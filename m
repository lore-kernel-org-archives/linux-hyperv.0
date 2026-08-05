Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B933EFD07;
	Wed,  5 Aug 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934125; cv=fail; b=Mk10rOgjFheBUUetbMPBAgc0PxwTZtc+b1YhfXWZAVP+o+aLoP5zxzBRDYcUZXvcJ4f1AGjxZfV9xExQR0fb2l/drj9vYVrPg/RoTuvYIAiZYvCZWtBCCApGbHsN5VpQ7nvQrUIEHnu0aot7vX4TRNfPuxGwkcgeaZRzs/WywQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934125; c=relaxed/simple;
	bh=hcMuFzdX5cAzu8HlLbRqECTFtjYxf4tjVb2lkYzd98w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SbIaiAUQQAXymTIFiga0tQNo5CWLTerW3TNrgZW8EJlCObaFHnATriCd+j0vXce9sqQhpMf6wRD0YdBot+0Cii685IGzpch3ox/HGkuDikfhL8QxdM/snc04pqbaM9lPfwR2hWHJvA5rH09WI4WqXZAi3nHGTe8WjNfIvyLRzZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FiOyoeiY; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FiOyoeiY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1eBLRUg1lhUuDcyibtOMoVPR5CBy6Ph46NOi667cRnquFZKzKPl99EkONT7PsYz4AHagFShFlCyba0cHjzr2/zyaNEngbF+kNvo2i0kO25Ne3b5/bKgWHvn/doYmhzSds7ptMz16IX088NrHKZPbC9jjYZ7frrvnmP2HM1wqCfGYsKWr7QnJB6MGO0dRnDx/Q8RY8ubprfcD4VRVqHw5j9RdtiG6xuylBc0zlcUEvMjNvVcCj0gt0/ZUYBVFULejyrtldws1JNqAumS5DJyBLZMnMuua29nkrYs8XPTwK2ei8+2HqJOCv5nJJk4qoUr/jI5MWW2ncEu8FB7vJkB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycYvnxE/eOm6nqFDykATtT41QOY/J7JDOmwAeOSfjkc=;
 b=eqkadu0pWNRAcovIgdgMuzTQsB+s+I+ReIJXJq1ccnZXEJJuDiY6ZYIg/CSTdF8esSBoJCWp4W1NMUXQ5jfVgE9VXcPvzuqPI9e32YZpmabU5juo7LeqBJ1XJhqmXSyEw/6ZtJTCuCURkyzJ+s79xU44f+3Tes7gO0f5+O11vfbYk1Z7XvJWEd0y0Y0U+AMmiD9ToL3ynsoLAQfysmmHQ5SMxtHfBd84Hf4NarXKsVcoaM1ORzVSV8XHq7OcQQIIZEEePc8kXp/1y7yhDS9VwxKQolJGsyh7nPtpN2f8DQTC/OEc29hgmPnrvpxDfq9bIoDy+IfXkKAwNWB0F29U0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycYvnxE/eOm6nqFDykATtT41QOY/J7JDOmwAeOSfjkc=;
 b=FiOyoeiYyWmxDRNu9hZCxVRWh9UzAZmEN9u9BFOYI4iD+8lJJ/4ZB4v/q8IWZN76Boohe6ymecFrXAannc8qpzwu+dbuMO50kOT8RadSDPQjgg7ztyIbJtFnyIfuRXcAdx/Yuv+1ub78CxCW/TQtyKRaxlc3WrOAV5LvVM50bSczvnLM/qpAFD1ngtrPVMfOY2Ynb5O3AANa2ETAABfJBcrpZT9rb7AoWQQDjdXHQcz0KGrRhUcqODzC81qGPjnxo0oONeyzFtEOZhYXvzlNIh0QOAi9NWNHKq+bdth8P7Asm11Ok0O2qcekkuQj+FO2S/7RKwuBeuO24Ihy3Eu1VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 12:48:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 12:48:39 +0000
