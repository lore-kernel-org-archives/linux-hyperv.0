Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6EC433B4
	for <linux-hyperv@archiver.kernel.org>; Mon, 19 Apr 2021 19:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D18613AA
	for <linux-hyperv@archiver.kernel.org>; Mon, 19 Apr 2021 19:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbhDST06 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:26:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49814 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbhDST0x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Apr 2021 15:26:53 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 5810820B8001; Mon, 19 Apr 2021 12:26:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5810820B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1618860383;
        bh=LQd7evFy2Q75ScLwqsnshtRMQ+LhoxeoSp8bTmAS3gY=;
        h=From:To:Cc:Subject:Date:From;
        b=HNnA4Y67swB3aEt6Y3trSOmZo5XAfnoFS7WtqupFOfzp57FNMq8ikyHMwn/HHN2T/
         jcvaO34OY4PZXas41kRAFLIWZRAsZGTIr2h9YsYU0FkV3IrWgmxL2FX5PrnDzEo4nT
         ZHUWrfHOeQ3tlJTHXQZbjUzHWF6GgxQuvj4Kq8os=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH] PCI: hv: Fix a race condition when removing the device
Date:   Mon, 19 Apr 2021 12:20:54 -0700
Message-Id: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

On removing the device, any work item (hv_pci_devices_present() or
hv_pci_eject_device()) scheduled on workqueue hbus->wq may still be running
and race with hv_pci_remove().

This can happen because the host may send PCI_EJECT or PCI_BUS_RELATIONS(2)
and decide to rescind the channel immediately after that.

Fix this by flushing/stopping the workqueue of hbus before doing hbus remove.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 27a17a1e4a7c..116815404313 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3305,6 +3305,17 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	hbus = hv_get_drvdata(hdev);
 	if (hbus->state == hv_pcibus_installed) {
+		tasklet_disable(&hdev->channel->callback_event);
+		hbus->state = hv_pcibus_removing;
+		tasklet_enable(&hdev->channel->callback_event);
+
+		flush_workqueue(hbus->wq);
+		/*
+		 * At this point, no work is running or can be scheduled
+		 * on hbus-wq. We can't race with hv_pci_devices_present()
+		 * or hv_pci_eject_device(), it's safe to proceed.
+		 */
+
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
 		pci_stop_root_bus(hbus->pci_bus);
-- 
2.27.0

