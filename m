Return-Path: <SRS0=d0bn=SR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AFCC10F12
	for <linux-hyperv@archiver.kernel.org>; Mon, 15 Apr 2019 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184152077C
	for <linux-hyperv@archiver.kernel.org>; Mon, 15 Apr 2019 12:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDOM1j (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:27:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55540 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfDOM1j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Apr 2019 08:27:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so20398900wmf.5
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Apr 2019 05:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NFkaEcrMcC+TkQE3T7eDIT8t/gt8OW6BPDneAKgJs0E=;
        b=CXr5mhULlcPn6g9N9uljdMfF5wF0Q027EcyF47Zet5GxSdlSF1zilXEjLFB0L6BffI
         uoGr2ESQaOEn4SU7jMvGh1xfaRg9XdWS568lhDxi6Hpe7xyL+r524nnAMcQf2/jlUPsy
         n2EE/+rO7lY00HFnqNH0/EPEuYaJPz/wIz1PPwOBl6fjcP4oXUD529H5BxWif6KRnj9f
         m3MJPs6kq9SLtUL1anVwHCwxkUw4toOl1SAtsy+qHBB61ahui2G/ZyUzyQymgCR8kqaX
         wX6AO/vasqg0tEV5WWiGOXOvveL15krLk/QRb7l1SXfIXnShVWI8R2evaZMHibtQhK6Z
         /fEw==
X-Gm-Message-State: APjAAAWX19JoyDtbHfctgdCiNH/Q1e0VMGtsSixrxBt463LugR+kDC/b
        u8oKh3q1bYirP+kMH/eK0LWHYexO4Io=
X-Google-Smtp-Source: APXvYqy10B54Sg22aN8scwrJY70VAnPjGpILUNo7T8gOq70S1eMMaCDd8f8pJBO2stBk04EayG0PsQ==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr22390739wmh.123.1555331257642;
        Mon, 15 Apr 2019 05:27:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o1sm19020108wmh.47.2019.04.15.05.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 05:27:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Long Li <longli@microsoft.com>, Simon Xiao <sixiao@microsoft.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] x86/hyper-v: implement EOI assist
In-Reply-To: <20190403170309.4107-1-vkuznets@redhat.com>
References: <20190403170309.4107-1-vkuznets@redhat.com>
Date:   Mon, 15 Apr 2019 14:27:36 +0200
Message-ID: <87v9zfh2rr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Hyper-V TLFS suggests an optimization to avoid imminent VMExit on EOI:
> "The OS performs an EOI by atomically writing zero to the EOI Assist field
> of the virtual VP assist page and checking whether the "No EOI required"
> field was previously zero. If it was, the OS must write to the
> HV_X64_APIC_EOI MSR thereby triggering an intercept into the hypervisor."
>
> Implement the optimization in Linux.
>

Simon, Long,

did you get a chance to run some tests with this?

-- 
Vitaly
