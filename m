Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0E81AA797;
	Fri, 21 Aug 2026 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318829; cv=none; b=TvAlLE6k6dkuACXfjgXLBtKXRrcLKSUuQBvGQdqiArD9put+wHeN8kPyfGZnSZoLYoFQqNRJ6it/tV4Zvl0APNYW9+mjLjUwsytoskjKA73HXhGEVKL3C1Ei1bQqHbYe3yQgkaX5wDT01cxukguvUsfHu/jQUpVuoOFlyppQJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318829; c=relaxed/simple;
	bh=6Vfpzsw3SeB16EA5KLIGHrlHoYhDS+tauAhAAxCd0Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHc0ZjGfspgW7sT29kpxg5EDpJE4RZ/Pf6oEbnzU4xx1ZF24oqOSbYzB188zeIQBEOriODJqdFVM3Ojs24fCAJagIAGyvFLAWLgUa0S1EryD1CJoRhpe3g5cz+5gvUA7Hau+HMWChrtNgJFV/SlVwVOzf+1y6+zIdjN2IoAb2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jAtbFKxL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jAtbFKxL"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81B0E20B7129;
	Fri, 21 Aug 2026 06:26:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81B0E20B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787318797;
	bh=ux8RO7E/y/j6zQsMHCqKLLUZFACoBgCCaLiU1gCSyFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAtbFKxLwqHbfCrnpffPw+fphRSQdoC3UzaFpapeTV25Wkf/fR6Vfqb4hM0YnWxKw
	 bip9izxvYkOrB++d1xhZRFXzWNdaTkpElg54wAz7gMyNTH2vUMoKl2uW+HK49ffiHW
	 5a2lYLtIeg/oE2KFSdUgoF5/7fdjJlioGQr76Kqs=
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
Subject: [PATCH v4 1/5] hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU
Date: Fri, 21 Aug 2026 21:26:50 +0800
Message-ID: <20260821132654.211730-2-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
Introduce the hypercalls used by the child partition to interact with
this facility.

These hypercalls fall into below categories:
- Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
  detect the existence and capabilities of the guest IOMMU.

- Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
  check whether an endpoint device is managed by the guest IOMMU.

- Domain management: A set of hypercalls is provided to handle the
  creation, configuration, and deletion of guest domains, as well as
  the attachment/detachment of endpoint devices to/from those domains.

- IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
  for a domain-selective IOTLB flush (which in its handler may flush
  the device TLB as well).

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/hv/hv_common.c      |   1 +
 include/hyperv/hvgdk_mini.h |   9 +++
 include/hyperv/hvhdk_mini.h | 137 ++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6b67ac616789..b5d2d6cd65ae 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -810,6 +810,7 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
 	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
+	_STATUS_INFO(HV_STATUS_DEVICE_ALREADY_IN_DOMAIN,	-EEXIST),
 	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
 	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
 	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570f..5d1338197eee 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -37,6 +37,7 @@ struct hv_u128 {
 #define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED	0x20
 #define HV_STATUS_INVALID_LP_INDEX			0x41
 #define HV_STATUS_INVALID_REGISTER_VALUE		0x50
+#define HV_STATUS_DEVICE_ALREADY_IN_DOMAIN		0x66
 #define HV_STATUS_OPERATION_FAILED			0x71
 #define HV_STATUS_INSUFFICIENT_ROOT_MEMORY		0x73
 #define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY	0x75
@@ -486,10 +487,16 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
+#define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
+#define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
 #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
 #define HVCALL_DISPATCH_VP				0x00c2
+#define HVCALL_DETACH_DEVICE_DOMAIN			0x00c4
+#define HVCALL_DELETE_DEVICE_DOMAIN			0x00c5
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
+#define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
+#define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
 #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
 #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
@@ -502,6 +509,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
 #define HVCALL_DISABLE_HYP_EX                           0x010f
+#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
+#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY		0x0127
 #define HVCALL_MAP_STATS_PAGE2				0x0131
 
 /* HV_HYPERCALL_INPUT */
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 035ba20870f7..7b9f43b320cd 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -548,4 +548,141 @@ union hv_device_id {		/* HV_DEVICE_ID */
 	} acpi;
 } __packed;
 
