Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC25356744
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343571; cv=none; b=QFsry5ftVlujEKtYC4He2L8KAlMi9WzMan3cMaBLuEEDYhHBOHOHXxymm37NDvebGwAPx/Ek5Lzbh/WXfOLztzwDE2y8hsb/l3tZjNsumC0IQV8i0n1ti/Ok8bFTclh/v098x2i2vZlcWFYkHLHJwIhyuPXxjv/mHGfn43d3pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343571; c=relaxed/simple;
	bh=x5iVXGsLbnLXNA7WAz5qMryVc4hDN+qHbMBdiKodHs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ITdGxQyBLewWhuEdSfIXouxUtDsVsI2M3sIFj7Df7VFhc70Y5Ia1qB3orpXvZ/tofZ4kL3+mQylMoUv+TTfMPseZYQifXBwNzewRaplzYQjkGqVa/3lMMZUEsf3x1QOh/Jxx8qo4/ZkbaWJKk9tWuk8CyB0oIo9i66KYZ+IUvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFnopNga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFnopNga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD3E1F000E9;
	Mon, 10 Aug 2026 06:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786343569;
	bh=+Ci6UOU+tqB/o1I+tC0HAFj5irrO7DCGIwS5usp1rcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFnopNgahSvRsqj8Oekfb6ZFO6EZmZ3KTy7+NQpRWLNzJirHGEEVCPWbhB1ruKgL9
	 UW142z7Uyg/SnD/fWrZOETtx3gMWJ+dGRUU39u6p8hAMqX8MAlCZH25QAbVmR1kVRG
	 fAeu4+Qxn5NJTjhHjvUJPNnl7MebYy+6zSWenswr9TJ9rmF2smxbR0REXddnKRJNEo
	 tNAe9xJkQyBGz7515f/h4dHE1trDbVzW7zk88/d7BbRBm5d7B2MqV4RgoXkHSrgttb
	 LcmQAnymGBdVaySykzxlwruCR+ICkIaqVgbBdZ0ptkiyVq+bPnKbQcs/I3eUzfoAzk
	 eN0t9DVurnJdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810062144.2108758-1-namjain@linux.microsoft.com>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 06:32:49 +0000
Message-Id: <20260810063249.ABD3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Integer overflow in intra-cluster group rotation breaks CPU allo=
cation permutation, causing empty CPU masks.
--

--- Patch [1]: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ =
stacking ---
commit 3ea99a586f68e414d616ef9d2a0f13f390a05e7d
Author: Naman Jain <namjain@linux.microsoft.com>

lib/group_cpus: rotate extra groups to avoid IRQ stacking

group_cpus_evenly() computes how a device's queue interrupts are spread
across CPUs. This commit introduces a per-caller rotation counter to
shift which groups get extra CPUs. The rotation ensures that single-CPU
groups from multiple identical devices do not stack on the same CPUs,
improving throughput and reducing tail latency.

> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index e6e18d7a49bba..8bed0f9d2110b 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
[ ... ]
> @@ -270,11 +279,15 @@ static void assign_cpus_to_groups(unsigned int ncpu=
s,
>  	for (v =3D 0; v < nv->ngroups; v++, *curgrp +=3D 1) {
>  		cpus_per_grp =3D ncpus / nv->ngroups;
> =20
> -		/* Account for extra groups to compensate rounding errors */
> -		if (extra_grps) {
> +		/*
> +		 * Rotate which groups get the extra CPU so that
> +		 * successive callers produce different mappings,
> +		 * avoiding IRQ stacking when multiple devices
> +		 * share the same CPU topology.
> +		 */
> +		if (extra_grps &&
> +		    (v + spread_offset) % nv->ngroups < extra_grps)
>  			cpus_per_grp++;

[Severity: Medium]
Can this addition overflow and break the CPU allocation?

The commit message and comments state that wrapping of the unsigned
counter is harmless. However, if spread_offset is very close to UINT_MAX,
v + spread_offset can wrap around mid-loop.

Since 2^32 is generally not a multiple of nv->ngroups, the overflow causes
the modulo result to skip some values and duplicate others.

This means the condition (v + spread_offset) % nv->ngroups < extra_grps
might evaluate to true more times than there are extra groups.

If cpus_per_grp is incremented too many times, the loop will consume more
CPUs than available, prematurely exhausting nmsk and leaving subsequent
masks empty.

Would it be safer to apply the modulo before the addition, such as:
(v + (spread_offset % nv->ngroups)) % nv->ngroups ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810062144.2108=
758-1-namjain@linux.microsoft.com?part=3D1
