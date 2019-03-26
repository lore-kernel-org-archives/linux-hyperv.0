Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CBC43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 06:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6584320856
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 06:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3tr4I3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfCZG2c (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:28:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37942 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZG2c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 02:28:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so1149496plb.5;
        Mon, 25 Mar 2019 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9klk9DlyPNX6ZYfIChAqq8jdp3QwCHVRJFf8Xe5M+PU=;
        b=o3tr4I3fu98XpgbdXY3MbFjsf36sDedDYTqOYZriNzQ21G6mXd4ZsNeyNOBEDqrYuD
         L2XkewXa0bWHkS2rBOmWrA098acUvKbeYN29Gd3rPqbdttzu0kDBf1QfJUwmH9V9gAUL
         U3SCwf3RlE2hTzNQlpcWeqNV12qHyAFs4sjD0rGXmy3tQDGvfs5psYOsUzuBrxMxUmh+
         IgHddDrs6fTCcmamAz0So8b6J7T5sGn6jEskRhPPAkhXsKK3HPu7/Wnh97LnARTpZ0q6
         qpy+1NxYxIxsmVOqpcSjIEjki4xkyr5H4nYb3RWEJ3VzDaK2mxc2ttfR6Rsblb+ZM+1A
         qRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9klk9DlyPNX6ZYfIChAqq8jdp3QwCHVRJFf8Xe5M+PU=;
        b=ovxOKbDSVSbZHtdvaWIDw4mwL6CXYmB5YT4Qa/6/TuHhlZ90QzefDFoAkSCPok++Kf
         /U0aCX/be5qk3A8BfynjJrlWpXltA6ckfrIQpGnWPhklqFPo4sahCFeOHLDWmHpYcRwh
         Y//OBndCpE3+4FV4WCY3hmXqvO6+/fIjI8LdZIomCTFREX8VIZQUGc1kFAJSJKKAS1Ob
         7f8PXSCqxl1ARkpObTzkd/SBElAAvxLcar2lz5ljt49f7B+E8Nesro7YbFOlJBjV6DwI
         cdhubOeJrFXxu3TULfvejfvX2Y9gqdOHVdJPKiNbSzeksu3oo4PjZLWUX3Zv9Gc9XNLn
         GJEQ==
X-Gm-Message-State: APjAAAW8xKLcFh/IIqSf1o6ghasUt5sqz/C0AXqjeyfiSJyST4KrOIRm
        B3pFPbgGtf+Mxb7cy3XhrtQ=
X-Google-Smtp-Source: APXvYqxOA/AuPgKigjA5FxvfAC2vKsjFbZCbDGg4XxjJXykV2VKg0jlhMvDbvvqLnqvIKAZJjKRObg==
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11mr29974203plo.241.1553581712068;
        Mon, 25 Mar 2019 23:28:32 -0700 (PDT)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e123sm26171542pfe.35.2019.03.25.23.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 23:28:30 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        tglx@linutronix.de, mingo@kernel.org, konrad.wilk@oracle.com,
        jpoimboe@redhat.com, peterz@infradead.org, mojha@codeaurora.org,
        jkosina@suse.cz, riel@surriel.com, peterz@infraded.org,
        Tianyu.Lan@microsoft.com, luto@kernel.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        sashal@kernel.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Fix Hyperv vIOMMU driver file name
Date:   Tue, 26 Mar 2019 14:28:21 +0800
Message-Id: <1553581701-25250-1-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The Hyperv vIOMMU file name should be "hyperv-iommu.c" rather
than "hyperv_iommu.c". This patch is to fix it.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..403247d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7175,7 +7175,7 @@ F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
-F:	drivers/iommu/hyperv_iommu.c
+F:	drivers/iommu/hyperv-iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
-- 
2.7.4

