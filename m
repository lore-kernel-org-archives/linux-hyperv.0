Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA295EEC3;
	Wed, 30 Sep 2026 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752692; cv=fail; b=lnosW4Vusm82+iHqE2sM+pTBTloPgDnGuR1hjl7cLPKyuT665VFUMx4N660NK/aO2OgGD0gsgP30WbvCPnfjR1Qot+6TJyZ8+KQCHDmonhWyEbaaj0BOa9ixmBOxfJLZWEwtfAHs5w0YsM7S6AYKJsNheGGUoCrgyNcYFYJxvqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752692; c=relaxed/simple;
	bh=zI2jXXXeW0aSycYYuJRkgHlDzDYAX77nHr+HI/EceKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxLomzEgdW5Kz0UugTATug/0/wHi4IA/zDdbAjiCgTS/HeJTDBh6hU+3KJt2s78LCd4PiMXVpBEHlwGz6+qypDTd9cXtGIUzDY/MI9xkgJ9hqjB/kOuZ4Mli09gbkGDuFhdCzreblEacoJNPSMBeTK8Ebi3A8QVhMdo9jD77VKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1iXJVQ2c; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1iXJVQ2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+n0krD9DFyHVeqTCWQA76Be4NSC8bB/cS6I/LQUpcrFzixW+lN4AsFEsBm0IwW1tRiVJfJcs36CdFpLbFtRxONGK0b2IDvmJtlM/B1shC4b3oZt5OL+t0kE94yVfWddiu0g9m4NQJrl6+blrwx7pyLC3ufN6++I2n8c3YCXUZ1PX2e7L7gb4wdLT7HwP8iJzUZQJ5iwL8x9qM51YvV3I2n662lo6Xedyu5Xd7Vhi+ZYcg/haKumydkw/tEURX+Pgx8ZN0VBG7KsUGTnTi+s2TTcX4EpEScV/Fct+VNYRnGvcll5NHHGMBOWnpIzQ59EPQk1z95uQS5wXrBbwEeMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/AIdNpPQKPuxsE7ffU5YealWJe9ET2Q5UTLf3GgZeM=;
 b=rMxXBDs4QFYLE7GrJ/8AAb7vvXSZDulDCtWNZQ3PkBjmpCbC1falChf92uJcjn9SyNHBOLE2hBSur9b+JwZdU/6122LbAIz7oEvu6jhF1HlpicxaTUDuHt5uw9A9AkgYO5OnOiPDE813ktGNjsdfMF8DYgIKyY8UO8kwu5EZNUQxkGqacxdWNCnD3iubNYOIIgiBMHupyvA3VwaDInNTG5bDr8SnFFelajGXLg3ryXReui4Js5s9bp6QuIkz9/kN4Ljizx5nAXlxTapqTzQRV6euiMVGu+uTAEXIez4HYYzlvsouePMN5DDGmajGQElEXl2l2xhUUzf0G04K2Qt02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/AIdNpPQKPuxsE7ffU5YealWJe9ET2Q5UTLf3GgZeM=;
 b=1iXJVQ2cGx0XJJoiZX+j0Z1uSMwHMba4Us3Vy6PVBa4g+zPgo84Uj5oXwNiPhWEBV6SdNX7DvmVsGisX4vaSPQclTmoFAdDxNb6QasJq1IEULbs68fHJkkBooJ49xZpsVWoxcjrAdCmmKwWPz9Vgl870RcgNeyZtAyLzfTv64E4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 07:18:06 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 07:18:06 +0000
