Return-Path: <SRS0=ldGZ=SG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108DC4360F
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 04:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45FA20657
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 04:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfDDEhe (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:37:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:31092 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfDDEhe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 00:37:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 21:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,306,1549958400"; 
   d="scan'208";a="137454373"
Received: from ssarabia-mobl7.amr.corp.intel.com ([10.254.56.115])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2019 21:37:32 -0700
Date:   Wed, 3 Apr 2019 21:37:32 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Shiny Sebastian <shiny.sebastian@intel.com>
Subject: Re: linux-5.1-rc3: nvme hv_pci: request for interrupt failed
Message-ID: <20190404043732.GA18380@ssarabia-MOBL7.amr.corp.intel.com>
References: <FCE231C24CDC4243982F7030CC75E92F644C034C@FMSMSX102.amr.corp.intel.com>
 <PU1P153MB01691F731370D45D13C3615CBF500@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PU1P153MB01691F731370D45D13C3615CBF500@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 04, 2019 at 02:42:56AM +0000, Dexuan Cui wrote:
> > From: Solio Sarabia <solio.sarabia@intel.com>
> > Sent: Wednesday, April 3, 2019 5:38 PM
> > To: linux-hyperv@vger.kernel.org; linux-nvme@lists.infradead.org
> > 
> > When two nvme devices are discrete-assigned [1] to a linuxvm on
> > hyper-v rs5 host, it fails to initialize both.  It worked a couple of
> > times and after some reboots it failed. `dmesg` shows:
> > 
> > [   14.099310] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: Request for
> > interrupt failed: 0xc000009a
> > 
> > Thanks,
> > -Solio
> 
> 0xc000009a is STATUS_INSUFFICIENT_RESOURCES.
> 
> This is a known host resource leakage bug of the RS5 host. After the issue
> happens, rebooting the VM can not help, and rebooting the host may hang
> and we may have to power cycle the host by force.
> 
> The bug has been fixed in 19H1, which is in the Insider Preview phase, though:
> https://docs.microsoft.com/en-us/windows-insider/at-home/whats-new-wip-at-home-19h1
> https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewadvanced
> 
> The fix is being backported to RS5, but I don't have an ETA yet. 
> I'll try to get more info today and keep you updated.
> 
> Thanks,
> -- Dexuan

Great to know you're on top of things.  Guest hanged and had to reboot host;
in all cases guest was in consistent state upon reboot.

It's not a blocking issue at the moment, I can work on one device at a time.

Thanks,
-Solio
