Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223229;
	b=eB+slqj8ctYucpgBGd2eIBzkg0XW5pG780WQzzMjmAfwRetA+KeF2viNHIjQ0wESeKJu
	 At28tcQFXRGklkIG0Oqpogh3d9ncUSjpMYeEu5UzASIc6onQQfhtt6AMCIrqcK9sUDBb7
	 xTKulyrV6VoKa9RIYQkoz/rrB1lY+iGE3n3HMPk0sDwMdbq9xX2RBJYc79yl20X73h6Zq
	 5BCGE+K/r6lNhk9ZVkm+RpQd0wjTvWV69h51+gRr4n0pr6bM/2H1IeAxCD0Y+z9Z9/fuQ
	 NuElZeWLdOzp59dNmW4zTTpnPvdeYVWMmSPZ9HR9R7ktIoPJ+nlkQLMMg4wnAbYcwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uRbvTYGHLE/dSalAhrR1hJSynJ2eHI0LzzHZL/10yZo=;
	b=UwMPmbsfYE5D/15kCQxbOODsZtw3Io6hHPi1Amr/TSeY+YdGIqfws60c39KWv8d9k5o4
	 V7ZTtfTizfQCdImKIPUCRq92KbiaitJgHolsbLtpSSYop1RAHP7uGO4h+34VO9PQLRUlh
	 h6Dk0lB5Uh/C7a84hstPtSjbGC5/GWEOpc2RVMvwfiRNylrUhB5GHc4f9LdXFTerqHj2V
	 5Z7zfRsj+BN6AdCt11uaR3jV0lP9T6zDro60vvy8HajS7VxXjxTQLU39xLfjsyzQdk4py
	 L3ljQjcO6RUVzjz/eR4f7pskCC5dSMXOvY/0YgeIKruM8OiZGRA3x0aVaXEL7u+HZQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LN+7Xyts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C94606A6BB;
	Sat, 21 Nov 2026 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LN+7Xyts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B6F1F000C6;
	Sat, 21 Nov 2026 01:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795223229;
	bh=uRbvTYGHLE/dSalAhrR1hJSynJ2eHI0LzzHZL/10yZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LN+7XytsqPs5YF9E9mIPKktv5Gsp1VQ/w4jEbFo5vT2u5BKEyqjRyUqoRT5Nwolq4
	 22by5rzHW0eHEBArf/qXzbjMAzXm9+SMOpY3BX8vpfcJ+8afSf2FEG4/f+nbp+/ZRO
	 68K1I1fQenkijo8Fswmmi/4ZjGCNGJke2gScCoR7QBbZTNTgvHjhLTc3rKj0c1FfqX
	 UTRlaA6BjtCIifzWkxXNuMyjVLjrF/nUkDgiT6MTRCoiiGQAQBb/PHJ1aP+qIuoyW3
	 7qFrHDkVDpVFY3egBfLOSHiksLdfXHaG/THUnKOaXkCK3JKG0LoWz71q4DCSXQkpiW
	 1cVy6Rw3zd+NQ==
Date: Fri, 20 Nov 2026 19:07:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Message-ID: <20261121010708.GA929035@bhelgaas>
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
In-Reply-To: <20261111234439.4098-1-pavel.e.popov@intel.com>

On Wed, Nov 11, 2026 at 04:44:36PM -0700, Pavel Popov wrote:
> VMware and Hyper-V expose passthrough devices to guest VMs without an
> explicit host bridge device. Consequently, host_bridge_whitelist()
> cannot automatically identify the underlying host bridge structure,
> causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
> device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
> P2PDMA on Intel hosts, this series extends cpu_supports_p2pdma(), which
> so far covers AMD Zen and newer, with an explicit list of Intel Xeon
> server generations.
> 
> Patch 1 adds a generic <asm/cpu_device_id.h>, so that generic code can
> include it without #ifdef CONFIG_X86.
> Patch 2 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma(); this
> is the v4 1/2 patch, unchanged.
> Patch 3 is the v4 2/2 patch with Logan's Reviewed-by carried over; the
> only change is in the includes.
> 
> Arnd, if 1/3 looks OK to you, could it go through the PCI tree
> together with 2/3 and 3/3?
> 
> The other users of <asm/cpu_device_id.h> and <asm/intel-family.h>
> under #ifdef CONFIG_X86 (ACPI, cpufreq, i915, amdgpu, tpm, ccp,
> platform/x86) are converted in a follow-up series on top of this one.
> 
> Based on mainline (7.4-rc2+). Built with x86_64 and arm64
> allmodconfig, each patch separately.
> 
> Changes in v5:
> - Add 1/3, a generic <asm/cpu_device_id.h>, so the include no longer
>   needs #ifdef CONFIG_X86 (Leon Romanovsky)
> - Drop the <asm/intel-family.h> include, <asm/cpu_device_id.h>
>   includes it on x86
> 
> Changes in v4:
> - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
>   (Logan Gunthorpe, Leon Romanovsky)
> - Keep the #ifdef around the asm/ includes, as these headers exist
>   only on x86 (Bjorn Helgaas)
> 
> Changes in v3:
> - Drop the hypervisor check and move the Xeon list into
>   cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
>   Gunthorpe and Leon Romanovsky [1]
> - Fold the VMware and Hyper-V patches into one, as the check no longer
>   depends on the hypervisor
> 
> Changes in v2:
> - Replace the Skylake-and-newer threshold with an explicit list of Intel
>   Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
>   Gunthorpe)
> - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
>   (Logan Gunthorpe)
> - Rebased on current mainline
> 
> [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
> 
> v4: https://lore.kernel.org/r/20261020173736.81755-1-pavel.e.popov@intel.com
> v3: https://lore.kernel.org/r/20261020151305.65218-1-pavel.e.popov@intel.com
> v2: https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel.com
> v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com
> 
> Pavel Popov (3):
>   asm-generic: Add <asm-generic/cpu_device_id.h>
>   PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
>   PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
> 
>  drivers/pci/p2pdma.c                | 30 +++++++++++++++++++++++++++--
>  include/asm-generic/Kbuild          |  1 +
>  include/asm-generic/cpu_device_id.h |  5 +++++
>  3 files changed, 34 insertions(+), 2 deletions(-)
>  create mode 100644 include/asm-generic/cpu_device_id.h

Applied to pci/p2pdma for v7.5, thanks for the reminder.

There were minor conflicts with Leon's series, but I applied yours
directly on v7.4-rc1 and resolved the conflicts when adding Leon's on
top.
