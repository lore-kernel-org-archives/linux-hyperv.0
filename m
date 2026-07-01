Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFC4B8DD5
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934351; cv=none; b=iLgjnPiu3zSTZITWbqr9MgvE5ZXvpXff3MXXNl/wSEmBG2Ynb693VLDSFEgMU8vrdQyasY4XDyUeGXxmgCgNSBcSE37FHc3ErdGVCQbMvX+olUfaYFU40Mnvw3OecNLXxwEYeA1mg0KFOD9yRaSvxqIO49+UTMWt1qYQ++wdBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934351; c=relaxed/simple;
	bh=v2Q0HNtSCGTgYUOIUvvhGqkYnBE/yC1sKZgtPaijFJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pMr2OgJYVlldtxhN48rmcjY5mzzB63ZvGAY4vB7KA8AAKJbN1Ykz6YbibYtw5BYPjdLzMrVWrVx54fkrB08mz4nd7wf0n4ShzPU7dZqbUnWfp76SUp32ip+iZXRduKu375FGpYF0QgwrKnoVkx54yTviVoQQpU3D09/WDEAhPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVd0d2cM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVd0d2cM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c916d17dd43so1229733a12.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934349; x=1783539149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LIZd+3O3352vjgCRNr7RtXOU8moEkEwJFa5rPF13Bys=;
        b=SVd0d2cM4rLZgZk5dMhN/UZG3zFd/v+V9aBfOlPqnhRkqSpgt4Ml37BWxgsZWBkWVB
         R8EVUS+UkD6WXvHH7wtl/rMzdzFmnABYCvqbqBdavedissYZrQRMAsDIBcvOt3NIsRxu
         2+a2Rv+l0Hl8GFkmp7BgQmaQQ737D0ebAT012ZJAOkqd1Dq3rK7Vj0whmL6qSC3COGSV
         q2/pFXk1azcoCSNzftl5UljHBbHnxc8ivwzJdkgLFojm7qz6pFmPx7fFIFEu6lwF63Z8
         ym68y3ZRMGna6nrtP8RE7bad4T2wbxq8rICP9Wp+KzS2l2UH2zq3hem89jbgDJ6byyBv
         Rozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934349; x=1783539149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIZd+3O3352vjgCRNr7RtXOU8moEkEwJFa5rPF13Bys=;
        b=aZyuEf8N7Tm7zn6pMVwWnAl9A+rlET3LIOUGOmDwhhVGJaA1yVXGFAFXKHDTQ+qHFG
         RaQFFrF+dU/uDbuSNcHzIz8eEGK/vr37YzUycJfxEPRiAKj46Gw5l8fobJjqtYqwABdx
         UxI4wzMompC+VW9s1yTdocpwLHXSKy3DanklzYKh1ubqVyQUAUmlp5N55VgayomtWMrF
         jJhSYshXJy91NL+mIgkDy/7RDLj/2IhIQEgytD3uOX9KcyAWpb1Yydq5lV8sKytq9yDN
         PLrhHrMnSPrY5bprsHrbqEoxGpPWA508/Eo4JKfoQkcIgXoJFqlUjwE9Wxu/VvAdwkOW
         oTiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4WMTq4PI0aSJn5HpLEDsw5YE3mlQTKNl3sFkcdhmaGM3NMR1Ae/T8w8KkfKU3KR5wOsgZP8EQmXjcMm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyov2rO0MpIc211xmBKKElop7N8thqv/8VsjVRzi158PM4GgICy
	nEI5EDiaoenUIfWTgS7Of3NnQ8vrvjrAgF4l2JbF2PK1+KlH8+NwjBs3T1vX5UY4XDKOTn6i1U0
	udsPYXw==
X-Received: from pgbcx9.prod.google.com ([2002:a05:6a02:2209:b0:c9a:eb48:4a8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e196:b0:3bf:8604:9a3c
 with SMTP id adf61e73a8af0-3bfed3e9622mr3622600637.28.1782934348718; Wed, 01
 Jul 2026 12:32:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:24 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-4-seanjc@google.com>
Subject: [PATCH v5 03/51] x86/tsc: Ensure that TSC recalibration doesn't run
 if TSC frequency is known
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

When attempting TSC recalibration post-boot, which is only done for ancient
CPUS (P4 and K7) on SMP=n kernels, assert that the TSC frequency isn't
known (explicitly provided by hardware) by way of MSR or CPUID, and bail if
the impossible happens.  In practice, recalibration and TSC_KNOWN_FREQ are
mutually exclusive, as TSC_KNOWN_FREQ will only be set when running on
hardware that was released decades after recalibration was obsoleted, but
but it's hard to see that, especially when looking at just the TSC code.

Note, the WARN can likely be tripped by running in a virtual machine and
concocting an impossible CPU model, e.g. by combining a P4 signature with
CPUID 0x15.  This is working as intended, as such a virtual CPU model is
wildly out-of-spec and is not supported.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4d6a446645c0..4393902c0ddd 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -930,6 +930,9 @@ void recalibrate_cpu_khz(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 
+	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
+		return;
+
 	cpu_khz = x86_platform.calibrate_cpu();
 	tsc_khz = x86_platform.calibrate_tsc();
 	if (tsc_khz == 0)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

