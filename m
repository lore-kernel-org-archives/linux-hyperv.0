Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011083.outbound.protection.outlook.com [52.103.23.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B9368282;
	Tue,  4 Aug 2026 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802956; cv=fail; b=bxx1Hge4JhYCxDFpMj+7zufzhUkHfpWeGChreQ5z7D9fAwa6h7jfCaXBmfjdmTJHtFe7YiJ9n3AvjbW28T9t1JUhbELNFwm89GO/khQV+7HTHZ/ENZgu3bQLH5f4YByl91h2Cxbe4P6nqlUf3+eTBMYPCzkrFZtPCvHxwbfTH4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802956; c=relaxed/simple;
	bh=Ya2VdEgvuC3vUHbWLBniS+w1bi+exdwIGjfyD9JhWSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LFviwziZdAeB5bk4gG+0pEFILRGPW0MgaUJh33UiKcjkTCkqdweOB9bfQPf+gONh5v6uewm9/Iay9IM5kFmFCssSSfeoR7lQ8wZjeK/oQ2hkWBiV0RZofXl7NKV6hf5yGXXhewzwthXj3ASYG1fvGTl9GGckch57gPZXEPsaHls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J6QHMpGs; arc=fail smtp.client-ip=52.103.23.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J6QHMpGs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz82wbWEJ3fWPKMJtpptCZjlP3dD3OacVB72dUquZOjnMSOUj0TxZnYiLdtXydiFBUsJcEctOhwekqxrSX3+BKJRYfYiIyKKWCm9/xqQWlPen3IAmOu0u6N0unjkPL/TDOR/+cltKuuVmzJIK1+jBoNQRq1NHda/gaH/tUq3a6NwH2cXDCej3rsqR2fzAjzhuz5Tb8g2MPxQm+RQxRlLPzDd5Lm72NEk5lXDA9mAmrQRcy/RJ8/5l3nG42P0J7fey+5OQvu1ACkFXJollMwCXaTZBM8E52OiPb6/QwNMfpia0oDWfpkPVUF39pbvL7FTsWGMyAKkEY33kqqiAE3txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDuFe1XjQW4I4cb4bEHJb/lqbSFWhOXeVJqvvUvjuxc=;
 b=I6BL3hF/RLPQnG0IWpN3CPA7Pb6u+OhjnP3suFM0TzI1OshbRmQTrreX6x1o984V3rPpmvt1efOc9nWwrFrXBvtSQq+JBKLPw3cy05Y4B+mR4BLqJ1/aj0M8qf5TpjWwXTtkZGfJ1BTM/eG/PWRGcLwUQiAhZmdluw2GlzPGB8sJAv82NWU7Bexfa2GVBMF8FaqLcOCxuhwYGbtGG5qfC7KHqNiBXSGW4HSq0xXXmgKiSJfktTenwFlq9tkv8kqB1vCSXTFU8M8619vhYK9OENPK0/ie7rT76meiAs7yI6RqvICQvSf4X3Fss5NAYR84flvxM+8j40UAVk8QieESQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDuFe1XjQW4I4cb4bEHJb/lqbSFWhOXeVJqvvUvjuxc=;
 b=J6QHMpGsnCUAir7V2fhJbpb1XQg7cgyNFDUObQ/AxH4XF3SyWWu09UBhFQheaetGa58ooS69UikodMSCocjMbEG65Tvsdq1D82+UmMqraBugoxBlat29seiY8TfKvgFepsT5KtN5kKbRoWr1uqOG3GVtvrIohxPS49VB6MZbgX8uU4SNYnfmg9PFM7sKhh96lCGWQAPN12nG/PGaYv3vVf3LfG0lzY3rFqgkNVgABfm3liAEEPQp96rznd/cNIAaWEDO2yqIFCM+5/xf06LvjTOcdE3C2UY3VwQaOWrnONvy0fguQmq8WjjIDfB5BSqz8MG6OkUOP1HjbVZwZZvDEg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB7898.namprd02.prod.outlook.com (2603:10b6:610:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 00:22:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 00:22:30 +0000
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
Thread-Index: AQHdGUstWmkWeQ5MbUqxHXCQQLfsQ7Z9FO5wgAr30ACAAiw0cIACcsCAgABwYBA=
Date: Tue, 4 Aug 2026 00:22:30 +0000
Message-ID:
 <SN6PR02MB415720DFAAC7EF9106D5B684D4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
 <20260721195633.1438361-3-kameroncarr@linux.microsoft.com>
 <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000901dd211f$b119be20$134d3a60$@linux.microsoft.com>
 <SN6PR02MB4157514D8AFB06FB6F2ED9BED4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000a01dd236f$2a24f4f0$7e6eded0$@linux.microsoft.com>
In-Reply-To: <000a01dd236f$2a24f4f0$7e6eded0$@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB7898:EE_
x-ms-office365-filtering-correlation-id: 3a0e113d-77b1-40c1-2b84-08def1be789a
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|37011999003|31061999003|24021099003|25010399006|8060799015|51005399006|15080799012|13091999003|55001999006|8062599012|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sQ5xLIN57JuexdONDSiYgLo5lfbF2DLSozLSZeXMBHi572w07SqJLzGD/n0d?=
 =?us-ascii?Q?1TTFxbQdVSZ5Cn61U6gy+uglZSBx2J/1+ApQoAetAZes/RDJE0VW0ysEkm5u?=
 =?us-ascii?Q?ydTp8pLvrG5I0Bloq+yph9d+rjoLy9W1JqntQ8Qg5JuceoP39grLsDorv8QE?=
 =?us-ascii?Q?CbVf2qeGKCyEAzThurQTL34dHfdxsHa7BXvEBgRivSOvPCIcTC9lJ5G44zZu?=
 =?us-ascii?Q?WEwdKmZUJPgPI3rSj004k9mFEy7XqXDUcHvWitDciE9VoAFWnlwwF3xiI2rM?=
 =?us-ascii?Q?PaWCZ8dHMmYskG4AlprVEe0bGk5+3PxwB3V29A5Y0D1Zl/2NeiRcrY+ho+en?=
 =?us-ascii?Q?SSSdrV4jRSqO0FmnIzonH9jf4shSeet2lH8tiUwMUdmr5K8Mh7M4LpTugZV8?=
 =?us-ascii?Q?WMgbr8iba1rbeNPby6Ab3F7uaMEq0cgmAqmbLMC8/CYXf9RWTGjF7Wb55W3W?=
 =?us-ascii?Q?sFKMZucPo+/dPe9tPvBb46Mk28vWMGvN0QtyuZlD4KHerTfENgRv+xL2DtxD?=
 =?us-ascii?Q?pXMRxEDy798jJFVfJnQQ1BfOQwj2r8LWLBIbYj5B2SfaN2KcJuqaPW++CM81?=
 =?us-ascii?Q?KhWlAjx8hr0uIkTJ+CaB5s6kpprBaAWudBUE9oszSniSA5XgA6LDV3lxUNW9?=
 =?us-ascii?Q?/zbCfgUX61Zlr3YFlb3Mpq1X+WHP+WhuV/2Lg2CroAGhFsxIDHzuVcrIS/ZJ?=
 =?us-ascii?Q?9u+mglqkxNzzQm8/HaefGFS5nmBgele8MjDIYudHsCXIezv6voWNJh9xtiA/?=
 =?us-ascii?Q?VYn8PaQ+lKPgCupfbHmtW/Naou5+YWIZU60SJHzbZIL9QP7JS+6GN4mBLFud?=
 =?us-ascii?Q?ePwNISVOZuneWNY3bWrGKctHokw1HqcBQsWlEq3dsir0pIVBlxL0X9Dsfcym?=
 =?us-ascii?Q?KvZk8egyD1TbuVTvjw6giRkgWWszCYx7EXpCAnG1I3VHGL7xOT5Yzv5SloJ4?=
 =?us-ascii?Q?q/Bj2V9f8TqpOoYhqyNVVHrZdD0+2PGlbLIYOSiCZpgkvTjXPHkWPhLzXXMg?=
 =?us-ascii?Q?1qpvLnnC/iFi0YmoE/t2JbFrxS0ZJtned651rm+2usBt6xjVgtHtIK4Tr3FV?=
 =?us-ascii?Q?fHoZmwC9?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WGVWIpNaxc2/nsz6h9Yqo97qqCAHLwN/RS1fGx+zT/oWROtcIBKr2ZHbDOUs?=
 =?us-ascii?Q?GoyzSSAZ/E2jcB8C6GhGPp9oopkRhF3apipH0Jd13Rm1JrCwl3XPIg4CorLz?=
 =?us-ascii?Q?/Sn8C3lw3QKLfv0KVtq7rPiOF9DGWnj0pP1MmKnNvfKvXIr5xi3ysiOIK10X?=
 =?us-ascii?Q?jsMUs02vsmo2F5dhTCcMXd0YjFp3KkdZJJhk9g7qMd9bgQdrTq6dxp1jksko?=
 =?us-ascii?Q?6YkULha8cKbEKH+XiDtT8ck+ElYAXRSwHfbW7/PWtSXEEQxcSRVklBYszZZ5?=
 =?us-ascii?Q?gBP7KPhYHoOLBxEaufKVSD3jiyDVaxC0q4IzoSbgJunFacyrj9WwNGtOiRAC?=
 =?us-ascii?Q?auNwNaHeLkziaypqFs6wr14caS2hKKvLDaqckxQE5Pv4hgetDZJTAUMO8NQd?=
 =?us-ascii?Q?Hj+8nBIV/hx01//2d7ulCm12xS8MKsYBTmEGaK/vNyBC2mta2o+zBUxp04lM?=
 =?us-ascii?Q?xe92wVIzP0rDjzqcIv16vrLt8mUsdZF6/emQXFS3skwOIbYRv6nLY62UlYof?=
 =?us-ascii?Q?UcoSUKFI8sjvAntIVRfTMgoSJvKJmAlFXETBSiN4+b3SVxd68rJhBvSOwNiW?=
 =?us-ascii?Q?DWjL5O0cBNUiowmPRWHMPpta8YXdgyRTcNC8jeZY2OiLR3tisU4yS0+remRA?=
 =?us-ascii?Q?a55KQ5d6XP4VXUdZeDAwNXX3Tun5rUu1o66ekr7uqSDhhlv3mxtmljsodfX+?=
 =?us-ascii?Q?6CL6L7V1hBF0vPjfPlAbbZfa8jQh62gyfVhuLQMpBZ1jhXznTXoJs9VOcJF5?=
 =?us-ascii?Q?k/W0vKjcTNfUvYmeIKQzteDGIOhMvF20TjZsk39TEM1AiLjlWIQNHH3MP2fw?=
 =?us-ascii?Q?GFcgPmE2b4XlgXxU0feAlg4UOkEcsqypbp+hr5zR8XQK/JDILbIfZLyq0v4D?=
 =?us-ascii?Q?aTTlyG66IznppNXBkfW2QTquyjLPCIx/4Y07p/XEH2FhQLrhHW6pNZnUjK09?=
 =?us-ascii?Q?s3Xr+VxVhqceBpOOxUrfCh5REfGli4syC/V+eRdDrEdy+WDL6BwkJOZR5XBd?=
 =?us-ascii?Q?YWxMw9TEtjHMHlJhKhr15/dy3R83B5DgT6nVCmrDOqGuUAD9irgRYFC8n7GM?=
 =?us-ascii?Q?L5d1DoFbMwW5+gG0j67Wr0uQycuMkcNOovqvVDbR5WTfy/tvY/KNOZixIbwq?=
 =?us-ascii?Q?/fjgkBHOv0DKu+SO7PuGpVoZ2tqCGmx8ofxPbbW327KixP7F2ZVMBQ8EJiWm?=
 =?us-ascii?Q?4quhTBEUalyU0EJrSo6EH/Ugtz8uOPEASyzkn7/hXQ2cK7iXHHZx5ivQN40y?=
 =?us-ascii?Q?WHoEkuIJz/OGJf6fR4o2qRIc1JRNDXNkps2XuyvfKfmGIIAHnrhxLZ/2Zy7I?=
 =?us-ascii?Q?DvOkE9C9NqVpriKP8+Psk6IiBjWFnUgXYtiCHBL0TLSa5bwPV9ueRinCeF4k?=
 =?us-ascii?Q?aKNj6BY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0e113d-77b1-40c1-2b84-08def1be789a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 00:22:30.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7898

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Monday, August 3=
, 2026 10:40 AM
>=20
> On Saturday, August 1, 2026 9:17 PM, Michael Kelley wrote:
> > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, July=
 31, 2026 12:06 PM
> > >
> > > On Friday, July 24, 2026 12:37 PM, Michael Kelley wrote:
> > > > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday,=
 July 21, 2026 12:57 PM
> > > [...]
> > > > > +	/*
> > > > > +	 * @order monotonically decreases across iterations
> > > > > +	 *
> > > > > +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing, but t=
ry
> > > > > +	 * harder at order 0 since that is the final fallback.
> > > > > +	 */
> > > > > +	order =3D min_t(unsigned int, MAX_PAGE_ORDER, ilog2(nr_pages));
> > > >
> > > > Prefer using min() instead of min_t(). For normal integer values,
> > > > min() should work correctly.
> > >
> > > Using min() compiled fine on ARM, but x86 is throwing a compile error=
.
> > >
> > >     drivers/hv/channel.c: In function 'vmbus_alloc_buffer':
> > >     ././include/linux/compiler_types.h:699:45: error: call to
> > >     '__compiletime_assert_518' declared with attribute error: min(ord=
er,
> (
> > >     __builtin_constant_p(remaining) ? ((remaining) < 2 ? 0 : 63 -
> > >     __builtin_clzll(remaining)) : (sizeof(remaining) <=3D 4) ?
> > >     __ilog2_u32(remaining) : __ilog2_u64(remaining) )) signedness err=
or
> > >
> > > In my v3 I may go back to using min_t. Please let me know if a cast (=
or
> > > some other method) is preferred.
> >
> > Hmmm. I don't get the same compile error on x86/x64. Maybe it is
> > related to compiler and version, or the kernel code base against which
> > the patch is being built. Probably you didn't see a problem on arm64
> > because of some such difference. FWIW, I built with gcc 11.4.0 against
> > linux-next20260726.  What is the compiler and base kernel info where
> > you saw the error and on arm64 where you didn't?
>=20
> In both cases, I built against hyperv-next (a4ffc59).
> On ARM64 I used gcc 13.2.0; on x86 I used 13.3.0.
>=20
> To do a fair comparison, I
>  * downgraded my x86 environment to gcc 13.2.0
>  * started with `make defconfig`
>  * enabled Hyper-V and NetVSC in the config (=3Dy)
>=20
> I saw the same behavior where there was no error on ARM and compile failu=
re
> on x86.
>=20

Really weird. I compiled on x86/x64 with gcc 13.3.0, and saw no
problem. This was against the official 7.1.0 release source code.
Then I grabbed hyperv-next (the tag "hyperv-next-signed-20260621"
specifically), added your patches, and again using gcc 13.3.0 I
built with no problem. Are you using the same local copy of the
source code for arm64 and x86/x64 builds? If not, I wonder if
your local x86/x64 source code tree is somehow corrupt or not
what you think it is.

My .config file is different from yours. I did not try starting fresh
with make defconfig and then enable Hyper-V and netvsc.

Michael
