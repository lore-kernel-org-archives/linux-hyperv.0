Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1243F0B5
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817761; cv=none; b=K3TDgJKBqnMJeDi4qWdisZidmVPYB5dTKHMf96VSgr/9WTk82VMneeppncyO6URc0uzgLe+6JKRh8pdjZuc2WNjb674N6S3DPnTcRy/7NT2Fq/S9L6MXHB1j9CQds4P/o5xCos4Eio/SoJbDA1NMGNmMPIrbLUxOsSDioLE3jZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817761; c=relaxed/simple;
	bh=kyhfJowlP78+mT4TFrBLw/COfDR9mYJ+UJWh2YOktaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NGZ8yNhP08POfmfBiF9B3Bo8+qFBl+Uis91vIn46JWh5AmwJX+yLuFtZ9ZIWxFP8au9v+8mLunFI6zg8UB8lxnPR3T6encofAtBBTxjZaDCAuJIsmPhgkkhagxz/CsKJoEARorZXAGOwYao6JC+wakkEKt2te686ikjUUivWuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVK7TpGO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVK7TpGO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d6f9e2f681so42440765ad.3
        for <linux-hyperv@vger.kernel.org>; Mon, 07 Sep 2026 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788817759; x=1789422559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjiHaibP4J4hTCPeapEW751w4Tf8EI2jtPcFZlPx910=;
        b=YVK7TpGOvSXVUXO8CbLPCjinNV/Rvv6qrqfk+39k7/f5DLhhuvYROa+zCY/mOiiATl
         X4OdUm9Dpn4/svR7ikHffj1rZiYAitkDEnUpsD5mF8vnYxWuAE0bdrSTpUpIs/GVdU9i
         8Gb+Z2Ccy8ox/+I2TgX2M4VgSVz/GxKwosRRTT0esrMgF6D5lswONZ1V9hwOOivVmSZG
         Mnh24timSSg+/+ygNb+JRht92cP1FDZsyQIYjDu2mmuZ/q6rh2USQ80+yJAhL4rpYdgo
         BltydYJeIjg9aFoPTJW2MlTgdtQN852Qu6P4uaS3/Zh02IR+lqiC/ZGnW3u02jmJ9KMD
         5hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817759; x=1789422559;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjiHaibP4J4hTCPeapEW751w4Tf8EI2jtPcFZlPx910=;
        b=s53PaIz5KwEi3y9f8bDU2pT/zGGAmnt/h3GCUs3UE47BZRFdeRVGv/lCreB8zvOQJk
         flG8ggzBeJNak5j2OeiTeEkKfz+eo4YBqzPxIaj+pHOrLlnGTVUxarP9IqQPxSd+/rMM
         1fzgjunm7ONlLFntFLnZxGSzRRJRujJV3obbvShJm40aula9giuRMmDl0cDvYihbaWGh
         vMJeIJ5iiCMgv84rqdKVPRSYDmY40ZVj+0e3TT6axRXBgM/8DiwZZmylMvkb24Wg69KS
         809T329j/30/UveArZHsvK9jEs+h2jR/yie8gOLhaKXGn2qyqX41r3Y+35MpxfLnfxgn
         eDyg==
X-Gm-Message-State: AFuF++l8espuy9A+aCGEL/IKuvspibRNbFhUYrgTwuUqdgZZcPOi7xbJ
	AcYkxQAH12fttPl+WrWCRxDvg97MigwiyEgmL/gLwqfMtWpO568r7V+y
