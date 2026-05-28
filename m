Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0027E05F
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931304; cv=none; b=AVhrDT2YIjz5Yw/iYIgs0qCRffuQk/3Ptpmq+mHAEU+V3sPTDJ2uX5CRByZysejoZIKvMqw7fTJ2BuGO+5xLNCmcgyePkMqaUuW+Yi40VzbXJEgJ4e6XjmKlEslfOvlYuEToRGdYziTu0gLm3VwDf0nlvQIuK8A+spL4C+R+e0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931304; c=relaxed/simple;
	bh=wNq6e9kIu2mtW1H3H0cAqnEgnHoLJWbVs16JBawMzgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GcwMjXBPXSDf+5wEm+3hqha6x7Z/i5oJzfpkLaKGFKI/zCPWBCfIlqW7sO+T9rXHa6izcjo3kiYgIGzx2TbMJW6iVfX/cXi84ELkxDH3mE87lOUooZZjLKuXymBdYUpfUORCwpQoXu3tlQhEcUpcwetD8HXOGJWHkE4ztn/owAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOw3f5c6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOw3f5c6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EEE1F000E9;
	Thu, 28 May 2026 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779931301;
	bh=zFQpxDtsufSj3eBE7q0Fh35E/2tM/RR0DWou/Rml9Ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOw3f5c6eqHWTp7tjLUGlaGnR6KS5q303M+ZcI5SxHUQ7H7HBGnuMrtaZyu75BaF9
	 RP8qkR7MheYS4iXzwdkdc9CFZdf0wkVIiTM/cPI5hJFWtaClVv5Wpme2Sljob+mCfi
	 TMZ9RVYNVq8rczapr2xKM+6Gcgu6S7g1JHykoR5uLqbAVqEpqmGUzMJQlbAAMHwHMe
	 8hIgNDWVmGKjR3BJWURouCHUBGwZYqRKNmlrxkWk3HzfdM9MAz4Krv9ZVZA7KzjzJ6
	 llggE+C3XAWS+GdU5dgowDv6DqMqZHE+vLrCTgsIZjqGVLeq/w7dwJLNjBXW70U3sH
	 ctSCnHxBpG1ag==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/20] kho: add kho_radix_init_tree()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-9-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-9-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:21:40 +0000
Message-Id: <20260528012141.49EEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kho_radix_destroy_tree() leaves tree->root dangling, causing subse=
quent re-initializations to erroneously succeed and lead to Use-After-Free.
--

commit d207a159c7c112b64706fe2fb64399a65932fdb6
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: add kho_radix_init_tree()

Move the initialization logic of the radix tree into
kho_radix_init_tree() instead of having users open-code it. Makes the
boundaries cleaner and reduces code duplication when a new user of the
radix tree will be added in a future commit.

[ ... ]

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 3f3ea71baa1ad..b2d1572808ebf 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -305,6 +305,34 @@ static void __kho_radix_destroy_tree(struct kho_radi=
x_node *root,
>  	kho_radix_free_node(root);
>  }
> =20
> +/**
> + * kho_radix_init_tree - initialize the radix tree.
> + * @tree:   the tree to initialize.
> + * @root:   root table of the radix tree.
> + *
> + * Initialize the radix tree with the given root node. If root is %NULL,=
 an
> + * empty root table is allocated. If root is not %NULL, it is the caller=
's
> + * responsibility to make sure the root is valid and in the correct form=
at.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_no=
de *root)
> +{
> +	/* Already initialized. */
> +	if (tree->root)
> +		return 0;

[Severity: High]
Can this cause a use-after-free if a tree is re-initialized?

Looking at kho_radix_destroy_tree(), it frees the tree nodes but does not s=
et
tree->root to NULL:

kernel/liveupdate/kexec_handover.c:kho_radix_destroy_tree() {
	if (!tree->root)
		return;

	__kho_radix_destroy_tree(tree->root, KHO_TREE_MAX_DEPTH - 1);
}

If a tree is destroyed and then kho_radix_init_tree() is called on it again,
wouldn't this check see the dangling tree->root pointer and incorrectly ret=
urn
success, leading to a use-after-free on subsequent tree operations?

> +
> +	if (!root)
> +		root =3D kho_radix_alloc_node();
> +	if (!root)
> +		return -ENOMEM;
> +
> +	tree->root =3D root;
> +	mutex_init(&tree->lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_radix_init_tree);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D8
