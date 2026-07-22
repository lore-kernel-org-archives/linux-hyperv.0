Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB853368AE
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763978; cv=none; b=EBLzfYwEwhPZdfeISjFABL3dLsZTMYh0+V4lF57paqOo8gG66n5b8hOgcWPQAzHcKlY7jj6jFLNTJur0otpUFm/GFVcgTJNuF+Wjyb0GOaX/bf4JJTauAq6d8b7B8u/WSbcbzyB4S3Sfe6xGfBUTHneBso/Tq6PS0Hdx5xfSV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763978; c=relaxed/simple;
	bh=5wy3SxNL9anHVn2P9Nw/46SyhZI/5wn2CpN5khxGcQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMLHW7qx0Dg/4y/Y5lNW0xlK60TRweU6zzZ5vR3zDc/ZZ4TKqjSeLLdJNyJfpA6NiHPI7yvnfHp6gmU0VGP58r4Av2lykksixXn1nmqNVFWaAinMwV2h5ojfh9gKvLSdJkjPAno7SKsVTapRxgbpcY3XG1zt7axVYVGdgpftVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxFwfjY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxFwfjY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088971F00A3A;
	Wed, 22 Jul 2026 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763977;
	bh=VdxC+Z8I2Px3IFCGlne4sxN1unPP2CZafVOJY0+31K4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxFwfjY44srbhNSg5946PDExb2yAVTnGwNrnRkCqrNDHlcBxCAykgQowY0P1TrX4W
	 RRY1xRp14nS3T8n2doOemEfUqZJ7xGOEqKE63+yg+r63HGH8XkHK8VET+xrWYT14hs
	 X1FBUoUy5EfOnEIt1XmAxvaONaoBudHGHwrDg++lrCVagCgM08OKR+zuYoRoUnBfLj
	 vhB0HVP47s18nXvEaxiCLVElbZn9Kv17LCr6a3D7Lg92MAeNTebNMgKnB0d9z18H8W
	 eZp9cY8aGvuhLiyx/10zBsEsBK7+YG6OIbvnaRD5c/natdh1ZNSScKK6PxUol+pKFx
	 2E7Q3Iv8F/s5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/7] net: mana: RCU-protect gc->cq_table
 lookups against concurrent CQ destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721234339.1476932-2-longli@microsoft.com>
References: <20260721234339.1476932-1-longli@microsoft.com>
 <20260721234339.1476932-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:46:16 +0000
Message-Id: <20260722234617.088971F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent QP creations sharing the same CQ cause a data race =
on `send_cq->queue.id`, leaking CQ table entries and triggering a double fr=
ee of `gdma_cq` in the error path.
- [High] The EQ event handler `mana_gd_process_eqe()` triggers a false posi=
tive `WARN_ON_ONCE(!cq)` when encountering stale EQEs for a recently destro=
yed CQ during normal teardown.
- [High] `mana_gd_destroy_queue()` frees EQ queues immediately after `list_=
del_rcu()` without waiting for an RCU grace period, causing a use-after-fre=
e if an interrupt handler is concurrently traversing the EQ list.
--

--- Patch [1]: [PATCH net-next v2 1/7] net: mana: RCU-protect gc->cq_table =
lookups against concurrent CQ destroy ---
commit 4df31c26faa213971de40d92e7d0a48ab9e5d300
Author: Long Li <longli@microsoft.com>

net: mana: RCU-protect gc->cq_table lookups against concurrent CQ destroy

This commit fixes a use-after-free race between the EQ interrupt handler and
CQ teardown by placing the cq_table under RCU protection. It annotates the
table, updates readers to use rcu_dereference, and ensures removers clear
the slot and call synchronize_rcu() before freeing the CQ.

> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c

[ ... ]

