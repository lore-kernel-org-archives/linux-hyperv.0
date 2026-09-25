Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03604349BD;
	Fri, 25 Sep 2026 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320435; cv=none; b=YMsn0sEXiEyyCfFigHjchZcyIg+xlB35ofIS4Efkj7C6bt5lJrX7i5fDT7zRr9SuUwV4l8UCRS8qGMH7vOCJRog0KGSpQFCavLMcdtpBNs+C7pjvIxI5F9vlJzv+McIO2th4pPTd0lk0PhqQvZSoUoguAW5s4GMgpNKBy6sBrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320435; c=relaxed/simple;
	bh=tbT3diGq1VkOfyS4XNHFEWJBumXbOXhfBdylPNtgoVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyl/FAMwUCJjmUeIft6uISq712TmV/i+Nc3SdutV6JMZHSXi1rmY+rfQelf7Pev8dFNI9jrjg2j47droj3ZGfz/9EXGtbuguWC4LheW9snunOgYGmtQ8L77clgKAYuW/yQEuI8mQyg+lt+sz6+tNr9YiyCCBIcFj5ZL+GoUgnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a000b03c3c046b119f0.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:b03:c3c0:46b1:19f0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5BC181C7759;
	Fri, 25 Sep 2026 09:13:52 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:13:51 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com, 
	jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, 
	robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
Message-ID: <arYcFJYOvKf-A6xt@8bytes.org>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
 <arUkaFhYGxaYwL0L@8bytes.org>
 <329027b5-3110-8362-ccee-080c14ed9b3e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329027b5-3110-8362-ccee-080c14ed9b3e@linux.microsoft.com>

On Thu, Sep 24, 2026 at 05:14:12PM -0700, Mukesh R wrote:
> So, I'm at a bit of loss. I could go back to V0 which did what what you
> suggested above, but it can also leave stale mappings when map hypercall
> succeeds partially and we delete the entire tree node in cleanup (but
> we could add to the tree back whatever succeeded, but that could fail
> also, but then we could unmap whatever was mapped, but that could fail
> also.. see :)...).
> 

The root-problem seems to be that every operation in the step can fail,
inluding the unmap operation. This makes it really hard to maintain a
consistent state. Are there any guarantees Hyper-V gives on the unmap
operation, e.g under which circumstances it can fail? It would really help if
the code could assume that it will never fail, or treat a failure as a hard
error.

If there are no guarantees HV can give, a solution might be to add a
mapping-resize operation to the internal tree (which can not fail) to correctly
update the tree structure on partially successful unmaps.

I still believe that the internal tree structure should be updated before the
HV map operation takes place.

> > > +static int __init hv_iommu_init(void)
> > > +{
> > > +	int rc;
> > > +	struct iommu_device *iommup = &hv_virt_iommu;
> > > +	struct hv_output_get_iommu_capabilities caps;
> > > +
> > > +	if (!hv_is_hyperv_initialized())
> > > +		return -ENODEV;
> > > +
> > > +	rc = hv_iommu_get_caps(&caps);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > 
> > The capabilities returned need more checking. I think at least it needs a check
> > for HV_IOMMU_CAP_PRESENT and that PAGE_SIZE is set in the pgsize_bitmap.
> 
> In general this caps hypercall is not available to root partitions,
> our only agreement is for hyp to provide max_iova_width. But, we check
> HV_DEVICE_DOMAIN_AVAILABLE in hv_iommu_detect() which sorta supersedes
> HV_IOMMU_CAP_PRESENT. As for page size, hyp owns the iommu and can chose
> the page size, meaning it can automatically use larger page size when
> possible. But the hypercall HVCALL_MAP_DEVICE_GPA_PAGES will only take
> 4k pfns as input, hence:
> 
> #define HV_IOMMU_PGSIZES SZ_4K        /* for now, to be enhanced */

Okay, so this deserves a comment in the code to make it clear why there is no
additional checking and what the hyper-v to guest contract for feature
detection is.

> Ok, I can change it back to DMA_BIT_MASK. (I removed after comment
> on V0 that this is not dma address).

An IOVA is a DMA address by definition :)

-Joerg
