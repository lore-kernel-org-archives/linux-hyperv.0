Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316946;
	b=ZQXCXSSGeNnyv+65TLh0bA0wk7e/mdd+UACbjrOqcFIHk2miqB8834oVPHm3+6bYNdWY
	 fsb8AVJOdDQUJAPKln0/g2a26UCGDKJG+rA1kBD1vi9nkDWa3Si2vBIXD9VZUdYTfxoqk
	 Gj8x+tI9UOCjBjOHROEomm066r69UcvhHe8Km/wkdHyW1aBP+AO6cAR7pfCYolcI10Zz+
	 Y94UeLK/SizQiuhCBoR2pA1JOObMs0I/9ckO0clBRjG79o9hS0AabaM85+EL2pHyj94Hw
	 +KQWZ95Lad/PXk2ryRQNWx2Aj/vWtixcIR62VoxNmR+Mq3VK74PlE4YWVzWwfdyujxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
	b=P/UVT7SqbEV4nUyCbGUaAClA/1lzH6mh2EhXbjYCE0LAKeExSchuKiItV22D84DyFNTY
	 XiQXLcyYTQ2z6Ds+mTsw5t0v+HHbgNTyCNMkwj1MIdMcas+vCHbE8L+qL5LK4Md6kgmiR
	 wsMRD+wfA4u7EwMOrSuTzk7VGUqUvv+tWM/7s3lrp6kdhHGXaZz9D+nybmFP5HZhmBaoB
	 HBZVF/BbQlz24qWPAwsNl4P8FDrt2F9nkEMz0fXy81e/jrAZ0BSe2V9ncsmYi6KVYT5kM
	 fPsWLuYHX5btjNT0YovyoyXcWq3vKhgP3pX0Ax1r6wOiELg8zlxejKzkTYfuAFupqWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FHvsNgog;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0355606A7D3
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Nov 2026 13:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0355606A7D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FHvsNgog
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e515769d3so199527585a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 10 Nov 2026 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794316945; x=1794921745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
        b=FHvsNgogAjEacq7zoQCQutH3H2rY/Mp6nn0PQAx6XhH7dqAsY4gCPt7R9BdbuXPKAi
         wxpxDLfikqVcN5xM1VY/H/v/NFQ6nTNQYbBjTB9Y+X54YQTUKZWiCbPrue0kUPKLvs0B
         SWItP2scQqWO4gEug+/zO85bmIDyfB5gy06RbKUkHIRG6Td26af+dAAfFxPpJhtVkzxI
         RTY8q4wfOVoj8Mo0U14wRoJwsgbjTWIxlmNGak378mVQpNEb8y5wGLQ5tkNTHEct8BTD
         2QLJqKjtduDf7mQ4NLfWes8q0X9CZ1SxAGlG6dddpQmRt2wbHKc2ucYJzj5kuQNmJupi
         3xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316945; x=1794921745;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
        b=jUReCordyjaNKFfGjteJBZr9acb90NWCuB59ODXpnlEKC1jhhmOTAehw1/xIRQk/8P
         8teT9Dzw3RTcGa066OekIxvKfASvpa0aj9AlTYNxNilCdFiYdkmtHiGXg8jhkVr8JTBF
         XhAe1zYICPApEjOU5qy1VQQ743TX/XZhgBgsdSQZA7/VxeTqAjYWtiJ9mk96N+m+/w8v
         SULUOsgg1El7YmWv8cjSbbaEp/OBkstM1WsA/58Ar4XbyhJEq5CDJpX2jrfyjuIi9Lj1
         13rk3yRsO+g3zaggk1R9ZuHb3Z3JeJDIWlygNp+xWPtHzt2+uDcgBtH4u0P25UuK68xX
         jesA==
X-Forwarded-Encrypted: i=1; AL+hErFGjbtIKf2G8jKtqMBrAeWdROMGsaJTBuZcthFPlvVz+sGnbYQ11D68mLfs+s54jV9hokV+yrXclrlWFqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xfWDsF2domVGTKtci6ISEB9OFdwaPPHEsoZDvh/tuex19olSE
	cclO9K6YLmKHOPbRdr67UVeBTVNphKSaqHVzoO8CyFv/p8TmDLX5WJlEV73ypBzRJ/Y=
