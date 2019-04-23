Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DA7C282DD
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DA921773
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556048697;
	bh=fsHZig5tspjRi5GQWJ+Z3RuWZ6zsfcwO+Kt+5vhxiu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N24qTfAp/5Pjf4jqHnpVoAlf2B+nfIHjtMXi5a1elCqZZOfU4EwI/M2LUoBHY5zIK
	 SbC4i352Xjv0nr883ULYwxZZi0zhx+guFULZX8CpdBxmLSYBlZL3SI1r3nCp83y/r1
	 wFl9Z2Q6fQ+F3EPQYyPOY8hbVB8Hr43QanHssMa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfDWTow (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDWTow (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Apr 2019 15:44:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE0C21773;
        Tue, 23 Apr 2019 19:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556048691;
        bh=fsHZig5tspjRi5GQWJ+Z3RuWZ6zsfcwO+Kt+5vhxiu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iz6JFjkXS9IXqG6zjGPkdRCoL8QMIt6OmtmvpZxyyYK6C2jZ72dggVDBRBM2/eHpb
         t3X83TKmVv7AlwmKF+qJF7tPa3dexgLKxMxomSRzvIiIuEjP34FCYRWh8TTkTBdYsj
         O455mqcf3Eopb/sTlfOn3be+9e6As6a19VwH6u2A=
Date:   Tue, 23 Apr 2019 15:44:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] drivers: hid: Add a module description line to the
 hid_hyperv driver
Message-ID: <20190423194450.GR17719@sasha-vm>
References: <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
 <DM5PR2101MB09183A22984131883E033DA7D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB09183A22984131883E033DA7D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 23, 2019 at 04:38:05PM +0000, Michael Kelley wrote:
>From: Joseph Salisbury <joseph.salisbury@microsoft.com> Sent: Monday, April 22, 2019 8:47 PM
>>
>> This patch only adds a MODULE_DESCRIPTION statement to the driver.
>> This change is only cosmetic, so there should be no runtime impact.
>>
>>
>> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
>> ---
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
