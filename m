Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4D33ADB0;
	Thu,  2 Jul 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008337; cv=none; b=fLYo3kS3eM71W38YVCNAkRvAtUDeQRB+8Kfffxozxnkq5quWXHMvfsGZbj4m+51tjyBZvUdguwTP7G5BriqvHQP4wHkPSDAGpG3TKoLkT+BQsZ4MsWEQZlB0mc14ae5H1xwH5jVFWsPEj3LDB7j18q8F3t3H+gfg4+PA0R0YTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008337; c=relaxed/simple;
	bh=vjoTjie2O7ZGMlCOftReONukFoAZ14XBp63OAy0AjVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1utaiELmiRtHjKbBQh6kaST9DGGBIcKPiviZeCx44jcQ7Ynfkx3TYc40RgYc1ZFL6aGTCmvlNVKtnvPAB88KkFvr7G5Gwpdz5B0p8TAdNhEwgd8AZC0ESJYJ2jJPiTROUKjzm6IYOZ3uMOMPQ0ZthnqY+NynkdG/Ud3Qc8oHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ChWCX95I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ChWCX95I"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 094B720B7167;
	Thu,  2 Jul 2026 09:05:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 094B720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783008333;
	bh=WrcfTg8KsU8NEoczlwTZsmDvDFPTZv8oQiMLw35u6NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChWCX95IZKSw1JAS7Bke9wxH8dplO9KncgflqzfLXqfhJLybu/i7herQxhIYyND43
	 3U3d1v9Aol0xrEcKXLROSPeLmmA4wTmWVvze1GEYootGmpUSb3HElgjH2zX76UQoIL
	 POZCjkTwFIOBLoALs4/aE2S3MEOW8/YonLwTUnDA=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
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
	mrathor@linux.microsoft.com
Subject: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for vPCI devices
Date: Fri,  3 Jul 2026 00:05:16 +0800
Message-ID: <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Hyper-V identifies each PCI pass-thru device by a logical device ID in
its hypercall interface. This ID consists of a per-bus prefix, derived
from the VMBus device instance GUID, combined with the PCI function
number of the endpoint device.

Add a small registry in hv_common.c that maps a PCI domain number to its
logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
prefix when a bus is probed and unregisters it when the bus is removed.
Consumers such as the para-virtualized IOMMU driver look up the prefix
by PCI domain number and combine it with the function number to form the
complete logical device ID for hypercalls.

The prefix construction is shared via hv_build_logical_dev_id_prefix() so
that pci-hyperv's interrupt retargeting path and the registry use exactly
the same byte layout. It is derived on demand from the constant hv_device
instance GUID rather than cached in struct hv_pcibus_device, which is
private to the pci-hyperv module; this keeps the interface narrow and
avoids depending on pci-hyperv internals.

Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 drivers/hv/hv_common.c              | 95 +++++++++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 21 +++++--
 include/asm-generic/mshyperv.h      | 13 ++++
 include/linux/hyperv.h              |  8 +++
 4 files changed, 132 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6b67ac616789..53493f8d14dc 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -26,6 +26,8 @@
 #include <linux/kmsg_dump.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/dma-map-ops.h>
 #include <linux/set_memory.h>
 #include <hyperv/hvhdk.h>
@@ -863,3 +865,96 @@ const char *hv_result_to_string(u64 status)
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
+struct hv_pci_busdata {
+	int		 pci_domain_nr;
+	u32		 logical_dev_id_prefix;
+	struct list_head list;
+};
+
+static LIST_HEAD(hv_pci_bus_list);
+static DEFINE_SPINLOCK(hv_pci_bus_lock);
+
+int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix)
+{
+	struct hv_pci_busdata *bus, *new;
+	int ret = 0;
+
+	new = kzalloc_obj(*new, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	spin_lock(&hv_pci_bus_lock);
+	list_for_each_entry(bus, &hv_pci_bus_list, list) {
+		if (bus->pci_domain_nr != pci_domain_nr)
+			continue;
+
+		if (bus->logical_dev_id_prefix != logical_dev_id_prefix) {
+			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new 0x%08x)\n",
+			       pci_domain_nr, bus->logical_dev_id_prefix,
+			       logical_dev_id_prefix);
+			ret = -EEXIST;
+		}
+
+		goto out_free;
+	}
+
+	new->pci_domain_nr = pci_domain_nr;
+	new->logical_dev_id_prefix = logical_dev_id_prefix;
+	list_add(&new->list, &hv_pci_bus_list);
+	spin_unlock(&hv_pci_bus_lock);
+	return 0;
+
+out_free:
+	spin_unlock(&hv_pci_bus_lock);
+	kfree(new);
+	return ret;
+}
+EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
+
+void hv_iommu_unregister_pci_bus(int pci_domain_nr)
+{
+	struct hv_pci_busdata *bus, *tmp;
+
+	spin_lock(&hv_pci_bus_lock);
+	list_for_each_entry_safe(bus, tmp, &hv_pci_bus_list, list) {
+		if (bus->pci_domain_nr == pci_domain_nr) {
+			list_del(&bus->list);
+			kfree(bus);
+			break;
+		}
+	}
+	spin_unlock(&hv_pci_bus_lock);
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
+	spin_lock(&hv_pci_bus_lock);
+	list_for_each_entry(bus, &hv_pci_bus_list, list) {
+		if (bus->pci_domain_nr == pci_domain_nr) {
+			*prefix = bus->logical_dev_id_prefix;
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&hv_pci_bus_lock);
+	return ret;
+}
+#endif /* CONFIG_HYPERV_PVIOMMU */
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..58ca2c95bd10 100644
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
+	/* Notify pvIOMMU before any device on the bus is scanned. */
+	prefix = hv_build_logical_dev_id_prefix(hdev);
+
+	ret = hv_iommu_register_pci_bus(dom, prefix);
 	if (ret)
 		goto free_windows;
 
+	ret = create_root_hv_pci_bus(hbus);
+	if (ret)
+		goto unregister_pviommu;
+
 	mutex_unlock(&hbus->state_lock);
 	return 0;
 
+unregister_pviommu:
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
index bf601d67cecb..f65344f2bb81 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -73,6 +73,19 @@ extern enum hv_partition_type hv_curr_partition_type;
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
+static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
+#endif
+
 u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9de2c8d6037a..10ee2c462d7c 100644
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

