Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139B33ADAF
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683919; cv=none; b=OwjjRsQqH1DGx5BT0/xBv6HgZiReggCQ5bSTbj+TjsRWJf6eoqf2v/Q+TBpnlVqLF5O5d0e8wYDdOe6mWDuZwMHxRkZ7QJf6kXnZThv/tQT18uDwN18tV3+7jQ9suGKoVfyhwamE47bdTYE1bAk+57SvjtSdHkrXd1zC0lhaXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683919; c=relaxed/simple;
	bh=395nsJX3b6JO9wdnp7r9VgZx0fJ0ndrtINCME71aniY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NUbCbgih9xK5lFAaLcIIb+Nog5BsTyfkLDH+Ik1MvOlVMKPWcL6U8NA1nmfGjuXrGCaSuGY6rsfgVQvlt9zx76t1QRZO12mtZ3QoaJ4JYNnu8GIY11PMqmIy1gcD4il9EvNZehS/X/U+0JOXTEqrPHgMhPeOdaF7QH0QBL2k5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP3kBkMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP3kBkMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF901F00A3A;
	Fri, 14 Aug 2026 05:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683918;
	bh=DzJeKy3DOOFQ2rYjipmyJgtCk43uLm5JDPcQv6lU61Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HP3kBkMz0goraaQwz++w4T3LCxtrHAj1JxJrDe6I6OZ9rJn8YLVwywsbN3j8+2IYq
	 N7npWbTPjjLiOPLtkqOuBPbV4q1X97+ZewzRw+zTgh2Hwbwu8WiIznti+XvZUdwc+5
	 3o6xC8OyDfG/OqZ0eybxa5ph9/okCrangKdqnD+8UV+EuUaZuKrEHEfuTzpJtTb7Ez
	 JqpcA0tjGst9HB9+JoMMH9VsAC/2Q1cRWeN5CVUxG+cIdP07klsfdtdXgBWk003Pan
	 IeKGbHVmS9jnWOxDAnuJgqvjaWqtzBbi3a8Z1EEwcWhc4Shsvd0bBXR4Gp/p49Cw+z
	 milrN6W6g439Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 03/13] net: mana: swap queue sets in
 mana_set_ringparam
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-4-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-4-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:17 +0000
Message-Id: <20260814050517.CAF901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Hardware Resource Exhaustion (MSI-X vectors) / Functional Regressi=
on
- [High] Ad-hoc Synchronization with Flags

Pre-existing issues:
- [High] State Loss (RSS Indirection Table)
--

--- Patch [3]: [PATCH net-next v2 03/13] net: mana: swap queue sets in mana=
_set_ringparam ---
commit e63909b90b30b5041af0319613913c9654a4cc80
Author: Long Li <longli@microsoft.com>

net: mana: swap queue sets in mana_set_ringparam

Convert the ring size path to pre-allocate and swap, for the same reasons
as the channel count path. An allocation failure returns the error with
the running configuration untouched, and the vport is never released.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index b12291555eaeb..40e9886c87a81 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -791,32 +790,61 @@ static int mana_set_ringparam(struct net_device *nd=
ev,
[ ... ]
> +	/* Block RDMA from acquiring the vport for the duration. The vport
> +	 * itself is never released, so vport_use_count stays > 0.
> +	 */
> +	mutex_lock(&apc->vport_mutex);
> +	if (apc->channel_changing) {
> +		mutex_unlock(&apc->vport_mutex);
> +		return -EBUSY;
>  	}
> +	apc->channel_changing =3D true;
> +	mutex_unlock(&apc->vport_mutex);

[Severity: High]
Does this code use apc->channel_changing as an ad-hoc lock?

Since this flag is set on entry and cleared on exit to prevent concurrent
RDMA vport access, could we use a proper synchronization primitive here ins=
tead
of a boolean flag?

> =20
> -	apc->tx_queue_size =3D new_tx;
> -	apc->rx_queue_size =3D new_rx;
> +	scratch =3D mana_qset_scratch_alloc(apc);
> +	if (!scratch) {
> +		err =3D -ENOMEM;
> +		goto clear_flag;
> +	}
> =20
> -	err =3D mana_attach(ndev);
> +	err =3D mana_alloc_qset(scratch, apc->num_queues, new_rx, new_tx,
> +			      apc->priv_flags, &newq);

[Severity: High]
By pre-allocating a complete new queue set alongside the existing one, does
this require twice as many MSI-X vectors simultaneously?

If the system is already fully utilizing its vectors, could mana_create_eq()
fail to acquire vectors from the MSI-X pool, causing the ring parameter
changes to reliably fail with -ENOSPC?

[Severity: High]
This is a pre-existing issue, but does this code cause a loss of the custom=
 RSS
indirection table?

During mana_alloc_qset(), mana_rss_table_init() is called, which unconditio=
nally
overwrites the indirection table with default round-robin values. If a user
has configured a custom RSS indirection table, will those settings be
irrevocably destroyed here?

[ ... ]
> +clear_flag:
> +	mutex_lock(&apc->vport_mutex);
> +	apc->channel_changing =3D false;
> +	mutex_unlock(&apc->vport_mutex);
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D3
