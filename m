Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8E224FA
	for <linux-hyperv@vger.kernel.org>; Thu, 14 May 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737631; cv=none; b=ONhGNslb8eAvnXaaHisdSWyHk4xkfO3ISwGLLv8VODW3XP1t+8JVChACyKjP1laU9/QuA4ovzU2DA9SKBSyGYuQZkmE3tZN4yAN8OqstKhkNYQTLjtEyoN0fy9sbkC8HwC+P5aP65yfMDHeLUYzTklLVrAHZCq2OvngrDxF7hU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737631; c=relaxed/simple;
	bh=4etiduDXSyxDHHVWXY3MSm/CeQtF4kTpPu3zOVsYA30=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m1giv6NkxA2leVRd+cRXiLGZKf2V/ssGJImz2Gqmqbz8LJsYiDTwTiupr84pWXhcFjj3l1cx0O5XT7PABcR9/iTf1YiyYs3qVHKw/B2uLlaEoEq8fZ/FQpH7k2mMsL5hz/50lhTnQFURerHRQqmyJ+ecrsg5SQgZX/DNMMEVeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRo5chRH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRo5chRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0963CC2BCB7
	for <linux-hyperv@vger.kernel.org>; Thu, 14 May 2026 05:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778737631;
	bh=4etiduDXSyxDHHVWXY3MSm/CeQtF4kTpPu3zOVsYA30=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=QRo5chRH+14NnxczYB6TyX6+LsZRLj/X4g6QaSyGnEXPbwHcVHwephKvVKa+Ib/MJ
	 y4m+bzxgSxKc14kfVzM6RIJ8TQvCOSlHM1Mlb5PC8L5y10CdGZyqrJXUKl33K4t7sh
	 NU6uA4fnPCr3aps5Jxlhyc69uqqRhUzcUyooBDTZUCJOoXzxOzX+3CDB6t60RMem44
	 aqY3PiYsnVlO+28B8ZKv96DxmTAJlgAutPBI+B6i03F2kaqKT8QUeXKI+Ei1Miyr/6
	 isQtQVSCMVHE/9rgYvn8a4JbQ5hvqvtcI5Yu6IZN3xRBUL0u/N39BajWbLOBlWK9f6
	 TAl+mWFtcHdnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260513-huge_1g-v4-1-33cda59e4a70@anirudhrb.com>
References: <20260513-huge_1g-v4-1-33cda59e4a70@anirudhrb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:47:10 +0000
Message-Id: <20260514054711.0963CC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing physical contiguity validation in large folio chunking lea=
ds to guest memory corruption and host-guest VMA inconsistencies.
--

commit 8234ab081cfc742915853b13b8eaeeb12adcc021
Author: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

mshv: support 1G hugepages by passing them as 2M-aligned chunks

This commit modifies the mshv driver to support 1G hugepages by treating
them as a sequence of 2M chunks, since the hypervisor map GPA hypercall
coalesces contiguous 2M-aligned chunks. It uses a 2M stride for folios
of at least PMD_ORDER.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index fdffd4f002f6f..6d65e5b421529 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c

[ ... ]

> @@ -86,15 +84,14 @@ static long mshv_region_process_chunk(struct mshv_mem=
_region *region,
>  	u64 gfn =3D region->start_gfn + page_offset;
>  	u64 count;
>  	struct page *page;
> -	int stride, ret;
> +	unsigned int stride;
> +	int ret;
> =20
>  	page =3D region->mreg_pages[page_offset];
>  	if (!page)
>  		return -EINVAL;
> =20
>  	stride =3D mshv_chunk_stride(page, gfn, page_count);
> -	if (stride < 0)
> -		return stride;
> =20
>  	/* Start at stride since the first stride is validated */
>  	for (count =3D stride; count < page_count; count +=3D stride) {

Does this code assume that all intermediate pages within the stride are
physically contiguous simply because the first page belongs to a large foli=
o?

If a VMM constructs a fragmented VMA, for example by using MADV_DONTNEED
on a shmem folio for guest memory ballooning, or MAP_FIXED to remap
specific pages, get_user_pages() could populate mreg_pages with a mix of
different pages.

Since the loop advances by the stride without inspecting the intermediate
pages between the stride boundaries, could this instruct the hypervisor to
map the contiguous physical block of the large folio into the guest,
ignoring the actual VMA mappings?

Would this cause the guest to read and write the host large folio's tail
pages instead of the VMM's intended pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513-huge_1g-v4=
-1-33cda59e4a70@anirudhrb.com?part=3D1
