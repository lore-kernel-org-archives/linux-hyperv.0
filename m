Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A53BE172;
	Tue, 11 Aug 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463445; cv=none; b=L/4qVs5oX5gtzThbf0x7SV1h3CT8Zwc57xmeB5z7UCTc2KtN1MB8Z5uZYoMzfljk22JJWoOSOrjKm5p9LsLTbSrmtzpcEtq3dgYKdplTEQEvOYrJzAbLzvPJGc/xFbaSAPytsRb6OsMeLJFWBlDKIh4rvkb5bJEHXbKnykEvZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463445; c=relaxed/simple;
	bh=PmsTtDWwVeZ587oiX2TU05O5N2RtQxWwYzmt2BVnbUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2UFKu8HZsfwgbj2ru4oY5P/BPlqwvIQ1YJhRRKtqNoZwpKWqlPrVDp8P46t0DkGqUo5bVu45yXON72Bn5JkOYCAbRHXzoQ6+WgDr1slxNCF8Ym3zuCaf/J/4VagIg6nOjtjkflWnrpkbPoYXpWpY46XO7wJ5Kg6U1tiRJdOWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nxoXKmLk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nxoXKmLk"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F8C420B7128;
	Tue, 11 Aug 2026 08:50:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F8C420B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786463418;
	bh=bXQWaPBHQGrEQV8aeJa3lvQLgkcEl8hDrQei3AZ7a7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxoXKmLkTo/SvRNueKi6tTKdcNS92Pn5X7QRzcsfPnHY40zqGwwe5bI5WMCldhF42
	 Hi3SknBJWPj5gANk752iJOa8A6RqCa/Tk+f4R4xQIr9nVsNwk0bd5ovqNFQ1NV5wz2
	 ppIOm4ziegiwLq1xdMjutk3ClbKBrWXdud2uYZGg=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: wei.liu@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	arnd@arndb.de,
	jgg@ziepe.ca,
	mhklinux@outlook.com,
	jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: [PATCH v3 2/5] Drivers: hv: Add logical device ID registry for vPCI devices
Date: Tue, 11 Aug 2026 23:50:18 +0800
Message-ID: <20260811155022.108148-3-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hyper-V identifies each PCI pass-thru device by a logical device ID in
its hypercall interface. This ID consists of a per-bus prefix, derived
from the VMBus device instance GUID, combined with the PCI function
number of the endpoint device.

Add a registry in hv_common.c that maps a PCI domain number to its
logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
prefix when a bus is probed and unregisters it when the bus is removed.
Consumers such as the para-virtualized IOMMU driver look up the prefix
by PCI domain number and combine it with the function number to form the
complete logical device ID for hypercalls.

Use rhashtable for the sparse exact-match mapping. Lookups copy the
prefix while holding the RCU read lock, and removal defers freeing the
entry until existing readers have completed.

The prefix construction is shared via hv_build_logical_dev_id_prefix() so
that pci-hyperv's interrupt retargeting path and the registry use exactly
the same byte layout. It is derived on demand from the constant hv_device
instance GUID rather than cached in struct hv_pcibus_device, which is
private to the pci-hyperv module; this keeps the interface narrow and
avoids depending on pci-hyperv internals.

Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 drivers/hv/hv_common.c              | 123 ++++++++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c |  21 +++--
 include/asm-generic/mshyperv.h      |  14 ++++
 include/linux/hyperv.h              |   8 ++
 4 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6b67ac616789..b30495b48a37 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -21,6 +21,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/rhashtable.h>
 #include <linux/efi.h>
 #include <linux/kdebug.h>
 #include <linux/kmsg_dump.h>
@@ -78,6 +79,27 @@ static struct ctl_table_header *hv_ctl_table_hdr;
 u8 * __percpu *hv_synic_eventring_tail;
 EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
 
