Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811866;
	b=CqrrXXThIgzriDOySCDGc3PxYu3KN0iagdCC+RdU/T+c7NuY/dNx244As2Q8QJ2Juekd
	 NepnRbzin0B9hCscBjqNkO684PzIE//RwH56QvT+OxO34VM1jexPS6BmjgdvmGf6O87wy
	 Q1eGbUhX1YUrXvL5l2N+iScmS1kV1+k5LTLmxyLSgHYELRwLVyS1lIR4aTIGiRZhzfRc6
	 ZMS/xvKOisA+h9qGE1/8U+cWKwubfgNY6Kgxzovpptgznb4wDf6turv+CX4N5NJtnmMh/
	 koDRqzCJHoKwODXGg9bY06nNVatxocUUudHKjAoArz+XeZSWAlQAGb0dJbp7GKILi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
	b=asTMweURc7VHajvHxNeeTDTvaJhvWKIWq7Ciq7Ifqy+HFwPzqAP8fSWRtQuXOBG/H3yf
	 bSScmXxaq3X0gcR1hb5FlgzibHjvnoP64sqVTVlgJQSva+6p9WUq8J7AReFZFCurFo21u
	 NnmJeDxydujJkF78yzXdqY7PRNxtAUDXQBm7crzmyDQbbnxhXutYm9D+6KfCRCRAk3D5g
	 deX/GQccAFm8ehDmqQcu/drlCJ8RzROYlPEHHTfxNbOMvK2B+9XyUTJgY9m+86U3/fJdQ
	 8tazA7dumWbeYsjHdmPR78KT12g9CRSS9FwYRbFGFQqWy24e0gF+DUF+eNOwolOaWCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FnPloMwq;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB70606A328
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Nov 2026 17:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB70606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FnPloMwq
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5363c8de563so9482151cf.0
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Nov 2026 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793811864; x=1794416664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
        b=FnPloMwqvWngKH5CC21E5gJVOtx9Q5IEOnDICAe0sUklobcLcaZM+/OzQztOg89V0i
         KuoYr6SyqqP0xsZKBKmoT7XPljGNtu70vol3a74doIKswPmkwzug2tclYHu0Kv6e8+l1
         +JFi5Nq1SAEhSZWtNoYLF/yglFUJwdfBpio1QPbUxTqzxSq0ojCqMir0AcZtuREGNKkc
         xyRB328ONytLaREiGlvambI6t4Rgz3ko2L3z8UmYQdtz5N13n5IxPkmJRjT0jTqvisOv
         Q5yUTN4FFVFuHWw9xNUBcxZAVWN3xoPTIIdN/XDafoot5ZcebTrlkbNL0cBh0geCpS5L
         XNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811864; x=1794416664;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
        b=zfs+kvCiPCQDPph6hDPar0q2ttifF3WFfybhsDxKIvo/i6QYm8XJJlzjLDEVFt+9XU
         1zdn+c6zXYQXd5BkUFuRYLDBfX8ehkSLCGFUZ4d8ucrIWEawCRqR7WDOfdiLleUg9adG
         Q8F26SbakQbzjxi5PQhfeeB1SKkLV+d2mWay46EjRrJS0mV6x3az3Ow15HypqXuEWG4Q
         WRfk84IuTr3rl2mlNZ4UAMnxn2DJQsTlGaIUK6mK6N4PQ9lzP6Aomb+wRUf5qsVrzJrk
         QwZqxp1lZspaLNCK8PwEQWGvFG9FukiBJP2/uYDji4911zNd2WoM1n1MksMlmdAb2ZjG
         Evfw==
X-Forwarded-Encrypted: i=1; AKwUvBwq0RlJLcxL6AYHfW918DFWeo9V3ri4casmo9nH3g5CxLBA5g7P1ypGC8e5BkJEZz3ZCIyb7uKhIXsBth0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Pxpg9vSYPCf+duRZPRdaaMBcrPOKTcY9Hk+zhyeofAT1O+gS+
	ZxdvoWmH3KOIp9HJw13u0YgpTliqul1QgTj1E1N0xEAvQ8Xjr11iykFuwPOkHF9aG1w=
X-Gm-Gg: AYBFou2CAq1vNnX6FEFV6LlCD+Beytg0nuRGc0RsaAWRbokNFtXhR0ttS5h9T0K/qZ5
	6Yj04pX1bpcMhAIzgXk+VcK9P/bqd0+o2GE29tBnfBjLOVyPt7U7tAhKmmKQf8FUcZ0DmZboJSX
	3Fc7qfeuO6v2a8objp6XmY0oS1BwvbQ/EX4mrMqw9sFVUKbKfgRooFx61xhV5dZfpPhITABWiGA
	1KW4ltDD28iHmcNe/PoMClWalB1eR5+4fYUtoqFLi99pD9uDoC/IvZtMQyl6JOob/oW0L5rMGDG
	hOgynn/ChjN6AjggLk7ljpXoCGX4azDoEJwEaW/txcDW/oMaHcjkRXTYO/gUoeRBIBTEkcQPQUe
	jfJMOjlI82WRKiVMUYGKegaEXlfESNTriDNRSPgB2lQqLGaFgyQGgMd+Oi59BdXK6bQu9bDaSgR
	2MLOIZaHUexkOZ/6ULSdaNWA8HsquqdS2gjiMLXcmPB5LScWy98APo93EpZyutwrCZfX6iaCC8J
	Jl+6vCw6/2eEfpQ6Y3926EMr+EcjfXXlMx+qUJD3O7dqpStx4eL0htxfUcQC3bFaP/FvSnZlmWF
	mOX53zhbVN5IIAHqRIx0nwx0NZ0f3JXOrtGXxTWaMcSHffRPwAuhf23s6ENZ7lSc1EFjmJDF4Gb
	AjMuUa+lf9g==
X-Received: by 2002:a05:622a:e342:20b0:537:83e9:e46f with SMTP id d75a77b69052e-542b3c732f5mr202335741cf.3.1793811864442;
        Wed, 04 Nov 2026 09:04:24 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c49ab3sm28279301cf.19.2026.11.04.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:04:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOePP-0000000Gg2b-0y2m;
	Wed, 04 Nov 2026 13:04:23 -0400
Date: Wed, 4 Nov 2026 13:04:23 -0400
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
Subject: Re: [RFC PATCH 0/9] iommu/iommufd: Add hypervisor external attach
Message-ID: <20261104170423.GR3889730@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <atiaKG86qcifKzBT@google.com>
 <20261026114917.00005a22@linux.microsoft.com>
 <ausHmkhAegDEyeKV@google.com>
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
In-Reply-To: <ausHmkhAegDEyeKV@google.com>

On Wed, Nov 04, 2026 at 10:23:22AM +0000, Mostafa Saleh wrote:

> > IMHO, I don't see any change needed for the host-side attach between hw
> > nested and collapsed single stage, if guest and host attach are
> > split. I think it is up to pKVM or MSHV to handle guest virtual iommu
> > mapping for both cases.
> 
> Although the hypervisor (pKVM, MSHV) is managing the guest IOMMU in that
> case, I believe the host should be able to decide the guest virtual
> toplology, as that will impact the firmware tables populated from the
> host for example, as in the nested case the guest will see an
> architectural SMMUv3 while in the collapsed case it will see a simple
> HVC based IOMMU.

Yes, this is how RMM/etc are working in CC land.

Untrusted hypervisor defines the vPCI topology, trusted hypervisor
implements it as instructed.

Jason
