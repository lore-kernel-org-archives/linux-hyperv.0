Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA644E236D
	for <linux-hyperv@vger.kernel.org>; Thu,  3 Sep 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449850; cv=none; b=f+403xaB3rtTjsa6+mTv/eov1l8g5G6+Lvof9vSRRzot613MUjmWAWLxtd3St2LNNPvMdvrudkr0LV+jQQqFt+lCWmC565XyokNmYRgez52gCG3BZ5Y8IAzmR7tervJewr09crV+sHhQ/omI75ff/GmVGp+/nIuSZx6gGv0FKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449850; c=relaxed/simple;
	bh=KFN2+XEZt21MWL4P88wpY0kbHhxNfDNXuhVXFdDI/pY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXfdzbitqajxmIPPEECAa4IBcr+iYd8OOmho8QTfRpB/EKxRAuJefzbiBPJ4BnraDYUkW5JsfpHOEzpMzZqlH3iLy6szXSZFcDgUWUtg50+o2zZVWt6l3phib1B7zsDyqwZg7BubvfyLtsC5Hjs/uFQiko2ZybKgjiradSsScX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrWOmqV6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrWOmqV6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d9db539a54so22498885ad.0
        for <linux-hyperv@vger.kernel.org>; Thu, 03 Sep 2026 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788449848; x=1789054648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zxB21Am19KNu/xD6JSwCcswCsWQ6E9K4YeysNE5kNTY=;
        b=LrWOmqV6gY02I0Rp6V/1rRGXvQGcDmtiN0n47x0SeAjw+onxiZbd7KCM5ZVRrW+/x2
         37bU99jR+BTUrBUcql1o9mktXZ6LsPzROMFkJD87zMSmAJtj1oGtP+G3jNmwq4kJ1RA/
         IzV6X32JadgMyBDUISy0ZmRC1bh8Cer/mYsoeGcdhLlH4KA5zYiAYvl8atOsFy+v9iD7
         R/QFz5jARWX4+dMg1/yTMKdDuwtXzDE07DGZnBPmgPObqg+mm458HMpoEgb32FASLj+j
         duUsw4YW1Sm7hsYYW5p7y6K/ciElNfT48owhh/Q/61oy1a5Zn4WpOYMWJwJVpoVr53u8
         0OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788449848; x=1789054648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxB21Am19KNu/xD6JSwCcswCsWQ6E9K4YeysNE5kNTY=;
        b=Y8zksdXO3uIW5DE889qWdzX7Pjv+eo2Ibp9ISB1hjkIrD1Mcr57phTAmKQiC/ZVk7k
         ljV39PdRB5fdEf1ceHLijb7CqGx37UPE/kqrhmyxhglTxU+afxN7D2p+N/O5jNWlT1RO
         abrT6GIEqV15XIgAtQoEO6NcChxYDh0kFn7wq3mJv5hOJko63g+ajecQMg2ycB6nxsRl
         lMpLhwtaX28GLfa+1hfvC+lAHlUBIM8UdP4mmThMXI5V+XMxPmTYibuXKoy1xyT0MTKN
         XlTnIG46iY+7whc7/tr+goZjwXWmuGj0p0XrG6yVmlHQUktWRt8pY2hVu/z59o0zvVXH
         p3Sw==
X-Forwarded-Encrypted: i=1; AKwUvBy0kduS98zCU/EJgJm58+l+2yqsg/X+xRvucB8KbC8WVqCdvjnbPar5LgWCs5g0xy+oDBDEHVIyjW9ssI8=@vger.kernel.org
X-Gm-Message-State: AFuF++n/6DVVGb6ZqH0xPdERuJkI4mO4gv6/G9U30iUafsIeFPsL4inf
	b8EohaABt1e5pq8BtltEi79P+sT8o9n8AR+1r33QspwDK17Xf5vXPEMkiMbnOtbpTRg=
X-Gm-Gg: AYBFou2/djIUVz2/BxvCXgQyfOE1qp/E18/ecPx174TMSE5L+31qGjl61DLri/ED1bm
	fIjSojl9gbnRjP79o8pIH8LHL0k/13IlR5jdSS1B/XCKz4Gea2IN2/9y8aX8aX+lVbTvHRyoWhT
	WWbrpd9UauWRY+4FOEg1nnduuYKwGZ+vQ06KVsvZvFlX1XLpChK1ek0+VVk9Pcf9iPZ/58uL2wH
	6NQK1O72Qes/utLXt19BhSfbfMUMabORIu4aSoxId9kM8Gf2vRGxadJ5XQ71kP4zzUaWQZlYxb9
	1aI46I3JV4Sy+FyucUYu4yJ+iQ3rbe5TqqIksSqrKNSvNZmcOGuAqe1fG0Dn9bETVMXpX1MG8pk
	Js/jr9kLPkzvSxTc8xwt8CG9CyujDl05uuD4pZ3BYInvHOe43N66fOHOp8zcFtOMp0W0NdZExsZ
	AMiWZAb7j84Vf2Z5WdRPNFInOU7FSvuGlNSuLh32A8KLIGAYR7K91z5iYfoSaxOIJ0xGTcpw==
