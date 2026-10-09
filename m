Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D83E314F;
	Fri,  9 Oct 2026 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522378; cv=none; b=Mgh/j1xG4yKWBTkr6YQiK0qnOWwCltQt+kYvLQZTQ6umrDXRg8MmoO0X0qa2UpZARjPno5jeezx6JeyWEgpOwfwGQDPXB3iiNuQbOPHA8b1RhdVQXF7yLdvNT08hAu+qotoSJI//HC8S+MRAeFMCX/t9fU6ZRpHKP6oNgmo6644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522378; c=relaxed/simple;
	bh=KWb85CxlJjeFDdFVV5G8COprvY8Jt6mVw4vkokgQmtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PruVegwQ8+pLYxTpT0/d/H0iPZekcqz8aBa9T7lioiv+ikQyvd5kHVwjzXCAhNZhqna68FQnh7y5fK96ecpQc2oN9DJAVdXZ6eCD4c3Yzy9nlxq5VjuURk+6Q/ld5z/NfszDX0+VMLlp/6fdJxS7K+LdeT/iPCzpGz7t5KSkoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YKNZOX4r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YKNZOX4r"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4CD6A20B716C;
	Thu,  8 Oct 2026 22:06:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CD6A20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791522371;
	bh=46J7xHctzxvUDHJeWv2iqHs99XRxsKeyDrGhFR2/gNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKNZOX4rh/xDyCfKDojwRTiXVK1HDX7sn8bLKSkd5+3Ysqt6k7cvlNtbw8Pbx3ZCr
	 Q2t25oD6a918+aZcDnr4JKhLQoTYxWKPiP+1sgy3GB9r/iVjL4R6pMbSvXsqyrUrbo
	 63t+se/h9Z8ibPpw9gvtQ01FewwHEx7SKpsc+WnI=
From: Naman Jain <namjain@linux.microsoft.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] nvme-pci: defer completions when rescheduling is needed
Date: Fri,  9 Oct 2026 05:05:56 +0000
Message-ID: <20261009050556.2817978-4-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009050556.2817978-1-namjain@linux.microsoft.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under sustained I/O, a CPU can finish one NVMe interrupt and immediately
enter another. This can keep the scheduler from running even when each
interrupt completes only a small amount of work.

For dedicated MSI-X I/O queues, check need_resched() before draining the
completion queue. If the scheduler needs the CPU, mask the vector and move
completion processing to irq_poll. The poller processes bounded batches
and returns the queue to interrupt mode after it catches up.

Stop and join irq_poll before deleting I/O queues or making the controller
inaccessible during suspend or PCI error recovery. Resume it only after
the controller is operational again. This prevents deferred completion
processing from using deleted queue state or inaccessible registers.

Admin queues, shared and legacy interrupts, explicit polling queues, and
threaded interrupts continue to use their existing paths.

Assisted-by: LLM
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/nvme/host/pci.c | 283 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 276 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bd4a6461b620f..dc1865d59686c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq_poll.h>
 #include <linux/kstrtox.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
