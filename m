Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483842D71B
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934410; cv=none; b=Dc9rRPyz0Mu+yXN1Y+PG1vj/5Jyj7ItxxrL1IFvipsJ/hwDxpENGkOazWKA5SuxivkL09xFDicJAIq5g4N+c6p4hNNq8QcjqYQFtF0dAf7DGnGqHMfMBJpBMPp/KeNdAqx93+Dq5rApahgIccWUFbyXSp85dmDht26zdQ+87IZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934410; c=relaxed/simple;
	bh=1PQjxlx5nubnpTfQaTN8BFLRTtJFTrF7SV6DilzQr90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OTIZpzTLjnrXt2hZJ/A6HUby0NY1Q8LeGoZTLSmje1DrEFNGVcV0HpUYPszA2Jk04Rasy+i0ui1DV0tTf1Any219wvP9SzsklRlsZGW3Qk8Bd3S2FZn/HSwiKOkoe+u6zWpzIkwdwbzUohqRWpkHGCDVCFBc01l+wMUGh84YCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dv/irHEq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dv/irHEq"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca1f16e391so11759045ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934406; x=1783539206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TVQraC4E63kxSjnR08hIOoNSz/X8YqL1FfZb6Oo6qbM=;
        b=Dv/irHEqt0nTIm9YtSOaBUL50OgmzGDj1bZ2fbidixjdaiBmbYE6bqInZbF+o3sCCj
         0EnKUciZAIrk3G7WkbYEc8RSDHVaVf+DUygUrer3z+u2vzhMHnIQGDpuHzA2FMy4xXAH
         ACWFJRqij4niFHZseKv31PQmZ8QQDHnT9xkyhrxer3YDp4jWZsdHRtc054+X64XAUk3F
         Hef5rYnwcuvgVa7oYtjfdVairYV5FUQzn+LP5GHoWJA2U1rhLT1zoFqikhH55Z/CKQEe
         ccZfBP1ZcCovCtr/QED88tJNcj42CrTZgOgsej6Wz16DIqCRzOq0DzNOmdRfy/nxyDt/
         zVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934406; x=1783539206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVQraC4E63kxSjnR08hIOoNSz/X8YqL1FfZb6Oo6qbM=;
        b=EaqjfJlQBlKZuDuU6KKf6RdXb6Zp/ppimG3gOuqAhKEN7mbJR3xvJ1WZFgc1AI1igp
         7WkO0HHCTlFPFkq/YR8DzxoIESh9mXa6rsxx/Owj63egsahZAQ4WjtGUCjqxsNhEN0dn
         XtyNGalaTK92BggnQv0FsiOF7NeysHXKw/Nl9FMKFLDISL40xpKIIGa/CP1+ujFSwxhX
         EMBd8QISnAYGJx+fl2H69br5/pOXZqMoD3F5XLJcFsA+wtIKFH3mtnhaQY1Ta0tdcRYA
         KSB4UcM1Y1vCFeR9GrNgvOXFbh1ZSv+R5yI3NrBCir0FFy9AfuqBXFAT4kj1jDxL6c6G
         44Sw==
X-Forwarded-Encrypted: i=1; AHgh+RrSr/mOIEHFsQgnccuzMW1IdTt5k8YePcGJ1A/yaa53qeXzoBRbIv3fHyIkKBa1lwglOf8oXcaNRwYfGA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUEA5FiORVyhybwplQmRvTukFWd5Zp90Yh1w2EFtdXvKSftC8
	2AbhLbP6SS5RLyvuigvh6znf9SyBl493P+drPkH5BtrmT138899L6KqPeis3P+p65Nz8yslEFXJ
	0HOEXZA==
