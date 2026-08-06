Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F77431A30
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059391; cv=none; b=j8YRUGAneM+vfITAHe2LkWcs8gu5sNCr5xsq3euXbyZV0+jvqglJQ2JtYujxZN2oje8eV+iL20OAfgQ6f23dmy4f8KLjMBxW/cbQgm6zB/JDQU7wQz84G7LXHxMYtWxt+Jgk8kR0L3Z5vWRHLMBrJyDcsM1K5CwX9io1MKBl01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059391; c=relaxed/simple;
	bh=7nJCUtk9B2SvR5o4wifrpms9dp9KqKgrU4RtlPAo6TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KVAsE7LYjYOxzS9Z0WvE3adO0Ij6rIAPqCUyJ+6eFCFaiBlY0szZ9hUGSvwZDrTAgLbxiEAvaw/93icavD811zt8XSr1bxXw0ww5qGMwRt5IK8I5w8BhFJ7rHmwrgRZjoEbGhdvVFtgq0+xbHxK6NbSfnzxlJ9nXmgpd097j/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e3scNbAS; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e3scNbAS"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d004f13426so35028635ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059385; x=1786664185; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VnGiMJAeWdyvdLpQdGy9NuKyd6BkLuzFrwi8wF2quVo=;
        b=e3scNbASaVi0OlUyIWxqNieLbtIHkidcpPpbYOIBBBtEFJkNJq9LAPtehnuTtERCDJ
         YZU50NdHUNUflwB3uMPETcbyeaKjAV/6K3gkt02wuV147HZAUWzrCpIg/L/q1j6D9DXy
         RwwJkxuSLEXhteKVN1lClQoqNZCF2BYfGZGr0uvVqfnwNM8CPX5boyV5sJdWSoTOZSjh
         CgWugxFM/+Kzl7ZkUu1pGaksKMU0ylSPTZhwXH5r0H9N5rlMmJfyocCT0rAG4ESeOjcz
         BQ3lJBn3vrIpoCr+qZYKfnoi0bQB85jLrNI4u2vGmGcfPTi/C2HBUt8Vhv4fiZ7xcxjO
         kqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059385; x=1786664185;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnGiMJAeWdyvdLpQdGy9NuKyd6BkLuzFrwi8wF2quVo=;
        b=DuhujZhOTz2Hm9CAly/THBUoTaB3IxuDnRxLZzNdTLaE+gthfOuqBVv4GpzKA6Ickj
         xVdvBdrUgRiIMeYx4TCJSPyIs2I+D+8jq965Z5YlWtTt2ye1hAPLOynFw6L7gjmDEoss
         j6aaNt29TTZMFT1dSb2Kj99jOzetyXBx2mtRGx2MTirdQ69YJp+++R6uMqkHe0SwydtI
         nYtI9VkZJUgSwLhlB974m4PjeS1Vi0e5Q6X4QJPGuBvLpYJi0ijlMeM0zMfSFnWAfSW6
         J/MP5WFL78dcXbSZi13tuLvPW7ZiwLajddMlvdx+I0oDio46Mg0vWpZur4IZZdMM+9E/
         tRWg==
X-Forwarded-Encrypted: i=1; AHgh+RqjsLD7Fj6POYvQcnrkehrC99M67P7XK3uXFmkxT8CNxhT00Fy68PjO5Kj3T4l4Qm6Fs4B6OQEI8Wlh2YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6qScHxO1SPHsaznM+vODsX74i/XgbNrdIaskdGtoW4GGXflg
	zpK9uwf1jEMgQPTfusQPPBKgyWBoTvN2aZMPvvVpOtUbOnuKxgJ2ROHUCalZcWIcNgXuZ7JpLA+
	zViaW1A==
