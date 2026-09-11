Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012055.outbound.protection.outlook.com [52.103.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BA4A4857;
	Fri, 11 Sep 2026 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144344; cv=fail; b=e6R9gVt2lOYXPRL1ypHK/J1i16D5yp/Y+NFN9TvYGOhigfvQt6TVf+29Ay10glXTIHTBvgiq0IfrNCOMr5LkazlWvsGEnwUJO7Aus8rfc2a8p/Lx3TKEKfL6GY7RT7kTeX2YJrgRWz6xudpCK5k/YUVgUysAB/vsRLvUgwiseYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144344; c=relaxed/simple;
	bh=bsYYZ4cvC5eLdLa7Cm7BsJmCzbENrF4t1unaWOpesos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K5hcO1qhu0faHgxUHMZ8G54vfg1zKpEeYUWbuR0Gormnqq5zAdyiJn/c2hTcWpNNz9tXRXXy4qZ3LWajqyeZok3fKPqR9p5FgmvMO6lMifvxIV1ZpBs2h5cgxlTmF5KlftOKSaJNv3CKbVNbAoHOIKnG97O5ysAqaIi0kxhyhFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hVmBD2D4; arc=fail smtp.client-ip=52.103.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hVmBD2D4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDUzU3fezORvWV5xGOK3P/00SoiPF02zZH7gEXk6roIPkil16lIMU6qD4pxn7jN81WzyEJYv6s8hw0sHNyipum6Ni0XSIFEt8yoIUXDSWMoB5H7LgGj8vzBtLPjIAinpof/SnxK5SKJyf+H3LVqkCQwLTLOtKZyfgyzKgs4dL6zDwU/uJsmkwyffqn6ySr1oocDDFjYtdDjmxcqYcNtvjycz8UwO444Bb3jX4wm3EsM+fLSA/V0ohhqraSjZZ0beLxR7d4dvCje2bSQm5dicg5rR1PmqirBW8chnXUdNUD8+rBVRINVXSzvJQU6s4AW6++XV+StM+mM7PztU6lUXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsYYZ4cvC5eLdLa7Cm7BsJmCzbENrF4t1unaWOpesos=;
 b=QcLKriZcg8+eXfgq3hzMPiLiDp+8BaHT4HEloC32yiRDbmGPAcaVbsMUwugqeWC1EuhSr8G10aoj3skpWqdi0ZNIRu0cm4XrC0p6TRb8VVstT50Rl5b4C2bM8GNgYOhbCWUcWx+o8b4rgC1JkRF2YWfZxH/IFih8BzCvfeVnmP2K7PN/XVBA1NDHrVvA+yS/Rnx9t1JiturUiRw88G/mSwSH/PlddBW3OJdfI7R/Z4KpXpAj/VrKm9JMMVL9+YcgjzvtZYrq3gGZCbQpmC4zuFKW1KUcK1ObWCC9JK2IgfS7ZzbIuZwtMbTEnk75lGoHAHU+x0c1fZ/Pa1KlniKoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsYYZ4cvC5eLdLa7Cm7BsJmCzbENrF4t1unaWOpesos=;
 b=hVmBD2D41ZqgOgDzfaVkCbH5n7d5mAH4E0DgTHNyeDfJS4TowSOC8pQZfs05QB7gAfTYe9ETVaLbsae6WPiLnHZIc4jC4iwGGlMyKdVuYhHxFzeXVzyeYwuPMjSzZqoYYHHL5Kd+fOdCBxXHBNOu+IacczRZRyl4u5N1lduge6VHpvjeyodLnPB8CJMRT0sopMRLEvPmAGy5hlrLCvhKFRaNyzg/bdTm4Ryy/AMgqPA7FWYKzIe84dcfjh0Bn5jelAJ1somSkIxEBkNbnm9MyXH9Tyt/jweQz6sTMw0xk7NZogevJtaZPUmYSwsVu56dOfY6cYDiRA0Y2f9vQk5KIQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB11699.namprd02.prod.outlook.com (2603:10b6:a03:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 16:32:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:32:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@kernel.org>, Naman Jain
	<namjain@linux.microsoft.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "namcao@linutronix.de" <namcao@linutronix.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Robin
 Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Aditya Garg
	<gargaditya@linux.microsoft.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
Thread-Topic: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgI+SZDwAUs2C3cA9ij63wIrtzLOtt2H6UA=
Date: Fri, 11 Sep 2026 16:32:11 +0000
Message-ID:
 <SN6PR02MB4157B093E09517D408FD58DAD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-4-namjain@linux.microsoft.com> <875x0e204j.ffs@fw13>
 <SN6PR02MB4157F453542D6003038CAC3DD4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87mrtoyzoy.ffs@fw13>
In-Reply-To: <87mrtoyzoy.ffs@fw13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB11699:EE_
x-ms-office365-filtering-correlation-id: cea39c26-d48a-4c46-7441-08df10223b54
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOo+9KyYVWPee/d58WG4vFl6jLtIi99AF2NsWxOsnBe7GwaV2HBXN4j/Y5OjSI53gvxT7NE5yzpfCHYI5/Ttfrd7PivrOH3eb+nKy5+wwClNlSv7R1jHzxIkspJ5RgFp0RQlwMEgXEdXL+kqxF51dodjruWSGVT96N3qNEI4ooWty40BEy3LNtA/vb5USojJ6jSdoYRwRLmNDeak6W+b0JQ2WcKq6AqP/CMDO5iyr7aqvjuUipN4G3L6o9DVEK145GzVZ6NRbqKwnKZNU8Rj3gMYgV0qd3JI2cn/a2PbFOdT8MIC47i635d0Y3yz5Q5zIBGkTPEOpS1y7Q+pE5E31x4Y10dXoX2+anuZthUG0fa9zXFsFL2DGuAgjOGeCLynFuuCdce48KPbkriG+/RCXmE+nMmMqVv5PIOlia62EhWzzpoSu32Ld4h8McTMrzbziPu8mS6KTsFZVKAbO9DmL3EDicfMWwfPeyEqFfhTy+CCa0JYlAPVn2im/gsAS5fil+EmBofaCLyI4+xAGS9IksrR8sFxgQmI/3qnblOOTbeKMBfd2lvso2PZJMMgl14x6++5hxT9zGUgKQSk26lWgCkw0bJaUpnw7NER1qfR1yUseTpr1xcioF2H4kX1StAd2a8paLdhEiriGtLgEAWFSD7LcSc3A/onA7MU6YPefNHxQVfdd2Vl6SvRxojCFn5/7XwdNPBkGS4/U5zjf853IG4p1KZcrYrHS/EEB0sN1mbVA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|12121999013|8062599012|8060799015|55001999006|24021099003|13091999003|51005399006|37011999003|31061999003|15080799012|25010399006|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkY4QmVKSEF4UXY2ajNnWmVWUWJJLysvTEVzYnBCeERHMDRBNWRmQmU3UE5q?=
 =?utf-8?B?aStCMGV2YnNwQi9XTmdFWE1nSlhjQ0ZrNUsvZnQxL0tHaEhnek5WNVU0U3dC?=
 =?utf-8?B?L0JEdTRnTDNaNmpXMFJxd2VxYWp6NUlWQTJpdFpKT294bXRtRG4wcnk5TjJ2?=
 =?utf-8?B?ZzBhYnMzZU5aa3krTXhNWkJhYXNwYS9jOS9lZFh4bFU0NzZscXNlNGhvQTZi?=
 =?utf-8?B?ZTRTelFrQ0krNThQK29XSmxMdXM1eGFwbTlta3c1MjRPU0xlVHprRGYrWGtz?=
 =?utf-8?B?Qk5Ndk5JT2oxQlY0M3ZlK2l6OVFtcTdha0Rrd2RQVUg0RHlBYUk3ajRjS1hB?=
 =?utf-8?B?cmVZekRmVGdTRW00dEFpNTY0dkVNM1hGRjRQOGNhRjBIMTAvN1FlMlcwa3FK?=
 =?utf-8?B?YlpGYTlVTTM3ekd4L3FPY3hHQ3R4bEpVVEppWGwyczlVcUd4c3UySEVZdkhM?=
 =?utf-8?B?SDdYNXl1cjRpUGlvL3ZTaDhhYnRIUnBNR0o5amUvenFta2ZlbTBNVkNTMjdN?=
 =?utf-8?B?Ris3UVJNUzFuOFpucmJtWkl1VFlERm9WQ1ZBelRHY3ZDSjNNeURuajJJTWls?=
 =?utf-8?B?U08yMFBHRHlJaHcyQTBQc0tjcm9WMWNtYzBnMVlYeUwxekdQSXlIb3pFWEkx?=
 =?utf-8?B?N0M2OGZWK2hSbHdwYVNKckIwaS84dlBKaFVYNjhLdlNDaTI5MldhaUJ6bFhk?=
 =?utf-8?B?SVVxdWQ3K2lSVGlidUpSVTBjczZUNTROeWduYzFvNWlKRjJwTnNYMDBOU3JN?=
 =?utf-8?B?SkxTNjZ6RGw2dG1UOHVBRVdaSEV1UmFwRlVDdER4RFpvVElHQktwbTVxN2p1?=
 =?utf-8?B?d0JKL1ZROHoyQmltbkcxb3VHaWgxSHk4Zm9OR3hmTjJUTkxjOGNLbnlpWnFa?=
 =?utf-8?B?WnFWbUdBRkNuaytPV0g1RXpBZ2lRRHlsMjNCdUsyMU1lMlhzWWRNdnk5bU5D?=
 =?utf-8?B?Z0gwY21pZHd5REJnN1VnZDd5K0l5ankyU1hmbENVTTZtOXF0Sk92d2g4blJX?=
 =?utf-8?B?SGxFUWVaY2h3ZExOTVhmcW9mQktTdThOVHluajVxcStIaUtwSTlQRExwZlRn?=
 =?utf-8?B?N1hVWjN5TG5ZUWlBUldZMXNxRUxKZ2h3Yk9mM0x4djI5VVdnS2lpbUxrMVZ4?=
 =?utf-8?B?dis2N2N6Ti82Y0E5QitSeEZOSC9HZkxuTjlWNmpBV2xNYXA0WDNKWlJXcDFh?=
 =?utf-8?B?S2t6WEJwU3lFaWwzWmRCK1VRTnk0S2JGVVBkYTJXaGFsTE1ldmcyN2hkbGwy?=
 =?utf-8?B?RGRuTitIdGVsYURmU2RBakozcm1xRmQyYUNLU1Q0RGp2S21XNHozeHFLbjBP?=
 =?utf-8?B?N2NQcUNRZDAyT2tZem5WR1JsVHdFUktFVEMzVUxjZjM2dElRVSs3dFZ1OG9i?=
 =?utf-8?B?bW82dHYrQm5nQ1BQVXdNaG9scHN6Y1VObmRnUHhpckoxZlhsUkxDOE0rMFVL?=
 =?utf-8?Q?DwfqqFPU?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkNUOUNZTHZiek9MREI2RlJaK0FlTXVXUlZJYzhQMGxhRDJGc1ViTUFYYXlp?=
 =?utf-8?B?bU5MZi9adGVUb1R6MjFhalE5UXoxSFR6L3MxU1BXeHNETldEeVRuOGV1c1lN?=
 =?utf-8?B?aTV6UFRNRDh2eU1kUm9WdnRvWEV3eUpPQkJUek9NQm1rdjVZbEFrOS9jSHp1?=
 =?utf-8?B?SlJHSFMxNk5CcGludE5lNVR4Y0VmQzdhVnhtWDkwd2djaDN1bE92UHlKTzJO?=
 =?utf-8?B?MCs0dEYvOGsxdTM5QUpCaGt6WCtXU1lYMGhGY25qczFnYlZVN3FydHluQTA3?=
 =?utf-8?B?dUNsWCtvZGxEaW1ORzhJVStYeTYySDJCaDdFSDI4bUs5WXZoTDZpSjBaWUQr?=
 =?utf-8?B?czFZOXQvWlRvOWJUTmtpSnd5YjdCWFUvYlJMUEU1Skhrcm9PRjZpaXQ0WFdH?=
 =?utf-8?B?bmxmdG1DY1BmTHRwK3kvNGk1S0dQR3BxazByTDNVV1oxUjJFREpxMm5qbHR6?=
 =?utf-8?B?b2w2bVVYbG9lWlNMdTh1S3RBRVJLa0dVWVd1ZDJ5UE5BUXpzcExOMHhpZnQ5?=
 =?utf-8?B?aW5YNnRXM3d1TWpiMGM3Y0ZIVzY5MkZOTzN5eTA4UDFwQVFoUWo1ZWIwM1BZ?=
 =?utf-8?B?Q2U3NElNOENsQ3pZY2FxUFo1U2d3MGN2RGpJZ2V6WFA4QWhKZFc3cW9FdFJG?=
 =?utf-8?B?WTJKOFhOSkpjSVE2UFlUbHpla3pBOXlUVlZjb2N1UWJLYWpNSkZPaTk5cTFX?=
 =?utf-8?B?TUkxWkxCTy94TUwyc2xpMUNBcXQ1R3pMTXRVV00wYzhjSnp2b2NkNnZSRGcy?=
 =?utf-8?B?aVlScy9YK2hXRkNzbVNUUTM5OHBTeFhUMThublhnWmJQdk9ESzhjdXlsRGlO?=
 =?utf-8?B?TkpTU2YxS3dYUFkzVzJpemJrRjkvSW5OczEwZGNGNUo0ZEFXMmZoaWVWSUZW?=
 =?utf-8?B?ZmZiL3lLTEJzWkJmRkhudVptRlBRVmZla0JHWHNlM3BEaXQ5ejRIVTdEcDEr?=
 =?utf-8?B?eXZGeUdtSWdKYnl5RkhlRFU4N01uTGNyQlFDSHF4bkMzNklDNGFxRXVLMFQ0?=
 =?utf-8?B?Z0M5Tzd1UTJjdUJzUjB4N3ZyWVZOQ2NkbTlrdWR4RzNmc3E4eFpXY1BEc1FU?=
 =?utf-8?B?aFlmWk81Q0w0N0pXOFQ4SjViNFpoV3J2VEZrWkJYVFlUUVpDVG8xUHZkSzNp?=
 =?utf-8?B?MnM5a0FCU3FRa1QzVCtJN3lwNjdGYmwzdTV3NWg1SVBDNW9IbEp5dEVZa0Vy?=
 =?utf-8?B?MXc1bmFaYXQ2WVpJNDBwbnlLOElJSFFFTXZSckl0ZmZiSmp1U0E2TldNM2Ft?=
 =?utf-8?B?eUkvczErVktNT2I3UGowMTFHU0s5L1lyb3BlU0xQV2lienlYdU8vcStMejkw?=
 =?utf-8?B?bHBnV3NQMlZ5TWt3amlVeXJVdnE5bVMwckZiZlEzQ3k1TGV3UzhCU25qbC8x?=
 =?utf-8?B?V09GdEo3Ti9Jb0FVWEVKYy80OVVPS00wRUNqYnl3NGhpazhCRS8rb2hTRmJP?=
 =?utf-8?B?cFo4bmhWeGJXbVNNOVBlclpGQU9QQkkrYnNiVzRpSjRHeGVKOGttaHNrQ2tD?=
 =?utf-8?B?MzVsSWlOSEl5Wkh3ZlY3aG9xdjhyMWFwYnlDU1BBTmtnUHRnVEZCRmdhRTVZ?=
 =?utf-8?B?cG1jMmRFNXJnY1FDWVdNcG1GR2xIcUlDOGFLZEx1Vlh5LzlSUHlBUHdkS0NC?=
 =?utf-8?B?MnIrMUpOVDhSWXlHRFFsRWRkWTZ5R2dsdGJZYmR2dFpuMmoxRE81R092RnBH?=
 =?utf-8?B?U3kyZng1MVYvbGRGSXhUQ3ZwdmJST1JsV29SRko0TVlHUlEwV3pYbThiWEEr?=
 =?utf-8?B?VHVnTGpoV05JeGZWNVVhRDFOSlNhQ3VoY050MC81MmlnUzNOekxxZHovOW5l?=
 =?utf-8?Q?g9ERsrfJWjLI0ukAInRQTXcEPKAnjQfFz4qNg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cea39c26-d48a-4c46-7441-08df10223b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 16:32:11.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11699

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGtlcm5lbC5vcmc+IFNlbnQ6IEZyaWRheSwgU2Vw
dGVtYmVyIDExLCAyMDI2IDE6MTIgQU0NCj4gDQo+IE9uIFRodSwgU2VwIDEwIDIwMjYgYXQgMTg6
NTEsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IFRob21hcyBHbGVpeG5lciA8dGds
eEBrZXJuZWwub3JnPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciA5LCAyMDI2IDM6MjQgQU0N
Cj4gPj4gSW4gYW55IGNhc2UgJ2lycWQnIGluIG1zaV9zZXRfYWZmaW5pdHkoKSB3aWxsIGFsd2F5
cyBwb2ludCB0byB0aGUgdmVjdG9yDQo+ID4+IGRvbWFpbiBhbmQgdGhlcmVmb3JlIHRoZSBleGl0
aW5nIGNvZGUgaXMgY29ycmVjdCBhbmQgY2FuJ3QgYmUgY2hhbmdlZCB0bw0KPiA+PiByZXRyaWdn
ZXIgaGllcmFyY2h5IGFzIHRoYXQgd291bGQgc2VlIGlycWQtPnBhcmVudCA9PSBOVUxMIGFuZCBk
bw0KPiA+PiBub3RoaW5nLiBOZWl0aGVyIHdpbGwgYWRkaW5nIGEgY29uZGl0aW9uYWwgdGhlcmUg
ZG8gYW55dGhpbmcgdXNlZnVsDQo+ID4+IGJlY2F1c2UgdGhlIHZlY3RvciBkb21haW4gYWx3YXlz
IGhhcyB0aGUgcmV0cmlnZ2VyIGNhbGxiYWNrIHNldC4NCj4gPj4NCj4gPg0KPiA+IEhtbW0uIEkn
dmUgYmVlbiBzdGFyaW5nIGF0IHRoZSBjb2RlIHRvIHRyeSB0byB1bmRlcnN0YW5kIGl0IGFsbCwN
Cj4gPiBhbmQgSSdtIG5vdCBzZWVpbmcgdGhhdCAnaXJxZCcgaW4gbXNpX3NldF9hZmZpbml0eSgp
IGFsd2F5cyBwb2ludHMgdG8NCj4gPiB0aGUgVkVDVE9SIGRvbWFpbi4NCj4gDQo+IFlvdSBhcmUg
cmlnaHQgYW5kIEknbSBhbiBpZGlvdC4NCj4gDQo+IE15IGJyYWluIHdhcyBhbHJlYWR5IG1lbHRl
ZCBmcm9tIGRlYmF0aW5nIG1lbW9yeSBvcmRlcmluZyBpc3N1ZXMsIHRoZW4gSQ0KPiBlbmRlZCB1
cCBjb21wbGV0ZWx5IGNvbmZ1c2luZyB0aGUgc2V0IGFmZmluaXR5IGFuZCB0aGUgcmV0cmlnZ2Vy
DQo+IGxvZ2ljLiBMZXQgbWUgdHJ5IGFnYWluLg0KPiANCj4gV2hhdCBJIGNvbXBsZXRlbHkgbWVz
c2VkIHVwIHdhcyB0aGF0IHRoZSBNU0kgY29yZSBzZXRzIGJ5IGRlZmF1bHQNCj4gbXNpX2RvbWFp
bl9zZXRfYWZmaW5pdHkoKSwgd2hpY2ggdXNlcyB0aGUgcGFyZW50IGRvbWFpbiwgYnV0IG9ubHkg
aWYgdGhlDQo+IHRlbXBsYXRlL2NocCBkb2VzIG5vdCBwcm92aWRlIGFuIC5pcnFfc2V0X2FmZmlu
aXR5KCkgY2FsbGJhY2suDQo+IA0KPiBXaGljaCBpcyBub3QgdHJ1ZSB3aGVuIHJlbWFwcGluZyBp
cyBvZmYgYmVjYXVzZSB4ODZfaW5pdF9kZXZfbXNpX2luZm8oKQ0KPiBzZXRzIGl0IHRvIG1zaV9z
ZXRfYWZmaW5pdHkoKS4gRHVoIQ0KPiANCj4gU28gdGhlIGNoYW5nZSBpcyBfbm90XyBicm9rZW4u
DQo+IA0KPiBUaG91Z2ggbXkgYXJndW1lbnQgdGhhdCByZXRyaWdnZXIgaGFzIHRvIGhhcHBlbiBh
dCB0aGUgdmVjdG9yIGxldmVsDQo+IHN0aWxsIHN0YW5kcyBiZWNhdXNlIHRoZSBvdXRlcm1vc3Qg
Y2hpcCBpcyBpbiBmaXJlIGFuZCBmb3JnZXQgbW9kZSBhbmQNCj4gdG8gdGhlIGJlc3Qgb2YgbXkg
a25vd2xlZGdlIG5vbmUgb2YgdGhlbSBoYXZlIGEgcmV0cmlnZ2VyIGF0IHRoZQ0KPiBpbnRlcnJ1
cHQgY2hpcCBsZXZlbC4gQW5kIGZyb20gYSBkZXNpZ24gcGVyc3BlY3RpdmUgdGhlcmUgd29uJ3Qg
YmUgYW55DQo+IGluIHRoZSBmdXR1cmUgKGZhbW91cyBsYXN0IHdvcmRzKS4NCg0KT0suIEdvb2Qg
dG8ga25vdyBJJ20gb24gdGhlIHJpZ2h0IHRyYWNrISBBbmQgSSBhZ3JlZSB0aGF0IGhhdmluZw0K
Zml4dXBfaXJxKCkgYW5kIG1zaV9zZXRfYWZmaW5pdHkoKSBqdXN0IGRvIGlycV9jaGlwX3JldHJp
Z2dlcl9oaWVyYXJjaHkoKQ0Kd29ya3MgdG9kYXkuDQoNCkFzIGZvciB0aGUgZnV0dXJlLCB5b3Ug
bWF5IHJlbWVtYmVyIG15IFJGQyBwYXRjaCBzZXQgZnJvbSBhIGNvdXBsZQ0KeWVhcnMgYWdvIGZv
ciB0aGUgU3ludGhldGljIEludGVycnVwdCBDb250cm9sbGVyIChTeW5JQykgdGhhdCBIeXBlci1W
DQpwcm92aWRlcyB0byBndWVzdHMuIFRoZSBTeW5JQyBjdXJyZW50bHkgaGFzIHNwZWNpYWwgY2Fz
ZSBub2RlcyB1bmRlcg0KL3N5cy9idXMvdm1idXMgdG8gbWFuYWdlIENQVSBhZmZpbml0eS4gQXMg
YSBiZXR0ZXIgYXBwcm9hY2gsIHRoZSBwYXRjaA0Kc2V0IG1vZGVsbGVkIHRoZSBTeW5JQyBhcyBh
biBpcnFjaGlwIHNvIHN0YW5kYXJkIExpbnV4IG1lY2hhbmlzbXMgY291bGQNCm1hbmFnZSBhZmZp
bml0eS4gWW91IGFuZCBJIGNvcnJlc3BvbmRlZCBhYm91dCBwZXItY3B1IGZsb3cgaGFuZGxlcg0K
dHdlYWtzIHRvIG1ha2UgaXQgYWxsIHdvcmsuIFRoZSBSRkMgcGF0Y2ggc2V0IGRpZG4ndCBnZXQg
dHJhY3Rpb24gd2l0aA0KdGhlIE1pY3Jvc29mdCBmb2xrcyBhbmQgSSBkaWRuJ3QgcHVzaCBpdC4g
QnV0IGl0IGhhZCBhIHN0YW5kLWFsb25lIElSUQ0KZG9tYWluIG5vdCBwYXJlbnRlZCB0byBWRUNU
T1IgYmVjYXVzZSBIeXBlci1WIGludGVycnVwdHMgYXJlIGhhcmQNCmNvZGVkIHRvIEhZUEVSVklT
T1JfQ0FMTEJBQ0tfVkVDVE9SLiBBcyBhIHN0YW5kLWFsb25lIGRvbWFpbiwNCmEgLmlycV9yZXRy
aWdnZXIgZnVuY3Rpb24gbWlnaHQgaGF2ZSBiZWVuIHVzZWZ1bCBpbiBmaXh1cF9pcnFzKCkuIFRo
YXQncw0KYWxsIHNwZWN1bGF0aXZlLCBidXQgaXQgd2FzIGluIHRoZSBiYWNrIG9mIG15IGhlYWQg
d2hlbiBJIHN1Z2dlc3RlZCB0bw0KTmFtYW4gdGhhdCB0aGUgb3V0ZXJtb3N0IGNoaXAgLmlycV9y
ZXRyaWdnZXIgZnVuY3Rpb24gc2hvdWxkIGJlDQpjaGVja2VkLiBJJ20gZmluZSB3aXRoIG5vdCBk
b2luZyB0aGF0IGNoZWNrIG5vdywgYW5kIGlmIGEgZnV0dXJlIGNhc2UNCmxpa2UgdGhlIEh5cGVy
LVYgU3luSUMgYXJpc2VzLCB0aGUgY2hlY2sgY2FuIGJlIGFkZGVkLg0KDQo+IA0KPiBEZXZpY2Vz
IG1pZ2h0IGhhdmUgYSB3YXkgdG8gcmV0cmlnZ2VyIGF0IHRoZSBkZXZpY2UgbGV2ZWwsIGJ1dCB0
aGF0J3MNCj4gbm90IHJlYWNoYWJsZSBmcm9tIHRoZSBpbnRlcnJ1cHQgY2hpcC4NCj4gDQo+IFNv
IGJvdGggcGxhY2VzIGZpeHVwX2lycSgpIGFuZCBtc2lfc2V0X2FmZmluaXR5KCkgY2FuIHVzZSBy
ZXRyaWdnZXINCj4gaGllcmFyY2h5IHNhZmVseSB3aXRob3V0IHRoZSBjb25kaXRpb25hbCBjaGVj
a2luZyB0aGUgb3V0ZXJtb3N0IGRvbWFpbg0KPiBjaGlwLg0KDQpBbmQgc2V0dGluZyAuaXJxX3Jl
dHJpZ2dlciBpbiB4ODZfaW5pdF9kZXZfbXNpX2luZm8oKSBiZWNvbWVzDQpzdXBlcmZsdW91cywg
cmlnaHQ/DQoNCk1pY2hhZWwNCg==
