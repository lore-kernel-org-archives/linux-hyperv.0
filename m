Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B5337BAB
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875001; cv=none; b=Qjemb5LeSyQ8le2aIfPA9VxArBTq8+tO+wfJ3nIt1l9qdrqXUHykF6HJ8dg3foKXMD3isMt1EW8a0shoK0x6q3ChmxHuL/UunlkWrk3xCkS+Sw9BMDkOLZ8PIheqtuH0p/sNOC/kWX9dIZqW5CBtffO+f6lELTo0seXNrT4mpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875001; c=relaxed/simple;
	bh=4699LF02dGogRBgsC4sG6ZJOZDGEaBx+w4aOCdT5qjo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1Gpmw8BVLBnpvm2CmPgLozyxjHB1wPtCAwEKi/SGmgqIMMCS7yldOA7tQBrggimDPvjDtzYGO8SIXNNyRzVLRuGvpAsGoJ7TQAFbb0RHqwWPSTp7039CjiLRcV8MwTEDsw3Im1/44ZKbHowrZ2l9TCLIWyc+0A2C9isW/5DzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW8oTLFy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW8oTLFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23F3C2BCB0;
	Fri, 15 May 2026 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875000;
	bh=4699LF02dGogRBgsC4sG6ZJOZDGEaBx+w4aOCdT5qjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OW8oTLFyjfpHnenX5BAXcNkpPYwr7/F173ZplaHWFY/UDMOZ7xea2AQ6zZBThlsqF
	 Hclscs+m0Ns1KU3X0r+UqYfpx7EFwUBuXDQu7pWoN18CFRKA+MpLDSgZirX/vjJgMn
	 AWu6C0yPAV+6K3k9/iqLO9Tgfm6ULSvqriYugNobb1MHOWKlPsB4ru6rHBFLtCX3PB
	 bM8pvzQO3jgd7LW4d7R8gHq2fcHkSzMzNcZKf6aoXslLnfuarNT2+dlsy99XoEkOu0
	 rBEHRO/OlcxaKpAtcYdSPYUiX7/cxZ4i4jJMX9oiKLU3noCTJRw+3dpoJQ1OpxM95N
	 6gSj9zW8BBpxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/41] x86/paravirt: Pass sched_clock save/restore
 helpers during registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-19-seanjc@google.com>
References: <20260515191942.1892718-19-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:56:40 +0000
Message-Id: <20260515195640.C23F3C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional NULL pointer dereference in ACPI suspend/resume and =
kexec paths due to nullified sched_clock save/restore hooks for VMware and =
Xen guests.
--

commit 812ddcb2484da2fae1600ef7146674adbef2e760
Author: Sean Christopherson <seanjc@google.com>

x86/paravirt: Pass sched_clock save/restore helpers during registration
   =20
Pass in a PV clock's save/restore helpers when configuring sched_clock
instead of relying on each PV clock to manually set the save/restore hooks.
In addition to bringing sanity to the code, this will allow gracefully
"rejecting" a PV sched_clock, e.g. when running as a CoCo guest that has
access to a "secure" TSC.
   =20
No functional change intended.

> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index b5cb66ca022b8..968de002975f9 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -347,11 +347,8 @@ static void __init vmware_paravirt_ops_setup(void)
> =20
>  	vmware_cyc2ns_setup();
> =20
> -	if (vmw_sched_clock) {
> -		paravirt_set_sched_clock(vmware_sched_clock);
> -		x86_platform.save_sched_clock_state =3D NULL;
> -		x86_platform.restore_sched_clock_state =3D NULL;
> -	}
> +	if (vmw_sched_clock)
> +		paravirt_set_sched_clock(vmware_sched_clock, NULL, NULL);

[ ... ]

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index b14c4ada89a3f..0114c63dfdd9a 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -280,12 +280,15 @@ bool using_native_sched_clock(void)
>  	return static_call_query(pv_sched_clock) =3D=3D native_sched_clock;
>  }
> =20
> -void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
> +void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
> +				void (*save)(void), void (*restore)(void))
>  {
>  	if (!stable)
>  		clear_sched_clock_stable();
> =20
>  	static_call_update(pv_sched_clock, func);
> +	x86_platform.save_sched_clock_state =3D save;
> +	x86_platform.restore_sched_clock_state =3D restore;

Does assigning these function pointers without a null check cause a null
pointer dereference during ACPI suspend/resume or kexec paths for VMware
and Xen guests?

When VMware and Xen pass NULL for these hooks (as formalized by this patch
and introduced in an earlier patch in this series), they are stored directly
in x86_platform.

Then, unconditionally in arch/x86/power/cpu.c:save_processor_state():

void save_processor_state(void)
{
	__save_processor_state(&saved_context);
	x86_platform.save_sched_clock_state();
}

and similarly in __restore_processor_state():

	x86_platform.restore_sched_clock_state();

Will these calls jump to a null pointer since the hooks are now NULL?

Before this patch series, these platforms relied on the default
tsc_save_sched_clock_state hooks, which safely returned early. Setting the
hooks to NULL appears to convert this safe no-op into a regression that
triggers a panic.

Should __paravirt_set_sched_clock() substitute a dummy no-op function when
NULL is passed, or should the caller sites in arch/x86/power/cpu.c explicit=
ly
check if the hooks are set before invocation?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D18
