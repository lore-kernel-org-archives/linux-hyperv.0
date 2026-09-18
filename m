Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4B4915B4;
	Fri, 18 Sep 2026 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714135; cv=none; b=epJW/BJtN8NDQwTd9mT6A9Qf1KGXVkuNPwm1Ng/5VUE2I+M6IYZJbK7F2gjVJF8oaySaziqwCvA2C5Geu5P/Hq+znyF9utUHL0I8iMIggTbuKDeLKBaKgySulj0M3SLXPhtk1n+DmleuIrS5hR5L805VSW08inXXAZP9YXQtztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714135; c=relaxed/simple;
	bh=scOg0zkY929U7MefX1SWenzzv/DGXcB5ud9XJmcHH+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AycpeCoPV6zApOZqmMSedrSTqux/Q3c7SrVEFu2d8ZGG1LWzS6Fd1J+mS5kUPPrP1+nSkU5/FI0eoGjXnCrBRB/HIR+Hqq1Nzf3j5K/9r7c9vCxew2a3mMkQIiXXeY8SFE/iHKzo9/zs3E/B8ElqKFGJytbL1okkFo861RzLOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lTE5wuVi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lTE5wuVi"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id A9B9420B7166; Thu, 17 Sep 2026 23:47:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9B9420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789714074;
	bh=5t9cgIT5f9rP+bBZj+k2OohF1bEsiI+o9JoKpM8YBmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTE5wuViE5zsPSQWG4RRydfhk85bXsmJErXz0umjjbR5/VO1bnR8U+it7k8TayikU
	 vZ/mNjtzJcRBnQwSoKeqBCWc8kh4W4DOCi9QnypUMZa3yMiqqmNfuZDSUlGHxwqwOj
	 cmVOZzZADm26KnVYNsRaIbzx2A9Z1XyPKUSPj4Ro=
Date: Thu, 17 Sep 2026 23:47:54 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Michael Kelley <mikelley@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, namjain@linux.microsoft.com
Subject: Re: [PATCH v2] arm64: hyperv: run VMBus kexec handler via syscore
 shutdown
Message-ID: <aqzempJPsZ41cOsk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

Gentle reminder.

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
