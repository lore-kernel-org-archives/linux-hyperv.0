Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012050.outbound.protection.outlook.com [52.103.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55945561A;
	Fri,  4 Sep 2026 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533592; cv=fail; b=Beqs1HmiXaf4qiyTLeo+LP/OUPkXrRpAAHlkW1VyuKHqSlYhypmynFaBfwr/RRJPGSlbyEikOzTDejZvYZ3xRHEZ8LmqLdPr0nOzeKp/KT6JRNy45uPNxCKmux6ljZyZTeIwpPKwri/HnlpRVQn+fANu4PLRaN/x/Nm+cg5eCwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533592; c=relaxed/simple;
	bh=kIhwguO75yHkS0sXrSLkC0L9HKStx45wTOTk5LvtvIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1ZLly2sbti0Q0cQQnc178+EhpY5iHGjdk1IJk0FezpNJhgWs9V3BP5885VaZHzyF5y+CtXCZlHfvVaMjLl4Tcj3bl5aaLZk305MtlBUmYw4lbMk8WpugglnkGpN3FLYxi5gnNoPwmz9gxlbOnALngY+NtXvoJir9G63rVWuSsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r8g4e+Fg; arc=fail smtp.client-ip=52.103.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r8g4e+Fg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXGDiPLeJ9Ms1td72XPFDnwynssany/Mf4UEOQTho3ahdqpC9eeavxkVNb2n4uOiiFCTFHwviY+MuK0XQmCV+6OOYQ9ICSgEFH1NpPvv1j8dmreleJPHMCGdpAK33fR0zdEEBnWEGYV/2bmgKzRGTY3WOamyGOrqoS3tZo9PYF/w2NMt/pLzkuPfw0SbGDee7l40XkgrHaY6bCD8ccjSHXi5DCYvEhg9/2NUMvxn1HTCLt4pUMamzFCsx2aboVngHe9nOVNCwcmYaYV916PmikFgIL8pjYGvjzhmuz7BuiACH4GjY5U0+WbGYLI9d1Vf4wHXlGNt69gaLLEE70njrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n12tYqoB335Oj1LibxDTsqJZTV1qITKnlZ5gpZKYkQ=;
 b=nEq5M6eID501MfUpiCA69Pl5ZQlmnFCmC/cIJJuG9zojDg6h3N0lgCrmCmq9SkQxm/uBWSeG1yHfAe6egsOxRaK8u0JfHoYhGibahJf4QpcdzmVRK09eZ1n6hM4hCtXh4WUFA3voR51GffSO2VydwUNOY0H7I03knzhmwyA7gciZB095HhbCaC1MUewE79kRAaPT+t7mGfwllQzOdgcWi6QIXTYDqJX7vU5rI389ukMAAU65TyHf650gewwVn+rRLsdR1otdt8gA7MRHNcp0sbO1dES5kKYX/TYVLHZV7dTQVeSOQIUyaLeK85r7Xt0xaGrzz7FTrDya71rTWoMcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n12tYqoB335Oj1LibxDTsqJZTV1qITKnlZ5gpZKYkQ=;
 b=r8g4e+FglxbLd99i5trGihKbhkXeAAj2E45OsRi5W9g61Jr9J6u54CmYBjvXOwKDQ8hE73p6tExilM3IlxZo56950YpoEnDn+7Uh/LdHn601REMb7Q4OWI6NWrYjdLV3B6nzGHctfucri99X8Y8tfb+9Ff4G8+Z10Gu2jdbKT9A3KmFy0XlgyS0I4YQvsUzyUpp2zf+wzftFCwoVhLSIyc05KtHgmsgkMYvqsjKNqPZwYqbPxqazxn6R83yD/DIgfcU07tgO/WnrKAxc1tT0RrCY1RfzwFBxR9nwbSvwhloGuuyxhlVeH9bHnCe/NqqyJ9yeQzfL7hABnkJJkMfufQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CHAPR02MB11381.namprd02.prod.outlook.com (2603:10b6:610:300::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 14:53:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:53:08 +0000
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
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v5 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v5 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQHdPELQGgO74D9XNUqyaDBdno3eYba+gabA
Date: Fri, 4 Sep 2026 14:53:07 +0000
Message-ID:
 <SN6PR02MB4157459466C149E93D499050D4B52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-6-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260904075512.174154-6-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CHAPR02MB11381:EE_
x-ms-office365-filtering-correlation-id: bf5983d8-ad17-4556-15c4-08df0a943b7a
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|24021099003|8060799015|8062599012|13091999003|31061999003|19110799012|51005399006|37011999003|15080799012|55001999006|12091999003|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8b3K00mr2z3PEPi1PwOP7B4O9RVfTJ+U8VLwDQ/io7Gz6W7IUQsbjZRAnIgG?=
 =?us-ascii?Q?2JbLz62xEfNt1YPvs97rpmMvK42JijrI7az1dipE99ImCY6CIbt3wCKUsxwX?=
 =?us-ascii?Q?8bhIaHQLbep3jtXAXhf5wx6MRU+Vxu5PnUdqNDoiGSIJ+zPhB7XPZzJJ/GC6?=
 =?us-ascii?Q?hetmBZoyBhab8GbIX/hfSDL80AXGXH0x4aCqnyzaZqfylgW4H6Pzn+ysnKkZ?=
 =?us-ascii?Q?Bn3zi9OEc40w2nYjEYf8icbJdkI2HFrCKPHWF2/zORBA2gs+haiuIfGOHcEi?=
 =?us-ascii?Q?pM7MGNRAAr8LFKazz8QZZBJykMxf29L7tNCRpY7iHAVVTGT+6e28kTw28Ztt?=
 =?us-ascii?Q?udv367nXwJlydERAbtB4OK60l4xKvO0G5thwnAeNF6cKF+F4lGguBh7Zs16k?=
 =?us-ascii?Q?k17SpMvxKDICIJHnBOh4Y/0FBTqVAKddQMDwfjZU2a2cSzBB+57nOtt5gSN2?=
 =?us-ascii?Q?kiU8wGpA7rhK9AsIcZPmSO6MfnuXdahOb/Vopeupo1/6hUIO5y4F0sFqPUrd?=
 =?us-ascii?Q?PIvI9FL/9TSfG4KjwJMPcglHr41913P4RNh2M2XkWZX5B2c0K8QZJZcf6oTa?=
 =?us-ascii?Q?c1qn41KO3aX83CMSutvxndJOG850o5IFeewJWSSbUAaPfl36riWSD6ykqdBW?=
 =?us-ascii?Q?v0pILIt9XSH+9gs2Cbq9gKe8Decr/s15VH86Q197DYXU/64/gg3btUw2smY9?=
 =?us-ascii?Q?KROguu6bDIj5FbpTj+L1qKr6/fOcuQ6wh0prYxNT9GxiUL6wsZq2yKzoO883?=
 =?us-ascii?Q?gEE1cMQ/gTKIE9bcv9i6HLmrIKESZ99nkPVRI5s5xhwUUHADAqcdTAvTLv2w?=
 =?us-ascii?Q?baNLB4ZVWNlTlSGnkq1M/ldd1rBsj5hI0QtG26xA0ZwGuMUhMouwWKf60AWU?=
 =?us-ascii?Q?M4WhH0wEiMWtFxdE6qv3DRtOItA18g24tdg61gQr1/iovPfyqHUVG3Vo1Esc?=
 =?us-ascii?Q?JCKbm2yKIgOwBIGuqAb94UIPzTQ+9o8anwKtyH89sQfj4Q7yZslRdt+OMpe4?=
 =?us-ascii?Q?kJY4P5s+eXrrBOOFc58nXPO3PUqNJqkhlZdjZimMCW8WlqAmY4LES/G+RHyk?=
 =?us-ascii?Q?wYQwXiZX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jot+kPSAlCrGnNKbUmNXle4uh61y/B4oRdHcs0+67Q1QtVKAq8r0xPi6+Pcn?=
 =?us-ascii?Q?PygaNvwx5DwcQ43Jsk6U6hZ+AJI8F5eEqB2n602vPZgWLnqgSI5QHxyR4ou4?=
 =?us-ascii?Q?Aj9A6PB1J/yy/KV/I1ZQ2sg0uey1jJ+rixfh05QXNkyd6OKBavZngB9ERllo?=
 =?us-ascii?Q?MVtM7v6TmFpF+pFjREN8wFVwYxZEarmlhymPnW9n/JUUwemIyZYMfM01bFaA?=
 =?us-ascii?Q?kSo50GFujL8aDaqLa/hFknEXqTLfL9Tot0F7WSsh0cIBeu+qVWCfUDto2eqz?=
 =?us-ascii?Q?FrP+rThAexSKm/la69Q/hYt8dMi8qivvKPyHQjqI7EN9twonzmDWgl6jhqdc?=
 =?us-ascii?Q?S2WNQKLdihyaAOJ1phmuG39AzY0IAmsta+I8ybJ0Al8U70aACW40ccCmBONZ?=
 =?us-ascii?Q?ceMQEd9STVGk5VauxgTTiuFKH+q4+TwY6PdvxGrnYS0MH2xmWIvYH5CCDl9l?=
 =?us-ascii?Q?lNJjtnH2ZzJTnA6ihbv/gja6lqZcJnjynZbirCF5/mCIae/8gNSM3kM+FVsx?=
 =?us-ascii?Q?wClu8Q36s5s5kbjYOdipr7GWf/AXDhJuY6kqK/rH3RrRNZH+VeCIVx1eljCo?=
 =?us-ascii?Q?9+fEzGRiX1tOoE7/oW4QjWMhLrNR1qJKlE9p77VbqBKLKF5I+CGIHdWQk/uc?=
 =?us-ascii?Q?RrKac5hTNu1Ky8lcU5a1K5gZR5QTAye+pnMjya3+/JI24rrbyY9HjY/6FJ1Q?=
 =?us-ascii?Q?tAcjRXmH8aHq7uZVQqTLmg01LV4iz9typsEELX+X5q+UdyIk5+KinIvobEvr?=
 =?us-ascii?Q?FF4tjYzhudt5PsAq7E0439zXWyN/jnLhtBLGxGTniF82ZeqgtBP6aSlMXE57?=
 =?us-ascii?Q?jHAdYdTmXoMj1nc/BuWyrwN8nPF3bSpRrJqf/fkANkDifeRyxB+dZqQAd7yi?=
 =?us-ascii?Q?nm0rjReGR0twArXO8IKOrrevCMAsxYl/oEybpNTl5wu+Z4wbhPfj1RsQbh4L?=
 =?us-ascii?Q?GucbsX24K4NCt8iwRrdGOhHMOQ0m7O8Fa0pfpFgQCZVuIP5EPVgRIU8Tomql?=
 =?us-ascii?Q?QSxYSa46Muz+tfHsV8I/6mKRx9rteRLM/2lcihXVKxvrKlUMGg6uxz0NANRv?=
 =?us-ascii?Q?7e5UxCqcnC1jmqa69vuTXw6qPi37wGf1P9nNvdsSwYTCltq5YeZW94rG4OrG?=
 =?us-ascii?Q?ZO87S4fr08WhffsPCsikO9xSrWRFurHeKy15Px08d9+BdcEYX/iEO4vnHQ2F?=
 =?us-ascii?Q?pIZSKxtAhvCuHQvWyyHzxsE0RO0hqa1DdUXxtLX5v1/pT7auAvIBXBLDirTw?=
 =?us-ascii?Q?7sXjHLWLb3stQq9kIKa9W/BCQam5NmlIqCjuk5TF0JORI3GV/8pkOnoWtumv?=
 =?us-ascii?Q?XApDqaYQ+j0JSX89Zk5CGeDty9k9prJ4S3oDa458oAXQuNurqp0Gu5jvRdsm?=
 =?us-ascii?Q?zDnmdzs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5983d8-ad17-4556-15c4-08df0a943b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 14:53:07.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR02MB11381

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, September 4, 20=
26 12:55 AM
>=20
> Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> This hypercall accepts a list of (page_number, page_mask_shift) entries,
> enabling finer-grained IOTLB invalidation compared to the domain-wide
> HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
>=20
> hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> range that covers the target IOVA region, producing a single flush
> descriptor. This may over-flush when the range is not naturally aligned,
> matching the approach used by Intel VT-d PSI. If the page-selective
> flush fails, the code falls back to a full domain flush.
>=20
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 74 ++++++++++++++++++++++++++-
>  include/hyperv/hvgdk_mini.h           |  1 +
>  include/hyperv/hvhdk_mini.h           | 18 +++++++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv=
/hv-
> iommu-guest.c
> index 137f232d74fe..13eb85b4a424 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -384,11 +384,82 @@ static void hv_iommu_flush_iotlb_all(struct iommu_d=
omain
> *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>=20
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, =
end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligne=
d.
> + */
> +static void
> +hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> +			  union hv_iommu_flush_va *va)
> +{
> +	unsigned long aligned_start;
> +	unsigned int sz_lg2;
> +
> +	sz_lg2 =3D max(fls_long(start ^ end), HV_HYP_PAGE_SHIFT);
> +
> +	/*
> +	 * A valid IOVA range shall not span bit 63. Use the maximum mask
> +	 * so the host can safely perform a full flush.
> +	 */
> +	if (WARN_ON_ONCE(sz_lg2 =3D=3D BITS_PER_LONG))
> +		aligned_start =3D 0;
> +	else
> +		aligned_start =3D
> +			start & GENMASK(BITS_PER_LONG - 1, sz_lg2);
> +
> +	va->page_number =3D aligned_start >> HV_HYP_PAGE_SHIFT;
> +	va->page_mask_shift =3D sz_lg2 - HV_HYP_PAGE_SHIFT;
> +}
> +
> +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domai=
n,
> +					struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain_list *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	/* Clear the fixed header and the single range entry. */
> +	memset(input, 0, struct_size(input, iova_list, 1));
> +
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> +	hv_iommu_calc_flush_range(iotlb_gather->start, iotlb_gather->end,
> +				  &input->iova_list[0]);
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> +				     1, 0, input, NULL);
> +
> +	if (WARN_ONCE(!hv_result_success(status),
> +		      "HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed: %#llx (%s)\n",
> +		      status, hv_result_to_string(status))) {
> +		/* Page-selective flush failed, fall back to full flush. */
> +		struct hv_input_flush_device_domain *flush_all =3D (void *)input;
> +
> +		memset(flush_all, 0, sizeof(*flush_all));
> +		flush_all->device_domain =3D hv_domain->device_domain;
> +		status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> +					 flush_all, NULL);
> +		WARN(!hv_result_success(status),
> +		     "HVCALL_FLUSH_DEVICE_DOMAIN fallback also failed: %#llx (%s)\n",
> +		     status, hv_result_to_string(status));
> +	}
> +
> +	local_irq_restore(flags);
> +}
> +
>  static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
>  				struct iommu_iotlb_gather *iotlb_gather)
>  {
> -	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +	hv_flush_device_domain_list(to_hv_iommu_domain(domain), iotlb_gather);
>=20
> +	/*
> +	 * The hypercall also invalidates non-leaf page-walk caches, so
> +	 * detached page-table pages can now be freed.
> +	 */
>  	iommu_put_pages_list(&iotlb_gather->freelist);
>  }
>=20
> @@ -440,6 +511,7 @@ static struct iommu_domain
> *hv_iommu_domain_alloc_paging(struct device *dev)
>=20
>  	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
>  	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.common.features |=3D BIT(PT_FEAT_FLUSH_RANGE);
>  	/*
>  	 * Hyper-V S1 domains use a 4-level root for IOVA widths up to
>  	 * 48 bits. A 5-level root is used only for wider apertures when
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 5d1338197eee..966945f0504f 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -497,6 +497,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
>  #define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
>  #define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
> +#define HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 7b9f43b320cd..57b70efe60d4 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -685,4 +685,22 @@ struct hv_input_flush_device_domain {
>  	u32 reserved;
>  } __packed;
>=20
> +union hv_iommu_flush_va {	/* HV_IOMMU_GVA_RANGE */
> +	u64 as_uint64;
> +	struct {
> +		u64 page_mask_shift : 6;
> +		u64 reserved : 6;
> +		u64 page_number : 52;
> +	};
> +} __packed;
> +
> +/* HV_INPUT_FLUSH_DEVICE_DOMAIN_LIST */
> +struct hv_input_flush_device_domain_list {
> +	struct hv_input_device_domain device_domain;
> +#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT BIT(0)
> +	u32 flags;
> +	u32 reserved;
> +	union hv_iommu_flush_va iova_list[];
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.52.0
>=20

