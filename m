Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9754AB801
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059438; cv=none; b=o8EC5q0JUi5zMfrOMu3YKTfHT4ukrMQNgOJBLqxBDLNrula/LXgmbs79fceuN35PN2JSq+u9OmiXq+NfdgYHPsgUKX3qnX4hRF5Ag3FQWWstxwmPI1Lc0UJXkHOyP6P6XU5bVVJ77zfFX8+kyKYRr4IB01XSH5msmTNzsgD0uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059438; c=relaxed/simple;
	bh=EetB+RnX28VKy0jN0zLsMSRc1BZr5Co2JodEFYoMux8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kw7wJFjyNpnJq2WdkTO5sH37+hZ+WD4ICDilgDDAtJiRjruDC9sr8F9oVSVzcenLBFPMQYy0TdMycYJUlHoWeq/5nyiHwcDqr9QkD1hMyY6qRI5aLUwXbEevrADCKs5N6te0PFOHDFIfAioPkfYg77DzT3IdcTwZnMfpsv5L0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BqqbRfW6; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqqbRfW6"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848860def2cso3141811b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059436; x=1786664236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DfVsK4/eNAzlqgTkif/k+3bkJqkVsqeG8riFv7GGWx4=;
        b=BqqbRfW6nxSQG3cymW7yNa0PeYowBginEK9NyhpXgnO8/hBtGpearvWMlln3PHtTHw
         8ZybP9jwoy9y5dLzZq7+/7ZwVV6nshgJsuEasoADRnQlH6CRDbs0Mhhq5LeFDH1IRMsj
         uFSLMnTRtwZ/XVf+0TnojBpg369/7KehsGkbQOJHKFYSvROuvCx6mnihIiOjqTUHrmyV
         qLOf+ajHjnFBiPrQZRZGIlbKK89KF7y+XFkjeu8oURSzLtb+P4jDznCNNrdcqPQnll6k
         C4OGzyRP5hAPCPJxvXjqodarzWpYON5QEsOLWATF1zzwHHgrdXKEQNWHHVB+7KJZdjOL
         FLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059436; x=1786664236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfVsK4/eNAzlqgTkif/k+3bkJqkVsqeG8riFv7GGWx4=;
        b=DHyg9BURmtEqGa1hZed0o7YmoWpSgFg21BCkqjg79DJ06qKGAoHu5QsCiq7bIobVwB
         CZfhcqtVZk4mwsVtvkSc0g9Hd17WD8MTLiWmHMwWC2QX4klseK5UWFObdudch2bkA66G
         anNzgXjvWSXQ4YdIWZZJQYn25kJrItJOP9v2wuZCMHnb8ZhPthhwcykVlI0WEqUGWg+t
         fLjh0mr1RUoD0cJC4styaUG9NSV8wq8FenzZvS4YqUcF7e1DlUymph7s3FQh7o1yAagE
         fPej3iDssrnJ2lN5FTEXUlbD0OTnZ78ylyEjw+zzM2x2mcd/bfvcoXvEapOEa1cOkiHM
         dz1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoCYuXNkyC8GmgEcWNNpxAnvOhgYpk3VIFQPaJcIcHXue7ylvVI8Cl+tcLf7sa5OaypPIufOdOU9yWty3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0p/40SD/9fdTNXzAwOcD+q5s4ymtX2tHPuWLtf89Ox5vlGRPT
	Bt0K6y8L1ByMPuA3Ien4TE+onbCVxBKVJPL530BZuo0yVuZq2WoNDMfdJaarcKQmwBos62EnFry
	JpFbTAg==
X-Received: from pfbko19.prod.google.com ([2002:a05:6a00:4613:b0:847:926b:dc17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1886:b0:847:99a7:c751
 with SMTP id d2e1a72fcca58-84f2e05d02dmr18083285b3a.25.1786059435385; Thu, 06
 Aug 2026 16:37:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:58 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-42-seanjc@google.com>
Subject: [PATCH v6 41/51] x86/kvmclock: Refactor handling of
 PVCLOCK_TSC_STABLE_BIT during kvmclock_init()
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

Clean up the setting of PVCLOCK_TSC_STABLE_BIT during kvmclock init to
make it somewhat obvious that pvclock_read_flags() must be called *after*
pvclock_set_flags().

Note, in theory, a different PV clock could have set PVCLOCK_TSC_STABLE_BIT
in the supported flags, i.e. reading flags only if
KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is set could very, very theoretically
result in a change in behavior.  In practice, the kernel only supports a
single PV clock.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5220d205abc7..61d4d943fe74 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -327,7 +327,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(bool prefer_tsc)
 {
-	u8 flags;
+	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
 		return;
@@ -354,11 +354,18 @@ void __init kvmclock_init(bool prefer_tsc)
 	kvm_register_clock("primary cpu clock");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
-	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
+	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
-	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
+		/*
+		 * Check if the clock is stable *after* marking TSC_STABLE as a
+		 * valid flag.
+		 */
+		stable = pvclock_read_flags(&hv_clock_boot[0].pvti) &
+			 PVCLOCK_TSC_STABLE_BIT;
+	}
+
+	kvm_sched_clock_init(stable);
 
 	if (!x86_init.hyper.get_tsc_khz)
 		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
-- 
2.55.0.679.g6767b8d81c-goog

