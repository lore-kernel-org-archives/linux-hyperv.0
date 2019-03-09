Return-Path: <SRS0=dnxS=RM=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EA9C43381
	for <linux-hyperv@archiver.kernel.org>; Sat,  9 Mar 2019 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7672081B
	for <linux-hyperv@archiver.kernel.org>; Sat,  9 Mar 2019 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552116103;
	bh=qlv+LrDu6CgHaITWEndrpEiHYRBHefecu/t1KhNbGU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wJ+rwqaIeOR3EcLkY5+mzoKzUVI+V12ebHnLoqHwhef9RiLihrzKjBkfnKeKchnNm
	 n9THSwxgtL0cxBtix/ytU0UoDobq10KoG5Ofh3WEhEeI50cwSfpCH33HV7yXB6K5sx
	 +CTozBupI0RoEJfVWqSDBvX1DdWvGxpk1lbtXSnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCIHVi (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 9 Mar 2019 02:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfCIHVi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 9 Mar 2019 02:21:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB022081B;
        Sat,  9 Mar 2019 07:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552116097;
        bh=qlv+LrDu6CgHaITWEndrpEiHYRBHefecu/t1KhNbGU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srjpvoOqsvXxd8+/KQo92zOr0aERrQDaDVpbajsiG19zsIwF3VJHQ+4XGEJzjK+Dn
         KeUSppvVG/ujqU2dNGF4OOQPfwr6e/40NXsTt5Gun2ErM/rZJQL01mdHDysjzv4iGV
         DAFTFODH9FN1RY7aOWoqxx7ilx1nMGJV4Qnq0fEs=
Date:   Sat, 9 Mar 2019 08:21:35 +0100
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
Subject: Re: [PATCH v5] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Message-ID: <20190309072135.GG3882@kroah.com>
References: <20190301191824.GA4108@ubu-Virtual-Machine>
 <20190308224611.GA3047@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308224611.GA3047@ubu-Virtual-Machine>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 08, 2019 at 05:46:11PM -0500, Kimberly Brown wrote:
>  static struct kobj_type vmbus_chan_ktype = {
>  	.sysfs_ops = &vmbus_chan_sysfs_ops,
>  	.release = vmbus_chan_release,
> -	.default_attrs = vmbus_chan_attrs,

As discussed on IRC, a kobj_type needs to get an attribute group one of
these days, not just a attribute list :)

So thanks for persisting with this, sorry for the earlier review
comments, you were totally right about this, nice work.

Minor review comments below:

>  };
>  
>  /*
> @@ -1571,11 +1624,34 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
>  	if (ret)
>  		return ret;
>  
> +	ret = sysfs_create_group(kobj, &vmbus_chan_group);
> +	channel->sysfs_group_ready = !ret;

Why do you need this flag?

> +
> +	if (ret) {
> +		/*
> +		 * If an error is returned to the calling functions, those
> +		 * functions will call kobject_put() on the channel kobject,
> +		 * which will cleanup the empty channel directory created by
> +		 * kobject_init_and_add().

Why is this comment needed?

> +		 */
> +		pr_err("Unable to set up channel sysfs files\n");

dev_err() to show who had the problem with the files?

> +		return ret;
> +	}
> +
>  	kobject_uevent(kobj, KOBJ_ADD);
>  
>  	return 0;
>  }
>  
> +/*
> + * vmbus_remove_channel_attr_group - remove the channel's attribute group
> + */
> +void vmbus_remove_channel_attr_group(struct vmbus_channel *channel)
> +{
> +	if (channel->sysfs_group_ready)
> +		sysfs_remove_group(&channel->kobj, &vmbus_chan_group);

You should be able to just always remove these, no need for a flag to
say you have created them or not, right?

thanks,

greg k-h
