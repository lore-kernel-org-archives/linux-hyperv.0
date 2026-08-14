Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9943451CC
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683918; cv=none; b=NkyqfBM7ZF1uVf2cbQFbRd752NdhwQrO8ftrB5XfBKG7SWPHKEUakS1lQe1fcYNDcf3hQ+GHplmX428VMLyVG7ojcecl80KJV4QKcqjbplO0BwbvG0J+v29oKoTr/33yAqEpQN2hyIuDeDsRnx2gsGRRxmME8Y4Wh5UfT1O4zCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683918; c=relaxed/simple;
	bh=JF6cjgGPbBkhRZaQBbLWJNZzcpFQhzQvGWd7C+ByR+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MvKizuQiUyzvAJsFciujZ7Wsh6/oIPRGpM5hQAOdiyQPAIAi5IqTf1hKFWL9cs0ygrcPQQAWtVqm3Rf6WLGioSJvmM0MyNJBnsLWgOeCoJSBuUiAYLpgAJKLiHZmf1xkqL4N68niMN79lMPBfRq8Wm2SlQauSnFNY5BPyywaOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwg40f7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwg40f7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220791F000E9;
	Fri, 14 Aug 2026 05:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683917;
	bh=BdwcnN37Kr0HT1ZZbzPTGqBChUfsqrWHdgkaeEFGnxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dwg40f7qPs2KFjL8dB8yZI3gdYbBb551ZPA77BvDVu8y15xiVGk3ooaa5bV7Po0iC
	 /1AeFDM4o2DPlggU8DzPnDk3yxPy4aEUNVQIwmPdKH1IRbO77KbAEFP/1+OsCpSAbU
	 W0KgGNZ5rTpp/qeugrmxTOaw3U3LGYsDJO8aKPwZZH//S6FF1EM8mBhmN2GirtJnIe
	 RDPawdebbLKsB6wzaO1avlqEVGPVIGa6Ad+s1OmBoR7Xn9Z4aFQR2JZ2sLczVvZDpn
	 VGdQBp0EJYTjD3hTzQOv6el7BefRqzSreGJ1R0YNqBdTO86CMw7xm989L0EX96Q7eM
	 tC6QQ0yHr8Nmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 04/13] net: mana: swap queue sets in
 mana_set_priv_flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-5-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:16 +0000
Message-Id: <20260814050517.220791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The boolean flag `apc->channel_changing` is used as an open-coded,=
 ad-hoc lock to protect vport reconfiguration against concurrent RDMA acces=
s, violating core kernel locking rules.
--

--- Patch [4]: [PATCH net-next v2 04/13] net: mana: swap queue sets in mana=
_set_priv_flags ---
commit 922132e276d163d3c58e43d88b85f6b85a403949
Author: Long Li <longli@microsoft.com>

net: mana: swap queue sets in mana_set_priv_flags

This commit modifies mana_set_priv_flags to pre-allocate and swap queue sets
instead of rebuilding them in place. This ensures that if the rebuild fails,
both the queues and the flag word remain untouched.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -884,54 +888,53 @@ static int mana_set_priv_flags(struct net_device *n=
dev, u32 priv_flags)
[ ... ]
> -		/* Block RDMA from grabbing the vport during detach/attach */
> -		mutex_lock(&apc->vport_mutex);
> -		apc->channel_changing =3D true;
> +	/* Block RDMA from acquiring the vport for the duration. */
> +	mutex_lock(&apc->vport_mutex);
> +	if (apc->channel_changing) {
>  		mutex_unlock(&apc->vport_mutex);
> +		return -EBUSY;
> +	}
> +	apc->channel_changing =3D true;
> +	mutex_unlock(&apc->vport_mutex);

[Severity: High]
This is a pre-existing issue, but in mana_set_priv_flags, is using a boolean
flag like apc->channel_changing as an open-coded trylock safe?

It appears to be set on entry here and cleared on exit to protect vport
reconfiguration against concurrent RDMA access, rather than using a standard
synchronization primitive. Does this ad-hoc locking pattern evade lockdep
and risk races since it bypasses proper kernel locking rules?

[ ... ]
> clear_flag:
>  	mutex_lock(&apc->vport_mutex);
>  	apc->channel_changing =3D false;
>  	mutex_unlock(&apc->vport_mutex);
> -
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D4
