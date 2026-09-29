Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53F35295C;
	Tue, 29 Sep 2026 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712295; cv=fail; b=pMTMqXMBPE53UHD9v9mRnJSovymMwv6ReCNSV55QugV2zML6zKZ1v3w94LL/L5BAA7LiMdlCjE6n9vbp+UPplYiZnK8nRys7/U8gLj2tmr2oDdtcLzo5HfkVmBqtGlORVOTY9XaoFzyz2z16Mpw0WCBEMYwk6Hn9K8Z2Zd3m12k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712295; c=relaxed/simple;
	bh=gVG4saXOBCLmMi7Rj0vzYNS9JcsWmzCIgQeoOxKCBMk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=a8eS3vWltQ1X5p14Uu7GC/BPRWfDmUhsaRvCW8+5AfphKk/dLP8/XR+G95NRp+wvx+WQDg+qzp4VH7ytjYz6zqaMa+miUhBtX7rXa6JBBKZvbTeP6z7nNekwUm4zRB7G7LxJ8uYCiOrP4swGdzWtm+riG2fYIo/kd6qG+PY7x5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9SftA+z; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9SftA+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5p2hxk0leGhCrAFRNaeF0+zRpYp+jCJy/2el70grquy6l44ZCDkPe5eiRrz48ctWa5g3JV1Tb+ROVDxriO3DWpQk4tuNOdURVWVJzTRmTjAEZcRamWoIF+/CZuT3UYjIgl8On88b+I8jyvF39Bx5A1ymQYzs/GqE1Mo31GrbZvuJ7+B2BwrJQlSSbPZqZgQFMKToUG/d3c0PkeTKQLWd2tkxrXp5Qvmpb6HG0lAmO0zGY1VXAh9F7dWfQ+mxKSEjIYu1LUMy1LHw5tO99Jqk0mS0FKaPJfLg4VhtVoDrFwpbm/11IKE8tReLE80Q/ZXz12BzLigDziMvbRGJPDmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86S8QrB4xPHDUFp2odqLaesF53+576m2YrZXeCRfL1o=;
 b=bY7W3l5d6t7F+J1B0VtM03dy5jfGmzKQBdH3+aYmwRjHPUOxxknP/4fp4OeK4EpbQmn+QeedrHadIdwfDOMqhAvxltI4aPQz8a1BfQ+5mqmPIe/sg1vAH3291gpsbs5pvt67l7EnK/E3Mi/zmkc5sWhfDZS5fKR7RuPCO4tltUBYikMg19y/9ftPGG52KV71fA75S/OQyaEtYoTMk2gLt8OelapD3qi3IRUToeur7JBlBqLAJ0Sr1RJxgQThDK/p68sz5ab02/sli+oowQ5FCt3wwFWYxvxE3m7V2vBBwEIwSZdVeggfT9iaATofpWMIAUbxihI9TUB70bruatJMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86S8QrB4xPHDUFp2odqLaesF53+576m2YrZXeCRfL1o=;
 b=n9SftA+zZTomVFLGa6TrrTFiWhsWUf4AFpe8XVu+aTWqaQafBZqRhoqUvHj8cjhISa2DCPHSVGS9s2N6jNOtPiVxB2SGqT1pkm1f7vMcUZLDO4ysI/WdsTFyXbKJQ6ST0P7bTbFeyyuAIPcYNxLfJpB5tn+AtH8chwmsDQROSDVlrw92OGKRJpL4+gZH8z8P8ktb9hQSgqGVoiLM111IGT1qIubYwUBEwAfjqZHrazlze9iYs2MzvcuT5dMCwQzuF4UYVDCOmRJETiyjE4NFvBlHzJMZjE2dJFJxW9LzG0rKebEy7yMiHTCxwJIxCZ25CQIaDaaS2vpoLV5BgK503A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB9499.namprd12.prod.outlook.com
 (2603:10b6:208:595::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 20:04:50 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 20:04:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/5] iommu/x86: Add architectural MSI reserved
 region helper
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org, 
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
 longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, 
 jgg@ziepe.ca, mhklinux@outlook.com, jacob.pan@linux.microsoft.com, 
 tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com, 
 mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, 
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
In-Reply-To: <20260904075512.174154-4-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-4-zhangyu1@linux.microsoft.com>
Date: Tue, 29 Sep 2026 17:04:47 -0300
Message-Id: <179071228737.122959.7908797795671322680.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: PH8PR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 891b5398-01fc-4a14-6507-08df1e64eb7f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|10067099003|22082099003|11063799006|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cbxEny+gTJuIG6sMBstheKhsom3ilkkYIsFHErqrix0BeUWulaNxdiAKf08NcbR02MEZT4Ey4EWVwGmG2xnnMJQK/jFXwWX3iftrmsErTFCc0q9sFAMd5lkBDT7NLuvyrKbQv4eJ/nZNOr6wcpI8JXzNihmbxBBz0z/LN+b5vJhJLkqe5m2G3jTTrHB3CO5FmSvWAz/hiR/pTxqk+DFuUIKwioC2cVNwL6/JKuEaWCMBWII5IYZyZJdlygBG7u1wdO2NlEvnuJYOi/ApM0wrTgKmchLvMWLuSz0rfMLyzqZl7jJ44TS2LFljXXReiePlJIAXYYrUHVFM0ZcCrPXh1meZKU46AQfQ6ceX/DSJyTJb2V1HBpWNHdR9mlBi9ZS9Dhynj4Gi/nSzkGcpshkQTXEAB5ZqpQbXTdJ4Gc34M49rCi81jR5SBQish3Xjhz8c64pHHPenJfUStw+BTpeVnHOqYjcCYmbce7LoDGfbGWQjJxy9TqtGJvt5gw3ITFfjcyZo239wssmySDux+iYuxwyZASOZeUfnH0+Rk7XggSR48xeHnbjtIAExQUvWUzS6DQRUwImBRBZUPwFqJDfLNSE64s8E/IKZLRYo379B3BBzY0trDU1To5fv96+ql4L0GxEz91KWPbrybVOq6fbcOCATDkUezxCNITRqWFBuDk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10067099003)(22082099003)(11063799006)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG9SdWYvRUZ4Zmw4ellrNVQwS3pPZEVoeG8zbXh0M3psSkRyYlVjSWMwQmxt?=
 =?utf-8?B?L1d5S2M2Rjc1UUN5S2ZuVW5uZmFlaE93cmlNSFhMWUlKM25MSGRhWEx5cEFq?=
 =?utf-8?B?YlQvWHF6Qk5KVmE3UWc4cTBLbUJpdDhjSzRkUHFpdmlGM0xEQng2L2t0VWRq?=
 =?utf-8?B?RWxLajEzZFk2TUplV1U0U2Mwb3VOdUZXc3FUS0NGT1k3VzhkenczUk9XeC9x?=
 =?utf-8?B?VHNXK3lGY2JQU1VBY3NsSytYMDFGTEsrWW5OTTlTdk9haWp5SnFiY2xYcG9F?=
 =?utf-8?B?U3RPWmhQVDdTbWlta2F2a3dCK3dha2JhbGRld3RBSzROZWpZRkJ3T21rSVpC?=
 =?utf-8?B?L2xFbUkzb2FRejIvWDZYMktYNzQ5OFNQbDFWTWx2elZRM0M4dTEyNE4xZWIx?=
 =?utf-8?B?V1NaMmU1YTR1U2dLZ2pyK0FEUjdkTTRRUFBGWTd1dkpIQUpPSWxicGkvSWRL?=
 =?utf-8?B?VGF3SkVpZzRwZlp1L09BVkdKdXFFOVhNeU1DQjJxUW9FV1ZWN3VoUXdISkpT?=
 =?utf-8?B?VXVnNDUxd09WQmFjVVR5TTdUMnlLZERRUVBYcGw3QzBJVHI2M1M4TDNMbU9T?=
 =?utf-8?B?QkwvWURjWE92ZE85OVJHRkJXd1FKU1FOY0xHUEFlNE5zczdBYWRNWEMrV01H?=
 =?utf-8?B?c3FCL3ljdmw0SGUyQTQ5RXlCdXJrTzR6azBlYVQ4alFWTkhhNDVodUlVbE9k?=
 =?utf-8?B?N2YxeWQzTWppbkJLUUlXaERldzFjWXpZbUtNZFdNTk5vYXVlem51UTg0SFN3?=
 =?utf-8?B?Z0taaWtUVTJzTE4yTkhQeTdsTFhHVllOSVp3WVBIdExRUzZuc3h5T1U2QWVX?=
 =?utf-8?B?dTNDNzdCUk5zTkZaeXNhbUdEQ0RCbFUyTGhIVUNtYmNzaElGcGQwbDlFZkNM?=
 =?utf-8?B?K3BCdkI0YTRXQUNqSWZ6VSs5YWlRcE9nb09KRXJ4Rk4xUFNuVHl4QW5HbmVU?=
 =?utf-8?B?TC9VNWo4TEpwdkpBK2d5NHFyVGRQRWRJWlQrMThrSXJxOGYvMDZxcDRrOTcx?=
 =?utf-8?B?VWpPMTVBcWIrQitWVTY3SWJQQWRQekYwQ3hTYzYwWG96bXpNcWtKU0Q0TnVM?=
 =?utf-8?B?VEw5NjRndVlJQlpMZ3FsMjd5NlZDa0VLWHRmTTQzUDg1OEE1SGxKTTIyM2Nn?=
 =?utf-8?B?ODl1aW9aN3MrWS9pcVE5TjFaU1NrdXZiaGZwd1NNUU9lM3hQVERCQXdCNkdq?=
 =?utf-8?B?ZE5FSXYrSlliT3RsSGVxMnVtd1U1M3NwQlRuTll1Z0d1ZXgwQVFRNmFWQUk3?=
 =?utf-8?B?UEtFRFNpeHdTWTlKVGRQWThRS2Rtemg1V2x6NWVPeElzenVDSUZaYitoRnNG?=
 =?utf-8?B?QXU2T0RBVTFjeHkwNzEwbWl1TU9kUTFzcXB0bW9oZFRjeGdsRXIzUmpBalJS?=
 =?utf-8?B?N28vTEdRYmRWN1pmWFN5T0IycUNJa3h5UE9Wbkg1T3N5Yzk0czMwNWp3MGgy?=
 =?utf-8?B?N3ZjWWw1amcyVHFERDlhTlc0eDFnWHNraVlRV3NSdHNXaVFxUStJWHB4SlIr?=
 =?utf-8?B?MkdlR2EreXBkSGpOUUJDdUt2Um5ib2pka2hyUmJIaWIvQlo0NHJLOWl1RnVj?=
 =?utf-8?B?ZXJ4QmhnTFhQYkVsMm03TFVub0xCTDZZS3RueUZqTW9UQThHQlIyUDgwS3Z1?=
 =?utf-8?B?aWJtcWVFSFJ6Z0Vydnh1M3A2WFRRT1padFMrZDZQWExMRlZXSFpJbGM1Misx?=
 =?utf-8?B?K3ZoMWZmV2R4c1NZeDlMTlhINTB6WmdIK0xmNW9sUVg3c0h0bWZaYUljR3lv?=
 =?utf-8?B?QWRQZHJUbHhPTG9TaU94TjBkenBDTWtoNWlSWnZSei8zUXhkeVpmZHR6Y1hq?=
 =?utf-8?B?ZTM1U2YybXBURUdCbC9TZ1BtQ0tjeGJ4aHM1TFBnQ1RxOTdudXBaRE1LZE45?=
 =?utf-8?B?bG5jdlUwTmJndUREai9teUFqamhMeXRoMGZMN3dscmF2anBEUFUxSkM0aXlh?=
 =?utf-8?B?WXFIa0xveG43NXZQTm80MmpjVmJYYm5WNUxVRUFYa2NIVVNZaDAxS0M0UHFW?=
 =?utf-8?B?Sk9VVTFxcm03WXRVOVMrUWc1aUtIYzNDbzYvNkw5Uk9SNWxubk9MeEdrNTgr?=
 =?utf-8?B?THd3NFhQdFN3dFE4bTR1clVKN3NSZWlqZm9HUk1yNVdHOUQ2ZkFKUWZuMHRE?=
 =?utf-8?B?c3R6R1ZMbTVOMytHNERySmwxdGtIdEh4bGVmeXVOLzl4aUsvRWRoZ05TeERh?=
 =?utf-8?B?NzAzUXArdHpGVXp1bVdTNXhEQTVjRU0wR2ptMUZRTDhQT0h5ck82dE9kU1A0?=
 =?utf-8?B?MVVBQjYxTHoyRENlZHRieHJnRktZcHE0QnhLMEFjYXQramRCeC96ZCtzZDVE?=
 =?utf-8?Q?w1N5j4Sj5SxXiMV/Kn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891b5398-01fc-4a14-6507-08df1e64eb7f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 20:04:50.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGYwSDeYZf4t/KaqZ6/DNXnbzdgyM2MuDvUdw5TuElZWpc4qwOQwvPHL5D0TBp4y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499

> [ ... 16 lines skipped ... ]
> index 3be2451e7bc857..6404f4fbeae817 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -4,6 +4,11 @@
>  
>  #include <linux/acpi.h>
>  
> +#ifdef CONFIG_IOMMU_API
> +#include <linux/iommu.h>
> +#include <linux/sizes.h>
> +#endif
> +
>  #include <asm/e820/api.h>

IDK if this header is the best place, nor do I have a better option,
but the overall idea is sound

> 
>  extern int force_iommu, no_iommu;
> @@ -21,6 +26,15 @@ extern bool x86_swiotlb_enable;
>  /* 10 seconds */
>  #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
>  
> +#ifdef CONFIG_IOMMU_API
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_x86_msi_region(void)
> +{
> +	return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
> +				       IOMMU_RESV_MSI, GFP_KERNEL);

Though I think it would be better to include the list add tail here as
well.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
