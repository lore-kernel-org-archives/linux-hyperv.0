Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794612883;
	b=IHity1kK2Eohb6QnkhCQ0IyirMBYE90y3M15OzzXCsMwnn9su97ztQnCYjkrvV2iLXxa
	 TWRd/gX9ad4GudVFeFX4S140uMUe9BHGgx4vlclndViLX4pPM4AEtZ/dpw75VSqAAMvzO
	 rhhvSsB/1bmq7EFh1ielFGJcLSNOqebT2A6dVEZnn6Zum9DRZQN8Bro2+JCXw336W45Cj
	 9bPEdI3cgXs6vyrJmGSjFfgHJXIecgxbWybdyR5oFynuClupohtDj2ZNW9EL2972qIvhx
	 fHUlsPrw2lGDWCX02Y7ZaN5qppvFnXfoPKUHwJdNOHhEGAMDj3/0nirKrnwdcD5U6aA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612883;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=xilJ8nt3XBwb2pEB3+RP//exS0XggRH4TXpbIWjcFaI=;
	b=E2kFeO1/Lh1lg0IgeqHdqF56itZ4eNJtPtA3Gy9mNtw8fl+KmULBS6Wbyi8aX56ZNRDM
	 fxwS5nku8V0fqc0iJS36e5Mo/w8L8GdEn6IpzRVwzv1yHhhfoufh118R5E7ygDLeIn/Wg
	 5gx6hheTDVuyua32InBiN/2p2zkTORRO6dZOoKMVnKaT9EWWvdPvEJ/n27w0ep1ZDOLGR
	 qi8gBKWlLnW4h1qUmfkhFpWvNilcAOwv8RaGGRSyDJWRQVm4ENxBX0dSnhY7zAScMEGeZ
	 ubiKGRqVYwVQnJvpQ830aRg3a708uMGgpM5KpbID5UpbotuBoa1CZlWxSerM3XZ1daA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dd/YdDEG";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=IrJr0z+y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0D606A335;
	Fri, 13 Nov 2026 23:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CB0D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dd/YdDEG;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=IrJr0z+y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794612883; x=1826148883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J4y+2z7yuGlCV0bwdR2+AdFaBYXWgOikMxbrkggCwE8=;
  b=dd/YdDEGAvy0yuB6cp9pkJCe8NuGx7DtczBs52Xp+hia7yLpIjCdcJSt
   SK+lN64p8eJhkyHMBUa18M2mh63ECHZNTN9KIjh9Eiy187gT/jw5i2BaX
   SgivUqHab8uLU/d6r5GL4kW9GacAGRK9HMiTKOsa4hb4p0QMPzo4cz9UT
   wxDCrcEy1gkRdTVJncZF0ICWs/qxPLf6fhauh+qfTJR+a41hUBX2RV5mQ
   A7yTgYe0skqjtmIejEQBrxIG4y2uzxrN1ZaVw8skir6IuPsBCWZZPVzZO
   0TVaL3hJEHRfWyn8b8ItJrOWWEPTBoA5tNQfFPDVYM1VqEzhiRdj1/57p
   Q==;
