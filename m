Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010018.outbound.protection.outlook.com [52.103.2.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD573F105B;
	Sun, 30 Aug 2026 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131867; cv=fail; b=BX+OvNEZpA2EUzBX0K0mzZwqkjLkyHxY8YsyR3I0pDoYImUEu01bNZDrqf4ItwVLO706vm1sNRRlJ7tS0w5WivxL+KOhy1r2WYp6AeM5+Rep3dah+gZsX63XlU8Kf+esmhVn8txOZcLTyJSZ1VS0npeaBhk/Ui910h2TWl7uBzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131867; c=relaxed/simple;
	bh=ohvzuMiB/q9G0S7I0dp1nvVtzOYtdHS0zImzSWHmJ/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzsJGf1rCMKy86mt+QbxO/xzqKw4tNrpm3GSQGMin3Wh9MKHoI36GmYstLBIqQ8vnez/z9yHem/kWmFfi+A0qafmLdzSM6t5A6U5iE7NyphrzmQjaGv0XxMv+6DKLaz2lV3FA7nFw1Q0iW7eqoPZ2cKG1shuYppiqFOmdORXEzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rruNuWu4; arc=fail smtp.client-ip=52.103.2.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rruNuWu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ27DtOOTJE8vIws+E88G43rt9PxpGP/qss4QjLt04zby6hLgd0T/x656zLdQHcbb1haIBAou9A7dbUSdCJSLwhL/bkHsp1H25nrskjdnM1e/7KNHSG4cy199bdfAhQRyF7vB2975/mvl9OTLpR6LZ9pt8T9p/1HwczusfkXxteuW4ConDmJfJrXq14yxeZzKZnUSZIeJVryrQQBfw4FKf/W2/PJIZFqvUBtURCo91VBZadDkHAkzAoIoxblxJDdmbk8JYaapjr23jZU4IjK5NULMytipPdz2TeanXKk/2bSdbEKQrFBDLh3lN1DZjfYAzCn7xrxzhmFuFpfDfHJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohvzuMiB/q9G0S7I0dp1nvVtzOYtdHS0zImzSWHmJ/4=;
 b=QEKiKRVziz4h3qAvABSgoBnznFckemTSfiQfl4+djMJzufXuBCbh8Qj/q7u8fUxwTzClCOmXd2gY5OcGzwkSefNV88JrCwg/Ro7CPkryeK8vDEPm96R7OuJfWm+kaHqnoEMuQhavmTtrUuyxwnLWSIPHN5c9G9jAvkDZ6mbbQvYeb55+lVrXTv9hjIkIDoIO6fgQEJNsnNB0kCDza6qBReDOunZAKxSqJwfSVqyVCoMBTlEv+y3LGw+ond+oW+ZWClX99LYDoDmOgPSU0e3AfKz76Q2s/N1aNpx1zDG1i50nJke144ZV17ngaF6hwAizULDTOWMYARf5/IbD0D+Wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohvzuMiB/q9G0S7I0dp1nvVtzOYtdHS0zImzSWHmJ/4=;
 b=rruNuWu4e4cbA9uefai0kOULAuiZEapqCVnbgWUWR/of/rNMFz3VNnXFt5nngPA7pinaME+/0jotOzj/3AVjEmhbt6m4Balgwwzh4A6G15/jXWnGpEwVn99Ep/xVs2KbB6DsRYtihZ5vtXw5V7k0qKp4nYCsER2cH0hDQrIqBIiAacff4zhjaGrisHY1Y7qTHznlxkS2qMaaQaF9J6wzNQLAK9ckxKw8Wieia8BUInd3hrY0Oqd55hdZAmZSCIHS9W7fiHlzNR0T0dO/spXZ0RbyRJCm0cabs2wih/dHca62bdp1fjJSghsM1mYo0kHCzJ+EnNUTpYKd+7+lnsUgHQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7999.namprd02.prod.outlook.com (2603:10b6:408:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:17:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 23:17:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Waiman Long <longman@redhat.com>, Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Topic: [PATCH v3] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Index: AQJq8gdS5UNdHvCBWIBChMZYcTVn1LWW38zQgAHlm4CAAwIJMA==
Date: Sun, 30 Aug 2026 23:17:43 +0000
Message-ID:
 <SN6PR02MB4157019C1A3D1233CAFAC2D0D4AA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260827193750.662623-1-longman@redhat.com>
 <SN6PR02MB415755118796082D643126ACD4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aaf4826e-6b25-45ff-8aec-8cfeae3b4fd5@redhat.com>
In-Reply-To: <aaf4826e-6b25-45ff-8aec-8cfeae3b4fd5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7999:EE_
x-ms-office365-filtering-correlation-id: e5301c89-9403-447d-e23d-08df06ece557
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|24021099003|31061999003|13091999003|15080799012|8022599003|8060799015|37011999003|12121999013|8062599012|19110799012|25010399006|1602099012|10035399007|1141799003|2607281247196008|3071699003|102099032|3412199025|4302099013|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEVDZndHN0hwYzhZZXpFTGJKVU1RSDMwSkhyU1hLcHFBb2JSdlFuV3YyZ2JR?=
 =?utf-8?B?ajJyOXRTaVBhRHF3WTZjSlVIT2RCSzRzc042VGhvNGlKUW5HenA1QlNDWmJB?=
 =?utf-8?B?OFNEYTJqeHZNK0s2Ym1nU3hlcHhpQk1iYlliZC9sWU5nWEwvUFZWRW9JZXFa?=
 =?utf-8?B?WWNPU0JkNlZ3UzVkclVsczlJWjZlZ0pQRUlhanBKTGVRRkhwa25oTW43a3VC?=
 =?utf-8?B?cUsxOTFFbEZhR1RYSm53a0NnaTI0RFVOU3g5c3JBaGdhZWtMWDFEUUhOVzJ5?=
 =?utf-8?B?bG5TbVl4ZWRmYTRyd3ZyOElPRDdlQmV6aHR1VUM1QjVySFlSMkNrOEViY21K?=
 =?utf-8?B?aERMODJYN25iK3d3R1BENVh5TUZqT2hMNE5iam1malVXK281TUYvQXZPeWh0?=
 =?utf-8?B?L1RQam1Ba1JCbGpKQlpUMThLUEJHOWY3ZGNkVGo1b2xGVGFVd2FGOUdhUldp?=
 =?utf-8?B?Y1ZwaCtRaE5iN3hhUk9jSkFUTTdBZEVOWWFWSlJIOU0rc3FqbkVVRkZUY1NQ?=
 =?utf-8?B?cmZ6WGcvRDI3UEVyQytuSXI5QWtldHo0U1FrUDRyR1hueWNJMmFnVW51aitO?=
 =?utf-8?B?a3lhcXdzcndpUU5sbUFXS21Bc1dDMGRYUXM3UG1JcVUzeE50K0RDbGxKVm9v?=
 =?utf-8?B?b1J0NGIrOE5hMmlFMnZ0WllUQkZBOG9jQUNnaVA2eGtVUERWakI2VUR2WW9O?=
 =?utf-8?B?TEFwSHFFUG5QRjEwMk9NZlpCeTN1bExuR0xCWHlVTzBQYTN6VmRWTUtjTzVa?=
 =?utf-8?B?OGo0OTVJcTZrZ3NCWTNwSVBabWJSanJ0K1Fhc1hKTTkxdjByUW5mNHRjeVRO?=
 =?utf-8?B?V05nZVV6TXpUeTVydm5oM3lnRmNFTDRzN2RHQkJ5aXc2YjhQUkdLMVhyRGRs?=
 =?utf-8?B?ek9SczJjRjRYZEdmSnJxOUNNQkhCNHFWcC9wTHlwVko1TDJ5a3d4MnNrVEdT?=
 =?utf-8?B?N05SRHVrMGNxdTJQSS9NVStkeTFQeGd3eThWMkkrU1B1K1gvK3FVcnQ0QmV4?=
 =?utf-8?B?enNWckNaUWFNY2JWZlJHdmd1dWo3SldpQ3VBYUZvLzAwbktHS2NaWnJiaDZz?=
 =?utf-8?B?VHQxeVc1ZzNmTU9tK1lOQ3F0MXFZZE9nMHcrTlpzdWNtem5WbGFsbU9UUmpF?=
 =?utf-8?B?K1dML2JBeWtpZlY5bENaeHllaGU3enBnU3A1dWo4NXdIbFVQRkw2TDI2VnRH?=
 =?utf-8?B?bGhDc28veWZiR0ppd09kTWhQd2UrK3BPZ2FVUEtETzNNYkNORVBjaWEvZi9D?=
 =?utf-8?B?YlhaZjlXM1VrRXdleFR6cm5ablRrTUFTWm5LUUZESVhJZ21USjFvNGVpV29N?=
 =?utf-8?B?TFBySzExS2oreXY4U2xoWGlHTFpETnVlTlR4dWszR1pmeWRGL2E0RlZKM1dl?=
 =?utf-8?B?d2JwM2orQkozR2t6dUZCVmdyZkc5UG85STZnN25sT3FoRll0ZFp3SmRpMGxU?=
 =?utf-8?B?K0dabmxJeHNmdjBYQkFjdiswYjFBR29BZ1UvMzQ3cVZxSWkrMytPeGx3dmNX?=
 =?utf-8?B?eFZKTjBKL3dzSmJlTDdYaWxjR3lTNUNFOFlzMnRxbzhiMEFKamJMcDV1RSs3?=
 =?utf-8?B?SjhSQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3ZmWmxsL0xzSzY0OXFOSEJLL0g0RWIxVVhnYk5iZnFMT2svalp1U1JQY0pK?=
 =?utf-8?B?em1EdVJpWGNvd0dMNXRFWTN4U3AwMnh1Y0FYY29uUWlTelRXWFlpbUdZR1Rw?=
 =?utf-8?B?dGhWd25sZWpJdnpUdGdEQ0VRdDhia3ZWdElHblNIVnI3RVQ5NVZaa3VKMnhR?=
 =?utf-8?B?d1UrcllEOHF6SHFVN1hBWVFycEtGY2RwQk96b0R3M2JVdlkzanJNNlE5NjZ3?=
 =?utf-8?B?TjdsN29VcW1BVk0rRHFobm9KS1hKTzBTSGNUTFo4UWRwWmFrNmYvTmlLVzhn?=
 =?utf-8?B?TS9qUGVJUmkxL052SUR0S2R2ejVQaGtvN0RWeEJBNjlLY0lsWG9IRnFvK0NC?=
 =?utf-8?B?b2JOZWFybzhONDA2Q293RjdXMlQwanBMdlJvU2FrY3dJeC9CbEdHNGpPTld4?=
 =?utf-8?B?eENQYVJrdVpxMFhQNW8wL3l0d08vVUYreStJVFF1L0pSVTlpcnJLN1FWVVVI?=
 =?utf-8?B?c3VtT3R3KytrbWZIRmVTL1JYblVDYmo1dENhUEdlVGF1aVBJdWFSTUxsVXlM?=
 =?utf-8?B?dFR0L1YvOHhGWmMxd1BPNWJDOWUxVVFCNXJZOEF5ZzR6d1BZdmN2K0RMYXg2?=
 =?utf-8?B?THU4RkNBM3JNZGlML0laWFJCcVpvMWJGTU0yN2o5c0pnalhXZUY5TVNtWFRa?=
 =?utf-8?B?Y0RQeHY1anFxOTRua01qMEhiM0RkMTNjbXVjUVgzKzJVOVpGd0kwQjdaTkxG?=
 =?utf-8?B?ck91Q3RXRU5RU2N5NGIyQWpyb09ZdjFVNjNiRVU5WnhlWnBYUUJ5YWorWDlZ?=
 =?utf-8?B?SkY0TjMrRHJxd2tqdnZ6ZXNwZ2pFNDltSzF2SHQzQUVLd3V4bm1ETURSdGJq?=
 =?utf-8?B?RWNKa3dGc1lIZ0dKbzl0L0R2VDJaMk55NzRpTFFhTG5YUFl4ZjllYnlRZlFC?=
 =?utf-8?B?WlBwa2hsVW1ZekdhSTlBb0ppNi9DejA5MXRlV3FSeDhyWDRqWi9tb2pNbCtl?=
 =?utf-8?B?Y3RtMWFlZ1pXbVM2cHJlVUF0M3VaTjlSQkFPUlUrM2NuR3FTcFRGN1c1TTZw?=
 =?utf-8?B?ZG5BS3NuUkdRczIyYWt2ZSt6RWtvdFJqaG16L2ZtSG5Xb3dQRDJXUTBkd3RH?=
 =?utf-8?B?ZDFRaWRZeXd0RXdDaDFjYW1FMWxtbUlMS1ZMaFpuZEQ3QStITHBDSDRGaWVx?=
 =?utf-8?B?aHVLcGNvY2ZFM2l5andmSUVpL0lZcExPaWJEK3d4VkREckI2SXpNT1JGOEFU?=
 =?utf-8?B?TCt3MWlXNXduaHYxd2V0WFlUS0ZMWllHYzNBWExRcWRCeVVvRG1oTzlyZklB?=
 =?utf-8?B?RE51MjRTM1h5VitjTVRYaGxGUmcrQVllSlQ0dmx3bk1XZUJJeld5K0F2b1p1?=
 =?utf-8?B?QTNpUnUyNDJRMUtRMHBZUHpzb0VnZDZYMXVQbXhBdCsxajh5YzdNYk9mbWVr?=
 =?utf-8?B?UldoYm5XZ0RTYXlGeDhYZFZaL09nSXppVEJtclh5WnVzRGhHRjByMW95T1FM?=
 =?utf-8?B?cFlXbWNvMzFkRkZiOEVPWEUvd1c4NWV1N2ZFcmdvdWlLQXBLQ1psU1JDQ2Jy?=
 =?utf-8?B?SHRZU3g4dmd3T3gzVlBsSmliSkRBNWlpalJMd3E3TURHdmtTbzVpRS9QcnJl?=
 =?utf-8?B?bFY0YjFFREtOQjdjUytzN2ZJdFhJK2FrUXh1MnBzWVVRV2dxdTVHS1RqS1dx?=
 =?utf-8?B?VGJrdnFGdlcrSEhZblZZOUhZZ0tVOUU1TkRNVDFVdklKV084b2ZOek1HMFhU?=
 =?utf-8?B?bUk2eTlEeHVOUkhJWHdHeGZacStZL3duOWdpRWZiSWJkYjZTS0tpRWh5dXY2?=
 =?utf-8?B?Q1M4SXhJNDQ5MzNJNnFUMG9GbjNhSzVNWXRDcEFMZUd0citrVU03bXUwRXAz?=
 =?utf-8?Q?C26ZRFKdxiR2VkVa9e+jOVLo1wqWoQZwBoU54=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5301c89-9403-447d-e23d-08df06ece557
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2026 23:17:43.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7999

RnJvbTogV2FpbWFuIExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4gU2VudDogRnJpZGF5LCBBdWd1
c3QgMjgsIDIwMjYgNjoyMiBQTQ0KPiANCj4gT24gOC8yNy8yNiA1OjEwIFBNLCBNaWNoYWVsIEtl
bGxleSB3cm90ZToNCj4gPiBGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPiBT
ZW50OiBUaHVyc2RheSwgQXVndXN0IDI3LCAyMDI2IDEyOjM4IFBNDQo+ID4+IFRoZXJlIGlzIGEg
cmV0cnkgbG9vcCBpbiBpbml0X3ZwX2luZGV4KCkgd2hlcmUgdGhlIENQVXMgZnJvbSBhIGNlcnRh
aW4NCj4gPj4gbm9kZSBhcmUgc3RyaXBwZWQgb3V0IGlmIHRoZXkgaGF2ZSBhbHJlYWR5IGJlZW4g
aW4gdGhlIGFsbG9jYXRlZCBjcHVtYXNrDQo+ID4+IG9yIG5vdCBpbiBIS19UWVBFX01BTkFHRURf
SVJRIGhvdXNla2VlcGluZyBjcHVtYXNrLiBJZiB0aGVyZSBpcyBubw0KPiA+PiBDUFUgbGVmdCwg
dGhlIGFsbG9jYXRlZCBjcHVtYXNrIGlzIGlnbm9yZWQgYW5kIHRoZSBwcm9jZXNzIGlzIHJldHJp
ZWQNCj4gPj4gYWdhaW4uIEhvd2V2ZXIsIGlmIHRoZSBIS19UWVBFX01BTkFHRURfSVJRIGhvdXNl
a2VlcGluZyBjcHVtYXNrIHR1cm5zDQo+ID4+IG91dCBub3QgdG8gY29udGFpbiBhbnkgQ1BVIGlu
IHRoYXQgcGFydGljdWxhciBub2RlLCB0aGF0IHdpbGwgYmVjb21lIGFuDQo+ID4+IGluZmluaXRl
IHJldHJ5IGxvb3AuICBUaGlzIHBhcnRpY3VsYXIgcHJvYmxlbSB3YXMgcmVwb3J0ZWQgYnkgc2Fz
aGlrbw0KPiA+PiBbMV0uIFRoaXMgc2hvdWxkIHJhcmVseSBoYXBwZW4sIGJ1dCB3ZSBzdGlsbCBu
ZWVkIHRvIGd1YXJkIGFnYWluc3QgdGhpcy4NCj4gPj4NCj4gPj4gRml4IHRoaXMgaW5maW5pdGUg
bG9vcCBwcm9ibGVtIGJ5IGFsc28gc2tpcHBpbmcgTlVNQSBub2RlIHRoYXQgaGFzIG5vDQo+ID4+
IGhvdXNla2VlcGluZyBDUFUgaW4gdGhlIGlubmVyIHdoaWxlIGxvb3Agb2YgaW5pdF92cF9pbmRl
eCgpLiBBcyB0aGUgb3V0ZXINCj4gPj4gZm9yIGxvb3Agd2lsbCBvbmx5IGJlIHJlYWNoZWQgaWYg
dGhlIGhvdXNla2VlcGluZyBjcHVtYXNrIGlzbid0IGVtcHR5LA0KPiA+PiBhIE5VTUEgbm9kZSB3
aXRoIGhvdXNla2VlcGluZyBDUFVzIHdpbGwgZXZlbnR1YWxseSBiZSBmb3VuZC4NCj4gPj4NCj4g
Pj4gTGluazogaHR0cHM6Ly9zYXNoaWtvLmRldi8jL21lc3NhZ2UvMjAyNjA0MjIwMzA5MDMuRTFC
RkNDMkJDQjAlNDBzbXRwLmtlcm5lbC5vcmcgWzFdDQo+ID4+IEZpeGVzOiA2NjQwYjVkZjFhMzgg
KCJEcml2ZXJzOiBodjogdm1idXM6IERvbid0IGFzc2lnbiBWTWJ1cyBjaGFubmVsIGludGVycnVw
dHMgdG8gaXNvbGF0ZWQgQ1BVcyIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IFdhaW1hbiBMb25nIDxs
b25nbWFuQHJlZGhhdC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvaHYvY2hhbm5lbF9t
Z210LmMgfCA3ICsrKysrLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9jaGFu
bmVsX21nbXQuYyBiL2RyaXZlcnMvaHYvY2hhbm5lbF9tZ210LmMNCj4gPj4gaW5kZXggODlkMjE0
ZGRhMzYwLi5lZDEyMWQ3NGQ3M2YgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaHYvY2hhbm5l
bF9tZ210LmMNCj4gPj4gKysrIGIvZHJpdmVycy9odi9jaGFubmVsX21nbXQuYw0KPiA+PiBAQCAt
NzUyLDYgKzc1Miw3IEBAIHN0YXRpYyB2b2lkIGluaXRfdnBfaW5kZXgoc3RydWN0IHZtYnVzX2No
YW5uZWwgKmNoYW5uZWwpDQo+ID4+ICAgCXUzMiBpLCBuY3B1ID0gbnVtX29ubGluZV9jcHVzKCk7
DQo+ID4+ICAgCWNwdW1hc2tfdmFyX3QgYXZhaWxhYmxlX21hc2s7DQo+ID4+ICAgCXN0cnVjdCBj
cHVtYXNrICphbGxvY2F0ZWRfbWFzazsNCj4gPj4gKwljb25zdCBzdHJ1Y3QgY3B1bWFzayAqbm9k
ZV9tYXNrOw0KPiA+PiAgIAljb25zdCBzdHJ1Y3QgY3B1bWFzayAqaGtfbWFzayA9IGhvdXNla2Vl
cGluZ19jcHVtYXNrKEhLX1RZUEVfTUFOQUdFRF9JUlEpOw0KPiA+PiAgIAl1MzIgdGFyZ2V0X2Nw
dTsNCj4gPj4gICAJaW50IG51bWFfbm9kZTsNCj4gPj4gQEAgLTc4MCwxNCArNzgxLDE2IEBAIHN0
YXRpYyB2b2lkIGluaXRfdnBfaW5kZXgoc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwpDQo+
ID4+ICAgCQkJCW5leHRfbnVtYV9ub2RlX2lkID0gMDsNCj4gPj4gICAJCQkJY29udGludWU7DQo+
ID4+ICAgCQkJfQ0KPiA+PiAtCQkJaWYgKGNwdW1hc2tfZW1wdHkoY3B1bWFza19vZl9ub2RlKG51
bWFfbm9kZSkpKQ0KPiA+PiArCQkJbm9kZV9tYXNrID0gY3B1bWFza19vZl9ub2RlKG51bWFfbm9k
ZSk7DQo+ID4+ICsJCQlpZiAoY3B1bWFza19lbXB0eShub2RlX21hc2spIHx8DQo+ID4+ICsJCQkg
ICAgIWNwdW1hc2tfaW50ZXJzZWN0cyhub2RlX21hc2ssIGhrX21hc2spKQ0KPiA+IFRoZSBjcHVt
YXNrX2VtcHR5KCkgdGVzdCBsb29rcyB0byBiZSByZWR1bmRhbnQuIFRoZQ0KPiA+IGNwdW1hc2tf
aW50ZXJzZWN0cygpIHRlc3Qgd2lsbCBjYXRjaCB0aGUgY2FzZSB3aGVyZQ0KPiA+IG5vZGVfbWFz
ayBpcyBlbXB0eS4NCj4gPg0KPiA+IE90aGVyd2lzZSwgSSB0aGluayB0aGlzIGxvb2tzIGdvb2Qg
YXMgYSBzb2x1dGlvbiB0byB0aGUgY29yZQ0KPiA+IHByb2JsZW0uDQo+ID4NCj4gPiBNaWNoYWVs
DQo+IA0KPiBZZXMsIEkgYW0gYXdhcmUgdGhhdCBjcHVtYXNrX2VtcHR5KCkgdGVzdCBpcyByZWR1
bmRhbnQgYW5kIGNhbiBiZQ0KPiBza2lwcGVkLiBJIGtlZXAgaXQganVzdCB0byBtYWtlIGl0IGVh
c2llciB0byByZWFkLiBJIGNhbiBjZXJ0YWlubHkgZHJvcA0KPiB0aGUgY3B1bWFza19lbXB0eSgp
IHN0YXRlbWVudC4NCj4gDQoNClRoZSBmbGlwIHNpZGUgaXMgcGVvcGxlIGxpa2UgbWUgdHJ5IHRv
IGZpZ3VyZSBvdXQgIndoeSBpcyB0aGlzDQpoZXJlPyIsIHRoaW5raW5nIHRoZXJlIG11c3QgYmUg
YSByZWFzb24uIDotKSAgSSdkIHNheSBkcm9wIHRoZQ0KY29kZSBhbmQgYWRkIGEgY29tbWVudCBs
aWtlICJBbHNvIGNhdGNoZXMgYW4gZW1wdHkgbm9kZV9tYXNrIi4NCg0KTWljaGFlbA0K
