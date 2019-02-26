Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C052C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 05:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144562173C
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 05:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irBqeNBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfBZFff (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:35:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52248 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZFff (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 00:35:35 -0500
Received: by mail-it1-f196.google.com with SMTP id r11so2202401itc.2;
        Mon, 25 Feb 2019 21:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZCw4CMYjZjFf6MkmHznRnDSt4WHxHp44cJfFeywAXz0=;
        b=irBqeNBSWdh8c5wYo5+wxBwwS2Qa+qfesDdtMwORPQnzcUhewYDK4oKmi5+wmBILUD
         fwsyq0EnCmw5LIsHg4f8y4XgY+F0zqK+/LBkhrMj+IGGNkjfW8Ty/+ifRRqOzSIGkydU
         fT50aRd1XldO4KPi/+jsBjNbOKb0v8Xu7f9ok/vdZl6F7tBHkbfD+JhAVP+dgOrT3cK0
         w8averYwsv6E+mkCpeYS+ceMnVZq83uz9bIGTBmmiuHrmC8T58aoUwd9WbmLPenGDz6N
         O75AiUx/9PKnnivQJxqSRmvG8WEXqrRplZTxBaRfomkBvUTxP0Wj/NcdNr+2iAAr/nSL
         1F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCw4CMYjZjFf6MkmHznRnDSt4WHxHp44cJfFeywAXz0=;
        b=I9LUthsb/j07PjrNFtJWYWZgKIAp1+yxzd7HgdxUVeL2d/9EH4HTZJ6mzo3c1DJj8W
         rO/AhKhCAYfPaSwrdhbEBLofjI/nVzCPB0AXNOgJJuw6uMz6JksoEQcyIOmIiMwoJ2Ub
         ZHdbjszk9anM9lb8K/E0JBWyEAh11eIhGsLVMFS4NWHmOl08XzfWtAVsFC6/IxmQ+dK7
         5KUuc/gQz9QtGK3mFgljPGs+pz7M/3wS3ecNKyomxrA8vv5F9iorAdP0LS27tRT/SQZg
         cWwhGqCxFDAlCqQBMlWibBvUmFEmQ8evz7qbzvhWSnG99R+nfVIbLcg2lNEgDdreCQfR
         q/+g==
X-Gm-Message-State: AHQUAuYzqNOPOKNNZ1FXgnMFI6JQPWf9gFFU4yssP/f/0TMSDhb77Zg3
        7SWCptNYxnCIB6ccSh6IB+Y=
X-Google-Smtp-Source: AHgI3IZ7TeRYXhEH+Oj1TFTwyVGhrEZsirPVDZx6ZSO7QuuDOHl3j4aa0NLIZYNxVorWUOXXuV6zbQ==
X-Received: by 2002:a02:58d:: with SMTP id 13mr12183797jal.100.1551159333903;
        Mon, 25 Feb 2019 21:35:33 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id b36sm4898061itd.2.2019.02.25.21.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 21:35:33 -0800 (PST)
Date:   Tue, 26 Feb 2019 00:35:30 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, gregkh@linuxfoundation.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Drivers: hv: vmbus: Expose monitor data when channel uses
 monitor pages
Message-ID: <20190226053530.GA2897@ubu-Virtual-Machine>
References: <7481d15f52427917a5f620e29308c1aa5c63f3eb.1550554279.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7481d15f52427917a5f620e29308c1aa5c63f3eb.1550554279.git.kimbrownkd@gmail.com>
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

Move the device-level monitor page attributes to a separate
attribute_group struct. If the channel uses the monitor page mechanism,
set up the sysfs files for these attributes in vmbus_device_register().

Move the channel-level monitor page attributes to a separate
attribute_group struct. If the channel uses the monitor page mechanism,
set up the sysfs files for these attributes in vmbus_add_channel_kobj().

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
Changes in v3:
The monitor "_show" functions no longer return an error when a channel
does not use the monitor page mechanism. Instead, the monitor page sysfs
files are created only when a channel uses the monitor page mechanism.
This change was suggested by G. Kroah-Hartman.

Note: this patch was originally patch 2/2 in a patchset. Patch 1/2 has
already been added to char-misc-testing, so I'm not resending it.

Changes in v2:
 - Changed the return value for cases where monitor_allocated is not set
   to "-EINVAL".
 - Updated the commit message to provide more details about the monitor
   page mechanism.
 - Updated the sysfs documentation to describe the new return value.

 Documentation/ABI/stable/sysfs-bus-vmbus | 12 ++++--
 drivers/hv/vmbus_drv.c                   | 52 +++++++++++++++++++-----
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 826689dcc2e6..6d5cb195b119 100644
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
+                performance critical channels (storage, network, etc.) that use
+                the monitor page mechanism.
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
index 000b53e5a17a..ede858b0ee46 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -601,19 +601,12 @@ static DEVICE_ATTR_RW(driver_override);
 static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_id.attr,
 	&dev_attr_state.attr,
-	&dev_attr_monitor_id.attr,
 	&dev_attr_class_id.attr,
 	&dev_attr_device_id.attr,
 	&dev_attr_modalias.attr,
 #ifdef CONFIG_NUMA
 	&dev_attr_numa_node.attr,
 #endif
-	&dev_attr_server_monitor_pending.attr,
-	&dev_attr_client_monitor_pending.attr,
-	&dev_attr_server_monitor_latency.attr,
-	&dev_attr_client_monitor_latency.attr,
-	&dev_attr_server_monitor_conn_id.attr,
-	&dev_attr_client_monitor_conn_id.attr,
 	&dev_attr_out_intr_mask.attr,
 	&dev_attr_out_read_index.attr,
 	&dev_attr_out_write_index.attr,
@@ -632,6 +625,22 @@ static struct attribute *vmbus_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(vmbus_dev);
 
+/*
+ *  Set up per device monitor page attributes. These attributes are used only by
+ *  channels that use the monitor page mechanism.
+ */
+static struct attribute *vmbus_dev_monitor_attrs[] = {
+	&dev_attr_monitor_id.attr,
+	&dev_attr_server_monitor_pending.attr,
+	&dev_attr_client_monitor_pending.attr,
+	&dev_attr_server_monitor_latency.attr,
+	&dev_attr_client_monitor_latency.attr,
+	&dev_attr_server_monitor_conn_id.attr,
+	&dev_attr_client_monitor_conn_id.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(vmbus_dev_monitor);
+
 /*
  * vmbus_uevent - add uevent for our device
  *
@@ -1537,19 +1546,30 @@ static struct attribute *vmbus_chan_attrs[] = {
 	&chan_attr_read_avail.attr,
 	&chan_attr_write_avail.attr,
 	&chan_attr_cpu.attr,
-	&chan_attr_pending.attr,
-	&chan_attr_latency.attr,
 	&chan_attr_interrupts.attr,
 	&chan_attr_events.attr,
 	&chan_attr_intr_in_full.attr,
 	&chan_attr_intr_out_empty.attr,
 	&chan_attr_out_full_first.attr,
 	&chan_attr_out_full_total.attr,
-	&chan_attr_monitor_id.attr,
 	&chan_attr_subchannel_id.attr,
 	NULL
 };
 
+/* Set up per channel monitor page attributes. These attributes are used only by
+ * channels that use the monitor page mechanism.
+ */
+static struct attribute *vmbus_chan_monitor_attrs[] = {
+	&chan_attr_pending.attr,
+	&chan_attr_latency.attr,
+	&chan_attr_monitor_id.attr,
+	NULL
+};
+
+static struct attribute_group vmbus_chan_monitor_attr_group = {
+	.attrs = vmbus_chan_monitor_attrs,
+};
+
 static struct kobj_type vmbus_chan_ktype = {
 	.sysfs_ops = &vmbus_chan_sysfs_ops,
 	.release = vmbus_chan_release,
@@ -1571,6 +1591,15 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	if (ret)
 		return ret;
 
+	if (channel->offermsg.monitor_allocated) {
+		ret = sysfs_create_group(kobj, &vmbus_chan_monitor_attr_group);
+		if (ret) {
+			pr_err("Unable to set up monitor page sysfs files");
+			kobject_put(kobj);
+			return ret;
+		}
+	}
+
 	kobject_uevent(kobj, KOBJ_ADD);
 
 	return 0;
@@ -1615,6 +1644,9 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.parent = &hv_acpi_dev->dev;
 	child_device_obj->device.release = vmbus_device_release;
 
+	if (child_device_obj->channel->offermsg.monitor_allocated)
+		child_device_obj->device.groups = vmbus_dev_monitor_groups;
+
 	/*
 	 * Register with the LDM. This will kick off the driver/device
 	 * binding...which will eventually call vmbus_match() and vmbus_probe()
-- 
2.17.1

