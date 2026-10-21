Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792588129;
	b=d3BQcF1dFmHESVpS13W9Isjo6xCsQoJ+C+hSOAvWTXpg5HVbIYycJRPt0IfDfeQY+VJ4
	 5Jy4F/hv2FLT1H138OutVxJBZQ+PIGUWtmX86duPIkVWVlNQ437LaqxhdLEBnYw+wy+HQ
	 lPpGvJuvea4J34Sbzih7cWL6geCnQTN/dUxvDq/PMzv0F8D++j0lecz3cU5KEm1EVbec+
	 35AyBQsXg4DYw+vFqMPoWqomNaHzs/QToAYZ1yBT19pTB8caD6LG9vMXDZcsfSYKhO7nT
	 FmsS6kzLW8MoJARpW/AoluiZ/fSVgdPSlIOJTSYsIOWRZbOcaW5Ef14UQPnnMh1feIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588129;
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
	bh=TK/aNdfcyF8NqgIqOzjG1Fjv3nvKXPnX3NEXFX9vopY=;
	b=a9X3QT0AEypOW+SPzVhN4cEdJgx0gp9N67Cd2+PFoTvOxCICFDZtsfujGJQsLMUdhUcd
	 yx08KBrDYs0Q4tFRZsltp48ZiKiAZi8g/9lP81ixLKtM+TPpbF79EQ8RuwrZrIFtTMUli
	 LvsUN5F4FfNKMw3yyqiViHI+NxmdZo29i/zOttJT10vSeMVxHWUa4Skrl/v6r2cShXlgK
	 UCg/99JF3U6HdWqssQ0kXFaaooE3akVodF5AvvM8+LbTHyPDSCnM6bAATLBiRzt9bioJq
	 nqOJPAO6hz3NeYqGq8YIDm4U+EEFjv4HevogSwuz41+d6m2HRE22bp7DzPZUVRsUDQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6qbVrQT;
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAA606A31B;
	Wed, 21 Oct 2026 13:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCBAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6qbVrQT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792588128; x=1824124128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4K4kE+ge50trDdHaj2GhRDCmsM7441memdjZcW8XaIk=;
  b=X6qbVrQTUO6kbbBzOOi9nY8Em91mwxAc4VDBOC+daNp3OSdLI0J4TnV1
   ROY3tjqCCl1Q7IWZDUxLlaKZdMnr0275rBTKMRsOJCk4sOt6HrQWvDVon
   s/opmzRwU9zMlFk0izTWDDc2YH9O+2LYf4uB4s+H7xbIGGLGXPm7HI95K
   fAfOe+MMDxYgYAdMcL/0pulg94hyaPE5LicnrBaqnBQJ+IFxA5LS2mexl
   5PfGj144mRFWSh52916RfkShIysynrvnxZUTBPbC+J7CYsJYYdVQSLBrK
   2e780snf/ScehwC5pbCkYAoVPcsZ46IX9tEmOVC6X8FFKCWZ5ojxMJ0VY
   A==;
