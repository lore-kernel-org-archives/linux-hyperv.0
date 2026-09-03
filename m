Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997D4B66DE;
	Thu,  3 Sep 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446570; cv=fail; b=YIexjNwHSWR1OG3SVoJQu2uWegqolQFdHsBrgu8NFbhY7g96fwZJR0l4q7lRkXAIGpLQ05rSatbAadqoXY36O9Ely5ItVY2o4SeRkEObiRTbKLmEFljiksNLnQUtvhk/c/dsGUr8ptJcv/XAUaTsLGLRJlzjdfCeyqT3bQVDkDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446570; c=relaxed/simple;
	bh=aXtaw7cnug5WYtfA/Wd2PeFkgteYKyMMFQSooszHc6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F0zgOlXgtNfFz8cd1Farx83YMUwFCYO5hJpCspZV6gZ1k0JaJfnHdBp7A+pQTjxtDoMcWgYt3MXQVT3aks+6EOsgHEZdAquemNmMs6RDmdDJab8V9XT2xoE2TnN7FNo/GqIWGYTVXtu+s3Ycsrb0RJ+tn6RMk9fV3pzjgHr53QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJxCMz5j; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJxCMz5j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehGJRdFy33uY80pGqNhE3eOBJb8gnk2QHixiUGuhzxHMVEOmW/ZtvWH72xLgHUfw1vhxc3yNEdajz3UpMW3J2Kg1wgdBypRD3c4lfRQXYB7tVuyHBLjclQ0/TOlvs4R2CQpwbD0/BeDEvMJSdCWpVL3/QXFLlLZn4gl22o/DnApycfJ46PVES70G8uYwnR/h6liNnOmmazrwjfbjf72faw2OrELg3CjU4PEtBrFdbGB3vtxw9ZGWgAN4zU3iuuPF9dvh8m2gYERnnLx+3XdweZip34PFSNX5SkmvzjZU1jG6bC2xGL2JWH81zTu4lu77LBCMq856erPm9CDCqMLmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXtaw7cnug5WYtfA/Wd2PeFkgteYKyMMFQSooszHc6k=;
 b=Oi3m61oS3quhUy6DetI8iC9ALlDLprpCCWw3ShMehoHCebcvXBSnuWzBgcYVIB+vrDVPQbC/WbiWsy6y/dvgXB3CiVLyFadh6dqmHcvFHfIEhORXj58bJwq439D314t5RjJDUzBnIHFAskXqYSRP3u5YGXgivstVBj1oVte/5UJ7TxUl+dO7vF+kPJUl8B+SD5Kol4wqsg+0pSyXv4mahNO/7mAgzRNgLjndUoXa5ic86xtDZ5QAZisM/UhkKz0Icw0Mt6kdKjmRj9eLiI6r4BUP8t3TsP+9xyntQBGN+FdFRA2/JgvvyPlY/Yyz0hDaorxejQb6jNcPNrKNGOTRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXtaw7cnug5WYtfA/Wd2PeFkgteYKyMMFQSooszHc6k=;
 b=SJxCMz5jnZlsyIphkZoj3FwtNu+VT2ySC/0JmiQ1ClZo4AjLjvoHwj38VFoTE4hqNfMXXfBWI1KpzpWeNzBsffzrxCLtbTJ38Jp345EIH2uqIAAuCOqX/8YgKRji2zJ1JqH7Vdjty91+5vYanh/ssbKIk23+Bgg0RKzx5RkdKGLs/dx625YD/w/V3eruAtNZ+DFAQJ2zN6u2WtSHzj11/wa1xNHTxPcluC3O7zoN7S4m1XTVBmTyIbQ2qNtlZ0w2wwjn+Wn7IKNFiXj4CeibXRbOg+b9VfAlulkrd+DRhGMUuDJ8GZf6EQ8g0uhjWkO7YCb9YEwGhtEfPhBzww65Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 14:42:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:42:38 +0000
Date: Thu, 3 Sep 2026 11:42:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>, hpa@zytor.com,
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
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for VFIO
 to build upon
