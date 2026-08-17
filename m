Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79D3B71D9;
	Mon, 17 Aug 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982477; cv=none; b=keaJx66u/duXgZ2VRAaSgkgBZk3GRAuGd2EREUSiZVG21BfWKJKDQH6c7/F1YZfFWFzXEZmjOx3+UNdbrynd5JYRXFwUSoJKxZ2GzhpVG8MsVNHxECZnWxquUVehVISCjEvPMNbscq/kMwSnYVmMyJ8RPZc/FBTil5q9mASYH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982477; c=relaxed/simple;
	bh=GiLIMTpBtBKYBCft6avqROJsEJhCo357+zSQa6yP/LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCaNtsQuKta9pf1UqtxxdiPgNPpWxIjd8Kci9Tg1V7bvEPGegIoHgv1p+57aVTnJvRNtBXrnULBGbGhSeCioXW7agwSEHx0qQorQoew9Upav3I/hNPKsmlYt73NysVJsWtVe0SDs8oLCIE1XuhIbV/GUQsGF80wDwRrMbOr0CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=reIH3eNu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="reIH3eNu"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id C63FC20B7167;
	Mon, 17 Aug 2026 09:00:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C63FC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786982448;
	bh=uA1WRPV/GEjXMADTzG5bqvvpEE4dgFC0L0ozuNODXMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reIH3eNuC+YOWJg2xpIB/HCzgeflB3AaMCZmPYcWiOOHFPxzqyzG85J/DCNUqW8d/
	 JKQR2jg+BfPQW1Ad0mkiJ8K/D9MxOcbRwCXPaOR34eOGjOlbT+u8SsQBW5bZsBdZET
	 B1ad+97KlA3xRfiuzua0Ns0uvXZulcKoZbZPYQnQ=
Date: Tue, 18 Aug 2026 00:01:13 +0800
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
Message-ID: <gk7lcfk73uzntmnmf7eb5clp2h7q7oqb7lykj2qlrrkilotfvx@mf6wima2kibk>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
 <20260817122216.GD933791@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817122216.GD933791@ziepe.ca>

On Mon, Aug 17, 2026 at 09:22:16AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 14, 2026 at 05:37:48PM +0800, Yu Zhang wrote:
> > > Why check it at all? Is there an issue with attaching the same thing
> > > twice? Will it blip the DMA or something?
> > 
> > Actually, I do not think there should be any issue with attaching twice.
> > Hyper-V *should* be able to accept such attachment. But I do not want to
> > make such assumption just for a redundant hypercall.
> > 
> > Does this reasoning make sense, or would you prefer that I remove the
> > check?
> 
> I would probably drop it. Having blocking always set blocking to the
> HW regardless of what the SW tracking state says feels more robust to
> me.
> 

Got it. Will drop the check and make sure each blocking request
reasserts the blocking state in Hyper-V at HW level.

B.R.
Yu

> Jason
> 
