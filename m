Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010020.outbound.protection.outlook.com [52.103.2.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386925B0B7;
	Mon, 17 Aug 2026 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937894; cv=fail; b=KIVxmGeVTNYWQiBJPvXAVF28UCZOds8wlXTh0d3awRuHBbzj00rpg2j/CNmUl4Lzq7qNhU34XzNYyCfS0nLvaZMwCIhuOxCSMeH5aPoK0Mv1El78hgG0YKin/Q5o5Y1Dc9IdhhZ6wHVuLMTo0xPhs9s3ZeW37BbTEeSQmX0sfbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937894; c=relaxed/simple;
	bh=Ur8vxB0guT0/djITMGXsuRw+ohzmEAQb8/01HrY+Kho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eHSnJ+2LvMIBHYplP5s/cJdeInsnFTrLKI1qJU1AdbfxtJOS+JfT8YQdA2pc7gG4LUDMmOrKsIxNMkPG+WAChLH/SBGYWMwuygBG0jvgpH4kHZlenPIvAWxDhJ+Vv3iJcxGWcT4KjsKK2jVCWyVxwKPyTzReDwPDuEmv1E4Ja1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PIfiFUNm; arc=fail smtp.client-ip=52.103.2.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PIfiFUNm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfpIAjzWAbe/huzEYNVsN2WQ7QKiIGisHJfibdPVcgqzmrtG+3kHK4OFUxdknOZbdCqOZngyv9+yJnjW5XiLmx/VeUBKVyAgY71rDIGUZeQZ0lv0p4tUct2uS5zYrhpwnTTaH0Nna+1XDp9RY5DsN10byZT2iiWnRkFPxkTAWqkpEhE0N8MWRwOOz6rtUXuuNyh4COE8/suf9XpFwZaNjf7qYVuhNsVfoWpODD6v0339TSFY58cJs6waB34+etdnywKLin0ESh9frEtXIGOqo8Pu6xTIEwTopUgyJv7GRfAwDIoQ/745xav4wx3ygKEXyqFQhvVAmPPpbQ0hoJdOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ur8vxB0guT0/djITMGXsuRw+ohzmEAQb8/01HrY+Kho=;
 b=MNzf0+2N6U30yN7WcmZDDn4Jp9wk0wfW3sWCgrYXp8r08LYYoW31kejxBtSpuHjY5iVBD1eOXDvOhQtG0uPDfAHoNAOFfZTkITwrMbmD2L09QyJaiYkzK+IOLjs9lVQmN7lf/FnDiplVKHtCS5pfLXom65r+GOL7vKCaYLVh103t1Pyy5lS1Z3ReKgBjxONSKsbQBez3NwI4GnbM1YzAxOvppeSATKP0UetmoGi6jHC7B87w/kKpVprPD2c+zACtHRyTAPGTC/3x/uidCYNMqCugyOVfNzUHcMaL7vwUAjjF3BQ0yFL5gVPF0J/1cX9qKMEbMlZ1MVc3lWxRqDEiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur8vxB0guT0/djITMGXsuRw+ohzmEAQb8/01HrY+Kho=;
 b=PIfiFUNmVeL2OT1fnlTjvihFFwXaoGRsnq7zHKzzOrk+3Itv7hDDtP2cHKGaUha6yFdewab7HOLcCy8E+q/xm7zUOqWLwxl/BDuXmWHcUmn/kqgh2NXgYGjN9aFvZ1nXZN+WxJYv1f7T6h19NBSYo3KprVtbLTPEdcLb9l4rkGadtsuaR9X/XNhMW3592/OhtLqIyb1F+Sbqs526CSUDU2aRNRsUeoNJFgyyxQzjYSy7f0bWPDPGvx5zw3371NR0h1KkNacjxb/OWXN4WcTZfdCX6lYe3pRHvKru9fLRPr3KK8fZ0u3DV9Jg5SpAZxk1/fnWrdmYrR0niTSP2TbZig==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:38:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:38:10 +0000
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
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgLIUKZLttR6YbA=
Date: Mon, 17 Aug 2026 03:38:09 +0000
Message-ID:
 <SN6PR02MB4157CE7F6C5A11D172444D60D4A72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-2-namjain@linux.microsoft.com>
In-Reply-To: <20260810090716.2325295-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7044:EE_
x-ms-office365-filtering-correlation-id: a325c847-c246-4ab8-6905-08defc10f56b
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|8060799015|8062599012|8022599003|13091999003|19110799012|25010399006|41001999006|37011999003|55001999006|24021099003|18061999006|3412199025|440099028|102099032|2607281247196008|3071699003;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVVOR2NSM0h6Q3NpRTNzY29kemY2VmxEaU4rT0x3WWZtamJOc1lMeDZVNDZP?=
 =?utf-8?B?ek9FM29LTGtvdlJXVTk1QUlxVnlPeU9CYWZNZnZGLzJUVGw1WGo4R0dkYThQ?=
 =?utf-8?B?bDZOa09TODNXeWpGWUR0bWhheTFpLzhJS2ZMM2t5dFFQczN4ajNrQm5ENWJr?=
 =?utf-8?B?Z0c4ZEhJMWcyQXVjV0YwelgvQzJyTElFUUxKUFlPRzFMd1h5OHdWZytqMEJF?=
 =?utf-8?B?WCt6NTlMTWc5UkxZVU9VelBHVUR0SC9EU3Zxd1JucUNHbWxxVlFEYngwcG1W?=
 =?utf-8?B?VTVDOEc2WGQ2bEkwQ2g2dSs4MWhMVnV0d0U1TCtBTlZwamxyWUdGemxyeERB?=
 =?utf-8?B?WEs0YzlIOEFuLzVtT1E1UmJkOGlJdEswT09yN0FuTHplbEt6d2wrZjlzVjlJ?=
 =?utf-8?B?Qy80dzhkZk5TelZBRnhhendITVkva0t2QUJ3MFNQN0l1bzV1WXdKWEZUL0VR?=
 =?utf-8?B?L2VJYjdRbU1sSWdXZzhwYVpnSSsxNjBKU09QNy9UZGMwSXZtbSsxREMvc2ZB?=
 =?utf-8?B?RVVmN05FRDRIaUJhdjNuNGtBUmJicVdRQkNORnJrWU10ek5lQ1VwSnV3eG5j?=
 =?utf-8?B?bGhqL0U2SzVxMitMTVo3ZkROTjkwanhCYVlzOEI2bUxZQUtnZ3NicFlPblA3?=
 =?utf-8?B?bUVFRlp3eEdNUXRWRkoyOGltNG9pR2huQ1JwSTBNNVhrVlZBY1VKZ3QxL0gy?=
 =?utf-8?B?VzFtb1pUMWdCdzNpc0dFTVAzeUI1RndhSnIzWGlXM2NkOTd4UTc2eG54WUVv?=
 =?utf-8?B?NG5JQ3N5RHdlL3BIdmYrUGdqeWxuRlVtN0czMjd1K0dYWFEyNmRjRWVPMFVw?=
 =?utf-8?B?bkJIZ0lmLzM0ek5aNDFXZjV1NTlyT1Jic3BGblMvOFZxWGVjL29iaEs1YWNC?=
 =?utf-8?B?MmdFSWt3UC9ybWFncWxuSVNsajNKM2ozZi9DR1oxSS9ZSXBoSDNJakFPVjdF?=
 =?utf-8?B?dTFKdUh4RUh5U0ZYTGM1WWhXVjl1NmoybmcrTnpwRTBnM0JVWkU3VGhQQVBQ?=
 =?utf-8?B?UTJyZnlTSER3SnRDNjkrRy8vekUyNmRzVWx0amZnNUtUNkVCQk1ZZ2pTRmE2?=
 =?utf-8?B?SC9IUU96MlJsZ3gxakt0M2xsMDJMVFF3N3NkVnNuOXZpbVB0bG1XbllPQXhI?=
 =?utf-8?B?SEo5V1FkMTlrc2FDSU5zSFBMaGovWXI1M0pjNmpEWlpyRGwvY0t0N0NwOTNN?=
 =?utf-8?B?RklldTRvV2NLUnhOTEhUOTFiZ1FxRmtJbXZsTVUyQ0NHZWNxaUhrSmpTMEtR?=
 =?utf-8?B?Ti95VEE0Ulk0c1A0TnlhbkRhbzZQNTN2cDVYSmFrM0c3QmZ1TGRua3JNd0d0?=
 =?utf-8?B?SHE5WTg4aEJEM3YxUnQ2eHAvNlNDQXlTVW9pNVh4UUUwSDkrSlhha1A1U1VH?=
 =?utf-8?B?bllYT1AxajJVN1IwbFN6aUhvajVMOEV0UWlwM2NMUXBLNm1rWWw5TVFtcHhJ?=
 =?utf-8?B?ZElQc29NV3pjRkNKcXhNRWxGdXdKNlM0d29hMHd3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWhQQWtKV1VEREg0VTI1ZDNUQ1U3cnhHWVlOT2lHZXFvQzJ3ZktFY3U0WGsr?=
 =?utf-8?B?QjI4c2lCNTUzTkd6d2tPanFYMjZJdm53aTEyalc3WU1YNDkzLyt3WU5MSXpl?=
 =?utf-8?B?TWZHUElxSWtSeS9LSUJIR1FFUHdBeFAvQnNDQk5zQUxDcHRoZUdDU2w0Zjhj?=
 =?utf-8?B?cFJUZjRhajZhbUpQT3dha2hCMURUZ2U5U1VUYlp6U1l3ZjhkVW0zbGJtMklS?=
 =?utf-8?B?dFZkS2ZrN1VDeDQxZU5EMUtJaU5IZFh4QlZtaU9JZ0ROc1NhYjEydC9UWGVZ?=
 =?utf-8?B?MEE2NkVxbDJXbFQrYlk3NlF6Skdha3VmM0E3ODh0MEMrWGpKaFJTaFhSbnhE?=
 =?utf-8?B?TEd2WXJEa1FkNk5LOURnUHV4WWg3djhxWFpBQlVJRDMrRGVJRU0xbGhvM3NQ?=
 =?utf-8?B?akFGcFJuNEJ4aEw2UTY2MndhaWpuTFlpOHUrdkM5Y0xEYkRPc1B1SDVMOWxu?=
 =?utf-8?B?UWl2MGZ4SWcwc1dmZ2x6V0ZoeWxwVEkycUp2MEpQVE56Y0NUWFhOOUJjaXZJ?=
 =?utf-8?B?eGZsRTlKOEJiSGZZeXFXUElLTDMwTHl4UHpZZUp4b1pNT1hPQ00yVy9WbXB2?=
 =?utf-8?B?MHd1SElQRllHNVpZbnNjSm5CcDJwQjRyREtMaGZFdGpJTXdKRktCZXFhaWpp?=
 =?utf-8?B?c3lIZWxOTTMvTnpmSllrRzhwaVFuZC9lNzNqRzFDejVETjkvQXluUmN1NGl3?=
 =?utf-8?B?TFVYTDhmdTc1eGNTdTQ1MnJETlFEZFlLL2FGVHlucFVVbG1MdVgzVXRSUXhz?=
 =?utf-8?B?QVlnVWY1RHJjZnR6MFpJVCtSTS9HQzh2OXhPR0ttL09TVi9uT3AwM1lHbXZr?=
 =?utf-8?B?ZHlqTDhPVWhNeTR4andzMHZKZjNFYnFPMWYzZm9ZTDcxNWNsMkFTVkp2dEtw?=
 =?utf-8?B?VzRPM3F3c1BPcEdDbzk0MWZVSVV1cUZ5MGRuYXBiT3hNNExIVUt1b2tFeHYx?=
 =?utf-8?B?YmZzOWFobFZJeHA0R2x3LytSaG5HbWdCL1VyZlhtaWw0SXFGbitFZTFKcE12?=
 =?utf-8?B?TzUxL2hhaEhyNHZuOVFYemQwSnN4U1Jsa0hjQ2xGaWVpZDRJbzBxemQ2U3Jt?=
 =?utf-8?B?M2Y4RjYrWXBRaDFWYm1kV2hIYkdRTlBQR3lGKzh4dDl2d0FPWnRNckRPcUVu?=
 =?utf-8?B?d013Z2lTbWpzNGRuQXVFdlVocmt2dndUenBobWh5TmlZc2dFc2VMaHJvZDZL?=
 =?utf-8?B?M3pLeDBnY0ZUK3dWZjNhUU83L0p1UlUzbFVURi9ocGVWdEQzU2lEZ0o5UDZF?=
 =?utf-8?B?VGVwQ3VDOTMvc0JFWllhRTFhK2V3Z202bGR1b3kvd0h5SGpRREt3aGFVZlpp?=
 =?utf-8?B?dzBzNVlyODgxQlQ0bGI0R3ByQmY5VTcrRWlzNlV1bFNzbTJSd2Z5d29nKytK?=
 =?utf-8?B?N2p6QkJ4TzdQSVptNDVxYWdEL0pnTUkyQXhoeUxkMjZRekZ4ODJQMVRUYm0w?=
 =?utf-8?B?ZjZiNk1NRmsyZVh5MFlzMTZyamwvR2s3SXZaN0VEV3hwU1dCR2UrWTdwSCtG?=
 =?utf-8?B?dmlaeFJiY3R2dHdBMlpyYktUSVR5VzJzd3BsWVI5QXVNMzY5VDc2UU9yYmo4?=
 =?utf-8?B?V2dwOGhTRXIrUG0zbWNmTmF3SVVCN2ZkVEVVTE91TjErV0EwcGxieEpZU3hE?=
 =?utf-8?B?UThHVWczVHFZc1N3cUlHTVYxdGVWRm1ERXJDVzNxSFgwWkJVQmVGNDlWcFpj?=
 =?utf-8?B?eVdxc2lYOWo1U29TUHZLdjMrS2krcXUvd2VQVnl4U2Jnc0RxQlJidGRlNFh2?=
 =?utf-8?B?d3BaRlFFZ0FYL1VieU8vanNxTUQzcDJBZmhHcmw2elJwVUJDR1doTmhReWRX?=
 =?utf-8?Q?bnbK+/eS25Q2JIfwNc4owMYg8eaubs1AabAoY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a325c847-c246-4ab8-6905-08defc10f56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 03:38:10.0011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044

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
dCBDUFUgdmlhIHRoZSBwYXJlbnQgeDg2IHZlY3RvciBkb21haW4uDQoNClRoZSBSRkMgdmVyc2lv
biBvZiB0aGlzIHBhdGNoIHNldCBsaXN0ZWQgdGhlIGFzeW5jaHJvbm91cyBuYXR1cmUNCm9mIHRo
ZSBIVkNBTExfUkVUQVJHRVRfSU5URVJSVVBUIGh5cGVyY2FsbCBhcyBhIGNhdXNlIG9mIHRoZQ0K
cHJvYmxlbS4gSXMgdGhhdCBoeXBlcmNhbGwgc3RpbGwgYmVsaWV2ZWQgdG8gYmUgYXN5bmNocm9u
b3VzPw0KTXkgdW5kZXJzdGFuZGluZyBvZiAiYXN5bmNocm9ub3VzIiB3b3VsZCBiZSB0aGF0IEh5
cGVyLVYNCmRvZXMgbm90IGd1YXJhbnRlZSB0aGF0IHRoZSByZXRhcmdldGluZyBvZiB0aGUgaW50
ZXJydXB0IHRvIGEgbmV3DQp2Q1BVIGhhcyBvY2N1cnJlZCB3aGVuIHRoZSBoeXBlcmNhbGwgcmV0
dXJucy4gVGhlcmUgaXMgYW4NCnVuc3BlY2lmaWVkIHRpbWUgcGVyaW9kIGR1cmluZyB3aGljaCB0
aGUgaW50ZXJydXB0IGNvdWxkIHN0aWxsIGJlDQpkaXJlY3RlZCB0byB0aGUgdkNQVSB0aGF0IGlz
IGdvaW5nIG9mZmxpbmUuIEZ1cnRoZXJtb3JlLCBIeXBlci1WDQpwcm92aWRlcyBubyByZW5kZXp2
b3VzIG1lY2hhbmlzbSBmb3IgdGhlIGd1ZXN0IHRvIGtub3cgd2hlbg0KdGhlIGludGVycnVwdCBp
cyBndWFyYW50ZWVkIHRvIGdvIHRvIHRoZSBuZXcgdkNQVS4NCg0KSWYgdGhlIGFzeW5jIGJlaGF2
aW9yIGlzIGluZGVlZCBwcmVzZW50LCBpc24ndCBpdCBhIHByb2JsZW0sIGV2ZW4NCmFmdGVyIHRo
aXMgcGF0Y2g/IGlycV9taWdyYXRlX2FsbF9vZmZfdGhpc19jcHUoKSBjYXVzZXMgdGhlDQpSRVRB
UkdFVF9JTlRFUlJVUFQgaHlwZXJjYWxsIHRvIGJlIG1hZGUsIGJ1dCBhIG5ldyBpbnRlcnJ1cHQN
CmNvdWxkIHN0aWxsIGJlIGdlbmVyYXRlZCB0byB0aGUgZ29pbmctb2ZmbGluZSB2Q1BVIGFmdGVy
IGZpeHVwX2lycXMoKQ0KcnVucyBpdHMgbG9vcCBzZWFyY2hpbmcgZm9yIGFueSBwZW5kaW5nIGlu
dGVycnVwdHMuIEEgbmV3IHN1Y2gNCmludGVycnVwdCB3b3VsZCBiZSBsb3N0LiBUaGUgMSBtaWxs
aXNlY29uZCBkZWxheSBpbiBmaXh1cF9pcnFzKCkNCnByb2JhYmx5IG1pdGlnYXRlcyB0aGlzIHBy
b2JsZW0gYnkgZ2l2aW5nIEh5cGVyLVYgdGltZSB0byBjb21wbGV0ZQ0KdGhlIHJldGFyZ2V0aW5n
LiBCdXQgaXQncyBub3QgYSAxMDAlIHNvbHV0aW9uLg0KDQpBc3N1bWluZyBteSB0aGlua2luZyBp
cyBjb3JyZWN0LCB0aGVyZSBpc24ndCBhIDEwMCUgc29sdXRpb24uIEJ1dA0KdGhlIHByb2JsZW0n
cyBleGlzdGVuY2UsIGFuZCB0aGUgbGlrZWx5IGJlbmVmaXQgb2YgdGhlIDEgbXMgZGVsYXksDQpz
aG91bGQgYmUgY2FsbGVkIG91dCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kL29yIGNvZGUNCmNv
bW1lbnRzIGZvciBmdXR1cmUgcmVhZGVycy4NCg0KSSBhbHNvIHdvbmRlcmVkIGFib3V0IGFybTY0
IHdoZXJlIEh5cGVyLVYgcHJvdmlkZXMgYW4NCmVtdWxhdGVkIEdJQ3YzLiBUaGUgUkVUQVJHRVRf
SU5URVJSVVBUIGh5cGVyY2FsbCBpcyBub3QNCnVzZWQgc2luY2UgdGhlIHJldGFyZ2V0aW5nIGlz
IGRvbmUgYnkgd3JpdGluZyB0byBhIEdJQ0QgcmVnaXN0ZXIuDQpQcmVzdW1hYmx5IG9uIHJlYWwg
R0lDdjMgaGFyZHdhcmUsIGFmdGVyIHRoZSB3cml0ZSB0aGUgbmV3DQpDUFUgaXMgZ3VhcmFudGVl
ZCB0byByZWNlaXZlIGFueSBzdWJzZXF1ZW50IGludGVycnVwdHMuIEFuZCBpZg0KYW4gaW50ZXJy
dXB0IHdhcyBwZW5kaW5nIGF0IHRoZSB0aW1lIG9mIHRoZSB3cml0ZSwgdGhlIGFwcHJvcHJpYXRl
DQp0cmlnZ2VyIGhhcHBlbnMgaW4gdGhlIG5ldyBDUFUsIHNvIGV2ZXJ5dGhpbmcgd29ya3MuIEFz
IGxvbmcNCmFzIEh5cGVyLVYgaXMgZG9pbmcgdGhlIGVtdWxhdGlvbiB0aGUgc2FtZSB3YXkgKGku
ZS4sIGZ1bGx5DQpzeW5jaHJvbm91c2x5KSwgdGhlIHByb2JsZW0gd291bGQgbm90IG9jY3VyIG9u
IGFybTY0DQpndWVzdHMuDQoNCkknbSByZW1pbmRlZCB0aGF0IGEgc2ltaWxhciBwcm9ibGVtIG9j
Y3VycmVkIHdpdGggY2hhbmdpbmcNCnRoZSB0YXJnZXQgQ1BVIGZvciBhIFZNQnVzIGNoYW5uZWwg
aW50ZXJydXB0LiBUaGUgaW5pdGlhbA0KSHlwZXItViBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgVk1C
dXMgTU9ESUZZQ0hBTk5FTA0KbWVzc2FnZSB3YXMgYXN5bmNocm9ub3VzLCB3aGljaCBjYXVzZWQg
dGhlIHNhbWUgcHJvYmxlbQ0KYXMgc2VlbiBoZXJlIGlmIGEgdkNQVSB3ZXJlIHRvIGJlIHRha2Vu
IG9mZmxpbmUuIEEgbGF0ZXIgdmVyc2lvbg0Kb2YgdGhlIFZNQnVzIHByb3RvY29sIGFkZGVkIGEg
bm90aWZpY2F0aW9uIHRoYXQgdGhlIGNoYW5nZSB0bw0KdGhlIHRhcmdldCB2Q1BVIGlzIGNvbXBs
ZXRlLCB3aGljaCBzb2x2ZXMgdGhlIHByb2JsZW0uIFNlZQ0Kdm1idXNfY2hhbm5lbF9zZXRfY3B1
KCkgYW5kIHZtYnVzX3NlbmRfbW9kaWZ5Y2hhbm5lbCgpDQphbmQgdGhlIGFzc29jaWF0ZWQgY29k
ZSBjb21tZW50cy4NCg0KTWljaGFlbA0KDQo+IA0KPiBGaXhlczogNGRhYWNlMGQ4Y2U4NSAoIlBD
STogaHY6IEFkZCBwYXJhdmlydHVhbCBQQ0kgZnJvbnQtZW5kIGZvciBNaWNyb3NvZnQgSHlwZXIt
ViBWTXMiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWdnZXN0ZWQtYnk6IExv
bmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVp
eG5lciA8dGdseEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQWRpdHlhIEdhcmcgPGdhcmdh
ZGl0eWFAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFNocmFkaGEgR3VwdGEg
PHNocmFkaGFndXB0YUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBOYW1h
biBKYWluIDxuYW1qYWluQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWh5cGVydi5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gaW5kZXgg
Y2ZjOGZhNDAzZGFkNi4uODk4MTZhMmJkN2NkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2ktaHlwZXJ2LmMNCj4gQEAgLTIxMTksNiArMjExOSw3IEBAIHN0YXRpYyBib29sIGh2X3BjaWVf
aW5pdF9kZXZfbXNpX2luZm8oc3RydWN0IGRldmljZSAqZGV2LA0KPiBzdHJ1Y3QgaXJxX2RvbWFp
biAqZG9tDQo+ICAJaW5mby0+b3BzLT5tc2lfcHJlcGFyZSA9IGh2X21zaV9wcmVwYXJlOw0KPiAN
Cj4gIAljaGlwLT5pcnFfc2V0X2FmZmluaXR5ID0gaXJxX2NoaXBfc2V0X2FmZmluaXR5X3BhcmVu
dDsNCj4gKwljaGlwLT5pcnFfcmV0cmlnZ2VyID0gaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNo
eTsNCj4gDQo+ICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4NikpDQo+ICAJCWNoaXAtPmZsYWdz
IHw9IElSUUNISVBfTU9WRV9ERUZFUlJFRDsNCj4gLS0NCj4gMi40My4wDQo+IA0KDQo=
