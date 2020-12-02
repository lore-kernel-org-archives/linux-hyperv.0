Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6289DC64E7C
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Dec 2020 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C762223C
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Dec 2020 12:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgLBMxP (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:53:15 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLBMxN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 07:53:13 -0500
Received: from orion.localdomain ([77.7.48.174]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N9dkD-1k5RtV2atZ-015e18; Wed, 02 Dec 2020 13:50:08 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, mareklindner@neomailbox.ch,
        sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, roopa@nvidia.com,
        nikolay@nvidia.com, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, jmaloy@redhat.com, ying.xue@windriver.com,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 2/7] net: batman-adv: remove unneeded MODULE_VERSION() usage
Date:   Wed,  2 Dec 2020 13:49:54 +0100
Message-Id: <20201202124959.29209-2-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201202124959.29209-1-info@metux.net>
References: <20201202124959.29209-1-info@metux.net>
X-Provags-ID: V03:K1:DUL4jKGzzr4GDRYpSOZvdg3+oBNavI4NZ3c+c7VoFlZr3QBVtI6
 pCnnMOqrfI073hEGxYt3TAh/FtWaz+BcXw0fq50/DavncwJSlhPH/FAJM5195hsN383TZZd
 yQxlERfADNkYsjlaIKnlUOe324cJbM7mNbE0/wRzWC0EWCvjvc9YYM8/hkSxv3AAGuYCfFc
 /DIGG9V0tdkvTFP2OBVDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dc+pPFTZS7o=:tIKFv8a6BXOKHxV4rd5+Qv
 CUc7k/gKVAw5aoSMk6Oe3RL4jQFqQuOTnAhD3nIrZlvldDBNlsdbbw68IDuHBVOX2JbSs2GH+
 speZgRfK0R/CfQXDDIztrdAG2GxC8MHN0hDRSdi0OcvoBrtlVxSwjbuZ/fZPNhoSEz10GHnpU
 SBQjdEx0zAo2J7Ynp4Q0GqHNCJfOWkFZSxreTyeLtdM3vXbNtmBjn1jpGnj8g3DYbKcHaFeKV
 kr99Rz+kj5w46k30XtSpQjYIZrMNr8OMLZFBx/axINrufJcsm4upxXP85WRjAch038LDrbKx6
 yt2S7zUhuExIliLDQ8/QBQsU/2VBKpXHmoozAW/CjuWBVJlk50oMjTBnDarETWL0n/a/k7qxX
 yzRPAqHHVhv7+F+yyT8EaVWPPHTcm1bwRbuqY+OunuudHxUpcOiGwaX4XDgAe
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove MODULE_VERSION(), as it isn't needed at all: the only version
making sense is the kernel version.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 net/batman-adv/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 70fee9b42e25..1c2ccad94bf8 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -747,6 +747,5 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR(BATADV_DRIVER_AUTHOR);
 MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
 MODULE_SUPPORTED_DEVICE(BATADV_DRIVER_DEVICE);
-MODULE_VERSION(BATADV_SOURCE_VERSION);
 MODULE_ALIAS_RTNL_LINK("batadv");
 MODULE_ALIAS_GENL_FAMILY(BATADV_NL_NAME);
-- 
2.11.0

