Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F6372EF0
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700338; cv=none; b=BqCdjM7hcQszTZi7Rlpw0GGI92Im+VjtMq72X50/IXb579KyxW6MzStgTuBcATYvRFzC91FqBeLw9fISilR/7JSFyS9MYOSwZXi4E1GmCw/0/rlO2hIwIzllGP45wRhLTQPIg1Ed2R0VusiInxSqeTnkrACtc+kHscib63CsE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700338; c=relaxed/simple;
	bh=HBOR86WC+r5IUfnoKph7j7st5MGMxaDmNbjd1b7ALbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BfJ2x7WIZgKiau0lDcd4vrxmV7MNhDSlPWL+nslDihTyeUrr2kuOkhPKeJPW1JJPLI/8YxC7I1H3q7N5Ryuz7vhaDhqVDKz7EoksoihUe4qlybVId4EsAksV84o53QpnhGAYXVGYBPgDpanXsX87nYFyEt2G/M5MH3V7NaNSfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JShPXvz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JShPXvz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD1C1F000E9;
	Fri, 14 Aug 2026 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786700337;
	bh=03ErAPol/vT9WGFlps+/JuNG0Cfcs/ChZD0/DiGMWwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JShPXvz85CmIQ9/wj8EKPy1kjTPu0wwl5y7eTDX80JaH0GlbNHKt22WU6u8e7pwx6
	 27jXtifq4zsJ2tgVlpdNxl956Ui207XDEYZdem5iytjrrNq5RqtUuu3rnrZrsoL4tU
	 uHFhWjIaLSeP+jjAErpbxqcSUTqgcYSmgB/NwIJYlNM7YzvewglkWCpAexeuFCOnNe
	 7eghMesn4Pmtd5TTrSXpk8EBeAY5GBRKu+iHifKDeOB8E/hrTFrY66TtLWt+odSAGI
	 oAjIffyDVgL5Z6aPDwXchrQgKr6FMow9Y+DhhB9rx3P0a455la2XTdCqCpHF7d1tSt
	 zC+1xp58MYrhA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] arm64: Add pre-shutdown hook to
 machine_shutdown()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shradha Gupta" <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260814093154.3191311-1-shradhagupta@linux.microsoft.com>
References: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
 <20260814093154.3191311-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:38:56 +0000
Message-Id: <20260814093857.1DD1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced global function pointer `arm64_pre_smp_shut=
down_hook` is placed in writable memory without the `__ro_after_init` annot=
ation, creating a potential target for control-flow hijacking.
--

--- Patch [1]: [RFC PATCH 1/2] arm64: Add pre-shutdown hook to machine_shut=
down() ---
commit 438763f14354dbd91b5fa7bea807c334ada0c642
Author: Shradha Gupta <shradhagupta@linux.microsoft.com>

arm64: Add pre-shutdown hook to machine_shutdown()

This patch introduces a global function pointer invoked from
machine_shutdown() to allow platform-specific cleanup before secondary CPUs
go offline during kexec or reboot.

[ ... ]

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 581f80e9b9b73..41c0e98409138 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -88,8 +88,21 @@ void __noreturn arch_cpu_idle_dead(void)

[ ... ]

> +/*
> + * Hook for platform code to perform cleanup after device_shutdown()
> + * but before secondary CPUs are offlined. This runs in the kexec path
> + * from kernel_kexec() after device_shutdown() and cpu_hotplug_enable()
> + * have been called, matching the point at which x86 invokes
> + * machine_ops.shutdown.
> + */
> +void (*arm64_pre_smp_shutdown_hook)(void);

[Severity: Medium]
Should this global function pointer be annotated with __ro_after_init?

Without it, the pointer resides in writable memory, which could make it a
reliable target for control-flow hijacking if an arbitrary memory write
primitive is obtained elsewhere. Since the hook is presumably only set once
during platform initialization, making it read-only after init would improve
defense-in-depth on the shutdown/reboot path.

> +
>  void machine_shutdown(void)
>  {
> +	if (arm64_pre_smp_shutdown_hook)
> +		arm64_pre_smp_shutdown_hook();
> +
>  	smp_shutdown_nonboot_cpus(reboot_cpu);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814093133.3191=
250-1-shradhagupta@linux.microsoft.com?part=3D1
