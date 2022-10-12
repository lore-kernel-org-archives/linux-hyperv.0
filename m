Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28FBC4332F
	for <linux-hyperv@archiver.kernel.org>; Wed, 12 Oct 2022 15:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJLPv2 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJLPv1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Oct 2022 11:51:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CF4F193F;
        Wed, 12 Oct 2022 08:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 796C8B819D9;
        Wed, 12 Oct 2022 15:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABB3C433C1;
        Wed, 12 Oct 2022 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665589881;
        bh=uWgi3jGpfAFbQQu88mP0kZwhxtsWDEB1EyOYRYv+tIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZENHhBBQ+qwxnIV17n6kdhRJJq+t2kbQmhgCbNn+nTTG7+nyLhfILzKFlDlcEZxTT
         diUP/98z34qsvDPGymLCRrPJ4l8pcrxD2PsqSmYdtixMO8UHLyVWY9hv/CFX3lBKeG
         sPBD+Gp5Si/aAFcamr1BH3J2UnqGKPJhpyKG33D4=
Date:   Wed, 12 Oct 2022 17:52:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] uio_hv_generic: Enable support for slower vmbus device
 channels
Message-ID: <Y0bipdisMbTNMYOq@kroah.com>
References: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 12, 2022 at 04:56:46AM -0700, Saurabh Sengar wrote:
> This patch enables support for slower vmbus channels, which consist
> of following 3 changes :
> 	1. Support for hypercalls
> 	2. Module params for recv/send buffer sizes
> 	3. Module param for custom ring buffer sizes

Even if this all was ok, you are doing 3 things all in one change,
that's not allowed at all, you all know this.

Anyway, no new module parameters, this is not the 1990's, we have much
better ways to do this properly (hint, module parameters modify code,
you want to modify the options of a specific device.)

greg k-h
