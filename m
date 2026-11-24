Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556453;
	b=mU0eTl/un/0IJEQJZdPR62XnmHp0LlAvfr9GGwLLffZ9islutd0gYUF4V+k5Ro7lX7vK
	 3u/YPkwIH7JhcAfEi7dtV9BzQZrkw+Lp4g2qyBPuZ6+rF22twHSdJhj4hC6HiQnbAzHIt
	 orsGJrj5sLfRy/FloRYB/X3xBz3L7ei251YUDGKAXqIVnEagXD81sFjD3+1d2+CerHsLW
	 zG53GSu0hhZw620k0pu1bKSnSfp0Yj3V1cMMCCM4qauXcsDxxkD0z8X6rCwTdq5IQf7c4
	 gxdjhUNCbXvxpyC4eh3Wk65liQzuOFD47z1wZfgSkgu62njvkxi6+jSnR5BTGmg8f6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AtBMwMn9ReQWweMu+z6BuwRBfjYxZFbbaT5jYKInjC4=;
	b=V1oJqOG0AzALrqAxOFLkm3rzamNaXfcMrx7e7+fYhhy16cUdQ1XuUsLzA51yMHqNE/G+
	 l0staOy43iUKrFNlSH6Z92PomJI3qBHRJdpLPvaE/BF4NsjpRz/QaHoUICxvDz74hlXzT
	 ixkTyPQ2lMvRDn2IvpAPsucJCDGQnJFAU18ZY2rMguvMVpwNzuk94iGAn5ha+jEmYuBBG
	 uCxIEqf9ca0vylMSZAB48Og4xul4gPU5XVZAMXx1QdQmZn7f8pQyfzMF44RNJF1Lhxq5p
	 AR56HmwajFkrnjJZtGYiwOx2bc9O5acrSJUPRljuJTIAKnzLyKz1ssYVcZIPjZxt59w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NT1e1qqY;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1764606A689
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 21:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1764606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NT1e1qqY
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso3125427137.3
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556452; x=1796161252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AtBMwMn9ReQWweMu+z6BuwRBfjYxZFbbaT5jYKInjC4=;
        b=NT1e1qqYe1psKpQOJUZD2ze4vXoGnnnsJDE7mrhYFXegr/RmZFPIX4LHGXYcV7YDez
         i4hEZH02eSY1uXCjDd0moNbN248LsKWlVDaOlzBnxY7I+DAByKfS2QQPk4F6IRPl4m4q
         q6OzLFXbydmpMCMpZyy3Ixoo4FRyEnziCxrlc0DnD3gfdlH9XW/zhWt63ZYtS5YCaOpt
         2g+8RrGzg0I7gU9EpTUSmOYjmwHAD9iQNzigZMC9JF0Q7ZF/hGzURcG0vJQF1jSnybae
         yARsszryMV0cCeC2wqwGkB3SditWLNSZI1TNdmmgYoHAuwgRzj6au0msK2pE2pL2UH/h
         avvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556452; x=1796161252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AtBMwMn9ReQWweMu+z6BuwRBfjYxZFbbaT5jYKInjC4=;
        b=mc9dRhfBkNJ4j/jdtfedY04B/4IvLuCk06dJiQRBqocuwVTfhQfZU73+bxZabyoLex
         5TbFMAdJfN+ThdqIu6rRPSOL6moYiuexYH1CEs6hPaU8wWq8PFrzh9WXq6Rm1d0ptce8
         s7oyZpq5y7XLIRGP0U6FCKkhyX4rQres9kakGcx+0Ut9xljxWpwdGgwYLbTRnhTTwyZC
         X0xo8yUKZ7Bade9Eirk5nxv+kJPEcy4yQjUxxT9HktGx7wePnJ8LvblGc52f9v0FGjzc
         ugu8gt+qlwe67DX6mFGh20GT3+isod7DxXosWghLB19wY2TRtTtwYY+5oJm6ADKIWieK
         J6TA==
