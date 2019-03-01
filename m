Return-Path: <SRS0=e6q8=RE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2BCC43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED9C2085A
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551455218;
	bh=wn4shBjv4kR9CPry+pyJA07oaTWXrN/IAMXCw0EBtso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1NUzAmXW+lTmqMgCFlbSwiTTYILFuyzrcTzBEsl85hSKvy9nyOJA2DNFBUU4vcZw
	 iwCubz3gyZUVNKNTmvvRglpQQqOqVbEdVeA1vckYU3jx+XJptEfiRaXVt977DZ88ZZ
	 ljYd5cgoCfma5dXasOIKofdMJFzLxbpyelpq80Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfCAPq5 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfCAPq5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Mar 2019 10:46:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9510A20851;
        Fri,  1 Mar 2019 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551455217;
        bh=wn4shBjv4kR9CPry+pyJA07oaTWXrN/IAMXCw0EBtso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUa07itjb/M5bIjvwjQqPOrfR7eRR61Yl6gfiUH2rlkqqbgE9kvhmXWhsHkuuhVqt
         Hb8iixBgC5yJgTSUMvqy8oFIyRQn3Xyj/8dIJdw/ASCcwDpPPfX/L6+HYrnsfl6F7d
         U32qbPZBCfYSIKnxzsu+7wLBFv0Li/dP3iDslLDQ=
Date:   Fri, 1 Mar 2019 16:46:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V commits for v5.1
Message-ID: <20190301154654.GA4270@kroah.com>
References: <20190301151621.486D92084F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301151621.486D92084F@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 01, 2019 at 10:16:20AM -0500, Sasha Levin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:
> 
>   Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

pulled and pushed out, thanks.

greg k-h
