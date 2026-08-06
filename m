Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610C4A1C86
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059414; cv=none; b=RvUBm6lOPJyE3gWRtkt+H2/y70WWbFpsN2xOZXSpX+73iGMeUyyiIaGPDHTKePHlqfOXWxrq9iiojCvPw0oYCHxgY1RR7CPGJI4JU8vBWHeIgaRDsBDQTMl9Nf27hCD0KKhSW7eFIqrMJHbq/UsyZMbGnhWn4felcqtCRyiUjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059414; c=relaxed/simple;
	bh=d2IlR+xJ3s7i3winERsl12oMi29cZLvPJvIMStFX9r4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gdDaHwgjEwxHKzTulSvDvCDhyGQ1vHBaM6lntzpBhhopvzhsDM2RaujePSwe/A5lmmj3uVh96RSRH2RuofrNjgYcrY2mjQQOj6DjMQMvW7kTX/QsrwfzXSbXHCg0RJeWIKGk8ECCm03A072xelG9ZbTNTsLHCWxxDBAbhiZMIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjrrmJnd; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjrrmJnd"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfe48ca1efso38504475ad.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059412; x=1786664212; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9lHEbI53WDwynue0wsp+pOzdIE1KL/OlJm0qjHY+exI=;
        b=UjrrmJnd9Uijef/hKA9/UOVb6SMy4SyVgS7txhmL5jw294xFKfzyyBkcrkyKDrlFNT
         2gmlvAO1++qzARZDZJRTzICZ6fJygfnzGoqWcfgfSwj13SJRDKpF/II7gsnOEwhmcuVP
         UGxhQE39Xa04ParOl7Vykt6GshHuWjpFzfAFOPdqE+5KQUYMnBTrP4qm4Fa6f1co8+Yi
         8swm2Zq5HZyy2ZUi/tLDyNbh07UnAwzXmti2OHcoYW7b1MTq+PzlUbjdBKJvv1S+lg2f
         jqiIr40gfYw2PxeJ4HG11eT1FpwalhltSQcQX6NQ+APByvsWQIXTVOJWcZs8kIHFs8j2
         UGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059412; x=1786664212;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9lHEbI53WDwynue0wsp+pOzdIE1KL/OlJm0qjHY+exI=;
        b=jZwp6qBV8vlROuNFUhUlo/OcV1RAQvCs3ER2Hu0RNghbK6mmRuzQH+LGRibhPENl0y
         io0m5YpBG98ApzhnqCx+Us2IjaqtB9xq/hVTtWhvguNK4DxhhdLHKa7wcUyg4mX0s/+/
         QeolHzI+jIxmq6IEBhrEz1ft0j87Q4dJIIeRpgl86nO3eX/VJjp9a2263SXBDu16VyZU
         +bTUVUySh11cc76p4dIHwxphzc38V/QftZ3pPINWykaRZVowYns68YIOwLGCT4PWomql
         9aIUDP5GMJi9vx4VSHc0Y5lhgXOFU/IKUngERPgFCwz0wrhPQ1mrJpQuYYSIhXHLYQZD
         7xWg==
X-Forwarded-Encrypted: i=1; AHgh+RpHvrQiPtdc4wRd8hBuAyhCce5TAvLvxrX5uGvnY2y085oSOskV9SCXwdM+QI4wMErRVfyDy1eHo31hRZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UQyPtm2XB7YB+D/flaL+4nG/M1d7QtnZaJZs9K+kRctnkLiB
	qbglV2/sGX1jkRKUFUSnFaimaIpGil1JlOyrT1aoEd4iohhuWjS6X4X6w03+T6s6JImlT+gSSuQ
	/TkMRpg==
X-Received: from plpn24.prod.google.com ([2002:a17:902:9698:b0:2cc:ae2b:c324])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0d:b0:2d0:4021:bb6b
 with SMTP id d9443c01a7336-2d0ca15c87amr222771235ad.0.1786059411603; Thu, 06
 Aug 2026 16:36:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:39 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-23-seanjc@google.com>
Subject: [PATCH v6 22/51] x86/kvm: Mark TSC as reliable when it's constant and nonstop
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

Mark the TSC as reliable if the hypervisor (KVM) has enumerated the TSC
as constant and nonstop.  Like most (all?) virtualization setups, any
secondary clocksource that's used as a watchdog is guaranteed to be less
reliable than a constant, nonstop TSC, as all clocksources the kernel uses
as a watchdog are all but guaranteed to be emulated when running as a KVM
guest.  I.e. any observed discrepancies between the TSC and watchdog will
be due to jitter in the watchdog.

This is especially true for KVM, as the watchdog clocksource is usually
emulated in host userspace, i.e. reading the clock incurs a roundtrip
cost of thousands of cycles.

Marking the TSC reliable addresses a flaw where the TSC will occasionally
be marked unstable if the host is under moderate/heavy load.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  2 +-
 arch/x86/kernel/kvm.c           | 12 +++++++++++-
 arch/x86/kernel/kvmclock.c      | 14 +++++---------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a47c16e2df8..4a49fc286b4c 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -118,7 +118,7 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 }
 
 #ifdef CONFIG_KVM_GUEST
-void kvmclock_init(void);
+void kvmclock_init(bool prefer_tsc);
 void kvmclock_disable(void);
 bool kvm_para_available(void);
 unsigned int kvm_arch_para_features(void);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 8ed02f4f5775..255a24a99f28 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -980,6 +980,7 @@ static void __init kvm_init_platform(void)
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
 	u32 timing_info_leaf;
+	bool tsc_is_reliable;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
@@ -1042,7 +1043,16 @@ static void __init kvm_init_platform(void)
 		}
 	}
 
-	kvmclock_init();
+	/*
+	 * If the TSC counts at a constant frequency across P/T states and in
+	 * deep C-states, treat the TSC reliable, as guaranteed by KVM.
+	 */
+	tsc_is_reliable = boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC);
+	if (tsc_is_reliable)
+		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
+	kvmclock_init(tsc_is_reliable);
 	x86_platform.apic_post_init = kvm_apic_init;
 
 	/*
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index f55d0305d1f3..2e7ab54cb9dc 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -307,7 +307,7 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
-void __init kvmclock_init(void)
+void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
 
@@ -356,15 +356,11 @@ void __init kvmclock_init(void)
 	kvm_get_preset_lpj();
 
 	/*
-	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
-	 * with P/T states and does not stop in deep C-states.
-	 *
-	 * Invariant TSC exposed by host means kvmclock is not necessary:
-	 * can use TSC as clocksource.
-	 *
+	 * If TSC is preferred over kvmlock, drop kvmclock's rating so that TSC
+	 * is chosen as the clocksource (but still register kvmclock in case
+	 * the kernel doesn't want to use TSC for whatever reason).
 	 */
-	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+	if (prefer_tsc)
 		kvm_clock.rating = 299;
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-- 
2.55.0.679.g6767b8d81c-goog

