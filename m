Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012074.outbound.protection.outlook.com [52.103.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638563B8D40;
	Tue,  8 Sep 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903103; cv=fail; b=gOf2SkOA9aZgk8QpY25N6uOOykDawU7uODOb/c/X1Wol/xGF3CZgYYF7gPdauBD01vyZdxCYPpEj20jF/jJ1a/6i9oO4iFZVlkp3BWTTWgiwzLOod0hi3/1eOH5mdPWCM81HuAGdOUUrII/2PS/xYUTp2CmBkakBcIj/4b/DSSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903103; c=relaxed/simple;
	bh=1cQZQYr/hxp9T1r5WaYo/oLVo8HF00NXQackxGcBt+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Im19ocIyAxu0c/JcxeJcwQyfNyByttQVnSsReWU+F1kUwHN/2ZLz9hJbrNHuyhDzFbKMZ/u71lulHQM9rJXo6mJxVsSv1DmrvteIpt+Hr1DOIYsFoCLgc/LlRJzirLLM+i+R4v3yYPY7ekVvSn59fgYuMHXgo4BMzUPK7LaWmJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OYhKdUPi; arc=fail smtp.client-ip=52.103.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OYhKdUPi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVFwvyGoOJnav2mYakI9aFjPh42IgL8raP5YTGtibJ4W/h7rpXMCcBrgiY7CLV3I8ud3Hv/W2sUKaO1m8Cq0f0Bw0Zcd3d/uqrGqa8KZo3pD3Ntnx5ekWdeJLTVV3je/SFZtN0XsGj7S76lCCmp9K6ulfayL1rNhZUm1VRvXyCn5cJqfu5AM3vK37FFParOnGKrMS0FLyxoAmaQJ7Dgs1sgQftShkUw/A3Rttxi2UGadllJIHHtGX/v/k1Db9HAqeF5clMWcbIa82Ca4ZQHSkVWn34sBJsFF49EL4jaRu6XxWlEyDMMCiVw96Cuzot/gIG+TC7cmyIZYhdLNF5ZOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cQZQYr/hxp9T1r5WaYo/oLVo8HF00NXQackxGcBt+o=;
 b=h5UMKQlCYqqBhZMZUL8CiwyJ6i60aU+LLQvO8/d6iezD0fUmvcOI+gLNJTxYsiwM2dFDU0UB/lc/bNohQIVk4oKrXSTkYYt0ie6R5iH1u+qjW9sLY+Q3UZCOgaDic89jMRQOP1fVLar3qKuKmSyIQdLvitQyzJHkTSIDyvQCVO44hZ7bU6K2PUec0PKDw5ClRkQ7pzvOPv0o865iG0zB8KweZb3tfuR63wXTmK16kpqJMEkn/nMnuya3cmpCbsFMdJAf2iSyeBuyRoAnE/gWVjzB5scsyKXHGz+FezbcXkv3JF5BnvEzU1ulWLCTTacLniirne+p5pC+TNl8FqbVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cQZQYr/hxp9T1r5WaYo/oLVo8HF00NXQackxGcBt+o=;
 b=OYhKdUPiiD8H1q2wom1DXUHPBxWW8NCrzph8aQri+p44p6x3HXiGWIUJoeym5YWndHNWw4MPadju1PcG4qv+XeeEUfGdrm35JJ/skKkSLR9jSELxwoxbgYOVDXYpF+GYfu7miXwelFxmnV51g8M1mmxVH6hjKTN22CoeVPmLmEn/7Go9GRhOnuSohFbMZuWAvGVoqRNT975Wa49dOlgVt6FgiGIP+lh4rKYz9Dk3gry7Qh2wzEDWaX40qjCgtEKUhv7yK9X9tVnqcsA9lEmkA5MoZ2wLe2kFATr7qi4dnqQgBgScP0dvetvqqJVNteSFxTy+VI1lbszIX1oTY7YEiQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB9697.namprd02.prod.outlook.com (2603:10b6:806:38d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 21:31:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 21:31:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH V1 1/3] mshv: Rename memory deposit memory functions to
 _old
Thread-Topic: [PATCH V1 1/3] mshv: Rename memory deposit memory functions to
 _old
Thread-Index: AQHdPze4t0iLeIQ6+kakBQ4jjn7iQLbE+cGwgAAtMgCAAA13wA==
Date: Tue, 8 Sep 2026 21:31:39 +0000
Message-ID:
 <SN6PR02MB4157C76EB132B729A8F9C923D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
 <20260908021340.2548924-2-mrathor@linux.microsoft.com>
 <SN6PR02MB4157D9294688C8E5F21BDD19D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
 <921a1646-4257-c627-1019-8ac41ea89ed4@linux.microsoft.com>
In-Reply-To: <921a1646-4257-c627-1019-8ac41ea89ed4@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB9697:EE_
x-ms-office365-filtering-correlation-id: 68109a3f-ea89-4fa5-306c-08df0df09186
x-ms-exchange-slblob-mailprops:
 igNrEvV8uhEjvtWg4HuO4afqtzhSzTL4btbxPH8eQksTBIPH3Tz+Z8UCalL9uj12xDSExeDS3S82SEUGs491/GEmVzPUF0Vnw5UyfShclakRMVHgm0KSMWKTRNVU7BosH1G5anuDE/qIlqJRuYwslZnOEqdYjLKV/AMHxSNyBX/i7QlGJtYphefFCU7bpdWNAseeyZST9zK+A4irfOft8wX1vQ6NfGDzcFQKnd4OMk5QYSVAyPW1V73OKED7sMC/MKcUubCVfX4o3s9fqJQ5LlJGx7d0tJKE1aHOsujkx3MwkTjuGMyFYLxpXltOiigA1lEYbnbTLPo47sg059scAlPjR+vjGyQZk3tS3FqLZBXvBKocxg78aJ4OkiwgZYDUgnZMCxRYlwMQikSoytoLAGgqxIhQ4jtXPIql9wJ5Q4gzuRVq1A96jFB7m9hxtbrwkkJrperbKMM0kVA29l9PYJpdTyo2HI/0j0RSPFx1xUu5UGH9wvCsU/p3jBKYrE0lit4c3kePc//F35dihvSJ/ejSShUPCF+CkShZ4KcXiY3FXyXW1cJJn8ehAwGcY8JfEzGDD0ulcjrbsY2GM4RkKPJXtrRUfBF/VeGbbvHi5yKaviK7hzU2o4516JgtE3lPhfrpipNJoMssSwzlpTCXD6aXPMjOW5HfDGm+rmxwJd03yxClZQugS9igbHqTzWk+DtpwDpCVsiw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|55001999006|24021099003|15080799012|25010399006|13091999003|11091999009|31061999003|8060799015|37011999003|12121999013|8062599012|19110799012|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?elpwSXgwcXU5b2tHZ2R5aGpOQTVxNHphcnJaaGhMRHZndUdXaW54RzJyY2JT?=
 =?utf-8?B?aG1iM3BXUjNWRE5ZZElNUklrc0VIMnE2aUlkTzMvdFA0aXN2dlhPUnN6Z1M0?=
 =?utf-8?B?dkVXZDJGbThZVmZjRTZXcHluRGlpRERubkZCTzc2c2NqeSswb3NtOXVjd0tL?=
 =?utf-8?B?ZytiMjFWV05aWXlvdlFMQ0xaM1d1WEhzZmVCTWh6T3M4bE1CU25pZWFXSE05?=
 =?utf-8?B?cms1eVFjSGhqRGVpMEMrN2Voa1U5SzlDSVRqbzVRazlmWG9GckZ3V0M1NVVx?=
 =?utf-8?B?UjNVZVkvNktwUTU3K0hLUTZzUStWY0gwclN4VjdoeW5mRWNPUmxiK2xWVGlj?=
 =?utf-8?B?VUZWTFErekdkUXlRUzlYbk92Wk9OazhMMjY1QUJLV05nM2NZNWFDYXBXU2dO?=
 =?utf-8?B?V2NuWFVKRms0SHBjem1YME1GbFUxUi9PK3FDMzRPZnFoUUhadWlmSkpIMENT?=
 =?utf-8?B?WDBpQU5xRUVKUmJkSkhPTnFFYWxaMlRhVFUrdVRFbUk2L0FoVFFDRW92c0Ir?=
 =?utf-8?B?QUpMS1ltZDFIeElQYU1KU2R0dGtGd1ZEWFRsRGhnemNvMXRGM3ZEbXNuZHNI?=
 =?utf-8?B?MW5wZlh4Y2tLZU9iaXhXM09hek1KRFg2Zk0zUGVVR0VhQ2czSDlwY214c2Ex?=
 =?utf-8?B?NElDekR1SjF3d0pBWElncjVPZ2hnb3Q4TFRWaDBtaHdtSy9nOFVuUE1hZHNZ?=
 =?utf-8?B?QllvQy9pdlBiOTNLdUoxUmtqYVUrRDRCQmJMVHg5aXc5aWdUVDVYUko0aEI3?=
 =?utf-8?B?RlRQa0VFSmpWQmRuYnlNVWkrY2FQK3pKS1FFK0hYSVJlbHBkSTQrZy9xQnpp?=
 =?utf-8?B?K0ZucVNuWkpIWmRFU2NKWmtSWWlhb2JOS1lGSjJnZ0VmN3p1UzAvaitPd2k4?=
 =?utf-8?B?NDRXYXZKMVIxMG1TMjlkUWI4YlZkaXBYWXlwK3ExWUVPNTJnTHpocU9nOTNS?=
 =?utf-8?B?NGRha3JVRGsyRmlRMFhYSCsycERha1YzbE5lWjdvVkFhWHNnaEhuWTU0RFh2?=
 =?utf-8?B?YXFKbHlTMUxHcWpZbTVuT2UzRTZXTHpJWDQ4bk5ET2dQUHQ4VXBrVHM0SC9k?=
 =?utf-8?B?YytkMkRQOXorditMdzJ5bW00SXliMVVzMC9Zejc1Z1NVNDFMMCtqSEhTeFBG?=
 =?utf-8?B?SWorYjB2c2VxM1QveFJ4QjR4K2szQUU3bm1LSEJNRTlxcGNGWDJOTm5rcURz?=
 =?utf-8?B?ZzZMTmpuZlJYZTF0bXVDdmZpVktadHpYVVE0N3hicWpQSmc5TXJ1M1N2SE1R?=
 =?utf-8?B?SDBhWnVjb2NMV0tTM1JCeEdYenVRb21NWitlWkdJbmxNWXJkaWd1aStCclZp?=
 =?utf-8?B?MW51dzdKVXpHNmpGbHVoRW0rZmtlZUFKbEx5amtsbEhxYm5FZVlWUWorb2t4?=
 =?utf-8?B?cWhWb1JnMlRFMzNtSFcybGI5VjduTGRROEgvc3liaXJ2SGJuYVpkZGZLTGRS?=
 =?utf-8?B?UG0wa05OT1JqR2ZTSmFGSmhqa2ZMaTdUN2Z2Q2dxK2pzaFN4eDUrZXpMaFlu?=
 =?utf-8?Q?Jk1uPV9CieqE5AnQGoaKBu9LEEC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHdVSER0dlJ2ejdqTjZxbitOMWZtYlBiaXdvTEpRN1UxZmU2VTVpWmcvNTdM?=
 =?utf-8?B?djB6Y0RFV2w5Q0pPdmh5aFBpZFp0dFlLS2dqcmlHLytlNDBVMVNYdmdRUTQ4?=
 =?utf-8?B?T3RvclpDcmxGeWNBL1lUcW1MVkNDWC9DRWFsazlBTkY2Y0d0dzBVWlExdU9u?=
 =?utf-8?B?MVVvRWcxR2g5aTVWK0NwNlpINlhLK0VQRE1nTTRMQ2lDdm5zTU42Wk9GbU5v?=
 =?utf-8?B?S0xtK1RaZVV2Y2RxemJTenhESUFKU0pEc3dBeUN2bGU2NThQWk0yT1drQ2ZG?=
 =?utf-8?B?U2Z1K1hlWmo3b1dmaWpHSHNDWktHaXFFSFA1ek90MVlidTQxY0gxZThBVG9V?=
 =?utf-8?B?bERnekRERnlQOVBWSjF2RzIrTTRnRTBJNEpxZUxrWUJUeEdGbWo0RldYOHZF?=
 =?utf-8?B?MmE2ZDNMN2hwR3lIZXE4czdSRnVNNDJmVEZnVXVjdFhDMi9xc1AxMkd0Ylgv?=
 =?utf-8?B?dzJHYkYvMVNsZUxmVXR5RlN1emc1K1dOeGpLajdQdkljejROamQ5Njhhc0lt?=
 =?utf-8?B?K1NndzlBMk96NXRIMS9EdW5XcHYxWWVrc0s4UCtPYWlwaFZnM3pwVmkrdGVQ?=
 =?utf-8?B?TmhnZzVUY2RLYWh4aDEvSk15TVV4NmVHWGk2T0lwMGNBZ0pLZTRNRWlVNVN0?=
 =?utf-8?B?ZmswKzhGeGtLYlNzTTNXNVFUbGhDaW14OHJsejV4bVp4NmtBaVFWdlh6NzlY?=
 =?utf-8?B?emdJTTY2YzlPamdob0Z3Z1REQWhiOTdSWUVWdXFBOXBDWFVuT3ZhK1lHZEVw?=
 =?utf-8?B?SE9Ud3lNdGpOWG1LNVE4dFd6OWlzTy92UG9OMXM4OGF5SjRhV1Z6dmNHOUhx?=
 =?utf-8?B?WWRUdm1TdzlZQVNUVkxlY2JJVXpoRU81SUlPYm81T2JHVG5vNXlWeWVGbU9n?=
 =?utf-8?B?OGxZdHRScjJ2TW5HNWEwN3ZvdC9WMzVqWld3QjRyelB2Snh3em5qWFdmUlg5?=
 =?utf-8?B?Uml1aFhLUUF4RXZpaHBacHdUVGFJTDVmeFZBV01MVEJ1YjIxY01Ic3NSTzJy?=
 =?utf-8?B?WXVZdThHclZTcnc4c2RqenUxOVBsK2hBbkUrK0VoeXcrRHV2R3NZWUwrN2Jn?=
 =?utf-8?B?c3d5THVBOUN1ZE5DM283akEzcytxSnJ0SENqNlBVMml4WDNPNWoyTCtZbUhZ?=
 =?utf-8?B?VnVhQzcvWnE2bXdjenJuZU5qQXJnVDY4U29wbW9NWExqSGptNFAzTHZjQW52?=
 =?utf-8?B?VFRCU085QmZ3cTYvVmkwWU02WHprOE1PdUtUdGtiT0x4VFlwbUYvcUhrejUy?=
 =?utf-8?B?WlZSVTdLRHl0dXl1TisyRSsxOGhYSXlDaEdlcFYxekhwQjF1VmxpVEVjSG8y?=
 =?utf-8?B?eXRmZE91ZTJmQ3dUVkZENk1NRnNpLytzWmtuMmZGL3E0K2tKVSttMk83bmMv?=
 =?utf-8?B?M0RuRklsNk5jeExaMWZseE1QOGdIOU1wb0NTT3FkTUFKRkl4b1dxVnRyTy8r?=
 =?utf-8?B?N1FuSDZwbmkwOWp0ZjBhZHlpQnVFWjd6cU5sd1ZzYVAzNW13aThRNzFic2Z2?=
 =?utf-8?B?d0hZWnZpcUk3U28vM0RsdzM4bHh1V2pVcGRSY0MwV1RpZE5xYXd1UEdETmpL?=
 =?utf-8?B?bVVyeG8xSldOU24zbm5kZ21pUG9YaTZkRGw5ek5ESElSMjRKOTRPT0dNajhP?=
 =?utf-8?B?cVNob1JjOVVqVjFNT1JhZnRjWDM0eGxqcTh2alR3WE1qdEtLNE1LWEEyT2V3?=
 =?utf-8?B?RkJ5RjdkUDdBRjV1TTIrQk84VkM3LzJ3MG9nVHpBeXhJVm5QRzZWanB2Nkxq?=
 =?utf-8?B?MmhucFJNWHZBYTJaRUZ3dlhmRFNad21scms1ZW4xSFA0MmRIa3V2NTVJcFkw?=
 =?utf-8?Q?Z7NxR+1rMhaybOOqtb/1rT6GcP0+O5q2xotYM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68109a3f-ea89-4fa5-306c-08df0df09186
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 21:31:39.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9697

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2Rh
eSwgU2VwdGVtYmVyIDgsIDIwMjYgMTo0MyBQTQ0KPiANCj4gT24gOS84LzI2IDExOjAxLCBNaWNo
YWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBNdWtlc2ggUiA8bXJhdGhvckBsaW51eC5taWNy
b3NvZnQuY29tPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciA3LCAyMDI2IDc6MTQgUE0NCg0KW3Nu
aXBdDQoNCj4gPj4gLWludCBodl9kZXBvc2l0X21lbW9yeV9ub2RlKGludCBub2RlLCB1NjQgcGFy
dGl0aW9uX2lkLA0KPiA+PiAtCQkJICAgdTY0IGh2X3N0YXR1cykNCj4gPj4gK3N0YXRpYyBpbnQg
X19tYXliZV91bnVzZWQgaHZfZGVwb3NpdF9tZW1vcnlfbm9kZV9vbGQoaW50IG5vZGUsIHU2NCBw
YXJ0aXRpb25faWQsIHU2NCBodl9zdGF0dXMpDQo+ID4NCj4gPiBJJ20gbm90IGNsZWFyIG9uIHdo
eSB0aGVyZSBpcyAiX19tYXliZV91bnVzZWQiIGhlcmUuIElmIENPTkZJR19NU0hWX1JPT1QNCj4g
PiBpc24ndCBkZWZpbmVkLCB0aGlzIHdob2xlIGZpbGUgaXNuJ3QgYnVpbHQuDQo+IA0KPiBUaGUg
bWFpbiAybmQgcGF0Y2ggYWRkcyBuZXdlciB2ZXJzaW9uIG9mIHRoZSBmdW5jdGlvbiwgc28gIHRo
aXMgX29sZCBpcw0KPiBub3QgY2FsbGVkIGFueW1vcmUsIGFuZCB3aWxsIGdlbmVyYXRlIGNvbXBp
bGVyIHdhcm5pbmcuDQo+IA0KPiBUaGFua3MsDQo+IC1NdWtlc2gNCj4gDQoNCk9LLCByaWdodC4g
VGhhdCBtYWtlcyBzZW5zZS4NCg0KVGh4LA0KTWljaGFlbA0K
