Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792439299;
	b=JlNDiWIXrnwceq8L+F3XeIQb2EAmWBDwtRKRaVwDnPI4bQnNqYODDoCVFU1ID2eM66a6
	 cHW+RP+oqJ8JYiaeIRXYSuxXekTmrZri7RGJQFNgqG0gQu+M9nga+LBjIoIwDm0l9eIfb
	 QP2g3XkITHaBJXJ+p8TMazO4W1/VIxvgLViXxxlTbcs9aIKL8Dbpkte14dYU4oMT3dSXS
	 zoUak1HPexDVFRgd45RmkITfloDGUSM/8Y56Ww0gsKh2Ly+VYpRWFXbjLcFjxCNXRT9qp
	 AvFaJkBz8siGuGvZ+CcGSL/jd55vq0TSmgXkpkL24NSXEzZKG4ywfVsPifA3GLJ4hBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439299;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=wA/GRmzhuKMxHmstEFBdK0UFeRJkvhk2R0BJKJd/G3g=;
	b=UEutWfghe0L5/1RMrS4vYIVX0XHSUQfNP7/n2FEmiskNRxsSHpxRO+jzb/BY+Po0DMGb
	 jTB0MKtRSmgxiMP2xYKga5lOBGtvUx7W4SS9VVOs3/5sgj88u2nJmuOdFG5bzG+F4uHgd
	 FmFfkjlEZQiys6kcIVEx6VW1EW6NvwXNfuvUF2onG7Q1W5DllJLj6IstI7v8I8BacMtYR
	 /41YAfuFBKljCWDhgKefNDqWQIPNAp7XRbCWC1yVXJ3jHSpk62C61atvfuwV15tuzHkdC
	 kmkgC+L6LQa6WuDk3cdyMaOSa03HtOb0/gZeQgdCOpuPQr9ir5PEhCwekqNex8XeHCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TozzVUMW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BB606A329;
	Mon, 19 Oct 2026 19:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A98BB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TozzVUMW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792439298; x=1823975298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h0Ymv8FEJxMcEtk4ORBDD4Dg0y7wYjx7H76XngqSdlA=;
  b=TozzVUMWntvFdr/5eL4b3m6fvT0DEKTbSfjWnlR7ElEFTdMlaZIktA9B
   ZWagWtImkxUsGXUxh6xim5vaLTskftyJM+9cltK0qWKBwSIx7Af1A0N/3
   LeHmj9rn7OtR66t19hlA02jRjrrlEFaw667ht7f8T57OrqsjhMb9iteqn
   UiibQHP29ztF+3TrcsqAAE8MX9Ne9cu0Of9FWYW+vIKarE7txFjaPFM/U
   PTJeWX3kqJcyU66XV4isY+B5jzNIi0Ovnmtv3a6PhmwMGcxZVV+EleavY
   Jkr04Fv2b3oyGGDA9cVXqlBETLch66thLA575uIl9E4mGT19tu35SweG5
   w==;
