Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18801C433EF
	for <linux-hyperv@archiver.kernel.org>; Tue, 29 Mar 2022 12:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiC2MFm (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiC2MFl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Mar 2022 08:05:41 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCADF193CB;
        Tue, 29 Mar 2022 05:03:58 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1327395wmz.4;
        Tue, 29 Mar 2022 05:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BTvjv8uLJtIXJ6YPBwIsbG9RDxooW4mmOR4hKBC2NT4=;
        b=kr/YiAwybjPY4wHV7Ml2OFpnmMdVffRQDxRy68x1N/vlE9kc8Dlml6+JUEm87M2+Pc
         PgK5ih6piQWE/GOIz7ZmHh+zwYQ1KoXicnuzEvcIy7KGwkWdKdvuTjATjar0iTZEhSrL
         FkgPHaHNcX0148WKvSETb6Vq4jrOQR0H+elZ8bnrhxAC78bcmlelrfvAUlnf1GlZO2EU
         tZcBwRR0/rs+k4Or462c2hf3r9xEbhMgq3AfILYCsnrG5xm0k7geINBjrrg0ubLXvyX5
         bTDE8p6yseYOZBA7+IXSuuDny9kwP0EylKWud69Ci2anHpDK69ZuhvUZwP43Ss0Gtnc/
         nj7Q==
X-Gm-Message-State: AOAM530YChHd9MQ9UNfGjopshb+Kvj7SGswbAzl5U1JK2kvXdAixjRIA
        MbtwyflvuXir+FJZ3sqd0xbSA4CAFrQ=
X-Google-Smtp-Source: ABdhPJyX3Tl1XJpYGg+rZVnndqf5mSPmDGix7jRPrXOljzS3ifIuIpN25VgkHrUBWQx2JkNL5vgeKA==
X-Received: by 2002:a05:600c:358d:b0:38c:6d54:bf40 with SMTP id p13-20020a05600c358d00b0038c6d54bf40mr6490032wmq.203.1648555437437;
        Tue, 29 Mar 2022 05:03:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b00203f2828075sm14684509wrr.19.2022.03.29.05.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 05:03:56 -0700 (PDT)
Date:   Tue, 29 Mar 2022 12:03:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Fix initialization of device
 object in vmbus_device_register()
Message-ID: <20220329120355.jyavc7oagz47qlcf@liuwe-devbox-debian-v2>
References: <20220315141053.3223-1-parri.andrea@gmail.com>
 <PH0PR21MB3025C408C7355EE552E81137D7109@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025C408C7355EE552E81137D7109@PH0PR21MB3025.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 15, 2022 at 04:46:34PM +0000, Michael Kelley (LINUX) wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, March 15, 2022 7:11 AM
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
