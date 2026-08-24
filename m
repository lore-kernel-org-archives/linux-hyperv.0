Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850C32D43C;
	Mon, 24 Aug 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562607; cv=none; b=oMa0UaPt9EmZiEQFRAHEz2kOxApK4o2d65VZujkhW5P87Qb3V/XHO3NIvuWWGyNxX01mI7YQP5KfiA5SEEfcQ9PzO6AnIMVmXSjsrFH4HoOIxy6CvjYvzo/spJicoyv3JfrmUT/eBlK7NyhFkNG4aFryUSmgdwa9YRG/2LIpZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562607; c=relaxed/simple;
	bh=Q6HYv8cYhoF3iYduGTqlOx0GD7cG8Bps3kRxT85X2RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/J8qqQX93xIstiYfwyhn2AbDo99ig59X8i+AYEfAm35jzqPwJ8MeucT9ijxYxrskL70cQYA2S97l84lKrIR7V4aYEnAKnMqvvmwqwytQcZdVv4gtSDFViXhTiTUnr9AcapzhOP9AZ91cFtbWA+SYveC7hsmjIk0H8AhxuLT9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kNJxgyEu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kNJxgyEu"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 424BB20B7167; Mon, 24 Aug 2026 02:09:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 424BB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787562574;
	bh=iliDBqjEx4orC+pbVHq7+cD2NLWm0bEnhWlr15LeCas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNJxgyEuuV+r+D6dEYGvhkwoRyH7nCEtAdiYs6pf+77V8nnT5vUZ/1KTdIIA49BsE
	 RM3HvSocIRSMdYdoEJEj+CEEvg9ACpDO+lu2AFNMgRSqlZQTjXZgcRM+LBZ5RvW/KV
	 J0w7SJbvybh0H3KwGLOYfWQLv7LiPfbsGRhYWWIs=
Date: Mon, 24 Aug 2026 02:09:34 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [RFC PATCH 0/2] arm64/hyperv: Enable kexec reboot support
Message-ID: <aowKTktjAeA9H9/W@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
 <aoglGZD7ntLJkmcO@arm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoglGZD7ntLJkmcO@arm.com>

On Fri, Aug 21, 2026 at 11:14:49AM +0100, Catalin Marinas wrote:
> On Fri, Aug 14, 2026 at 02:31:28AM -0700, Shradha Gupta wrote:
> > Kexec reboot consistently fails on ARM64 Hyper-V guests (Azure VMs).
> > During the kexec shutdown path, VMBus channels are never cleaned up,
> > so in the fresh kexec kernel startup hv_acpi_init() blocks because
> > the hypervisor still holds the old kernel's VMBus session open.
> > 
> > This is because ARM64 lacks the VMBus teardown that x86 performs during
> > kexec via hv_machine_shutdown(). On x86, machine_ops.shutdown is
> > overridden to send CHANNELMSG_UNLOAD and disable SynIC before CPUs
> > go offline. ARM64 has no equivalent mechanism.
> 
> I'm really not keen on such hook, a bare pointer you set elsewhere. Not
> sure it was discussed before but can you not use the syscore_shutdown()
> mechanism? This hook got added in 2023, so the 2022 discussion you
> referenced precedes it.
> 
> -- 
> Catalin

Thanks for the suggestion, Catalin.

I looked into syscore_shutdown() and it should work. The
syscore_shutdown() call in the kexec path runs after
device_shutdown() and before smp_shutdown_nonboot_cpus(),
which is exactly the window where VMBus teardown needs to happen.
It does run before cpu_hotplug_enable() (unlike the x86 path
where hv_kexec_handler runs inside machine_shutdown, after
cpu_hotplug_enable), but that should be safe because
cpuhp_remove_state() acquires cpus_read_lock, which should be
independent of the cpu_hotplug_disabled flag.

The implementation would override hv_setup_kexec_handler() in
arch/arm64/hyperv/mshyperv.c to register a syscore_ops.shutdown
callback, guarded by kexec_in_progress. No ARM64 arch changes needed,
and other shutdown paths (reboot, halt, poweroff, kdump) should also be
unaffected.

I am testing this now and will send a v2 with the updated approach.

Shradha

