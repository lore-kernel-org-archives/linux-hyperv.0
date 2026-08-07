Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E8340280;
	Fri,  7 Aug 2026 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110714; cv=none; b=b7ukkTxG8++Wx8X2MSdPr22SOx7HGcq42OlwyQm1g8EBIA12CdVsIsXJHXH72WnJIw8ngufrxwPYuI7o3TMbOFCI9zSJ9fC4VBWyQwK1v0W/pN1i9uaNYqSKB8runZS9FmhRTmjqeLw+iHtdrcYc+Gt6AtIffbZc9vJ+O4Jx7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110714; c=relaxed/simple;
	bh=Yv0w9GrwxpyoHl9yuhY/ohLJHK8wdPjrfnUOXsPM0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMJvWorapaqmYlxswWRzl0ueMemsGlF4AuVMuC2PXUGMZfUIbaFMiOpy1ctF27TFOkTZLvls8gMuNH/xJqsYcVOAbJuoYev4o/n+eSe+knfGIs4xsl3IQ1d+Uy/e2Xlr3vWX2jnKa89hvpgMBBIzNOrV06fXnSR+PI2IgvFSA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YRBlDIYi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YRBlDIYi"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2E37820B7128;
	Fri,  7 Aug 2026 06:51:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E37820B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110685;
	bh=YHRFYx2XYEIuYgshIfof1pYsVKfd3f7KzoTVO1tv5YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRBlDIYipHHcCm7vYp0xkGykPU/zGpQb2FXYklapdM8XYwEErybUCAAoHqd/UAddc
	 tz+vQ5HLKYVHABCBIgiq2nO/RjGBHPIkvxX+28egkq5nwfrUniwIcjad7HBGx97JK8
	 WdvNcquN4GimRHiSkLV0H0hE866uBsPGfXW/Rj3c=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v1 01/13] mshv: add SEV-SNP UAPI definitions
Date: Fri,  7 Aug 2026 13:51:07 +0000
Message-ID: <20260807135134.303943-2-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807135134.303943-1-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Add the MSHV UAPI and Hyper-V ABI definitions needed by the SEV-SNP
partition ioctls: the SNP isolation type, GPA host-access and
isolated-page request structures, PSP request structures, and the SEV
control register definitions.

Also add the SNP launch-data definitions (guest policy, ID block, ID
auth info and launch-finish data) that form the isolated-import
completion parameters, along with the SNP support-status enumeration.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/hyperv/hvgdk_mini.h | 19 +++++++++++++
 include/hyperv/hvhdk.h      | 45 ++++++++++++++++++++++++++++++
 include/hyperv/hvhdk_mini.h | 53 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/mshv.h   | 55 +++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570f..a53c0f59994a 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -497,6 +497,9 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_UNMAP_VP_STATE_PAGE			0x00e2
 #define HVCALL_GET_VP_STATE				0x00e3
 #define HVCALL_SET_VP_STATE				0x00e4
+#define HVCALL_IMPORT_ISOLATED_PAGES			0x00ef
+#define HVCALL_COMPLETE_ISOLATED_IMPORT			0x00f1
+#define HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST		0x00f2
 #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
 #define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
 #define HVCALL_MMIO_READ				0x0106
@@ -1065,6 +1068,9 @@ enum hv_register_name {
 	HV_REGISTER_VSM_PARTITION_CONFIG	= 0x000D0007,
 
 #if defined(CONFIG_X86)
+	/* AMD SEV-SNP configuration register */
+	HV_X64_REGISTER_SEV_CONTROL				= 0x00090040,
+
 	/* X64 Debug Registers */
 	HV_X64_REGISTER_DR0	= 0x00050000,
 	HV_X64_REGISTER_DR1	= 0x00050001,
@@ -1267,6 +1273,18 @@ union hv_x64_pending_interruption_register {
 	} __packed;
 };
 
