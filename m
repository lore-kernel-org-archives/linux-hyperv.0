Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8B3C09FB;
	Fri,  9 Oct 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573222; cv=fail; b=uUDMxEwL+zHFOlyDi6+sIWqParU3caJiUcZZdv5939p97ATBVkqm0nVfoC+wSMvzSgCxQNVIVtlLuXrh/hk7Vht04KajD5APjIMQt6XnOGCH9KmBKQk3xKpPeO52OKFQgLJfBSiiBjQ94eXUDnqInp/NF1H2Q5WHh/TKzbxMm1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573222; c=relaxed/simple;
	bh=HCqHwmygKIxDjCi5aFimWAubMgvua4PLaas5pmdi6N8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b9F8eLC1AyOrUyM/w5QGAUXNGA6xkJ6rvW/mFxmaF9RTbRIIoP0TLvuhudHhBgVMX5Szx2xEqDIPFXYnJbCyd7326/lCpR+kHL0Kcd7exAIBu03vkk6e6JJLnJtok3YahKmCwIBMwfwIXJ+E4SqevI863u7EIPw4AH4XfwJJ8Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBDmYgM9; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBDmYgM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791573220; x=1823109220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HCqHwmygKIxDjCi5aFimWAubMgvua4PLaas5pmdi6N8=;
  b=mBDmYgM94kTXU5e13cTqcQR1s5ypIQO16z3/NnisHs8USduIST3wi75T
   XxcQxyGxroNH5oLB3dtH730RQ5b7MwsOAJ0ZY2I01o9UqcnqbtQMfzw6z
   HpS8dtKh/pP/mZM0zuuGtbjSps2cDjeq/kTcCEZAwmJbdSQ8RG5Ilek6v
   sKi7YRpbg6lteG8OiRTSlfdQoo1rFZGO4K2khaeyAjA3sy0q0ZdsVU6/5
   dCjxndzk4A6Y1jPK21Fu3Mk9aSb5mGtpOS0DCBCt+9ZbPSJ8ttkVoZz9O
   db/Kl9vWbrmdsyF2dulDQu+TK49Zr5eeaMBFdtcLZGJSCv//LqMQacbXh
   Q==;