X-Forwarded-Encrypted: i=1; AL+hErESB+6oLWoRmENFv74P9qp1N9+qaIHEydLQAr4i79wNn6HAckm4uRditgyYQMqSkj5dikFX41RheBRm3+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LtvVIQOwX5Mf+g2fIzHRfyV3zMHW/TQlCAkv70IWW2L2U8Vjx
	PrU1jYhxDd5x7eujL+JvE0KoMDgFVOEviDh07A0d42yFmr0kteu8c+jm
X-Gm-Gg: AZFdTZfbxEvVYHZ55RT9Rj8wPZDWdEWQLHJC8x9PHpqIqhaj4QhMs1Dfbk/Hd0d0XLx
	S3bxMMk5sIZ2XxYT3RNJpeU54KdNjPFQlW9EfVO9K/aFPIL7i3NcJIWFDFDngHM7Rt/HEUoMis4
	HSTZfu11QMwqVJoTuKBIRn19GaCcZs/MCp33GjUKb8+2c24Ii6Ka8rWhLRM9yzRkjXu5Lpovt3G
	gua8YP/Qe4u6dGzhjv9ZJCn4DIoxN3b1HK2n2UijtxS1A/XEQZHziP7YL49GoVeqPpxlosnFMKS
	+BInsTOArHFcwFjsFu/qr0N0VHApdP3d/EFhfRh4hXPHxa9CnBfsSSqEj+DfCyqqrpBwS9iiArO
	fYcQpO1zOKtxEDeQnnu6qAvR+CnVyTaTPU+VStJ+QT4ALEXrk4uMxDwT4JUE1NdIfZMRQayIP3X
	YdbMgQ4do0b4ttdux71gpFktzDvpBeKY8OyVqoVdKyOgi2YrLKPplj9A/3XKcMUOOybBAmo1bYp
	v19qiIXwnatZsXulAxmPRiq9QEC9e85KGVIUJSrouYKDJHHVNgbpAsXzgSq4aQ/w/pMAwxoJjPv
	eV8S2/piJoIWHzjW5ZpukeAgP0auYarkjRsIp/H9TwPirDgthD95
X-Received: by 2002:a05:6102:26d3:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d739460f96mr8530064137.18.1795556451650;
        Tue, 24 Nov 2026 13:40:51 -0800 (PST)
Received: from emedev.tailf75c28.ts.net ([179.238.117.100])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec57ddsm15952879241.1.2026.11.24.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:40:51 -0800 (PST)
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
Subject: [PATCH v3 2/3] hv: vmbus: allocate ring buffers via vmbus_alloc_buffer()
Date: Tue, 24 Nov 2026 18:40:28 -0300
Message-ID: <20261124214030.174246-3-emersonbusson@gmail.com>
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

vmbus_alloc_ring() allocates both ring buffers as a single high-order
contiguous block via alloc_pages_node() (e.g., order-7 for a 512 KiB
ring). Under physical memory fragmentation, opening new channels or
subchannels fails with -ENOMEM even when plenty of order-0 pages remain
available.

Allocate ring buffers through vmbus_alloc_buffer() using
channel->co_ring_buffer and embed struct vmbus_buffer directly in
struct vmbus_channel. Ordinary and confidential rings use
vzalloc_node(), while host-visible rings in isolated guests (SNP, TDX,
and CCA) use the chunked direct-map decryption and vmap() path.

Update hv_ringbuffer_init() to take the ring's struct page array and
use kvcalloc()/kvzalloc() for its wraparound page table and packet copy
buffer. Update uio_hv_generic to map non-contiguous ring pages via
mmap_action_map_kernel_pages() (with pgprot_decrypted() for shared
rings) and UIO_MEM_VIRTUAL.

With all GPADL callers now allocating and decrypting buffers through
vmbus_alloc_buffer(), drop struct vmbus_gpadl and remove the duplicate
set_memory_decrypted()/set_memory_encrypted() handling from GPADL
establishment and teardown.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c         | 206 ++++++++++++-----------------------
 drivers/hv/hyperv_vmbus.h    |   4 +-
 drivers/hv/ring_buffer.c     |  17 +--
 drivers/uio/uio_hv_generic.c |  32 +++---
 include/linux/hyperv.h       |  13 +--
 5 files changed, 98 insertions(+), 174 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 9807ff35a1..c0bf154915 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/log2.h>
 #include <linux/module.h>