> @@ -149,23 +157,49 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,=
 struct mana_ib_cq *cq)
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
> +
> +	/* Wait for in-flight EQ handlers that may have loaded the old
> +	 * pointer via rcu_dereference() to finish before freeing.
> +	 */
> +	synchronize_rcu();
> +	kfree(gdma_cq);
>  }

[Severity: Critical]
This is a pre-existing issue, but does this actually prevent double frees
during concurrent QP creation failures?

If multiple concurrent ib_create_qp() calls share the same send_cq, the IB
core takes a read lock. In mana_ib_create_qp_raw(), the shared
send_cq->queue.id is locklessly overwritten:

drivers/infiniband/hw/mana/qp.c:mana_ib_create_qp_raw() {
    ...
    qp->raw_sq.id =3D wq_spec.queue_index;
    send_cq->queue.id =3D cq_spec.queue_index;
    ...
}

If both threads fail after this point (e.g., due to an invalid user pointer=
),
they both jump to the error path and call mana_ib_remove_cq_cb().

Since the removers are not serialized in this error path, couldn't they both
read the same gdma_cq pointer, both clear it, wait for synchronize_rcu(),
and then both call kfree(gdma_cq)?

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c

[ ... ]

> @@ -772,10 +773,11 @@ static void mana_gd_process_eqe(struct gdma_queue *=
eq)
>  	switch (type) {
>  	case GDMA_EQE_COMPLETION:
>  		cq_id =3D eqe->details[0] & 0xFFFFFF;
> -		if (WARN_ON_ONCE(cq_id >=3D gc->max_num_cqs))
> +		cq_table =3D rcu_dereference(gc->cq_table);
> +		if (WARN_ON_ONCE(cq_id >=3D gc->max_num_cqs || !cq_table))
>  			break;
> =20
> -		cq =3D gc->cq_table[cq_id];
> +		cq =3D rcu_dereference(cq_table[cq_id]);
>  		if (WARN_ON_ONCE(!cq || cq->type !=3D GDMA_CQ || cq->id !=3D cq_id))
>  			break;

[Severity: High]
This isn't a bug introduced by this patch, but could this WARN_ON_ONCE
trigger as a false positive during normal teardown?

During interface teardown, mana_deinit_cq() clears cq_table[id] and waits
for an RCU grace period, but the associated EQ remains active until
mana_destroy_eq() is called later.

If the EQ already contains a completion event for the destroyed CQ, the
interrupt handler will process the stale EQE, read a NULL pointer for cq,
and hit this warning.

Since panic_on_warn is common in cloud environments, could this crash the
system during a standard interface teardown?

[ ... ]

> @@ -1082,15 +1084,28 @@ static void mana_gd_create_cq(const struct gdma_q=
ueue_spec *spec,
>  static void mana_gd_destroy_cq(struct gdma_context *gc,
>  			       struct gdma_queue *queue)
>  {

[ ... ]

> +	/* Wait for in-flight EQ handlers that may have loaded the old
> +	 * pointer via rcu_dereference() to finish before the caller
> +	 * frees the CQ memory.
> +	 */
> +	synchronize_rcu();
>  }

[Severity: High]
This is a pre-existing issue, but does mana_gd_destroy_queue() need a simil=
ar
synchronize_rcu() to prevent a use-after-free?

While mana_gd_intr() traverses the EQ list under RCU:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_intr() {
    rcu_read_lock();
    list_for_each_entry_rcu(eq, &gic->eq_list, entry)
        mana_gd_process_eqe(eq);
    rcu_read_unlock();
}

The teardown path removes the queue via list_del_rcu() but then immediately
frees the memory without waiting for a grace period:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_destroy_queue() {
    ...
    mana_gd_destroy_dma_region(gc, gmi->dma_region_handle);
    mana_gd_free_memory(gmi);
    kfree(queue);
}

Could a concurrent reader in mana_gd_intr() dereference the freed EQ if
the memory is released before the RCU grace period ends?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721234339.1476=
932-1-longli@microsoft.com?part=3D1
