Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD543412294
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934379; cv=none; b=c6vXd+wY1kiYrtBZEPtYPXzC2WFE/rNjoHUh1W62sW0mYx1EGdXiuyb8Ep7QyZBn6K6qJloSq3ZoxZyYKFUXPuGtDOTh+u1y33abfbAIhno0OOVOs9/Bt1hFao4BH4U4dFWXQg7944A18nPtYodMlyyVn/MhImDVjGg4dfK0PyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934379; c=relaxed/simple;
	bh=qoYpZpdKAvs3c+m3l1ZOE6Nj7iAKGdPQ69UNTM7lOtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nFFawCeOpONPJQrI98j1uUSHPSnpxeDa2TanYwspeiPIWLfEf8HSryvQZjndiuw13A/Qf98sHUEygqhw3BS2VDWuam16xy0k5ZlFq8e3vEscqYkRQB8VVw/yULdl1L7PjWPGiG8dtBRg4cuOBqOXGWSRAYa8qbOnnlBucr6s8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTADQx2Q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTADQx2Q"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so990116a12.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934376; x=1783539176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZuhwNx9YXpitDLlgZzJCjWGiYgYUv+Ggq0FniuPOLw=;
        b=UTADQx2Qv+UkuYpZZzj6mDpjUB1/x1XUWBXs33eVIdTmwxCubn5aucvgGyZiIBiGX/
         2TPZ8G72wpzaHNDFjufo4YNQENKFFOaBsntR93nlbouFrd7pi/CzWncg0qUVX+sM6YIE
         PDxiCreYu6NWCtZQk7uI8Occpw5OUR4jZ9nrgb1Y4XtSEvoQLNygWDGBHI3E0VMQVa+v
         PSgS+ovotPVCjzAoBDN2mYbIz6VQuVNeOmxbTzQS4wPP30RLzj2fOiYJ1RJL40e3gNF/
         U3IvxDBU/KDo5NCD0EpiGoHLQl42WWqzSVU/mZAkeC29qAYoNjPrjwQBPYZ26E3mEnBm
         869w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934376; x=1783539176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZuhwNx9YXpitDLlgZzJCjWGiYgYUv+Ggq0FniuPOLw=;
        b=VhuiU1bfUAAuwM4STUpViQ++iqICaWLnOPUoKXbZa3A3STVlBDxtOitufhlhEzSMtL
         zo/DlHcA1+ccvg3xr7hNGyQ2IEAMNuJYRUUVZ3kEh7qVqdwbXTpC52xJ1ZzRxUBZvgDx
         LlaSYKMXUlTpAKBT6vpM2Xx6fpiWEpYfAetzbhNphACw9k3a6Nr8QBRe7yAFbnUdgYpw
         3ejL+i4RIQW12X2rpIzfrNa7CUUhjr/b0ufRljmqXGyS/4KV6oduux/EotKPd8kry+FZ
         cUfHT6UQp6/XdB4UTXKPrCM4Yu/M1ubeiShZ22mq7fJE2xEcHeafxufx80Voa3iXpaff
         ZfjA==
X-Forwarded-Encrypted: i=1; AFNElJ+BsVQHZ8Djbmtkk76XhHLB/O6lWBGZCmGEWak7RayTij3ml2UVo3S/m9BNmzF1Dq7kY8dJE5S+b6xo278=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89rjY0f6Au6hRUsWpzyyYwO/AU5Wno1zTcCMfKcQFTH1wDlKg
	7jNhAIQqvhZ4e93UbCpGheboCZ/Jhr3YYFWfSd+AQrnJsyZyR1vayCGVrIK2Y8IhiGBFKUmbpBv
	3i1hl/Q==
X-Received: from pglx30.prod.google.com ([2002:a63:171e:0:b0:c9e:a22d:15c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e8f:b0:3bf:d0c8:2aa4
 with SMTP id adf61e73a8af0-3bfed1c3990mr3189645637.8.1782934375853; Wed, 01
 Jul 2026 12:32:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:45 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-25-seanjc@google.com>
Subject: [PATCH v5 24/51] x86/kvm: Get CPU base frequency from CPUID when it's available
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

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 1cef54e1e7d9..6c7011ff7bd1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -50,6 +50,7 @@
 #include <asm/e820/api.h>
 
 static unsigned int kvm_tsc_khz_cpuid __initdata;
+static unsigned int kvm_cpu_khz_cpuid __initdata;
 
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
@@ -928,6 +929,11 @@ static unsigned int __init kvm_get_tsc_khz(void)
 	return kvm_tsc_khz_cpuid;
 }
 
+static unsigned int __init kvm_get_cpu_khz(void)
+{
+	return kvm_cpu_khz_cpuid;
+}
+
 unsigned int kvm_arch_para_features(void)
 {
 	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
@@ -1041,6 +1047,14 @@ static void __init kvm_init_platform(void)
 		}
 	}
 
+	/*
+	 * Prefer CPUID.0x16 over KVM's PV CPUID when possible, as the base CPU
+	 * frequency isn't necessarily the same as the TSC frequency.
+	 */
+	kvm_cpu_khz_cpuid = __cpu_khz_from_cpuid();
+	if (kvm_cpu_khz_cpuid)
+		x86_init.hyper.get_cpu_khz = kvm_get_cpu_khz;
+
         /*
          * If the TSC counts at a constant frequency across P/T states and in
          * deep C-states, treat the TSC reliable, as guaranteed by KVM.
-- 
2.55.0.rc0.799.gd6f94ed593-goog

