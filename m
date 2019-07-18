Return-Path: <SRS0=Mcgk=VP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9059EC7618F
	for <linux-hyperv@archiver.kernel.org>; Thu, 18 Jul 2019 02:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6642021841
	for <linux-hyperv@archiver.kernel.org>; Thu, 18 Jul 2019 02:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563416551;
	bh=6xadr3+yYCHxuYD3vVy1jNPvzGd3qcrQCliP6VNRTK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XEhQaEOZ9yUSFOikVQFMIVGnvkde+UublugkqcZH6cDy3ipv5TpXcAMK3eGGhjXp2
	 YAky36un2K1qymOFk1l7/IAglb003+KNELJi4qvCLVnneSSChuRzHHQrfvjZhpsBu4
	 AEvj9HVKdXLnn5fowKRtUTaTo5aT+M6c0srPHqaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfGRCWb (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfGRCWb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jul 2019 22:22:31 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B325120651;
        Thu, 18 Jul 2019 02:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563416550;
        bh=6xadr3+yYCHxuYD3vVy1jNPvzGd3qcrQCliP6VNRTK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yw39AtK0bsV5kB18dDwUFPaL8O8F0DGzBCSE29YuJl1S9zPxQNW/UzmYXCyAQcOEA
         YP/aM2VM5RHHCfdq03ZBilsy4I5NwtHHwCXEcXABoNBLHYabmr+9CBtXHlhZjNiZGc
         GXwp3WALUFv99ZFjFB07VhIjKmZ2NJWBpW96308o=
Date:   Wed, 17 Jul 2019 22:22:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH v4 3/5] hv: vmbus: Replace page definition with Hyper-V
 specific one
Message-ID: <20190718022228.GF3079@sasha-vm>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
 <0d9e80ecabcc950dc279fdd2e39bea4060123ba4.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0d9e80ecabcc950dc279fdd2e39bea4060123ba4.1562916939.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 12, 2019 at 08:25:18AM +0000, Maya Nakamura wrote:
>Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may
>not be 4096 on all architectures and Hyper-V always runs with a page
>size of 4096.
>
>Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thomas, if you're taking this series, could you grab this patch as well
please (dependencies)?

	Acked-by: Sasha Levin <sashal@kernel.org>

--
Thanks,
Sasha
