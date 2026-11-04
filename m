Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787810;
	b=kMW+hU59luiExpBKHvtvo8H7fWa8N69oncdxDxc4kRK7fO1iG3VBS45w9z29OtC4PaNz
	 AOKVvsLK+wrA3TsotGV3uAV0cxEydjR2W8xtCNsTbzrWC5L8YpwhjAW1LPJL8p6c7ste3
	 hw3IZYBdv4QUG3//Zb4uhFPHOBrDrU7/UdAoZ2WdrpeoDQ9ncz4o9P9WxKnF0J11k8eta
	 t35J+NjsO8P2yg7VExuXVhNpkcHJCXV6HIFVsCYYfJHmCXYLRw89k+4+v3FB1babKx2Pb
	 r8x+WuQvr9DX7nETMu9rhu/VjVVQUP73/I7JJi/wpG1HbIomC4gwUq8Ww9RdWpl30ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fP2wtbL8okahCme2REeuz/5kpLBhIsTYBbFIyLkDukQ=;
	b=4cD0bEQORkiPd/lGyPfQkSV9l6BStV1MaYFfksNW0aTfwYHxsn0B/oBnBUMi2UBuJ3Cl
	 +AnwBu4l3g355sDWs+xAdSHGjcAP9f158vdxzDJaAaeojl64mZi2ISDTOU0AYQ1VonFxc
	 tWNDevGEgndGMd+3K9TSm2E8xDKthCRoIsbcbxmGcxY8kiVDjHwoUOXysCeM4sqiJGgow
	 HaO8p90iANxzZE0VlOB0DqmaK3AaPt2Xw8QVty2SNS3jx97OGvOR5ikKYRkmVI7tRM+ED
	 ygyD1EEMsMAoF7BjxL9335omr7eMcmupythgFoKTnPlj7MdYihvJfXhGUpeUjetSdsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOH80JmD;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E12606A32D
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Nov 2026 10:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E12606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOH80JmD
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso117a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Nov 2026 02:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793787809; x=1794392609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fP2wtbL8okahCme2REeuz/5kpLBhIsTYBbFIyLkDukQ=;
        b=BOH80JmDvOkOft+cKPp7n1RirDBIBFL2zo4WJZDGlWTn0vLjSBwquwsHFimt4K+vA1
         FdhAnhkpRpC7pduXSvZ+wG3rv/sxZmXhoWLS1uEqK+jTRPZWyd4Md60+3MPU2OOGKZZy
         3r+suUFd3TMG2GtAoDCzc8Mrc8s063vNBN2gqQt2tUZCxE+/nAa4YFsisojEjNCQKoCc
         fSK+aGOVHtKanDoGRkovZI45rCR8TKH0vZQRA7zy7t/vzRmWkA8mpNYclrLDEomrjwPP
         RNzlTcn/803NgI+tVuOvSJdntkLED2/EKHQwTSjyVt/kTlNjRRYG4pMdP4Wm5ONavfih
         Tulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787809; x=1794392609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fP2wtbL8okahCme2REeuz/5kpLBhIsTYBbFIyLkDukQ=;
        b=PvXedhLJM4gPYB1Hr/aN4W3oQzZeQOHuHOLFS4M0pEZAp2cQl3OKx6Q47ipyk8YIFa
         UmhVKuq4KQ0vYT4qgU3rwNQpFckvUGlLsmU2y+gXQgVhlEy/WhkiNvVgyS9HpbPVC8Qe
         IpFCQyQAzpKEQ4coSmwyNT7KxKV46GbxJCmtBCdn2OYEizh+UFi9t2Z7dzjAOI+3veIr
         3rFbGR7TVpUXtY7BtfQGUJkin/TuA1hwE7/zicSdcHjEeUUBg7jydkiePoDCd9ODA42E
         GwuJ0vB729IDEV2gbJ0SmYl3PnyW8uqZPrqkJRzSfKRZ9wzY52VqIl13+MQZNIKOQKJ7
         G9EA==
X-Forwarded-Encrypted: i=1; AKwUvBzfihiBsnuogO7PwjfaMm5dLQtAK3irAo0YtEcf72D7YJ78upy8ubPOfEda2foa1wFfMH7avrRoJWkUOzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/tC+o5nO7Ark/UhO/SDGFkY6qEODCj77HXyhnItzKKeCmdZz1
	f4zPj0lxuIO8kH1dczZmeCCAkmxG1D3byK4c2BnQm3+GrVbKlMUng1xIbSBZcEv7AQ==
