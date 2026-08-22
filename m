Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EF493625;
	Sat, 22 Aug 2026 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359006; cv=none; b=r4f8AR+vQKGJ7RxDWTB1ZAtV5Em7AyTGSHtQLHpq9oGUN37lYEnzQql48E+ehxaw/D2dcB9HocYwFzVTnKtgGC5wg7TLJTKXwZtJGz66U0Bf+fERFAIvtIS3q/cm57E+sdEjv89c03BZnqEr9bjl9iX8VFluZX5C6H7QnVHcZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359006; c=relaxed/simple;
	bh=n77bWfg7/SrqlIq5Q92QVouaBeAoGZrrdJTdctsD25o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqNwdnKiH4TtM2mnjfHMBxIX3Gtl/qMs8zp34HqTpZO5+300Jm5MeF87WBC2vsyLTTl3n53GR48Qm4rsuhytzYTq+QngUeb0FHeHTgCFYgCKkVCXaWKhvceOtOoa6iZFyZVICEnLhcMG1kzSDICDhe7SSKWLqi/mBwYIux+BBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgA81X+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgA81X+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DB41F000E9;
	Sat, 22 Aug 2026 00:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359004;
	bh=4rPUvs1SqNmPF0n53kqBCF5WofIrOkSEXjsutvg8ZDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZgA81X+2v3w6MMbAEtxjLh75fNzzkpJhFo2h7Ta09HUL6r47wF0cv4Y1wEnnX27Nz
	 8USK6ZShd1DW6uhlTeBSaEuo1fgNdnvMzHVRIV396KOwLudUx41J637Y81ggQsJSl9
	 eTJr8I1oh1sJVGT2sYPNEAMoEVZFBuFmbAkk7Ym3YfVGscI9FY+Qswk4ML6UT9nPW/
	 1EM03RLIU+aqHuW7fUdKTAsvMSytxz6B+w7mT/0lrvJxGWPNQK4rI7jI4y9EzBo2M9
	 RbdIXYnmjPzgVWj362NXAUJvkr5o9Ow4TayqnmZ0qM448JYIpq4drBJRlynhqQ0LTu
	 WZM3NR7XeFmCw==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com,
	anirudh@anirudhrb.com,
	schakrabarti@linux.microsoft.com,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] PCI: hv: unmap MSI interrupt on the nested root partition teardown path
Date: Fri, 21 Aug 2026 17:36:21 -0700
Message-ID: <20260822003623.2925128-3-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822003623.2925128-1-wei.liu@kernel.org>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

On a nested root partition the vPCI MSI/MSI-X interrupts of vmbus
devices (e.g. the MANA NIC) are mapped in the hypervisor with a
MAP_DEVICE_INTERRUPT hypercall.  This is done from hv_arch_irq_unmask()
-> hv_map_msi_interrupt() because the nested hypervisor performs the
interrupt remapping and a RETARGET_INTERRUPT is not usable there.

The mapping was never removed: hv_arch_irq_unmask() called
hv_map_msi_interrupt(data, NULL), so the returned hv_interrupt_entry was
discarded, and hv_msi_free() tears the interrupt down with a vmbus
PCI_DELETE_INTERRUPT message (hv_int_desc_free()) without issuing
UNMAP_DEVICE_INTERRUPT.

This has led to MSHV rejecting already-mapped (vp, vector) pair from
being used. When this happens during early boot, the system hangs.

Keep the hypervisor mapping in sync with the kernel's interrupt
lifecycle.

The mapping is only created on x86 (hv_arch_irq_unmask() is a stub on
arm64), so the unmap hypercall is guarded accordingly.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 85 ++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..5a36382742bf 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -283,6 +283,35 @@ struct tran_int_desc {
 	u64	address;
 } __packed;
 
