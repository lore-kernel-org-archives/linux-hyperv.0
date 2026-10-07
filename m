Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9D4E2F1A
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400138; cv=none; b=Yq3hmxuNrGpTlBhi0VjBq9YMws0PudpmR/LjJ2f8nKXYoeBT8YANkvy5DDLDMosGQShKiBiEoWQ3bBrphAFWVBGvPF0knzz7MKH7I30GpiULj9aCTx4O1UXDxzMmA0RqXMG/nyhs0kuCYV8j3TlSbgQNFxpWfSgIWciwEiqV4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400138; c=relaxed/simple;
	bh=stnAR+cACbTh3+0n3e2GB8tkt80sQNeDUO2hXBjF/hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te5nCnR3sLk3HLqnubzLRWQ3fnkvhUNBIVw4hPsv6CZMWRPG1n+bXpXzpVRQzZ41zU4fZVNDJQIUhe6ePRJ8JJ5HpHnXOtqR1S1GQEeaOVgxcROzMc8KMVUCQWYvnXIKEcEyfNXD57nXoPyg78Bmd2+LC2TwbyEtN7+afF+dKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1labu8K; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1labu8K"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-754ac74c495so756658137.0
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400135; x=1792004935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpzlPNjySskapU5+8Jt0qnWxRwY4FzuGybS6JhSRPxw=;
        b=s1labu8Km5FG7R+/LT21H32mZKIvAK2/7KD0YGtSP/X6Y7n3Q2U1khciNrhZvZCy6u
         thuoaqxCz9M01MgYppxanh2AhbAFSUOUl4+JL9sIYLBSIyAkTJ7VXukymAmXHBFJdRhv
         d+dLVFs9qvVSZP3Wpz/OfP0mmg1FqumHGwPNvdVbB0qgC5kYBddZYdLmJfQcrDks0VsK
         uo1jNXlJKC5d6XpMbCLV/77lqMDrwKp4w2DywgFT8WlGNr3qV1/4/ex4XtOmCD0e1rVA
         Q6BaLNme+pkP2rBmIXjGyM+9DEIy60cDhPmtVBM6Vh496aEwA1x57FJnIH+2YxOtk5gI
         3Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400135; x=1792004935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpzlPNjySskapU5+8Jt0qnWxRwY4FzuGybS6JhSRPxw=;
        b=S6vad1/IvVtm4Mn3h7hkuViIOfxfxs7a+TFrkSZH7m7AU8brivmdp8iTvkYaV+cxAz
         CB8EuhlIQxPo2lp6uZJ3tS+yqMIuOZ2gurZ5WnqovNd8YUxSKqy2B8Ul2PPruG3hf3vQ
         D5NDtHBxO7+krpM+KiRwD6gr3CcS+RVkn2sAWd0ZHHmXKM0BEMQKLy+nBzTgSphRIx7z
         xmjpQFq7YLS11HyUnFPMuZDV8Bg+FLmRUgzP48TVpq9rbSJF5jRHWEmxnmWRDt2qptnM
         CwXKOeryDccJI0HPEozvNkEswZFEi04bYWvOB3KAf6HdtJbPeSI8rYVhNXopJRFNYLXP
         PoBw==
X-Forwarded-Encrypted: i=1; AKwUvByCeVMDo2ePpyVcbjTIokwGWLRXdfBuV02Z0RU7aFMcsBMXTtAuEKkyFO9BKazfbFlEDSMVwLFnUUlDy94=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTjNiH7VHW5kNs02yJQX5MyklYivnPabKaCI7Y2Rfw5dpgrbbY
	CY04HAIuxOWDMF+X6h3Ez4GwnYx+pHGsewl4ZWw6jmTfuTzf0IpNrrsU
