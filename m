Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D434D929
	for <linux-hyperv@vger.kernel.org>; Fri,  4 Sep 2026 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547277; cv=none; b=FLsRxuzqjxq0HxxLe/bka8ohUr3Rwf+4khgpNbP/DD/2f51Pt2St2p5R0QOXL0EG7mtZjPsVbDNO2k8D74cdQRDgYnQoSgZXEDEVulloCT/Tiyd4YSlt7rNWnMsyOXpmlJ46k7PX94E7fUH6dJhNfQFgn/DulOd59tHdRZrvP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547277; c=relaxed/simple;
	bh=DVkWlJoKR3c5misT9ry1vd54wEglsv28jLg5OYiZhi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=peoH4FYHFGntMVwXidpUnrHJDKzP54Zvc9aKv4Apv/2VZx5o4WkEvKJP4p/JIViUdY8hYvcHep2pFnlVs7wQJAHyymJGO5HlTvYQA2szittS8h9/Z9zA+mYtwJ+XNQ209N6qbXxacsW2a4fxI8KAd2JXb23NQqRvoIM552cC1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THelkqq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THelkqq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CFB1F00A3D;
	Fri,  4 Sep 2026 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547275;
	bh=lwKcUCXQDNbBdHcZ67cgAt0UO1AR4CVDeRTjO8vmkkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THelkqq6c/wGEo9sDVJ/4BHESQOP4rivfX4N/cMf03QQgXxzl146qhMkfLRoBuWiX
	 H2OfhMNlVKyeWtZcXvglka0xq7EvGiTqzLo+IF//FuNz3GAnRVycxh1huOiBQ/ZJPJ
	 +iFDxWMcUVeWagXZbtq7vTmyoG1v1ATagVtBRi7GkmB69knLO9NYrbHlw/baEDXGds
	 OdmHPzoATYX6QqdesJthY39k5VCbmGtUTiIkgPET2UxIyjQ76JORpqV5489nTTT6zq
	 o0nBgajcNYzJ0l5UghV75wd4nIwRgPS4YSIqkdWZZJ5CJqXF5riGEuwqJDBtboT8qo
	 692d0oAAxuSeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: mana: Use the HWC destination queues
 reported by the hardware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manish Awasthi" <mawasthi@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
References: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:41:14 +0000
Message-Id: <20260904184115.42CFB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Timeout handling releases msg_id for immediate reuse without flush=
ing the hardware queue or reinitializing completions, leading to data corru=
ption and race conditions from late hardware completions.
--

commit fa131293a7bcd61d0524a5c94944a9ade71d8bda
Author: Manish Awasthi <mawasthi@linux.microsoft.com>

net: mana: Use the HWC destination queues reported by the hardware

This commit simplifies the MANA driver by unconditionally using the hardwar=
e-
reported destination queues for HWC requests. It removes the PF-specific
checks since the hardware already supplies values that are valid for the gi=
ven
function.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 263e7c4e29341..5d75c2478a8a8 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -890,10 +889,13 @@ int mana_hwc_send_request(struct hw_channel_context=
 *hwc, u32 req_len,
>  	tx_wr->msg_size =3D req_len;
>  	command =3D req_msg->req.msg_type;
> =20
> -	if (gc->is_pf) {
> -		dest_vrq =3D hwc->pf_dest_vrq_id;
> -		dest_vrcq =3D hwc->pf_dest_vrcq_id;
> -	}
> +	/* The hardware reports the HWC destination queues through
> +	 * HWC_INIT_DATA_PF_DEST_RQ_ID and HWC_INIT_DATA_PF_DEST_CQ_ID, and
> +	 * always supplies values that are valid for this function, so no
> +	 * PF-specific handling is needed here.
> +	 */
> +	dest_vrq =3D hwc->pf_dest_vrq_id;
> +	dest_vrcq =3D hwc->pf_dest_vrcq_id;
> =20
>  	err =3D mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
>  	if (err) {

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
in drivers/net/ethernet/microsoft/mana/hw_channel.c within=20
mana_hwc_send_request() and mana_hwc_handle_resp().

If mana_hwc_send_request() times out waiting for the hardware:

	if (!wait_for_completion_timeout(&ctx->comp_event,
					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
		...
		err =3D -ETIMEDOUT;
		goto out;
	}

It proceeds to release the msg_id for immediate reuse without flushing the
hardware queue:

out:
	mana_hwc_put_msg_index(hwc, msg_id);
	return err;

If a concurrent or subsequent thread calls mana_hwc_send_request() and reus=
es
this msg_id, could a late hardware response for the original timed-out requ=
est
cause memory corruption?

When the late response arrives, mana_hwc_handle_resp() would see that the
msg_id is currently active, copy the stale response into the newly allocated
request's buffer, and prematurely signal its completion event:

	if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
        ...
	}
	ctx =3D hwc->caller_ctx + msg_id;
	...
	memcpy(ctx->output_buf, resp_msg, resp_len);
out:
	...
	complete(&ctx->comp_event);

Because reinit_completion() is not called upon reuse, the completion event
would also be left in an incorrect signaled state. Does this race need to be
addressed to prevent data corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903184104.3194=
819-1-mawasthi@linux.microsoft.com?part=3D1
