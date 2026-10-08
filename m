Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DB36A34F
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486577; cv=none; b=dFSlYzN7oZuDFR4rJi7biENLNQspPfZtZLBT+fkilic7/rmupgXBLqp5y3Ey41wsvyDjVjh/oPW+sDc/L+zaxFuu08Z01Jnn/amntX2m/qrsA+tKXPqGRkMJldLnJXlYqrbvEyEBGfOrKI6Ph9QNpQEnv9ZuPc58SBE5Xaq7I5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486577; c=relaxed/simple;
	bh=3W2T/Q83Hf+hfLBafR3ti/y8M6x3Z8xgETBa0LKLdf0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qHLXDcTk3lTcCj7B83fR8D8RuGiPeEhsgzc7q2OgFwqHXiARQ6uH4HsPVz3oDVTZThvGHJBiiMZDkD2GnkaVUs0ArWueqYMkZwgqv5vMzdBd6YMD46vRLBWkwqn5M0oFnxY8pHnh9jGgfimY6JyuvEZixpgy5tI/tKMwAbwcMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASkFMdKr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASkFMdKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAE21F000FF;
	Thu,  8 Oct 2026 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486576;
	bh=YJB/vZc2wbS2PUsxBlhHW6j4weNFuMaIgE1Oh03aZZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASkFMdKruJ0DMw97T5fpqFbD8wNt2j7PYjRj6ldFhCoV7ajqmszxdK02EZxxm6SpM
	 GD1E75IYeV6HVUQCcQsHlAeFDdhvVMvUZMcNMXNkcAOYRT0XNEhYa01ZJfguFENni7
	 fNBAA377XE7MkjyDNv5i9er0QyHC61xO/XMftcuv3hZMGslW69f3rq+R8SC4J0ceXg
	 mYZWvzZueHxEyaV0uyr1a7LNCkSTQYA70Jd2k0hP4LMW7XRspTf8qXQZwVHbMQDzpD
	 rAOMVGbXwLta3ASmf/VOKx/MVASS0S3jWJ57l9x0od6qZG7beZmu8t0Mb+IszVnegA
	 Li97vji8rfEaQ==
Message-ID: <sashiko-outbox-164496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] hv: vmbus: retain backing until ownership and
 references clear
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261007190752.336426-9-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <20261007190752.336426-9-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:09:35 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] workqueue: UAF of workqueue in vmbus_buffer_reclaimer_shutdown() r=
acing with timer
- [Medium] mm: permanent memory leak of arrays and successful pages on part=
ial encryption failure
--

commit 6530feb3fbe0165655c6797c004705143b2a41a7
Author: Emerson Busson <emersonbusson@gmail.com>
Subject: hv: vmbus: retain backing until ownership and references clear

