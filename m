Return-Path: <SRS0=e6q8=RE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D47C43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 06:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5FF2084F
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 06:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqolMy8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfCAG7E (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:59:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45281 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCAG7E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Mar 2019 01:59:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id v21so10962327pfm.12;
        Thu, 28 Feb 2019 22:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxHEGr8Rvtq7t1KsqNMkVb0LIFYzkot5HpT7rZKbRXI=;
        b=QqolMy8doEGGdSTh214EmmlHAGldFRA/BFZRtvGdWDEJ0UzgsRGzoG76W64EE4Mbf8
         o5HX6KqzriFYgFz8Du9ZsC9PcnM4oOlXNby8RwAjbGt2g9kicLFGJv5pk3aZjnPAN9T8
         wMbyU/7TSfdZFA/pn4ikUMs5AqZounZcK1OGbXR/b904r9LdkUTQjxuHFPnKtCd4Uf0W
         TAmjnHoMQzBppCQpdx03Q61AiGqWTKpi3y7LYAnPv6oSnmb7bFU2ILqHLKMCyiOPiZJi
         tTgnr9J+8tYCNz4dF9Mc1x23wgD6NKznYjbldp8JxVIv/Ti4pc/pR8rIeCY7WvjCaZt1
         HRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxHEGr8Rvtq7t1KsqNMkVb0LIFYzkot5HpT7rZKbRXI=;
        b=g2u1C0BIdmysVLJxhsWDESFOsTCuiXRW2A5r8S2A5X1qLT7ryHaYlCUoxI4unRjkS2
         d/ICbGdYMmXLvva/8OuBR9gdF8DnYEreBFPwl6uTR8MTC74r6YBaC7sVOW7PQso9ePUv
         I+2jP5I2+8CzK2YZKv4g51aofvTHn6ouCBFjEnppNyRNdkxE3OUcZ1xMnu1LUqKrcvj4
         OwjJ7vA7A+06eS05m6f237lA24g9jTtZA/v7szvD/D6sgEkTssOwhESBikEDc4//aC9B
         +iuHijfguYRDTakDv2RgDyg9Ue4opUXHZp2hiem4kpng9bZaggMlBVLMMkoJ2vqY0BdN
         xE1g==
X-Gm-Message-State: APjAAAWaDa6zCw1g2d4iqUJaQ3uCGBgjjoXfS0jTAJn9nHbqnVKWchlT
        jXb53DBWhkmsnEhnaLE0hUM=
X-Google-Smtp-Source: APXvYqzNnKFJVME5kC8VM5QKcI3nFyBh7GsbiHBihmmQEDrxsxGLcZA6Hro/La4b4qHlGrzcuTQ/vg==
X-Received: by 2002:a63:f310:: with SMTP id l16mr3413484pgh.72.1551423543421;
        Thu, 28 Feb 2019 22:59:03 -0800 (PST)
Received: from maya190131 ([52.247.206.249])
        by smtp.gmail.com with ESMTPSA id t10sm51389521pfa.151.2019.02.28.22.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 22:59:02 -0800 (PST)
Date:   Fri, 1 Mar 2019 06:59:02 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com
Subject: [PATCH v5 2/3] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <d18b5c492df84fcf4a55954ffc508dd937a44eed.1551421809.git.m.maya.nakamura@gmail.com>
References: <cover.1551421809.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551421809.git.m.maya.nakamura@gmail.com>
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

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes in v5:
 - Remove the code added in v4.
 - Delete the v4 code change related comment from the commit message.
 - Add the Reviewed-by and Tested-by tags.

Changes in v4:
 - Add __aligned(8) to struct retarget_msi_interrupt.
 - Update the commit message.

Change in v3:
 - Correct the v2 change log.

Change in v2:
 - Update the commit message.

 drivers/pci/controller/pci-hyperv.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 73862eef09ec..d71695db1ba0 100644
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

