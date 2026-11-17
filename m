Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938313;
	b=3RemKf0TOX3PKItYi34EikiXjYIg/U2Y7N/U6k12uKJJ2odbjOdXxZjpUrGQkPuYz3PO
	 2vosKdUj7rSJbZtlW7SqIXulCqnYn/pVYnmmr1AYkh6L7+4bNXCFQWn+VdWr1t7JnbhQH
	 6U/hVXWo41cnHdyHJJRljpI/gRYvczeO3NSwD7rUVgoI+aanJYF39cnmj+isIhRSsQe6X
	 8yL5PYXrgRIoRzDZ1V6IWQgOw90JRljFjHSfI6K0+GH8IQKm/kRLRc/XRzhXl5YiRr4Wm
	 qSeYsTNhYl+EowgDe1N7/MHXq7UFnO3K1mkacoYckP491G3z85i+KG1tg6J2chC9WIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938313;
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
	bh=YblgKPx8tXfqrarrBnAQGz/BQ8sDs7ERhbskU0jrwQs=;
	b=uUyHOke8acakvCrBzFnibU8G1kJGcXWtL6qo5IGHS++a9rNZxzxm+h8uqfnUlJSTtwJv
	 IMje+04K95d7PdDQ61cI0q7rkbTjp44G7z685yUqf0LJ12N2PSO3Be+YjPpuUKvZsueWg
	 SpwS9gEksy/YtF6pV6MOoYzDCbZwhOMuL57WL2/fH2t+mQbyD35UWlC55hNvMdVoe0B0Q
	 LekFn/erEf5A6RMJQRZ1Da+be8CyuHKCe2aassCfi25mY9ddhpSw2YOFtC+lkAY59cf3D
	 SPg1mo+8mlMejvF/C/53FTBGtANIiOUMvYEk+zBFwkRuq3+BkGJSm8HpMLYPlhTYrmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=okstNWR1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.34
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AE606A31C;
	Tue, 17 Nov 2026 17:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=okstNWR1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCPXNvkghKEgeqAH0w7YqTWIqmAPXpms9Sfx7zfXSyU48rTCYjEZ6IrdsuRwbV4eh7axss5CnsmtLZqDOYQ1xNr8L7UKD04GzqNrlq0xEvBMPuBKRXUbWluElq7yQmj06ksF5Lx5gI1ETMvAe34waV3AZvXn/f+Zu06DDLfHF65+cwQUKl5lke6OZ4bbV26LjoiCWkHuOYmS/nsonq9NeeMRaIgHzDJGMOpcXW0a1Nc8ZGwBc1KcRyvtflsiO+MVq//L1qF5bY0EhEp1VmWVUGSqVaXrVHquZNwv4W2/E5tDIZOkf+nUPzTTyeTDa9wOvTg6SGAEmfDJYqeOYScw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YblgKPx8tXfqrarrBnAQGz/BQ8sDs7ERhbskU0jrwQs=;
 b=XN/bdHyp+oxYZQaiLp4mtTTo1Qw6+THkeHHXwYpRgNFI6RAFU6BcYdZq1Gp7rsldm0n5uZbzPCm0y3Rv2T+1O8OsVerzqETcuXsbcnJVFvAPyZci77hi6oZCRS2AOzxlkNdD9XdaQ1BLYn61q3jaQLAkmhx6K/sneRSY+QLcUuxg9lQpHUIKWglEkqjolI/1XtsjqbuIDVVz0mkvBj0IQpVup4TvAGVQf61JfiZVQ5q/bULzsyhOdsdA4HHddZIOVwzOAzyzf1zy2sSJqsTyJVLQCqIcV/J7ueLOz+06oi322mul+B/IZmLRGVL/4vX+vCExFa3oROeStJboeMVF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YblgKPx8tXfqrarrBnAQGz/BQ8sDs7ERhbskU0jrwQs=;
 b=okstNWR1+lN7eqQM5Hq+QCyEzmZn2yVsMLePdX47e1NlSNPFGDXu84KjGvCnesdWx7XVSpj9Um4Xu38AUI/Uh2w+F5ZAsC41MHVNLG9B8cz6G31ENd0muCFzUTIH3mkYT8VvE0hTv+rBhohvc58uex3bAt8Mq9MWS5OQ/797vNc=
