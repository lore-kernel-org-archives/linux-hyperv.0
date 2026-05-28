Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F756472
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930677; cv=none; b=HPiHXhmVZLFc8ojSkBbqqzSjpcMy6U2d7ieKFoCG0OKdEXRIzW84rxNcfKze2kBLrpmdg/nuGfnC2VfPRUTCyn63+2kHNe4TYsWowtuHsRmWMAPA5LiQF3xGA/PP7j1mPWrgWtC0MmhxM/VtzhrVo6W5seoYZGM2CqpRNDUb0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930677; c=relaxed/simple;
	bh=GvD6WJprIDWLDHRC3L+2zF60iNpPIcQIZ25j29WsUFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PehagnZVzFSKgy1PkZXBVuZ01OcpM2h/vgG0WANqXLYPEtbWD8N7E+W+UViPltE4C9S05SgPu9ipfdAE02LesLc+/ghBTfJ2g+fOrr9ijujRhg0nG4upPNUExXQmotE9pIZZdjPPqScTmyCnGPrihTOnefJan+nJMNPseqeh1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQD333YS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQD333YS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5951F000E9;
	Thu, 28 May 2026 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930676;
	bh=yC1UxtqLRW57L1gv/PlMfS17OxfhyuGZGKLFr8uxDDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQD333YSHj8G8csA5WGYj5+GFQ2nurVYgOo3xowYbxa5nd3gOwud1nepgyqF7U34W
	 JuaLhPeOxP1DMu1MqU21jJhm32rB0B+037wkWZaFYhSmpC5tJyxWn+gx4RqHOwB0yS
	 /awCbL84JXXcqiMvBfGapFAH+U+V08sObEeKK5vPGc/FEkiVjKeiCiK5r1bvcbcwc0
	 7cqoyZpBHqjlIR+o9PQcvzwrS+/1jbB589xclpqjTW1k6C9W1FGQoTFvDf02eWEadb
	 zE0rn9GLY2aNuY/9gMj7hXED5BSqtFj6BFOhh+Du0n1AD5XKwyZxPbUTPhv2D9ialN
	 J1Uf4i8JGa/vg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/20] kho: add data argument to radix walk callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-6-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-6-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:11:15 +0000
Message-Id: <20260528011115.DF5951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Signed integer overflow in size calculation in kho_preserved_memor=
y_reserve().
--

commit 64e1a8a692077719d0e7f42a7ff19088fba754f4
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: add data argument to radix walk callback

This commit adds an opaque data pointer argument to kho_radix_walk_cb_t.
This allows callers to pass extra information to the callback functions
during tree walks.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 0f8d058f1a272..f6de6bf632261 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c

[ ... ]

> @@ -486,7 +488,7 @@ static struct page *__init kho_get_preserved_page(phy=
s_addr_t phys,
>  	return pfn_to_page(pfn);
>  }
> =20
> -static int __init kho_preserved_memory_reserve(unsigned long key)
> +static int __init kho_preserved_memory_reserve(unsigned long key, void *=
data)
>  {
>  	union kho_page_info info;
>  	struct page *page;

[Severity: High]
This isn't a bug introduced by this patch, but does sz overflow when
calculating the memory size in this function?

Looking at kho_preserved_memory_reserve(), the memory size is calculated as:

    sz =3D 1 << (order + PAGE_SHIFT);

The literal 1 is a signed 32-bit integer. When KHO preserves memory using
kho_preserve_pages(), the maximum order is bounded by NUMA node boundaries
rather than MAX_PAGE_ORDER, allowing very large contiguous chunks to be
preserved as a single radix tree entry.

For example, if a 2GB contiguous memory chunk is preserved, the order is 19.
With PAGE_SHIFT =3D 12, order + PAGE_SHIFT is 31. The expression 1 << 31
overflows the signed 32-bit integer into -2147483648, which is then
sign-extended into u64 sz as 0xffffffff80000000.

If order + PAGE_SHIFT >=3D 32 (e.g., preserving a 4GB chunk), the behavior =
is
undefined and often evaluates to 1.

Calling memblock_reserve() with either of these invalid sizes will cause the
system to either exhaust all physical memory and fail to boot, or fail to
actually reserve the preserved memory, leading to severe memory corruption
when the successor kernel allocates and overwrites the preserved state.

Could this expression be updated to use the 1ULL literal to prevent
overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D5
