Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514836;
	b=no7vFlqIZrOnpdI101Xab3elXijgQpx3igSdMTv3g2QaL3+mRg8P4BBQ0gJVX6cRap2d
	 EWsf2KNScxBbCXtg40VAUxFMt2R8o4OJHaOTMnArBEYgBVNdMt9rEa5LqAbJdoxrT8pgC
	 SJWVCYyIhTPg/WvEg9K/gSA0xBYgPpgTHD7+zHKjP2FuiNnKrYfaz+bJIdW3RriEkjXpi
	 dwsX24pYF5TRo5SNFNUcMMDfqj9iSnbkqsiwhvLyT2wcmYUtMaLwSUxAa6T4RVaJOzJIZ
	 PbNjJidtTpTVecjkNX6YJWRU/i7fU08NYZapfzsYNzjLjnw28/vBHw98W1Q3zvoHFwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514836;
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
	bh=IYeU5yL7lDjYrUbdNHrs+eNBykpNEWnh656Psmfu0Zk=;
	b=RNi9tdy6yr3MvbLvpje8RC2ke3TZ5HDMP4g+oitOJa2xNdPSGwaNvw1sqhd6/Tx4CVQ3
	 31jC6dMKLf6lQpJzRsZ0YlgFNbMxhKYnYyL+uL28i4yG8PCliyqdvD4C1OxlAJHUOQbLD
	 ND/ty0lBC3SFf7bqgbLQIjyg7Vc8wpZ1nRuTniBtu7/TdMPkhHOm0S7y70OMQBtEOTeM9
	 UwMhSQcnfZiMCmsCS2UGLUh8RmSVbTnlHl8Ck7IwPOTSig6bCXE24uYAwJ6E/nEzFSDtA
	 U5GKmIMadz2al2YwHlAZsVPvtQZLwGUJTRYjf9sRz7qkTs8mgXfphkb5aaxjyiK9KGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T+U917eK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D93606A31D;
	Tue, 20 Oct 2026 16:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D93606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T+U917eK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792514836; x=1824050836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=in8gMTwPepLu3QCSRdK8ygHPopGlBVBMzaac1PD+9jo=;
  b=T+U917eKWdfMSuuaV/KKCSv2cyt/I6w1hAdAAlTFLJZmoSIx3ZN/Cedo
   wEzgTzIY/4C+sXB2pnRW9oiBXw99DQp2xa4x8bre0xOcPsVQaEf7w/dAE
   cT39ePMs4t4OR5CAM53YkBN3fWrvBxe4gbm7P700H9dVxPZavu7+aqUDI
   DaVGQGGI0BOmG5WHX5ZO53Yu6DxzxfYLsebiwnHj0TbCk7GQXIzTMZLrY
   h7q2NUeTJPSzvinQG/JTMW4KymDgm6Bef2fa+7AWcKebuk6GAcrqr19+2
   pkJ/t+Wu8yk/fqJzUI2NUoubqh9GiEqIvf99tZ5HWAOqIB+wS5WjdFKBN
   A==;
