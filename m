Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221DCCA47C
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Jun 2022 14:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiFTOjM (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 20 Jun 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbiFTOil (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jun 2022 10:38:41 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E42642;
        Mon, 20 Jun 2022 06:55:45 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:55:42 +0200
From:   Vit Kabele <vit.kabele@sysgo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        kys@microsoft.com
Subject: Re: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
Message-ID: <YrB8Xvjp2KKQ/JhT@czspare1-lap.sysgo.cz>
Mail-Followup-To: Vit Kabele <vit.kabele@sysgo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, kys@microsoft.com
References: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
 <874k0kirbf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k0kirbf.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 16, 2022 at 05:03:16PM +0200, Vitaly Kuznetsov wrote:
> Vit Kabele <vit.kabele@sysgo.com> writes:
> > Nevertheless, I am not sure about following:
> >
> > 1/ The vmbus_initiate_unload function is called within the panic handler
> > even when the vmbus initialization does not finish (there might be no
> > vmbus at all). This should probably not be problem because the vmbus
> > unload function always checks for current connection state and does
> > nothing when this is "DISCONNECTED". For better readability, it might be
> > better to add separate panic notifier for vmbus and crash reporting.
> >
> > 2/ Wouldn't it be better to extract the whole reporting capability out
> > of the vmbus module, so that it stays present in the kernel even when
> > the vmbus module is possibly unloaded?
> 
> IMHO yes but as you mention hyperv_panic_event() currently does to
> things:
> 1) Initiates VMBus unload
> 2) Reports panic to the hypervisor
> 
> I think untangling them moving the later to arch/x86/hyper-v (and
> arch/arm64/hyperv/) makes sense.
Ok, I will send the complete patch soon.

-- 
Best regards,
Vit Kabele
