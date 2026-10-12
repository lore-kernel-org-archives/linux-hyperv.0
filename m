Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A330F819;
	Mon, 12 Oct 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823521; cv=fail; b=Ia/hyw9E0MYHdAxo3oOCocrugp3Fjs0LRB5lpdIgvuwFsopxTD/iMm7n3uFsjk3kdqDxymbuTM3wRB++I+98YfI5HU4ywXkp3wTxmcK3XvJnJFZet4DyK7n+jwJfWOUwIGkdzyZ0mBNJ00NmMfs8kPul26B+puQGcdpjj7Z2jng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823521; c=relaxed/simple;
	bh=N0WbJOgTBhTeShmDdlpYDGfoPLoB+Gb6sf0dEbCWo3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=meDgC0UfMt38v3wVA9QjrkDMWJcFrD4DhUP2y6ZikaOu4Zk98KMTlTyOuJWpDGdO/lioStLUFAXsRyiavPVCgO1rCjZLiqmy1VvL9PsvwWf1Q9QpA9O77wEdwt5qzhYzLqGFa+cAWHYsgiuUYnzPeGcSbwwpLFyHCkAXwHuQLTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZugIOnH4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZugIOnH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791823520; x=1823359520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N0WbJOgTBhTeShmDdlpYDGfoPLoB+Gb6sf0dEbCWo3I=;
  b=ZugIOnH4E+1WL7CTiTT+WMZA5o2rjeNf+ENl9aEtOK92WzEWtSITeUIQ
   3fIX+pQOq45AUuia2kSsWzUF4rRbfF43f5pKtgYo/zdzSK5J/07vusGTB
   sizZ19ANvmYsHouuJB8U694+Oq2jnn5SHvrHVEMQNX8HxM/FvBTTdq58F
   3dJmiEnwf7VuVrx9O8qz4BdaXQvA23V9TyAbyzBsWrJ66e5KWO7dv+gW2
   N/1fehq+d/oUi42u8eFAgRKt5WYZflJ74R5i26TZMdH2FdzTeSqtOYin9
   klkiBgBMLJlIOxyeP7h37WLs9S/fedb9pUYhaU38mERE0zMrb4DwWkgQo
   w==;
X-CSE-ConnectionGUID: oUVOsSAGSOiv3hH8cg5fLQ==
X-CSE-MsgGUID: eGbqiMJJQ5yb9XN/TzJTMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="551343"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="551343"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:45:19 -0700
X-CSE-ConnectionGUID: OQQK0klNT1SVHLaSOvEVIQ==
X-CSE-MsgGUID: o292Iqc4SuiB3Ka4upAH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="897622"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:45:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:45:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 09:45:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f018SlH1lfDkCyjnbY7xbQnBJn9V0xuM6SsnXDoNyOY9vZjcfnNeBXTv+zB7QUGzQduF4A5PpbhqOHy1qJkEKQgTDI0wYMV4Apd88lb2wZt6cGE2gBXN+/6Ap8AB0CdZCFhzHfut+jMT5Mg2UI/opXePaUTOk702CmbGAbeErCIF0JRVsg+O5JOh+3w+wpBveoqqrLK9khK1L7+PioLuLPekFXCV8OdOproLrMnRk3tblPGoTCmJOZNqITVT3nDqpHPlfqT2WiQL7kc86wsJqbrshEBbNR6jBzSeNGQUe8kRMQS6yX3hCzma9nUaufE4Xp74MonICEbV9eoK7cZiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QZPb7782sXfKzUcl0NEKj8vSaWfNdYBr8I8IEqeOwQ=;
 b=UCKsEOdrIz6bELYEzCP++Ot7ObcX4LKvTauaC+FefP/1NcIGrBQKc8Pt2X0yTndQUsI2gm+uyAB2VaZf+mLJGAWeo0bEQOKrTEmqbgx4P3kWG1ZwVVGO5w1MZUknbn1XRa3+Nmm6r7e4TGhnD8AIbLirOD2swg5bqA3uYtEt2aIllElbQDWGfmU98wIpHn0pr8wRV1x7LlCLlo5Bi16Fwfx5mnRaZsIdSPDin3zxebcSv6MufmbAJrzSdAJre+LgK3rgu0RB0jO+cKkSpurZMaHblaH1WopC2MnyqvouP/XuhEdTxLk4V4a0DpbbUxvDgFZ6sK6CpcRVNnLrWR8Z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) by
 BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:45:08 +0000
