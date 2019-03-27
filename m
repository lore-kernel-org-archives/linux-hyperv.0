Return-Path: <SRS0=AyMY=R6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5363C10F00
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79AB2075C
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715132;
	bh=PUA1LnDi4edmet7U8OlkBDruuRPientmusEN8OTIQis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ayBon6oA4YGV8rAPuzzax7ZOhZPrO/6qNkadfdlNFmol1FBVsyC2d+GioZF9QmTUq
	 eULuzezv7tYVwGKDFzFFiJHNmmCidvinAoH6QwNEifrX80BQiJFtDrne7EkXIfrxT2
	 itxMhypvO3Md260GvD7vzGr0CwjJ6YUWEFi9AE7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfC0SCq (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbfC0SCp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE2DD2087C;
        Wed, 27 Mar 2019 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709764;
        bh=PUA1LnDi4edmet7U8OlkBDruuRPientmusEN8OTIQis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnYiaGT6mdbM8o+bofFzx/WzFTxUYvIJjT0ygiJ9CqG5lKo65f3Jdt15u4g8rf5QY
         4rCer/u0rKHLqRoOhgtKEY0qAYM2GH9WkWLv1oVVEPnuket3DvnneJ1YbUkK4IDEAF
         kuw/v+ICJKQwbj2mZRRhtrBLTe3nhfLshHBPSNW0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>, devel@linuxdriverproject.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 028/262] x86/hyperv: Fix kernel panic when kexec on HyperV
Date:   Wed, 27 Mar 2019 13:58:03 -0400
Message-Id: <20190327180158.10245-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kairui Song <kasong@redhat.com>

[ Upstream commit 179fb36abb097976997f50733d5b122a29158cba ]

After commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments"),
kexec fails with a kernel panic:

kexec_core: Starting new kernel
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v3.0 03/02/2018
RIP: 0010:0xffffc9000001d000

Call Trace:
 ? __send_ipi_mask+0x1c6/0x2d0
 ? hv_send_ipi_mask_allbutself+0x6d/0xb0
 ? mp_save_irq+0x70/0x70
 ? __ioapic_read_entry+0x32/0x50
 ? ioapic_read_entry+0x39/0x50
 ? clear_IO_APIC_pin+0xb8/0x110
 ? native_stop_other_cpus+0x6e/0x170
 ? native_machine_shutdown+0x22/0x40
 ? kernel_kexec+0x136/0x156

That happens if hypercall based IPIs are used because the hypercall page is
reset very early upon kexec reboot, but kexec sends IPIs to stop CPUs,
which invokes the hypercall and dereferences the unusable page.

To fix his, reset hv_hypercall_pg to NULL before the page is reset to avoid
any misuse, IPI sending will fall back to the non hypercall based
method. This only happens on kexec / kdump so just setting the pointer to
NULL is good enough.

Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: devel@linuxdriverproject.org
Link: https://lkml.kernel.org/r/20190306111827.14131-1-kasong@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e2eeb8..d3f42b6bbdac 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -406,6 +406,13 @@ void hyperv_cleanup(void)
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
+	/*
+	 * Reset hypercall page reference before reset the page,
+	 * let hypercall operations fail safely rather than
+	 * panic the kernel for using invalid hypercall page
+	 */
+	hv_hypercall_pg = NULL;
+
 	/* Reset the hypercall page */
 	hypercall_msr.as_uint64 = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
-- 
2.19.1

