Return-Path: <SRS0=XtRY=6I=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A935C54FD0
	for <linux-hyperv@archiver.kernel.org>; Fri, 24 Apr 2020 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D765820700
	for <linux-hyperv@archiver.kernel.org>; Fri, 24 Apr 2020 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731466;
	bh=5OSZRKzHocynd3cI10LxDkEipxQYslbPr+V2EF9QLlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZOhJVkRphppcg7UeK0AsFucCkDo9aSmuzXmFwafdiCTcA3nopuZWyLPviM7dlwsb
	 hyWRL56N8lhLjrWAYzX+HA48BPivyrubTTjQBeHvv69MGMlfGge0+fIDR+BJGobovL
	 EGPbfuHSFYygjEyrPnRYJ5mfj2tefxop5CXQsnpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgDXMa5 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgDXMX2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BB3215A4;
        Fri, 24 Apr 2020 12:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731008;
        bh=5OSZRKzHocynd3cI10LxDkEipxQYslbPr+V2EF9QLlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4wxwg/WtgUtHYJF2PEApiciK7SZK2OTl8CxHAQ79bQl0dEAIM0Ls0Ykxbyf3QmPg
         fVG+p6VH+rKVEivGk6F2Dmyi5k0vDuRzn0df+1/NrHVY2a034ntC3UzB79I+UJ/a3d
         Wo/lASnZHpmLs0hyBewwiPqcrrYoY9dV6V1YZNlQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>, Wei Liu <wei.liu@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/26] x86: hyperv: report value of misc_features
Date:   Fri, 24 Apr 2020 08:23:00 -0400
Message-Id: <20200424122323.10194-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122323.10194-1-sashal@kernel.org>
References: <20200424122323.10194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Olaf Hering <olaf@aepfle.de>

[ Upstream commit 97d9f1c43bedd400301d6f1eff54d46e8c636e47 ]

A few kernel features depend on ms_hyperv.misc_features, but unlike its
siblings ->features and ->hints, the value was never reported during boot.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Link: https://lore.kernel.org/r/20200407172739.31371-1-olaf@aepfle.de
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mshyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index fc8814faae62c..1c2f9baf84832 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -227,8 +227,8 @@ static void __init ms_hyperv_init_platform(void)
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
-	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
-		ms_hyperv.features, ms_hyperv.hints);
+	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
 
 	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
 	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
-- 
2.20.1

