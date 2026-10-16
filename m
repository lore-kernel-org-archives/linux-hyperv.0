Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489484EFFD5;
	Fri, 16 Oct 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166755; cv=fail; b=r2OsiJpKiurxhFFpX3/2psMjsJDDVaykG/wwyrKbI/CjnaTvLJFIAsiE9GWN0dez7RGX9obhWi1kbqEzkKGXhdONEzbEXz38dFQdiTo/No33Y7I2db1YsjvtH8QgcmfvAGsnuYt1SP0IQ8EM6rQ1p3UJjIf+k0Ls4yQovjI0fYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166755; c=relaxed/simple;
	bh=ex8xTlnUkDG3On4bty/7WzmHMr0u3jHDAir4Ue7jV9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MPVFlJHjpbiPcDox/bjx0pa+XZgH/A0KwXsTJUk6B3rGUqYRxEt7HDBHky92A/5wAAyVP8LpSihhZz0gay/1Kl+wiv/NimCspClsdQiZYV3sNsykFvjISpze97fKNCvC6iK+3zZHySPearjZTONQDwY0NIHMXetGh76u0TWZ/g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0V2lo0o; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0V2lo0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792166753; x=1823702753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ex8xTlnUkDG3On4bty/7WzmHMr0u3jHDAir4Ue7jV9E=;
  b=O0V2lo0o/x+R/O3PFbRm2pfHCq4c1vxaZIENHQFGoWcYjGIkG5h47CMN
   lBI9qUaxxgbOAAuaBPZ7lr3zo/3Q1MAPDIM9rbW1QN1RVy/xru40PtDdS
   bkVZoDryjjZzOqC1RskczyWhOo5vqKV0LqhpP0Bz/JuyRaPgLvhqQ5OZ0
   PNXMknSSSG73v2uXEA9AA3vI/EfKe9zlWlCn11TvX40q3UEOuyXMVBkin
   aVEFWbPDeoKcGPi6GxRH0IJPPdmFbPi3r5ocPzWeVrTgg41LRnDaf1Q1u
   ySNuarIIMPId/ahl25RZDPMi0jlWevSA6+eVWwWSDXDfZ2KgeDIVNxQhT
   g==;
