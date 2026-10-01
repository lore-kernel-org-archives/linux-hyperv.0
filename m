Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A613F8707;
	Thu,  1 Oct 2026 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892696; cv=none; b=fLG2kM4CWpRKovEIVKAGL7KO7EkXbHmsDQxC6R21zAondl/9Tg+UnKY5oVkJOgJ+1PuJRaSApALnP/F2r1eB6xvmS36rkezTUJInUqafNcsWtIU7SMpk3CCnr7ElGvS1I34dik+N2tfN3Hpdqb3zGfW2uOhkK4pnIhZzUVbo5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892696; c=relaxed/simple;
	bh=eqr9w/7TDzFz5BlJb4hGXHLi47k0+sqTi5KIfClTKLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvMrfJGJVZCgKNZiv15iI8JQ1Dy9tvRHLgnm13SXfHHTo/a927khrhFiSar2gEDo/sX6DlMhgtNnKM+CpHWvEm+oQo7FOPeSACLZOdiIbLV6vZpLBzyFW4ioarSMBwAy7xKlTi9XZKQzH7ILTGq/kjBvYSRf0ytOZiJZQ5d8ejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hbof5MK2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hbof5MK2"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEF0120B7170;
	Thu,  1 Oct 2026 15:10:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEF0120B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790892641;
	bh=jpW55JgtvPbYS0SGoV/0R49DIok9nprOnf04hTneruc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hbof5MK2h9loeAOiG4ZYlJSUpIr2rZVT6CTMEluJbYHhrRcw8Xh5G1UyYTaFSzq/3
	 EbPasmryQcBUFnCdbFj7xHtmrAwuF79lRgFvaSMcolror1MmRReX07zFMEJIK4H0GN
	 cM3mIyzE6xlB0l5H0fmvZwkrXd7hy4gfLMyiiERA=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Drivers: hv: vmbus: Compute ring byte counts from a caller-held snapshot
Date: Thu,  1 Oct 2026 15:10:39 -0700
Message-ID: <20261001221040.1794904-4-kameroncarr@linux.microsoft.com>
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

hv_get_ringbuffer_availbytes() reads the indices directly, so a caller
that also wants the index values has to read them a second time. The
host can change them in between, resulting in the byte counts and the
indices reflecting two different states of the ring.

Replace it with hv_ringbuffer_avail_write() and
hv_ringbuffer_avail_read(), which take the indices as arguments and
return a single count. They are separate because most callers want only
one of the two values. Use them in hv_ringbuffer_write() in place of the
open-coded equivalent. hv_get_bytes_to_read() and
hv_get_bytes_to_write() duplicated the same arithmetic, so put the
helpers in include/linux/hyperv.h and use them there too.

Add a hv_ringbuffer_index_valid() helper for bounds checking and use it
for the checks in hv_ringbuffer_write(). Convert the remaining callers
to use a single snapshot:

  - hv_ringbuffer_get_debuginfo() now reports the indices and the
    computed byte counts from the same snapshot.

  - hv_pkt_iter_close() computes the free space from priv_read_index
    instead of re-reading the shared read index. The two agree unless a
    misbehaving host has rewritten the value.

No functional change intended for a well-behaved host.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/hv/ring_buffer.c | 63 ++++++++++++++++--------------------------------
 include/linux/hyperv.h   | 48 +++++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 7f466c5..29edab9 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -107,35 +107,12 @@ static u32 hv_copyto_ringbuffer(
 	return start_write_offset;
 }
 
-/*
- *
- * hv_get_ringbuffer_availbytes()
- *
- * Get number of bytes available to read and to write to
- * for the specified ring buffer
- */
-static void
-hv_get_ringbuffer_availbytes(const struct hv_ring_buffer_info *rbi,
-			     u32 *read, u32 *write)
-{
-	u32 read_loc, write_loc, dsize;
-
-	/* Capture the read/write indices before they changed */
-	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
-	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
-	dsize = rbi->ring_datasize;
-
-	*write = write_loc >= read_loc ? dsize - (write_loc - read_loc) :
-		read_loc - write_loc;
-	*read = dsize - *write;
-}
-
 /* Get various debug metrics for the specified ring buffer. */
 int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
 				struct hv_ring_buffer_debug_info *debug_info)
 {
-	u32 bytes_avail_towrite;
-	u32 bytes_avail_toread;
+	u32 read_index;
+	u32 write_index;
 
 	mutex_lock(&ring_info->ring_buffer_mutex);
 
@@ -144,13 +121,14 @@ int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
 		return -EINVAL;
 	}
 
