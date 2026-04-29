Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A723E0C61;
	Wed, 29 Apr 2026 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459000; cv=pass; b=KhXQ624uEVyG28GZ/Gq57ZxY0MrJl8uXy2vOyGaqAE+8CleiL0FPLqa0KutH8ErRTtNwxa2m77tasYzbZxq9JO39rEa5NXdfyMRBT2IKHXpU9BgDmvm8YwSN6IEK9d+D/z+PGL/JTMfALIz4G4gfqVaFGkN/llWW1cbim+wFXsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459000; c=relaxed/simple;
	bh=wWsgI55T2IIdII2886fM0Y+D2bDD3d/AayrfFLAVrIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGeshlLDp8IVJqtr4HhHibLR3mcFVCeczL/nprExr2JSUDIkWe10FhEDyrCWLksOOtEpfsFKJz4oPXfT1V5WWmcR/Kt7N6Ie43xpPMMT8vV0PGac67JjsVrtTkF3xcRW3gDV2rX1ACH6PiRnZsw2J06EZdT6DMij8zI5BKdFM88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=T+MYPJcl; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="T+MYPJcl"
ARC-Seal: i=1; a=rsa-sha256; t=1777458968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S6Oi1Mhyn7HSEIlQZ9NQ+85YldW92YeyhctFkYS3PpffytOc/8sLu3tr29aehHvNJQTbdTuDI/ZnxBEDviRKULb/2Qh/5lSTlTuMf1sksWN4UcIBl4Jd4rxUkY1R+barhNRu2E8iK3KNTKZ/Z2pIZ4d5/OkvVPDRH+SpPMhxkr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777458968; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xj/9h++E416HVc3sW+ej95YsGS2ZgLD3ML/lfDNu5mw=; 
	b=IILA7pZin3aP6X402//pPOBXAjLFHFCRk9h+dBon5zvUFOcQTyXVIGczlINRmxZuonqXPTHrBacbJKBhR4MYu9gomwBtDtRx8EHdonYr3HQoZ1ur28q8lxNm/rxiGXcYiQjGC1ZT0/rIsz9FdbyS4ma7VNunAzntCB00GZ/hfgw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777458968;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Xj/9h++E416HVc3sW+ej95YsGS2ZgLD3ML/lfDNu5mw=;
	b=T+MYPJclCboEFY2K75ze4MtY94KGcSs0Ebeb670CPu5Y4If7R5RFZPfLHKoEcvLD
	CUX0ZpNpYQmUi86E94MJeBknmbwTId0QoQEddCUXhC4abLVcq/+hMX2F9x3qxDloMm2
	YBbUKZXfmYErqwF79jT1WoARSFDlyOPqEUzr7fOY=
Received: by mx.zohomail.com with SMTPS id 1777458964961585.9652544116735;
	Wed, 29 Apr 2026 03:36:04 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:35:54 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V1 04/13] mshv: Provide a way to get partition id if
 running in a VMM process
Message-ID: <20260429-pristine-unyielding-magpie-1ce6ee@anirudhrb>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
 <20260422023239.1171963-5-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023239.1171963-5-mrathor@linux.microsoft.com>
X-ZohoMailClient: External

On Tue, Apr 21, 2026 at 07:32:30PM -0700, Mukesh R wrote:
> Many PCI passthru related hypercalls require partition id of the target
> guest. Guests are actually managed by MSHV driver and the partition id
> is only maintained there. Add a field in the partition struct in MSHV
> driver to save the tgid of the VMM process creating the partition,
> and add a function there to retrieve partition id if current process
> is a VMM process.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |  1 +
>  drivers/hv/mshv_root_main.c    | 22 ++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  5 +++++
>  3 files changed, 28 insertions(+)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

