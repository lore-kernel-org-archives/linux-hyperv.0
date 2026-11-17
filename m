Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794891214;
	b=lflX6wCCePpYGelBFcW6DKGYX2JYAxZx51jHK0d6GSPJkAQ9rspfkzBX2WC9Wc1CF9wv
	 3tBS32WIImm0a89qp5VFxWaYqunrKbhI0FkP87v4tGVDmQcGWWkR+Jxk0tiaUWQeuab5w
	 DoVUoBQ8cUyUiWWZumZQK6XqdX5muQToCXNOHFFSVKdCMBXd4ClsdUlQ488V9/QQgbLZ4
	 isW9+Im5GmDxm+KMuK3jtpJlr4wKnBsg4v3XfwtCtjrr/Wm51NamU41uVC8DRwD8JcllJ
	 6vtLefdGjPM8fDGwVADN/6OMNKLQ957OUh6OJLtWVLalrf41j8zrM72FgR0YAcotY0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891214;
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
	bh=FV3a3FiGuKVLt+jcBuORGdmveT/Wy5/PVVDg4GQEXsM=;
	b=e+/dJgxXssGz+8cVBcKWFDz7Ik6XBtjKYIXqeY/AT5rW2KZJIheyABNuyonayqpnOJYz
	 xw45V+8WitlitipWxxlLkUUqvKtaB0obl9kAfapc/VEvcXNBf0fqLl7XB9BXK9kqybFEg
	 cepX9l3n1+U1TpebUcF/xoEtRh2Sxm09Bv1Y+o6Gw1hmagGoKwOy37gUUFXwAJ9Pxwp7Q
	 fIS4Gh9ParKEyabefrcqCN28JfPbMUR6qEkhR6Sk+R3NO+stiVrv+jYfWJPKj7M+Qposw
	 hJINzN1nYTB3czDSiQmHFwGPmqEER+ZeqUjQOOCfKiCQCuyczvcXhTxXe3GwkVDs3bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=kUhTW1Oj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.0
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010000.outbound.protection.outlook.com [52.103.20.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A5606A31C;
	Tue, 17 Nov 2026 04:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 079A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=kUhTW1Oj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR/Mhdam0C/WrkPntxMU2xk9tn7J0h7cb4+TPvnkKy7J57QNeSeQC8Vi0OzWTiXajCwiFekajJzwZVPVnR1cEaFOHT2Zrw9g9PTd0AtuDwsKJpAPgqvAC5NMivjI04tjWTsoNSauNsGegBzMAWZ5BqDle7hC3mpIGQNmJ/ciACfMH/O68BFO+EPlXO+DeNvckbKN+dOEUedzz5Yt9RkJUvMGRTk1go8mWCSFDpOkH2ttmb9/iX1KsbjBjuCkcTH0j6Nujxi7atDhvhAS/wFor6cKASUB5E6MDOfROg1GjgPe30jYJldSXNh+IiNNqUgVAVyCyPrSE6IkMJZ7Qm+DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV3a3FiGuKVLt+jcBuORGdmveT/Wy5/PVVDg4GQEXsM=;
 b=WlGqSSwx//4cq1n9tZ0Sfpln1Gwr6J82iQ0OHObKx7yBhZkpAzfdyTZWKhND4Dbru6ifeXZrJRlgEpl8eyzJ1vWTKhA6+YAZB5IxT6q7MyDXJC5ZOCqUiFWZ5pZNhj4EuovyJEs0y69GyscOti/7Q1+QTtD9X3Tue254aTUGHXwPt1yTqNbkjRk0F88CKXq/dckVtRq++or0E8cQ7c57Ikm/8ag98PiUnoUEI0v3J2y8icOz+t8w+Y2DM8N5dPlMINn4hH3yE7Mrp1OKmYwGHcIEFAQoM4dws3pHddfN3UH9uTfO89wJGBuyMH6sxT1C9KkSqdybRhMA20vpsl1+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV3a3FiGuKVLt+jcBuORGdmveT/Wy5/PVVDg4GQEXsM=;
 b=kUhTW1OjAV55hiX7tBYdY870DXa/2+6YVvYdqNyac+46TTHH+LOipMC/+xzoPI0+BqJoW64dQGisf55I3+zJNXBl+M10bGjk7idzUHw7PslCmfMC34LkFLftbKfUoFsBQ513gsIAXSVbZurPz/ac2RytTxo4ktQ2uGa0l/H6l4pGsinrqcBGIrcPKoOeK9J1yiC3dohWX0ccOPzNZQnNhd7oIfPKJ8gkWB4517OMhEKilhXqI4pU9p8BTOgD2UlkB3MMk5JAuSwFw92cR7GsIDhzxT6Z+zsWYupIoK8lSW3TRmvxU4y9jeWK5mN23xFAiddZX8i1DVsv6yQBTbDulg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DM6PR02MB147411.namprd02.prod.outlook.com (2603:10b6:5:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 04:52:59 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 04:52:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Juergen Gross <jgross@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, kernel test
 robot <lkp@intel.com>
Subject: RE: [PATCH v6 05/17] x86/hyperv: Switch from __rdmsr() to
 native_rdmsrq()
Thread-Topic: [PATCH v6 05/17] x86/hyperv: Switch from __rdmsr() to
 native_rdmsrq()
Thread-Index: AQJWRMBMhEWrzhqQoRQ/70yarwqelgJSsf+Fti15aIA=
Date: Tue, 17 Nov 2026 04:52:59 +0000
Message-ID:
 <MN2PR02MB6863FE0AD51ED3BC3614138BD47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261116183905.1591611-1-jgross@suse.com>
 <20261116183905.1591611-6-jgross@suse.com>
In-Reply-To: <20261116183905.1591611-6-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DM6PR02MB147411:EE_
x-ms-office365-filtering-correlation-id: 46bc1558-4590-40c3-6bab-08df4466a776
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|51005399006|19110799012|15080799012|37011999003|13091999003|55001999006|24021099003|31061999003|25010399006|10035399007|1602099012|12091999003|40105399003|102099032|3412199025|440099028|4302099013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/pM4NYKvFfG5PZSZlVAWNEhp89VJtFG3cyYDkvbvgoOvXbMm/nQqp3pb6fxE?=
 =?us-ascii?Q?SeGy9QJLUSIIAMq3gi02t6NSG0YV/VDmsL3GHB1wpFwhJAH64oFUoDVhztMp?=
 =?us-ascii?Q?3043mANhvRkxXtJpSdkYXyt7SC038HelkguEm0Z2bMhvQ0dEXW1FVJ+vt/Dy?=
 =?us-ascii?Q?2q1mQ2xKn37yP0mjef3WdclBcG+3Cy2G0Pahardk54ybqbS7ptEYq1h3vPgQ?=
 =?us-ascii?Q?b7bZn9t1OR/+yXd9Y8EwMJ78IpTAIinhDa7oW6D0rA8XEV/rwCAv+kijwAJd?=
 =?us-ascii?Q?Oze9w/Pk3BGbZZPbss5iFuswGyNDpwl8XvNL2zoDbgsdauDd3dP802ZtsKgE?=
 =?us-ascii?Q?XhJNA+oMnzeMICmxJmxHP2a25YlG0MCAY63/a3hLpyfDnQ9GSfr/Sc2gSZT9?=
 =?us-ascii?Q?0d4wqTqTjoScioiOQYywrSytog4CtCv5u+yi9UIXU7140JhtyTxMMwEejGMg?=
 =?us-ascii?Q?riOO/jzHLnL8tctfMn4MLsIzZgj+K+RHLIEMBJhnRUZns7G0zaM8Pw+X4nIb?=
 =?us-ascii?Q?Ap6y0ROPBOFpYaAAZBxbF3OeauoiTQGKlozChv4+CJNgoBG91x205QdbJAt2?=
 =?us-ascii?Q?mTtDznFE5hbIXucBtsMDr3Kj6lfm8jt4IZJ6G/Jfi67D2kgIm5iGwhiYRxet?=
 =?us-ascii?Q?kfx1Kh/UbzMvkQ9vy60wPRqGL/Ec3OFG9c8L63cknuZuKpUjJs3zdhS8C6cR?=
 =?us-ascii?Q?hE0vgSWGXw/sBRqQRI1AVs8DrKLotHYeSR2gJDI6/i+sAJUDHC3PMy6U3H4P?=
 =?us-ascii?Q?Na8K5/X2AbN33RBDvuOFwFYdE6Z7flZIpEkGD12416UB2H4qUBEmvqqEZOip?=
 =?us-ascii?Q?hdoYhvd+cWCpYFFJuUQwVOk8syItDHlzjLR/omv7lwmQRNbXu4I6aboK3h8Z?=
 =?us-ascii?Q?amtn8N1h1LTMNaqoD1NAPrM8DXYZYiLYvkobvtlN9Z7OIvdB/9yQYKHNVwQk?=
 =?us-ascii?Q?Up9PAnycBrweEXtS/QWeX+t+OvQu3nwKnpU2QJTMOTYn2PSOjQq7/RXlXAr2?=
 =?us-ascii?Q?Puyx8cYBDEZ//I3uAPLs+tp7nD2orTSP+CrhVbtv0LyWmrMFqeN76WQrgpiz?=
 =?us-ascii?Q?02ER/v0UJmPSBZwMBLhvbnk4AyJuhzg8TcaGhVbJd7eHn12TV4U=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nqUq+KOz3aPnWhdP1It7G3WWyHGefthblxqAvhOKzNVCQjazmHa7ejamWrLs?=
 =?us-ascii?Q?cz3PozmhhoSQTdvjP7xsjnoSU5tyFmtWvcp3cwZxYljYNOuSNWzQ2Xh/V/hM?=
 =?us-ascii?Q?b/gizEt50j6Ugd9q+sF1Pqr+m562AakPECYIrWu5z27cAL0WaDRFcm5TJGT/?=
 =?us-ascii?Q?fL6frZRZMBOoDRMGrcoTKowY9tiH8sTwQVRhWnZ6Tbn12wy6zS2SCXTcj4uN?=
 =?us-ascii?Q?+B3qBoWuVslAINza7vm2xv/BpVpr5WiEFYeYwzOaQDwV50yYIIiuaVQh9j7I?=
 =?us-ascii?Q?wJ2XEh9cN/BSsFvP0YNSDT76+oucX7NekK7ePk9qr0Uma88o1UVmCaBo2fip?=
 =?us-ascii?Q?sW61Gis2VZIDaAqTSww+o7//CiIj4+i1iRAIX1APdg15ISwihjdwSvyau6vG?=
 =?us-ascii?Q?EEOnKn47Rzg/NYleAllfU8hKjew9MBMR11ZV/eiHs1/lFtAMz4/1VrC7joYw?=
 =?us-ascii?Q?HU91R5rU6EYAeesrNIrkjBYMIaxkOBboIkKGEOVoCPJr0PoeMvxMfghwD4Rb?=
 =?us-ascii?Q?vnokuDmcd+wokInAprfCsTIANYQpGRImNg+exDujhc0yT/SEqM0QC+4oZBtx?=
 =?us-ascii?Q?GdJW/lqxM/iXYL++ZXf97RjzHGvod8V/GHQu+g70uPo9otIgZOxbJyQunoRB?=
 =?us-ascii?Q?a23iu/E6w8t4UNKsvoU3VMQDiww1053uQM2CZBq5IX5Lg5PUpxzDinEmxsVB?=
 =?us-ascii?Q?n1tmyvfaV9Batdqc2AlLTQ02k4XEfhvptICHYCesCGYpX8NnM8BYLC0BkVwG?=
 =?us-ascii?Q?tw+/Enbn70tzZCDI0v3dtpJD14dFVAlnTbYZ0LgVbmpERqsIvXnWhvMgQZNP?=
 =?us-ascii?Q?S64liaaoMykcb7UI2/nUMvyx8wB/A6TreQgNKsdAH6pFUPjvxASuDTxQcPIC?=
 =?us-ascii?Q?i6imnk3+LLrHAsoCKL4whswGDSoFIm+9jEbwHG9SXvVyBDoTon3wsC2EjhwV?=
 =?us-ascii?Q?iCmKwsPT54MwALh2VITAxsyu9KwXwC6KWFiDuDEINeOlp/wJCP4oLZ4k4cY5?=
 =?us-ascii?Q?Dg9otKzfAXkX+bWcRWKLWdNmttjSkzaiWhCbFdutyqH23lVHYsLh1lIV0gWP?=
 =?us-ascii?Q?q0FeVucwj/9g7xwvXGaZaIzkJWx+n56bBYDYJGTZP/3b+AZed6GyNwy0PNOt?=
 =?us-ascii?Q?cvzPlFvZyvQVu9PDMXNWJ5IwkroMjNqEAts5SlVI79epDfWyQwZZ1D5f0+n5?=
 =?us-ascii?Q?BRRM4XmEcLNxO+op4kBLMMVV5VFdzDZOT0GV2cloP0ob9LT4hZc9Ggqus4AL?=
 =?us-ascii?Q?PIgQkN2wCwUT405Kjr72SNeVuMCuSxDR5IHqmi3EyLrKtt4nravR8uF62ssV?=
 =?us-ascii?Q?sImk0nQEfB09mZA6ozI9eWUGy1GGEaIUJi/xBVkglN7aB9YwhqAtnDLkb7hZ?=
 =?us-ascii?Q?eyM+7wo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bc1558-4590-40c3-6bab-08df4466a776
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 04:52:59.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB147411

From: Juergen Gross <jgross@suse.com> Sent: Monday, November 16, 2026 10:39=
 AM
>=20
> The __rdmsr() helper will be changed soon, so don't use it directly
> outside of msr.h. Switch to native_rdmsrq() in HyperV related code.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602182222.WEBLSQRj-
> lkp@intel.com/
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V4:
> - new patch (kernel test robot)
> ---
>  arch/x86/hyperv/hv_crash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index 5ffcc23255de..28ee76e18d9b 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -217,9 +217,9 @@ static void hv_hvcrash_ctxt_save(void)
>  	native_store_gdt(&ctxt->gdtr);
>  	store_idt(&ctxt->idtr);
>=20
> -	ctxt->gsbase =3D __rdmsr(MSR_GS_BASE);
> -	ctxt->efer =3D __rdmsr(MSR_EFER);
> -	ctxt->pat =3D __rdmsr(MSR_IA32_CR_PAT);
> +	ctxt->gsbase =3D native_rdmsrq(MSR_GS_BASE);
> +	ctxt->efer =3D native_rdmsrq(MSR_EFER);
> +	ctxt->pat =3D native_rdmsrq(MSR_IA32_CR_PAT);
>  }
>=20
>  /* Add trampoline page to the kernel pagetable for transition to kernel =
PT */
> --
> 2.56.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

