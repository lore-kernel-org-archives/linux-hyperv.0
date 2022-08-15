Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92129C19F2C
	for <linux-hyperv@archiver.kernel.org>; Tue, 16 Aug 2022 05:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiHPFHE (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 16 Aug 2022 01:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiHPFGp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 01:06:45 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D27100C
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Aug 2022 14:06:59 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NhIPoUIJz4lbwNhIPoi6UR; Mon, 15 Aug 2022 23:06:56 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Aug 2022 23:06:56 +0200
X-ME-IP: 90.11.190.129
Message-ID: <d9a4321c-efc3-e2b8-1bb7-9e2413940885@wanadoo.fr>
Date:   Mon, 15 Aug 2022 23:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/hyperv: Fix an error handling path in
 hyperv_vmbus_probe()
Content-Language: fr
To:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <7dfa372af3e35fbb1d6f157183dfef2e4512d3be.1659297696.git.christophe.jaillet@wanadoo.fr>
 <PH0PR21MB3025D61C85CD6E724919A9D8D79E9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220815155608.uekossy5hejqflni@liuwe-devbox-debian-v2>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220815155608.uekossy5hejqflni@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Le 15/08/2022 à 17:56, Wei Liu a écrit :
>>
>> All that said, the fix looks good, so
>>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> I made the two changes listed above and applied this patch to
> hyperv-fixes.
> 

Thanks a lot, that saves me a v2.

CJ

> Thanks,
> Wei.
> 