Received: from DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::953f:2b9:f2d2:43d5]) by DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::953f:2b9:f2d2:43d5%3]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:45:08 +0000
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
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iCAAkgrAIACGMTQgAArlwCAAACJAA==
Date: Mon, 12 Oct 2026 16:45:08 +0000
Message-ID: <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas> <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
In-Reply-To: <20261012162410.GH219304@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6064:EE_|BN9PR11MB5225:EE_
x-ms-office365-filtering-correlation-id: 476d4a2e-262f-4d69-8ec2-08df28802d07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|22082099003|18002099003|10067099003|5023799004|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: TEdigLasT7dtfIKlMd2Jugxqx7sxpBsaDOFDFC2YyddACY+n/rlscW35MRNUwxqguZ7aJYQvMALBwkM+6G3Z86RS+fsZAPxBYqL8Q5Y2N1N58P/PHmJxotnJKEqpNuaURvRKfsI0g8IQMIVuAIRc6ldsMAlqgRIRO5SxKnuoz5OyuObftkgvRM+taS5uguoCL+UflM6qWp2yWVDS69a1OzwJWZDfQ3Ngag0duJiLs2gdFnjhi3b5lbUvKOzU+eRm/LYJX32Rbh1jEv0uHh4xmKbXUawP9+050/EYgxqbLrxXTd3J3yeWChv/qUzqeX8W0QOH+KiZd6dv5I5jLE/N9rDNwiFyRoekFPrbq0XI9cgUPAvu28gDKKvXfMW4XyqdTOFVvEwwb58n4qCv1ZtANhr5d+CI5EZVsAG+4UZ1sa47BIHpdvqSpy+1CudbBz5w5joCY5XyaKw6u220Q3uO2t0FRQ4RL/6isbttgLV+t5bFCqwZ3qlINCQuoUDrCkrPaq+zeEdbb2ZTh7uHKGd5Isn4qEHiF54QsKy/sYubvMv7wIbgZQQeutbIIyaJHrX9Heh70s9Y8bilp4+DGya7umUg3NuWj2WOh28uZpuiQIe64mEGkHA3OFNCK/Tq6oia2NcIlkQBwXzE8WvHmdiUW2WRLv/g31TWa3AbtYFXGLqAtjS3s5m/y1zpHRsrgJsLTENTU+iVrAcL0CjMcIxytnNZ35A9LPxDKLFYOQ60QFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j99WsZIBvuu1Wu4aW6rCMwXe1ylOnAwS5RXNBe3ipyaUsJR1+XfcOkWF7Laq?=
 =?us-ascii?Q?AjTN9B7RnzNsDKUmLCax3+MO43ViC9hBM80BVRVlJVLxxx/f9cvpYc3sMGwi?=
 =?us-ascii?Q?Kzv4QfZPJyjSUX9c31RqUnDJDAMGBDhMhVv37Ky7AeGVKyB/FJ05uqTPhtDG?=
 =?us-ascii?Q?+ZEjTL0NTFt277BRD39nvrFqycY07A+O2jRlHcU6mNcztyElacYHlyWnEu92?=
 =?us-ascii?Q?XH8Djg8ExZGzj6Qybocm5kF7CFLWt10JbXgxSj62KnC68jM+8by9vZCcuQWG?=
 =?us-ascii?Q?kKdkVgvnwD0ZnLunc3mfJ9kytn8KLbqoQu6ax1nifA6Y9qiQMXlGNj6Y4xRe?=
 =?us-ascii?Q?UqgcuynRq8JzxVokHjryZtPoEPitYgNkyEUHGhOH8Ek9bdxbGQgrY7kGZbX2?=
 =?us-ascii?Q?USVAkXH8jwD7dfq7+Ww0WmnE3wirYctiR+NSQmmfr/V7/rRO13osDCtccyWz?=
 =?us-ascii?Q?BkxWkz1tQAU9P93rcQyCpQ4tz5nmrlMuuddU5kYP6crdeMgS0DWF8zgNAI92?=
 =?us-ascii?Q?O9sXOstc3UYZ2PmbGV9e9lg283AkiMnhGXdSSC5Gk+8PxbeJdrLQiUxPeUSm?=
 =?us-ascii?Q?JCaCnbgjZrr3Ekl/zPGQ2Pjf/7dY9F05o9aQfVlq6PDczvoeqNCa/VTYm4b2?=
 =?us-ascii?Q?JXJ7EiZA5F9J404s0lAkpy8TtI2r5MLMRgeamFQ+0W5BluqzNQxIHmheCEwA?=
 =?us-ascii?Q?2PQHg4O+TjtmzNQy6yddL55s9OthKaS0WkQ00qVpfk4twe6BGNQ6xFxGQO/C?=
 =?us-ascii?Q?wOQy8dd5gvqRN3EiE2dUBX5ywi0hIBTfcoIKjtN0qK+gl6WW8cEooe5bpwqn?=
 =?us-ascii?Q?jaNN1Bo34brBghbpZVmRw58ka1uDkmKh4ew5ZVpXk446aZA2sCumec82xlDs?=
 =?us-ascii?Q?mcWb1GOBg7fVn/7u40sG/mXDg31Zls6a4Zq2Gs7smPxAKvN3yxFR/LccjV3j?=
 =?us-ascii?Q?4z1DY2TUvwJ0cc2EaMSv/RYpDYTq8raZkqaPn1YrlNbHwUQmkteMP5ach4VA?=
 =?us-ascii?Q?DlCRpyFUzgVjz/Pc3JGU7qvrMt6v7coB6NiZd+6KHzQHCA6DBh6w8+/mYrev?=
 =?us-ascii?Q?ud+CBcShE8lr56pa/eXzZXIYxFY0qnUsv0ZuQFZW0fr5lnsS+8Dk8ZNDyDiW?=
 =?us-ascii?Q?9rmVaYQuphfLjxTCPmbIKSbTw2W/vem9O4n0u2Gbhwf1U5D3Z2CmapQx7LjJ?=
 =?us-ascii?Q?4+FLKEV0+ngzFDWojQ/ZG3ZFpYarFw8all3fakFnjf4RpEzGPKYYyemazjLR?=
 =?us-ascii?Q?AnT/IT7bXjCnc2GyLfIXhIxtzkDSPl2lTM0g/nQegO52DV/4UZzUrDDuoHTb?=
 =?us-ascii?Q?y+fG11c+Gse455Kl4O3+YeJS57CLrnCT2QZvDftdZOvNF2R2Ovk9ICmKupSy?=
 =?us-ascii?Q?yhMZjwg6Oz8e8vs5P0JhiQhOLttup+dVq0Lrdq1XE7ZzsFi06GIh0P9DNzQw?=
 =?us-ascii?Q?3CE/YcqsBuxLFofPc0sbyTh7Gs/0JItsNLjl5xQUp3UvIqGi3ezGwbXQCZuA?=
 =?us-ascii?Q?ZZAYqEM4PHhRN/MCM0FMjtV47pyRHhgiDnglh6535wPrJ6SKKfbnt6PuzgBN?=
 =?us-ascii?Q?iyoFSxmiqdUPYtmbXzJYoBFelo9A1NGdt2150EjnInCEz2NsRdAnf1gkqkHe?=
 =?us-ascii?Q?9cTCusk50uirohFp9hXgpXIAyAFEaLGE8irlVUoePyfWiEGCfclgueOjodzt?=
 =?us-ascii?Q?ZtT7vXXvy+9bXgQWb3d8S6utqB3ynv/rx1cWMhM9CsmsPjb++3syaodLloKI?=
 =?us-ascii?Q?vo9vJra9Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mXX4sYK/igCJy5YGNM1jEiqbXb+Jfv5vSMTfGK39EMUynxtbANwjcCrC10TIs/4bY3rtJPxQ+Pf99SzipDAsW70MQv6fh2EHCMfS5DIrl/vemUY8+b/77VMBm1UmvUMECYMWIudYc+6x41SopmSCdm1UIU9G8Npni6uNyN0BunbYX4IeIJkG5SCngF32z4KCz4lgd6i4LuuKh1UWzbRoa5UDVe4MrUmcqmZstDeVhAJVY/cms0vsPHBZlyBOV1PJ1fxBHeCYdkNUD/O72P34EP+gOSVrAyfrP5NpipHa6xjta+c9Fr2ULUcApWzz7bRTLp4rpJ1+DP3JaSpmnGXp5A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476d4a2e-262f-4d69-8ec2-08df28802d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 16:45:08.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atIvD9+UFuz/NB29k4vOWsDDmKZbf8kcJLWTbdad8qOoLyCsYI+VmjJMXCWSN8JRglq0kRoxNRutvml5JvE7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

