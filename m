Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683B492196
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729405; cv=none; b=sp1CHZHZNmd93cbzC5YRoM8+7OLnp0jvdjA5ubD4VaKse4DnNtM7I4ovf8HqL6szRvxccVHJbsk+Gqm5cxrF6Q2l3W2gaQKJolSqpyji0DzEm5X9KA8uXQ0NPsw/FeKLmQ7kxeKZFg6cCpGc8aEztpkIxvWlxSPzoP8zPaIX0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729405; c=relaxed/simple;
	bh=VX+uhDwhAPcrurUv8JJz4a96cBTzc2aCiLXLFUkiKLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qf10jXegBfa6n6E+5AkxlEYu4mZKf6fJQVC7wC/m4PQLfd+QP0CxXlVJVST8b/spkTTyG00zMzCr91aqhcdmFzY/K9O6D0z54OxJwg2H3caui3FGHNIgjWD9WzyEUUzkzsshfZ7ig4ci8KW3vCBdgaflKfuB6YErrNCDv7aa7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khqoshKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khqoshKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6311C1F000E9;
	Fri, 14 Aug 2026 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729403;
	bh=e1lqosTYuAaTGhHZxlouwcRNnj+DJ6wJa4NqW2CDBGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khqoshKdv/KIyxldAZN+kfY/313imU0zEoNx6izOEUWBPCNrCOK26Rv6tShIj5ziV
	 b1swQ4zyc8+JcL79PrsZZSQIXeuoSFgsi5FtKxB4jrVBaM66dF0oXrhuOv+DU2IXpc
	 e0OaY+qZ4BB2NgpupvhBb2RBiXPDRCNRipQSRNdauGTksIcSuWSeSM40Ptyfdxqzt3
	 yuZy+PHcF81W409xDBa4q+TbxbcI9wDWHCgkrlF52q2VLmKRXfkMMgyhfYMMUUXUUS
	 JMbP464wSmjO6CDlkY5Rp4o4UYvGtanyP/TgCEIYIgADtLr6YV0CDyKKkMRwAj9eyW
	 CPVvH31IWycYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 7/7] net: mana: keep max_num_cqs immutable once
 cq_table is allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813174243.3044348-8-longli@microsoft.com>
References: <20260813174243.3044348-1-longli@microsoft.com>
 <20260813174243.3044348-8-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:43:23 +0000
Message-Id: <20260814174323.6311C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `mana_gd=
_publish_cq()` and `mana_gd_unpublish_cq()` allows a malicious device to ca=
use out-of-bounds array reads and writes, bypassing the patch's protection.
- [High] The untouched `WARN_ON(err)` in `mana_hwc_establish_channel()` sti=
ll allows a maliciously crafted concurrent device response to trigger a ker=
nel panic, defeating the purpose of the patch.
- [High] Multiple other `WARN_ON_ONCE` statements evaluating device-control=
led inputs remain in the code, leaving the guest vulnerable to a device-ind=
uced panic.
--

--- Patch [7]: [PATCH net v7 7/7] net: mana: keep max_num_cqs immutable onc=
e cq_table is allocated ---
commit e063157399f0ceb210a06b4543697e98b1cac7e9
Author: Long Li <longli@microsoft.com>

net: mana: keep max_num_cqs immutable once cq_table is allocated

