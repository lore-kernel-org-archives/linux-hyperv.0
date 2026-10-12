Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985D44A3E6;
	Mon, 12 Oct 2026 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835309; cv=fail; b=g0gncv6742Hq/ZSzgiby66x29zOGTTRlnd/SLxNLrOYs5Uolc25E3uC6j3rsqCP5soTjXcvri+hGEwLb8QQfAOL3p8hDPMb4Tf4efFweyxrsPzVQ2jVHklP7+0yK/ivLWt0e5vx6unaqmbo50Ify92UPd/W0vDuX3OO31I5AUCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835309; c=relaxed/simple;
	bh=rzeaHove7VNW6STTdsI24VYIE6vTOLTeHywijmo6ZXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dMiGcyoFdiL4R4P2qGn4a146ixlyR+Iq7Yl8c30/Tf0YqFfXtamASknaqiRTDkI15eeo5AtdNfzKHJ9JGFfNMAEl2rd5xY4ZKsiQldsYxyn0ZleH17ylwlbZVW06Nu7BLwY2NVRtactZixJtVcnelUaAkRNGIdtafjoAv1dhuUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiEKL1/r; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiEKL1/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791835307; x=1823371307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rzeaHove7VNW6STTdsI24VYIE6vTOLTeHywijmo6ZXY=;
  b=FiEKL1/r4aq+yHyyMFnmBjc6F2WW5X3Y3ZWpuMiwNx5xL5mPfczP4sP+
   I26hx7s0DaSNTIQpU3Mk0J/pUpMiKG+4ukms39DYmTB2m8RTKhjS6oXCH
   Q0i+pHX0boW/8HWsJSscRd54WhBLC+UZs0+J+EwGh13XpVDNKy72UM/cd
   Ok+zyci1yrHTDzy2Hgor/MjG3AoHxy+HESm+Pw4Dxkvc17GITT9Ktw0fn
   StL5zCkwVlaDXQ5R7oS/y7rZH9XgYch1ktORTk7ybOb4attYO0JgVPAs9
   IceNbTUZ9CTp6SwiBGik3RUEPopQk52VwqxPGAUSxk2Rlx5Vpp5krOOhH
   g==;
X-CSE-ConnectionGUID: TO9pYR1UQya7zyv2ZsaBIQ==
X-CSE-MsgGUID: pBgfwNxWSW2d5AWsT0UKVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="544441"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="544441"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:01:46 -0700
X-CSE-ConnectionGUID: 0vck+/NzRWunAchawGITMg==
X-CSE-MsgGUID: FQQ+PAnqTvq8XCpaiS3T2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="951668"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:01:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 13:01:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 13:01:45 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 13:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC5FNr0cSkig1UfXgXOJmdq+lvuLDPYTas2JGm0P9mULlraSTIDvBdjpe4JUvY7JZr7hy6j2S434/+3prWo7tple8b2DVz8+pJB9xfkKWq+XiCI9f6MqddtnYr0eCciRqcceOn4KX5q3rewflzdrs7J0WFsy4iWVB4wNENsm+jzQx/Vr/GYktFnKjPrUnyfrS2iuAgSUvsmS9sC6y1B5MK9O9gdC3sEkz62zrwWHpv/pAcnWKd6WlkI33ZfnEOmPxWRmScfsZK0ePVBKeiZl4D54l4Uo6o0SVMq6wTiGWDcLOF813txT5ZGEVzvMR4ptkMF226cYYdFUh5trDG/4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ALr0sUOxdZP8/LqNnPAT0ktXS+z+tYxaraEYwebzd0=;
 b=dXfb80a0DfmgkNSSnnU/sa5/QZoqNOPOJN99q91ZOHjVoaERS0I8+eU/XOa4fci2G2myhsgdnvjMNhrcp0H9IQRIT6PZrZ1P52hW3390+zkox/pibQhW7CMjg6WuQ11aj3CK23EcsAim84FYAnZ8bHHYeb+/gvAeI6DuiavlWOg7a/SevmbZOJXoyw0Me+JoUloB3Z5p+fF9JtQncZL49ENRYyy3xHAf97in1B4xIesufNMCAZKRdgjqA+sR3UrXOKtfVxQIoKw0aoBDxe0ihtys1rfQMKNXyBqM63vafH6j3KRtZNvUe4I+nXGt5U4Tlh/fJ52KZN98LaA6oaU5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) by
 SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.18; Mon, 12 Oct 2026 20:01:41 +0000
