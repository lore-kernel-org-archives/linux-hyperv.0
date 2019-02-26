Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC57DC43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D97C217F5
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551169132;
	bh=0JV6VA8+mfx3k8ro0Aco18Zd4Jzci2z5u93qMkxYPbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nqk4ZaoMvIAVvyZ6ayUy7+gSVj2K9xPbj3EFMWZg2A3x6Dz9gBMUNE+anJL2RB3NR
	 fbXONIDuyn9TRETo+mYqns6H9yOnILTZ/OM8WEfsWAs2mLxVHvEn5NKdMaDWKpS/hZ
	 gJbhg1exWtAIyBOpPO3UYm/VFcqlaWMwX0Kz3DlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfBZISw (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfBZISw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 03:18:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0758A213A2;
        Tue, 26 Feb 2019 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551169130;
        bh=0JV6VA8+mfx3k8ro0Aco18Zd4Jzci2z5u93qMkxYPbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXNGPjrxLiJ5wYI6mdfb6qHIw2Pvdfigb2BoOh3vJabvrpd4hxkHGgDlSD9L8kdxn
         47G4aLBrYK3bZwDv/ueCBmxQIQNTvJtz8DyPHra8c57MAZOwrIFU1oGl0jKksofxgi
         m2fQjCHcBaTPoJwhs3ZlYgo/8Zwzp/QYpE0GJaz8=
Date:   Tue, 26 Feb 2019 09:18:48 +0100
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
Subject: Re: [PATCH v3] Drivers: hv: vmbus: Expose monitor data when channel
 uses monitor pages
Message-ID: <20190226081848.GA15659@kroah.com>
References: <7481d15f52427917a5f620e29308c1aa5c63f3eb.1550554279.git.kimbrownkd@gmail.com>
 <20190226053530.GA2897@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226053530.GA2897@ubu-Virtual-Machine>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 26, 2019 at 12:35:30AM -0500, Kimberly Brown wrote:
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
> Move the device-level monitor page attributes to a separate
> attribute_group struct. If the channel uses the monitor page mechanism,
> set up the sysfs files for these attributes in vmbus_device_register().
> 
> Move the channel-level monitor page attributes to a separate
> attribute_group struct. If the channel uses the monitor page mechanism,
> set up the sysfs files for these attributes in vmbus_add_channel_kobj().
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
> Changes in v3:
> The monitor "_show" functions no longer return an error when a channel
> does not use the monitor page mechanism. Instead, the monitor page sysfs
> files are created only when a channel uses the monitor page mechanism.
> This change was suggested by G. Kroah-Hartman.
> 
> Note: this patch was originally patch 2/2 in a patchset. Patch 1/2 has
> already been added to char-misc-testing, so I'm not resending it.
> 
> Changes in v2:
>  - Changed the return value for cases where monitor_allocated is not set
>    to "-EINVAL".
>  - Updated the commit message to provide more details about the monitor
>    page mechanism.
>  - Updated the sysfs documentation to describe the new return value.
> 
>  Documentation/ABI/stable/sysfs-bus-vmbus | 12 ++++--
>  drivers/hv/vmbus_drv.c                   | 52 +++++++++++++++++++-----
>  2 files changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
> index 826689dcc2e6..6d5cb195b119 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -81,7 +81,9 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/latency
>  Date:		September. 2017
>  KernelVersion:	4.14
>  Contact:	Stephen Hemminger <sthemmin@microsoft.com>
> -Description:	Channel signaling latency
> +Description:	Channel signaling latency. This file is available only for
> +		performance critical channels (storage, network, etc.) that use
> +		the monitor page mechanism.
>  Users:		Debugging tools
>  
>  What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/out_mask
> @@ -95,7 +97,9 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/pending
>  Date:		September. 2017
>  KernelVersion:	4.14
>  Contact:	Stephen Hemminger <sthemmin@microsoft.com>
> -Description:	Channel interrupt pending state
> +Description:	Channel interrupt pending state. This file is available only for
> +                performance critical channels (storage, network, etc.) that use
> +                the monitor page mechanism.
>  Users:		Debugging tools
>  
>  What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/read_avail
> @@ -137,7 +141,9 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/monitor_id
>  Date:		January. 2018
>  KernelVersion:	4.16
>  Contact:	Stephen Hemminger <sthemmin@microsoft.com>
> -Description:	Monitor bit associated with channel
> +Description:	Monitor bit associated with channel. This file is available only
> +		for performance critical channels (storage, network, etc.) that
> +		use the monitor page mechanism.
>  Users:		Debugging tools and userspace drivers
>  
>  What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 000b53e5a17a..ede858b0ee46 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -601,19 +601,12 @@ static DEVICE_ATTR_RW(driver_override);
>  static struct attribute *vmbus_dev_attrs[] = {
>  	&dev_attr_id.attr,
>  	&dev_attr_state.attr,
> -	&dev_attr_monitor_id.attr,
>  	&dev_attr_class_id.attr,
>  	&dev_attr_device_id.attr,
>  	&dev_attr_modalias.attr,
>  #ifdef CONFIG_NUMA
>  	&dev_attr_numa_node.attr,
>  #endif
> -	&dev_attr_server_monitor_pending.attr,
> -	&dev_attr_client_monitor_pending.attr,
> -	&dev_attr_server_monitor_latency.attr,
> -	&dev_attr_client_monitor_latency.attr,
> -	&dev_attr_server_monitor_conn_id.attr,
> -	&dev_attr_client_monitor_conn_id.attr,
>  	&dev_attr_out_intr_mask.attr,
>  	&dev_attr_out_read_index.attr,
>  	&dev_attr_out_write_index.attr,
> @@ -632,6 +625,22 @@ static struct attribute *vmbus_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(vmbus_dev);
>  
> +/*
> + *  Set up per device monitor page attributes. These attributes are used only by
> + *  channels that use the monitor page mechanism.
> + */
> +static struct attribute *vmbus_dev_monitor_attrs[] = {
> +	&dev_attr_monitor_id.attr,
> +	&dev_attr_server_monitor_pending.attr,
> +	&dev_attr_client_monitor_pending.attr,
> +	&dev_attr_server_monitor_latency.attr,
> +	&dev_attr_client_monitor_latency.attr,
> +	&dev_attr_server_monitor_conn_id.attr,
> +	&dev_attr_client_monitor_conn_id.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(vmbus_dev_monitor);

No need to create a special group for this and then manually add it if
you need it.  Just the is_visible() callback in the attribute instead, as
that is what it is there for.

Thanks,

greg k-h