@@ -154,15 +155,7 @@ void vmbus_free_ring(struct vmbus_channel *channel)
 {
 	hv_ringbuffer_cleanup(&channel->outbound);
 	hv_ringbuffer_cleanup(&channel->inbound);
-
-	if (channel->ringbuffer_page) {
-		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
-		if (!channel->ringbuffer_gpadlhandle.decrypted)
-			__free_pages(channel->ringbuffer_page,
-			     get_order(channel->ringbuffer_pagecount
-				       << PAGE_SHIFT));
-		channel->ringbuffer_page = NULL;
-	}
+	vmbus_free_buffer(&channel->ringbuffer);
 }
 EXPORT_SYMBOL_GPL(vmbus_free_ring);
 
@@ -170,25 +163,33 @@ EXPORT_SYMBOL_GPL(vmbus_free_ring);
 int vmbus_alloc_ring(struct vmbus_channel *newchannel,
 		     u32 send_size, u32 recv_size)
 {
-	struct page *page;
-	int order;
+	struct vmbus_buffer *buffer = &newchannel->ringbuffer;
+	u32 size, page_cnt, i;
+	int ret;
 
-	if (send_size % PAGE_SIZE || recv_size % PAGE_SIZE)
+	if (!send_size || !recv_size ||
+	    send_size % PAGE_SIZE || recv_size % PAGE_SIZE ||
+	    check_add_overflow(send_size, recv_size, &size))
 		return -EINVAL;
 
-	/* Allocate the ring buffer */
-	order = get_order(send_size + recv_size);
-	page = alloc_pages_node(cpu_to_node(newchannel->target_cpu),
-				GFP_KERNEL|__GFP_ZERO, order);
-
-	if (!page)
-		page = alloc_pages(GFP_KERNEL|__GFP_ZERO, order);
+	ret = vmbus_alloc_buffer(newchannel, size, newchannel->co_ring_buffer,
+				 buffer);
+	if (ret)
+		return ret;
 
-	if (!page)
+	page_cnt = size >> PAGE_SHIFT;
+	buffer->pages = kvcalloc(page_cnt, sizeof(*buffer->pages), GFP_KERNEL);
+	if (!buffer->pages) {
+		vmbus_free_buffer(buffer);
 		return -ENOMEM;
+	}
+
+	for (i = 0; i < page_cnt; i++)
+		buffer->pages[i] =
+			vmalloc_to_page(buffer->addr +
+					((unsigned long)i << PAGE_SHIFT));
 
-	newchannel->ringbuffer_page = page;
-	newchannel->ringbuffer_pagecount = (send_size + recv_size) >> PAGE_SHIFT;
+	newchannel->ringbuffer_pagecount = page_cnt;
 	newchannel->ringbuffer_send_offset = send_size >> PAGE_SHIFT;
 
 	return 0;
@@ -432,17 +433,14 @@ static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
  *
  * @channel: a channel
  * @type: the type of the corresponding GPADL, only meaningful for the guest.
- * @kbuffer: from kmalloc or vmalloc
- * @size: page-size multiple
+ * @buffer: buffer allocated with vmbus_alloc_buffer()
  * @send_offset: the offset (in bytes) where the send ring buffer starts,
- *              should be 0 for BUFFER type gpadl
- * @gpadl_handle: some funky thing
+ *               should be 0 for BUFFER type gpadl
  */
 static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
-				   enum hv_gpadl_type type, void *kbuffer,
-				   u32 size, u32 send_offset,
-				   bool caller_decrypted, u32 *gpadl_handle,
-				   bool *decrypted, bool *leak)
+				   enum hv_gpadl_type type,
+				   struct vmbus_buffer *buffer,
+				   u32 send_offset)
 {
 	struct vmbus_channel_gpadl_header *gpadlmsg;
 	struct vmbus_channel_gpadl_body *gpadl_body;
@@ -452,42 +450,17 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	u32 next_gpadl_handle;
 	unsigned long flags;
 	bool posted = false;
-	bool need_decrypt;
 	int ret = 0;
 
-	if (leak)
-		*leak = false;
+	buffer->leak = false;
 
 	next_gpadl_handle =
 		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
 
-	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
-	if (ret) {
-		if (decrypted)
-			*decrypted = false;
+	ret = create_gpadl_header(type, buffer->addr, buffer->size,
+				  send_offset, &msginfo);
+	if (ret)
 		return ret;
-	}
-
-	need_decrypt = !caller_decrypted &&
-		!((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
-		  (channel->co_ring_buffer && type == HV_GPADL_RING));
-	if (decrypted)
-		*decrypted = need_decrypt;
-	if (need_decrypt) {
-		/*
-		 * If set_memory_decrypted() fails, the encryption state is
-		 * unknown; leave *decrypted true so the memory is leaked.
-		 */
-		ret = set_memory_decrypted((unsigned long)kbuffer,
-					   PFN_UP(size));
-		if (ret) {
-			dev_warn(&channel->device_obj->device,
-				 "Failed to set host visibility for new GPADL %d.\n",
-				 ret);
-			vmbus_free_channel_msginfo(msginfo);
-			return ret;
-		}
-	}
 
 	init_completion(&msginfo->waitevent);
 	msginfo->waiting_channel = channel;
@@ -552,7 +525,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	}
 
 	/* At this point, we received the gpadl created msg */
-	*gpadl_handle = gpadlmsg->gpadl;
+	buffer->gpadl_handle = gpadlmsg->gpadl;
 	posted = false;
 
 cleanup:
@@ -562,14 +535,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 	vmbus_free_channel_msginfo(msginfo);
 
-	if (ret && posted && leak)
-		*leak = true;
-
-	if (ret && !posted && need_decrypt) {
-		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)) &&
-		    decrypted)
-			*decrypted = false;
-	}
+	if (ret && posted)
+		buffer->leak = true;
 
 	return ret;
 }
