Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012033.outbound.protection.outlook.com [40.107.200.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCEF51C35A;
	Thu, 15 Oct 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067802; cv=fail; b=c04Y8C4zTwpyPGegYvFz2cvwafV8bWgFVogD/kHSByT2XzvXArEm01xjo04gimXacozj6/bwKlQpfvSyWQoi425npbcEfYHj0YKLY5ec3cUz0j8yGaishr80lYPhSDy9m4UdcCmr4ahekgRaRkgPiFy2Jo5/SRT89tJS/3vFszM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067802; c=relaxed/simple;
	bh=NZjkpDCpuyx+I+cVtB/I8ZneUy53/3hMQJkqAtanulM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=sYzpmzHNv9JdLLqkChMq6q+5nkhUESbJc3/JEvOPRDODiwarYWJ+rhp39yrtsgnGfEEBnk6WWT+8akUhmgC+iRKyNtl7e2Tp9u3vOoGUn0LnG2noWPdq7d9lnUE/xbGLGsvjtGSeU5sEr+/wxTw00wbTMbzRfGXdNSHAsefrvY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kdc6obSY; arc=fail smtp.client-ip=40.107.200.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kdc6obSY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCm0jnOpth8R0NV15v7hxEuaioB4qAu59rAdQfLbj+ixAiSnOM/Q1FRTStdTlGDuwB9rWM4pVU/pyfaRaHx4kdm0M2sg4nVC4W6JDn3oh98KFaVHmIObaNXRQHdvWx5ITYulTB1AvGLUbhlVyNRFiPLkIZPE9xT2hmD/ua4c7BK4DWj+jDaSAf+sEUMZM+KLmU1FAGKPKpvoDujhagshaTB7FydE+o0ZO+HfggWF/hFZURGQiO/aigfaB28V6likAS5tLMV3OfQL8pOBhAMBjzlloDoe1ogzcONtPoXloO8q4jRjT+lQ1RHihcr96CbtRv1Ga/71MHtE+Watkg7cCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72cvLsDp8gWqAowHVaHtqvBqdTkfcZV+d2N3pfCjbMU=;
 b=B0m/pW9kp9YAe0aWIHCg/bEb3uLFs++ucXltU6e33we4THULxrXOINmrkL+PkagzPNyg/DV5bi6YmiVGRyDATzNkKjYtwHlxXGwYLDXLe3gU6ynB1OemTwFRZOr2IU28dOp6vdtYqSKVT+dEfIHUBP9+7eTRtJvORSg2MRN1sZPBVr6DjRz8zRKP5OV2E4Szrd0GTJu0OguTg3+UAFKZZytBmNGHqfe22E53mS5gmvsWlHWdpk0wCKkunjwqGwsYP7LRD1mK48JqmFcvnH7hrCa1W81IMzAMG9N9Va6F/YfqfZMWHvYF+Io4Hq/hOlYO3lYovNkaQi8Wf5qvtnTYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72cvLsDp8gWqAowHVaHtqvBqdTkfcZV+d2N3pfCjbMU=;
 b=Kdc6obSYO/byxH0km1Y8kTDdcLMX9eELGF+TDtwcxqRvwga24QnUjTSumIQk3hggfB+3Bi8/5I//e+QbM9fIM3HjY2td3A4bBsqb9Sc+Zeywr9FBCBvziGmnC0kr7ElSheb3crRwKGaJvuF0duFqAVhxw0u/6+Vd8OtuYHYckVhUrzmSO/iEMatg+rd7Q0iTnCWr4BlFDmQ65NG+XOiLLa2xkX9DmBEQiM3IHfXCV4U6zHbJEXG/1ydrq2m6HdydT7U16U34Cg34lyEyYzwbbM+IO0VoZH0Qu/U9+YAPYNVXuyv1qTfXfswWp/BNuZaSQ7ftHSK2LdYanxHm3lsVZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB7137.namprd12.prod.outlook.com
 (2603:10b6:510:1ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 12:36:33 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 12:36:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] iommu/hyperv: Fix guest IOMMU build issues
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
 joerg.roedel@amd.com, jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, 
 mhklinux@outlook.com, wei.liu@kernel.org, jacob.pan@linux.microsoft.com, 
 easwar.hariharan@linux.microsoft.com
In-Reply-To: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
References: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
Date: Thu, 15 Oct 2026 09:36:29 -0300
Message-Id: <179206778973.3923416.8800212000787941685.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e84ba8-9119-48eb-f7d8-08df2ab8f187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	au60Ras5QLgOCRWT5HIPHzCHhEKUzEVQbT6ywMYaBgNvFb5O/XCN/nw1Y50l5eY5bGik+bM5WxJWCBirWIFXscmIvhsaHq9OA3YtMtoNzqc46mRC8NJ37lbiUJ85edIPbY1peJdTElo0silHcVINRSOehd3IVAbWvOvtMSbR2+dka/11EKPoTweeyE+y1dy83Rjd5GqOAWVHkGCJD9oyet/SMGWluALuRDkeHThXYxq42m90fa+Ki+7FK4jH4C/Ff6CtXCfVYerOWWz9tk/cHj7QqvD0BkGkXKJ0R7PtjuwIRZ7BmgH+swbxov1fgbvjfHWKkFyEqMbuMWoptEAlNql4rTi2kwCeu1FuwZho4BhbTc9Dff41+47H2th4KvBiOhhr16JbhG1LSbdxDQ68cJ/ZTzpuAC73CsGN+3ke5G3OCg3/pn4K1Zyl/Kv2S8cQVCXkgtgXY/mjMGECUnXInEBTwNIUjebvR/XMKpoM8W8CIVk0zoM0IZW1EdlZu3t59h4pkHJ/pMSf4ddn6bIDtFInLtYjK9wAVexCBm/JxTMLnGgqicrzFZoWiqNfPtc4OUcGFiDxjpFelh/qe1z3thQqntwIWT8EarE6Cl2MTfx2CXoVWFK0YGSUw4vK/rwNwsqC2KyOL8a9VDfHaQMH2RsfQzI740QRmp4XAKp01Kw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXROd0tBdVNaekVPRklDSU0wYWw2THMzL1NmMmJtd2lOeFp5RkVZOGZ3TWFM?=
 =?utf-8?B?dGNGbHhOVUVuYjVabkM5ZXhhVFVSbDRPZ3BDcStyZUhRTVlpWll0OEN0bmZ6?=
 =?utf-8?B?NisrMkxoOUd1QjVITm52clZoN1VaRjhBOTRtVFptUW02bUo2aHhwa2pVcXFU?=
 =?utf-8?B?Q0xrSHlRY21MN2diU0pybzd3RktMRGRiTWNhQ0EwUVJObVBkK3ZWNFVBdHN5?=
 =?utf-8?B?WGYrYWhLTnF3UFFqU29QK3pRejBmck5Cc2NDbmQ3bWtmeU82UFhrcTJwR2lv?=
 =?utf-8?B?RFBSMkdBbUxReDhwOENoOVZ5RGhrb21JTFlCZk1XYVJVVE1zbVlubW90SHJK?=
 =?utf-8?B?VHVBY1BqYTZabmxzOEFMczV6Ym5JRjhnVXZ5ZGlrWmFrck9scEE2OGRYbWF2?=
 =?utf-8?B?Ym9aRE5EWDJRUHYvQmRUUVF5Q08vWmhGbm4xRWRWaDNoY0NMSkw1eVZnaVZD?=
 =?utf-8?B?UnMzZHExb2dWd24vbUdlUkw3VDhGaC9zWUZIOC9yc0pWOEFWYk5rWkNubHZV?=
 =?utf-8?B?NjNCcEVJYlpCdGZ5VFp2aS9DUjh4L3loZUZwWk1Ma2FyaDhMaFV4ejEwMWp4?=
 =?utf-8?B?bnhmWFgyZnpOemJaV3NLNG5McTRNeVFoY1RIa09oR1FVTGFiSVFVWTYyRUlO?=
 =?utf-8?B?SjJpdmM3NmdZK3NJMFhDMlltbDFjRmswNWJqdVhvN291VUpkSTZmOUFaaGFx?=
 =?utf-8?B?eThUM3V0Nlo2VFl1MVRiT3lVWUh2aGxMWFQvdFlUUmVZTWpUTWIxWEN3cmtC?=
 =?utf-8?B?NXI0bXFkS3NHQ2tDWlJvZ2VEMlZrS0JINTBlTGpPOFRjVk9LNEZnYk90M3Jz?=
 =?utf-8?B?eEdKNlBnenJ0b3IyMHpsTUVIbDZWVEErems0WXgzdENPVVlVcFYrL3JxQnJu?=
 =?utf-8?B?bUVVMEhIelZMbk1PdFYxYjQwKzNFWThmWWJGbTc0cFRWRi9BVWJ4akFSWlhD?=
 =?utf-8?B?eXB1b3JWSy9iYk5yd0FJSXUrcVlybStTb20wYmo2VjM2UEU0WDFaeUMvVDQ5?=
 =?utf-8?B?djFsWTgvenBCbHp3Rkk4SS9MUXNTVFVlMGtTR0NsdmVPRnhiY2tPbEVLRU90?=
 =?utf-8?B?QStIbHlYNnBIb2FpNGZkTlVIcGhyREZjOStadzNERUhja0h6MnpFbXhCMFdX?=
 =?utf-8?B?Q3Jkci9DRUZnckc3UElPQStOcklGRlkwTHNZSW5ZRUJwd1ZHcXVseDRFUXRO?=
 =?utf-8?B?WW1QdXFkTDlyYTlKaVlBSU5IeWYrb21IVkNncGdCcStQdUtQYXA5MXAyTG91?=
 =?utf-8?B?eWZtbGx0YzhpUTkxOFVEQW5Semt0ZUFMSkd6cFN1ZHArMjM1QWdCa2o5TDFt?=
 =?utf-8?B?SjdaL3NVYmV0REJWb2ZDdkd0N2wzMUVXVGkyWFg2eDR3VTR0NmJIRnBUdEcy?=
 =?utf-8?B?OEdJTDZqcU9mTkZqb1I5VXBSZ01EMHlsUEUwVm1vUWlRNEhLd1NHM3VvQzMx?=
 =?utf-8?B?ZUVPQmtCYWx3U1R1aWs0bExmTkhZY2trbVRtWlpCM0Z0bDBzNkJMREMxSDR2?=
 =?utf-8?B?N21maW9ITFVmVFFEQmFqdURLSmowcDdFSHJUZWNZb2k0aWh6WWhNRFhEQkFI?=
 =?utf-8?B?Y1lIL1U0MjdvamxqRmdhM1VENWVzbWorUldHUWNrcWtiYzNHcWdXN3BCSWJ5?=
 =?utf-8?B?c2tBK083R3dsV2hnd3JHc0UyTktNWTZsZ21qVWZEN3N3RWpxOTZ5K1RVTzZz?=
 =?utf-8?B?dHI3ZW9qOHhKTWhwYWIrTGl0L1l2VlptRE5rbmxIdEdwTHpjR3ZEUnRwRmk4?=
 =?utf-8?B?bUhqTjdieldyY0pGT0Q2UWpFVTluMEhsN1hlRnBTdUJKQ2ovQ3hiQTlXWnYv?=
 =?utf-8?B?NVBEZnRSUlJaSmkxNk5hZmQ1WHBBVitOS3E1R1phVExIRU0yZFBCTEQzQUdH?=
 =?utf-8?B?eGpNTnYxWm9sY2dkVWVPM1RSTFJEcHpKbG1jYkd5RXdRcEtENkhkOWR0M2lr?=
 =?utf-8?B?RmZLZ0piWXFqU2FSU25tajhuMWp2UXFLUnhVaHkrT2pzRkNvbzliTzJMLy92?=
 =?utf-8?B?NEQ3V1BSQ25XcmxaZ1dqbDlvcHc2SUJEWUZXMHN2S2tkVEd4TFVGZXJTY290?=
 =?utf-8?B?OHF0VFNxdzhYWUk0alcvVU1LOVJrNFhEWmlORjlXYnNmeFNxYkxGL3Z0Vmta?=
 =?utf-8?B?U2txdTlXbnJuT1VwblRwczZUQ1JMRE84NFBBVERWL3R5NnlIV2VoZGxzRXAr?=
 =?utf-8?B?cUdrTFFBdmtxNExmVE8yTzRCUFhYcDVVZHErY2ZPOWlSZmE2NllYcWNoTzRa?=
 =?utf-8?B?SWYzVkpYU3ZRY0F0dzJraG9DTDhiREEwNHp5MmYyUkN3eWlZMC80ZnhmMEFj?=
 =?utf-8?Q?qG/u46AQze4DQS1AjX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e84ba8-9119-48eb-f7d8-08df2ab8f187
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:36:32.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNZSaNJldtseFcP6btPGLrxLc1OI7akgxQwMYuBbhe9/6kjxCOPyOtWOisdZcKzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

On Thu, 15 Oct 2026 16:23:49 +0800, Yu Zhang <zhangyu1@linux.microsoft.com> wrote:
> iommu/hyperv: Fix guest IOMMU build issues
> 
> This series address two issues reported by kernel test robot in the
> recently applied Hyper-V guest IOMMU driver.
> 
> The first one adds the missing PCI dependency to prevent a link failure
> when CONFIG_PCI is disabled. And the second makes hv_iommu_device static
> to address a sparse warning.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
