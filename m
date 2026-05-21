Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1534DB46;
	Thu, 21 May 2026 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366449; cv=none; b=LuQSUZEBe2miMCFPmQSlFBzIVln7kYv9mqp3lCssTQozMSh7uvC0lqZvVpyPrffyMYZ/2CpPOvPDpEL5RRAAg8vuYUCt0pDx5lQ2tIBHSJoJAmC/HZS3ru01KBxuhdyYlkZghp+OZRfzFPrcP+MJCFyfOyrcfUq3KsjG3Kue0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366449; c=relaxed/simple;
	bh=PWU04bunZm1A4HdILcV+WysOonr1OjamaaGZ4P5EzKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaFQpQB2jb4wO6mpxwHFl3d565HdFa3y+nzK0X3TjjnVFN59Et44z1/yh9zSnTpMah+Cryab20ZDqrQ1n+Qhq9BamuO1zs55OnjQnxTi/ze2NPZippJ81qKUGt8R9vjC++F76HVTwcJz2d0T7kkV0YY1QSdyupK4dhPAe6X3Goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fMpy0Ou4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fMpy0Ou4"
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7074C20B7167;
	Thu, 21 May 2026 05:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7074C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779366431;
	bh=wmq8YLgsy2FAYrGPSihacYpLDE0RS/hdAF1EZzYlLgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMpy0Ou4eEEKrSZNTNiGX4PwDVVFxbvCOvsPUpxBo+V7B7Y3UYNXGJjRzBt3Dwm6w
	 Pt5lxUdggodkASVyZfO9NXgNHQY8BIQkc40eHFOLY1ZGt2MSQP4wF6+HpC7KGazpwh
	 fWa4d+MON6e6HPMW3uneD0XxDFWst47S8BjERN8E=
Date: Thu, 21 May 2026 20:27:16 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, 
	mhklinux@outlook.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <2k5pmxd7ml2p2dizujktj5zh4pyvzv4yjet2ekczilukt2avqm@w6puynixrf6t>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <20260515223139.GK7702@ziepe.ca>
 <yqhb6vxoovscvfafgv6i6zn7uydpfxeff7hqmvbn6z7c2tjqp6@jn2vvtxqgfef>
 <20260520112708.00003640@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520112708.00003640@linux.microsoft.com>

On Wed, May 20, 2026 at 11:27:08AM -0700, Jacob Pan wrote:
> Hi Yu,
> 
> On Wed, 20 May 2026 23:25:43 +0800
> Yu Zhang <zhangyu1@linux.microsoft.com> wrote:
> 
> > > > +static const struct iommu_domain_ops
> > > > hv_iommu_identity_domain_ops = {
> > > > +	.attach_dev	= hv_iommu_attach_dev,
> > > > +};
> > > > +
> > > > +static const struct iommu_domain_ops
> > > > hv_iommu_blocking_domain_ops = {
> > > > +	.attach_dev	= hv_iommu_attach_dev,
> > > > +};  
> > > 
> > > Usually I would expect these to have their own attach
> > > functions. blocking in particular must have an attach op that cannot
> > > fail. It is used to recover the device back to a known translation
> > > in case of cascading other errors.
> > >   
> > 
> > For blocking domain, the hypercall handler of such attach essentially
> > disable the translation and IOPF for the device.
> I think this should disable all faults, including unrecoverable fault
> reporting. right?

Yes, it should (e.g., my understanding is it shall set the FPD in scalable
mode context entry). Will double confirm with hypervisor team and make
sure it behaves so.

B.R.
Yu
