Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938273;
	b=ZlZ/q/JBVwa/jBt6jbsTXvR6zfhb4MWX5vcz6oYoGIu5txXfJKv6nA6X7WL1BptbJFwU
	 4XNcCK7OIM3EyYmIttIDFsUyp+RILY8HxJnD49VaVxBL+X9RXDXRYybUaHyZcVpyLJ6qj
	 W00zMqkQ2Dgyxx4c1p7gwzN0B7wF6iZ9LvtYcqCJqcrfGWjv/Z0WKdhzsHlsAGFFvQkx0
	 0bYNZWY8DzY0TZhq2ISuukIqg11uIGbllYovnSLZ44VrEk7uPJvbuntvLf7d7g2I1pT9C
	 v48EXqzb8SuXICakVSvnpX+7wGs5hDkMudLgoP6qfyeh4kO/dL79ipjZaXK/Stu4ITQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938273;
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
	bh=BjjaTubM549K4aZ23SjcS2vdVKQb7b7fmtPUdGJ6DdA=;
	b=GlpEp2ZC8DEOrsd20wGw83C8X8Bd5SoI8jad5zwtTUadTbAf5RJadTM2mC8rNFvP6u2O
	 DcPZ7fKMi39t4ts3YNg7tkCSLQ390UFSXBK3fDx0inM8CMQ76h1YccRfTzsNFmVnzvZ4A
	 qpU3t+jaJ7hcBUGOTuCl8G7Htkpbs0gU+7S3X1VaV1hDOJjd7064Xeur+LDvEPawE9Qtm
	 6jX4QEiYU9ellQqSFKp1RO0hpVvbNYa3ttAw2ZHOETDppHYrLWxS3gYbNIoAH0Lxkil6E
	 RW73LuIH02qNWylInDlTJ1RdX5rW7PRu7H84xfD6GQe7ddDjGf7qWwc1yfjO2bV93dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N4AecSFH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.51
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F593606A330;
	Tue, 17 Nov 2026 17:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F593606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N4AecSFH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDMFijxQBW29emwclja0YsjWj/gRnZgZo5n6vc4BlF2Pzuv2Hz1yxnUrbXA8nHz2DcIaTV+SDRCPBBKauJzUs5WBgqaP9wED+7vSn6QoiL1cA+uYQ9BQNmhiw+hGcx8rTkem8KcM9GR3ZiB60VRUazhLhK0kipotIblzXDgMb59nXOxXpe9eYjUvvXMPMP7iv4MxRDspZXv7rex4IbkC7oMeEtZ7O1GSxwnnj7fIef/nK28pvWrijNwKrYIHs9Zxk3gYKm2AntzP1HOTLIHPdyEkIGt0Z7l8K3XybF9DC7NC/5tXtK+OvoCVpTCCvkvyFUCxHIWkG53TFx/GexmgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjjaTubM549K4aZ23SjcS2vdVKQb7b7fmtPUdGJ6DdA=;
 b=mZm5I/ejS37HeGwcqhqYI9gNXsNtQCny4RbWJBInxWJIp/LkZJluFd5uc3WewIOzhwzDkszgFzNdzIecNq/qv9F8CBtfK7BOORWwMmK6QC5NcCgTdybrVNzKz+aOhh28ojgcsi4G0CtrGRq4mZSinFZILv0TuiOlZGbJMWuMLfdfQ2PUIVBprdOd9FZgyeqz7jfgsHSu1kQbDuH+R/XmmFIRFQpYSrViyHLfAxM+VDqJlfRv6hdXdXAwcycYImmHReb7gLi8/hBj+2yPYbQwDu//TZVi39u1iT7+mJbZu9wHTVJBvL00jGLDgHu4SxM6raeDPEtwJur75RPMyF6twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjjaTubM549K4aZ23SjcS2vdVKQb7b7fmtPUdGJ6DdA=;
 b=N4AecSFHYW3az3owzNQGEh3ChM+fLNxdao+DEw4oFAmEH4b6M+yAVPQ097yf1XDgE8luexUg7QNl1+mlGKSihy9S3xpoIZmuTX2vQZd7j5+VRglGK0WX1GNcKb6SdaA3nyQeE/Q6ab/htDmi1Yng0d2jWejECjxELGzfjB2WWKM=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:57:47 +0000
Received: from MW2PEPF00014675.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::84) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:57:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014675.mail.protection.outlook.com (10.167.249.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:57:47 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:57:33 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <haiyangz@microsoft.com>,
	<wei.liu@kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v5 1/3] x86/sev: Add Enhanced SMT Protection fields to the VMSA