Received: from PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::23)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:58:24 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::5a) by PH7P220CA0022.outlook.office365.com
 (2603:10b6:510:326::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 17:58:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:58:23 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:58:03 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <haiyangz@microsoft.com>,
	<wei.liu@kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v5 3/3] x86/hyperv: Add guest support for Enhanced SMT Protection
Date: Tue, 17 Nov 2026 17:57:00 +0000
Message-ID: <c03379e62765c3408889baef5f582abc8bc19916.1794935627.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd9c0f9-4de3-49f8-eadc-08df44d45f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|261102123227099003|261028144727099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|11063799006|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	iowxxLmVRtFKnn3SY62khP1/76c6968ylijyxOit5BOezXuKKC66ZsGKmCbADebkOPI1/TYtNrnNBD7BT9Cxi2/9CoPqzrTKgHtT9Vc7WC+2A6W2s1n0SbJ/j5vUoLv2g+Sei/nmmi7UN0iSXlibyF0b+8rgb4ujppfNmnx5llRR7wZM6IhJc0fKxg/eU7UY2f+IYWvnNxO9Fe2ERi+Pa+h52O6OGEKsgf8nhN731viLRGLYm9EID9vK2OZkZUxqD+AM/Wzrp/lbEM2EancBgzKBf8uR5r3XGXT9xp20IhbVNsKf7E7pPlrAjw11TQTXGWQhx2ysK3pKIt6b/RXO95Rj34Y0gGv3Lh53Fa76LUp3SG2QlzuRDSmRi/riZXOl7j2qdV+ZMQ1S7TYD+akAlF4QDvsGZklGJfzd4hsFzRozBFUWhE40hhLLlwzSJle/+E0XNelr1SEz6ipYAkL57xCvgVsrRFV2Ilvuy8VZmi6TdMqTAfqbphGvQlMb0rn2iX1z2h3mF+tzNqyy6TX84b5o38NQiLF0YrKgaf7KPFyZQ7q/XEyB21ciDeSJyK1crSv4JsRzZ1L5VMhKAbsBtBW2+TgP4vHtGU7meUVRLXAA7xIc7gRc7pei8ZR74RmbeJDXatRzpJO/qzxAThQkJ31Xel1PjNTfdQ3fY87vBz0YWZtJ14JA387xrGDjuYPe24N380CnaQ78w6JmAK0F+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(261102123227099003)(261028144727099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CwcZKQZTn7yhu09/7zWByR6mEg+iPPuKXP7e4tewhDtRRmy025reOituPnOtT119vtltLsm5la2SqFZb9pLPCAXrRkuWppof1rVoCutjvbXZwRBIwx6J/fJyLORFji1+tCXwzBGVHo/LDKamD8luinH8Uyu7V4/Hr8hoyamF8wM3N2qcajZT6E5KgZPncnPPy0K4VQ6vW/3p7jG/OutvlM0lkEDZXo1y8t2ltUo91J+Dyqf4HSLBKvO016CZ0/XsCCBLAs4O1v2rVkMGF2fOZwOgbMWPKqVuZR8h8vcLWbVA5PMw5xLM7O55SlAg3U4OGeZaOuvO/IRlZ5geTkLcKCrKqxkwAOBIfSq+6C5nzPpbAAH1mzbTF00O/46RMqC9QjZsJ0ziEP7L2vUxMAMUKnNLxr+rCWGy4nC7OFXcuhIP9lDrGHxyWOOYPX2YS2O7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:58:23.2282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd9c0f9-4de3-49f8-eadc-08df44d45f52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7

Add corresponding hyperv support for Enhanced SMT protection. A fully
enlightened SEV-SNP guest on Hyper-V builds the VMSA itself when
bringing up an AP, so populate both fields there, before the page is
turned into a VMSA and while it is still writable.

Similar to KVM, fully set the sibling mask so that all threads of the
same guest trust each other.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v4..v5:
* Remove comment about vCPU sibling mask configuration - Boris

v3..v4: No change
---
 arch/x86/hyperv/ivm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..bd57cac18181 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -347,6 +347,11 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	vmsa->vmpl = 0;
 	vmsa->sev_features = sev_status >> 2;
 
+	if (sev_status & MSR_AMD64_SNP_ESMT_PROT) {
+		vmsa->vcpu_id = apic_id;
+		vmsa->vcpu_sibling_mask = U32_MAX;
+	}
+
 	ret = snp_set_vmsa(vmsa, true);
 	if (ret) {
 		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
-- 
2.43.0