X-Gm-Gg: AYBFou3mqw9tbVAD+07S5+S6sfYIGuyx/FxO4z95sGIvZUQtLUWOoQdbIcZjIf6c6hR
	oMcY4GxreVk+P2ruweM2qypV0TkQc7w5p5RHJO91lWUdNbVo0JlQtBuaX65YTVcyn+cNW2Rw42S
	fSpCvySbNhJbM9b+b1jZv4cQ81jA1A3dDm/IgLIcgcipIjnIdAM3Sn5nha2SEWDjpmQHkJtkJPa
	HTrNs2R/tAYFDV2rwDUJAp/RmXHwSNQ3/WUcCh0owVGVR4BOcjTU9Oqcso+cyqmy8WdqJ30tLBf
	hxaG17hgIA4RatAkkXeqQXz28Q75jXwfyDhgV5vkQDGcnBwkWwbL0EjjCFRJviv9CNvodSTvmDT
	GTjUCJ8JoLTTfvEN2RHAuEYO6svTqVJZzIJlvSJNTQRp4SKdJf1YSqGMmXhtM60mFrdO/rS/HXO
	QSg4ldIwUot0mlKYLGKna7ZUB/QEVRtIyh2a0Gg3XNcnDgEeKnBHqfmPHY/SG5kEM9V3qZMHOg3
	JvL/PtMniKa+5oYiHnJztGDQqrFfjf27pZ9rNQSYQw=
X-Received: by 2002:a17:902:d4d2:b0:2d8:d4ce:7e3c with SMTP id d9443c01a7336-2db12630dd6mr289758255ad.17.1788817759221;
        Mon, 07 Sep 2026 14:49:19 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14841eaasm48794155ad.8.2026.09.07.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:49:18 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/3] Drivers: hv: Add vmbus_leak_buffer()
Date: Mon,  7 Sep 2026 14:49:01 -0700
Message-Id: <20260907214902.9046-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907214902.9046-1-mhklinux@outlook.com>
References: <20260907214902.9046-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error case needs to leak the buffer memory allocated by
vmbus_alloc_buffer(), doing so requires knowledge of how
vmbus_free_buffer() works. In a CoCo VM buffers are allocated
differently from a normal VM, and vmbus_free_buffer() handles
the difference.

Encapsulate this knowledge in a new function, vmbus_leak_buffer(),
that error paths can call. After calling vmbus_leak_buffer(), a
subsequent call to vmbus_free_buffer() frees the additional
resources used in the CoCo VM case but does not free the actual
buffer memory. As such, vmbus_leak_buffer() is callable in a
context where accesses to the buffer memory may be in flight.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c   | 26 ++++++++++++++++++++++++++
 include/linux/hyperv.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index cc86e8505ad0..389b27cb038d 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -648,6 +648,32 @@ void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt)
 }
 EXPORT_SYMBOL_GPL(vmbus_free_buffer);
 
+/**
+ * vmbus_leak_buffer - set up a buffer to be leaked by vmbus_free_buffer().
+ *
+ * @addr: buffer address
+ * @chunks: chunks array from vmbus_alloc_buffer()
+ * @chunk_cnt: number of entries in @chunks
+ *
+ * When @chunks is NULL the buffer is a plain vzalloc() allocation and
+ * the buffer is leaked by setting @addr to NULL. Otherwise set
+ * @chunk_cnt to 0 so that vmbus_free_buffer() does not try to re-encrypt
+ * or free the buffer memory, but still releases the vmap address and
+ * the chunks memory.
+ *
+ * This function may be called in a context where the buffer is still
+ * being accessed. It must not remove any kernel virtual addresses of
+ * the buffer or change its encryption status.
+ */
+void vmbus_leak_buffer(void **addr, struct page ***chunks, u32 *chunk_cnt)
+{
+	if (*chunks)
+		*chunk_cnt = 0;
+	else
+		*addr = NULL;
+}
+EXPORT_SYMBOL_GPL(vmbus_leak_buffer);
+
 /**
  * vmbus_alloc_buffer - allocate a host-visible, virtually-contiguous buffer.
  *
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9e109d91aa14..6f60ce5924ba 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1220,6 +1220,10 @@ extern void *vmbus_alloc_buffer(struct vmbus_channel *channel,
 
 extern void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt);
 
+extern void vmbus_leak_buffer(void **addr,
+			      struct page ***chunks,
+			      u32 *chunk_cnt);
+
 void vmbus_reset_channel_cb(struct vmbus_channel *channel);
 
 extern int vmbus_recvpacket(struct vmbus_channel *channel,
-- 
2.25.1