X-Gm-Gg: AYBFou1DFu/OhPY4kD2iB2wp7bKEa/1TJ0nWl0EWrQmNHSJlsNenyRGP2Li2ZyYErc1
	Y6mqc2ae4CmMzXvw2U1+jBt+YYXVwjskEcTCbfT6fTsuazMUtQCVJmN4W9oOW/c0+rECzc2U3ss
	MjTnuZF9eGpo678KkweE1JY9SL6i/IFiDi/hOM1XPUyxvu7vU6ww1nYmtMDekRNfU4Fix2z7j1r
	4d8BcxPjK+Gom3N/uICBlK4/eebGoiuZdDU21a0Kui3vQc4hTW7mTORAVTPaFb/Jwkt8qsJYYjy
	vj9lhQ9+8aEpipYx71zYkJLq016kT6PUt14MtOhePDdXolot5zVCIZSrurwxBSTJuBT428qBiMB
	vu9KZ9xrIJwZb+qEVHa8iWHZUd8Fg8iYow6rd2SJOsrGYjPM+KdG9alFAGPVnmtzBl3OlD3krvp
	k1TuS1luYtRXoNoHokR66Rl/0qTcxRYj/OudnMSWvci3fQhMBYxS9tNLPBLzaY5V6S9sWmW+PAT
	0D7KME5cwbaxEOxMftyN10BLxGpBur66zE1u4kxoe94cST/cP/+3uynQFFUQv1UQCfsxzs/jdmV
	s5LGCxgXG1rXMPiOBIl+nxD7KjGiRlhxo6a5sg/kYjNyD3uA3hALYfuVMq3OVCd8lYjACA==
X-Received: by 2002:a05:6402:a2ca:20b0:6b4:6725:f2c6 with SMTP id 4fb4d7f45d1cf-6b55abce7efmr53379a12.13.1793787808278;
        Wed, 04 Nov 2026 02:23:28 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e1402c6sm55414666b.2.2026.11.04.02.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:23:26 -0800 (PST)
Date: Wed, 4 Nov 2026 10:23:22 +0000
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
Message-ID: <ausHmkhAegDEyeKV@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <atiaKG86qcifKzBT@google.com>
 <20261026114917.00005a22@linux.microsoft.com>
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
In-Reply-To: <20261026114917.00005a22@linux.microsoft.com>

