Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800B53ECF7;
	Thu, 15 Oct 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078181; cv=none; b=abTYb7I9yeyht0rag4VTTlr7fTFGVJ7qvqd+KF1AQw+NKKv2Rguyf5J+JMJsUt+INR6EIo2Ape98u4B6a1P8qRz9o6XLtYZ6K9+FifhD7sIMSUmIPwLAD32UKpQjrIx34uqS4QpIROAAA9QmlGFeo6zaGHo3qDCJDVZ+ov0TP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078181; c=relaxed/simple;
	bh=+GWrO2FeIz6rrTJHswCKO4k2txZFmM6DDFYIGY9noIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGjBPxaaSzfrZyrdMHOhRUKwwty5RDvu4ubcrB4QWjp+/yaffHKzkknGSaHPnskAY3szdbq4KDxmIZ91KzIacNeX+LrT5JDKf/9ab9mcTNjAsxSuGHu+IqAs1zap7skRXO48CRwhDGvNnScks6+oEof7hihUSQS0+ojmJn6yQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lfoiFXm1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lfoiFXm1"
Received: from localhost (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id E508320B7166;
	Thu, 15 Oct 2026 08:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E508320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792078170;
	bh=WIRiLY78LofOC9PUW1C9DDSopUjC+PLAsMbJh8TcaVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lfoiFXm1Atn4dzOHOCiRGarRswJRg8aYg22uflSaRYNCm0RCxY2vGIx97/FPsbHd/
	 hGu+SLJ1v3MYS6zKP8+q1zX6yC24ciXB7AYNLdIp/rvlgAtQ25KJPOil8Arb7E5Dw/
	 iUdkOjoTdj3PGWmast/vO/MNLd4FaH2/eMom4ZaE=
Date: Thu, 15 Oct 2026 08:29:24 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 joerg.roedel@amd.com, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com, mhklinux@outlook.com, wei.liu@kernel.org,
 easwar.hariharan@linux.microsoft.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 0/2] iommu/hyperv: Fix guest IOMMU build issues
Message-ID: <20261015082924.000009a0@linux.microsoft.com>
In-Reply-To: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
References: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yu,

On Thu, 15 Oct 2026 16:23:49 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> This series address two issues reported by kernel test robot in the
> recently applied Hyper-V guest IOMMU driver.
>                                                                                                                                                         
> The first one adds the missing PCI dependency to prevent a link
> failure when CONFIG_PCI is disabled. And the second makes
> hv_iommu_device static to address a sparse warning.
> 
> The patches are based on the hyper-v branch of the IOMMU tree.
> 
> Yu Zhang (2):
>   iommu/hyperv: Add missing PCI dependency for the guest IOMMU driver
>   iommu/hyperv: Make hv_iommu_device static
> 
>  drivers/iommu/hyperv/Kconfig          | 2 +-
>  drivers/iommu/hyperv/hv-iommu-guest.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
