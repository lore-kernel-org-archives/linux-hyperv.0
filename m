Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C2439F86;
	Mon,  7 Sep 2026 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770509; cv=none; b=e3Sb+iKNn2caUv2K62eJ2cDc4iDd449jhNDqYyRReCcqeUum7joDlK7q+hgDuRDzp2/2jbWgY9PubhpoMWxRzOzvx7WGYVWtzm9lr6JO10GS8BH43JeQnXjnKE3xQXKm7p6W0fuhX6+fsYe8zJV85+1mErpNdv4acwSc6Xubb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770509; c=relaxed/simple;
	bh=E/UIgNpc25GUSWm1XbC00DjUtLL27lOf+DtKpkc4ypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvxwddi8yo8hZLnzoMiF+3z2bO1H1fxGEvjPSQU4VsZthSnhf/+K2xeoSqvCznR1yMMEzas/0sBoOVjKgQMeHheAa2LAF09OMFt0R45qpxDogK5Nudg43Z6iX5xgbPjrHn+Fb+Dm6uYqpqOEmzn44nCoX2EIzk1DfR2Z+sNIwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MLP/nXtF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MLP/nXtF"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3129620B710C;
	Mon,  7 Sep 2026 01:41:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3129620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788770468;
	bh=yR7782cSE2dRsdzPrK2mP3H/FNlWtg/vkjWXAGyEDv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLP/nXtFx6zptvpPxsuQkjgkNMf9ZbnuxXGcMf0KttNVVB8AegKCpYdovLm9pw/Z6
	 nyopZuhkxGgJvCKTEYsIA2pqY5smdVh+kjIQK9ttwBD79+iw/V4ZKve/bD4uD2q2MM
	 RO9lo9DzJfwMbQWy3Mj1BmrxLk6Sl3SW/dX8TX88=
Date: Mon, 7 Sep 2026 16:41:44 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, 
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com, 
	vasant.hegde@amd.com
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <re2lmz757bvtzbkylxtsj7zu2pjqz7ro752tcg7bpjaicuj6ml@mgsg6jnvgbyd>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
 <af047ef8-91ef-7786-c230-25e28b1c8c04@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af047ef8-91ef-7786-c230-25e28b1c8c04@linux.microsoft.com>

<snip>

> > +{
> > +	u64 status;
> > +	u32 prefix;
> > +	unsigned long flags;
> > +	int ret;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct hv_input_get_logical_device_property *input;
> > +	struct hv_output_get_logical_device_property *output;
> > +
> > +	ret = hv_pci_lookup_dev_id(pci_domain_nr(pdev->bus), &prefix);
> > +	if (ret)
> > +		return ret;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = (struct hv_output_get_logical_device_property *)(input + 1);
> 
> Any reason for not using pcpu output arg like we do in all other places?
> If there is a technical reason, please document it, otherwise when revisited
> in future for re-design, anyone looking at this will be confused and
> waste time investigating if there is anything different about this hypercall.
> 
> 

Thank you, Mukesh. I had also incorrectly assumed that output required
a separate page, which is why the RFC included a separate output-page
allocation patch. Michael clarified during that review [1] that input
and output can share a page as long as their buffers do not overlap,
so I dropped that patch latter.

Actually, there's nothing specific to this hypercall here - it follows
the existing usage. E.g., hv_pci_read_mmio() already uses such arrangement,
as Michael noted in [2]. pvIOMMU queries fit within the existing per-CPU
page, with output placed after input, avoiding an unnecessary allocation. 
                                                                         
[1] https://lore.kernel.org/all/SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/SN6PR02MB4157BF936EBDA23AD1EC5183D480A@SN6PR02MB4157.namprd02.prod.outlook.com/
                                                                                                               
B.R.                                                                                                           
Yu 
