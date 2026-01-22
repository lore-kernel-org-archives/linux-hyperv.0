Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F9385ED3;
	Thu, 22 Jan 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107292; cv=none; b=bFGuWfj5T20lqYPKxMay4YyitUNfvkeB5/iNou7H7QAZBYy9cL8SHX5R61OEu4laGx9DWhxang0J2E+fm/WK0cwQWxrQWKDdtBMWbb7wfdvuCxnOtvvn37uOmEObQAyR/CVgZrWoxNZvJTgopIkmy28E18cyQQZ6Tn78JWPkIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107292; c=relaxed/simple;
	bh=IMKgxRU1sol0qv3q4ykIX98inRbeR6UTILUypHJQ1KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lc2oyZFirPiZNOS2mb1SECcNFmQsrO2Db5kc0dWoKOATqOFPbmR+xLHVg9LJh2ZFwl+Q9IVeupE7xkL/Ie3CErdePXbRdhOPHUJl94PzXTio0DdmC1VbmPLkJD4jmGyH2S7yzBBmE5xLc5fQgI9BnCyoar9HRNDsXJ25leDHXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MKyKrV08; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MKyKrV08"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=6idYD0AKGESVEMq5nLW+uYD0VvpAsFD+VjX/8Dx4wWo=; b=MKyKrV08Sx5QbmdCbkNRDtkaDJ
	fvnArC5vm8BIbXB9LY8sGgYFRtbYWFEA0ZvMllxNtqcJwGqItmJG2DoDBtshPY5z5IAnUJ4SefnRq
	6kgv2E7Zz7MMiht+JnHralKiPgZB5varnYjsWqSJWxjSGcOdE9YBTSpeAkl8vFeMMK71TxoagYh+z
	wPYaeNZz9U3XXOIdR2WR7p0f7gndQ0IHUWyEl9za0Za1cvmpXKtGGzGUdGcVSPwWpfNIKUlFztkLf
	yekpw5Lp6XGT910ym1VH8nkayNspFL6bLwV9fz17hdTgftgemkrN6s4p73ZvrrEJxfVpEfrtZ2622
	SBJG6p3w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizcF-00DE1S-S0; Thu, 22 Jan 2026 18:41:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:17 -0800
Subject: [PATCH net-next v2 5/9] net: fbnic: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-5-94dbe4dcaa10@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=leitao@debian.org;
 h=from:subject:message-id; bh=IMKgxRU1sol0qv3q4ykIX98inRbeR6UTILUypHJQ1KU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8ksyt9eH41AQ3+MfJ/92osnDOR8V5uk3YWS
 uKMEGyYCZaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 bbpgD/9Jw+nYWfKZ9fc3wYv6g6rcQS18RwauPhB//bzj12HJml938592iXIwdagqqNlfoifz/Fr
 0JN4J8wVZVHbO3YLBEbl1Igp5tL7asU+GECeo0JbrgdYxlRG14S/rN++HhgTkzVUXVkCM7SSiHK
 PPL3ERYKMGW2N/LPHYUQvHVrQq42UztgnXfOZwTCZX2PmH8QeJRpbzkod5kLpI62LDeF2boCJxs
 EZhcAiAcMSGkEpkAgHYOKbtQUkH+s5jWFwm3ITq0+VO/jhe9BDd7MozZTH7rmUf4rhjnw0XJwLM
 EPEiS+4SxBNw+KEf7oIzQGGtUvD2Nwf27vXqVuUosOye+EfcLHPDheHsUDWXfZL5rtR1iuqEO7j
 LcdLgoaPFydm2YzYYyDDfQtz/W1qYij+Q3OSd/KCaBD87Cm2r7jCtfbxuTALiCIiLQ0uxZj5qLa
 Zz3+qgjhaG/ZisoUSMakVsuYczG2FgYI18hzjX1l9kffKyMgQ9c+lEItaapYthtAoPwGm46YzCA
 8z6rNAuEo9sB/3IkNOq4u4BOi/hr4SQ/4cV1VkqGvU+aknL8pzIEb0xCX/+hpuqxT1YvuvtjqW7
 1kfSFt1VyP1yHA3fwcijhbSQeVj5l5bEbocgoV43KbDcLqjjd/UZzobu3VFgP+tmAx+3I/E9w0v
 aT4Lc2IoYT2lroQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 61b8005a0db5f..11745a2d8a443 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -825,6 +825,13 @@ static int fbnic_get_cls_rule(struct fbnic_net *fbn, struct ethtool_rxnfc *cmd)
 	return 0;
 }
 
+static u32 fbnic_get_rx_ring_count(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return fbn->num_rx_queues;
+}
+
 static int fbnic_get_rxnfc(struct net_device *netdev,
 			   struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
@@ -833,10 +840,6 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
 	u32 special = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = fbn->num_rx_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRULE:
 		ret = fbnic_get_cls_rule(fbn, cmd);
 		break;
@@ -1895,6 +1898,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_sset_count			= fbnic_get_sset_count,
 	.get_rxnfc			= fbnic_get_rxnfc,
 	.set_rxnfc			= fbnic_set_rxnfc,
+	.get_rx_ring_count		= fbnic_get_rx_ring_count,
 	.get_rxfh_key_size		= fbnic_get_rxfh_key_size,
 	.get_rxfh_indir_size		= fbnic_get_rxfh_indir_size,
 	.get_rxfh			= fbnic_get_rxfh,

-- 
2.47.3

