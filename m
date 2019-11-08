Return-Path: <SRS0=EDWN=ZA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7D0FA372C
	for <linux-hyperv@archiver.kernel.org>; Fri,  8 Nov 2019 11:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206B3207FA
	for <linux-hyperv@archiver.kernel.org>; Fri,  8 Nov 2019 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214260;
	bh=hmx5Rpbn7yfuwK7i95I3Vro9XyTui2okvZWKHzrJrQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HN7FUesG9wKRsAYKH+gMcj7czT1urfBeN2MSYZG5Lo+qw1D4qa0OpvH1oQwvbooys
	 YhdrJeru2dih20sXQJ/wvAYJjUNVLfBdBzuvmxO/NZKATh94myGmQroI7T7AAHFOfe
	 GyvVb4TKxNVMMDWVICdt+Vl3E2Hge+tAQ4iEj8wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390995AbfKHLpB (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390989AbfKHLpB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15FA222D1;
        Fri,  8 Nov 2019 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213500;
        bh=hmx5Rpbn7yfuwK7i95I3Vro9XyTui2okvZWKHzrJrQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTZty8DAdEBDHT4WIALcrttyNc01UkznJ5JCcVxjxljFI/5+SKAkxYCbpUh9DohVe
         QSCcijha0W+To5eteUmkbeF0e6kUY3NDkRfoyu61AFvfNxo9I5bHD5OeO0EROVq8ui
         EXhA5MYjScxJzKlKA9XcgTTpsXjW/ru6diWTv9Po=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 077/103] Drivers: hv: vmbus: Fix synic per-cpu context initialization
Date:   Fri,  8 Nov 2019 06:42:42 -0500
Message-Id: <20191108114310.14363-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit f25a7ece08bdb1f2b3c4bbeae942682fc3a99dde ]

If hv_synic_alloc() errors out, the state of the per-cpu context
for some CPUs is unknown since the zero'ing is done as each
CPU is iterated over.  In such case, hv_synic_cleanup() may try to
free memory based on uninitialized values.  Fix this by zero'ing
the per-cpu context for all CPUs before doing any memory
allocations that might fail.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/hv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fe041f22521da..23f312b4c6aa2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -148,6 +148,17 @@ static void hv_init_clockevent_device(struct clock_event_device *dev, int cpu)
 int hv_synic_alloc(void)
 {
 	int cpu;
+	struct hv_per_cpu_context *hv_cpu;
+
+	/*
+	 * First, zero all per-cpu memory areas so hv_synic_free() can
+	 * detect what memory has been allocated and cleanup properly
+	 * after any failures.
+	 */
+	for_each_present_cpu(cpu) {
+		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
+		memset(hv_cpu, 0, sizeof(*hv_cpu));
+	}
 
 	hv_context.hv_numa_map = kzalloc(sizeof(struct cpumask) * nr_node_ids,
 					 GFP_ATOMIC);
@@ -157,10 +168,8 @@ int hv_synic_alloc(void)
 	}
 
 	for_each_present_cpu(cpu) {
-		struct hv_per_cpu_context *hv_cpu
-			= per_cpu_ptr(hv_context.cpu_context, cpu);
+		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		memset(hv_cpu, 0, sizeof(*hv_cpu));
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-- 
2.20.1

