Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F74AD67C
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059450; cv=none; b=lhX2G/uscgsrcQjUH+8MvBJhK1IwP/WA4ye+CjFYLCCMfx/HgVsO113zhnPRXx+11aR8ZLt6Dx7ME6d5GOYG3/LGpIeqcLkm03hQYTgGtqhIaNP2KWSSIm0MUBVw7bwcPoEKAqAFVinjKj7reidRDMm3feVz5Yu6ca3Kn6eq2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059450; c=relaxed/simple;
	bh=UjpjKwl+lBUDjSIYpCNArAdlu1FqZC9gy6u6ndRSMj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nONGoogEeOMbi7/a51IHJOlDkoujI5832c7NqL5CT0miXvJ7Y1ItmSqvIuLJST1RWlRyrAeCRktV8Wj8LN3p4uqnreUckpFmKrD6rL1u6LjGrKuB4X157bo11YWu0GNe7BX2UZN4ZBQbQ5WoV1k049Eo9fw2fUF4AS4PuolEcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2ieCjFj; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2ieCjFj"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc6dd43737so50917245ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059447; x=1786664247; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WG6tzs8/D5vUVAMD7J6BXfy7SNaM+XPXtfc+RTelhM8=;
        b=F2ieCjFjISEPh5Mxfbr1nKl0tKoKKUgXtVYrsB5u1kUy3eaEFqDeUZyRDCThAD9e1Y
         p5dHbHqPgc/IAA02Ylbi1DXp4ePS4pheU/i9wZ3QthJOhm1VLQ1/bnWw9pXimFiFFDWL
         K1wJqXq9Zi9FAIF9lw9+fQUWikDGgrvrDwg2JSHMfASeZeW4xt8btj8ZFRpZVmVjVZM4
         eoWEtH1xyUIqTfLKreDfY0WV++aii9jOsJy57GRAoNeCV9/Iq/dJEDng7InwVXIfJ6bd
         2FLYv2RD3U1RQw+GDUEhiBR7b/s8g8qhiButAEWRh6/wAT6zJLkpu8ZmEOQFcTWv59NN
         bLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059447; x=1786664247;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WG6tzs8/D5vUVAMD7J6BXfy7SNaM+XPXtfc+RTelhM8=;
        b=TDpcsVguwlP3mopw4dfZm53zqueE7hZMbxIM5l+DL/pHQ1Ge5u9jcSRpIr0EohYYvk
         jaTlVsF3Z8Jw7wPPiuKA3dY7zNS8kPy6MzcdOxISReHSp+jmR700pb19WtrOFt9IEHXR
         D9vZ/7DGIftabjqbKI2Isfu8P1L1uGRvLdFfkKKLfdkgC44CNg9U0qrRz3REpjaVLuJL
         VG7YGEr3lZ4O6vPpBXmO2ukDdH/gRhzaMionWC0/06FQ/LcspXSQQb1xfYdjShIJdi5y
         re0/hCgAv6oekcIagNBjtCIw1kMMr2a0j6wZHDWCgkQE0fSOe94wyVqFFgys+GZwqj6p
         UjPg==
X-Forwarded-Encrypted: i=1; AHgh+RrtLAq8JPGqhzBILsXC7x+WgkFejft2zRJ7+nOLak3jiSoz3Lw/pR6lbixs94KEzM0ZAAvdsd3baiLqaxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfdy/DuiT7D5zJTx5/rpDxR+Q12G1yoJ63f8lx6kNRdAE+lLmP
	U/NOeLZoVD/dumg+UD7MfsBDS9PXvLXdB5eAJSQCqe0897on64DU1GUJ48qcKxKrCiES8uEbaTL
	5TOQgQg==
X-Received: from pjgg14.prod.google.com ([2002:a17:90b:57ce:b0:380:f969:825e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2590:b0:38f:2168:b9cb
 with SMTP id 98e67ed59e1d1-3903c572a05mr18788898a91.9.1786059447175; Thu, 06
 Aug 2026 16:37:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:08 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-52-seanjc@google.com>
Subject: [PATCH v6 51/51] x86/kvm: Get local APIC bus frequency from PV CPUID
 Timing Info
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

When running as a KVM guest with PV timing info provided by the host,
stuff the APIC timer period/frequency with the local APIC bus frequency
reported in CPUID.0x40000010.EBX instead of trying to calibrate/guess the
frequency.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b954238b09fc..edeff41c03c2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -992,7 +992,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
-	u32 timing_info_leaf;
+	u32 timing_info_leaf, apic_khz;
 	bool tsc_is_reliable;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
@@ -1054,6 +1054,11 @@ static void __init kvm_init_platform(void)
 			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
 			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
 		}
+
+		/* The leaf also includes the local APIC bus/timer frequency.*/
+		apic_khz = cpuid_ebx(timing_info_leaf);
+		if (apic_khz)
+			apic_set_timer_frequency_khz(apic_khz, "KVM hypervisor");
 	}
 
 	/*
-- 
2.55.0.679.g6767b8d81c-goog

