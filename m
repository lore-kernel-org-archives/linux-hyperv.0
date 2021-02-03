Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E5C433DB
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Feb 2021 23:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83C564E49
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Feb 2021 23:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhBCX0e (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 3 Feb 2021 18:26:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:32276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233089AbhBCX0d (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 18:26:33 -0500
IronPort-SDR: txRAmVsnowjXhLgU8qwO7RBoEXxrh8ceeQ+TAvA9E5vb+BECWkzk4imf5jfSTtMClA4asI/fit
 0MNkeVsGwXlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242645457"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242645457"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 15:25:41 -0800
IronPort-SDR: fW7mgwdfpsdFzDrqk5qrVmoOWeS/KcOuXz00CTZ1ABq3ZKKAW2TAg0BuHC5AXrTRwJQEolUKwU
 +K/djcrZvXiQ==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356185661"
Received: from jbrandeb-mobl4.amr.corp.intel.com (HELO localhost) ([10.209.23.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 15:25:40 -0800
Date:   Wed, 3 Feb 2021 15:25:40 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: Reset the RSC count if NVSP_STAT_FAIL in
 netvsc_receive()
Message-ID: <20210203152540.00006fe8@intel.com>
In-Reply-To: <20210203113602.558916-1-parri.andrea@gmail.com>
References: <20210203113602.558916-1-parri.andrea@gmail.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri (Microsoft) wrote:

> Commit 44144185951a0f ("hv_netvsc: Add validation for untrusted Hyper-V
> values") added validation to rndis_filter_receive_data() (and
> rndis_filter_receive()) which introduced NVSP_STAT_FAIL-scenarios where
> the count is not updated/reset.  Fix this omission, and prevent similar
> scenarios from occurring in the future.
> 
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Fixes: 44144185951a0f ("hv_netvsc: Add validation for untrusted Hyper-V values")

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

