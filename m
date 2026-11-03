Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793681454;
	b=24QhX5pWwHBlKKH0WfZSJIfPkc9670hoYrGulluABSQOtcdBm6etKoXERgJQQdkLIZ9n
	 tf6vDdVjm7xCK9TeNyPZGaRf/V1Va3uOQoad5L/ekWY+v8pUYPBtDIHNPoR06LIu0vEQN
	 1TUzKJTS9JeWBTrLNspAT5I+VId4jvg5lDNyDRUjkxZpImxaM21ne2+YookDpf5TWa732
	 eS1XN2RwQ3EaxD3Svx/O+iXYZExSRFGIVRtIvobH2cH4aQS8fW8i1kTbKcI6LremPrF7Y
	 R2AvmgrOvRExd7Ju9PE4AHhL0pKhy8cntqtIfG5Be2KIliT00zdtN1Zaldn0gOLqZcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681454;
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
	bh=QtqHDWHRhO5y4jFged8jVQLpM2d/chcU5newRAprwhU=;
	b=Ozt5JfodsioO9+sY+iDiEKc23YN0AI150rNrTgZkkpH4x2sIQNskPqqMr7CdMJzwjUni
	 DBZTBND2kpYKVSnNcBnnOqP9Fgu7H9lKv/rPU06ad67JB/zBlaioxPI7iT54MzqAl+adZ
	 43e6H996quPxoAVJVWpr3OL9LXG0y1M+DLBJU2/g/c6q+bPPPwJaGTcYdh7bZ86SQbLc6
	 uvSr+N+WCVoEiB3CVZ6nDKAqmagHk1G+HiMLvCItGg1meRCQyJyvtbozAGeo+KpJdVHEL
	 C9RFHIaCWbE1XLZKwv+Fq9+ZdEXWAq7Xm2hpd9OvZcSwbnLD7suyUwR4SW+wjPHtCaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=orFSDDUw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011012.outbound.protection.outlook.com [52.103.1.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF01606A330;
	Tue,  3 Nov 2026 04:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF01606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=orFSDDUw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsATJjjgUxuc/SZZgqYeq1uUKyUizK9L5dJcfTiNKgLMu50Oeh8Cz+R151Z+7h1GgopeAhARUO+oNkNn0CIL3exK3JiTSRm0bOl4ldoUcsmCtL6u9LtLGmScthh98UpYs7O394VzI1hVg6M01nPQQwA5ZcbK3F11xfROf1eIHuvjn6IdH7MkRa+Q3AZHY8qnuos9SvGd0T982upJ2H0ZMQ2gQxGPnDcM1LwriZIQ2EGrj5RO0O/w8B73/SimMAO0okpcFYzqYYXRlWCEt+gWcWdu9oJxmbZLmOORqEHjzUAVpLAJ4BM8yqVpkodQBJ0jw0rNeF+tAinaMf2Sqhj2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtqHDWHRhO5y4jFged8jVQLpM2d/chcU5newRAprwhU=;
 b=nK3S0LddAvMGiRzx5q524etX7LF9lca2lL5XyIsQLgQFh40ElZ3SCJVJHUZy4IgMp5SGbp/fOt6F7AQVu65SXMiZ+/flO07nWt4rZgEHDa7sv8bx7+5onT3pnt9Mj7P0Ijz1pQux3j/ozwEMqPNWMXRoeC5IVtCoPBYS+u1bJRZh1UbHqHFgnucIUQqUZpy5DQ9AHPkpmfSCX5FYs6WNUXuHyDdf2ZZBvebrqszaf9mmekdwy32Aeo+bD2F5mHuUrHHQBytbqnh37eHW3Ka7yF24h7iGsvDnrV444xDYoAoc3j6Who/otX9gcu8ua83UyRNJVKM9aDY0tUHwf0ZKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtqHDWHRhO5y4jFged8jVQLpM2d/chcU5newRAprwhU=;
 b=orFSDDUw1sy+Wh2abn5NTBB5GKMF/xYxZjrJmytIFe15DGn9TPUiJav4nRMHxpBElNqUBK8lvgOzidIi4LLIAsgXcgi4VokstXovulQPH06likObX8Zhay8yH0w0n0IGn32kDKFWGNbZtiH0x0mzkmoWl4VxsT2nafmncGEJp/JMGF7/c3kAqt8wqrxm6JSpV70bCX9Bu+j6bVyS/71buuBbuHev0Y7QCG4FGZHialCSZrm1L9iEGFIL2A2z1wkXXTwc/CAip9fRKrzVwZ38Lbp35NkgzraV+sLWvKsaX+yAkp+cBnBfN7/73sl8GM/OkpXc6vrN1F58SVbAW4HC+A==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by LV0PR02MB11136.namprd02.prod.outlook.com (2603:10b6:408:335::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 04:50:51 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 04:50:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Daniel Pereira <danielmaraboo@gmail.com>, "mhkelley58@gmail.com"
	<mhkelley58@gmail.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 1/1] Documentation: hyperv: Update docs for PCI pass-thru
 device support
Thread-Topic: [PATCH 1/1] Documentation: hyperv: Update docs for PCI pass-thru
 device support
Thread-Index: AQIXomI6+otxfN4JCoxVV9PiYLu2L7anLLuAgAAsR2A=
Date: Tue, 3 Nov 2026 04:50:48 +0000
Message-ID:
 <MN2PR02MB68638712B3DECB1C25FDD5A0D4692@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261101022257.52819-1-mhklinux@outlook.com>
 <CAMAsx6eCrbcseb=eM_GW+3k2YF3t38Was35oQHW+3UkidsvKWA@mail.gmail.com>
In-Reply-To:
 <CAMAsx6eCrbcseb=eM_GW+3k2YF3t38Was35oQHW+3UkidsvKWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|LV0PR02MB11136:EE_
x-ms-office365-filtering-correlation-id: df3ac77b-9f5b-4acb-4aaf-08df396607cc
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|37011999003|15080799012|51005399006|8062599012|19110799012|8060799015|21061999006|24021099003|55001999006|13091999003|25010399006|102099032|19061999003|3412199025|440099028|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3VVYmlycmNhVWhuYm1HU0ZSaitURzBqU2JjalFqWndURThOTGt0NVZsbTY0?=
 =?utf-8?B?NndGMWJuL1FxZzFkT2NIdm0wc0hkMi9QQzdIN2hqZG40Vy9heVNCV09QQy9h?=
 =?utf-8?B?RFRBTFFQUVhJdmJjeklselFzVlJLYnZVNE1yS1hjbFVnSzhVRUpnUVdvaDJu?=
 =?utf-8?B?V09iZTRqU3pQdFJMVWhHc1RVcXhyNDhybG11Ni9obUhxRnozSWlkem5DNkJR?=
 =?utf-8?B?M082M2RRZExFekRkVHFPMnVoamlOb1dHNkNZbmg0dFY4YTUvMTQyTGhqbmtj?=
 =?utf-8?B?QS9jUzQvT0M3VGsyM0ZhcDRxMFZKNFV1bm9RVEdYeWV1eVM4YVdNWFZMMVZ0?=
 =?utf-8?B?SUs4WjdTVC9sWktOVkVTUmhQd0tLL3RBLzNHY3JYV1RZYU1rODM5cjA2UWlK?=
 =?utf-8?B?bDFaZkx6V3dvZ0kzdStSZU80UnNRRHZJaWtTL1VXUm5oaHZSVEk1UlF5Zlc1?=
 =?utf-8?B?clY1bGFaQWNWSzJiU2NiSzJHZ09BS0Yrd21kU2piVjhuQmRMUkU0blJvbDRO?=
 =?utf-8?B?c2hqVHZBcm5aL1dtc044bEFHM1BxVnVXZkF3bmRXdjFna3p6TFk2cm9WYkJ3?=
 =?utf-8?B?UU1LUitnNFI3bUVVbDRQSmRzcVBDeG1Obnljck1uS2hJZW8vaVBSbXZZbC9i?=
 =?utf-8?B?V2doekZxSXBmL21JK1VseXkwdmtZNHUzWlpZaEdXSU85Ym8yS05uZUtwQU9D?=
 =?utf-8?B?d1hubWphWE5tVUwzOXZLT1FZcjU3YUJXOEx0eTgxenJiSVkyQllYT2xvakpo?=
 =?utf-8?B?V2c0VDVuOUdsSVpsbnhtbndpb0tNZ2d5U2duVGcyQ09FYkVIRUtacENmUkUx?=
 =?utf-8?B?TGhVUnQvcElqTm10SnFJR08yM3Jhazh2aFo0MjB4VXhGMlR3TkR1eUdORHJq?=
 =?utf-8?B?RUpMbDR0VlJzSlNFUVpjU1VZdHJHTk8rU2xNYTBGek14T0hodG4ySW4zbHJh?=
 =?utf-8?B?N2F3cURoNTk2ZnpxbTZFUU5LUjJPWGRReHAyMlVqc3kvSnhhTGlmRGFwbVR0?=
 =?utf-8?B?dG0vNk05SzNqd2RPY0ZJNWtQeVJwZWFxeC96VlZlVlV0WE1wd3NRVHQ0dW13?=
 =?utf-8?B?cGVqNy9mYVpiNXI5UDBkNExOcHVrODB6dklSbzBDWXduZE1oM0RCK3J6WkVG?=
 =?utf-8?B?aGI4QmZZUFJyOS9vc1laQVhHZm12Uk94SVRlWHJibU9BcVVkckF0dVZ4T2V0?=
 =?utf-8?B?SHBwcERNVHVnUzArTXpqM1BHenNMTklUUC81dCtEdG5uNHVuNUxPNnFJSW1p?=
 =?utf-8?B?NHZHazVqZUdhSkpiZjBENER5UWxYU1RyNlU2T2FhU05VVWZnUlBKMlhaV0JV?=
 =?utf-8?B?U3lCbHdneFBBeDc2ZGIrUDkyMy9BcEY0Q2E3cnFoWjQzRkJQLzZ5dFNydkpX?=
 =?utf-8?B?VTM2QnVHZnllRUF4bnp5aEpiNVFrVGM5VjJ2NGY4ZmNzMXdQTWE5WkVGVGlI?=
 =?utf-8?B?cEZ3YjNPalpZMUovVEpnNUl0emQyS2luTjEyQXJobEF2YU1nZklad080RUFm?=
 =?utf-8?Q?vyjGe8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmVoK3BzS3Jmc3NVWjFmZkxudjBpaWNWRzFuT3lzZFBRNWRBVGRmL0NrblZK?=
 =?utf-8?B?UFM1dHRjdy95VzEyTXY2WU8wQUlXWnRTb0R1N3NaY0JxanpwbEhGZXZ3Y1J4?=
 =?utf-8?B?MDFtVnBIYXlFejRWby9nbkNYOGRybTE4b2NseUV1UWNLbzBXSUVHeG9lbVhS?=
 =?utf-8?B?UHhCK0hwY2pwWWUrVWZDUkhlTU4yTCtqbzRZZ1orbVhLeUFJVGtLWHN1dmpv?=
 =?utf-8?B?YnZhVGFDeTFKMXJJOFJuNHpDZndKZi9CcnA4RnppdjZINFQ1Q1ViOXhUM2Ir?=
 =?utf-8?B?RTgvTmtmSGo2T0hqbEpVN2ROQzBPZHBuWUgzaENEaEJsbnVza1EySzA5TmJj?=
 =?utf-8?B?bzA2dlp6aXBYS2w5RWQ4eWcrVTE2ZGFkSTl4KzNGV0JzZG4xcDNuaDdpTE1v?=
 =?utf-8?B?bnFHcHQvSWU3VmNQOUJSY0E5VGdBK0FsZ3ZoVDc4NDVLN2tjVVBkamxtdk1r?=
 =?utf-8?B?TGlvZjhoM25FV1NUWEYzZ1dzV0lQWHlPbzNiZkJKWkRDZ0hMZU00R3RBUkls?=
 =?utf-8?B?L1h1OC9DVnRkWHpCbFVnRU1QRFA1dExkV3pKMnQzZGF4ODZ1RlhtOEQwL2Rt?=
 =?utf-8?B?R2dreXFta09nTUVQY0QvOTkwS1h1T0VTVmVJOU1DNU5LMCtRUFQwMklEcjlS?=
 =?utf-8?B?YUtjb2tWVGRuTzM2KzJLdUNPKzhaYzMyQjY3RkV5Rm0xbWhnSytSUER1Wng1?=
 =?utf-8?B?LzRRNDUyWkdKS0pzcWtHdmNpWU1XRFBZZE5TTGtZMHZKY0tVSXpJVVEySlFS?=
 =?utf-8?B?NzUxdTJYelRmbURqNGZXT3AzN3UxZGphYk15cFlaOG5mOXpnRzZaR3VjZHdn?=
 =?utf-8?B?elBDaS9POFptcjAvOXZVZXFybkJWUlNlQklDRkRBVkJldWMwSWZxRVNTRWdW?=
 =?utf-8?B?Z3VIWFNxVXl2aVdmVngvZXlVUUx1ak5Lc2tlZ3pSQUsvRkRRWFJhUG9ybjdq?=
 =?utf-8?B?UDBMQnYzcURXSGI5TGh6V01DT21UbytnSmRKOHVmV1J6RnRmZzdZY2poblU1?=
 =?utf-8?B?c1V2WENGakFRV3R0REk4bEUybm13QXNRWU5oQWtrajZIWFp3N2htYjZsMUk5?=
 =?utf-8?B?R2czMklnL2d0Q2taU2tmTWxYQURWRzdUSERMQ0R5b0FjMUhiMHMyMlZOSWU1?=
 =?utf-8?B?RENmWVoyUTVLQ3ZsTEZzUGtuMUVIMHNyclhvODNoaUowVTZpRTd1QnpOaDFp?=
 =?utf-8?B?S1k5STRNZW1idDc0VXBzdmlCdFM2Nm1tVUx1ck41REFTaGF2dlkvNTFxbmJD?=
 =?utf-8?B?SmRsRDZxK25GWHF3YWJjY3RWT1dlMmxiT3U3eDRhMlFJQ1lzQmhrL3VZVmxU?=
 =?utf-8?B?cHliUmFHYXN2VGRkdW5YeU9XQ29UQmxHcmt3NW9VKzBGc09IVXZIQTUyTzhp?=
 =?utf-8?B?TitJWmZDdStRQW9yclpIaUo3blNHQXB6bVpRbTBML283T1M2dEJUd1hRbURy?=
 =?utf-8?B?SkFjUVUyMDg5Q0U4TFJJVC9lSUM3L2dhd1BNUDVpSEtieDM5dERnemhtcHVX?=
 =?utf-8?B?ZVkzRTh3c1N3WGQ1YWl6MHNQNURoUXhZMUpLWERBRFBaVU1SS1RXSnVCNm11?=
 =?utf-8?B?TWRMaXZ5R3hYUlo0S2htYkZhSUdERUk2cTdFeXN2YlYzY24yT1hxaG93QlU3?=
 =?utf-8?B?MFQ2S3hyS2lpTU5DY0N0WEp6TGcvOStxZ29iYlNJTVhTbmQweEFjU1czVmdl?=
 =?utf-8?B?aVE1OWlzY0lOWE1ETldYU1hMNmZCYTN0cTYzdHFFbTNsYjQ0Q0tWK2hCVGl0?=
 =?utf-8?B?d3FGdThPVWE0L1YrQ2FrZWFPazNhSGRsMUVMV3NWclZNSUVIT0hOV0JjYjNt?=
 =?utf-8?Q?XMB/lZVyKP79SZz1HAl3fMQ1R0HPphtq2kkOY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df3ac77b-9f5b-4acb-4aaf-08df396607cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 04:50:48.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11136

RnJvbTogRGFuaWVsIFBlcmVpcmEgPGRhbmllbG1hcmFib29AZ21haWwuY29tPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDIsIDIwMjYgNjoxMiBQTQ0KPiANCj4gSGkgIQ0KPiANCj4gPiArYW5kIHVu
bWFzayBpbnRlcnJ1cHRzLiBJdCBiZWNvbWVzIHRoZSBwYXJlbnQgZG9tYWluIGZvciB0aGUgcGVy
DQo+ID4gK2RldmljZSBJUlEgZG9tYWluIGNyZWF0ZWQgYnkgdGhlIG5vcm1hbCBMaW51eCBkcml2
ZXIgZm9yIHRoZQ0KPiANCj4gSSB0aGluayAicGVyLWRldmljZSIgc2hvdWxkIGhhdmUgYSBoeXBo
ZW4gaGVyZSB0b28sIHNpbmNlIGl0J3MgYW4gYWRqZWN0aXZlLg0KPiANCj4gPiArImlycWNoaXBA
PHBhZGRyPiIgZG9tYWluIGNyZWF0ZWQgYnkgdGhlIEdJQ3YzIGRyaXZlciB3aGVuIGl0DQo+ID4g
K2luaXRpYWl6ZXMgdGhlIHZpcnR1YWwgR0lDdjMgaGFyZHdhcmUgcHJvdmlkZWQgdG8gdGhlIGd1
ZXN0DQo+IA0KPiBJcyAiaW5pdGlhaXplcyIgYSB0eXBvPyBTaG91bGRuJ3QgaXQgYmUgImluaXRp
YWxpemVzIj8NCj4gDQo+ID4gK2RldmljZSdzIE1TSS9NU0ktWCByZWdpc3RlcnMvdGFibGVzLiBU
aGUgZ3Vlc3Qgd3JpdGVzIGEgdmlydXRhbA0KPiANCj4gSSB0aGluayB0aGlzIG9uZSBpcyBhbHNv
IGEgdHlwbywgcmlnaHQ/IFNob3VsZG4ndCBpdCBiZSAidmlydHVhbCI/DQo+IA0KPiA+ICtPbmNl
IHRoZSBob3N0LXZhbGlkIE1TSSBtZXNzYWdlIGlzIG9idGFpbmVkLCB0aGUgZ3Vlc3QgbXVzdCB0
cmVhdCBpdA0KPiA+ICthcyBhIGJsYWNrLWJveCB0aGF0IHRoZSBndWVzdCBkb2VzIG5vdCBpbnRl
cnByZXQgb3IgbW9kaWZ5LiBUaGUgb25seQ0KPiANCj4gImJsYWNrIGJveCIgKG5vIGh5cGhlbikg
aXQncyB1c2VkIGFzIGEgbm91biBoZXJlLCBzbyBpdCBzaG91bGRuJ3QgYmUgaHlwaGVuYXRlZC4N
Cj4gDQo+ID4gK3ZhbGlkIGd1ZXN0IGFjdGlvbiBpcyB0byB3cml0ZSBpdCB0byB0aGUgTVNJL01T
SS1YIHJlZ2lzdGVycy90YWJsZXMNCj4gPiArdXNpbmcgdGhlIC5pcnFfY2hpcF93cml0ZV9tc2lf
bXNnIGZ1bmN0aW9uIG9uIHRoZSBIVi1QQ0ktTVNJWC08UENJYWRkcj4NCj4gDQo+IHN0cnVjdCBp
cnFfY2hpcCBoYXMgbm8gLmlycV9jaGlwX3dyaXRlX21zaV9tc2c7IHNob3VsZG4ndCB0aGlzIGJl
DQo+IC5pcnFfd3JpdGVfbXNpX21zZz8gU2FtZSBpbiB0aGUgbGFzdCBwYXJhZ3JhcGguDQo+IA0K
DQpUaGFua3MgZm9yIHRoZSBjYXJlZnVsIHJldmlldyEgWWVzLCB0aGVzZSBhcmUgdHlwb3MgYW5k
IGh5cGVuYXRpb24NCmVycm9ycyB0aGF0IEknbGwgZml4IGluIHYyLg0KDQpNaWNoYWVsDQo=