> I'm not following your reasoning here. In the cover letter, you say that
> VMware reviewed your work. If VMware wants to provide P2P support to its
> users, it can add the necessary support itself. As for Microsoft, there's
> no need to worry; it can handle the ACPI changes just fine.

The cover letter sentence on this, "their adoption timeline in
hypervisors remains uncertain", was written with VMware's input; Jim,
Radu and Alexey are on CC and can speak for ESXi. But whatever VMware
and Microsoft do in future releases, guests on already shipped ESXi and
Hyper-V versions are not going to get HMAT, and those stay in production
for years. On them, passthrough GPUs, NICs and NVMe drives have no P2PDMA
at all without a kernel-side fallback.

> Of course not. P2P operation depends on the hypervisor topology, which
> the proposed code does not account for.

The guest topology is what the code already evaluates, unchanged: the
common upstream bridge walk and the ACS checks run first, and the new
check is reached only after they fail, right where cpu_supports_p2pdma()
already bypasses the host bridge lookup for AMD Zen. What the guest sees
is a flat topology:

VMware, four GPUs:

  -+-[0000:00]-+-00.0  Intel 440BX/ZX/DX Host bridge
   |           +-07.x  PIIX4 ISA/IDE/ACPI, VMCI, SVGA
   +-[0000:02]-+-00.0  VMware PVSCSI
   |           +-01.0  VMware VMXNET3
   |           ...
   \-[0000:03]-+-00.0  Intel GPU
               +-01.0  Intel GPU
               +-02.0  Intel GPU
               \-03.0  Intel GPU

