Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF53C3789;
	Wed,  8 Jul 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509136; cv=none; b=jizHoz26pqmpYwRYjE1/fi9UCUQiVT6X08Z28Gu0i1wPJK5sLfMbDnrPwJKZUfXWS5LTeMX6ztUF7RTMP/CodUhDPbNY7WGNY9YDuHxSoXBAmpUXSXCe9Ihu3720JZKCnDqSJN8xHNJGSqJtAZifRusLxd4b+KceRNUlOIeQcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509136; c=relaxed/simple;
	bh=OuMfLhhtVxhkxpTRqii8WR2yk9dBwCiWIHHcEUiT6mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2hN/EbBghXuXaFukFoZhIZbjtMXUnnmsG1UE6U2JttnxAhWgaWgMhrJtRqw7fQOBaO3QTIMsuYwSpU19t+A9NifGRaVf5wQMZdQgpS7Cgyei93SaBdI9VUBPg8EfixLeTd+dTy86DCz0N9mR9kAphJ/5pJdk6lquNnvFghopHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WbUfEPls; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WbUfEPls"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0975E20B7166;
	Wed,  8 Jul 2026 04:12:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0975E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783509130;
	bh=MWHeIrHVvdeyOR17VgK8TXqyJfCBF+l0EJcRFNNWH3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbUfEPlsKlRUgkS1C2IUX7W8uWkAunW3TBh2vj+87fc8uiYr6ZQIWJEUC41euQAs9
	 S+RQItJdS4azQKFTWjiTmtgym5Rtd2a26wcuvyALIgJPTkL9zWJK1hr7WzHi52Zq6W
	 nU0ig+wwgnIizroBnysee5qHeOn8L68xMrC2ZTjY=
Date: Wed, 8 Jul 2026 19:12:12 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, mhklinux@outlook.com, 
	jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <dsaz4wwew7qugja45ujb4igafccmsrrin3ab7r6rlg4dp7bri5@eq4jfula3bgy>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <8e688b47-eec6-39eb-e4d4-91700edc2e3b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e688b47-eec6-39eb-e4d4-91700edc2e3b@linux.microsoft.com>

On Tue, Jul 07, 2026 at 02:17:02PM -0700, Mukesh R wrote:

[...]

> > +static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_stage)
> 
> 99.99% of our code is80 cols, lets keep that way. someday we can change
> all in one shot, until then please avoid line wraps here and below in
> ida_free(), hv_iommu_get_logical_device_property, etc...
> 

Sure, thanks for pointing this out.

B.R.
Yu

> Thanks,
> -Mukesh
> 
> 
