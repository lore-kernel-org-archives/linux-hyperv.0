Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794850532;
	b=bHr7oT731FPky/1CJ2Ud9ymhCYarqruOXYfPA91hbnU4LkfYIsVfgUCLyc/nI30q3PV5
	 cl2hsqyn5JEkqJ5aXt8f3WoWT7mlGDt7vFOKfnHCd0k4NY5Grjk0jVP+6jZx1egA0TB20
	 cWzlpQgKTDn/pF75Crj0Ax+up1+4yZHqdlV1o8MvZlpMO5uVtCBw6n19G1PKpBmw6TofL
	 KAHrflmGlcagWOICpQy3Ez0SQg0nL6uLYj1alqld2BSsZlWbFSEofIGKl/1kiLd9J7Qt6
	 p1FVleISKCXf5Bfd9ZINWSbO617hB0U9wHUUP0QIbT91aWCZ76L9hE3TZVEHloRmIUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850532;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=uP2bxsKf7KHMG48/fuOn+Al8Cgv9W9H4ruQy1THCqyo=;
	b=h63gPp9tKyJTKgrdnvu50MdvBU30Lr+op/mJD28yZe07uF9jZUssJyJy5u61p/uAWi11
	 SP0rkqZTboOkOp3A8/6/X+3kLAh822daYP8LTLv+UvKapuZBGvbF0zQNt19mU7g4mm74f
	 lCuvT8DHJBTPPNjQbgdEPyb9I94lXEqVI9stCnU/aO+o92dZnFj6kB+cnjbKGyW/9aq8j
	 h9aGHnXOzUOJgbeJpOBj9bEtwpmwsw21h7X5d6TwvAUKVu3zKw8N3i4wM4/qOcdI9j0gS
	 WVytueV3GkIOSL4IClq43nu3khALaPBt+n9XhSuyNdLaWRMUTOiu51RTuuEzHoeNRFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJK6nY9A;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Lppc0SP6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A12606A31C;
	Mon, 16 Nov 2026 17:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A12606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJK6nY9A;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Lppc0SP6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794850532; x=1826386532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qq5Hr4u9822G8GAuYeBZfYTHkkMXlyl5vLltIm4Kdfs=;
  b=FJK6nY9A8NwRQReIHhU9n+WYzEMtHs7JUtb0aCMuFn5vkedAZK2XBiF3
   uL7wCR17NbiGVI7veabB1+jZWGGmgsl/AYqrahp/bRwmSFzPFppz66cUY
   LvpGbp86+eV0Fq4UHFmz9JQrMb/jTnlLbMBf7ysnCsFWZUg2xpIZ98mjf
   Ntjc4w+QcOiYLvFE+fU8QxiOSWTGbeFxg/N272ruxjCA1z+iBOuw+YJA4
   7NVbnxPprGk/LwDmHPyEcb/vO63Vu6cpQXaQ4b8Hg5lAmPWhkr/YThQC4
   h0yJ8OpH9Y1fXX1iYkI/oLgU20OhFpId/yfrC9u0D/fvn8eyjaHRwXelg
   A==;
