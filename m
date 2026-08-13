Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89847887B
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Aug 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628980; cv=none; b=ZYR+i2pmfrHisHZm0bmfWeTbOf6mowse5WUYfb4z3xP2htinl+A2GeCb6dykn9BxpU0pmW8vN2OeQoMRUidgKBujnnOzZGkbD+z7WeHmxq0uP6iX2NYnSCWkzLidG81dxXAK8nTJiTqBl33RphAy06cXpIlwhSbxsFVSPZDaKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628980; c=relaxed/simple;
	bh=0/BIRfMphfS1OGwGGVzoT/+z7v+H5hzNBd1OvKLo6R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2AXSCJ1LvE8ql/gcDsEdh7dlkIZv9sgpTU7sNgT88tr0I7gX0TWke2KlplNN2x9HCaTDOa3IEL8o0uy37r62df4zD4A8w52IcIRWOSeuFHaHlIMH84S/BHhFxCUa+AVq2zJTLwIWGtlCw/amcvEmkWdf6GX6SrlyqLl+fyWrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MkYOV5dD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MkYOV5dD"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e55b62640so31851285a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Aug 2026 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786628978; x=1787233778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Yi6QACY6Sk+pPvGX2LOJZA5tLUZ+nGsCUcFWjEbL98=;
        b=MkYOV5dDeYB6Ka49dQF3qGymlcQNeahvXC657wTWSh5bc13cs3WKyp6KlUju2hOTLr
         OZDQ1Jizl3VHXYlH/f+DXmDDjNpT6zDDhxHAnOFDZ2RmaDsVsazaihXqTcl0kXwsFhJp
         N2MQeFqpiQICZqgOvaTA8pY69vWKBnHC7gulzwU0xfrjU01gbgEZRQR/BynJJIWwQ4nx
         P6zkNCZv6DUjD78Nv4xeIHfmeBX4SQpaBB930lcXI0UKHxjsamNGqoIWuyqUqb6FyIOX
         85aFuVThogCAOjIvihgEEQvnO49vpgCTXHOPDzwOyIPQxslnbrMkxoMPlqvRQo+gLzk8
         Fzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628978; x=1787233778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Yi6QACY6Sk+pPvGX2LOJZA5tLUZ+nGsCUcFWjEbL98=;
        b=Tj2rS83JYl3Gq0iFgVTEsiaauUQOkt9vsplJUd15KtMyrmGwXC7fb3eXtUXwDXY4eI
         geAfdJKTv3OoMd8och+6XMl7/Og27y8bRSGOLWV/iL9AOOwtVCJ7i/iOAbBRVlBlmBxx
         7Go19dcDxjdV1CRnM8FIJ+1uYihiUtvFn4mKi36qJkE1y0eo3kPH+8KMuH8zADSStIgc
         V1OhkiSEy9uAuaIZId+KWiuO8VV0X0D9FFcpmeVL0sqYORBPAQ2Xf/hAz6VwyU5lfO4r
         FUBgdMCuOUyfYYIk40NMoNSihVqMdEZaSEhilsQdvFHGbSw2z5bb1jMhX2QgMj7F4PKh
         8BEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0NxN1BrbeL3G5szYaVia9JWyfAeOCvCAkAsSe3WYysh49UchR3XgCQpIyjneaakUhII/x/NbKVb9a8UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHLbqYahE3ierQ+hnwttttLGfGM12zR29/CXvItsJmOzsH3+u
	N97dkFuhq1tDnkEVRn1xb79/Kxn2D/1h7bhIiHGDd9EOFLUUOlGuUzCNRkPfOfhne+4=
X-Gm-Gg: AR+sD133ExAABwTr9LiMcyaKtvdWUNBdvsTT0Pwb5gTsI8Qd3RjkQDlgAp42nVnc2Um
	kbURo1gay5D1/UwgWCeRdEbSxRYrsViJ+PdA5cdEP8dRXjlBHd7Uw3SeMj42OPV1283kKawyNUw
	1EklX8COxNBoZiGArkymeTGsYh89TkiYxnbYXrDjLWkVGqPW9BaGfDG2PL9s8zLWMGcMgENvOme
	58ligSAH3f11cdkjncJpew6smDFMEJLY0f/uSOwv2gVbSn1ULigCiyG5iDUR9pJqyLzP0pWM9pu
	S9ZpT+YlSNYHsFA5eVkRSc4F6j3Y2mdkQFJVrI/AqopmI0nfnq9dWr0hEABBKKxEsIqV9f9mH1E
	Q/cizoMllXoLz6HwCu9F8n54BURQT02eEV3AQPtJsWSZVf46T582/zapSmdbPxNGV2qJNJZODoR
	AJWzCM7S+tD3Q4medH4aQAthzPBs1EKSuyI915LQ==
X-Received: by 2002:a05:620a:1995:b0:936:bc78:791b with SMTP id af79cd13be357-936bf90b78cmr572103285a.15.1786628978075;
        Thu, 13 Aug 2026 06:49:38 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b12344sm150528085a.29.2026.08.13.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:49:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuVoO-00000003nYa-1b6m;
	Thu, 13 Aug 2026 10:49:36 -0300
Date: Thu, 13 Aug 2026 10:49:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260813134936.GM662699@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811155022.108148-5-zhangyu1@linux.microsoft.com>

On Tue, Aug 11, 2026 at 11:50:20PM +0800, Yu Zhang wrote:

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);

Since attaching blocking does this and you set blocking as your
release domain, this is redundant.

The new flow looks alot better, removing the detach operation entirely
makes sense if the HV can support attach on attach

Jason
