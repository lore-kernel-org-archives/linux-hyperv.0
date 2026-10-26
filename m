Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056223;
	b=ncVsrraSqcK7mxIqeSLUThZ6npnRfBZCE6mUj68eur/bbRCAgjx/O0PGTVqIQgt7fL5e
	 BmUciAi6iLVMS+0rRdx/a2R7ZpyCsEt2w3PT7nyx8fiMtEavYlY8yeklTQIbYp9vrF0AJ
	 UgnG2YIn3sIbGRp4V51IfdbPl4EkxAxeVoKWGrJkM6r7VVhhP+7CVvcqGKiRY1iHJK9Mg
	 D1jPFdOqTZuZGdsl0rcpSfQnWAvaNXsTqZeEWD4hpZMzj9FSFwR62S68a5VmzVZ8V5Mv4
	 8NIBjgfv6qvF+P9dtZd0UkZXoKij1Hl1UPeZoqpt9WnhstCZSJVL0uXorDw8AYorT6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056223;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=vAGCvmTxy6ZtJGt5CSWzyoyAFqmQYDKuR0TIL8Beruw=;
	b=Ic5Zac+Wn+x5HM/W/CmpxCtLTt6EUjXismTTTSB/noSaNpYwMuclaDnJrXrtrH4tTOeE
	 63RLOyCgBNEjmPziiD2TUAZuCJJrsWU9h00jjPR3yDjRn4PtlrXjl3vEXUNqpXJSq7Sbv
	 Vpf4jnVH7Gyoj5hP3A930wbh3ervI7o0hD6Lt3XGVSLYMd5rRSjaymELBc83KO2ujim+z
	 NctxOxElOKZD+e6hvmjMNqR9sFNw+iWnB60r+sogSGGMHgvECRDs4N/UyNf4qsLowdtZl
	 GYNjxMQY1HoGG60v9W3ZsG4q0svN1MQBSdIZPEVd7QizXwGNmXR74EVFoZlC8G6DdQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=PVDMz7B0;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33A606A31B;
	Mon, 26 Oct 2026 23:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C33A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=PVDMz7B0
Received: from localhost (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D73620B7166;
	Mon, 26 Oct 2026 16:09:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D73620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793056210;
	bh=vAGCvmTxy6ZtJGt5CSWzyoyAFqmQYDKuR0TIL8Beruw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PVDMz7B0B4a18dyvgGY3eNUXdDo+pa0ROA5K1YlbuS11AmFFTVQ8CFHU/xby58w2M
	 RE/O+ag02r/o5RZXrQ8sy4FjeQV3vJd2zb/5bchD3HDWL0ioOhN0mxdawBGcmmhMoP
	 09eGcAPAWkN6VNvU4g3vuUsiRpefrI4WZamVd3JQ=
Date: Mon, 26 Oct 2026 16:10:03 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Wei Liu
 <wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, linux-hyperv@vger.kernel.org, Joerg Roedel
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K .
 V" <aneesh.kumar@kernel.org>, Mukesh Rathor <mukeshrathor@microsoft.com>,
 John Starks <John.Starks@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, Alex Williamson
 <alex@shazbot.org>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261026161003.00003b71@linux.microsoft.com>
In-Reply-To: <atiakDqtuED2cTM5@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
	<20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
	<atiakDqtuED2cTM5@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mostafa,

On Wed, 21 Oct 2026 10:57:20 +0000
Mostafa Saleh <smostafa@google.com> wrote:

> On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move
> > or attach devices to another VM address space provisioned by an
> > external owner, such as a type 1 hypervisor.
> > 
> > This is not a paging domain and is not sysfs-selectable as a default
> > domain type. It requires external owner context, such as a vIOMMU.
> >   
> 
> Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host
> never inserts any mapping?
Right, the host does not own or install any mappings.

The external domain type is nevertheless useful for two reasons:

1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen attach
and detach hypercalls 
2. It allows an externally managed device to leverage the normal IOMMUFD
device-to-HWPT attachment interface: VFIO_DEVICE_ATTACH_IOMMUFD_PT
No new ioctls.

It also makes the lifetime and ownership clear for IOMMUFD and
hypervisor, the device can be returned back to host iommufd owned
domains once detached.

In pKVM case, my understanding is that you have a emulated root SMMU
which does not do hypercalls obviously. Then the external attach
is done via an "out of tree uAPI through KVM/VFIO bridge IOCTLs that
proxies those hypercalls."

Therefore, if we were to park the device in blocking domain while doing
external attach (as you suggested), this requires a new PV only uAPI
that must support pkvm, MSHV, and Xen. So it does not fit in the flow
supported by PV IOMMU root driver.

I don't have a better solution for both pv and emulated root IOMMU
drivers. Perhaps others do?

> Thanks,
> Mostafa
> 
> > PV IOMMU drivers are expected to use it when moving a device to a
> > guest VM with an already-created S2 IOPT.
> > 
> > Assisted-by: GPT-5.6 Sol
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/iommu/iommu.c | 2 ++
> >  include/linux/iommu.h | 9 +++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index cd1bca7ede9a..d0bd3ef00379 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -220,6 +220,8 @@ static const char
> > *iommu_domain_type_str(unsigned int t) return "Translated";
> >  	case IOMMU_DOMAIN_PLATFORM:
> >  		return "Platform";
> > +	case IOMMU_DOMAIN_EXTERNAL:
> > +		return "External";
> >  	default:
> >  		return "Unknown";
> >  	}
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index ac43b8b93f14..ede77b90f0fd 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -188,6 +188,7 @@ enum iommu_domain_cookie_type {
> >  
> >  #define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed
> > address space nested on a stage-2 translation        */
> > +#define __IOMMU_DOMAIN_EXTERNAL	(1U << 7)  /* Externally
> > managed translation */ 
> >  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
> >  /*
> > @@ -207,6 +208,13 @@ enum iommu_domain_cookie_type {
> >   *				  represented by mm_struct's.
> >   *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers
> > that do their own
> >   *				  dma_api stuff. Do not use in
> > new drivers.
> > + *	IOMMU_DOMAIN_EXTERNAL	- Externally managed domain
> > for moving/attaching
> > + *				  devices to another VM address
> > space
> > + *				  provisioned by the external
> > owner, such as
> > + *				  a type 1 hypervisor. This is
> > not a
> > + *				  sysfs-selectable default
> > domain type; it
> > + *				  requires external owner
> > context such as a
> > + *				  vIOMMU.
> >   */
> >  #define IOMMU_DOMAIN_BLOCKED	(0U)
> >  #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> > @@ -219,6 +227,7 @@ enum iommu_domain_cookie_type {
> >  #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
> >  #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
> >  #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
> > +#define IOMMU_DOMAIN_EXTERNAL	(__IOMMU_DOMAIN_EXTERNAL)
> >  
> >  struct iommu_domain {
> >  	unsigned type;
> > -- 
> > 2.43.0
> > 
> >   

