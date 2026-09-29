Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5D41B8F7;
	Tue, 29 Sep 2026 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662875; cv=none; b=ro9LKQ0EieWuCJ/tn32GsrekfGVPA3XdBra372hSc/vF4jBnpKW+k4cyOFrwHIm3e5XmAqwn9yD141zPdXzBCVrV4WeGDxlD1CtiDHPBO963vB2T3ACx7kNcTFpKL26g8jEp0IRpJG0RuUzzS/ezD5/BFcdupH4CFY3RfPi/YGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662875; c=relaxed/simple;
	bh=E/eb4tF+1AGmaXV4gLHVCXrjYPDDjkYzhnkl0GSBGVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1ikdYplPC6EVBiuS90djxDbRWWceS6on0BLR7JRQ3+PpCJxUVs4X2NwiGXexgqr5z/Awx/gSc4oeGX5gb2ECS10Qe7lFh7WaHA9bljZTOzRyyPROni5vl8ke+X25p4XmdqS2OSqP/WpgzM6GOmOzOinQ5FX51LF9FMfYbXd94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DzssL94+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DzssL94+"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 408F420B7166; Mon, 28 Sep 2026 23:20:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 408F420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790662821;
	bh=cLzkxWuX73OtZPd+2cLPey94fJOtYMpaXEvCrZ8y+fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzssL94+9fOyz+ZaO/F7E9BDILNqy8pwVQc2RQ83Kv8Za0Y+WOa4CsCA9Pn/ZSY89
	 8XBi4LF1WftGQwJVK1aUZ1qRatUxpMKKyzYDAn/TVmHrc6vaJus5cXnm5d1jyFmvr5
	 yzRwEo/5Anb0z4nGsNjtCKYYtWVvOlsQOhwGrbTc=
Date: Mon, 28 Sep 2026 23:20:21 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>
Subject: Re: [PATCH v2] arm64: hyperv: run VMBus kexec handler via syscore
 shutdown
Message-ID: <artYpdKh6LJpQKgu@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260907092544.230338-1-shradhagupta@linux.microsoft.com>
 <SN6PR02MB4157A59FB4154C18BFBCB87BD48E2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157A59FB4154C18BFBCB87BD48E2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sun, Sep 27, 2026 at 08:26:45PM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Monday, September 7, 2026 2:26 AM
> > 
> > On ARM64, machine_shutdown() does not provide a platform hook between
> > device_shutdown() and smp_shutdown_nonboot_cpus(), unlike x86's
> > machine_ops.shutdown. This prevents the Hyper-V VMBus kexec handler
> > from running at the correct point during kexec shutdown, causing
> > kexec reboot to fail on ARM64 Hyper-V guests.
> > 
> > Use syscore_ops.shutdown instead: syscore_shutdown() runs in the same
> > window (after device_shutdown(), before CPUs are taken offline) where
> > VMBus UNLOAD and cpuhp_remove_state() must execute.
> > 
> > Provide ARM64-specific overrides of hv_setup_kexec_handler() and
> > hv_remove_kexec_handler() that register/unregister a syscore_ops
> > shutdown callback, replacing the __weak no-op stubs in hv_common.c.
> > On x86, the existing machine_ops.shutdown mechanism is unchanged.
> 
> Reviewing the code, I think this patch works as intended to provide the
> missing functionality on arm64. But it adds to code sprawl by having
> separate implementations on x86 and arm64, and there's an
> opportunity to combine into a single arch independent implementation
> based on syscore_ops.shutdown. Here's an outline of that approach:
> 
> 1) Move the current kexec_handler setup functions from
> arch/x86/kernel/cpu/mshyperv.c to vmbus_drv.c. (Or maybe
> they all just go away per my #4 below.)
> 
> 2) There's already hv_synic_syscore_ops defined and registered
> in vmbus_drv.c. Add the .shutdown function to that syscore_ops.
> (And perhaps rename it to hv_vmbus_syscore_ops as it is no
> longer specific to synic.)
> 
> 3) Remove the hv_kexec_handler code from hv_machine_shutdown().
> The new syscore_ops.shutdown path will run before
> hv_machine_shutdown(), which mean it happens before the call
> to hv_stimer_global_cleanup() instead of after. Until just recently,
> that would have been an ordering problem. But with support for
> Windows Server 2012 Hyper-V having been removed along with
> the legacy message-based path for stimer interrupts,  it's now
> OK for hv_stimer_global_cleanup() to run after the kexec handler
> has done the VMBus unload.
> 
> 4) With all the above code now in vmbus_drv.c, the kexec handler
> functions and data can be static. The __weak stubs for the kexec
> handler can be removed from hv_common.c. And having a
> global variable to store the pointer to hv_kexec_handler()
> is probably unnecessary -- it can just be called directly.
> 
> Net, overall there might be a few less lines of code, instead
> of adding 40 lines. I haven't coded this up, so maybe there's
> an issue I'm missing, but hopefully it could be worked out.
> When possible, having a single arch independent
> implementation is almost always better than separate
> implementations for each architecture.
> 
> One issue: The arch independent approach I've proposed
> wouldn't backport very well. If a backport is important, it
> might have to be the arm64 specific implementation that
> you have in this version of the patch. Then supersede it
> with the arch independent version for simplicity going
> forward.
> 
> > 
> > Fixes: 9d7cf2c96758 ("Drivers: hv: Add arch independent default functions for some Hyper-V handlers")
> 
> I'm not clear on how this commit is related to fixing/adding
> the kexec support on arm64.
> 
> Michael
>