@@ -99,6 +100,8 @@ MODULE_PARM_DESC(sgl_threshold,
 
 #define NVME_PCI_MIN_QUEUE_SIZE 2
 #define NVME_PCI_MAX_QUEUE_SIZE 4095
+#define NVME_IRQ_POLL_BUDGET	256
+
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
@@ -283,6 +286,8 @@ struct nvme_queue;
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
+static void nvme_pause_io_irq_poll(struct nvme_dev *dev);
+static void nvme_resume_io_irq_poll(struct nvme_dev *dev);
 
 struct nvme_descriptor_pools {
 	struct dma_pool *large;
@@ -369,6 +374,10 @@ struct nvme_queue {
 	spinlock_t sq_lock;
 	void *sq_cmds
 		__guarded_by(&sq_lock);
+	struct irq_poll iopoll;
+	int irq;
+	/* Serializes irq_poll pause, resume, and permanent teardown. */
+	struct mutex irq_poll_lock;
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	struct nvme_completion *cqes;
@@ -390,6 +399,29 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+/*
+ * IRQ-poll state:
+ *
+ * NVMEQ_IRQ_POLL:
+ *	irq_poll owns completion processing for this queue.
+ * NVMEQ_IRQ_POLL_INIT:
+ *	The queue has an initialized irq_poll and dedicated MSI-X.
+ * NVMEQ_IRQ_POLL_HANDOFF:
+ *	Allow one empty interrupt after the vector is unmasked.
+ * NVMEQ_IRQ_POLL_PAUSED:
+ *	Block IRQ handling and new irq_poll admission.
+ * NVMEQ_IRQ_POLL_MASKED:
+ *	This state machine owns one disable_irq_nosync().
+ *
+ * A temporary pause keeps NVMEQ_IRQ_POLL_MASKED set for resume. Permanent
+ * teardown clears NVMEQ_IRQ_POLL_INIT before joining irq_poll and keeps
+ * NVMEQ_IRQ_POLL_PAUSED set through IRQ removal.
+ */
+#define NVMEQ_IRQ_POLL		4
+#define NVMEQ_IRQ_POLL_INIT	5
+#define NVMEQ_IRQ_POLL_HANDOFF	6
+#define NVMEQ_IRQ_POLL_PAUSED	7
+#define NVMEQ_IRQ_POLL_MASKED	8
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
@@ -1638,11 +1670,104 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 	return found;
 }
 
+static int nvme_poll_cq_bounded(struct nvme_queue *nvmeq,
+				struct io_comp_batch *iob, int budget)
+{
+	int found = 0;
+
+	while (found < budget && nvme_cqe_pending(nvmeq)) {
+		dma_rmb();
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
+		nvme_update_cq_head(nvmeq);
+		found++;
+	}
+
+	return found;
+}
+
+/*
+ * A hardirq that observes need_resched() masks the vector and hands the
+ * queue to irq_poll. A full-budget pass remains scheduled. A short pass
+ * completes polling and returns the queue to interrupt mode.
+ */
+static int nvme_irq_poll(struct irq_poll *iop, int budget)
+{
+	struct nvme_queue *nvmeq =
+		container_of(iop, struct nvme_queue, iopoll);
+	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
+	DEFINE_IO_COMP_BATCH(iob);
+	int found;
+
+	spin_lock(&nvmeq->cq_poll_lock);
+	if (unlikely(test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) ||
+		     READ_ONCE(pdev->error_state) != pci_channel_io_normal)) {
+		irq_poll_complete(iop);
+		spin_unlock(&nvmeq->cq_poll_lock);
+		return 0;
+	}
+	found = nvme_poll_cq_bounded(nvmeq, &iob, budget);
+	/* AER may freeze the channel while this callback is draining. */
+	if (found && READ_ONCE(pdev->error_state) == pci_channel_io_normal)
+		nvme_ring_cq_doorbell(nvmeq);
+	spin_unlock(&nvmeq->cq_poll_lock);
+
+	if (!rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+
+	if (found < budget) {
+		spin_lock(&nvmeq->cq_poll_lock);
+		if (unlikely(test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) ||
+			     READ_ONCE(pdev->error_state) !=
+					pci_channel_io_normal)) {
+			irq_poll_complete(iop);
+			spin_unlock(&nvmeq->cq_poll_lock);
+			return found;
+		}
+		irq_poll_complete(iop);
+		/*
+		 * An interrupt may have been latched while the vector was
+		 * masked. Allow one empty interrupt after handing the queue
+		 * back without claiming that one is known to be pending.
+		 */
+		set_bit(NVMEQ_IRQ_POLL_HANDOFF, &nvmeq->flags);
+		clear_bit_unlock(NVMEQ_IRQ_POLL, &nvmeq->flags);
+		if (test_and_clear_bit(NVMEQ_IRQ_POLL_MASKED,
+				       &nvmeq->flags))
+			enable_irq(nvmeq->irq);
+		spin_unlock(&nvmeq->cq_poll_lock);
+	}
+
+	return found;
+}
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
 	DEFINE_IO_COMP_BATCH(iob);
 
+	if (unlikely(test_and_clear_bit(NVMEQ_IRQ_POLL_HANDOFF,
+					&nvmeq->flags))) {
+		if (!nvme_cqe_pending(nvmeq))
+			return IRQ_HANDLED;
+	}
+	if (unlikely(test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
+		     (!test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) ||
+		      test_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags) ||
+		      READ_ONCE(to_pci_dev(nvmeq->dev->dev)->error_state) !=
+				pci_channel_io_normal)))
+		return IRQ_HANDLED;
+
+	if (unlikely(in_hardirq() &&
+		     test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) &&
+		     !test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
+		     need_resched() && nvme_cqe_pending(nvmeq) &&
+		     !test_and_set_bit_lock(NVMEQ_IRQ_POLL, &nvmeq->flags))) {
+		set_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
+		disable_irq_nosync(irq);
+		irq_poll_sched(&nvmeq->iopoll);
+		return IRQ_HANDLED;
+	}
+
 	if (nvme_poll_cq(nvmeq, &iob)) {
 		if (!rq_list_empty(&iob.req_list))
 			nvme_pci_complete_batch(&iob);
@@ -1713,6 +1838,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	bool paused = false;
 	int ret = 0;
 
 	/*
@@ -1732,6 +1858,8 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
 		goto unlock;
 	}
 
+	nvme_pause_io_irq_poll(dev);
+	paused = true;
 	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
@@ -1744,6 +1872,8 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
 	 */
 	readl(dev->bar + NVME_REG_CSTS);
 unlock:
+	if (paused && nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
+		nvme_resume_io_irq_poll(dev);
 	mutex_unlock(&dev->shutdown_lock);
 	return ret;
 }
@@ -2050,6 +2180,98 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 	}
 }
 
