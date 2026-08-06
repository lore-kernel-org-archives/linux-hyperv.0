Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D84ACCC4
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059443; cv=none; b=V2F2i/jsG/8J5Sg9cSP08booiY2psu6tFCuWJawH5vFQ78xCyJcohYE5o1GQ4BjbIvZbFS6WNzgZuYSQPvp/b6p5Oz9SahgBJV3cvre1IwyKEPAsvosNXtKKtL2Oxcmk+MZMfQYyoP6drzcAS+skcHeSBpoo0NGpthpWRVbg9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059443; c=relaxed/simple;
	bh=XkhFva8JyfvpNMGgTzJPYMHmon5wSx833A7LghpVEEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EbuRix4euUjJoV0XIIkuszy/8KimO9FKYYyDnY6QPSg7rwA6f3ZVj+0LSU8bV9iU+UGOSEwrljqpb3T2RFYZfFjSLEVw0Y9OH40US9M2GH8aFAT53Eq3cnVr318IVOZMZm9NcbpjHjmUgPPwyGC8fe1qeB7c3+8dSutbokNp4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XaOPF2K6; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XaOPF2K6"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so33076955ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059440; x=1786664240; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ITopxW07/FQizEWlsu5JVYhKtG4YNcRGYaSiNeAs44w=;
        b=XaOPF2K6dOx5NT278f3+mfmwrTm8tjgKyxGpYJF0JvVG+RXB4modnZN6zHenUKycVl
         ShrqgnXzrxe/RR0qMVYstahSJ46k/sTl2KL7BI4A+vGnh23qWHSQ8Z1ZDSEgt9L2uecB
         EydA9AL6Kib3nnSYJVXwK6dBI7ilcAvC99yR4cMDvW4d6W2buGGiQn6YNnVSA1w5skG6
         ZX0FDi6L2ttzYFFL+WjRVkxA2BU3Qc9qVQF+1sfr+BGT/v/gAO/So2CQZEbgyrTwbNmq
         OhtuKowu02T9UsTZwUPRxuGPSV1POKuBQM3sF+eC4N067xPPSfxezvfIFHORUAGgxxRb
         QSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059440; x=1786664240;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITopxW07/FQizEWlsu5JVYhKtG4YNcRGYaSiNeAs44w=;
        b=fkSTxip3CdiNqyi7BsV9m8NRZEVzJNiZxBc3I9Lt5U2ENNvDvPirMjQlw1vwvdtcaK
         9BpTg7hpiA2Vg7lGhegBzsTshu21lsmod8SbS4zl+YfixvB43WZeeX8Bb4PPTYlPsvDU
         U/sHmIzj0jL/pYuHR6tdsEKfoT0StMgdGjNw0VqpqA6NX9tJFFjzjwCTeOtqHLq0KXq5
         iEa5SuVVJWGgL9BeRzUmNCP123erfqkTjLDKOXW9pPLGheqamgmX5xu8YwNiSAzO6j4y
         sOie7Aeld01uddVA9TgDiblBDwq4gkoVKzEe8mAI3GipRDucAa9l/UVyquTM8yNPAsRD
         ucFg==
X-Forwarded-Encrypted: i=1; AHgh+RriyDGJSDlZrG0LLdHpWcUUpSW+atNfvf6aP5t31RRjb+nPpdJjbWK4ACRExUDMmfhqD3nUxu2wfYBlIdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziWu/7JYzVioIfUrMcOQD/XOeORkOHVCUqCcHO4rs3IbrW5ugp
	+VrHS6DvClWyjez2Yqc9j0eHsdYuC1Z37fVx55NgQWIpQK0wlSPyzazxAnn4tsHzD9Yd9IcQMi5
	VEs26CA==
X-Received: from pljs12.prod.google.com ([2002:a17:903:3bac:b0:2ca:e163:e0c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41ce:b0:2cf:afa5:b19a
 with SMTP id d9443c01a7336-2d0ca7f8e9amr186517945ad.11.1786059440120; Thu, 06
 Aug 2026 16:37:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:02 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-46-seanjc@google.com>
Subject: [PATCH v6 45/51] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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

Annotate __paravirt_set_sched_clock() as __init, and make its wrapper
__always_inline to ensure sanitizers don't result in a non-inline version
hanging around.  All callers run during __init, and changing sched_clock
after boot would be all kinds of crazy.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 10 +++++-----
 arch/x86/kernel/tsc.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index e97cd1ae03d1..96ae7feac47c 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,12 +14,12 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void));
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void),
-					    void (*save)(void),
-					    void (*restore)(void))
+static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
+						     void (*save)(void),
+						     void (*restore)(void))
 {
 	__paravirt_set_sched_clock(func, true, save, restore);
 }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d4f7cb127235..363145c83919 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,8 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void))
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
-- 
2.55.0.679.g6767b8d81c-goog

