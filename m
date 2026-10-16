Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867A389115;
	Fri, 16 Oct 2026 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162515; cv=fail; b=g8Sb0xprl6fM4DfTazwKBTG4Kfn3r9iVzZu9LQZtlTrxvdeNgHGEXJW8BuP80bI+3fd/7TK5SkX/X/xGAn2eHiSZ0JwOjV6jV8cYgM52tbNumRk/4w4dcBWS1aPCDaSwCfxhEFTgQHsAJjhDu0G2LsX4rgmIz7ASuGJXYTXLbg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162515; c=relaxed/simple;
	bh=PP84QFxmxAezp6Ng2TRyStYqcvYhso67aBuL312Upng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LaWGA2XufFOhKecfmzHbRKuGflSoU0Cbrucw5uu91ZUq2oRKM6sM7iTZqdJv9cCquth9mu6zjzRnckiwfKJagqvGOuDkkgMGHv43NOcrPBAQXcRhGtbyU8IxpVx3CXrUstMsMxdM6CHfsP6zA2kheo7zAybcJnH2a9Zh8fIrWhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHcAj0dg; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHcAj0dg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792162513; x=1823698513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PP84QFxmxAezp6Ng2TRyStYqcvYhso67aBuL312Upng=;
  b=JHcAj0dg0INHtfgy3IZgvopYyk4c5FJsVhK9qUWQWGJza//ppbFsRvdc
   b4VXZgdOtkdfvPKc4IrlYLa/9Ra/uk1dmzejW3wEU/ntIfxYLOLQqHRLa
   odOTHLnzajV7Uph9czFVmt/modhtAGCr4kTgAOOKCahsbcOLlIVA8PbgC
   lZQRFK0EoDYjrUFylHqlxxRNC4TozOqgpBh4SQlfq/2b/a6yEsJkqbnz8
   HDnIt3h4nxVdohu31Gxc2d5gDO0KK9dOKrR2iJKMrt3MsZS9wHY+xOiK7
   j141i5TRGsEVBTATyMUxHJtkyuXxx7J1Mp8koX+Zo1sS2ntpvaRJScq9E
   Q==;
