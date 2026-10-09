Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515E4E2F28;
	Fri,  9 Oct 2026 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562562; cv=fail; b=Rruh937Ppc32eIwBxqrIonPlZvU8r2kIFFCXLpqIa2trauo0m+NRVmH0m99hH7CcKNXXG5isOHhY9g7mjaGjSXb+39v4WYcbfVWByYPG/FIXxTFX4WY2s6VHGAaqO+vvm7tHihL4boThxXlZvUASi6PiPTwXXSdRZ5fBXNoRP7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562562; c=relaxed/simple;
	bh=h+9M2bWfIrp7x36IGnScpGDLd0hf+q4vTyzWMCjgqgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tr4mYUM+xTbP8OAtGlCAb38eBps9MW+0U18i9UQEdkjvzP05SSmr4Q0REbd14CoHWZCONWwqxKmXBz3GvtOYvOrETKHR5CZaljAUALael6OHb21ekGsshZRwX1xPrAR7xWNXiVN8U4bWZXoS/eLSPZwm0mHNbwp/XF1FS3u2pOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnwHmRci; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnwHmRci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791562561; x=1823098561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h+9M2bWfIrp7x36IGnScpGDLd0hf+q4vTyzWMCjgqgw=;
  b=HnwHmRciFmSTccq078TrVEq4BpJnkIfB8kIX4gXzjOdazgmTLWUanN8g
   Gt5gzgpHKYt7JOi1dtvm9bEhr3HikPZeCCE7L4YAMZjLUlQE027oYXos4
   4qEaC8HEcQZzmYuudURgDr8XS+/UoxoRImEnp7zYpFa5gKE0bnkDqlaXe
   5vG92gzgO8aeGld0yicX40+TYuB79qtFpBh07M1fkhqhyTjTT9/hsjHYf
   O59hV4y8AohWxIIp9slWng0XoTiZrLpqtTgIXpC8iPfPJEDRgGIv1p/SL
   76iEy+/akpJs/XPER/LNw/qWo+h/WVpAFP1nQ8psqNAn1zc2wZ/ShYoww
   g==;
X-CSE-ConnectionGUID: Dx2bMZEhQe6O6iFuq+II9w==
X-CSE-MsgGUID: GTFVuG1DQ6CdA7VW5nZQ1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="378825"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="378825"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:16:00 -0700
X-CSE-ConnectionGUID: cBR/EqgGRSW1euNEPhqRRg==
X-CSE-MsgGUID: qGZkIpOoRgaLY1HtbHTLcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="322072"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:16:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:15:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:15:59 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2SlPjCwW5LELtyBiwZK1n1DZMv5SVAQ0QKQpQLv/aD/ajRCFNhgAJofZM/EJa9dUhjVxN+S/5FqMA60g9KNkVhxlh0Pk1gPPOOB+vpwhdfXUn1zf6TrdwR0ivK8F+oMkVvBcap0Uvh3xSJdSEGS9TZVLGCkILajfLxBYE5gwGQAWTnZ4DzAYJm/OLEut9YmV3VM7q1TPI8SMtPnKzrvVXoGxf3A0Rjp88GPWrgQVbFMetjKqwHuJeLDTm/It0FkqFk2x2+XA0/f+BdIJLCi8ouLqp3IEXDLtRlXP4y3D5gdmu5gpC6zgfwc+Wy5x7hoQXyAmIRGin3QE3hEy1rdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+9M2bWfIrp7x36IGnScpGDLd0hf+q4vTyzWMCjgqgw=;
 b=rA2jOoM/AYN1jIG7xNObBmyoDD6dTp+dBE+zQAd4VUnXeSZpuPzAF96XBBuOD+QdTCvPG7xddBISSatyRX6KwhPrtnzoEDHtN8R4TNePGNmAmXeny34su8l3FYhsXAzgQB3D26b9dwWu4t8tLKFgDSsuyPcrz4eQKIr2kEQGWYgDcIwiBWfmncdR37HzM/MaD4tC75AEdwCh671fAMtZIv4i8T0ikI4nYJXBydGMiwHgOyNzDL16CuotdRMyav0l/x/+xlBxvJGSEvr/AqtnkRP4MESebk8mmhzrO8XSFkAyitKRTh4IMLrd9I14XGUxKElwY+7qwTvfpr2UYnQXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Fri, 9 Oct
 2026 16:15:56 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:15:56 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 2/2] PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel
 hosts
Thread-Topic: [PATCH 2/2] PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel
 hosts
Thread-Index: AQHdWASQ4+At74lQk0qBMdq1AdVJm7b1WxKAgAAHQTA=
Date: Fri, 9 Oct 2026 16:15:56 +0000
Message-ID: <LV2PR11MB6070D1AE682B2A25762DA546B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009154034.82321-3-pavel.e.popov@intel.com>
 <sashiko-outbox-165797@kernel.org>