+#ifdef CONFIG_X86
+#define HV_SUPPORTS_SEV_SNP_GUESTS
+union hv_x64_register_sev_control {
+	u64 as_uint64;
+	struct {
+		u64 enable_encrypted_state : 1;
+		u64 reserved_z : 11;
+		u64 vmsa_gpa_page_number : 52;
+	} __packed;
+};
+#endif
+
 union hv_register_value {
 	struct hv_u128 reg128;
 	u64 reg64;
@@ -1286,6 +1304,7 @@ union hv_register_value {
 #ifdef CONFIG_X86
 	union hv_x64_interrupt_state_register interrupt_state;
 	union hv_x64_pending_interruption_register pending_interruption;
+	union hv_x64_register_sev_control sev_control;
 #endif
 	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
 };
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 0c89c62c9706..691ac495a095 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -953,4 +953,49 @@ struct hv_input_modify_sparse_spa_page_host_access {
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
 
+enum hv_isolated_page_type {
+	HV_ISOLATED_PAGE_TYPE_NORMAL,
+	HV_ISOLATED_PAGE_TYPE_VMSA,
+	HV_ISOLATED_PAGE_TYPE_ZERO,
+	HV_ISOLATED_PAGE_TYPE_UNMEASURED,
+	HV_ISOLATED_PAGE_TYPE_SECRETS,
+	HV_ISOLATED_PAGE_TYPE_CPUID,
+	HV_ISOLATED_PAGE_TYPE_COUNT
+};
+
+enum hv_isolated_page_size {
+	HV_ISOLATED_PAGE_SIZE_4KB,
+	HV_ISOLATED_PAGE_SIZE_2MB
+};
+
+struct hv_input_import_isolated_pages {
+	u64 partition_id;
+	u32 page_type;
+	u32 page_size;
+	u64 page_number[];
+} __packed;
+
+struct hv_input_issue_psp_guest_request {
+	u64 partition_id;
+	u64 request_page;
+	u64 response_page;
+} __packed;
+
+enum hv_partition_isolation_state {
+	HV_PARTITION_ISOLATION_INVALID,
+	HV_PARTITION_ISOLATION_INSECURE_CLEAN,
+	HV_PARTITION_ISOLATION_INSECURE_DIRTY,
+	HV_PARTITION_ISOLATION_SECURE,
+	HV_PARTITION_ISOLATION_SECURE_DIRTY,
+	HV_PARTITION_ISOLATION_SECURE_TERMINATING,
+};
+
+union hv_partition_isolation_control {
+	u64 as_uint64;
+	struct {
+		u64 runnable : 1;
+		u64 reserved_z : 63;
+	} __packed;
+};
+
 #endif /* _HV_HVHDK_H */
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index b4cb2fa26e9b..db83fedce243 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -94,6 +94,8 @@ enum hv_partition_property_code {
 
 	/* Resource properties */
 	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING		= 0x00050005,
+	HV_PARTITION_PROPERTY_ISOLATION_STATE			= 0x0005000c,
+	HV_PARTITION_PROPERTY_ISOLATION_CONTROL			= 0x0005000d,
 	HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION		= 0x00050017,
 
 	/* Compatibility properties */
@@ -145,6 +147,57 @@ enum hv_snp_status {
 	HV_SNP_STATUS_PSP_INIT_LATE_FAILED = 10,
 };
 
+union hv_snp_guest_policy {
+	struct {
+		u64 minor_version : 8;
+		u64 major_version : 8;
+		u64 smt_allowed : 1;
+		u64 vmpls_required : 1;
+		u64 migration_agent_allowed : 1;
+		u64 debug_allowed : 1;
+		u64 reserved : 44;
+	} __packed;
+	u64 as_uint64;
+};
+
+struct hv_snp_id_block {
+	u8 launch_digest[48];
+	u8 family_id[16];
+	u8 image_id[16];
+	u32 version;
+	u32 guest_svn;
+	union hv_snp_guest_policy policy;
+} __packed;
+
+struct hv_snp_id_auth_info {
+	u32 id_key_algorithm;
+	u32 auth_key_algorithm;
+	u8 reserved0[56];
+	u8 id_block_signature[512];
+	u8 id_key[1028];
+	u8 reserved1[60];
+	u8 id_key_signature[512];
+	u8 author_key[1028];
+} __packed;
+
+struct hv_psp_launch_finish_data {
+	struct hv_snp_id_block id_block;
+	struct hv_snp_id_auth_info id_auth_info;
+	u8 host_data[32];
+	u8 id_block_enabled;
+	u8 author_key_enabled;
+} __packed;
+
+union hv_partition_complete_isolated_import_data {
+	u64 reserved;
+	struct hv_psp_launch_finish_data psp_parameters;
+} __packed;
+
+struct hv_input_complete_isolated_import {
+	u64 partition_id;
+	union hv_partition_complete_isolated_import_data import_data;
+} __packed;
+
 enum hv_system_property {
 	/* Add more values when needed */
 	HV_SYSTEM_PROPERTY_SLEEP_STATE = 3,
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 32ff92b6342b..4e7f3038f0c6 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -36,6 +36,7 @@ enum {
 
 enum {
 	MSHV_PT_ISOLATION_NONE,
+	MSHV_PT_ISOLATION_SNP,
 	MSHV_PT_ISOLATION_COUNT,
 };
 
@@ -219,6 +220,55 @@ struct mshv_gpap_access_bitmap {
 	__u64 bitmap_ptr;
 };
 
+enum {
+	MSHV_GPA_HOST_ACCESS_BIT_ACQUIRE,
+	MSHV_GPA_HOST_ACCESS_BIT_READABLE,
+	MSHV_GPA_HOST_ACCESS_BIT_WRITABLE,
+	MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE,
+	MSHV_GPA_HOST_ACCESS_BIT_COUNT
+};
+
+#define MSHV_GPA_HOST_ACCESS_FLAGS_MASK \
+	((1 << MSHV_GPA_HOST_ACCESS_BIT_COUNT) - 1)
+
+struct mshv_modify_gpa_host_access {
+	__u8 flags;
+	__u8 rsvd[7];
+	__u64 page_count;
+	__u64 guest_pfns[];
+};
+
+enum {
+	MSHV_ISOLATED_PAGE_NORMAL,
+	MSHV_ISOLATED_PAGE_VMSA,
+	MSHV_ISOLATED_PAGE_ZERO,
+	MSHV_ISOLATED_PAGE_UNMEASURED,
+	MSHV_ISOLATED_PAGE_SECRETS,
+	MSHV_ISOLATED_PAGE_CPUID,
+	MSHV_ISOLATED_PAGE_COUNT
+};
+
+struct mshv_import_isolated_pages {
+	__u8 page_type;
+	__u8 rsvd[7];
+	__u64 page_count;
+	__u64 guest_pfns[];
+};
+
+struct mshv_issue_psp_guest_request {
+	__u64 req_gpa;
+	__u64 rsp_gpa;
+};
+
+struct mshv_sev_snp_ap_create {
+	__u64 vp_id;
+	__u64 vmsa_gpa;
+};
+
+struct mshv_complete_isolated_import {
+	union hv_partition_complete_isolated_import_data import_data;
+};
+
 /**
  * struct mshv_root_hvcall - arguments for MSHV_ROOT_HVCALL
  * @code: Hypercall code (HVCALL_*)
@@ -254,6 +304,11 @@ struct mshv_root_hvcall {
 #define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_gpap_access_bitmap)
 /* Generic hypercall */
 #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
+#define MSHV_MODIFY_GPA_HOST_ACCESS	_IOW(MSHV_IOCTL, 0x09, struct mshv_modify_gpa_host_access)
+#define MSHV_IMPORT_ISOLATED_PAGES	_IOW(MSHV_IOCTL, 0x0A, struct mshv_import_isolated_pages)
+#define MSHV_COMPLETE_ISOLATED_IMPORT	_IOW(MSHV_IOCTL, 0xF4, struct mshv_complete_isolated_import)
+#define MSHV_ISSUE_PSP_GUEST_REQUEST	_IOW(MSHV_IOCTL, 0xF5, struct mshv_issue_psp_guest_request)
+#define MSHV_SEV_SNP_AP_CREATE		_IOW(MSHV_IOCTL, 0xF6, struct mshv_sev_snp_ap_create)
 
 /*
  ********************************
-- 
2.43.0

