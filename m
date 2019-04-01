Return-Path: <SRS0=/wEv=SD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B37C43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4B620700
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 13:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfDANpR (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:45:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40934 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfDANpR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Apr 2019 09:45:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so11611286wmi.5
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Apr 2019 06:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=h7jmpdL0luLhA9lFto9exlN3jNkbV5QZT4lq1CkOFII=;
        b=IDtMTmjJwIDVr47/EkzwpElx4wrqI6rnjjIImz1viVmZAIycShr3A0TMpFycMbjpRT
         qwbcld4a/6wSM+H9DXDMSf+9v/MBM2KO5WjP6SWzHZ+Ute/R57O7BF6Z2+X+ukJO4I7M
         nkb/ENRw/3OTGtyHBV0Gr3d7Aa49n+3f7MOxeq4y9+SOi/W4IgSjEK3Uc3F0cZqoSoYS
         BsWbkVDmtlvi+bPSbK+W7rCIvVXJtc6IG9IJ/m4ZKlVY+zcq1+NerNWilchlwFMk9/B7
         Ronhr+XZeOdQoTSFkLRnqZalt3IRLylsYfZSWGrbB2ifnkTC+BQhQp+uHqbCu4lswZ0C
         T+QQ==
X-Gm-Message-State: APjAAAVQ/t87XeJ0y3bCVRH8+sjDIsinw70xrVk3gKrniIQeIAHcS2sF
        rYQAaSnyzDDiynGjpR1ie7Xo8rG/WF4=
X-Google-Smtp-Source: APXvYqw57OD5zn48Qu+mWLUGKUC0cc9JO/Fp9FDwfvLvvG+kKR8vHnDJT3jJyPbGRY/+Z6gq9CXtyw==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr12107445wmg.141.1554126315741;
        Mon, 01 Apr 2019 06:45:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v16sm20076450wro.48.2019.04.01.06.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 06:45:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "James.Bottomley\@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "emilne\@redhat.com" <emilne@redhat.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/1] scsi: storvsc: Fix calculation of sub-channel count
In-Reply-To: <1554076559-14873-1-git-send-email-mikelley@microsoft.com>
References: <1554076559-14873-1-git-send-email-mikelley@microsoft.com>
Date:   Mon, 01 Apr 2019 15:45:13 +0200
Message-ID: <87imvx261i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> When the number of sub-channels offered by Hyper-V is >= the number
> of CPUs in the VM, calculate the correct number of sub-channels.
> The current code produces one too many.
>
> This scenario arises only when the number of CPUs is artificially
> restricted (for example, with maxcpus=<n> on the kernel boot line),
> because Hyper-V normally offers a sub-channel count < number of CPUs.
> While the current code doesn't break, the extra sub-channel is
> unbalanced across the CPUs (for example, a total of 5 channels on
> a VM with 4 CPUs).
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 84380ba..fbaa11a 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -674,7 +674,17 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
>  	struct vstor_packet *vstor_packet;
>  	int ret, t;
>  
> -	num_sc = ((max_chns > num_cpus) ? num_cpus : max_chns);
> +	/*
> +	 * If the number of CPUs is artificially restricted, such as
> +	 * with maxcpus=1 on the kernel boot line, Hyper-V could offer
> +	 * sub-channels >= the number of CPUs. These sub-channels
> +	 * should not be created. The primary channel is already created
> +	 * and assigned to one CPU, so check against # CPUs - 1.
> +	 */

Indeed.

> +	num_sc = min((num_cpus - 1), max_chns);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

(nit: you could've written

num_sc = min((num_online_cpus() - 1), max_chns);

and got rid of the now-unneeded num_cpus variable).

> +	if (!num_sc)
> +		return;
> +
>  	stor_device = get_out_stor_device(device);
>  	if (!stor_device)
>  		return;

-- 
Vitaly
