Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A314DC542
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934370; cv=none; b=dYH6hjRfQ17wPljWtpqu7Z7a1z+bWh/2jxA8XdudYy2aBZdGBlkRneYdra0k1xDBxNVyia2oTWzF1q/zAw0lnxAJ1ICn52uIyzc6Udy3QCtG/uGEgc7RgZHj0auZ3x8nnbp1xtRBLbR2MZQa3/NRi3GFH9f8bLv11YapAJmtQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934370; c=relaxed/simple;
	bh=bCu106G3ke2QslwQjzoF0iFGAeRR147Dfw14C3mfIq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k5wMdhHP3XsM3ABHmNOZUxOArvMwcKg4ndDPqAO2JJea26HlJddVl+FjNHyp85JuUkHcjO1h+OwyXe8m1BeUFW263HYzQu+7CiG1GF2eeJSZGfb19kcpQxYjXy83TWD3yNBWdhtnQhseVba8VNdmAeQBhRFw3JdmFI9f1ddG0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGim8zLW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGim8zLW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37c9127e316so1037520a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934367; x=1783539167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wWnD58giubyrEvhTS3JtzvsAOScPFFHLvCt5ZIn12HI=;
        b=RGim8zLW1wlz5dJnZqYLWL3bGdYClN515n10wiLNcVizsBIPQujENdMajLs0iWsW6O
         O+Rx2mKWQRRHRrTpj90TOFoPGek5y9CvlljK8GTnhvSRp9QLcRy24rsh8suZh15fJuoC
         n+5xWIeSE6kJloQzUTTtO6yv2emTebfe/s/Sn6/AotYZtsHbAIQio2FU/fxvIKFXliYe
         gMZJLUWkCwWcwFqAMNiTLiX0Wl9+69Osa0QnHRn83EIUfNNL0IkjMwTy/pK0CnCJQ4CI
         S4sTgzOS5lzQ+vM2PlMED5NQfi5X02T2ecSVnPIwU2Vjn7mY/8D9XAipgF8imJCB2Hlo
         2e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934367; x=1783539167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWnD58giubyrEvhTS3JtzvsAOScPFFHLvCt5ZIn12HI=;
        b=fo/rK281J5LjunD7HrNNuje8t2bRyH2aMed4NItUqbQ7fit98iFBOzczo0zPYiBq80
         Im+UygP088W0uOxVFUKb61UU0SgTpAwoPy5+CgU9tA72I+fHdrD5BfKuzhqJZNxii0bL
         H7NjLfdDARBv3jXrJ5tup5LAgzBmDLR2zKvw7qyGuSEsr1/mllkRt8QSWNOLhKn2s4zp
         MUnyM4lOxD1UEXc2kE46IlZvsZNAwQiXWV57J/xIk4Ac7H9CFzqILR/oiOIBOrqli+KP
         VnAlXrmZ94D438oeXDm+hkzOifJrElsGZQR1ll+C3Y96P/JG2e/YT/O9XC/rNHxs7TF7
         uDOw==
X-Forwarded-Encrypted: i=1; AHgh+RqFI3hzr2PWnFNFG4dSXB8CaACRbmk1r+rcjoFqmUwuPGvy7OjhYMM5OABF57aXp4Ju1M5zZNCTiHnfYUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0U7+6Dp9nR1PlBOqlB5p0ypc/DFv9NT0IVg+zBsQJzeDxJNP
	cFsmXtDz24Ic86tDbWTqT3gJlBL+VXMHxWnIGMoxqk/fOeqmj3xFtt8QUbtf2cSK+yF0GzF1SkA
	AuTq32Q==
X-Received: from pjbms18.prod.google.com ([2002:a17:90b:2352:b0:380:9651:afb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7ce:b0:37d:8426:40de
 with SMTP id 98e67ed59e1d1-380aa0ad396mr2721883a91.1.1782934366877; Wed, 01
 Jul 2026 12:32:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:38 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-18-seanjc@google.com>
Subject: [PATCH v5 17/51] x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
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

Fold the guts of native_calibrate_cpu() into its sole remaining caller,
recalibrate_cpu_khz() to eliminate the extra SMP=n #ifdef, and so that it's
more obvious that directly invoking the early vs. late calibration routines
in determine_cpu_tsc_frequencies() is intentional.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 9764ac758081..6ed6f8f012eb 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -918,21 +918,6 @@ static unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-#ifndef CONFIG_SMP
-/**
- * native_calibrate_cpu - calibrate the cpu
- */
-static unsigned long native_calibrate_cpu(void)
-{
-	unsigned long tsc_freq = native_calibrate_cpu_early();
-
-	if (!tsc_freq)
-		tsc_freq = native_calibrate_cpu_late();
-
-	return tsc_freq;
-}
-#endif
-
 void recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
@@ -944,7 +929,9 @@ void recalibrate_cpu_khz(void)
 	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
 		return;
 
-	cpu_khz = native_calibrate_cpu();
+	cpu_khz = native_calibrate_cpu_early();
+	if (!cpu_khz)
+		cpu_khz = native_calibrate_cpu_late();
 	tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