-	hv_get_ringbuffer_availbytes(ring_info,
-				     &bytes_avail_toread,
-				     &bytes_avail_towrite);
-	debug_info->bytes_avail_toread = bytes_avail_toread;
-	debug_info->bytes_avail_towrite = bytes_avail_towrite;
-	debug_info->current_read_index = ring_info->ring_buffer->read_index;
-	debug_info->current_write_index = ring_info->ring_buffer->write_index;
+	read_index = READ_ONCE(ring_info->ring_buffer->read_index);
+	write_index = READ_ONCE(ring_info->ring_buffer->write_index);
+	debug_info->bytes_avail_toread =
+		hv_ringbuffer_avail_read(ring_info, read_index, write_index);
+	debug_info->bytes_avail_towrite =
+		hv_ringbuffer_avail_write(ring_info, read_index, write_index);
+	debug_info->current_read_index = read_index;
+	debug_info->current_write_index = write_index;
 	debug_info->current_interrupt_mask
 		= ring_info->ring_buffer->interrupt_mask;
 	mutex_unlock(&ring_info->ring_buffer_mutex);
@@ -282,8 +260,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 
 	read_index = READ_ONCE(outring_info->ring_buffer->read_index);
 	old_write = READ_ONCE(outring_info->ring_buffer->write_index);
-	if (unlikely(read_index >= outring_info->ring_datasize ||
-		     old_write >= outring_info->ring_datasize)) {
+	if (unlikely(!hv_ringbuffer_index_valid(outring_info, read_index) ||
+		     !hv_ringbuffer_index_valid(outring_info, old_write))) {
 		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
 		pr_err_ratelimited("outbound ring indices out of range: relid %u read %u write %u size %u\n",
 				   channel->offermsg.child_relid, read_index,
@@ -291,9 +269,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 		return -EIO;
 	}
 
-	bytes_avail_towrite = old_write >= read_index ?
-		outring_info->ring_datasize - (old_write - read_index) :
-		read_index - old_write;
+	bytes_avail_towrite = hv_ringbuffer_avail_write(outring_info, read_index,
+							old_write);
 
 	/*
 	 * If there is only room for the packet, assume it is full.
@@ -568,6 +545,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 {
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
 	u32 curr_write_sz, pending_sz, bytes_read, start_read_index;
+	u32 write_index;
 
 	/*
 	 * Make sure all reads are done before we update the read index since
@@ -607,11 +585,13 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 		return;
 
 	/*
-	 * Ensure the read of write_index in hv_get_bytes_to_write()
-	 * happens after the read of pending_send_sz.
+	 * Ensure the read of write_index happens after the read of
+	 * pending_send_sz.
 	 */
 	virt_rmb();
-	curr_write_sz = hv_get_bytes_to_write(rbi);
+	write_index = READ_ONCE(rbi->ring_buffer->write_index);
+	curr_write_sz = hv_ringbuffer_avail_write(rbi, rbi->priv_read_index,
+						  write_index);
 	bytes_read = hv_pkt_iter_bytes_read(rbi, start_read_index);
 
 	/*
@@ -627,8 +607,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	 * Exactly filling the ring buffer is treated as "not enough
 	 * space". The ring buffer always must have at least one byte
 	 * empty so the empty and full conditions are distinguishable.
-	 * hv_get_bytes_to_write() doesn't fully tell the truth in
-	 * this regard.
+	 * curr_write_sz doesn't fully tell the truth in this regard.
 	 *
 	 * So first check if we were in the "enough free space" state
 	 * before we began the iteration. If so, the host was not
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 5c65820..9d7d09c 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -209,31 +209,57 @@ struct hv_ring_buffer_info {
 };
 
 
+/*
+ * The indices live in memory shared with the untrusted host, so check one
+ * before using it as an offset or to compute a byte count.
+ */
+static inline bool
+hv_ringbuffer_index_valid(const struct hv_ring_buffer_info *rbi, u32 index)
+{
+	return index < rbi->ring_datasize;
+}
+
+/*
+ * Byte counts for a caller-supplied snapshot of the indices, so that the
+ * counts and the indices the caller goes on to use describe one state of the
+ * ring.
+ */
+static inline u32
+hv_ringbuffer_avail_write(const struct hv_ring_buffer_info *rbi,
+			  u32 read_loc, u32 write_loc)
+{
+	u32 dsize = rbi->ring_datasize;
+
+	return write_loc >= read_loc ? dsize - (write_loc - read_loc) :
+		read_loc - write_loc;
+}
+
+static inline u32
+hv_ringbuffer_avail_read(const struct hv_ring_buffer_info *rbi,
+			 u32 read_loc, u32 write_loc)
+{
+	return rbi->ring_datasize -
+		hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
+}
+
 static inline u32 hv_get_bytes_to_read(const struct hv_ring_buffer_info *rbi)
 {
-	u32 read_loc, write_loc, dsize, read;
+	u32 read_loc, write_loc;
 
-	dsize = rbi->ring_datasize;
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
 
-	read = write_loc >= read_loc ? (write_loc - read_loc) :
-		(dsize - read_loc) + write_loc;
-
-	return read;
+	return hv_ringbuffer_avail_read(rbi, read_loc, write_loc);
 }
 
 static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
 {
-	u32 read_loc, write_loc, dsize, write;
+	u32 read_loc, write_loc;
 
-	dsize = rbi->ring_datasize;
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
 
-	write = write_loc >= read_loc ? dsize - (write_loc - read_loc) :
-		read_loc - write_loc;
-	return write;
+	return hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
 }
 
 static inline u32 hv_get_avail_to_write_percent(

-- 
2.45.4
