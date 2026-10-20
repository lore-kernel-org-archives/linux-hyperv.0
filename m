Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792525060;
	b=Ok1Y55G843rlJy11qY6Gzdyqg8aECKqgPeCfBOe+soTFMrZNF+ZhyYkWCEaXR9uAM8qw
	 gikWlyyWez4XtqwihV3ywhrDps0GDqGCARLS3rBLdesVWWX1eJfQh+YL/COpP+Hb7AG0U
	 nopR9ru+8GvNkcwAXILGx88goUwKqyb4MIguh/hnhW52ffqaw170VuMbsH9kctpGbezhL
	 m8YW2AVLpAR74JcMFUzRqILt3urg+rUvgDfXjB/3j7SKRmHuA591NIzzPumI/WmOx4nsh
	 a1LtUMEYyxxgbkOHrWbcM2RQUbCI8O+MemTi+oH5GqqX8c5BhAK3ZICLg67wqiY79ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525060;
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
	bh=xF2bTCNOWyRHCTeizHdWdN/Y3rWAt33qthuE69XMTV4=;
	b=xSnw9J5jDTFi+OF/A07TVEVpTrCR4nb17ig92Hwiiy5mhdn4n9U2Y2hSDmTlMyMSLOqy
	 w2l8BJR/FsAzomma8ceFhShdLgHienKVkcsGkWPS/Ol1zILIOfiNCsncgxtyv00JBBdIy
	 5VyQRd2+BGmXpCu7v9qSofq6cm4UveaEKYmfc4z6MchuzNCZWFrkWsIEsxUFUcqzVHRN+
	 ppbDJAooBM1gj5FrGAcg2T9c52/MVbuAlXwIYk69d4I6+DVTnkRqnWGvk0BVRCdx4d0Vf
	 Yly0eO3T0L6VEb96y7mHk1iQT2xOTkO1rCqmjrteQKfI/4EHzbFoqXEBtM4ttP57ajQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iz8x8JxH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF2606A31A;
	Tue, 20 Oct 2026 19:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64DF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iz8x8JxH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792525058; x=1824061058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y+gBAuHDIHWKdv8wm5XcIcYZAZsU2GmYrGj2uf3yV+k=;
  b=Iz8x8JxH5mx1FfrCaOLkMxtxWUSMJZjiglOzyQnO1okWXAUdoqpbD+ae
   59N0CjEAHRU/IxqJjV10D18N0EwnXxBb1HV6F1CiTO6BqDWlr3lqR/AeV
   GjQou7l6pLbYL/EEY1FmXRAYfKs7whAnldG6Ie+G3QhHMjOaAXxLE7cFS
   EBM6EKlyXToRMXDn4I/LftrbVGHOZAyJwg2QI2WZGsEhH75j554AJEryY
   Y43EeFpD3r8XO3/nsedG/iz9lcjVU4DH3Sh4VV1Bvx49ednydNJ2u+1ww
   k9/QNPoIrPfp2+0yS6RKKftf/hAJ9/eCz//7gG/LETZFXOjd8mbA4xGMk
   Q==;
