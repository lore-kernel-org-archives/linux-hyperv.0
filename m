Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69BCC77B71
	for <linux-hyperv@archiver.kernel.org>; Tue, 18 Apr 2023 05:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDRFMs (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDRFMr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 01:12:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5D0C40EF;
        Mon, 17 Apr 2023 22:12:45 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 09D00217924B;
        Mon, 17 Apr 2023 22:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09D00217924B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681794765;
        bh=GIjj3qsXaZaCiMYQBRcfRNvvJ7xRppJubrlu61wysJk=;
        h=From:To:Subject:Date:From;
        b=q/cpnQcCa8RsprPmzeq81Q+2CWqtqQ9wULnSc0CL/377iDx1Y4gXCVzVkMJF9Ctyl
         ZanSZwvZ7adaJquhoeCc7d/5y/FeSV73Hp1tVJ21gb+sPjvGeW/R87gY8I1sVAvHpp
         gTq1o1v/n5DdaF6JdftGccb0V0oEbjwfKTZd5VCY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tiala@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 0/2] Fix for applied series [PATCH v5 0/5] Hyper-V VTL support
Date:   Mon, 17 Apr 2023 22:12:39 -0700
Message-Id: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[PATCH v5 0/5] Hyper-V VTL support is already applied, however
there are couple of kernel test bot warning reported. This patch
series on top of [PATCH v5 0/5] Hyper-V VTL support fixes these.
I expect them to be squash commit on respective patches.

The first patch is to fix 1/5 of the series:
https://lore.kernel.org/all/1681192532-15460-2-git-send-email-ssengar@linux.microsoft.com/
The second patch is to fix 3/5 of the series:
https://lore.kernel.org/all/1681192532-15460-4-git-send-email-ssengar@linux.microsoft.com/

Saurabh Sengar (2):
  x86/init: Remove static for get/set_rtc_noop()
  x86/hyperv: Allow hv_get_nmi_reason compilation irrespective of HYPERV
    config

 arch/x86/include/asm/mshyperv.h | 10 +++++-----
 arch/x86/kernel/x86_init.c      |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1

