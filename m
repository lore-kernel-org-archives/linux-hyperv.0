Return-Path: <SRS0=e6q8=RE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB6C43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 15:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAEC20851
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551453382;
	bh=EJ3c6tt6x2nuZaNObsHkzExAE2n4/j4X87r0sBWU0Rw=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:List-ID:From;
	b=Vl5WrWaYkhYxNZeeY4Z6hVA+hjZqcZSya9gMcbWFL04BW1UazRQeZ2c3txk+IbyKc
	 zwqQCA3nk3kSuRkPqdQC1PMrzyzaUp/AXzbvz2RI+ZOSKpzMkl9ZF/2XuXlV5LlGzX
	 2aCOExDwBpnajYsKrw/zjXhKqeIPatH9bE2C9NP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfCAPQW (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:16:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCAPQW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Mar 2019 10:16:22 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486D92084F;
        Fri,  1 Mar 2019 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551453381;
        bh=EJ3c6tt6x2nuZaNObsHkzExAE2n4/j4X87r0sBWU0Rw=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=L54xS3hWw6/uFhnP756LdFBHqJBc66bvlNNn0tYYgM188yeqzWfdjhr5h3GXxDgMn
         L2heYT5zoa5D4I1d0cl2WsEB1Au131Mhp6JGnW2/zOgdEesanekM1MrCk9QdofxiEd
         W5otpMsIrKBJYzArpZjvlHh7pJcuu9TD9iKiV91w=
From:   Sasha Levin <sashal@kernel.org>
Date:   Fri, 01 Mar 2019 10:16:20 -0500
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for v5.1
Message-Id: <20190301151621.486D92084F@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to 396ae57ef1ef978d1d21cdb7586ba184a3f22453:

  Drivers: hv: vmbus: Expose counters for interrupts and full conditions (2019-02-14 20:56:10 -0500)

- ----------------------------------------------------------------
1. Exopsing counters for state changes of channel ring buffers; this is
useful to investigate performance issues. By Kimberly Brown.

2. Switching to the new generic UUID API, by Andy Shevchenko.

- ----------------------------------------------------------------
Andy Shevchenko (1):
      vmbus: Switch to use new generic UUID API

Kimberly Brown (1):
      Drivers: hv: vmbus: Expose counters for interrupts and full conditions

 Documentation/ABI/stable/sysfs-bus-vmbus |  33 +++++++
 drivers/hv/channel.c                     |   4 +-
 drivers/hv/channel_mgmt.c                |  18 ++--
 drivers/hv/hyperv_vmbus.h                |   4 +-
 drivers/hv/ring_buffer.c                 |  14 ++-
 drivers/hv/vmbus_drv.c                   |  84 +++++++++++-------
 include/linux/hyperv.h                   | 144 ++++++++++++++++++++-----------
 7 files changed, 207 insertions(+), 94 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAlx5TJwACgkQ3qZv95d3
LNxZfxAAjCHHRJ2HStiHhH5tOEABQsTNYwqXB8QNwL4cBC3L0DiwihynKVy/BQzg
nwQz3dZbar2h5Qj4Wkz+ygX57Sq2kRHBYNKGygcNzBYqF0IZvcmav3xUxMUrohjq
OAAt6mfzPo/rKIoT0vq4XbtZByR3g23VJpXoE/kAf9fPnLg4LXv8xu0MWpE58mvl
9pGmD0lO7K559FlYoWZNaOKbtjayOBDa9N2Mos/KM36x9kmeF2wp06RGBe2lyKuR
fzdTJhBoYkAqVeryTox9YpdvmlCvgwmudrCChrwnpx91WJb8HM5aT8tYAOfGssiR
MArxya2qFEzuzk5ToQS0HW9Id/+08MVhB7nACON3knrpH7i6RuPq9jrVqHZZeKH1
uyiItqNs3YjTrCPhrYqzRGS572kTR2hIgRvLylq7I9GXq/PPYomo34hTrGiUDK5d
t0rT6xCAzq+4DKzwEydy4l9TpEk8IXTeJ3aiIIJLr/NgZad+IGv4aP+R01xXlUld
gN5REI8mbQ7Pvov4EPGBuLuMeMTAyXPm4W5ZYlBTZxUaT1QTx2bypX41QSaX+J/7
PCTmutjP2eIYbzcJnxvfbTS6fFJTkzLyj7HrnRrf+YotH+/NwUSP7F/fzxp5ImuL
hlC4FuvWMjSjQ/OVenVL/eqMsfPbCcdqk+eKd8HfIKKToFd6seI=
=FLip
-----END PGP SIGNATURE-----
