Return-Path: <SRS0=/wEv=SD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A47AC43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 14:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3619620883
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554128429;
	bh=vHQMGRNUZk1EcNsloV1elZ3RHsCKrr/HuTo0oCJyBBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u7NmhduuLpld8x9oKPWaQ7YkAW3gAWdzc2GJYwZToglTscuf8KPI6jeWYPaleoBzJ
	 ZUYEQDgiwhcleELvN6YR+m62SQIhgb7Y8TP4RqMIb/LpdLRr863w82ZAnMGLTrEG06
	 4h/r1awFhu6G+Bfn8UQ3Odaunj9ud2YIoytrCb7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfDAOU2 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfDAOU2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Apr 2019 10:20:28 -0400
Received: from localhost (unknown [173.13.115.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29FE2082C;
        Mon,  1 Apr 2019 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554128428;
        bh=vHQMGRNUZk1EcNsloV1elZ3RHsCKrr/HuTo0oCJyBBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18R+X7xYA4c2/vg2eHrao7xPz5LgXWj2GdY/hMD0GU+L2pmJMh0VBsksYiXv9D8IO
         NIDzova2wlOZB7WpylmEVislxoZ4vxfp+6TtLJJGFTUzngLaeq3LIY4YXbCl+1oFWU
         jB+ngNPJGIr0M6kskgPXpojDfRw+Nt1vNaiPgwKg=
Date:   Mon, 1 Apr 2019 10:20:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     lantianyu1986@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, tglx@linutronix.de, mingo@kernel.org,
        konrad.wilk@oracle.com, jpoimboe@redhat.com, peterz@infradead.org,
        jkosina@suse.cz, riel@surriel.com, peterz@infraded.org,
        Tianyu.Lan@microsoft.com, luto@kernel.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Fix Hyperv vIOMMU driver file name
Message-ID: <20190401142026.GA2792@sasha-vm>
References: <1553581701-25250-1-git-send-email-Tianyu.Lan@microsoft.com>
 <58c16b52-5833-ede0-c4b0-8b8839ef06b2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <58c16b52-5833-ede0-c4b0-8b8839ef06b2@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 26, 2019 at 02:57:09PM +0530, Mukesh Ojha wrote:
>
>On 3/26/2019 11:58 AM, lantianyu1986@gmail.com wrote:
>>From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>>
>>The Hyperv vIOMMU file name should be "hyperv-iommu.c" rather
>
>s/vIOMMU/IOMMU

What's wrong with vIOMMU? There's no hardware involved (afaik).

--
Thanks,
Sasha
