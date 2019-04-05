Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656FAC4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 11:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5D82186A
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 11:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfDELKt (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:10:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53063 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfDELKt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Apr 2019 07:10:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so6197897wma.2
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Apr 2019 04:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nw4byI8wl4u5RByJyIYhrTxED0BA1Q5a4JjGb2r3NJM=;
        b=uDUt4PoCQa5EZqbhVwU4xsWTjPhfbUE6BOc7cVl/kl1BaZaasYq34CQ214S4p3g1a8
         zL9Gp4//qdR/KgXnASSqoc+qhW2hkaYJmiEwF+hZix4GQ/QRtgqaEKhYSPli/1xCi8LK
         c13Za/8GwDwNrdjRNVRelCwWiqPzfMNYZbYoBqBTjdjv7MjO7MoSgSCb+jBKsR7E7Dsc
         0eFGVkydnBE5xFhPT7uyoTYmMUJihCBvjwlRiW15UcO2Vg3QEB7BJUSrkNr1VW0jtmj0
         ZvFj1OiCW2afdyc3hQIL5sl/3Hsj1Ob3awMRKYu9L9T4XkusqygdwcFD2XLScAgZyVub
         IkVQ==
X-Gm-Message-State: APjAAAXU9k08h5RuveyKvXLu6948tPmrfbpjU5E2ijYF12E6mjliQes6
        yvk4BsDEEW+Z3KzN9yRl4T1kHA==
X-Google-Smtp-Source: APXvYqyaepktI4unLI1mrcLgEOg9achbNy+5FFcyBwaxHCD8K3Hi8IYouC6KhIhti4fV4uP+8QfkAA==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr7087148wmk.17.1554462648238;
        Fri, 05 Apr 2019 04:10:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 7sm76640266wrc.81.2019.04.05.04.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 04:10:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] x86: hv: mmu.c: Replace page definitions with Hyper-V specific ones
In-Reply-To: <3bc5d60092473815fbd90422875233fb6075285b.1554426040.git.m.maya.nakamura@gmail.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <3bc5d60092473815fbd90422875233fb6075285b.1554426040.git.m.maya.nakamura@gmail.com>
Date:   Fri, 05 Apr 2019 13:10:46 +0200
Message-ID: <87zhp4iu6h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Replace PAGE_SHIFT, PAGE_SIZE, and PAGE_MASK with HV_HYP_PAGE_SHIFT,
> HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK, respectively, because the guest
> page size and hypervisor page size concepts are different, even though
> they happen to be the same value on x86.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  arch/x86/hyperv/mmu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index e65d7fe6489f..175f6dcc7362 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -15,7 +15,7 @@
>  #include <asm/trace/hyperv.h>
>  
>  /* Each gva in gva_list encodes up to 4096 pages to flush */
> -#define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
> +#define HV_TLB_FLUSH_UNIT (4096 * HV_HYP_PAGE_SIZE)
>  
>  static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>  				      const struct flush_tlb_info *info);
> @@ -32,15 +32,15 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
>  	do {
>  		diff = end > cur ? end - cur : 0;
>  
> -		gva_list[gva_n] = cur & PAGE_MASK;
> +		gva_list[gva_n] = cur & HV_HYP_PAGE_MASK;

I'm not sure this is correct: here we're expressing guest virtual
addresses in need of flushing, this should be unrelated to the
hypervisor page size.

>  		/*
>  		 * Lower 12 bits encode the number of additional
>  		 * pages to flush (in addition to the 'cur' page).
>  		 */
>  		if (diff >= HV_TLB_FLUSH_UNIT)
> -			gva_list[gva_n] |= ~PAGE_MASK;
> +			gva_list[gva_n] |= ~HV_HYP_PAGE_MASK;
>  		else if (diff)
> -			gva_list[gva_n] |= (diff - 1) >> PAGE_SHIFT;
> +			gva_list[gva_n] |= (diff - 1) >> HV_HYP_PAGE_SHIFT;
>  
>  		cur += HV_TLB_FLUSH_UNIT;
>  		gva_n++;
> @@ -129,7 +129,8 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
>  	 * We can flush not more than max_gvas with one hypercall. Flush the
>  	 * whole address space if we were asked to do more.
>  	 */
> -	max_gvas = (PAGE_SIZE - sizeof(*flush)) / sizeof(flush->gva_list[0]);
> +	max_gvas = (HV_HYP_PAGE_SIZE - sizeof(*flush)) /
> +		    sizeof(flush->gva_list[0]);
>  
>  	if (info->end == TLB_FLUSH_ALL) {
>  		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
> @@ -200,9 +201,9 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>  	 * whole address space if we were asked to do more.
>  	 */
>  	max_gvas =
> -		(PAGE_SIZE - sizeof(*flush) - nr_bank *
> +		(HV_HYP_PAGE_SIZE - sizeof(*flush) - nr_bank *
>  		 sizeof(flush->hv_vp_set.bank_contents[0])) /
> -		sizeof(flush->gva_list[0]);
> +		 sizeof(flush->gva_list[0]);
>  
>  	if (info->end == TLB_FLUSH_ALL) {
>  		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;

-- 
Vitaly
