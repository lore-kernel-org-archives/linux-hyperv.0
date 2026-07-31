Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7B383C83;
	Fri, 31 Jul 2026 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537289; cv=none; b=tOFY3aqm1GZjBbEpZ+i/7ezSmSYpgyHBt00S0TMHaAVXmbriqpoYY/6nDxdNW+XQRVrET+QeJ9PblSUJb2fLxoy9aZWWPsR7YM7kwSObSqQwU0z4z4CzMirKFuU0KHeN4m7pLTlrDIfKnPsI9gErdrdmYPN2FnNuBmljvRGpiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537289; c=relaxed/simple;
	bh=QinLjdrHG7tpTexgN5LTAi8FMgIWi0QZadkzwgkc6qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1f9/xOiMC/8Sv6L8JiRgJn8nCL58PQtzatjFWuSYnUVSoTcMkN31UGz95C47OrR7ZLPn8qTBMwWKvplM9SzCW0FRj0rvyf61VQWYTQC9p5vNah9/iSkCZxnOyzuaSBnnEE2pIqsA9ZfvcvuZQI8o/zcB56YcfPmacEmN79zQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mAzb+qe1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mAzb+qe1"
Received: from mrdev.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 70A7720B716B;
	Fri, 31 Jul 2026 15:34:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70A7720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785537269;
	bh=1I2WdTUqOuf9JU5Q89Ev0MAW1iXFtnGBGr5MppYA0aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAzb+qe1xaIbXVla5J98rQ6Nu4Bq25hSjDm8pd36n+WCyb+soAkrL0cUzPvl9xf4U
	 yV1ydyy850s6ILWyg5ZrfHhcJVvXjxkpwVLgigN5KOXEQxoYxicQJDXY2tK+5WTIf3
	 IIGZNQ6pdP9QJyuGt9A9L+kOaWiR8pXV7j5JC1Qo=
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
Cc: jgg@nvidia.com,
	kys@microsoft.com,
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
Subject: [PATCH v5 5/9] mshv: Import data structs around device passthru from hyperv headers
Date: Fri, 31 Jul 2026 15:34:23 -0700
Message-ID: <20260731223427.2554388-6-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy/import from Hyper-V public headers, definitions and declarations that
are related to creating domains in the hypervisor, attaching devices to
them, etc.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h |  8 +++++
 include/hyperv/hvhdk_mini.h | 67 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570f..e62f8d708e8e 100644
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
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index b4cb2fa26e9b..90497635c3cb 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -547,4 +547,71 @@ union hv_device_id {		/* HV_DEVICE_ID */
 	} acpi;
 } __packed;
 
+/* 3 domain types: stage 1, stage 2, and SOC */
+#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
+#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
+#define HV_DEVICE_DOMAIN_TYPE_SOC 2 /* HV_DEVICE_DOMAIN_ID_TYPE_SOC */
+
+/* ID for stage 2 default domain and NULL domain */
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

