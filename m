Return-Path: <SRS0=/lIm=VW=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5BBC7618B
	for <linux-hyperv@archiver.kernel.org>; Thu, 25 Jul 2019 05:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7B422BEB
	for <linux-hyperv@archiver.kernel.org>; Thu, 25 Jul 2019 05:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxVtMrHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbfGYFDv (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:03:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42306 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390203AbfGYFDv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Jul 2019 01:03:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id h18so47854572qtm.9;
        Wed, 24 Jul 2019 22:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YjvirF97DbBIiqJIhuBMbP/GPdJovbnZE88RbdAyiwQ=;
        b=bxVtMrHlaLhYg6dXVk89o94x1DzIrotFvEmk+3EIKmnUpRBs2GGIjqqAZmKsJV7Obm
         HGpMcGIN02Vvfqqt59dAz7RMCR0D5dHRDOBZk8l5owfeOfZTkcCBLg/PkNT3ihUA1N2l
         m/OhbFWCmwqx2WO/7lA3AzsAP+EVU8OvwR5EELWEBjGSt0RhlkqcS9Ulazz/aFFs6jnP
         BhYaTu/JeE8jL5gyt05ToUlMOwRigEjoZLhyQq1aXzbEoclFg8iXih52VVCQAJD5BNoB
         9vFyDf2MtQ222MjRZbSIcqQeXFChaErfES69kQ5qYALJbOBvlOdv96ZXU5sCfA/wmM5f
         3TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YjvirF97DbBIiqJIhuBMbP/GPdJovbnZE88RbdAyiwQ=;
        b=I+7IEwLSeuvozKrfcl8gG4H6ihHEppfTaaeCKwaRQTXxPPXcOV3CPonIukXziErbBt
         PTJluCoFs3mxABPXjwXwMhH4yvK8Fz+Uu8vugFul6uuvaz/lRQnhCDzMCqwP+5fhZ+Kh
         7OS8+IJxKhD9AE3Ml5Wt0M3wUXDwY1aSWCf7s5iQqzDReCnf7dUXgPtmiMF76xetXZpR
         EDAJ6jacLtUKNfg0K6PZIE3HV03dgHIUDcfP09EuddRM9aVL7opzKHM57uU3XciVQrkR
         D1+5OR8PdYKmdkcrNTzgRKt9p84+CvilXYGWlM6oEqgMz8Y5caEiKRHvmzg6OJcsOnOv
         //fA==
X-Gm-Message-State: APjAAAVeVVMcCOgVAKTfcP88VC+lJCemSl/aU79hQOKUl60fK/OdiqKC
        pAjsu0sOZDDYNLIUoo5bMWJztTx5oIs=
X-Google-Smtp-Source: APXvYqxpXkDhISgfBa3iOClPnBcn/0vDKjFdQGXlemiNI5J+6UIaXLF+89XmiucAnF2GlyQKGDssmQ==
X-Received: by 2002:a0c:eec2:: with SMTP id h2mr60578220qvs.189.1564031030827;
        Wed, 24 Jul 2019 22:03:50 -0700 (PDT)
Received: from AzureHyper-V.3xjlci4r0w3u5g13o212qxlisd.bx.internal.cloudapp.net ([13.68.195.119])
        by smtp.gmail.com with ESMTPSA id y2sm21835328qkj.8.2019.07.24.22.03.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 22:03:50 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
X-Google-Original-From: Himadri Pandya <himadri18.07@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH 0/2] Drivers: hv: Specify buffer size using Hyper-V page size
Date:   Thu, 25 Jul 2019 05:03:13 +0000
Message-Id: <20190725050315.6935-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

recv_buffer and VMbus ring buffers are sized based on guest page size
which Hyper-V assumes to be 4KB. It might not be the case for some
architectures. Hence instead use the Hyper-V page size.

Himadri Pandya (2):
  Drivers: hv: Specify receive buffer size using Hyper-V page size
  Drivers: hv: util: Specify ring buffer size using Hyper-V page size

 drivers/hv/hv_fcopy.c    |  3 ++-
 drivers/hv/hv_kvp.c      |  3 ++-
 drivers/hv/hv_snapshot.c |  3 ++-
 drivers/hv/hv_util.c     | 13 +++++++------
 4 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.17.1

