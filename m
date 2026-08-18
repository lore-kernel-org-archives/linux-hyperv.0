Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955F330B32;
	Tue, 18 Aug 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071903; cv=none; b=dO14Oba8JzvNGOVnd3y4/y05SvduP+Wwu1cdE84MP9Zy3yW2ebzLlaIoRzXZc5fub+xEuhrZMjPSbceb/HXArVj0l2Lliys6V7RyGlNwmb6oaY8VY8ZJomFa4+XLOrEtPQkxbLw2IiRO7nGFonfJ2oTJ6DFG2gcv6lTL0tSLUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071903; c=relaxed/simple;
	bh=lFjGbXuhkA8MceO+XNW6SAQeNJyoiER3NXQWxghfdKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmve6UcceOwxJJ6JEr6eTkFxOCurGHBenBXGJMQa6i0sS18P0zUu1myZu+12/idvCKTk/W6zD4H2oFvGvVDhZRoItieNK+eMiUpDTTpHhca8tsQ6PLI+VzK3cQxGPW/Yn5sQGFNjCSG7i4qazzGDSE+MI8wSdE7rE5DaWy4qz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hDNKQvBP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hDNKQvBP"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE32120B7168;
	Tue, 18 Aug 2026 09:51:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE32120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787071873;
	bh=2mZgx5gWgDVlkDtD9tOh15r2h1aKGr5ZdoPzlQnaaGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDNKQvBPny8fKA+Jg9JeUq/O6PTuDCIHjiYutdxQWgXqlRNOsv27jkZwShquF9wfR
	 ZVy8Iwbvz4AoqC+QST4cseVKi/v0m1pnCQDVh7iS6drIG7en2QgLGBBJj9Cv86Gd0n
	 48Tmn4ata8KVMi+vbvYvvg00K+G/+hIR96uDm2Q0=
Date: Wed, 19 Aug 2026 00:51:39 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, mhklinux@outlook.com, 
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com, 
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com, 
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <4cchi7bka5sopnvxyeycmv23scesfgtkg5lnlrq2yqsmwah5qd@5e3qqvsil2t3>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
 <20260817122216.GD933791@ziepe.ca>
 <gk7lcfk73uzntmnmf7eb5clp2h7q7oqb7lykj2qlrrkilotfvx@mf6wima2kibk>
 <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>
 <20260817173552.GA1418894@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817173552.GA1418894@ziepe.ca>

On Mon, Aug 17, 2026 at 02:35:52PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 01:22:03AM +0800, Yu Zhang wrote:
> 
> > So we could
> > - either keep the duplicate check in hv_iommu_blocking_attach_dev();
> > - or add code in our common helper, hv_iommu_attach_dev(), to treat
> >   HV_STATUS_DEVICE_ALREADY_IN_DOMAIN also as successful explicitly. 
> > 
> > And since normal paging-domain attaches do not have this duplicate
> > case, I'd prefer the first choice, to keep current check in
> > hv_iommu_blocking_attach_dev().
> 
> I think everything can technically be re-attached and must not fail,
> you have to handle that possibility everywhere.
> 
> So accepting that code as success seems like it might be needed anyhow?
> 

Thank you, Jason! Then we'll introduce HV_STATUS_DEVICE_ALREADY_IN_DOMAIN,
and treat it as successful in hv_iommu_attach_dev().

B.R.
Yu
> Jason
> 
