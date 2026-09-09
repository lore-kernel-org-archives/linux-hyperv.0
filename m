Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD4283FD4;
	Wed,  9 Sep 2026 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917911; cv=none; b=PVfFAMRnko/hRGFV4VwllbG7PkESJrjy9d8UumUShixCKIiSKnhIlbFFT5Bmt2+mtrJnIhqG3K4tbdU+UiRVKMZz8Ig2hdB7IOhMg+U9U1l5NyomEnw3mRxLTXgaAggs11AXP/Ta5ODoxzH1A+C38/oqyIXRYaEWSVUem8ouUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917911; c=relaxed/simple;
	bh=RoV+EFnTcrTRHMWJGo1xyTOCQ3ZnjClqQCiB9MZHTFE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMhCZOH1F7xRIkQOEqVS9s19vx+LPcejKl0mVj30sfCVzM5swIHfb3+kypwjQvO4T/ZrGUcYJnheHgbYOlLesxTr2VQwh8zHIgK3YRb+jdG/HtbCj86z8IvDN0+FAowTayAZdOumM6FnloR+7IfazHNXDOmcMFDt7Xm4S7ODQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLdhf635; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLdhf635"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED1E1F00A3E;
	Wed,  9 Sep 2026 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917909;
	bh=YoXSEZhjnbXC9qTpBQBpEEc0Pa+DT0Kb5ktdSRVq7mQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mLdhf635fEl/9I7XygasiRE+Mv9x5rv7S33QIfTw45b+ZdKP8dHjzB9+dYlc6kPW8
	 qP00gp3S/pgk7/zxFagW0BRezpExFZRpMIxamYRGLt6D/F7e1BGZiDAmSuy6UBPJ6S
	 oigJbW/JcKOi2b49PRgCgYYStr2C1K7bYYFaO9NREDHs5A41zM2iGJgWm9yOGoYKoE
	 RhZrCtICJdVu5m9XuZBYD5z+TmQkzHMtZ7ZjIXZYvtkTevAW8fB/tJjHbERlXZKH4t
	 MgGJhy9T0Sqn4K4pYQreIrrUq61pjUEt9zmDLd87p9ZW1wSEhSMTVO9Fn34l+Xvu+q
	 rrDpKVdFhmp+Q==
Subject: Re: [PATCH net-next] net: mana: Use the HWC destination queues
 reported by the hardware
From: netdev-bot+sashiko@kernel.org
To: mawasthi@linux.microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org,
 gargaditya@linux.microsoft.com, ernis@linux.microsoft.com, kees@kernel.org,
 paulros@microsoft.com
Date: Wed, 09 Sep 2026 01:38:27 +0000
Message-ID: <178891790797.219967.6930927720056812233@kernel.org>
In-Reply-To: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
References: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1 (1)

- [High] Removing the `if (gc->is_pf)` gate in `mana_hwc_send_request()`
  (drivers/net/ethernet/microsoft/mana/hw_channel.c:897-898) makes…
- [Medium] Commit message understates a functional change and carries no
  Fixes tag.
- [Low] The patch redefines the meaning of hardware-protocol fields but
  renames nothing, leaving an internally contradictory abstraction: the…

Pre-existing issues:
- [Low] `hwc->pf_dest_vrq_id` and `hwc->pf_dest_vrcq_id` are written from
  the HWC EQ callback `mana_hwc_init_event_handler()`…

--

net: mana: Use the HWC destination queues reported by the hardware

This removes the gc->is_pf gate in mana_hwc_send_request() so that the HWC
destination queue IDs learned from the HWC init events are used
unconditionally.  Previously non-PF functions posted every HWC request with
destination vRQ/vRCQ of 0.

No Link: tags were present in the commit header.

A few questions on the change below.

> net: mana: Use the HWC destination queues reported by the hardware
>
> mana_hwc_send_request() gates the HWC destination queue IDs on
> gc->is_pf, which the PCI probe derives from the device ID.
>
> The gate is not needed. hwc->pf_dest_vrq_id and hwc->pf_dest_vrcq_id
> are only ever assigned from the HWC_INIT_DATA_PF_DEST_RQ_ID and
> HWC_INIT_DATA_PF_DEST_CQ_ID init events, and the hardware always
> reports values that are valid for the function it sends them to.

[Severity: Medium]
Is "The gate is not needed" an accurate description of what changes here?

mana_is_pf() in gdma_main.c returns true only for MANA_PF_DEVICE_ID and
MANA_PF2_DEVICE_ID, so mana_gd_probe() leaves gc->is_pf false for every VF:

	gc->is_pf = mana_is_pf(pdev->device);
	gc->is_pf2 = (pdev->device == MANA_PF2_DEVICE_ID);

That means the removed branch was false exactly on VFs, and on those
functions mana_hwc_send_request() used to post with dest_vrq = dest_vrcq =
0 and now posts hwc->pf_dest_vrq_id / hwc->pf_dest_vrcq_id instead.

The two statements in the message seem to pull in opposite directions:
"The gate is not needed" reads as a no-op cleanup, while "the hardware
always reports values that are valid for the function it sends them to"
only carries meaning if the hardware does report these values to VFs, i.e.
if VF behaviour changes.

Could the changelog say which of the two it is, name the user-visible
symptom being fixed (HWC command timeout, probe failure, something else),
say which host/firmware versions are affected, and which of PF, PF2, VF
and bare-metal hostmode were tested?

