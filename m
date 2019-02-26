Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED1EC4360F
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3246321852
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZXMAOF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfBZMHo (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34675 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfBZMHn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so6171694plr.1;
        Tue, 26 Feb 2019 04:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qU1GABYYyeuPRZGX8LPlndQ7q8L8YfsCQ19TD+5FHqc=;
        b=qZXMAOF+D6SCoEM+v2PEd8vxnfcBFFbYa8iiwhgGDOSZofWuj+lzIoVy6LUyQlhq2s
         U91FXDhq6AcC4Oq93WoME0GPHCupoh+h70f/qR+FZ2LDt/xoS0bP1JvcqY8VLK0l69PA
         OrN7CRbkXvP99wezM4e73XB4Kd4iIEmDjxiJ8eWf8MkHftPltUmI8Em4OBa3Fdb5zfR1
         DP7v0eIrZnuVNFodlhGu9l/OO6Gu8+wReKUAISiQpH6VxgpzkUsc3mSVPephrCtnsDhI
         TowgLt+zXZJoM9oGGU2xRZRq08HAAg2WjvbqJVAjMosOdRjnwXagyZm7fEPoC1acGrNe
         4OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qU1GABYYyeuPRZGX8LPlndQ7q8L8YfsCQ19TD+5FHqc=;
        b=MbOKdgtug5BJ6FZiAQCKLWeQUVWT2TF/S3CmS9il8Sbb3NP5EBqPu5zRB5fRInSTor
         ErPNDXChdUrY29zLh5US7o9a/dyP4z0zVkusl72xf9RuBDdIzNG8BZK6nNXXr+O6F36j
         L/uShm36ubrAxMBWEOHFFgUlthxRhNXSsFa0Xeq5plU/Oq8OXa+s4pYcgvaBY8rDVei9
         mL4hpSVCRnMvBYN0TLYib9ZtKh6ZyUwj3TJhlaFP2YnkvYtCDNTefzalAkirvgF9/Lgz
         ug6+/4j4Alrrm24rJrUXwrWVozea2iQ4mEQ/h9O1RkWNMLKIUmKU1zAyjw10AeLY1UmV
         IOUw==
X-Gm-Message-State: AHQUAua/kgj5qDTApuJPBLW+JmqhpqwEMNFMdtdgJGTEU/Jjjzp55/sH
        IcFTI7P4xYRBJeBrL61LJeFzRV2g
X-Google-Smtp-Source: AHgI3Iajo/2Za+PSZHrYfraGQ2jzZC6VGQ6gc07Rk5zmAxKvwkIN/nNmZLMxDbglUJujWiEDeSj3cg==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr25034824pla.19.1551182863114;
        Tue, 26 Feb 2019 04:07:43 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e21sm30889423pfh.45.2019.02.26.04.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Feb 2019 04:07:42 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, joro@8bytes.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        alex.williamson@redhat.com, dan.carpenter@oracle.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org
Subject: [Resend PATCH V5 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date:   Tue, 26 Feb 2019 20:07:18 +0800
Message-Id: <1551182840-15069-2-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com>
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
Change since v2:
       - Fix compile error due to x2apic_phys
       - Fix comment indent
Change since v1:
       - Remove redundant extern for x2apic_phys

---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..0c29e4e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
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
+	if (IS_ENABLED(CONFIG_X86_X2APIC) && x2apic_supported())
+		x2apic_phys = 1;
+
 #endif
 }
 
-- 
2.7.4

