Return-Path: <SRS0=8k6u=WQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5EBC3A5A2
	for <linux-hyperv@archiver.kernel.org>; Tue, 20 Aug 2019 13:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AA322DBF
	for <linux-hyperv@archiver.kernel.org>; Tue, 20 Aug 2019 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308792;
	bh=Z0GHDjmBVeYyAmt7stLeihyxCMotcwHjjtTcPlZKz+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jOLTxLbDXs3qfUNU1NEpnz73/b/2yd0+yspP0XaTgiqmX4JTOCRyG1JTkisRF+pau
	 YySWNVkvEF8h2CHJgSUsDbFfvPait6Xxl6zPS4Rk99utIn4arn/c+YT1So1K9R7PP8
	 LSWWW4W8dEvljZHnxzIDf8y+Hgr4D/3AuQvsGKuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfHTNmO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbfHTNmL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:11 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4004230F2;
        Tue, 20 Aug 2019 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308530;
        bh=Z0GHDjmBVeYyAmt7stLeihyxCMotcwHjjtTcPlZKz+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxwAx0AmvAUj/jbLPNnh2LUGEPjpstGKHv+ai7HsX7wHogvxZ+WLWI1TJybGwnQ1x
         G9Td75Ik+obEFA9zumjBW2485zowYawBU0rgHmwscr4SNr8pvx4st2s6QPWraJxvfk
         EZJbYBn8uwftx4OSabkEDQTXVxx/3J153MEoZ5z8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 44/44] tools: hv: fix KVP and VSS daemons exit code
Date:   Tue, 20 Aug 2019 09:40:28 -0400
Message-Id: <20190820134028.10829-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134028.10829-1-sashal@kernel.org>
References: <20190820134028.10829-1-sashal@kernel.org>
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
index d7e06fe0270ee..0ce50c319cfd6 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1386,6 +1386,8 @@ int main(int argc, char *argv[])
 			daemonize = 0;
 			break;
 		case 'h':
+			print_usage(argv);
+			exit(0);
 		default:
 			print_usage(argv);
 			exit(EXIT_FAILURE);
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index efe1e34dd91b4..8f813f5233d48 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -218,6 +218,8 @@ int main(int argc, char *argv[])
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

