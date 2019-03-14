Return-Path: <SRS0=/bEP=RR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E5C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 20:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909EE2082F
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 20:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exYUW6Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCNUFF (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:05:05 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51698 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCNUFF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Mar 2019 16:05:05 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so6756941itl.1;
        Thu, 14 Mar 2019 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Wp80+44UXTvBPR/J8XZ3iMpuK3pkq3Zm7DfnTwZPdLE=;
        b=exYUW6Hj+2ZNKqs1phgx8NJ53TnESHzjVYoTDXHlWA1NQppEtSlEnw9QHHz4rSy7qd
         +tkqWIIo/tDYgwx/gCYvWmWZ4+o+2RfmdYWCPUFNfEAB3FgcnMr9jCXHCWBwVGvHy3py
         gU0TXViySqQVbLcqyMUpKkGwBPUFUhBUH5A8ouELCNz+5971kr+lrRSIzu6Y3Pxp4l6X
         8ldxqmFzkyWr6G25P8I1Y4CwCSb3VrXqgziuGb8o1bPEjqDMvHmFERwgTwhLa+cvlhXi
         soaQrXv98KeftfccIFceWh/88GYUdyN/uYCZBaQmKXjVynZx6AlJJ3WIRhh/eBimXV6n
         /qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wp80+44UXTvBPR/J8XZ3iMpuK3pkq3Zm7DfnTwZPdLE=;
        b=csi4W1aOq6fw+iYnN3OIHi3mx+jpN+xALoCW3RjyZURsIw0ydU7y9qY0j9DpDCthxh
         0T+16/x9ZIPVf/gVDsFgosxpHdm2AYBhkqZ3UvhKBTRpCHvchpRFldeMricoMTjxd62t
         x+Jvu36VjkfTAOzaZVDwjLmQJ820zBWdiK7q4L6xSPkn88IDcbPPQq41yPWPGrzojsL0
         iGrhJmcglHmcTSWS8GK89w8G6L0Os3EmTwIq1pJHycZdbxB4+Qkq3zQJ6PWKAh3EPWJD
         nIHoFxIgP6ouQgI2WsWAXs8x4twoaw4PVr+yD9Rnbbx59faHjEFqhR/YB5oeOha4F3Ht
         3EVw==
X-Gm-Message-State: APjAAAWjFpMGneAp1BF2sKO2dGtZLnylDGaUG2umZ09YGLAzTzG6r0TQ
        6diXbaovdhjjHxwVslHhKgMTKFkA
X-Google-Smtp-Source: APXvYqxjqmAxfQBWUgRfjBKD0RoijwZRxjrJX1Lahafpf09OAM0y+DDVUA8qV+PegqNtxGY7q3zXHw==
X-Received: by 2002:a02:6206:: with SMTP id d6mr57957jac.84.1552593903773;
        Thu, 14 Mar 2019 13:05:03 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id m23sm5006622ioh.29.2019.03.14.13.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 13:05:02 -0700 (PDT)
Date:   Thu, 14 Mar 2019 16:05:00 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] Drivers: hv: vmbus: Refactor chan->state if statement
Message-ID: <fcc9f3d305bb53c419090925932793ad01011dcd.1552592620.git.kimbrownkd@gmail.com>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1552592620.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The chan->state "if statement" was introduced in commit 6712cc9c2211
("vmbus: don't return values for uninitalized channels"). That commit
states that the purpose of the chan->state "if statement" is to prevent
returning garbage or causing a kernel OOPS when the channel ring buffer
is not initialized. The changes in this patch provide the same
protection.

Refactor the chan->state “if statement” in vmbus_chan_attr_show():
 - Instead of checking the channel state in the "if statement", check
   whether the channel ring buffer pointer is NULL. Checking the
   ring buffer pointer makes this code consistent with
   hv_ringbuffer_get_debuginfo().

 - Move the "if statement" to the four "_show" functions that access a
   channel ring buffer. Only four of the channel-level "_show" functions
   access a ring buffer. The ring buffer pointer does not need to be
   checked before calling the other "_show" functions, and moving the
   ring buffer pointer "if statement" to the "_show" functions that
   access a ring buffer makes the purpose of the "if statement" clear.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a7bb709870a8..7f15c41d952e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1435,9 +1435,6 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
-	if (chan->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-
 	return attribute->show(chan, buf);
 }
 
@@ -1449,6 +1446,9 @@ static ssize_t out_mask_show(const struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->outbound;
 
+	if (!rbi->ring_buffer)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
 }
 static VMBUS_CHAN_ATTR_RO(out_mask);
@@ -1457,6 +1457,9 @@ static ssize_t in_mask_show(const struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->inbound;
 
+	if (!rbi->ring_buffer)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
 }
 static VMBUS_CHAN_ATTR_RO(in_mask);
@@ -1465,6 +1468,9 @@ static ssize_t read_avail_show(const struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->inbound;
 
+	if (!rbi->ring_buffer)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", hv_get_bytes_to_read(rbi));
 }
 static VMBUS_CHAN_ATTR_RO(read_avail);
@@ -1473,6 +1479,9 @@ static ssize_t write_avail_show(const struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->outbound;
 
+	if (!rbi->ring_buffer)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
 }
 static VMBUS_CHAN_ATTR_RO(write_avail);
-- 
2.17.1

