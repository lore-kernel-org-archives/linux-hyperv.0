Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D784C9575
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934396; cv=none; b=Xp01z5UO43uQQoU6zxgrHF4Rf7sYfWSatdYp52SnXgnc8VYXb2xO1tufZf+7WNGrB5DHBmNK6okqjj3FKHvi0sh5kKL34R9OgrnpXsVrflHzz5w+WA+n73Hse8RN3aUFMcoU8sPVHgXvlR2vBhCEt+uG/1sxADT4A3JshNuXq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934396; c=relaxed/simple;
	bh=KWdxvECh9J5tLpTeYZdnmrdHt5yEzLjA+8xSwXhHHr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WmiMAUlQJzwNIeQU1rOMrL35z3kl/QS8VcXFPVm77HNLJuqC6SAm8odOmP5q6f0/BkBbfRDDylzIGr1ols+RDDxG5kn91EBfSTRoiQc29FdvN3Q6YM/X9dDEPIxvuAVkMeKDnH+Ym6RGBPGemjsXg5bDSpW1DE4nlpXmQpV/O+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yp6RIZSf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yp6RIZSf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c81db324caso14287895ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934393; x=1783539193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=webyAG7YP8cSF0fuLH5JBcVLeBtJwYsS/eijECri5dU=;
        b=Yp6RIZSfsCZnQYHcbIzl7wooDYSgzuwZa+Ith3fcpdGs7+APLEx+Qp4g3O0YoD6FZj
         L2wIu7l0UlV3KQf5FKZS6H9itoKUr0Sf/srVZL7QZn5UczGlkT9VGduZnBrI/6PQ06Iw
         Luvtv4lvczkJEsYikiSbv/Pa/HR1vrWxs7X4IG9R7wVfLaTOAfeBiBRV93/zwgFnDM0/
         Wb2U10CAB1tr0gEsxVmPxHhSEO/c3mwOits/YfBsuAp8avlU50mYikIuOjVazptfNI3+
         E4nsx/c/FJA1xclPCezijnmYPYIy7Ts7o8zJQZM8Xz1vTcdVzMr3aspgKC3V+mLv+eAe
         1pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934393; x=1783539193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=webyAG7YP8cSF0fuLH5JBcVLeBtJwYsS/eijECri5dU=;
        b=grIf24Uod9uBaUzmdjUAPkettVSNd+UzlhtEJZylan8B86f9PkFl5PasjsQIOIFHFy
         LdmaY+pMe5PHYwrQv8H/lvvMeVmX3MF4PwbTZLv/pEMtWu2Uxv5wlGzvetKH6u3LCMPo
         EPWiai8G7baUp1thU9ZChVr5HCpHbzpaRtSkH1aBNqaXZIMr/dBCfGHkw+cOnbJfBPvO
         oSrXREg1VvDKi4KzcQJvBfq29jHbA9yWlVq36bkV0GIgAl25yytphnL4mQ1YuTipq2m9
         Jvc9ZBF9SkvK4uCrMR80EQuHBEsT155VFfCiFtgCQWCulc+zCM69sV/MM5VGtYATRyl0
         tuww==
X-Forwarded-Encrypted: i=1; AHgh+Rqa2BmFGiHyXjdPi61JoRmzN3sUassQrz7ga4//GSH/eHUT0lV+pEaDXRpDgMeNwZRkK1S+B7BAwmqX6Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/V31PRGoFSxWn5nnDirbfCGG/uwhxU2XMmToE32qDQ4CeF6zN
	MSVHWfSrEMRSIuuv+X/65nO77JGhJ9PsRwEe2dgPp3UYN9C4A/oO7PxAMOuGm2tVOepTuPMiWFq
	vkaY1Dw==
X-Received: from plq6.prod.google.com ([2002:a17:903:2f86:b0:2bd:c5f9:e27b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48b:b0:2c9:feea:4e50
 with SMTP id d9443c01a7336-2ca7e71111emr31590225ad.10.1782934393274; Wed, 01
 Jul 2026 12:33:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:59 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-39-seanjc@google.com>
Subject: [PATCH v5 38/51] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 8cd8bfaf1320..bc26f00fc53e 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -443,7 +443,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