X-CSE-ConnectionGUID: UeWR3/apQ76jnLjtNx5/HA==
X-CSE-MsgGUID: sIrxTFN5QhW+SLmxzcEI+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3612159"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3612159"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:35:31 -0800
X-CSE-ConnectionGUID: nnw20GLkQdeMuyuUq6+Glw==
X-CSE-MsgGUID: PumEsv61RgO9lDYXkEh0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9674705"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:35:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 09:35:30 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 09:35:30 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 09:35:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkAV4ncA9cNOtTM6xArfoMqJQBwlNVJ7eGLEtBsCEYtpnLBLFeuHrhu+SsFnXfku+llUE3f4ekoD2t6hcgCeZDNcxIxBXbQiHHkbxeHZPgOqmyu0+U4OmxewyWf3t/+lkhdg1DDwp8h/cdgJVSwYTOShjxdpkNXvgg4BgV3VbQW1RiM/yOK6CKEjXAVBjwks0FEzfXJPjzl9VEVn9dIZ+rSXyKOVhvV5EtOzvLo3TiOm9ag1kYwdAiU43ljv3kpZ8VcOT/ER8Ur9KXw1HE2hP+tjT4y8i7EWj8/ilPMoHLH0XK24pUYoLkM9UqK9DkXT+8ZYwiZxllQXcOUWBScBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP2bxsKf7KHMG48/fuOn+Al8Cgv9W9H4ruQy1THCqyo=;
 b=VzQ2gU8I0ahe31Xm2c/E0EOEkvzKmhpSbMwWmhEi0jCr6ZTQew52g4PoEvHDfDctqbjOAaSrxRueMOtclxXtjhQxzPIYEHNoOC0FBKUfS9qazwZOAi+f/dOOl8tdvHXNK3aA6kbS0LoULBM7qTu0rVRWK8Y+lV4Nr/JBENBbkSzkgP7VGO9x4djn+/VwtBys8Yd9I5vXPaXoDmy7MMQ7JT7qptJ7PyiHkRr0wGzxemI2YcFQ3oXK4uNlSHNYvw9cBztzImVJQy7/CH3aU62xjQF2SjqqvoC9Yf0YrxbL9V1wT7Iq4BT+WPKKJLdCGWe7o3D/dIVjbwQIUYJIRifgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP2bxsKf7KHMG48/fuOn+Al8Cgv9W9H4ruQy1THCqyo=;
 b=Lppc0SP6kXgmKWF0PC4jZkKRMfdYeaCwx4G+IQVsRC/WJk/kosQ3vuMXlcHaWHYx9MnuwRc1HLLuNLJWz2Db4OMbFzr2ccnfknBiRUpwxEeAKBWKB1eNeqqAZXLoeplghzENq34s+eO7WdR4GAHtexWUroDHkS+xzc5uRTQO6Sw=
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by CHAPR11MB9656.namprd11.prod.outlook.com (2603:10b6:610:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 17:35:26 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:35:25 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
	<logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky
	<leon@kernel.org>, Lukas Wunner <lukas@wunner.de>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Jim Chow <jim.chow@broadcom.com>, Radu Rugina
	<radu.rugina@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, "Nathan
 Ciobanu" <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Thread-Topic: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Thread-Index: AQHdcjaoFI2tPjq4G0qhtkBtbNIwWbcwQUOAgAC6w2A=
Date: Mon, 16 Nov 2026 17:35:25 +0000
Message-ID: <LV2PR11MB60700E23494D2D82AD66638AB27C2@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-4-pavel.e.popov@intel.com>
 <avqhIQ2krd1qgp6K@infradead.org>
In-Reply-To: <avqhIQ2krd1qgp6K@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|CHAPR11MB9656:EE_
x-ms-office365-filtering-correlation-id: 837e22f2-dec2-4c89-dd3b-08df4407ffe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|6133799003|261009220027099003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|11063799006|4143699003|56012099006|261102123227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: MSEElJay8ypEfvasxf0/DgV3rauuMUNdhEKoFkJs0UvO3FNMpvoKA0H6p5Wr4SxiLOatSUcj1UC2irhzx7PlOHf25Ke6HcdTLX+Bjk3oLtCoNPCewVQvxrZbHD4r12EgWaC1yzQ5ECPK/sdmIBUkz8JgV+z3fwPMVdDVmuxxBc1XhrL1R5aIiezEmE5A1twTaXgwDrVWzzVrs7tYt6mN0ban0jbp+pB/FjXtqKEYGRgC445+tvw/ajvc7mq24wrxHIQvs5vdIAJRf3odunKwdeqhMrbXzZH51pSUAVnr5dy62lc0I6yQu8L+xA87Nm14G80wpEY3j/RM0tIz64LhjGttaVo9TsZibNZLpNUIPLY9jdQJguhmlnE/tNBaMg3R1ZsQUBcURHGD3Qu4OiZB5KFnwwrA0jZyqbvIHq4kfcWHJ2nnCMBNiU3D5ihPL7yvmrrf4kD6aAwIv2OKwW5TV9XWWqtYUsvdA9n6lLEGlTGWxwq5AQUsFgj2tb4Dfd4+3GRK/NxMrG+VIZ53kc/Wp40oh8BMBw1pRDvolyG9S9S6mmFzlyw5fCrW+u7tGfh1ClCJ2ZB217G0sZzTpUz79OwBUcQ5rKFc1Xln6ayYKJFUwpSVOxXkpJ1c2NO9IhdgSa6XehQlsGTWdZ8zYpxUmAfiqUhejnaqjJ+mRX78yZ04gOdYFmmo9UbLBiEjC89m9Pqu+p7MonkPAmg6Ot7jlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7Gwb6EnaEhLZfJW2PepYoDd8aZAQlaVv/zyu+/TGA1xmkXqLHJ6h1PzZ5kN?=
 =?us-ascii?Q?mEpvJCEvPklEbY5tuf1XNjpFYjO26pOKqIQ9tivggt8v/5i7U4pMAICamJZH?=
 =?us-ascii?Q?EIqTBhpJYxSU3PLX1vgBchASIl0egEo03pe+kMX/aewYj7GVGgswneIvaEdy?=
 =?us-ascii?Q?uAZGzeJ6BhMYNUJkjSy+lpW6CG8FcBqg+EwfQnpC3B4uxpr7CQsUJYx8WnJ+?=
 =?us-ascii?Q?xf+b/v++RfNa0pifLGLBDZY0WqDD8PvAYddpkYoaKKbnP/0iCOmKCw70pmMQ?=
 =?us-ascii?Q?RgQWmehLyNpEg1rncAgpWBL6AC+lCFrkTjqe8WlWGYj1MQl391iVDHmIU41N?=
 =?us-ascii?Q?HcNjuaXaWX8njPKYotrPQv08r0gzAmFqh5SSwwEjpRJkfjOtbWhK5q6GqBgp?=
 =?us-ascii?Q?3hM0O+vSK1Zu9CH2dHaWWhKH32YAlxVR0BjuDlG2i6kIxFh7bxucZfm6/Ndn?=
 =?us-ascii?Q?yZljDRgqL0dL2ZI9Myne548+9fmF/HDs3fcaic5N3A6lAYH0/vUVSNXPQOIo?=
 =?us-ascii?Q?ul0ad669XxyQ3+CQIGuyq89ZdCRUv0TZ2yF1A5HR3FFeTG5eZUq+nxERKBdy?=
 =?us-ascii?Q?3FPcxuKDmXRv82Fozuw1iigyhqQJX6TI1tsUg+FlSZIAHbnVttGetTrbwbj2?=
 =?us-ascii?Q?PAM4RCGaL+pmo5YLQZdOXvsu3Ha1A9yEu4/az4N8TRQX6qgzM5/mFdbcDd1u?=
 =?us-ascii?Q?5fIVmvP69cTcweVzmdlX98toYjJ8QPbeUJ1WuDvqJYie34c+NEkqHwa8GdnG?=
 =?us-ascii?Q?mvTKZ/AyVPZBFyiDAW7V7P/DABgxqGYlxTBtnHVaxx7WEzVG4ayrwsQtpoRX?=
 =?us-ascii?Q?5p4pfXZ7XhXjIS3gtVJFHkVj4b2XD4tcD6G4zZIz+PQCpcIz7f8vmjwIRzsF?=
 =?us-ascii?Q?NUsEjNuz9iR8SUwrYOs7D1nyTaemWXC757qt/6MejK+FcvQBHr1ecMxdTlC9?=
 =?us-ascii?Q?eBrqGUP1rnAQInpEBZjI2JI8JFT6+m6z4R3nM8HzM6c1AQ/z7xvq4fVFqRMW?=
 =?us-ascii?Q?FQUEh+JRQ2ve6ZrUYhcWAcbZXfSa2Rsf5ALYcxMdzjmvu8iTCgducCj+MCKR?=
 =?us-ascii?Q?mSzvz0wSsa1Q3L1KZCYR5z+hhqPs2Br6ENB063cGhuMCIHI0hA2uEimz+9aN?=
 =?us-ascii?Q?3Xmx93k1MzHC3PBdZTmi6wcE8H9voHf0JRti5LISAvz8gjEIFeIq137JrDNL?=
 =?us-ascii?Q?SjAqo0Z6K1/nfwBtdOQj7hGxgDK7ltIV8E0274Y/eWUq8O0XE4sC1/v3YvjQ?=
 =?us-ascii?Q?ZjaXvxo6ARRbVOky7gvg4E8Vc4J3p65kLdoOZYg5WNrDxcLTg6yNtbXpY47X?=
 =?us-ascii?Q?pvYyy2LSoP/RDCkKJlbsXGOYr/6RUiSf/+V8iAvhLe0WmukSvfZm5SOcexwR?=
 =?us-ascii?Q?unfM7GeClQ1i/M542KKQJcCfGTfCw9S/cUH9ZUDkBc5YCXxhHTokZa0Vxs3f?=
 =?us-ascii?Q?4uUdeGVFt3IHdEol3lpP7aZJdeBrbCp77errs0p9F2SGZ2JcZp4R+v8bWKSl?=
 =?us-ascii?Q?mkMgS/wLyRujcbQGzF13xIDtuON9J74XpaOVFJ4/sl3uPUpHd5cksDalj0E8?=
 =?us-ascii?Q?PT3YQos2KdbE6Y8rUVQSf5xTkAxVPFsEv+wskUf+0Fq3fi4y/WJrAKdMPyK1?=
 =?us-ascii?Q?xSuFvLTgSDWqmkzskeutCyBpVZXa6h5eAmvpSbAB48gIisa7GjEUydU9dyEt?=
 =?us-ascii?Q?vOgZLAEVMXuRZo63p27c4fytDInJqiKPTMbcDUCbg2K4jMwXgqbHL8Vq+pC4?=
 =?us-ascii?Q?2IqQ37NCxw=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: f7ns3LU49VZD1/NvqCUfNTdeYtnfhk7KASN5T7WnEtiu/7HEJZ/JTdLMyjOsmjc4G+BUwnRQ0+l63r/xWJH1f60g/5aXCH/n5GQHkAtco4O2Eaj4+y/yRfOwmNkvVvrlIiHPLFbvnZY+ehKotGQBRkOrhHkSUXaRji8UaS9c4DuU1hHmZFNsS7eq9WakrbPyEdrSGgzBp6AcnaTLwqRmUUl/rE6e1MB5u4FBK1jiqq+/bQEXw1V644cSK9GH0Tjt1v3D81pNvRi9PHPoZiMQjKNA+7G2DDW6o7ocPuvLVMuHWeh8qiUdKpg578rEdUQq9n88VjEvChxPfy/UcXAfww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837e22f2-dec2-4c89-dd3b-08df4407ffe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 17:35:25.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYINH2ZwYcqVs+op21f0kZVM5WdPWASyRrMTf8b4lZITSLOgoSmSUtc9r1TW5GCP/jfgz479pY1xqEsF1WHEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9656
X-OriginatorOrg: intel.com

> Why is this in drivers/pci/ instead of behind a clean abstraction in
> arch code?

It extends the existing AMD check in cpu_supports_p2pdma(), which
already reads cpuinfo_x86. The table describes a host bridge property,
not a CPU one; it's keyed by CPU model because the host bridge device
isn't visible to VMware and Hyper-V guests.

Thanks,
Pavel

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Sunday, November 15, 2026 11:22 PM
> To: Popov, Pavel E <pavel.e.popov@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> <logang@deltatee.com>; Arnd Bergmann <arnd@arndb.de>; Leon Romanovsky
> <leon@kernel.org>; Lukas Wunner <lukas@wunner.de>; Thomas Gleixner
> <tglx@kernel.org>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov
> <bp@alien8.de>; Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org=
;
> Jim Chow <jim.chow@broadcom.com>; Radu Rugina
> <radu.rugina@broadcom.com>; Alexey Makhalov
> <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>; Michael
> Kelley <mhklinux@outlook.com>; Nathan Ciobanu
> <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-list@broadcom.com=
;
> virtualization@lists.linux.dev; linux-hyperv@vger.kernel.org; linux-
> arch@vger.kernel.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
> CPUs
>=20
> On Wed, Nov 11, 2026 at 04:44:39PM -0700, Pavel Popov wrote:
> >  #ifdef CONFIG_X86
> > +/* Intel Xeon CPUs whose host bridges support p2pdma */ static const
> > +struct x86_cpu_id p2pdma_intel_cpu_ids[] =3D {
>=20
> Why is this in drivers/pci/ instead of behind a clean abstraction in arch=
 code?
>=20
> (and the fact that the CPU vendors still haven't managed to provide a fir=
mware
> interface to expose the P2P capabilities is just insane)
