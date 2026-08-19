Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010047.outbound.protection.outlook.com [52.103.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007013A83AC;
	Wed, 19 Aug 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155190; cv=fail; b=Z58FdDYbky2oizU4l1nMgGJY7XRiz9GcgS8/hnR7XfMa8NQlKzZOywq4iuGPdx+x1biybgQEjOIMjweLhVIk29M3FGA6DGUUIdB0P5SQaQ8QC0NZZYfz1FdKjpPdx5yEUeDk0jXbr9CdgO7FmWkjH2Dv234AsxaO8jzVlobK1Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155190; c=relaxed/simple;
	bh=XepYNnxqfJUzSYJEuqBsRfIlNGbG18mz/DCuaQhWWXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PO4BXmRDzUo64QyE321+g2l9Mye2ltA8wBemjNvrEHksKrFi01V2YMT90pgHFaBc3PxqrQvJRzwLQn9mePRr6Ud32bky3bivibniHKyvZp1rqleMiquUPQtS/V8AaezvqMuE6Gbe/17efG0WemVSHlnazSYYuqn99Hh1Ipet95k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QxLiYPyx; arc=fail smtp.client-ip=52.103.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QxLiYPyx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCqydew2LfyAvFSGRF0MJLqPQ4pDs0km4JUQl0d1J5W/AqaVYGwcFVcLenOBinxEE5/BWmW0yR9UHEN23fid/EGD9eglqVlL/70QqeASw2M2RXzvXFH4vcIR7cTWrwDllIYbGMDf8kQbHXH/MxYSSKKXTmthyBJvnmWbVs3fil7GITi6XlE9v3vDdrUbPlvT1nFI0J7spEqme/PDgkhCtXoX8XjUQAJUxaBJlj94ZdLGYdm6gcCdO2TcFkfOokY1MFN8YHF3mahFao8YJr8B91AuRdCWgcbHdr7XGD+pjB3m1jNifq7zpcNR0yCKoV4LL+s04+sRB0VjOoL0XBC5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG1Vg6xX7xeco+y8LIs8UEgp9zhQ5ByGaiSUh2dvBFM=;
 b=LaL29E7HD61cAecou0V1d0kEgkZpa+NIEG8KmrLmULmHeO+mdHOLm9lHJKL6OUaJfT+viPeY6a5K2HyTEnPAdvsEUvhLD38EyWVQjP8BxjbrQ6gKRNoTmyNQdrkkn8vjcGKHn8mJeIW826A4I+LDETXquMRnICQruGJ4z3ELe3BAsl2WgPdIuQDqCrJIPB+ERv2Ns4SxWssPcARIJpbVuaTrk8qiw/Cj9N99QWt5KzQ5hbr6yL5nYounANWlpdBUmv2rcH0U/OZ1gjG+n/6yQEtxE20ZQx5UMC09tO3e5rZTmPtsvZZYRxlotYhwgVVUS2OQLSCbcgWisB9EvnObDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG1Vg6xX7xeco+y8LIs8UEgp9zhQ5ByGaiSUh2dvBFM=;
 b=QxLiYPyxPLxfMp9iDf+tCzC7GZ+bNzxwmMZLzGxKchT7jzz/0+Y+U8KvtvFcImyFuSbtfAUyfZEdEaiZT8rOu4oAr46RH2o/HyfDhxw1Yl03/2PwkNqo+EEQX6RLBaI9SShXlONqE7BXriM4IV+1ctZ1dgRNLfjIooUvMsvL97vCYDsxlbtygz3pTu5uyVX/WnMLGO2gfWqOPCXY7mnnJ0m9RfzWwx7f0Tbn9V1UQZK/QgDXJh3RGhelSu1Z7mwlpqB1QY3QvSfC5lI77euzjDrXVtmwetCWVlsoSTcIyNmqGbr96mA3+OYvt9PE3pmN0hBrXxiEUfXV7Ue9Tew1cg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8095.namprd02.prod.outlook.com (2603:10b6:408:164::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:59:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:59:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Robin
 Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Aditya Garg
	<gargaditya@linux.microsoft.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Thread-Topic: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgHTB9rPtt3FEWCAAEDFAIACIFsQ
Date: Wed, 19 Aug 2026 15:59:44 +0000
Message-ID:
 <SN6PR02MB41574989AE7DB1332F06C66DD4A52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-3-namjain@linux.microsoft.com>
 <SN6PR02MB41570E8FC664CAC4A05CAFA9D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <72ccf7d4-0fda-4f55-a47c-27486ef3e159@linux.microsoft.com>
In-Reply-To: <72ccf7d4-0fda-4f55-a47c-27486ef3e159@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8095:EE_
x-ms-office365-filtering-correlation-id: e9c48a58-ac75-4a13-666d-08defe0ae34a
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|13091999003|19110799012|8060799015|51005399006|15080799012|8062599012|31061999003|37011999003|25010399006|12121999013|40105399003|2607281247196008|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?HcnyrZkWI0vgyNPbyzyTKFSFyGb2i5okA/vIwNA2jKnd3bP85GObrLh/Ih?=
 =?iso-8859-2?Q?gul1+arQ3wOWO9M00mn2UvBaI9UCp12yGi5Z9NsQbFi4hj03Bn1GvOj7k4?=
 =?iso-8859-2?Q?uYmmgh82eU91zDi06nvqDEavOkAfzqDFzsrO88RS8YZu0rVkUOCTZeO+xZ?=
 =?iso-8859-2?Q?QDhj7csaIDe1aiJP7aus/ADXYxcZx5kwSxZOSzTM2QCgtnBLeHDnd3YXYb?=
 =?iso-8859-2?Q?YCi8y468htkNTBbtQ7YpTWMcVYn7l7HYVOVClEVO+/IdaT7qWOzNpqjyiS?=
 =?iso-8859-2?Q?MJxw4QPKvlQx8Zo9AcZ0tD2fyskKwUB2I9t98w0EOJFrN6/UWA5aCnsaAx?=
 =?iso-8859-2?Q?3+aoN+qN0N373eTk+DhzT2KdLHfxCp9Z3lBlXxUzzMCVksyBkEVAnbnVKq?=
 =?iso-8859-2?Q?3sINVavx38FiHxmN+0RpIPOWIdol6PBba/mc2vjnfMxYb5BZKTssoyotUH?=
 =?iso-8859-2?Q?gJNpv4FXnNKIV7yGQf8bdc/CmzrcJFVYU2JxrB+GlzswnMK524YkbugfNU?=
 =?iso-8859-2?Q?9iHBdD2gee/1KzLc94jF06h4x2EncqHUmG5WE8LBEd88Rnlt84PDKo39Vx?=
 =?iso-8859-2?Q?EI1Y6iEXxEzOR7tQBg4W1zuBasp/pNIi9hw2UtDTAhQkcJAJJ2mOAFD8PU?=
 =?iso-8859-2?Q?6V1F0GjpOjJJcnetUN3520dnx/NjwOafkzAe/5vxHPpG6oBhbK7JMEnpSa?=
 =?iso-8859-2?Q?azedasK5/V/AZ51L043apQmtruOyV0D26bJHlzerfecxN/PfNjc1km31Td?=
 =?iso-8859-2?Q?9hvO6DDe1YiCPqL9ymxRoEuLO/UkpZr6n92CIKrKXJn5WE+7MG5Pd/0CkG?=
 =?iso-8859-2?Q?t+ap3wI4/vlNCwKbtj3rAcIGkyYVkB6KJr1W8bSdD4gauIweJ4AYuI6sgL?=
 =?iso-8859-2?Q?YiSGwiU7mTGrbTsADPS7ti3qNM9M04M+Ui/gChDjTR63p+bM2JnZFI8iby?=
 =?iso-8859-2?Q?8OCB7yAZ2qJk4ICyOvLZRap9HCG+FvmyWIJlXpqNT3CJcet87+ht9RcUQ2?=
 =?iso-8859-2?Q?4/x1sWXwIPGjeabEyVxMW0MWJwH3Q5d1r9iSc8LjICa5kZw0G1d/HHS3An?=
 =?iso-8859-2?Q?5i5Ttq14mAsFVuqZKr2mo4mAuJ9MG1p9tSBqfaRqbTv+aunhL7LxTK2duS?=
 =?iso-8859-2?Q?YD1LXI9w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?s8tOggEDuziTeAdVNjzMjDIvqtD7Ul3BxttiVGZ3iLV21JPJhCusKtWx2O?=
 =?iso-8859-2?Q?yoe2R9iQzj9hekxNNqonQtnRlEojoYIsckltwnc/807+eWVARkmCHK98wj?=
 =?iso-8859-2?Q?RzuUruJGJcdxQnJD3bxjkh4ljXbXt1o8O0lFXN4A6qPtQKXjKP04KRte2z?=
 =?iso-8859-2?Q?VpXl9pELf29LcsdsVOO/0Oyl2bO5xQQhVSZcuX3qT0MldgoctOXXaDaiMB?=
 =?iso-8859-2?Q?i9BoBTkHXYk94Cd3wiZR0x8eCkOKgrAV6M/BSrSC/nHKTKn0W+zeZyyAUh?=
 =?iso-8859-2?Q?ChB7mBqs1FYQv6N/j95ES99YG+j7GuHYxsF7nO1qrdGOJHE1GzIfpFQpuN?=
 =?iso-8859-2?Q?e7j/LxWy9FRHrtOT6DDJTelz7XIJ+R3TM0CfJh0phOw8oxc7JZD7rn94cB?=
 =?iso-8859-2?Q?Ub72oOh/IAgcJICvNTjMrCIGSTvQlh+fXmuKO2o35i2MdL/rY9tglXunp6?=
 =?iso-8859-2?Q?+NXb6t/V4qL+F9JHHu/hPyP66TAKIPwvsrPlGzDya4mohlcpok2yz6JGed?=
 =?iso-8859-2?Q?k8HlLjDtDwuXn17g9qpotoak21Ln/iYgco/IMsY5BuGpTqJEF+6LXfPiYq?=
 =?iso-8859-2?Q?HZqrH+Q+0ktCK574raes7gBQJJupDFLWdLuLXB2XjfsH3AiL5WBr4ZsahO?=
 =?iso-8859-2?Q?ielu4bQ4B7dHJWZpC1tJtZebCDMZ7hCY6xJgW80hIBso+6DYehQPoR0fL4?=
 =?iso-8859-2?Q?mLEJi8XLHcJWSnWNdDWNQDvZUD/kwJPk9RS3g8O7fWXbig64mp7YR3GaSe?=
 =?iso-8859-2?Q?PGh5Zy+7Hoii/HkuQRa7ZKEY4Nk6698B+7Lqo+BN9AZhBhWgcDBzpEyo3q?=
 =?iso-8859-2?Q?gfcPSeQYYkfuuS2HTNGKAY4wOckfsmfYQyjPm7cBfLXSiw0rcYFXgmWY5P?=
 =?iso-8859-2?Q?N9JDcMdSZChb2vY4PN0NUNJNCcot0nHigACyES9Df7w77l+aPZSWIE+JKT?=
 =?iso-8859-2?Q?zIzq+KrTC6doAI99zNXLD4eh3Lh6b+rTzSjTzYyskgxAHhkpHN6bjR/hbB?=
 =?iso-8859-2?Q?FNutoqSwYrMgfc9EX0xc8TxaqGJiuVG4GPyXK/4GoLsxBJ2pwi7Pv6h5Q1?=
 =?iso-8859-2?Q?hwRq52XIUZhJvfJZOEZ1/7brWXlpnt+c0hIydFlkFgjEJQzEjMHqeKktc5?=
 =?iso-8859-2?Q?F/UAkEejQBBHWt5+kbUuoRIeOoTL9I1HF4PlwxF6jMdTF94sJ6/idJETlD?=
 =?iso-8859-2?Q?uYyeyz8WrH2Tv4zlwuFgJNaPGTp0GIb6ZzIERowetCMkj+9ZNbPyEPY5Ov?=
 =?iso-8859-2?Q?apmHQDLxE27LZIKoKgUjA1pobn3IeQyFAD4bO4canuyd0VY47teVXl8Wh0?=
 =?iso-8859-2?Q?VPucn5M2JF68Bg7+FqxTwaGt2U0NxD294b1azJf9V5YetsoaGLpV4zUIe0?=
 =?iso-8859-2?Q?TrfzHDVEauI8sWSKaJh/48BxUNVlJAuZfo+DGoyWB0C8C79L3vIqg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c48a58-ac75-4a13-666d-08defe0ae34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 15:59:44.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8095

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, August 18, 20=
26 12:31 AM
>=20
> On 8/18/2026 10:40 AM, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, August 10,=
 2026 2:07 AM

[snip]

> >
> > Sashiko pointed out that irq_chip_retrigger_hierarchy() doesn't check
> > the outermost domain -- it immediately goes the parent. In v1 of this p=
atch
> > series, you categorized this as a false positive. But I don't understan=
d
> > your explanation. Even if there aren't currently any outermost domains
> > with a custom retrigger function, there could be at some point in the
> > future. So it seems wrong to skip it. But maybe I'm missing something.
> > Could you elaborate on your reasoning?
> >
> > Michael
> >
>=20
> irq_chip_retrigger_hierarchy() deliberately skips the chip passed to it
> and begins with its parent, i.e. apic_retrigger_irq(). The new code was
> doing the same. However, if someone adds a custom .irq_retrigger, hoping
> that it would get executed, it would not.
>=20
> Sashiko's example was valid in principle, but it is not relevant to
> these device interrupts because desc->irq_data is the outer
> MSI/IOAPIC/Hyper-V chip. The LAPIC data is its parent, not the starting
> data. I found no device IRQ in this path whose descriptor starts
> directly at lapic_controller.
>=20
> I am all in for adding this as a fallback -
> +    if (chip->irq_retrigger)
> +        ret =3D chip->irq_retrigger(data);
> +    else
> +        ret =3D irq_chip_retrigger_hierarchy(data);
>=20
> This should solve this problem while still covering the chips which can
> forget to add a retrigger function.
>=20
> Please let me know if this looks good to you.

In principle, I think what you have is correct.  But there's a
problem in that irq_chip_retrigger_hierarchy() isn't defined
unless CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy.  try_retrigger()
is what you want, but it's static. You could add the #ifdef's here
like in try_retrigger(), but the same problem will occur in Patch 3
with msi_set_affinity(). Really need a non-static version of
try_retrigger(). Or maybe just doing the #ifdef's here and in
msi_set_affinity() is the simplest approach. I don't have a
strong opinion either way.  Sorry this is getting so messy ....

Michael
