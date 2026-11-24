Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556448;
	b=5WPSajfbR8TUUOLH4F5A+j8zYHDHRoS7ZxZRHcr+QZJaPKfgZnq4PjLPoh0hSYlXSwK8
	 XRwA5XrB0s0LpzvU3+5xomHXu/51Bh1elxq67ecZ3HATOPJP8l82zpx2QW8Y6krTPz3Me
	 YfgbOM/ICv0eGGvhP9q4tv9+IiaOV+bdHTQ1E3ZcMbn0t4uqMBoXbFGMCUK0X767whkQ+
	 jMJA//qeENhQBot4NXN6vGM+wXmwe3y3NW34BJL+w8MiUUMho/hEDb51xNXf5naldrn9J
	 kzqq3IqZ8lKjG5fOBQe7gHjp4l52MZrnBmHTkCES2Im1WggNtjeQLmzKbyUAqRaTv8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9av5cTxjedxsg9IBzY4Fvk9oi3DuPtj+YEn6r94NS24=;
	b=HT3rfoPeH2V1iLXYxIrcypI2Il2V81Crq2UOB4zw1VliUeN/pbitUvLD8IPr9KU82lCS
	 GwjspAySGPTUQJkZirBmyPWc6xUD7RgqfxcQvafWClK/GCItJiRbvRb9hDi0U/sVBvI6W
	 j1FyLto9mT7Z1/VaMN9uGXWBZW3s2S+qfkZShXL/UOCLB8jfQBWwv0jaiodKESYz1nNeB
	 GRIawkFtjxsxzysoKAVwcCamKX9wfUqIcEoFQTXL7PhRmxIAJ+ysChZqadEQGKy+Y6BbN
	 AbHdMblERRcH5M1/d+sgir3Xba78xjfByKZktFUhq9Dt0CEE97dWsBEDJSM8el7l/rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwH06EeI;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34161606A327
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 21:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34161606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwH06EeI
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d6554d96d3so2864912137.0
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 13:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556446; x=1796161246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9av5cTxjedxsg9IBzY4Fvk9oi3DuPtj+YEn6r94NS24=;
        b=zwH06EeIoHHJivMwMJCqTiunk8VB1CTS8Db6LaGdvni0UjJ46hhsc/MSgTcRnwyPtW
         2HgVD0LSO1IST138p5qEIeWPVHcnvDqxoia5nWT5OcrY20hlhmwQn8IpfhA+EQ2YC9q0
         aSua9rbupDOnPAx5cug2jIFjnfiKEr6vp1AV2sVAog1v9kdbR6deqiGHJNfB63+1OXEU
         17UNMdDl1MpDtERuvTucPH6RO3zKaAzl+VO08vpjMVWxIFrz5Pt4QG/s193yhFpinYCN
         rSZLUZWrB4oBoocZb+HN0GqacxqppSEHgoVL8CsAlSbIUkJl6QJxbrN4/g7h5AX5Lwiy
         AnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556446; x=1796161246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9av5cTxjedxsg9IBzY4Fvk9oi3DuPtj+YEn6r94NS24=;
        b=oLYTu3c7/xzmI2ya7Dqg8BIZU6JlqU5eNnRmmzQ/1YWTLDvyey+5cEPmfcV6mkYyaW
         brHlAest2LdUtL/cENUXWrrDb1zsTTh533yvfqyrxVLGjvzP8gglg4Hue6/jbP+g6NP5
         eS26bYUHXE1yqpdhbTDlHRpFf/1R/F5qNF5UqY2a+RyGmXB9ee7tSwXwwNEhST63+wdX
         z1tPmF0VQxwp+5gMiKlO3/avVnwc4xwBj2f7EAgVvsD+fF09jSyoJdg6kiKSao7F1SdK
         DYy/ao+vOTj3JrztdfexlDkk2W/YcmjpNhcTKoifEj/v9sUcqvkJMqZyA72xZBVtvwq7
         FM3g==
X-Forwarded-Encrypted: i=1; AL+hErG2mF8peKIFSsZhIOuKlulEhZyjs9UqOdf6KfJZjGmFMGN+DmEYYnhTaHK4eUCS4Lc9wfzSgdhfgKzlH0U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S7ME0BmfnEtQUJ66JPgC4X4tTL70CFj/0uzW3lgFvlPIqxTN/
	uYyG2oaqDC5LSWzzt//DYMkUtrcBuiRR17rkhigeslE+tUz+fDwSQJwG
X-Gm-Gg: AZFdTZfEBYHgmychSQ+eRX2yizDxFR02zfDXlsD0XV0N9UdLLIt7wUuQLK/kH1Ug90z
	b9sfFHneAFAWGpFsoe4TKb0AxjykwKWbGGYk2O1Z6BQRjAfofuck+Mfq9nVeFP8cx3vu6LmYZq5
	IwiA/EP5sKsxd6ntAx5Mi+FHYj9F/94qN2WNDodgXs/Q+gGCsrxkcraYaTQ0ffzxO6gQULrk6zU
	v1fY+S2yyo7ao+bwnFAoR9JQHM7HtGa6ztIVELiPU9c3Dld9DvXTi3U2IeNNfL/1AiDKdw+rXcM
	osAKnvHDNdTkvMDtYiP38es7BhSeZ4sL0PqwMPu8hbrMpKOWQ6ryPKAWeJzxpMJrJ+e+jvQnryL
	0gdbctDonDZ+NgqJbdA2cLfSD8Og6fINJe3n7XmyJXZlIxsgMwcON84ObGyIRJgA8F3AeH0tifN
	A86oE+IOi7lFCDrQNxT67GeIcd7SxQ8UMJdgzj/Fbf9KFqZ4I8OXmoGH2rcpAXe2uvL/+wW3XU2
	79SRh7z3YQ7JcV4PYa2iibuCyKBR17fBhWiy75lw24rW/vRXLoZVg3fCP6MOseXyTQv4tYH36XH
	XBsrudr8eMogCEVsUN+Qqjs8Aa6Vpsoor0h2l/p9nsUOMgmt/MhhPw==
