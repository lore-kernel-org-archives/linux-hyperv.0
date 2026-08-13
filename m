Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1939381E86
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Aug 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661192; cv=none; b=D/udXe5OJIPBKZY7OFcljO76tW3cxpbXR5dqsSm9qnAAbmxoypl5F7WBFIQuHy6yj5u1OOmYO4SnTI+zoOtpIDj13hO9ymvnOasAhqNbWfRlWAvAxsWmtzaudL/lLnJ2jc2pcWW2+8NQdEDKqys3K9t/6Io/A5svi9KOHSqUnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661192; c=relaxed/simple;
	bh=i/6Jol0HBp5RRTvGHc5apFk8jhMg7iNWk5RSz52dbzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONHfCf0X68/7P7gEqWcVVYVc7YWzjISzouCOLXxh3Fr4hWCF1881BCYJbkwHolzpil1Vw1uQmdFsWZ1LKJ1gBU5hqJ6vl5AZhUEX/p9m2cOWVMFBJU0oxTr6/6ehsPDfLhA5VW82HTA6EaVd2Q3hGaemZQyx33zXgkrNP9pTN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GyRDrHzM; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GyRDrHzM"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e7632b193so28637885a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Aug 2026 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786661190; x=1787265990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5MtttmxZUrUNaLZLU+CiS25EBYvth90JdQ9xwh2RPo=;
        b=GyRDrHzMJ7bZyxuYZiASbi/fS/57YYoi2CZ7A9Z5GilQcrSSP3X4wNczxRQuqgfgAX
         bjvJ26TknklFhb/B8EES7F0pwa1ygSXvcSCJ1qZCASGQ63G3Ewr7Bma/3yLsur/laeko
         L+LCOJ57ncnnseSY65cXCGkXTYMf2MM8Shd6eQ9mVRxDYGC1SFBMXzsyq3P3up44E2P3
         gLhDE8KmU86bIkcNdrO7qyID9o10viZ30EV+Hp2GcWmIIl00KHMD7+W+UWTu2Y5L4PT7
         Nvv1X8tRBMgNgv1/2lxLsvdxV/5IHiRlyXMYBQqlT1e+atfxZYIgRlz/DKcsqMaxUVzS
         9JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786661190; x=1787265990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5MtttmxZUrUNaLZLU+CiS25EBYvth90JdQ9xwh2RPo=;
        b=nFxuBeuvNUJQenCQlxRCy5dfQWSK4kv5yvDnK/qHTi7dzls6B1hk2NmahnEqKUb+av
         WOlFUecg7DtA3/Py3S7JbN8AFGfeUZV9FEyQ3D84eyLOVjvipGC/y+/z3iw6akPH/asV
         R7y7yQuVpe98x/yoBRvCrtUWgR52BSd7h4piD50sGxpu5q0KCj+E2SVZUNaNaQjYvIU6
         460qWPH0TMxl2AG4zVixklDDs0PEMdovFO1s+eqvqfqkahymJ2tEEPWYP+MRXnq52KRC
         IXu1Fslh5eMs8r0BEVOyvzqTgwtcIRfWfinJoBWpbU43YB/24nLr7ou7Ftgobt2Exa27
         621A==
X-Forwarded-Encrypted: i=1; AHgh+RqczBOCYuHQXJRnJ3aItNlT1y0RPitJO9P0v+/S3Uy8fI5MT+dntmoxW8njBSBP1Z089wwkGKSZ3j97Dg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrMwnRE3DCv/Gr3tbRv+QMSf1ygXDfpY6hsDIVgiDvBapQ2OV
	H5KD+K83fM0VNiwvGNT6aAc/51vUkA814/F+t3F4jzd50lD7rlhgEt+kAwIA+rEs0xE=
X-Gm-Gg: AR+sD13wipapLwj8IoIBZuJi9Buy0ATop126vceSd07Yqqt3+MyB6zF4g5SbCImKHgk
	OSk3U9ZkBW9t/VQfJFqpUs6ZJn7Gof6EYSZ4tPSSVVjhHHtE22070VR2FFm8ofkV3e1YgqGu/Rk
	75blBRNFkgNk6P/c3/uUqhYrzh1y8VZn7t7A6qOlHVLAkYi2cg9FHRVB8DcABsjDEkPwoTF0kV2
	nfs8V8YX4HM19xfdUy4hXD9z3zJTYIg6f+xGvudqME6mtYOznf6AuJ141hCClhzTlIfrfjC1v71
	3eq6DhaUtTfkJ2u7r8YYUS5uOnbYWS/3IFboc9bU2O2IC4ZS51bizNGZcA+atmB5hRd+g5VtA4R
	n4OvxJ/VB+lwzq/4eWOO0DNR9LRJ7qxG61vAsJXOuhzFWGMHzMi1oY/gB77KnviAbAvlBr4YJ5/
	fXZnzxpR17Zs1YSMDqyZG8+aJCWm7JmBSGjsYPXg==
X-Received: by 2002:a05:620a:408c:b0:933:ada:c3b2 with SMTP id af79cd13be357-936d2382749mr132987985a.34.1786661189637;
        Thu, 13 Aug 2026 15:46:29 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce245787sm96424985a.41.2026.08.13.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:46:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wueBv-000000042QP-14bA;
	Thu, 13 Aug 2026 19:46:27 -0300
Date: Thu, 13 Aug 2026 19:46:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260813224627.GA933791@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813152913.00003d8a@linux.microsoft.com>

On Thu, Aug 13, 2026 at 03:29:13PM -0700, Jacob Pan wrote:

> > +static int hv_iommu_blocking_attach_dev(struct iommu_domain *domain,
> > +					struct device *dev,
> > +					struct iommu_domain *old)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct hv_iommu_domain *hv_domain =
> > to_hv_iommu_domain(domain);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int ret;
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> > +
> > +	if (vdev->hv_domain == hv_domain)
> > +		return 0;
> It may not be needed since the core code will check this. If you keep
> this as extra precaution, should this be moved up before ats? since ats
> must be disabled already if blocking domain is attached.

Why check it at all? Is there an issue with attaching the same thing
twice? Will it blip the DMA or something?

Jason
