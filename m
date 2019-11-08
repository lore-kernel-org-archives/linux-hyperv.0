Return-Path: <SRS0=EDWN=ZA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A55BC5DF60
	for <linux-hyperv@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7382085B
	for <linux-hyperv@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214717;
	bh=3ES43x8ohLQmZDTu+juPnCitXAo/wPlqMTd883fgsjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ayOAkUrKB37KNflUygXJpFZXsBbkLvHzCZoTi9VMCCuM+1swS2FW3F0rjRD7AOgdE
	 BG1KV9oHcCVqUt/6YWXAm8EXw/8GMcinqLxikqF9/71FCraTeOytn9TLIpn9n0Xzy6
	 YzxBNOZKbxf9FTwxs/sBcg7jS2VASzSZOAadBerE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfKHLlt (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389629AbfKHLlt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E513222C4;
        Fri,  8 Nov 2019 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213308;
        bh=3ES43x8ohLQmZDTu+juPnCitXAo/wPlqMTd883fgsjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsAp50mYMpMlVQGLpRxyVOlBXQJMqOSY4E7LAAg5Uszu7zpGGx/AvvaJLbdw7/F8o
         Ovx3GbMdMuat4RMMCFll2xlKKNmeeo/X4PiqQc8SyAAz47Kbeoi5t8fWctn2IkVirb
         2UArmWNu6+439k87oRnRUDrUJicKUqwHwoZB0tG0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 156/205] Drivers: hv: vmbus: Fix synic per-cpu context initialization
Date:   Fri,  8 Nov 2019 06:37:03 -0500
Message-Id: <20191108113752.12502-156-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
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
index 8e923e70e5945..12bc9fa211117 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -189,6 +189,17 @@ static void hv_init_clockevent_device(struct clock_event_device *dev, int cpu)
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
 
 	hv_context.hv_numa_map = kcalloc(nr_node_ids, sizeof(struct cpumask),
 					 GFP_KERNEL);
@@ -198,10 +209,8 @@ int hv_synic_alloc(void)
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

