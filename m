Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521272;
	b=S2h0TdH1sGMKY4XR8yLRe1Z/vEfOU7OlGA7OyAZLqpddNWCuqwVuznM95NHM4uekRS4X
	 3PocLjIcC+K8Lwkv76iHrXMn2QMHzOv5OCabhpz4aGhtHVtZAFFx0/CuDLyXIk/G69+7p
	 118gYLW82mAIJx6PJy9JZxZUQRpq2rnSW6tbUBF67vECSGMMiNTpdj6LHJkAQSBs6w4wJ
	 oHvsvDSJkWn1DIbaagKxxN+FeM6sz2ppUX8zA3N5/YTkgbQW14RUKs7K9GfZBawW10iqu
	 zeRHqf2iSO666WpTzmX8gAAXCXIhFWI4n6cQ0iiR1/3Tx6M23sVvAbmfPnjKmpkVQrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7xvuCJgcD9l7E/ovSE3XgN/jPSwiafr1MiTxX4bzF5o=;
	b=XGSFK+zV8NIp44Cnp99nOJZKk3HYK9Vkh7CJ3B34tcOvZhExc1tDJX4Pscf5UlxNPv4T
	 LCWssfUi142DWAwnm1z6FZ19EtRVtiFhvDdtUtkar1+rPJRfVcvaEAWbV5mg/8bBatcWw
	 uKeKvjF/FMGm+gCTJyYdxR/wOVyIakHiD8cIkDNyHf0DZCVkd/RHwb1W6KZAqT6+90AY0
	 w0yf+omaixB3RGMNF2XA9pIP6zfUvjMuXyR1e3Bxn/K2FGTF0YVFL/UKVJIsaaBqL02KZ
	 +UNUOOia14H4x5m7czOGwSKnSXGO8DcfETzPURpAXuI9zsp58S2lg+926GalmK08TLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NkJZjs/E";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F36606A324
	for <linux-hyperv@vger.kernel.org>; Sun,  1 Nov 2026 08:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F36606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkJZjs/E
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2944426eec.0
        for <linux-hyperv@vger.kernel.org>; Sun, 01 Nov 2026 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521271; x=1794126071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xvuCJgcD9l7E/ovSE3XgN/jPSwiafr1MiTxX4bzF5o=;
        b=NkJZjs/EMBQbCOIMogkLRABNsWip9qBkrNjQB/a5g26rcPoQDXpdRvjx/2LwgpC+/P
         qpLlWY6S9cc2G1PJHUZ2uvdPlFRMNXGu/Gbq70dv7cG68VQo0Yzx2REwx+aWWF3WJSJT
         UD1YOh/j4hhe70lSvxLt5msD1QeWZmeIVnLZ7wJlH1BGYBF9+T3RpT8wWaNcgRTil984
         8rJWRfJusj04p/47zY5znfEiig2Q8paiT41Xhu66586PldVud/zlYiwE2tbEW27kDahK
         /JW47NzlINKy49MVj/oMt4DGAQlPvtsYpdjCDKmIkiAiBbaXZsh9p3dF9aeXLcdQMpx8
         WaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521271; x=1794126071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xvuCJgcD9l7E/ovSE3XgN/jPSwiafr1MiTxX4bzF5o=;
        b=phIHa6bfpJ7j7AfgYE9Q8nGHQcIX+Vy2EYyQ4r6RNY2bgxRI0CrvE3YsALmm183gor
         QccI6xok0yrmzVyyWkHsdcYPnq0+OVj5fN0ATab9V9kYBRTVgqp3sO2mw9XRPlyUeA84
         TSovwdeV8Y0GIR/LtAInXIb8LZe43Lvkvr0xxgrsvgZytuNhjYizqyD8g9jeZ3CnHYNv
         8kTiIm2YXhowyhNa40C6b6F1VjK4Zt+eQDPEYZgGqUIboNVXYyZewpfErykOf2hLMa9L
         5TEvaF9QR4tYdYRShPSWh/cOuHByoF1/wZF4+nfNg1q3hl4r1x/NWjhYZW+yUJu5J4mA
         micA==
X-Forwarded-Encrypted: i=1; AKwUvBwSaek3T7N1I/sW1X61ubxVYnt74LHwkWLhApKO46mnW40ePoGGHqNQwgMbha+zxsRwngydlAud0Z7SKg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CI2+7tNusRZr6Cr7fAyvoNXDu6KTi6FvKTTooNELPc/zXvOLv
	lFihAMOMak6BN73KbLlQEbIk6IEdOPA8Yukh4iOY+HX3pmGMl8+YUTVl+Tvl3qd+
