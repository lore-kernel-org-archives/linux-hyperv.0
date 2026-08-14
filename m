Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652726FA60
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683917; cv=none; b=u/VU0b8fBBuJdhF9/Otbdk00UP/UdYFkeOdkKhplvUArOjNcYVFi/gC4ut/aECCXwJst2ziKzXeOIq3QjMoJW27BnGffHhO1V0v8w/jOgf6VrZk7iYyKIytzGibZio6DeP7ahPCjNCwkZRE+CoJ+u61vIV52mi2E1GJnZ/JD5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683917; c=relaxed/simple;
	bh=7uxhvjA41si8hZ6c5LfcmLVN3xoDdkw561iiEakFxVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kiuZgqhFdzXXG/9JxhAKZMGklTJkciICBE4SrYGGwnrFgV4nl0skNPwXl02bEvKGjqjdA3qO3JtmDlkQ9ZERV5GysC7+7nYHv2bpq5xTuC0uk8uFK4sIuG9RIDM8XZIZD4q2MYroaIZngeUtQUvQhTiWfdgjsRUc2p1/fRJ5hVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvjaK5I3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvjaK5I3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C531F00A3A;
	Fri, 14 Aug 2026 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683916;
	bh=iI9hpViTr3y9QfvES3yNrixEOCmhHemHuYCE9HWCX18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FvjaK5I3S87X1SZLvZ7YBRhCVuM4LALQ9YTgmDT8Xs08Gx/jLHOLr5d94R38QMc3z
	 5n2YuwhaAWY4eOGpNMPOnwI6kkanCF59TiVd1tlq5ZFuqGTeDPSj0CvaBk2egiYpcu
	 jHY1WVT7k0THB02HWSv1H/cwJMm80N4L3JGOIRc3XnIaxRiWZECqkEXoFQnkJ/3YEX
	 t3+WXuR14N6k3dOYsQlwHnTu3R/5pgz+C5ZK4tHVMDzWkMmM6jiWihCJvB+MtzE0Dt
	 ig2WTbVyYWTHF9i0OUzN7h5z2E8iUAEJdp42TM7WJf2Y7yps9pDxkQmtA7Jzz1q4Dn
	 Kjf+/Bl9OYP8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 02/13] net: mana: swap queue sets in
 mana_set_channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-3-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:15 +0000
Message-Id: <20260814050515.D0C531F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mana_set_channels silently drops user-configured RSS indirection=
 tables
--

--- Patch [2]: [PATCH net-next v2 02/13] net: mana: swap queue sets in mana=
_set_channels ---
commit 20d58255702f027247917ff013e18e0c18e9845c
Author: Long Li <longli@microsoft.com>
Subject: net: mana: swap queue sets in mana_set_channels

This converts the channel count path away from detach/attach. It builds
the new queue set while the current one keeps serving traffic, then swaps
it in and retires the old one.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 04b7a5c0fdabc..b12291555eaeb 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -659,42 +659,88 @@ static int mana_set_channels(struct net_device *nde=
v,
>  	apc->channel_changing =3D true;
>  	mutex_unlock(&apc->vport_mutex);
> =20
> -	err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, new_count);
> -	if (err) {
> -		netdev_err(ndev, "Insufficient memory for new allocations");
> +	scratch =3D mana_qset_scratch_alloc(apc);
> +	if (!scratch) {
> +		err =3D -ENOMEM;
>  		goto clear_flag;
>  	}
> =20
> -	err =3D mana_detach(ndev, false);
> -	if (err) {
> -		netdev_err(ndev, "mana_detach failed: %d\n", err);
> -		goto out;
> -	}
> +	err =3D mana_alloc_qset(scratch, new_count, apc->rx_queue_size,
> +			      apc->tx_queue_size, apc->priv_flags, &newq);

[Severity: Medium]
Does this silently drop a user-configured RSS indirection table?

By using mana_alloc_qset() here in mana_set_channels(), a custom RSS
indirection table configured via ethtool will be lost. When mana_alloc_qset=
()
is called, it unconditionally initializes the table with default values in
drivers/net/ethernet/microsoft/mana/mana_en.c:

mana_alloc_qset() {
    ...
    mana_rss_table_init(scratch);
    ...
    mana_qset_snapshot(scratch, out);
}

Because out->rxfh_indir_lost is explicitly set to false, the old indirection
table is freed without preserving the entries, and no ethtool_rxfh_indir_lo=
st()
notification is sent.

Will this cause the interface to silently revert to a default hashing
distribution after a channel count change instead of preserving it?

> +	if (err)
> +		goto free_scratch; /* current qset untouched, nothing to undo */
> =20
> -	apc->num_queues =3D new_count;
> -	err =3D mana_attach(ndev);
> +	err =3D mana_publish_qset(apc, &newq, &oldq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D2
