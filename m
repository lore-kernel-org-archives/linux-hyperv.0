Return-Path: <SRS0=vgga=S3=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEBC10F03
	for <linux-hyperv@archiver.kernel.org>; Thu, 25 Apr 2019 09:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD26214C6
	for <linux-hyperv@archiver.kernel.org>; Thu, 25 Apr 2019 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556184450;
	bh=SX3fEzBEiup92Fmtw52ospjzrzbfJ38p0MwjLEGFxBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X1s8ZFhz9NNr8LgFZEgWcBAWdz9L+DrvWDzhCq1LqCJcoHaW6JUqmz4njrFWhBvEB
	 6H1w/I2kGGiFbdLtFl6j9Dk0snuZXS3SjcJJUPngn14FrRBE75gfrIu3+so269jnVm
	 eDLCpAjCcJQftLLph38wcavXhwJnzqKg+zs39DfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfDYJ1a (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfDYJ1a (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Apr 2019 05:27:30 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F4E20675;
        Thu, 25 Apr 2019 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556184449;
        bh=SX3fEzBEiup92Fmtw52ospjzrzbfJ38p0MwjLEGFxBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjau3TDusofoqdOaW+QkKd/EWDISG5ttg6gnaaEUbV7q4ktT/aDdi4P3yHrWVRwZt
         tHcVw85GaSNFLnROKA3qYWvTbmWVBrbuxPVL8atpD5piA7gANyEdXaASctI4k36vzh
         49NkJNrTIOY8vO65SIwuH79ppsEJUob0KeAIAm90=
Date:   Thu, 25 Apr 2019 11:27:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V commits for 5.1
Message-ID: <20190425092712.GA5959@kroah.com>
References: <20190417013452.438FA20821@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417013452.438FA20821@mail.kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 16, 2019 at 09:34:51PM -0400, Sasha Levin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

Now pulled and pushed out, thanks.

greg k-h
