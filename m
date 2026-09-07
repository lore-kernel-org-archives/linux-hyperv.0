Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010002.outbound.protection.outlook.com [52.103.12.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F8412269;
	Mon,  7 Sep 2026 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810838; cv=fail; b=CKDhx9MWB2ReTp2kFURcTzMfGyzbRQ048TVM0NGomi76WeYcOwZPNkNnN78Op0IxF0FanvKIzYRg9wJQdgn1Btj0xUXolE1/hD7PR68K/HbUadz2b9ryhXgI6vlTc8wHOZEh7Uwg65BaaLG34LQ0TW/9CcuA5zGisjkuOaXBV8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810838; c=relaxed/simple;
	bh=nUdD9swQuvDzo93XPzbUwFdytc5+iJ67X6dolxVkz0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NrKkLH/NWHw0/H4SdUfq8t4jf+94MH0NzsgMJNyNIHGOXF3SlDhe1uI940R2jSc5k17tjZqdGTQVxPK0rxBJiv4NO1V4YY5Bsj9fBWGmPIg3OyUAzst4Bi//jS3cFbHm4J4ROfzSr79oCMFVuWsHYFLHxNPlTc5ye4QrF8th20s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dWIG+dw0; arc=fail smtp.client-ip=52.103.12.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dWIG+dw0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh6nSympayFTvAGJMRyWCaRUC6UUt0pw3+qT6aEF7avGgch3eTnPout94wPi1XKCOROfexy/vp/jdwgSnaI+qT5LUNvlIVbwMDabaJzNqnDdv/Vzub0x9Z1mlYk9o8FGWM0bjsdmRA+ZlxLcDfjEGKf5g+kbudZP8lqCVMiKvwySFqcr2uOz093Lh6FM/BCxmvcv+dVjXXWTSVsPDWGFssPLpw7C2FjISDmEJXsPZlAaGGRBDCb5irM4sqhlQjqDgMuDPoqUE11vArobeRbaNNWsfUpJAtaJHxpbRpuT+BIf2n/R9iZhc1ipTFUNrsTq7CZD/454X+tim0iaufOYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO5XbhQBZVrN/zNBK7nzQxQrRcQnXH1Bl2LpvWI6PZc=;
 b=vtHJTbJK2I67iIjKi6DMN0S1IC5da8f3awA2lsOMBZN0k1x7YI9bSNFTQHmYOoZ+hd2YvMc355XU0XuYAM/ZWAM++rQ3soNObRppZ38hctZ1uuZUE1yyda80BBiqWdpIv+7Xq2vnOFVRxxaVTW/0qZi64jVX/3xErhmTrveLqxoDFrBGqPDY8eVi/2cskj5Q93ourJaIrSAP3eaXSyOnEt388/Gc48lsGwB919YEhzRUz59w18Ovhni8Cg3TiaNo+KypyaafJ23PZt3NpQoDyWZVBNlaHLA35onIUxOBxRMBtuwL3rdD0mZERaMkqSqhRdk1cbNuC43fLcRPESIZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO5XbhQBZVrN/zNBK7nzQxQrRcQnXH1Bl2LpvWI6PZc=;
 b=dWIG+dw03NzaMuiiYsnOuDl0cFGgebfYRSRJ3QMmxyi15Y/lbkM/UNRu39aL1D2sk0/Cb+QX9/Bk+hr4a0mdHwAWm+ECPkcFGruQNieovFaygU5cPdMvr6YYTmLhqg0e7wLmqIzYzzCfNYyZpfTE116TisDi/JZjqhZNIc/bpmTLCw0qM9VFf/OU9KSdxTDlgLL31h+Mdf3aThQfcukfNULWWQ3LYaXWmJlhW3JZA2Kwp/gZnA/bQ5Wsp2lhhR3IN4qZCOU1IJojQc56Wbm9L8LR2kDFEKxx0tXDlGZlc+Kq+3HH+mhVQcYzJI+8c+ZxBGAn8XzZKzxZ9JC9Gcztew==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6526.namprd02.prod.outlook.com (2603:10b6:5:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 19:53:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 19:53:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Wei Liu
	<wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
CC: Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>, Nam
 Cao <namcao@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Kees Cook <kees@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Radu Rendec <radu@rendec.net>, Sean Christopherson
	<seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Dmitry Ilvokhin
	<d@ilvokhin.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thierry Reding
	<treding@nvidia.com>, Jiri Wiesner <jwiesner@suse.de>, Daniel J Blueman
	<daniel@quora.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
Thread-Topic: [PATCH v3 1/3] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
Thread-Index: AQHdPpVjaBt36+FjHkeBEelzCWVOZbbDiAow
Date: Mon, 7 Sep 2026 19:53:52 +0000
Message-ID:
 <SN6PR02MB41570E8F17B6A78AD607F91CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-2-namjain@linux.microsoft.com>
In-Reply-To: <20260907065129.269262-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6526:EE_
x-ms-office365-filtering-correlation-id: c81b3177-c2b0-4273-c3e3-08df0d19be3e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|31061999003|15080799012|51005399006|13091999003|37011999003|55001999006|24021099003|25010399006|4140399003|40105399003|2607281247196008|18061999006|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?J3pnzn4Q4uKyA70er/L5IMwwRJ8Az0XcTes8G+FamTi1E8GFcgqYYQcNWz?=
 =?iso-8859-2?Q?8EPula6209J3V/ZhI+B8khgvT2DFxxr/UmMs7jrSOkvG2PR8rSenjwXyL8?=
 =?iso-8859-2?Q?dTdl2rW0d/sQDbLG/og8yhtJLYwLCOG4zAwFkAvpi5op91DRRlgOClaFFN?=
 =?iso-8859-2?Q?LYxSk9lKfgc3vtFW4VXP3J5Vie9HTLlInAdFGpwQ3+gvuMHOlADE9vIPfb?=
 =?iso-8859-2?Q?5x8PlgW41Nnbd0X94L1aHf1Ii5lJwjvExCRmxwR0jHbXTJQfUBdFgiBFgk?=
 =?iso-8859-2?Q?K9bEWQfrziFoFSJzvVRl5WmxiuyaDj3TLi3hz16Oefez2DzRj7vlN0gatN?=
 =?iso-8859-2?Q?qNbtjmfjSWbW7rXme1NJ4/HelOM8KCR3vRCE5w4fydKlwE0ji6opZFA79f?=
 =?iso-8859-2?Q?TntmECnn/sIlpJwD8lkXeeLR/6uuxAGXM9oVB6nyWVUrrg0X/XO+CWU/l8?=
 =?iso-8859-2?Q?3CIHh9lwm4U4O9H6F557XKeesCCtVQuz/fWJnl71gDRXgwsywZm5ItEBj/?=
 =?iso-8859-2?Q?k2sGPigOtsGdYG7AhuQwRHVn6/sVhWika8wUGw+hXuLXjqgisKf3RxZnwb?=
 =?iso-8859-2?Q?sKmDYM03mNGM3yGY07R5oCwoc1wv18P/gUvPvML97wRshpPR4suoqhTZ3V?=
 =?iso-8859-2?Q?3KbcL/ynk4s0lJ1SRsSDqx460Xdx7zkFFrinAH84CMGCKBy0Xzzu+vtX/X?=
 =?iso-8859-2?Q?+PXybNFwz1GCki0GAOG7R/FU5bZDCi8zmgAyTQx7du2OSQpIuwkVDclVpI?=
 =?iso-8859-2?Q?OKVYrEwU+WA+EaiQUYCNOEa6hIRprkRb88v8pkGpWkRusxKaVMgQHlyofY?=
 =?iso-8859-2?Q?1/yBWEM1a5fSWICFJvrc0u2PADUooAXNYfshkjHDrq9L71yJjE7GMVVBvH?=
 =?iso-8859-2?Q?P5RnnXi9mmpsvR5fwWt3QruBhmR5P3/MEqmExerhh6woZZNO/cR6XLZGNF?=
 =?iso-8859-2?Q?wOK3y3qvUZXx905xprn8nzsepGQfLb/faF5rPnsInGDG44eNfWSEZyHEzp?=
 =?iso-8859-2?Q?VsZ38Nyo+VLcmPbWAhTHR+fUN0an6k8eqjiIK5sQ1tNU6K7//OjL07RAWJ?=
 =?iso-8859-2?Q?dHbMA8JlHLmfcYoKl6PIwBPo6HCJJN6UX9DCbnEfV+4jhp576l+E8+BO9b?=
 =?iso-8859-2?Q?7r1gCIRYxsvR8aCR0L6fgoiwa3fkA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?QVQrHc5seQzhjcjvY30NKYwB8bVVZy1n2YeguzMjC2pPG9jhj6DgN2XQrG?=
 =?iso-8859-2?Q?Pg3uLCqpOWToFUepRnXo66j5+4qv13nrRxtm89tWgTeQZswWkbUCbGKCJQ?=
 =?iso-8859-2?Q?NfnAt7oFkKq+usSsgjNL6AO6I4gzqATfalJLNjtPTyAyi90wpbQAAzdNf5?=
 =?iso-8859-2?Q?EN6XwnFRmpYBbsbA7rGr9y6fbmPJojb1qVie9hOPOyn27Ywd1ad5/zH74q?=
 =?iso-8859-2?Q?FzinzyFRbWSZm7mPOAcxAhfXS/Sc7KrfbTGVRRSKoL/iLIbMs01i68EI1M?=
 =?iso-8859-2?Q?Om33el8KgTgAHtcZZI/O7vRauPo7jfdXHydXBb0T/PJ79BenEBe4SnHWSH?=
 =?iso-8859-2?Q?A6i2Sz1xSaoYJVIkOkVOW5sMc9JLiecQ6+gkEIOdGqRQ4hBAl5Em+EyhX1?=
 =?iso-8859-2?Q?G0gDJKYvXW6U1UBO4aEliuqIV+2OkRPLFhHxN5PuBOzF5V0PiyHNEpMrB6?=
 =?iso-8859-2?Q?JkoWtI4ll1/TLBwnWTemfBVZwsxXXR1yzS38tK5oHOimJrvm7ZO4gSp6QZ?=
 =?iso-8859-2?Q?npqx6KTh/SB3K2VqAOWo9z/CFGRRoSqSgZ8TMi8jgSALpNPxa+QT5KWap6?=
 =?iso-8859-2?Q?7b3RZYxoSUuYx/eosAV1gaRIRpZoqI2RTyBapRqvYVhDNHlircC8B+kMEs?=
 =?iso-8859-2?Q?Wq3skXj9qqijn2USBJWEt3Sg0k6SUhlLJyr/52+KKJMMghpxmAT8qqsW4a?=
 =?iso-8859-2?Q?0ycUq9ZDYTuH93AOKYK6NrD033mJyvXFyVe8oyBvq0AWff+GawFZRBRyQk?=
 =?iso-8859-2?Q?F8dStafENXeIIOGKeLtCv+KlYOtbh9D12GpylRCCwvoc46/zpLbMMek6DC?=
 =?iso-8859-2?Q?XSCUiKkYNcA0RxAYhEQsD00Lbq/nSHTgVUTdaK5dS7dD+GRo+qitpVnus+?=
 =?iso-8859-2?Q?PPJqOReKUwEF2CEgW51S1LLrnmuz/SzU5g0VcMIHP1Y9YsQo1vc6vVL7mg?=
 =?iso-8859-2?Q?SCsyhnz02qilDg0T54dMD5I4HrfvlxtqxG3KmcRVNHpOdvRCjqNIoBXqIs?=
 =?iso-8859-2?Q?lu7eA5Fi6T3sbBgs8utE4kVRTgJ451J2oxd43nfgNntPeKDdN1D3pK7060?=
 =?iso-8859-2?Q?tM/+R5APi9kxJ0myhfsMmAuppOjHT7Qy5+IMAreMGmY7/+q5SumN9eDrIn?=
 =?iso-8859-2?Q?lk6cDmiGbbDyyGKS4VOZ4QSQhOGwQHFyhVE0f6GwoVqbyfXa4Ph2mlJ1Es?=
 =?iso-8859-2?Q?iSpq7cbRa6SuKpFmtPM5lt6SijLKlVFYEWuxnTBZc1VzQkrbud32C0rD/B?=
 =?iso-8859-2?Q?DeW2rxaTzbcasiC3nrfVSWZqkbrm8wZa40meXO4CJUmSt7oRyVqEJ41sya?=
 =?iso-8859-2?Q?2Qj8gRLW9dKIzQUMaezyZJFQOXbTfSnSBYSvq7fvenICfZSUV/pEZ2Vi6G?=
 =?iso-8859-2?Q?6vJ2Fs2ADeudOru5mfsC0K/z5j9BD6kvEf/RECw8jIUAtKjOs0pEc=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c81b3177-c2b0-4273-c3e3-08df0d19be3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 19:53:52.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6526

From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2=
026 11:51 PM
>=20
> The Hyper-V root partition vPCI MSI irqchip lost its irq_retrigger()
> callback when it was converted to msi_create_parent_irq_domain(). The
> callback was present on the original irqchip and was dropped during that
> conversion.
>=20
> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine t=
o
> the outgoing CPU to a new target. If an interrupt still has its pending b=
it
> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on t=
he
> new target through the irqchip's irq_retrigger() callback. As the root
> partition PCI/MSI chip no longer provides that callback, the pending
> interrupt is silently dropped, which can result in lost interrupts, stall=
s
> and "No irq handler for vector" messages during CPU hotplug.
>=20
> Restore irq_chip_retrigger_hierarchy() as the irq_retrigger() callback fo=
r
> the root partition PCI/MSI irqchip, so that a pending interrupt is resent
> on its new target CPU via the parent x86 vector domain.
>=20
> Fixes: 4691db0704ac ("x86/hyperv: Switch to msi_create_parent_irq_domain(=
)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index b3ad50a874dca..1e273d7d6c5b3 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -304,6 +304,7 @@ static struct irq_chip hv_pci_msi_controller =3D {
>  	.irq_ack		=3D irq_chip_ack_parent,
>  	.irq_compose_msi_msg	=3D hv_irq_compose_msi_msg,
>  	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
> +	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
>  };

There's a slight discrepancy compared with the guest pci-hyperv.c driver,
where setting the .irq_retrigger function is done dynamically in
hv_pcie_init_dev_msi_info() instead of statically.  The parallel here would
be to set it in hv_init_dev_msi_info(). But given that Patch 3 of series
removes setting .irq_retrigger in both cases, the discrepancy shouldn't
really matter.

If there's a reason to prefer one approach vs. the other, I don't know
what that reason is.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>=20
>  static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *=
domain,
> --
> 2.43.0
>=20

