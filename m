Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5ECC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C182064A
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 18:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="ClF61nAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfC1Sm6 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:42:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42148 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfC1Sm5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 14:42:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so12022568pgh.9
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Mar 2019 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rv3xOx06ONzKcqZs5Vl4PEhFLYUziQzUKeg/lcUkaFg=;
        b=ClF61nAn6JlYF+ABRyLt4Q61GZXPIwMEVSXO/n9HVR/1x5MjQFAWKH+SS89+m4fiW5
         nXUjiJH2iwC+RrQevjfz3vA3HttX4aN1OY7eG52ewZbj6LHmCOPXfX73NX7d1x0rQN8k
         guStPH/EFj0xK8qJ0eW+b9ePGpUsQqK4S6I7hugLgEusn2iE07mO17MfZOnHgNtnLhQR
         THRzUUuG8dVMVMVpyUU4/Jx7bIgbH2INpgstJ3zZX4SN12B9vpcepxvNiKyKYsLXEE2Q
         OGfCfahytXVLBvod52rZBHSoT/a6ZAc9U8WVgPj78yKPBv43SquvTsLKia0T/Bsra2SC
         FEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rv3xOx06ONzKcqZs5Vl4PEhFLYUziQzUKeg/lcUkaFg=;
        b=iHaqDyfCaOtWTjvJgR2ebNtbag9wpzvsHRgFwHk8FVqkl93QMuFjKZhd0XPhYBrlBd
         UU+N8CbgG0jAoVO+bP3qi+0ZYmU9itPteQr2Uw+LORSBkxeYBiayzTaKpVKeTNkUimg/
         +9r6Ik+Uv0LYoxPYcDiVWFc3mW5v8clrQzNwAk/xLknx/vW/lD6t7NB80d+NH2CZeUXV
         g1e8KQP6ASZP9ZSgnMam2YP2c+jhqp3i1Ua8qvKtXvjDs8KwomyXIrH1NMmlHA3WGI8a
         xNHA1891amHKAl9xi6GW48aNuIDmcwSDVs8H3QYfPh0RBCDQt/kIb89+fUFsNuHVP6ae
         zqRA==
X-Gm-Message-State: APjAAAW5K68PujgzuIk0ozWWouL20EuLhQeap0u/sjgZZG/q/6UhUysE
        xwkxhQXTZjqlWLTUwM/+njWChQ==
X-Google-Smtp-Source: APXvYqy9+kORcXfx75V6DJD6VzSSY0PkjZX3Y6cM46xFjVgMWs4S25b3/kdVr76xHP5yQyTXwmJVZw==
X-Received: by 2002:a63:c00a:: with SMTP id h10mr41632938pgg.272.1553798576742;
        Thu, 28 Mar 2019 11:42:56 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i64sm37086434pfb.112.2019.03.28.11.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:42:56 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:42:52 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Message-ID: <20190328114252.141bbcd5@shemminger-XPS-13-9360>
In-Reply-To: <20190328043057.GA2258@ubu-Virtual-Machine>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
        <cover.1552592620.git.kimbrownkd@gmail.com>
        <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
        <20190314154533.17c8a362@shemminger-XPS-13-9360>
        <20190317014927.GA60356@ubu-Virtual-Machine>
        <20190320130619.07e49c97@shemminger-XPS-13-9360>
        <20190321034752.GA6828@ubu-Virtual-Machine>
        <DM5PR2101MB091851BC7C55093D388514D9D7420@DM5PR2101MB0918.namprd21.prod.outlook.com>
        <20190328043057.GA2258@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 28 Mar 2019 00:30:57 -0400
Kimberly Brown <kimbrownkd@gmail.com> wrote:

> On Thu, Mar 21, 2019 at 04:04:20PM +0000, Michael Kelley wrote:
> > From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Wednesday, March 20, 2019 8:48 PM  
> > > > > > Adding more locks will solve the problem but it seems like overkill.
> > > > > > Why not either use a reference count or an RCU style access for the
> > > > > > ring buffer?  
> > > > >
> > > > > I agree that a reference count or RCU could also solve this problem.
> > > > > Using mutex locks seemed like the most straightforward solution, but
> > > > > I'll certainly switch to a different approach if it's better!
> > > > >
> > > > > Are you concerned about the extra memory required for the mutex locks,
> > > > > read performance, or something else?  
> > > >
> > > > Locks in control path are ok, but my concern is performance of the
> > > > data path which puts packets in/out of rings. To keep reasonable performance,
> > > > no additional locking should be added in those paths.
> > > >
> > > > So if data path is using RCU, can/should the control operations also
> > > > use it?  
> > >   
> 
> 
> Hi Stephen,
> 
> Do you have any additional questions or suggestions for this race
> condition and the mutex locks? I think that your initial questions were
> addressed in the responses below. If there's anything else, please let
> me know!
> 
> Thanks,
> Kim
> 
> 
> > > The data path doesn't use RCU to protect the ring buffers.  
> > 
> > My $.02:  The mutex is obtained only in the sysfs path and the "delete
> > ringbuffers" path, neither of which is performance or concurrency sensitive. 
> > There's no change to any path that reads or writes data from/to the ring
> > buffers.  It seems like the mutex is the most straightforward solution to
> > preventing sysfs from accessing the ring buffer info while the memory is
> > being freed as part of "delete ringbuffers".
> > 
> > Michael  


I have no problems with the patch you did.
My discussion was more around the general issues with ringbuffers being detached
from the device. Not sure if it was even a good design choice but that is
something that is hard to fix now.

