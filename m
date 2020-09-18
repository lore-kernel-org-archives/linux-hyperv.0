Return-Path: <SRS0=48U9=C3=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB17C43464
	for <linux-hyperv@archiver.kernel.org>; Fri, 18 Sep 2020 09:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898F621D24
	for <linux-hyperv@archiver.kernel.org>; Fri, 18 Sep 2020 09:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRJMZ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 18 Sep 2020 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIRJMZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Sep 2020 05:12:25 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B8C06174A;
        Fri, 18 Sep 2020 02:12:25 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 53443396; Fri, 18 Sep 2020 11:12:23 +0200 (CEST)
Date:   Fri, 18 Sep 2020 11:12:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH RFC v1 04/18] iommu/hyperv: don't setup IRQ remapping
 when running as root
Message-ID: <20200918091221.GM31590@8bytes.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-5-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914112802.80611-5-wei.liu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 14, 2020 at 11:27:48AM +0000, Wei Liu wrote:
> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Joerg Roedel <jroedel@suse.de>