X-CSE-ConnectionGUID: fvAKAJpEQeuSmMi2UTZBeQ==
X-CSE-MsgGUID: SZp9/Qb5R1qdwPsstmQ3ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222598"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222598"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 09:47:15 -0700
X-CSE-ConnectionGUID: db4LOUOWTbu5vfNrLdfJ8Q==
X-CSE-MsgGUID: mpr/n3MuQU2Yy5cvWRjKgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3325231"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 09:47:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:47:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 09:47:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP8eAwAmiqY0v7giUtyTM1ih9zzpPCJCmTRI3pp6H68naSBlFi6qPG2w1+KQupDz8FqsaiN+JJzX6wgNVlTQVi2ae+GtUU5MXaP13UlweKgBhQvSgxTc6dBFG1XbMsfP3BK/IssIrIoNt0SwNp6R6/zLBIGShOPaKcoH1THIHQoiehmPcAjQ18iMCLZNA3l5Lopsbjngj8asxRCEDjGoSeSXR0b/V/yfWjr/3HzdwEjUhho11B6vhEaGzjFX+LDyrMRTqBXbsqRDSWWC8Zrwql3HHz1b5MvYThNdOzhTJnOgU3DkEl7/PEveEkGj8FrO4xEPkoiurQRV5snOFQpFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYeU5yL7lDjYrUbdNHrs+eNBykpNEWnh656Psmfu0Zk=;
 b=NGz3/cm2A7LKGGLQsZRsnTITabbPZnxNRUdZpAIICJz4gXfizHeq4paPjkI6j9jbVNpnQBbFZT2ERKat6BOHA1TTSNJuygcE9v6MQPUN7jdJdYIc9lmdYGmvFejltLWtJVSs8yEoHisA39IdM40pYEDHJdpkWnp5KH3tPhg76EzYv99vzctaSI6u/5ENSvREPPERFIG/CFZ4BdX6mCeTThOhCtOaoe6VHFVnzSftcIheIneDhzlUDeg05D+gGTgsGwFbsnQbhmACzcMv0Eah51ZSVUS243FPMKDGpqLR/yK5fux+njQF3yhlnhB9Ph56nM/wMvGfWwO+9NqdEs7JsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by CYXPR11MB8711.namprd11.prod.outlook.com (2603:10b6:930:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 20 Oct
 2026 16:47:04 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:47:04 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, "Jim
 Chow" <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, Nathan Ciobanu
	<nathan.d.ciobanu@linux.intel.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Thread-Topic: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Thread-Index: AQHdYKWLVAc6/QYzDUyrQI/sNculNrcGmvWAgAAGegCAAADHUA==
Date: Tue, 20 Oct 2026 16:47:04 +0000
Message-ID: <LV2PR11MB6070444E927B9AA891B8180FB2672@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261020161447.GN64621@unreal>
 <20261020163758.GA2342476@bhelgaas>
In-Reply-To: <20261020163758.GA2342476@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|CYXPR11MB8711:EE_
x-ms-office365-filtering-correlation-id: 24977e51-f754-4af4-e4d0-08df2ec9c589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|10067099003|18002099003|22082099003|38070700021|4143699003|11063799006|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|56012099006;
x-microsoft-antispam-message-info: yZcpfaHnFOG9aGml6ko211s7Wd8zQETr4+KglycbZKc6aQ29IDXs24nSUL+kpcTsw1tVymbAbCAw8xJvia01DG2wZlHtfQlJlb7D8BVP1rT17nmfg8bMLJz48OyTMosm28vKJ3I601UrYNSr9+uNwURGs4n7XGDwoZ41tDUYIoh4c2bh1DqyRrG4tkbaxZ+8xPfa+W8wC3mtJO4bnRqyJdr9rHvyPGA4DCuXJ7MTrT4496YUdjWPY9/ickwTwpYA//+XsTM9hOOgD5pAAZWDghW540i1JiBYi38RvFQt+B48qVk1EbjCF/9P1zRShhc8DZDkZfKI1EckrAsgtb80SXXdlc/eZWO1ZA/QUksVEHzda/YTugC/Lyd97JeGfHtQ91YYV7Be3QSVOXqUVUGzI3BGno59rkPvlWiHu8XjAko7fC05b3bYfLhVrOHUWMoEA6++57t4Foujc/V57cG7eb823yO2IOzViVv2pZivuxb1SIDIqOItmcVFyEcJiOvxqza6o09lBBTbKgTSnNncfrmQagkbe5LDdDBaex8/YXp3ekWECadNX75A/F882l/dUUrZBBXiF/qm/8UcqQzxi69MEuALr7YiFP4NijSw3slO3FAEVCcVQFRUYCtiI9ieyCE8u8lrKmwS+cFcc5JCrKKHIrmkcYKV1rLJ+X+fwkmKzmIA+RGAQw/fXFMDpvaA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(10067099003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cx2Xy7TXI01bU7qd9HXKQwX1i2pizMi88Cskcdj8b8q81+3tZHqcdQG3sI3v?=
 =?us-ascii?Q?m2oP1l00MpVfOSjcx1jcawPw3RwGksf4GO8PPy8H8G0dCHSoNjvrE7dhQiru?=
 =?us-ascii?Q?fX4sHG1agW3oc28KvgYBGIlll2mTXUr2Ta3OQ0+Gt7L2MUwrx4mkqldwUcl5?=
 =?us-ascii?Q?1tYVY8Gr8JzXOq16B4k5rvFetmClaCG5KZ9gx0uZZOmS7qdZ7IoVdtZDDlEp?=
 =?us-ascii?Q?87JbwkH0zGKRpwHcXL7VWLPlDwuLjYeXDvxUBzVucGiUyD3V7txjS4apdXig?=
 =?us-ascii?Q?K3VO/50SQVvz6qG8Xzz8dEfA4ZCe1CieZWLqN1USIqZJoRyJlaSDgeTgTBtN?=
 =?us-ascii?Q?qiJZRFgYsppRNDqtzLzaaqgZjw8P+OVaqeTIFh22DmwRD9/eeFjiTCVWXcb7?=
 =?us-ascii?Q?X4+A1yq+Wv/w9bReS7Ej6Xr5bhgDE66PQ4odcZiKLOcc19G/LAC4Xb2YRa7G?=
 =?us-ascii?Q?7wNB6l2nA0bJiafq7mNYxZ9Za0A2+CBXhUp0rHVwSb2aloJeunXsyImeaCNl?=
 =?us-ascii?Q?9Fw5n+DWwcQKJLVTqWrOUHjGBCfL72l/zEXdfvnIvrDwX8UKBeWAUQEwlEVe?=
 =?us-ascii?Q?+MfN1oe6xjcjNU3HQOUba0TwoitX+FqOC6pp4F9oKvsXRZx2z69XANqJoebr?=
 =?us-ascii?Q?puUIrx410y4Bpft2gQioaUQ0xWOtDsd3ml2GNI79SFkq36lSLxzTN2tVOAcE?=
 =?us-ascii?Q?H9fet2jFtq9wbMmZ1SNlyshoNEgzjOFIHzdQ5SGZJS6uEFuNfaF1A6neTwxv?=
 =?us-ascii?Q?jPbptHflm4tHY89k4FRFQE9fHGE6r9qaNdZclTvFHsWAFScUq/MykkxFKJoZ?=
 =?us-ascii?Q?+HDIzF3dovzZHX2otlcR6scWoLrXzprr2A41Ot3wfq9/rUHXjL9dzGwkh61o?=
 =?us-ascii?Q?q1bIBE8e7Wg+i9a1oQnNl6zZkGJ/wHHw3da2g8ZHw6cfzaEFANeBxWfsQN+O?=
 =?us-ascii?Q?Bcir6N4MKrJbXpN4coVDPKQVtBt+vzMNW8To5GBS/4GmYzMJ+3/6LhWCt3pu?=
 =?us-ascii?Q?T2Ars8cmklzcbxyYE4RGABL4b4lJwABVp4uiSnEItM4aGPAbBGgBBJ9/9X1l?=
 =?us-ascii?Q?S+0mnpUDQIC0TA/jrBay5BNRSDvC0m1B2/2jIDb0l4jlOYhTFV5NTmFzGwaQ?=
 =?us-ascii?Q?6y+xPvwUQR+c42AVM1rvBwh8CKYzdlslyVC6ocBuBOhxH5AAh8zECb+qqw6M?=
 =?us-ascii?Q?5bqCV+pMfXAfwgm8A5rHh6+Ul+EwY8I4TBxkPEr8FVWb08oIOpMfR8HM8pNv?=
 =?us-ascii?Q?EiBffXtfBCCtL0uMXe6pxiCmMSNEcPw2k6O92JH2B3O1VR60XuvsTz0l9GVo?=
 =?us-ascii?Q?PpSD0guqTIUd6kcUZW8nj10HaBJtDWxFTa8YM4dm5VdB+hfGSggfG3dispsU?=
 =?us-ascii?Q?RVRznJLyXjEz6GadJ2U2bOGDeB1X1uwu2McCnrMu7fX+aRjMcnJKWIZB5Zor?=
 =?us-ascii?Q?olcaoszRQ0YJhfxyE3p9Fhs/ErNxpGi8ylM0UP+oRx8eNFpTGmoZ35rtPrTi?=
 =?us-ascii?Q?MaW/McPxi2omz9BJwaFj/T1Ff+gjO9pMDZ/1cvPEXt//3WPSl9BvvmHBdj+C?=
 =?us-ascii?Q?6yYiAkmkqPSv/MIHxETnxX/ruIm0MbpesHQOQz7oopkEXHVM9bD5P2I1IxPh?=
 =?us-ascii?Q?8P4ICIz2XPvtQAlHeINxGGAe5Bx9lzM+Het8CgTaT2lunC/jR4HfOwVx98AX?=
 =?us-ascii?Q?sDUFkFRYnqlWOn5KX7cw8EFNCZrYrxpSKZVAoEXu5FDW/kE8UI43mipk2Hky?=
 =?us-ascii?Q?WYkuV0ZgFQ=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: DpgWnEeXnIRS4abCfLCoyrNjl3SbwN7WjpITz0wjIE5GxaF7rzJTdRlHA0mRts8v3OM6+bTwAnDcyyAMCD7xO+37Xz8vx0g1HEgdPzNKecWTrSQWt3U2QjjAeLWgVPseHjvpmyk2LAmWBRcpbd+EcexS0+RT6/0Eua/WJ24XmPgwKKuxCjvPbjWoPF2RcZ/muIJ+gLBstCcXrcmmVfPsVlWDOtpykO3jRLsktMHVptgQDSss4Dg6dbW6u93KtBuMr3nB9Ps6GAzQEwwSz8UVuYQIpCVpvs0RbD+/ek7ynynOYywzH8qyKY0UE8ATDroAgUiyYgu82YwwcGgS1v/Hcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24977e51-f754-4af4-e4d0-08df2ec9c589
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 16:47:04.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mpZqrQRrRvFlMEXBkxiMc1zNB1Wuf2R36gbTgttGfUIlbVK4b4idLxz0iXYTkIM+wL9l7q/kjEySyWwoJJlgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8711
X-OriginatorOrg: intel.com

If preferred, we could use for cpu_supports_p2pdma() the pattern Logan
suggested for hypervisor_supports_p2pdma() in v1: the whole function
under #ifdef CONFIG_X86 with a stub returning false for !CONFIG_X86.
The Intel CPU list then moves into the same #ifdef block, which saves
one #ifdef, at the cost of also touching the existing AMD part.

Thanks,
Pavel

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, October 20, 2026 9:38 AM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Logan Gunthorpe <logang@deltatee.com>; Lukas
> Wunner <lukas@wunner.de>; Jim Chow <jim.chow@broadcom.com>; Radu
> Rugina <radu.rugina@broadcom.com>; Alexey Makhalov
> <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>; Michael
> Kelley <mhklinux@outlook.com>; Nathan Ciobanu
> <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-list@broadcom.com=
;
> virtualization@lists.linux.dev; linux-hyperv@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPU=
s
>=20
> On Tue, Oct 20, 2026 at 07:14:47PM +0300, Leon Romanovsky wrote:
> > On Tue, Oct 20, 2026 at 08:13:05AM -0700, Pavel Popov wrote:
> > > Peer-to-Peer DMA (P2PDMA) between two devices requires either a
> > > shared upstream bridge or a host bridge matching
> > > pci_p2pdma_whitelist[]. In VMware guests, passthrough devices appear
> > > directly on virtual root buses without host bridge devices. In
> > > Hyper-V guests, each passthrough device appears in a PCI domain of
> > > its own without a host bridge device. Consequently, P2PDMA checks
> > > evaluate endpoint Device IDs against the host bridge whitelist,
> > > causing P2PDMA requests to fail regardless of host support.
> > >
> > > This affects discrete devices such as GPUs, NICs and NVMe drives.
> > >
> > > Add an explicit list of the Intel Xeon server generations from
> > > Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
> > > CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> > > restrictions. AMD Zen and newer are already covered by
> > > cpu_supports_p2pdma(), so only Intel entries are needed.
> > >
> > > Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro
> > > B60 cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
> > >
> > > Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> > > ---
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
> > > v2:
> > > https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel
> > > .com
> > > v1:
> > > https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel
> > > .com
> > >
> > >  drivers/pci/p2pdma.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c index
> > > 9334eb314663..2650d605d87d 100644
> > > --- a/drivers/pci/p2pdma.c
> > > +++ b/drivers/pci/p2pdma.c
> > > @@ -21,6 +21,11 @@
> > >  #include <linux/seq_buf.h>
> > >  #include <linux/xarray.h>
> > >
> > > +#ifdef CONFIG_X86
> > > +#include <asm/cpu_device_id.h>
> > > +#include <asm/intel-family.h>
> > > +#endif
> > > +
> > >  struct pci_p2pdma {
> > >  	struct gen_pool *pool;
> > >  	bool p2pmem_published;
> > > @@ -519,6 +524,23 @@ static void seq_buf_print_bus_devfn(struct seq_b=
uf
> *buf, struct pci_dev *pdev)
> > >  	seq_buf_printf(buf, "%s;", pci_name(pdev));  }
> > >
> > > +#ifdef CONFIG_X86
> >
> > Do we really need all these #ifdefs? I'm pretty sure they're not
> > needed for the includes.
>=20
> Apparently we do.  I experimentally removed them and cross-compiled for
> arm64:
>=20
>   drivers/pci/p2pdma.c:24:10: fatal error: asm/cpu_device_id.h: No such f=
ile or
> directory
>      24 | #include <asm/cpu_device_id.h>
> 	|          ^~~~~~~~~~~~~~~~~~~~~

