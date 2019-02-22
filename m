Return-Path: <SRS0=lZBM=Q5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7C1C43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 03:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF08B2080F
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 03:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOWRADAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfBVDrT (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:47:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42240 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBVDrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Feb 2019 22:47:19 -0500
Received: by mail-io1-f66.google.com with SMTP id p196so696383iod.9;
        Thu, 21 Feb 2019 19:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BQuESBBgEdDBLGscfHgDkzpT5CHyQmlsLpoKrk/wzJs=;
        b=HOWRADAg2COkmgx5CcKJOhVAOmxCih1v5N05AT2Sv8lrC3edjKmGmLkURFEV7IuD7x
         PD+ujiU2AEmNFUSHaVdKeC3tsU94eVSLloCIsmF9E/wF7WowgCr0CECk0a5IrkTmOmTv
         z5Gv/lw8wpYAKFJeufvHHyIsiTFXzB81lqHi0wO1q+tLkhaN1WxeHASmhF+Zfaypsexo
         cagB/j9NBYS4/PppvKSLcYH7o8M813LBh9+x/fM0QJMODz0YA9REzoJ33QS0F1sPUD3G
         8Kzv4nb48tgsJXutmZdP8Dmd3ApGvMbz+3u8oNDuHDnnUNfZ51VDDhW3hwCpACgNG2VV
         pXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BQuESBBgEdDBLGscfHgDkzpT5CHyQmlsLpoKrk/wzJs=;
        b=WhDvxdurKrexDVKjrxbbELzCWvN7v7iLYQpOgERqBO7aI7z875HMeh7TYrDc9JkMTp
         2uxdw3bbQki4004wL9TJe6gJlgQHmJntkCihBKaNGLBtexGlABT27BYSrFhvDXs+AWHw
         938pFrwGpvSigwch3MFr2h84UsIJKZvRlGhOam1QsO9ZjybSHGgfu8JdQyMnb44nP+rX
         kCrvhoKrT5mgfilknL97uWIsz0IB9Ob4PI7AcuCGS850BdtrYZ0jlthK35KO+wht2ydb
         baAl2gn4bL+sR1qvXvto1O0DpQaloETGFA3+VAbbDVU5CuYlaY6g/vEKXAyA8MIk7EO/
         OCfg==
X-Gm-Message-State: AHQUAuawsS+zfnB9/9y/w1Fz+YdvAmZXZLTQbhAUwnAhzCiLEFIDu8+r
        0eqzZtLTSIhs0OHZKXt9LFE=
X-Google-Smtp-Source: AHgI3IZcBPnxQYg1C3c8tLiDXHRLN8r2jiYkHLaVcRW6NEKEVqtA/hJs20ok8BU6fGXx8Cgzg6CDeA==
X-Received: by 2002:a5e:a611:: with SMTP id q17mr1112532ioi.17.1550807237406;
        Thu, 21 Feb 2019 19:47:17 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id t1sm153174ioc.45.2019.02.21.19.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 19:47:16 -0800 (PST)
Date:   Thu, 21 Feb 2019 22:47:14 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Drivers: hv: vmbus: Add a channel ring buffer mutex
 lock
Message-ID: <c18bc31987ba67b8418fa2118f65bb258cb8899b.1550806305.git.kimbrownkd@gmail.com>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <cover.1550806305.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550806305.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The "_show" functions that access channel ring buffer data are
vulnerable to a race condition that can result in a NULL pointer
dereference. This problem was discussed here:
https://lkml.org/lkml/2018/10/18/779

To prevent this from occurring, add a new mutex lock,
"ring_buffer_mutex", to the vmbus_channel struct.

Acquire/release "ring_buffer_mutex" in the functions that can set the
ring buffer pointer to NULL: vmbus_free_ring() and __vmbus_open().

Acquire/release "ring_buffer_mutex" in the four channel-level "_show"
functions that access ring buffer data. Remove the "const" qualifier
from the "struct vmbus_channel *chan" parameter of the channel-level
"_show" functions so that "ring_buffer_mutex" can be acquired/released
in these functions.

Acquire/release "ring_buffer_mutex" in hv_ringbuffer_get_debuginfo().
Pass the channel pointer to hv_ringbuffer_get_debuginfo() so that
"ring_buffer_mutex" can be accessed in this function.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 drivers/hv/channel.c      |   5 ++
 drivers/hv/channel_mgmt.c |   1 +
 drivers/hv/ring_buffer.c  |  11 +++-
 drivers/hv/vmbus_drv.c    | 111 ++++++++++++++++++++++++--------------
 include/linux/hyperv.h    |  10 +++-
 5 files changed, 96 insertions(+), 42 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 23381c41d087..7770e97e4202 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -82,8 +82,10 @@ EXPORT_SYMBOL_GPL(vmbus_setevent);
 /* vmbus_free_ring - drop mapping of ring buffer */
 void vmbus_free_ring(struct vmbus_channel *channel)
 {
+	mutex_lock(&channel->ring_buffer_mutex);
 	hv_ringbuffer_cleanup(&channel->outbound);
 	hv_ringbuffer_cleanup(&channel->inbound);
+	mutex_unlock(&channel->ring_buffer_mutex);
 
 	if (channel->ringbuffer_page) {
 		__free_pages(channel->ringbuffer_page,
@@ -241,8 +243,11 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	vmbus_teardown_gpadl(newchannel, newchannel->ringbuffer_gpadlhandle);
 	newchannel->ringbuffer_gpadlhandle = 0;
 error_clean_ring:
+	mutex_lock(&newchannel->ring_buffer_mutex);
 	hv_ringbuffer_cleanup(&newchannel->outbound);
 	hv_ringbuffer_cleanup(&newchannel->inbound);
+	mutex_unlock(&newchannel->ring_buffer_mutex);
+
 	newchannel->state = CHANNEL_OPEN_STATE;
 	return err;
 }
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 62703b354d6d..769873cddfe5 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -329,6 +329,7 @@ static struct vmbus_channel *alloc_channel(void)
 
 	spin_lock_init(&channel->lock);
 	init_completion(&channel->rescind_event);
+	mutex_init(&channel->ring_buffer_mutex);
 
 	INIT_LIST_HEAD(&channel->sc_list);
 	INIT_LIST_HEAD(&channel->percpu_list);
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 9e8b31ccc142..35de60d2c1e8 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -167,13 +167,18 @@ hv_get_ringbuffer_availbytes(const struct hv_ring_buffer_info *rbi,
 
 /* Get various debug metrics for the specified ring buffer. */
 int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_info,
-				struct hv_ring_buffer_debug_info *debug_info)
+				struct hv_ring_buffer_debug_info *debug_info,
+				struct vmbus_channel *channel)
 {
 	u32 bytes_avail_towrite;
 	u32 bytes_avail_toread;
 
-	if (!ring_info->ring_buffer)
+	mutex_lock(&channel->ring_buffer_mutex);
+
+	if (!ring_info->ring_buffer) {
+		mutex_unlock(&channel->ring_buffer_mutex);
 		return -EINVAL;
+	}
 
 	hv_get_ringbuffer_availbytes(ring_info,
 				     &bytes_avail_toread,
@@ -184,6 +189,8 @@ int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_info,
 	debug_info->current_write_index = ring_info->ring_buffer->write_index;
 	debug_info->current_interrupt_mask
 		= ring_info->ring_buffer->interrupt_mask;
+	mutex_unlock(&channel->ring_buffer_mutex);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_ringbuffer_get_debuginfo);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b02bcf1a9380..1ff767795d0a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -345,9 +345,8 @@ static ssize_t out_intr_mask_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-
 	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
-					  &outbound);
+					  &outbound, hv_dev->channel);
 	if (ret < 0)
 		return ret;
 
@@ -366,7 +365,7 @@ static ssize_t out_read_index_show(struct device *dev,
 		return -ENODEV;
 
 	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
-					  &outbound);
+					  &outbound, hv_dev->channel);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", outbound.current_read_index);
@@ -385,7 +384,7 @@ static ssize_t out_write_index_show(struct device *dev,
 		return -ENODEV;
 
 	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
-					  &outbound);
+					  &outbound, hv_dev->channel);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", outbound.current_write_index);
@@ -404,7 +403,7 @@ static ssize_t out_read_bytes_avail_show(struct device *dev,
 		return -ENODEV;
 
 	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
-					  &outbound);
+					  &outbound, hv_dev->channel);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
@@ -423,7 +422,7 @@ static ssize_t out_write_bytes_avail_show(struct device *dev,
 		return -ENODEV;
 
 	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
-					  &outbound);
+					  &outbound, hv_dev->channel);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
@@ -440,7 +439,8 @@ static ssize_t in_intr_mask_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 
-	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound,
+					  hv_dev->channel);
 	if (ret < 0)
 		return ret;
 
