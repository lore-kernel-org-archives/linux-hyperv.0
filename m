Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D47EB64DB
	for <linux-hyperv@archiver.kernel.org>; Wed, 14 Jun 2023 21:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFNVRG (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjFNVRF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jun 2023 17:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A785BE6C;
        Wed, 14 Jun 2023 14:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D16E60DF4;
        Wed, 14 Jun 2023 21:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E42C433C0;
        Wed, 14 Jun 2023 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686777423;
        bh=XjFv25feh5z3BwlZoH20bTGy8or+VylkkD7fQlyCmDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ud2jLywLAUn44FGVrlbm5A9plEIgqO9h/bZ0oQGDszWvMpdaaMgXLmZ7L0Sq5nDNB
         BhF2TrqEQMY0VDMeHv+g6dhBz4fzrsqaQp9PVvF5Owyf7Q9oxf3ezNnSXEEZwss+kw
         +nTK2KACF3ehVRYlxBiFFZGoTlEVIk1TMEI7KFXs=
Date:   Wed, 14 Jun 2023 23:17:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/5] tools: hv: Add new fcopy application based on uio
 driver
Message-ID: <2023061413-flap-underage-90b9@gregkh>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-4-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686766512-2589-4-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 14, 2023 at 11:15:10AM -0700, Saurabh Sengar wrote:
> New fcopy application which utilizes uio_hv_vmbus_client driver

Please read the kernel documentation for how to write a good kernel
changelog.

THen get another microsoft kernel developer to review this patchset
before you send it out again, it needs some basic rework for simple
things like this.

I've stopped reviewing this series here.

thanks,

greg k-h
