Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95D1DC198;
	Thu, 16 Apr 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364564; cv=none; b=oKGXJwRjjCGLdM+WUkqk+c8mseim7fgwqGj+QrPecOg2nYe7QuW7b9d3SzvL1gH7/QdAWfiHC7/x+1gtTho0UBYlf4OKH/ll0c6XtGTnmmUDPdPCY19mTPLfguG+51im6M460xMu/6/DB0B/vF861/HSvV/u5Vjat3M6a7S95XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364564; c=relaxed/simple;
	bh=jYDrpKmgdrQiS3s46ncnw+0OXCF7//qblpw07yVDEsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHMWAgN5QF9jpqSxHoYnR1Xq6HGwMjrFz5audc3QRlgBmdq8D/cltbHXbtCTjbYSuX+4JHar4X9fq1uLUsRsUsK3kJkVYbSb/y/1XuvKe8KA1zAlVlikSj9N2sF7fvFR6cGwR6AC5MT6zHxvXWJFm2uZVnNaYz7bbpo8ELKPQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id CF89020B7128; Thu, 16 Apr 2026 11:35:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF89020B7128
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	matthew.ruffell@canonical.com,
	johansen@templeofstupid.com
Cc: stable@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio on Gen2 VMs
Date: Thu, 16 Apr 2026 11:35:29 -0700
Message-ID: <20260416183529.838321-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If vmbus_reserve_fb() in the kdump kernel fails to properly reserve the
framebuffer MMIO range due to a Gen2 VM's screen.lfb_base being zero [1],
there is an MMIO conflict between the drivers hyperv_drm and pci-hyperv.
This is especially an issue if pci-hyperv is built-in and hyperv_drm is
built as a module. Consequently, the kdump kernel fails to detect PCI
devices via pci-hyperv, and may fail to mount the root file system,
which may reside in a NVMe disk.

On Gen2 VMs, if the screen.lfb_base is 0 in the kdump kernel, fall
back to the low MMIO base, which should be equal to the framebuffer
MMIO base (Tested on x64 Windows Server 2016, and on x64 and ARM64 Windows
Server 2025 and on Azure) [2]. In the first kernel, screen.lfb_base
is not 0; if the user specifies a high resolution, it's not enough to
only reserve 8MB: in this case, reserve half of the space below 4GB, but
cap the reservation to 128MB, which is the required framebuffer size of
the highest resolution 7680*4320 supported by Hyper-V.

Add the cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) check, because a CoCo
VM (i.e. Confidential VM) on Hyper-V doesn't have any framebuffer
device, so there is no need to reserve any MMIO for it.

While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
the > to >=. Here the 'end' is an inclusive end (typically, it's
0xFFFF_FFFF).

[1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
[2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
CC: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f0d0803d1e16..a0b34f9e426a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -37,6 +37,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
 #include <linux/export.h>
+#include <linux/cc_platform.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -2327,8 +2328,8 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 		return AE_NO_MEMORY;
 
 	/* If this range overlaps the virtual TPM, truncate it. */
-	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
-		end = VTPM_BASE_ADDRESS;
+	if (end >= VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
+		end = VTPM_BASE_ADDRESS - 1;
 
 	new_res->name = "hyperv mmio";
 	new_res->flags = IORESOURCE_MEM;
@@ -2395,13 +2396,36 @@ static void vmbus_mmio_remove(void)
 static void __maybe_unused vmbus_reserve_fb(void)
 {
 	resource_size_t start = 0, size;
+	resource_size_t low_mmio_base;
 	struct pci_dev *pdev;
 
+	/* Hyper-V CoCo guests do not have a framebuffer device. */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
 	if (efi_enabled(EFI_BOOT)) {
 		/* Gen2 VM: get FB base from EFI framebuffer */
 		if (IS_ENABLED(CONFIG_SYSFB)) {
 			start = sysfb_primary_display.screen.lfb_base;
 			size = max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000);
+
+			low_mmio_base = hyperv_mmio->start;
+			if (!low_mmio_base || low_mmio_base >= SZ_4G ||
+			    (start && start < low_mmio_base)) {
+				pr_warn("Unexpected low mmio base 0x%pa\n", &low_mmio_base);
+			} else {
+				/*
+				 * If the kdump kernel's lfb_base is 0,
+				 * fall back to the low mmio base.
+				 */
+				if (!start)
+					start = low_mmio_base;
+				/*
+				 * Reserve half of the space below 4GB for high
+				 * resolutions, but cap the reservation to 128MB.
+				 */
+				size = min((SZ_4G - start) / 2, SZ_128M);
+			}
 		}
 	} else {
 		/* Gen1 VM: get FB base from PCI */
@@ -2433,6 +2457,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
 	 */
 	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
 		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
+
+	pr_info("hv_mmio=%pR,%pR fb=%pR\n", hyperv_mmio, hyperv_mmio->sibling, fb_mmio);
 }
 
 /**
-- 
2.34.1

