Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04E433042;
	Tue, 21 Jul 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663851; cv=none; b=p9BvHh1cKaV8NToQvjBRgRYaK2lFdw4XabZ+wUjdYP1LF2n/v0QYvXqN8G+PQGGvsuo6yfpy8aK/nhviYvD4VpVQoqkuI82dAcTnEZt1xauuCvUh6yypkzbprrZLZJ8rqDK/eNMDSkxxQcT6i53ikMd5P0ugiQia3hOlRaVLt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663851; c=relaxed/simple;
	bh=IYVSTxCpGVbAXARE7ds6mc9wTMZfxVD4NTRmpdogBCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFSBoDnXjMcV/nIo4eLoPq8otT972/jgse21ayXxftZ1fCUJBOUDQ1C9Hg3PNjdMGoK++E3fSMSzIABN1EdeS5tbka+1qHtI/2gpA9108Bze7Bnyma3JO731dVWFIxz/eo8eiZxh0zWaYtPJmpelSkkjuLeWTGs3dWxxdJ7baAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X+2I6Ofy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X+2I6Ofy"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D63B20B7169;
	Tue, 21 Jul 2026 12:57:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D63B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784663837;
	bh=926U/AZJ0GdSHqgcUZyUdYkCDirLtNdXi5CzAfUwUTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+2I6Ofy7cfywJQOzOU1C9G4rgAPvLo5ECWMmqlQqS3y2tpBLklSjCbA9IKCo6z/F
	 yrbK0FzYd8n3C9lwpYGHGGzPLxLRkSdzoxlB3KHuopX8OZQzzD3dI8o1gRtP4Cu1Qk
	 cDKs2hprgRXn8o4x9L2eSfMunWgHIiYHOPc6YhYY=
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
Subject: [RFC PATCH 1/2] Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
Date: Tue, 21 Jul 2026 12:56:32 -0700
Message-ID: <20260721195633.1438361-2-kameroncarr@linux.microsoft.com>
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

Refactor vmbus_establish_gpadl() to separate the encryption lifecycle
from the rest of the GPADL establishment logic.

Add a new vmbus_establish_gpadl_caller_decrypted() for callers that want
to decrypt their own buffers.

No functional change for existing callers.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/hv/channel.c   | 123 +++++++++++++++++++++++++++--------------
 include/linux/hyperv.h |  11 ++++
 2 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 6821f225248b1..0166367a4df37 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -426,7 +426,13 @@ static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
 }
 
 /*
- * __vmbus_establish_gpadl - Establish a GPADL for a buffer or ringbuffer
+ * __vmbus_establish_gpadl - Establish a GPADL for a buffer or ringbuffer.
+ *
+ * This function only handles the GPADL handshake with the host.  The caller
+ * is responsible for ensuring that @kbuffer is in the encryption state the
+ * host expects (host-visible / "decrypted" for confidential VMs); this
+ * function never calls set_memory_decrypted() or set_memory_encrypted().
+ * It also leaves gpadl->decrypted untouched, so the caller must set it.
  *
  * @channel: a channel
  * @type: the type of the corresponding GPADL, only meaningful for the guest.
@@ -434,7 +440,7 @@ static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
  * @size: page-size multiple
  * @send_offset: the offset (in bytes) where the send ring buffer starts,
  *              should be 0 for BUFFER type gpadl
- * @gpadl_handle: some funky thing
+ * @gpadl: out parameter receiving the established GPADL handle/buffer/size
  */
 static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 				   enum hv_gpadl_type type, void *kbuffer,
@@ -454,30 +460,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
 
 	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
-	if (ret) {
-		gpadl->decrypted = false;
+	if (ret)
 		return ret;
-	}
-
-	gpadl->decrypted = !((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
-		(channel->co_ring_buffer && type == HV_GPADL_RING));
-	if (gpadl->decrypted) {
-		/*
-		 * The "decrypted" flag being true assumes that set_memory_decrypted() succeeds.
-		 * But if it fails, the encryption state of the memory is unknown. In that case,
-		 * leave "decrypted" as true to ensure the memory is leaked instead of going back
-		 * on the free list.
-		 */
-		ret = set_memory_decrypted((unsigned long)kbuffer,
-					PFN_UP(size));
-		if (ret) {
-			dev_warn(&channel->device_obj->device,
-				"Failed to set host visibility for new GPADL %d.\n",
-				ret);
-			vmbus_free_channel_msginfo(msginfo);
-			return ret;
-		}
-	}
 
 	init_completion(&msginfo->waitevent);
 	msginfo->waiting_channel = channel;
@@ -553,19 +537,47 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 
 	vmbus_free_channel_msginfo(msginfo);
+	return ret;
+}
 
