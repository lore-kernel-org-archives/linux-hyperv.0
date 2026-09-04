Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5A4CCDF7;
	Fri,  4 Sep 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480614; cv=fail; b=azIdqL+HmPUEhoBXRCMUGSNIAp2tmc18hpSgKl9uTMELaVZSkUv3E6wL2GHAlAMUtVjKpdZsYdaJQrRE4PNvdYe7nHDVvrR7CxDUSmGcqwgEfNsIDtektIz7BZJAfNTkB+0Pymrrv77mXsx1lT6vKTdblxsd+6M0nypVI3MRDYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480614; c=relaxed/simple;
	bh=AaypQ6c/4i4Sh4u8jTjSMNCGY82+/BULaoIpeldpVXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfE9CqXVR6VAcUeM+oyg1IEaX9Q2d9QsylEpORRxxvEet9E4NUyWhTcjSPw1Q7eEcKAccK2ucy9uKPBtZlf5otx4+h2i8OjDI1eWD8putAOIhgnlbf1lYtTKGD+yGEyE2thlw2J4+IZ2hvNvEYAKvX44rIf8MsQxXZcr5LckC9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZkww+DG; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZkww+DG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjzkHeemgs5vhJldWbc6LFrxRznv2o/blMlyu6/Fq/2MQQMAXZkfKb+J6UmrVeFtZUsHs1PwuVJypZ9sGj8JJ/38ECUL/SSSTjkaVdjQfbUhtdijD1rYd++9dI70EVoraQ6MaDXiwX3moALBdUnqTJyq/WPg69YL4cI91D68lxy/xb+PU5HKNh/K9tD3tod/gzLzw0gqHNchtq2Wgs7GKW5+0hevly+jVHErF5VOv2Ien1BQn6CYrqgHmHycTwWWOhx7BzvG8C6HihlA7WowowAhVkxTzsGuu0lcQc9vJy1zou9xB70VCfKe/A4QWHyoLGNQ/vOGNknCETH1+jPNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUUkUsuTQzbDUcN7MyzcGD5HmTAucklv8wznb5Nbtyc=;
 b=pJomfzYZGoO5DokE+NsUZc3GznD2Fpc2IpHqoNXAION35EjnnHnvU3OCJKt039L90Smny9vo3b9pu4krp819GB8VWIZdq3tO35frM86SHTRWI9ldlPyKkoYI3XlXjYR0O6mZqXiKN1PXxJ6vHeaqFinyr3jkqypShpptRCSvZvmxempx56Xq/c9xy5dEgFI05v5E6ZzWIS90KaOUSHW1yiUeVeGTCoaZE3wZ99Ji535gCfrE1ktkUnKN0FBzi/Ajkrng3d/lyHYYgnUHsqNrxJw6VODWkE6zV+caBP9VpuZapMt8emffXHiB65rxrcpvfDK318LFpKpCI7RNyiQEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUUkUsuTQzbDUcN7MyzcGD5HmTAucklv8wznb5Nbtyc=;
 b=CZkww+DG/7qh8oLmLIO5aDPySZP45HojZ0IN37Uibt3a3zpVSRqcX6k6gN3ruSqXs0ZL9Q7AHu61LXdPQprQ9J/DwT7sNA2nwitDaaRuBRAU6RZvNjMCqJ/3Dl0+tAh+sNaA70Waj0VITrR7AGuvOV6Iz9X9Jmu2DSyFm810Kf/fumtVZGeYTwg/QDhMZ+ukgXT+4VvqOHB2yBd2l6vmF/Q1y8J+Yv1P3nywMY3ko9Euf1ARzR0IET04WX3sSlNuLEfh/G/JvY9Fr/mcoj2mkzbH13/WFP6I8k7Qqaa5hAxTVtp0Xgpf7xC5ksVGRmCkL33NZE1RQ3FEvYnLueslug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Fri, 4 Sep
 2026 00:10:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 00:10:08 +0000
