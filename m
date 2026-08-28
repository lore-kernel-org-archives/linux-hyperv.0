Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013087.outbound.protection.outlook.com [52.103.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80726ED4F;
	Fri, 28 Aug 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937750; cv=fail; b=IPuVeubSPQOubeDlOCt91du8rt6V9S/d9CoZacqcyHUOp+eecefGPp0wWUNHinvtYwEDG1Fwv1LW0ADuy00qphPUDbOH3mb+6/urixX7c753ntjS5G0IKzXJsVpUOMQqOsK42FTCokHn0q9A564LFpqL37kaTNjM+OF7VyfW92M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937750; c=relaxed/simple;
	bh=REgZl/BE8i12WGw0SfFXwYEIYhmS3xiprAUxqyOn114=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2tH3Yw23wLml8/kEBFkGca914AcnkBNUZCD5U1cBesfn1HkK0umheyHdZbjgOrCWhfYWyWt04dPVVKxXNcpVFAfjzfDmCrtHYB9EcNGC56lv50m4j/1q1AbBztgWRMmwaOpjCsyS60GVX+DyI3RpR56P/HuYMZKooh1OaakTM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fYUMTBi4; arc=fail smtp.client-ip=52.103.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fYUMTBi4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNnv46r0Bqu4oj9V7Fp2PCkqdxskKQwp+UAUjjHoShN1lsBRIpKswWHJ54cGu0jGdcrdE7LdlXX0Ik13Yu7JvmeyUdyZxOkyfeXTdOK1avqsNgjJbR6MM+RQzviM0sTiHdbp8JclBGbgqSe6Ge4E2q5aJzwgXhkF1AmR9hWqJlpfG1V+5wRHh45Q0015QO0YDr1UyGZPcMUwEtcL0DPyBEriXnWR0ssMKAc4WMFe0ejbX+Th3x+l5VNNrZP9Q2Stn4rKn/99aV8AiKORxUL1rb6YmTLUj4AhFXVdQ/rQ79CMAjsKsVugVd2SW35+DDFjTlnHFWSeb2oazcaCCjuG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcYY7PwIGRVMj07ybNPklSwU0w9ySJLAJePnvjoocGY=;
 b=baflRq5uODOvM/+z+aASj9eMFcIombmwl6ECqdoo9t0mKmoVwRh/2DvZ5u2D3QladevonV/RTYio3RBW6vkN1vpJ/P3RkBiTknio6w8WQmF7ZzheVuC1oRlZCKx93rp5fR/m1oaKHmnL9oNseEp1lK9Fm4M8OBdsdtSeM25RV1tIkEfwR0h51K6uz8byuNty/gQfj+LvRG8mRG+YaZlQvDWCywwssmgS7kz7OtbSoqVnX+NZcGCTTIP9Y2cajqrw3PSahZCItSenRX7FdMGStK/YvdAr8U2gX+Kn/ab23MmjJRbsLsBlIvxhRg3iGH+Yf8wakBmNXMKOwm2EAtjmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcYY7PwIGRVMj07ybNPklSwU0w9ySJLAJePnvjoocGY=;
 b=fYUMTBi4tstVyvwu4AEOQhVZDPpH+LefyjiqRIzT5o8AdM4szUkKSBrbKpibY3ORgde8qkzgZWt7eCGHCdnYFENHpWQLqxtusXkUThq2aKpK4heltTRngVHghViYkgoYxlNi7Wuw2Z9ELzoOqfUExW0ju7cT36PkUdBQdPoAQPUdc5KCitfNqDdegO7wl5ZrQnz+zYuLEA3if2iLcvB6h9BUBScIBdzKDfnkXJnWJMlKdp+LjySY/ywZXASnEtnHB0/JH4NrRPTiJPm2iCds9P8tpMhA7X7u8CdRi7ynf7ZpmcK0a0MPaVj1eshFT/w6c+rjYT1CPGl4l2ldSxxxmA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MW4PR02MB7185.namprd02.prod.outlook.com (2603:10b6:303:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:22:26 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:22:26 +0000
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
Subject: RE: [PATCH v4 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v4 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHdMXDQitOPjp5kfU+II/WhArtudrazwLIw
Date: Fri, 28 Aug 2026 17:22:25 +0000
Message-ID:
 <BN7PR02MB41489C44F11D14DDCEF925C7D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-5-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260821132654.211730-5-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MW4PR02MB7185:EE_
x-ms-office365-filtering-correlation-id: 4840cb00-c1eb-442a-d79a-08df0528edca
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0Acqh9BrS5tWFUiJNG0YaTxh2ARVQCCcppb2+QDC7Husbz8bhAsQ1ebYGQvmakboAflubwIBEOAMFRoObBo3dWGyV+ZY9xBDR6pvMxbHTg48geDlyrgnooSDa8rsELvxfqFl9QoOmygcq6Mvv5USECe66tu6qlD2meWNuHsPd7+VkvAzkm3bXKll7cpvdI78HV04xBsX9K4HXEvL5OgUOqA9D6R1pV5iJ9BjPy3bcji4owrymVD3zTaAET3CbzJFY0n6rDZoo9VMmIBJFpwOmk7hn+2Ptu8ayhP00QgJ2Jc967ExXhGEDZ4Dj0TBgr6gRZGboOYNEN+fxughl30ZBpB6xpXauLq6rdwgiMwHsFhPGChYXs1f8ii83VanNbxmcMxbkRNbalOpOzZpqGXFx3yGbHBDj1FgnX0vVvrtcEwF0p+gyg7ZIgB+hPoYRj2gufkOS3qFXmCKzqr2A2jVZQ6p2NHbl1rDNs2LwLBHbRojQ3nU+dgCUqIViffQVj1bKAbbZCTtn75oxkrcNVPl+Iy0Kw8tpq+RZQ5DgiSYh3tSQeyqbm9B0dcQf/VAdG+qFEbqjeHNtqNu/2fSsdMkGGyH2WRCXG2MVBto3cCNcKAyXmzFO9f5B6YZ3/ot3txVeP8UqPgKW0SgaSq/o4pFEZj75BIj1fTU87rj/w9/iKdBDDtndUrEQDvutIQSrEzM+HeRIf301Rx1I/u4CSn2DBa3G8nYB9F4Bpwu5Mhy0pGBFLrF/mgrHpff7Zu0RYF+Wz
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|55001999006|25010399006|16051099003|24021099003|15080799012|19110799012|37011999003|8060799015|8062599012|41001999006|13091999003|2604032031799003|51005399006|12091999003|440099028|3412199025|102099032|40105399003|56899033|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i8GQJOKfdahRg0+aFeECAyOe6Y3HdWJl58KB8W0wuykRDYBWZcXV7M/dSGPU?=
 =?us-ascii?Q?7XdSHOHdjBsCW7/hDXUaAENeeobeYUfDR4Xr/zMWYJirmeMZoRdAdEka0Jib?=
 =?us-ascii?Q?K97+6PUIL3LUeu6WbxjMkEH1EtnvojbESju/rFKCVMsfvMcMLZEZLxH7GeGG?=
 =?us-ascii?Q?QXNu4o+8yux+oHH3iQMAnBzfq0UMOpwJU5Zzh5hpujLXCJMEjSZuIjhnq6fa?=
 =?us-ascii?Q?uUbxH9/PTRxmdRM8gYNnpzOfPlivv52NEMM1jNADbgHMFmw4+so33I6M3oIM?=
 =?us-ascii?Q?KMMCkSe+oo/Nn2gDOjQMX7fBKe/siTJnbCZZwA17NmoyTn57Ut5DrXtOsqYG?=
 =?us-ascii?Q?oqTxHOmb1Vt0AGG5/zchxy7E8iC9EIbqh5f5XLVpXi3LiLnZ5NTm7IOwiF5C?=
 =?us-ascii?Q?ZEgie3XPQuk7nECHRW5catzxM26bZXRbzOANnVaitSgk3+4pRAMnOC9D5Lm7?=
 =?us-ascii?Q?DkuHK+suyFn3HDApOKHojvirrq+M/GEtaMKPaj8uvHT+Ud5z2Jdw5GQZAfej?=
 =?us-ascii?Q?M2CbAl+WXprj879bwV/ca59LbivkWKFWxjlNyRvOyHSG5mkchBVPLYZ4bCV8?=
 =?us-ascii?Q?zcOK/7wNYDKB1t2Js4cm/ZTW4iWkjHO1a8Pl461JpOXvQFToP/5EDCpLEUmn?=
 =?us-ascii?Q?49MimxO32bsCZqmfL1RpFR21S0JU2W2O3r1a2eI+f+3DnvEL9L7/y/T8rrEK?=
 =?us-ascii?Q?QNePx0oKy+gSXrptXilQCkV2n47b1AU1Bc/5htC0Cl6jIP6ohJIMfrdWFpsl?=
 =?us-ascii?Q?lnYtghbMRq4lwEPOBvPh88CQaaLI/yZ7FqXANqt+fGorfChS6veoDzxxbOYc?=
 =?us-ascii?Q?xr4wQNeN4VJdxAEd7YUixF4j+mn5LfzQ0Gk7shVwoQXQYMWL0KgRmc1KmX9O?=
 =?us-ascii?Q?F7/bO/U0v0hU3sozRdf+a4wPxloMsrzDAft3an9LQl+S60pHqODEJ6xjdcyX?=
 =?us-ascii?Q?NbkjFx5ptQc2VOdMVhbRlbe4iyxV42mMSAXEmWrRHkj/Koz4SaIHPDpYaAVU?=
 =?us-ascii?Q?6Ze+jKpjtNFOHmPiDHzDyCuJtJ4be6GIHy5hPgLGe2LGe6ngU2a7D5UGTObA?=
 =?us-ascii?Q?0FYr6MNY3NIk7Aksj1tAutCDKASVFz8C/x78zWEvI7OPLE3swbNGl5PxJ/Dl?=
 =?us-ascii?Q?1xHhbUMkaii3SYpoLCEfiSxru37PYk0MB0rDADdTSoGGWVETlH0AP5v4BQ0F?=
 =?us-ascii?Q?SSGTT3Q2s3EVrVuBtmUHPQeoZ4p6XyPXuzRcvQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sbfFCdCA4WzJRMZFunfr9IpRTqXiKAdYoVthM1n2+gPSuJCe7ZhfdWsPGsd1?=
 =?us-ascii?Q?1cndIWI4ttzxEpnJbOboRV+oJH/8h8R5DsqsAyyPpHeU08mX/v9/bUhhGNh4?=
 =?us-ascii?Q?rvYkXsRwIu+SX951Ax1L3EiXF8iIswAIbbP7fvbAAFclDkVYRfCg78sCSeHZ?=
 =?us-ascii?Q?Xvk1igsGi8xX+OBf/ztJevLMETwI3HZVkDbkgWmcdbPdmX8JkLkxLlP7b2Bd?=
 =?us-ascii?Q?TlH9EZbzBfGHT8PDCmcImZ16pOQUZ0+sA7tD39JlAihqAWUQaMLBfTMmIpJN?=
 =?us-ascii?Q?No/3NKwEsG978R4CG82G5MFJ2UFWkXiOqUANIrzxeXqRaqImu8Cy6BBZIf2G?=
 =?us-ascii?Q?ssuL6GnepVlSts7QBdr1hzt4KrD539h8VLT+V52Roe9+nvCxl8Ch0XT/g5cp?=
 =?us-ascii?Q?ZbCuN4g+3U62Vgf1oScw4R8HlXCVdq3pfJEbLLfqcwvfReVCCNO02ANsL2ho?=
 =?us-ascii?Q?BlsTcxZYcVvsD4yrPlOfg3aAyyglC/uICZ46/PEofsJ0u84iwH0uJ0Ps1Q6v?=
 =?us-ascii?Q?LnzAtT89ubFFDjApO3RqdrwKJQIVNQeuja9ZcFIUeFUQ2o7PQjufqk25FgXm?=
 =?us-ascii?Q?AgEzkKNdPBBJAsz6BEGPHMBMOJeFiigLTc5FUsRMJ5sSNz1WlJo8xw5LzXPD?=
 =?us-ascii?Q?VHldXOIQ0LYyL3ZtF5mc61sBNomtNwuQXVlUz1Q4PiB+OtsY+9TgJrdHrJG2?=
 =?us-ascii?Q?Yj+Jk9ZSa1qjU/JJS6glBNJvmHF1OsdFYa4BSqx03Sdv8rf2JJxk6VTY/1oA?=
 =?us-ascii?Q?eeCh65msabxw+CsKrtt9KvTWw9Z9MqNE8V9/U2p+TuvuzVFShxmilkAcavVW?=
 =?us-ascii?Q?4guRC6k2Phd3UrSmm6blOiA5xo1Hsppsn2WCUgrptZuM7B+2qjDFT5K5I/uh?=
 =?us-ascii?Q?n7FYeEUCSv3nZoXhZhzlXYwBJEIhjP2q6nSdygCQ+1UQX9ygyD0HhtTj5zrz?=
 =?us-ascii?Q?ahxsAyqup9jFZYZUlYVpl8eaB5g6dU03xvXAWr7Myg4q/kt7odaJIDislMiu?=
 =?us-ascii?Q?VNtcIXXlDyDSoYO2KqyfwjT7gu6TE19n6pnypl/HOP+hnmyrFh9FnMVHADUj?=
 =?us-ascii?Q?CYvEY0VAmsPkw8L5fW4TM/7AaXsqlmE2GtMhFMdRbPu13hhH/POFJ4inGhbo?=
 =?us-ascii?Q?B+jw5qyGKR2pyn8DIuB1tNHx4TS/5M2/MMF0uqMeXp/+nE8iU/zkFtQ+LA1c?=
 =?us-ascii?Q?POW9onEorhlxZvQHRvNCY4Fn+mq3auaX58XKjS93NgEC0/8OR84NG3qK6aaR?=
 =?us-ascii?Q?zdL/vhCCPjwe51FxfTFgzX9kAMhYGIZJ/PykrAILwCJFPtaTvXgIzyRSu0dS?=
 =?us-ascii?Q?R+jOMli++N2difkid4gsy9MC8uFJfRw7mZMarDg9uDB5gjBUFByFxJlGHdVC?=
 =?us-ascii?Q?eWKA6u8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4840cb00-c1eb-442a-d79a-08df0528edca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 17:22:25.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7185

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, August 21, 2026=
 6:27 AM
>=20
> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> This driver implements stage-1 IO translation within the guest OS.
> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
>=20
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
>=20
> Hyper-V consumes this stage-1 IO page table when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore eliminating the VM exits for guest IOMMU mapping
> operations. For unmapping operations, VM exits to perform the IOTLB
> flush are still unavoidable.
>=20
> Guest hibernation and resume are not supported by this initial
> implementation. The guest-owned stage-1 page tables reside in guest
> memory and are preserved in the hibernation image. However, the image
> does not by itself preserve the Hyper-V device-domain objects or their
> device attachments, and the current pvIOMMU interface does not define
> whether or how Hyper-V restores that state.
>=20
> To identify a device in its hypercall interface, the driver looks up the
> logical device ID prefix registered for the device's PCI domain (see the
> logical device ID registry in hv_common.c) and combines it with the PCI
> function number of the endpoint device.
>=20
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c             |   4 +
>  arch/x86/include/asm/mshyperv.h       |   4 +
>  drivers/iommu/Kconfig                 |   1 +
>  drivers/iommu/hyperv/Kconfig          |  16 +
>  drivers/iommu/hyperv/Makefile         |   1 +
>  drivers/iommu/hyperv/hv-iommu-guest.c | 620 ++++++++++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h          |  49 ++
>  7 files changed, 695 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/Kconfig
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
>=20

[snip]

> +
> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct devic=
e *dev,
> +			       struct iommu_domain *old)
> +{
> +	u64 status;
> +	u32 prefix;
> +	unsigned long flags;
> +	struct pci_dev *pdev;
> +	struct hv_input_attach_device_domain *input;
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +	int ret;
> +
> +	pdev =3D to_pci_dev(dev);
> +	dev_dbg(dev, "attaching to domain %d\n",
> +		hv_domain->device_domain.domain_id.id);
> +
> +	ret =3D hv_pci_lookup_dev_id(pci_domain_nr(pdev->bus), &prefix);
> +	if (ret) {
> +		dev_err(&pdev->dev, "no IOMMU registration for vPCI bus\n");

Nit: Given that the device id registration is independent of IOMMUs,
this message seems a bit off. Maybe just drop "IOMMU"?

> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->device_id.as_uint64 =3D (u64)prefix | PCI_FUNC(pdev->devfn);
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status) &&
> +	    hv_result(status) !=3D HV_STATUS_DEVICE_ALREADY_IN_DOMAIN) {
> +		hv_status_err(status, "HVCALL_ATTACH_DEVICE_DOMAIN failed\n");
> +		return hv_result_to_errno(status);
> +	}
> +
> +	if (domain !=3D &hv_blocking_domain.domain &&
> +	    !pdev->ats_enabled &&
> +	    hv_iommu_ats_supported(hv_iommu_device->cap) &&

Nit: In other places where the hv_domain is available,=20
hv_domain->hv_iommu is used instead of directly accessing
hv_iommu_device. That's a good practice that limits references
to the static variable hv_iommu_device in case future enhancements
allow multiple IOMMUs in a VM. I'd suggest doing the same here.

> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev, PAGE_SHIFT);
> +
> +	return 0;
> +}
> +

[snip]

> +
> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property device_iommu_property =3D =
{0};
> +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +						 &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev =3D kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev =3D dev;
> +	vdev->hv_iommu =3D hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);

This struct hv_iommu_endpoint is set up, but doesn't seem to be
used for anything except to free it. Am I missing some reason that
it exists?

> +
> +	return &vdev->hv_iommu->iommu;
> +}
> +
> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +
> +	kfree(vdev);
> +}
> +

Modulo the few nits above, this all looks good to me. But I don't have
a lot of familiarity with the details of IOMMU operation and the
generic IOMMU page tables, so my review is somewhat limited.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
