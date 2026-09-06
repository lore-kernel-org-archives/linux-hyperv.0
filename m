Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC089282F36
	for <linux-hyperv@vger.kernel.org>; Sun,  6 Sep 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788655489; cv=none; b=QpPVoyvGkUkzOB2PYKRRmqdXrsG87e2Myknb8zgzSIkmg1oRXWBHp0G0XqrY8A+7kQUott7leq7zEgj2egYknH7kajehiHgkDWLcqqWN/qJeTRwyKGq1LA548qwgOGVrMNOIjTUbAVrqKF05s9YzaG3a3NqxjqMl1LQan8iUSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788655489; c=relaxed/simple;
	bh=+PX69J/bbqExHt48Mau1YbzrVBPDOWzT0oaWbT7Z+O8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=krpbWOi/B/Bbb5lg7wDXlHwUy0BBPt9oMHi3Yftx760JsqvdqMmxnYxYDyahd8x5/VnLzKJ0+Ytvref7X/iJNNA17Z6XwE7R34Y4A9qKTovA3q/GMpkZnxepOnb33SIDubjgLTiJfM2u4XT1SrB3ttaLNM6qCTtIGjmk156ob/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgF70Q/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgF70Q/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1DB1F00A3A;
	Sun,  6 Sep 2026 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788655487;
	bh=cF7UajFF5KAmaPybWxJ5KbkdxiiuYCmJ3OU1LuAfWXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgF70Q/CjYnOlpPSqtF8IUVNNzNv0mmaBTAblIKqU9nwEoU9YWI0RJ7XDFlOQUYlh
	 OFo4AEzW1ci7vqQc1R1x66XUhcnvAuE+vpahVWcuatX0V+pIiiJIa7blJpEouMqrpb
	 uJZ30nxdiO0NC0NqDiR8U9xDnsYdcySR7ivzx/ip55zre074mOkzImyhqMZsRvdR5t
	 tMJ79LtYNlwiyDrovqLeSY4W7YVVvxoJUX4OuaWQgatE+TTVLMCIn3BsrrePJLECAs
	 vFYR5oh+m6gseMFditMnFqpsJ8JmO6Cw1+ygkGMcbo5Y0BIlAUxrnu5CPcE3f47HJO
	 9TV32Q0xs7sxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: do not discard an ethtool-configured RSS
 table on a queue rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260905004401.3937066-1-longli@microsoft.com>
References: <20260905004401.3937066-1-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 00:44:46 +0000
Message-Id: <20260906004447.3B1DB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] State desynchronization causes newly added queues to be left unuti=
lized after a sequence of channel count changes.

Pre-existing issues:
- [Critical] Pre-existing Use-After-Free in stats collection due to ad-hoc =
synchronization flag.
--

commit dc8331f7b2434de9035275921f9768699946cdcb
Author: Long Li <longli@microsoft.com>

net: mana: do not discard an ethtool-configured RSS table on a queue rebuild

mana_alloc_queues() regenerates the RSS indirection table from the driver
default every time the queues are built, so a table installed with
"ethtool -X" is silently replaced by any operation that rebuilds them.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 7a1ac853e3abc..97386e17b9421 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3306,6 +3306,28 @@ static void mana_rss_table_init(struct mana_port_c=
ontext *apc)
>  			ethtool_rxfh_indir_default(i, apc->num_queues);
>  }
> =20
> +/* Whether the current indirection table can be kept for apc->num_queues,
> + * rather than rebuilt from the driver default.
> + *
> + * Only a user table ("ethtool -X") is worth keeping; a driver-generated=
 one
> + * is rebuilt so that it spreads over every queue. An entry pointing pas=
t the
> + * last queue cannot be kept: mana_config_rss() uses these entries to in=
dex
> + * apc->rxqs[], which holds apc->num_queues pointers.
> + */
> +static bool mana_rss_table_keep(struct mana_port_context *apc)
> +{
> +	u32 i;
> +
> +	if (!netif_is_rxfh_configured(apc->ndev))
> +		return false;
> +
> +	for (i =3D 0; i < apc->indir_table_sz; i++)
> +		if (apc->indir_table[i] >=3D apc->num_queues)
> +			return false;
> +
> +	return true;
> +}

[Severity: High]
Does this check wrongly trust netif_is_rxfh_configured() without validating
if the table was previously replaced by a driver fallback?

If a user sets a custom RSS table via ethtool -X and then reduces the chann=
el
count, mana_alloc_queues() detects the user table indices are out of bounds
and generates a narrow driver-default table, but intentionally avoids
notifying the core via ethtool_rxfh_indir_lost(). The core's
netif_is_rxfh_configured() remains true.

When the user subsequently increases the channel count, could this function
incorrectly believe the narrow driver-generated fallback table is still a
user-configured table? Since its bounds fit the new queue count, it seems
this might permanently freeze the table at the smaller size.

> +
>  int mana_disable_vport_rx(struct mana_port_context *apc)
>  {
>  	return mana_cfg_vport_steering(apc, TRI_STATE_FALSE, false, false,
> @@ -3621,7 +3643,20 @@ int mana_alloc_queues(struct net_device *ndev)
>  		goto destroy_rxq;
>  	}
> =20
> -	mana_rss_table_init(apc);
> +	/* Keep a user-configured table across the rebuild: its entries are
> +	 * queue indices and stay meaningful while they are all still in range.
> +	 * Only a driver-generated table is regenerated here.
> +	 *
> +	 * A table that cannot be kept is replaced by the default without
> +	 * telling the core, which keeps reporting the table as user
> +	 * configured. That is what this function did for every table before,
> +	 * and reporting it here is not an option: ethtool_rxfh_indir_lost()
> +	 * sends ETHTOOL_MSG_RSS_NTF, which requires the netdev instance lock,
> +	 * and this runs both with that lock held (ndo_open) and without it
> +	 * (mana_attach() from the reset and resume paths).
> +	 */
> +	if (!mana_rss_table_keep(apc))
> +		mana_rss_table_init(apc);

[Severity: High]
If mana_rss_table_keep() incorrectly returns true due to the
desynchronization described above, does it skip the table regeneration and
leave newly added queues unutilized?

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but is there a Use-After-Free in the stats
collection due to the ad-hoc port_is_up synchronization flag?

Looking at mana_get_stats64(), the reader path relies on the ad-hoc
port_is_up flag and dereferences the queue structure, but can be preempted
before accessing it:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_get_stats64() {
	if (!apc->port_is_up)
		return;
...
	for (q =3D 0; q < num_queues; q++) {
		rx_stats =3D &apc->rxqs[q]->stats;
...
}

Concurrently, a teardown path clears the flag and proceeds to free the
underlying memory structures without waiting for concurrent readers:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_detach() {
	apc->port_st_save =3D apc->port_is_up;
	apc->port_is_up =3D false;

	/* Ensure port state updated before txq state */
	smp_wmb();

	netif_tx_disable(ndev);

	if (apc->port_st_save) {
		err =3D mana_dealloc_queues(ndev);
...
}

The memory is then synchronously freed, guaranteeing a Use-After-Free if a
reader is mid-execution:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_destroy_txq() {
...
		mana_deinit_txq(apc, &apc->tx_qp[i]->txq);

		kvfree(apc->tx_qp[i]);
...
}

Could a preempted reader accessing the freed memory lead to memory corrupti=
on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905004401.3937=
066-1-longli@microsoft.com?part=3D1
