Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792689260;
	b=1kon/QUuOtlJfHfbIzX91NwT6sFb1OXLr444NhoeUVRpRO5AS+nQjDEml0BwaE94Df1a
	 fJbp6PPlo53Av60xqoPuhiVeyuj6fFTH3mlin2GKCNfcUnqvHW82QKWqy7axLawQNTV69
	 CCkeTnGRlfhF5K8b6d93H9oAqC8IxXv4OxvSRXCAuk1SkZq2bJykIbi7O4JvMGsw7w/nG
	 zMOUyKbeMlwKuscqTf80RumG3g+6WfvgR/CjNB8m9n7FmD+ZRJjhpJ9HK45Ai6et3c3Fy
	 JgLDqMkKMIBD7JkQvVJVPKV0cuTOIPqVNmanffxMZL9HGPPg6jEotGBpBNyHYbeEg+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689260;
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
	bh=Yt6NwdyizH0hVgKOVvheeMX5SX7bFdYckrAhyNFXUUQ=;
	b=HRCZ5W1HN3gE/5+/nZPncBd+DfLTKTmXw8Oycbi6i6nbfAMamcpPyC0dS2hAdhux1pv7
	 723iRW2Nm/sAHTEiRHftOnhf7wTeYBVg7eQix9tXSQsmQNW/jnZL1gUa2fN/IC/uUmPLi
	 Cr9teFbS7P8BcgdW762SD458TEvpC/rzfltK2PKUgolRL0BflrMHWJQjbMXTfUFDINlJf
	 YaroRBY9lTk17GXhJ2raIq/ObIu+W7eWjrkWhRXl6/nC51E+HkK5DUuAFVfQYA0Ktxnra
	 y1a+mY5IA9jWKLmUg8fhbmOaIr0uVn8ucAjyGmdkrsttk1ky8PqMNRLkONnL49ebj/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="PW/bRjh/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.37
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011037.outbound.protection.outlook.com [52.103.13.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20363606A31D;
	Thu, 22 Oct 2026 17:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20363606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=PW/bRjh/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsrJ83Yd4eG95N2WzjmI2Aiogu7j9xnNPqG7l7Rkk+8s/kaWCMRJGw8y5LymaZT5RjZHjN9sGKhCQBWEGe34KXS8lALdEEC+wlw3Ucy6tP/YZ532Tz5Gjh7iO1TZrYxQdF0INnzmAaQYXFZnXQmv5zWPV8mcGuB0KPDNn+nHuEdZ25kSloL6bsKLCDpPjJrQ9a//N72JOyM+/Wcym8kjUnCIy1Y+aaPHTIBAB5zenKhu9DzGIICMGvRT5UYslQpKXpigPepqfsg34e4j6a4/Og3q70/pKVrvukaHUUIkRNjKmw5UYsKw3lrr6xUfFYlcqyvRgvmXdQVnFWiBf39Ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt6NwdyizH0hVgKOVvheeMX5SX7bFdYckrAhyNFXUUQ=;
 b=YZtAUkVuRvl6yPPBL/ZXvRJtgZwMrMG1Jn4WC8+tupPI4NoOcLpHib1n2uNwg800VYN3IUjYeDEr5igXGePDjYhPxDT83LteoMxOsPNlKu3wuC8wDqdqtLKbm9DHoa/5RRcLjVKmB8WVKiZjzjVUJjuBsMAw40qIheVdS+K6dYm7OpA4PkPNc0IzWdGlU+RKkojcsl/Q/tWe4v/Mh0bK/D+wu00z34cObKdNjJEMhmgeN3fvgZfVuYvD3sD8bT8a9abtYyU5Fs3OYkahOYOqW+oC1/N5o8aJ+LmeHve7xlitpd45WVIpynzM4tByjfXDBpMbVsBAiJ5Uym4u9I0Fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt6NwdyizH0hVgKOVvheeMX5SX7bFdYckrAhyNFXUUQ=;
 b=PW/bRjh/n3O7oG3FWI6rdwDFWyNXd9oaQ7NS2amt3FT4raZtGubL1N74yXbI2vYNLhzat9widARbVoE3Qw7fOXAKso+SJSHX2hFijZvbeDY7ViKJKt302DNKXhe7Xi8bB4bfEV/zRT9Wdg9GNYRknApDhOWQVgSFyD0hj+/l3AjGZ4yDU1BgIvFHjJNHCCGKJHV+jQELB7KjoQj9pgXF6R/yNmqiHwGPSIeUmOEBhw1VEql7Wz6uMe13KfkV+S9dWZD5bH2SE8TRt2G0acR/EuoK/NkUr88VWzu44QvliBSScJNBuQAMF1/Rb0ggTMvXgn4QNiUlkVSV1vReN1L6eQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH2PR02MB6663.namprd02.prod.outlook.com (2603:10b6:610:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 17:14:12 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 17:14:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in
 pcibios_root_bridge_prepare()
Thread-Topic: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in
 pcibios_root_bridge_prepare()
Thread-Index: AQMKc6wfiOMUtLj22A3qCpjii9PqxgKK3s6DtJtSwyA=
Date: Thu, 22 Oct 2026 17:14:12 +0000
Message-ID:
 <MN2PR02MB6863A57660077B2466B77FB8D4652@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20260929181056.4746-1-mhklinux@outlook.com>
 <CAJZ5v0jNJBCK1Zj0cVuTK3mtyJFF3MbEH8HKvTNKCa84eMUdmQ@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0jNJBCK1Zj0cVuTK3mtyJFF3MbEH8HKvTNKCa84eMUdmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH2PR02MB6663:EE_
x-ms-office365-filtering-correlation-id: e51a493b-d89c-4f7a-7ac4-08df305fe4a0
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|15080799012|25010399006|37011999003|51005399006|41001999006|12121999013|8060799015|8062599012|19110799012|24021099003|55001999006|31061999003|102099032|3412199025|440099028|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?cG5PWU5aOFJEZjN6TjJSaDNnOU1ZOXR4OGZnajhGazZhcHlHZ01HQjRmbTE4?=
 =?utf-8?B?Nzk3WGppbzEwTzZGcE4yRkJTM0NqT1ZXelNDWEp0TmZhZU9FV2c4R25OeFh6?=
 =?utf-8?B?ZDFxQlJsa29iUUYyUzFYVitYZXV4YTdpTEdoZmkrWHlId0ZYdFV6d2htcWRU?=
 =?utf-8?B?cjgyeUlKOUlPWUlmb1ArVUNwVHBWbFJjUDRYQWxvWE43eHdYeEUrOGpvaVpo?=
 =?utf-8?B?MHREdEdzalBJQkJKUG1WTFd5TmlnbEN0YyttWHJzbGRJSFhOQ2NrT1d6ZXFk?=
 =?utf-8?B?TDNvWmVrT3hJWTZiZjdwNHY3WkxCdlFoVWJWYU9sNXh0b2pMV1dhUUZ4UnVR?=
 =?utf-8?B?ZFRUTEdwejJjY2I0Ry9rTGxNdTk2SFI4Ly9hMXUycW5mY2YxM2FjRmxJanVv?=
 =?utf-8?B?ejMyU09BQU5WanJpWlRmR1k1M2pKYWlQeExldlUrT1V4YXJLVTRiUDM3REZJ?=
 =?utf-8?B?aVQ3UzAvNUloK0IremhhUmdlM0NvNGlBTTlWQVQrS0MzSDhoVklacFFWSGZF?=
 =?utf-8?B?NmdEQzNESGhxRks0WE14WjBxMFd5QkNaN1hUbU5oUG91aE5ybVhpWTVqVUNn?=
 =?utf-8?B?VDFEd2dwU3E1bi9SbkQrd0Y5SlZReEFnT0pmSHRvaFdQTkxlVnJnazY3eXFE?=
 =?utf-8?B?dFZFYW1kSlJLMUdER3JqV0hUSzVCQ3pTUTVlL3F1OVM1czdEblViZzlPc05x?=
 =?utf-8?B?YVZRS0xmeVgyb2Uzb0d6RlZhTTYrL1BjTXNqRW5kYW9IV3JYb0NNcEpucVdU?=
 =?utf-8?B?NWNtUU52aWtsalF4UjM0OGs1TWg2NnljemFzRjVLYWJQS1plMEMwUUhQL05u?=
 =?utf-8?B?WjRURkZUclFvaURrSkhuK0V1d3VOR3NVNmFKVDVacjdLSy8xUUt2MXUrNlJl?=
 =?utf-8?B?cUN4RTJCaHRmaEtncWphV3lhMTV4bTNBYWN4U1JPR1VNUzRiOUxLOWhlM1Bw?=
 =?utf-8?B?a1ZHeVhaUzdmSm9PNWJiY1pNRUc1bUFzTUxWZWFRM2M0NG82V3c2bE1aK2U0?=
 =?utf-8?B?TlZ5aWZvS09seExGb2xOVkR1NEhOZnZua3QxUW4rNUZhci9RN3JjSDMyWGov?=
 =?utf-8?B?WU1FcTZ2aGZicm5qU0lpbHJBUW5wdXRHQmc2K08xeEJyamxGbmxqVkppMFF6?=
 =?utf-8?B?TGwxeEthTmRwK0lNdXo5RjZOeXYvdkRSUkFsRVRzYUN4MWRSV281bnpjT21J?=
 =?utf-8?B?M2hxcitVZHBNWHVTTVZtb1I3QTgrWkxlSnFRa0JUK2JnZ2syU2RmdGRWcFJo?=
 =?utf-8?B?L1MwQmozL1dzaUhFY3dLeVB0MFpjbzV4bmZTVEhWUHl5Vi9IcHZpdHNmSlBo?=
 =?utf-8?B?Y01xN0luTjNjWktVVHdOZENzV3JZZFNkWjViUmRSUENaeTM2bUJ3MlVYQlFE?=
 =?utf-8?B?OStBemdXU29QeXRmekhvY04yRzl2Uk9XQjNVcDIwelZXbGxKeUVFSXpsdTYz?=
 =?utf-8?B?YlIvMzJWVE5FaDRCbFZ4Vko0RjNyRjdsUU1HVDJyR0hoRmNPTld1OG11Unl3?=
 =?utf-8?Q?/+xLII=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2hxSEJvMjhUdHIrdkVTWUpxa1RFOURPck5zdXFHQk1NeVNBSlcwa05IVWZm?=
 =?utf-8?B?LzRHdjk2c3hIK2RhRlczb2FBK1BnbVJydVZFYi9ydGI5cnlIcVJpVy9CMnUr?=
 =?utf-8?B?MnBISERSb3JoOVNxQ0x3WW81QzI4V3Q2TTMwWlRRYVJud0I1OXdZa2VuMVdx?=
 =?utf-8?B?amh3NHI5R2E0L3FNbzVoYmlwNEpTbDQ1UFZyMXdUS3NvVk4rOHBJV3lkVUVL?=
 =?utf-8?B?cjBjT0Q5OGhVRU1oUEVIS21HWUdRbmdhWk9wQnJTNlhQMmFiN2Rva2tGVnlH?=
 =?utf-8?B?Z2xENy8vT1RhRyticFFGQkNQVld3ZVpMMm13K2VSbzJ2UktUVmI0T2ZaT1ha?=
 =?utf-8?B?ZmtNYkZEbFBPZ0hBODF5NSt3T1ZBMGhON2VSZWxMNGVLL1pHcmR2dVpsL3ZU?=
 =?utf-8?B?Skx2RzJYUEVGRnR5Y0JtN0pxODBMUlhkTTJUUWxSY3cvaEJyNkh2c2x1SkdH?=
 =?utf-8?B?Zi9hVXkxaW1RR2FkbEhEejlrWlI2VHk4dElNRlVNT0JuZzZRMXcvYUthU0Q2?=
 =?utf-8?B?cGNOc2RXS2VHRTh0MVhqbHJwUGdBMSsycHp4SFdYaXVuZ0NLMG5jcmVYSG13?=
 =?utf-8?B?MHp0UVFSTkJBNXZFWVZIRGIwWC9TYk1LWlIrelVOd0lCNDJLb1I0Si9wRDhu?=
 =?utf-8?B?WXZYVUhLdmdOR2p4bVFSV3Zpdmp5UDlpR0lRdnRPdjBzbXBXcEJNUVZaS1RX?=
 =?utf-8?B?Y1NCcml3WTgxM2dUcGxPSkZRQ1A3U3VNUzUzQ0FBam9WS0FDNnNBYisxWHJr?=
 =?utf-8?B?ZjdjYlFXVURLQWZhd05Nd1pBS0xWaEpCRXRCdWk4aHJJaXB1UGdUdkE0VnU4?=
 =?utf-8?B?bzM2a0g5U3Btc2lNSmRrdFc3dzdVODh0WVhlbEsveFRaQ2k1elhEd2d4Nk9a?=
 =?utf-8?B?MzFQZFdDV1Y3dlF6TFA5Rmx0ZHlCR0NaRHhYOFJTR2VXY3ZGMTNlOThhZk1F?=
 =?utf-8?B?UHhQMmhOb0Z6UmoxQVVPWTg3NWRHajljOFQ1dTBMWmMrZktkZ1RRc0NHV0Rp?=
 =?utf-8?B?dHo3ZkwzZ2lkcGQxQVVLcWVxVHo2NGpYSkdIRmllMUNsYm5SR1JYc2pYT1lP?=
 =?utf-8?B?eWtlclpaMHFVdXUyZEl3a1pRTzVRbm8rcXVlbVFXRGVqNFVTOHc2ZldoMGln?=
 =?utf-8?B?Z1BYaTE0cFQ1Sk82dGoyVHZOeUVGK05WTkd1QnNjQ2xUdndrK1ROS25aWTEr?=
 =?utf-8?B?Y0U3U3MyT21CTi9ERll2Vm5NMW1iM0hIUThkN0dqeDN5MW8xTjltSUk2TnBs?=
 =?utf-8?B?Rys4NWpNTTRaZFRrYWptSVBsMitWQmtwcW5XMDBPMWtlNVMwMjcwbHFrNjI3?=
 =?utf-8?B?dzc5ZDN0bmxOZXAwUjR6YkZRT2R6VUJIdkZWNHJHcjhNRWVQQlM5UTJhOC9p?=
 =?utf-8?B?OUJldW9KMjlMcFd5dDlHVGRxYXprR2RpWDlyOHVTb2ZkOWJQREZudk4rMEM1?=
 =?utf-8?B?a1lOMFpRNDhRNzlmMklyMFJOQzVMeUU0OVM1VlVPdEt1V09JZzJrWTZydENU?=
 =?utf-8?B?TEVoRG9DS1k0blkzU3IzbHhEdyswdmpZVzc4bkFpdHBJakpLTDJ4aGdVbTFW?=
 =?utf-8?B?NW1CSjNNZlNlQ29sMHhaQjZlOEo4SkhPVWlTMVZYN1RkbFNCSEh5aEEzVjNB?=
 =?utf-8?B?bDZqam4rZnNldU9ocCs2aThkLy90Tmgyc2ZBdE04VU5VVGkxZmR5S2dmZW5h?=
 =?utf-8?B?ZS9SM2xyc05YL0RXbWFjcHROVWRYdFlRQU9vSFowdDhGT2JSNE91YzZSWkJY?=
 =?utf-8?B?OU1DM3BPYkVidmFSdktYcnc0YUJhMmVIS1hKOFM0cjl5UTNDSDBwd1ZsSDNa?=
 =?utf-8?Q?h3eLen0yQyKTDLUTvi9SnD04zeCaO1vhZz59k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e51a493b-d89c-4f7a-7ac4-08df305fe4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 17:14:12.5617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6663

RnJvbTogUmFmYWVsIEouIFd5c29ja2kgKEludGVsKSA8cmFmYWVsQGtlcm5lbC5vcmc+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAyOSwgMjAyNiAxMToyMyBBTQ0KPiANCj4gT24gVHVlLCBTZXAg
MjksIDIwMjYgYXQgODoxMeKAr1BNIE1pY2hhZWwgS2VsbGV5IDxtaGtlbGxleTU4QGdtYWlsLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBwY2liaW9zX3Jvb3RfYnJpZGdlX3ByZXBhcmUoKSBjdXJyZW50
bHkgaGFzIGNvZGUgdG8gaGFuZGxlIEh5cGVyLVYNCj4gPiBndWVzdCByb290IGJyaWRnZXMgd2l0
aCB0aGUgc3lzZGF0YSBwYXJlbnQgZmllbGQgc2V0IHRvIE5VTEwuIFdoaWxlDQo+ID4gdGhpcyBz
cGVjaWFsIGNhc2UgZXhpc3RlZCB3aGVuIGNvbW1pdCA3ZDQwYzBmNzBkOTIgKCJhcm02NDogUENJ
Og0KPiA+IFN1cHBvcnQgcm9vdCBicmlkZ2UgcHJlcGFyYXRpb24gZm9yIEh5cGVyLVYiKSB3YXMg
YWNjZXB0ZWQsIG1vcmUNCj4gPiByZWNlbnQgY29tbWl0IDhkMjE3MzI0NzVjNiAoIlBDSTogaHY6
IFByb3BhZ2F0ZSBjb2hlcmVuY2UgZnJvbSBWTWJ1cw0KPiA+IGRldmljZSB0byBQQ0kgZGV2aWNl
IikgYWx3YXlzIHNldHMgdGhlIHN5c2RhdGEgcGFyZW50IGZpZWxkIHRvIGENCj4gPiBub24tTlVM
TCB2YWx1ZS4NCj4gPg0KPiA+IE5vIGhhcm0gaXMgY2F1c2VkIGJ5IGxlYXZpbmcgdGhlIHNwZWNp
YWwgY2FzZSBpbiBwbGFjZSwgZXZlbg0KPiA+IHRob3VnaCBpdCBpcyBubyBsb25nZXIgbmVlZGVk
LiBCdXQgaW4gdGhlIGludGVyZXN0IG9mIG92ZXJhbGwNCj4gPiBjb2RlIGNsZWFubGluZXNzLCBy
ZW1vdmUgaXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGlu
dXhAb3V0bG9vay5jb20+DQo+IA0KPiBBY2tlZC1ieTogUmFmYWVsIEouIFd5c29ja2kgKEludGVs
KSA8cmFmYWVsQGtlcm5lbC5vcmc+DQoNCklzIGFueXRoaW5nIGVsc2UgbmVlZGVkIGZvciB0aGlz
IHBhdGNoPyAgSSBwcmVzdW1lIGl0IHNob3VsZA0KYmUgcGlja2VkIHVwIGluIHRoZSBQQ0kgdHJl
ZS4NCg0KTWljaGFlbA0KDQo+IA0KPiA+IC0tLQ0KPiA+IFRoaXMgcGF0Y2ggZG9lcyBub3QganVz
dCBkbyBhIHJldmVydCBvZiA3ZDQwYzBmNzBkOTIgYmVjYXVzZQ0KPiA+IGFuIGludGVydmVuaW5n
IGNvbW1pdCBtb3ZlZCB0aGUgY29kZSB0byBhIG5ldyBzb3VyY2UgY29kZQ0KPiA+IGZpbGUuDQo+
ID4NCj4gPiAgZHJpdmVycy9wY2kvcGNpLWFjcGkuYyB8IDEyICstLS0tLS0tLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMgYi9kcml2ZXJzL3BjaS9wY2ktYWNw
aS5jDQo+ID4gaW5kZXggNDJkNTQ1ZWRkN2ZhLi40NTJhOTAzMTdjNTggMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wY2kvcGNpLWFjcGkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS1hY3Bp
LmMNCj4gPiBAQCAtMTU3MiwxNyArMTU3Miw3IEBAIGludCBwY2liaW9zX3Jvb3RfYnJpZGdlX3By
ZXBhcmUoc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlKQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gMDsNCj4gPg0KPiA+ICAgICAgICAgY2ZnID0gYnJpZGdlLT5idXMtPnN5c2RhdGE7
DQo+ID4gLQ0KPiA+IC0gICAgICAgLyoNCj4gPiAtICAgICAgICAqIE9uIEh5cGVyLVYgdGhlcmUg
aXMgbm8gY29ycmVzcG9uZGluZyBBQ1BJIGRldmljZSBmb3IgYSByb290IGJyaWRnZSwNCj4gPiAt
ICAgICAgICAqIHRoZXJlZm9yZSAtPnBhcmVudCBpcyBzZXQgYXMgTlVMTCBieSB0aGUgZHJpdmVy
LiBBbmQgc2V0ICdhZGV2JyBhcw0KPiA+IC0gICAgICAgICogTlVMTCBpbiB0aGlzIGNhc2UgYmVj
YXVzZSB0aGVyZSBpcyBubyBwcm9wZXIgQUNQSSBkZXZpY2UuDQo+ID4gLSAgICAgICAgKi8NCj4g
PiAtICAgICAgIGlmICghY2ZnLT5wYXJlbnQpDQo+ID4gLSAgICAgICAgICAgICAgIGFkZXYgPSBO
VUxMOw0KPiA+IC0gICAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAgICBhZGV2ID0gdG9fYWNw
aV9kZXZpY2UoY2ZnLT5wYXJlbnQpOw0KPiA+IC0NCj4gPiArICAgICAgIGFkZXYgPSB0b19hY3Bp
X2RldmljZShjZmctPnBhcmVudCk7DQo+ID4gICAgICAgICBidXNfZGV2ID0gJmJyaWRnZS0+YnVz
LT5kZXY7DQo+ID4NCj4gPiAgICAgICAgIEFDUElfQ09NUEFOSU9OX1NFVCgmYnJpZGdlLT5kZXYs
IGFkZXYpOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg0K
