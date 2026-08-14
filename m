Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BF490C12
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729406; cv=none; b=RRBdc1V0+0hUN3qZurWLV35T93ye+fG5SjQmKycB2BL6VFbC3fzri9BsWZkAqJGIVy3GNe/gGNP6uyB+YyID1GiElSuIEsITxrtYOleE8yWf7g3PFJ5/Po+IdzfjviFxwWdiln207hpxokMXPxmD+4HFENPa6xI6g9WEbqgM+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729406; c=relaxed/simple;
	bh=MOOUTG5jqUhZLf7okBUZ3VV3XQVYlA85iZa65eXy0uI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ghc0SKY3XcIgUuGdVZ3SDZd206MgAU60t224eX+sn5KgPJBjMfHqTWCI5CKkt58MfuX2EDPMEEkOXIpQa9T3rWybBpRcVJpOlHqSaNlYNZGdb9JvQDgGxt0QbeWEviMgQuulsHbmVOevnv0Z4LEFsAL3HmhqBLd9oPlNV5KEzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6/+N/Tp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6/+N/Tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73541F00A3A;
	Fri, 14 Aug 2026 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729405;
	bh=6iqA/0jCJA6peHlqeIpJM+dc+a2GYZ6g+WgZddLqLP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X6/+N/Tp++IBpkHaZReRzO8VfWi53aVqVF+XShNm+0zJJuXbGec+b0i1wAQVn1wNe
	 8hc3n7vWBTPqlrTTo1N1StFVhb0rW70ECdIF4XntYE5RbFCJpMOWQ+22itl1h9jcyR
	 qsZn7HLq2jFqsSXVLPPclBK6dYl0R4KEXwgOO7VzEHB3mFJwiSyxjFelXcUnnlVu5L
	 Jx84ZBbR86nr6EkmV3lramYSlYKuOe4EJgj+w1zfa1SGkyAzE4nzvKilNJwR2yYkIb
	 loUwJj/iEveJXarPoVVwWgWNyXiBEpihIF1cM9RGeRXwEweWYCmsnM3iF7OcgK3+4X
	 EW0bbOVpVRSqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 6/7] net: mana: fix stale HWC response after
 command timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813174243.3044348-7-longli@microsoft.com>
References: <20260813174243.3044348-1-longli@microsoft.com>
 <20260813174243.3044348-7-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:43:24 +0000
Message-Id: <20260814174324.D73541F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a remai=
ning protocol correlation gap. Responses from the hardware are matched to r=
equests solely by the reusable `hwc_msg_id` slot index. If a command times =
out (or is a zero-wait teardown), its slot is released and can be immediate=
ly reused by a new request. If the hardware later responds to the original =
timed-out command, the response will carry the same `msg_id`. Because the s=
lot now belongs to the new request (and `ctx->output_buf` is published), `m=
ana_hwc_handle_resp()` will incorrectly accept the stale response and copy =
its payload into the new request's buffer, leading to silent data corruptio=
n.
--

--- Patch [6]: [PATCH net v7 6/7] net: mana: fix stale HWC response after c=
ommand timeout ---
commit 4d60222957c8ccd6181005f7897ef459443e8e8b
Author: Long Li <longli@microsoft.com>
net: mana: fix stale HWC response after command timeout

This commit introduces a per-slot spinlock, refcount, and a responded flag
to prevent a late response from writing into a sender's buffer after it has
returned due to a timeout. It also replaces the counting semaphore with a
waitqueue for admission control.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 88188523dcd48..b1269f7da0563 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -106,22 +129,34 @@ static void mana_hwc_handle_resp(struct hw_channel_=
context *hwc, u32 resp_len,
>  		resp_len =3D 0;
>  	}
> =20
> -	err =3D mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
> -	if (err)
> -		goto out;
> +	spin_lock(&ctx->lock);
> =20
> -	ctx->status_code =3D resp_msg->status;
> +	/* Honour a response only while the sender owns the slot (output_buf
> +	 * published) and has not already been answered; otherwise drop it as
> +	 * premature, stale or duplicate without touching the refcount.
> +	 */
> +	if (!ctx->output_buf || ctx->responded) {
> +		spin_unlock(&ctx->lock);
> +		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
> +		return;
> +	}
> +	ctx->responded =3D true;
> =20
> -	memcpy(ctx->output_buf, resp_msg, resp_len);
> -out:
> +	err =3D mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
> +	if (!err) {
> +		ctx->status_code =3D resp_msg->status;
> +		memcpy(ctx->output_buf, resp_msg, resp_len);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but is there a remaining protocol
correlation gap here?

Responses from the hardware appear to be matched to requests solely by the
reusable hwc_msg_id slot index, with no generation counter or unique
transaction ID.

If a command times out (or is a zero-wait teardown), its slot is released
and can be immediately reused by a new request. If the hardware later
responds to the original timed-out command, won't the response carry the
same msg_id?

Because the slot now belongs to the new request (and ctx->output_buf is
published), could mana_hwc_handle_resp() incorrectly accept this stale
response and copy its payload into the new request's buffer, leading to
silent data corruption?

>  	ctx->error =3D err;
> =20
> -	/* Must post rx wqe before complete(), otherwise the next rx may
> -	 * hit no_wqe error.
> +	/* Post RX WQE before completing =E2=80=94 the next response may arrive
> +	 * immediately and needs a posted buffer.
>  	 */
>  	mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
> -
>  	complete(&ctx->comp_event);
> +	spin_unlock(&ctx->lock);
> +
> +	hwc_ctx_put(hwc, ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174243.3044=
348-1-longli@microsoft.com?part=3D6
