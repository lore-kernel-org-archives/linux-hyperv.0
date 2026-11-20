Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795211065;
	b=YK1HKvAiNOEW4Fe7q45eSiwy/Rb8IzEfchD9byrE9iMs8Yuqc2p9a38SYOdU8tbz6UQU
	 hVGAthfCxzGX/QUFnwHIhCweUGjmPR6I73/Bv2s0jEkP/ngY4zvzYUllh80GRv8kNacFS
	 ek5082ZNR5OwNwa1Wt26P/vxgQYywg0RRTu9yHJLQB0RK8+A6TS3RyADBrJw4IA3rNYHs
	 U8JOL8+w1o4aXOyFYZu4AM9El2CNOxVWYS5vxE21WikTZGSxty0801mFosq2QPeR1nXC9
	 dju+ZKtB/cYGWiEj2TevYfU4lfdeDPplAl4zIalj7esp8bu2EJO8gTMi6DVm1uqsRDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211065;
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
	bh=fF9B1USe3xW8JGjS6vwUwtFiylROVUZk4lEwhRnfJhk=;
	b=ap17QesEShej7BQ8rMVHziOApIlwA5burkP0UlRBHx6QgBaaaIP9pLuTdd6VHGYLvVZl
	 IcGmk8nC59TL7tH2AEPQcLBsV6g5DtZonDh1KUSDePTncqkOZfqJu2gI4W59zS7y2sHhf
	 XGI3BHo6yAfvKZUdN8yHFQKq2Dtr7fIztOUTwIo2zUk6OGAtS3Xf8JndH44tNB6t7Hya8
	 KnBbJ/5S7LmmqrdqAKW7HgzzDKv4CHnuiTqfPlipgu5P7DqkoNkQwuInmlCncZIsY/yLj
	 fEUBROK+hShl43FE1ZFle44/Vc22NNqKgXMmQHdmjLq5NJ0C73WJ5FCybz1sKMID5bQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mSTgXM7a;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=S4BPLBjw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA034606A6A8;
	Fri, 20 Nov 2026 21:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA034606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mSTgXM7a;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=S4BPLBjw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795211065; x=1826747065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fF9B1USe3xW8JGjS6vwUwtFiylROVUZk4lEwhRnfJhk=;
  b=mSTgXM7a6VjRRwJa8/Tj34tA4nBQLAzJ5xj5ZOCO9D5zVdkus3cI+8Q8
   gn83awpJdC6l0uLVE8bRSzm4c2b5VQ78fJP4d4Nht/3fhj3m5EWY8LK51
   kJLtubHULfu9BI45gqoBl72oh5za2+9Hv0Cvb+hWpz6xl7Fn1Y7psjRzP
   1V9XbM/QJQ7ifijk+BPJjg1ghUhbvJ7aC/HhwA+TaTH1Yjshj9A22A0gF
   uFroindnhl7UvD6QAFjeqCi0pCEniOjcZtWjlU4R1dWxwMr1bUZcA/mNt
   dFS4HYRNsKs2z0E0fotwzowGDkcc6zJN/OqBIEZX+MIecCTpAPFuO0qpl
   Q==;
X-CSE-ConnectionGUID: 4c5KUx82R6OJlVwyRu+/Ag==
X-CSE-MsgGUID: sLGrN1FlS46LVi0NYAXXbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4111268"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4111268"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 13:44:24 -0800
X-CSE-ConnectionGUID: jQBCzPPFRXiDdNCb7OnfCA==
X-CSE-MsgGUID: GkiA4KTRRvK3uvYEQhQgOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10737252"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 13:44:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 13:44:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 13:44:23 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 13:44:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT6i2DUKC2BA6mMqeDRmRtqVcgrw0dIdJt9zckLwCCeoqnt8uyYviGzBno/3nHe7Fc0cydNn6R6vqmaN7o1jVaIJ79eBLa6g5+eLykleV8Im9/sMibx6WnpCRmUjaIVHFpMjt3Iw2j/BSQSmU4sOCo6Bf1PDFohw1n+oA+z+y6itWsM45vnDVuT+vnzVlOpvCPg/Ph8CoWWCp6Sxdu8Vsr8AvceD2ARX/OK2ajX+67++RpgELWX67NryZpCFfA+4+QX7Wj901KMyFQaqINcP2NPSdEJKRwPYKE3qX+5wi8bkDN273lRHISMIOE6UIu7IkRHLzFSmCpBhNLVQfmewAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF9B1USe3xW8JGjS6vwUwtFiylROVUZk4lEwhRnfJhk=;
 b=xdUEc7nueyIjiiLBKY1bO3JDnU3RppLb+9S2ZONhbyHUNQ/MNlKGCBroEZVH47dkp/2P2fd6LZ9Nd1+UOXnS2vOu4CRKbViDia8ciP/pwaH6u7h2bSVLV7oBBi3M2ewFgkSUETebNCPzo5XEMVAqdxL8X4uR09oigZE+8MYvGROU3YUz4xWchu5I6oVMedbWqzgIKDdFohlGZamBqLqzaZ5C5wyKcj235KyQ7SY2JxSAFBLxfvZQ3pCjGqyMCVs5YQypcGx8nG3v/kePSUvF0NuX43CDbBEmVQa1boCZObOYm/VIs28GzzUAZIOjg+Gpho3rsCZH3Wy2n5IkepYOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF9B1USe3xW8JGjS6vwUwtFiylROVUZk4lEwhRnfJhk=;
 b=S4BPLBjwTmHxaPy2trTkuOa7RRjLzhQx2gUG5BnqVITUPYlpgsMgf7WVwFKKxHW7oZQSNqPVZ8pQJqyu2DwAmcMa+LJwB+2ptHutunQl6ardmSFv21Xm3o6nsCXzIAv/+mONuqJyF42lmuefazdGCxcLpJkSfyzAtiJ39sS4xMA=
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 21:44:20 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 21:44:20 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
	<logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>
