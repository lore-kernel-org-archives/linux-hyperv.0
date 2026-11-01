Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793572867;
	b=IbNgm0qvqXxLyGVpqD5rTbDpN7ISjCmHQLxqzLaMQsOg1fiTKfOKFzjV9bHa0cq1bDrL
	 t38WThq77O1Ay5lK8h0YbKYLSMFcWJZSH00ltUVLOxR7kKC5fmqO0Kx7Yf7Y4UWEEi6UN
	 OX+t7hYawfNXlaH3c1AX+bUIKe3NiMLxt35S4+Q3xMc9p7w+tinmc8jQfBeQYnLAFk+89
	 rSJ2zligh7Wj7ehot7RK0kKP1pP8hTVu0wz7zXCzfdQeYDKYx8UpA59Nv7B9tL+INv14M
	 rYSEtZBE9uGGar4UKs/5BaRl7dc/XCSrX9cNqi+jdfGgpRX2+Jm9WWvb02lmTN/tJGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572867;
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
	bh=CkIFuBCRT5z30ZXvbH55l1JjMrh44ta/XGfVW8+GRG0=;
	b=UJ/VZK5lBre1pb4jULIf9+Eha8ibIpH6L5sxXJPUgWkQ/SOTFQuJuvdDFWsc3BJ1JbKs
	 iVMYj07N+YeAUzWfZl5RCaiuJ/IbQBlP9j5IlIylh3SgCmMhFqI43ls23Gwu7vV5U6uYk
	 85JpHdh0ZIuVgfN1KWhz9pp2ugtLtMHXjpqtx8lNPCu/jd9MZHmNKgu4w2lUeE09RWBmZ
	 Gj+QCSE3gpqvEOaJdhyVVIzBixkZe4w6sLJcBB5nZD9FfX+7iXlukMiykAqvJANXQ9+uZ
	 lMiEj5sZj6shIk+Bg6gsIznLBzQCasedWopmmvlQsZmg1cIKUwhHaR6WxJSETstqV0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=NWzKKPQj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.20
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010020.outbound.protection.outlook.com [52.103.23.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED64606A327;
	Sun,  1 Nov 2026 22:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED64606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=NWzKKPQj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ5PhQ8EMwph0A9BMmE5jNVq2RspSyPHnYw86NdlJheTFMa4U47wQK+XX59sioRMCpi1jKO4md04P/IQpj3F3RZ/iai1PztZot55ZRrWaqXpzw8mTBOC6A9NQIcr2bmxzo40FqzAp3FkRc95i6+aUoElIbmPteRtzHcMD1oC0/lzhO7422p0E82Z76ahhJcrXvFVCB/zAr/4ACFySDvgGZl4n0+MiYD3r1AxldvRaGVt9hZoR0idq8qsC2+tNSC/tR8p0Q0UmTKYGJURsw3E+zstoc/yJtopaBjbgdR66v4YSxAyE0I8sELxSA7lVFYhJBwHUnslHvh6zujof+LnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkIFuBCRT5z30ZXvbH55l1JjMrh44ta/XGfVW8+GRG0=;
 b=QFnP+MkSO4H9/YCj5ya8gDixCozXe/V27ETpy3CoteZJXOmpHnw7T/jg2p67oifWtDeQX9RW3tz4le7249iEqwOVbP00RiIRfvzLP6UD56cpB59gSfvja4JABr8KhiSQDaJWg5Mc1FxdyRmCbmraYX+XJR0jfX4CflrNyTnOWbyGsMTXQx6bWZRIMC0VM18AgFfELpUJnaiCAFW7//tR+/8B/+QzHNuenuVujSeQozzPufjuhqm1oZ4/ICxYS8H7r7RaiuxaYuF3rxvFVy7hfFQ2K744ir+LpvGeutlgJ+CLi3WAw88bxjTJE09Nc/LMdKAE5ZwUYh93hSM4fNnCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkIFuBCRT5z30ZXvbH55l1JjMrh44ta/XGfVW8+GRG0=;
 b=NWzKKPQjANYtqSQqB/sB1UFBFofm3fVxj1rZlQoyF83SWyOQzcTcwzxcHkfcZBdeinsx9ZpwR0+bKo4+De406/JM35iidXxyDTGDeH5eemMSMA4p3OX4wHjL7msHt16X1fNNolPxNmqiYrqDIwK5EtZfqFKY64AKtriGWA1fIx9goplacCVZ0JS3ThKkajLoBO9gji4IiDpMXUSYtrfxnhLTAhyLAy+McvS7rCByDdqjPax8tFKKe1416Lv0Dm5Bcx9Nsh5YL2aY3LpTJLXOSTirQWj/gNF/SyuKRMlKXQKF1spixlqhSJIB6J6jZ1idfdmF7+UXQ0KrNfHatHocMw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SA1PR02MB11338.namprd02.prod.outlook.com (2603:10b6:806:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 22:41:05 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 22:41:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "mdshahid03@gmail.com" <mdshahid03@gmail.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
CC: "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: use pointed-to type size for page table
 offsets
Thread-Topic: [PATCH] x86/hyperv: use pointed-to type size for page table
 offsets
Thread-Index: AQMEA58+vUfz9CyU12gsRpaliji9ybTMmnng
Date: Sun, 1 Nov 2026 22:41:05 +0000
Message-ID:
 <MN2PR02MB6863DEE71E0B43A5850ED6C1D46B2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261101082034.134583-1-mdshahid03@gmail.com>
In-Reply-To: <20261101082034.134583-1-mdshahid03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SA1PR02MB11338:EE_
x-ms-office365-filtering-correlation-id: a9d2b805-dfa6-490c-5272-08df386936c8
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|8022599003|8062599012|19110799012|37011999003|8060799015|55001999006|24021099003|13091999003|25010399006|102099032|440099028|4302099013|3412199025|1602099012|3071699003|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uW0h2KR7bDcIectj32ZIwFJNL6FkfVW/c2Dd0lt9CJwM85DjjKyMkmXP6cuI?=
 =?us-ascii?Q?btwrk8jqM2QN3ebToTt+1/B4Z/mlcjswdS7QpP8ElAMFJUe3raLheeqcmzNO?=
 =?us-ascii?Q?XuiLr04dMzJiHsvfduVzXOIKOQHCGwL8nEPFw4Ukk+TNXXO2wUu4mrPBXPEu?=
 =?us-ascii?Q?VDy3uJAQThBlhrHduKD0TQYaEi2Bp2kryoVD4uFpwj1rDXoRRKj1P2TF+cKK?=
 =?us-ascii?Q?Sh00emSGfc1+1CLvzXhXV1bwZWLCcpexMZhfnErlHbHwbXNWJdHXIrjwxgxQ?=
 =?us-ascii?Q?lYgouSnJF0rzU+1JNQfwI/pYvMR+T9K7mTqsdGkLW7JR8Dgsy9Xqa5E6w9rx?=
 =?us-ascii?Q?oKumf8ZFpNM+QL9aW/F9V361LaIHhmdr5JJFtWs6wbU4W4gD8754A2vkgIDS?=
 =?us-ascii?Q?8jirrAvNYZLZd77NdFV71p1K/rlbozBVRWBUospKz79hB3CwZT4tj+/xmrPO?=
 =?us-ascii?Q?TxWdnDNIOeZOCzIClHuEnADouvs1Jxm82TUWBX7/ISaVr0rCQ1Mp0msP49Q3?=
 =?us-ascii?Q?IIbVMPEyYpsa+7b9uAd7rrcUChHl9nZlH2f65UE9BZVWG6J+CToB/N9fExq/?=
 =?us-ascii?Q?rG7+4FaBDUYyV0Bcaz547BTaBPZaFyHGUVVoBcKurLDuyGQQp8VcWR5hSMvo?=
 =?us-ascii?Q?vyfVxAk4MNNmFB6UUt5H7gUomk+TqcB7Sv+26H6HPva6GRH/fAX1Yo0O0JBe?=
 =?us-ascii?Q?LHE7sUn9NG/jInYFm2tU2e7EuSledLVNJ3wPeL3TKU/FL7gSIrn2sRGseJrz?=
 =?us-ascii?Q?Z0A9IRY8h4JqyDDW+NyLe5KTtrrtVb5qUZq4uabXb7cBPTVIlN/qLTiDCQuV?=
 =?us-ascii?Q?9NOlNB96qFuMaSqiL3VqjWMfCKDk0ywoNurcvhy1bs+4kT6DFl0GQHJvc48u?=
 =?us-ascii?Q?Tm/LcZNtcvB2HL6xzMtQwaSJslOz2Et+nTLvn1nyyBMTjTQxwdecKfbSrSfF?=
 =?us-ascii?Q?6KyhgYP4ST5VXvh9XrvxmuPvhRvQ8c6bML0Itav2jSGv4qcrAwynCQ+08wIJ?=
 =?us-ascii?Q?j7gHn3KPQVImEA/+jUpomFRXcCJpQ0KshdxIaw2yRxqiCYBAKpXOiBcYwlcw?=
 =?us-ascii?Q?hUvMyyyN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cs+zljgr0v18jvUrtUJBSUIMkj5u7Qr/u+fEyjbSkh6j8Gsb2AXWhr3mg2VS?=
 =?us-ascii?Q?s9jzoSfvGIVcK7ihywB71CBTw86X/EgPyMslJzEI2gky/G4cidwDUiV0X+f4?=
 =?us-ascii?Q?LjGQw7kD4oHywt3OqJtVmjgokLVBus2mDduHlgeZGE1QYAe1T27QWS9AImc9?=
 =?us-ascii?Q?/e4nUwSWhbB994EkZoJx+NxxqyPSwQEds6VzgjiC5N1Vzp8aPS7qdjNrgZmv?=
 =?us-ascii?Q?QvI1vzH7K0vZ+SDDxsFN3uogIBImRjVXQVsrJlhfYAeR7vw/qdQECfIR3bCR?=
 =?us-ascii?Q?xzcHH2YJqMQWoggHUEu3AGj3jZp93FWJovIsa+h8CMqzTUHlCuLVPnetobD3?=
 =?us-ascii?Q?9pmBBEBuNZguaP1Fman7+5SrWGxysPK+kyNR+Fd5qOZ4Q/cmRF1ro5YvwBTV?=
 =?us-ascii?Q?Ss0DRMdJ2PG5jEChVD8woRgm2wwt0IjSsjWknDov5/fk/DClvsRHEUG7Qrzm?=
 =?us-ascii?Q?dEa7xWuL8EfQcmRYx9Jvet0ml6BJXAcALJPDaKv2x9uD6LrwxsGlxjfptJnj?=
 =?us-ascii?Q?cg1x9MiXNVGsiMTQp9l/1LfDo+wMONg1KwJ360KAK5ukP9XeaOdzljD67cc9?=
 =?us-ascii?Q?+CIRlzWHVdbS3uWmYNc+CLvBsTuc2u/ludhfSiiv6MU+VxjS1cTRrDq39vUf?=
 =?us-ascii?Q?EoEfsQHnE2TnGsHgI9oH9JQN29sM8C+l5VIodDQyV+NA0dMz/Bgsh1NWpRa3?=
 =?us-ascii?Q?377OjjugQ0d78aLmP/B+ww1lXJjwFxFI16cI/Zm+xboIf4QXpGEavRYDkqcD?=
 =?us-ascii?Q?NQNlyWBSDuhl9iOuzUbONeLy5/VIFG8EX6q+FX1AHN20eTYow4CP5Wva7y4v?=
 =?us-ascii?Q?L/21+EaqlWRpVgnZMA4V2Z3KjJO3IGLMfYpJ1BF86KuLMCuBNcimHN7Nomoj?=
 =?us-ascii?Q?RgQkfLzyUCx9JVA+WZlMnTYrttqqtVnGfzSgLM4Gvnsz71oLNxWcUNg2glLH?=
 =?us-ascii?Q?fDx14g789C73Wkt4KKz1u46nV49iE7zhfGEAA14RnoCzfQqJHkIlcVsUuUjs?=
 =?us-ascii?Q?GQX7iNwXuhIXYF+d4EYfwNsg62P/5/UsEDIkyMForoyakfU0XgQ/FGSsukUA?=
 =?us-ascii?Q?PIknVq0SaI1hw17OKanODXEA8HfdKBSxZIiwCG+xS5+YUj84ksGfA8yvKIGX?=
 =?us-ascii?Q?19IwlQGfKR/+qhBEFzFeGauyxKfWa8PwTvFF1dvaxzvVIuiydVsByKR9f+hU?=
 =?us-ascii?Q?HXgx9Vb0RYu2Pwn+tQsr72hATKSPGRHC9dP56FwDfeJ79zg5uziEvWzyyIed?=
 =?us-ascii?Q?cb+Y8VfWaCImMOPEhUjqqc1OeNnTAzNFQcLCkbNTFNKlDIbd2g7gZXUg0doU?=
 =?us-ascii?Q?F9TXsAJZCb3GwQXuibZRgKmwT/V2v3HI087jFaKoFnd8Qc0uFlZb8IobKYyz?=
 =?us-ascii?Q?HWbQGY0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d2b805-dfa6-490c-5272-08df386936c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2026 22:41:05.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11338

From: mdshahid03@gmail.com <mdshahid03@gmail.com> Sent: Sunday, November 1,=
 2026 1:21 AM
>=20
> The Hyper-V crash trampoline code calculated page table entry
> offsets using sizeof() on pointer variables.
>=20
> Use sizeof(*ptr) instead to calculates the size of the
> pointed-to page table entry.
>=20
> This makes entry size explicit and avoids relying on the
> pointer size matching the page table entry size.
>=20
> This issue was reported by Coccinelle script noderef.cocci.

FWIW, this issue was also reported by the kernel test robot.
See [1] & [2]. So you should probably add "Reported-by:" and
"Closes: " tags for those reports.

In any case, the fix looks good to me.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

[1] https://lore.kernel.org/lkml/202603101143.qUL1R1iy-lkp@intel.com/
[2] https://lore.kernel.org/lkml/202610080503.ivDF5iYX-lkp@intel.com/

>=20
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  arch/x86/hyperv/hv_crash.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index 5ffcc23255de..810eb1a4a0a2 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -512,20 +512,20 @@ static void hv_crash_build_tramp_pt(void)
>  	pte_t *pte;
>  	u64 pa, addr =3D trampoline_pa;
>=20
> -	p4d =3D hv_crash_ptpgs[0] + pgd_index(addr) * sizeof(p4d);
> +	p4d =3D hv_crash_ptpgs[0] + pgd_index(addr) * sizeof(*p4d);
>  	pa =3D virt_to_phys(hv_crash_ptpgs[1]);
>  	set_p4d(p4d, __p4d(_PAGE_TABLE | pa));
>  	p4d->p4d &=3D ~(_PAGE_NX);	/* enable execute */
>=20
> -	pud =3D hv_crash_ptpgs[1] + pud_index(addr) * sizeof(pud);
> +	pud =3D hv_crash_ptpgs[1] + pud_index(addr) * sizeof(*pud);
>  	pa =3D virt_to_phys(hv_crash_ptpgs[2]);
>  	set_pud(pud, __pud(_PAGE_TABLE | pa));
>=20
> -	pmd =3D hv_crash_ptpgs[2] + pmd_index(addr) * sizeof(pmd);
> +	pmd =3D hv_crash_ptpgs[2] + pmd_index(addr) * sizeof(*pmd);
>  	pa =3D virt_to_phys(hv_crash_ptpgs[3]);
>  	set_pmd(pmd, __pmd(_PAGE_TABLE | pa));
>=20
> -	pte =3D hv_crash_ptpgs[3] + pte_index(addr) * sizeof(pte);
> +	pte =3D hv_crash_ptpgs[3] + pte_index(addr) * sizeof(*pte);
>  	set_pte(pte, pfn_pte(addr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
>  }
>=20
> --
> 2.43.0
>=20

