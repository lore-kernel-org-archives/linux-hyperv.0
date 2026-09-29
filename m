Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD93E40E9
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654618; cv=none; b=g7GEO6XSc6h17tGPFsTPEGX5Vf3Pj+yPLgkeUM005eY8I97zFS+WBoKxHLkwPk+fLtTOCVUXryzS+Ss+BX4xGpeh61cMZhl5fCkBZdwL66HsDT4Nwq7T3TUUkDrgAao71MMhH1heBcrUDapcL34qMmAkWnIksqhEYZ5WX03VDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654618; c=relaxed/simple;
	bh=rUzQo5KHgL8B6Zt2JDNYEUTyvIMbiqzpi4ZnuUlZBBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQBFE223czKhCko9QjyaTndAm42S2QKPTYC0XN4cBtWGFqHCCqqHFg8wuQBQKl7fTcu51LczViaw+yUx2HbwOGNpFz5DwovtclIMWQFwLw7BBywQpxyAPUaWEM48fMExUqacokQ+sUhqhbVCHjpLmOkB/Ruk+tUw4nB1j3Wgma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bjNTJ6w2; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bjNTJ6w2"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so445938a12.2
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654615; x=1791259415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CV8TEMBP6IF+2lIlzYCpg42JpAwpPVBphnZX2jCaOFA=;
        b=n7tOQtsgEOmuSf1hvZtKBamz9IduDtznOu3cDYfwJkZv5e8aAuyhGsaPsD/naWavnV
         EYhnyTBS50bu8RHaY6uQjKl6J3PhLuDqWgeSGjB62ufuJL+6FhhTX3ZRRJ68FAUaRr3k
         wRfdDb1DkNB7DfwUEYvIpQ37zyQmj5m1+brsHMp1k0TcTi8pCuYCHpDC6FbrMXxZw5PG
         htCzpzxd4zkpm6dA/2Cp4V04Hh7U1fTCjNzTXWofcnlDTFhCmnS4yTowa0XbXRBr0P5t
         iwRQh/BFnmY93RB3kEyquiWRcPVNtaoBFRBsWrnUOyOxPnk+Z7WysN/yfLt+rMiIu+0Q
         aL6w==
X-Forwarded-Encrypted: i=1; AKwUvBxqpOEUwBw783U7vVQ9LxFgtPiRSF5NgO2mToeXYF2sPLR3SHLQNDRG9WjZ1O6luRpYKRFWPBtwbEGrYfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKn16Yi8NdolCXtaAQaYO1jdIG/o4/DWdRZtOcMzDxGf6xhKg6
	Hsc1Wh3xw3cgb17HgF/hacJgGbvkGgEos+Y+VMYpo/FwNSVcXPQdB9Mmcq+q4wlZfN4KibMl9I8
	6t2TktUpWC1XLrOEh6SKaUWLFafYp7lYFjYBTBxyhuBX6CmAz8e/akdiia04stNOLRexlB3Ov9y
	+96OvcNuzp3FrbgjN0PAQb2R3ZJbOu9d203Cz5k5jRbEYcEPiuEZWLHvZtcsZbcDLo7xBwFae6N
	SGAYcSYR5TCZWJi
X-Gm-Gg: AYBFou3vhd36QPQCVwMQZRdmpMk/1Ad0cxyneIvcAmsIBU294zT2c45sV/13wQ4oVpi
	d0GbV3MpdhUM6r890agTjW7Pq0T9h4pCS8fhGMbv+xYffa1N6pzFVgvOiqeRvqVWobkI17O3+Ai
	HuIqNk3x9dfbnrdkzzEsTg20RTwxbFgp5+qzN5R+eqW0sKNFzN/xRwaSMI7kbAzovgvxYDz8ddD
	rUajIymcqWCtP+cOGEFdVcUQDUC56uk8L4m8nBk5H6yZFnc8V5e0IuX1XZ0MFN/xsF0t+jEze9N
	vhwD+KTUpdM7YooETRNoEZvnbBJsvSaZoLYp3w+KbmvkjtXir8dyIy6rZJJMvj8svHvecnuSwEk
	zfPmTYA39gN74GzsFEMTCc4vRZCcNuyoHr/cIiZuMtsB0OAhno/hIqnchpToSkKN2kksgkCMtZf
	HGv8bvfxAiF6m/fU297bJnLxtSrqyrOgV6
