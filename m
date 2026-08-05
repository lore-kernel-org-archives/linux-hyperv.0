Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D393E3158
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942762; cv=none; b=lE0pdLEpsH7eTZiOhH30I3HA9Ac85xW4GAhyTj7FCi50Zm3U/mDMrbMIP8bA46SKjN3YZLObOYzrzuaTNwRz9BQdWTi2HqE35PplNBZxbLBKPOZ5y5/4Fabds4zQ+SOI8gtaQS2KyUzFDt3kiQQoOQwi6wW2SvDjlZjHiraOnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942762; c=relaxed/simple;
	bh=x+3FjV1V8nTR4+UiTANBZrJzaoaHSLJ+k9/1nIFmr2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=axvnZQI1ZU/LJFP0rfC+71kCNBbLbOBhTwTgEYpIGeriugoXAIm6gUXOazOoDCEEuh2kP8chcskmdOQTUp5Pe5vYmQnddxcTo/Q4hVj2JBGwsAtYRikOuxZsElRwtZCSbRgbrVKzfq22E9ISHPQpi7BqkRN87k1QW7KpF+WTDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk4tA9UP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk4tA9UP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4651F000E9;
	Wed,  5 Aug 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942760;
	bh=xEItjSProfOPfZIr0mmvaAYwTPFhTtZdZtH/k+msRjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mk4tA9UPU2zdnn+JDejWtxhp2TELQvCpLTbrlcQd8aBOsxrVW9pHDkuACF/nQsrvE
	 FmkcT3lVBSUzC2WshawDB3c9NcSKwObF6OQUQTdYTYLTqIj9bwkQXw5o2cfCrynrc/
	 5b8lre4fjeM9WSz9RdFHyo2f1MDJFBWikdiFZocpl1KNcAsmjwZr49SaxTn7TOlnIz
	 nuRSvKzVOxqD2ibnP4didO8r+tPs8aFyfJ0pB7H8f1aQ5L27hE12WaNDq5YpUq5s3N
	 Q3wApvpnm5JXapwNkKT/Af0IJbmn4koUqHd3RZ5y6ZW5M6IBfARNWk6dg9gXzpjEVD
	 Vndl8ow1y11UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup
 for non-nested root partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805142421.104797-1-mhklinux@outlook.com>
References: <20260805142421.104797-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:12:39 +0000
Message-Id: <20260805151240.BA4651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Backwards teardown in `vmbus_exit()` causes failure to free IRQ ac=
tion, leading to reload failure and potential Use-After-Free of unmapped IR=
Q handler.
--

--- Patch [1]: [PATCH v2 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup=
 for non-nested root partition ---
commit d186708fbf26f95dce2f00a8fed8b7ac79496439
Author: Michael Kelley <mhkelley58@gmail.com>

Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition

This commit updates the VMBus module exit function to skip cleanup when
running in a non-nested root partition, matching the behavior of the
initialization function. This prevents memory faults and kernel panics
caused by attempting to clean up uninitialized resources during module
unload.

Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@sm=
tp.kernel.org/

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6824bd7cb3c4f..88fc6add26860 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -3030,6 +3030,9 @@ static void __exit vmbus_exit(void)
>  {
>  	int cpu;
> =20
> +	if (hv_root_partition() && !hv_nested)
> +		return;
> +
>  	unregister_syscore(&hv_synic_syscore);
> =20
>  	hv_remove_kexec_handler();

[ ... ]

>  	vmbus_disconnect();
>  	if (vmbus_irq =3D=3D -1)
>  		hv_remove_vmbus_handler();
>  	else
>  		free_percpu_irq(vmbus_irq, &vmbus_evt);

[Severity: High]
This is a pre-existing issue, but does calling free_percpu_irq() here abort=
=20
and leak the irqaction?

It appears the CPUs have not yet disabled the interrupt, as=20
cpuhp_remove_state() is called much later in this function. Because=20
cpuhp_remove_state() is what triggers hv_synic_cleanup() to disable the=20
percpu IRQ on each CPU, the IRQ is still locally enabled here.

This sequence typically trips the structural safety check in=20
__free_percpu_irq() causing the free operation to abort and return NULL.=20
If the IRQ line fires after the module is unloaded, could the kernel execut=
e=20
an unmapped function pointer?

[ ... ]

>  	bus_unregister(&hv_bus);
> =20
>  	cpuhp_remove_state(hyperv_cpuhp_online);

[Severity: High]
This is related to the pre-existing issue above. Is this execution of=20
cpuhp_remove_state() too late in the teardown sequence?

This step triggers the offline callback hv_synic_cleanup() which calls=20
disable_percpu_irq(vmbus_irq). Because it runs after free_percpu_irq(),=20
the IRQ action is permanently leaked and subsequent attempts to reload the=
=20
module might fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805142421.1047=
97-1-mhklinux@outlook.com?part=3D1
