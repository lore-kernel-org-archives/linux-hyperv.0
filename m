Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580247;
	b=eoOGQkOV56kFxeQqDdXrbExuaNm5qzoxZb8jQ+FIAsMWO47IpUzepcD+4p1TtKH3//bC
	 SEBN5p6O6SuOv38NHPYMaL2RwvX1lFjr1Fr33Jc9eybcjeth3WJtFMAyEXhEvgkT7oX3J
	 hpOoXWmur/mWNLEaPimKQkQAtcaCG1mIsEDL1FbrzBOZftkLVOVrJo9xsX/fG89JJgNQt
	 wXueRzrTmqeDTGqtJvf+RvpiUqc2z0Df2uniaDNLhj29hnYXGdv9piVNhiEEMX92wzlmT
	 r4yZuLAOg95quc9C1lXJcRBsMdLgR/CG4J/7qluwkvgknET7SG0eHdZW8HmkBM4v3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
	b=kEx4eXUn8tVue0OKUmhFYPvoDkBg8A1L54Z/kmMvPEGhTTbVhLBaTo0E00U3zW2VghhX
	 6OWxsco0oyV5n3C/rtRJ3HLT3SMvwY+qGuUalK8ceed4GboHeH+XT1hY7xEsKb5tiDw/+
	 hxFgUv1u8v5cU5BGIKEPz+FD799COnc7ju4jOjjVxNmQ5rx945DDp5Vn0RB0hJxy0q7ou
	 W1YcRQVoVxiPXd1o/f+11ymgIFt27RnSj1P9G2HqxK+sXgLpse140g3iHaWWCzMehOZ2M
	 T4ZUqnRXKFlmHSr5qoAaQ4VSHoGQbb9Awet54NQXAjBaIRaWe9RcQnUsVcpBwChtw/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K9FHrqLd;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D55606A31A
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Oct 2026 10:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D55606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K9FHrqLd
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1d2ec9aadso39105e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Oct 2026 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792580245; x=1793185045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
        b=K9FHrqLdKhEKTusfXH7+g6zbV+wQLcZ++y7rAvQ2nG+6gY68Z9U0wraZDGIHwlZiqg
         CmU++vYIR4Pg78vEHbkfdPvhIh7NMBf0Q/WjP8v7rmWVUDHChPaLm+4FK5thfmMVgwJv
         ngOi0+0nMoy4H1VKj23048LMLW4VKeOaIu4dL4ow39wAsfI6JaesFn0VN9Ra2UtaeZKe
         POdMzzd3ZI2zNEoMLIRN9gbE0Wkq1QlNes6pnFNKRd/SeUFrsx4+ut6Yhw/NEV/JVRj7
         Li5DFR7/usK9MICPN7eK/jigisQnoaTX2kMvy83XYuwLHtfmSWr39nWUFzzKZ8gcxjJt
         jIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580245; x=1793185045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
        b=Nd6vXcMKgJSkhkY6cESOS2uHd716e8Icmd7Zek1sC2lne/Xuemds3Cvl9BmbFfnFWD
         ZDsocSnNpRjFn24TQrPhN1h3glCrzUPE35VhX2n1zn8IYwHQ4WUUQqCf9PCEdmtHTFZO
         HNmT71VfzqOgzem/M1yGCiF8pLDdyCuXK6tpvt3jSLr4zmp026iVaVGL5/q5ZASWNy+y
         fdo+JNbASUkZ0C7+XPwjNHBDujCPzLcKGC7Zt7IUPGpBia+EJKU7ML5HaTtbSVo7mhOr
         eTtx1MT82Z64yf8CwfC6AJ8e771hhijmxkbAIuhc6GupNDEmZAdplMiQkC0HwrSihgd1
         AdEg==
X-Forwarded-Encrypted: i=1; AKwUvBzfll9wFXwgmGeuJtFeORN4k5wKn64t26iit3FoaWDzJpVKxCdHhmVfBedqKROIKET47/z0Ox57vI5yDpQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPvgA+7fhy97OrtyWQfITy1NsCeG9QG0ERYdcMe4UIdMsz5tvm
	KLCsn/HAaHVO/7St+F1Anyg/NiTh/7CyctwirruwQPk8J6jqL2779oF4H3ZLqEGuwQ==
