Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012054.outbound.protection.outlook.com [52.103.10.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626623F0A8C;
	Tue, 13 Oct 2026 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901389; cv=fail; b=VYDaizCitVz1ngoD2UiZ5fyWKajkyOCpBgK6pMZI6YzXHvtmKK1OFO4w4IKEJC1n9Rds+HgAQeDYLie4ZlwHOGkHxcHNBdZqAIuO5BThtl21MJBrUeDJ7EM7BU/tk4TbVAXODJr5DgsqGxxgVG/nYT18xbEzNe52J/uTTW7qaQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901389; c=relaxed/simple;
	bh=Cf936LCVtYMdN5B7F6WV8CRwbWcEqUQRA5K3Mn3t0cU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QcTUUuK/w4fLXpXxASegARy2KeVEITMMlDZfsJGQmj7MH5u0MZzXYytHP+tyAZh5uIYzpAAzZMjMz6Zyz2/xuxn5Ik2m+FVL5LH5Yz1F0QbpT0ab1HXo7sIhB/H8HmVlkubIluC8fHMwG97dDKNiEw7t72IlysrNSWiWfA0WVCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nFViFUOU; arc=fail smtp.client-ip=52.103.10.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nFViFUOU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCmgPhLKoWeWL8qnanbwdOpu04H11XV4L3AJLNbOiYIjx8i+c9TR5jydIXxTUOAkb6xOBDF3EYRMltkdiP4RNNWJZRh4pBzCW+6/s9LMWNeeMOWPFmguu/J3vTHBiBcD8kvUxuQzeLve50IdZ9KvsPdKw5OsVFU6+hrpxs3uDOpoBj+iTS7/NCuq/pTv6PxBCtjTLVKFfYK4ve+vCLz+C5v8B88dsXvIziZGlAP+EI7AbJ+HpzBOA06yQFGFgCZcoNTFN6nW27wIGVge3eugDzBpRfp9COHbZz5ZviGMnWagv86LT3BGYKvXmmJWIDDBhj1Bfj07cS2Ktb/lZeGeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf936LCVtYMdN5B7F6WV8CRwbWcEqUQRA5K3Mn3t0cU=;
 b=FUyDfT98OkLCBFAWCONXD+xPgZEjDYlyGxH2urvhIxSQ6czRtGGDeUZw+cXojAKKlNcrzX+WDH+iA13M0wj5bPcVGQjjetQwb8x7kA+Yri/n/3MX1ywtkku9dD3YPNJzlaA+dG46feIf5irjGXf+S0no/zau39BU5QerM0nMJmY/zRT48liHBeO6Unyim3G6BPepbGteq6PljtwEfnwFxxmEwH6T9Wzc0bOmQlC8JgT7wsg6oKjMKWlyIFj7ylBisngvqRMcgX+LfPRupPz6keYEyzNT9ZktP75tN6kHGO3HA7fYBdokWtqd2d6M8+baJnslokAaWRqUTgrFwO7kxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf936LCVtYMdN5B7F6WV8CRwbWcEqUQRA5K3Mn3t0cU=;
 b=nFViFUOUsV/9V6N4gxdVPXfv0JifXdF1P4G84yIgXo5xuzQPioLkzd6XCp5i9YrE0b0ANYtoaH0zI1sAzYISpSnNOx3XB9kKo1rihCJzuksdZD07VTcspZM7WwYd2+miXE4WezfAthE05u+RGopiwqiGNZvRZeREff9XcaYyQqHMEQ5BU4L7BHhwzp0APz5eAqaePt9NxXdHvDCdSe/7X+HCvlydGHek8JajYjamXtb+3swf0CHzlkC5e8wJyj2IG27zBIrjkB21vlDF7lRbPgtbShgz7oct3YN84CErf+r3FhwUPJtmiArvmZz2L/HCcJ6AtymEfwCJpjsgeqFITg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by MW6PR02MB9820.namprd02.prod.outlook.com (2603:10b6:303:23c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 14:23:06 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0522.012; Tue, 13 Oct 2026
 14:23:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
Thread-Topic: [PATCH v3 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
Thread-Index: AQK6UzDhe5HTrJmO78kNcIWbmlNys7VBNuqAgABfaZA=
Date: Tue, 13 Oct 2026 14:23:05 +0000
Message-ID:
 <MN2PR02MB6863BEA40F97A03E3E786C61D49E2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261013014354.18023-1-mhklinux@outlook.com>
 <14013a11-b9e4-4cf9-b4ff-3253d179c991@linux.microsoft.com>
In-Reply-To: <14013a11-b9e4-4cf9-b4ff-3253d179c991@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|MW6PR02MB9820:EE_
x-ms-office365-filtering-correlation-id: 8dd44e9f-c233-4495-496c-08df29357f90
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|37011999003|13091999003|31061999003|8062599012|19110799012|8060799015|15080799012|12121999013|25010399006|55001999006|24021099003|21061999006|102099032|440099028|3412199025|3071699003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnhXdDVBVGlFTVhHcDFXeENsRlBhTldlaklXK3JDOXBTNWh5RnN6UzlRanFP?=
 =?utf-8?B?Wi96WGQ3UHo0NkNDVlFoRW9Xa1NTM1VUTWJsUGl2OUVQTWlyRDdKaDJPR2Mx?=
 =?utf-8?B?STNLNTVCNXdIaDNSaDdzeEF2YXZiNDdBaCtiQkd0ZmswNENHQTVFTjRaUkxa?=
 =?utf-8?B?TTh0ZWpFcFhpOWtpdzNiY0Y3WGxjQ2ptWThHaEhQQ0FDOG9UeW1LdDJLaHdt?=
 =?utf-8?B?aEp5Q1FXR2lWWFNQMXhFRFVlOWM2OHJPaHBKdFBreEFxYnZOZnVndHNvUXoz?=
 =?utf-8?B?N2JvS0pNRHNoTjdiZmZDWE93N3UrYkJQMkRDR1lBZ0pWODNrcm9NdWlVaVdT?=
 =?utf-8?B?YnNDZ2J1NEF1bXBoODhnM2RGQlltZHdPUnZaeFduL1ZBSTBEbGxLTjRaQ2FD?=
 =?utf-8?B?VVRYWVBBbHhjcS9DZFN0cjRiVFUvTldva3BUU0h0aEZlMi8xajVEbW56VkNu?=
 =?utf-8?B?TVN1YjJHU2hZY0FQQ0QrSTRPaDNmUGUrREdqaWNwRXI3blVsSnJ4ZEEwcTAx?=
 =?utf-8?B?b1RvUTlqNWlYYzJlNWpHR0t2MHJRaGJ6Rnk3bnNVNHVHL2o2cVRad3I1SXN1?=
 =?utf-8?B?WXIvckpzMnY5L01DVjhUbGVWcUFRUUlpai9tanRsdWhheXlLSm9qSVNGRTZF?=
 =?utf-8?B?d052RzF0ZStjclNTUDhKK2M1amxpSmNaQ2lqSWZWSGozNVJER3NVbmlIVHEw?=
 =?utf-8?B?Uk90a2JSWU1zWjFwWElNVUsweW1kMlpnS3c5cUlJVmVHVHNMRlQ5enFNNHY5?=
 =?utf-8?B?VDRKNUZXd3dINjRZNjdIbmlkZXFmd2tDck8rSnRLSVRmd3BlRHVaejA3RzlW?=
 =?utf-8?B?bjZsNlhYeWJQN1NidlowVXBYbXlNVWVNUkJxUWRMWTdpTjBiZ3g4eHJZaVQ4?=
 =?utf-8?B?Z0pRNjBCelgyYWxUMnZOVHlPcTZ0bnMzV3dHMmg3N2NjREF4ZUJBbmVpcGFs?=
 =?utf-8?B?bE9lSVRjUlZ6ZUNEY20yWXNrWGFRUm1wbUpUMWRJVFE3VWJHbVdVZ3JrSmxU?=
 =?utf-8?B?Ry9iQXByb3QxOWcvR2I4eW95Nk5IZHFRRVJ6NkxndC9BYXczaTZnZUtuTUsy?=
 =?utf-8?B?VWJ2RWJXd09IQVFpOSthR2NiN0Ywb2QzZlJ0aEl1WnJ5MUcvT1EyUlZXNnIy?=
 =?utf-8?B?R3dsUmFSa0RLSFk4YnZxVkh3Q0l1SldNK0JtTGVNSHYrTWZlb0g4ekpMWS9l?=
 =?utf-8?B?ZE9JVVJUQ1lRcWJKVWJxemlBaFhSQ2FUbXFQYzNPYXhhcFBVSU1qNFFBb2Iy?=
 =?utf-8?B?UDBCd2FrRjFnbW1iaXVKa2JxaFhxM0FVWlNQcEk3M2syekprWWZjaWpBejVn?=
 =?utf-8?B?emswQ0VmMnhxVngzTmNWU2Jkd2pUWGlkTURMalRFRlg0cis5cGJrSnRqYjBP?=
 =?utf-8?B?dy9wRUdIVnIybXI3Vk4rMnJrdHAyb2hrOFpWbUFuWThubytRTlJPOFlYU25n?=
 =?utf-8?B?OWREb2gvdUd2VTJ3c3N5WUF6ZGlDOGZ3QXFBK0hOQlVjK1dxcUpKcEVoN3R0?=
 =?utf-8?Q?YJYI6LtN6B3us0RYDzjALKaTL7U?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkJhOTYzL1lRQVpUeVUyeE95cTZncUdYbGZhSnJRa2VZaVRSZHVBalQzb29x?=
 =?utf-8?B?aW8yejJRZ3ZiR3ZSVE4rV3JHMzJoTmdFUmxPeHVPeEJvYmU1M3dGUzNRRDVl?=
 =?utf-8?B?VVBadmx0MVVFRGJ5UXZzbWJlSGkra0M1L0E0dzk2SUhjcXZoQnp1MVRYRStS?=
 =?utf-8?B?ZlR2eStEWE92ZDd4ZHRSRCtXbk9JVzcyc1E1TFk2QzM4NFNST3pPQkFSeWFv?=
 =?utf-8?B?WWFVSWVyZGJEa2NJZW93MCtLaXBlZi9rd0ZXVEFENU9JMVhoM0dMMWx6aGxk?=
 =?utf-8?B?WHZnWmdQcmVoZE9TNDJzOFF2dG1JQ1AzQjZCNTNWcEJwRDJZUjJqNUVOOEN1?=
 =?utf-8?B?MXlnUmw1NTB5dllLQVJYejVUczRtanFVQlFlbUZmd2dWdC9GOU5KZVBrWDhh?=
 =?utf-8?B?aTAwNDdvUnIvbDFUMjFzK0tXWDFLZ1VmaHlyZmtsaDhlTkRvQi9oU3dJTm14?=
 =?utf-8?B?M0d0bkNPODZtMmJkN1FMcFFENk9jdTRrVmcyVTlXVnNqS3dtb25iQzExeEtv?=
 =?utf-8?B?UjBZdUxmZ3UwSS8wd09JQjRBYUh5RHdvTDFZUnNvR21rSUJPektVd2hydXhB?=
 =?utf-8?B?V1BsQ0IwSGhYWVd6MmtKVzBmd1FNWTBLUWVaQ3dMRXU1QlZZVTc0K1piSG5s?=
 =?utf-8?B?MU41dDVQakZFdHlQc0NISjExdlIzNmhzVEdvOC9YRzllUDZzMWgwNDhzalUy?=
 =?utf-8?B?ZmJyOHF2TnRscFJBR3kwd1dxYk12Z2FrYURSUjUzNC9DR1NZMFVNTlIxaGtU?=
 =?utf-8?B?RVpiU3QrTkw4NENpVjFBS25NbmZXNFBqSFVzTnBkR3A5aDJBL0Y2U2xJTHE0?=
 =?utf-8?B?TUx6cDhyY1V1eStrdFlEUGpTRG55YUg0QVc3em9XTVdiN2FSeXdyRXlHUS9V?=
 =?utf-8?B?ZEdNMklQSUpPeXRKaGRWTlVUU1pwcWZGcTRPNDhzdlhEMW94aTVweU1vOFZY?=
 =?utf-8?B?UVB3eVhEUVBFZTJuSWdsTzlhQldxbzBiM2xGd0xJT1g0U2tsYTkvc0RjWmZt?=
 =?utf-8?B?ampCT0hKUmpCMnNsSXZhMnprdnpDcWgvVUVaSkk1b2k2TWdZL21xcmZDT1Mv?=
 =?utf-8?B?dUFmUWlPWUlCa2VKSEQwNFRYR29iVDVaTTBPNmN4dmFWa0JtSDdjZmNlLzc5?=
 =?utf-8?B?dENXSEdMN2lyNCtJd0tMUWI4cVpMcXBKY1lHQ3VUWnhianVxdktIYm5FUTF2?=
 =?utf-8?B?aHNXeEhYNzNpVEYrQSt4ZXlqZnZVd2NlZE90M1V5QVdnNlFmcDZidVJ4S1Zk?=
 =?utf-8?B?Vm91WXVObnVucjlGd09LTlZsdWdQRklhTHR3M1Y3R29WMnZ6eldMUHFKRERu?=
 =?utf-8?B?SFpYQW1ickJoZEQ3UGNTdytxNHhtNFNzSVpjZUhrR004OTVwVktna3NZSzNo?=
 =?utf-8?B?eUVmMEZXWC92RGNRWjhWd3pGREE4dktBcUIyMlg5aWpDcUpiUHJLa2xJZkdh?=
 =?utf-8?B?a0JZeVdIUEJXUDZjbHhEanpDQkFId29lRWdibHlxN0tsTjFDeUdpdVZRakVT?=
 =?utf-8?B?a0Q5TDlSRG1tMDJoRUtHMXJPVzYybWJYcGZMckNONWFNNUJ0bTkzeUlaY1dv?=
 =?utf-8?B?NmRqNWxnNzVreWNUczdRTGtoN2xIeVhKSlZhUzA0OXRwMzE3MUEybzlleFZI?=
 =?utf-8?B?dFlVMWhlZHJjWExEU2o5UXMvOVQvSnhId3cyaUpkZFltQUkzMCs5R0k1WVV4?=
 =?utf-8?B?YXBUTTY1bnowNDZDYlg1MVVBbUdncll6anhOTDZGWVZWVnZ1SWFZZG9LVUZh?=
 =?utf-8?B?NHBPYWJPRUduc3NPdjlWOWNxSng0LzZ6VlV4a3lRTkZlN0lmbVN3V040eGU4?=
 =?utf-8?Q?6sc11U88rgCgaRDbVDXH/89QQOG9OuNtNI0AQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd44e9f-c233-4495-496c-08df29357f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 14:23:05.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9820

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUdWVz
ZGF5LCBPY3RvYmVyIDEzLCAyMDI2IDE6NDIgQU0NCj4gDQo+IE9uIDEwLzEzLzIwMjYgNzoxMyBB
TSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gVGhlIGZ1bmN0aW9ucyBmb3Igc2VuZGluZyBW
TUJ1cyBwYWNrZXRzIGhhdmUgY2hhbmdlZC4NCj4gPiB2bWJ1c19zZW5kcGFja2V0X21wYl9kZXNj
KCkgY2FuIHRhcmdldCBtdWx0aXBsZSByYW5nZXMsIGFuZA0KPiA+IHZtYnVzX3NlbmRwYWNrZXRf
cGFnZWJ1ZmZlcigpIGhhcyBiZWVuIHJlbW92ZWQuIHZtYnVzX3NlbmRwYWNrZXRfZ2V0aWQoKQ0K
PiA+IGhhcyBiZWVuIGFkZGVkLiBVcGRhdGUgdGhlIGRvY3VtZW50YXRpb24gYWNjb3JkaW5nbHku
DQo+ID4NCj4gPiBGaXhlczogNDVhNDQyZmUzNjllICgiRHJpdmVyczogaHY6IHZtYnVzOiBSZW1v
dmUgdm1idXNfc2VuZHBhY2tldF9wYWdlYnVmZmVyKCkiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91
dGxvb2suY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gKiBGaXhlZCB0eXBv
IGluIHRoZSBkb2N1bWVudGF0aW9uIHRleHQgW1Nhc2hpa29dDQo+ID4NCj4gPiBDaGFuZ2VzIGlu
IHYyOg0KPiA+ICogQWRkIHZtYnVzX3NlbmRwYWNrZXRfZ2V0aWQoKSB0byB0aGUgZG9jdW1lbnRh
dGlvbi4gW05hbWFuIEphaW5dDQo+ID4NCj4gPiAgIERvY3VtZW50YXRpb24vdmlydC9oeXBlcnYv
dm1idXMucnN0IHwgMTcgKysrKysrKysrLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi92aXJ0L2h5cGVydi92bWJ1cy5yc3QgYi9Eb2N1bWVudGF0aW9uL3ZpcnQvaHlw
ZXJ2L3ZtYnVzLnJzdA0KPiA+IGluZGV4IDY1NGJiNDg0OTk3Mi4uYzU0NmU4MjFjZTZiIDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vdmlydC9oeXBlcnYvdm1idXMucnN0DQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi92aXJ0L2h5cGVydi92bWJ1cy5yc3QNCj4gPiBAQCAtMTQxLDE0ICsx
NDEsMTUgQEAgVGhyZWUgZnVuY3Rpb25zIGV4aXN0IHRvIHNlbmQgVk1CdXMgY2hhbm5lbCBtZXNz
YWdlczoNCj4gPg0KPiA+ICAgMS4gdm1idXNfc2VuZHBhY2tldCgpOiAgQ29udHJvbC1vbmx5IG1l
c3NhZ2VzIGFuZCBtZXNzYWdlcyB3aXRoDQo+ID4gICAgICBlbWJlZGRlZCBkYXRhIC0tIG5vIEdQ
QXMNCj4gPiAtMi4gdm1idXNfc2VuZHBhY2tldF9wYWdlYnVmZmVyKCk6IE1lc3NhZ2Ugd2l0aCBs
aXN0IG9mIEdQQXMNCj4gPiAtICAgaWRlbnRpZnlpbmcgZGF0YSB0byB0cmFuc2Zlci4gIEFuIG9m
ZnNldCBhbmQgbGVuZ3RoIGlzDQo+ID4gLSAgIGFzc29jaWF0ZWQgd2l0aCBlYWNoIEdQQSBzbyB0
aGF0IG11bHRpcGxlIGRpc2NvbnRpbnVvdXMgYXJlYXMNCj4gPiAtICAgb2YgZ3Vlc3QgbWVtb3J5
IGNhbiBiZSB0YXJnZXRlZC4NCj4gPiAtMy4gdm1idXNfc2VuZHBhY2tldF9tcGJfZGVzYygpOiBN
ZXNzYWdlIHdpdGggbGlzdCBvZiBHUEFzDQo+ID4gLSAgIGlkZW50aWZ5aW5nIGRhdGEgdG8gdHJh
bnNmZXIuICBBIHNpbmdsZSBvZmZzZXQgYW5kIGxlbmd0aCBpcw0KPiA+IC0gICBhc3NvY2lhdGVk
IHdpdGggYSBsaXN0IG9mIEdQQXMuICBUaGUgR1BBcyBtdXN0IGRlc2NyaWJlIGENCj4gPiAtICAg
c2luZ2xlIGxvZ2ljYWwgYXJlYSBvZiBndWVzdCBtZW1vcnkgdG8gYmUgdGFyZ2V0ZWQuDQo+ID4g
KzIuIHZtYnVzX3NlbmRwYWNrZXRfZ2V0aWQoKTogU2ltaWxhciB0byB2bWJ1c19zZW5kcGFja2V0
KCkgYnV0IHJldHVybnMNCj4gPiArICAgYSB0cmFuc2FjdGlvbiBJRCB0aGF0IGlzIG1hdGNoZWQg
YWdhaW5zdCBhIHJlcGx5IGZyb20gdGhlIEh5cGVyLVYNCj4gPiArICAgaG9zdC4gVXNlZnVsIHdo
ZW4gdGhlIHN0cnVjdCBjb21wbGV0aW9uIChvciBvdGhlciByZW5kZXp2b3VzIGRhdGEpDQo+ID4g
KyAgIG11c3QgcmVzaWRlIG9uIHRoZSBjYWxsZXIncyBzdGFjay4gQnkgaW52YWxpZGF0aW5nIHRo
ZSB0cmFuc2FjdGlvbg0KPiA+ICsgICBJRCBiZWZvcmUgZXhpdGluZyB0aGUgZnVuY3Rpb24gZHVl
IHRvIGEgdGltZW91dCBvciBvdGhlciBlcnJvciwgYQ0KPiA+ICsgICBsYXRlIGFycml2aW5nIGlu
dGVycnVwdCBpcyBhc3N1cmVkIHRvIG5vdCB0cmFzaCB0aGUgc3RhY2suDQo+ID4gKzMuIHZtYnVz
X3NlbmRwYWNrZXRfbXBiX2Rlc2MoKTogTWVzc2FnZSB3aXRoIG9uZSBvciBtb3JlIGRhdGEgcmFu
Z2VzDQo+ID4gKyAgIHRvIHRhcmdldC4gRWFjaCByYW5nZSBjb25zaXN0cyBvZiBhIHNpbmdsZSBv
ZmZzZXQgYW5kIGxlbmd0aCBwbHVzDQo+ID4gKyAgIGEgbGlzdCBvZiBHUEFzIHRoYXQgZGVzY3Jp
YmUgYSBsb2dpY2FsIGFyZWEgb2YgZ3Vlc3QgbWVtb3J5Lg0KPiA+DQo+ID4gICBIaXN0b3JpY2Fs
bHksIExpbnV4IGd1ZXN0cyBoYXZlIHRydXN0ZWQgSHlwZXItViB0byBzZW5kIHdlbGwtZm9ybWVk
DQo+ID4gICBhbmQgdmFsaWQgbWVzc2FnZXMsIGFuZCBMaW51eCBkcml2ZXJzIGZvciBzeW50aGV0
aWMgZGV2aWNlcyBkaWQgbm90DQo+IA0KPiBXZSBjYW4gcmV0YWluIHRoZSByZXZpZXcgdGFncyBm
b3IgbWlub3IgZWRpdHMuDQo+IA0KPiBSZXZpZXdlZC1ieTogTmFtYW4gSmFpbiA8bmFtamFpbkBs
aW51eC5taWNyb3NvZnQuY29tPg0KDQpJIGp1c3QgZm9yZ290IHRvIGNhcnJ5IHlvdXIgcHJldmlv
dXMgUi1iIHRhZyBmb3J3YXJkLiA6LSggIFRoYW5rcyBmb3INCmRvaW5nIGl0IGFnYWluLg0KDQpN
aWNoYWVsDQo=
