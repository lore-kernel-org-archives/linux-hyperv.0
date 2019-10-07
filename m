Return-Path: <SRS0=FFb4=YA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B291DC47404
	for <linux-hyperv@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1012084D
	for <linux-hyperv@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PklRWDAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfJGQb7 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:31:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53534 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQb6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Oct 2019 12:31:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so162217wmd.3;
        Mon, 07 Oct 2019 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlmF+oTM7RARaq9sK2TT+5ACFjhWCemrjzKwsF1f3G8=;
        b=PklRWDAXNChgEGD/oZ8HSOdFqe1tCcZHNO12cFGrZNeHjQ/3hyhKtPXAJw8Y4pxFby
         PfDyiaMy+gZQ5n8Nhfxk/f4Hk9+Gt9JFaUa3H9Bbg9URi8qYdQA3iYEw12ywIHp3r4ec
         wr/4vW+Mgpr+gjhjut+gGtl0o20dwxuwtZUiPCxvmLOfgfM5VlFFQCm3Q871AccuZ+Xo
         EhTMK/Yafi48TQIFjkJi3vN1PXtWaZFmiO57ObEnN9EryYZ+hzmyVvIWU0/+FlEF0F5o
         X3JvhY6deVfDQ9ffHZj8OP5I1JVRMLCxt8LrqG+GqWle/6TrSwjMNLb6k0uWZ/Gfap1p
         hNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlmF+oTM7RARaq9sK2TT+5ACFjhWCemrjzKwsF1f3G8=;
        b=nu8hUjJGgjVKZweHGYjKOOTlxA5WZ26iWuSvyIvlvKUANV8Na+TpIPwNjtKfT4X/He
         l9Gv81S2P/9putl0Wj9pGYcgwue860J15OfUGV/pQY3H3inhBsEXxBrDtchKp7vxlKYD
         zOXAueP8EMESuWuNBthgFIQ3COrVBNc7J6WUllIwMDU258XNWqkY3srUoa7t0BdZo67/
         xORNCVTuS1IjyxWar0AntgZc6vFQZzXVVfrbct2zOLM3rwXiSllNYetWhe6A8JVZ8dUr
         ywUjFyKS1v8OdvJsRxF7CbBRf5YSFIRoFp2yM3Dro51PvdCaJHUT76LGo1hmqFxxUUYj
         I+3w==
X-Gm-Message-State: APjAAAWoRPx4lz7GYf6G+eO6gCS7g/nhNqYMsvRnYwQo3B9rwm/qd/X8
        Q4TY3Cy+NO7Q+oL2ruQanuxhHD91nJEIXQ==
X-Google-Smtp-Source: APXvYqwW5x36dcf1QgxFltvrhUk5N6IZtgO+Ok7naAT0W3ZkrorbJzoPSI7Gs2faRfMgpu3M15OhzA==
X-Received: by 2002:a1c:5942:: with SMTP id n63mr107452wmb.65.1570465916205;
        Mon, 07 Oct 2019 09:31:56 -0700 (PDT)
Received: from localhost.localdomain (userh394.uk.uudial.com. [194.69.102.21])
        by smtp.gmail.com with ESMTPSA id a9sm148524wmf.14.2019.10.07.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:31:55 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 0/2] Drivers: hv: vmbus: Miscellaneous improvements
Date:   Mon,  7 Oct 2019 18:31:13 +0200
Message-Id: <20191007163115.26197-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

The patchset:

- simplifies/refactors the VMBus negotiation code by introducing
  the table of VMBus protocol versions (patch 1/2),

- enables VMBus protocol versions 5.1 and 5.2 (patch 2/2).

Thanks,
  Andrea

Andrea Parri (2):
  Drivers: hv: vmbus: Introduce table of VMBus protocol versions
  Drivers: hv: vmbus: Enable VMBus protocol versions 5.1 and 5.2

 drivers/hv/connection.c | 63 +++++++++++++++++------------------------
 include/linux/hyperv.h  |  6 ++--
 2 files changed, 30 insertions(+), 39 deletions(-)

-- 
2.23.0

