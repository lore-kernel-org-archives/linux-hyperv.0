Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010023.outbound.protection.outlook.com [52.103.23.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8F34AB01;
	Fri, 31 Jul 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512784; cv=fail; b=LgVrPo/6xuLlnNNRN+WEIi2eSDCACa5SnX+rR6DZvdj1L1zUbuCiArwd0tCFpjXp+DP+HTTtpPae7N7pCI4PyrqBqI/lkpnJc3ZInUeVP81BhnQ/39n/d6REbCRtks4uY+e/NY11XVkhAOTB0T1L2GAib7zqvDbnOMQLnATWlxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512784; c=relaxed/simple;
	bh=fg4U4H4DQ/Tmt/DaEO+xHyjVxx/bbsjUerR81zb/Gcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DPNI3tg7SEW7iFcbU6Zm7j0hUO3vFn+gPJybmwPJovAnVgRrTB3rY+5RF6nwKQVofIW/LBDVXnx6ov+rfuFPJ6UeCeTXjKUaZOnxKm0xYQIFLhdTflpO0tG+ZQVOFZ/qikumESoIjbpM/L+YQhUCpxBPaipHCy7Osd+Unxu6Ubc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HNoEKJjH; arc=fail smtp.client-ip=52.103.23.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HNoEKJjH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAPv0clX6yBG/Aw1znTyijbkSfTSUJIrKPJzss5W4wQHxVWvoVcmLDGOpusxR7S3Y9zitx+mggY0DSCF17vDBFqpmfPwZArEHeG2/e32FNU10HjRz/NfA+lGS3QAZtoRll5cIl1vVG97+4z7So3/md9gYSFxRSTN+Q6jHxXTXcKS3XLltsbPNxVRhq4rrgo5me/mV6biQppiHEekC0jxMph6VruJfUdZ+N8BR5T3sOcWtmPCfc8y9qe1WtzXX7EODIxjx8bNaEBWPFStHyO9XTi89Jd2viCnuEYwoorWxdXGVrs8sA+nilACM5q0kNUZl0UOwTHGRnDf3D6ppcftCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PtCaO6azyHl0YgDOclcarQtYz7qudoy8HuoSLECte4=;
 b=xxUX8isnXvjNgjE+aE3GW/ux+JdeO1XIdI7O72gqEagskYaYrsfviu+7iLUmYWQhy42L+9NWaT9V6y7IZ4/qX9V1Hp1h9En4Fa6GmcLBnFzv1towgM5IVHBLKfsi6nT9+KAgdE7aiohqgzHCCKd92pIEvddTYGmmPF6He6G+yTJvM0W9q7cpVTCUH/EefVP26a93Il0qBaWNGQc6fiSQwmn/yhw3sOyfEwm/5M7Ka5pR9/EOeYjf6p9W5FRGDbckxDVqE92kzwFUW43Leg6PW6V2g3hXcJB0yQw6p4+hTfJqvSYSdnAnkR8o1qqQYC4ek547OWPDHAnvX/7dH3PDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PtCaO6azyHl0YgDOclcarQtYz7qudoy8HuoSLECte4=;
 b=HNoEKJjHsO8MYqIs2cVihl/ETi8hIy6pQjDk6hOuBTcBkp/XkDyhSw/y/CMJ63OvVtmwyGozA8zNg9kv4tHYUhq8SbdKsI/0aIt+RGg1ezsDQdnnE/eLY7TqMipSZEkQakz2EcuwXLBARwYDk6so0ky5gaLkK2V7li9sHH5i7ETY6nwLzbTX05u6b6WLOEkz2b3GTgsWf0TSGHzJ8rFJhbVm47PsYf4oRpxpKcsUyQUG+zk8jzAaJLAsyq8TF+G8lYLutqAwR0azOS9wHXrU82bmMSSmSPGql9PMI9RrnUPo5VhGNSWOeLR7cvRp+5d8CXD6CVCjLkyRN55Y6cLOdw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9465.namprd02.prod.outlook.com (2603:10b6:208:3fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:46:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:46:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Michael
 Kelley <mhklinux@outlook.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Thread-Index: AQHdIHwAL6NKvG3VSkGEjSTjwqhAlLaHxnvg
Date: Fri, 31 Jul 2026 15:46:19 +0000
Message-ID:
 <SN6PR02MB4157F701FD4592A34D893E96D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
 <20260730233359.3850612-2-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260730233359.3850612-2-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9465:EE_
x-ms-office365-filtering-correlation-id: 1841f4f2-400a-4fad-e7c3-08deef1adda9
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vR/v3JdPldgLi0scLZ7cROUFyCOJ6pYbPt5F8YRF+7kKiJlCsWqs8q12CUQHH1E29uSip5fEdEztywXtdC5CLoyXiQdkBEBplQ/E+kIufyd/t82ANWfFBHDm3Uwfdn+UPUs4qfTolZxLlscN6ibefZrp2ZRWPG9uaqxD3WY5PXxQ4yLIvxaHw2yvDFGX+D0D3hR++7SP0y8azldCLE1jus9Fj+9eHe6TIJWh+A3Ic+bkiS3ph/7bWnA1qwhXn7pO1bjmuL5fS2GkNq9WbhnhJoj6jYp93DXqSOv8TPmlFULjDRSIO3U+bNVLBFyMmawioTpqTlp0sprS6Cest2VFnyowF6MXAFo9OpF60CjSTGlEDVpwjHGSmOkFCCKgBhJ7/kclT1NvTN6xsfoCVj30RoOtYlCPYJIKv5WFLZEV/cr6tN5iOFJJwAEkwd4JvW/Tjo0c7ZOGHGffXUmXln4YranbxJvOVqD8ycZ0440EFp9vu501fZBTvw6Phf0inzNZ07gBSxERRIF6o3nMizec0wTPhEf8arQBSykZIrShqcwo+dTsO69mGXM5ATZgk7+tr0aw7KdEp58baW0SfO/dXVvrYadVijwodD2Iek4tWP1wg3tTabfYDssvHuzDXcysy48LUhLc3UjYivARMzexnw8ZfreNjnKRcKNKrl0AYYtxw401duVKRhG66ZdAbfpPw0QdOA8N8XVoV26APzBQ3omWGUeyBAR6FQyRQNLA626sY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|51005399006|13091999003|41001999006|55001999006|24021099003|2604032031799003|31061999003|19110799012|8062599012|8060799015|15080799012|25010399006|40105399003|2607281247196008|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OvLOfG8Wp7Yz6/8jS/3CysiXJd+xvE56mbXfF76l4D6n7VggiXkKCvySoTOc?=
 =?us-ascii?Q?SHxSXdvpAcHm0kNrYNbnX2tCNMFGSyohOnD4WGgPEpGGbeu2P8qOfAXrclEr?=
 =?us-ascii?Q?HfFXdc8hAdqJYSURgYeahnBDUkqk6MlKAvQUrjwiyWZCa8F2sjeF9ZKmiHq2?=
 =?us-ascii?Q?88OTNsjwW3rmk1JHxpIBG2GDdXj/PPUV/Z9UyCwV74GCz/BX0O46llggcxnq?=
 =?us-ascii?Q?/1AiYWVapLWJK/ynpAvt3QZ1RRkgKErPefRq30bVMFfq9EzSMVdL0y0HeYZr?=
 =?us-ascii?Q?O9C5E3DAJ4+XcLneVO4aFiVywXzVAYjEybJIqrjRskA3CwRDLBmxh0GUsigS?=
 =?us-ascii?Q?2cHb6UsiGZLcupyItdThs/rx6BUg7skKrtHnRuBYWuaMHRA9a6XTwjSp5MBw?=
 =?us-ascii?Q?0uX9y3uraWw8loPxYJsZfvUh/Lm7PtvDAlJHwOKR525LoCpqamIMQpWLNEtl?=
 =?us-ascii?Q?HKKdy4riaMQinIJA7dmAIvLaRNm9TEogDorOY+dnpdS3liXt3c201KMUqbPP?=
 =?us-ascii?Q?OWZJ2YgR1pLIGw1Kow4PL3sLtAxBdvpxvxuluCsyHbClMpUw8B1Q4AAQScqf?=
 =?us-ascii?Q?475xvtWClJGpbkaBlPu6bvDUuliW3O4lSaxu273XUIC2RpXlK+TMZdjL8fPd?=
 =?us-ascii?Q?I9kvuMvT2CHD1lONliEMf6n4kXlPTu0wT4fNWEUo5q83b4jh/fN7tB/TQENT?=
 =?us-ascii?Q?DoG+0/xP+RTQAA8V2uXXk5p8ldRtg3ffT2ni9ga8aMcb85wdrMAmWRPHQHhX?=
 =?us-ascii?Q?OLRkcXpJ6TBXwLsUCgrFZhhPZJjIjGO4Pxs/Fhv8IgtzbXVnXpnarXPKjkiv?=
 =?us-ascii?Q?u9uFgGmKawRHXyx7x2NAJy8uqUOyNlZFZ0oH2Mwg9wr44i+Jh7Xf/ZvTr2wq?=
 =?us-ascii?Q?1ltq4YA9NOpdzUWrfDdHLvDoyRrp+KGriuzbXMdROrWtiE6MUYfNlfCepd9e?=
 =?us-ascii?Q?6FEP0kAAOco9Ifr5UDXYxc/CYiF+NNWH1DPRhDlg7giCy6TV7GoY6ZXol2lX?=
 =?us-ascii?Q?VL4Lx5yKuV1F1PpfYy8csNM/mTJwhdLfezy0Ey2ds0rTsV/MInX2nTyU+ywf?=
 =?us-ascii?Q?j8aQguEOZTCPpi9qBcm8phrhyfa7P25dUlqZ4JnAewZxC6LKg/f/3rKUtdfa?=
 =?us-ascii?Q?y56sPTberMWrrH4djHEA8bQ2AjjS/OAhGA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1LVvuonFcbcSwJuMyJRzJQidusf0ZEuMzlTmDvBe9AN7Ny2sb0TXpqRTu4B9?=
 =?us-ascii?Q?HFeIHBSyUI8gO2krLWDWdGNEzyKYo74ScMfHhVujBzc5H4v5lirAg7mlWaL0?=
 =?us-ascii?Q?Zgis2uo5c8xxaurGEfXobHqvbqcBkB45rJrPrNNWZrpml1x31bA9gtgzxPtT?=
 =?us-ascii?Q?MRQV3TN9rZiBQpoZmb81nf/sKITER/rCt68yWdp+5zvJRv059jHkpDKwTXLo?=
 =?us-ascii?Q?ZcUA45RAzEly30+KOE8/eeREhPShpA6ibHi9cvQz8hxLPi77OxQk+eX3maem?=
 =?us-ascii?Q?hIzzzpTAX4iNpRZRzKlcB/B/KaP/V/gepynGlvCVTq/6byW1tUJw76kIJqFC?=
 =?us-ascii?Q?sH5cKIGAGtxvdypC+UQdNWZYl1ilo/qpq00a8H8PfSsRz2DjwjPIpmAAsBHv?=
 =?us-ascii?Q?+P7m9p9u6pg3I43xxko5dbUM3pXcdsaPjkfj/qmNnZmaOkOco0WvlLD8wEEq?=
 =?us-ascii?Q?RSWdqlmm5SYPZTbg0gVbgeWUnQIw9zg2Qmr42FaH8R+0RKAOOTVtUmf/mL8x?=
 =?us-ascii?Q?oB9dTof4roN/2cCrc/tkVMC6jDwBTf+Of/1n6CRl80Kilq3lGfGsI2uwg0z+?=
 =?us-ascii?Q?THPQIOtmXs0Rq4i7ErsmFRgccoCvfCb7X3eNF+x35KAXnB0arYfyNn5VEWOm?=
 =?us-ascii?Q?uH5ixon0qU68/TIkfB0otwmkrMcq0mg6UYXTrYn9uPUjh+sw7/j7hMkpiCnN?=
 =?us-ascii?Q?obGZJG+xo2ZlWAXQegpos+XRkUYvR8QuM0kXr4LONnyBzoIFYXVx/cNALvPH?=
 =?us-ascii?Q?lc7M98MzZRGTJ7Jm/YBLHGzornJwKLIrbVUpyueWzw/esZssIlpiGX5DSSBO?=
 =?us-ascii?Q?uAa4BhN2eSE1xIxrz6GMYbS3wUO+5ZgoNYUjoYqxRbd8wEL9FHYIdrhJICVk?=
 =?us-ascii?Q?tFYlCtyOa0VytYE3bhFn0M8GIvsktolRs+t3nsxnLJQAtcOPVO5tXr9Bpvpo?=
 =?us-ascii?Q?JSBQKOzOAcc3FfXZp4Aez4SSJHL6coE7Wvi1RCv3hDVSJoPWg1wiMb1Zxe0v?=
 =?us-ascii?Q?uQRA+/cv/cA07Jccnlio9sIn1tRT9wI4xOtGHEJ1JZWiK26El/v+N7tuN73M?=
 =?us-ascii?Q?waPqSTqnuxPt3+wOPe2V/hC/4IQCnsmycv/M1udnTyiWhWdHDwO7gl2HqrQP?=
 =?us-ascii?Q?zWei2y3o3usW9SbamQzT1jXoshUdAgh0l19+k/2GoBL1JfEjV6PceEuhII3x?=
 =?us-ascii?Q?7KIOdEfkswolJH+ov5XhbczpzPpYl2PKPqgMEaXSExII4letr8Z7s65CtrC/?=
 =?us-ascii?Q?VHHRpn6L9bt87pfiTL7D9qSzwR67sWkE5Mopcv5ZMjqj2zp32WTcET0hukDp?=
 =?us-ascii?Q?ymJOpi85hd/KHJmkQ0AwvDWjga4p2MTHRbvmnQN6R7C3Rvs9snQXtGoTf1kv?=
 =?us-ascii?Q?2Lo7DLI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1841f4f2-400a-4fad-e7c3-08deef1adda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 15:46:19.9133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9465

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, July 3=
0, 2026 4:34 PM
>=20
> Add a new vmbus_establish_gpadl_caller_decrypted() for callers that want =
to
> decrypt their own buffers. Add a new hv_gpadl_type,
> HV_GPADL_BUFFER_DECRYPTED, to communicate the decryption status of the
> buffer.
>=20
> No functional change for existing callers.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Looks good to me.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel.c   | 27 +++++++++++++++++++++++++--
>  include/linux/hyperv.h |  8 +++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6821f225248b1..4782f5070bba9 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -40,6 +40,7 @@ static inline u32 hv_gpadl_size(enum hv_gpadl_type type=
, u32 size)
>  {
>  	switch (type) {
>  	case HV_GPADL_BUFFER:
> +	case HV_GPADL_BUFFER_DECRYPTED:
>  		return size;
>  	case HV_GPADL_RING:
>  		/* The size of a ringbuffer must be page-aligned */
> @@ -100,6 +101,7 @@ static inline u64 hv_gpadl_hvpfn(enum hv_gpadl_type t=
ype, void *kbuffer,
>=20
>  	switch (type) {
>  	case HV_GPADL_BUFFER:
> +	case HV_GPADL_BUFFER_DECRYPTED:
>  		break;
>  	case HV_GPADL_RING:
>  		if (i =3D=3D 0)
> @@ -460,7 +462,8 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  	}
>=20
>  	gpadl->decrypted =3D !((channel->co_external_memory && type =3D=3D HV_G=
PADL_BUFFER) ||
> -		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));
> +		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING) ||
> +		(type =3D=3D HV_GPADL_BUFFER_DECRYPTED));
>  	if (gpadl->decrypted) {
>  		/*
>  		 * The "decrypted" flag being true assumes that set_memory_decrypted()=
 succeeds.
> @@ -575,7 +578,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>   * @channel: a channel
>   * @kbuffer: from kmalloc or vmalloc
>   * @size: page-size multiple
> - * @gpadl_handle: some funky thing
> + * @gpadl: output gpadl
>   */
>  int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
>  			  u32 size, struct vmbus_gpadl *gpadl)
> @@ -585,6 +588,26 @@ int vmbus_establish_gpadl(struct vmbus_channel *chan=
nel, void *kbuffer,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
>=20
> +/*
> + * vmbus_establish_gpadl_caller_decrypted - Establish a GPADL for a buff=
er
> + * that has already been decrypted by the caller.
> + *
> + * @channel: a channel
> + * @kbuffer: from kmalloc or vmalloc; must already be decrypted by the c=
aller
> + * @size: page-size multiple
> + * @gpadl: output gpadl
> + *
> + * The caller is responsible for re-encrypting the buffer before freeing=
 it.
> + */
> +int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel=
,
> +					   void *kbuffer, u32 size,
> +					   struct vmbus_gpadl *gpadl)
> +{
> +	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER_DECRYPTED,
> +				       kbuffer, size, 0U, gpadl);
> +}
> +EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
> +
>  /**
>   * request_arr_init - Allocates memory for the requestor array. Each slo=
t
>   * keeps track of the next available slot in the array. Initially, each
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 964f1be8150c5..1146addbb42c4 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -70,7 +70,8 @@
>   */
>  enum hv_gpadl_type {
>  	HV_GPADL_BUFFER,
> -	HV_GPADL_RING
> +	HV_GPADL_RING,
> +	HV_GPADL_BUFFER_DECRYPTED
>  };
>=20
>  /* Single-page buffer */
> @@ -1205,6 +1206,11 @@ extern int vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>  				      u32 size,
>  				      struct vmbus_gpadl *gpadl);
>=20
> +extern int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *=
channel,
> +						  void *kbuffer,
> +						  u32 size,
> +						  struct vmbus_gpadl *gpadl);
> +
>  extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
>  				     struct vmbus_gpadl *gpadl);
>=20
> --
> 2.45.4
>=20

