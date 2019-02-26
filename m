Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53793C10F0B
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BCE217F9
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJyVc8Uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfBZMHy (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43181 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfBZMHx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so6119161pgq.10;
        Tue, 26 Feb 2019 04:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyPyWO4rNkGjA4881NI3n5pppHs1DoqsKQc13/GqFEI=;
        b=tJyVc8UhYrnjCb/hkChR4J5x6BU3tsnkLbw2AakuVTvQWCr3ir4XbtR7bj898iuqZY
         W40JDwV9CZeO/FTRE09+kNfVYUo1pS9dB3ML7HJnB5c4saG63JdQkGTkhda8JNRKGEUQ
         5fdC9EQZtf+6NNdQaewqLQS/jcOhHY8NfOzKpiiH1gBbyGzvq96LP8ftVwjMCVuzOxrN
         Ocias7SVDFA8zRl7J4Vm3b+vdIhbodTcYnwMhkGg7PgeC7jDLcxPCV46zslpeumNCcKp
         jN12C0OAh6MJ7BuAf7U8ehtiy5R5oLgdTe55Uf3mM2k1L5V3brtPHUGhoys+hGdym/Nj
         yDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyPyWO4rNkGjA4881NI3n5pppHs1DoqsKQc13/GqFEI=;
        b=FGF/TYn3/zvb1DjT4l28Z1QD8Vn/AcnZVNHcMlFmXArB8QGQpgH0Ff6XyBurETyQPU
         AHwHJLBFUpnhaJ/EbKK8EWkVEhZHYqC9bUk7C0T178IMRbJSP88LC1QrI5WsRG8/3bG7
         EFFJ+aOiK5MNnT5Xiq5QnzzK7kj2zCN9O13bvSy5ZS1CV6oQsFo/R6d/+plVIpedJ5MJ
         oYk62TVk1DWAzkJWjam5TG29o0fsnvmj84tN2DcDcIQivaCqdxjmPW+HMn8tjUIFC6Sm
         RjqK35+lnx1ytYAhjua3Ahg81d8eoJwWLHmMAEkZEpoqG6u2alW89qRau45xdpQeZFGN
         p1Yw==
X-Gm-Message-State: AHQUAuZnVz9DMRbnR3ueIPRUTd3tM3DfYHW+xTRGYfnCRiduOzjad7tq
        Ry/v1Z47OuxGrsFssVt9L9E=
X-Google-Smtp-Source: AHgI3IZ94KIi6M+mxjROPNIkt6P9vGGto8Q0dzJirzaGphb0r4XetNGd6S/vT9gTO4w7RNV9aI1l/A==
X-Received: by 2002:a62:1212:: with SMTP id a18mr25587619pfj.177.1551182873127;
        Tue, 26 Feb 2019 04:07:53 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e21sm30889423pfh.45.2019.02.26.04.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Feb 2019 04:07:52 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com, joro@8bytes.org,
        sashal@kernel.org, dan.carpenter@oracle.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [Resend PATCH V5 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope
Date:   Tue, 26 Feb 2019 20:07:20 +0800
Message-Id: <1551182840-15069-4-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com>
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

