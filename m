Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794411441;
	b=dq5l5atpWgANVaVOARZdlmu3U4RiuAFKAG5XoEUyOKl5MaaR5pKQeHPoEaJPy246zVOx
	 2Ozqya76CgiC2akfZF2zlc6uHhzHRqr86d80D8dFM6LE84jTKVbc9EdR05obFka/hCM3W
	 nnj0EMEFQlE9SDcxUKeWiPvjL8/VKTszxIy+boeqmzSgjYhlkP55nOAZoLqPYp7oQYhSj
	 3PHL1xR/v5P0/tu6Iu3GyrDxihpcbX1yEfmZn46mRg6s8anUkJirmD7shgKJqpYbqAn9+
	 0skwPPX/o3f1ClfBE55zpcOe90Nh0AsSQ5r3jbprT74vWWw52OOCbP5d/SSNlOsUPHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411441;
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
	bh=FpzDRhDWdTKAeB+tOYxD+5HRX0oo7aJP8K1eewJyEE0=;
	b=ivrZSLTZcYfVEowOF7jv/oygb8A+FGSCxA2qPDCQIZlSrK3PFwi303uup7GJTXpiEkAA
	 bbeYkTH/T2JF964JfTnU+jn6IYlmB6bNStbqjyUjxL6ynNwaRJ1PgqvXBokAIAGRsh24G
	 4lv9mkeM4d8z2iAx9qSUkC/OCGkXNGHpooPGJsm47LefTyaJJjtGA9Zauj9iFHot7hDv0
	 a5IafQV22p7r1ge2JYMpKsQJnTZf0rfGHP6TehDKZXyuz5GZFohA36Bl2g2OlffPcNvbc
	 piYUcBMqQJzo0pp1R1CKDceER05PTkYB+apUNxx75l0iNtSSGlOFb6T9FGMutSXszuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EWWHf9sh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB0606A335;
	Wed, 11 Nov 2026 15:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDB0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EWWHf9sh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794411439; x=1825947439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TKNh57U5yGZJsZZQJ2AIYukssVnRgY0e3EDOGi1Jdzg=;
  b=EWWHf9shWV6UTW1KPdR+NurS9P+EL1m4LhgHCTshwwSTHwLzQu+HV1nR
   kGAm9ybJ6FNguMguCu/oG2OQFmYlcpjmDKCeb/tNUYhKjKunp6cW7ng9l
   1+UPYKQ/dRmOWi9VvVM6Yk+awtt/pO/5alarQxs6SOPgZcFqKsf+dzh7M
   eyOYaBsLse0lrcQoR0V6yKt9UkEBFs8O7B9Ngyp+KxL68vh7SLAYedx7/
   136CgTCVJNLA31icJES9o4y9W4F1mywrZBvAOAP2TyP+T1nHWhPtAnpZv
   tsXsuRAfpZ3g8t5un9X1zW6aqY6qaDTAXyR/jcpPuwb1tEnwlpb/Z7+1m
   w==;
X-CSE-ConnectionGUID: Nu7wblShSpKehtriVFlpeA==
X-CSE-MsgGUID: HN/ThTvASSKhodkDFDr9mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3189539"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3189539"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 07:37:18 -0800
X-CSE-ConnectionGUID: wVGpTUKfRmyn23wgblR8mw==
X-CSE-MsgGUID: iCWsoianRnipK0gohuAo8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="10164013"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 07:37:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 07:37:18 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 07:37:18 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 07:37:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnLOFEFWVaZGV3ecjPGnrlNaI35Fhsf4FINR1bjFUBb9kgTVxxpe3+aF8eT2x/tPJ3xPfsFbKU6oVg+Ako4ZOCDtfF4n5+S6/S62KYDGG9iD/BvpN4QK5bIw9KTt6H3k61wLnqnuvAEYraUkhP7qoclZSLr36BeHcpR9alX/8RSpYrBugjUdIdOB0vW0EDUvZAClSll3FXfcHKDtUWRK+7tBqGhJYzAMP5BHqM1dmVDCa/Kcvb/M4Gk4E2FnNz2O7GRfnX0GEJOkmOBLGGw0Q0kiXHXU/apL86tR7TYRbnvOA5GmTepkgeutOAVRWF7VJa+yqhY6C6XLM5/MmS9h6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpzDRhDWdTKAeB+tOYxD+5HRX0oo7aJP8K1eewJyEE0=;
 b=Ivt52bI2M2yXNza+hw+aJsvOTPMZ7kAReIAFJOyOJhu85s0aVJ9sl29wg5/A6+zl67VDfldeQDSogzlaJqP3nweghhsTXLnLQPeJfa7TS95bDezIMD+7VGpIfBDoTNf+DbJTs1NMZPOMUnvLgDz+io0HUOyV/ShwW2HkkrQ2s5JTg4b4Y/hUMgWOBRZzhZ/HXkCWsx1fE6OW6K0YTjSREl/nu6fTEWZnfF/DK51tbBHh94W2yGOaTWXOc2xXQSBTdhmJPGo6Tkfh8W6fQN6x58cZWb6kkCy/IU2Z70dUgeE6316I1yNY0+nGipm0aJnr2s2+VQ9ZdWP/HECtC3lXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:37:13 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 15:37:13 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
	<logang@deltatee.com>, Leon Romanovsky <leon@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Jim Chow <jim.chow@broadcom.com>, "Radu
 Rugina" <radu.rugina@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Thread-Topic: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Thread-Index: AQHdYLm3Eu3+F6ITg0+VFiHnE2F7qrcoXBEQgABK14CAAG7WMA==
