Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B27385523;
	Thu, 22 Jan 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107289; cv=none; b=Y4DpRm6hU6yvieb+a1UMvVIhNYihL4DVn4sP+TBPL4cDaH3n2lPBB1YO3A+oIMQw14uKQyyuhuciMNvfA/hbzilYdFeFGuZqeTBiaTJwAeCKMHVHc3TRTPQf0/rC21oWzmeLem/5+uyo2L/xFJv0uL4VMEyRXPjkmntDl0RupFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107289; c=relaxed/simple;
	bh=hcqyM75IhDs1llDj+Jc/tRBAmN6d3Y2GPI2HR0+kOEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/FHtmflpOS0YCh9Jp1VLY6bfWiwEgp4ttEn3RIOXv6u5uQf8hGWwjSGuwFjAypmeLQb5QZ284pphiRcUE5wd00cPMtANFFEEI4a9Pk196aAjhpw/kYGIDzU3DnEltmBESDWdNL/EtSVDsDKSSFzOe4pwrjC7v5egHIPeJ5aYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=B87wqEox; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="B87wqEox"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=BLDbgw2RbJKl24Wt0v/fHeCv4g6QFtZXh1UHirohJQY=; b=B87wqEoxoqNxrfJlqatHqFodEi
	YC7kb0os1bPtlRdxo8z5QhItiHs9G+L5ot7Q+Nfp56LQ3tq/EEVuk9WN1ZMxAfqaUOQXztpGYEMqL
	8dDN0NttE4Gv5qDq3wv+dYRgg46XcBbrU7FhpbtYBSWGxWakoqk6qfbUaK0590WU93J+it3fLj6ZV
	zonRGw8go9YDWLZdWnAWPPZdRVHi+s51sQDEeudU12qL+GWb5RKxAJ6FAlmp2OgXq1rKezgAZZBxn
	2ScepCB3WxVlREbvLm7IX+Q6QJ5TnDWeoAS2l2VpNhWlycM6SceJuVgb98gCHni+jcQjb9HRAET1N
	PZ38nMVA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizcL-00DE1q-GU; Thu, 22 Jan 2026 18:41:17 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:18 -0800
Subject: [PATCH net-next v2 6/9] net: ionic: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-6-94dbe4dcaa10@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=leitao@debian.org;
 h=from:subject:message-id; bh=hcqyM75IhDs1llDj+Jc/tRBAmN6d3Y2GPI2HR0+kOEk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8k0kk3ABjJYbC9BPOONFr6Q4C+8FeRjPtbo
 j4zk+VDdPGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 bW7uD/96h8iVT+YSeMRE7CQILrkHvBXsdVsDCO+yv3k2OS4MBLR793NHDm7ymgcdctxCG0U3oe+
 XTQRKqfD56wMqL/ZaPMg51DoCZJzF9VGxUp2uzGlUazfIMRCiUSFFU0SMoExOe1epSXXjTgKWYl
 PvogDldi7XZ/wIAm6V9y1CpsSl5oGylLQsbWDNWXCyYy+nMifNMFfp++VeyP0zmLknO+f+ffMIM
 eqzblXmj21luh0fixVwrsXYgKEkKlfAdRm9iiiY5+JW+GMoptCFj1Rj/nm28X8Q1B4In/YnSX6X
 5ECJDIEYUVRzSaR4lXxVIW3729HsAVqVyPxlM5XD3CI51ANkbPO1sw/VQcutlpoak9CtMxlh9fG
 jPEGreeLi+Un35UCS4Nx/G7z/w2xuPDgo7pDRXtxxfxS3pNdAV9OxB//n3toFWzeGcfagiyGOLn
 BAyn6r5iJaCwfNSVm6eRU5+PpdfoEAtw/OpOMJVDk3I11Wk/vxn5vqvoqAxHAAPMV5Fe35aH7Yx
 jb1Ke00Rnr+lKZBGGLZH29tsEU6KHXYnfchzO7txDjGVjN6UOzcuJmdit71X3bE7QqAhV3J5P1V
 8jDV1S9A96dKpJgrxL0642gA9x90CVlVq8acZDTtUXD00IkpTWkxxQ08J0xX8QltXBphuFtwd/9
 E4H0aFNh/bO9jdg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by ionic_get_rxnfc(),
remove the function entirely.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 2d9efadb5d2ae..b0a459eeaa640 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -843,23 +843,11 @@ static int ionic_set_channels(struct net_device *netdev,
 	return err;
 }
 
-static int ionic_get_rxnfc(struct net_device *netdev,
-			   struct ethtool_rxnfc *info, u32 *rules)
+static u32 ionic_get_rx_ring_count(struct net_device *netdev)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
-	int err = 0;
-
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = lif->nxqs;
-		break;
-	default:
-		netdev_dbg(netdev, "Command parameter %d is not supported\n",
-			   info->cmd);
-		err = -EOPNOTSUPP;
-	}
 
-	return err;
+	return lif->nxqs;
 }
 
 static u32 ionic_get_rxfh_indir_size(struct net_device *netdev)
@@ -1152,7 +1140,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_strings		= ionic_get_strings,
 	.get_ethtool_stats	= ionic_get_stats,
 	.get_sset_count		= ionic_get_sset_count,
-	.get_rxnfc		= ionic_get_rxnfc,
+	.get_rx_ring_count	= ionic_get_rx_ring_count,
 	.get_rxfh_indir_size	= ionic_get_rxfh_indir_size,
 	.get_rxfh_key_size	= ionic_get_rxfh_key_size,
 	.get_rxfh		= ionic_get_rxfh,

-- 
2.47.3