+static void __nvme_pause_irq_poll(struct nvme_queue *nvmeq)
+	__must_hold(&nvmeq->irq_poll_lock)
+{
+	if (test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags))
+		return;
+
+	set_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags);
+	synchronize_irq(nvmeq->irq);
+	irq_poll_disable(&nvmeq->iopoll);
+	spin_lock_bh(&nvmeq->cq_poll_lock);
+	clear_bit(NVMEQ_IRQ_POLL, &nvmeq->flags);
+	spin_unlock_bh(&nvmeq->cq_poll_lock);
+
+	if (!test_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags) &&
+	    READ_ONCE(to_pci_dev(nvmeq->dev->dev)->error_state) ==
+			pci_channel_io_normal) {
+		/*
+		 * A PAUSED-but-unmasked handler drains normally until
+		 * disable_irq() has joined it.
+		 */
+		disable_irq(nvmeq->irq);
+		set_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
+	}
+	/* Resume or permanent teardown balances any mask we still own. */
+}
+
+static void nvme_pause_irq_poll(struct nvme_queue *nvmeq)
+{
+	mutex_lock(&nvmeq->irq_poll_lock);
+	if (test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags))
+		__nvme_pause_irq_poll(nvmeq);
+	mutex_unlock(&nvmeq->irq_poll_lock);
+}
+
+static void nvme_resume_irq_poll(struct nvme_queue *nvmeq)
+{
+	bool masked;
+
+	mutex_lock(&nvmeq->irq_poll_lock);
+	if (!test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) ||
+	    !test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) ||
+	    READ_ONCE(to_pci_dev(nvmeq->dev->dev)->error_state) !=
+			pci_channel_io_normal)
+		goto out_unlock;
+
+	/* Consume saved mask ownership before reopening hardirq admission. */
+	masked = test_and_clear_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
+	if (masked)
+		set_bit(NVMEQ_IRQ_POLL_HANDOFF, &nvmeq->flags);
+	irq_poll_enable(&nvmeq->iopoll);
+	clear_bit_unlock(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags);
+	if (masked)
+		enable_irq(nvmeq->irq);
+out_unlock:
+	mutex_unlock(&nvmeq->irq_poll_lock);
+}
+
+static void nvme_stop_irq_poll(struct nvme_queue *nvmeq)
+{
+	mutex_lock(&nvmeq->irq_poll_lock);
+	if (!test_and_clear_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags))
+		goto out_unlock;
+
+	__nvme_pause_irq_poll(nvmeq);
+	if (READ_ONCE(to_pci_dev(nvmeq->dev->dev)->error_state) ==
+			pci_channel_io_normal &&
+	    test_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags)) {
+		/* PAUSED makes any replay harmless; join it before IRQ removal. */
+		enable_irq(nvmeq->irq);
+		synchronize_irq(nvmeq->irq);
+		clear_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
+	}
+out_unlock:
+	mutex_unlock(&nvmeq->irq_poll_lock);
+}
+
+static void nvme_pause_io_irq_poll(struct nvme_dev *dev)
+{
+	int i;
+
+	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
+		nvme_pause_irq_poll(&dev->queues[i]);
+}
+
+static void nvme_resume_io_irq_poll(struct nvme_dev *dev)
+{
+	int i;
+
+	for (i = 1; i < dev->ctrl.queue_count; i++)
+		nvme_resume_irq_poll(&dev->queues[i]);
+}
+
 static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
@@ -2063,8 +2285,11 @@ static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		nvme_quiesce_admin_queue(&nvmeq->dev->ctrl);
-	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
+	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags)) {
+		nvme_stop_irq_poll(nvmeq);
 		pci_free_irq(to_pci_dev(dev->dev), nvmeq->cq_vector, nvmeq);
+		clear_bit(NVMEQ_IRQ_POLL_HANDOFF, &nvmeq->flags);
+	}
 }
 
 static void nvme_suspend_io_queues(struct nvme_dev *dev)
