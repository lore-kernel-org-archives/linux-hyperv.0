Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786C346E64
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683919; cv=none; b=faknt8kKSILQjWs10ELAmwZxspghlODE2B5KEgWjsL1htmhIeqGYPP2mOiLPb3RR5tL2hC/SH8u3fKk6z68hWUQn98G2pC/IJgC0Zxf1FgaVuVsKteBjKP4zo4O+KrGHSRbojt8xXG+S5AO3ppSnPWGpYrKTpQmOzoFeS9P4wJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683919; c=relaxed/simple;
	bh=W4VLeERxsoqxUpphEVssQwPZix7gWlvy9a4dV1pekFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHBCDP+hO16MOtH7MYU2PjSKF0CGoDcZ+kZnL4gszuIqUpv6ja0mkTC+IgWlAahOk6xXAwZjmQR5veSYbFxSsIVzSs7QCjkJda//V92hk2pdbjqT7vA0YIQ2UvXHR6shDTsM8+uXcgWCr+DBI2653kXb/s+fpN6s8EMBBs2F5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZDAPvyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZDAPvyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805D11F00A3D;
	Fri, 14 Aug 2026 05:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683918;
	bh=I1rZe07fGkK4igaSfWXXYO1VgUx2zr1R7JaFQfOwIKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZDAPvyXjJ6tGpJiU8aAyX92MtHERNoVSvRPOwYPr/j/y85xVWqJ/Iy+ni0WnHiJ7
	 nE7vPgMP/fjuc6Y2FpZ7+cgy7TDF/AIQ4ZKsCCOwKDsLHQZ2UpGWnVCLl2NU3+2z7Y
	 vkjD10tB9WIufg5XWxLAagm/sUx/djIxdPgSwWu/TJc8NKTpcRucq0sJNPfsKF1Yt8
	 rdQ0o4gDu3Do0IWSoHv+GnCJ5JeF0uFqld53UZLmKPokc/hoMYq04zn/5ugXERp+xe
	 /XYvT7x7m2uclenFbm3RrKpchJpB2BWT8VtH1k4fvpK9StEs//Mje/25Wr1BE7jEHc
	 aYZt//UbjFm8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 05/13] net: mana: swap queue sets in
 mana_change_mtu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-6-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-6-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:18 +0000
Message-Id: <20260814050518.805D11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] mana_xdp_set() is vulnerable to a race condition with RDMA vport c=
reation because it continues to use the legacy mana_detach()/mana_attach() =
sequence without blocking RDMA, leaving the interface permanently down if a=
 race occurs.
--

--- Patch [5]: [PATCH net-next v2 05/13] net: mana: swap queue sets in mana=
_change_mtu ---
commit 07ab252b810cb193b26b16516fc0a40653d2b458
Author: Long Li <longli@microsoft.com>

net: mana: swap queue sets in mana_change_mtu

The RX buffer layout depends on the MTU, so changing it rebuilds the
queues. Convert mana_change_mtu() to pre-allocate and swap.

The MTU becomes part of the queue-set configuration, so a new set can be
built for the new MTU while the running one still serves traffic at the
old one, and ndev->mtu is updated only once the new set is live.
Previously it was written before mana_attach() and rolled back on
failure, so a failed change was briefly visible to the stack.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index c0f31b386536a..c858a58577dfb 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -884,35 +884,49 @@ int mana_pre_alloc_rxbufs(struct mana_port_context =
*mpc, int new_mtu, int num_qu
>  	return -ENOMEM;
>  }
> =20
> +/* ndev->mtu is updated only once the new set is live (mana_publish_qset=
), so
> + * a failed allocation leaves the queues and the advertised MTU untouche=
d.
> + */
>  static int mana_change_mtu(struct net_device *ndev, int new_mtu)
>  {
>  	struct mana_port_context *mpc =3D netdev_priv(ndev);
> -	unsigned int old_mtu =3D ndev->mtu;
> +	struct mana_port_context *scratch;
> +	struct mana_qset newq, oldq;
>  	int err;
> =20
> -	/* Pre-allocate buffers to prevent failure in mana_attach later */
> -	err =3D mana_pre_alloc_rxbufs(mpc, new_mtu, mpc->num_queues);
> -	if (err) {
> -		netdev_err(ndev, "Insufficient memory for new MTU\n");
> -		return err;
> +	/* Port is down: no queues to rebuild, just record the new MTU.
> +	 * mana_open() will size the RX buffers accordingly.
> +	 */
> +	if (!mpc->port_is_up) {
> +		mpc->configured_mtu =3D new_mtu;
> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
>  	}
> =20
> -	err =3D mana_detach(ndev, false);
> -	if (err) {
> -		netdev_err(ndev, "mana_detach failed: %d\n", err);
> -		goto out;
> -	}

[Severity: High]
This isn't a bug introduced by this patch, but since it converts
mana_change_mtu() to avoid the mana_detach()/mana_attach() sequence, is
mana_xdp_set() still vulnerable to a race condition with RDMA vport creatio=
n?

Looking at mana_xdp_set() in drivers/net/ethernet/microsoft/mana/mana_bpf.c,
it still uses the legacy detach/attach pattern without blocking RDMA:

	err =3D mana_detach(ndev, false);
	if (err) {
		netdev_err(ndev,
			   "mana_detach failed at xdp set: %d\n", err);
		NL_SET_ERR_MSG_MOD(extack,
				   "XDP: Re-config failed at detach");
		goto err_dealloc_rxbuffs;
	}

	err =3D mana_attach(ndev);

Because mana_xdp_set() drops vport_use_count to 0 without holding vport_mut=
ex
or setting channel_changing =3D true, couldn't an RDMA application successf=
ully
acquire the vport in the middle of XDP reconfiguration?

If a race occurs, mana_attach() would fail with -EBUSY because RDMA owns the
vport, leaving the Ethernet port permanently down and requiring manual
intervention to recover.=20

> -	WRITE_ONCE(ndev->mtu, new_mtu);
> +	scratch =3D mana_qset_scratch_alloc(mpc);
> +	if (!scratch)
> +		return -ENOMEM;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D5
