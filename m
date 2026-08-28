Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010017.outbound.protection.outlook.com [52.103.20.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196B373BE7;
	Fri, 28 Aug 2026 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937713; cv=fail; b=tfn6WgsbzHPZUoU+BNnjlfbQQApT1Sje/rHaMRLOwxMX0SoYFQOU3pDFpvTunXBl0g2w4//zdUjII+ZH01FO8G2QH9qIhAZ0ptPhrOpGSUqetaeEBIDWdwq/g5Lc2wFRVIb46RPI+uCxIU/2K++jqCY/0uk1RerN2SLDHbVRIKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937713; c=relaxed/simple;
	bh=V3qybGqoFTPyC1emtCYPua2SPjwBZztagbgNbPPhEgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eu/svpLKKWc3swJ6RdKL7VBNk8B/eXL8V82VFIKqOtMK97N2AjJ4DQ1CioC037v/pHlGx3BA+1qBXR9Jl7GJZn47T/tvX4cCcEZOaCmibQaaK2vKH5GlUWdcoDlYkglQjrDf1IRU9EwUhlioTAACmBIqeBfCYfIZQ24LKjsbkt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TpgKoBrP; arc=fail smtp.client-ip=52.103.20.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TpgKoBrP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqZjm/SZ4e1LiFaigMciD5C0q1OhXb++h1qKLDsBuIK4vCusxVGOhX3o6A6uruXAkUO7B4+ypJx7PJatWMRV6rYAcOJQyLzDkCTYjhpYOjR2eIodU9wsICagu0NP0++0/Z4g/M9nH1i/wosPvOKo7UvjmYgW6Amb10V33FH/XtVA60gLrR6V+tZCTFtvUdNWkNFlgH8+PCBsLKO8Sjir3sNDuUd9r0O+FDH6VjeQ9cY1QYYDkeR/lENF9wvZLDZJTbXjdr57YG4TKDZwZtrahQZ9k7k9Ym9o08LgeqRaYtq1Mg/I4qQtXAXFBDTEJSuTWbXRHyyqiro7Yu71OOY4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzGpF8gaEXE1VTFs+8Wxm5Q8aajyMpKnZ3u0aEMLYkI=;
 b=OH8ZoMSz3aJvKOFeMZzdaTwhZ5ruX/JCA3R2Jja8ZkuGEVfApQqvvU9PRd81Z2Ko++M0M8D1Tk5uadkoyvFeOEoRWfSbE22XV1ezsonu1GnBaN80XRn+ZpwryCNmHh/G5ZmovrcbeuMabynDpxr5+y/4OIQj3OfhhPBP0/IJ4GfVmKSuzF4+LKpbTG/1zcXWyDPrOThXsG/WUR11I9OT7BlNr6haB01lLMS0dgoguQvFdTSfMDaT5uIwyzrsYGfMkgdAcRfxjWN37IyvcoOoOkQ5UxVibMy0opQjcWVmE2WsYSBgLtpENKW+wnLy6BmrDGko3jRDt/7trya3xtH2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzGpF8gaEXE1VTFs+8Wxm5Q8aajyMpKnZ3u0aEMLYkI=;
 b=TpgKoBrPAjANZU174JzD4e92QTQnTTp3aMQBM0/s47H3TdKwCiIw0cveNY0GvY4Dxi/R/jVvMJyUWV0eIuXjn0VcvkRW7YNNbhMkfi2GfwxT436dBS2TKVIOsaSt+XRmFOPRuO/to6RkKr9NqVeBdW//TsSfmCuZBVPBgzxQomJiU7qfTYgmd1SWEBtXu+eDP0JqiOFozW6W50p4SWjO1u7aW96yabjJnH6I0fIrIEi3PwH8R6vrXWkQZOFi8HjJ2Om75saD/j/g+/1Sg7P5W5tk5djgUDDp/kp9rKZ4YtQIG8r6zmGDWHhA2vI28RqVWuyWyGebo0EkEU5VqFgpRg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:21:48 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:21:48 +0000
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
Subject: RE: [PATCH v4 3/5] iommu/x86: Add architectural MSI reserved region
 helper
Thread-Topic: [PATCH v4 3/5] iommu/x86: Add architectural MSI reserved region
 helper
Thread-Index: AQHdMXDM4E+1B6mDDUyptJosf3PI4LazwIZQ
Date: Fri, 28 Aug 2026 17:21:48 +0000
Message-ID:
 <BN7PR02MB41480FA6C745BAA6770B6322D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-4-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260821132654.211730-4-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MN2PR02MB6973:EE_
x-ms-office365-filtering-correlation-id: a3a633df-f6ca-4904-24e9-08df0528d769
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|15080799012|37011999003|41001999006|16051099003|24021099003|55001999006|51005399006|13091999003|31061999003|25010399006|19110799012|8060799015|8062599012|40105399003|2607281247196008|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XRGCbwApyKeZ/NHoG7NZ3iwG78APdfppS/XlNkNlX+MDEcYp9i5/+UIiPfjq?=
 =?us-ascii?Q?9JqHxU9XVvhsZVCVSL7fEt9oqPUA4fxISF12Q/2RpQ1TDaTD3hY4nnCanrR3?=
 =?us-ascii?Q?6Zm8ELx4o6teKbueYy4+i2FReZuwZG+S8FD5axH7KY9/ntCyvU2oG5y6VQYn?=
 =?us-ascii?Q?znXB6LKgm0jsVoqUjX5v/NdcgBEkXb+FdktpcBwsWfIxeflA354+7hHuvyDp?=
 =?us-ascii?Q?rvs3TPeCSzNTquK0y0d00ktbFeSe/F6MfpIxORHkHqXyDQnDXfZqmvfWJ/vE?=
 =?us-ascii?Q?5SXKhJsiNA1tSYvs27hxPvM7LcaqaWo/O7rjxXNPhBIg5Bp3hbi8fWx45/2I?=
 =?us-ascii?Q?flQlBVpMrniUI0TogfGOsMFqhVkzdi+yycCf64pR1WdpB+WjIfu2gamL68+h?=
 =?us-ascii?Q?UP3k+xjZ6TQan17UV2pJG6oKPbZC/Z0T1ehrY/jL2mcfdDoSRcrKYhVgecZ9?=
 =?us-ascii?Q?P6TWxc80ZMchBr4s45biEDVIB9JG/jed7JfTJNobCOv/nLqvxCGVNYgiblaJ?=
 =?us-ascii?Q?8QrGap8wKhzRyuI8bIL88CUqTCWZG2EsKcvepCU2EolSkSdlNdKHUwlagYMu?=
 =?us-ascii?Q?x8CUwf27SlodA/M+Qd/UEyUCtWf2kArE9hsOD6rAdeKTGOVSTNTiStMOJHh+?=
 =?us-ascii?Q?sb1GzkE9PAlEuYbxc+ijJUzCldC+vBUtA8W64TXtG1Xpw1pmsb19x83RFHkl?=
 =?us-ascii?Q?fCXilQEnvF/cuRbTst/d8H9QohMSB3JM3A9myt8vxTPpGcfxMzV3F4OQLdi1?=
 =?us-ascii?Q?fIgIZXwMf+7etkgWQLtgwpmqBLQOK3OiBL464vTqpBCM4AV/gRq90qeyKBk0?=
 =?us-ascii?Q?KRUe5uZFYK3XhJlbtaAbZO7sycXd3/RWygI4aT1GpNnpcFFi9j92aanrhTMs?=
 =?us-ascii?Q?+/Afsi6sYgDjKjK/tXihFBwx/GVyzcvW09P1BzaAELAmfMPux5AWNKsMvOqA?=
 =?us-ascii?Q?HAVpYSZ9m6JePBDBxoHQZ0V4JJbx+YIBeeAthNgEk/sscNFwboPZPRTMRB89?=
 =?us-ascii?Q?RumUQCaYdiS52aXmSzM7f+i0y/tTfS1CAUDXFlAVJ5PVsinX2pXur8B86z5r?=
 =?us-ascii?Q?Q6ZUs6xjv9jmMPbCnT8120TtTuRhOi9UUHr5mf1L9VdV7ZIxvK/aHMwYuMeN?=
 =?us-ascii?Q?60cR+YdEcT3B/+naGc8kmR1iHIAhOSHzSH+muESRNzhm4qIVl6oVGa4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ykN+Kiksg5wHLwWPXPzAl3tbt8Jp3z1ewUu2kbFg2xN8Wjf7ZNb7gUiBmtfS?=
 =?us-ascii?Q?eA9ipL5ypT1XvkaY7S4VDk+P5i3375Efj+GAec4WzjieweVk6CVPO/Vp6eYF?=
 =?us-ascii?Q?thI7BjgKvHxFPQE3vsKemRAu9HvhhiRrQJnuUEH2T3z8UZ0dqTU/9j3Ml54j?=
 =?us-ascii?Q?OXJmUOmI5Bz0Jl/EpsaD10xRNm+8K3aSDwzbsaDY3asM3NTIwDcqrfOhmnOt?=
 =?us-ascii?Q?6C5qGHnYKQJZiHPaMLaouP9YoDXmV/EeiLbui64LbIzQGSUm+MHsTfnDFLWJ?=
 =?us-ascii?Q?BPvii1t58AgPoCV5r33sqojsueRdrJ68+LTNU8wdx7F2p0qFzpr1FZ0Dptih?=
 =?us-ascii?Q?XUDGSCLvDb4PF0zkfKPfog3W/V59IeR+zTEhyyNA6q2VT9eksRe8o5Xn3Sgy?=
 =?us-ascii?Q?kpPLcRIkoqd82lKO72jBJReSirY+EhRx7DsYp+TXvVQAhAz6ebUmowpHGxH9?=
 =?us-ascii?Q?HjEe1k/Zd9RJSAzcHiDybvfcVJVmj5RJHwGu11zGXDJfx7XJnGgqpD2M53/D?=
 =?us-ascii?Q?s5PRCmQr1DbUTrI5Ubm5w4t8vks6uNWEC+/wrYwBqqIcoXAhfe41tuclYJGt?=
 =?us-ascii?Q?BWs8zd6k3uEsFXAypf8UEiKjuqwusiDdQKrtdSgpjnd90vQulFtzpzuP8+2a?=
 =?us-ascii?Q?T5ueAi+5pVBFiEeRRD68wcfF15jk6sFYDxUKL69PA8bEiYwL4C8xoT4gxwfU?=
 =?us-ascii?Q?bKJSmL7HQi2qQr/ST6d1YDyqfNaPCglM4N1stHiEsM9dXfRH8DUeP0aNt65J?=
 =?us-ascii?Q?gomwOGC8IQRL76Gr/0iEPugf82nOOynE+VmyspivBGn3mgRr16QULGnW7zbX?=
 =?us-ascii?Q?EQ20ORu1dE9vfXHFI0rsD5BY8jVK1ivxjQVY9vQl+h0iw7BKQlY4jBra20dY?=
 =?us-ascii?Q?W4ZMLeUrwF7feozuB/wRBUckYnloiBVfoseRqVoG6vwadbH98Wo6sPRUNywc?=
 =?us-ascii?Q?3SiJDi48lPVFPoI6oPnetzvQzq0yJa0mUk9zjFduOGrojmOa7vBvNhrZBnVy?=
 =?us-ascii?Q?zc9oz9rQ719d6JeApBZuw/OZaJpLZQoU5MbicCu3pZuX3m10o0dhmKC1T5WZ?=
 =?us-ascii?Q?Yz6YFwW8McYtQuVLXxicHtdB4bC306cE7CE+jJmuWjv4R8R9AMSlTWYML573?=
 =?us-ascii?Q?OX9GboUoig0v0vwXAaQY2Gnr8267V0LJPGvmAmVe2G0sTFFtWCLw+/4in0LO?=
 =?us-ascii?Q?/mJgduD0OXD6X6uEnenp2o0NZz8JPIA1zbTMOgF6Q4TDXfNi4pjX0AqhfP/C?=
 =?us-ascii?Q?2XbESBxZoGMNn8aSSiJGrjs43bqO/pli4X+p7jGCLD3deJOjTpIi7oqj7pTq?=
 =?us-ascii?Q?PW098QSTtNAoQNDz3KFtkSSVvnFjhhXe9XIPB5wiZghazPI1KTURk16U7KEU?=
 =?us-ascii?Q?PDEcohA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a633df-f6ca-4904-24e9-08df0528d769
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 17:21:48.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, August 21, 2026=
 6:27 AM
>=20
> Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
> address window from normal IOVA mappings, but each open-codes the range
> and its allocation attributes.
>=20
> Add iommu_alloc_resv_x86_msi_region() to encapsulate those details, and
> convert the Intel and AMD drivers to use it.
>=20
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  arch/x86/include/asm/iommu.h | 14 ++++++++++++++
>  drivers/iommu/amd/iommu.c    |  6 +-----
>  drivers/iommu/intel/iommu.c  |  6 +-----
>  3 files changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index 3be2451e7bc8..6404f4fbeae8 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -4,6 +4,11 @@
>=20
>  #include <linux/acpi.h>
>=20
> +#ifdef CONFIG_IOMMU_API
> +#include <linux/iommu.h>
> +#include <linux/sizes.h>
> +#endif
> +
>  #include <asm/e820/api.h>
>=20
>  extern int force_iommu, no_iommu;
> @@ -21,6 +26,15 @@ extern bool x86_swiotlb_enable;
>  /* 10 seconds */
>  #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
>=20
> +#ifdef CONFIG_IOMMU_API
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_x86_msi_region(void)
> +{
> +	return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
> +				       IOMMU_RESV_MSI, GFP_KERNEL);
> +}
> +#endif
> +
>  static inline int __init
>  arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>  {
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4dc306a4b5c6..b9bbd9aa99a8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -50,8 +50,6 @@
>  #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |=3D ((t) << 28))
>=20
>  /* Reserved IOVA ranges */
> -#define MSI_RANGE_START		(0xfee00000)
> -#define MSI_RANGE_END		(0xfeefffff)
>  #define HT_RANGE_START		(0xfd00000000ULL)
>  #define HT_RANGE_END		(0xffffffffffULL)
>=20
> @@ -3140,9 +3138,7 @@ static void amd_iommu_get_resv_regions(struct devic=
e *dev,
>  		list_add_tail(&region->list, head);
>  	}
>=20
> -	region =3D iommu_alloc_resv_region(MSI_RANGE_START,
> -					 MSI_RANGE_END - MSI_RANGE_START + 1,
> -					 0, IOMMU_RESV_MSI, GFP_KERNEL);
> +	region =3D iommu_alloc_resv_x86_msi_region();
>  	if (!region)
>  		return;
>  	list_add_tail(&region->list, head);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2e3b3ab216f8..c4de4bbcb065 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -39,8 +39,6 @@
>  #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_=
ISA)
>  #define IS_AZALIA(pdev) ((pdev)->vendor =3D=3D 0x8086 && (pdev)->device =
=3D=3D 0x3a3e)
>=20
> -#define IOAPIC_RANGE_START	(0xfee00000)
> -#define IOAPIC_RANGE_END	(0xfeefffff)
>  #define IOVA_START_ADDR		(0x1000)
>=20
>  #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
> @@ -3459,9 +3457,7 @@ static void intel_iommu_get_resv_regions(struct dev=
ice *device,
>  	}
>  #endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>=20
> -	reg =3D iommu_alloc_resv_region(IOAPIC_RANGE_START,
> -				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
> -				      0, IOMMU_RESV_MSI, GFP_KERNEL);
> +	reg =3D iommu_alloc_resv_x86_msi_region();
>  	if (!reg)
>  		return;
>  	list_add_tail(&reg->list, head);
> --
> 2.52.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

