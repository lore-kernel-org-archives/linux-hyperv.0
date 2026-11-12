Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794451203;
	b=j9XrEscSa0lEi2CFmO3kdI5lQQmnJFj01M7xnakSPOPUZ4cXCiaSE0hppS7YgIbi9P3m
	 NyagRqv4QH3gQtJvZ+ClT0zPV8OKU7qCCsHAH2wP3Pj7VreqEQKgfDwZ5/mb+XvKDs/qO
	 sDYBcygt4V35sUvPM88HPk5ny8m3C3TnH3yksLVuWvl3d74MKKiPhoxpIH4astwKTc2/V
	 pY3TMHb7dCOg2a12Yo9QVIKzX4Lo7MtCH9aPMusE3NzMHyLNNTIZ9TmgdwL4XHppHzoAH
	 NblJbRz7NfATI8in7wuBdwYzkABO11oVZrD1WOCD5jYIptCRXtvcJBQs7JA4k64ki8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451203;
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
	bh=3w9gf/ItyABA8bo4jbaPDeMi3wa7RwQaNGz6XjRHg4E=;
	b=iBgvFYNaQphWROy+SMsVAqfQz+BmO7Gvr6Qdxo1yQ9hgrJNZcUOkM2Q0ng/9nLTtAPHH
	 wt8H3pPsquSLvJ/MqNjoq+fv6K7+pcjOJzJqD7ijfckovXV1jURpjZZC8Xf5Ek8UXQUyk
	 8wU2mQyRoAxmJlxJO5Nzm55PB+r/k+he8GAZK+Nixhs6t+5ThrbY6sXY8lNtxUgDSIO0k
	 75KbT+Be4aFpq/NvtjyWG92PftrhuA+GUB23vBaAcww2eSy6hpQlAroWkYtjC1Ikvhy+u
	 7FqKqETYH/uYBhn1jBbk+9KKE9v0l21bSiAeB4tAap3j2SjyGH1FacOihJCSGgViTBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=GKXYjdxk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012071.outbound.protection.outlook.com [52.103.14.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F653606A332;
	Thu, 12 Nov 2026 02:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F653606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=GKXYjdxk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEprq658Dz36Niqvl3shRzSLl/1eUyNSIhVkS1Z6t8TU3crCUghziZCQ2OrZckIBLsJBiC8+hmNIu/0w3+i3lRn3duAeFJksZ/7tUpWM1KcB5nWLipcC3zHPPjBt7h3L5KPr9g0NaoWJ6iq/edoE/Mzo+KqIxPGV5txYV29zun/s5V0r3Ae/JWsDuadocvQ8x7EVNHhRQ/y8GjeR5Ejl9Nqoos/UYdliElDILjjpn9nmKSq8Mw/n1DZhnikQ5cfghuZm7xN30I/nG9n42ocHi4AwSQXQkXEArexkHtQHw188mZW6nLfp02Nfm1cW8rDC4decb9zvv7Qrj5g3McDEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w9gf/ItyABA8bo4jbaPDeMi3wa7RwQaNGz6XjRHg4E=;
 b=EQ50EAXu7japJ2ewDtLC9PXUnOTZD/HGjpnxM/ew0I8ZX5E45jb/QDxwA1UwseAGnayqXbP50a092MJU4KFcpImiyaq6SsCGwCU7fXQTLmVPojRd2m73PxIolz8O4XbJomhxTPh4yRnADS2zibqBuD7HJIM4G+rNL6P+bcBun6S1UIko315pboVW8JXC0EiIEQXRYzaVu+sMIcbVJDTpRhKvPyCBbHFWrZCUOpceREJm9QVGNeL7NafeyWDoNvD2x2/iLI3OIEKwaMGCySjzAfSuTuhsz/LkRRxlxoUGJj6BsTwpQ25NcK4+fridRi/k9gQxe1tNqtC/bhrlhHtBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w9gf/ItyABA8bo4jbaPDeMi3wa7RwQaNGz6XjRHg4E=;
 b=GKXYjdxkFE9mjmnmvFaBFstIZz6MQyuJCwAM/sOPM+5Gf37HOrys/OvI/ZJyqCsCmFSRk4GzBpBNd6k8CgmJUagOPXkZDNTnVmC7ysIFolFD0mMzMxot2TMmApuY5kqFmVQkJIERV7qV6XY4zvUiarETgnpR9yfS654SsgsZjXsJN6G6qpcIQQGwsloUeGQ5uaK41yO6ys6E8NL0RdgUOEBzJYoL1ADKrIl5ozTyPVWQCN2Swf+3GNZ0wEs5y6NmoUcM4A8ujR3vFwZinhCBzC3Y3wuI4RAQs43PCRG9eiJ3QOc1FeComIgyWQq3NB4fI+WvTxLnhNfPdwA+mt8I2g==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA4PR02MB091122.namprd02.prod.outlook.com (2603:10b6:207:102::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 02:39:59 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 02:39:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Mukesh R
	<mrathor@linux.microsoft.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"sudeep.holla@kernel.org" <sudeep.holla@kernel.org>, "thuth@redhat.com"
	<thuth@redhat.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Topic: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Index: AQHdaMzUW+ALWywyUk+4CFfjEacMarcpO6KAgABNFYCAAEPlkA==
Date: Thu, 12 Nov 2026 02:39:59 +0000
Message-ID:
 <MN2PR02MB68633B97567EE210F12A5111D4702@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
 <MN2PR02MB6863AA6357C8E0D4881F5FEAD4712@MN2PR02MB6863.namprd02.prod.outlook.com>
 <5d9dccba-61b0-4fac-8dc2-f09ce630157e@linux.microsoft.com>
In-Reply-To: <5d9dccba-61b0-4fac-8dc2-f09ce630157e@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA4PR02MB091122:EE_
x-ms-office365-filtering-correlation-id: d3dc07a9-d07a-4e9f-e3b2-08df40663ed5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|51005399006|19110799012|12121999013|41001999006|37011999003|15080799012|13091999003|55001999006|25010399006|31061999003|24021099003|102099032|440099028|3412199025|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkM2a0N5MWV3SmZxQ1BpL2ZxZ2VPRXNENWQ1ZVlIam1tV0hYTWNZUlB3Qmtm?=
 =?utf-8?B?bitXS2hHT3gwenFKUGtiZDVPdXNENnJyY1BGMjdnYkh5WExkL1k3RXlwYkt2?=
 =?utf-8?B?NXZ6V2R3M25pYUFiUlFKaTY1L0JuK3FYbmtrbTZhc1h4RENUYzlBNnE0Yy9Y?=
 =?utf-8?B?Mnl0QXlZNlJTSTg0MUtGSzlwaUtIazAwSlA1dm9wYVRjbkZrMG05VnErUnh1?=
 =?utf-8?B?TXBNeXB2RE9KUXd5aEZiOW11OGtNTVJGWUZjL2ZhQ3ZVTVcxdWg1Q2xOcE9m?=
 =?utf-8?B?RUZ1bWthY2NScXlZK2Q4aW0rMmc4N2sydm03Qk9KSWZpeVpISHZjVEVaTDJW?=
 =?utf-8?B?OXF2RDVmb1V0MEV1SFVCZnQvaDZFVGtMa3N1NTRtbjJBZWxvbW9tOXhyUzdp?=
 =?utf-8?B?cW9xbS9HeXJzWlNrSkY2b3dIa3hkM2t1eENOVVY5UzM2elVSRWxaM2txMTZW?=
 =?utf-8?B?TXBjYmxJdXllYmtTVmxsRElIbGpFd2JkT2ZpTEZabm1TUlYrZ1RSc1c0a3F0?=
 =?utf-8?B?QXlnNmVmWjNLaEFBMWtJeXRIckhNcGNCdTRIOUUxLysvZFNxeFlQT2VkNE52?=
 =?utf-8?B?YWx0SHlabWkyZjV3d3A0NC8zSXR2bnVBZGFZVHJ0UERaY2FXVjdzZUZ6QURs?=
 =?utf-8?B?MldUTDFKRXpKcThmR3dkUmpIVVJaYzNmdnNqSEpiQkxReXRLckptYWtTSWk2?=
 =?utf-8?B?NjNZZHlCSklERnBWcmtXN2JFZldrZFFpdlA5ZG1rMjJEdmltZGFjTnA3Vmwx?=
 =?utf-8?B?TXlRb3NUdXJBVDNCRUpnUjF0ZUxtWStHaUtyZDZpZDZjbitmUlNUbE5ib2t6?=
 =?utf-8?B?VkVsRWdGWkV2Q2dyVjNQL3lzWjhsVDhudXllbW1VdGtYYnZJV3JiLzU1eEM5?=
 =?utf-8?B?akhUcVhSdlI1MlYraVhUWWRvZExxWTV4dHUzUmNMNGRaczlwaUFDQVNnR1ZE?=
 =?utf-8?B?bFpLejVOV0hqSFdqVHFXSW95MzJhVDJtalZBbE96WXh1RHJoTkJVVzFtbjRW?=
 =?utf-8?B?TkxCOWRDb3N4WWlvWkZGVThzclVGZGlKTlZySC9seVF2dm02M20wYTg1alRx?=
 =?utf-8?B?YUtPc1FDVjljZnUrQUdZaFRWUDk3ZGFza0NjYnhxVW1Ta2FLMmZwOGJUelQ5?=
 =?utf-8?B?LzNaSldqM2x4ZkFkWFZYS0Z1THUvK3U4TlBtdTVpRnJxSU01REgxN0h1ZzUw?=
 =?utf-8?B?aXhxK1ViUzRWMkRQV3cvYlYweXRGcm11bDZaVW1lTjFzb3JNekkwc1FmT1Zv?=
 =?utf-8?B?aGtsZmZXd00wSDJ6cTFjT1o1M3ZPK1NqTnJsU25zdjBWcldad09OZFl6MGhn?=
 =?utf-8?B?d0pNSzFNR0dKQVdSN3pIT1h3UEZuS1dISFVuMzBjTlFFYzM0SmlIWk9ydXJn?=
 =?utf-8?B?b0NKY0h4c0hsYVdtWUQ5QUttTGdIcTIrcTBFRW1QQm9QMkpOOUVCMlJkUUJJ?=
 =?utf-8?B?TnMzcnlJY1B5eThkMUJQWEcwNjdNSEM5SDZYenJrQUplaXFSOG9tN084UW1R?=
 =?utf-8?Q?ETFQm4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elVvNWd4T1dqRklXU0hHcjhlS1RJOHhIaTNOWlhzV3pURXgzS1RTKzFSUHhz?=
 =?utf-8?B?QXlNWmplUU5XZWtKZW5RcWRPb3hpUUNhbytEcTZHa1kxb0JJWGdwQnV6NXZD?=
 =?utf-8?B?WjFOSHFmLzVxbGFaUGx6azVzK3ZJZmc4eEpWMDc2UmZqVEtIUnVYdk8raEVB?=
 =?utf-8?B?MmxOa2FBcjRhbXZtajRCZGV4MUpqRUZNV0dSQkxMZTQrWkhBR3N1b3FpaitO?=
 =?utf-8?B?U3ZnL0tDS0ZiUTlTLzVTK2FTcksrUWdCTC9qS1NHUmp2ZnlKY2ErZ0JGYi80?=
 =?utf-8?B?bFExUWxlMzNacDkxcDM3L1lZQ2xsNytFZ2NsS01ubldmaTlFLzRxNytPWWQ3?=
 =?utf-8?B?MUdjWEZJcGJGNHhMNnRadmV2YmM2TW1tQ1Y1dkEzNEtGdVFDUFBQMU83cWZI?=
 =?utf-8?B?Z05aa2xZWkV2ZXY2b1JvVy9ibmNTaFhnNHpDSEE0aHc3Qk40NlVBMnQxd2w5?=
 =?utf-8?B?RURZLzRnWDdoYnhVU1ErMURoOHhNMGF3M0l0NkhSM2hTaXFjbG5hR3BqUUl5?=
 =?utf-8?B?TWRpR0R0cGJWWG5VSi8yQlErQ3gyUzJiNDFFbXNKeG1IdzBBSEF1RlNZNVcx?=
 =?utf-8?B?dEI2c0VISkRHSFlGU3UyTEJuNitEdEdLYnczWWdTMktoTnBtZlUvNGhudHJH?=
 =?utf-8?B?THdVaXorY3dHNERSSXFzVG9DcWlDbjdpbE11eU9CeTVZOWNsZkdiV2Y1TmFZ?=
 =?utf-8?B?Z29XQ0ZDSFZPTGI4cWlkVDUveEN2YXNtWVBpVldEV3FaVDl0RkVvcmU0d1c2?=
 =?utf-8?B?YS8zZzh4OXR4c29Sa2c2N3dQWnhYenVWK0U0ZkJ1TEtkT1J2M1VwbmhtWWt4?=
 =?utf-8?B?bllCTjA1UmtSUzMxYi92T0Iwckw1TmNSRmlXSnhoM1hlMHFMZ0srakx2QVpz?=
 =?utf-8?B?eUQxK3EwcThkK2ltUGh0Y2V4MGZHQzhZQlp0SlczRjhpUTJnT21LSGFCRVdm?=
 =?utf-8?B?bjI0ZkZiQVBOWGJUdnhUcVliaVVNSjg0U296YzUvWTdDOEI1Sk41V1ZLZEsx?=
 =?utf-8?B?RFNZcGFaNWR0YUhwT1U2VjhvbFp6bWlVRGdpdzl4WWMzaXVDMGk3ZThick5i?=
 =?utf-8?B?elgrMlNSVFJ5NW9hVEM4Sm82NktzVXJWQWxSRjdoai9PbUxKYU9NMHlHR3Ry?=
 =?utf-8?B?bEo4M2ljSU02MUlYTHJ6MDRpMCtsZk9seUIvNWg3bERkQjZkZ2E3VWNIUlRj?=
 =?utf-8?B?S3ZaUHVPUE9mb0w2c2UwN1VrZkR1V2RHTHFmN1lPRkh1WnJvRGdKUUFVbTRY?=
 =?utf-8?B?bXFQTEc0UklSOWZCcWE4cko0TUI3R0RqSXc1dm92NU5iaFVSNjVieVVSUTRE?=
 =?utf-8?B?d3ZkZ0hnWUY3TGZTdm5NR3c3STZ2a29vdWNXVy9yUXZmWUhJUkdGUm1DdEJT?=
 =?utf-8?B?djBvR3piNGF3b3Qwejh5NEV0MGpkK3ZXb1FNb3VlcUJsWnBhUDVSRHdtcmxm?=
 =?utf-8?B?VHNpU1kwYXZvbUFwNDh5OUMvSktWdlI2V0QwMVJBMTY0Tk1jYm5JdFFBV0dz?=
 =?utf-8?B?RnFLelJuTlJqQmFWeVNnU0loeWIwQ1h2Znlza21NckhyZHErM3BsSFBKZ3gz?=
 =?utf-8?B?YTZmbkVQeWo3VVJaMHAvTUltckRHVDNocXZQTUp1SlVwMGc0Wmx5K0NFUHNl?=
 =?utf-8?B?QW5NOFhUK3hmRVhCdDJvK0ZWTzV0ZHJ3TmdSSVBGY1NXNzNCY2I5cmw4ZElV?=
 =?utf-8?B?cXB6dzNuZjVqMFpXRGt6RUpoOGpWMkhwODZ0MnJLZFBoMjhDZk9ncjhuL1Z6?=
 =?utf-8?B?cnRnalczdStGdFV1L21qaTdJeXU4bVk1Qmsya0tNSXU1RjluWURVdlFCWTR0?=
 =?utf-8?Q?ZZX2n0PclHgq4vBK+l9DLBkKTeN+7g2B2o6pY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dc07a9-d07a-4e9f-e3b2-08df40663ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 02:39:59.4147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR02MB091122

RnJvbTogS2FtZXJvbiBDYXJyIDxrYW1lcm9uY2FyckBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50
OiBXZWRuZXNkYXksIE5vdmVtYmVyIDExLCAyMDI2IDI6MzcgUE0NCj4gDQo+IE9uIDExLzExLzIw
MjYgMTA6MDEgQU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IEthbWVyb24gQ2Fy
ciA8a2FtZXJvbmNhcnJAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5LCBPY3RvYmVy
IDMwLCAyMDI2IDU6MTQgUE0NCj4gPj4NCj4gPj4gSW4gaHZfY29tbW9uX2NwdV9pbml0KCksIHRo
ZSBwZXItQ1BVIGh5cGVyY2FsbCBpbnB1dC9vdXRwdXQgcGFnZXMgbmVlZA0KPiA+PiB0byBiZSBt
YXJrZWQgYXMgZGVjcnlwdGVkIChzaGFyZWQpIGZvciBjb25maWRlbnRpYWwgVk0gaXNvbGF0aW9u
IHR5cGVzLg0KPiA+PiBUaGlzIGlzIGFscmVhZHkgZG9uZSBmb3IgU05QIGFuZCBURFggaXNvbGF0
aW9uOyBleHRlbmQgdGhlIHNhbWUgaGFuZGxpbmcNCj4gPj4gdG8gQXJtIENDQSBSZWFsbSBndWVz
dHMgc28gdGhhdCB0aGUgaG9zdCBoeXBlcnZpc29yIGNhbiBhY2Nlc3MgdGhlDQo+ID4+IHNoYXJl
ZCBoeXBlcmNhbGwgYnVmZmVycy4NCj4gPj4NCj4gPj4gaXNfcmVhbG1fd29ybGQoKSBpcyBkZWNs
YXJlZCBpbiBpbmNsdWRlL2xpbnV4L2FybS1yc2ktY21kcy5oIHdoaWNoIG9ubHkNCj4gPj4gYnVp
bGRzIG9uIGFybTY0IChpdCBpbmNsdWRlcyA8YXNtL21lbW9yeS5oPiksIHNvIHVzaW5nIGl0IGRp
cmVjdGx5IGluDQo+ID4+IHRoZSBhcmNoLW5ldXRyYWwgZHJpdmVycy9odi9odl9jb21tb24uYyB3
b3VsZCBicmVhayB0aGUgeDg2IGJ1aWxkLg0KPiA+PiBJbnRyb2R1Y2UgYSBIeXBlci1WLXNwZWNp
ZmljIGhlbHBlciBmb2xsb3dpbmcgdGhlIGVzdGFibGlzaGVkDQo+ID4+IGh2X2lzb2xhdGlvbl90
eXBlX3NucCgpIC8gaHZfaXNvbGF0aW9uX3R5cGVfdGR4KCkgcGF0dGVybi4NCj4gPj4NCj4gPj4g
T24gYXJjaGl0ZWN0dXJlcyBvdGhlciB0aGFuIGFybTY0IHRoZSB3ZWFrIGRlZmF1bHQga2VlcHMg
dGhlIGV4aXN0aW5nDQo+ID4+IGJlaGF2aW91ci4NCj4gPj4NCj4gPj4gUmV2aWV3ZWQtYnk6IE1p
Y2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
S2FtZXJvbiBDYXJyIDxrYW1lcm9uY2FyckBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+PiAtLS0N
Cj4gPj4gIGFyY2gvYXJtNjQvaHlwZXJ2L21zaHlwZXJ2LmMgICB8ICA1ICsrKysrDQo+ID4+ICBk
cml2ZXJzL2h2L2h2X2NvbW1vbi5jICAgICAgICAgfCAxNyArKysrKysrKysrKysrLS0tLQ0KPiA+
PiAgaW5jbHVkZS9hc20tZ2VuZXJpYy9tc2h5cGVydi5oIHwgIDEgKw0KPiA+PiAgMyBmaWxlcyBj
aGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9oeXBlcnYvbXNoeXBlcnYuYyBiL2FyY2gvYXJtNjQvaHlwZXJ2
L21zaHlwZXJ2LmMNCj4gPj4gaW5kZXggNDZhYjJkYS4uZGE2YzNhYTAgMTAwNjQ0DQo+ID4+IC0t
LSBhL2FyY2gvYXJtNjQvaHlwZXJ2L21zaHlwZXJ2LmMNCj4gPj4gKysrIGIvYXJjaC9hcm02NC9o
eXBlcnYvbXNoeXBlcnYuYw0KPiA+PiBAQCAtMTgyLDMgKzE4Miw4IEBAIGJvb2wgaHZfaXNfaHlw
ZXJ2X2luaXRpYWxpemVkKHZvaWQpDQo+ID4+ICAJcmV0dXJuIGh5cGVydl9pbml0aWFsaXplZDsN
Cj4gPj4gIH0NCj4gPj4gIEVYUE9SVF9TWU1CT0xfR1BMKGh2X2lzX2h5cGVydl9pbml0aWFsaXpl
ZCk7DQo+ID4+ICsNCj4gPj4gK2Jvb2wgaHZfaXNvbGF0aW9uX3R5cGVfY2NhKHZvaWQpDQo+ID4+
ICt7DQo+ID4+ICsJcmV0dXJuIGlzX3JlYWxtX3dvcmxkKCk7DQo+ID4+ICt9DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2h2L2h2X2NvbW1vbi5jIGIvZHJpdmVycy9odi9odl9jb21tb24uYw0K
PiA+PiBpbmRleCAzMTI1NmNiLi5hNjBjOTJjIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2h2
L2h2X2NvbW1vbi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvaHYvaHZfY29tbW9uLmMNCj4gPj4gQEAg
LTQ3Niw2ICs0NzYsNyBAQCBpbnQgaHZfY29tbW9uX2NwdV9pbml0KHVuc2lnbmVkIGludCBjcHUp
DQo+ID4+ICAJdTY0IG1zcl92cF9pbmRleDsNCj4gPj4gIAlnZnBfdCBmbGFnczsNCj4gPj4gIAlj
b25zdCBpbnQgcGdjb3VudCA9IGh2X291dHB1dF9wYWdlX2V4aXN0cygpID8gMiA6IDE7DQo+ID4+
ICsJY29uc3Qgc2l6ZV90IGFsbG9jX3NpemUgPSBBTElHTigoc2l6ZV90KXBnY291bnQgKiBIVl9I
WVBfUEFHRV9TSVpFLCBQQUdFX1NJWkUpOw0KPiA+PiAgCXZvaWQgKm1lbTsNCj4gPj4gIAlpbnQg
cmV0ID0gMDsNCj4gPj4NCj4gPj4gQEAgLTQ4OSw3ICs0OTAsNyBAQCBpbnQgaHZfY29tbW9uX2Nw
dV9pbml0KHVuc2lnbmVkIGludCBjcHUpDQo+ID4+ICAJICogb25saW5lIGFuZCB0aGVuIHRha2Vu
IG9mZmxpbmUNCj4gPj4gIAkgKi8NCj4gPj4gIAlpZiAoISppbnB1dGFyZykgew0KPiA+PiAtCQlt
ZW0gPSBrbWFsbG9jX2FycmF5KHBnY291bnQsIEhWX0hZUF9QQUdFX1NJWkUsIGZsYWdzKTsNCj4g
Pj4gKwkJbWVtID0ga21hbGxvYyhhbGxvY19zaXplLCBmbGFncyk7DQo+ID4+ICAJCWlmICghbWVt
KQ0KPiA+PiAgCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4+DQo+ID4+IEBAIC00OTksMTQgKzUwMCwx
NiBAQCBpbnQgaHZfY29tbW9uX2NwdV9pbml0KHVuc2lnbmVkIGludCBjcHUpDQo+ID4+ICAJCX0N
Cj4gPj4NCj4gPj4gIAkJaWYgKCFtc19oeXBlcnYucGFyYXZpc29yX3ByZXNlbnQgJiYNCj4gPj4g
LQkJICAgIChodl9pc29sYXRpb25fdHlwZV9zbnAoKSB8fCBodl9pc29sYXRpb25fdHlwZV90ZHgo
KSkpIHsNCj4gPj4gLQkJCXJldCA9IHNldF9tZW1vcnlfZGVjcnlwdGVkKCh1bnNpZ25lZCBsb25n
KW1lbSwgcGdjb3VudCk7DQo+ID4+ICsJCSAgICAoaHZfaXNvbGF0aW9uX3R5cGVfc25wKCkgfHwg
aHZfaXNvbGF0aW9uX3R5cGVfdGR4KCkgfHwNCj4gPj4gKwkJICAgICBodl9pc29sYXRpb25fdHlw
ZV9jY2EoKSkpIHsNCj4gPg0KPiA+IENvdWxkIHRoaXMgYmlnICJpZiIgc3RhdGVtZW50IHVzZSAi
aHZfaXNfaXNvbGF0aW9uX3N1cHBvcnRlZCgpIiBpbnN0ZWFkDQo+ID4gb2YgZXhwbGljaXRseSB0
ZXN0aW5nIGZvciBlYWNoIENvQ28gVk0gdHlwZT8gSSBhc2sgcGFydGx5IGJlY2F1c2UNCj4gPiBN
dWtlc2ggUmF0aG9yIGhhcyBqdXN0IHN1Ym1pdHRlZCBhIHBhdGNoIFsxXSB0aGF0IGludHJvZHVj
ZXMgYSBuZXcNCj4gPiBmdW5jdGlvbiB0aGF0IGRvZXMgc29tZXRoaW5nIGFsbW9zdCBleGFjdGx5
IHRoZSBzYW1lIGFzDQo+ID4gaHZfaXNfaXNvbGF0aW9uX3N1cHBvcnRlZCgpIGFuZCB1c2VzIGl0
IGhlcmUuDQo+ID4NCj4gPiBZb3UgZG9uJ3QgcHJvdmlkZSB0aGUgbm9uLXN0dWIgaHZfaXNfaXNv
bGF0aW9uX3N1cHBvcnRlZCgpIHVudGlsDQo+ID4gUGF0Y2ggNiBvZiB0aGlzIHNlcmllcywgYnV0
IHRoZSB3ZWFrIHN0dWIgc2hvdWxkIGFsbG93IGV2ZXJ5dGhpbmcgdG8NCj4gPiBidWlsZCBpZiBh
IGJpc2VjdGlvbiBzcGxpdHMgdGhpcyBwYXRjaCBzZXJpZXMuDQo+IA0KPiBJbmNsdWRpbmcgeW91
ciByZXNwb25zZSB0byBNdWtlc2ggZm9yIGNvbnRleHQ6DQo+ID4gQW55IHJlYXNvbiBub3QgdG8g
dXNlIGh2X2lzX2lzb2xhdGlvbl9zdXBwb3J0ZWQoKT8gWW91cg0KPiA+IG5ldyBmdW5jdGlvbiBz
ZWVtcyBjb25jZXB0dWFsbHkgZXF1aXZhbGVudCwgdGhvdWdoIGF0IGENCj4gPiBkZXRhaWxlZCBs
ZXZlbCBpdCBoYW5kbGVzIFZCUyBpc29sYXRpb24gZGlmZmVyZW50bHkgZnJvbQ0KPiA+IGh2X2lz
X2lzb2xhdGlvbl9zdXBwb3J0ZWQoKS4gQnV0IEkgZG9uJ3QgdGhpbmsgaW5jbHVkaW5nDQo+ID4g
VkJTIGlzb2xhdGlvbiBoZXJlIGlzIGEgcHJvYmxlbSBzaW5jZSBzZXRfbWVtb3J5X2RlY3J5cHRl
ZCgpDQo+ID4gaXMgYSBuby1vcCB3aXRoIFZCUyBpc29sYXRpb24uDQo+IA0KPiBJJ20gbm90IGZ1
bGx5IGNvbnZpbmNlZCB0aGF0IGNhbGxpbmcgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSBpcyBhbHdh
eXMgYQ0KPiBuby1vcCBmb3IgVkJTLg0KPiANCj4gSSBzZWUgdGhhdCBvbiBWQlMgVk1zLCBtc19o
eXBlcnZfaW5pdF9wbGF0Zm9ybSgpIGNhbGxzIGh2X3Z0b21faW5pdCgpLg0KPiBJZiBzZXRfbWVt
b3J5X2RlY3J5cHRlZCgpIGNhbGxzIGh2X21hcmtfZ3BhX3Zpc2liaWxpdHkoKSwgeW91IHdpbGwg
dHJ5DQo+IHRvIHVzZSB0aGUgaW5wdXRhcmcgYmVmb3JlIGl0IGhhcyBiZWVuIGluaXRpYWxpemVk
Lg0KPiANCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgaW5jb3Jy
ZWN0Lg0KDQpZb3UgYXJlIHJpZ2h0LiBJbiBnZW5lcmFsLCBpdCAqaXMqIG9rYXkgdG8gY2FsbA0K
c2V0X21lbW9yeV9kZWNyeXB0ZWQvZW5jcnlwdGVkKCkgd2l0aCBWQlMgaXNvbGF0aW9uLiBUaGUN
CmRlY3J5cHQvZW5jcnlwdCBwYXRocyBnbyB0aHJvdWdoIGFsbCB0aGUgbm9ybWFsIG1hY2hpbmVy
eSwNCmluY2x1ZGluZyBtYWtpbmcgdGhlIEh5cGVyLVYgaHlwZXJjYWxscy4gQnV0IHRoZSBuZXQg
cmVzdWx0DQppcyBubyBjaGFuZ2UgaW4gdGhlIGd1ZXN0LiBQVEVzIHJlbWFpbiB1bmNoYW5nZWQg
YW5kIHRoZQ0KdlRPTSBiaXQgaXMgbm90IGFkZGVkIHRvIHBoeXNpY2FsIGFkZHJlc3Nlcy4gSW4g
dGhhdCBzZW5zZSwNCml0IGlzIGEgbm8tb3AsIHdoaWNoIGlzIHdoYXQgSSB3YXMgcmVtZW1iZXJp
bmcuIEJ1dCBpbiB0aGlzDQpjYXNlLCB0aGF0IGRvZXNuJ3Qgd29yayBiZWNhdXNlIG9mIHRoZSBz
Y2VuYXJpbyB5b3UgcG9pbnQNCm91dC4gVGhpcyBjYWxsIHRvIHNldF9tZW1vcnlfZGVjcnlwdGVk
KCkgbXVzdCBiZSBza2lwcGVkDQpmb3IgVkJTIGlzb2xhdGlvbi4gSSBtYXkgZG8gYSBzbWFsbCBw
YXRjaCB0byBhZGQgYSBjb21tZW50DQp0byB0aGUgY29kZSBoZXJlIGlkZW50aWZ5aW5nIHRoaXMg
YXMgYW4gZXhjZXB0aW9uLg0KDQpUaGUgZnVsbHktZW5saWdodGVuZWQgKG5vIHBhcmF2aXNvcikg
Y2FzZXMgZm9yIFNOUCBhbmQgVERYDQphcmUgZ29vZCBiZWNhdXNlIHRoZXkgZG9uJ3QgY2FsbCBo
dl92dG9tX2luaXQoKS4gSW4gdGhvc2UNCmNhc2VzLCBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHVz
ZXMgdGhlICJuYXRpdmUiIGNhbGxiYWNrcw0KdG8gdXBkYXRlIHRoZSBoeXBlcnZpc29yLiBUaG9z
ZSBuYXRpdmUgY2FsbGJhY2tzIGRvbid0IGtub3cNCmFueXRoaW5nIGFib3V0IEh5cGVyLVYgb3Ig
dGhlIHBlci1jcHUgaW5wdXQgcGFnZSwgYW5kIHNvDQpkb24ndCBoYXZlIHRoZSBjaGlja2VuLWFu
ZC1lZ2cgcHJvYmxlbSB0aGF0IFZCUyBpc29sYXRpb24gaGFzLg0KDQpJIG5lZWQgdG8gZ28gcmV2
aWV3IGFnYWluIGhvdyBhbGwgdGhpcyB3b3JrcyBmb3IgQ0NBLiA6LSkNCg0KVGhhbmtzLA0KDQpN
aWNoYWVsDQo=