X-Received: by 2002:a05:6102:f07:b0:7d0:6cf3:d8f3 with SMTP id ada2fe7eead31-7d739444d6cmr9045693137.18.1795556445792;
        Tue, 24 Nov 2026 13:40:45 -0800 (PST)
Received: from emedev.tailf75c28.ts.net ([179.238.117.100])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec57ddsm15952879241.1.2026.11.24.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:40:45 -0800 (PST)
From: Emerson Busson <emersonbusson@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Kameron Carr <kameroncarr@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] hv: vmbus: encapsulate buffer and GPADL state in struct vmbus_buffer
Date: Tue, 24 Nov 2026 18:40:27 -0300
Message-ID: <20261124214030.174246-2-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124214030.174246-1-emersonbusson@gmail.com>
References: <20261124214030.174246-1-emersonbusson@gmail.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmbus_alloc_buffer() currently returns the virtual address, chunk array,
and chunk count through separate parameters that callers track alongside
struct vmbus_gpadl. As ring buffers are about to adopt vmbus_alloc_buffer()
as well, repeating those fields in every caller adds boilerplate and splits
allocation lifetime from GPADL teardown and leak handling.

Introduce struct vmbus_buffer to hold the mapping, chunk metadata, GPADL
handle, and a leak flag in one structure. Update vmbus_alloc_buffer(),
vmbus_free_buffer(), vmbus_establish_gpadl(), and vmbus_teardown_gpadl()
to operate on struct vmbus_buffer, and convert both external-buffer users
(hv_netvsc and uio_hv_generic).

