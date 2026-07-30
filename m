Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23F478842;
	Thu, 30 Jul 2026 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454488; cv=none; b=QE5eUQfWqaHfVswDn1aM54c6KfJUD4I0fZUqtIeuvtZNeSSv2CQqY4dhIiRnyj4gFuDzTZRREYNbZ1tENzOhCdaO7rKYBRPHpcAWaHQ28NlVq9LgSEm3r5DqbNuD2hwXMG7HnT/DkPhbJAPZ/Cc/UzwDIiT7ruH2fPnh44rBEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454488; c=relaxed/simple;
	bh=z9IC3UaCT3kcUFx7/yXEBf/jScwzDKSxJVLbhjyQhIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoZJGoxkGhYwquLYm47+XzuZtccXdEmgTVAP5Z/G3ObMVU0xbOX6RflC1KaEk6LG4G1ROJPxFYZ/WfvZ+8q0xDg739rYurJKRUkkkAldcPTdxm5WSPkBpZYDP7lJJgUDRrsu4eHqm6I71g6H6OzIL2Ec7ACpueRWmQJkcgbmPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KZYR7Fgn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KZYR7Fgn"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59A1E20B7168;
	Thu, 30 Jul 2026 16:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59A1E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785454463;
	bh=MYlBk5yNAwEn7cL0hMdoyVFC+wgS7cecv71nTRouSjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZYR7FgnDoEybQOGyQm0QoDKFwmvYaELYDRWe+9eOgzJm9rBDbzeCGgVg9oa+jLvh
	 U3ogGW7KhUutRTDrh/BEi+F7LHyN63vjz/erWBrgKBgg77yUf0q7qhvFMrVTGBoCDM
	 TR5YA+mltddfa4tdPymKuZcjR/W8MjZYe8LLcmW0=
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
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
Date: Thu, 30 Jul 2026 16:33:58 -0700
Message-ID: <20260730233359.3850612-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
References: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
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
---
 drivers/hv/channel.c   | 27 +++++++++++++++++++++++++--
 include/linux/hyperv.h |  8 +++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 6821f225248b1..4782f5070bba9 100644
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
index 964f1be8150c5..1146addbb42c4 100644
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

