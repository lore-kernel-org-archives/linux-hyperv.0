Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50B3546F2
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313551; cv=none; b=uOQzlDxqLCR26RHKJCXFaWcpwsX9cWShIHvPObnl4hKiEb3OZzAiNaC90Dm/ZybydGMgBIec9fuWva/GiMf/ObN5HGPm2LUGedKBSTMnlX8tVJJOQOzmJBPCV0Ni4aBz2wV0IyYNldXJp+sEMkLlvFWMTMAU4PzCeUIZaBLjcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313551; c=relaxed/simple;
	bh=ZjKlrtPpjgN6vRUc7BDNpnRif3MwD7B2gPG7AzitJU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJUQSZhH3FWagOtaWss1UnfiIDOcgcD56bhqJUlecEANcSzKrl50jKWSLo9yHSTMCBS3vq/oGdOepHySUvFuTXh26Fcz/1TmjoE8HILvM+IU1W2qiaoOnnaQ1hjNIpWw8kkgPiKHVJCfOgyGuoT5LxfXGy61OVbc8J8vwKsZPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn1VH6ej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn1VH6ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBB51F00A3D;
	Wed,  2 Sep 2026 01:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788313537;
	bh=8+3TSczHMtxgmdsl2Rq8rLzlxy83MLmM6uoGm3Fhymc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jn1VH6ej5jvXTnnNMIFJMF3Btq5pfaJFyssdpjGMPGogxArfeg1h11OzRQwO6OpKz
	 RuFFS3vEATURZ+Y4Mfq12NVA5mN+wMQObMkKSl2iEBDCCf9QUlCpLS6a00V3H+xDZ/
	 ygfX0uYB6m14GBXLCyk3+eaZCgSXdTdZHlG5NZ0cvpuhMMqWDN2kMXYZ3JVTxajo7a
	 AzSfk0yXBHFFq1WeLObJ5uL1jYxCDLXvGXLpB+RpMe2z2QLcxYenuyi1ZRUcDOElqc
	 uVjDqnT2j7jCMGTk6d5kpEVH1J0GOi0+3aUsxbZpioC9uy1AHxOc6VbVx8jIaQF09m
	 Y+l2ZmP/saU3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 10/13] net: mana: release EQs left idle by a
 channel-count reduction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901014442.2945689-11-longli@microsoft.com>
References: <20260901014442.2945689-1-longli@microsoft.com>
 <20260901014442.2945689-11-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:45:37 +0000
Message-Id: <20260902014537.7CBB51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of CQ in EQ event processing due to lack of synchro=
nization during CQ destruction
--

commit 3d0d6fcf405f01d902d109c4441be576c316986f
Author: Long Li <longli@microsoft.com>
net: mana: release EQs left idle by a channel-count reduction

The shared EQ pool only grows, so it sits at the high-water mark of every
channel count the port has ever used. This commit releases the EQs above the
live queue count once a retiring set has been torn down. It also ensures the
dentry is properly recorded for debugfs.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 69e34fab8fe8e..2295769da0306 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -4745,12 +4785,19 @@ void mana_free_qset(struct mana_port_context *scr=
atch, struct mana_qset *qset)
> =20
>  	memset(qset, 0, sizeof(*qset));
> =20
> +	/* This set is gone, so any EQ above the live queue count is now
> +	 * unreferenced. Release those vectors instead of holding them at the
> +	 * high-water mark. Safe here and only here: the retiring set's CQs
> +	 * have just been destroyed.
> +	 */

[Severity: High]
This is a pre-existing issue, but since this teardown path is being modifie=
d,
can the destruction of the retiring set's CQs race with the EQ interrupt
handler?

An admin reconfiguring the network interface (e.g., changing MTU, ring size=
s,
or channels) will tear down the old queue set. The hardware queues are fenc=
ed,
generating a final CQE in the CQ.

If the EQ interrupt fires, CPU A could process the EQE in
mana_gd_process_eqe(). It reads the CQ pointer but might be delayed (e.g., =
by
an NMI) before invoking the callback:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_process_eqe() {
    ...
    cq =3D gc->cq_table[cq_id];
    if (WARN_ON_ONCE(!cq || cq->type !=3D GDMA_CQ || cq->id !=3D cq_id))
        break;

    if (cq->cq.callback)
        cq->cq.callback(cq->cq.context, cq);
    ...
}

Concurrently, NAPI on CPU C could process the fence CQE and signal the
completion event. CPU B, waiting in mana_fence_rqs(), wakes up and tears do=
wn
the old CQ via mana_destroy_rxq() -> mana_gd_destroy_queue().

It clears gc->cq_table[cq_id] =3D NULL in mana_gd_destroy_cq() and frees th=
e CQ
memory immediately in mana_gd_destroy_queue():

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_destroy_queue() {
    ...
    mana_gd_destroy_cq(gc, queue);
    ...
    kfree(queue);
}

When CPU A resumes and executes cq->cq.callback(cq->cq.context, cq), this
dereferences the freed cq and mana_rxq structures to call napi_schedule(),
causing a UAF write to napi.state.

Is there any synchronization, such as RCU or IRQ synchronization, to prevent
this use-after-free during CQ destruction?

> +	mana_shrink_eqs(apc, apc->num_queues);
> +
>  	/* Queues built through a scratch context carry no debugfs nodes,
>  	 * because both sets are alive during the swap and would collide on
>  	 * the same names. The retiring set's nodes are gone now, so the
>  	 * published queues can finally take those names.
>  	 */
> -	mana_qset_debugfs_publish(netdev_priv(scratch->ndev));
> +	mana_qset_debugfs_publish(apc);
>  }
> =20
>  /* --- end of pre-allocate + swap reconfiguration path -----------------=
----- */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901014442.2945=
689-1-longli@microsoft.com?part=3D10
