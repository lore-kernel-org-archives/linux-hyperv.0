Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567629;
	b=dihVvKbNY7wF90QnkiyYL0SBlpvVwS+oNsd0k9zFLKAHe45Uc13osHOGr8JVxhBoBWXM
	 rIJc35I8DJDDH5hSCPPHdWr3zIuDEvCJGyR46Iq7SqLMKk0l2SgqIndaUrX27vnahZicy
	 kpbMYNGie/FLG4r4SVPQgRaH1XvZ6pwHaN9kDwi6XUUMcNsB8eIXMCC+w0kpFTHqJwYfL
	 O7n+W7uhDM+s3C970hI5Ok2M2/cHXwyiM4QGdiBgYX5E/mKTA+NjinF7gg/OCmkP069+i
	 Qoo3Qu8OwbYWF9xEZ8kXCHEich96vv59zNIJ0N/nNzniSYkMxaXTbsiaz814RfO8NQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Yaahl2NjM7LYJ3/VUSQG13ODgqUJA5kkV/j2CsiAkwA=;
	b=XYGu2YJSc2wbHEN2A1c96ecnSijursf/xb6KXJE+er174i/zqJP8kNF5zZThSvlkpG7f
	 XOhKQYCDx+i8dxX32JFhODzN5pp628miDMU9zyneTe23LMUF1LG8x5MszxNZcPGbjPrbv
	 Wi4CoByi5nGj2PbGabFdKZNGh80pRHDUMaNAzxpFsDEHF9VdRnRE6KNZzRmGMLmcmZ6pC
	 FPZbfHjDS0mXoMzDuIGqvAfCzygIJrohjRh9T76FZqYH2C+pj2bLlwNyd+3RR04lhIhWM
	 NWxqyGlgHuzpKsniGg83QtyB7FKmtvX9YdZC0Cn7Qt+Sj77Fp19tvu7kQ9uGgpOvXWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUEsZ5IW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206A606A319;
	Wed, 21 Oct 2026 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUEsZ5IW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F48F1F000CA;
	Wed, 21 Oct 2026 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792567628;
	bh=Yaahl2NjM7LYJ3/VUSQG13ODgqUJA5kkV/j2CsiAkwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bUEsZ5IW9a3Szer7bK9RTRwykZPLZWByrbcqBn+bd0n7lP4ZRRuV5OQXQGjOwoy8E
	 BIYtLTNMkx8NTeMmbPOBJnWZRjkwca+gcJ1h0haQ7prOXdpniffU9ztJAo/CPtxhcl
	 iAVVU1n60X+gDOtLmaGmW3wQAAiu05os2br3vplaE3SNIZ922wcZXuJMf6DQ8CAFou
	 4JhAjGFaXE3LG+yhA2TCRhXT5gy9PB4rmZ4KRLa9JQTUL87C5Ox7r7ojsB9kcdE568
	 EYPrtBF/A2MmJ6LvO0xUa19vYnNWp1tseqSuVUhflIGb996+bdy1xHcA3NUPK49+zR
	 CV67lqrjbae+Q==
Date: Wed, 21 Oct 2026 00:27:07 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: mhklinux@outlook.com, wei.liu@kernel.org, catalin.marinas@arm.com,
	baoquan.he@linux.dev, will@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, arnd@arndb.de, hpa@zytor.com, maz@kernel.org,
	mark.rutland@arm.com, linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	broonie@kernel.org, kees@kernel.org, brads@mainlining.org,
	namjain@linux.microsoft.com
Subject: Re: [PATCH v4 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
Message-ID: <20261021072707.GH851443@liuwe-devbox-debian-v2.local>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>

On Fri, Oct 09, 2026 at 03:22:11AM -0700, Shradha Gupta wrote:
> Kexec reboot fails on ARM64 Hyper-V guests because the VMBus connection
> and SynIC CPU hotplug state are not torn down before the secondary CPUs
> are stopped. Move this cleanup into the VMBus syscore shutdown callback,
> which runs after device shutdown and before architecture-specific machine
> shutdown.
> 
> Patch 1 adds an exported helper for checking whether a normal kexec reboot
> is in progress. Patch 2 runs the VMBus cleanup from the common syscore
> shutdown path on x86 and ARM64, removes the old x86 handler interface, and
> documents the shutdown ordering.
> 
> On x86, VMBus teardown now precedes hv_stimer_global_cleanup(). This relies
> on commit be0cfab740e5 ("clocksource: hyper-v: Remove support for stimer
> interrupts in message mode"). Older kernels that retain message-mode
> stimer interrupts need an ARM64-specific backport to preserve the existing
> x86 ordering.
> 
> Changes in v4:
>   - Document the VMBus kexec cleanup path in the Hyper-V overview.
>   - Combine adjacent kexec_in_progress checks in the x86 shutdown path.
> 
> Changes in v3:
>   - Use the existing common VMBus syscore operations on all
>     architectures, as suggested by Michael.
>   - Remove the x86 handler pointer and the weak setup/remove interface.
>   - Add an exported read-only helper for modular VMBus builds.
>   - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
> 
> Changes in v2:
>   - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
>     suggested by Catalin.
> 
> Shradha Gupta (2):
>   kexec: Add helper to report an active kexec reboot
>   Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
> 
>  Documentation/virt/hyperv/overview.rst | 12 +++++++-----
>  arch/x86/kernel/cpu/mshyperv.c         | 27 ++++++---------------------
>  drivers/hv/hv_common.c                 | 10 ----------
>  drivers/hv/vmbus_drv.c                 | 22 ++++++++++++++--------
>  include/asm-generic/mshyperv.h         |  2 --
>  include/linux/kexec.h                  |  2 ++
>  kernel/kexec_core.c                    |  7 +++++++
>  7 files changed, 36 insertions(+), 46 deletions(-)

Applied. Thanks.

Wei
