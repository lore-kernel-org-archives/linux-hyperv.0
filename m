Return-Path: <SRS0=lZBM=Q5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C96C43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 03:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C203A2080F
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 03:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rODBu1dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfBVDq7 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:46:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36786 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBVDq7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Feb 2019 22:46:59 -0500
Received: by mail-io1-f67.google.com with SMTP id r136so727949iod.3;
        Thu, 21 Feb 2019 19:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kohoofnn6+gSvx9pNeiqTMMobMD8u2BzvI/Js2UiLuc=;
        b=rODBu1dC0U1Un0ehplkot5SC9sfAcqrbyf/1TTCxRr9O78F5WlaLHqvYrY+e/GX6Gq
         5CfsN/0fkBvHafvk0IsrScpCz9HNYYNCpvUywGCD6MwvyQ7vX/DzJ+9xuXVxkUTsNv6i
         mXQ4ggintoRr0ZBerogKhPX1f2659R5etvx5iEpnLRoCM6VEsVFniV7+XbBKtK6ZW0uI
         akb4FzynUeXxO+1gGZBUVObBEpYQkDLDzyBUe9L6jU/Y4aJa/SmvXCfh7oWJs/u2dOSb
         t9Pbbh6D0JgrR5ZBBz7SbbXEG5cKAxzClN/IwKIrIIGo5yK8TAJIYxDIq87kFr/HyX/O
         Q1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kohoofnn6+gSvx9pNeiqTMMobMD8u2BzvI/Js2UiLuc=;
        b=I4MR4/I5SiWkOzcrBiDRdEdFP9ITt2saeuxU1ssdAWrGxe8yfLNLTLkJ77Q+OFWwfM
         asv2yRYdAafzvvViGJ5VKksQWeRVEoMjPOlnIID8rSwflTkyYBYHPFW/m1SyyYcPAuAm
         LeVWQnIxCy8FPlhbOaeh/KZ0JNN4i61aNRpG4szMlqbmC2JNXMp/nWayo+T1EInqc+VV
         kMrM3hQgRku/FKO+hRnmvJ0+x0CAMi51v6EGGcYs8GED6LpxKvG5EhJJDhRL57ymQOEz
         g/GIbNob6Dvm+SuPKpQaEGdqYgjVUqHSxMnR1rqQ8BPRFMtlOGl/3gWgddwf0Oy//SJH
         klMg==
X-Gm-Message-State: AHQUAubbGUo7L/FUowuKWOKojz9kSgF0ZOjYORcjXPcMo0OGGpKN7plq
        95mCWPoxGbqZ5/TYMHSEm0I=
X-Google-Smtp-Source: AHgI3IbYTIV+iXHF4ANEsP+qJJsLsz1jrKGIGLoQ5ZR0vseS6KV/daoag/h6LobwL8xoJYT0jPnMjg==
X-Received: by 2002:a6b:7701:: with SMTP id n1mr1055784iom.143.1550807217794;
        Thu, 21 Feb 2019 19:46:57 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id g74sm155209itg.29.2019.02.21.19.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 19:46:57 -0800 (PST)
Date:   Thu, 21 Feb 2019 22:46:54 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix a race condition vulnerability in "_show"
 functions
Message-ID: <cover.1550806305.git.kimbrownkd@gmail.com>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122020759.GA4054@ubu-Virtual-Machine>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset fixes a race condition vulnerability in the "_show"
functions that access a channel ring buffer.

Changes in v2:
 - In v1, I proposed using “vmbus_connection.channel_mutex” in the
   “_show” functions to prevent the race condition. However, using this
   mutex could result in a deadlock, so a new approach is needed.

 - Patch 1 is new and consists of a code refactor.

 - Patch 2 introduces a new mutex lock in the “vmbus_channel” struct,
   and the new mutex is used to eliminate the race condition.

Kimberly Brown (2):
  Drivers: hv: vmbus: Refactor chan->state if statement
  Drivers: hv: vmbus: Add a channel ring buffer mutex lock

 drivers/hv/channel.c      |   5 ++
 drivers/hv/channel_mgmt.c |   1 +
 drivers/hv/ring_buffer.c  |  11 +++-
 drivers/hv/vmbus_drv.c    | 118 ++++++++++++++++++++++++++------------
 include/linux/hyperv.h    |  10 +++-
 5 files changed, 104 insertions(+), 41 deletions(-)

-- 
2.17.1

