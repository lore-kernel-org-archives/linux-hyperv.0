Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012083.outbound.protection.outlook.com [52.103.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022228B7EA;
	Mon, 10 Aug 2026 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377786; cv=fail; b=GaUqkN9LtFmbwUZZbkBO9Ypx8U/G/B2pmn5DLgnxpb5L+a1b8lCTZhs47sFVpBF3PxG5PLURP66Erp3BC6KcfBcq6W0X3mNFbS+BPCrzbNN2w1Aei8mGUkBbQsD0IAIPtdvmu1pBwnU5+T6WQXE/ish1J0olvR65478jLs6xXLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377786; c=relaxed/simple;
	bh=oYURGitDS0Xi3Oh96lk8NnVj9JesorNTroVQJ8/s1D0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eyf1CTArJFw0pe+5kEmzq1idFM5pl81ZFsDNK2xkWyhDjvo5zY+E8g0vj+rNuUn0KrdqTGlCwXK0eVg+eX1JUaLGPEa5XGNQI/BNqhLTrhnVMmK5f8UfLBfEm7gt/IrBA3H13LUW0Hte+5Hv9y0pIoB3yEUWVqT+ZLO+vYnPbiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gI8u+PzX; arc=fail smtp.client-ip=52.103.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gI8u+PzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJK+pmMe81W3aJIAJResvrFGJtlobABJeIkwFjSJpX/yWcT42nodYIZxvj+8s4+7Bd3sBSn/ouEjodVh+TPyR2mfJzG5ENf9+GnT6m9s5knJMd3s7IO9ZA6haDqzWFNhff42X5mHMKu5TyXP+R2cnwFwK7vMp2OOu9jzyB4xMpDWeUPLSU088mzFi4K9gLAsit7oeK7abc7C5iwtqlXRWho//Sv3az0CYgWPavKNxaM6W9wTFm+Yv6NoiQ6v9Q1NZFNp7QKufVDXs9ZiDcVfMvpmI0M0QJDSvjyBRqI+TA/fEpl6N5a5R581fuOrV1mM13AyLc5+yaQR/3uRAE5UIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYURGitDS0Xi3Oh96lk8NnVj9JesorNTroVQJ8/s1D0=;
 b=rHcXkcomInbkpkcgQEl3SIrfTxMA+UMszAygmvsFSauHWimgWteLA+CxUboORSM/45CDyGh8CbLVRewInyn5IXMuOBdxs9lEwaA5OgV7FZLxw+iqWDYDsAWoyERr/ss3OovASOE25qqIk+xnPTdWtnLAV/oKvUyHrIIOoNHT07sv+GbwcCWVGnG41igrcWmo6C3cBavevtmtTJ61J7hm2P+lBX/hjcHYeeYKh3stDA8hFZa7kcCj1ffHozANB7W0gKXOsLrRLELd7x0n5u017jj2gYW2eodDwFzdKensiXI5prG8q48qs1WXa0nKTwrSy8UPZs3DNzc0d200Gd1wLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYURGitDS0Xi3Oh96lk8NnVj9JesorNTroVQJ8/s1D0=;
 b=gI8u+PzX0fiD0NFdzzkkMzNtGSyPP5ALoMhIXwZAeX/IemY6vdeNy9MpcLwQ4pj+dC322rS+TST1GLo6hHpNiy4MUBpww9W2AEcCojJQmmJM7bX0NCZcU2jYTmQpJ69O6KVr47/NYQmT7+gI0auDh2gIGYLDsGQ20U7oGRn0c/BK7oTrd2QYM1sIZyG6jdjtNYvNUxPOi4vGPz6qYFsmxqvnU5PnlhFpp8ktRwc5cTcgIZiBbwgDVzm0UB/mVXBRbwHF+pM8ZKcyxS1Q0+cPnlk/e7VzrK49o/kY/Hrmn6wFRi3utFmllD+pXAF3JcFzZkHovVcmNs8V5Mempn2KRg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA5PR02MB12001.namprd02.prod.outlook.com (2603:10b6:208:608::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:03:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:03:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup for
 non-nested root partition
Thread-Topic: [PATCH v2 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup for
 non-nested root partition
Thread-Index: AQIPoccrxNw+ckH9MQ6flUAqHbF277YqvAKAgAfD3hA=
Date: Mon, 10 Aug 2026 16:03:02 +0000
Message-ID:
 <SN6PR02MB415799764B0A9913F652E177D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260805142421.104797-1-mhklinux@outlook.com>
 <4a363c99-e03a-469e-bf4d-bce811586d4a@linux.microsoft.com>
In-Reply-To: <4a363c99-e03a-469e-bf4d-bce811586d4a@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA5PR02MB12001:EE_
x-ms-office365-filtering-correlation-id: 389257c6-c0e6-4d1e-9960-08def6f8db12
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|31061999003|8060799015|19110799012|13091999003|12121999013|51005399006|24021099003|37011999003|15080799012|55001999006|25010399006|10035399007|40105399003|1602099012|2607281247196008|102099032|4302099013|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjlwemR5eVFueXhBTXhmVVhUZStRTzdhOHVJTmk2SkQyWEZmeEZkOFN3aytU?=
 =?utf-8?B?TmtaaHd1dGlsMjV5Qi9nM0ZKekNUUWl6bEg0My9tWi9RdS96bTZOa1ZnYzli?=
 =?utf-8?B?Y0xxZHo2UWZ4Y1BYSld4aFVqcy9DL3d1QmVrcTdjaHA2bEJiVVVHTXlTTGlZ?=
 =?utf-8?B?bGdUb0MrSUVON1Z5cFdZMldzd1lOZTVsWmJTbVhGNUQxeEZFS0kxMkV1bFdo?=
 =?utf-8?B?cHRuaU5XbnZ2VVhSMlNjTi93YTlncHFDSXJrU1UvYmN4UmFvU2h5Wm5kSC9I?=
 =?utf-8?B?S1lLNWxNUjc3UnJsSDVLVFZocElxNDZnbzlFaHQxUmk1ckNiOThQNld2YWtN?=
 =?utf-8?B?VUhDTXZpUHRwRFdmRjcwZUZWM2JnR3lpNUhKejh3ZjlIT2hGV3FjcGpxdVhy?=
 =?utf-8?B?dHo1NkFOMzlibXR6OXVDN0hvU1U1NUM2RFd5NXZSd2k5dlBZb3pGc00xTlVE?=
 =?utf-8?B?dWdUaURvY0llU1g2N0lRTVNnbUJ6bk0vUnltYzVmNWM2NnpCNXhhd2FERXNH?=
 =?utf-8?B?R1lkSStVZWtJREVhOW1wMjZtY215SWdIcU9QRHBmZUs5OUZOd0xQUG5HSjFs?=
 =?utf-8?B?V3UwZ0t1S3VUd3hPRnlWN0NCZHNBOVdtcE93b2EyTVVscnJlQk9lM2JuRkZC?=
 =?utf-8?B?bENnUWRXbkp6NEUyVGd1Y1NSU0g3SXdmdXV1dWZ3eW9Bb0E4ckFaNWtPU2lN?=
 =?utf-8?B?TmRzTnZNdU1aZGZlbXhraXJSQjJGUmJjdjhlbWdFSnRtVWNyTFRFSytSNXk3?=
 =?utf-8?B?VDkrWmoxRXdubkxzRmVRdE9EdFU2VlAwUm1jallGZG5paEFHR0tVbFRWUE5D?=
 =?utf-8?B?d2lBS0ltRmptUXZwc1VBNlEvK0RZQ2xUeUpQMVEvamhJUEFQTUMwaE0zbVlX?=
 =?utf-8?B?a2hIQjNIV0JPY1dwbGdXd1JVdlRxd3hvRjM4WExXU2pFME9uYU1wVUtWbnNO?=
 =?utf-8?B?Y2ZpWVBhVlhsL1JGazdCTFBkQXA0ejJtRnJoOGV6MDNBYW9TOUdFek1YZWkx?=
 =?utf-8?B?Q3NOTFI1dTlWc1RSTXFZRXllYjltMXBqclZ3OUpXTDVPR3hsSU1XOTBqdm53?=
 =?utf-8?B?MFNsYVVaT1dFVlVJSWJyLzZMd1RoVXF5d2R3NHNXUzFDT3lGakdJUEVEZVB6?=
 =?utf-8?B?aGsrVG9HeWJqNFdFSjlVenBSZHREYy9KRVJoNG55RWFFWWR6NVlUN1crc2lx?=
 =?utf-8?B?ZnB6c0RDbEVNSGdDdGljb2VjSFY3MXhnOTcwWkpHYmRKTG40Q1BmektVVC9C?=
 =?utf-8?B?Y0tDclhHZVo5ekVBLzh4YVdUWHIvV3NiZTJLb2VRVENrc3V2SGNQWG9CbjB3?=
 =?utf-8?B?T3hrN0dJcVdjZDcyb2w4bGcrREhxWnZDcURxOTNrQjdHR2pSWFVjMWUvcENU?=
 =?utf-8?B?elBlY0VCZmN2N0l1c0xDdUhINkdHVHB6ZCt1eThWSmo2N3VNeVI0MEVpTGhl?=
 =?utf-8?B?VCtGWlNPU2pWZlhtK1dNaXRxTmdSZ09heHBrNG53UTgzUnA2ZjF2a3ROKzlQ?=
 =?utf-8?B?RHJRNjRCOGhiQzJua1lJemVGL0dsMFIxcG54REdjdi92REg1QjFHb1JPM0kx?=
 =?utf-8?B?bW9MR05MSzBQdU9pVUNxdlFiUXJSNzU3T3pybDNYQllOTnA1anhoQnJMdjZo?=
 =?utf-8?B?QlBJcVFmZHBlZVpybFJlbzNzUHVXc1E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVZ6Q2Q1MUNNTVZTOGdPTnRZNU16UENHYUt5ZGw1aDNoaHBLNlFSbDA2NEE1?=
 =?utf-8?B?enZoci9xcDRPTU1ZVzhaRzNpQmNsUW1QVUsyUkY0Mi9uQmRYMVFYc0ZTTWNl?=
 =?utf-8?B?NzU5RVVnZ0Uzek1HSVBuS3VTdmNobHV1ZDg4a3hrSlVMOU5Ldmdzc1A0MGpu?=
 =?utf-8?B?bGM2VWxJQ0JVdm90VGhGTUZkUEQ3eUhtNzA4RXNnSUtLWkFqOUZLNzhPQk9y?=
 =?utf-8?B?REUzNk9tcHgwN0U3dWFLY0ZMTUNTVkwzUUZaRzBqcW1xcXV5R0tTT1VsY203?=
 =?utf-8?B?dEs4bGtzRTZxQUdKQlpCaTMyS1NPNkgzTEFuUWdhVStSZndzcFZxMFJOaE45?=
 =?utf-8?B?aTgvSktlRFhkWDhXR0dnVVU2SUZQWXVvTG1LTmwwSzJXNEVCdkpHSG1FOTdF?=
 =?utf-8?B?TXBvV08vR21lNnY5UEtITlZEaVE3TlByQTV2enBSVndlcU9sOWRzRjJMQU1V?=
 =?utf-8?B?V3ArTEUzSFV3WnAxUUFwcTFROXVLK0xIVFNMV2lISU10MDRGVXg2czVpR2w4?=
 =?utf-8?B?bzVkOWJ5YjF3cHNLK0hLR2Nxc2lMakxhdGM5MjBwR0lMMTdYNnBncjZxTTh6?=
 =?utf-8?B?V1EvYmE5YTNrOFRqVmNzaWNST2FJSDdYSDVWcFlFVkNoUHRHbnFMME8wK0Y0?=
 =?utf-8?B?QU5TTEJYM3J6RXUrWFBvUW1FTGdudWZ3dUpOQ1BhK2RrSDRRNzBpemlCYnVq?=
 =?utf-8?B?V1VhblRvN1drdnRxSUQwTjhjb2tjd2FpdU1mbWxvZVlZUmprUVFLbnNlWUgz?=
 =?utf-8?B?RWN0V2tBblN2bVplVFdMaTFDb21CSk5Vb0t6TmsyR0RsL2FEQ0NxR2JwWHJG?=
 =?utf-8?B?dzdTZlgrK01hU214VGpKbmdSd0Y4YnIwd2lvWDBDQkN4eHlrV09KMGdpQUtY?=
 =?utf-8?B?YS9mblA5TEx4TlU0SFBRSmRzZlZqc3FBNWEzM2ZHUmJwUWwvTThOZVVBRHpX?=
 =?utf-8?B?T0Q0NTF6VHBMTjRJZmdIc2UyTG9RellyMXBDRkwvOGRpd1ZVelQ2UTRYSVBS?=
 =?utf-8?B?QVR3L0tRY29zNE9nS2ZYd3htQ1Q0N3ZSeG1lZ0Nacm9RYTA1ZVAzN0NRYkdy?=
 =?utf-8?B?U3VZTzNReFV6QTJyVnZsZENEOFR5ek9Uc2k2cUxhWGlYZEw3Lzg5aVQ3dHJl?=
 =?utf-8?B?VjM5b1dqZEZtQXNEUm5DVFJ0dDZnQnlhU1MwMHNqWHo0YVhSejJsdkMvRlhF?=
 =?utf-8?B?Um1zWlM3WmNKS3o0NUtoVUc0aVp2RkM0SXhoTGVyWlNGMnF2bWFmQWpxMjdh?=
 =?utf-8?B?NHROQkVtK0JLeG5GbXJ4Y3dubDQ2b1NsWXZRMmpxK0prTC96NWdJWWxQRUxU?=
 =?utf-8?B?cHFFT1ZWR1pNL1ViVFhUTnZEWFErdVVZT0ZEMHlJTFRTVURMcWVqYnNINWlC?=
 =?utf-8?B?d25zWE5zWjdDQ2M1bWU2cjZFR2VsVy83WDRmUFd0L1NtNVM0elVGVUhORVJs?=
 =?utf-8?B?YUEzVWwvbDJzbkxJaXBCN1QycFJRaXVGQkJqd0pDUFljbThIakYrLzFIM3NC?=
 =?utf-8?B?OUJqdTBxRHVRM3BtRUlSbnpsZnJGTVVjcEtNaWpqUkR6MFhPWDIvTXFSbzhZ?=
 =?utf-8?B?QWdvcDR2MGVZM1dyalNyY3d4ejI3U280TTJRTkp6Y1ZLdXJndjFBOVcxQlc2?=
 =?utf-8?B?YzBjMlcxMndKUTkxZVZITFdSdUw4QXFqbkxISnZpVnZNNkY5aG85ZDZQWm1O?=
 =?utf-8?B?R0V3ZmkwekxVaTYyOFdQWGNnak91T045MWJqTitwa0llMUJwUTREMlg0WWM3?=
 =?utf-8?B?NVhVZERsTnE3a2Zoelh2RzdMUTUzMFhEb2dqWSsrM3RNVlpxVFV0UUl4TUJl?=
 =?utf-8?Q?Q5GiYhh9rKHSeYvz5YlK7ghGWMO5X7LRtrnpo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 389257c6-c0e6-4d1e-9960-08def6f8db12
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 16:03:02.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR02MB12001

RnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFzd2FyLmhhcmloYXJhbkBsaW51eC5taWNyb3NvZnQu
Y29tPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA1LCAyMDI2IDEwOjI4IEFNDQo+IA0KPiBPbiA4
LzUvMjAyNiAwNzoyNCwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gVGhlIFZNQnVzIG1vZHVs
ZSBpbml0aWFsaXphdGlvbiBmdW5jdGlvbiwgaHZfYWNwaV9pbml0KCksIGN1cnJlbnRseQ0KPiA+
IGRvZXMgbm90aGluZyB3aGVuIHJ1bm5pbmcgaW4gdGhlIHJvb3QgcGFydGl0aW9uIGFuZCByb290
IGlzIG5vdCBuZXN0ZWQNCj4gPiBpbiBhbm90aGVyIFZNLiBCdXQgdGhlIGluaXRpYWxpemF0aW9u
IGZ1bmN0aW9uIHJlcG9ydHMgc3VjY2Vzcywgc28gdGhlDQo+ID4gVk1CdXMgbW9kdWxlIGlzIGlu
ZGVlZCBsb2FkZWQuIFZNQnVzIGZ1bmN0aW9uYWxpdHkgaXMgbm90IGFjdHVhbGx5DQo+ID4gbmVl
ZGVkLCBidXQgdGhlIFZNQnVzIG1vZHVsZSBtdXN0IGJlIGxvYWRlZCBzbyB0aGF0IGh2X3ZtYnVz
X2V4aXN0cygpDQo+ID4gY2FuIGFuc3dlciBjb3JyZWN0bHkuIEZ1cnRoZXJtb3JlLCB0aGUgbXNo
dl9yb290IGRlcGVuZGVuY3kgb24gdGhlDQo+ID4gVk1CdXMgbW9kdWxlIGlzIG5lZWRlZCBhcyBk
ZXNjcmliZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGZvcg0KPiA+IDg0MGI3NDBhMzViZiAoIm1z
aHY6IEFkZCBjb25kaXRpb25hbCBWTUJ1cyBkZXBlbmRlbmN5IikuDQo+ID4NCj4gPiBMb2FkaW5n
IHRoZSBWTUJ1cyBtb2R1bGUgd2l0aG91dCBhY3R1YWxseSBpbml0aWFsaXppbmcgaXQgY2F1c2Vz
DQo+ID4gZmFpbHVyZXMgaWYgdGhlIG1vZHVsZSBzaG91bGQgbGF0ZXIgYmUgdW5sb2FkZWQuIFRo
ZSBtb2R1bGUgdW5sb2FkIGNvZGUNCj4gPiB0cmllcyB0byBjbGVhbiB1cCB0aGluZ3MgdGhhdCB3
ZXJlIG5ldmVyIGluaXRpYWxpemVkLCByZXN1bHRpbmcgaW4NCj4gPiBtZW1vcnkgZmF1bHRzIGFu
ZCBhIHBhbmljLg0KPiA+DQo+ID4gRml4IHRoaXMgYnkgaGF2aW5nIFZNQnVzIG1vZHVsZSBleGl0
IGZ1bmN0aW9uIHBlcmZvcm0gdGhlIHNhbWUNCj4gPiBjaGVjayBmb3Igbm9uLW5lc3RlZCByb290
IHBhcnRpdGlvbiwgYW5kIGRvIG5vdGhpbmcgaW4gc3VjaCBhDQo+ID4gY2FzZSwganVzdCBsaWtl
IGh2X2FjcGlfaW5pdCgpLg0KPiA+DQo+ID4gSW4gdGhlIGxvbmcgcnVuLCB0aGUgY29kZSB0aGF0
IG1hbmFnZXMgdGhlIEh5cGVyLVYgcHJvdmlkZWQgU3luSUMNCj4gPiBzaG91bGQgYmUgcmVmYWN0
b3JlZCB0byBiZXR0ZXIgY29vcmRpbmF0ZSB0aGUgcmVxdWlyZW1lbnRzIG9mDQo+ID4gcm9vdCBw
YXJ0aXRpb24gc2NlbmFyaW9zIGFuZCBub3JtYWwgVk0gc2NlbmFyaW9zLCBhbmQgdG8gaG9wZWZ1
bGx5DQo+ID4gcmVtb3ZlIHRoZSBodl92bWJ1c19leGlzdHMoKSBkZXBlbmRuZWN5IGJldHdlZW4g
bXNodl9yb290IGFuZA0KPiA+IFZNQnVzIG1vZHVsZXMuIFByZXZlbnRpbmcgdGhlIGN1cnJlbnQg
dW5sb2FkIGZhaWx1cmUgc2NlbmFyaW8gaXMNCj4gPiBhbiBleHBlZGllbmN5IHVudGlsIHN1Y2gg
YSByZWZhY3RvcmluZyBpcyBkb25lLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IFNhc2hpa28gPHNh
c2hpa28tYm90QGtlcm5lbC5vcmc+DQo+ID4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1oeXBlcnYvMjAyNjA3MjExNTQ5NDMuQTA5QkQxRjAwQTNEQHNtdHAua2VybmVsLm9y
Zy8NCj4gPiBGaXhlczogN2UyNzlkNzg2NjRhYSAoIkRyaXZlcnM6IGh2OiB2bWJ1czogc2tpcCBW
TUJ1cyBpbml0aWFsaXphdGlvbiBpZiBMaW51eCBpcyByb290IikNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+ID4gLS0tDQo+ID4gdjE6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWh5cGVydi8yMDI2MDgwNDE5MDUxNy4xMDE5
ODEtMS1taGtsaW51eEBvdXRsb29rLmNvbS8NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4g
KiBVc2UgYSBkaWZmZXJlbnQgc29sdXRpb246IEFsbG93IHRoZSBWTUJ1cyBtb2R1bGUgdG8gbG9h
ZCBidXQgaGF2ZSB0aGUNCj4gPiAgIHVubG9hZCBmdW5jdGlvbiBkbyBub3RoaW5nIGZvciBub24t
bmVzdGVkIHJvb3QNCj4gPiAqIENoYW5nZSB0aGUgcGF0Y2ggU3ViamVjdCBhbmQgY29tbWl0IG1l
c3NhZ2UgdG8gcmVmbGVjdCB0aGUgbmV3IGFwcHJvYWNoDQo+ID4NCj4gPiAgZHJpdmVycy9odi92
bWJ1c19kcnYuYyB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIGIvZHJpdmVycy9o
di92bWJ1c19kcnYuYw0KPiA+IGluZGV4IGUxOWVjNzNiMDE4Ny4uZjgzNzE1MzQyN2Y0IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2h2
L3ZtYnVzX2Rydi5jDQo+ID4gQEAgLTMwMjQsNiArMzAyNCw5IEBAIHN0YXRpYyB2b2lkIF9fZXhp
dCB2bWJ1c19leGl0KHZvaWQpDQo+ID4gIHsNCj4gPiAgCWludCBjcHU7DQo+ID4NCj4gPiArCWlm
IChodl9yb290X3BhcnRpdGlvbigpICYmICFodl9uZXN0ZWQpDQo+ID4gKwkJcmV0dXJuOw0KPiA+
ICsNCj4gDQo+IERvIHlvdSB0aGluayBpdCdkIGJlIHVzZWZ1bCB0byBoYXZlIGEgY29tbWVudCBo
ZXJlIGVpdGhlciBzYXlpbmcgc29tZXRoaW5nIHRvIHRoZSBlZmZlY3Qgb2YNCj4gIm5vdGhpbmcg
d2FzIGluaXRpYWxpemVkLCBzbyBsZXQncyBza2lwIHRoZSB0ZWFyZG93biIsIG9yIGFsdGVybmF0
aXZlbHkgcG9pbnRpbmcgdG8gdGhlIHBhaXJlZA0KPiBjaGVjayBpbiBodl9hY3BpX2luaXQoKT8N
Cg0KSSBnZW5lcmFsbHkgbGVhbiB0b3dhcmQgYWRkaW5nIGNvbW1lbnRzIGZvciBhbnl0aGluZyB0
aGF0IGlzIG5vbi1vYnZpb3VzLA0Kc28geWVzLiBBY3R1YWxseSwgYSBjb21tZW50IGlzIHJlYWxs
eSBuZWVkZWQgaW4gaHZfYWNwaV9pbml0KCkgdG8gZXhwbGFpbiB3aHkNCnRoZSBjb2RlIGludGVu
dGlvbmFsbHkgYWxsb3dzIHRoZSBtb2R1bGUgdG8gYmUgbG9hZGVkIGV2ZW4gdGhvdWdoIG5vIGlu
aXRpYWxpemF0aW9uDQppcyBkb25lLiBUaGVuIGEgY29tbWVudCBoZXJlIGNhbiByZWZlciBiYWNr
IHRvIHRoYXQuDQoNCkknbGwgc3BpbiBhIHYzLg0KDQpNaWNoYWVsDQo=