Date: Wed, 11 Nov 2026 15:37:13 +0000
Message-ID: <LV2PR11MB6070A8BA690DEA91D6675682B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <LV2PR11MB6070064A9E674EBDFB1A3B20B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261111081057.GP8635@unreal>
In-Reply-To: <20261111081057.GP8635@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|SN7PR11MB6900:EE_
x-ms-office365-filtering-correlation-id: 6d9a5208-0906-4337-f084-08df4009a85a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|22082099003|18002099003|6133799003|261009221227099003|261009221727099003|261009220027099003|11063799006|56012099006|261009223327099003|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261028144727099003|38070700021|4143699003|261026140227099003;
x-microsoft-antispam-message-info: fUq5FrXqQzTzrXXxcjb/QM8g/UdIq5/HEahv78LJgjAHFMy/dfJ9n7xsALLRIbGTpvs7y7WrjApyryxoczdAwE+mqSuHsjHsuwY0eciPoYuJemZcPua6dYJAvXh8w7bfdwP2OqW6oVViIMbg1ibGD7ny4pXiMo/9H9h740/GGSKtjI6bfbbk3z24+GYDScOIJY8z79ChNqGqGlw0/9NjlIBuSi9djn2QOh79JaHD02SnNakvfUaWAMZDHZ+5+5gF4pd+GSmgq9is+Q4Jf/H3M6Y+JaKAgBv94D2SmvigQYMg4kAKuo3ca/ONqHZk8RXAlBJi+7ro0aj8a7Y8yDpYOQdsxhNjL452GjAcL4PaNyc9f4Lu4u+EmJ/7hfNAToeD11OkcIA7VISLVVolyBLj4uRRSO/qIdtrbV/mTxQsYoiE/ymBCxW57q0XloKqzGPoIwesfiR/Pqw8N21VBD40sH5mWmLnP/aH2mAbPomkgegz77D9YL6HeCEeiADdoPZQaHz2OZi9HWi5YTN8HcUC+c053LPtNCselaR2VD3S+od/incr9T9qN7UpeE1sE06DNWnbxiGNaJB5FQJNipA8D0qj5xjMd/S+Autq2/20ylwc/CaUd/vdfVKQwNzAQmc2IbIWFCB7V6WVUKUZbkUSm1nxw0ugqD8S7uq1FU4/75M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(22082099003)(18002099003)(6133799003)(261009221227099003)(261009221727099003)(261009220027099003)(11063799006)(56012099006)(261009223327099003)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(38070700021)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J11chx1tMkt+IHMFyhdYR25Df0yQbDwPqSXb41+SU5YS1otzt/WL8b2lnyB2?=
 =?us-ascii?Q?auE0k4b/RjPWm/KWfjMS5IwZuwGnpN5UpmOdt6c2PBx47m9RK6OuLeukpa8W?=
 =?us-ascii?Q?5nXFFoIqM6EiupE4a7Dfg+hv2I3z//bvIIen3d8Kof8r6bLIyug0azmkWgYP?=
 =?us-ascii?Q?BHcccwXmTtn3YS1EtUGtEOaG/MQeJ21HrrhPquO4f+kdjm99mAVXua51Ze5a?=
 =?us-ascii?Q?QI7TakanquNSKjiPOcS0vLgti0adqWqZndYK6qzem+8eBGHU1GCP0oW70erH?=
 =?us-ascii?Q?OQ2zNc2JWXloZ2s9Fi4Tg9IvrpjcXjRFPPuHGEWoeZnwEnjvfD/lj2LjuBJC?=
 =?us-ascii?Q?StzqYfmCO8MkYUzsuFPB/x2xlLbJaiA5lkIWcq6ReXivpoKtHrzpz7q8yr2J?=
 =?us-ascii?Q?UACsVnWJe1uGeHmzaHxVK0adb4w267SuLgaWtr0QpV+Fy0Ng8OZPH1pCoeNy?=
 =?us-ascii?Q?Gf1cOJxCgmBrP0BqMsNEVMoNttGgK/IXqg2wkcJWYOUPu89QNK2UezocZCYc?=
 =?us-ascii?Q?Mj7uZFBsI8O3uMqg5A5ecpPqtkAcq0rc/5FMvoGvfxkSTrrbjQnWnj/ddMxK?=
 =?us-ascii?Q?vBc7k2P5jDCRKP6nHJSs0sjLdSFaWOewxXPEEO5cWzeHkMa57Vyz7Ck5Q8qb?=
 =?us-ascii?Q?mDcm9i8LzqHjiKIM35GN84b1D/+kuhHiVHeBuA34TmNzrI6MZInrKi8r3x/V?=
 =?us-ascii?Q?Ub1pWc6Tp3o3D+/UqXhMDFZt88Tc+JoisPGR5fIORbvLqu0qKpzTYvYmM5gT?=
 =?us-ascii?Q?OvfJufZxWGq5VmgMIfSFdi5GRudk30GmjvMcp7WgB3OyD3Xzx0sg4FfR5pkA?=
 =?us-ascii?Q?yUAkhhQPge4DMhw8+D4rSpbOjfnpq3m25LeoIKZiq6zFZs9HyuvLi81QkjSH?=
 =?us-ascii?Q?m8YmwxiLnSTbh8XYKDAYdHXd0vdKBR4BQ5AYKDly0o96z3zu06bLoKBdgzMw?=
 =?us-ascii?Q?Q+dou7a9Cj9QB4rG36MWStKXzUaAdYsA1M5qVm345rrpPAAZl2ZzqutudExb?=
 =?us-ascii?Q?Rp1e5oKC2LguxaMm4o33bnLHbsEXW2wforjMtBKiA6QsDkxafHrVx4Zynedn?=
 =?us-ascii?Q?G78FDNwjber3xPmQ7E90ll6pEsg/fucW81dRN4+H+k1m0oRwSdjBkFxSzX2f?=
 =?us-ascii?Q?M459JxIUtpvZlM9+LTs32tXcqIXwLuGARzCoEOKWtreqTxW7/JXBDZmAObRU?=
 =?us-ascii?Q?i0EdQk7GNUyf/gPzrNVAazpmNt4Yq9fz3JVzc/qZ6Iq2xsvf0IeITkC2A0k2?=
 =?us-ascii?Q?CWk78xoRUqL1U1Ln3pnUMYI4z1/l5ID0or0+CPT2Nq/Hjyw27oZYY48J5UmP?=
 =?us-ascii?Q?dNqIGQVpsURwNimwH++lOQm3Sz1XpdO/9QU0DksoIb09E7D/wCp2uVEo34Ap?=
 =?us-ascii?Q?GquDOjd/2U/Bhg5+apGkUQ2LJs+UnLP0A+sehOI/j52gZWNXbFjr459m4AsL?=
 =?us-ascii?Q?tQ2+GZkm5qwA1osn8h68Ej2VfpffKILDlZFhmxeO0J2W6pPxlhHFMGMElJbh?=
 =?us-ascii?Q?HLyqZMZrZ28qA9xjkPEfvbjwQ1ym95/e05E2Qu7e/+FY2DexLO9FIJgJzLCv?=
 =?us-ascii?Q?aPM39XOGB4HJXV9wgCMbhiB09YLK5t5yk+zTNeNns9LAXInuul7Ju+dAVPDG?=
 =?us-ascii?Q?0L9lvP8oD+C38242fOvl17KUiGXOfmtFHHB/P7kvQmv6Yhs4vAP5rQlYTwAG?=
 =?us-ascii?Q?kp21Rn02dLMROXY5ZzhzbEqlyhln92l1bA1WjccNxeRoupBuWSVDI7wwwvOp?=
 =?us-ascii?Q?Yh1kYWumKg=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: f7qyUs0dQpxPGmh5m9s1VxrVLpqrZla34j6pu+XkMZCBT2RxaBKI+BjTAWKpGicfwkkE4wDPBtFLa3ZZQKVaCioK1icsS1Ehk0iryoOoNIDv3XBsT+LVe3PMvpacqAZHOnLlNqkhRcLXziTDtK+TiED2poxAxWt0FxbAUt3KRxu4r66Dwd7UYUmZWj0CawbIuRyFO/VQS/o/RFH6k3hlDK4/u2xMoWaKIn8qNkcn5ywhQQbJEcB5OfDZsFs+BtUdP8N5EMFSXWYnx2/bfjXpwiNjl1pT4aDhA2DSV7KpbiijomabGJAhLXiblGZ35lPdDztnjRktqsSe5XdLi1z8kQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9a5208-0906-4337-f084-08df4009a85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 15:37:13.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AF6hVwqjLGMaQaNrs3t1INouw2OYftqSx0U6JIA2WhTtk5s9pVLL/WrdaMuY0p9U0WnpT0zeeggUWAdKXOe4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

