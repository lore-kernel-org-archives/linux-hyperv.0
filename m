Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A3A47DFB7
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010994; cv=none; b=lCwtcJy+Q1N6j2e9vp1LvHBDDlEylJyWAso2inmzdPZoAjBYrL9ZxNJZIUHkZf1FPZZGXv3gqc4mcFz30R+cibl67WXBbNrDcfbKwklKHSQMTxl63ahRDIA5NaoziyoVOsoR6jsLjdn+X6mc3ySzhHVHbH7sbl+7Z137HyuMQWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010994; c=relaxed/simple;
	bh=kqzS/7eXjKQG4xiemTDsmFZRs2ALv2BsjFw/ViIR5ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6cxLHdLNm6iqZ5nYeHY+A647/qafd01e+2Jz0kqZNVd3kmlHdwXduiDU1VKHD5T0HgbsRqqIBIr8pUvfqNYyVp3JXZegg3V6lv/nrVUJ3Cf6oQIuZPsHOGksOKB7toTEAmHuUcfjW8YysmGII5A0LI4S44PFmu2LUt0hqdsVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c87d82bd2so19333b6e.1
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010989; x=1769615789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BvlsW4lqNl+1+09mnU3bYFr4itCF0ttr+C2yEDPsR5w=;
        b=SlpImZKHRxwzIrS+lcysP7oeyRH/Qnln5UgbYpmYwoR/WoQ58AYbbVqIcaK0u8z3Og
         kOhyD7TFgBvmaqo0T9V2kpHViJJLfJbA4AIU07mUXvaqNIW6nGo8wy+e2twemD5h1TbA
         JW6riz+PiyVPkMmrLpIWlqOutm4xPFvd2AoznokzRhdAj0twU2vQWgJ2hrwI7eXGxx4l
         VSUBzEEl59g+KCA13MPQCV8LQyXLbBfpmKVKFiuqOUdqtGoPOMKG1eYrPTAMbdB4h0Qi
         HBejdwIO5l5Jshg2X7sy5X8DqR0rFRsnASe/GXKCu3G8uWe617+oSM6Z0N//BzHqGd2g
         Pmpw==
X-Forwarded-Encrypted: i=1; AJvYcCWJm3c/3WmFb3vlEh2Pr4HS7Rj9JYmtNA+FSHBBXWTTfSIa0k8vtJZQdsxUmkjoKfKToWAqwffgpPVATKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlk04OHQjVwtsnIeCdKIYeFlzEZjbruCE98jc/8u9SS2JO/sUo
	yU17eGkQ4vt2NhhUmOsojr6pP8wipErYgtpHqCPTyuY8JznIiAT1jkl1
X-Gm-Gg: AZuq6aI+EAqXHpQ++HshbRTpbWXayA7SeNnBmBZflMXLoPcosdHKZr2oznnGjiPOlLm
	JQCkUlU/WFj6HSl6O+Wf/4miDRbUesPwP/y9UGWa4dzlklLU8i8cNMUy93rTtE49UQUPqLfLJk3
	RXXqsdip3Dkt6MWTsRm5xHUJE4CdRkCURcYTZUH6w7yoWWeOBghAUL6vO3cNQMXLafHvZjZTNja
	B4r49NLXOFxA2DcPtBaF0opVnlyNh1J2DOk9hyA/XwP7HTjGegLOR66beNUYyXNApTzPhfc0pA0
	Bg2pPEKmlsHrW2nXXc2Bl0dEUeKegnp6ksNYOJ636pi7BHSvu0meq+QIsO+Rdk2lv/7XjAS32hG
	g+XoN3nVs0HmxvV0Z/nE4mEdzw0onn8H7nmoUG9/qt7UU9VnOnAoJbD8lAu24tha/B2b8pp0aXq
	0O
X-Received: by 2002:a05:6808:1207:b0:450:f17d:860e with SMTP id 5614622812f47-45c9c146db5mr7453499b6e.47.1769010989362;
        Wed, 21 Jan 2026 07:56:29 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dec6619sm8684288b6e.3.2026.01.21.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:46 -0800
Subject: [PATCH net-next 9/9] net: sfc: falcon: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-9-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=leitao@debian.org;
 h=from:subject:message-id; bh=kqzS/7eXjKQG4xiemTDsmFZRs2ALv2BsjFw/ViIR5ug=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPci73BBafszurpkpislh2ZdfEde9KM1z3BTH
 bEi/YHQ4KqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IgAKCRA1o5Of/Hh3
 bW8xD/9h5DYoUj0BnDZx0DxqyEswo0Yz24BdyMadcONl2aU6A/5L0TN0u8VNDwSsWgG+fnZxzfR
 0kHcfXVG8VstKhv6WBMC4KO1magMR4Lx3JYC22oDObaXt2v5Y0T7QAFhVc5PKptaqbhRPvlEcZN
 1unciuhewFPcqJbCk6kpIvhbnNIY1YQA+YL3S5AVwJLGQFEl648DGshte1NMUainY1FRJzIOXZJ
 4GrJrJkkpb9DrbLw5/tOn/HudzHV5/eCLJJj4M7K+AqBwreaMY1wzbe3mO0amtQgxgkEFEKIgty
 0InW+tYXBOA/7shGFBMmhLckz6+yyDQz4tX5Z6F6EisOINVh+IghhbpQY9+5krZdeEmjm0ksSf8
 smqvc/Qh/olyNs/+9DSROujp3XnNIyKb1mU37/30xZ3U7at0PE0hyenclY51b2lnpKU+YSR+eZB
 bT8VP4nh7dJjCb8vSM21cU0LGpf1s8nkWKllnCNL34XZXQ0moTharhlQpikpXe+R6URX5SEgh2o
 8NpNLahAV7Az19qYncrEyF56TzKpBQNX3WfsPoM99oCxmkNP49P7Qs5qZI0dB8mwx1kmqtMWALQ
 fBl93SueB5K5ODRvXlBT/rrqhdsnXPaQ+1y6DKBTLMeK89Kb0y/0QFD7LrTz9A1HY4wHRz2RILz
 CB90w3nUtgxXUwQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/sfc/falcon/ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 27d1cd6f24ca1..0493640315454 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -974,6 +974,13 @@ ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	return 0;
 }
 
+static u32 ef4_ethtool_get_rx_ring_count(struct net_device *net_dev)
+{
+	struct ef4_nic *efx = netdev_priv(net_dev);
+
+	return efx->n_rx_channels;
+}
+
 static int
 ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 		      struct ethtool_rxnfc *info, u32 *rule_locs)
@@ -981,10 +988,6 @@ ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 	struct ef4_nic *efx = netdev_priv(net_dev);
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = efx->n_rx_channels;
-		return 0;
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = ef4_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
@@ -1348,6 +1351,7 @@ const struct ethtool_ops ef4_ethtool_ops = {
 	.reset			= ef4_ethtool_reset,
 	.get_rxnfc		= ef4_ethtool_get_rxnfc,
 	.set_rxnfc		= ef4_ethtool_set_rxnfc,
+	.get_rx_ring_count	= ef4_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= ef4_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= ef4_ethtool_get_rxfh,
 	.set_rxfh		= ef4_ethtool_set_rxfh,

-- 
2.47.3

