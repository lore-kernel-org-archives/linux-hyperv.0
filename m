Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B293D7D65;
	Fri,  9 Oct 2026 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535125; cv=none; b=aPxeFk5+LNSBmrlp1TFGyoRW8wHek3f9Ikm3tS+6gOPk4ioTjpxBnCDnyyaYGe8Nezi3W+boRkk4iIsYe/sYeZ5/ZSEkU2+5CRB2hlcgncvoQw6cyA8MLIqEN0qZ1Gh6HDRXyIAedhVd3Gascs/nXh5YGHGCVd5rTuw9K1dXWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535125; c=relaxed/simple;
	bh=NafflI2qU1mbJzMzappoMzuz3Rb7ioFBX6cLoRfAlmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZuuYbDDJMK70zt+T0/6l1Pjv+ljlEw04HsXFqZaq0FBHxd/ilU/TPzuXELf/wNh4BI7sXsrhy6Qgut7yzBr3tEoReJ+hvcCDgnYbBTCFcHL5GWKZFm/LLRHb/xmH9L49NgHY98xV9UG+uGv4pD54AHcS6MHtDp2z4TJ4hTpGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00448550d0471e54ea.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:4485:50d0:471e:54ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5249A1C77A3;
	Fri,  9 Oct 2026 10:38:42 +0200 (CEST)
Date: Fri, 9 Oct 2026 10:38:41 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com, 
	kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, 
	arnd@arndb.de, jgg@ziepe.ca, mhklinux@outlook.com, 
	jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, 
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v6 0/5] Hyper-V: Add para-virtualized IOMMU support for
 Linux guests
Message-ID: <asin8LidKSJrn8fM@8bytes.org>
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>

On Wed, Sep 30, 2026 at 10:14:04PM +0800, Yu Zhang wrote:
> Wei Liu (1):
>   hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU
> 
> Yu Zhang (4):
>   Drivers: hv: Add logical device ID registry for vPCI devices
>   iommu/x86: Add architectural MSI reserved region helper
>   iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
>   iommu/hyperv: Add page-selective IOTLB flush support

Applied, thanks.
