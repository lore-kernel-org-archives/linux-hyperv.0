Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4983002D1;
	Mon,  8 Jun 2026 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884397; cv=pass; b=dbSUjS/8dUUEabRbhChxvBhsfc9RaeDl25tKjKXs1JUWPTBFZyrzXWRepTHVczag9DdLyL/ZeKJlx+9Y59f1v07YJl7AHUA4bhL9o0s09pxIKeXNyOYQr1a0JkvJknr6cqKqyxgLtYInw0G6gpeY05Q4PtBTJiFJQgyxiHuBDLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884397; c=relaxed/simple;
	bh=GRpxiDhOYdxhJE98yqlJqGSfb/ssfUh+7GJa7oi4J6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j1l6xrLBzyvEOe9M5g3YaZozBa0D0h6neQBi2j61YFZHq3elhtgNY37xit4ZmYCRPQOSD98iVusLZMNSDBdShJEC41Y8g2X/mV9e4JkeQmXBcKMuXRuwJzaLC+PFD69JYVplg7rG9SK8dZHhON0j34LSdoYM4Dw2rUuHXrsLbmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=KlJwMYN4; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="KlJwMYN4"
ARC-Seal: i=1; a=rsa-sha256; t=1780884391; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qb4P1o9wSVjfJvc9OGSYG5WMmlvgyFN/0decw9mTOtDSnJZ5qhfGgrHyf5H2czS6zFXC6gLSnbWaEOrnYX572B6Biba3vTJ0wInF3svNY3PfFcFnwfTnpuM3dSGp1R4pDtrHjttVLV5JXY0foGxenQrGkQrZ44kvlZwXAGpL8ZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780884391; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=djL16uw205VVL6gItTBwIsFHnNXMGG9l+tcLExhjJr4=; 
	b=doDDEyf1wekckQkVNWu/Tut11gLodPQQGeKWAA/lV6TzfhJSDr56CnrqupoXVY/+6rHo8muNKYklNG6A+w6TNE/LWi16xwOAMMfXUP2RX2/2dczX2iUM/tNCbEmYeyw3OENFZbXQVx7nj6mirD9YUpH1hpFXa+aHGGjSFk0eX90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780884391;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=djL16uw205VVL6gItTBwIsFHnNXMGG9l+tcLExhjJr4=;
	b=KlJwMYN4Z0Vr1sUkg5yWDmhn+Ox0cMrqglY2UaD083zUwgRDmNNjcLiORa1D2ESI
	4Ftkt0dpWQydjDZM7/SEeaUaLUDALLB98IyoADzoYsrfTMrr4h1ZOJh2WLSjeNo2vjf
	+IhhsAO22DQrbVXD7Zh4aV2qwOOhIYlLNh8a4ncg=
Received: by mx.zohomail.com with SMTPS id 1780884389211937.589742357867;
	Sun, 7 Jun 2026 19:06:29 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Set DMA coherent mask for VMBus devices
Date: Sun,  7 Jun 2026 19:06:16 -0700
Message-Id: <20260608020616.52852-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112272fcdaf1d591ed5cfa619beb80000f021b97d0acaf2b4153a41a6c980372e33844824cb6293770d:ZohoMail
X-Zoho-CM-AccountID: 0c88436b239415d28725328898ceccb9ce2ba3b61598c1c37bcb2109e0248174
X-ZohoMailClient: External

From: Michael Kelley <mhklinux@outlook.com>

In current code, the coherent_dma_mask for VMBus devices is not set, so
it has the default value of 0, which essentially means "invalid". Because
drivers for VMBus devices do not use dma_alloc_*() functions, the usual
use of the coherent mask does not occur, and no errors result.

However, a valid coherent_dma_mask may be needed even though the drivers
don't use dma_alloc_*() functions. In a CoCo VM, the VMBus storvsc and
netvsc drivers must bounce buffer DMA operations through the swiotlb
because the Hyper-V host can't DMA into encrypted guest memory. If the
kernel is built with CONFIG_SWIOTLB_DYNAMIC and the initial swiotlb size
is small, swiotlb code may need to grow the swiotlb in response to a DMA
mapping request. That growth first allocates a transient pool while the
swiotlb is expanded in the background. The transient pool memory is
allocated from the DMA atomic pools, and the allocation code checks for
a valid coherent_dma_mask. With current code, this check fails, then the
DMA mapping request from the storvsc or netvsc driver fails, and finally
an I/O error occurs.

Fix this problem by setting coherent_dma_mask for VMBus devices at the
same time that dma_mask is set. Being a synthetic bus, VMBus does not
have any restrictions on coherent DMA, so the coherent mask is set to
the full 64 bits for all VMBus devices, just like with dma_mask.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
I have not provided a Fixes: tag because the scenario under which
the error occurs is an artificial test case that I came across
while stressing a unrelated patch set. The fix is valid for general
goodness, but the likelihood of the problem occurring in the real
world is extremely small. So I see little value in adding this
patch to the stable kernel maintainers' workload. If someone wants
to argue otherwise, I have no fundamental objection to adding the
Fixes: tag.

 drivers/hv/vmbus_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c9eeb2ec365d..26e8273bbddd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2192,6 +2192,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
 	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
 	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
+	dma_set_coherent_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 
 	/*
 	 * Register with the LDM. This will kick off the driver/device
-- 
2.25.1

