Return-Path: <SRS0=T++6=RL=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C65C43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  8 Mar 2019 22:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9C32081B
	for <linux-hyperv@archiver.kernel.org>; Fri,  8 Mar 2019 22:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0HgBYG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCHWqR (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:46:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55683 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfCHWqR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Mar 2019 17:46:17 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so23285886itf.5;
        Fri, 08 Mar 2019 14:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8zzXLwm3W6+da6PHGf83Xpa1PYmftqDXMF3aOYJWJ3E=;
        b=i0HgBYG5tfeBitebZ9M1zCGAl6BdfOLKKbR+b0FSRlQQ16JkMmVrJlceVlkeDONmlK
         6Q1Fn7tW5mltguDMjrthHruYPKr7R4uGEUmEj3pHgiI8wsMFV3zSUz0bGWZZq+UWTO8Y
         5W9cDI9x0UirUzbR1fxEEvmN9yKYacDESRQHKXYlt6ZMCmuVVb63FXpQ3m4G5IfOv/xZ
         AqsKp0fdueOxVIMky8EQmT5RyUKh+Jegx1KCv+W6alJd2zcVfFQwEArXFP7AxhUnE/zj
         ReTlQhu4hAQ+nFgj1nb0nRrrbrzxwrWTGXN9WrXrTHavLmWpil2pNnrrF7egwrWwb5Mm
         tlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8zzXLwm3W6+da6PHGf83Xpa1PYmftqDXMF3aOYJWJ3E=;
        b=t6iRxtG7uWWAXI79dgAeTDrgEN24xNKKGQznv7RK8DetobdQHPSe93GCSW135K2K1H
         0sKONi06AGWTNFRLGIt09uSaM7lbYKLOMI9IzT7t4f1QiTcsybSSVTDL269kV/ridRYg
         I4yMg7TGYnYXXXxcFpEYs/Zbrm7yszKIdmRTFNk4UG2UEXvkAMuv+PYt8WoBUYaUTs7y
         nIogq19QY+w/hEuRK3HH+CP2RE9R3Yc69fMkhrPa9q5Ry812pL3RpYlha+1NP3M/L4cn
         OQGHHXts2iQMvFks1YKQuuF5+vkmxenCyBvBlsc9ghOImbRNOycEQLeLju9OoNlxUSHW
         SLGg==
X-Gm-Message-State: APjAAAW8MV5/ETwjQwsyXKHBGClch+YbACjG1Trnb6cF0Ez35WgAVtjV
        Bdw0SYzKglaRy/7zNIe1GJttvk0s
X-Google-Smtp-Source: APXvYqxIqGorK+SUGkZb8jen80xqEpyIv/PiOy6C2Aj9JCR5Q+LaXWUiFvoOl8cZAES5NhwC1KDw4w==
X-Received: by 2002:a24:59cf:: with SMTP id p198mr9742565itb.51.1552085175040;
        Fri, 08 Mar 2019 14:46:15 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id 202sm5233581itl.1.2019.03.08.14.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 14:46:14 -0800 (PST)
Date:   Fri, 8 Mar 2019 17:46:11 -0500
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
Subject: [PATCH v5] Drivers: hv: vmbus: Expose monitor data only when monitor
 pages are used
Message-ID: <20190308224611.GA3047@ubu-Virtual-Machine>
References: <20190301191824.GA4108@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190301191824.GA4108@ubu-Virtual-Machine>
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

Add the “bool sysfs_group_ready” field to the vmbus_channel struct.
This field is used to ensure that the attributes in the
“vmbus_chan_group” attribute group have been created. Add the
“vmbus_remove_channel_attr_group()” function, which calls
"sysfs_remove_group()" on “vmbus_chan_group” if the attributes were
created.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---

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
 drivers/hv/channel_mgmt.c                |  3 +
 drivers/hv/hyperv_vmbus.h                |  2 +
 drivers/hv/vmbus_drv.c                   | 80 +++++++++++++++++++++++-
 include/linux/hyperv.h                   |  6 ++
 5 files changed, 98 insertions(+), 5 deletions(-)

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
index 62703b354d6d..e4b1f0db8159 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -346,6 +346,9 @@ static void free_channel(struct vmbus_channel *channel)
 {
 	tasklet_kill(&channel->callback_event);
 
+	/* Remove the channel sysfs attribute group */
+	vmbus_remove_channel_attr_group(channel);
+
 	kobject_put(&channel->kobj);
 }
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index cb86b133eb4d..a94aab94e0b5 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -321,6 +321,8 @@ void vmbus_device_unregister(struct hv_device *device_obj);
 int vmbus_add_channel_kobj(struct hv_device *device_obj,
 			   struct vmbus_channel *channel);
 
+void vmbus_remove_channel_attr_group(struct vmbus_channel *channel);
+
 struct vmbus_channel *relid2channel(u32 relid);
 
 void vmbus_free_channels(void);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 000b53e5a17a..43a17e17f670 100644
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
@@ -1571,11 +1624,34 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	if (ret)
 		return ret;
 
+	ret = sysfs_create_group(kobj, &vmbus_chan_group);
+	channel->sysfs_group_ready = !ret;
+
+	if (ret) {
+		/*
+		 * If an error is returned to the calling functions, those
+		 * functions will call kobject_put() on the channel kobject,
+		 * which will cleanup the empty channel directory created by
+		 * kobject_init_and_add().
+		 */
+		pr_err("Unable to set up channel sysfs files\n");
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
+	if (channel->sysfs_group_ready)
+		sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
+}
+
 /*
  * vmbus_device_create - Creates and registers a new child device
  * on the vmbus.
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 64698ec8f2ac..604a2e05af47 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -934,6 +934,12 @@ struct vmbus_channel {
 	 * full outbound ring buffer.
 	 */
 	u64 out_full_first;
+
+	/*
+	 * Indicates whether the channel's attribute group sysfs files have
+	 * been successfully created.
+	 */
+	bool sysfs_group_ready;
 };
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
-- 
2.17.1

