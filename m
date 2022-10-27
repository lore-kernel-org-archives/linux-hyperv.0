Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826D7FA373D
	for <linux-hyperv@archiver.kernel.org>; Thu, 27 Oct 2022 10:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiJ0KV0 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 27 Oct 2022 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiJ0KVH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Oct 2022 06:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483DD1162CE;
        Thu, 27 Oct 2022 03:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D242B61F24;
        Thu, 27 Oct 2022 10:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E97C433C1;
        Thu, 27 Oct 2022 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666866063;
        bh=SvS8mCRDamJq7RQvM8z6wji2jsI8Gikmweq8HnvzFCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKlhCja6VxWyUOYNM2fzIqkZa2ktIYB73scknt/sdSlXmUPCJBTEf5ORG2gXJ9Kpm
         7g0cGSyFA44iySjXMoTbyYL8zCwpMBs62Xnd8xuxfnlZwJlOnwwhhkMyKWTC/IgIRI
         hJSikfWBEZnW0UHuHpcsWEsG81cL7Z2x9pvbcCGc=
Date:   Thu, 27 Oct 2022 12:21:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaurav Kohli <gauravkohli@linux.microsoft.com>
Cc:     stable@vger.kernel.org, haiyangz@microsoft.com,
        davem@davemloft.net, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 5.10] hv_netvsc: Fix race between VF offering and VF
 association message from host
Message-ID: <Y1pbjBqLUhTGRgzX@kroah.com>
References: <1666790623-29227-1-git-send-email-gauravkohli@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666790623-29227-1-git-send-email-gauravkohli@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 26, 2022 at 06:23:43AM -0700, Gaurav Kohli wrote:
> [ Upstream commit 365e1ececb2905f94cc10a5817c5b644a32a3ae2 ]
> 
> During vm boot, there might be possibility that vf registration
> call comes before the vf association from host to vm.
> 
> And this might break netvsc vf path, To prevent the same block
> vf registration until vf bind message comes from host.
> 
> Cc: stable@vger.kernel.org
> Fixes: 00d7ddba11436 ("hv_netvsc: pair VF based on serial number")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  drivers/net/hyperv/hyperv_net.h |  3 ++-
>  drivers/net/hyperv/netvsc.c     |  4 ++++
>  drivers/net/hyperv/netvsc_drv.c | 20 ++++++++++++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
