Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132353515D5;
	Tue, 18 Aug 2026 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097091; cv=fail; b=KHLH7woRvq3blr28u2v3UMjxZO+LLUlEeEHsD9yFUGanZbg41da7esfTM93drUwt17kVbl1ID0GagqlSjRK3GhW1P/TYdsASBqWJBsho0BE59b0Wfx/mlpqbu4WH0Wqy3ahBBmtyaeE/v/8Y7w5kOSoDiPjDXPlOAhYKNf3jqMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097091; c=relaxed/simple;
	bh=TCk1lsS8l+g8ySQM7/VYY66F+NqngCdKItg29hqLuYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4MUq7v6Gg6VAsjdiCFpZhO7yENQbJCVbGfNUJbpBDmKS79mfhPDgrz7MvQ4d3/UHNZ2EemqB86uXdLnTtfRg4OanXb+Mb7oLCHXHIDtd3yjxO5/4mGWTAYWBzCyUN2Br1+g5c+U0Oau2yEXWAeAZha0I7/l4fXpN/CaHWrgSjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rX2PqEML; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rX2PqEML"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgVHm9qvgGxYwNkeTOZUjVEyGN4BZdnHTMyNhU7R1KrOl7xynqFn78xxVY3wsoKmkVIP1n0AtXUNdigZt6G3FQwAZoJiSD7cKsFJCVJaLroMqbc0OBezEvRlFMdg4WuJLaW+6kit7U5+nh+En3bq0eLWTxTxOpWeddZ3EQIMAjuj0J0IDzM0O0SSQlRgO8SLCzx7plzfEkXSbGZE3G5YKHd5AfKdbQ4BaDZo1iCneFoaI4BnL5jxtqIJ2uJhv9/7ztOjtCRydMDeg2KNYLykJVRm783meFitcreWiRRNH1qIYlcZqtTXQd26BNV/YKIYCtAhHIs8QXpkOEZ9JZDK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtsSYl6EkOPzxx9qOkd76JfWqZbvaz4txBqygRO/avI=;
 b=lcJ9jkON/TMPGL6MPL/BoHjxmMzQXoFE3S48vVPXXlfH+2w/JtTLPNfhFD6JarQ5cROuDruKCu9k6ixWywelWJYXwTJIcy16dNt9iWeayUVB/52LtzFQJYxE7/xiIZOsVZQWyjZT5isAWARaYgpZjZ7N10pH4PTR5yPFKGZ6LryncD4YOjadD/HlwCDl2uTgjpe2TW6jueyrv6yn8A2YzHhlCw1i6KID/7UxjDlhXp7zPCMIEmFXpS5NfqIUE3ppBu3jb3ilGFqh7+Uh+pjqCjVZ0afZbQUdLixt5q9EMx90TLhPtRYA1esudJBbo3g62c4cVAHzFyqFfAZJhkW3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtsSYl6EkOPzxx9qOkd76JfWqZbvaz4txBqygRO/avI=;
 b=rX2PqEMLVEuPzaIg/NTRvhHoxwvocm6FTnERJdiho0jHiBfPjnqN+teu8C1moSHAOBiDt1ncES73bHZz9faDe3Rr/YYQHlgY8SPzaV1gLdTX3EOp2rMQ4q+w/AtFs1hVyYxpxLJLN3rmm9dFFQnBTNdWwkaeHlXuImQRIp/wKLq8zIUtf4BxxLtfJqEpIf57wbyiOUmowVDTRFobSXz6tSwl4TbLdtosNis6Go8/EMuZmOmdB63kshqzcGk7GNxxc/1hh5m4tJuJUr+CZ0EIHG0DGhRAIS88doTjvat0JLsGNcWoIXi8JX+uuYUY/aC5gnJ2+2QzTq+yqsPIuoq5pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 23:51:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 23:51:25 +0000
Date: Tue, 18 Aug 2026 20:51:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, hpa@zytor.com,
	robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
	mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	Teddy Astie <teddy.astie@vates.tech>
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260818235124.GB134244@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
 <20260805124838.GP27883@nvidia.com>
 <20260818140119.0000507d@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818140119.0000507d@linux.microsoft.com>
