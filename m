Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C843711C
	for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973309; cv=none; b=a5Xnxkj8cGKfRH0xnnEYCIF4kwCyaCfw5djvFTfKqr9WEriU+rRkis7r+77M+d8rFYCluIo36fA7fN3l68SnU2DS2m5lyuE2h5s4b8t5lebEgiQCgpZl82v/09cy7M+QSU63e3DYxCEe8TJUojzTvBSSni69l1nAq1TDtY28Z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973309; c=relaxed/simple;
	bh=IazxHX+RHUkRnRFbKnOMrt+XO1dpE9zzI6uZpKPk/jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0s9fryBU/t0XtXY+ucTN0fRHk9s4gD0faGCNBSTaAf44cc8X/NbvsaLiTmJn4GfGqRwcxfSSbHBHnSAjJsyOs26fZCvl3ZZONu+SCDksIRIdQtU2tt8tNtbBv/my80lqkVxr34pyX+Ysdq0ewj5jjMFaMII3Puc3N5kkOkAn60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ISEYnvPQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ISEYnvPQ"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8CEDF20B7168; Mon, 17 Aug 2026 06:28:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CEDF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786973280;
	bh=wE/KSNA2IF+wb72w9EHFZN0ZxVCzMKOucJxYMzjjrQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISEYnvPQ6gITISzNVkpr7gWYwGLQxsrv7c/8lKs/KLp8nsLegNeTOgsUzuCu7ta2v
	 XZ8LKKyCIQZHOSiG6EfT1ErRav0A+AITtPlZLr3WJybyDjlbZ8X1Ci3/gUJ4x1SBfI
	 vQQ+tzHNjO0SLnoMvi3iWHEit1+nLwF4yYztRx+A=
Date: Mon, 17 Aug 2026 06:28:00 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] arm64: Add pre-shutdown hook to
 machine_shutdown()
Message-ID: <aoMMYJiH/oA2avUv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
 <20260814093154.3191311-1-shradhagupta@linux.microsoft.com>
 <20260814093857.1DD1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814093857.1DD1C1F000E9@smtp.kernel.org>

On Fri, Aug 14, 2026 at 09:38:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly introduced global function pointer `arm64_pre_smp_shutdown_hook` is placed in writable memory without the `__ro_after_init` annotation, creating a potential target for control-flow hijacking.
> --
> 
> --- Patch [1]: [RFC PATCH 1/2] arm64: Add pre-shutdown hook to machine_shutdown() ---
> commit 438763f14354dbd91b5fa7bea807c334ada0c642
> Author: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> arm64: Add pre-shutdown hook to machine_shutdown()
> 
> This patch introduces a global function pointer invoked from
> machine_shutdown() to allow platform-specific cleanup before secondary CPUs
> go offline during kexec or reboot.
> 
> [ ... ]
> 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 581f80e9b9b73..41c0e98409138 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -88,8 +88,21 @@ void __noreturn arch_cpu_idle_dead(void)
> 
> [ ... ]
> 
> > +/*
> > + * Hook for platform code to perform cleanup after device_shutdown()
> > + * but before secondary CPUs are offlined. This runs in the kexec path
> > + * from kernel_kexec() after device_shutdown() and cpu_hotplug_enable()
> > + * have been called, matching the point at which x86 invokes
> > + * machine_ops.shutdown.
> > + */
> > +void (*arm64_pre_smp_shutdown_hook)(void);
> 
> [Severity: Medium]
> Should this global function pointer be annotated with __ro_after_init?
> 
> Without it, the pointer resides in writable memory, which could make it a
> reliable target for control-flow hijacking if an arbitrary memory write
> primitive is obtained elsewhere. Since the hook is presumably only set once
> during platform initialization, making it read-only after init would improve
> defense-in-depth on the shutdown/reboot path.
>

The pointer is assigned when the VMBus kexec handler is registered and
cleared when it is removed, so it cannot be __ro_after_init.

In v1 though, I will use WRITE_ONCE() when publishing/clearing the
callback
and READ_ONCE() before invoking it, preventing compiler refetching of
the pointer.

Regards,
Shradha
 
> > +
> >  void machine_shutdown(void)
> >  {
> > +	if (arm64_pre_smp_shutdown_hook)
> > +		arm64_pre_smp_shutdown_hook();
> > +
> >  	smp_shutdown_nonboot_cpus(reboot_cpu);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260814093133.3191250-1-shradhagupta@linux.microsoft.com?part=1
