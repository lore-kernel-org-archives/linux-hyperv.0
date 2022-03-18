Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB79DC433F5
	for <linux-hyperv@archiver.kernel.org>; Fri, 18 Mar 2022 17:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiCRRuU (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiCRRuT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Mar 2022 13:50:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F84D169B0A;
        Fri, 18 Mar 2022 10:49:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u23so8846175ejt.1;
        Fri, 18 Mar 2022 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGjB7GqWMynjIA0+/6xQ+uE8T6CCVvUTw43NpwNkZK0=;
        b=QR545lb7SAR4EZIGE3+S8kVIWFYqa/uw6jt9zzx70lDVNFQFPC30kX5SQjzRt2kFSN
         l0VGp+O7X4QTc8qSqGQx/iDrnfL0paX/uWjhSzzPfvX1yvCIO2hhfBm+LwDUMA9ELKIp
         vBwWLsoQAmzgEOv3uPAGayhzr3Rndxwkh5lYEDN5jBVAFnuh5yfwSuT/n6duxYsMr48s
         sB9dY+F2xrtNUgmFi+8Xj6zNM8Y0kuVLTtjudMhQ9v+hjKqKt44rGyEX1UTdmcB1saEV
         7CqKwQ39GZ1ScGYENFrv8RJJzsqtbKfigUe7MG4fSY2oEUISK5HsAJyM7DMnF00atm88
         1/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGjB7GqWMynjIA0+/6xQ+uE8T6CCVvUTw43NpwNkZK0=;
        b=Lm9TaZ6xwGC0qaqJ1AIWH7BGsiJYnjOasMWLRiDfpWDW/Gij0UoO5FwlPWfr8OuVrd
         JjRXP6fAECal0AwZf8QOt+UPnWkZ1fO45nu30V4Exjim7KqMcDbl1F9tfqpOc90uKYzx
         cMe89q+/xEQ0bF9oL0oOt0eE9e/pOqJ8b/Stcfv+z3w0W19UV5aipkxCAmmVpWNW47g3
         5GLYzLWAHoMQp3yIuK1oBsWfmOY0XppTEqNbRRCZqB/M65wCKyePHW1NmQV2/wDRRYsh
         3muqR7C2B2pjGX1vxTIJC5wNA+wlvajuv43DSXIAfn5ziZ1zvs9jAXsd7BqPSvKIEPML
         iOUA==
X-Gm-Message-State: AOAM53233p0qv819s96fpO1SbMwt+G9jXwc2BRfcBjoa0pH6BVOLYwtB
        gMlBYCoQ2nR1GVCEo1cCdj4=
X-Google-Smtp-Source: ABdhPJw9SvvLNSoXkEOZhN6kaI6NkYjOIMQn0VfoJ9rQkuBQfJm9/eKHSJ+Ti/1002viW91DmdPfpg==
X-Received: by 2002:a17:907:3e19:b0:6da:86b9:acc with SMTP id hp25-20020a1709073e1900b006da86b90accmr10352798ejc.655.1647625739000;
        Fri, 18 Mar 2022 10:48:59 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id y15-20020a170906518f00b006df87a2bb16sm3218730ejk.89.2022.03.18.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:48:58 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 0/2] PCI: hv: Miscellaneous changes
Date:   Fri, 18 Mar 2022 18:48:46 +0100
Message-Id: <20220318174848.290621-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri (Microsoft) (2):
  PCI: hv: Use IDR to generate transaction IDs for VMBus hardening
  PCI: hv: Fix synchronization between channel callback and
    hv_compose_msi_msg()

 drivers/pci/controller/pci-hyperv.c | 197 ++++++++++++++++++++--------
 1 file changed, 143 insertions(+), 54 deletions(-)

-- 
2.25.1

