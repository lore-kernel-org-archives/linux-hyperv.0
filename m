Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA94219E1
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010987; cv=none; b=oSG9rSyuDZUtP06Tx+vCo9OU9BycPgqgFasRAxuwhY7vOabBeQNYU9xDPbtNSeedUeg5Z+LEeca0MRiNdNONnzEAzHV19VelTsqzSL7qnILd6pZivMWK58Unyr9jFe+kR29bkTOP4LPtwB3No9QeskExwlf3+FpP+xKzkHsZbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010987; c=relaxed/simple;
	bh=KiK6mfmbvfAjTMgI1Nxjqq2yBnQ7fftuW5wYTWWOth8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5lOCwyiLQ9YAzjPPLcksayMXpLJj2BBxeP8LunsTDeLTMKH0/JgtXVPXOKUXpBxUN/nI8bvx8XKxd9rGvh7RM/6nNLdX5ZPsA0aihwUkxCPVGiZp0T+tcn+sG5lhwiTMnglYC/c2MjlHO+f4fgFIDzkR1mKzcuCIzCzCEZS7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40427db1300so23320fac.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010984; x=1769615784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=obI4wQS/LQ9vhDitZWs7Cx+s8XoRN4vJudvn3e5+msk=;
        b=WHLKRKYjyssjCXTmSdYnEcwIsAqztMKRgHw8KroC57/7y7935ko70xNNC+T0OOKVz5
         6g4g1/ECMbUv+mv3VSSmvx2pfRQntrYcyF80ZdShy4TerSN3+IVqaNc7QWSCGeINjC6U
         kxGVmEa3/+D30LDazZQwTcR2k86k7xReS009GxTBXQlfVbtLFgaFfDUSkQlG7VKo6kSG
         WKJ34y94EkuiC3cZdo3NVCVWBbITBN8xmQ/dfOgC5OcKsWzjZho5LcLwJyCL3fO9KfGN
         4R6WYcjyasUM6QumR8/2m4BzHuc9CtoyoDcsYqoM93bQRJE+txhI04kEEc5IZR6RiiEO
         muHw==
X-Forwarded-Encrypted: i=1; AJvYcCXrdS4BV6e2AoZ5MkHSHvvvOupMl08sJVgGfxIZ7ZmmF3e1GHooEt+cRaLq3/FpfIntMiesAFKnHb0lTKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pLSj03FjJeCikPSIXktq+UzxP0yGbRgv95wAuKEcDY9tM+fs
	371qrpcf71FEdQpel1dPKzwdLGa1qwRvc6bZDyNPOs6NoPXalL25wy/L
X-Gm-Gg: AZuq6aLMXENisTSFzxtuI4pafvMusYC2HomWKxL1DSS4BAaojbaDqMSP2ZCHDPXI/EN
	F6wqhN2H9emZdoR7lBOJb78nEM/MoG6t5I8XRUBPvK4kqhBaE9SeWg88EM94n/JLpmMkw9fM6Jv
	IyaaTlGlaIE27FgGP9haESsnZTwlQ8sEyznBcIv+9d5d9yycRqdLeiOgQWbKq2vNOISlm/bzsCO
	JHCm661A8onxPGwL+Oed19CRrlei215swNR2HeaGWevwF2z9pOs8/ScEeKdGk4C50/P+oT+hjtv
	dBCCRLSv45g+0IAyji9Z7vkyZhMyOLSiK/yZ0TbIOMcuTe26o4xA4BVOgw9+AUKC+AHx7A8XgIM
	9wph8uOOAJW0Y2hfjFVDjngg1db0bXxa0zqYyXUAjb+e5juHg66zJ7yJMBUQljsuJ9siJgQNbCX
	ozt6zocJDzJHkz
X-Received: by 2002:a05:6870:96ab:b0:404:3569:5a41 with SMTP id 586e51a60fabf-4044c48851bmr8465128fac.43.1769010983920;
        Wed, 21 Jan 2026 07:56:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb51d4csm11180043fac.6.2026.01.21.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:23 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:41 -0800
Subject: [PATCH net-next 4/9] net: mana: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-4-07655be56bcf@debian.org>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
In-Reply-To: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=leitao@debian.org;
 h=from:subject:message-id; bh=KiK6mfmbvfAjTMgI1Nxjqq2yBnQ7fftuW5wYTWWOth8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPchuDZz2+z3ebNhVWvJuTRSz6BSL//QPW796
 671I66a6waJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bZ65EACXI508P/RfwmkFR+L8D8KIHhJLLGUTsHGVjf7f9Uzbxq1t5/rrWDTt0LzUqDjFooCLwyJ
 NAPPf9u9UEpKrVBeJ5qG7lNHbk6Ky/b8SEiGGZKVJPV3dqIzhhaiuIVNkrIDXjbqfjdT9Sg2wDv
 pzvi3YTkEd0kWWdk78owEkZQAezX8WB1kNjAxyuukT+ODvCFQVHhFPhzdiQ8Bun+WouGUtNveAd
 +EWtKYH5fKPUucNkEkLhlbEhMC/ebXKNXQueOamJj+ntMcFXgidY1pdwefIqtoYe2JcU3LcgID0
 MyCeNp8I5LkPIETtF/XiDk9Lceuw7D6bSPHDcWeRQMjMLHrAzIH0i6aWXn9h2HmGP8xCx2ocgPs
 d4wlIEwi29qh0/t4snIuu+3KsnggeGblNdrnywSZL034mOuzRQQlts+GlszBXLeV9mVoHitLTiY
 K+IujBqywA39DOWRCUHjCleMUH2/ygr1YN03sHmm612ZLHoJbPpCrQG/24G0q2IWlxkydxMQhxQ
 lfXJsFAipVTTZRJqYsNen+XbQKYSGiyNb2nDQC21kmGrX+cIVcgkgUG6zyyHV0MgrXTmbs/8Whm
 5ddLIlmTa2w15UOJOSRLnGcQ8K8ZqEt7y4CFh1TvVZseEhRiu9MooSRKujESwSL8EWbytf50r+w
 2NVXroXMqRDJzMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by mana_get_rxnfc(),
remove the function entirely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 0e2f4343ac67f..f2d220b371b5d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -282,18 +282,11 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	}
 }
 
-static int mana_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *cmd,
-			  u32 *rules)
+static u32 mana_get_rx_ring_count(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = apc->num_queues;
-		return 0;
-	}
-
-	return -EOPNOTSUPP;
+	return apc->num_queues;
 }
 
 static u32 mana_get_rxfh_key_size(struct net_device *ndev)
@@ -520,7 +513,7 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
-	.get_rxnfc		= mana_get_rxnfc,
+	.get_rx_ring_count	= mana_get_rx_ring_count,
 	.get_rxfh_key_size	= mana_get_rxfh_key_size,
 	.get_rxfh_indir_size	= mana_rss_indir_size,
 	.get_rxfh		= mana_get_rxfh,

-- 
2.47.3

