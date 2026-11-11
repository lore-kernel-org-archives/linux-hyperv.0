Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794441352;
	b=bfhU8J2P+tUERQBGcSSe7D84WpUUW6l/IikQJA2FLcZWojnOVH5x8pMZwMxil5eu25Z7
	 joqOV77+0WU+E1gmt9kxjSvwbOPBLPp2TAmkVQOApWTqzqJylTIF0Q2+ROiIzLbP2XlM0
	 LhQLmFfHiCfC6iGmu8bMst1+2InrVB4y2BIKb6bslnDy3fwUeAvow25Rbp94/CX34Y8Y3
	 rI/skXqgmSMMBbo0fb37g6IOFZ1eVKKb4G6fYlxONoP3JupqLkB/sATLtMjBXKRXBd0a6
	 JXGFpNehyCP+hVRGFUiXrmLnJHEkQkAaOi67zA8Jb05rsI4oxwVdSujrclgrWuMF2Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441352;
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
	bh=medP/Sp0aAE4swS7SvREl8FF+D0BabI9LTJ1dvY8mQA=;
	b=biwoI6f1Jp38dnNwlQrvMkq9XK7v1YrM0tzjrJzCeWMhEhF3+noeuQhZxHR+t/oQVEf3
	 HcxJrCwqtKPxHfDkiWo96lUDfpKUwQUJ6dUjCvKPcg4uoEdphC3sxolA71R+4MzY+9qTt
	 /Sk4CDy9Si6O/vB9c/Y9E0Vpt5NJA2rfQmaAoTaIKP6/I2462fFrdeHmYwJHWfED+y3ko
	 dHb7SafQMuApnE3AJ2iyuNLzUvS3ikcJSzgHy8AoOHNQ2t5xuZd6ZoiDfVsDN3LtkadR+
	 vWTWik5UMiZYrhLbKjR5kTzthnBK1PB3uyXbGegvy4wAP2wUnMoOv2KxXA/Bxe619VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZ0SaErH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA938606A31C;
	Wed, 11 Nov 2026 23:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA938606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZ0SaErH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794441352; x=1825977352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wkiXXbQ2VLVEurRF8ij6E0hgb7Hj5Xj6x62oMIHIAJU=;
  b=EZ0SaErHhJR7ga+OLvieCkrG47ZT5CcsIvEfGxwDDfKywZax1+zG9q2i
   mUi3MumpbmkXf9tMxz7USAqXF1dLnSVUA8bIbItOyetLw/jjjFzlW6PfX
   aN5IhdJoQimU9Pcd9OyP7DiUl1zS9pRujKE0MJYpodN+qp8kNyN0H11Kd
   /wSGkpXuQmUOOFd9oZjeajSQG5Q6rnY7XB4Np+2D5NoHLieNGesuoLsmc
   hpEbb8kOD6WEH6CwuXIxqMtHjUXaz2xi2iAYlqnuXAMm0kMupkMu3Y6qA
   np9naYmw5RKGiyMOD5D+Z1jwLrNLQ/RBoecdbQMqPhAq9VmXtx8uPMeP8
   A==;
