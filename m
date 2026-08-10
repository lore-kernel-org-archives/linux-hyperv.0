Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79087439F90;
	Mon, 10 Aug 2026 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388149; cv=none; b=UD1VyCCM3nKtHnuq/VsGkHR0xTkSnA3XRAeHi9n7UjCnGlJKJuMTcySfGZG/1DutbA9OZL4BIBUfr9nKn2AcbGu3T9Vlf10gW/NOwYK54lGGtD8dum3SFsool6xwOpGI0UtgHtknzNJLnTV1ZNJuWBh9Ew1RLh9y4p0gTVYK8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388149; c=relaxed/simple;
	bh=dYcouYbgcszfoZP7xxZHfNu+BNKAGfkYKmm5DvZFUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyj8O7v6iBBeAQOHaWFuyi+BIfwu0lU1QkokrC8xmtCqIJa241M/kzlkLDsJa9BzV2pGLH1P+vmZeVCmfBSbHfdUVdFL8IS9lx4F1cbGQMqVubhfp9j7qFrv9w3wN3gXktlneu6tEBwLj113v4Hb/fmDTEwRHtPD8UPFOWdt8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozQuxWrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozQuxWrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE171F000E9;
	Mon, 10 Aug 2026 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388147;
	bh=aQ75Op3u4ovI2w7uoxlbwZuzzJOOlbqAnY/+5K3a0Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ozQuxWrChfMzyS/tJ9PNoBL+h4h6xocxxhGybly23sRMKgXd03tfcz5bKthgb1k2P
	 mD5XUIJb1BGI0yx0w++wKmnqgMHtiNIPrdosDyaXVxlOnvpIMxtQcpDzy6P0WZZ2iB
	 tB0ysp0YVh0mllXnAF1haSgwScnmqG2VjuqYzyDFAUA1h7PoktU7RBDeogEX18sziM
	 Pa0qYpN5ua4n79UTKl0p6z857kNaSmx3zZ6AKVrer7VU9xZnnS2I0OI4GNHhAO48lB
	 KOOBAE6t021jzxHzRvcnWJ95HawX/PVEWD+6uyfEhGZ5STA3sKvDXuX3fR3PjZY02p
	 kN9fAGKfYlu1A==
Date: Mon, 10 Aug 2026 11:55:45 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	linux-pci@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] PCI: Add controller reset method
Message-ID: <20260810185545.GC2496954@liuwe-devbox-debian-v2.local>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-2-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724230844.3259741-2-wei.liu@kernel.org>

Hi Bjorn,

Since this is adding to the PCI reset framework, this patch needs your
approval.

Please see below for my questions. I'm happy to change the code however
you see fit.

On Fri, Jul 24, 2026 at 04:08:42PM -0700, wei.liu@kernel.org wrote:
> From: Wei Liu <wei.liu@kernel.org>
> 
> Some PCI controllers provide a function reset mechanism that is not
> advertised in PCI configuration space. Allow them to expose it through an
> optional pci_ops callback.
> 
> Add the controller reset method to the standard reset_method interface.
> Prefer FLR and AF FLR by default, and use the controller operation before
> PM and bus reset fallbacks.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/pci.c   | 22 ++++++++++++++++++++++
>  include/linux/pci.h |  3 ++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..4e55da202cad 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4962,6 +4962,27 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return rc;
>  }
>  
> +static int pci_controller_reset(struct pci_dev *dev, bool probe)
> +{
> +	int rc;
> +
> +	if (!dev->bus->ops->reset)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return dev->bus->ops->reset(dev, probe);
> +
> +	rc = pci_dev_reset_iommu_prepare(dev);
> +	if (rc) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = dev->bus->ops->reset(dev, probe);
> +	pci_dev_reset_iommu_done(dev);
> +	return rc;
> +}
> +

The first question is whether modelling this on the controller level
is the correct approach.

Please refer to the second patch for the intended usage in the Hyper-V
vPCI code.

Whatever is added here, a new reset_method value will be added to the
table. I chose "controller" to reflect the decision above.


>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *bridge;
> @@ -5094,6 +5115,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_dev_acpi_reset, .name = "acpi" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
> +	{ pci_controller_reset, .name = "controller" },

The second question is whether this ordering is okay.

Thanks,
Wei

>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..d7759ee70670 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -52,7 +52,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> @@ -875,6 +875,7 @@ struct pci_ops {
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> +	int (*reset)(struct pci_dev *dev, bool probe);
>  };
>  
>  /*
> -- 
> 2.53.0
> 
