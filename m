Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A7439F77
	for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973417; cv=none; b=oSVL8yqp7wwIb7wZbCUiF6v/vxJA2kwnuNmX48A7WBaFOoZs+u+G6mpfYGbZqd1uHGWFzTA2RZxZdhYXZ6eMeBoWopCg3mP5qlNB4ZYG0HBgPGkCitHPjO52pLfI5qKKG75LPrmcaaHsgFyuFGdDv5wGWfd9ZwmVoVtB6/EqhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973417; c=relaxed/simple;
	bh=dPWWWotHNV2q6uRgTY8P3gvpjZyKKcwq3kdjWrY31Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAmVQLJA0aT3Ny+3jEtDdq/Ejf+dvogFPYf3etJykgkn0sCtiKGhgGmWKxbZZw9R8dYxAU290ZU1S8tNdjssYXD56bSiIxkJFq2SHCPzCSQ9GAD5EANOUI960RHAu0gDbF98t+6z8ICinEEsuZXWTxMaqE2Pq5hUev1B9ebOLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FuD5zPPc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FuD5zPPc"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E489620B7167; Mon, 17 Aug 2026 06:29:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E489620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786973388;
	bh=xm1FifbZ/uFh2aEErMDQ6hqDQErUBOW2vlv+MD9M1S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuD5zPPc7BUzRzeOqpVPtSpaaOTdjPsOsShRTgeqJTSSQD97vvCCmzHG8jR6r+AIh
	 6wgVRKPhOkUC9rgC+tFNXkVGSN4aWuNpRd9IJxAuVCTrah/BYE8hS85yR2HAoI8DBp
	 I98JXj8QZCGXV1BXLBfYAeYlpaS1XXJgyMDmewzk=
Date: Mon, 17 Aug 2026 06:29:48 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] arm64/hyperv: Add kexec handler using
 machine_shutdown hook
Message-ID: <aoMMzPtAduB1OCzk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
 <20260814093208.3191430-1-shradhagupta@linux.microsoft.com>
 <20260814094943.D7AC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814094943.D7AC11F000E9@smtp.kernel.org>

On Fri, Aug 14, 2026 at 09:49:43AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Concurrent module unload and kexec execution causes a Time-of-Check to Time-of-Use (TOCTOU) Use-After-Free/NULL pointer dereference.
> 
> Pre-existing issues:
> - [High] vmbus_initiate_unload() ignores vmbus_post_msg() errors, hanging kexec indefinitely on wait_for_completion().
> --
> 
> --- Patch [2]: [RFC PATCH 2/2] arm64/hyperv: Add kexec handler using machine_shutdown hook ---
> commit 49c11bb6b5ac02d64fdd78fc6417342ccc8089ed
> Author: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> arm64/hyperv: Add kexec handler using machine_shutdown hook
> 
> This patch provides the ARM64 override of hv_setup_kexec_handler() and
> hv_remove_kexec_handler(). It wires the registered hv_kexec_handler to
> arm64_pre_smp_shutdown_hook to perform VMBus teardown and disable SynIC
> during kexec.
> 
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> > index 4fdc26ade1d74..4176175060d30 100644
> > --- a/arch/arm64/hyperv/mshyperv.c
> > +++ b/arch/arm64/hyperv/mshyperv.c
> 
> [ ... ]
> 
> > @@ -15,10 +15,47 @@
> >  #include <linux/errno.h>
> >  #include <linux/version.h>
> >  #include <linux/cpuhotplug.h>
> > +#include <linux/kexec.h>
> >  #include <asm/mshyperv.h>
> > +#include <asm/system_misc.h>
> >  
> >  static bool hyperv_initialized;
> >  
> > +/*
> > + * Kexec/shutdown handler for ARM64 Hyper-V guests.
> > + *
> > + * On x86, hv_machine_shutdown() overrides machine_ops.shutdown and
> > + * runs after device_shutdown() and cpu_hotplug_enable(). ARM64 uses
> > + * the arm64_pre_smp_shutdown_hook to achieve the same ordering.
> > + *
> > + * hv_kexec_handler() (set by vmbus_drv.c) performs:
> > + *   1. vmbus_initiate_unload(false) - sends CHANNELMSG_UNLOAD
> > + *   2. cpuhp_remove_state(hyperv_cpuhp_online) - disables SynIC per CPU
> > + *
> > + * By running after device_shutdown(), PCI drivers (NVMe, MANA) can
> > + * send PCI_DELETE_INTERRUPT_MESSAGE and clean up MMIO/interrupt
> > + * mappings before VMBus channels are force-closed by UNLOAD.
> > + */
> > +static void (*hv_kexec_handler)(void);
> > +
> > +static void hv_machine_shutdown(void)
> > +{
> > +	if (kexec_in_progress && hv_kexec_handler)
> > +		hv_kexec_handler();
> 
> [Severity: High]
> Is there a race condition here if the hv_vmbus module is unloaded concurrently?
> 
> If sys_delete_module() calls hv_remove_kexec_handler(), it clears
> hv_kexec_handler to NULL. If that happens after the check here but before
> execution, could this jump to a NULL pointer? Or if the module memory is freed
> before execution, could this cause a use-after-free panic? A simple READ_ONCE()
> would prevent a compiler double-fetch, but might not prevent the underlying
> use-after-free without proper synchronization like RCU or a mutex.
> 
> [Severity: High]
> This is a pre-existing issue, but enabling this path on ARM64 exposes the
> system to a potential indefinite hang during kexec.
> 
> When hv_kexec_handler() calls vmbus_initiate_unload(false), it ignores errors
> from vmbus_post_msg() and unconditionally waits for completion:
> 
> drivers/hv/channel_mgmt.c:vmbus_initiate_unload() {
> 	...
> 	vmbus_post_msg(&hdr, sizeof(struct vmbus_channel_message_header),
> 		       !crash);
> 
> 	/*
> 	 * vmbus_initiate_unload() is also called on crash and the crash can be
> 	 * happening in an interrupt context, where scheduling is impossible.
> 	 */
> 	if (!crash)
> 		wait_for_completion(&vmbus_connection.unload_event);
> 	...
> }
> 
> If vmbus_post_msg() fails (e.g., returning -ENOBUFS if the hypervisor is out
> of buffers), the unload message is never sent, the completion is never
> signaled, and the thread waits forever. Is there a way to handle this error
> instead of hanging the reboot process?
>

The x86 Hyper-V implementation uses the same registration, removal, and
dispatch pattern without additional synchronization. That said, I agree
this precedent alone does not prove the two paths are serialized.

For v1, I will use a registration helper rather than exporting the raw
pointer. The kexec path runs only after device_shutdown() completes and
with a single CPU remaining, so in practice unregister cannot race with
dispatch. I will document this ordering constraint explicitly.

For second comment:

Agreed that vmbus_initiate_unload() ignores the return value from
vmbus_post_msg(). This is a pre-existing issue in the common VMBus
code shared with x86. I will address it in a separate cleanup patch
outside this series.
 
> > +}
> > +
> > +void hv_setup_kexec_handler(void (*handler)(void))
> > +{
> > +	hv_kexec_handler = handler;
> > +	arm64_pre_smp_shutdown_hook = hv_machine_shutdown;
> > +}
> > +
> > +void hv_remove_kexec_handler(void)
> > +{
> > +	arm64_pre_smp_shutdown_hook = NULL;
> > +	hv_kexec_handler = NULL;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260814093133.3191250-1-shradhagupta@linux.microsoft.com?part=2
