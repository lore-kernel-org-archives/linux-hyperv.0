Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166464D990A
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059448; cv=none; b=G//bkDmvIEekA4zo8Ntn7zCK+aYH3bsqxBBy/erarjXjXyT4x8s9X0oel+20DDzGmBBXoc7BJd3oJl/HHGRkXW8rJnFtznwB3Wl+MBnxq6EYjWYmIobHbSX2J/72GpeDzGe+337UzUm4J+i4BxQfOjLcLiPF22Lxl9BB9GZF3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059448; c=relaxed/simple;
	bh=DotEodtP+5nx+qQ2PED5Az3WVrkKwKmbTzb/y5Tt2sE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ws+jtBcZXgMojHNyjLD+ZD6fEfeYfHjoGT/aPN+b4PpwBnmaWA6jKojnQV56qeeBSjoumZsyfrWNzqWFYqUmHYwpZE+vzbWozA/6aZMh2gYkFbE3sioAYmefFae/F1Rszd3qdfbqFNsFgJyxyYIOLJ15+TE1a+xfYZ3dbVRe/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLpLfWHr; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLpLfWHr"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfca8558d2so38193875ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059445; x=1786664245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/TxUyuE9/koLQyW6zcM5dMaQ+pcBou93eYQoJAAWN+E=;
        b=CLpLfWHr+iPxI9WBbdFWWWvKTRL2bJeWYuZfzK0uXV/2EYzCuUezUStwDFpOg6yc5N
         WrI4aUOptdE7Z08WnoTh6IM9q6r8ffiyKLRt0yyDE/HnTzDozpU9UHL7Vi3FZe1ugKLK
         dLYAQuVPiVMGeGqFdlAcbZ51zuVmgC7SbqVvLGJFlMDHokLojUnMRe0nuYX5Hh/VWH85
         0npF2TdFqdA3RuWaLICOv8vabJKCOoefAbCo/gsmw9bYxUGZBt22A8osgxAr4CgtTke3
         OpNhmZe9Tf3v1x+dU3gmcKftdIFhlrOKxUWPXAaS9+d0eMgMA+cUBywRpkP0/TPw3nPI
         2IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059445; x=1786664245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/TxUyuE9/koLQyW6zcM5dMaQ+pcBou93eYQoJAAWN+E=;
        b=owS1wtiCVcY8NxiDzaDvGJ1ujwPVNlEyxkbw0HBeK+x6c4+LP8eG+l/RmKI2xIB/SV
         WqHZVS8WzRkfq7of6ogI1bFGEibgmFvS3QEol17klONFn6b854hrsoxlw2lTUPY2m8tM
         p2I39TpZh6i3+MUcKEodhkBZbMuY5DRUkItCGRP42Qb7HF5sWWXCgQkw8SIZlIM3ZOMx
         7gT8n25LXZmmHct93DaKCsh+gb2LbhOzwzYDHKOU4kX1w/tP3Nh9ZuLdGaf6ooNWD5Tt
         eDZr80hNlTlBTjWVjjasFRcQHmoUxHHTQch+1RBhYPcanXndNdI6TbO7LDXlPPOuX/AH
         qzIA==
X-Forwarded-Encrypted: i=1; AHgh+RoQXMcEsPUu69HwlOV0cIcvBsN3J5jmYp6GjuKFMVgUBZJsphYWuIkcLvODO1QctLyskd9Loc7EMJWIkn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vW7xE2Y6o/2loo3QqJkJe542X3gpLdVZLVTMKf++gDdfLcOD
	lZwHS2ffCU1J6bnBdtUNqT8MGOTEPsy6O+gVilHkQBH2jfX+KdIKm9uNc36d9liaBGJEBU+6Ten
	Oe/dWoQ==
X-Received: from plgi9.prod.google.com ([2002:a17:902:cf09:b0:2c7:e06e:86f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c402:b0:2c9:c952:6e9
 with SMTP id d9443c01a7336-2d0ca7b024fmr202039245ad.2.1786059444816; Thu, 06
 Aug 2026 16:37:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:06 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-50-seanjc@google.com>
Subject: [PATCH v6 49/51] x86/kvmclock: Plumb in AP-online and BSP-resume to
 kvmlock, for documentation
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
index 9c0b2fc98cc9..b954238b09fc 100644
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
@@ -752,7 +758,7 @@ static int kvm_suspend(void *data)
 
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
2.55.0.679.g6767b8d81c-goog

