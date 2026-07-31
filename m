Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC3232395;
	Fri, 31 Jul 2026 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538675; cv=none; b=E9ATNzo+orOIwlrNBfZyYaMgXknFXLx7augnetrsEZWq7Sl5T8MBmhTrhn2o9F2ickqiIeK0DTDx/FsuBI6YHUEGCMgTTvonR/YIpdlOAmwDgBQ35bkcd8s/AcxlAtGFTei86kB77VjLYODXT06lrtqMdtR4S6LO5HXcoWbRoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538675; c=relaxed/simple;
	bh=Dgcim4vQ3rU6xpO7knj5psVHq284kjCHDHg8Y1GPCgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gNpDoORnv76tudJ7HJR5K3AgaNMcDHr+n4lRSUWUImJFYYRjB6pJ4bxA3mCcSGxw27PmiI4Kk6KzKL6Dky5Q+VK7o4ijolLbd8SxneND8vrnAEWJyLsVtcqucB10haLhrIAvyt9Oul4GefZokSVFU2dpTgRNAhItTVBk1Rbunig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L71TsKNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L71TsKNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411CB1F00AC4;
	Fri, 31 Jul 2026 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538674;
	bh=efX2gNDQwDdViWXJuWq5gyTvWhvbf8nV4Gz4ITICKb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L71TsKNLr7E3mFALUTabmy6Lnx8Ov++e+FeOSKmHdfKBoACuLb10hgyJxxswEScqS
	 lKycFCmbqOLCXvt56TNwPwcizcvsS8VjHotpTRqrXKIo4bi5oqiN9sYbB7voic1YKd
	 kjkbirBUJ2LWvyDFJtAdePdIkenqIpTbKFWdIkzwJAjLPxNiPuiW6ma8nYE0EjK51m
	 0aBXYcBhe9oaUZEY3WrTDpWSiZFjYASLTNkM2Eqt5OZ9Sel1YEXwbr4MTfCV9LGqhN
	 kagRMdUjundbo2t6//GDlETBjmNuDaMnUWKdOClS589bMJdIVQ5+aHUFeNbFMybnba
	 anoA7LGSQwPMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] mshv: Disable movable regions upfront if device
 passthru
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731223427.2554388-10-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-10-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:57:53 +0000
Message-Id: <20260731225754.411CB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Bypass of memory pinning enforcement on device creation via `copy_=
to_user` failure.

Pre-existing issues:
- [High] Error paths in `mshv_map_user_memory` and `mshv_prepare_pinned_reg=
ion` cause a NULL pointer dereference in `unpin_user_pages()`.
--

--- Patch [9]: [PATCH v5 9/9] mshv: Disable movable regions upfront if devi=
ce passthru ---
commit 43489ca84b127042602836c2214d379f535126bf
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Disable movable regions upfront if device passthru

If a VM is started with a device attached, the memory regions must be marked
non-movable to allow the use of SLAT for IOMMU. This commit introduces a
module parameter to pin regions upfront and updates the device creation ioc=
tl
to mark regions as pinned when a device is passed through.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -1332,7 +1342,7 @@ static int mshv_partition_create_region(struct mshv=
_partition *partition,
> =20
>  	if (is_mmio)
>  		rg->mreg_type =3D MSHV_REGION_TYPE_MMIO;
> -	else if (mshv_partition_encrypted(partition) ||
> +	else if (mshv_do_pt_regions_pinned(partition) ||
>  		 !mshv_region_movable_init(rg))
>  		rg->mreg_type =3D MSHV_REGION_TYPE_MEM_PINNED;

[Severity: High]
This is a pre-existing issue, but I noticed an error handling problem with
pinned regions that might be triggered more frequently now.

If pinning fails in mshv_map_user_memory(), we drop the reference:

mshv_map_user_memory() {
    ...
    errout:
        mshv_region_put(region);
        return ret;
}

This triggers mshv_region_destroy() which unconditionally invalidates the
region:

mshv_region_destroy() {
    ...
    mshv_region_invalidate(region);
    vfree(region);
}

If the region pages were already partially unpinned and NULLed out during
the pinning failure, mshv_region_invalidate_pages() will pass those NULL
pointers directly to unpin_user_pages():

mshv_region_invalidate_pages() {
    ...
    if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_PINNED)
        unpin_user_pages(region->mreg_pages + page_offset, page_count);
}

Since unpin_user_pages() does not check for NULL pointers, does this
sequence result in a NULL pointer dereference when cleaning up after a
pinning failure?

[ ... ]
> @@ -1818,6 +1828,9 @@ static long mshv_partition_ioctl_create_device(stru=
ct mshv_partition *partition,
>  	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
>  		return -EFAULT;    /* cleanup in mshv_device_fop_release() */
> =20
> +	/* For now, just mark regions pinned if there is device passthru. */
> +	partition->pt_regions_pinned =3D true;
> +
>  	return 0;

[Severity: High]
If copy_to_user() fails here, we return -EFAULT, but the file descriptor
has already been installed into the process's file descriptor table via
anon_inode_getfd() and remains active.=20

Could this allow userspace to bypass setting pt_regions_pinned to true
while successfully obtaining and using the device file descriptor? If a
process intentionally passes an invalid pointer, it seems it might be able
to map movable memory while still attaching a device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D9