X-CSE-ConnectionGUID: BF+WYVQ1TzCsk9E6+Lmtvw==
X-CSE-MsgGUID: UTIF7msQR/uew1kz/FcviQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="930191"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="930191"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 07:55:12 -0700
X-CSE-ConnectionGUID: FP1TXN7SQf2tvZJ8xi+xFg==
X-CSE-MsgGUID: Q0RZsOFDRc2by275OpA2pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1939813"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 07:55:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 07:55:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 07:55:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 07:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/ieIR9nIIJcQxCTM/CI8pI4kgYXfbUKGAJt4MRbyV+MoOjeD8cjBiPbGwP5V7xoAWnR3zVfgrNqotXgJFNlDWoH2Aq8h1hUbw5slyCbaXm9y9rv83BQ2/5A0B9FpWoaBGySpct4cnpQAJXIwVZobOGl2sYp0syXb0vYaLEiFM5W0QVNixNzldKlGc4s4y3UTwBvRZoh7YWi11fWClpP5punuge3ExG0KM9xzaXIwjBuRAkJHZkwQRUeLsRJ9XFFjrJATRrMQIFcxAN+Y4cbZ0klMrxGi6NzQi3sl33AuBwnc6slPn2cR+4rTi4ddZp3tppyOpGidFpZzK/Qoyi+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IkQs+TyzLkUWZ0hh0yFmm02Frs1t2BjbpQXeOXplVk=;
 b=qBY8alQn1GLHslXCZNy/mN0/ahHb0rubSBj8SfOeJBBDJ95TEZ2lzkxh3B+pDoHnkvlxRW21GM5d/FjcnjkoZArPGn0xU8VgN3KllQ16mvRYXFcfgtYl2WTKGbReb/Y7zQ8CneF98pz53/ofChhZ9ije0ffGFQSBUFfu/Nyj8+MGI+lxk4LrSGPnwn2X/9mOEulta0e+tFswdEcd0Ym31wNerigj6cKg+WX26z6xxevVVOF77Crn+T2AmokHo/VuPiYq7TWpqHSTxdOxVYVlZ2vpyrswf4+8vNNvDb0Lwr7DReT8rNQSOOgnGiX8SU20umi/gWSQv5Pj7IsakEQMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by DSVPR11MB9695.namprd11.prod.outlook.com (2603:10b6:8:351::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:55:08 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 14:55:08 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
CC: Jim Chow <jim.chow@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Radu Rugina <radu.rugina@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Leon Romanovsky <leon@kernel.org>, Lukas Wunner
	<lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Nathan Ciobanu
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
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iCAAkgrAIACGMTQgAArlwCAAACJAIAAIDMAgAAQuKCAARyrAIAE4THw
Date: Fri, 16 Oct 2026 14:55:07 +0000
Message-ID: <LV2PR11MB60704D89055FBC471FF81B31B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261012182120.GJ219304@unreal>
 <DS7PR11MB60647FA80C6BE1029982222DB29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261013122002.GN219304@unreal>
In-Reply-To: <20261013122002.GN219304@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|DSVPR11MB9695:EE_
x-ms-office365-filtering-correlation-id: d3ce050d-ca08-45a7-57a0-08df2b957871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|11063799006|5023799004|4143699003|22082099003|56012099006|18002099003|6133799003|38070700021|10067099003;
x-microsoft-antispam-message-info: 7+K+Jh91aweKx2u33CKu4pGo4p3QhEZLEXXTnser6LFB8YZO7ck00fOz51QFb2+Q5v3xX35Glw3s7a5q/KyXKyV+IMZDkNHp0YbFSV6bioWksnoLGVjO9kMiwa8Xh6/UnturXX7n9zWsmP789g4Ali0Xwe1fXGC5geeKx8jN6PlQ39P4+aCOQ1rVpgA4JzrRl0hxFCW7VK4oDV+loxOZToodqNPvegUdOajbYt+2dRHs9MY3nXbOYQVkWeNmk6lhlY6b7NOCyMfWaZIMwuXx6Q04q8WaHMhSNzIsZS9VnXQVoGGq6mXKCAXIU9oJNVN+BUC7zVSBkRdNjg2P7ygsga1VrOtTzzFAfw68Tn9qZid8EEaHMkAef75/MY4Eabs6jrZKb8ulizFIOp5Vn8ePXz7EmC2WXDBAuEC96Sn10CpNkvDiM4+fv2EFZIqGPa3cIFnI0OkHqwFfdkwiKTbzzPgAm+XgAEnSk7v6zQhmj3K/Mh3E+yjW8Q53zCJRFNXFxMhpRG81tvxjzN0yrtGyNGzKNk6Iq2hJ3xBGtkvz/ipR8AgG0BM+SQQzG0eCCDkYNxl9AaZhqav8w1F8f9D6EFv22smMRDdmxeg6YKwFOusDOipibHBvKtKR73fgbO5jL3EVGXPcLst4WfISQPhrxOSZNMgVbKFBOhbKt8rqOC5/nNH3OuvEYe3ZBjIKl36shAJQpo0ik3OFEmZ+Za+IC+Q7vO0LzmPvRjWtttS3AWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(11063799006)(5023799004)(4143699003)(22082099003)(56012099006)(18002099003)(6133799003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PrlFHFLe1f+0ZKclQGoVnRaDPEZ0cJUAr4MLlTTcALwjuHJKJhZWBbytv1ct?=
 =?us-ascii?Q?BY/QoxzykqbOTlnW9CJrxnWpmHxrWvsLVkylwFHs27V2Ztk7KPp6pknNJL85?=
 =?us-ascii?Q?4e7JkF5UeYHw4eZRTRChN3D2LBeQBqofXVHDzgOoEKWeGsCp489pZ7T79O1W?=
 =?us-ascii?Q?BAqRPVtU3eIeEcIZ2HCIfVc5EcXZX4cYvjfqn6YbZaO6J9DK8LiC2I/21PJe?=
 =?us-ascii?Q?O1IKTf9xATm+xNDrIx936Qh7+Bok4TO3Op/637NrcKiEpfJOSn1f2YZq9uLA?=
 =?us-ascii?Q?mYQ0YDEAtyNVTDHKsQ5GrNRuo8thYiWnCDTfSh3s+DTOCRrC5+mmjFjTdAFE?=
 =?us-ascii?Q?w0tCN+dIdDacbvEVLnx+e77MW5W/f2SEmevTLxLKV00uE0oXptySJUCA8i0M?=
 =?us-ascii?Q?FKiSWF/oJQ0Tv/JCKN7xWId7QueSuPZtHYH1+o4dopbZkT5ta74sz0KoRi98?=
 =?us-ascii?Q?XOg027tnX4XXZjusonDKTLGasfY/zAIqtFAPp3Cj+hIVd8jOlXUjkNONWQ9s?=
 =?us-ascii?Q?U7C28XS+UikAqlYEDz/YSRBQlqqCUn9BTUQVwFJEMYb3+OcbZlcXExDTwsBc?=
 =?us-ascii?Q?mvXgPFgOaO5d1ozy5X89YTSSSNJqusAy9AkbOTPKzK319e6sKk6FH3IvrrL/?=
 =?us-ascii?Q?mGP7UkDO9jykb9JZomvayjiHl+QjbJLnBr+s+FUFGiHgcR2B+wo5CGXVUxbJ?=
 =?us-ascii?Q?W/sKelDBbEst0vHUA870m5qYrIQgarbnKYKM1sHaLjAjh4as3Xaqvs4LtnLL?=
 =?us-ascii?Q?IwHCV7wDTGo08XyldvY6kxcijQ5TemlyMh3+Rmjuq0EMnUfutG+K42VDPgOj?=
 =?us-ascii?Q?a64+frKrv3BlmGIrSzJAXUeuk1s8M4H7dwCbo7zKIbQeZlrBwawYsfNYwarW?=
 =?us-ascii?Q?vONPvD/jzxtkc9Pq+Suqjt8qCSPC8lKDxvEhhPWNGK21edYKt3x9U7UlmkLK?=
 =?us-ascii?Q?8ZJj+mDtTRebOCta1vr95cWF4dYdsZ1hzwZzFtfrlfRYkwetuGU4RsvTnQJQ?=
 =?us-ascii?Q?AFrBGPiQ0Bm5XgF1mLSHXShAK2mIZWXSv2lIlb3L9ngYtEzyv0xSm0FaqGjb?=
 =?us-ascii?Q?sRg/IXm4E9LRZAmsTeJDgxa6c6v1Ra997JTL7qe4oWxpghvSdmFUNWJAQlg8?=
 =?us-ascii?Q?LjOG3bjCCGs9yHy8YhZnMbgGWltNfYP/QLg8XPQKsCJWQwUkj63XA9ZBT1QG?=
 =?us-ascii?Q?GfjHlMmc/6C52jPDDOyTIESR5OGQnqjWLsI/fHra4q7GeT8qJSYWkDgxaOiE?=
 =?us-ascii?Q?hlGh+AlZHWyuWVUt8z78NrF/BAUgml0Aay7i1Aw62XUV803ZkpShrEvX/dlq?=
 =?us-ascii?Q?qJXMnH40RW5V73pBvBphRpJ1TDO4SuEZFwqIYd4a7POzj5xuv74ogtVnfkwz?=
 =?us-ascii?Q?Cg+mFbLUjKgJFIO40/d/kGT5/PiUAyfNlgSvVaU0xBHUWv3iyiKwmk/6mbRo?=
 =?us-ascii?Q?4v/II/GwMYllxmDDxyabVlV686uK1G4AQUP58KaMtGQDMINkX3dtIiAMV74L?=
 =?us-ascii?Q?5irwwfpKrbKnxRFJ7TaHFwlKCWzYWI25Tp9ZIfQay5CfNmZzkKctRjfUJVr6?=
 =?us-ascii?Q?I5ZnPL7jruCiZfDx+kIwmZ1j6/+NoLQLQ51t2Dr+c3tWbRQQ22Ta2+IzFNxA?=
 =?us-ascii?Q?X0q8Jl8qiBiOwQgd179XcI44M7PtPERSFVW9jN0AYuBJmDLMBjHPeaTJRUlu?=
 =?us-ascii?Q?vcTrqsI4u5Wc6QDU+7MDNiiVzHqtIFCwtTElw7W7RO34ZmQOxx0Vj2UaIK+Y?=
 =?us-ascii?Q?k9pOdInkZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qHERCpkdTuLAjIg48NN5Q9J8OtVPUkg8VNYO8jReH8mBHoj0ASmJAfMWgWZa5B/bfxjRy/IzwXzNuwvwNX1ZrT1M/MJjMZsdPrALOXfyn8/MVx0tjnjXkkjIIqH2VCRC4eREOHM9K8D8si81zDB4cCEZrCcDo0jpXxk8VTWwx6CHvRCWPxqXTudw7aPwVECppV5IOW8hCDjKOqH2ScmNE7rE95LT+CbH2KZAleYqixY/suYo3pLCNtgoRMKKdVAeZVzS8Nad5CSd3t/tGQ60ZbqyOkhgP/sPsXQXYKCaMjpMXDZ9Ku/vWE666YxrK7zbww+Hyfz8CuGzVp9nUujWiQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ce050d-ca08-45a7-57a0-08df2b957871
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 14:55:08.0212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fagNfIsy3XkdBZ/X/P3m3jXQZ400IlSCcAxWjeZwncqWOJCy8Qa1JVvBuOVGzVE1kUX/hlbREGaLUu/ZrRvoGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9695
X-OriginatorOrg: intel.com

Bjorn, Logan,

Could you consider taking this series despite the NAK, for two reasons:

- Parity: Linux gives AMD guests preferential treatment
- No alternative: the HMAT solution doesn't exist in Linux yet

Thanks,
Pavel

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, October 13, 2026 5:20 AM
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
> On Mon, Oct 12, 2026 at 08:01:40PM +0000, Popov, Pavel E wrote:
> > > Please read all of my responses. I was explicit about why the check
> > > inside the guest VM produces random results. However, your responses
> > > continue to focus on the guest, which is not the problem.
> >
> > Fair, my earlier replies were about the guest. Taking the host-side
> > points in turn:
> >
> > 1. Host topology decides P2P, the guest cannot see it, and the patch
> >    says "yes" for every pair regardless.
> >
> >    The topology is accounted for where the knowledge is: on the host.
> >    Which devices land in one VM is decided by the admin, from devices
> >    VMware has certified for passthrough in the Compatibility Guide,
> >    and on vSphere 8+ by Device Groups, which hands devices sharing a
> >    switch or interconnect to a VM as a topology-aware group. Hyper-V
> >    has no equivalent grouping; DDA is plain passthrough, each device
> >    assigned to the VM explicitly by the admin.
> >
> >    The blanket "yes" is not new either. On bare metal the flags =3D 0
> >    whitelist entries say "yes" for any pair of Xeon Scalable root
> >    buses, across sockets, with no knowledge of BIOS P2P settings. And
> >    cpu_supports_p2pdma() already bypasses the host bridge check for
> >    AMD Zen on CPUID alone, in guests included. This series gives Intel
> >    hosts what the tree already does for AMD; if that is unacceptable
> >    in principle, it is unacceptable for AMD guests today.
>=20
> If you had simply added Intel CPUs to the list of supported P2P devices, =
I might
> have been willing to accept that. However, you added these two lines:
>=20
> +	    (hypervisor_is_type(X86_HYPER_VMWARE) ||
> +	     hypervisor_is_type(X86_HYPER_MS_HYPERV)))
>=20
> This makes your case quite different from AMD's. Their check was for hype=
rvisor,
> which leaked to VMs. And, yes, AMD does not work reliably in guest VMs ei=
ther.
> For our internal testing, we have carefully curated hypervisor configurat=
ions and
> test VMs, along with custom patches, to test P2P reliably.
>=20
> >
> > 2. Regression: consumers that work today via a system-memory fallback
> >    will take the P2P path and break on hosts that cannot route it.
> >
> >    A wrong "yes" fails safely: without host-side P2P the request is
> >    stopped at the host IOMMU, nothing is corrupted, the same exposure
> >    an AMD guest has today. An unconditional "no" is worse: it blocks
> >    P2P on every host that does route it, and the guest's answer
> >    changes nothing about whether the host routes it.
> >
> >    Xeon Scalable routes P2P between any two root ports, which the
> >    whitelist already encodes. The only hypervisor-side requirement is
> >    mapping the peer's MMIO into the VM's IOMMU domain, and that is
> >    what passthrough P2P support means: on ESXi it was an explicit
> >    per-VM setting for years and is the default since 9.0; Hyper-V does
> >    it for devices assigned to the same VM, as tested on Windows Server
> >    2025. The decision is made on the host; the guest only has to stop
> >    vetoing it.
> >
> > 3. The hypervisor must describe it, HMAT is the way, NAK to anything
> >    that does not fix the hypervisor first.
> >
> >    Agreed HMAT is the right source and should take precedence: consult
> >    it first, this check only where no HMAT exists. The disagreement is
> >    on "first". Guests on already shipped ESXi and Hyper-V releases
> >    will never get HMAT, and those stay in production for years; the
> >    cover letter's note on the adoption timeline was written with
> >    VMware's input, and Jim can speak to it. Until a hypervisor emits
> >    HMAT, this fallback is the only path that works.
>=20
> This is VMware's problem, not the upstream kernel community's. If VMware
> considers P2P important and its customers agree, VMware can upgrade.
>=20
> It is no different from any other kernel feature.
>=20
> Thanks
>=20
> >
> > Thanks,
> > Pavel
> >
