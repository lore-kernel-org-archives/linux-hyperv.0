Return-Path: <SRS0=E+Qj=WZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01639C3A59F
	for <linux-hyperv@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42F82166E
	for <linux-hyperv@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103053;
	bh=7Duq5gO18jH/qa/5J91ieVvtbecfCbQ9i5hLM1vO4xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2+21SZGhn/qz+aPdMY2jGVxOmZZfx0kb7sGkvLU7e2GUbD37W4kjJeOxvjYD4xAS
	 sr1OqI4WUTxBz/CD6SgE7KCFk+atmj2dww7rxm6bnX1oe++CkJtX5Z4f6tEfFkycBU
	 W1aFGoOmoWWFK6YBk+ef9H6gtiXiSwC92S0Q4FPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfH2SQi (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfH2SQh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5375923426;
        Thu, 29 Aug 2019 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102596;
        bh=7Duq5gO18jH/qa/5J91ieVvtbecfCbQ9i5hLM1vO4xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNqvBsXSGgncl99YH9lCwGwCVSyE/hZDdoEkk6xgzf3lJiDYJikjRyjiYtBmeWDUK
         BypAlOjsz0UskjQI9dHDsp1SBjsCnQ3MVvG5KtI2mtXnXptmZAuQ6OYR+I/CQVA6ax
         7XTJcqOCVkRq36LVRWwp6Ey/bS+4bshbJGxRKifs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 33/45] Tools: hv: kvp: eliminate 'may be used uninitialized' warning
Date:   Thu, 29 Aug 2019 14:15:33 -0400
Message-Id: <20190829181547.8280-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 89eb4d8d25722a0a0194cf7fa47ba602e32a6da7 ]

When building hv_kvp_daemon GCC-8.3 complains:

hv_kvp_daemon.c: In function ‘kvp_get_ip_info.constprop’:
hv_kvp_daemon.c:812:30: warning: ‘ip_buffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct hv_kvp_ipaddr_value *ip_buffer;

this seems to be a false positive: we only use ip_buffer when
op == KVP_OP_GET_IP_INFO and it is only unset when op == KVP_OP_ENUMERATE.

Silence the warning by initializing ip_buffer to NULL.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index d7e06fe0270ee..6d809abaf338a 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -809,7 +809,7 @@ kvp_get_ip_info(int family, char *if_name, int op,
 	int sn_offset = 0;
 	int error = 0;
 	char *buffer;
-	struct hv_kvp_ipaddr_value *ip_buffer;
+	struct hv_kvp_ipaddr_value *ip_buffer = NULL;
 	char cidr_mask[5]; /* /xyz */
 	int weight;
 	int i;
-- 
2.20.1

