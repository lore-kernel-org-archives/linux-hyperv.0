Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC72222D0;
	Wed, 19 Aug 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143625; cv=fail; b=nhB+/h4uY1r0JLaX/hD/J/M4odMDmSX4Nz6oRrdh9tIyLzzexx9dTJOKtEUkryqt5Vw7HfJxP3aHpwFnEdlkBZjx63jiOzx/R1lFgyW0G2SbIclqc1UOxmdMuKrfs989LsIot4gYbOkE0XUL/rLbYrbHjAAUW/hnhHXmuyZ4xR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143625; c=relaxed/simple;
	bh=OcspkWe6YU3RxKVRmydUZ1X7IzjhCLiQjGjasPWSKTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GM4yi0Hhjh8+GTpWgVkkc0OyDp3GWDKcFvfI/pa3o2q+51Gp/QvxYlp5F5WIE4i724H5L2Zdm/teynP9c2Pr8CIPGwi+My15MsRsBqyPAe2bgcB9wgbdoDmxo6wJvzlYyPzWwPuUMIKd1DWaI8RFMP+eCU8GvedinS/gHYooyiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BL6JVmHi; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BL6JVmHi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaDxl1P8BYDjf7Ki2Kkcd/2Q9EUsg736z6DU5gX8hes5iWyYFG40u3LMoRvnOcaaP8odxYfHfOp5sEFmq4AFo2ZUgRFWCIXNc86N5uRkV0h6erLZT+kKd/O1tZADq96oiacW3vg4bI79yQXP+KBqNs4qswnJ7WKHPR3MlVAWh8irlPWMb/pJWlqffLpuxSrqYEYx+E2ZECSTuV4CnlW0zKOrbAP2euYujpVYSuEWiq8+vk5GIrB50AUyqxZDPEy42YNMPBV5Xl1AqeBQ42jTVVqWPFa4q/UB2lSO79RcMRR/7TGrq8ztLDVQDRcaxsdduPUnvTsKH7DdYk85brF3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpD5Bc32gEcT3on3AFnw/cZi2RkQs9r4I8fsoEK1EjU=;
 b=BtGMLszirEpXFVGY6RY9slq2mXbi/hIicmIc4aQkmK8l22A0GamAYAg0A8+o8PTzBprswTFp81eiOz6vqB6w8wyIrBSp6lQU53M22O2H+LPEr58kc29ePCwTUGrJoZ3+tj1ApZItQnbDKs4OZHA8eh+Wi1A2NGoX7Qxwrgh/CGN54oEJsEhgyGfjxoix0GwOjjhe9AHS5aFn3cBK5ma/wSJkD/mvWhJ8ypflmCcUAXGa9IGPlzvYsgzmHPHxZdA6CGo3u3nO9FVOpuLMR//4vKf6RYa34Ue8od+Jmw+Zap76WKdgTcu3c/3Pg5hKGltDlCpFzxpaK2uZ6qKsvrm1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpD5Bc32gEcT3on3AFnw/cZi2RkQs9r4I8fsoEK1EjU=;
 b=BL6JVmHiZNy9OskOlML8GQO2THBp+VJ4Elvxqd4ytv+nX/KCeUTihm4/xakyH+hdAMQabLuucJwp/6mOxv97S9uwDhSH9XS0B0ghwWPx1fHX5tkdoe9IWvjQJFN4jvHnu8orWFubpTjuXMSRmv78F6DMbq1u/4juUG0s4a2GTM5hLbBTSjMlg8Ew6c8eMuO6Di9PQRQ4QB2fQf7EphOgpZT9XfN0i7cRLYp/AtPO44yoqR75sPSxOlrwzIu0oN9MitXtu+0vXwVQTHXn0f4d7dlPQ9N/vkMt31BrY1em/ZpF+JIKQGh+MAudgHdZcC9Sr6jqQLDM3H7sRG/rXPcwPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 12:46:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:46:53 +0000
Date: Wed, 19 Aug 2026 09:46:52 -0300
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
Message-ID: <20260819124652.GA200680@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
 <20260805124838.GP27883@nvidia.com>
 <269d79fa-08ab-55ff-77c7-fb11fa2005d9@linux.microsoft.com>
 <20260818234840.GA134244@nvidia.com>
 <912a5911-5b38-a14f-132f-a2d1d7c8f154@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912a5911-5b38-a14f-132f-a2d1d7c8f154@linux.microsoft.com>
