Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022942C4A4
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934406; cv=none; b=ukEDdT3fPEbdj3iWzBQnZ7q8DxbQoQZwFfxr0GdjRhPQCjlcVoOdXC2aKm14H+W+crbAXVdh9Hko0e76z+/P54MgAi+RqgfM4UMa6MLMK+wjDEjQjJIhQgR36nPWguBqL+nvDtxux72+wskEXgBU8/V1h6CwSWZkFzQXeR9QOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934406; c=relaxed/simple;
	bh=IG2Hmi12vLvJIelcQEMDYixsIVkPyLQSG2OhagBXg7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bAf768d2DRVvwCsAiMDAQM1l2uXNqR1cAu9y+zaazrbSkttG037M91NzmHmNkvVmHQoL307Okeignpu6yHmcPw4KZQd+pWTQCkT/W8IrkL79fr3tmY2cEZbVLz60UlfamUze4VGOYwY47za5zgocT+afEgyeiUiYLmMHA8zicww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXZeEAMO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXZeEAMO"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso936166a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934403; x=1783539203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4/M1D57lssm/A6RYRKDqaCs4EQpgkZGCf/uDo3WK1sI=;
        b=ZXZeEAMOXd+gHrL4Ktx3/Fo5Th6QRTtB4gXMfNdwTL+exRiPrqetCTfpZ98PhD9JV4
         dM6KpfDSVh66P9265MUA1hTcgZ/qAmeUfmMXP3DuYgVYinTP0GKZop71+kmWbrdZemon
         hmt1oAEFd0goKUZF0XRjed/s2OFIxXj+duao0MGNFycUZpKnGRLLh0iEyMZkvAx15sMX
         ABvn0zFo5bN/L62mEHaRgff3vbIq0rZXTT8vqZu0SpEz0RJmWb9hmiAFMaWbBcghOHZA
         ebYcEAAVmEQ5cyBcm4eExiVeNAmyGQbD3q1ELWx3kSypvROtI5P5I6bggGB1joO5NW9I
         fIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934403; x=1783539203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/M1D57lssm/A6RYRKDqaCs4EQpgkZGCf/uDo3WK1sI=;
        b=clUi08WZmp+px+xl8PeF6ph2IbADSe0b8P3HxPYZp4L7mrQCRlvsNjSix+1Jzj8rYZ
         vC3y9wywHvg+vTlxePmVsf4pNsw7rI6YWO5ZltIOwpJAAwCyCB4irAz6EH7eHxq7DfDj
         +l2A0WElef1YCpRy/GSxM4fCbtQFGtXe75G/cvDukShOlIfpIwl//s1lUk0Zf8uBiu5C
         tDdDcyu8lF5OP3QhbKs06h8uG5zD1TTS5RatC81FPmswyKV5hmAr6ogeO7Rr14Kuoyoc
         HBZtI9z4A9iagBBtDfqq73FE522VYAsF78fRBfIh8ffGXdEqrk9/TO+/XHpVsYyXiUil
         ZMrw==
X-Forwarded-Encrypted: i=1; AFNElJ9wmzfGeMJh8O6s32WL0KBqoJ6JEed4JQIGIfmeLx2YsyjJu2Sp2aby0uajTO4bIKUejfANHIAQVUllO3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9kL3DO/ORoWJixD1VBLluhJDC5mP6QEFgva8oNVdqsFiBZIf
	Q/YTDMinSFYYFOtAIFg43cxwA/mqU3r+fCmh+VLvmy9HYRDdfWCwylamWOthk6oYARiaM60wvi/
	oAsnfUA==
X-Received: from pgal188.prod.google.com ([2002:a63:3ec5:0:b0:c98:a4cf:469b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:62cc:b0:3aa:c964:3c27
 with SMTP id adf61e73a8af0-3bfed49ea64mr3435408637.46.1782934402561; Wed, 01
 Jul 2026 12:33:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:07 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-47-seanjc@google.com>
Subject: [PATCH v5 46/51] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
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

Add a return code to __paravirt_set_sched_clock() so that the kernel can
reject attempts to use a PV sched_clock without breaking the caller.  E.g.
when running as a CoCo VM with a secure TSC, using a PV clock is generally
undesirable.

Note, kvmclock is the only PV clock that does anything "extra" beyond
simply registering itself as sched_clock, i.e. is the only caller that
needs to check the new return value.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 +++---
 arch/x86/kernel/kvmclock.c   | 9 ++++++---
 arch/x86/kernel/tsc.c        | 5 +++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 96ae7feac47c..ca5c95d48c03 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,14 +14,14 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void));
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void));
 
 static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 						     void (*save)(void),
 						     void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true, save, restore);
+	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
 #endif
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 2cc3dd2ba355..22e8855fcd4d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -332,10 +332,13 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 
 static __init void kvm_sched_clock_init(bool stable)
 {
+	/* Ensure the offset is configured before making kvmclock visible! */
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
+
+	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				       kvm_save_sched_clock_state,
+				       kvm_restore_sched_clock_state))
+		return;
 
 	/*
 	 * The BSP's clock is managed via dedicated sched_clock save/restore
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0f92b29adecc..012321fed5e5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,8 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void))
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
@@ -289,6 +289,7 @@ void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 	static_call_update(pv_sched_clock, func);
 	x86_platform.save_sched_clock_state = save;
 	x86_platform.restore_sched_clock_state = restore;
+	return 0;
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-- 
2.55.0.rc0.799.gd6f94ed593-goog

