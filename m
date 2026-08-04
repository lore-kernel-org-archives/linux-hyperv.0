Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA093F0770
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887084; cv=none; b=BlXZxvQx/UytbVXp9fNYXmYW7/20dv5/ETgbdrc3ROPtCn6FgLY/aeH4BlkRuExMO54VANuHnwFFf4eMt6IvGOCTDFDSbnHK43itrQ25/aJ+DJrvqhjPkSMv51bfylwHcEQ62NeK/ivTUtlISraPH4JER1jtSpPHCqdmH4Bz80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887084; c=relaxed/simple;
	bh=JFa0pbhDuKCrFSM4dEVfnsLxaCPvqk7JaOVkW072Vj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AGTkd+l5N84ntgJRVSR7MAXTsIDQZcmqO4SzDlRJVQi3+U9A5dKhtv/iFimTOtFCatuHkdm6QHADDJMYoctBUyi+VrFxIfcN2fZPWjYF4JhYhKsuQg2sY99Q1Dz5/duHYP9Q5DLRPh0r4XPILwUp19p5wUVc6+dqUSLb4uk+WnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDSLQW//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDSLQW//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3026B1F000E9;
	Tue,  4 Aug 2026 23:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887083;
	bh=HFy91hj6w/p+MF/XUI1juTOUfa5QaLs8Gop2kHzPiV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDSLQW//dvsS3+26YkqSfAt/J34P7HN3ejazBrRAGCCcAbyIoPaezqxzbmy4IjFXn
	 gvVhQMGQhL6a8wtVNhpNAf42aPVJTbtknHeLKVgaSoGbhNDyCRRMhivtnIm3Hp+Zao
	 viXR9ZfaPoBkd9iSSdTBCsUsQi5DnLLf1CmPASk3aQmwnrdegzjTbyOJj4IOG6MSyT
	 58IW/2ZO5o3B6Q56p14GQKC6uGhTyxvhzDlpJS96hsnWbutZTqznnTq/jZqcjsfr/p
	 ddrK+cY4u7kemtg/BVh7RSSLCuvh0wGKDkrW1Z+5YrPQVjDUPyCv/q8vb8C+pgOolo
	 JusVUZNLxurOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 6/6] net: mana: fix stale HWC response after
 command timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260803234355.636038-7-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260803234355.636038-7-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:44:42 +0000
Message-Id: <20260804234443.3026B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A spurious, duplicate, or maliciously early hardware response can =
prematurely free the message slot before the sender takes its reference, le=
ading to a refcount use-after-free/saturation and data corruption.
--

--- Patch [6]: [PATCH net v3 6/6] net: mana: fix stale HWC response after c=
ommand timeout ---
commit 374238ca2c81aa20a65060ecc749dc0a454b16f8
Author: Long Li <longli@microsoft.com>

net: mana: fix stale HWC response after command timeout

This commit introduces a refcounted spinlock mechanism for caller contexts
to prevent stale HWC responses from corrupting output buffers or completing
the wrong command after a timeout.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 1603968d7989a..d92032b466af2 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -1034,8 +1104,14 @@ int mana_hwc_send_request(struct hw_channel_contex=
t *hwc, u32 req_len,
>  		dest_vrcq =3D hwc->pf_dest_vrcq_id;
>  	}
> =20
> +	/* Take handle_resp's ref before posting =E2=80=94 hardware can respond
> +	 * immediately after the doorbell ring.
> +	 */
> +	refcount_inc(&ctx->refcnt);

[Severity: High]
Could a spurious or duplicate hardware response arrive before this reference
is incremented?

Looking at mana_hwc_get_msg_index(), the slot is marked in the inflight
bitmap and the refcount is initialized to 1:

mana_hwc_get_msg_index()
    bitmap_set(r->map, index, 1);
    refcount_set(&ctx->refcnt, 1);
    ctx->responded =3D false;

Since the slot is immediately visible to the CQ interrupt handler upon being
added to the bitmap, if an unexpected response arrives before the sender
reaches this refcount_inc() call, mana_hwc_handle_resp() could process it.
It would see ctx->responded is false, set it to true, and call
hwc_ctx_put().

Because the sender hasn't taken its additional reference yet, hwc_ctx_put()
would drop the only reference and free the slot prematurely. When the sender
finally reaches this refcount_inc(), it would increment a zero-refcount,
triggering a warning for saturation and permanently leaking the HWC slot.

Should the refcount be initialized to 2 in mana_hwc_get_msg_index() to
account for both the sender and the response, rather than incrementing it
later during the request setup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D6
