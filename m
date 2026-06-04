Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1D385539
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592378; cv=none; b=LJ9PudLrPvoskcMt3FaH4ptHmrAN/xAVszlsExvCa3G6f2FcU22WElShldDNDjVOoAylnasViGi5sHRSYGfQSF9eYIeOphABrA32fi43/lhNKV2z9K6DN3o42bTxG14/VJGBU2sIdwkUTZN+it4oBVRvW2FqrmKO/0cXB+gFd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592378; c=relaxed/simple;
	bh=yUtTpJHdzEWbgTjsiuCj893qdVCNtyL0l8/2vu8sS4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaGx83Tskw3KXuSy0WR40lDmacj8mHblH08kR6LsSj65MwQDa+dTHWZkGhgvonhQ0fZaEGJ+eKUPXGN1GF5+KEe92ZajEQKZHI+cwdzOn8Hx9ReqcXg0/Sbq7FqvPh3SsQfQj6qBW+aCbPR4UKWKrIbN/pxvNtvp8F2NYMxYa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3azZzTf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3azZzTf"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso727828f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 04 Jun 2026 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780592376; x=1781197176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pGoeEOr9RRtwxMbbZF4kryR7MSLvpeOOpDT4EcPNUk=;
        b=l3azZzTf4EZCVX985MITEzwnHVrxpYoDZ+7GeOT75J6Yl7pzlRp9z8FUksGklfxSfO
         FbyEgSyOH78cyvMnipX1G3pn16hEUjqzmp4K6lQ6+zxb4N3jp23zpFsE1dencmxyCm/V
         jlLMQ/efXxRDXqhKS3khhnx02Oe4IqWSOFe9Oh5sWnQ0lnY0oOUFaX7qShd4hd9Ua/8/
         /nACZ9JrUUSq5exUxtua1rkY09rzwdoVhnEyoKR46+KxmEM3CsSPfsH+U4oA8mttTjnf
         4eh8J+T6uf3wTdxC8XE5fCV/PjNLBrTuM1dobmKR8diC3jADYl0Ihh2aLSkYC4k9tt6r
         e/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592376; x=1781197176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pGoeEOr9RRtwxMbbZF4kryR7MSLvpeOOpDT4EcPNUk=;
        b=MYZ7tcpvhRVFz0g/gUmyPoM6qKAW7LVY27H2ARIH61VMWzgd6tdGdkzZGhMaPPe9Nj
         QvlgVPJDoHVTfN6+MnblT6h6KruBEHA942v1sQXM6/A9CaXLnjG//bRYQyEWzTdUSnfs
         MIAR+w3IkN7xySFtdcCIRyMycYjiTzVvfEskffp5pq4zwAMw5Bvoq+EzvyJYjutS+7vc
         alBPhORYSzd0R9gIwZuFxsQDEMlAjKKBqEgfCo/hK4HMdYf+qg8yvAE0Xlz9K305lNNc
         eix0JYulumGG5SaN8jWSokU0aWkHUQYT22bk3V+/ETuyvdxYb7lr5iJVgoeOFfL2bSDF
         Xlrg==
X-Gm-Message-State: AOJu0Yx3Ww9jkY5fBG2TD/Ild4zm38k/KXDb90XtlHZ1OXcHqlFMA+/E
	NbYot+Ewkqwpo/R+cQEYFFsUpXvITdfSr+Xz9UI+aYx2zGWmGPM3wgrx
