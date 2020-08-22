Return-Path: <SRS0=GYEm=CA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79484C433E1
	for <linux-hyperv@archiver.kernel.org>; Sat, 22 Aug 2020 08:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F6B2072D
	for <linux-hyperv@archiver.kernel.org>; Sat, 22 Aug 2020 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598086508;
	bh=GAiTXvJHEEGZWdKU8apDA/CFsEExKyFYa3WfQuWYNh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wFSRX7R6XnXqVffAWyqKtEiODWKQL0OA2FHWoMG14sHTuHgrxpPMMn7pTBWjmgJdD
	 Yy3VWUd5GmKfbMfX43Bie0pEUq7JZzL1E6j9JdiiGuUYgchThRaMR+qMYh2I5es7/N
	 NMwpV+43CtLNLGfsv5aWm/i5DDtyD7zhS2c9XymY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHVIzH (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:55:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44118 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgHVIzH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 22 Aug 2020 04:55:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so3949868wrs.11;
        Sat, 22 Aug 2020 01:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAiTXvJHEEGZWdKU8apDA/CFsEExKyFYa3WfQuWYNh4=;
        b=BKLK4kt0mouSo7RL/j+HIiEGIYc8QT8OvXbD/TbbvVIFAtbsQaEvrhvYJCM15WOkda
         FPgOW/F0BM1VB2tmeSFpzvbwliV9wr7Wkt3B4tuyYj+MbAMStmphNOl+iPfhG/3XL5RK
         m+6C8Pr61AjCbnZq4ykIsHQt9WZdGo1dBC9wuwMAWN12PBzCcGMSK+zX+E7MFNg+xtWk
         yedCT+UHzBkWfYGd4NqezIUPjavujW/japIqCHv2lwqDEnUMBTyEfeAAaVMR2zJJEAxh
         UUmV/IM1GfOacZeMeBgmkw2bNNRwaPqCr2cNW2F8k3wth2T01yRM+IdoniRno6ZXPcYV
         NVnQ==
X-Gm-Message-State: AOAM532l8tm4Kou/jbuRoWi3f3XimzMh+57IMRZK7TwHoW9TZplg5yPF
        mnIOQWdJJ1e3KnPW26UE1Bw=
X-Google-Smtp-Source: ABdhPJzj6v4Aj+FbjL+qjADXk0qjjQvefa6H0REh0p2Mw2dMnxfh54QzTrct4taXyT20r6x6u6KQrA==
X-Received: by 2002:adf:cd91:: with SMTP id q17mr6388427wrj.5.1598086506364;
        Sat, 22 Aug 2020 01:55:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v16sm10859714wmj.14.2020.08.22.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 01:55:05 -0700 (PDT)
Date:   Sat, 22 Aug 2020 08:55:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_utils: drain the timesync packets on
 onchannelcallback
Message-ID: <20200822085504.ryowfhild67ktu57@liuwe-devbox-debian-v2>
References: <20200821152849.99517-1-viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821152849.99517-1-viremana@linux.microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 03:28:49PM +0000, Vineeth Pillai wrote:
> There could be instances where a system stall prevents the timesync
> packaets to be consumed. And this might lead to more than one packet

Typo "packaet".

No need to resend. I can fix this while committing this patch.

Wei.
