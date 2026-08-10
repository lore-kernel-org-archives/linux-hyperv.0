Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8E43E087
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388498; cv=none; b=lMAeGcUEznBvM3AVDDFuy+T4uvQFGdkJfe2YPyG1xJ2ILKHMRAWsyD7sjKRRTwFEaQx2TyFhawOVPsoAyRwd9xeiCkc9YvSmimZh0SpWfgajowN/tCpmZYRZuHfE4w9vgx3N1Bk8z8hhoU899BJmFfI459rkWh7mWxn/QI0h11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388498; c=relaxed/simple;
	bh=HCyJu/dQaMcQnZPgEQQcqZ292mLE189h0xnG9VljeAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtLqSqqk1eIxdIDHB3ZENxqCLDZ48lZjdKApyXABId8CITP7usueImmxgWhOr6Yk2518vV1JrHFIAMHDu/tzgFci2tDMVqrBIcLu7oGYrYyeGpsCO4lFw2PWIBxE7eXFmTJ8VhJRDcQceHf9SV9r5GQQ+MEz85Adx7e3ULWrgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4aS0HrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4aS0HrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17981F000E9;
	Mon, 10 Aug 2026 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388496;
	bh=58FJB0vHZl1OWP3j59oPkZRhWTF45HOlqnx+C9nebyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l4aS0HrAmDlL+AQlxL8cClhrMPa71m08UulNcWOs02M8M531nthvCgMQBJTGVcrDQ
	 VXfxGo9B/O9WX+p3wQwUdma9RSdY7T3BQvA6SgzdVCpia0cJ6R8Bw0uwI8tu8+8OY1
	 YLM3thghdciUHYXdjcWexr5jla+7QNBg9sboo4Pmus0cP+NT+IpifOXWnjeRzbanVW
	 Lhf8+JJdfj3XlnmaaEqfEfsI3evFiT4UxkT3LfpWlBPLLigYAjgInmM/Cj3j+ojKY0
	 BrgMmjiIszNDeoTj69bWPkMlPPONe1Tpv997tMLt28GfPxklMlkc4fw9mVN24G1YXL
	 NwqKgsqbphqnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/7] net: mana: RCU-protect gc->cq_table lookups
 against concurrent CQ destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260809190047.2086368-2-longli@microsoft.com>
References: <20260809190047.2086368-1-longli@microsoft.com>
 <20260809190047.2086368-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 19:01:36 +0000
Message-Id: <20260810190136.B17981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing pointer verification in `mana_gd_unpublish_cq()` and `mana=
_ib_remove_cq_cb()` causes them to incorrectly clear valid, concurrent CQs =
(double-unpublish race) and inadvertently unpublish CQ 0 on error paths.
--

--- Patch [1]: [PATCH net v5 1/7] net: mana: RCU-protect gc->cq_table looku=
ps against concurrent CQ destroy ---
commit 882f7728097f3bfd4b17e15e31d6c14542d507c2
Author: Long Li <longli@microsoft.com>
Subject: net: mana: RCU-protect gc->cq_table lookups against concurrent CQ =
destroy

This patch puts the gc->cq_table under RCU protection to prevent a
use-after-free race between the EQ interrupt handler and concurrent CQ
teardowns. It also introduces a two-pass batched teardown to optimize
synchronize_rcu() usage during network device teardowns.

> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index f2547989f4229..2bf4be21cede7 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
[ ... ]
> @@ -149,23 +157,49 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,=
 struct mana_ib_cq *cq)
