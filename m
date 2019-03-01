Return-Path: <SRS0=e6q8=RE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAADC43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 19:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BABD2084F
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 19:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY3KJn/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCATSa (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:18:30 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34713 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCATSa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Mar 2019 14:18:30 -0500
Received: by mail-it1-f194.google.com with SMTP id d125so11101681ith.1;
        Fri, 01 Mar 2019 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EJvnz88PKXt2P/1f4lpJ20/ghJgBxLBmogUepF9SBG8=;
        b=PY3KJn/JV8oL2UFEKuIxQetuZ76EC3Ykeor87+m4jcZVqAp6rLNYOLJHTKmPeMPv2w
         8qp+zwVoz/dA6f4FNNy0R3mVZImAgFS0OYwf4cSttWgPNFuj7TzW65+ZMghTQtPDDx9n
         rYLWUov6atRtPZTUypYTOTclnQtaPctZWtG8fJEJGtwqiaD1w9u7bS4Y/dSO4+rO5vYI
         A/Sm5WDl0mvstC6WyQA+rsXk/T1mcOaNwrNR6jhr/uzwYoApZmXvOankh0ce1A8ZBZKI
         XjJFg+MTJWFfHz8B2ieqUKKW/P3igQXh7KDOaiKKrDY9dg5VhpYwXJZZg8ODwjNC2W9I
         Xe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EJvnz88PKXt2P/1f4lpJ20/ghJgBxLBmogUepF9SBG8=;
        b=VSDfdd7VEXwP5ImQLwe2NqDtft6O69kZ2SupG1HWqmHu5JOcfgRAWDd3BheTGQ4RiX
         3IUyKpX4PHzABSWZfKZGjVsQuhCYWYaN5rLTX2tLLz06/R2X2TmuNS4uK9i+JGrvBwKO
         Rtyvfik+SaJWAD0UsU0nS7bjLK6J9fw7AjuG6EPMLN/1iHdt1fjXwUkOXai9+x0IFVHV
         +epSZhljwEOyS84faAQLdD5TFAM/Lg354FvfdOAYuf8AEEzRLxJ/UKZvh62ap/QKFj5E
         khkPnU9N1l0gvUbhEMpNVDdVuVXHzoI7ohEHC5i7dOH12hshGQmF41SGCRupjqJSrT3i
         /tGg==
X-Gm-Message-State: APjAAAVpWQaPFi5dmj3B5oQqepswwdg/vbiwGCI5JQ8h5EPXq0Ih3iK3
        xwik5TUOL4B3UjyvIZcx/CE=
X-Google-Smtp-Source: APXvYqxWbEwgGZMoVDprLcUbC03ZDpY0nrFyTF+nu4qDS8USyU6fj885eHJqnmcj5O6NGIAQz4GkQw==
X-Received: by 2002:a02:12c4:: with SMTP id 65mr3809875jap.20.1551467908460;
        Fri, 01 Mar 2019 11:18:28 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id i14sm4987751itc.34.2019.03.01.11.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 11:18:27 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:18:24 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, gregkh@linuxfoundation.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] Drivers: hv: vmbus: Expose monitor data only when monitor
 pages are used
Message-ID: <20190301191824.GA4108@ubu-Virtual-Machine>
References: <20190226053530.GA2897@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226053530.GA2897@ubu-Virtual-Machine>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There are two methods for signaling the host: the monitor page mechanism
and hypercalls. The monitor page mechanism is used by performance
critical channels (storage, networking, etc.) because it provides
improved throughput. However, latency is increased. Monitor pages are
allocated to these channels.

Monitor pages are not allocated to channels that do not use the monitor
page mechanism. Therefore, these channels do not have a valid monitor id
or valid monitor page data. In these cases, some of the "_show"
functions return incorrect data. They return an invalid monitor id and
data that is beyond the bounds of the hv_monitor_page array fields.

The "channel->offermsg.monitor_allocated" value can be used to determine
whether monitor pages have been allocated to a channel.

Add "is_visible()" callback functions for the device-level and
channel-level attribute groups. These functions will hide the monitor
sysfs files when the monitor mechanism is not used.

Remove ".default_attributes" from "vmbus_chan_attrs" and create a
channel-level attribute group, "vmbus_chan_group". These changes allow
the new "is_visible()" callback function to be applied to the
channel-level attributes. Call "sysfs_create_group()" to create the
channel sysyfs files.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
Changes in v4:
 - Added “is_visible()” callback functions for the device-level and
   channel-level attribute groups.
 - Removed the separate monitor attribute groups proposed in v3. They’re
   no longer needed because the “is_visible()” callbacks are used to
   determine the attribute visibility.
 - Removed "default_attributes" from "vmbus_chan_attrs" and created a
   channel-level attribute group.
 - Removed the "kobject_put(kobj)" call proposed in v3. The calling
   functions take care of calling "kobject_put(channel->kobj)" if an
   error is returned by "vmbus_add_channel_kobj()".
 - Updated the commit message and subject for clarity and to reflect the
   new changes in v4.

