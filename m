Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A2C07E95
	for <linux-hyperv@archiver.kernel.org>; Wed, 14 Jul 2021 02:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC09561358
	for <linux-hyperv@archiver.kernel.org>; Wed, 14 Jul 2021 02:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbhGNCsR (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 13 Jul 2021 22:48:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51096 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhGNCsR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 22:48:17 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id E828920B6C50; Tue, 13 Jul 2021 19:45:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E828920B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1626230725;
        bh=cjWM8/+XYQ6WukpceI6IzfWW0AQXf/A7+2xC8ElfqUI=;
        h=From:To:Cc:Subject:Date:From;
        b=Tas/NVKrE2cMsUCG1LmwEGtd7h1smFlLznI+xmOQGYSJAYUyNaq0V7N5BgT54tfuj
         ssJ7f3OoRDAeXXWV+Prx/io7/n+QvauBKcEYtvCMEVwLKxgWdX0SwDSeryh1fC+vjC
         2KQPD/JgM2AT3yknYbA7zSuohnvbg4sSDr+mURx8=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 0/3] Introduce a driver to support host accelerated access to Microsoft Azure Blob
Date:   Tue, 13 Jul 2021 19:45:19 -0700
Message-Id: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Microsoft Azure Blob storage service exposes a REST API to applications
for data access. While it's flexible and works on most platforms, it's
not as efficient as native network stack.

This patchset implements a VSC that communicates with a VSP on the host
to execute blob storage access via native network stack on the host.

Reference:
https://azure.microsoft.com/en-us/services/storage/blobs/#overview



Long Li (3):
  Drivers: hv: vmbus: add support to ignore certain PCIE devices
  Drivers: hv: add Azure Blob driver
  Drivers: hv: Add to maintainer for Azure Blob driver

Changes:

v2:
Refactored the code in vmbus to scan devices
Reworked Azure Blob driver and moved user-mode interfaces to uapi

v3:
Changed licensing language
Patch format passed "checkpatch --strict"
debugfs and logging, module parameter cleanup
General code clean up
Fix device removal race conditions


 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 MAINTAINERS                                        |   1 +
 drivers/hv/Kconfig                                 |  10 +
 drivers/hv/Makefile                                |   1 +
 drivers/hv/azure_blob.c                            | 625 +++++++++++++++++++++
 drivers/hv/channel_mgmt.c                          |  55 +-
 include/linux/hyperv.h                             |   9 +
 include/uapi/misc/azure_blob.h                     |  34 ++
 8 files changed, 731 insertions(+), 6 deletions(-)
 create mode 100644 drivers/hv/azure_blob.c
 create mode 100644 include/uapi/misc/azure_blob.h

-- 
1.8.3.1