+#ifdef CONFIG_HYPERV_PVIOMMU
+struct hv_pci_busdata {
+	int pci_domain_nr;
+	u32 logical_dev_id_prefix;
+	struct rhash_head node;
+	struct rcu_head rcu;
+};
+
+static struct rhashtable hv_pci_bus_ht;
+static bool hv_pci_bus_ht_initialized;
+
+static const struct rhashtable_params hv_pci_bus_ht_params = {
+	.key_len		= sizeof_field(struct hv_pci_busdata,
+					       pci_domain_nr),
+	.key_offset		= offsetof(struct hv_pci_busdata,
+					   pci_domain_nr),
+	.head_offset		= offsetof(struct hv_pci_busdata, node),
+};
+
+#endif
+
 /*
  * Hyper-V specific initialization and shutdown code that is
  * common across all architectures.  Called from architecture
@@ -86,6 +108,13 @@ EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
 
 void __init hv_common_free(void)
 {
+#ifdef CONFIG_HYPERV_PVIOMMU
+	if (hv_pci_bus_ht_initialized) {
+		rhashtable_destroy(&hv_pci_bus_ht);
+		hv_pci_bus_ht_initialized = false;
+	}
+#endif
+
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
 
@@ -315,6 +344,9 @@ u8 __init get_vtl(void)
 int __init hv_common_init(void)
 {
 	int i;
+#ifdef CONFIG_HYPERV_PVIOMMU
+	int ret;
+#endif
 	union hv_hypervisor_version_info version;
 
 	/* Get information about the Microsoft Hypervisor version */
@@ -394,6 +426,15 @@ int __init hv_common_init(void)
 	for (i = 0; i < nr_cpu_ids; i++)
 		hv_vp_index[i] = VP_INVAL;
 
+#ifdef CONFIG_HYPERV_PVIOMMU
+	ret = rhashtable_init(&hv_pci_bus_ht, &hv_pci_bus_ht_params);
+	if (ret) {
+		hv_common_free();
+		return ret;
+	}
+	hv_pci_bus_ht_initialized = true;
+#endif
+
 	return 0;
 }
 
@@ -863,3 +904,85 @@ const char *hv_result_to_string(u64 status)
 	return "Unknown";
 }
 EXPORT_SYMBOL_GPL(hv_result_to_string);
