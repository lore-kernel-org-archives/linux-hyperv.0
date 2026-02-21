Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BA6FC5;
	Sat, 21 Feb 2026 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771638478; cv=none; b=ZxWpDrYqXGIhp94Nxp3n+Feqixm4q/I3kPrrcElhMmoYqk5NKdqkB5JD5Mn/biO4GrtYavf40FupnuK7fXYxyXp7PnId5WiLQleIsQiaYrSh1g2m2HccdDw1WWL/ttyumj9oE2mA0hJ4tHPkMtoNy+lS7NF9WOkj0ktKUBLBDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771638478; c=relaxed/simple;
	bh=xmbCS15vYD5GEuNeqtgemRsODzwek3gmG7RvPKbEBTU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lkfGb4vs0snWPIEcb76X4HHTwoavQcp3dmRTqDZaUeDEQVeADbHtKjoXgjWDGgoMojrA2O5jaTtMyBQq3IpEAiMgEGQYDdLzYEcBM4JetOUctXj2OMJ3ue4ToNiDJiFz0Bh09043wxfRqMC0s2z+39I7Z/Zg+8FoKoQaARP8l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Mc6s/Iun; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Mc6s/Iun"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fHqkb2wJ7z9tR2;
	Sat, 21 Feb 2026 02:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771638471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RjkiVnu78v4BP25QaPzneQ2qS2/od46N4qSv4+bCbg=;
	b=Mc6s/IunKpBzEf4UgQYrCwQfJiw6ClWkr8ceKm4tGgCiy8kg/T6iZp+3/MEl7149kdTn8j
	M7YZkKK+s7KTab5aABSwqvs2K63VWquwROQttye+JS77mXtziG90PwukZzCqCkxmJHqih9
	tm3i9IaeezcDffbE3iA6BnFJCFdyAvTc0Qxve7Pl5/i+fFNnZJxnSKTdix2xo9FPvLYnbP
	U57QmyGpIy0l7KJWiGGl/a1SSfmsr+gb1pMPKAp4bTQ9ilBk9aLL5PVSdFwZWano9fn6CS
	YtbciaLkHJoKXPEx2WcxwlBSjQUkfmhEQDR0cd/ohzmmklBOlwXTDn41HKLHBQ==
Date: Fri, 20 Feb 2026 17:47:49 -0800 (PST)
From: vdso@mailbox.org
To: mhklinux@outlook.com, Michael Kelley <mhklkml@zohomail.com>
Cc: linux-kernel@vger.kernel.org, kys@microsoft.com, wei.liu@kernel.org,
	haiyangz@microsoft.com, longli@microsoft.com, decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Message-ID: <1554036576.472972.1771638469213@app.mailbox.org>
In-Reply-To: <20260220164045.1670-1-mhklkml@zohomail.com>
References: <20260220164045.1670-1-mhklkml@zohomail.com>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Limit channel interrupt scan to
 relid high water mark
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 256082691585e84b9c2
X-MBO-RS-META: 69op9q3iu5jw11wcerja58unqh1or4fm

Hi Michael,

Boots for me on an x86_64 machine. Got a typo fix and a question for you.
Tagging as reviewed and tested regardless :) 

> On 02/20/2026 8:40 AM  Michael Kelley <mhklkml@zohomail.com> wrote:
> 
>  
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When checking for VMBus channel interrutps, current code always scans the

/s/interrutps/interrupts

