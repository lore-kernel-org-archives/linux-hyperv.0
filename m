Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479378;
	b=KBAXoAToE3WrxApnelgGFU9KdsaYyrEafzES+j2qPCmNgkapRxO7TL6RzKdsvLcHVhnj
	 zKGADWe4j+7AvTBEoUDK2Mxbfwojnr/yGqXsetQi/3CdbJtPOuU3YeAThyUXKh+Jfw3Dd
	 1OWT7itdKb/mh/M/Hrq/gclpu4cTamRi1k7nGje4FDQsDjK20L1xAR2y+tYiLxPgWWl/k
	 V2vH2gpXccHc1/w3ORVunuzgESdbFTOenfxzNcneuof2fsutYbKguGjiEfa0P7AJ/+bX6
	 GVmhfGNxsrjodREk7r7vM18+PceBAyfyPhZkFHLGdZfgEv572zgWkoUzelXGGS9tmjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479378;
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
	bh=XyWHdxxVdQeM4D7+Pa4KBCToryah7k6xe1AyxGV2ZCc=;
	b=JttsVi8FDys8yUfKJDfNQG1iZncbZG3Fe4ENKcU5dpy2CScJImWVSSg96ZRscfZOcJDS
	 tVzYl6P5ZDbDN9kO7Fb1DlmcbucR9XCIiWKgTQfrzi2OCD7LqGJHes6+N2S9fA9wKZhwc
	 9ACT6Kk8d/knWKEvNa93+HR3MlegenlyVzlhEjt0nSpxYPVvTwpVjC8S3xIolQXw5F0Ov
	 gnkJ6uHBfLDCTHG51RbhDEzvG6tZ5nNodPgqFuRQ182VmGScJeK5O8xT5atIKLr9jHPyl
	 6cXNfk245tsW6N6aRjBqV3YQW+AJ/8u5VyLpeOONe3acats3rQkEsADJH417V4uZm2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="mV/bpM58";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.0
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010000.outbound.protection.outlook.com [52.103.20.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA2606A31E;
	Tue, 24 Nov 2026 00:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CA2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mV/bpM58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qov2kfOGL4ZK7fDtBA6tV4+kZM2lo9MvK7S1tkPz2LsLPF+ccUI3UfyE3SvTaIxRN6NcNo/lFGwX6bTsdKxKKJQD3HgHc5hMW7NuYwR95auk7MPg7Xg2QX/SWCoNwtY331SksDBXc47ldRkJEPuHsbPwx/iuDI5dc1SkPuTbE/3GrlBvfEtAdox2sk2dOVrAYhIJXEbILK80OP3wiLpvWk2MwBTKfYv1VKyChMyn06PINbtrDjBoWYrD1SVLyj0Axd8pCz3RZ1QGkcfRRakETIg8hpgG1RKauxo7aRRmSg/PZ5IrTI1fccQNGpd8k0zir6H/EKywNRaybfNrDxhKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyWHdxxVdQeM4D7+Pa4KBCToryah7k6xe1AyxGV2ZCc=;
 b=QBjelbnfw61LFaLbETegZupD2dMomawdtP7zb9D9jACu4FlxnBdTaWXAwU2phsd0XaG1Fa0ZJ/lNb3vx6FxahsfHyzKV9d7JXoced1zyOYw8RYFEVk7IV1JjJ50h8gQiB1/EyWkTqA3hTHwGKDeUKrgFDR55t4I7iezMNl7ZzXXCP0Cq/WAOPYkpEPAIg5PEFC305+ztzx3e2W+uIqUin3CIJ4nv5NBHB2m6PgQWl13J2+AWdIKnSH2Bwuh2lDXh5encN2t+j5VGWLY6OWhq6jo0kJ8mWFZ2K2d0C/CoBNnaTfsIwYX3HKDZx3MdIqltsI6cVRo7/PsRiNEzqtx2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyWHdxxVdQeM4D7+Pa4KBCToryah7k6xe1AyxGV2ZCc=;
 b=mV/bpM58lt05m/QteVF0bABnggZR3+evnw23C2iImYT5D9EJ/1WRopWun9wkuqUmaWx6mM6apno7x3MTbuDNLmle7HgYSd2vbqQmshQVD/jEdxAl93neSPhLVWoGVZLSwnM0fj6O/jYSeYJk/u3O/9CVlqi19GZUgdzG2UuV4fW7SgCQ8RprbS7zjrG1q3g0dFN3+fj8K1ZNbpRCQgcZQscMJG5Z5wqJGq4DMyYaz/v+YWQGyvf/vjXvkdyxrlGb8JE3ZQpLWr2HLx6OnrNioLD9UR1dUdCdjM4lFI1c5dPmfllD3DqwiAQnetm5qpFUzbcgrJCwzFKk0k1EvfF8ng==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA4PR02MB349042.namprd02.prod.outlook.com (2603:10b6:207:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:16:15 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:16:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "zhouchuyi@bytedance.com"
	<zhouchuyi@bytedance.com>, "houwenlong.hwl@antgroup.com"
	<houwenlong.hwl@antgroup.com>, "qq570070308@gmail.com"
	<qq570070308@gmail.com>, "bastien.curutchet@bootlin.com"
	<bastien.curutchet@bootlin.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "jgross@suse.com" <jgross@suse.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] x86/tlb: Make the conditional flush predicate
 reusable
Thread-Topic: [PATCH v2 2/5] x86/tlb: Make the conditional flush predicate
 reusable
Thread-Index: AQHddnQzkd+wmIinp0iD8tjoCXhsg7c8ZR+A
Date: Tue, 24 Nov 2026 00:16:15 +0000
Message-ID:
 <MN2PR02MB6863198AC15E17474598EF23D4442@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-3-namjain@linux.microsoft.com>
In-Reply-To: <20261117091507.2088642-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA4PR02MB349042:EE_
x-ms-office365-filtering-correlation-id: 55cdee34-6993-41c6-5b60-08df49c0275a
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxObkrM6g+zZ+Vfub++oX56v+PPbNec+L63/WSFecL5PbLlQ0QqjurNYaT2RvOC+I58hxUtyQ34Sc7TnChVkmYLgM1F4WIr0t0DCfgcuawP0WiYAb4A3EFFaDYcv96OMzHE7km5Fo/ec1DyvzYTJaAavrFCQ8bRg5NeZ0LJdEUrKgao9PE/FnjeIWi6AfKuq2amUGhfCFS2y5rpXkbexRoWELu/bz++8Fgd2pSK+4rS7u4umGYiUcJhuwGB6xjaWW9ojaifAvKxELWybkYeT+2q0jpJ87wORoSQhuqq2GRd8j7llRN9gwM/r7Hl5W34KIk5SIXtnC9kin826F/f6mJayEGYMjZI6KCocLfejoXcRQ45EvrA6yv2N01lhNnSUP2E/7DG+MWFM8J9bpBHCbc1N/UdrOV1ZREVF1t8JChYRCdwzu9vj0zWNjyXVI61qVIgK/FBspzUajxzmFhQzFan5t/Cd+1j8cnQBV0uyy6DbkBWodwq2vobJIcYO9SOU65rj7x//0s09ioDeVfTY0mD3OQntKAmWbi48uFW50lbVxwMOKDjY16IZJuXNggHYKyAksRYmH/U2tyRbTm47+mOxhcWRm2P2og3PF7qNYhD25mytHwqfEs7pQRSzjgEQs+EJB5APT6XYgAb+UyrZbiXE2aPom/qXwLtEiVMVqCTERJFXJG+0Hro0HLX77TtlZRALslLapJrSMksg7WJZWc44tNzD0F2hpQIVsNL2y7+0SU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|13091999003|25010399006|51005399006|15080799012|41001999006|8062599012|8060799015|19110799012|37011999003|31061999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S+6u5q8IzI0qb3kSDhnJwSftn4wG/DwmcbcqTbhCxDDxrQP+/PMU4Y/3z3ZL?=
 =?us-ascii?Q?FDQ+5j+CeIXkdLVpa4jPg9FqK0qiihmJ2IXsaXLo/Ky5Odg99ydloj/YtTnH?=
 =?us-ascii?Q?53wdZoQnF7tTRot5/MH4P3hqRl9ZNZJqDersebeg+ejEJtZjibtzk7SZaxiu?=
 =?us-ascii?Q?TubHeee8wCYeuk/U+D92CGNGKMSsRG89m5HuElGgZjwz4A49ykayy/pxL5y9?=
 =?us-ascii?Q?K6aAhrvti7EfsnyTs3sXlLLe5seCtr0xx/gh4XlTgTIOZnlGi/idA/zfdZsL?=
 =?us-ascii?Q?RLoVJszBv2croBzeo/OfeXPQO8xnoIbrrqb4pVBPaOXBerM2d4lgJ/W3K9fD?=
 =?us-ascii?Q?bJozJlEJBn+r6fDvS6Mtte5iqEcphqaYAsAHbljI8f5qIi3Xh1McW9BgEWYa?=
 =?us-ascii?Q?HEAXzFkgB2p22SMaoY7h83+cKmQ2zNt8tRlXPEhrjVb3zgldci6Z+JqvI7+J?=
 =?us-ascii?Q?2QMshRLvIW2fINHobsuvsUhBW5jDfX3llV2w1KDWO/lXPjhsnYLxbe9ax57A?=
 =?us-ascii?Q?UXsgQQgA5vO4jmSRBMquKZZ1kHu8S6/32wKl8sGED5dQ6R+wdw85MIKO34A8?=
 =?us-ascii?Q?aBYjYby3YPvPNnEMAvYH2Becsb4RVKklPzCUgtOIUWRCBjBqnk80Q2fRuDtA?=
 =?us-ascii?Q?2wabzH7SXZBOuoiAmkQSAAY6aeDObi2uB16CTjdXHM6OhAzoj25nA2cKrQEM?=
 =?us-ascii?Q?SqQJW0EqjL2mjvykg2yCYHaacgV7LOtAHs+PQTJPcbAzRWbd0U1q2Xzglmki?=
 =?us-ascii?Q?h/eypNTMRgoj5IYK0OlaJQtAzdoh3KVhf68Mo9Lw+701xOheBz7vSc0Js404?=
 =?us-ascii?Q?1qVxk8gjvkes3b8O5BakBuIcol7JXvNF3Hl9Pj7vxbAbZzNLMB3yI1pNxezQ?=
 =?us-ascii?Q?klEGjsMTLI/JatbwHhNNd9dpN2fvC5BdyyUz4B7bxFOqmkSYWxcf3foI90Pw?=
 =?us-ascii?Q?LsaTrkbOVgMw7TElOx+qjmcz9T2mHE9BibfqkPmwRFVcIswzOF2Glm9XgKjs?=
 =?us-ascii?Q?2tpFYKaithB4j1CxCAFb65GtORZc/Qs68EroZBWbTARClW191Y+Des7VmOHW?=
 =?us-ascii?Q?GGmfwBn0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MBBFK1tzHHhg7Yv6gQy2hGf9rv7EdszKPVCKZUg6ud3W52+5jJBo/t0AEIOY?=
 =?us-ascii?Q?yHWH8ll0AIRo4Gj8R2vdGqkd1qtGdklMFAJE7tAtIrHC75+t3mxmVRQIYZZV?=
 =?us-ascii?Q?r92HMRTHMK8irzADiuUSyBOIZTtvQSpcMmr1jYh20n4NV4XbBbRShy1pJRxV?=
 =?us-ascii?Q?pCj9xcH/QqkJsrjcZelmtr4J1woVI8NctTK4otyOcddc2BnHRLo5U3m/+lNe?=
 =?us-ascii?Q?DU91Ss0D2/sg51rvKeLdL8lacSwfQ5lzrKEj8JUa3RwNxPfRk0G0XVdhHsej?=
 =?us-ascii?Q?SF9YePemkHpHvnVXdkmV2vIYhGYuZG2MDr9G2IYvP0N7gDj3H9XR/sjc7tdd?=
 =?us-ascii?Q?nAit5zU5Bn8D69GEeywmzuZoWNMJQW0CHrhTwN5DSF+kjfprD+4r/h/+Cghv?=
 =?us-ascii?Q?t5H40PKOYD9V7s/hy/6qVcaxkrd5iYZQRCVnCoGZA1LtueytHk5nbC/JlAw9?=
 =?us-ascii?Q?X1CHIHtx7Gpdep4sgraU2r/ElaOE8sgWDoL+W0bwXl8b6CSM+PaA6/HQ01hQ?=
 =?us-ascii?Q?sW8FgD+Fzb582Udv6vqXWympL/ubl9fSoJ1CqFaHPwadyTGRRsoyL0Ki6lNi?=
 =?us-ascii?Q?MSq1bZUq0z1uyJIJtW3V8jZMJYlw/v0idy4yXC9imhXEoCqgCQMTlPYGPNqi?=
 =?us-ascii?Q?tualZPt9NkLbFtJiGHlnyXWqhR7eK7HElHnaZgfSfO8Lv4EgLegSUOvogSzR?=
 =?us-ascii?Q?C+v2DU/0+zIFzEgbQT4zfFnmxd64kkb8g/lJRroMaZSljyTtQbcQ+yPQLIe6?=
 =?us-ascii?Q?kVkkm5vGLsMVPpSDZWKhbbH5pruaJPvfsh4YxHAmMqjr3IEytMfB69Jk84+o?=
 =?us-ascii?Q?OTZvkGBLxLh3eQsZVdfl8EJx8AeYahSGLSRv8Ds5iVXMky/0s+ZjBGaxPVfO?=
 =?us-ascii?Q?93k/uw1/951lreMkW1XN0GV0wEnRg9DcUa01RtqA6UWsUrvdM+VsWXYCovIB?=
 =?us-ascii?Q?zfBmBXlp1GhYP7tCNP+5Pc2ydSMVEO5q8EMcn2Db7/qe7SZ0ASb7MOsdYxvm?=
 =?us-ascii?Q?2xDANySBZ9SGkLR6QFcxX7xv/lzPLC4y1wNxZohjUy79GF8yBGwjPO+rl3Rx?=
 =?us-ascii?Q?MD0xi+v176UBtPDBHLiLvFmIV8KiNjsBVVUl0L+fb3V/auImN8d+uBvPNoiJ?=
 =?us-ascii?Q?+6gREbcARHCDDVnGxHFjGYzpgdGy5NYFFUj4FZBde/4N686wA/B6j3V9kijV?=
 =?us-ascii?Q?qQbIT1vqRHP/N/NFxWCDe2WNcTTsnvvHygiqAu+YVWtwVmqVA29OjpKLoHO8?=
 =?us-ascii?Q?snSXyW+k+A0OcxRQR3rwOjfiDFnTfsG8X9qRsHXinsDD6MGkIURvkNxstZqP?=
 =?us-ascii?Q?3wqvep85e+WZZAe4cNR4AjpPGmzKCC7zH1pCSdNZ2SXwjL6V3ReHZ0cRJ5w7?=
 =?us-ascii?Q?ODPnh1E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cdee34-6993-41c6-5b60-08df49c0275a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:16:15.2500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR02MB349042

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, =
2026 1:15 AM
>=20

In the patch Subject, avoid the "flush predicate" terminology (see my
comment on Patch 4).

> Make should_flush_tlb() available to the Hyper-V backend and give it a

What is the Hyper-V "backend"?  Maybe more specific would be
"PV tlb flush functions"?

> const struct flush_tlb_info pointer instead of void *. Keep a
> should_flush_tlb_wrapper() adapter for the SMP callback interface.

Is there any particular reason for needing a specific type instead
of keeping the void *? I'm just wondering what value that change
adds other than the compiler being able to typecheck the call
as made from the Hyper-V code.

Michael

>=20
> No functional changes.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/tlbflush.h |  1 +
>  arch/x86/mm/tlb.c               | 18 ++++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbfl=
ush.h
> index 70098d448e999..1d1852ecaf084 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -263,6 +263,7 @@ void flush_tlb_one_user(unsigned long addr);
>  void flush_tlb_one_kernel(unsigned long addr);
>  void flush_tlb_multi(const struct cpumask *cpumask,
>  		      const struct flush_tlb_info *info);
> +bool should_flush_tlb(int cpu, const struct flush_tlb_info *info);
>=20
>  static inline bool is_dyn_asid(u16 asid)
>  {
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 53dcab39566f2..9b1aea2b3a1d5 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1279,10 +1279,14 @@ static void flush_tlb_func(void *info)
>  			nr_invalidate);
>  }
>=20
> -static bool should_flush_tlb(int cpu, void *data)
> +/*
> + * Select ordinary flush targets using state ordered against context swi=
tches.
> + * Callers must bypass this filtering for page-table freeing and global =
ASID
> + * transitions, as native_flush_tlb_multi() does.
> + */
> +bool should_flush_tlb(int cpu, const struct flush_tlb_info *info)
>  {
>  	struct mm_struct *loaded_mm =3D per_cpu(cpu_tlbstate.loaded_mm, cpu);
> -	struct flush_tlb_info *info =3D data;
>=20
>  	/*
>  	 * Order the 'loaded_mm' and 'is_lazy' against their
> @@ -1317,6 +1321,12 @@ static bool should_flush_tlb(int cpu, void *data)
>  	return false;
>  }
>=20
> +/* Adapt the typed predicate to the SMP conditional-call interface. */
> +static bool should_flush_tlb_wrapper(int cpu, void *data)
> +{
> +	return should_flush_tlb(cpu, data);
> +}
> +
>  static bool should_trim_cpumask(struct mm_struct *mm)
>  {
>  	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
> @@ -1357,8 +1367,8 @@ STATIC_NOPV void native_flush_tlb_multi(const struc=
t
> cpumask *cpumask,
>  	if (info->freed_tables || mm_in_asid_transition(info->mm))
>  		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>  	else
> -		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
> -				(void *)info, 1, cpumask);
> +		on_each_cpu_cond_mask(should_flush_tlb_wrapper, flush_tlb_func,
> +				      (void *)info, 1, cpumask);
>  }
>=20
>  void flush_tlb_multi(const struct cpumask *cpumask,
> --
> 2.43.0
>=20

