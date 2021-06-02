Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF2C4708F
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Jun 2021 10:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2F761001
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Jun 2021 10:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhFBKdx (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:33:53 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36717 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhFBKdx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 06:33:53 -0400
Received: by mail-wm1-f52.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3454948wmk.1;
        Wed, 02 Jun 2021 03:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vf0+jsnxWv3MUeSQuUrF48fJEizrZe94s4fGa0z+Wtc=;
        b=pSd+V3KFdbCrUfkQEHXvaEMl/9UX8evR0uMSCMfoyTX9KDNOlqnj+Te9TFlXCfuqbU
         dDAzv1J1s1t4HDhrJPV6fU1LdIhwDMlgOj9uAggQ9Bw5TR9VIc515LF4Ui4sPxOOio8i
         Utg5e9UN+M7sIOSGt7duqDf1dQalPVUFFmjDBhHBx2bt1PfUKI2sV2schBKA4OPl9+4R
         OrHSrHleLIwmHGh0TLasLRfHs54wkprWXCCyHfXbqD5hiCdDMrJrEQaZ8j6xhBGascr/
         Jtl+Tzxs68ncrwSl9CUEJgmwH/txz6z9s9Sh/k7fuznbHxsjmOmW9/xcoofcC457vffY
         pdbA==
X-Gm-Message-State: AOAM532rT9y3J1cF7ix489bmkUcdpFVdsB8vw1PNuGPSqt8/DmD/lcYW
        7zmW6IuMYINUupoVf4eM0sw=
X-Google-Smtp-Source: ABdhPJz1xElCXT81jXsY6Mk0wZfrxjyd6riYjK7wy2V+QlDi42tA7HW9Cu2FMF41bVNtxJq4S8xZgg==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr4532738wmj.133.1622629928760;
        Wed, 02 Jun 2021 03:32:08 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o17sm5874932wrp.47.2021.06.02.03.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:32:08 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:32:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        kys@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: Add check for hyperv_initialized in
 init_hv_pci_drv()
Message-ID: <20210602103206.4nx55xsl3nxqt6zj@liuwe-devbox-debian-v2>
References: <1621984653-1210-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621984653-1210-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 25, 2021 at 04:17:33PM -0700, Haiyang Zhang wrote:
> Add check for hv_is_hyperv_initialized() at the top of init_hv_pci_drv(),
> so if the pci-hyperv driver is force-loaded on non Hyper-V platforms, the
> init_hv_pci_drv() will exit immediately, without any side effects, like
> assignments to hvpci_block_ops, etc.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reported-and-tested-by: Mohammad Alqayeem <mohammad.alqyeem@nutanix.com>

Hello PCI subsystem maintainers, are you going to take this patch or
shall I?

Wei.

> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6511648271b2..bebe3eeebc4e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3476,6 +3476,9 @@ static void __exit exit_hv_pci_drv(void)
>  
>  static int __init init_hv_pci_drv(void)
>  {
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
>  	/* Set the invalid domain number's bit, so it will not be used */
>  	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
>  
> -- 
> 2.25.1
> 
