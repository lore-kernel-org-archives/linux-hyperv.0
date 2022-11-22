Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94277C4332F
	for <linux-hyperv@archiver.kernel.org>; Tue, 22 Nov 2022 12:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiKVMBL (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 22 Nov 2022 07:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiKVMBB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Nov 2022 07:01:01 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 900423C6CF
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Nov 2022 04:00:58 -0800 (PST)
Received: from [10.156.157.27] (unknown [167.220.238.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id BBCB220B717A;
        Tue, 22 Nov 2022 04:00:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBCB220B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669118458;
        bh=UGsRDYD3xFYoEHM6FrUII3KmIobV/4NCMcfnkwaTXeA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=cm3JMTpeq+Z4MuBQBCYAwXniXHCOrQuWv+VQ4ykkanj5Gwsc5LNoSdua3GK43eHNt
         B/Nhnse7Y81SE3ncb1BQad7BveTBDiqv7VAolzGoIOPxFyopjHywpntCG91O8wOnJc
         mjgkRrgzwq2iymZrp9Z6cV9XLUSEjMy4uDupPFhc=
Message-ID: <f5adc72d-a215-fb25-a8ed-f44f29eebf2b@linux.microsoft.com>
Date:   Tue, 22 Nov 2022 17:30:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drivers: hv: vmbus: Fix possible memory leak when
 device_register() failed
To:     Nir Levy <bhr166@gmail.com>, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        mikelley@microsoft.com
References: <20221122001724.218299-1-bhr166@gmail.com>
Content-Language: en-US
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <20221122001724.218299-1-bhr166@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/22/2022 5:47 AM, Nir Levy wrote:
> The reference must be released when device_register(&child_device_obj->device) failed.
> Fix this by adding 'put_device()' in the error handling path.
> ---
>  drivers/hv/vmbus_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 8b2e413bf19c..e592c481f7ae 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2082,6 +2082,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  	ret = device_register(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
> +		put_device(&child_device_obj->device);

I think this patch is not required, as device_add (device_register->device_add) will put_device for any failure within. 
Please do share the specific flow which you think might need this fix. Thanks. 

>  		return ret;
>  	}
>  

Regards,

~Praveen.
