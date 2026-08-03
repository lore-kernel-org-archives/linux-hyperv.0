Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D97E2E8B64
	for <linux-hyperv@vger.kernel.org>; Mon,  3 Aug 2026 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728134; cv=none; b=dBSC1B9g9M8TX9aBqfwooqx4vY/8uuV9RHYBwIvT+6oIn6bGQEVXzi+wzcwzxRg2fncmXpQuCWvQC0r8TDtV8f/9bfzfyBhNFYgIdkRTu2W+GnIzhTp6ZTphAKx00yWjy6cwiFoM9/4Z4beOjw83AURumhRwLjKqd9WtZNJVasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728134; c=relaxed/simple;
	bh=vf0PL3BKC5aOnGyR/Cak6UfckyToLr8slKTkVzxIoPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=exvJs7vtwF9jXyTr272u+1CMtHzWYoJJ+0j+BhBis8+VCCiTQKE4x0LHTm4w+rVreDhDce19Q6YtVZGTCSH+xi5R+t3Cv858RuVqX15jiwfcQ9KSPHLFGLUMSU0dzaLbub/w3GdPmHgkCpWIYj0AAdeOrfDJudcJeBwIN3mpOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkCkmUu3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkCkmUu3"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2021080a91.2
        for <linux-hyperv@vger.kernel.org>; Sun, 02 Aug 2026 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785728133; x=1786332933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0CzR7FuJcZM3BKpU9H46pvPFe7lq9Af4jXZ47uMFuKk=;
        b=OkCkmUu3JStvxr08DX13P6yUHpcO+bP3PACV0Cdkf2sE98A1eSV0mLeMua6DQ6Qr8/
         QNAca57BdMB2qdFtZbj0ulrliWNNDLaSwrF6sWkNbhtZEgZMdUu5R2FQrB9dEjwAyfC8
         QUKylRT9SsvGKOPhmmxcHYGaGfcG03GdR+lYBgIFvG9fKWf+IPvbbf0HYlk25rE9YLZR
         bejhKLijNk1GyI4EkvWWca19tQs/QAB3H72flGrlJ5q1MRCxUxy4BBiLwbzXh5o4kQl+
         ZgLTkiQBXU20QFvYo44indZg9Yn8aCQcMsAMif8LONbaYgqKedMtW+tP263RNFnjWJX6
         O3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785728133; x=1786332933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0CzR7FuJcZM3BKpU9H46pvPFe7lq9Af4jXZ47uMFuKk=;
        b=PlNk2cfOTQ2GwaAoxjLyPb2QochFPfew3KIW85s1W1mbN34v8Eo4vzh0YGnBnvUSP4
         nGxccpIuoRvPbJ3l5xw4pYBWWGGpKgzzIJeuoM6A1EPMg5z6JrOJdLOVCHlCKRWatGhh
         Bsbs6lqez80qXRNfQwcrACmlrAwMoJ3hl23CL1D/Re0lO4Sz5HvP2jZ/PRjlaeg/m11C
         eJFZeL2wBgQS8789V4X8INA71M2Pmw7woa4pARZIYSyK//UTuAOwipJSjiTpF+TRU+Kx
         KI48/Pi990hKKS2eUO6rW6dOKIHdbcBJCj00+K+99ycSJYyWbAkbUhA3Kfwm250YUgv8
         qZBw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4lUS7u44W6XrZ9/gGZkBYN1Bxib/Usyl3S9doidnaqo9IilRg/eRew5jotxA7ATL8XQA/XOXbbC+TsCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhutsho4gXhnV+WO3OhMU3DOMq3LMbPYLT3NMTLJpd6vENhRRv
	ydCgDTx4ITI5PwUjD8zUowFuNEkFIOe5oFp6Wogi65L1IzEfQTJmjewn
