Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395445348D
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059398; cv=none; b=J9zczp/fmr9YYV8Yl9qaAdQe2DurE6F5ehc5FRGlWUd/5MOzhFR+XlRvhZn5bOegWL9f6qrBB26ziGweKzownWkiUOId5+oON2BVhT/997BEZQNXU+sKNvUDMPaIPAmvjV5Kg0eczv8tDlFyF8cL+Fp9GIPBrlRmj0T9Pzgaoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059398; c=relaxed/simple;
	bh=uHCr+aGd0IVIljQJaBiD1XMjX+0uHia3XbUwy11kdUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WsFWzIjoYbuqUTVqMzODW9QDVI6/h+5NfCUe/62X3Zs617trcC8jpGvLp3Lo5KNAc4wfrEPCaqOPg2tr4u7dP1HUyhz1fh985h/a+0Vf4/ioUdMcVGBAkiGQIy+oWypgOSCozTOCql1jbAb52vbEDh6hr+SMNI9IkRs8k1D8TaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjPeoHqh; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjPeoHqh"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfca8558d2so38184805ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059393; x=1786664193; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AA+qmVUXq1UZoUYGqhY11Guml9As0mrU+L3gWPkVgC8=;
        b=hjPeoHqhhitFmoDkk39+ffNLdd16jbWlNp72LZlKYC/BSDry2ANT86JOI8WgU5aoMZ
         4Lyh380lL/I/JKYe4k7gh4E78PS/oaMhR45vrMo65j5XUvEFrg8VVek0sqpaZ0jmp7eX
         2Yl2loHtsrxQlB4yEPngoh1ggXjTwNMwFmz8D3xCLCihkike3liuhCGZ+Ya0ZIHPkxb8
         FeEIVAKeKaEwRV6DpGeYlulwjn8TNs5AX2DcPXmlCECugMEEtq9I7k82+7JBSCqcpgrC
         Y7ygvED2/Ix3t5n8SzqwN/jkYdOB7ylhVD2jzuEDA/7ho7CyY1tA0XuspFlYjquZI25w
         N6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059393; x=1786664193;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AA+qmVUXq1UZoUYGqhY11Guml9As0mrU+L3gWPkVgC8=;
        b=c7Jl5mgWUdpUKn1vxIpqds36iDDNsUFILX2kJ69kxYlQQPTo+xRkxidZTt7FWboJ4f
         p6z8/XhsygqN9jOHmKdXNc09Mxf1RZ/4pZ6rbheG0aZxiKuEhKLwfkbXxyn4MsRvaotU
         XOYwH2emv2wIhdzdN/YQYaurS4+3ELDFrOM5TFWHfbGVsgBKMM/gH6hOdjH5Q/jiPc74
         jc9i4ifBMSeK8nW7etBCPfi+9kW2lVkk70ytqR/uvCJasA4p/Q2UrSl1ZyZLI82Mjk92
         Z5vLZWX24XQRfD7yEtvLiCTu3V+Aeqf2IjBeeVQDQKG25aOMXH1XqcXGJ5lbZjqXCDkb
         kc8A==
X-Forwarded-Encrypted: i=1; AHgh+RqbI5hyjHGIAIsYedhO8vlXSMotdqvH7SmxS2UPk+ZGcF7SKRFjhLmLxfYAgOVcJEeUuLR7d2wnRlLKd2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUhe6l4bMe0BkaCqUgeS0NsSqz1u5mosB3aB40hWukS4R+Ngm
	25rXCg7lgq/dTl6lJSwiQetMKAYIJUy+RouybBA6Mb3SE/P70xFRrB3lETqG/4Oetwn7y47z6rZ
	sw+Mydg==
X-Received: from plbjc21.prod.google.com ([2002:a17:903:25d5:b0:2ca:d66c:97b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef0a:b0:2c9:c517:d070
 with SMTP id d9443c01a7336-2d0ca7afebcmr224927325ad.3.1786059392825; Thu, 06
 Aug 2026 16:36:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:24 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-8-seanjc@google.com>
Subject: [PATCH v6 07/51] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Move the check on having a Secure TSC to the common tsc_early_init() so
that it's obvious that having a Secure TSC is conditional, and to prepare
for adding TDX to the mix (blindly initializing *both* SNP and TDX TSC
logic looks especially weird).

No functional change intended.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 3 ---
 arch/x86/kernel/tsc.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 665de1aea0ee..403dcea86452 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2025,9 +2025,6 @@ void __init snp_secure_tsc_init(void)
 	unsigned long tsc_freq_mhz;
 	void *mem;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		return;
-
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 09bf10f322ba..c710c71a1bdf 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1509,7 +1509,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.55.0.679.g6767b8d81c-goog

