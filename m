Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A104B04B4
	for <linux-hyperv@vger.kernel.org>; Sun,  9 Aug 2026 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242902; cv=none; b=CIncGl538c58he4ohmSnEaBggbMi/95QlCn/Ay81LBfab5bdeYXufFnL7Xk/OlZhMo0b3aLb9lZXfPf+9gxr4p7wva80ZJoK2tAQsbBdIkUxmvIeJafJ8/sWCUIaiCyh3V/Z20EdJJVWAKWrsqH9fjR2d7bVcoeReFwGEffkqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242902; c=relaxed/simple;
	bh=8oKaE7O4RpNrY1I0X2Udk4YIOwxY5fUubLmn2LfKDrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FvVsCMO6tkBAE0L20x3Dlze1PmFTXYRhHQjRPuJY32q8pOge6R7pFd/NowUlBQxdkOStmt3+Gy03nc8w9iwoDs1a+oRbMxRMXJkRBePuYb+JRW7rz5v6oDHnkADKdbg251zWU1SsURbeKKpuFt91n0m+kyPhuqtlZAPjTz5j0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEgJEUkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEgJEUkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE51F000E9;
	Sun,  9 Aug 2026 02:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242900;
	bh=Smrmt2NSu7D2CqJL+Dv72K8UgtMwowHMzFe+HX9eBts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PEgJEUkCH5JKlE+bM3xzGUuVWDT1pXjsmQw8/vSZq6w+o3jYzU31c9ydahp8t5yU2
	 Dl9CUjCzU4BTHKEKz6uzAH1yD2x2QN5jCEfPL4FJKwuO69IGC4NkE5xeSHiKN2ebff
	 jbhUhaTfjb+QLzPuRnZoeJXRiWEbgImkCswOF+AzMnLM885VtnXSify/hlX4AM0T99
	 hkNb8k8q0ZWiN/BelhHyv0oDTlyoN3a5g0waBktfU160SiCXkD9B7FUoNOOmKQiEZe
	 rXoOiMWOZ+kEQSkd+f3Fj6kx/erFUoA9xUE+CIl8FvzGD+ebrX3+ys4w0oScnO983o
	 c6Og1dfbRSo2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/7] net: mana: RCU-protect gc->cq_table lookups
 against concurrent CQ destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260808023417.1746886-2-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260808023417.1746886-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 02:34:59 +0000
Message-Id: <20260809023500.69AE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The NAPI struct for an RX/TX queue is scheduled before it is f=
ully initialized, leading to a NULL pointer dereference (Kernel Panic).
- [High] Dangling `cq_table` entries after RAW/RSS QP destruction cause mem=
ory leaks and prevent future QP creation (Cross-process DoS).
--

--- Patch [1]: [PATCH net v4 1/7] net: mana: RCU-protect gc->cq_table looku=
ps against concurrent CQ destroy ---
commit 855b59e3efafe6690d7dd204468e072eef10cb49
Author: Long Li <longli@microsoft.com>

net: mana: RCU-protect gc->cq_table lookups against concurrent CQ destroy

This commit puts the cq_table under RCU protection to prevent a
use-after-free race between the EQ interrupt handler and CQ teardown. It
ensures the slot is cleared and an RCU grace period elapses before freeing
the CQ memory.

> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index f2547989f4229..2bf4be21cede7 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -131,12 +131,20 @@ static void mana_ib_cq_handler(void *ctx, struct gd=
ma_queue *gdma_cq)
>  int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q)
>  {
>  	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	struct gdma_queue __rcu **cq_table;
>  	struct gdma_queue *gdma_cq;
> =20
> -	if (cq->queue.id >=3D gc->max_num_cqs)
> +	/* No rcu_read_lock(): install/remove run within the IB device
> +	 * lifetime, which mana_rdma_remove() (ib_unregister_device) drains
> +	 * before the base cq_table can be freed.  See gdma_context::cq_table
> +	 * in gdma.h for why "true" is sound.
> +	 */
> +	cq_table =3D rcu_dereference_protected(gc->cq_table, true);
> +	if (!cq_table || cq->queue.id >=3D gc->max_num_cqs)
>  		return -EINVAL;
> +
>  	/* Create CQ table entry, sharing a CQ between WQs is not supported */
> -	if (gc->cq_table[cq->queue.id])
> +	if (rcu_access_pointer(cq_table[cq->queue.id]))
[Severity: High]
This isn't a bug introduced by this patch, but could this fail permanently =
due
to a dangling pointer?

If a userspace application creates an RDMA QP with an existing CQ,
mana_ib_create_qp_raw() allocates a WQ/CQ pair and overwrites
send_cq->queue.id. When the QP is destroyed, mana_ib_destroy_qp_raw() tears
down the WQ/CQ in hardware but does not call mana_ib_remove_cq_cb().

This leaves a dangling pointer in cq_table. If the hardware reallocates the
same CQ ID to another process or queue, won't this check see the leaked ent=
ry
and prevent further QP creation?

>  		return -EINVAL;
>  	if (cq->queue.kmem)
>  		gdma_cq =3D cq->queue.kmem;

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 92bb55935c1c4..5d215981bba83 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -2596,12 +2619,18 @@ static int mana_create_txq(struct mana_port_conte=
xt *apc,
> =20
>  		cq->gdma_id =3D cq->gdma_cq->id;
> =20
> -		if (WARN_ON(cq->gdma_id >=3D gc->max_num_cqs)) {
> +		/* No rcu_read_lock(): mana_create_txq runs under RTNL during
> +		 * netdev bring-up, inside the netdev lifetime that
> +		 * mana_remove() drains before the base cq_table can be freed.
> +		 * See gdma_context::cq_table in gdma.h for why "true" is sound.
> +		 */
> +		cq_table =3D rcu_dereference_protected(gc->cq_table, true);
> +		if (WARN_ON(!cq_table || cq->gdma_id >=3D gc->max_num_cqs)) {
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> =20
> -		gc->cq_table[cq->gdma_id] =3D cq->gdma_cq;
> +		rcu_assign_pointer(cq_table[cq->gdma_id], cq->gdma_cq);
[Severity: Critical]
This is a pre-existing issue, but by publishing the CQ to cq_table before t=
he
NAPI struct is initialized, does this open a race window that could lead to=
 a
crash?

Once rcu_assign_pointer() publishes the CQ to cq_table, an early hardware
completion could trigger the EQ interrupt handler mana_gd_process_eqe(), wh=
ich
can access the published CQ and call mana_schedule_napi().

> =20
>  		mana_create_txq_debugfs(apc, i);
> =20
> @@ -2621,25 +2650,20 @@ static int mana_create_txq(struct mana_port_conte=
xt *apc,

[ ... ]

> @@ -2905,12 +2966,18 @@ static struct mana_rxq *mana_create_rxq(struct ma=
na_port_context *apc,
>  	if (err)
>  		goto out;
> =20
> -	if (WARN_ON(cq->gdma_id >=3D gc->max_num_cqs)) {
> +	/* No rcu_read_lock(): mana_create_rxq runs under RTNL during netdev
> +	 * bring-up, inside the netdev lifetime that mana_remove() drains
> +	 * before the base cq_table can be freed.  See gdma_context::cq_table
> +	 * in gdma.h for why "true" is sound.
> +	 */
> +	cq_table =3D rcu_dereference_protected(gc->cq_table, true);
> +	if (WARN_ON(!cq_table || cq->gdma_id >=3D gc->max_num_cqs)) {
>  		err =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	gc->cq_table[cq->gdma_id] =3D cq->gdma_cq;
> +	rcu_assign_pointer(cq_table[cq->gdma_id], cq->gdma_cq);
[Severity: Critical]
This is a pre-existing issue, but since mana_push_wqe(rxq) has already post=
ed
buffers to the hardware just before this, couldn't a network packet be
received at this point?

Since netif_napi_add_weight_locked() hasn't run yet, would an early hardware
interrupt cause the EQ handler to invoke napi_schedule() on an uninitialized
NAPI struct?

> =20
>  	netif_napi_add_weight_locked(ndev, &cq->napi, mana_poll, 1);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D1
