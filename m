Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6774DC433B4
	for <linux-hyperv@archiver.kernel.org>; Tue, 13 Apr 2021 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C15610C8
	for <linux-hyperv@archiver.kernel.org>; Tue, 13 Apr 2021 15:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhDMQAI (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 13 Apr 2021 12:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhDMQAH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 12:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8692F60C40;
        Tue, 13 Apr 2021 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618329587;
        bh=UD4aZe/qiFaq46Q+8RUJUKEgVxSzUUdRzyRPJYHtnE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iM0DNAlrcbhLaGqtyvRQ5Yzjn4soYbYa5KRX3/n/l+a+mSAy3uZjkx88iDCAo4exI
         VE/CQzxzxIzwmbHueB7IuuFrMHQWa/cqMMr/DdOwhNH4NdnsRbVOoxpdeilkp5sC9a
         zUeJY2nEcKNTXGuUzhEMFsvKmBF6Ci9gn4UDoQBc=
Date:   Tue, 13 Apr 2021 17:59:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: Re: [RFC V2 PATCH 8/12] UIO/Hyper-V: Not load UIO HV driver in the
 isolation VM.
Message-ID: <YHW/8AV5jZDjz+yP@kroah.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
 <20210413152217.3386288-9-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413152217.3386288-9-ltykernel@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 13, 2021 at 11:22:13AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> UIO HV driver should not load in the isolation VM for security reason.
> Return ENOTSUPP in the hv_uio_probe() in the isolation VM.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 0330ba99730e..678b021d66f8 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -29,6 +29,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/vmalloc.h>
>  #include <linux/slab.h>
> +#include <asm/mshyperv.h>

No driver should be having to add "asm" include files.

>  
>  #include "../hv/hyperv_vmbus.h"
>  
> @@ -241,6 +242,10 @@ hv_uio_probe(struct hv_device *dev,
>  	void *ring_buffer;
>  	int ret;
>  
> +	/* UIO driver should not be loaded in the isolation VM.*/
> +	if (hv_is_isolation_supported())
> +		return -ENOTSUPP;
> +		
>  	/* Communicating with host has to be via shared memory not hypercall */
>  	if (!channel->offermsg.monitor_allocated) {
>  		dev_err(&dev->device, "vmbus channel requires hypercall\n");
> -- 
> 2.25.1
> 

Always run checkpatch.pl on your patches so you do not get grumpy
maintainers telling you to run checkpatch.pl on your patch :(

{sigh}