@@ -458,7 +458,8 @@ static ssize_t in_read_index_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 
-	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound,
+					  hv_dev->channel);
 	if (ret < 0)
 		return ret;
 
@@ -476,7 +477,8 @@ static ssize_t in_write_index_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 
-	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound,
+					  hv_dev->channel);
 	if (ret < 0)
 		return ret;
 
@@ -495,7 +497,8 @@ static ssize_t in_read_bytes_avail_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 
-	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound,
+					  hv_dev->channel);
 	if (ret < 0)
 		return ret;
 
@@ -514,7 +517,8 @@ static ssize_t in_write_bytes_avail_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 
-	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound,
+					  hv_dev->channel);
 	if (ret < 0)
 		return ret;
 
@@ -1409,7 +1413,7 @@ static void vmbus_chan_release(struct kobject *kobj)
 
 struct vmbus_chan_attribute {
 	struct attribute attr;
-	ssize_t (*show)(const struct vmbus_channel *chan, char *buf);
+	ssize_t (*show)(struct vmbus_channel *chan, char *buf);
 	ssize_t (*store)(struct vmbus_channel *chan,
 			 const char *buf, size_t count);
 };
@@ -1428,7 +1432,7 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
 {
 	const struct vmbus_chan_attribute *attribute
 		= container_of(attr, struct vmbus_chan_attribute, attr);
-	const struct vmbus_channel *chan
+	struct vmbus_channel *chan
 		= container_of(kobj, struct vmbus_channel, kobj);
 
 	if (!attribute->show)
@@ -1441,58 +1445,89 @@ static const struct sysfs_ops vmbus_chan_sysfs_ops = {
 	.show = vmbus_chan_attr_show,
 };
 
-static ssize_t out_mask_show(const struct vmbus_channel *channel, char *buf)
+static ssize_t out_mask_show(struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->outbound;
+	ssize_t ret;
+
+	mutex_lock(&channel->ring_buffer_mutex);
 
-	if (!rbi->ring_buffer)
+	if (!rbi->ring_buffer) {
+		mutex_unlock(&channel->ring_buffer_mutex);
 		return -EINVAL;
+	}
 
-	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
+	ret = sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
+	mutex_unlock(&channel->ring_buffer_mutex);
+
+	return ret;
 }
 static VMBUS_CHAN_ATTR_RO(out_mask);
 
-static ssize_t in_mask_show(const struct vmbus_channel *channel, char *buf)
+static ssize_t in_mask_show(struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->inbound;
+	ssize_t ret;
 
-	if (!rbi->ring_buffer)
+	mutex_lock(&channel->ring_buffer_mutex);
+
+	if (!rbi->ring_buffer) {
+		mutex_unlock(&channel->ring_buffer_mutex);
 		return -EINVAL;
+	}
+
+	ret = sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
+	mutex_unlock(&channel->ring_buffer_mutex);
 
-	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
+	return ret;
 }
 static VMBUS_CHAN_ATTR_RO(in_mask);
 
-static ssize_t read_avail_show(const struct vmbus_channel *channel, char *buf)
+static ssize_t read_avail_show(struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->inbound;
+	ssize_t ret;
+
+	mutex_lock(&channel->ring_buffer_mutex);
 
-	if (!rbi->ring_buffer)
+	if (!rbi->ring_buffer) {
+		mutex_unlock(&channel->ring_buffer_mutex);
 		return -EINVAL;
+	}
+
+	ret = sprintf(buf, "%u\n", hv_get_bytes_to_read(rbi));
+	mutex_unlock(&channel->ring_buffer_mutex);
 
-	return sprintf(buf, "%u\n", hv_get_bytes_to_read(rbi));
+	return ret;
 }
 static VMBUS_CHAN_ATTR_RO(read_avail);
 
-static ssize_t write_avail_show(const struct vmbus_channel *channel, char *buf)
+static ssize_t write_avail_show(struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->outbound;
+	ssize_t ret;
 
-	if (!rbi->ring_buffer)
+	mutex_lock(&channel->ring_buffer_mutex);
+
+	if (!rbi->ring_buffer) {
+		mutex_unlock(&channel->ring_buffer_mutex);
 		return -EINVAL;
+	}
 
-	return sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
+	ret = sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
+	mutex_unlock(&channel->ring_buffer_mutex);
+
+	return ret;
 }
 static VMBUS_CHAN_ATTR_RO(write_avail);
 
-static ssize_t show_target_cpu(const struct vmbus_channel *channel, char *buf)
+static ssize_t show_target_cpu(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%u\n", channel->target_cpu);
 }
 static VMBUS_CHAN_ATTR(cpu, S_IRUGO, show_target_cpu, NULL);
 
-static ssize_t channel_pending_show(const struct vmbus_channel *channel,
-				    char *buf)
+static ssize_t channel_pending_show(struct vmbus_channel *channel, char *buf)
 {
 	if (!channel->offermsg.monitor_allocated)
 		return -EINVAL;
@@ -1503,8 +1538,7 @@ static ssize_t channel_pending_show(const struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR(pending, S_IRUGO, channel_pending_show, NULL);
 
-static ssize_t channel_latency_show(const struct vmbus_channel *channel,
-				    char *buf)
+static ssize_t channel_latency_show(struct vmbus_channel *channel, char *buf)
 {
 	if (!channel->offermsg.monitor_allocated)
 		return -EINVAL;
@@ -1515,19 +1549,19 @@ static ssize_t channel_latency_show(const struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR(latency, S_IRUGO, channel_latency_show, NULL);
 
-static ssize_t channel_interrupts_show(const struct vmbus_channel *channel, char *buf)
+static ssize_t channel_interrupts_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%llu\n", channel->interrupts);
 }
 static VMBUS_CHAN_ATTR(interrupts, S_IRUGO, channel_interrupts_show, NULL);
 
-static ssize_t channel_events_show(const struct vmbus_channel *channel, char *buf)
+static ssize_t channel_events_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%llu\n", channel->sig_events);
 }
 static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
 
-static ssize_t channel_intr_in_full_show(const struct vmbus_channel *channel,
+static ssize_t channel_intr_in_full_show(struct vmbus_channel *channel,
 					 char *buf)
 {
 	return sprintf(buf, "%llu\n",
@@ -1535,7 +1569,7 @@ static ssize_t channel_intr_in_full_show(const struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR(intr_in_full, 0444, channel_intr_in_full_show, NULL);
 
-static ssize_t channel_intr_out_empty_show(const struct vmbus_channel *channel,
+static ssize_t channel_intr_out_empty_show(struct vmbus_channel *channel,
 					   char *buf)
 {
 	return sprintf(buf, "%llu\n",
@@ -1543,7 +1577,7 @@ static ssize_t channel_intr_out_empty_show(const struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR(intr_out_empty, 0444, channel_intr_out_empty_show, NULL);
 
-static ssize_t channel_out_full_first_show(const struct vmbus_channel *channel,
+static ssize_t channel_out_full_first_show(struct vmbus_channel *channel,
 					   char *buf)
 {
 	return sprintf(buf, "%llu\n",
@@ -1551,7 +1585,7 @@ static ssize_t channel_out_full_first_show(const struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR(out_full_first, 0444, channel_out_full_first_show, NULL);
 
-static ssize_t channel_out_full_total_show(const struct vmbus_channel *channel,
+static ssize_t channel_out_full_total_show(struct vmbus_channel *channel,
 					   char *buf)
 {
 	return sprintf(buf, "%llu\n",
@@ -1559,7 +1593,7 @@ static ssize_t channel_out_full_total_show(const struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR(out_full_total, 0444, channel_out_full_total_show, NULL);
 
-static ssize_t subchannel_monitor_id_show(const struct vmbus_channel *channel,
+static ssize_t subchannel_monitor_id_show(struct vmbus_channel *channel,
 					  char *buf)
 {
 	if (!channel->offermsg.monitor_allocated)
@@ -1569,8 +1603,7 @@ static ssize_t subchannel_monitor_id_show(const struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR(monitor_id, S_IRUGO, subchannel_monitor_id_show, NULL);
 
-static ssize_t subchannel_id_show(const struct vmbus_channel *channel,
-				  char *buf)
+static ssize_t subchannel_id_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%u\n",
 		       channel->offermsg.offer.sub_channel_index);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 64698ec8f2ac..6a6f79d7beba 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -934,6 +934,13 @@ struct vmbus_channel {
 	 * full outbound ring buffer.
 	 */
 	u64 out_full_first;
+
+	/*
+	 * The mutex lock that protects the channel's ring buffers. It's used to
+	 * prevent the ring buffer pointers from being set to NULL while a
+	 * function is accessing ring buffer data.
+	 */
+	struct mutex ring_buffer_mutex;
 };
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
@@ -1207,7 +1214,8 @@ struct hv_ring_buffer_debug_info {
 
 
 int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_info,
-				struct hv_ring_buffer_debug_info *debug_info);
+				struct hv_ring_buffer_debug_info *debug_info,
+				struct vmbus_channel *channel);
 
 /* Vmbus interface */
 #define vmbus_driver_register(driver)	\
-- 
2.17.1