On Mon, Oct 26, 2026 at 11:49:17AM -0700, Jacob Pan wrote:
> Hi Mostafa,
> 
> On Wed, 21 Oct 2026 10:55:36 +0000
> Mostafa Saleh <smostafa@google.com> wrote:
> 
> > On Fri, Sep 25, 2026 at 12:07:33PM -0700, Jacob Pan wrote:
> > > Hi,
> > > 
> > > This RFC supports guest VM device assignment from a Linux host
> > > using the Microsoft Hypervisor (MSHV). The goal is that a common
> > > set of flows and infrastructure can be applied for Xen and other
> > > type 1 hypervisors.
> > > 
> > > Background:
> > > 
> > > The IOMMUFD/VFIO stack used for device assignment has largely
> > > evolved around the KVM/QEMU model, at least as the first enabling
> > > target. In that model, the Linux host owns the host-side physical
> > > IOMMU programming as well as the physical PCI devices.
> > > 
> > > Architecturally, MSHV and Xen differ from this KVM/QEMU ownership
> > > model. At a high level:
> > > 
> > >   +------------------+
> > >   | Guest VM         |
> > >   | virtual IOMMU    |
> > >   +--------+---------+
> > >            | vIOMMU ops
> > >            v
> > >   +------------------+    external attach     +------------------+
> > >   | MSHV             |<-----------------------| Linux host       |
> > >   +--------+---------+                        +--------+---------+
> > >            | programs                                  | owns
> > >            v                                           v
> > >   +------------------+                        +------------------+
> > >   | HW IOMMU         |<---------------------->| PCI dev          |
> > >   +------------------+          DMA           +------------------+
> > > 
> > > For MSHV, the specific ownership model is as follows:
> > >   1. The Linux host OS owns the physical device and exposes it
> > > through VFIO/IOMMUFD, but it does not directly own any of the IOMMU
> > > hardware. 2. The device node (/dev/mshv) owns the VM partition file
> > > used by userspace. 3. MSHV owns most of the physical IOMMU
> > > programming, including stage-2 I/O page tables.
> > >   4. The Linux MSHV root pvIOMMU driver bridges IOMMUFD/VFIO UAPIs
> > > to hardware IOMMU programming through MSHV hypercalls.
> > >   5. Guest virtual IOMMU emulation is done in MSHV rather than the
> > > userspace VMM.
> > >   6. Stage-2 IOPT may be shared between CPU and IOMMU. It is
> > > managed by MSHV and abstracted from the Linux host, including TLB
> > > synchronization.
> > > 
> > > These structural differences from the KVM/QEMU model create several
> > > needs for IOMMUFD support:
> > >   1. Move a device to a guest whose I/O page table is externally
> > > managed. This patchset refers to that operation as external attach.
> > > Unlike conventional IOMMU vendor drivers, where translation is
> > > managed within the driver through paging domains, external attach
> > > means that translation is managed outside the driver, such as by
> > > the hypervisor. 2. Identify the guest-visible device across VMM,
> > > host pvIOMMU driver, and hypervisor namespaces.
> > >   3. Identify the guest partition in the host pvIOMMU driver for
> > > device attach hypercalls.
> > >   4. Tie the device-attachment lifetime to the hypervisor partition.
> > >   5. Coordinate guest-memory pinning and mapping for DMA between
> > > MSHV and the external IOMMU domain attachment.
> > > 
> > > External attach has a few caveats compared with KVM/QEMU, where
> > > nesting is typically handled by the host IOMMU driver in one
> > > transaction after the userspace VMM uses IOMMUFD to form nested
> > > domains:
> > > 
> > >   1. MSHV creates a temporal split between host and guest
> > > device-domain attach. The host first attaches S2 through a
> > > hypercall; later, if virtual IOMMU is present, the guest
> > >      allocates S1 and establishes nesting with MSHV directly
> > > through a pvIOMMU or emulated vIOMMU.
> > >   2. Guest-memory pinning before mapping is covered by the
> > > MSHV/userspace VMM contract, not by the VFIO/IOMMUFD pin-and-map
> > > DMA flow. 3. Device capabilities such as ATS and PASID need a
> > > contract among MSHV, the userspace VMM, and the host pvIOMMU
> > > driver. At the time of host external attach, only S2 is attached,
> > > so the guest's later ATS/PASID usage is not yet known. For example,
> > > whether to expose and enable PASID in the device could depend on
> > > whether the userspace VMM creates a guest virtual IOMMU.
> > > 
> > > This RFC proposes an IOMMUFD external attach model for those cases.
> > > The normal Linux-managed paging or nested domain is not the object
> > > that ultimately owns the translation context. Instead, userspace
> > > identifies a VM/domain object, binds a physical device to a
> > > VM-visible device identity, and asks the host pvIOMMU driver to
> > > attach the device to an externally managed address space.
> > > 
> > > The series makes that relationship explicit in IOMMUFD. The model
> > > is anchored around a hypervisor vIOMMU object that represents the
> > > per-VM partition abstraction. It introduces:
> > > 
> > >   1. IOMMU_DOMAIN_EXTERNAL for externally managed translation
> > > domains. 2. IOMMU_VIOMMU_TYPE_HYPERVISOR for the file-backed VM
> > > partition. 3. IOMMU_HWPT_EXTERNAL for user-visible external type
> > > IOMMU domains.
> > > 
> > > It reuses the IOMMUFD vDEVICE object to carry the guest-VM-scoped
> > > logical device ID visible to the hypervisor.
> > >   
> > 
> > This is very similar to pKVM on arm64 also, where the IOMMU is managed
> > by the hypervisor, and for device assignment, the host doesn't control
> > it for the guest, but the hypervisor (in EL2), and there will be a
> > channel between the guest and pKVM directly after the guest runs. 
> > 
> > The host only sets the virtual to physical topology (how many vIOMMUs,
> > vSID -> SID mappings) and describes that for the hypervisor through
> > hypercalls.
> > In Android, we have an out of tree uAPI through KVM/VFIO bridge
> > IOCTLs that proxies those hypercalls.
> > 
> > In that case, the host just creates a virtual IOMMU and the guest sees
> > a paravirtual one which runs with single stage collapsed translation,
> > although I don't see a difference on the host side if nested
> > translation was used beyond an argument change to the hypercalls.
> > 
> By "argument change", do you mean that the host would pass the guest S1
> context in the device-attach hypercall for nested translation? 
> 
> IMHO, I don't see any change needed for the host-side attach between hw
> nested and collapsed single stage, if guest and host attach are
> split. I think it is up to pKVM or MSHV to handle guest virtual iommu
> mapping for both cases.

Although the hypervisor (pKVM, MSHV) is managing the guest IOMMU in that
case, I believe the host should be able to decide the guest virtual
toplology, as that will impact the firmware tables populated from the
host for example, as in the nested case the guest will see an
architectural SMMUv3 while in the collapsed case it will see a simple
HVC based IOMMU.

> 
> > My goal is to converge to IOMMUFD and I believe this series is the way
> > forward, By relying on the vDEVICE virtual toplogy uAPI and the
> > external attach introduced here.
> > 
> > I will try to prototype something based on that to prove that it
> > works. However that work has a dependency on the host SMMUv3 support
> > [1] which needs to land first.
> > 
> > [1] https://lore.kernel.org/all/20261015200903.2735565-1-smostafa@google.com/
> > 
> Same here, our pviommu root driver must land first.
> https://lore.kernel.org/linux-iommu/20260929223622.778617-5-mrathor@linux.microsoft.com/
> 
> My next step is to rebase on Aneesh's v7 such that we have a converged
> iommufd viommu layer, i will remove mshv specific helper registration
> in this series.
> https://lore.kernel.org/linux-iommu/20261008055955.4014342-1-aneesh.kumar@kernel.org/
> 

I see, I will add this to my review list also.

Thanks,
Mostafa