Changes in v3:
 - The monitor "_show" functions no longer return an error when a
   channel does not use the monitor page mechanism. Instead, the monitor
   page sysfs files are created only when a channel uses the monitor
   page mechanism. This change was suggested by G. Kroah-Hartman.

Note: this patch was originally patch 2/2 in a patchset. Patch 1/2 has
already been added to char-misc-testing, so I'm not resending it.

Changes in v2:
 - Changed the return value for cases where monitor_allocated is not set
   to "-EINVAL".
 - Updated the commit message to provide more details about the monitor
   page mechanism.
 - Updated the sysfs documentation to describe the new return value.

 Documentation/ABI/stable/sysfs-bus-vmbus | 12 +++--
 drivers/hv/vmbus_drv.c                   | 63 +++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 826689dcc2e6..8e8d167eca31 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -81,7 +81,9 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/latency
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Channel signaling latency
+Description:	Channel signaling latency. This file is available only for
+		performance critical channels (storage, network, etc.) that use
+		the monitor page mechanism.
 Users:		Debugging tools
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/out_mask
@@ -95,7 +97,9 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/pending
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Channel interrupt pending state
+Description:	Channel interrupt pending state. This file is available only for
+		performance critical channels (storage, network, etc.) that use
+		the monitor page mechanism.
 Users:		Debugging tools
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/read_avail
@@ -137,7 +141,9 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/monitor_id
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Monitor bit associated with channel
+Description:	Monitor bit associated with channel. This file is available only
+		for performance critical channels (storage, network, etc.) that
+		use the monitor page mechanism.
 Users:		Debugging tools and userspace drivers
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 000b53e5a17a..44308220d540 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -630,7 +630,36 @@ static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_driver_override.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(vmbus_dev);
+
+/*
+ * Device-level attribute_group callback function. Returns the permission for
+ * each attribute, and returns 0 if an attribute is not visible.
+ */
+static umode_t vmbus_dev_attr_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	const struct hv_device *hv_dev = device_to_hv_device(dev);
+
+	/* Hide the monitor attributes if the monitor mechanism is not used. */
+	if (!hv_dev->channel->offermsg.monitor_allocated &&
+	    (attr == &dev_attr_monitor_id.attr ||
+	     attr == &dev_attr_server_monitor_pending.attr ||
+	     attr == &dev_attr_client_monitor_pending.attr ||
+	     attr == &dev_attr_server_monitor_latency.attr ||
+	     attr == &dev_attr_client_monitor_latency.attr ||
+	     attr == &dev_attr_server_monitor_conn_id.attr ||
+	     attr == &dev_attr_client_monitor_conn_id.attr))
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group vmbus_dev_group = {
+	.attrs = vmbus_dev_attrs,
+	.is_visible = vmbus_dev_attr_is_visible
+};
+__ATTRIBUTE_GROUPS(vmbus_dev);
 
 /*
  * vmbus_uevent - add uevent for our device
@@ -1550,10 +1579,34 @@ static struct attribute *vmbus_chan_attrs[] = {
 	NULL
 };
 
+/*
+ * Channel-level attribute_group callback function. Returns the permission for
+ * each attribute, and returns 0 if an attribute is not visible.
+ */
+static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int idx)
+{
+	const struct vmbus_channel *channel =
+		container_of(kobj, struct vmbus_channel, kobj);
+
+	/* Hide the monitor attributes if the monitor mechanism is not used. */
+	if (!channel->offermsg.monitor_allocated &&
+	    (attr == &chan_attr_pending.attr ||
+	     attr == &chan_attr_latency.attr ||
+	     attr == &chan_attr_monitor_id.attr))
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute_group vmbus_chan_group = {
+	.attrs = vmbus_chan_attrs,
+	.is_visible = vmbus_chan_attr_is_visible
+};
+
 static struct kobj_type vmbus_chan_ktype = {
 	.sysfs_ops = &vmbus_chan_sysfs_ops,
 	.release = vmbus_chan_release,
-	.default_attrs = vmbus_chan_attrs,
 };
 
 /*
@@ -1571,6 +1624,12 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	if (ret)
 		return ret;
 
+	ret = sysfs_create_group(kobj, &vmbus_chan_group);
+	if (ret) {
+		pr_err("Unable to set up channel sysfs files\n");
+		return ret;
+	}
+
 	kobject_uevent(kobj, KOBJ_ADD);
 
 	return 0;
-- 
2.17.1

