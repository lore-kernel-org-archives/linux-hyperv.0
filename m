Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5049DD51
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059421; cv=none; b=pUSSaeKodeH7fEzsOauG8VoDbkGxs2WBj0Bdv/lS1jQDfSS3Ofm0drK1Dr1mYl5/jsarTe6qNGHtMzo+GCkQFIgNZZ9puRNnk2Ui6aWHJU27+mqKyRw+iGqaTAYIKL3Rb2KVsUhk4PlUxL7FPfW0mDqMUagLBqFXIVL+UDJV3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059421; c=relaxed/simple;
	bh=pvk61KgZsdgezrqmuUH0lmIu4eH6UZ//mUcKEN2ubd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ibzeFS3rY4UVxeh95ox0gpahXcRGtMz5Ml5o7zw5uC8eZGAf3s7eaFseynrw51s7aUJUSe8DNJZQN7zQWvTzzS8idkQ1Tm95+nmBf6rbZ8//Zo2YtlKVZZsrBJZ6B5C/cJRi0R+8ReuQxXak9dqs/eVRHxn9qq8Q8Fw+4XFNuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgeuRY+G; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgeuRY+G"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab041eced3so4024496a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059418; x=1786664218; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=heSuqSIgeH92pLRWbhNi7GYX8HqrNShkMIs22IEn4aI=;
        b=JgeuRY+G87SI6mEJFTSetd951fXXpqnhpp2TqQRSxfa88MqKJD0jaFS1egNVCLlWy4
         iXwzU3V+X4Ps0A/pyPrWbE0+PQPvv92+qhwK5pHcAV69EdRBCfXOtAeGpYAE3LziETYJ
         vtKuYNGX4v9UIJ1xwDTkkCFNVQjqN6rZ1P3a2wQd0Clz85cKjsqEING7YqmH1yL1p0uT
         Gm6Yn/yldjsvSIdY4nK5z08iiI6KstDKtml7Jtiz/xv4lBmEak5NIXlteg3tGXsQVXd7
         64rntZ5m/l1qBNuqXkfrFUhe+Ke2qXunUXfy/DNV1Ugqcx19RfRJjleApH1jHG6Y/R7B
         skmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059418; x=1786664218;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=heSuqSIgeH92pLRWbhNi7GYX8HqrNShkMIs22IEn4aI=;
        b=owyJTrknUei22c9Nkfxbu39IRPlvMQG07tezVg4pCGCCul8VEh4Pyk3KrgRIuCragJ
         LkmRO+bTsniYNj55SaAD5dZhqRkLQvH1izSDBKBD8FivicXFtJ9d11q4nQpA2rlkXUJ8
         JFF6vJIcy194rIROlG1jY8N6DinYFg0/w84rErGWQ/hc9RLTsr5Sm9rogp1cbX7xuVQf
         gHAZw7DjAALxU0VrU39aYuWYTWvu6JUxJSK1ly6Gvt0EtDzFfJtrkud1/lHjsi5D5xzR
         PgfsSAdm32lOVoP6EwcQHH8N//Isq1XEQTQ+BRh8YfrDMGQij1MjrLsKz2RFL/bvclfL
         etoA==
X-Forwarded-Encrypted: i=1; AHgh+RpUshSjaHzXCDMBPwj+E2xpj8C+oLsmLjFoIyZ6o5KLt6XDCSDp5wWHAe7kzf6qJ2N9A7Di9DomZxzfzQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYw+WauLLZmoGzWJU5FP45OCRFy2zp0mYmo0TTQ8R1ipJ0t2q
	dL0rFcXbQiRShYe/guIIUFs0Q/5sGTOo3Tgov8gCXLPSLhwsovE5fSNIe90bIpFoZX+oxcIdNek
	V0LIz9A==
X-Received: from pgmc19.prod.google.com ([2002:a63:1c53:0:b0:c98:2639:852e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7344:b0:3bf:6acf:2940
 with SMTP id adf61e73a8af0-3cb85df0a1bmr20575846637.11.1786059417589; Thu, 06
 Aug 2026 16:36:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:44 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-28-seanjc@google.com>
Subject: [PATCH v6 27/51] clocksource: hyper-v: Don't save/restore TSC offset
 when using HV sched_clock
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

Now that Hyper-V overrides the sched_clock save/restore hooks if and only
sched_clock itself is set to the Hyper-V reference counter, drop the
invocation of the "old" save/restore callbacks.  When the registration of
the PV sched_clock was done separately from overriding the save/restore
hooks, it was possible for Hyper-V to clobber the TSC save/restore
callbacks without actually switching to the Hyper-V refcounter.

Enabling a PV sched_clock is a one-way street, i.e. the kernel will never
revert to using TSC for sched_clock, and so there is no need to invoke the
TSC save/restore hooks (and if there was, it belongs in common PV code).

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/clocksource/hyperv_timer.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index daa8cbfe61ee..220668207d19 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -544,9 +544,6 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 #include <asm/timer.h>
 
 static u64 hv_ref_counter_at_suspend;
-static void (*old_save_sched_clock_state)(void);
-static void (*old_restore_sched_clock_state)(void);
-
 /*
  * Hyper-V clock counter resets during hibernation. Save and restore clock
  * offset during suspend/resume, while also considering the time passed
@@ -556,8 +553,6 @@ static void (*old_restore_sched_clock_state)(void);
  */
 static void hv_save_sched_clock_state(void)
 {
-	old_save_sched_clock_state();
-
 	hv_ref_counter_at_suspend = hv_read_reference_counter();
 }
 
@@ -570,8 +565,6 @@ static void hv_restore_sched_clock_state(void)
 	 *                - reference counter (time) now.
 	 */
 	hv_sched_clock_offset -= (hv_ref_counter_at_suspend - hv_read_reference_counter());
-
-	old_restore_sched_clock_state();
 }
 
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
@@ -579,10 +572,7 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 	/* We're on x86/x64 *and* using PV ops */
 	paravirt_set_sched_clock(sched_clock);
 
-	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
 	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-
-	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
 	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
-- 
2.55.0.679.g6767b8d81c-goog

