Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3154A6FE7
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059425; cv=none; b=bieNpTbVnOvYjtTkMtEmsI9dQtoz5b1u3zpfCoYu+buCpM0R8Ob4hDylhARTiIQK3HwiYcINK1/HheoTWb5//jb6nBFOL4A+Vq8KJu5qrOUI2Vo+m4Z/XcvDCufSQe9qU8J0LXNig/E5KZ70hG7XPPxbkXtRni+d21Fl6PLLvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059425; c=relaxed/simple;
	bh=s2/ZfVS2+K2HvwEjsbelciYdB6FNpWUiBJfvQma4wVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nzNerjfEHQjAM0K4s4dFEGeU27jF+RO9KSfKre3T+yXPj2Gd8xlnv6Z6hHAwdfqpB/5bxjaAFEVOqAgqdlzVfBbPjvTecUbGQnWs6+WOq8XVsRuY3xKviwO79C2m6b8OW882cjdXY6d0d5Kny5Xp2HeRZNOmqZbxe94jCp7J7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFARviB4; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFARviB4"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848568a6f62so4588797b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059422; x=1786664222; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3J0zUIaWZrZleLZttsrL9ykC8Y4xnIiv8MkXpJdWFpw=;
        b=MFARviB4NSkQlmEDR+PggBKrwuQU9TBBlB64jMxPV7kin7LpyuVI7HkmeTXN5UJ8nO
         mVwizoB6Yd7A+Y7I13Yvrb/3RmqvmPJzolC00hxP/idDfEZJzmkM5UM477TJ/i/1NEbY
         KoTqVL6W726H/WQhbuJd7JpPkx1OhQqCZcH3rLsygoExiR4eDBvD8+zOf3N6FhjNK2jr
         nwktuiUunKkHS0a2duejvvNhPjbuEIUC1C14dS+2fNoVt+dpbNEpMahkqjhY5lIFqXig
         E7lPtSF/i0fGGVVB1HHnwa3dFt/Jza6jljS76QOD8TgdGs2yTVqjBqjAlZeGGiKxhIgr
         kJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059422; x=1786664222;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3J0zUIaWZrZleLZttsrL9ykC8Y4xnIiv8MkXpJdWFpw=;
        b=joKZxoT4oibzCXcB03UWeqexRk4rAYaUoRUUopBVwWBYBVJ85tntiP8164dNLHBrvi
         NUnhU8C25TRofIgpgzrSutjn/FdNqW3Y5tmwD5qWb+hgeuI+SStMCkaQPiJve2kjq+Du
         J8x0an6KrlSJO21oyigVMQnEWiWJN41PcA3egom4XnBI3ueEgmL77n2bF994LxcdIKLU
         tYVFEwsw37pmMUjL98eQ2h/yIWol2kYGNOH7twJfpdyDNaYdzHYLk4CnI4HAs8RVYCld
         xrURoNRXTdWq9imTu0dxfNpAz+pRbb7T4TNsXXQoJxiuQMgiUVtv/pFm0FnbEWNl5z+M
         RB5Q==
X-Forwarded-Encrypted: i=1; AHgh+RoJzQD8OdPUtyiaKbG3fsU5IJsgHNttAKT6dOBqxJzBd2OLBK9DohXlGpC1awxbxwnUeQCrFPddnkJXEaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMJKIQf/8nq4q1aoByW99thsJEBF4rHtp1S4BWU4J1l4Gfwfk
	JLX+wbc1Rw9eUGUc/QSOE/xefQYjqBUnhDQMzKoKGaw0H0f/s5hgLiNa+e4p6W4XMup+UeLFEbx
	F7/6PIQ==
X-Received: from pfbcz13.prod.google.com ([2002:aa7:930d:0:b0:848:2e05:6161])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a58f:b0:848:3fe2:c88b
 with SMTP id d2e1a72fcca58-84f2dfc8fa4mr23126519b3a.6.1786059421552; Thu, 06
 Aug 2026 16:37:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:47 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-31-seanjc@google.com>
Subject: [PATCH v6 30/51] x86/paravirt: Remove unnecessary PARAVIRT=n stub for paravirt_set_sched_clock()
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

Remove the unnecessary paravirt_set_sched_clock() stub for PARAVIRT=n, as
all callers are gated by PARAVIRT=y.  Eliminating the stub will avoid a
pile of pointless churn as the "real" implementation evolves.

No functional change intended.

Fixes: 39965afb1151 ("x86/paravirt: Move paravirt_sched_clock() related code into tsc.c")
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 3 +++
 arch/x86/kernel/tsc.c        | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index fda18bcb19b4..c71b466d6ace 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -12,7 +12,10 @@ extern void recalibrate_cpu_khz(void);
 extern int no_timer_check;
 
 extern bool using_native_sched_clock(void);
+
+#ifdef CONFIG_PARAVIRT
 void paravirt_set_sched_clock(u64 (*func)(void));
+#endif
 
 /*
  * We use the full linear equation: f(x) = a + b*x, in order to allow
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4c5328d19ebe..e0bea58b6658 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -288,7 +288,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
-void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.55.0.679.g6767b8d81c-goog