X-Gm-Gg: AYBFou15JRNRe9JiTuXiNUqpZ/2emqs+guDeQXzowVUfskHSthyr8Z9a8fC9TjKEZJ6
	tfmgRZx1gjbwxlyPX2omiCkmu3Ij+rYv5obuiTfiL5PzfwUDs0OSHbPxsHmxXc9QTqD0TAMUd/Z
	AN9HXFEip8HI6i7M3jkhdUjsoSCohhLdn9um3064l/IZR6MH2rJZ3EHAmbUB46qIzy1kGe0M64+
	J2Iyl1PqIDyAzgqGlm90bVfxi9z83SyFLKEbp3luwQ4LnFnyvXt+o8+Gtp/687R7ONayYq65J87
	5D0q3JMWIlSL/pjAGKTWPsBl8xQGxNPgHTgKTXOJ2Dwgav89kXIgoWhYqj/zSCbbYWNHs4cv8rx
	8hPtbHmHLgt8zmbhauPjmOK0gHLSFsnBGnAvwjE3pSZB07+g1cvxLm7B0glhr27V+IrymOCc3Ew
	hZuw7yaptVK23jmSTHAWovuVsiSTBtoXCa1NntqvtW7pC8KmVIlEdmcQD59Dga9UjaFV3ZtpNpt
	jlKxuaIZbqEiiUXR5I=
X-Received: by 2002:a05:6102:915:b0:7c1:957b:1dd9 with SMTP id ada2fe7eead31-7ca38e095b9mr671267137.29.1791400135195;
        Wed, 07 Oct 2026 12:08:55 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:54 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 09/14] hv: use owned VMBus buffers in NetVSC and UIO
Date: Wed,  7 Oct 2026 16:07:47 -0300
Message-ID: <20261007190752.336426-10-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the remaining buffer consumers to the allocation, GPADL and release
entry points that carry one descriptor throughout their lifetime.
Preserve established exported signatures throughout the series. Ring
confidentiality comes from co_ring_buffer; external-buffer compatibility
uses co_external_memory, while UIO buffers explicitly require
host-visible backing.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c         |  4 +--
 drivers/net/hyperv/netvsc.c  | 52 +++++++++++-------------------------
 drivers/uio/uio_hv_generic.c | 32 +++++++---------------
 include/linux/hyperv.h       |  8 +++---
 4 files changed, 32 insertions(+), 64 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index aa33a0f08a7f..7eb9ea814ef4 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1035,11 +1035,10 @@ EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
  * @channel: a channel
  * @kbuffer: from kmalloc or vmalloc; must already be decrypted by the caller
  * @size: page-size multiple
- * @leak: set when a GPADL message may have reached the host but completion is
- *        uncertain; the caller must retain the backing pages
  * @gpadl: output gpadl
  *
  * The caller is responsible for re-encrypting the buffer before freeing it.
+ * Ownership of the backing pages stays with the caller's vmbus_buffer.
  */
 int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
 					  void *kbuffer, u32 size,