X-CSE-ConnectionGUID: pdf2Qc+4S+uUUYYStVN4MA==
X-CSE-MsgGUID: DAnqaxdESW2Z7Pnq0xhoZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1329761"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1329761"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:07:48 -0700
X-CSE-ConnectionGUID: rE9Vux/5SOmr/8YZLnpAfA==
X-CSE-MsgGUID: pVMLDPcKQZ+htlzZFo82xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3430248"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:07:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 06:07:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 06:07:47 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 06:07:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk/Ywd/kLEFp21tAg0tu7KeQHkO5gr8VNrVGI/WgYzcIvV695qplOEv/KgPm5281hKODxTuqEch1LPpSpPxazzvp3whZOAZ6GLnCsfSrwfayN+FvJZHjfUclwGLlThVvowhagQ+0yfHU4/asqlNOjhRsAWKgETrELhHdNRWsxfREADri2J0oqdlM4mw41nvkB2LsHhlEKqQitlZKx81ndSEQeAyT3J8OiUW41w1dEYVPfV5ed2LCdciOrhrLRgRhZ1vZjo/KDnldq0C+6yIQGImk4cPHePDiPK9tjkeWLjHrlXf5Kzdk6qiQrtFHIfhoXTBBRyYYEI3Bt0TDLRV7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK/aNdfcyF8NqgIqOzjG1Fjv3nvKXPnX3NEXFX9vopY=;
 b=AJCJ5T+EDolfG+IrYvkDo5QIJXwe4XCAkxK+hJUoiurVm1/iYDYc24KtV9w1vdSkYeNL9F04pKO53nk4kG7EKnpWjFi0dhiclkkYM5Hf1/1EKak4KHWVQAoyLGEw0jzs3lJFcNpwqGFiiNplgkjSl8v5el6joC8QD6w3ZsJF+XJ0BwYFiCgf9+QiyMTzucf+XLY2HYx0QJqVOS2M4oEq8WadTUnBBNSHpRIMVFXprMhuvmGbjHoMIjjI0Q5Eew1PabwniXzRrcwp2ciWG1SoRV20CFmhC6K4b2jG2gDylRB/Juat4duCinJRoA+cvOenjqNmPY8ArR6OhLL5P7ACAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:07:38 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 13:07:38 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
	<logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Jim Chow
	<jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, Nathan Ciobanu
	<nathan.d.ciobanu@linux.intel.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Thread-Topic: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Thread-Index: AQHdYLm3Eu3+F6ITg0+VFiHnE2F7qrcGw2EAgAAN8iCAAMqAgIAAXNZg
Date: Wed, 21 Oct 2026 13:07:37 +0000
Message-ID: <LV2PR11MB6070DF223EAED1186B710017B2662@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <20261020184002.GO64621@unreal>
 <LV2PR11MB6070E19D3A0CCA50943D7499B2672@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261021073443.GP64621@unreal>
