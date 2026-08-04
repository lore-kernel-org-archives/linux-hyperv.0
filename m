Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010018.outbound.protection.outlook.com [52.103.20.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B5308F32;
	Tue,  4 Aug 2026 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881867; cv=fail; b=f8Ejb+PHa50ZbpVlwQ+SXss9hyq9AHz/0QPQZo+OinrKwMJt/mxNjkKcqvgW1bag0F0U86t0CHCqRod1lazpMv4nPS47+KKlCPqhfnvRuuitVrrgV3/KjptGIksuuFZUSFKA3Jlqgls6+pZ8BUnKKjR/DS0xAnolmXCrQn0eLgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881867; c=relaxed/simple;
	bh=DAxPxFiu7egSO3cEn/y4hTUDg32mAS9CNRYDqLzi+jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dAXW7tPvXjUhLHjJfkBWBNXcjX7uIo+4zIJxR3B1cDs1Q1F7XAx1M2aTupCm6BvAajoDq/h9OD3Q+G3+od/1fbpoB1UIziyFgA7dsdufinvOsgvtrK1xz81KtyXTPjlPYf3PTx8zvkKnEzN3POaTR5IErqurdP8cCnG+uatiumY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hOwdJoSB; arc=fail smtp.client-ip=52.103.20.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hOwdJoSB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWRv4eW83jV3Nr61Jd5jDuo8GHsj1BraxR8Wr1hVMvaG1wyYz/E3VHU8bvU/2PkCiTDUXn2vXkobpIRkBrKtxVHAa0j0NowY7UP/NLwYYgztdLfXsLM5XYWN9+0kTmtRamNR0TgLPCFAoWMoDfei0nemW2mHeZeOVX3zUqZ/dKOOHtt+n8+z4e3WawsIOiFP0nF5FhVKvciDVGoG1H9AnfzaLvK1XthUeVpMOk1BI2wwkaQMiC2tiGrQNpKlYlTX9cC7c6wzZQ8oQ7el1fiVyM+qTzrK203Pj0wTjcuwl5Ckmz27IBg5B56y6mW8S1PCHygrdFYVG4HmXPbae3tOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAxPxFiu7egSO3cEn/y4hTUDg32mAS9CNRYDqLzi+jw=;
 b=Og4o7A8b4JFOh7EcngqqsnaHGmQ2CKKOcuAYfIimY3TZrQNhgNmVSvjXyIL5OdfJvM0jJQ8kSsHB2GtOLf0Ekvj2jtnvO5qmlPBz6EcdYwghJCplmvGQ7e4vghfTW9A/aALjcMon69d/zdyZ++jpiNODOb1FFKQ/z6o9SOUy8eBRbj/oL1I8r8TTGFuxK0t7P9BhPzHy93p4j1DVa9ogtRoB/uN0UNj6zHvCTiEwFgmPSoEkrGSbOSbjdNugRHIK1yWoVgWPqdDu5+Ks5Vrckp3BgQy+LbGZkas267nTuXyTPqQdV7BkRrtBblS33rUn6PMWlg1VIgSREshRwPoj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAxPxFiu7egSO3cEn/y4hTUDg32mAS9CNRYDqLzi+jw=;
 b=hOwdJoSBwkR3QYNoJ4gHy9NLEs4F3PTPqxf/3fkNoKMg/RWwfMWPuCegtZLYoTxgwohsN4V7BpONEB3tSckxsBnF9sHImLb773U2k6ApowzWT78byt6n3bM4dYZ+RahLcZbq5HgBTBGam8qZSuJ1FRaZ9q3JXrSZjrDGnDurxqwxdkmXLt9WKjpDnOzqCuvuVeNg+7ZTRVPvpis5rTtpNOYAMIwAsNtN89dKsQX35RHBp35xhmcn4pu2dIv2rictFfZFHSioEYbe2ky+NFHEjEDylo+KFEmNVAOBDS3MDNNg56A3PVfd005534e1pOHc+T9shOPKP013NdPXPiYTEg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH8PR02MB11473.namprd02.prod.outlook.com (2603:10b6:510:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 22:17:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 22:17:42 +0000
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
Thread-Index: AQIocF+/o929maeNmNdFaBWtVJKlPrX3sUUAgAAsGvA=
Date: Tue, 4 Aug 2026 22:17:42 +0000
Message-ID:
 <SN6PR02MB415758E1637A763B06911B8AD4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260804190517.101981-1-mhklinux@outlook.com>
 <ea0d31c0-5559-462c-b6d3-1ed6c01a9074@linux.microsoft.com>
In-Reply-To: <ea0d31c0-5559-462c-b6d3-1ed6c01a9074@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH8PR02MB11473:EE_
x-ms-office365-filtering-correlation-id: e1494092-5f66-4c44-8770-08def2763407
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|31061999003|41001999006|13091999003|25010399006|55001999006|15080799012|37011999003|51005399006|8062599012|8060799015|19110799012|440099028|3412199025|4302099013|102099032|40105399003|10035399007|2607281247196008|1602099012|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2pmd0RIcVo3TFdLaWhYTFQ2emRjR3FoWTBoWWFWKy9Fb2J0ODRUSnFjMnAy?=
 =?utf-8?B?eXBzVitBaU03Mll4Z0JLT2Y5bWZJTHVmYnM5cE1GNGtid2tnYXVIR0VjcEVU?=
 =?utf-8?B?QmJlUW5Id3N4SGQ5SHY0T1pOUVNEc05jWklQSW5NN1pubjl6VjM2T1BZUjVI?=
 =?utf-8?B?M3hCSXVJK0JiQzE2VHQ2M3dVZ01sRmE5di8zWE5pck1JbzR0V2h0MElIcGRK?=
 =?utf-8?B?Z3ViOE80RXpEM3RDZVpCVElsbWZzZ1c1VTZ6NXpsdXNrZkpHaXY5WlNaWDBS?=
 =?utf-8?B?VGw3SFlXSk1yTzVFNFJ6NmhYM0JocGxVM2NXVjlpbEpydzVENFFZMk9SbTdr?=
 =?utf-8?B?VXFpQkxOT2JMRUJQVTl0K3IyTjc5UFhiZWNZTWw1T3F1Q3F2dG9ObG02TkVE?=
 =?utf-8?B?NUUwb05HSUFRTVFkbCtCOWpVZ05xWkMrMXM3aWtmUldFc0I5UW1hRndiWk56?=
 =?utf-8?B?SnB2ZFVuYXJWZFFtbW9NcFVHWk41N3p2bzlhYk9DcW00VFZONDYwSzcxREtD?=
 =?utf-8?B?WXc1QlYzNkRIdk01RTZob3BzK1BidXI5aUVtNEV1Q3VVSHBrZVFyQU5meWRU?=
 =?utf-8?B?QXZxM3FKb1NrUkVvR0VJeFN0QU5XMk1rT2c1RGkyUjBRSmJGMlZOK3UxYnAx?=
 =?utf-8?B?ZEtNdGdMajA3NzM5ZXV3QmRrTmZkT0JzdHd2ejJ0ODMzNUtvZGlmM3VtRy9r?=
 =?utf-8?B?c0FTNlZnV21YZkhKemg3ZStRQmJrcDYzWXBqUkdXL3hlYlBLaWRJOXZvdlRr?=
 =?utf-8?B?Y0ozcW81NGV3VG5wV2pITkZKam55ZGY2SXhXQkY4cG8yTUNPZytSZ3F2MDJ1?=
 =?utf-8?B?Nnd3SUpTcFEvRGFNUU5vS1ZZREFGNk1wL0wyMjAvanFhVEpnVW1najNkc1Mw?=
 =?utf-8?B?MXlGREd0Y1NBTlQxeURzSkRFNjRSWnVMTmFlL2JZR05YTVhPQ2VQOWRETkUw?=
 =?utf-8?B?MW41bWtuaUtRMmdlalBJN1hJOWdZWThkbjdra2c5c3ZCb0xvajRzMnp0bHdX?=
 =?utf-8?B?YUM4dldXWHVWNkpYdlhmSk9taWpBUVdDZVkvM1VtajA4WUpya3V4OEZVZi8z?=
 =?utf-8?B?c2EzeFVlRWNNcTY4ckRwU2RlK0d0elR0dXd0UXRLMjdkMHk3Z1hkMHBYUFJq?=
 =?utf-8?B?TkJZWEYwTVVxWnpRTjYzR1JVaTlXTE1JODNPeGlRQkpHTThJMjByQTJia2hD?=
 =?utf-8?B?MWd0aFA2TkxOTk84ZUhhaUwyLy9halRkU05ML3I3R09leGxJbzdRaWdVaVRX?=
 =?utf-8?B?bjBOM3I0QU5ma3JnZzNTQm84WGl0c0pKWmNJZFNxMFFrd2FlR1pUazUyS0Rw?=
 =?utf-8?B?ZEhoMUc0Vyt1bEdVYnRsS0Z2QmNwSTRTRk1TNGtqaTdWNCttRXRhdjBsRkl2?=
 =?utf-8?B?RjJ6bmVvd0U0TGREUlpLSnBlOEZDS3NIbFJiZVZoL1BhN1QwNEViWjRBVUlu?=
 =?utf-8?B?WEZGZjNrUTNIeTNzR0JZL1ZKcHd5U3FNVklKVVVnbXhqdkQ5NlRrOGJSa29j?=
 =?utf-8?B?eVA0ZEwzMEV5TnU1ek4wUW95cmxTWm85dkxIdUtVQWgyUS9HajY2TXlRNnZk?=
 =?utf-8?Q?yZxqwpfniZn0tgQV+7xb2hyLdhfoq1FG4uySkYgwzx2N/T?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTdzcnpSZ3BTRW1BZ2ZRS3RMbnUycjJNWVF0anpyRkpNNlhBQnRKY3FGQmVn?=
 =?utf-8?B?SnJWZU40TzhPNW4xazRjK1oyNUgvampUbWhMMjFaTUdpOGZXd0xNWkhxVFhj?=
 =?utf-8?B?Y29SZ3N0eHk2UGVKNDJLMSt5alZVSlRVcHIvUlJ4SHdwQ3g1a3dRU3k4anZP?=
 =?utf-8?B?YnpqdHBhWVNvQUEwM2VXV081UkxuVzRGdmdZamFzaFVRYnIxaFZSczVrTkxv?=
 =?utf-8?B?TGt1Z3ZtQkEvNUFIcyt3T3RCYWFUME9paTVGYjh1Qk9EaVVudVdLOTJBMncv?=
 =?utf-8?B?emgvcjhhUTk0eXpRclhQbWFSbWJ1K0NQVDZIejZzbktNQWZDMVN3ZzltUVpC?=
 =?utf-8?B?TlpaV1Z2ZkU4VzlmcHVwVVhuMHZOdWo1eEZmcEJQTEs5OE1iUGxBcDF3SHE5?=
 =?utf-8?B?SWtaYk9RMHNOYWMxYUVnVGhJOEpkdVJCWE1XVk1EOHljNTBwTmIvVVEvL2Fz?=
 =?utf-8?B?azAzNXVTWklPTXFmd1ZocFErREpGOUZucy9XOFRUL0RPUmhUVFNQU05UQzNl?=
 =?utf-8?B?aGVjNEMyQ210WjZyV1BPT292d3BzOExGMWo2TEJUNHErMmYvYzVaSDBXU3Fh?=
 =?utf-8?B?czd4VVNWektpOTZUM2VTeU0reTdsTzhTTkoydlZ4RjhmU3hoL3k2U0Y1TDJk?=
 =?utf-8?B?Qm9DVWRJbVIzajhWZlBIRVhxNnVITThjR2FwRjRCWE1tY1BqL20xVkxJd0VF?=
 =?utf-8?B?VnE5bStCRlBRaEdjdzNCaVpOL1BMUHJkMjlwSWpoejArQmNMbk9va0I5QnlX?=
 =?utf-8?B?aXczTGh0djBtQlRrYUFLWlMxRUs1UzkrdFI5cGhacW1aMHhrZmwrQnE2WXRi?=
 =?utf-8?B?L2tsRU9lSWRsb0JYbDRVdG1wLzd4TkU0cFptK2tQenhEaWk4bC9pV1Z1NVhv?=
 =?utf-8?B?TjNHNDlvaE15dnFDc0dJUkw4aFVic2ptWmtaQnBncXdXN3ZraEF1STkzTHdh?=
 =?utf-8?B?N2ZEbjFRcDB1WVNJL1VFL0N4RXdOZGFya0l6RFdZMkJ5S0tBOGJLUEhhRXJH?=
 =?utf-8?B?Z0IvMWwwNWtDa2YwcEJ3OW5RdTBjaTdzYk0vN3llYmNsMGVHNmpCelVTQUtU?=
 =?utf-8?B?Yi8vcDVRSE5YYTlqQlNQOWthaGRWRXJJTEdFMTI0bFcxRGZyUERuVDNJRkJ3?=
 =?utf-8?B?bkZ0SDB2cWp6QldlVlZoZGgyR0V6R0N3eWZtdjdVaSs3c1dQL2tFK1VacGQy?=
 =?utf-8?B?a0VoamhITFBsZHZjNlRMaWhFVzNGL0hZbGtCYnB4cWZSb2RBNG1KN0NnN1pP?=
 =?utf-8?B?TVdoQ3l3M0I4WkZqWStTb3ZkQmRmQnJhODU3NmtPcVRNdWFpcEJycXB0eEJa?=
 =?utf-8?B?dXlQaFlWOGY2Z3dSb0ZDaGVVMnBxZGptYlpqdUpNZ0o0d1IybmVqVjIrbEtE?=
 =?utf-8?B?ZWUzZERmQ1RET0UxckhhdDc0VUE4cTVEYzE0TElJanIvSmxuSGt2eVdrRGNG?=
 =?utf-8?B?YmtwUytwTnROL0pqNy8vWTNhWWtxU0hZQjErc1Y1ME5EV3pvOE5YK0NVSW5j?=
 =?utf-8?B?eTN0NThBRU13dmZIUGpMb2hKbE1yTytKWEFhcTB2QXlNbnZ1a3d0WjJrZEhz?=
 =?utf-8?B?V1BPRytNbXRBSnVjMFFaQlVBcEhvbTd1RlZMaUxFQWM5RzY5bE5vRWVMaUhJ?=
 =?utf-8?B?R3JRcDQrU1VyTCtWNW05WmJpaTVHMnZMUzk2SEx4aFlrUU80WUxLTVY4bUtm?=
 =?utf-8?B?bDcvUUU0QzBpWm1MU05SNnlTR0xtNm84TGc4YzFOQWhON1FLSFEzQ1M0R1hR?=
 =?utf-8?B?dzNNczlDSmpmK3U3YWRUYWYwTzN3a0xmaG0ySDFlNU5mQTQ2VmtrQkNaMjVF?=
 =?utf-8?Q?mHNjlM/1+PUNd0nzb4XWiUi7+jn1e/y0xCOic=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1494092-5f66-4c44-8770-08def2763407
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 22:17:42.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11473

RnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFzd2FyLmhhcmloYXJhbkBsaW51eC5taWNyb3NvZnQu
Y29tPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgNCwgMjAyNiAxMjo0MCBQTQ0KPiANCj4gT24gOC80
LzIwMjYgMTI6MDUsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IFRoZSBWTUJ1cyBtb2R1bGUg
c2hvdWxkIG5vdCBiZSBsb2FkZWQgd2hlbiBMaW51eCBpcyBydW5uaW5nIGRpcmVjdGx5DQo+ID4g
aW4gdGhlIHJvb3QgcGFydGl0aW9uIGFuZCByb290IGlzIG5vdCBuZXN0ZWQgaW4gYW5vdGhlciBW
TS4gQ3VycmVudA0KPiA+IGNvZGUgY2hlY2tzIHRoaXMgY29uZGl0aW9uIGFuZCBza2lwcyBWTUJ1
cyBtb2R1bGUgaW5pdGlhbGl6YXRpb24sIHdoaWNoDQo+ID4gd29ya3MuIEJ1dCBpdCByZXR1cm5z
IDAgYXMgdGhlIHJlc3VsdCwgc28gTGludXggdGhpbmtzIHRoZSBtb2R1bGUgaGFzDQo+ID4gc3Vj
Y2Vzc2Z1bGx5IGxvYWRlZC4gTGF0ZXIsIGlmIHRoZSBtb2R1bGUgd2VyZSB0byBiZSB1bmxvYWRl
ZCwgdGhlDQo+ID4gVk1CdXMgbW9kdWxlIHVubG9hZCBjb2RlIHRyaWVzIHRvIGNsZWFuIHVwIHRo
aW5ncyB0aGF0IHdlcmUgbmV2ZXINCj4gPiBpbml0aWFsaXplZCwgcmVzdWx0aW5nIGluIG1lbW9y
eSBmYXVsdHMgYW5kIGEgcGFuaWMuDQo+ID4NCj4gPiBGaXggdGhpcyBieSBoYXZpbmcgVk1CdXMg
bW9kdWxlIGluaXRpYWxpemF0aW9uIHJldHVybiAtRU5PREVWIGZvciB0aGlzDQo+ID4gY2FzZS4g
VGhlIG1vZHVsZSBpcyB0aGVuIG5vdCBsb2FkZWQsIGFuZCB0aGUgdW5sb2FkIHBhdGggY2FuIG5l
dmVyIHJ1bi4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBTYXNoaWtvIDxzYXNoaWtvLWJvdEBrZXJu
ZWwub3JnPg0KPiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+IGh5
cGVydi8yMDI2MDcyMTE1NDk0My5BMDlCRDFGMDBBM0RAc210cC5rZXJuZWwub3JnLw0KPiA+IEZp
eGVzOiA3ZTI3OWQ3ODY2NGFhICgiRHJpdmVyczogaHY6IHZtYnVzOiBza2lwIFZNQnVzIGluaXRp
YWxpemF0aW9uIGlmIExpbnV4IGlzIHJvb3QiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwg
S2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9odi92
bWJ1c19kcnYuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi92bWJ1c19kcnYu
YyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gPiBpbmRleCBlMTllYzczYjAxODcuLjg0OWQ3
ZTFhNzMyMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ID4gKysr
IGIvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiA+IEBAIC0yOTc2LDcgKzI5NzYsNyBAQCBzdGF0
aWMgaW50IF9faW5pdCBodl9hY3BpX2luaXQodm9pZCkNCj4gPiAgCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gPg0KPiA+ICAJaWYgKGh2X3Jvb3RfcGFydGl0aW9uKCkgJiYgIWh2X25lc3RlZCkNCj4gPiAt
CQlyZXR1cm4gMDsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPg0KPiA+ICAJLyoNCj4gPiAg
CSAqIEdldCBBQ1BJIHJlc291cmNlcyBmaXJzdC4NCj4gDQo+IFRoaXMgc2VlbXMgc3RyYWlnaHRm
b3J3YXJkOg0KDQpBbGFzLCBpdCdzIG5vdCBzbyBzdHJhaWdodGZvcndhcmQsIGFzIFNhc2hpa28g
cG9pbnRlZCBvdXQuICBJIGtuZXcgdGhhdA0KdGhlIG1zaHYgbW9kdWxlIGhhcyBhIGRlcGVuZGVu
Y3kgb24gdGhlIHZtYnVzIG1vZHVsZSwgYnV0IGhhZA0KZm9yZ290dGVuLiBUaGVyZSdzIGEgcmVh
c29uIGZvciB0aGUgZGVwZW5kZW5jeSBhcyBkZXNjcmliZWQgaW4gdGhlDQpjb21taXQgbWVzc2Fn
ZSBmb3IgODQwYjc0MGEzNWJmLg0KDQpUaGVyZSdzIGFub3RoZXIgZWFzeSB3YXkgdG8gZml4IHRo
ZSBWTUJ1cyBtb2R1bGUgdW5sb2FkIHByb2JsZW0uDQpJJ2xsIHNlbmQgYSB2Mi4gOi0pDQoNCk1p
Y2hhZWwNCg0KPiANCj4gDQo+IFJldmlld2VkLWJ5OiBFYXN3YXIgSGFyaWhhcmFuIDxlYXN3YXIu
aGFyaWhhcmFuQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQoNCg==
