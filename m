Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B850486B90
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829032; cv=none; b=Cv7WItEtKbq/Ff5emTfuH8Urpu4WErE97dvSFtFeuKXV0bhI9BAJ2UKIsJGzO9vROZCarBxQGpo0diFxiCFBtz1/GJyqfkXSP1wFKmGCncj38XxyQFKvL3xW5EFxZxnLMjuKLXm0H5y2P+BHaRBaRrbcUrucH53Cs6JBc4mO9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829032; c=relaxed/simple;
	bh=HQzLdITXSz2yu6qxLXCGCBX/Wxwserprr1/PmtAUpdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1o/DQU8laAkBw9QWOz8Wyj7ffk5mRdKgCX8CnOaRiDF1aLoTbwxmD0rWKQJCBbVRP7deAosYTVxLSwtt6RhXOTcMro6fXpkr1m/AvhsS97KQzwhDrmtxgPNfFDZJzDw4uGbl0R8C0rr+sbYOAaVkvjC8CojMrk+43xK8rCDSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BF91F00A3A;
	Thu, 23 Jul 2026 17:50:30 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260723-hmm-v10-v11-2-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723-hmm-v10-v11-2-c55b003a4b61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:50:30 +0000
Message-Id: <20260723175030.90BF91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unconditional dereference of hmm_vma_walk->locked in hmm_do_fa=
ult() on VM_FAULT_RETRY causes a kernel panic.
- [High] hmm_range_fault_unlocked_timeout() causes an infinite 100% CPU bus=
y loop on faults that drop the mmap lock (like disk I/O) by unconditionally=
 passing FAULT_FLAG_ALLOW_RETRY without tracking retries, and continuously =
resetting the timeout.
--

--- Patch [2]: [PATCH v11 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout=
() for mmap lock-drop support ---
commit 05dcbcb5ba6adcdc92b16e648fa82986518acbaa
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support

This commit introduces hmm_range_fault_unlocked_timeout() to allow HMM
fault callers to handle mapping faults that drop the mmap_read_lock, such
as userfaultfd regions. It restructures the internal fault loop to track
the lock state and gracefully retry when the lock is dropped.

> --- a/mm/hmm.c
> +++ b/mm/hmm.c
[ ... ]
> @@ -641,6 +651,9 @@ static int hmm_do_fault(struct mm_struct *mm,
>  	unsigned int fault_flags =3D FAULT_FLAG_REMOTE;
>  	struct vm_area_struct *vma;
> =20
>  	if (hmm_vma_walk->locked)
>  		fault_flags |=3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;

[Severity: High]
Does this missing FAULT_FLAG_TRIED tracking cause a livelock on file-backed
faults?

When filemap_fault() sees FAULT_FLAG_ALLOW_RETRY without FAULT_FLAG_TRIED,
it initiates background I/O, drops the lock, and returns VM_FAULT_RETRY
immediately. Because FAULT_FLAG_TRIED is never set on subsequent retries,
this will continually drop the lock and retry until the I/O completes.

[ ... ]
>  	for (; addr < end; addr +=3D PAGE_SIZE) {
>  		vm_fault_t ret;
> =20
>  		ret =3D handle_mm_fault(vma, addr, fault_flags, NULL);
> =20
>  		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
>  			*hmm_vma_walk->locked =3D false;

[Severity: Critical]
If hmm_range_fault() is called, locked is NULL. Can this dereference a NULL
pointer if a fault handler returns VM_FAULT_RETRY?

Even without FAULT_FLAG_ALLOW_RETRY, some fault handlers (like
exfat_page_mkwrite or BPF arena_vm_fault) return VM_FAULT_RETRY
unconditionally when internal locks fail. If this happens during a legacy
hmm_range_fault() call, *hmm_vma_walk->locked will cause a panic.

[ ... ]
>  static int hmm_range_fault_locked(struct hmm_range *range, bool *locked)
>  {
>  	struct hmm_vma_walk hmm_vma_walk =3D {
>  		.range =3D range,
>  		.locked =3D locked,
>  		.last =3D range->start,
>  	};

[Severity: High]
When a lock is dropped, the outer function reacquires it and calls
hmm_range_fault_locked() again. Because hmm_vma_walk.last is re-initialized
to range->start on every call, forward progress is lost and the walk
restarts from the beginning of the range.

[ ... ]
> +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> +				     unsigned long timeout)
> +{
[ ... ]
> +	do {
> +		/*
> +		 * If the previous fault dropped mmap_lock, then the fault
> +		 * handler made progress. Restart the retry timeout in that
> +		 * case, but keep the existing deadline for ordinary -EBUSY
> +		 * retries.
> +		 */
> +		if (timeout && !locked)
> +			deadline =3D jiffies + timeout;

[Severity: High]
Coupled with the missing FAULT_FLAG_TRIED logic above, does this continually
reset the timeout?

Since filemap_fault() drops the lock and returns VM_FAULT_RETRY instantly
while waiting for I/O, locked will be false on every iteration. The timeout
deadline will be pushed forward infinitely, creating a 100% CPU busy loop
that entirely bypasses the caller's timeout policy until the I/O finishes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-hmm-v10-v1=
1-0-c55b003a4b61@gmail.com?part=3D2
