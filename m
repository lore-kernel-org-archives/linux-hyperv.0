Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793213389;
	b=GOgGzehG+pqmvZ8jf+QvIgF6I1YJeHssPueXlvWM5gX5zjMY/0orBUnx4g/BdLUVfuQw
	 7o498ff1rRHloAhhI/RMgJz2GWfkFPAldF/JTt0hEIIard66hMHqSuREZHW/7MASnOUXw
	 VX2pg7Fz4GXGr+hq5tiDc279cHD9dQ/RD8kz9YOoFPyj0DjAx+9mqNziA6+23fthoBCH8
	 i9O3yAGX78fxasG/qCY62D83NoP8lrjyH1vkb4UKw1J+GEqg0hQ1ksNTsXYx70n44Rmjl
	 8w/QKuO5Q6tg2Gff69NL5LfYBbC2pv4NrayPMeQZgMxIUAjJQkPuqXJOulvum0yqKqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213389;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tO8C4Qy+aaDa9wY8yiJc5V2+npxc3TZfW6EMJ1q1Ch8=;
	b=DdwBE8jec+2eCZFso5+VYsvDuR3yOSjnm6ZexgyyuUBA6yaAO4TSvPdr7Ap1jiCIY1rV
	 PXQkOgbumgfQ2eMMoNqBdnozWjKrFNbeVu2EveCC++WWoF/h46wTMmTgShQHG3sEUw03c
	 9aHjoeXe5UdXxr0ZsmmC+j3UCLaOyrArkgY3Y4TAcTQrk7or6bVvm4NltlcytoX6cV9di
	 vvqev36sjhN8i2AVVD/42sWXylPTbLJmf0InC2VwF6P2qWPVOdU/NLIaHGeGwiuk0/nTX
	 8+hAbI5k+E0g6DUH711uUMhfm+wIdqd0ztNKrWQ8Dk9dLawaBxA5dbpTfW6eP3iGDbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=miOrfYOF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.85
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013085.outbound.protection.outlook.com [52.103.14.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF37606A31E;
	Wed, 28 Oct 2026 18:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF37606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=miOrfYOF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/lWs+/WUIdgQl6Lk/tXXaptSUtVk+ROavKTdLD0DXnoQt1am+Z7XYMk4TLbZeANMdBmj72XpeoooVPXcjsHwmNGwXg/bA0MW/9JH/GGhXMd0jLSURGPYBV1d9ewf5rKUjjiifWCweAVgLmqpu+ua/EiJb5q4zQzRJz/akxxcHH5+gUwM4vrqQa7kQmx+QewQHHF317/Df1acQbXEBOYQDHubAFUhV2+eRC2eSXX4t+BuXWAM8ULrGFW9CqsPmzlv+u3p9WpBbbB66b2sY4cZQNkSYosdRhFhvueRK2yALLw8RCLaM9zfA7RMAWlnKzZHC/kBFCmFLiFwtkcQpM+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO8C4Qy+aaDa9wY8yiJc5V2+npxc3TZfW6EMJ1q1Ch8=;
 b=NzEpIpHJgM67EXKoRVXTE3yoJvpCf2XGgGizUOQuGTxBlQqEmbRC4V4gZtDkUc9IIF+R3vM3vZNvwpJ8hnN8vIIQVnzVmFAzXV4sDrCtGwAIPXBFLvZj1VhmVltbyvIY53blX0R7Y+19VsDMf4zevpKudTcuerMCbx78ih1YNeh9ECHnZjkBUKnIS9JlCm6m0lcJ0fCE4ybNV9qrrWX/9vUxBuyqf3VDV7UAQEpANrK0d4EFQz95bRiDmTLMiA0dB4sKOkgNo6svR9iepFAZaI5HOhLZ30zX8grP7trclVH6Yfde14LUjzNLl4e03h9O3SM/Ul1F5mmtGAK8EeBe5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO8C4Qy+aaDa9wY8yiJc5V2+npxc3TZfW6EMJ1q1Ch8=;
 b=miOrfYOF70+VaPYHDUdtDAvQ3/xj1N0Jl8/VJma0dsasLjaCOsI9VY85ExXhYG813MKztydob49rqLfcHP+pH6RNsCzjFaifb+MRvRI2DLhIS4K97OrFioq4AeSyAmZNboFxCBi/igAwRi30QOXZEZqBdpozIaz8Hi7fiD3C/HDEqNxI83gCW02YsH5F1fTQes6ZBfDqtSQm++dXF6b7/GvID4homUEan1N2dtPIUYxn27FGKFtRRm3Oi/Sr/72xnOOzQ0WnEMn/pPL2d4/KPbB8cBkfeR7WbRKZd9ZwoNgfsLFJGniyVw1gVU9UiDW1lhJJDUsbM/1KHquRFvpLag==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA0PR02MB9171.namprd02.prod.outlook.com (2603:10b6:208:43b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 18:49:46 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 18:49:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Thread-Topic: [PATCH v3 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Thread-Index: AQJL0oqSHe9tk39NevHpOtvtyWIWxbY2dEuQ
Date: Wed, 28 Oct 2026 18:49:46 +0000
Message-ID:
 <MN2PR02MB68636BDF288A70BDBACDC2D1D46F2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261028155559.138833-1-mhklinux@outlook.com>
 <20261028171348.GA560291@bhelgaas>
In-Reply-To: <20261028171348.GA560291@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA0PR02MB9171:EE_
x-ms-office365-filtering-correlation-id: 511b659d-9641-43f1-c3ba-08df35243ccb
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|13091999003|8062599012|8060799015|25010399006|37011999003|31061999003|19110799012|51005399006|15080799012|40105399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C+uGQOk3C7CgcIEZdRPMpHSA/yzzyiK6kiFrQTiEIGLdlWQ6My2T5AwyX6X3?=
 =?us-ascii?Q?JMxyRbUIvWhSRq800gm/kTd/G7k9oZomGG4EJYTGj0VHclRVJfaO60lfodTv?=
 =?us-ascii?Q?yv777nVDEnhl8tjymSJ73XVHEHEQFgzTmF4ip4ySIfJ1qRP5VLgwWXKfRXH+?=
 =?us-ascii?Q?4B53ahB6FjVGkCAc60+hCoGaFhgSWoFrb/rc7R9F4uV9mrkhkif3lbDDHl2s?=
 =?us-ascii?Q?7zAIEdV+dR4VNJWjjHHum97Jj/Qll9UGXbyqLvaz4Way8oJ+YI+2k3nAZBcf?=
 =?us-ascii?Q?JJ2Z/DI8C7pbOLMnUPeTheNCAcpigZCB+V0erwVE8A9C0+bKCxk0dsgeZepO?=
 =?us-ascii?Q?yxKhRkiMH7dErM6k+SfczI1huPBrgMM2aVu7u4G9tYkVzUWU0O6O/dBCRH3f?=
 =?us-ascii?Q?VQi4mfiPucFHSlXgOSPv80lvSyPLN6I8HEWIWnDuuTGp1vKWA9MN0RyDLrzV?=
 =?us-ascii?Q?btrXR5cyIqaUwO6Bdy7G1bmeLoF+Na7AYFYyA/eBHF0B/9coIkwYorvUqseO?=
 =?us-ascii?Q?vhydijhkZA6AZc8AS1c8IGdFk45hhjfvlSJwUaWOEraDxhmtRM1Gmect7nLY?=
 =?us-ascii?Q?2ryyYfL8uYTeUEYpII3T9S7pgg0HTamSBkJWAHcCbU7Dx68Tr4fIvd4nJMFJ?=
 =?us-ascii?Q?DlaucUapcgfc7LUjFZzSxffasxublpXh+r0rFndqS3aOmPktJx2lLqwdUDli?=
 =?us-ascii?Q?dwq4vJcCftGcjeOJQV7jrkkalCo3VTiD7J+b/K1sTWTJnHueC0IvCxhVSAo4?=
 =?us-ascii?Q?kj91CNB6nBNYavkjEo2tkD3fMpwa0YOH4iL10fA2u42rknW7WMdl4QlfY9JR?=
 =?us-ascii?Q?mh4q9cYQjT7sY6wOW4TrXALs24LuDSWI3cFSDGa5lTiUyVx6Cb3Y5X/WrasX?=
 =?us-ascii?Q?ST+HrfVLtrVjWz6zvyxkEd/2j/z9a89QNQet83A/Apo2siGoOCd7jDbc60iC?=
 =?us-ascii?Q?PRCeIJsipYX5iZgAnkavOYy7XMGBmVk/bNTnI+i4swQdMkT7sBjwsxulqcR7?=
 =?us-ascii?Q?u3wkukx0LF86X6/ZDsTx4eLCyg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Eohi+IRyIu2JXmMf3/CBN0MwmFSNseNl+9PJoGf1ORAGRMFQ3uOzXUc2uy7W?=
 =?us-ascii?Q?YFP/dK5UjVKPRKxxgZ+csVSHhDCLmUgJF3bvPKCCaBK2q1hGSweoNuRf4vfZ?=
 =?us-ascii?Q?LHkM7B1iy+OnXpciTsydTQ8+eQLoN7bieFduSLXaNLGBQx+eReCbask+7wXu?=
 =?us-ascii?Q?5xJWQ0A9BQlaB9urUsnSs7BNyJ+kUSIwpc4FJRtmB+fgf1iJ+TadFrVwn2RV?=
 =?us-ascii?Q?yw7tUksnOuUSNutmTbRLxgSrbQbsYF7iWIgnHtS741zCf3YFO27lIrxGCEWg?=
 =?us-ascii?Q?hYOgfRHWJ9hU9XSLgPy/FxfP4DQznRUaSF/Ir0q+8IKdaZLLM6EZ4vtx6kTy?=
 =?us-ascii?Q?xvTnpR2uRX4c5ZN1IjDWBTXjD3ngS1dRwM5yEtT/m5980Toy1BSbRV9jyDY4?=
 =?us-ascii?Q?JPeovLN0ZR/HkUVg1ediVzAe7LjyJwzmmZrHL+6Ij+7MrLgVoUzumgvDQ7J9?=
 =?us-ascii?Q?fGG2PkTr1sG3/Vyq7khOvKvVFI6u2EDPPCq0tCJM9W66B7RetbfZsj96YS/5?=
 =?us-ascii?Q?7YPoFY0BWZ1gftQAzzqW1SETS6ILXTpkfeCahABI/Pr14ipvsH0CuF5FyqZv?=
 =?us-ascii?Q?FpE0wsUJZ+q5c/8SP2t2Ow2ZtBinJ68GOWnAp88bVIzoHUYPNUdsbj7QmYdI?=
 =?us-ascii?Q?7UvEjznlUXQFRBMMkdSJm275BWZSZVArKXuVhB3anaBvVF2M8LBVF+2BvDWS?=
 =?us-ascii?Q?JmxuQ9VkbQHVrScpUCOeflqP8tUqZTGwuZLI9+wSnAiaDrFBhqieeovBev7Y?=
 =?us-ascii?Q?FjgJ4Q67m6ks0MZFaHgYK4S040VF4hYjqM7K1PSOSaV5eitOBQE1RanLXutN?=
 =?us-ascii?Q?vsgwgvTLOaMQJOFDkijXkABPsEstvqiCMsSSzX2AhlL2DZrDcVgjOTnUC+lM?=
 =?us-ascii?Q?NFggBPPk1GiInJIJAulb9jhPgLWxvQdtE4NS7JeQuiO5OpbHqWbBSHiQdKrO?=
 =?us-ascii?Q?XGfjue3u0eCTavMV0jdf28NMXRMRfSg6lNm2+lA6OQvjJczox0L+0+ONXKe6?=
 =?us-ascii?Q?E9XKP/w8X0I2NFFTPqEMm45z4XVEJMLg+6Fdq6Yuep5KFP2rxZBwacbNqHP8?=
 =?us-ascii?Q?IM0OvRvwkjVeXNZD6xojfalwFLlg1H1jpQwG19G88wOl7msEfCvxmh83HHfl?=
 =?us-ascii?Q?Bv3DVk2ENiNHUoT+pkV65iibdM8mqVQP4vfVxhcrgKIFG2GR0aO2v8SmbcIq?=
 =?us-ascii?Q?xDa80eguriYI/e+nlKtCTteK4rwacJGD4G5Gx7YYTipYFnPb9AVZi65Z88Fw?=
 =?us-ascii?Q?LhnZnVlTsqzGXZ2TK9VSwN/RNZuRnYT7yrwA9TSuYru7LcL3AttpGetpiHE1?=
 =?us-ascii?Q?sHCHdB/wqGB8z82u41GEgVRw7JzLAYnnX9ZDMNSYhDOCTgNsJdjsnElRRodw?=
 =?us-ascii?Q?k1caEPs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 511b659d-9641-43f1-c3ba-08df35243ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 18:49:46.4906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9171

From: Bjorn Helgaas <helgaas@kernel.org> Sent: Wednesday, October 28, 2026 =
10:14 AM
>=20
> On Wed, Oct 28, 2026 at 08:55:59AM -0700, Michael Kelley wrote:
> > In a system with multiple devices with the same configuration (such as
> > NVMe controllers), the affinity masks are the same for all such devices=
.
> > Linux typicaly must select a single CPU from each mask to be the effect=
ive
>=20
> s/typicaly/typically/
>=20
> > @@ -881,25 +1016,48 @@ static int hv_pci_vec_irq_domain_alloc(struct ir=
q_domain  *domain,
> >  }
> >
> >  /*
> > - * Pick the first cpu as the irq affinity that can be temporarily used=
 for
> > + * Pick the first CPU as the irq affinity that can be temporarily used=
 for
>=20
> s/irq/IRQ/ if you want to follow the majority usage in this file, also
> below
>=20
> >   * composing MSI from the hypervisor. GIC will eventually set the righ=
t
> >   * affinity for the irq and the 'unmask' will retarget the interrupt t=
o that
> > - * cpu.
> > + * CPU.

Thanks. I'll fix these. My own preference is for "IRQ" anyway.

Michael