Hyper-V, four GPUs:

  -[2fc0:00]---00.0  Intel GPU
  -[542b:00]---00.0  Intel GPU
  -[5c71:00]---00.0  Intel GPU
  -[9624:00]---00.0  Intel GPU

The passthrough devices sit directly on root buses with no host bridge
device and no root ports; on Hyper-V each is alone in its own PCI
domain. There is no upstream bridge to share, no ACS to evaluate, and
the host bridge lookup lands on the endpoint itself. The topology
carries no routing information, so the check falls back to the CPU model
and hypervisor type. HMAT would provide what the topology cannot; when
your HMAT-based detection lands it should be consulted first, so this
check is never reached where HMAT exists.

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, October 12, 2026 9:24 AM
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
> On Mon, Oct 12, 2026 at 02:26:43PM +0000, Popov, Pavel E wrote:
> > To be clear about what is at stake: this series is what enables P2PDMA
> > in VMware and Hyper-V guests on Intel hosts. The assumption that the
> > hypervisor can simply be fixed to emit HMAT is Linux-centric. It holds
> > for KVM/QEMU, which is open source and where anyone can add HMAT
> support.
> > ESXi and Hyper-V are proprietary, so only VMware and Microsoft can add
> > it, and until they do, this series is the only path for guests on
> > those hypervisors.
>=20
> I'm not following your reasoning here. In the cover letter, you say that =
VMware
> reviewed your work. If VMware wants to provide P2P support to its users, =
it can
> add the necessary support itself. As for Microsoft, there's no need to wo=
rry; it can
> handle the ACPI changes just fine.
>=20
> >
> > > This does not change the fact that the patch causes unpredictable
> > > behavior for P2P devices in the guest. Sometimes it works; other
> > > times, devices that previously worked may be classified as
> > > P2P-capable and will stop.
> >
> > Nothing "previously worked" here. Before this patch, P2PDMA was
> > refused for every passthrough device pair in VMware and Hyper-V guests
> > on Intel hosts, except Intel QAT/DSA/IAA, whose own Device IDs happen
> > to be in the allowlist. Those keep working unchanged, so there is no
> > working configuration that could regress. And the check is
> > deterministic: it depends on the CPU model and the hypervisor type,
> > nothing else. The same guest on the same host gets the same answer ever=
y
> time.
>=20
> Of course not. P2P operation depends on the hypervisor topology, which th=
e
> proposed code does not account for.
>=20
> >
> > > Help Lukas and Mahesh succeed in their work.
> >
> > I'd like to, but the blocker for guests is on the hypervisor side. A
> > guest only benefits from HMAT once ESXi or Hyper-V emits it, and that
> > is VMware's and Microsoft's code, outside the control of Intel or the
> > kernel community. The kernel cannot make them ship it; what it can do
> > is provide this fallback. When your HMAT-based detection lands, it
> > should be consulted first and this check only when no HMAT is present,
> > so on any hypervisor that emits HMAT your code is what runs and this
> > one is never reached.
>=20
> The kernel community has no obligation to accommodate users of proprietar=
y
> products who are unwilling to invest in a proper solution.
>=20
> Please keep these hacks out of tree.
>=20
> Thanks
