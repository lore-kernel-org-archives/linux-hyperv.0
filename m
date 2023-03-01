Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C5AC7EE2D
	for <linux-hyperv@archiver.kernel.org>; Wed,  1 Mar 2023 10:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCAKIV (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 1 Mar 2023 05:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCAKIP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Mar 2023 05:08:15 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84573392A1;
        Wed,  1 Mar 2023 02:08:12 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id EC56520B9C3D;
        Wed,  1 Mar 2023 02:08:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC56520B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677665292;
        bh=s0N4tO5+UD5xxFDjIaj3GIYCqlHsDOv+m7EifXzglvA=;
        h=From:To:Subject:Date:From;
        b=l7ridiYLy4wQOPWq1XUgVhdcY4dXc7L5tpbtoJFUyS0jwZ5T3Gc59gawOGmxEcKL/
         G/Dx01FyNrNCfB8t3GgKY3oM7673izBVf7U1MFUV14Vd8F9pr1DV/6u/WRqj9voeuw
         h6lKD7Sh6xOwEfLJQJQEeOa3NEa/eUJG0NSkbStM=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 0/2] Hyper-V VTL support
Date:   Wed,  1 Mar 2023 02:08:06 -0800
Message-Id: <1677665288-6879-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series introduces support for Virtual Trust Level (VTL)
in Hyper-V systems. It provide a foundation for the implementation
of Hyper-V VSM support in the Linux kernel, providing a secure
platform for the development and deployment of applications.

Virtual Secure Mode (VSM) is a critical aspect of the security
infrastructure in Hyper-V systems. It provides a set of hypervisor
capabilities and enlightenments that enable the creation and
management of new security boundaries within operating system
software. The VSM achieves and maintains isolation through Virtual
Trust Levels, which are hierarchical, with higher levels being more
privileged than lower levels. Please refer to this link for further
information: https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm

This patch series adds the initialization of the x86 platform for VTL
systems. This also adds the VTL early bootup code for initializing
and bringing up secondary cpus to targeted VTL context. In VTL, AP
has to start directly in the 64-bit mode, bypassing the usual
16-bit -> 32-bit -> 64-bit mode transition sequence that occurs after
waking up an AP with SIPI whose vector points to the 16-bit AP
startup trampoline code.

Currently only VTL level supprted is '2'. This patch series is tested
extensively on VTL2 systems.

Saurabh Sengar (2):
  x86/init: Make get/set_rtc_noop() public
  x86/hyperv: VTL support for Hyper-V

 arch/x86/Kconfig                   |  23 +++
 arch/x86/hyperv/Makefile           |   1 +
 arch/x86/hyperv/hv_vtl.c           | 242 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  75 +++++++++
 arch/x86/include/asm/mshyperv.h    |  14 ++
 arch/x86/include/asm/x86_init.h    |   2 +
 arch/x86/kernel/cpu/mshyperv.c     |   6 +-
 arch/x86/kernel/x86_init.c         |   4 +-
 include/asm-generic/hyperv-tlfs.h  |   4 +
 9 files changed, 364 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_vtl.c

-- 
2.34.1

