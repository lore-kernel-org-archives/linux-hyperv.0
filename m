Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABB2046BA;
	Thu, 10 Sep 2026 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000930; cv=none; b=kqYC9VrAXImjmDVmG82OszMryfHv0/C8K1tJVbvhXj8IIYqtPMbQUe0o/uTfML2rgXFDx3Sk5pF/mv6PDjzZyJCzEzVRTeW6Ichy/LBZqoVeWHQQh8K1QISbBl7e+pAXXz30k4lqQ0Z7PB+5GLnEypaQOavAkbT3m3wTQ9brBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000930; c=relaxed/simple;
	bh=Tv3xnnU0OU9v1IGje/TXpjVSfPtn1JyLtxhbK5Ipn68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACM4yFEczjkMRZhdsUVE6kwflzWmQ41rOG2sn4xNyQYQX1spE1Fiymx4iogaMpH2gYqmcpukL6kRoy6Wogj//pwIIa0gy21A/mKugimRvbfdyUCkpn/OUUa//GrU4dANZlZ7joEXng4cj/wh8DcndPfcG69VkVQHtZBKQ4jpiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jviwGPXQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jviwGPXQ"
Received: from CPC-mawas-YGKSX.localdomain (unknown [70.37.26.41])
	by linux.microsoft.com (Postfix) with ESMTPSA id A2B8620B7169;
	Wed,  9 Sep 2026 17:41:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2B8620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789000887;
	bh=/QNXnw8ssYR5Dw2jI2BS10T0r4EoQJjMi8RUvIi1AbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jviwGPXQxxEAyy8Izojqd+TVvX9byLbLg/gZIkc67+BUNuqwicyLkjz5qXfytRHgn
	 Gjdo1utRQwQB0l05Dq6XufbkLwW5Bwag5nMg7A2CkY4IN9bydIdduMnMD4RikRgofw
	 COxLjLSwYWi3rrMGx4fL27qjnu49jDTildBUr5EE=
From: Manish Awasthi <mawasthi@linux.microsoft.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	decui@microsoft.com,
	edumazet@google.com,
	ernis@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	haiyangz@microsoft.com,
	horms@kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	mawasthi@linux.microsoft.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paulros@microsoft.com,
	wei.liu@kernel.org
Subject: Re: [PATCH net-next] net: mana: Use the HWC destination queues reported by the hardware
Date: Thu, 10 Sep 2026 00:41:59 +0000
Message-ID: <178899533403.20526.14256959266357826913.hwc-sashiko-editable@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <178891790797.219967.6930927720056812233@kernel.org>
References: <20260903184104.3194819-1-mawasthi@linux.microsoft.com> <178891790797.219967.6930927720056812233@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 09 Sep 2026 01:38:27 +0000,
netdev-bot+sashiko@kernel.org wrote:

Thanks for the review.
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 1 (1)
> 
> - [High] Removing the `if (gc->is_pf)` gate in `mana_hwc_send_request()`
>   (drivers/net/ethernet/microsoft/mana/hw_channel.c:897-898) makes…
> - [Medium] Commit message understates a functional change and carries no
>   Fixes tag.
> - [Low] The patch redefines the meaning of hardware-protocol fields but
>   renames nothing, leaving an internally contradictory abstraction: the…
> 
> Pre-existing issues:
> - [Low] `hwc->pf_dest_vrq_id` and `hwc->pf_dest_vrcq_id` are written from
>   the HWC EQ callback `mana_hwc_init_event_handler()`…
> 
> --
> 
> net: mana: Use the HWC destination queues reported by the hardware
> 
> This removes the gc->is_pf gate in mana_hwc_send_request() so that the HWC
> destination queue IDs learned from the HWC init events are used
> unconditionally.  Previously non-PF functions posted every HWC request with
> destination vRQ/vRCQ of 0.
> 
> No Link: tags were present in the commit header.
> 
> A few questions on the change below.
> 
> > net: mana: Use the HWC destination queues reported by the hardware
> >
> > mana_hwc_send_request() gates the HWC destination queue IDs on
> > gc->is_pf, which the PCI probe derives from the device ID.
> >
> > The gate is not needed. hwc->pf_dest_vrq_id and hwc->pf_dest_vrcq_id
> > are only ever assigned from the HWC_INIT_DATA_PF_DEST_RQ_ID and
> > HWC_INIT_DATA_PF_DEST_CQ_ID init events, and the hardware always
> > reports values that are valid for the function it sends them to.
> 
> [Severity: Medium]
> Is "The gate is not needed" an accurate description of what changes here?
> 
I'll change the message to clarify that the check is not needed for any device.
> mana_is_pf() in gdma_main.c returns true only for MANA_PF_DEVICE_ID and
> MANA_PF2_DEVICE_ID, so mana_gd_probe() leaves gc->is_pf false for every VF:
> 
> 	gc->is_pf = mana_is_pf(pdev->device);
> 	gc->is_pf2 = (pdev->device == MANA_PF2_DEVICE_ID);
> 
> That means the removed branch was false exactly on VFs, and on those
> functions mana_hwc_send_request() used to post with dest_vrq = dest_vrcq =
> 0 and now posts hwc->pf_dest_vrq_id / hwc->pf_dest_vrcq_id instead.
> 
The removed branch was false on VF and PF2 before this change. Now the branch
is removed.

