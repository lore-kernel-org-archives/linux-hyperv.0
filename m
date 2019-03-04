Return-Path: <SRS0=2GwH=RH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB8BC43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 07:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4BD206B8
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 07:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551685127;
	bh=TiJMTXFuaHWrUlW1vJUoJQrBvqZ48J3PLcmDJMexoEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=axz5CtN1zEmgseAeUcTXpX1XSwy3WrmcE1KaGkSCQa+rROWuZDDK5lpNJ2O5c1cW3
	 91vVi+jxYoE0C1n1LUjOeTipAvph3nIE1OfbjMntugINzc8CN70LPrtCAyV5dpMFN8
	 cYEG9X4/Gp2Ihn0iWDHVg0V0y2AId/dVBnZpq5nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCDHir (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCDHiq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Mar 2019 02:38:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10107206B8;
        Mon,  4 Mar 2019 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551685125;
        bh=TiJMTXFuaHWrUlW1vJUoJQrBvqZ48J3PLcmDJMexoEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jg7sTjbPfZYQJT35IddXy73ojYHr7NX9CxSJhgla0tRKfWkfdDI3D51azLOLkoOCX
         VKOaS+x6EGznU75wxvuZq5ByD+Q54yYOZUY36qqr1bfLB78OhX5TsyCYLKlCWKXit4
         ynVSPtfrAN/EohVrW+Gv0q1ewFK4VLFTReH535LM=
Date:   Mon, 4 Mar 2019 08:38:42 +0100
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
Message-ID: <20190304073842.GD23573@kroah.com>
References: <20190226053530.GA2897@ubu-Virtual-Machine>
 <20190301191824.GA4108@ubu-Virtual-Machine>
 <20190303080543.GA32186@kroah.com>
 <20190303211128.GA2071@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303211128.GA2071@ubu-Virtual-Machine>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Mar 03, 2019 at 04:11:28PM -0500, Kimberly Brown wrote:
> On Sun, Mar 03, 2019 at 09:05:43AM +0100, Greg KH wrote:
> > On Fri, Mar 01, 2019 at 02:18:24PM -0500, Kimberly Brown wrote:
> > > +/*
> > > + * Channel-level attribute_group callback function. Returns the permission for
> > > + * each attribute, and returns 0 if an attribute is not visible.
> > > + */
> > > +static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
> > > +					  struct attribute *attr, int idx)
> > > +{
> > > +	const struct vmbus_channel *channel =
> > > +		container_of(kobj, struct vmbus_channel, kobj);
> > > +
> > > +	/* Hide the monitor attributes if the monitor mechanism is not used. */
> > > +	if (!channel->offermsg.monitor_allocated &&
> > > +	    (attr == &chan_attr_pending.attr ||
> > > +	     attr == &chan_attr_latency.attr ||
> > > +	     attr == &chan_attr_monitor_id.attr))
> > > +		return 0;
> > > +
> > > +	return attr->mode;
> > > +}
> > > +
> > > +static struct attribute_group vmbus_chan_group = {
> > > +	.attrs = vmbus_chan_attrs,
> > > +	.is_visible = vmbus_chan_attr_is_visible
> > > +};
> > > +
> > >  static struct kobj_type vmbus_chan_ktype = {
> > >  	.sysfs_ops = &vmbus_chan_sysfs_ops,
> > >  	.release = vmbus_chan_release,
> > > -	.default_attrs = vmbus_chan_attrs,
> > 
> > Why did you remove this line?
>  
> I removed the default attributes because vmbus_chan_attrs contains
> non-default attributes. You suggested that I use one attribute_group and
> an is_visible() callback for the device-level attributes (see
> https://lore.kernel.org/lkml/20190226081848.GA15659@kroah.com/). I
> assumed (possibly incorrectly) that I should do the same for these
> channel-level attributes.

That is fine to have a callback, but why did you have to remove the
default attribute pointer?  The two should have nothing to do with each
other.

> > >  };
> > >  
> > >  /*
> > > @@ -1571,6 +1624,12 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	ret = sysfs_create_group(kobj, &vmbus_chan_group);
> > 
> > Why are you adding these "by hand"?  What was wrong with using the
> > default attribute group pointer?  You also are not removing the
> > attributes :(
> 
> Are you referring to default_attrs in kobj_type? It's not an
> attribute_group pointer, it's a pointer to an attribute pointer array.
> The problem with using default_attrs is that all of the attributes are
> visible.

It shouldn't, the is_visable() callback will be called on each attribute
when the group is created by the core.  Did that not work properly when
you tested this?

> I'm fairly certain that the monitor attributes are being removed.
> sysfs_create_group() uses the attribute_group's is_visible() callback to
> control the attribute visibility. And, when I look at the sysfs files, I
> can see that the monitor sysyfs files are removed.

I mean you are not removing the group when the device goes away, not
that the individual files are not present.  If you leave the pointer to
default_attributes there, the core will properly remove the sysfs
attributes when the device is removed from the system.  Otherwise you
just "get lucky" if the attributes are removed or not.

> In v3, I proposed moving the monitor attributes to a special
> attribute_group and adding that group manually when needed. Do you
> prefer that approach for the channel-level monitor attributes?

No need for a special group here, just use the is_visable() callback
like you currently are, all should be fine.  I think you are adding more
code than you need to in order to get this to all work properly :)

thanks,

greg k-h
