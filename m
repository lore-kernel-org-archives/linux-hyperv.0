Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794368899;
	b=fDAHVj44PWEjkaZa1UXHJ7FLRZv5O7JVLfAEm/pW7waYAGYJ06cr1VHWgcKx8LNNApeC
	 /Ay9pTBp+NzcZUAkEem6+88+ifVXsjkSki4ZpA7tr3TqDsoNeSXX1ad1ALvabwJIp6qxK
	 vDsNdZlN+aaJ7xvkQ6Vt9AnCyZqJl63iQFBnbk2aphlHByA5/BcLf7yfBBm6SDeRcEDF0
	 IbBhhIRHwsH34IBGgGLDosPACI/uWKBao/r5qekay3FV5XjaRGR3MBKdmNeJF+S+JZwNT
	 1jjoWvkcK+2wjF562G8r22FS00c7HxkV2X4Jmj+YzicmJhXl2XjeYlkLW8xrjTWa3bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368899;
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
	bh=uCevxDM418QrmZYgCQkkzmfw4EsH6dRIdTMwVraAMQs=;
	b=xSN7/78q4AqeMl14sZFp4dI+/ZZUPMAGp4cLSQOcNby5VSuOIznPXEwLbAvHJqEz2GTF
	 6IaZIUXur6n0GPEc5weS904TCCgQycC2ENmik0ZZvpIQhdW978z49Qi/nxS+nINhrq/04
	 41R9SUELdfvQVG/ynEA/ZXJx7aOCL/oIEBh4RFdOoBxB5VSJQruOWv+ux71Z9Ejl/QqcC
	 CwnkrBWqsgzm/qem3XN3BkdZQkw78/4F4nDqVaBKuSvQuqlpYOVMnma98u3gcQ7qWn+pO
	 zd35i5dVgB1rqN0kIBd2o/egck+h6xZvvmsNLzFohHQ/PdQzzfbmuGzky49a00HAjIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cHCdUwTU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F5606A31C;
	Wed, 11 Nov 2026 03:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cHCdUwTU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794368898; x=1825904898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KwC796yR+UNdVPyvhCKYFyFRpV67lDVH6yefLt8KYik=;
  b=cHCdUwTUoq40lUvsRsj1d7ltLqPi7wisktRd1xSUqgjPqA8QiMIn/HWO
   oBHwJk9ZGa+0bbCQ1OgvkidSsTMqFbYGdELIU/gUCPK63SM3ERDoPHnAa
   oo1ZRgBYpmV9iD2b2zwlhPku9a2SN2ANJiRN+lcuNrJaa3mbKV4fY1ZNb
   lTIgQH1Dx/nAFWJsKAC9rt4ZhVbUQJia4apihuOXdnvB/HurgocizdmCM
   9yyzt5JsopgK/WQEYaX+maOqlg3407jxFx2wRSbDKhHlWfHrRrbtmSlwk
   mNLDz3hUdtTU/Y+tm2RDZ7oZAzVSa0izaCZm40h1WrvCllO8gk5FJR24e
   w==;
