Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012037.outbound.protection.outlook.com [52.103.23.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4A381EBA;
	Wed,  5 Aug 2026 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903203; cv=fail; b=GRS3uGa3G76dOgpUizbsOjVcYvsJNu8WAnEn3DStXc8y/S2XLifM4+7uAjl1DdeC9BNlGmhZp62xP6GnSUynRvbIZYOwIX4zYZpVYG5gzFUPH9Ep1nrO0a5+HxjVQkbiQ5woZDCfOi32PJ5WvnNldjL+N6n5WmXD/lxq3GDM9Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903203; c=relaxed/simple;
	bh=bFLqlKyyEISZba1eOMdHEHCTAtYoM5zxQ6cqtUBhsdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spCZICQkksuY3Sa3zlBJGIodIZoVr5uh5cC1UVugWSRL/ScQngBKLZ0g4LvGUSlod+GlO3/YlocHecFynAX+twu88nyBLecLEW+gzEsBaEIqjXtJjCzEouh6M4urIAwc3Ph/vgH7ij8qaMkyS+hUZjppCCLkvaQYIMW9PVWWIXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ryqFqLcq; arc=fail smtp.client-ip=52.103.23.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ryqFqLcq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1gfz5p0q8rW8KoCk90o1bJTkbaPRKqJBFgVckTFHiwP7AKkZHWLUVXuHfTi6Fp0UwqAcdnGxg/ycMQL4rQaVqTuiq06m6fqys9yzwFZ/9zEaaN291Y2ZjkFTfi3ldr+kMoHKG0yQpM1/5jYyGoSB7yazaOo05z2jejT7c2P6GejJSuLKFG4CP+DgA6qqrJwN270tcQxUhd9ffW/5wG8l0LQN4OF9lBlEOdXcXIGuZ02MG1EvjlClvP7+wSztdOyfgWhhjv3vHzsiX+kVPr+s+W4IZ1hPNCthIpJWmKDoy2H5ONnOp2mUlMZmSXttxceomm9FNBbjSms63DxPx/cAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFLqlKyyEISZba1eOMdHEHCTAtYoM5zxQ6cqtUBhsdA=;
 b=uVczDcQGJNCPLtbdL3MQF8E6Pv9r4jm1hOxeAVGOjE9flSWkbwpkNaG3rQImWgKoBfkRabuldLGDBUCqc4W7GXYdmK2msaLTTQFPruVJqs1wecGA/+2iC/1kl4Dby++HyJ0SIrXHg7G3L1ZXhaXfL3fNBH07vSOn1Dw19g69+jw58llhcUidZXsGXhJtq3vI6gr51Hf/4vfGWnEat0mSHBSzQwbbLNwd4HwwciciP0Hh00moXFrOTS+uaL51FtegH/5sVcyvuk2lkhUSrqUfkED7FUAXQcpNMGQlvoMMLbcZqjbgqaYGsN98xCHPAUTSG3HkEokD3ELLKdZtpSYONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFLqlKyyEISZba1eOMdHEHCTAtYoM5zxQ6cqtUBhsdA=;
 b=ryqFqLcqfPEhIJtEl3Pz20Y234Ofko+SNI2v3bsSxzvKDLucG5DZLaF72Qi0OcJIalwOUXyabwljhvfhRyY+YMcnLMFll+lJvdCy2ZBFAD5+72ieo3bYZN2Q20iO/ItlEDkQr4NoNf4wlmw4kkQ1mwq346UsibJwAhwcQ3cv4NgZTEcpdTzdYwh4/gVvZ6xFyEOldjACGhSpT1DipzW8VZSaBWdwtLLVAH9Np6qEeJUcP0LMXDABzLxPqsDlSf2jQaOzL0kHpnrBa/ihJoZoadb8ykJ7TJkrPT3QpwD4+JOprsm8IiyW4+HKbUM1MaU9yixJAPSHehEkHnWNqQg2+g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9203.namprd02.prod.outlook.com (2603:10b6:930:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 04:13:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 04:13:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Fail VMBus module init for
 non-nested root partition
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Fail VMBus module init for
 non-nested root partition
Thread-Index: AQIocF+/o929maeNmNdFaBWtVJKlPrX3sUUAgAAsGvCAAAg7gIAAAH4AgABaoTA=
Date: Wed, 5 Aug 2026 04:13:17 +0000
Message-ID:
 <SN6PR02MB4157566CE78CCD02C925E3CDD4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260804190517.101981-1-mhklinux@outlook.com>
 <ea0d31c0-5559-462c-b6d3-1ed6c01a9074@linux.microsoft.com>
 <SN6PR02MB415758E1637A763B06911B8AD4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ce1a513c-2eb6-449d-bfff-ce7a581d14f2@linux.microsoft.com>
 <afa0863f-92da-4f9e-81c6-f1676ea76870@linux.microsoft.com>
In-Reply-To: <afa0863f-92da-4f9e-81c6-f1676ea76870@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9203:EE_
x-ms-office365-filtering-correlation-id: 34393b56-1fa6-430a-cfc2-08def2a7e07f
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|8060799015|31061999003|19110799012|8062599012|41001999006|51005399006|15080799012|12121999013|37011999003|25010399006|13091999003|10035399007|40105399003|1602099012|2607281247196008|102099032|3412199025|4302099013|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?dks5VzR6ZHBuNlN3dGV6OE5XNVFyUTVNV0hNL2haSTluTE5pRE5uVWVldU1r?=
 =?utf-8?B?dEFiOTBXd095MFE4RTRCZnlpUXh6bjVPbU03Vk9uVnpIa1kxcW9qYXY3d2g2?=
 =?utf-8?B?YkJqaGI1c04vcU9tUmxveUtKRHhsR1NXU09NMS85MGNwdTg0R1lWSDJkU3JS?=
 =?utf-8?B?VGdmRzM5eDBOKzQwemg1Q1Z6VkNEelduY2dZNC9YQm8yQng0YUEyd1REdWdZ?=
 =?utf-8?B?Ym02MytMeHdUTCtsV2R0UGNUdldTTktUNzMyNk54Y0kwWkVwRXhzU3Ziblcw?=
 =?utf-8?B?Z2MzV3RXc0JZOS9RMGxUaWNxeDdjR2N5YzJhaXpYOUp5ckJPbEt6dGZCaUMy?=
 =?utf-8?B?Rm9EVUFxUXJRYUlVbkUxTXpnTWRIbmpNa2JKZFJTT2M4ZkV1MDMrakFyU1dH?=
 =?utf-8?B?V29YTjh2N2gycGxod21DdERvYWtFenJ5MkFqeGFETkVxT0Y4SnFvZk81NXRV?=
 =?utf-8?B?bUNsSXJHclVLOGZOVUs0N3FVR2UrUmpnZGtvQVBZZnNtZmpmMTRyT09XaTVl?=
 =?utf-8?B?N3pEcDl6MTFPTXA2SDBsc0xaai8rMzF5M2VFSXNld3U2Y0k2ZzNNdm1zakho?=
 =?utf-8?B?VHFPRDdhVnowTXgvR1pyczVaSWVjdkJ5NjJxQnA2T0lMRk5rMjRneUxRWGFq?=
 =?utf-8?B?OURNQXZFaHRtVXBTMGNGWDhYcWNZZFNpYnovNU45eStoWk1iWVdvQUl4VHpr?=
 =?utf-8?B?ZzBLMXlWeGdLdGN5UnFzUGVqVlZaajdQR1V2Rjl1OUVlaGFOTGtRSEw3Yjc2?=
 =?utf-8?B?czlYTDBWc1NKZm1lb2RnZE90K05Hdk1pZVg1cDRpSm1JcEhHSDg5ZXZLWVdV?=
 =?utf-8?B?RjgxWXNSUlMzVEJ0Nm53M1hzbDJMWmZGbkVySEwwK2NyeE90eGkveTNJUTlE?=
 =?utf-8?B?NWJJTWlITUlpdFZlLy9LY2N0WDNFS2dOcGFRdHpJTXVDMjBsekwvT1JBdDZt?=
 =?utf-8?B?di8yNWcwNnlyZEttcUtGVzZWT0JjY2MxczE3VHhCRVRkeDZ0SWNOTmV0b0NO?=
 =?utf-8?B?YnVBK0pYNHk2UmRzU1kzRG5NYkxIMUVWeUZtcXQ4SEtRLzIxblV6b0lZZ2k4?=
 =?utf-8?B?WWZkVXVabk1RZXRBNHJiZzBrbTRQT0k4L1RIcHYyWUlJMFdmUmhQLzUzTEJs?=
 =?utf-8?B?T2ZiL1JKVWh0RVlDc1JUbUVEZkEvNGk3cWxEcGRyZzQ1VWJZV0FxdVdsZzQ2?=
 =?utf-8?B?czY0M1BvM2gycS9NYzAwMFk2R01rMDVPSStrR0JFdEtsMnorWVRBU3QvV2lh?=
 =?utf-8?B?U2NOaUJZQkNOWFdxYVdrK1dwOWZOUUdTb2gva0JuTzJhWmVBS3o3OU5xSWxJ?=
 =?utf-8?B?dlpYMjVuT1BVZGtGcnQ1R0tOVFc2Z0xNcGdPUkhrdWw3bjFZVFc2bVlRSDRR?=
 =?utf-8?B?MXg1Tm9OVmZuc1laL3RxYTNlN0w4bmd4WWdKL283ZTdjRGxsNWNjYTRIekQ1?=
 =?utf-8?B?TjMxSVJwVklLM05EaUp0aFlxalhQQm9UL283QzE1UFFqWUVYT0s2cVpCNG1D?=
 =?utf-8?B?SzVlRGxjeUlYaFdmNE5SWG1TWDdKK2V3MnlYbysxek5wUU5oQW5EWFBmR2FP?=
 =?utf-8?Q?3rwOWTTzuRNcZ8FtssVGfAcoQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eW1zZHJPcXdicy82Y0JTdVBxUFBRZ2p3bmloYnVxdTlUQnhYMEVJcWJlbkJO?=
 =?utf-8?B?b3UvaWFtQmRWaDJKaHhJYnZHMXNwM0RBSVExbGJNVFAwSWZTZnVtTWZxUkhE?=
 =?utf-8?B?eCtpUktlZHlhVW53QklxOXRoVWdGQ013SGRLNzNyc3pGVnE1VHpTTnMxZkdx?=
 =?utf-8?B?ZWhaNFJreStsVGx1azlBc2NKci9VWGMyRFpmN28zbFR2b0M1Y3NYakZlVCtT?=
 =?utf-8?B?N1VyTEFFS1lIdEVvcEduV01qOGhPZi9PU0dRKzMwakkvbU9ySGM1TDBBaTFq?=
 =?utf-8?B?Z25RRS9CNWNmR2xMckEyRmZQZ25Ec0ZZVmRUaWxrc3U4Slc0c2FEOUlHcHgz?=
 =?utf-8?B?ZFI4b0hNUVZLZnZQRUk0Z0JBZCtoMGhTalU2STdaY3M0M3R1WDVjSlhCK0lk?=
 =?utf-8?B?QTZqRDZFWFdMTmxqcGluemgwSmhWd1BnK0xFbmp3REI2VmV5blg2TkpQRGhL?=
 =?utf-8?B?dkJnSHNsb1RPSFMrbXYwTlFmM3BCYnNJM2plS1cra2xvQ2ZJdjdWaGlUMklO?=
 =?utf-8?B?LzFqWXVvcUVxZ1hVdi9EVW1RMjcveFhCa0dFT3c5ZVc3L0g3Wmc5QXROSmxQ?=
 =?utf-8?B?Nm5Gb2JHbzhjWjdmeDdkcWU3VzZxT0grTjlxVjFkV252cFppMHRKd3pweEgx?=
 =?utf-8?B?UUptQjl1bGgzRDBpbFR5VS9pVjAraHFvNTdMUi9JeWZNT1dKcVh1YWJCZ0Zo?=
 =?utf-8?B?RC92OXMwdkhXcnIxbXNEWXZON3dPK1NwbEdjNTMvRGc2WC9aT08yOXRsMHBh?=
 =?utf-8?B?MVExTS9XSlJBQjFjYWdaaE9xblFWRzNSOG81ci9JMFkrTXptbDg4bXoxYzJp?=
 =?utf-8?B?RS9IMHExdjNKMUVPWnFQc0VHN3NvOFBKOVhDSlBrZ0VqYmVoV3c5NEtCdW9s?=
 =?utf-8?B?WnphQlNaUzNoSjdUSjhWT0FzbXJxOFdjY2lhRzFvZ3FTRU5MTnpkWmtlMktV?=
 =?utf-8?B?UGJrNkpDTW9EVmlGSDVMd3MzLzFUYUpoV04yeXQzR0hCcFVzQ2RFU1NIL0lt?=
 =?utf-8?B?RTJlSTcvOW1mRWVZSHlFM3Uyb0dtOVBseDdlWEVJYmJSVDlHbzRNUnB5Y1Jk?=
 =?utf-8?B?NkVPV0xXaDloRXI2SG9uNU03aW0wcTYwZzF4OExOaHd6cVNrQ0E1eVRUWmdn?=
 =?utf-8?B?VU5MUjRKMDl4dHdSSE1ra3JlWlVYdFlWZWEvQ3ljYnBKVFZoSzRKUE9PVG9l?=
 =?utf-8?B?KzIrVTY3OHpoZThweVIxajgvandIN25sckRqSFBsaXVMZDkzRklXNFl5RUhs?=
 =?utf-8?B?V0xTbEFob1g2d2pYNDgvUW4yZE1henduTnljZWNEdEl1dVB6UUhZbmgya3hi?=
 =?utf-8?B?NFAybEJZWVUrQmRSTFA5bVZBYVhIMVB4aFZEN01vRHo3VFR0dXBTa2FWbnhz?=
 =?utf-8?B?cERlajRPWXR1dFlFU1gvSE1wQWtZTmcxLzR1V2xoTVBRdk5zRit0OWw0THhU?=
 =?utf-8?B?cllBMFRNeFV0YjdObEFRMXptRlowVXpUMk5JK1Vib0ZUejgvVlZYOERWRU9S?=
 =?utf-8?B?QzdnWTZLL0tIQ2ptcTJFTXhaait3UXVJdWVDZ3pTbFV4d0pTdkFHYUpTVVQ2?=
 =?utf-8?B?UkYzUm94V0dIdWFJVmFrN05qSFhFWVZUSVB1SUpaNFQ2a2wzTVlzRDF0OFov?=
 =?utf-8?B?amUzWHRQb2U3dzFFTWF6NFkvQkxpWC9mbVBSa3NLWlh0ZU8xb0VGVGc5cnNB?=
 =?utf-8?B?OTlmQ0pXR21IYnBiUEsvZG9pdkhET2tqTktlREY5QStvaE13UExiMjBGQkhK?=
 =?utf-8?B?NmtuUEhwNUgxRVhzTVFwamIwa2NQZUlERXpWU0hMMm42MWdUbTc4SEZlYjJ2?=
 =?utf-8?Q?OA2WmROJTG3GRjk/oVkl24C5csc2o073n6CqE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34393b56-1fa6-430a-cfc2-08def2a7e07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 04:13:17.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9203

RnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFzd2FyLmhhcmloYXJhbkBsaW51eC5taWNyb3NvZnQu
Y29tPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgNCwgMjAyNiAzOjQ5IFBNDQo+IA0KPiBPbiA4LzQv
MjAyNiAxNTo0NywgRWFzd2FyIEhhcmloYXJhbiB3cm90ZToNCj4gPiBPbiA4LzQvMjAyNiAxNTox
NywgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4+IEZyb206IEVhc3dhciBIYXJpaGFyYW4gPGVh
c3dhci5oYXJpaGFyYW5AbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2RheSwgQXVndXN0
IDQsIDIwMjYgMTI6NDAgUE0NCj4gPj4+DQo+ID4+PiBPbiA4LzQvMjAyNiAxMjowNSwgTWljaGFl
bCBLZWxsZXkgd3JvdGU6DQo+ID4+Pj4gVGhlIFZNQnVzIG1vZHVsZSBzaG91bGQgbm90IGJlIGxv
YWRlZCB3aGVuIExpbnV4IGlzIHJ1bm5pbmcgZGlyZWN0bHkNCj4gPj4+PiBpbiB0aGUgcm9vdCBw
YXJ0aXRpb24gYW5kIHJvb3QgaXMgbm90IG5lc3RlZCBpbiBhbm90aGVyIFZNLiBDdXJyZW50DQo+
ID4+Pj4gY29kZSBjaGVja3MgdGhpcyBjb25kaXRpb24gYW5kIHNraXBzIFZNQnVzIG1vZHVsZSBp
bml0aWFsaXphdGlvbiwgd2hpY2gNCj4gPj4+PiB3b3Jrcy4gQnV0IGl0IHJldHVybnMgMCBhcyB0
aGUgcmVzdWx0LCBzbyBMaW51eCB0aGlua3MgdGhlIG1vZHVsZSBoYXMNCj4gPj4+PiBzdWNjZXNz
ZnVsbHkgbG9hZGVkLiBMYXRlciwgaWYgdGhlIG1vZHVsZSB3ZXJlIHRvIGJlIHVubG9hZGVkLCB0
aGUNCj4gPj4+PiBWTUJ1cyBtb2R1bGUgdW5sb2FkIGNvZGUgdHJpZXMgdG8gY2xlYW4gdXAgdGhp
bmdzIHRoYXQgd2VyZSBuZXZlcg0KPiA+Pj4+IGluaXRpYWxpemVkLCByZXN1bHRpbmcgaW4gbWVt
b3J5IGZhdWx0cyBhbmQgYSBwYW5pYy4NCj4gPj4+Pg0KPiA+Pj4+IEZpeCB0aGlzIGJ5IGhhdmlu
ZyBWTUJ1cyBtb2R1bGUgaW5pdGlhbGl6YXRpb24gcmV0dXJuIC1FTk9ERVYgZm9yIHRoaXMNCj4g
Pj4+PiBjYXNlLiBUaGUgbW9kdWxlIGlzIHRoZW4gbm90IGxvYWRlZCwgYW5kIHRoZSB1bmxvYWQg
cGF0aCBjYW4gbmV2ZXIgcnVuLg0KPiA+Pj4+DQo+ID4+Pj4gUmVwb3J0ZWQtYnk6IFNhc2hpa28g
PHNhc2hpa28tYm90QGtlcm5lbC5vcmc+DQo+ID4+Pj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC0NCj4gPj4+IGh5cGVydi8yMDI2MDcyMTE1NDk0My5BMDlCRDFGMDBBM0RA
c210cC5rZXJuZWwub3JnLw0KPiA+Pj4+IEZpeGVzOiA3ZTI3OWQ3ODY2NGFhICgiRHJpdmVyczog
aHY6IHZtYnVzOiBza2lwIFZNQnVzIGluaXRpYWxpemF0aW9uIGlmIExpbnV4IGlzIHJvb3QiKQ0K
PiA+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNv
bT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgZHJpdmVycy9odi92bWJ1c19kcnYuYyB8IDIgKy0NCj4g
Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+
Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi92bWJ1c19kcnYuYyBiL2RyaXZlcnMv
aHYvdm1idXNfZHJ2LmMNCj4gPj4+PiBpbmRleCBlMTllYzczYjAxODcuLjg0OWQ3ZTFhNzMyMCAx
MDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ID4+Pj4gKysrIGIv
ZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiA+Pj4+IEBAIC0yOTc2LDcgKzI5NzYsNyBAQCBzdGF0
aWMgaW50IF9faW5pdCBodl9hY3BpX2luaXQodm9pZCkNCj4gPj4+PiAgCQlyZXR1cm4gLUVOT0RF
VjsNCj4gPj4+Pg0KPiA+Pj4+ICAJaWYgKGh2X3Jvb3RfcGFydGl0aW9uKCkgJiYgIWh2X25lc3Rl
ZCkNCj4gPj4+PiAtCQlyZXR1cm4gMDsNCj4gPj4+PiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPj4+
Pg0KPiA+Pj4+ICAJLyoNCj4gPj4+PiAgCSAqIEdldCBBQ1BJIHJlc291cmNlcyBmaXJzdC4NCj4g
Pj4+DQo+ID4+PiBUaGlzIHNlZW1zIHN0cmFpZ2h0Zm9yd2FyZDoNCj4gPj4NCj4gPj4gQWxhcywg
aXQncyBub3Qgc28gc3RyYWlnaHRmb3J3YXJkLCBhcyBTYXNoaWtvIHBvaW50ZWQgb3V0LiAgSSBr
bmV3IHRoYXQNCj4gPj4gdGhlIG1zaHYgbW9kdWxlIGhhcyBhIGRlcGVuZGVuY3kgb24gdGhlIHZt
YnVzIG1vZHVsZSwgYnV0IGhhZA0KPiA+PiBmb3Jnb3R0ZW4uIFRoZXJlJ3MgYSByZWFzb24gZm9y
IHRoZSBkZXBlbmRlbmN5IGFzIGRlc2NyaWJlZCBpbiB0aGUNCj4gPj4gY29tbWl0IG1lc3NhZ2Ug
Zm9yIDg0MGI3NDBhMzViZi4NCj4gPj4NCj4gPj4gVGhlcmUncyBhbm90aGVyIGVhc3kgd2F5IHRv
IGZpeCB0aGUgVk1CdXMgbW9kdWxlIHVubG9hZCBwcm9ibGVtLg0KPiA+PiBJJ2xsIHNlbmQgYSB2
Mi4gOi0pDQo+ID4+DQo+ID4+IE1pY2hhZWwNCj4gPj4NCj4gPiBJIG1heSBiZSBtaXNzaW5nIHNv
bWV0aGluZywgYnV0IG1zaHZfcm9vdCBpcyB1c2VkIGluIDMgY2FzZXM6DQo+ID4NCj4gPiAxKSBC
YXJlbWV0YWwgcm9vdCBwYXJ0aXRpb24sIHdoaWNoIHJlcXVpcmVzIG5vIFZNQnVzDQo+ID4NCj4g
PiAyKSBMMVZIIGFrYSBEaXJlY3QgVmlydHVhbGl6YXRpb24sIHdoaWNoIGlzIGNvbmRpdGlvbmVk
IG9uIGh2X2wxdmhfcGFydGl0aW9uKCksIHdoaWNoIGlzDQo+IG5vdCB0aGUgY2hlY2sgaGVyZSBp
biB0aGUgdm1idXMgZHJpdmVyDQo+ID4NCj4gPiAzKSBGb3IgdGhlIE9wZW5IQ0wgcGFyYXZpc29y
LCB3aGVyZSBJIGhvbmVzdGx5IGRvbid0IGtub3cgd2hhdCB0aGUgZGVwZW5kZW5jeQ0KPiBjaGFp
biBsb29rcyBsaWtlLCBidXQgYmFzZWQgb24gYSBxdWljayBnbGFuY2UNCj4gPiBhdCBodHRwczov
L2dpdGh1Yi5jb20vbWljcm9zb2Z0L09IQ0wtTGludXgtS2VybmVsLyBhbmQgYSBjdXJzb3J5IGdy
ZXAsIGRvZXNuJ3QNCj4gc2VlbSB0byByZWx5IG9uIGh2X3Jvb3RfcGFydGl0aW9uKCkgYnV0IGRv
ZXMgcmVseQ0KPiA+IG9uIFZNYnVzLg0KPiA+DQo+ID4gSSBmZWVsIGxpa2UgU2FzaGlrbydzIHJl
dmlldyBmYWxscyBpbnRvIGl0ZW0gMSwgYnV0IHRoZW4gYWdhaW4sIHRoZXJlIG1heSBqdXN0IGJl
IGENCj4gbWlzbWF0Y2gNCj4gPiBiZXR3ZWVuIHJlYWxpdHkgYW5kIG15IG1lbnRhbCBtb2RlbCwg
b3IgbXkgbWVudGFsIG1vZGVsIG1heSBiZWNvcnJlY3QsIGJ1dCB0aGUNCj4gY29kZSBkb2Vzbid0
IG1hdGNoIGl0Lg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEVhc3dhciAoaGUvaGltKQ0KPiANCj4g
DQo+IFdlbGwsIG51bWJlciA0IGlzIGFzIGEgcGFyZW50IG9uIGEgbmVzdGVkIGh5cGVydmlzb3Is
IGJ1dCAhaHZfbmVzdGVkIHRha2VzIGNhcmUgb2YgdGhhdC4NCj4gDQoNCkZvciB5b3VyICMxLCBp
bmRlZWQgdGhlIHJvb3QgcGFydGl0aW9uIGRvZXMgbm90IHJlcXVpcmUgYWN0dWFsIFZNQnVzDQpm
dW5jdGlvbmFsaXR5LiBCdXQgaXQgKmRvZXMqIHJlcXVpcmUgdGhhdCB0aGUgVk1CdXMgbW9kdWxl
IGJlIGxvYWRlZA0KaWYgQ09ORklHX0hZUEVSVl9WTUJVUz15LiBJbiB0aGF0IGNhc2UsIHRoZSBv
bmx5IGZ1bmN0aW9uIHRoZSByb290DQpyZXF1aXJlcyBmb3IgIzEgaXMgdGhlIGZ1bmN0aW9uIGh2
X3ZtYnVzX2V4aXN0cygpLCBhbmQgaXQgcmVxdWlyZXMgdGhhdA0KdG8gZGlzdGluZ3Vpc2ggYmV0
d2VlbiB5b3VyICMxIGFuZCB5b3VyICM0IHdoZW4gaXQgc2V0cyB1cCB0aGUgU3luSUMuDQoNCklm
IHlvdSB3YW50IHRvIGJ1aWxkIGFuIGltYWdlIHRoYXQgb25seSB3b3JrcyBmb3IgIzEsIHRoZW4g
YnVpbGQgd2l0aA0KQ09ORklHX0hZUEVSVl9WTUJVUz1uIGFuZCB0aGVyZSdzIG5vIGlzc3VlLiBC
dXQgaWYgeW91IHdhbnQgYW4NCmltYWdlIHRoYXQgd29ya3MgZm9yICMxIG9yICM0LCBidWlsZCB3
aXRoIENPTkZJR19IWVBFUlZfVk1CVVM9eQ0Kb3IgPW0sIGFuZCB0aGUgVk1CdXMgbW9kdWxlIG11
c3QgbG9hZGVkIHNvIHRoYXQgaHZfdm1idXNfZXhpc3RzKCkNCmdpdmVzIHRoZSByaWdodCBhbnN3
ZXIgKGZhbHNlIGZvciAjMSwgdHJ1ZSBmb3IgIzQpLiBGdXJ0aGVybW9yZSwgdGhlDQptc2h2X3Jv
b3QgZGVwZW5kZW5jeSBvbiB0aGUgVk1CdXMgbW9kdWxlIGVuc3VyZXMgdGhhdCB0aGUNClZNQnVz
IG1vZHVsZSBpcyBhbHdheXMgbG9hZGVkIGJlZm9yZSB0aGUgbXNodl9yb290IG1vZHVsZSBzbw0K
dGhhdCBodl92bWJ1c19leGlzdHMoKSB3aWxsIGdpdmUgYW4gdXAtdG8tZGF0ZSBhbnN3ZXIgd2hl
bg0KbXNodl9yb290IGFza3MuDQoNClRoZSB3YXkgdGhlIFN5bklDIGlzIG1hbmFnZWQgc2hvdWxk
IGJlIHJlZmFjdG9yZWQgdG8gYmV0dGVyDQpoYW5kbGUgIzQsIGFzIEpvcmsgTG9lc2VyIGhhcyBw
cm9wb3NlZC4gSG9wZWZ1bGx5IHN1Y2ggYSByZWZhY3RvcmluZw0Kd291bGQgbWFrZSB0aGUgbXNo
dl9yb290LT52bWJ1cyBkZXBlbmRlbmN5IGdvIGF3YXkuIEJ1dCB1bnRpbA0Kc3VjaCBhIHJlZmFj
dG9yaW5nIGlzIGRvbmUsIHRoZSBkZXBlbmRlbmN5IGlzIHdoYXQgd2UgaGF2ZS4NCg0KSSBhZ3Jl
ZSB0aGF0IHlvdXIgIzIgYW5kICMzIGFyZSBub3QgcmVsZXZhbnQgaGVyZS4NCg0KTWljaGFlbA0K
