Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3B478E23;
	Thu, 30 Jul 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454490; cv=none; b=qXT0gZrUPYnK/pDN4VdvT4F130gvXilZ6U7Jul+eXQVUbj6bg+nqkQvMxjhnVEufPERoSOdMfErd1PaMnC3tNep8PWHITXbg/dYz4B9/s4rIEcjGeQ48hVrBUME8MQby9/cXvV9hVzWCJQu7B6BGZPGgzKN6nBqSlJdQ3kM6LPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454490; c=relaxed/simple;
	bh=27rWbP9e2j7bG28Hao/Q+zCOeWKVnGEFACUQsZJzzE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taL576ITOV1zjYw+0OSojh45lkB3M+7d5d9ToKKygQ014dfVH/pVYL57RLm0xlzOKb8HjKcEf4s6aQQaBoTmpb6nDg4jXu+7j8SUa/aUrCcbbln6K7UNpzLxDayTXK/y3FmxePggk7rXZc1fHVR/ALDoVXRSx+B4Xf/Mw+WouvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b4097XTJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b4097XTJ"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B9A2420B7169;
	Thu, 30 Jul 2026 16:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9A2420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785454463;
	bh=eqLIVxYOPXrtR5WMlLL9i6w1jMcZ5UYJmMe6dqKGIPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4097XTJeU8rw907jpZsHjoHwl9eAUuMCafIsta1sxR32qTK4z9k1RtZWj4WQyF2d
	 LJ+SdQTD4rHWVfaunZksHh7fE7YEFkFDXve7XFE5oV2TyHiMWQ9wsf1T078EoSEs7F
	 XjUgGY2wtS46hZtx+kld83Rn1EOVqk4aHmZ28Q5U=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: decui@microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	longli@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/2] hv_netvsc: Allocate host-visible GPADL buffers as decrypted contiguous chunks
Date: Thu, 30 Jul 2026 16:33:59 -0700
Message-ID: <20260730233359.3850612-3-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
References: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CoCo VMs without confidential VMBus, the netvsc send and receive buffers
must be made host-visible by decrypting them. These buffers are vmalloc'ed,
but set_memory_decrypted()/encrypted() do not work on vmalloc'ed memory.
This use case is (so far) unique to netvsc, so solve it locally rather than
changing the set_memory() or allocation APIs.

Add vmbus_alloc_buffer()/vmbus_free_buffer() to the VMBus core. When the
guest's isolation model requires it, allocate the buffer as a list of
physically-contiguous chunks via alloc_pages_node(), starting at
MAX_PAGE_ORDER and falling back to smaller orders so the allocation still
succeeds under memory fragmentation. Each chunk is decrypted in place via
set_memory_decrypted() on its direct-map address, and the chunks are then
stitched into a single virtually-contiguous range with vmap(). Buffers that
do not need decryption keep using vzalloc().

This approach minimizes scattering of decrypted 4 KiB pages through the
kernel direct map and the resulting shattering of large page mappings.

Use vmbus_establish_gpadl_caller_decrypted() so there is no attempt
to decrypt the virtual address. At teardown, vunmap() the range and
re-encrypt and free each chunk individually; any chunk that fails
re-encryption is leaked to prevent accidentally freeing decrypted memory.

Because vunmap() and set_memory_encrypted() must run in process context,
replace the rcu_head/call_rcu() pair used to defer free_netvsc_device()
with rcu_work/queue_rcu_work(). This also fixes a small race condition
where the buffers may be accessed while being re-encrypted by moving the
re-encryption after the RCU grace period.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/hv/channel.c            | 158 ++++++++++++++++++++++++++++++++
 drivers/net/hyperv/hyperv_net.h |   8 +-
 drivers/net/hyperv/netvsc.c     | 104 ++++++++++++++-------
 drivers/net/hyperv/netvsc_drv.c |   6 ++
 include/linux/hyperv.h          |   7 ++
 5 files changed, 249 insertions(+), 34 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 4782f5070bba9..9fe7b1163b408 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -13,11 +13,13 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/hyperv.h>
 #include <linux/uio.h>
 #include <linux/interrupt.h>
 #include <linux/set_memory.h>
+#include <linux/vmalloc.h>
 #include <linux/export.h>
 #include <asm/page.h>
 #include <asm/mshyperv.h>
@@ -608,6 +610,162 @@ int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
 }
 EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
 
