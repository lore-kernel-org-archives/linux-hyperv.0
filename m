Return-Path: <SRS0=Gp0b=RC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A89C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9999E217F5
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlUq2YXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfB0Oyu (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:54:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37875 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfB0Oyu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 09:54:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so8083860pgq.4;
        Wed, 27 Feb 2019 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyPyWO4rNkGjA4881NI3n5pppHs1DoqsKQc13/GqFEI=;
        b=rlUq2YXjjq/L9pBNQgIp8sbNNZOOsVMXgf0xpDSkRIbde1ZYomy6Oosw0uYNOOK0Wp
         m/9/bLnGExtiDkm/29qgFax7hmogrQOxwVu9pJdg+qVMiu+Ln0MBd5BG68NtbDiq4wfU
         Mafj1yxmQa/kYrOf+RZHtfhak5DxutPeyqsBhq7ejW12pahNRFISfsgoU6jdaoNVOEqY
         f+3RVIPAFhlVm2uC3+oS5oWiP9+mtBASonaJFzHGEDBo+JyOWJMuPHUg41eEKpT+qVFQ
         bvTHiwNlTA3OW90se/60WeX6jNGPLnu/Z/lDp18iQOJbmyVSOZUnc9zf1CPxInTVtbiz
         acnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyPyWO4rNkGjA4881NI3n5pppHs1DoqsKQc13/GqFEI=;
        b=s0IGXTJKidrCLBuKSt4DD6imR4B31HY1Yp38aR050wta1ZQQ3jUqQBm5FtrtPG5xGb
         f1Bgp0l8GFXvNlZWWCy6ha75m4/e0rS4fuA7nRmPAnVpDWeqdsZcRz2QMW3A9dK4bl7j
         RnoQ3ZU3Ex/GgYOTD0fj/dX37YqqGwUtal+2VpROuIwNsX7ya62y2HIqaiIlipBbYwAV
         HfEz51uWcFrMW0cGV8st3nKeaFN7nwug2M5ayEW0dSEQ7ra4R5eO4c+1vn2GME3+xfaw
         dwU+tcdjTgZ904omRvbj6AG9zTpgipNhRE++wu1wWpizhMWoEZTMrYQGG7HfQX3s0GAa
         RE0A==
X-Gm-Message-State: AHQUAuZCPMgQvfZ1tuTCBfUdb9YvaIpjYndvjExx6xpzgJEajDWoFAYm
        WyKmuXIEoHtbNh2gRwBUsCU=
X-Google-Smtp-Source: AHgI3Ia00D1xAgqsNV9TiDZnK54Lhoki95fjDZyFTLVwlrCPngdG46X6HUc8Pl3XLOm/O8E12NLs8g==
X-Received: by 2002:a63:ed0b:: with SMTP id d11mr3301869pgi.435.1551279289418;
        Wed, 27 Feb 2019 06:54:49 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id 63sm29618135pfy.110.2019.02.27.06.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 06:54:48 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com, joro@8bytes.org,
        sashal@kernel.org, dan.carpenter@oracle.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH V6 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope
Date:   Wed, 27 Feb 2019 22:54:05 +0800
Message-Id: <1551279245-25888-4-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add Hyper-V IOMMU driver file into Hyper-V CORE and
DRIVERS scope.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f64f8d..5fb6306 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7015,6 +7015,7 @@ F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
+F:	drivers/iommu/hyperv_iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
-- 
2.7.4

