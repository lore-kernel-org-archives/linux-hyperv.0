Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580147;
	b=RW3S+KCDNHGBCg+tGPBuQsTcBe2t0IVnH+3yC6OM2dU7vgOaIlFDsVOdxBWk32Loukrj
	 avMKhTrGCiCt5tnyVvzae39UCxDq20yWbddMRBepAsD1cm3E4OUOEbgXH5TDfRp0ftY1l
	 7HLj18rWsRXn99wILoP8A9X1VUSYGf53mneeTevvrOo/LrR7xnfTuk8gsH0+Yy3UehOqH
	 Mg5rsf4mfAfb8Nsz+lnmtpq7xu1v/xLr/ekd47sZYlXgEOGIorpJRATvTk6Gw2/TjVB1g
	 Ra6x3bt4CmgL4LrizbC+4fa2d4vB4r4fRSdJAUKOWUfHr6LC1d6d+badgxkvWR/ASrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=v57om+yRBBLGkth/qkaWXe1xFS8Ee5MlrK9nAsKl+LI=;
	b=xYM/o4OMPJMqI8KWq2c6SDdGjUdCdos47b1oees6w5qTaO+RMKUBNyf6MWcnNIv3wLA2
	 t6hmfbTSbaGliq4HMrv5Km2/YbOvJcP1wTQZgutIc6aQu0kPbF4Dbcr/MIdZG49tjoj8R
	 RmmlBtXw/HKumrCIzRj7MqFl4kgVmCJT+ri5tWO213udap0B9Zb1JauQL+JvUpUanKw8K
	 SsaHodHAWGj2+dn2t/S/xCx7MN+jdx0u9DpDsb2Ax+dZ8OI98aI0fmO1iSLAfeUMB2FH9
	 RbdlZ2JPnHKVOxubuNCqI/tKgU1TRpy33OnNM3xm0q7E3LhcBmmsQSzokE+3W30TUcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wVh7yKGD;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCA606A31E
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Oct 2026 10:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DDCA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wVh7yKGD
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a018493d57so67065e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Oct 2026 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792580144; x=1793184944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v57om+yRBBLGkth/qkaWXe1xFS8Ee5MlrK9nAsKl+LI=;
        b=wVh7yKGDj4Vm5Cs6wtcQNoqt8dtcgzboH3trdCcPwiSFqJrsRpZ0/F7Y+FlQch3NrM
         GRsZIUuqdZasUqlo4kOVuOhAWeSw3K8kLfkGbOwe2AGyAglxE1pl1fz6ahWZRlbvYlK9
         czXLBrJihDz0OrHtuwOlWSyQcSWKMoy6+xAQEu+wd3HPMxAyZF7pESlQRGHj60hXNQqw
         YpRPUN3qrYQj3KRxqTppd5cQZOuo+z4OmWSEQkoDQnCS70TAez6UalqBMMh+JcXi9ErF
         s6WkHDDLNn+fayNPkFUsRRDKIdHhils5UjrcmY5O4DqFyFGpvXDVlyV4gNn7tTHT6HO+
         ISzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580144; x=1793184944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v57om+yRBBLGkth/qkaWXe1xFS8Ee5MlrK9nAsKl+LI=;
        b=yDGmJXmTCz/X3CHqptADrerIzJstO/ccZvHpSVO4wSj8/4SagTgIlCGCV2B4UgvpXE
         KTNFFgBxAtFYTIkLm+4cnXCxvy4905NIgLIo06Y5C126hc+i/A3GVOcXciSBvn/uub8g
         Lr56C81KSPd8keCWjGkdNYiyhPuybP532NKQH8hLKmCAe/GBC2LSKV9jwNMqPW0TtmbY
         Vm2zI88zSOb0Bz8u6VXgRgziKGV4Mkr7+qbu0ImTtY+VI9+ygoxERwE1PdQzzcqe20Vb
         r8fmozmlpgx4YwIDTlUyWiYy4iBXLhhPNRL8muPTG2PrRfBa0IxVywViy/V0GRe32RzV
         DTSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwflM7ppE21Fm9uuXDVeroP/khcRTS2aUbQVy+lbMnu5jSwp+EUxV4LAAnc2eYiUO4ThV5LQN6BfCP3Jmc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0MBTd9+RWHTPvr/N9TfubDcDFvdAyQFoxm9kNEYOP9tGCJ1S8
	hMVmLwe8230QGYflqYZSvkTngboodfXAiQ3qXbfPre6rSp/V/sQeAzUZ0wD2w9q9kw==