On Wed, Nov 11, 2026 at 10:10:57AM +0200, Leon Romanovsky wrote:
> Peer-to-peer is a general concept, and the code should reflect that. It i=
s
> reasonable to expect you to join the effort and help clean it up.

I'm in. My proposal is to do it after this series, since this one
unblocks P2PDMA in guests and the cleanup is out of PCI scope: even
the minimal fix for p2pdma.c alone means changes under arch/x86, so it
would no longer be a P2PDMA patch but an x86 header series with its
own maintainers and review. That x86 header series is also the right
place to drop the same guard from six other files, and I'm ready to
do it:

  drivers/acpi/mipi-disco-img.c
  drivers/cpufreq/cpufreq_ondemand.h
  drivers/gpu/drm/i915/intel_cpu_info.c
  drivers/char/tpm/tpm.h
  drivers/crypto/ccp/ccp-dev.c
  include/linux/platform_data/x86/soc.h

Bjorn, is v4 OK for v7.5 as is? The x86 header series will follow on
top.

Thanks,
Pavel

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Wednesday, November 11, 2026 1:11 AM
> To: Popov, Pavel E <pavel.e.popov@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> <logang@deltatee.com>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> <jim.chow@broadcom.com>; Radu Rugina <radu.rugina@broadcom.com>;
> Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Nathan
> Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> list@broadcom.com; virtualization@lists.linux.dev; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon
> server CPUs
>=20
> On Wed, Nov 11, 2026 at 03:48:07AM +0000, Popov, Pavel E wrote:
> > Hi Bjorn,
> >
> > Gentle ping on this series. Is this OK for v7.5?
>=20
> I would say no. An Intel employee was asked to clean up an Intel-created =
mess
> while upstreaming an Intel-specific patch.
>=20
> Peer-to-peer is a general concept, and the code should reflect that. It i=
s
> reasonable to expect you to join the effort and help clean it up.
>=20
> Thanks
>=20
> >
> > Thanks,
> > Pavel
> >
> > > -----Original Message-----
> > > From: Popov, Pavel E <pavel.e.popov@intel.com>
> > > Sent: Tuesday, October 20, 2026 10:38 AM
> > > To: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> > > <logang@deltatee.com>
> > > Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Leon Romanovsky
> > > <leon@kernel.org>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> > > <jim.chow@broadcom.com>; Radu Rugina
> <radu.rugina@broadcom.com>;
> > > Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> > > <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Nathan
> > > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon
> > > server CPUs
> > >
> > > VMware and Hyper-V expose passthrough devices to guest VMs without
> > > an explicit host bridge device. Consequently,
> > > host_bridge_whitelist() cannot automatically identify the underlying
> > > host bridge structure, causing Peer-to- Peer DMA (P2PDMA) requests
> > > to be rejected unless the device IDs are explicitly listed in
> > > pci_p2pdma_whitelist[]. To enable P2PDMA on Intel hosts, this series
> > > extends cpu_supports_p2pdma(), which so far covers AMD Zen and
> newer, with an explicit list of Intel Xeon server generations.
> > >
> > > Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> > > Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by
> > > carried over; the Xeon list and the check are unchanged.
> > >
> > > Changes in v4:
> > > - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> > >   (Logan Gunthorpe, Leon Romanovsky)
> > > - Keep the #ifdef around the asm/ includes, as these headers exist
> > >   only on x86 (Bjorn Helgaas)
> > >
> > > Changes in v3:
> > > - Drop the hypervisor check and move the Xeon list into
> > >   cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
> > >   Gunthorpe and Leon Romanovsky [1]
> > > - Fold the VMware and Hyper-V patches into one, as the check no longe=
r
> > >   depends on the hypervisor
> > >
> > > Changes in v2:
> > > - Replace the Skylake-and-newer threshold with an explicit list of In=
tel
> > >   Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
> > >   Gunthorpe)
> > > - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
> > >   (Logan Gunthorpe)
> > > - Rebased on current mainline
> > >
> > > [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
> > >
> > > v3: https://lore.kernel.org/r/20261020151305.65218-1-
> > > pavel.e.popov@intel.com
> > > v2: https://lore.kernel.org/r/20261016223402.19991-1-
> > > pavel.e.popov@intel.com
> > > v1: https://lore.kernel.org/r/20261009154034.82321-1-
> > > pavel.e.popov@intel.com
> > >
> > > Pavel Popov (2):
> > >   PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> > >   PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
> > >
> > >  drivers/pci/p2pdma.c | 33 +++++++++++++++++++++++++++++++--
> > >  1 file changed, 31 insertions(+), 2 deletions(-)
> > >
> > >
> > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > > --
> > > 2.53.0
> >
