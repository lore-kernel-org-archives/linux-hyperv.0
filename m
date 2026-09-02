Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013064.outbound.protection.outlook.com [52.103.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED335C1AD;
	Wed,  2 Sep 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368251; cv=fail; b=F4CoX76yBJiwX+dCT66esV9yjE34VPt89XhzUZ1UrS+kcF05GGdCiV8aTlHiLmnQCvPFYt4daZ4VrfbRG+l51m+SDNmK5M4NzozTTEna9QZHomhSL5B7w5zAiG0PF6pxMWhhShKuhu9ZdaSM0zoou+a56hfPwYlAhdHUYE862Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368251; c=relaxed/simple;
	bh=qdTbLlYqxDIVfE0rhR0pMK9oZPMBXwOWGxayGOOiBKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wscqoxl7uqjhfE6cXB8Oh9i0h2RsPi8QA8NvpsoJLG2ecx7MKpp49H7K6mK03aAAcv5OBt7oxNTPIkD+ajLp/OvkGTAhzWy6/B7/VmDHtsydM0YYdWqZeMqbWys1nCpfw8xu/N9lmsPs7/EM7GplbW1JdN+1aXjqG3+AyRNFi9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=N5p3ARXn; arc=fail smtp.client-ip=52.103.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N5p3ARXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1TZYonDfA2WnAlyPpreQUBYkiLmpBjAFspfPh5ndyxeS1BKKiz/VqRqjIQPhle3c9dDiRWygLDXsCM2mmtkRBX99/Uv5vQGYGl02CgnwSIWtgqITztaHKcu4DvlHjrgObmcJCmKYFJadCr78YdLWLk0D/0xCdLSsE0+HXtUL7GL6YmI6qiJGQTrjt7Y2GD3FWV4ArVKQHz+H3Il9JcajvvimzpryARbCUSAUf15paDAs5LwIgPsRmZWRw3rMrt4z2YSKyzaJcs+5ltrm1fD3/yll3a+xN4C00pzklZcP7D/kuXCOcWseHQbsHB0CXyF/syacUn+aZYfOB9W75Bquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdTbLlYqxDIVfE0rhR0pMK9oZPMBXwOWGxayGOOiBKI=;
 b=LxVYQOs4ovVk5JDrbxUOEKyLmviZcIMmkmdmstbGlweD2B2r32V57sqerJ3ju2syGlf9ebF/zPX0d3nuGKc0FZGB3SWWDAf2oG/inLj5+IbZTDuSCYw4iKeygXhDbf9f8b91hQAUfTpNTNzSWrSmCd0hJrtIcizj/wWIdmOvJN5xueeBf/A7upP+Xjepp5vNn0rGm6qR4tTQNGWxZs9qxFHxATZCcHEg0rH/g3lzrQ1ulBiQERT5HqzwUfyE9Mw6sv+Ca/+aJXG6S6+apRQoKHo19srCQV/PncvaEnmZd8TLcjS24fLNTkxHtW8u+M7p9bh9Jm/fvZyguUTXjH9eDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdTbLlYqxDIVfE0rhR0pMK9oZPMBXwOWGxayGOOiBKI=;
 b=N5p3ARXn3Rco31Nf3tdXpjjg+rosnmsvojeytENqslXGhh/jX8XnidvALmyqbT16FwjoFrt9LrB9HvQHI/VlB/LBF/9BkrazQxF+MFOqhFVv/2FkDj5P02hC0ZW5LHD09OwbtybhWPJ+pWcLaXux/3cmCBSjbtPOGZOtsBFNE/vUlMrB1OY2auRRirGu48GsSLjc8dSovB385aA0Fau90lI1GCIVySlLJUvqFmF0+Lts9bfi5Gn6gu5f8L5OIhb3cEKgDiOsIEOtV0LhkHQ/+kRNNuyA8HyjLrUciDRz00w4/P/JhEwuf11AEIIfZ9qkdVC5Nswtk48QwIIOKvbMEg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9192.namprd02.prod.outlook.com (2603:10b6:8:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:57:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:57:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@kernel.org>, Ming Lei <tom.leiming@gmail.com>, Ming Lei
	<ming.lei@redhat.com>
CC: Wangyang Guo <wangyang.guo@intel.com>, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Long Li <longli@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
Thread-Topic: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
Thread-Index: AQHdKJCMH5PeXdnWRUiBUqx3W0OgELa4+KewgAHm1QCAAMee0A==
Date: Wed, 2 Sep 2026 16:57:22 +0000
Message-ID:
 <SN6PR02MB4157F6AD93437B057878E048D4B72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157B73B333F08702875110ED4A82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <19005077-4dde-4193-aafa-5b248a2131a6@linux.microsoft.com>
In-Reply-To: <19005077-4dde-4193-aafa-5b248a2131a6@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9192:EE_
x-ms-office365-filtering-correlation-id: e734e2ef-dc99-45ce-1be6-08df091341d8
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZn9IFDOZRHBr3PkJ6iE+FIkDUn8RT1l1bRCuZS5pxQb+0kSwRZYHb+IDtUvt6Q9RFnM3YjtRONxGSWwBVmgiJgprtypR/dcpcZ3/7Gkrgx0bdozv4SwhpDRi2QR69AwgUfD2lNNgAD9FwvxAZGcI3lsYFfsXbdl4nU2xstlIdmapswf7DI+WOofQchTHQaCNo2Vp6qPA6ts6FASSGVcxjG/3gm35Qgg/SWA8iBCT+mP4/LovMG/NnNIOrg3yECIYOx8Jg/6kJ9cgCacoz9/cUbYkWBaTYtWNkl3OukfhRa+ZOkwkwHrOHnANxJ+3ZM//PB0/wIW/zngCpIwDvqKchbhgHY1WahpmfMsa5oklxvKncXueCHqK0WbL9MF1G++HHTLueBzWBQS0H/2z98IlxTlFUk35t+1lkJHRFUKjdI16su2lVTtYHYBq66dP5gc9GIso7oFZXgdEXEeARruJMn7RznQL7fl7hnsXAPasNwBpyIloZ4vPSi+jHvaUV7k9fKS6zqTgCdm3bHuEvsrLfRq6/IGx6YTCde2h8GiIHvI4yg2OAhB+N6OCC2mgPJo6dt6UFB7o2T/ADQB2QRk4MZAqisMdGcv5PdFmGZuwfTU6QWGzvAi5ulzhbfSf89tDEwgkZfSz9AOAHi1ueqRrMuA1vO2yKZ9EB0jShcIeVIHAYKxqG7jAgHb2i8jl/9rII+lwRogstXatqFRvfWAzzmFbVmmiq4KZTcwHrvu9Z0pDdL5UvIoViS5iInOW02tTUPWg7j+18DaZZDk5QUY+pku6Bgm2/wbooT/JwjXgCxeTwdE+FE2loaa
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|12121999013|19110799012|8060799015|8062599012|13091999003|15080799012|37011999003|24021099003|55001999006|51005399006|31061999003|4302099013|440099028|3412199025|102099032|1602099012|40105399003|2607281247196008|10035399007|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVZ0MXgyR2R0MStMYXJQbmRtOTErdkdGbkpGekdBL3pkWThKTERZZWxadFNw?=
 =?utf-8?B?VitBaEhlck1TREJXczRSbUhsTmVEZ3V1SlRZNS9BMHJ1SmEyZklIdDFOYW1O?=
 =?utf-8?B?NThiYnZUcFJlVExzWVN1UHNxYTFrSkthdnlQVFdqWmxiSm1XRGVHbUxUQ1dV?=
 =?utf-8?B?c0RRcDRJVXpEU25kWlFYQXN5cEhyVnZKME0vR05CQ1NicTJEZ3UwVG0yTHRI?=
 =?utf-8?B?S1BKMFl4dFAwMndHa3gvbmVJOXV2dVpiMURoTDFZWnU2cTBLNnhFSUpxTy9z?=
 =?utf-8?B?a0liZVZpbmtic0pOWkE4SGd1bEtsekd5aWduT0JSeExvdzBsMkhlMUQvZTBp?=
 =?utf-8?B?bCtQR2Jjd0JIbURyY2NZVStXcEdGNTZYK2EwcitqY1VIdjJqOWYwLy84UTZU?=
 =?utf-8?B?aGNWakRHMjhhMHp1d1NZN09mQ0Yzc3h5bVRHbW5ZYnRYQ3Z5clpWczRSb2gv?=
 =?utf-8?B?L3RQNkJvOHB5c3hDc3VtUExSaHZ2dkcwM2hlS0JWeUUxRDJ3Mi9FQ2V1eFp0?=
 =?utf-8?B?RVJBWTdiQWpPVnlnTG84TEF0Y2FMT08yVjZOV3JoNTBPY2hCcmh5Qk1rQnIw?=
 =?utf-8?B?dVBIOGlRbTFDUytrR1cxckNnbFBJMjl4emNVS3VOVXEzNXFaWndxTXJWbXhN?=
 =?utf-8?B?ejFwUS9GN20vb2lGN0ZFWXBHbXJBNlhDa083c3I5RkVURTBJMDQ4VmV3MlJQ?=
 =?utf-8?B?UGhIbG5ZZnUyREJNU1pFWGlUOGZyc1kvbWpsNVR6UjF4ZVFHWnBaM2pPbkxs?=
 =?utf-8?B?dWtFbUVBNGw5VUZDSit5MDc1b0xlc3ozajNmMHRqaDZCaFN6L3VVWWczWU02?=
 =?utf-8?B?TmZnR21RWFhnaEpJYjJUdXZBcWlZbzd3cHQ2VUVVcUJSYnJUM3VKRHZGc0g2?=
 =?utf-8?B?bHFBOURmdXJvVGdzcnArcng5Slh2Sk1seWNrRHl2TlJxMXZGQWZUNjZBd2NG?=
 =?utf-8?B?QzFPQXpuZ0ttTTZsRXhBZXZHKzN0anY3ZEdqbTFBbFdMS3NjbW1UalV1NmZN?=
 =?utf-8?B?R3ZmVWh5bHdyWStSMTRLeUNCUGYyUEVTWW1tblY0QWdWYUp6M0J6YWUzdHQv?=
 =?utf-8?B?T1Rhblg5dVY1MHNlZTgrLzczRWZXQ3E3VVFpR0xYR081S0tjNGE0L0NPZ2xO?=
 =?utf-8?B?S2xUT3FQbzFtZEdsUmt6NEtGT1RsRkNLNjlwandQOHVIcWFUVktQbk9HbDFk?=
 =?utf-8?B?QVZRUkovUXpLb2lGKzZQUWRZaWY2d0NmVXJjRmVQTkFyRWlyVGNvdnlUbmgz?=
 =?utf-8?B?c3lIV0pKTWxNak00MVE4VVI4eGFvbVZabGNKNm9jZEJzRG1ZMjVLdnlOUldi?=
 =?utf-8?B?akVLd1FKeDZweDBYZHFzRCt6bVlXZ2VLV3lXUlg1SE81cXFlUklzVUlnZmtV?=
 =?utf-8?B?VkdtcSt1RUNNbC9DbFhQWUM1YnBNODQxeG9nMld0aTRjcGtUSHVVN3ZESFpD?=
 =?utf-8?B?aXdEakpsaGxCUk1DRGxvNVhnSGtVQ0NGVUpEbUhFc3FCNHRlYnZqWk95Y3kz?=
 =?utf-8?B?ZEZNWW16L096K3dtR3JHOE9sQkRXZ1d6V1Z6d2FHNUhrRWpzdjZPVWViNjk5?=
 =?utf-8?Q?Y0S2MHKkJGK1UTI59UbbtLB37RBCpYoD+KgwXghv0ASZ//?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEIzNGd2WFpSVW5LSzNCbkJ5Y2lhRFRUTytEOCttdzlvNnRxcndQT2FLRTZW?=
 =?utf-8?B?RDRzWitNNXUxMVFGK2xHL05zYWsxdm9rejF3SVk1a2QvWFFyV2gyUmx6ejlG?=
 =?utf-8?B?ZWZUZXlUMVZ6RkFpbkNYblc5WFBFVE90YUN4bENSTUJuV2lERDVkUjczaUhB?=
 =?utf-8?B?TmsxaVM3b0JSK2RnQzdlWk9odWVWL3loRjNLd0xyNjFqV25IaDkxakhWYmlB?=
 =?utf-8?B?cm0zMFJNRWI0RTRrQTdiVmxEaUVzQ3h4UWVBb1NReE1xNmZlcWxMNGhqcmpw?=
 =?utf-8?B?YW9meDRIQWxMdW5oRE9KbDhxeGMrOHErblFHY01jZW9hV3pKeEVodzhrSmZO?=
 =?utf-8?B?UlpheTJnZGNsQ3dqRU5YOTdrQUF5UlFoZFMwemw5bEVUQXFhU2dRYWlJRGhL?=
 =?utf-8?B?Nll3WTZmRFRwcTdQKzI5M2I1OWZBNTJFWWNXdVR4ZzlQaHFiRUVVZUc5ZC9k?=
 =?utf-8?B?Ti9qbjBSMU9XVUpkYmhuOVBiMys5Ly9lSS9ob09XRjQ0TllZOTQ5VEFSTzlv?=
 =?utf-8?B?a2R6NThsQnQ2ajlhWitsd0U0R3RUU1dTNjYyNHFtYWRwNzlGdzNHblhERmo5?=
 =?utf-8?B?QlhPdDVtNmV5a3BrWGZkeWNqQ1o5N1AwdzU4aVpvNm00YlBZTWNFTm82a0ZW?=
 =?utf-8?B?NWt0VDFDVWVheVErL0hpcDc2YzZBcWlZSUQ4NVlYdmtWMVNZS0xJa1ZlZzFk?=
 =?utf-8?B?Q25MQWtEMWFTRGZ3VEtLeFZVUUpHNHF5SmNOcDMzVW1MQlduWU12ZVJzM010?=
 =?utf-8?B?b0RRWG90My9kblNJN1FFT3dlTjROczhOL1EvWFBNa2dNUDNJcWh3YkoraFN1?=
 =?utf-8?B?S1dWRTVOQlpFUlJkdk42anBMbmdZN1kwSEdxdFpPVkdWbGhtajZ4T0VWaDI3?=
 =?utf-8?B?L0Fjb1MxM25tMWhOOWhPdjh0SmxDTENlZkF4bjh0TWtUSjQzMzdLK3VhYlFy?=
 =?utf-8?B?eTJmVmZkaFUvWFMyUlNwNHNrcWtmQU93dVlZTDZ6WS9oSXRsSkRYU2taZGcz?=
 =?utf-8?B?QlBPc1JtcUdXanFzdy9rMXdhM3Y0SE1zM1BkRnZpQ21MOXpvb3RaK1hxVVF0?=
 =?utf-8?B?SXlaVGJsRDVoS0c2d041M25IaTArKzgvY0dJbFhrSHVDOTBBY1lxNUNkR2VK?=
 =?utf-8?B?cXRFakducHY4cFpDNDhYVGJHd1pwUVhSTzZycHpDb3llT1A1RmdQZTRMZDFL?=
 =?utf-8?B?VENZakNFd0hpejZtSlQ5SThVaTdmR09nRDFPc2RnT0xLaTNGZ3p4K0lZY3Nl?=
 =?utf-8?B?cnVpTExXUFFhRkpJK3VPdFE5eDM2NFN6dUtueEdoM0ZmRUFTWm5ZNFJPWkxE?=
 =?utf-8?B?NWxPQ3QrZXFscXVtaWswOTV5RmlTWG4ydlJVSTU5bThGYjV5TzJLVXhsRjZI?=
 =?utf-8?B?bGRmYkt3R1hVbUJvay83Q1QxMlFFelpwY041eGh5UXJiUWhaUHpSSGg5SzlL?=
 =?utf-8?B?ZUVDVC9PVUV1WWhxdEhXMC9JMnVrSVFVamJuOUI3RktpbjA3d3VPL1YyM1cx?=
 =?utf-8?B?c0JLM2NlVXFwQXRha3dqaWhNR1l5OU1ZTElaaS9MdTkrOUJNeEM2ckhscFoy?=
 =?utf-8?B?UGxRalpUUStRWHBWdVVOTXVKcHpNdURRd1RZMTdBOVFESjNHNDloWk5kTklw?=
 =?utf-8?B?dm9TZGZEOFBXanB4Y3d1bm11Qnd2ZFJ0dlFOVTZQdjR2ZThUWkF0Zzd2S1Bn?=
 =?utf-8?B?L21jdE9WQ1hBQ1JOdnhNd1FsWUpTcnN5anhrZGowbzc0Z1dnU2VYbjFyamhm?=
 =?utf-8?B?ZjdiSnB1WWpFSWVwdUVTd0NDWFJOSnAvYmtaUWg3MVRjMzh0UDZyOHBJR3lj?=
 =?utf-8?Q?6f2PMTVp/ib311yQcZbgWYyvKpVmHn0MGZLfw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e734e2ef-dc99-45ce-1be6-08df091341d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 16:57:22.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9192

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUdWVz
ZGF5LCBTZXB0ZW1iZXIgMSwgMjAyNiAxMDowMyBQTQ0KPiANCj4gT24gOS8xLzIwMjYgNTozMiBB
TSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBs
aW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBTdW5kYXksIEF1Z3VzdCA5LCAyMDI2IDExOjIyIFBN
DQoNCltzbmlwXQ0KDQo+ID4+IEBAIC0yNzAsMTEgKzI3OSwxNSBAQCBzdGF0aWMgdm9pZCBhc3Np
Z25fY3B1c190b19ncm91cHModW5zaWduZWQgaW50IG5jcHVzLA0KPiA+PiAgIAlmb3IgKHYgPSAw
OyB2IDwgbnYtPm5ncm91cHM7IHYrKywgKmN1cmdycCArPSAxKSB7DQo+ID4+ICAgCQljcHVzX3Bl
cl9ncnAgPSBuY3B1cyAvIG52LT5uZ3JvdXBzOw0KPiA+Pg0KPiA+PiAtCQkvKiBBY2NvdW50IGZv
ciBleHRyYSBncm91cHMgdG8gY29tcGVuc2F0ZSByb3VuZGluZyBlcnJvcnMgKi8NCj4gPj4gLQkJ
aWYgKGV4dHJhX2dycHMpIHsNCj4gPj4gKwkJLyoNCj4gPj4gKwkJICogUm90YXRlIHdoaWNoIGdy
b3VwcyBnZXQgdGhlIGV4dHJhIENQVSBzbyB0aGF0DQo+ID4+ICsJCSAqIHN1Y2Nlc3NpdmUgY2Fs
bGVycyBwcm9kdWNlIGRpZmZlcmVudCBtYXBwaW5ncywNCj4gPj4gKwkJICogYXZvaWRpbmcgSVJR
IHN0YWNraW5nIHdoZW4gbXVsdGlwbGUgZGV2aWNlcw0KPiA+PiArCQkgKiBzaGFyZSB0aGUgc2Ft
ZSBDUFUgdG9wb2xvZ3kuDQo+ID4+ICsJCSAqLw0KPiA+PiArCQlpZiAoZXh0cmFfZ3JwcyAmJg0K
PiA+DQo+ID4gRXhwbGljaXRseSB0ZXN0aW5nIGV4dHJhX2dycHMgZm9yIHplcm8gaXNuJ3QgbmVj
ZXNzYXJ5LiBJZiBpdCBpcw0KPiA+IHplcm8sIHRoZSAibGVzcyB0aGFuIiB0ZXN0IGJlbG93IHdp
bGwgYWx3YXlzIGJlIGZhbHNlIGFueXdheS4NCj4gPg0KPiANCj4gVGhhdCBpcyB0cnVlLCBidXQg
dGhlIGludGVudGlvbiB3YXMgdG8gaW1wcm92ZSByZWFkYWJpbGl0eSBvZiB0aGlzDQo+IGJsb2Nr
LiBVbmxlc3MgeW91IHJlYWxseSBmZWVsIHRoYXQgdGhpcyBzaG91bGQgYmUgcmVtb3ZlZCwgSSB3
b3VsZA0KPiBwcmVmZXIgdG8gcmV0YWluIHRoaXMuDQo+IA0KDQpGYWlyIGVub3VnaC4gSXQncyB5
b3VyIGNhbGwgdW5sZXNzIFRob21hcyBHbGVpeG5lciBhcyB0aGUgbWFpbnRhaW5lcg0Kc2F5cyBv
dGhlcndpc2UuIEkgZmxhZyB0aGVzZSBjYXNlcyBiZWNhdXNlIEkgc3BlbmQgdGltZSBsb29raW5n
IGZvcg0Kc29tZSBzdWJ0bGUgcmVhc29uIHdoeSB0aGUgdGVzdCBpcyBhY3R1YWxseSBuZWVkZWQu
IEZvciBleGFtcGxlLA0KaWYgdGhlIGxlZnQgc2lkZSBvZiB0aGUgImxlc3MgdGhhbiIgdGVzdCBi
ZWxvdyBoYXMgc2lkZS1lZmZlY3RzLCB0aGVuDQpjaGVja2luZyBleHRyYV9nYXBzIGZvciB6ZXJv
IHByZXZlbnRzIHRoZSBzaWRlLWVmZmVjdHMgZnJvbSBvY2N1cnJpbmcuDQpUbyBtZSB0aGUgcmVk
dW5kYW50IHRlc3QgaW50cm9kdWNlcyBhbWJpZ3VpdHkgLS0gaXMgdGhlcmUgYSByZWFzb24NCml0
IGlzIG5lZWRlZCwgb3IgaXMgaXQgc3VwZXJmbHVvdXM/DQoNCkludGVyZXN0aW5nbHksIEkgaGFk
IGFuIGlkZW50aWNhbCBjb252ZXJzYXRpb24gaW4gYW5vdGhlciBwYXRjaA0KcmV2aWV3IFsxXSB0
aHJlZSBkYXlzIGFnby4NCg0KTWljaGFlbA0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtaHlwZXJ2LzhkMzhmN2MwLWYxNWQtNDU2OC1iYzJmLTU1OTE3OWNjYjQ1Y0ByZWRoYXQu
Y29tLw0KDQo+IA0KPiA+PiArCQkgICAgKHYgKyBzcHJlYWRfb2Zmc2V0KSAlIG52LT5uZ3JvdXBz
IDwgZXh0cmFfZ3JwcykNCj4gPj4gICAJCQljcHVzX3Blcl9ncnArKzsNCj4gPj4gLQkJCS0tZXh0
cmFfZ3JwczsNCj4gPj4gLQkJfQ0K
