Return-Path: <SRS0=8k6u=WQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE225C3A589
	for <linux-hyperv@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4D422DA7
	for <linux-hyperv@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308624;
	bh=4/L2wx3XUlichasHvmRlE6mRfe8WWhpTpxf7i/61zhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkpwRIqz3E7mduY81hRsSDGTKZ/9GzVn1HD7cxzDb95MWrvzEKlY0zpm1iPpUeCZI
	 l1AFwg0CXJOINCCw6uHFBy9iefcoLbhjT2erollzMo83gTIekOsuyjgUbNCgYmJdJG
	 HiJnsaBv3MkeaEu83bUFRSLW5+QO0OtP3xkuMdbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfHTNn3 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbfHTNnZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 09:43:25 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35CAE22DA9;
        Tue, 20 Aug 2019 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308605;
        bh=4/L2wx3XUlichasHvmRlE6mRfe8WWhpTpxf7i/61zhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOnuL08J8JBavo1oOWtgvBaYq7XlrgMjGSUU0b0xoBxggCc3lUFIqhhyVBuyaACf5
         IapMY8XotmH9Ppb1UKvI1Qu+WjONEr0QgcxuvOtbAozidva8JN9IeW8biU6qFaGsUT
         3Mnlv41nzrXPd7E1UZtBhSuhZNMKvGGCDEyNb9kw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 7/7] tools: hv: fix KVP and VSS daemons exit code
Date:   Tue, 20 Aug 2019 09:43:15 -0400
Message-Id: <20190820134315.11720-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134315.11720-1-sashal@kernel.org>
References: <20190820134315.11720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Adrian Vladu <avladu@cloudbasesolutions.com>

[ Upstream commit b0995156071b0ff29a5902964a9dc8cfad6f81c0 ]

HyperV KVP and VSS daemons should exit with 0 when the '--help'
or '-h' flags are used.

Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/hv_kvp_daemon.c | 2 ++
 tools/hv/hv_vss_daemon.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1774800668168..fffc7c4184599 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1379,6 +1379,8 @@ int main(int argc, char *argv[])
 			daemonize = 0;
 			break;
 		case 'h':
+			print_usage(argv);
+			exit(0);
 		default:
 			print_usage(argv);
 			exit(EXIT_FAILURE);
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index e0829809c8970..bdc1891e0a9a3 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -164,6 +164,8 @@ int main(int argc, char *argv[])
 			daemonize = 0;
 			break;
 		case 'h':
+			print_usage(argv);
+			exit(0);
 		default:
 			print_usage(argv);
 			exit(EXIT_FAILURE);
-- 
2.20.1

