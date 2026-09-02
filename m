Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51235C6A4
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313549; cv=none; b=AmZWUtRYHYk9eEJhaWehPHCrlNd9OtZIZ9KpihT0LSrv67iJa44cRPazWHGbW73EtqNMvsq/KIBg3WS3cAJo1d/krntCSju1hZ6ORSVBFubbYS9lz9dhGImakZrv0+cCcpYhvsoTbF+W0PDfw0s8d0eJpsYRs0igsHCoXDcv1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313549; c=relaxed/simple;
	bh=DTnLDDOgaR6zVAJX2M8dSyQbxGSmNoFL0uJmMG4xtU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ek6DECVDGiVjHr/0jm0DyXbsG0oOm1TeXy2zDH0uIqzFbhZu1+g5XQjQDnLlyg/Gu8vOK42PrnyPenO1+/EaaInTAB8xy3Yi0LR2DQjE/DXk+nCTPGUYadMQdEKbRTU4kTl1JG787DHGB0DhG8d9tuj417sCVLfhsKPfzL5ptbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be42ioBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be42ioBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3C81F00A3A;
	Wed,  2 Sep 2026 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788313537;
	bh=3mVRj9LMKmiu4yn4FXlgWFXvg2oAG7716oN0fDs4GRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=be42ioBmtyV1evKj0Cfe/xIRfuvrGBdIElq5zclGzygGcYTgP2Ui4VpLy8avg/yKJ
	 PsGD6RVCnzUkZY2SeCDhFU5650ZE0Js4Xqxue+fJkiF7xvQNUj3blBJwD87apr5Ffd
	 I998L4rkQKEiria+t3TDn7HyD37Y8Io5aOj40VkMNbOAqeScU32gPE9lKT2EEN88+x
	 1TrE7OgsxTxDMClyw0QgbxFP19SwzJKSzhwGnheSl00xqc4pA/7Zljt8ztgsI+0P3M
	 ALHeVWj2aoZQzOj9mRjptfFqEXXniCwg6Ej9Gmw9HRxQpv7+xa3zFi2i7q+LYojdru
	 HddJyjPdJKmjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 09/13] net: mana: keep per-queue statistics
 in the port context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901014442.2945689-10-longli@microsoft.com>
References: <20260901014442.2945689-1-longli@microsoft.com>
 <20260901014442.2945689-10-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:45:36 +0000
Message-Id: <20260902014536.CD3C81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] False-positive ASSERT_RTNL() warning during probe failure.
--

commit b6c8581e036e2f21afeed4eb0d2e9961d1a0d2f5
Author: Long Li <longli@microsoft.com>
Subject: net: mana: keep per-queue statistics in the port context

This patch moves rx and tx statistics from the individual queue structures
into port-context arrays. This ensures that the interface counters are not
lost across reconfigurations such as ethtool channel count or MTU changes.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> +static void mana_fold_rxq_stats(struct mana_port_context *apc,
> +				struct mana_rxq *rxq)
> +{
> +	struct mana_stats_rx *src =3D &rxq->drain_stats;
> +	struct mana_stats_rx *dst;
> +	unsigned int i;
> +
> +	ASSERT_RTNL();
[ ... ]
> @@ -3017,6 +3163,11 @@ static void mana_destroy_rxq(struct mana_port_cont=
ext *apc,
>  		netif_napi_del_locked(napi);
>  	}
> =20
> +	/* No poller left, so this is the last chance to keep what the queue
> +	 * counted after it stopped being the live one.
> +	 */
> +	mana_fold_rxq_stats(apc, rxq);
> +

[Severity: Medium]
Will this trigger a false-positive ASSERT_RTNL() warning if the driver
fails to probe?

If mana_init_port() fails during device probe (e.g., due to a memory
allocation failure or hardware timeout), the error recovery path calls
mana_destroy_rxqs() and then mana_destroy_rxq(), which now unconditionally
calls mana_fold_rxq_stats().

Since the probe path in mana_probe_port() invokes mana_init_port()
before calling register_netdev(), the RTNL lock is not held yet. This
seems like it would trigger the new ASSERT_RTNL() inside
mana_fold_rxq_stats() during a valid error recovery path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901014442.2945=
689-1-longli@microsoft.com?part=3D9
