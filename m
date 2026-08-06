Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25730421F1B;
	Thu,  6 Aug 2026 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052058; cv=none; b=M9Ruqq/ScUBb4KYbtmKoCAWKEZfbzNrpJedAetuhBZaepYaaAW8rh65EfhVvmVuTj5YA90U3LND+oQvdEU4xBzgt2LOE3C/u/qB01pngq258LsnB9eJvxfcqqytVW8zK7Z7R6qYaTZJ9J5D6N+kLauvtsPDxuuDZCSYx6nXyLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052058; c=relaxed/simple;
	bh=TV/OJAGo0l/qYS7Lh2LnxQeChJEJxruUMkll5V4QZAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKYirJuH8HYKbj7UmMzxBK+VZpybbYQ+duL1G+yXiwx2bEEjz80dqzEciwae+Zyu3qXmwQ2NTV869AHFzTLbwnp/tMYvdFDhVcLtP42sMzr7DOLG6Knfrp9kmZ1rvZCY1VrQhDsCY0ckf1/YjVosbxoVr3nzPLVwtpvOUctULjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MVQYy8G0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MVQYy8G0"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6997E20B712B;
	Thu,  6 Aug 2026 14:33:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6997E20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786052032;
	bh=m/xxZiPPPnx3a/e9x1rtE138HUAcJY9rU0x0uP+0JAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVQYy8G0PgzYyxTmwDja8A4MV0ZB5PHD4209AASsOicNmT5KpvNr3Zj+J783lBz7I
	 bqxCHsBkAP3HBjNr1nY5e3UuJeCyx1QWTN3kQc5Ffevl6yjHymDdVp9sqo/Sj9X8aW
	 pj5z3Xguqeg+ktmn4RetdMA6vqZ+voE4ipH0ePiQ=
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
Subject: [PATCH v3 3/3] hv_netvsc: Allocate host-visible GPADL buffers using vmbus_alloc_buffer()
Date: Thu,  6 Aug 2026 14:33:26 -0700
Message-ID: <20260806213326.1425848-4-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260806213326.1425848-1-kameroncarr@linux.microsoft.com>
References: <20260806213326.1425848-1-kameroncarr@linux.microsoft.com>
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

Use vmbus_alloc_buffer() to allocate the send and receive buffers, which
will make them host-visible. Store the list of memory chunks in the
netvsc_device struct so they can be individually freed later. Use
vmbus_establish_gpadl_caller_decrypted() so there is no attempt to decrypt
the virtual address.

Appropriately free the buffers with vmbus_free_buffer(). Because vunmap()
and set_memory_encrypted() must run in process context, replace the
rcu_head/call_rcu() pair used to defer free_netvsc_device() with
rcu_work/queue_rcu_work(). This also fixes a small race condition where the
buffers may be accessed while being re-encrypted by moving the
re-encryption after the RCU grace period.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h |   8 ++-
 drivers/net/hyperv/netvsc.c     | 103 ++++++++++++++++++++++----------
 drivers/net/hyperv/netvsc_drv.c |   6 ++
 3 files changed, 83 insertions(+), 34 deletions(-)

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
index 59e95341f9b1e..c59f2a44badf0 100644
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
@@ -351,7 +376,10 @@ static int netvsc_init_buf(struct hv_device *device,
 		buf_size = min_t(unsigned int, buf_size,
 				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
 
-	net_device->recv_buf = vzalloc(buf_size);
+	net_device->recv_buf =
+		vmbus_alloc_buffer(device->channel, buf_size,
+				   &net_device->recv_buf_chunks,
+				   &net_device->recv_buf_chunk_cnt);
 	if (!net_device->recv_buf) {
 		netdev_err(ndev,
 			   "unable to allocate receive buffer of size %u\n",
@@ -367,9 +395,10 @@ static int netvsc_init_buf(struct hv_device *device,
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
@@ -457,7 +486,10 @@ static int netvsc_init_buf(struct hv_device *device,
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
@@ -470,9 +502,10 @@ static int netvsc_init_buf(struct hv_device *device,
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
@@ -1863,7 +1896,11 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
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

