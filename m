Return-Path: <SRS0=Uaeg=3F=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD41C33CB3
	for <linux-hyperv@archiver.kernel.org>; Thu, 16 Jan 2020 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF70B20730
	for <linux-hyperv@archiver.kernel.org>; Thu, 16 Jan 2020 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195027;
	bh=YSPCRtvsCh16pjnRFqDXHWPRDtBnQ0mKqnVa4CJxkI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8eWFVPOkUBAneoMKS0U8r7/cvPGSSVNjfp60L4JSn676jGVTjY1JYmuJZV5eKXcI
	 LYtOqpXRa3ZZl2YTPegpn416awHSXhaUnzndP9zX1yzSuIdkM7JCi5Sz+x3uEiVnwo
	 iQv0dVH67T6v8r2Waa1Gk+B6PKNS5tWYh2Sd2ibM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbgAPRN4 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390862AbgAPRN4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599AF246AB;
        Thu, 16 Jan 2020 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194835;
        bh=YSPCRtvsCh16pjnRFqDXHWPRDtBnQ0mKqnVa4CJxkI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ea+QRb8I9yClZ+PwnvifeCA11uPefyLSQwcOkAYPThAsESq7oDvi9DBjs2B1yUJIR
         O6LuLUDFs3BbsKGITbAxtEYC2LNIeDKWCDbMtt0NSoP/FxjCJREDV7ci3RVNi2+b1O
         0JZCRzp8IDqHGIFtnKuhLWw7bwPBNSRJczGPqXXk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 635/671] hv_netvsc: flag software created hash value
Date:   Thu, 16 Jan 2020 12:04:33 -0500
Message-Id: <20200116170509.12787-372-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stephen Hemminger <sthemmin@microsoft.com>

[ Upstream commit df9f540ca74297a84bafacfa197e9347b20beea5 ]

When the driver needs to create a hash value because it
was not done at higher level, then the hash should be marked
as a software not hardware hash.

Fixes: f72860afa2e3 ("hv_netvsc: Exclude non-TCP port numbers from vRSS hashing")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 54670c9905c7..7ab576d8b622 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -295,9 +295,9 @@ static inline u32 netvsc_get_hash(
 		else if (flow.basic.n_proto == htons(ETH_P_IPV6))
 			hash = jhash2((u32 *)&flow.addrs.v6addrs, 8, hashrnd);
 		else
-			hash = 0;
+			return 0;
 
-		skb_set_hash(skb, hash, PKT_HASH_TYPE_L3);
+		__skb_set_sw_hash(skb, hash, false);
 	}
 
 	return hash;
@@ -804,8 +804,7 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 	    skb->protocol == htons(ETH_P_IP))
 		netvsc_comp_ipcsum(skb);
 
-	/* Do L4 checksum offload if enabled and present.
-	 */
+	/* Do L4 checksum offload if enabled and present. */
 	if (csum_info && (net->features & NETIF_F_RXCSUM)) {
 		if (csum_info->receive.tcp_checksum_succeeded ||
 		    csum_info->receive.udp_checksum_succeeded)
-- 
2.20.1

