Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795552715;
	b=Fmw/h97jJhq4xYECDrHC+oMmnLND/E536T5FKgVUdIXtyn1oqnKm5PUagQuSURlst61g
	 tquvGZjuUkCWoK7KcHWRh6U7TmypGQWqj2Bl+pgWSFwMA22k/n46xfOjj89J9l5lTfJl4
	 +n/DU0u39CY/GEpx6l6q9umQsYxScqcyRZ1HGdLG6WlYV1sAB5W8qNlNCGV9VhvcGbkIw
	 J1u7svwsDpbllPSZezHL56dsVblfmFZTzy7EcTEx6YzbS2PJiot0OOj4v1TZ6nWMjE1zj
	 mF9vxx3RTAUktdCkv+GWCWi/Hbv0cOszshsZvLBL1UJ0WbTWIT/0ZzAFY8vHI2qVFjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552715;
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
	bh=SahRXgWvk5cVmDmjSlq7zR+g4wkBeoa31vRx5n02LzY=;
	b=CGST2qDjnzHXpRWfiARehnef40It5RIqzhLrv4Ubq34hESP/vOkDES0f1Q5PgEVQNjrY
	 DL0/Wsuqo5hHJnopnWwb43iBY2AW7cZrjE9OQ2oaN7ZcZwM79BQi2Z5NNFiCnZe/qdDPS
	 RGQMmKaV+e9tEW9RQ/iDkPltaFwUN4QZKnbd7T6tG29OK3tzxYbFOKLLfK0gaVesPFJgm
	 YgiLlctbASwjmUEeKobrY+y8nXw+sNvlec0DuGQkbvxzY7lJoEZCKY6XfxuTr8Bt/b6nw
	 2+cymJMoVuJ+ozxcuQ9k2buzu71coI+RNsFYy+AQYS69RVLnArZ8uU0Vfm+0aR/qEDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pZ1P8hTW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.4
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010004.outbound.protection.outlook.com [52.103.20.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0F606A31E;
	Tue, 24 Nov 2026 20:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A0F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pZ1P8hTW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyId+mZTghdbIp8msq2oXrrPT578iLAKL7zonZYQ9rwkUYzQge8PGnTUelQsknV8DRvSMrTqXr7l+fB/X1H3MRuKI83fdw+ScR84U2KpXU39NpOvvMAjss740Di2xw5GUOpqzYC/2il/JcadrRws5RiHrZomP6qymc72Sd9r0AXmml8py9lr3nQP8FOqVEwp8+yulfKqziH49ELpwAXlhvyH/WAbwNQ66DD3igbA0cEGMzdU0wIRUo4rncdCl8CVtbFems1OiUn7cf7nQrasxkOD50CIMcHF4DcuB4thbN6nyMmTYdROlPtQyFRjRQQfY9yhmoFM1aKLX1AHuh6clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SahRXgWvk5cVmDmjSlq7zR+g4wkBeoa31vRx5n02LzY=;
 b=Rn68b1My64Ct6O20BLOpW0LtoVumBoeC05vxA7LNcOHIVw0nk23dMxG3PEpo8sEiwwHK7v+7mSMZ+3Eg1yHy46NHcW9o0H6jim40nDrl8NNkcAPlwpDyGECGxS+8eMPKPzsr2iyTRLh3pc7NPcKWxiGNg18JTBiuqhAAUzcWFUY4oyl0AaFeRTMxmZJURRqkYoJKIoYH7sPSwEH3IcOrFKkbIY9a+tgl5V3gsICO/GOaM/euDgsC+LXpGvnCZK7cvKI3XPLL6jbwVSGaX2IDYcqO/8fyo2EffyQolTHMOHa3wHPTvRRostP5aZ8LHJ5UuQDEIk2wJfvZsOpEVtghng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SahRXgWvk5cVmDmjSlq7zR+g4wkBeoa31vRx5n02LzY=;
 b=pZ1P8hTWYJPrSpuLwuC5nl2sul+U5Dy5a47bl2tQ8b7hEtpgmrParrK1wwSxvTMmz7hBeNnXoFYaIG6wzas6Vtt/3NxIVjExKaREXy4dKAicLdsM2IxfdBuWly2BrN+YdkXBst6kBHvYV+N5wxXZwz7EVcxf+YIX5Z4lOV+ECxlxfqJiFjqZRqskEgznC9V4JlMOBkVoUgJns32JmKaLGEM1mjQAQwvaWb/wZDs7c10x86HjjF0+LZZ7lIJugkUl7QLpSl1Zr2psdrPOgxHVL/Cr40007tG5YaBbSCbVUNlxUjcowRzdvq1Ic6VkVhxfJYn9COveli9FguXErsMzmg==
Received: from DM6PR02MB6860.namprd02.prod.outlook.com (2603:10b6:5:21a::13)
 by CY8PR02MB9521.namprd02.prod.outlook.com (2603:10b6:930:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 20:38:32 +0000
Received: from DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0]) by DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:38:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>
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
Thread-Index: AQHddnQzkd+wmIinp0iD8tjoCXhsg7c8ZR+AgABsZgCAAOkbMA==
Date: Tue, 24 Nov 2026 20:38:32 +0000
Message-ID:
 <DM6PR02MB68607FE813E55D371E03B4E2D4442@DM6PR02MB6860.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-3-namjain@linux.microsoft.com>
 <MN2PR02MB6863198AC15E17474598EF23D4442@MN2PR02MB6863.namprd02.prod.outlook.com>
 <14e81d94-1219-4999-8d32-a3f8d1a90e50@linux.microsoft.com>
