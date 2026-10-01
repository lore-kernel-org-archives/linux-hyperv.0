Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD03F1068;
	Thu,  1 Oct 2026 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892695; cv=none; b=p31Z9h5wRDDtoD39RxTMd2yR9ptgsKkOsi4dfxA8cRsWRoHGOWWNdghURltmCWze9ekHD1gAhvmLUWkH6SBpbF62Hqr3p6ZFXPQ3xZFFaNnlbJpXfGb4DUnovFGcv3UqitpmZV+5XUH+ZzOvuFH01ZzroQvEn1euEhRl+SgtqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892695; c=relaxed/simple;
	bh=i7ohgqwxsWy6X4DB7Az39PV8OHcEwsWSJNVSjqnXyUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JibBYj1rB6rchzBvnN0Htkr/rQaZ0vZPCCl73hE9pIfPNfowwYis8L0AM1khaBQWWmmcNOyHhaiEc8iBJ8YJNoojFiVXujQOuEvagC6ggPn6Gxncc3d8XcjZ2kLoipUN5fv1xnH5/Nn4G+VNqNut7tIZp2OTZDI/Xht+F1TeTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RDwCEokr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RDwCEokr"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E33E20B716F;
	Thu,  1 Oct 2026 15:10:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E33E20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790892641;
	bh=LrNyjlCJcVrvESBHaquzjKxXPJNBrscKd5uyNqw7ehI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDwCEokrsTFz782PWA7TtYT4++P3ixmMfdFDzxzVUAwOozsbFgxqHbaZ/i7KFBisW
	 yKkaCUKmeShwdz2ftDpov8nf5BN9XVTuTnQFo2nsRUAqmlNdv3SYjmdcQFdMZ6m7Ci
	 BZBENJ2WqYYV1Juo7sjsNwBv+6F0BC6P3vp0/f/k=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Drivers: hv: vmbus: Annotate accesses to the shared ring buffer indices
Date: Thu,  1 Oct 2026 15:10:38 -0700
Message-ID: <20261001221040.1794904-3-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
References: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
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

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/hv/ring_buffer.c | 15 ++++-----------
 include/linux/hyperv.h   |  4 ++--
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index a18b309..7f466c5 100644
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
