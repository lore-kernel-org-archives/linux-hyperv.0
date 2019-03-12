Return-Path: <SRS0=mRNI=RP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C46DC43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 00:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4432075C
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 00:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRq2K6gI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfCLAEy (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:04:54 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53587 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCLAEy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Mar 2019 20:04:54 -0400
Received: by mail-it1-f195.google.com with SMTP id x189so1569693itd.3;
        Mon, 11 Mar 2019 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/2Qa2e4UEqK/boVPhIKwaqF0oM6VtVD5qsDfr70Dho=;
        b=mRq2K6gITp61ApN0SLj4S9OAELSAcR8/59tG2kyQZVSHEjGwC2rEBEUPXPDx+zNZvO
         eHD6v7/RbUEwR7Bhg5PrwgSEKeFOrcCxC1keBovmW9YULHcbmEPrsFWlFjp4o6UJd2i6
         YXgOFc9O0xA18SCJdFHqZx+nOY/A84tdTbisYCx2vJ/eXyui2oQFBZbHj9PtGpRiFLYi
         rWfsOXNUi1AdO9Zf8nGvRHUvkoeOMBYCwcl6CAp0s+9v0sC9EvUv5dMpTwcUOtHTO7yM
         woroS54Ua/ASXjwae3vkHjTQxoWty9yGiCJ2CJ1Nq2/qqzL5dRkKGUPq9sWUVZt58y/n
         cacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/2Qa2e4UEqK/boVPhIKwaqF0oM6VtVD5qsDfr70Dho=;
        b=c2FsJ77RkX+ATvC578Z0/IyuTcJ9jkWGq7W/FLJL8ItFgLpMOYKSl5V2HyRl4NqKZe
         +M3nXY3AWmdBfw21S6SjJGQfWeYLAe9XhujJp1CAz52ikpsQNSIfBTTSSeKxaZsMbwp+
         +hg8ebd5r05kkqxfB182/rNj3UCogBPqndcvByrKkshF7r10TvP98SDuPS230YhDKYxe
         WDwzgEO2AVGmPCuhnMhbwIz4ZHe4qfvigx6Q8qKvs4V40CJzapYeZB2O2HlK67gebKjk
         gdY2x+Uz8ry5gR9g37Rtb71bC31eBNoRIMrb6oxYNEf1i2a/O7Wv/XKvTgyeZdNVLEQJ
         z2TA==
X-Gm-Message-State: APjAAAVRb/UWo6HBqDJ/RVPf6fMePhfJkS8adfm5beUVo4uSf7lSq2Q0
        f9eG1Eol9UCoBt1j3OKDvOg=
X-Google-Smtp-Source: APXvYqw240U8b/x+Mo2SnrQZ5DICtP17icV7c6TUoSyd3a9bWbPZcMzTdBw9lYI911XetX/kYxd3MQ==
X-Received: by 2002:a24:4290:: with SMTP id i138mr542504itb.24.1552349093561;
        Mon, 11 Mar 2019 17:04:53 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id d139sm430774itc.44.2019.03.11.17.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 17:04:52 -0700 (PDT)
Date:   Mon, 11 Mar 2019 20:04:50 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20190312000449.GA2741@ubu-Virtual-Machine>
References: <20190301191824.GA4108@ubu-Virtual-Machine>
 <20190308224611.GA3047@ubu-Virtual-Machine>
 <20190309072135.GG3882@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309072135.GG3882@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 09, 2019 at 08:21:35AM +0100, Greg KH wrote:
> On Fri, Mar 08, 2019 at 05:46:11PM -0500, Kimberly Brown wrote:
> >  static struct kobj_type vmbus_chan_ktype = {
> >  	.sysfs_ops = &vmbus_chan_sysfs_ops,
> >  	.release = vmbus_chan_release,
> > -	.default_attrs = vmbus_chan_attrs,
> 
> As discussed on IRC, a kobj_type needs to get an attribute group one of
> these days, not just a attribute list :)
> 
> So thanks for persisting with this, sorry for the earlier review
> comments, you were totally right about this, nice work.
> 
> Minor review comments below:
> 
> >  };
> >  
> >  /*
> > @@ -1571,11 +1624,34 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = sysfs_create_group(kobj, &vmbus_chan_group);
> > +	channel->sysfs_group_ready = !ret;
> 
> Why do you need this flag?
> 

I added this flag to prevent sysfs_remove_group() from being called if
sysfs_create_group() or the earlier call to kobject_init_and_add()
failed. However, it looks like that would just lead to WARN() being
called, which seems appropriate. I'll remove this flag.


> > +
> > +	if (ret) {
> > +		/*
> > +		 * If an error is returned to the calling functions, those
> > +		 * functions will call kobject_put() on the channel kobject,
> > +		 * which will cleanup the empty channel directory created by
> > +		 * kobject_init_and_add().
> 
> Why is this comment needed?
> 

Another reviewer asked why the empty directory created by
kobject_init_and_add() isn't removed here when sysfs_create_group()
fails. We decided that a comment would help clear up any future
confusion.


> > +		 */
> > +		pr_err("Unable to set up channel sysfs files\n");
> 
> dev_err() to show who had the problem with the files?
>

Yes, good point. I'll change this.


> > +		return ret;
> > +	}
> > +
> >  	kobject_uevent(kobj, KOBJ_ADD);
> >  
> >  	return 0;
> >  }
> >  
> > +/*
> > + * vmbus_remove_channel_attr_group - remove the channel's attribute group
> > + */
> > +void vmbus_remove_channel_attr_group(struct vmbus_channel *channel)
> > +{
> > +	if (channel->sysfs_group_ready)
> > +		sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
> 
> You should be able to just always remove these, no need for a flag to
> say you have created them or not, right?
> 
> thanks,
> 
> greg k-h