X-Gm-Gg: AYBFou0Tdn9WrB1D1Ovr+R326QuUuKESKj62bTEJJFnw/B0mpwvGMWR3CRPGTsBiQyM
	2hZPO4inlEkGEAMm7A/6cegaqORDv/WW/UcS9s/WlWS2a48OVK/C55i64fbRHi6qIVppneBfWr0
	tJ4ozIr9sxCFeKLfCTxZ1TX65/QLX221IpzWqdeme+TEAC5Rte1VBRgcWcTvDiXAT8PlPpKKmBR
	nAYnb9cQVhmrrMaLOIJTl1JcHw4z0la7UF8m5YgHWXsLu8h9jbMdBIRZpOjUZWdEIKkD6PI7ULb
	sIKkW0RneYXiI+h6pSjJkSh1zGP9QFw0u2GXbCvULRsBwPYmdy6xsSZrJNVae6vDZXQLrM1luBe
	yWCRQheCG7xUDo1psX4Pf5OuKfs/i7suTi9lEudkH5L2FHtnN+mEP8tU29UPBHEGSxTuqFTKi6I
	5I0Y/dPqhTdv1s+yMPEuMDy/358i9c81PFm/AZng57JRCDg446UVrGvbzoQkUb7no3vbM/pUYV5
	Vsm3og0rMQISaC4KnZHZ6+ig+qqjZID3w/woqaXXrW2AuCX9WOAKoDT2TT9d1bAm7T/bMcLdHHU
	UJxkvQ3zmLMdJIiFW8nOqRwrYJJvIsuB70vLWtVO/07YHPKqJZm5MttYLRdOsu6WGNOdeT7exVi
	W1L+DG4qpDqQ=
X-Received: by 2002:a05:620a:1a21:b0:93e:c12c:43fd with SMTP id af79cd13be357-9479f373debmr404603885a.74.1794316944696;
        Tue, 10 Nov 2026 05:22:24 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7915e2sm220546385a.23.2026.11.10.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:22:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQlnr-00000005hfb-1yLA;
	Tue, 10 Nov 2026 09:22:23 -0400
Date: Tue, 10 Nov 2026 09:22:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
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
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261110132223.GX663069@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
 <20261104170816.GS3889730@ziepe.ca>
 <20261106130352.0000638d@linux.microsoft.com>
 <20261110005259.GU663069@ziepe.ca>
 <20261109224200.000033c6@linux.microsoft.com>
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
In-Reply-To: <20261109224200.000033c6@linux.microsoft.com>

On Mon, Nov 09, 2026 at 10:42:00PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 9 Nov 2026 20:52:59 -0400
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Fri, Nov 06, 2026 at 01:03:52PM -0800, Jacob Pan wrote:
> > > I am not stating that it will break UAPI because of blocking domain
> > > is used. What I am trying to say is that with the blocking domain ->
> > > external transition, we do not need a new UAPI for external attach
> > > for non-CC. It will just reuse the existing UAPI.
> > > VMM:
> > > 	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT,
> > > &attach, "VFIO_DEVICE_ATTACH_IOMMUFD_PT");
> > > hv-iommu-root: external_domain.attach_dev() will do the hypercall.  
> > 
> > You've basically described a wonky NESTING domain.
> > 
> > I think you should just use nested domains for this. Even though there
> > is no S2 make it possible to create a nested domain through the
> > viommu..
> I didn't use nested domain since the current parent hwpt is a paging
> domain which cannot be used to express the external attach semantics.
> 
> Are you saying that we create a parent-less VIOMMU (in Aneesh's patchset
> and my RFC), and modify the iommufd core code to allow nested domains
> to be formed with an externally managed parent? or we expose a
> opague parent S2 that is not paging domain?

Just use a null S2 for this. If the viommu was created without a S2
then the nesting domains should be created that way too.

Once you do that you have a normal HWPT representing the S1
translation in the guest (identity to start) and everything works the
normal way.

The only wrinkle in your setup is you don't have a S2 at all. Not even
a placeholder.

> But if we go with the nested domain route and let hyperv iommu driver
> handle the nested domain attach, it still would not work for pKVM.
> pKVM's root SMMU is emulated, so it cannot do the external attach
> hypercall in the unmodified SMMU driver.

Yeah, I think it is fine that the hypercall is not part of the smmu
driver..

> So I am willing to entertain Mostafa's approach to park the device in
> blocking domain, then use hypervisor provided viommu/vdevice ops to
> invoke device external attach hypercall. Basically, move the
> attach_device to external S2 operation out of iommu driver to the
> hypervisor code. It does not need domain ID or anything IOMMU specific.

Right, though in your case some co-ordination is probably helpful
since things might go strange if the hypervisor side and iommu driver
side disagree on what the translation is

Jason