@@ -2087,7 +2312,8 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
 		spin_lock_bh(&dev->queues[i].cq_poll_lock);
-		nvme_poll_cq(&dev->queues[i], NULL);
+		/* Reap CQ memory without ringing a disabled controller. */
+		nvme_poll_cq_bounded(&dev->queues[i], NULL, INT_MAX);
 		spin_unlock_bh(&dev->queues[i].cq_poll_lock);
 	}
 }
@@ -2164,6 +2390,7 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->sq_lock);
 	spin_lock_init(&nvmeq->cq_poll_lock);
+	mutex_init(&nvmeq->irq_poll_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -2183,14 +2410,36 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
+	int ret;
+
+	/* The queue may be reused with a different IRQ layout after reset. */
+	clear_bit(NVMEQ_IRQ_POLL, &nvmeq->flags);
+	clear_bit(NVMEQ_IRQ_POLL_HANDOFF, &nvmeq->flags);
+	clear_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags);
+	clear_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
 
 	if (use_threaded_interrupts) {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
 				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	} else {
+	}
+	/*
+	 * Queue IDs map one-to-one to vectors here.  Restrict IRQ masking to
+	 * dedicated MSI-X I/O vectors; shared MSI and legacy IRQs stay on the
+	 * regular handler.
+	 */
+	if (!nvmeq->qid || !pdev->msix_enabled ||
+	    nvmeq->dev->num_vecs <= nvmeq->cq_vector ||
+	    nvmeq->cq_vector != nvmeq->qid)
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
 				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	}
+
+	nvmeq->irq = pci_irq_vector(pdev, nvmeq->cq_vector);
+	irq_poll_init(&nvmeq->iopoll, NVME_IRQ_POLL_BUDGET, nvme_irq_poll);
+	ret = pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
+			      NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+	if (!ret)
+		set_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags);
+	return ret;
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -3073,6 +3322,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	if (dev->online_queues - 1 < dev->max_qid) {
 		nr_io_queues = dev->online_queues - 1;
+		nvme_pause_io_irq_poll(dev);
 		nvme_delete_io_queues(dev);
 		result = nvme_setup_io_queues_trylock(dev);
 		if (result)
@@ -3330,6 +3580,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 
 	nvme_quiesce_io_queues(&dev->ctrl);
+	nvme_pause_io_irq_poll(dev);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_delete_io_queues(dev);
@@ -3948,9 +4199,14 @@ static int nvme_resume(struct device *dev)
 	if (ctrl->hmpre && nvme_setup_host_mem(ndev))
 		goto reset;
 
+	mutex_lock(&ndev->shutdown_lock);
+	nvme_resume_io_irq_poll(ndev);
+	mutex_unlock(&ndev->shutdown_lock);
 	return 0;
 reset:
-	return nvme_try_sched_reset(ctrl);
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_RESETTING)
+		return nvme_try_sched_reset(ctrl);
+	return nvme_reset_ctrl(ctrl);
 }
 
 static int nvme_suspend(struct device *dev)
@@ -3958,6 +4214,7 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
+	bool irq_poll_paused = false;
 	int ret = -EBUSY;
 
 	ndev->last_ps = U32_MAX;
@@ -3985,8 +4242,14 @@ static int nvme_suspend(struct device *dev)
 	nvme_wait_freeze(ctrl);
 	nvme_sync_queues(ctrl);
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
+	mutex_lock(&ndev->shutdown_lock);
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+		mutex_unlock(&ndev->shutdown_lock);
 		goto unfreeze;
+	}
+	nvme_pause_io_irq_poll(ndev);
+	irq_poll_paused = true;
+	mutex_unlock(&ndev->shutdown_lock);
 
 	/*
 	 * Host memory access may not be successful in a system suspend state,
@@ -4022,10 +4285,16 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be rediscovered then.
 		 */
-		ret = nvme_disable_prepare_reset(ndev, true);
 		ctrl->npss = 0;
+		ret = nvme_disable_prepare_reset(ndev, true);
+		goto unfreeze;
 	}
 unfreeze:
+	if (ret && irq_poll_paused) {
+		mutex_lock(&ndev->shutdown_lock);
+		nvme_resume_io_irq_poll(ndev);
+		mutex_unlock(&ndev->shutdown_lock);
+	}
 	nvme_unfreeze(ctrl);
 	return ret;
 }