In-Reply-To: <14e81d94-1219-4999-8d32-a3f8d1a90e50@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6860:EE_|CY8PR02MB9521:EE_
x-ms-office365-filtering-correlation-id: af64b754-1c31-4921-cd6e-08df4a6ae7d9
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxObkrM6g+zZ+UkEstrNWhRKSZ8tSGJbPUDVOuoZTSowTQDVrxnGl9UBFxgO3sEEX4poIIgNdjJwyB4x1x0w8ZhM4LFPDDGNv6WivPlO4wJ1S6jx2Rxf/Y3UMfuX43M52QWgfx2IdJ+WkChqes1sQcaoiaIH9FBU+BBMjr7fvECrtqlk0crU5QHEWsrfVOl+Iu+2nKd+QyMUXJMoeYeDp5nFkV95hk0PGsgYOvNhMYeCWnMRRJecuHoVuajtWmfEk29QkpMGAc6v1ej5KYWjG9T9rwgZcVwVvvx7fKBCEG5K3P3W8YaLvZ3QezKF0CDgQ9zJKDx6GZgblrc+1Zh+7+n+0l4B3b13MyNPUF67T77GIhBNWmKUGbkViGHoPOxOyoRtVccUtW38BBJsdBW/F+bDf3DyK2xpFPIdu8uWFA1fRNl71CT/L3GcmOFGEZqTT4GllGDPaC8af7tHUOo6XISsTltO2NVj8JyxAxk2X2JE7KYSOAVKftBCzKlNE4f8Ml04IWrHQUG0o+21b4T3pDkeKq0dKkH1M6nNsS78g4bXrUNBR+SutmNyD7D62lcHq/ZeftS6Xo12xbe5D5zBPTJcNxP9HHuqWxdSf5HxPXSR9AnNiHY6d7Q46HMR/CN/8ht+8Ei4mPsClmt6+oQLJQbgJ8Nk/o7thJlpbkogxg+PXvZksG/0O5s6Vx3umEsWUSCKNFRagAxwK4fYSaos+cxpP/DPdEsfw3MoQ4Qb1GniZ8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|2604032031799003|24021099003|55001999006|37011999003|19110799012|8060799015|8062599012|41001999006|15080799012|13091999003|51005399006|25010399006|31061999003|102099032|3412199025|440099028|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?czJSaUJoUG9pSDhVcFhrTFI1ZWIyb0RJdEl0QTg1SmpwUmlkbkZrSDJzS3hH?=
 =?utf-8?B?dUNSUDdtZEtWc1lSWEdSUE84c1pHcmFpN3hxUHRFOU4yVEt3ZVZYcHpuRk16?=
 =?utf-8?B?dXI4STNxcFdzcHFsRE1pNVVzdm9xd25panduSUIyMTVPb3p5d3dMUFhBT3h4?=
 =?utf-8?B?cjB4Qmhsa0R4ZDZRUkszVjFNb29Wa28xSWU5YzduZGxTRCtiVHVrajZxeDBY?=
 =?utf-8?B?QnhlM2VJUkN4ZXVHVzNzNVQwblp6T0luKzEwSEFkWG5DUTJJZTBZNnF2a3ZV?=
 =?utf-8?B?RTRac1N6NW91UXV5N08zd0oxdk1CV3pVLzhMLzkwWUlkQjJpek5mQVNxbERD?=
 =?utf-8?B?eHVlQlRTckNQSVRIVStNcEZDdWpKWnB2S0N6cks4TGFPWENJK3Z1anBxVWU5?=
 =?utf-8?B?dDN4L1NZZzJld0plbGFCeGZjcW1idkE4T2g1dFVZM2NLenBublFNZU56U0l2?=
 =?utf-8?B?UFMxK21qaGY4bEV6NTlIVHE0eEFKQ1NGVUtDOHdhK0QvS090eDVNNVF5NWI1?=
 =?utf-8?B?ZEgxeGxUN0RJVUVpNnpDenYzNm9ZOXVGWTA5dlNKV0EvTjBsKzE2Qm5hMjA5?=
 =?utf-8?B?ZTZ4WWpzK0RJK2FDeEUwNU9UempLTHUzUUtuRXNNdXNQTGFGK1Z0ZnNWRURk?=
 =?utf-8?B?OUtZeVR6Z3BJaDR6OFQvTXc2UU0wa3ZCb1FENkRVTlBZMjIwbW4zTjlIUkdJ?=
 =?utf-8?B?RmtuaUIyUE9seFZnS0U4dFFiQmdONUdISFJiU3k3OUwxUjc5cE9YbUtnRm5k?=
 =?utf-8?B?QXVkMmNKNHhmR2ZjdUVOTUpYd1JnYVo4SVplOEluckNzYzBRcW5YUkNoK3NG?=
 =?utf-8?B?QmZVVW03K3dYNmJEMytpblZ4Y2d5SnUzWjJ6Q25nNmZnNlBkSlU2N1BCM25o?=
 =?utf-8?B?QWN0TXFSNTZha1BXd2gvSjJPOW04djcxSkJPMDFkU1hhYTNwVi9VaE5NYkg2?=
 =?utf-8?B?MDBESW9ncVV5dmVHRUpEbGcreVg1ajNjL0creDBaTW05ZmJBZCtDTVhCK2FW?=
 =?utf-8?B?M2Y5Z1czTHg5ZHErNGMvMC9PY3RzbUIvRm9aOERyY3lnbVVaWjFnR3JRejYy?=
 =?utf-8?B?OG9jQk1HcUtmT3FOUjNoZUtrK3FaMDNETW1aRG8xWGxhREUwaFNoMnNsYnhT?=
 =?utf-8?B?Q1k4dmdNcHZLUjVRdFlLR3dNSWdRbllBZ0dVd1ZmQ2xVaEUvRzg1WjJDN1pm?=
 =?utf-8?B?Mzd6TGVHYnNOVkFLQ0NFNHIyeEcxNURvQkUrOUZ2Mmt4VEdqZnZMeisxSktL?=
 =?utf-8?B?dHBDeVNKdUQwRUkxLytyOXY1amRmSU1OaXZIZGtJWlFEMjZlV2JOMjgxWHVN?=
 =?utf-8?B?Y3BaVHpOK2tScGJSc0JRVmhYS0hlRTY4Z3pTQ3U4Z3JVT014MUJyc29OWWpN?=
 =?utf-8?B?NmZPYlVFeDJoenFueDVBZWhXNWVMMWpkWHowck1PTm51Qi9Fc1lCZnd5Q3Mw?=
 =?utf-8?B?a3kvQjVvNVEvZzNuMEVLWVk3aWZTS0hwR1krVTV4UEo0UHl6dWplOFdNTlky?=
 =?utf-8?B?QnI5cWdHeW0yczJCT202Ni9ZV2Y0N1NucUQwNkpoYkE2ajJFUUsyZE1uT2Zz?=
 =?utf-8?B?RDY1Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFY5N2haaytxYmVWMFluWEtMVGVHazkxb2hLWHVVVElJN2FqYmZpOERIeC9F?=
 =?utf-8?B?dXhaclJ1RkZoMk1UQzBpVXF3MnJGSHpteWRHZUNCaTFkb1o4MGJmS0FKYUNE?=
 =?utf-8?B?VzRZZUJuL1ZUVjd6cUh2Vk1VZThJdWQ0cGE4b3J5RW1OSWU2TWh4U0RQeWxT?=
 =?utf-8?B?dXFBalB2NmMzaTNCVTZTSmZkckszbkdObWNXTW1NMDZoczN3M2tDdHZIZm0v?=
 =?utf-8?B?T05uWFN1c2pyNGhpSUNDWEFIdlpERXhJRnY1Y05TMWUzWjBEUmNrdGVzZllH?=
 =?utf-8?B?cHJpb3FPNytuakdQeWdlZVRTWFdJN3pwaE9HUms2M1JrVTFESHE1UkVwRlN6?=
 =?utf-8?B?Wk5lRWZ0U2Y3Y1N2eVpsb0l6MW92UE9uK1dVMzR2T1ozdllKZmozKzRDbE5w?=
 =?utf-8?B?YmNoVU5WbTROYlU2bGo1eERzNC9uaUw4eDF5bnY1TDcrRmgzMnNxSlpvOTdP?=
 =?utf-8?B?UGdFQzZHQUlEdithL2h0bWQwSDV3d3lVNWt1M0JOMm8wT0JyM1htL2Y2YUlU?=
 =?utf-8?B?c0doKzc1TE1GQTd2NlpRZDc1ZUdjczE0OXFyOWd0c2J0NEkzNGxzZStvT1VH?=
 =?utf-8?B?WWo2QVNBZ1piMTZLOUZ4ai9CWTNpU0RMYzMyaVFQNGpqaGQ5RTQ5bEd6Ky9B?=
 =?utf-8?B?SncveEt4ckxheGkvWU5YQ1VVUHRuVlFMQ2hSb0duV3VQc3FKRXBFL09la0J4?=
 =?utf-8?B?bERPWUtsY0VVN0IxelBiUDNnaWw0L3RqWi9jc2V5NTFyR3E3NE5JVVU0ZnZS?=
 =?utf-8?B?aWRBUVhQdTRBM2UxVDQveEdZK3RMS2xqQUpBY2k3SjBtamlhRGZxaUQxYXVq?=
 =?utf-8?B?cGh5MGFDSUNiaEpNeFFlN2VidHcvaWJ6Zm5qV213WGJIU0dMT1EzMnhudXU0?=
 =?utf-8?B?MlIwVXhVOE9QWHlhb1doQXlkWDJlSXFlNzNvZGN0dzdDVmttNGlsb3NFS1pi?=
 =?utf-8?B?cThxY3IrenJzUHJSZXJhWVVNWVNiWFM5TWQ5NVV2Z25JdjROZnc2elIwUVFk?=
 =?utf-8?B?NWhpNW8xaDE5NGlGZVFQRVdEZXhKUW5DRk1DMzVjQjh3ZnhqV0gvQTdBT0ls?=
 =?utf-8?B?NXNXcCtoVDF4MXptYjF3ZFdqcEEwNG5sOXVaaWNQV0ZhTllHSUwyR2hFWmh5?=
 =?utf-8?B?blJTYTVLcVZDNnBXTUptc0thRW1XTWlGOVY4OWw4Tzc2MENJYVBFcWNHRXB1?=
 =?utf-8?B?T2UwM0tTUlNmNEdQcUtoa2pRZU4rcmF3YkJjdzBXL2ZmcXh1NUZ4bXRtZUhn?=
 =?utf-8?B?UVpXanNxMENwZ2tCNFV5cW9iNXFtUUNyc3VXTC9Ranl0a1hGK2w3VHVaMHV3?=
 =?utf-8?B?Z1ZOV3pla0RPR21lRWkzU05qMWVyNkdVYkdRYndlTU4rWFBjS0VUZm5CK1ZR?=
 =?utf-8?B?Z1pSWGU5RGxRSEk5dFdTb0xFTlpkSk1EMGRmdCtHQmEwaHVWdFo3K205S1Vw?=
 =?utf-8?B?TTNuemlSWUlRdnZLRlhEeEYyVHcrMFV4YXdwWDNwTEp0aDRKeGtwdVBSTWVU?=
 =?utf-8?B?U281M0ZPNzNGTVBzd3JCWTNWN295WGdjUGZ4N1J1c1RjVExOR3BiTWxiTEl1?=
 =?utf-8?B?NlJIMllrckNOTm5oYmVmbDN3Z2VCdTVYTXVsN3NGUVA0akhZWEpVOU96cjBT?=
 =?utf-8?B?c09JUXR2R1N1cmRzZmhCSVlNb1VMMUx2ZmxtcnZQMXpPNzJpcDcxNDJiczVm?=
 =?utf-8?B?d1kwc1ZKcm5kR0dLS3kxVFMySWZSOXRTY29KcTRNdXpSa1RkbklYRm95djdq?=
 =?utf-8?B?elpDWkNobXZ6T1pMOE9YV0RwalNKbFcrZUZMNFVZc3Vlb0NQQW1PMHdNVW05?=
 =?utf-8?Q?y+2FdOtv0agpyHRLJ7D3BEIOWdM8SltCHst0Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6860.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: af64b754-1c31-4921-cd6e-08df4a6ae7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 20:38:32.6636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9521

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDIzLCAyMDI2IDEwOjQ0IFBNDQo+IA0KPiBPbiAxMS8yNC8yMDI2IDU6NDYg
QU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE5hbWFuIEphaW4gPG5hbWphaW5A
bGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTcsDQo+IDIwMjYg
MToxNSBBTQ0KPiA+Pg0KPiA+DQo+ID4gSW4gdGhlIHBhdGNoIFN1YmplY3QsIGF2b2lkIHRoZSAi
Zmx1c2ggcHJlZGljYXRlIiB0ZXJtaW5vbG9neSAoc2VlIG15DQo+ID4gY29tbWVudCBvbiBQYXRj
aCA0KS4NCj4gDQo+IEFja2VkLiBJIGNhbiB1c2UgdGhpczoNCj4gW1BBVENIIHYzIDIvNV0geDg2
L3RsYjogTWFrZSBzaG91bGRfZmx1c2hfdGxiKCkgYXZhaWxhYmxlIHRvIEh5cGVyLVYNCj4gDQo+
ID4NCj4gPj4gTWFrZSBzaG91bGRfZmx1c2hfdGxiKCkgYXZhaWxhYmxlIHRvIHRoZSBIeXBlci1W
IGJhY2tlbmQgYW5kIGdpdmUgaXQgYQ0KPiA+DQo+ID4gV2hhdCBpcyB0aGUgSHlwZXItViAiYmFj
a2VuZCI/ICBNYXliZSBtb3JlIHNwZWNpZmljIHdvdWxkIGJlDQo+ID4gIlBWIHRsYiBmbHVzaCBm
dW5jdGlvbnMiPw0KPiANCj4geWVzLCBJIHNob3VsZCBjaGFuZ2UgaXQgdG8gIkh5cGVyLVYgUFYg
VExCIGZsdXNoIGZ1bmN0aW9ucyIuDQo+IA0KPiA+DQo+ID4+IGNvbnN0IHN0cnVjdCBmbHVzaF90
bGJfaW5mbyBwb2ludGVyIGluc3RlYWQgb2Ygdm9pZCAqLiBLZWVwIGENCj4gPj4gc2hvdWxkX2Zs
dXNoX3RsYl93cmFwcGVyKCkgYWRhcHRlciBmb3IgdGhlIFNNUCBjYWxsYmFjayBpbnRlcmZhY2Uu
DQo+ID4NCj4gPiBJcyB0aGVyZSBhbnkgcGFydGljdWxhciByZWFzb24gZm9yIG5lZWRpbmcgYSBz
cGVjaWZpYyB0eXBlIGluc3RlYWQNCj4gPiBvZiBrZWVwaW5nIHRoZSB2b2lkICo/IEknbSBqdXN0
IHdvbmRlcmluZyB3aGF0IHZhbHVlIHRoYXQgY2hhbmdlDQo+ID4gYWRkcyBvdGhlciB0aGFuIHRo
ZSBjb21waWxlciBiZWluZyBhYmxlIHRvIHR5cGVjaGVjayB0aGUgY2FsbA0KPiA+IGFzIG1hZGUg
ZnJvbSB0aGUgSHlwZXItViBjb2RlLg0KPiA+DQo+ID4gTWljaGFlbA0KPiANCj4gTm8gZnVuY3Rp
b25hbCByZWFzb24uIEkgY2hhbmdlZCB0aGUgdHlwZSBiZWNhdXNlIHRoZSBIeXBlci1WIGNhbGxl
cg0KPiBwYXNzZXMgYSAiY29uc3QgZmx1c2hfdGxiX2luZm8gKiIgd2hpbGUgc2hvdWxkX2ZsdXNo
X3RsYigpIGV4cGVjdHMNCj4gInZvaWQgKiIuIFRoZSBvcmlnaW5hbCBmdW5jdGlvbiBkb2VzIG5v
dCBtb2RpZnkgdGhlIHJlcXVlc3QsIGFsdGhvdWdoDQo+IGl0cyBsb2NhbCBwb2ludGVyIGlzIG5v
dCBkZWNsYXJlZCBjb25zdC4NCj4gDQo+IEtlZXBpbmcgdGhlIHZvaWQgKiBzaWduYXR1cmUgd291
bGQgYWxzbyB3b3JrLCB3aXRoIGFuIGV4cGxpY2l0IGNhc3QNCj4gYXQgdGhlIEh5cGVyLVYgY2Fs
bCBzaXRlLiBJIGNhbiBrZWVwIHRoZSBleGlzdGluZyBzaWduYXR1cmUgaWYgeW91DQo+IHByZWZl
ciBhIHNtYWxsZXIgY2hhbmdlLg0KDQpJIHdhcyBvcmlnaW5hbGx5IHRoaW5raW5nIHRoYXQgZXZl
biBhIGNhc3QgaXNuJ3QgbmVjZXNzYXJ5IGJlY2F1c2UNCmFueSBwb2ludGVyIHR5cGUgaXMgYWNj
ZXB0YWJsZSBmb3IgYSB2b2lkICogcGFyYW1ldGVyLiAgQnV0IHRoZSAiY29uc3QiDQpvbiBmbHVz
aF90bGJfaW5mbyBtYWtlcyB0aGF0IG5vdCB3b3JrLCBhbmQgdGhlIGNhc3QgdG8gdm9pZCAqDQpp
cyBuZWVkZWQuICBDYXN0aW5nIGEgY29uc3QgcG9pbnRlciBhcyB2b2lkICogdG8gZGlzY2FyZCB0
aGUNCmNvbnN0IGlzIGEgYml0IGR1YmlvdXMsIHRob3VnaCBuYXRpdmVfZmx1c2hfdGxiX211bHRp
KCkgaXMgZG9pbmcNCml0LiBZb3VyIG5ldyB3cmFwcGVyIGZ1bmN0aW9uIGdvZXMgdGhlIG90aGVy
IHdheSAtLSBwYXNzaW5nIGENCnZvaWQgKiB2YWx1ZSBhcyBhIGNvbnN0IHBvaW50ZXIgcGFyYW1l
dGVyLCB3aGljaCBpcyBPSy4NCg0KSXQncyBqdWRnbWVudCBjYWxsLiBJIHRoaW5rIEkgcHJlZmVy
IHNraXBwaW5nIHRoZSB3cmFwcGVyIGp1c3QNCnRvIGhhdmUgbGVzcyBtYWNoaW5lcnksIGJ1dCB5
b3Ugb3Igb3RoZXJzIG1heSBwcmVmZXIgYWRkaW5nDQp0aGUgd3JhcHBlciwgYW5kIEknbSBPSyB3
aXRoIHRoYXQgdG9vLg0KDQpNaWNoYWVsDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE5hbWFuDQo+IA0K
PiA+DQo+ID4+DQo+ID4+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gPj4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+PiAt
LS0NCj4gPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90bGJmbHVzaC5oIHwgIDEgKw0KPiA+PiAg
IGFyY2gveDg2L21tL3RsYi5jICAgICAgICAgICAgICAgfCAxOCArKysrKysrKysrKysrKy0tLS0N
Cj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90bGJmbHVzaC5o
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiZmx1c2guaA0KPiA+PiBpbmRleCA3MDA5OGQ0NDhl
OTk5Li4xZDE4NTJlY2FmMDg0IDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS90bGJmbHVzaC5oDQo+ID4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgN
Cj4gPj4gQEAgLTI2Myw2ICsyNjMsNyBAQCB2b2lkIGZsdXNoX3RsYl9vbmVfdXNlcih1bnNpZ25l
ZCBsb25nIGFkZHIpOw0KPiA+PiAgIHZvaWQgZmx1c2hfdGxiX29uZV9rZXJuZWwodW5zaWduZWQg
bG9uZyBhZGRyKTsNCj4gPj4gICB2b2lkIGZsdXNoX3RsYl9tdWx0aShjb25zdCBzdHJ1Y3QgY3B1
bWFzayAqY3B1bWFzaywNCj4gPj4gICAJCSAgICAgIGNvbnN0IHN0cnVjdCBmbHVzaF90bGJfaW5m
byAqaW5mbyk7DQo+ID4+ICtib29sIHNob3VsZF9mbHVzaF90bGIoaW50IGNwdSwgY29uc3Qgc3Ry
dWN0IGZsdXNoX3RsYl9pbmZvICppbmZvKTsNCj4gPj4NCj4gPj4gICBzdGF0aWMgaW5saW5lIGJv
b2wgaXNfZHluX2FzaWQodTE2IGFzaWQpDQo+ID4+ICAgew0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvbW0vdGxiLmMgYi9hcmNoL3g4Ni9tbS90bGIuYw0KPiA+PiBpbmRleCA1M2RjYWIzOTU2
NmYyLi45YjFhZWEyYjNhMWQ1IDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3g4Ni9tbS90bGIuYw0K
PiA+PiArKysgYi9hcmNoL3g4Ni9tbS90bGIuYw0KPiA+PiBAQCAtMTI3OSwxMCArMTI3OSwxNCBA
QCBzdGF0aWMgdm9pZCBmbHVzaF90bGJfZnVuYyh2b2lkICppbmZvKQ0KPiA+PiAgIAkJCW5yX2lu
dmFsaWRhdGUpOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gLXN0YXRpYyBib29sIHNob3VsZF9mbHVz
aF90bGIoaW50IGNwdSwgdm9pZCAqZGF0YSkNCj4gPj4gKy8qDQo+ID4+ICsgKiBTZWxlY3Qgb3Jk
aW5hcnkgZmx1c2ggdGFyZ2V0cyB1c2luZyBzdGF0ZSBvcmRlcmVkIGFnYWluc3QgY29udGV4dCBz
d2l0Y2hlcy4NCj4gPj4gKyAqIENhbGxlcnMgbXVzdCBieXBhc3MgdGhpcyBmaWx0ZXJpbmcgZm9y
IHBhZ2UtdGFibGUgZnJlZWluZyBhbmQgZ2xvYmFsIEFTSUQNCj4gPj4gKyAqIHRyYW5zaXRpb25z
LCBhcyBuYXRpdmVfZmx1c2hfdGxiX211bHRpKCkgZG9lcy4NCj4gPj4gKyAqLw0KPiA+PiArYm9v
bCBzaG91bGRfZmx1c2hfdGxiKGludCBjcHUsIGNvbnN0IHN0cnVjdCBmbHVzaF90bGJfaW5mbyAq
aW5mbykNCj4gPj4gICB7DQo+ID4+ICAgCXN0cnVjdCBtbV9zdHJ1Y3QgKmxvYWRlZF9tbSA9IHBl
cl9jcHUoY3B1X3RsYnN0YXRlLmxvYWRlZF9tbSwgY3B1KTsNCj4gPj4gLQlzdHJ1Y3QgZmx1c2hf
dGxiX2luZm8gKmluZm8gPSBkYXRhOw0KPiA+Pg0KPiA+PiAgIAkvKg0KPiA+PiAgIAkgKiBPcmRl
ciB0aGUgJ2xvYWRlZF9tbScgYW5kICdpc19sYXp5JyBhZ2FpbnN0IHRoZWlyDQo+ID4+IEBAIC0x
MzE3LDYgKzEzMjEsMTIgQEAgc3RhdGljIGJvb2wgc2hvdWxkX2ZsdXNoX3RsYihpbnQgY3B1LCB2
b2lkICpkYXRhKQ0KPiA+PiAgIAlyZXR1cm4gZmFsc2U7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiAr
LyogQWRhcHQgdGhlIHR5cGVkIHByZWRpY2F0ZSB0byB0aGUgU01QIGNvbmRpdGlvbmFsLWNhbGwg
aW50ZXJmYWNlLiAqLw0KPiA+PiArc3RhdGljIGJvb2wgc2hvdWxkX2ZsdXNoX3RsYl93cmFwcGVy
KGludCBjcHUsIHZvaWQgKmRhdGEpDQo+ID4+ICt7DQo+ID4+ICsJcmV0dXJuIHNob3VsZF9mbHVz
aF90bGIoY3B1LCBkYXRhKTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAgIHN0YXRpYyBib29sIHNo
b3VsZF90cmltX2NwdW1hc2soc3RydWN0IG1tX3N0cnVjdCAqbW0pDQo+ID4+ICAgew0KPiA+PiAg
IAlpZiAodGltZV9hZnRlcihqaWZmaWVzLCBSRUFEX09OQ0UobW0tPmNvbnRleHQubmV4dF90cmlt
X2NwdW1hc2spKSkgew0KPiA+PiBAQCAtMTM1Nyw4ICsxMzY3LDggQEAgU1RBVElDX05PUFYgdm9p
ZCBuYXRpdmVfZmx1c2hfdGxiX211bHRpKGNvbnN0IHN0cnVjdCBjcHVtYXNrICpjcHVtYXNrLA0K
PiA+PiAgIAlpZiAoaW5mby0+ZnJlZWRfdGFibGVzIHx8IG1tX2luX2FzaWRfdHJhbnNpdGlvbihp
bmZvLT5tbSkpDQo+ID4+ICAgCQlvbl9lYWNoX2NwdV9tYXNrKGNwdW1hc2ssIGZsdXNoX3RsYl9m
dW5jLCAodm9pZCAqKWluZm8sIHRydWUpOw0KPiA+PiAgIAllbHNlDQo+ID4+IC0JCW9uX2VhY2hf
Y3B1X2NvbmRfbWFzayhzaG91bGRfZmx1c2hfdGxiLCBmbHVzaF90bGJfZnVuYywNCj4gPj4gLQkJ
CQkodm9pZCAqKWluZm8sIDEsIGNwdW1hc2spOw0KPiA+PiArCQlvbl9lYWNoX2NwdV9jb25kX21h
c2soc2hvdWxkX2ZsdXNoX3RsYl93cmFwcGVyLCBmbHVzaF90bGJfZnVuYywNCj4gPj4gKwkJCQkg
ICAgICAodm9pZCAqKWluZm8sIDEsIGNwdW1hc2spOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICB2
b2lkIGZsdXNoX3RsYl9tdWx0aShjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1bWFzaywNCj4gPj4g
LS0NCj4gPj4gMi40My4wDQo+ID4+DQo+IA0KDQo=
