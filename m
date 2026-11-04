Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812099;
	b=xSJbD5uQ8f65BGHItgQzEqxBA8bveaT2PEgvyJh04ewgpvtoy1H/NOyO4scZRgaSFn8k
	 hXYOQ6FI3KdP5XZda1qqMWzYgBReJo9tpSd28Et6ZESXs+/hWfqRRfoKSD6hq9j9pDHXW
	 lDUeGyhiJviU/5e8iSxcL/fhvz1p44dVEehqTIxaVb58YldbLUWuN2XZl6X1ewwWcUx7b
	 neTktZYBhO8eRbY8/fJknXghXSuJYUzoBCfz9WTNz/7ZABytsHKPtImWCMsInCuYbEtl7
	 X56SFml0Cyo4H5FuVwylljd7gXRBPykhOkp/KFbhc7TeOG6FLFTmWrzPczMUpk9pL+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
	b=oaTp+S48l7cI3WBTuBJLE8LfajWJP+DmmgYSdb9/0EPQAOPnAbzRiMP+vpA1Xfu1xpgL
	 XhWnBLSsuOpIC5khTvepNh/ZwffVde/J8RQGCmL1HfO+Wy4QQHg4kg1cwz8o5S18ADJbR
	 MvIeUygpuwoa6w9UrGkmNTZqnbqwlmXvkSCAEd/M/nV7BKpuAH8ZaPbSnrlbLAIqbq98o
	 HYcJ4VfscjoyMW8YWawwXERacuSidd6Pofc5H7Zzv2rmKCGa4emWglxwAwt9zaFy+FL5B
	 PizF1Xt7dioH5gIYRDmK1SE4aWHpXpw96/+hMNaeMfyv8ZDsjBYnbtq7Wd8fAY07maQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=eGRuSzim;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7E606A330
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Nov 2026 17:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A7E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=eGRuSzim
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f269e335eso106081785a.3
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Nov 2026 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793812097; x=1794416897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
        b=eGRuSzimVkRdthVIwZ8j4V5/X1jU2H86/SOE6oD6/Q7NP4cLiSqGfJgp7mTdA8poXQ
         Ts8BLSn06r486J2kiI3LSH2Su7b7ls9A7Xd9I4I/5dgh7f99Vftn1ES0gg+KDm5HAu3m
         8qhGzCV9GbR6gt+jqkZJdyvBGGVnepD7TLWBpWnWovNEPiKSh9jtwTPXzFEUmU2s5ynn
         bgHm8kXq77T/HGgjG6aK4vEYlDsp29ORryNE8bv5wmogxGrWwLnqHfJKYZ61HgXLfO+U
         bsKNswZ80FHq12CBn1lO1iQEpBkx8eF0adXetWs1C2BDIRRqw4Rb/pLyja83jYGYb5wc
         117Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793812097; x=1794416897;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
        b=ePwj8oO5cXyvguQR+FG2iIPhExbrUS3113YAbc7ysopIIVvdVNOoi0QgmunADDxEWt
         GPcw5d+YXiw3nsg1+yl5SCotIZxcU9ML6Z8TfMVpk5PWFnLA+LeJZUj2CbB9wUuekAVL
         Xlf0KhSeacC+uqamKKG1Mn9zjnj4Gmyy1r+Qc96CCYe1GKyBYrqqTKzQClbR/wd7Lm7M
         IXO++Lmr6fokZnH+ugW5HF0WxyB+zl617evzw3wdFzEbVpkjQaaKH0hQg18pHqiN9hfb
         kz5TIQEms4WsDjLz79eHoHpnBGbbddaFxTOpiORz4spkybU5O0hHMASpepEwIV3o+e28
         J+qw==
X-Forwarded-Encrypted: i=1; AKwUvBwj84uHm2VQL6moMZgVgyzLP55RiOmCmdWYpJ9D5Reh6ftJBrjOrtgCKSvPWvko7BS3IRLJMs8wjX0yaBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+omZp+Mqb9z9vGIK2kOMTSLxkZHPN+7WHG9AJaYKwzmFSbx6n
	hfU3nUB3ISgbIhhc0mmlleTvH0flsX54XJ7IrWnfMVuP1gpgUdDzbTFHtmZAV3lRjZY=
