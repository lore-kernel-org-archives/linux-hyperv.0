Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266F4DA536
	for <linux-hyperv@vger.kernel.org>; Thu,  3 Sep 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451640; cv=none; b=qkL7rAsWgL3Sx7KxzrighKJeiqCX2BzVdVPgGGtGk9u88L4xf5Crxqa7AMwRtBO9MgSKAH9gbjGeFO7ejlGINg30VN5SV+9dcxD0spp9zbb1HXlYdXnavH/net9jab4VEBYIxJuvrzTcBFOrpHjZH9OmJgUMeKmoVwBAJ/U54qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451640; c=relaxed/simple;
	bh=xd7QfPoBvok/Ce3FnOcL4vksYEdiJx5bQP+Bx/J5PtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gu+1klI+I24wEjxLbbhyBwl8QU9a7auX65y6VKRX+lmvf4FdIiMuQa9MSH8ZsiuVJBkTpfPIbbgC2VyKLlKXYk2rAGBwV5DI6RO/T1Mhgtx8zjzXhcykaEIrW2LZmxCg1ag6nFfLs8U/lc/vAYcT/XawR5K1YWavTz2z4XQOXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkQvsfgS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkQvsfgS"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39647184c73so1198718a91.1
        for <linux-hyperv@vger.kernel.org>; Thu, 03 Sep 2026 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451638; x=1789056438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyyusPI3FD+mQJM1H+4lN3LfiPaBkg/Gx00WGPfPItc=;
        b=lkQvsfgS+idHRawxzjt9k6zh8JLmR7pjTKtQMEL0WEYCIFd38dWAzRO1U0JVenUT7F
         tFMBJoFy4KLaVpHx4KHTJeXhVF563de9cXuaM8Vxd2rTi+Y3n1B8HkCCTe69WEd5/ATo
         cJoMppkf4c16BNAANW97+xzWI3wpgGLjwXl902yBoGpK9jQJGG4o71b9zrFshuRrvwfp
         INyHvo1YfYlZcLMszXtIe75EaSSyZwINaeq0PMyT+PTJCcjh1++KOjx0wExuO0Kofz9k
         czQq0+yz596FwAOXKfP448TJxMOiX3V5uFZ88j5cLRJ9nt2uzb/JPD0VGE52lPPYiRpS
         tszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451638; x=1789056438;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyyusPI3FD+mQJM1H+4lN3LfiPaBkg/Gx00WGPfPItc=;
        b=q0tN9tVePQvj0JPeUnWRP5UykC883DbkHO9zOsPISp2j8wqPlv6W9SHQe892DbAbfR
         xpSFt8n9zvuUECR9uydxtgGneF2FyT8Nyc9D08brd5K7+8YxUqRlwbmazLXCrrZLINOU
         nv7chBUJRRDy5nP/2hjV9HfEjt3lO5bPOJM9R9drgno5uT+LWIN4A/VHbLWClkOVJ5bV
         dm/KdSRwIUHKmU+O6d0Tko2odzOHqrF+pcCpUH7jm47aeb0It4goXulHIUQSJzfvzgcE
         f6L4/UEekVkb0qQ0awpu+L4+XzQCFlumfUan5yfixskQKqpe0hG5bsG/sND7gQf3eagr
         jbwg==
X-Gm-Message-State: AFuF++lQMO6XDrzM0KeyVsO3z7k9r+CMh/3cVgd1oX/Pw9ZrCtAx2wYu
	RcUtEiquWAt/x6sVQNGUdH8DCtihWtuG1BH8IF9KqHfKnKFZ8Q36+Ocz
X-Gm-Gg: AYBFou0KdvRLs8WXjwybDidzxhHKkyr0sHSpDxt5dzLtXZwFm2PXsPvV+iEF9OQym0T
	vBDLSTFPWWo5v4P3EJ4z2ETraaJAUYXrTRs8ao2+kihfgJAeM+WNI9lu7izp7SzODXzI528cois
	E/L4asT5t6EIp4QIy0mQUS8m8trGfiKTiOBXdCrbxnu7hB6mVoJXbQTYLoHYTMnJCVLtkMiAaZP
	vCpj3PG78uhOemVE826Sytpf3BVydOHmj3ni+9kXNICmK88OCPnbNdspizbN1QS+meA8xsBstqf
	7mWoevr7225kiO1PUi3xLNLHoyVR9aRU/oGOxz1Z6hzZodWuXJirCIHX0ZgKSCjAFdh2b1rrckh
	e/jAPGprqaFdmGtXoCprwXSFQu95DZ0Hz+6b8Fl9Mj7qIM16OuOeKqYkRe3z+DZp+FoqF2dciRN
	SexVrCiDII+IKWibT8r8RmpyrhEepL+NIPaxz5FcY0rFc7Un4auvMt8dMJAetjNtzjxA==
X-Received: by 2002:a17:90b:4c4c:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39b1322464emr3752631a91.6.1788451637343;
        Thu, 03 Sep 2026 09:07:17 -0700 (PDT)
Received: from mhkubun.mshome.net ([50.34.2.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccc72fsm3702020a91.2.2026.09.03.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:07:16 -0700 (PDT)
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
Subject: [PATCH 1/2] Drivers: hv: Add vmbus_leak_buffer()
Date: Thu,  3 Sep 2026 09:06:50 -0700
Message-Id: <20260903160651.1637-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903160651.1637-1-mhklinux@outlook.com>
References: <20260903160651.1637-1-mhklinux@outlook.com>
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
index f4370617deac..d5d20e322831 100644
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
index e61f9a4cb7c3..c55de4d01cbb 100644
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

