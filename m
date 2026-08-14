Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144D4908BF
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729404; cv=none; b=cEX3p7yaSyowJi0ChOq2YDO92akq9HESv3W5HftShCbEPM/b/DIdXwqa91KSy823mSRZ0s8bvyOqDQT9U9cPz/5n0EnfTPxL7lRdk2mrfIVExAmsAJolh8yqIklE5Mxt8of8WFHk2etgEVfArDCe+wwtfuS+p9GJ2hH0d+40a68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729404; c=relaxed/simple;
	bh=YfvYSCWHX9/AJOUh2QzGP7mJMdJCJ6yBQwjQXvZksTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p8Ju3GFNgAALhHV+9UUDL/QJwFaCPmG3garHX/WQpKsWUO7v6pfBp99cyEDG7ldZGIn4wjBhy01qZY/sAzwOJJZL0Phx7KTfuYPru+jxjjRJ2pGO1dDkGyL808m5kO9F3DfBGsOZHnVjRcidqKN3BNIbnLF3W0SHryIrvv3ppLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un98Oxjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un98Oxjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E331F00A3A;
	Fri, 14 Aug 2026 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729402;
	bh=XuBvKwQrHkauEHJ9aoxEXEH+CjldhLC1WJrppjAwm7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Un98Oxjfqg4s93z6oI6V+loGFjxxAycQOPUsY1D4ibJBXVn4lJ57EJ3whZgGQFoPz
	 gNVwI2utPv4vQOCCdcdI88wZWjqf7IUt76lcdpCMiemFGhL8BxdUZjENtENGWn+EHg
	 cYZ+ehZii+yzGg24ahDgwd4Fxcx8/QCAAG+0HPsWqJi8y5aavhkCGCY9e8rgtTua4H
	 /jaDOhPbTilyWPNPVUqXFIc1qTY0YkMO7TkAmWPzP5YRn2/Nr6XQ/bvTRVn9dxVTfc
	 BVPppzVpcc426NTU9H9PV+dYviOf3gLcaD2u0pR3oZhcPBjxDPHe1KmNns/NhdlDUH
	 qdt7dzEjoP08w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 1/7] net: mana: reference-count CQs looked up
 from the EQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813174243.3044348-2-longli@microsoft.com>
References: <20260813174243.3044348-1-longli@microsoft.com>
 <20260813174243.3044348-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:43:22 +0000
Message-Id: <20260814174322.B5E331F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for CQ ID recycle window on Ethernet and RDMA kerne=
l CQs
--

--- Patch [1]: [PATCH net v7 1/7] net: mana: reference-count CQs looked up =
from the EQ handler ---
commit 26834a69bfec0a9b46df2c9aa1aa0f248272df13
Author: Long Li <longli@microsoft.com>

net: mana: reference-count CQs looked up from the EQ handler

This patch introduces reference counting for CQs looked up from the EQ
handler in the MANA driver to prevent a use-after-free. It also reorders
the RDMA teardown path to clear the dispatch entry before destroying the
hardware CQ, aiming to close a window where a recycled cq_id could alias
the outgoing entry.

> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index f2547989f4229..022c82479ef6c 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -108,11 +108,12 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct i=
b_udata *udata)
> =20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> =20
> +	/* Detach the dispatch entry first, then stop the HW CQ and free the
> +	 * queue.  A completion racing teardown then finds an empty slot, and
> +	 * a recycled cq_id cannot alias this CQ.  Errors are logged inside.
> +	 */
>  	mana_ib_remove_cq_cb(mdev, cq);
> =20
> -	/* Ignore return code as there is not much we can do about it.
> -	 * The error message is printed inside.
> -	 */
>  	mana_ib_gd_destroy_cq(mdev, cq);
> =20
>  	mana_ib_destroy_queue(mdev, &cq->queue);

[ ... ]

> @@ -149,23 +146,41 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,=
 struct mana_ib_cq *cq)
>  void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q)
>  {
>  	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	struct gdma_queue __rcu **cq_table;
> +	struct gdma_queue *gdma_cq;
> =20
> -	if (cq->queue.id >=3D gc->max_num_cqs || cq->queue.id =3D=3D INVALID_QU=
EUE_ID)
> +	if (cq->queue.id =3D=3D INVALID_QUEUE_ID || cq->queue.id >=3D gc->max_n=
um_cqs)
>  		return;
> =20
>  	if (cq->queue.kmem)
>  	/* Then it will be cleaned and removed by the mana */
>  		return;

[Severity: High]
This is a pre-existing issue, but does this early return leave the CQ ID
recycle window open for RDMA kernel CQs?

For kernel CQs, mana_ib_remove_cq_cb() returns early, bypassing the software
CQ unpublish step that was explicitly added to close the recycle window.
Because it skips this, the hardware CQ is destroyed via
mana_ib_gd_destroy_cq() before the queue is torn down.

If the hardware immediately frees the cq_id, a concurrent thread could
create a new CQ, be assigned the same cq_id, and fail with -EINVAL in
mana_gd_publish_cq() because the old CQ is still in gc->cq_table.

Also, does this same race exist in the Ethernet paths? Looking at
mana_destroy_rxq() in drivers/net/ethernet/microsoft/mana/mana_en.c,
the hardware object is destroyed before mana_deinit_cq() removes the
old software CQ from the dispatch table:

mana_destroy_rxq() {
	...
	if (rxq->rxobj !=3D INVALID_MANA_HANDLE)
		mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);

	mana_deinit_cq(apc, &rxq->rx_cq);
	...
}

A similar inverted destruction sequence seems to exist in mana_destroy_txq(=
).
Could this lead to spurious queue creation failures and permanently detached
network interfaces after operations like MTU changes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174243.3044=
348-1-longli@microsoft.com?part=3D1
