Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795551761;
	b=eMB2ETkEkMJL4Q1zgkAxnLrocthLTSry/cBFKsGl9lt1gYT/epmcWba7y08wsBK2H14O
	 G1pdZHVuFadDzG2Q5M/nLHa+0fOfWmVdkBheDrUyunA9u8VtrjoY/G3+mHTgEUeBCsNon
	 iRbNmOf3t0JmXxtIFrlGpUdUYrTNgLyGrdgtUTzmpWk77Nt9+mufLu2f5V1ktxFSM8cEO
	 oavVwnq/VMKp/XC3Ak5WP3i1Ic1cIktSQIti+rbWvufXHsgiMGc6w11DMe/N9VO4NOoCd
	 jCzcbx7RBAJ+y72vYn1MmKBRy1GcXUMFQ1iH72P9qYXZVpPpRRyhKYxZglpIvoUsHdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551761;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
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
	bh=zWLTs8SX4do8/5HvJFg4jqa5GXjFIeHauWRhH96GVAQ=;
	b=HbXVbFw2gISVSWNhBQUe7/px+liqImG6pwFJCc37DjiRtTcyt968odOJ1PvQHyR/bNo4
	 zPsOmDmLVWVmJUYqplCdLxtvDQ8pxE2jt2EBl7Q/vIeFCRafkp3MP72YWB6kMoDaTUViE
	 YPcair3ywJK6SV1lwxB7XeUqj8pboe57a0lCVHNTqsrHqSm+qip+L8Bj7kHLxWtnh9BNC
	 XrGYB8P5mh2+IdLGbzA11PyR6EE1kjFs0dm1kO7q9dRg1jmOykwwYzD/jIyyyT25DCQmS
	 +3Mz6NlQ+7ziN3Jc2Y7jlh7AdvI8P6281hu4RU9GjQ5WGZypmk0TN8B+fyUCgijKntA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ac39C7C2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.75
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012075.outbound.protection.outlook.com [52.103.11.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7576606A31E;
	Tue, 24 Nov 2026 20:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7576606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ac39C7C2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kzlaf7OhaxP4TsqfHdMqo0+zC8joh+NP0ftw+T3hP5b6vzpdAz699p48xJ+R+SPEEvLc8eEatLxtTjrEu5ABY4NeeSNT3Z6c7kn6nAzCr84u/l0kVEOo7rFvfV/t1eb1ExupRVJgP0Q4wq9MwW1LMBzGCXQGupmsRYWkAeev1cWQUf21odi8H5BYRUv2xxh2uCfC4OxhpbJm/9lSud3v3wb/w5fD8d3fIbflDyzC6/+2MPVS45PZ5y920/ppWjs94DlwQ5V5tK5ayCkH2nnvEP5WGepjaMSuMYjmapl5XWmIXZf7gulW8UbvENzwA9hEZ4grKq2u5OS2oTfeXdnqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWLTs8SX4do8/5HvJFg4jqa5GXjFIeHauWRhH96GVAQ=;
 b=BpkUeKl+WyfVLl6nL0UNRtdQIZl17UfhMhCsv3zNbNdXBP0I/hvMD664pRcFWRvsNnTjH8gN2OznNsaLD4Og3tPB+W2BEXL1zGaG0YAttl0F4uDMwiwq3aN2/Q68NsE9Z2Y8O1oSVabRJXE3k9gqBoSgy1opr3Z7rOxgdTW2Hw1EXKHZz65EhJdi+bQBPOS+UkD1J4jx73IM5PB7SWOnj80nDeO+VRYFjd75PgJXHawsRJVlnQLliwSM/rHTvV55HOHeknSykdqh2GtVKqHVbEUKx/OLT4ujySnskCu3DN+dEiBxHAwcLMfR3M6A1wmP/8iko9NdJ3OI6/ko7+U4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWLTs8SX4do8/5HvJFg4jqa5GXjFIeHauWRhH96GVAQ=;
 b=ac39C7C2P0XC7iJooM+H470ijwHEOwXkNBV+jchBw0yH0xM3iXpr7hAyUPxrORJG0lrpQ8TKqr3EY45uj9FwHOozXKXP/fkSXdzVOaZ6hDa8PicH4/AYNVvyei7CCV+GyMUgbrhusq0WmW1khVHcC9Tuco7uuJFfvJNmTmS15Dw4Xb2RGXDSo6FLx95a4+DvzWdV2iRDiEnUvF6VkHSUvwFo1VPIfZUoLOSmon31iU6PCT4VWU5svhBtv0/hz74Gzqc3xOgymw34tXhg6BoUcKR9RGQQdLS4OI5g05IiNxcXwryOQ2Wi2IhbV/AU34jx6BKPPNy1R7QNDeDIZDo9ng==
Received: from DM6PR02MB6860.namprd02.prod.outlook.com (2603:10b6:5:21a::13)
 by SJ0PR02MB8862.namprd02.prod.outlook.com (2603:10b6:a03:3fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 20:20:36 +0000
Received: from DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0]) by DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:20:35 +0000
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
Thread-Index: AQHddnQ64Ec83cbOYEiSIeP+LAxtyrc8ZU7QgABsZACAAOPqwA==
Date: Tue, 24 Nov 2026 20:20:35 +0000
Message-ID:
 <DM6PR02MB686096C4BD67938C356B7EE6D4442@DM6PR02MB6860.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-5-namjain@linux.microsoft.com>
 <MN2PR02MB6863EA8EE36408EA031F1CEDD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
 <d7c486ff-dbd6-4ec0-ad3e-673976b811e6@linux.microsoft.com>
