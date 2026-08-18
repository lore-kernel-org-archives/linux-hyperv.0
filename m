Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010005.outbound.protection.outlook.com [52.103.2.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6713AC0C1;
	Tue, 18 Aug 2026 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029843; cv=fail; b=atbsM6phzC2P+G7kNLMgN0Cnp3wsK7PmPmP8sljUs7CAQqBTjJgxhNBe44Lq+QaGUPuTWePcUFafnqp+a8P2EiaSw/R5FHluIFecVU6Kpw2NAkBd15HNy6uO9v8tNSegu2sZj9Xg0P4jEx/TBjODyFanL8zxAeoJtq6qsFQri6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029843; c=relaxed/simple;
	bh=ebxBy/F084rqIHvyOG+LVXLFKSaGfXDKgSHDaxgbQ7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQcNz7VEqDSU8dqTvVuBu+DeU7bB5nBd4Lm7HVdleQW9OVEErTk526CclAeXX7n6vHR/bqamkFnaL6Rl+Rhtv8DIAo3TELxkeTk1yS0HupRKcppu/4RdUAymRipMGUwDEC6EtiGyZ18VXDb7xOVT1CIqMoiIvq+Q/MZ4NAUqKnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OMM4Suvd; arc=fail smtp.client-ip=52.103.2.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OMM4Suvd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSyS8rEbxKX1Flj5yiADXuTbUgwiR9g1KaVt7gzj4z837rgXTmrzBWJ0WffJzQT4O4GnVCx7JMfIKWLNjdHiWU8t+cnjZmZxvZca4kVK+/cUrNtqCAeS48tvSPqljGNsVhJ9qwv905DBC4fbtMMHkxfZO+t5XMTKu81Hlb9kfZ+SSeDij7aryhKm2tYWGDvjQK1FRwle/AGQxwn6Z8cn0dsf8udRHfp5Fy7tsJUCzD9crhh6Z6Vtc9IMyKAfPrVIMZtfPal1eHhs/dJtF0mSoV4JODhw03qu6kVz0X6MwARXqIQfjtNEqPTGJqSjFCHFE0Pg1DR2RkHoCwOOAbEUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebxBy/F084rqIHvyOG+LVXLFKSaGfXDKgSHDaxgbQ7o=;
 b=dmdRHvm/UvZGh/nvbFbmDBfxMIkKPxYkY9DpOzDjvadmdPSdtkPPK88zwlTcHrlLeU1SB9xeBXDKMNTAoqpE1PzWKFH50/V7nvo5AYcVXyxnYbYl3ZR7/lc1ctcGqhcKNLyACvc48SDuYEdi/iv12C+zcksT+UQWNIDM2+CA2r9CdMaT6nRvuPYw/UQc8/leqywbk2HkGOX7c4rebToO7HHRh0ZHjceZyFgxQ3WERCr6d1d4PVcg56EPx+ylaR0HajbiyltdIrnUAhE3KYKM05EVFVJWWK2JmxsoUD0DnZnXa47LLadAFZ0U45b4rnBak2victHv7ieyOSLVHRoxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebxBy/F084rqIHvyOG+LVXLFKSaGfXDKgSHDaxgbQ7o=;
 b=OMM4SuvdcegohnN0bTUs6DWWrlveyW4x/lHIPfgnQPezMN6R1upuBzlDuwNw+0Aw7G3OjFqOEWe/YKFrFMjzbzVDw9hSnxm+z2BS2ZZQkrM0dlHMnGGGiG7ENv0yLiPSKud9vjDjjz1rZVOIJ61Pqv1S+ql1XRQ983gq+/pgOuVct66P8iae6MTc5lCnZ9xOQ5E59whNHmffxptwRn4dZkFIGTNmz3PfMA7IdQqyURl9z1c7a0TZul7ujSjHxgfzgHThulowas6AzdQ8NdA1hn4kLXMruM8Xzpy96UXQa0GPzbIaQsnZy8vat4t/26D2K886h62Rjv0l1waktrRIjg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS2PR02MB11185.namprd02.prod.outlook.com (2603:10b6:8:333::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 05:10:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 05:10:38 +0000
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
Subject: RE: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Thread-Topic: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgHTB9rPtt3FEWA=
Date: Tue, 18 Aug 2026 05:10:38 +0000
Message-ID:
 <SN6PR02MB41570E8FC664CAC4A05CAFA9D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-3-namjain@linux.microsoft.com>
In-Reply-To: <20260810090716.2325295-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS2PR02MB11185:EE_
x-ms-office365-filtering-correlation-id: 4159d097-83cc-4a0c-056f-08defce70b0d
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|12121999013|37011999003|41001999006|51005399006|13091999003|31061999003|19110799012|8060799015|8062599012|15080799012|25010399006|40105399003|2607281247196008|18061999006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3h0aGVPRjFtNXpEMytRZmtHbmpOOEp0cHFVYVpyaWRHN3VWMmNiVDhseUpp?=
 =?utf-8?B?QWtweE9ycVA1WjIyOTZ6QTBVUzA0Rm5JZzJXVCtZWDYwWXVsUkVwYmxaeGIv?=
 =?utf-8?B?NGhWMTRNUHJKMDBBbE4ra1A0ZUlKWXQvU1IzMVNadDU2QUNiRmhqMlRRMGJn?=
 =?utf-8?B?UWk1dXpEeE5EQ1BYVE02KzRSeExtTzIvSE9qTmkwb203UktlM2NUVVJWbGdY?=
 =?utf-8?B?TGlidEY0MWh0L3pwOTVqd0pvOENQRitVQytHd2hnTkVTd1J5N1VzQk03R1NC?=
 =?utf-8?B?SXNBTFpMcXpzK3ZJMjQ1TW4zQlVLU3ZnQTJneDQ5SHYrdVo3QTM3RDF6cXIx?=
 =?utf-8?B?djZ5RkdFdk1HR3pmR080V2VXbVNlQWZZRzJEK3BocnZrS3dhSHUyeTdUS1lq?=
 =?utf-8?B?Z25hQW9rODVOU2UrWWxiZGxlMWxydHdTMzlCSy9NTHNTV0hzMjJad2p0aHJH?=
 =?utf-8?B?Q21GT1QrbHpsVFJ1NkhnMmZ4RHBWUWEwRG13dEtlRVZLY3BTRXBiUkZPdEN6?=
 =?utf-8?B?b2FwQVAvRUJ2N3QwdnRSdFBFTnd1NjdPdEZDZHlrTUFaczd0Z3dRU1NUZUJ5?=
 =?utf-8?B?bFFQa0p4dVc1dE94N1diSmdiZi9SdEhKVVVwditHWGVsT2tWb0ZuUzVNVUcv?=
 =?utf-8?B?Y1FEMVg5OWo2K1Jzbkc1WnBjVXp1WHNzb2gwbklkc1lQd2pBQitqdGh6RFlD?=
 =?utf-8?B?WjJ1QlhPeFNFTkFoL2NRbGVyc01zQTE3QkJnZUVQUU81MlZPR2M2UTNCejA1?=
 =?utf-8?B?VkRmRU5rRU9KVFhmb1JMUzhPdk1DSnRrSHV6K3htRGNGTmhYTmRKR0RDQlRC?=
 =?utf-8?B?Qk8rZ21FVmd0MWpKRm1hSWxkK1ZJVWtJdW4vY3l6dmRYUnF1eDFnY2ZOZGtB?=
 =?utf-8?B?dWpmNHBIZVJtV3dQMm5odFh1WHd1YitENzNEd1QrVFY2SXVacGJob1k3cEh0?=
 =?utf-8?B?U2syNW43NUxpcjk3NUN0NDB1ekIybjZtanpqdWtmemRhRUxsUFRUMVE3VlE0?=
 =?utf-8?B?NEVuQ0wxRGNzdGJmRHVWSER3a1lGL0hLcXVJWStkOHlKZmY5N1E3T04xSVlx?=
 =?utf-8?B?Z21oUGI1R25mZUtYdzRhVTNBbmxvcFRoUTE3MVJ0YjlhdEZXdFVKQUJJbWd6?=
 =?utf-8?B?a1JodFo4ZUtCc1l1UVdnaDlvYnFIV3RTQ0prdHgwdHlIMkVUQUpZVFJiTHc1?=
 =?utf-8?B?TlNoSkVnS3NDaVlvK2NuMHdNQkhTUGFzTm5wcG5pQmJhTmlxaW5HYjNybVc3?=
 =?utf-8?B?bHdEZUdlbzRUOUR1ZEwrMHUyeVJoQUtvR2VPQ3RCQnlxR2pFdGhGZUJ3SnhJ?=
 =?utf-8?B?MjVGbG00YytjeFNxU1RxRTU3cmVQaEFvVlU0dFJBWlRGS1hnNWxSTExIaXZi?=
 =?utf-8?B?YXJQWUM1SG1EclExd1UvL3RyVWx2aVF6RVkvTit3eStVMzA4UW5XQU1ydGt2?=
 =?utf-8?B?djZMM1NPUElGU0IrbVg4d0dONTZmdWcxTEh1cmhLUnprQ09td2RQNHJQRnRh?=
 =?utf-8?Q?8fWW0KLZmK0kTtmBYrSd5lUWEOF?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3FiQ2M1WWhzZnhGWStIbzdOY1hsYmpqWDhXUS9CUVdoYlBTQmxPdjdXTHJo?=
 =?utf-8?B?ankzc3FOcmQ3Z1RmSjhOcVdiYlFPajM1S1lCVWk1UUM1SVVJVGdlVUg1R3Vu?=
 =?utf-8?B?L1AwbU9MWHpQV213TUw2YlZLcEgwZ0xLLzdZMUpoOUkwdXZoVWR6NzFpUGUr?=
 =?utf-8?B?dmhGM2RrTzlUbnFEbGRVcmtzUDNrTEE0STFySTZFUERJTmVPSTJrOGRCU0kr?=
 =?utf-8?B?OVB1RUFEb2RMQ1gzMWxuUTJ4aXJiUlF4V1o0d3MvWUg3Sk1yd0hEbU1XUDVH?=
 =?utf-8?B?QVFDVk1VWVdZZzZqS1A1NysyS3c2ZmlpTUp0bkx5SHRzQ0J2SmdBUEI2VnUy?=
 =?utf-8?B?MkJqaDBqbjhRenRiejV5ZFJlT3h4R3F1Z2NmcTdFNVEyYVFLOHFjYW95RWZY?=
 =?utf-8?B?SjVjVEEyeEpyejdnaC8vRVNySFdINFRVTFZnaG9wODVZUWlhVlBKdTNodWQz?=
 =?utf-8?B?cTBLUklHTDVnRmpqWVdCQXZQSHVnc1pBSVpTU0dkcCtIdVBHc0krNFhIbU9I?=
 =?utf-8?B?M3NhVWRNZXd3M1Q4Q1QwM0JNdzQ4WjNrUVg4UU8velFJYmhyZEpweGRWY2dI?=
 =?utf-8?B?eERQVklMbXVhVGxHbzlEaWtLZXV1Z3Z1dDZnSS9xb0Y1RGptcHFIbFR0UmlX?=
 =?utf-8?B?V0lwRVlRVi9aUmFXSEdLN3NZa1JvbExQT0FkM1dzWEVNcno4WFFJdDRrVXEv?=
 =?utf-8?B?LzR5YWZLaHhoMmJuNTd6TEllVFA4ZU9lb2MySW5HNW8yaE03Q2YzMHI3cVFt?=
 =?utf-8?B?YUk2ckpMSEo5MkhZMEFyT09kRGJxZHVPRWtjTG51YVJvbld0cjdPalFnZXhL?=
 =?utf-8?B?b2p1OC9uZUVCR3EwQW5seGpDUmx2TkFxRnN1T1FVZ0hRcnJlMHZOVHBIVHRj?=
 =?utf-8?B?UmNaeEZyVzdSUnl1WWFOK3ZxZE9mQllUNm13eVNHM3NUTmJJZTdBM00wak5O?=
 =?utf-8?B?S3V5Wk4rTlRjT0toYzJnSCtHdnZmSy9sMXJuZE1zL2dGVVNHcVh2K1d0ak5Y?=
 =?utf-8?B?UHpvd1pXUUQ4VjNaSFl2ZWRHd0IrZGlxMXpCcjRZR3oyK1pmdEozcXdwRktW?=
 =?utf-8?B?RUp3THI1QjJsWEJlTUFiRllQNmRxL1dBSm44YzI5dlB6WHQxaFJJbDNkNVZi?=
 =?utf-8?B?Z3RzbHI4cVFqNG1lOEgvc0pEeG1JQ1ptMnN0QUFmbW5Vck5DNE9ZYXJoemtE?=
 =?utf-8?B?RnBCc3dGTmg5K25qV21iWGJRNEthVmlwdGt6dkMrbVRaSGVka1NzcXpiWXdr?=
 =?utf-8?B?VEFoUnEzSFkzTk00c20yMXhhbDdqQktnVk9QZGNYbjFEblRFOVBhYWFESjZ5?=
 =?utf-8?B?cGlNY3RXVWpidktLMnhZMEVmazFmdmpia1JWdGUxdTFzZ3FEZHZYdEthN3BZ?=
 =?utf-8?B?aDgzbnB0bFFvelhlU0lrY1A4ZXQ1Wm9FcVVyak5qRE1JbTZ2NllzZVRZVTBJ?=
 =?utf-8?B?Mkx6VWIzR3lsUTJwRTQ2aWQ1dVBNTTNEZUQ5VzRaQWgxS2tOOVEzYk1kVU45?=
 =?utf-8?B?OVhFRVlhbkE2akpydXlpWjRXMEJjQk9SbHR4OU9WRlcrT2dURWgzQllndkNC?=
 =?utf-8?B?L0hiMnE3aUVYcWtCelRYbmh5alN3RjF3VEt2aWp0T2RrMllmb1ZmM3RUMW10?=
 =?utf-8?B?SVlkOUl3ano2MEhFUkJ3TU1zY0Y2U2NhSWh2bGtWQlR3N0NaUk5zOUpIa2tD?=
 =?utf-8?B?aEt3TDRJeE51ZWg2cEt0cVZlSnZidkFEWVFUUE16dGJJeHM1QUtNL0ZrVXp3?=
 =?utf-8?B?emtpTHVmYVNWSXdkSHFNb3JnOVdHc0VGaHFQOFo4WDRYdXJnakNWb09sb1Ro?=
 =?utf-8?Q?Rl7wtaKKyUNEBUGsJtw03jshSnFoqENfHbU1U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4159d097-83cc-4a0c-056f-08defce70b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 05:10:38.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB11185

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEF1Z3VzdCAxMCwgMjAyNiAyOjA3IEFNDQo+IA0KPiBmaXh1cF9pcnFzKCkgcmUtaW5qZWN0
cyBhIHBlbmRpbmcgaW50ZXJydXB0IG9uIGl0cyBuZXcgdGFyZ2V0IENQVSBieQ0KPiBsb29raW5n
IGF0IHRoZSBvdXRlcm1vc3QgZG9tYWluIGNoaXAgYW5kIGludm9raW5nIGl0cyBpcnFfcmV0cmln
Z2VyKCkNCj4gY2FsbGJhY2sgZGlyZWN0bHkuIFRoYXQgb25seSB3b3JrcyB3aGVuIHRoZSBvdXRl
cm1vc3QgY2hpcCBoYXBwZW5zIHRvDQo+IGluc3RhbGwgYW4gaXJxX3JldHJpZ2dlcigpIGNhbGxi
YWNrLCB3aGljaCBpcyBub3QgZ3VhcmFudGVlZCBmb3IgZXZlcnkNCj4gaXJxY2hpcCBhbmQgY291
bGQgbGVhZCB0byBsb3N0IGludGVycnVwdHMgb24gQ1BVIGhvdC11bnBsdWcuDQo+IA0KPiBVc2Ug
aXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSgpIGluc3RlYWQsIHdoaWNoIHdhbGtzIHVwIHRo
ZSBpbnRlcnJ1cHQNCj4gaGllcmFyY2h5IHVudGlsIGl0IGZpbmRzIGEgY2hpcCB0aGF0IGltcGxl
bWVudHMgaXJxX3JldHJpZ2dlcigpLg0KPiANCj4gV2hpbGUgYXQgaXQsIG1vdmUgdGhlIGxvb3At
bG9jYWwgdmFyaWFibGVzIGludG8gdGhlIGxvb3Agc2NvcGUgYW5kIHVzZSBhDQo+IHNjb3BlZCBn
dWFyZCBmb3IgZGVzYy0+bG9jay4NCg0KTW92aW5nIHRoZSBsb29wLWxvY2FsIHZhcmlhYmxlcyBp
bnRvIHRoZSBsb29wIHNjb3BlIHNlZW1zIHRvIGJlIGNodXJuDQp3aXRoIG5vIHJlYWwgYmVuZWZp
dC4gSSBrbm93IFRob21hcycgc3VnZ2VzdGVkIGNvZGUgbWFkZSB0aGF0IGNoYW5nZQ0KYW5kIGhl
J3MgdGhlIG1haW50YWluZXIsIHNvIGl0J3MgaGlzIGNhbGwuIEJ1dCBzdGlsbCAuIC4gLg0KDQpD
aGFuZ2luZyB0byB1c2UgdGhlIHNjb3BlZCBndWFyZCBzZWVtcyBPSyBzaW5jZSB0aGF0J3MgYSBu
ZXcgcGF0dGVybg0Kd2Ugd2FudCB0byBiZSB1c2luZy4NCg0KPiANCj4gVkVDVE9SX1JFVFJJR0dF
UkVEIGlzIG5vdyBzZXQgb25seSB3aGVuIHRoZSByZXRyaWdnZXIgc3VjY2VlZHMNCj4gKGlycV9j
aGlwX3JldHJpZ2dlcl9oaWVyYXJjaHkoKSByZXR1cm5zIG5vbi16ZXJvKSBpbnN0ZWFkIG9mDQo+
IHVuY29uZGl0aW9uYWxseS4gVGhpcyBpcyBoYXJtbGVzcyB0b2RheSBzaW5jZSBhcGljX3JldHJp
Z2dlcl9pcnEoKQ0KPiBhbHdheXMgcmV0dXJucyAxLCBhbmQgYXJndWFibHkgbW9yZSBjb3JyZWN0
LiBObyBmdW5jdGlvbmFsIGNoYW5nZQ0KPiBpbnRlbmRlZCBmb3IgY2hpcHMgd2hpY2ggYWxyZWFk
eSBwcm92aWRlIGFuIGlycV9yZXRyaWdnZXIoKSBjYWxsYmFjaw0KPiBvbiB0aGUgb3V0ZXJtb3N0
IGRvbWFpbi4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGtlcm5l
bC5vcmc+DQo+IFJldmlld2VkLWJ5OiBTaHJhZGhhIEd1cHRhIDxzaHJhZGhhZ3VwdGFAbGludXgu
bWljcm9zb2Z0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51
eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9pcnEuYyB8IDIzICsr
KysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvaXJx
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaXJxLmMNCj4gaW5kZXggMzAxMjJmMGIzYWY5Ni4uZWYxYmRk
M2M0NjU5YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2lycS5jDQo+ICsrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9pcnEuYw0KPiBAQCAtNDY2LDExICs0NjYsNiBAQCBERUZJTkVfSURURU5U
UllfU1lTVkVDKHN5c3ZlY19wb3N0ZWRfbXNpX25vdGlmaWNhdGlvbikNCj4gIC8qIEEgY3B1IGhh
cyBiZWVuIHJlbW92ZWQgZnJvbSBjcHVfb25saW5lX21hc2suICBSZXNldCBpcnEgYWZmaW5pdGll
cy4gKi8NCj4gIHZvaWQgZml4dXBfaXJxcyh2b2lkKQ0KPiAgew0KPiAtCXVuc2lnbmVkIGludCB2
ZWN0b3I7DQo+IC0Jc3RydWN0IGlycV9kZXNjICpkZXNjOw0KPiAtCXN0cnVjdCBpcnFfZGF0YSAq
ZGF0YTsNCj4gLQlzdHJ1Y3QgaXJxX2NoaXAgKmNoaXA7DQo+IC0NCj4gIAlpcnFfbWlncmF0ZV9h
bGxfb2ZmX3RoaXNfY3B1KCk7DQo+IA0KPiAgCS8qDQo+IEBAIC00ODksMjIgKzQ4NCwxOCBAQCB2
b2lkIGZpeHVwX2lycXModm9pZCkNCj4gIAkgKiB2ZWN0b3JfbG9jayBiZWNhdXNlIHRoZSBjcHUg
aXMgYWxyZWFkeSBtYXJrZWQgIW9ubGluZSwgc28NCj4gIAkgKiBub3RoaW5nIGVsc2Ugd2lsbCB0
b3VjaCBpdC4NCj4gIAkgKi8NCj4gLQlmb3IgKHZlY3RvciA9IEZJUlNUX0VYVEVSTkFMX1ZFQ1RP
UjsgdmVjdG9yIDwgTlJfVkVDVE9SUzsgdmVjdG9yKyspIHsNCj4gLQkJaWYgKElTX0VSUl9PUl9O
VUxMKF9fdGhpc19jcHVfcmVhZCh2ZWN0b3JfaXJxW3ZlY3Rvcl0pKSkNCj4gKwlmb3IgKHVuc2ln
bmVkIGludCB2ZWN0b3IgPSBGSVJTVF9FWFRFUk5BTF9WRUNUT1I7IHZlY3RvciA8IE5SX1ZFQ1RP
UlM7IHZlY3RvcisrKSB7DQo+ICsJCXN0cnVjdCBpcnFfZGVzYyAqZGVzYyA9IF9fdGhpc19jcHVf
cmVhZCh2ZWN0b3JfaXJxW3ZlY3Rvcl0pOw0KPiArDQo+ICsJCWlmIChJU19FUlJfT1JfTlVMTChk
ZXNjKSkNCj4gIAkJCWNvbnRpbnVlOw0KPiANCj4gIAkJaWYgKGlzX3ZlY3Rvcl9wZW5kaW5nKHZl
Y3RvcikpIHsNCj4gLQkJCWRlc2MgPSBfX3RoaXNfY3B1X3JlYWQodmVjdG9yX2lycVt2ZWN0b3Jd
KTsNCj4gLQ0KPiAtCQkJcmF3X3NwaW5fbG9jaygmZGVzYy0+bG9jayk7DQo+IC0JCQlkYXRhID0g
aXJxX2Rlc2NfZ2V0X2lycV9kYXRhKGRlc2MpOw0KPiAtCQkJY2hpcCA9IGlycV9kYXRhX2dldF9p
cnFfY2hpcChkYXRhKTsNCj4gLQkJCWlmIChjaGlwLT5pcnFfcmV0cmlnZ2VyKSB7DQo+IC0JCQkJ
Y2hpcC0+aXJxX3JldHJpZ2dlcihkYXRhKTsNCj4gKwkJCWd1YXJkKHJhd19zcGlubG9jaykoJmRl
c2MtPmxvY2spOw0KPiArCQkJaWYgKGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHkoJmRlc2Mt
PmlycV9kYXRhKSkNCg0KVGhlIGV4aXN0aW5nIGNvZGUgdXNlcyBpcnFfZGVzY19nZXRfaXJxX2Rh
dGEoKSBpbnN0ZWFkIG9mIGRpcmVjdGx5DQphY2Nlc3NpbmcgdGhlIGlycV9kYXRhIGZpZWxkLiAg
SSAqdGhpbmsqIHVzaW5nIHRoZSBmdW5jdGlvbiBpcyBwcmVmZXJyZWQsDQpidXQgbWF5YmUgSSdt
IG91dC1vZi1kYXRlLg0KDQpTYXNoaWtvIHBvaW50ZWQgb3V0IHRoYXQgaXJxX2NoaXBfcmV0cmln
Z2VyX2hpZXJhcmNoeSgpIGRvZXNuJ3QgY2hlY2sNCnRoZSBvdXRlcm1vc3QgZG9tYWluIC0tIGl0
IGltbWVkaWF0ZWx5IGdvZXMgdGhlIHBhcmVudC4gSW4gdjEgb2YgdGhpcyBwYXRjaA0Kc2VyaWVz
LCB5b3UgY2F0ZWdvcml6ZWQgdGhpcyBhcyBhIGZhbHNlIHBvc2l0aXZlLiBCdXQgSSBkb27igJl0
IHVuZGVyc3RhbmQNCnlvdXIgZXhwbGFuYXRpb24uIEV2ZW4gaWYgdGhlcmUgYXJlbid0IGN1cnJl
bnRseSBhbnkgb3V0ZXJtb3N0IGRvbWFpbnMNCndpdGggYSBjdXN0b20gcmV0cmlnZ2VyIGZ1bmN0
aW9uLCB0aGVyZSBjb3VsZCBiZSBhdCBzb21lIHBvaW50IGluIHRoZQ0KZnV0dXJlLiBTbyBpdCBz
ZWVtcyB3cm9uZyB0byBza2lwIGl0LiBCdXQgbWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nLg0K
Q291bGQgeW91IGVsYWJvcmF0ZSBvbiB5b3VyIHJlYXNvbmluZz8NCg0KTWljaGFlbA0KDQo+ICAJ
CQkJX190aGlzX2NwdV93cml0ZSh2ZWN0b3JfaXJxW3ZlY3Rvcl0sIFZFQ1RPUl9SRVRSSUdHRVJF
RCk7DQo+IC0JCQl9DQo+IC0JCQlyYXdfc3Bpbl91bmxvY2soJmRlc2MtPmxvY2spOw0KPiAgCQl9
DQo+ICsNCj4gIAkJaWYgKF9fdGhpc19jcHVfcmVhZCh2ZWN0b3JfaXJxW3ZlY3Rvcl0pICE9IFZF
Q1RPUl9SRVRSSUdHRVJFRCkNCj4gIAkJCV9fdGhpc19jcHVfd3JpdGUodmVjdG9yX2lycVt2ZWN0
b3JdLCBWRUNUT1JfVU5VU0VEKTsNCj4gIAl9DQo+IC0tDQo+IDIuNDMuMA0KPiANCg0K
