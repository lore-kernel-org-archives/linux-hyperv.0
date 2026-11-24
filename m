Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479544;
	b=oE7mhGq6sLjnc3DI06WlHFWZVsT9Uhe3V/zRtkk0OWUWe7rKg+XLX3E1KA1y718E0p9r
	 fKnyPtYT2Sz+uexF7gRf212He6d8vjGxYmXRuY3nfCcFUi3kCCXgQpWcIkV8SjyY/kia/
	 XbfZACyUx2FaJzGaonGYrrfg5CPlPzKNamyBBz5f8fxSZa9SQFHRIGqm1FYPXFBoLcBzC
	 hI8mnQ5uPXRGowsJavuaFAG2m9YjpIzyWZ65BYh29zht9oN0N05CqpYobYekR5dbBCLe1
	 6spAR7RYuno/LrjWoF7b4Ahc9qJ9CR4ZtcmopTk9dJHBBoauAM247cKt0SY7oc48rfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479544;
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
	bh=kSXAAEUIuL0lRxxDSk2C12IM1+bgRPAhgEoEV0N/wRA=;
	b=g+Vs1KBMOFmDRZFVBFUFiu/XhiRDKXQ+3Mpki2fk0+NADYEOY2n0otukEeeFPkCD/lT2
	 2QLFU/w18zjb/pQaLFxqHhuNLoQobSuN5X+LPY8PIzinaBDY6xQGOAuiqxiLUOgG+MTjY
	 bnJcYNYCxHy1nLsF/+JSPcvaau/spqO4i7J/OSAwrZ+vVgUd7DUalWB5+hI+XRceohkGJ
	 cTQKu7vfRk1/7DZlHNOTReBXj4x92EJSTr/n94x+0UPJdZwENKYla1O/zoywS6DDTnsOE
	 pJRGegton0xPs+4EXAPSevyboowYNX2W0yaCU75gqZUdFC2rAdnoHZiBxYVk76ZZl2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=NKoDno8L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.29
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011029.outbound.protection.outlook.com [52.103.13.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52370606A31E;
	Tue, 24 Nov 2026 00:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52370606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=NKoDno8L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkF9ghzXDwc9U9XJ/qH1KMSjR/BIlic4J7rZahZrBEtdnDFELoEokG4zvDlXe+/NQBcrj4rzMzrda8ohZEAbEycUJaTqkGXnq4I4qhMq98mFvq8mtHelUbSouw82KTPdzvnly73+f63PScF7R950x0AKsz+rFy1FU62aZNv6W5XmZiupt+XIoyUfWcQH+E8eeDMl8Jgv8/69WW4JFwlbOPPoFLqLNJoygAVOKlLC4QoO5IPVe9W4SbTucL3yrG28z2IuYClT5akNeiclriVPE4cxL9DOZ9yyDNB4U2do6dbNtBv6TXhOJftqAztWXzrhYHRlbTjV/fC8RQtD+h+1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSXAAEUIuL0lRxxDSk2C12IM1+bgRPAhgEoEV0N/wRA=;
 b=su5cF8TICH6E2sfipNew8VBl+sNeTdYgWAAq60esxp1GSKtwRBoko0SjUAam2rh1i2JXMhLIS/qxCCdaZOBOExNCq9bWa+BCavBi9qGfb7WGJzpDCbFbdcgc8SeB4dMhFoaPsDbaLMQCvFy8EaHmPRnYMzL2kt2axjFfpWvabKFjdaRc4Ac/vgOV0kvUU/hZ9VOXuWp1MwhPEbYSfk3GIOrerWMyd9BjDNuRTH+Hfdrg4p8sFGtXuGTgGMGreVBat1bgAg9isDBpRylyRf5APUPvbwZEzP4pQvvaY96uE27AQ6ZjI4BtOk6WNAXAobBfUKBjWNcrZ8qgqGCp81AasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSXAAEUIuL0lRxxDSk2C12IM1+bgRPAhgEoEV0N/wRA=;
 b=NKoDno8LcI6wfQZtY7HUakIShRxeBY/ggVujJ1Zpm6vyzPHhVk2y1g+qcB/rzocc+Y9sT/e0vpyt3p/14E7tm+0hYBtGcqUcK6Qim7YTThIw7pTX/vNdXaZRhB+47w6ODUjoRujQHq6wkyGtlcmpwA4QF5uSleImEEFmO+un89DmEDROZoL2E1mhaFDy/4vUic1MCGC5SrWVXAIPKd0iYKvd7ytM0gSOTY5SFoY2E8XRT47gpUJbSibv1+o2QAEA9UGv60fxPTb1I1Pp5fp1Y6lbJkpKrqpsi3ancr6mr852GJaZJelteXzUjtOUy0wIKr18QC6HIZL/3cj8DC+VMQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH9PR02MB12077.namprd02.prod.outlook.com (2603:10b6:610:355::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 00:16:55 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:16:54 +0000
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
Subject: RE: [PATCH v2 4/5] x86/hyperv: Filter TLB targets before building
 hypercalls
Thread-Topic: [PATCH v2 4/5] x86/hyperv: Filter TLB targets before building
 hypercalls
Thread-Index: AQHddnQ64Ec83cbOYEiSIeP+LAxtyrc8ZU7Q
Date: Tue, 24 Nov 2026 00:16:54 +0000
Message-ID:
 <MN2PR02MB6863EA8EE36408EA031F1CEDD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-5-namjain@linux.microsoft.com>
In-Reply-To: <20261117091507.2088642-5-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH9PR02MB12077:EE_
x-ms-office365-filtering-correlation-id: 8d20b1c1-e726-4026-b9e3-08df49c03ee8
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOFKpBUSDEzOMooxQ6vF25y9Hekg8r03rX73E5wKufSPZv7NhoDiV2OHOOcYLB3q1g5LG02JyhZA5ZZoJvS35KEEybh4pmnZw3O/FDi34cae/Nzl4QgNlSJylegNCijAxsdtzM0QBX53D7H/XwrwZ2x1Z6noW8mZA+ynn3byMvGh7bybuqPc7/0kcOzsAgtmdFjCZ1kw8lEpDQ4Ev/vuH1Ibdotdck5Eky/5Q96eFK4r/XkiRHoB7LPumGhyH4K4CFd04IeFpiBSxhu2TjLfS7bQnIw5sNYoeNlDCViYc5t2vln4cxcSuRqs6XnnuW8Sixmk2JMvCgO1+3fbyHc3ZoNDi3iMR/HsPC2E+qY0667UZIgahMRjS4fSWJFYWNj5gsXuX9MFc1RUkENCykQHlwmGoQpasMzNKWFANBExaBq8NgJfrVBaOC8vXkBSex/KJFAD0Q0cCKjRko19UKS4w1VwcOa8gbc8aQNiE781Lp7QzX+8t4FLaxYG8aAvc0ob+J3Rdk5kZWJZvoZFGaCMBPdZzTNBD+KSmPKRl/NYTsfYb3dbNnzKykFKm3Y2Fn9FFP2ys/1ME5XE0l6goS8ikUwcqpJBSzwhtjaPwTNsMI5hlhZOjCWvq/+BZBHLoiX+4wkInxBNSFBgmVWlntsaKQ0F5ySADPk92Bqw5+omxJ7aKT8HLhKOLLNDjgnjnv/vTa8/9Ypp+elBjm+D9yZhAaxTHNq+nrfey9SUfQxIzea8I=
x-microsoft-antispam:
 BCL:0;ARA:14566002|16051099003|25010399006|13091999003|55001999006|24021099003|2604032031799003|31061999003|51005399006|37011999003|41001999006|15080799012|12121999013|19110799012|8060799015|8062599012|40105399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3qfK4RMgVfYypErU7Qecf3wTHN3wJXNrkDASLMsRHVNUpUl3EwHaOarG6Tv5?=
 =?us-ascii?Q?gJI4Sz13OeYRVE8uxr2KWq1lFyy8gZerysnRgokMPnkrL0z+CklOuGAdO8eT?=
 =?us-ascii?Q?szDS+rYbFCu31D7+Z6bsKzeQN6vUydcc5fD8IR+J0uYmoCqO1WeOcQepZx+5?=
 =?us-ascii?Q?1295c79Vw4I1rPskfc/SQ0dC3Uv/tIUGPwNRd2a1uJ5EIpdPbau3LGZ2+baT?=
 =?us-ascii?Q?quQ7QRoyPbNX34BTQNN/HSQwANGa4LTbSWeEXZh+yFv+xwuqBk1WN5G9VJty?=
 =?us-ascii?Q?CsOhfk24FSjshq/jbenodu0n9B6M9SPOIzVCADBwmmy5pzAqyUHb8jme9Eqy?=
 =?us-ascii?Q?kN28XsIfgYRGU94WW/fWdZ/ShEh2cWoRyQ8A79b/HrhQyv1CiIpys7wgFl+Z?=
 =?us-ascii?Q?IqS5TCGKT+HChDM8UKQep1ZRxhiXH6wRyDbWq4Oy/3aO/2wF9LZ1mXCbG9Rj?=
 =?us-ascii?Q?tjaQ4si12z/W08TZNltfAbsihXcykBO3R0Wnk/lpAzYvPrIsh7M0IUG7y8jz?=
 =?us-ascii?Q?dYJl41kA4sxHljI1QK24XmUMSvBrMS4tol5972zVf+KNq6DRT2WM9qeGSZoW?=
 =?us-ascii?Q?uzKT4daxNXz9oz7JFGDvcKHBFhoMYPQ6X1xh77Jvi1lB3B3YDqEW3E/WfpxH?=
 =?us-ascii?Q?sADUp9zKVv+1OepSdrJTJHIU8LAzZowWn+QPwzlkSpB/X/fyYIb0juHE/o14?=
 =?us-ascii?Q?t8pcbbNXp5ryq5oxAia8NCXUNfGa/dvlJWPvoOjzvdQ6NsidL5Zs7PBzrx2w?=
 =?us-ascii?Q?lEhy8NUjSanuds78SgtOpp3kFOsO21eZt8EIgZPHYCJwOVEYgCHDkfordcr7?=
 =?us-ascii?Q?wFOizBn5zSZfEVDRoGBC+ANOrJkBu7eMmnrniOZ+IIpDYOqT7b8WmucCzQXJ?=
 =?us-ascii?Q?9mAaY+t5xYBqSmZJ67pdKn2LsNufX1UFuGMG4EKDaMNs8UVB7S2Skk1sJdoW?=
 =?us-ascii?Q?gHjJ5beGJBdQ/6jViANrCMUUHgmUSEFFbyBSE+4U3R0G73B5cfWWJXW9oXCI?=
 =?us-ascii?Q?glFxFRx6fh7FL+lJUA7+nZLsdqjpRT+iCFgg/WYDKe7c1QzO5kM53JxDwlvk?=
 =?us-ascii?Q?XuWiSEMU5fwaNlsgMngPPNtmIxF2XGduTGRqJr/UOGo0YPPgou9TtprjEOAI?=
 =?us-ascii?Q?yM4fAf0NsN927W7TQO2PpYQkORinl2zKC7G6krd1aiyairVsVEAGX0k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+pa2ujtuIJB9oEqFcNqrhtmaf3gdpzZlwa2zTL+VI3rp4eEuJsDKIQT8pLnP?=
 =?us-ascii?Q?zyMqgOsVfhF2UX8ijg1l45E/+lT2UiGgbJV+ski6Vs7/Ajo4tIzvhftTEosi?=
 =?us-ascii?Q?G2MDGwbTcTDO632IYe8QqUAqcQYq4QaNKU941ZeWeR9p3VgO406Cd4WuhQn4?=
 =?us-ascii?Q?saV2me5U2xiE9DfDJKi9EYTQ4P6aYY7qxUEX8R7OyMMQCB7BWV39JJoCT4OC?=
 =?us-ascii?Q?b1wLCl5qf3AvEaKfhvelyYIzFTDVhwf6gSincWhX4Wanlb7ocmOWd8vAtYSq?=
 =?us-ascii?Q?4QBmgIeaVwY+Vc/tLuX3ZE96nGxCS/lo/FE0B3Z3enpWhEdiIr5ni/Oq1xeQ?=
 =?us-ascii?Q?hOXk1Cbc4G8+q6scxjzIw9NitJiMvdYUOHjCtBdNdSclBVoihfDxtSVWTdVp?=
 =?us-ascii?Q?vo0Q0/mxFjSL9n0bKuM+QW4a0jSqwQ+gbJZsgqsl26nVS1srV7TOqbfufBdr?=
 =?us-ascii?Q?YNPGhPAyAeH9htWj6WzLjhgYoSMyurz/c+7hzIxC9DELvqZ+x5WCJL7MDf/y?=
 =?us-ascii?Q?jnMHUeVas9EgrdIH0hjLjGt7u5n6FxVGgFPehibljqysw9hObST36eMIV/7M?=
 =?us-ascii?Q?0NaWLf3QqYyWKIWxlVDMlvv4Zsm3zuAD3ZKphJ+Qj3c2rM/1rSudJcBLviuw?=
 =?us-ascii?Q?Uh9xiS9EVRRDEMuBP26rMdsn4EaJxRMTmCm6gTy+yAuyJBlmE7uFskP2P0Lk?=
 =?us-ascii?Q?8VcTDROZN980XpjwbZnUupl+pjVELaSK+bS8hAF34KqWEu++TNtO6PVsl1+F?=
 =?us-ascii?Q?KargR7DdZMFvmP7I69UXKt/5CeW8JaM4cQVHLYY4sokzWoPc2xidYNNUoV0F?=
 =?us-ascii?Q?dbaOxVDt9dXizyjBwjKNBuZCMOrBzIVatD5/qfSOL/jtwQsSEc116/vS1Pph?=
 =?us-ascii?Q?SAqeNEAAKkKa6G9QROdcJVbYulDZFVoaeQ2LLXXW3WzZNpWldA0N8vr4YCGI?=
 =?us-ascii?Q?fK0vQwqdDaAzUS5w1J8Khk7wtDu9W5rVAGjEvKPRL7HMSvTEmh17wCvSq7yq?=
 =?us-ascii?Q?FldQVgntElpgjpm4hHyXgTOIi+WCjn9HyMPG5QKWMomVDd2SCKxutIqcpC1t?=
 =?us-ascii?Q?of0p04Gjh3JORAmK8IqKK6blswgP+gDJc/L+DyEXcIWZajf6VtE1eAJboiNF?=
 =?us-ascii?Q?DXOjTmnI0HLwlkdcdV3ca3GkrwuSqo/XgCBflYpbThQnhfPQ1C7iWVkcO78m?=
 =?us-ascii?Q?j4x/5cPQhZ+fIN7SWwRJ91jEhr8NXtRxdWXdMlep+o9mwNtWid8EXXTiDX2f?=
 =?us-ascii?Q?b6coj3auA6407N2dtS9VHXRhP4w8LWd/COkokVUGyPANqu2J8K96V9+0HUdW?=
 =?us-ascii?Q?Mr4xVrPmzOH6gUbWVz/Cr5lS2wbGrYf+cUX2/8gAZcw8fcyKSq4Kzvnas/GY?=
 =?us-ascii?Q?GbS9c2A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d20b1c1-e726-4026-b9e3-08df49c03ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:16:54.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR02MB12077

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, =
2026 1:15 AM
>=20
> SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs regresse=
d
> between Linux 6.8 and 7.0. Recreating DataLoader workers each epoch cause=
d
> host-to-GPU copy stalls and timeouts. The reported bisection identified
> commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily").
>=20
> That change leaves a CPU's bit set after it switches to another mm.

To be more explicit,

"... leaves a CPU's bit set in the mm_cpumask even after the CPU switches
to another mm".

> Native flush callbacks remove these stale bits, but successful Hyper-V

Again, I'm wondering about the "successful" qualifier.

> hypercalls do not run those callbacks. A CPU actively running another

The word "actively" seems redundant/superfluous here.

> mm need not be in lazy TLB mode, so the existing lazy-TLB check does not
> exclude it. If the mask includes all present CPUs, the backend selects

Be more explicit than just "backend".

> the all-processors shortcut before checking individual CPUs.
>=20
> Use the native predicate to build a per-CPU target mask before selecting

Be more explicit than "native predicate" (which sounds like AI-speak).
Just say should_flush_tlb().

> the all-processors shortcut or either hypercall format. Keep the full
> candidate mask when freeing page tables. Retain the empty basic-mask
> check because filtering can leave no targets.
>=20
> This patch does not change when trimming is requested.

I had a little trouble parsing this sentence. I first read it as
"When trimming is requested, this patch does not change.",
which didn't make any sense.  Maybe reword as "This patch
does not affect when trimming is requested."

>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/mmu.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 375f23b157ab3..833eaea1d3fa8 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -1,6 +1,7 @@
>  #define pr_fmt(fmt)  "Hyper-V: " fmt
>=20
>  #include <linux/log2.h>
> +#include <linux/percpu.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>=20
> @@ -16,6 +17,8 @@
>  /* Each gva in gva_list encodes up to 4096 pages to flush */
>  #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
>=20
> +static DEFINE_PER_CPU(struct cpumask, hyperv_tlb_flush_mask);
> +
>  static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>  				      const struct flush_tlb_info *info);
>=20
> @@ -51,19 +54,14 @@ static inline int fill_gva_list(u64 gva_list[], int o=
ffset,
>  	return gva_n - offset;
>  }
>=20
> -static bool cpu_is_lazy(int cpu)
> -{
> -	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> -}
> -
>  static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>  				   const struct flush_tlb_info *info)
>  {
>  	int cpu, vcpu, gva_n, max_gvas;
>  	struct hv_tlb_flush *flush;
> +	struct cpumask *flush_cpus;
>  	u64 status;
>  	unsigned long flags;
> -	bool do_lazy =3D !info->freed_tables;
>=20
>  	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>=20
> @@ -87,6 +85,23 @@ static void hyperv_flush_tlb_multi(const struct cpumas=
k *cpus,
>  		goto do_native;
>  	}
>=20
> +	flush_cpus =3D this_cpu_ptr(&hyperv_tlb_flush_mask);
> +	/*
> +	 * mm_cpumask() may retain CPUs that have switched to another mm.
> +	 * Use the native predicate for its context-switch ordering and lazy

Again, say should_flush_tlb() instead of "native predicate". And I don't
really know what "context-switch ordering" is trying to get at.

> +	 * TLB exclusion. Page-table freeing must include lazy CPUs, so keep
> +	 * the full candidate mask in that case.
> +	 */
> +	if (info->freed_tables) {
> +		cpumask_copy(flush_cpus, cpus);
> +	} else {
> +		cpumask_clear(flush_cpus);
> +		for_each_cpu(cpu, cpus) {
> +			if (should_flush_tlb(cpu, info))
> +				__cpumask_set_cpu(cpu, flush_cpus);
> +		}
> +	}
> +
>  	if (info->mm) {
>  		/*
>  		 * AddressSpace argument must match the CR3 with PCID bits
> @@ -101,7 +116,7 @@ static void hyperv_flush_tlb_multi(const struct cpuma=
sk *cpus,
>  	}
>=20
>  	flush->processor_mask =3D 0;
> -	if (cpumask_equal(cpus, cpu_present_mask)) {
> +	if (cpumask_equal(flush_cpus, cpu_present_mask)) {
>  		flush->flags |=3D HV_FLUSH_ALL_PROCESSORS;
>  	} else {
>  		/*
> @@ -115,14 +130,12 @@ static void hyperv_flush_tlb_multi(const struct cpu=
mask *cpus,
>  		 * must. We will also check all VP numbers when walking the
>  		 * supplied CPU set to remain correct in all cases.
>  		 */
> -		cpu =3D cpumask_last(cpus);
> +		cpu =3D cpumask_last(flush_cpus);
>=20
>  		if (cpu < nr_cpumask_bits && hv_cpu_number_to_vp_number(cpu) >=3D 64)
>  			goto do_ex_hypercall;
>=20
> -		for_each_cpu(cpu, cpus) {
> -			if (do_lazy && cpu_is_lazy(cpu))
> -				continue;
> +		for_each_cpu(cpu, flush_cpus) {
>  			vcpu =3D hv_cpu_number_to_vp_number(cpu);
>  			if (vcpu =3D=3D VP_INVAL) {
>  				local_irq_restore(flags);
> @@ -166,7 +179,7 @@ static void hyperv_flush_tlb_multi(const struct cpuma=
sk *cpus,
>  	goto check_status;
>=20
>  do_ex_hypercall:
> -	status =3D hyperv_flush_tlb_others_ex(cpus, info);
> +	status =3D hyperv_flush_tlb_others_ex(flush_cpus, info);
>=20
>  check_status:
>  	local_irq_restore(flags);
> @@ -205,8 +218,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cp=
umask *cpus,
>  	flush->hv_vp_set.valid_bank_mask =3D 0;
>=20
>  	flush->hv_vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
> -	nr_bank =3D cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
> -			info->freed_tables ? NULL : cpu_is_lazy);
> +	nr_bank =3D cpumask_to_vpset(&flush->hv_vp_set, cpus);
>  	if (nr_bank <=3D 0)
>  		return HV_STATUS_INVALID_PARAMETER;
>=20
> --
> 2.43.0
>=20

