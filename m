Return-Path: <SRS0=I8uC=5R=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD6C2D0E7
	for <linux-hyperv@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF06208FE
	for <linux-hyperv@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5mH9SLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgDAKgp (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:36:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgDAKgp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=05QXKWS1KqcrFB5NhBgUw/ejOvygxZ7y1z56i9t/j7E=;
        b=S5mH9SLpD9gwnEjGqBHEsbxztEJxr4sSiIltZn9etYWg9uM5HUsvZbcSfFnR1/IYRIDWDc
        X5a8b5c+z+jD+4mqmEtCJZ3FadTWx95jMxrjzgb/wZsgmpN6kCMVt71qtDmy0yC0650x7N
        sEWwhN4FLpfvKkUamTozkbgjv2Pa+eQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-KUnP7s1XOyuDaHyxdrqCqg-1; Wed, 01 Apr 2020 06:36:43 -0400
X-MC-Unique: KUnP7s1XOyuDaHyxdrqCqg-1
Received: by mail-wm1-f69.google.com with SMTP id c21so1647978wmb.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Apr 2020 03:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05QXKWS1KqcrFB5NhBgUw/ejOvygxZ7y1z56i9t/j7E=;
        b=ZyYwY0++QjMJJmYUtfpu3TYB+XD//vBkcoK9QpLCyHYAZ3a6NWflmZkyBd6Uhw9IiM
         HUcih0+cGVBl2xF6xfWBVTHCruinH9ZEkPawhbzJy5nUd25LknEh1EYV9GOFyZkXQZau
         h5v1p7s/RsiK3bmghGYI4eSUWUGSn3vK+VrXQA26eTUral/UBBYxUp9AuIOufbpwayzQ
         UP8d2bTbKB/R8Td2PoqFIwtovSWD0/pR8TOyW4yrMVPEJJ0HDJdRr8GlVY2BCIynBMkM
         Q8SO/gXEAfmF5fmAs9crLednOEQsx0ulfY+1EkknTC1EC6Xf0QBTS6IFqFA4AtQ/uQS/
         NUNA==
X-Gm-Message-State: ANhLgQ2EMomurM6wiN8/B8rBCJ+KOfXCm2/QUb8ukZqz/JnBoPl638d7
        1drd/59oOtBqV2SIxxsg9zTJv5+dln0hQgLEPAzZ+644RwHDvkijtDy67OYa3flb2coDoxhDth6
        +/QyYXRV0XZu221KJaUrW9S4l
X-Received: by 2002:adf:a18c:: with SMTP id u12mr24808826wru.325.1585737401780;
        Wed, 01 Apr 2020 03:36:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsk3gwZaCIoqXICrLYVNkXNloxQDGeyLUThiGBS8+UIEbwtoL5GPxoeWEZeSzECi02DkiyAtg==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr24808800wru.325.1585737401541;
        Wed, 01 Apr 2020 03:36:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 0/5] Drivers: hv: cleanup VMBus messages handling
Date:   Wed,  1 Apr 2020 12:36:33 +0200
Message-Id: <20200401103638.1406431-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A small cleanup series mostly aimed at sanitizing memory we pass to
message handlers: not passing garbage/lefrtovers from other messages
and making sure we fail early when hypervisor misbehaves.

No (real) functional change intended.

Vitaly Kuznetsov (5):
  Drivers: hv: copy from message page only what's needed
  Drivers: hv: allocate the exact needed memory for messages
  Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
  Drivers: hv: make sure that 'struct vmbus_channel_message_header'
    compiles correctly
  Drivers: hv: check VMBus messages lengths

 drivers/hv/channel_mgmt.c | 61 ++++++++++++++++++++-------------------
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 34 +++++++++++++++++-----
 include/linux/hyperv.h    |  2 +-
 4 files changed, 60 insertions(+), 38 deletions(-)

-- 
2.25.1