-	if (ret) {
-		/*
-		 * If set_memory_encrypted() fails, the decrypted flag is
-		 * left as true so the memory is leaked instead of being
-		 * put back on the free list.
-		 */
-		if (gpadl->decrypted) {
-			if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
-				gpadl->decrypted = false;
+/*
+ * vmbus_establish_gpadl_and_decrypt - Manage the encryption lifecycle of
+ * @kbuffer around a __vmbus_establish_gpadl() call.
+ *
+ * Decrypts @kbuffer (making it host-visible) unless the channel was created
+ * with confidential memory for @type, then establishes the GPADL.  On
+ * establish failure the buffer is re-encrypted so the caller can free it.
+ *
+ * Sets gpadl->decrypted; see the comment on struct vmbus_gpadl::decrypted.
+ */
+static int vmbus_establish_gpadl_and_decrypt(struct vmbus_channel *channel,
+					     enum hv_gpadl_type type,
+					     void *kbuffer, u32 size,
+					     u32 send_offset,
+					     struct vmbus_gpadl *gpadl)
+{
+	bool decrypt = !((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
+			 (channel->co_ring_buffer && type == HV_GPADL_RING));
+	int ret;
+
+	if (decrypt) {
+		ret = set_memory_decrypted((unsigned long)kbuffer, PFN_UP(size));
+		if (ret) {
+			dev_warn(&channel->device_obj->device,
+				 "Failed to set host visibility for new GPADL %d.\n",
+				 ret);
+			/* Encryption state unknown; signal caller to leak. */
+			gpadl->decrypted = true;
+			return ret;
 		}
 	}
 
+	gpadl->decrypted = decrypt;
+	ret = __vmbus_establish_gpadl(channel, type, kbuffer, size, send_offset,
+				      gpadl);
+	if (ret && decrypt &&
+	    !set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
+		gpadl->decrypted = false;
 	return ret;
 }
 
@@ -580,11 +592,40 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 			  u32 size, struct vmbus_gpadl *gpadl)
 {
-	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer, size,
-				       0U, gpadl);
+	return vmbus_establish_gpadl_and_decrypt(channel, HV_GPADL_BUFFER,
+						 kbuffer, size, 0U, gpadl);
 }
 EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
 
+/*
+ * vmbus_establish_gpadl_caller_decrypted - Establish a GPADL for a buffer
+ * whose encryption state is managed by the caller.
+ *
+ * @channel: a channel
+ * @kbuffer: a buffer that the caller has already transitioned to host-visible
+ *           (decrypted) via set_memory_decrypted() or an equivalent mechanism.
+ * @size: page-size multiple
+ * @gpadl: out parameter receiving the established GPADL
+ *
+ * Unlike vmbus_establish_gpadl(), this function does not call
+ * set_memory_decrypted() on @kbuffer, and the matching vmbus_teardown_gpadl()
+ * call will not call set_memory_encrypted() on it.  The caller is responsible
+ * for the full encryption lifecycle of @kbuffer; on return gpadl->decrypted
+ * is set to false to record that vmbus does not own the encryption state.
+ */
+int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
+					   void *kbuffer, u32 size,
+					   struct vmbus_gpadl *gpadl)
+{
+	int ret = __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer,
+					  size, 0U, gpadl);
+
+	/* Caller owns @kbuffer's encryption; teardown must not touch it. */
+	gpadl->decrypted = false;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
+
 /**
  * request_arr_init - Allocates memory for the requestor array. Each slot
  * keeps track of the next available slot in the array. Initially, each
@@ -685,11 +726,11 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	/* Establish the gpadl for the ring buffer */
 	newchannel->ringbuffer_gpadlhandle.gpadl_handle = 0;
 
-	err = __vmbus_establish_gpadl(newchannel, HV_GPADL_RING,
-				      page_address(newchannel->ringbuffer_page),
-				      (send_pages + recv_pages) << PAGE_SHIFT,
-				      newchannel->ringbuffer_send_offset << PAGE_SHIFT,
-				      &newchannel->ringbuffer_gpadlhandle);
+	err = vmbus_establish_gpadl_and_decrypt(newchannel, HV_GPADL_RING,
+						page_address(newchannel->ringbuffer_page),
+						(send_pages + recv_pages) << PAGE_SHIFT,
+						newchannel->ringbuffer_send_offset << PAGE_SHIFT,
+						&newchannel->ringbuffer_gpadlhandle);
 	if (err)
 		goto error_clean_ring;
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 964f1be8150c5..9c6b1b7794b48 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -781,6 +781,12 @@ struct vmbus_gpadl {
 	u32 gpadl_handle;
 	u32 size;
 	void *buffer;
+	/*
+	 * Only used if the vmbus layer owns the encryption lifecycle of
+	 * @buffer.
+	 * Indicates @buffer must be re-encrypted at teardown or that it
+	 * must be leaked because re-encryption failed.
+	 */
 	bool decrypted;
 };
 
@@ -1205,6 +1211,11 @@ extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
 				      u32 size,
 				      struct vmbus_gpadl *gpadl);
 
+extern int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
+						  void *kbuffer,
+						  u32 size,
+						  struct vmbus_gpadl *gpadl);
+
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
 				     struct vmbus_gpadl *gpadl);
 
-- 
2.45.4