In-Reply-To: <d7c486ff-dbd6-4ec0-ad3e-673976b811e6@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6860:EE_|SJ0PR02MB8862:EE_
x-ms-office365-filtering-correlation-id: 7b9654ca-74ef-4369-c0bc-08df4a686607
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|13091999003|15080799012|51005399006|24021099003|55001999006|12121999013|19110799012|31061999003|8060799015|8062599012|25010399006|2604032031799003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWRyTm5SekVCRVVuVTd5YnQ0Ty85cFpNN0ppaDQ1dEwwVE4xY3dUMzRqUzZD?=
 =?utf-8?B?cG5UYmZjRkdGQ3E5clc0a0hvSHVTYmtkN0lvTS9ITjB1TlRSNXJwWnNLdHQz?=
 =?utf-8?B?MnFXckVPT1lqOXlyZW5pRmw0T1ppRVJsOTU3T3FOSFRnUUIrcTUvclBjMXAx?=
 =?utf-8?B?YThvKzZHWnRaY1JyRzUvNGRXdVYxcEIrNW1QTExOZXJZc04xclA0Y1NtSnVl?=
 =?utf-8?B?enM0cFMvYTFoOWIvdXBGaTNtZ2hFOUlqKzhVQWFocW1IaWQ5WVBJZys5R0dG?=
 =?utf-8?B?NHNmUnVjaUJyNzlDNFVCQTNsTVR2WDZSMmxONWVEWFhVNGtsLzBjRVk4YktC?=
 =?utf-8?B?VFVWbG1QdmQ5TDNTazRtb213c25IL1hoWk05c3VENWxtV3R1dDF3YTlaNlJK?=
 =?utf-8?B?OGhiMUIrV2Z5SzRNTDhySUxTVEcrcEM4R2xRNFYwVmNGd0RUbXhyMHE5OWFv?=
 =?utf-8?B?L0U1QWhraWJnQ1k5d1EwL2R6TkxsZEZodmxXK0RPWmNYNXJnaEdrUW1Gbysx?=
 =?utf-8?B?WFR2d3NYejE3SW9CV0pMM1dQSituUEZQRkw5QUxub1NsNTQrU3BKUG5lZkJ0?=
 =?utf-8?B?bnkrRlNqdmdnVHlXczBCbDZzd0ttS3BrT0dwUytYRzdrMGtTME9jVGlHR2My?=
 =?utf-8?B?K3FpOTNhNlZWWjgweDYreUZtZVJDNFdhdUVwcXBMVVhRd1RyRnlUSUtzU0pN?=
 =?utf-8?B?QzhBTWo1dEVybDkrRWUvMVg0dmRPdWIrNTNYcnVJSWgrWWFxUzhTMEJFOVpS?=
 =?utf-8?B?V2hDODRydlpoZGFSMXFidFdoV05Kc2I1ZTZzUzFMYndrMXhqNGdLUnY0SlJ3?=
 =?utf-8?B?L052RzNSZTEzUm1DYkJYbXE5bWVFaU1ZbUQyVm9tRDZlU2hlQ1VjMTE0cFp6?=
 =?utf-8?B?ZjhuRGhvK3o1MnphT21LdzNEWURadStSbS9lOVRpQ2lzQUpVd1daUHBKVzIx?=
 =?utf-8?B?V29LV29XY2ZjbkZFam9CTzQyMTl0TGJ2ckMxY1MzcWYxL01tdXhtdnNYM1NN?=
 =?utf-8?B?NzV2REhrcmZDVm9Yd0I3RFQ3emJhS1FEMDQrdjdQeENaVlNOWHNyVG1WeEV3?=
 =?utf-8?B?MkhZVDdkcCsvUUcxeE1nS01SYU9rMVdWNEVwaU1Fd0NPN1lmem53MHdUZjd0?=
 =?utf-8?B?VXVVeTk1UjNKWk9ybytWSEhHT3NyRVdLOUxwaVpHQUVMVWY4eTJxWmNVWWd3?=
 =?utf-8?B?Zm5aZ2tnKytwWUtvUHVWLzc5WWs4cWMreFg3QmpkaytwVWM4MGlURWdQQTVv?=
 =?utf-8?B?eVB2NXFXRUsycGorQVJ2Uk5paHh1WTlPZ2U0OUZtRGxJMkhLVHUxNFZ4Vysw?=
 =?utf-8?B?ak8xd3BjREx5SytlSHljMENlVDBLeUZiRThRS0VuRUlPcDluYW9sK2NCNGxy?=
 =?utf-8?B?MUZwSGc2dWI3aksyaFZqOFE2aWFrUzNZNFRvdlJxcDdldUZid3lJd3cvQklJ?=
 =?utf-8?B?dmc4YzRhRUtXZmRLVStLR1dBdm1pWTk2NGJ2OGNtL2FVK1dqbWhpSHBRdWtq?=
 =?utf-8?Q?OH9+tA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3RESCtYdmRzNVF3cVVQbVl3a0JEbG1obEdIeml3Q2hhb1NjZ1YwOVBjaHBR?=
 =?utf-8?B?MVZRVEZMcjBJT05EbTNLeFVGVi9EeVRTL2NxNnVkalAzdGcydGJ6V2QxTnVo?=
 =?utf-8?B?M1UrUmpaNDRwR2RtRHJ6akZkeFJVYXFWejNIeG4waElGK0ZXV1ViOEp0NXd5?=
 =?utf-8?B?TXpqcXRvTXhOaEIzZTdZMzR4NDEzbjdWUFo3ZGZOWVg3SDUvRjdMUFRTamhB?=
 =?utf-8?B?RGdCM1ZSSG1XaDdjc1ZKZ1dzMldEdHJNd2RXUjhHbUg0WlpOSklDUUxkQmFJ?=
 =?utf-8?B?bWM4RUF4S3FUejc2M1FiTGdCdC9STUQ3R3hCMHI1UTNLZ3lkYnJ6OFNHVEtY?=
 =?utf-8?B?MlRXaXVHWXEwdW9OcElqM3lYbG9oQVlLTmcxQjRYeFNQQ3pFdnY4L3hnQnBu?=
 =?utf-8?B?TXRUWDVZVmdPMUF6SFB0SjV1cklzeXZQL3pEcHo2YTE4MHBzaXAzang0dmk5?=
 =?utf-8?B?UkUzdENQdVBuWUxaVHlnTGNOMmlRUzYxK3NEeEtqc20ycGJkTmhUUktZY0Nu?=
 =?utf-8?B?OUc0aUFvc3p3SWtNUktKeXRyc08vOURMR3JnZ1k5SjBRcFFPVjhodzRqWmU5?=
 =?utf-8?B?c3U4a3dxaC8yV3ZHaDFZakZXdXdoY2xOaHRaQlZKNTlYRUhHZklBUFlvN3Uv?=
 =?utf-8?B?UG9ZdWRxK1VVQ2t2ZENtUklaOHcwR1J6QTliOUpiOXNGTDcwT2lRdnhFRUlw?=
 =?utf-8?B?RnJEWThpQ1JTZ2NaelNZa2dRMjRJN1N4SWpxL3V5WVNycy9iMFI2Sm8rUGNC?=
 =?utf-8?B?V21OZDR3ckMrTGxpbkdNOG9LblFwUCtsWmw5emptcVp6T3o5SmJFTTNBbjhk?=
 =?utf-8?B?ZmZ6cHhHemFEZ05QOU96cm95Z2o4bktkOGtuc3VRa3lCcTBkNDhsZVRPZUJr?=
 =?utf-8?B?czBLR1FhN1NBUFRBTm9INDNSQ3VNc1VpdEZIeGxPcE05RGRVdXl0NFpia3pi?=
 =?utf-8?B?OThZdFcxa2NqdG81M3RyU25NdWt2eEJkMFNzNkhTbDZsSk9uOFJ0NkFIQzVm?=
 =?utf-8?B?QTQvQ0lKcWxvUHptQ3Avdi9KSFlnUlRBcEV2YUdreXRzbEE0dmZzZ0JIeldu?=
 =?utf-8?B?ZXNXVGNpamF4d1dkRGJ2NFlLOHoxNHkyMkFpeVFkWjNnMExJdWFwYlMrZnpn?=
 =?utf-8?B?bTd6NmFBOXZwS055K05YSzNMT0FWaHdQVkZtbEoxUG96ckwvZElXMk1odGxT?=
 =?utf-8?B?ZWhkWENFSFcrU2FVaEFWc1lWQXZiSDRiRTFmY0dqUC8rZlJQQWk5TXBwZ0NM?=
 =?utf-8?B?MG9pMTNNRUdwc1dSQ0hObmNmNlJ3eWxUUHJaclFnNG9aTDVsZjhqRHNiSDhG?=
 =?utf-8?B?anRGRlhldi9ueUVkVWFqUE9aYmZVcHZyU1gxZ3dsZnZ5MitBRk9QeEthYWNL?=
 =?utf-8?B?VmtrT21mRVEwTjNLbGNta3RrU0dpK01wUEZrWWhPRVFLd3pMeUNGNlNiOVpq?=
 =?utf-8?B?K0xGcWVFYjgyb3FobDkvSWw0NVQ5NXloT1FNKzlVbGthOERBQys3dlU3czlX?=
 =?utf-8?B?eHcrQ003dHNtZUJqSGhxUlA5WktVdFcwbnNwTG1HTjNTeXpnanRxd2VkK0hl?=
 =?utf-8?B?NkU2d0QvbVlOUkYyd1huNjhSZGxhYS9JdkN3ZHR6MXk1c3dCcDU3MG1UcGRF?=
 =?utf-8?B?bXA1VlBpNXI3TXlkVnY1dkZ2WVhlTGdPM2orelM3UlExU2pNNzJtZjU4UjZ5?=
 =?utf-8?B?dkxiK0NISDBrdzJjZ0RyblhxVEw1QXo2b3d3ZWZsYXdpeDlVNDZwcExkWkxF?=
 =?utf-8?B?VzVHRUNEYkVJbXFFQWd1N2UzQnMvRTVyU2EyelBTRjRoZHFWQmUvbVdJTkFS?=
 =?utf-8?Q?o2AR0ELSSK/6WOu8Ry1KBERuEWo7SDESy7yaA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9654ca-74ef-4369-c0bc-08df4a686607
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 20:20:35.8376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8862

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDIzLCAyMDI2IDEwOjQ1IFBNDQo+IA0KPiBPbiAxMS8yNC8yMDI2IDU6NDYg
QU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE5hbWFuIEphaW4gPG5hbWphaW5A
bGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTcsDQo+IDIwMjYg
MToxNSBBTQ0KPiA+Pg0KPiA+PiBTdXBlckJlbmNoJ3MgZWlnaHQtR1BVIFB5VG9yY2ggTFNUTSB0
cmFpbmluZyBvbiBBenVyZSBNSTMwMFggVk1zIHJlZ3Jlc3NlZA0KPiA+PiBiZXR3ZWVuIExpbnV4
IDYuOCBhbmQgNy4wLiBSZWNyZWF0aW5nIERhdGFMb2FkZXIgd29ya2VycyBlYWNoIGVwb2NoIGNh
dXNlZA0KPiA+PiBob3N0LXRvLUdQVSBjb3B5IHN0YWxscyBhbmQgdGltZW91dHMuIFRoZSByZXBv
cnRlZCBiaXNlY3Rpb24gaWRlbnRpZmllZA0KPiA+PiBjb21taXQgMjA5OTU0Y2JjN2QwICgieDg2
L21tL3RsYjogVXBkYXRlIG1tX2NwdW1hc2sgbGF6aWx5IikuDQo+ID4+DQo+ID4+IFRoYXQgY2hh
bmdlIGxlYXZlcyBhIENQVSdzIGJpdCBzZXQgYWZ0ZXIgaXQgc3dpdGNoZXMgdG8gYW5vdGhlciBt
bS4NCj4gPg0KPiA+IFRvIGJlIG1vcmUgZXhwbGljaXQsDQo+ID4NCj4gPiAiLi4uIGxlYXZlcyBh
IENQVSdzIGJpdCBzZXQgaW4gdGhlIG1tX2NwdW1hc2sgZXZlbiBhZnRlciB0aGUgQ1BVIHN3aXRj
aGVzDQo+ID4gdG8gYW5vdGhlciBtbSIuDQo+ID4NCj4gDQo+IEFja2VkLg0KPiANCj4gPj4gTmF0
aXZlIGZsdXNoIGNhbGxiYWNrcyByZW1vdmUgdGhlc2Ugc3RhbGUgYml0cywgYnV0IHN1Y2Nlc3Nm
dWwgSHlwZXItVg0KPiA+DQo+ID4gQWdhaW4sIEknbSB3b25kZXJpbmcgYWJvdXQgdGhlICJzdWNj
ZXNzZnVsIiBxdWFsaWZpZXIuDQo+ID4NCj4gDQo+IERpc2N1c3NlZCBpbiBwYXRjaCAzIGNvbW1l
bnRzLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBjYW4gcmV0YWluIHRoaXMuDQoNCkkga25vdyBJ
J20gYmVpbmcgYSBiaXQgcGVkYW50aWMsIGJ1dCBwZXJoYXBzIHRoaXMgdGV4dDoNCg0KLi4uIGJ1
dCBzdWNjZXNzZnVsbHkgdGFraW5nIHRoZSBIeXBlci1WIGh5cGVyY2FsbCBwYXRoIGRvZXMgbm90
IHJ1biB0aG9zZQ0KY2FsbGJhY2tzLg0KDQo+IA0KPiA+PiBoeXBlcmNhbGxzIGRvIG5vdCBydW4g
dGhvc2UgY2FsbGJhY2tzLiBBIENQVSBhY3RpdmVseSBydW5uaW5nIGFub3RoZXINCj4gPg0KPiA+
IFRoZSB3b3JkICJhY3RpdmVseSIgc2VlbXMgcmVkdW5kYW50L3N1cGVyZmx1b3VzIGhlcmUuDQo+
IA0KPiBBY2tlZC4gSSdsbCByZW1vdmUgaXQuDQo+IA0KPiA+DQo+ID4+IG1tIG5lZWQgbm90IGJl
IGluIGxhenkgVExCIG1vZGUsIHNvIHRoZSBleGlzdGluZyBsYXp5LVRMQiBjaGVjayBkb2VzIG5v
dA0KPiA+PiBleGNsdWRlIGl0LiBJZiB0aGUgbWFzayBpbmNsdWRlcyBhbGwgcHJlc2VudCBDUFVz
LCB0aGUgYmFja2VuZCBzZWxlY3RzDQo+ID4NCj4gPiBCZSBtb3JlIGV4cGxpY2l0IHRoYW4ganVz
dCAiYmFja2VuZCIuDQo+IA0KPiBBY2tlZC4NCj4gDQo+ID4NCj4gPj4gdGhlIGFsbC1wcm9jZXNz
b3JzIHNob3J0Y3V0IGJlZm9yZSBjaGVja2luZyBpbmRpdmlkdWFsIENQVXMuDQo+ID4+DQo+ID4+
IFVzZSB0aGUgbmF0aXZlIHByZWRpY2F0ZSB0byBidWlsZCBhIHBlci1DUFUgdGFyZ2V0IG1hc2sg
YmVmb3JlIHNlbGVjdGluZw0KPiA+DQo+ID4gQmUgbW9yZSBleHBsaWNpdCB0aGFuICJuYXRpdmUg
cHJlZGljYXRlIiAod2hpY2ggc291bmRzIGxpa2UgQUktc3BlYWspLg0KPiA+IEp1c3Qgc2F5IHNo
b3VsZF9mbHVzaF90bGIoKS4NCj4gDQo+IEFja2VkLg0KPiANCj4gPg0KPiA+PiB0aGUgYWxsLXBy
b2Nlc3NvcnMgc2hvcnRjdXQgb3IgZWl0aGVyIGh5cGVyY2FsbCBmb3JtYXQuIEtlZXAgdGhlIGZ1
bGwNCj4gPj4gY2FuZGlkYXRlIG1hc2sgd2hlbiBmcmVlaW5nIHBhZ2UgdGFibGVzLiBSZXRhaW4g
dGhlIGVtcHR5IGJhc2ljLW1hc2sNCj4gPj4gY2hlY2sgYmVjYXVzZSBmaWx0ZXJpbmcgY2FuIGxl
YXZlIG5vIHRhcmdldHMuDQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2ggZG9lcyBub3QgY2hhbmdlIHdo
ZW4gdHJpbW1pbmcgaXMgcmVxdWVzdGVkLg0KPiA+DQo+ID4gSSBoYWQgYSBsaXR0bGUgdHJvdWJs
ZSBwYXJzaW5nIHRoaXMgc2VudGVuY2UuIEkgZmlyc3QgcmVhZCBpdCBhcw0KPiA+ICJXaGVuIHRy
aW1taW5nIGlzIHJlcXVlc3RlZCwgdGhpcyBwYXRjaCBkb2VzIG5vdCBjaGFuZ2UuIiwNCj4gPiB3
aGljaCBkaWRuJ3QgbWFrZSBhbnkgc2Vuc2UuICBNYXliZSByZXdvcmQgYXMgIlRoaXMgcGF0Y2gN
Cj4gPiBkb2VzIG5vdCBhZmZlY3Qgd2hlbiB0cmltbWluZyBpcyByZXF1ZXN0ZWQuIg0KPiANCj4g
QWdyZWVkLg0KPiANCj4gPg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBOYW1hbiBKYWluIDxu
YW1qYWluQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGFyY2gveDg2L2h5
cGVydi9tbXUuYyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0N
Cj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
DQo+ID4+DQo+IA0KPiANCj4gPHNuaXA+DQo+IA0KPiA+PiAtDQo+ID4+ICAgc3RhdGljIHZvaWQg
aHlwZXJ2X2ZsdXNoX3RsYl9tdWx0aShjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1cywNCj4gPj4g
ICAJCQkJICAgY29uc3Qgc3RydWN0IGZsdXNoX3RsYl9pbmZvICppbmZvKQ0KPiA+PiAgIHsNCj4g
Pj4gICAJaW50IGNwdSwgdmNwdSwgZ3ZhX24sIG1heF9ndmFzOw0KPiA+PiAgIAlzdHJ1Y3QgaHZf
dGxiX2ZsdXNoICpmbHVzaDsNCj4gPj4gKwlzdHJ1Y3QgY3B1bWFzayAqZmx1c2hfY3B1czsNCj4g
Pj4gICAJdTY0IHN0YXR1czsNCj4gPj4gICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4gLQli
b29sIGRvX2xhenkgPSAhaW5mby0+ZnJlZWRfdGFibGVzOw0KPiA+Pg0KPiA+PiAgIAl0cmFjZV9o
eXBlcnZfbW11X2ZsdXNoX3RsYl9tdWx0aShjcHVzLCBpbmZvKTsNCj4gPj4NCj4gPj4gQEAgLTg3
LDYgKzg1LDIzIEBAIHN0YXRpYyB2b2lkIGh5cGVydl9mbHVzaF90bGJfbXVsdGkoY29uc3Qgc3Ry
dWN0IGNwdW1hc2sNCj4gKmNwdXMsDQo+ID4+ICAgCQlnb3RvIGRvX25hdGl2ZTsNCj4gPj4gICAJ
fQ0KPiA+Pg0KPiA+PiArCWZsdXNoX2NwdXMgPSB0aGlzX2NwdV9wdHIoJmh5cGVydl90bGJfZmx1
c2hfbWFzayk7DQo+ID4+ICsJLyoNCj4gPj4gKwkgKiBtbV9jcHVtYXNrKCkgbWF5IHJldGFpbiBD
UFVzIHRoYXQgaGF2ZSBzd2l0Y2hlZCB0byBhbm90aGVyIG1tLg0KPiA+PiArCSAqIFVzZSB0aGUg
bmF0aXZlIHByZWRpY2F0ZSBmb3IgaXRzIGNvbnRleHQtc3dpdGNoIG9yZGVyaW5nIGFuZCBsYXp5
DQo+ID4NCj4gPiBBZ2Fpbiwgc2F5IHNob3VsZF9mbHVzaF90bGIoKSBpbnN0ZWFkIG9mICJuYXRp
dmUgcHJlZGljYXRlIi4gQW5kIEkgZG9uJ3QNCj4gPiByZWFsbHkga25vdyB3aGF0ICJjb250ZXh0
LXN3aXRjaCBvcmRlcmluZyIgaXMgdHJ5aW5nIHRvIGdldCBhdC4NCj4gDQo+IFBsZWFzZSBhbGxv
dyBtZSB0byByZXdyaXRlIHRoaXMgd2hvbGUgY29tbWVudCBhcyBmb2xsb3dzOg0KPiANCj4gbW1f
Y3B1bWFzaygpIG1heSBpbmNsdWRlIENQVXMgdGhhdCBoYXZlIHN3aXRjaGVkIHRvIGFub3RoZXIg
bW0uDQo+IFVzZSBzaG91bGRfZmx1c2hfdGxiKCkgdG8gY2hlY2sgd2hpY2ggQ1BVcyBuZWVkIHRo
aXMgZmx1c2guDQo+IFdoZW4gZnJlZWluZyBwYWdlIHRhYmxlcywga2VlcCB0aGUgZnVsbCBtYXNr
IGJlY2F1c2UgQ1BVcyBpbg0KPiBsYXp5IFRMQiBtb2RlIG11c3QgYWxzbyBiZSBmbHVzaGVkLg0K
DQpMb29rcyBnb29kIHRvIG1lLg0KDQpNaWNoYWVsDQoNCj4gDQo+IA0KPiA+DQo+ID4+ICsJICog
VExCIGV4Y2x1c2lvbi4gUGFnZS10YWJsZSBmcmVlaW5nIG11c3QgaW5jbHVkZSBsYXp5IENQVXMs
IHNvIGtlZXANCj4gPj4gKwkgKiB0aGUgZnVsbCBjYW5kaWRhdGUgbWFzayBpbiB0aGF0IGNhc2Uu
DQo+ID4+ICsJICovDQo+ID4+ICsJaWYgKGluZm8tPmZyZWVkX3RhYmxlcykgew0KPiA+PiArCQlj
cHVtYXNrX2NvcHkoZmx1c2hfY3B1cywgY3B1cyk7DQo+ID4+ICsJfSBlbHNlIHsNCj4gPj4gKwkJ
Y3B1bWFza19jbGVhcihmbHVzaF9jcHVzKTsNCj4gPj4gKwkJZm9yX2VhY2hfY3B1KGNwdSwgY3B1
cykgew0KPiA+PiArCQkJaWYgKHNob3VsZF9mbHVzaF90bGIoY3B1LCBpbmZvKSkNCj4gPj4gKwkJ
CQlfX2NwdW1hc2tfc2V0X2NwdShjcHUsIGZsdXNoX2NwdXMpOw0KPiA+PiArCQl9DQo+ID4+ICsJ
fQ0KPiA+PiArDQo+IA0KPiBSZWdhcmRzLA0KPiBOYW1hbg0KPiANCg0K