X-Gm-Gg: AYBFou3NZQMoSrrpo1ddsPwsgmmrDv6D5nHh2elcgJNBPJkg7slLUbAgvRMsgWW+1fj
	/D8af2j2LVwPW6vfrfRMjDgYLsfO4he0NE0r+lDvNb+xSFhVNLk/dmeyW/GCElUmmdzJPY6vCqV
	Jg5CaGcsMcap0Elh3jb1G/g37lCV6FkApndfIZVyMzuOTe4uA7okT0EyQkDgaXtFOelB2x1UKTB
	IECXvhVQy0fhwuoYsKghgELG2AFy+pRVIJ4WMsA8BUjJV3Rq5OgTQS1tAcj/nevid7IrWTu0ZXJ
	vUKXizd0jYs7/mGz7WBVLnqkM8OagnOJ3Tbg3KWPs/UzxldziJzKo4Hq39/s4xGSxg54PG36QAT
	Zn4cFH9lCTMDsA3b84lCW7MtRnECBKUOA6Ml6ySZczrdAc9YxP986SjMpAqL2ivdij1BcZOqgzw
	2OvmAq6aB5J9OCXS6QSN/hUC8GdeCxrRIi7UKFTScQ9OovZvBfmrRJBEk3GMyot5hgvhrlcqg+I
	06j/F+VGMfpHaoQLRpdKuGZnrc+iw7LsINaMZMLu8QNr3cm9zA8vPE43x3vJB+bqTs1mwszXjMu
	OD8I+cFS8geWTbisHit6gE+ZRIHrnXWS8lFzAtnuAOex
X-Received: by 2002:a05:600c:a3a5:b0:4a1:a48c:17eb with SMTP id 5b1f17b1804b1-4a1f59a5836mr1496985e9.11.1792580244647;
        Wed, 21 Oct 2026 03:57:24 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm104658535e9.5.2026.10.21.03.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:57:23 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:57:20 +0000
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
Message-ID: <atiakDqtuED2cTM5@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
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
In-Reply-To: <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>

On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move or
> attach devices to another VM address space provisioned by an external
> owner, such as a type 1 hypervisor.
> 
> This is not a paging domain and is not sysfs-selectable as a default
> domain type. It requires external owner context, such as a vIOMMU.
> 

Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host never
inserts any mapping?

Thanks,
Mostafa

> PV IOMMU drivers are expected to use it when moving a device to a guest
> VM with an already-created S2 IOPT.
> 
> Assisted-by: GPT-5.6 Sol
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommu.c | 2 ++
>  include/linux/iommu.h | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9a..d0bd3ef00379 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -220,6 +220,8 @@ static const char *iommu_domain_type_str(unsigned int t)
>  		return "Translated";
>  	case IOMMU_DOMAIN_PLATFORM:
>  		return "Platform";
> +	case IOMMU_DOMAIN_EXTERNAL:
> +		return "External";
>  	default:
>  		return "Unknown";
>  	}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ac43b8b93f14..ede77b90f0fd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -188,6 +188,7 @@ enum iommu_domain_cookie_type {
>  
>  #define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed address space nested
>  					      on a stage-2 translation        */
> +#define __IOMMU_DOMAIN_EXTERNAL	(1U << 7)  /* Externally managed translation */
>  
>  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>  /*
> @@ -207,6 +208,13 @@ enum iommu_domain_cookie_type {
>   *				  represented by mm_struct's.
>   *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
>   *				  dma_api stuff. Do not use in new drivers.
> + *	IOMMU_DOMAIN_EXTERNAL	- Externally managed domain for moving/attaching
> + *				  devices to another VM address space
> + *				  provisioned by the external owner, such as
> + *				  a type 1 hypervisor. This is not a
> + *				  sysfs-selectable default domain type; it
> + *				  requires external owner context such as a
> + *				  vIOMMU.
>   */
>  #define IOMMU_DOMAIN_BLOCKED	(0U)
>  #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> @@ -219,6 +227,7 @@ enum iommu_domain_cookie_type {
>  #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
>  #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
>  #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
> +#define IOMMU_DOMAIN_EXTERNAL	(__IOMMU_DOMAIN_EXTERNAL)
>  
>  struct iommu_domain {
>  	unsigned type;
> -- 
> 2.43.0
> 
> 
