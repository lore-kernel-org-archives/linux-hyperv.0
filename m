Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A53D3CEB;
	Mon, 17 Aug 2026 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987327; cv=none; b=oyGN0ocw3Tu7JdQIgs0WJlj3zr+gYRxqQUol4JH0USRggRrc7a5TpbvG832KAZlj22ttHZZs7MqCcGBRrAXr6v/b/synQIGXPt29FeQynkEkBktf0b9svmMNnWRruuaPqWyYK2tGxzX77cQ9ffDvfyY5MTLLTKSaf5xbdAs5hvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987327; c=relaxed/simple;
	bh=OJPpTSdJqWOKgNagl6Dk/V3KKSlf4x/lWf9u9G3QZbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnYMu4b97kXiwGKxoKRO4WehN17f/LkUCvgSM5u1hGvYAebSyL+B3JcYHJUNcF9nkPZZ4p+X8e1ds0qOyGtt2AuQzWAnwW94NoSa809vhXFUBgBhRz/zSvF6267ll32Nen42tpPoxwBemeaz4BBBRqkUagobBe1P+D3KbrW7ZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n3wD5QV6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n3wD5QV6"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85C1020B7167;
	Mon, 17 Aug 2026 10:21:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85C1020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786987298;
	bh=kb+fCUuYkcAeP7z/mo5+CWCOZs+ciuXANBGXdR+ZaZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3wD5QV6F0jhg/dKE1pvfKZ2jYpM/TNECiRSQ76BAsTbUfVKvFYoJDMq24by32Vp7
	 M3uzpX7An/q5ZOSpStSa/kwL/8gJtpvT8xFB9ahnNa9gAXKYofTxQNQ/biwepPTG4z
	 OeE/nxjHbPOngk+F+2jXOhjr9AQix6M8DVdi8PJM=
Date: Tue, 18 Aug 2026 01:22:03 +0800
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
Message-ID: <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
 <20260817122216.GD933791@ziepe.ca>
 <gk7lcfk73uzntmnmf7eb5clp2h7q7oqb7lykj2qlrrkilotfvx@mf6wima2kibk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gk7lcfk73uzntmnmf7eb5clp2h7q7oqb7lykj2qlrrkilotfvx@mf6wima2kibk>

On Tue, Aug 18, 2026 at 12:01:13AM +0800, Yu Zhang wrote:
> On Mon, Aug 17, 2026 at 09:22:16AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 14, 2026 at 05:37:48PM +0800, Yu Zhang wrote:
> > > > Why check it at all? Is there an issue with attaching the same thing
> > > > twice? Will it blip the DMA or something?
> > > 
> > > Actually, I do not think there should be any issue with attaching twice.
> > > Hyper-V *should* be able to accept such attachment. But I do not want to
> > > make such assumption just for a redundant hypercall.
> > > 
> > > Does this reasoning make sense, or would you prefer that I remove the
> > > check?
> > 
> > I would probably drop it. Having blocking always set blocking to the
> > HW regardless of what the SW tracking state says feels more robust to
> > me.
> > 
> 
> Got it. Will drop the check and make sure each blocking request
> reasserts the blocking state in Hyper-V at HW level.
> 


Sorry, Jason - I replied too quickly. :(

Latest confirmation from Hyper-V team about the existing behavior is
that, a repeated attach of the same device to the same domain returns
HV_STATUS_DEVICE_ALREADY_IN_DOMAIN. This is established behavior, and
other guest OS is already following such contract. 
                                                                                                                                                        
So we could
- either keep the duplicate check in hv_iommu_blocking_attach_dev();
- or add code in our common helper, hv_iommu_attach_dev(), to treat
  HV_STATUS_DEVICE_ALREADY_IN_DOMAIN also as successful explicitly. 

And since normal paging-domain attaches do not have this duplicate
case, I'd prefer the first choice, to keep current check in
hv_iommu_blocking_attach_dev().

@Jacob @Jason Is this choice acceptible for you?
                                                                                                                                                        
B.R.
Yu

> B.R.
> Yu
> 
> > Jason
> > 
> 
