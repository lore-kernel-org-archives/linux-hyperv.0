Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E235A3B1;
	Sat, 17 Oct 2026 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250471; cv=fail; b=CeEgxhXi6HlIBuFN6S4R7ORDlkYM6Q2/NVDbmD391wCLjcALSyBxAJy9ZSHXIhkSo80/J4z/tuujv9c1IVCmSUcHufjd62/iAzj47S4X+qPQm6MdBxRCpBBbiO9hIzHea10Uzt3HyM1z+JFp6ipYRf8cm6t3RDMiQ1qEEDhh6Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250471; c=relaxed/simple;
	bh=0k3BTJcY58X4OJd3++bpiVwnMWtgEX7uYNcZpo8eCcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJWL3fk3rwlHUw94UP7D8ASKfbj1LhPJ77a4oE56NjK6BbVsGayCBqDdNjQ4I0zPjfrMZNPg1HknZupdf6veC/TYQGeFKGWJPwgZtDyLblbg4RQpxrXZBRU7Ai3pHn66M9npBQ1YIEWlEQzALNImfa3K62mB+Fp0MY9Ysc20AuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1nRohP5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1nRohP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792250469; x=1823786469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0k3BTJcY58X4OJd3++bpiVwnMWtgEX7uYNcZpo8eCcQ=;
  b=g1nRohP5iCoreBIuhZfne9j6Vhz9XKajbl1j1QzaUjsPhhR6ivsPYo8f
   hZTOiLeLSdwlLrXKIWqErnOSoI2YLo99RJ099nQi+gC9YckDWjwhz9lNh
   CAn9LKJ+izoqSIGZYzcWAEXij9sIfR/lMgWNfKOIkqhaSq2cu65jgQUw7
   rxs/ryq1NtPNx4G9+jPJQEzqM5LTM4Mw46zFTqw8OnXPepe5IkfxrxrjF
   eArBkn0ZSJFjzlwx6qE8STT2NL8RltQzbGpERetFWQWbuR6yc0UpVGllr
   3tbUTovWIE2DAuQhz7gXqbhBXkaji/jCbSaQGc8Npl23H5NXRqiGcYGiv
   Q==;
X-CSE-ConnectionGUID: VAP+W5F/QaKvZAF85V1G0A==
X-CSE-MsgGUID: o5vTuUW2SlSIVzG8Dj2/OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1012501"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1012501"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 08:21:08 -0700
X-CSE-ConnectionGUID: QNVRfHA/QgOILU2bF6zHNw==
X-CSE-MsgGUID: iceEZvHyTSa6+87CnJM9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2232749"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 08:21:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 08:21:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 08:21:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 08:21:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+eaynutq4hPoNr7ZtCz195ILWUFf2BG0kqYC5V67EGb6TV7O749rjJQW+Bkmg5FdO6HWeWu/6BdaMJhp9KiS/0NwTp3tUtv80td0u+7gb6sD29XLj0m/O5fsjEMwSh8eN0ziaKmEVu9VdSqFdYOc/M9aXDEaYVlabQfK0kxAJBzuHQylFRdpWh+u7PTSKVrH6bwBayb4Y8r6oPqe8FmaDor652CNyA1UA/xC+bRTYR6ruAF5Vw+G9T6lv48DhlBG8TamrZjD9MZt5PwYVhIkR4GwGbsT6ad6pHf+p3htom8enS/wGZKFc23i7jt6qCN5mfiHiMS3gtEpelgiWhQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpTN0bhER67gUlTwF+2gUXfHN63eNr2g2wDKjFuIXsk=;
 b=cXzluhJ5Gwf1ORaW6JRtchIxkB+hPjFXicJ472qmt70m5wcePc51Yio+fbDBNqm9Gbx00Nqhm56c6oBUFuKZ1bmhaGOhcoE+lklR8d8bZSzrw7kZ/HDwcKeJgYfyaUqDaWqiNO041CqKc5qYlt2wbCaOf84HuTfkGWobagvzcaQvnZnvkYFSGmlqKi2gvo7sClX9sgwaALeaeHEMmFe2X1iBRbJDkvXnbH7LVTtSr6iBlhoFxwi8ifMPmrYKWCxRypeKoNmVaCkzX4uIiqhJ2m79oYm93WBxfdQGZuxZXxHyTNWKx6TclV+tUc/eYvajpiYwyzv2YHYW7m8rxElTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Sat, 17 Oct
 2026 15:21:04 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0522.016; Sat, 17 Oct 2026
 15:21:04 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: Leon Romanovsky <leon@kernel.org>, Jim Chow <jim.chow@broadcom.com>, "Radu
 Rugina" <radu.rugina@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Lukas Wunner <lukas@wunner.de>, Nathan Ciobanu
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
Thread-Index: AQHdXb56kLC8GFOklEy8u/njCKgpc7cAx1kAgAAZpWCAAHtGAIAAfQbg
Date: Sat, 17 Oct 2026 15:21:04 +0000
Message-ID: <LV2PR11MB6070ABD61B46E9590C9B28ACB29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
 <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
 <LV2PR11MB6070CE9CCA125C290C0F8209B29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261017074820.GD219304@unreal>