Message-ID: <4e08d7ae-d591-4cb4-a269-4e56b1aa5f55@amd.com>
Date: Wed, 30 Sep 2026 12:47:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, baolu.lu@linux.intel.com,
 Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org,
 wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de,
 jgg@ziepe.ca, mhklinux@outlook.com, tgopinath@linux.microsoft.com,
 mrathor@linux.microsoft.com, suravee.suthikulpanit@amd.com
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
 <179071228738.122959.14326374887826159868.b4-review@b4>
 <20260929142542.0000575e@linux.microsoft.com>
 <30c45240-3dd4-43d5-8512-6f3e7e839f51@linux.microsoft.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <30c45240-3dd4-43d5-8512-6f3e7e839f51@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: f8beab34-9ce7-4542-2a63-08df1ec2f936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xz4D5I/nlRYDtOgCPeqaXwyDVnNUO/C1yJuEE4h0zuFaBcCkcaGan+ee/JkcVFYSBHghrv5XuIHS/ySGFLKdPtWZVz5saAFG7Cqq0V7/ztGNBBy84eZu9WHJxg17R01uS4ERelO8AmQD4jS11fMZc+x7ellJQlSSgdGQrGUro4tQG/Zwbfm2FmNglWxiDQ4cIWJO8e79s1aZ2JtGEJ9HlFHNt6+8+7eWS+0qb0mE5ZUpA4i+RX1dge8P3445tHsaT2+00dXf/jCwVXv07vQ4VvPaSoLt4ZH1d1vn0UkTc75x+xYgnIYGYaCBnrd2X7JLTGxw1q1dxEHHwuUd/rjRHeW1cjH7fHN+eJPeGLm7HmQNJPEtdpoOu1TqdgknXKyHdQF0zrKBRHt3+s9xGxyq7SXAwUivH54BtRGXpMMJzG+96m4B9ToUwWwVZh2FqWJrkR1LNP4C/vCmMdddzpZBKWbDm5R246qfW99aaL1CUfBlDr4sXGFG5155cKfqAxUGbq5pzdPfL5gsjA8RFzqZNWbkTyB5HMgewf6cjYWQ5+fGvncgWcf9vMrdxEvr8lfnsNKjJIH86YxMP1ehtmn0s7itlipnghME1xNINmmG2EshV3shicyDAAThCbQATCeeBlPpUzP/KSJbfpxYjbr/pA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFNxbytpVHlXUnd4clhPWkVTQTNhb3A1VVFoVUpUYzRzVHpadVBmdzBiNUlV?=
 =?utf-8?B?M2RVN3hNaU1HakRrbmdCVTFoUHE4bnhxN3FiOXpNeDV0Z0lvVzhlV3laZlQ2?=
 =?utf-8?B?Y2Q2MnM4ZDhCTUtVTUQwU0huNU9hb0hqcWZuMjY5dEV3T2w3ajN1NlZRc3lV?=
 =?utf-8?B?RFFzajFLUXFxM2dLS3ZZUWlYaE5KbXFWREZwaksvdVB2VWNxSzB2OE9ORjQ1?=
 =?utf-8?B?ck1IaDVJTW83RlZmU0tSMGtKNzk5clBENTFCMkNvTGVlSkVmRE9hbHZjNmU0?=
 =?utf-8?B?NVNOeHlnci8rVFJCVDV2MU1SRHo3VU55Zi9hY1JMT09tVVFsUWRCeGQvWGhH?=
 =?utf-8?B?MEc3SnZ2eDdSVVN4YjRremdaTXdkRm1BaU94S0kyVmpXVUkzU2JuNFpUdklI?=
 =?utf-8?B?UUlvR2NSeWQ5TzB6S0RuY1NtYUpZallYclNpcDk0MnJGbXFoNXI3bUFXSVkx?=
 =?utf-8?B?NjNLUnBwOUJwU3BmbjlRaSs4SjlvVHVtNG9CUUlyTUxMOUI2cnJsR2RJVHUz?=
 =?utf-8?B?SnZDRGNYSVZqTDM2b2sxLzNCZTBVZzJEME5vc3VHQ294SmM2bWtBM1hYT3pK?=
 =?utf-8?B?R3d6dmdNYS9sdFdEQWZ0a0hIallGcld0TDlWT2w1MW40cXZSbnVjMnY0MWh0?=
 =?utf-8?B?aEkzNGVWRjJibitYcjFYYU1MNk9oTU1BQ2NGbEZXY25qWGtueUpFMGZjU0dp?=
 =?utf-8?B?ZjZveW5HVnpna1lWTG9zTEhzM1JSeW4vUC8reTB4ZTNlcjFpUis5Z053cVBZ?=
 =?utf-8?B?T1MrbHVqL3F6L3ZWRWZIOS9JdUtWVEdZTHpQSWFtaDdQSW1yNGJWZEhxQjA1?=
 =?utf-8?B?MHYzZDBEMkRjc3FqaE90TklkVW56djBkNkZnZmE2WEp6WU9KMDN2WTZCLzhG?=
 =?utf-8?B?b1RQUjJZVk9zOVNldzVFZCt3dWVOSEhnV0RpTU9IeCtTcGhOSUJhS0NZR280?=
 =?utf-8?B?c254ZkxGTFFLR3M5Wk5Id2lKK2JxZzhXbmZBVkxESFYrWjhhazdpWjZLc1Fq?=
 =?utf-8?B?NE0yN0oramlSN2VGSGt2WEJibkRKelpzSXFrVkFFamI5VDZJbm1DdEh5RzVv?=
 =?utf-8?B?bURKblg3eDIyUkdPVFIwOXpLTFlrOW5uNG1nMVE2ZkRFUzZPek1TT05mSVZI?=
 =?utf-8?B?VkFJbk4wMlJRRUlObEhTQWt3VnVmRUlkWkpacjlDRmMzb0prWFQyNmhSS2dx?=
 =?utf-8?B?SEdHVXY3ckFIY1g2KzlNTW9YbTVLZlJXQVJRd3RRQTdrczE0R20vWkpyN0pG?=
 =?utf-8?B?cmg5WFdlY0R2NktvYzNCUmFRNk5ualJaRVNUbVRkemx2eG5peUhMRVM1NXgx?=
 =?utf-8?B?aG93bHVxVHZBNEVCdFFOWEU2czJ6S3RZSndMYXZoVEhXZSs3RzNmWXJEM3J0?=
 =?utf-8?B?NDhVNTFXdFJVd3c0aHNua3AySjU5dHdBYUkzMkl3TFYxYTN6L2J3NFVCZDAr?=
 =?utf-8?B?cTBydHhqdmRtS21RSVR2OEdOaHpTUWtGUTNtcU1GR2pNaGYvdFB5N3dSQXNj?=
 =?utf-8?B?TjFIb05Cc0JYdjZSWkJURDk5TjR1NmE4cFdmdHpFVVpxeW44SnN2b2xsbmR4?=
 =?utf-8?B?bFN1MkUvazhxNm44NCtDUDZSRlRicUZJblhOVzJ5a1JEMXgxSVlzbE5IbGZR?=
 =?utf-8?B?Mms4b2RhNFE0RExxcWRnNnltYTRsRzczWlc3Nnc5ejI4NjhveUppOXBuWmVs?=
 =?utf-8?B?cEVOUGdiZWM5bGlzODJacTRCZ1JrT0o2ZVN6aU9DNWVvTEVXMS9RTVlqc1FP?=
 =?utf-8?B?eFhuSXp6TTIzQkhkYWNVTWwzU3JEYmhLY0haYXhBSVdzM3FyYWFET2ZoVkxJ?=
 =?utf-8?B?RFZRNnRKcUdRM2FzcGViZE10Mko2LzN2NXhBMnA3NWJDUE5JMFVJdzZPTG51?=
 =?utf-8?B?K2xXUjhiZkdjR1ZOY2h5VE9WQWdUS0xZaWtscE5zYk43SGJpMlBrYTQrc0dK?=
 =?utf-8?B?Q2hLcytXUjBKSE85cWthTDVaeVk0S1g5Mnp3ZTFTZ0JzQ0RaRGhaZnRLK3pu?=
 =?utf-8?B?K01sUWtOV3BuZGRsTXRwb3Y3ZUhyczFTQTFpNlhVa28wWmZyNjEzSzIvOHNZ?=
 =?utf-8?B?Yi9VMUdqRXdkbERtaGZUd3NvUEUwR2VaeGFtbUxDdVI2Zmt6UlU4K3lyWnJB?=
 =?utf-8?B?QkZKRklNdnlyeWxObUZWdUp1aG53VlFoUU1Hc2xiWXFyd0NoZE5tY0JpbjBi?=
 =?utf-8?B?RnZySVJFL0hZZ3cxVXdtZ0hBT3lhaGtDcXBCK1pNMmpUM0VQa0hzNS9hRWdu?=
 =?utf-8?B?aCsxSzdVSXJHOVdtZTBGUE5TbmJsb09ueVhBNDJzUWVWcS92cFd3MThpUGdN?=
 =?utf-8?B?cW9pdzV4SHBvVmRrZWVxb3F2TDluN1dEV0cyalR5QjVMb0wxR2hyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8beab34-9ce7-4542-2a63-08df1ec2f936
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:18:06.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8p8sEm+agYxNKzYxAokFbEOuEdjC9Tek2HFoSswo92KJXW/+801kEem/0xNQG76KyTvThs2D7B0m9knWTYArA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429



