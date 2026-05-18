Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE119E819
	for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145490; cv=none; b=RT/gJRjS9OejJztadC8/WECIqr4HQ4ZiGB0eFQf4z6dLC4Z5sRgDJdTx3yfAYXnvkL3tfrBhNGymvKU4Kj01C1vmAMTQjOVbil43cTEPvPwwW1D1f9w6/AIXjq3M1wp6oYn6sxrlMbJjFNDEmIHgDHb+RLOzSjPGCFv5Nj/q2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145490; c=relaxed/simple;
	bh=Hl8hT+E2KW+vDSL5bkB7oTZecn6JTP/4R7YfibREkfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z8m3f+6cdmTKhqKYNzY8PP3gnelWpLVj/4zFUTEDxLzVqY90mC9qhzSuhy5Z+zPgKn4VXiVq+kJxFYxjOMN80QIj7Zs2Cz8QCr7P6L+MVzMRZbPDSFv9t66LqtDecyK0u2uiyKGOB/p8EO9x+PYwwFvLKsRxV+DaLRraXOpxZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOK3HgD0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOK3HgD0"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-836cfd84728so1362367b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779145487; x=1779750287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/S9c7rYAOiurLeGXWMtdOsnSNHXOh27sQ43Ph+EblY=;
        b=eOK3HgD0f8+GTx3A2Kkdg57R8k5aDzmIrdJ+UOce9me/I2U71mCi6Q6X9odPAIV2bX
         M/qHu3CT+vdXQsm40eGkwa34y582WNPEDH10HSWtw13CZCDEG/OqxILEKZ927B6+PjPG
         QVfKiHiWhML0dhPezB4QC3Q6e9H4N4ic5c586aClCi1vX2Get6Y0by4inyPbOOSnIAsG
         Orii7d2rwkCvOPQ6K4qbVobWWIynC/LSqcZP3+1KzvgixhVFdBBftGIlvfXQ7Imxctgd
         B2a/wSGsTrqJNGakv6ZhT6f42jczBLpet5GBJIviKy3q4YjemygZBeHJcdxHuSalg+cq
         4jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779145487; x=1779750287;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/S9c7rYAOiurLeGXWMtdOsnSNHXOh27sQ43Ph+EblY=;
        b=RoEga8Cps4LAwQxaAeg5oXQiu4QIMpCC7f6dfZtyNgBkRsGhnCdKrBOn5jl/oHydmD
         xLlEPP9PySwLdOCDw08bf5Beh5mnVp6iCQvi8FigL7dvYbV0FnVv0mzrvr2Fkygoo65a
         ZIyDU9nRZfVdtrIyB/wqns79nzYiuysCx2g4vNSx5fh2sqq7hMf5HB1IfoQENOwwxnW8
         xZbNxQnhVqH5TY5eapL99jzZJEV2FGPLcVIu9NQgbrfk0TgqKCYf5BNPGg5XCU91j+po
         zEbPWwmtqCtqzO5tEJMLedQuep0Iu9i6FVQwOlXuYtNLZJ5RL5rYSAaq5rCmTxVJz7Um
         ZtWw==
X-Gm-Message-State: AOJu0Ywzdu8P5KpbvUaBc6xZ5J4ttQMLLmqpBVFwcvPnGtj6uEhdmUa0
	Hfkr+T3cyq5QDHbVjmViiLZyEJZat+LfzAODIp6yeuKwiIh2MLJz/oxb0X3fEg95d4Pds0vfnhM
	dpFxYUA==
X-Received: from pfiy14.prod.google.com ([2002:a05:6a00:190e:b0:838:dc32:5349])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a907:b0:835:447b:a2ac
 with SMTP id d2e1a72fcca58-83f18d5b8f5mr18547579b3a.5.1779145487028; Mon, 18
 May 2026 16:04:47 -0700 (PDT)
Date: Mon, 18 May 2026 16:04:46 -0700
In-Reply-To: <20260515194705.09AFDC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-28-seanjc@google.com> <20260515194705.09AFDC2BCB0@smtp.kernel.org>
Message-ID: <agubDgwQGvoZ3SUx@google.com>
Subject: Re: [PATCH v3 27/41] x86/kvmclock: Enable kvmclock on APs during
 onlining if kvmclock isn't sched_clock
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The logic to defer AP kvmclock registration to the CPUHP_AP_ONLI=
NE_DYN state when it is not used as sched_clock is architecturally unsafe a=
nd will break timekeeping.
> --
>=20
> commit 88625772445f01c4397e3dfd4ee43222efd758cf
> Author: Sean Christopherson <seanjc@google.com>
>=20
> x86/kvmclock: Enable kvmclock on APs during onlining if kvmclock isn't sc=
hed_clock
>=20
> This commit prepares for making early_percpu_clock_init() a dedicated
> sched_clock hook. It adds logic to enable kvmclock on APs during CPU onli=
ne
> if kvmclock is not used as sched_clock, and includes WARNs in the suspend
> and resume paths.
>=20
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index e7250d21c6721..d3bb281c0805d 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> [ ... ]
> > @@ -141,25 +142,51 @@ static void kvm_restore_sched_clock_state(void)
> [ ... ]
> >  void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
> >  {
> > -	/*
> > -	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
> > -	 * being used for sched_clock, then it needs to be kept alive until t=
he
> > -	 * last minute, and restored as quickly as possible after resume.
> > -	 */
> > -	if (action !=3D KVM_GUEST_BSP_SUSPEND)
> > +	switch (action) {
> [ ... ]
> > +	case KVM_GUEST_AP_ONLINE:
> > +		/*
> > +		 * Secondary CPUs use dedicated sched_clock hooks to enable
> > +		 * kvmclock early during bringup, there's nothing to be done
> > +		 * when during CPU online.
> > +		 */
> > +		if (kvmclock_is_sched_clock)
> > +			break;
> > +		kvm_register_clock("secondary cpu, online");
> > +		break;
>=20
> Will deferring AP kvmclock registration to the CPU online phase break
> timekeeping if kvmclock is still being used as the system clocksource?
>=20
> If the user boots with clocksource=3Dkvm-clock or if kvmclock is selected=
 as a
> fallback, it will be used as the clocksource despite not being sched_cloc=
k.
> The kvmclock clocksource read function accesses per-CPU memory that the
> hypervisor only populates after the AP registers its clock.
>=20
> If early registration in start_secondary() is skipped, as anticipated her=
e,
> an AP will boot, enable local interrupts, and process timer ticks before
> reaching the late CPUHP_AP_ONLINE_DYN hotplug state.
>=20
> Could a call to ktime_get() during this window read uninitialized per-CPU
> memory and return 0? It seems this might cause the timekeeper to compute
> massive forward time jumps, leading to immediate timer expirations and
> watchdogs firing.

Hrm, yes, that seems plausible.  Even if it's not actually possible in prac=
tice,
replacing x86_cpuinit.early_percpu_clock_init() with a dedicated
paravirt_sched_clock_start_secondary() isn't obviously better, and so defin=
itely
isn't worth risking breakage, at least not in this series.

I'll scrap most of this, but still plumb in AP_ONLINE and BSP_RESUME for
documentation purposes.

> > +	case KVM_GUEST_AP_OFFLINE:
> > +	case KVM_GUEST_SHUTDOWN:
> >  		kvmclock_disable();
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		break;
> > +	}
> >  }
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.18=
92718-1-seanjc@google.com?part=3D27