X-CSE-ConnectionGUID: o8kR2T3HQl66GFS+Sh9lJQ==
X-CSE-MsgGUID: m1uQHziwTKqot6fbo1YUEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="856127"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="856127"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 09:05:52 -0700
X-CSE-ConnectionGUID: C42fOkRIT5KSXh7p6PlHJw==
X-CSE-MsgGUID: oi8oO8yjQj2GJwSrtVkw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1957240"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 09:05:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:05:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 09:05:50 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiWKRLiDkbLSm4qS7haFZpTdQbHmZaEZibpY63H+bVoSQlKom998FslHaIlO29GTxNoX63j9qYcnpw0mqarfzf5tHN3eiP5zFYPBKfd8aGR9BMH/vj/uIj+GJLITJRFS3dx6Q0dnzN1Ps8VImiuj5pvLEbwmq5BjbcQAkWgR6qz2EFOuwhq1DPUbd9kxD0VNWlb+c7A9TBvR6+Er9EQaPjPiycx+XqEql3HVwQtnKW3huKP1h2RP26pz6+Pj2oblmtkkIXqvxRG9NkFUK1Lz726U0ILA4gSXzejN3oG/AKwA0o9K16Nr1j04IekZyYCkZCrkor97uduP4qctMFas4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zYMEBh5l223Dv3IWfem4Uh57hLeEAbzya3n0T+IH6o=;
 b=JCj7GRE8rlLYVDeSwns+TGfzajfejO14AFc5lbB82uVSoRHFl3PJnLbi2Rn4E4+IOyDM8p84eyR+jHYhI6UCne3/AB2PvZ6BW9K9yzke47/lgYaNL9rwoXDU1QEKEoSWI1/uayTxa2giyxfqLg3cC+tSXxb+SfNDHXwTkdVj9gD+YfAAk69YwPoZP2vw7XppB5UJLswuy63iAL5CwEXmFaGIPQjSjhpQbbzOlB8RPCVVmV9807qYFIUpBRypVjU5AWibLQ6a64WU19RYVrSBR7TEDBpsNJC8hmKczBv8ZViPfUNHrzB3nWvrXyG4AaF66ke0EhC7lv0+KkMQNLpvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by PH3PPF1BAF94C4A.namprd11.prod.outlook.com (2603:10b6:518:1::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 16:05:47 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:05:47 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
CC: Leon Romanovsky <leon@kernel.org>, Jim Chow <jim.chow@broadcom.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, "Lukas Wunner" <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, "Nathan Ciobanu"
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
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iCAAkgrAIACGMTQgAArlwCAAACJAIAAIDMAgAAQuKCAARyrAIAE4THwgAALYYCAAAPDQA==
Date: Fri, 16 Oct 2026 16:05:47 +0000
Message-ID: <LV2PR11MB6070D328D5E6A538DB6370B2B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261012182120.GJ219304@unreal>
 <DS7PR11MB60647FA80C6BE1029982222DB29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261013122002.GN219304@unreal>
 <LV2PR11MB60704D89055FBC471FF81B31B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261016153147.GC219304@unreal>
In-Reply-To: <20261016153147.GC219304@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|PH3PPF1BAF94C4A:EE_
x-ms-office365-filtering-correlation-id: c8d02c8e-afd7-4475-fe32-08df2b9f5757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|5023799004|56012099006|4143699003|11063799006|261009223027099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: DYfSo46T2SMXBSdyI/dfPnCAeKowKGQMnz/cmW+MZfrPomYMoFgafNM3paexYMPWoeZpQw4Pwgq0xtZKBg4v198ieIZmZ6BccXxzwZrPy2Z3naWV4NnA/YM1PHV+RbFDsbEjzN4+ktTTmnR19cMcUC7RmC81n6GHNs5cwiX2jH6sV9wUxu9zAIjIufIIxL1qrRAY61/QHQX7QT50NWCZRW5Br/4MiBZlLNRJExKfT3PszRd6vFYIvjmA64DUh5ZW61pq1B+KrL2yntNaHHfxjyHOaDyPySE+CXI0eYatcAcbGGhS4hartekyelwxfiuSvLvC2VDtUaogyoEFo1ezEnFY+sNN453CF32/3bO8zD+bCIhdvggIzsE4bUvwPokmJQwowVqiZNRsp3WqmRN3xaeNwy9SAVmZnNOfBSyYyibfs7A3Wn6vV6p2HyUuNqPeWJJVxte7kQ0M442Rlom34AUWfG1GD0w2lk1u1bryqzoALrt0lQvioVwfmzdvP7PbER8vsHWMPh1RM5rGmYa+dqxZOPyuY5kGbRJ5LkLUSJK7BDpiTKBNjwtEFx/3oSZiKL3wfSaNYrC5cbX4c/VLUVa83S1PBu4h+hBJSR/Rsq7Dno5acpfqbtbROOzLS/3m+/WSw5apHVaoPjGNNh5pzIve1tmC0MVdp8oPL4O8nEq/zqdOBwKqYN07ahdwFHoRs2BjfUmKTxC8GqXfuUTi+iYrZ91uB/RatuJ5EZitUik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(5023799004)(56012099006)(4143699003)(11063799006)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WZj1Dd6ucF/FTCglke4JzkhmFMrmZ/5suw0xg8IWs2s9YuawRBG1vaNhi0fr?=
 =?us-ascii?Q?mCs+44O4Ybp6XTFkWKNMEYfISczmPzHC++qzk1ELjqH+iYlnvtrlXVS+lIHW?=
 =?us-ascii?Q?UDSz86EmOn7wFLZBpYP8jBPHIPuC0OQCZECLeKwDiZGPpbZb1j5Cp4SkSFq6?=
 =?us-ascii?Q?Ae7J9HGN8J6EKVBVYH+RbbDj0MqPmps3v/yrKe04lny8ix37SevQbmD/EHRf?=
 =?us-ascii?Q?s8ojirMlY9MfAbWqdlvIUkdp5kFj+k9j/k8htJS3GIz3baJsmdSImK7HbFrm?=
 =?us-ascii?Q?wET2ld2Kqw+q44NG9/dHMSQeCu8YVUGmWbp7KPqpNWwFDh8E69z5t9O4Mi8l?=
 =?us-ascii?Q?jp+6RZtjibTzVjNJOyYOyEn9YvlV8kYSw9UHonXFHhHG6p8VT5C8IzItFRFK?=
 =?us-ascii?Q?YS9QLvhYjMfvCCe/zkJ0j4KYa/EiiadrwhTsSl2RcZNq76KcFH7EhXuzzwXr?=
 =?us-ascii?Q?Ue5MEyxc7uqvr1c09pH1HVtiPuFkK8j6lx5XqR3R0tYDIHtsDjx4W5bjldWF?=
 =?us-ascii?Q?zJoKNLHD4Qmml/QZWKBLaQiPZAeqH8iwFdPrRewU6paFdS+QwKc8Pkp/D11Q?=
 =?us-ascii?Q?Sn+I1fU0pJ5vCEOaETAG8MGKIPUk5ZQGCXk+DaglpwjfDe5ue4EcFs5GDQca?=
 =?us-ascii?Q?7ycxGV2P7JfZc8JRoKY86qHBpKXRQD9Q/Z8N2NyZiIq89y7qtT6hkw6j97+l?=
 =?us-ascii?Q?HFdJ4rqoOuIuxbXxSlH9qX7Y/sB1VGJPpg2815xTq34Fnsfkfo2eKRN4CgVU?=
 =?us-ascii?Q?Kl2+mID7F4Jb5NY9Gr9IA3oeQGR1hu8CnKUPUFXdVysdqbsBPCS7KlIRFGbN?=
 =?us-ascii?Q?3Knrs01gaR9bkJ5tycf2kefd1hBPCTseYBzCah9nh9E89iXyUfgsNlVNXPLl?=
 =?us-ascii?Q?4ewz2nh4iTminOKqJ1+CUrc1AK9iHQ/dHfOubtvEwNu1aAtcnZDeHJnxEkDc?=
 =?us-ascii?Q?ucLnUWTA9JbH3Kbw3umujmjhRC8u+cd+hXogmTO5MUX6Z45fkqVGTeNgG0wa?=
 =?us-ascii?Q?tkEVBKlKQj1A8Er2f5mf3vHbyhO4dSZBZgVxtrUmfzWoxysAILeZOmfo/ZNH?=
 =?us-ascii?Q?DtcblbQWU/ncGsRNgLpvM7bof30XZBXJCy1PUdgsGuCa4ylEYUfbyJ3+E9JG?=
 =?us-ascii?Q?Prf1/upDndK5Lrp6t/+zADG19iBeOB2+ppf1LTRFGBPJ2ZCXVKmOplb+tC1O?=
 =?us-ascii?Q?GR8ogDTQQ/fT4MVPKIJftL2djcKgZKut+i/T9/H5AInKOChLL3FK6C8cnbhM?=
 =?us-ascii?Q?luKefQo2UjY9a5q9TTiHPaov3SirhgKWeS5HGY3B6eFR3dGnIrIk4UldRCzf?=
 =?us-ascii?Q?3M8zgrvbJLh8TCm7CGWXRfU/0IpCJfhQsVuR8JzeDtL7VjKfeRwYCqpDfn7P?=
 =?us-ascii?Q?rdES2GD2Z/wHps8v6qAfZ2U0jPPAxn0u1V+xEhUBPGVv+4okI2jn6SUlV6eZ?=
 =?us-ascii?Q?LzKTJ2JlzpTVIbSb4m7AdF1SEzvBWdlZliKSsEzytsLXs/N295HwRkqzZ04s?=
 =?us-ascii?Q?CENWmpKke564UCseoIWFoUIr49AzjcBQjZW+VFtGwasnyhafahW2ZNq0/uND?=
 =?us-ascii?Q?PalCFc6iswCFfzeB+7jjtYdnwHOw2WvNcD57C1TDh4aZQvvmuvXArQrFQGoq?=
 =?us-ascii?Q?p9J3ByLgYGaGb8v+PR3GE6xF0Ekbeg5RExtf5vkpU2G1LZJWk3tbrtwuPrEX?=
 =?us-ascii?Q?r+KPgaNQWAzkCDapEdt6sENeONeFs1D7wRg2Kz/w3ag7qx7o5iw1VfmYY3m1?=
 =?us-ascii?Q?HIOUZ/uHHA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vRPoiPpOTGBoZr+5UfsjtldKR9JR4Q2ATQmDXZdcopc9ZQJqsM0aMK/fmQpwCTlmraRdLWsDNiIAnpB+qHf64U6JbFBSWZ/5A6wfFyohrINRmJNPSvQWp/aNfQZK/gqzQzzsYb6hmvrJnE7dULnVug8HFQ7U+qySdTpN0FV48LU0l3I5Orhh5oW8e9VGWyuTxHY5TVc1QrUwK622QPcSodZCiihD6u6wtsZqFZyLLm0fl1J5OY45zTpRYrmrQaIbq0EPHGfvtTcm87eifRBLi1Bo+01lwsdAzeV7QjlDKv8ZwytTyM9YlpKQHZgNLVrxNtJ+uWtj3NlhF2Bsy9ZaKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d02c8e-afd7-4475-fe32-08df2b9f5757
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 16:05:47.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkQCNtnGjwjVVnNUsReygbBAu95DVtHALRzDt9PWLWpPwKgv3biRVVt9ANQYmi2zYo+jSwOThKqDa1e6Prkhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1BAF94C4A
X-OriginatorOrg: intel.com

Bjorn, Logan,

Leon's position is clear: "NAK to anything that does not fix the
hypervisor first". No concrete failure was described, and no change in
this series can address it. That leaves the decision with you. Two
facts: AMD guests get P2PDMA today and Intel guests do not, and HMAT
does not exist in Linux yet.

Thanks,
Pavel

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Friday, October 16, 2026 8:32 AM
> To: Popov, Pavel E <pavel.e.popov@intel.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; Logan Gunthorpe
> <logang@deltatee.com>; Jim Chow <jim.chow@broadcom.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Radu Rugina <radu.rugina@broadcom.com>; Alexey
> Makhalov <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>;
> Michael Kelley <mhklinux@outlook.com>; Lukas Wunner <lukas@wunner.de>;
> Rafael J. Wysocki <rafael@kernel.org>; Nathan Ciobanu
> <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-list@broadcom.com=
;
> virtualization@lists.linux.dev; linux-hyperv@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
> guests on Intel hosts
>=20
> On Fri, Oct 16, 2026 at 02:55:07PM +0000, Popov, Pavel E wrote:
> > Bjorn, Logan,
> >
> > Could you consider taking this series despite the NAK, for two reasons:
> >
> > - Parity: Linux gives AMD guests preferential treatment
>=20
> This is misleading. You did not propose adding Intel processors to a whit=
elist, for
> example in `cpu_supports_p2pdma()`. Instead, you explicitly added a check=
 for
> whether the system is running in a VM.
>=20
> > - No alternative: the HMAT solution doesn't exist in Linux yet
>=20
> This is not how open-source development works. Let's work together to fin=
d a
> solution that works for everyone.
>=20
> Thanks
>=20
> >
> > Thanks,
> > Pavel
> >
> > > -----Original Message-----
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, October 13, 2026 5:20 AM
> > > To: Popov, Pavel E <pavel.e.popov@intel.com>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>; Jim Chow
> > > <jim.chow@broadcom.com>; Bjorn Helgaas <bhelgaas@google.com>; Logan
> > > Gunthorpe <logang@deltatee.com>; Radu Rugina
> > > <radu.rugina@broadcom.com>; Alexey Makhalov
> > > <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>;
> > > Michael Kelley <mhklinux@outlook.com>; Lukas Wunner
> > > <lukas@wunner.de>; Nathan Ciobanu
> > > <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > > list@broadcom.com; virtualization@lists.linux.dev;
> > > linux-hyperv@vger.kernel.org; linux-pci@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and
> > > Hyper-V guests on Intel hosts
> > >
> > > On Mon, Oct 12, 2026 at 08:01:40PM +0000, Popov, Pavel E wrote:
> > > > > Please read all of my responses. I was explicit about why the
> > > > > check inside the guest VM produces random results. However, your
> > > > > responses continue to focus on the guest, which is not the proble=
m.
> > > >
> > > > Fair, my earlier replies were about the guest. Taking the
> > > > host-side points in turn:
> > > >
> > > > 1. Host topology decides P2P, the guest cannot see it, and the patc=
h
> > > >    says "yes" for every pair regardless.
> > > >
> > > >    The topology is accounted for where the knowledge is: on the hos=
t.
> > > >    Which devices land in one VM is decided by the admin, from devic=
es
> > > >    VMware has certified for passthrough in the Compatibility Guide,
> > > >    and on vSphere 8+ by Device Groups, which hands devices sharing =
a
> > > >    switch or interconnect to a VM as a topology-aware group. Hyper-=
V
> > > >    has no equivalent grouping; DDA is plain passthrough, each devic=
e
> > > >    assigned to the VM explicitly by the admin.
> > > >
> > > >    The blanket "yes" is not new either. On bare metal the flags =3D=
 0
> > > >    whitelist entries say "yes" for any pair of Xeon Scalable root
> > > >    buses, across sockets, with no knowledge of BIOS P2P settings. A=
nd
> > > >    cpu_supports_p2pdma() already bypasses the host bridge check for
> > > >    AMD Zen on CPUID alone, in guests included. This series gives In=
tel
> > > >    hosts what the tree already does for AMD; if that is unacceptabl=
e
> > > >    in principle, it is unacceptable for AMD guests today.
> > >
> > > If you had simply added Intel CPUs to the list of supported P2P
> > > devices, I might have been willing to accept that. However, you added=
 these
> two lines:
> > >
> > > +	    (hypervisor_is_type(X86_HYPER_VMWARE) ||
> > > +	     hypervisor_is_type(X86_HYPER_MS_HYPERV)))
> > >
> > > This makes your case quite different from AMD's. Their check was for
> > > hypervisor, which leaked to VMs. And, yes, AMD does not work reliably=
 in
