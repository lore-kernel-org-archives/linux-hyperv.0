Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A149D5A6;
	Mon, 28 Sep 2026 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638602; cv=fail; b=ZSe2o9YMzHdgAqcuSOEzvUAKk1G50E+SEUo5gF39Ne8GyHY6jmThRSiJ2oT9yVKDkWpC0n+Rw46xZmx9WMZN301i4PPhPL1ogDyk+AQPVWIcxE6J8NU+wGZq0blqjzEDr1RbhSBvvhpUIvdBbNWGtvKh871fuC8VGxAPWMdUQuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638602; c=relaxed/simple;
	bh=A8liV2Z02h4PiUS09QkEHvRglmNdABSQRPiY3DFoCas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hAjCFyuoW4ogMT9V+lbKV7f03sEgE/TpFsqm1IaHsNTlbE99vPrcd8G95wkiZEvFwQuzxJXBIQGcKqKLsSOlM745wT/sD6Ee4fqs1bwJaArjpkptiVXUncq7Edbc8+n5cHuDxAaEwaYzfOisCEL2oHRwYg+ME9BzTwb5UWPZFkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VKvMisiU; arc=fail smtp.client-ip=40.107.209.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VKvMisiU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUPnZx1ORF45HLI7r8P8/ZmRCbt4w2JZDpEOJRp9df71RBKKmVL8OqNzmMf8EQRGFJ/3xy6yPsk+XBoD4oVdDfehWwAlYy6KhrhDgR8HfANYeJTP2nQJPlotMWQ8H89ZGUs+woOVIV1lHv8lScdzVBotR/UwGpmrG+PrOEpNohmQRGdGaA1V2nBUv8EfiGdiefJXhlubEQencVW/IMWheGdxMqJkwsI83TP6D/NMyaOk2ITeVMNrxDjWW1Gvehag/jRHPq1Dc+txSMmQ6kbGfTeQqX5tV5RGDWbWoBEl05aAhZJDLwL0BjqJxJTJK4q7VUSm3G9oDQs8wXipxLnTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EStoJl1Xap5dvycUyQKbuSUdEGKvNND3gNMgexXoB0w=;
 b=LTXd1DRGYZvxy3+Ovjvn7ZTgtSs03PFG/K+qOyWwWDna1PISscm7w2nfSx2/WxTBobYiJO3hrIus98O45jEqAVhexD0xT2dRXYjA15Y9rUczHGzXXBcHUOPvGW2iwr9LHsmv7df0UMe3dZKjnBjBLQlgtY0YL8dDBhailjzlq2nEaUa1tD6QZq9y5qYvvNBs+/N/1meWp8hP4hJ2Wt2NBZlPa/yKZKLLYpxuoSMv+2Fwi8EALov99VWAR5efVAiPRPZuNhLrup/F6NZzE1xxlR3rPa+H8PN1Qe2lWvYNVl8KjW+s31QqMCQe/9TuonfGxgCt14nWlyquYocqq4zm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EStoJl1Xap5dvycUyQKbuSUdEGKvNND3gNMgexXoB0w=;
 b=VKvMisiU0usiKSwIghmoWwh1DvZD0Uc3QwfQjHjCOMbP+hh/9Z1KrYOVN+ypvJPgzsgSpqjB1sJnonq6fmZUW6AkgpVuF9ZUB8k3tibxm31HjCka+xch7dq1QhbXyT5TE9GGu0wkMLrTeaDyN/x5/8u6iABWovZM2cA9wHi3S14QAKrqYhKMgNJ5ByFDln2KyDsbTAwXltmINPWOmb8VnOdxjBdIbYGwN0fwgEOVmxuEFGzGs2Q4olJrRbQKnEkAj4nDOW+z5ynYTF9YrxYewWQo8YRAZ4AXOWxk6W7L+UnXPHeWZg7HRlAtoguZRLsfTc0hRzBGEJAxcvNfKMIWuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM6PR12MB4338.namprd12.prod.outlook.com
 (2603:10b6:5:2a2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 23:36:32 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 23:36:32 +0000
Date: Mon, 28 Sep 2026 20:36:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	jacob.pan@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	arnd@arndb.de
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
Message-ID: <20260928233630.GF1616761@nvidia.com>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
 <179060271395.122959.9162511491972155683.b4-review@b4>
 <28ef0634-24ed-2cc7-89c8-48c8615a9691@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ef0634-24ed-2cc7-89c8-48c8615a9691@linux.microsoft.com>
X-ClientProxiedBy: SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: f8853179-f2fd-4a08-0c19-08df1db953ff
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	be7a0sIx9kvDNCYS0vGkeqcif18cH46uYn+CBhxr/rb+tZAip+ZRZVThRTpr1O677zA1i7fCmcOrTaSDHgs+xEOu6n0EGmfhdFIb/yq1qrddIwYhXFN0IbuodyExqq1vnFDleFxMOe1HTGHizq0t3ZylIo4VCA/qHWiXRRz2oNviBu3bpoJggEykOpTHoyNqowNEoZhszn66eiLjOQzL4+WZN30UetlgdULQ4iqNT9TPpNBvim4bfMHPinDsdfmNaU4hCtPm6lSv+F0gjpjd2c4JiKcwUjObXZyDQgKDvki9V/9NGR/C6xo8KGzr8yDGvhNNVVkhqv0Zwapki8GWJb58hGYw1JNWU5PMK8JCIt7j6v2xEN+EaI3FsWNHcjXFI2/Cj8Av7RXhhU75kxti/+thFoVQA/t378xITDVZ6Ejk7Eo94/DQR01hIl0P4E5x5rgt8AgUh2Vy13Whmm4Plol8OxdjfxsdN+rxTB8Vs79Tctpzr3Mwnz3TgCPsQGUubAdkCbhhrOpPdPOSloKG4jfxN9LNIh+aOFb4UHupM3UwtgwGCPdTc29E8A2npbvf6S3X0Clh3a7bucr9TIt1izCvTjv1Xs49O1GaZ1wXt9o8hjpeTc7oajxoK+gTP0OW5S1V93i0mnxvd4Q8nJHNjqS3Eu2xI6xaMP1I/eA1czQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wD3nyENa8I0MswUvH1dMlVVXTP3dVbRxm5+Nk3QsUlCsmvKbQkWKJZ1ZAh2g?=
 =?us-ascii?Q?Ch7Xgp0VzuE2AIlZefbcU4KvKARZ5nJZUdbzXIIoqZjj3T7uMoIjFS2BrzFB?=
 =?us-ascii?Q?UfIaGLGEg8FtKsRY1gWrrMskfv9PB7/HT0yB6VVxCUKFTw7rqla5csL/uqf2?=
 =?us-ascii?Q?fIu+1fJbY7ZO12NnkY931B8VmiHNsxqz17t5ymUgPnfnQdLkbGwSC8UciYeZ?=
 =?us-ascii?Q?g6Bqs2A7OPRgwaftGF2hVd3bISz/vhvpe0S2Tkg6A0rmHM5qLVxjSG/LmRyh?=
 =?us-ascii?Q?ZJ3PmjMb7Be08s7HmXtRuL6PHfI1WxGUaMN5q0A8sz7MzdMTQwjIWd8UVgYk?=
 =?us-ascii?Q?mUsHJ6JTtvi37k+XQnLKyOOstXWaXo8mP4bAdCBOKA3SBLRHn8cNZCbaCLTS?=
 =?us-ascii?Q?OIkEwWIJWaXlM56l0xVBjlm6Yfq2IDmuN6zb1mC61CAZBEvHV70vMCtk64h3?=
 =?us-ascii?Q?7fraETzqSN5HEa65aXTtm2Wx1bJ5vTkVlZkPV/6zioZlRNCzlCb+nFmpbBPP?=
 =?us-ascii?Q?/VaVYCp3HTURnYfJmJ01brwBc1OO1McWDGw3TVCknbU95eWgLDdfPQWZ0EFt?=
 =?us-ascii?Q?c78X2WlGk/mlRyE3ZVyFQjLaAHZ1MptTQWNRQ6t2EBxwQIZtwBv0QOc9TgWO?=
 =?us-ascii?Q?DcexcgmA0y7GfwPJRghzLTymhja9rFKCkUWZ3jXey6FjjI1tVq88DdqdQwT2?=
 =?us-ascii?Q?PXMhRcCN5RkCZiqAhH64jBEft5NPwXxER5zuoeiLmVKCaeMWlzWh6wMkfrIi?=
 =?us-ascii?Q?qv130YrNrwM90s6TcoY5jyHDrgvQLmnZETxfxhQZIt29f/fef9fI03wGs9JZ?=
 =?us-ascii?Q?p0bzc7jTejAFUefBrU5kuFJJTIMLaNHXg974KSuLxXYQOM+TvfBAcoMZ20py?=
 =?us-ascii?Q?AiaBBosCcuSKoHbvu3tSCCd5PxRk5xXO9XDn/4gUYim360ibLN2WsQ2KNF4D?=
 =?us-ascii?Q?TVYV3zsq34tCEElSzllKeT6J9cK39TLkGyQVGJsAzT3VBs/VQtwZs2oZOZjp?=
 =?us-ascii?Q?yu2PilXEjen03xalYZN3geTjRR6ls2eLxS3sagaa5eSNuFtYFVgp753Or64T?=
 =?us-ascii?Q?JDDAZDlx6g4fT/630jtAnSNDO7J6ChDQyhzHVRstJfxjM3h5ujboSGq+Cpg3?=
 =?us-ascii?Q?kIn00U+68275ancx0WOTISwmZOgUN1ztQpeX5+6CnfuPAO1Txbfp1v8ZR4uI?=
 =?us-ascii?Q?vKCXy2CZhwtaefx8uJhSKe6MqDAxn1Qwr4pyYc0ymcav6CVHQrZieAU1fGp7?=
 =?us-ascii?Q?tUP0pQez87zhZWctebmjSJYxIfznY4G3csWHIl7XTQNSxYPjnznSb+tAQjJ9?=
 =?us-ascii?Q?SkiI4DArQnewIPvDRNO7Wo2KeiGciJPB3J6yiT9hm++xk0VF4qZCDJe5TTxN?=
 =?us-ascii?Q?Gs2rZrjT/cL/1+SREhUwZzDGbrEXsDBkegPq0tKeH0RxuZcPbB4Pd/u2118r?=
 =?us-ascii?Q?9qFaHSiZ0REJy+n2EBdSPKaTPYw23RAFzYKji8qmQPoPX92s0GL30Rwi7K/J?=
 =?us-ascii?Q?beREQqCMNQZ7lseoQFOHSuj7Ifr1zcQ60adeCPH4t+XKRJJKeQyuxjVqI4KJ?=
 =?us-ascii?Q?NBBAkpsnl4JNShBhMzrSyydaap5S6zLqufUOQX1ZTese81TRQCSeiOOWJPGT?=
 =?us-ascii?Q?pR7Nr13PF0vVUxnjvlsmyxj9Fl3zXwFGASzgV5E514Dn3r8shcNaeSDN9EJl?=
 =?us-ascii?Q?KbRixzU/ZA6OX38Q9e8NQw8ddpUbUVW0/H9ywBMW4iN5j9Rs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8853179-f2fd-4a08-0c19-08df1db953ff
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 23:36:32.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S46FTBRMbQB3j/XaSEzycyEHluqSchZOY7x0OvS3VM7+gdzUas7CGaiaA2TWKbYM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

On Mon, Sep 28, 2026 at 04:33:35PM -0700, Mukesh R wrote:
> > > +static void hv_iommu_get_resv_regions(struct device *dev,
> > > +				      struct list_head *head)
> > > +{
> > > +	struct iommu_resv_region *reg;
> > > +
> > > +	/* reserve the entire LAPIC region */
> > > +	reg = iommu_alloc_resv_region(0xfee00000, SZ_1M, 0, IOMMU_RESV_MSI,
> > > +				      GFP_KERNEL);
> > 
> > There was some discussion to make a helper for this, I don't see it
> > merged yet..
> 
> we are both waiting on each other, whoever goes first will leave
> the follower to address it i guess. i cannot test without this and
> i am not sure if that series will merge first or this.

Maybe include those patches in this series too?

I think this is fine it should be able to go after you repost it with
the minor changes and the clarification on the unmap behavior

Jason
