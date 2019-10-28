Return-Path: <SRS0=Evx3=YV=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB940CA9EC0
	for <linux-hyperv@archiver.kernel.org>; Mon, 28 Oct 2019 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2FC21744
	for <linux-hyperv@archiver.kernel.org>; Mon, 28 Oct 2019 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572280009;
	bh=PdrC5fR7vi4+RQ67Fzc7rc+qt+SX/7NX6AYKx2xn1UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X3QDnNbENTsUllHjZzgLIblruDn/1Ep/PK5gLYQAwfdOkO5dAcwGlLiUP+8JmmpVR
	 Rb1D77BVqubrXhIN00RDunjKweIpusis4vy4sdW5U1TE/j7ikjxl3/IbyL2crO8Kog
	 k8FQDw05Lj7f7Ru8Wd+46WSGEPT74yIkSolhGGns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbfJ1Q0t (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbfJ1Q0t (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Oct 2019 12:26:49 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F6C214E0;
        Mon, 28 Oct 2019 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572280008;
        bh=PdrC5fR7vi4+RQ67Fzc7rc+qt+SX/7NX6AYKx2xn1UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1cHJ16hB2Sz3Gu0SnZjNozCaT02ffUuPGxWnBvDgZbPxpcLIGXQJo+0mMKKnAaHyF
         uhem9+NOAA85q37SDu+BNia1BgM6rx+2iNcS4WPVo5c96GIb3lV9Eq9sYT/y5b91OM
         8pRpjLD9I3vwNbVOFSqr0LzQj9GOcgeSS7N7JKFU=
Date:   Mon, 28 Oct 2019 12:26:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3 0/3] Drivers: hv: vmbus: Miscellaneous improvements
Message-ID: <20191028162645.GH1554@sasha-vm>
References: <20191015114646.15354-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015114646.15354-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 15, 2019 at 01:46:43PM +0200, Andrea Parri wrote:
>Hi all,
>
>The patchset:
>
>  - refactors the VMBus negotiation code by introducing the table of
>    VMBus protocol versions (patch 1/3),
>
>  - enables VMBus protocol version 4.1, 5.1 and 5.2 (patch 2/3),
>
>  - introduces a module parameter to cap the VMBus protocol versions
>    which a guest can negotiate with the hypervisor (patch 3/3).

Queued up for hyperv-next, thanks!

-- 
Thanks,
Sasha
