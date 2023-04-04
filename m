Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C7C761AF
	for <linux-hyperv@archiver.kernel.org>; Tue,  4 Apr 2023 10:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjDDKjX (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjDDKjV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 06:39:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 642DF198A;
        Tue,  4 Apr 2023 03:39:17 -0700 (PDT)
Received: from [10.156.156.87] (unknown [167.220.238.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id C114E210DD83;
        Tue,  4 Apr 2023 03:39:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C114E210DD83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680604756;
        bh=t1RBKOWPXIYWXkmpINOZQASPASeY4H8gbn3HuGOfaXU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C2cXmlNMbgJtDztc5Z5+q05aQErSSQ+TITzEQjzFT85RztAMThbd76GivmwzcMhKT
         xP5j40JNpbGjq5g/hNzGzH2MhACUsvN/4pAwoZd2u+Dq31G52HRiZRSS8+eK1ZzNjD
         H7MZIdoAhofhLEhFUfKfa2hbF9jQZcLc74/eAxi0=
Message-ID: <03f62671-7f01-eeb3-4326-cbf0c2250c30@linux.microsoft.com>
Date:   Tue, 4 Apr 2023 16:09:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Drivers: hv: Do not free synic pages when they were not
 allocated
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com
References: <1680564122-30819-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From:   Jinank Jain <jinankjain@linux.microsoft.com>
In-Reply-To: <1680564122-30819-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reviewed-by: Jinank Jain <jinankjain@linux.microsoft.com>

On 4/4/2023 4:52 AM, Nuno Das Neves wrote:
> In case of root partition or snp, the synic pages are allocated by the
> hypervisor instead of the kernel, so they should not be freed.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   drivers/hv/hv.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index c7f7652932ca..a10cf642c9ad 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -193,8 +193,10 @@ void hv_synic_free(void)
>   		struct hv_per_cpu_context *hv_cpu
>   			= per_cpu_ptr(hv_context.cpu_context, cpu);
>   
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
> +			free_page((unsigned long)hv_cpu->synic_event_page);
> +			free_page((unsigned long)hv_cpu->synic_message_page);
> +		}
>   		free_page((unsigned long)hv_cpu->post_msg_page);
>   	}
>   
