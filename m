Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7D23F417;
	Fri,  1 May 2026 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596131; cv=none; b=dF9rgTO3CDly+w0L1O9iIL6Czj1nKOEJ39QsfgM96vALKQIUXg/we/Cws9tSuH2d4fRGB2Cfnt8C2/UuGrCJizUtnbhQP9qXCFQcSA0P7RXYcBy9czh7eXuasM476valQmEVB6GWHy9yTQEeVDGtAo6ml7TDDcxQGueNb+TpT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596131; c=relaxed/simple;
	bh=iNCq/6LJynBsDvVqOUXofG0jeHT8WBHDLN51gLy0Qh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNJKf8urxCEXTkbk4yEh/01uv6AeHXYV8afToNRHCY+4m1P/iBkCThpJhoZ25obXyHbYM0wSJUSJU6QPV9dxh4g/BiWI2gsjASflQ+fZJbJ5/e+zuo7MJzJ6LOOG6oJbZdBgTHRJLKkGYQBzxfu+117s1XoqWQBbwm45aYbcwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iBPESL9j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iBPESL9j"
Received: from mrdev.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E76720B7167;
	Thu, 30 Apr 2026 17:42:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E76720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777596129;
	bh=ynRA88Z5bV4VTptbAf0c2VvjcKoPPD/m6Qh24ri9A0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBPESL9jKKWmNDTt4bCQrEOMEaylhc+I5k3jMfbEhgOdeL/Vr5w031kS9KRSu+KMy
	 3q5FPmZGV6l8nBTwUmbITkC69Qr/sUA1e8UV6AvdD6WEU2EkMIJ+KsA9GafQGOBhfh
	 mV6t6eABKgSYzQoTd/FFWo0AbXRUX4uYvVMtyIhU=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Subject: [PATCH V2 01/11] iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
Date: Thu, 30 Apr 2026 17:41:47 -0700
Message-ID: <20260501004157.3108202-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
References: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file actually implements irq remapping, so rename to more appropriate
hyperv-irq.c. A new file to implement hyperv iommu will be introduced
later.  Also, it should not be tied to HYPERV_IOMMU, but to CONFIG_HYPERV
and IRQ_REMAP. The file already has #ifdef CONFIG_IRQ_REMAP.

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 MAINTAINERS                                    | 2 +-
 drivers/iommu/Makefile                         | 2 +-
 drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} | 6 +++---
 drivers/iommu/irq_remapping.c                  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..f803a6a38fee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11914,7 +11914,7 @@ F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
-F:	drivers/iommu/hyperv-iommu.c
+F:	drivers/iommu/hyperv-irq.c
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
 F:	drivers/pci/controller/pci-hyperv-intf.c
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 0275821f4ef9..335ea77cced6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
-obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
+obj-$(CONFIG_HYPERV) += hyperv-irq.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-irq.c
similarity index 99%
rename from drivers/iommu/hyperv-iommu.c
rename to drivers/iommu/hyperv-irq.c
index 479103261ae6..d11076f906fb 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-irq.c
@@ -8,6 +8,8 @@
  * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
  */
 
+#ifdef CONFIG_IRQ_REMAP
+
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -24,8 +26,6 @@
 
 #include "irq_remapping.h"
 
-#ifdef CONFIG_IRQ_REMAP
-
 /*
  * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
  * Redirection Table. Hyper-V exposes one single IO-APIC and so define
@@ -331,4 +331,4 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
 	.free = hyperv_root_irq_remapping_free,
 };
 
-#endif
+#endif  /* CONFIG_IRQ_REMAP */
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index c2443659812a..41bf65e4ea88 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -108,7 +108,7 @@ int __init irq_remapping_prepare(void)
 	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
 		 amd_iommu_irq_ops.prepare() == 0)
 		remap_ops = &amd_iommu_irq_ops;
-	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
+	else if (IS_ENABLED(CONFIG_HYPERV) &&
 		 hyperv_irq_remap_ops.prepare() == 0)
 		remap_ops = &hyperv_irq_remap_ops;
 	else
-- 
2.51.2.vfs.0.1

