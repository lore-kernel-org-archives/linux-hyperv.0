Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B62652A2
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101870; cv=none; b=sMGiMgAXJrN/CQMyMYP20qpaHJymJfF8fSL4+MKZItUWjCGBf6bskppVed80WKZmqDD7ADfMNPpjUrl8u0UVo+38YKoAaWWxFMk9VJy8NiHsN6Lml57pa78VUc5E0g7FLHKcd0YaS0KbaM6IOlltXTJZFmEgBEH7F6Sb8yLdcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101870; c=relaxed/simple;
	bh=K1O2ppjBayizjgxsI743ob7fQnUyoh2PnvWlMWPVl6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDI41EX5zPpStVEpWtZkCI0sUXeHrF0ukHD1VQnXBU7RxVXwWnlxV6MIi0AsMheJDdU8QTB7j3hP5FyrGw/MWpm4eiFIElRCwkZrfcrBcSDx+jL3N6vShDCbFecJ3w8L+lSxlpIU3eLAD0JmInj5rFc9CLrF+3x1jE6JfT+pyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2x7HiMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2x7HiMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ECB1F00893;
	Sat, 30 May 2026 00:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101868;
	bh=1uC2JHvW+u1lafIUY9BIx0S0Prvwb7A//0yawjVDYXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2x7HiMuz6tYauN9pwi8v/5aY917QkMLi4bTewsQcqOcFQtXobWIOE+45yx+CjDiZ
	 56vuGztPGB7Pa54Tp3tCi+lomNziDX2An9WsVrSqCHzPnAWkJ2Q5B8aeAKVlM/FyGC
	 oqBSYKyH7KeZ3aQH7/4DOo4eXk2QPOZaZ907r2+9b9tT0t0yiaXZw3laNhNOnilWLY
	 K2m1YCE9fZd4DAp3/rIom+zRxa5TT6+uxIBYgGM8m5q9uApcOCLxWGWcEVFfD2MLNe
	 DdT1cURITclLV/1785QCcStjhF7M3/0s0duARZ3ykq2l06pfC1bnpIUQ1IiYnivKO6
	 TVAl3zosx44fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: validate rx_req_idx to prevent
 out-of-bounds array access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260520051553.857120-1-gargaditya@linux.microsoft.com>
References: <20260520051553.857120-1-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:28 +0000
Message-Id: <20260530004428.A0ECB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing `READ_ONCE()` for `sge->address` risks Time-of-Check to Ti=
me-of-Use (TOCTOU) bypass of the newly added bounds check.

Pre-existing issues:
- [High] Missing bounds check on `dma_oob->inline_oob_size_div4` allows an =
out-of-bounds memory read past the DMA WQE ring buffer.
- [High] Returning early without reposting the RX WQE buffer leads to RX qu=
eue starvation.
--

commit 4f8436d78a8ca78fb96f7252f756af92fc42ccaa
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: validate rx_req_idx to prevent out-of-bounds array access

This commit adds a bounds check on rx_req_idx in mana_hwc_rx_event_handler()
to prevent an out-of-bounds access into the reqs[] array. The index is
derived from unencrypted DMA-coherent memory which can be modified by the
hardware at any time in Confidential VMs.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -258,11 +258,17 @@ static void mana_hwc_rx_event_handler(void *ctx, u3=
2 gdma_rxq_id,
>  	wqe =3D mana_gd_get_wqe_ptr(rq, rx_oob->wqe_offset / GDMA_WQE_BU_SIZE);
>  	dma_oob =3D (struct gdma_wqe *)wqe;
> =20
>  	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4=
);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing bounds
check on dma_oob->inline_oob_size_div4?

Since dma_oob->inline_oob_size_div4 is read directly from unencrypted, shar=
ed
DMA memory, a potentially malicious host could manipulate it. It is a 3-bit
field, so an attacker could set it to 7.

Could this cause the sge pointer calculation to point 36 bytes into the
32-byte WQE buffer, resulting in an out-of-bounds read of up to 12 bytes
when reading sge->address?

If the WQE is at the end of the page-aligned queue memory buffer, could this
read past the allocated DMA region and trigger a fatal page fault?

> =20
>  	/* Select the RX work request for virtual address and for reposting. */
>  	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
>  	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_req_msg_size;

[Severity: High]
Does sge->address need to be read using READ_ONCE()?

Since sge->address resides in unencrypted, shared DMA memory, the compiler
might fetch its value multiple times. If the division by hwc->max_req_msg_s=
ize
is optimized into a bitwise shift, the compiler might re-read sge->address
from DMA memory after the bounds check has passed when indexing the array.

Could a malicious host concurrently modify the memory to bypass the new bou=
nds
check completely?

> =20
> +	if (rx_req_idx >=3D hwc_rxq->msg_buf->num_reqs) {
> +		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=3D%llu, num_reqs=3D%u\n",
> +			rx_req_idx, hwc_rxq->msg_buf->num_reqs);
> +		return;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does returning early here (and further
below for invalid msg_id) drop the request without reposting the RX WQE
buffer?

If a malicious host repeatedly sends valid CQEs with an invalid msg_id or
an out-of-bounds rx_req_idx, it seems the function drops the response witho=
ut
replenishing the queue via mana_hwc_post_rx_wqe().

Could this permanently leak the RX WQE buffers and starve the queue, causing
a denial of service for the hardware channel?

>  	rx_req =3D &hwc_rxq->msg_buf->reqs[rx_req_idx];
>  	resp =3D (struct gdma_resp_hdr *)rx_req->buf_va;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520051553.8571=
20-1-gargaditya@linux.microsoft.com?part=3D1
