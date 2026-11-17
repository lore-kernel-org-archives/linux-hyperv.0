Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938274;
	b=q4g8Lxn5Kl+gs5yFlCP/lXXEZRylNPX0i0M0HNnRydpbEw7NvbqYsWf/AnGxWCrlOZnY
	 AryBbEQiBPhnCHn8GKZ3CjFyLvicAmPDSTCJqbO7QwDYzivx1rCpMNpKktHo3udRScOoa
	 Ql5cys+MWrtOmbmccFjBS1C4D8zNbgLfgILkeKLFu/Qr20p3UMdiIMoNhih8+F1m4iUCu
	 1G+hrtDIGsKQ5rZerXNeBTShjhYqeQRmZ3fBcgn8Ymce6P6DHe/3M9yCXRoPD6ExlMJ6w
	 1HcMb6bUhN5Ud3eDdfPawQGPslLIot8t/4rA1aScYRbOg6GTidej8pyuhKLaYCTKcSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938274;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=sTOL0h7JaHjtrZENsS8kzR+9KMt6tkgnO035tGZnkI4=;
	b=3g9Cfi7mkOJndkSDLUIsYmcFssBmSvbuaCFqpQ4KXy1RyRKlbTcFHv3eb6k1JIzD0YSl
	 TfBxnEm5CVoV/mYorucAYMKsWikotQKKlYMhaLPnwrRpxw11IGdbGKZ/m5ciw4/RqrLC7
	 DMDR6rKv49iwDYuQ2q1HrbSOrZAFVac8fKkAIfFr76UUkkPm2gT0Kn1IQ/YVA3zV5gmtN
	 qlxr2XlIYhttBsAQ45qR1cA8LFmxXL6qcfxm/lpjx6TSx0M1eEDf940FIxGj5jtdB8jXT
	 2XiPu71f+gItRS4BRRDxL7ztVLdZZuHOBOvzRoHKiWGOrqaNEgbvSo9y13mgbz7VXpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uoahsdP7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.54
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDD606A881;
	Tue, 17 Nov 2026 17:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60CDD606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uoahsdP7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2f4G8rRUnhgV3i0dwD+G5LLnSODGB3wZt263RGB2xGDXp4AYKRRFjHWJE5+/jxCvsVGnl81W7gXjpmjuM1OJC/2bhhyhXLnsL3EExklz1/c383NxUoE41K57jNO6cOlOW/l/8b/3jKJWHD/AeAF67iPmUDzY7ZoOHvE93A5ZtdijJEnCNtbA4eghBNfzx5q05FIdbW1HNcKAEYtTakqetTfwY3X8t3guvpig9uOuBP4gJGlna4GSxJ9ZycP48YoTORcW8IRoTzRK/eHZb6Eoq/mJWvzjlXpXO8/YnBMnbMe0bFAV2/3dwiYjb30cPoKUl42AgsanUMR1Xu/sh0adA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTOL0h7JaHjtrZENsS8kzR+9KMt6tkgnO035tGZnkI4=;
 b=P15FFYuXfcFKpMyGmlj/5t+xo7GVMPvpNfcY77r+p59tUsgJhfNi7iicaRwHzk0sIFj4abBoD5/PagNAOgDo4soV60Q9n++lDd0HPUxNhCD44H1aNy+uA6OqHTvnAAdphnZI4VAcbinb1bmk3/6icDHMUwpcJru7gjPg/xczF5xjF5XQerrMD2mrGQ+nDtzDeJ1fEXc88lZyhaT1it8Ut5d67jPy8WPPLTZG0a61V60iqgE5C/gQ/xoKZuRPFFZuUVVtvtflKuyOgmIJ3KTtdCPtWwOX7538BbVm+y8/f+Vqgip/F7seTMG+Inc3uGj93OrAenx7/ByYdqJc1OSqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTOL0h7JaHjtrZENsS8kzR+9KMt6tkgnO035tGZnkI4=;
 b=uoahsdP7/O+/1VwUqrvHRFfg+b07d+JQrew7Oy8SDACCsgrngCb3lbMZkuhxBhqSBsACyrrlgJA4iX2gPwYB8uxewEcfHLl1TfzFHVZ3VroXj+wmSlF83jeUn9SoGOc8B5jVx5JsJDyvT/Ag6CcerBu8voPxv4TeWr9cNLxXxq8=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Tue, 17 Nov
 2026 17:57:46 +0000
