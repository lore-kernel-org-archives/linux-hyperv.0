Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E244242D9D;
	Sat, 18 Jul 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341217; cv=none; b=AoUywtlkv+XcEVrrhiskPtLLb9MZ47EqoZHj+uhX4XDJsaVQyc+AhkreBzYk0kgmOcqVzEjvjG18iGPwVMXRIpsyFJfX8TGfmz0trrWvaDwjgGNykUceEXppt31V+AbrWjFNduTukCMEukTIX29BBjRa5TNUm4PGr5THGJ3uIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341217; c=relaxed/simple;
	bh=HteEkaSp4wVOVK9nw0E0kiL5yJI37zhJ2LZk6JsNuX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkizfGYIDSeCs9xcLV4fvD05HhbfuxXK7JLGoWozv/QSiVuLVKtUIN9NfAXNh4W+RJMl6AHaRcuMDG+67swnQKPd40uynHmUnciIdNYsS2SYOXGuEWmowh8SuZyRgW1NrZ6IkG2iG/DaZug0U5PIbiJsbnaiUTKnq5/LrrlNklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dSc2/Wzw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dSc2/Wzw"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6E66420B716C;
	Fri, 17 Jul 2026 19:20:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E66420B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784341205;
	bh=hSQHhkvihXETyUD20dRGf5jzacsSTIZgqTCFlZVNEAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSc2/Wzwv52COrskPRmfHSb6gFoCIkvamBfZcOOh3PYM4NoZHa0tGN5lnlPNxsfhG
	 euoKKerSVTcgrBXhR7nk6py0bCLi7U/qcxyCnJTI4GR5ZYLK4+66CY0v7GxUDO3XOP
	 ZLf+GUNvwl6vGA0p3ufbpK2FhsvRt8C5y1cQQztI=
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
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V4 6/9] PCI: hv: Export hv_build_devid_type_pci() and change return type
Date: Fri, 17 Jul 2026 19:19:46 -0700
Message-ID: <20260718021949.926306-7-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260718021949.926306-1-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
interrupts, etc need a device ID as a parameter. This device ID refers
to that specific device during the lifetime of passthru. So,
make hv_build_devid_type_pci() public and change return type to u64 to
enforce it's size.

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

