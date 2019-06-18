Return-Path: <SRS0=Fjb5=UR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9569EC31E51
	for <linux-hyperv@archiver.kernel.org>; Tue, 18 Jun 2019 06:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6882120652
	for <linux-hyperv@archiver.kernel.org>; Tue, 18 Jun 2019 06:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+DeHlH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfFRGpX (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:45:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfFRGpW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 02:45:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so3048444plb.9;
        Mon, 17 Jun 2019 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZ8XQcqFPiBgKnC9B3u3J7ZO1DNl4k/Ar4Bg2fpOBFk=;
        b=g+DeHlH3i22he3fU6/lH59AjJFzbciZYgDVDBDw2FQtFbNaEDquenyOb5vVGobtuJp
         1t+LiL0ZrN0nOfgnignrVMCO6D5na5B03ayBT+oU5h+zo3Y+Pzgcn1N5ZEhKZKmK/yAW
         qfDD/ds9scJIRzAuGC4x1ux7iQYll2fRNMQjWtqZgkwinJM0laBPTDrYaJFsYq2MDhuS
         Z5i0y8kgn3LZlUTgSM6w2kKpZHV70EjZ0GOYpLnjC0oSzA7utzwlmH34r9canOfHoPVN
         RZrDbodnXpnz9s9Y9+vw89HRGjM1SFSq1sKYDNwfuL5rU05ZHu0PN7JkJuicg00yPURR
         qzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZ8XQcqFPiBgKnC9B3u3J7ZO1DNl4k/Ar4Bg2fpOBFk=;
        b=rUKeJNMsZFQY+zAlNVvnOyZ5IG5uFBz95/KGu2mlit9f03UV2tn/uKbzntl2qiFJP8
         ipPvol2AlWrbZ1Hq9d/aiIRIMS5T+4+w+mpxr7pM1hPYG5csnQkJcy+HodUCtoJNzoE+
         aDdkDQpcT9vf2CIce3SY+NK2TtFdq4NYOlIhl7QkhMnnV8kejz82vfpKpv+oRXzA0YIN
         oCgkw5YVyGDLuXoj0sW1KKZngOyW7UIanxWPQWBG/8jdHbciQsXOysk4dFTu5viOSj6+
         weA+zEOXxTk+7KEOAYZC3PHuygMjSByn+8pJXriQa5PSLSevx2NfI+Re1jV8AiEsIWhT
         bpJg==
X-Gm-Message-State: APjAAAXOOOeXPX2Ou9SJ56YrTzQXR2eRmy7zHqUAGp1cEkNZCDFS+bfs
        IRH44pDtNwVzdyV57IbCRS25OmRMFSM=
X-Google-Smtp-Source: APXvYqz7xoZJqn7yLoEwJtmtpeY0s0NA0MhsdA1HFNqdRLk0rNzXAzouA2aKGFczPZUqsPXPpSKFeA==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr34477675plp.168.1560838555927;
        Mon, 17 Jun 2019 23:15:55 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id g5sm21029593pfm.54.2019.06.17.23.15.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 23:15:55 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:15:55 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] HID: hv: Remove dependencies on PAGE_SIZE for ring
 buffer
Message-ID: <8e244063840664b7d54d545e73e9c6d83f7913e6.1560837096.git.m.maya.nakamura@gmail.com>
References: <cover.1560837096.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560837096.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Define the ring buffer size as a constant expression because it should
not depend on the guest page size.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hid/hid-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 7795831d37c2..cc5b09b87ab0 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -104,8 +104,8 @@ struct synthhid_input_report {
 
 #pragma pack(pop)
 
-#define INPUTVSC_SEND_RING_BUFFER_SIZE		(10*PAGE_SIZE)
-#define INPUTVSC_RECV_RING_BUFFER_SIZE		(10*PAGE_SIZE)
+#define INPUTVSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define INPUTVSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 
 enum pipe_prot_msg_type {
-- 
2.17.1

