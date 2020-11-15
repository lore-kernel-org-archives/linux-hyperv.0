Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C03CC2D0E4
	for <linux-hyperv@archiver.kernel.org>; Sun, 15 Nov 2020 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8F1223C7
	for <linux-hyperv@archiver.kernel.org>; Sun, 15 Nov 2020 20:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="r60dmg+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgKOUqp (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 15 Nov 2020 15:46:45 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.206]:15210 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727317AbgKOUqp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 15:46:45 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 15:46:44 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 485542EFF
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 13:58:45 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id eOAfkcexmAAk4eOAfkAQUA; Sun, 15 Nov 2020 13:58:45 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rFcOP8UWegi27SgLGGK/1FD40QNsTlzehhrgLClCyW8=; b=r60dmg+3VJ08/+ivsUeiC93GvI
        JP2+3Dmr8EcYyusEvFW5FXZ9+gSyQv7o4Grg+8dNey7vIkZTetCTkmJjW0o1T5+1HRIYOZIzaqY8G
        CiChPUX/AjfOCUodElH/Gyk65kuofufyEQdklXaA0/prhL1IuRq53zLEL34//c8fm1qqIECQ0wUFR
        g9ZFcZywa5O/MiMFgs9Fd8XX7Uvzzdoz0WqwZ/UBnHbBQfxHP2scU5XKkZGyTLUDr2hNyPs8m3ceC
        wk/9R362AD/nrfzJMIlVr4I1mwuOi0yW+IgJNSHFEoHS/9nvYQay0dnr5hEZTlewIiPv0x/Gz4xAj
        AR16Hlgw==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50406 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1keOAe-000kPb-NR; Sun, 15 Nov 2020 16:58:45 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, sunilmut@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 6/6] drivers: hv: vmbus: Fix call msleep using < 20ms
Date:   Sun, 15 Nov 2020 16:57:34 -0300
Message-Id: <20201115195734.8338-7-matheus@castello.eng.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115195734.8338-1-matheus@castello.eng.br>
References: <20201115195734.8338-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1keOAe-000kPb-NR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50406
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 76
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixed checkpatch warning: MSLEEP: msleep < 20ms can sleep for up to
20ms; see Documentation/timers/timers-howto.rst

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 774b88dd0e15..cf49c0c01206 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2382,7 +2382,7 @@ static int vmbus_bus_suspend(struct device *dev)
 		 * We wait here until the completion of any channel
 		 * offers that are currently in progress.
 		 */
-		msleep(1);
+		usleep_range(1000, 2000);
 	}

 	mutex_lock(&vmbus_connection.channel_mutex);
--
2.28.0