Date: Wed, 5 Aug 2026 09:48:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260805124838.GP27883@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731223427.2554388-8-mrathor@linux.microsoft.com>
X-ClientProxiedBy: YT4PR01CA0491.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: aa83bf02-51f1-4223-2d69-08def2efdf55
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|5023799004|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	EnQ+ie4+EsF6YgdEN418pctYbDeLyrZVn7dIWrdp1FT4d2zcaqY7VktWiIJTV3iprUl8hJFB7pLcLcC1ZQk1h/GJxdDb+80leRlrLWJ4M/Uovyf1lJ8R5lhwWZz8+ZdYUiLb+rufHT9df32BOgWhfcgGl5AmT7n52uunWOhRQvT6dlo21hGCx2z7DD0wpTwf+kmY33+TbZ3vBHYOg7RwyiPxk9WXX2mRdfHiwGi+4zwBad8iYRChdjE9Okg8jDMoFGlblLMp2gwcWQ50lUOR3dJhXXMovw8w9TyTngXQtT1vdDUYSirJ0lHH63CMst2QD9lTspOePV/qMWUqynTmG08O3ljEyOL+fu8R4Hn9vLkCu68cBki7GpwA/fs7JvhdGP5j32xj8wUXymUy+sW54QJfTsqjPI9mqBzZWKlC/YOdMhKRp0gW4RvA+duxogIV1Hj4Wi5QceG2PDhYvUol3bLYmZXnvVZw8nhfPlRkWnNP5xMmll+1FIZ+Hsavx1Y6Eyp/nxJhD+ks8RTsnuSH6eI37Y0OyqoFi5kOvIEi81NT9Twz0LOPrRkv59uXHC42At0vmif2isFb/kUGkFLq+4aJNWO/d0iT+WVJoTunLojmqptxZcwQfVihDVQuF7YkAXrjeQVRBsD6Khq/5sae1V2Wp60uMD1cY+HfMScqOJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7bIMdNG3ksBeVm7wITuJfzaGxczF9Io3E9Cknb3kXjR1Vwti38BKdIA/Pkyi?=
 =?us-ascii?Q?WZ4eHTtlt+r5Knx81Q9XrSNa/Sl2zsC3feBNLOb57kglIjC9j0NR9UTAlKVA?=
 =?us-ascii?Q?uH0a+FKbW0E5S5tVuFIo3f6S7fs8d+oXCN7SFg/hjsirtL5IrLZ47aIAcVNx?=
 =?us-ascii?Q?k0VQmhCeRFIeuOBdw8mjTD1pLd37jpUUoG0A0EOL5Rfx10fQt2C8TPzn5ja3?=
 =?us-ascii?Q?WGyF72zGbBFvUHKV98P9Ck0gycJ2iNfToXxShCip0/vbM/zovHBG8dg0+IjD?=
 =?us-ascii?Q?1oyj//ZC+hMuIOxxZPvJhIZXgsdTs7cdRBJlwEpEQNC9tDwGOIsVXeyQPFFW?=
 =?us-ascii?Q?91G7shoDeDx42Rd+bj+D887DufIZV42slNj8pOCEVYXTQANOsZlw0TaSiaZs?=
 =?us-ascii?Q?7WWaQYqcOTM2FD5d66vO2+uekaD3nCiL9VL6Hm5Vm0xOvpimXf+3RyKMBK26?=
 =?us-ascii?Q?UqCtKGBKzyYi39LZM0IhuHRcYgOpFsZX4AY3Nzjyvk2JTv3hCzJGAZG5vu4M?=
 =?us-ascii?Q?OtWMv12fcH/059sVwJ/niSFSIKcsnf1r8zyWe5zCkYmvO8MZ/wxPkuTNEply?=
 =?us-ascii?Q?8Yy/ONZ8OHIJY3mfKPS5L7RJe6d2iAEJPXH3TDEm00zpPUWTcb7G7yp0hWjh?=
 =?us-ascii?Q?1T0dIcvAWOZoC5Lqy8Hljm8bYqd4D3h8KTCUTD4B7KzkMDZ4H3MZjRR8ZYyP?=
 =?us-ascii?Q?voegasEgrOLICm5s48jaCxxOFgM+PWqTnGdyGGOjCFUdprrlH6kw5wMNFuwC?=
 =?us-ascii?Q?4+AH91bQHD0/1PHApbLOqxyD8WD4BDhiYHVhuIGAAmJ1N3VjBK2VZrrJScz3?=
 =?us-ascii?Q?RlkeN52T0zcpO0ASgbGaJ2lfAm89ydxWy4eIcYR1MYhEikfAL72c6m6gJwre?=
 =?us-ascii?Q?FGGgXxLx02tJJ4kyEZj2EDt+CMpJpKBrbiNfcvdKVf25cfUY71ZFSSY8Y4Iu?=
 =?us-ascii?Q?sCuFYpBTsD8/JtAfETSZZBgiXZHQeKahHrVDERU1Bdeb2TKMdKpkWXw1wYLA?=
 =?us-ascii?Q?CpH+miRRJ/5r83tTHo8f7l05NCZY2TE3AqtfX4qLA0HKzDhdicit5A44VYuT?=
 =?us-ascii?Q?TVTl97fhnuPtZ3/+jGuSO7EgfGyxifYR4Yvf3nOH6vIIrRviNl4JxpxlCdr1?=
 =?us-ascii?Q?eSpHxk1F1YO5VjLSa/+rf/+yP+ucUAQGpURrFDY3GRAzwCW//c7KKp00cPdA?=
 =?us-ascii?Q?pU9n5tAsZL2mESS2FSCwiaPBOP6EXXu3G6WNodROhx/YhO1XIQK5Dppme36J?=
 =?us-ascii?Q?T+zPi2D6R8rDj51cSXmwnofvLVA3eIKMcq/BT7Su+L/lP2bTn2zMImck54GH?=
 =?us-ascii?Q?9qniuhzZr1aZ3bs1tyrRK5fKdD6JaA3gyGMKYQxvzxib6ZCa5NgiNalq7jkZ?=
 =?us-ascii?Q?Zo7+dQ+0YAMOf4Ap0rbGN72P4h6xf5tuQLpC1xDFb4pyic8W7PMOBzjQk+xf?=
 =?us-ascii?Q?Fq+HEpPwgNrGaGsoxR4kbg9E7x7N7F/yeFXsrHYKFivhsjLBdDduRnQ8wL3U?=
 =?us-ascii?Q?pR4RR1O8w7gkyMh94UQXXN6arMBopE23NJrvHBFyIcquu4N4p5w2/GU+9AbN?=
 =?us-ascii?Q?3jvXqvXGMTYDG3ClucJHue5CrwsKqupXbsEiOwA3eQI51tAK9V/kRp1FQHGz?=
 =?us-ascii?Q?b7VfpNpyETSDpq6M4FIMAKpphb1R9NgRxn6AT+WhXSqxDj788ja20NZN4Ts7?=
 =?us-ascii?Q?/nXC2zSqxiRjtmWJNvF7e+zGxpiP+OUYtgr2ipTQMvjgubJe7/GcOa9xbxoD?=
 =?us-ascii?Q?opbw02otkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa83bf02-51f1-4223-2d69-08def2efdf55
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 12:48:39.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpdtwQlOJgugqzbLb80PHStx8gzIQBv3vHIqCMt+S/8mBR6poRkv83j6CcEPyEP3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682