In-Reply-To: <sashiko-outbox-165797@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: 62c8bf49-7ed9-443f-98cc-08df2620997d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: SJpz7thHjXxrEn249OxKFTrHx4YMJut0sAuOrquIkGhvJwPfLJJjX9RrCVaEyHWIGKxPWIYRoycSwp9KK7qz/zoOhIYjKq4h/wAP5SEgRP2kPaKpfcwOVZ8f0d3uORcxBXDdJ2HIykKD4aHt2JOYi8XZnv0E1luFkVaGY9yHDrZxNL+4ekjkKltryq8sr+6jzxN91T59XZ2sZ4yr+nd2GNEbd9eUeEn0havQf4YIoIC6HiQBAe+mYE2Tq6kXqOGTxFK+83tAWMbNjv21EOoDQSIGnD1PnMZoNGLIgv1vGVQOrTM/B2UPsBV4yTvhu1XK0heNrJbK3SiHHA5lY8yh3I+uYDzqkrf+Q+Ekl2QyF2K+/ndJKO4cVHdhphflkyV7XDald5JPLypw5iJi2Pzk6m5aO1YVHjcbOB8c1CKv+53ly4wQ4DblNdPHXbXq91GmD2mNYJbTWAL+w4+bDs5c4WPaqTix2lgvX/k26eUtS5hHkcfsIwv7dxYLesoWuRE4vAVNUG4dzODize4h8K0uqeaQqkxDupt+TnBYKdIm5Ok61d5OejVai38G+Yu6ogHk5swMQayCQXmffBBpqYNdGjXY52hUQuSh2P386j4uS3+v9OIkYplGV+tSEgQ4KQUdx5Z/rjcQY8sVBQn5sXE8EmZbNzQMcnyjw9QOJeIyUV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXR5Ump5cWVFWEJzQk4zbHVjU25rTGVjODc5QUFYQU84QWFNcDBCaEQ4ZzZp?=
 =?utf-8?B?MGVpalNkN3lET3FScE1ZQ0REYW9TejVoT290VVlPNmZETnpjNTZxOG01MG1W?=
 =?utf-8?B?WmxVL1RyRFRZY1NuYTJzL0dnTEJEeVkyTk1rS1k3YnBZQU5aWG1rR1JjclFE?=
 =?utf-8?B?UmdyMzJKeGVUU0JhUzk3dHUybXJWQ2RNcGhjM2RUblV6c0x6WVZkY09TSXor?=
 =?utf-8?B?V205b0VhWlYzNzU3dFZhVVpEWE1HWGw1RENrekFnbWJIbnF0MVNKMVc4UW1G?=
 =?utf-8?B?VGczWXJXVVFRbmZ1WUNMQ0E3TjRGRWxud3ZWdnRlK0dHczVUQXFuSVgvM014?=
 =?utf-8?B?a2g2MEgzVGRTRUF3eDBrSm1QaVhsd0ZxV2hEaVp5azc4SThyVkhLZGxEU0NE?=
 =?utf-8?B?b21ETFhKR1ZKTzZsN2J5azZRbjlSNTA3OWdUTmJ2eTBhTkFhOC91c3k0cHpO?=
 =?utf-8?B?d083dWpBTjdIdHl3aUduSlBrRmZRT2tCTFJFcWEwUFJUeUwvVXhvZnZwYXRa?=
 =?utf-8?B?UEM5YzU4UXY0dHAwbkdNU0Y2ODNrS1E1Q0N1RzlmNHVVNkM1MnBBTHAybUhr?=
 =?utf-8?B?V2ZQZ1dmMUxxTmdRY0xCVENXRjBlZGtPU0E1emdHNmZzY01RN09VdDJpQnFo?=
 =?utf-8?B?a0RzdzhXZ2MwWVNheTB5eUxRdFp2S3gyQzc3UER5UHpTcC9PZnZFalJtVFBG?=
 =?utf-8?B?VDR5ZERNVVlzR2tabEtQaVpMK0VuTHlFeHpWUTBLZmR1eXVrNzQ3UGF3cGk3?=
 =?utf-8?B?Uk0waStnSnk5NzEyaGJHSnJGcGVzTDg2aFgreFdwcVFMbk9oL1BYTVZkci9M?=
 =?utf-8?B?dExpR0UrcldkWkZzVDNQWHREaWV5Vmt0cGU2UTkxaTd5QXA4YWp6WG4zQzZt?=
 =?utf-8?B?elNMQkNwdW1UZlgxRGI4WDhaNmdPQWczQmtMZHpVRGlsNFhFSHJzelpjb05W?=
 =?utf-8?B?NnZSUWhXRDcxeVVDUUo4b3RrSzMyRklld0FSMjROd2NZVFZ6eURqYXgvcllS?=
 =?utf-8?B?a0orL3cvcmtwbjBJOTVUZUc3eUwrMkZzY01NWVk5aDRGQ0Y1VlRlZ0pBZkMv?=
 =?utf-8?B?amN0VVluU055RVJCeWFRNi8wOEJ1aXlRc01nRzdFNCtnMlNvcDFQM3l3Rlg0?=
 =?utf-8?B?Rm5iTENKYzJtS0dCb2prMEJoVEt6SFJVQkpIMGJua0xzN0V3SWpJRVRCOGEw?=
 =?utf-8?B?T2ZSRzR6NU90VkphekVSa25ka0doV0RhNlRzOXdFOHl0dndrYUJQK3kwYllv?=
 =?utf-8?B?STBVcEVCTm93aGV1T2hqb0VJb3dTd3RkSkNUNHhXZnRnUFV5aHA1MndtQU1S?=
 =?utf-8?B?UE5Jb3g0WFE5VGVDaGJhcnNqdGlNRVVjb1g3SjdqYkZFbUloUS80SmFZQTdo?=
 =?utf-8?B?dHNGSXhyTys5SEhoUTRjNzV3SE12S0FMZnZjTUpXdnplNmd5OFJrNXdacmg2?=
 =?utf-8?B?T0xmak1wMEVFNXJJR1UxcXNXcXpSWFVGcDJhMGxOWWxoUXB2R05WdlZKM1VW?=
 =?utf-8?B?bGFtSU5BWEFBK3l0WVVxT2pBMGZXM0Vza3ZoNkdac0l6MVpkQVJBV0ovcWhO?=
 =?utf-8?B?ZEppUWhmZ1JqVGcwRk5oVCswc24xU3RiU3dSWDdIVHh3WGYyNG5VNk9aYVZH?=
 =?utf-8?B?VG5weG9ZbjdndFgzdXRMWThMNzkvazJmaE1sbGFiNnZTTGgvTEJxSFJMUE5q?=
 =?utf-8?B?SHpWNEhuMWhSb0pPSW1TaTIzK2FZd3VFRkQ1WlpRNVMySmoxS3UrZ3RmeG5x?=
 =?utf-8?B?SlNOZ014cHJrbGdOdkYyb0FZMnNaeHBRa3NSMXdOcjkwVEZPODFaM0ZrR1Ev?=
 =?utf-8?B?VVlXTDI1Z21RZ3V0ckF1REM1cnBvbXlZTC83Nm41VGRSZ3gzcThQMXZQNDVE?=
 =?utf-8?B?NjMyeTJpK0o4S1pNSGdFZnpBdFAzQVZXcjFOVFFqdjFFRlFieXJ0bTh4ZlJa?=
 =?utf-8?B?ZlI5eXVTRTdTQ1NCckJnRTVzSGg2YkhzbVpGNFF5LzdVZjBlcHRCUC9GcE9N?=
 =?utf-8?B?S0VXVllldWs4eFViUWsvK2xtWjRuYUt6L0c1WFBzWkxDd2tKeTFQMW14MDh5?=
 =?utf-8?B?NXRMNldlQUJ3WDB1Q3FGMTBwWHVjZTJCYm1pYkhucGJVNlY5SVRPUjlVV0Ur?=
 =?utf-8?B?NEZiMjBjNlNBZ25vbTNaQ1JSS3lNMWUzVTd0Mk54V21RWC9MdFJGNmNaemtl?=
 =?utf-8?B?N3VKRWMyYjQrVkFpYW5IUS8vY1dBVnF6MUJzaFUyUkxBemVoWmZ6bkMzSVBI?=
 =?utf-8?B?dFFrVXkrNk9OWjZHeGFIaThLQVJZdG9XMXdpckF2a296a0haMmVudDFDU1Ex?=
 =?utf-8?B?aFNEVklxa0cwakx0TW8vNEpPMldYVXgrdzRnc0lNNTJzcnVqVGtpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BrftJLUCSLlARstUNShKDWdiRfOvhd+Wn60tYfr62SCZVbgPk4VmdfH7GBM0TZsUWC2siCHA3ulRqT08OG35fpuimcv8lE2cAhV6plxVOqvsKm1lvcvnMwBdZ9OTyrgoru04A6xfqYS1ONVOxMLpxXcWCWhm5o5q4MG2/C8y0a2sFlOBeEUV9KkNBdfpx8n0to3d+xXNHtguDg3oSOJfjWprx4cibyOjgRcprOdCjFoXQjIZSjE5SbPc/pyEFIWgjR8Cj5B/BTsqxe4Y4c/iREXbYLDzWDdu0V5co2biDwPL/HapS+NEYHWhTEYRKoldFXVnqjShHAwxA3k7NWtEnw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c8bf49-7ed9-443f-98cc-08df2620997d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:15:56.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWJn3L3hE+1WR8UV6e2XgiNkDfIKRYpn8TKzT4YFvc3MVYH+E3JC336lx/lp6qKqDD1v0ZtSwdgUn49Vaw8ZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhpcyBsb2dpYyBjb3JyZWN0bHkgaWRlbnRpZnkg
U2t5bGFrZSBhbmQgbmV3ZXIgQ1BVcz8NCg0KU2FtZSBjb21tZW50IGFzIG9uIDEvMiwgYW5zd2Vy
ZWQgdGhlcmU6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvTFYyUFIxMU1CNjA3MEFBMzkx
NjhCN0EyQjk0M0RBRTg3QjI5MjJATFYyUFIxMU1CNjA3MC5uYW1wcmQxMS5wcm9kLm91dGxvb2su
Y29tLw0K
