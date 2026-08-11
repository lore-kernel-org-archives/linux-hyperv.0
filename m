Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7C3803C3
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Aug 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465289; cv=none; b=ClFY2AxQfbY7Jaqaej/Rwl5k/O8jJ80LRv24ChKXywe2NTq1Cr3y95r6LUUGla4kkBTvJcrFa5N3xyXwO6etdh0xctIi5PfA9dXNbWKvBw8QkQ9r7tCSWkWAw9wRAP7zOnE65AsZcMivraliKo9AZ1JrQUDKff9qlUOHTzbH4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465289; c=relaxed/simple;
	bh=IzG7wcSnS0LX7TU2RQ1pHjEUVUk31vZgsIvwWciX868=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxev/oWsu3zCwtI8H34e/+/r7Ew3AMabud9393GzDKbRDqWOvCp9HUg0e5V12Ue0Dahn+hiP66G2FB64/hbobQ81v21I/xdntyeKp1MEI7K9DUF6lRb6AqrkXcXwLHLpbUriXO0/S/yP5NyFruCWeDYcfYRLnn6LKJCHXQopWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nKtf0pX2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nKtf0pX2"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52b4e988c77so766801cf.3
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Aug 2026 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786465286; x=1787070086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iF1EovNHXjlni8LKG7pfSf4Sk3EXbwMQtSznu/lYQFo=;
        b=nKtf0pX21rLJ0eVwVhCstxfwpROMM6okWF4T39N426WVApG1snKiQYcVNMlTjzWUiK
         dQ4wztoE2MzksS1pFar2VyvsLJswkX7iPZ5AZzuHFwgb2WTjOdx9YRSpIRLX4rxJWrsu
         YPsf+XqLc0BJbFBdf9KhOocgnpGCtf0AkGRaOWh7keCi1hjHSdERTz7hS83x0SHoKW73
         2LqtA4QB+V9kGibXx7zfQEBycSiiT2jKM+yker1PIy2aG65LqoNCaXLiojcXTPR958YS
         YAXcS8DRmDsh6hxL5buDuQtTtV/mklBrh9hfwUZG9wVXk7oVYs4b8piOh/ir9Z87PCJO
         GUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465286; x=1787070086;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iF1EovNHXjlni8LKG7pfSf4Sk3EXbwMQtSznu/lYQFo=;
        b=C5yRqVQu48yUXZ0AmjIARSG+QooOuMD6/EHI/YDOwBXqsJW9hy5UwR7+5aNkr0QV2O
         SRnl/N0Ak5tLrELQN+gRxn3yTtusOuBYxxTVysDpXdqi9f50erYvmkIHSu/X96nP89nb
         SxgqPiUVurgPwioH3o7p8JtXwYkifw35zxj80npaFEQFO2MkH0lshvH/mk9enb10ZLkQ
         JfzSqU/n23JhF+pfop2lJG9cKWdXt1INqRpc1vpJ/BUiumXRSfb5zT6m4fl7EIuuICE9
         uNKcKZxyEUBvXDadmMNVIKu6O4tMomFQdiqLe4TVIiqxpq77TePxfkWPiC9CuhcEuotS
         x8AA==
X-Forwarded-Encrypted: i=1; AHgh+RruBvQWQYDW5h/CzFwquSQImRPi7+WA5QoxfyouK4Ykl1d6wE4LRkNhLtyqYVNsiXCNwGaxsiCKbJdXON4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKs1mnDJk6i6hDlQvA1ZsjJem6ncu1/tbZgfxo6SjwBer6gsI
	a5r61zCaI2UUpaAVieszP8G8+si0/gpjsfRfWdH4KKcf0gYqDJbZXsAC2jGIFPriDwg=
X-Gm-Gg: AR+sD13N0KWiHWoFS13t4f3zk6eppIcsZBYyR7P3VQbUMrn948pboBR9HVnXQjFNjoD
	eEi5yAdYnQrrRTWhMjsV6AGoMhFMFkSxsuWtDj/y73kB2TVD64xSnAHB6ASb3hvrUM2WRkuf3HT
	+qj/XdK9OOvI2ELxp8rfocD5WqbP4I7UT2qyHste8fRYXOTjDAjk0E+BpQ40l88olRL75RVTw0s
	Xy0pUjINsMXgNO2lE7vQs6NDrQMucEdG2O/bay+9bi0uKJraOnwAFQpI/cUpOy/qeNyqAU/d5hX
	N0bppJ729hz2jKn1WbuXEcRsAk0l0qIZG9qn5INVYSM0yGyCRNoKdGV1WG9UJoaVEOLeqZoDunC
	Gwq4jmPmCEztffaijUyahrFjCLxk6I+NRbnEbsVnaIzTGzid4Cdovq/LugDAgmWEcqiPP9vsFPT
	YyGHKWSl35ZtMH/y6peIFlAIRAikOMrRRJEfgNpw==
X-Received: by 2002:a05:622a:4d43:b0:519:89b6:78b4 with SMTP id d75a77b69052e-52d5867e85amr44709981cf.40.1786465285899;
        Tue, 11 Aug 2026 09:21:25 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c39254fsm2441146d6.23.2026.08.11.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:21:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtpEC-00000002Y6b-1J1V;
	Tue, 11 Aug 2026 13:21:24 -0300
Date: Tue, 11 Aug 2026 13:21:24 -0300
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
Message-ID: <20260811162124.GK544626@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811155022.108148-4-zhangyu1@linux.microsoft.com>

On Tue, Aug 11, 2026 at 11:50:19PM +0800, Yu Zhang wrote:
> @@ -50,8 +50,6 @@
>  #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
>  
>  /* Reserved IOVA ranges */
> -#define MSI_RANGE_START		(0xfee00000)
> -#define MSI_RANGE_END		(0xfeefffff)
>  #define HT_RANGE_START		(0xfd00000000ULL)
>  #define HT_RANGE_END		(0xffffffffffULL)
>  
> @@ -3097,8 +3095,9 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  		list_add_tail(&region->list, head);
>  	}
>  
> -	region = iommu_alloc_resv_region(MSI_RANGE_START,
> -					 MSI_RANGE_END - MSI_RANGE_START + 1,
> +	region = iommu_alloc_resv_region(X86_IOMMU_MSI_RANGE_START,
> +					 X86_IOMMU_MSI_RANGE_END -
> +					 X86_IOMMU_MSI_RANGE_START + 1,
>  					 0, IOMMU_RESV_MSI, GFP_KERNEL);

Maybe instead of adding constants you should add a
iommu_alloc_resv_x86_msi_region()

That is just an inline doing the above?

Jason