X-CSE-ConnectionGUID: 7/pJBCjgQiOrKvRdx/8wDw==
X-CSE-MsgGUID: nLUpTTI2SYe7QBa4fzMuyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1117552"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1117552"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:48:17 -0700
X-CSE-ConnectionGUID: Wzm65uxZSfGEd1ey7QSk+Q==
X-CSE-MsgGUID: 4f5GqdLNSiK2BvS+8uZuGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2680396"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:48:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 12:48:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 12:48:16 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 12:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf+VSKQTwVZ1DliFiBN47NqX14gkVgQfd6af/ZgQ086O3yRckZK89g6GUVUxtNmkgx/MzDISAQfw5Wpn1No+gUdmWoGlm3ZzihnEoPuqFevYx/IVD9sMHYyhPyvXZxGsy3WIvIhXdEb7yW47Pr1qiT/QgRbtSk+E+WXLR6Bio/IPgBFPe4JvDvpS+Zg8auD1B2vUSZXss9LJBX+mrfvq9R1HRxVHDAUvzQ+S1VRv3vHIOlK/2AldFu5bvA0p2PyrNRD09GNXh0yLa2NCNyosd+zo42qHZ3RFT0zlcgg6FIO8LvoxBJWR9vfN4J0XPyshp7OwnI2QR8Awa7BrpMMbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA/GRmzhuKMxHmstEFBdK0UFeRJkvhk2R0BJKJd/G3g=;
 b=M1Y/TBYXrhTR5KyjQSZhNCMzx1NYIKVJUY8PJU49MhVrrFSXmjcUnrXfZYxItt3K9p0/zPd37bY9BMsAlfuXuPynVg21VA39dmLhcbiA0Bgf2F5syZvFWNsV1A2uQl5+EaVpwjV+00AvcNfdCU+36mIkOkxZV318+o3czkQf2ecz2PCaoi0tAHZu8dKR4Gerd1djWNqmcOYPRIlOWlsEcJTklJfJh4QKdzx16MZ9GAdEH3yKMneGx08YFn9rZaMliWZLeaIJ0EMbVwKh3lHFuWwj4P5VIorU+aAraYM56noqRszYZoWOuiQ+3Gj7sAoGKin10YZBS60ogwgFvSaZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by LV4PPF4B9825472.namprd11.prod.outlook.com (2603:10b6:40f:fc02::225) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:48:14 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:48:14 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Leon Romanovsky <leon@kernel.org>
CC: Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, Lukas Wunner <lukas@wunner.de>, Nathan
 Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
Thread-Topic: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on
 Intel hosts
Thread-Index: AQHdXb56kLC8GFOklEy8u/njCKgpc7cAx1kAgAAZpWCAAHtGAIAAfQbggANsbfA=
Date: Mon, 19 Oct 2026 19:48:14 +0000
Message-ID: <LV2PR11MB607077BABF5643BD4FAF470FB2982@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
 <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
 <LV2PR11MB6070CE9CCA125C290C0F8209B29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261017074820.GD219304@unreal>
 <LV2PR11MB6070ABD61B46E9590C9B28ACB29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB6070ABD61B46E9590C9B28ACB29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|LV4PPF4B9825472:EE_