Date: Thu, 3 Sep 2026 21:10:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Mukesh R <mrathor@linux.microsoft.com>,
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
Message-ID: <20260904001006.GO4157646@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-4-mrathor@linux.microsoft.com>
 <20260902111905.000079d4@linux.microsoft.com>
 <20260903144236.GK4157646@nvidia.com>
 <20260903161328.GA3102631@liuwe-devbox-debian-v2.local>
 <20260903174014.GM4157646@nvidia.com>
 <20260903114647.00005a1f@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903114647.00005a1f@linux.microsoft.com>
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: ae02a7d2-9ce3-4383-f714-08df0a18e0d2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ZlqWOFYBgGecFpeSaJKQpHyZaemVcLrojKXN8bS+qtUQ9k0CXbTsEoHAO+cH1A5Y4jjfxUGVPoZ/68kiQ/uh/fXks83Qyiidxv35El8sdVX/VYsTeFQiNNvgfLH8QZnnBOO7wRHIHg/IDNsuw0+Xn9EKc3hyVcPHXj3+JtFoMwUhkPbdlQbseVORYvAcZV46sQQ42Wxe+kkspu42euPlp5lKYw23xsML6o6Mf1xRBrL8AHzFGKRpJTSalg0wu0BSCh9whZO282ZJpAByXyccMiGwKrQnnXzWv4XWWYEfIsjPOkj0XiVO3SBZS1A+qMvtjc3ipr+WGOgXAlf/g+kpm91SMIIekfEJKue7Wu8RezHebRjx17JUuqfy5Ap6q66DjeTUsPdCCVPW8aOkhkMwePUx9G2bbI1PaMm9x/zVPLdJ+raELLgVxEYXr6fOL75c4+AfziJCMvWwH1UGyL1tDLpciJxrQYO/qB96eP9dbLP9dz/so1PRP+gukczLJR9eg8aUyr7FhiC7FJtlBcFYp5XnRX5XTJX8cUm84fLyROrL6gOzDwIJ0/d8egqh2aHMG7vwkR3+KzBok+XWiPisRYKw0SokYcJjZTSyOM+Z2a9XU1+nwtzxLAl+o9QT7U2Fb49N+CvG7SimMxJTsPkkipaSz4PrUwBPwWCYw5kHaSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8s8kxERyAqkOqW4fi6BWmEcXaqJIyFUc+qWBdTuzCnSqgfKHJwqhzZN9EJ4H?=
 =?us-ascii?Q?cuTOdSSqUDKLLC/z/Plq904+5L5hETvYOqgSdSMy0DtgSywXlWJZ4QcSQq5S?=
 =?us-ascii?Q?IIO/hDg/ViQ+w2UUzlWXUS2PnJCqyQkzsnsp0L1jbAwf5JIG+niWpf93HQ5i?=
 =?us-ascii?Q?7TN/ZLFAjjnqaueYKGuhWWJovvBdrN9sKPMS5Z3OUJkMUKXvSOZShAGXOCkv?=
 =?us-ascii?Q?EQGB+eiOAs6PvVr9oFnGJrFWOLuBeuRnySOYPcVbk2d6YBxGwTH8rYk7Z9sR?=
 =?us-ascii?Q?0mtGtftQFqBL0WqFWmwsRW1DNHDAqRoi7gmUxige0Wa/RO7LIUBrlbkFmDIq?=
 =?us-ascii?Q?Y9ZCgJjeHnhXHrIGjiiyZxfnsE4FVO9TVWXNPMnOb1ao8j8WTC6BxSb/aFMb?=
 =?us-ascii?Q?lQ8gbxF6IakEhHIujr7e+3lSdo+7EiknYYXUSWhDtjl0OUoACtZhUJI9i+zS?=
 =?us-ascii?Q?1l9ar4gyhN0q8W9rMK71OTHYfS6T6Neq8ID6PrNrwjwysHPiXdCvRpCgTM5J?=
 =?us-ascii?Q?jpQBue9hYAn1dingBzDrZGFFPGUVbriX5xrh4cCiv/W+SveMd2VvwDIZJCkM?=
 =?us-ascii?Q?7GrucjFn4TJRfSXt3HOXi2K1AJXnsrzCoiRgr0Z+lKDKeloqaynn8UFI3ciO?=
 =?us-ascii?Q?8W/ZElEYE+w2nJ6BgvkLu98HdFC+H08BNpqucahB1uUL7Nko+pxTpc1i4CJj?=
 =?us-ascii?Q?ukrroQ7OUOg0z5cdYKGiH/gCmzvZ36nyFGu3Pd2GvAphRcokHZm6dVGRMF/A?=
 =?us-ascii?Q?tVjxDm2N7LaUYxTNKAr+xcdakdkoY/MxVrl4KYSNl951WPSQ5DHDzdINxDeD?=
 =?us-ascii?Q?BbXj8zrrPivAOr5Jc6yP2Z1qfDcDti9njP6pHEI2n3l/blRXJxNm2HaTG6Td?=
 =?us-ascii?Q?gQIS0nfTK5DCkaxpfYb8clN/TvedvoZOFPKurJDf4oV7mIlEId4Bcj3VnjYd?=
 =?us-ascii?Q?guG4qDI9H6DWTZJREdM1LgHdwAvNFIpeSRyKwrafDMNFf6vDC4ESlo7dchO8?=
 =?us-ascii?Q?xpspVUl02M9q+b2FNmtbm7FxFDaPtfPSD04O4cwgLemb0cmfJjXrcLFtNqy5?=
 =?us-ascii?Q?JYruGe/OWgkZC7/fxbk/CIp4+XLcfrwUeaAeszy06wuZQ7gqQ0hWdiTXDcl5?=
 =?us-ascii?Q?7hXm+EsT59KZXNX10ThGWBsieUBZ0zfKnaMEoDTTxe+2ZTpfzQczvQqkMyfG?=
 =?us-ascii?Q?FlR7fDt8FBgMGX6bePAWMxpcJetVYrIZo8Pen+PWmK6N0+cAY2JDumhz+0sq?=
 =?us-ascii?Q?2uMTjYeKRvD8MiUNVKDOHoaW+EdGHLsqpVy0DUiNMzlMRkiu55p+JIebovJG?=
 =?us-ascii?Q?KRsfKfa21/0CYexbl7ZcQZa8t2RYI9ZwTjA1YyH+z4clQC1e06hbW4q8/s7o?=
 =?us-ascii?Q?OQSOufSDfZKLUKZfi5iFvMFE3CofC7l7rGPmuLr+4QFgJdal9DSKDWG2LoaF?=
 =?us-ascii?Q?X5f5ETN1EJE3T+tI4Yh4FNRGRxDd0gC+LZSOBfc9uHb+/4AVww9TK12SsLA/?=
 =?us-ascii?Q?2l7UqicQPVYgjHYdjZFrauBjEv5C5f/zC3Tsk8/IsgFCGw6IKAFY6RLZlvpI?=
 =?us-ascii?Q?V9bvysCxN9aVCk0aLEG+9HmXCZNvcfkrYD8xcyhNkkKw9VbEFhlffuPNIcQP?=
 =?us-ascii?Q?VhWHYCBd/+vmJJhSm4dTxtLvs8asvXmNi1PN/9omwX6qUIHqb/g9k9an7vS9?=
 =?us-ascii?Q?VRxJzWciX1UKQE3n5rqgk+/UgiM7K2iwWajsdNY1nt+cWlh8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae02a7d2-9ce3-4383-f714-08df0a18e0d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 00:10:07.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+dynyWlSB2VmkkXVfIM0O3DV6mypDKazBCHhPRSjQ6kvtVFcRTMkUw1E5IivAG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

On Thu, Sep 03, 2026 at 11:46:47AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Thu, 3 Sep 2026 14:40:14 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Thu, Sep 03, 2026 at 09:13:28AM -0700, Wei Liu wrote:
> > > > Does mshv use KVM at all? Can a kvm fd describe the partition?  
> > > 
> > > No. MSHV doesn't use KVM. We don't have a kvm fd. We have an mshv
> > > fd to describe the partition. They are different virtualization
> > > solutions.
> > > 
> > > In the ideal world, the fd should be hypervisor agnostic, not tied
> > > to kvm.  
> > 
> > There is a patch generalizing vfio to work on FDs instead of KVM
> > structures:
> > 
> >  https://patch.msgid.link/20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com 
> > 
> > That's probably a good step long that line.
> Yeah, ideally, it would be removing/rename device/group->kvm to
> something like group/device->vm_file?

Maybe it could? Do you need the file in VFIO land or is what you
showed in the other message OK?

I think it should be broadly fine to pass in the file that way and
hold a reference on it in the viommu object..

Jason
