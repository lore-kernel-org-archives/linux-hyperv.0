Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1C4DC54D
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059399; cv=none; b=IaViVrIn9c1fGjfhV/7tQMlI91/lxNfB+Lbkylb+i0mdRtqqHJzyNHo/IfjAq2ayb/tHyNVk8lWfX2ITr3lfG43vLnFiQtv8KSQevHA5RKiVVTgXUzUZT+I4lbOyrVsCp0aKjZ5M77LdhnYuGk3EFLdMahCfZzPTKGqNZDPIOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059399; c=relaxed/simple;
	bh=Ip3+9AZjdh0bvA2Vl8RDcUNvlhnW8rCYLw17acrPYF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z/yq+CgbSi9QQRYZwSzHW5Ou7oepL2ediE0ehUHibIDL2qGoALMh8Cta1aWOFe+WvSDiOqlRh4yXknq2RHIrjynHGc1BEIFCP6IjORlwWgFQ2pPGi4KHlHaD60iEZbBqHog/UhcEGbqISXZvJO9AHcdsYLKYKPZ00nAUwR5oMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7kMl+Mc; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7kMl+Mc"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so3727362a91.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059395; x=1786664195; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rOLPH8cbFzmNmyBMg+VXArbJGugFBL/MCFG1XvEwkdc=;
        b=m7kMl+McXQyK9xA73uFP82umikkjT46BQpNphWMHBzFgvnSx9z9erW0dTZ+XnmegZw
         UYbxRHW6+qDIdQ7bqGASxk7Fw1W0Fa1qlC0MBJudI6JQSuEbADDOkFY0HhwOuGRNeOyR
         CpaB76qaWkIQsnFvsgyY3ONOKueFuDhpmm3XTagSP90smUFZq/IbHAsInvzfHCo4SLF3
         p+7vw+4WNV5qxLJYL/KSbcQpA5fOR6+FZYZB7f8+cmCoxMqLMCuebTQF2KN1zjr7b+de
         MudaXY8sxMngBzTdG23X4Qhm7P40KRXRwoIxkiVGWdjCkh3g8RI6A4rWLPTi88xgGth3
         uM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059395; x=1786664195;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOLPH8cbFzmNmyBMg+VXArbJGugFBL/MCFG1XvEwkdc=;
        b=pw/57pdLAPVZJ9NcRie6hMUj1CvzNS4udJzmCpiwQAYi7zCe4hOaG4n5LgIeH6ZJYj
         Zwnyh+aW4mpX2/503MrJ8o1412QfNzTAKT90suPShWKvXAQPAEOgX/W3Tfu/fdAjm8l4
         9b7aK/AsPgosxiN9HaNdphkms7XoOk6lj4OrDLzzIfGUxqjHZjKJZ4/1o/JDC/1EVDab
         B4SHiBfmolC3GhumagWdpeHRLD0VGvotuTCuZ+cZCgELct5gs7unyjcseBYGyhjsOcNJ
         Beu01bowi/b3LTvrrUly9RSfv/+qennyE1GrK2KeK4S6XQirzFusEtks3+8/CspxPevX
         BFMg==
X-Forwarded-Encrypted: i=1; AHgh+RqbNcP0Q+w2K8uXjnL8X/NxFRV4xFWZ++bRUo5hJpXrbyIfgVzZIh0k+6jz1XsxlkwiHs6RR1bMr7z+e3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8f2ZbEnNfuElGEz0rkHAnUVwWkZbY2Q1fODIN4WRYdhhowFCw
	LEpkDHJAd7i5/iE4XX7/2PwTS0vzBMOnTqR4hxI6brkd0Wj2HILU8s5d3tXJ/O52Azq3rxS8reg
	Y3wSRUQ==
X-Received: from pjte20.prod.google.com ([2002:a17:90a:c214:b0:38e:7f69:82cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5683:b0:38e:6aa7:68ad
 with SMTP id 98e67ed59e1d1-3903c54fbc4mr18735745a91.5.1786059395009; Thu, 06
 Aug 2026 16:36:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:26 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-10-seanjc@google.com>
Subject: [PATCH v6 09/51] x86/tsc: Add a standalone helper for getting TSC
 info from CPUID.0x15
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

Extract retrieval of TSC frequency information from CPUID into a standalone
helper so that TDX guest support can reuse the logic.

Opportunistically drop native_calibrate_tsc()'s "== 0" and "!= 0" checks
in favor of the kernel's preferred style.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 61 +++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6898584610a7..d405ff4e45e0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -645,46 +645,62 @@ static unsigned long quick_pit_calibrate(void)
 	return delta;
 }
 
+struct cpuid_tsc_info {
+	unsigned int denominator;
+	unsigned int numerator;
+	unsigned int crystal_khz;
+};
+
+static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
+{
+	unsigned int ecx_hz, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+		return -ENOENT;
+
+	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(CPUID_LEAF_TSC, &info->denominator, &info->numerator, &ecx_hz, &edx);
+
+	if (!info->denominator || !info->numerator)
+		return -ENOENT;
+
+	/*
+	 * Note: some CPUs provide the multiplier information, but not the core
+	 * crystal frequency.  The multiplier information is still useful for
+	 * such CPUs, as the crystal frequency can be gleaned from CPUID.0x16.
+	 */
+	info->crystal_khz = ecx_hz / 1000;
+	return 0;
+}
+
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
 unsigned long native_calibrate_tsc(void)
 {
-	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
-	unsigned int crystal_khz;
+	struct cpuid_tsc_info info;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+	if (cpuid_get_tsc_info(&info))
 		return 0;
 
-	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
-
-	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
-
-	if (ebx_numerator == 0 || eax_denominator == 0)
-		return 0;
-
-	crystal_khz = ecx_hz / 1000;
-
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
 	 * CPUID_LEAF_FREQ for the calculation below, so hardcode the 25MHz
 	 * crystal clock.
 	 */
-	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
-		crystal_khz = 25000;
+	if (!info.crystal_khz && boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
+		info.crystal_khz = 25000;
 
 	/*
 	 * TSC frequency reported directly by CPUID is a "hardware reported"
 	 * frequency and is the most accurate one so far we have. This
 	 * is considered a known frequency.
 	 */
-	if (crystal_khz != 0)
+	if (info.crystal_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	/*
@@ -692,15 +708,14 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
+	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
 		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
+		info.crystal_khz = eax_base_mhz * 1000 * info.denominator / info.numerator;
 	}
 
-	if (crystal_khz == 0)
+	if (!info.crystal_khz)
 		return 0;
 
 	/*
@@ -716,9 +731,9 @@ unsigned long native_calibrate_tsc(void)
 	 * lapic_timer_period here to avoid having to calibrate the APIC
 	 * timer later.
 	 */
-	apic_set_timer_frequency_khz(crystal_khz, "CPUID 0x15/0x16");
+	apic_set_timer_frequency_khz(info.crystal_khz, "CPUID 0x15/0x16");
 
-	return crystal_khz * ebx_numerator / eax_denominator;
+	return info.crystal_khz * info.numerator / info.denominator;
 }
 
 static unsigned long cpu_khz_from_cpuid(void)
-- 
2.55.0.679.g6767b8d81c-goog

