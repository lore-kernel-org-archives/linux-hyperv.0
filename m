Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451401;
	b=OGDyfVk/c/Hc0XjEc/pgvZWafN3mpnNACeJLNNZnXaEYbZOPY4zQQpXaN6uHfTh8s39s
	 hJha5mIj93r91KVuNiiwFasbZQWqamwN13pJQ1kfC24RKt3mOJ1bCFPgxADiZy3Luw2CP
	 f9ZUfKFA3bvaDFiBEkdI6cLFNbFWBrkmS/b4FA4yFfNhAe7oeYbQCqD9YI+C4dNincR6a
	 JJL3ppSva92lgvLFg2P6Z/6OHwye+xeY++Z7nYXsf5Vt3NINRT4zH8r8saIVmf2AyXNd8
	 EVxjjBinVK2tQLm4qqa8nQoqVnc6FLs0Z9gqOIx+vBhhwqzo5uzdmGMSBjf0LRJh6XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451401;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=pUtG0UPjbgb9XOyaniYxfylvUw/fxSavKKfw3owmOro=;
	b=ZJZn6qhveauv/EVZeBg5IUoUGz6xGqf5v9MJym2f6wTNcVgymI8StJZafE4CbYKdSDv1
	 4WKYzhve1YDDB5H/yBajAtdYymZJErzPuVMpuPbnAfvjuNgn09Tmg6yI5HL6GrlATF+d6
	 oV41s8/ruvGf/lbqitgWsP0ZFPLuQ+Xe0QHvc4ahbX90YqfDB9uwmwOKv+3yhbr+SWBOf
	 dOWGUjqsDtKUh7+zWSUIIw6wEZHGyF+MTGEvRcIab5KC1CSLvfPr6bUaduBq5vZkIm9lo
	 F+j/YSm8Q0F8l0wfddCQSBOI6nlg7hOyAvstUDdaQkOdo1swdI36uzMUopy0Op/5irg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RNUaoyfL;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B0606A31E;
	Mon, 19 Oct 2026 23:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B63B0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RNUaoyfL
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9BEDC20B716D;
	Mon, 19 Oct 2026 16:09:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BEDC20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792451393;
	bh=pUtG0UPjbgb9XOyaniYxfylvUw/fxSavKKfw3owmOro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNUaoyfL8sZ+oFN7dtEdrlQ1nTaG7vwjkSC/6d8QjjbRS6iz0Qj7/lgtH1If+mnpb
	 p3DjEQPWAz4zOOlcqRiWDTB2b5aDXCfw5JjxKkSaoJSSPj4VYLNQdxgWh300UKFDNC
	 9z8t+b7Y9QpFVlnlk96PuiNX59KoZIZF2hdpIXls=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] Drivers: hv: vmbus: Use *_ONCE() to access shared ring buffer indices
Date: Mon, 19 Oct 2026 16:09:47 -0700
Message-ID: <20261019230950.1573677-3-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
References: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
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

The ring buffer read/write indices live in a page shared with the host,
so the compiler must not split, merge or refetch accesses to them. Add
READ_ONCE()/WRITE_ONCE() in hv_set_next_write_location(),
hv_pkt_iter_close(), hv_get_bytes_to_read() and hv_get_bytes_to_write().
The accesses in hv_ringbuffer_get_debuginfo() are left to the next
patch.

Drop hv_get_ring_bufferindices(). It has one caller and is a one-line
expression on the write index. Inlining it moves the access to the call
site, so hv_ringbuffer_write() can reuse its validated snapshot of that
index, old_write, rather than reading the shared memory a second time.

No functional change intended for a well-behaved host.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/hv/ring_buffer.c | 15 ++++-----------
 include/linux/hyperv.h   |  4 ++--
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index a18b309c..7f466c5 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -75,7 +75,7 @@ static inline void
 hv_set_next_write_location(struct hv_ring_buffer_info *ring_info,
 		     u32 next_write_location)
 {
-	ring_info->ring_buffer->write_index = next_write_location;
+	WRITE_ONCE(ring_info->ring_buffer->write_index, next_write_location);
 }
 
 /* Get the size of the ring buffer. */
@@ -85,13 +85,6 @@ hv_get_ring_buffersize(const struct hv_ring_buffer_info *ring_info)
 	return ring_info->ring_datasize;
 }
 
-/* Get the read and write indices as u64 of the specified ring buffer. */
-static inline u64
-hv_get_ring_bufferindices(struct hv_ring_buffer_info *ring_info)
-{
-	return (u64)ring_info->ring_buffer->write_index << 32;
-}
-
 /*
  * Helper routine to copy from source to ring buffer.
  * Assume there is enough room. Handles wrap-around in dest case only!!
@@ -358,7 +351,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 		*trans_id = __trans_id;
 
 	/* Set previous packet start */
-	prev_indices = hv_get_ring_bufferindices(outring_info);
+	prev_indices = (u64)old_write << 32;
 
 	next_write_location = hv_copyto_ringbuffer(outring_info,
 					     next_write_location,
@@ -582,8 +575,8 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	 * is updated.
 	 */
 	virt_rmb();
-	start_read_index = rbi->ring_buffer->read_index;
-	rbi->ring_buffer->read_index = rbi->priv_read_index;
+	start_read_index = READ_ONCE(rbi->ring_buffer->read_index);
+	WRITE_ONCE(rbi->ring_buffer->read_index, rbi->priv_read_index);
 
 	/*
 	 * Older versions of Hyper-V (before WS2102 and Win8) do not
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9e109d9..5c65820 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -214,7 +214,7 @@ static inline u32 hv_get_bytes_to_read(const struct hv_ring_buffer_info *rbi)
 	u32 read_loc, write_loc, dsize, read;
 
 	dsize = rbi->ring_datasize;
-	read_loc = rbi->ring_buffer->read_index;
+	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
 
 	read = write_loc >= read_loc ? (write_loc - read_loc) :
@@ -229,7 +229,7 @@ static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
 
 	dsize = rbi->ring_datasize;
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
-	write_loc = rbi->ring_buffer->write_index;
+	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
 
 	write = write_loc >= read_loc ? dsize - (write_loc - read_loc) :
 		read_loc - write_loc;

-- 
2.45.4
