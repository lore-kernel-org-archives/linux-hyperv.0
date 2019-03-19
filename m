Return-Path: <SRS0=7etu=RW=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C25C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 19 Mar 2019 04:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A43F20854
	for <linux-hyperv@archiver.kernel.org>; Tue, 19 Mar 2019 04:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTvgi+/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfCSEEG (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:04:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45424 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCSEEG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Mar 2019 00:04:06 -0400
Received: by mail-io1-f68.google.com with SMTP id x9so16446562iog.12;
        Mon, 18 Mar 2019 21:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=muBSWe3x1lDU5VtJ3m8DQZD4Epd2BJiMfY/RBjW12V0=;
        b=qTvgi+/V0O6GHGfHq2WujdCoaHlGxBBu8GPPQTs8yrovP0pGAUqk1LS4EKFh9R9vQd
         UXLdKKfkej5HMptNr8R2rg31E/YPe4G8jaOMasirizyiqCSZulB36a5aTL6eZn+s1ngv
         /ENMTsmF/27Fkc3VL8It0iHUOflErMSoZrBUyfpENOPZ2vb6clPobYkTvaK2/ly/qc9d
         seIkJVmvn+LypGLJzXb97KD3qviDOCAwM0YTqni1pz/oZYSm/ULkHzmYgmLBSjiEK0Lz
         8xcySkPJjegdDAqkJUJ6e6x7ED3hqIvYtzIymIR0U/2WNHC0w1ArPgLE7iAVCVoNddnp
         FMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=muBSWe3x1lDU5VtJ3m8DQZD4Epd2BJiMfY/RBjW12V0=;
        b=BUmFBX7PUI4bQ+0987veyulNu5splHW8GVli4nQpKKcf1sBgeEdBjMYJOr4lkTiUrR
         djDRN0mcxwskT2VtY54iV0OTmVxy7v2Z7eRNgM3r5imOuzBspcMsWpHdUfTbH8X5qW3V
         92hfU4nqEJr4ZX7mo5dN67LlQjCZwRwD3/rykcSZAuOhBMle0TEGRLbNNp2AKaesYDfj
         3bkiWtGZppTIxWlP2C3/jQb1oK73rDd4BmguFiVew0z9MHWKugmidedDDrk7G4aQV+AN
         VqGrk6WoZAltGQWrPvxYHDJno+WVICj+6VluY2dxVtX8xOh+7xaPJ6eEQxfiEMEqdS7T
         Go2g==
X-Gm-Message-State: APjAAAUgpYyEwK3lsePbHIjR5mNFzCKA1E2sjrHU4sRXjgcvcU/agAB6
        G5BuycTpUl6NeVx3EzY8gwI=
X-Google-Smtp-Source: APXvYqxLHNO1WJwkMQvG/xw6Tzb5CEzeeRrBjpSJ4aaS8ZX1E/LsNFbb8aBsN+gmTPAP8Vf7p9JlPw==
X-Received: by 2002:a6b:6201:: with SMTP id f1mr186260iog.47.1552968244971;
        Mon, 18 Mar 2019 21:04:04 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id e72sm5353034iof.13.2019.03.18.21.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 21:04:04 -0700 (PDT)
Date:   Tue, 19 Mar 2019 00:04:01 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] Drivers: hv: vmbus: Expose monitor data only when monitor
 pages are used
Message-ID: <20190319040401.GA3050@ubu-Virtual-Machine>
References: <20190308224611.GA3047@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308224611.GA3047@ubu-Virtual-Machine>
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
channel-level attribute group. These changes allow the new
"is_visible()" callback function to be applied to the channel-level
attributes.

Call "sysfs_create_group()" in "vmbus_add_channel_kobj()" to create the
channel's sysfs files. Add a new function,
“vmbus_remove_channel_attr_group()”, and call it in "free_channel()" to
remove the channel's sysfs files when the channel is closed.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---

Changes in v6:
 - Removed the “sysfs_group_ready” flag proposed in v5. The flag was
   used to verify that the attribute group was created, which is
   unnecessary; sysfs_remove_group() can be called even when
   sysfs_create_group() fails.
 - Replaced pr_err() with dev_err() as suggested by G. Kroah-Hartman.
 - Shortened the error path comment in vmbus_add_channel_kobj().
 - Updated the commit message.

Changes in v5:
 - Added the “bool sysfs_group_ready” field to vmbus_channel.
 - Added the “vmbus_remove_channel_attr_group()” function which calls
   "sysfs_remove_group()".
 - Added a comment to "vmbus_add_channel_kobj()" to describe how the
   empty directory is removed if "sysfs_create_group()" returns an
   error.
 - Updated the commit message.

NOTE: “.default_attrs” must be removed from vmbus_chan_ktype in order to
use the is_visible() function because "default_attrs" is an array of
attributes, not an attribute_group.

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


Documentation/ABI/stable/sysfs-bus-vmbus | 12 +++-
 drivers/hv/channel_mgmt.c                |  1 +
 drivers/hv/hyperv_vmbus.h                |  2 +
 drivers/hv/vmbus_drv.c                   | 77 +++++++++++++++++++++++-
 4 files changed, 87 insertions(+), 5 deletions(-)

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
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f174b38f390f..3fc0b247a807 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -347,6 +347,7 @@ static struct vmbus_channel *alloc_channel(void)
 static void free_channel(struct vmbus_channel *channel)
 {
 	tasklet_kill(&channel->callback_event);
+	vmbus_remove_channel_attr_group(channel);
 
 	kobject_put(&channel->kobj);
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 50fabf4dcb75..e5467b821f41 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -322,6 +322,8 @@ void vmbus_device_unregister(struct hv_device *device_obj);
 int vmbus_add_channel_kobj(struct hv_device *device_obj,
 			   struct vmbus_channel *channel);
 
+void vmbus_remove_channel_attr_group(struct vmbus_channel *channel);
+
 struct vmbus_channel *relid2channel(u32 relid);
 
 void vmbus_free_channels(void);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 41f782af73ea..aa25f3bcbdea 100644
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
@@ -1583,10 +1612,34 @@ static struct attribute *vmbus_chan_attrs[] = {
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
@@ -1594,6 +1647,7 @@ static struct kobj_type vmbus_chan_ktype = {
  */
 int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 {
+	const struct device *device = &dev->device;
 	struct kobject *kobj = &channel->kobj;
 	u32 relid = channel->offermsg.child_relid;
 	int ret;
@@ -1604,11 +1658,30 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	if (ret)
 		return ret;
 
+	ret = sysfs_create_group(kobj, &vmbus_chan_group);
+
+	if (ret) {
+		/*
+		 * The calling functions' error handling paths will cleanup the
+		 * empty channel directory.
+		 */
+		dev_err(device, "Unable to set up channel sysfs files\n");
+		return ret;
+	}
+
 	kobject_uevent(kobj, KOBJ_ADD);
 
 	return 0;
 }
 
+/*
+ * vmbus_remove_channel_attr_group - remove the channel's attribute group
+ */
+void vmbus_remove_channel_attr_group(struct vmbus_channel *channel)
+{
+	sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
+}
+
 /*
  * vmbus_device_create - Creates and registers a new child device
  * on the vmbus.
-- 
2.17.1

