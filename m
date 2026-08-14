Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707633ADAF
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683917; cv=none; b=OAmo1ttY4GQvzRBNFJoViMbtY7sduUQ7OUCWucXMR87FOQ5yerJPn3A9kvgMaeyDKB3ypCXRiHXbYAR/0P3yzCqcMCP2Sa1nDzNF4LVC/UsnhSmIYA4Gcl3tw+4N0U9814+soYekV0ewAHJkG96h+b6qqCXqOdEPe6yLwvwNjZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683917; c=relaxed/simple;
	bh=pn3sE8IJIt33bqKufhfe2ieXCder1Z4d114sgwMeVcc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kPzo1N2FLOasQVZDypOioBi+EwNcYEYs7sQgZRm1PO3aqqZdPIIYdCfKVAi3jRg5QQjXjtenlKtNa9VVlF9VDzCC+QdfYkTh4E0JXCIBgSpF6TPgFVKMFlGyrFBd6KxYRFF5tC25j4RnTSM5YmGn1qR6OwqKM+MiTlal6SGtfvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyarJMF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyarJMF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7629A1F00A3D;
	Fri, 14 Aug 2026 05:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683916;
	bh=0DmSwzriryGuF2kutMhJGH2/5ntYKLzm7pp/66hIm9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lyarJMF7mNFDhM2f5GOaEBudCEL1StqmNUBxp45cc84NHuuJv1Jx5OuyxDnbNaya1
	 +oy8WgQR15MpcetbjZ2ooTvqEYYeoDgblNIzQitVaNPM2K2fqx8AfQxtEq5aXr0qVP
	 gaIxZEc8JtYpSYH6ylFnECpkiMRTqTq5pK2apqrlV+CWWtXqNnEhJjyrrgoA0m9C+v
	 Km5nD18Zk+4C9TYitYhfVDr7HMVETqvWbZODkKhKt20n1bhv1FDuWpC+TMWrJ5s12F
	 /hUqjQMTE+s7Z1DQqOZ+Laxs9MHf0CKSiBgqFsMDIVMMl7R6v1skEZE0QizH+AJSC2
	 HstUYnhRbJjuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 07/13] net: mana: do not bail out of
 mana_detach on dealloc failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-8-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-8-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:16 +0000
Message-Id: <20260814050516.7629A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The 'channel_changing' boolean flag is used as an ad-hoc lock to g=
uard code sections and prevent concurrent access, violating kernel synchron=
ization guidelines.

Pre-existing issues:
- [Critical] Hardware queue memory and RX page pools are freed while the de=
vice may still be DMAing to them if it fails to quiesce during teardown (DM=
A Use-After-Free).
--

--- Patch [7]: [PATCH net-next v2 07/13] net: mana: do not bail out of mana=
_detach on dealloc failure ---
commit 04170ba1361c402d70e39fad639e6d6455da30a2
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: do not bail out of mana_detach on dealloc failure

This commit modifies mana_detach() to remove the early return if
mana_dealloc_queues() fails. This ensures that the function completes its
full teardown, including netif_device_detach() and mana_cleanup_port_contex=
t(),
avoiding an inconsistent port state.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index e54ad4db918ce..2b3250483b439 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -4502,10 +4502,8 @@ int mana_detach(struct net_device *ndev, bool from=
_close)
> =20
>  	if (apc->port_st_save) {
>  		err =3D mana_dealloc_queues(ndev);

[Severity: Critical]
This is a pre-existing issue, but does mana_dealloc_queues() safely handle a
failure to quiesce the device?

If mana_drain_txqs() times out and pci_try_reset_function() fails, it skips
freeing the TX SKB buffers and returns false:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_drain_txqs() {
    ...
		err =3D pci_try_reset_function(to_pci_dev(gd->gdma_context->dev));
		if (err) {
			netdev_err(apc->ndev,
				   "function reset failed: %d, %d pkts pending in txq %u\n",
				   err, atomic_read(&txq->pending_sends),
				   txq->gdma_txq_id);
			quiesced =3D false;
    ...
	if (!quiesced) {
		netdev_err(apc->ndev,
			   "device not quiesced, leaking pending TX buffers instead of unmapping=
 memory it can still DMA from\n");
		return reset;
	}
    ...
}

However, mana_dealloc_queues() ignores this false return value and proceeds
with the teardown:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_dealloc_queues() {
    ...
	if (mana_drain_txqs(apc)) {
		struct mana_context *ac =3D apc->ac;
		unsigned int i;
    ...
	/* Even in err case, still need to cleanup the vPort */
	mana_destroy_rxqs(apc);
	mana_destroy_txq(apc);
    ...
}

Because the device was never successfully quiesced, it remains active. Will
unconditionally freeing the GDMA SQ and RQ hardware ring buffers and RX page
pool buffers here lead to a DMA use-after-free when the hardware continues =
to
DMA read/write to the now-freed memory?

> -		if (err) {
> +		if (err)
>  			netdev_err(ndev, "%s failed to deallocate queues: %d\n", __func__, er=
r);
> -			return err;
> -		}
>  	}

[Severity: High]
Is the channel_changing boolean flag being used as an ad-hoc lock to guard
code sections and prevent concurrent access?

drivers/net/ethernet/microsoft/mana/mana_ethtool.c:mana_set_ringparam() {
    ...
	mutex_lock(&apc->vport_mutex);
	if (apc->channel_changing) {
		mutex_unlock(&apc->vport_mutex);
		return -EBUSY;
	}
	apc->channel_changing =3D true;
	mutex_unlock(&apc->vport_mutex);
    ...
}

Using a boolean flag to protect entire blocks of code bypasses standard ker=
nel
locking mechanisms. This prevents lockdep from analyzing lock dependencies =
and
forces concurrent callers to fail with -EBUSY instead of gracefully waiting.

Could a proper mutex or rwsem be used here instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D7
