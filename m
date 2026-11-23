Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430893;
	b=UHM2TKBUFYX5Xw8IM2VIcNLWPheoG1UVdhEm44imUWkM7BgkW5RW+xjELMFLrpOwbBoE
	 +mUreCDwDvXP2fiWQ2DcZKfvPsr3a3Wy70qTmpoBNyCtK0YAt1bZw/kn1wVs1zOPqwOU3
	 PZuvscFyWVatOfr+OyXBp6C77msljVVnfFVZhVHI1MeFNuDD02uUqDsyh2gyzwoD8EbcC
	 ql3UloiS2H+0Je2ASdCB77Cb8DI153yOBD2/prf+9Rs77CrJ7Qf/6hf7+2B7qOpp5cq2z
	 BvxeAev/pyviEAGCXLTu+m6zrUtC6Nj1cTwiNGDPKCd+GdVvlNQx4XKsqyMON5KNSvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430893;
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
	bh=xmA1Wyo926oEe/q3rVojBDXq62ZgfN7BQbs5FWr5Tg4=;
	b=jX8LJqlrIh17gQ+rY2klpQStcqYpmYITZTEjlr+p9o+Nf4ui+76XPDpjLErXgo7tT75E
	 UQwjO8jFDVT4r8j3pleHXuTBAawt9TKdm2HMDJLWRQlPye7X4C1UuhSuJf4fV/a25Qsmw
	 deLSU/lv/sSo4sJL6DBIIrY9OBuK+taXMbIdUwRePEEjmUd4OpdPbsdZb5OqLjRd6PL8f
	 NDRB/nmpDjVpKAr/8JFx6ovgkqJTyHeFutHjDNEIaMoYB7Bj3DBOWedza339CiIILgQk+
	 G8hAmsp42OtYkNHgcpxWP1XFTomTnbHZhmPAWWFIX8xlb0Uw+kBguCH7ohrEghGLRqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=azNL9ylh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.16
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012016.outbound.protection.outlook.com [52.103.11.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB4606A33D;
	Mon, 23 Nov 2026 10:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FFB4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=azNL9ylh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9ck8bJoZgfkq0sekMZpkvmakH2qQKUtRLAIN+yZ4h0FiHIZWhJsJdoaWnUo1szTbsIslUmsridY/mhNVY/EOyA0HzmqZdi+6AIfZeTllT28Is0UAjbbI3Fx3+frMVDwDQXJp6lKpF+BRaiirFsMmhJUp3uhA1gd2R6kBSbanZfWF9M/gE4fPOPX8t5iFDzUbygjIAE4ZHoGcfkdZL20CI8k+up/I1deXdJfdUYeNsW4kpnYIzJiWKM+HuPOev+FksiSQx6lrCzR3g7Gl/AocelxsbPHTKd8vmNmSq81zA6SYMhU9KWxsk0pMz+3WrjIMw4+va6cWVWHoHlSnqxmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmA1Wyo926oEe/q3rVojBDXq62ZgfN7BQbs5FWr5Tg4=;
 b=AggIpBlUCcQ9hz0RvP5zKgvkM+CyZ2HkOCgvUgR9jzSagJ/zvxX4vmbIegldsZ2TEZ7e15AKif2V5U+ZyQaKmu3+5QEe4v7fc/BziHSFJRlM4rfWIhJvqmwXAXf2xPdHaNGz60K57BiOr0IrnH9p4Qjlq1B27/LWZiI8PPtknsgzD+c2Mj4wtqXtcBoXoFJVqL4CoNNQEWr/RHc3/40jCeGQDToQ7KKkI+2s/ig53TjMxUq+AoUxcxTrHmFTsoZ1TOi51bD6mHFEX1A2Odw9B/Qm32SFym7httUjrJS/s0Y1cF8DlG4sEiv2aN6zdfbXCj/zUvMM/mbKQ4uLliiAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmA1Wyo926oEe/q3rVojBDXq62ZgfN7BQbs5FWr5Tg4=;
 b=azNL9ylh1DYpsayromys/y39yDukvqL7hce5RY30WebCdOYiveEqM1n7Kgo3nEBzuqtRcbMsx1LJF2XsdNWiiddj6e5gnpo+LBX42DsO0LBcE20tpUrEsvJ7Vr+P7Vsr5fyDoA41YHLdv6KaX/CZjJ2gPpSFlNh4CzyBAXT3E4f6ebXkVs0Oqsiy5a3r7KEB4Z0iQe4yEMMgZMsyjx890mALqSQ7PaKj1btPYFjtoXKeIEuIjkNogxJZa4DVbrB1kWqXPT3RFCsth5qIRtl44yt9hkDn8nacmBk34eO+l4wHQ8IegVJushAnMIQRv3hJYnyiof4Ohe0baptsMtJHBQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB928093.namprd02.prod.outlook.com (2603:10b6:a03:2a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 10:48:09 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:48:09 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Yuho Choi <oss.patchbox@gmail.com>
CC: Will Deacon <will@kernel.org>, Wei Liu <wei.liu@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>, Easwar
 Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Thread-Topic: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Thread-Index: AQI83YYoiMXxR9hl+Da1t3KlxwRuFgKG1JtCtmh+C5A=
Date: Mon, 23 Nov 2026 10:48:09 +0000
Message-ID:
 <MN2PR02MB68630C9F5A4AD705B3838FABD4452@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <awQOkV6RFl0TM6Hb@8bytes.org>
In-Reply-To: <awQOkV6RFl0TM6Hb@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB928093:EE_
x-ms-office365-filtering-correlation-id: ef1a7b49-de1b-4ffa-1623-08df494f439b
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQkGaLwEdeYxLY7yqos8lGqVhgR33Y1C2m4xULn6yRW7JDuYLFUxQ/KqoNfnYKOngVoR4/EYrDx4Vx/f/te9rB/HAa3e4GupZ0B6fkd5NBCcPmT2botVhBzDipvpr89D1hjUJ5MsxiH/RS3j7lDklBmm4Y+ofYexiqAd718o+f4EUiQrEg0nNNTH9dYVe+cImRI+cbGrpdlCOm8RpW4KsSDSXmebi2n8aOrphsgBP17fxwxKAUVFcuFJgpMVYKtJZrGKRRWWlQDVPvcSR54QXPttp8tdNkt2bekv5KzixzQrdk79AaVtuLDZW8A6YCIOpI3kMD/8CfTg0EklE5V2KFhzJlMKFJ6OPECyWD+dbgQGYiQL0usBcD1UvulNLfU/S6TGF7azoifmX82gzTNIp5jqA0rD/uCGfVwESSkFV5Dty/t5QTGgC2gJV4nf6c8WexUzvXRVuGZUXRcgEc9vdJM9qUu8K3Wa/z8EIUSKXbKEDWV+sf6aZT7Si4UX/pJmjfoRIqmrL8SZdDUhBOXo3tO1iTPf+xNwJgJ6lgOQRr9Uxa5dSWFTKYbA6Uc/eYh1sX3Z0WYIaEkGuHCW2lfyJIYhxES9KLHF/rANPeD0wTQ0PVuBL9jHoHFnE+s+LN2jTZqzue17VZw2CIFo5+g14ugC+ulBpT6bR1zIDNw636nmp6VEYyNyCb5dA6deUh15/Pe2GQRH4KKnNdErxvGNh5hUFSyk18khycE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|13091999003|25010399006|51005399006|8062599012|15080799012|8060799015|19110799012|37011999003|31061999003|11031999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PJBWwuPLhdRgXbzQxN0jH6ro6CiQySmaYHX16ONv6T1vxZzy/ztfVhFto6RX?=
 =?us-ascii?Q?xbxMpMAgfRcxzG9Pc83mkrYNSMykopefcltyB8Efj8if5LTkbVfV9egNnvJO?=
 =?us-ascii?Q?4nehu2Idw/RnZ1HKKKisUOEY58VAUWf5lThqFQ/hd0O/5t6t6U9LlENgqQ/X?=
 =?us-ascii?Q?dEJVp2dPwIkz9edc5AJf/RlKfVft3P0lYU/tPgP7Sz06W8+0FTJABEuW9TSV?=
 =?us-ascii?Q?GFBKO3gyHYElnMJFNlD5daXlATl7HzZsIXRZFUxe1gkFFD0HEFzxYj5+4+61?=
 =?us-ascii?Q?24SvsL1WppgrkVt+TDzUtc9BCu8sVIfzbk828Wdw55wF6rB0UDWjR2KoPPta?=
 =?us-ascii?Q?RRq/j58fhyuF+mliwuUqdN7HGwvxRZa56I6Gk8qkOJuMU8t1IzykpHDXNdG7?=
 =?us-ascii?Q?uIKgJE+iyQqkkJBz5l9JXtJOH/YpTdGk7lmj0qhVv4fjtxfE66WjbE9O4OuK?=
 =?us-ascii?Q?usrmJdufWp8Fn/UX2jJeUub//hSYh34zQka0/k8oq/5uhwi0Ohr+jbU5bmf8?=
 =?us-ascii?Q?jeTO6zUjOXhTiPI1y94CL7SxqHVUxAtdsU8IoNO6ovht1ecVDp+1gWOp3SoW?=
 =?us-ascii?Q?4GvmgUIBnD9+5ljZnT8g+7YOYgOZEDPcd/25z/DR/rsbw7X/pcF/Ybrra4S9?=
 =?us-ascii?Q?w7lbyGT2pZfKcwqkB0piMLnJT/peLspBlInMIPk47y1dS0fYrDj37Wim9lVj?=
 =?us-ascii?Q?O630vAtr4SCTNFnuVx7minJVZuRZ8rUguASQImB/NmrNH7YXXaRzM7tl881T?=
 =?us-ascii?Q?ZKXk6kUCsZ0ExmeBQhA/fib9Ez8j6rTPA4v+KyOMRB2UjD0KQV9rP+47OiIW?=
 =?us-ascii?Q?1UgCX4DnRFkEeA+pn3Uw6EwJpLkjUxz4ckH7124m0aTuYZ+wNzuXyN472YTV?=
 =?us-ascii?Q?nTowAKHKtTaj/YGa/zaZC6CZFOSDIvRaM8BAMBXA9ATdngcA+DBh96bj6xD8?=
 =?us-ascii?Q?eD+erKontM+KiVzIOjpo1eYmtOK49k/CEpgLECEeY8HfM8lrGr6tZb/jvmkQ?=
 =?us-ascii?Q?lWYqyhESEnG21EkKRB0iW+U4+QLgYfzkzOuM+gb6pdtkqQRVjKrAl7Q/7RsJ?=
 =?us-ascii?Q?ugK33+6R?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gavmZHNlreXFGocMk71pEs/OdmvYsU2YBFuaj2Vlacm12phiFbUHc/Z0CfKy?=
 =?us-ascii?Q?aXXfOEhnkMW0wLoLM17onT5lOrHcr8GXbNSK2MubIRKSOvXfJpF3nI8YClaA?=
 =?us-ascii?Q?giKgZCNYYD252rJHLdMJvCryF38ckOrTwQmfgy9wisrUtyfPhanThyKs+ViL?=
 =?us-ascii?Q?o3H42BDZSsVIwE0G6dpLfSYtCMuB6n4yiA76wVIhPW+OUXk/RTTLhMxb7S3e?=
 =?us-ascii?Q?BCcSBLwqfKkW4T44G+v5pQcmZv5y9FQFe5JnS97EF2llhOZi3f6LuwMm01gb?=
 =?us-ascii?Q?4EEysVMyrbwpZRy1v96fc9tC0C0Ln2smM1l6Uoyw9+WxTcK/+hQ7A+XaMfTT?=
 =?us-ascii?Q?QePwhrEVGJr8FkZ8Qn4OSNnKHNDLSOP8bG33aHwd5Zj+HL3tkCB1YPKt8SxH?=
 =?us-ascii?Q?NxFG6MY306i8bhWBdo5Erl6T3JlyoHMX2ALPFBl9dNF9Gc+TSM/IvDmVrSXT?=
 =?us-ascii?Q?3uzm/8q4W3ED2Nvov/J8Knucf4GorQ/3D3i/ki8v+hWaI/WnQdznuAYFEqTC?=
 =?us-ascii?Q?7JMZ5AGmCrXp5bmta6VzJ3BPOXqm30pxzxxd3WvIla66rVdju2SkDsAM0uSN?=
 =?us-ascii?Q?tDS+FxIbdACuOLUrtcLQT/cuLcBureOXwCL8K23gzfUp1bTpeut9fzT46PFa?=
 =?us-ascii?Q?juwa+rJefgBbOnqI0m1eltIAICg9UK6VLQn4Dm0vgY62Bq8djPBnOqV49oFQ?=
 =?us-ascii?Q?KerfY+p3dVN6C8Lm6h+bEYGXPp4Gs4ceVqOmMJ8jCTQ1IXrBHGbPEkD0p0ys?=
 =?us-ascii?Q?bhsVzj4DNCt15O250y83TjBnCu3TysYF5+gElRup64DWzWDAJ/Z2o6SkzKV5?=
 =?us-ascii?Q?+cuuHYCyIaCFBJl7AFtoSg7wuhUxbMaQinKEk/KxDfb/TOeAOcPad6HmkfO6?=
 =?us-ascii?Q?EjBxgxayq7ngiBQKEUL+nZY4f+CkhJu+RbEFVr498mWJWi6KiJCzsckMW87j?=
 =?us-ascii?Q?3/3GyF236ICdrEqTLSO/WuOFG/oOS07q2We5V/VSyBKWEJrKBnY1hy9+tGeF?=
 =?us-ascii?Q?D3Y0eKolehW4wliXNFIxXTkEa4KUJZJO3X7mLrhJwNHYJSZn9mO6bgYTAf1E?=
 =?us-ascii?Q?DhIT6tyhtjXwUK3krDxasv+3CrNtu/jySy0K51WpGUB3qq2qdLpxthgRw4fV?=
 =?us-ascii?Q?TXdyfdXW09YY/9MhJy9e45ZIDPXJLLR3HlSDUY1XcGZ/BP5jTEzduWbj5Ebl?=
 =?us-ascii?Q?sdFEgJb7YHu87bPu2K0uUjUAuYMw5MGaPyD8hszMetPgJ22rh3UHEd+zgpLG?=
 =?us-ascii?Q?uEYXiJjAtf1Tjv1PSn4wsunMcWW+9kEstNduSFZf8Vz4imGNNtXgi9PUqEUV?=
 =?us-ascii?Q?VajdEtNeoIIegoCvfkR9eMLEdxEXklkhmTCEAjB2q0T0Pxm7og+CXfiemfZe?=
 =?us-ascii?Q?wlePrgU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1a7b49-de1b-4ffa-1623-08df494f439b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 10:48:09.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB928093

From: Joerg Roedel (AMD) <joro@8bytes.org> Sent: Monday, November 23, 2026 =
2:00 AM
>=20
> On Thu, Nov 12, 2026 at 02:56:58PM -0500, Yuho Choi wrote:
> >  drivers/iommu/hyperv/hv-iommu-guest.c | 29 +++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
>=20
> Applied, thanks.

Hmmm. Did you apply this v2 patch set, or the v3 that Yuho posted a
few hours ago?

Michael

