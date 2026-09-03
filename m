Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFD4FB9DF;
	Thu,  3 Sep 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457225; cv=fail; b=JKFjj0bwpT/dUV5RwGM+gnfIZnX86VwbgMKIuZHZUmF6k2ImxBpM5gEPBKN3JtQBZBlkPjKBfDiD+woJhoG1oMkEI/M7PaBPRRbm0QD9txzuXAg1Cn9yLSFmOOEBwc+ZG5gBDSSECn35lfEO5MpaCTYOO4U3gIf/oKnzazCdumE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457225; c=relaxed/simple;
	bh=EUODATFoQbpF2nhx9Qs16Gi8fXf931Ag2fYGF7m3S+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OB5M8s5bOngN2iuIjP+rQiwDTUX0OEUWuA6OhcZzwrnnQbgWU7QrPwb3xp6djV6ilyd3+my4xZsoQI6OF8mXmlj0Ale/c7bjjbe1sE1ACqLTmyBoA+H96nZGFD77vJ1Mrpq+A3b1HORPmwUvQ/+6tE6E0d/vFLYRplmaj7IKyOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfnSrGs2; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfnSrGs2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijs08P+hw8qFocRabNBfNQaZRwo+Jdukxduqfmk9b3lsmmUbiF+W9I/VPGyJ5wJW4ZiZVZpo0ClKO4b+pPYuUHCldNoGiPVpIq+y+pkEHt51haxHE3sE9eDav9eJ6qjNE9LkHmS/ExCU/ZWcf/yilrThbvtUfA3koI1VoPY855FZs+k3AGOtqmO+Lf3h5D1NAXHqp9ibx6566jx5+av1yMOOYg2EkLMM4mQWzOkx8TZetV6AJZc5Z1PIRP6bz6ofDtHlL1T3mLSBzQo7mGoz1FmNBrkftpbN6w7rU7OMyEicvkzR7GRfqGCWKSferIpkWI4b3DxdQGXMkQwSDSiviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJyF1Gn1VNvz53AVdFgxQ41aO5mcBIKzd8EZ/Kpu/TU=;
 b=C2HQh7ef7akYziX67/IMTtkRmuxuCyv94fK5/0Ku3HWf9ykVBDrIqUFaGFNLsG2yFn3lxBUH6RQ5/YMcdmR0bLGkUV8B+I+l13wP0RyWbKsAN28u14PN6uCB0s/WvHtulCFOVOd35/54P/c9x9Z789hPB2qobtjQ5FkCkBzLNkoesbyPY82sz6vaytN9MSUTJK5GXuGmyn06edoVY7RrLVgL6o82LYv123tR9YG0l3jhWkUHUy/ZucwkHe6qJDVA+IuAlQwC6UqTsY7N3eu+8y6oktaTzn7NEqNvsVes87vGmK+agvEqUtYtVhm2KQYMfjaMUdnco0g+SfjlCDlkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJyF1Gn1VNvz53AVdFgxQ41aO5mcBIKzd8EZ/Kpu/TU=;
 b=AfnSrGs2IH9LFNxirO1pVjUxpqHNRlzwV/DVgQr3S7zLFRl+5Gfxc2teqazJca6/MUU6p3KIndaZeuWDiBig0Qbeiv6YXMs/fo4ZCtrqHG49dCheFsHFAJSJWmZ7N02TVBie+mD/hpQxaIrMzcBg5uw4KxLTNZCxV6l8xK7algrdKbag4S0OkQJCgXcDpL5637g088VEWhqoToKfw8C7ogakP2oanBi3SSPuP1Ont2yi+WSN+Ztsxw2Q/Dg6rjWYpfUjxcb866h/M9QvKflPEfN72LyDCYcf1xC5zre4bMPQPrbE1uy7Y1sGdC9PGzZYu4PFbVKyB/nm8GapOudGMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 17:40:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 17:40:16 +0000
Date: Thu, 3 Sep 2026 14:40:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Mukesh R <mrathor@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>, hpa@zytor.com,
	robin.murphy@arm.com, robh@kernel.org, mhklinux@outlook.com,
	muislam@microsoft.com, namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
	will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, arnd@arndb.de,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for VFIO
 to build upon