> The two statements in the message seem to pull in opposite directions:
> "The gate is not needed" reads as a no-op cleanup, while "the hardware
> always reports values that are valid for the function it sends them to"
> only carries meaning if the hardware does report these values to VFs, i.e.
> if VF behaviour changes.
> 
> Could the changelog say which of the two it is, name the user-visible
> symptom being fixed (HWC command timeout, probe failure, something else),
> say which host/firmware versions are affected, and which of PF, PF2, VF
> and bare-metal hostmode were tested?
The change applies to all supported device types. I will update the changelog.
> 
> Also, both the pf_dest_* fields and the gc->is_pf gate being deleted came
> from commit 1566e7d6206f ("net: mana: Add the Linux MANA PF driver").
> Should this carry a Fixes: tag naming it?
> 
This patch doesn't fix a bug or an issue introduced by commit 1566e7d6206f, so I don't think a Fixes tag is appropriate.
> > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > index 263e7c4e29341..5d75c2478a8a8 100644
> > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> 
> [ ... ]
> 
> > @@ -890,10 +889,13 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> >  	tx_wr->msg_size = req_len;
> >  	command = req_msg->req.msg_type;
> >  
> > -	if (gc->is_pf) {
> > -		dest_vrq = hwc->pf_dest_vrq_id;
> > -		dest_vrcq = hwc->pf_dest_vrcq_id;
> > -	}
> > +	/* The hardware reports the HWC destination queues through
> > +	 * HWC_INIT_DATA_PF_DEST_RQ_ID and HWC_INIT_DATA_PF_DEST_CQ_ID, and
> > +	 * always supplies values that are valid for this function, so no
> > +	 * PF-specific handling is needed here.
> > +	 */
> > +	dest_vrq = hwc->pf_dest_vrq_id;
> > +	dest_vrcq = hwc->pf_dest_vrcq_id;
> 
> [Severity: High]
> Where in the driver is the invariant stated by the new comment actually
> established?
I'll rename the HWC_INIT_DATA_PF_DEST_RQ_ID and HWC_INIT_DATA_PF_DEST_CQ_ID to
HWC_INIT_DATA_DEST_CQ_ID and HWC_INIT_DATA_DEST_CQ_ID. The invariant is established during 
the HWC handshake regardless of whether its PF, PF2, VF or bare-metal.
> 
> The only producers of these two fields are in mana_hwc_init_event_handler():
> 
> 	case HWC_INIT_DATA_PF_DEST_RQ_ID:
> 		hwc->pf_dest_vrq_id = val;
> 		break;
> 
> 	case HWC_INIT_DATA_PF_DEST_CQ_ID:
> 		hwc->pf_dest_vrcq_id = val;
> 		break;
> 
> There is no gc->is_pf / gc->is_pf2 test there, no range check against
> gc->max_num_cqs, and no check that the reported queues belong to the
> receiving function.  Compare mana_hwc_establish_channel(), which does at
> least sanity-check the HWC CQ id it got from the same handler:
> 
> 	/* Both were set in mana_hwc_init_event_handler(). */
> 	if (WARN_ON(cq->id >= gc->max_num_cqs))
> 		return -EPROTO;
> 
> So if a non-PF function ever receives those init events with non-zero
> values, is every HWC request now addressed to a queue that function may not
> own?
Hardware sends the values for these fields as appropriate for the function it is sending them to.
A non zero value is not invalid.
> 
> The values go straight into the hardware OOB in mana_hwc_post_tx_wqe():
> 
> 	tx_oob->vrq_id = dest_virt_rq_id;
> 	tx_oob->dest_vfid = 0;
> 	tx_oob->vrcq_id = dest_virt_rcq_id;
> 	...
> 	tx_oob->dest_pf = dest_pf;
> 
> and this call site still passes dest_pf = false while dest_vfid is
> hardcoded to 0, which does not look like a descriptor addressed at a PF
> destination.
> 
> If a request is misdirected, does the channel recover?  In

