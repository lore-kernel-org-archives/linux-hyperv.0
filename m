Return-Path: <SRS0=DBVS=6U=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D584FC28CBC
	for <linux-hyperv@archiver.kernel.org>; Wed,  6 May 2020 16:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0575208CA
	for <linux-hyperv@archiver.kernel.org>; Wed,  6 May 2020 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588781292;
	bh=ayuwIV50Cs9v+urgIKa4LpRwdjMuo9qV+UjzqNRQlnA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lReCXQncbS2rZDN4cxJoYZ94IMhM/GT8fUk/GR/3BK/K1d8emHIJ0tinAJXTKWwkd
	 DtC0ifnLQ1zq4wVUkfc9sVnqODBiuLIyN2ltcZWV9LktFdjfQ39p5T82OdV0n8h8dG
	 VqK2Qun31CBX77LWORYPRQi8Eb3HNslI+LfavRHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEFQIM (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 6 May 2020 12:08:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35300 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgEFQIM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 May 2020 12:08:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id r26so3374464wmh.0;
        Wed, 06 May 2020 09:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HG4juwLkpA3lPMHgXzAH+5UcLg1AB2lQeps7Ou5A7I4=;
        b=hs2Eew4EbrR7fqyTeQR7qgvilYC6hKFlj84PKVvxTFd8yOSwHC/X4xCsSh9FSfX/r/
         9vkEpIp6zV9Jou58gp71q8+eiwa8n6iYp3n2bfdX9ZcYhPTiHATOi+W7bjTKT/gsuGSi
         T8msLpjxc1x1R2G00UVsETtsJqdSISsPT/mm3QakFxyMTqig8RfvIUJ+v+k2JIedoX/z
         qCpqSK+8r/3vHSl02amhWL03Du2GtSejBHOsdNjgk0oJ1R2eK+oFvLdKXn+qCU2zlLLe
         mMC8RGkJPG/gQReJViKgOftjlQowEthwqspBKxPb/80fpAMRm3QFn9CeIozpGdUtgdNw
         EY+w==
X-Gm-Message-State: AGi0Pubuykj06ILspGZf48tZB6zKh1br9Qja3omdfk7tuEeRfVDg7p4a
        sw3uvb5Yn8XuqB/OB6Llb0LncwaS
X-Google-Smtp-Source: APiQypJ9Msc2eoTwoHeh58vNZgD8yGEzKZTMjuCYxPO32gZYLSHjNsJdk1SWChD6SLVoOZODPfseYA==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr5648769wmj.137.1588781289856;
        Wed, 06 May 2020 09:08:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l16sm3355699wrp.91.2020.05.06.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:08:09 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] Driver: hv: vmbus: drop a no long applicable comment
Date:   Wed,  6 May 2020 16:08:05 +0000
Message-Id: <20200506160806.118965-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

None of the things mentioned in the comment is initialized in hv_init.
They've been moved elsewhere.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/vmbus_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3a27f6c5f3de..7efdcadc335e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1396,7 +1396,6 @@ static int vmbus_bus_init(void)
 {
 	int ret;
 
-	/* Hypervisor initialization...setup hypercall page..etc */
 	ret = hv_init();
 	if (ret != 0) {
 		pr_err("Unable to initialize the hypervisor - 0x%x\n", ret);
-- 
2.20.1

