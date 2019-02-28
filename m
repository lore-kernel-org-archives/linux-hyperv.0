Return-Path: <SRS0=MLR3=RD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161DFC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A1120863
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATfioEUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfB1CfI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:35:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfB1CfI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 21:35:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so8921081pgq.4;
        Wed, 27 Feb 2019 18:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pEwYiWVACEY9e8hOcJJc5+iyihWPSZqoyGMirWvaC0Y=;
        b=ATfioEUckM5ED/fzsne0fT/o3LTViNnrIoxcgmTMLqYmr7n9wPXYAGHrXJ1IJBO3f2
         twtCltaQB7bH1VCHnpA2h5qEmAcVqQEKhouFfwL2PJ1wLTGqfloNZJhNC28sZgaE9Kjr
         iQGH1Mr+7Pmy3br6IK5LzAs2dd43gCJ9t50VYayWMLbyWrah3a7aSFLynEqCAJh/xly9
         qmPdGKuv6TIrOqKUv+gt5IviRxln6MHcAzt55nSCS6i1v3BFgplhX5/pcuVxtpmEiPSi
         0noPQ/3psuj1Xl7oBRJz2ST3+lbxe11iTxBAQpLYeKCVwDnVLuucq4kIU3hb0pXnTQCs
         6LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEwYiWVACEY9e8hOcJJc5+iyihWPSZqoyGMirWvaC0Y=;
        b=FioIKq8SFGlrz9gYWdZh2oVE29pYDrzo0oTyyecU9u+d6mpW6h7lpQaWu16xaSBcUh
         Lq+Ac9dqE+P0xLf6n6BRxLrfjyHMefte8KA9XY92G5UKf0rAq2n0sEaFFZiDny6y2cQv
         0Zjd3XZm/Zln9hZdRtAcJ8IZnL6TMlgkIEjSxQOL5RKgD26zyDc+lIrSysocYWkro7fp
         dR8Jc/ak11K+WK1eytLB+elwiULup8nkDSwUs6pOJRq0zU4v7hsbs8gh5mGYcniylVfU
         YNrKuaxHjao9zEQn6TwwGRqcXi0kDiisVObQidewi2DZAvypdxH3yLQTpatsBfcmuIlL
         94mQ==
X-Gm-Message-State: AHQUAuZe+1oHrjqxvyE9SM7ihFmzvWldwRph7uG4tXbzXax1UWp4sFtW
        QPxML18rFCD6gy1e5dfz8W6RPKvl1zjXbw==
X-Google-Smtp-Source: AHgI3IZ7Zepvoi0fMcTS3tQ0DqQ/IKKSxihFXwIVNn7DLgjhwaOYZ+7sXtxhrAgxvU4HR6xjUYXs7g==
X-Received: by 2002:a62:bd13:: with SMTP id a19mr4927433pff.222.1551321307378;
        Wed, 27 Feb 2019 18:35:07 -0800 (PST)
Received: from maya190131 ([52.247.237.14])
        by smtp.gmail.com with ESMTPSA id b26sm22168181pfo.33.2019.02.27.18.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 18:35:06 -0800 (PST)
Date:   Thu, 28 Feb 2019 02:35:06 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v4 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <6a86e6e6d299dcfa71bf9ba97c60def73c0547e1.1551319643.git.m.maya.nakamura@gmail.com>
References: <cover.1551319643.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551319643.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove a duplicate definition of VP set (hv_vp_set) and use the common
definition (hv_vpset) that is used in other places.

Change the order of the members in struct hv_pcibus_device so that the
declaration of retarget_msi_interrupt_params is the last member. Struct
hv_vpset, which contains a flexible array, is nested two levels deep in
struct hv_pcibus_device via retarget_msi_interrupt_params.

Add a comment that retarget_msi_interrupt_params should be the last
member of struct hv_pcibus_device.

Based on Vitaly's finding, add __aligned(8) to struct
retarget_msi_interrupt because Hyper-V requires that hypercall arguments
be aligned on an 8 byte boundary.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
Changes in v4:
- Add __aligned(8) to struct retarget_msi_interrupt.
- Update the commit message.

Change in v3:
- Correct the v2 change log.

Change in v2:
- Update the commit message.

 drivers/pci/controller/pci-hyperv.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9ba4d12c179c..d71695db1ba0 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -393,12 +393,6 @@ struct hv_interrupt_entry {
 
 #define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
 
-struct hv_vp_set {
-	u64	format;			/* 0 (HvGenericSetSparse4k) */
-	u64	valid_banks;
-	u64	masks[HV_VP_SET_BANK_COUNT_MAX];
-};
-
 /*
  * flags for hv_device_interrupt_target.flags
  */
@@ -410,7 +404,7 @@ struct hv_device_interrupt_target {
 	u32	flags;
 	union {
 		u64		 vp_mask;
-		struct hv_vp_set vp_set;
+		struct hv_vpset vp_set;
 	};
 };
 
@@ -420,7 +414,7 @@ struct retarget_msi_interrupt {
 	struct hv_interrupt_entry int_entry;
 	u64	reserved2;
 	struct hv_device_interrupt_target int_target;
-} __packed;
+} __packed __aligned(8);
 
 /*
  * Driver specific state.
@@ -460,12 +454,16 @@ struct hv_pcibus_device {
 	struct msi_controller msi_chip;
 	struct irq_domain *irq_domain;
 
-	/* hypercall arg, must not cross page boundary */
-	struct retarget_msi_interrupt retarget_msi_interrupt_params;
-
 	spinlock_t retarget_msi_interrupt_lock;
 
 	struct workqueue_struct *wq;
+
+	/* hypercall arg, must not cross page boundary */
+	struct retarget_msi_interrupt retarget_msi_interrupt_params;
+
+	/*
+	 * Don't put anything here: retarget_msi_interrupt_params must be last
+	 */
 };
 
 /*
@@ -955,12 +953,13 @@ static void hv_irq_unmask(struct irq_data *data)
 		 */
 		params->int_target.flags |=
 			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
-		params->int_target.vp_set.valid_banks =
+		params->int_target.vp_set.valid_bank_mask =
 			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
 
 		/*
 		 * var-sized hypercall, var-size starts after vp_mask (thus
-		 * vp_set.format does not count, but vp_set.valid_banks does).
+		 * vp_set.format does not count, but vp_set.valid_bank_mask
+		 * does).
 		 */
 		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
 
@@ -974,7 +973,7 @@ static void hv_irq_unmask(struct irq_data *data)
 				goto exit_unlock;
 			}
 
-			params->int_target.vp_set.masks[cpu_vmbus / 64] |=
+			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
 				(1ULL << (cpu_vmbus & 63));
 		}
 	} else {
-- 
2.17.1

