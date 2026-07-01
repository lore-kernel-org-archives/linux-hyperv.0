Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352244DA55E
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934365; cv=none; b=ubPGgVfqx/LvKzQbNw8luH64ka/4xfMpd9V/h91XS2t5xDpwVKCSdxarM1VcjHowSxjtW4FKMVDGuzjEO/ee3Bwb2ihECzeepkV40+LcrCHW2wTLI8PGjajfjGZRr984sFZxWAZY8dH8e7BwAjcQusU4uYd2d9ZJdT0G5fW4lVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934365; c=relaxed/simple;
	bh=CiGkqE/6AT+VqdBT08JjtFv5kCcpPymLLHYJ+kIZoXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9Yb0aBifcVkMK57W7RJjBOPoUs6KQLUh+eWJbLe8YEhc/8jrLT/C2JWxHX4Mzf3hvIAhpW1TE4f+hQCBJ8iT7L5b/F/Juhs+gRAtExfaFqAg+Tx33IVKEe31Mjo9JnBnozAMU24eJrkrwLN/kgGHWBdP2SslPjDDKmYnIVJCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVMfEvpv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVMfEvpv"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8479b45ad08so1025950b3a.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934362; x=1783539162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FaUjTU3QKJy+ktbmudl/+1GzmAqwQnS7of3spvtM7gQ=;
        b=lVMfEvpvQXxC5+fETpqFyjEWlQJQPq/56kpXbPp/syIzIFrxLUvGB0bs+pu1IlN7Ci
         n49bmLOeisfthvCPlLb+S2VTHC234yAsPZCM/vwPD3JPebyikdXfmgooYPqtVB7TOCPM
         RVMckaado0UrAOEc1gbhWrJJLPYBLc3DUFbruOdhSi0uDpikg/C+HLJTpMFh2i5w/zQI
         jmORdLYQexgDboBfkhh8OYf8idrsE7xfTxfcbJod3FMKh5NQrlIs7pO3vh+6ea/MbE6M
         xI0vCq37W7vTmgZQWSFNwnvK36WD4tfF6RITzSojHfu7ZVkEXM9Q77lHO8F69g4onlCR
         Nz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934362; x=1783539162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaUjTU3QKJy+ktbmudl/+1GzmAqwQnS7of3spvtM7gQ=;
        b=hjAK75u8cKvt8sESpimRB6rrV3oC7yhNTWeZ+iG65QbVSKlX+t0Zugc5vJoXHY+fFW
         f/hhu38SQeeL4MOokWuebSegMabl1ukr8vcrhNIkg1zAwuFAnOY4p6X79tYWkGXq4qVf
         Kz2kzePObtjsYgpGlyd5OsEf5qW3/EEP/LRZV2vBFiHrI0I0IXXnt8o2VXYK8o/16xjG
         CeHeWuA5bMXl7WQ224FbPo41tW3Um8vxWwR8vthm66ECPRJ9cPWYPBeb5oKXatQWjQq1
         fCS+rJeT4H57C8gSiM2XkIdzZyHSTbG+al2a9L6jHmsV2oiB8HuTDDy5jksYTDCGsEKN
         1EnA==
X-Forwarded-Encrypted: i=1; AFNElJ+a3Fwu5sv0kG/EgXKfZFuDnkwxYT+SKShXpB1wxYYhZWQj8s5qr5mMXaCErzIc7W6ZUzBIy6R6KRXAMRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTsT+QH4/sJ7gvsO6xpIARp5W4LOIJXLoMurJ7u9/Xf3HF4Q9
	I5T6Z3Fz/mbOaSUZKfQBy+WPt6WzMFwiQxoXoY6jrylTpIn0bpmWZ0wxKfzX57j4rQ036+Z9oKp
	MNKw1vQ==
X-Received: from pghx17.prod.google.com ([2002:a63:f711:0:b0:c9a:53ea:434a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1b84:b0:398:9b42:69f7
 with SMTP id adf61e73a8af0-3bfed3b19b0mr3536321637.39.1782934362055; Wed, 01
 Jul 2026 12:32:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:34 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-14-seanjc@google.com>
Subject: [PATCH v5 13/51] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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
2.55.0.rc0.799.gd6f94ed593-goog

