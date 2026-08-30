Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011009.outbound.protection.outlook.com [52.103.1.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68050242D9B;
	Sun, 30 Aug 2026 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134275; cv=fail; b=faXAcQ66tfjLtCf9yqPfXxqzc5rsNuIgO3OPv6z2wMKCWMm1BZ+bv15e9jmaGfvUeBBgYFXGJjtxzZisbtFNsqbaz2YZoGUqmKcDg/UAPTsvmilTj9gWDz+NEi0wT928Y69ftBnW/RnXlRZSjLZ5x+R6ev0F8xxk/tIw8lgUW+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134275; c=relaxed/simple;
	bh=aYLr8Ws3/OnBssFrSPYKBGPjV2qjyc5YG1bCCp6mU8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8u2bygXnIAJGwhrWBQOmC2mTYqvTJJWV6piR893m02Ok1XQK/6dcHhj8qIxEbZeGlyK5WGHV+Af7l9rAmHCKQhaymsSQgv0oVfCXO/VuGxpYZvIfakI9R4BAqwhT240DTWZGgwq2hCgdjoCYV6yTzA5/cKQ0Nj6OcO+S9gBWUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jjfGyWAy; arc=fail smtp.client-ip=52.103.1.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jjfGyWAy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNeLvAZPksYAXMW/GgTz0hWgzbIlFbZWnVGt2/9xgn4ra8hEga0gYWF49rbLy85MsRIATtxJVd61nYrvt7BV3k2YEc61lJ3/hsevB1AyQXKRkcR5Em48LXhemDXea3Yfs9pNacZbF6h1UMdljiq1IrwzTnf9M7s+zRKYBFuAixxto9Nn+ZexwpgDS/InjRhvWTLhXb8ssAKkpGGo+9yOLCDK6jly0EJjQJMaikDyFJMjsixcD6Yr9BQyWYsyfS1oc227BCeWhn5bI8krWIj1K9IVhL5Ih3FhFr+IiHZ9zff+L3PJeqnKyV4pfzxC36RVPm6OUX+cu8/QLSGjZn/ETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYLr8Ws3/OnBssFrSPYKBGPjV2qjyc5YG1bCCp6mU8s=;
 b=i7bjJHhDChauM5SDaNlFAKI8uDOqN1w+CcTPkfc7Vu5WMZ2/PS8OBnkVWChw7eTwAELCygle5m2X8DPJ39GIdkxmy1iKNMiUaH1ws9wuNMFJze32UvkPJNt65m5NMeMPm9Wy8dbClS5f5aNg3da68mkBpV0qCn8MYtJNq1qXiLTTfifxMxXsOgxVfCefepNjPI1Eerp6C3RoTj+OAugMtd2xPnTMs4vm3iJS7DWHIYEVel/iEb+njbx1AYh3h7PjIaltWmfpEITrBP9QH0zvPfbcpWKrlQazwnXVtcoktSQu9tJaBkYFtvyEI9dUfiHZx8XOe1SPu0Zsv5MFx/6rYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYLr8Ws3/OnBssFrSPYKBGPjV2qjyc5YG1bCCp6mU8s=;
 b=jjfGyWAyABREBJ5lIixAJvHL1pwJYWy1KUf+EtbM0sWKBh90XtrX1uxpaRxExG7t+iRLF1WvMMu4TkvVx4qy+HFa7OVm7HNMoOi1IQcVE6RcL6c5xJ4E+p9Xu/OnscfSWVbHZQBEC1KDIGySLyEoFcAnf4hu7NUWBrMt8FBbxZhyhDX8j5YQos24j4aUhTuL3pg38RWqUmkvMEj7CUern61kyT4AByuxGfrIN7lqyb1IQhFj03Ws+UHjY1nFmzTiKRdHlptzO8V1zttif51w2MZwNr2Uk9na2r+/jhU2VNg/6/b29oJgi3TK1+tingwq5DWAmsGXP7NxQQ6+8s6JfA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:57:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 23:57:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@kernel.org>, Ming Lei <tom.leiming@gmail.com>, Ming Lei
	<ming.lei@redhat.com>
CC: Wangyang Guo <wangyang.guo@intel.com>, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Long Li <longli@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
Thread-Topic: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
Thread-Index: AQHdKJCMH5PeXdnWRUiBUqx3W0OgELavrJjggAIKUYCABa6rkA==
Date: Sun, 30 Aug 2026 23:57:49 +0000
Message-ID:
 <SN6PR02MB4157F84374BFA68158E0D85AD4AA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
 <SN6PR02MB415735EB56D0EBEAC606282DD4AE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ffd568dc-8292-43c4-b425-a68047a40c8e@linux.microsoft.com>
In-Reply-To: <ffd568dc-8292-43c4-b425-a68047a40c8e@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6947:EE_
x-ms-office365-filtering-correlation-id: b6e73d45-67cd-43b6-285a-08df06f27f66
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|19110799012|13091999003|25010399006|12121999013|24021099003|37011999003|55001999006|15080799012|8060799015|8062599012|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?aCsydEVpdTQyb0o1U21Vb0ZUSSs3RDIzNVZ4RG1XeGpmZWZ2a3VFN0d6TDc3?=
 =?utf-8?B?WXhKTkwzUzBieVdtcGpqMld6MWhleG5kMzE4djM1MXczbDR0S3AwRFhrUFYw?=
 =?utf-8?B?UUZqdzAxeWdSYzZRcnB0SzhZdmVQSWxjY2o1dzlOTkVUNk9TNTBiOTlTRkNG?=
 =?utf-8?B?QWVCTm5kdmtnM0Flc3FhZ0RGeE9kaWhQV1dua1hSOWtGeUF6TElYRW9IRS9q?=
 =?utf-8?B?ams2cnkxaXNwTGxRb1poM0krbTE2Q3lReVFZWjZsbFNpTGpCWWlrSGFReVhv?=
 =?utf-8?B?eG5uNzNIT0lPYUMwVktjeXN0dnREd1YyaVlocHhwVzE0c21xcUZLdjhoUDZC?=
 =?utf-8?B?QitmdXlEM3lGZ09JREQvOExBUnkzTytCcnp2VFlDbHFCWW9kRENuSWZLM3pi?=
 =?utf-8?B?aXphNm42YTVURDNCRUpGMFFxRHIvVzFqU2JxVWdZQndWMDJTbWljdjNQckJF?=
 =?utf-8?B?WWUyRjdFZUpGMUFkekZYYkZIY1YxMDFZbTJOc1Judlp3Um8wUGk3cGh3Skc0?=
 =?utf-8?B?RVJENTIxWFdyM3k3d1dFeTBHUlhuK1RKQU5lUWZmMlE3QVAyRTcySEVxRGlD?=
 =?utf-8?B?ZHZNTmRNZFB2UHJscFZuTzNmSjE3VlVrMHRGV0NXdm1FMmM3VE5EWFNXMStP?=
 =?utf-8?B?enVoU0VDanNUWVhZWW9BendRYThPT0tCak1NcUxFRkg1dkd2Y293M20vS2Q0?=
 =?utf-8?B?QjBmczA5cU9xMmtxVFJFWnhXSW0wa2trdk1kUnhQY0llMG5MNWhTeGFGNFR5?=
 =?utf-8?B?eXRSQTBLeU9lSGdoUUhsazRkanRvM1R2bUZxaGlzbWdWOHVIMVQyQWFXdEFG?=
 =?utf-8?B?d281ZWlOVk9GSzJ6VXlWbW54NFhuTndKMHRCeTBLTHdzMStndDdLVGZjUlJu?=
 =?utf-8?B?WXBoZ0dLOHZnZHE3a0UyQ1BVTXdRaEtmSUd5eTJsZk9tamNSWVQzR0pWWC9K?=
 =?utf-8?B?SHZTcm42NWh4VC9ZQk5uSkFxeFdPQ1VGeXZzUDlVbDRuZXNPMVUxL1ZwUDk5?=
 =?utf-8?B?eVlGSFpzK0xRb0ZZaER5OXpUN29GcnQ3YjZQQW5ZdmMrZWlLVUU1Y25ScmJu?=
 =?utf-8?B?bGxFTFZnY2R4d09IVVlXOHEyUUVMQTVVZXFBaExEZnBXYndrOWp5ellKb24v?=
 =?utf-8?B?QStNR2J1cDBTd2ZaYXI4VzJNWU4zQXU3SXYzc2Y0Y3dheU9qRGgwSStPZ2Rh?=
 =?utf-8?B?cnJVK2oxdnVIcmNaYTNwY25IQVM0bk9BSmVJYisrS0xtdjBTSFpycEpFUWlO?=
 =?utf-8?B?LzV1WE9CNHNrVk5OMDBwRWYzWWlReE1qT0JqMUliWUxGM0ErcTdLQkR3b2Rj?=
 =?utf-8?B?TnFVMnk0QWVORXdhNHdkYTBXZU8vcVc0NmlHQkkrc3dwbkh3ekZTbGtuYmRx?=
 =?utf-8?B?aWVzWGF6aEdvZjJaZjcrTlRUUW1JcDAxejdzSU5DWXB3RlNJbVAwRlJMR2F3?=
 =?utf-8?B?NWM5VG1TL0FYRkQxUExDbkFWY1E2bmlCRFVOcG5YdDJEQ3h1UTZqanp2enFG?=
 =?utf-8?Q?6ksLic=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1ZPYlFHYmZCN2QyYytwemt3ZHdGMkk5S0sweVU2OTZhTndsejhrOU00MWxQ?=
 =?utf-8?B?Q3dQbXBTblFqWk5SZTh1NEU4VlRlVVV4NTJqQkhKd0k2OG8rc2VpRlAzTFIz?=
 =?utf-8?B?VWFHQ1BQK3I2cFBxcnRiQk03Znl1YlVYTzhWNkg5RUhvL2h2dm0wN3Erdlhh?=
 =?utf-8?B?RG9reS84VzJsSnFEQURRQUovVXlWcTR2Yk5ZQWZSTkZoQndsV1IwUC93M1NH?=
 =?utf-8?B?RVF2ZFFxM3Izakgzamo0ZGRqdmY5akJ3Q0FJdzhkc1FnZjVrU05tWDhvbmM2?=
 =?utf-8?B?UUJCTDcrUzkyeklSYUFnYzdJbjU1NkZ2WWxQcmM4dG5udjlscmhldFNUUTdn?=
 =?utf-8?B?UE5OdnV2Y2Ird3FVU3MvanpSS0l2dTloTDRXUW9vWVVaak1zYW1sRkZib295?=
 =?utf-8?B?d0t4VG5DcUNwQVdnL0l4eml5Q2RjZnRBV282cklOaHhhbXh3akQvMmoveGNt?=
 =?utf-8?B?M2xaUDg0amE5akcxQllPeHBYOHpqSHpIRGs4dnM3dDloVWF5V2tJcVhjdDBW?=
 =?utf-8?B?UlU3UDg5WnRnK3E0c2FDZDc4Q2Erc3NDZEprbk1TYW1wdXVETklkVndZZktx?=
 =?utf-8?B?YkhyQWlJRHJXeHpqUVhvUWticVVoeEhzR1g5NVBpaHZyRTA3bzAya1F5dHFz?=
 =?utf-8?B?QVZyWnJhbnVSaG5Ma2lXVEtnNFBFb3pQOVRSNm9pZ0ZiSjZkbHRDRGlXbG5r?=
 =?utf-8?B?aTNiMVhyYnc2Q3ZDdUJRelg4ZjNDRHFBc1VEZTZSdko4T3B0VGRwbWpvS1R3?=
 =?utf-8?B?ZVlGeUVtVnBQbk83Z0svNkE1emo2aXBOYTZYUEx2d1JlK1R0VzMvR0w2OWRB?=
 =?utf-8?B?WlVlM0QwSW1FSUd1cmRYL0REUUI0YStybER2NG1BcHBDenFyMVJwNjQ5TU1S?=
 =?utf-8?B?VjA0cEtWdkJMMDY3R1VpTFduWFh0Rlg1NldSdHBGY1pvWUt2bHZvRGRDelFR?=
 =?utf-8?B?SmtaZUxlSmtFbHRuREpVdXNHUFZzcStnWldLMElNbjJuNXZrNVByeUVid25U?=
 =?utf-8?B?a0tQcVE0aXg4QUhGRnk3UUltMFJHb0QvQmh5SG1CTFBEenBpc1V1SlR3U2Fp?=
 =?utf-8?B?V3N0MEhZK0U3UmN6elVoUm50ZWNxa205YWVIdHlPbDFuSWd0Sm9tbGZFbnU3?=
 =?utf-8?B?QkUrbVpVcnZnOW9WYktoQ2orcGhKT2lsSHp1bzJFYWczSEFCNDhCd1dWSmN6?=
 =?utf-8?B?T2htc0VSVmtvblNpeTRNVnRTMVNVSE9CR05ub2hPZDlwS0RJK01ZS3dqczQ2?=
 =?utf-8?B?eFhsVjk5SWp1UFVQbHFoNjR1RyttZTB5aVFQSThhZXQ0QUJSRlNQVE44VzBM?=
 =?utf-8?B?dXhmdXZ6dHQyQ04zRTZsQ1JlNDV2Qkp3S21COVJpMXpQRU0wSHJ1ODFoRTZ1?=
 =?utf-8?B?V0sxUk9DdlVpTG15bGpMSGcwRmI2MjRlZ2xzcWd2bGFIWjRwY0djc1RkUHdL?=
 =?utf-8?B?OFhNeGhGL1VMd2NlajFDdVJEMzBmRGZkRG4rUGN0V0VFL2pvR0VQbUMxNmRN?=
 =?utf-8?B?Vm5Ic2dlV0xlMmJ2UU5DSW8wVzZPSHhEMDBmTC9QQzVJck9VK2x4dDJPN09Q?=
 =?utf-8?B?cTNlTXNKbFp3dzBYaXNtYmNxMHlKaUZHTUsrdFJUY1JCekc4d1psZXkvb0Ju?=
 =?utf-8?B?bkJaM3NTcWptNnhYeDBNaStwSElMRkt3L3ltQjdJRVFZVXREL09pRzNTQW1n?=
 =?utf-8?B?MnhLTjdmSWtpdUxNOWxWZk9FdS9yQWR0dDFXcFlYeXpQeTY4RCtabFFzSlF5?=
 =?utf-8?B?NytwOTRkVVRQNTR0Rys2cGxvVTBpMXVTQmhNOWRuaGtxclB2VmtMTHhCcjRv?=
 =?utf-8?Q?gmRmv34/0B7C8kimqEprXWh+NLibtrLKu8ONs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e73d45-67cd-43b6-285a-08df06f27f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2026 23:57:49.8685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6947

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDI3LCAyMDI2IDI6MTEgQU0NCj4gDQo+IE9uIDgvMjYvMjAyNiA3OjMxIEFN
LCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBOYW1hbiBKYWluIDxuYW1qYWluQGxp
bnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IFN1bmRheSwgQXVndXN0IDksIDIwMjYgMTE6MjIgUE0N
Cj4gPg0KPiA+IFtzbmlwXQ0KPiA+DQo+ID4+IEBAIC01MTAsNiArNjMzLDggQEAgc3RydWN0IGNw
dW1hc2sgKmdyb3VwX2NwdXNfZXZlbmx5KHVuc2lnbmVkIGludCBudW1ncnBzLCB1bnNpZ25lZCBp
bnQgKm51bW1hc2tzKQ0KPiA+PiAgIAlpZiAoIW1hc2tzKQ0KPiA+PiAgIAkJZ290byBmYWlsX25v
ZGVfdG9fY3B1bWFzazsNCj4gPj4NCj4gPj4gKwlzcHJlYWRfb2Zmc2V0ID0gKHVuc2lnbmVkIGlu
dClhdG9taWNfZmV0Y2hfaW5jKCZncm91cF9zcHJlYWRfY250KTsNCj4gPj4gKw0KPiA+PiAgIAli
dWlsZF9ub2RlX3RvX2NwdW1hc2sobm9kZV90b19jcHVtYXNrKTsNCj4gPj4NCj4gPg0KPiA+IE9u
ZSBhZGRpdGlvbmFsIG9ic2VydmF0aW9uOiAgSW4gbXkgdGVzdGluZywgZ3JvdXBfY3B1c19ldmVu
bHkoKSBpcw0KPiA+IG9mdGVuIGNhbGxlZCB3aXRoIG51bWdycHMgc2V0IHRvIDEuIFRoaXMgaGFw
cGVucyBpbiB0aGUgYmxvY2sgImxvb3AiDQo+ID4gZGV2aWNlcyAoZHJpdmVycy9ibG9jay9sb29w
LmMpIGFuZCBmb3IgdGhlIE5WTWUgYWRtaW4gcXVldWUuIEluDQo+ID4gdGhlc2UgY2FzZXMsIHRo
ZSBzcHJlYWRfb2Zmc2V0IGlzIG5ldmVyIHVzZWQsIGJ1dCBncm91cF9zcHJlYWRfY250DQo+ID4g
Z2V0cyBpbmNyZW1lbnRlZCBhbnl3YXkuIEluY3JlbWVudGluZyBmb3IgTlZNZSBhZG1pbiBxdWV1
ZXMNCj4gPiB0ZW5kcyB0byBkaXJ0eSB0aGUgc3ByZWFkaW5nIGZvciBtdWx0aXBsZSBOVk1lIGRl
dmljZXMgd2l0aCB0aGUNCj4gPiBzYW1lIGNvbmZpZ3VyYXRpb24gYmVjYXVzZSBpdCBpcyB1c3Vh
bGx5IGludGVybGVhdmVkIHdpdGggdGhlDQo+ID4gc3ByZWFkaW5nIG9mIHRoZSBtYWluIE5WTWUg
SS9PIHF1ZXVlcy4NCj4gPg0KPiA+IFRvIGltcHJvdmUgdGhpcywgSSBjaGFuZ2VkIHRoZSBhYm92
ZSBjb2RlIHRvIHRoaXM6DQo+ID4NCj4gPiArICAgICAgIGlmIChudW1ncnBzID09IDEpDQo+ID4g
KyAgICAgICAgICAgICAgIHNwcmVhZF9vZmZzZXQgPSAwOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+
ICsgICAgICAgICAgICAgICBzcHJlYWRfb2Zmc2V0ID0gKHVuc2lnbmVkIGludClhdG9taWNfZmV0
Y2hfaW5jKCZncm91cF9zcHJlYWRfY250KTsNCj4gPg0KPiA+IFdpdGggdGhpcyBjaGFuZ2UsIG15
IGNvbmZpZ3VyYXRpb24gIzEgKEF6dXJlIEw0OHMgdjIgVk0pIGlzIG5vdGljZWFibHkNCj4gPiBi
ZXR0ZXIuICBBbGwgQ1BVcyBpbiBOVU1BIG5vZGUgMSBoYXZlIGVpdGhlciAzIG9yIDQgSVJRcyBh
c3NpZ25lZC4gTlVNQQ0KPiA+IG5vZGUgMCByYW5nZXMgZnJvbSAzIHRvIDUgSVJRcywgYnV0IHRo
YXQncyBwYXJ0bHkgYmVjYXVzZSB0aGUgTlVNQQ0KPiA+IG5vZGVzIHRoZW1zZWx2ZXMgYXJlbid0
IGJhbGFuY2VkLCBhcyBwcmV2aW91c2x5IGRpc2N1c3NlZC4gV2l0aCB5b3VyDQo+ID4gY2hhbmdl
IHRvIGFwcGx5IGdyb3VwX3NwcmVhZF9jbnQgdG8gdGhlIE5VTUEgbm9kZXMsIGFuZCBteSBjaGFu
Z2UNCj4gPiBhYm92ZSwgbXkgY29uZmlnICMxIGlzIGxpa2VseSB0byB3b3JrIG91dCB2ZXJ5IG5l
YXIgb3B0aW1hbC4gT2YgY291cnNlLA0KPiA+IHRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQgc29t
ZSBvdGhlciBkZXZpY2Ugd29uJ3QgaW5jcmVtZW50DQo+ID4gZ3JvdXBfc3ByZWFkX2NudCBhbmQg
ZGlydHkgdGhpbmdzLCBidXQgZm9yIHRoZSB0eXBpY2FsIGNhc2UgaXQgcHJvYmFibHkNCj4gPiB3
b3JrcyB2ZXJ5IHdlbGwuDQo+ID4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24sIEkg
dHJpZWQgdGhpcyBhbmQgaXQgd29ya3MgZmluZS4NCj4gDQo+ID4gVGhpcyBjaGFuZ2UgdG8gc2tp
cCBpbmNyZW1lbnRpbmcgZ3JvdXBfc3ByZWFkX2NudCB3aGVuIG51bWdycHMgPT0gMQ0KPiA+IGRv
ZXNuJ3QgaGVscCBteSBhcm02NCBjb25maWdzLiBJJ20gc3RpbGwgdGhpbmtpbmcgYWJvdXQgd2F5
cyB0byBkbyBiZXR0ZXINCj4gPiB3aGVuIHRoZXJlIGFyZW4ndCBhbnkgY2x1c3RlcnMuIEkgaGF2
ZSBhbiBpZGVhIHRoYXQgSSdtIGV4cGVyaW1lbnRpbmcNCj4gPiB3aXRoLCBidXQgaXQgbWF5IGJl
IGEgZmV3IG1vcmUgZGF5cyBiZWZvcmUgSSByZWFjaCBhbnkgY29uY2x1c2lvbnMuDQo+ID4NCg0K
SSBmaW5hbGx5IGZpZ3VyZWQgb3V0IHdoeSBhcm02NCBpcyBkaWZmZXJlbnQgZnJvbSB4ODYuIEJ5
IGFkZGluZyBhDQprZXJuZWwgYm9vdCBsaW5lIHBhcmFtZXRlciBmb3IgY29udHJvbGxpbmcgdGhl
IG51bWJlciBvZiBOVk1lIHF1ZXVlcw0KcGVyIGNvbnRyb2xsZXIgKGZvciBleHBlcmltZW50YXRp
b24gb25seSksIEkgY291bGQgY29uc3RydWN0IGlkZW50aWNhbA0KY29uZmlncyBvbiB4ODYgYW5k
IGFybTY0LiAgQW5kIGV2ZW4gdGhvdWdoIHRoZSBjbHVzdGVyaW5nIGlzDQpkaWZmZXJlbnQsIGdy
b3VwX2NwdXNfZXZlbmx5KCkgcmV0dXJucyBleGFjdGx5IHRoZSBzYW1lIHNldCBvZg0KY3B1bWFz
a3Mgb24gdGhlIHR3byBhcmNoaXRlY3R1cmVzLiBTbyB0aGUgY2x1c3RlcmluZyBkaWZmZXJlbmNl
DQppc24ndCB0aGUgcmVhc29uIGZvciB0aGUgcG9vciBzcHJlYWRpbmcgb24gYXJtNjQuDQoNCk15
IGV4cGVyaW1lbnRzIGhhdmUgYmVlbiBtb3N0bHkgY2FzZXMgd2hlcmUgdGhlIG51bWJlciBvZiBO
Vk1lDQpxdWV1ZXMgaXMgc21hbGwgY29tcGFyZWQgd2l0aCB0aGUgbnVtYmVyIG9mIENQVXMgLS0g
ZS5nLiwgNiBOVk1lDQpxdWV1ZXMgb24gZWFjaCBjb250cm9sbGVyIGluIGEgVk0gd2l0aCA5NiBD
UFVzLiBJbiB0aGlzIGV4YW1wbGUsDQp0aGVyZSBhcmUgMTYgQ1BVcyBpbiB0aGUgY3B1bWFzayBm
b3IgZWFjaCBxdWV1ZS4gVGhhdCBzZXQgb2YgMTYNCkNQVXMgaXMgdGhlIHNtcF9hZmZpbml0eSBm
b3IgdGhlIElSUSBhbmQgaXMgdGhlIHNhbWUgZm9yIGJvdGgNCmFyY2hpdGVjdHVyZXMuIEJ1dCBk
ZXRlcm1pbmluZyB0aGUgc2luZ2xlIENQVSB0aGF0IGlzIHRoZQ0KZWZmZWN0aXZlX2FmZmluaXR5
IGlzIGRpZmZlcmVudC4gVGhlIHg4NiBBUElDIHZlY3RvciBjb2RlIG11c3QgbG9hZA0KYmFsYW5j
ZSBhc3NpZ25tZW50cyBhY3Jvc3MgQ1BVcyBiZWNhdXNlIGVhY2ggeDg2IENQVSBoYXMgYQ0KbGlt
aXRlZCBudW1iZXIgb2YgdmVjdG9ycyBhdmFpbGFibGUuIEF0IGEgcmVzdWx0LCB4ODYgc3ByZWFk
cyBvdXQNCndoaWNoIENQVSBpbiB0aGUgc2V0IG9mIDE2IGJlY29tZXMgdGhlIGVmZmVjdGl2ZV9h
ZmZpbml0eS4gQnV0IGFybTY0DQpkb2VzIG5vdC4gVGhlIEdJQ3YzIGZ1bmN0aW9uIGdpY19zZXRf
YWZmaW5pdHkoKSBhbHdheXMgcGlja3MgdGhlDQoxc3QgQ1BVIGluIHRoZSBzZXQgb2YgMTYgQ1BV
cy4gU28gdGhlIE5WTWUgSVJRcyBnZXQgc3RhY2tlZCBvbg0KdGhlIHNhbWUgNiBDUFVzIGFuZCB0
aGUgb3RoZXIgOTAgQ1BVcyBnZXQgbm9uZS4NCg0KSWYgdGhlIG51bWJlciBvZiBxdWV1ZXMgZG9l
c24ndCBldmVubHkgZGl2aWRlIGludG8gdGhlIG51bWJlciBvZg0KQ1BVcywgdGhlbiB5b3VyIHBh
dGNoIHByb3ZpZGVzIGEgbW9kZXN0IGFtb3VudCBvZiBzcHJlYWRpbmcgaW4NCmhvdyB0aGUgY3B1
bWFza3MgYXJlIGNvbnN0cnVjdGVkLCBhbmQgdGhlIGludGVycnVwdCBsb2FkIGdldHMNCnNsaWdo
dGx5IG1vcmUgc3ByZWFkIG9uIHRoZSBhcm02NCBDUFVzLCBidXQgbm90IG5lYXJseSBhcyB3ZWxs
DQphcyBvbiB4ODYuDQoNCkkgd2FzIHByZXZpb3VzbHkgYXdhcmUgb2YgdGhlIHZlY3RvciBsb2Fk
IGJhbGFuY2luZyBkb25lIGJ5DQp4ODYsIGJ1dCBoYWQgbmV2ZXIgY29tcGFyZWQgd2l0aCB3aGF0
IGFybTY0IGRvZXMuIEkgaGFkDQp0byBydW4gYSBmZXcgZXhwZXJpbWVudHMgdG8gaGF2ZSB0aGUg
bGlnaHQgYnVsYiBjb21lIG9uIGluIG15DQpoZWFkLiA6LSkgIEJ1dCBJIGxlYXJuZWQgc29tZXRo
aW5nIHNvIGl0IHdhcyB0aW1lIHdlbGwgc3BlbnQuIA0KDQpJbiBhbnkgY2FzZSwgaW1wcm92aW5n
IHRoZSBzcHJlYWRpbmcgaW4gc3VjaCBjb25maWd1cmF0aW9ucw0Kb24gYXJtNjQgcHJvYmFibHkg
aXNuJ3QgdGhlIGpvYiBvZiBncm91cF9jcHVzX2V2ZW5seSgpLiBUaGUNCmFybTY0IEdJQyBjb2Rl
IHdvdWxkIG5lZWQgdG8gZG8gc29tZSBzcHJlYWRpbmcgd2hlbg0KcGlja2luZyB0aGUgZWZmZWN0
aXZlX2FmZmluaXR5IGZyb20gdGhlIENQVXMgaW4gdGhlIGFmZmluaXR5IG1hc2suDQoNCk1pY2hh
ZWwNCg==
