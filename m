Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012076.outbound.protection.outlook.com [52.103.11.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D026ED46;
	Fri, 14 Aug 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721496; cv=fail; b=FcILeRCuIY/SmLs+JYsyFEHAxSG18POxoeUsjdadI4SfowkSD4VIDiqbb6rhDzAVuiEw/YZHAPf9ktybvK87HuTcHj0I2G609sVYsfcKRNn5g2Z1G5uKh9Wv84wCc51UTVuD5BPd40RuA+lGFtCWpi+p+OcInRAHmO6lryE9APo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721496; c=relaxed/simple;
	bh=IhpTsfllBDrGkj/ubZHfrcqa0HHFUv7hFSimr0iYUwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYpq1K4akUb/8X0+uOP6RjyXx/VIgsxRMAOtjXStsAwOogml6f0ap7rhT7ATS4RbpXI7hKxtjgcooMcqXaaksPJjLyDe9caGKA2x/LIoyQMk7e5jZVjZyl+sxcKGFAMeD+aanbGMaXc4RwkeNoXrbzwMG2/m02h2oAbHfNdaxe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DAveTf17; arc=fail smtp.client-ip=52.103.11.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DAveTf17"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFQEf6b1Kd0D9qsN2XWGTwEI5dgcGjCwiaHRLX2CDXcQzjpLVGqV5MWM9GDPJ8D2kUbXSjEIrlS1jkQA+UAZ10C+FFfoYUYotLyXiYc5o1Hji19ZGIEPQYVLn+Nxf/2uc+DXyOCtAMNilSHK+uK+fr0rESW5QOy+Mp/UPCJjps0Qr1TYlGVLuO8WV05Th1K5QlVqx66J2Cv1fzDQpIcztYyEevgIRlbVyosVv1DZ6YzPKGlJsvvYKNKI4Ck+pPzN+dM2rU/9JFF8/jeazZiiZt7zXh6i9IwSEKaX22Sl23Gq5g5/J+Zl3XFCH5yncIW+0RNj+hlP8KCvmgjOJujMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJEm2hPwtQsphfY+YVCuB3IoaXGeLNqFr6MxxK4Dt3I=;
 b=igzH4VeTA3VBYSQJRmmkymgkrB/nh92dKbXu7oteqcG5SJM6yYeDCOdqfU5dHfhvkGFEJsXx6BFJ4tftQ/zDLI2NGIM+v9r84vGelUtQV/Ycnt+cL5aq31tSNiqlWEcMM99ODDcJ06O1z4CMEigRTmLuox9wNONh4zVLcfH1go1zlN32rkYbgxSWwqySKXJLTEVGPQtccPFWzUKjj+o2STazLaq9yCHGyzRvcoWtwcH2unnUk6J9likQ66t6MIvzEZQVSt5a3ETsT1/2VeiGUYdI19LdtlgzHTaODJj9dz1QgkgpLdONeDOqezCISnG9s+1LHLO0oXSnX315f/VjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJEm2hPwtQsphfY+YVCuB3IoaXGeLNqFr6MxxK4Dt3I=;
 b=DAveTf17b9vSjzHGVNeP3WtHjQ6hUU7ROqPM517bwUN3xUdXxAXI6sM9NuMrdyl9a4EK8lT4/i2BQkSNZdgRoH9UmUiPPmzDed0B10PMSH1v1gfEehqfGJSVGILS8K17AJlWZeYqpOfth/mWPL7eLhUIvRs3Svj1MUOMdFNWuWzlx2+XyUSTDcuNJBUqNoIiVdKAXalBXFlhck/pQRYcwicR/d0tHLNv4Qjg0I4XnO0ZUmeXB+Cw+2bd6M1JlVAkA68PTX5ihZP0awU7T6JWWLB48HXQS1B9bsa02lx3S0i3TWFOGdXxM3JHQVPB4QoNxU71HoEVqYJdDcmKSP1wlw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BL0PR02MB6466.namprd02.prod.outlook.com (2603:10b6:208:1cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 15:31:27 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 15:31:27 +0000
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
Subject: RE: [PATCH v3 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Topic: [PATCH v3 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Index: AQHdKaksqYpZxqDILkSMgywEvhwx/radsJ0Q
Date: Fri, 14 Aug 2026 15:31:27 +0000
Message-ID:
 <BN7PR02MB4148C2319B12C57B1FA3885ED4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-3-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260811155022.108148-3-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BL0PR02MB6466:EE_
x-ms-office365-filtering-correlation-id: 8f8e740e-73d9-4080-8d43-08defa191b5c
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|24021099003|55001999006|25010399006|51005399006|13091999003|8062599012|31061999003|15080799012|37011999003|8060799015|19110799012|12091999003|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pvYf6stg2L3Aaf3BSEJv/rNNAiH5mdHXC5/hq9eoiRz7f+63u+wgjK8v/Cib?=
 =?us-ascii?Q?AQuMhsH3r31HRCTQE3MPf/+KrnADSxVDsiofk8GeJqahgHTO68LCn3clTgQn?=
 =?us-ascii?Q?1lYxaB8XngbCY4PxWnWw/QI3BUj8nMvgtaaJHVdplN6qoE4kDcaHsslL2+O+?=
 =?us-ascii?Q?YrFtuls+5amJvNpulePtOrKfp3/VKxv7c1Gh8V5yrne7dpxIJ3k2JON2bF50?=
 =?us-ascii?Q?hfANTYgHV5ZtJdq7IF0zBw276ptZAbaPyhzR498MOCa7ZnWrkvt4gHD4yBN4?=
 =?us-ascii?Q?uN0gXkWqLjYTP1E8xRApyMWUaarcMJlJyrfqzJeUBlc0A8uw+K0sQRNUoNVP?=
 =?us-ascii?Q?eYyjid64JT/4isYmSAg1zT0+VXRv5TX1cYJrcsdBnn6nrDvQVK+Pn4mmCRZP?=
 =?us-ascii?Q?4paGGSjd5ZmkaiX4OdqmnFmApQp4UCq2rOeCsZoc6LLRXS8COcbpV+xLPI5V?=
 =?us-ascii?Q?mRnfQKj9QtGiSQsKgpZbRMXu+Y3ah3eJgP+gP+0WAZlCFZiTt4yhb76yJf3h?=
 =?us-ascii?Q?8eRC1A9HjThQZE4q1jieMKgdaMV5U3NA1HZZa0woQzkbhkeN8urH6K9qe/iH?=
 =?us-ascii?Q?2hyUP1E7oWzOYPt3qWnmPlWkKRPJ6VjGiuW87x+y9PHGkR9XY0HFoGQtxzMq?=
 =?us-ascii?Q?/gc8aoxHewkKT2ygpL9vtfBVy9NuZrnSfr0U0E8VPc1ukeSpOKM4Q+55tM9W?=
 =?us-ascii?Q?8xTeOJoPH9Uo0gEvDZMoxQqvxnG3HkHzVgAn42+AcSxpZ/S5dFooiprEbLZh?=
 =?us-ascii?Q?i4uT9PXYxp+evMyFH/9kAY6LNnYZ0jcq2DDAgNB9MLXjH7k+qrlfJmyIFXxE?=
 =?us-ascii?Q?DJIADziFNA7bWWyWtHGiM/R3084n5/XVa/HJZe5atjFsHUjCBHyqypp9Clk6?=
 =?us-ascii?Q?MAG3v2l3/sKdIFNbAo46+/0fKbWQ0a5cw4BGoDKcgQYkDB+ADf8jEuOjE4i9?=
 =?us-ascii?Q?vE0USn+QccY20mXhTorXGRF2OJqR8q3XXLGQfJsKv8bno1tOLZOmZzkJbhNU?=
 =?us-ascii?Q?k9/shOnwHoB4ddJ92L/rv+pht3/FLpcTMXNBB/lIIijDnuHJjBqPCNFkzXhR?=
 =?us-ascii?Q?K1eyef5bH8nlUWgeyh2EPwpQNflNj8A3n4aIx3UCVn7A2LQ/lSEinWe78x2O?=
 =?us-ascii?Q?wwT+uKkA5Xkx?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?txqX0yJh+30kFtaGXp3yztYyOosXpslctqTseGOUlAXOxmLAburzZ8PRXz2J?=
 =?us-ascii?Q?eTX+AoOCWAZRt2QUXpMcXHButNfJlTMFMvFxVid/Q62ezeSs820n/kMda2gX?=
 =?us-ascii?Q?J22iUzkmgNQPjloHkWEjTslVqEjWRRuOlIKi54f8ln4Fil39LLoyQsAFga2E?=
 =?us-ascii?Q?O7q9MZqGsZBi/RtpyxciPySd5BnDw/7T8QvZdGzJOXknkaNPkJZxWokUHEW0?=
 =?us-ascii?Q?2Xh4omtQZmm1ZzZTBlf5YJ3UDroxztBBDg2xm5V8gSXnIdWn/m7e7YyvrtBV?=
 =?us-ascii?Q?zipWal43tR6yD3v866pkGi3smzv3H/MUghysBLrZPvsJ/EdvWvNKSFo0h8LD?=
 =?us-ascii?Q?SKzvgNVGRs6Nzck2VVCDzs8mz0XaC5sfoWFidbE3AhQnVHI1Tg+hA7WiqIis?=
 =?us-ascii?Q?DD8ftQzMiU6wH1iXqJ2DjNzzpq2+H7KcMDr0w3/vyRmZE42qKUmMl8zrVjoe?=
 =?us-ascii?Q?qHijfzuL5ALh1GDGSbWgFzAE6NS/pe04/fEFnGCdVttFBawi4LcL1VCsN8zD?=
 =?us-ascii?Q?QxP88vojeMxu9NcP4zg+9r5uqJ3Xt9FYcdeiIvZgFYSLN5wcnevF2yfl+9TP?=
 =?us-ascii?Q?XV1/L3nK5rFneAn86zTNFvo3WPYjjj5YLiuwadeD69EW9hL6pVYyJIYOqlxw?=
 =?us-ascii?Q?wayHs68JSi1oa19skRQg3cuJzbWuG5nA73Kil321qT1/CZ8wO4u3tvZoKxxc?=
 =?us-ascii?Q?GsNrND+PjywI7HQDMijapsEsqrBdBc1ut/qYXKZpYK9mJQIEAFHHOBDWEsJF?=
 =?us-ascii?Q?C4Q6sJ7wMWO8siPWV9GKTT8t9f1TVjlVDmsaFqYbg/WnCN0mXpqO3F22S078?=
 =?us-ascii?Q?pF+fsJV64eBLcYxGmAbEpUW7N6EcWp1jO/esIFbFUCZJLM/9gDIPGtLlMSe2?=
 =?us-ascii?Q?8vUHRbYO/WLdI0y64Oyuii3/py8VH5SMF2iYkhmu+V3VH0uw9vxkSi49eZoJ?=
 =?us-ascii?Q?mdDmhCkOuc5NfCYThrZPMRVGYG3X/+dfAIqg+UtwYlcWM+TKDzpn9+NPDMIO?=
 =?us-ascii?Q?4gR6/BQbgSxurjpUjM52WICdYyAV9O/0kcFeWCo1h0MJ56KXtki9tftABBR9?=
 =?us-ascii?Q?qb45iD27aW3uNhVHwDZj1DchfuLC/ON/Z57sxp+IQg0uScLjdn5gx0ff3zwo?=
 =?us-ascii?Q?0TnSrMWTzZpLtn+0D1S3hhcrhJa53/MbXZTtxVix2kABbIfMtDPKbc/UmkmZ?=
 =?us-ascii?Q?QdI84yGRFouTinLVc4t2Jnh2v36YgM2JO/ZyhCFOb1zt1VtxzxHL4wPE7zaE?=
 =?us-ascii?Q?+cGNc9rPWS0Brqp91sRVlBXBXZ3RL6kdV3WM5dZNi0Bx213AC8S+0ut9r4sn?=
 =?us-ascii?Q?0w9Uut91O6JWPZ/gO1VXD58eWEgjEZvm38kjRpcfuXmt9LAzPptLfTkgKvkA?=
 =?us-ascii?Q?kO3gdnA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8e740e-73d9-4080-8d43-08defa191b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 15:31:27.2931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6466

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Tuesday, August 11, 202=
6 8:50 AM
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
> ---
>  drivers/hv/hv_common.c              | 123 ++++++++++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv.c |  21 +++--
>  include/asm-generic/mshyperv.h      |  14 ++++
>  include/linux/hyperv.h              |   8 ++
>  4 files changed, 161 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac616789..b30495b48a37 100644
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
> @@ -78,6 +79,27 @@ static struct ctl_table_header *hv_ctl_table_hdr;
>  u8 * __percpu *hv_synic_eventring_tail;
>  EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU

Making this code in hv_common.c conditional on HYPERV_PVIOMMU
assumes that the only consumer is the pvIOMMU driver. But my
understanding is that root partition code is also expected to be a
consumer, and I would guess that code is independent of a guest
pvIOMMU. So the #ifdef might need to become more complicated
to also allow the root partition case. I'm thinking it makes sense to
always build this code as part of hv_common.c. Even when building
for a guest only with no root partition code, HYPERV_PVIOMMU
defaults to HYPERV so the pvIOMMU driver will be built anytime
Hyper-V code is included, unless someone goes out of their way to
disable it. Getting rid of all the #ifdef'ery would make the code a bit
cleaner, and I'm looking for an excuse to do so!

I'd also note that CONFIG_HYPERV_PVIOMMU isn't defined
until Patch 4 of this series. This patch will still build without the
remaining patches, so bisect isn't broken, but it would be with
the equivalent of CONFIG_HYPERV_PVIOMMU=3Dn. It's a little bit
weird to be using a CONFIG_* value before it is created, but maybe
the ordering among the patches is complex and not easily sorted.
=20
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
> +	.key_len		=3D sizeof_field(struct hv_pci_busdata,
> +					       pci_domain_nr),
> +	.key_offset		=3D offsetof(struct hv_pci_busdata,
> +					   pci_domain_nr),

Nit: The above two initializers will fit within 80 characters on a
single line if you take out an unneeded tab before the "=3D".

> +	.head_offset		=3D offsetof(struct hv_pci_busdata, node),
> +};
> +
> +#endif
> +
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -86,6 +108,13 @@ EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>=20
>  void __init hv_common_free(void)
>  {
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +	if (hv_pci_bus_ht_initialized) {
> +		rhashtable_destroy(&hv_pci_bus_ht);
> +		hv_pci_bus_ht_initialized =3D false;
> +	}
> +#endif
> +
>  	unregister_sysctl_table(hv_ctl_table_hdr);
>  	hv_ctl_table_hdr =3D NULL;
>=20
> @@ -315,6 +344,9 @@ u8 __init get_vtl(void)
>  int __init hv_common_init(void)
>  {
>  	int i;
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +	int ret;
> +#endif
>  	union hv_hypervisor_version_info version;
>=20
>  	/* Get information about the Microsoft Hypervisor version */
> @@ -394,6 +426,15 @@ int __init hv_common_init(void)
>  	for (i =3D 0; i < nr_cpu_ids; i++)
>  		hv_vp_index[i] =3D VP_INVAL;
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +	ret =3D rhashtable_init(&hv_pci_bus_ht, &hv_pci_bus_ht_params);
> +	if (ret) {
> +		hv_common_free();
> +		return ret;
> +	}
> +	hv_pci_bus_ht_initialized =3D true;
> +#endif
> +
>  	return 0;
>  }
>=20
> @@ -863,3 +904,85 @@ const char *hv_result_to_string(u64 status)
>  	return "Unknown";
>  }
>  EXPORT_SYMBOL_GPL(hv_result_to_string);
> +
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +/*
> + * Logical device ID registry shared between the vPCI bus driver
> + * (pci-hyperv) and the para-virtualized IOMMU driver. The vPCI driver
> + * registers the per-bus logical device ID prefix at bus probe time, and
> + * the pvIOMMU driver looks it up to build the full logical device ID us=
ed
> + * in IOMMU hypercalls.
> + */
> +int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_pref=
ix)

The comment above is written as if the pvIOMMU driver is the only
consumer, which isn't accurate assuming the root partition use case
materializes as expected.  And that also means having "iommu" in the
function name is overly specific. Same with the other function names
with "iommu".  There's really nothing here that is specific to pvIOMMUs.

> +{
> +	struct hv_pci_busdata *bus, *new;
> +	int ret =3D 0;
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
> +	} else if (bus) {
> +		if (bus->logical_dev_id_prefix !=3D logical_dev_id_prefix) {
> +			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new =
0x%08x)\n",
> +			       pci_domain_nr, bus->logical_dev_id_prefix,
> +			       logical_dev_id_prefix);
> +			ret =3D -EEXIST;
> +		}
> +	} else {
> +		goto out;
> +	}
> +
> +	kfree(new);
> +out:
> +	return ret;

