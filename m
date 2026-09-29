Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331C3F44D3;
	Tue, 29 Sep 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712301; cv=fail; b=CFv1jbTJNYvj7rR8b5l9Cq3Wec6/C3pHDT/5pWy0lGFI2LlvIzD4y1dcO6VKSh5rTH+pg5E+xDu+wdhV6fbal+lXrLFwlmtLAIHUYuhW0hTMqRKz9xvIy62EuUz5rXdxwBgMdyxGWjF9jTC0qMOp6vf1ONDLatCgO9iA1OG3P5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712301; c=relaxed/simple;
	bh=zxQE8GHs4puCQJpdLMczSWwcXXH7LVBQ+rejpIU0oas=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=gafDSVlBU0iy+FGRQMmfwN8WasMpDi/7xMu0Pga4PaWT4U8Rw6Gzebw8RZLj/L+MpvjTRYdQkGKINnvKjB+sJGH/CCH3Q6GP3CrXOBn0ZLIZGdpaTOcT3dadM3e8QBseXALgR6kJVoJzqPxHmgtZ7cg/S8VdRRcJmUiVZ29B2lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UUr1RQYb; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UUr1RQYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwbZ5OECp9n9/fRlvxOskx9sPhKOfe1xQpJ+UyrxvZzqF5zqdiis0p7lvDArxxMpizC8eIU6hU7e9YlGi7LIGTk5Vq0OcI58hYRSNI1rzwERMEuO/T3h1UjCgMjv5a2AG6z85V5FAvUVX/jfkr1eYt/CcSagCMisQifhRI4GkXgupnGsL0P8WsDXpnb+3hCDKPuKtyomIWMR3zNllOfVsqUOs1cnyuOYRf4BjTOL2IDQ6LsssbGS/0VY39QusVh5fXax/jzSc1eFI6T78Yj0VaVtJ/ksiOBxRsdxODBttSGQsg79Jw+dTPv23wXCByMYH5AFSbir1WI1CKgpZI7xEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emAaNclPvx2KxZpPGRXX1upeSmeP+9oOyK3ySyPQmHk=;
 b=mbnQtyLJsThVh+2QoGqqnpmnbuW5s+EnhE/LxSnVldW4hO6FzRPJpUjCPtxstpIi4JRzK+HqOIM78FA1sIZRj8pY0ox+O6Bb8VjmsOloxSOsCG4yPbcrswKyAZlAqXPnOz5fnlL8Kn+MmWlVrcSarbavJdKA4I2uCiNFVy3AC0HUjEmwSFCCSQhTIQjvwK5O0fBjTnbE0Loq2X/FmvcVxNtWQ4MUvnbtnB6CNgQFr+sHdyHg0uzCfhSvQCaQW3lyTugfXYN7/LD33QmedXU6IE9Z6aFFvl0h2Tcksnatkh7VEbgz1crD4LOKHvC3ZNb/zZoCf3WThs4SQpWCv5ji4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emAaNclPvx2KxZpPGRXX1upeSmeP+9oOyK3ySyPQmHk=;
 b=UUr1RQYbXZ5dbfTU/xdZPzoaP83nCHEpZCQV5PwYXLuR4XrOzJ6efWSXlJjb5HR2u+QNF1NMIYgmnik4JJxrgsEEcEYmfXT4DBP445XLFesA7x3BEbCs+m6oa5AK+UAw135TxgiS9EotKpv73Y/dTm+kdDkcVyuKKMfl3eFhD65YRu3wBSuHk/5fRz8A6XMiIWO7ddG6t7H3yEltixRksGA1qQ0p4fUB6qacPiR5nNKAEn/wHsitKGg4OJ4MvRP5T9C9+BC3u8FkOaGGoAgdccWmOrlwENGKYRj43YM46KjJfHIU/l7aXyEoOfub9vk37r5k4QO01kzkg2eqMYzY6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB9499.namprd12.prod.outlook.com
 (2603:10b6:208:595::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 20:04:51 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 20:04:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
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
In-Reply-To: <20260904075512.174154-6-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-6-zhangyu1@linux.microsoft.com>
Date: Tue, 29 Sep 2026 17:04:47 -0300
Message-Id: <179071228739.122959.6853057469350749233.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: PH2PEPF0000384B.namprd17.prod.outlook.com
 (2603:10b6:518:1::68) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cc427f-539c-4527-8d5c-08df1e64eb9d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|10067099003|22082099003|11063799006|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NlYqbr31VE/sWMHrBWC5X3BT81dA4wQElD4WAJPEJ5dXg29uipG9pJ5XE8XGY7EhstyDHj7iOTBVd6ydwwRCEbCgPxoroQbklwMwKIdUHI2EXKBwuYm44NQYe9SVwYOj5LavHlnQ8E16nMiFHSu425M67j8E9H+SbO/uu+ED65rPPyDiNQp1NJt6p7II6Wo3HmYCtRPmjtnR2fcOOJzrlVupg5BLcRuZVYgW8XnKZG4WkGNpyZ1V2LKIkjTYJMlrOLs814nWZdW80InUELBaLaexLjiP7wHo+pwOQmud9MnSgtHuLjA1NSMwCfF1enUiEsft9aNT2JiCqKZYaBpjOzQNeUH5k+tjExY5fAZYlJ3WwOGL5oKKMxKR5GAI9piZx/8SIwAueRVQvHDN+CCzXb4yyu0MeSq/6/1LJ3b1sZXxkWaCdW/OCZCcii3na7IIk0wXoXlpAKxVh30w7BO25dFDqHmQSL9a5BWyzaS1G6fghvqTrtesNNvrUvO60WJOcCxLfrHtecrEv76rCWqcjmdPm+trRcWJnVl+6yp6v7FNzylzocYD/miG3tTZze3ljWZ0UV2RHav3IYO704SbvxetZ7v56ryeoOIwLkPE6j9X4T/zkuFp9A23S8Lix+V3lCZEp1yuHiQ47YBDNnma3kGlYbBhcntOby+wj6TB5Dg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10067099003)(22082099003)(11063799006)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFvRW0rVXlrUEpld0QvRFgrREI5SlVEVmdZTXJXQlRINUFISldka0NBZzZ3?=
 =?utf-8?B?dlFOREZ3VXVWZDZWQjV2U3duYzNFeFVBWlRuSlp5RjdqT2lyWnBGNVZCcFIv?=
 =?utf-8?B?ZHRKRDZVbys2WFY3ZVYzOW80Tmo3R2h6b1JQb3NNem5pYlplQXBMRDhjSWZN?=
 =?utf-8?B?MmhQUDZmRFFocmRtRDduVlY0TnJ5aGp1TDBRRFRPQjIzdDhlZS9OV2tnWElI?=
 =?utf-8?B?cStEb0xQdnpXbHRHSERBNENoT0FxWlFhTUQxTWhSbXFtTDVWQ1Jkei9qZm1o?=
 =?utf-8?B?R2hyUlRQVzZHNDhNaHlrKzl3OWUxZVlockoybEQyTDZDanNXS1A1TThWMXBn?=
 =?utf-8?B?R291azBrVktBS3hLVTh6YmNrdWh4bU9YTXduK0JyUzFibTVnUDRMR1dnL1Bo?=
 =?utf-8?B?RzZoOGR1SzI2SkE0Yzh1VTBLTDNmc1UvdDFHUWtNbDUzT29PYXdhM3FxVXdo?=
 =?utf-8?B?K2ZNWHhlUlBsK0paL2lkTjUzRWo2VmNJQSthL25qTU4wU01peDV4TXJjbnAw?=
 =?utf-8?B?WWp3WjRsUXYxWHE1ZzBwV0NyTlc3T1pUMklZOW54VEZ4eW5nblJxUHpuVUV0?=
 =?utf-8?B?aGZBK3pnVkNmK1p6TG56MHJUT0dsYmpWNWVhekRlMTVZdmtSQTRublRkN2J0?=
 =?utf-8?B?eFRKR20raDZyMVQrcFB6NUtyaE9wSVBkNnBoWW5ncnNQTmQ3R09pYU9VVzNS?=
 =?utf-8?B?MW0yNGNKUkcxMnlZZW9XRjJKSFpTaEUzM2JlM2ZiTVRLS2tIMS9MeHRNUTg1?=
 =?utf-8?B?Y2YvMDRqTGg3Z0dXT1dncENMZU1QS3pXWUdGUGtGM3BKRm92NTg3aFJBdEhq?=
 =?utf-8?B?NklOVTd5VWsvVTdCUTJtQXZHRXhiRTNCNkRIWm5idW13ZE5YdDV6NnFpQkdm?=
 =?utf-8?B?cWcxMEhtZ2c2eDNzTTFCbFFDcDF2QjcvVWEzZWZOMlJWZmRlNk5CbTdUSjlO?=
 =?utf-8?B?NnVpY1pOQ3B0MEwzbG0vY2E3ZFdjYWlvZEtMVGpvZjZoV3V2TWVhbEtGakND?=
 =?utf-8?B?eHM5QXhFTlpxazhPNzgvYUFvYmJRYWJjUEVVeWJ2cEpkM2ErSmpxRk52aVJ3?=
 =?utf-8?B?L3J5U3RoZ2R0bG0vKzMvbWcxTUtSa3dkZ01aeThjUWUxNGFzT0NOSkk5VUtX?=
 =?utf-8?B?M3ZnV2YwVWFBaTR1QitxM25ZU2lvQ1htRUY1aXRyK3hOd0lYVVRMQ2p2NVkw?=
 =?utf-8?B?Tk5ZMGxVRmJ3WFFRVUpZTy95ai9vcXc0dFBKZmRQMWhGOXhnTEdJQlNSeXI3?=
 =?utf-8?B?endCUll4MWphWGkwY2YrWityRjk5a04yTWVLUDRBY2xwMnJ5bVMzTWtTTlha?=
 =?utf-8?B?TU9KRGNOY3NMV2ZCUVhCcFJodHZKTTI3YXQxN3BBNW9XTFIyRTNtemJhQ0R2?=
 =?utf-8?B?bmVkOG9uWmFpSU44UDI5QXhHSEJMMDZEWGFWSGtBM3NDT3lhdzFNZmkrRkIw?=
 =?utf-8?B?T08xRTZqVlo2ajV1UEJyT0ExRStuM1ZOYUtOWW80ZzRqc1BqWU8zbS9ldGJN?=
 =?utf-8?B?SnhCQkpzcmVGUkZnWDNsK1d1U2tZbVI3Q21BZWx2d1Y1b25mZnE2Y3dUamI0?=
 =?utf-8?B?N3UxVjNmYVpKbWllWFJtbkJnemU2Z2dPVHZkTUNCcDU2WDU1VmNaMENudXRs?=
 =?utf-8?B?VUlBd2h1QVBVeit1UzZYTnZCbDdPaElab0QyMEFDVHZEOVpYMjZIcUFuWWpy?=
 =?utf-8?B?QU52RkJ2bDNwcmpacEF3eXJyY2VvTlBpckZmQ05yM0NPL0cwT0NlSUh5MnJ6?=
 =?utf-8?B?amx3aGhtUU9sa2xsWjhVMHdQeURFdURqeUNnUUNBb1lTZGlLc0lKKzUzS3Fn?=
 =?utf-8?B?eGI5bER4Mlh5aE8rOTl6THhudTlzOEQ4WHQ1TFFJQkNHaCtjdTQ2eUJDbDdj?=
 =?utf-8?B?L002aDllLzNPZXZ4WFJVcDJCQVBIZUUrdUVuaVZuRmMrc2NvVmRmNGVoci9a?=
 =?utf-8?B?NXpNQTRzSzVrOU15bTVwYkdNZGZ2SFc5dGFpQTNuS1ZlOWpXcDE3SE15RFpn?=
 =?utf-8?B?RUhZWVA3Vnc0UnhXZUpndE9EdGN6am52TmFYeHlIczhTdkhvTHpjZTJRbEoy?=
 =?utf-8?B?bTRWNC9rbGcrcjFLRUJnYTU3ckFzYjJrbjNlb3pNUFo4bFI3d2FGUmpnTGMw?=
 =?utf-8?B?bWg5R1pIUDNub3Q2N09odjdXelE5MUdzUGtPQ3JaaGlUbFRkYjA5dUR2NzZk?=
 =?utf-8?B?VFU1MmphREJ5VDM4R1JLWkpnMHdEYU1adTNEbWRMcjU2RExxUFowd0RkelBa?=
 =?utf-8?B?YkI5OWd3VC84bk1aLzhsRDJhL1BnYkhnSGtHN0F3RXBRRVorb2piWUg5cWlN?=
 =?utf-8?Q?6CB8TlMOoRcAdjkVso?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cc427f-539c-4527-8d5c-08df1e64eb9d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 20:04:50.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiU5ljmXyg3SuWIIQXfk25qsTMI0MjVZeuBFwqnL+Qx2eUuQMMOYvhp4OGIzFdtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499

On Fri, 04 Sep 2026 15:55:12 +0800, Yu Zhang <zhangyu1@linux.microsoft.com> wrote:
> Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> This hypercall accepts a list of (page_number, page_mask_shift) entries,
> enabling finer-grained IOTLB invalidation compared to the domain-wide
> HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
> 
> hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> range that covers the target IOVA region, producing a single flush
> descriptor. This may over-flush when the range is not naturally aligned,
> matching the approach used by Intel VT-d PSI. If the page-selective
> flush fails, the code falls back to a full domain flush.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
