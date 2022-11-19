Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9109C4332F
	for <linux-hyperv@archiver.kernel.org>; Sat, 19 Nov 2022 08:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiKSIN4 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 19 Nov 2022 03:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKSINg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 19 Nov 2022 03:13:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42F82205
        for <linux-hyperv@vger.kernel.org>; Sat, 19 Nov 2022 00:13:21 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDmX874b9zqSXg;
        Sat, 19 Nov 2022 16:09:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 16:13:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 16:13:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-hyperv@vger.kernel.org>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <mikelley@microsoft.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH v3 0/2] Drivers: hv: vmbus: fix two issues
Date:   Sat, 19 Nov 2022 16:11:33 +0800
Message-ID: <20221119081135.1564691-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset fixes a double free and a memory leak problems.

v2 -> v3:
  Update commit message and comment suggested by Michael.

v1 -> v2:
  Add a comment before vmbus_device_register().

Yang Yingliang (2):
  Drivers: hv: vmbus: fix double free in the error path of
    vmbus_add_channel_work()
  Drivers: hv: vmbus: fix possible memory leak in
    vmbus_device_register()

 drivers/hv/channel_mgmt.c | 5 ++++-
 drivers/hv/vmbus_drv.c    | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1

