Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929740961A
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067320; cv=none; b=ch3CHiMX5bnGIFKMcKOOtTD3Txuc1n8v9tJQGzEdkIU8Ud7whVne3Uy1+cgzTZE3vP62g+6ehSHoSM9YSNA7ubiGoFKPRehQ2RYuR9gnTQ+AC+nHH8ZsX/XG0yk5dYuwPFVePYIxeoQHOa5sDLcJrpDA3XcLEzn8v2W7sGlpAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067320; c=relaxed/simple;
	bh=Z4oAOLUpAYbd1Tz0ygnPD0Nha8ewr7CaV2/fH3E4CC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D4693wpqupbtgB4sI4aFb8Q5c8Flk18NB0mFhVN066R6uReH4SSkj2WUbj/Xzk/chNaQbOnl2qGKS5qqgPzD30bYTLS2mCCtwvEcvxthcftVqidSi1Nd6zAMuZYvK7R+sCoZFN2fJmZoKuOvV4zh+9SXZBx3Ntj7xysR7py8/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbETHUPW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbETHUPW"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so1040511a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067318; x=1780672118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=79xm+AEEzsSDw8ktlax8YEYwGg5Kvc01O7CLcLHBYus=;
        b=hbETHUPWPx8b0d5AG8KKLSL5P067+SWaT+7CEq8eOZvXvGtHTjgsLJN9ThCr3FXY8q
         QCxXg9C6r0VbytMcrPtWyglunQfp3Wbd5Dz9vNoY/bOIk7/uRbLNpOlms0dwosEB7eMq
         O+iF7+DG4Kl8D1dDCg08ELDSsD+hfha5ZltdKIIyv8GdiaRP1X48WfQdkJa0UNdpihS0
         y6t28x9WwpWVJg1J9wGvUYq9Q+r0lxexE54l/x4oiGb3bdlkl1ocxdg6ruIUfvHLL43q
         t3D9KDoyxOJTaIFZsZnm6EFplYeFnXmxnDp7p0B4VDhK7ObRMvWH6QwZQ3n0Veh+zVS6
         RKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067318; x=1780672118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79xm+AEEzsSDw8ktlax8YEYwGg5Kvc01O7CLcLHBYus=;
        b=e8l4SLDBISk7fhmnEUSiXQl4iRQZhuOgr9Y5jffVPc4To4SFsi2OBAepkjO3yOWhUW
         Bl7M1WIgWgVXGGk0JxDhjN2YAiplASFFRhj+Mgl9PAG/VG6ibj3kBJVdJWb16SHTbvJM
         OjDwEjsmZdBDFrbCtoWT2tRuttTmC0roOAB9YxZHD1nTjgc2QUMgmJaCYdv3AVNQsgqz
         M4yayhJopib+b9w7/RCoUCQWUab4yhCD1EA/lL9Ct7hCenY9p/kR3MYHg08qClAOBNFR
         iDwrP2xC51U2HeZQo6kkJzb9LbRfRFhwHeyMolh6mZpABAfw18ghF8HQCkEUVjWAQRb9
         JU8w==
X-Forwarded-Encrypted: i=1; AFNElJ8t7PI3EqWuieYGmli2hrlJBGZxcfkxFRGt2OCsgITJ4Jc4mdFsCM6gV3TN8bveO4v0qkch62eZGKcsPE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpsK3ussg0cx105uomWdSuVbsRIOMmDop1cvbUXnznZ0UkIkc
	EqQAZiPPJMS/QJ/MztBq1QlzNcvovk33WpBFX0icftrpCDl+4RYl8WpTTL9xMc3XPjTXv0fLIv1
	D3n/8Gw==
X-Received: from pgh1.prod.google.com ([2002:a05:6a02:4e01:b0:c79:8102:80bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184b:b0:366:479e:63a5
 with SMTP id 98e67ed59e1d1-36bbcc160f0mr4139147a91.2.1780067317529; Fri, 29
 May 2026 08:08:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:35 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150835.715093-1-seanjc@google.com>
Subject: [PATCH v4 47/47] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
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

Now that timer.h ended up with CONFIG_PARAVIRT #ifdeffery anyways, move the
PARAVIRT=n using_native_sched_clock() stub into timer.h as a "free"
optimization.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 ++++--
 arch/x86/kernel/tsc.c        | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index ca5c95d48c03..a52388af6055 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -11,9 +11,9 @@ extern void recalibrate_cpu_khz(void);
 
 extern int no_timer_check;
 
-extern bool using_native_sched_clock(void);
-
 #ifdef CONFIG_PARAVIRT
+extern bool using_native_sched_clock(void);
+
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void));
 
@@ -23,6 +23,8 @@ static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 {
 	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
+#else
+static inline bool using_native_sched_clock(void) { return true; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 036916953f4a..159d7d060204 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -302,8 +302,6 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-
-bool using_native_sched_clock(void) { return true; }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

