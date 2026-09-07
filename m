Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011002.outbound.protection.outlook.com [52.103.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB562D5925;
	Mon,  7 Sep 2026 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817711; cv=fail; b=DJVowwRfOtWf6J7VirsuvgUCc4jp4RrRuMR9QM2C+mJXHf6+th985h12SQSwB3EyAqcyrB7LMWV9XcctLEAIfFchxxJZcuJIQrJgqWQz8qqZXWXR4UEn4XBMWSbPGk6Bs6J41iwPT0Lrhd0n5gGcA0fqX6JvvDWJRm4XktNTtkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817711; c=relaxed/simple;
	bh=NSai/LlDD6TI0b5djeO4znRniiKqbYCmgV9m7ckjIy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYfks8nO3GAtvimRbvAW0zHtyyWZ6oapf2moHzypXQjPl/rymrf6HbzSsRB1naszQIg1LRQAycsMkKI7WWPkANQstNN8l9IEl8HaW/2r2FU483SbQSbrO/+LwZqpDJiS8wVVuSPkasN5WTaAzGTOk1kacwpk72rEwxgHHfMYqVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZKTM9p9s; arc=fail smtp.client-ip=52.103.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZKTM9p9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov0RKVgFRxRcFwwovLtCFHb/+R0iz5HibOZfi9sKdIlIbtx/VcVjEuGDXyKule8WmJzhk5DoWEWiDEyNFtBG6iDL5p+MRpPjNliBqCD4XZJGJB5lspMzqExe1EsLvAyGemseFAQlmWxsvd7HG2XMTRRMeEy6VW64KzGSelRZBHLmkjBnuTdpUzfJWDhhxHmciR2NY702ZZcxpdSF3GKRHLlGxLP1FuqKEyuPTeCx40MZDl1bNARBJjoITJGRheDIrEvT05buwyBtVMXGPeB2i0QhzrvdFKiGoA4uDukyobzG/LfQZzOdwPq1RSf5Dk1ZDf4u6kXShC3Z8bDpN+byfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqWmF361GnO87QjtUUyHBe8y7bksDYmlBdISXg2T5Yo=;
 b=vZXExPUL/kIid2IHpCRtM9rD6nss4iOXk3xBaA98xKdeWugbuYLlgQij7BjSlHghD7mG0fGFCT3BWAW0RusxOS5JjGxmd/uN0GAj4LdXt0FycjcmL9KoNtblxE83NdFhj0ZLgYgUfnRj5k1rEYKZt3c0wN6L8cmKlE8dHVmF1TFMR5wzBJjdLYMQXIVX12/x+shliMxzhDk6fObdbtFZ2UOhyQZ3zNZ1ZzDSupWQaNATHb0Hx5bIU1pvznKvkUxNTmmwHy0M1InD8AwlRZZQz3/1gIGzBa2nsRaovr21Jtb3qQKA+8ELyQi8nAistn1g+xoeKCF+LZvYuN+A0fPLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqWmF361GnO87QjtUUyHBe8y7bksDYmlBdISXg2T5Yo=;
 b=ZKTM9p9s1VpQXYRD1WXkIn8JsqsaMCiwi0MnIHr0VuKrwCeGkYJCAo7HGf4CLkCIApb7CdBcA8TN/+SrRrCM2CNlK6SMunS6gjizsp7CpwWCMTU6vIcG+mWYKE/tefdoDtHnToxoO/VrtmBAFehqWP3SmQXXhrW8h2FwegKVSPlVb1O+K/QU8O0qdEpvpuKOMVO4YRIH+ckdriHZ9B8/JDmCOPZNGpFBVQgMyF8CIu9aANOKwVE2kWHnvbR6x/+21xpJhiNmo7iVUC9YfRS1e4lp13ep7Iump1Y8F3sz13u5YPustO3XPgRNvanao6NBQuvCaQyXdqJk8SkgpCI7HQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7169.namprd02.prod.outlook.com (2603:10b6:303:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 21:48:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 21:48:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH 0/2] hv_netvsc: Fix leaking of send/receive buffers after
 GPADL teardown error
Thread-Topic: [PATCH 0/2] hv_netvsc: Fix leaking of send/receive buffers after
 GPADL teardown error
Thread-Index: AQFHVm9dMeVqpqUlk7GE8NQ1Dm/qS7fvd6JA
Date: Mon, 7 Sep 2026 21:48:26 +0000
Message-ID:
 <SN6PR02MB41572101F40CE1EE8546B26AD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260903160651.1637-1-mhklinux@outlook.com>
In-Reply-To: <20260903160651.1637-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7169:EE_
x-ms-office365-filtering-correlation-id: 52c5e472-f58f-407b-15cb-08df0d29bf63
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8060799015|31061999003|13091999003|19110799012|25010399006|51005399006|2604032031799003|37011999003|24021099003|55001999006|8062599012|102099032|12091999003|440099028|3412199025|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iGGu1VO1At2VQZ3bgEBCMugKaCGyzPt06ZXuPgFbZcC/fV80FRYsUf0HyTfs?=
 =?us-ascii?Q?b4j788efyLkKD5+HHwEqUcnMZUBoZOPuKME7BT+17kSsRHLamHLmuRAEYIgk?=
 =?us-ascii?Q?AG2/X8O44xgkkmJCkx+VrbIrUHT7rqyi4dWDhnGvXJsL0nyTF5pUCrQYkRv2?=
 =?us-ascii?Q?iCV+f0YQcOXpMgo1PQnYrGuhHfiarFg9tYtp4EcdSVRhznJU0ipYPvYM24pi?=
 =?us-ascii?Q?3KZWpsLXz3e6WI+qlFmvTTydrqbBLs87rElyS7P3yLPel/2aShuj6KmE9xbo?=
 =?us-ascii?Q?/mBu8pQswEzPSl+W2HENA+bn32ez5mlBF7cZyUOBlFwOom1vVdgoRRDzevnO?=
 =?us-ascii?Q?5SamYcxUATixIKEdjUVNOHtjwH6RfcGBNkC3ifmUEpMZuP5pC9PWVop1tD3/?=
 =?us-ascii?Q?k+F1+rktz+sUkqVtR3d841LCdhOJlhwtWmGLbIB+H+v4iWIF+Xqb7GW2ktF4?=
 =?us-ascii?Q?jXmj9oTDgYupsve0wB1AkR/9tJrMsoxvnvG1kvAwzMcuGXzoZM/UfQDkkUvy?=
 =?us-ascii?Q?CjqzlUk6WWsrpYaFP+8Cuy6Y2fNWMxRlCmCJQ6M5gZH/WkOF0Vlzkf/cXmzi?=
 =?us-ascii?Q?IsZ5z7eV/a05WhnJze/WngoOqQjzOikTkZUhA/sgv85FWxYLRU7xkNuf2wkf?=
 =?us-ascii?Q?8lqbx4FaNrMiCbuqubzhgVMc082RpWA5DKWAfsfaiSBDyVKrK0oYsRK8slkz?=
 =?us-ascii?Q?Xfa16cU/jPxtCpEcGcjXcGlujj/ZFfL0vWZIfCvLe5CpGSCE+IwiRWfVoqyV?=
 =?us-ascii?Q?i73NI1H3/onP+5UtyGP/EdlbYUNELoEYyZtnQKqnIjD5wUt+4WoZNHSzw+v/?=
 =?us-ascii?Q?4kS4M9RWi50vEDAZOfS+3GfjDAXN/wkh/evm+FHIMSJ0qqFyvhYX+1JNJAE9?=
 =?us-ascii?Q?kMmune2EkeUxXdNE9MJ3Ie42he/Wqi49QZ8iQzjn03sSODAEbx1Jmi9ApgG9?=
 =?us-ascii?Q?VPmJ/6nvJqdxOBZuaadMCPnD2D4gDeEpdtja6WFpFKZII1NdqTfVnzqfcUOY?=
 =?us-ascii?Q?oR2SiEdgm3ugCpZe/LchwF45gA2rJVfHxqyNCiia18d+5tSmI+PPG61nm2pB?=
 =?us-ascii?Q?1Vcj0B7c2EWvDjIAGnFTtoo0d0WCziknWAdVvylvG6OnSx0s7Rc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kpkAOj822iGntr5pftytjc4H1Ot2+5muZN+b0JYUna8MLvjN5K/qCnZ/30N/?=
 =?us-ascii?Q?RPfSCTnJYCGK5xeAGDrcn98iwKt7DDt6HgD2po9PRyzpo0P5b2r5LHhRwmu/?=
 =?us-ascii?Q?SHlVcuhlHHHUTPlA/Dvbjh81b+xOh5CALMiXxfD6crIvQDm01cIaKVyTVSWj?=
 =?us-ascii?Q?gXYA7fudD0LMUKjjjZfuIkmNHFVKdV6SLh6QHHLXuxH06VtZIdvaM5wuy+9t?=
 =?us-ascii?Q?as40VxDd5YoModG1D+PLzbQp86/TeuTaNG45s3FABdd9qj3RQUz1/YIJXVvC?=
 =?us-ascii?Q?VNlVYoOa0m+BYR2pwkQrtLw7uf/r77bL4C0WtmEdla2Cf1P5R1C7nnF0aWOL?=
 =?us-ascii?Q?XrcCvO8p1Np9ELPQt45Gr1glVWIcqG35Cc3COIVZusBrNca88Cu+e3uUfBRU?=
 =?us-ascii?Q?Fms2HtTAgrFOASGektVoQhp7hlNN4pJl7/PlDKR5Zg+bm7qKeGDvo5IeQvJb?=
 =?us-ascii?Q?2ZDelRj70IFQCaHu+R18bmcw2SyD4Au15XNhB8e1TbPVFg+b2NSEaY3MIIxw?=
 =?us-ascii?Q?2ReLFc51QvroKD5QsAs1F3z88Nth6I0YBcBT1QPqoAKfat7/Fs6UQqgnIR5c?=
 =?us-ascii?Q?4J4kON1FHRVdj3iDeSnOfvIAFZk50FqHkwtPf/yzaqPMEjx+BaBHv6xSSrt2?=
 =?us-ascii?Q?8jSgdO2aY11zAIUCrNZ3NHYFh5VWPBn655GYx3zje+TErpYC+jMc+WgBO9YN?=
 =?us-ascii?Q?m+BuGh4vQM0M7YMqGQbnRyDEvBg3A4irf0/sia8TsO2p5QbmJq8ZpoxuEctT?=
 =?us-ascii?Q?SgHB9LbHmojuApgc+RWwq7hqe0mSH+GDbGHVy1zpJcSh+vAUg0jNSTFcvmb7?=
 =?us-ascii?Q?/S9kQQ0FluCaWEr6NQu1nZzNgyFMoGdexccdW/sIS+pgqTw02aLXErL4ooXV?=
 =?us-ascii?Q?oilWOthF51cbF0KRhccLEy2+DzAIqePQZZhcdKgWV9/YAo+ar0yw8NaN6Tkx?=
 =?us-ascii?Q?mBctaRI7BXapD0q3alz/ZNA7T8jbBsj10c3H+wHMAwq39zpq3LVJlR3r69Oj?=
 =?us-ascii?Q?aoseZPfy0SvJxy/gRDg6lgjQsTs/encHhRlex4e5AGzjnEBfQUSNgjuGP0G1?=
 =?us-ascii?Q?5NPk3noe4BLaaCOB/hbKCEcICBqTkxwr9odvbyE4gC8/JCRStQRkkw4GUQOs?=
 =?us-ascii?Q?J70ykoaI0plcONvOQqP7s3LnqX8ztgwAJqxkEIvH93xtbPlQVqitKUOp7IAU?=
 =?us-ascii?Q?4hzlVzBssEg3S2YG6w+KpgWKoEEo9w/gDt3s+eThEoyb6YH5sVttR4BGuDs0?=
 =?us-ascii?Q?SCW676p5OIqFnnL6DxOhH/cMs5eEgA4aZ0CjDO7C9ofXTqwkwLLO+YKVRq4L?=
 =?us-ascii?Q?tggztTWOB4u/PRPqzjqC8PkfkDdTB8A8HoN4C16xu8SAwa3uFfRVtPYNztz2?=
 =?us-ascii?Q?JXpSkaM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c5e472-f58f-407b-15cb-08df0d29bf63
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 21:48:26.4894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7169

From: Michael Kelley <mhkelley58@gmail.com> Sent: Thursday, September 3, 20=
26 9:07 AM
>=20
> When a Hyper-V netvsc device is shutdown, the GPADLs for the device's
> large send and receive buffers are torn down. If the teardown fails,
> Hyper-V retain access to the buffers and may continue to read or write
> them. Consequently the buffers should be leaked after such an error.
>=20
> Leaking the buffers used to work correctly, but was broken by a
> commit applied in the 4.16 kernel. This patch series restores the
> correct leaking behavior.
>=20
> Because the large buffers are allocated with wrapper functions
> that allow allocations larger than MAX_ORDER_NR_PAGES, leaking the
> memory is not as simple as setting the memory pointer to NULL so
> vfree() or kfree() does nothing. Patch 1 introduces a new
> vmbus_leak_buffer() function that causes vmbus_free_buffer() to
> properly leak the buffers. Then Patch 2 uses this function in
> the netvsc driver.
>=20
> Michael Kelley (2):
>   Drivers: hv: Add vmbus_leak_buffer()
>   hv_netvsc: Leak send/recv buffers if GPADL teardown fails
>=20
>  drivers/hv/channel.c        | 26 ++++++++++++++++++++++++++
>  drivers/net/hyperv/netvsc.c |  6 ++++++
>  include/linux/hyperv.h      |  4 ++++
>  3 files changed, 36 insertions(+)
>=20
> --
> 2.25.1
>=20

I will be posting a v2 of this patch set that fixes an additional
bug in vmbus_teardown_gpadl() that Sashiko pointed out.
That fix is necessary for the full "leak on failure" scenario
to work correctly.

Michael

