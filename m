Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795BEC433B4
	for <linux-hyperv@archiver.kernel.org>; Fri,  9 Apr 2021 12:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54081610CB
	for <linux-hyperv@archiver.kernel.org>; Fri,  9 Apr 2021 12:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhDIMXi (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 9 Apr 2021 08:23:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42432 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhDIMXf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Apr 2021 08:23:35 -0400
Received: from [192.168.86.30] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id E677C20B5680;
        Fri,  9 Apr 2021 05:23:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E677C20B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1617971002;
        bh=g1IkxfC02BI2BaL8HcBt5TCTlI/DmrIpd9NIeiz+BX8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fDj98FQ0o8C9gtrF5zNWuas2cJ8KOF0kYOBZ9RmYT9qJ8Jo4iRsYJXO8L3kX5B6iK
         3LB/y/+2He4rNKz2eYoVDAsWb2ovypwCeabvrYsiDOyGf1Cs0x9sCbyU3qqjLLNOcj
         qRHsOdSZjrj+OAonLaLjzVJvyKqvYo12nV0IyJF0=
Subject: Re: [PATCH 1/7] hyperv: Detect Nested virtualization support for SVM
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
References: <cover.1617804573.git.viremana@linux.microsoft.com>
 <e14dac75ff1088b2c4bea361954b37e414edd03c.1617804573.git.viremana@linux.microsoft.com>
 <87lf9tavci.fsf@vitty.brq.redhat.com>
 <af87c25e-78c6-5859-e1c1-2aa07d087a25@linux.microsoft.com>
 <YG8gPI6NZHGBc3Zl@google.com>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <cce1a04e-7b72-ea7f-d6eb-099a7e777cf3@linux.microsoft.com>
Date:   Fri, 9 Apr 2021 08:23:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG8gPI6NZHGBc3Zl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 4/8/21 11:24 AM, Sean Christopherson wrote:
>
> Technically, you can use normal memory accesses, so long as software guarantees
> the VMCS isn't resident in the VMCS cache and knows the field offsets for the
> underlying CPU.  The lack of an architecturally defined layout is the biggest
> issue, e.g. tacking on dirty bits through a PV ABI would be trivial.
>
>> Yes, you are right. I was referring to the fact that we cant use normal
>> memory accesses, but is a bit mis-worded.
> If you slot in "architectural" it will read nicely, i.e. "VMCB is already an
> architectural datastructure in memory".
Yes, this makes sense. Thanks for the suggestion, will reword as you
suggested.

Thanks,
Vineeth