X-Received: by 2002:a17:903:1aa3:b0:2d6:fec3:bd57 with SMTP id d9443c01a7336-2daec71a62bmr121927425ad.14.1788449847469;
        Thu, 03 Sep 2026 08:37:27 -0700 (PDT)
Received: from lsgdev.mshome.net ([167.220.255.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafec29303sm11902545ad.53.2026.09.03.08.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:37:26 -0700 (PDT)
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
Subject: [Update RFC V2 PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory in Coco VM
Date: Thu,  3 Sep 2026 23:16:34 +0800
Message-ID: <20260903151635.125034-1-tiala@microsoft.com>
X-Mailer: git-send-email 2.53.0
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

For PCI devices with TDisp support and Confidential
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
Update change:
    * s/T-Disp/TDisp
    * Remove redundant check code

Change since RFC v1:
    * Fix warning, code style issues and make the code
    of reference dma ops under CONFIG_ARCH_HAS_DMA_OPS.    
---
 drivers/hv/Kconfig        |   9 +++
 drivers/hv/Makefile       |   1 +
 drivers/hv/hv_dma_ops.c   | 134 ++++++++++++++++++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h |   1 +
 drivers/hv/vmbus_drv.c    |  19 +++++-
 5 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/hv_dma_ops.c

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 2d0b3fcb0ff87..fbbeb67cb2cab 100644
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
@@ -14,6 +15,13 @@ config HYPERV
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_DMA_OPS
+	bool "Enable Microsoft Hyper-V DMA ops support"
+	depends on ARCH_HAS_DMA_OPS
+	help
+	  Select this option to enable DMA with encrypt
+	  memory in CoCo VM.
+
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
 	depends on (X86_64 && HAVE_STATIC_CALL) || ARM64
@@ -62,6 +70,7 @@ config HYPERV_VMBUS
 	depends on HYPERV
 	default HYPERV
 	select SYSFB if EFI && !HYPERV_VTL_MODE
+	default y if HYPERV_DMA_OPS
 	help
 	  Select this option to enable Hyper-V Vmbus driver.
 
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 888a748cc7cb9..b4d23c88b9eb0 100644
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
index 0000000000000..9b0fb76a98747
--- /dev/null
+++ b/drivers/hv/hv_dma_ops.c
@@ -0,0 +1,134 @@
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
+const struct dma_map_ops *dma_ops;
+bool is_vmbus_dev(struct device *dev);
+
+static bool hyperv_private_memory_dma(struct device *dev)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+
+	if (is_vmbus_dev(dev) && hv_dev && hv_dev->channel
+	    && hv_dev->channel->co_external_memory)
+		return true;
+
+	/* Todo: Check TDisp capability of PCI device here */
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
+			dma_addr = phys_to_dma(dev, sg_phys(sg));
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
+	*dma_handle = dma_addr_encrypted(__phys_to_dma(dev, phys));
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
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 05a36854389af..94f16382bba7b 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -356,6 +356,7 @@ extern const struct vmbus_channel_message_table_entry
 /* General vmbus interface */
 
 bool vmbus_is_confidential(void);
+bool is_vmbus_dev(struct device *dev);
 
 #if IS_ENABLED(CONFIG_HYPERV_VMBUS)
 /* Free the message slot and signal end-of-message if required */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d28ff45d4cfdd..a45a1d010a1cd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -40,6 +40,12 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
+#include "../../kernel/dma/direct.h"
+
+#ifdef CONFIG_ARCH_HAS_DMA_OPS
+const struct dma_map_ops *dma_ops;
+const struct dma_map_ops hyperv_dma_ops;
+#endif
 
 struct vmbus_dynid {
 	struct list_head node;
@@ -62,6 +68,7 @@ int vmbus_interrupt;
  * visible to either the host or the hypervisor.
  */
 static bool is_confidential;
+static const struct bus_type  hv_bus;
 
 bool vmbus_is_confidential(void)
 {
@@ -69,6 +76,11 @@ bool vmbus_is_confidential(void)
 }
 EXPORT_SYMBOL_GPL(vmbus_is_confidential);
 
+bool is_vmbus_dev(struct device *dev)
+{
+	return dev->bus == &hv_bus;
+}
+
 /*
  * The panic notifier below is responsible solely for unloading the
  * vmbus connection, which is necessary in a panic event.
@@ -1523,8 +1535,13 @@ static int vmbus_bus_init(void)
 	 * doing that on each VP while initializing SynIC's wastes time.
 	 */
 	is_confidential = ms_hyperv.confidential_vmbus_available;
-	if (is_confidential)
+	if (is_confidential) {
+#ifdef CONFIG_ARCH_HAS_DMA_OPS
+		dma_ops = &hyperv_dma_ops;
+#endif
 		pr_info("Establishing connection to the confidential VMBus\n");
+	}
+
 	hv_para_set_sint_proxy(!is_confidential);
 	ret = vmbus_alloc_synic_and_connect();
 	if (ret)
-- 
2.53.0

