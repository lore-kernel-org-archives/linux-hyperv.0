Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3A3A8FF6
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700987; cv=none; b=cOm4mE22WXlvHhNHzXZHjFCD3Q+yZ/aR4DFZ4Vth2SNtWOBBgcScAEoT2UHvu4nP5m+jz/o2yoojWAIu8jnObNES91o8qUj8LQa1EQrG4oUnH6ydgoSrC5KqcoXf/cCH84VmO2vkQ74xYk53MiDw4zeHWRJcA/DTkS5i9PhrEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700987; c=relaxed/simple;
	bh=3s4FkEYPeNnKYyv+uc9zU3ZPtZH0m9EqyhCOxopeyOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PBaRRVCNLMs7uiN3A+jtD1nxt/jnWSZhY01U5tFI62H3e4JOe4judcrH8P2m/gZ4ECmF2e1nKOZl8dWiT3WEkQTZF66tgUqnW8H09yfIA/rJU25Cw/tP31C85xCYAV/EcTpXYiOsqw5kRVEHe2bHgAarKZ4fGTGuX6/9VZ7Yug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqkryES+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqkryES+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AC11F000E9;
	Fri, 14 Aug 2026 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786700984;
	bh=cZn9ah/GzT+Jto6PI2V+HqdwpQf/kK91qSiLNLEgiAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqkryES+9FVO+ajMUe6RiFZsIvj7riKwcOj5gMmJM4corWqK/TeF0FwtuCglvWfdb
	 N1wasUbLm6drZQUlPGVOYwKkqzoxlvNjQJyZ9j8F/RFrffkHgg+GhaTkuzR4vkID4Z
	 7tlCRDEteaIvS20TbhijcEmywfw2Y8F8a+DLNBAg9IbUyAMUwMsd2wCVMGx1QQVswD
	 qZczOj8cxMOnrmA0ASztC4GW9ygnfR2xs8t3D9MGqWu7ifOMOfDJ5EhRP8R6n2rEfR
	 TImv0MG/cz/e7BgRQNry68Apc1wjneEp1T7NedH1e2x91QQjmIHs85NbBRJxz8CFwA
	 O5s51pFSIPKOw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] arm64/hyperv: Add kexec handler using
 machine_shutdown hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shradha Gupta" <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260814093208.3191430-1-shradhagupta@linux.microsoft.com>
References: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
 <20260814093208.3191430-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:49:43 +0000
Message-Id: <20260814094943.D7AC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Concurrent module unload and kexec execution causes a Time-of-Chec=
k to Time-of-Use (TOCTOU) Use-After-Free/NULL pointer dereference.

Pre-existing issues:
- [High] vmbus_initiate_unload() ignores vmbus_post_msg() errors, hanging k=
exec indefinitely on wait_for_completion().
--

--- Patch [2]: [RFC PATCH 2/2] arm64/hyperv: Add kexec handler using machin=
e_shutdown hook ---
commit 49c11bb6b5ac02d64fdd78fc6417342ccc8089ed
Author: Shradha Gupta <shradhagupta@linux.microsoft.com>

arm64/hyperv: Add kexec handler using machine_shutdown hook

This patch provides the ARM64 override of hv_setup_kexec_handler() and
hv_remove_kexec_handler(). It wires the registered hv_kexec_handler to
arm64_pre_smp_shutdown_hook to perform VMBus teardown and disable SynIC
during kexec.

> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d74..4176175060d30 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c

[ ... ]

> @@ -15,10 +15,47 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/kexec.h>
>  #include <asm/mshyperv.h>
> +#include <asm/system_misc.h>
> =20
>  static bool hyperv_initialized;
> =20
> +/*
> + * Kexec/shutdown handler for ARM64 Hyper-V guests.
> + *
> + * On x86, hv_machine_shutdown() overrides machine_ops.shutdown and
> + * runs after device_shutdown() and cpu_hotplug_enable(). ARM64 uses
> + * the arm64_pre_smp_shutdown_hook to achieve the same ordering.
> + *
> + * hv_kexec_handler() (set by vmbus_drv.c) performs:
> + *   1. vmbus_initiate_unload(false) - sends CHANNELMSG_UNLOAD
> + *   2. cpuhp_remove_state(hyperv_cpuhp_online) - disables SynIC per CPU
> + *
> + * By running after device_shutdown(), PCI drivers (NVMe, MANA) can
> + * send PCI_DELETE_INTERRUPT_MESSAGE and clean up MMIO/interrupt
> + * mappings before VMBus channels are force-closed by UNLOAD.
> + */
> +static void (*hv_kexec_handler)(void);
> +
> +static void hv_machine_shutdown(void)
> +{
> +	if (kexec_in_progress && hv_kexec_handler)
> +		hv_kexec_handler();

[Severity: High]
Is there a race condition here if the hv_vmbus module is unloaded concurren=
tly?

If sys_delete_module() calls hv_remove_kexec_handler(), it clears
hv_kexec_handler to NULL. If that happens after the check here but before
execution, could this jump to a NULL pointer? Or if the module memory is fr=
eed
before execution, could this cause a use-after-free panic? A simple READ_ON=
CE()
would prevent a compiler double-fetch, but might not prevent the underlying
use-after-free without proper synchronization like RCU or a mutex.

[Severity: High]
This is a pre-existing issue, but enabling this path on ARM64 exposes the
system to a potential indefinite hang during kexec.

When hv_kexec_handler() calls vmbus_initiate_unload(false), it ignores erro=
rs
from vmbus_post_msg() and unconditionally waits for completion:

drivers/hv/channel_mgmt.c:vmbus_initiate_unload() {
	...
	vmbus_post_msg(&hdr, sizeof(struct vmbus_channel_message_header),
		       !crash);

	/*
	 * vmbus_initiate_unload() is also called on crash and the crash can be
	 * happening in an interrupt context, where scheduling is impossible.
	 */
	if (!crash)
		wait_for_completion(&vmbus_connection.unload_event);
	...
}

If vmbus_post_msg() fails (e.g., returning -ENOBUFS if the hypervisor is out
of buffers), the unload message is never sent, the completion is never
signaled, and the thread waits forever. Is there a way to handle this error
instead of hanging the reboot process?

> +}
> +
> +void hv_setup_kexec_handler(void (*handler)(void))
> +{
> +	hv_kexec_handler =3D handler;
> +	arm64_pre_smp_shutdown_hook =3D hv_machine_shutdown;
> +}
> +
> +void hv_remove_kexec_handler(void)
> +{
> +	arm64_pre_smp_shutdown_hook =3D NULL;
> +	hv_kexec_handler =3D NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814093133.3191=
250-1-shradhagupta@linux.microsoft.com?part=3D2