Message-ID: <20260903174014.GM4157646@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-4-mrathor@linux.microsoft.com>
 <20260902111905.000079d4@linux.microsoft.com>
 <20260903144236.GK4157646@nvidia.com>
 <20260903161328.GA3102631@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903161328.GA3102631@liuwe-devbox-debian-v2.local>
X-ClientProxiedBy: BL1PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:208:2be::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: cd19a6a1-bd60-4393-095d-08df09e26a72
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sQKU8a4mqAcJjQK/PETkCG5X96VpdS49c2XmNjFd7wEPeRkNcTGzayHjEJQPvTjnDKjfsYfCeXVw/4c9tSv/uCSo/YKoy7IwU5yOKhnRS75F+IVcmdMh+3h+qRW+WxvsAHw1vm6Hvago2S6YBWLDLn59Wg0074Xx5fTVwCytootgCsAWRSGIjpRwHbTSNZdWhXwNO849Dk6GUzrttbx8feuMIV7En6cOCjt2aRh5f9O6i+kUVkoYaPLjVqMAJTOhyif9CWTUdm2sjQrOfpJCenK/1lB955viVWZDvoizCaJPIt53SPqDmWlhZ06BXOCCkMJxB0ugySdy+Z5stxJ67HeM059AZaahXQZdwJMg7KNSsZU6frCZwqCTmAvY/7iFjq34vBlGCnehV+yy4LjQq2xDx2XaCfeVymyscfn1oqvnCuVER3Hvg2ElBv8OB0JrNoQRP2TEkkzkcK22lmG4QiGaWilaXQ4dog1862ppBkwONbUi45fuy+0RD+hVw5ly/WzOK6Vvqv28MuhdaaDUABgFPKvTsoJMs6SeoSBqDXxMiQl/mAlMvnSZsA0R45nFPTsTjZPxRW8MoZpfLVdFh1+F+7W7xDjc4O7AtFKFI4ms/gwBLDEbpT6ordOZ9HJ6oshv6eFWVg29jz4XBqqaBu6caz2HscKvFyYNajgLFWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1aUN9H1N02DPjy/ioD/Nz05G0aPyHRj/NhD8bJM2VKx8cd+arZ5NIC1l3Rj?=
 =?us-ascii?Q?6OFyZh99JwJAooxj7LfQXXcbOotqUjFrt5jB/soWDcsi5J+vFaxjRNYrPjzK?=
 =?us-ascii?Q?xRW1i0sy1l+8TksMgBoZwEwvEGmQc74Vy7YD2scTbjW707axLr4tqrEg959i?=
 =?us-ascii?Q?Vtxte6yChJ9oO1+hYmDWEUf22iDlKFfmiYm5dqh/PtsZvqoQZnC0Sf5+dWDR?=
 =?us-ascii?Q?vwQbax1OHhcyEouwBpuuSjhhL9bYejjaO5P9+dN6Y2EvvOUTMTE3s3AWV0o5?=
 =?us-ascii?Q?FJ/1UQv2kQL+L6i2oWSW6+F+CodZMLt1hIyQzAGpdfsxYAjrs6fPedwQLfQw?=
 =?us-ascii?Q?d5B594q5KJcD5hCv9K95cU/EMhXasGKgtjcZFM8NmU+TuYVa9vpRBda5+Jie?=
 =?us-ascii?Q?66fs4901Tg/LWpNULd/99I9zfmLs/e2Pyr56r7h5QF679vC7NeFOIdqhznPp?=
 =?us-ascii?Q?UynzRelkG+Txoj4b3RG5OuvXSQWrsAREvulAPrhhjSr/WbHWEXnbnAArXunL?=
 =?us-ascii?Q?GYtWf3u+lF9DMShIylNlFShbdclFffSyEM1m0d0pLvx8meQjTdBMHk5l67Yu?=
 =?us-ascii?Q?Bh8pPZ7GCUIYV8DqopOTb43Xu09CIuy1Ggf8Q8bghYwIQj+OSqV8PV8/OFZ9?=
 =?us-ascii?Q?DfAjr8ad9cWOfAoIArfnZPtHKLDS4xrB8aj363YUxGq1uRPz8piMgh4Rbye8?=
 =?us-ascii?Q?QEeVmCYmkLSD/CCT9UmJGVrHagAe4il3s206tyBRHxWoBA5QWcbQu5Iu69ac?=
 =?us-ascii?Q?+jARuXPv1ApHp0IEVX6TfyrXvUkOXzkh8LMpGoXf21rKbTOEINwHYUzeI9lx?=
 =?us-ascii?Q?YmoaQAZseTbxf+jUrsH98B/490c9jkO0xom2lLRNvaj5K2Zp4FcIwzZGebIw?=
 =?us-ascii?Q?9kDEONTjK1SQxGPyRSC/tFlqRAU7vq2f1yZ2tbbS8/8UsqFny6KWCTrxVjzR?=
 =?us-ascii?Q?19US6PTG275Ufh83uys3JVEUMLb1k++/FBg21pRJRGM9Otf94OzRl1G/qN8o?=
 =?us-ascii?Q?edOjjUocmWrSLDs0+gJhhH7d2E5FX9LCqu7sz9J0Knvc/r0kOlfvyVmlHm1Q?=
 =?us-ascii?Q?xihtmjN5GOctZtqwm1JmcXcr1tx/OvmvY6Kd6OXUVh9Vs/hu2Zy/fTz90HqF?=
 =?us-ascii?Q?/Gils9MJfpuHhaTLKSSmfR8dFCsTbHnfifJ7y9HE/lRzS9FtH1rAFM6QigRl?=
 =?us-ascii?Q?R0nFRZKc3OGj/OA1S7N0bzccZoqwNi3jesh9yUr0FUdqBkXFbI8tFQ3jxPtW?=
 =?us-ascii?Q?c8Ub3K+8C43IoMrhIMrKD2WTW8IUsSQWefHU6TK2gNoa3xlzd7O8UDZd2DYI?=
 =?us-ascii?Q?gZTwZeDVaBSf2uodCpsb8m00tupF4R+oyAf65GXtjfnzha265Mzo62NiC8nz?=
 =?us-ascii?Q?EdifAlfaS9Fbo2qpQHBHEnaxI934lhi/j+MzXhj0FKgfmGbhzC1qaHQJYWvQ?=
 =?us-ascii?Q?8qF1fmZPNzA884awG7VGe6BJcA6QtfUBQ4mdLDAnWDmN0wtEQLrJhl8dqTDN?=
 =?us-ascii?Q?GczlzyLIYc40ubLEA5QrjiQQM4ZJaVTSpzUvPRzOa/a5t7NIejMcZO+lZjCF?=
 =?us-ascii?Q?urIP2A2dm1h19XZggn4L4020B7UkHedRJibQ/vphHiSL9Z9keV8e/nOWlad2?=
 =?us-ascii?Q?u44zagKJ5vLY7mVF/PtJrw8a1wyrX7zc4jthtl7dHNoYHkXZyRS4/sNamf4p?=
 =?us-ascii?Q?QfTIUIa5RdZZQmu1fp+66WfRN6UU+lS0/TKllsATJQFafrgC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd19a6a1-bd60-4393-095d-08df09e26a72
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:40:16.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gihEAP4pG2D2N6/tTN4FZ7XomJcjT0WSWJ1dwWhLBBOj0DN0TgGJlNaLF1X3bBep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600

On Thu, Sep 03, 2026 at 09:13:28AM -0700, Wei Liu wrote:
> > Does mshv use KVM at all? Can a kvm fd describe the partition?
> 
> No. MSHV doesn't use KVM. We don't have a kvm fd. We have an mshv fd to
> describe the partition. They are different virtualization solutions.
> 
> In the ideal world, the fd should be hypervisor agnostic, not tied to
> kvm.

There is a patch generalizing vfio to work on FDs instead of KVM structures:

 https://patch.msgid.link/20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com 

That's probably a good step long that line.

Jason
