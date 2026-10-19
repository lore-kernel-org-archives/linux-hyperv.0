Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451405;
	b=NXiABks8b89lLZxsl/dEJTktVWyK/l2BMNnqEus0vzlOwMK/e3mTDZVczS44GQMg/K0N
	 D3Fhybbk4bgoxy4leFXR0Ph9QWGMZxhUFsv1dXq31F8MC5DDwJd8czg2cscOY6Huw1rKg
	 TO330GIG3QhkNrHFmwNEtGfYG8qF3k9pZF9HOP2yzJOXwCjRKDm6oINObQ1x5BPlahp0H
	 qNG/ev7nIuBju4hH3WG1aTvCXOPLxUFNJwj7IZEczO5N9jIMtKBgVfzugYsusC5KL6H5f
	 5EzhEgWQ1i0FAW6STPND7VGRMyZzEDQY7gx7+BKHbZabLszhaaAreALcb5ZoobQYP4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451405;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=euImZm62ogtAGWAfFy17KrdQNvsi9UasxMLHFQ4WlK0=;
	b=4lWAkufz6i0vl4fNQwFoCpsJgzRnAozKPfhvU7KbaZ47VKyL9knfVGKW0kVTI5iW2bjP
	 Wfa4TOV+AwGaIsPdDeOhZxfAFSUTT/pSYh8EIePJyFjY/r2KsmMOYj50c92qXkcXAAMzO
	 KYLTla4YUfAWWyovqsgx6920bNI8fWod4fMBr3vBqmvoUPWN+w64T/rAfFtn03uesxWRK
	 BXzPg0XXVrl0kpF4xw7mVQjmpQtyQLz0Rg/QiagT+PwHKIKNo9dpujxxMieCjPGg8WR7U
	 6svGfpV39KwjN+KqwXSjBvQYD3f32KWEZhcSbfFffMaQNfSSd/IFuEdo9fIH8HUUkcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BEtjhT9h;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509BB606A31B;
	Mon, 19 Oct 2026 23:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 509BB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BEtjhT9h
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 311D120B716C;
	Mon, 19 Oct 2026 16:09:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 311D120B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792451393;
	bh=euImZm62ogtAGWAfFy17KrdQNvsi9UasxMLHFQ4WlK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEtjhT9h+5Hoc2nvUL8Voi3IY3L/AbYmAHbzv8FpTjyw6oCcBHNS/uptcPoyJUfre
	 c4yBhMijJcHEwhjoEcy66gqyivY78aoYAxOugOUrxJrBVFUGTIBd8sQm1EVny2ocWC
	 Bc/eJWMGNkwnq16xV/1QRG92109mGtp7pExrsY8Y=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] Drivers: hv: vmbus: Bounds check the shared ring buffer indices
Date: Mon, 19 Oct 2026 16:09:46 -0700
Message-ID: <20261019230950.1573677-2-kameroncarr@linux.microsoft.com>
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

In a CoCo VM the host is untrusted. Since the VMBus ring buffer read and
write indices live in shared memory, the guest has to treat both as
potentially malicious.

hv_ringbuffer_write() copies into the ring at write_index with no bounds
checking, so the host can make the guest write packet data at any offset
up to 4 GiB past the start of the ring buffer. read_index matters too:
the available space derived from both indices is the only bound on how
much is copied, and an out-of-range index can make it far larger than
the ring.

The fix is to validate both indices before use and to use the validated
snapshot instead of re-accessing. For invalid indices,
hv_ringbuffer_write() logs and returns -EIO.

One re-read of write_index is left unchecked in this patch:
hv_get_ring_bufferindices() fetches it again for the prev_indices
trailer. The value is only returned to the host and is not used as an
offset or length for indexing. Since this is not a security issue, it is
addressed later in the series.

Open-coding the bytes available arithmetic keeps the fix free of
prerequisites; a later patch refactors it into a helper function.

Fixes: 3e7ee4902fe6 ("Staging: hv: add the Hyper-V virtual bus")
Cc: <stable@vger.kernel.org> # 5.15.x
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
The unchecked write goes back to the commit in the Fixes tag, but the
host is only untrusted in CoCo VMs, which Linux has supported since
v5.12, so the stable tag starts at 5.15.x. This applies as-is to v5.15
and later.

 drivers/hv/ring_buffer.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 592a960..a18b309c 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -70,15 +70,6 @@ static void hv_signal_on_write(u32 old_write, struct vmbus_channel *channel)
 	}
 }
 
-/* Get the next write location for the specified ring buffer. */
-static inline u32
-hv_get_next_write_location(struct hv_ring_buffer_info *ring_info)
-{
-	u32 next = ring_info->ring_buffer->write_index;
-
-	return next;
-}
-
 /* Set the next write location for the specified ring buffer. */
 static inline void
 hv_set_next_write_location(struct hv_ring_buffer_info *ring_info,
@@ -281,6 +272,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	u32 totalbytes_towrite = sizeof(u64);
 	u32 next_write_location;
 	u32 old_write;
+	u32 read_index;
 	u64 prev_indices;
 	unsigned long flags;
 	struct hv_ring_buffer_info *outring_info = &channel->outbound;
@@ -295,7 +287,20 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 
 	spin_lock_irqsave(&outring_info->ring_lock, flags);
 
-	bytes_avail_towrite = hv_get_bytes_to_write(outring_info);
+	read_index = READ_ONCE(outring_info->ring_buffer->read_index);
+	old_write = READ_ONCE(outring_info->ring_buffer->write_index);
+	if (unlikely(read_index >= outring_info->ring_datasize ||
+		     old_write >= outring_info->ring_datasize)) {
+		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
+		pr_err_ratelimited("outbound ring indices out of range: relid %u read %u write %u size %u\n",
+				   channel->offermsg.child_relid, read_index,
+				   old_write, outring_info->ring_datasize);
+		return -EIO;
+	}
+
+	bytes_avail_towrite = old_write >= read_index ?
+		outring_info->ring_datasize - (old_write - read_index) :
+		read_index - old_write;
 
 	/*
 	 * If there is only room for the packet, assume it is full.
@@ -317,9 +322,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	channel->out_full_flag = false;
 
 	/* Write to the ring buffer */
-	next_write_location = hv_get_next_write_location(outring_info);
-
-	old_write = next_write_location;
+	next_write_location = old_write;
 
 	for (i = 0; i < kv_count; i++) {
 		next_write_location = hv_copyto_ringbuffer(outring_info,

-- 
2.45.4
