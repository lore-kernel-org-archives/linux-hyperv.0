Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE0370D79;
	Fri, 21 Aug 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319715; cv=none; b=lRvcvbeoZ6vDd5PU38ZMMnSfXCxPxvD1hEEhTPOqUyFBMRJx8Cb+vyPGrveFTZB0xm31YlwfDNXToWsXWpsc1Y8ac6RxXt5hLG81vjXDqHQTAr69A0TMWARkn7M0SopBTTmMdkvIng6HBPneiZ+fU2jXkSr9SNVPdcFceXn4vHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319715; c=relaxed/simple;
	bh=FjFVcw1Dt7UgtsISnTuNiUf0z+/JPvw0XwLgE+Q7kHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XBko0Y10TqoDtqEWqz6iwV8D4Z0muil0gTsupo1FPKR6/0QviVP6NTYHPDMVRe3/lArN08CXOTveI2Ka5BcOocilo6FY1sSIQqDCQsQqaAxv2/kTTTN3ulg97f4vQdDsxy+0Lkc5N60N0mmz8hx4F1TxnA/QYECqmmqDR/3m9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdCmnhxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdCmnhxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680241F000E9;
	Fri, 21 Aug 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787319713;
	bh=FjFVcw1Dt7UgtsISnTuNiUf0z+/JPvw0XwLgE+Q7kHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TdCmnhxF7z3kIDx+uxCouGnw5j1sZJF2nrqRDb9k3h2Nx9DPtf9rYaVNvxp2CivUq
	 igxnSeAXVZ8C/OR1mpJdFgE9cc4qZd0BUDWkX4ABf8RZNVc/B1SRGtvXKGuGmwL8lD
	 UZsbl/LExVJppg0pOBAya/K+S3Jusw5S97eJvaSmRVwbZN+djkqBBI9B/Z588LlmyQ
	 mkj97XiRADFfjnOrl4qiF5M3VvghdJ/rImx5K2zI3if/2yjKGox2jFlYzxbmMxS++1
	 njY7AxyheqIVhalBtx3Sz5K7Y3VRlp5lfs1qoaIV4SV7ESpk+NduvH749n5zKux84W
	 CgOXedHx5MEjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260821132654.211730-6-zhangyu1@linux.microsoft.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-6-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 13:41:52 +0000
Message-Id: <20260821134153.680241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> This hypercall accepts a list of (page_number, page_mask_shift) entries,
> enabling finer-grained IOTLB invalidation compared to the domain-wide
> HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
>=20
> hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> range that covers the target IOVA region, producing a single flush
> descriptor. This may over-flush when the range is not naturally aligned,
> matching the approach used by Intel VT-d PSI. If the page-selective
> flush fails, the code falls back to a full domain flush.
>=20
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821132654.2117=
30-1-zhangyu1@linux.microsoft.com?part=3D5

