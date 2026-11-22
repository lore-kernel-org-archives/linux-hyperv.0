Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795319056;
	b=JU/N3KxJUu/qdhh8uqi2CgxQU+vgTLmSVkNSRT8VOfNoLZ6EsrZb+TN//Ge6UnQCQWxm
	 TsI5KFxLqX+j6PhzQQ/CCPT7rKihk0DxtnZj1MTCa/iJ/pJH1xPQW9+Yk5kOb327b20ZF
	 mSUPYPOLxBgJ8JD19coCYppI1i4QY0wx9ZsfpLFcbWd6Mi+U6rkT5aFK6Be+jN3sieeNl
	 7nebEYaufqx3u2VnWqkFbPh1rB6TMANkdvSa6cqBKd7Y2LhXPZB6NfnGVOoj0kuVAhElA
	 8viYctADjnF0Pw2H+esRDip80+oJIkk7oCn26hVrLwNZPZ6kT2s4IqaqH9c7dmeX37Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795319056;
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
	bh=KRJdymvtH1+OY9BlKrSl3N1egAq8YrE4fwQPAoJ4ukY=;
	b=NsznFfdw+zPEXJ4tCfXJ7T2lkul5tcWrULD6G1Ho/7isc2mylKoiJvHX7q7zAL8MKaUX
	 ZqTDPuQDsIOdmu11a5FH59dU0Tpbc5zBpn8jkPhzu9xehqujHsO/+NSEau024MFq643e8
	 T76/JAq34yBiO2ZM2ZKJAb9g0KMI0Zkd8P2TllYlNFfqzpr7eP6OAoyeCFFGO9vSaQEfF
	 Qr9/bATIYOj7Js0XSujfz83gq0WozuLBDH5zCubTVpS2dQu0zmLmR9eXDfV3jCl12T3VW
	 EGLbwJdIYTylZj1Gn+EnUyFDgNeBmBC8S1w9+xmdFMF4SeAwyw/Xepl2mkaHXD6fCvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="Uu3g3Z/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.29
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010029.outbound.protection.outlook.com [52.103.23.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0F606A320;
	Sun, 22 Nov 2026 03:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9F0F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Uu3g3Z/+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4IXYVkwwaw8nnDtFbUq5kQvINuhO2GEFn3zoiIyAdBqh/cceOFtRGNq6EUBaNbqOw51JCW0h04GIbBHYX6v/8NXJ/KCyeizbYh4jGNQwaP4tsmMWmBvx4wOnQkQlgErj4EiWukKI9rw73kSuXaeYLTe0zYkiHQtuxOlDAN5RUPMZ6OD8iiMqRRGWwrVio42/ZR6DOiL4NIgruiCTjzFB84xc6FHXRmWVsDXFe6waddtEdtivdCvP0Vdv7ylRVreVyWwLg8JcOtEeHzCE6rR5Hdk5prRTIcOWgBAG9vJ+hWSolsfNJAXxc2wsrR6+1sXaajaP6EIGt+3bw+H2Im+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRJdymvtH1+OY9BlKrSl3N1egAq8YrE4fwQPAoJ4ukY=;
 b=cC0de8u3LjEssOBik2+AtcPPZ8Kd52qI75JleztHu8m/PXFTyDPUgyMt8kaj6COlQWXEdabreRlxs8pbyNTxqloqcpt8FLpuk9i2pH1jQkvzbGwYW/Wt2oHTEsR7PMC6KuWfmrIIP7zvwRH/0LKreYdvVt+0kbb5eXUwLcprW3RPdNOKfBzJHJxvSK9skhyDFjXsLuPqJv26PQP8htGJUYXCkDn4HJeoOJh6yz/OBJBZpsTuq7/+SVqtEaGUQNocJTscRbGJdyTwNySL2JlE1XM6EuTrggvndpF2SGdItw58ZNw12r96qon0aH79xb1RcBrpd5YlQZ77FUdTFqY1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRJdymvtH1+OY9BlKrSl3N1egAq8YrE4fwQPAoJ4ukY=;
 b=Uu3g3Z/+nqWoiBfNPRiPvyCOFWkP/wUPK6tb1rwZfv6rcy+Z1r0YzuOXd5dKQqgcGP50+xLEIqCj3uhJD4gkWGMP39ZFrW+svptAoQoWgE/n17UspSkoEQo9Q8INZcVo99SAX1Wp+H5ox4/7Yu66gwE4AvWfBo4OTYGonRdYgPUvrt63EzKnNqSlCvEN4yBxzcJBlq/2JHO8GVMlNOLmY8ndTkAVTbzcn4BmpXGcsktjO8QI7hjcYBP2o2zItqgLf3gEu1Ks8tcoji93HUDKZjsPV9N3Mj7ULypyEmByv64cByEmOxcqmeTgYBkirmVOyo6BAHyEVTnz59hl1Fyo4Q==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DSVPR02MB12010.namprd02.prod.outlook.com (2603:10b6:8:41d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sun, 22 Nov
 2026 03:44:14 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 03:44:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] mshv: Change parameter passing to
 hv_call_create_partition()
Thread-Topic: [PATCH] mshv: Change parameter passing to
 hv_call_create_partition()
Thread-Index: AQHdbk+V+RGffhjcC0mB0d1LIN6ibbc5itgg
Date: Sun, 22 Nov 2026 03:44:13 +0000
Message-ID:
 <MN2PR02MB6863F6129CE2B77EB2CD9780D4462@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261107003303.3897039-1-mrathor@linux.microsoft.com>
In-Reply-To: <20261107003303.3897039-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DSVPR02MB12010:EE_
x-ms-office365-filtering-correlation-id: 20c11c92-5d2d-4951-eb61-08df484ae05d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|24021099003|51005399006|31061999003|8062599012|19110799012|8060799015|55001999006|13091999003|25010399006|102099032|440099028|3412199025|19061999003|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JdWV7Lwnw1mXlSy6dv12wHynwkgx/UgZrcqOlxp3QueUu2AGprg2L5D6EwlU?=
 =?us-ascii?Q?cNETuhaQnXu043Wu9o0U71tGUA2FwRmmpp3CzXurggobCAY2PQqXp/ns3EfS?=
 =?us-ascii?Q?arBYv++AeJL3kOFRpjXk416qxMDjA5GKMQB+kuXmqxXT/gsnxZWh2u7px+5s?=
 =?us-ascii?Q?RB5lszhhZlUVnUbQrPJJ9+6noZEqWVwytB2BI7eGDKeX+zMK1IqV3iR2N+7a?=
 =?us-ascii?Q?WGtyOKAXjZVAren2VaDEZ8+KcmaLVsFZnqpcDYFRcCyR54PgyZzb0049QomS?=
 =?us-ascii?Q?HjyHU6xdTEft9rGohZJgR1SK2PC9SRwod+oajwfmZd87Zgh9CWuENvXOINea?=
 =?us-ascii?Q?4Ggsu5+hOg7zYbUTdjX+PM5824BJkG7L6CPv89c3sZBfgNGFNfT2hO8MibYN?=
 =?us-ascii?Q?b1gQ3cjXqBT1LVV/KxtNupizsO19aEJLIzYI80c5bUZGr751DalmH6NEXfiY?=
 =?us-ascii?Q?gbq8Q2f/COX9a3MEZbc+cR7HhIIAvRxm8Fgzz8NDDWqb3spMvDrYTIMICUgb?=
 =?us-ascii?Q?AVxNWa4Q5DuIiUF8Iwg9Aq7weGdzIo7uCio1jHHvKAth/5V0h3Cx98S5se9G?=
 =?us-ascii?Q?YxddOx6Ry5Mivs7+0PL9KmebntkuU+sSRUASZR6wrVSHbNclYrvZDHp2+BqB?=
 =?us-ascii?Q?U4L6yXQZGWwRVlVcet8HBDUjZ+jp2DDjptnV5fUxRljoBr4lIg9M6j4DRjVs?=
 =?us-ascii?Q?z2pmcmh89YO9nqhmu0HO8xh9Gpe3YwtXxVLvDb3ghfWx8Sw5W4nel8g5iA3i?=
 =?us-ascii?Q?Fb9XMQiNd73T63UbqrB/itqBoUrZJ+ldSQkUY5b9XPQV6GKSTe1UHVfLmbYG?=
 =?us-ascii?Q?2xxfVVtcbe6fdEfa4nn0pIvlqGK0Tv4nk9MFm03+fAvvTV+roXctrVwKbTWV?=
 =?us-ascii?Q?JhGiW0stHEwXOm/IY/nOxbjoqFFVUnqsdP073QeYzW6aouj6cmqzbg++WtOO?=
 =?us-ascii?Q?yIQNlfgORI5u+AzVbZaxY4/wZUV8ma+KYGal/DWW1c9VspHZuU3QRGVtmB0J?=
 =?us-ascii?Q?GyvligpRtquQi3JLB4fgHenALJYKqz43rtgw0jgorqAaVnokuKMmTFqRlJbQ?=
 =?us-ascii?Q?I588ILVzSWOYAIvlCitS2PT18USsPhbkIIRpSDxSfu8g4Y3vjKQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IyIMilgAY03pBNl3ezVMPX6kDOrmYxU2CZWvANDfxtPuRAsXDx8i2YWRaIz6?=
 =?us-ascii?Q?zBKsLF6vsaHXpVxiCIRm2t3ahclzj+JC+lR18Lr0VrgOz4woMa8baAf4jf+s?=
 =?us-ascii?Q?/FQ0IVvaisUfYnZ/FTfOm5xFlM2CgNKIy68tw4MC/IFr/FGOO6gbjyUZK9+1?=
 =?us-ascii?Q?/NU4I1TBBbZG4YSOqAC1Ih5BktvVVanzvkp9p+q3h+rcXyTuDnAkLp9XjZY8?=
 =?us-ascii?Q?cKwGVDDn9KVQibFEBwRoq6BXdclWQYvx8mdvogeFwpw76IT1/7xQBtpfOpPW?=
 =?us-ascii?Q?1MqgEzDtLZUf9CM+apjx0KpwnVA6O5NhFKRnQ6gll/T8buUZoxPaYfohdvcJ?=
 =?us-ascii?Q?sbfxB/CeG7IEw93VoRPGPk/9DRONvVvqiTutXYVeiccK69SqhD1/qqS2j90K?=
 =?us-ascii?Q?WEmuTDrpjWxn3H4HnISY1yiBMI6Ai/yx9meUgjdzJVoyTmhMQS7Fw4vzjVy0?=
 =?us-ascii?Q?3DjQ0jkIodaMym8PX2jL9cbzi9rGEK/vkvC0d0pkVXs7Zp8tL6awxWMW8S7d?=
 =?us-ascii?Q?eZQjCokTNTZKj2jsWn1KBYyT2rH91TFsZC+SH7wTppGbqWmsSSuFQW8VS49n?=
 =?us-ascii?Q?Hmp3dN+n147Lk5YsG67+a2bFcGkiwM4UBLU5+HoYEk3VijJRNgH/Ez4PqWc2?=
 =?us-ascii?Q?mmP5RSrKYWg4TPrrKroFGBheOXNj1fspzYp45TRkbz9eZpcg9y4NKHETsR4X?=
 =?us-ascii?Q?S6RscTGwwVOJPbQVn7LtczSKjTfUEfnI+RbrruRobUlydjMv15GjGfZu2lOg?=
 =?us-ascii?Q?PhUlA+9xXFIUtIeshzIlNzMQcUWfNtCWtsEJBFn/QSwbunB8b08v5jw8ndLe?=
 =?us-ascii?Q?UNH75L6QbLFDiUKwUu8HAwT+1zEc3X3wpzL+03dbeJoSvV+95o0cHElA7ayt?=
 =?us-ascii?Q?yqUWyZuoQzOY7LV2clUaXcsPdFcQoR+rttDXtYE4yjgqqw4ZZctY8+tzvb8r?=
 =?us-ascii?Q?Ow/hU6vIzqGZl2tZDncrEcuzm4N09t76hj6K4v49rkB9sRZaUiipYbzuB5f8?=
 =?us-ascii?Q?66BR4bQK+qOnAGiMzcq2Y5Kv7Dob6sUai+UzEyEY0qSA/3JJTNAtvCguz3VS?=
 =?us-ascii?Q?iBpm5BhyFLxQ782XybzF4tY19h3jhiYkaSqNJmI+BeOUp+9Y+lfXhua7A3hs?=
 =?us-ascii?Q?GtWlPor5kWTAvjgK8CC+6+cj5lLw3EVACFnOQkM4V2tWStW+jHCITdelfNGa?=
 =?us-ascii?Q?EJ3Tr6GxjubMZxwjT8wf6+w6SGZ9DImTJnZOLszofY3lXnTXBGOPTKG5MWS2?=
 =?us-ascii?Q?+D4j+3jhkG6IqaSKSjGvlPttpOmqsRbxct0hhJ8YYgVNlx2QqHfyKG83ODAi?=
 =?us-ascii?Q?dNZoUYR/O5/UP+iFSpo6I6QNVc+eU+/1cD4J1QWL8ncjfDsfw2JoeplT5y/I?=
 =?us-ascii?Q?r5OjH5U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c11c92-5d2d-4951-eb61-08df484ae05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2026 03:44:13.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB12010

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, November 6, 2026=
 4:33 PM
>=20
> At present, mshv_ioctl_create_partition() for unknown reasons passes two
> aggregate parameters by value to hv_call_create_partition(). Change that
> to pass them by reference.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/mshv_root.h         |  4 ++--
>  drivers/hv/mshv_root_hv_call.c | 12 ++++++------
>  drivers/hv/mshv_root_main.c    |  5 ++---
>  3 files changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 1f086dcb7aa1..c61b52db7f00 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -275,8 +275,8 @@ void mshv_vp_stats_unmap(u64 partition_id, u32 vp_ind=
ex,
>=20
>  int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
>  int hv_call_create_partition(u64 flags,
> -			     struct hv_partition_creation_properties creation_properties,
> -			     union hv_partition_isolation_properties isolation_properties,
> +			     struct hv_partition_creation_properties *cr_prop,
> +			     union hv_partition_isolation_properties *isol_prop,
>  			     u64 *partition_id);
>  int hv_call_initialize_partition(u64 partition_id);
>  int hv_call_finalize_partition(u64 partition_id);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index e761addda50e..bf0f90515dad 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -86,8 +86,8 @@ int hv_call_withdraw_memory(u64 count, int node, u64 pa=
rtition_id)
>  }
>=20
>  int hv_call_create_partition(u64 flags,
> -			     struct hv_partition_creation_properties creation_properties,
> -			     union hv_partition_isolation_properties isolation_properties,
> +			     struct hv_partition_creation_properties *cr_prop,
> +			     union hv_partition_isolation_properties *isol_prop,
>  			     u64 *partition_id)
>  {
>  	struct hv_input_create_partition *input;
> @@ -105,11 +105,11 @@ int hv_call_create_partition(u64 flags,
>  		input->flags =3D flags;
>  		input->compatibility_version =3D HV_COMPATIBILITY_21_H2;
>=20
> -		memcpy(&input->partition_creation_properties, &creation_properties,
> -		       sizeof(creation_properties));
> +		memcpy(&input->partition_creation_properties, cr_prop,
> +		       sizeof(*cr_prop));
>=20
> -		memcpy(&input->isolation_properties, &isolation_properties,
> -		       sizeof(isolation_properties));
> +		memcpy(&input->isolation_properties, isol_prop,
> +		       sizeof(*isol_prop));
>=20
>  		status =3D hv_do_hypercall(HVCALL_CREATE_PARTITION,
>  					 input, output);
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefd..89fe6fb9244a 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2088,9 +2088,8 @@ mshv_ioctl_create_partition(void __user *user_arg, =
struct device *module_dev)
>  	if (ret)
>  		goto free_partition;
>=20
> -	ret =3D hv_call_create_partition(creation_flags,
> -				       creation_properties,
> -				       isolation_properties,
> +	ret =3D hv_call_create_partition(creation_flags, &creation_properties,
> +				       &isolation_properties,
>  				       &pt_id);
>  	if (ret)
>  		goto cleanup_irq_srcu;
> --
> 2.51.2.vfs.0.1
>=20

