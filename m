Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559F248886
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931282; cv=none; b=gmBdRjWiPP/fzfwEUN8014VRiu44mDGo2gTDOxSTc8OdQwwyzbJqI32iHtDcrGex5Ng+dCiqnJdA7VXRwsVLPj5N6037CMfbPNodgoIqEHUmJ5EK1dqLHiJ5CYQZofv0jyriMcfzut/w9ZmzOntYc4pUL2GtUWwe4jCNUTdoJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931282; c=relaxed/simple;
	bh=CbunhDg7kIgjqwJfU4DTycQ0Lo6ZlNbfvbyKjfMq+Xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rvCHCMwqq2fOBWHBqgWxejPjDkVbxziLD1rAHWSNulKZZEZFncRqP9ou0C/X8XE7Z3kCs259sW0UF+4BtgQchuOjbiMQLkDb3/05sDLwfUtSmqhG/c1+J1mLeDcmwSjpwHnQo7hTw6bcCTpE/EF2+d3jMOU+5MVqpB7qn9hAw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vil+JATk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vil+JATk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074A01F000E9;
	Thu, 28 May 2026 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779931278;
	bh=vdzgEYy5hKMmiuN9uq4W2aQTUXdh5HswQ74XPNGYMqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vil+JATkmUUDsNJMXBy8NOpsz6l3waCLgAKmP6Nirz4e6fO9icq7hVzK9d9+Opn2f
	 XKP9itmj9egIvhs7HlJfHY945T4hwp5c4WqIQhyvTcrIIFqpbcSTXCcqzvMstoHxLe
	 tGj3lJqxdUPtCkEbfdaEuC//yNUnwr/L99EE1FgTTIRnqXnLGPuvQjpfsfYK1tdRaj
	 09Hmb8+gPYeo4wDmar5WC8rBX46C+gwIgimhZjEQZDZfxdBxP67ilDo06ikQCVFoNH
	 pPAbo6x9BwgOtbaM32STYas3zYUWYxkm8If45xXVL1yE7j38mwSlM93WoXAy9/ydsw
	 YuLSAhcPxQatA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/20] kho: extended scratch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-11-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-11-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:21:17 +0000
Message-Id: <20260528012118.074A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing error check for `kho_get_mem_map_phys()` return value
- [High] Missing static inline stub for `kho_extend_scratch()` causes build=
 failures
- [High] 32-bit integer overflow in `kho_ext_mark_scratch()` causes incorre=
ct physical address calculations
- [Medium] Uninitialized stack variable `radix` passed to `kho_radix_init_t=
ree()`
- [Medium] Nested acquisition of mutexes from the same lockdep class
--

commit 69c3d241e681519286b4c5b53a9ed0d4287fb2b8
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: extended scratch

The scratch space is allocated by the first kernel in the KHO chain and reu=
sed.
This commit introduces extended scratch areas discovered at boot by walking=
 the
preserved memory radix tree.

> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handove=
r.h
> index 8968c56d2d73e..6ce46f36ed992 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -37,6 +37,7 @@ void kho_remove_subtree(void *blob);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *si=
ze);
> =20
>  void kho_memory_init(void);
> +void kho_extend_scratch(void);

[Severity: High]
Does this missing static inline stub cause build failures when
CONFIG_KEXEC_HANDOVER=3Dn?

kho_extend_scratch() is called unconditionally from mm_core_init_early().
However, its prototype here is only declared when CONFIG_KEXEC_HANDOVER is
enabled. Compiling the kernel with CONFIG_KEXEC_HANDOVER=3Dn will result in=
 an
implicit function declaration error.

