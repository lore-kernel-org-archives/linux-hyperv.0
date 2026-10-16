Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2C3BE643;
	Fri, 16 Oct 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179908; cv=fail; b=hyJUYalY3wA545Cz2sYT4sTGHuA0y/bGqOqWt3eZ85Ds0X6EBJHYAbjk8pcDgEFBscTdg06Ff9dWUK+CJXcCxOODXTMXwhsFUB72SZx6H/oSdZg9237b+kJ72JRIxPxja8n/DOdVe/0GgY608OtIIFYVQVjfj12TU2hXbwwW9FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179908; c=relaxed/simple;
	bh=i5PZ8PKkrrNpUQtpBkHTIw5aJzogrG84Dz0tfASAR3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wr7mauu715lYhizHI3TkWIVHyFltyozaxIIzMwRjl6Du4+upGZ1GdpSqVDuUqNlCrv86FLZYhH3Os42l1E392kL49FylCBlI4dIAo6qao8KcgxYM+cu2JsGlQtMJ3uDUF16vzkldG8UtKwJPK6elzyKCXUdY9CO3LoKxRGFbfB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLbZJUB2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLbZJUB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792179905; x=1823715905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i5PZ8PKkrrNpUQtpBkHTIw5aJzogrG84Dz0tfASAR3s=;
  b=CLbZJUB29DaJx64OWMNL4+/oRVzTzyIYzd13ks5KC/yhCA/MxsQgQPZw
   rc5Dja5j5mwObtzBgXGFBTMIBjwxcowP4ZthBxeiGrRxRXQPUj9I3I9RR
   v1p8+sskmv5hhz/dgfvjbabO+VPQ9/3tIlMkE6aam+PpKns85BUEdFZfa
   tW1XNOS/gi3Gx6TA4grpCLBW5Yj4Et3PbfGa3l39PNruYJTicdn89oE8k
   v9BVdfBi6Td1dg34+KCOEne3zqI37tY/aEgaQrPM4vrTcUxI6bgFtL7xL
   5ZVPnngL8dM8le5eobpNm22s/VdM3Wme0wMNY5zFbyoif5M5tsd19wIeB
   w==;
X-CSE-ConnectionGUID: K09xdTpLRXyNZs5pImsLpA==
X-CSE-MsgGUID: U0WYgt4lT86jtyJ598IT7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="1071341"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1071341"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 12:45:05 -0700
X-CSE-ConnectionGUID: rkNTldnuQ6ar0FC29gvong==
X-CSE-MsgGUID: M0oQVy9YTJ+Cakyj+1lgVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1908194"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 12:45:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 12:45:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 12:45:04 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 12:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItuNYHsN717mNVKNYGGkXAukw+d6ITV/OlV+cm1ZdTmWCJAc6mGPo1+ax92zFpy5VDk7pOfppPNWzvgtYEiKtuk5YjC6pebi13k2frZHimcBpPXa3CKjgIfb7hS10QHrHsbBttCR5cu9hRVx4EbN8MHGjz/z2HkTlwrDjeFFk+i5+9xtfvbAE/IFZJSFFZETQas2dxXvcI2S04O6tULAMSzKPRVjPwOOf9V4Z0WGH64Q+ASvWTtEuusGPAI4/C4Mcdn7kWsphs3OEIuOrIIbFWjmWbHMyrBi77kMnzsWeKdU1J/3c9QrmHxZ6uw1K+aztgCEQCzP12os3fxkFjeMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5PZ8PKkrrNpUQtpBkHTIw5aJzogrG84Dz0tfASAR3s=;
 b=kSwSAphdt4akxbxdAdDA9HaWizpzhzHnadm2xoJN1Ric90kQ8QhDLPXV2FQkOtAk3Y41wcSGk+hng7JnMIBkQuPe1VqewirNdw5nm+ZNrc7zbItZP/bAd20z7xdMgAN5YDJgcgaWiXCPIEaCt2+nlKpae02lQq45c1H7aSOevkp2FbVMf4V8oxrGyvc71/7MOPLDm59VW9oDh4/QKG/tcdLfhxQs9GOtWmJfrVJVMAQ1L27tnOhdczok1dgXASkStrswQZlZatTUwGSeDntsc6IMbHaEFA5cBqCJa3WUc9WL+TyK8K1AUBZICtdSFKtIu1F2aZq9rJXy7UKft1lVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 19:45:00 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 19:45:00 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Leon Romanovsky <leon@kernel.org>, Jim Chow <jim.chow@broadcom.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, "Lukas Wunner" <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, "Nathan Ciobanu"
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
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iCAAkgrAIACGMTQgAArlwCAAACJAIAAIDMAgAAQuKCAARyrAIAE4THwgAALYYCAAAPDQIAAKsUAgAAVHRA=
Date: Fri, 16 Oct 2026 19:45:00 +0000
Message-ID: <LV2PR11MB6070A3BB8BCB592EDFAFC261B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261012182120.GJ219304@unreal>
 <DS7PR11MB60647FA80C6BE1029982222DB29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261013122002.GN219304@unreal>
 <LV2PR11MB60704D89055FBC471FF81B31B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261016153147.GC219304@unreal>
 <LV2PR11MB6070D328D5E6A538DB6370B2B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <006effed-576f-4aed-b3ac-c335d8d51106@deltatee.com>
