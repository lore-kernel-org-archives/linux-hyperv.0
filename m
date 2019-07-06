Return-Path: <SRS0=zkQS=VD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09848C5B578
	for <linux-hyperv@archiver.kernel.org>; Sat,  6 Jul 2019 07:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4723216B7
	for <linux-hyperv@archiver.kernel.org>; Sat,  6 Jul 2019 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562399642;
	bh=SL58GbW5h343HEakJ02bx/bRsqwrFAJtkG3Rl+qQMyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RfKMewUqsRI4DX3so9Z0tclfzPGNYe15YGd+4+xcuFDPoZGrouOVKLeVcCMTEzEew
	 PiNWpJ5+QINwVInZdL4DaIKOFTbbO5Nsh4cFpyZZkAPEj9QR0OBrpS7CYUFpUzagYq
	 n3GMsOcMJV65v+Ot7IuzemrAYi/IYmn9KB8cLLMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfGFHx7 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 6 Jul 2019 03:53:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46739 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfGFHx7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 6 Jul 2019 03:53:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so11158285ote.13;
        Sat, 06 Jul 2019 00:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6mY2CfnJn0z6m6PWk92q2rVFU6R3KZLNmdBvZJpNLg=;
        b=ku79V/Ehw34nV+rjPJO6dhAGasHYEKvhJvCw1tvprS4gXx56MVlnJVWEcDK8jG9X31
         /8QymLli6PIfj/m86a+79Q36C4n16lWDBcx46zTeXF4w+YzH8NBxkNb2fn4T8xJ0hgGK
         jLwqo52oVPClNsWMyqqIH7s+5GsldO1LyzSCp6oe/28GrjBz0Fma4QGVoEgvDtpVYUAf
         EjA1FFfbrxvldiqTL/FRz/fLZj4prU51DJS+/CPs7hmEHH2O9nfK7uqmgigvouDPXXmr
         ZYLnCCJigpKd0Y8AcSVD4Osh8NbDPmlcDw6AZQrwDQ+8TlVWCkAe5SHqlYjsWV8AckFx
         wAYA==
X-Gm-Message-State: APjAAAWNLYERqI1RvxN/Xr8hbddUIC1U9vTHbzLAXMdYMUY3tVVHB/31
        u5fojnUCU9RC3z70SorzmAMYWnPLb4mNkrot994=
X-Google-Smtp-Source: APXvYqwTSqbL/OKY4+prlMpOtaJSQmc+yPsHR+RTeokBw6aGC5mz5ZwTCZPuKAOApRdbIvPNxY6ovXXaFeRXTpBKGyE=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr3981699otn.266.1562399638756;
 Sat, 06 Jul 2019 00:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <PU1P153MB0169731042EFE4D6B08F04A5BFF50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169731042EFE4D6B08F04A5BFF50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jul 2019 09:53:45 +0200
Message-ID: <CAJZ5v0i+UL7kVPWp_fLOKpLJtHTyy6NccU0JMxcaRnuSHoQALg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Fix "multiple definition of acpi_sleep_state_supported"
 for ARM64
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 5, 2019 at 10:18 PM Dexuan Cui <decui@microsoft.com> wrote:
>
>
> If CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT is not set, the dummy version of
> the function should be static.
>
> Fixes: 1e2c3f0f1e93 ("ACPI: PM: Make acpi_sleep_state_supported() non-static")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>
> Sorry for not doing it right in the previous patch!
>
> The patch fixes the build errors on ARM64:
>
>    drivers/net/ethernet/qualcomm/emac/emac-phy.o: In function `acpi_sleep_state_supported':
> >> emac-phy.c:(.text+0x1d8): multiple definition of `acpi_sleep_state_supported'
>    drivers/net/ethernet/qualcomm/emac/emac.o:emac.c:(.text+0xbf8): first defined here
>    drivers/net/ethernet/qualcomm/emac/emac-sgmii.o: In function `acpi_sleep_state_supported':
>    emac-sgmii.c:(.text+0x548): multiple definition of `acpi_sleep_state_supported'
>    drivers/net/ethernet/qualcomm/emac/emac.o:emac.c:(.text+0xbf8): first defined here
>
>
>  include/acpi/acpi_bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 4ce59bdc852e..8ffc4acf2b56 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -657,7 +657,7 @@ static inline int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable)
>  #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
>  bool acpi_sleep_state_supported(u8 sleep_state);
>  #else
> -bool acpi_sleep_state_supported(u8 sleep_state) { return false; }
> +static bool acpi_sleep_state_supported(u8 sleep_state) { return false; }

This should be static inline even.

I've reapplied the original patch with this change folded in.

Thanks!
