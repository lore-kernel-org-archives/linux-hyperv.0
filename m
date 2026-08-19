Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE3D21CC5C;
	Wed, 19 Aug 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156960; cv=none; b=Q934xfeHtc0UOTdHaxyfkJLqQknGx5EmaiwyRCNSTTdVpk8gsE+oPM2S5WDGgNAfbaOmJ8yrLx1YlmVDHZSiYcy7NRAuRST8LXJeOII/OG0CE7SaCZvRYT7z26YAr2YTCrZQh8mTxWZ8CMMhirI8ViwBkR+MaNrQY08VOC76dxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156960; c=relaxed/simple;
	bh=MaL8MHrnbcJRwclMlp/DOE47Ksbyj0+G5LGKPqauCqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Shw8FhKl8vIQSBCaOJ5O58Deltw11I6ZVkdpgrQkCl/Hu+L9tasWI9dAwmH4sIDS1fv2ty1kKAXaFmM4xq1VaLeUlEG5wQi9JBT+CJ7Kn/g6x4WAvT4Y5hEmG6G84dnu4zckv5cB4xdMo+pVyU3Si5muDupr3bMskcsqMJIeFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A0aL91Ne; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A0aL91Ne"
Received: from localhost (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 50C9C20B710C;
	Wed, 19 Aug 2026 09:28:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50C9C20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787156923;
	bh=Wp8qCNcIp1zshkCEqgn/f+gxrufAEnZU1CInd3RaG/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0aL91New+BgTODocDK4EFIJNRIVn0neFVomc6TYURIx9ltPhObV2nAjQYygB23zB
	 bdIHXhN39bA2sl9YygYDZCrf/SBPoVfUjYwUaU/GLf5TPhpUG5QprSnPwiqpN0Ec2d
	 uS2Bdag7kWlLdNNDhq3QfeoRWO76OpBg+xvhvKjk=
Date: Wed, 19 Aug 2026 09:29:09 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, hpa@zytor.com,
 robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260819092909.00003954@linux.microsoft.com>
In-Reply-To: <20260819124652.GA200680@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
	<20260731223427.2554388-8-mrathor@linux.microsoft.com>
	<20260805124838.GP27883@nvidia.com>
	<269d79fa-08ab-55ff-77c7-fb11fa2005d9@linux.microsoft.com>
	<20260818234840.GA134244@nvidia.com>
	<912a5911-5b38-a14f-132f-a2d1d7c8f154@linux.microsoft.com>
	<20260819124652.GA200680@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Wed, 19 Aug 2026 09:46:52 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Aug 18, 2026 at 05:13:29PM -0700, Mukesh R wrote:
> > On 8/18/26 16:48, Jason Gunthorpe wrote:  
> > > On Tue, Aug 18, 2026 at 04:39:32PM -0700, Mukesh R wrote:
> > >   
> > > > Thanks for the review. I know there is another set of patches
> > > > for pvIOMMU ongoing (both came from the same source) and you
> > > > are probably repeating things, and I appreciate your patience.
> > > > I'll also try to look for your comments in that patch series
> > > > going forward.  
> > > 
> > > Those patches look pretty good so you should try to copy their
> > > stuff :)
> > > 
> > > They ended up never calling detach, I hope you can do that too.
> > > Just  
> > 
> > Unfortunately, my case is a bit different due to the "direct attach"
> > feature for guest VMs. When a device moves from say a paging domain
> > to be directly attached to a VM, today, it must first be detached.
> > But since that just moves to identity, I am discussing with hyp
> > team if detach is really required, and if we can get rid of it via
> > just attaching to identity/blocked first before doing the direct
> > attach. Hopefully, it can be done even if changes are needed in the
> > hypervisor.  
> 
> You definately cannot have it blip to identity, that is security
> unacceptable for VFIO.
> 
> Once it is attached to VFIO it must only be blocked or under a
> translation controlled by VFIO. Never something else.
Based on this requirement, I don't see there is a difference between
this root driver and the guest driver in terms of VFIO DMA ownership
transition in the layer above the immediate hypercall site. i.e.

old domain -> blocking domain -> new target domain

Regardless of source or target domain type (e.g. direct attach as
the target domain), the blocking domain must be attached.

If the hypervisor detach operation internally implies transition
through identity, then it needs to be hidden behind the blocking-domain
attach transaction.