x-ms-office365-filtering-correlation-id: 9e35a0da-9c6c-4d3f-3e5c-08df2e19e9c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|22082099003|18002099003|10067099003|3023799007|4143699003|261009223027099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: v/c1qn8MXCyh/ZDz1GssiXVUQWkikw2+6G/FuSpYItmACenkbR1C8hjc+e+IBWOmvBilIosCJm0SzPehYajL4axDM3iGvljMgipWE+SKNODmfSAB5YgSISm56donG3QriC9rc10kpuFcQkWm8al51cSJZbPjl8D+CWLJX8nckYbOnQXb5tl3v+OLwoUzXll4B3VD5ECGTgAi1RA0tHDSHYt0xnAHRVJBS6VsyVXDHg/KUItzT6oTcpNzaiVgOEYF06LY6RKFttC0qiil9nzsMq7XEwzSbqfq/Vbcea+n7/KLtnTgRFeuxq4c/bay5gKKGPfnUEOxnj05Mee75Iv4tVLjIWx1RpBrNwC8thXhuaxEBqGyWMzclu56ju5tFbAcdB1iCbFvLGFquPaoR1ZmJAsg6bDU05i8HQ3lDDoPilLcIBmNjsT5f+6meUNi46GHkz2EHywVhGmW7GerL5mcRtFopizEAdz+/OI2L+bXSpMGFaNvy0ncvmjRgWQnynu7MaKQbyy/625VT60PLE75y2f1iXdjyiHg3UY/2uo6qQcCK0shPJP2xiHr06PTRd0rbFYMe3Hior9ROwiAfUPnZMyWOOxVQcRBFPWjh0kVGp/oYEkjzLiJknkq6Y8Hfxzy4OrEVsJyCFoJ7U1qTn2psHt29Hvm9Nvqg+yiWVzHtQPsr3niavCye1AvaQdevGzzvnt5hi6y4vsv47sBih/+MlAZTq40h9LIjvmnWu6rRrE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?crvlIRhlz5UsVht/iIkcgV68MKQhdkCWQ1gQop2+jsRDMMEiKYKpWkfAlbho?=
 =?us-ascii?Q?x9DdgK5MmW+f0pPstC/pwLoKlw2i65xQVdxXDaynQHL9yNzNlwx5IFlTYO2I?=
 =?us-ascii?Q?DogdEbGJuw0AMzQh3YtBU8FD5Y772UtzrEkWsC/BVzoVzwwx3GJU7xkqsKNN?=
 =?us-ascii?Q?1Jv8SST3fxp8+HGQkswhSh923VlVkuDogjW7eLI6lOXV2xgOWupqEjHhje9r?=
 =?us-ascii?Q?9M675mMsKA23ZOv0I7EZP7p3GhOr2eboof4gWVnKh241gnP6eiJ5BIxQzJy+?=
 =?us-ascii?Q?lJYda7W48rSrXkLKUuApMborSIj2Tx/xauigzKLSLieVmUlUPpakOeo8q/Uf?=
 =?us-ascii?Q?eGVYqbMAZVm3pj2IHtbd6o7tq8THABE0YV+K86HDPGvUFhBNS4/cB9XwMzea?=
 =?us-ascii?Q?5q5gh8gfkLpXzhk+vn0/5PpCGfofs62pNVhSGue9M3BWHt/LLFhJ5UUfpKvS?=
 =?us-ascii?Q?f19twbAZt2pSAoHECw+1S+90siQIQ9SaZHca+FVkeb3OdoQUYTA0PcMJhvfa?=
 =?us-ascii?Q?ZvhyCOpbv90nOXHmgEhDRHwleaDSgDDhJGX59IqFBR1mAyLxcp/X/O7o/aAU?=
 =?us-ascii?Q?kPs53IJnIiYjC3T4EhUPA45Tc1NsVBO1yd63e7e/mJV6OpA+DZciLWSazrrA?=
 =?us-ascii?Q?vuH+zHNVAMO/sFGjFCSjdxyFRaMTXK0q4mCwLPRtc2exPMQ5TNyXMDenhT85?=
 =?us-ascii?Q?pOEKC1PMfyhZzchguSa33FuZ8S+8vG0JaBhsGzbDC319zI8g3aH70cgxgt2T?=
 =?us-ascii?Q?QxOHIY6Nh/x+/OLKawvVR8GDhgCglpq5cldTa9mEz4iZGCZWHoiADJAPLD9J?=
 =?us-ascii?Q?qy5+yV+he2JGwIMUT5eVQQQGSZnY1agfHYwQM295JEhYL5tHAFoy2LKruOMR?=
 =?us-ascii?Q?pLDOq8/vQKYsY4jjZlExK+NoN18oP/QujCfOvhsu35HnQYQShIcpT0QoQ/+T?=
 =?us-ascii?Q?gvQz4CbFVcikQYJC1X1f9/Fkl1Ssw4vF+vaaMn4xFFU10hSm/MRV11g2BTyZ?=
 =?us-ascii?Q?euAsYbqruy9yf7dReVP96VER/hhlqhosA/dkdXY8j6qpNHn3gH6XtKaMGBTt?=
 =?us-ascii?Q?dtxFQVirotdev8fwuT/j5hBfppZYtkEd3DCUBU5cBUzzoSgK9jCBWoVFhu1S?=
 =?us-ascii?Q?pL82UOFHqkoDnRtNE2WXVbb717Ni1ZPGuUuhQYvKKGmgK33cBamupBbyWPI0?=
 =?us-ascii?Q?+KUhIJksnmbwdvITFniz9AbO48n4uWmV0Nv2awFH/mB8/8dbm/6N7SiENgoO?=
 =?us-ascii?Q?akypQogJMSiH3GF3Ym81Zdw3LSxztEbbNwHIswGctN7Z0aCZyWTKFkNLOtLO?=
 =?us-ascii?Q?SF+SaKTo00ag0GZavBHhIW+7/SK2F8lVNTq72Bw4/9reyZ9HYt7KWoy5dv7Q?=
 =?us-ascii?Q?sFLe4mll6O1l51MUreC0M+QY8KAOVEN8hwPQNNNMtepalE5DOJ0sv6niCMAu?=
 =?us-ascii?Q?tt3vDS9YrhoruOh8nmGwhQx5RlV/no9kDbHy5KDB6I0fm7xVVoT0v7zUMGC2?=
 =?us-ascii?Q?dKR3MN+LG+Bse26n4+Trz1UGIXpXHYkOXi++SeHWxLXLCoX3TTB4cxyTs1f3?=
 =?us-ascii?Q?u7+vL78d/SPgUJ54q8DQaF4zSx9XyMzhCeIt3j2mhPzYdkSgIb1aJdHUE183?=
 =?us-ascii?Q?HSyV557P0Rl7bvf8FzG5BaMtSGCSz+sl20W+AqwUnAyD9POdnZYBkmXcTdvj?=
 =?us-ascii?Q?4iz3AApbk9IFYERoeP2VktAezL95ZT6eLnyexSjsQSiqZGgzeL8cXwUD3d/K?=
 =?us-ascii?Q?59PJMJLgcQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fprEo8DNDJy/QVGA4mWQBspW4HYfnRtrVUZUx3dwkaZo18XJEqOvclMEWim+Z32qTqWmADPCu3UFz5R+vOpdB8q2MmiYq925V95rh2xdXN4kN8/WujWNLNRLSQ9s8dMVR7KjorR3Awun8YWfi2bSl6qUvFHmCjLUvaHo0JbeagDBci2saJe72RyRqRXh0b1cBM3Jp1WVOluBGcgbXVZ65GCWMtOu4XQm4+y1nTeGIk9MmNCyoZkIRLpsm7/g0C5xmr/7bT4Ld01Nlf5BZXNr89e/ib+9PuIkufcidBg0nhVel5SP0G+w+gOzj3eXlAlInJv8fd4D9p6w3RVUJoRegA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35a0da-9c6c-4d3f-3e5c-08df2e19e9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 19:48:14.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCKKtczaw6JwZr69+2phbp3HP/1DOZoU9COSSk8WipoYsYkczFY1kvOmW+YfH4lM/eP2txUekA62PdijzG0z4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF4B9825472
