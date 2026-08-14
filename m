Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8B36920F;
	Fri, 14 Aug 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700272; cv=none; b=C5jod5ptGDwQ3bUIzpjEZzmeCP1ZWCl2Ti8EHJD+83DCM/P+Xte8Lt34Wcn6K37ZnvC+gVDCcEwYip/vNr3lszxq1fEjV15d/F5Y67qxYRj8nOE402ZvnLBnNam4yA0M52GvrSVck17QbTUEdQ8vpV5qqyPDL+Kmyxb8eqLDKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700272; c=relaxed/simple;
	bh=t7+7Umd0u3vXNbOTNBXduVQSErIY3/fVSWRtPFdzg3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7LGaRm0erJxWL02ju0OPYYQgj+DW/wQxAkfSpCxgC0FlqZDZrJYx7WyuCqGuqNi+EpJwpk67fAaTeILI+bwCgw6H8w9WRzu2Nb02I8bVbVJJBZjOR/RYnsvU+6WnHsYeZasj+KoRsXG6CUsOW3xGvTM/Xr/ZTPTxBCNiwYSqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KWuUIhE3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KWuUIhE3"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id CEB0E20B7168;
	Fri, 14 Aug 2026 02:37:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CEB0E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786700245;
	bh=mrPCGSCOgcbImYUmKSq1aUBNJApcEPF4LurAYoGhmf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWuUIhE3DnstjtweJwewzpdkTUXMkgfRQJ84/am0XAvdc1bRgttwo3dQumixnhhVp
	 iJTevsRrtVBzs8CF3ZyVxBXdrc+FI3SrfDADGUoXaJ+7PmtfEbslpeSaJZqvSucFcE
	 AkEZHctKNkynpFkJWvYSTzMGrvv8RntZD56M65vo=
Date: Fri, 14 Aug 2026 17:37:48 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, 
	mhklinux@outlook.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, 
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813224627.GA933791@ziepe.ca>

On Thu, Aug 13, 2026 at 07:46:27PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 13, 2026 at 03:29:13PM -0700, Jacob Pan wrote:
> 
> > > +static int hv_iommu_blocking_attach_dev(struct iommu_domain *domain,
> > > +					struct device *dev,
> > > +					struct iommu_domain *old)
> > > +{
> > > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > > +	struct hv_iommu_domain *hv_domain =
> > > to_hv_iommu_domain(domain);
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	int ret;
> > > +
> > > +	if (pdev->ats_enabled)
> > > +		pci_disable_ats(pdev);
> > > +
> > > +	if (vdev->hv_domain == hv_domain)
> > > +		return 0;
> > It may not be needed since the core code will check this. If you keep
> > this as extra precaution, should this be moved up before ats? since ats
> > must be disabled already if blocking domain is attached.

@Jacob In v2 (https://lore.kernel.org/all/20260706095510.00007ce1@linux.microsoft.com/), 
this check was in the common attach helper. It was redundant because the normal
group domain path already skips same-domain attaches.
                                                                                                                                                        
In this version, I removed it from the common helper and kept it only in the 
blocking attach callback. iommu_deinit_device() directly attaches the
device to release_domain without going through the group-level check.
IIUC, for a device which is alreading parked in the blocking domain, the
releasing might invoke another blocking-domain attach.
                                                                                                                                                        
Sorry, I should have explained this change and its rationale in the changelog.

> 
> Why check it at all? Is there an issue with attaching the same thing
> twice? Will it blip the DMA or something?

Actually, I do not think there should be any issue with attaching twice.
Hyper-V *should* be able to accept such attachment. But I do not want to
make such assumption just for a redundant hypercall.

Does this reasoning make sense, or would you prefer that I remove the
check?

B.R.
Yu

> 
> Jason
> 