>  	gdma_cq->cq.callback =3D mana_ib_cq_handler;
>  	gdma_cq->id =3D cq->queue.id;
> -	gc->cq_table[cq->queue.id] =3D gdma_cq;
> +	rcu_assign_pointer(cq_table[cq->queue.id], gdma_cq);
>  	return 0;
>  }
> =20
>  void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q)
>  {
[ ... ]
> +	/* Removers for a given CQ are serialized by the IB core, so the slot
> +	 * is read and cleared without rcu_read_lock() or atomicity: a CQ is
> +	 * never torn down while a live QP references it (cq->usecnt), nor
> +	 * while the QP-create that installed the entry is still running (that
> +	 * create holds a reference on the CQ uobject across its error path,
> +	 * before usecnt is taken).  Any double-remove is therefore sequential
> +	 * -- the later caller sees the NULL stored below and returns.
> +	 */
> +	gdma_cq =3D rcu_dereference_protected(cq_table[cq->queue.id], true);
> +	if (!gdma_cq)
> +		return;  /* already removed by a prior teardown path */
> +
> +	rcu_assign_pointer(cq_table[cq->queue.id], NULL);

[Severity: High]
Does this RDMA cleanup path need to verify that the gdma_cq read from the
table actually matches the expected one (such as cq->queue.kmem)?

If a hardware ID was reused by a concurrent operation, could this clear a=20
newly created and published CQ?

> +
> +	/* Wait for in-flight EQ handlers that may have loaded the old
> +	 * pointer via rcu_dereference() to finish before freeing.
> +	 */
> +	synchronize_rcu();
> +	kfree(gdma_cq);
>  }
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index e8b7ffb47eb98..7714040d1df42 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
[ ... ]
> @@ -1050,18 +1052,41 @@ static void mana_gd_create_cq(const struct gdma_q=
ueue_spec *spec,
>  	queue->cq.callback =3D spec->cq.callback;
>  }
> =20
> -static void mana_gd_destroy_cq(struct gdma_context *gc,
> -			       struct gdma_queue *queue)
> +bool mana_gd_unpublish_cq(struct gdma_context *gc, struct gdma_queue *qu=
eue)
>  {
> +	struct gdma_queue __rcu **cq_table;
>  	u32 id =3D queue->id;
> =20
> -	if (id >=3D gc->max_num_cqs)
> -		return;
> +	/* No rcu_read_lock() here: unpublish runs only on the
> +	 * CQ-destroy/teardown path, where the base cq_table is stable.  See
> +	 * the lifecycle note on gdma_context::cq_table in gdma.h for why the
> +	 * "true" predicate is sound.
> +	 */
> +	cq_table =3D rcu_dereference_protected(gc->cq_table, true);
> +	if (!cq_table || id >=3D gc->max_num_cqs)
> +		return false;
> +
> +	if (!rcu_access_pointer(cq_table[id]))
> +		return false;
> +
> +	rcu_assign_pointer(cq_table[id], NULL);
> +	return true;
> +}

[Severity: High]
Should this check if the pointer actually matches the queue being unpublish=
ed?

If a hardware ID is 0 on a failure path, could this unintentionally clear t=
he
slot for whatever valid CQ currently holds ID 0?

Verifying that rcu_access_pointer(cq_table[id]) equals the queue variable
could prevent blindly clearing the wrong CQ.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 92bb55935c1c4..5d215981bba83 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -2448,8 +2454,24 @@ static void mana_destroy_txq(struct mana_port_cont=
ext *apc)
>  			apc->tx_qp[i]->txq.napi_initialized =3D false;
>  		}
> =20
> -		if (apc->tx_qp[i]->tx_object !=3D INVALID_MANA_HANDLE)
> -			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
> +		if (apc->tx_qp[i]->tx_object !=3D INVALID_MANA_HANDLE) {
> +			mana_destroy_wq_obj(apc, GDMA_SQ,
> +					    apc->tx_qp[i]->tx_object);
> +			apc->tx_qp[i]->tx_object =3D INVALID_MANA_HANDLE;
> +		}
> +
> +		if (apc->tx_qp[i]->tx_cq.gdma_cq)
> +			mana_gd_unpublish_cq(gc, apc->tx_qp[i]->tx_cq.gdma_cq);
> +	}
> +
> +	synchronize_rcu();
> +
> +	/* Pass 2: the slots are clear, so mana_gd_destroy_cq() skips its own
> +	 * grace period; free the CQ, the TXQ and the queue pair.
> +	 */
> +	for (i =3D 0; i < apc->num_queues; i++) {
> +		if (!apc->tx_qp[i])
> +			continue;
> =20
>  		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);

[Severity: High]
Does this create a race window during the two-pass teardown?

Since mana_deinit_cq() calls mana_gd_destroy_cq(), which in turn calls
mana_gd_unpublish_cq() a second time for the same queue, could a newly
created RDMA CQ that recycled this ID during the synchronize_rcu() wait
be incorrectly destroyed here?

If mana_gd_unpublish_cq() only checks for a non-NULL slot, it seems like it
might blindly clear the newly published CQ on this second pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809190047.2086=
368-1-longli@microsoft.com?part=3D1
