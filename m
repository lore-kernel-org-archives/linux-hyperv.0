Return-Path: <SRS0=1u+G=6V=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D431C38A2A
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 May 2020 16:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B5A20936
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 May 2020 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588869391;
	bh=JT0PP4ZfYn/IJrnFIRLvplXbm6PgVpgpYJ7DUbhhyww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i0wmPZbFtjjNN7fLQtOtKjoycAq4ZBPGSEfn4j8aM04SaZXKORFd7h6lOsj86YIMe
	 vDaEZp6th5VaPva0Oz2L0NHWL47k4WhEd5wmL9Z2/GESzWP09gs1sij7G6j7T+zyLZ
	 z0v21aRjneFpEVL87+jTkPQfLFjpCrQWwTVtcnMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGQga (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 7 May 2020 12:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgEGQga (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 12:36:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C982073A;
        Thu,  7 May 2020 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588869390;
        bh=JT0PP4ZfYn/IJrnFIRLvplXbm6PgVpgpYJ7DUbhhyww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwbFamQbJYZbmAQLcBE8AZgNy53XrrS6FHntaQsupO+kWReiZEGpcDQe+hFusSY+7
         1uaW/yQeCrI4XnqxSo/+fxvmFspQ2VYZ9H+Ul0aFSNmv1gWWF2DDyVHeCKrh9XZ2nJ
         6hfspvrZHJ9HXZOLWn179IEfk+ALAmBkxFeULjcg=
Date:   Thu, 7 May 2020 18:36:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio_hv_generic: add missed sysfs_remove_bin_file
Message-ID: <20200507163628.GB2100062@kroah.com>
References: <20200507151343.792816-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507151343.792816-1-hslester96@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 07, 2020 at 11:13:43PM +0800, Chuhong Yuan wrote:
> This driver calls sysfs_create_bin_file() in probe, but forgets to
> call sysfs_remove_bin_file() in remove.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/uio/uio_hv_generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 3c5169eb23f5..4dae2320b103 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -361,6 +361,7 @@ hv_uio_remove(struct hv_device *dev)
>  	if (!pdata)
>  		return 0;
>  
> +	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
>  	uio_unregister_device(&pdata->info);
>  	hv_uio_cleanup(dev, pdata);
>  	hv_set_drvdata(dev, NULL);


I'll take this, but it's not always needed as all sysfs files are
removed from the device when it is removed from sysfs anyway.  So this
shouldn't be an issue in a real system.

thanks,

greg k-h