X-Gm-Gg: AYBFou2Evv0RkNxIEAyAf8oYYEYuaL/6hMVeq2v3cgR2aZ6GXpI9iATaCc3pBr1Y9Hh
	r1UoX3rJHB9kRSGj1TnjmiIBTcN5EPlApBIZ/dovQMwuzCIGgN6xoiQY74r47m+mCF3brQcBh4L
	8NefRQgDiDGcYtoJlVujqhg3TvYEGB9vHYJ+c6LwjNd6xdC9ACqmnkI/tGUXLYfwjXEhxrmRK7l
	fTSp2kRqa0z94VUpxoNv73aUkfqpJNougsWfcwI14oSZljTdrFttLhD8/8y6F1MUNN8yAUdY3Tn
	xkoXHlswW9IUJG6dVVS3nIz13fSwBgZVfwNh68M8p4w6HWsNTSpycoOw5z209BNwvV/JxQhtsHJ
	0HGJ7UP7Iq77aQQB90C66RVNygHw23N40C7oPVVbEEJEoqrco5VEQgn+6mVS1qSzlgLImciy8hx
	AxJ5LqtdjOssJ9REX80Hcm2duIeOCSnfyyDuqXn7Pk7+8hSGUSx92dlE96aXNsJG6w9knBm9KzW
	LVyErCIHQ5upkhV6xvvcfGmkn4+D4pHseYOf8TblMdmpXd7H/iyPDXMtJkit54Mgyg04Lr+fdSw
	bDSZuIvRSbf+RGyydQb9sHQ=
X-Received: by 2002:a05:600d:848e:20b0:4a1:fb0b:1c9c with SMTP id 5b1f17b1804b1-4a1fb0b1f11mr791075e9.10.1792580140669;
        Wed, 21 Oct 2026 03:55:40 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm4668452f8f.52.2026.10.21.03.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:55:39 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:55:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [RFC PATCH 0/9] iommu/iommufd: Add hypervisor external attach
Message-ID: <atiaKG86qcifKzBT@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>

