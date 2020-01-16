Return-Path: <SRS0=Uaeg=3F=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D84BC33CAF
	for <linux-hyperv@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0B32053B
	for <linux-hyperv@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200826;
	bh=/XjjuyJM66nJZY8ruIXznJGpNYS9Xd7bRF1x7oYOdMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dEppRqex+rPwuIQgUfsC8LR06uNc4uTP150mM+o2cRpsJQLq03K0/FjSoTJ2eACVk
	 yZeoS2cUCflcWdH6Tu0KqllXBCmWR7aURX+CJRWbBewNk9wNB3IEr5FoUrtOvaNCzv
	 cW/c/3aqM3A/IlI+6Mx+/hogLENGYFun9RfRYNhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgAPRIL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:08:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389310AbgAPRIL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F48924686;
        Thu, 16 Jan 2020 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194490;
        bh=/XjjuyJM66nJZY8ruIXznJGpNYS9Xd7bRF1x7oYOdMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJxnw3WiL4f436IlJC2FVyarxFu7/wONI4VOa8Xx4KQ7kxIN6IAF1gz29HRl/aSAW
         sBncG4ROk9MGlUp3FVhIg6SEK0wpoq3BZPJh92+q3Lw+8C3ABpGLi5z/8ztPNooiP9
         +cdgrb98m6T2DlY+NMy6t112OzF7H35ENUKDqfWs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 389/671] netvsc: unshare skb in VF rx handler
Date:   Thu, 16 Jan 2020 12:00:27 -0500
Message-Id: <20200116170509.12787-126-sashal@kernel.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 996ed04741467f6d1552440c92988b132a9487ec ]

The netvsc VF skb handler should make sure that skb is not
shared. Similar logic already exists in bonding and team device
drivers.

This is not an issue in practice because the VF devicex
does not send up shared skb's. But the netvsc driver
should do the right thing if it did.

Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1f9f7fcdb0eb..54670c9905c7 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2004,6 +2004,12 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 	struct netvsc_vf_pcpu_stats *pcpu_stats
 		 = this_cpu_ptr(ndev_ctx->vf_stats);
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return RX_HANDLER_CONSUMED;
+
+	*pskb = skb;
+
 	skb->dev = ndev;
 
 	u64_stats_update_begin(&pcpu_stats->syncp);
-- 
2.20.1