Because every external buffer is now allocated and decrypted by
vmbus_alloc_buffer(), drop HV_GPADL_BUFFER_DECRYPTED and
vmbus_establish_gpadl_caller_decrypted(). Keep the leak flag set if GPADL
establishment fails after posting, if GPADL teardown fails, or if hv_netvsc
fails to send its protocol-level buffer revoke message, so neither
vmbus_teardown_gpadl() nor vmbus_free_buffer() releases host-owned memory.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c            | 317 ++++++++++++++++++--------------
 drivers/net/hyperv/hyperv_net.h |  10 +-
 drivers/net/hyperv/netvsc.c     |  64 ++++---
 drivers/uio/uio_hv_generic.c    |  65 +++----
 include/linux/hyperv.h          |  36 ++--
 5 files changed, 253 insertions(+), 239 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index a0883ddf32..9807ff35a1 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -42,7 +42,6 @@ static inline u32 hv_gpadl_size(enum hv_gpadl_type type, u32 size)
 {
 	switch (type) {
 	case HV_GPADL_BUFFER:
-	case HV_GPADL_BUFFER_DECRYPTED:
 		return size;
 	case HV_GPADL_RING:
 		/* The size of a ringbuffer must be page-aligned */
@@ -103,7 +102,6 @@ static inline u64 hv_gpadl_hvpfn(enum hv_gpadl_type type, void *kbuffer,
 
 	switch (type) {
 	case HV_GPADL_BUFFER:
-	case HV_GPADL_BUFFER_DECRYPTED:
 		break;
 	case HV_GPADL_RING:
 		if (i == 0)
@@ -443,7 +441,8 @@ static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
 static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 				   enum hv_gpadl_type type, void *kbuffer,
 				   u32 size, u32 send_offset,
-				   struct vmbus_gpadl *gpadl)
+				   bool caller_decrypted, u32 *gpadl_handle,
+				   bool *decrypted, bool *leak)
 {
 	struct vmbus_channel_gpadl_header *gpadlmsg;
 	struct vmbus_channel_gpadl_body *gpadl_body;
@@ -452,33 +451,39 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	struct list_head *curr;
 	u32 next_gpadl_handle;
 	unsigned long flags;
+	bool posted = false;
+	bool need_decrypt;
 	int ret = 0;
 
+	if (leak)
+		*leak = false;
+
 	next_gpadl_handle =
 		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
 
 	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
 	if (ret) {
-		gpadl->decrypted = false;
+		if (decrypted)
+			*decrypted = false;
 		return ret;
 	}
 
-	gpadl->decrypted = !((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
-		(channel->co_ring_buffer && type == HV_GPADL_RING) ||
-		(type == HV_GPADL_BUFFER_DECRYPTED));
-	if (gpadl->decrypted) {
+	need_decrypt = !caller_decrypted &&
+		!((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
+		  (channel->co_ring_buffer && type == HV_GPADL_RING));
+	if (decrypted)
+		*decrypted = need_decrypt;
+	if (need_decrypt) {
 		/*
-		 * The "decrypted" flag being true assumes that set_memory_decrypted() succeeds.
-		 * But if it fails, the encryption state of the memory is unknown. In that case,
-		 * leave "decrypted" as true to ensure the memory is leaked instead of going back
-		 * on the free list.
+		 * If set_memory_decrypted() fails, the encryption state is
+		 * unknown; leave *decrypted true so the memory is leaked.
 		 */
 		ret = set_memory_decrypted((unsigned long)kbuffer,
-					PFN_UP(size));
+					   PFN_UP(size));
 		if (ret) {
 			dev_warn(&channel->device_obj->device,
-				"Failed to set host visibility for new GPADL %d.\n",
-				ret);
+				 "Failed to set host visibility for new GPADL %d.\n",
+				 ret);
 			vmbus_free_channel_msginfo(msginfo);
 			return ret;
 		}
@@ -492,11 +497,9 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	gpadlmsg->child_relid = channel->offermsg.child_relid;
 	gpadlmsg->gpadl = next_gpadl_handle;
 
-
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_add_tail(&msginfo->msglistentry,
 		      &vmbus_connection.chn_msg_list);
-
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 
 	if (channel->rescind) {
@@ -504,6 +507,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		goto cleanup;
 	}
 
+	posted = true;
 	ret = vmbus_post_msg(gpadlmsg, msginfo->msgsize -
 			     sizeof(*msginfo), true);
 
@@ -529,11 +533,11 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 		if (ret != 0)
 			goto cleanup;
-
 	}
 	wait_for_completion(&msginfo->waitevent);
 
 	if (msginfo->response.gpadl_created.creation_status != 0) {
+		posted = false;
 		pr_err("Failed to establish GPADL: err = 0x%x\n",
 		       msginfo->response.gpadl_created.creation_status);
 
@@ -542,15 +546,14 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	}
 
 	if (channel->rescind) {
+		posted = false;
 		ret = -ENODEV;
 		goto cleanup;
 	}
 
 	/* At this point, we received the gpadl created msg */
-	gpadl->gpadl_handle = gpadlmsg->gpadl;
-	gpadl->buffer = kbuffer;
-	gpadl->size = size;
-
+	*gpadl_handle = gpadlmsg->gpadl;
+	posted = false;
 
 cleanup:
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
@@ -559,121 +562,100 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 	vmbus_free_channel_msginfo(msginfo);
 
-	if (ret) {
-		/*
-		 * If set_memory_encrypted() fails, the decrypted flag is
-		 * left as true so the memory is leaked instead of being
-		 * put back on the free list.
-		 */
-		if (gpadl->decrypted) {
-			if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
-				gpadl->decrypted = false;
-		}
+	if (ret && posted && leak)
+		*leak = true;
+
+	if (ret && !posted && need_decrypt) {
+		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)) &&
+		    decrypted)
+			*decrypted = false;
 	}
 
 	return ret;
 }
 
-/*
- * vmbus_establish_gpadl - Establish a GPADL for the specified buffer
+/**
+ * vmbus_establish_gpadl - Establish a GPADL for a buffer allocated with
+ *                         vmbus_alloc_buffer().
+ * @channel: VMBus channel to associate the GPADL with
+ * @buffer: buffer descriptor populated by vmbus_alloc_buffer()
  *
- * @channel: a channel
- * @kbuffer: from kmalloc or vmalloc
- * @size: page-size multiple
- * @gpadl: output gpadl
+ * Return: 0 on success, negative errno on failure. If a GPADL message may
+ * have reached the host, buffer->leak is set so vmbus_free_buffer() retains
+ * the backing pages.
  */
-int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
-			  u32 size, struct vmbus_gpadl *gpadl)
+int vmbus_establish_gpadl(struct vmbus_channel *channel,
+			  struct vmbus_buffer *buffer)
 {
-	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer, size,
-				       0U, gpadl);
+	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, buffer->addr,
+				       buffer->size, 0U, true,
+				       &buffer->gpadl_handle, NULL,
+				       &buffer->leak);
 }
 EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
 
-/*
- * vmbus_establish_gpadl_caller_decrypted - Establish a GPADL for a buffer
- * that has already been decrypted by the caller.
- *
- * @channel: a channel
- * @kbuffer: from kmalloc or vmalloc; must already be decrypted by the caller
- * @size: page-size multiple
- * @gpadl: output gpadl
- *
- * The caller is responsible for re-encrypting the buffer before freeing it.
- */
-int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
-					   void *kbuffer, u32 size,
-					   struct vmbus_gpadl *gpadl)
-{
-	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER_DECRYPTED,
-				       kbuffer, size, 0U, gpadl);
-}
-EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
-
 /**
  * vmbus_free_buffer - release a buffer allocated by vmbus_alloc_buffer().
+ * @buffer: buffer descriptor to release
  *
- * @addr: buffer address, or NULL if none was allocated (e.g. cleanup from a
- *        failed allocation)
- * @chunks: chunks array from vmbus_alloc_buffer(), or NULL
- * @chunk_cnt: number of entries in @chunks
- *
- * When @chunks is NULL the buffer is a plain vzalloc() allocation.
- *
- * Otherwise tear down the vmap, and for each chunk re-encrypt and free
- * the underlying pages. Any chunk that cannot be re-encrypted is leaked.
+ * If the buffer still has an active GPADL or buffer->leak is set, the backing
+ * pages are leaked rather than returned to the allocator. Any chunk that fails
+ * set_memory_encrypted() is likewise leaked while the remaining chunks and
+ * tracking arrays are freed.
  */
