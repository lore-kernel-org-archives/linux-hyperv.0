Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E7437448;
	Thu,  1 Oct 2026 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892697; cv=none; b=WYMC5h5FzXZBdinSQlAyYbv0wRRlmysvJe28S28BBgtYyx0jULZkFeR+QMfFqhDwMJHwhYl/xzxcTMJmCLQ5ZpS2mTb5GnG5BB39jO9GQb2xRPesTNCUYBjyKJnvmq/fVbbMEEDJcx12gIgXYwgP4bTfsFlrkN7lSpWLFHxccIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892697; c=relaxed/simple;
	bh=i5dGuL+vmCk0H0P/olMRt7aH85cUGBzKK2mmuD1WHqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlJybo5ZkaGjMc5r4MG2+EieDGrotEeds7yg4tgFlotZChOx3h1Mh0Mz1mQk7jVQRqZmDLoVsazPjqzULVniODXbow8YWbYAFNlJpLqky9OlbpsS8N4LkJV50JKZ2EhOP9/4VDAZjB5c1xVrik4N5RPbfrZlXBcX/WNPzU+8AvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZssPztoY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZssPztoY"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 524ED20B7171;
	Thu,  1 Oct 2026 15:10:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 524ED20B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790892642;
	bh=qFQdVdooSZcP5uYUJo8WJDgVWEs1roO5BJFHiMbw/4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZssPztoYw0prPqhe48Icws8j333qOTcJ2OEAAs/rmRitoD1HwqvWaSwkYCVAqLC0E
	 ZpToPhogXl0XzSTjkLr9NV1KJiFBwscnqs0yspwOiMmBg4VpKXbs5dkjaLTNPUrHhW
	 YBVAG85Y1hXa75nq/yOnsKk11uMsfGrg0RWjqKR0=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Drivers: hv: vmbus: Keep the ring byte counts sane for a bad index
Date: Thu,  1 Oct 2026 15:10:40 -0700
Message-ID: <20261001221040.1794904-5-kameroncarr@linux.microsoft.com>
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

The remaining users of the shared indices can't cause a bad memory
access with the channels a CoCo VM accepts today, but an out-of-range
index gives them a nonsense byte count. Give them defined behavior
instead.

hv_pkt_iter_first() bounds its memcpy() by hv_pkt_iter_avail(), which
is derived from write_index, and by pkt_buffer_size, which comes from
max_pkt_size and can exceed ring_datasize. A bad write index can then
make it read past the end of the ring. Only KVP has such a max_pkt_size
(16K on a 12K ring with 4K pages), and vmbus_is_valid_offer() rejects
it in isolated VMs, so this is latent. hv_pkt_iter_avail() now reports
an empty ring for a bad write index and logs it, rate-limited like
hv_ringbuffer_write(). It takes the channel instead of the ring so the
message can include the relid.

hv_get_bytes_to_read() and hv_get_bytes_to_write() now return 0 for a
bad index, so callers see nothing to read and no room to write. This
also stops hv_end_read() from reporting data that hv_pkt_iter_first()
won't return, which would keep a channel rescheduling its callback.

hv_pkt_iter_close() only uses the indices to decide whether to signal
the host, so skip the signal if either is out of range.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/hv/ring_buffer.c | 15 +++++++++++++--
 include/linux/hyperv.h   |  6 ++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 29edab9..b54a7d3 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -408,8 +408,9 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
  * This is similar to hv_get_bytes_to_read but with private
  * read index instead.
  */
-static u32 hv_pkt_iter_avail(const struct hv_ring_buffer_info *rbi)
+static u32 hv_pkt_iter_avail(const struct vmbus_channel *channel)
 {
+	const struct hv_ring_buffer_info *rbi = &channel->inbound;
 	u32 priv_read_loc = rbi->priv_read_index;
 	u32 write_loc;
 
@@ -421,6 +422,12 @@ static u32 hv_pkt_iter_avail(const struct hv_ring_buffer_info *rbi)
 	 * stale data.
 	 */
 	write_loc = virt_load_acquire(&rbi->ring_buffer->write_index);
+	if (unlikely(!hv_ringbuffer_index_valid(rbi, write_loc))) {
+		pr_err_ratelimited("inbound write index out of range: relid %u write %u size %u\n",
+				   channel->offermsg.child_relid, write_loc,
+				   rbi->ring_datasize);
+		return 0;
+	}
 
 	if (write_loc >= priv_read_loc)
 		return write_loc - priv_read_loc;
@@ -441,7 +448,7 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
 
 	hv_debug_delay_test(channel, MESSAGE_DELAY);
 
-	bytes_avail = hv_pkt_iter_avail(rbi);
+	bytes_avail = hv_pkt_iter_avail(channel);
 	if (bytes_avail < sizeof(struct vmpacket_descriptor))
 		return NULL;
 	bytes_avail = min(rbi->pkt_buffer_size, bytes_avail);
@@ -590,6 +597,10 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	 */
 	virt_rmb();
 	write_index = READ_ONCE(rbi->ring_buffer->write_index);
+	if (unlikely(!hv_ringbuffer_index_valid(rbi, write_index) ||
+		     !hv_ringbuffer_index_valid(rbi, start_read_index)))
+		return;
+
 	curr_write_sz = hv_ringbuffer_avail_write(rbi, rbi->priv_read_index,
 						  write_index);
 	bytes_read = hv_pkt_iter_bytes_read(rbi, start_read_index);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9d7d09c..fd61382 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -248,6 +248,9 @@ static inline u32 hv_get_bytes_to_read(const struct hv_ring_buffer_info *rbi)
 
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
+	if (unlikely(!hv_ringbuffer_index_valid(rbi, read_loc) ||
+		     !hv_ringbuffer_index_valid(rbi, write_loc)))
+		return 0;
 
 	return hv_ringbuffer_avail_read(rbi, read_loc, write_loc);
 }
@@ -258,6 +261,9 @@ static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
 
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
+	if (unlikely(!hv_ringbuffer_index_valid(rbi, read_loc) ||
+		     !hv_ringbuffer_index_valid(rbi, write_loc)))
+		return 0;
 
 	return hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
 }

-- 
2.45.4