On Fri, Sep 25, 2026 at 12:07:33PM -0700, Jacob Pan wrote:
> Hi,
> 
> This RFC supports guest VM device assignment from a Linux host using the
> Microsoft Hypervisor (MSHV). The goal is that a common set of flows
> and infrastructure can be applied for Xen and other type 1 hypervisors.
> 
> Background:
> 
> The IOMMUFD/VFIO stack used for device assignment has largely evolved around
> the KVM/QEMU model, at least as the first enabling target. In that model, the
> Linux host owns the host-side physical IOMMU programming as well as the
> physical PCI devices.
> 
> Architecturally, MSHV and Xen differ from this KVM/QEMU ownership model.
> At a high level:
> 
>   +------------------+
>   | Guest VM         |
>   | virtual IOMMU    |
>   +--------+---------+
>            | vIOMMU ops
>            v
>   +------------------+    external attach     +------------------+
>   | MSHV             |<-----------------------| Linux host       |
>   +--------+---------+                        +--------+---------+
>            | programs                                  | owns
>            v                                           v
>   +------------------+                        +------------------+
>   | HW IOMMU         |<---------------------->| PCI dev          |
>   +------------------+          DMA           +------------------+
> 
> For MSHV, the specific ownership model is as follows:
>   1. The Linux host OS owns the physical device and exposes it through
>      VFIO/IOMMUFD, but it does not directly own any of the IOMMU hardware.
>   2. The device node (/dev/mshv) owns the VM partition file used by userspace.
>   3. MSHV owns most of the physical IOMMU programming, including stage-2 I/O
>      page tables.
>   4. The Linux MSHV root pvIOMMU driver bridges IOMMUFD/VFIO UAPIs to hardware
>      IOMMU programming through MSHV hypercalls.
>   5. Guest virtual IOMMU emulation is done in MSHV rather than the userspace
>      VMM.
>   6. Stage-2 IOPT may be shared between CPU and IOMMU. It is managed by
>      MSHV and abstracted from the Linux host, including TLB synchronization.
> 
> These structural differences from the KVM/QEMU model create several needs for
> IOMMUFD support:
>   1. Move a device to a guest whose I/O page table is externally managed. This
>      patchset refers to that operation as external attach. Unlike conventional
>      IOMMU vendor drivers, where translation is managed within the driver
>      through paging domains, external attach means that translation is managed
>      outside the driver, such as by the hypervisor.
>   2. Identify the guest-visible device across VMM, host pvIOMMU driver, and
>      hypervisor namespaces.
>   3. Identify the guest partition in the host pvIOMMU driver for device attach
>      hypercalls.
>   4. Tie the device-attachment lifetime to the hypervisor partition.
>   5. Coordinate guest-memory pinning and mapping for DMA between MSHV and the
>      external IOMMU domain attachment.
> 
> External attach has a few caveats compared with KVM/QEMU, where nesting is
> typically handled by the host IOMMU driver in one transaction after the
> userspace VMM uses IOMMUFD to form nested domains:
> 
>   1. MSHV creates a temporal split between host and guest device-domain
>      attach. The host first attaches S2 through a hypercall; later, if virtual
>      IOMMU is present, the guest
>      allocates S1 and establishes nesting with MSHV directly through a pvIOMMU
>      or emulated vIOMMU.
>   2. Guest-memory pinning before mapping is covered by the MSHV/userspace VMM
>      contract, not by the VFIO/IOMMUFD pin-and-map DMA flow.
>   3. Device capabilities such as ATS and PASID need a contract among MSHV, the
>      userspace VMM, and the host pvIOMMU driver. At the time of host external
>      attach, only S2 is attached, so the guest's later ATS/PASID usage is not
>      yet known. For example, whether to expose and enable PASID in the device
>      could depend on whether the userspace VMM creates a guest virtual IOMMU.
> 
> This RFC proposes an IOMMUFD external attach model for those cases. The normal
> Linux-managed paging or nested domain is not the object that ultimately owns
> the translation context. Instead, userspace identifies a VM/domain object,
> binds a physical device to a VM-visible device identity, and asks the host
> pvIOMMU driver to attach the device to an externally managed address space.
> 
> The series makes that relationship explicit in IOMMUFD. The model is anchored
> around a hypervisor vIOMMU object that represents the per-VM partition
> abstraction. It introduces:
> 
>   1. IOMMU_DOMAIN_EXTERNAL for externally managed translation domains.
>   2. IOMMU_VIOMMU_TYPE_HYPERVISOR for the file-backed VM partition.
>   3. IOMMU_HWPT_EXTERNAL for user-visible external type IOMMU domains.
> 
> It reuses the IOMMUFD vDEVICE object to carry the guest-VM-scoped logical
> device ID visible to the hypervisor.
> 

This is very similar to pKVM on arm64 also, where the IOMMU is managed
by the hypervisor, and for device assignment, the host doesn't control
it for the guest, but the hypervisor (in EL2), and there will be a
channel between the guest and pKVM directly after the guest runs. 

The host only sets the virtual to physical topology (how many vIOMMUs,
vSID -> SID mappings) and describes that for the hypervisor through
hypercalls.
In Android, we have an out of tree uAPI through KVM/VFIO bridge
IOCTLs that proxies those hypercalls.

In that case, the host just creates a virtual IOMMU and the guest sees
a paravirtual one which runs with single stage collapsed translation,
although I don't see a difference on the host side if nested translation
was used beyond an argument change to the hypercalls.

My goal is to converge to IOMMUFD and I believe this series is the way
forward, By relying on the vDEVICE virtual toplogy uAPI and the external
attach introduced here.

I will try to prototype something based on that to prove that it
works. However that work has a dependency on the host SMMUv3 support
[1] which needs to land first.

[1] https://lore.kernel.org/all/20261015200903.2735565-1-smostafa@google.com/

Thanks,
Mostafa


