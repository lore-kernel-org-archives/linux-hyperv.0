Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788073;
	b=kg0lF6MLVicUwHnlhTbFspSptU5e9WIQT5MR0lP2Kc36Ro+C0148CNJgZlcVSOk77+V4
	 zJHaY58l9L1jdNATB7M23m2yZTJKMqDj7DuyeJc5Jn/2FokWpjmN441jiMLqWANruz0qo
	 F7XsL0xP7Y9Vbe13nzo5+TqMjG9vkaRZzRXIyXWyqj+HJyixvbs0EVLxKAcHdXevaY3Sl
	 j4eG56mY7FWbKHIpg7dD06jQlJ1r1/3gabSISgdNr4ZwwomsHTWyK7eE1EJIpRM2C4IZG
	 tuv23i6uYQeIJWVd+1LJa8AvFKHmnvQhXV9r1zRphL6jjstD1HonyN5P4CLT46e87dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
	b=JqX1UOuwR/n7XyuZioDU2CiUCVrvQOpbeV1CM/Znp7hchPHHrA25KJo78yFPi6Hp29W3
	 8Ha4AAymnYxJKl55h+yAl90JU9K/Etxh/BVlrCrO968jItGbFkX0a19q5rlORXaBwbBq3
	 MtyinDhJeTd1F9BlxrsGcCMod/2In2riAh1w7QjyX8wNML08X15hS2moHggdipOy2SEyh
	 EWbjjHP9uTqKBhNOGFEmmWIj6y8QvS1RjXGs8GbIs+1QnUnxwnci0sf4+umzB6pNSE4yZ
	 Fk+73lTLOAMuqOzPnhx1W3vVC3907qD4znmkUJGqPRXr/bw6t6s9xR0Vn6TNAel0v6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ETY8VoT/";
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE17606A328
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Nov 2026 10:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE17606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ETY8VoT/
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso7695a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Nov 2026 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793788072; x=1794392872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
        b=ETY8VoT/f+gDU32SGXFwti5vr5fy0yPG6zRSjejzpQMJOVav1+tZqMyte9EyF+4IgH
         MRjXyR3rRsdcXoeKpcoHArC9/SxZlMktYBlTbH+p5n1AVBtDVR7dHfaIjeIDkHwAiBIu
         ecAm00KOZxHMW4azoXD3Rk83uDFOqv2kDZdYCIPC4ScTXNMup6y+qGzCbcsq+sE3NSdC
         l4bO+Ci9F2o4AJsy2FJkWpS/3buA0DTrbXiJolnxhXCLPEtLIHpVG3Okxp1grtyffcs1
         CYgX4q74LfeC9PpDxlC43DVAJD3zZNyhwtgmvqgB+CDSbNqSP6LAuvTg0dnVsoSaa1NP
         hlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788072; x=1794392872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
        b=Tezw9JJPQmxhhPlxsf/feMVEDDyGQ7UdLBHLo+pMFwBFsZTLLVNdA/iQlxy/LG48KM
         5ojV+J9VEf5jLUVHZH5+O1unMVPXCZ5dRjiDauHvVpZ+sAJTgmdpe1V+3NX8R9tBSitd
         ucGdy/JrzHqDg/viW6MC3ZCUi1SmEMJYteFvk1A9ycyb0VtrJb8NVkaYTT46AuioeguD
         bA5gS1YxC/OURRFiI/oVqjDX0lNEgowHR56KwbpJjXrZJxXyIW1LV0z/jA1Pp8TGU8NV
         Wklx6cTOLaX7KXsjzTUPsHJvdYQ04AW3w5NVK0btHF+YMQzEnkeZvD+W1hdwXZIlNebq
         Yh9w==
X-Forwarded-Encrypted: i=1; AKwUvBxwZPd5KnFLYAw0+bmFWM1FCHDSRvyWz/oaAGH0kH9GtdpAkacsdoAXrOvulvcCiaeqsbGISFjU15lqbqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/01dHFG7wJjmKNGHW5QGq0uEJOJidt0dRBfAkZbW/N8kxSJRqM
	ZRDtl3YW4pLR6FMesSWfxIVsB5QNX91U0FOkFgCR7cZV2YS9HYR0AWgLhm0DmX5xOA==
