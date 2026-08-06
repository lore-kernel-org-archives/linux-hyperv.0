Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01754A6557
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059428; cv=none; b=nDsoNrxDjbnWK4dOI0TvqU7AKwq9Pc1lOVNHTZSNBAkvjoL7wzwHS8g1rxbUK6Gi3C50Ifguv8JsqKAAhJmX9lbP5Pbl1MlAekE0A7K2s/VFx3v46RgQIABdXiWHQ8BOakaVS++mN+fY4zW5Gt2trwo8zkW53KRaQnk+aA6NVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059428; c=relaxed/simple;
	bh=0rWeo5U3RNZ9xcYSG/uqkjOEU1OGp8V9JrAfTrxuqfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HLWKmHBjTKKapZkFP5sq4PnZ7fcV/TYyUtr5m4BOKsUJ7TYSDhmSK8EpbI8VmLQAt94PgP95Dx0CGIuwVVUmj4qyMMNhLw8o+wKOAKu1p1RqlxlN8e7jRfDx4gl+sRu2dJRZMb6vYzN9FApU1poCxG32HsgVARe73RYlaUjNf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hxfwyjn8; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hxfwyjn8"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so1828768b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059426; x=1786664226; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7lbZxAdhwKhuj6TvbAGr7x+TgvyyRrRPdrrP8vwGefI=;
        b=Hxfwyjn8PX0Ni3d5BEm4Xr1Omu7JPIhsk3Iq1vp0zLEaZ2nYvAHWSRlMOsyBPagYWR
         Du7lhhWjAl8RVO9Q0pJoV+4+LvJMu6rh97KjyJK+rd36iZGmR3lUKYcPekzugsg+Svfu
         SRA3fVQxP1wKEgdygBT/rqCOfDYiwY3FaUYhKfSR+c3rrJ8uh4aquCkp/H75h0EGr3PT
         g5dGQVi0krKx+PfKjbeeabKmTWBmH0Hih+pJPnReZNWK+I9VmOBp/e0u2x61RfVu0GHt
         RW/f/1r7BzrIrf8crL80e9bYPbR1OgMFJSUIbvA6EL7LcpPQLAqusJuHxByJ5Zwzi0nF
         pQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059426; x=1786664226;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lbZxAdhwKhuj6TvbAGr7x+TgvyyRrRPdrrP8vwGefI=;
        b=s1wrZR61XY6vTOcs21W5EMYsXpbzmRtEqUA9UH+rG7UXGlwCSVLrrsUZXilH7qR/7v
         3LNVnUXhbkRufZKeI6qnXFPc0lFwxe2/e8K2+/wtvquyDowg29WMG6+Uv/+UcAEgnZqi
         MyBTAYAcOdy/494nUxgC8CLbsfonqQInhaU+fxxf/zW1aDMwZa6AVeavMBxEVK8FsLsb
         x8X/EsWCkk28yKccwsWt7pmJ40vaX2zwD3bwAEgIrUYx/nU8SCnlD53VL6pO8ye/tQ9y
         R8FLupLIBYHtt5r56CCK4qLCp5R0XKrUtCk/HlEYQbCYWd/GY8H5OS/oAjoYKI+bt5xN
         HkfA==
X-Forwarded-Encrypted: i=1; AHgh+RpwAJKezfKSNte/DdRwshwTWS+4gIuLmnhi+KBzHNTmGev9UyL6S5SPjnlfTGVTCwHFW0d6thlpMRBBu6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIxu/1nTHQ4bfZuhbGYAi3hTnZ60ZAd69GfbuZHuQpamMEarx
	M6GXRUhTn595Qab5SF9XwEqiz10QaNwzlPimiCB7/uuqH2HH8P8wkGQ+uSPjcgnwjj4YPbfjHXZ
	9HZQpiA==
X-Received: from pgmt23.prod.google.com ([2002:a63:2257:0:b0:c86:61a1:3390])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7105:b0:3bf:651d:fee0
 with SMTP id adf61e73a8af0-3cba2b5d6a7mr10015839637.19.1786059425491; Thu, 06
 Aug 2026 16:37:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:50 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-34-seanjc@google.com>
Subject: [PATCH v6 33/51] x86/xen/time: NOP-ify x86_platform's sched_clock
 save/restore hooks
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

NOP-ify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 487ad838c441..477441752f40 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -567,6 +567,12 @@ static void __init xen_init_time_common(void)
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
2.55.0.679.g6767b8d81c-goog

