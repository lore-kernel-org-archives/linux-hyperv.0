Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE54DBD98
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934369; cv=none; b=nCbM02xwJla/Pga+ZMrjeZ0/vlZmkrSHaBbwpqgGlg2hnYKp3/Nn07Yej/Bub4JEY3fkVWBGxlhOyzRce1Jjrw5P6lsU/Zl3m6LUnkrNtH11CTyFu4frI/eDVCkIQWyDP0BLPbi1MuzvLYiN0jtjG0fJ+iN5Xx1HmEWR8MiCLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934369; c=relaxed/simple;
	bh=1GecteZCmORDRJzv/0fTJ5eJc9riviXtHhE/GZIQN3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RxDy+0YMan/Z5jqV1IK+TslAeaQ4T/vxbDrb4YGj7+eA3zisRg8iXuiRIiavyx/PV8JiCqjsn+5TmzybGeqrXlNZ9JgTCycP40ipoiqKV9T2jpQimwn54GM12g4bdNAs5infaA2G9qG9lnz8aNaGBjj1iebUoEz6A0MoNMYO+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZyOcNsU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZyOcNsU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9f452d260so14900555ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934366; x=1783539166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3QmXXgqE7aLG5WH8n+yjrFm5ZX7gR61uwM9vT7lFOWU=;
        b=rZyOcNsUKcbqzdQdFboqK41i16nBNY/Kf3E+cdGf3SB6uo5BL6CWYF+VoQJWosD0Vm
         N6Jy6UaWALxIdKIBiyKdsjEnTxjaN2s6MCvmEi3pQDWScxanuoiamT9QdT9tC4kT9V8S
         2ha3D/Vf0hih/yV4VGOgI8FUpj29x093+lkf/JLR0DC+LWViX/K36kLs0ryos7ylLpbv
         7zS9xQFtOZ+S25bk50a2bCiebTESVXX7UII8K8QcCGOMrW1PhNvyRz/AvoG6CYvShDHY
         uw34SDS4Hp/lsfhRxPtwbI7RiPbeu3QI/RUR+56eyjihGUgWbhy0pj3rlaXUuPEIKRO5
         bcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934366; x=1783539166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QmXXgqE7aLG5WH8n+yjrFm5ZX7gR61uwM9vT7lFOWU=;
        b=pwXF0wICh3ykJpCwil1lLrr7KMjAxsvYUbNhOADtypn3r/Rb2OX6ic7+Z+Q4RuHdNY
         x0KaNvIcvN5JjSj/6isAuaPNVMqakubq8dp6kPGp6kDzQOguM8qKM1iLECjJEcP+6lwE
         XKgJWwivFytM2B620mg5EdHKJ+IFDYAXnQi1haxtI6qhtviYEA+S0cZnCZEZPyW1VE5c
         DGOApdc50sa0BxmHF0QvL+k9IUao9GkCEdweKRjY/Co8goBU3ms6quJY+xatNRHQzx5S
         8wvZAyhxpkrXIZrPmWxDlh8AEbdmEN76VSJT8rxB/tZvcovr+9nGcIzRaltRNrtGHGQC
         NaxA==
X-Forwarded-Encrypted: i=1; AHgh+RqZawdv0dFIrsjHWjetgc22f/A37sGyl3imFRGITlpnXM4oVTYA4opyPWc+jIiXMfx0yZMnzc1TN6qSnZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5z+T3ZUN1Gmrqa+MX+vwAZBNpkmGKnAMmeFG7tjhlj8JJEyOX
	Ks6E3DC45/HKBOblVeDIXpd/QQtcUf+bffJfJcYPZx3gUKje4PonELdCrIdCb6ferCD8JrquhOF
	Zm0KpKA==
X-Received: from plef18.prod.google.com ([2002:a17:902:f392:b0:2c7:eb53:9c06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:2ca:68b1:b64c
 with SMTP id d9443c01a7336-2ca7e75d694mr30967275ad.20.1782934365572; Wed, 01
 Jul 2026 12:32:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:37 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-17-seanjc@google.com>
Subject: [PATCH v5 16/51] x86/tsc: Rename pit_hpet_ptimer_calibrate_cpu() => native_calibrate_cpu_late()
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

Rename the late CPU calibration routine so that its relationship to the
early routine is more obvious and intuitive.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a877b82d0991..9764ac758081 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

