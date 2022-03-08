Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B37C433F5
	for <linux-hyperv@archiver.kernel.org>; Tue,  8 Mar 2022 20:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349882AbiCHUr6 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCHUr6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Mar 2022 15:47:58 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E4A517D8;
        Tue,  8 Mar 2022 12:47:01 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id u10so28792298wra.9;
        Tue, 08 Mar 2022 12:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41ivgF5dWaFtnwPFxxJehv8WRBUjxjX2+saR8VYk4sM=;
        b=Z2APTcTWo7zBjrMjKpR3FZBpboZ0E36wfY4BL2vwWd+vUUO7YhEAQTeFs6FjDqPnPE
         OQqrRijPS+WzcHhtRxzpWzm1v4gwW99CQO0Z1yImQ5jUzeMvuNA5PUPheLV2tVVTXGWD
         rmAo6+RUKUotq7UlvEMwPv+lbQz1fajmwOW1keZU30OqjiTTLSNszaIDGj/Into1iwiO
         lWeV/OZji9womS3OZ1DZng3wsDb7RqJc0QaG2Tq8A+u93Q6rrtfWbuF6Atewt2aHVprT
         5tgmQtmceva27WUQmslyLDyo34pRQyeCQZE21lkiu8uqniLvQSP2M//DfLp1bDSJ2W5j
         mXRA==
X-Gm-Message-State: AOAM531xNBrllnjeJOjPoVYMlACISU0EetORGZG/6e1YJopptxJT+iic
        bnUuwF5uB5Pw1A4r92s36aM=
X-Google-Smtp-Source: ABdhPJy5Db+bMZMryQ/25RN8/rilJcHTHDD0H1hvfS1B6t6wEWTPFi3n/hF0OwTKYgTp3L/Bc6UjvA==
X-Received: by 2002:a5d:624d:0:b0:1e6:f18c:d264 with SMTP id m13-20020a5d624d000000b001e6f18cd264mr13837312wrv.546.1646772419685;
        Tue, 08 Mar 2022 12:46:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b0038995ede299sm3064083wmr.17.2022.03.08.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:46:59 -0800 (PST)
Date:   Tue, 8 Mar 2022 20:46:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH 1/1] x86/hyperv: Output host build info as normal Windows
 version number
Message-ID: <20220308204657.v2xdbtx6qsx6n44s@liuwe-devbox-debian-v2>
References: <1646767364-2234-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646767364-2234-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

(Cc Vitaly)

On Tue, Mar 08, 2022 at 11:22:44AM -0800, Michael Kelley wrote:
> Hyper-V provides host version number information that is output in
> text form by a Linux guest when it boots. For whatever reason, the
> formatting has historically been non-standard. Change it to output
> in normal Windows version format for better readability.
> 
> Similar code for ARM64 guests already outputs in normal Windows
> version format.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
