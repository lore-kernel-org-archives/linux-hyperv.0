Return-Path: <SRS0=cz4q=RG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A9C43381
	for <linux-hyperv@archiver.kernel.org>; Sun,  3 Mar 2019 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D531A20835
	for <linux-hyperv@archiver.kernel.org>; Sun,  3 Mar 2019 21:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de5RSEzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCCVlB (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:41:01 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41636 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfCCVlB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Mar 2019 16:41:01 -0500
Received: by mail-io1-f68.google.com with SMTP id 9so2480150iog.8;
        Sun, 03 Mar 2019 13:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sAs6pZLWOZiL9ot6Y8AZZHgU1XK0sPZul9PnLc4+yMY=;
        b=de5RSEzKZrY6UM+xZ80l/BZEgCN4VLLonGAuAxu2MCAvlOgke4wVuivkYHekr60aoL
         wDaANjbDmR84aduK++yg7LpQGz/uTirYhyAcpeu8lFes5QwZfNf1sDrM0JcuCTZDHAvQ
         E0jBda9PSHX9XjFQE2XgaExiv/XoPc98sJGa0AJz1JEcD7Ki8yyEQJlkelOpkeiwsfvI
         UGlTs+3aRKl9rLDgAN3aelWWn1p0OllkNltoh2Gs7wJjhOeQE49qYBGmJJhadGYJl+pI
         sl1jEVR2mq6NrNlu0sWD9et587MqK6e6GV7cWhlU7YyQdA0VaALD1cVi0p+1NPWsSgu/
         eVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sAs6pZLWOZiL9ot6Y8AZZHgU1XK0sPZul9PnLc4+yMY=;
        b=pQaDoIWb92i5xOKVRnQkXOpwzgflX6VYFiZECtav1R+m1/aUrHg7+fZDPcLdODvToE
         a/lLp2lp4Kuvk4GIEFuae2ibOQ00mHCW4VHRStSNnOYvd0SErIjq3WLgHJmPbDPLZd39
         bNvaVki8OK0m4HajHSV4fSt7oHlP5SXD5hMelySl+NoUzhqtlPf04WM62m5HedvSpF70
         pucLTaozdeM25Uxm7WwOl4oyl16izr+RFJ7OeT6uL/K3mkY5f4rjwfqTbpQCeX0bQisk
         CYW9zF7wAehr6uxvQq9f8zylAruCJunnJep15Otv6IsnACbLA4jXrxDdJwh8ppoQcYHK
         Qoow==
X-Gm-Message-State: APjAAAWxZo4u3uffAZUUDpKBHIg9x14TlAsS4t+2c2c63KO0PwmFoIwN
        aeCcMKZSQgO0e8+ZfyyMj4U=
X-Google-Smtp-Source: APXvYqy2zlqWXPoyPZiw6KbNSA9kZHICDfFF3PcU7cwMq7mvJwoi2LS7KWApTs5IKCaSg1OnsB+4kg==
X-Received: by 2002:a6b:914:: with SMTP id t20mr8073596ioi.63.1551649259788;
        Sun, 03 Mar 2019 13:40:59 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id l19sm1568958iob.46.2019.03.03.13.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 13:40:59 -0800 (PST)
Date:   Sun, 3 Mar 2019 16:40:56 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Message-ID: <20190303214056.GB2071@ubu-Virtual-Machine>
References: <20190226053530.GA2897@ubu-Virtual-Machine>
 <20190301191824.GA4108@ubu-Virtual-Machine>
 <DM5PR2101MB091825C55612FBCEA3322119D7770@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB091825C55612FBCEA3322119D7770@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 02, 2019 at 06:39:30PM +0000, Michael Kelley wrote:
> From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Friday, March 1, 2019 11:18 AM
> > 
> > +/*
> > + * Channel-level attribute_group callback function. Returns the permission for
> > + * each attribute, and returns 0 if an attribute is not visible.
> > + */
> > +static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
> > +					  struct attribute *attr, int idx)
> > +{
> > +	const struct vmbus_channel *channel =
> > +		container_of(kobj, struct vmbus_channel, kobj);
> > +
> > +	/* Hide the monitor attributes if the monitor mechanism is not used. */
> > +	if (!channel->offermsg.monitor_allocated &&
> > +	    (attr == &chan_attr_pending.attr ||
> > +	     attr == &chan_attr_latency.attr ||
> > +	     attr == &chan_attr_monitor_id.attr))
> > +		return 0;
> > +
> > +	return attr->mode;
> > +}
> > +
> > +static struct attribute_group vmbus_chan_group = {
> > +	.attrs = vmbus_chan_attrs,
> > +	.is_visible = vmbus_chan_attr_is_visible
> > +};
> > +
> >  static struct kobj_type vmbus_chan_ktype = {
> >  	.sysfs_ops = &vmbus_chan_sysfs_ops,
> >  	.release = vmbus_chan_release,
> > -	.default_attrs = vmbus_chan_attrs,
> 
> Just to double-check my understanding, removing the default_attrs
> here means that in vmbus_add_channel_kobj(), the call to
> kobject_init_and_add() will only create the sub-directory that is the
> channel number.  The sub-directory will be empty.  Then the new
> call to sysfs_create_group() that you added below will populate
> the subdirectory, as filtered by vmbus_chan_attr_is_visible().

Yes, that's my understanding as well.

> 
> >  };
> > 
> >  /*
> > @@ -1571,6 +1624,12 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct
> > vmbus_channel *channel)
> >  	if (ret)
> >  		return ret;
> > 
> > +	ret = sysfs_create_group(kobj, &vmbus_chan_group);
> > +	if (ret) {
> > +		pr_err("Unable to set up channel sysfs files\n");
> > +		return ret;
> 
> In this error case, the previously created sub-directory that is the
> channel number needs to be deleted/cleaned up.

I was going to let the kobject and sysfs systems take care of that. If
vmbus_add_channel_kobj() returns an error to the calling functions, they
call kobject_put(), which eventually removes the directory.

There are two functions that call vmbus_add_channel_kobj():
vmbus_add_channel_work() and vmbus_device_register(). If
vmbus_add_channel_kobj() returns an error to vmbus_add_channel_work(),
the function calls are:

free_channel() => kobject_put() (channel kobj ref. count should now be
0) => kobject_release() => kobject_cleanup() => kobject_del() =>
sysfs_remove_dir()

If vmbus_add_channel_kobject() returns an error to
vmbus_device_register(), the device's sub-directory is removed:

device_unregister() => put_device() => kobject_put() (device kobj ref.
count should now be 0) => kobject_release() => ...


So, I don't think its necessary to cleanup the subdirectory created by
kobject_init_and_add() here.

Thanks,
Kim


> 
> > +	}
> > +
> 
> Michael
