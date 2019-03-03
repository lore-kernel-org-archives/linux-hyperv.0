Return-Path: <SRS0=cz4q=RG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8574DC43381
	for <linux-hyperv@archiver.kernel.org>; Sun,  3 Mar 2019 08:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A94720866
	for <linux-hyperv@archiver.kernel.org>; Sun,  3 Mar 2019 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551600348;
	bh=i5zU1TP1AoRx2PU99jqYvVklsnNCDLsdkBjWgzCmUDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IEnfqOU5OmqZn5OGE75nhZphqSFf+ZYiTnE6gy4rcC91swDPYyZI+TVlwc4Z+ss/O
	 5FhgRKjWtGyjg4CDmI1GaISUH9TT8waHdD6KnM+g2SgV66ZLjX0DdKL9UlQ03eWewx
	 ZEMj9TLbLWq9YUEidGs7VVKCc3/kVIiaA/lIV5z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfCCIFr (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 3 Mar 2019 03:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfCCIFr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Mar 2019 03:05:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4FB20863;
        Sun,  3 Mar 2019 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551600346;
        bh=i5zU1TP1AoRx2PU99jqYvVklsnNCDLsdkBjWgzCmUDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSzbeUxwu1ye9eYmjYQG3uR0dgYKiMCDO2FYuNZiEysvtTQKaerb3lYKb40D0iJiX
         u6dH4oeM/wgegzp2BcSTqUUtiFjW2dWuBlui0kKe+mhVOCPX/eNdcDGB+3nhbrJHMO
         7ZJ8I2WU1F773n9FG4Ggbm1VA9pT/CJJ+mvnCQCU=
Date:   Sun, 3 Mar 2019 09:05:43 +0100
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
Subject: Re: [PATCH v4] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Message-ID: <20190303080543.GA32186@kroah.com>
References: <20190226053530.GA2897@ubu-Virtual-Machine>
 <20190301191824.GA4108@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301191824.GA4108@ubu-Virtual-Machine>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 01, 2019 at 02:18:24PM -0500, Kimberly Brown wrote:
> +/*
> + * Channel-level attribute_group callback function. Returns the permission for
> + * each attribute, and returns 0 if an attribute is not visible.
> + */
> +static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
> +					  struct attribute *attr, int idx)
> +{
> +	const struct vmbus_channel *channel =
> +		container_of(kobj, struct vmbus_channel, kobj);
> +
> +	/* Hide the monitor attributes if the monitor mechanism is not used. */
> +	if (!channel->offermsg.monitor_allocated &&
> +	    (attr == &chan_attr_pending.attr ||
> +	     attr == &chan_attr_latency.attr ||
> +	     attr == &chan_attr_monitor_id.attr))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +static struct attribute_group vmbus_chan_group = {
> +	.attrs = vmbus_chan_attrs,
> +	.is_visible = vmbus_chan_attr_is_visible
> +};
> +
>  static struct kobj_type vmbus_chan_ktype = {
>  	.sysfs_ops = &vmbus_chan_sysfs_ops,
>  	.release = vmbus_chan_release,
> -	.default_attrs = vmbus_chan_attrs,

Why did you remove this line?

>  };
>  
>  /*
> @@ -1571,6 +1624,12 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
>  	if (ret)
>  		return ret;
>  
> +	ret = sysfs_create_group(kobj, &vmbus_chan_group);

Why are you adding these "by hand"?  What was wrong with using the
default attribute group pointer?  You also are not removing the
attributes :(

greg k-h
