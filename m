Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77C436BFF
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362068; cv=none; b=Lj8r4c5hq+PmjvnuglCAZyzCrggnQM+kbkLGLK8byMCF9wi/O+1aUvd78NPUJG3HWxISCRp+2KrSFsac1MmWb8vUbhOYlYw9okMunmsrfoQFDhprTVEJOmfWBUtAdoTp9/sPrbQwDs6/0F+EyxMfICkM901lsUBb8o2BKQuaYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362068; c=relaxed/simple;
	bh=IwCbm3v2fOe0p8L9vIhHBGDGgMWaYfQAQdVuCHTxUJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TtqJ2mr+fr+ZX4gjcGR7fuw/LZtms870js/IUX7k1N0OViwTGiroSRejNWTiwLsncFjiQUzZT+Ur0Jy41mPf5edY/uai69qEErt63PPExnjU2HmCw5C33bifrtll5Qz7ySXEVm9NNIKh/2EQkU3S6eWHo5GaNb4/axCHZZKkEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT25/236; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT25/236"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3DD1F000E9;
	Mon,  6 Jul 2026 18:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362067;
	bh=hH3JGJgz2GkPY4j7m3GWJFsXFPsvJ/vgVtuRUEhbelU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UT25/2364VHGzKILczCGTGmi7+/+4+cCyOadQ7p8byuvZRHAUIQrY5mXol9XYTNY0
	 fpZEAVMzD/bFP8PSh53Q1yVUJ57oiKDAFakqerl0u+2nVdny7oazIHu1EILGOkjV6q
	 qU+jf7aPLln0+yJ/5Y9snTid/34m7/xNxK9SYOfMW1KcKMzlSmjVIpttPEL7l0GULK
	 Rf58gzf3dHirVhlWOZpYArvxsHufa+5Mh4XRTvZvp+F7de3l/WLHvvHwRLZYiRNlJh
	 Fn9GxWKa2MXHz5LUvXBc2Yw0j8/aMn+kBYH2Kz8kxKBCtg154Akx1+561+gKHYjseC
	 Y7ZURHk3OWCQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] mshv: Use hmm_range_fault_unlocked() for region
 faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <178336052192.504354.1841795575701703197.stgit@skinsburskii>
References: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
 <178336052192.504354.1841795575701703197.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:21:05 +0000
Message-Id: <20260706182106.2A3DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing check for fatal signals in retry loop handling HMM faults.
--

commit 4f92a5b1f4b0160351016ede4e0c8d47d308cbfa
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

mshv: Use hmm_range_fault_unlocked() for region faults

Convert mshv_region_hmm_fault_and_lock() to use hmm_range_fault_unlocked()
instead of taking mmap_read_lock() around hmm_range_fault() directly.
This allows the MSHV fault path to handle mappings whose fault handlers may
drop mmap_lock.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 6d65e5b421529..04676f06c5c74 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -388,13 +388,11 @@ int mshv_region_get(struct mshv_mem_region *region)
>   *
>   * This function performs the following steps:
>   * 1. Reads the notifier sequence for the HMM range.
> - * 2. Acquires a read lock on the memory map.
> - * 3. Handles HMM faults for the specified range.
> - * 4. Releases the read lock on the memory map.
> - * 5. If successful, locks the memory region mutex.
> - * 6. Verifies if the notifier sequence has changed during the operation.
> + * 2. Handles HMM faults for the specified range.
> + * 3. If successful, locks the memory region mutex.
> + * 4. Verifies if the notifier sequence has changed during the operation.
>   *    If it has, releases the mutex and returns -EBUSY to match with
> - *    hmm_range_fault() return code for repeating.
> + *    hmm_range_fault_unlocked() so the caller retries the range fault.

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
fault retry logic, does the retry loop in mshv_region_range_fault() need to
check for fatal signals?

When mmu_interval_read_retry() detects a collision, this function returns
-EBUSY, which bubbles up to the caller in drivers/hv/mshv_regions.c:

mshv_region_range_fault() {
        ...
        do {
                ret =3D mshv_region_hmm_fault_and_lock(region, &range);
        } while (ret =3D=3D -EBUSY);
        ...
}

If a userspace program continuously invalidates the memory range concurrent=
ly
(for example, via madvise(MADV_DONTNEED)), mmu_interval_read_retry() can
repeatedly return true.

Without a check for fatal_signal_pending(current) inside the loop or before
returning -EBUSY, could this cause the kernel thread to spin indefinitely a=
nd
ignore fatal signals like SIGKILL?

>   *
>   * Return: 0 on success, a negative error code otherwise.
>   */
> @@ -404,9 +402,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv=
_mem_region *region,
>  	int ret;
> =20
>  	range->notifier_seq =3D mmu_interval_read_begin(range->notifier);
> -	mmap_read_lock(region->mreg_mni.mm);
> -	ret =3D hmm_range_fault(range);
> -	mmap_read_unlock(region->mreg_mni.mm);
> +	ret =3D hmm_range_fault_unlocked(range);
>  	if (ret)
>  		return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178336023903.504354=
.7500950448226027718.stgit@skinsburskii?part=3D4