X-CSE-ConnectionGUID: b8J9SENiSWKsXjZCIIUXuA==
X-CSE-MsgGUID: et9E33JFTpGCY3qqR51sfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3123778"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3123778"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 15:55:51 -0800
X-CSE-ConnectionGUID: jA5xqXxFQqaN0eIAdV+58w==
X-CSE-MsgGUID: o4f81DFNQ3CYpGNGz4HzAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="9090014"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 15:55:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 15:55:50 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 15:55:50 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 15:55:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GST6DdUAWSw/9Y6zewYSM438c064GUakytrlQp4ROaFFgCVnMPrU4HG7WaY8WOZJC7GIZDdxvk09YPCQTlOZnqpLY6iH7g57f1pnQrkQ6Dib0Ogu4rF+q1JMGN78RrsYMO3zw1hu9bWsFgSuBZbyuCxYhKJ607kN5vWr1aW4dV+PkuOK9wSqku1IjMvQHLdrDVTOIrSIqab3zX6LhQi3+lheCaWtzg5PhHVD3ApLLJwKpmKYMwYozz4chfzYUcuGCUts6XCbkHSUbiFClKFblcYTDSEz5a/9sfyRd9dNFcgoC5UlWx2w4tOn/QkMEXJ4A2mNwgf/gvli6JGreX+5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=medP/Sp0aAE4swS7SvREl8FF+D0BabI9LTJ1dvY8mQA=;
 b=jK+Yl2kgcf5BYHMx0cxHi0wUzbBN1PaRb3Cq6QnybeIEZwTBgAOeWGTgwPqK9UpOQghqWCPps7GJiwCGEPToVVLty/CWQvccL04GM84swE3X37V4STZfAzJ+YHJGbfnqyaLfIT+fWpRjxKTN5NZdBYnBL+Yl71PXjF1Q715YfkuPwr+oFSw4EFvtSwkWHjor3jLeVQhmbBAjOvb3Hdol1MrKaU3Z3impn1Njqo/4w8V1U0TioHimP6gBRVVKBqUvHiZjsd6HXewcaldVyZ1J6Hw7t31eoMQ04pEaMJrko8FS4J3D+de8kVK47jomezwhxxvKwX/q0SjEEZWoaONXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by SN7PR11MB7974.namprd11.prod.outlook.com (2603:10b6:806:2e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 23:55:46 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 23:55:46 +0000
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
Thread-Index: AQHdYLm3Eu3+F6ITg0+VFiHnE2F7qrcoXBEQgABK14CAAG7WMIAASTcAgABOLCA=
Date: Wed, 11 Nov 2026 23:55:46 +0000
Message-ID: <LV2PR11MB6070D62F7D135C63AC727E36B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <LV2PR11MB6070064A9E674EBDFB1A3B20B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261111081057.GP8635@unreal>
 <LV2PR11MB6070A8BA690DEA91D6675682B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261111190942.GT8635@unreal>
In-Reply-To: <20261111190942.GT8635@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|SN7PR11MB7974:EE_
x-ms-office365-filtering-correlation-id: 1fc4e70d-5ad4-4da1-c4d0-08df404f4dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|10067099003|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261021123027099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|18002099003|22082099003|6133799003|261009223327099003;
x-microsoft-antispam-message-info: LLniLDTdmGs/ahxyhdhPUHi1ULUakT4DItFVHg5D88Nz0zt2VYcwe5TlQDy5Tq3bK9cUFU2cFLdaHpO8vXnO8pZ0QNl+gkPoNcdXJ7axI+sHcI8ozKbuq1SDumfpAYTw1Kz35Hmpno+gC7Plng/MeKuVJkKVQVKFTJNZ7wI+HdJoTlNSZytrVL+HbzSLK8DKdUK2DCdV2rQRMYs9uLhQ03Q1CTJd6J8tiBdGvj2ctYvL2prFQhkoBs9KfKadZrXCL7g9AGzXn1zMfjxMIYSnBKvjg2xiTbmZzIGWLO6wpgZDpjNV0vuq9wZIZledDRodXuOjLI+0ENz4l5K1uS1AtV9MsiBEZg0zVvxg67y47M1FQ1J8mnJzqvTl8DBfsmkmnq6PD6V6Gek/oFEt4jzyplmHJekZIrBt/UM7o9w4MyxgFga2NMNq0IjCszDVQxv0tkkxYfZKfLv1GdTf3gRNn8Yt2H4GTAUlwgGU0XgwZhDy7ndXNr9dK9HX02nj72YxCUtJOMVZVdR8NEZUvuBeNihwsBI9CQCnwHo0l3RR1bLTPrsWk0Bzf0O0y6wIV5ZPdmjHBcQhpveyUsHoXwJrdgXm13xG2HEflZs7SZ5IFQDzQ8H6zX5CiXwgJQL7FeXRjU2Omjj6CFpJOzZOd2K3NNRU0D9yB8YIAfNjwYs6Mqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261021123027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(261009223327099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7OZhy1Mw5AkLsEktPnBRm7mF8pEX/0gaa7AxWqZW4xOqbWLULgHDGxhipUtM?=
 =?us-ascii?Q?c+k0Hf1gyxcwnxr+aVhVd50IpZh7fDZyaDx591OV9tsdfbcxvAUsNsdRyI0A?=
 =?us-ascii?Q?/MRN7fEmBpqIDriblnlLkdkVqBZ9Xv90ZSZKmH54qy5X+gVZ5ehJI5zYMrc4?=
 =?us-ascii?Q?uksV6J+nElfTGkdV5iI4magClvsPnF3dSRcR0F5tdqv4TN+j8m6hhAwfaqj/?=
 =?us-ascii?Q?Fl+Ms2Q7Jaf+PNV4ZJ7wMRxpqYNTen0B2yQLsVeJ4nrchAXDoLK4Vk9hXZFP?=
 =?us-ascii?Q?g57fpeqba4AUiu69SMe7F0BZ2uEYxb5ofva7K4dzoWS4VuAEqkNGfniS3/1i?=
 =?us-ascii?Q?uWlt9MWbnboVPYEyUhd+nCEFEqM87VUMdG5hlgRpg49HU7vpRL8A8l1D4g8m?=
 =?us-ascii?Q?p4l2W8+QpUlot4YP/4Du1Ucg6gnuQCHl7BQM8RHPyErBT6abrvv8f/TRuTIr?=
 =?us-ascii?Q?wM20irk3xCXw/KwsbfegdnuX76nLGnP6WHSwZOF+otPqdYY2nPqtNrRS396D?=
 =?us-ascii?Q?raToF7/ruxwm/73GmeF+onguXsQFExzljUkpjLzWxlTTbvLQNuVBWQArgobU?=
 =?us-ascii?Q?kCAeJL7dVRrr33LhyENfaRfVffamTZSJ9NnD95NN34WpY8bx6ZekdIC3JqZC?=
 =?us-ascii?Q?3JT3NtYfh26Ym2hmVMYJUUQOCks53J+auXU9qg+/pIPTA2Oj9otrLoN5r3mN?=
 =?us-ascii?Q?IQYA47tHPOj5UjM0j26VmfkW044A8tvVHVEI/EQLThTO/XzJQOrTAe1q2exI?=
 =?us-ascii?Q?SEnsWV1KuEovLNE508XzNNRLzgsgoymOCSN1/5VotC/qlCM6Ix+wY0GIk3Fs?=
 =?us-ascii?Q?neALtvfFHFL5HTQPdL6xSDHRBRxmqHic3g2RL7RCuvDPNA3IEmWuFspDR6yQ?=
 =?us-ascii?Q?LsF5cM6ujATQu3b1GF6FvWtqQnhe64b/b0+EgexpXLiGU7uN4zfQwpb2vu9r?=
 =?us-ascii?Q?rZ5WMfUVZTYG/vYYQeu4aSwBX5vmOBGXbFHWJq02OZ8orQyecDsJcw8o3E4c?=
 =?us-ascii?Q?ppevBpar49aBVqmty+yDx8TQuhdmwK+djVYy4mTSuzypFJ/zOW/n5dMRzN3K?=
 =?us-ascii?Q?fSqom2sgbeci6ZgJNdwZ9IXbs3IzRlQ1eiJjo4KB5LxLVW7MAT09uFpS+fdG?=
 =?us-ascii?Q?V6ZrMJKFokLv0oF2AMJukeDLk2LmxWzjgExwPKt8QNGHglMOQmUt0BB2PkqK?=
 =?us-ascii?Q?xzrf7qrXLxuWXAENmn1aHyQKHHjcA7N7/haBh7ChpnuJabaBgvl+zz0MwvwI?=
 =?us-ascii?Q?xxFlYfOvCz1asUlpfwNZZqV2fkOKjwHOM0UiLMnw1nSldzIEH4OO0A862qxF?=
 =?us-ascii?Q?HBoViQ2V9dkdZuIHL0RqnJEf1+UJxacLgHlBBlb2a2gfjjeUIHo3IEQuYJPA?=
 =?us-ascii?Q?SJ+LEXAPzx/jGy5Km2KG/K4UoCOM+pjcckc72g3v58ZUdGYeWMsGsxLXLOt9?=
 =?us-ascii?Q?sUUI6KGtN38DC8/gmWB1kU8PcqE4MBWY99hkpZpAhPVumI0KbNvsBleFXLX8?=
 =?us-ascii?Q?0463+puIPdYdK3IdivtxE3x37J5OV0JdUyf5Tg3scRhG2yO4iXGK98lqEXew?=
 =?us-ascii?Q?2YHAkEOXFlMd8weY0c1C7aI2IGmeB4efblQzBtJViVOjfcs4eWrqbRWkdcHf?=
 =?us-ascii?Q?RIJeO7k9917HaK6ApQQlT9kVi0FuFvg5mY0c06XghtvQjHkDF0uuG0zu2SUT?=
 =?us-ascii?Q?mWlpzOBtPbG9l6oR0L2V6ql4oVe8lLlkM68qbIKPgaVqfoVnWM2OyM1SrCZR?=
 =?us-ascii?Q?hheo7g/MDw=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: NA3AHyTjWvetURYr6Q/aLPfxhRoB6u7M/K5BWnfs3Setrwm2ODmK4TgvpW7BOsIi4gkquQMJVPQBC5NMubstk9aHYDbIW5w/ahf4jTqFlpharTc1HK0KchfP7Wu6Q5cVzqdY5KOkUOqdPhi4f98mqcNsj4b+mG+qM39mYXutLnx5nf7Eip6tE0LvAfIdYDOzoNeHsM98XslbLNIIyCyaMLRWiV3Nhu7AffAKBv4CstXsWicyHK9/E0fUxO2L81kA2mcH1Weg9KKOzl/xNU6Lf3wX6bzj0xU4Dixmjuy6ygoZ2XUmGdS7MfUqXvd9n2xSRrO9hImDbHOsWXWN3Qh5vA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc4e70d-5ad4-4da1-c4d0-08df404f4dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 23:55:46.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EONT6zN801lhieRE9AkFOrM/ycGZX37LjRkLDjDEsB0vhErIy4wb2zrWf/8NSuJu2MGcAxzYuVUOJmZnIQ5Mug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7974
X-OriginatorOrg: intel.com

On Wed, Nov 11, 2026 at 09:09:27PM +0200, Leon Romanovsky wrote:
> The only sane approach is to do the cleanup first and then build the p2p
> changes on top of it.

Done in v5 [1]. It adds an empty <asm-generic/cpu_device_id.h>, so
<asm/cpu_device_id.h> can be included without #ifdef CONFIG_X86, and
the P2PDMA patch sits on top of it. The <asm/intel-family.h> include
is dropped, as <asm/cpu_device_id.h> already pulls it in on x86.

The follow-up series [2] removes the same #ifdef around the include
in the other users (ACPI, cpufreq, i915, amdgpu, tpm, ccp,
platform/x86).

> If you are ready, why hasn't it been done until now?

I missed your "general asm stubs" hint and read "properly exposed" as
moving the x86 headers under include/linux/, with the aim of dropping
CONFIG_X86 from the P2PDMA code entirely. As that is a much larger
change, I proposed doing it later.

[1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
[2] https://lore.kernel.org/r/20261111234821.4814-1-pavel.e.popov@intel.com

Thanks,
Pavel

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Wednesday, November 11, 2026 12:10 PM
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
> On Wed, Nov 11, 2026 at 03:37:13PM +0000, Popov, Pavel E wrote:
> > On Wed, Nov 11, 2026 at 10:10:57AM +0200, Leon Romanovsky wrote:
> > > Peer-to-peer is a general concept, and the code should reflect that.
> > > It is reasonable to expect you to join the effort and help clean it u=
p.
> >
> > I'm in. My proposal is to do it after this series, since this one
> > unblocks P2PDMA in guests and the cleanup is out of PCI scope: even
> > the minimal fix for p2pdma.c alone means changes under arch/x86, so it
> > would no longer be a P2PDMA patch but an x86 header series with its
> > own maintainers and review. That x86 header series is also the right
> > place to drop the same guard from six other files, and I'm ready to do
> > it:
>=20
> If you are ready, why hasn't it been done until now?
>=20
> The claims of urgency are hard to take seriously: `SKYLAKE_X` was added t=
o
> `arch/x86/include/asm/intel-family.h` in 2016, and now, ten years later, =
you
> are asking us to "do it urgently." I strongly suspect that if I don't bri=
ng up P2P
> at LPC, we won't see this patch for another ten years.
>=20
> Even now, despite being asked to clean this up before the merge window, y=
ou
> still haven't done so. Trust is built by following through, not by making
> promises.
>=20
> >
> >   drivers/acpi/mipi-disco-img.c
> >   drivers/cpufreq/cpufreq_ondemand.h
> >   drivers/gpu/drm/i915/intel_cpu_info.c
> >   drivers/char/tpm/tpm.h
> >   drivers/crypto/ccp/ccp-dev.c
> >   include/linux/platform_data/x86/soc.h
> >
> > Bjorn, is v4 OK for v7.5 as is? The x86 header series will follow on
> > top.
>=20
> I disagree. You can't build this on top, as it would need to go through d=
ifferent
> trees and would likely cause merge conflicts. The cleanup series would ha=
ve to
> touch the same lines in the PCI subsystem that you are changing now.
>=20
> The only sane approach is to do the cleanup first and then build the p2p
> changes on top of it.
>=20
> Thanks
>=20
> >
> > Thanks,
> > Pavel
> >
> > > -----Original Message-----
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Wednesday, November 11, 2026 1:11 AM
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
> > > On Wed, Nov 11, 2026 at 03:48:07AM +0000, Popov, Pavel E wrote:
> > > > Hi Bjorn,
> > > >
> > > > Gentle ping on this series. Is this OK for v7.5?
> > >
> > > I would say no. An Intel employee was asked to clean up an
> > > Intel-created mess while upstreaming an Intel-specific patch.
> > >
> > > Peer-to-peer is a general concept, and the code should reflect that.
> > > It is reasonable to expect you to join the effort and help clean it u=
p.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks,
> > > > Pavel
> > > >
> > > > > -----Original Message-----
> > > > > From: Popov, Pavel E <pavel.e.popov@intel.com>
> > > > > Sent: Tuesday, October 20, 2026 10:38 AM
> > > > > To: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> > > > > <logang@deltatee.com>
> > > > > Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Leon Romanovsky
> > > > > <leon@kernel.org>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> > > > > <jim.chow@broadcom.com>; Radu Rugina
> > > <radu.rugina@broadcom.com>;
> > > > > Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> > > > > <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>;
> > > > > Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>;
> > > > > bcm-kernel-feedback- list@broadcom.com;
> > > > > virtualization@lists.linux.dev; linux- hyperv@vger.kernel.org;
> > > > > linux-pci@vger.kernel.org; linux- kernel@vger.kernel.org
> > > > > Subject: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon
> > > > > server CPUs
> > > > >
> > > > > VMware and Hyper-V expose passthrough devices to guest VMs
> > > > > without an explicit host bridge device. Consequently,
> > > > > host_bridge_whitelist() cannot automatically identify the
> > > > > underlying host bridge structure, causing Peer-to- Peer DMA
> > > > > (P2PDMA) requests to be rejected unless the device IDs are
> > > > > explicitly listed in pci_p2pdma_whitelist[]. To enable P2PDMA on
> > > > > Intel hosts, this series extends cpu_supports_p2pdma(), which so
> > > > > far covers AMD Zen and
> > > newer, with an explicit list of Intel Xeon server generations.
> > > > >
> > > > > Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> > > > > Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by
> > > > > carried over; the Xeon list and the check are unchanged.
> > > > >
> > > > > Changes in v4:
> > > > > - Add 1/2, moving the CONFIG_X86 #ifdef out of
> cpu_supports_p2pdma()
> > > > >   (Logan Gunthorpe, Leon Romanovsky)
> > > > > - Keep the #ifdef around the asm/ includes, as these headers exis=
t
> > > > >   only on x86 (Bjorn Helgaas)
> > > > >
> > > > > Changes in v3:
> > > > > - Drop the hypervisor check and move the Xeon list into
> > > > >   cpu_supports_p2pdma(), next to the AMD check, as suggested by
> Logan
> > > > >   Gunthorpe and Leon Romanovsky [1]
> > > > > - Fold the VMware and Hyper-V patches into one, as the check no
> longer
> > > > >   depends on the hypervisor
> > > > >
> > > > > Changes in v2:
> > > > > - Replace the Skylake-and-newer threshold with an explicit list o=
f Intel
> > > > >   Xeon server generations, from Skylake-SP to Diamond Rapids (Log=
an
> > > > >   Gunthorpe)
> > > > > - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
> > > > >   (Logan Gunthorpe)
> > > > > - Rebased on current mainline
> > > > >
> > > > > [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
> > > > >
> > > > > v3: https://lore.kernel.org/r/20261020151305.65218-1-
> > > > > pavel.e.popov@intel.com
> > > > > v2: https://lore.kernel.org/r/20261016223402.19991-1-
> > > > > pavel.e.popov@intel.com
> > > > > v1: https://lore.kernel.org/r/20261009154034.82321-1-
> > > > > pavel.e.popov@intel.com
> > > > >
> > > > > Pavel Popov (2):
> > > > >   PCI/P2PDMA: Move CONFIG_X86 #ifdef out of
> cpu_supports_p2pdma()
> > > > >   PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
> > > > >
> > > > >  drivers/pci/p2pdma.c | 33 +++++++++++++++++++++++++++++++--
> > > > >  1 file changed, 31 insertions(+), 2 deletions(-)
> > > > >
> > > > >
> > > > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > > > > --
> > > > > 2.53.0
> > > >
> >