X-Received: from plkg7.prod.google.com ([2002:a17:903:19c7:b0:2c6:a4ed:efee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94c:b0:2c9:c97e:71cf
 with SMTP id d9443c01a7336-2ca7e683909mr35659695ad.6.1782934405912; Wed, 01
 Jul 2026 12:33:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:10 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-50-seanjc@google.com>
Subject: [PATCH v5 49/51] x86/kvmclock: Plumb in AP-online and BSP-resume to
 kvmlock, for documentation
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

Invoke kvmclock_cpu_action() with AP_ONLINE and BSP_RESUME, even though
kvmclock doesn't need to do anything in either case, so that the asymmetry
of kvmclock is a detail buried in kvmclock, and to explicitly document
that doing nothing during those phases is intentional and correct.

For all intents and purposes, no functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  2 ++
 arch/x86/kernel/kvm.c           | 22 +++++++++++++-------
 arch/x86/kernel/kvmclock.c      | 37 ++++++++++++++++++++++++++-------
 3 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 08686ff19caa..763ed017738a 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -120,6 +120,8 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 #ifdef CONFIG_KVM_GUEST
 enum kvm_guest_cpu_action {
 	KVM_GUEST_BSP_SUSPEND,
+	KVM_GUEST_BSP_RESUME,
+	KVM_GUEST_AP_ONLINE,
 	KVM_GUEST_AP_OFFLINE,
 	KVM_GUEST_SHUTDOWN,
 };
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 604b52f233aa..f9a6346077b0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -474,18 +474,24 @@ static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
 	kvmclock_cpu_action(action);
 }
 
+static void __kvm_cpu_online(unsigned int cpu, enum kvm_guest_cpu_action action)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	kvmclock_cpu_action(action);
+	kvm_guest_cpu_init();
+	local_irq_restore(flags);
+}
+
+#ifdef CONFIG_SMP
+
 static int kvm_cpu_online(unsigned int cpu)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	kvm_guest_cpu_init();
-	local_irq_restore(flags);
+	__kvm_cpu_online(cpu, KVM_GUEST_AP_ONLINE);
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-
 static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 static bool pv_tlb_flush_supported(void)
@@ -750,7 +756,7 @@ static int kvm_suspend(void *data)
 
 static void kvm_resume(void *data)
 {
-	kvm_cpu_online(raw_smp_processor_id());
+	__kvm_cpu_online(raw_smp_processor_id(), KVM_GUEST_BSP_RESUME);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL) && has_guest_poll)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index bc98ebb8587d..842f38c5f6ca 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -150,7 +150,7 @@ static void kvm_save_sched_clock_state(void)
 #ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
-	kvm_register_clock("secondary cpu clock");
+	kvm_register_clock("secondary cpu, startup");
 }
 #endif
 
@@ -174,13 +174,34 @@ static void kvmclock_resume(struct clocksource *cs)
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
-	/*
-	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
-	 * being used for sched_clock, then it needs to be kept alive until the
-	 * last minute, and restored as quickly as possible after resume.
-	 */
-	if (action != KVM_GUEST_BSP_SUSPEND)
+	switch (action) {
+		/*
+		 * The BSP's clock is managed via clocksource suspend/resume,
+		 * to ensure it's enabled/disabled when timekeeping needs it
+		 * to be, e.g. before reading wallclock (which uses kvmclock).
+		 */
+	case KVM_GUEST_BSP_SUSPEND:
+	case KVM_GUEST_BSP_RESUME:
+		break;
+	case KVM_GUEST_AP_ONLINE:
+		/*
+		 * Secondary CPUs use a dedicated hook to enable kvmclock early
+		 * during bringup, there's nothing to be done during CPU online
+		 * (which runs at CPUHP_AP_ONLINE_DYN).  When kvmclock is being
+		 * used as sched_clock, kvmclock must be enabled *very* early,
+		 * and even when kvmclock is "only" being used for the main
+		 * clocksource, it still needs to be enabled long before the
+		 * dynamic CPUHP calls are made.
+		 */
+		break;
+	case KVM_GUEST_AP_OFFLINE:
+	case KVM_GUEST_SHUTDOWN:
 		kvmclock_disable();
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 /*
@@ -382,7 +403,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
 	this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
-	kvm_register_clock("primary cpu clock");
+	kvm_register_clock("primary cpu, online");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