X-Received: from plzw6.prod.google.com ([2002:a17:902:9046:b0:2cc:6ddb:debc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac1:b0:2c0:e5ee:f554
 with SMTP id d9443c01a7336-2d0ca71b3d7mr204312595ad.8.1786059384888; Thu, 06
 Aug 2026 16:36:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:18 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-2-seanjc@google.com>
Subject: [PATCH v6 01/51] x86/apic: Provide helpers to set local APIC timer
 frequency in hz and khz
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

Add and use APIs to set the local APIC timer period (given a frequency)
instead of open coding the subtle HZ math in all external callers, and
make lapic_timer_period local to apic.c.  Provide APIs to specify the
frequency in both hertz and kilohertz so that Hyper-V and VMware code
aren't forced to lose precision.

Opportunistically take the frequency as a u64 to harden against the
possibility that the frequency (in Khz) is greater than 4294967, i.e. if
the APIC timer runs at ~4.29 GHz.  As pointed out by Sashiko,
4294968 * 1000 == 0x1_000002c0, and thus a Khz period of 4294968 would
silently overflow the 32-bit unsigned integer used by most callers.

Print out who set the period to maintain equivalent Hyper-V and VMware
functionality, and in general to make it easier to triage/debug issues.

Cc: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/apic.h    |  3 ++-
 arch/x86/kernel/apic/apic.c    | 19 ++++++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c |  5 +----
 arch/x86/kernel/cpu/vmware.c   |  4 +---
 arch/x86/kernel/jailhouse.c    |  2 +-
 arch/x86/kernel/tsc.c          |  2 +-
 arch/x86/kernel/tsc_msr.c      |  2 +-
 7 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9cd493d467d4..6946220a6008 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -63,7 +63,6 @@ extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern bool apic_is_disabled;
-extern unsigned int lapic_timer_period;
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
@@ -138,6 +137,8 @@ void register_lapic_address(unsigned long address);
 extern void setup_boot_APIC_clock(void);
 extern void setup_secondary_APIC_clock(void);
 extern void lapic_update_tsc_freq(void);
+extern void apic_set_timer_frequency_hz(u64 freq_hz, const char *source);
+extern void apic_set_timer_frequency_khz(u64 freq_khz, const char *source);
 
 #ifdef CONFIG_X86_64
 static inline bool apic_force_enable(unsigned long addr)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 90025451ace2..9239dca91c41 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -37,6 +37,7 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
 #include <linux/kvm_types.h>
+#include <linux/units.h>
 
 #include <xen/xen.h>
 
@@ -176,7 +177,7 @@ static struct resource lapic_resource = {
 };
 
 /* Measured in ticks per HZ. */
-unsigned int lapic_timer_period = 0;
+static unsigned int lapic_timer_period;
 
 static void apic_pm_activate(void);
 
@@ -796,6 +797,22 @@ bool __init apic_needs_pit(void)
 	return lapic_timer_period == 0;
 }
 
+void apic_set_timer_frequency_hz(u64 freq_hz, const char *source)
+{
+	u32 f_remainder;
+	u64 f_khz = div_u64_rem(freq_hz, HZ_PER_KHZ, &f_remainder);
+
+	lapic_timer_period = div_u64(freq_hz, HZ);
+
+	pr_info("Local APIC Timer Frequency set to %llu.%03u KHz (from '%s').\n",
+		f_khz, f_remainder, source);
+}
+
+void apic_set_timer_frequency_khz(u64 freq_khz, const char *source)
+{
+	apic_set_timer_frequency_hz(freq_khz * HZ_PER_KHZ, source);
+}
+
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 185d4f677ec0..cadc7f872b4f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -646,10 +646,7 @@ static void __init ms_hyperv_init_platform(void)
 		u64	hv_lapic_frequency;
 
 		rdmsrq(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
-		hv_lapic_frequency = div_u64(hv_lapic_frequency, HZ);
-		lapic_timer_period = hv_lapic_frequency;
-		pr_info("Hyper-V: LAPIC Timer Frequency: %#x\n",
-			lapic_timer_period);
+		apic_set_timer_frequency_hz(hv_lapic_frequency, "Hyper-V hypervisor");
 	}
 
 	register_nmi_handler(NMI_UNKNOWN, hv_nmi_unknown, NMI_FLAG_FIRST,
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 34b73573b108..22842bf5b59e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -424,9 +424,7 @@ static void __init vmware_platform_setup(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
-		lapic_timer_period = ecx / HZ;
-		pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
-			ecx);
+		apic_set_timer_frequency_hz(ecx, "VMware hypervisor");
 #endif
 	} else {
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index f58ce9220e0f..615a1f25c83a 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -65,7 +65,7 @@ static void jailhouse_get_wallclock(struct timespec64 *now)
 
 static void __init jailhouse_timer_init(void)
 {
-	lapic_timer_period = setup_data.v1.apic_khz * (1000 / HZ);
+	apic_set_timer_frequency_khz(setup_data.v1.apic_khz, "Jailhouse hypervisor");
 }
 
 static unsigned long jailhouse_get_tsc(void)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 723347e2cf7f..63e26805f8dd 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -717,7 +717,7 @@ unsigned long native_calibrate_tsc(void)
 	 * lapic_timer_period here to avoid having to calibrate the APIC
 	 * timer later.
 	 */
-	lapic_timer_period = crystal_khz * 1000 / HZ;
+	apic_set_timer_frequency_khz(crystal_khz, "CPUID 0x15/0x16");
 #endif
 
 	return crystal_khz * ebx_numerator / eax_denominator;
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index d74743c8d2a4..4bd5f2ae656b 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -212,7 +212,7 @@ unsigned long cpu_khz_from_msr(void)
 		pr_err("Error MSR_FSB_FREQ index %d is unknown\n", index);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	lapic_timer_period = (freq * 1000) / HZ;
+	apic_set_timer_frequency_khz(freq, "MSR_FSB_FREQ");
 #endif
 
 	/*
-- 
2.55.0.679.g6767b8d81c-goog

