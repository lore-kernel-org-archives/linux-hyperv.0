Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC4BC4332F
	for <linux-hyperv@archiver.kernel.org>; Fri,  9 Dec 2022 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLISRJ (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 9 Dec 2022 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLISQ6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Dec 2022 13:16:58 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06ED8AC6DF;
        Fri,  9 Dec 2022 10:16:57 -0800 (PST)
Received: from [192.168.0.5] (71-212-113-106.tukw.qwest.net [71.212.113.106])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7333820B83C2;
        Fri,  9 Dec 2022 10:16:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7333820B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670609816;
        bh=lzFnTftRvxlZ+Gp85uwktXavpvOXAhfKFviLo3DMfwo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ml8VmkXz4Y1dj/DbMqloNM7VMWznzIn+ig7QaDWVQbzj1O7/crKJi1zVjqTWT09q0
         0rRVt7NwqKNDuqt/c+8B0kq9cqw+dPNLVCBknhjt5lKwQiEvcPdzeMhayh3VpBpaa3
         g6iK/YUGVnqJ0UOP/IhoWG4+JVexLjnYaT+TCfYs=
Subject: Re: [PATCH v8 4/5] Drivers: hv: Enable vmbus driver for nested root
 partition
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
References: <cover.1670561320.git.jinankjain@linux.microsoft.com>
 <c8aa55ee5b48f301ef721908e6195a102a089d42.1670561320.git.jinankjain@linux.microsoft.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <b69f0aa9-3f6e-b1d4-7927-1c807adbbf75@linux.microsoft.com>
Date:   Fri, 9 Dec 2022 10:16:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <c8aa55ee5b48f301ef721908e6195a102a089d42.1670561320.git.jinankjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/8/2022 9:32 PM, Jinank Jain wrote:
> Currently VMBus driver is not initialized for root partition but we need
> to enable the VMBus driver for nested root partition. This is required,
> so that L2 root can use the VMBus devices.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0f00d57b7c25..6324e01d5eec 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2745,7 +2745,7 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> -	if (hv_root_partition)
> +	if (hv_root_partition && !hv_nested)
>  		return 0;
>  
>  	/*
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
