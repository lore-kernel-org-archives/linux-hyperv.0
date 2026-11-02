Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651292;
	b=pdetMhDQhPq4j8fQxgAmaloxN57ztOY9SJeS5ophzRlj07hIU8B3zPEjuK2GBMBizb9N
	 La6ebPLlCo7qG794DbzvZ1ne/kE30hSBuCgGXMKUOON46a0LbO9usa9QRonCO6Ab9aX21
	 USRm9ekL9BjWDfc0pDQ1GoxcykNRTUuiHROWmSGkhtxsEyr/CBJsDwArm6DkL69kQKjQU
	 pdc/mE8iw/+GhB27CLsfBR3yIbZU4fsa2vBEhnwJ07vmyTWnftHK+inyaK2uDL8l/8+Fh
	 CQsBX11JK0WKT9aRwvtSakvGmvJkFD0a+lHBgrM++HuekDq4FsWcm711eYtPY1t3EZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651292;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kNIoXMIj0D6tWi8oDVr/cix9uEHn2FqNesf3emLKmwA=;
	b=Ia7zPYNraX2AvTR5USXKqzJKDiXquKlDjDzZQOL16YsvRRY06wzlF78WZkv9H3B7Ak4e
	 rUSYbzu//WVBN42U7Lin13IN+NFJtN4SMpI2csjgHqwppBZlTokPWceQGq5QAudZJnJG2
	 sTiIk8Jp6nW5lQW8zHPF9f5NKDDOmlVQIh19A2skIAxTc7hESzHGdWSoWpADLGllNbJAk
	 WYIDN/mEX3kPkkAmiA2qotNfcUsyPetU7ahaUTZnxMDtDSd5yCFBz8HYSs4uvf6fRx6mO
	 Z3rEf243ef/UHqdbjYKqtw2JiZ9N0coF1YoK1KKUbMW9mPKl9CNn34vXjj6D1OWzoLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LwqGN/5O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DC606A324;
	Mon,  2 Nov 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwqGN/5O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C281C1F00A16;
	Mon,  2 Nov 2026 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651292;
	bh=kNIoXMIj0D6tWi8oDVr/cix9uEHn2FqNesf3emLKmwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LwqGN/5ONoTdHIJf0oGXsaCmTm0ZoJmgimhJGGd5YL1IWtV3ZAZCKuENAPVbyXLVO
	 TCk4hvjQoMayINfxHIWSzC/NuClx8w4pfjevEjDJXyyU0KgBLhcq6v9N0NX4MmCad0
	 ZDzrkIXoKeOL4EvcS9i5WHW+hgjC7Ac9b9dSN3jzIYphBX6UmQH9REEROu2Vf3iZTG
	 z4CIr1O0V5uiUy6TH5ZdvB+9mk7kYCZIiQ822FF5FPhRgA+0cICtxrTduFUd1u0FtI
	 kNb+TiH9Pb3/ieVX6hm88QZ1+UMAtyYC9vmlyIaUYY/2tchw31HJ0DJ2HnYRz3EGdR
	 h4g+XLF2we1hg==
Date: Mon, 2 Nov 2026 14:28:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: use reset_root_port() for bus reset of devices
 on a root bus
Message-ID: <20261102202810.GA982665@bhelgaas>
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
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Applied both to pci/reset for v7.5, thanks!

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
> 
