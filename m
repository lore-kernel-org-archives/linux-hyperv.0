Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BA18FDDE
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683917; cv=none; b=L0Z38BB1us8tyomrRtBMxlfnwnx8Ce+FT//eGfm3lAY50lNrMSejjaZ3vxQw6SJhf4Pf7kQcMsXZnBZZylPXTDrnYCygAYfKgOL2xvfLu7Z79IpVZ+2WKqPgkNhd7i4vPCD2RczrX6x1JsrTf2YYDmqiQxa0iGzyKUOs6LTAz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683917; c=relaxed/simple;
	bh=otJA7GrkeRvyhIeiGhaxiqy4McCeF2vDAwvOQXMkg2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KdLoDlKYHUytz29ShoR5yZ0FAQUfYoiNGuPKAuPs6mUhsBKpnQz4t2nEJ3r7eOb2PRJd7XjE7Jw1jnXpeKXyQmOXVg4oxtXRj/naTypZkjQx6Kago6Wrul+ZBsGmbAjxJjOWZBJVtfWqNWLbgnDFe0PTrDz1WB1efXhpUijVy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcwlz/CI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcwlz/CI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B65B1F000E9;
	Fri, 14 Aug 2026 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683915;
	bh=2XQcvqz9d94/UcFPpc3E+mpNBLzPQei8zSBwvJtznkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lcwlz/CIWRcgS7WFaZapR3gzLZ5QTHh+KtKAToRKnRzV7N58aOgajWg4EONU40jEm
	 WF47bdcFvrBRkBP5t1uTE4WqLEW8tHVWyBregRqpACEIq210fZJSAKPyZvxuaZlu5K
	 fTH9maCMLPO9DAIkm6kWZuONSP1q1AgGb3yWsLd6opMLOO8yWsVRHsR7p1GyngF8dX
	 lShNGvZe9oKQX1uSa172tD4CbEwhkNol0m2epj1zhjta2LNHhg0jN6dJ6oFdKu4Hp7
	 s3dVayXYZUYjRcUcMMiyTMOoNullD+CORIESfWA26LzFaEoXWNRNfotdPHffJFmz8g
	 kpDBYwvmfBHJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 08/13] net: mana: keep per-queue statistics
 in the port context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-9-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-9-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:11 +0000
Message-Id: <20260814050515.3B65B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent writers to the same `u64_stats_sync` structure during=
 RX queue swap.
--

--- Patch [8]: [PATCH net-next v2 08/13] net: mana: keep per-queue statisti=
cs in the port context ---
commit 48e144b542daf3b7f2ff07b74db60098e784159d
Author: Long Li <longli@microsoft.com>

net: mana: keep per-queue statistics in the port context

This commit moves per-queue statistics out of the queue structures and into=
 a
port-context array to prevent statistics from resetting when the queue is
reconfigured. The stats are indexed by the queue index, and the arrays outl=
ive
the queues so totals stay monotonic.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -1059,6 +1065,48 @@ static void mana_cleanup_port_context(struct mana_=
port_context *apc)
>  	apc->rxqs =3D NULL;
>  }
> =20
> +/* Counters belong to the port, not the queues, so a queue-set replaceme=
nt
> + * does not reset them. Sized to max_queues, allocated once.
> + *
> + * A swap adds no writer to a TX slot. RX slots do overlap briefly, sinc=
e a
> + * retiring rxq keeps its NAPI until mana_free_qset() destroys it. MANA =
is
> + * 64-bit only, so u64_stats_sync has no seqcount and at worst a few
> + * increments are lost; the alternatives are a lock in the receive path =
or
> + * per-set slots that make ndo_get_stats64() dip during a swap.
> + */

[Severity: Medium]
Is it safe to allow concurrent writers to the same u64_stats_sync structure?

The u64_stats_sync API requires that writers must be mutually exclusive for=
 a
given syncp. While MANA is 64-bit only and lacks a seqcount in the syncp,
allowing both the retiring RX queue's NAPI and the new RX queue's NAPI to
concurrently update the same apc->rxq_stats[rxq_idx] introduces a data race.

For example, both could be running mana_rx_skb() at the same time:

	u64_stats_update_begin(&rx_stats->syncp);
	rx_stats->packets++;
	rx_stats->bytes +=3D pkt_len;

Could this lead to undefined behavior or KCSAN warnings when the queues
overlap during a swap?

> +static int mana_alloc_queue_stats(struct mana_port_context *apc)
> +{
> +	unsigned int i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D8