Message-ID: <20260903144236.GK4157646@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-4-mrathor@linux.microsoft.com>
 <20260902111905.000079d4@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902111905.000079d4@linux.microsoft.com>
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c3f93e-3f9d-408a-34d1-08df09c99923
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TgAwAiTKPL5U5G3tGdxNk6fby/ebrgshEWYqhx+IASxz8WHlSL3rxU1vikf2wYj3t4irngc8vyjVry7PDbzpvTdvH0ICiG7wUXR8BXi9/gHvta6vkMaiosQicnWvJvId+rXDsU8ZGwLm/zv3/0u+pABVouKyiLb3PFrgk3Ch54rW5lXcNBXdEpD3EIz7axY7iJ6VIOIBuF4kK791ESIK+jCrfB4rIPUafCh32zeV1j07QtSvgI/Evqfrbyn+DoBUyNaYiXDftZIXyKDc0em1H1OKkBUYrN9ptt8ntIz9zEqf/Wei3FBsdjw+ojFvDOMhea7CYHIBq5Q79/LGLDXNUpu0yKmJM+jPecV0ndrcVM5W+0lCJUBdUkBCzJpVQqSi1NkZ7JnvQstUIQjhInyxBDryc8uU7sHDQfkNenoAGH6zYb0xXe2V62XDCvFIktYjEEP07/hBDVaM6XJCg6jIWg5hkg6rqPSilSZSaQmpIu3RvE321iHq7tOhvJVx6YIrYEcS1ocD2B2VKIn7uZ/9Lzc0+Rvx8bcNwGpQiv8MpfgTxS3k2Nu2bRTvMlY2eVbr27KQgbt5WsWsdmO5rFN/L5JBNJb4YZhA5ZzcxBKrECO+W7tFV5yDvTZoao+Yg2YARkNmbK1lFuJoXBtx5B63BhiJInRj77ztd0V2mNOBmZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yePXdVtAqfPtFz6lierpGeDecu+qsLw93UcOw75rBK0Mfd/ZMgbFg7owe2Pp?=
 =?us-ascii?Q?M4Vqeed2o9XgtyMjS7HMOl178C402nSOshTQsD365DuwY0SfQldHtYPWPF4E?=
 =?us-ascii?Q?sP0vWuxdj11rzzh2/v2bf4e/Kyh9okUwZpYYhh5x65Y6Mt/jc0cMpPqI7qvJ?=
 =?us-ascii?Q?Unk8S1eMIDqHnOkaMMXVoPZbG9z9weBQZpEy5T28bfH8UKRzAL3ZUCfM41cq?=
 =?us-ascii?Q?b334dvL40qGL9AxzbS3AfvCe/RCxb4E2tSwxDA3LG+S18Q+m2DXWU2+6bSGK?=
 =?us-ascii?Q?FcZeLqP3W4B+rFAANY81vcDhNiuuTOaisfA2zj2Pd3WXNM+GEBHISpyAGe3v?=
 =?us-ascii?Q?Pb6cHCR7X0I6ek3e4j86nJS+e9ZmNIdrJIrrwf/RL+1JknEDQT7veqZx07Cc?=
 =?us-ascii?Q?vZoPV9mcftYc6IHlOjnlY3Mt9un7IxTmUWj8erYSyJmWBDqm/32NuKu2bmAs?=
 =?us-ascii?Q?hEMEJg73xN1P2AaYl0NMZ3/4w+qAzOp7Uy/L5hlj1Bq9I0L4NjkVVzwQejZm?=
 =?us-ascii?Q?3gdRocagTPQhDxzNhmbffHDdbE6q9UoafNXqqpCPTUUOz0O8AdNXmnV6BCeN?=
 =?us-ascii?Q?ozKuHnB2CoH5MLtcyR/tJLWrvW6mQCtVWl9JD/9t0XTgN6MQ4QcQurNJwZer?=
 =?us-ascii?Q?KxYpJHqEq5PmITGLgDluOZq7osoOWOjB/jTzhmbw75BJQ81d+KFTQkgTUnUY?=
 =?us-ascii?Q?AEqpg/z/zSaT7F2pMT7sdUPAguWaCZaDUtfSPf/GwmbJZxTEHNHjJozVV1xF?=
 =?us-ascii?Q?eTWqymqzbblH1HgHDTTzGUFb2NI5f3Xs0/r8FEhAxSnXdV809VFcPaf3mTzu?=
 =?us-ascii?Q?K+fN8KWCp/8ehwY083KbSv5WgAyHl3h5VqQCcUNk3frbkCF8vju3hNVSFwB/?=
 =?us-ascii?Q?O5Cs99jF52te0UamahlAoX/mhRS9EaTaZWNeptDRqViCggWjbHa5jIQWgEOm?=
 =?us-ascii?Q?wx87QmVlXSiu0plLKRX20FLX14DaM6E1SCs8UDHvFsaJfl48Css+LGUceLTM?=
 =?us-ascii?Q?mj8wALUNcK7yfP9iSUvvue7UNXMXoUlLpoR8yVtvY0XkhXZWXVmx9UGHbib5?=
 =?us-ascii?Q?80DQuz70xCItS0FCwGjgNYM7BRM2eV/WEktwr8+RueLONzI1n1SWFGKZgjjr?=
 =?us-ascii?Q?FtzkCDm9WTNrVZO1g3OAVYFDWAkkpgv4NiArenHg8PkwhiC4xhoBqFodHs9p?=
 =?us-ascii?Q?tLw3tjtM14AVgcXTsIiztqiumubrZ44uP8wgEcQG28zcyaTM2XE2Qo+5LtO0?=
 =?us-ascii?Q?newaOniWCJuvtSNI3g75XQVu+XbXDeTBzs32tWOw2TmVFBOVAO2GlIhmejuA?=
 =?us-ascii?Q?mRGUfAfwxehkagMm27X/GmB1QE/OHMBzhXjue3278w2u+8QXbL+cAbsC2tKT?=
 =?us-ascii?Q?2MdMCI6OXtklFi2NjeGpIoaQVy30pmKTS5WWJl17xf6zE2xWcslTBwzb+8CZ?=
 =?us-ascii?Q?c1b0P2fqvFCogW+s2glrIUe55CzBp8HyYoHDgeG3ReofZqxLDXdf4vToDuLN?=
 =?us-ascii?Q?jWwBnHROC7Wkm/NSRCvtpIXMlJPovfXrJzag2a81iw4+h9zQvdvTPUyFDiIN?=
 =?us-ascii?Q?O85c3JQEfDud0dpM3LBPguEIx5dezCONCYTosSyxqonSSHZ23bocSMcjlTfI?=
 =?us-ascii?Q?j8jHvbKewyGkGSQhK6Mhb1g8QGPI3CO/BRzqeqePi1hV9NUXPBOB8LXC83Ct?=
 =?us-ascii?Q?yP/8RXhMq+vFPYfRDULs4TBAVOp9PTAgWDsE9uSmrU3NKUcj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c3f93e-3f9d-408a-34d1-08df09c99923
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 14:42:37.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b27IHUWkM1IY9q2aQB7YElX9UiKDyZMS77NQjC2TS/vUdWJIarM3COMpQKs8aknZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702

On Wed, Sep 02, 2026 at 11:19:05AM -0700, Jacob Pan wrote:

> If we do want to support this kvm-vfio bridge semantics beyond kvm,
> maybe this should be abstracted as a generic VFIO "hypervisor
> partition" association, with hypervisor-specific get/put callbacks,
> rather than adding an MSHV-only copy of the KVM hook.
> +Alex

I don't like this patch at all.

I think we should try to harmonize all these sort of "external" cases
as best we can. mshv, confidential compute, xen, etc all have a very
similar shape.

I am discussing here with Aneesh an approach to use the viommu almost
exclusively for this.

https://lore.kernel.org/all/20260902235609.GG2890729@ziepe.ca/

Can you imagine a way to do that for your stuff?

In that case I imagine the iommufd vdevice create is what attaches the
vfio device to the partition, not a seperate ioctl over in some other
driver. When the viommu is created it knows what partition it is
affiliated with because it took in a FD that describes that partition.

Does mshv use KVM at all? Can a kvm fd describe the partition?

Jason
