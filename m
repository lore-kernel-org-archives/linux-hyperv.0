Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8B1A724C;
	Tue, 18 Aug 2026 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787091298; cv=none; b=lJfZmctQadOpeXH2LdxX0qZMQrEaqh4dO6G/pDG6mI1aAWgKaR7+AUdBJYvJ14pXxy0h3TshcTroz9GF6bZjtMfCWhd3a3eVyx5/02n16vaYRyBJLM7DkAnMU0CzQqo8o+oGVHf0h/smy7Fing2ZHvw8LoWjl77/mgHBlBce5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787091298; c=relaxed/simple;
	bh=UU1xbgx05wud8KkMtPg6MGrENfz2EC+HJ0p53EulM6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=skFw0BeuxSTooQvDc6bgsOdqiF5RlHqngXvROibEDii+nQ8eK6z202mb7qWdH+/AKmW0HISAyql2I5jVUkG6jPa/LZft2gJjNGuHP5wb6pSQ87b1yg7nYDJ+Zo5teeWG5vJAS71LqTh6Ec5EG3IeSrgmihx6uy8m1GGMomC9ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeXgByjc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeXgByjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4D71F000E9;
	Tue, 18 Aug 2026 22:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787091297;
	bh=4GDQ1OI3IWc2/dYpF/3louVOMJ5MXEF2dzhihO5cFOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=SeXgByjcYevqIvBmCsVKwS5/E8E7NQin1wdgCCn7fVV8y0fvgXTVmclY3QJA464L/
	 eWc245iLDuccqYxoOA4RbKAhVjibCAgxHhka3AylJdVrIkri8TK6VK9oDZ6Byc7LBI
	 ejjvkYsSuXo3fDwhgWY//6PirM3rRWu9eGDLVTKyJPxAQSc0KzC/gBN9tNkyrMyfJE
	 LNdBrwNmg6LHY9jxURqm9EtTsJDh6tDyrpZ0ovS+Iaktquegq96TcIgBMjJaWZxsaY
	 KjCCByGG1MhddbqJy2Sk0WToXsuQH8Lz+KC6xY333ppcPXs2FN/i9HMzt3Y0+XrDxR
	 HqqTr5vJP8apA==
Date: Tue, 18 Aug 2026 17:14:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	jgg@nvidia.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, joro@8bytes.org, will@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	arnd@arndb.de, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 6/9] PCI: hv: Export hv_build_devid_type_pci() and
 change return type
Message-ID: <20260818221455.GA743465@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731223427.2554388-7-mrathor@linux.microsoft.com>

On Fri, Jul 31, 2026 at 03:34:24PM -0700, Mukesh R wrote:
> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device ID as a parameter. This device ID refers
> to that specific device during the lifetime of passthru. So,
> make hv_build_devid_type_pci() public and change return type to u64 to
> enforce it's size.

s/it's/its/

This patch doesn't have anything to do with the PCI core specifically,
so the "PCI: hv:" subject line looks a little funny and doesn't look
anything like previous history of these two files.

> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 9 +++++----
>  arch/x86/include/asm/mshyperv.h | 6 ++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index b3ad50a874dc..8780573a4332 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -112,7 +112,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
>  	return 0;
>  }
>  
> -static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
> +u64 hv_build_devid_type_pci(struct pci_dev *pdev)
>  {
>  	int pos;
>  	union hv_device_id hv_devid;
> @@ -172,8 +172,9 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
>  	}
>  
>  out:
> -	return hv_devid;
> +	return hv_devid.as_uint64;
>  }
> +EXPORT_SYMBOL_GPL(hv_build_devid_type_pci);
>  
>  /*
>   * hv_map_msi_interrupt() - Map the MSI IRQ in the hypervisor.
> @@ -196,7 +197,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
>  
>  	msidesc = irq_data_get_msi_desc(data);
>  	pdev = msi_desc_to_pci_dev(msidesc);
> -	hv_devid = hv_build_devid_type_pci(pdev);
> +	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
>  	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
>  
>  	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
> @@ -271,7 +272,7 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>  {
>  	union hv_device_id hv_devid;
>  
> -	hv_devid = hv_build_devid_type_pci(pdev);
> +	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
>  	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
>  }
>  
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index f64393e853ee..8ebbd1cb7c8c 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -248,6 +248,12 @@ void hv_crash_asm_end(void);
>  static inline void hv_root_crash_init(void) {}
>  #endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
>  
> +#ifdef CONFIG_PCI_MSI
> +u64 hv_build_devid_type_pci(struct pci_dev *pdev);
> +#else
> +static inline u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return 0; }
> +#endif
> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> -- 
> 2.51.2.vfs.0.1
> 
