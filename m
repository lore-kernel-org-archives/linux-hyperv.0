Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607842DFFB;
	Wed,  8 Jul 2026 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508730; cv=none; b=HJny/xl5WEsBUl8Ae4pn00NfAKSOio6VJGgP+88CERYeSAIE7cIUXi8g4ER2caxqzqtvci0whimrjopQ/0HH9JXzKK0fBnyDDd7zC+DIfVG/mencb5327CET7LlB5OEO3QyPoE0mPSB8Y72Rn0SEsFC8I7bmgEIsp7/26XLq0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508730; c=relaxed/simple;
	bh=7xN3gN/1fufW2zcG5xVQZNt3mgjfLnXivIEcwpleKQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWmvKiHoOidU/2cdbWj8McS+nzuirtUzY7U8COK99x8X7jFVeqyMeL92DjAnUYqDrK24zMIMoJCZO/G4D3sVWx/eHllOMTGZ8OkaEn0n6fo/xVXHJ8HOomWAy0LIMxCYf/zJO0jBW2k8D2R1i4icChad9cbDXx4UeIWSVJvq7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aisOYdqk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aisOYdqk"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id E033920B7166;
	Wed,  8 Jul 2026 04:05:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E033920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783508720;
	bh=NfmX2Gu/X4lDwJwfowtrot5xu5EOiks7e+Fc49sNRR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aisOYdqk1Lm2WQ/Q/WjXnlJHEwO8YMfW/+p3Gn9mVKsA7RbU/6imb7DzVvsV1eLhO
	 I/UgK3F6r0ySTnIKjvc3ruv1/x6HQcTpU4VFId6G2gUYPwgF3Bk/Xm/FEkZ8q3b9OK
	 sd1/3Lxfxbf7IZyVyHufcfpFV6LlzFhqU95uPJAs=
Date: Wed, 8 Jul 2026 19:05:22 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, 
	mhklinux@outlook.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <smr7cmmhvqeuddmoxwyt774qtb5clf6s3vbkfmusrvccav6ey4@cqtqgkeqv5lx>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <1f57d1d9-ccbb-ff4e-9680-d45adc7821ea@linux.microsoft.com>
 <20260707074814.000010a0@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074814.000010a0@linux.microsoft.com>

On Tue, Jul 07, 2026 at 07:48:14AM -0700, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Mon, 6 Jul 2026 17:08:50 -0700
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
> > From: Mukesh R <mrathor@linux.microsoft.com>
> > To: Yu Zhang <zhangyu1@linux.microsoft.com>,
> > linux-kernel@vger.kernel.org,  linux-hyperv@vger.kernel.org,
> > iommu@lists.linux.dev,  linux-pci@vger.kernel.org,
> > linux-arch@vger.kernel.org Cc: wei.liu@kernel.org, kys@microsoft.com,
> > haiyangz@microsoft.com,  decui@microsoft.com, longli@microsoft.com,
> > joro@8bytes.org, will@kernel.org,  robin.murphy@arm.com,
> > bhelgaas@google.com, kwilczynski@kernel.org,  lpieralisi@kernel.org,
> > mani@kernel.org, robh@kernel.org, arnd@arndb.de,  jgg@ziepe.ca,
> > mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
> > tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
> > Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU
> > support  for Hyper-V guest Date: Mon, 6 Jul 2026 17:08:50 -0700
> > User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
> > Thunderbird/91.13.1
> > 
> > On 7/2/26 09:05, Yu Zhang wrote:
> > > Add a para-virtualized IOMMU driver for Linux guests running on
> > > Hyper-V. This driver implements stage-1 IO translation within the
> > > guest OS. It integrates with the Linux IOMMU core, utilizing
> > > Hyper-V hypercalls for:
> > >   - Capability discovery
> > >   - Domain allocation, configuration, and deallocation
> > >   - Device attachment and detachment
> > >   - IOTLB invalidation
> > > 
> > > The driver constructs x86-compatible stage-1 IO page tables in the
> > > guest memory using consolidated IO page table helpers. This allows
> > > the guest to manage stage-1 translations independently of vendor-
> > > specific drivers (like Intel VT-d or AMD IOMMU).
> > > 
> > > Hyper-V consumes this stage-1 IO page table when a device domain is
> > > created and configured, and nests it with the host's stage-2 IO page
> > > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > > operations. For unmapping operations, VM exits to perform the IOTLB
> > > flush are still unavoidable.
> > > 
> > > To identify a device in its hypercall interface, the driver looks
> > > up the logical device ID prefix registered for the device's PCI
> > > domain (see the logical device ID registry in hv_common.c) and
> > > combines it with the PCI function number of the endpoint device.
> > > 
> > > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > Co-developed-by: Easwar Hariharan
> > > <easwar.hariharan@linux.microsoft.com> Signed-off-by: Easwar
> > > Hariharan <easwar.hariharan@linux.microsoft.com> Signed-off-by: Yu
> > > Zhang <zhangyu1@linux.microsoft.com> ---
> > >   arch/x86/hyperv/hv_init.c       |   4 +
> > >   arch/x86/include/asm/mshyperv.h |   4 +
> > >   drivers/iommu/Kconfig           |   1 +
> > >   drivers/iommu/hyperv/Kconfig    |  16 +
> > >   drivers/iommu/hyperv/Makefile   |   1 +
> > >   drivers/iommu/hyperv/iommu.c    | 620
> > > ++++++++++++++++++++++++++++++++ drivers/iommu/hyperv/iommu.h    |
> > > 51 +++ 7 files changed, 697 insertions(+)
> > >   create mode 100644 drivers/iommu/hyperv/Kconfig
> > >   create mode 100644 drivers/iommu/hyperv/iommu.c  
> > 
> > Hey Jacob,
> > 
> > You had suggested I rename iommu.c to iommu-root.c (I called it
> > hv-iommu-root.c eventually), so this needs to be renamed also,
> > right?
> 
> yes, I agree. I feel it is clearer to name it hv-iommu-guest.c since
> this is a guest only driver.
> 

hv-iommu-guest.c sounds good to me. :)

B.R.
Yu
