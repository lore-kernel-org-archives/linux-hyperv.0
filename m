Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BBF47F2ED;
	Fri, 25 Sep 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333729; cv=none; b=VUFN1167UITzHDwIFqh2FvnH6wIoPI+J2Jw+UmymZ5elZAcLguqhETZqpDj9rT1vUUp4wQw7apH0YSQ5h803sDdm0zs9qsVFANmDrob/zCaMGmu0wtvU5cCE4kX5/k/Zch0irhoE0IED1mY18Esi58CjMC+3rFFSc5xLCJIsFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333729; c=relaxed/simple;
	bh=YxCqPPfU4FQGEeCj9SaF4yu2dTKU6srsQ9ZCzJ3MIjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXNLrhGnK9oGPlllO24sImJTrmW0SoVowXI2qAFExei/KMgkCw/8v3UURHp5awJShTSE/vKP3a/CS+0MC4hkCyg7pla8SkUBkSXAnqHOnyNSlpuzCcZvcdAoZ/mLgs0RigGn8eWRxAKw/OVvrZ06Iql5ejdi1uBtgKnH1lAF2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TBY94IAU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TBY94IAU"
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DE03E20B7167; Fri, 25 Sep 2026 03:54:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE03E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790333674;
	bh=TvEPGOfbgk6GAAitdg40W0kx1ikkHQeD6VX4NT0U9cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBY94IAUfCDpClpxzxKhpb9QROdJLRr+DhKGenzz7MpzJd3UNj7yHGq0yh0QHAeC4
	 E6koLuWaEpulGcS0dREtqRbv1hfMmh2IYVGiOCYQQ6Mys2zmwWB3yPg4LkTsZejpqi
	 nK1SJU30/cFmjJKSVsaqLq92BY7Cuw/Jf/8920II=
Date: Fri, 25 Sep 2026 03:54:34 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Michael Kelley <mikelley@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, namjain@linux.microsoft.com
Subject: Re: [PATCH v2] arm64: hyperv: run VMBus kexec handler via syscore
 shutdown
Message-ID: <arZS6km9V29CnYw9@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260907092544.230338-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907092544.230338-1-shradhagupta@linux.microsoft.com>

On Mon, Sep 07, 2026 at 02:25:42AM -0700, Shradha Gupta wrote:
> On ARM64, machine_shutdown() does not provide a platform hook between
> device_shutdown() and smp_shutdown_nonboot_cpus(), unlike x86's
> machine_ops.shutdown. This prevents the Hyper-V VMBus kexec handler
> from running at the correct point during kexec shutdown, causing
> kexec reboot to fail on ARM64 Hyper-V guests.
> 
> Use syscore_ops.shutdown instead: syscore_shutdown() runs in the same
> window (after device_shutdown(), before CPUs are taken offline) where
> VMBus UNLOAD and cpuhp_remove_state() must execute.
> 
> Provide ARM64-specific overrides of hv_setup_kexec_handler() and
> hv_remove_kexec_handler() that register/unregister a syscore_ops
> shutdown callback, replacing the __weak no-op stubs in hv_common.c.
> On x86, the existing machine_ops.shutdown mechanism is unchanged.
> 
> Fixes: 9d7cf2c96758 ("Drivers: hv: Add arch independent default functions for some Hyper-V handlers")
> Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@linux.microsoft.com/
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  Changes in V2
>  * Use syscore_ops.shutdown instead of a bare function pointer hook in
>    machine_shutdown(), per Catalin's suggestion.
> ---
>  arch/arm64/hyperv/mshyperv.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d7..e608e546a395 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -15,10 +15,50 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/kexec.h>
> +#include <linux/syscore_ops.h>
>  #include <asm/mshyperv.h>
>  
>  static bool hyperv_initialized;
>  
> +/*
> + * Kexec handler registered by VMBus.
> + *
> + * On ARM64, machine_shutdown() does not provide a platform hook between
> + * device_shutdown() and smp_shutdown_nonboot_cpus(), unlike the
> + * machine_ops.shutdown mechanism used on x86.  Use a syscore_ops shutdown
> + * callback instead: syscore_shutdown() runs after device_shutdown() and
> + * before CPUs are taken offline, which is the same window VMBus needs to
> + * run its UNLOAD message and cpuhp_remove_state() during kexec.
> + */
> +static void (*hv_kexec_handler_fn)(void);
> +
> +static void hv_kexec_syscore_shutdown(void *data)
> +{
> +	if (kexec_in_progress && hv_kexec_handler_fn)
> +		hv_kexec_handler_fn();
> +}
> +
> +static const struct syscore_ops hv_kexec_syscore_ops = {
> +	.shutdown	= hv_kexec_syscore_shutdown,
> +};
> +
> +static struct syscore hv_kexec_syscore = {
> +	.ops		= &hv_kexec_syscore_ops,
> +};
> +
> +void hv_setup_kexec_handler(void (*handler)(void))
> +{
> +	hv_kexec_handler_fn = handler;
> +	register_syscore(&hv_kexec_syscore);
> +}
> +
> +void hv_remove_kexec_handler(void)
> +{
> +	unregister_syscore(&hv_kexec_syscore);
> +	hv_kexec_handler_fn = NULL;
> +}
> +
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  {
>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> -- 
> 2.43.0
>

LGTM. This patch is important for Hyper-V kexec support.
As discussed in the RFC, the approach used here is also in agreement
with the ARM maintainer.

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
