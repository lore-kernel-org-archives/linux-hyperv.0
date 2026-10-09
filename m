Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012019.outbound.protection.outlook.com [52.103.11.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156793A5E84;
	Fri,  9 Oct 2026 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523881; cv=fail; b=kEGyTaH4MMwsmOHCE+XtnOS7+IVOclLjlTnMNtL/t5y+gtgAMWCdWVMi494nj+Ous/VTXcqULEh5HD8pQth7bnQ9u/TOH/7c9c5n1Vbd1Mp3ygjC79taW+nCZonC9KJ2ZVIVmOQu64THQOxvAf7lowgU/6GM81g8Nd4IltN0EfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523881; c=relaxed/simple;
	bh=ei7opdJ1A0nqI9XnXjQ819qWCMH5sTOyWZLlkhLZToY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u32LPXPqeuNGtkJzs5o5ZkhG7LRvCtdsaEt1D0KbdWiK8rpbXkvZ+NcOK1OD6RIDmVK11aH3TLEoyOD338JYeyqc2L3ObrRni3mRFdOZf0OOqw1Uru+fgySctvdpUzpgEp5qm98TpCiYBUrSzhdRlyYH/lBV6MSe8merQEOHxpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZFXFU5q5; arc=fail smtp.client-ip=52.103.11.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZFXFU5q5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddXnUKJr8O68w6kox5K8+kAeeZyfNOli4DWLflpfQODvXwng5vaatxV+S7JI7UMUsOz4Q9Hh94GYy6ONQ8O8M3JnhG2C5Le7qOA6pwo+NpmJv/dcEKjvdNBKSCMU/1tIvGsJOR3In1Ju7HqrBLRar3TqbyKpv55HANUwRddwMJzUdd6VstXBS6PhDS9Md+lalDWX+sNE7eQ7XnbR7/PD25MSdJWC8wKt3Zj11ex0BeYuti8ptxDcgS0bixidzPcysHEP+7SAolV4FOi2pkjvn3D8OrxobIlwl00jtFXImvml/KLaXxJqxYoLleNp94tSacRTq9MBhqBdB9djHWCwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei7opdJ1A0nqI9XnXjQ819qWCMH5sTOyWZLlkhLZToY=;
 b=fCsxzqmqlyeFMzrkWMYxylkzb9lGrMpErvGLvt8p+SN23Wz4H1cg/pkmHl6U/POcLAFTWKHINFxL/Ow6HkbbaRblsXG1mar4AL04GbhacZIerlGqmRDUKXdRKC7yxKPlCrph5lk7NWNVpWl2eOt62EBLaZSoYbAW6R3zndodkhOsBEP96nieYwBeo3kCrJ6upo9H2tExAKVFhOHpDUShEHHL286daTXzkOEQuXyYhzsVgXl7sdeum8uF+A/k6+ftD7AQz8LFDdGs0bhEzpXcBZAZZf7eWGcLDV06Rk0Yjzc/Q/DiZXtgD66cYuThDi0G80VzfYJDHm/v++xeCGdqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei7opdJ1A0nqI9XnXjQ819qWCMH5sTOyWZLlkhLZToY=;
 b=ZFXFU5q5Caiey276qYDvMhRHnC+DVESphACnVCeodVAXcJSGBEVdJtLJ/8k6FM2y/0IthgoaXRSft8thGB/E1ddyj0EyHwuwFi2f2knpFyCPdBxM3mqX+BJzU5xZ/XAxRsS9fadqouLGvEfhMt63vlOjQ08H+7cgpZf9IAyRfV+zLL8w3CTPKJCSYn0LxLrlYmhyLwtyA3JTfsP4oYO3olZl9vaK8bNnlq5FYn67ka5jB/4ekE6CeZbcdQdBWKavIE+ePOfup70k6RBTSFXkzw9tO4JqeAxZGBISD6Yh/bOAjWLEJyuBFVGmUro4SCpnBu9XHoGAWThfoQDZJMK3qw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DM6PR02MB6748.namprd02.prod.outlook.com (2603:10b6:5:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:31:17 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:31:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
Thread-Topic: [PATCH 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
Thread-Index: AQEvZQSsLKEGT4J+CjqOahDoURF5ELhQhheAgAAOq0A=
Date: Fri, 9 Oct 2026 05:31:15 +0000
Message-ID:
 <MN2PR02MB68632A2D7C859FF9BBFBA020D4922@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261009030637.3869-1-mhklinux@outlook.com>
 <db1a6c90-f2d9-44e4-be4b-1dbc96c66691@linux.microsoft.com>
In-Reply-To: <db1a6c90-f2d9-44e4-be4b-1dbc96c66691@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DM6PR02MB6748:EE_
x-ms-office365-filtering-correlation-id: 5840e862-3985-4e42-4b05-08df25c68a18
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|8060799015|19110799012|8062599012|25010399006|12121999013|13091999003|31061999003|24021099003|21061999006|15080799012|37011999003|51005399006|40105399003|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFNKQkI5R3ZnbTVjU2NDbEVwaS9wWXRsZmpVbHI2YmloQzdKUk5WN2lsYlZ2?=
 =?utf-8?B?Y21FTWZCa2NPamtSSyszRjY0a1RoazFsQU8xQ1VWSm42dVhUMEZtdUFmMGZC?=
 =?utf-8?B?bldlaXQzb09uN3BLYlIvN3BHNm9rMmxpMXNob3JRSSs0RkI2TzkyYWt5Rysv?=
 =?utf-8?B?MU1PUktGZmJYUnhMa3RnZGdkaWxzc3k3QWRsSEx3MS82TEh1U0wvOG5lbFJC?=
 =?utf-8?B?OEkxU0pYRTdDbzNlVVlaQ3FmZGRTcDZ5NkdNL0UwVCtnaDRkWWl0M2p2cTZX?=
 =?utf-8?B?U0J5UVAvSDkvVkJQcXFPVzZOcG1SR3JKM2JBdE5NM3JsbjFjV0xVTjl5UWhx?=
 =?utf-8?B?NmNRS3RQRERDZmhHV0QzbzBmemtjbUVBYkFkaVgzUUxtSmJNWEI3OGNBVGdr?=
 =?utf-8?B?Ry80aUNBeG96K0lrZW8yYWMxUWNnMjVCcEZxeStBZDU1eCtRKzdVN1RSOHdp?=
 =?utf-8?B?NEtjWWFOYUkySHJxdExWK3NHUzQrVHc2ZmpsNWFSZkpGeHJ6emF6eHExRTYw?=
 =?utf-8?B?T2h1SjBDNHBkU0pOaFhkb3I4MDR0RXZ0VnJHVGY5WXdTU0JSNExDaWNLT2Zu?=
 =?utf-8?B?dVdZTE45aTVqbFBKem1YaWp2R2xUeXFxaXRoenJTcEF4NStVQU90U1NaZ2VE?=
 =?utf-8?B?TTFRZ05lUzk1NVVYMlIrekx0MVRJMy9WekhhSlIwdGdGempSSnJXWjZCWjhk?=
 =?utf-8?B?RFZiQlhOSFBudW5GbkhmMGtnTUlxMm5GTDhYdTFtWks0MGFxZHd0MmhDMTlJ?=
 =?utf-8?B?ZmJJWEtRSHV0bDV4WkFNdnAvNXkxT0VnQXljL2lOWDNrMngxQUoxVEErSzBC?=
 =?utf-8?B?N0w4Rm5qcytTVVR5Sk1Pa2RzaTRtYSt6NHlCcUU1VGlKU1BRS3hNdWlCeEhi?=
 =?utf-8?B?UENjSE9Scmh6QkJYdEs3U24zbTNIcVJibmNtaWJ5ZjQ1U2pRK0svZDRocTFu?=
 =?utf-8?B?V1RraCtYQmdZWlFUZ2lsSmxhRGw4MjdFYU02L285ZnBPTWlxbFdKVXhmVVdO?=
 =?utf-8?B?cWhDSU91TjdMSEpJQzJCejNVVDhCMnpCUXY0ZmFCcTFubHdieE1weG1pbkVH?=
 =?utf-8?B?YnZPL1B4M0xnUExWTThNdEMxSkZNSyt1c2U2TktqS0VnbE9ZR1hXUjZKWWNB?=
 =?utf-8?B?SzIrVFlYam1wYStObG05WFp3VWJUZHQvOXBkT1AvT0pUUEFiV2RNSUF1MWlm?=
 =?utf-8?B?QldWdmpZQzVKenZGRHpSYVd5WnNnd2lGbjU4bVZ2QWUxbTUrNGR6NGV3V3hI?=
 =?utf-8?B?bVEzd2xlYU5EL2g3eHN1OGJTV2E0NXQ0TGlMSUJtekJWMHE2UmpRT0ZGeStk?=
 =?utf-8?B?dlJ1b1NVcTNhdFc0KzJpelVITXJodnAzM3k4NGZRUlVjTVdDemZHd21nQld3?=
 =?utf-8?B?VlY3ODVUM3UxUUFmdFZPaFdOWDUwSXQ0RDg1N2FtM2d1bC9LTWtWOUZEUmE4?=
 =?utf-8?B?M2V1SXVHNlE1RlYzOUJycmczWEJIRGNSdnlHRU9rM2ZnMFNTeE81azFldklj?=
 =?utf-8?Q?ppxLcw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SE9oMi8zRHdQdmgyOWk3b1dWaFp1a0ozTTRva3BKV2J6cGFSUDIvUTJJOG9L?=
 =?utf-8?B?TThUbENyd3o4ZjVtb0NHTVgvY0FTQWczaXhoVERmbGdLZlhFQUJ2NExZditP?=
 =?utf-8?B?blZoempkTGFkSXNYcU4wT280RERRUjRlQk1PdUVGU2JsRjgyaFA1TnF0WXhq?=
 =?utf-8?B?c3dHVFhYZkJGdzFYUTlWWVZxRWh2bTI4YW9PeGd6L2dKVmZkZmRsaFVwY3BC?=
 =?utf-8?B?THVvUHJVY2FCVFdTejRJdnZxVmRFNU1IeThmSS81djlVNEpuN29HNTRCaVhP?=
 =?utf-8?B?OHlRaHBXNnNhYkVKZFpmbno1dlVsNFRVcUQybE84MFJMZHBUSFB3R1NwNzZK?=
 =?utf-8?B?SzBia013MW9VUEp2UHdVemw5TnRJUG40a3JEbkw3bmQ3bEVkd3UyRzJSYWdk?=
 =?utf-8?B?SGJLQkt1SGt1M1lES2pzWkNpOHRYMWtWVFgrT09BQVc5bHVnb2pTTFpQamhW?=
 =?utf-8?B?UGVPekY3cy9CMW5kUkU4Q3JoRTBtb1BGYlQrNjJCcVdSbHhHZDMzN01aWlJj?=
 =?utf-8?B?VDFxTmpoSkFGK0VyR2FJK2FYSFNxMnNhUTdQZHpFYnkxNWZhb1ZKTzgxeS82?=
 =?utf-8?B?SXl2YWJlT1B1T0t0VTZ1ZExxUE5CYTNWSmtrZmFSWGpaT1NXVkx6UTBxYVoy?=
 =?utf-8?B?RTQzSXlzUCtFdkJLYmxKL0kwbFM3ZW9xcUIxbEhyWEE2MkJqd3loa2FMS08r?=
 =?utf-8?B?TVpYMXpmRTNYbHFDaVRpd0JXTmxZM2xyUXRHVy9mcHJ1QVZINVZ5T3AvRnpk?=
 =?utf-8?B?bklXSVBLTEp1Zmt3M0l5V05RaGpnYnpkdFdjbjFmVG0rd1FYU0VwMjJOWmJn?=
 =?utf-8?B?TzE5VDNxcWhCblRaRUplVVI3RUdyM0wyWlk4eDQrSTZyejBlY2JaZkVWVjNk?=
 =?utf-8?B?blZJNDFjUDhOenJuSjRtdkdqZS9YS3hJK05EU1JIcG5CKzhtaUVNdGd3UFh6?=
 =?utf-8?B?cE1JWGVCSUorZU02R3V0OWlLc1VhdWNQcE81RWhBYVNsMGlUUXZDVk43OVRr?=
 =?utf-8?B?VDJZZ1ZMaENsQVV5RklWaHZVdDVMNFExZ2kyUzRIN3N5cSt1YnR2R0pWSEV5?=
 =?utf-8?B?QWVjWTU5WUVuclF5ZEVIdUNPSERQUnEyaG81SkRGY2R1bW9hN1A3NzFFY2Rv?=
 =?utf-8?B?Smp4cjEvWkRoS1BIcU5FMlJCUEx4ZVI5aHlzNytlQkdsTG5EREFsSUhUU2Iw?=
 =?utf-8?B?UFFwcHNoQVAxYklKeU01UHh2djR2a2dlby9nL2VEd09yTHNVN2lrcUdIWGtR?=
 =?utf-8?B?UjdOY0FCSTB5Sk5QV0hxY21SbGFxUXQwT1hXR3RVb1AzeXQ2azZ4aXFmQ3Jh?=
 =?utf-8?B?V3drN3MvTGhEdm9RVXJCVkt4Z1B2QUZWRmRBZ2I5R0tpOVFvSWRvTmx3WElR?=
 =?utf-8?B?VFVhWmZhSmQvNDZTSDBBb0FsOUVuU2tONk5BcUQrbzBIY1Z4VDh6L3oxRlZZ?=
 =?utf-8?B?andmc3drTWtBbGl3c2p1ZEhuS2xRRThIVnh2R09NeVlha0FGVXdXcVlCN2dJ?=
 =?utf-8?B?YkIyT0xxQXEyRlRwK3JQaFJBSUxoV053SWJ0cCtsNVI2ZzY1WCsvcUFEYlJ1?=
 =?utf-8?B?UmxaQ2RqZENDZG95K3ZPR3p3QndvZlRrL1FjWE9QbTlha1AwWW8rNEE5YzJm?=
 =?utf-8?B?NWxRMWxyQlpSM3VIbk5JWHNCaW9DQVJ0S1VkTE9lbWhLSm9icnQrczQ1K3BH?=
 =?utf-8?B?bldoNkwzTW9GZ1dUVUUyRWU5K0g1c0NrRGthMUJRWGpqK1NnMGFmaFpnMUEz?=
 =?utf-8?B?WThXbWJwMTlZNkdCMkZOZkhKTlFDSFQzOFMvVzV4OGhzZ0dGOHJNNDVZa2NB?=
 =?utf-8?Q?TqK7SzTHXG3hpEEG6/TqOQ4ecJaZp2UAFGZAo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5840e862-3985-4e42-4b05-08df25c68a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 05:31:16.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6748

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciA4LCAyMDI2IDk6MzkgUE0NCj4gDQo+IE9uIDEwLzkvMjAyNiA4OjM2IEFN
LCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBUaGUgZnVuY3Rpb25zIGZvciBzZW5kaW5nIFZN
QnVzIHBhY2tldHMgaGF2ZSBiZWVuIHNpbXBsaWZpZWQuDQo+ID4gdm1idXNfc2VuZHBhY2tldF9t
cGJfZGVzYygpIGNhbiB0YXJnZXQgbXVsdGlwbGUgcmFuZ2VzLCBhbmQNCj4gPiB2bWJ1c19zZW5k
cGFja2V0X3BhZ2VidWZmZXIoKSBoYXMgYmVlbiByZW1vdmVkLiBVcGRhdGUgdGhlDQo+ID4gZG9j
dW1lbnRhdGlvbiBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IEZpeGVzOiA0NWE0NDJmZTM2OWUgKCJE
cml2ZXJzOiBodjogdm1idXM6IFJlbW92ZSB2bWJ1c19zZW5kcGFja2V0X3BhZ2VidWZmZXIoKSIp
DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNo
YWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+ID4gLS0tDQo+ID4gVGhlIEZpeGVz
OiB0YWcgcmVmbGVjdHMgdGhlIGNvZGUgY2hhbmdlIHRoYXQgd2FzIG1hZGUuIFRoZQ0KPiA+IGRv
Y3VtZW50YXRpb24gdXBkYXRlIHNob3VsZCBoYXZlIGJlZW4gaW5jbHVkZWQgd2l0aCB0aGUNCj4g
PiBvcmlnaW5hbCBjb2RlIGNoYW5nZS4NCj4gPg0KPiA+ICAgRG9jdW1lbnRhdGlvbi92aXJ0L2h5
cGVydi92bWJ1cy5yc3QgfCAxMyArKysrLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vdmlydC9oeXBlcnYvdm1idXMucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi92aXJ0
L2h5cGVydi92bWJ1cy5yc3QNCj4gPiBpbmRleCA2NTRiYjQ4NDk5NzIuLjc3YTQzNzk2OWI0OSAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnQvaHlwZXJ2L3ZtYnVzLnJzdA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydC9oeXBlcnYvdm1idXMucnN0DQo+ID4gQEAgLTEzNywx
OCArMTM3LDEzIEBAIGNvbnRyb2wgbWVzc2FnZSBjb250YWlucyBhIGxpc3Qgb2YgR1BBcyB0aGF0
IGRlc2NyaWJlIHRoZSBkYXRhDQo+ID4gICBidWZmZXIuICBGb3IgZXhhbXBsZSwgdGhlIHN0b3J2
c2MgZHJpdmVyIHVzZXMgdGhpcyBhcHByb2FjaCB0bw0KPiA+ICAgc3BlY2lmeSB0aGUgZGF0YSBi
dWZmZXJzIHRvL2Zyb20gd2hpY2ggZGlzayBJL08gaXMgZG9uZS4NCj4gPg0KPiA+IC1UaHJlZSBm
dW5jdGlvbnMgZXhpc3QgdG8gc2VuZCBWTUJ1cyBjaGFubmVsIG1lc3NhZ2VzOg0KPiA+ICtUd28g
ZnVuY3Rpb25zIGV4aXN0IHRvIHNlbmQgVk1CdXMgY2hhbm5lbCBtZXNzYWdlczoNCj4gPg0KPiA+
ICAgMS4gdm1idXNfc2VuZHBhY2tldCgpOiAgQ29udHJvbC1vbmx5IG1lc3NhZ2VzIGFuZCBtZXNz
YWdlcyB3aXRoDQo+ID4gICAgICBlbWJlZGRlZCBkYXRhIC0tIG5vIEdQQXMNCj4gPiAtMi4gdm1i
dXNfc2VuZHBhY2tldF9wYWdlYnVmZmVyKCk6IE1lc3NhZ2Ugd2l0aCBsaXN0IG9mIEdQQXMNCj4g
PiAtICAgaWRlbnRpZnlpbmcgZGF0YSB0byB0cmFuc2Zlci4gIEFuIG9mZnNldCBhbmQgbGVuZ3Ro
IGlzDQo+ID4gLSAgIGFzc29jaWF0ZWQgd2l0aCBlYWNoIEdQQSBzbyB0aGF0IG11bHRpcGxlIGRp
c2NvbnRpbnVvdXMgYXJlYXMNCj4gPiAtICAgb2YgZ3Vlc3QgbWVtb3J5IGNhbiBiZSB0YXJnZXRl
ZC4NCj4gPiAtMy4gdm1idXNfc2VuZHBhY2tldF9tcGJfZGVzYygpOiBNZXNzYWdlIHdpdGggbGlz
dCBvZiBHUEFzDQo+ID4gLSAgIGlkZW50aWZ5aW5nIGRhdGEgdG8gdHJhbnNmZXIuICBBIHNpbmds
ZSBvZmZzZXQgYW5kIGxlbmd0aCBpcw0KPiA+IC0gICBhc3NvY2lhdGVkIHdpdGggYSBsaXN0IG9m
IEdQQXMuICBUaGUgR1BBcyBtdXN0IGRlc2NyaWJlIGENCj4gPiAtICAgc2luZ2xlIGxvZ2ljYWwg
YXJlYSBvZiBndWVzdCBtZW1vcnkgdG8gYmUgdGFyZ2V0ZWQuDQo+ID4gKzIuIHZtYnVzX3NlbmRw
YWNrZXRfbXBiX2Rlc2MoKTogTWVzc2FnZSB3aXRoIG9uZSBvciBtb3JlIGRhdGEgcmFuZ2VzDQo+
ID4gKyAgIHRvIHRhcmdldC4gRWFjaCByYW5nZSBjb25zaXN0cyBvZiBhIHNpbmdsZSBvZmZzZXQg
YW5kIGxlbmd0aCBwbHVzDQo+ID4gKyAgIGEgbGlzdCBvZiBHUEFzIHRoYXQgZGVzY3JpYmUgYSBs
b2dpY2FsIGFyZWEgb2YgZ3Vlc3QgbWVtb3J5Lg0KPiA+DQo+ID4gICBIaXN0b3JpY2FsbHksIExp
bnV4IGd1ZXN0cyBoYXZlIHRydXN0ZWQgSHlwZXItViB0byBzZW5kIHdlbGwtZm9ybWVkDQo+ID4g
ICBhbmQgdmFsaWQgbWVzc2FnZXMsIGFuZCBMaW51eCBkcml2ZXJzIGZvciBzeW50aGV0aWMgZGV2
aWNlcyBkaWQgbm90DQo+IA0KPiB2bWJ1c19zZW5kcGFja2V0X2dldGlkKCkgaXMgYWxzbyBwYXJ0
IG9mIHRoZSBleHBvcnRlZCBWTUJ1cyBBUEkgYW5kIGhhcw0KPiBhbiBhY3RpdmUgY2FsbGVyIGlu
IHBjaS1oeXBlcnYuYy4gSXQgbWlnaHQgYmUgdXNlZnVsIHRvIGluY2x1ZGUgaXQgaGVyZQ0KPiBh
bmQgZXhwbGFpbiB0aGF0IGl0IHVzZXMgdGhlIHNhbWUgcGFja2V0IGZvcm1hdCBhcyB2bWJ1c19z
ZW5kcGFja2V0KCksDQo+IGJ1dCBhZGRpdGlvbmFsbHkgcmV0dXJucyB0aGUgdHJhbnNhY3Rpb24g
SUQgYXNzaWduZWQgdG8gdGhlIHBhY2tldC4NCj4gDQoNCkdvb2QgcG9pbnQuICBJJ2xsIGFkZCBp
dC4gSSBrbm93IGVub3VnaCBhYm91dCB0aGUgX2dldGlkKCkgdmFyaWFudCB0bw0KcHJvcGVybHkg
ZG9jdW1lbnQgaXQuDQoNCk1pY2hhZWwNCg==
