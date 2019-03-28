Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF7C10F06
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A862721773
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 17:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfC1RuL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:50:11 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:59536
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbfC1RuL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 13:50:11 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 9Z9JhVvWdO5E59Z9JhQc8T; Thu, 28 Mar 2019 10:49:09 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1h9Z9J-0001GA-2c; Thu, 28 Mar 2019 10:49:09 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     sashal@kernel.org, linux-hyperv@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after tx_disable
Date:   Thu, 28 Mar 2019 17:48:45 +0000
Message-Id: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMZltb/sB/e4UFgHZssbiqMVSxMBg9AEbr636/S1oQ8KsXQsBgkLBRKZ/UGFHIUHnpqPbg8WYWhK0FjV7KYU1om1AERIXUCiQL+IC388fmc83N88XzIz
 K7lVMgJLkBQnBSRsOJX3ixnNvn21rJVRT14hwWEZh9TymyHp3W8TMWjblycauAJ5t11F1bvzBJewElSGeXtKnSpIBkjuAdP5+XlY9707Zu+Ks1a/+VtUYANb
 hIkIla+gc7BqMoqo8tc5ZlGHxS5lq8djKsUDyIFo/rC0L+A1aztSQq4J/x+Qs43XRM8jdjB5a1myyC46lNaAAzhsZdqeKYchN6CBTAifdZyk4fF+kKuRhLAH
 nlZxYA9ileifSvTJXCnUeV5MzRl2gtyYmNgNJpfflR8wvzzgoc/7crh7AhsQYxMALXs5olUMWVPbLD2DWEn7x+GrDLCHb8NwSGJcqo2Ma5BYqlpcxmKdFz2X
 x6HKPxmftdVpexfuDQG/zezAmGMMOV/jM0LgATFT1WoFEfKUpClO45VGB5Q=
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

After queue stopped, the wakeup mechanism may wake it up again
when ring buffer usage is lower than a threshold. This may cause
send path panic on NULL pointer when we stopped all tx queues in
netvsc_detach and start removing the netvsc device.

This patch fix it by adding a tx_disable flag to prevent unwanted
queue wakeup.

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Reported-by: Mohammed Gamal <mgamal@redhat.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h |  1 +
 drivers/net/hyperv/netvsc.c     |  6 ++++--
 drivers/net/hyperv/netvsc_drv.c | 32 ++++++++++++++++++++++++++------
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index e859ae2..49f41b6 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -987,6 +987,7 @@ struct netvsc_device {
 
 	wait_queue_head_t wait_drain;
 	bool destroy;
+	bool tx_disable; /* if true, do not wake up queue again */
 
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 813d195..e0dce37 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -110,6 +110,7 @@ static struct netvsc_device *alloc_net_device(void)
 
 	init_waitqueue_head(&net_device->wait_drain);
 	net_device->destroy = false;
+	net_device->tx_disable = false;
 
 	net_device->max_pkt = RNDIS_MAX_PKT_DEFAULT;
 	net_device->pkt_align = RNDIS_PKT_ALIGN_DEFAULT;
@@ -719,7 +720,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
 	} else {
 		struct netdev_queue *txq = netdev_get_tx_queue(ndev, q_idx);
 
-		if (netif_tx_queue_stopped(txq) &&
+		if (netif_tx_queue_stopped(txq) && !net_device->tx_disable &&
 		    (hv_get_avail_to_write_percent(&channel->outbound) >
 		     RING_AVAIL_PERCENT_HIWATER || queue_sends < 1)) {
 			netif_tx_wake_queue(txq);
@@ -874,7 +875,8 @@ static inline int netvsc_send_pkt(
 	} else if (ret == -EAGAIN) {
 		netif_tx_stop_queue(txq);
 		ndev_ctx->eth_stats.stop_queue++;
-		if (atomic_read(&nvchan->queue_sends) < 1) {
+		if (atomic_read(&nvchan->queue_sends) < 1 &&
+		    !net_device->tx_disable) {
 			netif_tx_wake_queue(txq);
 			ndev_ctx->eth_stats.wake_queue++;
 			ret = -ENOSPC;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1a08679..0824155 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -109,6 +109,15 @@ static void netvsc_set_rx_mode(struct net_device *net)
 	rcu_read_unlock();
 }
 
+static inline void netvsc_tx_enable(struct netvsc_device *nvscdev,
+				    struct net_device *ndev)
+{
+	nvscdev->tx_disable = false;
+	mb(); /* ensure queue wake up mechanism is on */
+
+	netif_tx_wake_all_queues(ndev);
+}
+
 static int netvsc_open(struct net_device *net)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(net);
@@ -129,7 +138,7 @@ static int netvsc_open(struct net_device *net)
 	rdev = nvdev->extension;
 	if (!rdev->link_state) {
 		netif_carrier_on(net);
-		netif_tx_wake_all_queues(net);
+		netvsc_tx_enable(nvdev, net);
 	}
 
 	if (vf_netdev) {
@@ -184,6 +193,17 @@ static int netvsc_wait_until_empty(struct netvsc_device *nvdev)
 	}
 }
 
+static inline void netvsc_tx_disable(struct netvsc_device *nvscdev,
+				     struct net_device *ndev)
+{
+	if (nvscdev) {
+		nvscdev->tx_disable = true;
+		mb(); /* ensure txq will not wake up after stop */
+	}
+
+	netif_tx_disable(ndev);
+}
+
 static int netvsc_close(struct net_device *net)
 {
 	struct net_device_context *net_device_ctx = netdev_priv(net);
@@ -192,7 +212,7 @@ static int netvsc_close(struct net_device *net)
 	struct netvsc_device *nvdev = rtnl_dereference(net_device_ctx->nvdev);
 	int ret;
 
-	netif_tx_disable(net);
+	netvsc_tx_disable(nvdev, net);
 
 	/* No need to close rndis filter if it is removed already */
 	if (!nvdev)
@@ -918,7 +938,7 @@ static int netvsc_detach(struct net_device *ndev,
 
 	/* If device was up (receiving) then shutdown */
 	if (netif_running(ndev)) {
-		netif_tx_disable(ndev);
+		netvsc_tx_disable(nvdev, ndev);
 
 		ret = rndis_filter_close(nvdev);
 		if (ret) {
@@ -1906,7 +1926,7 @@ static void netvsc_link_change(struct work_struct *w)
 		if (rdev->link_state) {
 			rdev->link_state = false;
 			netif_carrier_on(net);
-			netif_tx_wake_all_queues(net);
+			netvsc_tx_enable(net_device, net);
 		} else {
 			notify = true;
 		}
@@ -1916,7 +1936,7 @@ static void netvsc_link_change(struct work_struct *w)
 		if (!rdev->link_state) {
 			rdev->link_state = true;
 			netif_carrier_off(net);
-			netif_tx_stop_all_queues(net);
+			netvsc_tx_disable(net_device, net);
 		}
 		kfree(event);
 		break;
@@ -1925,7 +1945,7 @@ static void netvsc_link_change(struct work_struct *w)
 		if (!rdev->link_state) {
 			rdev->link_state = true;
 			netif_carrier_off(net);
-			netif_tx_stop_all_queues(net);
+			netvsc_tx_disable(net_device, net);
 			event->event = RNDIS_STATUS_MEDIA_CONNECT;
 			spin_lock_irqsave(&ndev_ctx->lock, flags);
 			list_add(&event->list, &ndev_ctx->reconfig_events);
-- 
1.8.3.1

