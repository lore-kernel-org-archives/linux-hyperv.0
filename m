Return-Path: <SRS0=JXHx=B6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBBEC433DF
	for <linux-hyperv@archiver.kernel.org>; Thu, 20 Aug 2020 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B132075E
	for <linux-hyperv@archiver.kernel.org>; Thu, 20 Aug 2020 21:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C+4fabQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHTVsT (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:48:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39228 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHTVsS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 17:48:18 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A73920B4908;
        Thu, 20 Aug 2020 14:48:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A73920B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597960098;
        bh=1poYvZ5PwBVampeoy9/r+Ck8lpluSiK2TwYPa0QxQy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+4fabQdO2f9Gi1nCABCKRSBGNcAGeU4oo14Py/MMLDNnBNIKqj3OFQZ61+9Wg5i2
         gaQuzc/mbeCMLWFy8RxFyWmGXC8ajz2oAuL7bJ2FhCfI4G+dRQXF9E0JNv+0Doo8rU
         8Wq9iYUqrHsbTA1Y7Gbp/8JvM4SxZSnghiwAV3lI=
Date:   Thu, 20 Aug 2020 21:48:17 +0000
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv_utils: drain the timesync packets on onchannelcallback
Message-ID: <20200820214817.ndjmzanwmdm5qfvf@viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net>
References: <20200819174740.47291-1-viremana@linux.microsoft.com>
 <MW2PR2101MB1052254C5ED7C587E548DB3AD75A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052254C5ED7C587E548DB3AD75A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20171215
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Hi Michael,

> > +			pr_warn("TimeSync IC pkt recv failed (Err: %d)\n",
> > +				ret);
> 
> Let's use pr_warn_once().
> 
> If there's a packet at the head of the ring buffer that specifies a bogus length,
> we could take the error path.  But the bad packet stays at the head of the ring buffer,
> so if we end up back here again, we'll spit out the same error message.  We
> actually should not end up here again because Hyper-V shouldn't interrupt
> when adding a packet to a non-empty ring buffer, but who knows what might
> happen.
> 
Valid point, will fix this in the next iteration.

Thanks,
Vineeth