X-CSE-ConnectionGUID: 7T8CqHqASruKgWCmNGCPYA==
X-CSE-MsgGUID: NRC0aWdNRZqX/6o7drmaUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3470520"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3470520"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:34:43 -0800
X-CSE-ConnectionGUID: DQT6L2nbSCipSJJ6woxNMQ==
X-CSE-MsgGUID: hlH2MaoZS4CzL437u4z4yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9364858"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:34:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 15:34:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 15:34:41 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 15:34:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYxtH8eofh+Igos6f3lNfA78DxAm6WP5y1cxuY7Uxp7ZBfzcFZyIEuX7qgNTZElgBxHQBHzCwRjlLa/S5np3QaK5wA5hREAVmUnbfHwVgJD2b8NOEPh8iv72oT8+r5JF4II+0CeBKBZmKzBkd017LHuZ4vyzWsWt5vI+7UT1piKlGgprPt1ntHqQNfJyg7QfmlsMxIzNM7JbsPTjx5eA1iDQYJLsJUBM7FAF9yosIUT+EX5zWPvzMZhdxhOGthJ3FjOJZyklJNpJ27bfg2lFZ6BbNbj2Nhahp5aAKTcMNtrWAT37orFFzpNWCn8iYlmDa5Ee/j+Hpek25YLQH7UmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xilJ8nt3XBwb2pEB3+RP//exS0XggRH4TXpbIWjcFaI=;
 b=XmOOCUgzO8Ug8L6/+yK8+Ll9MX3q0CYVJ5UOM2m/vll4yU1sdVxzt6yQIaJzMhVdZlaYfWFZgZJ4g/7Eza8HucMno7YvEMsVe28fmPDlPH2q97GSE3M+m1Sp71yiwZl47IahjgelXU1WQouziokhcaYSa22k6ySHbcKSUJpaAtYV5VULwzPIpVeKb+dF90vcSwVl4ig98JBNzQtuWEIaHdShf2nhKl6gbihXRAnseseACJL4UAarzKP9FwefIhbHfCH3z18DwdfeeEJv7n733orkhkFctmhL9rw0petbsJadRrifQqxJuUPHEEGUG+VEERi/Cj2S49ne08X9yLi8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xilJ8nt3XBwb2pEB3+RP//exS0XggRH4TXpbIWjcFaI=;
 b=IrJr0z+y/J5YVHGgElSDCfbt3bGAqFKjNzs7b/Q8ELKQ0f/RdZntOneqrfZ+FLaYcPVyujVa38yxRIdPOdValdIuvkNgODSWgtEYYqkyl75fOVOw2lVOzcphQPZaJi1ha7IqDYRK2YHg3u9mnOAqoL8mvXHGJnmA1/BABU/0Ba0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by DS3PR11MB746707.namprd11.prod.outlook.com (2603:10b6:8:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 23:34:39 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.010; Fri, 13 Nov 2026
 23:34:39 +0000
Message-ID: <36753749-e07a-4031-b729-b6cc86d4ee55@intel.com>
Date: Fri, 13 Nov 2026 15:34:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] asm-generic: Add <asm-generic/cpu_device_id.h>
Content-Language: en-US
To: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann
	<arnd@arndb.de>
