Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8344BC433ED
	for <linux-hyperv@archiver.kernel.org>; Fri, 16 Apr 2021 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD1160FED
	for <linux-hyperv@archiver.kernel.org>; Fri, 16 Apr 2021 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhDPR0i (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 16 Apr 2021 13:26:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56122 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbhDPR0i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 13:26:38 -0400
Received: from [192.168.86.23] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 246E820B8001;
        Fri, 16 Apr 2021 10:26:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 246E820B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1618593973;
        bh=yI1pAMpH+mhQxjxBFxyi6XTgljNwMYGQtQI+vVWmMsk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=slYNO8en83Yfldinakff1HJ/VLKev28A09BDDpGfNxEsBbJsFZzaRUwIL6TqVp60l
         n+V4W/Pm2YDlMVWcvXcoKFbSRkv9U3k9t4ZtyrpKL7VlbKv/AQ5tquBIZ2Bejd650V
         yJmIxW3UOiU6H1DyeLr5CWaC44C8wO2qaDuhG75M=
Subject: Re: [PATCH v2 5/7] KVM: SVM: hyper-v: Remote TLB flush for SVM
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        viremana@linux.microsoft.com
References: <cover.1618492553.git.viremana@linux.microsoft.com>
 <959f6cc899a17c709a2f5a71f6b2dc8c072ae600.1618492553.git.viremana@linux.microsoft.com>
 <87sg3q7g7b.fsf@vitty.brq.redhat.com>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <f85b1db2-3a0b-0de3-78e9-2c04721f00bc@linux.microsoft.com>
Date:   Fri, 16 Apr 2021 13:26:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <87sg3q7g7b.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 4/16/2021 5:04 AM, Vitaly Kuznetsov wrote:
> Vineeth Pillai <viremana@linux.microsoft.com> writes:
>
>
>   
> +#if IS_ENABLED(CONFIG_HYPERV)
> +static void hv_init_vmcb(struct vmcb *vmcb)
> +{
> +	struct hv_enlightenments *hve = &vmcb->hv_enlightenments;
> +
> +	if (npt_enabled &&
> +	    ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB)
> Nitpick: we can probably have a 'static inline' for
>
>   "npt_enabled && ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB"
>
> e.g. 'hv_svm_enlightened_tlbflush()'
Makes sense, will do.

Thanks,
Vineeth




