Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F805C433EF
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Mar 2022 14:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiCBOy3 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiCBOy0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 09:54:26 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21722DD66;
        Wed,  2 Mar 2022 06:53:42 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id r10so3218046wrp.3;
        Wed, 02 Mar 2022 06:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ymAiqH7FrFQT4kALiSCU8D+YjYYsG1H9OJ7iD9GzacQ=;
        b=F5qx+QEZefC0cP/nJbw/3/C5Y0U2ef4IPOf1oD/kcf5cGpBIHd4oPR51HhZ7QzTMf4
         MV2yzcAyzWXT28DLYZgBcFARXnTlQwtrz0QLzZ1OHfZuHiEIBs1yrcjrgDCubRXbTq/u
         m/J8tY3z3ulgtnzS96cKnnM0iLZ4ZVla3QTsENa7fujWZpYloCyU4onoj1zjX3Oz60+e
         2uV1oQWedY2MAEf7Ft9ODgMV2FFpUohx6yG2QRZuB+useyFexXhCy4JSFUrGphWjRedl
         M3tVN7yu2a5hU5eT/Q2q7kCqPa2d4JZUfbw95FVPc4TNocdu/ewVMCTkHt8pSHy21jzU
         EdNQ==
X-Gm-Message-State: AOAM530zbT2WuC2FVUzkHr5w72cXjc2sgMM0VOOtKwrUAT4Rh3k3Y6JY
        W0+oLlTrqFDd5XQ1cchE7es=
X-Google-Smtp-Source: ABdhPJymZRwxT/Fzt+V604FQew9mY27jW0koz3Qh0DPBc5UJLdPz6bYdfKZKRPghGZXuuWQuqc+y6g==
X-Received: by 2002:a05:6000:156a:b0:1ed:ab7e:b69b with SMTP id 10-20020a056000156a00b001edab7eb69bmr23447319wrz.305.1646232821500;
        Wed, 02 Mar 2022 06:53:41 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00380fc02ff76sm6686255wms.15.2022.03.02.06.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:53:41 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:53:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 00/30] Driver for Hyper-v virtual compute device
Message-ID: <20220302145339.2s2bt252sxj3lsn6@liuwe-devbox-debian-v2>
References: <cover.1646161341.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646161341.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Iouri

I've gone through the whole series. A large portion of the series is
about graphics stuff which is out of my wheelhouse.

I have two general comments here.

There seems to be an excessive amount pr_debug / pr_err in code. Please
try to reduce their number a bit.

For memory allocation you always use vzalloc, however large or small the
allocation may be. Why not use kzalloc for smaller allocations?

Thanks,
Wei.
