Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010020.outbound.protection.outlook.com [52.103.23.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B92820AC;
	Sun,  2 Aug 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785644230; cv=fail; b=CJuyiPwQUJS5gZoKHLTbXPvni4FBuIwUUKwvbNUrNp4iTWBmeUmAthG9CusT8H8Oh/4JE52kK1fzg1jpbPRBWPDluOB/UIGcZcfSfS33zRKT77WwakGHZw0yCoHW0oCoczjAUTywBdTlp+6qwSzTiJHNjVOV7FP17ihIG+lphWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785644230; c=relaxed/simple;
	bh=B/ApujEI1O/9GucdaoIoWeByAgAkWsPH0ahvfN0Uhzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l4hQB4x+ocUhbFoabGvrj50mi/3dzK4JhZc0j55wVgKPRe67cWX3ucyOuzgd6Jv6hFbbVFL48t1IMGUXtpB6ZBO482pg2sY4oP57vbOYLQSyEvHvIPRRW5k1rC55G8siZRw020wkBx5KfTJdEiV9S75kToIAGfRlCLnnJNxPfpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MK2xp+6m; arc=fail smtp.client-ip=52.103.23.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MK2xp+6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcQLB1Iq8SZh1JIRRCqjqH/jax0d9ooG+oseD5io7+FWgdt8J5d58Ag+wD4wAUcWG2coF5pCPpiiB8clDFyjosdowMUmOnU8VAO497yHwvFpQrpnphgnmrRjFM7TxdziRq3yaiCVBRL+r/rgT1/FWtgxvk67x8e5d2acsWfEtlAmSQWyJm+JGVIIy069BnScwnZAwg1NtbMtx8+4iADejIsT907+g8KG/KwftEM3j260Eb24ucyR0Ehn/jaVo5lpjFwt69Eef2APy7IQn9ZLja8EfnHMPxclTMubJ1JRMXjacytwlNILFhlH61b602VyeaGa9sGOyq+BEEJCQmqkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/s88zEQT49wu53Fq5SDcDUFpAbGqSBDu346PbY/pJk=;
 b=LDjaRRZLFaG+RZBOlUSN7lt4RcarzUxaRnFTuEUZ54oYmXRfyjuehxc9rE4jdqSKzEJIXv7phhzyctt3wrJ6cvLbfgcr8KDhABT6JVPvWebP1Op2h6o8u2Pp2Chf0PZPNuTBb8GPJjHYRB68Z0kqoP0IKVWOFOI3iA1qguOrPZsVpZnklnNlwjnTsH/TCug5rs90cfOoC1Ky+FniLNz3c4oJ/4aB86D6FOlialKvDWS8HV3jC6FpJVwhmFyTa94nhGmZ60PiE4BfDD97qQTj2cUcqKEXrZ2cl1O977RnRO0/N84QdsxtG1sEn9AzIHlNWLKtQDNRQF6uedmAqwhbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/s88zEQT49wu53Fq5SDcDUFpAbGqSBDu346PbY/pJk=;
 b=MK2xp+6mhSR0iRkqnHlk7biatiaigpPwGg0qphYe5pzi6gF5VsN9k/igf1EV8bQxHbbw61qWQA5dmItBBAsZTzzmeXk/4LMLuK7osfSiTM2p0UpnRQPSQfA2fvueyPR9VmhhXM2qTv2sFZ+YXtqbzb8Vfp8kscE3IoCxYFsEpQXwiZcEcs3Jgqwev2UMti+SBgChXu0oQ8yrknzdSuUX9ZnoloXasKbnXU2y4VQnqZHI1l2ooLjdcSwvNvCwHWe5SDsID3Wa5m5U/xaJ7uTKdxk1BEe9Za/Gy7U2M65ktx89GAN6/3uwt2xL4q8mYIyrVR4hysFivb5JtPCcaQAv9Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10234.namprd02.prod.outlook.com (2603:10b6:408:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 04:17:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 04:17:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc +
 decrypt + vmap
Thread-Topic: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc +
 decrypt + vmap
Thread-Index: AQHdGUstWmkWeQ5MbUqxHXCQQLfsQ7Z9FO5wgAr30ACAAiw0cA==
Date: Sun, 2 Aug 2026 04:17:05 +0000
Message-ID:
 <SN6PR02MB4157514D8AFB06FB6F2ED9BED4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
 <20260721195633.1438361-3-kameroncarr@linux.microsoft.com>
 <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000901dd211f$b119be20$134d3a60$@linux.microsoft.com>
In-Reply-To: <000901dd211f$b119be20$134d3a60$@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10234:EE_
x-ms-office365-filtering-correlation-id: 00710450-b2f4-4f5b-fea5-08def04ce942
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|31061999003|13091999003|8062599012|8060799015|19110799012|37011999003|15080799012|55001999006|24021099003|25010399006|40105399003|2607281247196008|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CWQiPTz+SIz58H7JqvGVo4QjOadzcGs8YRjvqDq1ZoyzPGg0Y8XLuNtcPK4V?=
 =?us-ascii?Q?IyTvb7iiAuqmJVd72vgg3INtdJ6/nwJhqHCbibrHl1bVbE/A2uzI1aKcm/HL?=
 =?us-ascii?Q?/vdp8t5GtTX8n0sM1gFWCaYsl11K9D/VzpMBQGy2Qh8IqkILQUf7pKB1j1d4?=
 =?us-ascii?Q?Br96tfUJinvMauSFj+rj9VxSX9Onf1lFpEEp+ZhBycAqGf3/ragD6xucak7q?=
 =?us-ascii?Q?PvxrmCyb/jONdfPY0FXkA6+hvGMuVUy1c6JVXHAtPiCBH0VzRz4ecdyr6g56?=
 =?us-ascii?Q?VgjFCjBw3EjtE6YOO/7Zk9eo4pOCif6PR5eE27av1kbgfi7RItEN5YMJqh6r?=
 =?us-ascii?Q?p4w4WXzOo/XyXUS15dnngjc9vWb5Ri+8m053uREHPnEPIJpf400O6Pe+TGHG?=
 =?us-ascii?Q?SF4X1WaJRmPUbuMyF/coU6XFjXIz+stzZgeAy7Lgji6s2Ec9J7sDNs7Qa95r?=
 =?us-ascii?Q?YV5gtCPzbmB2ceZzTCAzYLvGhpwQz5MzptjsPE2mGkDVHW2uaImpiLEzd/1F?=
 =?us-ascii?Q?XjLO8lwwLV5p9tL9obpOTDfHSQTDL4GuV7lMUgFESeuA/EygQmH7qYhWWhg4?=
 =?us-ascii?Q?RNGKwOU8CJDYAif7HahGVCrT0u4CI7MuSUcH/Z6VxD6iOX2GR0bOLyyR0UFR?=
 =?us-ascii?Q?vyL+JwrKscJSWBW0YURzq2qy4RtccYXCHFf4d1fmlYobS6b68OSfObYsQd27?=
 =?us-ascii?Q?9eA8bDH7p+JtKkJXq+pmEA9BbMbqLGbg+TaGrZtx6DSAeSy3ICrCoUPFoDHr?=
 =?us-ascii?Q?sOibFGQVOl7YFaxcdPvLo9B6aqyBSdXxDIjQVPNTb96xeZb6Fyd+HYzwqr9v?=
 =?us-ascii?Q?yXh+vV48FKSzNJmpkvZn3OXkkF1jc7f4m6W+CbRkR1CrpqeLcY+LRerrp+j/?=
 =?us-ascii?Q?RlIRg/0vniUhbVy5IwbP4ufgh3uadjaJySh7A6E1EnPdpLMvRP2qOUs7FTrd?=
 =?us-ascii?Q?EvhP/3o051jXHohERkDkEtlmCVzjOOu3RPvvgCY/ZgCWFrjhU1wXJyu2hmJR?=
 =?us-ascii?Q?P0vnebIu3NTX3DmCDqFMT7EBlLmqwqtjHzbSBBCjF1QEfejV6BOUi2TjV8jU?=
 =?us-ascii?Q?UXI7kwEZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YwAW8uCtutlcV4i5e6SIveZlF1RrW8aEHMJjx+yTT/UFsXndB0/sw0sQaSQD?=
 =?us-ascii?Q?wT/13bmhfmI+rjWKv6yfYTbdCi0PzIyORqOmXb4u5Y2HsB3WFH0ziqnie1Zi?=
 =?us-ascii?Q?Pk2xw1jwQNFH1OuuyJ/1f+oVVZ33iSEm4YgtWrgNM/dtvHW8Kc5VeqVwWlh/?=
 =?us-ascii?Q?FEHmXgnCOZbIdGygY5P9McDiW4ltEJwwtNoV8q9samZ5u/4fbPMchwR4SNzq?=
 =?us-ascii?Q?pS1Wp+LGqbaief+dXb5cH3P7uuwQkdGLSdI7TAESZ63IUgwv4T5C5WkJ2R26?=
 =?us-ascii?Q?q7t0eiKyoNYUIX+URgxnU/0KnLkL8deOB3Qm8HgnoVBLsco5TiMw6hVna+2d?=
 =?us-ascii?Q?JsQMWLdeWqejgxnw4TiZAYbpVFK9vaBv8ADGseQZCyv+R281BUvd6tJE+pDS?=
 =?us-ascii?Q?BGmCylcOb1Ri2zpOad4Rvm0xhZKZ+R1Hu8nTonQ+nBhcBVDpvPQbtCiWgWIY?=
 =?us-ascii?Q?fVsGOaa+gXTyEzeD7N4QlQfnlUNVShMcyCC56fj6BXND2/8+isy1mcltW/Xp?=
 =?us-ascii?Q?ABl0+5dIuiJV3euIMEi5o5ubJITyVkgEpIIoQdh2jnyJP16LhIFw7cBMoKRM?=
 =?us-ascii?Q?HJh5dlmCnw099ti7XoCgN0PftRsKa3e08O4HQmafh7yfI4SsxQi8yPRGeo+V?=
 =?us-ascii?Q?IxabguUXRPkKL9YyTOs+LS9pMJ1+S6a8SWQ34lVRKb6KkGKHICYyFtt9cWwz?=
 =?us-ascii?Q?2wiEbWpVTgepHb5OZYTaPD2cehGEE7uHAal9x2cka9hpQ7n3PLE2WGoSDkdu?=
 =?us-ascii?Q?4SgI+cHXh0ngapNtmHwkCN/LKeE62Lfowit9fmZ0E8EE5nlmvPduhxOzIdXD?=
 =?us-ascii?Q?hq8q9qfJxFxWqAKxKm8I236bx/XH7GxYYF5t3Msgxjxz7ER1V/+pHFwHTFKT?=
 =?us-ascii?Q?mURSejtdBK+HvTZPokeqdbTJyfH/szFFctuD6hmqEr8PXahAFxEBnJF9vJoY?=
 =?us-ascii?Q?hapWG9xglD9L/882si7ZzxJAVLnQUbuzLBCfO43FIud9w1grn2MiHr5SLSqx?=
 =?us-ascii?Q?H2sRtWK9p+a6yPVtF5Oud9SOD7qwk5CvDuTHMuW0n5UFCXtQQMruNsnSVozx?=
 =?us-ascii?Q?eEdMzKoVgVpestxKZSlU2v55OxwBZRZpUl2W0NPTU3r4Zc7Q0dJ5mjVBdDCw?=
 =?us-ascii?Q?8TNhRQVf6p1tFTs0OwlBOqI7k1gHsujKQi7yCBjCISA9QrKwRKbzyEvHKx4U?=
 =?us-ascii?Q?3RurALP9xepz0NrUe/Qf8GYQT8skVqgwHug6jfAXtVLKKj3FoMJP30XPBWNT?=
 =?us-ascii?Q?n5MlKyEMpNecBHzFNOjdTbfwLy5r92OxT6vACBpkaMnXXoPWgOoMIqnxKlhB?=
 =?us-ascii?Q?uI0dfTHwHB4ocNxQCKjadrG+Vt26zpTTi74SBGkD0DeGWIW8ABkgZfplNqv2?=
 =?us-ascii?Q?LptBU1A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00710450-b2f4-4f5b-fea5-08def04ce942
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 04:17:05.4441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10234

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, July 31,=
 2026 12:06 PM
>=20
> On Friday, July 24, 2026 12:37 PM, Michael Kelley wrote:
> > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, Jul=
y 21, 2026 12:57 PM
> [...]
> > > +	/*
> > > +	 * @order monotonically decreases across iterations
> > > +	 *
> > > +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing, but try
> > > +	 * harder at order 0 since that is the final fallback.
> > > +	 */
> > > +	order =3D min_t(unsigned int, MAX_PAGE_ORDER, ilog2(nr_pages));
> >
> > Prefer using min() instead of min_t(). For normal integer values,
> > min() should work correctly.
>=20
> Using min() compiled fine on ARM, but x86 is throwing a compile error.
>=20
>     drivers/hv/channel.c: In function 'vmbus_alloc_buffer':
>     ././include/linux/compiler_types.h:699:45: error: call to
>     '__compiletime_assert_518' declared with attribute error: min(order, =
(
>     __builtin_constant_p(remaining) ? ((remaining) < 2 ? 0 : 63 -
>     __builtin_clzll(remaining)) : (sizeof(remaining) <=3D 4) ?
>     __ilog2_u32(remaining) : __ilog2_u64(remaining) )) signedness error
>=20
> In my v3 I may go back to using min_t. Please let me know if a cast (or
> some other method) is preferred.

Hmmm. I don't get the same compile error on x86/x64. Maybe it is
related to compiler and version, or the kernel code base against which
the patch is being built. Probably you didn't see a problem on arm64
because of some such difference. FWIW, I built with gcc 11.4.0 against
linux-next20260726.  What is the compiler and base kernel info where
you saw the error and on arm64 where you didn't?

 Michael