In-Reply-To: <20261017074820.GD219304@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|SA0PR11MB4607:EE_
x-ms-office365-filtering-correlation-id: 6abbfb34-41c6-483c-73ef-08df2c624268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|38070700021|56012099006|261009223027099003|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: C6FiJ0gCBDZr9iYUdwGb7pOR6BWReqrIhJcn3FbMPBTX5PfSMOF+O3f0rltkG81D9vzX7uHssKXkK0JjJGw+lSAj0JrOQzazxa7a0nahSQ9mP3VnLqheCmryvtVUWcCOZGXLebwCE+sVGKcJIInQ/ZaGueab1A5YdfVL+IhAz6ApLu0WaS96Il7YHsm+cW52ByqKP2yQWsUns+ejCxzKODN2CEXj4J61H2asiAxaL/8CMcqIsZq0wrTqsWZM+bMzbiXW6t2DILKJnSDIb83kerlc+lpVED6WoMpdaOnwju64WITT0JVCUm8xwQDW59ygWRYxHWPG4tWVzf1IdvoDtDnFzTsbAjAkIVxzjTRPaNM2m/0zPwH9Ot8rKCUW/XGp7vmOntPora/Mcz6jWIVqUronTQUcmtzHLeHxXk8kExa080IRLYXUrj7XDTqFAezVmBmK5Qu/sHfXdP3jxYf0wknDRxfaQcfDPeMvIlDjijccW8JCS/y1ci63+3WdwDyxqBcP39DQ0jXCF+Ao6YSGkUvNpIyLAUvN2yZOcp+VgxljuhW/Ex3K/ZnukBz0FiN9p7YrRvO63ZPJDKUiDOtrBC06hlibCmTgUDqOtcydaiXkitcLTi46kEJkiuto3MKg48qVi0XfFP1lJhJj1B+/Ydx1VvGlBtR8zjdV6LcZXdvf8wlgn/thtwQQFIyq2vVjW9nQJitybtjhI4vFNFkDO/m01MkvzEkFJPc7gNwcvp8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(38070700021)(56012099006)(261009223027099003)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4eqF29ztxZcvRs7W3fB3K1mtfZMFBqxw287TwbR+AD8o7lVDYNYgPdLPFNrk?=
 =?us-ascii?Q?XUGlxObCQl5i421vuzZrGVvHYiFAWtao+9RWN+ez5mqaXKdEzknBnmUZEkwL?=
 =?us-ascii?Q?+3NDEp0XekLAIk6MNT25yo5hgEArOIxk1ON1FvuCTVJa50ZC3dEt1I8v/GIE?=
 =?us-ascii?Q?HAeqn/pjESKZx1oLLL9mtQ2v5dZwnsf9ArkVEoHgHhA0wvcWSw5aw32cCuH9?=
 =?us-ascii?Q?pttH3WSE8auY0UmFuBCaGB2a/1eqXRzxWdUyy1GwqFdjuzmpBnYVBP/knrBl?=
 =?us-ascii?Q?wuwKhQMUUhURYxnnVfs3rIPBgXrUCI3NIrRm9xLgM0yOm0bGC1oPx2UZ8ED8?=
 =?us-ascii?Q?QaRBUXN3smPBRTAAT0mJaP6cWkxvG2VHOyCW5ElO9r2+1MnkLT6TtB2MMJgW?=
 =?us-ascii?Q?rxaKRf4uGbhn/agWOVmpHTzEPrIy7EF3tEAikS0Cfn4oKxaZSXMkzCB9U0N7?=
 =?us-ascii?Q?FBE+0IWxeYr3dih2zdYRj+5IczyfABYiOSCn11RUMUOERwlU19hcrbRx8L6W?=
 =?us-ascii?Q?mn9oMTiP+mLw2mT2ENHC0KZY1ohlQJn1oy8wnme9SnvGHE5p4a7zLML3Eynr?=
 =?us-ascii?Q?meAWZoxnMNN56JLYOgkHN/TQoRPV5bvULsfDaaF7Xj5fjttq0ELKPeQ6yYyG?=
 =?us-ascii?Q?MIWHeGqcNzfeNpJUjesT8SPiWJjj+0D20ahPr7J9XUZ9xYn7KPFVx7kdFcjF?=
 =?us-ascii?Q?lGs+opIqmLKcEqBKJXzE0+bfenBTaIk1i2C7Ye2VULCi+KtvfK+gU5MsDIMM?=
 =?us-ascii?Q?NXxToXMfqsB1aZF462VPuu/Vx4369QtQy7kTLtsy+1b9roMWqjxc2E5LYssZ?=
 =?us-ascii?Q?/fM18merAyn9HiqmTK0D1I5YMSohgxHhSrnn75olNhjeIxKT6mwQPye48Giw?=
 =?us-ascii?Q?wmBmrq+DWiIul+hIl7WGpF2QH8GurDECJr2z2go9qxe9ZJj1N16GdpFUZHaU?=
 =?us-ascii?Q?oe1jfblv9pPT8me+wqHBjY3iHLH7xPaNmLvAXtyJ7UY8yzwO5bL/VB5bbo9A?=
 =?us-ascii?Q?aGMVFbN2UqpE97SDpD3MKj8N/9BjKtM+rKcku7W/tU0/11QM3SAk+czCe7VP?=
 =?us-ascii?Q?Zb1YfQ+kv56+6/PVwREr2Np9R2xlQvrWG+qYaQfHc2wuBUW/vhfhre1S1uGl?=
 =?us-ascii?Q?RzxupiZMDkDcC5Hgmy11f7z0iPrRciQmJJ1nzQDKhOlRUmYC3D5UTWnm79K1?=
 =?us-ascii?Q?fpyizE4hFEyrUcaI5yoSb65SA3UDM5aP7Wbhu6AmvbAJgh91tsHn1AI8ppIv?=
 =?us-ascii?Q?/PHGawh/Qfbmt3E/6u4TbwRDZ5y46TakHuVfQZ36bbGF8SONVaRRx2AGuuL9?=
 =?us-ascii?Q?yE7nCGKzgp+tToMnbn2On2c1LsjnlTJ8EWgVPq6aXcgkcTFxyiu79/5GjLmw?=
 =?us-ascii?Q?sxgEJRnJtnMu6H4dKmZ52+gyEORBsCBcn5MvknIlejyUjjyMB63wVb+AD4TF?=
 =?us-ascii?Q?7FrUIYP5tpyudY1q0l3gRdHYCKyWCB+rJpY6Ces6KG9+Vy08ohdZaiFbKdDs?=
 =?us-ascii?Q?0ortdKEOnzJOsFRsi/7aQwn+vgtFazChev/JhR9sjM0Y/ueCZ8jDQ1SSEJPy?=
 =?us-ascii?Q?lbe9P87MpdyEZ6C57Z1UsZbBXKP8lA64eHPNR5sZ5IqT55b/xJQb7Hmp/2jG?=
 =?us-ascii?Q?g+22gye+huv5zuYxkEAC/ggxo4Spt6y8RfLpU54Rlxg0fVJZtpywqZg209is?=
 =?us-ascii?Q?KIUMuLcHrHifsoDjS8ikhOypVGzQ2a0QAPHNmS+njWvYyCGcjs2FnCbiWRwe?=
 =?us-ascii?Q?okJR0bbxvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: x1MvXxkVoIgeEN3DwF5C0oG/NMgXh7tS5EupM6Fq+zcvlV7rais2vZ35y3yRM3mLwEg359sD3JrPOjhtln8KG3H4yO2NsUmcm9rjIN2WiJY835YLgSLY0BXxxoxH3BuE7Z8IqGo01/41wdzXN4Wktk7yqX9n30/tZOgk5Esa3KU7d/zxvjgbEd9WPeS9q6Hos/XW/4k281SFuQSNsw+TAZ4qTNB8kiCwEhSEnbl/KkhBoO5YPy3UB6RNYEplTrHJNAu369B9UHGY9gbiAk2yBhV/MUznZuQO+Gidri0e61ewhMObuheRqNGOTvkFS/Eje14TCHj276joG6C3bVMJJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abbfb34-41c6-483c-73ef-08df2c624268
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 15:21:04.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNNiBqMu1lCgojc5enigejv2iX/u4UvG6YrwPpr10BUmOD796rRThzPaOuXYqxMVHorgSoA9NEv8t5YJOGzJ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com

