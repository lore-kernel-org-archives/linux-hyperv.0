Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F9C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 06:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28182173C
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 06:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEI+ndgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfBZGYz (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:24:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40623 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfBZGYz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 01:24:55 -0500
Received: by mail-io1-f65.google.com with SMTP id p17so9622125iol.7;
        Mon, 25 Feb 2019 22:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cyqp8ogM4qWY6528hpiIHcgsFIxgO2ZDoWzsD72g5yI=;
        b=sEI+ndgy9ALErdMMYk6OamcmHP+TfagJ323l3quu7BwD7YMwzuJ3qhuMOJ61RGBXuS
         89J7eT/HiX13IQuvi9NazQRXO2q3ks9ffUQby4+6NiBD+G8X8anBM8mfrhonzETxepni
         5CmapjYubvEm0H7k4FzfKgMu33EAkbcg9vCSTMnWN+U9sV0NKRNhjO1oWXl7Uy9v5l0O
         ZT1ibGjcu2CKQeInf2XXUUAstLecJ7KuGLEJ5i91wU8Rnndi/XJvO2tPTEoB2HEia/3x
         4H+U/AUiQvEYWbKX2csIfxiCFdsAtefMEhyQeGvLBfpsp4eqQg/rcMk8NM0lc/9N030u
         oFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cyqp8ogM4qWY6528hpiIHcgsFIxgO2ZDoWzsD72g5yI=;
        b=UVVy/YyEzisndQYorh93Cir4+VIubYNHhzImfy/qNCNaaDQjEehokg2qSg+pit30t/
         doXYUzIJls1gn3v8canp5EH/BwDjtgo6kLaL5Pej4ZIQ8MXhCUK1gd6xfaitLKRvwqyB
         kk3JHYfbEGoZyk9Z9NGAqNqKrmSGZzqhHS0zPvCmICn5yshILEiz3+ZyNW2AmB1nuKeL
         o/V3O3SqJtACybySyEZlk88GEopssJ8RzPFxnL1KxR43e6mQI4A8RaOh3kUb9cuqVf1O
         19QSuP10TZg6sfTYH3zahSXp13YAmo5lyfdZxvp1EjpnDhSIL/2lf4zbZJCPZHhxxyA5
         rHmg==
X-Gm-Message-State: AHQUAuZx41XrtTP0811ipzwEMI8/6pOR6peLLsbqRaC182nzsib/lM2t
        E1YJcTzFykkLR0XT7+063Zo=
X-Google-Smtp-Source: AHgI3Ibl0id/DXcmf1+oH3vqg1zC58ojCMHXqC5N7grFZj9LpPHGEpqvcpqOVXkdG1lVqlbH1YiUvQ==
X-Received: by 2002:a6b:6d18:: with SMTP id a24mr12572989iod.292.1551162293972;
        Mon, 25 Feb 2019 22:24:53 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id a21sm4791589iod.63.2019.02.25.22.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 22:24:53 -0800 (PST)
Date:   Tue, 26 Feb 2019 01:24:51 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: Add a channel ring buffer
 mutex lock
Message-ID: <20190226062450.GA33641@ubu-Virtual-Machine>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <cover.1550806305.git.kimbrownkd@gmail.com>
 <c18bc31987ba67b8418fa2118f65bb258cb8899b.1550806305.git.kimbrownkd@gmail.com>
 <DM5PR2101MB0918921A96F16D862BA2AF0FD7790@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB0918921A96F16D862BA2AF0FD7790@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Feb 24, 2019 at 04:53:03PM +0000, Michael Kelley wrote:
> From: Kimberly Brown <kimbrownkd@gmail.com> Sent: Thursday, February 21, 2019 7:47 PM
> > 
> > The "_show" functions that access channel ring buffer data are
> > vulnerable to a race condition that can result in a NULL pointer
> > dereference. This problem was discussed here:
> > https://lkml.org/lkml/2018/10/18/779 
> >
> > To prevent this from occurring, add a new mutex lock,
> > "ring_buffer_mutex", to the vmbus_channel struct.
> > 
> > Acquire/release "ring_buffer_mutex" in the functions that can set the
> > ring buffer pointer to NULL: vmbus_free_ring() and __vmbus_open().
> > 
> > Acquire/release "ring_buffer_mutex" in the four channel-level "_show"
> > functions that access ring buffer data. Remove the "const" qualifier
> > from the "struct vmbus_channel *chan" parameter of the channel-level
> > "_show" functions so that "ring_buffer_mutex" can be acquired/released
> > in these functions.
> > 
> > Acquire/release "ring_buffer_mutex" in hv_ringbuffer_get_debuginfo().
> > Pass the channel pointer to hv_ringbuffer_get_debuginfo() so that
> > "ring_buffer_mutex" can be accessed in this function.
> > 
> > Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> 
> I've reviewed the code.  I believe it is correct and fixes the race
> condition.  Unfortunately, the code ended up being messier than I
> had hoped, and in particular, the need to pass the channel pointer
> into the ring buffer functions is distasteful.  An alternate idea is to
> put the new mutex into the hv_ring_buffer_info structure.  This results
> in two mutex's since there's a separate hv_ring_buffer_info structure for
> the "in" ring and the "out" ring.  But it makes the ring buffer functions
> more self-contained and able to operate without knowledge of the
> channel.   The mutex can be obtained in hv_ringbuffer_cleanup() instead
> of in the vmbus functions, and hv_ringbuffer_get_debuginfo() doesn't
> need the channel pointer.
> 
> The "const" still has to dropped from the channel pointer because
> the hv_ring_buffer_info structures are inline in the channel structure,
> but that's less objectionable.   The extra memory for two mutex's isn't
> really a problem, and none of the code paths are performance
> sensitive.
> 
> It's a tradeoff.  I think I slightly prefer moving the mutex to the
> hv_ring_buffer_info structure, but could also be persuaded to
> take it like it is.
> 

Thanks for the feedback! I don't have a compelling reason to keep the
lock in the vmbus_channel struct. I chose this approach because only one
lock would be required, rather than two. But, as you noted, using one
lock requires some tradeoffs.

I've looked through the changes that would be required to use two locks,
and I agree with you; I prefer using two locks. I'll submit a v3 for this
patch.

Thanks,
Kim



> Thoughts?
> 
> Michael
> 
