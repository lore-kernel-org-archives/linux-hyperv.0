Return-Path: <SRS0=e6q8=RE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B1C43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 06:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B792186A
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 06:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOw3HGUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfCAGyr (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:54:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43208 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCAGyr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Mar 2019 01:54:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so10961500pfh.10;
        Thu, 28 Feb 2019 22:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oXEfPEGL+Zj75A5a3F8V80z9LeMcoj/Klqsodz0w0Eo=;
        b=DOw3HGUvyL8LkrkxcIwaECvG5vd+yUTfNIJM5C6+dybHFL0DMuu5191QjD3KhLjETT
         ENcwZb1K4hqigvIsGR7MyGcIWVZlKYtDNpwJB+ad+qNPD6TngKT69XEnYF9tvNclyi0s
         WEVNBmc3fjbXt1ndqpdUmjXgXszS6MnKAvXN7u1yjjwk5mHb8W4INCaCqswfea1aI3Bk
         zaWy0kA4Vdj3al27bFK8Z+3UmYOvwJt4hDZ9rY9CHb02DZWYMZXgIPCsDb92Z7eN6wOq
         eKw2lvFgx7XLENb3Iu/09sixuheUiqXBzcl0xjD/Z8BRX0dvTs5lFFxNe9J/Av63QmbH
         JvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oXEfPEGL+Zj75A5a3F8V80z9LeMcoj/Klqsodz0w0Eo=;
        b=Ie46g3f6yTgH3ImS2B/ICwYOyym/LoXapD83Hro1kjMmgnnhCOb9gl2yBtC1WQ69Vh
         FIFYy41dwG9sah4Ld+7Bik6pDL75svApQhFe7LT217ygHvjAqov4qzLR18IzmcfDgyj2
         yiRmHVVqSjmgSDXuSGgR23qoUdCjEXc0N1Kb5JLAT1tFMpdI45HyLxbuY/eCIMTYX4yS
         T391QhYsK89tx/Mrt2oUtTAQRVoytHB9WxhweA4SDbgPAStdz6j/d6dCn+etyQG3+UJL
         6dC/ckTcuiGDAfDL8hjKi5WxMGLbvYCWLbCLX3LGV3eHKVaEY0nWiyL73btEPD2DUxrt
         n/3A==
X-Gm-Message-State: AHQUAuZLIobiEVYWBQIJJYvhDFe6iNRBjgh1c1Aig1hRWKceq2IJYFu9
        rZ+LCZupwWO5v37AQfyWTCk=
X-Google-Smtp-Source: AHgI3IYqJ2/1pxz/XxLtGjRL5eqzEUSI95cTJPkqnQJzFH9WXViShXguZHcx30uhm3begF46omTckQ==
X-Received: by 2002:aa7:8597:: with SMTP id w23mr3925636pfn.87.1551423286942;
        Thu, 28 Feb 2019 22:54:46 -0800 (PST)
Received: from maya190131 ([52.247.206.249])
        by smtp.gmail.com with ESMTPSA id s4sm19649505pfe.16.2019.02.28.22.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 22:54:46 -0800 (PST)
Date:   Fri, 1 Mar 2019 06:54:45 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com
Subject: [PATCH v5 0/3] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset and
 cpumask_to_vpset()
Message-ID: <cover.1551421809.git.m.maya.nakamura@gmail.com>
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

It adds __aligned(8) to struct retarget_msi_interrupt because Hyper-V
requires that hypercall arguments be aligned on an 8 byte boundary. This
is now a new patch, separate from one of the previous patches.

Maya Nakamura (3):
  PCI: hv: Add __aligned(8) to struct retarget_msi_interrupt
  PCI: hv: Replace hv_vp_set with hv_vpset
  PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()

 arch/x86/hyperv/hv_init.c           |  1 +
 drivers/pci/controller/pci-hyperv.c | 61 +++++++++++++----------------
 2 files changed, 29 insertions(+), 33 deletions(-)

-- 
2.17.1