@@ -587,10 +554,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 int vmbus_establish_gpadl(struct vmbus_channel *channel,
 			  struct vmbus_buffer *buffer)
 {
-	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, buffer->addr,
-				       buffer->size, 0U, true,
-				       &buffer->gpadl_handle, NULL,
-				       &buffer->leak);
+	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, buffer, 0U);
 }
 EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
 
@@ -824,17 +788,13 @@ static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
 	bitmap_free(rqstor->req_bitmap);
 }
 
-static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
-				  u32 *gpadl_handle, void *kbuffer,
-				  u32 size, bool *decrypted, bool *leak);
-
 static int __vmbus_open(struct vmbus_channel *newchannel,
 		       void *userdata, u32 userdatalen,
 		       void (*onchannelcallback)(void *context), void *context)
 {
 	struct vmbus_channel_open_channel *open_msg;
 	struct vmbus_channel_msginfo *open_info = NULL;
-	struct page *page = newchannel->ringbuffer_page;
+	struct vmbus_buffer *buffer = &newchannel->ringbuffer;
 	u32 send_pages, recv_pages;
 	unsigned long flags;
 	int err;
@@ -842,6 +802,10 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (userdatalen > MAX_USER_DEFINED_BYTES)
 		return -EINVAL;
 
+	if (!buffer->addr || !buffer->pages || buffer->leak ||
+	    buffer->gpadl_handle)
+		return -EINVAL;
+
 	send_pages = newchannel->ringbuffer_send_offset;
 	recv_pages = newchannel->ringbuffer_pagecount - send_pages;
 
@@ -862,29 +826,21 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 		newchannel->max_pkt_size = VMBUS_DEFAULT_MAX_PKT_SIZE;
 
 	/* Establish the gpadl for the ring buffer */
-	newchannel->ringbuffer_gpadlhandle.gpadl_handle = 0;
-
-	err = __vmbus_establish_gpadl(newchannel, HV_GPADL_RING,
-				      page_address(newchannel->ringbuffer_page),
-				      (send_pages + recv_pages) << PAGE_SHIFT,
-				      newchannel->ringbuffer_send_offset << PAGE_SHIFT,
-				      false,
-				      &newchannel->ringbuffer_gpadlhandle.gpadl_handle,
-				      &newchannel->ringbuffer_gpadlhandle.decrypted,
-				      NULL);
+	buffer->gpadl_handle = 0;
+
+	err = __vmbus_establish_gpadl(newchannel, HV_GPADL_RING, buffer,
+				      newchannel->ringbuffer_send_offset << PAGE_SHIFT);
 	if (err)
 		goto error_clean_ring;
-	newchannel->ringbuffer_gpadlhandle.buffer =
-		page_address(newchannel->ringbuffer_page);
-	newchannel->ringbuffer_gpadlhandle.size =
-		(send_pages + recv_pages) << PAGE_SHIFT;
 
 	err = hv_ringbuffer_init(&newchannel->outbound,
-				 page, send_pages, 0, newchannel->co_ring_buffer);
+				 buffer->pages, send_pages, 0,
+				 newchannel->co_ring_buffer);
 	if (err)
 		goto error_free_gpadl;
 