X-Gm-Gg: Acq92OH8JsN15fZyu6wKDXlKDDEsMWKI4ldXyUeIDdhj9rwJ1FCm3clJV3e5RDix8Ss
	GI7oFr5SFHwrNtFBZE+ELaABuYDChDCOmhDkX2+uE5GcAjNVDLX12u9uXk9tUpspZXMqN8lT6Ys
	Whh5jOPTPAgYd9hzIzZzG/ToDVuWT5K/0uf+XrTxXwlpej/+KNWRhCbvH8SsK3nSPZYo2rJ6oP+
	bXX2h29E93AUbkTxPCzcm2jx5Mx3FCpWhZUBT57dieNDjjvcawXbqWw4ojob8D2Yec2PTPvjZU5
	LExF88OTUb4cQ71+McnL5MQ/vUVr+9wJtIfn5R4aA3S0GKaCnz6ccaWgbNwT109F+sZLbxO+83b
	CLhXbWBCOtov8zzB98SxKCZUenKZEIistgAULbf35iqQVLskNrsPsuRnOUxDm4vmMaxyblGte7o
	YqI18d5MYOzlqpCXNsL762+tOnHPymm1mdKcxlQXvmYt8hPrAxP3X7eS7MavkVAQfnLD8=
X-Received: by 2002:adf:ef0a:0:b0:43d:7c1b:b8c7 with SMTP id ffacd0b85a97d-4602183267cmr11729522f8f.21.1780592375658;
        Thu, 04 Jun 2026 09:59:35 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm17376308f8f.21.2026.06.04.09.59.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 09:59:35 -0700 (PDT)
From: Anton Leontev <leontyevantony@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net v3] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Thu,  4 Jun 2026 19:59:38 +0300
Message-ID: <20260604165938.32033-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netvsc_copy_to_send_buf() copies page buffer entries into the VMBus
send buffer using phys_to_virt() on the entry PFN. Entries for the
RNDIS header and the skb linear data come from kmalloc'd memory and
are always in the kernel direct map, but entries for skb fragments
reference page cache or user pages, which on 32-bit x86 with
CONFIG_HIGHMEM=y can live above the LOWMEM boundary. For such a page
phys_to_virt() returns an address outside the direct map and the
subsequent memcpy() faults on the transmit softirq path, which is
fatal.

Map the pages with kmap_local_page() instead, handling two properties
of the page buffer entries:

 - pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity,
   not a native PFN. Reconstruct the physical address first and derive
   the native page from it, so the mapping stays correct where
   PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g. arm64 with 64K pages).

 - Since commit 41a6328b2c55 ("hv_netvsc: Preserve contiguous PFN
   grouping in the page buffer array"), an entry describes a full
   physically contiguous fragment and pb[i].len can exceed PAGE_SIZE,
   while kmap_local_page() maps a single page. Copy page by page,
   splitting at native page boundaries.

The copy path only handles packets smaller than the send section size
(6144 bytes by default); larger packets take the cp_partial path where
only the RNDIS header is copied. So entries here are bounded by the
section size and a copy is split at most once on 4K-page systems. On
!CONFIG_HIGHMEM configs kmap_local_page() folds to page_address() and
no mapping work is added.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v3:
 - Copy page by page: since 41a6328b2c55 a pb entry describes a full
   contiguous fragment and pb[i].len can exceed PAGE_SIZE, while
   kmap_local_page() maps a single page. Split copies at native page
   boundaries.
v2:
 - Derive the native page and in-page offset from the physical
   address instead of passing the Hyper-V 4K PFN to pfn_to_page(),
   correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).

I do not have a 32-bit HIGHMEM Hyper-V setup to exercise this path;
testing help from the Hyper-V folks would be much appreciated.
 drivers/net/hyperv/netvsc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..4d319c50955e 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,12 +966,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = (pb[i].pfn << HV_HYP_PAGE_SHIFT) +
+				    pb[i].offset;
 		u32 len = pb[i].len;
 
-		memcpy(dest, (src + offset), len);
-		dest += len;
+		while (len) {
+			struct page *page = phys_to_page(paddr);
+			u32 off = offset_in_page(paddr);
+			u32 chunk = min_t(u32, len, PAGE_SIZE - off);
+			char *src = kmap_local_page(page);
+
+			memcpy(dest, src + off, chunk);
+			kunmap_local(src);
+			dest += chunk;
+			paddr += chunk;
+			len -= chunk;
+		}
 	}
 
 	if (padding)
-- 
2.43.0