CC: Leon Romanovsky <leon@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
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
Subject: Re: [PATCH v5 0/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Thread-Topic: [PATCH v5 0/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Thread-Index: AQHdcjam2A3Q4odg002rEagcyXnfx7c3iKlw
Date: Fri, 20 Nov 2026 21:44:20 +0000
Message-ID: <LV2PR11MB60707F72BFE00F5FF18CAD5AB2782@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
In-Reply-To: <20261111234439.4098-1-pavel.e.popov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|CH3PR11MB7940:EE_
x-ms-office365-filtering-correlation-id: 1b3037f4-7422-469e-11e5-08df474f6f30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: PGnN6SuFDv2HSzlnOayVGSJbcOKpVV61SyPTaZ2btV09G9HFJTzVhM/uJofIIjaV3tbvKsuTrOGR+UZc6whuxiDoi++hqdud0p+RKpdKAStqG5mFx1SZtAan7NwFoA8BLgD2+9H7ZJYmvb44ftyUQgE16EB6X5qp0G0EOQsHDHa+/lwtq9oA10QQvihj+c9As0zCa5gteJGm/Z2x6TNPlvQjPef3wCi5JX9VdtM3pQJh8BzleqKzXbXMGIKT2mHASkpckzgaiTnMcquv0y6FcEjnFRgRWefqlEiHdbXQivluY9eBKbpku+4MRZp4e2nEUm41/0QhTneVv1ijXyh3Xx5csumn91ypWFYe9MzOOF89lIN//Sr1k5M/X70UoSF06bvstaFxg4865TMIyNNgRvze96k7cm8u4KpE+T4RCuk784WFUln1IvYCX0gQI59uoAV2e7ajIdj4DnTjoy8i+XHDVYShvvKUjVTIqwHVYUdNbcQjfPpeJVys+WRrajhHCiYKB0V5LdGMX/4+g8RFRTafoQvNw8O2jKpjxmsRLe5SApqzTfirqDftQzfAqfy5s2r0Ym960tI07bQKxsRFbgbmoaOTLJ7vPqmMPzcJjlpwejETBSgRVrMEXMvTKnvcNMszQJU6RUp/KkbBTB+Mnu7hhhWq0r1bjtyDkcpKcXY/2yWtCJgd+d8i8WLHWVNg2WwM7EBdD9cRhMQNyonKyejJ16rv0pIp9sK6MXe/Wqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ivlybsIlDKZCJuqnOqLySu4+91MgInYJ+OG0GP/3a+t5FAETocdhi5I+vHE/?=
 =?us-ascii?Q?JgTZFPEKU1cf6Nag7ZHe/L7CIYUBavILheo4cfOodAtPFyzGyRgf70coKiE5?=
 =?us-ascii?Q?5otuTX2p4uMjtq23Hwn8/EQbs1wU4Z4RbHy+B0ZWrOn4zuoTTOgbN8p67ppy?=
 =?us-ascii?Q?nqVI+8vnP5h+Bb8We8UnUbJ5gJcwmWysFEtbJbXjnj8vlOlQ0DQ4RZsTYZLz?=
 =?us-ascii?Q?1HvUobPU4Jxbr9w57KJEa7+jMCUTvwflKgaIiFbgQLl1wZzNl9qx0hupL5h+?=
 =?us-ascii?Q?RDKCmrWk8ebEK+FoolH3uAs/RWrmm3tat45zOHoinnQUu3pdWwZ/Q5ut5JG2?=
 =?us-ascii?Q?6Y3JY3S4skhXXdHLPua4XrjLGaxbMW1D8e76bjFnGRN7xeUQOK2f2gKuS5cA?=
 =?us-ascii?Q?kdrB3/gKy3sLdOIcI5FryzYzpKNkh+U5Qd89PDPftMWeF/1z7fIQT1LowmfY?=
 =?us-ascii?Q?g5nDUDSgutIfO4pK/u9uttIMjaeoXdbgT8Uf5/tpy/7KZ6Bb52vz2D/YYXgO?=
 =?us-ascii?Q?XWbszSzjmY/kqh039ZXnEJPuM50UGO3lsIQSgKyTxfFbwECOsOcukJG55Gvc?=
 =?us-ascii?Q?7eepccTwiI1s3S6zGr42Uq21JHvwvCvq/cWu7xXmGgoBeeaQDq1PlkZmCCet?=
 =?us-ascii?Q?aiKLqYcXwaX3lCdyCmst6asfrK+fxK/0bWSAFhyzuqEZOZBQcnljEBRoWyNn?=
 =?us-ascii?Q?FbmWkHpO14AMgaARCq6Z1r4u59dApr6Quvt7MMu4cKjVs5AmVdbu0GvO5YrX?=
 =?us-ascii?Q?TeeM2bwsvidxonzf+/++ft7Kf2P4+xo/xhoBKIXB404BJljFyEWSe+46Xm5g?=
 =?us-ascii?Q?7f1kQ+Eheo9mJ1LQi55AB0BEsrmD2I10c4HNL+HXlbrlVWWjEsWN3r1359eM?=
 =?us-ascii?Q?cvNf7W+bOimd1fVC7IcnSf6XzC0pvcMgbtWxdSrkCOUetfDgYtGEHbNVbR2i?=
 =?us-ascii?Q?3airccIzyNvXHpKwz6vwuEBIKDf3zte/a4HDX4FLqLb5yDEKUUSwfzAbuKRk?=
 =?us-ascii?Q?GTLPEhgMYr41YFmfxlo+8vOaAG+kF+K5D8rYOux5SPPM5u5uBlqUdnxaNbwf?=
 =?us-ascii?Q?/2zF+MjUCO6CxYXF1H36QUkoBZwzzcTYGLVkl65eETp3cjvp+O3c+VmBXivK?=
 =?us-ascii?Q?Y42lXdKfQNIraFXWDR7E3equNo0XHcioIUBAQymMFgkkwEwdKFM2gsHlCNDI?=
 =?us-ascii?Q?droMajraV1UiitWZ7nnB9wVVUYuP3PSczg4aOTiDiBi5H0vbm6rD9vIidl5G?=
 =?us-ascii?Q?PODuhrSuD4Jb4yh82Ex7OFhIgdU+E1iL+ZH0TS+DkdYvIMXpQp15eDezX5oC?=
 =?us-ascii?Q?eTbNYGXfYc9VxJYuj02/ubLXN0lBpJ762KubaO0ZZT4UapcUfM7lmv+IAc1/?=
 =?us-ascii?Q?iCLjwvLOIaoDo+11F2chyc9nS0txGaSm0W92x8fWQpTlVCPK1lrUbK5ZGT5x?=
 =?us-ascii?Q?RYbCIs66L4wG+oUkzexce5c05GHBkKK1W6SLbFAbswGhQDJ1XUebGR94/URk?=
 =?us-ascii?Q?hBxRfCvB8xSR/zzDy7LKSUAKZ2VSb35LLw4M1dI2r39hgXIpOAyy2NTyxr0F?=
 =?us-ascii?Q?rTzZnbS5jtomg7x3T9rNjAETdQbxvpsaFlXUh81Yh2Ka4lkqALpdWg0RhN0u?=
 =?us-ascii?Q?1k7YWdMniJ4fIA8kO40f0+q6PJvJQ+nRDIGJqo+8v8Ne6DKXHmNPkOGywEac?=
 =?us-ascii?Q?GB6nYN97Y+fl6n/4IDnEt66pMLCXy+qTiyPl0sgkxL3phhSqNHTPdykgSsq5?=
 =?us-ascii?Q?6e2cwvN1/w=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: flJiGWZPGV4DQKza1Oty2c2Za9IyvM3PDl/CNE/zhyPBXE2G1GtEcXoZWATGpcUDqdgmRRZovsAZj2+opag8FQ8OiQpiRspaV9TKog+u1f5IcU/lpltW9Prm/YY5F+6AnYKiE5HbLYESfDUyw4U2NuOGIm4vSYX9GAajjMDmFZyJkd5BW/PVoLpcByTwegz1Wu+h/ScQlLB5LxkC2N27zs6h19mA9wEa0R++OeIALkgw56MF8oxIt7VB4G7agg1FAzPbByUNTcQQNUD68MxTj5Dyw6VY/1ORsEJ2Z+FryK4yIvbCgxTm3h+wQOaIzKs0zXIJQzmkXpSOuL9sUtK/9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3037f4-7422-469e-11e5-08df474f6f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 21:44:20.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMTCkMYEvMVM2C3+NKQbeqvrwIRn2k/oouQDJz6Jq0WD/DRyTCeea60fh/pMvT2h8JyHh4bRD+DMLgVIMKvduQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
X-OriginatorOrg: intel.com

Hi Bjorn,

A gentle reminder about this series. All three patches are reviewed by
Logan, 1/3 and 2/3 also by Leon, and 1/3 has Arnd's ack and Sohil's
review.

It applies on pci/next as is. 2/3 and 3/3 have context conflicts with
pci/p2pdma. I can send a rebased version if you want it on top of that
branch.

Is anything else needed to get it queued?

Thanks,
Pavel
