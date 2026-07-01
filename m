Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623404229BA
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934401; cv=none; b=XknstLodTpd3ZQteJ2NzCVfadseJWNJBWpw8nDfTKXIZ34X9I4w7ELiLZAtdn4v4aTTZkOp3/OENQf5wE7TM1kqgG38iCrgOiCdjnVuoYPpkzRuoWcEoBJorTnqQyHO/+U4Et7jsf15WG60PYHldpZwVfHppzbP5AOv+dCx30QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934401; c=relaxed/simple;
	bh=v/jmxMkGYZ/HTlvohOgxWHlLEZvO6K2N4svMiche8Yc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QIYXXZjghLwMNeptnd+YQFVNLCmQd1ehrj7BZbtKPr1T3LwQwmWkv8xYi7naR0Gp90K1iKxc5P3inlBs3o2qZfi/YIT76szrFESjAWg6dT3ly5FFFJd+OhRH6OgJkvA2o1afeAZNcHm9V9vcLpIpIt2hwuzSjoOR5uJiMiK/Nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vARzOcPo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vARzOcPo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c8018f11fbso12445815ad.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934398; x=1783539198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E0Ky72UXh2AIoPVqIZkO5elKJbkXgXhRlg1eH2WcetI=;
        b=vARzOcPonbotl5Eu8R7YZwr7DwSNSZllNUakNzDPaa03BrG6Hai/OiNmi6tMe7Y18z
         KzyPWN8mE9QmO4wQw4spd6qjEkowdg3aMtO7UdtsS6u5NP/K9ITuTpqGMjKolXClE9QN
         eaYH94/Of+Hei9JF6ItM5ObcsgvKkOeJnmK9W3BP04TwClkAqzN0tEgB99x6Biy4UeGy
         VW6UNukIfpt16lg6XBFmyJk20BuqgXsWyX40aOHtIIoq1aiO7VkYyifRAlTElGEf8WoV
         5qyOxOjNq9pPUryKjmZyG3Ew2PEHk9gO3LCbOGT/s0d52Ir255x+O7cOO0dKrzFW4hiY
         6Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934398; x=1783539198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0Ky72UXh2AIoPVqIZkO5elKJbkXgXhRlg1eH2WcetI=;
        b=ooDH2kyslVhMhQKJT79xa/j7vrbTFrLFXBvnve19jzzPC9+7+j/J4Z9OheiK6HkDYS
         AndpRDx1N8khaXtkmHWszHDHSXQZ44S7Y63pOlvp+bCmnB7FdOQZBeMq7pFrIZahY5KX
         ENPGLiAU2fRA30Yg5EDiPcmRJ+KxQFkJ9Hmzd2P8xkY/0+Up7VA9OmYvSLGihOhKRoHg
         9ZEtF6/YZ+C5EqSNYKIDICfI6HLGPgEwYdOEdTd9TOgr4bm2tMZKvmzrv1UjCfvkxd4Z
         YtXkloIMaJ+DkONzFE0CygONi9lMX0whvaVP+6yYkgMM10GxY8rD4sgVp86U/pxrYIvS
         mj1g==
X-Forwarded-Encrypted: i=1; AHgh+RrFbQCAHe+EyjD36CVgQPxzW2oPZJxuOOdtCeK0viTM1H0WXbkcxLCVMvCe6LjUhPB+DdrL/URaLn61zuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWsoTvpgwBwCpYPH3KhqgBq9xabt4eXf1RrXJyngtppDdPTv7
	SiVMH/oTPrMxInIP7r+fabL8NxhbsK12Aks0WJPtYmuU0utf86hXlm7rt9zkr9ztKYiQQ/Ra49k
	sunEyCA==
X-Received: from pleu6.prod.google.com ([2002:a17:903:41c6:b0:2c8:5a:8056])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3885:b0:2ca:17a8:cfce
 with SMTP id d9443c01a7336-2ca911d341fmr20775345ad.29.1782934398119; Wed, 01
 Jul 2026 12:33:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:03 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-43-seanjc@google.com>
Subject: [PATCH v5 42/51] timekeeping: Resume clocksources before reading
 persistent clock
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

When resuming timekeeping after suspend, restore clocksources prior to
reading the persistent clock.  Paravirt clocks, e.g. kvmclock, tie the
validity of a PV persistent clock to a clocksource, i.e. reading the PV
persistent clock will return garbage if the underlying PV clocksource
hasn't been enabled.  The flaw has gone unnoticed because kvmclock is a
mess and uses its own suspend/resume hooks instead of the clocksource
suspend/resume hooks, which happens to work by sheer dumb luck (the
kvmclock resume hook runs before timekeeping_resume()).

Note, there is no evidence that any clocksource supported by the kernel
depends on a persistent clock.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b1b5ec43c0f2..5bc77d36c7a3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2180,11 +2180,16 @@ void timekeeping_resume(void)
 	u64 cycle_now, nsec;
 	unsigned long flags;
 
-	read_persistent_clock64(&ts_new);
-
 	clockevents_resume();
 	clocksource_resume();
 
+	/*
+	 * Read persistent time after clocksources have been resumed.  Paravirt
+	 * clocks have a nasty habit of piggybacking a persistent clock on a
+	 * system clock, and may return garbage if the system clock is suspended.
+	 */
+	read_persistent_clock64(&ts_new);
+
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
 
 	/*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

