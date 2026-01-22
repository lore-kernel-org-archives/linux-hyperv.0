Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139B3859DD;
	Thu, 22 Jan 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107270; cv=none; b=Lb95kIDH+MaLM0KIJUvgAu25Mm0wj8iqHbgAm4sPV9KcvfIgPQ8RR7E7fAB9FF2yHG6cD4Rx8uYtnTMz7y5VuSeNm5t5yXUgt9Q4Pdxs0l/yQ7z1BanjJOSaMXiJhoLMHzSaFZIDExtR79dTmjwV6nKR+XVPOEmORhag3ZxiaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107270; c=relaxed/simple;
	bh=mny2J00nrRs6M1IHRh0d8Q1nMB8VhbEIqBu99Df48CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNr/7w4XP8gIZ1gyEolHRy9CJCcv1eza3C9PyKASSBkU7OjBXZeQs19tlHmy14wg03QAmhI4aUg+bqJ0fZq5FGV+pD2wjbMLdyeFwL1CO3bv5bSS4ge6Zs3mINzUWO94DztCEYRskLj66lHqe0h/eJVDoPrSOSsHvtZS+T7Slho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NQP60CwH; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NQP60CwH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Sij5cyFk6sASCRFzOWNEYLobCeVvd/jMN2k8ihm0wIw=; b=NQP60CwHXQo7aqzhha6anevK3c
	xbl7o/XC2guoaytEpqBe8NxVsfMyqUMyVOPoSjqh36nn13feMSvgOstmOeod88Yq8dktQquPp/LD6
	HhjPOyzFGyDyqk8hpEhxxrrBRWCzuUZHNtnmQGUnCSr2aVJFMq0UnC3y+pKK0EcBMH3EgXvmHEYNf
	iITCPx93HZOKOXPNxidP5vMix/VGT6TF6ItQQEss93oG5Jliw3XuINwcWCG5Ve6dH3sI6YfIXhLTs
	KfDKWBqcDWHaKwRULAoQkIVHRuSyZu2TSwBOUtK8l9OA2juO1WUdUyds3Qr/ZJGC6+Z3Bu5mxxq68
	JsEmpJcA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizby-00DE0U-Ly; Thu, 22 Jan 2026 18:40:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:14 -0800
Subject: [PATCH net-next v2 2/9] net: atlantic: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-2-94dbe4dcaa10@debian.org>
References: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
In-Reply-To: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=leitao@debian.org;
 h=from:subject:message-id; bh=mny2J00nrRs6M1IHRh0d8Q1nMB8VhbEIqBu99Df48CU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8kKGR/7/+R88bgdG1d1CAVDrvN1m4tU6wAx
 Lyad+buyleJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 beqCD/9Q3iypbU4jAhwYJL6ZzuBe69K/yo+wvzan9GYfmIsdEd1b2EschFEPOHviKA+jJy58HJ+
 DztZwxXZdTM1TVvb/OjUoiMZ7pAMK6w80yomt0vWTPsxCfiI73fl2keHHiyKsPXen5z/MkKOYgw
 TI3o5bdY6QmxikeB88Kmy3LCoA7w8AbMxOJPlv2LsTZcX4RU9Ccai3FI72KcvLBtiRZ1TJDzWeW
 inKYyMkeXcA6yEytC/hGPQAW20PBnp/JKQ+6bqqOpc+U3tA04lb/VriZa81ZuPfMh7AgIjnAM+q
 Y4iFu4Q4UHXUZmDCDXgyWTC8F9pqWMnFIoWfiEo4YMimp7TaUbyz0qgBqcAQeyFFELoTSM3fXHa
 kpoLrfpkXlIQToNrCa8v4ZaMdm3b3cwFQ+OjSNrsPQXKa1t1+i/C4fcdQfdrpy4ipMrWZx+Otpq
 RKu1hBaIiHdhYJ3zcwcyCfM9PDHCSjeGRLSwo119yE+5ZNvMv0HZBjuwkrJnZtrayKhiyXSYQ/k
 vgi7YmjNGjdmggcn8eksYlLPPlFuZehdc0gtAeO5gzJjoUiZKCxDUdxNBtysq65WhEUSt3EYRu7
 zOMYBn+M5OqpjF4oPlNQOkN6qLMlub5nfZXy97Us8KKzdko0CTG3+MI6oisn13YcM0rgsyhtBLc
 3bZS1tBerJkNyUw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 6fef47ba0a59b..a6e1826dd5d7e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -500,20 +500,25 @@ static int aq_ethtool_set_rss(struct net_device *netdev,
 	return err;
 }
 
+static u32 aq_ethtool_get_rx_ring_count(struct net_device *ndev)
+{
+	struct aq_nic_cfg_s *cfg;
+	struct aq_nic_s *aq_nic;
+
+	aq_nic = netdev_priv(ndev);
+	cfg = aq_nic_get_cfg(aq_nic);
+
+	return cfg->vecs;
+}
+
 static int aq_ethtool_get_rxnfc(struct net_device *ndev,
 				struct ethtool_rxnfc *cmd,
 				u32 *rule_locs)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
-	struct aq_nic_cfg_s *cfg;
 	int err = 0;
 
-	cfg = aq_nic_get_cfg(aq_nic);
-
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = cfg->vecs;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = aq_get_rxnfc_count_all_rules(aq_nic);
 		break;
@@ -1072,6 +1077,7 @@ const struct ethtool_ops aq_ethtool_ops = {
 	.set_rxfh            = aq_ethtool_set_rss,
 	.get_rxnfc           = aq_ethtool_get_rxnfc,
 	.set_rxnfc           = aq_ethtool_set_rxnfc,
+	.get_rx_ring_count   = aq_ethtool_get_rx_ring_count,
 	.get_msglevel        = aq_get_msg_level,
 	.set_msglevel        = aq_set_msg_level,
 	.get_sset_count      = aq_ethtool_get_sset_count,

-- 
2.47.3