CC: Leon Romanovsky <leon@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, Nathan Ciobanu
	<nathan.d.ciobanu@linux.intel.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<virtualization@lists.linux.dev>, <linux-hyperv@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-2-pavel.e.popov@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20261111234439.4098-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::34) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|DS3PR11MB746707:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f75f4fb-c150-4b7a-3684-08df41deaf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|261009221227099003|22082099003|261009223027099003|18002099003|261021121427099003|56012099006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|10067099003|261022105027099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: XrYDB8BnxRs9P+ia99H5WF3FXy4i8rGfKl129UPAnUqc5KMBm6nj9Lp3wJEc8VwuPSqv/ummN/ldDFQEG2wBfxJVQtQ1bG0jZqFbXB0uFezA0jp5UYf6uVsxNVYrnyaY5NC2H2tQLhh3dHJP/c7rnfZB2LEqOHSvGpm8wJIbox5bMVNJZXjcBguVDTLLhbHKvYKdEybZqktfh2C6FIqAtEcXEQg3tPLj28DBO7R/d6Uzz79szIqTXPp/EqanOVMTjElPUR9ZaDuZVYEw0zrBM+1keAUAA6xftZ64BUEKMfq+kpYRhLPtufMGEIRE3PCwDs0Y0in7YVg9JiP2Gv8xIGzq8Dz7KyRREOxkEqYmuH7jf/6kUUmhTZwGEroSJ5SJ4apH2XmV9NTq8i8VEPEU1cGjKFi/G6QomFhBNAcifVKzSjZ6GA6pYg8wEV2QayipeWAdCPocyTgH2ghhvAlXgHSIAIovdg3DEKxjA80O0dvMj+mB6csZ2OFVXsM9IHCmYiH02tW0EHvd7D6QCaby95FRHXuae5C6+70vveWnUgWQKkdn47VdGX53LQ8HSo26yyB1QNo+n4IXvFjpOOwiC8QqCD/mPE40XXIUE4FvMw4a5AAbzQhHBsMf2PQLqu3h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(261009221227099003)(22082099003)(261009223027099003)(18002099003)(261021121427099003)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(10067099003)(261022105027099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NGUFZhc25kKzFaOEJSVU0ydUhZck1PcFZyNmdNdmRJT0NlUjh6L0F6TzdX?=
 =?utf-8?B?YWRObjNKVlBLa3c0MUtJekcxZ1dLQVJ5MDNvYVNkZlc4VjgyRlFVSWo4bUhh?=
 =?utf-8?B?WW9Mc0dsUzRHZkdZMjdxd2ZGUVg5b1pBSlNDTkdzcXJPWUlxK3Z1WjN6a0xl?=
 =?utf-8?B?STRWNTRoQ3lKRDloUm0rZWVKMEd5eUs0Mi8wcjlvclpNa0hueGlSREs0S09E?=
 =?utf-8?B?NmJPa3pZeVkvdHZiem5idGx5Szd4Zm5oV0NzMVJUZmlaa1k3eWY3QWpOQllF?=
 =?utf-8?B?c0ZyV0dxbnVwWG9HWGxYVHI3VXVheFNIa3pnVkRGdVVyOG00TXQ3SzlLMnhY?=
 =?utf-8?B?RStqWEh6cVpIT2hwZ2xRSGhwbjhXdFllK2pLOFRxYnJncFd3Z21CeFE5UUti?=
 =?utf-8?B?RTZjWDdKbXVlWUhJL1JtY2V2QXJkMG91RGxKVFpsVmxaaG42akp2cG1sTUlV?=
 =?utf-8?B?OXF6c1NwbWtFb2tVSHpabERWNkVQdE9IcG81SWhhY2FqTWZ0RTRZN0xEWDRr?=
 =?utf-8?B?d095djRWcmJONUZqT01VZmtRNTZLNktReEhQUUgraFI1OEZ1QzkzbHFCS0l4?=
 =?utf-8?B?T3phdDlhOWRJVERuN2Q2djFWZTZFSDRGU0ZsYnZEOHVrUG1lTVE0K1hqSVRL?=
 =?utf-8?B?cFVhck1hQ2d1cTQ4T01nMGp6ZStvZUlIUTRiUHcvNFR1YnFlb1RybnZHQ3hs?=
 =?utf-8?B?MGNRYVltTlBpM3hxY3ZLUlBTRDVZU3RQSUpSazRtcm1MUFJza0ZrcDg4Mm9n?=
 =?utf-8?B?Rk1EZDdGcGZwVUNKUngxS2IzeWwvNCt3aVZlbEt2N1BSdFRFYWtaREVaSVV1?=
 =?utf-8?B?YkMwT3JMUnQ3RDRweHpnYUpqcmR0RGJxWmdZYlB2VUk3elVTb2NSRElkRUk3?=
 =?utf-8?B?YVpyZjM0aFpJc3I2ZktGZHJjK2RaMHVFM0xwcTh3N3cvdHRkSjFFVjUzQW1n?=
 =?utf-8?B?czA1ZXE2OUIyU01jTk5peSt0UTZlRzB3Y0lFWENnbFpwK0VZeFYvbVdsZk40?=
 =?utf-8?B?Rk1aZ3pVYkx5UUdpYThWcGI2T0pIWlNjMFpybFZsNTZCY3ltWjhMYmpwQmQz?=
 =?utf-8?B?NUN1UXJNS1JibDZyUlBHYVBRbXZhZXFBUWxScTRaTi83SlZ5WlU3Yk16Sk5w?=
 =?utf-8?B?QVRGZnFIWHU3cFhsZ0pXZHh0TVZFTWk5VnppN1ZHb29vNWU2YUxlUlB6bWhV?=
 =?utf-8?B?SmhtZ0thQnJJUi9KUzFQakhxZnZUMm4yamhXMkdYUTZqRm0rdFpWV2tidHBL?=
 =?utf-8?B?eFRJYy82QVV3THhQanY4Q2VrVVFUWUtJUkdWYTlRRGhsVURKcExMSmZlQ3hu?=
 =?utf-8?B?RXd2dnp4ZmJheFRiVDR2a1VEUFJONlMrSVRDbVFRaTZSSjB4d1FTNlZ0TVZs?=
 =?utf-8?B?UENpblgySzJQZi8zVkVQZ2ZheWZGVjdQM1JFTFFmWWgxUlBIcU5wNDNiVW9q?=
 =?utf-8?B?K1hteFZWS1F1M3BHVXRrb214M0luMGFXVXNOVnpVRWNyTXNtNlpVVDB1NVhh?=
 =?utf-8?B?WWx3RDBYK1lyaWN1dG43ckhPVnpGTWU2c0hTaEdDTlVoMFpoVG5XL0RqeEVC?=
 =?utf-8?B?UE9QUUI4VHBSbzdSUS9hcmdZa1E4NTJLeW4wYnQvejR2ekVsVmh3R3pxTk5m?=
 =?utf-8?B?Mlh5RXArT1VSeXh6QzJYOWpWTVJqKzREMDhuNnM5Nm5zaks2S1B1bkFFNlJw?=
 =?utf-8?B?cDNoaEtEeFJCYUMvcDlRZ21McXVnS1NlREJxMzB1Zituc01OUDYxT1d5NXhE?=
 =?utf-8?B?NDFFMFI1a3ppcGo1VkN0bSs2OTJRSW1OQk8xbzVTUHRKWFJyd2puQVZLRkV1?=
 =?utf-8?B?S2VkbGNhL256L0FjMmRzdjkrQ0RCTjZISDBydVlRRU5YcmJBb3IrZ09NVXFI?=
 =?utf-8?B?WGs5Uyt4c1dMVFd1UmcvcVlmOTdWak5YVjVZRURpUkc5QnZGUzl5ZnRZQytq?=
 =?utf-8?B?c2NONndrWEduRjVTNVBqWmo1bDl6QTJLdi8veW9NdzA4aFFCaXhmYXlnb1N4?=
 =?utf-8?B?d3ZXeFZkYnJNTTJ2ZnE5UzZoeW9OZG1adVJtNGE0ODJIQ3k3SHpPb1hBSzdr?=
 =?utf-8?B?TXVrZEF5TWNLb2JMbzN2RUNlRk9USGJ2TUE0T1Z6Z1hndWJoM0VXUTVXcXd0?=
 =?utf-8?B?UEVXK3dDTTc4b1JITTZITkxvYlVOdXhSNDdVbVRzVTRhYmxWcExwQWR6NDBT?=
 =?utf-8?B?d1NDSW9FTllkK0xTZytUYWE0VERmMzViNkhBaXhZekpGVENtUytGd25EUmdr?=
 =?utf-8?B?NEJaYkVyQStNN1g5Rmg0SEdELzhibGlNeG5ocTBpekR6ckpldEVEUmJxb1NF?=
 =?utf-8?B?NGRwVEZVTkJCU3FneUpaV1QvdzVvNUp0K2hqaUxwWTJRSUwwWjM2Zz09?=
X-Exchange-RoutingPolicyChecked: PeDRxtNtycXYdqUgtiZ4RokAFsiGZ9sRPzzg04Wf7udaF9GpfYH1mqssIxoVrRkxtt3MRxt+xYE3XtOVUTHozsWp8S7Y/gRUVk/fFZW9qcRDLC2bnt9/YWkMGlIgZ0ARsLtrdzq3g4m6ZXiafomUJnDF+2ywslLJ4rwgAcNsYPCsFeIq339tO7CWJ6MjX1ROPsvw6tsJAH2I8LXUZyb4dfW5z7qAYr5XgvC/m8V55x9F9UgNQQEA7ejr7S02zpMN1g56WkCmtUKzwPyrQUrjOxUHsl+M5AgRv9elfixqkusWDzMD8PEvHSn+SfQ+ZYuhSAeVQyn1Uv+MkRvdiw/BRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f75f4fb-c150-4b7a-3684-08df41deaf77
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 23:34:39.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87Y6+Sqq6EULqCu2uvRZWIM8rD9mVKxmx9eSiV2RGWIOVOAJKRPTMj6VU7Vd9li4imq6YXeT9OOhGg074iTMyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB746707
X-OriginatorOrg: intel.com

On 11/11/2026 3:44 PM, Pavel Popov wrote:
> <asm/cpu_device_id.h> exists only on x86, so generic code that
> matches on x86 CPU models has to wrap the include in #ifdef
> CONFIG_X86.
> 
> Add an empty generic version, so the header can be included
> unconditionally. The CPU match tables themselves still need
> CONFIG_X86 for the model defines.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/r/25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.fastmail.com
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---

This looks like a useful cleanup.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


>  include/asm-generic/Kbuild          | 1 +
>  include/asm-generic/cpu_device_id.h | 5 +++++
>  2 files changed, 6 insertions(+)
>  create mode 100644 include/asm-generic/cpu_device_id.h
> 
