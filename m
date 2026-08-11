Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384531A07F;
	Tue, 11 Aug 2026 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465708; cv=none; b=ifh6FTo5mUHD0H7TvOPFYOdMDmgsqfLRp48sY9U1li9yDiGhb5HGhzlNN3pmvvuOi95a6cCNedVOpGddz5i2NXpwCsEEwhu34cZKWB0UWSynaGVJxCMjg2Kezjy0WV8ZwF3gRAI7mAO+jgCfMzPiPkryBywe+mJnZ4C61Oj8dFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465708; c=relaxed/simple;
	bh=AaYGKVZWkC9qi8grYOpbdOiaKQPvptLGNvFXtFj6VXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPGZIGYyYG0vIFDa5UwPk17ovV/oiW5QzlwojeDd0HmMRmJFsDD7lOxdmUkNyBsF08mAX/2LQLGNFDgx5O4DhcCq2UeHM9uqTXXS78Guo/QP13/F7NHDB5YeB6IpwgxQGfIPVTSKlgbBYcHXhZxjVty9mSG17x1NNr0CxF3duzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3dQJaBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3dQJaBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73631F000E9;
	Tue, 11 Aug 2026 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786465706;
	bh=pdHi2EVn+Umwp6NiHTpkPlmOcYrVhm1MtM/Zej/VHpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3dQJaBburdSccyvwtNmq/Ir35c1N24n/xQLL0mXl5Jkj/8YerX3UG7Cww/Ml4clr
	 R0ZzBeihLh67/3ZINVcoXFPIg43ida8Dgspu7AzrKUo7rO7ATgqMb5q01TYatlhGJZ
	 pBXjRE8L6NLibhYS+UziSnO8AYQTUUY3RQDGWzStR4CMYEDKzLOhKc+CXLj/pwL/S4
	 kQ5mjBCKHqjkA5mndWZxQlDb9q9dsjusOlS5TmgRVLM9Bmk2k0wRoty9GKXOZWjlnP
	 Qu4XCXBTqKuWPH7yJmNwRyVo14OdYKgpe/0thRqV54R0/doe24h4BJHdPrAqDkL0/Y
	 /2weAl3kLDI7A==
Date: Tue, 11 Aug 2026 18:28:19 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] PCI: Add controller reset method
Message-ID: <rlgkynaq654kznkcxfgwi7mv3w2qymq5dieof5zskdq23gaica@o4zcrt2pgxdk>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-2-wei.liu@kernel.org>
 <20260810185545.GC2496954@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810185545.GC2496954@liuwe-devbox-debian-v2.local>

On Mon, Aug 10, 2026 at 11:55:45AM -0700, Wei Liu wrote:
> Hi Bjorn,
> 
> Since this is adding to the PCI reset framework, this patch needs your
> approval.
> 
> Please see below for my questions. I'm happy to change the code however
> you see fit.
> 
> On Fri, Jul 24, 2026 at 04:08:42PM -0700, wei.liu@kernel.org wrote:
> > From: Wei Liu <wei.liu@kernel.org>
> > 
> > Some PCI controllers provide a function reset mechanism that is not
> > advertised in PCI configuration space. Allow them to expose it through an
> > optional pci_ops callback.
> > 
> > Add the controller reset method to the standard reset_method interface.
> > Prefer FLR and AF FLR by default, and use the controller operation before
> > PM and bus reset fallbacks.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  drivers/pci/pci.c   | 22 ++++++++++++++++++++++
> >  include/linux/pci.h |  3 ++-
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 77b17b13ee61..4e55da202cad 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4962,6 +4962,27 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
> >  	return rc;
> >  }
> >  
> > +static int pci_controller_reset(struct pci_dev *dev, bool probe)
> > +{
> > +	int rc;
> > +
> > +	if (!dev->bus->ops->reset)
> > +		return -ENOTTY;
> > +
> > +	if (probe)
> > +		return dev->bus->ops->reset(dev, probe);
> > +
> > +	rc = pci_dev_reset_iommu_prepare(dev);
> > +	if (rc) {
> > +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	rc = dev->bus->ops->reset(dev, probe);
> > +	pci_dev_reset_iommu_done(dev);
> > +	return rc;
> > +}
> > +
> 
> The first question is whether modelling this on the controller level
> is the correct approach.
> 
> Please refer to the second patch for the intended usage in the Hyper-V
> vPCI code.
> 
> Whatever is added here, a new reset_method value will be added to the
> table. I chose "controller" to reflect the decision above.
> 

I recently added a hook for resetting the Root Ports in a platform specific way
[1]. This new hook is called in the SBR reset path. Will it work for you?

- Mani

[1] https://lore.kernel.org/all/20260729-pci-port-reset-v9-2-53570b92064d@oss.qualcomm.com/

-- 
மணிவண்ணன் சதாசிவம்