In-Reply-To: <006effed-576f-4aed-b3ac-c335d8d51106@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|PH8PR11MB7992:EE_
x-ms-office365-filtering-correlation-id: 51044823-02bf-4194-1afb-08df2bbdf6e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|18002099003|22082099003|10067099003|11063799006|5023799004|261009220027099003|261009223027099003|261009223327099003|261009221727099003|261009221227099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: ljdK1vbh60KpdmcPeIhPxQVXewZWfpcMdRV7A4dkLfqUkVRGfPgJbcRjT7Nultz1YU1w3l/jGf3wF9z5OFQPnPlALzbawIbEspaamq4hLr/516I3IqRKtOUoVXqIQPDa5VnYvu7rasfVW5kbl0cZzTDuucthbn6DSyZsJGPPv/WLyhUeeljDjpz6rP6TpuwxeDrdAV4gqAEIbNaxlJKD3/hZxe7SHRKvx2Tm+5U7AsEouhElFBcafHXM/BfM2BoYGUoy/5jNp9ZeRE5fm5pOvQXBkUiLkVp0UGZXncjuOTGGQgqFFfJX+1fY9v69/tTMPlZWm12ILwgoEnGWfLsgYJ4q1YiDphkvx/bCWJ9sviQKq5u5tQVIYiIoZbk5D4tengJG0tNE00ZLbQ1rNAaiBFYJ4YmIOoTXVXpzv37l5hm6wplwqfT4uatr4yIffqWi7IJhwD+xP5RFmlPS9GpBanMWf0rtUhewjK1AWsr/Hq0k/QWkZWnnQGku4IDjfHryPe+1lFhDz++oQa4uxNxe2eEHqcVgWt6TMbbV8WSKlRgshEYurV1oMJNeI6SYXKUOtFDiiR4qftybxJ9KPMIK8A2SuM9LUCKwfRdA1Q/9szSHm/M2htBcVz4n2fMpbe/y8z3fU8kohTJG/R5KZJopfyQCLsE3IarrdeCtEma+IwiCCd0t9/QV4tki95gCblX7rzwQJxNkdW7HwjOmJBc+BnfXxTRAI0htmiHwLYuo56Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V21ETHd3MHBxUkJYOTdBejJqMXdJMG1XUWRjRWM4Z3o4ZDRodVZrMDl1dk9P?=
 =?utf-8?B?ZHlWR0NocW9ISTlMRmJCTXBDUXAzZGM1WHZaYStSYUQwWm5BbGphTFFOVyt2?=
 =?utf-8?B?Rzlqdi9tMHkyUEIvNUdrcDBGN1pnaFhISHNDZGZVQjB5QXpuWGxURER1L043?=
 =?utf-8?B?citobnVMWWZ5UDN3dDMySThJQlptdlF4NkszWGxFWnhUSk00TUdNN3RrOGgr?=
 =?utf-8?B?bXF4UVJhcHFFNmtHRFJZNUVEeUJybzRxdXJEd0liaFhaOTlwbXZublVBRjVu?=
 =?utf-8?B?YzJOWklGS09zUjB5NEFjS1c1OU5HZGtFbUpnS0luajdNYkltT001Q3BuRnNL?=
 =?utf-8?B?ajJLQnZrMGFnZkN3Rnk1RzRJZUV5dk1PMFpkWWxTMDJzVHpGa001UjMwRmNQ?=
 =?utf-8?B?MXZiazV2YnYyKzJWT2Nram5SOExjb1ZYU0hDWTZPUlJTY2cwUGNSdUsyb012?=
 =?utf-8?B?REJDT2RXMTBkUXlhbWNhRzRXL3pTbHVGbGtZY3dLNmNTWGpHdjNlMFdldGRP?=
 =?utf-8?B?V0owYlNKTGNlYnl4TFZkZDQzSkp1aWFwUTUrQzVVWmdlVldQMnFJNGIyU21y?=
 =?utf-8?B?cEszQ0lKTU5jR2lWQjc3MzBVckNUMGtkSmg5OEVsZHdIcTVoTDRPbVVNZFgz?=
 =?utf-8?B?ZFI5TDBrRStTNjh4dmtDUy94TTcrUGZ5eWY4LzVrNlVaQVpJRENWbm5BKzYv?=
 =?utf-8?B?VnRNSEIwcFhFaGUzcS9ha0JrNjZMTisvOEsvNFg2SDlVTmd2dWhlc25pdjN6?=
 =?utf-8?B?Sm5CanJtUk5UMm1Cc3NZMitoVDZXT2pvL2dUUlh6VXVWTDlWbE1rZ3l5bmlx?=
 =?utf-8?B?OTg5REs1ZVZCNm1JN3ZPL2x2SFEyaEh0VFdBVnBnc3JsdGIyemYzRFVTTmx2?=
 =?utf-8?B?dHA4MjBUbENJdmtrcDQ1V05mSDhQWlpzbzZ0UEdqc0crTUhtRXpNNkhSUWJm?=
 =?utf-8?B?TjRwb0JjZnhCNDVZTlVKbCt0bWJRSkpKY1h0SDF2U2xmVXJoUjFDYVAwS1cx?=
 =?utf-8?B?enE2SEkrQS9teUlmbk9SN3ZTVkdzWEtiUm5NVlgvUmFYM2gvSFJNWlA5Z28r?=
 =?utf-8?B?VmdLYlFxUWszVGs4SWY1TVVxZ25TdmpUTmZBTmJza2VCMEV4WXdpbmF3dGpz?=
 =?utf-8?B?ZFljelo4dE5LVU1FUC94TFIzclJlTzVUYlh6SGFBdHpGMG9BUGFOb25IMFRL?=
 =?utf-8?B?Wmoyd1BybEsvTXBrQXNOcmwwSlhMUlY1bVJyVTRzNlBDOTIxc0hEMnJoU2FX?=
 =?utf-8?B?MENUb1luQjkrd1pqSUVDMzVVYnFZaGJrVFNaT0Noc283eG9uZjJWQlNkeFFE?=
 =?utf-8?B?bDA3SlJtZDFKM3R0RXVQdWhTTS9Ja2NiMUczRm9aRlJIeE5yOEFKaFZXY1BN?=
 =?utf-8?B?YnZ6b2p4enowcUVka2d5SkYrL3pyRzR3SFNvdS9STDVpOUcvOTZzSTFZcTEy?=
 =?utf-8?B?engycEphaW9GUUNRZnRRcmlkRDdKUno0djF6eFltRTE0V3YxNFJ6cTRoY2VD?=
 =?utf-8?B?YUVjVkVmM0dqTkZpNms1aitnRjk0Q25RM2N5R2pMTm5zSmN6cUE0eWREd3J3?=
 =?utf-8?B?cndQVGtiNmZLTnNaKy9GQlBieWNMZHhkWDBmV0lWQ1dPYWx2LzEzRlluNzdu?=
 =?utf-8?B?SVQ1QkU4Q2VFbkUzMDg3QUd5WjlLRC9mQXNVbEkrc3JEMnM1MzBGZEFRYUNB?=
 =?utf-8?B?bkVuaWhHMXM1OXkzNUxiV1RiakQwQ1dkQXJ6YzdPVWdVL0x1ckd3UmNhRTg0?=
 =?utf-8?B?ZXVLYmVCbkFUU3pmQURzQUk2SUJlcTU1Vy8yZ2w5NTNtQk5qb1U5Y2crWFp2?=
 =?utf-8?B?OFdKanZZa2NjSEZoQXFXNWlsVjFZWkMxU2FzbktBUUVhQzBXQThOM1hRWWUw?=
 =?utf-8?B?RjFZUWhHOXljL01EWDF5d25hZEdmeXB3Z1JkL0dGMHd3bjBQY3VndDU5UHJu?=
 =?utf-8?B?S1RVbXBRLzd2L1NRR0sxaWNNWGZVZDlCd1pxYU1oV0s0ODZMNG14WVhMZ29N?=
 =?utf-8?B?dHljNklXenVpVTAzdVQ2anVIVmVyYlhrckUyRFY5Y1RmZXFSN3FMQ2dwdk5E?=
 =?utf-8?B?a1N1WDNtRHJVbUJveGRiRGl5ODBCMG5hUS9WejhHYlAyZ0RVZDhjczRtSEhC?=
 =?utf-8?B?ckgzbWZYeDNIdWhndmYyZS9oYVh0RUJIcWtTbE1ZYVVFZ3FtemY4RHovc3c5?=
 =?utf-8?B?TkE4NjVSTjBQT3c1dkFnZXJaNmhXQW5wQkQ1blpJUTYxVDJ5K0psRGZWM3hl?=
 =?utf-8?B?R3hCVUhLdjRSbTQ3a1BQdGs2bEhBUTFWMHBRWEpCTUh6NEs3YmxQQStqKzdo?=
 =?utf-8?B?bXBOM0NJWjJRVEdnTHJ3eVd4VTdJV2NPd1RwR0c5amdSOU44UTlLUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jfqU43wXWgSjQf9lZD57lo9Ky0bV8/fcD/u1E+sDwHGFmJS7P1hp8uAGE3dni+u/q9jFwbX8zKGWhWNSeoP/DQ5XIoX1PjPQiEwahWptLXRbQTWLuWFHIl5C1Jr/p/+4H9SjPtZCu/Oj0aB4Vom/SWv2ixxxNi0nUUvM5hfllinjCBvJ7oKY2sg8ZkdVecXSEFZ9r8RbVL3+/Nr1+bMnHdqM/3TRyfVcjrhbdlnN8iaMKHyj+qWm94SlgOUwrZ8WTqkioju72d+ywsnBFwT0HgD2K4vFzPVZt+lwgdqT3QAyvr3a7VJd5xqSaAAOhdMhPVOc/FH/u0wpwrAgosqVZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51044823-02bf-4194-1afb-08df2bbdf6e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 19:45:00.0658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvZCJ7XJ4HD1QhXEdiRJKAG/4VK6fhmi5CaWGp0MrmjRKNLNdaiZk0HD+D57pTtO/UZuZLXs0VAcPRHF7w1GlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com

