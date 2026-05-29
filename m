Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ECE3F4DEF
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067280; cv=none; b=eDkGc9trb2XzQkavbqF0VwH9tSAigHpy+WULzmBj5eUmG/GE30o5qKCSX0eUQ9p/ejLDo5xKO8TWzH+P4+A1MVsCwqHCtjrSgfPy7l6SgahDb3dfSvHGc1S9DhTBusBy9V4zIU55vfCrg0GHXJxNsTEqem8AtzVif9dNiOuL0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067280; c=relaxed/simple;
	bh=FpeYXKUVm9PMkFdOsJA/iB3JokpDn1J3KKT5u4Rg4HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PDHm3u6Vx5T+xG6DGND0e5DtsCH79HuaPjyLf5g/7HEQj786wBbZGFwluKkZcqJZA3Y2o9WhPBvY7GFGGrMxfseb0JG4zFx3KM9QK8Nwky7/igwyBQNfH+6iBR/tHvrYaPqTIhxNSTkjPNDbKYfR0qm2ZOnMutuBfvXzOHVaNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1u4pSJS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1u4pSJS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828f0f5c23so7214435a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067278; x=1780672078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xxACJL8GJmmB0S+liLqaHbVRa5fkFAryvwd+hR3Tj1U=;
        b=O1u4pSJSSOeUYcFsUgDydMeZlb6uDdrJpEiu8kNRPKnGbijG9UjRIUl3XAQI4CQltB
         5+aumXId6OaSACXvWPZz4y1SjNQyczrhMxvq9oLniRQYy3sD1yBvS4IwD2JtKVLThMNU
         tHpeLRrqJvO1nhZulkacCX8kDZzDtwuuu62+7i/ib2gKJIRCjBlHGfLjXVb0mVcij5Xf
         wUMOa5H7Lk+D+kn+lByie9oA+GJ3A/ZrWIWSQbwg8HS0xJbDsc5w8qrrTkraJbqWdlZ2
         6MyKPR4c/U+VuS872khWrdZ+s0I00Xne1sBb8QWcJCz7FyxEjJ5HFA17ivN+uqctAoFu
         F6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067278; x=1780672078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxACJL8GJmmB0S+liLqaHbVRa5fkFAryvwd+hR3Tj1U=;
        b=MiA0cY2ZGXU8kRHG5AxN4R0Z4yqus0ggvdF6mqIaomoODr7VLsiB1A6sMLmipwY3d5
         CiWCd6yK54MMjk1V6ERziDN6YH5Zsd3d6Rjhg+JdsQ+8RcPtORl2zd96kW7pEe8xTrxA
         4RcmkDlqLaJqXm8VN8V46IS33T1V8jH2j+nIhM2u0iQCdcf9FqfEc3joPQteKKcEPaAM
         ehVgzORyjbAIemZojUgdXjifW2mgjXeS0xaFvZflBuytUb62yagPEN4F2kkm6suQM7Ya
         /LVzTTPkxQmX+dc5CPGd8vm2KF3JGaHQPRbB8yAzIysksaGU/BrdnwtPPzPVB5abow4T
         50IA==
X-Forwarded-Encrypted: i=1; AFNElJ8TvwnvUAeg5/ae31CBio6u22SHBEwZIuIOLfCvNtMciKNEOgqkRoXdowdZUIq98qGoiX4tLrpOUsT8UuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAn7+B4cnkG7/GeubuPRm7SosQtRQY+szlUVXoxvytlKM+8Qpg
	p4q+UOkajMcEC5fbJ02E7AXRo7Pkhp8Vr9YVN4dmdNhQGFSLUpa7fy6w8Hq+LWMAeXo3PSgW9iG
	uHirsnw==
X-Received: from pgbda10.prod.google.com ([2002:a05:6a02:238a:b0:c80:2987:4220])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f88:b0:3b3:1951:489b
 with SMTP id adf61e73a8af0-3b411e714f7mr3887670637.45.1780067278068; Fri, 29
 May 2026 08:07:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:55 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150755.714364-1-seanjc@google.com>
Subject: [PATCH v4 32/47] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a9b6d3399c23..19da1a3d2126 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -972,9 +972,17 @@ EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
 
 static unsigned long long cyc2ns_suspend;
 
+static __always_inline bool tsc_is_save_restore_needed(void)
+{
+	if (WARN_ON_ONCE(!using_native_sched_clock()))
+		return false;
+
+	return static_branch_likely(&__use_tsc) || sched_clock_stable();
+}
+
 void tsc_save_sched_clock_state(void)
 {
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -994,7 +1002,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	local_irq_save(flags);
-- 
2.54.0.823.g6e5bcc1fc9-goog

