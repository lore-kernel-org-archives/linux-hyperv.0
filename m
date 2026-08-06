Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DF4A8C9A
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059430; cv=none; b=lOeoL9zaz/DaEl8p2WTRKHd97LDPSLmwY7oaMl0YoZw9ejHcvx5AlKpUKEXipRHLyMJunzC99ZcHZeiEPWGPMtVkD9KWhHKMjdU98f7GZ7BbaHMlqafVDd4kyb4jBhdG7M/4c+CU1nYtb1K8zHc5iMIj3u11ht8DDmmx/CumaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059430; c=relaxed/simple;
	bh=sbzLks0rCz/Y4FC4JU4m7+dMymRO89Rs74fjqXQ5fdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m/HTKssyZAZwbjFSnrExOi6apFLbJwpK4NTJip3uNRNnNhrV1CD0b81YGqqdpPKoZoTaqdHQgS457yH/Z7lwMIogK53UaKvnp5a0G8zCvfhLPhZacJpWksJWnsnbNnO2uCJ8pMahYEjju/W+TbAuK3Rnq9eCFhjz6trvXV3mB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJckNCrX; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJckNCrX"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so5941231a91.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059428; x=1786664228; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aQ8musMrPFB3W7GZXrEzufcFO/9G0XUPjz13+bRyF/M=;
        b=nJckNCrXHLPKAPj629XD4b9gQYhz5Jc0ZOiEvrsNVBmsjvMRHIKMCd5KngSkLsPDVa
         B+r2QKJxzmfFMy9pE/d0JymcKlm9w7vXKzkOL+lh0UxIpcKrjL2PKhGNN8HQW6xGfhV8
         OL+D1VZZSzSy1iqxzN+Rr92/Dy0CnDK0jEWPFIh1AJBevWFtyVTzmpCzwcXzfoDy/wQE
         NKPrj/kI9KOct6sxgG9OjLljQBivdKiiAfRrwu6bDEmhEyUXB5TC4fCGP4osZqzqapQU
         n56GAFhUirPBwLJWa/7Y28xXNsHijxL/XBp9hed1TyR4gTfv2+bRII/ySd5dYOEph3PS
         mlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059428; x=1786664228;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aQ8musMrPFB3W7GZXrEzufcFO/9G0XUPjz13+bRyF/M=;
        b=NmmPbfAJHmubSjaVKXl0DkiLNTRox2f1CDwU+J3mwxy0GQEMqL8o1jaGlllJ+EXLai
         CHKTgfzfLUFQYFwNyqdyCwcMXM3JpfZ+c5dbC5JphBORRo1OOMuXCfjUER0Vur1jp8j3
         rVfmwdArYjCawz40N5AoMIGX1dm0sL8bhRmDGUnws8OmqKJM3eIUeX3iq52hdCqEsx8v
         3fixXJevZ69TWq7UUn6tqF/uoNrpPYh0UZ1Y9qkwDGieCP4o9mLz5sAKU22dso5s5Pj5
         qvrRJR4y7BHNUKlZvy6nhbVlq9mtJAZgk6zlsIkb63EnpC1y8G1PQc3ghcm9CW4ISyEy
         i6EA==
X-Forwarded-Encrypted: i=1; AHgh+RoKVuqK1Ga78fM/+/tl08SQaboe7LHlfST06U34i0phq0xW+YlTNjoEyxIywdUW138AcBkELhwSZ61p5Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNY2AZv9N40nzcjgzfj9lPqVdwULnFLx/UWe93g7WEsbglXaj
	PEdU4a5i7auq7/RJrT/MwlkJw+OXw/v49vM3ZrchAGggCR0etCtjDcrJMO3tknzvrNpX5/7Lk7h
	yAGamgg==
X-Received: from pjpq20.prod.google.com ([2002:a17:90a:a014:b0:38e:befb:90c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264b:b0:38a:c3f:3b87
 with SMTP id 98e67ed59e1d1-3903c58a6femr19988163a91.12.1786059428057; Thu, 06
 Aug 2026 16:37:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:52 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-36-seanjc@google.com>
Subject: [PATCH v6 35/51] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 964f3d6c2c71..60fcc3020792 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -947,9 +947,17 @@ EXPORT_SYMBOL_FOR_MODULES(recalibrate_cpu_khz, "p4-clockmod,powernow-k7");
 
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
@@ -969,7 +977,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	local_irq_save(flags);
-- 
2.55.0.679.g6767b8d81c-goog

