Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451402;
	b=VV4eCGepXZqLTuiz8F1LgnB/XWcu8y5Flfp9tZh/4XdIKeIb1xWD9n92w9q72Cn2qBg9
	 zEsXXipiRZwLhXnqR8Y5IIh3/Af8nUNK9KBvaS7/1NoPTXj3miv3uZh/UjnYG+mouPrXz
	 XKN0Sm2VUyVqUuPEeAkrJK4FJODlZeX8CqvVflZhk/2aqtkaFUmQ3Y6jlY40HevwusuzZ
	 tPQ6yvUuaxOUSDovws/MaXwfziUKAsnrlsmUxg/mL/EiUUacGE/kGHgKaTWTPcuJi+rWj
	 JaOCdpTjPhc+4h6ZqzywRHdT6cGhKxVaZPHc3qxsfGJCAW9LvCWmKxmIAti0EBUGYgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451402;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=kq706Yw7r1M42zq8+pGBk6neyIEicB8NU3VHhTPTwPA=;
	b=jGiQ6uN36IULcoq9U6vDFv1/tP9sWk+lig3NLvYdUsZMIzmwbVZ2Cb0AD4gWLRVXw86p
	 mnvdSEquHIlAzOxjQLGW9yloX8QxjpiY1EO/nCyy4QY7SRoy2a0ZxMxElhH2QGoLuUvRy
	 /nj7VSy3xjWCek9N2R86Ik47YrHAI75DR2XgnHfEDThUX6ZMeOs/KBCJFntmNQZOFHQRa
	 YV1dKKbD1P+lWWWPdLtirqoCQSiKt9tJyOSB6F5CWla3g+G/BxgpioSIinZQMQpXMCn9V
	 BbP67XJEf/bCsYAH7BRwX+0WWs1+UEl9RjdAaeoo2NfpCeuHr76aaxO9596/VMySN4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iZjJCzWh;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978DE606A32A;
	Mon, 19 Oct 2026 23:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978DE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iZjJCzWh
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90EFE20B716F;
	Mon, 19 Oct 2026 16:09:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90EFE20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792451394;
	bh=kq706Yw7r1M42zq8+pGBk6neyIEicB8NU3VHhTPTwPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZjJCzWhUD6xAADLxA7jXsdP7AaBDrMOBa1DOv9Wyy3Hwts8OwQrO2pXYOOXQfaXm
	 3fFkZ7XGvlq8dwt7GehW5RV3keFXSSz9q1oP0wefwH5l2KfUnnj0giTpLb/2LmjtNd
	 S1TKlHC0TTHAlmPhSLZlaDpUfCSYatXhaRtlD/UI=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] Drivers: hv: vmbus: Keep the ring byte counts sane for a bad index
Date: Mon, 19 Oct 2026 16:09:49 -0700
Message-ID: <20261019230950.1573677-5-kameroncarr@linux.microsoft.com>
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
 drivers/hv/ring_buffer.c | 16 ++++++++++++++--
 include/linux/hyperv.h   |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index cda957d..72f30ab 100644
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
 
@@ -421,6 +422,13 @@ static u32 hv_pkt_iter_avail(const struct hv_ring_buffer_info *rbi)
 	 * stale data.
 	 */
 	write_loc = virt_load_acquire(&rbi->ring_buffer->write_index);
+	if (unlikely(hv_ringbuffer_indices_invalid(rbi, priv_read_loc,
+						   write_loc))) {
+		pr_err_ratelimited("inbound write index out of range: relid %u write %u size %u\n",
+				   channel->offermsg.child_relid, write_loc,
+				   rbi->ring_datasize);
+		return 0;
+	}
 
 	return hv_ringbuffer_avail_read(rbi, priv_read_loc, write_loc);
 }
@@ -438,7 +446,7 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
 
 	hv_debug_delay_test(channel, MESSAGE_DELAY);
 
-	bytes_avail = hv_pkt_iter_avail(rbi);
+	bytes_avail = hv_pkt_iter_avail(channel);
 	if (bytes_avail < sizeof(struct vmpacket_descriptor))
 		return NULL;
 	bytes_avail = min(rbi->pkt_buffer_size, bytes_avail);
@@ -587,6 +595,10 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	 */
 	virt_rmb();
 	write_index = READ_ONCE(rbi->ring_buffer->write_index);
+	if (unlikely(hv_ringbuffer_indices_invalid(rbi, start_read_index,
+						   write_index)))
+		return;
+
 	curr_write_sz = hv_ringbuffer_avail_write(rbi, rbi->priv_read_index,
 						  write_index);
 	bytes_read = hv_pkt_iter_bytes_read(rbi, start_read_index);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 09f25ad..216c0b9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -250,6 +250,8 @@ static inline u32 hv_get_bytes_to_read(const struct hv_ring_buffer_info *rbi)
 
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
+	if (unlikely(hv_ringbuffer_indices_invalid(rbi, read_loc, write_loc)))
+		return 0;
 
 	return hv_ringbuffer_avail_read(rbi, read_loc, write_loc);
 }
@@ -260,6 +262,8 @@ static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
 
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
+	if (unlikely(hv_ringbuffer_indices_invalid(rbi, read_loc, write_loc)))
+		return 0;
 
 	return hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
 }

-- 
2.45.4
