Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781383E3177;
	Thu, 15 Oct 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079562; cv=none; b=hE5Ee2cOBg9TBFCwHUYji0H+2JRjSlg+qdLgVqaT8knM+P5g4ugUvvut8bAOxCWBIcikKT5UvnzOKWu4ce2InWslh8ZaX0bOxQNzORj/XawvEpJmmP/+t/tDRXzfe0oF00OSMW7PFwiThwM4+iOMIZPM82qWTmG2/DlaV0bYxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079562; c=relaxed/simple;
	bh=OOsEYilQaN4m+yMZzvn0O4PMiWmqqCrym5pHcxb8hGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMdF+jXITqRYxEaNRNjocIv/nd4dkJ/sDyJuw0d/wWeQTnBNUsam+M/r0p1JEutpzYM78qUsZ8D1vjbj24Ve5cHMEL87OgSw4ccpBkW1CXclV1CuV0HGh9OjRYKUIUCng+e2DlV0siUYZpsAympwqqiivGRCs9WVcxOTqjRZjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00bcc634c34b045ea0.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:bcc6:34c3:4b04:5ea0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BDF1D1C7802;
	Thu, 15 Oct 2026 17:52:21 +0200 (CEST)
Date: Thu, 15 Oct 2026 17:52:20 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	joerg.roedel@amd.com, jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, 
	mhklinux@outlook.com, wei.liu@kernel.org, jacob.pan@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH 0/2] iommu/hyperv: Fix guest IOMMU build issues
Message-ID: <atD2pAZd0f9rwvTz@8bytes.org>
References: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>

On Thu, Oct 15, 2026 at 04:23:49PM +0800, Yu Zhang wrote:
> Yu Zhang (2):
>   iommu/hyperv: Add missing PCI dependency for the guest IOMMU driver
>   iommu/hyperv: Make hv_iommu_device static

Applied, thanks.