X-Gm-Gg: AYBFou3uxa2UHZSLWQgl9pAHstfKmriri1nGZItzBCCrug8xG9eX8X4+4WB8aHJr9Zf
	MYo8L7QGlD5m3mDePcd5ao3LZKZETSoksqCYiUzC4D6+rs5M0ChG+NL0ieWpg2qsgvoykxsTIjm
	l9EJhalYDs7rQZ2wXOcvs3vQbWiJTOqdHDWLGdzam7yUQ0dcsZYQFho+Qv3TzU9i4MKA16s2KLR
	hsE0e1TY5aE+fRRjDQ2kytdHCe/LnCl6qDW8TI5LSbwZ041ufqjK0r5fBvzoGoDtS00D4UReaR7
	BEsONGFUoy/8FGH+c0GNGAy0qC/jLuleIwY5gQEWwuPceN7qTdHBItwoZJuheTo9Qea0hO0M8Wa
	Oeymjb3n82kG6rYBMliaimuKVg0a8zm1zdFVt7sFyMnQELz+/ycMd4FvFwNTof/9RoFPJ3DB5kW
	kA3pH5sFMrj7pLUdtZdBn1R/j2bkPWIDTd7/l54rcE7BuhTCeGoJfcP1HeH4ejMpbQ/jaNLnwbs
	uyYDN7lxGUUh2om8HkR/q4ngkP3o4tlhfyCJsSBhY2ytYknn41IWl+tD9eNsNZ4WMPwsuJvimo8
	OC+ZmZDRTvldZUGIsHtNuIE0teojfoITNw5fQrzw2Lk5UupbUw3MCzKv97YivlLvj9T7Vntl5h7
	NFC4/+mYYyg==
X-Received: by 2002:a05:620a:4014:b0:944:dbd:831b with SMTP id af79cd13be357-944216dbfc3mr2925762185a.51.1793812097533;
        Wed, 04 Nov 2026 09:08:17 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482eb96sm247450485a.23.2026.11.04.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:08:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOeTA-0000000GghE-1hbL;
	Wed, 04 Nov 2026 13:08:16 -0400
Date: Wed, 4 Nov 2026 13:08:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
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
Message-ID: <20261104170816.GS3889730@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
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
In-Reply-To: <ausIn5Txiy1uRjkY@google.com>

On Wed, Nov 04, 2026 at 10:27:43AM +0000, Mostafa Saleh wrote:
> On Mon, Oct 26, 2026 at 04:10:03PM -0700, Jacob Pan wrote:
> > Hi Mostafa,
> > 
> > On Wed, 21 Oct 2026 10:57:20 +0000
> > Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > > On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> > > > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move
> > > > or attach devices to another VM address space provisioned by an
> > > > external owner, such as a type 1 hypervisor.
> > > > 
> > > > This is not a paging domain and is not sysfs-selectable as a default
> > > > domain type. It requires external owner context, such as a vIOMMU.
> > > >   
> > > 
> > > Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host
> > > never inserts any mapping?
> > Right, the host does not own or install any mappings.
> > 
> > The external domain type is nevertheless useful for two reasons:
> > 
> > 1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen attach
> > and detach hypercalls 
> > 2. It allows an externally managed device to leverage the normal IOMMUFD
> > device-to-HWPT attachment interface: VFIO_DEVICE_ATTACH_IOMMUFD_PT
> > No new ioctls.
> > 
> > It also makes the lifetime and ownership clear for IOMMUFD and
> > hypervisor, the device can be returned back to host iommufd owned
> > domains once detached.
> > 
> > In pKVM case, my understanding is that you have a emulated root SMMU
> > which does not do hypercalls obviously. Then the external attach
> > is done via an "out of tree uAPI through KVM/VFIO bridge IOCTLs that
> > proxies those hypercalls."
> > 
> > Therefore, if we were to park the device in blocking domain while doing
> > external attach (as you suggested), this requires a new PV only uAPI
> > that must support pkvm, MSHV, and Xen. So it does not fit in the flow
> > supported by PV IOMMU root driver.
> 
> I am not sure I understand this, how can the domain type change the
> uAPI? can you please point to what breaks in the code if a blocking
> domain was used?

Yeah me too.. The plan for the CC side with TDX/RMM is to not have a
S2 domain in the viommu side at all. It should not be uapi brealing in
the sense that nothing using mshv viommu exists today.

In mshv case the iommu drivers are telling the hypervisor what to do,
so they have to effectively see a change in translation. But maybe
this can be managed internally to the driver by annotating the
blocking domain attachment?

Jason
