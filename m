Return-Path: <SRS0=8REI=DU=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490E7C433E7
	for <linux-hyperv@archiver.kernel.org>; Tue, 13 Oct 2020 09:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FCB208D5
	for <linux-hyperv@archiver.kernel.org>; Tue, 13 Oct 2020 09:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602580643;
	bh=p8efPKm7XRfwCPSC5l/ty+juJlcgucomdx9EkyoltLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sx7GBT8EiD0x/4++zhq30pevGD/mwZcZqBzaeVyV/haK38a5CAR/Ejcah7qfsTVXO
	 9liyRPSfWy5ybe5G7uImp5l9B3L+MCRLWE4JNgKYD4nNwszJ+HZAtaPdP3HpV9FlUd
	 X8FQfPS0qBI5JSiKPb7lwkwx3kxMCURLsBocwqa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390757AbgJMJRW (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 13 Oct 2020 05:17:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50550 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390753AbgJMJRV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Oct 2020 05:17:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id 13so20218369wmf.0;
        Tue, 13 Oct 2020 02:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zMddMsSOr3NyQqHwSBF6KhT9IB0oD7WMml2BQYoKN0=;
        b=fVPOZtfqQgFlWF5JVoVVtW+f/5kh0U10EfzgdojE8lazFg00Oy7MNoW61e5mvHAGum
         UrtKemtE8d/vKRJSbSt5KAj1SiQfhCQhZvoUISSANcLH0umcLD4Qroz0bF0qLofoUfG4
         Td+SucCHRbrcxnrnqd/5Mh2JP1wuz0bJduQfrnFT1TvKB64HYzuW6kF4AIQB8a88gpBS
         Hi9Oropr+TKdHcQxw5oG1d7F82hqj9+nrp3p6LD+REgtPmoQ8EAwQPE68a94KO4TmRjj
         t59KSkcsUgfAYCADqcVGtaLvVJT/HrnWw4TflS25jsV8PviEYbnAbtNu6Ckq7f+LeNUR
         GSkQ==
X-Gm-Message-State: AOAM531LRCYgcEMTwRYSK8VKFnKv7oUDuprzKEPjaOgFe654tRn56S3e
        B7p6SG+n/yjHHEDJF1OFr4Y=
X-Google-Smtp-Source: ABdhPJxeB3qrlEGa2i0ujUdEoT1z/JcLaHF3BmI/abGhW/QbzrrYzWbjZbtSa0+mt7ItzNoRyrhDag==
X-Received: by 2002:a05:600c:210f:: with SMTP id u15mr15393370wml.53.1602580639657;
        Tue, 13 Oct 2020 02:17:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c1sm28670034wru.49.2020.10.13.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 02:17:19 -0700 (PDT)
Date:   Tue, 13 Oct 2020 09:17:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1] hv_balloon: disable warning when floor reached
Message-ID: <20201013091717.q24ypswqgmednofr@liuwe-devbox-debian-v2>
References: <20201008071216.16554-1-olaf@aepfle.de>
 <20201008091539.060c79c3.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008091539.060c79c3.olaf@aepfle.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 08, 2020 at 09:15:39AM +0200, Olaf Hering wrote:
> Am Thu,  8 Oct 2020 09:12:15 +0200
> schrieb Olaf Hering <olaf@aepfle.de>:
> 
> > warning is logged in dmesg
> 
> Actually it is logged on the system console, depending on how logging is configured.
> 

So ... this patch is not needed anymore?

Wei.

> 
> Olaf