Also, both the pf_dest_* fields and the gc->is_pf gate being deleted came
from commit 1566e7d6206f ("net: mana: Add the Linux MANA PF driver").
Should this carry a Fixes: tag naming it?

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 263e7c4e29341..5d75c2478a8a8 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -890,10 +889,13 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	tx_wr->msg_size = req_len;
>  	command = req_msg->req.msg_type;
>  
> -	if (gc->is_pf) {
> -		dest_vrq = hwc->pf_dest_vrq_id;
> -		dest_vrcq = hwc->pf_dest_vrcq_id;
> -	}
> +	/* The hardware reports the HWC destination queues through
> +	 * HWC_INIT_DATA_PF_DEST_RQ_ID and HWC_INIT_DATA_PF_DEST_CQ_ID, and
> +	 * always supplies values that are valid for this function, so no
> +	 * PF-specific handling is needed here.
> +	 */
> +	dest_vrq = hwc->pf_dest_vrq_id;
> +	dest_vrcq = hwc->pf_dest_vrcq_id;

[Severity: High]
Where in the driver is the invariant stated by the new comment actually
established?

The only producers of these two fields are in mana_hwc_init_event_handler():

	case HWC_INIT_DATA_PF_DEST_RQ_ID:
		hwc->pf_dest_vrq_id = val;
		break;

	case HWC_INIT_DATA_PF_DEST_CQ_ID:
		hwc->pf_dest_vrcq_id = val;
		break;

There is no gc->is_pf / gc->is_pf2 test there, no range check against
gc->max_num_cqs, and no check that the reported queues belong to the
receiving function.  Compare mana_hwc_establish_channel(), which does at
least sanity-check the HWC CQ id it got from the same handler:

	/* Both were set in mana_hwc_init_event_handler(). */
	if (WARN_ON(cq->id >= gc->max_num_cqs))
		return -EPROTO;

So if a non-PF function ever receives those init events with non-zero
values, is every HWC request now addressed to a queue that function may not
own?

The values go straight into the hardware OOB in mana_hwc_post_tx_wqe():

	tx_oob->vrq_id = dest_virt_rq_id;
	tx_oob->dest_vfid = 0;
	tx_oob->vrcq_id = dest_virt_rcq_id;
	...
	tx_oob->dest_pf = dest_pf;

and this call site still passes dest_pf = false while dest_vfid is
hardcoded to 0, which does not look like a descriptor addressed at a PF
destination.

If a request is misdirected, does the channel recover?  In
mana_hwc_send_request() the completion never arrives, the
wait_for_completion_timeout(&ctx->comp_event, ...) expires with -ETIMEDOUT,
and the same path then does:

		/* Reduce further waiting if HWC no response */
		if (hwc->hwc_timeout > 1)
			hwc->hwc_timeout = 1;

after which every later command fails fast.  Since the first users of this
path run during mana_hwc_create_channel() and mana_hwc_test_channel() at
bring-up, would that show up as a probe failure and loss of the interface?

The ABI names (HWC_INIT_DATA_PF_DEST_RQ_ID, HWC_INIT_DATA_PF_DEST_CQ_ID,
pf_dest_vrq_id, pf_dest_vrcq_id) and the fact that the gate and the fields
were added together for the bare-metal PF path all read as evidence
against the premise.  Would it be safer to keep the function-type gate, or
to move the gate/validation into mana_hwc_init_event_handler() and document
the firmware contract there?

[Severity: Low]
This isn't a bug, but the patch redefines the meaning of these fields
without renaming anything.  The declarations stay as:

	u32 pf_dest_vrq_id;
	u32 pf_dest_vrcq_id;

the init-data constants stay as HWC_INIT_DATA_PF_DEST_RQ_ID and
HWC_INIT_DATA_PF_DEST_CQ_ID, mana_hwc_post_tx_wqe() is still called with
dest_pf = false, and the only record of the new semantics is free text at
this one call site.

A later reader seeing pf_dest_vrq_id consumed unconditionally right next to
dest_pf = false cannot tell whether that is deliberate.  If the premise
holds, could the fields and constants be renamed (dest_vrq_id,
HWC_INIT_DATA_DEST_RQ_ID) so the invariant lives at the definition?

[Severity: Low]
This is a pre-existing issue rather than something introduced here, but
the patch widens it from PF-only to all function types, so it seems worth
mentioning.

These two fields are written from the HWC EQ callback
mana_hwc_init_event_handler() and read here in process context with no
lock, no READ_ONCE(), and as two separate plain loads, even though
mana_hwc_post_tx_wqe() consumes them as a pair.

The initial publication is ordered correctly: the stores precede
GDMA_EQE_HWC_INIT_DONE -> complete(&hwc->hwc_init_eqe_comp), and
mana_hwc_establish_channel() waits on that completion before anything is
posted:

	if (!wait_for_completion_timeout(&hwc->hwc_init_eqe_comp, 60 * HZ))
		return -ETIMEDOUT;

The EQ callback stays registered for the life of the channel though, and
the GDMA_EQE_HWC_INIT_DATA switch has no guard against a further init-data
event while requests are in flight.  If one lands between these two reads,
can the WQE end up carrying a vrq_id from one generation and a vrcq_id
from another, so the completion is steered at a queue the driver is not
waiting on and the caller blocks for the full hwc_timeout?

I have no evidence any firmware re-delivers that event, and the same
handler would also rewrite hwc->cq->gdma_cq->id, the rxq/txq gdma_wq ids
and gpa_mkey unsynchronized, so this is a property of the whole init-data
handler rather than of the two fields touched here.

>  
>  	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
>  	if (err) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903184104.3194819-1-mawasthi%40linux.microsoft.com
