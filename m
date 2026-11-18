Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795021023;
	b=o3huJRAe7f74U65JNxyW6V5qKkY9XZuLAWP29FYSvSQzgHAqWSacaEvLWpjQ1uCLtSs6
	 Nq/JDdHYBr7RDHTJvcS6i/GIcIpT7p7Z+ygx6DFs9KtqOz3qpTQDR6NFYx+Fvy6l6Xqjr
	 inWFn2g3DUW/Ll0sZaxQBpY2132iJU549fOq95lBccXrFziSwGaBdGL7ZCqAjhYiIDrGK
	 CdAhyvUKtEZzh718Ie6mfERuQyqLOJIoK9GTNutFM68+NDHcN+qL51+eFkb/kK4aw4MzE
	 zZ7OjOB0kArgK9ctNgDAwEDvPU2+LCObVEEcbAXbhOXxkoNjyebx14fWA0xO9P/R0eQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021023;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=l2K2DvmlnDNeHtbaAB9kBSiQgoHP2bQgFaqEpcMs22g=;
	b=nic0+N0sAlZ6sjbwhuhhN1t1/O+ny4hRpBsTwVW692Wi+VkZSZos3nVWO01n5HtHPcn0
	 3p1XBl1gvrAiu3BhL/4eP0Lo8jDQ0KHvWYXF35zykK1/3TVVtdzuqwtyeG7Plka2lxWwl
	 BjX8tGWdn5Z5XBe/a47qFVVyh3PKb5EAbn4q3J8cBxF6NGVrejVCs7rSVZGKveA9N5rw2
	 6U4hsO+pvjcl2aJVwAjj7kecQXYrzQ01j+jLUHPv2VNJfh3WhOjblWhA3Nkolie+P7lWX
	 AdFi7vOQcVgfqDmrfyULwX9s1FgruDJ0khfoPmWXiLJOL65NwvIBk0m1mdBJmhH1hSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RaOS0nZK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.91
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010091.outbound.protection.outlook.com [52.103.10.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008E606A32F;
	Wed, 18 Nov 2026 16:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1008E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RaOS0nZK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2my06B3V32Dno4FvOS47O4BDpqgsnn53F+bQU6wPfCiX3mHWmMW++04jrSSTJpN0qh9NGyBuk1n572auA+JH1KaaGC9FoC6LRN4+oYpSB5RFiVV+BO02yt+8qRO43/mSv+wmic8P+Cio+/pEWeJrPOBgXgMr8JNmUodTtGJrP1zEESDgKuRhXMJUIbvYvPe7kH+d8z63YfKZOVrynEHxrwBeanG20rJMTV81yjAZOEwu1/tIb7d36KHN64fSKO72u93avceKcw1j2VgT/fQDlcm+T+qyPDiBJGUVR6pTEGHlPDuGX2QLWdBLVTfPRvVRJ2JUZJbD6aGnEErMwbXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2K2DvmlnDNeHtbaAB9kBSiQgoHP2bQgFaqEpcMs22g=;
 b=lFAY8aMu6lGh4uxhaJCqkqU64zd2MG9he79QhQcc2+9yiwpYTiJIKksfknsR/0HQOICqSO5yUklrIKBRGSaQmYh3Ic+nEtDFeJ9Ev2kz1Xh0rKyk+rWixZ7Ws63Ku545TeH3jgcpp+RA13t6eyyV/lg+mS3i5dm5s8SyteDAzSVrpwdD4phfVK6/PMSyhk5Xb2ScC83QNGPbkTfmlGrzp7r3fwp+1+WUweLpeTOWCNLZqvyVzedzllfbFLOno3tPVYIHBkfq8mXywEEmixa3nvdWceckJrwrAxd2M5xZQn2K3WPPFRmaFq+/tjEDJWlbNPM/gbiS11HoZi1Jk4x3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2K2DvmlnDNeHtbaAB9kBSiQgoHP2bQgFaqEpcMs22g=;
 b=RaOS0nZKntlWZbj9kmdkNN/shaoue2S1D4r9oysTIVfstzKOiPB0UDdXOIO2eNuhhmJnAfngytmZPO6z0YbLFbVkazAEgq9R2KS+xv1+pNKs29XYkMY5G1bky9lh+yFnJKSwifoMGsFstVq0CDUIAPaj0UVFyoymgHsHUUGZ7LoquisAiE7lA0gJNtbRmYcReA1g0Ic6Xfg89upEcB076+wGAln2GDTsPPfhGEk2fCl4qGHYt6pvkxPr8T9gJg2lTbJ070BtTNejq6SjQodbMGoQ32ZJ8WLwxenG9+DHwaj0YZzcrzM6+PGgF/eTPtLsFGQhev7zAJFNlY3N1oMmdg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH2PR02MB6506.namprd02.prod.outlook.com (2603:10b6:610:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:57:00 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:57:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Mukesh R
	<mrathor@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"kameroncarr@linux.microsoft.com" <kameroncarr@linux.microsoft.com>
Subject: RE: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
Thread-Topic: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
Thread-Index:
 AQHdc+NRSu3oKf9nNkmCF7w/x48KTbcvz73wgAG/ZQCAAP7c8IAAW6gAgAD5QwCAADD14A==
Date: Wed, 18 Nov 2026 16:57:00 +0000
Message-ID:
 <MN2PR02MB6863A95F4A2E10D73BDBFE97D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
 <20261114025313.1257042-3-mrathor@linux.microsoft.com>
 <MN2PR02MB6863E6C4F59864B7833681FCD47D2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <fd130973-25d6-e706-6822-793f12ba2015@linux.microsoft.com>
 <MN2PR02MB68639EE1AC00187FDA3D5A42D47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <bb569c87-1a60-c498-98e4-db519e4d7d24@linux.microsoft.com>
 <kupwlqagrw7.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
In-Reply-To: <kupwlqagrw7.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH2PR02MB6506:EE_
x-ms-office365-filtering-correlation-id: f4f62da3-fd60-477b-5bf6-08df4594f6b0
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/sGdcjwoY4T9XG3hAp9E47QvcC8F+OXklboNMTOfcOdNGg/E5yzSi1fIHLkTwvi3qynkrWzvFhTbgyD7cq7h7Mws5g4SmbB0rmzZPDJU4P7L6v2qn4VGRo9ZrZO7QRCpCNGesQcAsgaGB1umSgmXTNXnzJEhjBtjvbxfZ9YegJgCsdQZfq3kG3/caO6/aV38nIaY9dV1pXyENVcold316BVFAMjyL5oxOGr64fnIAMgTmFtuknFg2SsRpaHsi1C8t1tV4WzV0nKw0ecv5CBkq8mii/j5x2KwDGQdVC+cmucVo0Ma60UM2BWbcPM1/X3XfXwoih5yg/TI55MPKLsKGDq2RGU+ocaCCBlaHQCTV5VRGkTJ2O8HlR9kAnQfyj/gAI8K0m9m/WmN6eRUclyFyI3LBouOP5NQqV4OJSQXy3fRtj8QPEtciqZdu9nO5Lm5FxB389zY5u62dvgdO4LwBb9wcvH5KTrewLWuUY/omJxJ46YthWJnvjNPOJGvrQBv4m7GwUtMrJfOCp/5mMNmdT837R5Ywx/oAm68tppdy3g1QN8SbhE2Tz1qubaIl8wFGVeBl1aHSDcekqcJHlYB3NIknq9gm9+ZHSqUeQTAtVaP5QCQ0bK/W4RwRtR5xIP2pdndh0SrgHw5G5m92HGnmjBUxJpXf4q39jLLQgRhiOKUFMX7E1mWae40xjKITncrS2c4NrFotO0RItyCvO68uhm0qI+15hhCc
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|31061999003|51005399006|8060799015|8062599012|25010399006|55001999006|15080799012|12121999013|37011999003|24021099003|13091999003|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1JeZoSwt+14D0D6QBqfaNG5BeSJww18naCV5yAFJQUUo6CiCnq0HZMUw/nuq?=
 =?us-ascii?Q?Z8DRrMTVNr/mn6ZGDdG/TWRnkDJvl+cFrr3XqbDFzhF2b/9ZzIsUZZK1x4XB?=
 =?us-ascii?Q?z9Vm7X7At/NeUgb0An8A3AxnuzeneL0xF9m/Fp62z5+58aMGhE9KRT0I8ZrD?=
 =?us-ascii?Q?8W9j9YUV8UNTMA74Tdm84mJ6lB7xLL3ZaUoky6bCvKnkct8o7xMubyy5S6Ga?=
 =?us-ascii?Q?AQSJhOReed2OAq2o+HDdrJIGjtcNoy2N+BgyxosRqahtSEfp0wBZyPZmmaB+?=
 =?us-ascii?Q?959NSkxHXOn6RvHl81SZ16i03U7cU71MjAo7HIIGtxOHF63qCdSyH9ExGPje?=
 =?us-ascii?Q?aRSDFb9fB7dQCB+VQU/IOFM1tpF15iaY1j/rEeP8F6zsb0wUoRbHrvm5xdc6?=
 =?us-ascii?Q?CRbl8m9R7hZxiSvfm9qiJZc7KD1ufT7IAC6/1W8cP0CN5JGk0XKWtj0REWnG?=
 =?us-ascii?Q?eQKzOLZBz9/KlFvPzSQmgknkS1CiZRZ6OELtJemprTCejen6Xnj1onad5+IX?=
 =?us-ascii?Q?kAuWNoil5zfzsur/p4QIMDu6p+GeCdfgrrbKFc9Ox2NLBHfQ6Eu03i9hLkq7?=
 =?us-ascii?Q?5TO1q5+YjOX0qRgHKcmQPCco1XG9huYvWYstGhW1/t0Oy3fyv3FiC9pxqmgi?=
 =?us-ascii?Q?2QvD8WfGkeiuhRqhE/z2g2rlscI5ZG+JBkGeB2A/Yq5mYRrYDgN6RPuHp7oQ?=
 =?us-ascii?Q?T6OHgez4pGDBRJ/snpYpLHpNQAAOPjlU3/R7G3DezlTixvfreEaVGpRvFYYi?=
 =?us-ascii?Q?QNsU87z/h+JFjHT1oVe1QnWd2INclWqyeptxD3r6/lraRy6E1vR2WgIxcpF3?=
 =?us-ascii?Q?hBt435Lu5sYosobBc0IQ67Qko9w8js/SLGa5i9fsV0Co9iDiJiiVJ3EQFrfO?=
 =?us-ascii?Q?91N0vXs2AwvBdV1AF912Ly/se63aEpsE/SS+Bu514bx+aK50yO+emdO74DXN?=
 =?us-ascii?Q?ty9I5+udiSn77FwSCszBeExwPwjvYC0HSBlSc4arleuVJ7vsua37Mb5QB/LR?=
 =?us-ascii?Q?gKY1cEyXXkBZZKTJ0GQw2RskcIGwjI5a2fA3v5AKs5mgh1BhgRgLtiMR5osJ?=
 =?us-ascii?Q?lSVAcHG9T2l6iZtw+yUCaFi0uzGMeA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+qMVMqadlV1BbOIrXsm5JnaEPi5viiT45+p21WLbVq1mP4j6HcWKwJVijtE9?=
 =?us-ascii?Q?5GvgAv0/+0n9t8vIBcaDCLXjRkVyRPdy0ZQ1ZkDkJw7qtErGQ7spPYpoHfL+?=
 =?us-ascii?Q?9aBYltvK+cWUtt5BxCwGGtHhSjUAPLne7HCavBNX0SD04HCfgnZU1jahvTjk?=
 =?us-ascii?Q?sCxS7vn3j5VkIiFvh1Wp74yQHFD7e0l/dO2AfvFu0pxsXKO+4iBdGRcLeJD4?=
 =?us-ascii?Q?S+dIMcKEosrMRZwMtoRfmLmH6E+St6Y11693tdRzuFvkfzlFqmFkB5eoch3k?=
 =?us-ascii?Q?QO1IRx87YEyuD2G7ZIYAp+9EEFv18kPH4Kn2v2DYroKjWk6GvQSUKulfQMOU?=
 =?us-ascii?Q?3yvbejPtQMtmOD5GiW9Bu6h3SS+0G61qpwje4tSQFLBN52MPfPSIxIVOJXB8?=
 =?us-ascii?Q?qvuUbwJxwgn0x6O8llrwUwx/q6IIv+/IEMfnNhv8rF4nhBAaGxxnt6W55AAl?=
 =?us-ascii?Q?51qbGozLcmYTlyfRT/M7cI3kQbYqULeks8wDYFvBwulttXHgDRaVt86ignK+?=
 =?us-ascii?Q?eA+PDVcozeZjeePRPej+ssqGSXgGWe42+U/RbHTsc3sp8guoxxbD8OGAvm7s?=
 =?us-ascii?Q?SKH0bQ16Yseqk4qsVtB/pvrS8rldfeeKwdcrAEzoMcrOpk9ofn1aT6FVg6ka?=
 =?us-ascii?Q?2cochMMM93OlMFwHfE7qnBEmV6GuM+L+n3A3zqvMtu1RNG652XzHByx3jvOO?=
 =?us-ascii?Q?SPojPhf2gjgYbyznGX7CbmyHN30wfW9Y/PQnMH1KOatcksto3ETZnGz7D2av?=
 =?us-ascii?Q?xMt6mMWA5KmT1h/k2RLDRtsACrSDg7k4QdQAuLpcEYoQRfoVJa0Uker4G/cY?=
 =?us-ascii?Q?K9a+DeEZCiGJjl/pWhOqji2EdYnqVyyfLLFg0HDziJaLwJHHYZ6ZFcYlYzNU?=
 =?us-ascii?Q?irldj9Kfz8pg2KPtwv3u29xOIpGrP4YclElJkucg5Agn5mGCnw0OPOL9wwFr?=
 =?us-ascii?Q?y3pduVdM+Y0Qrp7CuYnM12D9miISniMAf/Gmf5OZ71PmlqprWovsV4xXwNte?=
 =?us-ascii?Q?mqUkpVjc2CWwdLVqmjwew8gCnfZ02T5OXp9yA66sZKAx4yU76Y5HEZhAfUZl?=
 =?us-ascii?Q?1ZnEgjDOTVO7FVJFnWBSndNpxd8A2HV22IC3DBJi40E+GVWorPWnEnM/LNXa?=
 =?us-ascii?Q?BlBD1+7Sg7vEGrOQUImnQI2Swoso7m2x8GZdGBAJ/qExxtKn88oNWzpKPKKJ?=
 =?us-ascii?Q?BCWIH6/O4I1JKTLANOajvXg63gPMaBU29oU1+LqH5PVbZUnxNLn17Z/sW723?=
 =?us-ascii?Q?B+z+GA4+D4nQngtyPsLgBQjX++ThIpxT9fx84u7B+0b32fjLHCR7FBC9dr3o?=
 =?us-ascii?Q?QcH8LEzjCwHOPzoUr1Pol0IeFkX/gG3it4zOwvFoPIeJ0LFnjlA9+Ab/7aaS?=
 =?us-ascii?Q?wNSHBZk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f62da3-fd60-477b-5bf6-08df4594f6b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 16:57:00.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6506

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, November 18, =
2026 6:02 AM
>=20
> Mukesh R <mrathor@linux.microsoft.com> writes:
>=20
> > On 11/17/26 09:41, Michael Kelley wrote:
>=20
> ...
>=20
> > Confirming, that it is same behavior all the way back to 2016.
> >
> >> Sounds good. FWIW, old TLFS version 2.0A, which is specifically
> >> titled to cover Windows Server 2008 R2, has the paragraph
> >> about hypercall continuation. So that functionality was evidently
> >> present very early on. It is still curious that Vitaly found it
> >> necessary to include the looping behavior in the Linux guest
> >> code.
> >
> > Maybe Vitaly was running into a genuine bug, not sure.
> >
>=20
> I'm not sure either :-(
>=20
> WS2012 was definitely around back then, not sure about 2008. It may also
> make sense to add at least a debug print in case we find ourselves
> running on something that old. AFAICS, even the TLFS version 2.0A
> mentions PV TLB flush hypercalls. If looping is still required for these
> old versions, we may introduce some very hard-to-find bugs if we drop
> it.
>=20

Vitaly -- I'll point out that support for running Linux guests
on any Hyper-V older than WS2016/Win10 has been removed
from the upstream code tree as of 7.4. The removal is
impactful enough that 7.4 and later kernels won't boot in a
guest on these older Hyper-V versions. Hopefully whatever bug
you encountered is no longer present in WS2016 and later. But
even if the looping is removed, the code could still check and
warn on a hypercall completion with no error but not all reps
completed. Then at least we'd know there is a problem.

Michael
