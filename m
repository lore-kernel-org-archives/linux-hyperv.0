Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE70646DFEF;
	Tue, 21 Jul 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663852; cv=none; b=blSacXqFCoGEtthvn4bZbpCorp7HEeZ5FuOqW58QY53VrkumL1o/D5Hl2cJSmd/Zb9/u/SB9baHo7qbRPppX5+kfRFCJSWY/xol/dR0iTJh1+kJn2eb8DlvFDHUSSuLb4B2dlmn15iHodpas6bj2YnihbnZO6duvryJfgwMGpbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663852; c=relaxed/simple;
	bh=bnKY/xBLgy31qQLAzLi94ZVnPKI/SHUDMmxx6b0BrwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTbn2I1WLso5iwqp4GcbHOKuOk6ttjfdKYl5NbUkKb7cTMHabR9iwzbAnoq7iOJ4QaOTdE5ATXgi3B2A5jmsF4A6XZdGnJ479mGOsKjjuemE+M1Q1QoHqG3qRZNcLALCZcoMRLByab5G10RBhKkgYOgg4743neIztxwQvfldWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=laf7dYhQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="laf7dYhQ"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA0C820B716A;
	Tue, 21 Jul 2026 12:57:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA0C820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784663837;
	bh=yEnkpfIi11KsaXT0ol5eDNBjbJyYlxGmsXi5ekvcUWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laf7dYhQjQpunYSl9T1f7CdXsPSzqqIhLD0TGKrOxAV0aofJ4se/cqc0WYijCOQa+
	 CZfkNvguGC5WIDxeqrc/uvrSWSaO0mfGk/l8YTqoeIZmiNtSwnGeqzJ60t5OohSsFo
	 VjPtURnPzNGk1IZLWliBQXkXBF1vF4LwM6Qy3qy8=
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
Subject: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc + decrypt + vmap
Date: Tue, 21 Jul 2026 12:56:33 -0700
Message-ID: <20260721195633.1438361-3-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate the buffer as a list of physically-contiguous chunks using
alloc_pages_node() starting at MAX_PAGE_ORDER and falling back to smaller
orders. Each chunk is transitioned to host-visible via
set_memory_decrypted() on its direct-map address, then all chunks are
stitched together via vmap() into a single virtually-contiguous address.

Use vmbus_establish_gpadl_caller_decrypted() so the vmbus layer doesn't
try to decrypt the virtual address. At teardown, vunmap() the range and
re-encrypt and free each chunk individually; any chunk that fails
re-encryption is leaked to prevent accidentally freeing decrypted memory.

Because vunmap() and set_memory_encrypted() must run in process context,
replace the rcu_head/call_rcu() pair used to defer free_netvsc_device()
with rcu_work/queue_rcu_work().

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h |  18 ++-
 drivers/net/hyperv/netvsc.c     | 271 ++++++++++++++++++++++++++++----
 drivers/net/hyperv/netvsc_drv.c |   6 +
 3 files changed, 261 insertions(+), 34 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 7397c693f984a..b0c4cb0f7a4ce 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -220,6 +220,8 @@ struct net_device_context;
 
 extern u32 netvsc_ring_bytes;
 
+int netvsc_workqueue_init(void);
+void netvsc_workqueue_destroy(void);
 struct netvsc_device *netvsc_device_add(struct hv_device *device,
 					const struct netvsc_device_info *info);
 int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_idx);
@@ -1147,6 +1149,16 @@ struct netvsc_channel {
 	struct netvsc_stats_rx rx_stats;
 };
 
