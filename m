Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4E357D0D;
	Mon, 12 Oct 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815212; cv=fail; b=qvcRQbON4GZkaWbbc/lYxmrqQ+NZnaeaRIhY6dFwUClK04pTI4/0kSz//zqsjYaa0/UyOVHzOYqQWhc+OPUsPudRe7GRITJ6SRpCXYMGLwpSTQK8DrMGaLJODvV9sbUsVpHPkjokJxKrZTK3/44OH7Xpa5fYGGAu1747nIrGCdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815212; c=relaxed/simple;
	bh=z12Qpmyp8Zr5Pfg4x04b4aVI32pqADyYABjcqkZfIKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PML8RDFbT/WqKhd1VNz87dnLy0z+WiXWaBHDTSS5CJvKUqI5esPdMdnLSdxXcpOpmmEYlfaEEDyn8JvrBfc0QkmdCbIqunpef3ecDMoDgV6pfu5M5JvD8KgFLmaiWENfb86mr8DGjfvEoy8dneT+CbmAAzX4wPZVLqnoRY3T7XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGNUk2a6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGNUk2a6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791815210; x=1823351210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z12Qpmyp8Zr5Pfg4x04b4aVI32pqADyYABjcqkZfIKw=;
  b=HGNUk2a69ztUX1w/bP6Ket8J94n1Vj1srErptQH9DxY69dFONLK2HT7e
   b/qu2jGTF9/lHBJLlXgPfVvgNr1cBKxQSg24EQ5gEN+DW8p1eEJfnDiw7
   EdS8JnYvw1l8UEpErfONkeR1FXWJLuao6RH0bel+AvJNQyyz/Ivo2fSJp
   o+PGuvBdUyn+EwZQtWvCywCAmXhnx0G4ZZiaRLI0OBAU4Blyk2d9hZjKE
   8Dw5vk2Qc1MVZzwky32F0i7Ho2KfCv5BWpV/1iBZeeePFTGShRJH2AgU5
   4HLIBxQ2ff9vLBJPCnfEpA/cOVpJSGXsWdOiDGQc+joTcThIUAFeaWjUE
   A==;
