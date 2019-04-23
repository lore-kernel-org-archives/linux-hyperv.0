Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805AAC282DD
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 19:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4681E21850
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556048721;
	bh=+nJMRFHpv5lLMh0pucCjE5AEJotV/bWzVURalK9xDDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z+2tLEUY1ExkobBG9/k2k3QRBSDRvIAHOfExESfIm5mwBrEU1LoFxWeAyp28gK6lZ
	 /KF4/FSs3kevSqr0LJXgr7PVobnErDgupTo6JqkCpKSKkgyzUWTPHZD7jW/b4aKXrm
	 6y8GpSOmo36M2Ng36zKC7YQ53CJXN2mEQlBmUg7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfDWTpV (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDWTpV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Apr 2019 15:45:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9FF21773;
        Tue, 23 Apr 2019 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556048720;
        bh=+nJMRFHpv5lLMh0pucCjE5AEJotV/bWzVURalK9xDDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xd/KNTphbnWMq2tZkeTDYZ+fF323Z/ScZzO62/TqFwjcgfMLXVjZGWmLcuoyZlOjG
         ep3ka3zeMF37LzV59Znyg9DwehTaNXnPbtKMuF2RoX3fGcwKqRe+5mFpIqLDZIFFce
         CvjnfhQQZbJZ/w5zXodrNDsGeLer513SZrcDUrRY=
Date:   Tue, 23 Apr 2019 15:45:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] drivers: hv: Add a module description line to the
 hv_vmbus driver
Message-ID: <20190423194519.GT17719@sasha-vm>
References: <04eaef0e2b365317935ff756c7365ee13a6f18f8.1555967337.git.joseph.salisbury@microsoft.com>
 <DM5PR2101MB0918DA7EF7FAFC78C24D8350D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB0918DA7EF7FAFC78C24D8350D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 23, 2019 at 04:39:57PM +0000, Michael Kelley wrote:
>From: Joseph Salisbury <joseph.salisbury@microsoft.com> Sent: Monday, April 22, 2019 8:47 PM
>>
>> This patch only adds a MODULE_DESCRIPTION statement to the driver.
>> This change is only cosmetic, so there should be no runtime impact.
>>
>> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
>>
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
