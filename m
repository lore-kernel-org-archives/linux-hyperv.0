Return-Path: <SRS0=S9PY=Q6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B4C43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 03:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E0B206A3
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 03:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550891552;
	bh=jPyjdI4c2JGdw+xGkKjsfHs9erxbeLREgCywmtmX8es=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:List-ID:From;
	b=RO1jzGiu9j+OEi81ZA9G6I8WpY5c9w1mIr2qx0t311wUD+0HXjCCrDstNWJUyndqX
	 6yUmPLhxVBOkqxqq6c6SUcwM/GaeOsmbm3G8uof3UTQOrq/bAXOeAf0nWd8en2/5zu
	 thnt/0HUnJqyBlopE2EsKA/daUiVts4U4KoAcPvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBWDM1 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBWDM1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Feb 2019 22:12:27 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB912206A3;
        Sat, 23 Feb 2019 03:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550891547;
        bh=jPyjdI4c2JGdw+xGkKjsfHs9erxbeLREgCywmtmX8es=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=jdqme5M/KhO7bcEoSiApsqJjgwyotseTWIJ+jfMQ+/RqsPvfBM/0isQclxi6SppxL
         jt9GgxqLXaGReHTBVITIn+t/L6Vdd+VvieDcot8iyIkC2UzzfpjXE4gGwQkg5I0Ivo
         2mz/KY1jpEVfPje52gdAEoc526vdOw/LNmVUPpv0=
From:   Sasha Levin <sashal@kernel.org>
Date:   Fri, 22 Feb 2019 22:12:25 -0500
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL v3] Hyper-V commits for 5.0-rc
Message-Id: <20190223031226.AB912206A3@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to b2946cd86f3c1b5b1262c0ec06068110c2328fe6:

  MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS (2019-02-22 21:46:37 -0500)

- ----------------------------------------------------------------
Two fixes:

1. A fix for a race condition reading sysfs entries while a device is
being added, by Kimberly Brown.

2. Update the Hyper-V mailing list to a new one created on
vger.kernel.org, by Haiyang Zhang.

- ----------------------------------------------------------------
Haiyang Zhang (1):
      MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS

Kimberly Brown (2):
      Drivers: hv: vmbus: Change server monitor_pages index to 0
      Drivers: hv: vmbus: Return -EINVAL if monitor_allocated not set

 Documentation/ABI/stable/sysfs-bus-vmbus | 15 +++++++++---
 MAINTAINERS                              |  2 +-
 drivers/hv/vmbus_drv.c                   | 39 +++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 5 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAlxwucgACgkQ3qZv95d3
LNxkUg/9GmnREx3P9dvQECTeT/ynuL1kbA6lhbwolimrEjdBcEiPRRhD1UKOW5lb
lwBvp7Qj3+rnVBzI1+950VZoDCsmhCHS2DJ+Iy6OKPASYxCHXfSKfG0BWoid56ar
VTjG93gY9MmfUv/SkiAE/lYRdhGEM5GwojzPwKZ88+bV7gsgSHnFLeUgf/C5FXfG
PhvviKyV9S4MW5OwTcboNaHNSaS1Wf0EeOE3iHoXiE8Ylj3aJswrCgJWbIc9koQF
+KcugIIMnzTIhrKsxe9wmisAVAdaJo33suVOSgS50xnsVmIiJYtSgZ93/jH1GCXO
0rGuu1Qs/1dzzbZN5heQNm1KIlvpEaudG8pTQFssb3nmzyTPVFMqIb5pPungWpus
h4n/4DHg3pDgZXeTfygqogSkysWwfCoaiBymWfUYEbYJjg0zxgdrGbQvzowu5nOZ
mCBGxhrjJLDCMovkZKZggxutzIL+YTpJjPYmxZgNqnNdGHt9HR3syg142ZC3yXNT
ALZzQVXNk6cmCoTr9q/G3qbaS9Sv7BwMqC8YwGsqC5QbEP3WuKPBC7ifdXtA9nuo
fgAk2g3+vYlRK4kDUhl8EsTWMkH6HDNMe6Hzn4nyl01Qg36lyEwCoY1C32HFg8RR
Roi7nWz6IyQfJixYbkgVznhjHAuFZgIRS307a/n5vmwyYny1VZI=
=h1IS
-----END PGP SIGNATURE-----
