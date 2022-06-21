Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE5C43334
	for <linux-hyperv@archiver.kernel.org>; Tue, 21 Jun 2022 07:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbiFUHP4 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiFUHPz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jun 2022 03:15:55 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10545167F5;
        Tue, 21 Jun 2022 00:15:55 -0700 (PDT)
Date:   Tue, 21 Jun 2022 09:15:52 +0200
From:   Vit Kabele <vit.kabele@sysgo.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
Message-ID: <YrFwKAis3WmPiWVx@czspare1-lap.sysgo.cz>
Mail-Followup-To: Vit Kabele <vit.kabele@sysgo.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
References: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
 <874k0kirbf.fsf@redhat.com>
 <YrB8Xvjp2KKQ/JhT@czspare1-lap.sysgo.cz>
 <PH0PR21MB302564C8AC6C3B4F0153A596D7B09@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302564C8AC6C3B4F0153A596D7B09@PH0PR21MB3025.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 20, 2022 at 02:53:58PM +0000, Michael Kelley (LINUX) wrote:
> FYI, there's a large patch series [1] that proposed some reorganization
> of the panic notifiers across the Linux kernel.  Patch 16 of the series
> splits the Hyper-V panic notifier into two along the lines that you
> suggest.  In addition to the patch itself, the comments and follow-on
> discussion are relevant to changes you propose.  See my responses
> throughout the series.
> 
> The author of the series is planning a v2, but he's out for a few weeks
> so there will be a delay. [2]
Aha, great. Thank you for the information, I won't reinvent the wheel
then :)
 
> [1] https://lore.kernel.org/linux-hyperv/20220427224924.592546-1-gpiccoli@igalia.com/T/#t
> [2] https://lore.kernel.org/linux-hyperv/20220427224924.592546-1-gpiccoli@igalia.com/T/#m3c190913bcb6f66e3ace792b4e6f2236839d4fa7

-- 
Best regards,
Vit Kabele
