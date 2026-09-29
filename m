Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7C4E13EF;
	Tue, 29 Sep 2026 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717146; cv=none; b=oyuZWXC/qse7sjLocT7oDcryzvVpHNoFfGF8/uYgGFAjFdeRxzXkW2Bw9O0fEAYBsCwE3x8sVV004ulh0tXA0ARbFZnqLBuz2jBOI0ZwfFbFKuHdCnKst2HORWJQjZBPV+WTriTYP2/eHTLUEArG2TwmTZRdCAf9fI+WODEsAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717146; c=relaxed/simple;
	bh=J3aoHidNLwIQXT4rllO1lG2m2ABVYl/SETOziV8bip8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcQuBQIitOkrzEFe/hIyizMF29AhZK1HwK5jwhxVvzp7Ea5CF+Yvi9Q8dXsaZtmFTOmGEBLay44qFUGJ7nx6bMLtr1S80LQs67Y3GZMiEl7mzdubYdYWEGdc/aNKMU0OBCSu7e5udiydc1ZmjkY5CRp53rPpoI5hgnHnlsNX1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HuQPKTIa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HuQPKTIa"
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5465E20B7166;
	Tue, 29 Sep 2026 14:24:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5465E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790717092;
	bh=qWV/+kwDScxqWsdgmvbejHverx+0lYJpag1/QdsRBs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HuQPKTIaFJGP4PMRVWOu5L9lsJbCNytzk2oZd3QqTnRFBTocZxb8MLXDaRbM6G2Kh
	 KG9JI4yMM83Cr3VygrrxK3oIPy8lnZsK/A06v10LMHVU/QKClNy/7+6MvvqD5Z2B9r
	 Gcf5dqXDbgrJM0C+vcIN7W9dTs7oSU9Wchqmhj0o=
Date: Tue, 29 Sep 2026 14:25:42 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>, baolu.lu@linux.intel.com
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org,
 wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
 kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
 robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, mhklinux@outlook.com,
 tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 mrathor@linux.microsoft.com, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260929142542.0000575e@linux.microsoft.com>
In-Reply-To: <179071228738.122959.14326374887826159868.b4-review@b4>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
	<20260904075512.174154-5-zhangyu1@linux.microsoft.com>
	<179071228738.122959.14326374887826159868.b4-review@b4>
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

Hi Jason,

On Tue, 29 Sep 2026 17:04:47 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> > +config HYPERV_PVIOMMU
> > +	bool "Microsoft Hyper-V para-virtualized IOMMU driver for
> > Linux guests"
> > +	depends on X86_64 && HYPERV
> > +	select IOMMU_API
> > +	select GENERIC_PT
> > +	select IOMMU_PT
> > +	select IOMMU_PT_X86_64
> > +	select IOMMU_IOVA  
> 
> Should this be IOMMU_DMA ?

I agree. I guess we should also delete "select IOMMU_API", since
IOMMU_DMA selects both.

Noticed vt-d driver has the same option, maybe it should also
be changed. Baolu, is that due to historical reasons?

config INTEL_IOMMU
	bool "Support for Intel IOMMU using DMA Remapping Devices"
	depends on PCI_MSI && ACPI && X86
	select IOMMU_API
	select GENERIC_PT
	select IOMMU_PT
	select IOMMU_PT_X86_64
	select IOMMU_PT_VTDSS
	select IOMMU_IOVA
