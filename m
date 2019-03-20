Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC9C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4369C2175B
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 15:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bv+2fjNr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TRz00Ypf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfCTPu3 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:50:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTPu1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 11:50:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 59FD0607C3; Wed, 20 Mar 2019 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553097025;
        bh=eJcfw1KaXjciYxRLIgRlNwUK0l3sz2sP031q6+VXl+w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bv+2fjNrmyoVBVxlUuwV2h5D58RVnF7k6+226vKYNYJPzeWHLic/boYk7j9P7bfx7
         NvwsvXvzTOwx5KdMT22ZTqmqxii3kO11XH5VCO4U/G1jhF66WWlyE1SecypAIV0UkR
         Ws3yZb9gwqyeXdWSKV7AiEQelq9JmfqRC9gPQXNc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0888606DB;
        Wed, 20 Mar 2019 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553097024;
        bh=eJcfw1KaXjciYxRLIgRlNwUK0l3sz2sP031q6+VXl+w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TRz00YpfzggTbp1D5x/z3TB5ylRbw6wzo+vTNrAFJW4YApo87tB+coa5du2g6Fo1a
         7rOjBV5hrb9GH52falFQacSrJKCZcTpm2RN7Go9brO50kCpgo/cSoPteN241zOMtge
         LcUutYLysRdZ7jb7fgGwuZ/yz7xN++pqOz5TkLQA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0888606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] hyperv: a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190314054651.1315-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <24cbb2df-6510-2ed8-deca-670ea934db68@codeaurora.org>
Date:   Wed, 20 Mar 2019 21:20:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314054651.1315-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 3/14/2019 11:16 AM, Kangjie Lu wrote:
> In case alloc_page, the fix returns -ENOMEM to avoid the potential
> NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   arch/x86/hyperv/hv_init.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7abb09e2eeb8..dfdb4ce1ae9c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -102,9 +102,13 @@ static int hv_cpu_init(unsigned int cpu)
>   	u64 msr_vp_index;
>   	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>   	void **input_arg;
> +	struct page *pg;
>   
>   	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	*input_arg = page_address(alloc_page(GFP_KERNEL));
> +	pg = alloc_page(GFP_KERNEL);
> +	if (unlikely(!pg))
> +		return -ENOMEM;
> +	*input_arg = page_address(pg);
>   
>   	hv_get_vp_index(msr_vp_index);



Looks good to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


Thanks.
Mukesh


>   