Date: Tue, 17 Nov 2026 17:56:58 +0000
Message-ID: <eb0ea38c0713b44906dc3b42ec92d6f9e38649be.1794935627.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014675:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: f695188b-86f2-4e70-bcf4-08df44d44a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|11063799006|56012099006|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Lt1N/8gLOokvMoJgpmc3rA9a+L4bJ5aV+OocIl59HeenWtWQ/hKm12ZJnEwR0ojsDXiWsVEx9eF4hNGL3zGv+1PEZD0qIOiOsBcuUnyL8Lh4OGjkJ6ch1aIcalYzBgYi0zJ4v45rm8zgf2y2INcSC7lRL5sikvyumwPzKYE0tLECjT+4VQAZNjTqwEYqw70iGtyJ5MsYZSvvI+IgBFQLpNEFHRtRIwAUN0hq6gsYbOlRHGeBLmNtCK1WO2bLPP20TYx7Z6gmMr6btA45bpMIC0gIpcsejmi9FoOa6dRpaMmpq2FBwO9zJKiYJMxYyCdoOie0ki6Bzv19dSzKCRxgHerDwB2LAsFMTTkPgmPnxg/tw3juu5096/QhZbJR6I+5xbYAxkjXWGz6O9NUcD2WFrOsDDPehlaonQzSdUYCw+9iOBfOmtTVaHpDL4Mv447GpLpLCaY0MoSSWlgd1e/vbpb/KCkGkLZvofUJKSDNl4t1203U7mI0/ru1FPcghrfaKeMPANvcsmi0vu8N9NGCnTiHtPlrKj2x+4w/PEEZEY6cG1/IQ2t6bUGjx9N2jkopW+8/6wZdz/EsnV4XDFAzz6N5Y5z4dwBIk5x/B4ZypDwGOkgwsAAxqJb5fsa2mnxrGoExo4R/8aMPvBJ0nkGxi62lRHk3JsmiGNsHcVCt5SlTlBj4wIO5+A1YR5eG4rRqdP3+HbWwI3U4AUBdm+u58A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BNsZGP+E6qeYuBoFFYrqqPnukfe0rgiNiBH+whiksGMiu8AqeirVSj5mn4ZV4WcaUnjqbfcMf/yFLf0dbUrxbfeeZZ29Ea+dNpECk5OJGmx26kwTgdTVWYf3djeb7hQlRZoFg/38tA0xtDy8QoDF7CJff3w4pP6CK5/b5GCPHpqXapq0EY3tZOkP62QOub0i4NRt5PJbJXqxAf8TC3VgvIgbTYH3gBQv+/LFVlOkZEYGhfRs8zG3c5pBokj7v3/41+3H6j7nURjPfdNdS7IiSzcgw509PzBHX+0QxDmxwsyArOPLAhkM23jP8tQj5bfomU4B5KBOtZGMnbhNZnD3OBE+roWfDOsp/rR0E371VvMPNwyQvKaJCKTZC5zdfEen0Matla87bSk72DK+WKWzgOtJql8DFjf1VSvGevEh3G9jfTN0pD5WCXCsdL0wC8lF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:57:47.6955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f695188b-86f2-4e70-bcf4-08df44d44a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014675.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

Enhanced SMT Protection (ESMTP) adds two VMSA fields that carry an
SEV-SNP vCPU's co-residency policy. VCPU_ID identifies the vCPU within
the guest and VCPU_SIBLING_MASK selects which of its peers it may share
a physical core with. Two ESMTP vCPUs of the same guest are legal
siblings when their VCPU_SIBLING_MASK values match and their VCPU_IDs
agree outside that mask.

Add both fields to struct sev_es_save_area so that the guest can
populate them in the AP VMSAs it builds and the hypervisor can populate
them in the VMSAs it builds.

Refer to the AMD64 APM Vol 2, section "AMD64 Enhanced SMT Protection".

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v4..v5:
* Move the VCPU_ID/VCPU_SIBLING_MASK VMSA definitions out of the KVM
  host patch so that the guest side builds on its own.
---
 arch/x86/include/asm/svm.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 83fd49b26a4b..aceb405449a5 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -486,6 +486,11 @@ struct sev_es_save_area {
 	u8 fpreg_x87[80];
 	u8 fpreg_xmm[256];
 	u8 fpreg_ymm[256];
+	u8 reserved_0x670[560];
+
+	/* Enhanced SMT Protection */
+	u32 vcpu_id;
+	u32 vcpu_sibling_mask;
 } __packed;
 
 struct ghcb_save_area {
@@ -558,7 +563,7 @@ struct vmcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		744
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		2216
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
@@ -593,6 +598,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x670);
 
 	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0x0);
 	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0xcc);
-- 
2.43.0