X-OriginatorOrg: intel.com

Logan, Leon,

I kept the hypervisor check to avoid changing what the host bridge
whitelist refuses on bare metal. Looking at those cases again, on the
listed Xeon CPUs this is a limitation of the whitelist itself, not a
known hardware limit, and it is why Intel QAT/DSA/IAA had to be added
by ID. So I'd drop the hypervisor check.

Would a v3 that moves the Xeon list into cpu_supports_p2pdma(), the
same way as the AMD check, be acceptable to you both?

Thanks,
Pavel

> -----Original Message-----
> From: Popov, Pavel E
> Sent: Saturday, October 17, 2026 8:21 AM
> To: Logan Gunthorpe <logang@deltatee.com>; Bjorn Helgaas
> <bhelgaas@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Jim Chow
> <jim.chow@broadcom.com>; Radu Rugina <radu.rugina@broadcom.com>;
> Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Lukas Wunner
> <lukas@wunner.de>; Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm=
-
> kernel-feedback-list@broadcom.com; virtualization@lists.linux.dev; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-kernel@vger.kern=
el.org
> Subject: RE: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on
> Intel hosts
>=20
> Logan,
>=20
> To keep the record straight:
>=20
> - A global CPU check was never proposed: v1 and v2 are both limited to
>   the hypervisor, for the reasons in my previous mail. The argument
>   was parity with AMD guests.
> - v2 does not depend on Broadcom certification. The explicit list
>   matches only the Xeon generations whose host bridges are already
>   whitelisted, which is stricter than the AMD global CPU check.
> - HMAT's direction was never questioned. There is no HMAT solution
>   today, and current ESXi releases need one. As a side remark, the
>   timeline for ESXi to adopt HMAT deserves consideration too.
>=20
> Thanks,
> Pavel
>=20
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Saturday, October 17, 2026 12:48 AM
> > To: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Jim Chow <jim.chow@broadcom.com>; Radu Rugina
> > <radu.rugina@broadcom.com>; Alexey Makhalov
> > <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>; Michael
> > Kelley <mhklinux@outlook.com>; Lukas Wunner <lukas@wunner.de>; Nathan
> > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests
> > on Intel hosts
> >
> > On Sat, Oct 17, 2026 at 12:31:49AM +0000, Popov, Pavel E wrote:
> > > Logan,
> > >
> > > > Why does this now need to be related to the hypervisor? Wouldn't
> > > > it make sense to do this check regardless of whether VMware is invo=
lved?
> > >
> > > The whitelist decides per host bridge, and a global CPU check would
> > > override it on these CPUs, for example:
> > >
> > > - It allows VMD domains, CXL 1.1 devices and other RCiEPs, which are
> > >   not whitelisted.
> > > - It overrides the emulated topology in KVM/QEMU guests, which alread=
y
> > >   decides P2P there.
> > > - It makes the existing QAT, DSA and IAA whitelist entries pointless,
> > >   since any RCiEP would be allowed.
> > >
> > > Limiting it to the hypervisor keeps the whitelist logic unchanged on
> > > bare metal and in other guests.
> >
> > Logan,
> >
> > You can see how convoluted and illogical this discussion has become.
> >
> > Initially, Pavel was told that P2P inside a VM is not working reliably
> > (to put it mildly). His response was that he wanted Intel to provide
> > the same poor experience that AMD currently provides. We agreed.
> >
> > Now he points out that AMD's solution does not work well and proposes
> > keeping his hack, which will not work any better.
> >
> > Moreover, it is unrealistic to expect users to run this software and
> > VMware's code only on machines certified by Broadcom. It shows
> > complete misunderstanding of users.
> >
> > His claim that HMAT's future is unclear is also inaccurate. Half the
> > work had already been done: p2p ACS had been cleaned up and was
> > waiting for Bjorn to pick it up; an initial version of the HMAT
> > specification had been drafted and verified against the current kernel
> > implementation; and the community had been consulted and had endorsed
> > the approach at LPC. The remaining work is to update the
> > specification, move it through the code-first process, and implement it=
 in
