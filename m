Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723B3DF019
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877288; cv=none; b=NGMaFKUqJmbND+AzPklykRlZfaL6IQSCgehhryNJvXJ27eprIqJnP4gT8jGfep6Ad+ia3xfIs8eTGv1howV/gl+UojWTAuKpxv50jdp7QPWVqJIyExQ3V+7WIUk9FrkD/2JZ9hlmarUSLPQMHF6fd8Jhi4rmLH9UqsqsQYZU8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877288; c=relaxed/simple;
	bh=38etjCCr7KQ+mpZMtsFqWW5d5G+mG3j5y8I+1sdbWIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L/2qpJkGODU8J1u5gIX6spGuQaaDfvawT5/MZoj7xUryq2nMqmfx02B5AzqoIfyUHdUjdpq9P+EqiYr2W4FRqzPneFwQ4RumqT+H7bcBPQsUDlFX7xQf/jhDqrA1kdN7McSjlgGZFWtf7N2JwV898pheFJ+GxL5eqeILwOwc4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq9pqbKA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq9pqbKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0E7C2BCB0;
	Fri, 15 May 2026 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778877288;
	bh=38etjCCr7KQ+mpZMtsFqWW5d5G+mG3j5y8I+1sdbWIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Vq9pqbKAhMkegjQWGc3UqEfOsByOTWsWa1fIaMVXVfroUXoCxjh22aOT9PfKChzLD
	 kbQEdCClcWA0YLO/kyyCoJKC+Iwd99gHdxHGDDZv5HcflKvnDf8xLDpmhW3k/6j4k1
	 ySlHGYT7O7KRgjeT4yIz/KeSP4wWiY6w68e8VfXlFc904zlDrQO5sqsxPfF3BKcVIl
	 zw5Jjs1cgnYDRXOs+Sd54VHXim2PoMs20YXswdTMIe+F/reSjv7v45/BwCsBIfaM7V
	 V0oXJwHUVYBwaNpDSqyWKj5X1QWrJr7rwr8G5vA6VQiRptncd/VACjD93aPpBGMqvc
	 bvkHlFW+vFT2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/41] x86/kvm: Don't disable kvmclock on BSP in
 syscore_suspend()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-12-seanjc@google.com>
References: <20260515191942.1892718-12-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:34:47 +0000
Message-Id: <20260515203447.ED0E7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Moving kvmclock_disable() for the BSP to x86_platform.save_sch=
ed_clock_state leaves kvmclock enabled across hibernation if the callback i=
s overwritten by another clocksource (e.g., Hyper-V), leading to memory cor=
ruption.
--

commit 1ada3230c82e463b5d5311eb45fc919a4e06098c
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()

This commit changes the suspend logic to avoid disabling kvmclock on the BSP
during syscore_suspend(). It defers the operation to the sched_clock restore
callback and introduces a new action enum to handle different offline and
suspend cases.

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index df95516a9d899..006e3a13500b4 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
[ ... ]
> @@ -178,8 +178,22 @@ static void kvm_register_clock(char *txt)
>  	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt=
);
>  }
> =20
> +static void kvmclock_disable(void)
> +{
> +	if (msr_kvm_system_time)
> +		native_write_msr(msr_kvm_system_time, 0);
> +}
> +
>  static void kvm_save_sched_clock_state(void)
>  {
> +	/*
> +	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
> +	 * If the system is hibernating, then kvmclock will likely reside at a
> +	 * different physical address when the system awakens, and host writes
> +	 * to the old address prior to reconfiguring kvmclock would clobber
> +	 * random memory.
> +	 */
> +	kvmclock_disable();
>  }

Can this lead to memory corruption if another clocksource overwrites the
x86_platform.save_sched_clock_state callback?

In environments where KVM emulates Hyper-V, both KVM and Hyper-V clocksourc=
es
might be initialized. If Hyper-V overwrites
x86_platform.save_sched_clock_state with its own callback, and previous
callbacks are not chained or invoked, kvm_save_sched_clock_state() will nev=
er
be called.

Because kvmclock clears its clocksource.suspend hook when registering as
sched_clock, the clocksource framework cannot act as a fallback.

This would leave kvmclock enabled on the BSP across hibernation. As mention=
ed
in the comment, could this result in the hypervisor writing to the old phys=
ical
memory address after resume and clobbering random memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D11
