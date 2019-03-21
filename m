Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA5C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 03:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9565218C3
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 03:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553140627;
	bh=rbC2rOdT+f1vuiTnn4H48uqnaLttNCEQzv52Lkrxrkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=btObC7BXHQIYaqaqsaozTSKT6kH00WoZeRXvLnGzUJKSeYmuFNfg0VLNipfDMHVjd
	 DPYQngsllImhLloSF94nIa7eWPl9XSWXG9X/deBxQhG4/15ZZYjCx5T2J0oYzzGcfj
	 qMW4Lv/bFTETST9IliGACZqjAVOW+1HleOHc0XOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCUD5H (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfCUD5H (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 23:57:07 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E4C218B0;
        Thu, 21 Mar 2019 03:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553140626;
        bh=rbC2rOdT+f1vuiTnn4H48uqnaLttNCEQzv52Lkrxrkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gzvq9/XruHwnUja0s05ds/NagNQ8vA8zd9sxsdWJwKNfDSVfmhDPOuiIWARzOEJ1a
         sZ98HDrAgBrenuX12T1RNmBERMW3Lq4ifVDFwzOOtDaXHM14PNYPtaN2XqrnUWMMiL
         OkJBiA1+OGpkmUgUMm6D0RrFDXq9G2xtOzVk0z9k=
Date:   Wed, 20 Mar 2019 23:57:05 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Message-ID: <20190321035705.GE25262@sasha-vm>
References: <20190308224611.GA3047@ubu-Virtual-Machine>
 <20190319040401.GA3050@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319040401.GA3050@ubu-Virtual-Machine>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 19, 2019 at 12:04:01AM -0400, Kimberly Brown wrote:
>There are two methods for signaling the host: the monitor page mechanism
>and hypercalls. The monitor page mechanism is used by performance
>critical channels (storage, networking, etc.) because it provides
>improved throughput. However, latency is increased. Monitor pages are
>allocated to these channels.
>
>Monitor pages are not allocated to channels that do not use the monitor
>page mechanism. Therefore, these channels do not have a valid monitor id
>or valid monitor page data. In these cases, some of the "_show"
>functions return incorrect data. They return an invalid monitor id and
>data that is beyond the bounds of the hv_monitor_page array fields.
>
>The "channel->offermsg.monitor_allocated" value can be used to determine
>whether monitor pages have been allocated to a channel.
>
>Add "is_visible()" callback functions for the device-level and
>channel-level attribute groups. These functions will hide the monitor
>sysfs files when the monitor mechanism is not used.
>
>Remove ".default_attributes" from "vmbus_chan_attrs" and create a
>channel-level attribute group. These changes allow the new
>"is_visible()" callback function to be applied to the channel-level
>attributes.
>
>Call "sysfs_create_group()" in "vmbus_add_channel_kobj()" to create the
>channel's sysfs files. Add a new function,
>“vmbus_remove_channel_attr_group()”, and call it in "free_channel()" to
>remove the channel's sysfs files when the channel is closed.
>
>Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

I've queued it up for hyperv-fixes, thanks Kimberly.

Should this go in stable as well?

--
Thanks,
Sasha
