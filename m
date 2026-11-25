Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589801;
	b=c3EVe8L+K9ZCgrNfYIyIYa/ImvbRcJN+GqLAa6xetziMtKx68zGrZWpnmJKktAVz3P8o
	 7+tkzlIcrgVzSTILWMHrtj7lVCrCQHcJ0QSazvJYw9i9U3+9unANny7qSrqipYF4zewGk
	 0U4L+eGq/CokTE8MTd4YPuncrzCDQcKZBEVx1HdxKVPm96Z/ZjnGajw4ntCiueMu57ivD
	 GTlzuUmswpKoBxI23LXcv0kxaDAZsXKWgqP+btOQdpDOC+1X5YP7ui3mLQw23txvI8H2m
	 wYC96yopcSukyjk+dZuLkhZVKvF5gN0EjnUDmeT0xIIemnMoihk4zAwrsIgA5MLJiHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589801;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=v2N3GcvzGp8pCmyk5/+OOTuDT9XiBxpv2TAT/4w+lgg=;
	b=lHU8R8tkZwMnkD+p2aIJ6R0bvLrH7jTYdWwp52QgRzOzCDetzkLiViiRZSiRse0qLOdk
	 V0sGdYphpbVdj+zn17V26MVS+bNTIVVyOpxRsA8U7JkwxET9Cop7m+LCUMNIBmgKSwPcD
	 4GQb9RBTjAtUQ3O4HYIFieLq/QItrqHDPcc5eRr0wXhT/F9VpJnhSV69Yrpo35bBNJ/QP
	 CLK5Z2L4VlfUa8zdLdqlpr+aIj87cbIPTSS523o1wskXsp1bZ7CL0lFVD67JE0wXPVKnn
	 SJXxXL4JDCK2q7i5/c3eKsgafhztiWjUSuL8uzPNiNwbuv+yQ5arcd6zMU/znTPOdHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=A+4sMm+i;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D0606A33D;
	Wed, 25 Nov 2026 06:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795D0606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=A+4sMm+i
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 9CA1020B7170; Tue, 24 Nov 2026 22:56:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CA1020B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795589796;
	bh=v2N3GcvzGp8pCmyk5/+OOTuDT9XiBxpv2TAT/4w+lgg=;
	h=From:To:Cc:Subject:Date:From;
	b=A+4sMm+imLiI00khBsJhs9jthiOHLK+zSXtmmIYtmSO2/kkEPL86Xszl/aaBveQu+
	 Yb9/U/ayGDNElWUrvcwkecrr3+yuphpMdEr137Bzx8IRVK7c8iK4tzGb78Uqdlx/EX
	 7g3Wd1L2byguiuRzPBMf1hmFPu2CDvhwu5dxuSvc=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	horms@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com
Cc: Amir Boussejra <amir@boussejra.com>
Subject: [PATCH net] net: hv_netvsc: Preserve RSS indirection table across device recreation
Date: Tue, 24 Nov 2026 22:56:17 -0800
Message-ID: <20261125065620.1604647-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing the MTU recreates the RNDIS device and frees the RSS indirection
table. The replacement is zeroed, but the user-configured flag survives
and prevents default initialization, directing all RX traffic to queue 0.

Save the custom table before teardown and restore it after host queue
negotiation if its size and queue indices remain valid. Otherwise use
defaults and report the lost configuration only after attachment succeeds.
Preserve the cached RSS key and zero table entries on single-queue error
fallbacks.

If subchannel setup or RSS programming fails, keep the device usable but
clear the active table and key caches and report the custom table lost
after attachment succeeds. This prevents nonzero netlink retries from
being skipped because they match settings that were not restored.