Received: from MW2PEPF00014675.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::83) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:57:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014675.mail.protection.outlook.com (10.167.249.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:57:45 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:57:12 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <haiyangz@microsoft.com>,
	<wei.liu@kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v5 0/3] Guest support for Enhanced SMT Protection
Date: Tue, 17 Nov 2026 17:56:57 +0000
Message-ID: <cover.1794935627.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014675:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: f167ae80-748d-4056-3c91-08df44d448bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|7416014|261028144727099003|261102123227099003|261026140227099003|261021121427099003|56012099006|5023799004|11063799006|261022075727099003|261021123027099003|10067099003|261022105027099003|260925021911599003|260925021311599003|260925022911599003|18002099003|261009223027099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	XdvDSy6sUMraagHvSdSl3ZpKmjO4qwJpn3nuITxUstvGwk5vVR7IlPhah0/GcxST8euAhGoWBGmp9SNECIysn4JfjNbX5DTpI6uqktbU8At+MnucWK/HHs2wCvMF2Nd1Tl/bzkZSktO2qemX54CXWeUr2RL9CuMmvMFlUZ0UIwt5/yKUbv4kun7FpcTbuVcu4AUuos7mb4k0ncQOU84p5DRcDiFFc8Eeic9YXvHcW0MbsFw1zQ5Zu/TOLq8jJWUxgiUcQ1QCGKTHY42Qc1sO2nGr1VVoPpc6R2L5SBA6F41EgvGnoHvHh1T563SAfNPudWPju/+j0jqKzgrkVRKxxwRmPvrxXDrP9Wyl8hEW5sI2qPnFgyxe+bxAUCBrd2l0d05eoE3FgbW0aKhAYzawG+6gHPuGS3Q6AePyJdQA+rwLvCahqKHqfYbQvtd4y8VSpxpxhEch/JVpdP9relYzqsaaKEMUu0jbsI01zPnR7VHiF4CNamfstDqc7mh65/CIY4c8pqIG2rIeVOUgAGaaXiLQJalnbQaKqvn+MT7PPCrkVhD1IRDm0z4nUpb2peTO35iB3goJpgrM98sZOeKPi5nns1ynEo9esnNJyb9tQXh4dUzfKylD0MHe5zb//WdCW1ObotgUzEjn1JVoyYAaVg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(7416014)(261028144727099003)(261102123227099003)(261026140227099003)(261021121427099003)(56012099006)(5023799004)(11063799006)(261022075727099003)(261021123027099003)(10067099003)(261022105027099003)(260925021911599003)(260925021311599003)(260925022911599003)(18002099003)(261009223027099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yMp35/3tWatiNua6tAdQZgB2ksmZ7h6gpRPDw7vjxmqm3qkxe7chU2b8MOkhp7YAw+4cBy6s8d3rt/YqalM896eRQy+A0TpvVDuuGPXv+x3HiRXrk2+l3STirFf08ZKtXXQvvxhZR1SA+F9INtyqX3xpXM1r4DB1+qVlIEk9ceVSMGhjL3s7A98OTyPeoXRb5yjV7OvbQE7GViqg8NrGvM+44hjniLiMLorpkGL0Qq4yGpMcjfMgUx7oaMpj5dHhcIu8sk64/MZd+auWSNG6Nl0nduvvDnUgwn5/D5XKHcUxuB1G8Gk3WGUyYTgKybVTWHslpaBcbY7+wtDOH+nw5tJAf8wnuQGJ8TW7uezCnG4RWZ9eBUvANNTL9ZfjcrlF7MosuBJOpvuW4huoUiXUtOctHj+qrr3y+eHpLWOIeMZxz5cgeLmdd5UquzaQKdcy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:57:45.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f167ae80-748d-4056-3c91-08df44d448bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014675.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B

Enhanced SMT Protection (ESMTP) allows an SEV-SNP VM to require that,
while one of its vCPUs is in guest mode, every SMT sibling thread on
that physical core is either idle in host mode or running a vCPU the
guest itself has declared a legal sibling.  This mitigates the
side-channel risk of sharing core resources with untrusted host threads
or with another guest.

Unlike core scheduling, where co-residency is a host kernel policy
expressed with cookies, ESMTP is enforced by hardware. The sibling mask
lives in the VMSA.  The host is not trusted to run arbitrary kernel,
userspace, or interrupt-handling work on a sibling thread while an ESMTP
vCPU is active on that core.

