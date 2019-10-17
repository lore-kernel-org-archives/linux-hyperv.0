Return-Path: <SRS0=i3Vl=YK=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5996ECE599
	for <linux-hyperv@archiver.kernel.org>; Thu, 17 Oct 2019 00:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7267820659
	for <linux-hyperv@archiver.kernel.org>; Thu, 17 Oct 2019 00:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox1kz4/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbfJQA5p (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:57:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41030 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJQA5p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Oct 2019 20:57:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so324327qkg.8;
        Wed, 16 Oct 2019 17:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTGJwtX3gaFJhfVoluMU8ZGAYiXGalHVfNd4SW8h3wE=;
        b=Ox1kz4/ubMjY0NqMhSvT3o7i8b1ksljfLJIysx6uJPIP2yRWgaBpyjuJip6NCAsxXW
         eI6pUQX1p0dzLjXIRU65G0ymCZmCJTb6sxNJVh83rgjxHF0V1RkyiDwzIObcotrTQcUL
         xN4ONDLFOtBvp/pmrwIFbmNIqvP/HmMLg80WW2NeJs06uZd63KAjYIT+GdGY0FLrbvC+
         RZ7nmMLb8gYfC9BgSaao3j9+UYa0VTVgTOL4HKZBoj8el2GQIi158v16B3BUNnue4hho
         Vf/gzHQTIOXqaPn4LIueompNv0lcl7ipGHJuftywmGONHrlUahNlP3VkRt8gQuXWBGP5
         xtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTGJwtX3gaFJhfVoluMU8ZGAYiXGalHVfNd4SW8h3wE=;
        b=kR+02EOAaxNGiBZATR9ys47LmbxHp1bX2q56EJ2z59rHh9mdfK+2tsQY3ZBog8hjdT
         LHMvjqPvmh6Wn0FATcQpfvCJprDWnInR0LO+vLcaZWINQITtbGdM2iEP73YiIX6mxSCD
         TJC8N3SbL/P1K5NjAl3+MbkqZMJJEdjIOJklcZ0G3k2fo9HtU904oTqfdN57mJmwEygv
         ylPzO8KR/qJdm6Khefw50UqDw81WCq0t6OCMqmV07nmnEX9vVVqJqBq82URFeJMs781V
         z4RLDFwi0G5VAmtDCbQcEDjsT34DbvRPArHsZY7rDCwnl/t6Nlv5rtkSKHIVfN2OH7an
         fWvQ==
X-Gm-Message-State: APjAAAXA9mRjl17sm015nB8a0c+6VeadQdJYDOUcgBWmWOIazqav0jM3
        2O7/k6CW1OTlxiYee1q6V/0=
X-Google-Smtp-Source: APXvYqw+Is0zFWxxVXLgNAjD5ji4cCtuKQRAnjkgkQc5G9iAjtGzrF4ecvJ23ZYSA/DEUWls6TVR5g==
X-Received: by 2002:a05:620a:98c:: with SMTP id x12mr820763qkx.323.1571273862463;
        Wed, 16 Oct 2019 17:57:42 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x12sm619050qtb.32.2019.10.16.17.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 17:57:41 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id E2DB022025;
        Wed, 16 Oct 2019 20:57:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 16 Oct 2019 20:57:40 -0400
X-ME-Sender: <xms:hLynXcZXTDVQW7tG4chaOnZhLkN2c_L2wmdkfpI7j_ISf5ekFmdMDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepuddtuddrke
    eirdeguddrvdduvdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunheppehfihigmhgvrdhnrghmvgesfhhigihmvgdrnhgrmhgvnecuvehluhhs
    thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:hLynXfLGr8-_sWO0fjTZIsG1Fw8PfzGIZ5TFLXYIH83mAw6a-JJdmw>
    <xmx:hLynXaCcDgi12eMZ0Bx8PCeWvTGfGvx-5qJ9Pofcwm9UDca4-HdncA>
    <xmx:hLynXUrxAb3L1i1zdg-K4vtQ-HuVjafjUS_HbDquhQ4zggNxagluvA>
    <xmx:hLynXZD2Da2FGrkW1PNxbT17aIUbukOR2z_EkwOhnp5AZMPPhJZm_A>
Received: from localhost (unknown [101.86.41.212])
        by mail.messagingengine.com (Postfix) with ESMTPA id B150ED6005B;
        Wed, 16 Oct 2019 20:57:39 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] drivers: iommu: hyperv: Make HYPERV_IOMMU only available on x86
Date:   Thu, 17 Oct 2019 08:57:03 +0800
Message-Id: <20191017005711.2013647-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently hyperv-iommu is implemented in a x86 specific way, for
example, apic is used. So make the HYPERV_IOMMU Kconfig depend on X86
as a preparation for enabling HyperV on architecture other than x86.

Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---

Without this patch, I could observe compile error:

| drivers/iommu/hyperv-iommu.c:17:10: fatal error: asm/apic.h: No such
| file or directory
|   17 | #include <asm/apic.h>
|      |          ^~~~~~~~~~~~

, after apply Michael's ARM64 on HyperV enablement patchset.

 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..f1086eaed41c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -467,7 +467,7 @@ config QCOM_IOMMU
 
 config HYPERV_IOMMU
 	bool "Hyper-V x2APIC IRQ Handling"
-	depends on HYPERV
+	depends on HYPERV && X86
 	select IOMMU_API
 	default HYPERV
 	help
-- 
2.23.0