Thanks, Michael.

I initially kept the implementation ARM64-specific to avoid changing
the existing x86 shutdown path. Using the common syscore callback would
require moving the x86 VMBus teardown out of hv_machine_shutdown(),
including changing the established ordering where
hv_stimer_global_cleanup() runs before VMBus UNLOAD.

Commit be0cfab740e5 ("clocksource: hyper-v: Remove support for stimer
interrupts in message mode") has since removed that dependency. With
this ordering constraint gone, the architecture-independent
implementation is now the cleaner approach, and I will rework the patch
accordingly.

For stable backports to kernels that still support message-mode
stimers, I will prepare an ARM64-specific adaptation that preserves the
existing x86 ordering.

Regarding the Fixes tag, I used 9d7cf2c96758 because it introduced the
weak no-op handlers used by ARM64. However, I agree that it made no
functional change and did not introduce the failure. I will change the
tag to:

Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")

Thanks,
Shradha
 
> > Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@linux.microsoft.com/
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
> >  Changes in V2
> >  * Use syscore_ops.shutdown instead of a bare function pointer hook in
> >    machine_shutdown(), per Catalin's suggestion.
> > ---
> >  arch/arm64/hyperv/mshyperv.c | 40 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> > index 4fdc26ade1d7..e608e546a395 100644
> > --- a/arch/arm64/hyperv/mshyperv.c
> > +++ b/arch/arm64/hyperv/mshyperv.c
> > @@ -15,10 +15,50 @@
> >  #include <linux/errno.h>
> >  #include <linux/version.h>
> >  #include <linux/cpuhotplug.h>
> > +#include <linux/kexec.h>
> > +#include <linux/syscore_ops.h>
> >  #include <asm/mshyperv.h>
> > 
> >  static bool hyperv_initialized;
> > 
> > +/*
> > + * Kexec handler registered by VMBus.
> > + *
> > + * On ARM64, machine_shutdown() does not provide a platform hook between
> > + * device_shutdown() and smp_shutdown_nonboot_cpus(), unlike the
> > + * machine_ops.shutdown mechanism used on x86.  Use a syscore_ops shutdown
> > + * callback instead: syscore_shutdown() runs after device_shutdown() and
> > + * before CPUs are taken offline, which is the same window VMBus needs to
> > + * run its UNLOAD message and cpuhp_remove_state() during kexec.
> > + */
> > +static void (*hv_kexec_handler_fn)(void);
> > +
> > +static void hv_kexec_syscore_shutdown(void *data)
> > +{
> > +	if (kexec_in_progress && hv_kexec_handler_fn)
> > +		hv_kexec_handler_fn();
> > +}
> > +
> > +static const struct syscore_ops hv_kexec_syscore_ops = {
> > +	.shutdown	= hv_kexec_syscore_shutdown,
> > +};
> > +
> > +static struct syscore hv_kexec_syscore = {
> > +	.ops		= &hv_kexec_syscore_ops,
> > +};
> > +
> > +void hv_setup_kexec_handler(void (*handler)(void))
> > +{
> > +	hv_kexec_handler_fn = handler;
> > +	register_syscore(&hv_kexec_syscore);
> > +}
> > +
> > +void hv_remove_kexec_handler(void)
> > +{
> > +	unregister_syscore(&hv_kexec_syscore);
> > +	hv_kexec_handler_fn = NULL;
> > +}
> > +
> >  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> >  {
> >  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> > --
> > 2.43.0
> > 
