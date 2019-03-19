Return-Path: <SRS0=7etu=RW=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B539C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 19 Mar 2019 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A82B20989
	for <linux-hyperv@archiver.kernel.org>; Tue, 19 Mar 2019 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552987573;
	bh=H8sqJx4xl9UyuHvAo1Fy0cMfbNSjhDJc0Zd4wT9Zjgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KBTWTDjsLLx6IbtgYM6C8mGzO18ytK+7+Rl5EtL2yUF+Kq5TffEBWWEszs5hMVM1Q
	 3j/DwmL/li4ki43sTTwAyQkUJtMYhBLDJJBrOsrEjNBVMPxiINoJcUy5ryngKRSitc
	 EdWMNt9pxVpJKZK3DBm0L8wC4S+JbPvw0pdOiOwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfCSJ0M (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfCSJ0M (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Mar 2019 05:26:12 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9C720857;
        Tue, 19 Mar 2019 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552987571;
        bh=H8sqJx4xl9UyuHvAo1Fy0cMfbNSjhDJc0Zd4wT9Zjgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z5ErkNYv70fk9stOATCBs2OsvnVgGVIwqdUwj52O7zrXo/hy6Fzuy5n9MoJlIlCfX
         7f0kA61sq3YGLPDax/KVp7RKWwlau+MwxcWj4v0RATtbYVQDJD3OCUpQiD2HFYUcQj
         TLXjFZeKbc+xICL8rMtqeeUzZBbn0vB72Ni/L2vI=
Date:   Tue, 19 Mar 2019 10:26:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Message-ID: <20190319092609.GB21652@kroah.com>
References: <20190308224611.GA3047@ubu-Virtual-Machine>
 <20190319040401.GA3050@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319040401.GA3050@ubu-Virtual-Machine>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 19, 2019 at 12:04:01AM -0400, Kimberly Brown wrote:
> There are two methods for signaling the host: the monitor page mechanism
> and hypercalls. The monitor page mechanism is used by performance
> critical channels (storage, networking, etc.) because it provides
> improved throughput. However, latency is increased. Monitor pages are
> allocated to these channels.
> 
> Monitor pages are not allocated to channels that do not use the monitor
> page mechanism. Therefore, these channels do not have a valid monitor id
> or valid monitor page data. In these cases, some of the "_show"
> functions return incorrect data. They return an invalid monitor id and
> data that is beyond the bounds of the hv_monitor_page array fields.
> 
> The "channel->offermsg.monitor_allocated" value can be used to determine
> whether monitor pages have been allocated to a channel.
> 
> Add "is_visible()" callback functions for the device-level and
> channel-level attribute groups. These functions will hide the monitor
> sysfs files when the monitor mechanism is not used.
> 
> Remove ".default_attributes" from "vmbus_chan_attrs" and create a
> channel-level attribute group. These changes allow the new
> "is_visible()" callback function to be applied to the channel-level
> attributes.
> 
> Call "sysfs_create_group()" in "vmbus_add_channel_kobj()" to create the
> channel's sysfs files. Add a new function,
> “vmbus_remove_channel_attr_group()”, and call it in "free_channel()" to
> remove the channel's sysfs files when the channel is closed.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Nice work, thanks for all of the changes you have made to this over
time.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