> Roughly, the VMM flow is as follows:
>   1. iommufd = open("/dev/iommu")
>   2. vfio_fd = open("/dev/vfio/devices/vfioN")
>   3. dev_id = bind_vfio_device(vfio_fd, iommufd)
>   4. create_mshv_partition(&mshv_fd, &vm_fd)
>      // Creates the guest vIOMMU and configures guest-memory pinning policy.
>   5. alloc_hypervisor_viommu(iommufd, &viommu_id, dev_id, vm_fd)
>      // Uses the hypervisor vIOMMU type.
>   6. alloc_vdevice(iommufd, viommu_id, dev_id, vm_device_id, &vdevice_id)
>   7. alloc_external_hwpt(iommufd, dev_id, viommu_id, &external_hwpt_id)
>   8. attach_external_hwpt(vfio_fd, external_hwpt_id)
> 
> Step 4 may be completed before steps 1-3, but it must precede step 5 because
> the partition file is required to allocate the hypervisor vIOMMU.
> 
> The attach_external_hwpt() operation enters the MSHV root pvIOMMU driver's
> external-HWPT device_attach path:
>   -> resolve partition ID from hypervisor vIOMMU
>   -> resolve logical device ID from vDEVICE
>   -> invoke the partition prepare_attach callback to force pinning if policy
>      requires
>   -> MSHV attach-device hypercall
> 
> Object lifetime:
>   - The hypervisor vIOMMU takes a reference on the MSHV partition file and
>     holds it until the vIOMMU is destroyed. Closing the userspace copy of the
>     partition fd therefore does not destroy the partition while the vIOMMU
>     still exists.
>   - Each vDEVICE and external HWPT holds a reference on its parent vIOMMU.
>     The vIOMMU cannot be destroyed until these child objects are removed.
>   - An attached device holds a reference on the external HWPT, so userspace
>     cannot destroy the HWPT while the device is attached.
>   - Closing the IOMMUFD fd destroys the object graph from the leaves upward.
>     Once the child objects are gone, destroying the vIOMMU drops its partition
>     file reference and allows the MSHV partition to be released.
> 
> Thus, the external-attach lifetime is anchored directly by IOMMUFD object
> references and the partition file. It does not require a separate
> VFIO-hypervisor bridge, such as kvm-vfio: the MSHV root IOMMU driver's detach
> operation directly tears down the hypervisor-visible external-attach state.
> 
> The root pvIOMMU driver changes in this RFC address the following concerns
> received from the older version[1]:
>   1. The target partition comes from the fd-backed hypervisor vIOMMU created
>      by userspace, not from the thread issuing the attach.
>   2. External attach is represented explicitly, avoiding paging-domain hacks.
>   3. Guest memory is pinned exactly once. In the older model, the same memory
>      could be pinned once by /dev/mshv and again by the VFIO DMA map ioctl.
> 
> This RFC builds on the MSHV PCI passthrough/root pvIOMMU base work [2]. The
> mergeable MSHV driver changes should be added on top of a future version of
> that base root pvIOMMU driver.
> 
> Feedback would be especially useful on:
> 
>   1. Whether IOMMU_DOMAIN_EXTERNAL is the right IOMMU core representation
>      for an externally managed translation (Xen, perhaps TSM [4]).
>   2. Whether IOMMU_VIOMMU_TYPE_HYPERVISOR/VDEVICE can be common to MSHV,
>      Xen, and similar type-1 hypervisor flows, and whether it can cover the
>      semantics in CoCo TDISP that would otherwise require tsm_bind() [3].
>   3. Whether a file-backed VM/domain reference is the right way to anchor the
>      external attach lifetime.
>   4. Whether vDEVICE virt_id is the right generic source for the
>      hypervisor-assigned logical device ID.
> 
> At LPC 2026, I will be presenting this work and have open discussions.
> https://lpc.events/event/20/contributions/2520/
> 
> Future work:
> 1. ATS/PASID policy integration with the root pvIOMMU driver.
> ATS/PASID policy is intentionally left as a separate contract issue. I do not
> think the root pvIOMMU driver should blindly enable or disable PASID/ATS on a
> device without knowing the guest configuration or receiving acknowledgment
> from MSHV, which owns the device-TLB flush for S2 changes.
> 
> 2. Live update support
> The current LUO proposal preserves DMA mappings through IOMMUFD-owned state.
> External attach requires a different preservation model because the S2 IOPT
> is managed by MSHV rather than IOMMUFD.
> 
> 3. vDEVICE lifetime during external attachment
> An attached external HWPT does not currently retain the vDEVICE used by MSHV
> to resolve the guest logical device ID. We can either let the core retain
> the vDEVICE identity for external attach, or provide an opt-in mechanism
> to the vendor IOMMU drivers as needed. I am not sure if all type 1 hypervisors
> require a vDEVICE identity.
> 
> 4. Revokable dma-buf support for P2PDMA
> Now that MSHV, instead of IOMMUFD, manages the S2 IOPT, we need to reconsider
> how revokable dma-bufs are handled. Perhaps MSHV can be the importer of
> revokable dma-bufs for P2PDMA and unmap them when the dma-buf is revoked.
> 
> [1] https://lore.kernel.org/linux-iommu/20260731223427.2554388-1-mrathor@linux.microsoft.com/
> [2] https://lore.kernel.org/all/20260902235609.GG2890729@ziepe.ca/
> [3] https://lore.kernel.org/all/20260921225028.4007330-1-mrathor@linux.microsoft.com/T/#t
> [4] https://lore.kernel.org/linux-iommu/yq5a33uxka2g.fsf@kernel.org/
> 
> Patch groups:
> 
> IOMMUFD core and selftest:
> 
>   1. iommu: Introduce external attach domain type
>   2. iommufd: Introduce hypervisor vIOMMU type
>   3. iommufd: Add external HWPT support
>   4. iommufd/selftest: Add hypervisor external attach backend
> 
> MSHV:
> 
>   5. mshv: Add partition file identity helper
>   6. mshv: Add prepare callback for external device attach
> 
> MSHV root pIOMMU driver:
> 
>   7. iommu/hyperv: Split root IOMMU declarations
>   8. iommu/hyperv: Add fd-backed vIOMMU support
>   9. iommu/hyperv: Add IOMMUFD external domains
> 
> 
> Thanks,
> Jacob
> 
> Jacob Pan (9):
>   iommu: Introduce external attach domain type
>   iommufd: Introduce hypervisor vIOMMU type
>   iommufd: Add external HWPT support
>   iommufd/selftest: Add hypervisor external attach backend
>   mshv: Add partition file identity helper
>   mshv: Add prepare callback for external device attach
>   iommu/hyperv: Split root IOMMU declarations
>   iommu/hyperv: Add fd-backed vIOMMU support
>   iommu/hyperv: Add IOMMUFD external domains
> 
>  drivers/hv/hv_common.c                  |  91 ++++++++++++++++
>  drivers/hv/mshv_regions.c               |   6 ++
>  drivers/hv/mshv_root.h                  |   1 +
>  drivers/hv/mshv_root_main.c             |  71 ++++++++++++-
>  drivers/iommu/amd/iommufd.c             |  10 +-
>  drivers/iommu/hyperv/Makefile           |   2 +-
>  drivers/iommu/hyperv/hv-iommu-iommufd.c | 135 ++++++++++++++++++++++++
>  drivers/iommu/hyperv/hv-iommu-root.c    | 102 ++++++++++++++++--
>  drivers/iommu/hyperv/hv-iommu.h         |  40 +++++++
>  drivers/iommu/iommu.c                   |   2 +
>  drivers/iommu/iommufd/device.c          |   9 +-
>  drivers/iommu/iommufd/hw_pagetable.c    |  88 +++++++++++++--
>  drivers/iommu/iommufd/iommufd_private.h |   7 ++
>  drivers/iommu/iommufd/main.c            |   4 +
>  drivers/iommu/iommufd/selftest.c        | 120 +++++++++++++++++++--
>  drivers/iommu/iommufd/viommu.c          |  37 ++++---
>  include/asm-generic/mshyperv.h          |  42 ++++++++
>  include/linux/iommu.h                   |  17 ++-
>  include/linux/iommufd.h                 |  11 ++
>  include/uapi/linux/iommufd.h            |  42 +++++++-
>  20 files changed, 790 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-iommufd.c
>  create mode 100644 drivers/iommu/hyperv/hv-iommu.h
> 
> -- 
> 2.43.0
> 
> 
