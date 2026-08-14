Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9826FA60
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683920; cv=none; b=a0DBEHYjBZdI1OkmKLcj9MU1ZnYbrw5TrvjKchNhfjeldTOQ/2J3b9hfcC90MTPNEt2ZUie9MdazfaM3/zhxamyePRlzcaJcNcBJUWIm/U06wSQamqcyKDZaACRKkH3RvElErhywN/fmxJssg+zf4WGYgX/tdMOeau9mbhmDjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683920; c=relaxed/simple;
	bh=SAB1PC0OW6vKxq4gvWlWBaQkmkXpnZIa6D241OirpcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X17xQDdFObQEtwgW4Au6RuPfWCknBOPFzJBtG4XWRp2cOoOLMnmwdAYIhKCDsvJ6jFiRJQhrgVYXlF9dR+agl0GpXCKGXOT+rVJH9q2ajylu7N8OqR5K04FcvYy9pbboxJL8EoVDzxGaYOtupQH3qpWWqpAJt/S5+tUYUfWDsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b43dvRpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b43dvRpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8851F000E9;
	Fri, 14 Aug 2026 05:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683919;
	bh=K9NkJQQRvvRI9+m+W7xbcwZ2SVX34iqdsvVjPmVPwmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b43dvRpNHRNXRHCpK7lvAppTZX7uNqh4UxLUYBUAiW5rih4tU9FBbfHbbtZtRRHtF
	 Q9mqK9oemlJhwFa81kiATprAQSB+NAFk0viph86zFyaHXzgEb7gBis6E0ahtpdXy/k
	 WzDvPrKq0TfpgjLsAa07k32YbTYrFbXAQObMh0AMr6Vf14wVsopZB6DiaqKTaFF9Sh
	 MtYieytBZqVajXSrFKbupp3N7PJBeQy+T9wHs7jrS2Rpt0HWzInaCOqRZU4irzPUC7
	 Ob7Qs9uEuugh1bhwyF5gQ8puGhFf6MAfQ+DBorOsA2HmEuKeQUtgHP41NkWPVDFL2K
	 ae9YRldVY+FjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 01/13] net: mana: add queue-set allocation
 and teardown helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-2-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:18 +0000
Message-Id: <20260814050519.2B8851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] User-configured RSS indirection table is silently discarded and =
reset to defaults during per-queue reconfigurations.
--

--- Patch [1]: [PATCH net-next v2 01/13] net: mana: add queue-set allocatio=
n and teardown helpers ---
commit fcc6a74602d4e66dc287809434c5e9b44c3be829
Author: Long Li <longli@microsoft.com>
Subject: net: mana: add queue-set allocation and teardown helpers

The ethtool reconfiguration paths (channel count, ring size, private
flags), mana_change_mtu() and mana_xdp_set() rebuild the queues with
mana_detach() then mana_attach(). This adds the data model and helpers for
pre-allocate and swap to independently build and tear down a queue set.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> +int mana_alloc_qset(struct mana_port_context *scratch, unsigned int num_=
queues,
> +		    unsigned int rx_queue_size, unsigned int tx_queue_size,
> +		    u32 priv_flags, struct mana_qset *out)
> +{
> +	struct net_device *ndev =3D scratch->ndev;
> +	int err;
[ ... ]
> +	err =3D mana_rss_table_alloc(scratch);
> +	if (err)
> +		goto cleanup_rxq_array;
> +
> +	err =3D mana_create_eq(scratch);
> +	if (err)
> +		goto cleanup_rss;
> +
> +	err =3D mana_create_txq(scratch, ndev);
> +	if (err)
> +		goto cleanup_eq;
> +
> +	err =3D mana_add_rx_queues(scratch, ndev);
> +	if (err)
> +		goto cleanup_rxq;
> +
> +	mana_rss_table_init(scratch);

[Severity: Medium]
Will this unconditionally reset the RSS indirection table to defaults during
reconfigurations?

Since mana_rss_table_alloc() creates a new table and mana_rss_table_init()
initializes it to default round-robin values, it seems like a user's existi=
ng
custom RSS steering configuration might be silently overwritten when the new
queue set is published.

Could this cause a regression where the custom configuration is lost? Should
it be preserved by copying the existing table from the active port context
instead?

> +
> +	mana_qset_snapshot(scratch, out);
> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D1
