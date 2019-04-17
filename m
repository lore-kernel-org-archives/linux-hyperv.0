Return-Path: <SRS0=V+x0=ST=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF148C10F14
	for <linux-hyperv@archiver.kernel.org>; Wed, 17 Apr 2019 01:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0F12177B
	for <linux-hyperv@archiver.kernel.org>; Wed, 17 Apr 2019 01:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555464893;
	bh=cPe4HWkDTgp8T0n2SgOPalmyScgMdEd0XIwkCDJ2/VY=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:List-ID:From;
	b=Yrc163EYuhGaVFlJrSGjcRMEayl45xb1Tjb3sWoDGAJ+yQAVAvymPudxMlRQhYYLU
	 u6ymIzKi9tG2YjrIRBSULpl3iBEV/l9swx5CfE1hMY8j1SGTniZl/u7SUDSAaEJGTG
	 KJGfEGrnL9zEFcUg0borXRDaPKmvHICbzGi108Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfDQBex (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfDQBex (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Apr 2019 21:34:53 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438FA20821;
        Wed, 17 Apr 2019 01:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555464892;
        bh=cPe4HWkDTgp8T0n2SgOPalmyScgMdEd0XIwkCDJ2/VY=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=s3isqs/MImsW7aUiusFOFZUrek0YnR6buhALLsDf95KRZ9FHGtF+eNbNW8C/vQpQ9
         AZuMiSIsM8//wVpSCZeia7kOEvU3aVs50SoaNzmkwT6CI3Qqxrc3AoW4AhdKzSc/jN
         +2Vpg9I/FF/HO9kv4zQcbaWAFc0cBAdqLXUnncIM=
From:   Sasha Levin <sashal@kernel.org>
Date:   Tue, 16 Apr 2019 21:34:51 -0400
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for 5.1
Message-Id: <20190417013452.438FA20821@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to a0033bd1eae4650b69be07c17cb87393da584563:

  Drivers: hv: vmbus: Remove the undesired put_cpu_ptr() in hv_synic_cleanup() (2019-04-13 09:36:35 -0400)

- ----------------------------------------------------------------
Three fixes:

 1. Fix for a race condition in the hyper-v ringbuffer code by Kimberly
Brown.
 2. Fix to show monitor data only when monitor pages are actually
allocated, also by Kimberly Brown.
 3. Fix cpu reference counting in the vmbus code by Dexuan Cui.

- ----------------------------------------------------------------
Dexuan Cui (1):
      Drivers: hv: vmbus: Remove the undesired put_cpu_ptr() in hv_synic_cleanup()

Kimberly Brown (4):
      Drivers: hv: vmbus: Expose monitor data only when monitor pages are used
      Drivers: hv: vmbus: Refactor chan->state if statement
      Drivers: hv: vmbus: Set ring_info field to 0 and remove memset
      Drivers: hv: vmbus: Fix race condition with new ring_buffer_info mutex

 Documentation/ABI/stable/sysfs-bus-vmbus |  12 ++-
 drivers/hv/channel_mgmt.c                |   3 +
 drivers/hv/hv.c                          |   1 -
 drivers/hv/hyperv_vmbus.h                |   3 +
 drivers/hv/ring_buffer.c                 |  22 +++-
 drivers/hv/vmbus_drv.c                   | 166 +++++++++++++++++++++++++------
 include/linux/hyperv.h                   |   7 +-
 7 files changed, 175 insertions(+), 39 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAly2gjwACgkQ3qZv95d3
LNwtLg//UPVpBuilk7pzyumaEYNNeVcq781h/cghAOxiTDPlCI/qAkshdPj9ePAI
UWmBl/lUTXWcN26Xb2NLF9VulXfTFCiphQdgYMQEVslnOvbYLMLkIOOkrkovT6ie
OE5x1j+2S2uF+nwZvLq+FYuS5OiCBx8De1HaCUJQjh1dnrcdjCBTk+idE12tdqa6
pXO32CBKLUK0AEo9yHfeyg9RRsXV89u0wDEOhS160sqx5B6o1TevGOxkPDDQKrKG
mo80aY17MV3ljcODt4pqCNz1rITV6wwZ2oTz1sEv+5nMsqGZ9dcpXYQiQp0huaVl
/j4v/xY9gUDhGYvixoT8Mn87zc7y0y6o+VMcoM7YO7NJkbDA3XN6UaGzXdon061U
w25JBpWdHmot+5PxNafp708V7OBcWpbCoEFhSKvzKcYZlnGo4OA0om966v1WsW2K
ssXEPS4qdwtRM1dyK9c/Lt9HgaZWXzpIzj2bMxVjYPMeAmOd6W0QlfnuZuxYHmRd
aoZswMwFiC2lyOoHtbo50EzeKLwxVju+ToHFTf2jRXnjsLvDXkE6FmX9DSYnwvnE
Vs5qCvW8ynOPhTWAn6eKl0Ysb12+m36w+MEol7JTUlw4XPw7ahHsuxsN4TJQnshD
mZYG2Mrc38B/YOytT0asT5Z9U5ob9U7446I2Rn3XbdjVs9EEBAA=
=gXIY
-----END PGP SIGNATURE-----
