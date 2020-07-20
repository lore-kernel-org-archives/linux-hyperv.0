Return-Path: <SRS0=q/xO=A7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76737C433E1
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Jul 2020 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4820A22C9D
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Jul 2020 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255181;
	bh=gVlnDGkUWvMCdg/rT+jwsxn+V/IwfZoJkQOFM6t2wbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0e97nSeBY6KM8nW9Awp0Hq2NUBWI3mu98CbcanuY599NKV/LGYkQfi8viR8hj+G/k
	 34WS6g2QLN3xzzSQuo1cVrlrAQQtYiMbpGhFGa++Zoxe64j30zhblMjcXlJi/fcpCV
	 S+XO/RKMgh56WzSLHawe5lWAXWBQ0FqE7fQxrTQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgGTO0V (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:26:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34891 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgGTO0U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jul 2020 10:26:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id z2so18106664wrp.2;
        Mon, 20 Jul 2020 07:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BNgYPqhxRYjSVXbbLgxK/P3mGTeHM4UuVOZDXwpk69E=;
        b=h8XeQ5h2pR2NlhQGgB8rdlGtiPG93XKUs0pmFoRmn+S855ilNrMwQzNAN+Ez2LwQId
         5miTZUr/XESwU4/r3/sqSEd0RWOCR14fThGrWXJBSTHpPK04/8USTdsK9Gj0vvtQcAC5
         up80bN1yOnrN/GKsTFGnyfaNHdZRTkThY/ZMjbBiACiB0cusnTsIxvUK3WTI95DskTrJ
         xkB02FiMwITNnDZOTd1SpwN4Wdd+ww/sQtLj6j6Ql7r7cdSVj0Phpoi1vTfHa/shjPzi
         rRIjztgoFuu8OUvhW3JxIq4UN3VdtT2RakBkyZTTCWoaYgqP4+VDxktquxOf3I7Ub3Ko
         TumA==
X-Gm-Message-State: AOAM530+BoW2Po/02cbZ2kcLkEpcEiJsU32Th6E0Vzv1JI5y1lQ2PGd1
        rScKO+vwG0R0g1A49iGI9adHuYfQ
X-Google-Smtp-Source: ABdhPJw6mW1qUYBRfjMsIXYJ4SbujclQOLMqVmDd8akFz2pItNEPdQYgsTHNVkaIm8YpNCKM6dEqdQ==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr22240315wrr.259.1595255178174;
        Mon, 20 Jul 2020 07:26:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 31sm15239867wrj.94.2020.07.20.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:26:17 -0700 (PDT)
Date:   Mon, 20 Jul 2020 14:26:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] hyperv: hyperv.h: drop a duplicated word
Message-ID: <20200720142616.usjwfqdvtquou2y6@liuwe-devbox-debian-v2>
References: <20200719002841.20369-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719002841.20369-1-rdunlap@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jul 18, 2020 at 05:28:41PM -0700, Randy Dunlap wrote:
> Drop the repeated word "the" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: linux-hyperv@vger.kernel.org

Applied to hyperv-next. Thanks.

Wei.
