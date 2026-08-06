Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C6493211
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059404; cv=none; b=d+DFAnAa6rrYIoeLpqvoDk3N6wmeNp1CdKmUeb5x7p1LVh9t84vWfmKRjR7e6TvmheZHoy7z1BendOBmb73/QdXo8QLWKZZz62xSpRNyOi4NxpCV7ZOTTUXsK7F4qw5cieRtnKDUnDwIsSbRqm3Kl50UA0/Hin3iw3qEoYBvkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059404; c=relaxed/simple;
	bh=4z1GlPe+fx1kTpwR5eIkMwvFEvBptpYbjy53SQyI3Fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HiWBnziT7P01iCc5DjMejSd3pSxfJTN840K7e09wn6Ix/+N9822YoXV+/cBU5lNpyrWDIWwIQbanvjP7g3aO5ntKsyizuEnVLw0Lf/uL6CGyNBMKaX+v0S771tiK6kiRUJOQ2enSRNNxSV9wVvKoQHszKZfCpfH7W4Iw+MnZ5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZVso5hG; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZVso5hG"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848474825ffso2105020b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059400; x=1786664200; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kmrkRlf4iOUyRYugkcn9gxIXBFL0cMozIwMb4/CeDNQ=;
        b=CZVso5hG5zGbxJowGYCYPV5Bw8AqpJTc/Lm0/N8poGgRplp3fgX+qD4wmH81HJl7ww
         sk9FyNOkDZbOcrr4W7A1WWmp/wvV/JKnRxDZH7X05meVxUSAlBuzw2bPr5yCUYimn/n6
         SkM5WTgUjvwXu0Vd9VKZNZwtlha9/QaRnZQY7u85+iQBY0zaEhQGbZKppTEhAPkXQ78S
         6WC0WIk5PipMQVMPaEhAiA5d7B0JRwP9VQ0uQnERNMaG9sRLDqRQLiHbJBMnhTGj3X/3
         UScXGMmrwQtsmwDyOd4yXdXWVHmyn5GyocbMCgWgeVM7Ess0KWCDY2eiCGmwJCJC3J9j
         /9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059400; x=1786664200;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmrkRlf4iOUyRYugkcn9gxIXBFL0cMozIwMb4/CeDNQ=;
        b=DZKdX+Ye0aHbl9KLU1Za13cm5W8SciH+RKoxvbu7S4ocvkZVrPlJ1lpyEfB6abf3Xh
         Bz/pBozW0bSUPj1BcVvxATbCc/RQwvrKn1Ri9grOwdUGK3SEw0cMvEQwnii6nbJuLnUR
         L4nhvgYgrLfUpGeUgTjE27uB3Pg4i065Ukm8s0ozkqzQtN0wO1RVdEJlQHQyouR7cPOy
         Sqit4OcfGE1AOTbT6Tg5DT+ORVtiwVxzH+TVvRhZ2qGE7acTD2xKDB+EMszNIvZ3Nj92
         JJxgKXtdHHTgM81rmcW3n/+zeyPLEgbMF5NtCu5WgYAP6z6x2svNSA8GMCK+jnMjxBz3
         ufGw==
X-Forwarded-Encrypted: i=1; AHgh+RrLwRERkCMIxK3zcgWfSKPJbH3eQDMigsjXnqV1icY1QMI2+ZadyjmW8WHgBEB248b1s0HBy3qkszTind0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITUMVwywoku2cnfpJ/W3A7WuqoUbWzcO+r25A85cvvoXtSrsz
	ps3MVv5dDRHzrNGAEH8bV3fSzyYSZaEkMkQuzUB4mGEWz7zz8cfLXALWpWyJ2nGk6WbPI+sFoE+
	0W6Xriw==
X-Received: from pfbcz9.prod.google.com ([2002:aa7:9309:0:b0:847:aa6c:47fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4648:b0:842:63f5:d097
 with SMTP id d2e1a72fcca58-84f41ba51c5mr11209793b3a.3.1786059399712; Thu, 06
 Aug 2026 16:36:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:30 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-14-seanjc@google.com>
Subject: [PATCH v6 13/51] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index dc71a6fdd461..3818f6ae0629 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -40,6 +40,7 @@ static void __init acrn_init_platform(void)
 	if (acrn_tsc_khz_cpuid) {
 		x86_init.hyper.get_tsc_khz = acrn_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = acrn_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