This series adds the guest side. The VMM enables ESMTP for an SNP
guest through SEV_FEATURES[17], and the guest observes it as
SEV_STATUS[19]. Two new VMSA fields carry the policy: VCPU_ID
identifies the vCPU within the guest, and VCPU_SIBLING_MASK selects
which of its peers it may share a physical core with. Two vCPUs are
legal siblings when both are ESMTP vCPUs of the same guest (matching
ASID), their VCPU_SIBLING_MASK values match, and their VCPU_IDs agree
outside that mask.

Merging
-------
Following the discussion on v4 [4], guest and host support are now
split into separate series to untangle x86 and KVM. This series only
touches guest code and the VMSA definitions it needs, has no dependency
on KVM, and is meant to go through tip. Nothing changes for a guest
unless the hypervisor enables ESMTP, so it is safe to merge ahead of
host support. KVM host support will be posted separately, potentially on
top of the scattered.c rework as suggested by Boris and Sean.

Testing
-------
End-to-end testing needs the host support, which is not part of this
series. It was tested with the v4 host patches and patched OVMF [1] and
QEMU [2] builds. Launch an SEV-SNP guest with ESMTP enabled on the
sev-snp-guest object:

  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,esmtp=on

The guest reports the feature in dmesg among the SNP feature names:

  # dmesg | grep -i SEV
  ... SEV-SNP ... ESMTProt ...

To check the sibling behaviour on an SMT=2 host:

* Identify a sibling pair X and Y on the host:
    cat /sys/devices/system/cpu/cpuX/topology/thread_siblings_list
* Pin two of the guest's vCPUs to X and Y.
* Load both vCPUs in the guest, e.g. stress-ng --cpu 2.  Both host
  CPUs should show 100% guest utilization, since the two vCPUs are
  legal siblings.
* Start a host task on one of the pair, e.g. taskset -c X stress-ng
  --cpu 1.  CPU X's time should now be split between host and guest,
  and guest utilization on CPU Y should drop, since the vCPU on Y
  cannot enter guest mode while the host task runs on X.

Based on tip/master.

v5:
* Split guest and host support into separate series, per Sean and
  Boris [4]. This series carries guest support only.
* New patch 1: move the VCPU_ID/VCPU_SIBLING_MASK VMSA definitions out
  of the KVM host patch so that the guest side builds on its own.
  Retaining Tom's reviewed-by since it is functionally unchanged.
* Drop the sibling-mask comments from patches 2 and 3 - Boris
* Rebase onto tip/master.

Host-side changes from v1-v4 are left out below and will be listed in
the KVM series.

v4: https://lore.kernel.org/all/cover.1794244450.git.prsampat@amd.com/
* Fix conflict of reserved bits introduced by PML support in
  vmcb_control_area

v3: https://lore.kernel.org/kvm/cover.1792184487.git.prsampat@amd.com
* Collected Reviewed-by tags - Tom
* Use sev_status to determine SNP support for guest as well - Tom
* Not syncing the tools/ copy of msr-index.h, since several bits apart
  from ESMTP differ and the perf tooling maintainers usually sync it.
  Happy to add a sync patch if needed.

v2: https://lore.kernel.org/kvm/cover.1791302373.git.prsampat@amd.com/
* Populate the ESMTP VMSA fields for Hyper-V AP bring-up - Sashiko
* Add ESMTP to SNP_FEATURES_IMPL and SNP_FEATURES_IMPL_REQ - local
  Sashiko instance

v1: https://lore.kernel.org/kvm/cover.1789399214.git.prsampat@amd.com

[1]: https://github.com/tianocore/edk2/pull/13128
[2]: https://lore.kernel.org/qemu-devel/cover.1789399242.git.prsampat@amd.com/
[3]: https://lore.kernel.org/all/avc-5lkQhoR6US9o@google.com/

Pratik R. Sampat (3):
  x86/sev: Add Enhanced SMT Protection fields to the VMSA
  x86/sev: Add guest support for Enhanced SMT Protection
  x86/hyperv: Add guest support for Enhanced SMT Protection

 arch/x86/boot/compressed/sev.c   | 6 ++++--
 arch/x86/coco/sev/core.c         | 7 +++++++
 arch/x86/hyperv/ivm.c            | 5 +++++
 arch/x86/include/asm/msr-index.h | 4 +++-
 arch/x86/include/asm/svm.h       | 8 +++++++-
 5 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.43.0

