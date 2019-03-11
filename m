Return-Path: <SRS0=nv2F=RO=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E64C43381
	for <linux-hyperv@archiver.kernel.org>; Mon, 11 Mar 2019 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC672206DF
	for <linux-hyperv@archiver.kernel.org>; Mon, 11 Mar 2019 07:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jV4CgfA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCKHXv (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:23:51 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:59330 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKHXv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Mar 2019 03:23:51 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 03:23:50 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 16C6DB74
        for <linux-hyperv@vger.kernel.org>; Mon, 11 Mar 2019 07:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uJ6kY6-2SE8S for <linux-hyperv@vger.kernel.org>;
        Mon, 11 Mar 2019 02:17:20 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id DC2ADB5D
        for <linux-hyperv@vger.kernel.org>; Mon, 11 Mar 2019 02:17:20 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id v12so4299374itv.9
        for <linux-hyperv@vger.kernel.org>; Mon, 11 Mar 2019 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GfdWM9SSU7KfpdKIZzPpOpuTjbGIrvUY//TTRkRyo1k=;
        b=jV4CgfA6f2NefhvsNAU/w+b5T4RciwZ5dS2A3aL6ae2pRzAxY7i15mvt8wExlwQV0r
         kR/sXSuBNw/Ak/5wvSW33yV+nOAy0L8VIdl9n1/tqAXJgYcIpKPXJ7yRI+isnC9Pv91n
         XElnjo1se8m04cFtnKF2R5PIfUjmu98QmNHkRR8d0dP3nlqB+ria6/tczrfPgE3Wd5SA
         eH1590NEX8Qc/oYN085b9KFbl9UOGrJ8TAMfKUjCCnbkjdz0qnrvrHxfGf3NMAs0bfrB
         z6DPGQX2k9nGlaD5xToVyrEHsimyawsu1JQxrMmqfjkLUyhQyvL4y24GJ7420DsApHQt
         Qb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GfdWM9SSU7KfpdKIZzPpOpuTjbGIrvUY//TTRkRyo1k=;
        b=SMUsQi136403LtWnERbLAlpyQmqBF27ydDhCr/xtL4MFrypo2uBwTJ6zELk5Txk8n2
         MBPGjMhBFweiHAbdAjQ8TNfqiBzUmMyWuf72VImcYfU6zQCKFMLz/MW9MPymWes5DAmN
         1Jk0oow5opB7mfYhoeJ3eMtlrJcAI1xKAFrdtb5NsjfasLzRXdlQH2ltYzrRHSlb8mDR
         uCpf+EsMeHBRlTIzFLH07VpF7yz2qvPXCgP7TPL9mlH17ycCXXq48I01OwVZIN/wcYcC
         T/XIWy3Kk7xK8wHsb8S/AyizcLHTGnfKJngt/vVqxy+cKSVylDVonPuyDfbvyr9qXfOj
         rvtw==
X-Gm-Message-State: APjAAAV5WhsgxH7wPd4SPfgQgROQ8PPJRqbEVmWomET+gd24k/Wn8QAO
        d02lBTq2+N1SRWqP9yB4/TD5+pQqkfItLXa9Fok5Z74BDxUTjLHhKA1JKyqkZ8ySsXpwnlWDf+I
        lAboXpAWXJ5LI1ZKn+4h9m8fFJNKg
X-Received: by 2002:a24:304a:: with SMTP id q71mr14174678itq.4.1552288640458;
        Mon, 11 Mar 2019 00:17:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzhgP+5Pcqts1uhb1NOGNfIh7ZtlSVnPxZ14MmPbLw70Gon2mCf3VtNmkYbdnowiHzSx5/Hpw==
X-Received: by 2002:a24:304a:: with SMTP id q71mr14174664itq.4.1552288640200;
        Mon, 11 Mar 2019 00:17:20 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y10sm2103420iom.9.2019.03.11.00.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:17:19 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: hyperv: fix a NULL pointer dereference
Date:   Mon, 11 Mar 2019 02:17:14 -0500
Message-Id: <20190311071714.28631-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In case kvmalloc_array fails, we should stop using it to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index cf4897043e83..4b3a03029fe8 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1426,6 +1426,9 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 	pcpu_sum = kvmalloc_array(num_possible_cpus(),
 				  sizeof(struct netvsc_ethtool_pcpu_stats),
 				  GFP_KERNEL);
+	if (!pcpu_sum)
+		return;
+
 	netvsc_get_pcpu_stats(dev, pcpu_sum);
 	for_each_present_cpu(cpu) {
 		struct netvsc_ethtool_pcpu_stats *this_sum = &pcpu_sum[cpu];
-- 
2.17.1

