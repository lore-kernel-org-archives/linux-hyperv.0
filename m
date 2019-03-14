Return-Path: <SRS0=/bEP=RR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D0AC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B731720854
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 22:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="qEqaszIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfCNWpj (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:45:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42774 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCNWpj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Mar 2019 18:45:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id b2so4959616pgl.9
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Mar 2019 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EsL0PS/FM629mXkrIcnvAacOBIRrslVnwHtYAAnlSs=;
        b=qEqaszIx33x1+flV/V5WdLRW8Vc4EhIGulINXHIPZWs1w55oc/kwEM0HALMTXrH8B+
         cMBY14RQr0t0G7+OLLOe6BKMEf8K4tkJqGjNwFYOC2rn0YdTvjs7IJmWPw8fdZA3L+/9
         5xE0ybDbSCGG24LLeix3gP6r8q0xXPxh7DxHj6kH6Z6/BYkwxpqPoLq8/DC9cWHNRIKM
         JbLjG6t37bcsUJjYbgIX3F02Bawo0LPTBqDeDa22YM0Z7joSvrDoN7SiQAZsbewYvYrY
         Cah927lfeNuogt6IoGsQKA9MUXqzsq40DVvZEO/37gOLHO7DzASdCbPa2fYzUbJg6OHa
         XYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EsL0PS/FM629mXkrIcnvAacOBIRrslVnwHtYAAnlSs=;
        b=oVwYO8rEQCs/Nu6CSpSPL8VcNEOaDK/+QL1z2jwJSECXKDiaUwhRE1CP10qhD98nqS
         tUaH9jcgpzWCAeM+L2rN3u2tCpHPZlb6m/gmcdWlRLbuMJYxzmqigc0XPYn2fI0WJiVP
         vmxMXf6fmKT7F04akp3PwW8GwgXlylk9IpWw91UbMrl4jY9Aow2icF66weFDcJpWCDRc
         GOOuo4/bUEUMnK8LyYKGy0qaAm1BEobaY5zXf7BWvDXSada+WcxOJLADc6UUzdwVxxWl
         86QiI6VcfQn7RFwvpfyxb53VZ3nuXiPvFaGeLits1KAY1qRfIUNw/wL9tthogkbNEUjq
         P0mg==
X-Gm-Message-State: APjAAAVLIfU1G63YxEVMpgKG/A7ZHK8ClvaTxx+d2Yzl2l8XWYqhe5qk
        tYLERBqkx102rgyInjUpAAypHw==
X-Google-Smtp-Source: APXvYqyaSikELfsrlQSa8IPlFBaE6PeELk1iQ6OzmhVWOqAx1hxss6F6EXz/AEeeSRBqSLQmUaougQ==
X-Received: by 2002:a63:4e1d:: with SMTP id c29mr248831pgb.433.1552603537785;
        Thu, 14 Mar 2019 15:45:37 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c130sm159368pfb.145.2019.03.14.15.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 15:45:37 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:45:33 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Kimberly Brown" <kimbrownkd@gmail.com>
Cc:     "Michael Kelley" <mikelley@microsoft.com>,
        "Long Li" <longli@microsoft.com>,
        "Sasha Levin" <Alexander.Levin@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        "Dexuan Cui" <decui@microsoft.com>,
        "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Message-ID: <20190314154533.17c8a362@shemminger-XPS-13-9360>
In-Reply-To: <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
        <cover.1552592620.git.kimbrownkd@gmail.com>
        <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 14 Mar 2019 13:05:15 -0700
"Kimberly Brown" <kimbrownkd@gmail.com> wrote:

