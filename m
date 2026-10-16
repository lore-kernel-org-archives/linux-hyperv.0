Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024D3ED3BB;
	Fri, 16 Oct 2026 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188107; cv=fail; b=Koao4CugPvPm0M8I+CPOmPFje8hiGK2hDwVnTkp4fYUpUiKTQSC0Q6vShzugWGrwwt0S7G/LMPbwvaR/YGNliY+6awWd/WQM/iMHYNE32NPRH05e6yws3BhxG70XEBFfoNoBbv8OYlXtyLqueFZUYIyjDu0+rvKKy2HmytzloD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188107; c=relaxed/simple;
	bh=3N6Ij3+jm5kRTHO2skPDynx023ZSZLiEZCX4hqtkyws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fAAnQm4NjG9x9KwjZDJJhY9BDafDgMiFHxiF9peB0qvUr2w+6ogeXrNk0hcL7QzBtWBvd6ojrf6JWtuhVnG7W4gqDMAgE+m9tf9IITToNB86tor5xYojfmU5+4ps4V5Gutc/R1ZXxTsov9XvYnsxTLu2uItmmIIBDU/QWsQpEjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExMSp3H9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExMSp3H9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792188105; x=1823724105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3N6Ij3+jm5kRTHO2skPDynx023ZSZLiEZCX4hqtkyws=;
  b=ExMSp3H9f9VMMN+4ehrPBToXZ347pYklsdi57Ood9N8OQovigm2Wb52S
   7sCeslIp6jfRdkdLWoizgNnQVg8XlFmUx2AVv0YTF6qLdZaWNc1isZ+qG
   n9eyw9Uk6z/ogYT+bNUth+sM/Dfe3CLuCME0LFpwe67gp6t3GUi0S9sL/
   sqGaNGM9ZP32kRnaLYugDfkS6YDkgT6Vzd76jQzu/tmLtfcVCeZbKjXQ6
   I3YXSruxdgLbjw9MlOexy7y/kgo9opPetWw0vOZjAvpIMoWhWmAytdT59
   WxEpc/yvTilymMUoyUIedE1zxb1uCqHBT9RSsFbkgFDFgJyx3lwSKUJ6e
   Q==;
X-CSE-ConnectionGUID: ECTCavSpToeP8OaHhlX3xQ==
X-CSE-MsgGUID: k1NBk31mRfi6Y0rmkK3n/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="881502"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="881502"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:01:44 -0700
X-CSE-ConnectionGUID: QT0IQmlzQm+Umft2j7PWdg==
X-CSE-MsgGUID: PMmm1eZTQhy0qcZj3ya5Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2017216"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:01:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 15:01:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 15:01:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 15:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlAvnqVHGWZhEl8lNw4g9UDPTZOXIQGyelpwTcOUXwLZJnq8n/RqXBBKVp0QD9VFFcTLO8JYn5zxNdVaxxOb8MmM2TRllVOCVmyCPghvuN2kl7oq5j32yrJccJin6oLNQh6qwswcxyndAKeGyLAg6nXL1sK9pAZkRqsbkls4B3yXc8jbWk/7f306vYUow2L2G/oCZ/0ec3BdMtZSF3uJywvHPW+igNnqm9CTYGXgiNEKChdCSmX63C/jOd50U/7/nZU3ugKBJlw/bQlTKbxhP4zXbC1H9Z+AjNF1y0YUZooVJru0pGSXNN7LFDBC893dptZba3Z8LE28T4qf49i8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N6Ij3+jm5kRTHO2skPDynx023ZSZLiEZCX4hqtkyws=;
 b=o7VAWiYAkdLYWpOFrtlwh00gqYhiSqf2AoGD7v7hrcdFgeDmy1Cty7/KjBfwPvPuw540cppMKAi5+rbC3zJYo4ftFzX1vWTJ8DKZNovvNFJay3+7i7ZqvP+3U6jlacer0MpYgxPt+naWtAoR4jgYcy6lQCYumIezDDuQPfTbpYkRlEjl0bOTZEJfLyHDMroa7UWqJgXUEXyIk2UARjffHqXfQyXpzBLHIhCj9VfOuxKPfg+54aTpMSBjS7fg0rir7LzxLcofFj4m/pKBkLwfL0Y8OZv33vn3l9K25D9AkwqL+a6n7ZQRXjerxNGvoC4WxBgdIcV/M4Z/mlfzCgXs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 22:01:39 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 22:01:38 +0000
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
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMIAACQKAgAAB5iCAAkgrAIACGMTQgAArlwCAAACJAIAAIDMAgAAQuKCAARyrAIAE4THwgAALYYCAAAPDQIAAKsUAgAAVHRCAAAqvAIAAHYHQ
Date: Fri, 16 Oct 2026 22:01:38 +0000
Message-ID: <LV2PR11MB60705FF775FB48814951E4A4B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
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
 <LV2PR11MB6070A3BB8BCB592EDFAFC261B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <4af82730-44ff-4ca7-a126-fba78cbf34f4@deltatee.com>