On 9/30/2026 3:04 AM, Easwar Hariharan wrote:
> On 9/29/2026 14:25, Jacob Pan wrote:
>> Hi Jason,
>>
>> On Tue, 29 Sep 2026 17:04:47 -0300
>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>>>> +config HYPERV_PVIOMMU
>>>> +	bool "Microsoft Hyper-V para-virtualized IOMMU driver for
>>>> Linux guests"
>>>> +	depends on X86_64 && HYPERV
>>>> +	select IOMMU_API
>>>> +	select GENERIC_PT
>>>> +	select IOMMU_PT
>>>> +	select IOMMU_PT_X86_64
>>>> +	select IOMMU_IOVA  
>>>
>>> Should this be IOMMU_DMA ?
>>
>> I agree. I guess we should also delete "select IOMMU_API", since
>> IOMMU_DMA selects both.
>>
>> Noticed vt-d driver has the same option, maybe it should also
>> be changed. Baolu, is that due to historical reasons?
>>
>> config INTEL_IOMMU
>> 	bool "Support for Intel IOMMU using DMA Remapping Devices"
>> 	depends on PCI_MSI && ACPI && X86
>> 	select IOMMU_API
>> 	select GENERIC_PT
>> 	select IOMMU_PT
>> 	select IOMMU_PT_X86_64
>> 	select IOMMU_PT_VTDSS
>> 	select IOMMU_IOVA
> 
> FWIW, AMD also has the same...
> 
> config AMD_IOMMU
>         bool "AMD IOMMU support"
>         select SWIOTLB
>         select PCI_MSI
>         select PCI_ATS
>         select PCI_PRI
>         select PCI_PASID
>         select IRQ_MSI_LIB
>         select MMU_NOTIFIER
>         select IOMMU_API
>         select IOMMU_IOVA

We should replace IOMMU_API And IOMMU_IOVA with IOMMU_DMA.

also probably we should move PCI_ATS, PCI_PRI, PCI_PASID to CONFIG_IOMMU_SVA and
remove it from amd/intel driver code.

-Vasant

