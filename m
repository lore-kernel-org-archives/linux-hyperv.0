Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61B3911A2;
	Tue,  6 Oct 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278856; cv=none; b=NK2h8lS/6v80KWo/VRY5UrYB0Bza+XDHW7pZomc4vVh+Gl4H9qZDE6VgBDKI+c+euQz0PsF2PKs2ImFoWafcqHVtQoSjsP3OUjM+WaNLhIZpr+VRjYxtxKtFWoScBYMKLVRgYChXjZug0FVSHDf6FgcAplzSg7nCkkR9ieRO2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278856; c=relaxed/simple;
	bh=G3nFgPp0dY4DMkurPGHR7uMaTO7HS6BshA/t/4Xe1Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBYR6xGF5uB5Fw7F/5GJTIuH02sYX4XY0ccgW8cDc+blWD2gyWWU7yZ3GkvCi4RVyrkYa4bz/tYrdzmDan3gdmgYU7QaFGP7oiiye5ES9PqeVed7lESEBni3zhADhuCoFTsyXu4e04JlH9UiHr4TGL4zVNWHY5M82kp4jcklcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TuNXtmZ1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TuNXtmZ1"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 61EE920B7168; Tue,  6 Oct 2026 02:26:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61EE920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791278799;
	bh=0HJbfqojCnyDCq67GdTQKqumiVu32qDFX6wYw2kJYng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuNXtmZ1Fqfzj5XwTvOXRi1jAGQyvOSi23J8GQ1iWAU7FH+zLjWffU5SG6dIeMOL7
	 eYpBG4SAHoh4gBAJnKOKOiRZaL/ENjCVn/fqfFiMAxmlAHsFM2eahcELTmWojgQOKZ
	 Q4F17v1qfpqD7Uy88ym/UbkD9Sisd0dT2PkJo7wA=
Date: Tue, 6 Oct 2026 02:26:39 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Baoquan He <baoquan.he@linux.dev>, Will Deacon <will@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
Message-ID: <asS+z+2H8iNfnHwW@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
 <SN6PR02MB41578FDB019EE76576C612A8D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578FDB019EE76576C612A8D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Oct 01, 2026 at 04:14:22PM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Thursday, October 1, 2026 6:21 AM
> > 
> > Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
> > connection and SynIC CPU hotplug state are not torn down before the
> > secondary CPUs are stopped. The kexec kernel consequently starts with
> > the previous kernel's VMBus state still active.
> > 
> > The previous version added an ARM64-specific syscore shutdown
> > implementation. This version follows Michael Kelley's review and moves
> > the cleanup into the existing architecture-independent VMBus syscore
> > operations. This removes the separate x86 handler dispatch and gives
> > x86 and ARM64 the same ordering:
> > 
> >   device_shutdown()
> >   syscore_shutdown()
> >     VMBus UNLOAD and SynIC CPU hotplug teardown
> >   machine_shutdown()
> > 
> > On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
> > This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
> > Remove support for stimer interrupts in message mode") removed the
> > VMBus dependency from synthetic timer handling.
> > 
> > Patch 1 adds a read-only helper that reports whether a kexec reboot is
> > in progress. The helper is exported because HYPERV_VMBUS is tristate
> > and the common syscore callback must also link when VMBus is a module.
> > Patch 2 moves the cleanup into the common callback and removes the
> > obsolete architecture-specific setup/remove interface.
> > 
> > For stable kernels that still support message-mode stimers, an
> > ARM64-specific backport will be needed to preserve the existing x86
> > ordering.
> > 
> > Changes in v3:
> >   - Use the existing common VMBus syscore operations on all
> >     architectures, as suggested by Michael.
> >   - Remove the x86 handler pointer and the weak setup/remove interface.
> >   - Add an exported read-only helper for modular VMBus builds.
> >   - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
> > 
> > Changes in v2:
> >   - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
> >     suggested by Catalin.
> > 
> > Shradha Gupta (2):
> >   kexec: Add helper to report an active kexec reboot
> >   Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
> > 
> >  arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
> >  drivers/hv/hv_common.c         | 10 ----------
> >  drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
> >  include/asm-generic/mshyperv.h |  2 --
> >  include/linux/kexec.h          |  2 ++
> >  kernel/kexec_core.c            |  7 +++++++
> >  6 files changed, 24 insertions(+), 36 deletions(-)
> > 
> > 
> > base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
> > --
> > 2.43.0
> 
> Nice! Net impact is to remove 12 lines of code, instead of
> adding 40, which is great. And nothing under arch/arm64 is
> modified.
> 
> One minor point: In hv_machine_shutdown(), we have two
> sequential tests of kexec_in_progress. Given that you are
> removing some code under the first test, I think it would be
> fair game to do a very minor refactoring of existing code and
> combine the two tests. It just looks a little funny to have the
> same test twice in a row.
> 
> But regardless of whether you include that change, for
> the series,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thank you Michael, I'll take up the refactoring in a seperate patch.

regards,
Shradha
