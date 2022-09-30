Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D9BC433F5
	for <linux-hyperv@archiver.kernel.org>; Fri, 30 Sep 2022 02:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiI3C0Z (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 29 Sep 2022 22:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiI3C0Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Sep 2022 22:26:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189491176F3;
        Thu, 29 Sep 2022 19:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0C08B826C8;
        Fri, 30 Sep 2022 02:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38323C433D7;
        Fri, 30 Sep 2022 02:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664504781;
        bh=/WEoZ8n88myss+8KOVb0Zar/v+0c5JDnq5LdQkkghB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MCuEpTEbMAzR3lSSJK11K8hnvD9CTdc00XZkq4kNuXsUJB0J325uptTx03CAG9a7G
         1iwip99vLN4b3gNoBuMipmvKxG/tCxqJeBwpuwnyhi8mD0npIzzDqBk45MrzJRibcS
         9rDpQjw1qS49h3h2qwC3GqtoepaxFO3H6CtmMSalahL3yhmVHH8FY1FXvmQPptHdLc
         vA7Xwqz43pT9yaKtpvIN9EESYh5Lfm49T2ty5uk5aLozhzkjFRih4C/AVlzmE6CJuY
         nbzM/aI2NmVMmmcgnp3AwLGNdY+Q5qeHf+ypCFmGfhsNl+/AJeHwCmiHj5t1TQqDRU
         CZGmAK93m6HJQ==
Date:   Thu, 29 Sep 2022 19:26:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Gaurav Kohli <gauravkohli@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: Fix race between VF offering and VF
 association message from host
Message-ID: <20220929192620.2fa1542f@kernel.org>
In-Reply-To: <1664372913-26140-1-git-send-email-gauravkohli@linux.microsoft.com>
References: <1664372913-26140-1-git-send-email-gauravkohli@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 28 Sep 2022 06:48:33 -0700 Gaurav Kohli wrote:
> During vm boot, there might be possibility that vf registration
> call comes before the vf association from host to vm.
> 
> And this might break netvsc vf path, To prevent the same block
> vf registration until vf bind message comes from host.
> 
> Cc: stable@vger.kernel.org
> Fixes: 00d7ddba11436 ("hv_netvsc: pair VF based on serial number")
> Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>

Is it possible to add a timeout or such? Waiting for an external 
event while holding rtnl lock seems a little scary.

The other question is - what protects the completion and ->vf_alloc
from races? Is there some locking? ->vf_alloc only goes from 0 to 1
and never back?
