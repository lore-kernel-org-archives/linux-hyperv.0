Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012013.outbound.protection.outlook.com [52.103.23.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620D463B6A;
	Mon, 17 Aug 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986851; cv=fail; b=i1U5DhoBXUlpQ2QI5VvYqPrrr6wlyb7HvMJHgl0EacqCNb9tTGfCSNGbBAXdbr1+D1WdffeZ21g0pxESuCH6355zOrxdM5Hwoe+5cYkB8iqc8fsFYc2fYcgSv1qNTMKoGSTRE3MJYcyWGeVrwkMrmlsiEbOQWa+5mRZ/3GXO0ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986851; c=relaxed/simple;
	bh=3XNvUueQTyejqeBpd7NWgolMzVnaxZ6uN+96FEQT8iI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hIx1xSX0XNFifbs/l2+ZWKzSyyGVN1xP4sOggGStTYhrrapV8/EP5ApS7leZHPxQ554W2E+nrMYuQNSs42qFLz3Otg+XcwX+HSRNUYTfItf1y9HEre3EYLfH2SdP2aQ1mUHm/xCrl3gtv+9hObCTOyAiBj4Df3So4+MNZ5gF3RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MQSW5NQ9; arc=fail smtp.client-ip=52.103.23.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MQSW5NQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRXmOE4tCg0IjlGgWwpdGzI2q5/CTVhyW/6W2AvYyl+yAM1MpeKJrtcBVKK4V/mkToNLz+JHkUASmxORGfLGiF7LTaim3NWIXrA47A9hCXCGVA6hTnthnwoIWDhK5+Xrugz5LiqQy/toWScGRY0JsMEz66RqsIVMVcuzW73+M7OXSTBVvmWxDxfj7xchlkL1lnm1e51i/vt1FkI7d+78YcjNAtplEJPugd5iJtM0XXPxvG3tfeWMZR9qZRUuW1EAijdnagyJ95NkJy871UhEbFN5aSZdibkVTGxWnZvA3442IvB5N7RdRu/Q9MkXYlWUxXsgOTGiPY/ZctZEY6v2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XNvUueQTyejqeBpd7NWgolMzVnaxZ6uN+96FEQT8iI=;
 b=B7MaaBaEmxet661tCofZovz9uWsaRZ/PJDTWRqfbPnM4sfOLhP7VyIoHqwLPHxrT7nCWSc+WRPXjEMyEw1zAWVjgjV5ikTne/U4M4l9SwEQXnE1f1Thw6miR4vh0D5CDAmqwcAvp58pMtUTiVOqxkSnDVxkYB70nN723BLT6L9nawylFIK+cwmmlqBL/sV7oziVZZHz5iXLueqMreIizMnZbbuf1fVp6dbrkREErWtHG6ONTH9rnqqCRFyCptc1SyVCioVfF4lSIItF9LJOIaBiVAHg3XTaZkiiwxLlkUcN7KDWVVRMqz2t3aCMwohbnQoSELrJJZqYTWooWTuTyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XNvUueQTyejqeBpd7NWgolMzVnaxZ6uN+96FEQT8iI=;
 b=MQSW5NQ9EQYelGHTdEijoLaiAjCQNIW2yyCG614A2ZKsoZHeHJkUg7H4k3XzctgL+FXXwGWatS1DxpLSmpkFPFtDo+PtUHne8vQCrFWQZvalsax2WFBD1zgkEko64Qtvh/bTOjgSkZJMmWSrd/hvSFCenxjlixgr+mgB6wUbM0XlQw1jHJ0oVPe/Ok+uIwQ8dwafAwqZG0lzcWtpsZYVCcjzEzXaqnxLpRJ2COVDW9YOsIEj9+c2K5rUJwIN4mG/jdjKe1DKQv77MD3oILLyxxU3HWdK/d+jMTAYhL7JidaxEkmCKQrnvDpFgMNzUXH8Gt2nqheyX+iiXzXaFmOPEw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CHXPR02MB11380.namprd02.prod.outlook.com (2603:10b6:610:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:14:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 17:14:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
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
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgLIUKZLttR6YbCAAJ4iAIAANrAAgAAc1gA=
Date: Mon, 17 Aug 2026 17:14:06 +0000
Message-ID:
 <SN6PR02MB4157FD17AB10BC8D763179B2D4A72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157CE7F6C5A11D172444D60D4A72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <68315782-3695-4e16-a990-3a1c41cb7476@linux.microsoft.com>
 <bed153ef-1cc4-4c27-9cfb-88afc2f73a3a@linux.microsoft.com>
In-Reply-To: <bed153ef-1cc4-4c27-9cfb-88afc2f73a3a@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CHXPR02MB11380:EE_
x-ms-office365-filtering-correlation-id: 6daa931c-35b6-4a1e-779a-08defc82f1cf
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|25010399006|24021099003|31061999003|15080799012|51005399006|55001999006|13091999003|8060799015|8062599012|19110799012|18061999006|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUhocDVOdVNVOEwwT0YwVEhnZUk4VVVSMUZ5Qkt2TkVrTUtTUnlXMWZzZjdR?=
 =?utf-8?B?Z21EVjhxMXBKRXJVWkNITmV1M0trQ2JZN2d2KzhyemhPMUcxOTAvdy9PMU50?=
 =?utf-8?B?Yk5MSjFZVUdWeVVmWUcvYWF5by9Mc1pMenI1MVFJWDVLMUhhQ0lrTE1jQ3kw?=
 =?utf-8?B?bXpxbjRJN1d6Zm9ub0RnL3hQa3cxMUE5VnNNdk1RR01YTExRdXIydk9MK01z?=
 =?utf-8?B?UkhYOHZpMS9LQmpTY3FFMzBDNElGeDIxOG9uendDazQxQVhldnR2QlBGeEFm?=
 =?utf-8?B?TnRlb1BHRys4a0dmMytINDFEcFBTYnJEOXoxa0NVeVp4bW9JdHhVVmYrbWZq?=
 =?utf-8?B?dGQrM2taWmRFcDh2enRWRFJDbVBwTE9sVnhLOWRwUDB6LzEvdkFLTDR0RFdn?=
 =?utf-8?B?TXhOeGkxTXphYzh3ZWRaU2ZWcTRGTXhGWlBuclVJZnNFaUQ3NXRsNTNraElO?=
 =?utf-8?B?N1Q4SlFPaFFLTkRtOVpoSldJTGR5cGcyWUtBS0EyK050RmNUYUlPekhvM2xj?=
 =?utf-8?B?MnhtNTJvUEdrYlFZa09kRnlXMGJEOEVCVVR6MHozVUJLanlob2cwSlptQlRq?=
 =?utf-8?B?clhRYkZpUzhJekp2bDRJSEYyV3JjTlZyb2hFS2JLVmlYdVhha3JQSnNPUGgy?=
 =?utf-8?B?NDlnWjZYbG9hT2p1d3RGNGh2Y2dOeDZHOGk0bDZpRWZsQWxXbWY3Zi9kemZX?=
 =?utf-8?B?aWx0eVNqS3U4eWtzdGZzSUpGVGxWL3pNSjRsdTlHbnl0RnBNb0Ntc0h3aGQx?=
 =?utf-8?B?Ylp3bzlUU0hlRjZpdXRmVXgxNVRaeU1tRHJBT1dPR3pjbWlXRkljZkh0M3F5?=
 =?utf-8?B?SzdaMzdTbE1pSm51WUQ0STB3Vkx6RWx4N1VqaDRCWXFJTmFVdTV1TUZnbkJo?=
 =?utf-8?B?Y3hnTTc3LzFSSWpRN1RhdDVnb29HT1RQOWEwTExaajFmZlhMSThvTGNySDZm?=
 =?utf-8?B?SmJzZDg5TFJFZlJSNmRQU3RDcWlabS9lVDMrb0xDd2VSWndzdXVZWDBrWFJk?=
 =?utf-8?B?SXA1dFhramNlcHJOVFVzdUN6ekFjVDk4M2E3OFBES0dvU3AxT1RJUFQ3cjIr?=
 =?utf-8?B?YnkvSmhxU1lXTXJGSGN5Q3U2cklLN2QxenQ5MUdzS2FSZG1jdU1Md052OEdW?=
 =?utf-8?B?ME1FUWFDZ0RQWFpONlJXV3IwNDV3aXRGak15RGs0a2gyUCttVkk5RGNGRElX?=
 =?utf-8?B?Z2I4VE1IU3NueUR5WloybEFtRDR6ZE1NNEs2Y2JGQm1RQ2E1bmY5MUNNOVlh?=
 =?utf-8?B?UWU4SGlTcmJDY3plVHBvRnUvRS85Y3hYb082TjhxZ2lqaTdFbGh1L0c5QVBn?=
 =?utf-8?B?Z3RsYy9nUExkcUdSaDFLVXVIdGpTbDM3R3JvQlhzYjNMRVczNjlFYTc0d2l4?=
 =?utf-8?B?ejBlRzU5eEswNjQvVVVZWjFIblFsR1N1S3k5Z1I0QngxZUdmdjlPckN1TzNh?=
 =?utf-8?B?WWFwSmIxR3NqUTJKYitQVEVQc0p3MnN0bDVBOEZ3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXRROFU3Z3B4VXBsdlE3ejRnR29wTUhsenp6MDIwa3RPZjZzbTRsRE9hSnhW?=
 =?utf-8?B?OTRVd2xWVmJzbElNZWxNYnVqOUZtUk5xNnlyUnVQNnhVUUcvMDVsMk5UcDg1?=
 =?utf-8?B?T242dVM3bVBwM3Q5ZG1ZVGtDMVMrZWZHOC9ReUtnNGpsODlTaGVHN2hnNmVT?=
 =?utf-8?B?eE5HOUMrQU5IRUs4KzdJM09vZjcrNGZRUU9Dc05Fb08ya0NGU1cxdEltU3p1?=
 =?utf-8?B?SzZCT3RNTzlXeXMvSXRJcEg3SVdIcWlTZGVHalRZb3czSVBTb2xIaWNXVGxL?=
 =?utf-8?B?OXRveWNqTW1GdjFhakh2WkZzTkNiWng1MENjaG5vRmxCdDB5VG1GNitlVmhl?=
 =?utf-8?B?TWtaM2hYV2trcDJnMk1mYTBta3llelJtRUNFTWdwS1ZTQ3dkaFNzRW9xNjFD?=
 =?utf-8?B?TVFnb3JqQWFMOHdNTnZyTm42ZVIwcCtISXkrb05HaisxNjdmVmhLZGdLOHdi?=
 =?utf-8?B?aVRRd1Q4dm51RlBxT0M1WU9EREhoNk94TGhWN2E1bHltS0JkaEhmN2wvU2tq?=
 =?utf-8?B?TXN2QkZjOEJ2TXgzQklGRnB0Mjd5aGxZSGlBVmRHWWVRWjZLRU9JeWVTZWZB?=
 =?utf-8?B?dTllYmU2cTlNQm56c3lTNG9YMUEzOXZ3ZEhwbzMvSmliT2laVFBucHFiV0J2?=
 =?utf-8?B?eXMyUCtwdHBpeisxWWpqMHBoOTRDYTNiNks4OHdxNHF2QkdINTlmNlJwR3BP?=
 =?utf-8?B?cVBxL1NzQmEvU2dMMDF3eGRQRTQ5ak9iVmhKY2JEa3NWK203eElxTVZ2ZmVP?=
 =?utf-8?B?YVlsUHRRZWhJdFloWkJkUmlNMlIxbnRHRmRVZGhTL1lkMnlYcmxNdFdrZTIw?=
 =?utf-8?B?WWpXVlVhYit5Qnh4K05qYzBsMnkvUkIwanp3bzVicjBoZ1BTZGlLNnZaRi9W?=
 =?utf-8?B?QTJEN05jcGlRQWxuUHZxYi94aEtXSTJhaGYzTE10UFNqRnpSQjMyNDFDbzhJ?=
 =?utf-8?B?YU9Odm9RVzJxZGVYVmkwaVZETm4xMnk2MDB4bXFOelNNekYycUVjTys5TFhU?=
 =?utf-8?B?WG1yZlJhV3piZUVKNzlCN1dtVjc0bXp0QXdkelN1QWx2WExYc0tmUHQ2S0E3?=
 =?utf-8?B?am9WY05COWtOVStRODNTMlQ0WW82K1YyREorL01xb2FCZW5yT1h6UFc5TnVL?=
 =?utf-8?B?cnczOWNJbHhJbWNDallPSERESm1zYnZ1NjkrR2NDOWQzd25rS00zK2FZQjlK?=
 =?utf-8?B?Kyt3Y0puTk53ek8xSnVLN291a0J0ZWNrSysyWkZkWDMxUWtjUkc5cU1KejRi?=
 =?utf-8?B?c0NwMUtnK2ptZ3ZPM1h6cHprM3c2alYvQmJoVmd6THA5MGpHWFduOUxQd0tl?=
 =?utf-8?B?dWlMWVRmQnUwdWpmMjNhSVBaRjBFa3E0K3BhRmx0N3pVZmluSCtHbHFhd1RW?=
 =?utf-8?B?eXNwaUtnNFFPbDZwQmx4cFhzSHdzd0VBVW1jMTVkdzkvUjZBdkpQc2lxV052?=
 =?utf-8?B?VFFQU0pqUjBUaEl5RDhWZVVweEZtb3M4ZW9ic3pEVkg4bnl0MzlGVU95TVpr?=
 =?utf-8?B?Mm1MdFh5SUNUMThsa3ZXeU9lbzdUdkFQVnc3QWhyeFA1OVc4anV3TXVqd2Yy?=
 =?utf-8?B?cWlwR21SZ25teXgvaFpHdFBNMkg4MEpndjdnUm05OGV4YUNPcFppS040WUZ4?=
 =?utf-8?B?TEc4ZEZJM1hjcTRTV08yZExhbVBlTVZzeWYwY0FOMExjY0dhYlp4MmFIb29V?=
 =?utf-8?B?M04ybDhVRUM1cTlWTjlyYmF4QVFId2MyOWpuMENxOHA0Y3AxODVaNS9oRTVi?=
 =?utf-8?B?YnNLUG1FRjhhSkdQNE55c1lqWHkydmNObjRBOUprdXA0NE1UWWpvdTZBSGd3?=
 =?utf-8?Q?qLWee75qzshMGYw6cWxoIl3ryPkR0Q4KitXT4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6daa931c-35b6-4a1e-779a-08defc82f1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 17:14:06.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR02MB11380

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEF1Z3VzdCAxNywgMjAyNiA4OjMxIEFNDQo+IA0KPiBPbiA4LzE3LzIwMjYgNTo0NSBQTSwg
TmFtYW4gSmFpbiB3cm90ZToNCj4gPg0KPiA+IE9uIDgvMTcvMjAyNiA5OjA4IEFNLCBNaWNoYWVs
IEtlbGxleSB3cm90ZToNCj4gPj4gRnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNy
b3NvZnQuY29tPiBTZW50OiBNb25kYXksIEF1Z3VzdA0KPiA+PiAxMCwgMjAyNiAyOjA3IEFNDQo+
ID4+Pg0KPiA+Pj4gVGhlIEh5cGVyLVYgdlBDSSBNU0kgaXJxY2hpcCBuZXZlciBpbnN0YWxscyBh
biBpcnFfcmV0cmlnZ2VyKCkgY2FsbGJhY2suDQo+ID4+Pg0KPiA+Pj4gT24gQ1BVIGhvdC11bnBs
dWcgZml4dXBfaXJxcygpIG1pZ3JhdGVzIHRoZSBpbnRlcnJ1cHRzIHdoaWNoIGFyZSBhZmZpbmUg
dG8NCj4gPj4+IHRoZSBvdXRnb2luZyBDUFUgdG8gYSBuZXcgdGFyZ2V0LiBJZiBhbiBpbnRlcnJ1
cHQgc3RpbGwgaGFzIGl0cyBwZW5kaW5nIGJpdA0KPiA+Pj4gc2V0IGluIHRoZSBvdXRnb2luZyBD
UFUncyBJUlIgYXQgdGhhdCBwb2ludCwgZml4dXBfaXJxcygpIHJlc2VuZHMgaXQgb24gdGhlDQo+
ID4+PiBuZXcgdGFyZ2V0IHRocm91Z2ggdGhlIGlycWNoaXAncyBpcnFfcmV0cmlnZ2VyKCkgY2Fs
bGJhY2suIEFzIHRoZSBIeXBlci1WDQo+ID4+PiBQQ0kvTVNJIGNoaXAgZG9lcyBub3QgcHJvdmlk
ZSB0aGF0IGNhbGxiYWNrLCB0aGUgcGVuZGluZyBpbnRlcnJ1cHQgaXMNCj4gPj4+IHNpbGVudGx5
IGRyb3BwZWQsIHdoaWNoIGNhbiByZXN1bHQgaW4gbG9zdCBpbnRlcnJ1cHRzLCBzdGFsbHMgYW5k
ICJObyBpcnENCj4gPj4+IGhhbmRsZXIgZm9yIHZlY3RvciIgbWVzc2FnZXMgZHVyaW5nIENQVSBo
b3RwbHVnLg0KPiA+Pj4NCj4gPj4+IEluc3RhbGwgaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNo
eSgpIGFzIHRoZSBpcnFfcmV0cmlnZ2VyKCkgY2FsbGJhY2sgZm9yDQo+ID4+PiB0aGUgSHlwZXIt
ViBQQ0kvTVNJIGlycWNoaXAsIHNvIHRoYXQgYSBwZW5kaW5nIGludGVycnVwdCBpcyByZXNlbnQg
b24gaXRzDQo+ID4+PiBuZXcgdGFyZ2V0IENQVSB2aWEgdGhlIHBhcmVudCB4ODYgdmVjdG9yIGRv
bWFpbi4NCj4gPj4NCj4gPj4gVGhlIFJGQyB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggc2V0IGxpc3Rl
ZCB0aGUgYXN5bmNocm9ub3VzIG5hdHVyZQ0KPiA+PiBvZiB0aGUgSFZDQUxMX1JFVEFSR0VUX0lO
VEVSUlVQVCBoeXBlcmNhbGwgYXMgYSBjYXVzZSBvZiB0aGUNCj4gPj4gcHJvYmxlbS4gSXMgdGhh
dCBoeXBlcmNhbGwgc3RpbGwgYmVsaWV2ZWQgdG8gYmUgYXN5bmNocm9ub3VzPw0KPiA+PiBNeSB1
bmRlcnN0YW5kaW5nIG9mICJhc3luY2hyb25vdXMiIHdvdWxkIGJlIHRoYXQgSHlwZXItVg0KPiA+
PiBkb2VzIG5vdCBndWFyYW50ZWUgdGhhdCB0aGUgcmV0YXJnZXRpbmcgb2YgdGhlIGludGVycnVw
dCB0byBhIG5ldw0KPiA+PiB2Q1BVIGhhcyBvY2N1cnJlZCB3aGVuIHRoZSBoeXBlcmNhbGwgcmV0
dXJucy4gVGhlcmUgaXMgYW4NCj4gPj4gdW5zcGVjaWZpZWQgdGltZSBwZXJpb2QgZHVyaW5nIHdo
aWNoIHRoZSBpbnRlcnJ1cHQgY291bGQgc3RpbGwgYmUNCj4gPj4gZGlyZWN0ZWQgdG8gdGhlIHZD
UFUgdGhhdCBpcyBnb2luZyBvZmZsaW5lLiBGdXJ0aGVybW9yZSwgSHlwZXItVg0KPiA+PiBwcm92
aWRlcyBubyByZW5kZXp2b3VzIG1lY2hhbmlzbSBmb3IgdGhlIGd1ZXN0IHRvIGtub3cgd2hlbg0K
PiA+PiB0aGUgaW50ZXJydXB0IGlzIGd1YXJhbnRlZWQgdG8gZ28gdG8gdGhlIG5ldyB2Q1BVLg0K
PiA+Pg0KPiA+PiBJZiB0aGUgYXN5bmMgYmVoYXZpb3IgaXMgaW5kZWVkIHByZXNlbnQsIGlzbid0
IGl0IGEgcHJvYmxlbSwgZXZlbg0KPiA+PiBhZnRlciB0aGlzIHBhdGNoPyBpcnFfbWlncmF0ZV9h
bGxfb2ZmX3RoaXNfY3B1KCkgY2F1c2VzIHRoZQ0KPiA+PiBSRVRBUkdFVF9JTlRFUlJVUFQgaHlw
ZXJjYWxsIHRvIGJlIG1hZGUsIGJ1dCBhIG5ldyBpbnRlcnJ1cHQNCj4gPj4gY291bGQgc3RpbGwg
YmUgZ2VuZXJhdGVkIHRvIHRoZSBnb2luZy1vZmZsaW5lIHZDUFUgYWZ0ZXIgZml4dXBfaXJxcygp
DQo+ID4+IHJ1bnMgaXRzIGxvb3Agc2VhcmNoaW5nIGZvciBhbnkgcGVuZGluZyBpbnRlcnJ1cHRz
LiBBIG5ldyBzdWNoDQo+ID4+IGludGVycnVwdCB3b3VsZCBiZSBsb3N0LiBUaGUgMSBtaWxsaXNl
Y29uZCBkZWxheSBpbiBmaXh1cF9pcnFzKCkNCj4gPj4gcHJvYmFibHkgbWl0aWdhdGVzIHRoaXMg
cHJvYmxlbSBieSBnaXZpbmcgSHlwZXItViB0aW1lIHRvIGNvbXBsZXRlDQo+ID4+IHRoZSByZXRh
cmdldGluZy4gQnV0IGl0J3Mgbm90IGEgMTAwJSBzb2x1dGlvbi4NCj4gPiAgPiA+IEFzc3VtaW5n
IG15IHRoaW5raW5nIGlzIGNvcnJlY3QsIHRoZXJlIGlzbid0IGEgMTAwJSBzb2x1dGlvbi4gQnV0
DQo+ID4+IHRoZSBwcm9ibGVtJ3MgZXhpc3RlbmNlLCBhbmQgdGhlIGxpa2VseSBiZW5lZml0IG9m
IHRoZSAxIG1zIGRlbGF5LA0KPiA+PiBzaG91bGQgYmUgY2FsbGVkIG91dCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UgYW5kL29yIGNvZGUNCj4gPj4gY29tbWVudHMgZm9yIGZ1dHVyZSByZWFkZXJzLg0K
PiA+DQo+ID4gUGxlYXNlIGFsbG93IG1lIHRvIGNvbmZpcm0gd2l0aCB0aGUgSHlwZXItViB0ZWFt
IGludGVybmFsbHkgb25jZS4gSSBtYXkNCj4gPiBoYXZlIGFzc3VtZWQgYXN5bmNocm9ub3VzIGJl
aGF2aW9yIGJlY2F1c2Ugb2YgdGhlIHBlbmRpbmcgaW50ZXJydXB0DQo+ID4gYWZ0ZXIgcmV0YXJn
ZXQuIEl0IGNvdWxkIHNpbXBseSBoYXZlIGJlZW4gY29tbWl0dGVkIHRvIHRoZSBvbGQgcm91dGUN
Cj4gPiBiZWZvcmUgdGhlIHJldGFyZ2V0IG9wZXJhdGlvbi4NCj4gDQo+IFRoaXMgaXMgYWN0dWFs
bHkgc3luY2hyb25vdXMuIFNvIHRoZSBmaXggaW4gdGhpcyBzZXJpZXMgc2hvdWxkIHN1ZmZpY2Uu
DQo+IFNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLg0KPiBJIGRvbid0IHNlZSBhbnkgbWVudGlvbnMg
b2YgYXN5bmNocm9ub3VzIGJlaGF2aW9yIG9mIHRoYXQgaHlwZXJjYWxsDQo+IGFueXdoZXJlIGlu
IHRoZXNlIDMgcGF0Y2hlcywgc28gSSB0aGluayB3ZSBzaG91bGQgYmUgZ29vZC4NCj4gDQoNClRo
YW5rcyBmb3IgZ2V0dGluZyB0aGUgZGVmaW5pdGl2ZSBhbnN3ZXIuIEhhdmluZyBpdCBiZSBhc3lu
YyB3YXMNCmluaXRpYWxseSBwbGF1c2libGUgdG8gbWUgZ2l2ZW4gdGhlIGV4cGVyaWVuY2Ugd2Ug
aGFkIHdpdGggdGhlDQpWTUJ1cyBNT0RJRllDSEFOTkVMIG1lc3NhZ2UuIEJ1dCB1cG9uIGZ1cnRo
ZXIgcmVmbGVjdGlvbiwNCnRoZSBWTUJ1cyBjYXNlIHdhcyByZWFsbHkgbW9yZSBiZWNhdXNlIGl0
IGlzIGEgbWVzc2FnaW5nIHByb3RvY29sDQppbnN0ZWFkIG9mIGEgImNhbGwiLiAgQXMgYSAiY2Fs
bCIsIHRoZSBoeXBlcmNhbGwgcmVhbGx5IHNob3VsZCBiZQ0Kc3luY2hyb25vdXMuIEFuZCB0aGF0
J3MgY29uc2lzdGVudCB3aXRoIHRoZSBhcm02NCBiZWhhdmlvciBvZg0Kc2V0dGluZyB0aGUgR0lD
RCByZWdpc3Rlci4NCg0KV2l0aCB0aGlzIHRvcC1sZXZlbCBxdWVzdGlvbiBub3cgcmVzb2x2ZWQs
IEknbGwgcmV2aWV3IHRoZSBwYXRjaA0Kc2VyaWVzIGF0IGEgbW9yZSBkZXRhaWxlZCBsZXZlbCB0
byBzZWUgaWYgYW55dGhpbmcgZWxzZSBjb21lcyB1cCwNCmJ1dCBpdCBsb29rcyBwcmV0dHkgZ29v
ZCBpbiBteSBpbml0aWFsIHJlYWQtdGhyb3VnaC4NCg0KTWljaGFlbA0K
