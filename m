Return-Path: <SRS0=/bEP=RR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC096C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 20:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C83D2082F
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 20:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYuDqEDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfCNUFM (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:05:12 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54628 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCNUFM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Mar 2019 16:05:12 -0400
Received: by mail-it1-f193.google.com with SMTP id w18so6731005itj.4;
        Thu, 14 Mar 2019 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YzEHB5aWwddSacdYRHdX6XA8+uBycjteGJ3ShNLj/h8=;
        b=fYuDqEDqaFllJimzzH4XOIal12h3MYLDQXRZKYam6QylBveXFnAvrk1Pfcoj68ZHu2
         k/AGlZIwkpfbd86H0bflsFlKjur3mKbk20q5k5t8nEvnGhoMDABxN4VFgITnFCtd8aCj
         OCMjty2gI7V+0l98YQQazQS3PY2TSrqo83CklENE6lU/LeHMbctb/kGGhEDFw1wQY6J3
         Q3vGOOXflQ01Dn8amDviUvY1Bs3TmF2vX8PEZ1udKCyqAsuhWxQvbmcgn+OI79l5o5bN
         wOd91zUv7lklO3NEaPUIpuSeG8kPUkb9Rp3cSlrHOsC0BIzUmLJv1pfq95lThTqtVc+v
         T/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzEHB5aWwddSacdYRHdX6XA8+uBycjteGJ3ShNLj/h8=;
        b=dv610K7biAKXJ56Ypz2LOorHuSW9YWtxsZG4eGz7DPw0gt9Ezor1h4P2tzFioGWXI1
         qA42xgNFKZGQQWKZPXJ9DG9euMbi1Y4yRWxdCPBDXDJQCBZqgVmpU/Dn8aiy26thWixT
         3fcxAcV91XqCliUqV4jwWH/srcD9EuVQgKTgJwWP6vpQ4o24fU4atUTEw45pQl+gvo8C
         pg5JmB2aw8lol6AVpNvXxOQM0EMd8vV9E1Je8G7ZR6oy6w+n2emSy9qmHjjETDp9f1ND
         KLrNfvJH5QnqWHUWcP9zGAxhcYrEO21YiFcg79exhtke6XiS7Xu4Zt2BST91vPf+xAs/
         kapg==
X-Gm-Message-State: APjAAAU5JrDgBgwvRVSgS82PGXQxI/QywawPLf+KeHfU018Gc948p9wC
        GBkkX5m2yfn2v4enlRIhbHw=
X-Google-Smtp-Source: APXvYqx4/u7fqsCeU0tdJ2C7+5usj/VXrA0xXklmm/GMGUeWXBZq8o/+PIYg1N8hCg2BeIaY9NMdQQ==
X-Received: by 2002:a24:9491:: with SMTP id j139mr189689ite.9.1552593910743;
        Thu, 14 Mar 2019 13:05:10 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id k133sm1719566itk.9.2019.03.14.13.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 13:05:10 -0700 (PDT)
Date:   Thu, 14 Mar 2019 16:05:07 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Drivers: hv: vmbus: Set ring_info field to 0 and
 remove memset
Message-ID: <b9b604327b885d82ddad2991f55d1b54be6eb1c8.1552592620.git.kimbrownkd@gmail.com>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552592620.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Set "ring_info->priv_read_index" to 0. Now, all of ring_info's fields
are explicitly set in this function. The memset() call is no longer
necessary, so remove it.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 drivers/hv/ring_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 9e8b31ccc142..0386ff48c5ea 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -197,8 +197,6 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	BUILD_BUG_ON((sizeof(struct hv_ring_buffer) != PAGE_SIZE));
 
-	memset(ring_info, 0, sizeof(struct hv_ring_buffer_info));
-
 	/*
 	 * First page holds struct hv_ring_buffer, do wraparound mapping for
 	 * the rest.
@@ -232,6 +230,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		reciprocal_value(ring_info->ring_size / 10);
 	ring_info->ring_datasize = ring_info->ring_size -
 		sizeof(struct hv_ring_buffer);
+	ring_info->priv_read_index = 0;
 
 	spin_lock_init(&ring_info->ring_lock);
 
-- 
2.17.1

