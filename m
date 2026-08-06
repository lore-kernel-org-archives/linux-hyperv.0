Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B239490BFF
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059396; cv=none; b=NK/OyDRVO+uZmpWZCyWUyLSNprgX9JT/9UDT6vi6ip97byqXEogU6xaZks+SpPriT9SpzO3ksxOYOJzq0bUYamZzK549oPzX0SK1+wote2aWr4laiILvW47X5h0AgH39HWMEAQFN3nV3WqZzzAgapD0ZSsU3Dr1MRq5bkSQk3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059396; c=relaxed/simple;
	bh=Lm8aNsZHGOuUIlXcj3KgaJkbvcxgm3rvJuJfaBGztsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8WVl5yL2cpGNQoN3lHj7YLjA26DF5auRFIJBpJzpn0+H43nGR2HBm6rUOkOva+niVFmq0vw8KSpQWrx//DyAXPCGEq021ugZt5A0W7s0w9ieS6WyCdfCGMAsayT9c74t5NVmU/rv5dAHlQK02z1QRed3VJq7/hIFzej28VMgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUQqk1sI; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUQqk1sI"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso3066359b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059392; x=1786664192; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tcL8w1SVbwtFzoahyKqy3HGwkprj7A9nnDUrJsX64pM=;
        b=nUQqk1sIhasBxDoJk5phmfVWiPecAtjMoVhx5xhao1MiA+dmCMB/hRNdpk4yu7vvYx
         z4We7tFowB91aDLoKuFAgWYznq3iAdh9j91Uu23+6veIPOFeLuiT307Nh9jfyIUrER+b
         5+wtfK/oMatIt8kXRDBRYJjYgFPHObIPa81Rgc5TTLgP1vlXGzItfscFk0kiw5khBDwH
         Pb+MmgD/JrkY5xJkQSDc3ZGk4WGAkdK1GZW8I2IUeqO4+Ez6c4YxhW1Tb1KZBsy6VZMt
         0bFwMoLcBS73a7+wxtuMtdOV2Jw4NzwKZm8uAc6yNr8xhoh8+2doNB4M7EcB+NDNu3xX
         xN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059392; x=1786664192;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tcL8w1SVbwtFzoahyKqy3HGwkprj7A9nnDUrJsX64pM=;
        b=mYnX9i7c2rr839DUXGr188AGxPAu6ABgjLiPZ+/RN5wwn/OT/XfwAOSza59DiMyXiZ
         uXzmhCi7IRfrYaIFaLMXMwaeuUNs6JyxG+SGbHtZqygm/rRbj9sstr3PUzRmt7BZjUOB
         q/JZFHiDZb9J2Tvmp5WUcc6v9tm5g6lqsWpwreuspMzrP/hm0LMwBh58IX8YnFtlXjOe
         99HpkCPs6i9LcQy4OMpuJOZdlcaQ9pSb05315YFuBL3dQukFlwlsanYSzwJH1vGCamu1
         e5XcxPFWHjhgI7BebWkvQ+OqmfAg3pkz4t94auvnPIYYgbQqoD8HOARG7d2Q2bVWXl+S
         9DzQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9teNV5mwJjQHht0LF8pV2US16vvWZHffTsRXCz34ELVgil+op5m7F7+d5safLDOSkeH7CxkmUTdW44Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGT6D3XUNG4Q4OxsZ8UDQLXf0KTJapMmX8t3lSfH8xnYZUaVe
	svcVKVfklE0pPXJFmsNQijW+APHrkP2e8JzZYZBxoKGH+D5LR5i2r/DBXMoLuXkLzri14RJ26ke
	SR6Pfcg==
X-Received: from pgmc14.prod.google.com ([2002:a63:1c4e:0:b0:cbb:8a1e:efa4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10cd:b0:848:8445:6956
 with SMTP id d2e1a72fcca58-84f4fe9f90emr5350899b3a.18.1786059391731; Thu, 06
 Aug 2026 16:36:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:23 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-7-seanjc@google.com>
Subject: [PATCH v6 06/51] x86/sev: Don't override CPU frequency calibration
 for SNP's Secure TSC
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

Don't override the kernel's CPU frequency calibration routine when
registering SNP's Secure TSC calibration routine.  SNP (the architecture)
provides zero guarantees that the CPU runs at the same frequency as the
TSC.  The justification for clobbering the CPU routine was:

  Since the difference between CPU base and TSC frequency does not apply
  in this case, the same callback is being used.

but that's simply not true.  E.g. if APERF/MPERF is exposed to the VM, then
the CPU frequency absolutely does matter.

While relying on heuristics and/or the untrusted hypervisor to provide the
CPU frequency isn't ideal, it's at least not outright wrong.

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ed0ac52a765e..665de1aea0ee 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
 
 	early_memunmap(mem, PAGE_SIZE);
-- 
2.55.0.679.g6767b8d81c-goog