The typical pattern is that non-error path goes straight through to the ret=
urn,
and the error paths do the goto's the cleanup and exit. So I'd suggest that=
 the
two error case do "goto out", and "out" do the kfree and return. The non-er=
ror
case just does "return 0" instead of the "else goto out".

Separately, it seems like the existing calls from the Hyper-V vPCI driver s=
hould
never duplicate an existing mapping. Your code disallows mapping a domain_n=
r
to a different logical_dev_id_prefix, but silently allows entering a mappin=
g
that already exists as an exact match. I wonder if that really should be
allowed, as it seems likely such would be followed later by twice removing
the duplicate entry, with the second removal failing. Removing a non-existe=
nt
entry is also silently allowed in the unregister function below, with the s=
ame
question as to whether that should be allowed.  =20

> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");

This may be overly restrictive if the root partition use case code is in th=
e
mshv_root module.

> +
> +void hv_iommu_unregister_pci_bus(int pci_domain_nr)
> +{
> +	struct hv_pci_busdata *bus;
> +	bool removed =3D false;
> +
> +	rcu_read_lock();
> +	bus =3D rhashtable_lookup(&hv_pci_bus_ht, &pci_domain_nr,
> +				hv_pci_bus_ht_params);
> +	if (bus)
> +		removed =3D !rhashtable_remove_fast(&hv_pci_bus_ht, &bus->node,
> +						  hv_pci_bus_ht_params);
> +	rcu_read_unlock();
> +
> +	if (removed)
> +		kfree_rcu(bus, rcu);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
> +
> +/*
> + * Look up the logical device ID prefix registered for @pci_domain_nr.
> + * Returns 0 on success with *prefix filled in; -ENODEV if no entry is
> + * registered for that PCI domain.
> + */
> +int hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix)
> +{
> +	struct hv_pci_busdata *bus;
> +	int ret =3D -ENODEV;
> +
> +	rcu_read_lock();
> +	bus =3D rhashtable_lookup(&hv_pci_bus_ht, &pci_domain_nr,
> +				hv_pci_bus_ht_params);
> +	if (bus) {
> +		*prefix =3D bus->logical_dev_id_prefix;
> +		ret =3D 0;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}

Unfortunately, it looks like changing to use rhashtable didn't reduce
the lines of code. :-(   But compared to a linked list, it does provide
better performance when the number of entries grows.

> +#endif /* CONFIG_HYPERV_PVIOMMU */
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad..0b12b18fe0f1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -641,10 +641,7 @@ static void hv_irq_retarget_interrupt(struct irq_dat=
a *data)
>  	params->int_entry.source =3D HV_INTERRUPT_SOURCE_MSI;
>  	params->int_entry.msi_entry.address.as_uint32 =3D int_desc->address & 0=
xffffffff;
>  	params->int_entry.msi_entry.data.as_uint32 =3D int_desc->data;
> -	params->device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
> -			   (hbus->hdev->dev_instance.b[4] << 16) |
> -			   (hbus->hdev->dev_instance.b[7] << 8) |
> -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> +	params->device_id =3D hv_build_logical_dev_id_prefix(hbus->hdev) |
>  			   PCI_FUNC(pdev->devfn);
>  	params->int_target.vector =3D hv_msi_get_int_vector(data);
>=20
> @@ -3715,6 +3712,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	struct hv_pcibus_device *hbus;
>  	int ret, dom;
>  	u16 dom_req;
> +	u32 prefix;
>  	char *name;
>=20
>  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
> @@ -3857,13 +3855,22 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  	hbus->state =3D hv_pcibus_probed;
>=20
> -	ret =3D create_root_hv_pci_bus(hbus);
> +	/* Register the bus before scanning any devices on it. */
> +	prefix =3D hv_build_logical_dev_id_prefix(hdev);
> +
> +	ret =3D hv_iommu_register_pci_bus(dom, prefix);
>  	if (ret)
>  		goto free_windows;
>=20
> +	ret =3D create_root_hv_pci_bus(hbus);
> +	if (ret)
> +		goto unregister_pci_bus;
> +
>  	mutex_unlock(&hbus->state_lock);
>  	return 0;
>=20
> +unregister_pci_bus:
> +	hv_iommu_unregister_pci_bus(dom);
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
>  exit_d0:
> @@ -3977,6 +3984,8 @@ static void hv_pci_remove(struct hv_device *hdev)
>=20
>  	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
> +		int dom =3D hbus->bridge->domain_nr;
> +
>  		tasklet_disable(&hdev->channel->callback_event);
>  		hbus->state =3D hv_pcibus_removing;
>  		tasklet_enable(&hdev->channel->callback_event);
> @@ -3994,6 +4003,8 @@ static void hv_pci_remove(struct hv_device *hdev)
>  		hv_pci_remove_slots(hbus);
>  		pci_remove_root_bus(hbus->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		hv_iommu_unregister_pci_bus(dom);
>  	}
>=20
>  	hv_pci_bus_exit(hdev, false);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bf601d67cecb..4b3c9ba69cdb 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -73,6 +73,20 @@ extern enum hv_partition_type hv_curr_partition_type;
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int  hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_pre=
fix);
> +void hv_iommu_unregister_pci_bus(int pci_domain_nr);
> +int  hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix);
> +#else
> +static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
> +					    u32 logical_dev_id_prefix)
> +{
> +	return 0;
> +}
> +
> +static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
> +#endif

These stubs won't be needed if the code in hv_common.c is always
built.

> +
>  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index a2b484679eb4..7bc7b9b60002 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1287,6 +1287,14 @@ struct hv_device {
>  #define device_to_hv_device(d)	container_of_const(d, struct hv_device, d=
evice)
>  #define drv_to_hv_drv(d)	container_of_const(d, struct hv_driver, driver)
>=20
> +static inline u32 hv_build_logical_dev_id_prefix(struct hv_device *hdev)
> +{
> +	return ((u32)hdev->dev_instance.b[5] << 24) |
> +	       ((u32)hdev->dev_instance.b[4] << 16) |
> +	       ((u32)hdev->dev_instance.b[7] << 8) |
> +	       (hdev->dev_instance.b[6] & 0xf8u);
> +}
> +
>  static inline void hv_set_drvdata(struct hv_device *dev, void *data)
>  {
>  	dev_set_drvdata(&dev->device, data);
> --
> 2.52.0
>=20