In-Reply-To: <4af82730-44ff-4ca7-a126-fba78cbf34f4@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|CH3PR11MB8381:EE_
x-ms-office365-filtering-correlation-id: b1b30a2c-ce48-4d99-d76e-08df2bd10dc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: sG3Vf4x8UHxCbxCM4Uu9Iufw0fhIMpQCJ3b3jjij7UkSCQ5JP+thjJNtq3zPEqcFn1QnkAHAPcKjKETD+M821XgH//fRllTSeTuGosVwldamV7dQ07Ov+J40jNRI7MHUoO44qUhsQgeP4SADGwLfea1aemoZ7enLna7iyJ2LD0HkDd8jeG259XXzmpKt/6R2qUIDT6mNRwVtu4Xxa1OyevgNFTG+Obi6nhcPkSyCrM3TQo+DtMr/v8Dv5Rc7139XFwNORg8JdpJgHh9MKogPCRAbKBEHCA8tupe7qDC/oywH//Op1fypjrTFE85eVO0C5jIIX1QKPJS+w17psqC+r5Zq3H1U/TOaDz9iL9SPvZ6MjhBkFNFarbFBsJmPxb4WiIOfvzJHYwEtcnldqWJSKZhecTAinnSdfTOHuJPbKgy6zr0HCnD3inp1gTCuUbVKeznJi6ke/AA94MlDBSsmHZrA9e3g5TFXovNGrqzMH/+Vzbo27tVueyLRNVKsYu5PdjiQ+s/aQQcOjUjZ+ptnZXigQ5TvKK4mOEyGIABpuxGK6un/U2yH3yQc2tN7oeaPbc8HXS9n6yTH2biw0pAfycLNmEfMZ8bZJla7T6IDdxqpIE/hRQYbDqDP4NPgLfI/kC+hEyO+/pyTp6FEMlVc/OaC3TfxqllrSXMNQnjNeozJT/pIX6gZodSVM1e0fIjl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzdIV01VZzRoWXdrY2trQVNXRWMzVWFDcGVXUEtTRllSRXpveGpjaExsN3dv?=
 =?utf-8?B?TWNzTm5Pdm9kR1poZjVBSzhDNVNwcWNoM3VOWXhyMXp1T3NIR3RacGk4S0t6?=
 =?utf-8?B?L2lhZGdPZW4vRjJQTGRCbjZ6aW5ZY0xDMXNvMzIxeVlHanRxOTR4dWtUdm83?=
 =?utf-8?B?YTVLRmc3RkZRMmVYQTlKc2gxTjRpdEo5QXhrSzVQWi8ydFZHZFN1RFpwNkw5?=
 =?utf-8?B?ZXgxOXpkSElHUzRWMXVrZ2tOc2pZd3RKRFFoYzY1ZVhOL0VwYnZ4MDhLT01O?=
 =?utf-8?B?VG8rM3NpL01ZTnEzQWdwNTNNdTZONmU2T0ZSTE5sSGxCRW5NUGhEYmNTNjFW?=
 =?utf-8?B?OUdseWFQS0ZxRTZObjhxRnJSaUpYLzR3NFpyUmx3YzdFMy9hZWJKcTNiMUxR?=
 =?utf-8?B?NFdZVmh3d0dJbk0ySWdJZlNQOWlOb2krZkhxTGdEQlNGQ3FGZCs5SWFBY3RE?=
 =?utf-8?B?a09KMnpiZXh6b2JlWnNJditmc291UHo4VjdiaFZxV0pFeTJzRTMxaDlKQUg0?=
 =?utf-8?B?aU80V3pEZyt6cHJyLzlUVysvTVpMamhIZGxkUFkxMVFRUUpOTUVycERQOGY1?=
 =?utf-8?B?YytxdzJZZE9IT1k2NjFlZDR3czJGbHdBNEY5SUh4blBBZjdrOFprdTJKYWh0?=
 =?utf-8?B?ODd6VEU0TVJRak9vcDEzakk5Tk1ZanV0ME1sTmxPVjg4ZVdNMExXSjUwSGZl?=
 =?utf-8?B?YjlGYWtTTkdxa29rZ2Mybm9UNnR3cnZBQkFXbHlWRnRzWk1hZmMweFpXbDhV?=
 =?utf-8?B?RDZPeHIxRkptTHFrbDlFcGpBbVhMNnl3Sk1lckF4SkovanlRbGVUWGo3MXpp?=
 =?utf-8?B?Ti9pY2ZsaE9vREE1OG5idmJ6MVVJWEVoSWRaWHFoMi9jQ2ZDOVlIeDlaUE53?=
 =?utf-8?B?SVl2ZHh1NnNVaTJJUTlKTjFPOU9jMWxRRGduQzNwMGhWUkh2L3B6MEthYStm?=
 =?utf-8?B?dmxTUTBUYTk1TkhncSthNi8xd0txaE5IcExUV3oyUHh5dyt2bmZIRnhpbHRw?=
 =?utf-8?B?OE85b3J5UkZBMkFwVHFxOHdaL1drbDNjUUFuN3FlMFBCQlRTdk5qZ2NnaDdn?=
 =?utf-8?B?NHZ2dHVPWjhpYzNzdEUvVDdqZWtYMjErV05jSUVrUGt6RWN4ak1NVXhnTWV5?=
 =?utf-8?B?cU9rYldxanlIWVJ6T0tna2NGaDdvZWxSRHFESEZoYURuaFE5VitDN1lVUEp1?=
 =?utf-8?B?MWR1WDBsKzJDVjVVK3NzbERjUnlvR1FJa2tIaTNSYkJBYld0NmN0Q2kwQmVU?=
 =?utf-8?B?NHFsb2ZIY0o0VnMxZkxxbHVyNzlES2VkTW05d0NRd0hhd20wOENsREs1dEFX?=
 =?utf-8?B?Sm1leEFwUTlrbTJOY0xmSDBpNzRWc3VRTC9LZnl1WDRJaW9TQWdpQ25YKzkr?=
 =?utf-8?B?N0lCYmtzdWt2T1g4NW9OOWhFc3JWYW9KWlpVL0c1R0IvdTlnRW9vbTFLNjNy?=
 =?utf-8?B?VHQ5djVUMGlXakM2dXRyNUFLeUluNUxvS2Q2WGhmNlJ2SXhYT3ltYVcvWXJV?=
 =?utf-8?B?VitDZGRMbnJ3NWRsdEl6UVNPNGJpc2hCQ1hZSVJpcWtYTWUvMVBtTmNJaURS?=
 =?utf-8?B?VzNxNmtUS1lqbEZHU2RaSUdaN2ZQUXFqanUzOUEwTXRkbjBlME9MK1JXcERl?=
 =?utf-8?B?QWltRUgrNWFQYnptR1pnMVIrR2JaQmMvVVpKbkM5MldDbEY2UDZmZVliV1ZH?=
 =?utf-8?B?d0Q5OGpmczJBaGltQit6WGpWcDFVMzFEQmVOd1UrT24rdzF4ak5vN1BGSUR5?=
 =?utf-8?B?ZmUzcGdLbDk3a2djVTNjczZEcGVsSFlwTEl5RmJkNGJXSEhKUVJRUnRCbGw3?=
 =?utf-8?B?Zndjc2V5NUZDYzd0K01HTzV4blk4NEhITHMvQXRjQXdCRXZQeG9GTk5OTEZ0?=
 =?utf-8?B?VEg2ajdZNk9VSmFGdGZjcTJyVjdyd3FuM0I2czRiaC9sS2xFRDJCVVZQdlFx?=
 =?utf-8?B?WnFYaTZSS2d4c1NXMVZLT2VxN0MydzVFZlkwOGEyQ1N0NFJ1ejRzTFkrbWRv?=
 =?utf-8?B?Y2E3enVSWGRaRmRHR1JCKzlrUnBjaUNPYm9NRDd0Zy9DNHRWMDRLVTFoQTl1?=
 =?utf-8?B?c2RHQUUzamNPOTNkK01WTUJJUlNRK2V6N01aSDhEd2R0eFVNOEtwSHYzeHh2?=
 =?utf-8?B?K1VSalBWNXllZzU4WTQxOXZJaXo2QzdMQkd6YTQ0bXQ1RzloU0ZySTB4M3Nk?=
 =?utf-8?B?ZXpYVDFGMHh3S2czcTRHbjlWTzVwRlpvZ3ZsM0Y2dTBuYTZUTmJDSFZPWmlU?=
 =?utf-8?B?NWlhanJFSk5hdlN2WEtkVEtNMDhldnljcXB6S2MyOTdSWFNianBNREtnUEZ1?=
 =?utf-8?B?d2VzWGMvOHZWMUZkUnR2ZnE0MzU2MXNnMWlsZmc2U3JtaDR2YmpzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dL0gPree0EmQyEXBf+5j7aiMUqPxLzDxi5ZmFmxnG+9TdGVgefG1Rs/UcbG3rGCJS24dRD3PM+HLnuHrxJyJ9QMvIntiTpw1MqyyGgW3YjXVLDR8wZOwN9O6ckXyYQ0V6PBDr3z10QuXZ/GKng+tO6sYHEuWlMNnJ4xAh1w3lbK4OygFLcTWdi89pz0+rq1FOAeFSSmMgULNAHEuM2Ez6PeQ309u1lyT2N3Yci47DJK88WCHI+VPtotIZruAFqmj5NGapKMKjYVfxyTmlZ0gjaOdyk0IIJxwsppED/MTXf25kVA0z75maFoJt/OE8aH1XZeR45PuV4vLT8NLly/EAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b30a2c-ce48-4d99-d76e-08df2bd10dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 22:01:38.8407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ab7NZKCIWYHzp7mGj9ww5A8+K/S65QKYtF4WPP8Ze9YWwQ/c/VjtA+BQVEq2/1Sr7NINsgs9odhDukf7wcQ4+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com