X-Received: by 2002:a17:90b:1c03:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-3a098537e9bmr12931340a91.5.1790654614977;
        Mon, 28 Sep 2026 21:03:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a49835dfc6sm996397a91.6.2026.09.28.21.03.34
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-342217d8d53so12163083eec.0
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654613; x=1791259413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CV8TEMBP6IF+2lIlzYCpg42JpAwpPVBphnZX2jCaOFA=;
        b=bjNTJ6w2pB+RY4tIwDLWRoyh1TKrkkXYnJifKxI+xNDRyGSYEEyzU0N9RA+k3C96ay
         vaJH3Uc2C7BTr+aeuOpbnzDtG1rLZuoXoQ9TZEm3yZzzX+cYXeIlE51x0XqJMlI+lXq0
         upWhIuZH+I939ODjwf+SW6xGOiFUHEmKFwSeY=
X-Forwarded-Encrypted: i=1; AKwUvBy02a98vfwEG6lDaY22TffE7onZuPR7lUb843CPFRA6haDkJxXotxPGnR0Ono+ErS9y9IYB2YyjNfKmA/k=@vger.kernel.org
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr12611761eec.31.1790654612900;
        Mon, 28 Sep 2026 21:03:32 -0700 (PDT)
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr12611727eec.31.1790654612252;
        Mon, 28 Sep 2026 21:03:32 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:29 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 5/6] x86/tdx: Support early sharing of kernel data
Date: Tue, 29 Sep 2026 00:02:54 -0400
Message-ID: <20260929040256.543767-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Share pages before the page allocator is available, after both their
direct-map and kernel-image mappings have been made shared. Preserve
initial contents in a private scratch page, matching the AMD early helper,
and use the existing MapGPA path and shared-page accounting.

UP per-CPU data has an image alias. Drop shared image mappings before
kexec converts their backing pages to private through the direct map.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/coco/tdx/tdx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..4a683e9eafc3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -4,6 +4,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt)     "tdx: " fmt
 
+#include <linux/cacheflush.h>
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
@@ -18,6 +19,7 @@
 #include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
+#include <asm/sections.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
 
 /* MMIO direction */
@@ -1006,6 +1008,23 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+static char tdx_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
+
+static int __init tdx_early_decrypt_page(unsigned long addr, unsigned long alias)
+{
+	void *buffer = __va(__pa_symbol(tdx_early_buffer));
+	int ret;
+
+	memcpy(buffer, (void *)addr, PAGE_SIZE);
+	clflush_cache_range((void *)addr, PAGE_SIZE);
+	early_set_page_decrypted(addr, alias);
+	ret = tdx_enc_status_change_finish(addr, 1, false);
+	if (ret)
+		return ret;
+	memcpy((void *)addr, buffer, PAGE_SIZE);
+	return 0;
+}
+
 /* Stop new private<->shared conversions */
 static void tdx_kexec_begin(void)
 {
@@ -1033,6 +1052,18 @@ static void tdx_kexec_finish(void)
 
 	lockdep_assert_irqs_disabled();
 
+	/* Drop image aliases before the direct-map walk makes pages private. */
+	addr = (unsigned long)_text;
+	while (addr < _brk_end) {
+		unsigned int level;
+		pte_t *pte = lookup_address(addr, &level);
+
+		if (pte && pte_decrypted(*pte))
+			set_pte(pte, __pte(0));
+		addr = (addr & page_level_mask(level)) + page_level_size(level);
+	}
+	__flush_tlb_all();
+
 	addr = PAGE_OFFSET;
 	end  = PAGE_OFFSET + get_max_mapped();
 
@@ -1160,6 +1191,7 @@ void __init tdx_early_init(void)
 	 */
 	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
+	x86_init.paging.early_decrypt_page = tdx_early_decrypt_page;
 
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
-- 
2.53.0

