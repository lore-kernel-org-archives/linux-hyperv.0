Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617238;
	b=QYuJgbKgagys/eYPMQwuDWLO5lk8v/67NB4rINFfHgXsQtRBTISDFUgiPI8aAkuecs04
	 xJpyKsN3H7du6dDqRcnECgKz7KSzuEk+gv2TPPGykVkWzHsR3hDlOq3EHT0FPU5J05Jca
	 Gwd1jX4faiBIAUFWO9oFG2Q2z0kAZMFwpPcAdGC1KqxKBOXOJgaqlzEqa4uR81zLNium7
	 HuSwaWJc+scnjaKG0nAxiOrDsGytXa2OQGA+vZX/VBD/PkxDWs9+YUbqzc8zrRojT6ohv
	 zI4MTqYUagJ3H78z0zSu2RkgYX89YBv1+qZxOxY2x7GS0NT6D/AVQg6QPEgGTaokCLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sFWoksDl/YSxzzEgBxVNVr0WRDbY63H/etkwcboJjXc=;
	b=IfP7+6QEIiQ3Q6hAgjXbE6h4zrjNAFAV8ISyDYPmUMi8wSbwWAIbPpTY02YX4/DqGGaY
	 UzvRx3A0pzLVuJJNyYS8yU5mUggEZ/f4hZXDSUSeOSqWABOEbNq7dnCTDDOQsIlTLkKkv
	 E+otGhEXtzUUa9dAjMcYZd+YEORE/L4sye+ku5xoVSrqlH1GUHIykJ6IQvlthU6guEt2Z
	 TNzSH1XjVZgNSfi8U6xlNvXmdZFxzgAKnmSE0K3wPh8c/fpe+Kjrk0s5JYWToMB0kednv
	 23/0CUSAUjBmUQjjsnUuxxB43arRno4BhazOpIzsjiEbGPURUydtL4HRDDzSP/kJxhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="XyVZZ/6K";
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD95606A335
	for <linux-hyperv@vger.kernel.org>; Sat, 14 Nov 2026 00:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BD95606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XyVZZ/6K
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55c38cdd5b7so5963461cf.2
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 16:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794617236; x=1795222036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sFWoksDl/YSxzzEgBxVNVr0WRDbY63H/etkwcboJjXc=;
        b=XyVZZ/6KHgc0SnAGhE+nOZT3P9/3caLv1SztSB6O2DhyUct31m2H81KeZbaxWc+Zmn
         7k2OwX/Ma+HdJuszhMMdNkJXat+n16COGEcTCx5bNb1ZQrZSWmlWpiBt8f5dVsvt1JMF
         tunVJ1m2XvNvp15U1ckHW6TCWGKpedOGLJdky4LUtYG2x2h+tccel23tRwpLLr5JvhFK
         8laFbFmYY73/CBmJAehfl6Wqj+aqqeeUoi6AFJejktEiRZpmcfF0NBTZgluDudl4AC/E
         KLNkmLxCqYLfhelws3lYkG9uTfja/letfAbABE5f0F4PDFyCxdFWN0IpjTzmeqNHC3v1
         qTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617236; x=1795222036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFWoksDl/YSxzzEgBxVNVr0WRDbY63H/etkwcboJjXc=;
        b=hHgLVyt+vmWMcoC8NBE8sVagpSYvdG6xAufD2adE0PU1wHcPUP+Y3asS2ue7hyShq/
         NqMDES7lEtEjx/h61bS67+UccFV8snFNBrtxOeRXNYIYFEiRn2I5V4FPpdzmHTDwHDUi
         CBWChcgpCX6R410ZZyk5ZS+OmBa3Yv0mY9Spn0P6wXGsVROOB0FiYvgAqIxs5os3FGkP
         ExEdg7ehTpM97GiBij2IAOLqEN76JVyl8FM6XkJGJGKYptbvpA1coaSjVvnjLUmzkaCF
         eLiAWLmElSu2DOexr13lL/GelnHWvgkJR3E41jLubNM2BOPTBL4nfqsld5aI/7jV10rl
         Q0NQ==
X-Forwarded-Encrypted: i=1; AL+hErHFidQdhPUq2+hXHYAJ90XAxBF349I9tiLkhtt4SuqxSgdraHRvA0JDwC+4L6K00Sb872RhS5q0xsPAPmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EVx7S2L8scAmYGpi+WOJO/vJ79+QSglQ/upMP4VP29NrQcGZQ
	7YKdpneIff3osKYfc4OUlvroJBNC3EBvK2uLmZf+sftAH6eV53mJtj6W4TICXcXfoj8=
X-Gm-Gg: AYBFou1yJcuY6Tbx6lywSrBGMw54ESQJTa0YgHIO4dH0o7nnjh1pEMYAOIKeLIr5lK8
	N3mYUkj5sjjY7Ii7/PR6sXUotApD7a9vhTl0n6Gk8hu/fn6sANtY+Z/BaFIoBYYX5HAz2pFo18d
	hZ/kLPCY2ql52rdU51bJIYWW+7uosgqifnl8uOxKu2O+JtE4HfHCLSWZJ5ROpRTdMjA9kDbzYby
	e8yiEf1mbvyg6vyca0ZZq7zFt5GSf9Wjwqvnws/ddMh17BIXg4puJOzH7ANaugg2bM7KRmCXs2z
	X6ZHLYYUm/Gj3K7nEIk7nDqKjoqBovFyMB+Z2PgkHWHqNf9H8EF4j4pykShBnhf0goJ59h7UZ6o
	nBYTkqT/DwUzgGkP8/OMAiTlsYP3ctL73bAE21MvA4kEpX5g6fFqZo6xREaFXMrrexeNl6njPkb
	e/pu0LyHLXQYW7J6r+yTgI7r0XrVpU2HCQN8LtwdtsevzXU611zyZoVw8h2cFOmbqXmOBbWHZrG
	fklhZ6TxsVni1N39J1lxQN+H7aak7ckW0jb2aQ7RPO0qPZUNHti3mUSqhrMlVDb/2IkksCZtWVZ
	wY8KUg==
X-Received: by 2002:ac8:5c85:0:b0:535:a5f8:a5c1 with SMTP id d75a77b69052e-55aca875ecemr64665691cf.65.1794617236082;
        Fri, 13 Nov 2026 16:47:16 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2006csm30002301cf.10.2026.11.13.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:47:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xS1vG-00000002SDe-0c1E;
	Fri, 13 Nov 2026 20:47:14 -0400
Date: Fri, 13 Nov 2026 20:47:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/hyperv: Keep a new domain's page tables if
 it cannot be deleted
Message-ID: <20261114004714.GF2532299@ziepe.ca>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <20261112195710.1417744-6-oss.patchbox@gmail.com>
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
In-Reply-To: <20261112195710.1417744-6-oss.patchbox@gmail.com>

On Thu, Nov 12, 2026 at 02:57:00PM -0500, Yuho Choi wrote:
> When hv_iommu_domain_alloc_paging() fails to configure a new device
> domain, hv_create_configure_device_domain() deletes the domain again,
> and the caller then frees the page tables with pt_iommu_deinit(). If
> the delete fails as well, the hypervisor still has the domain, which
> may already point at the page tables, and they are freed anyway.
> 
> Create and configure the domain in hv_iommu_domain_alloc_paging()
> itself, and leak the page tables and the domain when the delete fails,
> as hv_iommu_paging_domain_free() does.
> 
> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
> Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
