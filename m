Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5956472
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930508; cv=none; b=aNad7ue7QoISl7jUu6RqV8hnfQmNCaSWEB3InrUweHx5W0tjtNTE61J5r7tlnVUvMu8RBhBA4OjiGRd6RDzBgY1hVTA+vVmW8FKCNmQt8lgIpPY9A4ig1ahk48xYDSIUCXUaFiQyE1fy4rVEPsOj4FNcftUXXdWIFcMjTQ9h2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930508; c=relaxed/simple;
	bh=3BOvnR8U2l1jYiddoQTp87DNdCJJSd1qqbnydmph38A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxiocFkmZWy089qk9uecMIJMIePeQVAKvvCLpdYZBWxvxzYggnGSLgK89gxJTRSFTmgvOaC8OkrAjKPOONKpBGyFPBWFL7ftT8kYOEcbUWoAl3j5Uq/t46DTF4rPnfz1V7MJRxS40KPskOG0rAA+5z2BpzFNOZpcFvYuARSlP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvLuKKtu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvLuKKtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A36C1F000E9;
	Thu, 28 May 2026 01:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930507;
	bh=zjxJKi6ZWHYom4uYtI2EgLRNiN+Td+93zN0lznGZd2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QvLuKKtuvuRNrapF9GT+aaKBru2RBpIJ7pVF6ugRMRBawddVBlTrYWXA75L4asn7K
	 HZyj3FjuyIUByGeFPQKZwiJ5aQrnIn4lm4RFXmxnaCWQtXXnS5lDS04rh6E4mqkAKj
	 2lC0fSIJK2B7DUAB/Qif4Q4s499qeM9Qqtst+iF6DRXBqhlEOfEl7vvcv5EJ0iWQjk
	 3hkpHkwez8qG+YtspSTB21PnedBqO3dJf76i7fmvDhhBGtq3EsT9jdUHwO303wyTlQ
	 h42Twk+dG14Uw4RU+X2gFo7n7rFy0kp7fhLeC687fR0AWIhuIRUSfRETllTmrO/MAW
	 /3haSlTOAdxEg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/20] kho: store incoming radix tree in kho_in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-3-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-3-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:08:26 +0000
Message-Id: <20260528010827.2A36C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing error handling leads to boot panic
--

commit 84425fcb93791aa9b9c2db978b57ed659f2c9ec2
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: store incoming radix tree in kho_in

This commit stores the incoming radix tree in the kho_in struct to allow
other functions to use it. It also refactors the code to use
kho_get_mem_map_phys() for retrieving the radix tree root from the FDT.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c

[ ... ]

> @@ -1395,24 +1396,10 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
> =20
>  static int __init kho_mem_retrieve(const void *fdt)
>  {
> -	struct kho_radix_tree tree;
> -	const phys_addr_t *mem;
> -	int len;
> -
> -	/* Retrieve the KHO radix tree from passed-in FDT. */
> -	mem =3D fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
> -
> -	if (!mem || len !=3D sizeof(*mem)) {
> -		pr_err("failed to get preserved KHO memory tree\n");
> -		return -ENOENT;
> -	}
> -
> -	if (!*mem)
> -		return -EINVAL;
> -
> -	tree.root =3D phys_to_virt(*mem);
> -	mutex_init(&tree.lock);
> -	return kho_radix_walk_tree(&tree, kho_preserved_memory_reserve);
> +	kho_in.radix_tree.root =3D phys_to_virt(kho_get_mem_map_phys(fdt));

[Severity: High]
Can this lead to a boot panic if kho_get_mem_map_phys() fails?

If kho_get_mem_map_phys() returns 0 on failure, phys_to_virt(0) will likely=
=20
generate a non-NULL pointer. This bypasses the safety validation later when=
=20
walking the tree:

kernel/liveupdate/kexec_handover.c:kho_radix_walk_tree()
    if (WARN_ON_ONCE(!tree->root))
        return -EINVAL;

Walking the tree with this invalid address would then trigger a panic durin=
g=20
early boot.

I note this issue appears to be fixed later in the series by commit=20
80928d5942267 (kho: return virtual address of mem_map), but wanted to point=
=20
out the temporary breakage here.

> +	mutex_init(&kho_in.radix_tree.lock);
> +	return kho_radix_walk_tree(&kho_in.radix_tree,
> +				   kho_preserved_memory_reserve);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D2
