Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BCBC4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AAA217D4
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N94eNoEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDEBTU (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:19:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33195 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDEBTU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 21:19:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so2102273plo.0;
        Thu, 04 Apr 2019 18:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MjJ+/VCasb87xuya0ajNHcY368TAHJh1oTyxs8T+FF8=;
        b=N94eNoENGdv7ajtDeK8QwR8+Tu/9Z4wKDvHS+ZPwaDGGtvuBWhcAR1gCno5TtMKU3a
         oGmT+od36mGp7iWlpxyOCuRKdGdBC/0Ybv34ey3cZMblkiSLrQUEthEwiKtL+RozPSIq
         a+0dgcqjfvhtacds/QbUpBcUWXBn6l/vQbcTZzSwiAioExfGTqK2EBNX0T44FjPiWqFT
         nUqo0xqlRemB9rwMJa13lcHrZzhjcXjVxJj3VLKAVAkxF+WptRJugM8LQemq/yytW/cd
         oFOzXPRMmpUZVtAZ3Nf6Wvoi44SXpQue0r54/HjjyXEgdzf5iMBrSv4jWeo6QxCyD5QY
         Nagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MjJ+/VCasb87xuya0ajNHcY368TAHJh1oTyxs8T+FF8=;
        b=gGnOH8o2FPIwpO3sh35hs7SMHvIUoxICuu/zjxVFjz/7b3xTMsUtszaZNEtv78CA3W
         0W8qDurV/NVmUHOoT4WDNEhOBxcsgXgd1O/x99r920MnKfpQTw0c1yWGkwUttF5cXB46
         YP9rrZj97/5xdXcpPEJqCyMYBhumBvv6Juc7qXYcpYIKd1IBO0wnwkWU48P1n0YYUVGw
         zOUFQfcBQlAISC7ipv3Fc9kWCCrjfzygSH7jHpZYc6x4rC259lcjp5B0G9LhPIQ6By6X
         1BevRyQpCwAj/CjurK5HS4AOY/cplW2sRpGlNV8GrGMkyWM7bpVZRWk8/cLzj6VavX/v
         29aQ==
X-Gm-Message-State: APjAAAWsEJ7FtxReg14rmS6pRScyM4KBpTO9pm802E2dZAGuEvfXbpFe
        bXLTkS02ovlZP3nIX3Mn5REoXTEYOzzyVw==
X-Google-Smtp-Source: APXvYqytchKq5SQPjQ/5tKpRW9OSsmEITdARMHmLQ0z7uxyaSnutdxbTp36Tx+aHNxevMdA6n2MHkQ==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr6329327plq.138.1554427159599;
        Thu, 04 Apr 2019 18:19:19 -0700 (PDT)
Received: from maya190131 ([52.250.109.216])
        by smtp.gmail.com with ESMTPSA id f3sm35097882pfn.100.2019.04.04.18.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 18:19:19 -0700 (PDT)
Date:   Fri, 5 Apr 2019 01:19:18 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] HID: hv: Remove dependencies on PAGE_SIZE for ring buffer
Message-ID: <4d5599a835c1ce37b5def62543ea9c9fe3f30329.1554426040.git.m.maya.nakamura@gmail.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554426039.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Define the ring buffer size as a constant expression because it should
not depend on the guest page size.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 drivers/hid/hid-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 704049e62d58..4d0b63bf8b33 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -112,8 +112,8 @@ struct synthhid_input_report {
 
 #pragma pack(pop)
 
-#define INPUTVSC_SEND_RING_BUFFER_SIZE		(10*PAGE_SIZE)
-#define INPUTVSC_RECV_RING_BUFFER_SIZE		(10*PAGE_SIZE)
+#define INPUTVSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define INPUTVSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 
 enum pipe_prot_msg_type {
-- 
2.17.1

