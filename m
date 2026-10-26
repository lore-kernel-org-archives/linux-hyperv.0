Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793030374;
	b=Oqs89hAyhda8ypqeq6tYz0S4ZJmYYS/bKQR0tMTSkpV3PXIf0IeAsZTgkB/goQCogohR
	 xbpndk/hm+LuAZjIKCYvri3QzJfw6BStxuVamLJiji6bQ2lPDcsb3K22xnga/L5MhWnnK
	 D1GdRh2rJXKlmetlcaAxJ3b/2u8vxceO1gU/q5mLVjXgVpraLNKe07px3/vvqvmj/BDUa
	 dJwQjosm3uLngptnrcZ9WDU4CsMPlrh5CjdGczx5kl5zQlF3WVHkfdTRsEFXFOiblpXag
	 AX3kt2KOZ560sdMei8tSXkDRLgOC6Wvo+nM4nOwMNGKjJEJDZXG6Mv+HcLZlmE9pEng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030374;
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
	bh=G/EHHSstRFnyDBbdeTHQV/e+a9jM+MsAFMLDSQfwuJw=;
	b=x3X4Bfa0xQOHWLdb3YjIpO6z2ZixQtkiwTpQX8T3Stw2mL997zQDNHSKjyrj5mdpdrpN
	 eCsxPCe1MdNCPjANzCTdlY6MPAaUacXC/Q/MFziejTstY8Oy0A4qJyy8Ica/XkdPX8pNT
	 paf0rMjWG7ifeOaObuj7K532Ft8bUNHNVbILxiO6WPKl9BeI938Jxv0R7LwoDSwMLvUns
	 s04suL+1/eOWqj1UpIIRuCT8IIlDhDmvNtQr1Ke3LY2jHHb4yBMPsAJOd8rprbcwTPV0z
	 RRMwrATVRxOBlzod2zCls44RoILH/QmOoZPQOSIO7QVOxdMDRV8LzpYetDK5xRnJl7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=qaqA+zoC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.21
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010021.outbound.protection.outlook.com [52.103.2.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE33606A331;
	Mon, 26 Oct 2026 15:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE33606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=qaqA+zoC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmUD50tzIbD5dfyxHxM43tWmsolYvQ6m9Jsmlj599U29aJZF4pAVlLKOUaX2CZ8GqsRabE1PAjhiR1Dvk8cUf4XgNQTJEfUGqHqX8EcTlsLtTgYdWO9RuhPu5cRZT7nSTPzND4g2XhlKsI8AtYV4qnDCzeqpYVA0beHlVCE/ayZui7Ebu/t86CWuLEQgFIkq15v0ZQMgcsvZRXtgJcj/ikHeIMs88P9AIJTs0+XVTC9Ekp8jMa1pu2hgcNttd9yqg0GrxBJ1VYA3H7ZYaOCaEMdyzLCPN1DkmAL8zKAmOcoX8+DClalIkRDe6qFBp76wk94cDUwiJoZtVo9KAjtgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/EHHSstRFnyDBbdeTHQV/e+a9jM+MsAFMLDSQfwuJw=;
 b=IBsJNoZSn0dqvtA2nDWrzVf4BEePHCU1rwU9okZlrXeeuodQ6kHZjqV5s3objPcWXFN9kwWm52Ur/u/t37LL3vNWU1DPlV+UFY57aaJWpyXTo4SH2UkdvCfu8AVZ+TaTUdV5f0Cl0CZrPl5SyVVSQrfEBKna9qVJ7wcyC6ZxI7Lfp3zwE3IL5TQkNMFk4Xgsds8ZliFHQr0wUs+KVhJw5ffT2zl3dSk1DsuYFlpXYtSR9t390g0aAZJuIF45hi6JWzLkoeFGF73P/TfIYUGopmCUFsdihLDtiqwVUdtIOIE/61JQ6OzgnltUPIeh8mpDUZtFoB97ffin6LgcOhYlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/EHHSstRFnyDBbdeTHQV/e+a9jM+MsAFMLDSQfwuJw=;
 b=qaqA+zoC77zrnKQdVIc1RiDjNKsGrecRMYQfRztNt4VidpTu9tx1stiZNMtbKZAg7e5K0Lek0e9RH3KmhVhgny2PUpUQ4f2OzT3Kzj2EqadRqZzjlJ2MNSFklZRqCZGsjVsgBm07dXxLvBWGLl9lbNnOPpq6IhSMUKRQ40Qi8HotLO2TAkC+MrymXLMi9r5g5kKuhqatnIkxHYy3Mn/8EdPrbxOqp4lKnO2FQjtACdIK1+PXa3lwYsJ6DUvs+hJixUirBTgYy6tFgn5XW1D+BNQmhbMJHgs9GWQQ70UcQgp1TlmpwlZiJG3M8K6GpYkBtOpLkwzmM2tB/mUyzm8+aw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by MN2PR02MB6989.namprd02.prod.outlook.com (2603:10b6:208:20f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Mon, 26 Oct
 2026 15:59:32 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:59:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Thread-Topic: [PATCH v2 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Thread-Index: AQHdRoSgfDLr0VgjEcqpOP6cAwhLsrcPwn2AgAB2caA=
Date: Mon, 26 Oct 2026 15:59:32 +0000
Message-ID:
 <MN2PR02MB6863DF1BDE302493DCF5D65BD4612@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261026045930.129874-1-mhklinux@outlook.com>
 <53f73450-7eaa-4f0c-90be-ffcfe1116e73@linux.microsoft.com>
In-Reply-To: <53f73450-7eaa-4f0c-90be-ffcfe1116e73@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|MN2PR02MB6989:EE_
x-ms-office365-filtering-correlation-id: 82a84ace-d8ff-45ea-c0d8-08df337a1fbf
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRA7LKchzwkq+WDdZuQWRD6TRGqehjb4HZMckyfc0jRX/5DzS4psEUo8bIGr123rF96vVNa8LIFgy1vKLXyXOkWDy21lgEYjc1iwIgqvlqqnYB519tgLRrTlWXRGnYJO4s58o8fKz4x69zK1hjPIGEwaOzH/1cLfKYJotFkh71NGLAlqTuUMQzBFJiWCjrb22h9EpAdyCoERO4HctI5el23qjKqcGctgn5gssXXxamBKx08vHDpQ2hIBI8efV24pAhxJKa1WJ/M6QBSKeUAWo3LMIsisZ38HxnoebcGgAbne69+Hj1PL6kAVnr49QQIwnWJgNpFr/f6rmqyybU2n9dp20O3bNyTw/P1znRhKODYKkEVpynyNBxx4G3j7pRHLLId3Y8Bt6003ztptj8huNs+nW64sm0d5FuA4opRhsfI8oHMGs++6VAl51Ez9UonnlsmZYZi4aK/qYcm/ToWm48iNajUhPi2nP34aeCkscD1S3rmP2B5Q6bYuZK+iFLo7YGl97bWG7mUQwOWHocgKzYzaQSoEv03GEDak/1FUQGPf/mTOdIssGFx7+hTVgbQrtDxqCYC9bTDT3CSUeErv43wLcTMO2VJyG02YghJsd7kMLLWfjXVpC6cbvEzqL8KnE4+Huztu9vj6cJWh/B4UfFBhzL1ry2/K87nvF4qXXBDo6oS5qiKCgVwiTP8uQzAn9ShIydwd4+jdKB7y+geINqnY5vGlxMeBj4efqgJmw82GY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|24021099003|8062599012|8060799015|41001999006|13091999003|31061999003|25010399006|19110799012|55001999006|37011999003|15080799012|51005399006|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGx2S00vRmNmMmgwUTZ4eUYxU1lXZjdKZDQ0Y3QyT3BDQUZwYzJ3dXFFbkRD?=
 =?utf-8?B?QUtqUG5KUUxXSXNSWnNCaHEzYVhqdS90TzVlbitBaGROdFh4bjhzZFkzeXEr?=
 =?utf-8?B?NTNMM0tkWmp6TklaNHVmY3J6SmNkT3AzRHJCM2VRdHZLQWE3NzBway9ha09Q?=
 =?utf-8?B?bE1xc0pBamc1cEVKRFB1MXp2bzJSQ3VtTWNSMkxRRHcxS3NIcEpJQ2hUakxE?=
 =?utf-8?B?MnJ1OGJ1VUVkZHB4ZlFKeGtEVUIyWnoyOTVwamJYTExNSUk3OXFFTG5Od0k1?=
 =?utf-8?B?cVprRjUxNExJL25YRm02TWJUQ213M1JHYVl4MTVIZm5kRzNyQSs4MXh2dVR2?=
 =?utf-8?B?TlpTSXpmVnB1azJjTGJJbzlyZjBNUisyb0JmcFFjS1Q0YzRkVUZrNFVWY1hL?=
 =?utf-8?B?eHM3YXdsTERFbFhoenhXdGRMR1k4QldwS0RaekxBQjVETGJnUjdnU0RNeXB4?=
 =?utf-8?B?cDBxbWs4dHlRYVlrTTdOUU9ManRtb3hzaDQrUktCSHNnWW5BdEp1QWY3S2tC?=
 =?utf-8?B?WXhGUXdnbS9sVHlMQllLN1hjKzNHK2dQNHR3MUNaM1hiOWh5MUFDNWdOR2Vw?=
 =?utf-8?B?THlMTmZYTG5LN0x2Z3ZidHRSUG42NVVaWE5ubUNLVzRETVFYR25qcXVoUUFW?=
 =?utf-8?B?dGZpQ0YycXBkUS9TVy9wMDAwWEprUUJncUFBZWZaSk1mbEJPTGZHOXZQTTNK?=
 =?utf-8?B?cElpcWRDVjY3RnZwc3VOa0VPRnI5cThDb3R4WUJrUVM2MUNnKzBDNlBPMmwz?=
 =?utf-8?B?NExpUUhIZUNMVCswRERoaUdiSEgyWTBja3hXbGIrM2ZldjFwOUdyc2g2Yitp?=
 =?utf-8?B?RUpPc0Vpdi82WnltcGs0RktLV2swQ3RPT0t6VzBsdEdZR0s4Vmp0Q21Qcm9J?=
 =?utf-8?B?czc5MjdRazlkYSs4amtoT3N2cU45eWdNVSt2S0xSbzVRQW1EV3BrZXFvOFNU?=
 =?utf-8?B?Wmo5MkpJS3F3ZEtTdzZOUEk0SjZtNGtFVGd6U2VvS0lvMTRTOVZHUm9SWlg0?=
 =?utf-8?B?dlBNZU04NWN0cDkrTStlRlAzZFg5TnhLTW9qZFN2RUxHTDNsZFdKampNWStJ?=
 =?utf-8?B?dVN0Ly8zdlI4K2NYTWdzRkJQUjd5ZHN2Qk9RYUVXdkdJOTNLZGlHTHYreVEx?=
 =?utf-8?B?ZlVxT0RuYUY1L1VKOG4rMGtMcEgyeEdMYVdGaTNVYTV0TnJFVjJVTThoNWxl?=
 =?utf-8?B?Qm1wcWFjZm5YaHNWWEw4QzE3WE8xVGVLOG9laHljL3o1cjhjVWFBNWFFM0ZN?=
 =?utf-8?B?aytrbUJUN0FtUTgya3AyMUYxcDltTFBJaVp0YVp1SmltZDhHbGRMR3lUTUNT?=
 =?utf-8?B?a2JOTEI2Wmh2RFMzWFdpVFh5bURLWGRZWSszcU0rVklicHk4SUNFbnJZdThU?=
 =?utf-8?B?RFpQeFBHL2Fid21EVEhpclVNV2pUdGRIaUx1ZlpvOXdBaHEvQXl6aGo5MTNw?=
 =?utf-8?B?VzJEYVJobHA0MnlZQ1NXZEdTeG9RTitkenYvUzl5c3BTTVFBWVltSjhDMHUr?=
 =?utf-8?Q?QYZSQg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEFMODY1M0ZWRUVTN2lwVEFLVjVDc2Z2UGxWYmREbmE2aW8yTzVtVzhOc0xM?=
 =?utf-8?B?ZTJ1TFRRMkFRRTA3cEgwcFVrN0djdW9iQVFTQ0V4THdkQlhRM0YrQW40MFpZ?=
 =?utf-8?B?Y0xLdDRzREZseS9VblhoZ096aGsyMTlwMFZwUXNsak5wcjR2aEcwaVhnb2JR?=
 =?utf-8?B?TnFyOUdjVnVneVlEcjNYUUJndDRsNWx4RGVYY2RPcWQyam5XZVhyWVlCeG9H?=
 =?utf-8?B?OCtaaUphYVRYZlJSRmxrTC84NkNEdEZvT0dHcE0vay9meGRmdUlWNFh1QkNq?=
 =?utf-8?B?eTJOT3BpNEx1bGZmc1g1czZDMGJXRUpOU2RrS0pwMFZ1aEZQbW1UVWliRkZ6?=
 =?utf-8?B?R25WYVV3WFdSYS9DcVRNbGhUdWdueDBBZ1BxVG9jaGM2Z0hKNnNpSDRYMEhp?=
 =?utf-8?B?MFZRbThDcUliMjBtVDdPdXBabjlYeURQanpwak9iYnpOcEI5RUhnamRvUFVx?=
 =?utf-8?B?d0ZnbkRYcTZCZ3orVVROK090MFFBNlp4MmhRZldKOW9kZDNyYTVybmlOTGlN?=
 =?utf-8?B?c1JoZUs3dmVCaVN5eklRWUhMbXNYc3FKVVQ2bFVBbW12QVV0blowd01ZTlRW?=
 =?utf-8?B?QkhnTy9sWDlRUDJvQ3M0U1N1NE4zUTNFL0o3Mlg2RzhFV2VyUHNpRjRMK0ls?=
 =?utf-8?B?ZWpMQVY0RW90dVlHZ1RPamppampqRjdEYVBiZGVLSVd6RnQ1UWJtbDBrS3Zw?=
 =?utf-8?B?K05LbHJmeXRoUHhYUmFFQmpPWk1JbUU2QzRNMTcxNzB5Q0lnLzdWbDZMaGVN?=
 =?utf-8?B?aHUvVU5keTBJUEJhQjR5U2RRd3J3ekZRaHFHTG4rSW1ybEYvcHlSd2ZpWkYy?=
 =?utf-8?B?cUVaZEFNYVdtV1FOaEg4bmZlcHYySzNzKzcvZ1U0VjM4ZjU3TUpDWWlIWlNh?=
 =?utf-8?B?OG9ta3RhMG9KTDJDbllaeFowZDlxc2l1TFhvZlVEVVlJODRENzR4QXU1aCtQ?=
 =?utf-8?B?a21FYlZocUZKbE5HeVNvTkdkaXFqK0NON0ZzRWgzc29UekdWeHRlRnlMbUd5?=
 =?utf-8?B?YVJEVE1zY09vOE1jL1BvemQyRGxDZU5DMmRWcE8vVUdrZThZdUxuVWJ0QWhX?=
 =?utf-8?B?MURIVGdxam5EbDE1ekRYTXdnN0c5K1htN1N4K3ZrYzE0TGY2WTM2WUVoRnA3?=
 =?utf-8?B?WmlOVzhlTUwrTVZPWXhLQ1BYTE9mTWl3TXdWbE5rSmhEQk9RckhZMEpBR0Yw?=
 =?utf-8?B?MEJhV05scTZzN2d2QThnMEdkZ2czZXZYMU1hYm16K210d1ZWRlp1YnJ5Wndi?=
 =?utf-8?B?K0dhUFF3aDUya0xxYS9rS3VPSmtTMTdVd09YMThQOUlVL0pESFpoTFRWVjVN?=
 =?utf-8?B?Y1o0SUFIZnEvbDRPY1MvckJBSHVyeXIxYkNzK2hmVzhtQ0pXUVFqTjh4RU8x?=
 =?utf-8?B?eFJ1Z29oTFNVZUFMQ0lhcXdpZ1dWQVFTSlVoTkc5L1c1MUJGMEgxTjVsUmd4?=
 =?utf-8?B?RUt1Y0pqc3VyalB6aWVEZ0N2VjRVbkY5QXhwME1wWjd5UWhDNGhSSVVGNzcx?=
 =?utf-8?B?Q2Vob2F6SDFjYUkvbWhDNWFVd1dMckpvRjJyM1BEa2hIeUtZa2UzeVZaeEZo?=
 =?utf-8?B?b3JHdWJoVW92MExOZXFRT1NnK29oY2w2U0RWdmYrV2tmdkt6WW9KVkxnUnAr?=
 =?utf-8?B?c1loenc1UktFWXUyR1g1MGNQdU5RMUlmUTgrU0pmYnNjRUF1TkJ6REZrOHZV?=
 =?utf-8?B?VUV4U080Z0xuR2tnM2JuTkV5WTZGRis1TlE5R2ZoYzBDVHRrdWhweXRhQ1ZZ?=
 =?utf-8?B?VW1xR3A4bnVxWlZZaXp1aDdydVljL1kvTEZNd1VWZzVZc0Nsb2kxN2RFL1ZU?=
 =?utf-8?Q?oi04KoZuJC5ddQomKSagh6nYnEE1E5V6VcEzU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a84ace-d8ff-45ea-c0d8-08df337a1fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 15:59:32.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6989

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIE9jdG9iZXIgMjYsIDIwMjYgMTo1NiBBTQ0KPiANCj4gT24gMTAvMjYvMjAyNiAxMDoyOSBB
TSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+IA0KPiA8c25pcD4NCj4gDQo+ID4gKy8qDQo+ID4g
KyAqIFRyYWNrIHRoZSBjb3VudCBvZiBTUElzIGFzc2lnbmVkIHRvIGVhY2ggQ1BVLiBQaWNrIGEg
c2luZ2xlIENQVSBmcm9tIHRoZQ0KPiA+ICsgKiBhZmZpbml0eSBtYXNrIGJhc2VkIG9uIHRoZSBT
UEkgbG9hZGluZyBkYXRhLCBhbmQgaGF2ZSB0aGUgcGFyZW50IElSUQ0KPiA+ICsgKiBjaGlwIChz
aG91bGQgYmUgIkdJQ3YzIikgc2V0IHRoZSBlZmZlY3RpdmUgYWZmaW5pdHkgdG8gdGhhdCBzaW5n
bGUgQ1BVLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGludCBodl9wY2lfYXJtNjRfc2V0X2FmZmlu
aXR5KHN0cnVjdCBpcnFfZGF0YSAqZCwNCj4gPiArCQkJCSAgICAgY29uc3Qgc3RydWN0IGNwdW1h
c2sgKm1hc2tfdmFsLA0KPiA+ICsJCQkJICAgICBib29sIGZvcmNlKQ0KPiA+ICt7DQo+ID4gKwl1
bnNpZ25lZCBpbnQgY3B1LCBwcmV2X2NwdTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJ
cHJldl9jcHUgPSBjcHVtYXNrX2ZpcnN0KGlycV9kYXRhX2dldF9lZmZlY3RpdmVfYWZmaW5pdHlf
bWFzayhkKSk7DQo+ID4gKw0KPiA+ICsJc2NvcGVkX2d1YXJkKHJhd19zcGlubG9ja19pcnFzYXZl
LCAmY3B1X3NwaV9jb3VudF9sb2NrKSB7DQo+ID4gKwkJaWYgKHByZXZfY3B1IDwgbnJfY3B1X2lk
cykNCj4gPiArCQkJaHZfcGNpX2RlY19zcGlfY291bnQoZCwgcHJldl9jcHUpOw0KPiANCj4gTml0
OiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gYWRkIHRoaXMgbnJfY3B1X2lkcyBjaGVjayBpbg0KPiBo
dl9wY2lfZGVjX3NwaV9jb3VudCgpL2h2X3BjaV9pbmNfc3BpX2NvdW50KCkgaW5zdGVhZD8gSSBk
b24ndCBoYXZlIGENCj4gc3Ryb25nIG9waW5pb24gb24gaXQuDQoNCkkgbGlrZSB0aGF0IHN1Z2dl
c3Rpb24uIEl0IGRyb3BzIDUgbGluZXMgb2YgY29kZSBmcm9tIHRoZSBwYXRjaCBhbmQNCnJlZHVj
ZXMgY2x1dHRlciBpbiB0aGUgbWFpbiBjb2RlIHBhdGhzLiBJJ2xsIHdhaXQgYSBjb3VwbGUgb2Yg
ZGF5cyB0bw0Kc2VlIGlmIHRoZXJlIGFyZSBhbnkgb3RoZXIgY29tbWVudHMsIHRoZW4gc3BpbiBh
IHYzIHdpdGggdGhlIGNoYW5nZS4NCg0KTWljaGFlbA0KDQo+IA0KPiA+ICsNCj4gPiArCQlpZiAo
Zm9yY2UpDQo+ID4gKwkJCWNwdSA9IGh2X3BjaV9hcm02NF9nZXRfbWluX2xvYWQoZCwgbWFza192
YWwpOw0KPiA+ICsJCWVsc2UNCj4gPiArCQkJY3B1ID0gaHZfcGNpX2FybTY0X3NlbGVjdF9jcHUo
ZCwgbWFza192YWwpOw0KPiA+ICsNCj4gPiArCQlpZiAoY3B1ID49IG5yX2NwdV9pZHMpIHsNCj4g
DQo+IEF0IHNvbWUgcGxhY2VzIGxpa2UgdGhpcywgeW91IG1heSBzdGlsbCBuZWVkIHRvIHJldGFp
biBpdC4NCj4gDQo+ID4gKwkJCWlmIChwcmV2X2NwdSA8IG5yX2NwdV9pZHMpDQo+ID4gKwkJCQlo
dl9wY2lfaW5jX3NwaV9jb3VudChkLCBwcmV2X2NwdSk7DQo+ID4gKwkJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJaHZfcGNpX2luY19zcGlfY291bnQoZCwgY3B1KTsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBpcnFfY2hpcF9zZXRfYWZmaW5pdHlfcGFyZW50
KGQsIGNwdW1hc2tfb2YoY3B1KSwgZm9yY2UpOw0KPiA+ICsJaWYgKHJldCA8IDApIHsNCj4gPiAr
CQlndWFyZChyYXdfc3BpbmxvY2tfaXJxc2F2ZSkoJmNwdV9zcGlfY291bnRfbG9jayk7DQo+ID4g
Kw0KPiA+ICsJCWlmIChwcmV2X2NwdSA8IG5yX2NwdV9pZHMpDQo+ID4gKwkJCWh2X3BjaV9pbmNf
c3BpX2NvdW50KGQsIHByZXZfY3B1KTsNCj4gPiArCQlpZiAoY3B1IDwgbnJfY3B1X2lkcykNCj4g
PiArCQkJaHZfcGNpX2RlY19zcGlfY291bnQoZCwgY3B1KTsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwlyZXR1cm4gcmV0Ow0KPiANCj4gPHNuaXA+DQo+IA0KPiBXaXRoIG9yIHdpdGhvdXQgYWJvdmUg
bml0IGNoYW5nZXMsIGZvciB0aGUgcGF0Y2ggLQ0KPiANCj4gUmV2aWV3ZWQtYnk6IE5hbWFuIEph
aW4gPG5hbWphaW5AbGludXgubWljcm9zb2Z0LmNvbT4NCj4gVGVzdGVkLWJ5OiBOYW1hbiBKYWlu
IDxuYW1qYWluQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IA0KPiBUZXN0ZWQgdGhlIHBhdGNoIG9u
IEF6dXJlIEFSTTY0IFZNIGFuZCB2ZXJpZmllZCB0aGUgaW50ZXJydXB0DQo+IGRpc3RyaWJ1dGlv
biBhbmQgYWxzbyBzYXcgc29mdCBsb2NrdXBzIGRpc2FwcGVhcmluZyBhZnRlciBvcHRpbWFsDQo+
IGRpc3RyaWJ1dGlvbiBvZiBOVk1FIC0gUENJIGludGVycnVwdHMgcHJvZHVjZWQgYnkgdGhpcyBw
YXRjaC4NCj4gTm90IHJlcGVhdGluZyBoZXJlLCBvYnNlcnZhdGlvbnMgYXJlIHNpbWlsYXIgdG8g
d2hhdCBJIG1lbnRpb25lZCBpbiB0aGUNCj4gcmV2aWV3IG9mIHYxLg0KPiANCj4gUmVnYXJkcywN
Cj4gTmFtYW4NCg0K
