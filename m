Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABB317144;
	Thu, 16 Jul 2026 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164674; cv=fail; b=tVBYmx6atckE5BMFJX1EPtKGVRAMP/3LYEU4U5IoadKNTvnYDS3QTHg7Xzp8mwRtEm0BU8z7GNXY1qg+9pE3ImxGVixNk2i3qWPKeUAWX15k+Idq3Oa6GuWkRoyd0cII8XiM79dtGZfx4O4JWGmHxKzr3PWs1imw7WauRMpi6cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164674; c=relaxed/simple;
	bh=OJiOW/I/BrwI3G2rVkFGLDpgwU6xFqeAGcQSyayZ/bE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CzgI9DRy3frFIWhcWGVMyeEEpHjcAVJg0sSEbdcmZWR5aYEwEDp4GRIUUcPBlbw29Tj04+RKbxsuy7kUl9fhqBqZN7NFpuP0rCqwfKKpDXVpcxz8oFwwBmMAoQo3XJSzubVnxlE6vYe2/dvHHqw1TIBVqx8T13wKcCZFK/QUpI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=A3UMX5KF; arc=fail smtp.client-ip=52.101.62.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A3UMX5KF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDbXs3TIOvqlZ0HlXllXZpNvu6xGKVrtaQI3nvX7BsOjmDiDodZFpjX5MWzjdWPar61jbz5lyqFNzn3wHmMJgHcXEfU97sfDLWVN4aF++H+YE5HIBTmDOeqRj8DGHq8qrbYJd3W65PniR3S+A7KWGuyEvXW+GG5Q2UqT4woFNi+ArNWA+V2mIyF9GDWEFjbyHu8uga4K+mJjOQhO4sxuGDamPS1PJ2o0NeCFfeIdAfVf1oMG1JMYbIeahN64L7KPjId8qT9pud6QaoeeZY25r6OkLuDpsmPPvt00i6QyRvPGzGF0WYiZMQhd+y27UjGlyyieu/MqQrM2qxBaz9fh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIAvv2rjURPOMKRtLxv5ipDv0b6qbnNQas/HefxSX5E=;
 b=MBCZ60HeAcfFtljWcOXey/FM17tNVd9hLqyuN0Pqsg0P+uEuKYN187cGHyIhnoRVxxgajwZhddeaBQhTemrjyDpYJOQGFXEvD98GjAnoi7pFnUvqGyH6GeR5OFawjmT3oW6ppZ9mH7A6eSRZKocElYfvNS1Eic0QLrkpfrOOoVXczMVr2WziOw2K0zpeHqCq1cpwT7w5L88GwMjvbVjXkS85kHXyMtcQ6NY4aQC4OSwd85SAsKoaoxgaAAzMkSB9BUY2CAUMDeZ5+ldxcb0fgoIIJ3s4eY/SAyLlDQ3VRLJU9kODS072d7NB4XcGwJByp7ExHnelmqD/I6d7LHoiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIAvv2rjURPOMKRtLxv5ipDv0b6qbnNQas/HefxSX5E=;
 b=A3UMX5KFv0dzFjqIyVhfnvCByAO2R5r1kpZTag+dTXssnKcKWcy3WQeKWFnv1xLIJ88ql62GYJqBs7kq4XCMRjmoMsnCYJBcfVuOrqCi28sr66FS+V+d76nCqX2EYsjjNWMTm/L+ap6l6rGMq5zw7hYM9IwDNxHMY1ATtM7hRGc=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6034.namprd21.prod.outlook.com (2603:10b6:806:4af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.3; Thu, 16 Jul
 2026 01:17:44 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Thu, 16 Jul 2026
 01:17:44 +0000
From: Long Li <longli@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [RFC PATCH] x86/apic: Fix lost IRQ during forced vector migration
 on Hyper-V
Thread-Topic: [RFC PATCH] x86/apic: Fix lost IRQ during forced vector
 migration on Hyper-V
Thread-Index: AQHdEC8b+m5cLMB10k2rMASQG4Wl1rZvXmhg
Date: Thu, 16 Jul 2026 01:17:44 +0000
Message-ID:
 <SA1PR21MB6683979099D4656345A60FE9CEC72@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260710054007.288807-1-namjain@linux.microsoft.com>
In-Reply-To: <20260710054007.288807-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=151c20bf-0d98-4b54-ad5d-dba54605a310;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-16T01:06:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6034:EE_
x-ms-office365-filtering-correlation-id: c0248d35-1bb0-4b64-30d9-08dee2d80a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|38070700021|22082099003|56012099006|18002099003|11063799006|10067099003|6133799003|5023799004;
x-microsoft-antispam-message-info:
 UaqywJ5ZC9uQatWvfwXuDGDS/a+2YmM2VUDThTjyTwFkbrlnBmwgbCd5mPTZPBq93YwyhiVImabACCdHjo8xqWtzA/uU6gQjJDEXLUdWqFPPobV/9ECRLF0HHsh7KMhPRfzqTcFAiR3wrWrZ87ZoBA3vwlgHORsujcE1abtFirAqgfsgDUuDXM7QwDJFbvpMyW9vFzI4IlE39C2R70fsOZmO32wnfvvHVyhpfThsRzKNdPvabkTXa2a3I7b2Fp96drwNlEd0a9HzImafk9mv8d/3+I6g+CRW3syTu6WnVya5QXDX7H6svwdKhSS6qUPeSJjK6WTAR3T4joC12nSHpPqFZHEaPJaYUsay5KPuEEk5aOaRUIxDgVSz1Un6mZvEQDxyVenl+S7pAwweViubnckGPzWmk6tcEesJiZ8yBwB7LNigHqrknZ+nspp51nR2f03pC3TqfRqJIX9Heb7TAneuBHZ3BslSzdzzlNUmkOO+0NjRG5DVc+6A3gYb31DnOBxq51cbZv5wvyw3NBPVNBMW4jGwvJZChkKCV3rUq1+RVL8WKCTki9wzeZ5PWnO7+ELygcmni8LVTv62ijZr7M9BLFJ2LNfr8al/R1waQLMlUL8ZWAf/wpv9n7C6JwGQvP8xfNz9uAje9UHQbdZMU/zbJvJmFtY+KTzT0ib0xdpnWzuXls/1PWm8dT/AidqHpiW8T4DCC1p3DumGloRvSWnU38ok2BSK7vNIrswiwlw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(38070700021)(22082099003)(56012099006)(18002099003)(11063799006)(10067099003)(6133799003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tbUNTF6d2Lw8wtflPhyhaNgH19MtfesbVVsFdFGgieg6q0/9C7yQY52JxHCm?=
 =?us-ascii?Q?BR+v5VcnzfU8rHZzCsTna5lQiL/5wj8RCy+ZuE78W7YLwD+52wtCabdLO+Ug?=
 =?us-ascii?Q?T9f5RKy487w17bd76ii1Q4dQvW1pJ2JqTVt0OOyFxY7FWMQ74H7bXsjG7OsA?=
 =?us-ascii?Q?+FDKCtlww38MgvAdVu8iViiPPlxyHOxoSZnVJ1tyPoqVQ+1FmO4pbkcX2Kbm?=
 =?us-ascii?Q?+Y2mgLuC3bGwmFUoPWGjEiGRjJ4FRaSc9iWbszv69XaoH1zX3S/5LqwWj9CP?=
 =?us-ascii?Q?0lWBmfG71dYE+Q/LedcPT6XAW4qbN/Qlc0Zd7VCDUWVPdKm9KQtVwc3MHB9N?=
 =?us-ascii?Q?tTs7zHopn33Jfq44fDQF5SFdRN/R3msaaesoR5rkU43+UnX8fum/5Qgg0fxP?=
 =?us-ascii?Q?ur1M+b7yOXI5ZoVeZEWa5ECh37Z/z0u3YLfe2j64QT/bpuZVTwHerakF0SbA?=
 =?us-ascii?Q?B3dgp2FdegNuISlx2BZfAwfa3073uaOY+fRmxxKlb8lN7J5D4AlMbXaGET11?=
 =?us-ascii?Q?gR/I6htjKqlLh9CpRSVprVXl0cp63zryPGdnl5sofUOsnMqwmRun/2T1o3vE?=
 =?us-ascii?Q?9yY+YV68wYg0Fadgz07V5zKlMtAuQZ3RC1r7un6aL9rCmcBbewxfI73TsQck?=
 =?us-ascii?Q?G3y3y8JF4uARETOjQwqjjZHerfaYD96srz/8IWRZU19GnGuaLUwL0D9qJcga?=
 =?us-ascii?Q?j2OBCRn+cFG2PbU/nu8eXcFVh8oG+iUmPgVZRatNkPc1Sbvv4+APY0N4DQ+Y?=
 =?us-ascii?Q?XxIomATj3nu9rbaTBlnAYYN+pm/VYGnUyvbJp4MDPnDuQAQEX0nJ1tEoHYsN?=
 =?us-ascii?Q?lJ64k0Lh0dq8PS4yvNg68/8JiVe3M7Tdnj/1Vv37Pmd4yS01U+cA1wvN3H7m?=
 =?us-ascii?Q?lUQAMOY3nx0MgrOp7IhE8LxyzAH/3ZZNWVn9LQs8hMUeCwftL2iuo2uTS0iH?=
 =?us-ascii?Q?/1O5DSLKj2k20D1IPmRjKyBtpdo+NDsXmAwm2k4HCd/xV7WhCDzYeQkkwK3R?=
 =?us-ascii?Q?LqGqitjhdgssSY5Sqld8txNWF4M0ZHrrqIiYGpHVrgbGUMD6MsMjE6h0EHGz?=
 =?us-ascii?Q?h50L/MnuN4rg3c0Ity/Cajh2lEgE5pB0TNJqM0xc8dnH9N4d/rDEwqgXcdWq?=
 =?us-ascii?Q?Ds/ipZOSXb9MXeGwAyhdCHvjtyQYAKK3lQdEDLS78sM+Q5x4VJmHx6g9GOD+?=
 =?us-ascii?Q?tt625I5S5ExMnxpGzoxLHsgG4gYccrxuoU3+LDGbUQefrHVFg4wq8k95JeF1?=
 =?us-ascii?Q?MFQanZu/i80CXdeeq4awWC86NZoSRiofhSn/o4gLlvb4NFqh6XciSat8bE3R?=
 =?us-ascii?Q?oZ+LZOPqtwFpwCdAgbM/YdPbm/vIPQseXfQ6EhCz9omgmGPR+QEXkttrX6FO?=
 =?us-ascii?Q?i3p9JdKzLUmBSUMautkourWLSdBaCFI04DrHYQaP6Z7z/x/FCjHusm1m3S16?=
 =?us-ascii?Q?qDejDsWdYIFeHusPna72Tf0ivrDEMBM+/sKMqvZBySyGh5yqdjoUu3JMFbbV?=
 =?us-ascii?Q?eDQyLUB+pLqpCk5yEaHPeu75sdtfU2LK7jbfXF08kHb9S8KmpCml/k88v1LI?=
 =?us-ascii?Q?1VjZAuxOlVvbiuBiWrS8L0Zq3drHbksPYN9dV4lxt8TOL1Uv3cu4eDyx1/K2?=
 =?us-ascii?Q?Y9xFvsiFEuSm26T3IqBEw/D3PEPA/vIJ8F2ScyimIHNFxiEgVi9J4ae6sOAz?=
 =?us-ascii?Q?7yUDVE8Vx9/rpfW8bSN99t9mTcdzOdu1PX5Zzi8kVpDxPnUJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0248d35-1bb0-4b64-30d9-08dee2d80a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 01:17:44.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54kvJw4uj2Mg+YlaGIetRaj8zyf1UkJf3mMwOj1f2YGpoESnnUeqHnCwqPN8gthBAld/ZKdh6WWKdj0tHLC26w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6034

> On Hyper-V the MSI retarget hypercall is asynchronous. When a CPU is take=
n
> offline, chip_data_update() frees the outgoing CPU's vector inline becaus=
e the
> deferred cleanup-vector mechanism is unavailable for an offline CPU. A de=
vice
> interrupt raised inside the stop_machine window can be posted to the
> outgoing CPU's old vIRR after that inline free, causing two problems:
>=20
> 1) The completion it carries is lost, as nothing drains the old vector
>    once it is freed. If it was the last in-flight completion on an
>    otherwise idle queue, the command times out and the controller is
>    reset. This is the functional bug.
>=20
> 2) When the outgoing CPU re-enables interrupts during teardown, the late
>    delivery finds VECTOR_UNUSED and reevaluate_vector() logs "No irq
>    handler" - harmless but noisy.
>=20
> The native MSI path (msi_set_affinity()) handles this race with
> VECTOR_RETRIGGERED + irq_retrigger, but the Hyper-V MSI chip carries
> IRQCHIP_MOVE_DEFERRED and reaches the forced-migration else-branch in
> chip_data_update() instead, so it never gets that protection.
>=20
> Mirror that protection in the forced-migration path:
>=20
> - Issue __apic_send_IPI(newcpu, newvec) after installing the new mapping
>   so a raced completion is drained on the new target. The retarget is
>   asynchronous, so the outgoing IRR is not authoritative and the IPI is
>   unconditional; a spurious or duplicate ISR is harmless to the MSI
>   completion-draining handlers (NVMe, netdev), which find an empty queue.
> - Mark the freed slot VECTOR_RETRIGGERED so the late stray is absorbed by
>   reevaluate_vector() rather than logged. The write is unconditional
>   because apic_free_vector() leaves the slot pointing at this irq's stale
>   desc, not an unused entry (unlike msi_set_affinity()).
>=20
> The migration runs under stop_machine with interrupts disabled on all CPU=
s,
> so any raced CQE is visible before the new CPU handles the retrigger.
>=20
> The guard is restricted to edge MSI vectors on Hyper-V: it requires
> X86_HYPER_MS_HYPERV, an external vector, a non-level trigger, and an
> attached msi_desc. Only the MSI retarget hypercall is asynchronous, so th=
is is
> the sole path with the race; edge IOAPIC lines retarget synchronously via=
 the
