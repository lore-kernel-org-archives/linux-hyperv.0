Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938278;
	b=YykADMvzt7K2QJGaEu4FHaRweWThEAiXFj1xs7mlIeZtYAvc5ZYQaF8YjO7hJ/etU+Y3
	 X2Tw/L6Ll81OEIJW66Gqp+iGYT1umav2+6mfZ+DJudqF3r91QbEsyvbBaeBGf1lgTPGC8
	 nutrKPvtu5PjlZs6uyAR4UJe+ezh7c0eaMimAjV1NP8ys4l43V0vYZejfLb0KaKYM9+Jo
	 LLDpiyhUP9H1nnmx6pr+OKjDoRQpPEfcpLxHF2ednfHf4ENBQKwq+je4e0+aMFgxfi6va
	 KeOUISEFbFUFqnaN4BuGfyPrBIABtsiaGJlMHJqOvu9BZjOsH2V4+EGhSXTJsH+YUYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938278;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=b0Ov2p5FPI/lgBjwf0ajDG/r8K0qvYi9DcGhQ6mnXeo=;
	b=HuvzvGVZkEV9En8ZXJheQNnGGNF1s7PsAeo0eWdeEjthM9le0F32aAwnLstGCH1B/7JG
	 SvtlcdM1NE/rzZwjYmXXhsq264pNjQFDu/rLRk9EGDPkd01M1JHUcIpJ4QXFjjz+lVhuw
	 HyVb+0aES1+2wkaQTI8kZ+CbjxUya2+NXAfUfz4My1d6pZCGKq836pOKEQSJaGmhtpXiB
	 bfM25h1gndHwO5Pw2Ww1cipIOgKVozst7QkfCi41qyl7OkoH+J6QFcphf3ycToE2b6AWr
	 6S5nluHNh8HgmPd9BUIa0ggfCelHbgqsKPqnvHRgXy3Z0nNY3SNTRudwRKmYRVXv2WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N6fNJteq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.30
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF9606A32A;
	Tue, 17 Nov 2026 17:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBF9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N6fNJteq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmZhdrGjJt0p9GussqL0IGh5xOFuldXjS73LZABuh3GD9iF6TzFKKXJYfco431GfhrX11bXwMR8+RJAFhXsE1bToSYbYvS6bPgzzZB1uUARS0BaTYxBGEXmYBDa4KJOZctMWr619qnIqxqKWag3bCaarMyW+O2kuEQy6YCRzwtgOx75i9rQjvdXrFXeeQRgWKQ/6gbZzhym8Qy+C+Z7NpD+yIl7lKHQE3im4wg+XwSXwLtfvkAee7aB+PfERCWETaL5nDNBoVYsKNNp/6gRM/lAxQc7dOKZ4TB33zb3Exps+giPq6gq/cxeN0klf3iUtFhwxDIQQnhl+I057yxFCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0Ov2p5FPI/lgBjwf0ajDG/r8K0qvYi9DcGhQ6mnXeo=;
 b=jxfdCUwe+iTDg2dtY7gFaYEWLmE1GhHat1tT9whR42e4QUKCM850JgSjdohtK+jKs8Xb4OTS0I/1cW7rDvNpE8CUA11kwoO5a7P2ZsILICHTDtcyblo8mIo1lzcnnnMw7HoCRFsn0fuu56hIH60LtzauEKvBxX7Cx13b60aIOCXKXmHL9F6jJz1HhlvNcLRXGkBqYB1cyJz850bUUcWGpm63sMT8ujbJVqivFxFo4RO3ZrwMkBPbkMDuDE3tx/4ZVIXwFQtD9kFkJ8UoYyXMCXtFD3o12/UvjSJ5JHZxNWTK0An4b5QtgnwzaRj897daD6aFno7ZO48qO9Ikl34Uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0Ov2p5FPI/lgBjwf0ajDG/r8K0qvYi9DcGhQ6mnXeo=;
 b=N6fNJteqV6TD0/HLO1dTXuDJrmpeiX6Af4xTuE01phXbn2+amf23JT7q+LTGX7J325rJ1ErkBfkEQedTT7kC70e8FxogUhnFwe8kdwDXvg0Aecj+fnfRIxQ3JFcQxiDK8mdr6Sb6i4a3Be6/wfm/+uSBxmLOLJ4JyVJaRhhlDN0=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by SA3PR12MB196577.namprd12.prod.outlook.com (2603:10b6:806:533::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:57:53 +0000
Received: from MW2PEPF00014675.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::99) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 17:57:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014675.mail.protection.outlook.com (10.167.249.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:57:52 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:57:49 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <haiyangz@microsoft.com>,
	<wei.liu@kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v5 2/3] x86/sev: Add guest support for Enhanced SMT Protection
