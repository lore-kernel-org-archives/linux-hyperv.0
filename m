Return-Path: <SRS0=yHP1=TJ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159FC04A6B
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 May 2019 01:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD49214AF
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 May 2019 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557363963;
	bh=600qRXLEDKMKeph/AjRgQT+N42KTSsWElKhQOKqFhe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DAAC9+LlCDUiyfdwdIQHKZnj0ewHqfmD/CwDFJRc0EQwC8aYUYRIULCEv0i5mpB8/
	 PiyBweysMNkfqqmD+0/+QVDDmlQTGGe/QvFmHaglAshFQ4zS6nu8A+1ubQ4zxTKfS8
	 OGBnCEWiHZmjrxeMGM1r/L69Dz1IBU5d7VZ8tsY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfEIBGD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 8 May 2019 21:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBGD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 May 2019 21:06:03 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D653621479;
        Thu,  9 May 2019 01:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557363962;
        bh=600qRXLEDKMKeph/AjRgQT+N42KTSsWElKhQOKqFhe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPg5LdTAmRD2OhNEmBwJTTJmPX6CbMLJ90xwUz39kvxl1oA/GSKPUSv+b3lR9GPWl
         nSQW9zRFSc5byUJNsQAkQeMTqlkmxmbqN+V/jsgqhEInRiICHL4XGpDmP6dwSzR8Kf
         Iax1Wo8NaXsjSQBviB+p9Ck0C8WRJAmzapEjWbk8=
Date:   Wed, 8 May 2019 21:06:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "juliana.rodrigueiro@intra2net.com" 
        <juliana.rodrigueiro@intra2net.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix virt_to_hvpfn() for X86_PAE
Message-ID: <20190509010600.GQ1747@sasha-vm>
References: <1557215147-89776-1-git-send-email-decui@microsoft.com>
 <DM5PR2101MB09188A7DB0777CD50333F94ED7310@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB09188A7DB0777CD50333F94ED7310@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 07, 2019 at 12:51:51PM +0000, Michael Kelley wrote:
>From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, May 7, 2019 12:47 AM
>>
>> In the case of X86_PAE, unsigned long is u32, but the physical address type
>> should be u64. Due to the bug here, the netvsc driver can not load
>> successfully, and sometimes the VM can panic due to memory corruption (the
>> hypervisor writes data to the wrong location).
>>
>> Fixes: 6ba34171bcbd ("Drivers: hv: vmbus: Remove use of slow_virt_to_phys()")
>> Cc: stable@vger.kernel.org
>> Cc: Michael Kelley <mikelley@microsoft.com>
>> Reported-and-tested-by: Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>
>Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

Queued for hyperv-fixes, thanks!

--
Thanks,
Sasha