Logan,

To keep the record straight:

- A global CPU check was never proposed: v1 and v2 are both limited to
  the hypervisor, for the reasons in my previous mail. The argument
  was parity with AMD guests.
- v2 does not depend on Broadcom certification. The explicit list
  matches only the Xeon generations whose host bridges are already
  whitelisted, which is stricter than the AMD global CPU check.
- HMAT's direction was never questioned. There is no HMAT solution
  today, and current ESXi releases need one. As a side remark, the
  timeline for ESXi to adopt HMAT deserves consideration too.

Thanks,
Pavel

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Saturday, October 17, 2026 12:48 AM
> To: Logan Gunthorpe <logang@deltatee.com>
> Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Jim Chow <jim.chow@broadcom.com>; Radu
> Rugina <radu.rugina@broadcom.com>; Alexey Makhalov
> <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>; Michael
> Kelley <mhklinux@outlook.com>; Lukas Wunner <lukas@wunner.de>; Nathan
> Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> list@broadcom.com; virtualization@lists.linux.dev; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests
> on Intel hosts
>=20
> On Sat, Oct 17, 2026 at 12:31:49AM +0000, Popov, Pavel E wrote:
> > Logan,
> >
> > > Why does this now need to be related to the hypervisor? Wouldn't it
> > > make sense to do this check regardless of whether VMware is involved?
> >
> > The whitelist decides per host bridge, and a global CPU check would
> > override it on these CPUs, for example:
> >
> > - It allows VMD domains, CXL 1.1 devices and other RCiEPs, which are
> >   not whitelisted.
> > - It overrides the emulated topology in KVM/QEMU guests, which already
> >   decides P2P there.
> > - It makes the existing QAT, DSA and IAA whitelist entries pointless,
> >   since any RCiEP would be allowed.
> >
> > Limiting it to the hypervisor keeps the whitelist logic unchanged on
> > bare metal and in other guests.
>=20
> Logan,
>=20
> You can see how convoluted and illogical this discussion has become.
>=20
> Initially, Pavel was told that P2P inside a VM is not working reliably (t=
o put it
> mildly). His response was that he wanted Intel to provide the same poor
> experience that AMD currently provides. We agreed.
>=20
> Now he points out that AMD's solution does not work well and proposes
> keeping his hack, which will not work any better.
>=20
> Moreover, it is unrealistic to expect users to run this software and VMwa=
re's
> code only on machines certified by Broadcom. It shows complete
> misunderstanding of users.
>=20
> His claim that HMAT's future is unclear is also inaccurate. Half the work=
 had