+
+#ifdef CONFIG_HYPERV_PVIOMMU
+/*
+ * Logical device ID registry shared between the vPCI bus driver
+ * (pci-hyperv) and the para-virtualized IOMMU driver. The vPCI driver
+ * registers the per-bus logical device ID prefix at bus probe time, and
+ * the pvIOMMU driver looks it up to build the full logical device ID used
+ * in IOMMU hypercalls.
+ */
+int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix)
+{
+	struct hv_pci_busdata *bus, *new;
+	int ret = 0;
+
+	new = kzalloc_obj(*new, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	new->pci_domain_nr = pci_domain_nr;
+	new->logical_dev_id_prefix = logical_dev_id_prefix;
+
+	bus = rhashtable_lookup_get_insert_fast(&hv_pci_bus_ht, &new->node,
+						hv_pci_bus_ht_params);
+	if (IS_ERR(bus)) {
+		ret = PTR_ERR(bus);
+	} else if (bus) {
+		if (bus->logical_dev_id_prefix != logical_dev_id_prefix) {
+			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new 0x%08x)\n",
+			       pci_domain_nr, bus->logical_dev_id_prefix,
+			       logical_dev_id_prefix);
+			ret = -EEXIST;
+		}
+	} else {
+		goto out;
+	}
+
+	kfree(new);
+out:
+	return ret;
+}
+EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
+
+void hv_iommu_unregister_pci_bus(int pci_domain_nr)
+{
+	struct hv_pci_busdata *bus;
+	bool removed = false;
+
+	rcu_read_lock();
+	bus = rhashtable_lookup(&hv_pci_bus_ht, &pci_domain_nr,
+				hv_pci_bus_ht_params);
+	if (bus)
+		removed = !rhashtable_remove_fast(&hv_pci_bus_ht, &bus->node,
+						  hv_pci_bus_ht_params);
+	rcu_read_unlock();
+
+	if (removed)
+		kfree_rcu(bus, rcu);
+}
+EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
+
+/*
+ * Look up the logical device ID prefix registered for @pci_domain_nr.
+ * Returns 0 on success with *prefix filled in; -ENODEV if no entry is
+ * registered for that PCI domain.
+ */
+int hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix)
+{
+	struct hv_pci_busdata *bus;
+	int ret = -ENODEV;
+
+	rcu_read_lock();
+	bus = rhashtable_lookup(&hv_pci_bus_ht, &pci_domain_nr,
+				hv_pci_bus_ht_params);
+	if (bus) {
+		*prefix = bus->logical_dev_id_prefix;
+		ret = 0;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+#endif /* CONFIG_HYPERV_PVIOMMU */
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..0b12b18fe0f1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -641,10 +641,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
 	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
-	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
-			   (hbus->hdev->dev_instance.b[4] << 16) |
-			   (hbus->hdev->dev_instance.b[7] << 8) |
-			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
+	params->device_id = hv_build_logical_dev_id_prefix(hbus->hdev) |
 			   PCI_FUNC(pdev->devfn);
 	params->int_target.vector = hv_msi_get_int_vector(data);
 
@@ -3715,6 +3712,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	struct hv_pcibus_device *hbus;
 	int ret, dom;
 	u16 dom_req;
+	u32 prefix;
 	char *name;
 
 	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
@@ -3857,13 +3855,22 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	hbus->state = hv_pcibus_probed;
 
-	ret = create_root_hv_pci_bus(hbus);
+	/* Register the bus before scanning any devices on it. */
+	prefix = hv_build_logical_dev_id_prefix(hdev);
+
+	ret = hv_iommu_register_pci_bus(dom, prefix);
 	if (ret)
 		goto free_windows;
 
+	ret = create_root_hv_pci_bus(hbus);
+	if (ret)
+		goto unregister_pci_bus;
+
 	mutex_unlock(&hbus->state_lock);
 	return 0;
 
+unregister_pci_bus:
+	hv_iommu_unregister_pci_bus(dom);
 free_windows:
 	hv_pci_free_bridge_windows(hbus);
 exit_d0:
@@ -3977,6 +3984,8 @@ static void hv_pci_remove(struct hv_device *hdev)
 
 	hbus = hv_get_drvdata(hdev);
 	if (hbus->state == hv_pcibus_installed) {
+		int dom = hbus->bridge->domain_nr;
+
 		tasklet_disable(&hdev->channel->callback_event);
 		hbus->state = hv_pcibus_removing;
 		tasklet_enable(&hdev->channel->callback_event);
@@ -3994,6 +4003,8 @@ static void hv_pci_remove(struct hv_device *hdev)
 		hv_pci_remove_slots(hbus);
 		pci_remove_root_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
+
+		hv_iommu_unregister_pci_bus(dom);
 	}
 
 	hv_pci_bus_exit(hdev, false);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..4b3c9ba69cdb 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -73,6 +73,20 @@ extern enum hv_partition_type hv_curr_partition_type;
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
 
+#ifdef CONFIG_HYPERV_PVIOMMU
+int  hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix);
+void hv_iommu_unregister_pci_bus(int pci_domain_nr);
+int  hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix);
+#else
+static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
+					    u32 logical_dev_id_prefix)
+{
+	return 0;
+}
+
+static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
+#endif
+
 u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a2b484679eb4..7bc7b9b60002 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1287,6 +1287,14 @@ struct hv_device {
 #define device_to_hv_device(d)	container_of_const(d, struct hv_device, device)
 #define drv_to_hv_drv(d)	container_of_const(d, struct hv_driver, driver)
 
+static inline u32 hv_build_logical_dev_id_prefix(struct hv_device *hdev)
+{
+	return ((u32)hdev->dev_instance.b[5] << 24) |
+	       ((u32)hdev->dev_instance.b[4] << 16) |
+	       ((u32)hdev->dev_instance.b[7] << 8) |
+	       (hdev->dev_instance.b[6] & 0xf8u);
+}
+
 static inline void hv_set_drvdata(struct hv_device *dev, void *data)
 {
 	dev_set_drvdata(&dev->device, data);
-- 
2.52.0

