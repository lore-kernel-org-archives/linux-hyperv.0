Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9671C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5182175B
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 10:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfCTKVB (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:21:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35161 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCTKVB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 06:21:01 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6YKy-0000qq-LI; Wed, 20 Mar 2019 11:20:44 +0100
Date:   Wed, 20 Mar 2019 11:20:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     KY Srinivasan <kys@microsoft.com>
cc:     Kangjie Lu <kjlu@umn.edu>, "pakki001@umn.edu" <pakki001@umn.edu>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyperv: a potential NULL pointer dereference
In-Reply-To: <CY4PR21MB0773FB535B3F4177CA9662C0A04B0@CY4PR21MB0773.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1903201119240.1906@nanos.tec.linutronix.de>
References: <20190314054651.1315-1-kjlu@umn.edu> <CY4PR21MB0773FB535B3F4177CA9662C0A04B0@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 14 Mar 2019, KY Srinivasan wrote:
> > -----Original Message-----
> > From: Kangjie Lu <kjlu@umn.edu>
> > Sent: Wednesday, March 13, 2019 10:47 PM
> > To: kjlu@umn.edu
> > Cc: pakki001@umn.edu; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger
> > <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Thomas
> > Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav
> > Petkov <bp@alien8.de>; H. Peter Anvin <hpa@zytor.com>; x86@kernel.org;
> > linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] hyperv: a potential NULL pointer dereference
> > 
> > In case alloc_page, the fix returns -ENOMEM to avoid the potential
> > NULL pointer dereference.
> > 
> Thanks.
> 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

Did you mean: Reviewed-by or Acked-by?

You cannot sign off on a patch from
someone else which you are not picking up and transporting it further.

Thanks,

	tglx
