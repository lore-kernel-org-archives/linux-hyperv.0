Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82982C4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50276217D4
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyrDgHSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfDEBUP (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:20:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDEBUO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 21:20:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so2292678pfm.11;
        Thu, 04 Apr 2019 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EHHQVi3LQPZBfRpS1JEOnovkUyu0MTyaAKCg+qDo4jE=;
        b=jyrDgHSVTW0UFZlspNYgUspZGpO/EMgr3FAIvrTRSkIppdW1YaiVwe/z0xV5Kdfu8g
         WIvhjiR7SIju2r2AkQe/2xg57gw2Ylt59t+J9WWnR6Sf4S0aE+nCynAnodmheY3vzCUq
         nEIEtu+PA0D/Dk325cjUD//fj63kaOALRI8RqK9WMPgaU5++MF3FAf5DlISVghkE1oMr
         LJXFnB0d5O6w5Q5NJXs4LsCYlyyGNOSnMKxvFMmOvICtrFfzR8OTNBRr4U32ixhmF1lz
         ThvqDJvY2iwn+nXnygD4oz7U+r+VZV31tQIdAeJ0OcevfqAwPKE2uQYu1jmzzqcsXB4A
         9l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EHHQVi3LQPZBfRpS1JEOnovkUyu0MTyaAKCg+qDo4jE=;
        b=nZ4cz9v5FJ5WpJzVwucQABjZBEkA8+KYjMBrCheDkOtTlqLJw36hjYpdG5YH477HMy
         /uMTk9BLskE/aUNPMZ7GGYGHChP72l+MDxKsjm6qBM51OQrrwdMGT29lE6NQI8pk51p1
         w/b+yqteLzSENvZGJau6yn0rMRU3w+Gxg2aEuiVUvQnEFiZmhyZtXa4vwW/19MMo3Srg
         YImxG9xPwE0boKS8oav18ads1FWBkJJ3H0HwcN1ONizq8e0oEhVhmkwXK9buVz1R1yh5
         1MzPf0AIwmMj3p2Z0xCiadnVi5xhNVXRbUguZmVt1zxriggr3MM/4BMQkzU1W2nHEbQD
         /mtA==
X-Gm-Message-State: APjAAAUF9YoF+jIiDAax5C3Qc1j1jQbGvLMqQbHWPRB658zykCJoi1wM
        DjLDbf8VBUyEkwUyyCFN5S14Ub94kDx6Bg==
X-Google-Smtp-Source: APXvYqzWLU98SxIBcZ2Q4zB3ZacCJybgwTzGfqEiEwmagQxnXuRto4Jbjy1DDcogtiqkj+kHLFoyTA==
X-Received: by 2002:a63:1359:: with SMTP id 25mr8897695pgt.92.1554427210757;
        Thu, 04 Apr 2019 18:20:10 -0700 (PDT)
Received: from maya190131 ([52.250.109.216])
        by smtp.gmail.com with ESMTPSA id q128sm26774366pga.60.2019.04.04.18.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 18:20:10 -0700 (PDT)
Date:   Fri, 5 Apr 2019 01:20:09 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] Input: hv: Remove dependencies on PAGE_SIZE for ring
 buffer
Message-ID: <4e14060e33f731728e658262b6ecfe3b11277e7e.1554426040.git.m.maya.nakamura@gmail.com>
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
 drivers/input/serio/hyperv-keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index a8b9be3e28db..e1b0feeaeb91 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -83,8 +83,8 @@ struct synth_kbd_keystroke {
 
 #define HK_MAXIMUM_MESSAGE_SIZE 256
 
-#define KBD_VSC_SEND_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
-#define KBD_VSC_RECV_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
+#define KBD_VSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define KBD_VSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 #define XTKBD_EMUL0     0xe0
 #define XTKBD_EMUL1     0xe1
-- 
2.17.1

