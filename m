Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F64D90AE
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934360; cv=none; b=qmHs5EixXDaonOSK4NlrVt/NR4p/2+88t86FOXT7LFYiKA1cFuCZdHvfVAeBzM2KSUZetyR9oJGp9CbgMj6bpF0ygoYO+OINKgKgc05aG5B9E58GE78G664Nes9pT4vQncaeFCb04BocA2YqldKc7D2/EQZ6W2M0iE4yWMaYY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934360; c=relaxed/simple;
	bh=BqZrQFDYqCLPu/01WSmaD7Zj4w0fC0dOaEwcmaj4YV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sTgdQdUf607ULjILeLmzsy8WaFanqUNaCVO875Halbyh0OJJVbvncirJEgR1rq5i+VIpCjhgJqCNWvOvvtgpg9b6ER4KWQZef2G9TqsfrYkRTaX0B/2g3kfZzTV5DbeowtNmJp6LTz6u8+NuJ4Pvx522AOGBHTka2AABA6Q4zjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwIIFytr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwIIFytr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a90cc5e2so1364483b3a.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934357; x=1783539157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f4XM+SKEbnv+9fV8zEMQX/tlhGFDki//v0QnInqZVcA=;
        b=iwIIFytrdqnIVVzJvIYNwgce2pLibJ07p/p8kuYt9HtWfrNVABKlNbXbEiaGBlmumq
         65s+DjZoIePV0ZjWalLJbITSGb2QJXyw5gv4+9xm98uuj9yuqhZc1s4EOVOPtSWmhfwS
         UePzZBqiq+vRZMNnGNrMtwkaihlScP9cWgYwBQ8NTZPHu3EfbQEJOpgXILeh/7u261QY
         MUON9B1hZut9+gRNQn1VNsgpQs3xdUF6d0gnrb/6IPskCdMZZOiCtSrnoCC+jWiQLu2T
         XJ0V3j0TBcei9UgJJzQ4/zS5VeFt9R5yBurg01YKibelpxm1YawZ5y0HVIuuTgQcKzZv
         v0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934357; x=1783539157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4XM+SKEbnv+9fV8zEMQX/tlhGFDki//v0QnInqZVcA=;
        b=iT5kZFXXETO0wvqDj9TAqyVt5h/dw3Q0PHiHVlvSy+foIRtVzUipgQXPxmMP560gbC
         b5SX1++0dWSzsjbt6t0UZzQh9FjYZau0oIEFHGYsxHlOcJ4C+HmRSYlLUESw2IAm1Fxl
         q0+qMWQOMWntZ6674ZLCcdJpYYBjcMkNfGbNPEbwf6JYb0EStXvSzqHReRfXkntgPKpe
         ilj/y7NBTLBHXcMSN0t0/+jB1SNsfIoKyE7EnJwZQRpEc+tipVriECS1596PYoSt3512
         sA9qXkc+QKUT39QGtn6+HdrsR/JL88mXebiEP+FdgFrD//1ruPvM2/FwG0xRK5RDMOn4
         9H2g==
X-Forwarded-Encrypted: i=1; AFNElJ+X25hYC/3VdEdxIZjpUea+1A4AGPQzNkD7FtSWaGt2tWsJLjvGPo49074u5BQvcSyno4okLQ3tq/uF2Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk9RzM6IkcJ/vf19bY5LjcnDCdcukMqFraiuEgGviD8Wsx3fj
	rXYsqoMR6RZ6Uw9Mhsv0lqaLyXrTazxMRhUGH7QvYHvqgYtvnVrLHNqUg3Tt2t5JYVFLPcU9Nn9
	opJqNtg==
X-Received: from pgge10.prod.google.com ([2002:a63:db0a:0:b0:c8c:b193:3b13])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a104:b0:3bf:6c08:fb81
 with SMTP id adf61e73a8af0-3bfed44c700mr3262662637.49.1782934356969; Wed, 01
 Jul 2026 12:32:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:30 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-10-seanjc@google.com>
Subject: [PATCH v5 09/51] x86/tsc: Add a standalone helper for getting TSC
 info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
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
index f049c126e47c..12043812c8f5 100644
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
-	apic_set_timer_period_khz(crystal_khz, "CPUID 0x15/0x16");
+	apic_set_timer_period_khz(info.crystal_khz, "CPUID 0x15/0x16");
 
-	return crystal_khz * ebx_numerator / eax_denominator;
+	return info.crystal_khz * info.numerator / info.denominator;
 }
 
 static unsigned long cpu_khz_from_cpuid(void)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