> QEMU.
> >
> > The direction is clear, and developer time has been allocated. This wil=
l happen.
> >
> > Thanks
> >
> > >
> > > Thanks,
> > > Pavel
> > >
> > > > -----Original Message-----
> > > > From: Logan Gunthorpe <logang@deltatee.com>
> > > > Sent: Friday, October 16, 2026 3:55 PM
> > > > To: Popov, Pavel E <pavel.e.popov@intel.com>; Bjorn Helgaas
> > > > <bhelgaas@google.com>
> > > > Cc: Jim Chow <jim.chow@broadcom.com>; Radu Rugina
> > > > <radu.rugina@broadcom.com>; Alexey Makhalov
> > > > <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>;
> > > > Michael Kelley <mhklinux@outlook.com>; Lukas Wunner
> > > > <lukas@wunner.de>; Leon Romanovsky <leonro@nvidia.com>; Nathan
> > > > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > > > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > > > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware
> > > > guests on Intel hosts
> > > >
> > > >
> > > >
> > > > On 2026-10-16 16:34, Pavel Popov wrote:
> > > > > +#ifdef CONFIG_X86
> > > > > +/* CPUs whose host bridges support p2pdma, see
> > > > > +pci_p2pdma_whitelist[] */ static const struct x86_cpu_id
> > hypervisor_p2pdma_cpu_ids[] =3D {
> > > > > +	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> > > > > +	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, NULL),
> > > > > +	{}
> > > > > +};
> > > > > +
> > > > > +static bool hypervisor_supports_p2pdma(void) {
> > > > > +	/* Hypervisor hides host topology, allow p2pdma on whitelisted
> > > > > +CPUs
> > > > */
> > > > > +	if (hypervisor_is_type(X86_HYPER_VMWARE))
> > > > > +		return x86_match_cpu(hypervisor_p2pdma_cpu_ids);
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > One quick thought, after a very quick pass at this:
> > > >
> > > > Why does this now need to be related to the hypervisor? Wouldn't
> > > > it make sense to do this check regardless of whether VMWare is invo=
lved?
> > > >
> > > > Logan