X-CSE-ConnectionGUID: 28pyyDM5SEaZhFMgQWnc+g==
X-CSE-MsgGUID: tAWdfHY5Rx+mX7dO9AV5Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1343445"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1343445"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 12:37:37 -0700
X-CSE-ConnectionGUID: sZEQjHNTTB2j1i0Ts7oXvA==
X-CSE-MsgGUID: bogf4KVRSja0qBGOnwD1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3259784"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 12:37:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 12:37:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 12:37:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 12:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoYF2Ux02wRRnYYUfNpqufE8Bm02PcVsNIRcHTU/HMUfpeRv1QH9FKnn/qhB0yp9KmCfKq0B2YVWL3RgfBjo7YAUGPKj5PzmccUgHGAB61x9WWqT9ask7lPqF/ICib2lf50JPjSL/ZNJ7nJOCN+cS033N/mbYFLG3ZRVJ1EdkIyoP9jb5k2jeVeWpc0+jO28sLVDvIwKhoJ1dR2nLoaKc8gVXiBY0BCyTCOVmDcNXSs7YBknUtV4GoNEwwGO8qkmF79FlJupdAzOjWyWAMlXh5CuvpHy+q7PaUP+LJDAgvoXulb7Ixgkv0hnKPwhcbkhSirCI23aoI2xmqkTDgMe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF2bTCNOWyRHCTeizHdWdN/Y3rWAt33qthuE69XMTV4=;
 b=HwT2898JKj+iEf0AwQ4Q+STXz2yaaddARXHQFBo41TDdiYiqCoxwhuOEKm8CE7ktrDJMv21CTQpfVkv1pulCEsCefnsSiESCSkqIRVbIqdFrqIh+mc68eYMv5P5Ovi8/uIw3cMFn7C4eg702EmtjIBYcd1XJeQn9ldWcUtyZfgrPbwDbY9IzWNjtyXt941Z4rMiOcDlqUlJ9k4ED331A11GEJtD3hDXiVW27Gvok0ZLVnEp/87Tdm+Kbb3hnhnlsllah9dovnYgU4rvtOPdlxm2OlBIIYRK39kqZxDHwIdiKy3Xm7mpB3Ni1Z2pX/3ov9e+WgbuN+yq1/6DNViybyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by DS7PR11MB6224.namprd11.prod.outlook.com (2603:10b6:8:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 20 Oct 2026 19:37:32 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 19:37:32 +0000
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
Thread-Index: AQHdYLm3Eu3+F6ITg0+VFiHnE2F7qrcGw2EAgAAN8iA=
Date: Tue, 20 Oct 2026 19:37:32 +0000
Message-ID: <LV2PR11MB6070E19D3A0CCA50943D7499B2672@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <20261020184002.GO64621@unreal>
In-Reply-To: <20261020184002.GO64621@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|DS7PR11MB6224:EE_
x-ms-office365-filtering-correlation-id: 0c12b0d1-28fc-4aef-7640-08df2ee195a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|38070700021|56012099006|11063799006|261009221227099003|261009223327099003|261009223027099003|261009221727099003|261009220027099003|22082099003|18002099003|10067099003|6133799003;
x-microsoft-antispam-message-info: 3FZo20mXabnfZU1wkNNhNRUsBKP/oqS6Ow8f7qqDRc5HJJNYI9XYi8GlGLVswDYegQS6gGpHdgBO0H9m6vLGrirUoxhIkBAOmEC2tfhRgISXI9rakaJk5NxSSSwev+yFkpmqvsbRx8/pU5wRssPnfI387iEQgsmQ4oxMiBylHL3hvamYPiD5x2KVhYShF2WYv8N3vjJhcVKsMQ0comKJXnP2Tktx1L4pNd3m7qToIYGV0m5sPIbpOXrIUyRj1CyWBi0zVOjhJ2M6XruRAyzvNUqbRBqjgrqm8E0rPOi3MkMKU2oodlY5aJGwZfIgveOAEqoi30I90wnmdqgQGVsnuQU6Dm9Z7X6Y/4Rsxrfjb45OfiYFo0sSKGFGsCKvYI/HyBNWw7YauCtbA/5Te/ztR8RwefihMNw/pU8m1RXVlKJSrK3Rt9FGvNx2rJG6OezkZWRnoIJ7KUxIwwU2d+IIaV6G7/nwiIEIoLBSI7so2tdnAzb/8wDsVZxLw9UILFrXVdMOIuWhk1o4SfSHHBebyLgBWpDbkdcLlIffi6hEjmHu4RDBO9SQBbVOSlGZOOL5cXaPnMinc2LDP9OHcvZ/GJbea5tRJxtSydae8aqqnrgV5+6xDoM7JuZx/NylySFvg49EDq32Vfq8J55WvNXOZNc0VAtENjrP0wYgYO5x+AQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(38070700021)(56012099006)(11063799006)(261009221227099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009220027099003)(22082099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QI030bvzDBsD8iRPnYgtlsvrS9AIlfGRRQji1MqzrA0Bh9CUuU5YD4PZ54b+?=
 =?us-ascii?Q?22GesLGeXB5Ok8nKWa9Sy4uxPNychfx8xsFeluWdtIEGrYdxNvLIL2hPgWGv?=
 =?us-ascii?Q?a2L47GcTAZkzLrnqztloaZLIImzZrtsfI0VRiP0hqbvepB2+2QXR0kuVQh/V?=
 =?us-ascii?Q?8Xs/oFkpyH4w/sM3t1YJCaIuKkUYYB8OSAam2/ulIRrgTUWmFCQMdGokXZq+?=
 =?us-ascii?Q?lZercdX9bysLeSCvZMfbCT4l8wrACgdf0tgxnfxhRzrLGdicwLeh823/th6V?=
 =?us-ascii?Q?19IosjldEQK1g5BTEttnBbQ9YXxNYuJe63ylOSpiev3yXmr5q8G6DiBmshCl?=
 =?us-ascii?Q?K0CTI7j95u4L9ZdZjKn06G147ZjPNNoh/Ji3HqIT0j8F16wAc2nC6YgKJcbI?=
 =?us-ascii?Q?SzfqaWH26iDwXCIH0hdJXfYujXdNhJA+iPd3xbphbqysw/WWbOTu1DXWMnn4?=
 =?us-ascii?Q?KvC2s0fhlrNpBErswEtfA5hAIAb+fqaH0fBK/uEBTZidoIhYTB2uWW/w+ZSb?=
 =?us-ascii?Q?e+1XH91/791KePvCjfr/N7zvdI4YaCDJBBqS53d+yylCeuJPS2LUueUhRxPp?=
 =?us-ascii?Q?gW5rENw9tpemBPZrG+Ur0FYZ2bAz9LwyD9+i/2oS5noo0d+bliCqi2WvRTvD?=
 =?us-ascii?Q?B0QUCaX1cLYsmYuv+sSnn9ifKTKuiExGuSuhsSzLaVZFLdHj5WkP5pi4Ddre?=
 =?us-ascii?Q?dKDm54X1XAWDokRYCQMXhHFdcBHyqnNStNb35Yv49Ymw9b8VPyoJXYV3qsfD?=
 =?us-ascii?Q?lANIpYar8yXNk40qBFjmEDyA8WnOfyckGKuhIdVanxHqznNRndoWUR7OwDjd?=
 =?us-ascii?Q?UcgV2jI5DFPXuI8/UFw9B6ZWxva1i8rfkGiLan6yyvNIAmezLzk7s8izbv9S?=
 =?us-ascii?Q?8nEc5nuP+P2wU6/6cRp1L+ZZU3r4YQJymdeYfTC42PSOYxdTmPvlzBZgsYFi?=
 =?us-ascii?Q?FIrNCnzuJvB7+nAg/YlBnS2d1bv/uuXGwuROXA3sHdy+2IElgA3vM0EMaGXE?=
 =?us-ascii?Q?kaFhKc6cAPduQfpzjsv2iF8tTPXDEO7UKZ0cF5VP9SlmPh8azjeXHCBpDOX8?=
 =?us-ascii?Q?BFKvpzpDwq7+cjXA4j92a53yfD4kJOi23LgzSraM/BcpmOgrvXzmP8338S/n?=
 =?us-ascii?Q?lato34toFdk3xWSTv95aG0yR5KReP+ujlH9jrHoqXAaZ05v5cnk/TIYrNNSh?=
 =?us-ascii?Q?DJpMjBJcPzeQG658QRBt+U5MsciY26ZM904YA8yLl/JlVESVXr8d9FBykuh6?=
 =?us-ascii?Q?KBk0gVAZrQ0qZ2Gl0W8m38Oa4dfOUlc8h1s8HaYxLqx5CR4xbAIAlCz27HPM?=
 =?us-ascii?Q?kjsBNEM6/Aur7nS7Chs3WUiNfDydO+f/eTjh9PgrvYrGgWS/nLqwJ01vH7vn?=
 =?us-ascii?Q?h+gem19b9f0yR8FmSXIjq731Im4ZWNnelD/YL2yJi4WtoIoMg7JsjtQmOE+Y?=
 =?us-ascii?Q?aCKMMsp43f1o8thLTS/xMaP5fp4jj5gzsi7b9Yk+JPT7OY7zLoNtyamAejvD?=
 =?us-ascii?Q?sactb27c9aEuXIeUEfgPujRHGRuTfIJEjVpB2eHn1Rx3iJ9rd4dzrziv+/yz?=
 =?us-ascii?Q?5F+YoE2RyGOIwKYUQMgQY2uAmfi7OhbdC1WKc4R/vRKGVGJAAyv/NEMDGwju?=
 =?us-ascii?Q?5dfVdg6uRN/WGTL+JoeaPUXAtU95hTzpsC+TtDAsXu0UjQqIqAcYvOpfKWLK?=
 =?us-ascii?Q?bp9l+sJTKoVLfbslmb2LcZYAyETGK9+RXXDY0DIgjuhcgiplwdiBK9/gxyGp?=
 =?us-ascii?Q?AfsYp3QXfA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: vrK8EZ+ldr0gm78iKxmYO9hBIfq7vfw/djmanfcdWtJTs0ZJi4JqySCA01IboJrQ6ZWYB0iVEVTqBpLXSLZecp1nI/DAR+MjG55MaNQAN+7vynEIaRmB7IX0fyc0PusThgG+VdNnR9frwBNcehJDPzk0aN6Ajzk3oYzE7fPUfnv6AJ08JtlIj0PTdeq4RpOe/YbqugxJDbxj0iIHcy2wB7YgRyjEtdsISbXlRFNjA44tcssG82au4uBlmzqxM17nYWCUS8gnQfJENZbU9EBQD7qQGBIy/Jdz7dC8/3c+a9JllZkKXL7hmm3b1LFZXwbP4wwIfG02Z5No4fphNprpsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c12b0d1-28fc-4aef-7640-08df2ee195a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 19:37:32.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //C6gSL9iBQhgCQ9cZl8e5YAYW5SOZGZZDIe9SHKbwgBxQtqRsZf3GHWYyOwkF9gLrJlNq5OPkGYMaC44drQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6224
X-OriginatorOrg: intel.com

Leon,

The #ifdef CONFIG_X86 in cpu_supports_p2pdma() came with the AMD check.

Would it work for you if I move the includes into that single #ifdef
block, next to the CPU check? Some multi-arch code does the same:

  https://git.kernel.org/torvalds/c/c7be64355fcc (drivers/acpi/mipi-disco-i=
mg.c)
  https://git.kernel.org/torvalds/c/7f3cfb7943d2 (drivers/cpufreq/cpufreq_o=
ndemand.h)

Thanks,
Pavel

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, October 20, 2026 11:40 AM
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
> On Tue, Oct 20, 2026 at 10:37:34AM -0700, Pavel Popov wrote:
> > VMware and Hyper-V expose passthrough devices to guest VMs without an
> > explicit host bridge device. Consequently, host_bridge_whitelist()
> > cannot automatically identify the underlying host bridge structure,
> > causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
> > device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
> > P2PDMA on Intel hosts, this series extends cpu_supports_p2pdma(),
> > which so far covers AMD Zen and newer, with an explicit list of Intel
> > Xeon server generations.
> >
> > Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> > Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by
> > carried over; the Xeon list and the check are unchanged.
> >
> > Changes in v4:
> > - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> >   (Logan Gunthorpe, Leon Romanovsky)
> > - Keep the #ifdef around the asm/ includes, as these headers exist
> >   only on x86 (Bjorn Helgaas)
>=20
> I'm confident that this is wrong usage of asm headers.
>=20
> Thanks