[ ... ]

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index b2d1572808ebf..a006a883ee94a 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
[ ... ]
> @@ -825,6 +842,120 @@ static void __init kho_reserve_scratch(void)
>  	kho_enable =3D false;
>  }
> =20
> +#define KHO_EXT_SHIFT 30 /* 1 GiB */
> +
> +static int __init kho_ext_walk_key(unsigned long key, void *data)
> +{
> +	struct kho_radix_tree *tree =3D data;
> +	phys_addr_t start, end;
> +	unsigned int order;
> +	int err;
> +
> +	start =3D kho_decode_radix_key(key, &order);
> +	end =3D start + (1UL << (order + PAGE_SHIFT));
> +
> +	while (start < end) {
> +		err =3D kho_radix_add_key(tree, start >> KHO_EXT_SHIFT);

[Severity: Medium]
Will this trigger a lockdep warning due to nested acquisition of mutexes fr=
om
the same lockdep class?

When kho_radix_walk_tree() is called on kho_in.radix_tree, it acquires its
lock and then calls this walk callback. This callback calls kho_radix_add_k=
ey()
on the new radix tree, which acquires its lock. Because both locks are
initialized by kho_radix_init_tree(), they share the same lockdep class.
Acquiring a second lock of the same class without using mutex_lock_nested()
can trigger a "possible recursive locking detected" lockdep warning.

> +		if (err)
> +			return err;
> +
> +		start +=3D (1UL << KHO_EXT_SHIFT);
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int __init kho_ext_mark_scratch(unsigned long key, void *data)
> +{
> +	phys_addr_t *prev_end =3D data;
> +	phys_addr_t start =3D key << KHO_EXT_SHIFT;

[Severity: High]
Can this cause a 32-bit integer overflow on 32-bit architectures?

The key variable is of type unsigned long, which is 32-bit on 32-bit
architectures. Since KHO_EXT_SHIFT is 30, any key >=3D 4 (representing memo=
ry at
or above 4 GiB) will overflow the 32-bit shift and result in a truncated
address. Should key be cast to phys_addr_t before shifting?

> +	int err;
> +
> +	if (start > *prev_end) {
> +		err =3D memblock_mark_kho_scratch_ext(*prev_end, start - *prev_end);
> +		if (err)
> +			return err;
> +	}
> +
> +	*prev_end =3D start + (1UL << KHO_EXT_SHIFT);
> +	return 0;
> +}

[ ... ]

> +void __init kho_extend_scratch(void)
> +{
> +	const struct kho_radix_walk_cb kho_cb =3D {
> +		.key =3D kho_ext_walk_key,
> +		.table =3D kho_ext_walk_table,
> +	};
> +	const struct kho_radix_walk_cb ext_cb =3D {
> +		.key =3D kho_ext_mark_scratch,
> +	};
> +	struct kho_radix_tree radix;

[Severity: Medium]
Is it safe to pass this uninitialized stack variable radix to
kho_radix_init_tree()?

It is allocated on the stack but not zero-initialized. If kho_radix_init_tr=
ee()
conditionally initializes its fields (e.g., checking if tree->root is non-N=
ULL
to avoid double initialization for global trees), it could read garbage sta=
ck
memory and return without initializing radix.lock. Subsequent operations wo=
uld
then dereference uninitialized pointers.

> +	phys_addr_t prev_end =3D 0, mem_map_phys;
> +	int err =3D 0;
> +
> +	if (!is_kho_boot())
> +		return;
> +
> +	/* Make sure the KHO radix tree is initialized. */
> +	mem_map_phys =3D kho_get_mem_map_phys(kho_get_fdt());
> +	err =3D kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_ph=
ys));

[Severity: High]
Does this code miss checking the return value of kho_get_mem_map_phys()?

kho_get_mem_map_phys() returns 0 on failure (e.g., missing FDT property),
and this return value is passed directly to phys_to_virt() without validati=
on.
If the map is missing, the code will initialize the KHO radix tree using
physical address 0x0 as the root, leading to arbitrary memory being parsed
as tree nodes, which can cause memory corruption or a kernel panic during
early boot.

> +	if (err)
> +		goto print;
> +
> +	err =3D kho_radix_init_tree(&radix, NULL);
> +	if (err)
> +		goto print;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D10
