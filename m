Return-Path: <SRS0=Kt8c=UX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432AC48BE8
	for <linux-hyperv@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F32722DCC
	for <linux-hyperv@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561340553;
	bh=Km/EG26G//otzJirp7DHc7RJp8gQBMn6W9dxgDNtxZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RobXrjov1MP7oOEs6akJZW8RUpNY88XvCFHLiRwaQMQbNf29YZEQhtBXl1ZsJBHFk
	 q1iQCNyUeNBDgjDpwJT1fztKbE8nyXr1cd/Le2mDoJ825kG7wfICeYd895K+G1MnG4
	 smd9EVzziQAEzijMFDNU5nwfO3mBd6P0CYr7dso4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfFXBmY (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfFXBmY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jun 2019 21:42:24 -0400
Received: from localhost (mobile-107-77-172-83.mobile.att.net [107.77.172.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8AA2208E4;
        Mon, 24 Jun 2019 00:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561335872;
        bh=Km/EG26G//otzJirp7DHc7RJp8gQBMn6W9dxgDNtxZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grcHSJMH3kPW9Zu1kz/gWzmcxOFASAqZ2TT/0LPbSGJkyK91/BXFpxwRwuOAT5a0U
         eTfiYHI08zHQqep9xE80GVfLv0m41eESZKfQWosEkz61WNNt1VuBmPlb9xfn44A/ar
         btaVIxYwKhWHHtdCrtUInzfldSwCGeCOn121tG44=
Date:   Sun, 23 Jun 2019 20:24:30 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>, linux-hyperv@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Message-ID: <20190624002430.GN2226@sasha-vm>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <20190624075834.2491a61a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190624075834.2491a61a@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 24, 2019 at 07:58:34AM +1000, Stephen Rothwell wrote:
>Hi Sasha,
>
>On Sun, 23 Jun 2019 15:09:29 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>
>> Appologies about this. I ended up with way more travel than I would have
>> liked (writing this from an airport). I've reset our hyperv-next branch
>> to remove these 3 commits until we figure this out.
>
>But not pushed out, yet?

Pushed now. For some reason the airport wifi was blocking ssh :/

--
Thanks,
Sasha
