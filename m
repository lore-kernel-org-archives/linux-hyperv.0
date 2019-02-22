Return-Path: <SRS0=lZBM=Q5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3415C43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 03:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681172080F
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 03:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhnbIerN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfBVDrI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:47:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54642 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBVDrH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Feb 2019 22:47:07 -0500
Received: by mail-it1-f195.google.com with SMTP id f10so1193842ita.4;
        Thu, 21 Feb 2019 19:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sk41UeLkzzTn4KypRu0CQVd69ZDRQ+8bC0EFmE/pbHI=;
        b=PhnbIerNCcX5NidRyPlOeUTdsCjo7mLwWPDzkV5qgR3v92UTeKiczMhJySvGGk7Zvh
         LimSjpLxBHIrUam49H6/TWRye3QtvdjxeT+7GPf4QBy4Rt9DJxPxABUr8pI9kBaqtD34
         +4/KY6BryYYhJWIfDq3sEOZEWUUeoBOpb7ZzvzJ/IBfel1yTL/f1AX9oIsQUAMU7JgV/
         IhzBRTHTiXX2xJE4RhpL6+n4Up0tt9iO3QXmSV4YlMi6p8f9PhnVlwNS+W9n0yL6vyXK
         lzMQfLZXqZSfNZL2gcAtICzMGOSlaWAYmMUK7FsfudnepjSLBrw79Bi73nfg8CQCtA4p
         LOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sk41UeLkzzTn4KypRu0CQVd69ZDRQ+8bC0EFmE/pbHI=;
        b=amX+MoDLwf2ZmVOOuLIrdU/R+gAwtk6fzQCLfj1YX4gMzy1aHhBHe2ZbnQ3mhA3pXJ
         5eFq/RqC1twzKvjMchHPqKYTdYzZNUEJ5FsK9mTaSwyLEGWPNIrHwMne5WirSg2B1umL
         wUGRntM04aNa3+d2CS2IMiUKW0qKCPWyEPW8eFsz7x9QHPwL6jlSQV2s+gj0siqn+/hC
         plc0s9EtJ8POq6ChOPZUlRFXJREn0TK6txBgjwhFtDUczaIvfKyxa+vZFA+GYL/+vW9S
         gc2hthFhJv5d78WvkT0jsj88EyHSwgy1XZbQ7hQZjsG79sSm2+BlyVUpwiQTDsuAeF/Z
         8M6g==
X-Gm-Message-State: AHQUAuajAjy3JM4tMRqnEu1G53cmzANA9bfG4MxyK3elRq1yWEazU/Pd
        bx6KT7Tlx/YZWsYazKh9lq4=
X-Google-Smtp-Source: AHgI3Iahz6D9R/hxwNHVKesX6x1KLD42eq1AzQqV0D6yIKlh5pLAm1iV5iZhysd+q/+Xut8Adkw6ww==
X-Received: by 2002:a02:393:: with SMTP id e19mr1223642jae.95.1550807226605;
        Thu, 21 Feb 2019 19:47:06 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id p17sm148675itp.36.2019.02.21.19.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 19:47:06 -0800 (PST)
Date:   Thu, 21 Feb 2019 22:47:03 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Refactor chan->state if statement
Message-ID: <1bb109543adc60c1f349e0c6f290591804b4289a.1550806305.git.kimbrownkd@gmail.com>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <cover.1550806305.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1550806305.git.kimbrownkd@gmail.com>
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
---
 drivers/hv/vmbus_drv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f290401f97e5..b02bcf1a9380 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1434,9 +1434,6 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
-	if (chan->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-
 	return attribute->show(chan, buf);
 }
 
@@ -1448,6 +1445,9 @@ static ssize_t out_mask_show(const struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->outbound;
 
+	if (!rbi->ring_buffer)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
 }
 static VMBUS_CHAN_ATTR_RO(out_mask);
@@ -1456,6 +1456,9 @@ static ssize_t in_mask_show(const struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->inbound;
 
+	if (!rbi->ring_buffer)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
 }
 static VMBUS_CHAN_ATTR_RO(in_mask);
@@ -1464,6 +1467,9 @@ static ssize_t read_avail_show(const struct vmbus_channel *channel, char *buf)
 {
 	const struct hv_ring_buffer_info *rbi = &channel->inbound;
 
+	if (!rbi->ring_buffer)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", hv_get_bytes_to_read(rbi));
 }
 static VMBUS_CHAN_ATTR_RO(read_avail);
@@ -1472,6 +1478,9 @@ static ssize_t write_avail_show(const struct vmbus_channel *channel, char *buf)
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