This commit changes the VMBus channel code to keep buffer allocations and
GPADL states retained until ownership, page-state, and mapping-reference
conditions are clear. It adds a background workqueue for delayed reclaim
when mappings are released or teardown is acknowledged.

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
[ ... ]
> +static void vmbus_buffer_reclaim_work(struct work_struct *work)
> +{
[ ... ]
> +	if (ret) {
> +		mutex_lock(&vmbus_buffer_owners_lock);
> +		owner->permanent_leak =3D true;
> +		owner->work_active =3D false;
> +		owner->reclaiming =3D false;
> +		vmbus_buffer_trace_owner(owner, "retained");
> +		mutex_unlock(&vmbus_buffer_owners_lock);
> +		pr_warn_ratelimited("VMBus buffer reclaim retained pages after encrypt=
ion failure: %d\n",
> +				    ret);
> +		return;

[Severity: Medium]
Will this early return permanently leak previously processed pages?

In vmbus_buffer_reclaim_work(), if set_memory_encrypted() fails on a chunk,
it breaks the loop and returns early.

Bypassing the cleanup paths permanently leaks all other successfully
processed pages in the buffer, as well as the owner->chunks and
owner->pages tracking arrays allocated via kvmalloc_array, and the owner
struct itself.

> +	}
> +
> +	vmbus_buffer_trace_owner(owner, "reclaimed");
[ ... ]
> +/* Caller holds the owner lock or exclusive custody of this owner. */
> +void vmbus_buffer_owner_drain(struct vmbus_buffer_retained *owner,
> +			      struct workqueue_struct *wq)
> +{
> +	if (!cancel_delayed_work(&owner->reclaim_work))
> +		return;

[Severity: High]
Does this non-sync cancel risk a use-after-free when racing with the timer
callback?

If the delayed work's timer has just expired and its softirq handler
(delayed_work_timer_fn) is concurrently running on another CPU,
cancel_delayed_work() returns 0 without waiting.

> +
> +	owner->work_active =3D false;
> +	if (wq && vmbus_buffer_owner_can_reclaim(owner)) {
> +		owner->work_active =3D true;
> +		mod_delayed_work(wq, &owner->reclaim_work, 0);
> +	}
> +}
> +
> +void vmbus_buffer_reclaimer_shutdown(void)
> +{
> +	struct workqueue_struct *wq;
> +	struct vmbus_buffer_retained *owner;
[ ... ]
> +	list_for_each_entry(owner, &vmbus_buffer_owners, list)
> +		vmbus_buffer_owner_drain(owner, wq);
> +	mutex_unlock(&vmbus_buffer_owners_lock);
> +
> +	if (wq)
> +		destroy_workqueue(wq);

[Severity: High]
Can destroy_workqueue() complete while the timer handler is still running?

vmbus_buffer_reclaimer_shutdown() uses cancel_delayed_work() to stop
reclaim works. If the delayed work's timer just expired, it returns
immediately.

The shutdown function then drops the mutex and calls destroy_workqueue(wq).

destroy_workqueue() flushes existing work but does not synchronize with
concurrent timer handlers that have not yet called queue_work().

destroy_workqueue() finishes and frees the workqueue structure.

The timer handler then proceeds to call queue_work() on the freed workqueue,
causing a use-after-free on module unload.

> +}
[ ... ]
> +int vmbus_alloc_buffer_owned(struct vmbus_channel *channel, u32 size,
> +			     bool confidential, struct vmbus_buffer *buffer)
> +{
[ ... ]
> +	while (remaining) {
> +		struct page *page;
> +		gfp_t gfp;
> +		int nid;
> +
> +		order =3D vmbus_buffer_order(remaining, order);
> +
> +		gfp =3D GFP_KERNEL | __GFP_ZERO;
> +
> +		nid =3D cpu_to_node(channel->target_cpu);
> +		page =3D vmbus_alloc_pages_with_fallback(nid, gfp, &order,
> +						       vmbus_alloc_pages_node, NULL);
> +		if (!page)
> +			goto err;
> +
> +		buffer->chunks[buffer->chunk_cnt++] =3D page;
> +		for (i =3D 0; i < (1U << order); i++)
> +			buffer->pages[page_idx++] =3D page + i;
> +		buffer->page_cnt =3D page_idx;
> +
> +		ret =3D set_memory_decrypted((unsigned long)page_address(page),
> +					   1U << order);
> +		if (ret) {
> +			/*
> +			 * set_memory_decrypted() failed; the page state is
> +			 * unknown so it must be leaked rather than freed.
> +			 */
> +			owner->encryption_unknown =3D true;
> +			goto err;

[Severity: Medium]
Could this goto leak the successfully processed pages?

In vmbus_alloc_buffer_owned(), if set_memory_decrypted() fails on a chunk,
it sets owner->encryption_unknown =3D true and jumps to err.

This marks the entire owner as non-reclaimable, leaking all previously
populated chunks and tracking arrays.

> +		}
> +		owner->needs_encrypt =3D true;
> +
> +		remaining -=3D 1U << order;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007190752.3364=
26-1-emersonbusson@gmail.com?part=3D8
