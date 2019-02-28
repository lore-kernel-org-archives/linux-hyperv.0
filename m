Return-Path: <SRS0=MLR3=RD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1488C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 02:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781F420863
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 02:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCbDcmF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfB1CcD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:32:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45113 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbfB1CcC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 21:32:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so8948222pls.12;
        Wed, 27 Feb 2019 18:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9fb7ulQzUjFrkS4BsHjJTXR9fBvG6ZDDHxB1iOz56mc=;
        b=vCbDcmF64enXQA3g6wu0hTdSeF0EeQQRnBEZ80nu+CphWXhJSZzIWSBfYUXF+nA1Oq
         t+rUp24De3z+CWNY25Zd9wIO4O5mnA0OXlOwFlCwHdZDBK7kquEh36g4hlI3W+VMlkW9
         S/Dc2Xfz7F9SnjVGirXYMgzvrdrNFX/kiEfzZvkm9//y66amQqCU6CN/buubDmqOQUGQ
         Lu+al7FkSkn+6MIvLLuCUEY5+mNOi1rQusz4ESR0fMUdQu8isXEoZ5LGqtfEuPq1o7oh
         5e5qxziau9rqZBhjQlYpjJP/Zj3dFFaIIpOxmHBINSfWSjt++131XXT+r2pymXT/KhnY
         SlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9fb7ulQzUjFrkS4BsHjJTXR9fBvG6ZDDHxB1iOz56mc=;
        b=YBCL33vt0bfrHrF31dAB3og55f48Cg7L07u3afO3/0M5aB67n4db244Pk+s58oCYnN
         EXaL3l9cso/7l5dgNVN/U6d368QtHoUR9daOcg6DEScKcxF1apckpysumGAohOoIopGZ
         y342clxsNB5WhMvU6I5OqQeko/GmEnj58dnIBNmA9FlCxWv2KrSH4IH+ArdpF+dy8UOo
         +/36HGRnPRIqunHFLDcl1A5ieoYEFZVJgqNQfWJT7IjgLycwTy+7FdILOliY9qjH2bZA
         tleYKZC9SX6Dj0oLsM+9eeBInb9NvdjtXPTuos6mqxX9RVowkAUdPpxueLpfAk1vXZK8
         A0zg==
X-Gm-Message-State: AHQUAuZnHnzvqoIOYJzS8BT79JKanu4c7ErSUFoQ6R1zALPAnnKsRT+F
        aR+o0TukiUcHyCe4qp7doflr8VfpQfp3+w==
X-Google-Smtp-Source: AHgI3IaCy2JPUgJYk96eaieQgS9nGzkn3Bx4ZYHnRiAdKogQgJLOZ3UzwTCbdlhfIPtmPanarYvoSg==
X-Received: by 2002:a17:902:5992:: with SMTP id p18mr5477363pli.231.1551321121917;
        Wed, 27 Feb 2019 18:32:01 -0800 (PST)
Received: from maya190131 ([52.247.237.14])
        by smtp.gmail.com with ESMTPSA id d86sm10043549pfm.18.2019.02.27.18.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 18:32:01 -0800 (PST)
Date:   Thu, 28 Feb 2019 02:32:00 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset and
 cpumask_to_vpset()
Message-ID: <cover.1551319643.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset removes a duplicate definition of VP set (hv_vp_set) and
uses the common definition (hv_vpset) that is used in other places. It
changes the order of the members in struct hv_pcibus_device due to
flexible array in hv_vpset.

It also removes the duplicate implementation of cpumask_to_vpset(), uses
the shared implementation, and exports hv_max_vp_index, which is
required by cpumask_to_vpset().

Based on Vitaly's findings, two changes were applied: replace GFP_KERNEL
with GFP_ATOMIC for alloc_cpumask_var() because hv_irq_unmask() runs
while a spinlock is held, and add __aligned(8) to struct
retarget_msi_interrupt because Hyper-V requires that hypercall arguments
be aligned on an 8 byte boundary.

Vitaly, thank you for finding the issues, and Lorenzo and Michael, thank
you for your guidance and support!

Maya Nakamura (2):
  PCI: hv: Replace hv_vp_set with hv_vpset
  PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()

 arch/x86/hyperv/hv_init.c           |  1 +
 drivers/pci/controller/pci-hyperv.c | 61 +++++++++++++----------------
 2 files changed, 29 insertions(+), 33 deletions(-)

-- 
2.17.1

