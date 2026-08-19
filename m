Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE23515F6;
	Wed, 19 Aug 2026 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157187; cv=fail; b=qnKCGezmm1IIdf4fTpEHQTbZoRafqfF8r3rJ7linuI5oss8S3Grd6rmaJtsMFde5uPJV9iLEaGXVs6y8RTyB/yNIIITu4Stb5hsnp5nyFaJdDlGhfgP8NBYlZHyV9zyWaWQ2hqoNKd2sw0iORcdS/feUs6FpXqrDbgU1StInSLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157187; c=relaxed/simple;
	bh=lUOF7ZMRkPu/jpsyF7jgeIJUa00kw4aSILxGrJ+BoN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HvJrWzFAoaADiBsE9I4r1WARNZAYS33VudsRM9HfCGYLYCJhEkc/P1lY8Qfulk4xUd3CyR4stEeUwfu8qmBI9qi8viv57WtnjRi6+m4yIPRPNANkqgsmoOhms+vBtlnFT7Qt9ame1tQUYumWgxhiTJwertlVXwbE3U2M5YjGcGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qR/evaH3; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qR/evaH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcde5RaEFlhaUcfEqSGgAQdPiS/eWTj4WH6BNWyPPPQey9UA8/LHQ6JXgM8xhZBunhwZix9nUqE5v6ZiLZS6LElUu+nOh5LTJgk7KQrxAI8tsspystVl51stFAvYM2X4Qsvtx1G7DE/ooaMyeb7QjjIq7+1Rg+2hc3jh3Y7zPgJeK/ifPGUp1JEhLLP7IPLkfAYbkO0x0J+uGsXGjDFavwB88sYk2BScA6lE4hHBQTJOV/R5KWGf9brP2rYE08oEZbiL0amgNqnGeizaZswI75Ht2I5lwQVqmLsFihr1WKHWUbaapVUs9o/NAon8ol1zxryFCfMnBAAk1EjjovDRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgKhkH8u43cz5mIxgE6qrcW17Gib0RdDWwP2a58A41U=;
 b=XjkFEe8OGItcfWJ9N1dAdLORzINv4x9XXi0TWtRx0O8ALiKCu1Q+785Y/4TFDske1V3xoC1afT99dRm6cm95jLKY1bhlEs09VO2JGFIrdIXXhto3QcE1bbCxXEnBZMszzEymqlzDJK8XkBtakVIRX5kVyJtIxA6DctBCNfijmilCZQUIONwPlKflMkWF6lfIVYNGHZ4Clz3ur6pxMI+gpdyrwDKECz/Mp2bqGCIitvBXtLHjIK3bfGAUg4/GdveIAzHG9Dlt2hJFZO4v9hIwg7t1/8lZZifeJ8C5FAp9cQupJzMhe6rUsSebtGPmiEM/Xdi6LynW8SGLhkTQptWGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgKhkH8u43cz5mIxgE6qrcW17Gib0RdDWwP2a58A41U=;
 b=qR/evaH3uLgXx9Nd4QCJ6yM0I444O9GIxIxdaNLwrw2g7KWupewuqQtgur2kuN23NiUyLjOFALGpE2zF0cttihg6mNwEr4ga+R9ldA0c6BBkRhV5hja3pajp2FNva6vjJV057Hc4dmkmQho2VlHqxzZjuyRKxmT1EpyqIdMFaOws7Vd4DtKFBbZWAEsLxetQhUcOe0OJev7PM88hPA7p5b26pgsVOJwVLwYbmcjFWJzSTrIyiqJ76I9xNlmvdk0zj+b5tAIYryb/QvrYEHS1750Z2gYbUiLgVJzcAoYK63ymHEj7FevCvsynjKTyFH4Ei4sL6xqqzlZ14KU+nXtcvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 16:33:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 16:33:02 +0000
Date: Wed, 19 Aug 2026 13:33:01 -0300
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
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260819163301.GB244917@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
 <20260805124838.GP27883@nvidia.com>
 <269d79fa-08ab-55ff-77c7-fb11fa2005d9@linux.microsoft.com>
 <20260818234840.GA134244@nvidia.com>
 <912a5911-5b38-a14f-132f-a2d1d7c8f154@linux.microsoft.com>
 <20260819124652.GA200680@nvidia.com>
 <20260819092909.00003954@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819092909.00003954@linux.microsoft.com>
