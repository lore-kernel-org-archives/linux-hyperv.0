Return-Path: <SRS0=AyMY=R6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96300C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Mar 2019 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C6D2075E
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Mar 2019 14:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lXaOMOMd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b6AVA+5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfC0OJW (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:09:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfC0OJW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Mar 2019 10:09:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 73AC660C72; Wed, 27 Mar 2019 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553695761;
        bh=qozMxbzqqU/cnJ5mUxhiDDHpTdrfvXkQOCxg/VHLYpY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lXaOMOMdTsN65xKpunCRki8bn1ACBp0xFBp4TDy9Ptj2k5qRL42OYOosQuAYM/DKf
         5TtXeYDazb34tUg1nASgs+mhpYzy7VQlmX4+HIWmYxTARlWwbKY85wZfdbe3x9vlot
         NJ/QM+7i9IUA7UZfpTRvHIBAD5J45kb9hUfDsRlk=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15B8F6079C;
        Wed, 27 Mar 2019 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553695758;
        bh=qozMxbzqqU/cnJ5mUxhiDDHpTdrfvXkQOCxg/VHLYpY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b6AVA+5FuzZOJLscHCqVUNiAycNv7tHEhLnRVahCev2DGWQ7mVbp6GyrrFz8ZjGue
         wFSp+thyKJOhHw3RpyuAHZ3MxWFAwGSnOg/zgXR50x9kNqzBw8kLXgU7I3Tc+hXLvL
         qidXWmDtzKvnUmSXxaQn1yYWra5IQj6cQBYl/1/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15B8F6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] MAINTAINERS: Fix Hyperv vIOMMU driver file name
To:     lantianyu1986@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, tglx@linutronix.de, mingo@kernel.org,
        konrad.wilk@oracle.com, jpoimboe@redhat.com, peterz@infradead.org,
        jkosina@suse.cz, riel@surriel.com, peterz@infraded.org,
        Tianyu.Lan@microsoft.com, luto@kernel.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        sashal@kernel.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <1553581701-25250-1-git-send-email-Tianyu.Lan@microsoft.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <fe945246-b915-97b2-ab04-4f1951b45352@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:39:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553581701-25250-1-git-send-email-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 3/26/2019 11:58 AM, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> The Hyperv vIOMMU file name should be "hyperv-iommu.c" rather
s/vIOMMU /IOMMU
> than "hyperv_iommu.c". This patch is to fix it.
>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>


Othewise looks fine.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf7..403247d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7175,7 +7175,7 @@ F:	drivers/net/hyperv/
>   F:	drivers/scsi/storvsc_drv.c
>   F:	drivers/uio/uio_hv_generic.c
>   F:	drivers/video/fbdev/hyperv_fb.c
> -F:	drivers/iommu/hyperv_iommu.c
> +F:	drivers/iommu/hyperv-iommu.c
>   F:	net/vmw_vsock/hyperv_transport.c
>   F:	include/linux/hyperv.h
>   F:	include/uapi/linux/hyperv.h
