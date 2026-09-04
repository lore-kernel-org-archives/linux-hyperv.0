Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E23DB31F;
	Fri,  4 Sep 2026 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509765; cv=none; b=TwUBWb+auTeR6W8seGa1xVXlsDbO1SB7DH8bEnStiU0ySXS9/pxtdOdKNCK6agbPgJ8mIbHVF+KjV1k0pZpg9p0Q7w+F9IS3oy4dh3nx1VSsYW8hyDzM4By4A79u3RZuSn8TESLDQ6+UrKjdwWrKmh5LtMAWaggK04mmu/Unqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509765; c=relaxed/simple;
	bh=aSfPxQj/YjxwoklxR3K2ucq3A48Tm/zvoyu77ufuvDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r7oEP5Qlguj8V/23rdSKgqLfnEezoqPh6oapMjYsWK8AdOLipp2dfhYNOkF7XBaDRPKNtv9AtU6owqEfO6+ntWNbTloU05YDS/ac+D10aHVirdU5VMqOhoZBgnWFVh03kcf13wB8JdpYAJXRnlWl/Wgzaop3UMpMRebyTxwOeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh3lL6Uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh3lL6Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FDB1F00A3D;
	Fri,  4 Sep 2026 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788509763;
	bh=H59JtYoWK5KPRHKTIX6SQsjtFw6IGIPvGDF6WmqQ8/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eh3lL6Uu4cdiKClVHFTK1x+xNwaC2Z7AceIlmFPQQ/K/kBeVyOja0bzjX+zF6ouLc
	 aHusxNShlhWI9DcpAkoZeqthKMieC/y5nwDColkocw+Urva6ag1RomJb2C4qQ4MGk0
	 ZEws3eWsmtsP+dT93viqDbZdMlqJTGGb5d5K4dNobiJFzDxybaw/k9047s4iAuLP0z
	 F8iBqwv23ZJo5qipSb6OBE6+34872XNRGdz6KWBH5lfyml7D4fwpxz3ScOrKmsPF0Z
	 OZxCadf0L74t0qvFAesjHpcEtjG8+OKt/tm+IEz9Ix3sdMDC2zYiqpYlCVNLpCLPvE
	 4ep+zsMniZMjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:16:03 +0000
Message-Id: <20260904081603.74FDB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The global pointer `hv_iommu_device` is left pointing to freed memo=
ry on initialization error paths.
--

commit cabf0b0a28725bbdf8a09d64a7c284187b9174dc
Author: Yu Zhang <zhangyu1@linux.microsoft.com>

iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest

This commit introduces a para-virtualized IOMMU driver for Linux guests on
Hyper-V. It implements stage-1 IO translation within the guest OS by utiliz=
ing
Hyper-V hypercalls.

> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv=
/hv-iommu-guest.c
> new file mode 100644
> index 0000000000000..137f232d74fe5
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
[ ... ]
> +static void __init
> +hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +		     struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
[ ... ]
> +	hv_iommu_device =3D hv_iommu;
> +}
> +
> +int __init hv_iommu_init(void)
> +{
[ ... ]
> +	hv_iommu =3D kzalloc_obj(*hv_iommu, GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret =3D hv_initialize_static_domains();
> +	if (ret)
> +		goto err_free;
[ ... ]
> +err_free:
> +	kfree(hv_iommu);

[Severity: Low]
If hv_iommu_init() fails after calling hv_init_iommu_device(), the allocated
memory is freed here on the err_free path. Does the global pointer
hv_iommu_device need to be reset to NULL to avoid leaving a dangling pointe=
r?

While this might currently be unreachable because functions using
hv_iommu_device are invoked via callbacks that are only registered on
successful init, could this pose a regression risk for future code accessing
this global state?

> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904075512.1741=
54-1-zhangyu1@linux.microsoft.com?part=3D4