This commit addresses an issue where an untrusted device event can update t=
he
max_num_cqs bound after cq_table allocation, leading to out-of-bounds
accesses. It fixes this by snapshotting the bound in hwc_init_max_num_cqs a=
nd
reading it once in mana_hwc_establish_channel(). It also replaces a WARN_ON
with an error return so that a malicious device cannot panic a panic_on_warn
guest.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index b1269f7da0563..d9bff4634dc35 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -209,7 +209,11 @@ static void mana_hwc_init_event_handler(void *ctx, s=
truct gdma_queue *q_self,
>  			break;
> =20
>  		case HWC_INIT_DATA_MAX_NUM_CQS:
> -			gd->gdma_context->max_num_cqs =3D val;
> +			/* Store only; establish_channel() commits it to
> +			 * max_num_cqs once, so a later event cannot grow the
> +			 * bound past the allocation.  Pairs with its READ_ONCE().
> +			 */
> +			WRITE_ONCE(hwc->hwc_init_max_num_cqs, val);
>  			break;
> =20

[Severity: High]
This is a pre-existing issue, but does this vulnerability still exist for t=
he
CQ ID?

In mana_hwc_init_event_handler(), the untrusted device event can concurrent=
ly
overwrite the queue ID without synchronization:

		case HWC_INIT_DATA_CQID:
			hwc->cq->gdma_cq->id =3D val;
			break;

Meanwhile, mana_gd_publish_cq() reads queue->id multiple times, first to
validate the bound and then to index the array:

	if (!cq_table || queue->id >=3D gc->max_num_cqs)
		return -EINVAL;

	/* Sharing a CQ between WQs is not supported. */
	if (rcu_access_pointer(cq_table[queue->id]))
		return -EINVAL;
	...
	rcu_assign_pointer(cq_table[queue->id], queue);

If the device sends a malformed CQID event that arrives after the bounds
check but before the array indexing, couldn't this force an out-of-bounds
array write of the queue pointer? The same Time-of-Check to Time-of-Use race
condition appears to exist in mana_gd_unpublish_cq().

[ ... ]

> @@ -810,17 +816,32 @@ static int mana_hwc_establish_channel(struct gdma_c=
ontext *gc, u16 *q_depth,
>  	*max_req_msg_size =3D hwc->hwc_init_max_req_msg_size;
>  	*max_resp_msg_size =3D hwc->hwc_init_max_resp_msg_size;
> =20
> -	/* Both were set in mana_hwc_init_event_handler(). */
> -	if (WARN_ON(cq->id >=3D gc->max_num_cqs))
> +	/* Snapshot the device-reported count and id once, so the same value
> +	 * sizes, bounds and indexes cq_table even across the sleeping
> +	 * vcalloc() and a concurrent init event.
> +	 */
> +	num_cqs =3D READ_ONCE(hwc->hwc_init_max_num_cqs);
> +	cq_id =3D READ_ONCE(cq->id);
> +
> +	/* Both operands come from untrusted HWC bootstrap events; a missing
> +	 * MAX_NUM_CQS leaves num_cqs at 0.  Reject rather than WARN_ON() so a
> +	 * malformed device response cannot panic a panic_on_warn guest.
> +	 */
> +	if (cq_id >=3D num_cqs) {
> +		dev_err_ratelimited(hwc->dev,
> +				    "HWC: bad CQ id %u >=3D max %u\n",
> +				    cq_id, num_cqs);
>  		return -EPROTO;
> +	}
> =20
> -	cq_table =3D vcalloc(gc->max_num_cqs, sizeof(*cq_table));
> +	cq_table =3D vcalloc(num_cqs, sizeof(*cq_table));
>  	if (!cq_table)
>  		return -ENOMEM;
> =20
> -	/* Publish the initialised table; pairs with smp_load_acquire()
> -	 * in mana_gd_get_cq().
> +	/* Publish the bound and the initialised table together; the release
> +	 * pairs with smp_load_acquire() in mana_gd_get_cq().
>  	 */
> +	gc->max_num_cqs =3D num_cqs;
>  	smp_store_release(&gc->cq_table, cq_table);
> =20
>  	/* Publish the HWC CQ now that the table is in place. */

[Severity: High]
This is a pre-existing issue, but does a maliciously crafted concurrent dev=
ice
response still have the ability to trigger a kernel panic here?

Just below this context in mana_hwc_establish_channel(), there is an
untouched WARN_ON():

	err =3D mana_gd_publish_cq(gc, cq);
	if (WARN_ON(err))
		return err;

If a HWC_INIT_DATA_CQID event is processed after the READ_ONCE(cq->id)
snapshot earlier in this function, mana_gd_publish_cq() will correctly reje=
ct
the modified ID and return -EINVAL. However, won't that returned error
trigger this WARN_ON(), crashing a panic_on_warn guest anyway?

[Severity: High]
This is a pre-existing issue, but are there other WARN_ON_ONCE() statements
evaluating device-controlled inputs that could lead to a device-induced pan=
ic?

For example, in mana_hwc_rx_event_handler():

	if (WARN_ON_ONCE(hwc_rxq->gdma_wq->id !=3D gdma_rxq_id))
		return;

In mana_hwc_tx_event_handler():

	WARN_ON_ONCE(!hwc_txq || hwc_txq->gdma_wq->id !=3D gdma_txq_id);

And in mana_gd_read_cqe():

	new_bits =3D (cq->head / num_cqe) & GDMA_CQE_OWNER_MASK;
	/* Return -1 if overflow detected. */
	if (WARN_ON_ONCE(owner_bits !=3D new_bits))
		return -1;

Since these validate untrusted values from the DMA completion ring, could a
malformed response trigger these warnings and panic a guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174243.3044=
348-1-longli@microsoft.com?part=3D7
