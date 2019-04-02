Return-Path: <SRS0=Cz6W=SE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DAC4360F
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Apr 2019 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0792070B
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Apr 2019 14:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds6lyNlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfDBOND (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:13:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34812 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOND (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Apr 2019 10:13:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so6459136pfd.1;
        Tue, 02 Apr 2019 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hnOwdjxBlqNg7VVcRE/8zfPc8TAr8TXpOT6LOY3G4o=;
        b=Ds6lyNlwphhXHT/y7a/K0YfLwcunPEf6SojJZ89eDyl02SIpIMr/AmmWzZ4tHRY8MX
         ru16fW4Fy2T5QwxbY2TMmQR1cfo11YBzP6ODfV70TJPVSC+/AMhZwDES/3gq57OzHsCr
         TkgtYloz/SgpV7FC0HFxN5u7aLzOOHL3f+mBds5/TuyiLVdH94YSdqeNO1Lkh9sAPnM4
         N7txlgms6sEVKayvqS0oteJr5aqVLbdBJpFtCF3QmyRNaaX5jxlk8QZqE/5cAvEUqSH+
         Y1shfdcg2pMg3S4HDzb9NZXzuwjWscxQ1tDCWTr/YSFbPeONzCrnxibzHgvuxCRYPWKx
         Cv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hnOwdjxBlqNg7VVcRE/8zfPc8TAr8TXpOT6LOY3G4o=;
        b=H8qbFt90gEIAx20fd1cdCSZ1ODL5LlMa8+fQeOrtPb0iIX2+3WgDtTvQuq+l8piQL0
         kKJvtAqvKZQQasYoV7WdWuYzJaj5SWNDSLSG51EFIRvBdJkSXqJr8Im04ui29bUJudj0
         qa1hYCHPLgoFi7YXQ186lAgAG8IFh9BgEBO/Y+vSL5vjLRfJQOfnYPYzlnczHXZ/m8+y
         ua/rAeSJK5jV55E4JFMOkfpxRXM1LfO5OR9IBMUgel3xhL/YY5kBifIwccT1Y0/SCY6M
         qaLcK5onW2FTBh6bukx2oNcQyU2eU6xDVUnXCDZ/Z329iIjEX0pImde40ONTTeLKyoVi
         OR7g==
X-Gm-Message-State: APjAAAXRWsldHnkPgAUAVTAoNjOvkK1mxJYFWH0w9/gpp4Sfbfz++aW6
        LbdMSHRTflZknga0pQBS93o=
X-Google-Smtp-Source: APXvYqxuaBKoeAgLVDxk/VT+gKkQ3JDb6ApBCpzEiCiQrHUJwmEArHIwMhd1CwB18qNmeVVrW/g5pw==
X-Received: by 2002:a63:2a8f:: with SMTP id q137mr66340969pgq.31.1554214382126;
        Tue, 02 Apr 2019 07:13:02 -0700 (PDT)
Received: from zhlao-linux.corp.microsoft.com ([167.220.232.97])
        by smtp.gmail.com with ESMTPSA id p34sm15940286pgb.18.2019.04.02.07.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:13:01 -0700 (PDT)
From:   Zhongcheng Lao <laozhongcheng@gmail.com>
X-Google-Original-From: Zhongcheng Lao <Zhongcheng.Lao@microsoft.com>
To:     haiyangz@microsoft.com
Cc:     Zhongcheng Lao <Zhongcheng.Lao@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Do not overwrite CFLAG passed into makefile
Date:   Tue,  2 Apr 2019 22:11:22 +0800
Message-Id: <20190402141123.97941-1-Zhongcheng.Lao@microsoft.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

It is necessary to pass a custom value for KVP_SCRIPTS_PATH
because of the directory structure differences in Linux distros.
Current makefile does not allow this.

The patch fixes the issue.

Signed-off-by: Zhongcheng Lao <Zhongcheng.Lao@microsoft.com>
---
 tools/hv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 5db5e62cebda..058c3dbb7824 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Hyper-V tools
 
 WARNINGS = -Wall -Wextra
-CFLAGS = $(WARNINGS) -g $(shell getconf LFS_CFLAGS)
+CFLAGS += $(WARNINGS) -g $(shell getconf LFS_CFLAGS)
 
 CFLAGS += -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
 
-- 
2.21.0