X-ClientProxiedBy: YT4PR01CA0473.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d8433f-c4b8-4d0c-34f7-08defdeff1e0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	rqm0o5rx0Ycn/uNqJgNZjNyYOewKPWhVH3Evv1RkBs/P4EXFFqzoSY38V3mR6sqOPZDsRGlt++y4Gh0I1UO8bvTmOvaCXU71wAWea6M6LYqdHp9WaqJB2O12uApaXBtCy/nIy6BuuAdScFJwX4reLszeqnqc8PYtsOz0kDOPqs8EmXuYLKU5lBXWT7oMxxLsIZ5TCIlAjmUkgnCCWTcfEN36SxH6gMI+OzPQxYn0RZBNeRrGLuhrbPwWyKiBEx9BWxaWy4rrE7xH4wGdpO9F69Q5yx5jYWccGVmoTVr/+OMC89D2eFv3dFRYoLzevWhF9+csg7kyUbVhyh7SIcYtRsXDsaSnu+zQjqEfhO/HRvFgLjvpJdPS0dGxSVp4lHH36amEBh8hrOMCoYAH/5l663L5ZSyZxHLFlIEMX7IPTkrXPXLleDaPaa9vBWrQyv/osh6Q+e9/NUl/JyJ+jBnRxYIH++RC7XlYbBWwdt95ADRYSvGkaweN9AY8F0b+l6lGUdsNRWN8vkEQY2edWniBOwmtaReNgVC2XII2t081XONmhV80NCf1KdBBWQJCPZmNiUOrw8nQGKHZRWI/CVYNz4MTsJz/Hh5oPA0UeUXk3is7uCt9oApKaqQCq1VTYknqD5biDa5e956MJfkeIzNNsmagHijr4jXjTj/WZJkMqRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ruG0feCVE/CGvTQCuvns4O82OyhST3s6E9hq+1oVjM17iQG+l6Qf6IbCfh0S?=
 =?us-ascii?Q?V0uEvCt6PRy16npBDFi2+aMiBdw3ZpQWz92fq4vGHesAJh95P4ef7Bu96wsB?=
 =?us-ascii?Q?4Jv3cw/0ovl+0090JIbg0bcwA94I8dIDQpxi/t/9rT2b9JGaM6Qm87DU3LSO?=
 =?us-ascii?Q?ELEBpuKuzziSvFNJy09K7X/s84r3n8ZNjupjeCGSK3wMe+i5zVW+oeBy0F3A?=
 =?us-ascii?Q?Qua6ydWy84/wBtQoxfu/URdMcM7prOOh1oPogI7rBIM9FOqZsrpVxX9Tpm/f?=
 =?us-ascii?Q?1iOS4uYE0n0Jcsx010umrTeCeWkW3Jp0h0F3s8NARWRN7L6b2ETWLU1nTQgt?=
 =?us-ascii?Q?ktpKKno/mSk/dnff0+EMulVe9vUt0Nl975ctPA86gqLMyV1vNAj6s7p1c31Z?=
 =?us-ascii?Q?6giWM5yPvdPT2vKv6L8sJh9GJrEiqfqJIGdepWIdzpwpEG2yrdY9ZFSzoV02?=
 =?us-ascii?Q?7AqpPWaFla3xDQ83Eupi4ynI1ashp6zU152joXaI7MFjXD4it04gaqgp2GIs?=
 =?us-ascii?Q?vYdshiTnXa8xZWjoKa9jWaM6CsjP3XKTg9EhX9UCKppOcY647/R+JYNO8uys?=
 =?us-ascii?Q?7Ce+foUtpBYnpBgwuuYAGZMkLoR5FNBisxbBqE6dh1vYCxcQWtCvdUf+M+Qf?=
 =?us-ascii?Q?T+HOLPBo13RtTH+7D+he4VMoDFDMnbfDGXO21swfxjn9UAbtQY/l41cJgysa?=
 =?us-ascii?Q?xC8GsF7vPQ+XJZG+niyh4yOUifMorkiCIbmDKGgLGotaLeSFtHO1MVoa9/5K?=
 =?us-ascii?Q?K8PyisObxpGRNfDhH3kd7/8QM4iomtLvwNm1xeYsI5mUWdA+tTMzFKHO9BR9?=
 =?us-ascii?Q?kdvuxEhQIr7q7ze2BF6k0kaZWtSug3iG2/OLRpgQeTziAtqUG9fJH3BRo0NI?=
 =?us-ascii?Q?poo+iZMIrLu00pqABMuhFxpnGOMO71/awF7j9UPDBJoM5p7+6k1KoRgLCe7s?=
 =?us-ascii?Q?sp8eof4wnZBeSxr3nhan/IiI0+5jCNdzHTtJH37Sh4R1+eOVvyBZLzj8CnFJ?=
 =?us-ascii?Q?Pl/KUzwvh/+fREyQAh+vn9SLeN7A7bRKQpO8kVTLuXUybksi2HuIcW9qbXe0?=
 =?us-ascii?Q?WQhfQEVueuS0NwmjVah8119WO9Ws2PaQTIPd7zCzQ7gmaqQHVVKgi9OLQS6W?=
 =?us-ascii?Q?2m1ENZfMjyECSSoVwXKD8EgMGT1TQnIeL/qIszVsqt3ZrkZHZk+onzYc0xSI?=
 =?us-ascii?Q?/OyYHz4cORpvLvnsa2QJ4CVxjkqZNB6D+nJZ7Q2J1mEpkOHG/DU3OhWG0VLq?=
 =?us-ascii?Q?vfj1iyEymdROrdtvzzgwNl/TamBQSuFlgKIn+TM9QnRpvyqMAUy0YrmDJrrG?=
 =?us-ascii?Q?+9/Z33dN7Sdwk+7XINy5u1IRKAP1CsWIuHh1cF2pEkNgYRSlRnSxLfo3n1GX?=
 =?us-ascii?Q?WWfbLiXnsWOnoLBUUxLGgY+0NfGYhlzpQf6YDEiAuVMav4IfMYDNKLpH7wlR?=
 =?us-ascii?Q?bQHNCjnbtzoaPMkg15nqmMRhOKxerDrw6Eywh1vhr63sXQxT+Ogt1ivpxho7?=
 =?us-ascii?Q?nMO+zKZjSAZJA6XavHQ7LOpk7enC2RRGBQwwb6HGyJP91hbBAX2UNwNsUHR0?=
 =?us-ascii?Q?olff9OiYCPqe0hUlFWxhp0HGHmXgxC3VoZGdaphLkp7paNyYjas1NAPomFFc?=
 =?us-ascii?Q?EVD8jN3ip1hAY1ke8eof+jWigAAbdZZj3/prwxs2DI/Nie+2h83rg9+IstC0?=
 =?us-ascii?Q?dJ1hQNCJbWeVnp4+UVs0Qbu8MvT4TDlFDhOHGD3Mje0S5KVA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d8433f-c4b8-4d0c-34f7-08defdeff1e0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:46:53.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4JV9dQ+eAGxh3BdmJwrZanTca0BR6j/1Bmci7b7DzUqnqh93OfikNTXF/YKhJxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

On Tue, Aug 18, 2026 at 05:13:29PM -0700, Mukesh R wrote:
> On 8/18/26 16:48, Jason Gunthorpe wrote:
> > On Tue, Aug 18, 2026 at 04:39:32PM -0700, Mukesh R wrote:
> > 
> > > Thanks for the review. I know there is another set of patches for pvIOMMU
> > > ongoing (both came from the same source) and you are probably repeating
> > > things, and I appreciate your patience. I'll also try to look for your
> > > comments in that patch series going forward.
> > 
> > Those patches look pretty good so you should try to copy their stuff
> > :)
> > 
> > They ended up never calling detach, I hope you can do that too. Just
> 
> Unfortunately, my case is a bit different due to the "direct attach"
> feature for guest VMs. When a device moves from say a paging domain to be
> directly attached to a VM, today, it must first be detached. But since
> that just moves to identity, I am discussing with hyp team if detach
> is really required, and if we can get rid of it via just attaching to
> identity/blocked first before doing the direct attach. Hopefully, it
> can be done even if changes are needed in the hypervisor.

You definately cannot have it blip to identity, that is security
unacceptable for VFIO.

Once it is attached to VFIO it must only be blocked or under a
translation controlled by VFIO. Never something else.

Jason
