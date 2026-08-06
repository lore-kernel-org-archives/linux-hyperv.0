Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065E4A4305
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059418; cv=none; b=h8U/Jc8V5yr4lztD35igDtpOgBQnaXurO7PmxHdG3gQRIPG/HUimOOcezz7yUNRphHru6UZVuQeOCBGYeqsHdZRM84jmRLa4aDrHPYJBVLDr5qL2ilHMPJaNqDsL2KL+2mJUwTeJ5J9Gt5sPABIKQnTHW1/9RONQswXFTbG7EuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059418; c=relaxed/simple;
	bh=LJwj0H7ygxbdQNHP5MBvYXv85flCoR1qvNC13d+g8ks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=APXvOO9dLgdYrX2GNyIboNYXzqif8hcfA+7C6/xyLkEeZSEwH1KHRl/8ql8BmxnoCKXhNld2fEboR06+1G6LQLxkVJ6YuT/ZvhElqDTlJ3q2ivdpy9JUuGjcR2QbcWZxasgft3IdLx0YqIRB1RZ7EfOBuD9qgzz9oucn+ydJIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2wEzc1g; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2wEzc1g"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so2212122a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059415; x=1786664215; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LVVzZOjwmw/JiJ4qXIbPAPAp0QWxfKUo2q2D7ecTrQM=;
        b=Z2wEzc1gpTtxPNQfGMbLP7AHA3KE5SQvPd0nI9wIKxp2FmlsLP3kHE35Aym4KSTL6t
         QtAPcxFeEmy4VECb5XMTjpELzxqBcqPEXo4y/ovf/Tq1jQPvyAs42UQyAmR9zv4zyXa6
         +HDkaCBPXxI6+ecVZM6JxsrAhLDyr8xcuPfulnf3WAtVbmGKxXzhuwa7g+4HWqkblU/N
         f1S5wKffIBs64E5lTjR2exF/g8MSkTdNWrNFpP3rYBdgieze5qXIo6u2NIljI5bkXVQd
         0ppnnHVjyV+oJxpJbUagcT9AxseOr835ZqH7oeA8sK6NYbEVI/U1Unb/gKLxd7U+hwAm
         S7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059415; x=1786664215;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LVVzZOjwmw/JiJ4qXIbPAPAp0QWxfKUo2q2D7ecTrQM=;
        b=ht4qQH9tEPQe45XkIpNXa+v9jEjbwVT7Cvh2lydmfVRY1DqOjdyq1jntSmq8Lb3rbe
         2TZjT8zCplGRzJ0uUCsX3iP/UhJyCfUSk6gccfSe8OTpFr9q76pNstjNoIogKCqcYPR3
         BgqVzM3BXEprJ64C+8ULgYJ7j+BQtVPAVj45rl3bzl5WttNj2c//zPBdjnvalhjLoKv8
         y1GBa353K/wEsEwk967joZYppKsLxITQ+Bp92hhCAru/NAMFDRksLBi+gDK4eiMuj7tg
         fPvMYbJQyzTP67Bq5cyjeSBDKI4hkNcjvBFr+t2AFR7t9H3VHBXhv63yrmzTqf67gc4T
         badw==
X-Forwarded-Encrypted: i=1; AHgh+RqO/BR27niQs/oCy1v7tk2yYlhIkz2NtXpNk+vqJvbwz/V3GPC8QBY1AJ3CxiMNYNFyUN8M/LBov8oeYpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnkZ990ICCgYi+3sLgQAdOq3WE7nqmc7ghS3pLzY1vgLSv6Ar
	ZsLmSlzCRjN7ftEhn0oVPZnNnS3so+bFpyMhyIG1yeACDt0Yrb3LN/2OrgCMiQdjpD/aiWrigY2
	Y2Ax2iQ==
X-Received: from pfcy22.prod.google.com ([2002:a05:6a00:93d6:b0:84b:be30:8d22])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8019:b0:848:4a48:9f9f
 with SMTP id d2e1a72fcca58-84f4fee000fmr6402250b3a.34.1786059415266; Thu, 06
 Aug 2026 16:36:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:42 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-26-seanjc@google.com>
Subject: [PATCH v6 25/51] clocksource: hyper-v: Register sched_clock
 save/restore iff it's necessary
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

Register the Hyper-V reference counter (refcounter) callbacks for saving
and restoring its PV sched_clock, if and only if the refcounter is
actually being used for sched_clock.  Currently, Hyper-V overrides the
save/restore hooks if the reference TSC available, whereas the Hyper-V
refcounter code only overrides sched_clock if the reference TSC is
available *and* it's not invariant.  The flaw is effectively papered over
by invoking the "old" save/restore callbacks as part of save/restore, but
that's unnecessary and fragile.

