Return-Path: <SRS0=Gp0b=RC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610FC43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7634217F5
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 14:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMR2I1vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfB0Oyk (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:54:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43605 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfB0Oyk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 09:54:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so8065343pgq.10;
        Wed, 27 Feb 2019 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BAaU3SCjEVdf5o/jF2bCzRsTcKRKt2DHscF4H08IKCc=;
        b=SMR2I1vRBZ+TyLLwZEhjNH8iZgGkSKHxRLllk7CbdKJteNqUu5gmkJ/2aWMjFQ/Eoi
         UOlBsRgUd7K/pB/ZMXaLYyhJFsqN56YrZK29YKZCNN9X973NZz05FgdVpRhusMz4TfhS
         mrztKfvudmutSZf1KhNuNTTDQrWQloMSE0DpRAfJqp2PBNUCuFvkcQcwnrJpZCPuI0Nn
         l57a27SXZg4FJllxdUwy/NQkYrKhX/gnGAg2Aff24o6hUf5PxAaylZNcKNuvHnJFv9OX
         MIvZatt1ddJCiDdfqvzLsi+D1fZe/0TU8JSKtt4q8Gto8ojebfUUoutjaCyaBs+26xwX
         8xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BAaU3SCjEVdf5o/jF2bCzRsTcKRKt2DHscF4H08IKCc=;
        b=EwsO2gGGgFgwGolbIOzNZDgCcLRzucVQWilarz91hQ9xkGnDdMb3jXbwTi/5EMlx/M
         Y4RMFczgO68wn00vXjqICo6ikRdMUEr7nYBRFtWkS22bWi6ZX8Jr8FpC45mcxG5ploNa
         BcOmdMM+wy2Go3e6pJBWsCH+qj93Aid7xDx9Pxn3NdtB2vp88E6v3oRgU3MqNjuMucij
         D8rpON2PJCvo/ROcLBUDwUVqv1IFJus9sqdHj6FT4qgt9YryvxbTd+okeZKwtF3/Fg7b
         jvbC1D6Rbjc73Z2V1gTtqhGW41g1DY0VUALPHFRvuELMCOacSDGLVlkxnRc6+17UwUc0
         FZEw==
X-Gm-Message-State: AHQUAuajGSKBdmbqeY0ESlW52fnGkS2ys3MqnF/1TEf9e3o1yjrP5fr6
        tHRJbmbyChZFSMOJeoOcj90=
X-Google-Smtp-Source: AHgI3Iaa0EMl4uSNw5IKlXSebQc8zVeao+tC90YxRtHHHdzENLLI8UP3TmpZrPrRjaFpRYw20iz/Kw==
X-Received: by 2002:a65:4806:: with SMTP id h6mr3365142pgs.408.1551279279466;
        Wed, 27 Feb 2019 06:54:39 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id 63sm29618135pfy.110.2019.02.27.06.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 06:54:38 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, joro@8bytes.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        alex.williamson@redhat.com, dan.carpenter@oracle.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org
Subject: [PATCH V6 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date:   Wed, 27 Feb 2019 22:54:03 +0800
Message-Id: <1551279245-25888-2-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
set x2apic destination mode to physcial mode when x2apic is available
and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
8-bit APIC id.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v5:
       - Fix comile error due to x2apic_phys

Change since v2:
       - Fix compile error due to x2apic_phys
       - Fix comment indent
Change since v1:
       - Remove redundant extern for x2apic_phys
---
 arch/x86/kernel/cpu/mshyperv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..3fa238a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,18 @@ static void __init ms_hyperv_init_platform(void)
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
 # endif
+
+	/*
+	 * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
+	 * set x2apic destination mode to physcial mode when x2apic is available
+	 * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
+	 * have 8-bit APIC id.
+	 */
+# ifdef CONFIG_X86_X2APIC
+	if (x2apic_supported())
+		x2apic_phys = 1;
+# endif
+
 #endif
 }
 
-- 
2.7.4

