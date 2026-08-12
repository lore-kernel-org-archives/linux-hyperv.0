Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A42C11E2
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Aug 2026 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493703; cv=none; b=iYCDF+EyE2wTEDqjjZXgO3GWniNjZX1tM5Fd2LrGnVDOVKNqumtgzg2j0QYIwBBDlvJnp7vZRlOdEULUcPmLHp25A+YA4nVEzk8ckVgfHBr6gb8m3jDbLiWsJEaTxIC2Ro7bHAKz+7jnTs9yb4HcvpzOo3jh69IQNCWZxKQNjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493703; c=relaxed/simple;
	bh=2KV448a6/Ec4G1KwujFiXOwqJvsH0xjQ3eRqL0GgW0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tRL2bkGL7SnUfgm0GGHo99VBYyqrGTtQgLh1J4EHv1MgkOhhK3XDZAgcAhh+/vf0JbZKLjkzzNetqiZB99c8fTpQD0dxV681rQOyTEOZQakP6nRRe5nTZANAeN1uj5zBzw7B266Ixeqw/ipQbftcAKISS3Ng4ghtKl+8kk6Pbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJF5E4H7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJF5E4H7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D431F000E9;
	Wed, 12 Aug 2026 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493702;
	bh=+WiNGYZVatH8L65eAtBciGsHp9TR5rWZDN2qyErPY7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJF5E4H7Ua+LqTBrqA2PqeJ5IYFj7BLjiln228wc6HSBfaz3WhUCC8Cs84oj7gWji
	 evZ83dxBmCK7IlcmZe56eIpgqTd1WPtuspuxUZGDl7oduPZfxawFEiNXE+8UiOWX/4
	 JTm3rgojC0mBxzotblzItt3Iild185d0DMWHYucEiG22l85KW85wi2UuDbTJySpWFo
	 Ar6ecfVyWpzhQNMexcrE77yX77kjg8kop1kiRcoT5VJrKYYjoXuj72yaUHhEtgd3aE
	 VEJsppme40QsRe7u9WU8aF+gfPxhyulIfPFuvKBUBYM0GluTA3Z9o83u5yusutcEDQ
	 kHPVULitfG6eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V0 2/2] mshv: Redesign hypervisor memory deposit logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260812000507.3809046-3-mrathor@linux.microsoft.com>
References: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
 <20260812000507.3809046-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:15:01 +0000
Message-Id: <20260812001502.55D431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect memory allocator and cleanup for contiguous pages leads =
to memory corruption and kernel crashes.
- [High] Unhandled partial success in the deposit memory rep hypercall lead=
s to memory corruption.
- [Medium] Optimistic high-order allocations missing __GFP_NOWARN will spam=
 the kernel log.
--

--- Patch [2]: [PATCH V0 2/2] mshv: Redesign hypervisor memory deposit logi=
c ---
commit 8f3cb1a3334e617608894587fd59c0c23c46b19a
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Redesign hypervisor memory deposit logic

