Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0743E486
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757371; cv=none; b=nzFrT1lR/rjCudwkEn1YNTPPKhYIeHNbrVOALCUZj+rqdlFFCrWDeLHu2y+GTA+jcIeQEYrFXQAd1eYif+izQcxa3UqHV0mMsHuCtQYGv5svrdvgVxwzfc6pUGcbuQHFLyMSs4Zcpctl0E5AZxZTEDlmZ/fY4rJaJMUm113ZFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757371; c=relaxed/simple;
	bh=+eSc7qGI92JbK9Td44236paCB/zT+F7H6TShSuwXd8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9ObWxyLvxAb+28avg+WIIgVpWDPdaxeESR63wANC/OOMsktgpbpLBaH+fqMQZ2TYDwHTfuWn+kKhd+CJcZYs616IrMnDlvLkAAgz438Nln4/aQpSAN6EncMbdDbO2I0M9kO/vzAAa4yz7gCd1f6GWBiKa3dCizyWfYCbyIwvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXChkq4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXChkq4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54C31F000E9;
	Wed, 22 Jul 2026 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784757369;
	bh=nPV7Fz029QcyviGxjSeBbyLLbptl7GxDXHVljjfzUuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXChkq4yXI2KG+5TPqXzXNkwjtti0kLnmULrMmK6rg+6X9GcwZU1FsNgHYy+1uWZQ
	 hDPmgaHEP0XqxilLChHvOwQsI0wwik96kazEhKvEpdtwOtDbQLC8Yn759P1uhlYz6P
	 mQFaQ9qMRnzJcObcrQAo7wYXTm1JXotboRhqUpEGONr17a8HS4bsghxCqiEhTe6ueN
	 WQ6H+4XGJXnMK/iZ7y90kzocgmLWaZAbuSZwVcYiowKamFRBqZbCzqAhw86Br/45iK
	 4Gnh1hqTUgKP90Yc19IZR6zEVAZNdjqrf0Yt5WgPByJnzMwi5olck2Pjd07Ss1AGQF
	 CE618/gXgylVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/8] RDMA/umem: Use
 hmm_range_fault_unlocked_timeout() for ODP faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-hmm-v10-v1-6-606464dd601a@gmail.com>
References: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
 <20260722-hmm-v10-v1-6-606464dd601a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:56:08 +0000
Message-Id: <20260722215608.D54C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing check for unstable address space before iterating over an =
external mm_struct's VMAs, risking a crash if the OOM reaper has marked it =
MMF_UNSTABLE.
- [High] Unbounded interval invalidation retry loop in a workqueue context =
lacks a timeout or yield, leading to a potential CPU soft lockup.
--

--- Patch [6]: [PATCH v10 6/8] RDMA/umem: Use hmm_range_fault_unlocked_time=
out() for ODP faults ---
commit b7408a657980d2af72d45f322c843edb9faecf2e
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

RDMA/umem: Use hmm_range_fault_unlocked_timeout() for ODP faults

ib_umem_odp_map_dma_and_lock() takes mmap_read_lock() only around
hmm_range_fault(), then retries -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT
expires.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes range->notifier_seq for its internal retries.
ODP keeps using HMM_RANGE_DEFAULT_TIMEOUT for each HMM fault attempt,
while interval invalidation retries continue to be handled by the existing
outer loop.

ODP still validates the interval notifier sequence while holding umem_mutex
before DMA mapping pages.

> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core=
/umem_odp.c
> index 404fa1cc32542..9cc21cd762d98 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c

[ ... ]

> @@ -363,26 +363,18 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp=
 *umem_odp, u64 user_virt,
>  	}
> =20
>  	range.hmm_pfns =3D &(umem_odp->map.pfn_list[pfn_start_idx]);
> -	timeout =3D jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +	timeout =3D msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> =20
>  retry:
> -	current_seq =3D range.notifier_seq =3D
> -		mmu_interval_read_begin(&umem_odp->notifier);
> -
> -	mmap_read_lock(owning_mm);
> -	ret =3D hmm_range_fault(&range);
> -	mmap_read_unlock(owning_mm);
> -	if (unlikely(ret)) {
> -		if (ret =3D=3D -EBUSY && !time_after(jiffies, timeout))
> -			goto retry;
> +	ret =3D hmm_range_fault_unlocked_timeout(&range, timeout);
> +	if (unlikely(ret))
>  		goto out_put_mm;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed we are passing an
external mm to the HMM helper here without checking for an unstable address
space.

When we call hmm_range_fault_unlocked_timeout(), it takes the
mmap_read_lock_killable() on the external owning_mm and traverses the VMA
tree locklessly:

mm/hmm.c:hmm_range_fault_unlocked_timeout() {
        ...
        ret =3D mmap_read_lock_killable(mm);
        ...
        ret =3D hmm_range_fault_locked(range, &locked);
        ...
}

Could this crash if the external mm is being concurrently torn down?

For instance, if the OOM reaper has marked the mm as MMF_UNSTABLE
or if a dup_mmap() failure has left XA_ZERO_ENTRY markers in the maple
tree.

Does the HMM helper or this caller need to invoke
check_stable_address_space(mm) after acquiring the mmap lock before
walking the page tables?

> -	}
> =20
>  	start_idx =3D (range.start - ib_umem_start(umem_odp)) >> page_shift;
>  	dma_index =3D start_idx;
> =20
>  	mutex_lock(&umem_odp->umem_mutex);
> -	if (mmu_interval_read_retry(&umem_odp->notifier, current_seq)) {
> +	if (mmu_interval_read_retry(&umem_odp->notifier, range.notifier_seq)) {
>  		mutex_unlock(&umem_odp->umem_mutex);
>  		goto retry;
>  	}

[Severity: High]
This is a pre-existing issue, but does this interval invalidation retry
loop lack an overall timeout or a way to yield?

If a user-space program concurrently loops on madvise(MADV_DONTNEED) for
a memory region, it triggers the MMU notifier, causing
mmu_interval_read_retry() to repeatedly return true.

Because hmm_range_fault_unlocked_timeout() takes a relative timeout,
calling it again here on every retry resets the deadline for the HMM fault
attempt. If the pages are already faulted, the helper returns 0 quickly,
and this thread will loop unconditionally back to the retry label.

Can this unbounded loop monopolize a CPU core indefinitely and lead to a
soft lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-hmm-v10-v1=
-0-606464dd601a@gmail.com?part=3D6
