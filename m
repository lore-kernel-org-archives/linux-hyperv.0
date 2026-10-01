Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8437A843;
	Thu,  1 Oct 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856467; cv=fail; b=QoyyEnln4Enm9XQ50nm4PGn0naiK8AGGH7gkFC1ReMW8w+ZSPeYiaNXOM4ofgfIFf6I9QRn+8lkyTgZJhRKsmSkwOlgVXkHPfSRjfFNJl1I6VeVy4WFIn/jd/o/Huu/+zRHyJO/HD4jVQj+In9rsq2kXbzPGqUGFWC+xuGN81+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856467; c=relaxed/simple;
	bh=pPyCah+mInsCakdsfxi2qG8f0Ad3K3t37OxvRuGeMjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZYtT9tan8NzqTxndKyKEaP+HjdSF8NnV2v88V5sgd3/dsiK+ucT0JI+ZKFVKIfH5gepC8hJjYMci0mgky17GkJ3TWyfvQWZwpS1x+44AhdcM4EwoOgCC+0fz+eX5IZY8V9l6g9dJjmc2z9KHDq1beDoYpulNbQs2q5vReryc24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PrWLU/J+; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PrWLU/J+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwTe6anhhMXRmh4nohyH/qA/lw0JfHTN273NnRlsTjcFTcMD+VoApTsJNJ7ehHkzTNASeqbFWFsdMbVT+Ko0v9gEoRfv+184AXzWJ9ij294wBSYDTt66dThLdezon58zA/+ehrcM8FmkHEb7lFG15MaGB9d4PvMQaghhjap0+jSAOWMPtxmQa3BrNCXx2HRI5WYfsRbttPvyhQkovy4L37KOHC5zQw21DH1ej+fpLX+U80WkNSVvx+MpNsbG2zJ0RrLEGo9Q/8aaLUN+k4X6CvC5gZryI48P6/L9iIaDHjUXbox32/83yBVunfx9UM4vQXwxRsJb46pTB+ookiILGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCabl5OXsvXGxdp3snxfOqxTNcEu2FkhNPhp1zWWWAA=;
 b=Bd7Rh09oD5rpdq40/gtBjjbp5uEidu7Y85IaMK6yec0tAMqsaK6rUW6xmZ+G8aScs6N2eOC/m+0lHpfD+RnYPNo8wEUlsd1b8QFY9zgvoPS7DR4bewPCvO1Btgx14XuC5JDjzjsbgD02gYMjtY56lq5mG/hqXtA9S2HOXc2W9qyhRBkTPsDQAILD9gSysL6n1TWTvdBkYd/zI6Lk5zUVtlOSouZ1HnfXOrZ7wj42w4O5vAxZMjcR9d5z4bEx7B81z03u02hUAv7V4aW7mwnsushMlCOOFJ8BsemtGn3HZ0+gvB4p8IAXFI1xjbAaSwYq4iGrPDnH1u3aek3he9meBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCabl5OXsvXGxdp3snxfOqxTNcEu2FkhNPhp1zWWWAA=;
 b=PrWLU/J+VCuxDBED3sB7TNvZ4GsgKgLBJDiPePncc7wDUxblfUwzMisOd1VOtB8jO9jKKPRgORt1mtF8c1mw6GZEsqc/OAlmZRQS6Gd41xZHlpWNqn93MGnEg6wsDLWflQe/utGRMXR+7ZFOjcUgcZriJ/pxo6qnA9KlNsx5aWQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 12:07:31 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 12:07:30 +0000
Message-ID: <9b5088ad-da0c-4d25-bf9e-1c7ff657bf8e@amd.com>
Date: Thu, 1 Oct 2026 17:37:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] iommu/x86: Add architectural MSI reserved region
 helper
