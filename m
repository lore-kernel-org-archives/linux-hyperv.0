Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9A40D1CD
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872870; cv=none; b=n7yHTDYPPV5cYIpmTAmLSAJI+eAbQMOTyLJZjX2cDFiyuWjUC3lR1A8SV3ixdQ2W3T6WxcpRrra5nCzgmA822fABZf4TGasKPfhPP0vHxJdKma3pL7eEYUqXswVYBjLtOWV0wIyHGN/7trwxGV3w+EWmJTkQ1YOfXiJWWwHvFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872870; c=relaxed/simple;
	bh=wHV+tqsgKZeHCNlwzMKQ+ffX2tGbMars+kUaRwUmZDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sc+q3Fp4UXVUbk+SBWZ2RjhetHrnuDWmCPT6GqA4sq6P2BzcT4qcVv+sCrFt4dNA2NHCklKYxfcxlwhbUWfFo60FVU72gH/1w5tkHsSx6lSaYxiNHS29qXdM01nyLKACpIAH5GeI6b5OUrC+dd+KJHDjJom9DiDnbcHyQoX6vuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIcnnCKs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIcnnCKs"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa860e71eso96383b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872868; x=1779477668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pNsHSCzVBvNpSbb8atgOEwFmCd7ur8peJFPmwL2u2ME=;
        b=PIcnnCKsUhDggNx5raHnwzwB1GSeKCUoxOzu+H38L7b4K/vfohKztrmRSi36SL7GxH
         nA9xXTw9P84T+AQa23IWjiOkCe0kaOGR4HdA4dmFr/qNDrZI3QwCsmYHcBGj5ClsDcK3
         5dJ9S+sN2oFDQjPUJYNvwqyzArqebuQ9nDvR/zEkB9gruttwvaD3cHNCX2meIgcKPVV4
         DCQ3IFqmcGJypLr6paDYTbs+R9kzbo2kH3cjHNLl9lGgqMUYG+f3FAehGEe+F3wbxItU
         X7YAtlkHbT+OGaJCq1NKqqqRwXcNVb7g+LAW5XnueCyBKnESK/QGkBCAmitROs0wZCTC
         tjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872868; x=1779477668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNsHSCzVBvNpSbb8atgOEwFmCd7ur8peJFPmwL2u2ME=;
        b=nAesE9n9QKyVGNJk2526ApR9DAmlgxNzvxPL8ycagT577etmML/E2UyE1XfdRCqj9T
         rpM61nIreG9PniEuYWJvaOduIihjbrulY9Vf3SjgNc/ZxZcPtT62zwGHlbVZqfDcfrja
         +gbkT0nT06xDn4mjpGklUCmPnJaN/eyIyhwHxi7PZwcJtXvqMZBXr4Vtth6/A/MwAkSh
         9t1RPGUZqBz5AAhdcJrHJp9V8+WSUz6YMug7zvGFsv3WXzMX38YejClbKKfN4thUlNwe
         PuHZ8IftmobieVLnalC04INi6VgFw08PXLDMDl0gGjhhIvpSJodw/rIfVg5dTPZrgQoW
         nZ+w==
X-Forwarded-Encrypted: i=1; AFNElJ81+d4fFdK7+TuPVjsQ9UivB8yNWSKlz3KmbDMnZGIEBl78edV2y5wj9cn8wpPVYZaT/DUNVdVuqbfAEDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtA6tSkqf8Xokl9GvQABLbWHe9ilqUoVfYPIgxAoNYxw5knpS
	iA6mHKmo6u1V/voRJh7M2a+0GJQn47MfI+mFI/kXg9zVZi3V4MTtp24xvF7Ikdr9YmwgQdpHTTA
	TC2K5rw==
X-Received: from pfra8.prod.google.com ([2002:aa7:8e88:0:b0:83e:b125:ff3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3005:b0:82f:29fe:7239
 with SMTP id d2e1a72fcca58-83f33d3659cmr5558676b3a.50.1778872867738; Fri, 15
 May 2026 12:21:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:30 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-30-seanjc@google.com>
Subject: [PATCH v3 29/41] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
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

Add a return code to __paravirt_set_sched_clock() so that the kernel can
reject attempts to use a PV sched_clock without breaking the caller.  E.g.
when running as a CoCo VM with a secure TSC, using a PV clock is generally
undesirable.

Note, kvmclock is the only PV clock that does anything "extra" beyond
simply registering itself as sched_clock, i.e. is the only caller that
needs to check the new return value.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 +++---
 arch/x86/kernel/kvmclock.c   | 8 +++++---
 arch/x86/kernel/tsc.c        | 5 +++--
 3 files changed, 11 insertions(+), 8 deletions(-)

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
index d3bb281c0805..9b3d1ed1a96d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -338,10 +338,12 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 
 static __init void kvm_sched_clock_init(bool stable)
 {
+	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				       kvm_save_sched_clock_state,
+				       kvm_restore_sched_clock_state))
+		return;
+
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
 	kvmclock_is_sched_clock = true;
 
 	/*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4a48b8ba5bea..3c15fc10e501 100644
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
2.54.0.563.g4f69b47b94-goog