+/* Device domain types */
+#define HV_DEVICE_DOMAIN_TYPE_S1	1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
+
+/* ID for default domain and NULL domain */
+#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
+#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
+
+union hv_device_domain_id {	/* HV_DEVICE_DOMAIN_ID */
+	u64 as_uint64;
+	struct {
+		u32 type: 4;
+		u32 reserved: 28;
+		u32 id;
+	} __packed;
+};
+
+struct hv_input_device_domain {	/* HV_INPUT_DEVICE_DOMAIN */
+	u64 partition_id;
+	union hv_input_vtl owner_vtl;
+	u8 padding[7];
+	union hv_device_domain_id domain_id;
+} __packed;
+
+/* HV_CREATE_DEVICE_DOMAIN_FLAGS */
+union hv_create_device_domain_flags {
+	u32 as_uint32;
+	struct {
+		u32 forward_progress_required: 1;
+		u32 inherit_owning_vtl: 1;
+		u32 reserved: 30;
+	} __packed;
+};
+
+/* HV_INPUT_CREATE_DEVICE_DOMAIN */
+struct hv_input_create_device_domain {
+	struct hv_input_device_domain device_domain;
+	union hv_create_device_domain_flags create_device_domain_flags;
+	u32 padding;
+} __packed;
+
+/* HV_INPUT_DELETE_DEVICE_DOMAIN */
+struct hv_input_delete_device_domain {
+	struct hv_input_device_domain device_domain;
+} __packed;
+
+/* HV_INPUT_ATTACH_DEVICE_DOMAIN */
+struct hv_input_attach_device_domain {
+	struct hv_input_device_domain device_domain;
+	union hv_device_id device_id;
+} __packed;
+
+/* HV_INPUT_DETACH_DEVICE_DOMAIN */
+struct hv_input_detach_device_domain {
+	u64 partition_id;
+	union hv_device_id device_id;
+} __packed;
+
+struct hv_device_domain_settings {	/* HV_DEVICE_DOMAIN_SETTINGS */
+	struct {
+		/*
+		 * Enable translations. If not enabled, all transaction bypass
+		 * S1 translations.
+		 */
+		u64 translation_enabled: 1;
+		u64 blocked: 1;
+		/*
+		 * First stage address translation paging mode:
+		 * 0: 4-level paging (default)
+		 * 1: 5-level paging
+		 */
+		u64 first_stage_paging_mode: 1;
+		u64 reserved: 61;
+	} flags;
+
+	/* Address of translation table */
+	u64 page_table_root;
+} __packed;
+
+/* HV_INPUT_CONFIGURE_DEVICE_DOMAIN */
+struct hv_input_configure_device_domain {
+	struct hv_input_device_domain device_domain;
+	struct hv_device_domain_settings settings;
+} __packed;
+
+/* HV_INPUT_GET_IOMMU_CAPABILITIES */
+struct hv_input_get_iommu_capabilities {
+	u64 partition_id;
+	u64 reserved;
+} __packed;
+
+/* HV_OUTPUT_GET_IOMMU_CAPABILITIES */
+struct hv_output_get_iommu_capabilities {
+	u32 size;
+	u16 reserved;
+	u8  max_iova_width;
+	u8  max_pasid_width;
+
+#define HV_IOMMU_CAP_PRESENT    BIT_ULL(0)
+#define HV_IOMMU_CAP_S2         BIT_ULL(1)
+#define HV_IOMMU_CAP_S1         BIT_ULL(2)
+#define HV_IOMMU_CAP_S1_5LVL    BIT_ULL(3)
+#define HV_IOMMU_CAP_PASID      BIT_ULL(4)
+#define HV_IOMMU_CAP_ATS        BIT_ULL(5)
+#define HV_IOMMU_CAP_PRI        BIT_ULL(6)
+
+	u64 iommu_cap;
+	u64 pgsize_bitmap;
+} __packed;
+
+/* HV_LOGICAL_DEVICE_PROPERTY_CODE */
+enum hv_logical_device_property_code {
+	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,
+};
+
+/* HV_INPUT_GET_LOGICAL_DEVICE_PROPERTY */
+struct hv_input_get_logical_device_property {
+	u64 partition_id;
+	u64 logical_device_id;
+	/* Takes values from enum hv_logical_device_property_code. */
+	u32 code;
+	u32 reserved;
+} __packed;
+
+/* HV_OUTPUT_GET_LOGICAL_DEVICE_PROPERTY */
+struct hv_output_get_logical_device_property {
+#define HV_DEVICE_IOMMU_ENABLED	BIT_ULL(0)
+	u64 device_iommu;
+	u64 reserved;
+} __packed;
+
+/* HV_INPUT_FLUSH_DEVICE_DOMAIN */
+struct hv_input_flush_device_domain {
+	struct hv_input_device_domain device_domain;
+	u32 flags;
+	u32 reserved;
+} __packed;
+
 #endif /* _HV_HVHDK_MINI_H */
-- 
2.52.0