TG9nYW4sDQoNCj4gSSB0aGluayB0aGlzIGxpc3Qgd291bGQgYmUgcHJldHR5IGVhc3kgdG8gYXBw
cm92ZSBpZiB3ZSBrbm93IHRoZSB0d28NCj4gQXRvbSBwYXJ0cyB3b3JrLg0KDQpUaGV5IGFyZSB0
aGUgWGVvbiA2IEUtY29yZSBwYXJ0cywgU2llcnJhIEZvcmVzdCBhbmQgQ2xlYXJ3YXRlciBGb3Jl
c3QsDQphbmQgZXhwb3NlIHRoZSBzYW1lIDB4MDlhMiBob3N0IGJyaWRnZS4gTHVrYXMgbGlzdHMg
Ym90aCBhbW9uZyB0aGUNClhlb25zIHRoYXQgc3VwcG9ydCBQMlBETUEgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlIG9mIDBiYTc2YjE5ZmQ0Yw0KKCJQQ0kvUDJQRE1BOiBBZGQgSW50ZWwgUUFULCBEU0Es
IElBQSBkZXZpY2VzIHRvIHdoaXRlbGlzdCIpIFsxXS4NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvdG9ydmFsZHMvYy8wYmE3NmIxOWZkNGMNCg0KVGhhbmtzLA0KUGF2ZWwNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0Bk
ZWx0YXRlZS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxNiwgMjAyNiAxOjEyIFBNDQo+
IFRvOiBQb3BvdiwgUGF2ZWwgRSA8cGF2ZWwuZS5wb3BvdkBpbnRlbC5jb20+OyBCam9ybiBIZWxn
YWFzDQo+IDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+IENjOiBMZW9uIFJvbWFub3Zza3kgPGxlb25A
a2VybmVsLm9yZz47IEppbSBDaG93DQo+IDxqaW0uY2hvd0Bicm9hZGNvbS5jb20+OyBCam9ybiBI
ZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgUmFkdQ0KPiBSdWdpbmEgPHJhZHUucnVnaW5h
QGJyb2FkY29tLmNvbT47IEFsZXhleSBNYWtoYWxvdg0KPiA8YWxleGV5Lm1ha2hhbG92QGJyb2Fk
Y29tLmNvbT47IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz47IE1pY2hhZWwNCj4gS2VsbGV5
IDxtaGtsaW51eEBvdXRsb29rLmNvbT47IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPjsg
UmFmYWVsDQo+IEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgTmF0aGFuIENpb2JhbnUN
Cj4gPG5hdGhhbi5kLmNpb2JhbnVAbGludXguaW50ZWwuY29tPjsgYmNtLWtlcm5lbC1mZWVkYmFj
ay0NCj4gbGlzdEBicm9hZGNvbS5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldjsg
bGludXgtDQo+IGh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMC8yXSBQQ0kvUDJQRE1BOiBBbGxvdyBQMlBETUEgaW4gVk13YXJlIGFuZCBIeXBlci0NCj4g
ViBndWVzdHMgb24gSW50ZWwgaG9zdHMNCj4gDQo+IA0KPiANCj4gT24gMjAyNi0xMC0xNiAxMzo0
NSwgUG9wb3YsIFBhdmVsIEUgd3JvdGU6DQo+ID4gCVg4Nl9NQVRDSF9WRk0oSU5URUxfU0tZTEFL
RV9YLCBOVUxMKSwNCj4gPiAJWDg2X01BVENIX1ZGTShJTlRFTF9JQ0VMQUtFX1gsIE5VTEwpLA0K
PiA+IAlYODZfTUFUQ0hfVkZNKElOVEVMX0lDRUxBS0VfRCwgTlVMTCksDQo+ID4gCVg4Nl9NQVRD
SF9WRk0oSU5URUxfU0FQUEhJUkVSQVBJRFNfWCwgTlVMTCksDQo+ID4gCVg4Nl9NQVRDSF9WRk0o
SU5URUxfRU1FUkFMRFJBUElEU19YLCBOVUxMKSwNCj4gPiAJWDg2X01BVENIX1ZGTShJTlRFTF9H
UkFOSVRFUkFQSURTX1gsIE5VTEwpLA0KPiA+IAlYODZfTUFUQ0hfVkZNKElOVEVMX0dSQU5JVEVS
QVBJRFNfRCwgTlVMTCksDQo+ID4gCVg4Nl9NQVRDSF9WRk0oSU5URUxfQVRPTV9DUkVTVE1PTlRf
WCwgTlVMTCksCS8qDQo+IFNpZXJyYSBGb3Jlc3QgKi8NCj4gPiAJWDg2X01BVENIX1ZGTShJTlRF
TF9BVE9NX0RBUktNT05UX1gsIE5VTEwpLAkvKg0KPiBDbGVhcndhdGVyIEZvcmVzdCAqLw0KPiA+
IAlYODZfTUFUQ0hfVkZNKElOVEVMX0RJQU1PTkRSQVBJRFNfWCwgTlVMTCksDQo+IA0KPiBJIHRo
aW5rIHRoaXMgbGlzdCB3b3VsZCBiZSBwcmV0dHkgZWFzeSB0byBhcHByb3ZlIGlmIHdlIGtub3cg
dGhlIHR3byBBdG9tIHBhcnRzDQo+IHdvcmsuDQo+IA0KPiA+IElmIHlvdSBzdGlsbCBwcmVmZXIg
dGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgb3B0aW9uIHlvdSBzdWdnZXN0ZWQsIHYzDQo+ID4gY2Fu
IGFkZCBpdCwgcGVyLWVuZHBvaW50IG9yIGdsb2JhbC4gSXQgd29ya3Mgd2l0aG91dCBhIHBhdGNo
ZWQga2VybmVsLA0KPiA+IGJ1dCBwdXRzIHRoZSBidXJkZW4gb24gZXZlcnkgVk13YXJlIHVzZXIg
dG8ga25vdyBhYm91dCBhbmQgc2V0IGl0LA0KPiA+IHdoZXJlIHYxIG9yIHYyIGp1c3Qgd29ya3Mu
DQo+IA0KPiBBIGtlcm5lbCBjb21tYW5kIGxpbmUgb3B0aW9uIHByb2JhYmx5IHdvdWxkbid0IGJl
IGEgYmFkIGlkZWEgaW5kZXBlbmRlbnQNCj4gb2YgdGhpcy4gQnV0IHVwIHRvIHlvdSBpZiB5b3Ug
d2FudCB0byB0cnkgdG8gaW1wbGVtZW50IGl0Lg0KPiANCj4gTG9nYW4NCj4gDQoNCg==
