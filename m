Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77A4F7984
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059440; cv=none; b=WBiGTxLWTEwzpnQPXMR0Cz1tL/Wc7c+sZNFhxrTTU9zzW3jOHqdEdgEsUjUQbEI8NaV8LQmU4OONEE0qRcxXt74nXxFY2wV4Ysyf5Jkb211R6DSeLZroCEwvvlH0iFTQHR2IS86sptNHjWYJA99zVs7+dFxqlZCkYs3uYoqgIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059440; c=relaxed/simple;
	bh=K/EtG7hsgatUBHi5bWDjfRauVW7X2RN7VoYeeZHucVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lO1PXNjkzwRgeSIQ8CzaeBAXljmHx4XjLWMW7AbptRtHl3y0iRldohEPlKqL/3HhYQTiNzeCekpJ5rHI5NsHNLcxzc5A6+EPJgCGyq19VHOOzbp4WRw72ek5sqEJzWeMD9ssNIH7Erv6epuJ4sywEiJQhmSOOZgH7X8bfX3B09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTh/0ag6; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTh/0ag6"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso3886364a91.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059438; x=1786664238; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LM+bFo6oZyT6hMjeOJv5/5C5Sfvue9FfV0H+MNWzQd0=;
        b=YTh/0ag6tM/oAFVXEVZwkvasp1gMe3Oe67/vLfSgvsTOCg/wOEI/b8fhPZSfZwz0g5
         cB1R9kASN95ueg2IRg+EFjQ+ws78kzDFL4nW9h5NzSf2EZygNy6TmX2rTXTnblQzXe8a
         agwvYeyoeay4CQiIG2SCt5FtWzNe1ZbtRbvGp+43tymkXV3cjTtEj6LBmkbEddrpaqeF
         ZCAbOAGdbNFRCy1E3T8WkOfz0c5CIjVjBcK0Iao/hH+Gs3DHQ0Jo0e7e2IUbLTbVCeWE
         9r/urfp0duXhRQ3CBXysgQ3x5H2zszueT3tx910uI6N7/U5OOLGYvP7bIihxPvOqUH/l
         vLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059438; x=1786664238;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LM+bFo6oZyT6hMjeOJv5/5C5Sfvue9FfV0H+MNWzQd0=;
        b=IWu/BRaBDof5yxzflhyzwNa4UP/+xfppgp03u4MP0K5PHjOcfoOcJt+EgkmlH4YUCW
         XTCSx4y11sc670+83ALKy4HXfpCh6Udx5IQ1Ko+A/cuJ8AE2D3pXJ6eCYM5BQE2b7EMO
         xdJv/xLlkSjMNyB0b+CbV9x3/fiKMSG/sybXKIxMUW1FT+dCfZycP8rSyaGaW3kcyWAh
         PeBdQ3fjjoJdPvt2cHbsvWCmRwZh2PRYEGwwQSOu0fU9A6IfwmA9G1kSjzlwr6meBT2x
         bZMJCW6wC49T52u5up8hJO9XeEydkr1Im/YCqBSn9C2xZbTe6moo8iF1GN5hGb7tJWL1
         YtpA==
X-Forwarded-Encrypted: i=1; AHgh+RqT0dGqDGV7/KrPQPoDuOldAUHuB/RXv9OkFh/Gr8Mnyjx8kNkdPZZcZHp0GIf6lsPt+0i903VMnRNNKZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+msb6A30pHBeVVUSppgQj5xJfqXXmRuC6dVTui9jZqbf7UDY
	v0XSmqiR0zrWjO/42DaMB+c0UbqCdqNJyP9dEoit+H2IPv+gI/0Tf9tHXw9XQUseMACllLa72Kj
	i+7r7yw==
X-Received: from pjuf1.prod.google.com ([2002:a17:90a:ce01:b0:38e:aa86:7cac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5447:b0:380:83fc:4315
 with SMTP id 98e67ed59e1d1-3903c66b3bfmr20385633a91.21.1786059437671; Thu, 06
 Aug 2026 16:37:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:00 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-44-seanjc@google.com>
Subject: [PATCH v6 43/51] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
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

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 61d4d943fe74..41aff709b90a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -152,7 +152,17 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
-	kvm_register_clock("primary cpu clock, resume");
+	kvm_register_clock("primary cpu, sched_clock resume");
+}
+
+static void kvmclock_suspend(struct clocksource *cs)
+{
+	kvmclock_disable();
+}
+
+static void kvmclock_resume(struct clocksource *cs)
+{
+	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
@@ -223,6 +233,8 @@ static struct clocksource kvm_clock = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.id		= CSID_X86_KVM_CLK,
 	.enable		= kvm_cs_enable,
+	.suspend	= kvmclock_suspend,
+	.resume		= kvmclock_resume,
 };
 
 static void __init kvmclock_init_mem(void)
@@ -318,6 +330,15 @@ static __init void kvm_sched_clock_init(bool stable)
 				   kvm_save_sched_clock_state,
 				   kvm_restore_sched_clock_state);
 
+	/*
+	 * The BSP's clock is managed via dedicated sched_clock save/restore
+	 * hooks when kvmclock is used as sched_clock, as sched_clock needs to
+	 * be kept alive until the very end of suspend entry, and restored as
+	 * quickly as possible after resume.
+	 */
+	kvm_clock.suspend = NULL;
+	kvm_clock.resume = NULL;
+
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
 
-- 
2.55.0.679.g6767b8d81c-goog

