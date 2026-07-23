Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666CE372EEC
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829260; cv=none; b=efx+F3aJdKJrydM1Jl7oX7zUgsI9TtOolDyEOOGrLqbBXSXCoeDlyhu9+BZKfhs8BJSd4Fq5dGvLpqjmEpznA8LDQiMWgyLO+Zv9CVD1RsAY5DsakqAYuIIgDy1ma39S1sKugV0to3S3eGnCFdw2romQOAgRvw4YBSCeMHoEdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829260; c=relaxed/simple;
	bh=sXxqZH/bjdpPE5ad9F5NQQ9OvYDav7kNit6XM6lo8VE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fR4s7W8w0bZrHsCI5d68eQu2eAlHKcfzA1LCEcSrU2/Wx7tvY1sowW6OHtJL4WPSt+dBn677/LP/0RcfGDpexnBdIG3wZRbt2Nqk/OctSbfSozvLHz+3GsliozmtAY4c7X40Xl/7lBP04qO5PiVmitLHdg7cCDXT7XMVL9x9Ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE3u7Xv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE3u7Xv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12221F000E9;
	Thu, 23 Jul 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784829259;
	bh=4a3WCBaF2d54wq/QflDBhU3ZrKf7L+sZt6qilimb1w4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jE3u7Xv1imYw3t4h4RrdPM1HIrsb+M+SO3Y/fxY29QjeFTHMi1zlhMoGgeXcyP3Zy
	 +cB49+x0E/+khvdpNTZXNaBfXNQUhdaviowL0YURc811yION+ib7G6WIWWG0kTY1lK
	 LBPWM2UXlfw3cXWuK2etZ6uIQxLvzE6kgAJX6L44EAGu0VvPP7h+agJf/4MIEsh+08
	 tNvl3O0UfHHgWPlrVKgkq+mrh4CnoHponlk44qRu8MUczzrCW2b781zNmxd/hqSl2U
	 xJp8E4g8jWVxQNOhNFX6Rq49Xut/rBJdHrONazRalT8bUeXLankds0TfhUZB8/cmwZ
	 bQBknHH08qKfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260723-hmm-v10-v11-8-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723-hmm-v10-v11-8-c55b003a4b61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:54:18 +0000
Message-Id: <20260723175418.D12221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `mmput()` on the `pfns` allocation failure path causes an =
`mm_struct` refcount leak.
--

--- Patch [8]: [PATCH v11 8/8] drm/gpusvm: Use hmm_range_fault_unlocked_tim=
eout() for range faults ---
commit 83e2ac7a16c88b9dee7c9dc0f7c00f0dcd69b81d
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

drm/gpusvm: Use hmm_range_fault_unlocked_timeout() for range faults

This commit replaces open-coded HMM fault loops that hold the mmap read lock
with the hmm_range_fault_unlocked_timeout() helper. It delegates the lock
acquisition and retry logic to the helper while maintaining the existing
timeout budgets.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..e912e994beb21 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1736,24 +1708,12 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpu=
svm,
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this allocation failure path leak the
mm_struct reference?

In drm_gpusvm_range_evict() in drivers/gpu/drm/drm_gpusvm.c, earlier in this
function mmget_not_zero(mm) successfully acquires a reference to the mm. If
the subsequent kvmalloc_array() call fails, the function immediately returns
-ENOMEM.

Should there be an mmput(mm) before returning to prevent leaking the
mm_struct reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-hmm-v10-v1=
1-0-c55b003a4b61@gmail.com?part=3D8