On Fri, Jul 31, 2026 at 03:34:25PM -0700, Mukesh R wrote:
> +struct iommu_domain_geometry default_geometry = (struct iommu_domain_geometry) {
> +	.aperture_start = 0,
> +	.aperture_end = -1UL,
> +	.force_aperture = true,
> +};

This should not exist

> +/*
> + * If the current thread is a VMM thread, return the partition id of the VM it
> + * is managing, else return HV_PARTITION_ID_INVALID.
> + */
> +static u64 hv_get_current_partid(void)
> +{

No, you cannot transparently detect VMMs and link them like this. The
VMM makes it self visible to the iommu driver via the viommu interface
and you get a kvm FD to fish your partid out of. This is hackery not OK.

You should come with VMM support as a followup once you get a basic
kernel-only iommu driver working.

> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct hv_domain *hvdom;
> +	int rc;
> +	u32 unique_id;
> +	u64 ptid = hv_get_current_partid();
> +
> +	if (ptid == HV_PARTITION_ID_INVALID)
> +		return NULL;
> +
> +	hvdom = kzalloc_obj(struct hv_domain);
> +	if (hvdom == NULL)
> +		return NULL;
> +
> +	spin_lock_init(&hvdom->mappings_lock);
> +	hvdom->mappings_tree = RB_ROOT_CACHED;
> +
> +	unique_id = (u32)atomic_inc_return(&hv_unique_id);
> +	if (unique_id == HV_DEVICE_DOMAIN_ID_S2_NULL)	/* ie, UINTMAX */
> +		goto out_err;
> +
> +	hvdom->domid_num = unique_id;
> +	hvdom->partid = ptid;
> +	hvdom->iommu_dom.geometry = default_geometry;
> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;

This is the only place that needs it, and I somehow doubt -1 is the
right end value since that isn't supported by most HW.

> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
> +			       struct iommu_domain *old)
> +{
> +	struct pci_dev *pdev;
> +	int rc;
> +	struct hv_domain *hvdom_new = to_hv_domain(immdom);
> +	struct hv_domain *hvdom_prev = to_hv_domain(old);
> +
> +	/* Only allow PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	/* There are no explicit detach calls, hence check if we need to detach
> +	 * first. Also, in case of guest shutdown, it's the VMM thread that
> +	 * attaches it back to the hv_def_identity_dom, and hvdom_prev will not
> +	 * be null then. It is null during boot.
> +	 */
> +	if (hvdom_prev && !hv_special_domain(hvdom_prev))
> +		hv_iommu_detach_dev(hvdom_prev, dev);

What translation does this set? If it is anything other than blocking
it is security broken for VFIO.

If it is blocking then why does  this:

> +	rc = hv_iommu_att_dev2dom(hvdom_new, pdev);

Attach HV_DEVICE_DOMAIN_ID_S2_NULL ?

> +	if (rc == 0)
> +		dev_iommu_priv_set(dev, hvdom_new);  /* sets "private" field */

The only thing the priv is used for is release_device ?

It would be better to have a 'detach domain' as the
release_domain so you don't need this.

> +static void hv_iommu_probe_finalize(struct device *dev)
> +{
> +	struct iommu_domain *immdom = iommu_get_domain_for_dev(dev);
> +
> +	if (immdom && immdom->type == IOMMU_DOMAIN_DMA)
> +		iommu_setup_dma_ops(dev, immdom);
> +	else
> +		set_dma_ops(dev, NULL);
> +}

I've forgotten now, but I thought we had reached the point of getting
rid of this from most drivers? amd and vtd do not implement this, why
does this need it?

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_domain *hvdom = dev_iommu_priv_get(dev);
> +
> +	/* Need to detach device from device domain if necessary. */
> +	if (hvdom)
> +		hv_iommu_detach_dev(hvdom, dev);

What does "detach" actually do? What translation will be in effect for
the device?

Ideally you should set the release_domain to blocking or identity and
arrange things so that is enough to destroy the iommu attachment. But
I see both blocking and identity do new attaches so IDK what this
trying to do..

> +static int hv_iommu_def_domain_type(struct device *dev)
> +{
> +	/* The hypervisor always creates this by default during boot */
> +	return IOMMU_DOMAIN_IDENTITY;
> +}

That isn't what this does, it overrides the policy set by Linux. Fully
functional HW should not implement this function, please remove it.

> +static struct iommu_ops hv_iommu_ops = {
> +	.capable	    = hv_iommu_capable,
> +	.domain_alloc_paging	= hv_iommu_domain_alloc_paging,
> +	.probe_device	    = hv_iommu_probe_device,
> +	.probe_finalize     = hv_iommu_probe_finalize,
> +	.release_device     = hv_iommu_release_device,
> +	.def_domain_type    = hv_iommu_def_domain_type,
> +	.device_group	    = hv_iommu_device_group,
> +	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.attach_dev   = hv_iommu_attach_dev,
> +		.map_pages    = hv_iommu_map_pages,
> +		.unmap_pages  = hv_iommu_unmap_pages,
> +		.iova_to_phys = hv_iommu_iova_to_phys,
> +		.free	      = hv_iommu_domain_free,
> +	},

Please don't use default_domain_ops, this should a new struct
hv_paging_domain_ops

> +	.owner		    = THIS_MODULE,
> +	.identity_domain = &hv_def_identity_dom.iommu_dom,
> +	.blocked_domain  = &hv_null_dom.iommu_dom,

Can we call null dom blocked dom please?

> +static void __init hv_initialize_special_domains(void)
> +{
> +	hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
> +	hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
> +	hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
> +	hv_def_identity_dom.iommu_dom.geometry = default_geometry;
> +	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_S2_DEFAULT; /* 0 */
> +
> +	hv_null_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
> +	hv_null_dom.iommu_dom.ops = &hv_special_domain_ops;
> +	hv_null_dom.iommu_dom.owner = &hv_iommu_ops;
> +	hv_null_dom.iommu_dom.geometry = default_geometry;
> +	hv_null_dom.domid_num = HV_DEVICE_DOMAIN_ID_S2_NULL;  /* INTMAX */

These ones don't use geometry. Didn't I say this once before?

Jason
