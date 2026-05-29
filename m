Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDE3F6C5F
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065908; cv=none; b=CQ0mruoLRRYfqiLWBow9zW0VmXLYjsAhDkzXz6DCjUa4O5na0zAKSxdIAAHnoWEjk0495nBd5+DTZF9Lv4NAvqlT4ldiT0ZRMQYr3/sTu6MDBCifGRrAuovkxzmbc3En93xecDz+h16i5UZohzmpVHQdRoty1w/wY94QXvb1gt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065908; c=relaxed/simple;
	bh=QsGKR47k87jDmABsbb6wIJ/Oo6leqTzO1mrFX7LbN8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kqopZDglOXWwLJecnxrEXCsZ9owC0nyC8cZnJQVBCkYkqEw73IijuVvlsq+nFcxh61kGWP+bAJWf87ZsK5f9M0R9yJTeSRLK4Il+mJ0C1TS0Ow1yc3dqtE48s/BY93GYMd7MTHFCErKoaQ0BIqBzUxEQYJ0p0TzdOrT6DYa89gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKCQwTpi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKCQwTpi"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf2bc4371bso2855405ad.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065906; x=1780670706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep5voyn6wy8bCsLD4fpqMEGPbCHcjvgsIyxbB5uxkeU=;
        b=pKCQwTpizj1qUYd60Xj+63HosG5aEgFa00/oSzODrzD5VXcTzkD1lVn8TVu7LlBH9r
         FZ8TJebytJF2vp7ictkpBxtYqkw9AetgYd4zV84xKr33FlGp/wA3cCJlWnQFQwC2epMV
         MAlSyCHyJ2ua7wKHzCHZhg/jjH6DM3QybPukdKYVMrWz2GVLv61+GqKJi3F8/CbzE0b6
         xtTxkqgyit9E8cxUA/8b3qOM3ByF86cu1+/yrUon1nyvGonTCsYgnCTdB/zg0LXIDzBz
         bcvz3MQxaOcsKKwxzqz1vK19hWBe+Kf8NOrBt/SKnfEPALdUAVWF5EH56wWEy/4IQUhm
         qVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065906; x=1780670706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ep5voyn6wy8bCsLD4fpqMEGPbCHcjvgsIyxbB5uxkeU=;
        b=Us06W3hnGdrOZtfC6ou2F+BCL2ACYwxb4rWOcMvIAT9WltX/Gj8RaEQw1kbHnyKhhZ
         CX/a1srSglMGDx1RBv2Qv5IVyILrLuc7Pdzy0s2QMIhsBxJ1wgj1nMHzqbHkKI5SGR2m
         fW2gGyTc9fvJSuZXf1Ych9c3NcOKFWRmhmnSr59oxzfMMBKutW9CfQ2zlTds6d8a5WZe
         i5K0sW4tcxqX/OMciEjX51qu4hx/BYelTPN1lyQ3fJPU8BM470ROm3f9qy2v2etXP4Hg
         Mfa01iRbAwdNG5qWH9F78dm6AqMqK4XWXa0yYjVtdzcmL8CLfYm9LwUkfGB72AsX9nhh
         soGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tUXR2VH6SQissc9m5hZfUm3paNtIgSJXYI6fHa0bws6Nb6NDP4ngkbfLTooy13I1zJhjojMByz8DOT5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvB1hSaKdonluZ/6erGV7KJu+pUiD++0+1OtzQXh9RTo1SjYuT
	HarQAN2ELUHAF1rktovuRKDVKQ9iDbwi2Lw9Dpxb9YgnN5I6yKSClS9fKl+mMGZJZ4O/i+nqD6b
	/M/UDJg==
X-Received: from plbv2.prod.google.com ([2002:a17:903:44c2:b0:2bf:2808:7225])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:144b:b0:2bc:dca9:f0ed
 with SMTP id d9443c01a7336-2bf20dbeeb3mr34014545ad.15.1780065905419; Fri, 29
 May 2026 07:45:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:59 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-13-seanjc@google.com>
Subject: [PATCH v4 12/47] x86/tsc: Rename pit_hpet_ptimer_calibrate_cpu() => native_calibrate_cpu_late()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

Rename the late CPU calibration routine so that its relationship to the
early routine is more obvious and intuitive.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5b4b6e43c94c..534462c81c78 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -779,7 +779,7 @@ static unsigned long cpu_khz_from_cpuid(void)
  * calibrate cpu using pit, hpet, and ptimer methods. They are available
  * later in boot after acpi is initialized.
  */
-static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
+static unsigned long native_calibrate_cpu_late(void)
 {
 	u64 tsc1, tsc2, delta, ref1, ref2;
 	unsigned long tsc_pit_min = ULONG_MAX, tsc_ref_min = ULONG_MAX;
@@ -954,7 +954,7 @@ static unsigned long native_calibrate_cpu(void)
 	unsigned long tsc_freq = native_calibrate_cpu_early();
 
 	if (!tsc_freq)
-		tsc_freq = pit_hpet_ptimer_calibrate_cpu();
+		tsc_freq = native_calibrate_cpu_late();
 
 	return tsc_freq;
 }
@@ -1497,7 +1497,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
 		else
 			tsc_khz = native_calibrate_tsc();
 	} else {
-		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
+		cpu_khz = native_calibrate_cpu_late();
 	}
 
 	/*
-- 
2.54.0.823.g6e5bcc1fc9-goog

