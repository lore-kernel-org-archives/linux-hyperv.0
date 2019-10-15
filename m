Return-Path: <SRS0=J8zZ=YI=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99505ECE588
	for <linux-hyperv@archiver.kernel.org>; Tue, 15 Oct 2019 14:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2D020873
	for <linux-hyperv@archiver.kernel.org>; Tue, 15 Oct 2019 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571149599;
	bh=5nnNdAf6WXH+v00l5Zeozfrj8EhYQJPb342rxJehYoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YVX2Nyzw/qu8Qwtu/FxVZFeBPMcMIKLgiNOtmc6grsxauSYL/4vAC0iVK1nWXf6IL
	 Y0dqFwLK83QHH7gorvWv+GzgRu/tLPPAQS0vjfdl3ctn+0nT1jgNzksJSsM1VOtn9i
	 b5V4V2imvS1UxQDwV9bFgEiBywwqdMx1DJpbLUDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfJOO0j (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732050AbfJOO0i (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 10:26:38 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B4F2168B;
        Tue, 15 Oct 2019 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571149598;
        bh=5nnNdAf6WXH+v00l5Zeozfrj8EhYQJPb342rxJehYoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w6kJzt5rCxA+Nlnc6hyIEBdHPLR9CJR6dh6IqwJ/WXAz5GRdYwAlefDCa5ef3V271
         ls2UZPhGQCoIqPOU4JcYp3QDCydF113tQQy89ztJklOt0nRytgyFF1PR5PBOLiY/+V
         OovPE2XgvnVLIRFhxz5FdEp8dIte+utA3TCTK5Y0=
Received: by mail-qt1-f173.google.com with SMTP id c21so30764130qtj.12;
        Tue, 15 Oct 2019 07:26:38 -0700 (PDT)
X-Gm-Message-State: APjAAAXHoNnpul/Mmefy6IG707ulo6YzPf1+U0KtjUZvOylO461wk7qi
        2xhzWn4LBz/sdbJYDfFFensVIO1SUNXiBRsnvIc=
X-Google-Smtp-Source: APXvYqxJeXGDIDIxntmOPHKIT4TVJ5vltdtc+3C0nxOmveI8caoOTLYE4Qxbn38fdBc1CblJtiI19abZIqkd7fxC1QQ=
X-Received: by 2002:ad4:4503:: with SMTP id k3mr1579944qvu.155.1571149597331;
 Tue, 15 Oct 2019 07:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191015114646.15354-1-parri.andrea@gmail.com>
In-Reply-To: <20191015114646.15354-1-parri.andrea@gmail.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Tue, 15 Oct 2019 15:26:26 +0100
X-Gmail-Original-Message-ID: <CAHd7Wqx8VzTdyo_e7NxYg83kgV27HSeKdpij3+s=VR6GZT197A@mail.gmail.com>
Message-ID: <CAHd7Wqx8VzTdyo_e7NxYg83kgV27HSeKdpij3+s=VR6GZT197A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Drivers: hv: vmbus: Miscellaneous improvements
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 15 Oct 2019 at 12:47, Andrea Parri <parri.andrea@gmail.com> wrote:
[...]
> [1] https://lkml.kernel.org/r/20191010154600.23875-1-parri.andrea@gmail.com
> [2] https://lkml.kernel.org/r/20191007163115.26197-1-parri.andrea@gmail.com
>
> Andrea Parri (3):
>   Drivers: hv: vmbus: Introduce table of VMBus protocol versions
>   Drivers: hv: vmbus: Enable VMBus protocol versions 4.1, 5.1 and 5.2
>   Drivers: hv: vmbus: Add module parameter to cap the VMBus version

For the whole series:

Reviewed-by: Wei Liu <wei.liu@kernel.org>
