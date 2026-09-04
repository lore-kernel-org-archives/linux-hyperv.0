Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC03CDBD3;
	Fri,  4 Sep 2026 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509223; cv=none; b=P9mvaoVTTyDH7UsSqpJaX4iMsTkKlgs/3omU8fWFA1UHivcmq2ZoGg3Sz7QiWVLdyc279xvGfvFSg25PVoCN7YLynAM4TN8RBFL8S5CPvNXwF1I0+C7z0/KGLNYqBPJDNuHm7DHEHL+73T1VvCMuCRogmlLOajIrS3uegi0E/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509223; c=relaxed/simple;
	bh=1DiEvfFqH7VsHyAyJjbLCH4l1vzqGfdITtxCo2beOUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S4zcOmtuIZfh7mNaBzMVPPG7aVTEne0U3Hi7DWHWe/2wRxqr6FK/XDxe/IZdu9hRBN5F26OBxQTPDxqQUDK/dROIJlO5P0Z3bmCBiq8I6htPLYN5DCyXm+dlj9dzXlS+IETGqK6t3fz1AFRQ3c/Oc28bvLxi/WkPyNqN3DF3OKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exfGuqpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exfGuqpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344801F00A3D;
	Fri,  4 Sep 2026 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788509221;
	bh=1DiEvfFqH7VsHyAyJjbLCH4l1vzqGfdITtxCo2beOUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exfGuqpadhQUHUs+oINMgzZVTVxYz++m1SNSfE342P+P6cSyK0+qgsZOxN3O/2hQO
	 cqc+dN2I/TZKIxysSze/zs2jJAmHkAzJc1LrqmPc392S3GSTrCQrjHNDsfbK2Seofw
	 UYNZl1zCKAbGRxtLQVFbRLuN/15qfe+tUnOS4MRdtI8Nyt+CJg32kBCnX5KrFx/ld8
	 SCLts7VIlCJx+63NlhErrA7HOcXuiUFSQdMk/2FIN2BthRYj2Ip4+N4SWcDt2qkCmx
	 glcWCQvg17WA4Bh/b42POiLAW8cPSmCzN9ju8GQSddpmE9JUlGXbXzM0DJQWBCAsvc
	 jx/Cv0Fh8RmNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260904075512.174154-6-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-6-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:07:00 +0000
Message-Id: <20260904080701.344801F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904075512.1741=
54-1-zhangyu1@linux.microsoft.com?part=3D5

