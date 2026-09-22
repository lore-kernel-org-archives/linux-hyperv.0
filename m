Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012047.outbound.protection.outlook.com [52.103.23.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916862EDD53;
	Tue, 22 Sep 2026 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088178; cv=fail; b=mjvTJ79VO8U1WGeZDDyuhErBrOO+4Rfnvm1JsSihhvdAk6HVQGa3OHhQDUDFGixndrn8AE6kZIMsGzZMpGo/+Zon/5eaIsMWufezWWEyZv5FkC+oUkgz+m5JhXucse3H4lOxLnzN9HSNvrzea5XXvkuiOYYmsAmLoSs6Kf9ETag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088178; c=relaxed/simple;
	bh=mFkIyRzFPDvq0gkt5fpei9xdZdQGrJ1oFm098aRsVY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKGg8U6wYGamb8kwMFnl5J5K74QnZxbRpnvsBaSkScN3rbdeiYaFF9ZAOwoLK0hip1qv8ypUbsU600dbG04t5Yk/5s8hn55tckq+w5PVGqta2PG2in3zsnSBVYEl0sTgQOqZC53xO1Pb9BpmlCqNydeejamx0p1VTxjBC2DIx2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=euY9kQa1; arc=fail smtp.client-ip=52.103.23.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="euY9kQa1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seeLJRUc7KbE2RSO4bqPNgaK6mixk1B/4mfgTx4W0RZ1G50V61nNbGI+URBaSxuZExkT2xexP1igd1XArNRnRdi5HA4kACs8B0L8JKInbQBem5SvNlWSl3zLepp6HNnusO6zPfX9A7kDF4jhMh/8+kIDS4H0cxxLywGWckshDxaccGRR7tWPA8r17eVgP9era1u7ZWi6yvesvXz6D8glfUAus8qwvkba2FGK5OYlBWJ4p3+LUtTAfKLv5bw9Fx6/Kmlt1xHwNsGFUDzTlip6xtLH+1oa6/3m14AMwZTVFfLtbPIgktqQiqhQMrIttFQTV3pzbAFg4BZv7cxN8nOxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFkIyRzFPDvq0gkt5fpei9xdZdQGrJ1oFm098aRsVY0=;
 b=ScSo5XcWomSb7lhjigQdLVAVgDchpWcKxDHmJmRAM+umMNZvugwfAIT6vGGSjwcCCkwlpc2IfUR/xoU3FYDfhOo9vapmIe/rx9JhcztUgQZ7FABCvhc5B4RXrF0Z/GxdurSEdQdcyo4I2PV9CPhiva9hae5CMpDyRHg8cj+QaqkdqehQ91ADMhcyRTkB8chKgdcpmOZJp6zroeP20JQ7zTpf1Em3Q5leftQNzmxchpd68sQfrkuJyrITXw130IhF38dMfNSwIf2p6Lsno980PLKtqUBlJeEZL/JUAFisfaq8qxUnOtsr0m/lccAXtxbloRtENz8vZbBD6BSdyCFuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFkIyRzFPDvq0gkt5fpei9xdZdQGrJ1oFm098aRsVY0=;
 b=euY9kQa1aulbHWlBVFLEFblNSBX4b2IgYqMSnoqJJRMD9CN9lSEAy4PV8WWwxrs5Zx5ddje9FJjhGhexwtsZ3nkVHVlfxVpJ3kNf80JEYS1QcE7qWdxjZtn4zd9xXw+oXCe09JWhrdgVCfCyJP7+B+ZVaTbkxMjn4o8Iif3igAZ9EBFnLAhQiIyt3khsJCobwAo/+CmK0QmMuDvBV0tNLV079thb32zaY8YsQ8yh/eLR149WF1BJ7eHEMNYfDGndnZva/k5tgR2Q/FzgPadZA0W2xrrk3mpPmh9fuIZYbxq0aNsw4UoRgtQbnLZOB3QCGNa7k5sHX9fw0PLxXTp2ug==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV5PR02MB11177.namprd02.prod.outlook.com (2603:10b6:408:362::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 14:42:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:42:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Probe vPCI buses asynchronously
Thread-Topic: [PATCH] PCI: hv: Probe vPCI buses asynchronously
Thread-Index: AQFxrKO58mwTdErnGMc9OIYxIQ3zNLewv9cQgADK1ICAAF09YA==
Date: Tue, 22 Sep 2026 14:42:51 +0000
Message-ID:
 <SN6PR02MB41574C84E56157D1FC2E4F86D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260907054742.235389-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157AB3B9404AF9CC43BF11FD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
 <c3345afb-7491-42c9-9e9c-609860aea515@linux.microsoft.com>
In-Reply-To: <c3345afb-7491-42c9-9e9c-609860aea515@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV5PR02MB11177:EE_
x-ms-office365-filtering-correlation-id: 991fe661-061a-4016-558b-08df18b7c773
x-ms-exchange-slblob-mailprops:
 laRBL560oLSPhlJ95/U7v6W/AahuugGakdyUFwQKZTNxtG2I8atPwHWZ37+ju9VZxdvpYO7pbCq5HeWwDYyzP7z1aBIG3VagCwP78I6dbjCOMsjd5FjvYDFBSZba/46YjXwc4SSIKTo+oGXMnzxeQ0HWvFangJxLkLox1GiQhTTG6DLNVfbYYOpceQ8Pv5a29LIpNmYZ2OHtQsYR2tuuQ+UZVg4VyIVH5O6kTb8PaKL697Ktdxr1oNOqfK/4zUxPpwAKNORszGOulYtRCWkwz/4bH0ByqvDKD9o5gZgi8vNHZNKek+e8s4ddfW65IOB/7yDmz1IjPzF0+o+7WS2aFL0yuZVH+fFsp7jNNdCkEre8RuHmy44YrgPtu6uBxTzcEPgRPCY4KaWGgcVXrmpw8m5bnrPOgrdWgHPB/jvfWuvP/sbUbmS4IAikQ8p2phViA7lfR8nmNADNmqYsRXex5Fo5m+xx8heM2uaNGEjpLtn5N0RFaPbWaMKaiBsuhGQE+EOg8glYio4In/rygoMyFOPXL9z3rOc+48Le84sMm4P5sDVJSRYQXsmXzfjfoPYmp5jokSEmYen347tzMJZ62twnynXg/ycn6q5UTqbMJrR6jqiLfxoKu7qymRnEr5vfk64taEljktUVhyvXETFSE0nw79tUniNSxD+yxDFF8PF5WI7bqTldJINxdUNW5FpzwtvQhlsMCm5aTi0Or7nXE3D32kbQWVgiEz7GbImtzBSemfEU7wUnF0PBThCep9bNeD8XQf6OkMxSzAIjvw6rljokMcze+3JV
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|12121999013|25010399006|2604032031799003|51005399006|41001999006|31061999003|55001999006|24021099003|19110799012|8062599012|8060799015|13091999003|40105399003|2607281247196008|12091999003|56899033|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmV1cWE0VXRUUjdTSEZ4cnZXakpsTDA2WkNiaUlrazZzYVNqWXBIRzJHTm1T?=
 =?utf-8?B?Nk9kb1l3YWRHbzZ0NitwaXhpTnExMVFEVkdqYng1V0ExWElFTGg0bmtGaFBr?=
 =?utf-8?B?aE1yN1F0dFdmeHVabnBZenROaWZ5LzdneUFSeXlaOWRlYXo0Q3l0Z0RVV2Q5?=
 =?utf-8?B?REMrSXFuSjZhNmxKeEZrNEhpM0NUVUIzV2x6c05SSDRJMEl1VGgwU3p2VTE5?=
 =?utf-8?B?MmlUaU1OamRWWGdYR2tsRk9Ways1SFF5T2krMGlWQVprV2tYbzA2U0xuQVRw?=
 =?utf-8?B?cnRQL0MzRFpnWjQ4a2h6Wm9TTUpheUFGRytTajF4VzNDTjAzL29NYk1hdVQv?=
 =?utf-8?B?d01qL0pNM244RmcvU3NFNkU3LzZJUzJLcUFocmFmRmFMazJhUWNsSnBwZ2JF?=
 =?utf-8?B?bDV6WVR1SitZbjdoQ05lV3RQVTh3akZ1emxKNWxjZS82MXdYN3EvbXZKYXN4?=
 =?utf-8?B?QWNNQjVacUc1WXBzSm43OXhOei9iMnM2ZkRmN0hBZTdEY01tQTh6b2VJREVl?=
 =?utf-8?B?N2trV1lxUGkzVWxBTXFPUkZxL2JoODN1aUdJay90Zy9QQk1YcDRXMFBzQnBM?=
 =?utf-8?B?bGNLa0tDb2xxemF4ZXdUM3B5bFZLYUJreHJWYUFmZlY4ME5vbDZEZEJQZlFX?=
 =?utf-8?B?VU5kQzFRK2xkaWlWZ2g0MEMxWmRId01aVS90UVNOUy9TZmc3d0R3UFRBQXdZ?=
 =?utf-8?B?dDZ1R3BtWEdNUlZyYWt3K0VrNVkrenFuODlvRDVHenJrNVdwYnZUcy84YXhs?=
 =?utf-8?B?c25KVGNDNmluN3lsUG1IUng1ZXYraGx0T0FSOUF5MkY4VGFVTC9TWmRITmhK?=
 =?utf-8?B?U2FJczJVWlJlUXVRZ3NJeEUvMk9vZ1ZnSFk2Y283VE1IeFJ2UVJPUHZtbzNV?=
 =?utf-8?B?cmZTSndQNFhUb0hGTGVYWlVXVHZMOU04NTVQMk51aXZPcVUyQ2VFKzV0Q1h4?=
 =?utf-8?B?Ry9GclR5MVRWcStSRUQzTDJLMEM3djV5SzdEYmgrUWNURzF1RjlrS1lreEZi?=
 =?utf-8?B?R2t2UWxhM3VkbEdZNEpWQ3NFQkdqS092YjRabWtTNjhSSVYrVHNFNnRMVHBq?=
 =?utf-8?B?UHZhSnhOZjhQT05Ibjc1SEoydEplQWtpNDJJdzc3QmFYMlQ5UmMvZXVJVUV2?=
 =?utf-8?B?akUwWW11MHJkbEVpKzkwMUg3UitOYTErcXR3bmhIWUZ2VHdOMkdTbm5jbFo5?=
 =?utf-8?B?VXB0eWlBUTdTYjhHdWxqcDFYR3czRkJSaHM2TG1oekxLNnJ6cXlidVUzOW9H?=
 =?utf-8?B?bTRKdkpqVUlzWVZtS2xwTGhIczUyT2NlOHpNQm53bERCYTJ2a2F4cE1IUGgv?=
 =?utf-8?B?RWhlbEwxaXR2a21lcFVwK2s4YmYrRy9kRFI5WCtqNzF5aWRUTzM2dHAyL2Fs?=
 =?utf-8?B?ZXFRbG15eVBoblVjVnBwekQ3MjM3bzJHcWdtbTVXcnhvaFl5a2xNVGRGdXZH?=
 =?utf-8?B?RGl3S3FQMTR4K1lTeGg3UDBYNWlRUzU1dUdUZ2pmTmNHQ2Y1Um5vc09XWGI0?=
 =?utf-8?B?dndtQTY2K1grUXo1TmN3SEtUV0Z6STVJb2ZTdFgzM3k3dFpBZ2NMUUxBZzA4?=
 =?utf-8?B?cVhXN1FCSHd4eGNHc3hQb2NYUHVlTTIzZFkrd0JxUE50OEQ2Q0JnMEpGT0o2?=
 =?utf-8?B?R1dxaEdOOUJWUFY4U3VZMllyejgwUHc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE9QeVNWV0xGdk9tVnZkZTlCWXVaL096dTJTMEZMOGxhTngwaHJsTnM3S1Er?=
 =?utf-8?B?QXJzNkRkdzRXdTdKNFpyRS9MOUdnazJrRnBIR2pNa0lXZWtzcHFYTS9uTnVU?=
 =?utf-8?B?UVhaQWtxSmxpdmxDNEpzWHRDUnRZNXl4WWlIb0hRVWswWkRXSXZob3k4QkQ4?=
 =?utf-8?B?UHFnQU5qQk0zMnRObGpBcjNFZUVHU0l2QmNkWTJza0NLQkgrNjNFb2lOOW16?=
 =?utf-8?B?dmJTWlFTaHhlemZxbjNER2RmZ0E2WjJRT1ZQTWtFR0QrRWY4UGpFT0NwK3Bs?=
 =?utf-8?B?dW1YUjhQZ2JaeGY2d1E3bFF3WW10b1AyZGptQisrSkVxWVhsS1JDUENKZlpL?=
 =?utf-8?B?aGY0Y25xYmxtZkN5TlVxTCszb1hqUzIwcUNqeTQ0ZE1VZTNaei8zcmpsZVpT?=
 =?utf-8?B?TU5XSVovRjRyMGozUU9GNXVCSW5yemRSemswNDY3czJuVjk2WVNKL2NOVFdL?=
 =?utf-8?B?bFhVbEFhbUo3UG05WitNT0VjQWdzZU9CSnhibVhsUWJLazh4YWJMcndnckdO?=
 =?utf-8?B?Ym44a0ZtZWx6andHSTRGbnFxdzV6VFFFZjg2KzUrK1A4eEkzUW4xTWcyN2ZF?=
 =?utf-8?B?eEF1VnhCZWJuN1JLWWpQV2dZdFhFZ0x5QjNJd2lsaTJ1MlhiWjMvdERGUlp6?=
 =?utf-8?B?a3VDWVhpL1VuSGVXSTdLQjVHcEx4cXBNVHU2bzU4dlpnS0JCU0VJMEpUQ0pZ?=
 =?utf-8?B?UWNVRU0vWVl6azU3SmxiRS9PRjcwVTFpZnhQR0ZUdmFUMTlzeGFsNExHVHBX?=
 =?utf-8?B?RFZ2bXdJc2JEUUl6Sm1RZER6R0Qzc1ZXR2IvcDc0V0NJWS81VTVNU2ZadG5T?=
 =?utf-8?B?VENrREdiMmJxRG5tU0I3TWVxY1FTVi9Od3hQanF0WklTZ2VPcHU2UTlqRVBw?=
 =?utf-8?B?ZS90ZWJjRjhxS3hrN0hvc1lvMGRJejYrM09TRlpiRkJvTnE1YXNNc0ttUzBk?=
 =?utf-8?B?UHgxS2JSMlBYS2hBZS93MjhhbmVWWnliOSszbElYY0dJMlVYejZwTXZaZjlE?=
 =?utf-8?B?SnhzNFUvWEpMTUlBd0ovMGZBQlI5SXgvN09lS29xZzBKcytHZ01vUGYxRXdK?=
 =?utf-8?B?WVlvUzd1RnRUNjNTTElIZjAxdmJGajNHcmpnbU1VSnJrM1pmQ0d3cjRIWSts?=
 =?utf-8?B?QzYySEZmcUh3cncvRjcwa0dtclE4Q01GelN2bFdSM3FzM0hXYXFKZTBFMXBQ?=
 =?utf-8?B?ZVMzOWNBRmxhV1MwNm1zbUYxWXhzQnVaZTJOa2ViL1VuemtKNlJnU2dmVys0?=
 =?utf-8?B?YkI0azlHM1NJZzFzaGc0YVdkR0hIYlA4VGg5WjFXaWZFa2U5Z2N4VWptUjdG?=
 =?utf-8?B?NTBGQllFczFYTTFyVmtVYnFISzc5YnMwNUszbGhrR2xtTms4aStobjJ3WGtS?=
 =?utf-8?B?dmZhb1pldmJtd0pRMDkvL0wvWStWVmxZK2UyNmwzVzZQZ2FIRDZBWURUb1R4?=
 =?utf-8?B?Lzg0UTJGQjcwaVJyeFlGaFNVa29ScXFLZWs5RGtZZ3k4ZFFycFUwa2JqR3dW?=
 =?utf-8?B?a1crUTI5bG1ZOVN0UlZaNkxncGlJc21SVytTMWR5RStLM0tueGxtV3U3WTJI?=
 =?utf-8?B?RkxIbnhCaWhXeFJEMEVDVEt1RmlvY0NsSkN3NmJRZkR5RmZrREdNRG84T2lD?=
 =?utf-8?B?a2hEUVNkaE5Bay9vOTNuRkZyUUlUeEg4WXYzdDZzM3F3a0wzRWx5Vmp4TXRX?=
 =?utf-8?B?WG9ZMXY0TkkvSURkblBGTUZFcjFxZS9HNktHbzYxbVJLUUxsYjBNT1Q3RVF0?=
 =?utf-8?B?Z3ltRjJ5YjJKRXVtZkRkbzlqc2NVMXAvemM5M3M3U0RJSTF0RmsvQ2p5NFVY?=
 =?utf-8?Q?RnDjd9u4zRb6YGQOKknWpXr75XDVWzVWssc8Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 991fe661-061a-4016-558b-08df18b7c773
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 14:42:51.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR02MB11177

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUdWVz
ZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjYgMjowOSBBTQ0KPiANCj4gT24gOS8yMi8yMDI2IDI6Mzkg
QU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE5hbWFuIEphaW4gPG5hbWphaW5A
bGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgNiwgMjAyNiAxMDo0
OCBQTQ0KPiA+Pg0KPiA+PiBPbiBIeXBlci1WIGd1ZXN0cyBlYWNoIHZpcnR1YWwgUENJIGJ1cyBp
cyBlbnVtZXJhdGVkIGJ5IGl0cyBvd24NCj4gPj4gaHZfcGNpX3Byb2JlKCkgY2FsbC4gVGhlIHBy
b2JlIHBlcmZvcm1zIHNldmVyYWwgc3luY2hyb25vdXMgaG9zdA0KPiA+PiByZXF1ZXN0L3Jlc3Bv
bnNlIGV4Y2hhbmdlcyB3aGlsZSBuZWdvdGlhdGluZyB0aGUgcHJvdG9jb2wsIHF1ZXJ5aW5nIGJ1
cw0KPiA+PiByZWxhdGlvbnMsIGVudGVyaW5nIEQwLCBhbmQgcmVwb3J0aW5nIGFsbG9jYXRlZCBy
ZXNvdXJjZXMuIFRoZXNlIHdhaXRzDQo+ID4+IGFyZSBsYXRlbmN5LWJvdW5kIHJhdGhlciB0aGFu
IENQVS1ib3VuZC4NCj4gPj4NCj4gPj4gaHZfcGNpIHJlZ2lzdGVycyBhcyBhbiBvcmRpbmFyeSBW
TUJ1cyBkcml2ZXIsIHNvIGRyaXZlcl9yZWdpc3RlcigpIHdhbGtzDQo+ID4+IG1hdGNoaW5nIHZQ
Q0kgYnVzZXMgYW5kIHByb2JlcyB0aGVtIHNlcXVlbnRpYWxseSB3aGlsZSB0aGUgZHJpdmVyJ3MN
Cj4gPj4gaW5pdGNhbGwgcnVucy4gT24gZ3Vlc3RzIHRoYXQgZXhwb3NlIHNldmVyYWwgZGV2aWNl
cywgZWFjaCB0aHJvdWdoIGl0cw0KPiA+PiBvd24gdlBDSSBidXMsIHRoaXMgc2VyaWFsaXphdGlv
biBhZGRzIHRoZSBob3N0IHJvdW5kLXRyaXAgbGF0ZW5jaWVzIHRvDQo+ID4+IGRldmljZSBpbml0
aWFsaXphdGlvbi4NCj4gPj4NCj4gPj4gRWFjaCBidXMgaXMgZGVzY3JpYmVkIGJ5IGl0cyBvd24g
c3RydWN0IGh2X3BjaWJ1c19kZXZpY2UsIHNvDQo+ID4+IGluZGVwZW5kZW50IGJ1c2VzIGNhbiBi
ZSBwcm9iZWQgY29uY3VycmVudGx5LiBSZXF1ZXN0IGFzeW5jaHJvbm91cw0KPiA+PiBwcm9iaW5n
IHZpYSBQUk9CRV9QUkVGRVJfQVNZTkNIUk9OT1VTLCBjYXVzaW5nIHRoZSBkcml2ZXIgY29yZSB0
bw0KPiA+PiBzY2hlZHVsZSBtYXRjaGluZyBidXNlcyBmb3IgYXN5bmNocm9ub3VzIHByb2JlIHdv
cmsuDQo+ID4+DQo+ID4+IE9uIGFuIEF6dXJlIFN0YW5kYXJkX0wzMnNfdjMgZ3Vlc3Qgd2l0aCBm
aXZlIHZQQ0kgdGFyZ2V0cyAoZm91ciBOVk1lDQo+ID4+IGNvbnRyb2xsZXJzIGFuZCBvbmUgTWVs
bGFub3ggVkYpLCBMaW51eCA3LjIuMyB3YXMgdGVzdGVkIHdpdGggb25lIHdhcm0tdXANCj4gPj4g
YW5kIHRocmVlIG1lYXN1cmVkIGJvb3RzIHBlciB2YXJpYW50LiBUaGUgbWVkaWFuIGludGVydmFs
IGZyb20gdGhlIGZpcnN0DQo+ID4+IGh2X3BjaV9wcm9iZSgpIGVudHJ5IHRvIHRoZSBsYXN0IHJl
dHVybiBkZWNyZWFzZWQgZnJvbSAyODQ3Ljk2OCBtcyB0bw0KPiA+PiAyNzg2LjcwOSBtcywgYSA2
MS4yNTkgbXMgKDIuMTUlKSBpbXByb3ZlbWVudC4NCj4gPg0KPiA+IFRoZSBlbGFwc2VkIHRpbWUg
aW1wcm92ZW1lbnQgaXMgcmF0aGVyIGRpc2FwcG9pbnRpbmcgZ2l2ZW4gdGhlDQo+ID4gY29tcGxl
eGl0eSBvZiB0aGUgcHJvYmluZyBzZXF1ZW5jZSBhbmQgdGhlIG51bWJlciBvZiBpbnRlcmFjdGlv
bnMNCj4gPiB3aXRoIHRoZSBIeXBlci1WIGhvc3QuIERvIHlvdSBoYXZlIGFueSBpbnNpZ2h0IGlu
dG8gd2h5IHRoZXJlIGlzbid0IGENCj4gPiBsYXJnZXIgcmVkdWN0aW9uPyBJcyBzb21ldGhpbmcg
bW9zdGx5IHNlcmlhbGl6aW5nIHRoZSB3b3JrIGV2ZW4gdGhvdWdoDQo+ID4gUFJPQkVfUFJFRkVS
X0FTWU5DSFJPTk9VUyBpcyBzcGVjaWZpZWQ/DQo+ID4NCj4gPiBNaWNoYWVsDQo+ID4NCj4gDQo+
IEkgY2FuIHNlZSB0aGVzZSByZWFzb25zIGZvciBub3Qgc2VlaW5nIGdyZWF0IGltcHJvdmVtZW50
czoNCj4gMS4gVGltaW5nIG9mIGRldmljZSBvZmZlcnMgZnJvbSB0aGUgaG9zdCBpcyBiZXlvbmQg
dGhlIGNvbnRyb2wgb2YgZ3Vlc3QNCj4gYW5kIHRoZSBIeXBlci1WIGhvc3QgbWF5IGFsc28gYmUg
c2VyaWFsaXppbmcgdGhlIHJlcXVlc3RzIGZyb20gdGhlIGhvc3QuDQoNCkFoLCByaWdodC4gVGhp
cyBpcyBwcm9iYWJseSB0aGUga2V5IGZhY3Rvci4NCg0KPiAyLiBTaGFyZWQgbG9ja3MgdGhhdCBu
ZWVkcyB0byBiZSBoYW5kbGVkIHNlcGFyYXRlbHk6DQo+ICAgICAqIGh5cGVydl9tbWlvX2xvY2sg
ZHVyaW5nIFZNQnVzIE1NSU8gYWxsb2NhdGlvbi4NCg0KVGhpcyBwcm9iYWJseSBoYXMgbWluaW1h
bCBpbXBhY3QuIFdoaWxlIHRoZXJlJ3MgYSBkZWNlbnQgYW1vdW50DQpvZiBjb2RlIHByb3RlY3Rl
ZCBieSB0aGUgbG9jaywgSSBkb24ndCB0aGluayB0aGVyZSdzIGFueSBpbnRlcmFjdGlvbg0Kd2l0
aCB0aGUgaG9zdCAoZXZlbiB2aWEgdHJhcHMpLCBzbyBpdCBzaG91bGQgcnVuIHF1aWNrbHkuDQoN
Cj4gICAgICogcGNpX3Jlc2Nhbl9yZW1vdmVfbG9jayBkdXJpbmcgUENJIHJlc291cmNlIGFzc2ln
bm1lbnQgYW5kIGRldmljZQ0KPiBhZGRpdGlvbi4NCg0KT0suIEkgZG9u4oCZdCBrbm93IGFib3V0
IHRoaXMgb25lLg0KDQo+IA0KPiANCj4gSSBkaWdnZWQgbW9yZSBpbnRvIGl0LCBhbmQgaXQgaXMg
aW5kZWVkIGJlY2F1c2Ugb2YgbGF0ZSBvZmZlcnMgZnJvbQ0KPiBIeXBlci1WLiBJIHdhcyBjb25z
aWRlcmluZyB0aGUgc3RhcnQgb2YgZmlyc3QgcHJvYmUgdG8gdGhlIGxhc3QgcmV0dXJuLA0KPiBm
b3IgdGltZSBjYWxjdWxhdGlvbnMuDQo+IA0KPiBGb3IgdGhlIDQgUENJIGRldmljZXMgb24gbXkg
c2V0dXAgd2hvc2Ugb2ZmZXJzIHdlcmUgZGVsaXZlcmVkIHRvZ2V0aGVyLA0KPiB0aGUgcGVyZm9y
bWFuY2UgaW1wcm92ZW1lbnQgd2FzIGFib3V0IDI0JS4gSG93ZXZlciB3aXRoIHRoZSBsYXN0IG9m
ZmVyDQo+IGNvbWluZyBsYXRlIGZvciBNTFggUENJIGRldmljZSwgb3ZlcmFsbCBpbXByb3ZlbWVu
dCBpbiB0aW1lIHdhcyBsZXNzZXINCj4gaW4gdGVybXMgb2YgcGVyY2VudGFnZS4NCg0KRm9yIHRy
YWRpdGlvbmFsIGNvbmZpZ3Mgd2hlcmUgdGhlIFZGIE5JQyBpcyBwYWlyZWQgd2l0aCBhIG5ldHZz
Yw0KaW5zdGFuY2UsIHRoZSBob3N0IGRvZXNuJ3Qgb2ZmZXIgdGhlIFZGIE5JQyB0byB0aGUgZ3Vl
c3QgdW50aWwgdGhlDQpjb3JyZXNwb25kaW5nIG5ldHZzYyBpbnN0YW5jZSBoYXMgYmVlbiBwcm9i
ZWQgYW5kIHRoZSBuZXR2c2MNCmRyaXZlciBoYXMgdG9sZCB0aGUgaG9zdCBpdCB3aWxsIGFjY2Vw
dCBhIFZGIE5JQy4gSW4gdGhlc2UgY2FzZXMsIHRoZQ0KTWVsbGFub3ggb3IgTUFOQSBWRiBOSUMg
ZGV2aWNlIGlzIGFsd2F5cyAibGF0ZSIgYW5kIHByb2JhYmx5DQpzaG91bGRuJ3QgYmUgaW5jbHVk
ZWQgd2hlbiBkZXRlcm1pbmluZyB0aGUgc3BlZWQtdXAgb2YgZG9pbmcNCmh2X3BjaSBwcm9iaW5n
IGFzeW5jaHJvbm91c2x5Lg0KDQo+IA0KPiBEZXh1YW4gaGFkIHJlbW92ZWQgcGNpX3Jlc2Nhbl9y
ZW1vdmVfbG9jayBpbiBoaXMgcHJldmlvdXMgdXBzdHJlYW0NCj4gYXR0ZW1wdCwgYnV0IEkgb21t
aXR0ZWQgaXQgaW50ZW50aW9uYWxseSB0aGlzIHRpbWUgYmVjYXVzZSBmcm9tIEFJDQo+IHJldmll
dywgSSBzYXcgYSBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24gdGhhdCB3ZSB3b3VsZCBpbnRyb2R1
Y2UgaWYgd2UNCj4gcmVtb3ZlIGl0LiBTZWNvbmRseSwgSSBkaWQgbm90IG9ic2VydmUgYW55IGJl
bmVmaXRzIG9mIHJlbW92aW5nIHRoaXMNCj4gbG9jay4gQnV0IEkgYW0gZ29pbmcgdG8gcmV2aXNp
dCBpdCBhZ2Fpbi4NCg0KVGhhbmtzIGZvciB0aGUgZGlzY3Vzc2lvbi4gVXNpbmcgUFJPQkVfUFJF
RkVSX0FTWU5DSFJPTk9VUw0KaXMgc3RpbGwgYSBnb29kIHRoaW5nIHRvIHVzZSwgYnV0IHRoZSBi
ZW5lZml0IHdpbGwgYWNjcnVlIHRoZSBtb3N0IHdoZW4NCnRoZXJlIGFyZSBhIHNpZ25pZmljYW50
IG51bWJlciBvZiBOVk1lIGRldmljZXMgYW5kIHdoZW4gSHlwZXItVg0KaXMgcXVpY2sgYWJvdXQg
b2ZmZXJpbmcgdGhlbS4gQXMgSSBkZXNjcmliZWQgYWJvdmUsIGl0IHdpbGwgYmUgaGFyZGVyDQp0
byBnZXQgcGFyYWxsZWxpc20gd2l0aCB0aGUgVkYgTklDLg0KDQpNaWNoYWVsDQo=
