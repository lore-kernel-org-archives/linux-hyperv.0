Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031848;
	b=e7FtUufuB6vt0ijru5AaTeinuflg6tl02IYtfQdUb9wBHYA9PHs1s+ILqR2fKElgy/7s
	 16KdIwWVyZZb+kKbg05Ipu6tUh5fGYNLIPg0zukKPar1OADu6E7tcBeqtHh7xTyUyblcl
	 s8U48QfX3KIiRcmGs3KgOJWlbWIPMyGC6lFx9WkFWQKtwyiCE84qkkR1bBhMJnSHQ6/rK
	 XNWHEzbZ9nCK/Hqt38OxjuEookImAI6g2r6Rs/FP0wFQrpbRpnJOdC4Mx6ZIi3h8XIHKm
	 Fj2sE4AlRnhkuzSy7yyqLiBzVi4BGT7NiO0+YFXSu07NxxgVWu9CsARe61pmV8rmYOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mb1LylgSgLYx9kP7yTYuR0Xon9M6txJJYletyYuCONI=;
	b=BsjV74TZhz7MOvWuyAzAhOgGLZHmY8lrvXEI7djmc+FFE6LIDm7j3kNOELaO6L+/KJPD
	 B26jgwMIf5r4wruM37aqKFKsOATsLlPkENVt7EH4wINtw3/74dBe+kS7mNJ+tnJUEwzcc
	 pDTbv+36nmtF6rvk/2kCl8cMjf8vB6dZSzdRUqgOGBR5h/7zM+Bp7nXD6HuGObdnKEOqS
	 Zoq74oKdwBWpuYBpf/HePKUzEEq+eiiQQROeQCumNa8cffzUTw4e7lcEiAgOu6RM3+SsS
	 Uzn7TbOrgxPqvUO3BylJZlN/98BxCFFEDA4xDlIrkQwSRsGCBHZIZMk0aWj8y5NAkLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAE2RuA9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163E606A31C
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Nov 2026 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAE2RuA9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DA41F000C4;
	Wed, 18 Nov 2026 19:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031848;
	bh=Mb1LylgSgLYx9kP7yTYuR0Xon9M6txJJYletyYuCONI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAE2RuA9mEng/37BehHCUh/KtrfA861OVLISmozmXGH69NB+dS1BtvzGFgh9v30T6
	 qUZIlcOUCz5dp+WGXJUO6dnMA1mzH81maxdCgGZAM5jl/UzPbsdDbfRLZ4LzRyB/TR
	 OuqPdnY0okTBtVURSmIpdkkWkl1XlfNFjTWdV2rBp2Ae2nHQPGA22yx3SkDXT+vrlf
	 u20c0rfOFT/BX/6o7t6LFTOiWq3I4rufFlOdEopRV2F9Xzo5l6nL08QqUzjrYmq794
	 BXfGuRW06CgayIzmXIUaAjx2mVIizcNklfS7GpvrcxpWmabq0K7zS7WZXqLYYKAyPZ
	 dObggkZAUqXqg==
Message-ID: <sashiko-outbox-221909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3JpdmF0c2EgUy4gQmhhdCAoTWljcm9zb2Z0KQ==?= <srivatsa@csail.mit.edu>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
References: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:57:27 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] block: incomplete and racy freed-request check in
  blk_mq_complete_request_remote()
- [Medium] nvme: missing in-flight state check in nvme_find_rq() allows
  prior crash and corruption
- [Low] block: inaccurate Fixes: trailer in commit message
--

commit 65327008502cbbac3ada696570a4b5ff52feb917
Author: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

