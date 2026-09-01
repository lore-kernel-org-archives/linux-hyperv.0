Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020107.outbound.protection.outlook.com [52.101.85.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD21472075;
	Tue,  1 Sep 2026 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300273; cv=fail; b=bx4yudz+i9XRW12u6LupOWmBMN+QAzRVVjU9/0XbmC+jUWqcyFaIx++NokyJlQnclR2MBxtvCvt52hGTVgnflrtSJ+Ajt1Htx3v8GZjfNm80WhI5ZtEizZoeH4vCNNcHqgNCts+R2KElGhDeH02FAgbzlSFosiy6QZblVDJBQ/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300273; c=relaxed/simple;
	bh=XcZTuWLrDBgvrpzSXvtFTuICK0Ppg+6kOU8PAE8hgTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxgEqTysOBJSjM/dtnQFcUnAfCbtX0LeQcBB6YqpLfYDVUo1KG1rHJX+KlNA0W5cHiMnNa7EdAf/VzBb0ZSsNsy3YcUYrEmcfQXb+kceVcs7WdJueyLV6+w1jTIu1ZnnZYjftcHF89BrBwir8d2WSSBmyugMJDkJRHb+2wy5GuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dolGooN4; arc=fail smtp.client-ip=52.101.85.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dolGooN4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGHWuoqpJ8zze0KnKwAD4hk51R7QJ3wc6g0bTYO9O87lj/5tg6p2G6z++89BzhslrM8eupXkp4Riz/ck3a76bFa28LVatVpUwqQxb8b+9KWM4SduCPNjupLo7edBgkQCYx7AYF4SMexHlXZN9l4pFLcG/YWoCztsDEkBy6dx7cC8GFwticKMmbhw5T1kw1U/4cIw3yMK4am8gX5KyaSIwlbj7SKEWm9XkY16iRRAzLUPB/5mLuV1tfOjQQ5qla8D3IM3udda1xLQkLfqlo+V52+54XubSdqXqOv0r6tVaHNhXmu603nMD01wNrC2w7JDmL2DrKJxlW2B7vOqOzyRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcZTuWLrDBgvrpzSXvtFTuICK0Ppg+6kOU8PAE8hgTk=;
 b=KCFXkaCPyGTxm2C4dco3J86YI3WhpKhqAkC7iBDtdX3Q0Iv7v4XVfVYTlRnBXqdunNgwQ4HFQ08YhlakybORPahJNDI1sPi8zy8oikhCVmiFLwrgftcQvggwUkEA0JOA3lBAj+ww6hmTQY90Fva2Tix2coHYQJE3SuhuymvEP69HeOLdZy9k/zEaDXj0iwxSJMyJ/u2KZUVFHO8oBsqpDxLyPgPjlju1ouvKxhIToeUCBA8Zyx4CT8nbU44Wlnv24p4Pb6Y/l7+BNTeKQ1SyaLWv5gos4HZSGOLdE5puss5BLm0FUIRVqp7jpSLErri3lgSlt5qYOAxWXNLw+TvoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcZTuWLrDBgvrpzSXvtFTuICK0Ppg+6kOU8PAE8hgTk=;
 b=dolGooN4/vMPynF2gQ/4k9wYzLgsU1RDUFeKXtLV1oKxbUfp0GVAw1sfHPmQenxZzil7oU7JMCbgwd3tZ++cIrHCBtoicV6ngn1gLWqj3MjXa+UrviTyYMfd7T6EbNGfSNeoRpHWYHOKbwatUK8fSD/Qo7ex/7EFd7GQl0rTGzc=
Received: from LV5PR21MB4704.namprd21.prod.outlook.com (2603:10b6:408:307::7)
 by LV2PR21MB3087.namprd21.prod.outlook.com (2603:10b6:408:17b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.0; Tue, 1 Sep 2026
 22:04:22 +0000
Received: from LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb]) by LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb%3]) with mapi id 15.21.0406.000; Tue, 1 Sep 2026
 22:04:22 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Christian Melendez <chrismelnu@gmail.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [EXTERNAL] netvsc.rst: is XDP_REDIRECT still actually
 unsupported?
Thread-Topic: [EXTERNAL] netvsc.rst: is XDP_REDIRECT still actually
 unsupported?
Thread-Index: AQHdOYPj36/Bm4wrJEKYaF+h1j0eDra6SHGA
Date: Tue, 1 Sep 2026 22:04:22 +0000
Message-ID:
 <LV5PR21MB470448DB6745196E16491E3ACAA82@LV5PR21MB4704.namprd21.prod.outlook.com>
