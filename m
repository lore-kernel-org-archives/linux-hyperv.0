Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010000.outbound.protection.outlook.com [52.103.20.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51013790B;
	Sat, 26 Sep 2026 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790387832; cv=fail; b=XWVUbET+e2PO8pZeAvo6g4jtk7ASCZ2E3cnDTEq1md3iq0qlvceJ2h7D1bAGrCPfxabdJqrCO4wJ44PmmsUKxlDbaFmJkEY49Z7fgudChmeDC9BwHTo3KdhX8BAARDyq6R0nKosqPcCZPJ6Wjf74cytqlZmxHJhw39QlI1pHt/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790387832; c=relaxed/simple;
	bh=gURytATRjtSeshg+PCKZ+09z1d+ptdEIsbHtDgWsZpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QbUdq6Lk1ANr6tJx5XVqorxF73XWzwynCgZheYtm/xrA23nTOM5nhQsWdD7ya4mkPW6L7MdTJK2KvfcG9IMMKZYqOrLj6G3cCWNuko2TR2mAvn7ObWoJt0kbEQ40XhT66NCErJD3VpJA0ZgLXwT3LgicxtzRMugwbtah1LyiIUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A00kUIkL; arc=fail smtp.client-ip=52.103.20.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A00kUIkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfkb7AI8Dx5zLGwYeiQdrSKxjcSkU0/cGt/E2vMGg3fPxn4f3I7+r15CYYQu/AMBwLT4Wxh6eUyTyY6JLbmYuDRl8asFkOyrBVsL5TxF/Uu5I9siesDdPzo+9s0Ow76WERvQsW330OzmItht25JRlppnbrnCSxAFhkzz4WS4Dl9g3af5wjwHjrSl2NKYgO4yEjbdJ1UbLKLVI6aTZaBynAlh4eGSLXiH0y/kc8o2BQy8gvF99cw7/pbNq8YWhCnnbqlhb1Ld7l605fbxXr9uSQ1mqAK9ooZqYaf83C2HjmvOLAClTFkd/pKUBJzl6VFyqE7fGMYDY3QeoTW+PZOVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gURytATRjtSeshg+PCKZ+09z1d+ptdEIsbHtDgWsZpM=;
 b=g9RP4mFnJIAxAFrjC6fqCXm2+uH1WrD9ryK8w3oMmTlrOwxpFIH7b8j1oMQ8nm3v+42RlgJ/SVtPP4XeJDztHhzvifgXFaQ1yLFZGJkzdLkgrsunPj9qlrospKYQ7y2CrUcfg/IUzV+3nE+coDQwjehMsVAoyHy5n/rIA4dwidpEkzAvBVEbb6it486olx2UJnsydXEg6WvEb7fV/Hfr1gP7hUPHSHXbYptze0/+Ylvkl+/c+vqtz4vX4A2uuJ/7aEKcHOshRIK3itZhlfkms8PB4lvgkN2IV3xjbJpF1n1DFubDH+XamEC9YExU+s4H7AYZYlhRS/PcviZi3SeWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gURytATRjtSeshg+PCKZ+09z1d+ptdEIsbHtDgWsZpM=;
 b=A00kUIkLvW0oNKqCDSYJFCPZZRtnFh1/ZZB+FbfzFegLe6RY16DhT3AvVa5CUkqXVwAnbxxjUITOvwWVr585xzB09X28RqFxXijCUTrofZ3wByJaFCeLjjeyOwcGDCWR8JNDXz+rGgjnjQwtzeXm6oLO9laHuvOtL5UU0n/IH8f4Nn+XnaVDsaQLwT3TCL/cGuS0puwwYhP27eNNEDAVOzTQLtFNVOULsQRnPyR92vMFhWlXOqof7sQqX+9/p4fIvWfxCuqlwBDAp7RgYpBM4fIDGSq2DA8qgj6xtR/w8GzfZsEchp7uibrrSJkK+qxOs9w9adMKYHyrxu5AR4uQVw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB11944.namprd02.prod.outlook.com (2603:10b6:8:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 01:55:09 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 01:55:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Bill Wendling <morbo@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>
CC: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"codemender-patching+linux@google.com" <codemender-patching+linux@google.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with
 __counted_by_ptr
Thread-Topic: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with
 __counted_by_ptr
Thread-Index: AQIiBVB/vlWtbMtYmjm34FwfBPcYqrZWpwsQ
Date: Sat, 26 Sep 2026 01:55:08 +0000
Message-ID:
 <SN6PR02MB4157A2693AE5369CA19A84DCD48F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260923055320.2602534-1-morbo@google.com>
In-Reply-To: <20260923055320.2602534-1-morbo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB11944:EE_
x-ms-office365-filtering-correlation-id: 7f540334-9e24-4214-452a-08df1b71316e
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CITcTSlV0Irpr/l8JdFh45drNmRgdv59BE1O0gAgunrMFgRe/o2BmSr3fhSjiPxXcPnEsBNyHoHSGIDqnKIz4/7BSJsWzfWqWjbgnVmdvlEs0Qe4K0qTVAcQNXGImK/xUxafrLBC2G9rO4UHm4xj51IXKEG1C/Zs8m4LuY/2ccDxrak6BXyweFsPZPl6YKB6AnqSFzoGq6nJ57HgoFA1KyE042uU274XnGnBO8dVhrpFXNHkz9b+5lHVqZxUYk0v5WL+nnQbgJ/Atije5eakx5iNzOuE8E4eCI1XAHmCPQuNHA7v90JKYUJjX6nd9IBhsr0q9vdoOLqWPd596TBS94rkyZbLwEd3D6w5M3g+65gtSwqyTACCrEPxUJpr9d64uNdSlsKUUVcS3rGYipyjfEMLgi2Cm5GOtdGCSDPsLWmPiIx8ZfgY8i9fseZfCtXpuPpsB0FPa6TtA9hTt6ePXg2/TaFqz55JE1E91qv4aAgvEQ8Dft3LbLzoqfuzc8yW/zhUSj90bdfWo/QyGMnMD3+LXK0lsgkOKLxUcGSe9NjFj3VfE5o0E5wvAQzbV6wD7y9EVExNDxogNnJsfkKO6JWC2v8eSGj0JpxULaprwvLNViBq/whzDpPbfieaQS9jrYYGZAibMH7vwlyv9wgEBdhH0gv15V6XWIOB03McpeY3sk9H2/rsNA7+FDKs8Vl0a1Pwo1zQBK50d1pxcnYkmmxCFwVTzInpH0bxyutMuErCg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8062599012|25010399006|31061999003|8060799015|19110799012|4140399003|37011999003|15080799012|24021099003|55001999006|3412199025|440099028|102099032|40105399003|52005399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vm9VaWRGMFk2dDBMcllRYzcxblUzcHF1TFNMRncvR2dFM0F3VmxtMDF0VVF4?=
 =?utf-8?B?bTJ6YXhVRkJyenV5NWtUNkw2VFlGOVdkMkswNGdDMG9JOTNqV2FBbEJncC9N?=
 =?utf-8?B?QUJUTjA1S2kvblV0SkVqNURVTXNJREJRamlwN3pjQXBXcFNuY0R0MXRqT2lX?=
 =?utf-8?B?aFhWNUJQOWlMQm56V1ZYbzdFTkQ3QWNiUzZ4SmNCKzE5TG0reko3dUxZYTRR?=
 =?utf-8?B?dHllNXVHUzExcmw4R0UveCt5cHBxREZYR0RwMSt6b0MzSE9kdmxkdG82cXJL?=
 =?utf-8?B?SVEyN3Z6TVQveUV0NEtaaUlFdXdWRE84NHNTakNIZlJKRUNtL05vT1NrN2x1?=
 =?utf-8?B?M1Z1eGkzYjVYcUgwcTFMZ09SbTJYVmI3QkJod1hVWWx4OWhRWHVTUEhyeUl6?=
 =?utf-8?B?OXR1T0JVRk0yeTNFKzB4dHhzSkVMQmo0NzNVNlYvd3pLRDdIRnlFU3lZZmpj?=
 =?utf-8?B?WFhkcFIxdzVrZ1E0WTR4VEdEekhSSkdkQWdUQ0R2Y213YmUvckNjVEYzS0lM?=
 =?utf-8?B?YVlaSEZWVUxMZXo3bXJIamtKUFZRRzBXWTRSd1NVSHNiVFArTm91cU1XeVhW?=
 =?utf-8?B?L0hIY0xpOWlKWVFCM3BnT3E1ajhGN1h4QXJDbERseG9LWG1GTVl5UGEycXV1?=
 =?utf-8?B?WHE0a0xkeDFtRVAwODllaEk3RUdzTEhwK2wvQ21FbDFQU3l1ekFaUHJGM2dK?=
 =?utf-8?B?a2VhSnJQKzlqcXgzWGhGSFViUms0VFNlSWhRb3l0SDZpdzlqNGMzRUY2b2lJ?=
 =?utf-8?B?d05BYXA1MVJhUUlSUnlFRVI5VWw5N2UydERXMnFEdG04aG1CRUNYNk1tQjN1?=
 =?utf-8?B?NWVYaHRWSGpkdmlCZ1pwMmpFLyt4MjluVlVxTjEyM0xjRVhrSS9acmtjVkw3?=
 =?utf-8?B?dFUxUW0rRFdjU05LL3l1MEJURklyaFhxa2ZGSllrQk55djBWbDVMREQwRGpY?=
 =?utf-8?B?ZGJzR0djcW9HenEraUlTRllOOHZHSU44dzlpL0dvTVU5T2FwcEVndHdEUUxn?=
 =?utf-8?B?VGlKSmZyWDZpSkY5anJMeEg2MlNIT3ZhcTNyRU5GcWJuQlhhaURlM0w3OWFE?=
 =?utf-8?B?WHh1RnhrTFRvK0c5WTlrcnBPZnNMVThGWm1UYUJPakhkOEphMGVLV25vdmN1?=
 =?utf-8?B?WkdzWEJIZzdhNFA3K3FWdmphMnRjck5OODg2ai9LcEdZLzljMkZ2d1d2dCtT?=
 =?utf-8?B?N0tyL05VV2dNQ0p3U3lmSjRhblVzSEpXSHJXMHpmTzZYN1lLdExDZURUTHNl?=
 =?utf-8?B?RmxrT0RyQTMyRTJESjhDenFHcEtZZU1Hc2Nub0NiNjNFMkRXUnUrSnpTcVE0?=
 =?utf-8?B?NnRJT0UvcldERllqNjRkMkIxby8zd1pOcHJIRjlyZWlxeFNTTXN5bkpLUERs?=
 =?utf-8?Q?kifa8myocG06pmfzy76ilm8EcKOvH5WQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1FKdU9jcmZqeWZneHdhWFlzWFdhNk5Xbk1ZSlRxOXFMMGxsSW9iUE8wUVF2?=
 =?utf-8?B?amhXcGpjSWxFU2dFYjFNcXQxbnJSdUhweTJqemdxSmRTUm5XVDlkbWhUQVoy?=
 =?utf-8?B?TUdCSE9OZFM1ak1vaERPTW5XTUlFMEI5K1VEUXNqaVRSZ3BmWU9NclE0THRk?=
 =?utf-8?B?VTNGRE0vRFI0WEZKbjh3Y3E5YjJWMWF1aEZ4Q0xrUlJmcGpXWmNWaFZDQkRv?=
 =?utf-8?B?NHcxQ3hIZFpNVGlKTkNGTEJlV0xGSFZwSmNCZlpQYVA5V0l5UlpFMWpvcFcr?=
 =?utf-8?B?bmFkbWRWSm1hR0JWQm9MSjdIZjIxTWtrMWVoWWdJRHdCaEs5eDBMMlUwNEFj?=
 =?utf-8?B?YTNqZG10OEhyb0M0V1ZtR1hidG04Z1ZpaHRONzlYVWVLc09IcjU4TVBjS0o3?=
 =?utf-8?B?bWxRdkY2cmhGTE9jdXl5UG1qTG8yV3drTnpIbDlSNXgxSXZPeXJvM1ZSVitn?=
 =?utf-8?B?d1FpNUozUnZ6bDYvVmJobzZUSFptSHBNVHZLNHVSQ0FVbGFLSGJTczg3WDNZ?=
 =?utf-8?B?WHMvMm83K1BuUEZjZ09USy9YMDNlRHBpWHUvV3EwV3k4S1VUVERKbjY0Wk9X?=
 =?utf-8?B?S2pGR2s0NXNzeU9sdUs5WmxHMzVmNkxiOVMrY1NlTm1jckxtT2JYeDN4VzFs?=
 =?utf-8?B?TDh0c3psYk0vSGRFUXdobVpPV001dHJkSGx0bzFLR2Z3UFZQT05TUVJPeDAx?=
 =?utf-8?B?WS81dXMwVXRQN05yT09sT1hJUlVMTlFPeG9WVlVqVTRmdU01ZlVKdWQzUkRC?=
 =?utf-8?B?MnJocU00WGlXdGtNQStCZjlkUThLUVJVODk0U0NRWHVrbnExZFhVa1dGWjFN?=
 =?utf-8?B?aVpxREJsc2JTZ0ZhOXdQUVRDUmZuMUR1QXdTRDhUUWtvbkZIdXBtSUZNc2Jx?=
 =?utf-8?B?MVJteDQybTIrMjA5ZGwzRW5RcnFaa3MxdkJrVmh5UFN3WDdNUmcwMmxnQXBt?=
 =?utf-8?B?L0tFV0k5R2Z6ckVzZkpoR3F0WDlaamlKVWVTcWlRVmx6SmtWa2Y1V0MvK3ZO?=
 =?utf-8?B?aTNucm1FcytTYjZKWGRQSm9kVlFRTjVmVEgrbjZTUzMxbnFHVGRUK0J4OEN1?=
 =?utf-8?B?di9kQ0RUK0VHaVJUeWtndTYwZHd1MlBqZG53dXlFN25KTGY5Y2ZPbkJkTmY5?=
 =?utf-8?B?MzJ6cFVyeXltMmZVY3Z1eGdFbXpYSnpaOUgwd1BpNHNHTFh5K254YUY0YjBz?=
 =?utf-8?B?VGU1RUpTbjdXYyt5U2NUUHI0OW52ZUJvblpaZzhacERvWWtFNXl4NDdLMnMw?=
 =?utf-8?B?THpMQmZkemh6YVJaT1RGNkV4QzJvT3czQXRDSWc1YzJ3Ty9ISUpnTStSM0xM?=
 =?utf-8?B?c2dML1VldXZVVnBEVDVtS0VpaFlDQ0NuTEhtcWdRZ0E2bWREMDFRSE95bFhv?=
 =?utf-8?B?Mno5Q0t5TlppZjg5KzFxOGtXTnF5ZUdYRTZyYjlTNXRKRnBGYVZLMDBIbDZG?=
 =?utf-8?B?VG96cVUrdCtUZWlWWlBPUUJKQWVGV1V3b1hSYUVKOWJ6VTZaVXlWZXhEV01R?=
 =?utf-8?B?Vzg3MkxESlpGRVQ1MnZsZHFKZEZmTU56UXVwMXZ6aEhsSkZBZ0dPY2dHT1lp?=
 =?utf-8?B?MTRSb0lJcjhmeVpJT2VIaGhaeUtTMWlmR3p0OTJsM2xWV0xUV2JDVFl3bnRr?=
 =?utf-8?B?YXJnRDhlVnZZZERLdHIrN25lMEVud1dmYWxvT2RDODBLK2lJU2IvTWJ3RzMv?=
 =?utf-8?B?Z0ZTNkhKbU1BRnhjbWJRY3pYdHVWaTRpYlI1SzBWbi9jeHZjbFFNNkxmdzhx?=
 =?utf-8?B?UWdLRXZYbnROelhVWDZrMnBPZ2xxc2ZEelVxWTRDNEJrTVYrV1VzWGZWTk8v?=
 =?utf-8?Q?I0Oh3ogZg1KstPA7HkigywS8D7AbQl2feSESU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f540334-9e24-4214-452a-08df1b71316e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2026 01:55:08.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11944

RnJvbTogQmlsbCBXZW5kbGluZyA8bW9yYm9AZ29vZ2xlLmNvbT4gU2VudDogVHVlc2RheSwgU2Vw
dGVtYmVyIDIyLCAyMDI2IDEwOjUzIFBNDQo+IA0KPiBBZGQgdGhlICJfX2NvdW50ZWRfYnlfcHRy
IiBhdHRyaWJ1dGUgdG8gdGhlIGJ1ZmZlciBmaWVsZCBvZiAic3RydWN0DQo+IHZtYnVzX2dwYWRs
Ii4gVGhpcyBhbGxvd3MgY29tcGlsZXJzIChHQ0MgYW5kIENsYW5nKSB0byBwZXJmb3JtDQo+IGNv
bXBpbGUtdGltZSBhbmQgcnVudGltZSBib3VuZHMtY2hlY2tpbmcgd2hlbiBLQVNBTiBpcyBlbmFi
bGVkLCBwcmV2ZW50aW5nDQo+IHBvdGVudGlhbCBvdXQtb2YtYm91bmRzIGFjY2Vzc2VzIHRvIHRo
ZSBHUEFETCBidWZmZXIuDQoNCkl0IHR1cm5zIG91dCB0aGlzICJidWZmZXIiIGZpZWxkIGlzIG5l
dmVyIGRlcmVmZXJlbmNlZC4gVGhlIHZhbHVlIGlzIHNhdmVkDQpoZXJlIG9ubHkgZm9yIHRoZSBw
dXJwb3NlIG9mIHBhc3NpbmcgaW50byBzZXRfbWVtb3J5X2VuY3J5cHRlZCgpIGFzDQpjYWxsZWQg
Ynkgdm1idXNfdGVhcmRvd25fZ3BhZGwoKS4gVGhlIG1lbW9yeSAqaXMqIHJlZmVyZW5jZWQsIGJ1
dA0KdGhyb3VnaCBhIHdyYXBhcm91bmQgbWFwcGluZyBjcmVhdGVkIGJ5IHZtYXAoKSBmcm9tIHRo
ZSBzdHJ1Y3QgcGFnZSdzDQp1bmRlcmx5aW5nIHRoZSBidWZmZXIuIFRoZSBtYXBwaW5nIGlzIGNy
ZWF0ZWQgaW4gaHZfcmluZ2J1ZmZlcl9pbml0KCkuDQoNCkdpdmVuIHRoYXQsIGlzIHRoaXMgcGF0
Y2ggc3RpbGwgYXBwcm9wcmlhdGU/DQoNCk1pY2hhZWwNCg0KPiANCj4gVGhlIGZpZWxkcyAiYnVm
ZmVyIiBhbmQgInNpemUiIG9mICJzdHJ1Y3Qgdm1idXNfZ3BhZGwiIGFyZSBhc3NpZ25lZA0KPiBl
eGFjdGx5IG9uY2UsIGR1cmluZyBHUEFETCBlc3RhYmxpc2htZW50IGluc2lkZQ0KPiAiX192bWJ1
c19lc3RhYmxpc2hfZ3BhZGwoKSIgaW4gImRyaXZlcnMvaHYvY2hhbm5lbC5jIi4NCj4gDQo+IFRv
IGVuc3VyZSB0aGF0IHRoZSBjb3VudCBmaWVsZCAoInNpemUiKSBpcyBpbml0aWFsaXplZCBiZWZv
cmUgdGhlDQo+IHBvaW50ZXIgZmllbGQgKCJidWZmZXIiKSBpcyBhc3NpZ25lZCwgd2UgcmVvcmRl
ciB0aGUgYXNzaWdubWVudHMgaW4NCj4gIl9fdm1idXNfZXN0YWJsaXNoX2dwYWRsKCkiIHNvIHRo
YXQgImdwYWRsLT5zaXplIiBpcyB3cml0dGVuIGJlZm9yZQ0KPiAiZ3BhZGwtPmJ1ZmZlciIuDQo+
IA0KPiBDYzogY29kZW1lbmRlci1wYXRjaGluZytsaW51eEBnb29nbGUuY29tDQo+IEFzc2lzdGVk
LWJ5OiBMTE0NCj4gU2lnbmVkLW9mZi1ieTogQmlsbCBXZW5kbGluZyA8bW9yYm9AZ29vZ2xlLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2L2NoYW5uZWwuYyAgIHwgMiArLQ0KPiAgaW5jbHVkZS9s
aW51eC9oeXBlcnYuaCB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvY2hhbm5lbC5j
IGIvZHJpdmVycy9odi9jaGFubmVsLmMNCj4gaW5kZXggN2U0Y2M2ZjU1MjM3Li43MDQyZGUyZGQ0
ODEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaHYvY2hhbm5lbC5jDQo+ICsrKyBiL2RyaXZlcnMv
aHYvY2hhbm5lbC5jDQo+IEBAIC01NDgsOCArNTQ4LDggQEAgc3RhdGljIGludCBfX3ZtYnVzX2Vz
dGFibGlzaF9ncGFkbChzdHJ1Y3Qgdm1idXNfY2hhbm5lbA0KPiAqY2hhbm5lbCwNCj4gDQo+ICAJ
LyogQXQgdGhpcyBwb2ludCwgd2UgcmVjZWl2ZWQgdGhlIGdwYWRsIGNyZWF0ZWQgbXNnICovDQo+
ICAJZ3BhZGwtPmdwYWRsX2hhbmRsZSA9IGdwYWRsbXNnLT5ncGFkbDsNCj4gLQlncGFkbC0+YnVm
ZmVyID0ga2J1ZmZlcjsNCj4gIAlncGFkbC0+c2l6ZSA9IHNpemU7DQo+ICsJZ3BhZGwtPmJ1ZmZl
ciA9IGtidWZmZXI7DQo+IA0KPiANCj4gIGNsZWFudXA6DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2h5cGVydi5oIGIvaW5jbHVkZS9saW51eC9oeXBlcnYuaA0KPiBpbmRleCA5ZTEwOWQ5
MWFhMTQuLjQwODc0OGEwNTQ0MCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9oeXBlcnYu
aA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2h5cGVydi5oDQo+IEBAIC03ODAsNyArNzgwLDcgQEAg
c3RydWN0IHZtYnVzX2RldmljZSB7DQo+ICBzdHJ1Y3Qgdm1idXNfZ3BhZGwgew0KPiAgCXUzMiBn
cGFkbF9oYW5kbGU7DQo+ICAJdTMyIHNpemU7DQo+IC0Jdm9pZCAqYnVmZmVyOw0KPiArCXZvaWQg
KmJ1ZmZlciBfX2NvdW50ZWRfYnlfcHRyKHNpemUpOw0KPiAgCWJvb2wgZGVjcnlwdGVkOw0KPiAg
fTsNCj4gDQo+IC0tDQo+IDIuNTUuMC4xMDgyLmcyYjkyMjZiYmMwLWdvb2cNCj4gDQoNCg==