-void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt)
+void vmbus_free_buffer(struct vmbus_buffer *buffer)
 {
 	u32 i;
 
-	if (!chunks) {
-		vfree(addr);
+	kvfree(buffer->pages);
+	if (buffer->leak || buffer->gpadl_handle) {
+		kvfree(buffer->chunks);
+		memset(buffer, 0, sizeof(*buffer));
+		return;
+	}
+
+	if (!buffer->chunks) {
+		vfree(buffer->addr);
+		memset(buffer, 0, sizeof(*buffer));
 		return;
 	}
 
-	vunmap(addr);
+	vunmap(buffer->addr);
 
-	for (i = 0; i < chunk_cnt; i++) {
+	for (i = 0; i < buffer->chunk_cnt; i++) {
 		unsigned long vaddr =
-			(unsigned long)page_address(chunks[i]);
-		unsigned int order = folio_order(page_folio(chunks[i]));
+			(unsigned long)page_address(buffer->chunks[i]);
+		unsigned int order = folio_order(page_folio(buffer->chunks[i]));
 
 		if (set_memory_encrypted(vaddr, 1U << order))
 			continue;
-		__free_pages(chunks[i], order);
+		__free_pages(buffer->chunks[i], order);
 	}
 
-	kvfree(chunks);
+	kvfree(buffer->chunks);
+	memset(buffer, 0, sizeof(*buffer));
 }
 EXPORT_SYMBOL_GPL(vmbus_free_buffer);
 
 /**
- * vmbus_alloc_buffer - allocate a host-visible, virtually-contiguous buffer.
- *
- * @channel: the channel the buffer will be attached to
- * @size: requested buffer size in bytes (will be rounded up to PAGE_SIZE)
- * @chunks_out: on success, set to the array of underlying chunks, or NULL when
- *              the buffer was allocated with vzalloc()
- * @chunk_cnt_out: on success, set to the number of chunks
- *
- * Buffers not requiring decryption are allocated with vzalloc().
+ * vmbus_alloc_buffer - allocate a virtually contiguous VMBus buffer.
+ * @channel: channel the buffer will be attached to
+ * @size: requested size in bytes (rounded up to PAGE_SIZE)
+ * @confidential: keep the buffer private to the guest
+ * @buffer: output descriptor populated on success
  *
- * Buffers requiring decryption are allocated as a series of
- * physically-contiguous chunks, starting at MAX_PAGE_ORDER and falling back to
- * smaller orders on allocation failure. Each chunk is transitioned to
- * host-visible via set_memory_decrypted() on its direct-map address, then all
- * chunks are combined into a virtually-contiguous range via vmap().
+ * Buffers not requiring decryption are allocated with vzalloc_node().
+ * Host-visible buffers in isolated guests are allocated as physically
+ * contiguous chunks starting at MAX_PAGE_ORDER and falling back down to
+ * order 0, decrypted on their direct-map address, and combined with vmap().
  *
- * Return: the buffer's virtual address, or NULL on failure.
+ * Return: 0 on success, negative errno on failure.
  */
-void *vmbus_alloc_buffer(struct vmbus_channel *channel,
-			 u32 size,
-			 struct page ***chunks_out,
-			 u32 *chunk_cnt_out)
+int vmbus_alloc_buffer(struct vmbus_channel *channel, u32 size,
+		       bool confidential, struct vmbus_buffer *buffer)
 {
-	unsigned long nr_pages = PFN_UP(size);
-	unsigned long remaining = nr_pages;
+	unsigned long nr_pages;
+	unsigned long remaining;
 	unsigned long page_idx = 0;
 	struct page **chunks = NULL;
 	struct page **pages = NULL;
@@ -683,24 +665,36 @@ void *vmbus_alloc_buffer(struct vmbus_channel *channel,
 	u32 i;
 	int ret;
 
-	*chunks_out = NULL;
-	*chunk_cnt_out = 0;
+	memset(buffer, 0, sizeof(*buffer));
 
-	if (!nr_pages)
-		return NULL;
+	if (!size || size > U32_MAX - PAGE_SIZE + 1)
+		return -EINVAL;
+
+	nr_pages = PFN_UP(size);
+	remaining = nr_pages;
+
+	/* If the buffer does not need to be decrypted, just use vzalloc_node() */
+	if (!hv_is_isolation_supported() || confidential) {
+		addr = vzalloc_node(nr_pages << PAGE_SHIFT,
+				    cpu_to_node(channel->target_cpu));
+		if (!addr)
+			return -ENOMEM;
 
-	/* If the buffer does not need to be decrypted, just use vzalloc() */
-	if (!hv_is_isolation_supported() || channel->co_external_memory)
-		return vzalloc(nr_pages << PAGE_SHIFT);
+		buffer->addr = addr;
+		buffer->size = nr_pages << PAGE_SHIFT;
+		return 0;
+	}
 
 	/* Worst case: every chunk is a single page. */
 	chunks = kvmalloc_objs(*chunks, nr_pages, GFP_KERNEL | __GFP_ZERO);
 	if (!chunks)
-		goto err;
+		return -ENOMEM;
 
 	pages = kvmalloc_objs(*pages, nr_pages);
-	if (!pages)
-		goto err;
+	if (!pages) {
+		kvfree(chunks);
+		return -ENOMEM;
+	}
 
 	while (remaining) {
 		struct page *page;
@@ -731,7 +725,7 @@ void *vmbus_alloc_buffer(struct vmbus_channel *channel,
 		if (ret) {
 			/*
 			 * set_memory_decrypted() failed; the page state is
-			 * unknown so it must be leaked rather than freed.
+			 * unknown so leak this chunk and free earlier ones.
 			 */
 			goto err;
 		}
@@ -751,14 +745,18 @@ void *vmbus_alloc_buffer(struct vmbus_channel *channel,
 	memset(addr, 0, nr_pages << PAGE_SHIFT);
 
 	kvfree(pages);
-	*chunks_out = chunks;
-	*chunk_cnt_out = chunk_cnt;
-	return addr;
+	buffer->addr = addr;
+	buffer->chunks = chunks;
+	buffer->size = nr_pages << PAGE_SHIFT;
+	buffer->chunk_cnt = chunk_cnt;
+	return 0;
 
 err:
 	kvfree(pages);
-	vmbus_free_buffer(NULL, chunks, chunk_cnt);
-	return NULL;
+	buffer->chunks = chunks;
+	buffer->chunk_cnt = chunk_cnt;
+	vmbus_free_buffer(buffer);
+	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(vmbus_alloc_buffer);
 
@@ -826,6 +824,10 @@ static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
 	bitmap_free(rqstor->req_bitmap);
 }
 
+static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
+				  u32 *gpadl_handle, void *kbuffer,
+				  u32 size, bool *decrypted, bool *leak);
+
 static int __vmbus_open(struct vmbus_channel *newchannel,
 		       void *userdata, u32 userdatalen,
 		       void (*onchannelcallback)(void *context), void *context)
@@ -866,9 +868,16 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 				      page_address(newchannel->ringbuffer_page),
 				      (send_pages + recv_pages) << PAGE_SHIFT,
 				      newchannel->ringbuffer_send_offset << PAGE_SHIFT,
-				      &newchannel->ringbuffer_gpadlhandle);
+				      false,
+				      &newchannel->ringbuffer_gpadlhandle.gpadl_handle,
+				      &newchannel->ringbuffer_gpadlhandle.decrypted,
+				      NULL);
 	if (err)
 		goto error_clean_ring;
+	newchannel->ringbuffer_gpadlhandle.buffer =
+		page_address(newchannel->ringbuffer_page);
+	newchannel->ringbuffer_gpadlhandle.size =
+		(send_pages + recv_pages) << PAGE_SHIFT;
 
 	err = hv_ringbuffer_init(&newchannel->outbound,
 				 page, send_pages, 0, newchannel->co_ring_buffer);
@@ -956,7 +965,12 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 error_free_info:
 	kfree(open_info);
 error_free_gpadl:
-	vmbus_teardown_gpadl(newchannel, &newchannel->ringbuffer_gpadlhandle);
+	__vmbus_teardown_gpadl(newchannel,
+			       &newchannel->ringbuffer_gpadlhandle.gpadl_handle,
+			       newchannel->ringbuffer_gpadlhandle.buffer,
+			       newchannel->ringbuffer_gpadlhandle.size,
+			       &newchannel->ringbuffer_gpadlhandle.decrypted,
+			       NULL);
 error_clean_ring:
 	hv_ringbuffer_cleanup(&newchannel->outbound);
 	hv_ringbuffer_cleanup(&newchannel->inbound);
@@ -999,20 +1013,22 @@ int vmbus_open(struct vmbus_channel *newchannel,
 }
 EXPORT_SYMBOL_GPL(vmbus_open);
 
-/*
- * vmbus_teardown_gpadl -Teardown the specified GPADL handle
- */
-int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpadl)
+static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
+				  u32 *gpadl_handle, void *kbuffer,
+				  u32 size, bool *decrypted, bool *leak)
 {
 	struct vmbus_channel_gpadl_teardown *msg;
 	struct vmbus_channel_msginfo *info;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	info = kzalloc(sizeof(*info) +
 		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
-	if (!info)
+	if (!info) {
+		if (leak)
+			*leak = true;
 		return -ENOMEM;
+	}
 
 	init_completion(&info->waitevent);
 	info->waiting_channel = channel;
@@ -1021,7 +1037,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
 	msg->header.msgtype = CHANNELMSG_GPADL_TEARDOWN;
 	msg->child_relid = channel->offermsg.child_relid;
-	msg->gpadl = gpadl->gpadl_handle;
+	msg->gpadl = *gpadl_handle;
 
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_add_tail(&info->msglistentry,
@@ -1041,13 +1057,10 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
 	wait_for_completion(&info->waitevent);
 
-	gpadl->gpadl_handle = 0;
-
 post_msg_err:
 	/*
-	 * If the channel has been rescinded;
-	 * we will be awakened by the rescind
-	 * handler; set the error code to zero so we don't leak memory.
+	 * If the channel has been rescinded, the rescind handler wakes us;
+	 * clear the error code so the buffer is not leaked.
 	 */
 	if (channel->rescind)
 		ret = 0;
@@ -1058,18 +1071,35 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
 	kfree(info);
 
-	if (gpadl->decrypted)
-		ret = set_memory_encrypted((unsigned long)gpadl->buffer,
-					PFN_UP(gpadl->size));
-	else
-		ret = 0;
-	if (ret)
-		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
-
-	gpadl->decrypted = ret;
+	if (!ret)
+		*gpadl_handle = 0;
+	else if (leak)
+		*leak = true;
+
+	if (!ret && decrypted && *decrypted) {
+		ret = set_memory_encrypted((unsigned long)kbuffer,
+					   PFN_UP(size));
+		if (ret)
+			pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n",
+				ret);
+		*decrypted = !!ret;
+	}
 
 	return ret;
 }
+
+/*
+ * vmbus_teardown_gpadl - Teardown the specified GPADL handle
+ */
+int vmbus_teardown_gpadl(struct vmbus_channel *channel,
+			 struct vmbus_buffer *buffer)
+{
+	if (!buffer->gpadl_handle)
+		return 0;
+
+	return __vmbus_teardown_gpadl(channel, &buffer->gpadl_handle,
+				      NULL, 0, NULL, &buffer->leak);
+}
 EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
 
 void vmbus_reset_channel_cb(struct vmbus_channel *channel)
@@ -1143,7 +1173,12 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 
 	/* Tear down the gpadl for the channel's ring buffer */
 	else if (channel->ringbuffer_gpadlhandle.gpadl_handle) {
-		ret = vmbus_teardown_gpadl(channel, &channel->ringbuffer_gpadlhandle);
+		ret = __vmbus_teardown_gpadl(channel,
+					     &channel->ringbuffer_gpadlhandle.gpadl_handle,
+					     channel->ringbuffer_gpadlhandle.buffer,
+					     channel->ringbuffer_gpadlhandle.size,
+					     &channel->ringbuffer_gpadlhandle.decrypted,
+					     NULL);
 		if (ret) {
 			pr_err("Close failed: teardown gpadl return %d\n", ret);
 			/*
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 4841367fda..a15cb24603 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1158,21 +1158,15 @@ struct netvsc_device {
 	bool tx_disable; /* if true, do not wake up queue again */
 
 	/* Receive buffer allocated by us but manages by NetVSP */
-	void *recv_buf;
+	struct vmbus_buffer recv_buffer;
 	u32 recv_buf_size; /* allocated bytes */
-	struct page **recv_buf_chunks;
-	u32 recv_buf_chunk_cnt;
-	struct vmbus_gpadl recv_buf_gpadl_handle;
 	u32 recv_section_cnt;
 	u32 recv_section_size;
 	u32 recv_completion_cnt;
 
 	/* Send buffer allocated by us */
-	void *send_buf;
+	struct vmbus_buffer send_buffer;
 	u32 send_buf_size;
-	struct page **send_buf_chunks;
-	u32 send_buf_chunk_cnt;
-	struct vmbus_gpadl send_buf_gpadl_handle;
 	u32 send_section_cnt;
 	u32 send_section_size;
 	unsigned long *send_section_map;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index fc6548b16c..f668829291 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -134,10 +134,8 @@ static void __free_netvsc_device(struct netvsc_device *nvdev)
 
 	kfree(nvdev->extension);
 
-	vmbus_free_buffer(nvdev->recv_buf, nvdev->recv_buf_chunks,
-			  nvdev->recv_buf_chunk_cnt);
-	vmbus_free_buffer(nvdev->send_buf, nvdev->send_buf_chunks,
-			  nvdev->send_buf_chunk_cnt);
+	vmbus_free_buffer(&nvdev->recv_buffer);
+	vmbus_free_buffer(&nvdev->send_buffer);
 	bitmap_free(nvdev->send_section_map);
 
 	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
@@ -245,6 +243,7 @@ static void netvsc_revoke_recv_buf(struct hv_device *device,
 		if (ret != 0) {
 			netdev_err(ndev, "unable to send "
 				"revoke receive buffer to netvsp\n");
+			net_device->recv_buffer.leak = true;
 			return;
 		}
 		net_device->recv_section_cnt = 0;
@@ -296,6 +295,7 @@ static void netvsc_revoke_send_buf(struct hv_device *device,
 		if (ret != 0) {
 			netdev_err(ndev, "unable to send "
 				   "revoke send buffer to netvsp\n");
+			net_device->send_buffer.leak = true;
 			return;
 		}
 		net_device->send_section_cnt = 0;
@@ -308,9 +308,12 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
 {
 	int ret;
 
-	if (net_device->recv_buf_gpadl_handle.gpadl_handle) {
+	if (net_device->recv_buffer.leak)
+		return;
+
+	if (net_device->recv_buffer.gpadl_handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
-					   &net_device->recv_buf_gpadl_handle);
+					   &net_device->recv_buffer);
 
 		/* If we failed here, we might as well return and have a leak
 		 * rather than continue and a bugchk
@@ -329,9 +332,12 @@ static void netvsc_teardown_send_gpadl(struct hv_device *device,
 {
 	int ret;
 
-	if (net_device->send_buf_gpadl_handle.gpadl_handle) {
+	if (net_device->send_buffer.leak)
+		return;
+
+	if (net_device->send_buffer.gpadl_handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
-					   &net_device->send_buf_gpadl_handle);
+					   &net_device->send_buffer);
 
 		/* If we failed here, we might as well return and have a leak
 		 * rather than continue and a bugchk
@@ -377,15 +383,13 @@ static int netvsc_init_buf(struct hv_device *device,
 		buf_size = min_t(unsigned int, buf_size,
 				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
 
-	net_device->recv_buf =
-		vmbus_alloc_buffer(device->channel, buf_size,
-				   &net_device->recv_buf_chunks,
-				   &net_device->recv_buf_chunk_cnt);
-	if (!net_device->recv_buf) {
+	ret = vmbus_alloc_buffer(device->channel, buf_size,
+				 device->channel->co_external_memory,
+				 &net_device->recv_buffer);
+	if (ret) {
 		netdev_err(ndev,
 			   "unable to allocate receive buffer of size %u\n",
 			   buf_size);
-		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -396,10 +400,8 @@ static int netvsc_init_buf(struct hv_device *device,
 	 * channel.  Note: This call uses the vmbus connection rather
 	 * than the channel to establish the gpadl handle.
 	 */
-	ret = vmbus_establish_gpadl_caller_decrypted(device->channel,
-						     net_device->recv_buf,
-						     buf_size,
-						     &net_device->recv_buf_gpadl_handle);
+	ret = vmbus_establish_gpadl(device->channel,
+				    &net_device->recv_buffer);
 	if (ret != 0) {
 		netdev_err(ndev,
 			"unable to establish receive buffer's gpadl\n");
@@ -410,8 +412,8 @@ static int netvsc_init_buf(struct hv_device *device,
 	init_packet = &net_device->channel_init_pkt;
 	memset(init_packet, 0, sizeof(struct nvsp_message));
 	init_packet->hdr.msg_type = NVSP_MSG1_TYPE_SEND_RECV_BUF;
-	init_packet->msg.v1_msg.send_recv_buf.
-		gpadl_handle = net_device->recv_buf_gpadl_handle.gpadl_handle;
+	init_packet->msg.v1_msg.send_recv_buf.gpadl_handle =
+		net_device->recv_buffer.gpadl_handle;
 	init_packet->msg.v1_msg.
 		send_recv_buf.id = NETVSC_RECEIVE_BUFFER_ID;
 
@@ -487,14 +489,12 @@ static int netvsc_init_buf(struct hv_device *device,
 	buf_size = device_info->send_sections * device_info->send_section_size;
 	buf_size = round_up(buf_size, PAGE_SIZE);
 
-	net_device->send_buf =
-		vmbus_alloc_buffer(device->channel, buf_size,
-				   &net_device->send_buf_chunks,
-				   &net_device->send_buf_chunk_cnt);
-	if (!net_device->send_buf) {
+	ret = vmbus_alloc_buffer(device->channel, buf_size,
+				 device->channel->co_external_memory,
+				 &net_device->send_buffer);
+	if (ret) {
 		netdev_err(ndev, "unable to allocate send buffer of size %u\n",
 			   buf_size);
-		ret = -ENOMEM;
 		goto cleanup;
 	}
 	net_device->send_buf_size = buf_size;
@@ -503,10 +503,8 @@ static int netvsc_init_buf(struct hv_device *device,
 	 * channel.  Note: This call uses the vmbus connection rather
 	 * than the channel to establish the gpadl handle.
 	 */
-	ret = vmbus_establish_gpadl_caller_decrypted(device->channel,
-						     net_device->send_buf,
-						     buf_size,
-						     &net_device->send_buf_gpadl_handle);
+	ret = vmbus_establish_gpadl(device->channel,
+				    &net_device->send_buffer);
 	if (ret != 0) {
 		netdev_err(ndev,
 			   "unable to establish send buffer's gpadl\n");
@@ -518,7 +516,7 @@ static int netvsc_init_buf(struct hv_device *device,
 	memset(init_packet, 0, sizeof(struct nvsp_message));
 	init_packet->hdr.msg_type = NVSP_MSG1_TYPE_SEND_SEND_BUF;
 	init_packet->msg.v1_msg.send_send_buf.gpadl_handle =
-		net_device->send_buf_gpadl_handle.gpadl_handle;
+		net_device->send_buffer.gpadl_handle;
 	init_packet->msg.v1_msg.send_send_buf.id = NETVSC_SEND_BUFFER_ID;
 
 	trace_nvsp_send(ndev, init_packet);
@@ -965,7 +963,7 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 				    struct hv_page_buffer *pb,
 				    bool xmit_more)
 {
-	char *start = net_device->send_buf;
+	char *start = net_device->send_buffer.addr;
 	char *dest = start + (section_index * net_device->send_section_size)
 		     + pend_size;
 	int i;
@@ -1472,7 +1470,7 @@ static int netvsc_receive(struct net_device *ndev,
 	const struct nvsp_message *nvsp = hv_pkt_data(desc);
 	u32 msglen = hv_pkt_datalen(desc);
 	u16 q_idx = channel->offermsg.offer.sub_channel_index;
-	char *recv_buf = net_device->recv_buf;
+	char *recv_buf = net_device->recv_buffer.addr;
 	u32 status = NVSP_STAT_SUCCESS;
 	int i;
 	int count = 0;
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 7b4cc456c4..9c6449c92a 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -27,7 +27,6 @@
 #include <linux/if_ether.h>
 #include <linux/skbuff.h>
 #include <linux/hyperv.h>
-#include <linux/vmalloc.h>
 #include <linux/slab.h>
 
 #include "../hv/hyperv_vmbus.h"
@@ -56,12 +55,10 @@ struct hv_uio_private_data {
 	struct hv_device *device;
 	atomic_t refcnt;
 
-	void	*recv_buf;
-	struct vmbus_gpadl recv_gpadl;
+	struct vmbus_buffer recv_buffer;
 	char	recv_name[32];	/* "recv_4294967295" */
 
-	void	*send_buf;
-	struct vmbus_gpadl send_gpadl;
+	struct vmbus_buffer send_buffer;
 	char	send_name[32];
 };
 
@@ -195,17 +192,13 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 static void
 hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
-	if (pdata->send_gpadl.gpadl_handle) {
-		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
-		if (!pdata->send_gpadl.decrypted)
-			vfree(pdata->send_buf);
-	}
+	if (pdata->send_buffer.gpadl_handle)
+		vmbus_teardown_gpadl(dev->channel, &pdata->send_buffer);
+	vmbus_free_buffer(&pdata->send_buffer);
 
-	if (pdata->recv_gpadl.gpadl_handle) {
-		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
-		if (!pdata->recv_gpadl.decrypted)
-			vfree(pdata->recv_buf);
-	}
+	if (pdata->recv_buffer.gpadl_handle)
+		vmbus_teardown_gpadl(dev->channel, &pdata->recv_buffer);
+	vmbus_free_buffer(&pdata->recv_buffer);
 }
 
 /* VMBus primary channel is opened on first use */
@@ -303,46 +296,40 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	if (channel->device_id == HV_NIC) {
-		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
-		if (!pdata->recv_buf) {
-			ret = -ENOMEM;
+		ret = vmbus_alloc_buffer(channel, RECV_BUFFER_SIZE,
+					 channel->co_external_memory,
+					 &pdata->recv_buffer);
+		if (ret)
 			goto fail_free_ring;
-		}
 
-		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
-					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
-		if (ret) {
-			if (!pdata->recv_gpadl.decrypted)
-				vfree(pdata->recv_buf);
+		ret = vmbus_establish_gpadl(channel, &pdata->recv_buffer);
+		if (ret)
 			goto fail_close;
-		}
 
 		/* put Global Physical Address Label in name */
 		snprintf(pdata->recv_name, sizeof(pdata->recv_name),
-			 "recv:%u", pdata->recv_gpadl.gpadl_handle);
+			 "recv:%u", pdata->recv_buffer.gpadl_handle);
 		pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
-		pdata->info.mem[RECV_BUF_MAP].addr = (uintptr_t)pdata->recv_buf;
+		pdata->info.mem[RECV_BUF_MAP].addr =
+			(uintptr_t)pdata->recv_buffer.addr;
 		pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
 		pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 
-		pdata->send_buf = vzalloc(SEND_BUFFER_SIZE);
-		if (!pdata->send_buf) {
-			ret = -ENOMEM;
+		ret = vmbus_alloc_buffer(channel, SEND_BUFFER_SIZE,
+					 channel->co_external_memory,
+					 &pdata->send_buffer);
+		if (ret)
 			goto fail_close;
-		}
 
-		ret = vmbus_establish_gpadl(channel, pdata->send_buf,
-					    SEND_BUFFER_SIZE, &pdata->send_gpadl);
-		if (ret) {
-			if (!pdata->send_gpadl.decrypted)
-				vfree(pdata->send_buf);
+		ret = vmbus_establish_gpadl(channel, &pdata->send_buffer);
+		if (ret)
 			goto fail_close;
-		}
 
 		snprintf(pdata->send_name, sizeof(pdata->send_name),
-			 "send:%u", pdata->send_gpadl.gpadl_handle);
+			 "send:%u", pdata->send_buffer.gpadl_handle);
 		pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
-		pdata->info.mem[SEND_BUF_MAP].addr = (uintptr_t)pdata->send_buf;
+		pdata->info.mem[SEND_BUF_MAP].addr =
+			(uintptr_t)pdata->send_buffer.addr;
 		pdata->info.mem[SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
 		pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 	}
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index e85a1a043e..17ad83d19a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -70,8 +70,7 @@
  */
 enum hv_gpadl_type {
 	HV_GPADL_BUFFER,
-	HV_GPADL_RING,
-	HV_GPADL_BUFFER_DECRYPTED
+	HV_GPADL_RING
 };
 
 /* Single-page buffer */
@@ -816,6 +815,16 @@ struct vmbus_gpadl {
 	bool decrypted;
 };
 
+struct vmbus_buffer {
+	void *addr;
+	struct page **chunks;
+	struct page **pages;
+	u32 size;
+	u32 chunk_cnt;
+	u32 gpadl_handle;
+	bool leak;
+};
+
 struct vmbus_channel {
 	struct list_head listentry;
 
@@ -1232,25 +1241,16 @@ extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 				     u32 bufferlen,
 				     u64 requestid);
 
-extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
-				      void *kbuffer,
-				      u32 size,
-				      struct vmbus_gpadl *gpadl);
-
-extern int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
-						  void *kbuffer,
-						  u32 size,
-						  struct vmbus_gpadl *gpadl);
+int vmbus_establish_gpadl(struct vmbus_channel *channel,
+			  struct vmbus_buffer *buffer);
 
-extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
-				     struct vmbus_gpadl *gpadl);
+int vmbus_teardown_gpadl(struct vmbus_channel *channel,
+			 struct vmbus_buffer *buffer);
 
-extern void *vmbus_alloc_buffer(struct vmbus_channel *channel,
-				u32 size,
-				struct page ***chunks_out,
-				u32 *chunk_cnt_out);
+int vmbus_alloc_buffer(struct vmbus_channel *channel, u32 size,
+		       bool confidential, struct vmbus_buffer *buffer);
 
-extern void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt);
+void vmbus_free_buffer(struct vmbus_buffer *buffer);
 
 void vmbus_reset_channel_cb(struct vmbus_channel *channel);
 
-- 
2.43.0

