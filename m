Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5F3FFD;
	Fri,  7 Aug 2026 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061094; cv=none; b=IYDE72/Axnqc3ArQ5Dyl0wX3slmKbf/4e5CjpipQYx4p11+E9mkGp8SStl5feqW6E+FlyuLSawLDYQ1mCqdnbp6QnX6ZCbALvlxwx+P1X/XbuO4LRlD0Q37aua0mjIwXbJIvY0p9CTAnyjYUImAm3ti5Tm+FQ5pjKRx/RplvPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061094; c=relaxed/simple;
	bh=nxGza71qehxCBnT18mL8BUIr0BFhdcRxkX9XXQQLIHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkCAwhQ0GjsZbWXRqUKLYzyviTfHd1Aahnm41vyAv5Y7o+hOjwaJkgK8QvWzD5aa750uAo8vNTLzCgFwl5PApHud/Moy50KbrbKeYXSafBYi6M8EaZErpxh5qPjjj2Vyjhrno7TiO74sIsFWPbuXHTGeqAqEsNZER6f6J1mYAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhvP8QR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhvP8QR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFBA1F000E9;
	Fri,  7 Aug 2026 00:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786061092;
	bh=lta1DOMX6Fn5v3+khKF2titzs9a8wp7t62A3BevIxqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YhvP8QR0cL1kHJ6NXGv8pEQ3z4eF1GBPQTcBUX1DBHoSfFU59jLR/LgEdfmFDXJby
	 4gba5Mqpjp7CNKZGN9eK0Fv7psmB6kRc+S/3ESmizSag1w5UvIm1JgZjAP/QfvM131
	 tJJKsWLvM9JgFF+NcrLMt3dzwLJk/fjQknma2fD97rdj2Ubc3OG/rOwK4DADsHZd9u
	 rdWQrVit/0OhdziiwAL5R8rvgvMWPTSh8DuxjfCaVtIYdTgKooA0w4XYCO85RFgllP
	 aR04tp0Y7ke27qG7QXgQRbNkg2MCPg8Qv1CbCPoUNoVFdG2KHbNZg6bCviPz/QTiWg
	 qFOdgfZLh0c4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 29/51] x86/kvm: Don't disable kvmclock on BSP in
 syscore_suspend()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260806233609.212337-30-seanjc@google.com>
References: <20260806233609.212337-1-seanjc@google.com>
 <20260806233609.212337-30-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 00:04:51 +0000
Message-Id: <20260807000452.4CFBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the KVM migratio=
n control MSR (MSR_KVM_MIGRATION_CONTROL) is disabled on suspend or CPU off=
line and never re-enabled on resume or CPU online, permanently breaking SEV=
 live migration.
--

--- Patch [29]: [PATCH v6 29/51] x86/kvm: Don't disable kvmclock on BSP in =
syscore_suspend() ---
commit bb5c379a7a7675001e9cbd3ac5ed082d68cc68ae
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()

This commit introduces a kvm_guest_cpu_action enum to avoid disabling
kvmclock on the BSP during syscore_suspend. The BSP's clock is restored
earlier via sched_clock, and disabling it can cause time drift over time.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c

[ ... ]

> @@ -460,7 +460,7 @@ static void __init sev_map_percpu_data(void)
>  	}
>  }
> =20
> -static void kvm_guest_cpu_offline(bool shutdown)
> +static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
>  {
>  	kvm_disable_steal_time();
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> @@ -468,9 +468,10 @@ static void kvm_guest_cpu_offline(bool shutdown)
>  	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
>  		wrmsrq(MSR_KVM_MIGRATION_CONTROL, 0);

[Severity: High]
This is a pre-existing issue, but does this permanently break SEV live
migration after a suspend/resume cycle?

When a CPU goes offline or the system suspends, kvm_guest_cpu_offline()
clears MSR_KVM_MIGRATION_CONTROL. However, it appears this MSR is never
re-enabled when the CPU comes back online.

For example, when the system resumes, kvm_guest_cpu_init() is called
to restore other PV state like PV EOI and async PF, but it does not
appear to restore MSR_KVM_MIGRATION_CONTROL.

Could this lack of restoration cause a SEV guest to permanently lose the
ability to be live-migrated after an AP offline/online event or a
suspend/resume?

>  	kvm_pv_disable_apf();
> -	if (!shutdown)
> +	if (action !=3D KVM_GUEST_SHUTDOWN)
>  		apf_task_wake_all();
> -	kvmclock_disable();
> +
> +	kvmclock_cpu_action(action);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806233609.2123=
37-1-seanjc@google.com?part=3D29
