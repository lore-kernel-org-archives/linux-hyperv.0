Return-Path: <SRS0=ieL1=DP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A169C43467
	for <linux-hyperv@archiver.kernel.org>; Thu,  8 Oct 2020 07:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC8A2087D
	for <linux-hyperv@archiver.kernel.org>; Thu,  8 Oct 2020 07:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="VMfLHPx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJHHSb (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 8 Oct 2020 03:18:31 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:18827 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHHSb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Oct 2020 03:18:31 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 03:18:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1602141509;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=L4CzWZOQiQW3zMHeD3EapvKb0btqyWUXDOgi93wCfiw=;
        b=VMfLHPx3noZRHceW1Foa7CvY4+O1LLXyhXAGbOEOYs9SY/GhnKRgtHiBacygSuh/0H
        JTmHDoCXpvlRgA2SO+lBZEf2CmHFQPvgAjiuDfViq7CotpCjBtDH8z36Ks/vBGVv8pfV
        sCaYLwTkMiaodwunPTi2/hta4Kqt+uq/DDDjpI/Pt9TMrvRCvF6mX0dgefG0keMhbf4s
        cRLWgRdq4seoi5Xce9nFDlekWg/CNbz+MLNu3srSIjJ1cBHd+p9fUKnXY1vWPmII1nTS
        21HlH6V8kltWx4dH2+KU8RVLL0OpWR/2J3iKeE1z3Iex8CF5/Ri2CXlDFdkc/tQ7MOmA
        P71Q==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS3G5Jjw=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id e003b5w987CLP0s
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 8 Oct 2020 09:12:21 +0200 (CEST)
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v1] hv_balloon: disable warning when floor reached
Date:   Thu,  8 Oct 2020 09:12:15 +0200
Message-Id: <20201008071216.16554-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

It is not an error if a the host requests to balloon down, but the VM
refuses to do so. Without this change a warning is logged in dmesg
every five minutes.

Fixes commit b3bb97b8a49f3

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 32e3bc0aa665..0f50295d0214 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1275,7 +1275,7 @@ static void balloon_up(struct work_struct *dummy)
 
 	/* Refuse to balloon below the floor. */
 	if (avail_pages < num_pages || avail_pages - num_pages < floor) {
-		pr_warn("Balloon request will be partially fulfilled. %s\n",
+		pr_info("Balloon request will be partially fulfilled. %s\n",
 			avail_pages < num_pages ? "Not enough memory." :
 			"Balloon floor reached.");
 
