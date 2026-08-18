Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010002.outbound.protection.outlook.com [52.103.13.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F635C6B3;
	Tue, 18 Aug 2026 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029824; cv=fail; b=d8ZukUnS9ZDVSqvGmBv5rrOsBtSMEYOJLDyyjVh8VLKYnP/mf0Nr9+Govd+lw6dD+Y3AgDf1VkF69a6tzhC9yocgI2kYVipZ6FQ3fckT+Oe8R76X0gtwc+sTPrxjtaLVMPMvMK7Apvg2/XzlO90qS0G0r7WRM4edYRWRsWgMeRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029824; c=relaxed/simple;
	bh=pyCRCM9ZHYE3aDQIvXpKpMt+ZoGUF6fyMRroG8rs5Cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qQdkKg1mpKtUM1EiXUPJy25S28vz5p5aINeuv/bgVRNepYnLJzZYoKXxvofrznedqF0oQBOlp3cDA+/AmzmLn2HNJe2yIVqyT8k+/W+2KhAqB3B7jpnH/KykkzMtfE08hDnRc3mEF/LjtPmCItVZ8j2jR/WBGIbgOR5u7m+n3t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TOQhxveT; arc=fail smtp.client-ip=52.103.13.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TOQhxveT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmsbwepCNdLchWpnHsiLkHtRsaSmkxBcsgwZfQEWlzQMJyLpcSXtx100OSb9REGdxFwM6kabu+IAaKKxzugR5Au94bg9ChfH9Q9YmHHh2CWyCkvNv1K2yA7r7GhURprdUXdgBB4Q4Vt1mGHaQCihX4M6KbKbX+Yb8gYScdSQWUiJkuyA6oyNeJ6uBB/tG+Ie22A0NU/0BzM3CSsOge8zaBVcJ7h6Ix25ggn9wu8wKTRgFtXQw3e8H+ys/HQstKMWdM1FYTqtwGHSPjzLZCzlVHxZepDKbzc1bL6XnHScWQ7dxOSJiCqy4uvyNMnnHpLxBzxk5SoE5yZygQ+0QxRpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyCRCM9ZHYE3aDQIvXpKpMt+ZoGUF6fyMRroG8rs5Cw=;
 b=V3g3tiC25q/YQ0POP0NgtcPFj6RLQmVREvKpVChyhpgUu05MEZ3c3BmVej3Vj0cikFbpV19d94MKOHo61D1UbYrJAYy0xc9IeEQumFKCL+OnVVLo/txoxxF+hp7WiQ8tRUtxQY6pWVa1+B39QiTp19zilCf/g9LFIa4Bgm2lXqNXq7V0wICwTgP0VC0PSaxsTx26ldXy7jks3UnX1Vz5fJWyZjUw29JTaLvYUp3JbVJCIy0lxS2N+5KqdSFWbqaRy6aeHg6NLFiwmyAORq56XYbOOOb/JR/+JLPtLsSNDHh+QLHijxQ8Qd5hHr46F8tArhVtNYKJ2WuHGTlOwSrwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyCRCM9ZHYE3aDQIvXpKpMt+ZoGUF6fyMRroG8rs5Cw=;
 b=TOQhxveTdep2Dv9qb5hKQwrQOj17D3+xJ79dxtK2XMIvwI0Nvq15peG3r3RK5LQhLtBS/RvPjGJ16Q5qkBx+o+A/3lJygCL/5nKMKch9sIBy1uNFErS5KUJAYYYXy7YmSAFc+jthW3wuz11U6i5z9t4adShrDRKc/xHxQ45nkOFGW5+YqrMcO598FNR20/xvaKhsUOfzydJAPbGCdwAwXuZS05/NDSpqQps0LZDC3IRHO9NHZZWTD0g08IJLdz5F4fTemLOlt4YdcCd2wYysAFS3htyjeDx/WNd8OWk+njsIEDNGTdZv+URqMQmSXhiMxSsA1rKn78U5+XRFva6zLQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS2PR02MB11185.namprd02.prod.outlook.com (2603:10b6:8:333::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 05:10:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 05:10:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Robin
 Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Aditya Garg
	<gargaditya@linux.microsoft.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] PCI: hv: Set irq_retrigger callback for the
 Hyper-V PCI MSI irqchip
Thread-Topic: [PATCH v2 1/3] PCI: hv: Set irq_retrigger callback for the
 Hyper-V PCI MSI irqchip
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgLIUKZLttYakVA=
Date: Tue, 18 Aug 2026 05:10:19 +0000
Message-ID:
 <SN6PR02MB4157A559BFB69BAC5D97B858D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-2-namjain@linux.microsoft.com>
In-Reply-To: <20260810090716.2325295-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS2PR02MB11185:EE_
x-ms-office365-filtering-correlation-id: 9eb15bcc-b2f2-4a4b-3f47-08defce7000a
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|37011999003|51005399006|13091999003|31061999003|19110799012|8060799015|8062599012|15080799012|25010399006|40105399003|2607281247196008|18061999006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnpIbjBLVEpYTzU2ZG5hdVlCMG9tYlFYM0Uzb2dIVFNoVWFLOGphanBURndZ?=
 =?utf-8?B?NnJVTCtGZnBVSnBmRjEyV0diT0dLYXlHYVlhbFp1cjJWdDkvOGY2WUFNdG9l?=
 =?utf-8?B?UTcrOWRnV0pCbGd0UGdGaFhHNEFleWJUY1dROGN1Y3ZXb3o4TUpReDdqVVdr?=
 =?utf-8?B?NXR0L2RRaURaTk5wTjl4dUViRUliZ2Q5TGd3bmZYeWRpSFBYdEpWWkFWeUNx?=
 =?utf-8?B?a1lNRkl0VktYY1M0Q0VEVWMwUjFpUkJ3VGVrVDh5WkduK1NwaVlQNmtrVjNn?=
 =?utf-8?B?VnpUNFprcjQ0VmRkZWtveXZ5QkxhallubXlyNVBudjVEQmhiQW5OcjBYY2FV?=
 =?utf-8?B?c01raTJhc2dTOGZ1YkZBcFVvUTMyTTZOcUlWLzh3c0QzbGVNdDFDSElJbkEy?=
 =?utf-8?B?OVVJYXV2aFgxVHhRVlVMcE05aVpDNm95L2I4VDc0aHo4Z2ZnbzZ5UEJZMmlQ?=
 =?utf-8?B?azZjK1F4VkNuMGJNSUh5VzJrUlV5VzRadDBSTy94azhkcUIzN0hoMkpGR29X?=
 =?utf-8?B?Y2puTTRSR1BDTlBHd2hBL29EWHVLTzI3UnJpR2hpSzNUMVMzckxlN0JrWW1X?=
 =?utf-8?B?Y0hpOUMwMWhaNlJIT1YvdFJ5K0UyanBBSThieXU5OHBTUHZwZHliZGZ4bUdH?=
 =?utf-8?B?cmQ3blVsR3UwMW1BTFRKN2o1MUNoUDFYcHQyVjlsOXBwYmVOUFY4dDZqeUdM?=
 =?utf-8?B?U0dpcDZ6MmtwbGhHRDA0Y3g3Nk5qVUdOVkdZZDl1bzlBdkFraU04dkJqWHVl?=
 =?utf-8?B?Mi9ZVkRnMC8zWmZ2REpRSVJNUVU3QjRvTWJud2d0cDJOQWVYRUZ5WTNQRGJJ?=
 =?utf-8?B?YkxudFdyZ3A1ZURDSFl6KzY2NXUwMEp0RWppbVIweWU0SzlYbGJYSFEzWm9J?=
 =?utf-8?B?aGQ5ajZ0QVo0OTUzZ1dSOG1JbisxeklqQ1FzZi9LZ3R0dzlONFl4OWFmSis1?=
 =?utf-8?B?a01aNDhMdm1hUWdQNDl1MkE4L3k3TzR6MVRGY2F0bnpESkdkQ2s2eHRibVQx?=
 =?utf-8?B?MmhRb3piTHVwb0Z0R1l4SlNRTnM0dDhGbktaRXkrQkUvSkl0VUtmZVRGUzNs?=
 =?utf-8?B?N0ZnaVQ0ajBHc3NCeEtxdGxsWEVOMlFNYzJNUmFzSHhkQlZ5bTkvVU5LYjdU?=
 =?utf-8?B?VjAzTUpzaHBCM1R1UzViY1Ntb1VyaDRQZ1V1OTJIWitxeEQvRDZ3TEJSTzdO?=
 =?utf-8?B?RVJoRFNvSHRVMDBkSndEdXNJYTR4MCtsSkRpUldrU28wVFJJdkt2SjR3QTBQ?=
 =?utf-8?B?Zk9yZG1sSTA2OXY4NExJa0pjVkRyN3VUcGY2c1luL1hoQklqZnh0SmJtY2pY?=
 =?utf-8?B?THRPaENGV3BSM0RFZW1VM045aUdpWUdiVW5Gd0ZGWEsrdVE4R3pxbWlLOUV2?=
 =?utf-8?B?eDJWOCtoeVd3RGtHczdwRXJ6Y3Y1bDNqTkN3bzBQQ1EyQzllSHgxeWRNV3Rz?=
 =?utf-8?Q?AX0yvWae?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWxDRCs5a3J0RFVTQU95R3J6aGxCZ1EvUG40dzNhZFIzQTBTRGlGZUlLOXZ3?=
 =?utf-8?B?bnhsZU8wZUNvVTV1REszenZhSjhKUHNuUkRqbGdsakdMMTFwK2RsSGhhWENM?=
 =?utf-8?B?T1ZydWVNQ3lWV2dwNnNFSWpDMUY2VDBUWm1jdEZKdEYvb1hLTmpLMVdPU0pm?=
 =?utf-8?B?YTZ3amFWQnBRNVI0eFRqUVowenovckhmeEdQZDAxUEx6dktPLzVBcWNmUXox?=
 =?utf-8?B?WXp6OCtXOHVWbDVoSSs4UFV5VEF3QWlzVXMvSzJIZUQ1TW9pM0hFZzdNK0tO?=
 =?utf-8?B?ZWRzNUVMWWU4U25QT1NNNWw2QTR3aTVEczkzcEcwM2ZheTJDdGpDRWZ6UlAw?=
 =?utf-8?B?M25TWEtUMDMvZGp4K3ZpdkM2aTVhSlZmQk5yRlBGMlUzcEpqUjdUMnhCNUhT?=
 =?utf-8?B?ai9ZbHJiNTVHcm55Tjl4eEZ1VUZqdVBnaTdYQUc4NkRHZGlUd0J3SUFJUWhP?=
 =?utf-8?B?NXNsNVdib0RnbXppaVl0aXdxajdrQVFWMjBYRTR4eHZtTW1zbzE3RFM2UG9T?=
 =?utf-8?B?RlgyRHNNdHVBakNPT0RROGNOaHR6Y04wN2t5L2hmd2xROEt3ZVUrTmZBcXJV?=
 =?utf-8?B?QnUyRjhNbGcySTN2Rm1Gd29uM1drcnBibG5jbzNFVXZJK29XZTA0RFlnTDRi?=
 =?utf-8?B?QWlIWmQyOXFaUmVQNzZyeDNYdnJ2cVJPUGNpV2oyZkNYYmQvZVBoRjlEZ2cy?=
 =?utf-8?B?c2tPdkU0YjRHQldGN3hYT0VPT21KNXpUUFZyU2x2bkVLWnVrUGZEVHdCYUFr?=
 =?utf-8?B?SE8wMkorUTlteGtlNGEwYkVrUnEzUHBIOWl0aUpENXFvK2xLQ3J3QXdKUVRy?=
 =?utf-8?B?bG40OGNvQ1gyaXEwNkdyc3oxTGVZd2Z3d292ckVvMGRkdXhSM2VRdW1kOFdt?=
 =?utf-8?B?c0FTa0hGeDJlMjcvTWhuKysvby9ncE9vSnlNRmcwZVFVVkl3S0dDRVY5OElW?=
 =?utf-8?B?T21UNWI0YjlQdUp4SWpYMFJwQ1NEbitiZ29ueUYzWEphTi9YWUZOVUR2Q3FP?=
 =?utf-8?B?ZE5VTyt1TXVsc3ZzSU9WdWpCSGVTOHdtME1zRTJuUzVXWFluMExuam9YSHhP?=
 =?utf-8?B?YU1vUGVGUWo3bnF5UzhaVEFuc2lib0V4QzhFdDZWM3FiZi96WWlmR0hvOUNo?=
 =?utf-8?B?TllyK0dKekE4ZUswTjZRdmJwR2d3TW1WOHNGamVPQW5ZY20vaC9XTGcyZWVQ?=
 =?utf-8?B?aTVjdS8xUlg0WFBDbHJXWkVPWE9OTzhnWXBsYzNqYmZEZUw2UzkyWS8yOFhT?=
 =?utf-8?B?R2N6dXJiWURaZ0tCd3Nsc0wxRlhPZ1IrbE5nRWVudlVZOCswQmk4YVptR0Ew?=
 =?utf-8?B?M3BmUHB1NU03bGdsMWtXSDkzSFk0TW9qLzBsSlJGRHhFYkV3VmE4VGMvRklT?=
 =?utf-8?B?d2hOcFZRN01OdmhTSEliTHUvREx3VlI3RWUwQ2djZUkrWFUycnA3SkNkZTFw?=
 =?utf-8?B?dGNoR0I0Nmx0Mk91R3F5OWtrbXB2ODdGWUtEaWtQa0RtU29vajhRbTQrazlO?=
 =?utf-8?B?RWl4RUFKelJQSklsNWJkb3BoOVV2M2lVOVJlUXZncFJSZUtxakQyV2k2QnNE?=
 =?utf-8?B?bEhrUEIwYktidzRxeXpwQkRSeFJQRTZhTEg3RlZ0SHExc0ZuY2lseXg3NVh3?=
 =?utf-8?B?VktQL3ZxaW00R3Z0SFB0emF5THZ5cVp3SFk5bS9QbHhmUUMyZEhEeE4zZ1o2?=
 =?utf-8?B?Q2tvV1dkSGZwQ0pGZnZrMVA3SFNNUDFnMEN4TTNHTTBXTzRoVmpCVDJqWXpi?=
 =?utf-8?B?UndFeWNDRTZmOXA4TUhWQjQ4T29yMGxXN21mT0RhYmtDbUdMcUlKR1JmSGtl?=
 =?utf-8?Q?ceeitLjjF+Fw9lQ4LQuhW3Ltph1YVfXSzjRag=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb15bcc-b2f2-4a4b-3f47-08defce7000a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 05:10:20.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB11185

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEF1Z3VzdCAxMCwgMjAyNiAyOjA3IEFNDQo+IA0KPiBUaGUgSHlwZXItViB2UENJIE1TSSBp
cnFjaGlwIG5ldmVyIGluc3RhbGxzIGFuIGlycV9yZXRyaWdnZXIoKSBjYWxsYmFjay4NCj4gDQo+
IE9uIENQVSBob3QtdW5wbHVnIGZpeHVwX2lycXMoKSBtaWdyYXRlcyB0aGUgaW50ZXJydXB0cyB3
aGljaCBhcmUgYWZmaW5lIHRvDQo+IHRoZSBvdXRnb2luZyBDUFUgdG8gYSBuZXcgdGFyZ2V0LiBJ
ZiBhbiBpbnRlcnJ1cHQgc3RpbGwgaGFzIGl0cyBwZW5kaW5nIGJpdA0KPiBzZXQgaW4gdGhlIG91
dGdvaW5nIENQVSdzIElSUiBhdCB0aGF0IHBvaW50LCBmaXh1cF9pcnFzKCkgcmVzZW5kcyBpdCBv
biB0aGUNCj4gbmV3IHRhcmdldCB0aHJvdWdoIHRoZSBpcnFjaGlwJ3MgaXJxX3JldHJpZ2dlcigp
IGNhbGxiYWNrLiBBcyB0aGUgSHlwZXItVg0KPiBQQ0kvTVNJIGNoaXAgZG9lcyBub3QgcHJvdmlk
ZSB0aGF0IGNhbGxiYWNrLCB0aGUgcGVuZGluZyBpbnRlcnJ1cHQgaXMNCj4gc2lsZW50bHkgZHJv
cHBlZCwgd2hpY2ggY2FuIHJlc3VsdCBpbiBsb3N0IGludGVycnVwdHMsIHN0YWxscyBhbmQgIk5v
IGlycQ0KPiBoYW5kbGVyIGZvciB2ZWN0b3IiIG1lc3NhZ2VzIGR1cmluZyBDUFUgaG90cGx1Zy4N
Cj4gDQo+IEluc3RhbGwgaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSgpIGFzIHRoZSBpcnFf
cmV0cmlnZ2VyKCkgY2FsbGJhY2sgZm9yDQo+IHRoZSBIeXBlci1WIFBDSS9NU0kgaXJxY2hpcCwg
c28gdGhhdCBhIHBlbmRpbmcgaW50ZXJydXB0IGlzIHJlc2VudCBvbiBpdHMNCj4gbmV3IHRhcmdl
dCBDUFUgdmlhIHRoZSBwYXJlbnQgeDg2IHZlY3RvciBkb21haW4uDQo+IA0KPiBGaXhlczogNGRh
YWNlMGQ4Y2U4NSAoIlBDSTogaHY6IEFkZCBwYXJhdmlydHVhbCBQQ0kgZnJvbnQtZW5kIGZvciBN
aWNyb3NvZnQgSHlwZXItViBWTXMiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBT
dWdnZXN0ZWQtYnk6IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiBTdWdnZXN0ZWQt
Ynk6IFRob21hcyBHbGVpeG5lciA8dGdseEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQWRp
dHlhIEdhcmcgPGdhcmdhZGl0eWFAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IFNocmFkaGEgR3VwdGEgPHNocmFkaGFndXB0YUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgfCAxICsNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlw
ZXJ2LmMNCj4gaW5kZXggY2ZjOGZhNDAzZGFkNi4uODk4MTZhMmJkN2NkMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gKysrIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gQEAgLTIxMTksNiArMjExOSw3IEBAIHN0YXRp
YyBib29sIGh2X3BjaWVfaW5pdF9kZXZfbXNpX2luZm8oc3RydWN0IGRldmljZSAqZGV2LA0KPiBz
dHJ1Y3QgaXJxX2RvbWFpbiAqZG9tDQo+ICAJaW5mby0+b3BzLT5tc2lfcHJlcGFyZSA9IGh2X21z
aV9wcmVwYXJlOw0KPiANCj4gIAljaGlwLT5pcnFfc2V0X2FmZmluaXR5ID0gaXJxX2NoaXBfc2V0
X2FmZmluaXR5X3BhcmVudDsNCj4gKwljaGlwLT5pcnFfcmV0cmlnZ2VyID0gaXJxX2NoaXBfcmV0
cmlnZ2VyX2hpZXJhcmNoeTsNCj4gDQo+ICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4NikpDQo+
ICAJCWNoaXAtPmZsYWdzIHw9IElSUUNISVBfTU9WRV9ERUZFUlJFRDsNCj4gLS0NCj4gMi40My4w
DQo+IA0KDQpSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29t
Pg0KDQo=