To avoid introducing more complexity, and to allow for additional cleanups
of the PV sched_clock code, move the save/restore hooks and logic into
hyperv_timer.c and simply wire up the hooks when overriding sched_clock
itself.

Note, while the Hyper-V refcounter code is intended to be architecture
neutral, CONFIG_PARAVIRT is firmly x86-only, i.e. adding a small amount of
x86 specific code (which will be reduced in future cleanups) doesn't
meaningfully pollute generic code.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/mshyperv.c     | 58 ------------------------------
 drivers/clocksource/hyperv_timer.c | 50 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3bca987e05c3..d704496d0409 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -275,63 +275,6 @@ static void hv_guest_crash_shutdown(struct pt_regs *regs)
 }
 #endif /* CONFIG_CRASH_DUMP */
 
-static u64 hv_ref_counter_at_suspend;
-static void (*old_save_sched_clock_state)(void);
-static void (*old_restore_sched_clock_state)(void);
-
-/*
- * Hyper-V clock counter resets during hibernation. Save and restore clock
- * offset during suspend/resume, while also considering the time passed
- * before suspend. This is to make sure that sched_clock using hv tsc page
- * based clocksource, proceeds from where it left off during suspend and
- * it shows correct time for the timestamps of kernel messages after resume.
- */
-static void save_hv_clock_tsc_state(void)
-{
-	hv_ref_counter_at_suspend = hv_read_reference_counter();
-}
-
-static void restore_hv_clock_tsc_state(void)
-{
-	/*
-	 * Adjust the offsets used by hv tsc clocksource to
-	 * account for the time spent before hibernation.
-	 * adjusted value = reference counter (time) at suspend
-	 *                - reference counter (time) now.
-	 */
-	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
-}
-
-/*
- * Functions to override save_sched_clock_state and restore_sched_clock_state
- * functions of x86_platform. The Hyper-V clock counter is reset during
- * suspend-resume and the offset used to measure time needs to be
- * corrected, post resume.
- */
-static void hv_save_sched_clock_state(void)
-{
-	old_save_sched_clock_state();
-	save_hv_clock_tsc_state();
-}
-
-static void hv_restore_sched_clock_state(void)
-{
-	restore_hv_clock_tsc_state();
-	old_restore_sched_clock_state();
-}
-
-static void __init x86_setup_ops_for_tsc_pg_clock(void)
-{
-	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
-		return;
-
-	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
-	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-
-	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
-	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
-}
-
 #ifdef CONFIG_X86_64
 DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
 EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
@@ -736,7 +679,6 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
-	x86_setup_ops_for_tsc_pg_clock();
 	hv_vtl_init_platform();
 #endif
 	/*
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index df567795d175..4293173c3a27 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -554,10 +554,60 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 #elif defined CONFIG_PARAVIRT
 #include <asm/timer.h>
 
+static u64 hv_ref_counter_at_suspend;
+static void (*old_save_sched_clock_state)(void);
+static void (*old_restore_sched_clock_state)(void);
+
+/*
+ * Hyper-V clock counter resets during hibernation. Save and restore clock
+ * offset during suspend/resume, while also considering the time passed
+ * before suspend. This is to make sure that sched_clock using hv tsc page
+ * based clocksource, proceeds from where it left off during suspend and
+ * it shows correct time for the timestamps of kernel messages after resume.
+ */
+static void save_hv_clock_tsc_state(void)
+{
+	hv_ref_counter_at_suspend = hv_read_reference_counter();
+}
+
+static void restore_hv_clock_tsc_state(void)
+{
+	/*
+	 * Adjust the offsets used by hv tsc clocksource to
+	 * account for the time spent before hibernation.
+	 * adjusted value = reference counter (time) at suspend
+	 *                - reference counter (time) now.
+	 */
+	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
+}
+/*
+ * Functions to override save_sched_clock_state and restore_sched_clock_state
+ * functions of x86_platform. The Hyper-V clock counter is reset during
+ * suspend-resume and the offset used to measure time needs to be
+ * corrected, post resume.
+ */
+static void hv_save_sched_clock_state(void)
+{
+	old_save_sched_clock_state();
+	save_hv_clock_tsc_state();
+}
+
+static void hv_restore_sched_clock_state(void)
+{
+	restore_hv_clock_tsc_state();
+	old_restore_sched_clock_state();
+}
+
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */
 	paravirt_set_sched_clock(sched_clock);
+
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
-- 
2.55.0.679.g6767b8d81c-goog