References: <20260831200357.45390-1-chrismelnu@gmail.com>
In-Reply-To: <20260831200357.45390-1-chrismelnu@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3436e298-0ff4-4017-8dc5-24ea1f623374;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-01T22:03:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4704:EE_|LV2PR21MB3087:EE_
x-ms-office365-filtering-correlation-id: 8f7e4318-7cd5-4fd3-a62f-08df0874fae7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|7146999003|56012099006|11063799006|7053199004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 B/iIGTWgMYDUtP8IjKg/J4XNk8Qz5k6KKsIjPI3Lg+fZIpmywOoy3Yj6LwaeuH4U2eIzqAfX90PlARkHHXi4a+3Hv7rrqN+33Evu7ujm1Sp86SrIuqqQSjCjwTWzzC1kk/JBNwSRZobMQoG+e2Lvpv8iUs2Hsk7uo/iP9AA89bffX+8gmTOgU//KfglbImPC6AQ9q9MnDW9xwunx6KNFi6R7mUxF6f7ttl7VnrweQEUvZqwJi7pNoLdhHxB3ZB4vectTcSzI4xNu69EIs41+FOaI+b2VKwJhRu3/rtBiMq2qOcvOlOLmhZg0HMKLYnpGACqEWnR+RmHjkAkSab2nXd6jDP0WPb4jWINHbc9KhHmNigZvZkl3bA0l6OYC2X0XRHZHIbDyIQk6TvtgOWohimh/feWGfdtRDbS1Vb08bbJpa5KFgAFcki5r38kVs0FmlB0tgpdeG9WGOVSps6RVYA8GaIO1kimUgDt2NysbbqOOwZqjlyM7fcru7WZGLGG8MF/6zKsTpehCbNakhESHUQmxvAUTwwhXSb7XmYsU5/A34g1zE4lgUiGZP8YS4sSwJJZgJP0O1bIRpwO+tU04AMMNi8Cpjqk8PVuD7p5PVCTuKKER+ojCBZahm3Vh6n1rKGm45dDfu5LaBm9F1kOk0O1/JZeT0XTxYbuXuhSPXvdz707oPkTxzigCXqjz22T9cJ/OQX8M/YK5JH5BXleBcVNLS/1zk8qD+MDCvi+RCiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR21MB4704.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(7146999003)(56012099006)(11063799006)(7053199004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?45f0XUwepfa6cWphUp7GbXa0WzI2u7oL0R6bhcNDfGlPPormdqTmvZg3Zv/c?=
 =?us-ascii?Q?rNKSUXPbpL4UYhEfbw4MkgRWxGbd4Pg8dyO5S3ceGekPvpTtRuqz8Nf7KiQB?=
 =?us-ascii?Q?KXYyZ2Kg533HvyZhd4ehOUDA7yogJ9gadhL74/6xYVbAVEJhrkcvF4qTYoWU?=
 =?us-ascii?Q?t1xlh8llTZEW/6zykefAAnE0vLBOTnJaTiTelQ4sSAbchItxlQWJw+Sr5+vj?=
 =?us-ascii?Q?5blT8XjfccEbQUHC0l4NRd2tcOM0dC6J0dZx9ihLfWyUOxXODO0NQJKBvPqO?=
 =?us-ascii?Q?eepOjeCqydWS5Y5IbfGR2NsrTseUhqnUJ0LdbUQJtNV1bKh5FpB+s01e1dbi?=
 =?us-ascii?Q?5I5bwFwXjlHBzOfgWSdwvCsrA6cwcg6nzGU9GLoOWrrnd9d32FF2p1QRMBNT?=
 =?us-ascii?Q?s5tFz6DtjGVTdKpzW/ibfhBa5v6PXDzFLWaPJgaJpmFY/4+o5LKPVQl38TOf?=
 =?us-ascii?Q?MnD6yiT3lI2eZz8Smw2w04Em906TBn+TXEKtUsKUAvxnhTmjZ7CdHG5/jyrz?=
 =?us-ascii?Q?SeouxqYZoRX2cR8zaASPikaEwqYe+VbNoi5OGYEtwOapX5M1V9nydgEG/p0M?=
 =?us-ascii?Q?mex8yqKCvQ9n3NILb3clSh5FJsW8AhN0ws1WfsfvYkmd7ikv6pxy0V0JVPSC?=
 =?us-ascii?Q?VNlLPzxfThqwBGVFRcPI77EIkb/EvIpIq04I9SQRGH/hIWr2Eqfr1JOC7M3x?=
 =?us-ascii?Q?jQuYXAFNuMbnZEDMXryX14pf1q9sOMmb7JbPoeXMNLs5X7fexRyzEXN00/uI?=
 =?us-ascii?Q?gqQ70Q/AiZ48Py7bOd3Fh69S/Xv9jfj6eFwLyjN7W2eX8zJzsqqRSWFjd6Zz?=
 =?us-ascii?Q?08UqujvIKxBGhc80Emuo4NJsxBXSJquw9/kGGcFKm/CM2c1z6yO9qzlQrvcq?=
 =?us-ascii?Q?95agu/mJ/CHnILWDwJbk3gl1D1M/OrqVHwtlMHLtR9mLR1Hrw2dkKnd/Pgm6?=
 =?us-ascii?Q?rL5FOXagea4xcfSOv6L17U5vFnGKGMPUe7fXgmqeOFxAeaaNmDyIAPOqAMVT?=
 =?us-ascii?Q?NgPs04XR8a5PNYLftjLiah1GfS+/yi+amZohazAPsMNrPCIqOQQASLOWCgEt?=
 =?us-ascii?Q?wSoBa7SbvpwaoznF16+29WLXcFxJOea4w0XpKdPBbFvDUInwL4Emugt8vE9f?=
 =?us-ascii?Q?A66OLIuVAiw/MLClqezqe6ybU4Aik3H5xTisPXMEshc1f0raz3qSLHnf3zRm?=
 =?us-ascii?Q?4BqIe9e+pz67KLSQrJHdCwVWNBRtJoFSkaLLttWHkYUAMZA/YfM2Dn8+Kif/?=
 =?us-ascii?Q?5FRFV4Ml55Ko0rx/8USpW0sEhECtfs80Qe99zV5oplRy/mpdZvBpQ5scDgKd?=
 =?us-ascii?Q?sE6dWA7JzqddUzVuGTZeauk64ciC/77bK4yHw4WVhcUSX+UrHseHbWzCOdt7?=
 =?us-ascii?Q?y7qWPBGZhabolTQXOkgPlZV0tQcIZjcFDzh288XhGf4m2V509RA9thEahCgE?=
 =?us-ascii?Q?0cxWIqZRPsyu4pyT98GpIvn7RCnJob61AW2dBndXEZOYp0VYAbHYWJlY9ub6?=
 =?us-ascii?Q?z5K8b0kLne38GZLGZEf1/deSVOiVPpl3fba501jDkxzFs8eAYukakQ1VkruW?=
 =?us-ascii?Q?fbfD/da7L3awDIbRcIoiTk5RPopXnQ/sMY7qsfn5DEXdFU6+aZxQB0HWxySs?=
 =?us-ascii?Q?TzVAKlOulL2gUtukER66FKQMTvjBPP+GtAtC61khWLuSr/slX3HhcNqOjwui?=
 =?us-ascii?Q?RqsQeNkBOOjNkBQ/Tgl9HEecYI8+tceGm18L+rBTVif/GGRrDlht+Bd7nEKa?=
 =?us-ascii?Q?6eyG8jkd+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4704.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7e4318-7cd5-4fd3-a62f-08df0874fae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 22:04:22.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rb8yv0yG8crhk6lF6/ZFPGJujqmAvGN83NuJ8MvBy1gbVUbVPiLdJwl4wsFp552tRR1HjK7NeHAiqsoiedDa/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3087



> -----Original Message-----
> From: Christian Melendez <chrismelnu@gmail.com>
> Sent: Monday, August 31, 2026 4:04 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: [EXTERNAL] netvsc.rst: is XDP_REDIRECT still actually
> unsupported?
>=20
> [You don't often get email from chrismelnu@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Hi Haiyang,
>=20
> Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
> still says "XDP_REDIRECT action is not yet supported," but
> netvsc_run_xdp() in netvsc_bpf.c seems to handle it fully -- calls
> xdp_do_redirect(), tracks stats, and netvsc_drv.c advertises
> NETDEV_XDP_ACT_REDIRECT. This looks like it's been true since your
> commit 1cb9d3b6185b.
>=20
> Is the doc just stale, or is there a caveat I'm missing? Happy to
> send a one-line fix, or feel free to just tweak it yourself if
> that's quicker.
>=20

Yes XDP_REDIRECT is supported already. The doc is stale

Thanks,
- Haiyang