X-Gm-Gg: AYBFou0xZpsrt4RzHTvmKgRrYpi22iv1juTsPjsAOhxX0kFtdTYDPd+feQHxWAdnWFl
	WeXBLAu6l4/BzqItddNfXS9jHzjUx8r1659EguqO4ZYxRaM83jQdXUPnv/cC/0ox5eZigMoA7Bh
	lZ4LLnc7OkarDJgfMZJub7PoJIxD2+3SjsVn7J0Jja3pfpKPmOl8oajcyMDxU7lu4UFL8hEEnWc
	E/NPYWUytUQCIo1IO1MDOCx6lITdXJfgzlZD7Y0om1NLdh8H8BotKBBZFaa6ia6kzLXOuVEe+w1
	N3EusAkhdRt7Yiss+PRnoC79lqD0Xv0Siq8i4YSdMEdRNjfcRe9Sz+L9oo3hwroXkCaRB2rz/gZ
	Bh8CqBuQRyq3uCkxFrF37Z7/9QbLvjyCe7cAAUeQccAirbzw36i8/dor4dD6jSj3aEo5X6LvUVU
	rhbyYDgCYFcymyk7hpq7So0l/ycBO+uxEikY+a5ussl+gobD5XTSTXqe6/i5xTApcQ4W1IrUeBP
	UMp/ZNpCTmSZ+lTPnoJLVNawAhWElEIN65q/DvIrPKH54liDmV0R4izp9RRKpsRYqvc/KQiWZSN
	/8JyvA2sFmjt0HqIog1Et4o0m5hT
X-Received: by 2002:a05:693c:895c:10b0:36a:4a08:f0f0 with SMTP id 5a478bee46e88-36a4a08f8a7mr8653024eec.27.1793521271334;
        Sun, 01 Nov 2026 01:21:11 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:bd68:88be:f3db:8e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a98f65sm24114255eec.28.2026.11.01.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:21:10 -0700 (PDT)
From: mdshahid03@gmail.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] x86/hyperv: use pointed-to type size for page table offsets
Date: Sun,  1 Nov 2026 13:50:34 +0530
Message-ID: <20261101082034.134583-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Mohammad Shahid <mdshahid03@gmail.com>

The Hyper-V crash trampoline code calculated page table entry
offsets using sizeof() on pointer variables.

Use sizeof(*ptr) instead to calculates the size of the
pointed-to page table entry.

This makes entry size explicit and avoids relying on the
pointer size matching the page table entry size.

This issue was reported by Coccinelle script noderef.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 arch/x86/hyperv/hv_crash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index 5ffcc23255de..810eb1a4a0a2 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -512,20 +512,20 @@ static void hv_crash_build_tramp_pt(void)
 	pte_t *pte;
 	u64 pa, addr = trampoline_pa;
 
-	p4d = hv_crash_ptpgs[0] + pgd_index(addr) * sizeof(p4d);
+	p4d = hv_crash_ptpgs[0] + pgd_index(addr) * sizeof(*p4d);
 	pa = virt_to_phys(hv_crash_ptpgs[1]);
 	set_p4d(p4d, __p4d(_PAGE_TABLE | pa));
 	p4d->p4d &= ~(_PAGE_NX);	/* enable execute */
 
-	pud = hv_crash_ptpgs[1] + pud_index(addr) * sizeof(pud);
+	pud = hv_crash_ptpgs[1] + pud_index(addr) * sizeof(*pud);
 	pa = virt_to_phys(hv_crash_ptpgs[2]);
 	set_pud(pud, __pud(_PAGE_TABLE | pa));
 
-	pmd = hv_crash_ptpgs[2] + pmd_index(addr) * sizeof(pmd);
+	pmd = hv_crash_ptpgs[2] + pmd_index(addr) * sizeof(*pmd);
 	pa = virt_to_phys(hv_crash_ptpgs[3]);
 	set_pmd(pmd, __pmd(_PAGE_TABLE | pa));
 
-	pte = hv_crash_ptpgs[3] + pte_index(addr) * sizeof(pte);
+	pte = hv_crash_ptpgs[3] + pte_index(addr) * sizeof(*pte);
 	set_pte(pte, pfn_pte(addr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
 }
 
-- 
2.43.0

