Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E041DD5C
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934387; cv=none; b=VdOquOMvPqzSe9VzHpy9IoG3/MhxJ/IVKGzvpytiL28k1uZQ1tYdZlgSbU3ECS7N0tgYmI6aH17VvHT5CmV6j5RHTdqUuYB+FT4uIlUYdvs//c3RUMwpECXuCL61qUOPaGQHDPnmcpbLJn7bMq5DDzvaEHB7cdB6uPARVPF1Pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934387; c=relaxed/simple;
	bh=n+A51rFoj4USUN6oHKtUVePZwkXkBrZ3Utmadq/pitI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S9ah4AOzXd24m8ea1E9w2JtbE8BaaJcFJB0WJSN/vLUL/asbpk8AClZRpHrSt0kLgyyFMGH8QpbjOPlXqvlgJBnZapGcqB1XKQuT7KjJEtxhzJ6oEKdJJab+FEpx2LWzda9qW/yNeTWam4Wfgubt4y6T+EYpBxWPgY8zlRdeGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pijR3Y8f; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pijR3Y8f"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c889d1eebafso1550337a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934383; x=1783539183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YK2zVmNLEJoBEawF7PlPSBbbkhRpzdy0apLvLWVt+lo=;
        b=pijR3Y8fF7xxpqMv2Qrgjtn/kFn920P6FTAct3/7XOOggxBKN4KsktDyRN18V2qy9L
         OO1b1gjR18+kKhVJUoxJyS7H3p855NLw6WMxx71XJwlnCE+s9gFRVCFvtFaKi2qrj9uO
         bcWLmY5fu6wL3Pu8dA7ePwkLPL8UXiFrrYEm6M/TX5PhzNBIGn2ZkXwzJu87NchnWjtN
         +yq7hfuHKCpDu5c4jiNDUBFN8nYNalA3P32QtLX3Ap7wYtKXngeChRlXY13JKaFvyNtx
         8osfjD7kNw3oDFh1hIR2goH/muJnkbAGBO6D4pOGoNVx7LiNYXu+YglOayspP/o0P9fN
         u/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934383; x=1783539183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YK2zVmNLEJoBEawF7PlPSBbbkhRpzdy0apLvLWVt+lo=;
        b=WVZqSfZD9WF9RBRQ+IKK5gLpB5S/QD+/GIdPjUTc8v1HRpDDQeUapA7/USDKYotY7/
         ayafWmHjW4ii1F0PyDjxjnY7t0WkF2q+jztuV6wMqyPa7W3cFcodOzC7W+OKI9wCH3GZ
         CTRWjnL3Tv81y9KcAupChMNA9SVuqw54DcJSSBPtfw1+EdNjvfxfPBezmtJm7H0UW3GP
         rUCcs7oazs+MpMehjLY39m6VY0V/sF+ct/X+35RydXBrVYgGVyTddRP17eHC1ibedadr
         phWGrQDiZPlIhIMtiJQlRVGs0+hnnXk/ils33RItgu2lAUD7RWOcFsxedbg3Ba+XdwqG
         HI4w==
X-Forwarded-Encrypted: i=1; AFNElJ/lm52nIBRoD3U9ppQbMybp75efsZqY0omy4ZpgwwjddVz+/5ECCPE7uIyezbJGQWpsUky/5MdbylMI3mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZR+LvhXn6yi2LiyHZShWPFGy8L7anbpkMXK3mZfsFt028Vua0
	U2mJh0QLTAZpqXALqfAggc6x5lEzdCplR1pKbCLOQIS4laAfY7gfXQeDAE/OK541+HjYNgB3Lwj
	fxQMhIQ==
