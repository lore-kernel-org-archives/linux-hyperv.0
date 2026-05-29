Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DA3F23A2
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067274; cv=none; b=lv9Dd8tLXYWMr7EF6hPzabEzfjoNDAtLKGnSq6Ul/l6Ysf0CuOj/3YYkXmpIa0MTSbxsS3DHPJBWpbsX0a6Q+cy2lrVMijc0Ul7S2hxxLJiI/Ksyy5NqqDWXko1JDMDS8n6TCjhO5ZvSM2kVEERWOz0t9ybEC87CW3564QfJyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067274; c=relaxed/simple;
	bh=jVoGol12bIRznjNhieU5A4Tdk7z3jKrmByZepFDORvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QU00GtlffRFvIVGKTKjZv5g8z3ALF1P4/V0UWaBY/X/eMpqE9KJd+XYGdjtVp4RbhAggSzhlFSrxjLk2EPvrrtpVMajNH2XwcNOeB9T91w8UYPVLL7nJdt1jYVXgAxIqQhfRoA5i8pc/ySywEjslO8uIUHyCm+VxEFrlWOF9MtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKT3vjwP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKT3vjwP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so978257a91.0
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067273; x=1780672073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kJfvO9zjLIcNgxwydf05ic8q1+t5yL6F8Cppp5YBjVQ=;
        b=WKT3vjwPfMnixG7ZQirCo+lluDVkV2CZZo0rcELgtwMV9SQo1UDSdpst96Vc0qXM72
         BY4qAZGZ92i93Bm2TDwnQxh3qMmPYNYuNSEG2QXc2FmGZLJIblzCGB92eutxiWgos1Md
         4gFYK0xj2QbKG264ZF4zXZKSqbGrlOJ/FTbwFokVvOmKaUa0Wc9uj5AONgu31aUxRkLW
         s0QVwZ3AaILl04eSzQGyMJB0s/1E1Meldn4ra5j8QBgmSncXLq9xezvwGH8A3ZCELs5N
         rkgZDGl/RxlUt90FbHiNAmMhtcEovoRh21lRW3Xmv4V/Pc4rRhoToVVqdzdQDXis6w65
         b/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067273; x=1780672073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJfvO9zjLIcNgxwydf05ic8q1+t5yL6F8Cppp5YBjVQ=;
        b=Di+CBhUhh7JgdjoVUkrfnVmIIXN8gNmKBoli0y5JOmkEIiIxgfTnqqWHN1fbeC27Zu
         9Fl2qYozRjqLMsCv4WMt0KjToCALov7NemmKhMsIzRlLEI4asJtdTkF+k+wVViWG6L6k
         7dbZ4zziHbAukLyPdqDyQfaPR8bkIL2G/OkU4BEDiZ954P07B6tB3BrjGfe827UTuZS7
         TiwWWpkPRai/j8BZIiZDk1Jvh8N9/MxBl9uJdgMM7Zb8S6gT8+rb+QVxcNkKQy7s1Uxu
         YFy07Dq3uL/sGPZTiXN2GwOOJ0ioam6ojHYnohMlPhYg5bfH43noENvy2/Al2BNNw0Wk
         aRMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pJ+ADTk/VlW4iuWbZoVkI/R5zk0OeGo3WT5QKlx3EYyyqRp++n7+mLYkdZwJedskgroCg5V52l4en4aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFr8p3nzM1436wv0M5kzaKcQiAj+guFavOr1/t7Og8VnIyG8J
	zDu/HN8H54KjtDK2nVl/SUVSpSoFMql86/P++PorrZUDB4fH6xDENGDZ/rrU/sMPWMBOH+r23tJ
	xpCavkg==
X-Received: from pldy13.prod.google.com ([2002:a17:902:cacd:b0:2b2:a70b:98ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b64:b0:2bf:305a:312a
 with SMTP id d9443c01a7336-2bf3680a163mr2618575ad.22.1780067272464; Fri, 29
 May 2026 08:07:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:41 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150741.714145-1-seanjc@google.com>
Subject: [PATCH v4 30/47] x86/xen/time: NOP-ify x86_platform's sched_clock
 save/restore hooks
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

NOP-ify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 36d66abf5379..640b71d22d97 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -578,6 +578,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = x86_init_noop;
+	x86_platform.restore_sched_clock_state = x86_init_noop;
 
 	x86_init.hyper.get_tsc_khz = xen_tsc_khz;
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.54.0.823.g6e5bcc1fc9-goog

