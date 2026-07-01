Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6EB4DB56C
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934367; cv=none; b=o+ZyjYRm5tAIsSkHOsQI9KLPHgxVZpEDSGATpwD7nNngS4DteCdn+2ZYOCyUUDhPCo/njuS3tAtgtcGBBYaQqoGmNXB/whppIgBXZW8rJA8J8DEtl5k5e/9vcbnAhkmzQbHV1DbOvSUd+kdQAt7kYYxxOigdrhkbMi49Ut4Sr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934367; c=relaxed/simple;
	bh=Gnih5LrGkG8ktdHYV+2HKjvX94Rde895YkWyNLJNx+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2RGdSliTwT+87m8FPMU51McbpYjoddrRxmgPMaGn96nGdC6PYIP3unyCgMeba0Jl/FEIbYFehTD4YvNJ0HpCQEK6E1zSkx+AxQYMY2ikKJrQvz2q3WD/hGg+iU0CGgBn7UvW0P86BMfsuVEAbG9yDvfYHSBfA7JimfwLFTW6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eq29z/DN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eq29z/DN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8895156101so863128a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934364; x=1783539164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JEJEfFzkyRhChopEv3/Eo+3SUmzyKJlolrUUxvPFGQs=;
        b=Eq29z/DNm+7b6n6eAHhSUelccfILnQOMcMiWSt9kEODZbsejylgDr7+ZYJpC+0kLRM
         6KJ9UjU+G9lJVjsFTIoWf6VUqt6s5qcaHIbiFqFi3opZUVOHdQme7Mqkjjntpmu07Kp3
         W1VBOM5LWFhlRlB72WqYZ6xrIA8uSfE8iHxAOckpNRQR5zAICyq/pdoSVKiqB8a3gUtx
         wjlbrVkMw0r93eZEWj3563+R9GYFdLQd+UNUsKiWj4IkFSBadUhY7qtkrsHyNpIzqeB8
         kTteUoxZzYUIma3wLNA8i+giR/WqHZJS7Q522iFG0rji1MVV86I6TGga3FzrZypaL9F0
         jzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934364; x=1783539164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEJEfFzkyRhChopEv3/Eo+3SUmzyKJlolrUUxvPFGQs=;
        b=V4wiZUThR4jlplvZ0kZp3wD5stOuzIvhD0IIwjFDKbRb9h3JAD00l562t/VcP+PsTf
         EWCudnuMA80R87jEul5P0QwTnxmis9sukJ8dhB+Ku7xOBMl7QMdJj37hay53xl2uoEd4
         Gyd4vAEGOHJYBFWH8tHzZp2tG+p/ynpzrB/bG8tDtF9C2sNuJKd2CevxYzx2KZxNjobt
         VUPyfR7JKcSa+bSKkw7IFoomGrNQIuz3QJoLWF+t6qI1XxYrh+TQPGr5deIP/NaySBEi
         8tLGTXOdqZcRC+v2ia8DK8T2EoLbbKycyLTqdsZOUCNTfKHjTRmk4DOn2bXhvtUpieo+
         n3Lw==
X-Forwarded-Encrypted: i=1; AFNElJ9QBRRs+qQjcA87tM3XrJ9KHl3UIbRjfeZJPUasBZM1MtWZDqb9MSJNkwNXpoEttHWIxcTfKtAnE1a1n3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GY2I7QbL23PM+rwvowLV92v249hy1XKZzPp4ApOJaxOYK+6A
	Scrz7S2wKvs1Ht9oJH+O0UthCykyMWgaQzXgxMgVSCRgFoF8QvMrSGnQJoI5gkUQfpja5GeFsY6
	a+zWWCw==
X-Received: from pgbda6.prod.google.com ([2002:a05:6a02:2386:b0:c99:7baf:125f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7288:b0:3bf:b1f4:747b
 with SMTP id adf61e73a8af0-3bfed0e2904mr3197752637.12.1782934363113; Wed, 01
 Jul 2026 12:32:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:35 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-15-seanjc@google.com>
Subject: [PATCH v5 14/51] x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ
 for PV code
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

Now that all paravirt code that explicitly specifies the TSC frequency
also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is known.

Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was provided
by the user.  Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_khz command
line parameter"), one of the goals of the param is to allow the refined
calibration work "to do meaningful error checking".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c       |  1 -
 arch/x86/coco/tdx/tdx.c        |  1 -
 arch/x86/kernel/cpu/acrn.c     |  1 -
 arch/x86/kernel/cpu/mshyperv.c |  1 -
 arch/x86/kernel/cpu/vmware.c   |  2 --
 arch/x86/kernel/jailhouse.c    |  1 -
 arch/x86/kernel/kvmclock.c     |  1 -
 arch/x86/kernel/tsc.c          | 13 ++++++++++---
 arch/x86/xen/time.c            |  1 -
 9 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index bc5ae9ef74da..72313b36b6f5 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2027,7 +2027,6 @@ unsigned int __init snp_secure_tsc_init(void)
 
 	secrets = (__force struct snp_secrets_page *)mem;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ae2d35f2ef33..94682aca188b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -1205,7 +1205,6 @@ unsigned int __init tdx_tsc_init(void)
 
 	/* TSC is the only reliable clock in TDX guest */
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	return info.crystal_khz * info.numerator / info.denominator;
 }
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 3818f6ae0629..dc71a6fdd461 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -40,7 +40,6 @@ static void __init acrn_init_platform(void)
 	if (acrn_tsc_khz_cpuid) {
 		x86_init.hyper.get_tsc_khz = acrn_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = acrn_get_tsc_khz;
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f9bc1c2d8c93..e03c69a4db33 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -575,7 +575,6 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_init.hyper.get_tsc_khz = hv_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = hv_get_tsc_khz;
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3cb473cae462..0a3bd90576d4 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -390,8 +390,6 @@ static void __init vmware_set_capabilities(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	if (vmware_tsc_khz)
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
 		setup_force_cpu_cap(X86_FEATURE_VMCALL);
 	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index e24c05ab4fae..ff173052cdce 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -255,7 +255,6 @@ static void __init jailhouse_init_platform(void)
 	pr_debug("Jailhouse: PM-Timer IO Port: %#x\n", pmtmr_ioport);
 
 	precalibrated_tsc_khz = setup_data.v1.tsc_khz;
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	pci_probe = 0;
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4f8299303a19..35a879d33e9e 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -138,7 +138,6 @@ static inline void kvm_sched_clock_init(bool stable)
  */
 static unsigned int __init kvm_get_tsc_khz(void)
 {
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1dca9464b41c..676910292af7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1541,11 +1541,18 @@ void __init tsc_early_init(void)
 	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
 		known_tsc_khz = x86_init.hyper.get_tsc_khz();
 
+	/*
+	 * Mark the TSC frequency as known if it was obtained from a hypervisor
+	 * or trusted firmware.
+	 */
+	if (known_tsc_khz)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
 	/*
 	 * Ignore the user-provided TSC frequency if the exact frequency was
-	 * obtained from trusted firmware or the hypervisor, as the user-
-	 * provided frequency is intended as a "starting point", not a known,
-	 * guaranteed frequency.
+	 * obtained from trusted firmware or the hypervisor, and don't mark the
+	 * frequency as known, as the user-provided frequency is intended as a
+	 * "starting point", not a known, guaranteed frequency
 	 */
 	if (!known_tsc_khz)
 		known_tsc_khz = tsc_early_khz;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 1adb44fdddb2..487ad838c441 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -43,7 +43,6 @@ static unsigned int __init xen_tsc_khz(void)
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(info);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

