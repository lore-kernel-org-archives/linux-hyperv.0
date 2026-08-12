Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44015437455
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Aug 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537840; cv=none; b=rC5SdvuJoNYqEqQikxv24UJgNU4mr5v49R6VWMbRnnNlXcy1+yYTC/4ROGlh6ZDwndhuE9J1cU94gwLyIJ4F0aNDdbWTM8wwTP8pvWZvUhvI1mZ84Kf8nC+nvVJuDkzA/vA0oGzScP4qL2Tn1VQA6vbs04yMzPBQDMD8HffM+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537840; c=relaxed/simple;
	bh=oPx8rA1LxifIFXbFQU3CUDbGAZuvNtfeA5eTxK6h5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX594rVIYX3a7/F//EOydbqq9P37UgczRMCv4O1MNsOtIYKGznFduLrcL899S/PjF/L6o0Cr8Rr7Sn3OcDEBOy7nIJylqQFWXL32xzBzGbHBXbleoI5ClsSAL8D3H4bjxCKtiornZ5jsLs6Z+eH1PYspuQKhbO15Ztwu2TYfG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K1DObIFJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K1DObIFJ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9349ad9c857so105820985a.1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Aug 2026 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786537835; x=1787142635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=K1DObIFJ02M62a8WH5OMJo0XF8ybEoV5IKOKtoneADLfcGcd6D13fy71m1wkEHHor2
         TPme1C5Gi2840NobPWnm62GXfVqvTuoIJpbQG6LQabrmCciRAXa8JcuDN2FEBfb0i4RI
         xIXCpHjhYiZhX9MRUesBGq7FdMC7env1mhQylwZ9AwtesKzAzUS3wQ3OqvdJI4d7XEmb
         0jghcwKcPa1OOLlHbuiZ3yTkW737qSSlrmuAB6Lsf8/B4Nn9TeVJZ3e99eayK6NAGkNB
         wv0JCbD6UAKa3rdSQH4C0Hd+jmFBTG86tQbpwlUoPCLGJtpLfaJbWUJ9bBUeiCYXG8He
         sSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537835; x=1787142635;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=Ec2QCnPSOWKAw/XT5uuv4sVAPuq2MEPfH0QT811Ald/HjeVlz3sINM3YiIR121ZDG8
         v7WLSY8uFnOIY5DYJ7j8l9X11cvGeXDtyi/nHSUdwGpnRY+HHD8VcPR0JO+pZ2tjG5L7
         wDq8uNqfzZau6lqNvquW3Kn9ZK7zoZs1KiKK8I1jFyzP/Fs3Pg/NVVnOFHU02SikQsjT
         LlUXpZXfxKzJgq7LONLDGfhKI/mlEs/5hczUnSNe864R424Wgyr9fdmMU0gYI16eKYct
         6OffyDiXJZzfvAsVLcfSZi9fdk8BINwZUMrNTiAgwJcI+00FsAWrHMlhRfQOOnrJY34J
         LRCg==
X-Forwarded-Encrypted: i=1; AHgh+RrkKCfJwHQfF3kGc5JcvxYOJFB/BZSU2IwadXAATp8K2ZpSQ1477w+bHJ4NeJdWU6LaqLHyHAurcbKHWPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmN5FR5lJWCwlPkrkcXmrT/Ei9eNIxpu1jxLs90gt2wu1tHYZ4
	haGL1p4SHQs5bvddhJGV1sewKfY41MiAiM8BZq7aHFPhKbSK8t3VcxK+Rzlvsg+8T00=
X-Gm-Gg: AR+sD13+Wt8TBIG2JZ7LAR4pp7BNENrgBN62AZrPhmEgoka4ZPGYfXfQL5Y60JS9OOL
	P454GSS7uiI9zyibEnt5o/Mb46FWGjHEOhJTgyrjwFp9fbLijxqJ0fVHLeES8PvzPhLALp2F0p/
	CkmuDSw0Lc8H4WnMS50ApJqbQij3Hj2GbltTQ31lkYczVYl2FHGAFAxB5kvnQYi3Dl1aZmmT0mt
	KJwL8pTfAemN8jUNDH49vslQHdUY9VwVHA+VBOXvJLoBjmzZy2RZEib9RYl3Ss24BSWeyt6+O3Y
	hxEFGEIB4ckP8P/6gc6sdVpmNQxP94gamjjwOqTy7u5e/hLFugOBHjlkKWUHitVy5Ng8K79klIX
	vyNfPowqnAacaAyKRy0nMS0pc+km6G5lqDPmWzK2IKJNihjG8cU92o4crvxej9uDEJtDNv/dWVH
	uLten/NUuZ3X9yhCEy1mNOuqGgkRTeIX/TVUxMuUwBpfNUie3F
X-Received: by 2002:a05:620a:4013:b0:930:e2ea:2881 with SMTP id af79cd13be357-936b3d940c1mr359405785a.36.1786537834756;
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f1388fsm117247585a.24.2026.08.12.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu86L-000000030Ox-0KWD;
	Wed, 12 Aug 2026 09:30:33 -0300
Date: Wed, 12 Aug 2026 09:30:33 -0300
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
Subject: Re: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved
 range
Message-ID: <20260812123033.GB662699@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
 <20260811162124.GK544626@ziepe.ca>
 <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>

On Wed, Aug 12, 2026 at 04:58:28PM +0800, Yu Zhang wrote:
> Thank you, Jason!
> Do you mean something like below?
> 
> -#define X86_IOMMU_MSI_RANGE_START        0xfee00000
> -#define X86_IOMMU_MSI_RANGE_END          0xfeefffff
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_x86_msi_region(void)
> +{
> +       return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
> +                                      IOMMU_RESV_MSI, GFP_KERNEL);
> +}

Yeah something like that.

Jason
