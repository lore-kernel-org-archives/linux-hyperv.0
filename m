Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08845C77B7A
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 May 2023 05:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEWFgc (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 May 2023 01:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEWFgb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 01:36:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29EA5109;
        Mon, 22 May 2023 22:36:28 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 6DAC320FB999; Mon, 22 May 2023 22:36:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DAC320FB999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684820187;
        bh=DJlGDQvSIvFeKq1xoknA5bnOBGdDqtcUpdxg6zY8oeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGuQJ00Sro2QYqmdwLp1OTQZV1PYu4sHGKN62sbRAG4uaougSP/gPN09pf8ERbae8
         kXFkW58SKHAxHy+Rzw7zGlLuwY3gGlY8Tvb1Ta7h3KpkH9pQIwD/cLFpqFrDfDcZJ9
         d/8/BKS/1nJWEdgSr9Ze+HBgQl+/eslKVuVVDjb0=
Date:   Mon, 22 May 2023 22:36:27 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Ani Sinha <anisinha@redhat.com>
Cc:     Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
> > Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
> > 
> > > Olaf, is this a reviewed-by from you? :-)
> > 
> > Sorry, I did not review the new functionality, just tried to make sure there will be no regression for existing consumers.
> 
> Okay, this is fine, too. Thank you for looking into this.
> 
> 
> > 
> > Olaf
> 

Gentle reminder.
