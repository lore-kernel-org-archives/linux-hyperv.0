Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E41531E8
	for <linux-hyperv@vger.kernel.org>; Sun,  9 Aug 2026 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242902; cv=none; b=UJ51RwyCs1RgUEmk6ZXBqdi65Vm0CiR4nufFe9U2h6P0bJHEohWMmK3LbXDQlUK4IWzEMK0gmUnhRG5Apj8l2BvocJLe2NxuOZH+kR6xwcNNYEhfkKVNb0N+BxJz3hW9sczhvu99g8SGWghmuhsilqFWYskctQXYAAkVF/xTDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242902; c=relaxed/simple;
	bh=09ioEel8FNxTYYvo9ujK/DxyDVZJQvR16PwKLKMLAhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Thd4icYZa1Ltnj72cwCqaWkBjWIqKnLDl8oCu+kVu7xKxfH9o1u5ikJIKwtm9CPfDoDjb0f5KcWHelCd7uML3PPpP+M4B0sVxzU9AMwTlGXskxtFN8vYlUCGWzfsFV1JQIObPusMX+WvNDSbULE8EWugmH3RDAVrbggVFY7Ydzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtZMgW+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtZMgW+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E141F00A3A;
	Sun,  9 Aug 2026 02:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242901;
	bh=mpZkg/uyI2PqjIMZnheBkKrEmkKyMIxAfUM3K/Gj6Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YtZMgW+MqX9cRl/8DrkP6VVENke33VTilfSFjbMRgoZaPCMtBzDGidbmJbfX3+s/8
	 O3IOlVAvRluwXNnJXOuCLacss4Jr1/PpBW77kKlyzDCop4sfLrgBAhbCXREi40aNyO
	 SWrtKk4tV7GzCXWKiaSZIW3ce0QPnshmSP3mg+zNb6gEzyy0AxBoWpy/L/HLjpfmmP
	 AelfDL/f9Z5K8iCQoJd5etmykpQVnMjIw3cO2UUBCDJJ/kXN2k/y8iA5vpyAHvUw5V
	 sSVO+9tzg6lg+ePM25S54AtZTB4jlPt0w4/Jh9XgJE94rmaoFc5KV2vggQIvWzsbkE
	 KtM5Nr92kC+2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/7] net: mana: fix HWC RQ/SQ buffer size swap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260808023417.1746886-3-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260808023417.1746886-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 02:35:00 +0000
Message-Id: <20260809023501.50E141F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated hardware/hypervisor input `inline_oob_size_div4` cause=
s an out-of-bounds read of the DMA ring buffer, potentially leading to a gu=
est kernel panic.
--

--- Patch [2]: [PATCH net v4 2/7] net: mana: fix HWC RQ/SQ buffer size swap=
 ---
commit a84c17edbd298a723626b1c82f2d180dc7a76163
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC RQ/SQ buffer size swap

This commit fixes a latent bug where the HWC RQ and SQ buffer sizes were
swapped during queue initialization. It corrects the RQ to use the max
response message size, the SQ to use the max request message size, and
updates the RX slot index computation to use the correct stride.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 409e20caeccdc..3f011ebbe7b3e 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -263,7 +263,7 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 =
gdma_rxq_id,
> =20
>  	/* Select the RX work request for virtual address and for reposting. */
>  	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
> -	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_req_msg_size;
> +	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_resp_msg_size;

[Severity: High]
This is a pre-existing issue, but could an untrusted hypervisor or hardware
trigger an out-of-bounds read here when dereferencing sge->address?

In mana_hwc_rx_event_handler(), the driver computes the sge pointer using
dma_oob->inline_oob_size_div4, which is read from shared DMA memory. Because
this input is unvalidated, a malicious hypervisor in a Confidential VM
environment could potentially modify it.

If inline_oob_size_div4 is maliciously set to a large value like 7, the sge
calculation (wqe + 8 + dma_oob->inline_oob_size_div4 * 4) might yield a
pointer past the end of the DMA allocation boundary. The access to
sge->address on this line would then read out of bounds, potentially causing
a guest kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D2