+/*
+ * vmbus_free_buffer - release a buffer allocated by vmbus_alloc_buffer().
+ *
+ * @addr: buffer address, or NULL if none was allocated (e.g. cleanup from a
+ *        failed allocation)
+ * @chunks: chunks array from vmbus_alloc_buffer(), or NULL
+ * @chunk_cnt: number of entries in @chunks
+ *
+ * When @chunks is NULL the buffer is a plain vzalloc() allocation.
+ *
+ * Otherwise tear down the vmap, and for each chunk re-encrypt and free
+ * the underlying pages. Any chunk that cannot be re-encrypted is leaked.
+ */
+void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt)
+{
+	u32 i;
+
+	if (!chunks) {
+		vfree(addr);
+		return;
+	}
+
+	vunmap(addr);
+
+	for (i = 0; i < chunk_cnt; i++) {
+		unsigned long vaddr =
+			(unsigned long)page_address(chunks[i]);
+		unsigned int order = folio_order(page_folio(chunks[i]));
+
+		if (set_memory_encrypted(vaddr, 1U << order))
+			continue;
+		__free_pages(chunks[i], order);
+	}
+
+	kvfree(chunks);
+}
+EXPORT_SYMBOL_GPL(vmbus_free_buffer);
+
+/*
+ * vmbus_alloc_buffer - allocate a virtually-contiguous buffer suitable for
+ * a GPADL, making it host-visible when required by the guest's isolation model.
+ *
+ * @channel: the channel the buffer will be attached to
+ * @size: requested buffer size in bytes (will be rounded up to PAGE_SIZE)
+ * @chunks_out: on success, set to the array of underlying chunks, or NULL when
+ *              the buffer was allocated with vzalloc()
+ * @chunk_cnt_out: on success, set to the number of chunks
+ *
+ * Buffers not requiring decryption are allocated with vzalloc().
+ *
+ * Buffers requiring decryption are allocated as a series of
+ * physically-contiguous chunks, starting at MAX_PAGE_ORDER and falling back to
+ * smaller orders on allocation failure. Each chunk is transitioned to
+ * host-visible via set_memory_decrypted() on its direct-map address, then all
+ * chunks are combined into a virtually-contiguous range via vmap().
+ *
+ * Return: the buffer's virtual address, or NULL on failure.
+ */
+void *vmbus_alloc_buffer(struct vmbus_channel *channel,
+			 u32 size,
+			 struct page ***chunks_out,
+			 u32 *chunk_cnt_out)
+{
+	u32 nr_pages = PFN_UP(size);
+	struct page **chunks = NULL;
+	struct page **pages = NULL;
+	unsigned int order;
+	u32 chunk_cnt = 0;
+	u32 page_idx = 0;
+	u32 remaining = nr_pages;
+	void *addr;
+	u32 i;
+	int ret;
+
+	*chunks_out = NULL;
+	*chunk_cnt_out = 0;
+
+	if (!nr_pages)
+		return NULL;
+
+	/* If the buffer does not need to be decrypted, just use vzalloc() */
+	if (!hv_is_isolation_supported() || channel->co_external_memory)
+		return vzalloc((unsigned long)nr_pages << PAGE_SHIFT);
+
+	/* Worst case: every chunk is a single page. */
+	chunks = kvmalloc_array(nr_pages, sizeof(*chunks),
+				GFP_KERNEL | __GFP_ZERO);
+	if (!chunks)
+		goto err;
+
+	pages = kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		goto err;
+
+	/*
+	 * @order monotonically decreases across iterations
+	 *
+	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing, but try
+	 * harder at order 0 since that is the final fallback.
+	 */
+	order = min(MAX_PAGE_ORDER, ilog2(nr_pages));
+	while (remaining) {
+		struct page *page;
+		gfp_t gfp;
+
+		order = min(order, ilog2(remaining));
+
+		for (;;) {
+			gfp = GFP_KERNEL | __GFP_ZERO;
+			if (order)
+				gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
+			page = alloc_pages_node(cpu_to_node(channel->target_cpu),
+						gfp, order);
+			if (page)
+				break;
+			if (!order)
+				goto err;
+			order--;
+		}
+
+		ret = set_memory_decrypted((unsigned long)page_address(page),
+					   1U << order);
+		if (ret) {
+			/*
+			 * set_memory_decrypted() failed; the page state is
+			 * unknown so it must be leaked rather than freed.
+			 */
+			goto err;
+		}
+
+		chunks[chunk_cnt++] = page;
+
+		for (i = 0; i < (1U << order); i++)
+			pages[page_idx++] = page + i;
+
+		remaining -= 1U << order;
+	}
+
+	addr = vmap(pages, nr_pages, VM_MAP, pgprot_decrypted(PAGE_KERNEL));
+	if (!addr)
+		goto err;
+
+	memset(addr, 0, (unsigned long)nr_pages << PAGE_SHIFT);
+
+	kvfree(pages);
+	*chunks_out = chunks;
+	*chunk_cnt_out = chunk_cnt;
+	return addr;
+
+err:
+	kvfree(pages);
+	vmbus_free_buffer(NULL, chunks, chunk_cnt);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vmbus_alloc_buffer);
+
 /**
  * request_arr_init - Allocates memory for the requestor array. Each slot
  * keeps track of the next available slot in the array. Initially, each
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 7397c693f984a..4841367fdab2f 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -220,6 +220,8 @@ struct net_device_context;
 
 extern u32 netvsc_ring_bytes;
 
+int netvsc_workqueue_init(void);
+void netvsc_workqueue_destroy(void);
 struct netvsc_device *netvsc_device_add(struct hv_device *device,
 					const struct netvsc_device_info *info);
 int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_idx);
@@ -1158,6 +1160,8 @@ struct netvsc_device {
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
 	u32 recv_buf_size; /* allocated bytes */
