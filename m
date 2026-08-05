Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013078.outbound.protection.outlook.com [52.103.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D63839B9;
	Wed,  5 Aug 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951422; cv=fail; b=V8o6RfRTn4kJs4T2PzdrOU0mWYHiJUFBuSLH1aa3o/Xn+PcYinB3H7XbgP5BLN1NL0SQL46YssK9O6KWm0Pm6Bs3Lg3xpxfVf/+dYdKvA7xr2UGTXemNSQWoxb3Or7UvTXO4JFjeJQMSEmCh+tI8yTHJi4qtG9mpBPEeU+/Cm7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951422; c=relaxed/simple;
	bh=IvonBErXFrJC2SfxRNJX+Wwvn7hCxeKWXg2EtlVmsF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=urVk0AgCJyqMFdKRsil2wHMbwtN+dBHsSiMSTVb1UDxtfkFgQoQWnyIeDUMi9CXpZJ6ors65zQp6QLzMp0wLk9Nqj3nQvkaHfmxPNOhBT3paftEr/P37+i5JrwvXDg5w8hLbG7zyARaqHJrwxc+HpDw+2FjP7mzxzKA2OiIo4jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kJ84UXN6; arc=fail smtp.client-ip=52.103.7.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kJ84UXN6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKgMiP/7kzoU3dTsbg+mUw6GE0mqLpHtAy0P15pR5tQQUNrrAzxU+lHn0q62FzXbgGCwjM+j8DTQp4WxdBmtvgAljTeBajl8HmffJGms6dFIN/5+6DB3lpgIhiXcgDj95eEfnWBBJIqooZd8Akb8g+T6W32Azc2G5uZo1vQdfGITg6jfHVwj0YdCLG2Ko0A5WtQy1P9kka2bplKxfcWAtrwtG4mdQORh4wPoFFW58g8IwutXwsl5Xt41sokPWVQwaoLkaV6cUN5eu8kHdNfobJdGJ2Ong7SCX9snJyQoB1WEqWSXj2ieli2xtmyzNsAjbEG7F2Q71X2HkyQHGmKDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MADbn026VoFzVEcC0N96CCfjtgT/v/EDHtRJqPvaExc=;
 b=ebz90AE22bpu9Riob9hHVMQ8dVXrvhFiIeW2hlzJIlwiLhjUS0lmO2yInysoZCq+wpxcLqO78oabZWkYkPOsjQ4aibq5otbKKeSde8WX2cMfjK6pLuFqf5GH8TToNBO12lR4Y3bILyfg6H882bMosl1LEHWWvw6K3M6bJD9t9QjnlGLBKS4oPpZdRH8QAqjaXry+jTZkxKoBsfHLb+SHfMUculzrbrEx2IPfujs653eglJ1vz68Xbo4ZFLA2pJJBdtF6r5iqD2pmawUk/7mzc3pbaSL0I4xrlfb8T55GysB0gaCqRSIcxcmN8nddCeVF0wHP/bUlPsVNh96NnW90iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MADbn026VoFzVEcC0N96CCfjtgT/v/EDHtRJqPvaExc=;
 b=kJ84UXN6yulbS6/au+iirbjcOij7OaUhwJoZ3yCdfspEG+XCDpzCbAuQ65WWrBVG4hVtd5mbcT9sTuHuE92ZWOra2Jj3VixmAm5eIM4WwEuiHlMWsXSKIvlWB10DKb8HVsG0Ov/Slt1gHf5I5zT7v+lRbEtWcSEVnxdKJzt/w+uB+wJrhL8C2t/sdfk6zEIJn8LMAwYUp0+AFP947SjbyaR3SgHi4wNJHcZEjQLzXbj7jssEh+AWrFF1wT+Xipj3N1ytNv+EPpApSxYWgU4XY2bNA2CVBbrjJJ6d2hXcQ3UVdLsnDlX1zycaoarL/25dmLKLHuDjJESTz4k9ETGQVQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB9951.namprd02.prod.outlook.com (2603:10b6:408:18c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 17:36:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 17:36:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>
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
Thread-Index:
 AQHdGUstWmkWeQ5MbUqxHXCQQLfsQ7Z9FO5wgAr30ACAAiw0cIACcsCAgABwYBCAAq2agIAABMuA
Date: Wed, 5 Aug 2026 17:36:57 +0000
Message-ID:
 <SN6PR02MB4157446A0CCB6FD10E30308FD4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
 <20260721195633.1438361-3-kameroncarr@linux.microsoft.com>
 <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000901dd211f$b119be20$134d3a60$@linux.microsoft.com>
 <SN6PR02MB4157514D8AFB06FB6F2ED9BED4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000a01dd236f$2a24f4f0$7e6eded0$@linux.microsoft.com>
 <SN6PR02MB415720DFAAC7EF9106D5B684D4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000a01dd24fe$26f311a0$74d934e0$@linux.microsoft.com>
In-Reply-To: <000a01dd24fe$26f311a0$74d934e0$@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB9951:EE_
x-ms-office365-filtering-correlation-id: 65b488c9-b428-4c82-91a8-08def318262b
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZn9IFDOZRHBr3PkJ6iE+FIkRKMXo7bTFqCFAO4sGWGp1kE19k5I/lOXaA4+m/4BMJRgzIzPW3fV1NDrngoUXFzeBKQeRu2GPfz/PfMZdrUlTVS+tolOspFVME72p53XOAZYubiWXWB6Cx8D7RgMVbh/fUcEgcygE71Vsd1V0d3R2uYVR2xwOFZCPcx+7Mp/hFyODD+Fjr00uMHtiSnQVenX/ixLE1ldlPbtL9/NUaErDwA7bsUTKVQwGTHYTbJ/z5NAWbj7oTml4Gp1i/jLcF7+bnMG9/l2dpm2Lz1/IjHN5prumOiCaSJSH8LnCh5CM0CeQ01RZE4fnoEhRp0xXyDPpO/B30w6BNLMMGRko/X+CmiEwQVEjqRmr1ON20xYtIxZFw+Z9vTV2BxNP6i5+xyB9zWQaDlFg3Z7asvCMXvM5iC2ousM/+S+RSQGdq2A3mmuydQnbw9/6AcD9/qi7YEnXQpXpddf//r7/cT08BRJjcz7+XGcte2W9XFCbaaqUjWAjEBoMUeN1Kb0nvNP9GjHT0pJ0f9mnvVbX62r4TwmlMCnvj4/P/2yaibX1JHWuxTIr4UieJKujZIgwQ4N49gHCGxlQNS0SbOyRKSM3/d/cDNoU5aJwLK3e+z/sAL5kksrP7S8OU88tTFtahet7U3f56HggfzT77dBNfOtPgkkMFhBGCEGj6fbByxt65VdsPaOgivE07PBHmGDkWcDWtu0TGSOjlWvjKGyrlBN3klmudm0nypUwcLtyVemhI8HuxEbWoKOR/hzZELxrQDQzFgmlNRq4PGoYHTXdBBMiKGgWsG2hGjKOR8t
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|15080799012|13091999003|8062599012|8060799015|19110799012|37011999003|55001999006|24021099003|25010399006|13031999006|40105399003|10035399007|1602099012|2607281247196008|102099032|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aW4fRTej1/1oQJqHnXYO7T/NMYW7yDY4/tgjEx3q/QBI1k1sQ97VZIlSXtyI?=
 =?us-ascii?Q?Z28Jpetcobh63mweV67IXX1X+v3h4MqaPUVNqz8lqCxkzYW1W41av1dLvLBk?=
 =?us-ascii?Q?//bLD0faUCshURJEEr6+H34ogZfqXr7CabB1hGbdT9ZJ94yoU6/FwSg3FO/r?=
 =?us-ascii?Q?kwLL324ubHBJPcSD0R92Nm8yNJaCWA90re085obKufMsj9Li7HsyDeRlbFry?=
 =?us-ascii?Q?+upyN/1TsbzkXfinJwts/GoyUCB6rZO4EuothjZp4V2nP/XCgwLdEduTJYxb?=
 =?us-ascii?Q?/ERNAXxz4qdI/NFKQX6DLBK9O64jIyaKsiEp37wZshDyYXIXKGIFADqbWyeX?=
 =?us-ascii?Q?04rpsLAbSZ4Z+pHFPw0tACvW1XQEKhscmPF+3uEXsgeFIDTUoDeuA6X2yX0K?=
 =?us-ascii?Q?WWbauTLvKXCPNsT7HG2o7R8M7NBCardo6lmm31HT+/Wj627hqSSKSqh8Plk+?=
 =?us-ascii?Q?eyGJ7Fw+DxWpm+gjUM/rk8xs76tKLuVYTm3sV3O2c1keuNitnIzSMai5zBIn?=
 =?us-ascii?Q?ZdLoG8JgxAi1j+m1xiqmByS0ipwhu8SKn+RruKqan5DxCA0TNESKAMtFeBkL?=
 =?us-ascii?Q?dnvhOtKcKL2Y4RkSyBg61tT792of6DrsOLNy+eQgocl69h8b3MvGrytEFEzV?=
 =?us-ascii?Q?ZCOrPUjiF3VPTpkgLQ2044BriVpsU4BpBAVL/TxuxuUkRD8PTiIE6AschgJe?=
 =?us-ascii?Q?wpbTNQjRoDUBRxMMyV+L5uoYf9JB2G7ARdfCncLUCwljmSasgqgu9F5zJ+NK?=
 =?us-ascii?Q?cD3jMqGOEmBd7ibmDIeaEOYvV/KsGdRElbzrvLS0fGkiDV7t4Pc6lUyTlZGW?=
 =?us-ascii?Q?qGZnqseHt+le6NgVE14/ZRAcFrQjvHHdUk7BjTE+cAsFQ4IF1a8Tm53Vnz3L?=
 =?us-ascii?Q?xfCLAwXQw0Yht7bkC7wtD5EVfgqfeycVz65gEzwBNnCM7Y7y/6SUBdKMmC83?=
 =?us-ascii?Q?A1GIdkN+BkAKDLtRgDhHlAQ2hk8bD1O1Y5cCfyoEyJ+EyjUqYPJQyWWrIkjU?=
 =?us-ascii?Q?iNIjzMf8pWrJ7ZuH7Jt2eUPRublXSRD6Zw3xVaRojC1cMAMyrYmHoArC+QHo?=
 =?us-ascii?Q?nWjoCFEK8qagW51vOP5Jr07RQQoMW3/AnQnPJP9W4ID4TqojDpVuL0OrwzhD?=
 =?us-ascii?Q?8JCpv8qfpyOGZKDK/XSF10wapWWZfjlFqfUwe28xVmbfi3ldz1XabAM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mdsN1CK/4rdmVQ7K9yWCsBv9sAnY4hvAiycCUE1iEqdX/bzCBTdBuF4mfYv6?=
 =?us-ascii?Q?GAId+t9mP/vQkNk8uPTdBMBnWipa1StHXp17XbH0ZaLJlEju2I8jmiNyyoRE?=
 =?us-ascii?Q?5f5PS/l8qp8/eKtc7I4yLq4fEd1Ct6Fg159uj9AbCkdbwxKRahUGXEjUuojB?=
 =?us-ascii?Q?fpGJPbFJ9L+1LY/rA7TbSy7bivsyUoeWGTaCAUWs7EUhz0n8rHt2WOK/GUyH?=
 =?us-ascii?Q?S5n7icYsNyEUhTsnI5UzV3r306NnN3SFqE3L0Ggf3rJcLm6OzlyDRrAkoVQi?=
 =?us-ascii?Q?MMM4jeUU8s7omiCk2afUCFwZtJhrY7S+8+wM3gtr0C7IF9X7M37y6bClcR7u?=
 =?us-ascii?Q?KCAO7sOZ8qogryVP0cLfyGu/fIP1hefDX7DQKZhuxXSdz8ysZ1X9YtLbleYd?=
 =?us-ascii?Q?39/N6CeXuo+gfPqtV1WXwn7hReYb5I6wCcvmqwyKKoSxaKKwzcNhCQ9hijTJ?=
 =?us-ascii?Q?oJukSR3E9lWj/GQhkRjtXLhvKQRf8Jb+6VxZmwNwGUiUnV1MpIJZoEdV+BKB?=
 =?us-ascii?Q?7LGkmZFhdXAyxPeW27uyVYIfDV+kPOOqRcG/4IVpd264X2GA6wiBXyv2sJEp?=
 =?us-ascii?Q?rmNOvEWNud4UtpRi+y2cv9+GopBqdUucx92oUbM7ae/pF7AxJaYlCfspWJ3r?=
 =?us-ascii?Q?MYwRlW2BiajZGfgpAbtvth2gUujuzsK1RkyLAWct2IQZCcq5ojXzGiT5swk3?=
 =?us-ascii?Q?kqT3Wnb3xPJq9FyFMtgDe5hNgiCoijlgI/Ms2OZJW9XtR0VF+WQiHR5t3WNg?=
 =?us-ascii?Q?U19NUBEjaAlC10lajCY0+r9+jkWXJq5YL/G68TC4TKYeZhIHBvCXwJQ3GOyg?=
 =?us-ascii?Q?/GTQtT8xY4nDXpSB85wZAGde7HDXOJX/6t5PRQXLEV2/CbJmNXHH2Rp6etcj?=
 =?us-ascii?Q?V46NpuHZV9nris+AxJ1CDRIYGdDmRAPFnrD3iC+PcHruOK3mZNjZs9X/10a7?=
 =?us-ascii?Q?BJLchmkXGG5DPckKRtOKuPvFxBKijeUfRiwAw6VJiTD40wlf/l1dIbZkAPZo?=
 =?us-ascii?Q?6sDtR+BzpzG2FhbhHu9S7VYZIClXj3mnsNQGZWJJ50mFa2gLs/CJ4FYxzQg+?=
 =?us-ascii?Q?2sEwDwZQX1qEmRWfJVJqTqOgzqwI+DENDEgQ2durGOtuRgUAAESK+5bQZQmO?=
 =?us-ascii?Q?CEYco5BM6kcG0GmSm5vLJ9e5Y0IG01lMEgvjzB3oncHydXTlq/YC7UfeI6mC?=
 =?us-ascii?Q?e1o7LQOhC1B0rFgOCHg/44OQsCVATHskH/pBuW7EwVhlWdQX8nfiUZ/9KyFO?=
 =?us-ascii?Q?VNLwVus/UG08bHg3nsrT8ITv0vu04qhtw8UZHcV+LXRddWr/P3xBR20GeArm?=
 =?us-ascii?Q?376DbvKvDI41loK17L8Krw4OHReVotGIBud5m/B3AdOQ3bcwHne0wMWI1kjR?=
 =?us-ascii?Q?J/6vav4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b488c9-b428-4c82-91a8-08def318262b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 17:36:57.7801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9951

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Wednesday, Augus=
t 5, 2026 10:16 AM

[snip]

> > > > >
> > > > > Using min() compiled fine on ARM, but x86 is throwing a compile e=
rror.
> > > > >
> > > > >     drivers/hv/channel.c: In function 'vmbus_alloc_buffer':
> > > > >     ././include/linux/compiler_types.h:699:45: error: call to
> > > > >     '__compiletime_assert_518' declared with attribute error: min=
(order, (
> > > > >     __builtin_constant_p(remaining) ? ((remaining) < 2 ? 0 : 63 -
> > > > >     __builtin_clzll(remaining)) : (sizeof(remaining) <=3D 4) ?
> > > > >     __ilog2_u32(remaining) : __ilog2_u64(remaining) )) signedness=
 error
> > > > >
> > > > > In my v3 I may go back to using min_t. Please let me know if a ca=
st (or
> > > > > some other method) is preferred.
> > > >
> > > > Hmmm. I don't get the same compile error on x86/x64. Maybe it is
> > > > related to compiler and version, or the kernel code base against wh=
ich
> > > > the patch is being built. Probably you didn't see a problem on arm6=
4
> > > > because of some such difference. FWIW, I built with gcc 11.4.0 agai=
nst
> > > > linux-next20260726.  What is the compiler and base kernel info wher=
e
> > > > you saw the error and on arm64 where you didn't?
> > >
> > > In both cases, I built against hyperv-next (a4ffc59).
> > > On ARM64 I used gcc 13.2.0; on x86 I used 13.3.0.
> > >
> > > To do a fair comparison, I
> > >  * downgraded my x86 environment to gcc 13.2.0
> > >  * started with `make defconfig`
> > >  * enabled Hyper-V and NetVSC in the config (=3Dy)
> > >
> > > I saw the same behavior where there was no error on ARM and compile f=
ailure
> > > on x86.
> > >
> >
> > Really weird. I compiled on x86/x64 with gcc 13.3.0, and saw no
> > problem. This was against the official 7.1.0 release source code.
> > Then I grabbed hyperv-next (the tag "hyperv-next-signed-20260621"
> > specifically), added your patches, and again using gcc 13.3.0 I
> > built with no problem. Are you using the same local copy of the
> > source code for arm64 and x86/x64 builds? If not, I wonder if
> > your local x86/x64 source code tree is somehow corrupt or not
> > what you think it is.
> >
> > My .config file is different from yours. I did not try starting fresh
> > with make defconfig and then enable Hyper-V and netvsc.
>=20
> Automated testing is picking up the same compiler error
> https://lore.kernel.org/all/6a6dc0b6.1aa927e4.17d4bf.000d.GAE@google.com/=
=20
>=20
>     tree:      net-next
>     arch:      amd64
>     compiler:  Debian clang version 22.1.8
>=20
> This points to a real issue, not a corruption issue.
>=20
> I believe the right course is to explicitly do an unsigned comparison
> instead of relying on the compiler to allow a comparison between a
> signed and unsigned value.
>=20

Agreed.  I don't have any ideas at the moment on how to
further investigate why it's OK sometimes and other times not.

Michael

