Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010021.outbound.protection.outlook.com [52.103.7.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8693B8BC4;
	Fri, 14 Aug 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721475; cv=fail; b=ge1cCYUlaCQDB6XrO8LfQaB+OaVEuCQa2+37p3ehpbbTW0B8YaLwTyBWLenEf9xyQT6WfjfnkyfX++Ql1w5HjPcS4JcgvfOUy5DV8H06d7LrNmK8bU0ywH34aPJ9bjadcoYdqEuShcfOJcrNdPkVmhCC2Z6U++JMP6VjxAkv/lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721475; c=relaxed/simple;
	bh=lmNyfzi04SdZTAEDxNezp8coiHSzp5jkPuaF9Zg/7Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JUMlGYi0+XI7J1sWTmiyBmjPTkVKtOrM9HqA7WoeRUBKcHCIFFVcBkcwySMTXXbskW3gnHb7/ckQpPUZ+WUKEr6od5oUNzZdrRwBkEFsalT0OmlXUH7ncBLTt/rFDcMvq897XDzAVav10QQuahgLsNGIJ16o72HFruPV1VF6LN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BS9KSDrm; arc=fail smtp.client-ip=52.103.7.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BS9KSDrm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZKnGamf8+TZsn8Jkskmn8ZQ1SAIIPscsC8aE1HLSEA/oYgdLMp6yr6+EpNKaRVStrIGITqoTCYRnuYUE9HKdPkGWThOfRsWA+w/9wvznDL7RMTcEkRxi63AZ/HQsVWnrNZea19y18QmWmGI7yThYTOFwF/FwnXNxbdyWlkPhtvKlqs+3J0q8VdJVDSPWt4RfZKudziq8RvHmOagMsHTo+7nosttPxFkPbl0JtXe4byjr+epupWuhzHXZme7DMUvhDTovKHVm3aC9iDZxv6hbk2uGC+dJPK79jhW1lSgflrWY7RMnYXPa01KI5Yc8zpIJ9CPOySYlwQkNHDzuJFCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66QUJzNibG+qlPnGlGXrHJpnz2ODz327JLN7qPUXShI=;
 b=OmdfyJO1AjVOzJX2r5WrqLg2L4chcnnufnobLVg3UdNaKY+Wdkeg/pB6asAQ8/Kau7IBsuwisK7NVhZPa9GMvnuOkvW4xQGjSfHN4gEsKPV0zwWprIegavRuwIS2hW5s4q6b54XY436VwA+Ka80KRCyGqhq696FFZ7+0LDSzRbLmPffpCWjA8rmOgigrAGAPh8XezE6z6p+0ifhDX/uIcEWEG049n9NMRZd4b0sSoy019dGwGIK81MOnTgkZsIp7bh1iD4nzcxLfcHWJ7EDgzNbP+3ACXznYR4kEClRB7ZUhLEEPGmTlg/ZGGhlj2Xd1JeRvVYirg8FIoz3MqwJZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66QUJzNibG+qlPnGlGXrHJpnz2ODz327JLN7qPUXShI=;
 b=BS9KSDrm92e0N4GqIaCF7G4uVWmLJuW96MwCI5ThWpz8KLQfgw/DTVqkH3bXdVoiQfwt1Aft17SGQ5newDZQ/q9o04+zcjerq8hrHxCbnGSxrdkCAiQdsiu6yEv9YIb3vPcS/whisP/Cwxuq523pvvD1oFzvd4/34EEQoftiCKKXXlF0Rof3Vtyo1TiG9OUi8HwvETc/lIrmQsM+WMNo3GadFgOXSjiHpbywE9f5j2PJ+ATepUtpP7cvVUK7r2qY9UKZs2C+d5R3WsSh2CRivBWeroTMegKpiIfyDz42+2HKJ56KKaKsbmcyjX0AMLOVNYoFqAprxJDZrZ5UGCLYYg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BL0PR02MB6466.namprd02.prod.outlook.com (2603:10b6:208:1cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 15:31:09 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 15:31:09 +0000
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
Subject: RE: [PATCH v3 1/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
Thread-Topic: [PATCH v3 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Thread-Index: AQHdKakoR55TFjdAFkG85tpLWFDXxradsIPQ
Date: Fri, 14 Aug 2026 15:31:08 +0000
Message-ID:
 <BN7PR02MB414806B8395DA93F5F7D7867D4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-2-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260811155022.108148-2-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BL0PR02MB6466:EE_
x-ms-office365-filtering-correlation-id: e599201f-68e9-49f0-091f-08defa191070
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|24021099003|55001999006|25010399006|12121999013|4140399003|51005399006|13091999003|8062599012|31061999003|15080799012|37011999003|8060799015|19110799012|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J9+3HkTs+GpgKpT8fFYDnHxKxcYJJAYLxvVVGbY0BKT5RLmuPSnEBLrA/9Mu?=
 =?us-ascii?Q?hpBZsixH7fRBeRXwmriz/xFVRz8ctsaL/nhCaISHxdIXBxzAkfmQe93ggpvH?=
 =?us-ascii?Q?cyXTFya+57VBGJ86ajPy3YXQkpUwNy4si07fPtFfA2gJfbPNPe/xOZbtYAd8?=
 =?us-ascii?Q?N6Cnf5NQO+Rx4rL/r+ciE+4qdZ0y1UJStkzQz4spBFDaCkPc4KXwRrZMmG8c?=
 =?us-ascii?Q?9hL/bIaiJ/CcpNAr2Q0To3plZiF1ggNRncP923hZMx3FJA81Hf+GIoS4Qqsv?=
 =?us-ascii?Q?iTq3z2wUQkUVxFIq6da5dJCu8/eEQ27BV7XP2aPHc/imqO7tcHm8iNmOuP+h?=
 =?us-ascii?Q?cwhQ/c1XjYrt0ZlZ4pPD9/ANjlpE5nUt+bOdNu91MU8SM8BDFfgDh0H1zM3N?=
 =?us-ascii?Q?4mBmnNQBvMPNoHEpi5oeGD3T1pOqonAvYzs5aA8o8lzfKzFyMRBSl9NSidZk?=
 =?us-ascii?Q?aAujmuN4t7LkX5XJuxEymQIjlWLglb+VxtNn++23G3JBLeLEgWsO95YHOIeJ?=
 =?us-ascii?Q?W0WjQr88XqsdAz3XG5FRj02/t8YYf97OdONr9qM/3VHJDM4RNaIsfUicLqhV?=
 =?us-ascii?Q?6ezezK+wTGS3a0QwLsiT8gVOiaGDsHIwWvb2Q4n27nKV54VNEzNqjWCOaXDu?=
 =?us-ascii?Q?p8VJ5Gritk7Gdxlmm2h8MwE6RF7Jm09oweyDUEK2QxcLsnfzon+xnUUwsP7t?=
 =?us-ascii?Q?hjc8R8wSRAEyD9CZioLj/1T7M+ttP+5G5DKWgrWWsMhZzfjwR3TyJjoulNV6?=
 =?us-ascii?Q?5Xtc7ZStYB5omjGMVMaMk+n7FwjQGLyxkHMbrSnanYqX7yIVjEPIPPoryc75?=
 =?us-ascii?Q?MMYqHGWBjLVuzw6ORJx3XouFTyyTOKcfmmxcEkU4MuKCZzdbWlO68qLhuptm?=
 =?us-ascii?Q?ts3NUAqZnaVW0E4m0qqhJ1e5n8m147B1XrzK2d3XrbuG4qp2d19eYYmYR1S/?=
 =?us-ascii?Q?9rTgfxYKwiRG4izkVrKDbLr2TUFs20h6qfAbGWskIqBX6fgQncu7dHniy6tt?=
 =?us-ascii?Q?ekUdHZJapz7YCuH/hxhmtpGoDz/HDt9z+mC2xjIhnxgdrDIArhSVeFGXuYme?=
 =?us-ascii?Q?FRuMQTyu5Gwr3EsHfGuOaZ1J/yxiCciGzkMSUCecSNP7IvoKZeSMq06QsPr8?=
 =?us-ascii?Q?gEXea69UMaCl?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LPGZwVREGF/o6VEpTJRqPKel6HO3Tvd6SIZh5bDG4Tlf8GVsqlh85A3Iz9IZ?=
 =?us-ascii?Q?tbQU6kXzejM4U1iw5iONbgS/PaRIw19wlapPfpaRJyVDzCaQqZfw3LkplsPJ?=
 =?us-ascii?Q?3ZKDl0svcrAU4OYRX143+XODoqQFj/t94nypNWNxiiAxzWLGoTBFBCE5BKlO?=
 =?us-ascii?Q?LyW0A0DEjfIP7xT6gt6v4WjumilR9yLbR1DdSXMI5zTysa2B+/hRhZqhI8O8?=
 =?us-ascii?Q?fyd//QA7sSJtfujG8JBIpggxm2n5rs6AH1pNbCARUO9a11JmbsMdRdWfabkS?=
 =?us-ascii?Q?BheQneYqz8DsyfWMFQ8x8uREM2qr+Hm998UjgShH5jRWYUx7gJHnjr0POn+P?=
 =?us-ascii?Q?Emr+mWFi4fOJkK9+UtqnervttS0apdiWYoox6EuN1vt/hFHluU1zJWdXwRlr?=
 =?us-ascii?Q?5+xR4ccHD96ECCn7cMnrI+qywQN5sbU4rxAPHTCzslKkGMCzFyGUO59AwyXX?=
 =?us-ascii?Q?biVJsKiCxKqsZshKLBFqgdX/94JFFOIccRy7UoGmhMvJPlvAnEwZbvcRbwIY?=
 =?us-ascii?Q?8NYwY0HxCKcjxh/C4nDmV4uJOLV2UHoIDo/xyrpukh9cTf7RE656+NV1a/L4?=
 =?us-ascii?Q?/qsXbC6dPg6mafOUhYenCODcDnHeNWw2FzpdF16UWWJwM5Ngckjo2x7845eA?=
 =?us-ascii?Q?OSp/iS++FDJgkhMosSurig1QsWMhhgQHaZ8+gE79EyZyLn2GfpaZQa2j31dF?=
 =?us-ascii?Q?GkXV4U3IvT7o28A1/dJnvnTC7tUwZE+SH5aUt7uCav2o23oEV7AYs6FfU1F6?=
 =?us-ascii?Q?a1VA9SeUgrfl/y5pJbOsGHf0n0Ajt3zxyCgHO8O9+yeHgjHklyH4mmVesw1I?=
 =?us-ascii?Q?kCTogWTVTQX68fFqqpm4ov230GtygJkkrOy2mqQuOIRNsAKK4OoHnsf2lVnd?=
 =?us-ascii?Q?xbyUy4ybQVRZ90aDrKNXSykkNU0PEJkJbc0o0ChMguw1Df+ngmR86I1XAwuy?=
 =?us-ascii?Q?CILWXqBLNmUaYykCW+6zN2MJT8cJSV7P5IO2nNP8AvFtd11+CtqlMHDqMeo0?=
 =?us-ascii?Q?YieTCLIT6xWGURIgPEmwQpMNNIMEAkVaVo7i/VU9dft+8wT9bMoKgxnLaIqc?=
 =?us-ascii?Q?KxCxSfhGXk+R9xrfhaGJclhQkuC1QciTvZmoTFqho8DGLs6wyTP+HTwSeW1q?=
 =?us-ascii?Q?f6pKGcGvnhqQDFRK3+57c5KH06cl9XQzH/VQw0+gV/706oKcPq8Q5R0tuvW9?=
 =?us-ascii?Q?qHMSNxxArIKQvfQr53manMH+4m0kcutkHwPJT2T3ZO3J/ZjeRFnqzC6zcKhX?=
 =?us-ascii?Q?Y+KhD2FQWhVE2X0K+WvNRLAOJiC95Wr0UDbH2/R2k74ChE83044ydc02FTdS?=
 =?us-ascii?Q?ilerq7ZySng/KZuMIkjS+yHPFQd5mxlHGDQBOIaefhoH9mLAtg9FAx2mWZY+?=
 =?us-ascii?Q?bRZIerE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e599201f-68e9-49f0-091f-08defa191070
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 15:31:08.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6466

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Tuesday, August 11, 202=
6 8:50 AM
>=20
> From: Wei Liu <wei.liu@kernel.org>
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

[snip]

> +
> +struct hv_input_device_domain {
> +	u64 partition_id;
> +	union hv_input_vtl owner_vtl;
> +	u8 padding[7];
> +	union hv_device_domain_id domain_id;
> +} __packed;
> +
> +union hv_create_device_domain_flags {
> +	u32 as_uint32;
> +	struct {
> +		u32 forward_progress_required: 1;
> +		u32 inherit_owning_vtl: 1;
> +		u32 reserved: 30;
> +	} __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +	u32 padding;
> +} __packed;
> +static_assert(sizeof(struct hv_input_create_device_domain) =3D=3D 32);

The static_assert() here is unusual. For all the other hypercall
inputs/outputs where we rely on the structure definition to
be correct and the __packed to prevent the compiler from
adding/changing anything. If there's a reason for this one to be
different, a comment would help. If there's not really a reason,
I'd suggest dropping the static_assert() as superfluous.

Michael

> +
> +struct hv_input_delete_device_domain {
> +	struct hv_input_device_domain device_domain;
> +} __packed;
> +
> +struct hv_input_attach_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_input_detach_device_domain {
> +	u64 partition_id;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_device_domain_settings {
> +	struct {
> +		/*
> +		 * Enable translations. If not enabled, all transaction bypass
> +		 * S1 translations.
> +		 */
> +		u64 translation_enabled: 1;
> +		u64 blocked: 1;
> +		/*
> +		 * First stage address translation paging mode:
> +		 * 0: 4-level paging (default)
> +		 * 1: 5-level paging
> +		 */
> +		u64 first_stage_paging_mode: 1;
> +		u64 reserved: 61;
> +	} flags;
> +
> +	/* Address of translation table */
> +	u64 page_table_root;
> +} __packed;
> +
> +struct hv_input_configure_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	struct hv_device_domain_settings settings;
> +} __packed;
> +
> +struct hv_input_get_iommu_capabilities {
> +	u64 partition_id;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_output_get_iommu_capabilities {
> +	u32 size;
> +	u16 reserved;
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +
> +#define HV_IOMMU_CAP_PRESENT    BIT_ULL(0)
> +#define HV_IOMMU_CAP_S2         BIT_ULL(1)
> +#define HV_IOMMU_CAP_S1         BIT_ULL(2)
> +#define HV_IOMMU_CAP_S1_5LVL    BIT_ULL(3)
> +#define HV_IOMMU_CAP_PASID      BIT_ULL(4)
> +#define HV_IOMMU_CAP_ATS        BIT_ULL(5)
> +#define HV_IOMMU_CAP_PRI        BIT_ULL(6)
> +
> +	u64 iommu_cap;
> +	u64 pgsize_bitmap;
> +} __packed;
> +
> +enum hv_logical_device_property_code {
> +	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU =3D 10,
> +};
> +
> +struct hv_input_get_logical_device_property {
> +	u64 partition_id;
> +	u64 logical_device_id;
> +	/* Takes values from enum hv_logical_device_property_code. */
> +	u32 code;
> +	u32 reserved;
> +} __packed;
> +
> +struct hv_output_get_logical_device_property {
> +#define HV_DEVICE_IOMMU_ENABLED	BIT_ULL(0)
> +	u64 device_iommu;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_input_flush_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	u32 flags;
> +	u32 reserved;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.52.0
>=20