To: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
 mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca,
 mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
 tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
 suravee.suthikulpanit@amd.com
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
 <20260930141409.437904-4-zhangyu1@linux.microsoft.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930141409.437904-4-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::21) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: df130ed2-4fd3-4fb9-725e-08df1fb4919e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|18002099003|22082099003|3023799007|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	omIRS6FPl0OSsqHBseAb14t1bmBx10J+U6b4V56Cc4lm+AgtmJ0oiYYQ1gO5lBwu7P46BB5k9oFO5D8GtQ/5gcPFjMVTcDNMZIa89FFvvVUjcVdMo3+KyTSGy3xRdK22/z/MmlhoXZq8SPBfM3BqDivIrsNJDgCsaTRHlm+7TdkU/5rKmLmkvwx7gpJh8ISG2SOyEHBqZt/B3Qs9LehjT7H0hvwfmTVDrucU+ve8oMhwyOcZ68cylT2MfcI4PzmSReb36FKtW3obo9hTfWpFJGpkjYZJDuVy5DGZ71gORmMtj02vKWMJLmnfnzCsucOMVGe1N/fKENnnADBMk+cogFKqELOudAzurBM4RT2Fj+6/wQ12oSZAAmbk+lUJ/bhqVTx8ZjxxixRYTLJhb9o5dPPAMeugVPNmc0cVv8aFmEY/8Pd1PPxBhos7DEfjJ7N38AgNwDMXP1i1mkirwB5DUUU/j7aiUbl2EA4yAmJqOTuK/mvR5MfkSKJJnM3qZxWf2/0Jlbikay0VFVGmy/c+X/T10TmNPEGeXolNLLZRByfYUsKHpPVimOkFU1so7Jfu77k9E/eJKFuFa7dAjPvlpW7L9WtZqcFKIur279f5mogamcBIzB0MsdkOa/mzGKvuyeNNjGW5TSDeEvHQckHNnIGNyTakCkke0zTEX9BD9sk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3dSU2JROHVWT1dNVXRsbFJiUC8vRjU0VTN0N2w1Z0hCV2syVTUva25wMkVs?=
 =?utf-8?B?VURqVWZrY09QSUpqSXBaV3AzcmhUcVkxa0FQb3l3b3M5ZkJnS3l0dEx1TGVz?=
 =?utf-8?B?MFNERG91SHBpSTNxdzJIdlZtbkdUWWZQUGVXSk5TeWt1L3B0ZnJEUlJMQmxJ?=
 =?utf-8?B?blVhMFZRWVEyTzVUUEVXK2cvaVdTN1Qvd251SUltT1MzNTVIaUMvUGpMcmhN?=
 =?utf-8?B?SnVtclNXamlKaXcrRHNPTE0yQlBGdHZCZ1BhRFlnNVZtWkp0cjkwejA2WFB0?=
 =?utf-8?B?UDI2OFYzbkdGOHN6ZzNYMWdmVmRoRlBtUG4zNy92Ry80ay9ISmRpS1Bnc20x?=
 =?utf-8?B?Wlh4dTNBSkxBQks0Z3E1Mk9MK1kxc0VFWVBSWWV3bEZiMkkwdDFSbGlLczJ5?=
 =?utf-8?B?ZEdmZUNEWXF4LzdRdndxQXR3WU9lNlljYnpUOUtLTUhsbFlvV1g2TnY5Vlhq?=
 =?utf-8?B?ano4Y0g0WFpmLzlGQVl0c2RnUUtsc2xYTmtmOWpScWptREhUNzhibDI2a3F6?=
 =?utf-8?B?M25GNlgvbW4vN0xwT0lzWUJEaGQ3dk9HditYdjVKSVFCaE13UmUyOVhPMGh4?=
 =?utf-8?B?Ry9wS0NDTG1iZEczaXNmSytGUE5oWTkwVlY2aXVaZSt0QkE2Y2Jkc21pK1pt?=
 =?utf-8?B?SU5heWxXbWtlaWVrYmhvZGVjRTh0MXBUbGhPL0pDWituOW9mdzNnMFVQQ0h3?=
 =?utf-8?B?Ui9rQkpBdmRxR2pHa0R6eXB6blRtcEZ3S1RnRHFHVlIvV0xhZ29RYUFsNllr?=
 =?utf-8?B?SWFEZ0h1VGFXN2JZUXhZVXFlT2dCVVdBZ09VQUlxWGtyM0xEaGN0SEdpUDAx?=
 =?utf-8?B?Zjd4TldFeE1VMXNpYlVlREtQUmpza25zdjNIZWw5SXh4eUFZQkNvRkdRYUQx?=
 =?utf-8?B?bTFWeWJZb3JmdlVCVVkrQjNGV0tRWjY0SWFkUkdvdmhqN0wvb1VKSmZqZnRS?=
 =?utf-8?B?ckx0SWdHNGc1U3BVOHhubDAvVlkzd0pqTFRjMGZYTjRyTEtJN2ozYTAvMlN0?=
 =?utf-8?B?YTVxYUZkY0VJb09NcDU4SHA2V2I3MU82d21zbUZvTGxoZC9RWlo2bjM3QTlo?=
 =?utf-8?B?cjU0cG5NQUZMVFQvaVRUS1d0d2ZGczU4VXY1VC9ENHBFbWEzbVR1a3JJWjRU?=
 =?utf-8?B?S3J2S2dFV0tyMzhyMlZvVGd4Z0FaTUVjc2dpTEdqRE5UVmpHSjE4OU1HSFFh?=
 =?utf-8?B?cldzcGpickpuWno4cGt3aEFJeDlDbVFWNGhLV2tuS3kwQ2ZzYjQzQzhwUkR3?=
 =?utf-8?B?bXpSZHpBNmI4STBxSUhSTEY3ekpiSWRHUjNXMi92MkFpUDlncUprMnpLbVlu?=
 =?utf-8?B?YVF4eXRlV3Y3cmU2YzhId0ZrdWF2N0VTd0c1R1FYN0RnM0xCY0dDTHZReW9o?=
 =?utf-8?B?RXA2bXZHWDl5cVlQaWNNNnhCbkZYVUhNZGg0SUVkUXBxQ0dqMGU4aS9aSGJj?=
 =?utf-8?B?Tmk1bUFCMk13T1pXL00wczk3dlpaRFBxK016Z3BaZjdZdlpNUmRBSit6NGtI?=
 =?utf-8?B?R09MeDA5UVN1Y0dTdmVRTlhjNGxKWmt3ZVJGb0xLK2pDWXFPanpkTWJEQW01?=
 =?utf-8?B?MDBpcGp4RDRBNk9Ka3VlZ3Rtd0xwVEFpTnczUnlUa1JGZmxia3RyWmRUOGxY?=
 =?utf-8?B?SGp4OU9JZWFqdWZ3REdzSGpMTmJoSEk0aUJYSkRtNm45SHZzWGpCK3JrbkNy?=
 =?utf-8?B?UWJiSzVRNmwxaVIwTjVmT2J5eTVZWmpsMWtwRlFlamo1OTBFeXM2T3MvK0lO?=
 =?utf-8?B?aklLV3pORTdUNG85ZU1jdm1sQ2xBUndIVDh4b0pGOGVUdnNKTWx5VmxESHVS?=
 =?utf-8?B?T3ZzN1RJYUt2TnRyYytFYWJackV0OTQ3OENCVExveDN1NVJ6QkFBZ2RwYjJV?=
 =?utf-8?B?cVV0WjBqL0tORzcvdk1YbEFQSTM4bUN4b1Z4VUZwL1F1eFRxbElTRmZ6STN1?=
 =?utf-8?B?VXlrKzN6QlFXVEtjL1ZqZDViODY0SU9vbTZOMHBWcnhaTEN1c3VRaWlvcVVh?=
 =?utf-8?B?RmdzZmNncnpoRFpBMWVKZnRlckVNMUhyTEpIOHNQaTJValA1VCtCeEZnOWRV?=
 =?utf-8?B?LzRIRlU1UzBValZwdysvYWQxdVcyVWM3VFZaRWR4RWJXSFhqbElodmRjZ0tJ?=
 =?utf-8?B?QjBNTjZpVURIUVBNMUZyZHVTZm1HTFU5RFh2dm1rd0JLVFl1azNiTitFdGhl?=
 =?utf-8?B?MnFYUWpPY2kvK05KVWZkSjBqbHNEZ3l3WHMwRE11d3c3K1lJYlBjb21NMmdR?=
 =?utf-8?B?dDNVemFLRC9uY25IM21ZZzRUUlp6NzEwblJQZjFieTFiUk9LTGxURDk0NURP?=
 =?utf-8?B?Zkh1RWhaUG1VbnpBRktJRTkzSXUzdUJnUFJjbU9SNmRBa3BWckY2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df130ed2-4fd3-4fb9-725e-08df1fb4919e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:07:30.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFi+HaCdlA/dQNYW+V4+OJe5VPoQlRwb5G0O8rNfhgcYuJcm/6DI1qOuszacVc9wlWATyLLUmnlmJLu/LaRCKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940



On 9/30/2026 7:44 PM, Yu Zhang wrote:
> Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
> address window from normal IOVA mappings, but each open-codes the range,
> allocation attributes, and insertion into the reserved-region list.
> 
> Add iommu_add_resv_x86_msi_region() to encapsulate those operations, and
> convert the Intel and AMD drivers to use it. Return an error on allocation
> failure so callers can preserve their existing error paths.
> 
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

