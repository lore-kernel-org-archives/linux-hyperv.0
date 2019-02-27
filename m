Return-Path: <SRS0=Gp0b=RC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F98C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 14:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B96217F5
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ5ucZ4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfB0Oye (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:54:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34716 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfB0Oyd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 09:54:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so8092660pgd.1;
        Wed, 27 Feb 2019 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bimPMa35q+0CwqM1/LGvQIQX4sWjEKfl53qd/UsBPS8=;
        b=YZ5ucZ4p9NRyKLOXU4zItG+PxSmqjIBctktZqD64pW7O1B7O0gnF7/RqekPCoD1Jla
         PvTiuxGPKMOpf8lfJq9UtYIFM2hXNrzDcWPX3s3wSQuwYcNIfFDajZxjsvzI8YjKhlEH
         OJWA2fnuJOo1QMaTVRaJQQtk2PWI+/U8A19A2FwxzPFN5L7hyGya/EFl5vd83pCssxZy
         y2jGFIQ2MetoSet357gMKwC9T+HHx/XEt3Uu7ebCojYvWGr8QalVMaeJtg9fQfYb0aX3
         ZSGTDU6qcPWnogWnPV4ZKMdZ6f9mug+7se4XT8uFUN+RNnuRz+FBk1EaogoEybVCgr1F
         QdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bimPMa35q+0CwqM1/LGvQIQX4sWjEKfl53qd/UsBPS8=;
        b=HbAObAIaTAofwOmh6l2gGw6d50b6SkXHkX1UO46442VKsgK7gXl2DcgApovZcSBttg
         gSjh1psX7iwFs4vaWLOfVPKPgyZvqOY9xDARp1ApW1ksEAmH5WClwvMXYj5GoqgzxTHx
         6ks2LbOtqIJS3F3Ab3oU6Kn/W3AJjS+Geep2anZA5SYDrEVfQaYg7uwVHuJqfUtoWBL0
         mXtdae7gzlKojQOh2U6GCMyY/6xBgXXo8Vj8qJZ9kiV20qWcKlLhBAP5BRK/SRi56bRF
         Mm2cuK/J8BOrokjD1fyMeLWkIDRzaRT/93Jw0mSL9FpnOJ3QGrT9rQWKpEmIkRCtjaTH
         7qLw==
X-Gm-Message-State: AHQUAubPzSFGiMLbuVoq9lmxcCadcMtklsHmKKVFlzVJZsJ2ri2iYFVg
        CxVPyx9juYh7vanCl6DTT94=
X-Google-Smtp-Source: AHgI3IYiscPbUe0F0hxlOtgvd2kpkbNZckjTmp6gO1gkafSQ7VCviOoCPn4OV8WK4enfdIL63sI2VQ==
X-Received: by 2002:a65:608c:: with SMTP id t12mr3391092pgu.400.1551279272578;
        Wed, 27 Feb 2019 06:54:32 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id 63sm29618135pfy.110.2019.02.27.06.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 06:54:31 -0800 (PST)
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH V6 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to support x2apic mode
Date:   Wed, 27 Feb 2019 22:54:02 +0800
Message-Id: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
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
 arch/x86/kernel/cpu/mshyperv.c |  12 +++
 drivers/iommu/Kconfig          |   9 ++
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/hyperv-iommu.c   | 196 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c  |   3 +
 drivers/iommu/irq_remapping.h  |   1 +
 7 files changed, 223 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

-- 
2.7.4

