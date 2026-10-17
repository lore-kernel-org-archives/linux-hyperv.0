Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A41DF748;
	Sat, 17 Oct 2026 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197123; cv=fail; b=JJvokUCyoy11hqa2EL8N4SgDba86N1unexulOwgqR6/sc2jNWi0QV2prW6ZTNola6MoHI5XoN706Jk6yCGsPjsntYoq87Nh1/cn4bIT/nVdGg8obyfNpmHST96ZEgj8w3offWpdXEfybGJtKZj9yCfFTmyAdTxKn/wQ9Sj4mT9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197123; c=relaxed/simple;
	bh=acTQkJrYn1u9ukKtuGDQYLzzSm8p7pBLt+TBwgm/4DQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F2bbFwmQ88PNr4I7RfUEMsypjJmorzjP423tjY7UyC3KqQLxFM93rCXm1NP4/w+sDModGydJUlDQniQThlio7FqtsmIr+qCEo01uDMOxgRYEk68N6U20qoiheVHKWwDGvYaDcuLuc8VPMLJWtEKyPHO7I59qfcaqeyAxWKIpj34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTAv/9hp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTAv/9hp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792197121; x=1823733121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=acTQkJrYn1u9ukKtuGDQYLzzSm8p7pBLt+TBwgm/4DQ=;
  b=UTAv/9hpWJE5XUIog4ZKjqa0DZEYRXRCa8xVQOK/deE3zy2X/OhKJaam
   7mOiIUF9yXbnLfkk3mLv/15T8kVZnwOaVe204HlSvYu6vpScqQeAmbVZS
   cg219L3EyPEz7rGPN5ugE09aWNXAlE3cpzCteSWmbzpRe3cIT2bYO45Au
   I1rGb4AZwhliuEysRGXqUkj9Ck8szFOf6a4Ag7diW53gfp9LehKoaCLx+
   fbxYsD5k0Dyn5h6NOOOxV9yzQWSdvUo7Wc0Hd6Fohox7dEx/cITwR1M8G
   mimcrsbUfRGVIFlKwK9MfSsS8sdsuBC5z2mShcv02C3e0kZEp/pbT0wWw
   g==;
