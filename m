Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066341226D
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934377; cv=none; b=X1U+YcnfvNAJLYu3s7tpvrOWTrHsg3LgYoff/AGO9yEGMGpfsVrj6wd2sbpttKfiQ0jCqrTjD1O9g/2u2Lqu3FhbqtZclVR2fXzDd/21dTLFIKhDIC1Cy51D0a3LAxNOs51GuIFe/GqSgR6uF49znTkG2ER6yKztyG+iSM+B5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934377; c=relaxed/simple;
	bh=ehvol4aPGGdBph7tPEcdqNiMmKvh5DD8WD/ckSXpqow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bAhz1nPUrwWTaScg16ddTmQNVkxJ8KptGCXCzNg+t8X+CA1311rXZquYlWVmlstuVaKI33H2D0BIYP0ntVHM+wnaY9IuNALbUHKlabcuAhEMuRMJcEolLsOmGuaZBcH+lgjLIM6DiiTaO1P4Q8MGtQn8XVj/24EL3oi8HOUgjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/JGcFWh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/JGcFWh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca1f16e391so11746145ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934375; x=1783539175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XQAPpCEE/BDkXN3dIWP18HQMEopEl3zLKZ2PUcc2V5o=;
        b=f/JGcFWh9X32X3N6GvM28619cTdSE/iPF4/e53t4cFm7B4if4byqEPzdf823jJz5ir
         6hIuhr2LTZWHXRmnOWOlOMIzXVRBpQwWxqWIYG3Solt0Ed+kjYkeWG9R6nyN4pW3g2HV
         VTbMs/xTPWkUuJeDUZ2nEiwjkoaPrszGNgkumoELpGUUoFnz8Lf6+GC5/3cPwwTBTPut
         35VRi/V8IPu9wrkD1r+zsMG1gxaO29PTL6jjLH/v4es6yI7MXnMXl3MvPrEvfhjlWcgV
         Xqpycw2Ql1+L86OHACPpPZQ0BxdlxVlYtrme1kd9gSMtObRVQ7Nq7zkqAklqfWvCOPh7
         JNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934375; x=1783539175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQAPpCEE/BDkXN3dIWP18HQMEopEl3zLKZ2PUcc2V5o=;
        b=WNlR1GD9hFtSKam1RKqwx1uQIUK0UKE2P70fN9cD4h83UtU7EOl5whRzAr5VFOyZzY
         0AXdTIEsaX1g0vlzjlCbQJfAPgTjRD9OValJ72959ebp3wMZoHZThvzzMTnNRDbkOteR
         XhW3yujFgrbllglC/rhuKlzf5PD+USHrw2ev3L5Vo07m99quUR2/b0ToUHkmiqm/osGd
         R+yPfiWZh/I0f2e+NQJSUy6tk209OiDXjLikRxaEhBQITC+TbeDXD90N4pspFmJpcqtq
         74ciaxJcpTmUHXKpPFv5JHbUQtd/jQ7zvTZOdQTqAAIyHou7K1HfUBHA2+6aSuUtvDTD
         4bNg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3719/ms5LANFD+4ftlQKZjrm+U0kUJ63C1Pgsg1Ofn6o2OwQJW+Hicvg+VI3n9pO6kEj9czJniVz/aSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyemDH31v4T/TEw6oSPNgG2WPW1th01Y92hPKishMRPTFWc5rqa
	re8v1YN7ZOzQqmKZZaPit78qIR+Uo9cpC8SkGCEcwPKw5FWg1noEoXuHGqh2V96m31z6P3eWjK7
	ouqB4Ig==
X-Received: from plpl11.prod.google.com ([2002:a17:903:3dcb:b0:2b0:46bd:4fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce02:b0:2ca:62e:cc4f
 with SMTP id d9443c01a7336-2ca7e7645d1mr34535395ad.23.1782934374801; Wed, 01
 Jul 2026 12:32:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:44 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-24-seanjc@google.com>
Subject: [PATCH v5 23/51] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
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

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with KVM-as-a-guest, as KVM generally doesn't restrict CPUID
based on vendor.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 31 +++++++++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index c09ec485abcd..cb682f097ea7 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -88,6 +88,7 @@ struct cpuid_tsc_info {
 	unsigned int crystal_khz;
 };
 extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
+extern unsigned int __cpu_khz_from_cpuid(void);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6ed6f8f012eb..56e73e96920a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -668,6 +668,18 @@ int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
 	return 0;
 }
 
+unsigned int __cpu_khz_from_cpuid(void)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+		return 0;
+
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
+
+	return eax_base_mhz * 1000;
+}
+
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
@@ -703,12 +715,8 @@ static unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		info.crystal_khz = eax_base_mhz * 1000 * info.denominator / info.numerator;
-	}
+	if (!info.crystal_khz)
+		info.crystal_khz = __cpu_khz_from_cpuid() * info.denominator / info.numerator;
 
 	if (!info.crystal_khz)
 		return 0;
@@ -733,19 +741,10 @@ static unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
-
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
-		return 0;
-
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
-
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
-
-	return eax_base_mhz * 1000;
+	return __cpu_khz_from_cpuid();
 }
 
 /*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

