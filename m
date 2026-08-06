Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614649502C
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059406; cv=none; b=UkuCc2OlwXXvHgU9w9F225NIJtMGvl0Tii3AEHc7GbUnGShJpwu/izpuekxZO3SzFxHNMH5mihGiyFmcm2BPQSCtqN5W7VCRE2JkWGFXLoeoOiUdRaU7BNRrZWV5REP0b/iE7LQ9E0DwxLKdXBA94mPifMKbGi1WrMUhKTBCxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059406; c=relaxed/simple;
	bh=JVq3rGO4pg6RPeAnx1wMiHtknekbd2VNIRn3YGfu0ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxVXnDDgBIIfGl/TsHgzmz4T44dC2+CCXyrIhGiHP/1pT5kz2V2qzKgwI+XHWzKyftgYK6gDnJUO+jOl1h8bIPkgnSWcQJyMZ1Bt8gwac+dQvfdBOeG7c9U92i6jzPRciOEeex0bQ4wkUCHwrw+87o2KCwKKSYJ+xRHlbpDqgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlO+072r; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlO+072r"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so4350214a91.1
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059404; x=1786664204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VAfqOqpweyKvsFpq/agEYC9CEWnfcmlui4k8L8ZR5pE=;
        b=BlO+072rpsy9DCM83gKW5v7E1PZyyJ67zTdD/BlALmywcI2sQZNZHXQBXAKw4ZqNI9
         orlED5c7TiX1o7l5Zut9YzGld5blVDOpn4O9mYoe7uazWZ3HR54VXdik5t5XvyUMmZvS
         +TsFLGAHZJX4cHUParMffVovk8u+L9n5xjp7cu9DW6uVpOrFhdKFyUu23sRcU4P85abh
         lcJFYNcoagmvLj0NScnYB1g/UzRNDUojXfe6Q+bVTVdYnVBsi6rAnIxhswNTgjBQnyxt
         CzOjlFI/YqrwrR/TmfQQX/JACg7XjCCJIyF+KkCFJZ8NUpmy+enpfNSOQp0OU/SPRfR3
         UupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059404; x=1786664204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VAfqOqpweyKvsFpq/agEYC9CEWnfcmlui4k8L8ZR5pE=;
        b=oF4JqEAD21U+XmNZ3a/alAKOlHRWDaQCi97CleKJ9Q0gcW7G1StzTdgDhgEZrHOilR
         +p2d2y40gYxklVii/C/yGKmvETMeGJaOzIWPHZzkoeDXsSbt485dTZLC0OBoqblRzd44
         CgpPoaFm6G1MKb/22q6iXSRZHrZDRnjbqP5G/mLxWjiQYTsUVI5FIchUwamlGYqcZfAh
         sk9Z4Z7Bz43EQzc57I3aYJmzsXubYtxgD2t76b6axxh+K1YqinUlc0hCZrvpfKlkHFB8
         NYWGg2ohOct6Dkksa2ynKLBrBiEVTqyUMdKGtxitb8T5mt49NuvMLfThdbKUyCsHMg84
         OwwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXzTsD4ebgLadFx2wWaLyYD4LcaX6DCpdoG/KI7/WzCQYSZ/CLXY07VRCh/uxdm4gkw7wCseYOmRwGG5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDylEaZPdVV89og3fU87GeyTi/ePyT469xUICIGk/iiVFw51a
	xvD9NJnMnpXxtiexAzvSGJvKBFM15968s/xCom8rHQki6RL8xeeb2xplmfVeepVIyXUIPppGIcz
	NGou0Aw==
X-Received: from pjbcu4.prod.google.com ([2002:a17:90a:fa84:b0:381:7fb0:5a60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288b:b0:38e:8300:af51
 with SMTP id 98e67ed59e1d1-3903c54d040mr19813478a91.8.1786059403683; Thu, 06
 Aug 2026 16:36:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:33 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-17-seanjc@google.com>
Subject: [PATCH v6 16/51] x86/tsc: Rename pit_hpet_ptimer_calibrate_cpu() => native_calibrate_cpu_late()
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

Rename the late CPU calibration routine so that its relationship to the
early routine is more obvious and intuitive.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1d41ef1db27c..dd9e04e325d6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -752,7 +752,7 @@ static unsigned long cpu_khz_from_cpuid(void)
  * calibrate cpu using pit, hpet, and ptimer methods. They are available
  * later in boot after acpi is initialized.
  */
-static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
+static unsigned long native_calibrate_cpu_late(void)
 {
 	u64 tsc1, tsc2, delta, ref1, ref2;
 	unsigned long tsc_pit_min = ULONG_MAX, tsc_ref_min = ULONG_MAX;
@@ -927,7 +927,7 @@ static unsigned long native_calibrate_cpu(void)
 	unsigned long tsc_freq = native_calibrate_cpu_early();
 
 	if (!tsc_freq)
-		tsc_freq = pit_hpet_ptimer_calibrate_cpu();
+		tsc_freq = native_calibrate_cpu_late();
 
 	return tsc_freq;
 }
@@ -1472,7 +1472,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
 		else
 			tsc_khz = native_calibrate_tsc();
 	} else {
-		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
+		cpu_khz = native_calibrate_cpu_late();
 	}
 
 	/*
-- 
2.55.0.679.g6767b8d81c-goog

