Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7E53ECF7;
	Thu, 15 Oct 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078519; cv=none; b=LnzvsZQE5e2jJowCfXn2dZL6HAekuHXI1/14e5QH3qibyDOTGwqieyVJhQBw3uN1bbXUFn+gxWB4HpgXDoJIMNtgVxxkdU0/rXdcinkL6Ow9FVzNUHwuwPvRlCtwcLdTbRmzZgHGSK/2+a6f3TJM0mzvOowDTTnNqVBd9cz8G4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078519; c=relaxed/simple;
	bh=aRv5lp/2W6G64TtRKpcOOro7Y5+YvO7ASgp7/tcHRQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/ase5nWBSS8dyE4gcQ14WuuLDQmzsl4Hd1ldw/3PFEhhxz96jsPkymx3oOfKToFHUXyyunPw8IKXUQMmM7BWFjIH3ULAIOF+K2mBjx2FKQvvpE701W7VOFR++Zkeepb5QxYyWD6LtlK6/hyrEYrEgv+1JyufbNnICy0uBoZAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mVGA2nNe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mVGA2nNe"
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 5F69B20B7166; Thu, 15 Oct 2026 08:35:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F69B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792078503;
	bh=dNgC2fFe8I25KQ/wSozZG2LGP7y+X3JFgFWpP03891s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVGA2nNevaEowW9MzZEDHeumderKWg5yN3HNuE/TLnnJM8fwtV+RQQty218X8UmwN
	 PFH2+STPY7Co0nqXLNqAnIASPatKs6JxvxqtTktVcd+kzFU9iLqzcagHg8/SRYiVsy
	 nMVuKIR5hewZgC9KDFnGZJdXb1vBMoUD62QFW6ig=
Date: Thu, 15 Oct 2026 08:35:03 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in
 pcibios_root_bridge_prepare()
Message-ID: <atDyp8zWELnsyLE+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260929181056.4746-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929181056.4746-1-mhklinux@outlook.com>

On Tue, Sep 29, 2026 at 11:10:56AM -0700, Michael Kelley wrote:
> pcibios_root_bridge_prepare() currently has code to handle Hyper-V
> guest root bridges with the sysdata parent field set to NULL. While
> this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
> Support root bridge preparation for Hyper-V") was accepted, more
> recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
> device to PCI device") always sets the sysdata parent field to a
> non-NULL value.
> 
> No harm is caused by leaving the special case in place, even
> though it is no longer needed. But in the interest of overall
> code cleanliness, remove it.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This patch does not just do a revert of 7d40c0f70d92 because
> an intervening commit moved the code to a new source code
> file.
> 
>  drivers/pci/pci-acpi.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 42d545edd7fa..452a90317c58 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  		return 0;
>  
>  	cfg = bridge->bus->sysdata;
> -
> -	/*
> -	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
> -	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
> -	 * NULL in this case because there is no proper ACPI device.
> -	 */
> -	if (!cfg->parent)
> -		adev = NULL;
> -	else
> -		adev = to_acpi_device(cfg->parent);
> -
> +	adev = to_acpi_device(cfg->parent);
>  	bus_dev = &bridge->bus->dev;
>  
>  	ACPI_COMPANION_SET(&bridge->dev, adev);
> -- 
> 2.25.1
>

I was trying to find a case where any new driver would have started using the NULL case
but couldn't find any.

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 
