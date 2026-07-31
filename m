Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011031.outbound.protection.outlook.com [52.103.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85A3EF0C8;
	Fri, 31 Jul 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512800; cv=fail; b=oe+wa7KOn3yXaH9VOnQ2TR4ja5BPlYU5Mubc/g5bQ+jbyqHazmv7tn5Od36ZaqHDQfMSUrXH8ujI8AcifKDn6mfAYsIa2XLFhrqaXVolYhhADNgmNK80X/fxlNfmMyiOujWQmpOATDGxq7F9krrZY3p3INv9rSjhXn7aGldgOO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512800; c=relaxed/simple;
	bh=fG5gU79KWc136eNW7sVbXOUMUM2wM+AF/3JFlIAFbqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VpHCcPBmm0WoMJI4TSfOu316ntwJ9tC0+76qsRd982VCtbv7jrFivTR8x65+S1meKePQoN9NPDP+31eZWaZDTr03Ol2KShkxbQuoK0iG8IzqNoZUyLKNYYIKG7YbIiUvwltDEOOnMcwkI2qzugV6qK1i7bn0PA/MDodDTjSkE+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vQ24lWnh; arc=fail smtp.client-ip=52.103.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vQ24lWnh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t15lg7W15yOyuR+pZVjJVCiz8At4KInY7kxDMehr6g3rRr8M5U1zHmkubJEYJIMU2xqPMz6aNnToSMBcJXDG9y6qZpTfXdybyVyT7OmqURSAQDw1HGCwpEcgARefMFSgJ//nhqRKsDjedxsyq0zZ3yK+w8IiewHTBHhO8izl3sOJMX+fidZq205CCf8Er0ldHCi8AOOG+VvO65XNs/HKidqHJs1K1KI5NQ6L1phweATwUh89fS3C0vpEA3dgtIa4+UK6FMG6XFyBh7rcxCcuse3GLoU9w3iVABh485NVaSXVvStUl2YC+wPGtB7URlUJcwY/z45+7MQqUkOUT0cggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKoQmRMVSvtS0lNYohKHZSS0dBAmE5P9fhrtFhdTLzw=;
 b=dTcIO1ZqmXxxJ0H1OH7yTCexOwVv4+KE8KVOaAz/XN4fLsSUH1hBhG/lQvcAjXyu6BCEAraRZqtj3psU2e9kNdZFc+AsPmKHorto2CKiS4UNvQeT8tcajBxPWF4YBhMmnOYVUUMxmR4ibAQ+u52/+KJKlD/NpDjCYd/v7KaTWm1ukCn6Tv+P0eBRC1KcxurpkpCNpbgpaFvNmQZuOBkThsK044H1ZtuaN9W/E6xZsvnvFF6TsE08s3eN51KHlsFJA/OJcDAHsw2QF7RYjMshUZJtEyiu06OG5yEjpkyEmJf2s/s6FGLnzeE5x81L7eEz57Pbz43f+NRzL3tXfoBItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKoQmRMVSvtS0lNYohKHZSS0dBAmE5P9fhrtFhdTLzw=;
 b=vQ24lWnhuZNkhrN3XXq6gfbAf2hhBUF+BWbOCfbQNMTnGcm2V7lXmDG5P+cr322OofxF5G430C2VaM2u9cWic07wwh3agcxE19oSsba+cMSlq9W3DAE+9hJuVRRSsOAirni6EhjtYgoA8nO+BOJGT8WMJSEOho0tcAsZxduvOm786muhX25pMWb/qbnm2F+PW96c0EF4q9weTIJ0NN/Hgmi8OlZF4V03HxS3HxMqU7x5+SLinKNii5ljvGOC1WmiUA4FdjlaOqZMyISCFPeq0wvqqc+Ii5f3XvlcER6xq4Xq1UYVF/UkZn12x5mIcWW3nQjGZ5p7Sn1ew0PxOTTGwg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9465.namprd02.prod.outlook.com (2603:10b6:208:3fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:46:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:46:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Michael
 Kelley <mhklinux@outlook.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] hv_netvsc: Allocate host-visible GPADL buffers as
 decrypted contiguous chunks
Thread-Topic: [PATCH v2 2/2] hv_netvsc: Allocate host-visible GPADL buffers as
 decrypted contiguous chunks
Thread-Index: AQHdIHwAygH/b4GY8UuKRqN3wt0GTbaHxo6A
Date: Fri, 31 Jul 2026 15:46:35 +0000
Message-ID:
 <SN6PR02MB41576627C0DBA40FA8BB49C7D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
 <20260730233359.3850612-3-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260730233359.3850612-3-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9465:EE_
x-ms-office365-filtering-correlation-id: fc4a69ac-8dc8-489c-312d-08deef1ae6a2
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vR9zmqRIbV2msFsVb/bKGJUXW7c4F4sug2/Mp29cpsjRzmQVEqBxfvK0l3h0A2P9V2IIZvt8E8ztdy+xAfYAqZoowFrJYQMh+/vAEKvj0Y1x2DEmceWTjNWM+tJm0IGu2upgd8hS0DGs4QTwHOYnATNidKaghuH5ea+XvG9SnFC1kHDYb+B3lkzgTgJ27FYviTSVWKe6Pjrq6cJ6al02Zvqjxd8p3o7rrcLVscF/aao0m7hVnbEYGX70fvuOpt38X7+JpJurL2B4logUwhIn5qBz4yAzX5uYOyna544wh4lh1BoSO+r9LV1W8qwwVhPYEcEEfCY5Bhk5DybcCFXpRedW/ANcITcKeNnKii3wcUxfScOsQWHePK/terem3v02RZJglTZa/j3zTKq+bV5prEpk82SUadicLJEP6MAQtS2nILo5lCBqTbJ5hJtXWXtp+v/lPA/W10QF+m09l5lUU+nalIkyLtk5tz4bVqBRyM+dbMVO6ZbkDRX2uhCRAPem/Y0ikW5Z/AdYxDoLfrM04N8Oa07gRq7nIG4xC32ITI+Ss/6KT9lrsRydTSzWr/MqM6v5m3AD6liPV8h/hwIOig+DRlVPtfSCeAR59RR5xDRUg9s8ka5Rwu7Va4h++KBru2ps9niF468qN4gol6u3XapWU1ZfJx0MQmeQigzSZMwBr9dk28rvTRV9fjulGg9wx5Z5BYzkxubCgXU2zRSKa20inHyw6f1e0W4wFcS+7V53Y=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|51005399006|13091999003|41001999006|55001999006|24021099003|2604032031799003|31061999003|19110799012|8062599012|8060799015|15080799012|25010399006|40105399003|2607281247196008|12091999003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?78b9jE+TdqhUmFlmAbd9Cw3gLNyq/JksCtWBwWWJ8G5G44pWFh8hhTLUWDc2?=
 =?us-ascii?Q?X8i7BzTZUnMwwt/fSlYeZKQ7rvhnFyyzv4daDlhdsTnayRaJLknNZpTGuFO2?=
 =?us-ascii?Q?Aa157fuioNSN8Gh3PwMpWhbUb3cESiwA8b9CO4jvjzTBDDG+sPOQaj1wRPyc?=
 =?us-ascii?Q?TweebQbLa7Bsg1nqICTDNNOP8ZE+NJevXYFvGkalZa4MrxpX31/mSdA6NEBf?=
 =?us-ascii?Q?GbqKNUnHGFwLfz3qIbywMYNiaH4vULDeKaqZ1IKpob5eUAiKIAqE9zzveuHi?=
 =?us-ascii?Q?PjScDBdWQz/ggQgHgcFYxdrT5idABvxUY5oHAaPpnpx0Dh+o8m/u7O/OswaD?=
 =?us-ascii?Q?czjRa1UjYKg3jSsupcjGpg6wTY4iJyHF7smQJEoiHz8GvDC1Uc6V6ShN9EXy?=
 =?us-ascii?Q?ZlDectKfIonS4JLyyEjL/IxLIwkVHYX5iA1aufEjc+4QX+zJ80ORVxX/COwf?=
 =?us-ascii?Q?/7Z8GAs1kHlMKYmTwx/0+6vJZFgr+mwK969Fwsn07gOEKXuzsgkcC1saNhIv?=
 =?us-ascii?Q?IFY8tXO3/1S0X9r7QhBHl7KWnXNhGZaxHDaz/EpU3Hq6Ket330RakMMjjCaU?=
 =?us-ascii?Q?LbpO2X7jfr6UZGZp21Jet0wnF5TG1tdZweJAlJYRyL33adA+B2OV+2CeSgXr?=
 =?us-ascii?Q?WTh2tx6PjrdXvQwoYpiiobo2On2OSJaDgeGLOU/hN2Lv2lyn4oi6F2hVRY9Q?=
 =?us-ascii?Q?einz87L9/HojsSOtm6j/yAA/+Xh8S+CCx6PksRpoyQbQwiBIA6LQk2xLITGL?=
 =?us-ascii?Q?gtKyB+IC3T9eeIKMaru599YgMGGhC7nsEYA0ahrJQGkaAQDtDbYEInke12xM?=
 =?us-ascii?Q?ijmyr6qj/TyFUsrc5jFHA3lL0+rWvx8TKfc/U1SC+itBoTBn2Wd71xKtX/mS?=
 =?us-ascii?Q?gZSCHwD2hss23jVNhRzrnybbQA/wp7UzWwMxHTehawkPDO5cjIFxqiAk58q6?=
 =?us-ascii?Q?RY048uKd9CPWAeG6WUwF4/rZosGR2Nw8Sn5v5LWNBdqll9zRoVzSuq1C31GT?=
 =?us-ascii?Q?NdxDLeYc6u/N4pvLwnWDwstI4fnIUiFzQ+siC080KcanIuNyMby2KDRfvU+S?=
 =?us-ascii?Q?Vjgowy7t+IBrmKm6gSGLMdcSyrzvihYP4Dk7tPkvoSAVgItuIVts3hNot7gy?=
 =?us-ascii?Q?tlWBQK57qYpdvnb7aMYWkj/lEhxgxNjfNubvqFg52UaVs3gfLGzVOC8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7kmuwrnl+FXnSZIqlK8u9o3eAAQKAcsv/KvsImBF69sL86agAcuifJvF/Pik?=
 =?us-ascii?Q?ymrPi9gyYSXx1Rb3jv9I1mT5K7xZsdDBEI8vADeIoGqybq02R5v9elIZlBg4?=
 =?us-ascii?Q?Ro4AqSp2pHoZq4ZpXJ/zvkM2jw/o99JRp4Y8MpSvNaoeKta4hAT5eLTAFPsw?=
 =?us-ascii?Q?K1Cx77QUdMtJFXOxzn1s2Uu6aqpp7h6Jip1RhhsfGWi1x+QycnPuYFCof6FY?=
 =?us-ascii?Q?i12Cc5wgjFbkOu28chZ2d3h37eWU6rr4KKTH6S07AuPtOTe3yElJBnIGtF0G?=
 =?us-ascii?Q?mhA+4URMDQvrMBHdatYti63mB1V02ClH8bTqh/cHaQhZg9Ri1+nStqB4vOCZ?=
 =?us-ascii?Q?imBchB0xaJO+Vm8bNEsraZOvRFqTf8eMdnS8I5Bx7mFNA4yBMgo+adiC3XRe?=
 =?us-ascii?Q?C+CFFc30Vb1X7+2l9O4PPeXetkrIwLG7wPS2yxXy81TFUKHux4/UDqjHl6C+?=
 =?us-ascii?Q?HqxkbNho02Z/CoC2p74ScSNzWM5o/KIr7maxlVZx6gitKjnGKzkzU+dyaA3q?=
 =?us-ascii?Q?Us+BkIWgHOHZL1FYhrLRWzDVwTPR4wGVCgwQGx7xdtXNfPZHvGxRmDfdm4sX?=
 =?us-ascii?Q?Zufiqgm8eWkR4ucJZxP5o1qAl3jfWUrLXeJxUyr3wwcnQJQQNUYfKjZrLLZo?=
 =?us-ascii?Q?lB/0hZ2Z4by0cLmY0ntzsh9TQiGBJjS8G7URTgKpHIn1c2C40NFP5b/4MSBy?=
 =?us-ascii?Q?dj5ePU7AxNhav3WhGr/2mlwzG3b/49t9hVtPJ9uN0cXvLLK9JlPSnSYw8KEH?=
 =?us-ascii?Q?/XrXDVBmxaRmIIHIpCwCVmKm65Fz0YvnNloybgFSq62CnSPi5mbXIlRahJ1m?=
 =?us-ascii?Q?SK2F/qpIDJtYJ2LRJ/mIMe9Bwm0KgPIOo+ShzOzdU59NgpqUJpbvWsgnbWm1?=
 =?us-ascii?Q?wUZhuVIkwwZYx07N3piTOaJauvPTve52Dk6pQhnt3FRaPM3P2Xqv1iVkQWPd?=
 =?us-ascii?Q?jQGnQBj3bWr+pCOfLVTNTG9n5GKjcoRcNOiH5j3nVj7vjjqBhtn3VLCWYp/I?=
 =?us-ascii?Q?rJBQBqKrr8OtUxMnIvOj0HOwfrQ/kpUpHeWKEEjupPmmo3skWeZ9GSXfFU73?=
 =?us-ascii?Q?N6SdAEMTDVfWEUImGfL80UzpijRaib//6lt+ZvDOaUos5sx1q9lC0iTgf3Ko?=
 =?us-ascii?Q?qDHSlE8/AFjtZilef2uyUliT2hInxyqQJqfCHrS6gquJChwUMBMjNvpPkOiR?=
 =?us-ascii?Q?aNGajC1pW4fXZVq9cO9EsdrcKHWMqkbfo/OmFgVj1ba+z9FlNyTbwUP+/lww?=
 =?us-ascii?Q?1BPM0kGr8RGUwzfK714mgs/qi/em2jXfbKtH7IisubrTeMuXPaWRibyufDhG?=
 =?us-ascii?Q?28+7tPE9ZP9lPNQAVxZqJmUEK0AP0EBNtd6XJ/KWZ35y8QPvmKZ307smFKNg?=
 =?us-ascii?Q?6HoK/94=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4a69ac-8dc8-489c-312d-08deef1ae6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 15:46:35.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9465

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, July 3=
0, 2026 4:34 PM
>=20
> On CoCo VMs without confidential VMBus, the netvsc send and receive buffe=
rs
> must be made host-visible by decrypting them. These buffers are vmalloc'e=
d,
> but set_memory_decrypted()/encrypted() do not work on vmalloc'ed memory.
> This use case is (so far) unique to netvsc, so solve it locally rather th=
an
> changing the set_memory() or allocation APIs.
>=20
> Add vmbus_alloc_buffer()/vmbus_free_buffer() to the VMBus core. When the
> guest's isolation model requires it, allocate the buffer as a list of
> physically-contiguous chunks via alloc_pages_node(), starting at
> MAX_PAGE_ORDER and falling back to smaller orders so the allocation still
> succeeds under memory fragmentation. Each chunk is decrypted in place via
> set_memory_decrypted() on its direct-map address, and the chunks are then
> stitched into a single virtually-contiguous range with vmap(). Buffers th=
at
> do not need decryption keep using vzalloc().
>=20
> This approach minimizes scattering of decrypted 4 KiB pages through the
> kernel direct map and the resulting shattering of large page mappings.
>=20
> Use vmbus_establish_gpadl_caller_decrypted() so there is no attempt
> to decrypt the virtual address. At teardown, vunmap() the range and
> re-encrypt and free each chunk individually; any chunk that fails
> re-encryption is leaked to prevent accidentally freeing decrypted memory.
>=20
> Because vunmap() and set_memory_encrypted() must run in process context,
> replace the rcu_head/call_rcu() pair used to defer free_netvsc_device()
> with rcu_work/queue_rcu_work(). This also fixes a small race condition
> where the buffers may be accessed while being re-encrypted by moving the
> re-encryption after the RCU grace period.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  drivers/hv/channel.c            | 158 ++++++++++++++++++++++++++++++++
>  drivers/net/hyperv/hyperv_net.h |   8 +-
>  drivers/net/hyperv/netvsc.c     | 104 ++++++++++++++-------
>  drivers/net/hyperv/netvsc_drv.c |   6 ++
>  include/linux/hyperv.h          |   7 ++
>  5 files changed, 249 insertions(+), 34 deletions(-)

Arguably, this patch should be broken into two patches. One
patch adds the buffer allocation/free functions to the VMBus core.
The second updates netvsc to use the new allocation/free
functions and to call the free function in the required context.

>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 4782f5070bba9..9fe7b1163b408 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -13,11 +13,13 @@
>  #include <linux/wait.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/hyperv.h>
>  #include <linux/uio.h>
>  #include <linux/interrupt.h>
>  #include <linux/set_memory.h>
> +#include <linux/vmalloc.h>
>  #include <linux/export.h>
>  #include <asm/page.h>
>  #include <asm/mshyperv.h>
> @@ -608,6 +610,162 @@ int vmbus_establish_gpadl_caller_decrypted(struct v=
mbus_channel *channel,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
>=20
> +/*
> + * vmbus_free_buffer - release a buffer allocated by vmbus_alloc_buffer(=
).
> + *
> + * @addr: buffer address, or NULL if none was allocated (e.g. cleanup fr=
om a
> + *        failed allocation)
> + * @chunks: chunks array from vmbus_alloc_buffer(), or NULL
> + * @chunk_cnt: number of entries in @chunks
> + *
> + * When @chunks is NULL the buffer is a plain vzalloc() allocation.
> + *
> + * Otherwise tear down the vmap, and for each chunk re-encrypt and free
> + * the underlying pages. Any chunk that cannot be re-encrypted is leaked=
.
> + */
> +void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt)
> +{
> +	u32 i;
> +
> +	if (!chunks) {
> +		vfree(addr);
> +		return;
> +	}
> +
> +	vunmap(addr);
> +
> +	for (i =3D 0; i < chunk_cnt; i++) {
> +		unsigned long vaddr =3D
> +			(unsigned long)page_address(chunks[i]);
> +		unsigned int order =3D folio_order(page_folio(chunks[i]));
> +
> +		if (set_memory_encrypted(vaddr, 1U << order))
> +			continue;
> +		__free_pages(chunks[i], order);
> +	}
> +
> +	kvfree(chunks);
> +}
> +EXPORT_SYMBOL_GPL(vmbus_free_buffer);
> +
> +/*
> + * vmbus_alloc_buffer - allocate a virtually-contiguous buffer suitable =
for
> + * a GPADL, making it host-visible when required by the guest's isolatio=
n model.
> + *
> + * @channel: the channel the buffer will be attached to
> + * @size: requested buffer size in bytes (will be rounded up to PAGE_SIZ=
E)
> + * @chunks_out: on success, set to the array of underlying chunks, or NU=
LL when
> + *              the buffer was allocated with vzalloc()
> + * @chunk_cnt_out: on success, set to the number of chunks
> + *
> + * Buffers not requiring decryption are allocated with vzalloc().
> + *
> + * Buffers requiring decryption are allocated as a series of
> + * physically-contiguous chunks, starting at MAX_PAGE_ORDER and falling =
back to
> + * smaller orders on allocation failure. Each chunk is transitioned to
> + * host-visible via set_memory_decrypted() on its direct-map address, th=
en all
> + * chunks are combined into a virtually-contiguous range via vmap().
> + *
> + * Return: the buffer's virtual address, or NULL on failure.
> + */
> +void *vmbus_alloc_buffer(struct vmbus_channel *channel,
> +			 u32 size,
> +			 struct page ***chunks_out,
> +			 u32 *chunk_cnt_out)
> +{
> +	u32 nr_pages =3D PFN_UP(size);

Is there a reason for nr_pages to be u32, and then cast it to unsigned long
a couple of places below? The first argument to kvmalloc_array() is of
type size_t.  Avoiding the casts would be incrementally cleaner.

> +	struct page **chunks =3D NULL;
> +	struct page **pages =3D NULL;
> +	unsigned int order;
> +	u32 chunk_cnt =3D 0;
> +	u32 page_idx =3D 0;
> +	u32 remaining =3D nr_pages;
> +	void *addr;
> +	u32 i;
> +	int ret;
> +
> +	*chunks_out =3D NULL;
> +	*chunk_cnt_out =3D 0;
> +
> +	if (!nr_pages)
> +		return NULL;
> +
> +	/* If the buffer does not need to be decrypted, just use vzalloc() */
> +	if (!hv_is_isolation_supported() || channel->co_external_memory)
> +		return vzalloc((unsigned long)nr_pages << PAGE_SHIFT);
> +
> +	/* Worst case: every chunk is a single page. */
> +	chunks =3D kvmalloc_array(nr_pages, sizeof(*chunks),
> +				GFP_KERNEL | __GFP_ZERO);
> +	if (!chunks)
> +		goto err;
> +
> +	pages =3D kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		goto err;
> +
> +	/*
> +	 * @order monotonically decreases across iterations
> +	 *
> +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing, but try
> +	 * harder at order 0 since that is the final fallback.
> +	 */
> +	order =3D min(MAX_PAGE_ORDER, ilog2(nr_pages));

This works, but is more complex than needed. Just set order to
MAX_PAGE_ORDER, and the min() at the top of the while loop below
will do the right thing. And you could do order =3D MAX_PAGE_ORDER
where order is declared.

> +	while (remaining) {
> +		struct page *page;
> +		gfp_t gfp;
> +
> +		order =3D min(order, ilog2(remaining));
> +
> +		for (;;) {
> +			gfp =3D GFP_KERNEL | __GFP_ZERO;
> +			if (order)
> +				gfp |=3D __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
> +			page =3D alloc_pages_node(cpu_to_node(channel->target_cpu),
> +						gfp, order);
> +			if (page)
> +				break;
> +			if (!order)
> +				goto err;
> +			order--;
> +		}

I think this nested for loop can be avoided. At this point in the outer whi=
le
loop, set the gfp flags and call alloc_pages_node() as you have here. The
good and normal path is that alloc_pages_node() succeeds. The exception
path is alloc_pages_node() failing, so you can do:

		if (!page) {
			if (!order--)
				goto err;
			continue;
		}

The "continue" just restarts the outer while loop with the decremented
value of "order" and everything proceeds normally. To me avoiding the
nested loop is simpler, though "simpler" can be in the eye of the beholder,
so if you prefer to keep this as is, I'm OK with that.

> +
> +		ret =3D set_memory_decrypted((unsigned long)page_address(page),
> +					   1U << order);
> +		if (ret) {
> +			/*
> +			 * set_memory_decrypted() failed; the page state is
> +			 * unknown so it must be leaked rather than freed.
> +			 */
> +			goto err;
> +		}
> +
> +		chunks[chunk_cnt++] =3D page;
> +
> +		for (i =3D 0; i < (1U << order); i++)
> +			pages[page_idx++] =3D page + i;
> +
> +		remaining -=3D 1U << order;
> +	}
> +
> +	addr =3D vmap(pages, nr_pages, VM_MAP, pgprot_decrypted(PAGE_KERNEL));
> +	if (!addr)
> +		goto err;
> +
> +	memset(addr, 0, (unsigned long)nr_pages << PAGE_SHIFT);
> +
> +	kvfree(pages);
> +	*chunks_out =3D chunks;
> +	*chunk_cnt_out =3D chunk_cnt;
> +	return addr;
> +
> +err:
> +	kvfree(pages);
> +	vmbus_free_buffer(NULL, chunks, chunk_cnt);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_alloc_buffer);
> +
>  /**
>   * request_arr_init - Allocates memory for the requestor array. Each slo=
t
>   * keeps track of the next available slot in the array. Initially, each
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_=
net.h
> index 7397c693f984a..4841367fdab2f 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -220,6 +220,8 @@ struct net_device_context;
>=20
>  extern u32 netvsc_ring_bytes;
>=20
> +int netvsc_workqueue_init(void);
> +void netvsc_workqueue_destroy(void);
>  struct netvsc_device *netvsc_device_add(struct hv_device *device,
>  					const struct netvsc_device_info *info);
>  int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_=
idx);
> @@ -1158,6 +1160,8 @@ struct netvsc_device {
>  	/* Receive buffer allocated by us but manages by NetVSP */
>  	void *recv_buf;
>  	u32 recv_buf_size; /* allocated bytes */
> +	struct page **recv_buf_chunks;
> +	u32 recv_buf_chunk_cnt;
>  	struct vmbus_gpadl recv_buf_gpadl_handle;
>  	u32 recv_section_cnt;
>  	u32 recv_section_size;
> @@ -1166,6 +1170,8 @@ struct netvsc_device {
>  	/* Send buffer allocated by us */
>  	void *send_buf;
>  	u32 send_buf_size;
> +	struct page **send_buf_chunks;
> +	u32 send_buf_chunk_cnt;
>  	struct vmbus_gpadl send_buf_gpadl_handle;
>  	u32 send_section_cnt;
>  	u32 send_section_size;
> @@ -1193,7 +1199,7 @@ struct netvsc_device {
>=20
>  	struct netvsc_channel chan_table[VRSS_CHANNEL_MAX];
>=20
> -	struct rcu_head rcu;
> +	struct rcu_work rwork;
>  };
>=20
>  /* NdisInitialize message */
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 59e95341f9b1e..1192929d93a86 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -28,6 +28,8 @@
>  #include "hyperv_net.h"
>  #include "netvsc_trace.h"
>=20
> +static struct workqueue_struct *netvsc_wq;
> +

Does netvsc needs its own workqueue to do the "free" operation,
or would the system default workqueue (system_dfl_wq) be just
as good? At first glance, the system_dfl_wq seems like it would work,
since netvsc free operations are rare and don't have any strict
latency requirements. But I'm far from being expect in workqueues,
and there could be subtleties I'm not aware of.

Michael

>  /*
>   * Switch the data path from the synthetic interface to the VF
>   * interface.
> @@ -125,6 +127,47 @@ static void netvsc_subchan_work(struct work_struct *=
w)
>  	rtnl_unlock();
>  }
>=20
> +static void __free_netvsc_device(struct netvsc_device *nvdev)
> +{
> +	int i;
> +
> +	kfree(nvdev->extension);
> +
> +	vmbus_free_buffer(nvdev->recv_buf, nvdev->recv_buf_chunks,
> +			  nvdev->recv_buf_chunk_cnt);
> +	vmbus_free_buffer(nvdev->send_buf, nvdev->send_buf_chunks,
> +			  nvdev->send_buf_chunk_cnt);
> +	bitmap_free(nvdev->send_section_map);
> +
> +	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
> +		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
> +		kfree(nvdev->chan_table[i].recv_buf);
> +		vfree(nvdev->chan_table[i].mrc.slots);
> +	}
> +
> +	kfree(nvdev);
> +}
> +
> +static void free_netvsc_device(struct work_struct *w)
> +{
> +	struct rcu_work *rwork =3D to_rcu_work(w);
> +
> +	__free_netvsc_device(container_of(rwork, struct netvsc_device, rwork));
> +}
> +
> +int netvsc_workqueue_init(void)
> +{
> +	netvsc_wq =3D alloc_workqueue("hv_netvsc", WQ_UNBOUND, 0);
> +
> +	return netvsc_wq ? 0 : -ENOMEM;
> +}
> +
> +void netvsc_workqueue_destroy(void)
> +{
> +	rcu_barrier();
> +	destroy_workqueue(netvsc_wq);
> +}
> +
>  static struct netvsc_device *alloc_net_device(void)
>  {
>  	struct netvsc_device *net_device;
> @@ -143,36 +186,18 @@ static struct netvsc_device *alloc_net_device(void)
>  	init_completion(&net_device->channel_init_wait);
>  	init_waitqueue_head(&net_device->subchan_open);
>  	INIT_WORK(&net_device->subchan_work, netvsc_subchan_work);
> +	INIT_RCU_WORK(&net_device->rwork, free_netvsc_device);
>=20
>  	return net_device;
>  }
>=20
> -static void free_netvsc_device(struct rcu_head *head)
> -{
> -	struct netvsc_device *nvdev
> -		=3D container_of(head, struct netvsc_device, rcu);
> -	int i;
> -
> -	kfree(nvdev->extension);
> -
> -	if (!nvdev->recv_buf_gpadl_handle.decrypted)
> -		vfree(nvdev->recv_buf);
> -	if (!nvdev->send_buf_gpadl_handle.decrypted)
> -		vfree(nvdev->send_buf);
> -	bitmap_free(nvdev->send_section_map);
> -
> -	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
> -		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
> -		kfree(nvdev->chan_table[i].recv_buf);
> -		vfree(nvdev->chan_table[i].mrc.slots);
> -	}
> -
> -	kfree(nvdev);
> -}
> -
>  static void free_netvsc_device_rcu(struct netvsc_device *nvdev)
>  {
> -	call_rcu(&nvdev->rcu, free_netvsc_device);
> +	/*
> +	 * Defer the actual free to process context: vunmap() and
> +	 * set_memory_encrypted() cannot run from RCU softirq context.
> +	 */
> +	queue_rcu_work(netvsc_wq, &nvdev->rwork);
>  }
>=20
>  static void netvsc_revoke_recv_buf(struct hv_device *device,
> @@ -351,7 +376,11 @@ static int netvsc_init_buf(struct hv_device *device,
>  		buf_size =3D min_t(unsigned int, buf_size,
>  				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
>=20
> -	net_device->recv_buf =3D vzalloc(buf_size);
> +	net_device->recv_buf =3D
> +		vmbus_alloc_buffer(device->channel, buf_size,
> +				   &net_device->recv_buf_chunks,
> +				   &net_device->recv_buf_chunk_cnt);
> +
>  	if (!net_device->recv_buf) {
>  		netdev_err(ndev,
>  			   "unable to allocate receive buffer of size %u\n",
> @@ -367,9 +396,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	 * channel.  Note: This call uses the vmbus connection rather
>  	 * than the channel to establish the gpadl handle.
>  	 */
> -	ret =3D vmbus_establish_gpadl(device->channel, net_device->recv_buf,
> -				    buf_size,
> -				    &net_device->recv_buf_gpadl_handle);
> +	ret =3D vmbus_establish_gpadl_caller_decrypted(device->channel,
> +						     net_device->recv_buf,
> +						     buf_size,
> +						     &net_device->recv_buf_gpadl_handle);
>  	if (ret !=3D 0) {
>  		netdev_err(ndev,
>  			"unable to establish receive buffer's gpadl\n");
> @@ -457,7 +487,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	buf_size =3D device_info->send_sections * device_info->send_section_siz=
e;
>  	buf_size =3D round_up(buf_size, PAGE_SIZE);
>=20
> -	net_device->send_buf =3D vzalloc(buf_size);
> +	net_device->send_buf =3D
> +		vmbus_alloc_buffer(device->channel, buf_size,
> +				   &net_device->send_buf_chunks,
> +				   &net_device->send_buf_chunk_cnt);
>  	if (!net_device->send_buf) {
>  		netdev_err(ndev, "unable to allocate send buffer of size %u\n",
>  			   buf_size);
> @@ -470,9 +503,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	 * channel.  Note: This call uses the vmbus connection rather
>  	 * than the channel to establish the gpadl handle.
>  	 */
> -	ret =3D vmbus_establish_gpadl(device->channel, net_device->send_buf,
> -				    buf_size,
> -				    &net_device->send_buf_gpadl_handle);
> +	ret =3D vmbus_establish_gpadl_caller_decrypted(device->channel,
> +						     net_device->send_buf,
> +						     buf_size,
> +						     &net_device->send_buf_gpadl_handle);
>  	if (ret !=3D 0) {
>  		netdev_err(ndev,
>  			   "unable to establish send buffer's gpadl\n");
> @@ -1863,7 +1897,11 @@ struct netvsc_device *netvsc_device_add(struct hv_=
device *device,
>  	netif_napi_del(&net_device->chan_table[0].napi);
>=20
>  cleanup2:
> -	free_netvsc_device(&net_device->rcu);
> +	/*
> +	 * net_device was never published, so we don't need to wait for an
> +	 * RCU grace period -- call the free routine synchronously.
> +	 */
> +	__free_netvsc_device(net_device);
>=20
>  	return ERR_PTR(ret);
>  }
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index ee5ab5ceb2be2..1d43c73fd73f1 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2867,12 +2867,17 @@ static void __exit netvsc_drv_exit(void)
>  {
>  	unregister_netdevice_notifier(&netvsc_netdev_notifier);
>  	vmbus_driver_unregister(&netvsc_drv);
> +	netvsc_workqueue_destroy();
>  }
>=20
>  static int __init netvsc_drv_init(void)
>  {
>  	int ret;
>=20
> +	ret =3D netvsc_workqueue_init();
> +	if (ret)
> +		return ret;
> +
>  	if (ring_size < RING_SIZE_MIN) {
>  		ring_size =3D RING_SIZE_MIN;
>  		pr_info("Increased ring_size to %u (min allowed)\n",
> @@ -2890,6 +2895,7 @@ static int __init netvsc_drv_init(void)
>=20
>  err_vmbus_reg:
>  	unregister_netdevice_notifier(&netvsc_netdev_notifier);
> +	netvsc_workqueue_destroy();
>  	return ret;
>  }
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 1146addbb42c4..f843ee0efa22f 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1214,6 +1214,13 @@ extern int vmbus_establish_gpadl_caller_decrypted(=
struct vmbus_channel *channel,
>  extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
>  				     struct vmbus_gpadl *gpadl);
>=20
> +extern void *vmbus_alloc_buffer(struct vmbus_channel *channel,
> +				u32 size,
> +				struct page ***chunks_out,
> +				u32 *chunk_cnt_out);
> +
> +extern void vmbus_free_buffer(void *addr, struct page **chunks, u32 chun=
k_cnt);
> +
>  void vmbus_reset_channel_cb(struct vmbus_channel *channel);
>=20
>  extern int vmbus_recvpacket(struct vmbus_channel *channel,
> --
> 2.45.4
>=20