> block: Fix NULL pointer dereference in blk_mq_complete_request_remote
>
> Add NULL pointer validation in blk_mq_complete_request_remote() to
> prevent kernel crashes when block drivers pass freed request structures.
>
> When NVMe devices experience hardware failures or firmware bugs,
> completion queue corruption can occur, leading to scenarios where
> drivers attempt to complete already-freed requests. The NVMe genctr
> validation in nvme_find_rq() catches most stale completions, but when
> corruption produces a command_id whose genctr bits happen to match,
> the freed request passes validation and reaches the block layer. The
> block layer's __blk_mq_free_request() sets rq->mq_hctx to NULL,
> but blk_mq_complete_request_remote() lacks validation before
> dereferencing this pointer.
>
> This manifests as a kernel crash like shown below (the stack trace
> was obtained from a crash observed in a Linux VM on Hyper-V):
>
>   nvme nvme0: resetting controller due to AER
>   nvme nvme0: request 0xe3 genctr mismatch (got 0x0 expected 0x5)
>   nvme nvme0: invalid id 227 completed on queue 6
>   nvme nvme0: request 0x26 genctr mismatch (got 0xb expected 0x9)
>   nvme nvme0: invalid id 45094 completed on queue 94
>
>   BUG: kernel NULL pointer dereference, address: 00000000000000fe
>   RIP: 0010:blk_mq_complete_request_remote+0x1b/0x150
>   Call Trace:
>    <IRQ>
>    nvme_irq+0x182/0x320 [nvme]
>    __handle_irq_event_percpu+0x47/0x180
>    handle_irq_event+0x38/0x60
>    handle_edge_irq+0x87/0x1a0
>    __common_interrupt+0x3f/0xa0
>    common_interrupt+0x42/0xa0
>
> The crash occurs at offset 0xfe when accessing rq->mq_hctx->nr_ctx,
> where mq_hctx is NULL.
>
> Add a NULL check that returns true (signaling to callers that the
> request has been handled) to gracefully drop freed requests, with a
> WARN_ONCE to flag the condition for diagnosis.
>
> Fixes: 40d09b53bfc5 ("blk-mq: add a new blk_mq_complete_request_remote AP=
I")
> Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

[Severity: Low]
In commit 40d09b53bfc5 ("blk-mq: add a new blk_mq_complete_request_remote A=
PI"),
blk_mq_complete_request_remote() did not dereference rq->mq_hctx.  The
rq->mq_hctx->nr_ctx dereference was added later, so should the Fixes tag
instead be:

  Fixes: f168420c62e7 ("blk-mq: don't redirect completion for hctx withs on=
ly one ctx mapping")

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5ae22d5565404..5dc9d7d806b59 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1307,6 +1307,15 @@ static void blk_mq_raise_softirq(struct request *r=
q)
> =20
>  bool blk_mq_complete_request_remote(struct request *rq)
>  {
> +	/*
> +	 * Validate request is not freed (__blk_mq_free_request() sets
> +	 * mq_hctx =3D NULL).
> +	 */
> +	if (unlikely(!rq->mq_hctx)) {
> +		WARN_ONCE(1, "%s: attempt to complete freed request", __func__);
> +		return true;
> +	}
> +
>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> =20
>  	/*

[Severity: High]
Is checking !rq->mq_hctx sufficient and race-free for detecting requests
that are not in flight?

First, the batched completion fast path used by nvme-pci frees requests
without ever clearing rq->mq_hctx:

block/blk-mq.c:blk_mq_end_request_batch() {
    ...
		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
		if (!req_ref_put_and_test(rq))
			continue;

		blk_crypto_free_request(rq);
		blk_pm_mark_last_busy(rq);

		if (nr_tags =3D=3D TAG_COMP_BATCH || cur_hctx !=3D rq->mq_hctx) {
			if (cur_hctx)
				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
			nr_tags =3D 0;
			cur_hctx =3D rq->mq_hctx;
		}
		tags[nr_tags++] =3D rq->tag;
    ...
}

Requests freed through blk_mq_end_request_batch(), requests reallocated
or cached in a plug via blk_mq_rq_ctx_init() (still in MQ_RQ_IDLE before
blk_mq_start_request()), and requests already in MQ_RQ_COMPLETE awaiting
remote IPI or softirq completion all have a non-NULL rq->mq_hctx.  A
spurious or duplicate CQE matching one of those requests bypasses the
!rq->mq_hctx check and completes the request a second time (causing
double DMA unmapping in nvme_pci_unmap_rq(), refcount and sbitmap tag
underflow, or cyclic corruption of the per-CPU blk_cpu_done llist if
rq->ipi_list is queued twice).

Second, because __blk_mq_free_request() clears rq->mq_hctx without
synchronization against a spurious completion on another CPU, the unlocked
check still races:

CPU0                                  CPU1
blk_mq_free_request(rq)
  WRITE_ONCE(rq->state, MQ_RQ_IDLE)
                                      blk_mq_complete_request_remote(rq)
                                        if (unlikely(!rq->mq_hctx))
                                          /* observes non-NULL */
                                        WRITE_ONCE(rq->state, MQ_RQ_COMPLET=
E)
  __blk_mq_free_request(rq)
    rq->mq_hctx =3D NULL
                                        if (rq->mq_hctx->nr_ctx =3D=3D 1 ..=
.)
                                          <-- NULL pointer dereference

In addition to crashing at rq->mq_hctx->nr_ctx, CPU1 overwrites the freed
request's rq->state back to MQ_RQ_COMPLETE after CPU0 set it to
MQ_RQ_IDLE.

[Severity: Medium]
Should stale completions be rejected earlier in nvme_find_rq() by checking
that blk_mq_rq_state(rq) =3D=3D MQ_RQ_IN_FLIGHT (similar to
scsi_host_find_tag() and nbd_read_reply())?

When nvme_find_rq() returns a request whose 4-bit genctr collided with a
corrupted CQE, callers act on that request before
blk_mq_complete_request_remote() is reached:

drivers/nvme/host/pci.c:nvme_handle_cqe() {
    ...
	trace_nvme_sq(req, cqe->sq_head, data_race(nvmeq->sq_tail));
	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
    ...
}

If the nvme_sq tracepoint is enabled, trace_nvme_sq() calls
nvme_req_qid(req), which dereferences req->mq_hctx->queue_num and hits the
same NULL pointer dereference when req->mq_hctx is NULL.  Next,
nvme_try_complete_req() increments nvme_req(req)->genctr and overwrites
status and result before calling blk_mq_complete_request_remote(), which
corrupts the request if it has already been reallocated or is awaiting
remote completion and causes its real completion to fail genctr
validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-fix-blk-mq=
-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu?part=3D1