X-Gm-Gg: AYBFou22JJ568b+NfW/7VHuM/2vKl5Vs23a9S/X5SMDfIhcjmwThaeo4M/qJWN2HQLr
	j/vBWwJH2kIEY7n1+I5onsE2axoXJS8taafegYU8CfIi1dqFFv7X3fNSuqGnBdzwyeoOq+atDvd
	6kUJhY0qyfTA9c/sVXjOgS1oosggKWGpvweYT+64uQMgk6404l1WHsALwarJB55MCrbmikGNGYU
	wDjb/NHqFrL9uXDw3P04SPrHyDZmqPcD8oMydwTaRDRDXGl5Dv5+2p/MJKFsNSznltVit51qreT
	KBaNsqoDD3Y2X+d9r/DrFsCEAfJOQY/vGJUJbaokPoiaEqlHvaSnK/A3UV/nWIJLYyWvwAFcsWv
	SCMdpyskKeQ9CmAYrSoLGwECn29BWcD/ZjC1ynsbrjKhEdfvljJttXybt+t2+sOut3CPZHLrzoz
	383pfreS6j24ylOIrDHc1EKgDZAoCeks+mC+jg/zuIywFN4xwH5J2KynXOOfcdBYou0phPQU47X
	uxWSxH2eOxOVMoML4xUl7Nn9jcGYthsJnRcMTs17g6ZywQo9lIW2agGFuVvpIzjlG4j0io5VwAj
	IHx96AARAvaByuIB/BbO886iEZ/wmRV8F/EMzb5D1kB4ShYzbfXzzTZi7ToWMGaJ6AFz69+AyTm
	EWWbjx0fB0gaa7jVX
X-Received: by 2002:a05:6402:20d9:b0:6b5:5cd3:5dc with SMTP id 4fb4d7f45d1cf-6b55cd3077fmr36964a12.1.1793788071437;
        Wed, 04 Nov 2026 02:27:51 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e41d670sm54601366b.23.2026.11.04.02.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:27:50 -0800 (PST)
Date: Wed, 4 Nov 2026 10:27:43 +0000
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
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <ausIn5Txiy1uRjkY@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
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
In-Reply-To: <20261026161003.00003b71@linux.microsoft.com>

On Mon, Oct 26, 2026 at 04:10:03PM -0700, Jacob Pan wrote:
> Hi Mostafa,
> 
> On Wed, 21 Oct 2026 10:57:20 +0000
> Mostafa Saleh <smostafa@google.com> wrote:
> 
> > On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> > > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move
> > > or attach devices to another VM address space provisioned by an
> > > external owner, such as a type 1 hypervisor.
> > > 
> > > This is not a paging domain and is not sysfs-selectable as a default
> > > domain type. It requires external owner context, such as a vIOMMU.
> > >   
> > 
> > Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host
> > never inserts any mapping?
> Right, the host does not own or install any mappings.
> 
> The external domain type is nevertheless useful for two reasons:
> 
> 1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen attach
> and detach hypercalls 
> 2. It allows an externally managed device to leverage the normal IOMMUFD
> device-to-HWPT attachment interface: VFIO_DEVICE_ATTACH_IOMMUFD_PT
> No new ioctls.
> 
> It also makes the lifetime and ownership clear for IOMMUFD and
> hypervisor, the device can be returned back to host iommufd owned
> domains once detached.
> 
> In pKVM case, my understanding is that you have a emulated root SMMU
> which does not do hypercalls obviously. Then the external attach
> is done via an "out of tree uAPI through KVM/VFIO bridge IOCTLs that
> proxies those hypercalls."
> 
> Therefore, if we were to park the device in blocking domain while doing
> external attach (as you suggested), this requires a new PV only uAPI
> that must support pkvm, MSHV, and Xen. So it does not fit in the flow
> supported by PV IOMMU root driver.

I am not sure I understand this, how can the domain type change the
uAPI? can you please point to what breaks in the code if a blocking
domain was used?

Thanks,
Mostafa

> 
> I don't have a better solution for both pv and emulated root IOMMU
> drivers. Perhaps others do?
> 