Date: Tue, 17 Nov 2026 17:56:59 +0000
Message-ID: <4dd1bdbceacf5ebbde07899f8b20e052435ee2eb.1794935627.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794935627.git.prsampat@amd.com>
References: <cover.1794935627.git.prsampat@amd.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014675:EE_|SA3PR12MB196577:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a9017f-0728-404d-caf4-08df44d44d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	c62oRI9dxDw42jNDwgGf26b3OnR3au3B61VO5wPGhHJvQAzRSNryL0N6mSh2ekb7Pvh/nw7dKVmyKkhZ/4jpBr4lxOjSYz3iyKriN2siESJi+hAlgzQzQSBV/FKd9l+A04h2gI+3OWSQDmyWdbOeZfSYPra4osFQtQlC3+3FmxMZ6G3yh/t+JAHRysh4fLKjuODiAuNWDQCJPg4gn/DV7pexdIIQyVgFEOQsHcdcnPueUh4peEVXzIfSJsNWA+bKWsC6wQ0h14/DrBGZrUvFEwL7ej2mV43gwjukTSyzDXj6eycWvgQbH2iwEL+SR06X6GUOLmvPTC7eW289J5eqoWfDh2uAO5gB4h5R7/Iv5J0QarnA5OANrMo7H1y3HkeMKY0r751SyY91L7Rz8+wmOBCxJNbEO4vp/1PX98FkXhearoeOxmOfP9KtVBJD8/rweP5xh06+0MQsQq5do1NayyA5mR8XTfaP/GG359f2WpM/xdmg8D6hqCJumBSLufAyIEyVJIr4Fiee79L4IDT7MZzn1vxVtgL/6AQRL9qsDyKjakHmTpxMao08+fiLOFnDyYBmSM8Kt7U/tJr/twdXuEn/fXtgHU0tCVy0VFeS6RHlY8ulTWiisK6uEeVT9LVNlXMDQ37o626lzAQ1Uu3qga7rwO8XHovNZnj9RAV0FVZyFzJ9EkfE6l9Ab7G4hbxj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AMI8cDyspoeNn76yVlyIwihFf0R6HFHOke6Fzilr1llwHntg9++M6On7DaiHRZbOXdzV+BYvgh/debOAJNP8dn3dgQKgtlA66bwtNknjSDSCSqWVZFdoz3pNZAaVf+cSIBg5Dg0IFDlrk1mxYL8/l4UdeVCOH03PA0s12APN7hwOxTvfwhxQEh4p2IOd3Sx4eJiqs2Vvk7KyuTHe2JOFY6DHN5t7uNoZXXixeMMN6XauhwRWanNdqudlJbjaMWV52cfN9o08WYCuE6ghjuqwzj+PoAHf4geCMPwkMhaBX8q5X+VZbCBbjvmtH69ChbAqSM8qBIIccVatRi01SZiuGZKfO6M9PNn5wjrJ444pV3OO/uhCGEvUTDwtGfOie5OdPQ72GEi4ODM8hBpk/ThPGeb5gtJDKuA6hQhtlXD5Wibavddq/rdizudFBwUEVajb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:57:52.9516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a9017f-0728-404d-caf4-08df44d44d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014675.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB196577

Enhanced SMT Protection requires every VMSA to carry the vCPU's identity
and the mask of SMT siblings it may co-run with. The guest builds the
VMSA itself when bringing up an AP, so populate both fields there, before
the page is turned into a VMSA and while it is still writable.

Fully set the sibling mask so that all threads of the same guest trust
each other.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v4..v5:
* Remove comment about vCPU sibling mask configuration - Boris

v3..v4: No change
---
 arch/x86/boot/compressed/sev.c   | 6 ++++--
 arch/x86/coco/sev/core.c         | 7 +++++++
 arch/x86/include/asm/msr-index.h | 4 +++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c6512f2ea31e..4e0fa5a5f70b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -188,7 +188,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
 				 MSR_AMD64_SNP_SECURE_AVIC |		\
-				 MSR_AMD64_SNP_RESERVED_BITS19_22 |	\
+				 MSR_AMD64_SNP_ESMT_PROT |		\
+				 MSR_AMD64_SNP_RESERVED_BITS20_22 |	\
 				 MSR_AMD64_SNP_RESERVED_MASK)
 
 #ifdef CONFIG_AMD_SECURE_AVIC
@@ -204,7 +205,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
  */
 #define SNP_FEATURES_IMPL	(MSR_AMD64_SNP_DEBUG_SWAP |	\
 				 MSR_AMD64_SNP_SECURE_TSC |	\
-				 SNP_FEATURE_SECURE_AVIC)
+				 SNP_FEATURE_SECURE_AVIC |	\
+				 MSR_AMD64_SNP_ESMT_PROT)
 
 u64 snp_get_unsupported_features(u64 status)
 {
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index eb2e853e950a..92bf3afd4351 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -89,6 +89,7 @@ static const char * const sev_status_feat_names[] = {
 	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
 	[MSR_AMD64_SNP_SECURE_AVIC_BIT]		= "SecureAVIC",
+	[MSR_AMD64_SNP_ESMT_PROT_BIT]		= "ESMTProt",
 	[MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT]	= "IBPBOnEntry",
 };
 
@@ -849,6 +850,12 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
 	vmsa->vmpl		= snp_vmpl;
 	vmsa->sev_features	= sev_status >> 2;
 
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
+	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
+		vmsa->vcpu_id = apic_id;
+		vmsa->vcpu_sibling_mask = U32_MAX;
+	}
+
 	/* Populate AP's TSC scale/offset to get accurate TSC values. */
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
 		vmsa->tsc_scale = snp_tsc_scale;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c0914829a925..83517f53d757 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -754,7 +754,9 @@
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
 #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
 #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
-#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
+#define MSR_AMD64_SNP_ESMT_PROT_BIT	19
+#define MSR_AMD64_SNP_ESMT_PROT	BIT_ULL(MSR_AMD64_SNP_ESMT_PROT_BIT)
+#define MSR_AMD64_SNP_RESERVED_BITS20_22 GENMASK_ULL(22, 20)
 #define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
 #define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
 #define MSR_AMD64_SNP_RESV_BIT		24
-- 
2.43.0

