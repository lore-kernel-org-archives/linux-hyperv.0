Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F545DF67;
	Tue, 11 Aug 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464327; cv=none; b=PW+LOWuUG++wAer2rKhzNJKc5eZ0NZBrJgI9HTX6EvdSPIHpEQfEylWJPbEEKwfJVz4Cr2iv915r+nyyjYOACMtfxHeLydCFqVWsevs7XFepaWhT9EESQhnG1QcuhYyLotwk9o13GOMNLsKhKXzxgi8faz9oFjODmpTX0mt3CZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464327; c=relaxed/simple;
	bh=nYR4qaoV/dnmBKrZsYQKwoI5X9D4QY4yuPg0S5+KK8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM/gA1odAjWFlAhZyeKrydFzDejhWT7+cNMnM+Ge+AneUNESGuh4Co8/bV0ymwyft37VVCG0hsw3DkCBxjAWlOGu+U7M1j8ix3WrF4U0EVLs3GzIIm9A0sUNJRy4AsWF2jx92ghg+GPbdhAxTCn+tbpsNfKCN8eyr5TCQrpOcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N0h37BlD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N0h37BlD"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7F2CF20B7168;
	Tue, 11 Aug 2026 09:05:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F2CF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786464301;
	bh=GQiP7rNN/KQRNfzSV1VO0hhypWpn/hjzLyCBuN8NBD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0h37BlDAZEhKkT2OjLghAKByynCnTV/7LcGdDxWSJASUEdAF2xx5CDe53lY1CBYS
	 7M0UvI8XDXkNDFuiqtc9tiZfn0J1yRyB5aTx4hiIZOHiLSMzqdWnF3YMi92kVKKf5X
	 D5iSkn41VQABkIZQmDYZSHqT7TYpnCLFCWDgEy4w=
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
Subject: [PATCH v4 1/3] Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
Date: Tue, 11 Aug 2026 09:04:45 -0700
Message-ID: <20260811160447.2529876-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811160447.2529876-1-kameroncarr@linux.microsoft.com>
References: <20260811160447.2529876-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new vmbus_establish_gpadl_caller_decrypted() for callers that want to
decrypt their own buffers. Add a new hv_gpadl_type,
HV_GPADL_BUFFER_DECRYPTED, to communicate the decryption status of the
buffer.

No functional change for existing callers.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c   | 27 +++++++++++++++++++++++++--
 include/linux/hyperv.h |  8 +++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 6821f225..4782f50 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -40,6 +40,7 @@ static inline u32 hv_gpadl_size(enum hv_gpadl_type type, u32 size)
 {
 	switch (type) {
 	case HV_GPADL_BUFFER:
+	case HV_GPADL_BUFFER_DECRYPTED:
 		return size;
 	case HV_GPADL_RING:
 		/* The size of a ringbuffer must be page-aligned */
@@ -100,6 +101,7 @@ static inline u64 hv_gpadl_hvpfn(enum hv_gpadl_type type, void *kbuffer,
 
 	switch (type) {
 	case HV_GPADL_BUFFER:
+	case HV_GPADL_BUFFER_DECRYPTED:
 		break;
 	case HV_GPADL_RING:
 		if (i == 0)
@@ -460,7 +462,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	}
 
 	gpadl->decrypted = !((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
-		(channel->co_ring_buffer && type == HV_GPADL_RING));
+		(channel->co_ring_buffer && type == HV_GPADL_RING) ||
+		(type == HV_GPADL_BUFFER_DECRYPTED));
 	if (gpadl->decrypted) {
 		/*
 		 * The "decrypted" flag being true assumes that set_memory_decrypted() succeeds.
@@ -575,7 +578,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
  * @channel: a channel
  * @kbuffer: from kmalloc or vmalloc
  * @size: page-size multiple
- * @gpadl_handle: some funky thing
+ * @gpadl: output gpadl
  */
 int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 			  u32 size, struct vmbus_gpadl *gpadl)
@@ -585,6 +588,26 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 }
 EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
 
+/*
+ * vmbus_establish_gpadl_caller_decrypted - Establish a GPADL for a buffer
+ * that has already been decrypted by the caller.
+ *
+ * @channel: a channel
+ * @kbuffer: from kmalloc or vmalloc; must already be decrypted by the caller
+ * @size: page-size multiple
+ * @gpadl: output gpadl
+ *
+ * The caller is responsible for re-encrypting the buffer before freeing it.
+ */
+int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
+					   void *kbuffer, u32 size,
+					   struct vmbus_gpadl *gpadl)
+{
+	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER_DECRYPTED,
+				       kbuffer, size, 0U, gpadl);
+}
+EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
+
 /**
  * request_arr_init - Allocates memory for the requestor array. Each slot
  * keeps track of the next available slot in the array. Initially, each
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 964f1be..1146add 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -70,7 +70,8 @@
  */
 enum hv_gpadl_type {
 	HV_GPADL_BUFFER,
-	HV_GPADL_RING
+	HV_GPADL_RING,
+	HV_GPADL_BUFFER_DECRYPTED
 };
 
 /* Single-page buffer */
@@ -1205,6 +1206,11 @@ extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
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

