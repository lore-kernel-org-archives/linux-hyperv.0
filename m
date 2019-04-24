Return-Path: <SRS0=BSe6=S2=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17361C282CE
	for <linux-hyperv@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8242218FC
	for <linux-hyperv@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117407;
	bh=vXZl1tBqgZCBTtlHpOam6CTDmIbgK4mmylHJMbB3+zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E4KxxKyyecbXzttrQUkFYxspT6ipgSbNMUeT2Cp0svkANFZBw+2iuR1j1arEf22mN
	 rQhVK9vkeaknG7E0fo8JaxEsYzA02v9jONf/ovVkN4tWF8oh81b87g84i8MLGofFim
	 WnngrdWPdyKaGRQX9PS+JKloZ4vlOWV0aXW2HvBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfDXOsH (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732369AbfDXOsE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Apr 2019 10:48:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18C0218FE;
        Wed, 24 Apr 2019 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117283;
        bh=vXZl1tBqgZCBTtlHpOam6CTDmIbgK4mmylHJMbB3+zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kB4QjUEcb77BIYSffN+cV3UORu/0mKUNs+XZOz3U66DYBzcrkOdrf8NjP3BgCu8+K
         AtjSxBHQc1EErGyt8j0S2T9I/xFmNbVyV8AoXLKOx2380O4OeraQIoN+sQNoXtDwzn
         8oFG94Q9x71G8HRMuoYv3jHxZPJ7/xujrSOIUFig=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/35] scsi: storvsc: Fix calculation of sub-channel count
Date:   Wed, 24 Apr 2019 10:46:57 -0400
Message-Id: <20190424144709.30215-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 382e06d11e075a40b4094b6ef809f8d4bcc7ab2a ]

When the number of sub-channels offered by Hyper-V is >= the number of CPUs
in the VM, calculate the correct number of sub-channels.  The current code
produces one too many.

This scenario arises only when the number of CPUs is artificially
restricted (for example, with maxcpus=<n> on the kernel boot line), because
Hyper-V normally offers a sub-channel count < number of CPUs.  While the
current code doesn't break, the extra sub-channel is unbalanced across the
CPUs (for example, a total of 5 channels on a VM with 4 CPUs).

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index beb585ddc07d..5adeb1e4b186 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -658,13 +658,22 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 {
 	struct storvsc_device *stor_device;
-	int num_cpus = num_online_cpus();
 	int num_sc;
 	struct storvsc_cmd_request *request;
 	struct vstor_packet *vstor_packet;
 	int ret, t;
 
-	num_sc = ((max_chns > num_cpus) ? num_cpus : max_chns);
+	/*
+	 * If the number of CPUs is artificially restricted, such as
+	 * with maxcpus=1 on the kernel boot line, Hyper-V could offer
+	 * sub-channels >= the number of CPUs. These sub-channels
+	 * should not be created. The primary channel is already created
+	 * and assigned to one CPU, so check against # CPUs - 1.
+	 */
+	num_sc = min((int)(num_online_cpus() - 1), max_chns);
+	if (!num_sc)
+		return;
+
 	stor_device = get_out_stor_device(device);
 	if (!stor_device)
 		return;
-- 
2.19.1

