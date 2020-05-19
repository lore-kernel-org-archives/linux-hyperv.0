Return-Path: <SRS0=lCxe=7B=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E5C433E0
	for <linux-hyperv@archiver.kernel.org>; Tue, 19 May 2020 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700DC207D3
	for <linux-hyperv@archiver.kernel.org>; Tue, 19 May 2020 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905994;
	bh=KqBKhr6to6bxExK2bg4wDA0x7D/o81eMVQb7vBHPcOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t8ivp49lZzt3PQEmaoEsa0VBtuAtu99VcvJe+Wv+BVP5I3ShWLBYnT1HQyDjE6im1
	 ae7Rzv6CKRi828ytEA+Ce/TGRYY4KfZAkgvQMEOekGd8NZ+jZvZ2juZYXlfeVA8gX9
	 fdT5gy7wxge0e9202Ia0Ys255tT9enSFbGOLbvbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgESQdO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 19 May 2020 12:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbgESQdN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 12:33:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E2820884;
        Tue, 19 May 2020 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905993;
        bh=KqBKhr6to6bxExK2bg4wDA0x7D/o81eMVQb7vBHPcOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLwx4XLbCMMeNgYFg4LZMUs5N+usEH/X5Qa4Zk8BnvMKDRFfHDVBfZYva3KPQfDKf
         FY6B9ylSZcXEiPLjvYxUvlHwF0OOEMpO9CUJHOWlWBfze0aPtZ9sNcq49fgY8g2dX4
         XEO/DAXqGVEXQTGY+jSpNnrmuxQ9lQypen2aTuVM=
From:   Sasha Levin <sashal@kernel.org>
To:     alexander.deucher@amd.com, chris@chris-wilson.co.uk,
        ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com,
        tvrtko.ursulin@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org, Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 2/4] gpu: dxgkrnl: hook up dxgkrnl
Date:   Tue, 19 May 2020 12:32:32 -0400
Message-Id: <20200519163234.226513-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Connect the dxgkrnl module to the drivers/gpu/ makefile and Kconfig.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/Makefile  | 2 +-
 drivers/video/Kconfig | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..28c22c814494 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -3,6 +3,6 @@
 # taken to initialize them in the correct order. Link order is the only way
 # to ensure this currently.
 obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
-obj-y			+= drm/ vga/
+obj-y			+= drm/ vga/ dxgkrnl/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 427a993c7f57..362c08778a54 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -19,6 +19,8 @@ source "drivers/gpu/ipu-v3/Kconfig"
 
 source "drivers/gpu/drm/Kconfig"
 
+source "drivers/gpu/dxgkrnl/Kconfig"
+
 menu "Frame buffer Devices"
 source "drivers/video/fbdev/Kconfig"
 endmenu
-- 
2.25.1

