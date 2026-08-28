Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010021.outbound.protection.outlook.com [52.103.20.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE8373BE7;
	Fri, 28 Aug 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937677; cv=fail; b=Q1mSUtjSm1XGE6AssZtYCny6SrhkAnkfOC0ZhOKKah7g1wnimLx3s7zqFs/ZpMYvAhw38buD5/M7yU2MRqi5Owof8WFipyTueFjkPnFgSZXgmtWRq0UTM2KBMagtCWXQgew3R002zSfAzeqUFWp5ynoFwUp1KjLCfKmcEWgGBDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937677; c=relaxed/simple;
	bh=SMjzccn2lewmW/sYScQfk16ZuNSNTq1OW9bzzL2FOfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/50LI9p69kC0ZJPnSUhRIfhVr4hidhetyCzdm3S5hwU/5vT/yF2jXVUdXenq+QWVpx2tTt6qyAVmylCFo4MHuXqMn9vIQXunITjgHj3OIanP8Dmj2tiARidTMZjxbZ+jt0L1jzAcyLIi+kHMo2YCqWuWx5XjPiRGSZd81Twp5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GDfJJIB2; arc=fail smtp.client-ip=52.103.20.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GDfJJIB2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4Rm3yuP5HyV4fiAaKGgOWfoMiwBlR7aiN3TSu2me+/ueNq513mZOz+0QsthvVsCzeasB2Yy5maF3VUDZYL2OymHifEX/BflYIDaYGSH12hLh4ligsq+jdNO/pg95Q3KW9Iig3ZHT9tJXE8hDmgBZ9sg4EOWEdrSYjQHhQHRfkyiC+JLe2/WTqB+ZqO5MNH1vC3SF8QR8rzpo1ha+X18Hd5aiX5Wj83y4bOnXwgojkIxU8LAOHqYuIeFjOQeF36iSBkhLZJRDyJIgPvzz8MnLcPvp97cI2qdL4uH9QPSH9YgC9zSmHM37KanX3VS+TI3znvyPI/GQCPXvsQU7hpQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjR7CVGan6e+V3VSCgNMq1DOCZpC/yo+g1uSunHxlGY=;
 b=eoTEPjOgPdOd8IyGV0/zsX5J4mY0lrpXlan/MzqDnIi9Eva2ztI2keSPXOnUMW5pKWW4PX2vcqIhrc9FYFrvr8M96c1RuSrWBdoaUlk6VDL0cSPS9lHGWN4S57Mvqni7stwjQgH4rvakVTHSQjgWIUsG9hVNUNmiizDHz7zgvmhdPeP0yX9qhvk3pij1brPa5JWJJBznL5GFVwXu6h5DxgBkEW7BbxbSLFMrGraLqMSRhizgy1DoIyhBLHnp5Bv56WyTuhczWKxrFltWx8sVpZiMGiKtxY6ksVvarfmI4dxh7Le3AcKvpxf5lSMLt3NDfZcAHa+GvJfTkNk8B/ERqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjR7CVGan6e+V3VSCgNMq1DOCZpC/yo+g1uSunHxlGY=;
 b=GDfJJIB26K4jW6IcNWXdCSE1wXnPH7pqsGlWp3VEli0rBiNLGmrIc6Zrgs7NrTrWkFAYdKCZLXZpDjb7HDttQPlhV05/octgUblL0h3eh0drOLodlpaDeFml2mDOS+rzfxb/ErbDzaqOlpuE590t095U2YxFOZwMbS3rMtlqK6m8mIsliFgkPBm0vcGZOB1wyod7dZ4NGwleOy1V1JgTU/L4YAMUnzRqXrJVuDiH5HzZrJvfdM0zNIAUOpyykBDnLdFiMaBR3xNDQhv8yhUdkQhnktGcidj2bhvq3B9I3l/j3yO8Fzz1Um3SZ8j6KGAfRWEnnWIS+6/T0aogo0J/wg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:21:12 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:21:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 1/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
Thread-Topic: [PATCH v4 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Thread-Index: AQHdMXDIfQUKjMLd50yyWV+rJanBB7azwFoQ
Date: Fri, 28 Aug 2026 17:21:12 +0000
Message-ID:
 <BN7PR02MB4148D654408E5D3DBE075DD4D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-2-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260821132654.211730-2-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MN2PR02MB6973:EE_
x-ms-office365-filtering-correlation-id: ce7ff51e-4034-4035-206d-08df0528c229
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|15080799012|37011999003|24021099003|55001999006|51005399006|13091999003|31061999003|25010399006|19110799012|8060799015|8062599012|40105399003|2607281247196008|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?db3ZHWG7MIFMqEixJ0lSsyTor4Q1CBbw8+5+pQUS4qkiKO1vEJV+QHW6zs0Y?=
 =?us-ascii?Q?/1Jem1hlfVfyOrfRxZZBPAfrTGxd8nvZsolTlNusGrpyi3fOl6khS1CpEmmO?=
 =?us-ascii?Q?Rj8DlUxf+V/dDhsFKnG4uLZSLSuRkMv38d1fBwhJVobr1zOsxmN5U+4qa/BG?=
 =?us-ascii?Q?4Li+DULc9FJXiNPMTO4cWBzQrAAjGR/cK3dh1vLjnkVBTtCq07Yn5tGAhVQM?=
 =?us-ascii?Q?yWqxATKQLNlJ8k9qDTkCgp666/Zq/jCTuFEV2JzRG9TUqypwVqfG7Qu9f17L?=
 =?us-ascii?Q?YQyYm/sxgoQKFEEOjsBOHQ5zryYBgq1EVo06S6JKjMOKurCFOU9sGlGawSy4?=
 =?us-ascii?Q?+ci0mhAnffAj4S4uCa/lWFuNf5Oi4li0gGlMCIO2BIOJwhVJE7PfUzik/yRm?=
 =?us-ascii?Q?TOAgrdLu+bwNoqs6f6yfCwB1PAxhI0xHM/y0zUWflPmbwKgpKTEGzpoM8WOo?=
 =?us-ascii?Q?kC0yaKmDjPscaEJ1fe6wCNRnalc2X7aO5ikYKYvpDeQQCmqpU0wY0PTDZ33z?=
 =?us-ascii?Q?mbRVwvvnIxDDWwgV/UwNX+qH7F/u5bK3YlzzRo0HHDpLLPaIAOapHPkYVT2w?=
 =?us-ascii?Q?RGotlY7P9slFywcuPc9v/utNTrlmYb0KF2ynKKviNTQzqrBPZUJm7uDXaL6R?=
 =?us-ascii?Q?ILRqszSaVxgNsH9i0fH4qGWu0Qmqf7jF9hb41PAdjRIQiV4jDL/OtPSU5aku?=
 =?us-ascii?Q?hzSKsZsClfYUdoed4pj7CXfa9AvPc1mJbvAGB1Js3X/LdEllGFNI+26VOFhz?=
 =?us-ascii?Q?dYGDf1wSFV3/1Don4Ygp6/Y0TX1n2vOWctoxcD+qvzU97nE4odzirPTcMAbw?=
 =?us-ascii?Q?MQW1WY+3fLqX06navneR/+Psg41moHeyPIw/gfC3RM0NPuGl7nYgCLQVlNDN?=
 =?us-ascii?Q?c2BzfFUN5bG3HurU1+wrL0EWX868WeuU9OdLjFPqjIOfJ0YYpVTbIPAc2iwN?=
 =?us-ascii?Q?PIqHzd2BHLnPIWdVuSdD93niyUGwbYKFpkh2LzFYdsPibbGtKqUR/KQteKUL?=
 =?us-ascii?Q?hwDR96MkNZ4Z7gpzMDCLPCJa/2S79OHl8nabGpfq6SYnwHHTq3So7AJsCEV3?=
 =?us-ascii?Q?HscODr67gOfr0ZN6Dt1VY1QO3wHFEeO59uvZzsx+P3Sc00TGDTE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zkYJeJUFAbkzKNTnd9iyfmv5lE1VIUaIYQRfOYboQGgJzo//RMN4Y/VzPAxX?=
 =?us-ascii?Q?KANY49blh1YYgj4zCUskqx2BirJlsrQ6qfFXQHzFXzhcyUG5YoEG4kMXLpw1?=
 =?us-ascii?Q?6hSZtjFQ/Evo8QGLrOtlSMsXyxCxxxCwFulOzQ/dBNO8AnXilqxAAf3AFt9O?=
 =?us-ascii?Q?QkP7MO8dMd2iZZR4cq4C4qTiQ43p4ImHL0MUhA+IFl1MkDpZZgBTn0bef2fS?=
 =?us-ascii?Q?KpTAYeXdVc16G2z+Z72ePQMgNcl++2OjQdRrHef4W1cy1Lg1slxAzsAtJc7n?=
 =?us-ascii?Q?Dfs67jdaki/Pwd/3O03cKbW6fRz5jmSqUsyCQwrds+mGRnjwFNStz48zRGbW?=
 =?us-ascii?Q?loGl860W4gYVig5Y67DRrR7oJ1YHSb+FUuGoozfFgcPIk1+Z32GCX19fFmP+?=
 =?us-ascii?Q?hYovbeH87G8cKknnyezgm90jzhLssCoOrE/nZohpmYT9qoAxMEYOpAt4qOcT?=
 =?us-ascii?Q?8bjxsifKcA8Ycls/fE3UxaBZRe2rD0set5ezYCKIaaY6ablZkMOSCrxrq5K8?=
 =?us-ascii?Q?uXwxvoXQ7vrr4JLvwrwJEgQvHrU7S3dJuLWhbGcHP3WH5/4Fm48SRl91+zm4?=
 =?us-ascii?Q?LzLLZKTmYcw2115iL6Lz96nlBVb9MaZRiRMAPaT2Zv4VV8qvfLPJihqBolI5?=
 =?us-ascii?Q?JJfUgq3b3v1SwoyOuC3w6wVspJdz5JgPiZ7m2rGIZQJepbEl3MmbysC+LS5n?=
 =?us-ascii?Q?Yh+iP8YII6q1mIqOWvk6FNPnDVtcHYPtlVxejhiYvKQiK25KE3sf7Ouv3b0B?=
 =?us-ascii?Q?0xgwXXK23ARIWHyyEtirHhyp00MScwE4ajHm0jzV5/5rGUmMMCMLTJ9GEyr9?=
 =?us-ascii?Q?wX6h74pKBA7x6E0YZYjnLLsgU9xjAfo8W+TkrSTpABEPoWEAhYALQTw+I9cX?=
 =?us-ascii?Q?Sy43wFt1YoAQOH7hB6FH80BSZfndbq2lmJPvAT+d+Rvp3SIyRwakRbjc+/K3?=
 =?us-ascii?Q?E3VlpwtKWwMsbwmtpIPwrsjgjeGe76Y8KDhBBIX0bHesX0YbP3Gz9ZXt1j9/?=
 =?us-ascii?Q?/kxOjliJ4Y2pHA020FwZlrOcu3zPK809sSKXPAZ8y+TIUgGKY5yHtwOfjOMj?=
 =?us-ascii?Q?dCGhdxBfkbHq0oNkEuZq8dULvGEEmIRKVsb1+Zov6sn9axuvWCTfkIoRiG6I?=
 =?us-ascii?Q?IBKjdDvzgdxnVdOQ2lxpuR1Zpl8hfRcI2KwWi+GzPDXCxNrVlroYj6tZhqLO?=
 =?us-ascii?Q?ICY/DMo6fVs/FIi3YKL6gRQb+s1y+7ivWvv9w8b0RTo9fhzqAT50q+3lwjEE?=
 =?us-ascii?Q?V+n4fzTyRB5mRE/BAZ3rJfc1IlTricGGa0kpfJUramkUI+Jtk29ZjpCQqBeX?=
 =?us-ascii?Q?cY60w1T4ucrSXZ8LMDvaH9Dg5fSz4xtTKJ/A4E2xTsLfUpskKtlrWAOH4TCy?=
 =?us-ascii?Q?TWTNJEk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7ff51e-4034-4035-206d-08df0528c229
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 17:21:12.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, August 21, 2026=
 6:27 AM
>=20
> Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> Introduce the hypercalls used by the child partition to interact with
> this facility.
>=20
> These hypercalls fall into below categories:
> - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
>   detect the existence and capabilities of the guest IOMMU.
>=20
> - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
>   check whether an endpoint device is managed by the guest IOMMU.
>=20
> - Domain management: A set of hypercalls is provided to handle the
>   creation, configuration, and deletion of guest domains, as well as
>   the attachment/detachment of endpoint devices to/from those domains.
>=20
> - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
>   for a domain-selective IOTLB flush (which in its handler may flush
>   the device TLB as well).
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/hv_common.c      |   1 +
>  include/hyperv/hvgdk_mini.h |   9 +++
>  include/hyperv/hvhdk_mini.h | 137 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
