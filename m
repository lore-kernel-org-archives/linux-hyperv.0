Return-Path: <SRS0=S9PY=Q6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DBCC43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 08:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB45320850
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550912239;
	bh=aZe5xVzZorGvqNXMwwWxUGB7fvbTfHaPkqMuO1pGIEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MY/VAO3mARhuNTioITjqWbhkcztcst35ImQ9h+38JwYmBQQ9gxnQCcldk591nuFnm
	 vKVpS7BC0eE75fVyrdV7WYaWs9hXyH0Y9GyFhoBmFEhI6U3uUHY0eWfk7mrlmRqk2o
	 2fzDrYIPnILXEyihn6ZpG+jCl16cNFLl6lTGEoQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfBWI5T (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfBWI5T (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 Feb 2019 03:57:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6552084F;
        Sat, 23 Feb 2019 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550912238;
        bh=aZe5xVzZorGvqNXMwwWxUGB7fvbTfHaPkqMuO1pGIEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uykjkNWDB9vFtLmpvw8uUknvJLVDFfis7hW0/omyoEqfBGKWBI0ZAlSuJurHk1CqQ
         KnCEiRB9Jn4w86miEj5sYuuKzgdgw/+drP9hEoMOIJFgH4ZOgNbS9UDflYw1Pw+0fg
         uX/Vtt+kRU9gf5if/QHSJ8kAUipg06EtTGKYxVt4=
Date:   Sat, 23 Feb 2019 09:57:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0-rc
Message-ID: <20190223085715.GA22149@kroah.com>
References: <20190223031226.AB912206A3@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223031226.AB912206A3@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 22, 2019 at 10:12:25PM -0500, Sasha Levin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:
> 
>   Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
> 
> for you to fetch changes up to b2946cd86f3c1b5b1262c0ec06068110c2328fe6:
> 
>   MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS (2019-02-22 21:46:37 -0500)
> 
> - ----------------------------------------------------------------
> Two fixes:
> 
> 1. A fix for a race condition reading sysfs entries while a device is
> being added, by Kimberly Brown.
> 
> 2. Update the Hyper-V mailing list to a new one created on
> vger.kernel.org, by Haiyang Zhang.
> 
> - ----------------------------------------------------------------
> Haiyang Zhang (1):
>       MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS
> 
> Kimberly Brown (2):
>       Drivers: hv: vmbus: Change server monitor_pages index to 0
>       Drivers: hv: vmbus: Return -EINVAL if monitor_allocated not set

I objected to this last patch when it was posted on the list.  The sysfs
file should just not be present if the functionality is not there, no
need to add the "-EINVAL" logic to it instead.

Having a sysfs file that says it can be read, and then rejecting that
read with an error is NOT ok.

I'll cherry-pick the other two patches, but this one needs to be
reworked.

thanks,

greg k-h
