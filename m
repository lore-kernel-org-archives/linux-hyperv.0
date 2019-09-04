Return-Path: <SRS0=MZwT=W7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA9BC3A5A7
	for <linux-hyperv@archiver.kernel.org>; Wed,  4 Sep 2019 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C25022DBF
	for <linux-hyperv@archiver.kernel.org>; Wed,  4 Sep 2019 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567607026;
	bh=q4hCRkM7CBlSJ5qN5g57oao1y0pVDCO/sOHQjBQihhY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ynlWxoKPx/MNI1uMWMdyMpwAnCKtyQNau6CF5jTiq7zidCkygRulqbfkLARnWAyC9
	 ZkWggv4bQtyncah0AYL/vYuW+3UxQUTLAkPYJrqLc66sVMlEjIPq2zJO+0XKmfZpms
	 y4ZCsqDkofQDJB8sy+C0On9dWfBUR4ecZHWRkjbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfIDOXq (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbfIDOXq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Sep 2019 10:23:46 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03ED422CED;
        Wed,  4 Sep 2019 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567607025;
        bh=q4hCRkM7CBlSJ5qN5g57oao1y0pVDCO/sOHQjBQihhY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Hp6aanycZdKm59KxYy4A+pXujfEVf/oWNkMVKfp/xIX8ftyzXDe/l4sNuzlwOny+B
         9s3gfctACIDYIRlj66faWLbQjPtqk7nqrm83ulFHPVPLvXIgkinDIk1DoJf+x0ervO
         /otWvmmupU9DuhGRi4ikQCrs5YEoltQY9JsDo4no=
Date:   Wed, 4 Sep 2019 16:23:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
cc:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
In-Reply-To: <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Message-ID: <nycvar.YFH.7.76.1909041623050.31470@cbobk.fhfr.pm>
References: <1566269763-26817-1-git-send-email-decui@microsoft.com> <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 3 Sep 2019, Dexuan Cui wrote:

> > Hi Jiri, Benjamin, can this patch go through Sasha's hyperv tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> > 
> > This is a purely Hyper-V specific change.
> 
> Hi Jiri, Benjamin,
> Are you OK if this patch for the Hyper-V HID driver goes through the Hyper-V
> tree maintained by Sasha Levin? It's a purely Hyper-V change, and I have
> been using the patch for several months and there is no regression.

No problem with that. Feel free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

in that case.

Thanks,

-- 
Jiri Kosina
SUSE Labs

