Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE049EF3A
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059412; cv=none; b=mysPyT0CCEwPBeGc66Kvy4aInXbfTlklYre+X6v+q/Jz5CCH1NuhUOCNmrB28FY1JBenJrZuZM0ZrKYbEBadiVLQWARR1RHtSoWD/53dWuIQHPommuOjI7kvQzQTAbgo87CLJ3q54vdcqLvPqGr7EbPgTAt09VjpH9bx9lKBeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059412; c=relaxed/simple;
	bh=hNEb8xDuzhPNI6tvifSOafJznm7WdTSs3VtHjZgwixU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ry3eh55viecaYP92+BqWyNiRUjA/A83Rih2ICLj9672k5jaqS7UQ08zIz2ckMyRzPaB+qnHI77xfvEIVC1uN/SezbHkp22vpTqKTmeHXszJ9V8BeAdQeL+PMThNEOsDXOL5Jyy8hAGnIOgNnYGk0CmgnTdGU3xQS38oRXncJgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+3SeEuU; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+3SeEuU"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84870e7f498so2970737b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059408; x=1786664208; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kOFXKheX158XT5RdBZeZqj6PvfchU0LO18FYNMDj3A4=;
        b=f+3SeEuUGZdqvkJjB9P3mmwyxZKY+8jTQ75eC5gRfXo5VFDqyWPUUbActIjpbMK7lu
         eAIYwqBShq2vBgslCjqWJm5zK7Vm+oYipUj+jrx1noqLVD2Edre+FmHUadEg3vwPK0M7
         ubbB+mhlOfLb2FX/RvPE7Ivcyhlo+b2ZMoJYjZFb/OrbcDhOPJH2gUGRNHvIiL1kuJyz
         xbf3xE4Uwvq4yW1J8leN2Fkmuv3QyB8tbIX3owrNpuyc/pFDYFwQQscX5Z2ORP0YQbZg
         ZgqEyI/fLeH9E7b5up4xftpUn8pxWBgAjK58vMyPudlHA1FaRwoBMnKfnuvj61nTUvcX
         TgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059408; x=1786664208;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOFXKheX158XT5RdBZeZqj6PvfchU0LO18FYNMDj3A4=;
        b=dyj3EaE11H817oEg5pCts5rYiC2zOG88EODZrzEFIiB3lKKn5NY5rllF4zCml6ELFL
         iKfeLu2qiUbXvcP1SU+S5iamUxxAaaL/R6yFvdM0SJkizZ2pt9+V2Aypxz2NW4ICT4iY
         /tuAHW4crxSvuKNjSwzUD+tLEwPqszeanLYqafig/9mRxC1p9CcEBug9rzRGrhGtSQzt
         yMKo6fHA84A28ByrafbyS7vuGDhsM3a20MFpM0JCfwn2EBZtkSPIZUw3TH7c/X4bgLrh
         UMiDRMd0AgO+L1LchnPHDPaVG1ndmKwyg108V5kCEV0hE/1W8TSS9XJDSaumjPWdOE4P
         KJkg==
X-Forwarded-Encrypted: i=1; AHgh+RrbP+WNk2acLLfGXZTzAC63YX/0kbsQfEB4/OIr0wd/T77aWDA4gsZxm0nCB9mSrBkOT+Ulr6PKkaJ2IuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDG5txmj6/TFu44vdGIFNnlAsxk7OXo0f7g8vt83HuhUaj1luq
	turQU4smsLeGJkBRcLaC/7D6l9qTIJqs2kkbGp7OQhoARxkNx2/3VoGg82HAC/2UsHSPSFG0LDP
	wjWms6w==
X-Received: from pgay6.prod.google.com ([2002:a05:6a02:4966:b0:cbb:8616:5536])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4f:b0:847:9188:e492
 with SMTP id d2e1a72fcca58-84f2e04d173mr18898130b3a.22.1786059408172; Thu, 06
 Aug 2026 16:36:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:36 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-20-seanjc@google.com>
Subject: [PATCH v6 19/51] x86/kvmclock: Drop dead check on TSC being unstable
 during kvmclock_init()
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

As pointed out by Sashiko[*], kvmclock_init() runs before __setup() and
thus before notsc_setup() or tsc_setup() can mark the TSC unstable.
kvmclock_init() also runs well before tsc_init(), and even before
tsc_early_init().  Simply delete the check, as it's been dead code since
it was introduced.

Note, odds are good the check_tsc_unstable() call was copied from Xen's
xen_time_init()+xen_tsc_safe_clocksource() logic (as so much of KVM's PV
code was).  However, xen_time_init() runs via x86_init.timers.timer_init(),
which is invoke from x86_late_time_init(), and thus after params have been
parsed.

Alternatively, kvmclock could register itself later on, or tsc_setup()
could be parsed as an early param.  Given that there's zero evidence there
was any meaningful intent or need to actually check for an unstable TSC,
go with the simplest option.

Fixes: 7539b174aef4 ("x86: kvmguest: use TSC clocksource if invariant TSC is exposed")
Link: https://lore.kernel.org/all/20260529181213.0B27A1F00893@smtp.kernel.org [*]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 061a22d31dea..29ca37e9a3bc 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -362,8 +362,7 @@ void __init kvmclock_init(void)
 	 *
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 		kvm_clock.rating = 299;
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-- 
2.55.0.679.g6767b8d81c-goog