In-Reply-To: <20261021073443.GP64621@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|IA1PR11MB6097:EE_
x-ms-office365-filtering-correlation-id: 675dd3aa-b800-4daf-b320-08df2f7447fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|38070700021|4143699003|11063799006|56012099006|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: W1+X3B+u3aCWgJdZ8SlLDh9RwwkCOi73T70cH02O4YJPFaCPar5bY7Rt8Kh0p9YGH5hvF3oeGWYK4gmuCRN+OlSMwmb8EM7Jm3ThWwlyfUhklITYjYtyFmhBy6FioslTL/rAcd54APk0Hg/A6d8wGcSLaT+RuURPd42LqMCGijC/mkGr8WbhTUE+foUQUVh73Yl6Wm1qFk3KsPOIjVP++9u6KtyhnV9H9G1bnTwtalkjsPh1X/AxiJbcVX5XXhfQQroNTNsqqi+9KcVFBO/AaCkKd3DneSlNKQ/9GphXPLDO9R6dk317ZgfBNYD3L4fdYALSrqexeo+368eHDE853MEZc9/u9EmqWslXySB5n9nlrjJLsh76+rwO+XY2m+cQQHuscF2NwOT4JZKN2eQYvP9oD8VubItrt3jEoK8jw08KS9/PQfpJwZhWlxLbsTcAX6L+uiaRiApAL8SlKJymgHISPatibsziPsuHFPQx9g/CcjNg/czlt9zV1O5GrkkeVEvH29Xl9LJTHE1G81A1d0lw7D8n4GC8ruLt74ozhg7e41KLUuQwYnh9gSahnPThPAR+SwHzi4Kus3oinSU/cmhU5v9kZ53fkax2/CZIsS+LRzBi5Ha4kLk8Bebi9EDvAAWI3lh2Olu+zhf9dJEqtghEJBIB40jSHSXJe0MhdEXPyCswlO6sEsmzhd5Iizw/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(38070700021)(4143699003)(11063799006)(56012099006)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PoyjfeP2AS7Z2zBQ5r0CPmZtRxGsUBajLhV3MLbxCB5PKMUumd+vZUIEeUE1?=
 =?us-ascii?Q?fRNpEEk0iKK6sF/mdocb3qQwe2MyJkRVyMWBFDiJP1MS+PNIXeMsblAgVLuu?=
 =?us-ascii?Q?bYoneu5FA5sL+nhKGv80Z8ZfGmRxavDBanIJffYGlroER1DBfizgztRVREiU?=
 =?us-ascii?Q?mKAJPsFeN1lSxC1EO+weovxjCSTTaC6wAeQ+Rrg1ijRNYiVFQmwK8mPQF2at?=
 =?us-ascii?Q?CYe+APASwGBSzZUzfZjMtrEC1jCSX5yzVr66ItdzxDtYZco97XuBiMhVQyES?=
 =?us-ascii?Q?GmXdiey/Uvt1oJPbQ1ut4whfqBgUlUDOkQnSRRI4G5kcn3oU+Pk9mT6bBkhe?=
 =?us-ascii?Q?3raCHfZcnh4ovPXCSKPivCeLJnO92f3axVmY7GqpDJQzMkO/pcDCkpE/USlC?=
 =?us-ascii?Q?6cBJie2604J5+diExX+AY6cXLv4PI460RiQ0uqRaXayJfwBu3q2TNl8KmswT?=
 =?us-ascii?Q?OEbzSQz5x0qGYqn56qOZIuGXzz13jQ8z0NgoqBQ3/0ecKbvsFZDiq01akX7c?=
 =?us-ascii?Q?bO6gBPrOXR8pNcKy1p47B/OQwOmphfIkQB1bBMsztL5sGflnS6yF7jL+kczK?=
 =?us-ascii?Q?TqtwXENoO9SH5ng9zlFk55iCoPleiohiW87luj/aFWmgL0whcLy9ra9PeMEx?=
 =?us-ascii?Q?3gSYbuhhhKkrTxW+nIrgFTe0HiMybFUPUxbbD09cEecfsZNQ6XATyXNfS86J?=
 =?us-ascii?Q?mR01Rqya9hbJ/zZWPfLojqfWZ0g2SRzqggAdsJvKAgcb46lljecfVJd+5YWz?=
 =?us-ascii?Q?mISVRRzt/U4kjy2Nv4GWUNYgIptZXv71LK2UgmZai4LHx1h9ZcpCVnjK6AXV?=
 =?us-ascii?Q?NKWpAvqwUOLJ1LtIhDNzB/8wxKC8c8oh1RiEwEwjoMiswBf8ylaAMJIpmmxS?=
 =?us-ascii?Q?eM4xoXzL7KUGzAUllhdIMly5yN8A18SGVEWk1oYu5zTnaLEcAu+3bk7OJrwX?=
 =?us-ascii?Q?tzbqS3oA3PQerrxNSUY1fweoz2fKur8lsfPhxnfKM2hcG/W33/B+uTopcE0V?=
 =?us-ascii?Q?6MXUP/P5UstDr+4qLe9t0do8SqUBMRQDKSA/NznuULl7oaYyRh0E68s9iSgE?=
 =?us-ascii?Q?z98TwbVtE2Ep6jHsbaf05dK0DRzJ4Z6WL9iF+AoqLmE+sa9wR2m+dyZ1AmBs?=
 =?us-ascii?Q?YhxBsTIiWeP8hAmD8N4e7adjerLLvBpzMYcaqCl08d8rKtafNiRV7mYDMsYD?=
 =?us-ascii?Q?KGoSw0rOnCEpbVSM4sizlcJaYNJDMeKMVrE4pb09FlNuPm/KZdDr1UWUFnUB?=
 =?us-ascii?Q?rWcSp7K/ZAaGAo94CPHbjGo5dHtfCGaZ67qKxTucU6quqNV6A/iBH3ZNx0OZ?=
 =?us-ascii?Q?P2nsQFqkl1FpJpDC+kMIZbfL5xmWQ0sDVA0mbUepInBStGaO8vXNFBfgxdGp?=
 =?us-ascii?Q?rX7PxTwyV87mnla/sOV7DoEa6mxhvYlH9kH+skImES7iPFMWjAH8H6q50Hjn?=
 =?us-ascii?Q?FyXuClCPogJi/KDsbnos57WSt1E4gPFWxxdAP/flwCoZbf7l2AwYWhOXPGmI?=
 =?us-ascii?Q?p5fpnkqDCBpef0kiV+ug5M57CLERjoD+fv4+BeSy4vee5SwNUuel3Qnz+mPS?=
 =?us-ascii?Q?GGTh/AirUcUfkKn6KrxxXXiMxCUr1hWXo/udSClaPHB31u2yk3m5yRz5plA4?=
 =?us-ascii?Q?hhJapvDZDtBqnrqhQyut1KjOVmM5CNge6JrGF36ax1UDzM62i5XMySCO/AP4?=
 =?us-ascii?Q?spN41uP/danG4uPArQUUezKS16AmgKN+2SjSH0mu2WoS6WtLH+VN7O2hq0h8?=
 =?us-ascii?Q?hIL7nYmy8g=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: 4xbi/Na5wE/RjgF3hqtKfrcHYEBCBvvDL8P4RMUJqDIoTHj5M5P67vzrAeVsaLcdBrXkIrvakMM/I6Ly8knxU9u0EVQfBBCrHS+MBZmHLMFy3dLoDnoP3vOcCNs5jWXsfxSMLkLtJCuEFWVUvo0NV/5pDNp/Xq2jKTf2ltXH7EZZTMh+2XIY2TIuyuHbKGTmDQk+EJCepF7CLyURM5IY/kDo4Q5B3ssVlkVPjHpVNTkbf2Loo+6ioqiJ60W7AoaMVkDEfZVb/CyMesnAqxE8jiOBDE6UhME55ToWH0dgp3VMYKhRSDLvpdJA7drp93hRUbe7pRfBlgLiQYkt6ZhWSA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675dd3aa-b800-4daf-b320-08df2f7447fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 13:07:38.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW1YTT31znI9nJusKJYLnpEsibvzL6gZMNX+8eMqWjSSdzipQ6AlKvS34L2Cyn2a3qHQ037OSbxoXecXJYt9lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com