> Fix a race condition that can result in a ring buffer pointer being set
> to null while a "_show" function is reading the ring buffer's data. This
> problem was discussed here:
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> %2Flkml%2F2018%2F10%2F18%2F779&amp;data=02%7C01%7Csthemmin%40microsoft.com
> %7C1d7557d667b741bdbb6008d6a8b8620f%7C72f988bf86f141af91ab2d7cd011db47%7C1
> %7C0%7C636881907217609564&amp;sdata=1bUbLaxsODANM7lCBR8lxyYajNpufuwUW%2FOl
> vtGu2hU%3D&amp;reserved=0
> 
> To fix the race condition, add a new mutex lock to the
> "hv_ring_buffer_info" struct. Add a new function,
> "hv_ringbuffer_pre_init()", where a channel's inbound and outbound
> ring_buffer_info mutex locks are initialized.
> 
> Acquire/release the locks in the "hv_ringbuffer_cleanup()" function,
> which is where the ring buffer pointers are set to null.
> 
> Acquire/release the locks in the four channel-level "_show" functions
> that access ring buffer data. Remove the "const" qualifier from the
> "vmbus_channel" parameter and the "rbi" variable of the channel-level
> "_show" functions so that the locks can be acquired/released in these
> functions.
> 
> Acquire/release the locks in hv_ringbuffer_get_debuginfo(). Remove the
> "const" qualifier from the "hv_ring_buffer_info" parameter so that the
> locks can be acquired/released in this function.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c |  2 +
>  drivers/hv/hyperv_vmbus.h |  1 +
>  drivers/hv/ring_buffer.c  | 19 ++++++++-
>  drivers/hv/vmbus_drv.c    | 82 +++++++++++++++++++++++++--------------
>  include/linux/hyperv.h    |  7 +++-
>  5 files changed, 79 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 9d7f9c1c60c7..14543059cc3e 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -336,6 +336,8 @@ static struct vmbus_channel *alloc_channel(void)
>  	tasklet_init(&channel->callback_event,
>  		     vmbus_on_event, (unsigned long)channel);
>  
> +	hv_ringbuffer_pre_init(channel);
> +
>  	return channel;
>  }
>  
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index a94aab94e0b5..e5467b821f41 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -193,6 +193,7 @@ extern void hv_synic_clockevents_cleanup(void);
>  
>  /* Interface */
>  
> +void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
>  
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  		       struct page *pages, u32 pagecnt);
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 0386ff48c5ea..121a01c43298 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -166,14 +166,18 @@ hv_get_ringbuffer_availbytes(const struct
> hv_ring_buffer_info *rbi,
>  }
>  
>  /* Get various debug metrics for the specified ring buffer. */
> -int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info
> *ring_info,
> +int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
>  				struct hv_ring_buffer_debug_info
> *debug_info)
>  {
>  	u32 bytes_avail_towrite;
>  	u32 bytes_avail_toread;
>  
> -	if (!ring_info->ring_buffer)
> +	mutex_lock(&ring_info->ring_buffer_mutex);
> +
> +	if (!ring_info->ring_buffer) {
> +		mutex_unlock(&ring_info->ring_buffer_mutex);
>  		return -EINVAL;
> +	}
>  
>  	hv_get_ringbuffer_availbytes(ring_info,
>  				     &bytes_avail_toread,
> @@ -184,10 +188,19 @@ int hv_ringbuffer_get_debuginfo(const struct
> hv_ring_buffer_info *ring_info,
>  	debug_info->current_write_index =
> ring_info->ring_buffer->write_index;
>  	debug_info->current_interrupt_mask
>  		= ring_info->ring_buffer->interrupt_mask;
> +	mutex_unlock(&ring_info->ring_buffer_mutex);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(hv_ringbuffer_get_debuginfo);
>  
> +/* Initialize a channel's ring buffer info mutex locks */
> +void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
> +{
> +	mutex_init(&channel->inbound.ring_buffer_mutex);
> +	mutex_init(&channel->outbound.ring_buffer_mutex);
> +}
> +
>  /* Initialize the ring buffer. */
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  		       struct page *pages, u32 page_cnt)
> @@ -240,8 +253,10 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info
> *ring_info,
>  /* Cleanup the ring buffer. */
>  void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
>  {
> +	mutex_lock(&ring_info->ring_buffer_mutex);
>  	vunmap(ring_info->ring_buffer);
>  	ring_info->ring_buffer = NULL;
> +	mutex_unlock(&ring_info->ring_buffer_mutex);
>  }
>  
>  /* Write to the ring buffer. */
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7f15c41d952e..84f3a510b4c9 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1410,7 +1410,7 @@ static void vmbus_chan_release(struct kobject *kobj)
>  
>  struct vmbus_chan_attribute {
>  	struct attribute attr;
> -	ssize_t (*show)(const struct vmbus_channel *chan, char *buf);
> +	ssize_t (*show)(struct vmbus_channel *chan, char *buf);
>  	ssize_t (*store)(struct vmbus_channel *chan,
>  			 const char *buf, size_t count);
>  };
> @@ -1429,7 +1429,7 @@ static ssize_t vmbus_chan_attr_show(struct kobject
> *kobj,
>  {
>  	const struct vmbus_chan_attribute *attribute
>  		= container_of(attr, struct vmbus_chan_attribute, attr);
> -	const struct vmbus_channel *chan
> +	struct vmbus_channel *chan
>  		= container_of(kobj, struct vmbus_channel, kobj);
>  
>  	if (!attribute->show)
> @@ -1442,57 +1442,81 @@ static const struct sysfs_ops vmbus_chan_sysfs_ops
> = {
>  	.show = vmbus_chan_attr_show,
>  };
>  
> -static ssize_t out_mask_show(const struct vmbus_channel *channel, char
> *buf)
> +static ssize_t out_mask_show(struct vmbus_channel *channel, char *buf)
>  {
> -	const struct hv_ring_buffer_info *rbi = &channel->outbound;
> +	struct hv_ring_buffer_info *rbi = &channel->outbound;
> +	ssize_t ret;
>  
> -	if (!rbi->ring_buffer)
> +	mutex_lock(&rbi->ring_buffer_mutex);
> +	if (!rbi->ring_buffer) {
> +		mutex_unlock(&rbi->ring_buffer_mutex);
>  		return -EINVAL;
> +	}
>  
> -	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
> +	ret = sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
> +	mutex_unlock(&rbi->ring_buffer_mutex);
> +	return ret;
>  }
>  static VMBUS_CHAN_ATTR_RO(out_mask);
>  
> -static ssize_t in_mask_show(const struct vmbus_channel *channel, char
> *buf)
> +static ssize_t in_mask_show(struct vmbus_channel *channel, char *buf)
>  {
> -	const struct hv_ring_buffer_info *rbi = &channel->inbound;
> +	struct hv_ring_buffer_info *rbi = &channel->inbound;
> +	ssize_t ret;
>  
> -	if (!rbi->ring_buffer)
> +	mutex_lock(&rbi->ring_buffer_mutex);
> +	if (!rbi->ring_buffer) {
> +		mutex_unlock(&rbi->ring_buffer_mutex);
>  		return -EINVAL;
> +	}
>  
> -	return sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
> +	ret = sprintf(buf, "%u\n", rbi->ring_buffer->interrupt_mask);
> +	mutex_unlock(&rbi->ring_buffer_mutex);
> +	return ret;
>  }
>  static VMBUS_CHAN_ATTR_RO(in_mask);
>  
> -static ssize_t read_avail_show(const struct vmbus_channel *channel, char
> *buf)
> +static ssize_t read_avail_show(struct vmbus_channel *channel, char *buf)
>  {
> -	const struct hv_ring_buffer_info *rbi = &channel->inbound;
> +	struct hv_ring_buffer_info *rbi = &channel->inbound;
> +	ssize_t ret;
>  
> -	if (!rbi->ring_buffer)
> +	mutex_lock(&rbi->ring_buffer_mutex);
> +	if (!rbi->ring_buffer) {
> +		mutex_unlock(&rbi->ring_buffer_mutex);
>  		return -EINVAL;
> +	}
>  
> -	return sprintf(buf, "%u\n", hv_get_bytes_to_read(rbi));
> +	ret = sprintf(buf, "%u\n", hv_get_bytes_to_read(rbi));
> +	mutex_unlock(&rbi->ring_buffer_mutex);
> +	return ret;
>  }
>  static VMBUS_CHAN_ATTR_RO(read_avail);
>  
> -static ssize_t write_avail_show(const struct vmbus_channel *channel, char
> *buf)
> +static ssize_t write_avail_show(struct vmbus_channel *channel, char *buf)
>  {
> -	const struct hv_ring_buffer_info *rbi = &channel->outbound;
> +	struct hv_ring_buffer_info *rbi = &channel->outbound;
> +	ssize_t ret;
>  
> -	if (!rbi->ring_buffer)
> +	mutex_lock(&rbi->ring_buffer_mutex);
> +	if (!rbi->ring_buffer) {
> +		mutex_unlock(&rbi->ring_buffer_mutex);
>  		return -EINVAL;
> +	}
>  
> -	return sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
> +	ret = sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
> +	mutex_unlock(&rbi->ring_buffer_mutex);
> +	return ret;
>  }
>  static VMBUS_CHAN_ATTR_RO(write_avail);
>  
> -static ssize_t show_target_cpu(const struct vmbus_channel *channel, char
> *buf)
> +static ssize_t show_target_cpu(struct vmbus_channel *channel, char *buf)
>  {
>  	return sprintf(buf, "%u\n", channel->target_cpu);
>  }
>  static VMBUS_CHAN_ATTR(cpu, S_IRUGO, show_target_cpu, NULL);
>  
> -static ssize_t channel_pending_show(const struct vmbus_channel *channel,
> +static ssize_t channel_pending_show(struct vmbus_channel *channel,
>  				    char *buf)
>  {
>  	return sprintf(buf, "%d\n",
> @@ -1501,7 +1525,7 @@ static ssize_t channel_pending_show(const struct
> vmbus_channel *channel,
>  }
>  static VMBUS_CHAN_ATTR(pending, S_IRUGO, channel_pending_show, NULL);
>  
> -static ssize_t channel_latency_show(const struct vmbus_channel *channel,
> +static ssize_t channel_latency_show(struct vmbus_channel *channel,
>  				    char *buf)
>  {
>  	return sprintf(buf, "%d\n",
> @@ -1510,19 +1534,19 @@ static ssize_t channel_latency_show(const struct
> vmbus_channel *channel,
>  }
>  static VMBUS_CHAN_ATTR(latency, S_IRUGO, channel_latency_show, NULL);
>  
> -static ssize_t channel_interrupts_show(const struct vmbus_channel
> *channel, char *buf)
> +static ssize_t channel_interrupts_show(struct vmbus_channel *channel,
> char *buf)
>  {
>  	return sprintf(buf, "%llu\n", channel->interrupts);
>  }
>  static VMBUS_CHAN_ATTR(interrupts, S_IRUGO, channel_interrupts_show,
> NULL);
>  
> -static ssize_t channel_events_show(const struct vmbus_channel *channel,
> char *buf)
> +static ssize_t channel_events_show(struct vmbus_channel *channel, char
> *buf)
>  {
>  	return sprintf(buf, "%llu\n", channel->sig_events);
>  }
>  static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
>  
> -static ssize_t channel_intr_in_full_show(const struct vmbus_channel
> *channel,
> +static ssize_t channel_intr_in_full_show(struct vmbus_channel *channel,
>  					 char *buf)
>  {
>  	return sprintf(buf, "%llu\n",
> @@ -1530,7 +1554,7 @@ static ssize_t channel_intr_in_full_show(const
> struct vmbus_channel *channel,
>  }
>  static VMBUS_CHAN_ATTR(intr_in_full, 0444, channel_intr_in_full_show,
> NULL);
>  
> -static ssize_t channel_intr_out_empty_show(const struct vmbus_channel
> *channel,
> +static ssize_t channel_intr_out_empty_show(struct vmbus_channel *channel,
>  					   char *buf)
>  {
>  	return sprintf(buf, "%llu\n",
> @@ -1538,7 +1562,7 @@ static ssize_t channel_intr_out_empty_show(const
> struct vmbus_channel *channel,
>  }
>  static VMBUS_CHAN_ATTR(intr_out_empty, 0444, channel_intr_out_empty_show,
> NULL);
>  
> -static ssize_t channel_out_full_first_show(const struct vmbus_channel
> *channel,
> +static ssize_t channel_out_full_first_show(struct vmbus_channel *channel,
>  					   char *buf)
>  {
>  	return sprintf(buf, "%llu\n",
> @@ -1546,7 +1570,7 @@ static ssize_t channel_out_full_first_show(const
> struct vmbus_channel *channel,
>  }
>  static VMBUS_CHAN_ATTR(out_full_first, 0444, channel_out_full_first_show,
> NULL);
>  
> -static ssize_t channel_out_full_total_show(const struct vmbus_channel
> *channel,
> +static ssize_t channel_out_full_total_show(struct vmbus_channel *channel,
>  					   char *buf)
>  {
>  	return sprintf(buf, "%llu\n",
> @@ -1554,14 +1578,14 @@ static ssize_t channel_out_full_total_show(const
> struct vmbus_channel *channel,
>  }
>  static VMBUS_CHAN_ATTR(out_full_total, 0444, channel_out_full_total_show,
> NULL);
>  
> -static ssize_t subchannel_monitor_id_show(const struct vmbus_channel
> *channel,
> +static ssize_t subchannel_monitor_id_show(struct vmbus_channel *channel,
>  					  char *buf)
>  {
>  	return sprintf(buf, "%u\n", channel->offermsg.monitorid);
>  }
>  static VMBUS_CHAN_ATTR(monitor_id, S_IRUGO, subchannel_monitor_id_show,
> NULL);
>  
> -static ssize_t subchannel_id_show(const struct vmbus_channel *channel,
> +static ssize_t subchannel_id_show(struct vmbus_channel *channel,
>  				  char *buf)
>  {
>  	return sprintf(buf, "%u\n",
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 64698ec8f2ac..8b9a93c99c9b 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -141,6 +141,11 @@ struct hv_ring_buffer_info {
>  
>  	u32 ring_datasize;		/* < ring_size */
>  	u32 priv_read_index;
> +	/*
> +	 * The ring buffer mutex lock. This lock prevents the ring buffer
> from
> +	 * being freed while the ring buffer is being accessed.
> +	 */
> +	struct mutex ring_buffer_mutex;
>  };
>  
>  
> @@ -1206,7 +1211,7 @@ struct hv_ring_buffer_debug_info {
>  };
>  
>  
> -int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info
> *ring_info,
> +int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
>  				struct hv_ring_buffer_debug_info
> *debug_info);
>  
>  /* Vmbus interface */

Adding more locks will solve the problem but it seems like overkill.
Why not either use a reference count or an RCU style access for the
ring buffer?
