Return-Path: <SRS0=cz4q=RG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F985C43381
	for <linux-hyperv@archiver.kernel.org>; Sun,  3 Mar 2019 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F6720830
	for <linux-hyperv@archiver.kernel.org>; Sun,  3 Mar 2019 21:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5nJ3Hgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCCVLc (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:11:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37569 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCCVLc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Mar 2019 16:11:32 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so2455231iop.4;
        Sun, 03 Mar 2019 13:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UlqwdBoM26XzEO4IUZVTE3fMlYnL5azn8awk8TJxkC0=;
        b=r5nJ3HgzQRToig0IMHGz+OUNsVA3vJmae/cNiKn8EJrOCcOYZFPcg/Sf5+Fl2Ls//3
         sJiGY/Qhq+2vEd1vkMHV89mZ7pWcMcR6l3PSkxgGU+hATRal0WVCO4k+K+z0q95c+kYq
         OaxBcsiNKHjF67mUhZob6Hp41JVLKwFF6ZtPqy3mAxh6zP7BUoV7M75Q9hV2+TlbJm+b
         35soozdU1mXa6PF9EDk2hQpR7JkF4Hgs5L+aW/CIDk+rBZ4xH8Ld1vBjOuU8x+AG90PU
         UFLgVoPxAN8jxaQnlBM3S7Wcl5ZAGFdY9XBPVu+b9SAqH00Hap+sGtpEKh6cFJF7/pGl
         Gr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlqwdBoM26XzEO4IUZVTE3fMlYnL5azn8awk8TJxkC0=;
        b=HyM7iASi9dRSYdEMYNtUuO5AvqxEa4wisue0EJxfd1MnEZ0azMWvOaxFTCyfE+4wkO
         yVfiFdE3gQ2oBXPdkZ0cyZtBwkuUf9erVUffs4Rxx9o7TQvRmL5VzVwGAAHZaKKUq/AS
         lFhjckq0/+Oki5r7BQW+105/nE/F2Uz+LMBGFFRA2Bjx2d/27lOcwX5BJEbl2Pf9BwZ/
         cB3JHjbK6bljkoyFwaWpGNpPYy4+p7WppeWh3DOk3PkcZr1yD8fZUTHLkf2Xgl2VKYAQ
         q7DGPTTlHpzUvJkHH1W76JIK+3liKQNRYym0kLU8w7mqeMG+IejAWGi6GFv0R4I2zoq3
         41DQ==
X-Gm-Message-State: APjAAAU4mNRojbCZBkcJe5Pjcr9wYywwvpHKZHZN9fdL+RWk1uz72/uE
        6nxxif0sYFoeq1ZQCCIeoso=
X-Google-Smtp-Source: APXvYqymWu0d44OvS+H+UkCb+fFBJ1i9oG9yiguNstvWjxqm96L0yQZvv3cq4Fu3SXFCPMZpnpcoxw==
X-Received: by 2002:a5e:c707:: with SMTP id f7mr8529259iop.76.1551647491320;
        Sun, 03 Mar 2019 13:11:31 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id v21sm2288395ita.21.2019.03.03.13.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 13:11:30 -0800 (PST)
Date:   Sun, 3 Mar 2019 16:11:28 -0500
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
Subject: Re: [PATCH v4] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Message-ID: <20190303211128.GA2071@ubu-Virtual-Machine>
References: <20190226053530.GA2897@ubu-Virtual-Machine>
 <20190301191824.GA4108@ubu-Virtual-Machine>
 <20190303080543.GA32186@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303080543.GA32186@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Mar 03, 2019 at 09:05:43AM +0100, Greg KH wrote:
> On Fri, Mar 01, 2019 at 02:18:24PM -0500, Kimberly Brown wrote:
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
> Why did you remove this line?
 
I removed the default attributes because vmbus_chan_attrs contains
non-default attributes. You suggested that I use one attribute_group and
an is_visible() callback for the device-level attributes (see
https://lore.kernel.org/lkml/20190226081848.GA15659@kroah.com/). I
assumed (possibly incorrectly) that I should do the same for these
channel-level attributes.


> >  };
> >  
> >  /*
> > @@ -1571,6 +1624,12 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = sysfs_create_group(kobj, &vmbus_chan_group);
> 
> Why are you adding these "by hand"?  What was wrong with using the
> default attribute group pointer?  You also are not removing the
> attributes :(

Are you referring to default_attrs in kobj_type? It's not an
attribute_group pointer, it's a pointer to an attribute pointer array.
The problem with using default_attrs is that all of the attributes are
visible.

I'm fairly certain that the monitor attributes are being removed.
sysfs_create_group() uses the attribute_group's is_visible() callback to
control the attribute visibility. And, when I look at the sysfs files, I
can see that the monitor sysyfs files are removed.

In v3, I proposed moving the monitor attributes to a special
attribute_group and adding that group manually when needed. Do you
prefer that approach for the channel-level monitor attributes?

Thanks,
Kim


> 
> greg k-h