X-CSE-ConnectionGUID: GUdgGIRZSu6yqYExgkP5tg==
X-CSE-MsgGUID: wHJjxzXCQZSVCRcpk33Abg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="996103"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="996103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:32:00 -0700
X-CSE-ConnectionGUID: BqxY1RyMTiGEt3IfaRZy5A==
X-CSE-MsgGUID: B9+iyMkKTpCOMB5xdXtRCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1949843"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:32:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:31:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 17:31:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIblRw2BN7zr0F3veTApBLCI6Qtbwh0OFZcQYV694e8ZqMBUPR/HgHr0+JEDoB0kayyE/DuTDwrpMj/0qgPhDBqmSuMJ+6iJ5nP4YDM5PQHxkUlUVwsuNzKH1WRhhiM75JQlRaUr4ax+b5YLe/ML77Mv8wTH0b6NR3I0hE+F4UTBbkPtvafnuOdbAwImwYBBdtKlDDp2fXwWxrhKwf4n0T/3w5dZ4lJ4ljcCFxK7dBfrSOQTKcLKJoUEFVOpQmq8gAxveyX5QvnWc2ooaTIO2I6VIIZz5ASWPvSdcG8qvE0PdVDhO81wjBWM0S8yTt2YYPGGf8Sh83x3vzhOJjIhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acTQkJrYn1u9ukKtuGDQYLzzSm8p7pBLt+TBwgm/4DQ=;
 b=wG/KH8XxZ5RofdFLo2L9H2Rb+ee582jToVJKFSKnxUBxb5wECnZxAaCrg79MSklyMVpJ1ITJPd5H7iyeNoCj93mg3t+yrGdiYNZiSBY4rcqx7jZ/ZuopNYJ4eiqATOZDNy6TkkE3qcDkdEuFSeHrAEaFHeOSfAjGDC1Jg7u4ZDPDH3Ivwciz5tNegn10Go7gegLswIZTcrtrxgAVM49Bq3Luoy8Ixhp4mdgaK5qfaOTLhsYH5CvDjwguI2cT1+g7c6mWNk5MR61PqqZwbS6lUZNU64BhQ8w095vTtt3Z355OAyFOk3eoRUWu9tVEkdzFW8TC85YCyNsxcBZT4Wbu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by PH3PPF67C992ECC.namprd11.prod.outlook.com (2603:10b6:518:1::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Sat, 17 Oct
 2026 00:31:49 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0522.016; Sat, 17 Oct 2026
 00:31:49 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, Lukas Wunner <lukas@wunner.de>, "Leon
 Romanovsky" <leonro@nvidia.com>, Nathan Ciobanu
	<nathan.d.ciobanu@linux.intel.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
Thread-Topic: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on
 Intel hosts
Thread-Index: AQHdXb56kLC8GFOklEy8u/njCKgpc7cAx1kAgAAZpWA=
Date: Sat, 17 Oct 2026 00:31:49 +0000
Message-ID: <LV2PR11MB6070CE9CCA125C290C0F8209B29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
 <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
In-Reply-To: <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|PH3PPF67C992ECC:EE_
x-ms-office365-filtering-correlation-id: 02866a40-208e-4f03-9597-08df2be60883
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|38070700021|56012099006|11063799006|4143699003|10067099003|261009223027099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: UE/AOKv1L5nxMsRRDigz/W4ZnqsSy+ExqY30D4eHkeHP12u9/6anDWXI9oP59G0TskOLXb5zRntnfkdX54QWgozJ+LJJmY6A9UCI3xOyXRCz9rMGYhfUOH66MCPFf+sFJeYuCxlF09Zt9h5gGwmpZDYl6QtzI1QQ621nfTMsxzAYGNvsVfCNXmR3jjZ9Bzyh/hZ+a51eUdOJi7d7LsykZn6JC+HYAIrH7hh9jlzg5l4RTxRMxZ7MkKHYXsVYn6URFTWlIp6FtZui4myZQhI3l3k7doqEEZlXZsrjRfdClVcNOQSAZrRCLwA66DQZ1HRhv7bzWWlqpUhL8KKva/68Jx5AZ+eWf3xcXT9Ig6exy3UX+KEXUtVBWBo2Edi+X8oXAkXpLlt2+lzUXL1K0ochgTD/llSTi35Q/SRJ+VobU7YkuMrlR37rWqDN4RWbpFAzEChlWI6mCmXYxCWSPPxOjtX4xur8Lsw5q6t+2TjZm0sNwkEM3hd9cePKI222y/DqT6oTv4Mf1xNXL82X5P5w3nxJxtq2pn/3PCrk6s06A/w+ejm1vsPLOqUUEJYEHKXY2pb88OccaPV/q66jAqmLobP7/GBtOHIiSZZobHWyu0V85lVijXfQjuP6wMHd6JQR/IyXmfu2gg4eIpSz7sfkZlJJRI+FkRlonLlAiHHU8kMHYFpH8DkjKYp+hKdV25N7kbpHIwAIEdqaXC9xGonQRES5kGukH8V61LxOmBXawzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVJtU3B1Q0JvcWY1dWppZUREdlE3VURiQ0NCTWNYb2MzNmtmaWpId0ZvQzE4?=
 =?utf-8?B?eURENVorbi96NlpaTWF5TEx5K3lZM2ZYeUI4SmNwMWI1em1EV1pLWXYwT0Uz?=
 =?utf-8?B?WGZQc2hWZ1hkeWxjNTk3T1gvcVlqU0o1RGlGdlBRblBneHdRaDdsajFEb3lM?=
 =?utf-8?B?NlZSeGpETUdJc09WR2duWmJraE5DTzNDRDQ3U0ovbktYdTVITWIrSUV6UVgy?=
 =?utf-8?B?OFlzMUtzSG5TUE5LRGF3NDQ1MzJkVXpNbjBnSmFyUGhSZnUrMCsxWVhBRFF3?=
 =?utf-8?B?UGFURkdQN0NvbnVnQWpCUjRoSUtWRkNCbkJLVytFWFJ6Nit5Y0F2MmkzVG5z?=
 =?utf-8?B?WWRHK1cwS3g2QnRRNkp4bmJreUY1TVc5Vy9od0gwSE9BQTd2WWJYN3NwcFRJ?=
 =?utf-8?B?SkJLNi9TaHZ2S0dkaENZRTVtMjYxYnBMUUpVc01wVkdQY3d6Y2t6dG04WDhv?=
 =?utf-8?B?a3NlWWR1dU4yRk5BQUwvYUxobWRwbEVsMDVRWFZMRFdzVi9MdjB6WkR5bHQr?=
 =?utf-8?B?eUg2MUM3YjZRVjUrbFJvTGhYUm5mbXhsRGxTT2ppSkhoaHRaKzR5SFgvcXJJ?=
 =?utf-8?B?UVIwbGtNSkE0S1htaEE3V0xsaUdSb25xa1JIQnBVakg2MXNjdWpwdTBVMGpj?=
 =?utf-8?B?NGh5T1lsRmVIeFhmcXZEY08xVTFoN3N1a1h1RUdUUXR1QmcwUGdZVjlVRCtW?=
 =?utf-8?B?Z211SVNjTEdXVHFFQ2U1Y25UNGVibnFiWmlRM3VvbFJ4a3QwbWJ5eVI4VFFa?=
 =?utf-8?B?UnM4MUJEaVJ6ZXpnaFQraloxamdaOGxrNUVyTkN5Ni9kZEdLU3RLMmRiWjFL?=
 =?utf-8?B?WXNrL1BLTlRRcHVoUUVwTEZzWVdPWjJFNExjSVNoS2RML2xhd0M3U2JVb0hw?=
 =?utf-8?B?VGRNbzZuR2tGYkJ3cWxkWDZNYTFyaGJxMzVlcVNFOVBSSXlTQVdFYVV2dTRy?=
 =?utf-8?B?MHVRTG1jamJhdDF4OGNzaThQZGFzUU5xN3JBN1BEbEJPT0FzNGV5d1JhRGFU?=
 =?utf-8?B?WWh6L0RnamtaWFh1V0N1N2Vod3h2ZkdoREM3MDFndWQ1UjRYRzZlY1dxdmZX?=
 =?utf-8?B?UU5NSjNnUjcrVVMzVG12dFU3SjZOQmJabzFVWHFoSW80UjZLYktYVndNalc3?=
 =?utf-8?B?L1J4OUh0Z096c29SR2FiNUpLQS9JZ3lFNmxEQlZJYVg1cC9BTnBPK3V3bEI5?=
 =?utf-8?B?MkRXaEVNWWc4VnVPRkkwR3p4d1hxSFZ5c1pSbHhVQmxPS0lDWXRON05sQmk1?=
 =?utf-8?B?ejkrL09QNE9CRmdJRS8xeG1aYis3Kyt4R0xsL1FGUW5QMlZ4SThPVjJVc1lu?=
 =?utf-8?B?dlBQTHdUTStDVkFYWnRtNGhqWDNaVGxXYytJQXhPN0JzUjJqcXd5TmFMckZE?=
 =?utf-8?B?UE05cUNITlhQTWo5SEtjK09QemRXSTdITUVoelhpdHlMSHAzQlV5Mk56cXha?=
 =?utf-8?B?d3RqVDRMczhoaVhVaDJHeEI0UEUrajZ2UlM0ZS9GdFdpcjRsSE5ZSVJoN0Y2?=
 =?utf-8?B?cHNjcW1XSW82SHhienhpVGtINitPSDZrTFF5MElLMURUNitTdDQvL05taEg3?=
 =?utf-8?B?ZTlBTGx0Y2xRQTArUXpRVkJCTlY1bHBMMjFTWkhHL3NOeE9GQStZakt4TE5N?=
 =?utf-8?B?aVRZUXMwMHhoWENiOUl6dmJIcm1sZ0xJTEpOQXU0bEhKLy9ISnRMOGVneTFY?=
 =?utf-8?B?VG5vaTlPeThEZ2RIZXgvaGJlWW00SW50Zm1Pd1RqcFlaMTYxWitYSUxCQU5M?=
 =?utf-8?B?UzRIdTlMcE82QkdLK1JCck1aZlVxNzVPUU1UQU93c0wvMHpPNW5meFozUkNC?=
 =?utf-8?B?a21XL000ajliQS9rMU43V2VIT1hyVkZXNGkvSmxTdS9xNStud09EQVNvbFJi?=
 =?utf-8?B?UkludUFveUgxT0ZteXo2MTI3VTQ0dFJNUVZoaFNrZEdyYktTUEF0WW01MHZr?=
 =?utf-8?B?SjFOMkdKamwzdVppT0ZRbTllWHVHR1JRRERwMmpOWjBGNGVhWUJ6eTNjM3VH?=
 =?utf-8?B?K2JmdzdLK1F2ZUtWcks0OEozUXJyS0Y2OWJwWHRvNGtsODJrTXFiWU1lakVP?=
 =?utf-8?B?NE42SWNIdGhGT2RHTFA5dWNEemEwajlaT2tSSk1nSms2ZWVGRGJZcENPRkZ2?=
 =?utf-8?B?MUJjdzY2SVVCOCt1V1ZYZlpYd3p3d3piYWo1eXplOXFNSSs2a2dwMjYyZEdT?=
 =?utf-8?B?NDVKaExvQjVHZURmbGVyNkVBcmR3ZWd6LzVyUDR3K21IeXpkSlNoSDBXU0tp?=
 =?utf-8?B?aExnYTV6V0pGTml3TzFBVkl6ZlF0cGdjRmlDOFA0SlNHSHdvRVh1R25CWFln?=
 =?utf-8?B?TzE4MS9Yc3YxUFEvcXdSMG5yNFQxNWZWdVlkVVhzTlVVZVJKU1o1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QG57dx8gFORS5afjsKyAFyQeTws5TGL1uWeT1QBqUKmJOH1po1WT67v6bAtJvui+iQK6myR2diV6W3MnniMGEQP85DWcaGEcRxlEqtjAoTyizs+SJLK5btroGNWkuFdS3rRP9V85EKjFW3kj7ksl8gzQyftyFJa8go5rXQ4spbA0pVtHt4fqDq9PCSwvW43A8r18R2gDn+9wJx93ZmGBwSOuHi4EDpcb+xei43F2jtbIPAPEGTmPstavHwsyNL2JIOOOE+AyO68rzv+qZ3BVnimWxBr5uv+eQhTxO4VnfgYRYdQupIAe4A+ZziO2OHwwMV72x7ZSxAlFIfCAmQBGag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02866a40-208e-4f03-9597-08df2be60883
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 00:31:49.5164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uy0GvUAsKJXDWaiR3mtQZBoPoFe3CKz0VXI7+czWYRvH04AV9V5fElaTCXkIgeCt8B6/VUDKZCVVExx6WVt40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67C992ECC
X-OriginatorOrg: intel.com

TG9nYW4sDQoNCj4gV2h5IGRvZXMgdGhpcyBub3cgbmVlZCB0byBiZSByZWxhdGVkIHRvIHRoZSBo
eXBlcnZpc29yPyBXb3VsZG4ndCBpdA0KPiBtYWtlIHNlbnNlIHRvIGRvIHRoaXMgY2hlY2sgcmVn
YXJkbGVzcyBvZiB3aGV0aGVyIFZNd2FyZSBpcyBpbnZvbHZlZD8NCg0KVGhlIHdoaXRlbGlzdCBk
ZWNpZGVzIHBlciBob3N0IGJyaWRnZSwgYW5kIGEgZ2xvYmFsIENQVSBjaGVjayB3b3VsZA0Kb3Zl
cnJpZGUgaXQgb24gdGhlc2UgQ1BVcywgZm9yIGV4YW1wbGU6DQoNCi0gSXQgYWxsb3dzIFZNRCBk
b21haW5zLCBDWEwgMS4xIGRldmljZXMgYW5kIG90aGVyIFJDaUVQcywgd2hpY2ggYXJlDQogIG5v
dCB3aGl0ZWxpc3RlZC4NCi0gSXQgb3ZlcnJpZGVzIHRoZSBlbXVsYXRlZCB0b3BvbG9neSBpbiBL
Vk0vUUVNVSBndWVzdHMsIHdoaWNoIGFscmVhZHkNCiAgZGVjaWRlcyBQMlAgdGhlcmUuDQotIEl0
IG1ha2VzIHRoZSBleGlzdGluZyBRQVQsIERTQSBhbmQgSUFBIHdoaXRlbGlzdCBlbnRyaWVzIHBv
aW50bGVzcywNCiAgc2luY2UgYW55IFJDaUVQIHdvdWxkIGJlIGFsbG93ZWQuDQoNCkxpbWl0aW5n
IGl0IHRvIHRoZSBoeXBlcnZpc29yIGtlZXBzIHRoZSB3aGl0ZWxpc3QgbG9naWMgdW5jaGFuZ2Vk
IG9uDQpiYXJlIG1ldGFsIGFuZCBpbiBvdGhlciBndWVzdHMuDQoNClRoYW5rcywNClBhdmVsDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9nYW4gR3VudGhvcnBlIDxs
b2dhbmdAZGVsdGF0ZWUuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMTYsIDIwMjYgMzo1
NSBQTQ0KPiBUbzogUG9wb3YsIFBhdmVsIEUgPHBhdmVsLmUucG9wb3ZAaW50ZWwuY29tPjsgQmpv
cm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gQ2M6IEppbSBDaG93IDxqaW0u
Y2hvd0Bicm9hZGNvbS5jb20+OyBSYWR1IFJ1Z2luYQ0KPiA8cmFkdS5ydWdpbmFAYnJvYWRjb20u
Y29tPjsgQWxleGV5IE1ha2hhbG92DQo+IDxhbGV4ZXkubWFraGFsb3ZAYnJvYWRjb20uY29tPjsg
V2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPjsgTWljaGFlbA0KPiBLZWxsZXkgPG1oa2xpbnV4
QG91dGxvb2suY29tPjsgTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+OyBMZW9uDQo+IFJv
bWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPjsgTmF0aGFuIENpb2JhbnUNCj4gPG5hdGhhbi5k
LmNpb2JhbnVAbGludXguaW50ZWwuY29tPjsgYmNtLWtlcm5lbC1mZWVkYmFjay0NCj4gbGlzdEBi
cm9hZGNvbS5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldjsgbGludXgtDQo+IGh5
cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBQ
Q0kvUDJQRE1BOiBBbGxvdyBQMlBETUEgaW4gVk13YXJlIGd1ZXN0cw0KPiBvbiBJbnRlbCBob3N0
cw0KPiANCj4gDQo+IA0KPiBPbiAyMDI2LTEwLTE2IDE2OjM0LCBQYXZlbCBQb3BvdiB3cm90ZToN
Cj4gPiArI2lmZGVmIENPTkZJR19YODYNCj4gPiArLyogQ1BVcyB3aG9zZSBob3N0IGJyaWRnZXMg
c3VwcG9ydCBwMnBkbWEsIHNlZSBwY2lfcDJwZG1hX3doaXRlbGlzdFtdDQo+ID4gKyovIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgeDg2X2NwdV9pZCBoeXBlcnZpc29yX3AycGRtYV9jcHVfaWRzW10gPSB7
DQo+ID4gKwlYODZfTUFUQ0hfVkZNKElOVEVMX1NLWUxBS0VfWCwgTlVMTCksDQo+ID4gKwlYODZf
TUFUQ0hfVkZNKElOVEVMX0lDRUxBS0VfWCwgTlVMTCksDQo+ID4gKwlYODZfTUFUQ0hfVkZNKElO
VEVMX0lDRUxBS0VfRCwgTlVMTCksDQo+ID4gKwlYODZfTUFUQ0hfVkZNKElOVEVMX1NBUFBISVJF
UkFQSURTX1gsIE5VTEwpLA0KPiA+ICsJWDg2X01BVENIX1ZGTShJTlRFTF9FTUVSQUxEUkFQSURT
X1gsIE5VTEwpLA0KPiA+ICsJWDg2X01BVENIX1ZGTShJTlRFTF9HUkFOSVRFUkFQSURTX1gsIE5V
TEwpLA0KPiA+ICsJWDg2X01BVENIX1ZGTShJTlRFTF9HUkFOSVRFUkFQSURTX0QsIE5VTEwpLA0K
PiA+ICsJWDg2X01BVENIX1ZGTShJTlRFTF9BVE9NX0NSRVNUTU9OVF9YLCBOVUxMKSwNCj4gPiAr
CVg4Nl9NQVRDSF9WRk0oSU5URUxfQVRPTV9EQVJLTU9OVF9YLCBOVUxMKSwNCj4gPiArCVg4Nl9N
QVRDSF9WRk0oSU5URUxfRElBTU9ORFJBUElEU19YLCBOVUxMKSwNCj4gPiArCXt9DQo+ID4gK307
DQo+ID4gKw0KPiA+ICtzdGF0aWMgYm9vbCBoeXBlcnZpc29yX3N1cHBvcnRzX3AycGRtYSh2b2lk
KSB7DQo+ID4gKwkvKiBIeXBlcnZpc29yIGhpZGVzIGhvc3QgdG9wb2xvZ3ksIGFsbG93IHAycGRt
YSBvbiB3aGl0ZWxpc3RlZCBDUFVzDQo+ICovDQo+ID4gKwlpZiAoaHlwZXJ2aXNvcl9pc190eXBl
KFg4Nl9IWVBFUl9WTVdBUkUpKQ0KPiA+ICsJCXJldHVybiB4ODZfbWF0Y2hfY3B1KGh5cGVydmlz
b3JfcDJwZG1hX2NwdV9pZHMpOw0KPiA+ICsNCj4gPiArCXJldHVybiBmYWxzZTsNCj4gPiArfQ0K
PiBPbmUgcXVpY2sgdGhvdWdodCwgYWZ0ZXIgYSB2ZXJ5IHF1aWNrIHBhc3MgYXQgdGhpczoNCj4g
DQo+IFdoeSBkb2VzIHRoaXMgbm93IG5lZWQgdG8gYmUgcmVsYXRlZCB0byB0aGUgaHlwZXJ2aXNv
cj8gV291bGRuJ3QgaXQgbWFrZQ0KPiBzZW5zZSB0byBkbyB0aGlzIGNoZWNrIHJlZ2FyZGxlc3Mg
b2Ygd2hldGhlciBWTVdhcmUgaXMgaW52b2x2ZWQ/DQo+IA0KPiBMb2dhbg0K
