Return-Path: <SRS0=RYCE=4O=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD187C4BA20
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Feb 2020 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DB324650
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Feb 2020 18:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582740068;
	bh=DwK3NdDvJkgxZUvDxF6wCc37ejzk8NIQj+M67ZYkj8s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eTR+5tk7rdzZRCMDBo+pzKpyIgOWSWoR8BShNPTyDJglWdzpjJKEnFj8ZSBWKb390
	 wglcLBVbG7hmWqzA7PjgIE+uxVvgONnYjE1OeCrqB5SqTLI/ueYUJjVSZINLXMUSUb
	 z+QvkJooakRsISncSc/FVccSNkVTFrIswm7tpPnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBZSBI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:01:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44001 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgBZSBI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Feb 2020 13:01:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id c13so3482583wrq.10;
        Wed, 26 Feb 2020 10:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28tdOJyUAfuczO8QOQDz0B5rms6hK1wMorMHeVB9gGo=;
        b=hdh5YJWjtuLtlvKM1iRT6mLYLGKAExX2UNVgUx8vcPZUCmVhA2gw1qwfbAysI83dVm
         5g5tsNhni+s9WRp+R153i0veM6FRQQA8rYryQCj/N6ThTDE0WRirqMzadxwAnzrOdWEU
         u3l7Rft2+o9zOeEZ1Fbr/AVfqTGkxD+oKyVmrfT7WTvm4rmGQDOAQm0URW60ea2HoZLP
         cgwFhC97fKNYtYSR2m4RoxkRCKZr+lJK3GBcC6L/Mp0+ucPDNz2fcBNePgvtaLbSroal
         6HagN4H8Qvj1n71MWqh3z8hKfwdOK41ryDJqjAXXUywkLxL4fxrq2FNLuexB8F2B82ve
         RV9Q==
X-Gm-Message-State: APjAAAVIB2cm1smuREptYfACFXmoEpVmD6YDDD7KbzlyKrvZx0t1lA8i
        kFyfusCeyUviiW3wYYzj91G05utT
X-Google-Smtp-Source: APXvYqy29CQdUMxdxJY0XbJdkod6c4rVqRH9ImMWo7apsBtQdViP4ndSSI6puW74C5n1eidpxo1dnQ==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr6623076wrl.26.1582740065986;
        Wed, 26 Feb 2020 10:01:05 -0800 (PST)
Received: from localhost.localdomain (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id x6sm4197911wrr.6.2020.02.26.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 10:01:05 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] Hyper-V: add myself as a maintainer
Date:   Wed, 26 Feb 2020 18:01:02 +0000
Message-Id: <20200226180102.16976-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
Cc: linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>

Sasha's entry hasn't been dropped from the Hyper-V tree yet, but that's
easy to resolve.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f27f40d22bb..ed943f205215 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7739,6 +7739,7 @@ M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Stephen Hemminger <sthemmin@microsoft.com>
 M:	Sasha Levin <sashal@kernel.org>
+M:	Wei Liu <wei.liu@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
-- 
2.20.1

