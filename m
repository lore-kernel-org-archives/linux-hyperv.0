Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795410981;
	b=fMShcbCgFJAi4qypsglg5RzjPmyivWTSLX6q8bA9+3B7E7XJjdutaraSGVbRC1P6KZ2F
	 ZJ1U/u4vBJ+7i6rwoToeE+SbvoPjkxe+AAJIPHma0fRWFXK5J7wEIo+6bdtXv/YCtKE6z
	 n8BmwIWYjZdOlIybNUfES3GSD9iyZ6oyJUhWd0Qjb5d2LLOeU9vUgXc/G/iW0HjSzXf9K
	 Ajo5qis7t6L/1uydLZonHbpYDQ5/8Ly5RgT1Vj+OI6nHRxKuoEEiQ+MNvYsRpAPUa3OHg
	 /xhofg5i7OcAkAEgCLbu2BZeRUN27gzYNIipFpMdSe22eghCLXr8DlHXNRsp0SvacoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410981;
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
	bh=sUhpbOgW3LwPQSZ7+mghR58VeYcrtgxGgEhNrFwZOzY=;
	b=UvArkYabwXBQrEKx6QvEQ0kQIGGGslKJ7nhCyoyffE3m46BtSD75gLabcxy3zj1Dy13U
	 89Mui3fN3k1aSMDnF4aTrUTeuSXlbw3UhqWvOidoXnuik2NF5wNUlSX4uRikM/gW8rBFk
	 NhpaQn8QSNyzD+V7mavZjSIpIUp0h6kMHUavuCzaSE6exCbu8vHX+WXr0G+ijdj/8EIq5
	 9OQTVTpobINCYYzZqLi1zwyeLU1N+G1QPDkTM364e8csVzLZA/DS+59jnqpGeXSoERkZP
	 r4JBuQ0iv6XFIhv5hyIWqJEN9Yjyez6Upc/q6899Ak08NEX4tVMh108YzPAJDEO7/3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=FRH9XyWf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.29
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011029.outbound.protection.outlook.com [52.103.13.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFF606A31A;
	Mon, 23 Nov 2026 05:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8EFF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=FRH9XyWf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgeGgW9TK1dy74k/rPCx5BW2QBMaHZ9P44OYFoYvvrVenYUwJ6tOkQBwb1QPyvDNdRFLilSgBnseegfnCpZQBTETt/t4xV4f87Bo5RpkB8AlJ11ni1+bN4RXX7rLKaGVVMHHvDKkjoxteoFEEromGvXxQDwI8UU6lCyIeK0WG1vvFwE4ldxojI4LSg7akmGTvdwrd2YUlLO8ZOfKEP2dXH29IGvOLGPGRPstMxgx0AEs1kHDbAEZ8NmW22Q2eIdKqGs0RA1M3P0jpWqtDbdcsaPdMjC4Y/fd57HG+eNRu1pNJy5adsAz9IRp/SYmcvS+9E9S/GDETEU2So6QQHZPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUhpbOgW3LwPQSZ7+mghR58VeYcrtgxGgEhNrFwZOzY=;
 b=w9Rn6dxRWnZ/0NS11R2SK/myPjqg7fOYueUeXQ4BDIcQjFV0QTVB2M7zsIJqb1T4m6cho+vytgTLyF8HKJEB5yy7ftEMu7lUU6fuWJYsM+2vAS7yHEVSHV4JMLaQRrH3ieXFnTpaY69X04wIpq9w3MvZRXSTEg11zYcCSi7byOA5Lr80fcRg2LpdsIthDZKONcNoPHxaTEaT81taWu3j4UfPfe1JcdGqf+/dbWJxC3vqXMriMu4oClAGmfbro/M0JbDAt2QKfyULphuWgg+TWvWsyuXBZ5Ebx52hn+8G0H4uqkdfRcouI6IlFKGRVUBjBwWHkkuBzwNL8fPVh/Z27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUhpbOgW3LwPQSZ7+mghR58VeYcrtgxGgEhNrFwZOzY=;
 b=FRH9XyWfWUgheAEwLwCJUHpdk8yJKv+f7e4QbV63Nb3vOWnXQstfmb2xoH7b/KcfL2TvqrALjkbMnTgeAxuvCsWEPO0DKs3HEXMmlOKVxGUQ+9F3S632k1kJV51Pms5KHlwvoRS9KRvt0cYPx4AGVVHqGUHOuyVflcufY8xx/GfDtndpjGSgXAnt7fbnl/fGkgnygwpMLDmmwOvIsNiVtaGLuAYt1jwM4/xCtw40O2ugj5wExxgAqbZ7mLRdULaK7MDvKyK6q/dlaoMe8s56lQgvBZPVeLyq2fL7tkryyg9z1rplZG8iaLqorgVG+pVc0/O/Y0c82Qx6FjBDuykRiQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB8816.namprd02.prod.outlook.com (2603:10b6:a03:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 05:09:39 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 05:09:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "shyckless@gmail.com" <shyckless@gmail.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "romank@linux.microsoft.com" <romank@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] mshv_vtl: Release mem_dev through put_device()
Thread-Topic: [PATCH] mshv_vtl: Release mem_dev through put_device()
Thread-Index: AQIKtqY9J6acQ5302YykVqj7YhXbDbbgo7vA
Date: Mon, 23 Nov 2026 05:09:39 +0000
Message-ID:
 <MN2PR02MB686305D4FD4D953E6244B76DD4452@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261112-hyperv-v1-1-67144d71878c@gmail.com>
In-Reply-To: <20261112-hyperv-v1-1-67144d71878c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB8816:EE_
x-ms-office365-filtering-correlation-id: 50d3516a-326f-4846-c28c-08df491ff9d4
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7NlVaV8aDO8K8VWxWnctQAoIkRZZ2xXxSgV+yApdkYKElmnxg1Wb1iN7I3ewqd5GyPpQgVh36DDeijPMBiazZ+9+5Xc9TJm2CaLsXJYNhcfkwqoS9Dg+2qtUBfPygTWdYsJUJMx1oUHPNhEzZKRLBoi2NUFQ8BKL+UdWcNCz7qpDHxPBtSTU/TWLnN4t7u7WQ5WsDx3sb2hMSkZxWQqsic9AWmySVZhsjSMPHmmjMPPEIg17loz0TKO6cbG9HvNOO09f0DqFYSGawljugk91EwbcbUR9CqKO3n+OJeNBp0GbioZfFO0hidZMApRkuejOTAz0Tq28IZSua95YW1cmEmpeGHB1ww0ytNSV+G4LW7qk2vIVJJlcQT6wYPi4WkmFmjrcQvEPM8KtAE2sUs7nD+YbafhegvafN/YmrYy+RGIWQNE5aUSSyiE7rgT/nsrVZ6dcX6bBKcGccaynEJYpm+D9bxt81+xaBudQOigFpPfuG0Ivjyz3nh1maijXF6BvTifNMguGjVoTjTJfvyz5ht8eFfQ7RjvtdlaPsuhMQksS1XwXTnE86aMtPVsh0rBF7TzrCGxe6YfUrnW79gKDBD1yAO8u96jS9ZpbfSTdg+cozB8mkfRK1Hx73pTg7vmfccviX0fm3VEN0OSKMt0l/sA8blq8bXz/hZ/mNT0zItxletG0kcM2X3/DmNQsoY4aYg39gl69zK9KZ+0L77RVIKinSUzk+CWYqVUZWgu40GNY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|24021099003|37011999003|19110799012|15080799012|31061999003|8062599012|8060799015|13091999003|55001999006|51005399006|4140399003|25010399006|3412199025|440099028|102099032|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjM1Rnd1R3dtaGZiUzZPcC9uL1hici9UZ1ZwVUlVZnIzbG8zcjRMak0rQnVU?=
 =?utf-8?B?d1dDakExZ2JoZ0poUmJ5aE9mLzJUeTZ4Y3h0dW1RT0NiSDNGbllya2hVcExW?=
 =?utf-8?B?TGJLMlFzZTZJRGEvMm9aWTJtb05JRmIwM2FRa2hKdlk0M2pveU5hc25aR0tn?=
 =?utf-8?B?MGQzUDlrVm5TZzY1VERIU0VyQmlKaDRsdks2VkFsUE1XOHZMTGFYM251N2Jt?=
 =?utf-8?B?MjI3WFpGUkFnM1pmMnlWSlVPMWM0Q2lXemY4VzJ0ZlJxS0VtaERBdU9mMzZo?=
 =?utf-8?B?Qmx6WklzSHZqWWFKTUFUeDk4SDFGVUpjMzQ2azBoVldVVG1xVXQya2ZXWk1Q?=
 =?utf-8?B?b3hxZnJQd0l4aGFzTkJmY2RBalJ6b2dGMjhURVVsVUx6TlpHaUlsUXFkV2My?=
 =?utf-8?B?eXNYNGdqL2NyNVdGWng3eFE0RTJUZnM0WHpzY3JpSUZkditmcU9hWjBxYkU3?=
 =?utf-8?B?Y3ZIcE1jaThwbXVBM1pKd0hBbEVNUGxoNC9FMHRDU2R5NEpWS0dCQlZESTZV?=
 =?utf-8?B?UG9HM05mcnFFbnJHWGY1ZVpKYmNjQURjTDcvcW5hZFFrY21PaklSbmJaZ1VW?=
 =?utf-8?B?a09yenFZalFyNjlVR1pld2xqTWxQRVNsZVdldW9jY1g4M0FxeEN4VWJvVG9s?=
 =?utf-8?B?ZC9ySW9yamJ5YW5DLzRWVnF0dmZnQ1VVY2dXOXo0WC9LVnozYWpvamhzUEJF?=
 =?utf-8?B?SDUvN1FpZGZwZWY4YkF0SldCSG9DYjEvRS9MbkpzR3A0YmJ4QnN2Y2Q4bkU4?=
 =?utf-8?B?RWNXdzF0azBpcnhqZkptc3NhUHNpT3hFTzBuRnhtSzJKV0I1UkdYZEJRVGVl?=
 =?utf-8?B?NFl0K05aUzFGMlZENEI2VExqMTRKS1ZhbEUxaVpuNUtUbjJjTjhqM2pFcEdJ?=
 =?utf-8?B?cFprVjRuVnFQanBmV2lZNDZqR3FIVUhER0NnNTF2M1R3dG5OalBUcXhTVUkx?=
 =?utf-8?B?aWF1cmg0Wm5XeWRidk8vL0pNWGxuREtyNjcwVzdVR1VJbUJDcjU0bXd6Mldn?=
 =?utf-8?B?WG5VWXRKS254KzdqdVBPeFNrWmZscThIcFhId21JVkM5cThiWldweG42NFcw?=
 =?utf-8?B?QjI1dXpIRTd0K1ZVWXRaWUpHVnpOYVYxWXVJOGFRUWlZSW9XcmtlNkNWajZ3?=
 =?utf-8?B?RnM0NlN1RW05bVdPMTRoL29qdzhSY1B4c0Fuanhnd2Q3bnFFUUZnY1lLWmZT?=
 =?utf-8?B?VU91V08yczRiYUVzdzQ2OEdyRWVOc09jSXRRa3hrWEc5RGh6Unk5UXVWd3hR?=
 =?utf-8?B?THBPY3VRRmJhaTVNNHpNZVNXc0lJSjU3RHFUeVIxdnl1Q3hSMGJvd0I2cDF1?=
 =?utf-8?B?ZS92cHNPSGRCMldZQUdQQ3J3MU9SbEZiZDlQUHhZSXhsNlA3ejkxb2ZXTGJY?=
 =?utf-8?B?VGFRYkVlSzZxMDVSVEZFOHVPaVk2R2FFZjE0aHRiT2NBdWJqT1Z6TWdwQ0N1?=
 =?utf-8?B?Qk9GV2pEK3A2MGgvK2l6YXdYK0Q3bE9KSlZ6TXlWREo3YTl5eVdhc2JVQ2w2?=
 =?utf-8?Q?WoVUw4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2QxTVdCcGIzemtJY3F0RjlHZE04dkt0ejB5Mm15TWEwZmhGQ2VQMGU0RUxM?=
 =?utf-8?B?a2dIcUhtR1JlS3F6eXhDaHdxTzczWUxVREFIeGlDL0hKaXh5UzRhUzFEelRt?=
 =?utf-8?B?bGlEbDhjeEdRVGg4eEpxWWtRaG1WU1cwRGZhcHI2T1o0bXBmQWt5RTZJQlhX?=
 =?utf-8?B?SFBud29tVmVBaFVxYnFFWDZjblRvRWZwdnFsLzUyMlNhNVpqWEdTSzhHWEZN?=
 =?utf-8?B?N1VNdFZIKzd6bWlwY0o4ZHM5L0NQbi9OMmVQeEo4ZktLcjdZbE1FZEJmMWds?=
 =?utf-8?B?bG5LZXdLV1pKOWd4S2F3RXpMQUJsWk5JZE1qUVl3TGFlajFHdzIrR1I0cVpN?=
 =?utf-8?B?Y1dNam4zNHJGdkdjV1hxN0FDNTFsQ2R6dFE3QnFyaFVWNG01U1diNm9mSE0y?=
 =?utf-8?B?YXZrQi9aYTl5bGhwNE8vZHJYS0hXRWpSQmxvTmVGcnltKytWS2YrSlQ0c2tM?=
 =?utf-8?B?VU1kZE9iNDlQUTROSHMvbi90MzREejJvUmg4ZjI4UE5iVDNWWGF1WHFTL01k?=
 =?utf-8?B?UEVIaU5QVmE4cE0vNkhaUTh6eDJ3V0VKY2NkRlp0SnBWMzBNYXlYcXNPNVNh?=
 =?utf-8?B?Mk16VkFoYzBUN256OEhGeUF0a3o5aExOOEpVR3AyMnByOVBrWW1kOFVtTkVK?=
 =?utf-8?B?WHhSajJjSUpDSU0zWkhWcitJemdhSkZySzBCcllrVGorTmkwWU5IcFJ1c2Nl?=
 =?utf-8?B?U082WmdzdzE1RjFMaU5aZytSZXBsUEJLRG1manFBNE9zWkgrb2JwbFZjNk5J?=
 =?utf-8?B?Z1BkeXZRRDF0L0VVekFha3pzUHA2U3lFRU9oR01FU3l1WTQzNEpUMlFGZk41?=
 =?utf-8?B?aUZNdzFvZEc1YU51OU0rT3lwRVNDR0lqNlBaQ25iVWJUUzVqb1dlbUQrVHVE?=
 =?utf-8?B?UE9TelBWQUQxeFFLcHVJUWgyejlod1AyV0NIYTdBcEVudWJQWnk0M0NhaFkr?=
 =?utf-8?B?bVZKYTEyK2pIS0RjWWE3TzFLdXhuL1dNQVgwWCtDZ21hS2ZpM0IwTVp5VWpk?=
 =?utf-8?B?Z1Nha0ovZkVOeTBtUmJRRUlGNXRJSS9uZURyQzk4TUdjS3Vya1ZKRXZuWG4v?=
 =?utf-8?B?Z1N2V21CSzNrSDhaQnJxd25aejlZU1V2NTNCL0pXelcwSGRNMHo5ZWE2ZUlT?=
 =?utf-8?B?cFI2bmZYbUpNZ0VranlwWWlkbzV2L0thYlBrQkNHMmNsRThTaXZpbm13K1hn?=
 =?utf-8?B?TUU0cHo1bk5JSlVNQUFiSSt4T3BkZUtOWk4rSFpHL0FsYVdvR2RNdDI2b08w?=
 =?utf-8?B?UzF6SzhVWk9jUUtYRllHL0tIakd1eXFYbjJzK0lwd0MxS2IrQ3dlVk9qaDRv?=
 =?utf-8?B?NkRtRU1wN0t1TGFEdU43RCttVm9HYlcvd0VDSnJYTk9rU1lGeHlLZHZHVG5t?=
 =?utf-8?B?L2VoM216YWtnSUplc0VCakdLRC9zKzZMVzVkWW0rQ21lc2k1bkpicnlBMG1K?=
 =?utf-8?B?TFdwRS9xQklsb0dNUTJ3OG9oT0NmUGUwcjAvU0RkZ1JRWkpjR1k3N251T2Va?=
 =?utf-8?B?dEVYQnU5dmhRZGNNYW1oMGhtdGZYdWE1TVFkdGVuT2JFUjUxRHZkbUcvNGQ3?=
 =?utf-8?B?c0FSS1F3MUp2VjRLSzBjdE05V0J4bjM2UHBzVjZtWVNHMTRNYU5LR2Y2bUln?=
 =?utf-8?B?STNvUWJ5eEFsVmUvalFwNlJWdW9NMk1TYjFWbGdiVVlMZTdISEFzU25MK0s1?=
 =?utf-8?B?eXg1Y0F1RHZxSFVhb08xSzNVQkowaHRWcFpIQkZuUDRMeUlOT2p4MHFwNDcv?=
 =?utf-8?B?R3l5bEpvNHJTR2NKUWx1MGVaZ1g4NURuVHE1RTE0VnV1OWF6TFBpVDY1QytP?=
 =?utf-8?Q?68Md0A2hyy1teVMi2iOWgIs9Krx41U13draq0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d3516a-326f-4846-c28c-08df491ff9d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 05:09:39.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8816

RnJvbTogU3V5dWFuIFdhbmcgdmlhIEI0IFJlbGF5IDxkZXZudWxsK3NoeWNrbGVzcy5nbWFpbC5j
b21Aa2VybmVsLm9yZz4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDEyLCAyMDI2IDI6MDQgQU0N
Cj4gDQo+IG1lbV9kZXYgaXMgc2V0IHVwIHdpdGggZGV2aWNlX2luaXRpYWxpemUoKSBhbmQgZGV2
aWNlX2FkZCgpLCBidXQgaXQgaXMNCj4gZnJlZWQgd2l0aCBhIHBsYWluIGtmcmVlKCksIGJvdGgg
b24gdGhlIGRldmljZV9hZGQoKSBlcnJvciBwYXRoIGFuZCBvbg0KPiBtb2R1bGUgZXhpdDoNCj4g
DQo+ICAgICBkZXZpY2VfZGVsKG1lbV9kZXYpOw0KPiAgICAga2ZyZWUobWVtX2Rldik7DQo+IA0K
PiBJdCBoYXMgbm8gcmVsZWFzZSgpIGNhbGxiYWNrIGVpdGhlci4gRnJlZWluZyBhbiBpbml0aWFs
aXplZCBkZXZpY2Ugd2l0aA0KPiBrZnJlZSgpIHNraXBzIHRoZSBmaW5hbCBwdXRfZGV2aWNlKCkg
YW5kIGRldmljZV9yZWxlYXNlKCkuIE9uIG1vZHVsZQ0KPiB1bmxvYWQgdGhpcyBsZWFrcyB0aGUg
ZGV2aWNlIG5hbWUgYW5kIHRoZSBkZXZpY2VfcHJpdmF0ZSBhbGxvY2F0ZWQgYnkNCj4gZGV2aWNl
X2FkZCgpLCBhbmQgb24gdGhlIGRldmljZV9hZGQoKSBlcnJvciBwYXRoIGF0IGxlYXN0IHRoZSBu
YW1lIGlzDQo+IGxlYWtlZC4gVGhlIGxlYWsgaXMgc21hbGwsIGFuZCB0aGUgZml4IGlzIHRvIGZy
ZWUgdGhlIGRldmljZSB0aGUgd2F5DQo+IHRoZSBkcml2ZXIgY29yZSBleHBlY3RzLg0KPiANCj4g
R2l2ZSBtZW1fZGV2IGEgcmVsZWFzZSgpIGNhbGxiYWNrIHRoYXQgZnJlZXMgaXQsIGFuZCB1c2Ug
cHV0X2RldmljZSgpDQo+IG9uIHRoZSBlcnJvciBwYXRoIGFuZCBkZXZpY2VfdW5yZWdpc3Rlcigp
IGluIG1zaHZfdnRsX2V4aXQoKS4gTm90aGluZw0KPiBlbHNlIGNoYW5nZXM6IHRoZSBkZXZtX21l
bXJlbWFwX3BhZ2VzKCkgbWFwcGluZyBpcyBzdGlsbCB0b3JuIGRvd24gYnkNCj4gZGV2aWNlX2Rl
bCgpIGFzIGJlZm9yZS4NCj4gDQo+IEZvdW5kIHdpdGggYSBzdGF0aWMgYW5hbHlzaXMgdG9vbCBh
bmQgY2hlY2tlZCBieSBoYW5kLg0KPiANCj4gRml4ZXM6IDdiZmUzYjhlYTZlMyAoIkRyaXZlcnM6
IGh2OiBJbnRyb2R1Y2UgbXNodl92dGwgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gQ28tZGV2ZWxvcGVkLWJ5OiBLYWl4dWFuIExpIDxrYWl4dWFuLmxpQG50dS5lZHUu
c2c+DQo+IFNpZ25lZC1vZmYtYnk6IEthaXh1YW4gTGkgPGthaXh1YW4ubGlAbnR1LmVkdS5zZz4N
Cj4gU2lnbmVkLW9mZi1ieTogU3V5dWFuIFdhbmcgPHN0ZXZld29uZ0BodXN0LmVkdS5jbj4NCg0K
TG9va3MgZ29vZC4gVGhhbmtzIGZvciB0aGUgZml4Lg0KDQpSZXZpZXdlZC1ieTogTWljaGFlbCBL
ZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KDQo+IC0tLQ0KPiBDb21waWxlIHRlc3RlZCB3
aXRoIENPTkZJR19NU0hWX1ZUTD15IG9ubHksIEkgZG9uJ3QgaGF2ZSBhbiBPcGVuSENMDQo+IHNl
dHVwIHRvIHJ1biBpdC4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2L21zaHZfdnRsX21haW4uYyB8IDE1
ICsrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9tc2h2X3Z0bF9tYWlu
LmMgYi9kcml2ZXJzL2h2L21zaHZfdnRsX21haW4uYw0KPiBpbmRleCAyZDRmZTI0Y2VjYmYuLmJi
ZjQzMzMwZTEyOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi9tc2h2X3Z0bF9tYWluLmMNCj4g
KysrIGIvZHJpdmVycy9odi9tc2h2X3Z0bF9tYWluLmMNCj4gQEAgLTEzNDYsNiArMTM0NiwxMSBA
QCBzdGF0aWMgc3RydWN0IG1pc2NkZXZpY2UgbXNodl92dGxfbG93ID0gew0KPiAgCS5taW5vciA9
IE1JU0NfRFlOQU1JQ19NSU5PUiwNCj4gIH07DQo+IA0KPiArc3RhdGljIHZvaWQgbXNodl92dGxf
bWVtX2Rldl9yZWxlYXNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlrZnJlZShkZXYp
Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IF9faW5pdCBtc2h2X3Z0bF9pbml0KHZvaWQpDQo+
ICB7DQo+ICAJaW50IHJldDsNCj4gQEAgLTE0MTIsMTcgKzE0MTcsMTggQEAgc3RhdGljIGludCBf
X2luaXQgbXNodl92dGxfaW5pdCh2b2lkKQ0KPiAgCX0NCj4gDQo+ICAJZGV2aWNlX2luaXRpYWxp
emUobWVtX2Rldik7DQo+ICsJbWVtX2Rldi0+cmVsZWFzZSA9IG1zaHZfdnRsX21lbV9kZXZfcmVs
ZWFzZTsNCj4gIAlkZXZfc2V0X25hbWUobWVtX2RldiwgIm1zaHYgdnRsIG1lbSBkZXYiKTsNCj4g
IAlyZXQgPSBkZXZpY2VfYWRkKG1lbV9kZXYpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2Vy
cihkZXYsICJtc2h2IHZ0bCBtZW0gZGV2IGFkZDogJWRcbiIsIHJldCk7DQo+IC0JCWdvdG8gZnJl
ZV9tZW07DQo+ICsJCWdvdG8gcHV0X21lbTsNCj4gIAl9DQo+IA0KPiAgCXJldHVybiAwOw0KPiAN
Cj4gLWZyZWVfbWVtOg0KPiAtCWtmcmVlKG1lbV9kZXYpOw0KPiArcHV0X21lbToNCj4gKwlwdXRf
ZGV2aWNlKG1lbV9kZXYpOw0KPiAgZnJlZV9sb3c6DQo+ICAJbWlzY19kZXJlZ2lzdGVyKCZtc2h2
X3Z0bF9sb3cpOw0KPiAgZnJlZV9odmNhbGw6DQo+IEBAIC0xNDM5LDggKzE0NDUsNyBAQCBzdGF0
aWMgaW50IF9faW5pdCBtc2h2X3Z0bF9pbml0KHZvaWQpDQo+IA0KPiAgc3RhdGljIHZvaWQgX19l
eGl0IG1zaHZfdnRsX2V4aXQodm9pZCkNCj4gIHsNCj4gLQlkZXZpY2VfZGVsKG1lbV9kZXYpOw0K
PiAtCWtmcmVlKG1lbV9kZXYpOw0KPiArCWRldmljZV91bnJlZ2lzdGVyKG1lbV9kZXYpOw0KPiAg
CW1pc2NfZGVyZWdpc3RlcigmbXNodl92dGxfbG93KTsNCj4gIAltaXNjX2RlcmVnaXN0ZXIoJm1z
aHZfdnRsX2h2Y2FsbF9kZXYpOw0KPiAgCW1pc2NfZGVyZWdpc3RlcigmbXNodl92dGxfc2ludF9k
ZXYpOw0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA2MzAwNTlhNWE2MzIzNzdiOWI3YjQ4N2Jh
Y2NkZTkyYjdhZTFkZDQ3DQo+IGNoYW5nZS1pZDogMjAyNjExMTItaHlwZXJ2LTU1YzUzMzNjZTY1
NA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBTdXl1YW4gV2FuZyA8c2h5Y2tsZXNzQGdt
YWlsLmNvbT4NCj4gDQo+IA0KDQo=