> already been done: p2p ACS had been cleaned up and was waiting for Bjorn =
to
> pick it up; an initial version of the HMAT specification had been drafted=
 and
> verified against the current kernel implementation; and the community had
> been consulted and had endorsed the approach at LPC. The remaining work i=
s
> to update the specification, move it through the code-first process, and
> implement it in QEMU.
>=20
> The direction is clear, and developer time has been allocated. This will =
happen.
>=20
> Thanks
>=20
> >
> > Thanks,
> > Pavel
> >
> > > -----Original Message-----
> > > From: Logan Gunthorpe <logang@deltatee.com>
> > > Sent: Friday, October 16, 2026 3:55 PM
> > > To: Popov, Pavel E <pavel.e.popov@intel.com>; Bjorn Helgaas
> > > <bhelgaas@google.com>
> > > Cc: Jim Chow <jim.chow@broadcom.com>; Radu Rugina
> > > <radu.rugina@broadcom.com>; Alexey Makhalov
> > > <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>;
> > > Michael Kelley <mhklinux@outlook.com>; Lukas Wunner
> > > <lukas@wunner.de>; Leon Romanovsky <leonro@nvidia.com>; Nathan
> > > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware
> > > guests on Intel hosts
> > >
> > >
> > >
> > > On 2026-10-16 16:34, Pavel Popov wrote:
> > > > +#ifdef CONFIG_X86
> > > > +/* CPUs whose host bridges support p2pdma, see
> > > > +pci_p2pdma_whitelist[] */ static const struct x86_cpu_id
> hypervisor_p2pdma_cpu_ids[] =3D {
> > > > +	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
> > > > +	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
> > > > +	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
> > > > +	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
> > > > +	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
> > > > +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, NULL),
> > > > +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, NULL),
> > > > +	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, NULL),
> > > > +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> > > > +	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, NULL),
> > > > +	{}
> > > > +};
> > > > +
> > > > +static bool hypervisor_supports_p2pdma(void) {
> > > > +	/* Hypervisor hides host topology, allow p2pdma on whitelisted
> > > > +CPUs
> > > */
> > > > +	if (hypervisor_is_type(X86_HYPER_VMWARE))
> > > > +		return x86_match_cpu(hypervisor_p2pdma_cpu_ids);
> > > > +
> > > > +	return false;
> > > > +}
> > > One quick thought, after a very quick pass at this:
> > >
> > > Why does this now need to be related to the hypervisor? Wouldn't it
> > > make sense to do this check regardless of whether VMWare is involved?
> > >
> > > Logan
