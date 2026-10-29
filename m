Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309664;
	b=VCpRy9FUW3W0C7suqx4OEIclvf16dY13MEcZUEVqHSZLhkf1MwmdTfw1UoLolQtX/iC4
	 rEsRPq0xhqMAs/NLsY3z3+JXSwWLpr9VdV+M+IZcSuC/z7l0vK14fXH6XiQuQv40w+squ
	 qaZ64I1CLl7LRk1Y1GFklh9BG95zDrG+zWAliCU5Co8tnaazqebki37AWhN7paGgZvaue
	 vjR2pucbsOX0CHvJq9tKLAC7vd5+H1dgr33FGVDxwxA1jIo3znBLtZdkCm23sIizmk/FP
	 YRGE6Ky6eH3PJmdQV5ScMHHxk8uaqzA1yNBoS/3HD/eDe2vFrpYH8OA105vYtmTUvTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309664;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vsTgvTJ67UmXZNnV62IYb7BaAYlbsR7gCdAiI5k6ouI=;
	b=3qbFo05R8jN8SY27oBIgmUMLG8h9ZmtuTbuIh1u4Qh1Tg1sYH9laOgo91Yf+9AikGSNf
	 vQJkIoRoL9q+XJHi0AELuGgHOKzSwuvzg1tns5VNk9tVzLrSqccW6EJa+VbO0oCeDgfrn
	 Ln8+u60g4A9gw+53RrzLt5bNus8lywowT/qDSCgNG6/0lCp5k4iMasomfVuQevdndG/UC
	 UK31HWZ/gr64q8xSu8wVMSBIlVA8F1tdNPBbyis8/ChnbsN8n2G6as705gjsTLsSEJQTp
	 mtrPT+FFjYK8h1V66vfHGcpbYrK4sQDGEiSe9SX+Gq4lKaKtA4ESBvaxrUJFaBoRr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rzKAgOP2;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A05606A31A;
	Thu, 29 Oct 2026 21:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rzKAgOP2
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 7774320B7166; Thu, 29 Oct 2026 14:34:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7774320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793309646;
	bh=vsTgvTJ67UmXZNnV62IYb7BaAYlbsR7gCdAiI5k6ouI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzKAgOP2FOkAwxZEUfZYjZPjAEnIHtrWND4Oli8t+mGeEtpAThpOf+ogdeif4bBMW
	 qkOlIHJ42ZjllZreQPUIoknfukvcFfD0YZNRKWsp2QCruCud1JOjb/HaaTpEJQxt7l
	 3T5nTRckT7elrDuand5sHNL1B3a9RztdeKx7W2V8=
Date: Thu, 29 Oct 2026 17:34:06 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: use reset_root_port() for bus reset of devices
 on a root bus
Message-ID: <auO7zt6EtXiNUZP3@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
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
In-Reply-To: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>

Hi Bjorn,

On Fri, Oct 16, 2026 at 07:59:39PM -0400, Hamza Mahfooz wrote:
> The "bus" reset method resets a device by asserting Secondary Bus Reset
> on its upstream bridge, so it is not available for a device on a root
> bus, which has no upstream bridge.
> 
> Some platforms have no Root Ports and expose PCI devices directly on a
> root bus, e.g., Hyper-V vPCI places each assigned PCI function directly
> on the root bus of a virtual host bridge. Such a device has no reset
> method at all if it supports neither FLR nor PM reset, even if the
> platform is able to reset it.
> 
> pci_host_bridge::reset_root_port() already allows a host bridge to reset
> a device on a root bus in a platform-specific way, so far only in place
> of a Secondary Bus Reset by a Root Port. Use it for the "bus" reset
> method of a device that is the only device on a root bus, and wait for
> the device to become ready afterwards, as is done for other reset
> methods.
> 

Do you have any comments regarding this patch? If not, do you mind if we
take it though the hyperv tree?

> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/pci/pci.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..fd4e958d6b99 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4924,18 +4924,46 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>  
> +static int pci_root_bus_reset(struct pci_dev *dev, bool probe)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	int rc;
> +
> +	/*
> +	 * Bridges, e.g., Root Ports, are not eligible.  Check the header type
> +	 * because dev->subordinate is not set up yet when the reset methods
> +	 * are probed during enumeration.
> +	 */
> +	if (pci_is_bridge(dev) || !host->reset_root_port)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	rc = host->reset_root_port(host, dev);
> +	if (rc)
> +		return rc;
> +
> +	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> +}
> +
>  static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *pdev;
>  
> -	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> -	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>  		return -ENOTTY;
>  
>  	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
>  		if (pdev != dev)
>  			return -ENOTTY;
>  
> +	if (pci_is_root_bus(dev->bus))
> +		return pci_root_bus_reset(dev, probe);
> +
> +	if (!dev->bus->self)
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> -- 
> 2.56.0