X-ClientProxiedBy: MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: dece6d5c-9b27-4836-39a2-08defe0f89c7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|56012099006|10067099003|5023799004|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4gB20QprfApgbxxtDlrIUzjXGkU14iFPHSz5A1px3CICCCdRd3nq3wCc/E2kKl/dCKQUXkn0shwgAX5FKvzTxFzYO4pnaLVobMHnkvusTV5VNUST6I0pxYUvrE+aUaJ3VcNEprdt+6gS9Q3bCi0VBH7oJeoANRrKmjIw67Z7cpEPE0TOHnKILncYz0/UmfzM4lRDznrLKppSUlrEZq8P+HvxcWCzCkGN0cOOOTG05ZgVxvzs/fuTO2rfSauGiejOYPMhNwTqrmcv0Teic6W/2PoQwAsfkU1++ywX2L4ryxv3wiQeBMR/+mYmFd8LW5/Mih0Zr9nL13dqUiWR92qMJslXebcWqLRrl1lqRxF9DN7VEaUTKXll+dW5IN7cnxp389Zwb8jWhgX853KQ1A/Lxx++wto7ypkfWd8nh5tQ1ERdJp8/NIsQ+rzCeXbJa6UsQKi63zlFTRu7pjq8QJ2Lul46IfPGje9frFSvWSzMdrBDnyGt5xiBWPRw5LKygPZlryftwDUY5LYFFVMLYlIQGXy5RFlMNkdbwo0jgudj5L+2AHWQ6+B8z92mONYgPJLc9bpfzRiwXinn/QMZ7TTcPoGcYJjmwjGK276q0QDA/9iw00+OnDLJDZ81vaaS0+MBZUQRM2BynAqpAPdXwFg5SvRd+g0FtYrZ0Jl7gBettCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(56012099006)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IuxTH2skcmsVJE5QVgRt+1UzWuPCpw0d8Ht9S5M3D2bHwOfmkQdhZ2mxFwLX?=
 =?us-ascii?Q?2trKhNwVchObA/eX7qa/uPPU3Pdtwrw7BPoZ0pVasFn5h4/H46vV0gB+joAx?=
 =?us-ascii?Q?9SNI5s6coVR92gAldFuXUDJaQbuCnH8QJuy3K0JvnHrL8G5Cy6zs/F+Ps305?=
 =?us-ascii?Q?jWMhMvpA549p0qoF1xcafp9zx7x3gZ3dzU342ZHGKYp/60BkVRkAM3W2OxHy?=
 =?us-ascii?Q?VOQci9ZM4ZnciGvxWzKNHl8gJ7UhLP3AIGaj6CjmbdQh7AVFfPx83VD6OwJ0?=
 =?us-ascii?Q?GHfD9MB2p2TyrI4JlUXH0zstmMxZSkDyh9b/n6K2/us6kKqdnI5jVoeowaok?=
 =?us-ascii?Q?+pF3zpHWcA8WIbZsYLfepgtTV443kkjY2RknN12mY9xX6uZbcDO4K+LklRtT?=
 =?us-ascii?Q?WMzUVCOV0mU5dftZ/6HtLIFfr0afWtc5LBV2wenDu+DEhYwyJgnX2OeTzGP7?=
 =?us-ascii?Q?H8xaakeSo5U9kICgOmWjevSz54Fbuu53BuQH5fMaqjUwLiVnGAYBL9V2sNKx?=
 =?us-ascii?Q?z6xP6Qr3M/d0dQyhPBkjmvCVUnlakVIfy2symanngEiw3F4O8ncqIpO1Bc8k?=
 =?us-ascii?Q?fFR/rLs/xPVBCtlSiagtRLQ3byiAoN8cyTJIBZpsDOoG7r1MF/wPt97L6B2l?=
 =?us-ascii?Q?zWf9v9qB3diqlbApbu1ji8ga/mJKln28SatT+CkA39AhhOsnYtJnYBMX6FCO?=
 =?us-ascii?Q?ja9vb02X2lSkKfBN/YSl/ODDGcU05ARlYphBPFBcsuHFX8LXh9paOuybxwfr?=
 =?us-ascii?Q?8TRA8qzCPkUOHMOYBj/IWmo6QD+S01v23lMitXWHvAXERkpEfDzkbmUddHby?=
 =?us-ascii?Q?iQxzR7iLRESui4pPHGS8eeEhC4tKZV7f6dV6ddhU84SOpa7xhLNLxuHTspFP?=
 =?us-ascii?Q?9bgWW862DfYkS8mQxDXbEsA6Q8uiW9HOXzgWLkMyMd+a6xpX6DQtfwFhmxgo?=
 =?us-ascii?Q?sEQqOWkSmANz5zaUCV9bfyU/u8jb+KkSEY+kxT2km3WO1nrpjSoH+njZsxdJ?=
 =?us-ascii?Q?HiN4whoR//w5rON1lZQJVQXWRW+OBz34GszVslQexzbaZzVBq1vKbVxHC5rc?=
 =?us-ascii?Q?KWGadsYpMkg0VPsVMuv2A21G38q48nUu1nRVDtcweGu39CIGx4Cyf3iQHE2L?=
 =?us-ascii?Q?TebvB/zB+3QlRak1Gl/vpbkvd8P0uqx78Yan8L2d3onj4bva+/J1aFJwmiPi?=
 =?us-ascii?Q?0Nx3BSE4+rip6P0EIYZSXDkpDR9MtjqetYV/i6Saw39JqYiK5NfRk+ajuv0k?=
 =?us-ascii?Q?sg+8KXDE43EABcGFjqE/GyZZEb3f4L/Oh2kjpgWpmGKysOVaEjBvZdouPulY?=
 =?us-ascii?Q?uqAANHg7p4nmoyESY7EROA3GD1/vEvLPeN1n7ERo2baOcS7p8VA4mldzQiVm?=
 =?us-ascii?Q?SPeh5g3LDXhQXNPpisnyHzX1Mwmaw6T6NephGgYApC8L3bQGFaV9EYd91n/Y?=
 =?us-ascii?Q?fH/pkBQB58Xa5mwTjJFPJjwpUJtScAIKlXrC1OYw0o37KCdX5tuwrH7HGVn2?=
 =?us-ascii?Q?4UgL40+GxiVYIDJXX0thdLW/Yh0pVQ7fUxOkvuPZE/ystsmfx9clYXbBwruO?=
 =?us-ascii?Q?mVxqbpXrqjeOlbyFL7ZfnELR/pyomePepDzHOjz29zc8cS8A/DukK5KNrdiD?=
 =?us-ascii?Q?fOoLB4VZfX6r9kwbKgSjmhC0lsldaltUiyBxuAi+Wo0FK4Xicq1TMFKPEt4X?=
 =?us-ascii?Q?+enVwJ9kSLMGU2K8N/AO0Yo6Wkhgq2N0DZ916DrI+rgrrR/x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dece6d5c-9b27-4836-39a2-08defe0f89c7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 16:33:02.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD3UO5sPwk3b38dXUjKaHDwBFplhpnJLBZngxPR1KrYnIOaqvOkUlQxJ2YIU0KO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691

