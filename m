Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022106.outbound.protection.outlook.com [40.93.195.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19503515CB;
	Fri, 11 Sep 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137129; cv=fail; b=mmDVTK1/XM0u5X6B5yWJfzhP4sX1Ew0vbny76dR9R28GstKKzbLnQr76HWcdiFAUC+bbs8nHn51DpFrxy0kspPHfzkYUt8UyB1MST+kbkq1fw9aqRiYxidFTFg6QGc+vUYluFsDExrExmmcDEvFIQh8tc/AVw9+bEmtjN7Zsemc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137129; c=relaxed/simple;
	bh=CeZweqNhBzKYrq+ImFVlm7dBQ7DIPxMXOSooey4vy+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7FVcoWcqXDeLZGTSORhYxCFsXcoINJKD5p84jtGQZD1/IV1yXZLrxq/8h4OZ15yPPfBAwcGjEt1TdDqPyUHqCikcb8tNAIPYPbkD34DUTY9ZuuYQYPdP8xH6VAzgo87Y4KwvVYUv6zLFWJBTLpsujDOWESMzXW6ize1kQ4MNY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vcinity.io; spf=pass smtp.mailfrom=vcinity.io; dkim=pass (1024-bit key) header.d=vcinity.io header.i=@vcinity.io header.b=n+gOJaNB; arc=fail smtp.client-ip=40.93.195.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vcinity.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vcinity.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vcinity.io header.i=@vcinity.io header.b="n+gOJaNB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAw1DEcP0Ik/zH7ONnymXw99EpUcebcn69Wf8Cp/bRE47XoFbKMIBK+yk5abzADZjj2Q4rmG/iDX6XWhcC2mPfYKRknwPv2zdjwX+Ra5QS+0xC60U8SxqLOaX/kENPzVxa+WWk6ztk2QIvow3wfddmrQcocDkk+mis9ABq4znkOPVlO1kpLpFCr4lgRrwSMRY8onycaqZ6uClUWhQcTjrmqHFL6oayH3LhJa420b2vh1cm2TaG2HHp14R7L6Mszoszs+eqVuMuF77JryiDLzJJ6JIBmtxtB+WQzE9o3SK4LaIkQPOcT6lIk0NcFWUMA7wyhdHfukO0KltEY0C3RTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeZweqNhBzKYrq+ImFVlm7dBQ7DIPxMXOSooey4vy+s=;
 b=tj4tX+NJ/vFXlhJgSJGEeDT6XtkPb68ebjE6Jy9fNZAaJoZGMhU4sq6BFP6zPei+ftE91c2x2To9SBYN7bv3wq+tXmMwDDHmij5C2b5DWsARtr2dazCWJnB3I27bUouAiCSKxlNVZw8djcawriliqWO32hpm0nvqHajkYN+IvOq5zKGkH/ZGD0XrDZahaqmBTvsmxtVTfg7DG5E8wOwxgKRww5dkURxCcuDh6q8RFlQW+NcbVx9hu6BpanCQuIXfgmuU722UlCVHEwJijxD6EueAQKSikmzodVpFuVFrIMX0/q8apjxxFSqranAaSC1Ka5Zj6tmHbmlYqPdKn7yTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vcinity.io; dmarc=pass action=none header.from=vcinity.io;
 dkim=pass header.d=vcinity.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcinity.io;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeZweqNhBzKYrq+ImFVlm7dBQ7DIPxMXOSooey4vy+s=;
 b=n+gOJaNBDGJ2oAgkdzamutoXj+bGCdnhgn1eWVP4jO8bB/lhmddVax2/25AoRcgKV4S+riRqoARRF1juImroIdzDOdsC98O6bl+FFA1BV5JyMTgi0WAH+VS8WkNYcSSkIh5Rn0TVhFaacqcJGASgg3iw7IlezT054Aw9uxfnne0=
Received: from SN7PR03MB7183.namprd03.prod.outlook.com (2603:10b6:806:2e5::5)
 by LV0PR03MB989248.namprd03.prod.outlook.com (2603:10b6:408:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 14:31:40 +0000
Received: from SN7PR03MB7183.namprd03.prod.outlook.com
 ([fe80::9124:ad4c:3f31:234a]) by SN7PR03MB7183.namprd03.prod.outlook.com
 ([fe80::9124:ad4c:3f31:234a%6]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 14:31:39 +0000
From: Gunter Woytowitz <gunter@vcinity.io>
To: Simon Horman <horms@kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:XDP eXpress Data
 Path:Keyword:?:b|_xdp?:b|_" <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: mana: never hand a non-page_pool buffer to XDP
Thread-Topic: [PATCH net] net: mana: never hand a non-page_pool buffer to XDP
Thread-Index: AQHdQTe1Y5zxLC99hE6NpjcrmTVhK7bJOmSAgAA3o4A=
Date: Fri, 11 Sep 2026 14:31:39 +0000
Message-ID: <E180DC24-B376-48A5-AD9D-08427E69F312@vcinity.io>
References: <20260910-mana-xdp-pagepool-v1-1-dab140d91fed@vcinity.io>
 <20260911111221.GE48209@horms.kernel.org>
In-Reply-To: <20260911111221.GE48209@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.600.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vcinity.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7183:EE_|LV0PR03MB989248:EE_
x-ms-office365-filtering-correlation-id: 1a7a874f-b926-4833-0c5f-08df10116478
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|38070700021|4133799003|10067099003|4143699003|11063799006|6133799003|5023799004|22082099003|55112099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 HKWAoOx5Cqj3+13ckFhSfLwtso1hiEeV0buXRWuCV7V+sg2apk7I27dCS5j1JUe62Hs7eIFwH5l244rLTXIF+bo8+vnWrrtObQlJIYCUEI92ezqK2iIJXkxAUHl41MlG7V1/PoDnH3wLpRTMt6oNFnW/sNTdSbBfPZfwIXf+ZDYBh3SR3DqzLZm+OqzCCQY7V5PPfRTroimnJVbzhmEI+4ZwpA4aMuLxT7dw6bsx54fsgM66OoxGK0YZCLP0NKljSatr/RZt6gRqHmVnFoSHep55Soas0j7nXGcYuWq5ldQ4l6IMajhGs+QF4pmBaAbOuWJ4Sp3GPjnscP759rru39yCenjXChAJGlxDz1wfC5NRyz2ia5yBTdVxtj8tWvxw8jAyPrIWJEzBb9vOZcsnOzVpN5/qtcguduqbNCQhqByNgO9uwvEY0HMyDyWFiNJrsJWn/pAvleuaYNN2ymYSgc7sSFYviMuWwaRtqlFP8Fws0eYJXQ83msZfVEMdwJr8hWFH3MuQlVIwINL9SeFXOHtB+vdgubgXThtQNC8b5TQUZtTp1xa/hDoQgyWP+yOMuGCmzXgDcXSg+AzD6UyDLBhEkXjJU8bNaHcNpr6X1TtjGTd97Dk8wUjJ8tQJyhjZHMuniAEJON0C6gjZziHX0A3NGkFheg/o2sJfmkvbodimBzKY8y8mNpD2loE78SrU3vRasrB8mCzb6369HLFuBc6+hvlsB/k6CzOlkWCgyFU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7183.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(38070700021)(4133799003)(10067099003)(4143699003)(11063799006)(6133799003)(5023799004)(22082099003)(55112099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z21leU5PZUtwYStubEdZYTR5a0kzZExqTVNvUGhlTk1KTjhPenArSWVNQXJG?=
 =?utf-8?B?NDJQQk82OWgrbmxWcjVnTTVNZEVRQ3dqU0R0cmtHeUpoYzM4bEtMZ1YxOFJW?=
 =?utf-8?B?QkdsbWkvWkpRK3l5VW92YkxsMHk0OExQYU1KTmVyMmtCZlFoQkg2cnJmSGpY?=
 =?utf-8?B?M2F1eW1tejFpTm42Um11clV2ZFdidkNndUorNFpneFErRlFEUTN3YWdTMW0z?=
 =?utf-8?B?UE5PSVNUY0lEVm1kNHpOcmVGMW8xME9maUc1SW0veWJZWlFndkFLL0ZrZHk1?=
 =?utf-8?B?Y01LeTRFQWpvQ05xVkpINFNCQzBXSkdaZFJpUmJMZk9XM3F0cWRvZWlza01F?=
 =?utf-8?B?eCs5M1E5M0M0d1hNRUNscWYvNlRCQ2FBVUtSZ3NiOXlkNjkzRHBJbDVvTGZ0?=
 =?utf-8?B?MU5PS2krM3IyWWtvQk9ISW8yUXV3R3M5eFYrc1dFNTVOZ0hBcGJaT2c5Uloz?=
 =?utf-8?B?cXJZcGR4ZEQ5S0VoTGF2N2V3dDJ2d29rNkhvN3Z3bEEyQVQ2dUMyRGxIcEdV?=
 =?utf-8?B?cGxoL09xbSsxTEYxTTI1M2M4OW5MWllzaEhBOWFFVlUycHpybXlQYk9IK0g4?=
 =?utf-8?B?RnZ0MG1xRWJ5TW5DR0JoOENqVFNSYUdNSjVxTHRZY0t6bWVqa2JaTlh6QzZ4?=
 =?utf-8?B?Y0p3YTVSbkVIQ2dPcnRTNlNDWlFuU2loVGdCK1BNSG1VdGlERTRSTEVhOUYv?=
 =?utf-8?B?ZFF2YlRJd25HbDVPQ0FLdXYvc3hvTnVzMHVhVERqU1VqZVdpa0h3Qms4NUEy?=
 =?utf-8?B?OW1TclRqeWlzcFV5OUhhUS85cXNyaVM0dG5FWTVyTUVMVzY1QnRwSHppN1FR?=
 =?utf-8?B?V0pCU1d5RG1OL1dIYjY5VUkrd3pFeGU1dkMzZWlQZ1RVNnh5VVVpVEcvK3Fi?=
 =?utf-8?B?cnhlTnJ4WGx4bW4xSmM0MDMzUkZPVTJXbUUrdU1nalM3U2Z0QmZ1SlF5azE4?=
 =?utf-8?B?MDIzVTZILzBxelFTR1gxak1HSjRwR0hXMUJpMnZDbCtUa3ptVFVqN1R5bHVZ?=
 =?utf-8?B?RzBqRW02WVZRWFdiMUNZTXZ2WFBNMDFyOVA1OWJXeFpUMVpObW9jclVRM0tw?=
 =?utf-8?B?cTEzQWh4TG9Ec3ZJUkJlbzVFM0ZLdWc5VE9EOGZ1RVNHVytzSXlsazNnOHR1?=
 =?utf-8?B?TXNDN3RKUkJOTkhoOGZVOGc3b082UkJ6TldvbXBJSGx3aUE5VVZHUVJCSmJP?=
 =?utf-8?B?SVozUFZDTnFEdUFzQi9yK2NDUGdGNHAwNXNaVVJUWlNmNEVyNzZIU1VWaFFk?=
 =?utf-8?B?ZXVkR1hFUWFhZ0lFU0N0aDV0RVdLTlVTa1cyc0djc3BERldCQ1hrUGkxNEZh?=
 =?utf-8?B?VG5TMm9RY1VPa3pDOWo4bFZUR2F3WXc1RGw5aFQzbzdCU1YrVisrbkVaLzkx?=
 =?utf-8?B?c2JiZ0tUZlhZbkd6NXVaVXBvTVJvUGwxaGtUdGNXNTl0TTcrbXl4M2RpWG1R?=
 =?utf-8?B?ZHkxV1hzUFZzVWorZDg3MldoSmFNd0FNUEwvVEh1VldRWnB6b2QyY1J6N1FU?=
 =?utf-8?B?WUNtSGpQQ0d1UEs3a3NZV3JDV21zakNCYnB6ZWFOZ1RTcWxRUWpZQXJVQStU?=
 =?utf-8?B?Nmh4WTlXc3FxTkNaNHZCYkNLSWYraXF5UXZlOGw0NlI1cXdYZkVEY1hmNzJr?=
 =?utf-8?B?V082QlpPeHE0RHJkMTNpbFZ1MGp3TmNERmQrNC8xV1VpdFFZVWxSNHZGTUNj?=
 =?utf-8?B?WVRIY1dRelY2L2ZXRy9xWXVFWWZxVVh3WTV6amc1cENUKzlhVGJScEJ3MzBX?=
 =?utf-8?B?NFA2Z1VDNHUrbUc4UU5ob2FNNFRyWmp2T1JaMnA1ZkViTzhZSGl4SDQyOXVR?=
 =?utf-8?B?UXRZeDNCOE5OaDdGMFdGSmVudkY4L3ZlTjVXekZGOGh2a3ZHb2k3QWszRnZG?=
 =?utf-8?B?Y0Z0RkpHcjJNMVRDckRtWW1tM1U4K2VtekozTHgyNHBaS0dqMkhvK01QcmhO?=
 =?utf-8?B?TTNKam5IMW9hUHBEVkc2U3FTNzZjUVYrM0RGYWhEZUpwclhTbm5FQnNRNG1C?=
 =?utf-8?B?bWttdzBWK2JTK2xKK0NLb2paRmZBWGNrNHF6eXNVUDl4aWxmbzdKWFNvem5P?=
 =?utf-8?B?QzhzZVNQbHd1b1k0a2xHcEFycVlaWmVqcU1OQmUweGV0UllhQloxV21GSzRE?=
 =?utf-8?B?VXp4cDVNQlNMaDBHVmhDTHBUVi9aN1lBWXJmZ2MyN21jdCs4Vm03RU1YeG1o?=
 =?utf-8?B?azZnUFNaeFVKT0QxWkY0U2hBMDJVdkUwVXJjbzlMUGRNZXhXZzQzR3JDVzI2?=
 =?utf-8?B?OFAwYkRIY2xaSVprZFQ2NUNaNElHK1lOMWlMcHdLTnVURW1MSVl6RUROcXVM?=
 =?utf-8?B?TTJFVHo4SmVXQ2dnM3dMZklRc0F0SW9ncWFjSGgxMWR0M3RMZjhEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8726DFF0FBAFDD4CA81F2E7A54B85C88@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vcinity.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7183.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7a874f-b926-4833-0c5f-08df10116478
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:31:39.5260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aac3cb3b-f625-4cbc-ae65-2b4805bc1fa4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5HsttLDw8xNh8UK83Pfbj5pTwqSvvmHV6dKoJJgiKCvC9vxtZ5tHKp6oGtiSecXzzREegY+6c0LhNpKk5REPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR03MB989248

SSBoYWQgYSB2ZXJ5IGhhcmQgdGltZSBjcmVhdGluZyB0aGUgcmVxdWVzdCBJIHN1Ym1pdHRlZCwg
IGFuZCBkb27igJl0IGhhdmUgdGhlIHRpbWUgdG8gdHJ5IGFuZCBkbyB0aGF0IGFnYWluLg0KSWYg
eW91IHRoaW5rIGl0IGlzIGEgd29ydGh5IGNoYW5nZSB5b3UgY2FuIGluY29ycG9yYXRlIGl0IHNv
bWUgb3RoZXIgd2F5Lg0KDQoNCj4gT24gU2VwIDExLCAyMDI2LCBhdCA3OjEy4oCvQU0sIFNpbW9u
IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+DQo+IE9uIFRodSwgU2VwIDEwLCAy
MDI2IGF0IDExOjE3OjQ3QU0gLTA0MDAsIEd1bnRlciBXb3l0b3dpdHogd3JvdGU6DQo+PiBtYW5h
X2NyZWF0ZV9yeHEoKSByZWdpc3RlcnMgTUVNX1RZUEVfUEFHRV9QT09MIGZvciB0aGUgcnhxDQo+
PiB1bmNvbmRpdGlvbmFsbHksIHNvIGV2ZXJ5IGJ1ZmZlciBYRFAgY2FuIHNlZSBtdXN0IGJlIG93
bmVkIGJ5IHRoYXQNCj4+IHBhZ2VfcG9vbDogb24gWERQX1JFRElSRUNUIHRoZSBmcmFtZSBpcyBm
cmVlZCB0aHJvdWdoIF9feGRwX3JldHVybigpDQo+PiAtPiBwYWdlX3Bvb2xfcHV0X2Z1bGxfcGFn
ZSgpLg0KPj4NCj4+IG1hbmFfeGRwX3NldCgpIGFzc2lnbnMgYXBjLT5icGZfcHJvZyBiZWZvcmUg
Y2FsbGluZw0KPj4gbWFuYV9wcmVfYWxsb2NfcnhidWZzKCksIHdoaWNoIGFsbG9jYXRlcyB3aXRo
IGRldl9hbGxvY19wYWdlcygpLCBhbmQNCj4+IG1hbmFfZmlsbF9yeF9vb2IoKSBwcmVmZXJzIHRo
b3NlIGJ1ZmZlcnMgd2hlbmV2ZXIgbXBjLT5yeGJ1ZnNfcHJlIGlzDQo+PiBzZXQsIGxlYXZpbmcg
ZnJvbV9wb29sIGZhbHNlLiBTbyBmb3IgYSBwb3J0IHRoYXQgaXMgdXAgd2hlbiBhIHByb2dyYW0N
Cj4+IGlzIGF0dGFjaGVkLCB0aGUgZW50aXJlIHJlLWNyZWF0ZWQgcmluZyBpcyBmaWxsZWQgd2l0
aCBwYWdlcyB0aGUNCj4+IHBhZ2VfcG9vbCBkb2VzIG5vdCBvd24uDQo+Pg0KPj4gVGhlIHBhZ2Vf
cG9vbCB0aGVuIHNlZXMgcHBfcmVmX2NvdW50ID09IDAgd2hlbiBzdWNoIGEgZnJhbWUgaXMNCj4+
IHJldHVybmVkLCBzbyB0aGUgYXRvbWljX2xvbmdfc3ViX3JldHVybigpIGluIHBhZ2VfcG9vbF91
bnJlZl9uZXRtZW0oKQ0KPj4gZ29lcyBuZWdhdGl2ZSBhbmQgdHJpcHMgaXRzIFdBUk5fT04ocmV0
IDwgMCksIG9uY2UgcGVyIHJlZGlyZWN0ZWQNCj4+IGZyYW1lLiBPYnNlcnZlZCBvbiBhIDUuMTQt
YmFzZWQgZGlzdHJvIGtlcm5lbCwgd2hlcmUgdGhhdCB3YXJuaW5nIHNpdHMNCj4+IGF0IGhlbHBl
cnMuaDoyNjk6DQo+Pg0KPj4gIFdBUk5JTkc6IENQVTogMyBQSUQ6IDAgYXQgaW5jbHVkZS9uZXQv
cGFnZV9wb29sL2hlbHBlcnMuaDoyNjkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBfX3hkcF9yZXR1cm4rMHgyYjMvMHgyYzANCj4+ICBtYW5hX3Byb2Nlc3Nf
cnhfY3FlIC0+IG1hbmFfcnVuX3hkcCAtPiBtYW5hX3J4X3NrYiAtPiB4c2tfbWFwX3JlZGlyZWN0
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLT4gX194ZHBf
cmV0dXJuDQo+Pg0KPj4gT24gYSBWTSBib290ZWQgd2l0aCBjb25zb2xlPXR0eVMwIHRoZSByZXN1
bHRpbmcgc3RhY2sgdHJhY2VzIHBlZyB0aGUNCj4+IGNvbnNvbGUgdGhyZWFkIGFuZCB0aGUgbWFj
aGluZSBiZWNvbWVzIHVudXNhYmxlLg0KPj4NCj4+IEZpbGwgZnJvbSB0aGUgcGFnZV9wb29sIHdo
ZW4gYSBwcm9ncmFtIGlzIGF0dGFjaGVkLCB1c2luZw0KPj4gbWFuYV94ZHBfZ2V0KCkgLS0gdGhl
IHByZWRpY2F0ZSBtYW5hX2dldF9yeGJ1Zl9jZmcoKSBhbHJlYWR5IHVzZXMgdG8NCj4+IGNob29z
ZSB0aGUgWERQIGJ1ZmZlciBnZW9tZXRyeS4gV2l0aCBubyBwcm9ncmFtIGF0dGFjaGVkIG5vdGhp
bmcNCj4+IGNoYW5nZXMsIHNvIHRoZSBwcmUtYWxsb2NhdGlvbiBzdGlsbCBkb2VzIGl0cyBqb2Ig
b2Yga2VlcGluZw0KPj4gbWFuYV9hdHRhY2goKSBmcm9tIGZhaWxpbmcgb24gYWxsb2NhdGlvbi4N
Cj4+DQo+PiBMZWF2aW5nIHRoZSBwcmUtYWxsb2NhdGVkIGJ1ZmZlcnMgdW5jb25zdW1lZCBpcyBz
YWZlOg0KPj4gbWFuYV9wcmVfZGVhbGxvY19yeGJ1ZnMoKSBkbWEtdW5tYXBzIGFuZCBwdXRfcGFn
ZSgpcyB0aGUgcmVtYWluZGVyLA0KPj4gYW5kIGV2ZXJ5IGNhbGxlciAobWFuYV94ZHBfc2V0KCks
IG1hbmFfY2hhbmdlX210dSgpLCBhbmQgYm90aCBldGh0b29sDQo+PiByaW5nIGFuZCBjaGFubmVs
IHBhdGhzKSBhbHJlYWR5IHJ1bnMgaXQgYWZ0ZXIgbWFuYV9hdHRhY2goKS4NCj4+DQo+PiBUaGUg
cnhxLT54ZHBfc2F2ZV92YSByZXVzZSBpbiBtYW5hX2dldF9yeGZyYWcoKSBhbHNvIGxlYXZlcyBm
cm9tX3Bvb2wNCj4+IGZhbHNlLCBidXQgdGhhdCBjYWNoZSBpcyBmZWQgb25seSBieSB0aGUgZHJv
cCBwYXRoJ3Mgbm9uLXBvb2wgYnJhbmNoLA0KPj4gd2hpY2ggdGhpcyBjaGFuZ2UgbWFrZXMgdW5y
ZWFjaGFibGUgd2hpbGUgYSBwcm9ncmFtIGlzIGF0dGFjaGVkLCBzbw0KPj4gaXQgbmVlZHMgbm8g
Zml4Lg0KPj4NCj4+IEZvdW5kIGFuZCBmaXhlZCBvbiBhIDUuMTQtYmFzZWQgZGlzdHJvIGtlcm5l
bCBydW5uaW5nIEFGX1hEUCBvdmVyDQo+PiBNQU5BIGluIGNvcHkgbW9kZTogMjRNKyByZWRpcmVj
dGVkIGZyYW1lcyB3aXRoIG5vIHdhcm5pbmdzLCB3aGVyZSB0aGUNCj4+IHVucGF0Y2hlZCBkcml2
ZXIgd2FybmVkIG9uIGVzc2VudGlhbGx5IGV2ZXJ5IHJlZGlyZWN0ZWQgZnJhbWUuIEFsbCBvZg0K
Pj4gdGhlIGNvZGUgaW52b2x2ZWQgaXMgdW5jaGFuZ2VkIGluIG1haW5saW5lLg0KPj4NCj4+IEZp
eGVzOiBiMWQxM2Y3YTNiNTMgKCJuZXQ6IG1hbmE6IEFkZCBwYWdlIHBvb2wgZm9yIFJYIGJ1ZmZl
cnMiKQ0KPj4gU2lnbmVkLW9mZi1ieTogR3VudGVyIFdveXRvd2l0eiA8Z3VudGVyQHZjaW5pdHku
aW8+DQo+DQo+IFVuZm9ydHVuYXRlbHkgdGhlIENJIGZhaWxlZCB0byBhcHBseSB0aGlzIHBhdGNo
IHRvIG5ldC4NCj4gV2hpY2ggaXMgY3VyaW91cywgYmVjYXVzZSBJIGFtIGFibGUgdG8gYXBwbHkg
aXQgbG9jYWxseS4NCj4NCj4gQnV0IHBlcmhhcHMgaXQgd291bGQgYmUgYmVzdCB0byAocmViYXNl
IGFuZD8pIHJlcG9zdA0KPiBhZnRlciB3YWl0aW5nIGZvciB0aGUgdXN1YWwgMjRoWypdIHRvIGVs
YXBzZS4NCj4NCj4gWypdIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvbWFpbnRhaW5l
ci1uZXRkZXYuaHRtbA0KPg0KPiAtLQ0KPiBwdy1ib3Q6IGNoYW5nZXMtcmVxdWVzdGVkDQoNCg0K
VGhpcyBlbWFpbCBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kIHByaXZpbGVnZWQgaW5mb3Jt
YXRpb24gYW5kIGlzIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgYWRkcmVzc2Vl
KHMpLiBVbmxlc3MgeW91IGFyZSB0aGUgYWRkcmVzc2VlIG9yIGFyZSBhdXRob3JpemVkIHRvIHJl
Y2VpdmUgbWVzc2FnZXMgZm9yIHRoZSBhZGRyZXNzZWUsIHlvdSBtYXkgbm90IHVzZSwgY29weSwg
ZGlzc2VtaW5hdGUsIG9yIGRpc2Nsb3NlIHRoZSBpbmZvcm1hdGlvbiBvciBhbnkgYXR0YWNobWVu
dHMgdG8gYW55IHRoaXJkIHBhcnR5LiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGNvcnJlc3Bv
bmRlbmNlIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5k
IGRlbGV0ZSB0aGlzIGVtYWlsLiBZb3VyIGNvb3BlcmF0aW9uIGFuZCB1bmRlcnN0YW5kaW5nIGFy
ZSBncmVhdGx5IGFwcHJlY2lhdGVkLiBBdHRlbnRpb24gRmVkZXJhbCBDdXN0b21lcnM6IFBsZWFz
ZSBub3RlIHRoaXMgZW1haWwgcGxhdGZvcm0gaXMgTk9UIGFwcHJvdmVkIHRvIGNvbW11bmljYXRl
IChzZW5kIG9yIHJlY2VpdmUpIENVSS4gRm9yIHF1ZXN0aW9ucyBvbiB0aGUgYXBwcm92ZWQgc3lz
dGVtIHRvIGNvbW11bmljYXRlIENVSSwgcGxlYXNlIGNvbnRhY3QgeW91ciBkZXNpZ25hdGVkIFZj
aW5pdHkgUmVwcmVzZW50YXRpdmUuDQo=