Received: from DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::953f:2b9:f2d2:43d5]) by DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::953f:2b9:f2d2:43d5%3]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 20:01:40 +0000
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
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iCAAkgrAIACGMTQgAArlwCAAACJAIAAIDMAgAAQuKA=
Date: Mon, 12 Oct 2026 20:01:40 +0000
Message-ID: <DS7PR11MB60647FA80C6BE1029982222DB29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas> <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261012182120.GJ219304@unreal>
In-Reply-To: <20261012182120.GJ219304@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6064:EE_|SJ0PR11MB6622:EE_
x-ms-office365-filtering-correlation-id: 8f01392b-fd16-4ce9-38b1-08df289ba1b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info: PWeEg3f8/M4PV6RY/H72u9soFXCH92ow9Utzfe7RnhQrQ19dwIFP0x/aKIaANJ6nmVDIlvfDg5gvtlkWqkiY+lIhvseO8OQUYJKQ5iMhCF9SUwhQclrEfLodf/+QOeOvIUmSF5NnWjq7LwbxCIcANl/5NSFAccM6fv/Ed1isZzaQVrHGn7BMhfC9Vs0gEjLgoKLRcQrOoDxHf2Cr5IkOGzrAG9tSkXgpKHWDWWyyRotKLhW9y/heEocvLAnwxWodWJSk/8glgIO7mll+tbAsGCiRS7Y+V0TKldook18lNM/lTi4elOfwTyaW2typ6DreJij4h3apFulS0lcUamVj7MmSIiDtj/ensIGkj73Sek7nAa4hwY9cSQUF5LYXDOJemN1U/hXMlysuTFL6edyLFHe5mZ7woIskKEV2Q6MaaLUm78hw8prfHxh59FUVSyUeAap1Uh+DfQvxtw2Pr3kvJ5jBBirwpq9meRoaVFwG6HAX9K+D+90VMJfWIX5C1BB0OwJZuT45Rn6w+gCzNaXG8paQRmjzoOkMZM1amNv0iZWC55xwCHyVniGRtZpSj1ccyv2djcLmcwM/2jb5qug2SKO+Ap4kt7xrvXjxJlZwxdYsJ81vex9jCguS8P1PCviE3JlftXFCrR8zgq9Gml7TN11TaChCUSs2qwxVDZspcc4ZqxLL9zPNzd9F8UEGZgEDP83HOHfyhMf6bFe7741m5PjnIeBDQTJ8NMC8xrcJZzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(5023799004)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kzeuCFSYj3eigvROqhsF05XcxR3oqLxfEMN1kt9+ZhQcSbPjQsC/Cg0VvrXg?=
 =?us-ascii?Q?Lvs/8U5lPGQDgUiyATexz5ochQpRoqz0Aa3IbLkyfJOzL+UL+Y4F/l5QUmmp?=
 =?us-ascii?Q?Payp73CxXFMuyiua1oZHNMRvhW9cxYIvqMSft0hmy0HwA0D9guZpEsbtsFRW?=
 =?us-ascii?Q?eVtmQGVtGa+VMAjNydXAoLn2Sxr7gKSfZF98G4QdovLYfVrdCz5PYO3x2ME3?=
 =?us-ascii?Q?Dw77NKD1Kv34symiUHgCwKqKD7V2Gbmtw6vUZXSrwhr08qwJmbT5bVRXqeOJ?=
 =?us-ascii?Q?/G/sM19MmZnySx6Z73hPM/N0ytRVZ3Slf+XtmX314yktSr3t0C4US6SmeCzk?=
 =?us-ascii?Q?XVcTPzg668VaBYMbGbjr9Yd5yuWmd12L1gZKIks7WbHPJCxENZRKvIsGLGHN?=
 =?us-ascii?Q?fVTUTifrpYbv6s93aN+HmMLGqiDexL3RnBfREABXagL1PHs5FlR2RKFaZLeh?=
 =?us-ascii?Q?UF+xsnn62zCYXph+Nb1yFiYwff7FiTEfcutW6/jpTPChvEwFXJovNcljeXnR?=
 =?us-ascii?Q?vgjbuYd7DtjgtwhcDHr7Hy8GSpyEgz+82fuiILycHO6D9gOz7NLyhzFtZxFx?=
 =?us-ascii?Q?u66u/sxQQhYJgpCbDpeE9PmbhSlcT9lAl3KpmL8BYAP0xUiOf2u2ZIwTyyhP?=
 =?us-ascii?Q?qxnazlZinIuZHJyNZcIsdu6u9s5pz1fuHWyIRZkbnDvwm9shOIw9SapCNktp?=
 =?us-ascii?Q?AkXauojoolBllb9/M5iobvTq5bAuXIJOzhr5PyQvYBq9N2o8hN0bRE87VT6Q?=
 =?us-ascii?Q?wNg+y9iCpfYFq523MSIkdi5lh2QBcRsmpqpZJJJbY4K1hFiwGqINWPm0fRGT?=
 =?us-ascii?Q?SyF1MNEsvqOmmZHF0TBHCeNoyfwWNHulFKCA8x6H7daiAqLvVpTYHvoa0Liu?=
 =?us-ascii?Q?yQ6n3T27avDcNBMfDUj+1WOKgFhzTYR+UlqOn8lEhzajbG0H2B6KXz0BFDL+?=
 =?us-ascii?Q?vDMf9cBnCWnJWFneJo1Y8lc+Ytiv6HcedKVbUDmJC9zQ/ebKKmFx7ngFaLfe?=
 =?us-ascii?Q?ewmkJCc/fGONgylyuE76jNvTQh9VOM5/X4zAiTuzYMRKNpGxRoMb9OWH6wMR?=
 =?us-ascii?Q?Vn8js5LtQPjk5hzZYV266SZ7JWWMyeIapzbpCLrSguTMsNuFrQnDTaivsxnH?=
 =?us-ascii?Q?LUuVQQoLnfGrgU+zeAQZYvxGrUvMtCPQT0/ds0C2twZ0MRTJE+4iv0XhURRO?=
 =?us-ascii?Q?6C9mWfmMBds/soERred65AmwdqM/sFDHWW+5wd6xqm7PTh3UIq08YuPO0SMm?=
 =?us-ascii?Q?LFl6IzNKs+9gqtELzdH3z3PdLTorp9MMTfRoNBSmdzrHJT5qXE48KEkiRUuD?=
 =?us-ascii?Q?eXFP2kdu60tdRmLe1kNn4TyAnVSTRXUO0LqDubm6KtA4qWqT9VFcYRsizJet?=
 =?us-ascii?Q?BnSf0IIIWbVAJOOxgnrancWARvaFdmdozqyErqBXMImK1McxzAsjMADRl52c?=
 =?us-ascii?Q?lKkr+37lML4yztFm7SADRYMOQyviLmogjfu4dtYmvHrzdNLha8n1XdqDDNqg?=
 =?us-ascii?Q?PHOBWGC45+VMQTFgJLmfcG5OeHDnVTk1iZNsQUXAdvoc58dDoWw3Lzxb+Rih?=
 =?us-ascii?Q?dIsdUOCkCQy/fLFlwOcS69SGGLLXX3oFrlyOnzwAvNAD45SZWeLI8i5PudbG?=
 =?us-ascii?Q?bRXmn37Uqt+s3+g+e6AS1YQ9I2nY5Zvf3LNLTDj0hmWisH8r58sJHs/iAsjr?=
 =?us-ascii?Q?ef51yVHwPZ5KXcuIF97NukOujtPvDs8ZpyzVvjydJV1QBahd3TCz84Jugt3b?=
 =?us-ascii?Q?l5g8glQcwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vXvG6g0QM/TW2HJU7aeZvknahlhn/T06GlDZ0zYCgDbnNBz6XtpQy72pTP+RdXh73fj8U5ezxng9o062OV9hVyza2WnRTgy4+33jkOUV3wgUv9fpAxsCsGqunm8DQhLSiWnPTAjiUq3c3iWW/py9tNqPoZE+6F0CmMrqARVR0RHCbq0tyoZtGVcQGLwrG4G+TtMY0aMXp9jT7cN400WcZx+eLiqyLtt6IxH2IQxfuaB89NYO5DDaryPylbZKLxLa9ezGI7Fhk8zS4rGVh9mK9OEh3ulgTzmx/EHkCEQvGWVXd+QbKxaGs0TZPE2xRuLaXkpODsBi1rDaG4cPx09/SA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f01392b-fd16-4ce9-38b1-08df289ba1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 20:01:40.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4W+58myFg6OWPbSfZvZsdiD2ccUqPECQWqpEJ3sEC4wRklhdGzFQ4zjZsSwz5xq0gKgUuqAMLl11BYCD8E40qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com