X-Received: from pgwa6.prod.google.com ([2002:a65:6546:0:b0:c99:cbb4:1dcb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11b:b0:3b2:924c:567d
 with SMTP id adf61e73a8af0-3bff42bedd3mr2415279637.46.1782934383031; Wed, 01
 Jul 2026 12:33:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:50 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-30-seanjc@google.com>
Subject: [PATCH v5 29/51] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
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

Don't disable kvmclock on the BSP during syscore_suspend(), as the BSP's
clock is NOT restored during syscore_resume(), but is instead restored
earlier via the sched_clock restore callback.  If suspend is aborted, e.g.
due to a late wakeup, the BSP will run without its clock enabled, which
"works" only because KVM-the-hypervisor is kind enough to not clobber the
shared memory when the clock is disabled.  But over time, the BSP's view
of time will drift from APs.

Plumb in an "action" to KVM-as-a-guest and kvmclock code in preparation
for additional cleanups to kvmclock's suspend/resume logic.

Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
Cc: stable@vger.kernel.org
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  8 +++++++-
 arch/x86/kernel/kvm.c           | 15 ++++++++-------
 arch/x86/kernel/kvmclock.c      | 31 +++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a49fc286b4c..08686ff19caa 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -118,8 +118,14 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 }
 
 #ifdef CONFIG_KVM_GUEST
+enum kvm_guest_cpu_action {
+	KVM_GUEST_BSP_SUSPEND,
+	KVM_GUEST_AP_OFFLINE,
+	KVM_GUEST_SHUTDOWN,
+};
+
 void kvmclock_init(bool prefer_tsc);
-void kvmclock_disable(void);
+void kvmclock_cpu_action(enum kvm_guest_cpu_action action);
 bool kvm_para_available(void);
 unsigned int kvm_arch_para_features(void);
 unsigned int kvm_arch_para_hints(void);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6c7011ff7bd1..604b52f233aa 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -460,7 +460,7 @@ static void __init sev_map_percpu_data(void)
 	}
 }
 
-static void kvm_guest_cpu_offline(bool shutdown)
+static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
 {
 	kvm_disable_steal_time();
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -468,9 +468,10 @@ static void kvm_guest_cpu_offline(bool shutdown)
 	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
 		wrmsrq(MSR_KVM_MIGRATION_CONTROL, 0);
 	kvm_pv_disable_apf();
-	if (!shutdown)
+	if (action != KVM_GUEST_SHUTDOWN)
 		apf_task_wake_all();
-	kvmclock_disable();
+
+	kvmclock_cpu_action(action);
 }
 
 static int kvm_cpu_online(unsigned int cpu)
@@ -726,7 +727,7 @@ static int kvm_cpu_down_prepare(unsigned int cpu)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	kvm_guest_cpu_offline(false);
+	kvm_guest_cpu_offline(KVM_GUEST_AP_OFFLINE);
 	local_irq_restore(flags);
 	return 0;
 }
@@ -737,7 +738,7 @@ static int kvm_suspend(void *data)
 {
 	u64 val = 0;
 
-	kvm_guest_cpu_offline(false);
+	kvm_guest_cpu_offline(KVM_GUEST_BSP_SUSPEND);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL))
@@ -768,7 +769,7 @@ static struct syscore kvm_syscore = {
 
 static void kvm_pv_guest_cpu_reboot(void *unused)
 {
-	kvm_guest_cpu_offline(true);
+	kvm_guest_cpu_offline(KVM_GUEST_SHUTDOWN);
 }
 
 static int kvm_pv_reboot_notify(struct notifier_block *nb,
@@ -792,7 +793,7 @@ static struct notifier_block kvm_pv_reboot_nb = {
 #ifdef CONFIG_CRASH_DUMP
 static void kvm_crash_shutdown(struct pt_regs *regs)
 {
-	kvm_guest_cpu_offline(true);
+	kvm_guest_cpu_offline(KVM_GUEST_SHUTDOWN);
 	native_machine_crash_shutdown(regs);
 }
 #endif
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b0c871ba8232..a3ec298d56d7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -199,8 +199,22 @@ static void kvm_register_clock(char *txt)
 	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
 }
 
+static void kvmclock_disable(void)
+{
+	if (msr_kvm_system_time)
+		native_write_msr(msr_kvm_system_time, 0);
+}
+
 static void kvm_save_sched_clock_state(void)
 {
+	/*
+	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
+	 * If the system is hibernating, then kvmclock will likely reside at a
+	 * different physical address when the system awakens, and host writes
+	 * to the old address prior to reconfiguring kvmclock would clobber
+	 * random memory.
+	 */
+	kvmclock_disable();
 }
 
 static void kvm_restore_sched_clock_state(void)
@@ -208,6 +222,17 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
+void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
+{
+	/*
+	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
+	 * being used for sched_clock, then it needs to be kept alive until the
+	 * last minute, and restored as quickly as possible after resume.
+	 */
+	if (action != KVM_GUEST_BSP_SUSPEND)
+		kvmclock_disable();
+}
+
 #ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
@@ -215,12 +240,6 @@ static void kvm_setup_secondary_clock(void)
 }
 #endif
 
-void kvmclock_disable(void)
-{
-	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0);
-}
-
 static void __init kvmclock_init_mem(void)
 {
 	unsigned long ncpus;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

