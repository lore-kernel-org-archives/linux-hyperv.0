Return-Path: <SRS0=MLR3=RD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C61C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 02:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C0220863
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 02:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrRyDgaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfB1Chh (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:37:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32891 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbfB1Chh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 21:37:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so8967902pfd.0;
        Wed, 27 Feb 2019 18:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GMkiTJqCagvIb09Uuj0om9cKdwSMRHgaoyAla48hwtI=;
        b=BrRyDgaHMCwNrmaP7YdtrJyv+ED/eFNi2H8hHdzCpy8TXH+EFjQti4yrEXLzaa/kgO
         zol90yhw2YoKLBFFhyBYJiObcLulVOS0bU+QlC9uLPuKhwyuGFzXd8pYtZoCrL+YYT3g
         3M+Nwb4BZfEGB0tRCIwWS62HB0PvAibOgH4n3oOEEdCPpvGZ3KbbO14YblZ8J3xrWqB2
         jG5OyGPR8VHro3RGslAM0noqN5X9FOB9t8sqEm7t7xoJd6CjQFHYen3cDd05+0Yqsrmz
         Ym7usp7DCmtwY0szZRDjHuksXJCcULOrGjSmo4aJa4LPPov6/nkbYTmcLXPDPKkNlQ6E
         ozRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GMkiTJqCagvIb09Uuj0om9cKdwSMRHgaoyAla48hwtI=;
        b=opensy8QrkRut0v3rZGCk+yF+ugknXfAAexvjzGeBLBM/Zr6NhO15AwVX/L+y+dTHP
         I9rTgf0P/ZiZfu3v26KLvFRESDOlzifPNqOcymEGUjQ6W2BMmbHXnLHCpYQHCAZU7wSa
         Z0ow2ObGq2ZI4REK5Se4K95jiYGklppQl7FfHPp0bnW60fIpBqhQdgMlsVN9pR8W1CLu
         cevRVLELTK5F8bF8UxDeiWGv9OSnhvaVc2Pq5nN1VP3/sMKvReqx72tvyH+qqkZ3FUbC
         3OFx0LhybwpHT7BBoNGflMZNnmM4OQoudyPxKE2oZGUiNmdG0nBamwYJnYzxegtyw/dd
         mNpg==
X-Gm-Message-State: AHQUAubNn/sRi9SBNxLCzij9acMvP01X4RELRSY6UJ9ey3yH/cq4izLL
        LO/byOS7IQR0aOpdPIqz7VUBWLJaaDNdpQ==
X-Google-Smtp-Source: AHgI3IYy7y4L8ixGsjO+JTDm16UPBOPuXokGs4m2MR2lpBWNGQ1vznGEBUOewMcfo+pF0843rKMKfA==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr6219091pgb.58.1551321455915;
        Wed, 27 Feb 2019 18:37:35 -0800 (PST)
Received: from maya190131 ([52.247.237.14])
        by smtp.gmail.com with ESMTPSA id f87sm11741316pff.38.2019.02.27.18.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 18:37:35 -0800 (PST)
Date:   Thu, 28 Feb 2019 02:37:34 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: hv: Refactor hv_irq_unmask() to use
 cpumask_to_vpset()
Message-ID: <d691069ffe6e41b04cb4dff0dfabd1755afa500f.1551319643.git.m.maya.nakamura@gmail.com>
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

Remove the duplicate implementation of cpumask_to_vpset() and use the
shared implementation. Export hv_max_vp_index, which is required by
cpumask_to_vpset().

Apply changes to hv_irq_unmask() based on feedback.

Based on Vitaly's finding, use GFP_ATOMIC instead of GFP_KERNEL for
alloc_cpumask_var() because hv_irq_unmask() runs while a spinlock is
held.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
Changes in v4:
 - Replace GFP_KERNEL with GFP_ATOMIC for alloc_cpumask_var().
 - Update the commit message.

Changes in v3:
 - Modify to catch all failures from cpumask_to_vpset().
 - Correct the v2 change log about the commit message.

Changes in v2:
 - Remove unnecessary nr_bank initialization.
 - Delete two unnecessary dev_err()'s.
 - Unlock before returning.
 - Update the commit message.

 arch/x86/hyperv/hv_init.c           |  1 +
 drivers/pci/controller/pci-hyperv.c | 38 +++++++++++++----------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e2eeb8..7f2eed1fc81b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -96,6 +96,7 @@ void  __percpu **hyperv_pcpu_input_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 
 u32 hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
 static int hv_cpu_init(unsigned int cpu)
 {
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index d71695db1ba0..95441a35eceb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -391,8 +391,6 @@ struct hv_interrupt_entry {
 	u32	data;
 };
 
-#define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
-
 /*
  * flags for hv_device_interrupt_target.flags
  */
@@ -908,12 +906,12 @@ static void hv_irq_unmask(struct irq_data *data)
 	struct retarget_msi_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
+	cpumask_var_t tmp;
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u32 var_size = 0;
-	int cpu_vmbus;
-	int cpu;
+	int cpu, nr_bank;
 	u64 res;
 
 	dest = irq_data_get_effective_affinity_mask(data);
@@ -953,29 +951,27 @@ static void hv_irq_unmask(struct irq_data *data)
 		 */
 		params->int_target.flags |=
 			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
-		params->int_target.vp_set.valid_bank_mask =
-			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
+
+		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
+			res = 1;
+			goto exit_unlock;
+		}
+
+		cpumask_and(tmp, dest, cpu_online_mask);
+		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
+		free_cpumask_var(tmp);
+
+		if (nr_bank <= 0) {
+			res = 1;
+			goto exit_unlock;
+		}
 
 		/*
 		 * var-sized hypercall, var-size starts after vp_mask (thus
 		 * vp_set.format does not count, but vp_set.valid_bank_mask
 		 * does).
 		 */
-		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
-
-		for_each_cpu_and(cpu, dest, cpu_online_mask) {
-			cpu_vmbus = hv_cpu_number_to_vp_number(cpu);
-
-			if (cpu_vmbus >= HV_VP_SET_BANK_COUNT_MAX * 64) {
-				dev_err(&hbus->hdev->device,
-					"too high CPU %d", cpu_vmbus);
-				res = 1;
-				goto exit_unlock;
-			}
-
-			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
-				(1ULL << (cpu_vmbus & 63));
-		}
+		var_size = 1 + nr_bank;
 	} else {
 		for_each_cpu_and(cpu, dest, cpu_online_mask) {
 			params->int_target.vp_mask |=
-- 
2.17.1