> full SynIC receive interrupt bit array to get the relid of the
> interrupting channels. The array has HV_EVENT_FLAGS_COUNT (2048) bits.
> But VMs rarely have more than 100 channels, and the relid is typically
> a small integer that is densely assigned by the Hyper-V host. It's
> wasteful to scan 2048 bits when it is highly unlikely that anything will
> be found past bit 100. The waste is double with Confidential VMBus because
> there are two receive interrupt arrays that must be scanned: one for the
> hypervisor SynIC and one for the paravisor SynIC.
> 
> Improve the scanning by tracking the largest relid that has been offered
> by the Hyper-V host. Then when checking for VMBus channel interrupts, only
> scan up to this high water mark.
> 
> When channels are rescinded, it's not worth the complexity to recalculate
> the high water mark. Hyper-V tends to reuse the rescinded relids for any
> new channels that are subsequently added, and the performance benefit of
> exactly tracking the high water mark would be minimal.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Tested-by: Roman Kisel <vdso@mailbox.org>
Reviewed-by: Roman Kisel <vdso@mailbox.org>

> ---
>  drivers/hv/channel_mgmt.c | 16 ++++++++++++----
>  drivers/hv/hyperv_vmbus.h |  3 ++-
>  drivers/hv/vmbus_drv.c    |  7 +------
>  3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 74fed2c073d4..61f7dffd0f50 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -384,8 +384,18 @@ static void free_channel(struct vmbus_channel *channel)
>  
>  void vmbus_channel_map_relid(struct vmbus_channel *channel)
>  {
> -	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
> +	u32 new_relid = channel->offermsg.child_relid;
> +
> +	if (WARN_ON(new_relid >= MAX_CHANNEL_RELIDS))
>  		return;
> +
> +	/*
> +	 * This function is always called in the tasklet for the connect CPU.
> +	 * So updating the relid hiwater mark does not need to be atomic.
> +	 */
> +	if (new_relid > READ_ONCE(vmbus_connection.relid_hiwater))
> +		WRITE_ONCE(vmbus_connection.relid_hiwater, new_relid);
> +
>  	/*
>  	 * The mapping of the channel's relid is visible from the CPUs that
>  	 * execute vmbus_chan_sched() by the time that vmbus_chan_sched() will
> @@ -411,9 +421,7 @@ void vmbus_channel_map_relid(struct vmbus_channel *channel)
>  	 *      of the VMBus driver and vmbus_chan_sched() can not run before
>  	 *      vmbus_bus_resume() has completed execution (cf. resume_noirq).
>  	 */
> -	virt_store_mb(
> -		vmbus_connection.channels[channel->offermsg.child_relid],
> -		channel);
> +	virt_store_mb(vmbus_connection.channels[new_relid], channel);
>  }
>  
>  void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 7bd8f8486e85..2c90c81a3b0f 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -276,8 +276,9 @@ struct vmbus_connection {
>  	struct list_head chn_list;
>  	struct mutex channel_mutex;
>  
> -	/* Array of channels */
> +	/* Array of channel pointers, indexed by relid */
>  	struct vmbus_channel **channels;
> +	u32 relid_hiwater;
>  
>  	/*
>  	 * An offer message is handled first on the work_queue, and then
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3e7a52918ce0..a96da105b593 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1258,17 +1258,12 @@ static void vmbus_chan_sched(void *event_page_addr)
>  		return;
>  	event = (union hv_synic_event_flags *)event_page_addr + VMBUS_MESSAGE_SINT;
>  
> -	maxbits = HV_EVENT_FLAGS_COUNT;
> +	maxbits = READ_ONCE(vmbus_connection.relid_hiwater) + 1;

Worth checking that "maxbits <= HV_EVENT_FLAGS_COUNT" to protect from corruptions,
etc. or would be too paranoidal?

>  	recv_int_page = event->flags;
>  
>  	if (unlikely(!recv_int_page))
>  		return;
>  
> -	/*
> -	 * Suggested-by: Michael Kelley <mhklinux@outlook.com>
> -	 * One possible optimization would be to keep track of the largest relID that's in use,
> -	 * and only scan up to that relID.
> -	 */
>  	for_each_set_bit(relid, recv_int_page, maxbits) {
>  		void (*callback_fn)(void *context);
>  		struct vmbus_channel *channel;
> -- 
> 2.25.1
