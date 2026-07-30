Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40C3542F6
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452007; cv=none; b=st10v3DzhIlpdK9rwOSG5wEn0fckWqlh71otlTaz7cXi4/yFC60hbgYIHMCFR+w5V8wBFhL4SOz19xYj0NU8gbIwEaMwOFim+uDbGrKlZzBs+IZT38dFkTlUm/WMJuQYiawLieUNKJKtHTZAgAt2OZ8y+yRCHASyLXsOO4Dgx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452007; c=relaxed/simple;
	bh=CneZIo7TPaGpho3+SDjLXa2hsevND+A0XFsE8I3zo/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P0r7PO12WUeoHb1WC64iThuBWwq/DDUje/zG+koNnFScEM+XE9FuJN8GXIBI9XNeTsRmO1afsi/BrDlAKjHwOeoN0acQ0MfyYoBhyNNrW/7hVmkuNqlXYPGUIl7cMeBJYCovhBaHq53D/pZB7mABHkUe/kBgkhP391eP1/TE9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDAVtqGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDAVtqGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AE11F000E9;
	Thu, 30 Jul 2026 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785452005;
	bh=cC/bHJGwvryQ2IInOLamYFfJxYxHtlowaM6Nk0V7S4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDAVtqGRbNSeI/qafNENQULC1zJhzUqnVOjyXmwQoLrmSxC6jD7r4trzaO0IBjqv/
	 jov8PnWhoXWOK/nIE6760xmXZhYVDz6LDIXmTq14a7sNlVsnM89RhFK6ZBZFMJ3bND
	 +AN+hoWJ6v2NIAjmxjiTfsFMyO3oPGb8Z5Q4zBvH2TVJdekYR+ZeUEKcRi/6Vte5WJ
	 qp3HvFkufkcsGnSKcQ0KdvcEKDNAauWFZBJL6U9LtnoOQ30fssvCbWVJZJi2sedPNC
	 l/x23BgpgqV+YLNMP/EywBdm3033pZH3XCC0aU/RAB3QfN8Nzyg4K7JSb+PfZPB9h+
	 7k0z4VTLl/mgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: mana: Extend RX CQE coalescing up to 8
 packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260729225235.3573786-1-haiyangz@linux.microsoft.com>
References: <20260729225235.3573786-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 22:53:25 +0000
Message-Id: <20260730225325.B7AE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `mana_rxcomp_perpkt_info` union defines the 8-packet mode layo=
ut in a way that incorrectly rearranges fields, contradicting the commit me=
ssage and potentially causing the driver to read bogus packet lengths and h=
ashes.
- [Medium] The driver accepts `rx-frames=3D8` via ethtool even when the har=
dware does not support it (`!gc->cqe8_coalescing_sup`), silently falling ba=
ck to 4 packets instead of returning an error.
--

--- Patch [1]: [PATCH net-next] net: mana: Extend RX CQE coalescing up to 8=
 packets ---
commit 2083fcc78b90120f37ea18fdedab5ea909bd1068
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Extend RX CQE coalescing up to 8 packets

To support up to 8 packets per CQE, put two packet lengths and hash values
into one PPI entry by using the reserved fields. Update ethtool handlers to
set this feature and per queue stat to show the coalesced CQE counters.
This feature is supported on NIC hardware showing the relevant PF flag.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 9e31e2595ae32..8743f7edecbb8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c

[ ... ]

> @@ -514,8 +518,15 @@ static int mana_set_coalesce(struct net_device *ndev,
>  	saved.tx_dim_enabled =3D apc->tx_dim_enabled;
> =20
>  	saved.cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
> +	saved.cqe8_coalescing_enable =3D apc->cqe8_coalescing_enable;
>  	apc->cqe_coalescing_enable =3D
> -		kernel_coal->rx_cqe_frames =3D=3D MANA_RXCOMP_OOB_NUM_PPI;
> +		kernel_coal->rx_cqe_frames >=3D MANA_RXCOMP_OOB_NUM_PPI;
> +
> +	if (gc->cqe8_coalescing_sup)
> +		apc->cqe8_coalescing_enable =3D
> +			kernel_coal->rx_cqe_frames =3D=3D MANA_CQE_COAL_PKTS_8;
> +	else if (kernel_coal->rx_cqe_frames =3D=3D MANA_CQE_COAL_PKTS_8)
> +		netdev_info(ndev, "Fall back to RX-CQE x4 coalescing\n");

[Severity: Medium]
When the hardware does not support 8-packet coalescing, this code logs an
info message and falls back to 4 packets while still returning success (0).

Should this instead return an error code like -EINVAL or -EOPNOTSUPP?
Silently changing the requested parameter might break userspace configurati=
on
scripts that expect ethtool to reject unsupported values.

> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 4d041fb8437f5..3ca1399a2fafa 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h

[ ... ]

> @@ -238,12 +242,25 @@ struct mana_cqe_header {
>  #define MANA_HASH_L4                                                    =
     \
>  	(NDIS_HASH_TCP_IPV4 | NDIS_HASH_UDP_IPV4 | NDIS_HASH_TCP_IPV6 |      \
>  	 NDIS_HASH_UDP_IPV6 | NDIS_HASH_TCP_IPV6_EX | NDIS_HASH_UDP_IPV6_EX)
> +#define MANA_HASH_ENABLE_SUPPORTED \
> +	(NDIS_HASH_IPV4 | NDIS_HASH_TCP_IPV4 | NDIS_HASH_UDP_IPV4 | \
> +	 NDIS_HASH_IPV6 | NDIS_HASH_TCP_IPV6 | NDIS_HASH_UDP_IPV6)
> +
> +union mana_rxcomp_perpkt_info {
> +	struct {
> +		u32 pkt_len : 16;
> +		u32 reserved1 : 16;
> +		u32 reserved2;
> +		u32 pkt_hash;
> +	};
> =20
> -struct mana_rxcomp_perpkt_info {
> -	u32 pkt_len	: 16;
> -	u32 reserved1	: 16;
> -	u32 reserved2;
> -	u32 pkt_hash;
> +	/* Up to two pkts per PPI entry */
> +	struct {
> +		u32 pkt_hash0;
> +		u16 pkt_len0;
> +		u16 pkt_len1;
> +		u32 pkt_hash1;
> +	};
>  }; /* HW DATA */

[Severity: High]
The commit message mentions using the reserved fields for the second packet,
but does this new structure layout match the original offsets?

In the original structure, pkt_len is at offset 0. However, the new 8-packet
struct places pkt_hash0 at offset 0.

On little-endian systems, this will overwrite the original pkt_len position
and move pkt_len0 and pkt_len1 to offsets 4 and 6. If the hardware still
populates the first packet's length at offset 0, could the driver misinterp=
ret
the first 4 bytes as a hash and parse bogus packet lengths, potentially
causing 8-packet coalesced packets to be dropped as oversized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729225235.3573=
786-1-haiyangz@linux.microsoft.com?part=3D1
