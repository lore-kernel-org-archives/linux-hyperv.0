Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46A2AD00;
	Sat, 20 Jun 2026 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934848; cv=none; b=PZFptIQk92XdZYT1KYdZgS8rH1zOwYf6ov/K59AH/b09azbVNvax8H2FL8GnDMYxYc56vknSBStYR/ecie2J3TWdkmC5MvVYvowdavTie4kmeJfS/OdklbVwfghbSJ3bBm9B58c1Y20r9jgLLiJEVdRtoobxbpSoZ+XqC172hRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934848; c=relaxed/simple;
	bh=r3HUleWjSLSWjHs+Po/2UHPAB1IL0ZB3XemC7YIONHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mx0Osv9jXLuH9ljAz8rPrCVFgYErrj1EXI/qhYSmh3WGcCjFFtNuO7iKQ6JhoecBlYsOLJT+hysdqgaxGOUfEbaCgOkXQaGbYJesEJfPmy2G7HaZ4+8owTy2hYWaeeqOO15oD/aBJi7oft8v4RCi3hF7KGE/4G6jZ5sgNjLtsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp1KzPVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp1KzPVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564C1F000E9;
	Sat, 20 Jun 2026 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781934847;
	bh=sByWLIJaTIALxs6GR8Fv7ykcvn/to37QCJAb0wX8OnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zp1KzPVAhogWZ5zy8m2LVTRQm6jxWpYxbsqhhZov7bwqSuIjuWixgNoTdhGJEHomw
	 DhByoWf+MJdz7+bgAMmVkprrEgsAxL2QeTd/Uir9pzREnd06r/3Y+0edM4i91P7K/U
	 npQCHROeEi2toorh87jGEzsd1q+Bifo0bN1vCdLmfYibdvzdoLXvwoE/QMQwlxZR14
	 x++51MNzA4upI9x5/OXxX5aufvPYJF3MLcaEX3edrzfnGFm+zcxEU9VOnFrUTIIGBS
	 bfL1WmE0nFmK5x31sg9vpY5faW/djJSBFH0IjGmuH31LZDGrOZKlXvBsnPmcpWgNaj
	 BhnpUKyLpv9Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: Fall back to standard MTU when PF
 reports adapter_mtu of 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Erni Sri Satya Vennela" <ernis@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260619055348.467224-1-ernis@linux.microsoft.com>
References: <20260619055348.467224-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 05:54:06 +0000
Message-Id: <20260620055406.C564C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting error handling bug in XDP set path leaves apc->bpf_pro=
g pointing to a freed BPF program, leading to a Use-After-Free/Double Free.
--

commit 425f6bf5274f2172e13cdc649ea2288d8dc1ad72
Author: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0

This commit fixes a regression for older PF firmware versions by allowing
an adapter_mtu of 0 to fall back to the standard ETH_FRAME_LEN. It also
updates MTU bounds checks for XDP limits.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net=
/ethernet/microsoft/mana/mana_bpf.c
> index b5e9bb184a1dd..53308e139cbe9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> @@ -237,7 +237,8 @@ static int mana_xdp_set(struct net_device *ndev, stru=
ct bpf_prog *prog,
>  		bpf_prog_put(old_prog);
> =20
>  	if (prog)
> -		ndev->max_mtu =3D MANA_XDP_MTU_MAX;
> +		ndev->max_mtu =3D min_t(unsigned int, MANA_XDP_MTU_MAX,
> +				      gc->adapter_mtu - ETH_HLEN);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes
to mana_xdp_set(), I noticed a pre-existing issue on an error path earlier
in this function.

Earlier in mana_xdp_set(), the program is assigned:

    apc->bpf_prog =3D prog;

If the port is up, it then allocates rx buffers:

    err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
    if (err) {
        ...
        return err;
    }

If mana_pre_alloc_rxbufs() fails, it returns directly rather than jumping
to the err_dealloc_rxbuffs label. This bypasses the cleanup step that
restores apc->bpf_prog =3D old_prog.

Since the networking core frees the bpf program on error, does this leave
apc->bpf_prog pointing to a freed program?

If mana_xdp_set() is called again later, could fetching old_prog lead to a
use-after-free or double-free when calling bpf_prog_put(old_prog)?

>  	else
>  		ndev->max_mtu =3D gc->adapter_mtu - ETH_HLEN;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619055348.4672=
24-1-ernis@linux.microsoft.com?part=3D1