+/* A physically-contiguous chunk of netvsc buffer.
+ *
+ * The chunk list is preserved so each chunk can be individually freed at
+ * teardown.
+ */
+struct netvsc_buf_chunk {
+	struct page *page;
+	unsigned int order;
+};
+
 /* Per netvsc device */
 struct netvsc_device {
 	u32 nvsp_version;
@@ -1158,6 +1170,8 @@ struct netvsc_device {
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
 	u32 recv_buf_size; /* allocated bytes */
+	struct netvsc_buf_chunk *recv_buf_chunks;
+	u32 recv_buf_chunk_cnt;
 	struct vmbus_gpadl recv_buf_gpadl_handle;
 	u32 recv_section_cnt;
 	u32 recv_section_size;
@@ -1166,6 +1180,8 @@ struct netvsc_device {
 	/* Send buffer allocated by us */
 	void *send_buf;
 	u32 send_buf_size;
+	struct netvsc_buf_chunk *send_buf_chunks;
+	u32 send_buf_chunk_cnt;
 	struct vmbus_gpadl send_buf_gpadl_handle;
 	u32 send_section_cnt;
 	u32 send_section_size;
@@ -1193,7 +1209,7 @@ struct netvsc_device {
 
 	struct netvsc_channel chan_table[VRSS_CHANNEL_MAX];
 
-	struct rcu_head rcu;
+	struct rcu_work rwork;
 };
 
 /* NdisInitialize message */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1e..2505d10e22010 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -14,6 +14,8 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/netdevice.h>
 #include <linux/if_ether.h>
@@ -28,6 +30,8 @@
 #include "hyperv_net.h"
 #include "netvsc_trace.h"
 
+static struct workqueue_struct *netvsc_wq;
+
 /*
  * Switch the data path from the synthetic interface to the VF
  * interface.
@@ -125,6 +129,194 @@ static void netvsc_subchan_work(struct work_struct *w)
 	rtnl_unlock();
 }
 
+/*
+ * netvsc_free_buf_pages - release a netvsc send/receive buffer.
+ *
+ * @addr: buffer address, or NULL if none was allocated (e.g. cleanup from a
+ *        failed allocation)
+ * @chunks: chunks array from netvsc_alloc_buf_pages(), or NULL
+ * @chunk_cnt: number of entries in @chunks
+ *
+ * When @chunks is NULL the buffer is a plain vzalloc() allocation.
+ *
+ * Otherwise tear down the vmap, and for each chunk re-encrypt and free
+ * the underlying pages. Any chunk that cannot be re-encrypted is leaked.
+ */
+static void netvsc_free_buf_pages(void *addr,
+				  struct netvsc_buf_chunk *chunks,
+				  u32 chunk_cnt)
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
+			(unsigned long)page_address(chunks[i].page);
+		unsigned int order = chunks[i].order;
+
+		if (set_memory_encrypted(vaddr, 1U << order))
+			continue;
+		__free_pages(chunks[i].page, order);
+	}
+
+	kvfree(chunks);
+}
+
+/*
+ * netvsc_alloc_buf_pages - allocate a virtually-contiguous, host-visible
+ * buffer for the netvsc send/receive area.
+ *
+ * @node: NUMA node hint (NUMA_NO_NODE for any node)
+ * @size: requested buffer size in bytes (rounded up to PAGE_SIZE)
+ * @chunks_out: on success, set to the array of underlying chunks
+ * @chunk_cnt_out: on success, set to the number of chunks
+ *
+ * Allocates the buffer as a series of physically-contiguous chunks,
+ * starting at MAX_PAGE_ORDER and falling back to smaller orders on
+ * allocation failure. Each chunk is transitioned to host-visible via
+ * set_memory_decrypted() on its direct-map address, then all chunks are
+ * combined into a virtually-contiguous range via vmap().
+ *
+ * Return: the vmap()ed virtual address, or NULL on failure.
+ */
+static void *netvsc_alloc_buf_pages(int node, u32 size,
+				    struct netvsc_buf_chunk **chunks_out,
+				    u32 *chunk_cnt_out)
+{
+	u32 nr_pages = PFN_UP(size);
+	struct netvsc_buf_chunk *chunks = NULL;
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
+	order = min_t(unsigned int, MAX_PAGE_ORDER, ilog2(nr_pages));
+	while (remaining) {
+		struct page *page;
+		gfp_t gfp;
+
+		order = min_t(unsigned int, order, ilog2(remaining));
+
+		for (;;) {
+			gfp = GFP_KERNEL | __GFP_ZERO;
+			if (order)
+				gfp |= __GFP_NORETRY | __GFP_NOWARN;
+			page = alloc_pages_node(node, gfp, order);
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
+		chunks[chunk_cnt].page = page;
+		chunks[chunk_cnt].order = order;
+		chunk_cnt++;
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
+	kvfree(pages);
+	*chunks_out = chunks;
+	*chunk_cnt_out = chunk_cnt;
+	return addr;
+
+err:
+	kvfree(pages);
+	netvsc_free_buf_pages(NULL, chunks, chunk_cnt);
+	return NULL;
+}
+
+static void __free_netvsc_device(struct netvsc_device *nvdev)
+{
+	int i;
+
+	kfree(nvdev->extension);
+
+	netvsc_free_buf_pages(nvdev->recv_buf, nvdev->recv_buf_chunks,
+			      nvdev->recv_buf_chunk_cnt);
+	netvsc_free_buf_pages(nvdev->send_buf, nvdev->send_buf_chunks,
+			      nvdev->send_buf_chunk_cnt);
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
@@ -143,36 +335,18 @@ static struct netvsc_device *alloc_net_device(void)
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
@@ -351,7 +525,20 @@ static int netvsc_init_buf(struct hv_device *device,
 		buf_size = min_t(unsigned int, buf_size,
 				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
 
-	net_device->recv_buf = vzalloc(buf_size);
+	if (device->channel->co_external_memory) {
+		/* Confidential VM Bus leaves buffer encrypted */
+		net_device->recv_buf_chunks = NULL;
+		net_device->recv_buf_chunk_cnt = 0;
+		net_device->recv_buf = vzalloc(buf_size);
+	} else {
+		/* Otherwise, allocate decrypted buffer */
+		net_device->recv_buf =
+			netvsc_alloc_buf_pages(cpu_to_node(device->channel->target_cpu),
+					       buf_size,
+					       &net_device->recv_buf_chunks,
+					       &net_device->recv_buf_chunk_cnt);
+	}
+
 	if (!net_device->recv_buf) {
 		netdev_err(ndev,
 			   "unable to allocate receive buffer of size %u\n",
@@ -367,9 +554,10 @@ static int netvsc_init_buf(struct hv_device *device,
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
@@ -457,7 +645,19 @@ static int netvsc_init_buf(struct hv_device *device,
 	buf_size = device_info->send_sections * device_info->send_section_size;
 	buf_size = round_up(buf_size, PAGE_SIZE);
 
-	net_device->send_buf = vzalloc(buf_size);
+	if (device->channel->co_external_memory) {
+		/* Confidential VM Bus leaves buffer encrypted */
+		net_device->send_buf_chunks = NULL;
+		net_device->send_buf_chunk_cnt = 0;
+		net_device->send_buf = vzalloc(buf_size);
+	} else {
+		/* Otherwise, allocate decrypted buffer */
+		net_device->send_buf =
+			netvsc_alloc_buf_pages(cpu_to_node(device->channel->target_cpu),
+					       buf_size,
+					       &net_device->send_buf_chunks,
+					       &net_device->send_buf_chunk_cnt);
+	}
 	if (!net_device->send_buf) {
 		netdev_err(ndev, "unable to allocate send buffer of size %u\n",
 			   buf_size);
@@ -470,9 +670,10 @@ static int netvsc_init_buf(struct hv_device *device,
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
@@ -1863,7 +2064,11 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
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
 
-- 
2.45.4