> Once the header files are properly exposed, clean up these other areas
> as well.

Agreed, that would be a separate change, for the x86 maintainers to
decide.

Thanks

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Wednesday, October 21, 2026 12:35 AM
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
> On Tue, Oct 20, 2026 at 07:37:32PM +0000, Popov, Pavel E wrote:
> > Leon,
> >
> > The #ifdef CONFIG_X86 in cpu_supports_p2pdma() came with the AMD
> check.
>=20
> This is due to poking at `struct cpuinfo_x86`, which is not ideal but
> understandable.
>=20
> >
> > Would it work for you if I move the includes into that single #ifdef
> > block, next to the CPU check? Some multi-arch code does the same:
> >
> >   https://git.kernel.org/torvalds/c/c7be64355fcc (drivers/acpi/mipi-dis=
co-
> img.c)
> >   https://git.kernel.org/torvalds/c/7f3cfb7943d2
> > (drivers/cpufreq/cpufreq_ondemand.h)
>=20
> Once the header files are properly exposed, clean up these other areas as=
 well.
>=20
> Thanks
>=20
> >
> > Thanks,
> > Pavel
> >
> > > -----Original Message-----
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, October 20, 2026 11:40 AM
> > > To: Popov, Pavel E <pavel.e.popov@intel.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> > > <logang@deltatee.com>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> > > <jim.chow@broadcom.com>; Radu Rugina
> <radu.rugina@broadcom.com>;
> > > Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> > > <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Nathan
> > > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon
> > > server CPUs
> > >
> > > On Tue, Oct 20, 2026 at 10:37:34AM -0700, Pavel Popov wrote:
> > > > VMware and Hyper-V expose passthrough devices to guest VMs without
> > > > an explicit host bridge device. Consequently,
> > > > host_bridge_whitelist() cannot automatically identify the
> > > > underlying host bridge structure, causing Peer-to-Peer DMA
> > > > (P2PDMA) requests to be rejected unless the device IDs are
> > > > explicitly listed in pci_p2pdma_whitelist[]. To enable P2PDMA on
> > > > Intel hosts, this series extends cpu_supports_p2pdma(), which so
> > > > far covers AMD Zen and newer, with an explicit list of Intel Xeon s=
erver
> generations.
> > > >
> > > > Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> > > > Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by
> > > > carried over; the Xeon list and the check are unchanged.
> > > >
> > > > Changes in v4:
> > > > - Add 1/2, moving the CONFIG_X86 #ifdef out of
> cpu_supports_p2pdma()
> > > >   (Logan Gunthorpe, Leon Romanovsky)
> > > > - Keep the #ifdef around the asm/ includes, as these headers exist
> > > >   only on x86 (Bjorn Helgaas)
> > >
> > > I'm confident that this is wrong usage of asm headers.
> > >
> > > Thanks
