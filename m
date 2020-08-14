Return-Path: <SRS0=5ztu=BY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04262C433E1
	for <linux-hyperv@archiver.kernel.org>; Fri, 14 Aug 2020 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D413522B43
	for <linux-hyperv@archiver.kernel.org>; Fri, 14 Aug 2020 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597408748;
	bh=GMHi1FpPrR62ulxDK6MxZ6BFhwvKlixc4HoFmHzpW3k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SCpgq8a7JlJFiCqyjLuqbBJ4N5Eah2d65pNbyuDcJVV+/lk/OI64grebn5pBVSdzN
	 6v6ea+dg4LopbqQS2idxcZZlBoxIs3Zy7eRgg+yKGOXpl5WAGEmZCBm8bwcp5xmJHT
	 MR6brEUfZjYM+sOz+ykbVr8H1V2T8CoQsFeWRdjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHNMjH (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNMjH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 08:39:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B26520866;
        Fri, 14 Aug 2020 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408746;
        bh=GMHi1FpPrR62ulxDK6MxZ6BFhwvKlixc4HoFmHzpW3k=;
        h=From:To:Cc:Subject:Date:From;
        b=lKf44wUf2Kc3v1KN9FqczPLbiNSEB3nE1ZqTbD+tfrxWnlmj+xpAZ8cSyY7SZoVM4
         TAR8k//u7btxlzTAFfzmg6VtHFmHVA2UXlQqF9s677CPaz6UzyCwJYvc1NLgZ2JAk1
         HpCTi2zCWQIRmZFDJ1c19CfkmFBZkopM0+xjDTe4=
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     gregkh@linuxfoundation.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 0/4] drivers: hv: Microsoft Virtual GPU Driver
Date:   Fri, 14 Aug 2020 08:38:52 -0400
Message-Id: <20200814123856.3880009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is a follow-up on the RFC sent a few months back[1].

Changes since the RFC:

 - Move to drivers/hv/
 - Address comments from Greg KH
   - Misc device initialization
   - Remove typedefs/variable defines
   - Use the kernel's ioctl declarations
 - Clean up random code bugs.


[1] https://lore.kernel.org/lkml/20200519163234.226513-1-sashal@kernel.org/


Sasha Levin (4):
  drivers: hv: dxgkrnl: core code
  drivers: hv: dxgkrnl: hook up dxgkrnl
  drivers: hv: vmbus: hook up dxgkrnl
  drivers: hv: dxgkrnl: create a MAINTAINERS entry

 MAINTAINERS                     |    7 +
 drivers/hv/Kconfig              |    2 +
 drivers/hv/Makefile             |    1 +
 drivers/hv/dxgkrnl/Kconfig      |   10 +
 drivers/hv/dxgkrnl/Makefile     |   12 +
 drivers/hv/dxgkrnl/d3dkmthk.h   | 1636 ++++++++++
 drivers/hv/dxgkrnl/dxgadapter.c | 1406 ++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  927 ++++++
 drivers/hv/dxgkrnl/dxgmodule.c  |  656 ++++
 drivers/hv/dxgkrnl/dxgprocess.c |  357 ++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 3084 ++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  873 +++++
 drivers/hv/dxgkrnl/hmgr.c       |  604 ++++
 drivers/hv/dxgkrnl/hmgr.h       |  112 +
 drivers/hv/dxgkrnl/ioctl.c      | 5413 +++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.c       |  279 ++
 drivers/hv/dxgkrnl/misc.h       |  309 ++
 include/linux/hyperv.h          |   16 +
 18 files changed, 15704 insertions(+)
 create mode 100644 drivers/hv/dxgkrnl/Kconfig
 create mode 100644 drivers/hv/dxgkrnl/Makefile
 create mode 100644 drivers/hv/dxgkrnl/d3dkmthk.h
 create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
 create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
 create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
 create mode 100644 drivers/hv/dxgkrnl/dxgprocess.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
 create mode 100644 drivers/hv/dxgkrnl/hmgr.c
 create mode 100644 drivers/hv/dxgkrnl/hmgr.h
 create mode 100644 drivers/hv/dxgkrnl/ioctl.c
 create mode 100644 drivers/hv/dxgkrnl/misc.c
 create mode 100644 drivers/hv/dxgkrnl/misc.h

-- 
2.25.1