X-Gm-Gg: AR+sD10M18NFcUtI671A4oEzbK0rHyorDTCsylQwhcKc3wq+/vT70OczZbaV2fN62Uj
	bXQV6cPGHsKouig2tMNjf1GQyKPPWXiSX3Pz8P5o9/WtaJ9uTMUWCc3a+kVplYYnV5kJCvKOx+R
	7/TIhDjg8l9vSwTK8QcskufYPXwr4NEnW9O5mW0MplQkl6v+jon1jdTjHqADs8+Tuq/fOA/YS+n
	1oJBT3Y5YWGgdywLeHSibh48huNrewaeMvxEfPkmlgiaFoD3qLF1yIr94+ZAp+QAS8XeAawu7/T
	Okq3f3Ty1zEy3T90fAfEZ1vEyd4BtYOOEdkey8b452xVrhLvZ0RKSiv6tTpEEDkaspZ1mR+Ojkx
	S8+9ifi2dwZnisVRO+0k69Pg1mG0o+Kv9DOL1yM8Klqp0EOUcQXoXvLMAiU7PbTrzmEshQaquFu
	WwoqTA+yAyRG8dFGw26kSfFB27JHGA1UbIGyOEEKhTpb5JNYZ7YOi+SZORyJQOxlwv5aMEtOM2T
	1U2lLaHrnc2EWbYNSN5DA==
X-Received: by 2002:a17:90b:1808:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-38fbc3f7effmr7377092a91.9.1785728132073;
        Sun, 02 Aug 2026 20:35:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([104.43.2.12])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm36733485c88.12.2026.08.02.20.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:35:31 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	hch@infradead.org,
	robin.murphy@arm.com,
	vdso@hexbites.dev,
	aneesh.kumar@kernel.org,
	mhklinux@outlook.com
Subject: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory in Coco VM
Date: Sun,  2 Aug 2026 23:35:20 -0400
Message-Id: <20260803033520.12930-1-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In CoCo VMs, system memory is encrypted by default.
Device drivers typically rely on the DMA core's
SWIOTLB as a bounce buffer for DMA operations, providing
decrypted memory that can be shared between the guest and
host.

For PCI devices with T-Disp support and Confidential
VMBus devices (https://lkml.org/lkml/2026/7/27/1733) can
perform DMA transfers directly with private/encrypted
memory in a CoCo VM.

To support DMA transfer with encrypted memory, Hyper-V
DMA ops are introduced and bypass some API which may
use swiotlb as bounce buffer.

The DMA ops used is global data structure(see get_arch_
dma_ops() and get_dma_ops() for details). There is no
need to set up for each device individually.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/Kconfig      |   5 ++
 drivers/hv/Makefile     |   1 +
 drivers/hv/hv_dma_ops.c | 140 ++++++++++++++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c  |  14 +++-
 4 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/hv_dma_ops.c

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 2d0b3fcb0ff8..4b50a631fd57 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -7,6 +7,7 @@ config HYPERV
 	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
 		|| (ARM64 && !CPU_BIG_ENDIAN)
 	select PARAVIRT
+	select HYPERV_DMA_OPS
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
 	select IRQ_MSI_LIB if X86
@@ -14,6 +15,10 @@ config HYPERV
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_DMA_OPS
+	bool "Enable Microsoft Hyper-V DMA ops support"
+	depends on ARCH_HAS_DMA_OPS
+
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
 	depends on (X86_64 && HAVE_STATIC_CALL) || ARM64
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 888a748cc7cb..b4d23c88b9eb 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV_VMBUS)	+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_HYPERV_DMA_OPS)	+= hv_dma_ops.o
 obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
 obj-$(CONFIG_MSHV_VTL)          += mshv_vtl.o
 
