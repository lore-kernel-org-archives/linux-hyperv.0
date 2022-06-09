Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F46C433EF
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 Jun 2022 05:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiFIF1d (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiFIF1c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 01:27:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E703551E7C;
        Wed,  8 Jun 2022 22:27:31 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9104820BE676;
        Wed,  8 Jun 2022 22:27:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9104820BE676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654752451;
        bh=DF6REoJcbQxjyeIVLO2TSXKP3/EtC32cmh3TcxvbOV4=;
        h=From:To:Subject:Date:From;
        b=W9/bIBeYXrStNF0X3M0ozw7EK2zyTUcMy8XR/Ity05/aXZSoo09p6sq8M3NYmuaEf
         S5PsqyBnxs3Jn9BXheWm5BIborQqD0z3DfDY9ALR0IZ/E8N947jpUFSV5rhQSJDfKb
         v4QXu02ZgV1ItsdQmYU1dT3RgHTjhVfIrk5DHARQ=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH] Drivers: hv: vmbus: Add cpu read lock
Date:   Wed,  8 Jun 2022 22:27:26 -0700
Message-Id: <1654752446-20113-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add cpus_read_lock to prevent CPUs from going offline between query and
actual use of cpumask. cpumask_of_node is first queried, and based on it
used later, in case any CPU goes offline between these two events, it can
potentially cause an infinite loop of retries.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 85a2142..6a88b7e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -749,6 +749,9 @@ static void init_vp_index(struct vmbus_channel *channel)
 		return;
 	}
 
+	/* No CPUs should come up or down during this. */
+	cpus_read_lock();
+
 	for (i = 1; i <= ncpu + 1; i++) {
 		while (true) {
 			numa_node = next_numa_node_id++;
@@ -781,6 +784,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 			break;
 	}
 
+	cpus_read_unlock();
 	channel->target_cpu = target_cpu;
 
 	free_cpumask_var(available_mask);
-- 
1.8.3.1

