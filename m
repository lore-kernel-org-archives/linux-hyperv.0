Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E12C4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AD5206B7
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOZ322Ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfDEBLj (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:11:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45882 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfDEBLj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 21:11:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so2278823pfi.12;
        Thu, 04 Apr 2019 18:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+3zXcHYjgYEH0DqJApSQSnOjaZDldSwrpSHlOoc3kdY=;
        b=aOZ322Edgs2XpFufMTJjBZ7vJR9FjPppXKJpp2TQaPmZDkFwMKZT1hS0cwc0Nz7lMm
         J/v/92Y787rAWvIhpJaDeuPK+6yELa7ZMe+b52YdD8/9RuesZd3E0ZfJsAbQjoRq5Vzt
         rrOPjAcqhon8mt1kHxeZAI9wneLFmDrwRyW0KPUv0dU6evANEpKpZoTZC49m+XTbk+YW
         xuWxxNpt25UvOglk2BiUdCt7HnI/51eBjk8hBihKtiknd9qF0PPjZW3l9HsARSnly+SP
         ORPV30qNaq9pILGGR+ZileOKRxC9J54CQW2Tz1J/TjVzOQhiRuY9ElBEf9mZUb/apimT
         +NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+3zXcHYjgYEH0DqJApSQSnOjaZDldSwrpSHlOoc3kdY=;
        b=H55pA9Udf4+4nLRGuC5ocLIdfOWRzr6v/f/Z+S4Wjcb/4kqwKFalEondzQtQiGMKIw
         NLCFQxmASZxFJFjJ/p6/u5w+2U+T3RBzNGZg/nIHD+Rq+xyJ2UJV9w51IT3odkd1lRIJ
         8fkmJKZmP5jZaVxr7MvDC+4TeYFqzGn/QDGQCzOwUD5qE1Fnnk9ng4Mnz/E6V21nV8Qn
         82QuTlcLmy7/nU5GDs1tPwxEN3sw5gr47pa8Skq+6nNvvGcFKIDHwGztvwwo9QyrdXzn
         UmMQLm3tMZdVPmEAnlGjVY1qJ+Ez5V+xqMImr8JTtLfBqfSoQc4HqErf2AuOxGbjhuUZ
         VRQA==
X-Gm-Message-State: APjAAAXxI+jTEK1kq3lQjcvyOuZtaO/3U/rkwpRe93eooSJZ6vEdn3AI
        pj5TCY/OTJfI/cTjd/aRZ7Zt9m0vd5eqOw==
X-Google-Smtp-Source: APXvYqw+pXflK11fSVuKmYpvLblWud/XR9KiBz7sisBnoa4gHFW/wxXGbZp+HPLvkzY+HKgE7hBMYQ==
X-Received: by 2002:a65:4844:: with SMTP id i4mr9081495pgs.347.1554426698316;
        Thu, 04 Apr 2019 18:11:38 -0700 (PDT)
Received: from maya190131 ([52.250.109.216])
        by smtp.gmail.com with ESMTPSA id q87sm31553429pfa.133.2019.04.04.18.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 18:11:37 -0700 (PDT)
Date:   Fri, 5 Apr 2019 01:11:36 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] hv: Remove dependencies on guest page size
Message-ID: <cover.1554426039.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The Linux guest page size and hypervisor page size concepts are
different, even though they happen to be the same value on x86. Hyper-V
code mixes up the two, so this patchset begins to address that by
creating and using a set of Hyper-V specific page definitions.

A major benefit of those new definitions is that they support non-x86
architectures, such as ARM64, that use different page sizes. On ARM64,
the guest page size may not be 4096, and Hyper-V always runs with a page
size of 4096.

In this patchset, the first two patches lay the foundation for the
others, creating definitions and preparing for memory allocations of
Hyper-V pages. Subsequent patches apply the definitions where the guest
VM and Hyper-V communicate, and where the code intends to use the
Hyper-V page size. The last two patches set the ring buffer size to a
fixed value, removing the dependencies on the guest page size.

This is the initial set of changes to the Hyper-V code, and future
patches will make additional changes using the same foundation, for
example, replace __vmalloc() and related functions when Hyper-V pages
are intended.

Maya Nakamura (6):
  x86: hv: hyperv-tlfs.h: Create and use Hyper-V page definitions
  x86: hv: hv_init.c: Replace alloc_page() with kmem_cache_alloc()
  hv: vmbus: Replace page definition with Hyper-V specific one
  x86: hv: mmu.c: Replace page definitions with Hyper-V specific ones
  HID: hv: Remove dependencies on PAGE_SIZE for ring buffer
  Input: hv: Remove dependencies on PAGE_SIZE for ring buffer

 arch/x86/hyperv/hv_init.c             | 38 +++++++++++++++++++--------
 arch/x86/hyperv/mmu.c                 | 15 ++++++-----
 arch/x86/include/asm/hyperv-tlfs.h    | 12 ++++++++-
 drivers/hid/hid-hyperv.c              |  4 +--
 drivers/hv/hyperv_vmbus.h             |  8 +++---
 drivers/input/serio/hyperv-keyboard.c |  4 +--
 6 files changed, 54 insertions(+), 27 deletions(-)

-- 
2.17.1