TG9nYW4sDQoNClRoZSBpbnRlbnQgb2YgdjEgd2FzIHRvIGF2b2lkIGFub3RoZXIgbGlzdCBsaWtl
IHBjaV9wMnBkbWFfd2hpdGVsaXN0W10NCnRoYXQgbmVlZHMgZXh0ZW5kaW5nIGV2ZXJ5IGdlbmVy
YXRpb24sIGFuZCB0byBsaW1pdCBpdCB0byB0aGUNCmh5cGVydmlzb3Igc28gdGhlIGV4aXN0aW5n
IGJhcmUtbWV0YWwgbG9naWMgaXMgdW50b3VjaGVkLiBFU1hpIHJ1bnMNCm9ubHkgb24gc2VydmVy
cyBjZXJ0aWZpZWQgaW4gdGhlIEJyb2FkY29tIENvbXBhdGliaWxpdHkgR3VpZGUsIGhlbmNlDQp0
aGUgc2ltcGxlIFNreWxha2UtYW5kLW5ld2VyIGNoZWNrLg0KDQpPbiBkbWEtYnVmIHBpY2tpbmcg
UDJQIHdpdGhvdXQgdGhlIHVzZXIgYXNraW5nOiBQMlAgaXMgZW5hYmxlZCBvbiBFU1hpDQpzZXJ2
ZXIgaG9zdHMsIGFuZCBzbyBpbiB0aGVpciBndWVzdCBWTXMuIEEgInllcyIgaW4gdGhlIGd1ZXN0
IGlzDQpjb3JyZWN0IHRoZXJlLCBhcyBvbiBiYXJlIG1ldGFsLg0KDQpJZiB0aGUgdGhyZXNob2xk
IGlzIGEgY29uY2VybiwgdjIgY2FuIHVwZGF0ZSB0aGUgaHlwZXJ2aXNvciBjaGVjayB0bw0KbWF0
Y2ggYW4gZXhwbGljaXQgbGlzdCBvZiBYZW9uIFNjYWxhYmxlIGFuZCBYZW9uIEQsIGZyb20gU2t5
bGFrZS1TUCB0bw0KRGlhbW9uZCBSYXBpZHMsIHNlcnZlciBwYXJ0cyBvbmx5Og0KDQoJWDg2X01B
VENIX1ZGTShJTlRFTF9TS1lMQUtFX1gsIE5VTEwpLA0KCVg4Nl9NQVRDSF9WRk0oSU5URUxfSUNF
TEFLRV9YLCBOVUxMKSwNCglYODZfTUFUQ0hfVkZNKElOVEVMX0lDRUxBS0VfRCwgTlVMTCksDQoJ
WDg2X01BVENIX1ZGTShJTlRFTF9TQVBQSElSRVJBUElEU19YLCBOVUxMKSwNCglYODZfTUFUQ0hf
VkZNKElOVEVMX0VNRVJBTERSQVBJRFNfWCwgTlVMTCksDQoJWDg2X01BVENIX1ZGTShJTlRFTF9H
UkFOSVRFUkFQSURTX1gsIE5VTEwpLA0KCVg4Nl9NQVRDSF9WRk0oSU5URUxfR1JBTklURVJBUElE
U19ELCBOVUxMKSwNCglYODZfTUFUQ0hfVkZNKElOVEVMX0FUT01fQ1JFU1RNT05UX1gsIE5VTEwp
LAkvKiBTaWVycmEgRm9yZXN0ICovDQoJWDg2X01BVENIX1ZGTShJTlRFTF9BVE9NX0RBUktNT05U
X1gsIE5VTEwpLAkvKiBDbGVhcndhdGVyIEZvcmVzdCAqLw0KCVg4Nl9NQVRDSF9WRk0oSU5URUxf
RElBTU9ORFJBUElEU19YLCBOVUxMKSwNCg0KVGhhdCBpcyB0aGUgbGlzdCB2MSB0cmllZCB0byBh
dm9pZCwgYnV0IGl0IGlzIGJvdW5kZWQ6IHRoZXNlIGFyZSB0aGUNCmdlbmVyYXRpb25zIHdob3Nl
IGhvc3QgYnJpZGdlIGlzIGFscmVhZHkgd2hpdGVsaXN0ZWQgb24gYmFyZSBtZXRhbC4NCkEgQ1BV
IGxpc3QgY2Fubm90IHJlcGxhY2UgdGhlIGhvc3QgYnJpZGdlIHdoaXRlbGlzdCBvbiBiYXJlIG1l
dGFsLCBhcw0KdGhlIHR3byBkbyBub3QgbWF0Y2ggMToxLCBzbyBpdCBzdGF5cyBiZWhpbmQgdGhl
IGh5cGVydmlzb3IgY2hlY2suDQoNCklmIHlvdSBzdGlsbCBwcmVmZXIgdGhlIGtlcm5lbCBjb21t
YW5kIGxpbmUgb3B0aW9uIHlvdSBzdWdnZXN0ZWQsIHYzDQpjYW4gYWRkIGl0LCBwZXItZW5kcG9p
bnQgb3IgZ2xvYmFsLiBJdCB3b3JrcyB3aXRob3V0IGEgcGF0Y2hlZCBrZXJuZWwsDQpidXQgcHV0
cyB0aGUgYnVyZGVuIG9uIGV2ZXJ5IFZNd2FyZSB1c2VyIHRvIGtub3cgYWJvdXQgYW5kIHNldCBp
dCwNCndoZXJlIHYxIG9yIHYyIGp1c3Qgd29ya3MuDQoNClRoYW5rcywNClBhdmVsDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdA
ZGVsdGF0ZWUuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMTYsIDIwMjYgMTE6MTggQU0N
Cj4gVG86IFBvcG92LCBQYXZlbCBFIDxwYXZlbC5lLnBvcG92QGludGVsLmNvbT47IEJqb3JuIEhl
bGdhYXMNCj4gPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gQ2M6IExlb24gUm9tYW5vdnNreSA8bGVv
bkBrZXJuZWwub3JnPjsgSmltIENob3cNCj4gPGppbS5jaG93QGJyb2FkY29tLmNvbT47IEJqb3Ju
IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBSYWR1DQo+IFJ1Z2luYSA8cmFkdS5ydWdp
bmFAYnJvYWRjb20uY29tPjsgQWxleGV5IE1ha2hhbG92DQo+IDxhbGV4ZXkubWFraGFsb3ZAYnJv
YWRjb20uY29tPjsgV2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPjsgTWljaGFlbA0KPiBLZWxs
ZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPjsgTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+
OyBSYWZhZWwgSi4NCj4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBOYXRoYW4gQ2lvYmFu
dQ0KPiA8bmF0aGFuLmQuY2lvYmFudUBsaW51eC5pbnRlbC5jb20+OyBiY20ta2VybmVsLWZlZWRi
YWNrLWxpc3RAYnJvYWRjb20uY29tOw0KPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC5kZXY7
IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MC8yXSBQQ0kvUDJQRE1BOiBBbGxvdyBQMlBETUEgaW4gVk13YXJlIGFuZCBIeXBlci1WDQo+IGd1
ZXN0cyBvbiBJbnRlbCBob3N0cw0KPiANCj4gDQo+IA0KPiBPbiAyMDI2LTEwLTE2IDEwOjA1LCBQ
b3BvdiwgUGF2ZWwgRSB3cm90ZToNCj4gPiBCam9ybiwgTG9nYW4sDQo+ID4NCj4gPiBMZW9uJ3Mg
cG9zaXRpb24gaXMgY2xlYXI6ICJOQUsgdG8gYW55dGhpbmcgdGhhdCBkb2VzIG5vdCBmaXggdGhl
DQo+ID4gaHlwZXJ2aXNvciBmaXJzdCIuIE5vIGNvbmNyZXRlIGZhaWx1cmUgd2FzIGRlc2NyaWJl
ZCwgYW5kIG5vIGNoYW5nZSBpbg0KPiA+IHRoaXMgc2VyaWVzIGNhbiBhZGRyZXNzIGl0LiBUaGF0
IGxlYXZlcyB0aGUgZGVjaXNpb24gd2l0aCB5b3UuIFR3bw0KPiA+IGZhY3RzOiBBTUQgZ3Vlc3Rz
IGdldCBQMlBETUEgdG9kYXkgYW5kIEludGVsIGd1ZXN0cyBkbyBub3QsIGFuZCBITUFUDQo+ID4g
ZG9lcyBub3QgZXhpc3QgaW4gTGludXggeWV0Lg0KPiANCj4gWWlrZXMsIG9rLCBJJ3ZlIGZvbGxv
d2VkIHNvbWUgb2YgdGhhdCBsb25nIGRpc2N1c3Npb24uDQo+IA0KPiBNeSBmaXJzdCB0aG91Z2h0
IHdhcyB0aGlzIGRpZG4ndCBzZWVtIGFzIGJpZyBhbiBpc3N1ZSBhcyBpdCBzZWVtZWQgYmVjYXVz
ZSBpZg0KPiBzb21lb25lIGV4cGxpY2l0bHkgdHJpZXMgdG8gZG8gYSBQMlBETUEgdHJhbnNhY3Rp
b24gaW5zaWRlIGEgVk0gYW5kIGl0IGZhaWxzDQo+IGJlY2F1c2UgdGhlIElPTU1VIGJsb2NrcyBp
dCwgdGhlbiB0aGV5IGp1c3QgZ2V0IGEgbm9pc3kgZXJyb3IgYW5kIHRoZXkgc2hvdWxkbid0DQo+
IGVuYWJsZSBQMlBETUEuIEV4Y2VwdC4uLg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgZG1hLWJ1
ZiBwYXRocyB3aWxsIGVuYWJsZSBQMlBETUEgdW5jb25kaXRpb25hbGx5IGlmIHRoZSB0ZXN0IGlu
DQo+IHF1ZXN0aW9uIGFsbG93cyBpdCwgd2l0aG91dCBhbnl0aGluZyB0aGUgdXNlciBuZWVkcyB0
byBkbyB0byBlbmFibGUgaXQuIEkgdGhpbmsgdGhhdA0KPiB3YXMgcHJvYmFibHkgYSBodWdlIG1p
c3Rha2UgYnV0IEkgZ3Vlc3Mgd2UgaGF2ZSB0byBsaXZlIHdpdGggdGhhdCBub3cuIEl0IG1lYW5z
DQo+IGVuYWJsaW5nIG5ldyBoYXJkd2FyZSB3aXRoIHJ1bGVzIGxpa2UgdGhpcyBpcyByaXNreS4g
SXQgbWVhbnMgZXZlbiBhZGRpbmcgYSBnbG9iYWwNCj4gcnVsZSBmb3IgSW50ZWwgbGlrZSBBTUQg
aXMgcmlza3kgdG9vLiAoQWx0aG91Z2gsICptYXliZSogZWlnaHQgeWVhcnMgYWZ0ZXIgSSBmaXJz
dA0KPiBhZGRlZCB0aGlzIGNvZGUsICB3ZSBjYW4gc2F5IHRoYXQgdGhlIHZhc3QgbWFqb3JpdHkg
b2YgSW50ZWwgQ1BVcyBzdXBwb3J0IGl0LCBpbg0KPiB3aGljaCBjYXNlIHRoZSBkYW5nZXJzIGhl
cmUgYXJlIG92ZXJibG93biAtLSBidXQgY2FuIHdlIHNheSB0aGF0PyBXaGF0IGFib3V0DQo+IGF0
b21zIGFuZCB0aGUgbGlrZT8gV291bGQgdGhlIHJ1bGUgbmVlZCB0byBiZSBjb21wbGljYXRlZCBi
eSBhIGJpZyBtb2RlbCBsaXN0Pw0KPiBUaGVzZSBxdWVzdGlvbnMgYXJlIHdoeSB0aGlzIGhhcyBu
ZXZlciBoYXBwZW5lZC4pDQo+IA0KPiBTbyBJJ20gaW5jbGluZWQgdG8gYWdyZWUgd2l0aCBMZW9u
IG5vdyB0aGF0IGFjY2VwdGluZyB0aGlzIHBhdGNoIGFzIGlzIG1heQ0KPiBpbnRyb2R1Y2Ugc29t
ZSBwcm9ibGVtYXRpYyByaXNrcy4gRm9yIG5vdywgbWF5YmUgd2UgbmVlZCBhIGtlcm5lbCBjb21t
YW5kDQo+IGxpbmUgYXJndW1lbnQgdGhhdCBjYW4gZXhwbGljaXRseSBlbmFibGUgYW4gZW5kcG9p
bnQgb3Igc29tZXRoaW5nIGxpa2UgdGhhdCBzbw0KPiB1c2VycyB0aGF0IHdhbnQgdG8gdHJ5IGl0
IG9uIFZNd2FyZSBvciB3aGVyZXZlciBjYW4gZG8gc28gd2l0aG91dCBuZWVkaW5nIHRvDQo+IGJ1
aWxkIGEgY3VzdG9tIHBhdGNoZWQga2VybmVsLg0KPiANCj4gSSB3aXNoIHdlIGNvdWxkIHJldmlz
aXQgdGhlIGRlY2lzaW9uIGZvciBkbWEtYnVmIHRvIHVzZSBpdCB3aXRob3V0IGFueSB1c2Vycw0K
PiBleHBsaWNpdGx5IGFza2luZyBmb3IgaXQuIEJ1dCBJIGRvbid0IGtub3cgd2hhdCB0aGUgY29y
cmVjdCBwYXRoIGZvcndhcmQgaXMuIElmIHdlIGNhbg0KPiBhZ3JlZSBvbiBhIGJ1bGsgcnVsZSBm
b3IgZW5hYmxpbmcgSW50ZWwgQ1BVcyB0aGF0IG1pZ2h0IGJlIGEgZ29vZCBjb21wcm9taXNlLCBi
dXQNCj4gSSdtIHVuY2VydGFpbiBpZiB0aGF0IGlzIGV2ZW4gcG9zc2libGUuDQo+IA0KPiBMb2dh
bg0KPiANCg0K
