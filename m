Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06948F835
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059393; cv=none; b=acRW6ky6jLFGowJiP77l8WiuaAKN/zD65PL0IoPSD2GdZZeht1eLnzVtv/lH6KiAaFynwbThiwp/Eq2ciymPUquJMjAa6UKmHiXjiD0/FtZWkYjpwbGSEx7Sv4xPuv8YqapA0jgYNsORNNv14V+4Zgi+WT2NImQ/QI46+/iNExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059393; c=relaxed/simple;
	bh=COVjz/VMaG10y/OAye851r7NpDmo+A5RSCjUP4fF4Ws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JJje8DOI8tMvyR0xrb/3wA7w+6zAG/yvLHS511lfpMKPNNm8m4xtY57t08u5KoV/7mdez+0aNI6UnqNMUeMRcoyTtMkgIahfzyACZkJTfn2xmG5GWu+Fn+zUBuHzsr19gyTDAUGWvQyMEmp3iwem2npSnzUoDo32HCH8fjKd0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1LdJ0R6; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1LdJ0R6"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486ffba174so6231376b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059387; x=1786664187; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2SJsprQma6tQ2oU494vKbTkDMI4EE2yRA8rYyHQJqoI=;
        b=D1LdJ0R6ioj02gCurpKV+iLLjrK2wb/ihlD5uEdbBxkY9j6Z4JzyM/qZ7Gx/5y3RbT
         SsqQst1tKm/4KvVxmzPjjMs9rtDf3ZRSMmbOUSLTHuoxPtx/DbxHkfacVflAV60KawXb
         EMOgJy+CuU8nqZOzmJNL9TtCILGTwNbY/hJ8r1IZp3nTU3KTmuhtJe67jLRdwuMlOzS2
         drV9bFFiYL0CR3YXKuk4Zriu10iALq0tXZ7z5FYagUOc49sFIEr4K2MktWoPxDHcUM0B
         cA0k2ZcpeC6D+H+A4HGtsPwo/8ZlZRJiArnvAlTYp6//l37BIW8RsfVYfn8xpIgCpB+K
         JqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059387; x=1786664187;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2SJsprQma6tQ2oU494vKbTkDMI4EE2yRA8rYyHQJqoI=;
        b=XN5T9xu0J6O7i9dEFl/FflGFTr/QYqMlWLXNKNC0ZQ+7B6voEooTO/5MLUlpooyUxr
         JexoaK+B4flSMbpfjdf/YuQ2yKR4/xiqyyVZKkVp77gkxhX1n6zEcsAdh0+ll9GEaC8K
         vjUtkZxAEow0EpO6E+INuBd1UEdZIwX6Poqkto8R1NoOKBFZ8qh6u7ZDQ5kW1Gh6BFhq
         yCnShNUyU+ocCOZT3rzkBK2HNCSrkLkfMbLp0Vs4Q2B3M+llxR2RWL/2LDREyGTm55OU
         vsR1uBXOc4EnR64Keo+Fn/3IlXsuDaX3hUWEAgZyRrhLX5HzGNgQH29khhGCo0wE4PVI
         0xVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4hB9w1vR5eM2xG/RjzTmpy7GHazqjnuwbHxsCQzAT9j+mrmeOOvlJDNjboBfVSEsYQgk+n6PXtl7ggZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDyQj3f7JmJcFootouf1qnCh+aMyQGgNuyBWyt076BNZ1W0ihN
	wdCbhtyLqAIU00tb3GrdhAh+D46P2sg5RTb2kxlONpXdbQ9wz5x1/LF5JOjpzeMlZoXrPraHbUb
	5WAm8fw==
X-Received: from pglr15.prod.google.com ([2002:a63:514f:0:b0:c9a:7d72:c316])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d0c:b0:84e:2382:f4f0
 with SMTP id d2e1a72fcca58-84f2dfc8ed4mr19812672b3a.4.1786059387185; Thu, 06
 Aug 2026 16:36:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:20 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-4-seanjc@google.com>
Subject: [PATCH v6 03/51] x86/tsc: Ensure that TSC recalibration doesn't run
 if TSC frequency is known
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
index 4392fddd616e..bc4348585194 100644
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
2.55.0.679.g6767b8d81c-goog