X-ClientProxiedBy: BL1PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 2272d622-5f5d-4320-be26-08defd839d04
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EK8GM8Asu+Y9yoQxx5gEEfLzJ6VdsmYyvspYotnOE1n1FHJ4xaZCY9W22pyFi852gSwdHB3ohuTwrkCIF5fOz7Mz2ygZmcHQ7lh9r9LjAU8WkkqYe+xI/hc2R8/PYc9Q1gQcFB1TL3S9TFkUuU2U5/AvtITE/2wWRAjvdfWRYxiBSODw8eREkUh6Mflmejp0K1U4/GEDsYlQYO8w9eQrVz2v/61HQEziBL/tsG4BUqykESEIsuiosz+pG8dRpTYW4sgwZmCdNb6qglaxBU9gCStCGKtxEgkLmfzCrhFh9PB389zsJdpUwr1o6hXhPRg18+yeFwoCx9zs24BAvsSxgDMDw4uxvYm3qx9BKEq7lmGN1AYlJS22/2bl668DwtAee2/4tsi+jiCFtAhHjcmBAuzQb+VWrwoDKl8IUvFzw2BKHBtW0MFBqfF4kPLY7RnHjQ1Py4yZoRFFRSMrDJ/RpBSiub2ZXZLMXkXSEXmaPyflUID+1jlB6YeXp23NikG6Um0s00MIv4X4OsnbaeKeGUydtLtaVA8rui64IOY7z47pjhHNLqpVEYZtd5G/pTC4H4lw08yZ7IZFtes6X+NiAYEsmUsGiCt7wcSpNjgZJy+0XHCuZAFX1MyPwOqm2XHGEcZ1hWOYjLeqB5x6Ou6UcA83sBbRlR8B7SbF7Ka2y8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qXeCQs2O3xl8b8YMNK5Lf8TDV+AtJPgwXV2pepxdoCygU/jJFP/xhKkk1Zwy?=
 =?us-ascii?Q?3Wv1KB0skzPFpdukaDlI+Q0PRAFs5OXZeRMryXsDzCYSKHPUSPSkLvNhKo42?=
 =?us-ascii?Q?lcQkUXMzcwqqLUCQSfN7XRurWKOEH4Q38atmvHeh+VR8Qe4PwSmGPbW7HeiB?=
 =?us-ascii?Q?JEGaZmgRi15HqaZsh+54OnwpG26UAuN5vYMWLlgVgVBHAIjrcGh7SX589DUs?=
 =?us-ascii?Q?E9KSsSqP2CaOooxw38gL3WJLfu9xlqNu7AU656Dcs+i2EZnPdfc+pZSoCi6+?=
 =?us-ascii?Q?DOGHTBZik2ZBk1sFZTAhoI2kTRJTa/TupQVvZgI/nfJ7ghcSBG6yrBTm5y2Y?=
 =?us-ascii?Q?0ghpW0TdXgIQibcVdi1a5yhVVeH25oQ01XC5Zg4fqXc8V4Z44SEdF9NOyCJL?=
 =?us-ascii?Q?p182WcbFPGwl1Lfccb9qAe6wEAE5m2NsTUiH1IZOdI47eX2yDrpEo00i8avJ?=
 =?us-ascii?Q?GYjvVDvAhz5U1rHLeGSjotiMRAjQLlzGHx0paYxbnDVJPnY5MtZBk3LIS3QR?=
 =?us-ascii?Q?Xhbj9l5welCajONMUSr2c2uUT0VDHbNbIHCclFChOO56f0Dhpk9w7u4nNnTl?=
 =?us-ascii?Q?ICtVg7+tuAnGzA5aBvXskZu4wt49fQu6BAIYo0uu9JHO5JAx9dvcY60ZlI5e?=
 =?us-ascii?Q?OZ98B96ULDQ5t0Xeybl8ZLK4IesHVKFf0Glo51dZZKoROwi2KKLqJxdyofN3?=
 =?us-ascii?Q?sk1OsYcQKIstqc7dfHjrcItiikXzgRuLrmqYa3+AHrRUenSmNiAFBmaUwxcO?=
 =?us-ascii?Q?FpY2RBpydmGNFhpI4XApFpMpcwi9Wpi9IBTEU+4py1W4lbajsU0Mf7S051Ox?=
 =?us-ascii?Q?7AcAUtzj25KZLj4N6ZQfB5ZhqdqIRk7lQdl4wD2dBVtbx8omsfzeDvAVCMGN?=
 =?us-ascii?Q?X5av6fO1iDL8X4uDz/9RQVQJtqNaCDsVAXWnrK2p98FYa6WROt8Ddd6PbFnk?=
 =?us-ascii?Q?/vsDkQxLp4l3yc4EbZJzKu1OQWdDYbaowrmp35s6ASiwZaDQEgsenYKCqZVc?=
 =?us-ascii?Q?Chv3uXGmn8hK2UIty0xL4fub1gHdXnGmqzs08+iG8YlhLPDot6HM0aygvVyn?=
 =?us-ascii?Q?ULeB33wkoFtG2Gi7obqAmdMLjhKHtxYPLNC1smrQqtk2Y358wejPPDg6tCzV?=
 =?us-ascii?Q?+7vvhlsbtbfOkKJcX8RXOsb4A3QQZtK6qW4S6INEWElDXOmVeVzbORnGYEJN?=
 =?us-ascii?Q?9uRE8C5gNcuaQcUzjQ61VYgsw61zDXMXlpaF4JnE/1XlsCFaRKcKG4BZ0iu/?=
 =?us-ascii?Q?Q0dahoYHqBXRHlDepxK8muC3cbQdT5zBzcIAshB+z1jpJdwok0QrYXZ44yjv?=
 =?us-ascii?Q?3gfnCarCUWkmFezJroDsaXTKEag5fBQ9zbr9DiYmcktEysgks0m2/5PqCaHO?=
 =?us-ascii?Q?2JW9ghvc8Vxq4ucX8/mjpO8k2/BoCtzU4scZDUXENm12MULpsn6k7peCYNY4?=
 =?us-ascii?Q?w+yH06ofyNlp9BEYYav270q1X8RDmxUUFejZKKrEajthB87WWk7BZjWKbl+n?=
 =?us-ascii?Q?vzZOCf857juCS4df7/gljARbo0CRADRIFLxJXVesLzppIuFP8MvZecTwNB4U?=
 =?us-ascii?Q?VX/397sNoZRXFEScAhIp/P4SFK+nTP2T8igW4QwvhrXQNQ8HdLrjO2Un0LcF?=
 =?us-ascii?Q?az3gPsc0kbP6cWEdcLUslOXrgGBC9iTmhx3FO4vs5Q5JUV6SSQf6ybicOOtz?=
 =?us-ascii?Q?Z8SRVfbz6zIdNZ8ic96oPZKvfUgbNItKmmSvXEa4+wxp5qxV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2272d622-5f5d-4320-be26-08defd839d04
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 23:51:25.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDdki0I7HNb8Cj7PVMDMr8i5mRfBlel+K/RLc9oEZo8Q70xufFSG/8iRd8UOVej+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