On Wed, Aug 19, 2026 at 09:29:09AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 19 Aug 2026 09:46:52 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, Aug 18, 2026 at 05:13:29PM -0700, Mukesh R wrote:
> > > On 8/18/26 16:48, Jason Gunthorpe wrote:  
> > > > On Tue, Aug 18, 2026 at 04:39:32PM -0700, Mukesh R wrote:
> > > >   
> > > > > Thanks for the review. I know there is another set of patches
> > > > > for pvIOMMU ongoing (both came from the same source) and you
> > > > > are probably repeating things, and I appreciate your patience.
> > > > > I'll also try to look for your comments in that patch series
> > > > > going forward.  
> > > > 
> > > > Those patches look pretty good so you should try to copy their
> > > > stuff :)
> > > > 
> > > > They ended up never calling detach, I hope you can do that too.
> > > > Just  
> > > 
> > > Unfortunately, my case is a bit different due to the "direct attach"
> > > feature for guest VMs. When a device moves from say a paging domain
> > > to be directly attached to a VM, today, it must first be detached.
> > > But since that just moves to identity, I am discussing with hyp
> > > team if detach is really required, and if we can get rid of it via
> > > just attaching to identity/blocked first before doing the direct
> > > attach. Hopefully, it can be done even if changes are needed in the
> > > hypervisor.  
> > 
> > You definately cannot have it blip to identity, that is security
> > unacceptable for VFIO.
> > 
> > Once it is attached to VFIO it must only be blocked or under a
> > translation controlled by VFIO. Never something else.
> Based on this requirement, I don't see there is a difference between
> this root driver and the guest driver in terms of VFIO DMA ownership
> transition in the layer above the immediate hypercall site. i.e.
> 
> old domain -> blocking domain -> new target domain
> 
> Regardless of source or target domain type (e.g. direct attach as
> the target domain), the blocking domain must be attached.
> 
> If the hypervisor detach operation internally implies transition
> through identity, then it needs to be hidden behind the blocking-domain
> attach transaction.

The best thing is to do as the other driver did and just always and
only do attach. Hypervisor just changes the attachment instead of
demanding a pointless detach.

Jason
