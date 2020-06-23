Return-Path: <SRS0=4eFl=AE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287A3C433E0
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Jun 2020 06:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0475320774
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Jun 2020 06:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns9BOijg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgFWGsv (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgFWGsv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Jun 2020 02:48:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC1C061573
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 23:48:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so8714713plr.4
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oZZGNxksi984IFrtL4/ab5B2BOXyhHS93zVMSSqHlk8=;
        b=ns9BOijgSYyBCbz7Onv9gy3FniAP6VypfwVkCNaxItLmoPHFknqvdX4uXPkbA5NALN
         tY8IVENeq4JWwf2shAkWfwxRRIuKEaoMY1A/XUAD7VFdbC5GRito5rR/6F985UK7QR5F
         qvSRCnKJdH60UqagJd6YEEbjo6VmM/0pCQwH7K6uwAcr08tyhomVzHtOUtblW4zDf4KL
         xBb8NyW2FDdF9QWkGlxiWuM1Uqkz8DPRZ8bN5X5QcKu3VztQBz4LWrJswneuTETHUBvB
         fOoWcJuMupo46nA4F4bflMpGLcgYwQcw9Fv0y093cTauE742GG5VbJVwqLwEY07dwevz
         aDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oZZGNxksi984IFrtL4/ab5B2BOXyhHS93zVMSSqHlk8=;
        b=TGV+49QtL27QMHd5dudip4osspgpeeCn7Mai45xd7s0RRtW5xFtYUdMRFRqQkHcsH7
         YUI3lWdLhgn7qOspYrGYyw5eZWp8X22nGM0ko24WaTyoVwBQk0+Dr1fObKQMVwarBeib
         fqJ30sfZsqmc71MWLdr4Mh+o2SvTUtP2emv1376zPgbB73WO4B8guAWhP7UNgFSOluwl
         VrowBpV2/LPUsqNc5eE8WmrqX7LehmX4fBKAWTmen644Nh00MhnI7MsB56++2xrOcdD0
         8H96hI4RDcfMbZ05kbF/eZ2Nt4a1JSFiEwMJxcAhwbVz+I+FBKFbrATJL8AFRDfgSPP4
         kBCg==
X-Gm-Message-State: AOAM5308lPlMmJWfJckegkx9mApu4ihXzSj0L5UwNNth/ofvEwYd/B0e
        vqKHWW5FCM1i+OZLYQni/nc=
X-Google-Smtp-Source: ABdhPJyZtjnEOos/txCUFSLJJLxQYV1cCj3AAkfsfi1hhx+Pi4FZ0B3ahhWOCBDI9Wali2SKaH/rkQ==
X-Received: by 2002:a17:90b:ece:: with SMTP id gz14mr6809570pjb.93.1592894930961;
        Mon, 22 Jun 2020 23:48:50 -0700 (PDT)
Received: from arch ([2601:600:9500:4390::d3ee])
        by smtp.gmail.com with ESMTPSA id q65sm16048866pfc.155.2020.06.22.23.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 23:48:50 -0700 (PDT)
Message-ID: <aa7ab349ff502390edea4fd5721dbd64a0997216.camel@gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Wei Hu <weh@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Date:   Mon, 22 Jun 2020 23:48:49 -0700
In-Reply-To: <HK0P153MB03224C17D736FF164209F6DABF940@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
         <20200622110623.113546-2-drawat.floss@gmail.com>
         <HK0P153MB03224C17D736FF164209F6DABF940@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 2020-06-23 at 02:31 +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Deepak Rawat
> > Sent: Monday, June 22, 2020 4:06 AM
> > 
> > DRM driver for hyperv synthetic video device, based on hyperv_fb
> > framebuffer driver. Also added config option "DRM_HYPERV" to
> > enabled
> > this driver.
> 
> Hi Deepak,
> I had a quick look and overall the patch as v1 looks good to me. 

Thanks Dexuan for the review.

> 
> Some quick comments:
> 1. hyperv_vmbus_probe() assumes the existence of the PCI device,
> which
> is not true in a Hyper-V Generation-2 VM.

I guess that mean for Gen-2 VM need to rely on vmbus_allocate_mmio to
get the VRAM memory? From what I understand the pci interface anyway
maps to vmbus.

> 
> 2. It looks some other functionality in the hyperv_fb driver has not
> been
> implemented in this new driver either, e.g. the handling of the
> SYNTHVID_FEATURE_CHANGE msg.

I deliberately left this and things seems to work without this, maybe I
need to do more testing. I don't really understand the use-case
of SYNTHVID_FEATURE_CHANGE. I observed this message was received just
after vmbus connect and DRM is not yet initialized so no point updating
the situation. Even otherwise situation (mode, damage, etc.) is
triggered from user-space, not sure what to update. But will definitely
clarify on this.

> 
> Thanks,
> -- Dexuan

