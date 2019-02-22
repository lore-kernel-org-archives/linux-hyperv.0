Return-Path: <SRS0=lZBM=Q5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90589C43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9242070B
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfBVS0p (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:26:45 -0500
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:37252
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfBVS0o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Feb 2019 13:26:44 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id xFW3ghWxKhEQ7xFW3gUlkm; Fri, 22 Feb 2019 11:25:43 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gxFW3-0003Aq-Bn; Fri, 22 Feb 2019 11:25:43 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     sashal@kernel.org, linux-hyperv@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH hyperv-fixes] hv_netvsc: Fix IP header checksum for coalesced packets
Date:   Fri, 22 Feb 2019 18:25:03 +0000
Message-Id: <20190222182503.12160-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: haiyangz@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAdO3BIupsRjgTvMK/y1eJzwxhgPoRgQSW3yr1z8H7YHKhKrdWAPhRkKvYWaGAVBdvEBALHtb3A/P9vUadekn00sIF7lncMMrl/H/aQiNYyrPGyBFZ8N
 pIbUq91qbfVHE9AU4LTx1bJL3AmAkCfVUjeoZsYJfzeO/2Lyv6C6rSdNm23rqYWfUs/XWJknfmQbqLvPj0d1O9bdURQdmSUe7FZPKb1ERXbVsuBVRDb+KJ0m
 oh1VqXfDQ/qMSbXyy/iYNKY+N8UOY7kTqXifzVpI7Fph+QRbscjdVjg7vVwMck/HpUzW7gGa45opl/i3N/vM1dYiY+VIKUnDurIuWdAKlICNoIcHJYXhTrkF
 RNofzeSdRsDJM72g+F9fKSCVvpRmI32sx5tRZUY5Ql3dh48M6mtXP2U1OaFEnkgmY4B+GsuutzoD5R5AgPpiiOo/13uBoc49pwQIxwZsvCkmwRMv6OUsBYyE
 XVDyEqmCw8D0hirlSNPTbirRuf3rBV8RWbWCGGMWcePTX6jCam8Mic7tvqg=
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Incoming packets may have IP header checksum verified by the host.
They may not have IP header checksum computed after coalescing.
This patch re-compute the checksum when necessary, otherwise the
packets may be dropped, because Linux network stack always checks it.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 256adbd044f5..cf4897043e83 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -744,6 +744,14 @@ void netvsc_linkstatus_callback(struct net_device *net,
 	schedule_delayed_work(&ndev_ctx->dwork, 0);
 }
 
+static void netvsc_comp_ipcsum(struct sk_buff *skb)
+{
+	struct iphdr *iph = (struct iphdr *)skb->data;
+
+	iph->check = 0;
+	iph->check = ip_fast_csum(iph, iph->ihl);
+}
+
 static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 					     struct netvsc_channel *nvchan)
 {
@@ -770,9 +778,17 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 	/* skb is already created with CHECKSUM_NONE */
 	skb_checksum_none_assert(skb);
 
-	/*
-	 * In Linux, the IP checksum is always checked.
-	 * Do L4 checksum offload if enabled and present.
+	/* Incoming packets may have IP header checksum verified by the host.
+	 * They may not have IP header checksum computed after coalescing.
+	 * We compute it here if the flags are set, because on Linux, the IP
+	 * checksum is always checked.
+	 */
+	if (csum_info && csum_info->receive.ip_checksum_value_invalid &&
+	    csum_info->receive.ip_checksum_succeeded &&
+	    skb->protocol == htons(ETH_P_IP))
+		netvsc_comp_ipcsum(skb);
+
+	/* Do L4 checksum offload if enabled and present.
 	 */
 	if (csum_info && (net->features & NETIF_F_RXCSUM)) {
 		if (csum_info->receive.tcp_checksum_succeeded ||
-- 
2.19.1

