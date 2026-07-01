Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13942D6EB
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934409; cv=none; b=hzIwzzx9/0bZswKvV1kPtCJvi54u5hYrFKf/h0mmdSaPu1+xGLCBNDNH5m8hAQI62wf+E1mwzk4QQlL56SY6hV9nM1+olw5aEnmiO1TymcRzHokrf8iPGYeCy3z0BIKam4d7RHq+RUbOlOEDvMDUFltIyyVdIQfGVtIoh3S8ymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934409; c=relaxed/simple;
	bh=1+k5bW4sotKJMM0NqHqr71EffqplV+UQXiw8XbSTW9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJJf8iGL3VUKnQ/OlG1oxmDDNWrA+uJHVRq/NzxhnWCV95KX+P2n0VsiGSzXS3CaS5TjKypK5TBVyo9pBzS6Ez765rgsUAODrOFU6t+e0hNyQ6Xp76xAerpCtluc9+DZeaWpXne3QRM/94cJ8C87/HeIwHa0LftAdBy1D2XrbV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3PeuXt/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3PeuXt/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e24235ce1so1374964a91.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934405; x=1783539205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sbysuOQKV7W7YbruNHYRSyCV0jaRsBQX5EoVXm1Gq/A=;
        b=c3PeuXt/tgiO285TH6bRFAbMFKTiwEoZzlXsqPEiFWyQ2FpgMWYceyK9lwkLeHjKah
         +el+ErfWA4ciWbGnFYAI9UwkLpVFKKV33LWWNJPOujoc6UMgbeyqzYvq+zyf8wxMlMhJ
         qhd1KRHCj64PN/9fero+0OiR1fBcpwhGljrDYLM6+hG3BO/vMcgfUQevJJA+eAoe39Px
         +fR1usn1w2CqZ+Mux2iVwmt2dE32CYy3Y7z107q1NJmCurRuyHyWQkGXhvSlptgbWQ19
         jJfWBqvU3cZQCrWbQtZrb+RkLetwPZ7LFpHYwR+3PVSePKvGipi2vviFW/SJNU84lK6X
         gY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934405; x=1783539205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbysuOQKV7W7YbruNHYRSyCV0jaRsBQX5EoVXm1Gq/A=;
        b=iExPnclTSMxdCpssyiwSOl6EyqkUytqTbA9GxhuWM6KsfwXQNK0zml+4E9qPsKML5c
         qvuR3aAHiuvpSEC24pESP+ssOkWfn6Ar9cZOWGtRIOTX3+f+e77pRWVak79LOxwbnKdC
         ccOvzUpi2RB+5o3jUaTIxe3utbHNeX9yp46wT5V2CKrftBSwZNwyVpsbHKVURekmZgeW
         uNmoXGHGn9ZRnbR2hjZZdZIpAyGiXHFEF3MhsAxNil8Ap4bXIR170Wcy9h8rEyAaCaHb
         p6iXj83X0LOlgPb5aBYfXK+nFyYRsbnXQWrouweSQ8LcZ926OA1JZzEE+A7gUKdXc07W
         icTg==
X-Forwarded-Encrypted: i=1; AHgh+RrXW07lEfg0mO1IDHae/dxrGA1NsVbe4hfonNthVsM1pSFuJXomsf2h7XMz2MPf8Lhg93zb2T/pPPDybDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYjz46y2JG8KEaq2yFTg++lSV+DNlm+9ft6CUeNMhKLL3ZD5p
	GVIkyMiFAvclbOJ8dxm9j4NYCEhvC9zChd5SWWMcLorb/NqBbyKTMJ85nrQ6RBFCK2dqzhieX2V
	SkpWbmQ==
X-Received: from pjbbf15.prod.google.com ([2002:a17:90b:b0f:b0:37d:e898:7cd8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2886:b0:36a:f612:e6a3
 with SMTP id 98e67ed59e1d1-380aa18d2b1mr3062418a91.17.1782934404832; Wed, 01
 Jul 2026 12:33:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:09 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-49-seanjc@google.com>
Subject: [PATCH v5 48/51] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
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

Prefer the TSC over kvmclock for sched_clock if the TSC is constant and
nonstop.  I.e. use the same criteria as tweaking the clocksource rating so
that TSC is preferred over kvmclock.  Per the below comment from
native_sched_clock(), sched_clock is more tolerant of slop than
clocksource; using TSC for clocksource but not sched_clock makes little to
no sense, especially now that KVM CoCo guests with a trusted TSC use TSC,
not kvmclock.

        /*
         * Fall back to jiffies if there's no TSC available:
         * ( But note that we still use it if the TSC is marked
         *   unstable. We do this because unlike Time Of Day,
         *   the scheduler clock tolerates small errors and it's
         *   very important for it to be as fast as the platform
         *   can achieve it. )
         */

The only advantage of using kvmclock is that doing so allows for early
and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
broken for over two years with nary a complaint, i.e. it can't be
_that_ valuable.  And as above, certain types of KVM guests are losing
the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
needs to be decoupled from sched_clock() no matter what.

Link: https://lore.kernel.org/all/Z4hDK27OV7wK572A@google.com
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 22e8855fcd4d..bc98ebb8587d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -396,7 +396,6 @@ void __init kvmclock_init(bool prefer_tsc)
 			 PVCLOCK_TSC_STABLE_BIT;
 	}
 
-	kvm_sched_clock_init(stable);
 
 	if (!x86_init.hyper.get_tsc_khz)
 		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
@@ -416,6 +415,8 @@ void __init kvmclock_init(bool prefer_tsc)
 	 */
 	if (prefer_tsc)
 		kvm_clock.rating = 299;
+	else
+		kvm_sched_clock_init(stable);
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
-- 
2.55.0.rc0.799.gd6f94ed593-goog