X-CSE-ConnectionGUID: 1Y/heTeUTuWU6wjg2hQaJA==
X-CSE-MsgGUID: Dr5xBXjiRs2G+lokDSnb1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="537556"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="537556"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 07:26:49 -0700
X-CSE-ConnectionGUID: GGFFkhVISaexfv5h7sMb6g==
X-CSE-MsgGUID: GMHC6o5ER1aoK7lWzxiaOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1229299"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 07:26:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 07:26:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 07:26:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 07:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei1wsPIcd/ABt0wzhxla/UB1M4iw9i6Rmk6YMkCWr1Y49eBLqnS2054USp8urNz/FyWB7Y9ITksrJ2GX/PfoJ3RGqKYFHfawxq+RBwLq9iZGs3HrK3Cy4kx+AS7aUPqENDcKeWprNzcZFFyDbzy+Mp/qa74Zrzp0iPqGOOm2Hig9luiiUEIe6lzyYuCVnd2qn4avutL+XFQ3ki9u2uIunA3YaeAA4dS54O34BaKA1W3c+8IBqv/5PeEgtB6ya1f2l0ePoDNOxezofQLxwz7TPeleWBpj4QYaxUT23eKByDjRDZNrD9NHew2+ej4gZNNmNFdPhzs6ptov/b6eeXJWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z12Qpmyp8Zr5Pfg4x04b4aVI32pqADyYABjcqkZfIKw=;
 b=lkBtCsifwgjsfdH0sfRSluZwYoWAIRN02ciKZl/AI77ODTxdcmVnKxxCfoUJBwv3iAMgPvJr7LwsQPMt6bgGV1kJtVMpeVTDkHlziRbPr3PChwJCBEb4x9IqsoA2Gktlyc8WwgEqhOHolojX/JM27e1hRxWdfCcZ6n6Gq8qqFEJb5rp3uIkWUVZpjRfQeX0DUhIkIVIXHEIkkt4VLu/IOddpiGJjNo1ZwGQQKAPYpt06qD8mcCL2SgJSNGy6jAi0VZiJ3b5XJfB8NSm9f1oa6FNW0zPvjUJum7QAComarhz9GEl2xpHLgq/ZE/6dPHTIDtLgM9eI7mu2Od2x2XpteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by LV1PR11MB8791.namprd11.prod.outlook.com (2603:10b6:408:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 14:26:46 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 14:26:44 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Jim Chow <jim.chow@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
	Radu Rugina <radu.rugina@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Lukas Wunner <lukas@wunner.de>, Nathan Ciobanu
	<nathan.d.ciobanu@linux.intel.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V guests
 on Intel hosts
Thread-Topic: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
 guests on Intel hosts
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iCAAkgrAIACGMTQ
Date: Mon, 12 Oct 2026 14:26:43 +0000
Message-ID: <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas> <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
In-Reply-To: <20261011054700.GF11438@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|LV1PR11MB8791:EE_
x-ms-office365-filtering-correlation-id: 461224f3-ecd9-4795-0775-08df286cd735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006|5023799004;
x-microsoft-antispam-message-info: 7k2TXzaTWE0Rrj/g9qtRAmhlhskjqTpYZDEesmPxb/uCPEj+9U8y1CmVfMqQj68FWUmsdS2465bVQFM88C/rtwgxOjcPzQjvabk+wRf5ilDrmejjsIESCud8ewM/3sJKxtsaFIfsIWBOPThvBEtZRQ1HzMt8RIpfYiKTmG1s4ptbKCe0HrLvX8rWhTpJgxaH9+JqtXYtWHP/5bjroYI3aO58jqys5BSwpjBZ3cVvTN181xyp4Kq4QlVtiESKo9ya5PZZ5v6BAItWEcA//Jk5FqXw3p6bIbonJttAHsXmLlNX06ZfWJ44tbobz+h0OPBqOWDCAlxXLlu7VIuc5Hi3CAqmBpGENmNsKC3zqx5/VgUBrswFxB/fpc+muXhVKu1yyl6nqlolTOWy8/h6SFzyPfe83+z5+b6kVbbKpnPkF0lhuB4up8LeRh3kB8sysMZduP7rgEvz+ZauHJCMukCZju9/E67MSbXc76Nyh102KTkdY0Xj1SVoouT/Jqy7h94I/pmpHrmZ3SmkjbmyiI3OSG5l1ARKg/ttjo0gL0sAHIOTVqJvDIBhEACLs3PLirplW8TGOLm5tMr5ZyzC84WFyI8CLuu3vPScYB6HVuIXO5iD+nYT3Kjyct4b4kDfWsJi20PxJrQrLT7d4kqNjGZifLkijQKHOvHb/3BCN4YBamnrw6U4hjDnMyYzlZi2pDhGyrBkwlgbBpmdcyp2md8nQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?optuB7qXM/fVma+D5wfYW31DLeYTmoIA3M39Y8lKKyjxwEftRj3H7lk/wtew?=
 =?us-ascii?Q?8HuPPOfkDVTVwUjmCafpOxjVy5To/aJ35BW9HPRxGqwHc5myZTjy+0ucdlCP?=
 =?us-ascii?Q?5Uqm6UmSe+l58e1K4xQ27IjDgguEyssC4vhjknfOdReBQHuEcM6rWU2l5Lqw?=
 =?us-ascii?Q?/TLg4pgcb9sqCOAbDicCY64j+NjUqkupryCqbtgEvR+THtwudECTKwDAwrL7?=
 =?us-ascii?Q?IInWyM6s8WCI6XJUsFqigtccjeNfVpv2QHV7yHvBIOd2zVCS+EBFSbawFY/c?=
 =?us-ascii?Q?5360qy1I53njXniMu8OJ1zJ0PIuwoydUM0d6dLfi+uDfoJrCBi3uvNUimLab?=
 =?us-ascii?Q?2psoezhleERZ8ix1ib25G5BTVwbM6GzJPRqWBNyPbLMZV34ZaVlE/tb6TpgY?=
 =?us-ascii?Q?4L48FusDDIz0pgNxRNkdxCaBN15JybtEDx7uFfhYqYNlgAWdixViEwVKQX41?=
 =?us-ascii?Q?XXtwdZq52YWhzT45FfbWDJAxD/pBtVN3FWg/Fspa0DOXiEhi0VKaj6cTPOB1?=
 =?us-ascii?Q?mXSAO9/M7SEXKLR1O3SGTFAQDv52fR13m0ko8fhPNowOj6NzZj2tjsg2nSyO?=
 =?us-ascii?Q?bmr+JPKyo9Cs79LvWGs4bsIHKlJMqdKdaeakOWEADU6TLZzzY37AI4ikNwq/?=
 =?us-ascii?Q?RR5GI6KTkcC8CEZezxX8MfPmWOQd46lgr1tELH2YRQVW/FafklakA5QpEvzv?=
 =?us-ascii?Q?oMxCszc+o3ms+eptkggpEhqU0bwXfl456uPe6Ud+I2OSy5Z5j8qcUF2+ETBx?=
 =?us-ascii?Q?j7iEbqhWZpjfkFsYMBiN1/bhJCzbLJg2QM3HOK2GV3lMr09zAjR1JCuorR/F?=
 =?us-ascii?Q?rA6FdrewZnn00UyLWdSZx9RD9BtBTxpzs4aNWk+KPfVHHocptN2bqKWo4I9o?=
 =?us-ascii?Q?KXyMsv9HH31pXM9g150ZOpr0lp3lmLszWyp1qAQkBxHYU7GdNU/3PSpDOrQD?=
 =?us-ascii?Q?GI422dhg7jJlx8jV/P6/bk6THMeyzX0R/zLnpQ10Hoqsff4CW+TTsUe3+zY6?=
 =?us-ascii?Q?vEpc1EbAExKTRoklG5GhpZcp3SZ5yedZaINamfi/2e3q6FESCK8WgBn4a3G0?=
 =?us-ascii?Q?laaTiyK1LaS40dfBdGuyvar2FfFENa87k4xuYZ2U/x+pbXdtWQyWpaDLnj+h?=
 =?us-ascii?Q?NUe/UR1WC6NUNSwRv5AzYnc8wlysqsrIGqQBzEjibmg6QCKnQ7te4SnAwWbO?=
 =?us-ascii?Q?qHX9beSckp25aAmhZGqIhoXcDIim5/APVM5gpjZNEESzQsEjHkJTMRNu6eoH?=
 =?us-ascii?Q?+3BznQA9dO+MmofO0O3213p7+iQ6UEDB0BwCsf2Np7OsUJ1KlzXTN+XaTdA+?=
 =?us-ascii?Q?SyxbWoKAUY3nwLzShCQdd+gH2XF2qP4xu281prgtgkBHF6h6BcmP3LQLXVuU?=
 =?us-ascii?Q?c9UiB+WXTS9vximMuEVS4hpvyDtjOc5cFieTqPELN6wr8XRaOfo8cuyN5ABf?=
 =?us-ascii?Q?3ShnSTVdUk6JI0vmw0xpPzJSxXbTJzKu+7dX4Qwy140Tv0O44a8M4bVmdY08?=
 =?us-ascii?Q?mswa69WC/vu0UKfOyJ36HejrvYPbu56rKjf/ip7DxqqxO5komrMl6IDK1sHz?=
 =?us-ascii?Q?jz/zEUkob2M6W5OffQ+UK8U0I5WT1YxJ1XvSHvd0AGbpNudu5v3RbObHj0gc?=
 =?us-ascii?Q?3UKlQN5SK+m9njdchU4sMphkJx7c1IPWtWw9UsFM9nRloX6WZZ9dLMLifQ5a?=
 =?us-ascii?Q?csv5GPTYbCwytLAGY+8wAgQUF+RyldBZfzrtknifv+o0yVty5CmTwFOV2TSy?=
 =?us-ascii?Q?Q+gI+wRVPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AnQ4eTWxUsUn7yJY1To5lMz9dLmSgrzZu3ij2bQYafsPUK4FlAWcvWxzR+QkCnWWNyPqie916D86ViVyHsT5zXnPc+NurW4L9fN3UVE6rvNpmheaP3kqsvrCXH6wnjJS/5Ot6Vl/y/y2sM2oI4GkkBNq1OS17BeEsY5BJ3tm98u8Vo1g7nfq6Iuz8ZvknN1EfgUmQQHO0LOx1p2jBRFtYO8yCaEc97yp9VvOAkra7M/rsYmMaSc8gOi1SB7V1I3xDmXY61SRv/fWvJmZAlEDk96IggUMUJfEBC78aRs5bI41EKs7u1pI2YyWu8sGlOr5vP9WNGM3GSjABYBn2fZuvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461224f3-ecd9-4795-0775-08df286cd735
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 14:26:44.1770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veHehkaH3OsJe3SoqhC4q5JUeHx5wZ8RM43n4dX0zBqnlfqZVHEvOeLkXDFg3fKYe2GZsUwUPPHlfcJ2Ac3bOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8791
X-OriginatorOrg: intel.com

To be clear about what is at stake: this series is what enables P2PDMA
in VMware and Hyper-V guests on Intel hosts. The assumption that the
hypervisor can simply be fixed to emit HMAT is Linux-centric. It holds
for KVM/QEMU, which is open source and where anyone can add HMAT support.
ESXi and Hyper-V are proprietary, so only VMware and Microsoft can add
it, and until they do, this series is the only path for guests on those
hypervisors.

> This does not change the fact that the patch causes unpredictable
> behavior for P2P devices in the guest. Sometimes it works; other times,
> devices that previously worked may be classified as P2P-capable and
> will stop.

Nothing "previously worked" here. Before this patch, P2PDMA was refused
for every passthrough device pair in VMware and Hyper-V guests on Intel
hosts, except Intel QAT/DSA/IAA, whose own Device IDs happen to be in
the allowlist. Those keep working unchanged, so there is no working
configuration that could regress. And the check is deterministic: it
depends on the CPU model and the hypervisor type, nothing else. The same
guest on the same host gets the same answer every time.

> Help Lukas and Mahesh succeed in their work.

I'd like to, but the blocker for guests is on the hypervisor side. A
guest only benefits from HMAT once ESXi or Hyper-V emits it, and that is
VMware's and Microsoft's code, outside the control of Intel or the kernel
community. The kernel cannot make them ship it; what it can do is provide
this fallback. When your HMAT-based detection lands, it should be
consulted first and this check only when no HMAT is present, so on any
hypervisor that emits HMAT your code is what runs and this one is never
reached.

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Saturday, October 10, 2026 10:47 PM
> To: Popov, Pavel E <pavel.e.popov@intel.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; Jim Chow <jim.chow@broadcom.com>;
> Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> <logang@deltatee.com>; Radu Rugina <radu.rugina@broadcom.com>; Alexey
> Makhalov <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>;
> Michael Kelley <mhklinux@outlook.com>; Lukas Wunner <lukas@wunner.de>;
> Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> list@broadcom.com; virtualization@lists.linux.dev; linux-hyperv@vger.kern=
el.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
> guests on Intel hosts
>=20
> On Fri, Oct 09, 2026 at 07:13:31PM +0000, Popov, Pavel E wrote:
> > Leon,
> >
> > Understood on all points, and I agree HMAT is the proper fix. We
> > discussed it with Lukas Wunner as well. Exposing HMAT is on the
> > hypervisor side; Jim Chow from VMware can speak to their plans. Even
> > once HMAT lands in Linux, it only helps guests after the hypervisors ad=
d support
> for it.
> >
> > The key point for us is that today there is no path at all for
> > passthrough devices on VMware or Hyper-V, and that is what this patch
> > addresses. We reviewed it with VMware and aligned on this approach for
> > the guest in the meantime.
>=20
> This does not change the fact that the patch causes unpredictable behavio=
r for
> P2P devices in the guest. Sometimes it works; other times, devices that p=
reviously
> worked may be classified as P2P-capable and will stop.
>=20
> >
> > Is there anything you would recommend to make the series acceptable as
> > an interim?
>=20
> Help Lukas and Mahesh succeed in their work.
>=20
> Thanks