> RTE and IR-remapped interrupts via the IRTE, and neither is touched.
> Narrowing to MSI also keeps the unconditional retrigger confined to
> completion-draining handlers, which tolerate a phantom ISR, rather than
> arbitrary edge handlers. The slot marking and completion drain must happe=
n
> where the vector is freed and the new mapping is installed, which is why =
the
> guard lives in chip_data_update() rather than the Hyper-V MSI chip, which
> cannot reach vector_irq[].
>=20
> Verified on a 64-CPU Azure VM: zero "No irq handler" events across 320 CP=
U
> hotplug passes with concurrent NVMe I/O, compared to ~460 per 5 minutes
> before the fix. No NVMe timeouts or controller resets observed.
>=20
> Fixes: e84cf6aa501c5 ("x86/apic/vector: Handle vector release on CPU unpl=
ug
> correctly")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.8
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

I think this patch is correct in that it retriggers interrupts unconditiona=
l on Hyper-V. This is needed because Hyper-V does MSI retarget asynchronous=
ly, unlike all other platforms.

As an alternative, this can also be fixed in fixup_irqs(). IRQ layer alread=
y has this logic in fixup_irqs() for dealing with a lost interrupt when pro=
gramming the chip for retargeting, calling chip->irq_retrigger() unconditio=
nally for Hyper-V in fixup_irqs() is another option.

Thanks,

Long


> ---
>  arch/x86/kernel/apic/vector.c | 48 +++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.=
c index
> bddc544653999..3577e9ca23ba6 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -20,6 +20,7 @@
>  #include <asm/i8259.h>
>  #include <asm/desc.h>
>  #include <asm/irq_remapping.h>
> +#include <asm/hypervisor.h>
>=20
>  #include <asm/trace/irq_vectors.h>
>=20
> @@ -152,6 +153,7 @@ static void chip_data_update(struct irq_data *irqd,
> unsigned int newvec, unsigne
>  	struct apic_chip_data *apicd =3D apic_chip_data(irqd);
>  	struct irq_desc *desc =3D irq_data_to_desc(irqd);
>  	bool managed =3D irqd_affinity_is_managed(irqd);
> +	bool hv_retrigger =3D false;
>=20
>  	lockdep_assert_held(&vector_lock);
>=20
> @@ -181,7 +183,46 @@ static void chip_data_update(struct irq_data *irqd,
> unsigned int newvec, unsigne
>  		apicd->prev_cpu =3D apicd->cpu;
>  		WARN_ON_ONCE(apicd->cpu =3D=3D newcpu);
>  	} else {
> +		/*
> +		 * The outgoing CPU cannot use the deferred cleanup-vector
> +		 * mechanism, so its vector is freed inline below. On Hyper-V
> the
> +		 * MSI retarget hypercall is asynchronous, so an interrupt
> raised
> +		 * inside the stop_machine window can be posted to the
> outgoing
> +		 * CPU's old vIRR after the free. Two complementary steps
> handle
> +		 * that (see also the retrigger at the end of the function):
> +		 *
> +		 *  - Retrigger on the new target so a raced completion is
> drained
> +		 *    there rather than lost. The retarget is asynchronous, so the
> +		 *    outgoing IRR is not authoritative and the IPI is issued
> +		 *    unconditionally; a spurious ISR is harmless to
> +		 *    completion-draining handlers (they find an empty queue).
> +		 *  - Mark the freed slot VECTOR_RETRIGGERED so a late stray
> is
> +		 *    absorbed by reevaluate_vector() instead of logging "No irq
> +		 *    handler" while the CPU still takes interrupts during
> +		 *    teardown; __setup_vector_irq() resets it on re-online.
> +		 *
> +		 * This mirrors msi_set_affinity()'s protection, which the
> Hyper-V
> +		 * MSI chip bypasses via IRQCHIP_MOVE_DEFERRED. The
> guard is
> +		 * restricted to edge MSI vectors on Hyper-V (msi_desc
> present):
> +		 * only the MSI retarget hypercall is asynchronous, so edge
> IOAPIC
> +		 * lines (retargeted synchronously via the RTE) and level-
> triggered
> +		 * lines never see this race and must not be force-injected.
> +		 */
> +		if (hypervisor_is_type(X86_HYPER_MS_HYPERV) &&
> +		    apicd->vector >=3D FIRST_EXTERNAL_VECTOR &&
> +		    !irqd_is_level_type(irqd) && irq_data_get_msi_desc(irqd))
> +			hv_retrigger =3D true;
>  		apic_free_vector(apicd->cpu, apicd->vector, managed);
> +		/*
> +		 * apic_free_vector() releases the matrix bit but leaves the
> +		 * outgoing CPU's vector_irq[] slot pointing at the stale desc, so
> +		 * the marker is written unconditionally here. (Unlike
> +		 * msi_set_affinity(), which marks a genuinely unused slot and
> +		 * therefore guards with IS_ERR_OR_NULL, the slot here still
> holds
> +		 * this irq's old desc.)
> +		 */
> +		if (hv_retrigger)
> +			per_cpu(vector_irq, apicd->cpu)[apicd->vector] =3D
> VECTOR_RETRIGGERED;
>  	}
>=20
>  setnew:
> @@ -190,6 +231,13 @@ static void chip_data_update(struct irq_data *irqd,
> unsigned int newvec, unsigne
>  	BUG_ON(!IS_ERR_OR_NULL(per_cpu(vector_irq, newcpu)[newvec]));
>  	per_cpu(vector_irq, newcpu)[newvec] =3D desc;
>  	apic_update_irq_cfg(irqd, newvec, newcpu);
> +	/*
> +	 * Drain any completion that raced onto the freed vIRR by retriggering
> +	 * on the new target (see the else-branch above). Issued after the new
> +	 * mapping is installed so the handler is present when it is serviced.
> +	 */
> +	if (hv_retrigger)
> +		__apic_send_IPI(newcpu, newvec);
>  }
>=20
>  static void vector_assign_managed_shutdown(struct irq_data *irqd)
> --
> 2.43.0
>=20