-	err = hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
+	err = hv_ringbuffer_init(&newchannel->inbound,
+				 buffer->pages + send_pages,
 				 recv_pages, newchannel->max_pkt_size,
 				 newchannel->co_ring_buffer);
 	if (err)
@@ -906,8 +862,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	open_msg->header.msgtype = CHANNELMSG_OPENCHANNEL;
 	open_msg->openid = newchannel->offermsg.child_relid;
 	open_msg->child_relid = newchannel->offermsg.child_relid;
-	open_msg->ringbuffer_gpadlhandle
-		= newchannel->ringbuffer_gpadlhandle.gpadl_handle;
+	open_msg->ringbuffer_gpadlhandle = buffer->gpadl_handle;
 	/*
 	 * The unit of ->downstream_ringbuffer_pageoffset is HV_HYP_PAGE and
 	 * the unit of ->ringbuffer_send_offset (i.e. send_pages) is PAGE, so
@@ -965,12 +920,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 error_free_info:
 	kfree(open_info);
 error_free_gpadl:
-	__vmbus_teardown_gpadl(newchannel,
-			       &newchannel->ringbuffer_gpadlhandle.gpadl_handle,
-			       newchannel->ringbuffer_gpadlhandle.buffer,
-			       newchannel->ringbuffer_gpadlhandle.size,
-			       &newchannel->ringbuffer_gpadlhandle.decrypted,
-			       NULL);
+	vmbus_teardown_gpadl(newchannel, buffer);
 error_clean_ring:
 	hv_ringbuffer_cleanup(&newchannel->outbound);
 	hv_ringbuffer_cleanup(&newchannel->inbound);
@@ -1013,20 +963,24 @@ int vmbus_open(struct vmbus_channel *newchannel,
 }
 EXPORT_SYMBOL_GPL(vmbus_open);
 
-static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
-				  u32 *gpadl_handle, void *kbuffer,
-				  u32 size, bool *decrypted, bool *leak)
+/*
+ * vmbus_teardown_gpadl - Teardown the specified GPADL handle
+ */
+int vmbus_teardown_gpadl(struct vmbus_channel *channel,
+			 struct vmbus_buffer *buffer)
 {
 	struct vmbus_channel_gpadl_teardown *msg;
 	struct vmbus_channel_msginfo *info;
 	unsigned long flags;
 	int ret = 0;
 
+	if (!buffer->gpadl_handle)
+		return 0;
+
 	info = kzalloc(sizeof(*info) +
 		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
 	if (!info) {
-		if (leak)
-			*leak = true;
+		buffer->leak = true;
 		return -ENOMEM;
 	}
 
@@ -1037,7 +991,7 @@ static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
 
 	msg->header.msgtype = CHANNELMSG_GPADL_TEARDOWN;
 	msg->child_relid = channel->offermsg.child_relid;
-	msg->gpadl = *gpadl_handle;
+	msg->gpadl = buffer->gpadl_handle;
 
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_add_tail(&info->msglistentry,
@@ -1072,34 +1026,12 @@ static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
 	kfree(info);
 
 	if (!ret)
-		*gpadl_handle = 0;
-	else if (leak)
-		*leak = true;
-
-	if (!ret && decrypted && *decrypted) {
-		ret = set_memory_encrypted((unsigned long)kbuffer,
-					   PFN_UP(size));
-		if (ret)
-			pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n",
-				ret);
-		*decrypted = !!ret;
-	}
+		buffer->gpadl_handle = 0;
+	else
+		buffer->leak = true;
 
 	return ret;
 }
-
-/*
- * vmbus_teardown_gpadl - Teardown the specified GPADL handle
- */
-int vmbus_teardown_gpadl(struct vmbus_channel *channel,
-			 struct vmbus_buffer *buffer)
-{
-	if (!buffer->gpadl_handle)
-		return 0;
-
-	return __vmbus_teardown_gpadl(channel, &buffer->gpadl_handle,
-				      NULL, 0, NULL, &buffer->leak);
-}
 EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
 
 void vmbus_reset_channel_cb(struct vmbus_channel *channel)
@@ -1164,6 +1096,7 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 	trace_vmbus_close_internal(msg, ret);
 
 	if (ret) {
+		channel->ringbuffer.leak = true;
 		pr_err("Close failed: close post msg return is %d\n", ret);
 		/*
 		 * If we failed to post the close msg,
@@ -1172,13 +1105,8 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 	}
 
 	/* Tear down the gpadl for the channel's ring buffer */
-	else if (channel->ringbuffer_gpadlhandle.gpadl_handle) {
-		ret = __vmbus_teardown_gpadl(channel,
-					     &channel->ringbuffer_gpadlhandle.gpadl_handle,
-					     channel->ringbuffer_gpadlhandle.buffer,
-					     channel->ringbuffer_gpadlhandle.size,
-					     &channel->ringbuffer_gpadlhandle.decrypted,
-					     NULL);
+	else if (channel->ringbuffer.gpadl_handle) {
+		ret = vmbus_teardown_gpadl(channel, &channel->ringbuffer);
 		if (ret) {
 			pr_err("Close failed: teardown gpadl return %d\n", ret);
 			/*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 33923621a5..98eacd737f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -204,8 +204,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
 
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
-			   bool confidential);
+		       struct page **pages, u32 pagecnt, u32 max_pkt_size,
+		       bool confidential);
 
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index d8b085dfdb..15abab9a9a 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -146,8 +146,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 
 /* Initialize the ring buffer. */
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
-			   bool confidential)
+		       struct page **pages, u32 page_cnt, u32 max_pkt_size,
+		       bool confidential)
 {
 	struct page **pages_wraparound;
 	int i;
@@ -158,20 +158,21 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 	 * First page holds struct hv_ring_buffer, do wraparound mapping for
 	 * the rest.
 	 */
-	pages_wraparound = kzalloc_objs(struct page *, page_cnt * 2 - 1);
+	pages_wraparound = kvcalloc(page_cnt * 2 - 1, sizeof(*pages_wraparound),
+				    GFP_KERNEL);
 	if (!pages_wraparound)
 		return -ENOMEM;
 
-	pages_wraparound[0] = pages;
+	pages_wraparound[0] = pages[0];
 	for (i = 0; i < 2 * (page_cnt - 1); i++)
 		pages_wraparound[i + 1] =
-			&pages[i % (page_cnt - 1) + 1];
+			pages[i % (page_cnt - 1) + 1];
 
 	ring_info->ring_buffer = (struct hv_ring_buffer *)
 		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
 			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
 
-	kfree(pages_wraparound);
+	kvfree(pages_wraparound);
 	if (!ring_info->ring_buffer)
 		return -ENOMEM;
 
@@ -196,7 +197,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	/* Initialize buffer that holds copies of incoming packets */
 	if (max_pkt_size) {
-		ring_info->pkt_buffer = kzalloc(max_pkt_size, GFP_KERNEL);
+		ring_info->pkt_buffer = kvzalloc(max_pkt_size, GFP_KERNEL);
 		if (!ring_info->pkt_buffer)
 			return -ENOMEM;
 		ring_info->pkt_buffer_size = max_pkt_size;
@@ -215,7 +216,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 	ring_info->ring_buffer = NULL;
 	mutex_unlock(&ring_info->ring_buffer_mutex);
 
-	kfree(ring_info->pkt_buffer);
+	kvfree(ring_info->pkt_buffer);
 	ring_info->pkt_buffer = NULL;
 	ring_info->pkt_buffer_size = 0;
 }
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 9c6449c92a..09995cfb5b 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -27,6 +27,7 @@
 #include <linux/if_ether.h>
 #include <linux/skbuff.h>
 #include <linux/hyperv.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 
 #include "../hv/hyperv_vmbus.h"
@@ -147,19 +148,24 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 	vmbus_device_unregister(channel->device_obj);
 }
 
-/* Function used for mmap of ring buffer sysfs interface.
- * The ring buffer is allocated as contiguous memory by vmbus_open
- */
+/* Function used for mmap of the ring buffer sysfs interface. */
 static int
 hv_uio_ring_mmap_prepare(struct vmbus_channel *channel, struct vm_area_desc *desc)
 {
-	void *ring_buffer = page_address(channel->ringbuffer_page);
+	unsigned long pages = vma_desc_pages(desc);
+	pgoff_t offset = desc->pgoff;
 
-	if (channel->state != CHANNEL_OPENED_STATE)
+	if (channel->state != CHANNEL_OPENED_STATE || !channel->ringbuffer.pages)
 		return -ENODEV;
+	if (!pages || offset >= channel->ringbuffer_pagecount ||
+	    pages > channel->ringbuffer_pagecount - offset)
+		return -EINVAL;
+
+	if (!channel->co_ring_buffer)
+		desc->page_prot = pgprot_decrypted(desc->page_prot);
 
-	mmap_action_simple_ioremap(desc, virt_to_phys(ring_buffer),
-			channel->ringbuffer_pagecount << PAGE_SHIFT);
+	mmap_action_map_kernel_pages(desc, desc->start,
+				     channel->ringbuffer.pages + offset, pages);
 	return 0;
 }
 
@@ -245,7 +251,6 @@ hv_uio_probe(struct hv_device *dev,
 {
 	struct vmbus_channel *channel = dev->channel;
 	struct hv_uio_private_data *pdata;
-	void *ring_buffer;
 	int ret;
 	size_t ring_size = hv_dev_ring_size(channel);
 
@@ -276,12 +281,11 @@ hv_uio_probe(struct hv_device *dev,
 
 	/* mem resources */
 	pdata->info.mem[TXRX_RING_MAP].name = "txrx_rings";
-	ring_buffer = page_address(channel->ringbuffer_page);
-	pdata->info.mem[TXRX_RING_MAP].addr
-		= (uintptr_t)virt_to_phys(ring_buffer);
-	pdata->info.mem[TXRX_RING_MAP].size
-		= channel->ringbuffer_pagecount << PAGE_SHIFT;
-	pdata->info.mem[TXRX_RING_MAP].memtype = UIO_MEM_IOVA;
+	pdata->info.mem[TXRX_RING_MAP].addr =
+		(uintptr_t)channel->ringbuffer.addr;
+	pdata->info.mem[TXRX_RING_MAP].size =
+		channel->ringbuffer_pagecount << PAGE_SHIFT;
+	pdata->info.mem[TXRX_RING_MAP].memtype = UIO_MEM_VIRTUAL;
 
 	pdata->info.mem[INT_PAGE_MAP].name = "int_page";
 	pdata->info.mem[INT_PAGE_MAP].addr
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 17ad83d19a..41b9976945 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -808,13 +808,6 @@ struct vmbus_device {
 
 #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
 
-struct vmbus_gpadl {
-	u32 gpadl_handle;
-	u32 size;
-	void *buffer;
-	bool decrypted;
-};
-
 struct vmbus_buffer {
 	void *addr;
 	struct page **chunks;
@@ -844,10 +837,8 @@ struct vmbus_channel {
 	bool rescind_ref; /* got rescind msg, got channel reference */
 	struct completion rescind_event;
 
-	struct vmbus_gpadl ringbuffer_gpadlhandle;
-
-	/* Allocated memory for ring buffer */
-	struct page *ringbuffer_page;
+	/* Allocated memory and GPADL state for ring buffer */
+	struct vmbus_buffer ringbuffer;
 	u32 ringbuffer_pagecount;
 	u32 ringbuffer_send_offset;
 	struct hv_ring_buffer_info outbound;	/* send to parent */
-- 
2.43.0