> guest VMs either.
> > > For our internal testing, we have carefully curated hypervisor
> > > configurations and test VMs, along with custom patches, to test P2P r=
eliably.
> > >
> > > >
> > > > 2. Regression: consumers that work today via a system-memory fallba=
ck
> > > >    will take the P2P path and break on hosts that cannot route it.
> > > >
> > > >    A wrong "yes" fails safely: without host-side P2P the request is
> > > >    stopped at the host IOMMU, nothing is corrupted, the same exposu=
re
> > > >    an AMD guest has today. An unconditional "no" is worse: it block=
s
> > > >    P2P on every host that does route it, and the guest's answer
> > > >    changes nothing about whether the host routes it.
> > > >
> > > >    Xeon Scalable routes P2P between any two root ports, which the
> > > >    whitelist already encodes. The only hypervisor-side requirement =
is
> > > >    mapping the peer's MMIO into the VM's IOMMU domain, and that is
> > > >    what passthrough P2P support means: on ESXi it was an explicit
> > > >    per-VM setting for years and is the default since 9.0; Hyper-V d=
oes
> > > >    it for devices assigned to the same VM, as tested on Windows Ser=
ver
> > > >    2025. The decision is made on the host; the guest only has to st=
op
> > > >    vetoing it.
> > > >
> > > > 3. The hypervisor must describe it, HMAT is the way, NAK to anythin=
g
> > > >    that does not fix the hypervisor first.
> > > >
> > > >    Agreed HMAT is the right source and should take precedence: cons=
ult
> > > >    it first, this check only where no HMAT exists. The disagreement=
 is
> > > >    on "first". Guests on already shipped ESXi and Hyper-V releases
> > > >    will never get HMAT, and those stay in production for years; the
> > > >    cover letter's note on the adoption timeline was written with
> > > >    VMware's input, and Jim can speak to it. Until a hypervisor emit=
s
> > > >    HMAT, this fallback is the only path that works.
> > >
> > > This is VMware's problem, not the upstream kernel community's. If
> > > VMware considers P2P important and its customers agree, VMware can
> upgrade.
> > >
> > > It is no different from any other kernel feature.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks,
> > > > Pavel
> > > >
> >
