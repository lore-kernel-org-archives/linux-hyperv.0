Return-Path: <SRS0=e6q8=RE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7970C43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 06:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B472186A
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 06:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5iYZ5X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfCAG41 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:56:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37953 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCAG4Z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Mar 2019 01:56:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so10981921pgl.5;
        Thu, 28 Feb 2019 22:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ckz5cZ+UCIsmGaUiciDSxa7VVqmOmRltABIFS3JWww=;
        b=W5iYZ5X8ao0Kip3uX4gkvOU715GksHIx3Uo2Qfb0lZFNVDwyuaCL94ZY1LBpgulbYe
         nlPj9+jqH0JxKy84brThjmWG7V8Q9D4hiwL05Wn4ujanTvTBAvcuFNE89GPudNza2mZT
         CkFZgzdtIS8MQKzkKJLbE97Aql0XeecRpbX+Zrn40dtt6mcjkqOA3gnhLTZNYrFk7Yc0
         L1KM2ETR6Vlwd6S5wZ4hxEi9Z5HaclJTwQkAxSEPP287Pbnv7gCDDRbQSDWRRRoDkyNW
         +XqzbfBZtfJPpCz4V0E5sppTBD2pblZ+jy/HpE+RkQqpok77M2JAXAqNjBS2aUgQOIUC
         lNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ckz5cZ+UCIsmGaUiciDSxa7VVqmOmRltABIFS3JWww=;
        b=SoVTsPUICHFrgehQgtPZ7aEX5+fq8fAOZjDng7sRutKAtSyIev3Rb5TmGHMCzzxRfY
         cXn8RCqNaHMO7H2LZLgsfWcAjhsEYbo1Yyp5kUtc220w6UWhFc11cI4rTnF364nQ3gRO
         DDyytAAAtI0hmJjC1UR23rfB/WVWAyJlxvMEO3xY47Ky4j+UlPaO+Oy+AjwHfy8U7X1z
         FdHawA3m9KsbjswmIe5WNCQrSlVyfcIIWec/8GF0eXVIRTC5XqwxGfM6cg3yHFAz8rLV
         OftzyJyCCv7DAe10brk2TQJbl4gZgtq3OLaps+3Ns2KqoijaoaeyqeFh5egWI1RFLyFp
         KD1w==
X-Gm-Message-State: APjAAAU7sXW8N61TxN9W+wev4kJUkHeFxkUF31xnd4AuKSsQH30XiUy1
        HcBq560+BUweP7pwoOwpSJQ=
X-Google-Smtp-Source: APXvYqx/yxl5X72BpxIA5DV2dMwxx1W/mx32hotapCJxNwgxAeDmccie7m5fu2nsaltwn3IHX1nikw==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr3295302pge.79.1551423385242;
        Thu, 28 Feb 2019 22:56:25 -0800 (PST)
Received: from maya190131 ([52.247.206.249])
        by smtp.gmail.com with ESMTPSA id m3sm20684239pgp.85.2019.02.28.22.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 22:56:25 -0800 (PST)
Date:   Fri, 1 Mar 2019 06:56:24 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com
Subject: [PATCH v5 1/3] PCI: hv: Add __aligned(8) to struct
 retarget_msi_interrupt
Message-ID: <5f6f7fa3d287867ae4c2220ff7235efe544cdd6e.1551421809.git.m.maya.nakamura@gmail.com>
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

Because Hyper-V requires that hypercall arguments be aligned on an 8
byte boundary, add __aligned(8) to struct retarget_msi_interrupt.

Link: https://lore.kernel.org/lkml/87k1hlqlby.fsf@vitty.brq.redhat.com/
Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9ba4d12c179c..73862eef09ec 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -420,7 +420,7 @@ struct retarget_msi_interrupt {
 	struct hv_interrupt_entry int_entry;
 	u64	reserved2;
 	struct hv_device_interrupt_target int_target;
-} __packed;
+} __packed __aligned(8);
 
 /*
  * Driver specific state.
-- 
2.17.1

