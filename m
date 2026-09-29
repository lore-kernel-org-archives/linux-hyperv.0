Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B543D647C;
	Tue, 29 Sep 2026 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721399; cv=none; b=gdyenNX4VO+o4d93Oo6NdZwHmCp9O81ocS+p9UJw5omRM16wTcwPM7KFVL2LileFOhewOnfsk8A3Wv0cSdtqmDIEwiBAKqQdzRXAOdEFZ1awC7HS23I2sYTpG1z/doPwzXTlNDdaDE2pISsWC43QShkRx3gfngV7XGPetJMV9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721399; c=relaxed/simple;
	bh=Ymf/cgNOvtF8j7qbvczslQ4pKC6Lx1W98l3M/V1vP2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKErOOxrhvn3+5SM4sUV5WlplyIgOqXWFWPDQ7EEUxw3Y0qDBXoQQKFS9+DKE1G+g7TnK034CI17Z62Im/J0Q0/yxOTxOVjmf2PPO+k+8qiC2AcLVGZyRe2j5Ag6zU7k7ebReORs4cj5/SBONndMGqryUQdfC6izbt2jIdmo0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gVgS3iK4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gVgS3iK4"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2584020B716D;
	Tue, 29 Sep 2026 15:35:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2584020B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790721344;
	bh=FUH5ngTZgAQ97CtC2m8tO43RnFT+/gvng8S29Lw4Qso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVgS3iK45fZiK2yx7MyKjUuFX2rYX5l0iu/PpmCFmKTrPrqH5xdKl3YfHARpVHMop
	 WKK5WbxF66h3hkFhq/AjpD4HGwC63c8DDtpKtDS7OlwJRrIYjyDk8vyDJ0u/po2SYd
	 f8MnPTpcXeWdvPXViOhy2eEONCqTQgooUkqlEq84=
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
Subject: [PATCH V2 3/4] mshv: Import data structs around device domains from hyperv headers
Date: Tue, 29 Sep 2026 15:36:21 -0700
Message-ID: <20260929223622.778617-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260929223622.778617-1-mrathor@linux.microsoft.com>
References: <20260929223622.778617-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy/import from Hyper-V public headers, definitions and declarations that
are related to creating iommu domains in the hypervisor, attaching devices
to them, doing the reverse, etc.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h |  9 ++++
 include/hyperv/hvhdk_mini.h | 87 +++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570f..3b74f3c0229d 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -326,6 +326,8 @@ union hv_hypervisor_version_info {
 /* stimer Direct Mode is available */
 #define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
 
+#define HV_DEVICE_DOMAIN_AVAILABLE			BIT(24)
+
 /*
  * Implementation recommendations. Indicates which behaviors the hypervisor
  * recommends the OS implement for optimal performance.
@@ -486,9 +488,15 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
+#define HVCALL_CREATE_DEVICE_DOMAIN                     0x00b1
+#define HVCALL_ATTACH_DEVICE_DOMAIN                     0x00b2
+#define HVCALL_MAP_DEVICE_GPA_PAGES                     0x00b3
+#define HVCALL_UNMAP_DEVICE_GPA_PAGES                   0x00b4
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
 #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
 #define HVCALL_DISPATCH_VP				0x00c2
+#define HVCALL_DETACH_DEVICE_DOMAIN                     0x00c4
+#define HVCALL_DELETE_DEVICE_DOMAIN                     0x00c5
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
 #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
 #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
@@ -502,6 +510,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
 #define HVCALL_DISABLE_HYP_EX                           0x010f
+#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
 #define HVCALL_MAP_STATS_PAGE2				0x0131
 
 /* HV_HYPERCALL_INPUT */
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 035ba20870f7..3dbfb338bcba 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -548,4 +548,91 @@ union hv_device_id {		/* HV_DEVICE_ID */
 	} acpi;
 } __packed;
 
+#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
+#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
+
+#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
+#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
+
+union hv_device_domain_id {
+	u64 as_uint64;
+	struct {
+		u32 type : 4;
+		u32 reserved : 28;
+		u32 id;
+	};
+} __packed;
+
+struct hv_input_device_domain { /* HV_INPUT_DEVICE_DOMAIN */
+	u64 partition_id;
+	union hv_input_vtl owner_vtl;
+	u8 padding[7];
+	union hv_device_domain_id domain_id;
+} __packed;
+
+union hv_create_device_domain_flags {	/* HV_CREATE_DEVICE_DOMAIN_FLAGS */
+	u32 as_uint32;
+	struct {
+		u32 forward_progress_required : 1;
+		u32 inherit_owning_vtl : 1;
+		u32 reserved : 30;
+	} __packed;
+} __packed;
+
+struct hv_input_create_device_domain {	/* HV_INPUT_CREATE_DEVICE_DOMAIN */
+	struct hv_input_device_domain device_domain;
+	union hv_create_device_domain_flags create_device_domain_flags;
+} __packed;
+
+struct hv_input_delete_device_domain {	/* HV_INPUT_DELETE_DEVICE_DOMAIN */
+	struct hv_input_device_domain device_domain;
+} __packed;
+
+struct hv_input_attach_device_domain {	/* HV_INPUT_ATTACH_DEVICE_DOMAIN */
+	struct hv_input_device_domain device_domain;
+	union hv_device_id device_id;
+} __packed;
+
+struct hv_input_detach_device_domain {	/* HV_INPUT_DETACH_DEVICE_DOMAIN */
+	u64 partition_id;
+	union hv_device_id device_id;
+} __packed;
+
+/* HV_INPUT_GET_IOMMU_CAPABILITIES */
+struct hv_input_get_iommu_capabilities {
+	u64 partition_id;
+	u64 reserved;
+} __packed;
+
+#define HV_IOMMU_CAP_PRESENT    BIT_ULL(0)
+#define HV_IOMMU_CAP_S2         BIT_ULL(1)
+#define HV_IOMMU_CAP_S1         BIT_ULL(2)
+#define HV_IOMMU_CAP_S1_5LVL    BIT_ULL(3)
+#define HV_IOMMU_CAP_PASID      BIT_ULL(4)
+#define HV_IOMMU_CAP_ATS        BIT_ULL(5)
+#define HV_IOMMU_CAP_PRI        BIT_ULL(6)
+
+struct hv_output_get_iommu_capabilities { /* HV_OUTPUT_GET_IOMMU_CAPABILITIES */
+	u32 size;
+	u16 reserved;
+	u8  max_iova_width;
+	u8  max_pasid_width;
+	u64 iommu_cap;          /* HV_IOMMU_CAP_* above */
+	u64 pgsize_bitmap;
+} __packed;
+
+struct hv_input_map_device_gpa_pages {	/* HV_INPUT_MAP_DEVICE_GPA_PAGES */
+	struct hv_input_device_domain device_domain;
+	union hv_input_vtl target_vtl;
+	u8 padding[3];
+	u32 map_flags;
+	u64 target_device_va_base;
+	u64 gpa_page_list[];
+} __packed;
+
+struct hv_input_unmap_device_gpa_pages {  /* HV_INPUT_UNMAP_DEVICE_GPA_PAGES */
+	struct hv_input_device_domain device_domain;
+	u64 target_device_va_base;
+} __packed;
+
 #endif /* _HV_HVHDK_MINI_H */
-- 
2.51.2.vfs.0.1

