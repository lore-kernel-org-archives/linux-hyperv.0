Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E174B0486
	for <linux-hyperv@vger.kernel.org>; Sun,  9 Aug 2026 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242900; cv=none; b=gOdMRtmLuzcL9+xTtgPMCCWObROeyPdgR8Byy5UUpYKe2y64lFIjQ3bHYO1X7AV99ibgNxo0NnE0tv2QMgPhMndeW6mlqySJDvE1BL4jxLkjasCT72G8B0Eqt3kduSG6p1MIznYc+sybSYwhQnt0sKAXepHYeaJRt3sQA5qQxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242900; c=relaxed/simple;
	bh=65hOq/UD/6WzvEha/ePjQd4oPvTCPQf6A3BnBm0BKYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HvFRb0xBKzhhVuScuk6uTF6z1VtVRKfbIhcrJe8BEIV82nPuW6XVkx0AJeQ+EzuZNPqWwI3KadGPteuA0cTlcoSz8F0CVE7oLoK/6Z2zlGpic1Z93q5UfiHEHcohnpK7OqKFLdcF0LZ/w9AwZIFdDJDfSTJXVbo+azs4s4sGx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPzl9wg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPzl9wg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6D61F000E9;
	Sun,  9 Aug 2026 02:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242898;
	bh=ypDYnAWmPOOxGCwMiFf57Zkwe/MfqMmlJ+iiuQd53kA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPzl9wg8kjpXEwjOFjl2NfntBU36dcdH3mEtTA5stxS8p7/SdsId3rjZ3LkjO7vO1
	 lM1g02/s3wsUd2urmsf09bgHCYN2B+4nGFeqBPt5Qn0neuuaI4zgs8zcnTZVtmwYrt
	 vgNICF6P7JfEh7lj/auRByfZzIa52RBizxL+i/rC5+yncfy+/f0UxwVjnjgRhw7HYF
	 uRDk0RZdE4Rq9kF6iClYyv7MvZyvO16zjhlzBbVuWcbFBmXxt8Tazm/39S3bbp7KoQ
	 +F2w3MMi7eXDIRwkzZMQGUaIRpyH+VPgPBC0e6bwBtHlbh09s2ibFyMu6kYAYZymX4
	 4+o2IkIM/t+mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 4/7] net: mana: validate hardware-supplied values
 in the HWC RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260808023417.1746886-5-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260808023417.1746886-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 02:34:57 +0000
Message-Id: <20260809023458.0B6D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition leading to stack memory corruption and Use-Afte=
r-Free (ABA) on hardware command timeout.
--

--- Patch [4]: [PATCH net v4 4/7] net: mana: validate hardware-supplied val=
ues in the HWC RX path ---
commit 3dd532e8ebcefe4a1f19044be675c58a1504e9c6
Author: Long Li <longli@microsoft.com>

net: mana: validate hardware-supplied values in the HWC RX path

This commit adds validation for hardware-supplied lengths and indices in the
MANA hardware channel RX handler. It ensures the inline OOB size, SGE addre=
sses,
and response lengths are checked before use. Out-of-bounds or untrusted RX =
WQEs
are leaked and, if exhausted, the channel goes into a terminal state.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 19896bb5ce1a4..5db8cfe2d8443 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -83,6 +83,19 @@ static void mana_hwc_handle_resp(struct hw_channel_con=
text *hwc, u32 resp_len,
>  	struct hwc_caller_ctx *ctx;
>  	int err;
> =20
> +	/* Defence in depth: the sole caller, mana_hwc_rx_event_handler(),
> +	 * already rejects msg_id >=3D hwc->num_inflight_msg with the value it
> +	 * passes here by value, so this cannot be reached out of range.  Keep
> +	 * the guard at the indexing site so the bitmap and caller_ctx array
> +	 * are never indexed without a bound in view.
> +	 */
> +	if (msg_id >=3D hwc->num_inflight_msg) {
> +		dev_err(hwc->dev, "hwc_rx: msg_id %u >=3D max %u\n",
> +			msg_id, hwc->num_inflight_msg);
> +		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
> +		return;
> +	}
> +
>  	if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
>  		dev_err(hwc->dev, "hwc_rx: invalid msg_id =3D %u\n", msg_id);
>  		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);

[Severity: Critical]
This is a pre-existing issue, but is there a race condition between this
test_bit() check and the command timeout path that could corrupt stack memo=
ry?

If a thread calling mana_hwc_send_request() times out, it takes this path:

	if (!wait_for_completion_timeout(&ctx->comp_event,
					 (hwc->hwc_timeout * HZ) / 1000)) {
		dev_err(hwc->dev, "HWC: Request timed out!\n");
		err =3D -ETIMEDOUT;
		goto out;
	}
    ...
    out:
	mana_hwc_put_msg_index(hwc, msg_id);
	return err;

The timeout path clears the message ID bit and returns without synchronizing
with the interrupt handler.

Concurrently, if a delayed hardware response arrives here in
mana_hwc_handle_resp(), it could pass the test_bit() check right before the
timeout path clears it.

The timeout thread then clears the bit and returns, popping its stack.
Then mana_hwc_handle_resp() proceeds and executes:

	if (!err && ctx->output_buf) {
		ctx->status_code =3D resp_msg->status;
		memcpy(ctx->output_buf, resp_msg, resp_len);

Since ctx->output_buf points to the now-freed stack frame, could this memcp=
y()
write hardware data into a freed stack frame or to the stack frame of a new
thread reusing the message ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D4