On Tue, Aug 18, 2026 at 02:01:19PM -0700, Jacob Pan wrote:
> The rough flow looks like:
> - vmm creates an iommufd ctx
> - open cdev FD for the assigned device
> - bind vfio cdev FD with iommufd
> - vmm calls /dev/mshv or xen to create a partition, stores hv allocated
>   part_id in its vm FD's file private data
> - vmm creates a per vm viommu ojbect of direct attach unique type
> - in this hv-iommu-root driver's .viommu_init, fish out the part_id
>   from the vm file's private data then stores in hv-iommu's viommu
>   struct.
> The rest is for direct domain attach, roughly
> - allocate a vdevice under the direct type viommu
> - allocate a direct type hwpt (new)
> - attach the direct hwpt to the cdev, where this driver can intercept
>   in its direct domain callback (instead of abusing the paging domain
>   attach).
> 
> With this flow, the VM identity is explicit through the vIOMMU UAPI
> rather than inferred from current tgid.

Yes, this seems broadly OK

> One open naming question is whether "direct" is the right term for this
> object type since it hints 1:1 mapping which it is not. It really is an
> externally managed S2 domain/iopt, so "external" may describe the
> semantics better, as Teddy called it in [1].

I also think direct is not a good name. External is not bad with
something like 'external hypervisor controlled translation' as perhaps
the whole name?

Jason
