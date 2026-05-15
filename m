Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC139184B
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872853; cv=none; b=uNnkP0u7cL6Daf5jjBd/yhNzxZzJVvIqHqETUNfULV/BQ5SlpYbMiq9L1OnkEMa6YprLlNKIZBzbwqcGaZDJRTz1NtwIC5ibuM1O6YZ/bOMdXx1DeNYNmuCctbWcbjFMN1KjJ73pHkjF0S4m2UuR7I0P+US5jWo27p4s4C/psWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872853; c=relaxed/simple;
	bh=F9WUpGZj1miTCwUFuamAuxgNbr/h7T971FWwjKtok0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eDiyM7vuk1dRZjQo0ARezHhnyWTGqE3Cn13JFvM2rmTpP3XUOqB6dWmC/+IUOZOhjkHPBT43j9XGAQl9hI3zfnfneTn9OjufyhEzGUVKT5J3+Sqm/0FLu2GQA6i1l5CnQEzxcWqCr9SQGA7U3LP+oobGpz7kd/GbN+5N+Z6ji4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkQ404gL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkQ404gL"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd15c00a1fso15033245ad.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872850; x=1779477650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HxeaHaxP6KnUzzL58lskoB535u+ahD+SqcMQMaRjbjY=;
        b=CkQ404gLc3NPI0iJRx6TL6bIRb8Hd/iMKv/XqaENPkELMQaqj5477betlpcZlsGPqu
         wUa/q7ThWbrCU0tRcrTJ92hNbf7+wDO7YJ/asuF0IV4PxAHu2uSI7JCS90/ZdI9KADb8
         RK26FS2sSAkTjq93bpcd1Hqz/FgTOMejHDhRdTH74JY/UssoRxQ5O6L4ICg3k9alo8UO
         mB/t2AN6TyxFf5a4XyBTi1RwH29A/emWzgIi/q0vhlbLDlDBomUVIoi10+Ef0nIrzaQM
         V3Fy9KuzM0tEP6LSa47I3ean7Bzn6JDTdLEepfHeG7MgYxSOwTTPqDaMSrrSr/Wuq6IO
         U2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872850; x=1779477650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxeaHaxP6KnUzzL58lskoB535u+ahD+SqcMQMaRjbjY=;
        b=gX26bgvyKoPeL1SCxDNppsf9uZ3eUGFP2jc42Lo3Dm15EIGJo6CGl8ukVxiFx+KWFP
         d4rp1AmC6usoKZzt/6hk79oifKfNr2mFWyyLbwFar6Fa07y1HvSbhTYEPrAa7IYRSd/Q
         uJRRedWypJPUTRvMPEZaGgq8l8ow4tCQzahce4t7ghMK6x+mIggCLZD6SKweQi6SpMgd
         pHlOlr6zMQcODBo743/cL4dIYE6SkpbZyPiaDqbyEbCzVnXgmhhXuTsRi+/rK4hFENWC
         swmv+Azgf1eYZJQCq9tw2JeaELkdbpOryUk/H/T2jWHOGfqDUYnIvZqkQe22lj0T2QDF
         5hwg==
X-Forwarded-Encrypted: i=1; AFNElJ/lf9x/U0XrB/vEr93F7IS5BjL+2bbQTHM8XGDdzpNSJZvhrVHNOV0vU7DmPXhLgkLDhA+/ATCNtLASs94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXH73C1oxtJT+BGso41wRi/xBUr2saZd7hvsbGdbfd53VhtVV
	HTEBUXdLEs1xUiUSbBZlBP3OZNWp2RWu3scaBqrWm5jl+FfFFaMJIUoFVwdpUjanDx3WmyHNgzJ
	SwvcegA==
X-Received: from plhl17.prod.google.com ([2002:a17:903:1211:b0:2ba:73fd:6d36])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:943:b0:2ba:5e99:93e8
 with SMTP id d9443c01a7336-2bd52b6d778mr87428535ad.29.1778872850277; Fri, 15
 May 2026 12:20:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:19 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-19-seanjc@google.com>
Subject: [PATCH v3 18/41] x86/paravirt: Pass sched_clock save/restore helpers
 during registration
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Pass in a PV clock's save/restore helpers when configuring sched_clock
instead of relying on each PV clock to manually set the save/restore hooks.
In addition to bringing sanity to the code, this will allow gracefully
"rejecting" a PV sched_clock, e.g. when running as a CoCo guest that has
access to a "secure" TSC.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h       | 9 ++++++---
 arch/x86/kernel/cpu/vmware.c       | 7 ++-----
 arch/x86/kernel/kvmclock.c         | 6 +++---
 arch/x86/kernel/tsc.c              | 5 ++++-
 arch/x86/xen/time.c                | 5 ++---
 drivers/clocksource/hyperv_timer.c | 6 ++----
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index fe41d40a9ae6..e97cd1ae03d1 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,11 +14,14 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void))
+static inline void paravirt_set_sched_clock(u64 (*func)(void),
+					    void (*save)(void),
+					    void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true);
+	__paravirt_set_sched_clock(func, true, save, restore);
 }
 #endif
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index b5cb66ca022b..968de002975f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,11 +347,8 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock) {
-		paravirt_set_sched_clock(vmware_sched_clock);
-		x86_platform.save_sched_clock_state = NULL;
-		x86_platform.restore_sched_clock_state = NULL;
-	}
+	if (vmw_sched_clock)
+		paravirt_set_sched_clock(vmware_sched_clock, NULL, NULL);
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 800c3d65f0af..962b6fcb5c60 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -137,7 +137,9 @@ static void kvm_restore_sched_clock_state(void)
 static inline void kvm_sched_clock_init(bool stable)
 {
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
@@ -344,8 +346,6 @@ void __init kvmclock_init(void)
 #ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
-	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-	x86_platform.restore_sched_clock_state = kvm_restore_sched_clock_state;
 	kvm_get_preset_lpj();
 
 	/*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index b14c4ada89a3..0114c63dfdd9 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,12 +280,15 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
 
 	static_call_update(pv_sched_clock, func);
+	x86_platform.save_sched_clock_state = save;
+	x86_platform.restore_sched_clock_state = restore;
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 21d366d01985..ee7095febfd1 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -567,13 +567,12 @@ static void __init xen_init_time_common(void)
 {
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
-	paravirt_set_sched_clock(xen_sched_clock);
+
 	/*
 	 * Xen has paravirtualized suspend/resume and so doesn't use the common
 	 * x86 sched_clock save/restore hooks.
 	 */
-	x86_platform.save_sched_clock_state = NULL;
-	x86_platform.restore_sched_clock_state = NULL;
+	paravirt_set_sched_clock(xen_sched_clock, NULL, NULL);
 
 	tsc_register_calibration_routines(xen_tsc_khz, NULL);
 	x86_platform.get_wallclock = xen_get_wallclock;
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ac1d9f9c381c..dee59ce61c29 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -553,10 +553,8 @@ static void hv_restore_sched_clock_state(void)
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */
-	paravirt_set_sched_clock(sched_clock);
-
-	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+	paravirt_set_sched_clock(sched_clock, hv_save_sched_clock_state,
+				 hv_restore_sched_clock_state);
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
-- 
2.54.0.563.g4f69b47b94-goog

