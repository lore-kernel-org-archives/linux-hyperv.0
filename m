Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3693DA7FB;
	Tue, 29 Sep 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712297; cv=fail; b=mHMQSY6+eoYw7fA0rxJCt3DeTYF8VszalaRa/pv15HWypsE5VjGYfWd9UtsKoHEArihGjilk8cgDXMJ98U+z/MhHEBv5ktc4Uhttyj7SVORtwZ05jMA7whqCsMx8HDHT36Te/Pl60yHUHHlj2ob5+/lkXLhHV5874iqpOcwrUFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712297; c=relaxed/simple;
	bh=lQST3oR5LeOGjZenXr24i39h958ZJGQa4DYTQTCGbO0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=nXsfXX3lxYlaoFbM2zzXathhG7BZi04YsaY7Ux1/oFJLdkSsfZinGQ8Lu4K0ruVakGe4BfLYKuyhuMIyRw+XdvEU1d1EtKkjidMLSC2DYz4qbFxVe3V1czx5g3CVSOBqNSsgbAvoVC9cuXxhCR3t5K+lG7TJrzrj+DHUVTR0ZM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjNY0xu+; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjNY0xu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/WLu4biqkSN9Q66ylIzjnoy9GT0nSKMJkpZLhLqn/CDTNl/sAZiaqbdYBNpdaiirXSS6uYXSR7HlDWpltTszf9vLvNCW+PqP0L00fK8h+OJgfy23D0YH9Xf2CYeE9FZZaYhu4j+kRO6RcgzcGuEduR6GQehN5MxcnvB7j+rU90X0B3fgKYTxBbZ+HdtdvJPcAe9qlqL7+KTDzAqUvKeVGy/YcSdXW+lLyprrU+fk1lbUpmnGYzbIqWtNdPX1sE4bEavAY3AvXw3WpDdpot1sIhzJge57K7NJKam3/s7h5UOcYEIJyHSNmN0Qvl6MHV2g7VHm9S52G+zkAUbsqAGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yyiL1F3gHeXi/H6HH0D+vTDgxSZAn4xgZ984I5aWdA=;
 b=L+Aa9jG7AO/vfEN8m+TmVpyoX829szt3uTiLUUjca+3nCBpp8wTLjB1yAw6xMIkIE2RUX8HoFP+pogruYhN2u6S2ms7ap8WLt3GmfDpchx34IleDiqZMNiqtCPAwaYthB3DQqYyDDZVEerCxtfTYm55jzx3HaBNg5zJtX/bO9b2Q2H0eIf0ouml+3I7H/INoTwhamZyDCrkRNdZWQTXH9ZOcWRRXbzjOF88/DJrWYc1tDW2idzuRzYaBP/K/vLbCqdyvBKaY+RZYkR5ZCoZFM/VuSBcbFAYWL+PBpja9A0o/Ew5ST11lCbhB+DPx1XA7Eliy4c2dUbBJw00cxsUtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yyiL1F3gHeXi/H6HH0D+vTDgxSZAn4xgZ984I5aWdA=;
 b=bjNY0xu+wCSez3DCs8hPUeNcmeuPXazqH8H8h+toQ9ju1W9Cp3jrh3iVnNPJRTEfmQP+MUgjE4+ki5V1eRe4ZrUQB3udSR6zfP9pt2pf1MeSnGbRn+0ZRcnWCPY57odQQtWSzx2qerxOGm80MqIk5QxfTdsy9ZQQnUCY/J4KKN4Um5tXPHXgCnru9qCGWzVAO1CvI5Taf+EBUdIQpdXDc+HxzNVY/zFQJ6RHS2TTp6RnMwo9WT7dWK/fL//qZEaGoJ5oEN3PI3HP/RZWbHJWi//HYap/PeRPSSbeFlkwZAcgK1A2m1phRwkeRGheav1yOreLRgWyS7EHS7abcTnd3Q==
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
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU
 support for Hyper-V guest
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
In-Reply-To: <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
Date: Tue, 29 Sep 2026 17:04:47 -0300
Message-Id: <179071228738.122959.14326374887826159868.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: PH0PR07CA0109.namprd07.prod.outlook.com
 (2603:10b6:510:4::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d27f632-f423-4b66-11a2-08df1e64eb80
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|10067099003|6133799003|22082099003|11063799006|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qfnSFfb0bnvFnp0sKuNR816tyBgdWTavP6viWMJOPDLKcsHtkSGAAz6g2cNJBmDM6Xsz+SYf2ByD5jUn5Y+MA6Ez3cLUTL7oqu13yaLg4jGmUF9LsQgw8F4yjSXVJeokUZJ0XVFXU+oLhF7jZlV4txhLEWH2GDJWwhNmCXI5M4mdvhsT5Ui/76P94L13p38913BpsB6H9zLfHqCp2cXjOeXP6MTa9YZ51f0gFPHwzkCUl92+ZTcbTDZ7qMSKT8BMmn9XMqCCKBnFsuceaZ43djHApJeEhK+NNycc6Q6tsB8mHhyfud8S4k/QmDcs+/6GeheyrCtuI1nwMwBweVLKyTpvyDrHrN1e1cgjOtzGr5bLv0p/80tEuhXDN0G35PBP9O2DdyyeuAXUSnc1IO/EqWwyNYLhf7MEErC8tg5ZRNgwxWmG3gKtXaYRjn6+Awwl9z8AyjPX/TDCwlqEH8eirZEZgEhaTemTOP9gfSTRX3/ss//bCSzy6vIQ7NGvSt6Imql0Anb+FHzyQDnA5DmU2dWtJzfOT8Ipe+YLjLoGaIQftcZFUPnrr9+vfAcuv0rgk8Pta45b2XbgpzzqWhI2DcIYlc3BaJGv1NlzBFTD9W8TEDZ3W22SPFbLA1SjYBGomBy+eSWLYqyAxySoioSoCUVXYKbwYSg4DAWlt8gqkVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10067099003)(6133799003)(22082099003)(11063799006)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmlPMDFieEdPb0tvZ2dvdk52UzJ6MlBPcWMvK2UrUlptSUhva3Y3OWJQdkdT?=
 =?utf-8?B?dTAyN0xPU2NTZ0ZVODhNY0FyS2dscFNmbDJYVkNGbmFlNEhiQ1dhNURrUVZV?=
 =?utf-8?B?UTA1RXc4Rmo0dVNnV0hSTEVPRDhBMG9xd0J0aExzdG1JSnVkOUtROUpkd2s4?=
 =?utf-8?B?U0IrVmlZL2ovSS9YYlhRcFBWQks2ZnZraGwvaHRLZFR1VGZONTVIUnBJSWpu?=
 =?utf-8?B?ekRrV0trUzQwaHIydGtScEs0MHVkMXErUzZ6Unl1ZjAzbDlYcnF4eUNWUlF2?=
 =?utf-8?B?M1ZSMGtXZGFyaGpDb3NIc2FYaHNPWXoyWUJQSFpQOGt3Wm1ITVhUbGlYSHpO?=
 =?utf-8?B?cmgvYVlZREpaUzhzWW15YUZkNWRzVVFvZkdGQStWMXhLaDZJZmlyR3pNeCtr?=
 =?utf-8?B?MDJPWWxjRE9nOHBOS0w3bEhkbkpXQ21yM2xQTEMzV2w5SHc5Vy9nM0l2Y0VQ?=
 =?utf-8?B?WVZtWHlYSjZPQ1pHT1RLZlFocTlFYjNlOFhzQklFZzEyQXBDWXhROEZEeU03?=
 =?utf-8?B?YWlqaHpCQnkzZisyb2U3SXRIdVRvbGtFN1pSVUxGOWNjNVJTVTg3V255L1hl?=
 =?utf-8?B?Rk1SMndoVGJpVzcrRmh3bGJMTlcvNXNmMnBWN3JUcDZGdWE1eldETGpLdVd6?=
 =?utf-8?B?ajJBenlJQ2kxY0J5WjB2cW5abTQwWnhxK2JUVVVrOFRKaVBHWUNmU2NVdjdl?=
 =?utf-8?B?Ymg1bVhOQ0hXd1hNbk41RVVSL0ZNTEk4amgzQ0lvN0J0Qngyc2thNENlRmM1?=
 =?utf-8?B?OUhxNFUxY0JxRFZ2YW84a3FzWWZoNWV5TnRIWnNxcy9HT0o4TXRvSDkvT1ps?=
 =?utf-8?B?cWxHWVBEdmlXOElEK3NSUW5BODVHS0FPMzZ1Y0c1VUVLSFNHRFNOcEdOUWha?=
 =?utf-8?B?V1BjSWk2bEx2dC9ZcmFxZ1dUZjdGUDFoWG00czFJUjZBUGJhUGI1UTgvS3Bq?=
 =?utf-8?B?c29Td2VYRVVjZzU2QUwrQzFqdzIxUzRXLzNlanlzUVFXTFk5WW01Ri9OZTQw?=
 =?utf-8?B?VGs2ZWM5dU5kSnE2STJKK05VdGxOdXRiTnMwRGJTL01teWZUemlrVG1zQWhh?=
 =?utf-8?B?YmY4Yk5XRmkyRmwzdmY2d0hZUjJnamJUYnFueEcrdWtmR2RUVVVacWtaZDh0?=
 =?utf-8?B?c3lzTnB5Y0UyYlZteGtSZU0zbzFmVjduVFRSakJ2alh4MFdmdTFTeDllZWF2?=
 =?utf-8?B?OUw1djN4cC9NSGJ4UlNTdGxBUiszdEljSmNHb1FGM3hYbEh2U01uZHdxVEk3?=
 =?utf-8?B?Zm53emZPMVlhdUJUNkxpR2J3K08rc3Avb1lOeGdSRUlGY2lJR2JxbkI2K0Mz?=
 =?utf-8?B?NXVockwrdW8vRUsrZG9OdnVvWDhHZDFEUVV1Z1hod1hBdDcrc3d3L3Q5NHF6?=
 =?utf-8?B?REcxWGErdmpoRHl1a3FLTVNzMzl3WG82LzRDa1dFNnl4WFhzUkhxZHVyaU1C?=
 =?utf-8?B?L1JFclVxcXFvYmpuMEVwSHZjVXN2ejZuVDB5KzF6Rlh4RjJwbVdwQzVZQk5q?=
 =?utf-8?B?ZkZ1WVRWYXBKZERvYkRTeEJ4dUlTNWdROXFvZVdwVEttRnJOK1M3MExYdXVX?=
 =?utf-8?B?T1NDakRUQ2Z3ejhHOENGTXVPZVRJUEFyY2RQL0N5RWlhNmsyTmFBeUp4YTd6?=
 =?utf-8?B?ZzEySzhxb2ZyWnN6UmR3QitVVUgrcHp3MlF5RUVneXNyYTNhVGR4UW9NYXFn?=
 =?utf-8?B?U0NSWXlYYkliWllZQk1vQjl0R0tyWlByZm9YSTRKSExhYnQrRWxBMlNsKzdT?=
 =?utf-8?B?YVZ0eStHZnRKTXZLd05TOXdReWp1c1ZwbG1MUFhmR1MyNDlyZU16dE5CamRw?=
 =?utf-8?B?QjJLbHdldGNHQTlpRXVDOVlOQjcxaW9uN1BVZVRlcHpaRk0zcFFlUTkraGc4?=
 =?utf-8?B?Wks0WFBCODJKT053SU8yTUVyckpTNkNRdFo3SFdSNEs2dUFXM1l0NEk5aHZk?=
 =?utf-8?B?ekRPRkc5cDRwWmlmTWN3US8raXA5V2xvajgxbitiN1hJd1hGRTFkenl0VXU3?=
 =?utf-8?B?dkdNaWpuaThsTkM1Zkp1ZUNxNTJDRGdjbjJmT21WcmpxdG9yejMvb3RqbFZa?=
 =?utf-8?B?TUJzZTYyYStwMzY3bkoyQ3hPZ21yRUlJRDNXM0xGU0dCWFJxbWhUb0VPQ1A1?=
 =?utf-8?B?T21jMXVCVnBzdk1mcFBwRHlPOG56RDR2V2NrZzFVdzlpNzl6czN3ZlVtNjVr?=
 =?utf-8?B?MHpXWWx4ZDZXZGRERUJ2eXpRTkc3cXNwYWRjd3dPK3FsRnF5a2FiTzJVaEdB?=
 =?utf-8?B?MWN5MjN6Rm8vSnlyM2cvTkdlUTk4dm54SXR5aHk2a0p5bEFUeUk3NkdBalo3?=
 =?utf-8?Q?FDIXwYGHC5nW7IdJ4U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d27f632-f423-4b66-11a2-08df1e64eb80
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 20:04:50.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY1Vf4xZA/B6N9cahuIDlS75IkKjplLMUt9AYBNSiyR0SGjsCEQs+uy7Ks8S64Br
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499

> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> This driver implements stage-1 IO translation within the guest OS.
> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
> 
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
> 
> Hyper-V consumes this stage-1 IO page table when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore eliminating the VM exits for guest IOMMU mapping
> operations. For unmapping operations, VM exits to perform the IOTLB
> flush are still unavoidable.
> 
> Guest hibernation and resume are not supported by this initial
> implementation. The guest-owned stage-1 page tables reside in guest
> memory and are preserved in the hibernation image. However, the image
> does not by itself preserve the Hyper-V device-domain objects or their
> device attachments, and the current pvIOMMU interface does not define
> whether or how Hyper-V restores that state.
> 
> To identify a device in its hypercall interface, the driver looks up the
> logical device ID prefix registered for the device's PCI domain (see the
> logical device ID registry in hv_common.c) and combines it with the PCI
> function number of the endpoint device.
> 
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/hyperv/hv_init.c             |   4 +
>  arch/x86/include/asm/mshyperv.h       |   4 +
>  drivers/iommu/Kconfig                 |   1 +
>  drivers/iommu/hyperv/Kconfig          |  16 +
>  drivers/iommu/hyperv/Makefile         |   1 +
>  drivers/iommu/hyperv/hv-iommu-guest.c | 607 ++++++++++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h          |  44 ++
>  7 files changed, 677 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/Kconfig
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0b4a1c0b0b16fb..d5edc853096436 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -579,6 +579,10 @@ void __init hyperv_init(void)
>  	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
>  	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
>  
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +	x86_init.iommu.iommu_init = hv_iommu_init;
> +#endif
> +
>  	hv_apic_init();
>  
>  	x86_init.pci.arch_init = hv_pci_init;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index f64393e853ee31..20d947c2c758b0 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -313,6 +313,10 @@ static inline void mshv_vtl_return_hypercall(void) {}
>  static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>  #endif
>  
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int __init hv_iommu_init(void);
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>  
>  #endif
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6e07bd69467a3d..0d128f377929f4 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -195,6 +195,7 @@ config MSM_IOMMU
>  source "drivers/iommu/amd/Kconfig"
>  source "drivers/iommu/arm/Kconfig"
>  source "drivers/iommu/intel/Kconfig"
> +source "drivers/iommu/hyperv/Kconfig"
>  source "drivers/iommu/iommufd/Kconfig"
>  source "drivers/iommu/riscv/Kconfig"
>  
> diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> new file mode 100644
> index 00000000000000..dd8900700b85ad
> --- /dev/null
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Hyper-V para-virtualized IOMMU driver for Linux guests
> +config HYPERV_PVIOMMU
> +	bool "Microsoft Hyper-V para-virtualized IOMMU driver for Linux guests"
> +	depends on X86_64 && HYPERV
> +	select IOMMU_API
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_X86_64
> +	select IOMMU_IOVA

Should this be IOMMU_DMA ?

> [ ... 389 lines skipped ... ]
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region = iommu_alloc_resv_x86_msi_region();
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}

Maybe the helper should have added to the list too?

It broadly seems OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