> Please read all of my responses. I was explicit about why the check
> inside the guest VM produces random results. However, your responses
> continue to focus on the guest, which is not the problem.

Fair, my earlier replies were about the guest. Taking the host-side
points in turn:

1. Host topology decides P2P, the guest cannot see it, and the patch
   says "yes" for every pair regardless.

   The topology is accounted for where the knowledge is: on the host.
   Which devices land in one VM is decided by the admin, from devices
   VMware has certified for passthrough in the Compatibility Guide,
   and on vSphere 8+ by Device Groups, which hands devices sharing a
   switch or interconnect to a VM as a topology-aware group. Hyper-V
   has no equivalent grouping; DDA is plain passthrough, each device
   assigned to the VM explicitly by the admin.

   The blanket "yes" is not new either. On bare metal the flags =3D 0
   whitelist entries say "yes" for any pair of Xeon Scalable root
   buses, across sockets, with no knowledge of BIOS P2P settings. And
   cpu_supports_p2pdma() already bypasses the host bridge check for
   AMD Zen on CPUID alone, in guests included. This series gives Intel
   hosts what the tree already does for AMD; if that is unacceptable
   in principle, it is unacceptable for AMD guests today.

2. Regression: consumers that work today via a system-memory fallback
   will take the P2P path and break on hosts that cannot route it.

   A wrong "yes" fails safely: without host-side P2P the request is
   stopped at the host IOMMU, nothing is corrupted, the same exposure
   an AMD guest has today. An unconditional "no" is worse: it blocks
   P2P on every host that does route it, and the guest's answer
   changes nothing about whether the host routes it.

   Xeon Scalable routes P2P between any two root ports, which the
   whitelist already encodes. The only hypervisor-side requirement is
   mapping the peer's MMIO into the VM's IOMMU domain, and that is
   what passthrough P2P support means: on ESXi it was an explicit
   per-VM setting for years and is the default since 9.0; Hyper-V does
   it for devices assigned to the same VM, as tested on Windows Server
   2025. The decision is made on the host; the guest only has to stop
   vetoing it.

3. The hypervisor must describe it, HMAT is the way, NAK to anything
   that does not fix the hypervisor first.

   Agreed HMAT is the right source and should take precedence: consult
   it first, this check only where no HMAT exists. The disagreement is
   on "first". Guests on already shipped ESXi and Hyper-V releases
   will never get HMAT, and those stay in production for years; the
   cover letter's note on the adoption timeline was written with
   VMware's input, and Jim can speak to it. Until a hypervisor emits
   HMAT, this fallback is the only path that works.

Thanks,
Pavel
