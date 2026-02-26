Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E053C197A
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116132; cv=none; b=UfdKW746hrFMa3zDOEv/v1q+0ZQ6Jpv9RwbKp/KDfwyTi1hOu9k7UcXmqc5suaZXDN96ad1/R+N2uOun4e0hArw6rjQVLPrg/296SL45HzgQBqesY0VY+PI7fnY1QkD0qkqTqWyc93ym3wTQhDYDKX/zCU6rVlg4EVJD8eeFwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116132; c=relaxed/simple;
	bh=7rpVZ+fxTUQLAz/MsXS+ABz6b8FDyA1NowiHxW15/zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxUvzNT72iaTNeGvdMAHVRK/caZo9FfjUi5DhXA4sS1TXubyB+UY1sr+RsOhfq4tHCwHhVsErtDYDiTdQUiema4lK+jeCLr96w1nA/MFzNtTv1Ihr3jKtLN5sOGXNEebFnjeEF03VGt3wkH4sfyHxgaVvx/NzhVvGNmXA61ibSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kcinII8x; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kcinII8x"
Message-ID: <46896339-b3a3-4109-a2e2-324446be5aeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772116126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQnoxdPqvcrup1Ns5bia3RQkVtFv3JRAv6rhmjfIRe8=;
	b=kcinII8xvQi7dPe8qWMA8eJ00twW2kq2qUuuzP5isI8+GdlUewOyrXS/yYsgPHegxfwFe6
	HkLZ4ODOTRfHBnyjLMAG8nSjEAHrl2Smjoj/C2aAm2lr5siJtku1vYQqi8YoG4ildrVywS
	ZgsODQbTI1YUgV5/dIkmUR+U5pi8Yhw=
Date: Thu, 26 Feb 2026 14:28:14 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: mana: Ring doorbell at 4 CQ wraparounds
To: Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260225184948.941599-1-longli@microsoft.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260225184948.941599-1-longli@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/02/2026 18:49, Long Li wrote:
> MANA hardware requires at least one doorbell ring every 8 wraparounds
> of the CQ. The driver rings the doorbell as a form of flow control to
> inform hardware that CQEs have been consumed.
> 
> The NAPI poll functions mana_poll_tx_cq() and mana_poll_rx_cq() can
> poll up to CQE_POLLING_BUFFER (512) completions per call. If the CQ
> has fewer than 512 entries, a single poll call can process more than
> 4 wraparounds without ringing the doorbell. The doorbell threshold
> check also uses ">" instead of ">=", delaying the ring by one extra
> CQE beyond 4 wraparounds. Combined, these issues can cause the driver
> to exceed the 8-wraparound hardware limit, leading to missed
> completions and stalled queues.
> 
> Fix this by capping the number of CQEs polled per call to 4 wraparounds
> of the CQ in both TX and RX paths. Also change the doorbell threshold
> from ">" to ">=" so the doorbell is rung as soon as 4 wraparounds are
> reached.
> 
> Cc: stable@vger.kernel.org
> Fixes: 58a63729c957 ("net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 23 +++++++++++++++----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9919183ad39e..fe667e0d930d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1770,8 +1770,14 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>   	ndev = txq->ndev;
>   	apc = netdev_priv(ndev);
>   
> +	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
> +	 * doorbell can be rung in time for the hardware's requirement
> +	 * of at least one doorbell ring every 8 wraparounds.
> +	 */
>   	comp_read = mana_gd_poll_cq(cq->gdma_cq, completions,
> -				    CQE_POLLING_BUFFER);
> +				    min_t(u32, (cq->gdma_cq->queue_size /

no need for min_t, simple min() can be used, queue_size is already u32

> +					   COMP_ENTRY_SIZE) * 4,
> +					  CQE_POLLING_BUFFER));
>   
>   	if (comp_read < 1)
>   		return;
> @@ -2156,7 +2162,14 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
>   	struct mana_rxq *rxq = cq->rxq;
>   	int comp_read, i;
>   
> -	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp, CQE_POLLING_BUFFER);
> +	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
> +	 * doorbell can be rung in time for the hardware's requirement
> +	 * of at least one doorbell ring every 8 wraparounds.
> +	 */
> +	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp,
> +				    min_t(u32, (cq->gdma_cq->queue_size /

same here

> +					   COMP_ENTRY_SIZE) * 4,
> +					  CQE_POLLING_BUFFER));
>   	WARN_ON_ONCE(comp_read > CQE_POLLING_BUFFER);
>   
>   	rxq->xdp_flush = false;
