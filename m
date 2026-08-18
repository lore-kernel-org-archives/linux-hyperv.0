Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073532B110;
	Tue, 18 Aug 2026 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096927; cv=fail; b=L6iWLGT0ea8GgwFww6x6LBK2mg4gx6WlFiAuXPMwDGTixqnIchceDOuez3skS+4AcbKYGuVeEBm9b8VOAnUR8T5fIQyI/CoMPFyoBfJh+SzDKUhoTgrd54WqMn+aG3fKAdBjf91wbFAQjLvhumD5bC6LYPejOSHn9p2O0b52WL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096927; c=relaxed/simple;
	bh=9XrlD1uJ2VEa6DB5P12cG2x8OHCUr1VC75vf5syT0JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P6VEPhMjsfO5OGNC3J6OmxpVpB19e4+CrvYNFV3bJj5zQsh2QoV5JRbIOGtgdwoAKwbrPyG21KDEWDxkb4fsLXLJ5AHYMjsVhSSvcRqU9jYR7h+FANF4zxCxFA24qaWi77AETAp/RHV5O8AJPGvbxlIpIaWeUIhqe6wMGWRZVYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qbo4hsH+; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qbo4hsH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqZPSJ0lo6HHHw+vzDWtqh5+EWcgPB+DxluxXK/rpYoOo7lRNaYKnWMiFun2yCHpUT0JCefmzBgwM4gCSWhRMi8P7iIu7x5rYqhI2n70jO49bMvoD3UWw2jopcChRt5+C6ZYEhRrZs/pkLA5FR5+WeGklv7AjR2XiWrJmSCkMfSLp9PFc2grvNui5mWdEVc73oSLqIEOjhPsiaWXUl94NIBkhgwsA90A3jLOKPgIXCGDcAVReMZOlo7SUHE15+igSFGX6irInAXe2ZkReaNbkUWv9+pbtCld42EMCf/qw5qEkBTXIFDdRo9XmCUv2Xc+CQvUN9guVYqPWnnm98wMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XrlD1uJ2VEa6DB5P12cG2x8OHCUr1VC75vf5syT0JE=;
 b=fMUaPtg1krlibXsmKC0CTfzW9rk7XiVBRHgzAd+ZD2uorjBLouNhZ0oaZTNPxaHMw8qtsZ34rN6iW2kV9Qhx+IupWbPcS9f1N99GI6twU1HPTS0F5k3fKQEb7T6zLUBaAX31NcUHvwK6zHJ1iLYYbEzhzqz0Ruyss2PxXBLnG/Rbs5P98DWYVvik/PIuNJwriDzu11pU6CBIUjR4heeJ9tPKqMAPbXSfJ7EdGHfzYe8Ec4eZATCBg9Lpvi/aA/wos7ZX7wd8NJv9z3wCMHhfNovrXSABhq867dRsHXTi6FkEq5wW82rna5Hlm/MtL/d6foHw5Kgl59eggMJ8szNonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XrlD1uJ2VEa6DB5P12cG2x8OHCUr1VC75vf5syT0JE=;
 b=Qbo4hsH+1wtYEhdt66trWWATOTVgaNHpRQD3hvAZg3QmwsiTE93b6U9yU5rESlKKmd3KXoMGfq6fYcepp9TnouNGquMSMHQpnt2xE0I9No7nr67SUxulb/VtmLIKBHJCX+tLl+b92keE78hiU6fd2kDgC9OXqCpebsBfMnM4WvRHZcfPQPvjnp/T4nJYj2QUFAYbI1NRNpdOEhOmNgAISYIIiHSjK8OxFFXYZiKRvmnokAdGazeRfpuPj4PKCZ/J6dn8VhtgkhkUz+uBMTHI1oZL44zfo6e2R9f7Lypm8rgNQaZNbjfLo2KFntPypM/O0HmV/S9NzKnICmTb6H8Xqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB999228.namprd12.prod.outlook.com (2603:10b6:806:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 23:48:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 23:48:42 +0000
Date: Tue, 18 Aug 2026 20:48:40 -0300
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
Message-ID: <20260818234840.GA134244@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
 <20260805124838.GP27883@nvidia.com>
 <269d79fa-08ab-55ff-77c7-fb11fa2005d9@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269d79fa-08ab-55ff-77c7-fb11fa2005d9@linux.microsoft.com>
X-ClientProxiedBy: YT4PR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB999228:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e76736-8d47-4d6e-9b89-08defd833bd3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+eh/mBk23/hp8TvBNQsObJ4/G6DVzr681x/2bE/WnrPkP5MlT+6+rSiX3cwQnWAfHs1IwQdSvAFXYUawmza9D9SkG2mMLPsfDQ6/ogOCFUjGGKA4DAN2f5uYIsm3IDbwx2ROJVUCkhtxiqCBhovVlzfoZtNUEW/ES0XDobCiTU4sNRUc/5yNMeBhosnjqF+3RdED50YMC5d2zQ0znSWELVXtOWhmZxVU1vB5pFbljmlllHzVP6cBOMKClkKaL4n6cJEtOHJ79cr0HyFOAAO9bqgPq4V9TNkrUFYtLMKfxRosUljDeBztwHmLTZygo14t/70ztFALGLontjXKA4E0IzZiMUX4yC/McgfbQHCWcO8F32ogWqLxtZKPW7J0sUA9nRlP9H2SUAmN4n403WgBUOjdsOItL/JLbfrlE9st6yvEe61e4SYADaKl8m8C9YFS6cFLwTxXXsnRwQ0JzQyt3bWMLaMid4/8d8w2+ZezuntZNGAZ62p03I23zk89qDGvNCPKmiisS9EhZixXsew9or42hwzXIfa33YLAcYXZbeqj/+O7Hov7FNepYijlDcOpUMNXm2IdGqYokjIjeIgAbP2+7n5ivbGkKp2754VJaW5MkVvWgbZI4llhP5yqoGrpazIDqqIrh78IaGAf/GbE8ilhSThLPPBgbSmNJlqqfPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJY6CCshQ6Y53JW8R91mmdX1honcJQsRCmXPjiUnDN36/WNy9uiqs0lKoLAp?=
 =?us-ascii?Q?fOWYyxn5fT47QcnqaMidS9zhKCxeXLRR1S5YgHl80ChaUPpzvtKD1QUWgD1i?=
 =?us-ascii?Q?TmYdw4Y08hGDpApT01i16oAAj0vd/HikUwH9cYLL7JQHH9tqA31gUvMab3Vt?=
 =?us-ascii?Q?JEZIkDCCzAUS/Ws484G1ffeILlFuoe6IHPS8LOrW796ulBo96QTftbMmldo1?=
 =?us-ascii?Q?VfS8OYFSsq6TaZhg7mtB9Z28Gxu4JLnl8w2BS645fSdpPXhe4tzg0JSAs5Ij?=
 =?us-ascii?Q?7C9OAyWmI4u1Owos0sWLDQB+EuZiuZnxAcArKJCuspk4TxNFocXniFBnfAb6?=
 =?us-ascii?Q?g4KqyRcXA3NL7vm+8c+yAuuH5v3+z5R8r9YN3xCw08y28GHEnlZ0YuQDXqoJ?=
 =?us-ascii?Q?D5Yz33qFYSz6S+q/3T8ZT5HmGgR37oWECU54caVpbKe8jFptYm+5LdMYx+kR?=
 =?us-ascii?Q?ff+U4PlQCZc3GNFuVOEOGP3azFCuEIK4VgTtOvsE+C0HtX2FGGkFhhj0uRf/?=
 =?us-ascii?Q?5Gsi/5fLA8cnF4WOvCKBOaN02SkmitPTgBYCb4ng+Hjg5oWXFbAGP1mm5ZGc?=
 =?us-ascii?Q?kXOYs18ZwfXDnp1sP7qQ8z5TnWbdxG1fJftXHHhCoWO4K2H0OTeuijG0mHBz?=
 =?us-ascii?Q?byFSmPNEYfPWkIbIzefhmJGvUQ1ooE305stqiabWRKAndacMlEIn2PabnkvM?=
 =?us-ascii?Q?z53MeohU+XeTnEWbDTvgEHD4s0KSh3OxUvILQbnyphVrmZInZD8ZCL3zSeVj?=
 =?us-ascii?Q?bA0JoDFfRl4X25Uc+RAC3TuO89VK0YGN9Tdkk2hKWbAPjaGt3A35HJth7YmJ?=
 =?us-ascii?Q?qwhhB3PUXff3m2Xv3yUqJ+BSX1GGQuDJlFbzfKYvWXNEARt44K0zaSNEnpw1?=
 =?us-ascii?Q?8okSZ+QNjSSULgQX7rggGkQ73GCuMBYNbMk0ZCyuQ5nM5AGdTPELle7hEJ2v?=
 =?us-ascii?Q?2orisKvuh1wU6SsMCQQ5JPRYjFX12AR8xT2iMZPRliBXHbmDYYgkatR3GStl?=
 =?us-ascii?Q?vLa0OFNgePSHyCKA6Gfk9ZhdV5mUagA9vm1amVtJRRrUyfeVVq3HSaj2X8yT?=
 =?us-ascii?Q?EUOK0KOkAt3Icev5mQRXYcaWT8XduwyvFKA/mrgjUSuRSn4B2kgy4ocT1etM?=
 =?us-ascii?Q?w7kxfI7O0xoCPrOZfJBZtJjJfAtG2ySHqrwKx83GKswj9MgqldJ/tzZK9gcw?=
 =?us-ascii?Q?CNxusgkzOadCteResot70ORsWbGohWu+8klZ/D0f7JYFclYvbAvQNjDY3BgQ?=
 =?us-ascii?Q?t1ww2LquzjJ/Yeho7K7mmpULgSd1xH0XYKUU7L/aHhgTNB3rgmduDi1ove/3?=
 =?us-ascii?Q?EPP2W+gPU5JDHtgq08KuCKdAkFMoGXgeXI6S1EZMIrmLfgG/9oy1iBTTN9Q7?=
 =?us-ascii?Q?CsU5Za1ScJMw7/BlcIlm47sTmE0gT7pVHjK8O9yUq2inT+rio73GI1pIupV/?=
 =?us-ascii?Q?E7dGUZl8BSTCsGo+CyKy6MkWe4yf1tsPBC0o0QlnlmfSSIGfJ0DSax1VEspP?=
 =?us-ascii?Q?xggHUY0rIWdqJlRLKTf/vRNMfUfpaj+YKzlPK0xDPix5XWQhFt5l+TQo4AZN?=
 =?us-ascii?Q?KuuPBLYSF9GwEtizZFwY/wXpzrqx1DBbw2Kyx0DQQn0ZUDb0/Kf2HKhzr0ge?=
 =?us-ascii?Q?b0HjBLFSJVXppXEB+HFafr/5lu3Q3KSw4cBV8bXO/+4Ywg7qbrivTbwmWpNj?=
 =?us-ascii?Q?UjmYRVglIaJL54COMZwZK9CVrvNIN5lICfMhAp6eB54MKf3w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e76736-8d47-4d6e-9b89-08defd833bd3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 23:48:42.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrEv1P4Zyw0+yK9QcGQ+CsqzB9fiV297vpa7rhSDZ1O5fnSN77YCXWZ6wV+EcVRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999228

On Tue, Aug 18, 2026 at 04:39:32PM -0700, Mukesh R wrote:

> Thanks for the review. I know there is another set of patches for pvIOMMU
> ongoing (both came from the same source) and you are probably repeating
> things, and I appreciate your patience. I'll also try to look for your
> comments in that patch series going forward.

Those patches look pretty good so you should try to copy their stuff
:)

They ended up never calling detach, I hope you can do that too. Just
always have a blocking or identity domain and just use it everywhere.

Since you can't predict what translation detach gives it should not
be set on a device. release could be the only exception and only if
you reall have to.

Jason