diff --git a/drivers/hv/hv_dma_ops.c b/drivers/hv/hv_dma_ops.c
new file mode 100644
index 000000000000..ef53a42c0450
--- /dev/null
+++ b/drivers/hv/hv_dma_ops.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Microsoft Corporation.
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/hyperv.h>
+#include <linux/smpboot.h>
+
+#include <linux/kernel.h>
+#include <linux/dma-map-ops.h>
+#include <linux/export.h>
+#include <asm/mshyperv.h>
+#include "hyperv_vmbus.h"
+#include "../../kernel/dma/direct.h"
+
+extern const struct dma_map_ops *dma_ops;
+
+extern bool is_vmbus_dev(struct device *dev);
+
+static bool hyperv_private_memory_dma(struct device *dev)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+
+	if (is_vmbus_dev(dev) && hv_dev && hv_dev->channel
+	    && hv_dev->channel->co_external_memory)
+		return true;
+
+	/* Todo: Check T-Disp capability of PCI device here */
+
+	return false;
+}
+
+static int hyperv_dma_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nelems, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct scatterlist *sg;
+	dma_addr_t dma_addr;
+	int i;
+
+	if (hyperv_private_memory_dma(dev)) {
+		for_each_sg(sgl, sg, nelems, i) {
+			dma_addr = __phys_to_dma(dev, sg_phys(sg));
+			sg_dma_address(sg) = dma_addr;
+			sg_dma_len(sg) = sg->length;
+		}
+
+		return nelems;
+	} else {
+		return dma_direct_map_sg(dev, sgl, nelems, dir, attrs);
+	}
+}
+
+static void hyperv_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nelems, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!hyperv_private_memory_dma(dev))
+		dma_direct_unmap_sg(dev, sgl, nelems, dir, attrs);
+}
+
+static int hyperv_dma_supported(struct device *dev, u64 mask)
+{
+	dev->coherent_dma_mask = mask;
+	return 1;
+}
+
+static size_t hyperv_dma_max_mapping_size(struct device *dev)
+{
+	if (hyperv_private_memory_dma(dev))
+		return SIZE_MAX;
+	else
+		return swiotlb_max_mapping_size(dev);
+}
+
+/* allocate and map a coherent mapping */
+static void *
+hyperv_dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		    gfp_t flag, unsigned long attrs)
+{
+	phys_addr_t phys;
+	void *ret;
+
+	if (!hyperv_private_memory_dma(dev))
+		return dma_alloc_coherent(dev, size, dma_handle, flag);
+
+	size = ALIGN(size, PAGE_SIZE);
+	ret = (void *)__get_free_pages(flag, get_order(size));
+	if (!ret)
+		return ret;
+	phys = virt_to_phys(ret);
+
+	if (hyperv_private_memory_dma(dev))
+		*dma_handle = dma_addr_encrypted(__phys_to_dma(dev, phys));
+	else
+		*dma_handle = phys_to_dma_unencrypted(dev, phys);
+
+	memset(ret, 0, size);
+	return ret;
+}
+
+/* free a coherent mapping */
+static void
+hyperv_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t dma_addr, unsigned long attrs)
+{
+	if (hyperv_private_memory_dma(dev))
+		dmam_free_coherent(dev, size, vaddr, dma_addr);
+	else
+		free_pages((unsigned long)vaddr, get_order(size));
+}
+
+static dma_addr_t hyperv_dma_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	if (hyperv_private_memory_dma(dev))
+		return __phys_to_dma(dev, phys);
+	else
+		return dma_direct_map_phys(dev, phys, size, dir, attrs, true);
+}
+
+static void hyperv_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!hyperv_private_memory_dma(dev))
+		dma_direct_unmap_phys(dev, dma_handle, size, dir, attrs, true);
+}
+
+const struct dma_map_ops hyperv_dma_ops = {
+	.alloc			= hyperv_dma_alloc_coherent,
+	.free			= hyperv_dma_free_coherent,
+	.map_phys               = hyperv_dma_map_phys,
+	.unmap_phys             = hyperv_dma_unmap_phys,
+	.map_sg                 = hyperv_dma_map_sg,
+	.unmap_sg               = hyperv_dma_unmap_sg,
+	.dma_supported          = hyperv_dma_supported,
+	.max_mapping_size	= hyperv_dma_max_mapping_size,
+};
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d28ff45d4cfd..d1ce5c107993 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -40,6 +40,10 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
+#include "../../kernel/dma/direct.h"
+
+extern const struct dma_map_ops *dma_ops;
+extern const struct dma_map_ops hyperv_dma_ops;
 
 struct vmbus_dynid {
 	struct list_head node;
@@ -1468,6 +1472,11 @@ static int vmbus_alloc_synic_and_connect(void)
 	return -ENOMEM;
 }
 
+bool is_vmbus_dev(struct device *dev)
+{
+	return dev->bus == &hv_bus;
+}
+
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
  *
@@ -1523,8 +1532,11 @@ static int vmbus_bus_init(void)
 	 * doing that on each VP while initializing SynIC's wastes time.
 	 */
 	is_confidential = ms_hyperv.confidential_vmbus_available;
-	if (is_confidential)
+	if (is_confidential) {
+		dma_ops = &hyperv_dma_ops;
 		pr_info("Establishing connection to the confidential VMBus\n");
+	}
+
 	hv_para_set_sint_proxy(!is_confidential);
 	ret = vmbus_alloc_synic_and_connect();
 	if (ret)
-- 
2.53.0

