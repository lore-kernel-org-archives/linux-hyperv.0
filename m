Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31392C4360F
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E3121871
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHlKBpGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfBZMHi (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37058 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfBZMHg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id q3so6162830pll.4;
        Tue, 26 Feb 2019 04:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cRSp6tvS/Rco8rcWUsXIYReEFgEXXBMbEv9s2oo6H7Y=;
        b=nHlKBpGUUHTYYkK618zWETl1r97R5bRwzy/5mzUn0gnlGyGKPAbl/HjatAldZ6IjW2
         fSsOoSoOgRnBvmwvQ7ZjDyy00Z32NYQk0CLs4amr5A8mNAZmBxq8culjBI7wju1S94DD
         Q32ZTK1Gt2imAUdOY/seMos6w+kfZ6TmqX8oPAu8Sj0aiKAn5gMtymGlyYzeGPBmLOZx
         MNTQyYzFPEDJiRJT3tTr6/ujE/KZ+12HL7lC2gV5qH675sLPkcmiRxgtiLPMBTGMbpbI
         vIIKuAHrWcOKdBaNAAjR+MXPF+6VnvRGuJakDwzxc0i4mG+BvFXpmCEtpkvYhilxe+MK
         KUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cRSp6tvS/Rco8rcWUsXIYReEFgEXXBMbEv9s2oo6H7Y=;
        b=paNDW/b0iWKzilPoNqrFW2LBUvLxNt6IFUD0Jni7QAIOHLhXp9kMIidwVdShwuvQ6t
         Fu6n6iDqYsbn40DbY0eseh19VDdK8CAf0mK9hALyhyAmC10Cwfl8fNr8P/xDlKllHTUg
         7wzQiOqpJ0EMw411YtLztBTiJU5TjrlghYDcbg3py6ScBd/ygWPHWp8G+hlFfHLqQr38
         KsfvEv6Yjbcd5wgxhsyyQgNw5hX3Jr6bx7m2HdAiZepVIGhgLOxW9mBEkHqdc9uiGndo
         4Ic9MOZ23FBYatgtEHoUg+flf1tgUqLwab4BG231nGmu2i4izwjAJBu1mOu2/IWU0R18
         K/Yw==
X-Gm-Message-State: AHQUAuafygyRlmFSq9DeQ3FmlwqEP6Fu6bXwODdQItaTLz5QTqshKyIE
        +kRak44Wllja/3tP5hPkR/s=
X-Google-Smtp-Source: AHgI3IZeLgLxLt3t/V73zZjAlgZRMXFiXy/WPIDd+b2UcBjrV7LtaReozeQrUTRJNangnzNdGu/cfQ==
X-Received: by 2002:a17:902:b416:: with SMTP id x22mr26061107plr.285.1551182856171;
        Tue, 26 Feb 2019 04:07:36 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e21sm30889423pfh.45.2019.02.26.04.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Feb 2019 04:07:34 -0800 (PST)
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
        devel@linuxdriverproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [Resend PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to support x2apic mode
Date:   Tue, 26 Feb 2019 20:07:17 +0800
Message-Id: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

On the bare metal, enabling X2APIC mode requires interrupt remapping
function which helps to deliver irq to cpu with 32-bit APIC ID.
Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
MSI protocol already supports to deliver interrupt to the CPU whose
virtual processor index is more than 255. IO-APIC interrupt still has
8-bit APIC ID limitation.

This patchset is to add Hyper-V stub IOMMU driver in order to enable
X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
interrupt remapping capability when X2APIC mode is available. X2APIC
destination mode is set to physical by PATCH 1 when X2APIC is available.
Hyper-V IOMMU driver will scan cpu 0~255 and set cpu into IO-APIC MAX cpu
affinity cpumask if its APIC ID is 8-bit. Driver creates a Hyper-V irq domain
to limit IO-APIC interrupts' affinity and make sure cpus assigned with IO-APIC
interrupt are in the scope of IO-APIC MAX cpu affinity.

Lan Tianyu (3):
  x86/Hyper-V: Set x2apic destination mode to physical when x2apic is   
     available
  HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
  MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
    scope

 MAINTAINERS                    |   1 +
 arch/x86/kernel/cpu/mshyperv.c |  10 +++
 drivers/iommu/Kconfig          |   9 ++
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/hyperv-iommu.c   | 194 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c  |   3 +
 drivers/iommu/irq_remapping.h  |   1 +
 7 files changed, 219 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

-- 
2.7.4

