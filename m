Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010089.outbound.protection.outlook.com [52.103.10.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACEA385D94;
	Thu, 20 Aug 2026 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201606; cv=fail; b=tm52+QSPimPe8MnqyKt2fDhm/SMOOpmD0Jpq/T0U53Zo8toSXabi6xM4iq35qRn5AaaEuAIg76tbUqVs/0558PZMqyz2JgkFPTC3W/helDfw4P7qt+S/a2MlhtzLXk8hfOmx1jTzEsuzvsDofTxCHK1HXGy7IQmNzwRT6jiD+7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201606; c=relaxed/simple;
	bh=bWUNC7C2ow0cXdrQ2jxD21SWMTaYMsgXcXvyIqM0WRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBk4cNIa8d0qgzcZi+sz5qJ9zYSkdtvQknHKDcm0eC6DejRMV7ccntPbCu/cQSCrLJGEBAx/S0yIGQYN/dHdyXYwyvXh1MIbpHkLJS986Y2OQPMDOOPpuyiBntF55FldqnLn/G0Dw73j6Ai7SPG7gPy71M8kdb7Uo85R5uqruOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SlnJTK5W; arc=fail smtp.client-ip=52.103.10.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SlnJTK5W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF1E1ch6CGabIi9LwfnWtapyg7jUjnTiAW5oDl9YM9XMThAfdlw5Ka36lWG6xylqXijAstTmQWry+IBI6iNI6zJ3ydG7INR1nxz/GnbhUeoz0aZi7blSO3z2AyNOkfXJvIRNDxn42Rxwz7L76gPwojnxCwCgo/b+TVoOzfmOy5LvfMgmlUD8wFt1YU2EBwpAbrao0ypWMfum+hbdkCpb8lb8tMz+Y0lymUzHo8nfkTeOtZmQIgiMVVhwo8WCeT9E6nABCbQtw6Z2ZOJbaV6sUZgI6VDiU0wtsmIRPvXA5EAhVpD1B/5EpfYNBeNqNSZ8iqGx/QKWL2XPjBegQ89+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWUNC7C2ow0cXdrQ2jxD21SWMTaYMsgXcXvyIqM0WRk=;
 b=lBa/3NGe/EhGWtcoCH4iZF1a4OSEjGQPEVshbFG51Mvzzz1KAyrnCDamqzHAAFqkz3ryuW8AfpytHWAGZLhy7bGKuwEsqV3xnwhDqOLeYZ3Rh84w1Srno69VFwR+kg6C8V6NYAciXnVzz5J7WCPX07FjxD5Zkr5M9N3mtRBVwhVdVySL4EFhn8NmWWd6LZLOfmBDzA/Evi6wSkuOVXu7pGLSw5u4vV+VmSRAYeqwETN+KsTyAPOypM16zFdCORNIYG/G2hwsUwKqf4cjYzIekIVlyzTTa1C7rTdrlEqVJPxGDqNxLKqMUkGsn8DNjLDYlj7y0HFlKO5lwgv7MYhk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWUNC7C2ow0cXdrQ2jxD21SWMTaYMsgXcXvyIqM0WRk=;
 b=SlnJTK5W5wwSfmGLG1Iz6OtvLv27jW6BA1C8GOHR3bJ7cujQO4N5UqMOIEXgOp0t0dU4OXgWPfW9ZBxbUv2QFhVgP+wH7xSfrhaSAPe5649heouVDmlLzJNQ9Z1zpubgXvc6BfKQZlXbVrsCVa4BdElZ16VpIWZ1QfiLxSHulX3XRQtK8cCkPSbpZ0MXVDtwIqKejsEFC0AN6HkaGpNlbMV9HNaPIwHJaUDWCwpfvsKKBsGDJwzSff/gg8srtUgUCZRh/zYI9BpbqI14j/bK2qQCR7lM3nD9fYbqutKApTrGZIJWFdQtZkdw87PamQaeO3mi7K6QTIGNl20DEDABnw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10570.namprd02.prod.outlook.com (2603:10b6:303:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 04:53:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 04:53:21 +0000
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
Subject: RE: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Thread-Topic: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Thread-Index:
 AQG4lIWg1CA0E9n3RBnld28Zsf/qhgHTB9rPtt3FEWCAAEDFAIACIFsQgADWkICAAAGXcA==
Date: Thu, 20 Aug 2026 04:53:20 +0000
Message-ID:
 <SN6PR02MB4157B7AC66C79B4BD66EBB72D4A42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-3-namjain@linux.microsoft.com>
 <SN6PR02MB41570E8FC664CAC4A05CAFA9D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <72ccf7d4-0fda-4f55-a47c-27486ef3e159@linux.microsoft.com>
 <SN6PR02MB41574989AE7DB1332F06C66DD4A52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fc7c4d74-d861-4268-8044-fa83748572f4@linux.microsoft.com>
In-Reply-To: <fc7c4d74-d861-4268-8044-fa83748572f4@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10570:EE_
x-ms-office365-filtering-correlation-id: 5b431b64-0d9e-4c16-c3e4-08defe76f576
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|12121999013|13091999003|8062599012|37011999003|25010399006|51005399006|24021099003|55001999006|31061999003|15080799012|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGl4REdTTkNLcFlhQ1VseEtoNnQxcXQ4ZjdqVERBYWxYSDNMa2loTW4rajNF?=
 =?utf-8?B?QndRNm1FRkQ5VGE5V05lYy9jWTZuK2l6Y2xqVmd2cUZaNnVJVDIzTHZnYTJy?=
 =?utf-8?B?YUMvWkpocElnNWRNMmtuZktucy8yaElQSWxBM0VQbGxhU0tYaWhEZXd2TEQ4?=
 =?utf-8?B?ZEdWa21oaW95Y3pqdnRGeWx0dGhPbmxqQnZHNkpCRklUQ0cwUVoyRjFXaVJQ?=
 =?utf-8?B?OHFrVGE5VlZad2JpNzA2QWw3bVpEbThwRVp2NDY4aVg2QzliMHd5N0U5dWgr?=
 =?utf-8?B?Qld6K2MvanNGWU1Calp5NUtJdisySTR6NWdNSkwxSWQ4dE5YQm0wbHFJM00z?=
 =?utf-8?B?cFlUNU0rN1V3K1E0R2IrWFBuN3ZvakVHdStNa2ttaWpGQVRTOU9yRFdwN1Vl?=
 =?utf-8?B?Q2lSTTVManZDMmF3OHJqS2xyMENKVG81QUU0UWZUT0dERW1NT1VjeUlPT1lN?=
 =?utf-8?B?NHNaM1gwNlFPbkZnbFdYZzltTEFxN0ZSVUU5TmZrTTNhd0FOZHQvQWREdVR5?=
 =?utf-8?B?YjFVYTlZaklwdHczUzRnZzdyZG9Ma0hvWXppRVFNaFdoZnE4MjQxQVZQYVVH?=
 =?utf-8?B?dmkyQ3FrZmsxbkU5Y0FzWUEwL255Y0lnNUpkdVY5UVgwamdVYzFuOVJISWpQ?=
 =?utf-8?B?ZGRkM3hxdlhnRTNpN0dYTTZuSnJFUFBzQlU2a0ZzVE93ZFpzSDVuenlIQTRa?=
 =?utf-8?B?RnViMXhFdlpESXZjRkJDOXdQSmdyQThETjZEbTNpaGpnejdCangySElCNlQv?=
 =?utf-8?B?cFp4WlZPK2tIVW1IZUY3QitpSno2NWk4cEI5bysvT3NDeExNZGM2VkUrelJ4?=
 =?utf-8?B?bWFqVWNOaEZqbWRSWFROZ2NvRHdYM2Y2ei9kdFJSNmZMbXdNQmZjbFZidnFN?=
 =?utf-8?B?bkxNWkh5NUVtZUhJSjNEZFpKSUNhWEkxT2U0QWpBYWlzVzFkUWVMYlZTR1FR?=
 =?utf-8?B?UzVQbUhJTTJtSWFhTEsyNHN1SHRuUXgzdEVhWkNLbTBTV0FYRDJJd213L2xv?=
 =?utf-8?B?REFBdTJ4aUUrN0Q0VkltVlZDWUx3MVNhRXFrcHlXM2Uyd0NOcmZ5UWpEZnRY?=
 =?utf-8?B?Z29zWXlhV0VMT0JLQnNZRUI0T1Q0VmQzc3VLcXRjN2p4bkx0bUM1Z1ZHeFBP?=
 =?utf-8?B?ZmVhRkFQQkNZdVpvUlZETzh6NDAwRnNnakpUbXQvM3NtK3RtRmd1MHJrOHNP?=
 =?utf-8?B?QnVpbG5vMGNSTklPcWtSZUg0U0FaZzBDRE5HdjdkZHlQM0cvMmc0VHJkQkdR?=
 =?utf-8?B?dk95V2wxUmdwNkJBOEhoSFNqa1g3L1M3QjZhQ01WNkU1bTZQZ28zUVFQbnN5?=
 =?utf-8?B?WmZrY01PcDZKam4xcHdmTERvc0JSYXVxOXZYVFF1MndaMHFyaWs1QlphMk9a?=
 =?utf-8?B?WDltRTB6alpLK01JdlpiV1VZeXgwa2VFZ0s4bWh6WGd5b1E1bE9zN1BLUmVS?=
 =?utf-8?B?L0VxUFExSlY5bGFJZ2ptZHMySm5qV3JCRm5DUm1RPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S08yNG55cmZpdEdWakhtc3VjZW1TbTI4U3Z1Zi9uQlF1ZzVDeFRwRmo3dHJz?=
 =?utf-8?B?UUdDRzkreHhvcFF3T2Y0QjRoaTJOMkhhTUhwT0J0Z2tMRjl2Sm4yK3VQVU9D?=
 =?utf-8?B?NElicUZzeTFUeGx5aTFvY0lrNW1sQmpLTWE2bkEwSGVmS3lDMVVSNys4RWVn?=
 =?utf-8?B?TFA1aE55NjNZZHVmc3Nyd1M0cEJObDNZc0lZZE9xL1Rsc3FlZGRBNEdWNmYx?=
 =?utf-8?B?cUhhcVZzWDBENkthVW9SVzBaOWlIV2w4NkEzWFJqQnNVcjVxQzF4OGlsWWtp?=
 =?utf-8?B?MUp0Tm5KR2QxekE5QUU1OGVzR1Y4MkNlN3MrTGtDWEN3UW5nM3hlK1lnc09Q?=
 =?utf-8?B?ckQ3QTM4d3R2bG1rWGw0Z3ZpVzNmaFp0c3loUzdDM0l0aGw5NXZBUU0yTjhK?=
 =?utf-8?B?emIzN2k5a2x5WGcvWFllbzdIVWVsSFNkUXN5ZTNGT1BOWXl2NGVqelpwUTd2?=
 =?utf-8?B?amt1cDVKMmpkM01FQWs1a1NGTk1OcW1HbExhVVpDN0hZdWl6RWh0QXJQR3pl?=
 =?utf-8?B?eGFRQzlCNTdtMUpaTU5FQXNDdDI4Zk9ZazdHUUtTSWZBVGd1djVobEczQkdW?=
 =?utf-8?B?WStTdTlWZDJOZVBNOGUwaXZsYzl2bmZESTJzN1JsOUYyT0VHMWw4V3hkZ0dF?=
 =?utf-8?B?QUtPNjZJMEdhaThRbC81ZDl0SXdmcVcrNW9TbzJscFFtUzFqYmRFdXVvMnl5?=
 =?utf-8?B?Wit1cEV4blhNRTZsKzFZUTNRSi95eUltVU9aMGFXb05UeDBoUFZkVGl2UU5r?=
 =?utf-8?B?SmMrY2Q3K3MvRTVmTUc1SWEyRzNGNkJjUWZpanYxSXA4MTM4OEhXVWdMbjVk?=
 =?utf-8?B?MDJDNFpmdmwrQU1jWit1ZjZ5aVlTc243ME91RkljWXRTUGJTa1p2Qm9xVzd1?=
 =?utf-8?B?aUdPR0J6WTV2SmRkZEZTdDVUWUZYM1FyVGlackZFK3ZaTGpiNmwrV3dnc1pI?=
 =?utf-8?B?U1pWMUZWWStocElhd3NvRWZtbi9hK1hJaWJsb25yMm8zOHU0V0NUZCtwd2Rk?=
 =?utf-8?B?MHUxSWlGMnlJTGFkMGxzN1MvT3ZYTGdwQ01qdG9iSHZSWTdDWWNzNlVRdEdw?=
 =?utf-8?B?VFYrMzlNOEtEcWVCUDNuTHQ3bnM2SzZrM0tHYmF0NEJ2Qm5CdVRtTXlYQkRo?=
 =?utf-8?B?SG1yZERUTGNYbUhZOXRXcUtWTVNtVnY2YWR2Y2JrWHY0WnZLR0wwdmdTVDFP?=
 =?utf-8?B?RkhoYktpL1dUYVZWbEVjaThiU2tzdnV2MjZoYTBncDZpUzBTK09pQTVMYVRl?=
 =?utf-8?B?ZnIyYUkyV3lnU0p2UFd2cHdEakpoQW5LeVpKN2pOUXFiSDZ1WmJLamhvRFBn?=
 =?utf-8?B?TmQ2d3I3Zm8wbmFqd3UyQUhQbnlhcnJmZkUxSDNzbi9UOEpQK0Z0NERCVDIv?=
 =?utf-8?B?RkhQOER3QW90aU1IQmtaTUNkMWN6aHppdTQzVGx3TEZyeE5VZG5nMlkxNnU1?=
 =?utf-8?B?ZTVjbnppcUNUWnRaY3NMTTNtUFJsNEg1aWhqak0wWDBkdVB6OUdzVkc1N3di?=
 =?utf-8?B?RlR1SHJydllSTmtkMXFLYUNIK2xPVytJTElMZ01aSGVBcDFqdUpBOWo5eFg2?=
 =?utf-8?B?ajIrVTR1OHFvcWErM296dVhpb0xVaEtJZURHenlnTXpsMUFGMTMwaHlENHdr?=
 =?utf-8?B?MG91Q0lNVnBKVlBDUWc5UkROaGJLdzFvUmlLVm5zb3RkSWI0NzIxQjVXdkFF?=
 =?utf-8?B?azY5bXBOdHJlRlZEbmtxbUV3T0thVzNpL1U2M1RQbkUwVEJaaEoyNkNsWWRE?=
 =?utf-8?B?QUNpMkVKUmJvRExwbDNqdlluLzNvOCs2ZDU1NTRIMWd0SUFiSnJyNlkwbGpy?=
 =?utf-8?Q?8mXtjHY52YJONqsUHRIeqzsPscgInUvEdysew=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b431b64-0d9e-4c16-c3e4-08defe76f576
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 04:53:21.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10570

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBXZWRu
ZXNkYXksIEF1Z3VzdCAxOSwgMjAyNiA5OjQ4IFBNDQo+IA0KPiBPbiA4LzE5LzIwMjYgOToyOSBQ
TSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBs
aW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTgsIDIwMjYgMTI6MzEg
QU0NCj4gPj4NCj4gPj4gT24gOC8xOC8yMDI2IDEwOjQwIEFNLCBNaWNoYWVsIEtlbGxleSB3cm90
ZToNCj4gPj4+IEZyb206IE5hbWFuIEphaW4gPG5hbWphaW5AbGludXgubWljcm9zb2Z0LmNvbT4g
U2VudDogTW9uZGF5LCBBdWd1c3QgMTAsIDIwMjYgMjowNyBBTQ0KPiA+DQo+ID4gW3NuaXBdDQo+
ID4NCj4gPj4+DQo+ID4+PiBTYXNoaWtvIHBvaW50ZWQgb3V0IHRoYXQgaXJxX2NoaXBfcmV0cmln
Z2VyX2hpZXJhcmNoeSgpIGRvZXNuJ3QgY2hlY2sNCj4gPj4+IHRoZSBvdXRlcm1vc3QgZG9tYWlu
IC0tIGl0IGltbWVkaWF0ZWx5IGdvZXMgdGhlIHBhcmVudC4gSW4gdjEgb2YgdGhpcyBwYXRjaA0K
PiA+Pj4gc2VyaWVzLCB5b3UgY2F0ZWdvcml6ZWQgdGhpcyBhcyBhIGZhbHNlIHBvc2l0aXZlLiBC
dXQgSSBkb24ndCB1bmRlcnN0YW5kDQo+ID4+PiB5b3VyIGV4cGxhbmF0aW9uLiBFdmVuIGlmIHRo
ZXJlIGFyZW4ndCBjdXJyZW50bHkgYW55IG91dGVybW9zdCBkb21haW5zDQo+ID4+PiB3aXRoIGEg
Y3VzdG9tIHJldHJpZ2dlciBmdW5jdGlvbiwgdGhlcmUgY291bGQgYmUgYXQgc29tZSBwb2ludCBp
biB0aGUNCj4gPj4+IGZ1dHVyZS4gU28gaXQgc2VlbXMgd3JvbmcgdG8gc2tpcCBpdC4gQnV0IG1h
eWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZy4NCj4gPj4+IENvdWxkIHlvdSBlbGFib3JhdGUgb24g
eW91ciByZWFzb25pbmc/DQo+ID4+Pg0KPiA+Pj4gTWljaGFlbA0KPiA+Pj4NCj4gPj4NCj4gPj4g
aXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSgpIGRlbGliZXJhdGVseSBza2lwcyB0aGUgY2hp
cCBwYXNzZWQgdG8gaXQNCj4gPj4gYW5kIGJlZ2lucyB3aXRoIGl0cyBwYXJlbnQsIGkuZS4gYXBp
Y19yZXRyaWdnZXJfaXJxKCkuIFRoZSBuZXcgY29kZSB3YXMNCj4gPj4gZG9pbmcgdGhlIHNhbWUu
IEhvd2V2ZXIsIGlmIHNvbWVvbmUgYWRkcyBhIGN1c3RvbSAuaXJxX3JldHJpZ2dlciwgaG9waW5n
DQo+ID4+IHRoYXQgaXQgd291bGQgZ2V0IGV4ZWN1dGVkLCBpdCB3b3VsZCBub3QuDQo+ID4+DQo+
ID4+IFNhc2hpa28ncyBleGFtcGxlIHdhcyB2YWxpZCBpbiBwcmluY2lwbGUsIGJ1dCBpdCBpcyBu
b3QgcmVsZXZhbnQgdG8NCj4gPj4gdGhlc2UgZGV2aWNlIGludGVycnVwdHMgYmVjYXVzZSBkZXNj
LT5pcnFfZGF0YSBpcyB0aGUgb3V0ZXINCj4gPj4gTVNJL0lPQVBJQy9IeXBlci1WIGNoaXAuIFRo
ZSBMQVBJQyBkYXRhIGlzIGl0cyBwYXJlbnQsIG5vdCB0aGUgc3RhcnRpbmcNCj4gPj4gZGF0YS4g
SSBmb3VuZCBubyBkZXZpY2UgSVJRIGluIHRoaXMgcGF0aCB3aG9zZSBkZXNjcmlwdG9yIHN0YXJ0
cw0KPiA+PiBkaXJlY3RseSBhdCBsYXBpY19jb250cm9sbGVyLg0KPiA+Pg0KPiA+PiBJIGFtIGFs
bCBpbiBmb3IgYWRkaW5nIHRoaXMgYXMgYSBmYWxsYmFjayAtDQo+ID4+ICsgICAgaWYgKGNoaXAt
PmlycV9yZXRyaWdnZXIpDQo+ID4+ICsgICAgICAgIHJldCA9IGNoaXAtPmlycV9yZXRyaWdnZXIo
ZGF0YSk7DQo+ID4+ICsgICAgZWxzZQ0KPiA+PiArICAgICAgICByZXQgPSBpcnFfY2hpcF9yZXRy
aWdnZXJfaGllcmFyY2h5KGRhdGEpOw0KPiA+Pg0KPiA+PiBUaGlzIHNob3VsZCBzb2x2ZSB0aGlz
IHByb2JsZW0gd2hpbGUgc3RpbGwgY292ZXJpbmcgdGhlIGNoaXBzIHdoaWNoIGNhbg0KPiA+PiBm
b3JnZXQgdG8gYWRkIGEgcmV0cmlnZ2VyIGZ1bmN0aW9uLg0KPiA+Pg0KPiA+PiBQbGVhc2UgbGV0
IG1lIGtub3cgaWYgdGhpcyBsb29rcyBnb29kIHRvIHlvdS4NCj4gPg0KPiA+IEluIHByaW5jaXBs
ZSwgSSB0aGluayB3aGF0IHlvdSBoYXZlIGlzIGNvcnJlY3QuICBCdXQgdGhlcmUncyBhDQo+ID4g
cHJvYmxlbSBpbiB0aGF0IGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHkoKSBpc24ndCBkZWZp
bmVkDQo+ID4gdW5sZXNzIENPTkZJR19JUlFfRE9NQUlOX0hJRVJBUkNIWT15LiAgdHJ5X3JldHJp
Z2dlcigpDQo+ID4gaXMgd2hhdCB5b3Ugd2FudCwgYnV0IGl0J3Mgc3RhdGljLiBZb3UgY291bGQg
YWRkIHRoZSAjaWZkZWYncyBoZXJlDQo+ID4gbGlrZSBpbiB0cnlfcmV0cmlnZ2VyKCksIGJ1dCB0
aGUgc2FtZSBwcm9ibGVtIHdpbGwgb2NjdXIgaW4gUGF0Y2ggMw0KPiA+IHdpdGggbXNpX3NldF9h
ZmZpbml0eSgpLiBSZWFsbHkgbmVlZCBhIG5vbi1zdGF0aWMgdmVyc2lvbiBvZg0KPiA+IHRyeV9y
ZXRyaWdnZXIoKS4gT3IgbWF5YmUganVzdCBkb2luZyB0aGUgI2lmZGVmJ3MgaGVyZSBhbmQgaW4N
Cj4gPiBtc2lfc2V0X2FmZmluaXR5KCkgaXMgdGhlIHNpbXBsZXN0IGFwcHJvYWNoLiBJIGRvbid0
IGhhdmUgYQ0KPiA+IHN0cm9uZyBvcGluaW9uIGVpdGhlciB3YXkuICBTb3JyeSB0aGlzIGlzIGdl
dHRpbmcgc28gbWVzc3kgLi4uLg0KPiA+DQo+ID4gTWljaGFlbA0KPiANCj4gSGkgTWljaGFlbCwN
Cj4gQ29uZmlnIGRlcGVuZGVuY2llcyBtYWtlIHN1cmUgdGhhdCBDT05GSUdfSVJRX0RPTUFJTl9I
SUVSQVJDSFkgaXMNCj4gZGVmaW5lZCB3aGVyZXZlciBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFy
Y2h5KCkgaXMgZ2V0dGluZyBjYWxsZWQuDQo+IA0KPiB4ODYgU01QIG9yIHg4Ni02NCBndWFyYW50
ZWVzIFg4Nl9MT0NBTF9BUElDIOKGkiBJUlFfRE9NQUlOX0hJRVJBUkNIWSwNCj4gUENJX01TSSBn
dWFyYW50ZWVzIGl0IHZpYSBHRU5FUklDX01TSV9JUlEuIFNvIHRoZSAjaWZkZWYgbWF5IG5vdCBi
ZQ0KPiByZXF1aXJlZC4NCg0KSW5kZWVkLCBJIHdhcyBqdXN0IGxvb2tpbmcgYXQgdGhpcyBteXNl
bGYgYmVmb3JlIEkgc2F3IHlvdXIgcmVwbHkuDQpJIHRoaW5rIHlvdSBhcmUgcmlnaHQuDQoNCk1p
Y2hhZWwNCg0KPiANCj4gSGkgVGhvbWFzLA0KPiBDYW4geW91IHBsZWFzZSBjb21tZW50IGlmIHlv
dSBhcmUgT0sgd2l0aCBtZSBhZGRpbmcgdGhpcyBmYWxsYmFjaw0KPiBtZWNoYW5pc20gaW4gbmV4
dCB2ZXJzaW9uLg0KPiANCj4gUmVnYXJkcywNCj4gTmFtYW4NCg0K
