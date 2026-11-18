Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795028861;
	b=mN3CZJzxlrFObuuLdPejCm+wq0N7TWIwZsCTwYpXW6i03ng1l+Fu1niJuoSSM2B1MJt1
	 cBtT1QTQne6UdB2KZthJsI0zltkLaL8nOetICu9pPO8eBJgfiJ3syZsJJnYfV7w3vMtkZ
	 mVtThxxVP2d5KTWl5oBJye9hNqyA67TUwRdzwxRFVN6a1W3lCkj7E2dCM1POp6hRnRW3o
	 cY4t7FKdlJzGqQ5I5fPE5gJl0Wl56Yb+yaeryxe8t08ZZzYs2ggcMsPRcfg9bt8AYr4eF
	 WyhhbQV9SrvENYVmmRONYaulzTQ+T2NKXnhJd7dtKqg9hl9X63mkP3n1CY6tzVFs0Lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028861;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1g15kQg2AZRVcjHVO6KOQOIh7Hqjj4frhB6OvIc8tF0=;
	b=yqLSUEV3vt6pHLIKaozbt4bqST+XyIGUvLmvRisSiUwq1Fj4i2Kf9m2YQk1OoT00uNeI
	 MC15mLvf9Y8A+sDC9SiyvziLJhs5FnJTpJY6tqWNGX4lzotrZr6GvSrEOENdxGyziWpLr
	 iV3K73Tqwo2PpDVialFvCrtqBuehvg1JpuGyWltQsytdj+yHuCySs++haRvgdjE1KihkC
	 YXryke0tih+doMolZxxx2C+2/MSdHOhZ6gw0w73zieUssUx4fZ5nzEd52ivSGerWILEKK
	 c+jwpCORR8QloPyqLdwQuJCJAU0OBWGwLPKIr+ggtxO2vAWmoue+GRZo0TfaooTnprQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=dFAPVFpk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.26
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011026.outbound.protection.outlook.com [52.103.13.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F1606A33E;
	Wed, 18 Nov 2026 19:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468F1606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=dFAPVFpk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uByBUPWC+oN+xNqyCXluPkQvTPsxLsVw6FZHdFagy0vV47QI1tRGK3O6s1rAezkqazqiPCC8xjnDgw5vXBgZAE76WcdtFWcAeB29Wk7mGZ0QzLVJOByMMYmOYqMOsscLv7cid5F8T0L7bRYIz3rKt9j0HZq80+Iw7kgvPBLrlIcS/cGi/B32IpWELPVgNsA9nNUmbxa0aEHiYMOzknqaSjXms+T6/QVDo2QWQG8/SW0M/an7xLrYu8iTpV1Hif5oznpn1+wMA+P/i+W2K4nXHWbidQYAvOJsFSpLs2MBz7npIb7OekRd08a+4ospj7eBr2+eugZSSTfCFlLA00FwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g15kQg2AZRVcjHVO6KOQOIh7Hqjj4frhB6OvIc8tF0=;
 b=J27E38/unJAOZW44JjjMPHb+D5YwRxPXxMqG+NUVFiASPskmnZ9wXc92UT00UY1xDD+IqzUemzaLs5tI6oAEwnpZeyOA5ed5xQyJUVgS42VG518fpOVZs1jkx5BVHOwxa8ZXPW257uiWVR/smEdfC612wftVRGefj9r28ag3weWvvnA7H+hovkiy4gSj1kqpGwlqvcRbR0fIzC4/1mmhXeYQzcdSyEQPPL5RKlGgLzQ/had4+UcZxgIwY3kFwXvZN9NCSJjWawXsoo6rPdF+rLQqs5UTnYeH7nPRh/KMSufCi+11mzWZcdrBJ031KFMqLYa+7ma1004xCQZZMEHrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g15kQg2AZRVcjHVO6KOQOIh7Hqjj4frhB6OvIc8tF0=;
 b=dFAPVFpkn1/sYM4aS1JR2UXhgn2NILqgNdrJ1aGkTA83Q/0AeI5jb+BhI6q5fEi/JrU1t6PrsxTgWbuB/Nw42AgJbmz2FOGcz5Mwf7B2PZjks7NU1udbn8MTNcBS/GwNYr44JWUgl9y4vYQBy8iaGy98jiJFGM0kfpW57g4Ln50l4Mb3kTOykBGVgGGz+TtVut74EKu6vgByEOGnnIMqXyS6ILM+ps7E5Cbsw47L76xFut9uDFkacnLkJ7YGNsRJusZM2apYS64I0N13hw6bRHt2w7GK3Y4Cz7N9U+QsD3H6apf3OhoeLjIX77Fh5WSnh5/EOWBKmJafZHghfCjXig==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by BL3PR02MB7921.namprd02.prod.outlook.com (2603:10b6:208:350::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:07:27 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:07:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob
 Herring <robh@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/13] PCI: hv: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Topic: [PATCH 12/13] PCI: hv: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Index: AQJkn8ke3hrUAJD/fxNI/dSM12acegIB3L3RthXNLzA=
Date: Wed, 18 Nov 2026 19:07:26 +0000
Message-ID:
 <MN2PR02MB68637F500EFB95B333A87429D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-13-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261116152403.2672-13-ilpo.jarvinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|BL3PR02MB7921:EE_
x-ms-office365-filtering-correlation-id: 426fbb65-3b31-4827-7c04-08df45a72f7b
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|15080799012|25010399006|37011999003|19110799012|55001999006|24021099003|31061999003|4140399003|8062599012|8060799015|51005399006|440099028|3412199025|102099032|19061999003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTB3RW1rSlJXK3M3TWR5S3diR0hySU9KZVJUbjlTRHlGYnhYOEszSE9QSHlo?=
 =?utf-8?B?UEt1eUt5RkNoN0NGUVNoaDJtMndUOUhmcTZSQlVGL3dWYVBzSjBZUSswenRy?=
 =?utf-8?B?aHRMeFZYaU1uNTJKSS9WUDJsSnFyUExuejlpYjRkSG94Umx3UndtQllEemtK?=
 =?utf-8?B?WEhJekVIdHR0RnhiQnpCN3p2eEd0enV1eXNvdVVvS0tFb3BHNGpya3RJOFd2?=
 =?utf-8?B?UUNwOWdNTThSbVdBbUhaZmQ3WHVYcXFDV09VMjcrWGFOUVdOaXJWTGhJRC8z?=
 =?utf-8?B?YUhNeWgvZ0N0UnhNRWlyWW8ydGVVelBoalVPTzN0dlBBQkJESTRzWk9mMHZR?=
 =?utf-8?B?N0JUSnhIcWszV0ZHTGNyZGp5RFFvR1p5a3RqU01VWm1lejlrdG1GOWNmWWhB?=
 =?utf-8?B?ZTFQMW1jRSs4ekJqUTg2UWVLZWpXT2xCOTBablovZC9rSGcwWW5zY0lLb05Q?=
 =?utf-8?B?YWtIK0RINDVwRmhSa1grZUh0SGwra1F6R05zTC9oekxSbTd5b1ZzTHBnVnhW?=
 =?utf-8?B?RUV4VFoyRjBVUzFPTnorOG5kWWM1U1BGcDViWFFqSVNkSjZ0ejFmbW4wa3Bi?=
 =?utf-8?B?WStIQXZ1VkNndCtFYWhVZXJMQ2ZHdER2cENCOUVyNGdrQnQ5RXpaeTc2ZVBi?=
 =?utf-8?B?dERQRlUzVHE2bzBnR20wZFpSYlcyeHFCM0lzTmdTa1ZUZFdBZytrS2wrMEt1?=
 =?utf-8?B?Rlp6Z1NkS050MnRiRk9aVW1aT3V3UGd3eDQyVm9lcW90a3U0Q1pBR3ZsQ3Q3?=
 =?utf-8?B?dm1XaDFCMnFNWG5GZUl3Y0U0ODNTVGljZ3gwVWxZcjhNTU5rTDJqNWFFYTRV?=
 =?utf-8?B?OHk4ME9sakd0akVaaU5RNU9wRlRnVU8zUmZGYTVTNWVudVFuT2RNYWhmdThD?=
 =?utf-8?B?NGNyNEtqZHB1U2NJN3E0SEwyODJvVll6ZVIra1d6QkNvSXlDS2ZxNXlzTk5W?=
 =?utf-8?B?cTUyR0FyK1lXVkMybVM2OGxDMUpGRnFwTlV1eXNIS0xNQm9Nc0VtUzEzcVUv?=
 =?utf-8?B?ZnVRbDg3TmdYQit6YU1BUnJCbW44NnUzcjl0NDdweHNyV3BhQmJBSVpkeWNq?=
 =?utf-8?B?K2tUVzJNS0l1V0pKQzZEVDZNcUxuVHIyU0tuRGlwODdHeG1SVi9nS1hsY1JC?=
 =?utf-8?B?bDQvRUNGakV1MjhyOGhkVXpXN09GZGZhYjgyTkNHLzdlM1BTbDV3Y3IyQkFK?=
 =?utf-8?B?YVdjS2VEUDU1d0NWd3JucG8zYW1vWWw4VnNqN3FXZk9DY0xpREwyWnlnMjho?=
 =?utf-8?B?c3dXMkMxQ3JKVXJYT1c3MGgrb0NYL0hpZExpR3BDQmhwZ1h0aWZKZzE1b3l3?=
 =?utf-8?B?NTlDZEM0QTlPZUhobS9FL0FoRFg2cXZMWmsvL0FRM2Jnb3psZjN3SUgvTkZQ?=
 =?utf-8?B?Q1lnYWpWSGx2d3NPQ2dmWnM0TDFmYVdNN0FKcWcyZFVTTnZsMnlUalBEMGww?=
 =?utf-8?Q?63q53LUE?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1VueWlRdVVxNWtOek1Wand2bEhZOFFyYjBielpvZ0l1RWkwVzhvZVZzLzV1?=
 =?utf-8?B?cS9ockNKUTEvMGVPU2EzeWxJOGEzS2tpR1N2OUlpU0Z2NDhZaGJKYjV2ZWtj?=
 =?utf-8?B?R0ZJRXczaFBzQmxKRHh4MG44YzljVnZwOWtXMmZCVGhqWUpKaHpKTUNObm81?=
 =?utf-8?B?UHVxeU1QWUFtaTNUU0lzOStYekFpc21BOFo2MEtjZFhIKy9iTmNpenlJZXFn?=
 =?utf-8?B?ajY1bml5M2llTGNWK2s2Y3BhbFdDeG4zV21NZ1IyM1dMMkRRV2NaR1A0a3JZ?=
 =?utf-8?B?WldvK3Y5NDZRMW1FaE10S1hoc1BWUVIvMkgvU09aazFkKzdVa0dUVTV6MWlw?=
 =?utf-8?B?VHFvcEJpcTF1QVNYSk1RZzJnRkMxckJNZXhseGFTQ1JnakllT3YxUHlNQWhC?=
 =?utf-8?B?anZvWWRkdFFGVFpkRFhwZkRJcTNTN2Z3SVJWQzlQb3hJcGhzS0swZSt0QXZv?=
 =?utf-8?B?SGJreGdGZGxNYmVCOVM2QjlMUFBDMnMrZHMwcTJyK2p6TUdocktBNGJzVjVC?=
 =?utf-8?B?ZUNWU2xuYXpZTEdUNjYrVGhibW5ubGxHVmdsWUxQQ3g1RG5yRytjYXdEL1Bj?=
 =?utf-8?B?TmhIR0VlUmdPWU1XbzkxYStBeTFvUWxTRnZPN1h2RmtmNmplM1pGWUxvL1do?=
 =?utf-8?B?Rmk4MzRJSDlkemFQc0hPL3NVZk02N2Y3S3JodGVDK3ZjKzVMQjJ6dGpOK2p0?=
 =?utf-8?B?MERGeFlXcUtWVkx3cmRGY2NoRTZtN09Ia0xkZHJHL2x4SWc2VGVkeVNjMXZ1?=
 =?utf-8?B?N2FQNitZQ1Zveit1ZnFYbW5TN0R4VzJIWUxXTEZtdVowYktKYStuQ2c2Nzcr?=
 =?utf-8?B?NDRYenp6eGxmSEtFZXZCbUNGZGwrcDZkaVh3T0p6dWtQWmZ4VzNNbWxkNmhk?=
 =?utf-8?B?RWt4M1BKWlA3Z05PNUtLVDdDZndrdFpRUXp1eVkrZDBvZUhtLzdScVN2eEJl?=
 =?utf-8?B?UTdOSDlLRHBIWVd5UHMwd1IrcGtwaVFrS2s0TkJMRUxnZG5MMm1QVW5nM3c0?=
 =?utf-8?B?TkdtMUNjcEFaeEhZaGZiU1YydE8raUNjSE5sM21PM2p3ZnRIZjBkOGdEZElQ?=
 =?utf-8?B?ZzNicjFUczYvVThKc0wzckxsN0xTVUsyVkkwT3c5TFl6TjBMSEExUWVydkJM?=
 =?utf-8?B?M2pMNFY2dGZ5YWpnVVVKbzFiNEU3U2FhZkZxSU9ucjlJQnZMTFQ5WTVWK0hO?=
 =?utf-8?B?U1FOZ3dTdStINmdsT0FwY0phVzRvSkNTcE1kMXVIYU1LUllRZ0lVSlpGSTdR?=
 =?utf-8?B?UlFvaU9JdTIwZGtuVHFzc3ZLb2FBdTErMmZ5bzdYbHJubE9ZcjJlK2JMbUpi?=
 =?utf-8?B?RURLWU9mcVkrZWVVUUJtQk1GSmtaYStuNXVVVEpnMTZ5MEt2VzdKMGR1YTNs?=
 =?utf-8?B?Z1F0SXRmOGs5Sms4dHB5YXB1cHZGWXMwYnVFV21RRVRtSkJ3ZjF3Y2tYZVR0?=
 =?utf-8?B?V2RLUkw4TEFKUDEwTE1IVGs1YlA3cXNCWHVHbWQvakpGZUp1Vm9pckxCa0VB?=
 =?utf-8?B?aXhicHFrQXlzLzdXN09vZ1BUMVBYVXFKazlTSUlZTDBEbUljMHB4NFdzSk5J?=
 =?utf-8?B?ckZ5TWpvRnZYWHZTbXhXUHJXaHFXVitHay9NRzlwd1JpTXBxV2hIT0c0eXF4?=
 =?utf-8?B?c3FsbFFnNFY3WS9NVTM4UmQ4Y3BEUTd3bjZKdllGQ3k5SDNpdEhqMTN3TXV6?=
 =?utf-8?B?Mm9FZGVXditaNS9HckY2eUtrUEhZVWFuUC9kMERBb3NIa0FkL0ZPTWhLN2Vh?=
 =?utf-8?B?WEM5QVJhSCtNWVpxZzlSUlJEcGRYMmd4eWJmMStWVzFGM2xSN2RHTGx0N2Rt?=
 =?utf-8?Q?a6Tl8hkkitB34ZRuMXX5fADvvw3l0jUsRYbY4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 426fbb65-3b31-4827-7c04-08df45a72f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:07:26.8153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7921

RnJvbTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDE2LCAyMDI2IDc6MjQgQU0NCj4gDQo+IFRoZSBwY2ktaHlwZXJ2
IGRyaXZlciBzY2FucyB0aGUgYnVzIGFuZCBhc3NpZ25zIHJlc291cmNlcyB1c2luZw0KPiBwY2lf
YnVzX2Fzc2lnbl9yZXNvdXJjZXMoKS4gVGhhdCBmdW5jdGlvbiBtYWtlcyBicmlkZ2Ugd2luZG93
IHNpemluZw0KPiBkaXNqb2ludCBmcm9tIHRoZSBhc3NpZ25tZW50IHBoYXNlIGFuZCBpcyBnb2lu
ZyB0byBiZSByZW1vdmVkLg0KPiANCj4gQ29udmVydCBwY2lfYnVzX2Fzc2lnbl9yZXNvdXJjZXMo
KSB0bw0KPiBwY2lfYXNzaWduX3VuYXNzaWduZWRfYnVzX3Jlc291cmNlcygpLiBJZiBubyBvdGhl
ciBicmlkZ2VzIGFyZSBpbnZvbHZlZCwNCj4gdGhlIGV4dHJhIHNpemluZyBzaG91bGQgYmUgbm8t
b3AuDQoNCkkgdGVzdGVkIHRoaXMgc2VyaWVzIG9uIGFuIHg4NiBWTSBpbiB0aGUgQXp1cmUgcHVi
bGljIGNsb3VkIHRoYXQgaGFzDQo1IE5WTWUgZGV2aWNlcyBhbmQgYSBNZWxsYW5veCBWRiBOSUMu
IEFsbCA2IGRldmljZXMgYXJlIFBDSSBwYXNzLXRocnUNCmRldmljZXMgaW4gdGhlIFZNIHRoYXQg
YXJlIGluaXRpYWxseSBzZXQgdXAgdXNpbmcgdGhlIHBjaS1oeXBlcnYuYyBkcml2ZXIsDQpzbyBl
YWNoIGRldmljZSBoYXMgaXRzIG93biByb290IGJ1cyBhbmQgYnJpZGdlLiBObyBpc3N1ZXMgd2Vy
ZSBzZWVuIGluDQphIGJhc2ljIHNtb2tlIHRlc3QuDQoNCkkgYWRkZWQgc29tZSBkZWJ1ZyBjb2Rl
IHRvIHBjaV9hc3NpZ25fdW5hc3NpZ25lZF9idXNfcmVzb3VyY2VzKCksDQphbmQgaW5kZWVkIHRo
ZSAiZm9yX2VhY2hfcGNpX2JyaWRnZSgpIiBsb29wIGZvdW5kIG5vdGhpbmcgYXMgZWFjaA0KZGV2
aWNlIHdhcyBzZXR1cC4gU28gX19wY2lfYnVzX2Fzc2lnbl9yZXNvdXJjZXMoKSB3YXMgY2FsbGVk
IHdpdGggYW4NCmVtcHR5IGFkZF9saXN0LCBhbmQgYXMgZXhwZWN0ZWQsIHRoZSBuZXcgZXhlY3V0
aW9uIHBhdGggaXMgZXF1aXZhbGVudA0KdG8gdGhlIG9sZCBwY2lfYnVzX2Fzc2lnbl9yZXNvdXJj
ZXMoKSBjYWxsLg0KDQpRdWVzdGlvbjogWW91ciBjb3ZlciBsZXR0ZXIgc2F5cyBkcml2ZXJzIHRo
YXQgY2FsbCBwY2lfYXNzaWduX3Jlc291cmNlcygpDQpkaXJlY3RseSBhcmUgbm90IGNvdmVyZWQg
YnkgdGhpcyBzZXJpZXMuIHBjaS1oeXBlcnYuYyAqZG9lcyogY2FsbA0KcGNpX2Fzc2lnbl9yZXNv
dXJjZXMoKSBkaXJlY3RseSBpbiBodl9wY2lfYWxsb2NhdGVfYnJpZGdlX3dpbmRvd3MoKS4NCklz
IHRoYXQgYSBwcm9ibGVtPyBJIGRvbid0IHVuZGVyc3RhbmQgYWxsIHRoZSBkZXRhaWxzIG9mIHRo
ZSBQQ0kgcmVzb3VyY2UNCmFzc2lnbm1lbnQgd2VsbCBlbm91Z2ggdG8ganVkZ2UgZm9yIG15c2Vs
Zi4gOi0oDQoNCkluIGFueSBjYXNlLA0KDQpUZXN0ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGts
aW51eEBvdXRsb29rLmNvbT4NCg0KQW5kIGF0IGxlYXN0IHRvIHNvbWUgZGVncmVlLA0KDQpSZXZp
ZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+IGluZGV4IDgyNGNmMjdlODVlNi4uOGVm
ZjNlOWIzMjVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBl
cnYuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiBAQCAt
MjU0OSw3ICsyNTQ5LDcgQEAgc3RhdGljIGludCBjcmVhdGVfcm9vdF9odl9wY2lfYnVzKHN0cnVj
dCBodl9wY2lidXNfZGV2aWNlICpoYnVzKQ0KPiANCj4gIAlwY2lfbG9ja19yZXNjYW5fcmVtb3Zl
KCk7DQo+ICAJaHZfcGNpX2Fzc2lnbl9udW1hX25vZGUoaGJ1cyk7DQo+IC0JcGNpX2J1c19hc3Np
Z25fcmVzb3VyY2VzKGJyaWRnZS0+YnVzKTsNCj4gKwlwY2lfYXNzaWduX3VuYXNzaWduZWRfYnVz
X3Jlc291cmNlcyhicmlkZ2UtPmJ1cyk7DQo+ICAJaHZfcGNpX2Fzc2lnbl9zbG90cyhoYnVzKTsN
Cj4gIAlwY2lfYnVzX2FkZF9kZXZpY2VzKGJyaWRnZS0+YnVzKTsNCj4gIAlwY2lfdW5sb2NrX3Jl
c2Nhbl9yZW1vdmUoKTsNCj4gLS0NCj4gMi40Ny4zDQo+IA0KDQo=