X-CSE-ConnectionGUID: yltj7UP4T5CYTf71dknOvA==
X-CSE-MsgGUID: jvBOIFEWSGSDoxl6nYOMNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3053302"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3053302"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:48:17 -0800
X-CSE-ConnectionGUID: 9Ofw9iagQ3aR7PM6nVFfYQ==
X-CSE-MsgGUID: 5Qr+MjadQtqJ212L08MZZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10053023"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:48:18 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 19:48:17 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 19:48:17 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 19:48:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r97GhFxpawRfCyU9ndttsUWXiRJWvhfTytB1KGowGsjAstP6sRQwJrla9sVWsh3rHMSyt7sYAwyRZJT7RH07JU+wZYO9vVXEyCQ088R/ee2uDDOE8cBA4SYVeuwRCqr5uDhWcEOLxlkftl6Sjd/iEAPtiTUZKMYJ2Epbh26k+Wfw/ZPs41pejGFv5Mf5xL8PvTrd4EV2o6wy8w+8zeffw7qiULRGgLT5h2Oa5biLSlAQYz3CeeiBWnezuaUgbkdaj3jJcyduEKg6YcUt6vrf6scQwoywT4BvsItlXmMi+dzF6sE8j5TIh1OdpPx3a8fYi9dy5FIoLdSc/WzLKEqSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCevxDM418QrmZYgCQkkzmfw4EsH6dRIdTMwVraAMQs=;
 b=n6vn+J54TRpHB0kth4aTV3VH43DrIPfN4ZEolTbsyfB/CIwh3iNszUbi8GxrUFQkWQGxKRDfcfNq8JD6LS3A+E2BsSQgEUvo4ov+/m7gaDIX9k8EMOATez+XDgAA1sPKXz9JVIr8LVELUQS5JmZKehGXrDlrp+eKE0RF4hzFuRNZRydgffXgpDXb78HmwvWEJAjb2sZXUjfQRyeCMtpSgZxlEHFiBfGe2iDErnHNzfEeUAkwzarJ0P8fjqHEEkt+InYpVZCGnijMcIKZRRTh28yMhl+tQHX6oiM/Sr+LPhzQZ7lt8+Y7hAgbY8XNLeSs+lmlgiQeX9tWI1G7f5RG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by IA1PR11MB8862.namprd11.prod.outlook.com (2603:10b6:208:59b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 03:48:08 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 03:48:07 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>
CC: Leon Romanovsky <leon@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Jim
 Chow" <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
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
Thread-Index: AQHdYLm3Eu3+F6ITg0+VFiHnE2F7qrcoXBEQ
Date: Wed, 11 Nov 2026 03:48:07 +0000
Message-ID: <LV2PR11MB6070064A9E674EBDFB1A3B20B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
In-Reply-To: <20261020173736.81755-1-pavel.e.popov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|IA1PR11MB8862:EE_
x-ms-office365-filtering-correlation-id: 1db2c0c4-1ec1-4e04-6e2c-08df3fa69943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|38070700021|56012099006|10067099003|11063799006|261102123227099003|261026140227099003|261022075727099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info: 8GP47sxzzj4R9B7WEwrGwnFFyzjGc7fWpqaiIF/rni94fPSlR+9Qitc+Go2YArXl8lENu0/MA2oPDQb8hYdueJVZErCK8415S8poXxAC/G/3M1ORj2OkK0KAi6IbRMbSA6yMjUuvhuts0zfqBU4qqtR/9FZgOSBKMeGIQRx5PreSSuHEEGjVOJ/1bbKDXUH/SJvPP9SXH/GuOlcfcbr+W/w285ZzMyEz4CSpGKyebXI5SO3wOth+SaI7wkos4bE31GTCngbqRYoJfgYo+FMv5YKRZhyqgaqbTmUEvddbWUKHBj35O65mBS8QsjxjoFVXnI114XKPW636SJSAjnVO8K3zEp2c0Rpgx9O4t+r+n0RVFDaif6+0bKX65lxX5In4asY9FLfwr7Tu8bLAeZSJ4BxNAgP6S0/8s+mMpfYQrw3xcaacHJiqiUjnfavGcRnbbV/WMaPpw02bbk3Fft3hNg9v6CPFq5Qimi/0pvvDlIf9tIbUgB0OiM0eSUD2+Fb0Du3RqmdGESLnLtJhfEpr0ZWsiO5VriM1KTEkWBh6nV2QMEmUx5TqHaJznKjnOfZzLCL5/CtzmGAjtjK8oeFDOvcEGaofIc3WeoPrnboizlBOEP/ZVvTWABYY0mVsVFy6RGUNOfi+0LoRxA2hKRUOcSAoBKNjdaIV1hPfd8nas9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OX1GkMZyipFeaxVrloWIxBo/UOpj3BUT/5M3ii2azPrbVGevhPe0J5rMhhUy?=
 =?us-ascii?Q?WZx3hVvCsRtQOtFwUjLgaP8CRhoAVjX5B2oyGwT9osGIKQ5x6B3LKhEecxqS?=
 =?us-ascii?Q?CSzu6oUNBefG/QGroy7sSsYrf6TBlyfgZcelLshsdjYTUXBt5/3cWk0uNWW6?=
 =?us-ascii?Q?Q5FeRo+Y4OP1nBW1dmymZIMNHY6iGqLCEvnuVv5/cpskfxuDt+moBnVM64Mt?=
 =?us-ascii?Q?rHGYS/vu2wrZWjWTgWuHAlrhrbf2AJVkJGFAPdLYn3vkl8tfam12ctEdC/QM?=
 =?us-ascii?Q?1H7+hn0tiyE5UffZhd3fUKxvktwyrYsaJBNmaXHZWM4gXWy/eiBzU8Amg+NG?=
 =?us-ascii?Q?1RH33qSuZPVCxSHLPXyMEcL3KCCO++5e80NW78Ps28aG8AX7Qa1Si6YtMUPG?=
 =?us-ascii?Q?o7ooDZ6OO2C66gtA6ZEt8MXmyK4UYLCare5awCCsfW82G+WZsJDYY5weL6Pz?=
 =?us-ascii?Q?4zMJ91LS6b5xMTKBdxYDtXQQHUm2jFfwv6yFzurpjmg3ut/XCTRE2UqTkZN9?=
 =?us-ascii?Q?qFnLDl6q/4q3KbeCrAAFzWOV5m/m9mC9MqsBrsQHkdlcJHd9AgeWEjaQJtdp?=
 =?us-ascii?Q?qKa9mz6rmh8LYBDdpAlRwQJmzGox7YIpVak33t9EBVW2Qx+ugtV2zMD6Ot74?=
 =?us-ascii?Q?jJNJU5EcXhXJtOWQF/vWIwnYvA1HdzqDeK1byVezUWCrv1n41tz5Bfs3l0mo?=
 =?us-ascii?Q?c+nl+HUve/qhcjRcOKmkES+WE+w0Ab1p9SFkZzTrnNVi+0StddQjToHuDIII?=
 =?us-ascii?Q?I/0EV8unnMmsxAaQBY7F7YfM+0KdqPsi4ob0toe4L3oZMZnKXhXyG8yxjhLa?=
 =?us-ascii?Q?ypTmmp5BTwaozVZKEz9yoxcmyyDnexSjy5O+uDjll3jXir4YKLruk0kvSoT7?=
 =?us-ascii?Q?E2EFfbdgKyg03jVlFGUID7KPQws/LHTJZEprhRnKPgLsM64Av2dI4BznOlI6?=
 =?us-ascii?Q?BteNERA8jsAHN9o4oWJ7Tj/yeDEWa13lqQ9mma1GKfXdVlkuNREoLODpFGpv?=
 =?us-ascii?Q?YCamyCG7MhFe5T3/p5fit9YGA3nDc21vkBdjlpl8KW4AgJ1eRY6SUUuCuop+?=
 =?us-ascii?Q?yQiPUken2tkA0hDkY0E4Ef/103l6NyPEksBaBnLKiAb24IbuBBtPnHpK8W1K?=
 =?us-ascii?Q?6RdX7oi10x42aoBNlNzSq/WRwvWFkCXgsDvPa9zgwPZPbhLRq2JTNS35Z6AD?=
 =?us-ascii?Q?RFCkcU97A/FNzCwJoU9p4j73XN4cQmTn6kLMYfw43y4OgAgAh/MquZLU2S2C?=
 =?us-ascii?Q?Se1PGOcWl6MehXvw3oJrIPf0D00azrNISDJyv+dCkOaDF08gtWx/lmH+aAA+?=
 =?us-ascii?Q?FweGVaX767Se4aTQs/6aAWq0Ut+BD1xZMbwczwv8HKhF5VFmpsmEEfENHvbZ?=
 =?us-ascii?Q?7dvhi/JW6UpwEbAhVp0hQ8ggOqJ9DuP09XoEc8ZphsM8eUWevdJDV3elaBY4?=
 =?us-ascii?Q?pn4I/HkD4TXg8e+CFy4k4QurD1gu9ubkwRw2K0JcIVuRT96weAUwUGFNRYBM?=
 =?us-ascii?Q?18IlUgRB5q0Hs6Fbn5tdwywK4aoZENVn+vxf/ZHESqBUXmQHGogr7gF355/Y?=
 =?us-ascii?Q?t/oVa7NVE4bQSwHGamBcCjKRnSqYr1FcmPaiO37dXXPrN4mCM+A0dLWt974h?=
 =?us-ascii?Q?KoYxfFDmId3qEQhe0TsRk5jGd1yuVIns9QUI+Gap1DQMhnTAXj/DyW+Vq9qL?=
 =?us-ascii?Q?RfjrSMj/hm/chz8nRvmfpaTM6C73HbTulZkEv349Zb+hLrON9D7nng6z5+yn?=
 =?us-ascii?Q?IlcdbYdTMg=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: Er0OA4n7vXppj04Cm1SuqldWRbsRePJnfyhSV+8Cbzu7/oGt5poVSd9nWb08ImLeqEsJ8UqcwJHO2uQeM0ny+rmRv1AS/n1aBbckECKsyJqO96ayROaAj3tr7CJDrkHjbbpiNDPH+s5t7AKR/ojRQkYa4xqrU8OOWu/69XGWpHSKb+8TaHvcayzxKoP99kOwS6pxZ/D/gtcF3JE+UDGtrEdzu3ulPsKZEsEt8SYSTKBZJYD9e0iOq0U/51Xs9HGJYrF+rUgZDP+th3J9AqeTUG2S37Pb5vSzvjqphsUm2ieMl1ZnWZGRQGF6B4Z07Gm/kgEv2QtjY5gtxbxCcR97VA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db2c0c4-1ec1-4e04-6e2c-08df3fa69943
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:48:07.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB40tsq84KeQwkzfYFCT71fwOqR0cUrQoslp+rfrOJHKPhkcJq6A570YWqf+PIJk+RBn6nihqvGtasaUrWXVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8862
X-OriginatorOrg: intel.com

Hi Bjorn,

Gentle ping on this series. Is this OK for v7.5?

Thanks,
Pavel

> -----Original Message-----
> From: Popov, Pavel E <pavel.e.popov@intel.com>
> Sent: Tuesday, October 20, 2026 10:38 AM
> To: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> <logang@deltatee.com>
> Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Leon Romanovsky
> <leon@kernel.org>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> <jim.chow@broadcom.com>; Radu Rugina <radu.rugina@broadcom.com>;
> Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Nathan
> Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> list@broadcom.com; virtualization@lists.linux.dev; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
> CPUs
>=20
> VMware and Hyper-V expose passthrough devices to guest VMs without an
> explicit host bridge device. Consequently, host_bridge_whitelist() cannot
> automatically identify the underlying host bridge structure, causing Peer=
-to-
> Peer DMA (P2PDMA) requests to be rejected unless the device IDs are
> explicitly listed in pci_p2pdma_whitelist[]. To enable P2PDMA on Intel ho=
sts,
> this series extends cpu_supports_p2pdma(), which so far covers AMD Zen an=
d
> newer, with an explicit list of Intel Xeon server generations.
>=20
> Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by carried o=
ver;
> the Xeon list and the check are unchanged.
>=20
> Changes in v4:
> - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
>   (Logan Gunthorpe, Leon Romanovsky)
> - Keep the #ifdef around the asm/ includes, as these headers exist
>   only on x86 (Bjorn Helgaas)
>=20
> Changes in v3:
> - Drop the hypervisor check and move the Xeon list into
>   cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
>   Gunthorpe and Leon Romanovsky [1]
> - Fold the VMware and Hyper-V patches into one, as the check no longer
>   depends on the hypervisor
>=20
> Changes in v2:
> - Replace the Skylake-and-newer threshold with an explicit list of Intel
>   Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
>   Gunthorpe)
> - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
>   (Logan Gunthorpe)
> - Rebased on current mainline
>=20
> [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
>=20
> v3: https://lore.kernel.org/r/20261020151305.65218-1-
> pavel.e.popov@intel.com
> v2: https://lore.kernel.org/r/20261016223402.19991-1-
> pavel.e.popov@intel.com
> v1: https://lore.kernel.org/r/20261009154034.82321-1-
> pavel.e.popov@intel.com
>=20
> Pavel Popov (2):
>   PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
>   PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
>=20
>  drivers/pci/p2pdma.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>=20
>=20
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --
> 2.53.0