+/*
+ * On a nested root partition a vPCI MSI is mapped in the hypervisor with a
+ * MAP_DEVICE_INTERRUPT hypercall in hv_arch_irq_unmask().  Keep the entry the
+ * hypervisor returns next to the per-interrupt transaction descriptor so the
+ * mapping can be removed again with UNMAP_DEVICE_INTERRUPT when the interrupt
+ * is torn down.  tran_int_desc stays first: chip_data is used as a struct
+ * tran_int_desc throughout this driver.
+ */
+struct hv_msi_int_entry {
+	struct tran_int_desc		int_desc;
+	struct hv_interrupt_entry	hv_entry;
+};
+
+/* chip_data is passed around as a struct tran_int_desc *, so it must be first. */
+static_assert(offsetof(struct hv_msi_int_entry, int_desc) == 0);
+
+static void hv_vmbus_unmap_msi_interrupt(struct pci_dev *pdev __maybe_unused,
+					 void *chip_data)
+{
+	struct hv_msi_int_entry *ie = chip_data;
+
+	if (!ie || !ie->hv_entry.source)
+		return;
+#ifdef CONFIG_X86
+	hv_unmap_msi_interrupt(pdev, &ie->hv_entry);
+#endif
+	memset(&ie->hv_entry, 0, sizeof(ie->hv_entry));
+}
+
 /*
  * A generic message format for virtual PCI.
  * Specific message formats are defined later in the file.
@@ -715,16 +744,30 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 
 static void hv_arch_irq_unmask(struct irq_data *data)
 {
-	if (hv_root_partition())
+	if (hv_root_partition()) {
 		/*
 		 * In case of the nested root partition, the nested hypervisor
 		 * is taking care of interrupt remapping and thus the
 		 * MAP_DEVICE_INTERRUPT hypercall is required instead of
 		 * RETARGET_INTERRUPT.
+		 *
+		 * Keep the returned entry so the mapping can be removed again
+		 * when the interrupt is torn down.
 		 */
-		(void)hv_map_msi_interrupt(data, NULL);
-	else
+		struct hv_msi_int_entry *ie = data->chip_data;
+
+		/*
+		 * A NULL chip_data means hv_compose_msi_msg() failed and the
+		 * interrupt was never set up, so there is nothing to map.
+		 */
+		if (!ie)
+			return;
+
+		if (hv_map_msi_interrupt(data, &ie->hv_entry))
+			memset(&ie->hv_entry, 0, sizeof(ie->hv_entry));
+	} else {
 		hv_irq_retarget_interrupt(data);
+	}
 }
 #elif defined(CONFIG_ARM64)
 /*
@@ -1708,6 +1751,7 @@ static void hv_msi_free(struct irq_domain *domain, unsigned int irq)
 		return;
 	}
 
+	hv_vmbus_unmap_msi_interrupt(pdev, int_desc);
 	hv_int_desc_free(hpdev, int_desc);
 	put_pcichild(hpdev);
 }
@@ -1882,6 +1926,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	const struct cpumask *dest;
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
+	struct hv_msi_int_entry *int_entry;
 	struct msi_desc *msi_desc;
 	/*
 	 * vector_count should be u16: see hv_msi_desc, hv_msi_desc2
@@ -1932,9 +1977,10 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		hv_int_desc_free(hpdev, int_desc);
 	}
 
-	int_desc = kzalloc_obj(*int_desc, GFP_ATOMIC);
-	if (!int_desc)
+	int_entry = kzalloc_obj(*int_entry, GFP_ATOMIC);
+	if (!int_entry)
 		goto drop_reference;
+	int_desc = &int_entry->int_desc;
 
 	if (multi_msi) {
 		/*
@@ -2184,9 +2230,34 @@ static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq, unsigne
 	irq_domain_free_irqs_top(d, virq, nr_irqs);
 }
 
+/*
+ * Runs from irq_domain_deactivate_irq() during irq_shutdown(), before the
+ * parent (x86 vector) domain is deactivated and the (cpu, vector) is returned
+ * to the matrix allocator, so a freed vector can never collide with a stale
+ * hypervisor entry when it is reused.
+ */
+static void hv_pcie_domain_deactivate(struct irq_domain *d,
+				      struct irq_data *data)
+{
+	struct msi_desc *msi_desc;
+	struct pci_dev *pdev;
+
+	if (!hv_root_partition())
+		return;
+
+	msi_desc = irq_data_get_msi_desc(data);
+	if (!msi_desc)
+		return;
+
+	pdev = msi_desc_to_pci_dev(msi_desc);
+	if (pdev)
+		hv_vmbus_unmap_msi_interrupt(pdev, data->chip_data);
+}
+
 static const struct irq_domain_ops hv_pcie_domain_ops = {
-	.alloc	= hv_pcie_domain_alloc,
-	.free	= hv_pcie_domain_free,
+	.alloc		= hv_pcie_domain_alloc,
+	.free		= hv_pcie_domain_free,
+	.deactivate	= hv_pcie_domain_deactivate,
 };
 
 /**
-- 
2.53.0

