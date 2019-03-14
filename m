Return-Path: <SRS0=/bEP=RR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77673C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 20:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBF92082F
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 20:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmpuRjYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCNUE5 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:04:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35516 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCNUE4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Mar 2019 16:04:56 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so6283068ion.2;
        Thu, 14 Mar 2019 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g99EPKxKMgj2H+cqNYPOHoYCKI5hzg27tCOeJsLf6eM=;
        b=pmpuRjYAqi2GBmUwoEYclzf2Uipfsv5OWZBETNx0IgCYH3OyO6YQO5Ds+HKQnqEP5c
         k0/bVxMhjTwTVlw8K9H7JXNwYaXjOAwFvSTKloBmxKbcyHAIwwKG0ZSTOLqbZYG01UiT
         WsXvHCYzGrvTAxP9vvVvpS7rstPQ56vYoJL2VBwQKLREFky2UTrgbBllwGxuxKp3Xcp5
         Afad8X/2tMcYd2Leb5Wjmn5xbZ/JjCg0GEiCG7CLcnabVtWlLInRstl11LpMXR8ydRWW
         IO1SBA9IpPwOjkPeBI+SvZndNZHugg0yxYBpIQyNMFPvZ3xwmSkuvb9/ISA/PAgQlX8G
         mvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g99EPKxKMgj2H+cqNYPOHoYCKI5hzg27tCOeJsLf6eM=;
        b=N8WAUKusFmcuFcmcWwLwh0KuDkbgl5XU2kPtC5E5fvdRbwxFTZ0Xvt6vztFcHfGu52
         OCfs/96fxdZmrB1hOQChKj/wmwtfjqX7ofXfkW+DkhgHLWDwcT0+A/Hp90htdK7wOL7x
         lRsMwz6RKRUw0PedcrQvUEDPSoayEVoxMhcc080mP9hT0WlAnyXOV4YCogr9eKcuj0yO
         za3doDygmD6pEHc2ebrF9Qcx9KRoNdEZuBiCRliqkLBcvpvUaxo34iNvMm7eZj3bryf+
         W4mipiisdn9rlBpMGtMmIYDJNDYf3iy7Izu4NXKT4SejDCvQzSnCLyAHmaVZF6x1GLVG
         SIAQ==
X-Gm-Message-State: APjAAAWAWgSBUC2jyXj+vOuf1Jlvsn9DxQFxge8jA+P7Hh8meUknNs74
        YhExhPU4vWcQvc5LCuh8tUU=
X-Google-Smtp-Source: APXvYqzFJI91QIQ3wFIj2Z6gYvEPR9SQDc7gjfozRskFVFI6oDjJHIKg50O0eewBe0n86TMkOBEV4Q==
X-Received: by 2002:a6b:6003:: with SMTP id r3mr22163874iog.231.1552593895611;
        Thu, 14 Mar 2019 13:04:55 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id w12sm7185739ioa.38.2019.03.14.13.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 13:04:54 -0700 (PDT)
Date:   Thu, 14 Mar 2019 16:04:52 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Drivers: hv: vmbus: Fix a race condition in "_show"
 functions
Message-ID: <cover.1552592620.git.kimbrownkd@gmail.com>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1550806305.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset fixes a race condition in the "_show" functions that
access the channel ring buffers.

Changes in v3:
Patch 1: Drivers: hv: vmbus: Refactor chan->state if statement
 - Added the “reviewed-by” line from v2.

Patch 2: Drivers: hv: vmbus: Set ring_info field to 0 and remove memset
 - This patch is new. This change allows the new mutex locks in patch 3
   to be initialized when the channel is initialized.

Patch 3: Drivers: hv: vmbus: Fix race condition with new
         ring_buffer_info mutex
 - Added two ring buffer info mutex locks instead of the single channel
   mutex lock that was proposed in v2.
 - Changed the mutex acquire/release calls as needed for the new ring
   buffer info mutex locks.
 - Updated the commit message.


Changes in v2:
 - In v1, I proposed using “vmbus_connection.channel_mutex” in the
   “_show” functions to prevent the race condition. However, using this
   mutex could result in a deadlock, so a new approach is proposed in
   this patchset.
 - Patch 1 is new and consists of refactoring an if statement.
 - Patch 2 introduces a new mutex lock in the “vmbus_channel” struct,
   which is used to eliminate the race condition.

Kimberly Brown (3):
  Drivers: hv: vmbus: Refactor chan->state if statement
  Drivers: hv: vmbus: Set ring_info field to 0 and remove memset
  Drivers: hv: vmbus: Fix race condition with new ring_buffer_info mutex

 drivers/hv/channel_mgmt.c |  2 +
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/ring_buffer.c  | 22 ++++++++--
 drivers/hv/vmbus_drv.c    | 89 +++++++++++++++++++++++++++------------
 include/linux/hyperv.h    |  7 ++-
 5 files changed, 88 insertions(+), 33 deletions(-)

-- 
2.17.1

