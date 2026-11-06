Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999050;
	b=4wxkxKAe194MRz48F1thw3bvuML+8II3UrLi8hGDbCy0wSEnFz5CIA25ffHngsHI8N7X
	 pu/K+OCN/RE5s6l/VmmqE5jRSzgnwI1BJxPzHxEvKslS+iVibGVtOPgqPZUnXsMPWJZgx
	 7mG63arbnT1ogJpqWomEos3IB271ktKCHL735V+or0LhRBHsJNgxLvc6+EjrVDuaumvPA
	 Vwtxsic6S0FRoClfHXcJ/iPJLJaj91C6Va5VFaBH1M9h0kF8H9l4Jzk20U1wqf9IiXSF/
	 TOflErVfIIFTEyg50fICr0Mk1fonpFU0rzvSCC+ZA6hzq0g+fyHth7E+An5uJ7JUa7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999050;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=q10T67xw+8iwHPcrxFQHCyE49pWYACvlJE98CBh75Ok=;
	b=nqZfWOGs8E0j10lK+CtH8YCYCRJdLNgP80op4Abjr5TJuCNEkHL8KDxkBhgomXUvNUlm
	 cPfW6og3K1FdvtOQg1nvfTTEOFANxNdr3wumNOoexTmGFNtiwhPqLklnG4uxfn2hXs4d8
	 U6XHflGqYms1TmQAHL2myhN7decDy8M37rD/I4yJ0MZzoG2nq7764ibd7oHqrKqfp+unv
	 qSA6ie3b2SXhoyOpK1Cx+5k/Nl+szJkMm9yElplEekQoVkvNFXLh/yOsFC/evJQQeriiz
	 Dp8/kCUPjdhYCaziJqXu9X/n8YELfYvQMwgTxKHpNPvtB2YginOw8MPpD3uNbU226mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qfM2GTQL;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF32606A326;
	Fri,  6 Nov 2026 21:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF32606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qfM2GTQL
Received: from localhost (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id B673820B7168;
	Fri,  6 Nov 2026 13:03:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B673820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793999048;
	bh=q10T67xw+8iwHPcrxFQHCyE49pWYACvlJE98CBh75Ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qfM2GTQLvgztNtvHuXTW0Kx8aOvIWB3gH9MIBtiJv1g8QXKg/f8P+U26jASpu9MGT
	 LElxBHwp7Ag6mmQWwXHUKCnFwI/cMsJbTtPzMeNM1jwdGpj160myGzMdniTyU07dU6
	 f2TPFQ6GXe4Ug/FQc8xWl2Y+i0ykhVRa26qYhmvU=
Date: Fri, 6 Nov 2026 13:03:52 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, Nicolin Chen
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
Message-ID: <20261106130352.0000638d@linux.microsoft.com>
In-Reply-To: <20261104170816.GS3889730@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
	<20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
	<atiakDqtuED2cTM5@google.com>
	<20261026161003.00003b71@linux.microsoft.com>
	<ausIn5Txiy1uRjkY@google.com>
	<20261104170816.GS3889730@ziepe.ca>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

Hi Jason,

On Wed, 4 Nov 2026 13:08:16 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Nov 04, 2026 at 10:27:43AM +0000, Mostafa Saleh wrote:
> > On Mon, Oct 26, 2026 at 04:10:03PM -0700, Jacob Pan wrote:  
> > > Hi Mostafa,
> > > 
> > > On Wed, 21 Oct 2026 10:57:20 +0000
> > > Mostafa Saleh <smostafa@google.com> wrote:
> > >   
> > > > On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:  
> > > > > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that
> > > > > move or attach devices to another VM address space
> > > > > provisioned by an external owner, such as a type 1 hypervisor.
> > > > > 
> > > > > This is not a paging domain and is not sysfs-selectable as a
> > > > > default domain type. It requires external owner context, such
> > > > > as a vIOMMU. 
> > > > 
> > > > Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the
> > > > host never inserts any mapping?  
> > > Right, the host does not own or install any mappings.
> > > 
> > > The external domain type is nevertheless useful for two reasons:
> > > 
> > > 1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen
> > > attach and detach hypercalls 
> > > 2. It allows an externally managed device to leverage the normal
> > > IOMMUFD device-to-HWPT attachment interface:
> > > VFIO_DEVICE_ATTACH_IOMMUFD_PT No new ioctls.
> > > 
> > > It also makes the lifetime and ownership clear for IOMMUFD and
> > > hypervisor, the device can be returned back to host iommufd owned
> > > domains once detached.
> > > 
> > > In pKVM case, my understanding is that you have a emulated root
> > > SMMU which does not do hypercalls obviously. Then the external
> > > attach is done via an "out of tree uAPI through KVM/VFIO bridge
> > > IOCTLs that proxies those hypercalls."
> > > 
> > > Therefore, if we were to park the device in blocking domain while
> > > doing external attach (as you suggested), this requires a new PV
> > > only uAPI that must support pkvm, MSHV, and Xen. So it does not
> > > fit in the flow supported by PV IOMMU root driver.  
> > 
> > I am not sure I understand this, how can the domain type change the
> > uAPI? can you please point to what breaks in the code if a blocking
> > domain was used?  
> 
> Yeah me too.. The plan for the CC side with TDX/RMM is to not have a
> S2 domain in the viommu side at all. It should not be uapi brealing in
> the sense that nothing using mshv viommu exists today.
> 
I am not stating that it will break UAPI because of blocking domain is
used. What I am trying to say is that with the blocking domain ->
external transition, we do not need a new UAPI for external attach for
non-CC. It will just reuse the existing UAPI.
VMM:
	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach,
			"VFIO_DEVICE_ATTACH_IOMMUFD_PT");
hv-iommu-root: external_domain.attach_dev() will do the hypercall.

With blocking domain, this external attachment operation must be under
another UAPI (could well be based vIOMMU/vDevice).

I think it can accommodate both pKVM & MSHV. i.e. move the attach_dev op
out of iommu driver to mshv/pkvm code. I think this goes well with CC
where there is no S2 domain.

For MSHV, the external attach hyper call does not need domain info.
MSHV should have all these info if it is also the viommu/vdevice
provider. This aligns well with Aneesh's patch.

		input->partition_id = partid;
		input->device_id = host_devid;
		input->attdev_flags.logical_id = 1;
		input->logical_devid = vdev_id;
		status = hv_do_hypercall(HVCALL_ATTACH_DEVICE, input, NULL);

> In mshv case the iommu drivers are telling the hypervisor what to do,
> so they have to effectively see a change in translation. But maybe
> this can be managed internally to the driver by annotating the
> blocking domain attachment?
I am not following what the annotation is for? yes, hv-iommu-root
driver can put device in blocking domain, if VMM is to orchestrate the
external assignment, it already knows a device is in blocking domain.

If we let mshv/pkvm to perform direct attach, there must be a in-kernel
agreedment that the device is already in blocking domain. Is this the
annotation for?

This new UAPI also needs to support roll back to normal blocking
and paging domain after external detach.

Thanks,

Jacob
