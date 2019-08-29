Return-Path: <SRS0=E+Qj=WZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8375C3A5A6
	for <linux-hyperv@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852F321726
	for <linux-hyperv@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103357;
	bh=7Duq5gO18jH/qa/5J91ieVvtbecfCbQ9i5hLM1vO4xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWp6PVlZb6QIpvWGomjVJNkjg/gKBemJGM0yI0+cc59iaDHLG/z18RieuIcUE30d0
	 iedg1WrFL7OFx47ixoDPOdl/3ex2FYkKg3ITJ7zhLgX7p1T+fwwRzQoyLJ27CnTdeC
	 qu/toKLXMPIDPjcKsDkbQd6qPIM/zPk+s4lKg3Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfH2SPF (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfH2SPE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1305B23407;
        Thu, 29 Aug 2019 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102503;
        bh=7Duq5gO18jH/qa/5J91ieVvtbecfCbQ9i5hLM1vO4xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzCht8j124mUZtLsUokwbfFUX7FfL3FGZHWsPaZcdh5tRb2XdUtFGMEgpjoocC+UD
         BmdzHfKksX8eWSxb+6miofxufBRC/6rw055YmvEdZZ6YpWJRBlwf2LsduY0Gj9PsIL
         ytpYi+75jhieUds4ZIKqRlo2jt2cRlKKgy51/DxQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 54/76] Tools: hv: kvp: eliminate 'may be used uninitialized' warning
Date:   Thu, 29 Aug 2019 14:12:49 -0400
Message-Id: <20190829181311.7562-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
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