This is an existing behavior and this patch doesn't change it. The recovery is already
implemented in the driver.

> mana_hwc_send_request() the completion never arrives, the
> wait_for_completion_timeout(&ctx->comp_event, ...) expires with -ETIMEDOUT,
> and the same path then does:
> 
> 		/* Reduce further waiting if HWC no response */
> 		if (hwc->hwc_timeout > 1)
> 			hwc->hwc_timeout = 1;
> 
> after which every later command fails fast.  Since the first users of this
> path run during mana_hwc_create_channel() and mana_hwc_test_channel() at
> bring-up, would that show up as a probe failure and loss of the interface?

There is recovery implemented in the driver on probe failure.
> 
> The ABI names (HWC_INIT_DATA_PF_DEST_RQ_ID, HWC_INIT_DATA_PF_DEST_CQ_ID,
> pf_dest_vrq_id, pf_dest_vrcq_id) and the fact that the gate and the fields
> were added together for the bare-metal PF path all read as evidence
> against the premise.  Would it be safer to keep the function-type gate, or
> to move the gate/validation into mana_hwc_init_event_handler() and document
> the firmware contract there?

I will send v2 with fields renamed.
> 
> [Severity: Low]
> This isn't a bug, but the patch redefines the meaning of these fields
> without renaming anything.  The declarations stay as:
> 
> 	u32 pf_dest_vrq_id;
> 	u32 pf_dest_vrcq_id;
> 
> the init-data constants stay as HWC_INIT_DATA_PF_DEST_RQ_ID and
> HWC_INIT_DATA_PF_DEST_CQ_ID, mana_hwc_post_tx_wqe() is still called with
> dest_pf = false, and the only record of the new semantics is free text at
> this one call site.
> 
> A later reader seeing pf_dest_vrq_id consumed unconditionally right next to
> dest_pf = false cannot tell whether that is deliberate.  If the premise
> holds, could the fields and constants be renamed (dest_vrq_id,
> HWC_INIT_DATA_DEST_RQ_ID) so the invariant lives at the definition?

Yes, I will send v2 with the fields and constants renamed.

> 
> [Severity: Low]
> This is a pre-existing issue rather than something introduced here, but
> the patch widens it from PF-only to all function types, so it seems worth
> mentioning.
> 
> These two fields are written from the HWC EQ callback
> mana_hwc_init_event_handler() and read here in process context with no
> lock, no READ_ONCE(), and as two separate plain loads, even though
> mana_hwc_post_tx_wqe() consumes them as a pair.
> 
> The initial publication is ordered correctly: the stores precede
> GDMA_EQE_HWC_INIT_DONE -> complete(&hwc->hwc_init_eqe_comp), and
> mana_hwc_establish_channel() waits on that completion before anything is
> posted:
> 
> 	if (!wait_for_completion_timeout(&hwc->hwc_init_eqe_comp, 60 * HZ))
> 		return -ETIMEDOUT;
> 
> The EQ callback stays registered for the life of the channel though, and
> the GDMA_EQE_HWC_INIT_DATA switch has no guard against a further init-data
> event while requests are in flight.  If one lands between these two reads,
> can the WQE end up carrying a vrq_id from one generation and a vrcq_id
> from another, so the completion is steered at a queue the driver is not
> waiting on and the caller blocks for the full hwc_timeout?
> 
> I have no evidence any firmware re-delivers that event, and the same
> handler would also rewrite hwc->cq->gdma_cq->id, the rxq/txq gdma_wq ids
> and gpa_mkey unsynchronized, so this is a property of the whole init-data
> handler rather than of the two fields touched here.
> 
> >  
> >  	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
> >  	if (err) {
> 
Thanks for reporting the issue, since it it pre-existing, we'll review and address it in a separate patch.
Manish
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903184104.3194819-1-mawasthi%40linux.microsoft.com
> 
