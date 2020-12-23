Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D43C43332
	for <linux-hyperv@archiver.kernel.org>; Wed, 23 Dec 2020 02:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7C2245C
	for <linux-hyperv@archiver.kernel.org>; Wed, 23 Dec 2020 02:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgLWCYZ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbgLWCYY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 21:24:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84E66229C5;
        Wed, 23 Dec 2020 02:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690223;
        bh=Df0DxbSAYSyYMU6NKNk1/U88ie/hjegk9tYCULiAtNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0aKETvTlnWOjI7jAKw+T/7olhy6+jWSpTK9C5InuSCzbhhtCgtXNG9mF2aABv2qd
         5EKgMcgWeRtJLOMyPTaoQSl/FqptRaUcpeYM4ZH6NoS1jsULNBYA7+XcFTOQwD60rO
         UmTjtEdtt1ejY60siZaXAcEmDvxIOmTkfw2FlWNZijhk1XgrdvnIqaf7UE6t8f6aqb
         kSRgb9M7VHubQNVoOMcO8Oc7o23dMyK43xFC9xKCgqFSaLguEtLfur4yt0krYTM2mq
         fS5i0qhloe0d+FiN6K6fmjGkcIj/knkkZWWyYu2lMLiwuaLB3mCa98hTdJIh9an2Vd
         ByMnlJnW9++WQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 40/66] hv_netvsc: Validate number of allocated sub-channels
Date:   Tue, 22 Dec 2020 21:22:26 -0500
Message-Id: <20201223022253.2793452-40-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022253.2793452-1-sashal@kernel.org>
References: <20201223022253.2793452-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>

[ Upstream commit 206ad34d52a2f1205c84d08c12fc116aad0eb407 ]

Lack of validation could lead to out-of-bound reads and information
leaks (cf. usage of nvdev->chan_table[]).  Check that the number of
allocated sub-channels fits into the expected range.

Suggested-by: Saruhan Karademir <skarade@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/r/20201118153310.112404-1-parri.andrea@gmail.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/rndis_filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index aa0bbffe49005..1db34b7a423ef 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1100,6 +1100,11 @@ int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev)
 		return -EIO;
 	}
 
+	/* Check that number of allocated sub channel is within the expected range */
+	if (init_packet->msg.v5_msg.subchn_comp.num_subchannels > nvdev->num_chn - 1) {
+		netdev_err(ndev, "invalid number of allocated sub channel\n");
+		return -EINVAL;
+	}
 	nvdev->num_chn = 1 +
 		init_packet->msg.v5_msg.subchn_comp.num_subchannels;
 
-- 
2.27.0

