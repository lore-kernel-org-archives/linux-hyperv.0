Return-Path: <SRS0=S9PY=Q6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D05C43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896F1206B6
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550937336;
	bh=+Ays36zEFHBmxXkJpu0R3jWM526SktwiDLIwElTU+3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gtR9kgAFKajcPP54GdB9pC3SuDoe2JhQH2aGLp2Pq3jYYiLDV/5ksUcr1AuP0Sc04
	 dSdDigtIlLohnbAul23j9FJRzUHYgqPB0zbiZrQ9kOMSTpSdmwA9SlgOZAC6a/Hj/Y
	 7kBcCi1kWQpCN9iXQnDmW8Edc2X/Q3jTG2Jbc6Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfBWPzg (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 23 Feb 2019 10:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWPzf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 Feb 2019 10:55:35 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E52C20675;
        Sat, 23 Feb 2019 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550937334;
        bh=+Ays36zEFHBmxXkJpu0R3jWM526SktwiDLIwElTU+3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QM/AA0oKUw5NBMESEeAHzsgtEtw1GepbY+FEwTckfKBI8h5MwSrIix6uDYoTGOT2g
         FWyMjc194ug7h2JvC27ri3ejuTjLoXEjKU2j/ovj4czWX8Lgr+80EkjDdgcJKhAOXy
         t6at+9x6Py0xrPKRgxDfR19fXmz5XHKr2QJkkcVI=
Date:   Sat, 23 Feb 2019 10:55:33 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0-rc
Message-ID: <20190223155533.GE10616@sasha-vm>
References: <20190223031226.AB912206A3@mail.kernel.org>
 <20190223085715.GA22149@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190223085715.GA22149@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Feb 23, 2019 at 09:57:15AM +0100, Greg KH wrote:
>On Fri, Feb 22, 2019 at 10:12:25PM -0500, Sasha Levin wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:
>>
>>   Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
>>
>> for you to fetch changes up to b2946cd86f3c1b5b1262c0ec06068110c2328fe6:
>>
>>   MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS (2019-02-22 21:46:37 -0500)
>>
>> - ----------------------------------------------------------------
>> Two fixes:
>>
>> 1. A fix for a race condition reading sysfs entries while a device is
>> being added, by Kimberly Brown.
>>
>> 2. Update the Hyper-V mailing list to a new one created on
>> vger.kernel.org, by Haiyang Zhang.
>>
>> - ----------------------------------------------------------------
>> Haiyang Zhang (1):
>>       MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS
>>
>> Kimberly Brown (2):
>>       Drivers: hv: vmbus: Change server monitor_pages index to 0
>>       Drivers: hv: vmbus: Return -EINVAL if monitor_allocated not set
>
>I objected to this last patch when it was posted on the list.  The sysfs
>file should just not be present if the functionality is not there, no
>need to add the "-EINVAL" logic to it instead.
>
>Having a sysfs file that says it can be read, and then rejecting that
>read with an error is NOT ok.

Hm, I'm sorry but I didn't see an objection on the thread
(https://lore.kernel.org/lkml/20190122020759.GA4054@ubu-Virtual-Machine/)
which is why it was sent in like this.

Could you please point me to it so we can get the patch fixed up?

--
Thanks,
Sasha
