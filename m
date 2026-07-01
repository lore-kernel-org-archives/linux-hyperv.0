Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD444C9556
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934350; cv=none; b=Zws8KcldLhfMyQOwNvbcW9WkFgK/2vNmQnjraXodd/7f9xt3TELBGS2HgHMwGvJDqhzyWINA/q8qreyxgcFNo29VT/Hn4NTaB3xRuu/x7NzS10PMvK4fxrX4Ec9bmGIGxvSdYHXiMuM0i3mtKN5smOV7F5Fzo8I0cMKinRjMnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934350; c=relaxed/simple;
	bh=0N92npWFwQpDgzq6TxntM7pcGurQzibnGfUzvkQVrqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nz+xhFn7bLF5ZQnQ3tyQ5a7pe0+kVAEE4h5LnxJJEWEoO2twYhODlyaBsTfmJsXtbAlpVgOJprbjvR1hAQaV+S5wV+ccNhaUuviIywK+jq3IU8G2ja3iG1VXYTApA52BFe2gzOGl4Ini3M1mgOktNVcATTBd4d4cjw2d1A0NQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxKeSecl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxKeSecl"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9f452d260so14890265ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934348; x=1783539148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t7xFvhsXyUl34us7SMoRDgC7NN8K9lGkg6/G6zp7sLk=;
        b=SxKeSeclRpnbZ4+aPNw+ubC7k25HfD7Xg9CxAfklglUxv0Znlp0xM/pJihcBtHJY8j
         yk4ebKen4zZ/yb1fGQ2XCr5bihf8B/y9RTyN0tlnt5mHLR3nWHMHgtcBVm84MZQBYk4p
         7G2bjuiUsVgsuMbI3JAHhpE2zwYQ2Dc1Qmgdqvemj9by47qCnmnYgRId3O2ILQaHZh0m
         k5eR8/ScmAZj2265SacvN+iOkgyFI79TuOXM6Z8zRESXs+CTBHMM6Cbop4XJqP5dmKhg
         5hjCbfOzTXZ8Z3ilaPB69/2K0+Wu/7p1AmtlmFH3Ifa8E8RBHGubUQ3JZvSwE8CNVreP
         B37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934348; x=1783539148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7xFvhsXyUl34us7SMoRDgC7NN8K9lGkg6/G6zp7sLk=;
        b=pU4pLmtXlqs1Ka+NLmyeQY+RyEhjJgnzMbCRc9sOkRhH08j/UtwvE0VacJh33g3ArC
         ueRoovsOiiq63lMbZyE+f6ygRij0MnpWIq6MeMxIZhnq3ML+7DskevnHq6eIFpkk4Dtw
         ZqCWSsNuJOYSwQiRnPTJNO2nhgt/CO93xOPOhCaJiIbeb0fk0hi0XGOZIe7GPe819kn7
         FSIhPndYxlmV0i1aRKZwrM1TR9oxQNa+1ek0IBuZhsVKnXt7owubcSR2EzsZF2tTfpYi
         8aDWY0sWdwL7fbBfadvlUfQCl/ui5MJQxz5vgLNRUlwALUKa04U8hfB9Pn+XsDAVSYQZ
         IDYA==
X-Forwarded-Encrypted: i=1; AHgh+RpcJv6vtviCbET3fXbeeuuEc1OVRofbgnkAxETdDIgC93XSyTy4CJIcZwnLlrejbEiHeDIhEzBkslLEjno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7uzEfyPu2/U/hUgfrh7svfNtFfN9nkjxI3Hzva7ppmRh5zW4
	m1Hox4xB5+tJMjCSgJH8YkB2W3IfQtYHec9UYM7lhfWoMEAR9OXfk78MJCFrAWDfTuDQ20tMKGe
	OcGPbtA==
X-Received: from plbmk12.prod.google.com ([2002:a17:903:2bcc:b0:2c8:219a:17e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19d0:b0:2ca:53e9:1277
 with SMTP id d9443c01a7336-2ca7e714f7fmr32655485ad.1.1782934347423; Wed, 01
 Jul 2026 12:32:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:23 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-3-seanjc@google.com>
Subject: [PATCH v5 02/51] x86/apic: Add CONFIG_X86_LOCAL_APIC=n stubs for apic_set_timer_period_{,k}hz()
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

Add stubs for the apic_set_timer_period_{,k}hz() APIs when the kernel is
built without support for a local APIC, and drop #ifdefs in callers that
don't need to check CONFIG_X86_LOCAL_APIC for other reasons.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/apic.h  | 2 ++
 arch/x86/kernel/cpu/vmware.c | 2 --
 arch/x86/kernel/tsc.c        | 2 --
 arch/x86/kernel/tsc_msr.c    | 2 --
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index cd84a94688a2..035998555e99 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -189,6 +189,8 @@ static inline void disable_local_APIC(void) { }
 # define setup_boot_APIC_clock x86_init_noop
 # define setup_secondary_APIC_clock x86_init_noop
 static inline void lapic_update_tsc_freq(void) { }
+static inline void apic_set_timer_period_hz(u64 period_hz, const char *source) { }
+static inline void apic_set_timer_period_khz(u64 period_khz, const char *source) { }
 static inline void init_bsp_APIC(void) { }
 static inline void apic_intr_mode_select(void) { }
 static inline void apic_intr_mode_init(void) { }
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 36f779dd311d..13b97265c535 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -422,10 +422,8 @@ static void __init vmware_platform_setup(void)
 		x86_platform.calibrate_tsc = vmware_get_tsc_khz;
 		x86_platform.calibrate_cpu = vmware_get_tsc_khz;
 
-#ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
 		apic_set_timer_period_hz(ecx, "VMware hypervisor");
-#endif
 	} else {
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f9ecc9256863..4d6a446645c0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -710,7 +710,6 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * The local APIC appears to be fed by the core crystal clock
 	 * (which sounds entirely sensible). We can set the global
@@ -718,7 +717,6 @@ unsigned long native_calibrate_tsc(void)
 	 * timer later.
 	 */
 	apic_set_timer_period_khz(crystal_khz, "CPUID 0x15/0x16");
-#endif
 
 	return crystal_khz * ebx_numerator / eax_denominator;
 }
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 7e990871e041..aece062aee7e 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -210,9 +210,7 @@ unsigned long cpu_khz_from_msr(void)
 	if (freq == 0)
 		pr_err("Error MSR_FSB_FREQ index %d is unknown\n", index);
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	apic_set_timer_period_khz(freq, "MSR_FSB_FREQ");
-#endif
 
 	/*
 	 * TSC frequency determined by MSR is always considered "known"
-- 
2.55.0.rc0.799.gd6f94ed593-goog