Fixes: 4cab498f33f7 ("hv_netvsc: Allocate rx indirection table size dynamically")
Reported-by: Amir Boussejra <amir@boussejra.com>
Closes: https://lore.kernel.org/all/40fb2352-4859-4334-849b-f6a4229605a1@boussejra.com/
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h   |  2 ++
 drivers/net/hyperv/netvsc_drv.c   | 44 +++++++++++++++++++++++++++++++
 drivers/net/hyperv/rndis_filter.c | 33 ++++++++++++++++-------
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 4841367fdab2..aef30cb52010 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -182,6 +182,8 @@ struct netvsc_device_info {
 	struct bpf_prog *bprog;
 
 	u8 rss_key[NETVSC_HASH_KEYLEN];
+	u16 *rss_indir_table;
+	u32 rss_indir_size;
 };
 
 enum rndis_device_state {
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1d43c73fd73f..f51e7b349d7f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -928,6 +928,7 @@ static void netvsc_get_channels(struct net_device *net,
 static
 struct netvsc_device_info *netvsc_devinfo_get(struct netvsc_device *nvdev)
 {
+	struct net_device_context *ndc;
 	struct netvsc_device_info *dev_info;
 	struct bpf_prog *prog;
 
@@ -939,6 +940,21 @@ struct netvsc_device_info *netvsc_devinfo_get(struct netvsc_device *nvdev)
 	if (nvdev) {
 		ASSERT_RTNL();
 
+		ndc = netdev_priv(nvdev->extension->ndev);
+		if (netif_is_rxfh_configured(nvdev->extension->ndev) &&
+		    ndc->rx_table_sz) {
+			dev_info->rss_indir_table =
+				kmemdup(ndc->rx_table,
+					ndc->rx_table_sz * sizeof(*ndc->rx_table),
+					GFP_ATOMIC);
+			if (!dev_info->rss_indir_table) {
+				kfree(dev_info);
+				return NULL;
+			}
+
+			dev_info->rss_indir_size = ndc->rx_table_sz;
+		}
+
 		dev_info->num_chn = nvdev->num_chn;
 		dev_info->send_sections = nvdev->send_section_cnt;
 		dev_info->send_section_size = nvdev->send_section_size;
@@ -973,6 +989,7 @@ static void netvsc_devinfo_put(struct netvsc_device_info *dev_info)
 		bpf_prog_put(dev_info->bprog);
 	}
 
+	kfree(dev_info->rss_indir_table);
 	kfree(dev_info);
 }
 
@@ -1023,6 +1040,7 @@ static int netvsc_attach(struct net_device *ndev,
 	struct netvsc_device *nvdev;
 	struct rndis_device *rdev;
 	struct bpf_prog *prog;
+	bool rss_failed = false;
 	int ret = 0;
 
 	nvdev = rndis_filter_device_add(hdev, dev_info);
@@ -1036,6 +1054,19 @@ static int netvsc_attach(struct net_device *ndev,
 		if (ret) {
 			nvdev->max_chn = 1;
 			nvdev->num_chn = 1;
+		} else {
+			ret = rndis_filter_set_rss_param(nvdev->extension, dev_info->rss_key);
+		}
+
+		if (ret) {
+			netdev_err(ndev,
+				   "unable to restore RSS parameters (ret %d).\n",
+				   ret);
+			/* Do not report the saved parameters as restored. */
+			memset(ndev_ctx->rx_table, 0,
+			       ndev_ctx->rx_table_sz * sizeof(*ndev_ctx->rx_table));
+			memset(nvdev->extension->rss_key, 0, NETVSC_HASH_KEYLEN);
+			rss_failed = true;
 		}
 	}
 
@@ -1066,6 +1097,14 @@ static int netvsc_attach(struct net_device *ndev,
 			netif_carrier_on(ndev);
 	}
 
+	/* Check whether the custom RSS table was lost and notify ethtool. */
+	if (netif_is_rxfh_configured(ndev) &&
+	    (rss_failed || !ndev_ctx->rx_table_sz ||
+	     ndev_ctx->rx_table_sz != dev_info->rss_indir_size ||
+	     memcmp(ndev_ctx->rx_table, dev_info->rss_indir_table,
+		    dev_info->rss_indir_size * sizeof(*ndev_ctx->rx_table))))
+		ethtool_rxfh_indir_lost(ndev);
+
 	return 0;
 
 err2:
@@ -2719,6 +2758,11 @@ static int netvsc_suspend(struct hv_device *dev)
 		goto out;
 	}
 	ret = netvsc_detach(net, nvdev);
+	if (ret) {
+		netvsc_devinfo_put(ndev_ctx->saved_netvsc_dev_info);
+		ndev_ctx->saved_netvsc_dev_info = NULL;
+	}
+
 out:
 	rtnl_unlock();
 
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 962251327506..9c0f01b6af1c 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1290,6 +1290,7 @@ int rndis_set_subchannel(struct net_device *ndev,
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	struct hv_device *hv_dev = ndev_ctx->device_ctx;
 	struct rndis_device *rdev = nvdev->extension;
+	bool restore_rss_table;
 	int i, ret;
 
 	ASSERT_RTNL();
@@ -1332,11 +1333,23 @@ int rndis_set_subchannel(struct net_device *ndev,
 	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++)
 		ndev_ctx->tx_table[i] = i % nvdev->num_chn;
 
-	/* ignore failures from setting rss parameters, still have channels */
-	if (dev_info)
-		rndis_filter_set_rss_param(rdev, dev_info->rss_key);
-	else
+	if (dev_info) {
+		/* Validate the whole saved table against the granted channels. */
+		restore_rss_table = netif_is_rxfh_configured(ndev) &&
+				    dev_info->rss_indir_size == ndev_ctx->rx_table_sz;
+		for (i = 0; restore_rss_table && i < ndev_ctx->rx_table_sz; i++)
+			if (dev_info->rss_indir_table[i] >= nvdev->num_chn)
+				restore_rss_table = false;
+
+		/* Restore the saved table if valid, otherwise use defaults. */
+		for (i = 0; i < ndev_ctx->rx_table_sz; i++)
+			ndev_ctx->rx_table[i] = restore_rss_table ?
+				dev_info->rss_indir_table[i] :
+				ethtool_rxfh_indir_default(i, nvdev->num_chn);
+	} else {
+		/* Set initial RSS parameters; ignore failures to keep the channels. */
 		rndis_filter_set_rss_param(rdev, netvsc_hash_key);
+	}
 
 	netif_set_real_num_tx_queues(ndev, nvdev->num_chn);
 	netif_set_real_num_rx_queues(ndev, nvdev->num_chn);
@@ -1500,6 +1513,8 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
 
 	net_device->extension = rndis_device;
 	rndis_device->ndev = net;
+	memcpy(rndis_device->rss_key, device_info->rss_key,
+	       NETVSC_HASH_KEYLEN);
 
 	/* Send the rndis initialization message */
 	ret = rndis_filter_init_device(rndis_device, net_device);
@@ -1570,11 +1585,8 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
 	/* We will use the given number of channels if available. */
 	net_device->num_chn = min(net_device->max_chn, device_info->num_chn);
 
-	if (!netif_is_rxfh_configured(net)) {
-		for (i = 0; i < ndc->rx_table_sz; i++)
-			ndc->rx_table[i] = ethtool_rxfh_indir_default(
-						i, net_device->num_chn);
-	}
+	for (i = 0; i < ndc->rx_table_sz; i++)
+		ndc->rx_table[i] = ethtool_rxfh_indir_default(i, net_device->num_chn);
 
 	atomic_set(&net_device->open_chn, 1);
 	vmbus_set_sc_create_callback(dev->channel, netvsc_sc_open);
@@ -1598,6 +1610,9 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
 	/* setting up multiple channels failed */
 	net_device->max_chn = 1;
 	net_device->num_chn = 1;
+	if (ndc->rx_table_sz)
+		memset(ndc->rx_table, 0,
+		       ndc->rx_table_sz * sizeof(*ndc->rx_table));
 	return net_device;
 
 err_dev_remv:
-- 
2.43.0

