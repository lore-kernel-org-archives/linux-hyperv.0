Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CBB3DC4B1;
	Fri,  9 Oct 2026 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522371; cv=none; b=aRha9OtBsZH3E0TUpal9sjN9zd8QKxYjjUHBBZWeGHYutBAC2USewooNpyfg4OP3zBlMVnhgHi+yqe0z082I7W8lX5nwVtmeFgDR39/Gz0OEwzIlphXpsfH5NRKNIxrks28mpDwjRNdeOYrIoTyW6X96edDI0iuCV4dimhV0tZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522371; c=relaxed/simple;
	bh=5xoZUjItqH6hoTTijoF5Y4qOu7Bm3FgIUfxBHooaQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwBKfBU5TM1onJcpQ9R/eGODxRlNRjTWZwjvZsUg/CPJECHJK1eDiqnFdjBRgKhJtvZrXVVmLY7jyuMWVLi+RlJt2a8MfbHO/jcvh2E5JCYYp5XmpwdoWez2Ul0cXdWqcE+OxfLZz52js/FG8Nt3rP9ZrBE6AyuVDUESxXq+q8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bMMiWL4Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bMMiWL4Z"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5205420B7167;
	Thu,  8 Oct 2026 22:06:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5205420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791522368;
	bh=WdC4dJY/4vazVcvf5m0/8SEiRw+z1O4P8w3T6xgJfP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMMiWL4Zq5oI8MeJURknwQaGOskkhOq8/PYImArYPOEnWpY9mZKEygOh3ktngbDy+
	 6bfvlYTaF3j1d0YJzxkhDNqoNIJsX+XxyYEoPvtDBe8SeIC7X2bliDk0zpi+/xcsvv
	 khK2rFtVIg2NBNNSzAAE8rdnpUqwBRXR947mDya8=
From: Naman Jain <namjain@linux.microsoft.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] nvme-pci: make completion queue polling softirq-safe
Date: Fri,  9 Oct 2026 05:05:55 +0000
Message-ID: <20261009050556.2817978-3-namjain@linux.microsoft.com>
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

A following patch processes interrupt-driven completion queues from
IRQ_POLL_SOFTIRQ. Ensure every task-context user disables bottom halves
while holding cq_poll_lock so the softirq cannot interrupt the local
owner.

This includes explicit blk-mq polling. Those queues do not use irq_poll,
but all cq_poll_lock instances share one lockdep class because they are
initialized at the same call site. Keep that class consistently
softirq-safe rather than reclassifying reused queue objects across reset.

Assisted-by: LLM
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/nvme/host/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dbcfc7ddb78aa..bd4a6461b620f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1673,9 +1673,9 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 
 	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
 	disable_irq(irq);
-	spin_lock(&nvmeq->cq_poll_lock);
+	spin_lock_bh(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_unlock_bh(&nvmeq->cq_poll_lock);
 	enable_irq(irq);
 }
 
@@ -1688,9 +1688,9 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	    !nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock(&nvmeq->cq_poll_lock);
+	spin_lock_bh(&nvmeq->cq_poll_lock);
 	found = nvme_poll_cq(nvmeq, iob);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_unlock_bh(&nvmeq->cq_poll_lock);
 
 	return found;
 }
@@ -2086,9 +2086,9 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 	int i;
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
-		spin_lock(&dev->queues[i].cq_poll_lock);
+		spin_lock_bh(&dev->queues[i].cq_poll_lock);
 		nvme_poll_cq(&dev->queues[i], NULL);
-		spin_unlock(&dev->queues[i].cq_poll_lock);
+		spin_unlock_bh(&dev->queues[i].cq_poll_lock);
 	}
 }
 