@@ -1282,6 +1281,7 @@ int vmbus_alloc_buffer_owned(struct vmbus_channel *channel, u32 size,
 	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(vmbus_alloc_buffer_owned);
+
 /*
  * vmbus_alloc_buffer - compatibility allocator for callers managing lifetime.
  * New callers that need retained GPADL and mmap ownership should use
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index ffba1443396a..fd8aa7a3dcb3 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -243,7 +243,6 @@ static void netvsc_revoke_recv_buf(struct hv_device *device,
 		if (ret != 0) {
 			netdev_err(ndev, "unable to send "
 				"revoke receive buffer to netvsp\n");
-			net_device->recv_buffer.leak = true;
 			return;
 		}
 		net_device->recv_section_cnt = 0;
@@ -295,7 +294,6 @@ static void netvsc_revoke_send_buf(struct hv_device *device,
 		if (ret != 0) {
 			netdev_err(ndev, "unable to send "
 				   "revoke send buffer to netvsp\n");
-			net_device->send_buffer.leak = true;
 			return;
 		}
 		net_device->send_section_cnt = 0;
@@ -308,18 +306,14 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
 {
 	int ret;
 
-	if (net_device->recv_buffer.leak)
-		return;
-
 	if (net_device->recv_buffer.gpadl.gpadl_handle) {
-		ret = vmbus_teardown_gpadl(device->channel,
-					   &net_device->recv_buffer.gpadl);
+		ret = vmbus_teardown_gpadl_owned(device->channel,
+						 &net_device->recv_buffer);
 
 		/* If we failed here, we might as well return and have a leak
 		 * rather than continue and a bugchk
 		 */
 		if (ret != 0) {
-			net_device->recv_buffer.leak = true;
 			netdev_err(ndev,
 				   "unable to teardown receive buffer's gpadl\n");
 			return;
@@ -333,18 +327,14 @@ static void netvsc_teardown_send_gpadl(struct hv_device *device,
 {
 	int ret;
 
-	if (net_device->send_buffer.leak)
-		return;
-
 	if (net_device->send_buffer.gpadl.gpadl_handle) {
-		ret = vmbus_teardown_gpadl(device->channel,
-					   &net_device->send_buffer.gpadl);
+		ret = vmbus_teardown_gpadl_owned(device->channel,
+						 &net_device->send_buffer);
 
 		/* If we failed here, we might as well return and have a leak
 		 * rather than continue and a bugchk
 		 */
 		if (ret != 0) {
-			net_device->send_buffer.leak = true;
 			netdev_err(ndev,
 				   "unable to teardown send buffer's gpadl\n");
 			return;
@@ -385,15 +375,13 @@ static int netvsc_init_buf(struct hv_device *device,
 		buf_size = min_t(unsigned int, buf_size,
 				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
 
-	net_device->recv_buffer.addr =
-		vmbus_alloc_buffer(device->channel, buf_size,
-				   &net_device->recv_buffer.chunks,
-				   &net_device->recv_buffer.chunk_cnt);
-	if (!net_device->recv_buffer.addr) {
+	ret = vmbus_alloc_buffer_owned(device->channel, buf_size,
+				       device->channel->co_external_memory,
+				       &net_device->recv_buffer);
+	if (ret) {
 		netdev_err(ndev,
 			   "unable to allocate receive buffer of size %u\n",
 			   buf_size);
-		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -404,11 +392,8 @@ static int netvsc_init_buf(struct hv_device *device,
 	 * channel.  Note: This call uses the vmbus connection rather
 	 * than the channel to establish the gpadl handle.
 	 */
-	ret = vmbus_establish_gpadl_caller_decrypted(device->channel,
-						     net_device->recv_buffer.addr,
-						     buf_size,
-						     &net_device->recv_buffer.gpadl);
-	net_device->recv_buffer.leak |= net_device->recv_buffer.gpadl.leak;
+	ret = vmbus_establish_gpadl_owned(device->channel,
+					  &net_device->recv_buffer);
 	if (ret != 0) {
 		netdev_err(ndev,
 			"unable to establish receive buffer's gpadl\n");
@@ -496,14 +481,12 @@ static int netvsc_init_buf(struct hv_device *device,
 	buf_size = device_info->send_sections * device_info->send_section_size;
 	buf_size = round_up(buf_size, PAGE_SIZE);
 
-	net_device->send_buffer.addr =
-		vmbus_alloc_buffer(device->channel, buf_size,
-				   &net_device->send_buffer.chunks,
-				   &net_device->send_buffer.chunk_cnt);
-	if (!net_device->send_buffer.addr) {
+	ret = vmbus_alloc_buffer_owned(device->channel, buf_size,
+				       device->channel->co_external_memory,
+				       &net_device->send_buffer);
+	if (ret) {
 		netdev_err(ndev, "unable to allocate send buffer of size %u\n",
 			   buf_size);
-		ret = -ENOMEM;
 		goto cleanup;
 	}
 	net_device->send_buf_size = buf_size;
@@ -512,11 +495,8 @@ static int netvsc_init_buf(struct hv_device *device,
 	 * channel.  Note: This call uses the vmbus connection rather
 	 * than the channel to establish the gpadl handle.
 	 */
-	ret = vmbus_establish_gpadl_caller_decrypted(device->channel,
-						     net_device->send_buffer.addr,
-						     buf_size,
-						     &net_device->send_buffer.gpadl);
-	net_device->send_buffer.leak |= net_device->send_buffer.gpadl.leak;
+	ret = vmbus_establish_gpadl_owned(device->channel,
+					  &net_device->send_buffer);
 	if (ret != 0) {
 		netdev_err(ndev,
 			   "unable to establish send buffer's gpadl\n");
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 2cb95b4786ca..b40e80e19c6c 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -196,11 +196,11 @@ static void
 hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
 	if (pdata->send_buffer.gpadl.gpadl_handle)
-		vmbus_teardown_gpadl(dev->channel, &pdata->send_buffer.gpadl);
+		vmbus_teardown_gpadl_owned(dev->channel, &pdata->send_buffer);
 	vmbus_release_buffer(&pdata->send_buffer);
 
 	if (pdata->recv_buffer.gpadl.gpadl_handle)
-		vmbus_teardown_gpadl(dev->channel, &pdata->recv_buffer.gpadl);
+		vmbus_teardown_gpadl_owned(dev->channel, &pdata->recv_buffer);
 	vmbus_release_buffer(&pdata->recv_buffer);
 }
 
@@ -298,18 +298,12 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	if (channel->device_id == HV_NIC) {
-		pdata->recv_buffer.addr =
-			vzalloc(RECV_BUFFER_SIZE);
-		if (!pdata->recv_buffer.addr) {
-			ret = -ENOMEM;
+		ret = vmbus_alloc_buffer_owned(channel, RECV_BUFFER_SIZE, false,
+					       &pdata->recv_buffer);
+		if (ret)
 			goto fail_free_ring;
-		}
 
-		ret = vmbus_establish_gpadl(channel,
-					    pdata->recv_buffer.addr,
-					    RECV_BUFFER_SIZE,
-					    &pdata->recv_buffer.gpadl);
-		pdata->recv_buffer.leak |= pdata->recv_buffer.gpadl.leak;
+		ret = vmbus_establish_gpadl_owned(channel, &pdata->recv_buffer);
 		if (ret)
 			goto fail_close;
 
@@ -322,18 +316,12 @@ hv_uio_probe(struct hv_device *dev,
 		pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
 		pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 
-		pdata->send_buffer.addr =
-			vzalloc(SEND_BUFFER_SIZE);
-		if (!pdata->send_buffer.addr) {
-			ret = -ENOMEM;
+		ret = vmbus_alloc_buffer_owned(channel, SEND_BUFFER_SIZE, false,
+					       &pdata->send_buffer);
+		if (ret)
 			goto fail_close;
-		}
 
-		ret = vmbus_establish_gpadl(channel,
-					    pdata->send_buffer.addr,
-					    SEND_BUFFER_SIZE,
-					    &pdata->send_buffer.gpadl);
-		pdata->send_buffer.leak |= pdata->send_buffer.gpadl.leak;
+		ret = vmbus_establish_gpadl_owned(channel, &pdata->send_buffer);
 		if (ret)
 			goto fail_close;
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 90bdbacee054..0f482ed5c776 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1216,9 +1216,9 @@ extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 				     u64 requestid);
 
 extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
-				      void *kbuffer,
-				      u32 size,
-				      struct vmbus_gpadl *gpadl);
+				 void *kbuffer,
+				 u32 size,
+				 struct vmbus_gpadl *gpadl);
 
 extern int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
 						  void *kbuffer,
@@ -1226,7 +1226,7 @@ extern int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
 						  struct vmbus_gpadl *gpadl);
 
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
-				     struct vmbus_gpadl *gpadl);
+				struct vmbus_gpadl *gpadl);
 
 extern void *vmbus_alloc_buffer(struct vmbus_channel *channel,
 				u32 size,
-- 
2.43.0

