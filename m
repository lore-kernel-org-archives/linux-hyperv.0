Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010006.outbound.protection.outlook.com [52.103.2.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A0529E10B;
	Fri, 28 Aug 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937698; cv=fail; b=KMBgDmn3nr1Zvtlzv3bgbtGDe1JtBfFfnnq5QQL/QKSBWrLv4nthX1cdvbh5lD1DwwKVgoI7jOhrtCYkqg6moxzgoIqijbWfI6ZZf3yqZpW0KUmeflGJnY+pvFo8BkmWQWc+zsdbf0r0dla2XCLvJq0+DzSisVwdRYbJS+bM52Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937698; c=relaxed/simple;
	bh=BXvSvGxC7AQbNfXcu0c+gkHx51HzZxWCZovcfPgapIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEzLkEde0qy+DtJPjFz/lZ+/Gf34trGf8hq3+Rxa0BirqvavrDrrjkiHJsLoKbU1E/JNGJh+gzkShXY0yQMHkNi8C798L7KpGBitj0/pUi7O1BjwqhmymwmfyXwpDX2zQlX3TCV/wygsO3mnLD7j/+fC6HoUBYDUaYHWajH6+fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rCaEdC/b; arc=fail smtp.client-ip=52.103.2.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rCaEdC/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmczdFosydVfjRPm3tMsnOGB8TUHDh7iA5FQA995z0I8oRlxD5z4+916fkSoQDiZ4Yi4ukTipzBhnyQFpK7RDHK4yKF0yZ4cbFJvEyyNi2z9/LWY+nR6geGE1OYb5vl/YxMQDUqJl0sLQn+rTOV45M7QbxuZlmCSNgHVOLDfEazl6UqrAhT+YBnKLbZmIorMAvA4ZdXP86alZjgVNGUNn+HiNzGT32jFvS3PZeMJYUv7nAdCGWOkAZuLFB1x84KFb/CVE0uyUKmmMTZGcy0vfxVuxB6rdv6cuHHA3apMrbrzYIuAIoc2den/Hl/kEgRS9YLR76wG0wNNClfXFsXJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrkMmuYfgDqtDgBZcycVpGocE4YjK/UPkXkI88uJFds=;
 b=DJIrDifCXo80d3iFEW54OiAku5ovnr0IJX3WmoJF/pFZ0wbr5sSu9I+uc7ix3DFqmCPx5dc7u8AEq4cD0h0sT8OOXRwYmO4cF2i6AX0XGoMUD5C2UB7uy7lIt6hyD3LTEhPiRpTfLSdxmIwUg+oIrWAgBEzkVIc+dSzQYtZF4WKFVUNvS1jEU+CVIygxxjh34jXr5BZwc2AZMlDeFbhTyz2Z84tV/YOl62KVF4OXY+I3GadJfUsABFNrKY8zUEZK+jx6z9PiJH4igtO9Md0NnJpNPxJPc0zWczjoRfn/hs4ccHWUNa6Pi7d5yQUnFXmSZSQWQCr8tWKA1dK8riVupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrkMmuYfgDqtDgBZcycVpGocE4YjK/UPkXkI88uJFds=;
 b=rCaEdC/bwOGXlEOoaIHBo9YI8L0j841O/i2HDDYJQlreGPB4NyJKAvtDI4DoiEsW0q6XEl79Rrni77rVPlomq8zKt4Y89GQfA3xhWOWMh6xf2LnhA0GGUhgH8EgBHUzfAY/1Y4TRUYDfL7jReqRzogBiUgPnroKTy0iWd20qdk+UvOzd9EnMK+FGXUv0UCmW6LxNKg9d7l7WEUNdPUa8Ek9Bqjeu+4F7i0aMOfw8ozAcQdlaI7aRfns0edqLZMb66+UpWQR3TLYA62cAJLdwn9jq6F9YpmEgsL4K+l83vhk4VLfjmAW/QhuYYNsTFmHtgcLUJyuRrC1huycvLCgJOQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:21:34 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:21:34 +0000
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
Subject: RE: [PATCH v4 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Topic: [PATCH v4 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Index: AQHdMXDIJUDxUzgJDE+fT9U3vTqDTbazwHWg
Date: Fri, 28 Aug 2026 17:21:34 +0000
Message-ID:
 <BN7PR02MB4148F0CF3EC3084440DB1CE7D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-3-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260821132654.211730-3-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MN2PR02MB6973:EE_
x-ms-office365-filtering-correlation-id: cc3e405c-c98e-4420-2ce5-08df0528cf15
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|41001999006|24021099003|55001999006|51005399006|13091999003|31061999003|25010399006|19110799012|8060799015|8062599012|40105399003|2607281247196008|12091999003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cgS6dVAJRYKXwH6lNe1eRAeGof71Bgl9ezQ42A1A+K/MWsK8RaPo9H6SnFo1?=
 =?us-ascii?Q?T5wFGREaKrluJk0lGAxIwlfBO1UGlIOoumVfFp4G+SNQL66ggbvbCj7bo7Kh?=
 =?us-ascii?Q?XnZCONS5qHfTupSECAoEQ5pfang+BuQfMW6AfiUUv2JU4cJi7xaDq6Sj87Vx?=
 =?us-ascii?Q?cxYPYQ0qyRzOWvFCu6i5aPZMEHsrDI9h9aFT2bFQJmaseNqelqJ1uK4zdwTt?=
 =?us-ascii?Q?TTlKbJVVjApx5x2hJOTOaoPkPGh5jkf/3Z6bZHkqhw4P9rc5gYzyWl6IPpa7?=
 =?us-ascii?Q?ErzUY3KWjVrd2Is1BLs/1mJBo8YrGq+btaGN1fvSLF3RJguGW3kULAYvsyYx?=
 =?us-ascii?Q?9xFbRY3aQK3kHClsbDaJdyej5nlEggDR8KOSmOe+AaWchDSGUc6d8/Hiyubk?=
 =?us-ascii?Q?WPDrWGzNDoOUs5OD1jABdVCbw+nrEXn1L2b/QGRSS3tF6IIseSy2/bsI+P/m?=
 =?us-ascii?Q?bDHn6a8rGjsNW6on8SvwkaVw5O+OH8AhQh9QRndrpF8t9Denp0SL65AF6Dve?=
 =?us-ascii?Q?mlt8HSaw2C3fE283EGIEZFZiDB+MIOHRUFH3SqeI2evsHvZJM17QqpP7geYQ?=
 =?us-ascii?Q?5Aa6frlygUhQlpHjdc50eEA9Mo1ClvjUxoqyXM8wNT9Jtr8wQqZyFE6dGygE?=
 =?us-ascii?Q?5DxMwi5J+KNepPN/GaOTQo36EDtg2UhzjCIDptGxFRk0S2VKf930db9bskzV?=
 =?us-ascii?Q?di9unJBifySYc4CYxvywcGSLt0bHg3Ql/0iak9WXksyBnLJgPdxaKfN/zsMe?=
 =?us-ascii?Q?z33gsKETNp+C30QrBjP7g0Bk0QfmnK0bXl1knTz7Iw0KIT1utNax5pqgRAjE?=
 =?us-ascii?Q?4kWNzNurckBiF2Z5199nWPTd/0earQ3TVDXz+fCDHfOSc8lrWfNWjD5uVcso?=
 =?us-ascii?Q?jdvGxI9RURVQCM2ozMVwZduAdXtSDmnZ0fSJXxa8ecnDSUsiYPV8f5fRmkTS?=
 =?us-ascii?Q?RGGDC5+PWKVP4r3RgLy3PyWyXOaWJwal5cxB43BskQF8pcY/WFZ4vWzfy3ij?=
 =?us-ascii?Q?jBN/RD+YAmhaOCaaFV9SC00A1cPrrbK3YS7dyq0D46OELcjQBVf37oLcvgvU?=
 =?us-ascii?Q?DWps/KG7p6Ld/WzKEsPhcYLiXXjTfO680NyZFTo154Of2LPnQ+wgi8QEaPIe?=
 =?us-ascii?Q?XrULKrZIpldv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1h6zKadtG8yS1hc/byTXPR7E69ltdp/mYK3GIDbUXQu6Y7niQBha1sMex5ES?=
 =?us-ascii?Q?RBfmfiyjaJXb1wSaiObbLFvxwF4i9ciXCrYPiMvQtksOx2v1CBs4CPdKuL5r?=
 =?us-ascii?Q?1w95j9uOn6eO6QnnO+69lcHxo+BeQkpYM8eGkwJS4Rs+F6Fd+S4n7oXiir2w?=
 =?us-ascii?Q?lNIxxbe08X53WSWprSgCI1imZqhnb4BRwv/8QxuK4JO2OvNb2lsbyD2Juoq0?=
 =?us-ascii?Q?GLUUSevewkzXqe3PH786dfBW4gglNrfjAGy+FsmiAHLSNkFR3p2g5C32vhqU?=
 =?us-ascii?Q?pVkmfJhTKlALQKpXasN2FYmbASBFZFnDZQyJbUFMa5zGRdHmMG7hFbl0EmhP?=
 =?us-ascii?Q?LN4/M5l9230B1cUT/QEpj++93pTwKzq38JGDsph/aJLpAhxgx9NRcG8CVIuK?=
 =?us-ascii?Q?hOF10gaLwZCyb0MKphHaDr19ruG5Nj9bcrN210q2vYA/o9paT83VArYhYgSw?=
 =?us-ascii?Q?mbOdUvpIw2EhpyXih6GZS3d+1VDkg2+4egsmd4r4eFmVNnVhjTDYe3YjDDEx?=
 =?us-ascii?Q?3B+0xk5cqtGL1RK5nw1twmOAciuZyODeIwAFj+nTkM+/7oQcLNfFSaI9CwzH?=
 =?us-ascii?Q?Z8fFbxbSR+FAgCayr6OYfrisGv3M0gEKRyMfLugN4oox9gHmIX/mE4DYsxd5?=
 =?us-ascii?Q?p0yYdk5C4Q1AVeu/poLI+XmxbC5/xT3kf4Art76KMGVsK5nDgBNVdObRsiId?=
 =?us-ascii?Q?6mObMBKKPXBZTOY3z4cGh2n7RdDq5h4ceJXzgtFwu6a/GsB78tAyZE4OlVm3?=
 =?us-ascii?Q?EQYL8lQZP9qAtfewmSTZyU6AmTBh7V6FCaZgKXrpObhrhcSqmlTTpkRIIS4z?=
 =?us-ascii?Q?x5SOGjsza+yVqiGO9I5YkWIFe9qRaGGyLvyLISU16jIyz0KTGk5CdtCcQi1m?=
 =?us-ascii?Q?ZYN2cFUMks79tLL9VDae70Tlh/RYYo6ijvCLHZ7FcZWZPJJ0bNVtjSetCFWh?=
 =?us-ascii?Q?O5+WTgXVWo5gI8jgEzAAEt68tLWc6DndhAlcMefCAnNP4OSU8Rh7KZZmMTvc?=
 =?us-ascii?Q?LbBHVZVDbxP9xO/HZFzTuhQi1I4KbnoEmYLwDVrN/068NJL1+PtMb05NgRjS?=
 =?us-ascii?Q?qXrDRLFSMQvjUG9m9OGEsgOLjlQ0/do5KfnJrqxvVfBe484QozD0R5pdF6qX?=
 =?us-ascii?Q?9DEU8JItaHsOdTi1SjGRetMeOBH769zUGDZR4INuchrRKnwr3f82VoPjxd2B?=
 =?us-ascii?Q?VVud9tThvf21ixh6IPEMXxodsj7bpJsExYME45KkcBwRrsb0PbB3k5CB0zLO?=
 =?us-ascii?Q?roFBtearRec+tA9G3vqUm23qS2VkeF0I8QC/LGeFPXP2qpHcis09s9LvyhN+?=
 =?us-ascii?Q?UZMpkbUahABl8Buo1JH0O9QmbCxWWc+OXmizryyFWs5KiRu25551irqm6sIR?=
 =?us-ascii?Q?R1Er08U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3e405c-c98e-4420-2ce5-08df0528cf15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 17:21:34.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, August 21, 2026=
 6:27 AM
>=20
> Hyper-V identifies each PCI pass-thru device by a logical device ID in
> its hypercall interface. This ID consists of a per-bus prefix, derived
> from the VMBus device instance GUID, combined with the PCI function
> number of the endpoint device.
>=20
> Add a registry in hv_common.c that maps a PCI domain number to its
> logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> prefix when a bus is probed and unregisters it when the bus is removed.
> Consumers such as the para-virtualized IOMMU driver look up the prefix
> by PCI domain number and combine it with the function number to form the
> complete logical device ID for hypercalls.
>=20
> Use rhashtable for the sparse exact-match mapping. Lookups copy the
> prefix while holding the RCU read lock, and removal defers freeing the
> entry until existing readers have completed.
>=20
> The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> that pci-hyperv's interrupt retargeting path and the registry use exactly
> the same byte layout. It is derived on demand from the constant hv_device
> instance GUID rather than cached in struct hv_pcibus_device, which is
> private to the pci-hyperv module; this keeps the interface narrow and
> avoids depending on pci-hyperv internals.
>=20
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

This all looks good to me except for a couple nits below. Modulo the nits:

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/hv_common.c              | 112 ++++++++++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv.c |  21 ++++--
>  include/asm-generic/mshyperv.h      |   4 +
>  include/linux/hyperv.h              |   8 ++
>  4 files changed, 140 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index b5d2d6cd65ae..808751aa356b 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -21,6 +21,7 @@
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
>  #include <linux/random.h>
> +#include <linux/rhashtable.h>
>  #include <linux/efi.h>
>  #include <linux/kdebug.h>
>  #include <linux/kmsg_dump.h>
> @@ -78,6 +79,22 @@ static struct ctl_table_header *hv_ctl_table_hdr;
>  u8 * __percpu *hv_synic_eventring_tail;
>  EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>=20
> +struct hv_pci_busdata {
> +	int pci_domain_nr;
> +	u32 logical_dev_id_prefix;
> +	struct rhash_head node;
> +	struct rcu_head rcu;
> +};
> +
> +static struct rhashtable hv_pci_bus_ht;
> +static bool hv_pci_bus_ht_initialized;
> +
> +static const struct rhashtable_params hv_pci_bus_ht_params =3D {
> +	.key_len	=3D sizeof_field(struct hv_pci_busdata, pci_domain_nr),
> +	.key_offset	=3D offsetof(struct hv_pci_busdata, pci_domain_nr),
> +	.head_offset	=3D offsetof(struct hv_pci_busdata, node),
> +};
> +
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -86,6 +103,11 @@ EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>=20
>  void __init hv_common_free(void)
>  {
> +	if (hv_pci_bus_ht_initialized) {
> +		rhashtable_destroy(&hv_pci_bus_ht);
> +		hv_pci_bus_ht_initialized =3D false;
> +	}
> +
>  	unregister_sysctl_table(hv_ctl_table_hdr);
>  	hv_ctl_table_hdr =3D NULL;
>=20
> @@ -315,6 +337,7 @@ u8 __init get_vtl(void)
>  int __init hv_common_init(void)
>  {
>  	int i;
> +	int ret;
>  	union hv_hypervisor_version_info version;
>=20
>  	/* Get information about the Microsoft Hypervisor version */
> @@ -394,6 +417,13 @@ int __init hv_common_init(void)
>  	for (i =3D 0; i < nr_cpu_ids; i++)
>  		hv_vp_index[i] =3D VP_INVAL;
>=20
> +	ret =3D rhashtable_init(&hv_pci_bus_ht, &hv_pci_bus_ht_params);
> +	if (ret) {
> +		hv_common_free();
> +		return ret;
> +	}
> +	hv_pci_bus_ht_initialized =3D true;
> +
>  	return 0;
>  }
>=20
> @@ -864,3 +894,85 @@ const char *hv_result_to_string(u64 status)
>  	return "Unknown";
>  }
>  EXPORT_SYMBOL_GPL(hv_result_to_string);
> +
> +/*
> + * Logical device ID registry for Hyper-V PCI buses. The pci-hyperv
> + * driver registers each bus's logical device ID prefix before scanning
> + * its devices. Consumers look up the prefix by PCI domain number when
> + * building logical device IDs for Hyper-V interfaces.
> + */
> +int hv_pci_register_dev_id(int pci_domain_nr, u32 logical_dev_id_prefix)
> +{
> +	struct hv_pci_busdata *bus, *new;
> +	int ret;
> +
> +	new =3D kzalloc_obj(*new, GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	new->pci_domain_nr =3D pci_domain_nr;
> +	new->logical_dev_id_prefix =3D logical_dev_id_prefix;
> +
> +	bus =3D rhashtable_lookup_get_insert_fast(&hv_pci_bus_ht, &new->node,
> +						hv_pci_bus_ht_params);
> +	if (IS_ERR(bus)) {
> +		ret =3D PTR_ERR(bus);
> +		goto free_new;
> +	}
> +
> +	if (WARN_ONCE(bus !=3D NULL,
> +		      "Hyper-V PCI domain %d is already registered\n",

PCI domain numbers should be displayed as 4-digit hex numbers.
Use format string %04x so that leading zeros are supplied if needed
to make 4 digits.

> +		      pci_domain_nr)) {
> +		ret =3D -EEXIST;
> +		goto free_new;
> +	}
> +
> +	return 0;
> +
> +free_new:
> +	kfree(new);
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_pci_register_dev_id, "pci-hyperv");
> +
> +void hv_pci_unregister_dev_id(int pci_domain_nr)
> +{
> +	struct hv_pci_busdata *bus;
> +	int ret =3D -ENOENT;
> +
> +	rcu_read_lock();
> +	bus =3D rhashtable_lookup(&hv_pci_bus_ht, &pci_domain_nr,
> +				hv_pci_bus_ht_params);
> +	if (bus)
> +		ret =3D rhashtable_remove_fast(&hv_pci_bus_ht, &bus->node,
> +					     hv_pci_bus_ht_params);
> +	rcu_read_unlock();
> +
> +	if (WARN_ON_ONCE(ret))

For symmetry, I'd suggest including a message like in the "register"
function. Include the PCI domain number in the message.

Michael
