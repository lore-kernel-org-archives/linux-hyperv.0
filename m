Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011071.outbound.protection.outlook.com [52.103.23.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE5218ADD;
	Fri,  4 Sep 2026 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534831; cv=fail; b=C2/M1kTUSNCfLh/r0gz+X8Bj2Bhh8zJKmLSHAjd1tXg36VEWCsiOh/t+DtYWYaFQgyCVm0l1mFTc4iuzIVsNPjj2QzAVaoRciyxcxhRLkuT+bXndbDPd9rqisux5+I+UtUD91p+PQXOtrM08ojTr/QIN6C7w6Z02TObxQOxRMgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534831; c=relaxed/simple;
	bh=qpAOkGwSWJlhBR9tprkwD4BRcvm6OxsuEpUWV3zrh9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gf3s7tr8F4w12nRVe3DdxsDW5uWBBEevN6b9nRnrZ7vnOo2C0SjBcrx4clMYAbPGhXJ2+GOSUiMJrgt0Tt8HvXW/7kG88e6saOoo3fId3o1mgp/xBzifp9cpVkzUiBrWO7+PEkR8E0eSrLXaWdfqzm11FE0PYLRryCgaYQuiDdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qsvyFE3Q; arc=fail smtp.client-ip=52.103.23.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qsvyFE3Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpZWPnnhVuV47+oHmdM1sjB7PQMm2EWS1QcoluaOwZ+ukp+lznttEdbRsZkCht6nv1XpKtiK4LOlp10KKfp48dT8WrRc0WV53FLYHMFOIcwaOO0zlFaXBBAYg9cZCrJBLVqXICBMimo44Ma12gimuHR7aPX7OvStsT2MFLyV+moN/Lk+w9MXmE7XCu9GVrMIS6wXkK32i9hE7Kjd8Nd67IlPecF6/+xQY0rQZZJaKbfyrM0NS8//H0V2wuxEyc4wD1vBlHqTkvFzi5Uir231ykIsqVF4LwE0CPAX85Nr8WZ9x5rT3bh50Fo6i6KJO9z6G9LkUY9SScZz0Z0PbLYk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP/bLF837Tt9L4KvwvVbxJC6+3jMw49YLnQ6kJdaoG4=;
 b=JoIf+lvGGPt+8ISXSxuwjcDvut/fdAs7T9UdadAqpRLSk8BentjkAJCoE6qJVno1AyDRcIAzqnqzd9WEGMObWXIGojd+u4jv4uczk8M6t0SiynHOpPgHFraYanPN1n82hTSnFrUrY0fdB/x6fbKSDTjQI9Z62pQlvHVbUK9staBTlRjkxs1n+JgD381LXBjtwz3TakRSecrYaqCNKNZMmMPeVKbUFf7gPTeUm6GSHahSmoUYX0Zvfwdpc/ORlul1BJlHAbA4xe0kacrXmN0PD9A7MhmbPL4d9PHksJpqX/Hr4jzW57jyfNLaCdaRzQDBhLwJuJWrQU7hL1yJHek3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP/bLF837Tt9L4KvwvVbxJC6+3jMw49YLnQ6kJdaoG4=;
 b=qsvyFE3QJ5VGTZgk1laeixos2pUvdtwaB7YLUjGcxl1VsYjYYKST9V0a7QlBVe7DGMTJHP9V1+wObe6tSV3Pmal+Gn0w4ErSAu3zQrllHEUKFqxq+q0npS0hEaVduCQ3p+uMzNe/oAWiKfl9et2cPgpcRB9DlCJ9z0dVXLaYzZK3xDHeURH/gEsxX6bzWUVBkVbVAneV0v9LeyGLoU/8kOR91sYQO3z7uAT+Zg9nCdby0r2PzSrbFxM0jGSS7C74EjS4S3VPPE4lJjIUWhwnRCPUxvEuXuC4+MNY/iZWu0JjWkRlA82xrCVl388d0uCXS99/M2YKM9NAfefjqVip1g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7574.namprd02.prod.outlook.com (2603:10b6:510:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:13:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:13:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/2] hv: fix typo "substract" in comment
Thread-Topic: [PATCH 1/2] hv: fix typo "substract" in comment
Thread-Index: AQFJ4/2fTj1rVCOYFMYKHTCfqVGwRwFv0klit9m37LA=
Date: Fri, 4 Sep 2026 15:13:48 +0000
Message-ID:
 <SN6PR02MB4157035F26D27C5F18A46266D4B52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260904120857.20431-1-hemanth.selam@gmail.com>
 <20260904120857.20431-2-hemanth.selam@gmail.com>
In-Reply-To: <20260904120857.20431-2-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7574:EE_
x-ms-office365-filtering-correlation-id: afc40cfa-a830-48f7-9828-08df0a971eee
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7d+C7J/MAe2pPMXNhqps5RROBkkgXPDOgKemmr2z/N+Bs9BBEbF4F1X++IH0NljIt54HPv5DLRUV920KnDqu/9wdfsuyJceptG/xYCvfbGbpXCU3XKYzmav5SVm8L9IPtlQuVN7oX6B2w6kpxegzwxmizaYRp+xXC0RPL7KcNuqXkrcjX/1wxApJGiWRbikF7AsdloNUBXE2DYWTFc4qeWVBPqwtgqN2rUOsn5pVqhizBCWz9a71QWKJ5cxo8RIHXKrZFCFJW1BgBBgAj4OFoMFS8iq5cZzjwB1c2nF4+om/RYm0U+OeNmC6khhvFcuKzTbTUSypQq+jq6N0xhHxPy4qlFmPZbMpv1XTW3mOAswbpVfixFpiltSHL5Pea5l9EBsB/+kjjoteEexIEzxJajisnR/6KSq52HNFhqWkQ8hFR8aU47ZnP/tldlGYs1iejt+4wpVDZQEfX/lJTVdfvjqfK6CbCU0HnwLe/7DKz5trKV4WJRnDBkvJ77CqWwhSGR473TY4sg5B1TduptAZUj8sWBHa6nsL9VIhYinVgLIkaLKjUQCk4JtjSVc0mtb40riZ0vszjUCeOO+VZyYTZuPPvE4Hz3j5b4ZJl1tgzZWs24GOY6iFnuCKQ66e/PB70hIB5A1VsRipOUuUoQ2oPRYn/gMHq+PaOj/2ZOUavsaTbLG2rgFxLH6HPif+zPGoichvGt0ZVS7liWCkT6raRA75nZNFP0CzvvjqI0yaSk4g=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|24021099003|55001999006|4140399003|25010399006|8062599012|8060799015|19110799012|37011999003|15080799012|13091999003|31061999003|51005399006|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tCvceB0pPBSaZAW9tKDRixf4mqqWXQ6I4clrDUfeoIC/ad7fd39igTMzN+Ug?=
 =?us-ascii?Q?JTmdgznDCxQdZ4gkmV3XtF4rehnB5BYXEmFz32UCvtDd2IcvMjDvBcIZc27n?=
 =?us-ascii?Q?P8aL8ujCbCAsW0ZUQoJ4YWXVN8WbfIslLYylAtc3JXtIcqyQ5qL1bZiVt0pn?=
 =?us-ascii?Q?sxNu8lZnrVE1PqcneC0Ag8m8omGJMQyLfyF6aFgm3UeBk7dVKPrK0yl2sZn5?=
 =?us-ascii?Q?Gtie+f6lAavh0yEUN4qya1gJ87oIJPtmibR9nngJ8wkA8GmmBT7qWV3DeU1l?=
 =?us-ascii?Q?DnkMnZpF/kAeTIPbIJqOqil3TgxIhCM710FWZnVtYJlh7NkYk+4Pxk5Yhtev?=
 =?us-ascii?Q?DDXE++XyLBdAZZFn+XxVjCBamUTCqkWap5/AYiYC3E1BhjYrPU9E0DsRJVR6?=
 =?us-ascii?Q?uOBgXswGfKRxURilAUBspdDB6PpW4iW0G8u7dXdT0JaFbSz9GvjZO4eDrk2R?=
 =?us-ascii?Q?6EaGcSJtXo/L9w31T6j1BhQ6RBZl3gLHgrYg9ccbtFWnv3AD2tPa0mu+j5nD?=
 =?us-ascii?Q?DyEJKvOc07DuTjNi4YSQlQSB/6RkW2drdpSxJuv2pwJELpPOUqJSfqrnendw?=
 =?us-ascii?Q?Sv+z2mIvQo9pg+6/5Jtn7u3hdxvWmLSzBA2ByOVP9MsNC6TP1Z1RBx4wGsGa?=
 =?us-ascii?Q?gs+ie6QtTvLMghAq4SRJzh2ArCtU7Y+aiqNK9Np/BQi0DoOcWKaJNn/p6WQ/?=
 =?us-ascii?Q?dk8DkA45HFdshfa+nedyGbjBppR1tZ5NCyAh9BZNcGcFEWL2mK5PImlBXlJS?=
 =?us-ascii?Q?xfHWROND/jLjuWCNNs35V0MOyu03KFJhgYrIThgGDum8DQasPmBFMPV0m4kn?=
 =?us-ascii?Q?gU+RP6J0FyJSZuUp65UFYzQG+FtWMJUJecXN4z51HBetINtAYSWGkMUmGDkX?=
 =?us-ascii?Q?KMv4feQvz+sKSMyx+22geAQo+6sCEzLrsU/Wjl2D/Aph0luMx5mytclEKBnc?=
 =?us-ascii?Q?GigUFDV+z1R0pf+xXb2qc0pvBl8k3JylaKQd2DOvAW8Keg2RPiYakd6Av0mf?=
 =?us-ascii?Q?lKHSSiGACYsIZxtjBWjYlTESJxLmzZ1lZCRdooByeoBvgsON+xCGz47zJHQR?=
 =?us-ascii?Q?92iWbQWH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZkKjqDZqGH3nFLpBAsT5SJK2x/NiN1WlVPlzcc2r6miupStGAYciPZxLQzrP?=
 =?us-ascii?Q?6buWcS4gYAzsfHmc8KS/ejtnqSFA44o+Q5ttpkBxGRSoNAAYEpl/2hwbDDmh?=
 =?us-ascii?Q?kk6TFYyJYWhALIPlM2Vc9bdaoXiJ3ZPYqxWFkHjXTkruBaymG1Xbu9KZVm0R?=
 =?us-ascii?Q?X2Qpt51Axj4gfvKYH+4ZS5uJAyhh/LVTvzYau83vH1mOK0t+rL8w0uXM1LXr?=
 =?us-ascii?Q?t76cF1m8Fu/F3E2ky8+BBjL2jmm7s0YTLJJ5wEaBS40v/QTCPlCf3LVihw5K?=
 =?us-ascii?Q?BaDNLkDrFHoWAbu2f7XJzwzaTatwKTShLmthFytc4qRa7Arxt1LZBKGoY5Eu?=
 =?us-ascii?Q?1mu5wRsWF/fYK0C94omL6amYeb7yUPRsRofvbpn9T1g3oEa+louLjC6bL5Gc?=
 =?us-ascii?Q?8pb891ys9palYinahs2D8pwgBkxfkbKHJjRQNB9vnGOMytX4hhDrR6Yw2TqK?=
 =?us-ascii?Q?LC0pIcb/cdKKR1w5F+11CEqfJGN3kOaIglzoKSkvOar5pF6FYU1dVAPVyL67?=
 =?us-ascii?Q?cJYdgyMmeLOg4hWSP26sbna83asd0TxjOYyELGBT0ix6imxUcvyCu3h+3LyS?=
 =?us-ascii?Q?3Dv57sj4wqrxkjeZ8P9KTCfDLpCWiDraISd9suRsylldRaWkf4fdMR5BfaTG?=
 =?us-ascii?Q?mjbY1aGaxRtuqH/ncILGYcJV9ZQofz20uxiFuKDHbfRowM+sJHzFSNqABsHy?=
 =?us-ascii?Q?ocxv5kAAO0hiXgtEC/pIEFpqAx7jcA6iWjfGWUQmZET++vQXtmx8JEMnmDJA?=
 =?us-ascii?Q?3R/yieIN5L3AF5rSyYsXt3R0BO7F3A/Jmn1vnW8kZGCUNdgpgE4+sFy//a8P?=
 =?us-ascii?Q?J5A4vbzn2SG2r5AN/LLla6xNnpXx1OM0rIyna3I+BJ4jt8gAg1iSSXTsCrMk?=
 =?us-ascii?Q?+Kr5r1Mxs+LJLPuxOA4d/1u/gDyZ2twBnLilrbb0LA5uwuGhtttoNlBg6ZKt?=
 =?us-ascii?Q?qOqQ50gTKzn9nRxvMpxrBtJ+sw9ETaQLxPCbPguUuwruQIkfo8L8AFD6s7kw?=
 =?us-ascii?Q?xM92w/C8lQzyADzyUIFM7zgKUCA5kOWiksg66yPmQM2M8qM91StnUAlshfmN?=
 =?us-ascii?Q?Ujpy2J+fhWkfunvaiWsUoxhXWOVZvQ7Z4xbJPCiogUDu5i6ArYImjru0H+A3?=
 =?us-ascii?Q?q7lOD1Fw8CmBlpdsCeVGadzDVMPog2ZPuRWO+PkZkyhMb8Mu26uFhT8FuzEM?=
 =?us-ascii?Q?5hbjiXaBZxg1dimyaKyzBZ+d6iUaqsoG3Qzw3xtkCt+m+gedZfmKnxzJh8dd?=
 =?us-ascii?Q?5aQLyGrfXH4KZzOpLfw9Xdao/xCzckmBhD+cIORSSr+JpTyed3S5F0RDptEb?=
 =?us-ascii?Q?frwMyFcHQICTXrEFkGm70f5oM+605oIrMllI3iIB4hW54rTZGhNd5/qFAg7S?=
 =?us-ascii?Q?5qQZaFo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: afc40cfa-a830-48f7-9828-08df0a971eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 15:13:48.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7574

From: Hemanth Selam <hemanth.selam@gmail.com> Sent: Friday, September 4, 20=
26 5:09 AM
>=20

Nit: For the "Subject" prefix of this patch, instead of "hv:", use
"Drivers: hv: vmbus:".  This is for historical consistency.

Modulo the nit,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> Correct "substract" to "subtract", reported by scripts/checkpatch.pl usin=
g
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/hv/channel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index f4370617deac..c36ec14529b9 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -79,7 +79,7 @@ static inline u32 hv_ring_gpadl_send_hvpgoffset(u32 off=
set)
>  	 * therefore leaving a (PAGE_SIZE - HV_HYP_PAGE_SIZE) gap.
>  	 *
>  	 * And to calculate the effective send offset in gpadl, we need to
> -	 * substract this gap.
> +	 * subtract this gap.
>  	 */
>  	return (offset - (PAGE_SIZE - HV_HYP_PAGE_SIZE)) >> HV_HYP_PAGE_SHIFT;
>  }
> --
> 2.48.1
>=20