This commit redesigns the hypervisor memory deposit logic to improve
performance. It attempts a contiguous 2M allocation and minimizes allocatio=
ns
to speed up the deposit process while handling contiguous requirements.

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index d5ce9a032e9c7..fd74c286e6129 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -9,15 +9,182 @@
>  #include <linux/export.h>
>  #include <asm/mshyperv.h>
> =20
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +#define HV_DEPOSIT_MAX 512
> +#define HV_DEPOSIT_INP_MAX ((HV_HYP_PAGE_SIZE -  \
> +	offsetof(struct hv_deposit_memory, gpa_page_list)) / sizeof(u64))
> +
> +static int hv_alloc_contig_pages(int node, u64 *pfna, u64 *lastpfnp,
> +				 int num_pages)
> +{
> +	void *p;
> +	int i, tmp;
> +	ulong pfn;
> +	size_t size =3D num_pages * HV_HYP_PAGE_SIZE;
> +
> +	if (num_pages > HV_DEPOSIT_MAX ||
> +	    (num_pages =3D=3D HV_DEPOSIT_MAX && lastpfnp =3D=3D NULL))
> +		return -EINVAL;
> +
> +	p =3D kmalloc_node(size, GFP_KERNEL, node);

[Severity: High]
Does this kmalloc_node() allocation lead to memory corruption or crashes?

For small requests, kmalloc_node() returns memory from a slab cache, sharing
the physical page with other objects. For large requests (e.g. 512 pages/2M=
B),
it returns a compound page.

When these PFNs are handed to the hypervisor, the hypervisor takes full
physical ownership of the page. If it's a slab-managed page, won't this cor=
rupt
other kernel objects residing in the same slab page?

Additionally, when this is a compound page, isn't there a risk in the error
path below?

hv_alloc_contig_pages()
    p =3D kmalloc_node(size, ...);

hv_call_deposit_memory()
    __free_page(pfn_to_page(lastpfn));

Since this lastpfn is a tail page of a compound allocation, won't __free_pa=
ge()
trigger a VM_BUG_ON_PAGE(PageTail(page), page) and crash the kernel?

> +	if (p =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	pfn =3D PFN_DOWN(virt_to_phys(p));
> +	tmp =3D min(num_pages, HV_DEPOSIT_INP_MAX);
> +
> +	for (i =3D 0; i < tmp; i++, pfn++)
> +		pfna[i] =3D pfn;
> +
> +	if (num_pages =3D=3D HV_DEPOSIT_MAX)
> +		*lastpfnp =3D pfn;
> +
> +	return num_pages;
> +}
> +
> +
> +/*
> + * Allocate free pages for deposit to hypervisor. pfna[] must be large e=
nough
> + * to hold HV_DEPOSIT_INP_MAX (511) pages. If num_pages is 512, return l=
ast
> + * pfn in lastpfn.
> + *
> + * Returns : -ENOMEM if zero allocated, else number of pages allocated
> + */
> +static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int nu=
m_pages)
> +{
> +	struct page *page;
> +	int num_allocd, count =3D 0;
> +
> +	/* Published ABI, enforce its immutability. */
> +	BUILD_BUG_ON(HV_DEPOSIT_INP_MAX !=3D 511);
> +
> +	if (num_pages > HV_DEPOSIT_MAX ||
> +	    (num_pages =3D=3D HV_DEPOSIT_MAX && lastpfnp =3D=3D NULL))
> +		return -EINVAL;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		int order =3D 31 - __builtin_clz(num_pages);
> +
> +		while (1) {
> +			page =3D alloc_pages_node(node, GFP_KERNEL, order);

[Severity: Medium]
Should this high-order allocation attempt include the __GFP_NOWARN flag?

High-order allocations frequently fail on fragmented systems. Because this
failure is fully expected and handled gracefully by the fallback loop
decrementing the order, this warning is spurious and could needlessly spam =
the
kernel log, or even crash the system if panic_on_warn is enabled.

> +			if (page || order =3D=3D 0)
> +				break;
> +
> +			order--;
> +		}
> +
> +		if (page =3D=3D NULL)
> +			break;

[ ... ]

> +static int hv_call_deposit_memory(int node, u64 partition_id, bool conti=
guous)
>  {

[ ... ]

> +	/* We are not using hyperv_pcpu_input_arg, so no need to disable */
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages,
> +				     0, hc_input, NULL);
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "\n");
> +		rc =3D hv_result_to_errno(status);
> +		goto out_free_dep_pages;
> +	}

[Severity: High]
Could this error path cause memory corruption if the rep hypercall partially
completes?

Rep hypercalls can partially complete (e.g., due to a timeout or interrupt =
in
the hypervisor). In this case, hv_result_success(status) returns false, but
hv_repcomp(status) indicates the number of successfully processed elements.

Since the code treats any non-success status as a complete failure, jumping
directly to out_free_dep_pages without checking hv_repcomp(status), won't t=
he
error path blindly free pages that were already consumed by the hypervisor?

This could lead to Linux and the hypervisor concurrently using the same
physical pages.

> +
> +	if (lastpfn) {
> +		hc_input->gpa_page_list[0] =3D lastpfn;
> +		status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
> +					     hc_input, NULL);
> +		if (!hv_result_success(status))
> +			/* We deposited some earlier, so just free this */
> +			__free_page(pfn_to_page(lastpfn));
> +	}
> +
> +	free_page((unsigned long)hc_input);
> +	return 0;
> +
> +out_free_dep_pages:
> +	for (i =3D 0; i < num_pages; i++)
> +		__free_page(pfn_to_page(pfna[i]));
> +	if (lastpfn)
> +		__free_page(pfn_to_page(lastpfn));
> +
> +out_free:
> +	free_page((unsigned long)hc_input);
> +	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812000507.3809=
046-1-mrathor@linux.microsoft.com?part=3D2
