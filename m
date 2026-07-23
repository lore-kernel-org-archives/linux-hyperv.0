Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD01396572
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829204; cv=none; b=gTL8umJPLpz41D0ie8Vek4E/8wPPq/VsNmr9hkLmE3MScLNobB3OjSAJD8dtZ2nH8IsrsNvE4R1jfO5s3N4jQpPna1gUYrSmN3MNKxxQRO/qMmiinwbkNIpocGScP4QAqfdpxdnY+soSQX8VEzjhzcinUZyU7NfI84cpbbJkoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829204; c=relaxed/simple;
	bh=p3GRmGEwYp2aBww71xULZhcEL7IaXrO3ApmuXNrxF7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T81LglEdBratOR/dNM8Umi1o2r9o7Ma+t/KoZX2w+MIHd3BntSJdG62NwFLlfXWtLu2+I7SYFWyS0VJMjK5E7vnAH1QpkY5CpqRm9vvZP8ZhmgQoUS6WqJTj4JI1gI1b3eTDz2kXb9QkKZfM+60BAaC5/T+nuISQ7itaUTxdR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC61D1F00A3A;
	Thu, 23 Jul 2026 17:53:22 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-hmm-v10-v11-7-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723-hmm-v10-v11-7-c55b003a4b61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:53:22 +0000
Message-Id: <20260723175322.AC61D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dereferencing `mapp->vma` without holding `mmap_lock` or a VMA loc=
k leads to potential Use-After-Free.
--

--- Patch [7]: [PATCH v11 7/8] accel/amdxdna: Use hmm_range_fault_unlocked_=
timeout() for range population ---
commit 49a458a983bff0bc836f15feb7b3aa4763d7eb91
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

accel/amdxdna: Use hmm_range_fault_unlocked_timeout() for range population

This patch updates aie2_populate_range() to use the new
hmm_range_fault_unlocked_timeout() helper. The helper manages the mmap lock
and retry sequences internally. The driver now scopes the HMM retry timeout=
 to
the helper while maintaining its outer invalidation loop.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 54486960cbf5e..b5b4ca263002d 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c

[ ... ]

> @@ -1061,24 +1061,9 @@ static int aie2_populate_range(struct amdxdna_gem_=
obj *abo)

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free with the VMA just before this block in aie2_populate_range():

        XDNA_DBG(xdna, "populate memory range %lx %lx",
                 mapp->vma->vm_start, mapp->vma->vm_end);
        mm =3D mapp->notifier.mm;
        if (!mmget_not_zero(mm)) {

Is it safe to dereference mapp->vma here?=20

Since aie2_populate_range() only holds the xdna->notifier_lock at this poin=
t,
it doesn't appear to be tied to the VMA's lifetime. If a concurrent munmap
from another thread triggers an invalidation and frees the VMA entirely, co=
uld
the logging statement access a freed VMA structure when reading vm_start and
vm_end?

>  		return -EFAULT;
>  	}
> =20
> -	mapp->range.notifier_seq =3D mmu_interval_read_begin(&mapp->notifier);
> -	mmap_read_lock(mm);
> -	ret =3D hmm_range_fault(&mapp->range);
> -	mmap_read_unlock(mm);
> -	if (ret) {
> -		if (time_after(jiffies, timeout)) {
> -			ret =3D -ETIME;
> -			goto put_mm;
> -		}
> -
> -		if (ret =3D=3D -EBUSY) {
> -			amdxdna_umap_put(mapp);
> -			mmput(mm);
> -			goto again;
> -		}
> -
> +	ret =3D hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
> +	if (ret)
>  		goto put_mm;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-hmm-v10-v1=
1-0-c55b003a4b61@gmail.com?part=3D7
