Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D70C2D0E4
	for <linux-hyperv@archiver.kernel.org>; Wed, 25 Nov 2020 02:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994CC20872
	for <linux-hyperv@archiver.kernel.org>; Wed, 25 Nov 2020 02:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgKYC4T (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 24 Nov 2020 21:56:19 -0500
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:40964 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgKYC4S (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 21:56:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D91DD127F;
        Wed, 25 Nov 2020 02:56:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spy30_0f0529627373
X-Filterd-Recvd-Size: 2214
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 25 Nov 2020 02:56:15 +0000 (UTC)
Message-ID: <60b60d026a0636090b1617c6fd9e7b3a88013a7f.camel@perches.com>
Subject: Re: [PATCH 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
From:   Joe Perches <joe@perches.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
Date:   Tue, 24 Nov 2020 18:56:14 -0800
In-Reply-To: <ada0ef93-1443-49a0-914c-1ad03ffa024b@castello.eng.br>
References: <20201115195734.8338-1-matheus@castello.eng.br>
         <20201115195734.8338-5-matheus@castello.eng.br>
         <MW2PR2101MB1052B329DFC5D54F4D7501E9D7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
         <ada0ef93-1443-49a0-914c-1ad03ffa024b@castello.eng.br>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 2020-11-24 at 21:54 -0300, Matheus Castello wrote:
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
[]
> > The above would be marginally better if organized as follows so that the
> > main execution path isn't in an "if" clause.  Also reduces indentation.
> > 
> > 	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
> > 	if (!hv_panic_page) {
> > 		pr_err("Hyper-V: panic message page memory allocation failed");

And nicer to add a terminating newline to the format like the pr_err below.

> > 		return;
> > 	}
> > 	ret = kmsg_dump_register(&hv_kmsg_dumper);
> > 	if (ret) {
> > 		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> > 		hv_free_hyperv_page((unsigned long)hv_panic_page);
> > 		hv_panic_page = NULL;
> > 	}


