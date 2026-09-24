Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7D3B6C13;
	Thu, 24 Sep 2026 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215380; cv=none; b=Z2PCY3hxb1VULzn5yBSRb4eMo+hYwvMKfRKMhhB7DJmYfxVOfB5zUlPdWc53hc+4XrgT1eRRKn/h8o/YpmDos9qXf1DD8SvQQ2/itCmaQ0Tz17eRvcoMgR+aYqlPccorz79AbbuJYdlAVLmn3uYtDIDobFBdxNrVtiP3MMjS96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215380; c=relaxed/simple;
	bh=r6jNY8HrdWZcp/saDq2c9Y5dbHAxj+2CKLQmoIEPrWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hso2LCtejABT1+n0qVVefG2j2bCVE/NV21yPxPABM4rsHjGeGAiGVnaN5AIlYbjSBFpY78stDigDfhLTew0NcOzRHUG1MdrHlqY1NJ5IOzBsf1i/ERurOCwyJLtM3fJGzTIDwQBjZXodKvUbNcQxGYl/Vwjy/Fd7bOxusBD6Oe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BYuS/Q6o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BYuS/Q6o"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id C904520B7168;
	Wed, 23 Sep 2026 19:02:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C904520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790215330;
	bh=s/r5W8RbILDolxzcAII0g8fOYp9kKEm8qMK2MOj266E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYuS/Q6oxoc70BBGqp2sdZ1TtmUDnuNu+qjWLBVkCmaLQPRl/XXj9MkJmZkS4yw9e
	 6BiCp6zLNN6fhPQlanA5xqAN/CdnAVIwDZXkDW0t9YQ824+FqRaGenJZckfT6i452s
	 wSDCT465Hw1N5/RO3ug3PKXP/gijZpCIxcCmbNSY=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V1 1/3] PCI: hv: Export hv_build_devid_type_pci() and change return type
Date: Wed, 23 Sep 2026 19:02:19 -0700
Message-ID: <20260924020221.128762-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260924020221.128762-1-mrathor@linux.microsoft.com>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Hyper-V, most hypercalls related to device domain management like
attach device to a device domain, or to map/unmap regions, interrupts,
etc need a device ID as a parameter. So, make hv_build_devid_type_pci()
public and change return type to u64 to enforce its size.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c     | 9 +++++----
 arch/x86/include/asm/mshyperv.h | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index b3ad50a874dc..8780573a4332 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -112,7 +112,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
+u64 hv_build_devid_type_pci(struct pci_dev *pdev)
 {
 	int pos;
 	union hv_device_id hv_devid;
@@ -172,8 +172,9 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
 	}
 
 out:
-	return hv_devid;
+	return hv_devid.as_uint64;
 }
+EXPORT_SYMBOL_GPL(hv_build_devid_type_pci);
 
 /*
  * hv_map_msi_interrupt() - Map the MSI IRQ in the hypervisor.
@@ -196,7 +197,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
 
 	msidesc = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msidesc);
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
 	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
@@ -271,7 +272,7 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
 {
 	union hv_device_id hv_devid;
 
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f64393e853ee..8ebbd1cb7c8c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -248,6 +248,12 @@ void hv_crash_asm_end(void);
 static inline void hv_root_crash_init(void) {}
 #endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
 
+#ifdef CONFIG_PCI_MSI
+u64 hv_build_devid_type_pci(struct pci_dev *pdev);
+#else
+static inline u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return 0; }
+#endif
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
-- 
2.51.2.vfs.0.1

