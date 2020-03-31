Return-Path: <SRS0=cRYp=5Q=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB7FC43331
	for <linux-hyperv@archiver.kernel.org>; Tue, 31 Mar 2020 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AC72071A
	for <linux-hyperv@archiver.kernel.org>; Tue, 31 Mar 2020 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtkhE0Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgCaO0M (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:26:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46499 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbgCaO0M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Mar 2020 10:26:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so10375626pff.13;
        Tue, 31 Mar 2020 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qgU5GNWwxvNw01wKTkbZHng7zu7l/h3s0v78nM/ZPKs=;
        b=PtkhE0VkyzzTy/IDBq5VV+xYtPAlrWWNClmlEDZW7jdDllAviOBy/BJmakwn+g+7Ge
         9Mi1Na+ko01cOch/IOFiwO5F9bfeosfDxKyjubVEp1ZwZEDkH14spQBi3XGg7yE1KY94
         Dcg2tl3pr6v5kr49cQGp/Wc4P2vaAxln0Nwxdkr2W4Jfwk9/vYSkJYToQcGTUY9Sm5is
         ZTsp9R6Q/CQ0nwPd5qKfd4aOZZOlmZ6oOYQ4DqBKTX12xzKzmzEReTyWWL9dV4OQss+U
         4Axks+aB7uIRKNL9sFO9tcaxf2oNGwd5dR2T6XmBrlHmkN06dIyDKN8sUNUW25qnwbI6
         rqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qgU5GNWwxvNw01wKTkbZHng7zu7l/h3s0v78nM/ZPKs=;
        b=SlvqA5IAk5TENyPb7m8xGfp+vGUvGZ62GSVfR4dkDR/Semk3I5kQazvbEP+/+doobJ
         oCQXwCbLubMVOWYttGF3BLdUa/oDlqQs3rH6exXuHLGi6EpUZ7gtmn9TkdqLq4VyNvOz
         J14FhqQEGDx4EUCUvm44nC3iUjoqXOIAFwOLcyrHTA8VqtWpZt4l0Anh/hfFmh0Gn2/s
         SVOQATBiTilvOqHIGA2OFseFt9o2iWcruWATPQCEmCpTrROy9+tlKMGS+FK51txiL4ZS
         8jrwPW3YaysBeDpcBaYglMct2c9wGFJEnwTF9qoz/1EMS54Vr21r8UCKlXywKL3239ox
         UfOA==
X-Gm-Message-State: ANhLgQ2loye5NQ5qKrMZmN9rFJpHGL+JU4mghgc/WdyaHCjSYAuT6bX2
        DXp/X1pT1h0kphttry9ed/s=
X-Google-Smtp-Source: ADFU+vsle8KCYPPqVswIR4/39cotREF+U9FBahnHWb1DVytVndV//3sFEwJFTLSlM7H7mLRgl4spcQ==
X-Received: by 2002:a63:5c02:: with SMTP id q2mr19061326pgb.262.1585664771045;
        Tue, 31 Mar 2020 07:26:11 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id k14sm2976631pje.3.2020.03.31.07.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:26:10 -0700 (PDT)
Subject: Re: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
References: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
 <20200331073832.12204-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1052A8FEF85F381B3EAF7D36D7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <9eb81216-8e00-64e5-ab1c-b363983b245e@gmail.com>
Date:   Tue, 31 Mar 2020 22:26:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052A8FEF85F381B3EAF7D36D7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 3/31/2020 9:51 PM, Michael Kelley wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 31, 2020 12:39 AM
>>
>> When oops happens with panic_on_oops unset, the oops
>> thread is killed by die() and system continues to run.
>> In such case, guest should not report crash register
>> data to host since system still runs. Fix it.
>>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> Change since v3:
>> 	Fix compile error
>> ---
>>   drivers/hv/vmbus_drv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 172ceae69abb..4bc02aea2098 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/kdebug.h>
>>   #include <linux/efi.h>
>>   #include <linux/random.h>
>> +#include <linux/kernel.h>
> 
> Unfortunately, adding the #include doesn't solve the problem.  The error occurs when
> CONFIG_HYPERV=m, because panic_on_oops is not exported.  I haven't thought it
> through, but hopefully there's a solution where panic_on_oops can be tested in
> hyperv_report_panic() or some other Hyper-V specific function that's never in a
> module, so that we don't need to export panic_on_oops.

Yes, I don't consider modules case. I think we may introduce a check 
function of panic_on_oops in the mshyperv.c and expose it to module.

> 
> Michael
> 
>>   #include <linux/syscore_ops.h>
>>   #include <clocksource/hyperv_timer.h>
>>   #include "hyperv_vmbus.h"
>> @@ -91,7 +92,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long
>> val,
>>   	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
>>   	 * the notification here.
>>   	 */
>> -	if (hyperv_report_reg())
>> +	if (hyperv_report_reg() && panic_on_oops)
>>   		hyperv_report_panic(regs, val);
>>   	return NOTIFY_DONE;
>>   }
>> --
>> 2.14.5
> 
