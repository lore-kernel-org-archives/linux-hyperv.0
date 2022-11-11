Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA219C43217
	for <linux-hyperv@archiver.kernel.org>; Fri, 11 Nov 2022 01:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiKKBuS (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 10 Nov 2022 20:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKBuQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Nov 2022 20:50:16 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127221C116
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Nov 2022 17:50:15 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7hTy4gWkz15MWm;
        Fri, 11 Nov 2022 09:49:58 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 09:50:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 09:50:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-hyperv@vger.kernel.org>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <yangyingliang@huawei.com>
Subject: [PATCH v2 0/2] Drivers: hv: vmbus: fix two issues
Date:   Fri, 11 Nov 2022 09:48:45 +0800
Message-ID: <20221111014847.673576-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset fixes a double free and a memory leak problems.

v1 -> v2:
  Add a comment before vmbus_device_register().

Yang Yingliang (2):
  Drivers: hv: vmbus: fix double free in the error path of
    vmbus_add_channel_work()
  Drivers: hv: vmbus: fix possible memory leak in
    vmbus_device_register()

 drivers/hv/channel_mgmt.c | 4 +++-
 drivers/hv/vmbus_drv.c    | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1

