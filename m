Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7E409114
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426892; cv=none; b=UISV6VRKF1BY/8nqmfb71ODXE7oZPl2ho14Fx8wEFsZMLYJRSuwJzSkiDSTmRvNU8ZuC9O6wZmtR6Jo17kyaEjP9t148i/RR+I9X3PmuaENygbHaC4mSsLTuLwquWAZIp9QrzFM6x2xlgt1paulZglDGQdQsihgwSBzRU+OuV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426892; c=relaxed/simple;
	bh=6RUJbJCJmcOgmBVoIfacETmzluT4jCS47ZikeWc4G18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF89F37PRPstds1E/W7yrl+TaEqFOVFAU1OwG3ru4wfATluK0nJvQ6SvXxk3iRFEo9uGDB0h7p3QNNTiaisHD/EV6L7bU95ojJ3Ry7cLp3Ql+EuLgEgr74A0R3LdiN94SMmeRTTsD5J3k+UDL3rHkx1f5ATNadUW5W7QhBpGkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=S1qxlM8b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="S1qxlM8b"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e58034d05so21429a91.2
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785426890; x=1786031690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ffWa1sUD0fV7EQhpv7D4SRQ+QnX1CHB/1+CmFyAsMhI=;
        b=S1qxlM8badubcVu+2zpnNR9vP5APe33QEemGuVqcmIIVsTyOWeXQNIrkFVGB1OUPgw
         8AwGXhCPXL1jxOY7i5dwV77y7TJMWn9XBuHUMPpSg/oHMqJCaBc5tPSbAbBR1fKoTc9p
         nAqIn+NL5WfZ1rUxYRn0WtLR4j2m+jgQrTYsSUL04xxxihMe5PWSjvWnSpfoovhtfxpx
         9bw/mL2y6DsR33MiffSsQtcywRCdlu7LpbuC0hQ739TFTpg/LespTWQiLtrJugHSlHqY
         T/ogjw72GZvhT3rKpRet8SQp4zgh5ZC1eYkH3Y70S0ruCTy8/qysIDYRNxp7MGRvLQfd
         17PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785426890; x=1786031690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ffWa1sUD0fV7EQhpv7D4SRQ+QnX1CHB/1+CmFyAsMhI=;
        b=iDGCwFbvr1SEpMKkCiDSXa3UZZPOMyOdrZngau2AhLjyQiEUvIfwMOXMJ8a2qBBk1n
         SJZyRuWn1n/fl80hqECRqhdAdCjcR4p/lj3KpB6C5KHQJwkDcvD75xxI4GdfogqD+nbm
         OwpDeeCBFlMn+uKs4+kGSQj+JEigfbVHXfMBNSOzwItIK8/PejpCw26XdlwRSpZHjU37
         NxtevbhvW7t5Xe+hOWjxHuz+Kx02VCwKIWW/eOPayCEPTySnmUX0P4Qh9KhRck590sle
         REbYH+lN7d9rHNB58y3ZmJElfV4josjXxCba6C1Y7gcAtcKsifcd7XGvHGi9YtM9Di2N
         Yg9A==
X-Gm-Message-State: AOJu0YynzY9XddJMofcdvsgL2BG0Hkht/q9OcYrf9uN2zaZV3WTzrbhO
	fo2QEB9wunnTssuYp04GOzaZ3uMuZx3cNwHPmG3N8cKTO40X1iGJ6Ilcm2cVTvsA9ABffywKWUB
	JoncEpcRqqqRM
X-Gm-Gg: AR+sD10VKB5LN8LsaArhoYCUVxTIo6+GbbqkYkBGhPUyWIKIN9tRM/XeIvsrTbcvgCv
	jmFpZ+35+5OiJCIhQdwAklc6veZUDb7+7N2y9LcQ9DKItvy1Id+Fge1eB9ol+fqR/9J1cjr9p5o
	TQP4yh0E6HviDgTGubyxN2M1QWdLyQO4uBK1WGU8wF7yaQ2pFx6fdJLuYctj8igmt/3RQhuWeRu
	8OtBikCGaqiLuySHBb6m04l8eWpvwQbBcT3QX8MSv5xz4RvS/7xPsuiotBpBarKPrAxj9Y28Een
	BgGfKI6rJc8aGEwXrFRl/dHp1a5vxrk5gqc/HCGeond9b1+sdY/DDLIgdukntklFQjfcmJPIpNq
	f4v1OMoeZX8ah0SrtzyTVERPPmhton2VWdJ9flW+cp1cVIfKi5izZglPyYvTxjGxhNYQ0zpBXvz
	L73yJXogYYq1zuRok+HucR3SbMX/VuLqbXng53SCiKDA==
X-Received: by 2002:a17:90b:3b86:b0:381:bc4c:da56 with SMTP id 98e67ed59e1d1-38f9bde74d1mr2714794a91.19.1785426889854;
        Thu, 30 Jul 2026 08:54:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b99bda7sm1282895a91.12.2026.07.30.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:54:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 08:54:48 -0700
From: Joe Damato <joe@dama.to>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Extend RX CQE coalescing up to 8
 packets
Message-ID: <amtzyNmcIIYy6/bK@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Haiyang Zhang <haiyangz@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, paulros@microsoft.com
References: <20260729225235.3573786-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729225235.3573786-1-haiyangz@linux.microsoft.com>

On Wed, Jul 29, 2026 at 03:52:22PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> To support up to 8 packets per CQE, put two packet lengths and
> hash values into one PPI entry by using the reserved fields.
> Update ethtool handlers to set this feature.
> Update per queue stat to show the coalesced CQE counters.
> This feature is supported on NIC hardware showing the relevant
> PF flag.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 137 ++++++++++++------
>  .../ethernet/microsoft/mana/mana_ethtool.c    |  30 +++-
>  include/net/mana/gdma.h                       |   4 +
>  include/net/mana/mana.h                       |  43 ++++--
>  4 files changed, 150 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a8c329bdbacf..720d22e6aea9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1241,6 +1241,9 @@ int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,

[...]

>  
> +static void mana_process_one_rx_pkt(struct device *dev, struct mana_rxq *rxq,
> +				    struct mana_rxcomp_oob *oob,
> +				    u32 pktlen, u32 pkt_hash)
> +{
> +	struct mana_recv_buf_oob *rxbuf_oob;
> +	struct net_device *ndev = rxq->ndev;
> +	void *old_buf = NULL;
> +	bool old_fp;
> +
> +	rxbuf_oob = &rxq->rx_oobs[rxq->buf_index];
> +	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
> +
> +	if (unlikely(pktlen > rxq->datasize)) {
> +		/* Increase it even if mana_rx_skb() isn't called. */
> +		rxq->rx_cq.work_done++;
> +
> +		++ndev->stats.rx_dropped;

It looks like this code was moved from mana_process_rx_cqe, so this is prob
out of scope, but I saw this and was wondering if maybe rx_length_errors is more
appropriate?

from if_link.h:

 * @rx_length_errors: Number of packets dropped due to invalid length.
 *   Part of aggregate "frame" errors in `/proc/net/dev`.
