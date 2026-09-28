Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAA3A1E96;
	Mon, 28 Sep 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602726; cv=fail; b=EMkHIvGN9HNKGeC8CGuMsT4T4YA9lgzYd/Bw9oMjwVCNu+K+Jm3dRpS3t6Ly2qtFaU0qq5XNcHAsdgVHpGoJKGStBYrRKzPkFZwimos6b/aX+kj/VAMWVryVTjtSsXmsDI3M9oC0Dsa/I/lNSXRxXGgj422AJUOpYUJH2ubrQVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602726; c=relaxed/simple;
	bh=RJTG8cNEnow5m3nxNyUie9zTMVrB1rujkzHXTuddo5g=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=NGRbZfc/M/J0yU/1yQGC4+8aKgYiu0JXSScWETWeqF4tuFJ43Q1LfUNsQGvYXyou5Iy0z0MuVvEnk2TDLYVukSZ41mHgl6Gmx/2RhI3kZy7whEro5Ihktln307F94X4Z/gWk6OX1rlquA8q4V97W6qqld0nXRX7wrB40pifRuNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ffAzAC1c; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ffAzAC1c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+mt6/YiPolWX6+w3QkMgK+471P99S3+6kxHd3vWvzRmKiJR/SdtVthWSkZNE5rncSNPOrf+wnUW64/r9etDAAr2r1HnoNhr8ihHOWitpR1BNHi5wMclGuVzrjuhkySE17cp8tEfxxv4uDdg5MUx4igauB3sLzOVJ5CiezfC1uxBJGAtdKkNRB4XFGoTZ/L19sWBARbCDhB2H/wuoAL6XR/4Fd9/0KyH/eRxyLeUXyMpY4iGhDofOEUhYUG15KMZFvPOwmYW8ROmGHinn7+hQC1dpATM8g+RGsiSOUGvGx4XR+lWnRmTp1VED3LRj5FrlWIMEwbijCTztPk38n7VlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGAirMmWntWzFYQYUFU9Hx2G2y+j47XVFQranWjoDuo=;
 b=GE0gCkso4csDooAwTDwx+jTDn9EPDJDjZdUjT83s0zS8NA458bHjEutpzd/C0hhPiNcm2/7Pm3iyfHPQF0nvOxnCCKsciHzRWrA9Fo4cyMIyiOGtwObFbYlt3lZcQuyBkRu1yE7f1MjqlGo6ZsJ3G4PQYCqY5UeWjzLzOZm5oQ2mGqjtydjcS3m8EMeApe0AyUgWEluHWnfKlvDMeoTk2GXkp7T2hcbQDMNPKVY7txKQQ6OU6C8g6ic7mTSbiqdnTwp7DEDcaCxyVjoSSEP73p0sQGrwI7n8gZU3Ixs5dg7j6XH939BgqdX4OoxFjWh0NC8gBB2Bsi/pGBz8aN9mfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGAirMmWntWzFYQYUFU9Hx2G2y+j47XVFQranWjoDuo=;
 b=ffAzAC1cMZsvWsvK57FHcE8I0ungG5//WWdArJfMyC46qzUosnACMUMFJBIavOzWuCUOOOOHi38OcXxNOLShkssdFFuFMQOgwEC6k99c2jM83/6QK47rSjTT/+J1jQ7K3AhGG6d76M6IMsApauaOt0taXZoX03283s0oNEKzsxXMQMO/meIvyJBzrljACH6k+pNBXs1+jVWnCYeBgG7R3MpKg6xyXcuawXtazLgDyiWF+Qy4WRlHHF+cUGWu4T+p+tkYdkbMVmZxg9LVNhq3Rvhr2QgSiexccoQTaCRBfqtQ1y6Htp74wG90Z6e+DXrpd5gp8aUg1L2GozmHLRO0NA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM4PR12MB6471.namprd12.prod.outlook.com
 (2603:10b6:8:ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 13:38:38 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:38:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com, 
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com, 
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, 
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
In-Reply-To: <20260924020221.128762-4-mrathor@linux.microsoft.com>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
Date: Mon, 28 Sep 2026 10:38:33 -0300
Message-Id: <179060271395.122959.9162511491972155683.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfaa683-e1ff-4f14-ecb4-08df1d65cd0a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|3023799007|6133799003|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mKGlesfysM24HZjLPBtYRursfpR3R7UH1EVVBn/mSeUAOkJOddAoqBuyXFCMO2Ahn9AyJOT9BFAnWW5L9zwwojei/KQAckL3CWzYHtPbzNsZgZSwgj4YY39X8Dktf2gieWYwxeFPwbf6JpJSvnISrj5XqFMUiZpiLj0G8SydSwyS2T4X6DcZneK5uZPHjPjxtJhMSRvxjaSTX2HRomway0dVmzptSjFa9yZH7rTuEdPJs5MBKOho/ZhsXfCoB0LweVM5hlLLdc6QhUKkdCoKMeLUtIAKqGAZomttI2475XUrSQ9yH1YcbcyLpbSLNOpuoM0QciHi0BIn47FBRc6rjYWllJU4nkXNDeNTxf4K44KlBw514eUKNMtD08eCNkiXxt7RdC1E/WBdIma0gKCd1YcvlfjXZ3w9KcKDpjBwcLoCEngjUBGHoaLbqo1nxpQAC0ybBdDS61s0yKK/8PS7RX/xH78aWlMWDulmxasS5mGRIr5c+axf0GHYI++NouWYEliHqVRprlIbNLT96PTfIlG2PL+oXY4Ywk2SlzIaBbwRsFPT5dHLT+Kn5HN5X4X1JFFACNLDxBBX4zooYKRxHxoNH+/+YZ/b33feeziTFq/l4y/H20NttOBzdr007L+g/IQQ+uPBG2tIb2L6AAsWVQK3Q6Rzack3lYm3tjJ+MFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmg4NlJ4eWwzQStXMHM4TE9RQjFEaHQvUVpzL3htN2JZdmhKUzVubjFRYnVS?=
 =?utf-8?B?bHhlRzNUNzg0SWsvN0phTDh2RUlzaWRoM09DTm52MWxYVHZyejh6Z1hpZk5n?=
 =?utf-8?B?VEJTOStIZE9rYXpNT1VlRFBsdG5JMUFvVGpEY2hZdEhSTEVROGpvcHZ3OE91?=
 =?utf-8?B?TFY5Qy9jc1ZiZ3VWQ1FpTmVNSDlCVm1BQVZpaS9PUVpwTlhXUnBtVDV3SkNa?=
 =?utf-8?B?MlZmQXVDT3cyeTJ2d1BpbGZidlc3UjQ5RFk5cUNVa2Z5NnllUDR6UEVZS1pt?=
 =?utf-8?B?NnpnUFp1MlhBYzdyM0xPNU5WVDZVRmFSTk5vdkpoSFk3MjVOS2VRbk9oSGRP?=
 =?utf-8?B?Q2MxeUNlWUpGZDRYQjdNSzNTbjNOWG8zQWtmUXhSMFNTWmdsL0xaWnk3cUkw?=
 =?utf-8?B?SEVjdGtGVHJicHVSME4rSnUxTmJHRVk4alZDcjUyNHVTWlBjMytLcHhMZktY?=
 =?utf-8?B?Tk4rcEpzVmlubzZ3VktNdVUvNjhPSjJmVWhWeXdtZ2VRN3RWbGR5SlJDNlgw?=
 =?utf-8?B?OG1yaXdGc2N3TkJ0V1hUK21ZTWdvYVdSVllXQUN4K2ptOTEwYjNYK0dGbEh1?=
 =?utf-8?B?YWRhV3AyeWl0MUhIeVdpdnVVQWZkYURFM2gxS2JKZ0kvNFZ1UW85OVpkZW9h?=
 =?utf-8?B?a3VvY1poSjVRcHVrbmJDeU9oMzRJdzAwd0pma25nQ1lHRER2dEZCalpCR3I3?=
 =?utf-8?B?M2ZPSGJ6Y0lCZnZ4cThWZGxMYVNIaFRGNmhzelN4alRiQVRibUREdEV3cW5p?=
 =?utf-8?B?RVNBQ1FCQTJLeVk3azFqWEdpNS9Ba21ITkVseTdFSW8zcFlFY0t1bEM2RXU4?=
 =?utf-8?B?UFA5WVJGL0FGUjl1REdFSkVmaWU3TmdtWWdnRTdWZXdCMFNBQ0dRdnRJM1lR?=
 =?utf-8?B?dWNDUDdTZ05PblBaYWFWVWM3aGF3R0xvb2RaZmNOTFRQczlFVFBVYkFjcUUv?=
 =?utf-8?B?N2dyM2gyekJQcVpCTWVQQm16b3VvdkRyMUxrd0R0bC84TTlQWGVhdkFJMmpa?=
 =?utf-8?B?YmFCRXFDb3BtQjV4QzlzZGE5QkJzNkJYWTRrbkpaQ2pmV3BLRXVPd0xUbVQ5?=
 =?utf-8?B?V1RtUS9SK2ZkdlFjTURYQjA0RlE5WmJXSWVNZUpTWGlQMEttNzZ0S2Y2WjNI?=
 =?utf-8?B?QWNkd1dwQ3AvUENjZ3lpb1M1cU9HU0ttQ1IwT1VvcEMxUFpRMkl0U0U4WUhC?=
 =?utf-8?B?RXFiaVR6cmRieWxlTU8xeDVCRmdQZ2NSeld6UC9KUnJkZ2wzV3JtNGNLVVJT?=
 =?utf-8?B?cndFR3l3TnRic3M2cTR0VHZoRWtZQ1V6dE5hU2FYblM4WnEwZElscjZzSUVa?=
 =?utf-8?B?TmpXSkpSZXA4dmlEeE1ncUphVndLNllxZllKWHlVdjNIQWNlSnFOelhPbWpU?=
 =?utf-8?B?dGV6OVBIWklOWjZ2dEdnMFdxVnkraVd1V0tObGdQUTFzYnhXdS9hU3BENEky?=
 =?utf-8?B?bWN4SDl1QTY1S2kvS1Znb2xMYnNwYTRsenhYTEwxemFHZVMySk9YTURDNzlX?=
 =?utf-8?B?NTRvczU2ZmtrTmJHUGFkZ3lTSzBoSTRnNU9IVW96aUJYcS9KSTRzakxHdXVs?=
 =?utf-8?B?Yy81S2hnTlpsRVV0YTByM2F5RExmeWE2UU9IbjhHNXdXTEw1Rkt2R3dteVha?=
 =?utf-8?B?dk9lMXBuSmN5SU5FMGxmNVV3WEo0SkU2M1U1eERPQy9iK0xPME82V25CREs2?=
 =?utf-8?B?YWhadnk4bjhySUl5SHFTU3I3U1hzUXVrU0pTQTY4SXlVVmpDWUJtaHRJYkpp?=
 =?utf-8?B?blZmallhUkUxNkFuNVdMaXRGRzFKZGVFWWNBcVVra2ZwdzlqUDduc2ZIaXNj?=
 =?utf-8?B?ZXp3WTB0d1lWZVdHdnFGSDlzbHVYYVpJM1B2TVoxNWozRnNiUEw5RmM2aWto?=
 =?utf-8?B?TGhhdlUwcmxrclU5TitHWTFtQm1Qd1JpdXhJbWhYMzlwUjVkWUMrdFY0UmEz?=
 =?utf-8?B?UlpWdDVMTmJJUWk0WENCQkloZjBjZm9BbDNrSFRuQXhLNGNFdEU2KzdGdTZS?=
 =?utf-8?B?UlphSTlrWWU0eFNPa004c0lJM21iWDFiQ0pyV1pST0dZNjV1cVFySm94TjFC?=
 =?utf-8?B?QkdtcHM4N1RsWldsUmwzaForbmREbEt1UUVSSWN3KzcvaWJpMVRad05RcXN0?=
 =?utf-8?B?NTQzKzlPRDlsK2JUSEdKMGVHTXpJbWJMUE16b1JnN2ZIMnhDSE9JbWFWT0dL?=
 =?utf-8?B?ODBNc1V4NWpwc2tabmFnKzJUQ21jUEp6TDI5Z2ljVU5HTVVPNVVEWnRRaUJx?=
 =?utf-8?B?WGtIOGtDWm5sUVhaSWYwMWgzaTI5TnBGYjNqM3h3MGlDMk12TDdsbjlJVzJK?=
 =?utf-8?Q?8dnj6qw8zrJF+CSUWE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfaa683-e1ff-4f14-ecb4-08df1d65cd0a
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:38:37.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JBDRk45h34tslhy9Y4yU9NPP7Nc9GWmpZzaQVS+xRX+Xn6VEKlX3DBmI1GwdviM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471

> [ ... 103 lines skipped ... ]
> +/*
> + * We will not claim these PCI devices. Eg hypervisor debugger is using it
> + * for a dynamic debug session. They cannot be enumerated under static ACPI
> + * device scope.
> + */
> +static char *hv_skip_pci_devs;
> +static int __init hv_iommu_setup_skip(char *str)
> +{
> +	hv_skip_pci_devs = str;
> +	return 1;
> +}
> +/* Eg: hv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
> +__setup("hv_iommu_skip=", hv_iommu_setup_skip);

I don't like this in a driver. This isn't really skipping anything, it
is just leaving some devices in an identity mode.

If you have a use case for this as a general command line policy then
come with a core code enhacmenet so everyone can choose per-device
their boot time mode.

> [ ... 7 lines skipped ... ]
> +struct hv_domain {
> +	struct iommu_domain iommu_dom;
> +	u32 domid_num;			      /* as opposed to domain_id.type */
> +	spinlock_t mappings_lock;	      /* protects mappings_tree */
> +	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */

This seems basically identical to what virtio-iommu is doing, can you
consider sharing its code?

> [ ... 26 lines skipped ... ]
> +static bool hv_special_domain(struct hv_domain *hvdom)
> +{
> +	return hvdom == &hv_def_identity_dom || hvdom == &hv_def_blocked_dom;
> +}

This is only called by hv_iommu_domain_free() which is only linked to
hv_paging_domain_ops(), so it should be dead code

> [ ... 204 lines skipped ... ]
> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
> +			       struct iommu_domain *old)
> +{
> +	struct pci_dev *pdev;
> +	int rc;
> +	struct hv_domain *hvdom_new = to_hv_domain(immdom);

'new' is an odd variable name here

> [ ... 246 lines skipped ... ]
> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	return pci_device_group(dev);
> +}

No need for a wrapper, use the function directly in the ops

> +
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *reg;
> +
> +	/* reserve the entire LAPIC region */
> +	reg = iommu_alloc_resv_region(0xfee00000, SZ_1M, 0, IOMMU_RESV_MSI,
> +				      GFP_KERNEL);

There was some discussion to make a helper for this, I don't see it
merged yet..

> [ ... 65 lines skipped ... ]
> +static int __init hv_iommu_init(void)
> +{
> +	int rc;
> +	struct iommu_device *iommup = &hv_virt_iommu;
> +	struct hv_output_get_iommu_capabilities caps;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	rc = hv_iommu_get_caps(&caps);
> +	if (rc)
> +		return rc;
> +
> +	hv_iommu_max_iova = ((ulong)1 << caps.max_iova_width) - 1;
> +
> +	rc = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
> +	if (rc) {
> +		pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", rc);
> +		return rc;
> +	}
> +
> +	/* This must come before iommu_device_register() because the latter
> +	 * calls into the hooks.
> +	 */
> +	hv_initialize_special_domains();

This probably should be before doing anything with sysfs.

-- 
Jason