+	struct page **recv_buf_chunks;
+	u32 recv_buf_chunk_cnt;
 	struct vmbus_gpadl recv_buf_gpadl_handle;
 	u32 recv_section_cnt;
 	u32 recv_section_size;
@@ -1166,6 +1170,8 @@ struct netvsc_device {
 	/* Send buffer allocated by us */
 	void *send_buf;
 	u32 send_buf_size;
+	struct page **send_buf_chunks;
+	u32 send_buf_chunk_cnt;
 	struct vmbus_gpadl send_buf_gpadl_handle;
 	u32 send_section_cnt;
 	u32 send_section_size;
@@ -1193,7 +1199,7 @@ struct netvsc_device {
 
 	struct netvsc_channel chan_table[VRSS_CHANNEL_MAX];
 
-	struct rcu_head rcu;
+	struct rcu_work rwork;
 };
 
 /* NdisInitialize message */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1e..1192929d93a86 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -28,6 +28,8 @@
 #include "hyperv_net.h"
 #include "netvsc_trace.h"
 
+static struct workqueue_struct *netvsc_wq;
+
 /*
  * Switch the data path from the synthetic interface to the VF
  * interface.
@@ -125,6 +127,47 @@ static void netvsc_subchan_work(struct work_struct *w)
 	rtnl_unlock();
 }
 
+static void __free_netvsc_device(struct netvsc_device *nvdev)
+{
+	int i;
+
+	kfree(nvdev->extension);
+
+	vmbus_free_buffer(nvdev->recv_buf, nvdev->recv_buf_chunks,
+			  nvdev->recv_buf_chunk_cnt);
+	vmbus_free_buffer(nvdev->send_buf, nvdev->send_buf_chunks,
+			  nvdev->send_buf_chunk_cnt);
+	bitmap_free(nvdev->send_section_map);
+
+	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
+		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
+		kfree(nvdev->chan_table[i].recv_buf);
+		vfree(nvdev->chan_table[i].mrc.slots);
+	}
+
+	kfree(nvdev);
+}
+
+static void free_netvsc_device(struct work_struct *w)
+{
+	struct rcu_work *rwork = to_rcu_work(w);
+
+	__free_netvsc_device(container_of(rwork, struct netvsc_device, rwork));
+}
+
+int netvsc_workqueue_init(void)
+{
+	netvsc_wq = alloc_workqueue("hv_netvsc", WQ_UNBOUND, 0);
+
+	return netvsc_wq ? 0 : -ENOMEM;
+}
+
+void netvsc_workqueue_destroy(void)
+{
+	rcu_barrier();
+	destroy_workqueue(netvsc_wq);
+}
+
 static struct netvsc_device *alloc_net_device(void)
 {
 	struct netvsc_device *net_device;
@@ -143,36 +186,18 @@ static struct netvsc_device *alloc_net_device(void)
 	init_completion(&net_device->channel_init_wait);
 	init_waitqueue_head(&net_device->subchan_open);
 	INIT_WORK(&net_device->subchan_work, netvsc_subchan_work);
+	INIT_RCU_WORK(&net_device->rwork, free_netvsc_device);
 
 	return net_device;
 }
 
-static void free_netvsc_device(struct rcu_head *head)
-{
-	struct netvsc_device *nvdev
-		= container_of(head, struct netvsc_device, rcu);
-	int i;
-
-	kfree(nvdev->extension);
-
-	if (!nvdev->recv_buf_gpadl_handle.decrypted)
-		vfree(nvdev->recv_buf);
-	if (!nvdev->send_buf_gpadl_handle.decrypted)
-		vfree(nvdev->send_buf);
-	bitmap_free(nvdev->send_section_map);
-
-	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
-		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
-		kfree(nvdev->chan_table[i].recv_buf);
-		vfree(nvdev->chan_table[i].mrc.slots);
-	}
-
-	kfree(nvdev);
-}
-
 static void free_netvsc_device_rcu(struct netvsc_device *nvdev)
 {
-	call_rcu(&nvdev->rcu, free_netvsc_device);
+	/*
+	 * Defer the actual free to process context: vunmap() and
+	 * set_memory_encrypted() cannot run from RCU softirq context.
+	 */
+	queue_rcu_work(netvsc_wq, &nvdev->rwork);
 }
 
 static void netvsc_revoke_recv_buf(struct hv_device *device,
@@ -351,7 +376,11 @@ static int netvsc_init_buf(struct hv_device *device,
 		buf_size = min_t(unsigned int, buf_size,
 				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
 
-	net_device->recv_buf = vzalloc(buf_size);
+	net_device->recv_buf =
+		vmbus_alloc_buffer(device->channel, buf_size,
+				   &net_device->recv_buf_chunks,
+				   &net_device->recv_buf_chunk_cnt);
+
 	if (!net_device->recv_buf) {
 		netdev_err(ndev,
 			   "unable to allocate receive buffer of size %u\n",
@@ -367,9 +396,10 @@ static int netvsc_init_buf(struct hv_device *device,
 	 * channel.  Note: This call uses the vmbus connection rather
 	 * than the channel to establish the gpadl handle.
 	 */
-	ret = vmbus_establish_gpadl(device->channel, net_device->recv_buf,
-				    buf_size,
-				    &net_device->recv_buf_gpadl_handle);
+	ret = vmbus_establish_gpadl_caller_decrypted(device->channel,
+						     net_device->recv_buf,
+						     buf_size,
+						     &net_device->recv_buf_gpadl_handle);
 	if (ret != 0) {
 		netdev_err(ndev,
 			"unable to establish receive buffer's gpadl\n");
@@ -457,7 +487,10 @@ static int netvsc_init_buf(struct hv_device *device,
 	buf_size = device_info->send_sections * device_info->send_section_size;
 	buf_size = round_up(buf_size, PAGE_SIZE);
 
-	net_device->send_buf = vzalloc(buf_size);
+	net_device->send_buf =
+		vmbus_alloc_buffer(device->channel, buf_size,
+				   &net_device->send_buf_chunks,
+				   &net_device->send_buf_chunk_cnt);
 	if (!net_device->send_buf) {
 		netdev_err(ndev, "unable to allocate send buffer of size %u\n",
 			   buf_size);
@@ -470,9 +503,10 @@ static int netvsc_init_buf(struct hv_device *device,
 	 * channel.  Note: This call uses the vmbus connection rather
 	 * than the channel to establish the gpadl handle.
 	 */
-	ret = vmbus_establish_gpadl(device->channel, net_device->send_buf,
-				    buf_size,
-				    &net_device->send_buf_gpadl_handle);
+	ret = vmbus_establish_gpadl_caller_decrypted(device->channel,
+						     net_device->send_buf,
+						     buf_size,
+						     &net_device->send_buf_gpadl_handle);
 	if (ret != 0) {
 		netdev_err(ndev,
 			   "unable to establish send buffer's gpadl\n");
@@ -1863,7 +1897,11 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 	netif_napi_del(&net_device->chan_table[0].napi);
 
 cleanup2:
-	free_netvsc_device(&net_device->rcu);
+	/*
+	 * net_device was never published, so we don't need to wait for an
+	 * RCU grace period -- call the free routine synchronously.
+	 */
+	__free_netvsc_device(net_device);
 
 	return ERR_PTR(ret);
 }
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ee5ab5ceb2be2..1d43c73fd73f1 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2867,12 +2867,17 @@ static void __exit netvsc_drv_exit(void)
 {
 	unregister_netdevice_notifier(&netvsc_netdev_notifier);
 	vmbus_driver_unregister(&netvsc_drv);
+	netvsc_workqueue_destroy();
 }
 
 static int __init netvsc_drv_init(void)
 {
 	int ret;
 
+	ret = netvsc_workqueue_init();
+	if (ret)
+		return ret;
+
 	if (ring_size < RING_SIZE_MIN) {
 		ring_size = RING_SIZE_MIN;
 		pr_info("Increased ring_size to %u (min allowed)\n",
@@ -2890,6 +2895,7 @@ static int __init netvsc_drv_init(void)
 
 err_vmbus_reg:
 	unregister_netdevice_notifier(&netvsc_netdev_notifier);
+	netvsc_workqueue_destroy();
 	return ret;
 }
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 1146addbb42c4..f843ee0efa22f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1214,6 +1214,13 @@ extern int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
 				     struct vmbus_gpadl *gpadl);
 
+extern void *vmbus_alloc_buffer(struct vmbus_channel *channel,
+				u32 size,
+				struct page ***chunks_out,
+				u32 *chunk_cnt_out);
+
+extern void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt);
+
 void vmbus_reset_channel_cb(struct vmbus_channel *channel);
 
 extern int vmbus_recvpacket(struct vmbus_channel *channel,
-- 
2.45.4