X-CSE-ConnectionGUID: MY/KQH/3TeepfoLvjPt/1A==
X-CSE-MsgGUID: Bc2UGNvSRPq5a6scvHhIDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="474983"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="474983"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:13:40 -0700
X-CSE-ConnectionGUID: 03pxQFtGSGKHJvlvble6/Q==
X-CSE-MsgGUID: EmxLonHUQRirhBGIRB26rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="361560"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:13:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:13:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 12:13:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:13:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxhvC5JI9TANHFTsCOC61vCrba1tNvENEu9CagOVCS37r9Azj581fhmdH0r7dGIRdRJNg3zWdEgJTVVyjCOzs8oL1F7PiRXKdAL4pcioYOddPHMR4eY7D+8YslCtBKwX4vbjcIDB/QR6KzX2lyAUYSQGYPDTJre7aRPeoA5wR16zOiXWCoF9B5VyPOFT1aOja0//MnUABUks6mhnVTHFC1II2nyD6JVeWC8TR78PnE/UrHlCTryqAsJ2i4+EroU06hGXnJ65FNxq2L/eB2LRt58FuoH//FslQkdxnJIudBIDLHTwKMgGFy+t9ePTImayvbCJGXPw7Q1IG/WxiGlJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCqHwmygKIxDjCi5aFimWAubMgvua4PLaas5pmdi6N8=;
 b=vSBJ6Ece4pvG7ktG2IOOgjJW+eqzxsXHe00cWSA+SMdphyK3FR3fI84BcEHhaPvSXePfPQS4m4PD+Qyg4zRqGJoAjnB/M6Nke4Wz9kM8zSpLd1pcErFM2H7TCDoOPUVnvXAAc59VVWKAaIGkzr50ThVCBgljgKyD9f5Lt1ma6MF0Cln5BSBVfQQecGm1MLSBZnuJR/l0juHiu2ojTFBdqs9dgdKYotXb3EGZ9krRzaazk+zF4LkRErinqWsdNP4AHrHACECbgA2gPjHvOHYjs+7RZKO5B0047FdHWTLW6N3vm05zeE6Z8p4SrZwkWTv+D/iiCiHJTYlUpdg5625zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by CH0PR11MB5282.namprd11.prod.outlook.com (2603:10b6:610:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 19:13:31 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:13:31 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Jim
 Chow <jim.chow@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>
CC: Radu Rugina <radu.rugina@broadcom.com>, Alexey Makhalov
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
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iA=
Date: Fri, 9 Oct 2026 19:13:31 +0000
Message-ID: <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas> <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
In-Reply-To: <20261009184923.GE11438@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|CH0PR11MB5282:EE_
x-ms-office365-filtering-correlation-id: 594f8989-a266-410f-8df0-08df26396818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|11063799006|38070700021|4143699003|56012099006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: k788Xtc3PmXFpjxHr0jl6f9zqdH3DdGefwnIYE7ao3IFDhZZ1vAo49yjboj/cp8fe2dtm90YX50yJ7UZHs7O1SuLDbS6hSZfdD0/487/+KjlbXZTj8f50h4fw8fkD+4/7JyJtmXGHjpUPS+5qi9bhNWk7D//usK8Gz3YqHgF5vbk73Cw2NKcIhvK96AmU3OnUGdN13cToHzdJX2Wq6EDBGg8Qv/Vpn01jTwB25sfKNRM9WqASChYaMee8cnY4AAe0obQysbRzzvY/4OXk9v4gAQB7WwL5a3MGoARmv3wY0DinMAeMkgkqkxE8n+PTA2hNJ01apOT5JKxAD2/eZ5ja8KagffSZ2QPKwvq1Bmff871aQ5ijhsaQsgTQCOO6CMyO56YOBa4vb1cJPYf0d8wu86JwcWcsFNQ6Z+QvAz+ifSZNPyk7txFqmyFXyR/rZFL3q+rZ1FBuc3wF6PwcMhsefIskqgFim/ugeQfpNnjeJ0F15mEpNxGKH6GysQRUJRVRYYZxE0crdz//zkrAqXhB8oSijLkT5o/O39Ex5imsKcqQOLkUDWRYkV6iRmUrg24GjLfMC8fcuG1eVDzQfcao7QEzxRwr4AHdXWkc8V2RdD+74xitp0HpjspxABABGXYvq8vDUWBrSz3E7UeqrYaxeYz4mhkRUN0ZCBF7UyQQgQAjfCu5ZLLU0y5dNpH3oBd8RhVTisnmkClWh2rIDjFH8ZSn2CfBNZ88qPfJpuiV9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(11063799006)(38070700021)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AB7GcuUxcveYvCgF6LQ/VmNhoLh/o4tQBzDZxe3JRwwuVHdvuny6xJQtGqVi?=
 =?us-ascii?Q?dQF6bbxoGduoRRqAbvUnYWl6L96gzVR1hNn9iKabKrCiELefHt27yOoeRbbd?=
 =?us-ascii?Q?Gz0SBytzWE4OguDEKDw4MkFggFsbNCOs8mXxgQ5E0acMYOzJZDMhtp+V/x9l?=
 =?us-ascii?Q?gULPs+q+iYNNEMsBLwc17THq4KWa3Z84OQmaqAmxIN4SCLw1irFO0yum88kN?=
 =?us-ascii?Q?zwOgBTSYZ+ofZndM1Ye3b7Poyzaj6Jn+9NcRW8AgDKF0qZglBRX071HcixPC?=
 =?us-ascii?Q?t+gR17WcnS/IEm5S16eSr0XjMIUUlGBkF9KPAvmNsoerZniUkx8V/tvN3knE?=
 =?us-ascii?Q?laN7PakXHiXqf+a5K3qIrI3XGYAeQhyRh7NElyLiUUjC/iJqTNHg2L4FPvEM?=
 =?us-ascii?Q?061uQTdvbd2CfTcZp6e0h3n8ORySshPQcd9bnVss4fuP36/P1GtpjYPiHZKG?=
 =?us-ascii?Q?9Vh5Dlz+YhueyQZDXVFlXUiNTMe+33zhwo2VNxpkP4ZPMY/doWDl+tKCUJR+?=
 =?us-ascii?Q?g6RLhHmh/wfr46/9wmsvw9iVNmIs5g/t1xY8nr45BY92wdKz7+cEBEcNmDsP?=
 =?us-ascii?Q?p+gAtUe7igyf/8M8bZMds2nUa6UIBL9K6x/y9mB8MzR0TJ3+DgiYGAiTPr6u?=
 =?us-ascii?Q?ZGWZKNQRKAtVDbrz4gwTA3KkHfic9HEs/sAvokYeYYR8yiyPjH13IZI79hx2?=
 =?us-ascii?Q?/uAS7EXwl8K0O9WVbwpiMEk6tCO4n4bbPjZZEeJyNXaPmRGvmAz2Vfx/bnFf?=
 =?us-ascii?Q?7JxNFNDk2RQKSqamsjE35eZ+TL3IfHY9eM1VAhrRjij52Hj6BliTnVKJazpx?=
 =?us-ascii?Q?TQUmgrU0GNhL/4Ks7EhiwQJl70Rees5WntAljGYhpF46X1jMbYZC5LLwjc8U?=
 =?us-ascii?Q?CJCoeRt3v9jb5gByy9CyIKUdIz47wy5XPCV0glESus0iL/6bTG2Np/TGkSaB?=
 =?us-ascii?Q?BCHsalDnxmU8QLAyg5rLYBhYSRErp3U6FWDy8UHoLbaEI57unxVGMHWI/n0a?=
 =?us-ascii?Q?lfKBR6YyKMh2J7ZyL6gqL88rd0o2qT7JKR235S/yJeLhrZ2yXYT7tfGqOQ0K?=
 =?us-ascii?Q?cN5FPmXvFMrzh8Behn9+Mcr3KsySDgz+qTi58bXubU+HE1r6IYK+aZlW5smI?=
 =?us-ascii?Q?YzPmpYs2jylF8Tm5pWcR7Gy1N0a7q8Z3ERifWEArAihYHyMQAs1xh3x/aPEF?=
 =?us-ascii?Q?ni8Zj3+KhNxDDGTViFA0obt1kSO81cBds/Bb/+UF67p2z3APugn8Aw7kPYEw?=
 =?us-ascii?Q?RrP24lBV/bt1jVD8Zw19tSednNTWzakXSRogpGbTVuMCJAhKFRBrfPyT1ohK?=
 =?us-ascii?Q?tX23qG0CSFbUyCJcQLkjjTGhIWzgLay3zdMkYFVJt141pQ/2wFCm+tDyfi0v?=
 =?us-ascii?Q?WfsYSDntIlub4XmneE1NXyz4Pzx0ifkR/h/7bvq1LPHS2G21AHG4p4klbZds?=
 =?us-ascii?Q?CVdAHdS6gJbSG+atAH5uQIsgNoB1FmIzPk/f1oxTnQ1o8NxlokeiRZmAdHGi?=
 =?us-ascii?Q?3ZO2aCPhq2eVQs0moLy2k2TnUNTeBdJqCk9YWEFkdFKIPQ9s4uVLMXROll8A?=
 =?us-ascii?Q?nSjSX4Tvj028HVgDLud8UeLO3LxZet0KPKo9yaJl9lxUO+Tar6h/bFt8nqBG?=
 =?us-ascii?Q?BruSbdbJQ5ldemSAJFMrsMhULV69I55iHoiMSd5TbjVijxpHOmIqXWLL2nsa?=
 =?us-ascii?Q?4ZAHr8MoWFrhCDujIeGxNygxr0bjcvduIEiDPBRY+OtD7Sgrx6qQzyDsXOLx?=
 =?us-ascii?Q?o8zzJjrrow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pswVS0ehIHQ+CJ00iNaoY0dzI52QRgKuSCL7gzIImKHYh5j04wE4i7G2bx2jrbOV24vv44O4j40twrNvXsQS42s6r684bR+PDIJe98iRBzvXNfo+5KzuJaPjY8lmLT+1R6NSnqioUwv9SRrqwX6XgL6scV79dIK+b1cGr1dxr+jOkX/RInsg59qP5SoolPlzm3rTgkQBAGEes7fvYAy/Ozbh+897SQylOlda8umRrPl/nP51sURVjYwhVBtOauqzM/ouiTTcUvOvxmGh5EHg2yGCCdOd5ceLqiEHsNOcjIJxreARekpZjwT5Oo+LVUvvpJ+bOdHNiQVTTOWNY7WmSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594f8989-a266-410f-8df0-08df26396818
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 19:13:31.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0Qysd8R+ZmKBf7WfKy5X6oVuYm2+jiXT3JaS8g0eNnlPaf994HsPrTvYIapxLteX8KLjdVWgwqhtULGEUoSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5282
X-OriginatorOrg: intel.com

Leon,

Understood on all points, and I agree HMAT is the proper fix. We discussed
it with Lukas Wunner as well. Exposing HMAT is on the hypervisor side; Jim
Chow from VMware can speak to their plans. Even once HMAT lands in Linux,
it only helps guests after the hypervisors add support for it.

The key point for us is that today there is no path at all for
passthrough devices on VMware or Hyper-V, and that is what this patch
addresses. We reviewed it with VMware and aligned on this approach for the
guest in the meantime.

Is there anything you would recommend to make the series acceptable as an
interim? Bjorn, Logan, your view would help here as well.
