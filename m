Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454E19E819
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932894; cv=none; b=IpH46+mfiy6hpMb3ZgDF9KdoKoEArWzR22oBZzGF5jL4GwHoegi5EtBrSMdp6AqGPVCFmArVe5+M1ovjIIjXyKkAopGYQh+21xArwEOi0FJkoUNtnNYZ0Qh6Ra5HO0Rism598hFZWjBR5J+DMbV/a6Iemxdy1v60e5TT7N8U7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932894; c=relaxed/simple;
	bh=aKhgTyu4AqrG15kaRNG9I/QZVlpmw1pGD96NWRs8XwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Shc6U66uKh3VzJJUX0C1REUvsDhwkubAXr+QIPTLDmqGoTnB9ugnNFpO7I+G9+D9i5Aa+PtYsv9NIiDZPsWqXbPsipfekLKoUnxTyaNwMqnZx4kHiFaEuSSYDtBAGlQRkHqrdB4jo+QneVF39hrhIdnCbV7ONgB7UM/FryjLKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLS3oTYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLS3oTYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF601F000E9;
	Thu, 28 May 2026 01:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779932892;
	bh=oKrosg7WWvXhkpwAVuFfYpER/s+YN2zqhUdY1qUl3Dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLS3oTYcrXNFWsl9prbDqeuZdqQ2iBtCBidyvuo4ylmPdiOJIyCZjoQZVuaK28jim
	 s0y6RPTzH4Lun3+vRDEZ8++2Dexiz77a5ss+BXroqF2Fif1/1AZia+/UZm93YtHJcB
	 sBIbSrUkGNSIOkmYmMBOigWxlbnIVNdfeByoQ96Enpbigz6TDuOZUa+MMN0Wr90vWw
	 EK657zt8VyuHiaO9aNFERAGCenJIH3iGjCD6eO+lpgAxyOy7M208Na+vMFNh+6CAZk
	 BGTQqYKuQYczBPDoEPuqGExxqWxh0SybQ8UQKmskNp7BB0keBuM3x47V8kGmryYrgQ
	 YP7/66LdYnmEQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 16/20] mshv: Add debugfs interface to page tracker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-17-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-17-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:48:11 +0000
Message-Id: <20260528014812.2DF601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The newly introduced `mshv_iterate_preserved()` and its debugfs =
callers invoke KHO APIs without checking `kho_is_enabled()`, triggering a k=
ernel warning on systems where KHO is disabled.
- [Medium] The error handling path in `mshv_debugfs_init()` fails to clean =
up resources allocated by `mshv_debugfs_parent_partition_create()`.
- [Medium] The `pt_tree` debugfs interface uses `single_open()` for potenti=
ally unbounded radix tree iteration, leading to O(N^2) processing overhead,=
 prolonged lock contention, and allocation failures.
--

commit 0782bfee5c54e7b8251a28d7d1fba762890a41cc
Author: Jork Loeser <jloeser@linux.microsoft.com>

mshv: Add debugfs interface to page tracker

This commit adds debugfs files to expose statistics and tracked pages from =
the
MSHV page tracker, as well as the scheduler type. It also adds a new API to
iterate over preserved pages using the KHO radix tree.

> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
> index 3c3e02237ae94..d79898e21b361 100644
> --- a/drivers/hv/mshv_debugfs.c
> +++ b/drivers/hv/mshv_debugfs.c

[ ... ]

> @@ -668,8 +675,89 @@ void mshv_debugfs_partition_remove(struct mshv_parti=
tion *partition)

[ ... ]

> +static int pt_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct kho_radix_walk_cb cb =3D {
> +		.key =3D pt_count_data_cb,
> +		.table =3D pt_count_meta_cb,
> +	};
> +
> +	struct mshv_pt_stats pt_stats =3D {0};
> +
> +	mshv_iterate_preserved(&cb, &pt_stats);

[Severity: Medium]
Is it possible to read this file when KHO is disabled?

According to KHO subsystem rules, callers must gate KHO usage on
kho_is_enabled(). If kho_is_enabled() is false, preserved_pages_tree may re=
main
uninitialized (root is NULL), and kho_radix_walk_tree() will trigger a kern=
el
warning.

> +	seq_printf(m, "Data pages: %lu\n", pt_stats.count_data);
> +	seq_printf(m, "Meta pages: %lu\n", pt_stats.count_meta);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pt_stats);

[ ... ]

> +static int pt_tree_show(struct seq_file *m, void *v)
> +{
> +	const struct kho_radix_walk_cb cb =3D {
> +		.key =3D pt_tree_data_cb,
> +		.table =3D pt_tree_meta_cb,
> +	};
> +
> +	struct mshv_pt_stats pt_stats =3D {.stat_file =3D m};
> +
> +	mshv_iterate_preserved(&cb, &pt_stats);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pt_tree);

[Severity: Medium]
Will this lead to large allocations and O(N^2) lock contention for large VM=
s?

DEFINE_SHOW_ATTRIBUTE() uses single_open(), which requires all output to fi=
t in
a single contiguous kmalloc buffer. Iterating over all preserved pages can =
scale
to millions of pages.

If the output exceeds the initial seq_file buffer, seq_printf() discards the
overflow, but the tree traversal continues to completion. Afterwards, seq_r=
ead()
will reallocate a larger buffer and restart the entire traversal. This crea=
tes
an retry loop that monopolizes the KHO radix tree lock and will likely
fail with -ENOMEM when kmalloc reaches the MAX_ORDER limit.

Should unbounded outputs use stateful seq_operations instead?

[ ... ]

> @@ -694,6 +782,17 @@ int __init mshv_debugfs_init(void)
>  	if (err)
>  		goto unmap_lp_stats;
> =20
> +	err =3D mshv_debugfs_pt_create(mshv_debugfs);
> +	if (err)
> +		goto unmap_lp_stats;

[Severity: Medium]
Does this error path bypass cleaning up the parent partition stats?

If mshv_debugfs_pt_create() fails, it jumps to unmap_lp_stats, which
skips mshv_debugfs_parent_partition_remove(). This appears to permanently l=
eak
the resources allocated by the preceding mshv_debugfs_parent_partition_crea=
te()
call.

> +
> +	d =3D debugfs_create_file("scheduler_info", 0400, mshv_debugfs, NULL,
> +				&scheduler_info_fops);
> +	if (IS_ERR(d)) {
> +		err =3D PTR_ERR(d);
> +		goto unmap_lp_stats;
> +	}
> +
>  	return 0;
> =20
>  unmap_lp_stats:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D16
