Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013085.outbound.protection.outlook.com [52.103.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D64F4D09;
	Mon, 21 Sep 2026 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025048; cv=fail; b=Ev1D7PKTNays2jklPjHrTLgObIhIjj1xL+PThtfKQIaNWvYjiBVTHIZR36puLNFVR1mayAM3sMGpYF96N1AaLc7P4120DzlIc2vV8SwelEIbNFOGBPhVPT4p7y7T+B9eNBwODc+BvC7gQ5u/0JlpLVHZTkQLJmWuvfM7CF/IbPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025048; c=relaxed/simple;
	bh=0td9yq3c/mTCg2tNVc43QZhJP/nX8XgwdEpZmWKhth8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQ3isq9C96fLjIEFhFkT3hpsCx+35mzzv5fzNOw37hnnUDUsVm7HpOJU0ixYk6PJmIO7V0jr/jaHgbQzU7jrfhssBBPx7aED88rzM+Ofzl4I+SJZ8Pl+PmaYshjTfYQY540D0UbHmNbV8FAd7+9Msoh5YM79xiMMUFfp06gLrHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UwJ2WxLD; arc=fail smtp.client-ip=52.103.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UwJ2WxLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpmICCElMbSOFi6PhG34kAC5Gk1EtFkb6S6zOLJVpP7Wbtc7XayIn3/7DMtSFoI3xxf3RrWBxOMziUPW/7KUG2ULq8E6gxomx1Z0zfH+N1+EQVKJoDJuiYljt6ZBzuak0k3jei3wuQAXubuVEdUcKT31biS8kxtt8wZUTm1UOxgDEUBvRJ5oX8bwbOO2QS3wbhZZytNalXAKZsnFw3n0CeTJdljwSvoWTz1d4maR/jPWqwP3YneYS/UViNR0vqOahSjiRr2RkmKsU8uVH6TZ6SjPacg49FFJO3hkgR/LYZCL7kI7zstho0OoHb2swXTdyxnf0qiAk6xs2qBicodfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0td9yq3c/mTCg2tNVc43QZhJP/nX8XgwdEpZmWKhth8=;
 b=a135vJeM2HsLGSn7DyBOwjJOWK16bB8phMQb4omcJgcBuePs82IeOm4pcVTEsIvxYc9GrhE4xdsakgTfmVxusqtNvVuzNTwbvYl1tmy68DJgm0EPtKeSLKsAJLthdvUjMSMC/ppk2EYpPz0CxTTPwMz8dPJnKHnOlycU3ZXfBqdh0gSaOTmR46jUeG0DJpgS73dZuNik5a5fqYnsrFv6O6fFgF49JjhnYY4wOi1gICDchyuatYtzD2YuDlEL8m8kyDszvFVnTrCip1qJBa15se2B5TP3Pz7DPgyIaDcQUr708WmfSvr7U+YDmG6SH+nRNJ/JlaClkzAQdw83x+WPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0td9yq3c/mTCg2tNVc43QZhJP/nX8XgwdEpZmWKhth8=;
 b=UwJ2WxLDvmmnazSWHteUTBSfnaRGF1DBtVxhtQt3587Qm8SCeGmiCZ3jWj8jV/RADh5BEDSvuiWrH22peoVfXqWoLsz423cpv4Gm9sbUrfS8c7KHWebqvbMewRP7Gyc1ZK02J8j+V1xYBgRGaiwakVwPer0LRY1MmislJemfFkbNSygAPwLlhTemJiY8HvRoCWkCvCM8ndHOHFnqVA3nPgwlQf799ddV8zlOU+TQGej426HMVfF+7d85hJjWLtXNGDZWUINTxhyYdtETCz7lxwA9uWxAmudsAv5w/hNSbB95OyomUlui02zP/YrbEhn+NZ1+eSPZt65ixBphOS6fsQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB11588.namprd02.prod.outlook.com (2603:10b6:8:394::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 21:09:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 21:09:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Probe vPCI buses asynchronously
Thread-Topic: [PATCH] PCI: hv: Probe vPCI buses asynchronously
Thread-Index: AQFxrKO58mwTdErnGMc9OIYxIQ3zNLewv9cQ
Date: Mon, 21 Sep 2026 21:09:33 +0000
Message-ID:
 <SN6PR02MB4157AB3B9404AF9CC43BF11FD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260907054742.235389-1-namjain@linux.microsoft.com>
In-Reply-To: <20260907054742.235389-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB11588:EE_
x-ms-office365-filtering-correlation-id: 202e7fcc-4d8e-46b4-1ce0-08df1824a26f
x-ms-exchange-slblob-mailprops:
 8U9+OAG/EBKkI8GgeR43xRMrZ/+qH0EF51qnm5S/Co3g7AO+g4pyj9V43z6NVG5K/o205smHwEy88p1wySWl41hOxuo42vYXgWFdmsRWMnKd0WA1aFGxwRbPS7hD4iywlwNLZ/newHdp7oLxmT62gzVLRD8ZbwucYahMeYKGbs8DmLGMbJdpTV4SNkN++nnoZQoUwqqarzbSxiF5e8U9hZJH/A8s7m+VsttNMLQMSfXLGwXLX+rHC2ZZ3vA+DBT7cdFi69i1zXvXG1Hm1rEQlQalojUuNf4wp0x0rOFfhc50iiiPAvk1hpqQVnfjDG4CF2AdpLgsgBGIe5KGhzvkQQAMGfhJJpECuZaQSq2uRtWfDaChn4LTr6xrG7ABG64c4VI0nOBBMMfXOiJ/shlzz6whbMNt4DVojS3bNWjPwg46IqHm4GTqGQCRBaLGVWlvWjiGkHBOGhr/4wUImGtPcCtBGdpoOtuUod/MNy2CIDPf7qUMceNy8WTh5BqRz+gz19u09cGrANsnxTLXe6wkmgFdV/VnNAGhZzAuBQwt2cR6fHRLmE7rOT7p9rZnGldQMVFeKpA41IT6Agsk+mIkE5Y1xCxXm5hJxdjXJy2CBcS5EkkcHobgTKv/LVIu/QffxOM7OBRjdimbW2w9ItPemRXMBjtWbxLGl/G51HlAPk4PTpepLMfFDBXePuBesqPRhWtj2GlA43FhOS3okFIDcvcBdBEzQmKXXxf8HYhXTgl7+BJwtp0rz+eKXoAMaAnTS8QoRbshUBaIDpu9CAAikXRJJNTmoGO3p9JGiipBJCUHW0j4GIr9+Z1/uge8HUbAlqJuzadiS7tEVlDnKnuxow==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|2604032031799003|41001999006|37011999003|24021099003|13091999003|8062599012|31061999003|8060799015|19110799012|51005399006|25010399006|55001999006|16051099003|440099028|3412199025|4302099013|102099032|1602099012|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjdUc3VXUjlRK3JqcEhCdm1PUDRxSWcwTk9MT1BBSWV2WXdYSTFPb1UxeUg1?=
 =?utf-8?B?eHRFZ3g2ekk1UzJFTE52N0VPVEJBRWVvQ3QybHZQMzJ3eVVNNjhlSUV6NHBs?=
 =?utf-8?B?elU4LzFmWEk4NFBuMW9rSWVBZnBOM2Mwb1dwY1QrQzA1aUtOV2hNSHZMNm9Z?=
 =?utf-8?B?dGo5VFVJbDJYK2ZCRDhKbGxqNHk2OHlKdFZ5Z3pMZlJmMGNYbitNcFNpanJX?=
 =?utf-8?B?aVhjcGhDR3JjeWZuc01oQVFmRVQva0Z0UzB4ekFhSGY3NEsySDhWSVZmWW14?=
 =?utf-8?B?bEIySVZqMStMeWowNE9jYW13ZEtzMFVDamhNZUJETlRmc2FWRFBxTzZralBC?=
 =?utf-8?B?MUZINlZ2M1l4ZktWTWJoOXdkNmZKdTJnK3NDelp3NTgva25zTGcyZjBBMExj?=
 =?utf-8?B?eFpoMnR1am1waUZiekZRZDdXL1dxdkRpTnEwTTNOc0ErSXZSOE01Z0s0L0Ju?=
 =?utf-8?B?MUw4ckFZOTVWUDQvZU9uUitUUXEzMFlCM0FiZFJmRjllb0hmaWV5RG01cWhN?=
 =?utf-8?B?UWZDQWcxbjhrekhQbFBXVGV3MWxhTW9uZTJBQ0hiN0gvaEtNQ1ZmYy9UVDRO?=
 =?utf-8?B?TGtYdWdTakxjTnhqRDJqRXQrZG5XS09NZUVRYUhyYzNzbGRTZFY5UUlmb1My?=
 =?utf-8?B?N0FTcXl1ZmR2R2R6TzU4ZUtxcStVdkZ0bitwWm5jV2JySWlIYjBsQThxa3Yz?=
 =?utf-8?B?T0YrbExXaC9YUTlNdmllV2VUd3lJUzk2dlR0THROVWlPZDE4VjF2MUlaNkNl?=
 =?utf-8?B?UjdRTmNKbURKSmFiZGJXcTlKMjY3UWJyVnMvRitlSjRWWEl5cUdrVFBsY2xF?=
 =?utf-8?B?N043dVJxRXI3ZHcrbTcwZlJYQzduUXZhWmtYZFFabHJicEI5Q3loWW14YnhO?=
 =?utf-8?B?WnM0dXRQbjErMDIxWHpSaXFlWTJpS1VVU1hobzRMbTA2eDdtd2hHMlFMQ3hy?=
 =?utf-8?B?Mm9lczVPWmd5VnY2Q3BTZGxGcjFISnk4VlZnRk83SEE4SUlVeFZyczRxY3Ex?=
 =?utf-8?B?UnUvYTd4ekZOWXhhYTZ4alE2TytCVG0yUnRTQzhkbUozaVFLYU9BbWxEMFM3?=
 =?utf-8?B?aDliZjlCQURxS2Y3bHBIL2RtUXlzSnU1eFpWZHpuZCtYdFdOUzhOMGFOUzhZ?=
 =?utf-8?B?NG90TUNTWjV5TDlPMURDV1VjZlF4TmYrMW5ZTHBiU0M1WElTamtIYjI4dnVP?=
 =?utf-8?B?MXhIZ1gyRFByKzBaVGdQdzFBdFRiRE9QU21RUHhWeEREaFFhTnFja3h3dFlK?=
 =?utf-8?B?OEtYSHdadlpGS3pITTJoTVJWNVBJVzh6SDBldml1Zkpmek96dlpjTDRTaXBC?=
 =?utf-8?B?Szh1UWoxdlBkSFVMeFhyeGRwU3dub1FnRUczYnNpWmwrS2NpY3RFRFROdHVm?=
 =?utf-8?B?RWdIM0p3TWNjYW82M295VW54SHV6SWNERFFPTDIyRnZaTTAwV1crc05vMzFp?=
 =?utf-8?B?SlhsaXc5aEFuMFdqWXFsbnpNY2o2dlA4RHZ4ZDIxdXpRbFFoTUpEL0JJOUh1?=
 =?utf-8?B?ajQvblp2dm9nUXdtYUYyNFI0UmgvcXVnajdYQTdBdkRUM0d1aE9WdE1HUVdy?=
 =?utf-8?Q?OBNSj9096ug2B8bQHhWspYv8DBIM9Nre+MHv3XXRqc1oR8?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWQzdjFzSEtjck1SUTM3ZXYwVlgySnZLNngvRER0amY1N1hGOTI3VzFlMTdF?=
 =?utf-8?B?aXJrNWU4dlNVeEE4UFhyZ3ZjMUlxaHIrWEZoVk5ndGU1Y1RPTjh0QjA3aERV?=
 =?utf-8?B?MXdaYWltejZuUm1TSGhva0ppVm05dUJRNGppZ1NGZkRNWjVSOTVNdy8rZ3JL?=
 =?utf-8?B?NGpUaUpCK21FdlZUaG56VkZvOGxaUUtxeHNybWk0U3J2YVV3K1RVc3FCRkF1?=
 =?utf-8?B?dEk1NUNsNm9QRXh3YWpkNjZoc2ZHNklycVlIMjNYbm9pZ3hFQTE3enkvcVpq?=
 =?utf-8?B?UktMMGVMMWxaMVcwRmNtS2xFWDA1cU1SbTdCRzJXaVRwTUx0YW5mUnVRdGd3?=
 =?utf-8?B?WVZIQ3I3cHk5elFGWWZRK09jYWppT3VrMHlyMVJmNENWbkxGUUREUG5zQzc3?=
 =?utf-8?B?RmlsNm13b0dpVktMYlB5QmFvNUdKbmpOdDliUTMvZ3ZJU2xrMFc4K3JsbXND?=
 =?utf-8?B?UHBMMXd3V3ZWWVVJL25VSXZ4dXRINUdSQURnb0U2SDJXam1sT0FmZmpSMjFr?=
 =?utf-8?B?YWhuNkJHSFcvK3UyQzA5VkE5L2VkOXhYMWw1TjBZcDROTWIxYmI4MVRxamdL?=
 =?utf-8?B?VGZyRnptcUxoVzhSclhtV01NOW1KdXBYYTJXOXltcFNjblhwaWdENEE2a3M3?=
 =?utf-8?B?NE5RTmpEYmZsOEJSOUhrdG5hY29aWXVwdmQyWW9NNU9XSjFBc0pqQkY3NVAr?=
 =?utf-8?B?MERmUTQ3b3NxaUF6eWhoaWRzV0xXSStBSmhleUFHZ1FDeHZRKzZkUSs2VEFn?=
 =?utf-8?B?cm9PazNiVHM2YjBZUi9UanAzbEovYVZVSTlRYkRrT2ZZRjQwS2p4N2tvTzJM?=
 =?utf-8?B?U0JiSnB4MTU5UmNjVkNlQjlOak1uR000aCt5QzAyUDkxU3Jaay9od2JsZEJp?=
 =?utf-8?B?OEZVeHdYMVNNcW9STjRqVFYweFFLUVMzVTVyTzNZRDVjUGdHV0ROZTN0eGtz?=
 =?utf-8?B?anFBMWtERnZWMG82WlpUaUdDa2FOZWhwOER5cU9QSGwrYmVkd01sQ2lhVE5E?=
 =?utf-8?B?azBsT1lQSU1sL2ZtWldKS2lEbllmRUJMTW9ZaithVUNXVmpDbW9mL3R4V2V1?=
 =?utf-8?B?S3dUWUFIYmF4WHVQaXd6ZkRTbmJzcFlJZ1J6WWJ6b0praS9zWUs4YzE1RUdl?=
 =?utf-8?B?YVltZWdPZG5lZ2tBMzR0eHdEU0MydU1xUU5DaklwVXlUeEtaWm9CMjZuUVZ4?=
 =?utf-8?B?SWhzVllhdnRXcnlkekVKVjloZ1R3ODlidFRDcU1kbmNWTnJnbWJ5REpId29k?=
 =?utf-8?B?MXZPbks5SHpxbUllUnFJY2tNNGI2dUN6SWJTNkdNeFRBNTlyd2dncEg5ZE5F?=
 =?utf-8?B?UlAwc1FJOENNY2U2ZFZ6MlpRVDVOc0JLWGR4ZjZuazBHUFRSRXgrMkRGUEwr?=
 =?utf-8?B?b2V2eWN2VnVieVQxdmZrVnZGNkhpa1ZoOUVHMHpSNnh2ZjBoQSt6RXJqQVd0?=
 =?utf-8?B?aWV0VzN5MjZCSE9uR0laQnZFS3hpRHlyOGlTK0FUSjl4QnRHUGtWNktxNUtt?=
 =?utf-8?B?RUwxaVFDU1I0NmNSWTNKeWRQN2hVZ1RhcktrTFE0cUNrQTlsWVJLb3llTFFF?=
 =?utf-8?B?Y3FRVkpMT2IxaGdXeWZ2c0JGUkNxMGNXc3FpK3B0WVNzcHZPNVBSMk02K3hG?=
 =?utf-8?B?UjltN3BBSDZzODhYL0xaV3F2ZU05b1lEd0xQb1BadDFZa2dnTDAwQSt3WkJq?=
 =?utf-8?B?Z1EzdDBGOXVvdVRpM1FSMnpzL1Y4ZFFQMXhYU0lISkhMeWEvT2ZsamlGRXQw?=
 =?utf-8?B?NENLRWQ4VnFZaVJrYVdyNjZiUEUyaEN6bUlxNjR4S1RMMURQZlhsWlVzVFo5?=
 =?utf-8?Q?4sOk6aUVrh8lzgVVhKZbhTv1N0LsByX0OsfZs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 202e7fcc-4d8e-46b4-1ce0-08df1824a26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 21:09:33.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11588

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBTdW5k
YXksIFNlcHRlbWJlciA2LCAyMDI2IDEwOjQ4IFBNDQo+IA0KPiBPbiBIeXBlci1WIGd1ZXN0cyBl
YWNoIHZpcnR1YWwgUENJIGJ1cyBpcyBlbnVtZXJhdGVkIGJ5IGl0cyBvd24NCj4gaHZfcGNpX3By
b2JlKCkgY2FsbC4gVGhlIHByb2JlIHBlcmZvcm1zIHNldmVyYWwgc3luY2hyb25vdXMgaG9zdA0K
PiByZXF1ZXN0L3Jlc3BvbnNlIGV4Y2hhbmdlcyB3aGlsZSBuZWdvdGlhdGluZyB0aGUgcHJvdG9j
b2wsIHF1ZXJ5aW5nIGJ1cw0KPiByZWxhdGlvbnMsIGVudGVyaW5nIEQwLCBhbmQgcmVwb3J0aW5n
IGFsbG9jYXRlZCByZXNvdXJjZXMuIFRoZXNlIHdhaXRzDQo+IGFyZSBsYXRlbmN5LWJvdW5kIHJh
dGhlciB0aGFuIENQVS1ib3VuZC4NCj4gDQo+IGh2X3BjaSByZWdpc3RlcnMgYXMgYW4gb3JkaW5h
cnkgVk1CdXMgZHJpdmVyLCBzbyBkcml2ZXJfcmVnaXN0ZXIoKSB3YWxrcw0KPiBtYXRjaGluZyB2
UENJIGJ1c2VzIGFuZCBwcm9iZXMgdGhlbSBzZXF1ZW50aWFsbHkgd2hpbGUgdGhlIGRyaXZlcidz
DQo+IGluaXRjYWxsIHJ1bnMuIE9uIGd1ZXN0cyB0aGF0IGV4cG9zZSBzZXZlcmFsIGRldmljZXMs
IGVhY2ggdGhyb3VnaCBpdHMNCj4gb3duIHZQQ0kgYnVzLCB0aGlzIHNlcmlhbGl6YXRpb24gYWRk
cyB0aGUgaG9zdCByb3VuZC10cmlwIGxhdGVuY2llcyB0bw0KPiBkZXZpY2UgaW5pdGlhbGl6YXRp
b24uDQo+IA0KPiBFYWNoIGJ1cyBpcyBkZXNjcmliZWQgYnkgaXRzIG93biBzdHJ1Y3QgaHZfcGNp
YnVzX2RldmljZSwgc28NCj4gaW5kZXBlbmRlbnQgYnVzZXMgY2FuIGJlIHByb2JlZCBjb25jdXJy
ZW50bHkuIFJlcXVlc3QgYXN5bmNocm9ub3VzDQo+IHByb2JpbmcgdmlhIFBST0JFX1BSRUZFUl9B
U1lOQ0hST05PVVMsIGNhdXNpbmcgdGhlIGRyaXZlciBjb3JlIHRvDQo+IHNjaGVkdWxlIG1hdGNo
aW5nIGJ1c2VzIGZvciBhc3luY2hyb25vdXMgcHJvYmUgd29yay4NCj4gDQo+IE9uIGFuIEF6dXJl
IFN0YW5kYXJkX0wzMnNfdjMgZ3Vlc3Qgd2l0aCBmaXZlIHZQQ0kgdGFyZ2V0cyAoZm91ciBOVk1l
DQo+IGNvbnRyb2xsZXJzIGFuZCBvbmUgTWVsbGFub3ggVkYpLCBMaW51eCA3LjIuMyB3YXMgdGVz
dGVkIHdpdGggb25lIHdhcm0tdXANCj4gYW5kIHRocmVlIG1lYXN1cmVkIGJvb3RzIHBlciB2YXJp
YW50LiBUaGUgbWVkaWFuIGludGVydmFsIGZyb20gdGhlIGZpcnN0DQo+IGh2X3BjaV9wcm9iZSgp
IGVudHJ5IHRvIHRoZSBsYXN0IHJldHVybiBkZWNyZWFzZWQgZnJvbSAyODQ3Ljk2OCBtcyB0bw0K
PiAyNzg2LjcwOSBtcywgYSA2MS4yNTkgbXMgKDIuMTUlKSBpbXByb3ZlbWVudC4NCg0KVGhlIGVs
YXBzZWQgdGltZSBpbXByb3ZlbWVudCBpcyByYXRoZXIgZGlzYXBwb2ludGluZyBnaXZlbiB0aGUN
CmNvbXBsZXhpdHkgb2YgdGhlIHByb2Jpbmcgc2VxdWVuY2UgYW5kIHRoZSBudW1iZXIgb2YgaW50
ZXJhY3Rpb25zDQp3aXRoIHRoZSBIeXBlci1WIGhvc3QuIERvIHlvdSBoYXZlIGFueSBpbnNpZ2h0
IGludG8gd2h5IHRoZXJlIGlzbid0IGENCmxhcmdlciByZWR1Y3Rpb24/IElzIHNvbWV0aGluZyBt
b3N0bHkgc2VyaWFsaXppbmcgdGhlIHdvcmsgZXZlbiB0aG91Z2gNClBST0JFX1BSRUZFUl9BU1lO
Q0hST05PVVMgaXMgc3BlY2lmaWVkPw0KDQpNaWNoYWVsDQoNCj4gDQo+IENvLWRldmVsb3BlZC1i
eTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGV4
dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmFtYW4gSmFp
biA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gDQo+IFByZXZpb3VzIGRp
c2N1c3Npb24gYXJvdW5kIHRoaXMgY2hhbmdlOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMzA0MjAwMjQwMzcuNTkyMS03LWRlY3VpQG1pY3Jvc29mdC5jb20vDQo+IA0KPiBTa2lw
cGluZyByZW1vdmFsIG9mIHBjaV9yZXNjYW5fcmVtb3ZlX2xvY2ssIGR1ZSB0byBwb3NzaWJsZQ0K
PiBzeW5jaHJvbml6YXRpb24gcHJvYmxlbXMgYXNzb2NpYXRlZCB3aXRoIHRoaXMgbG9jayByZW1v
dmFsLiBBbHNvLCB3aXRoDQo+IG15IGN1cnJlbnQgc2V0dXAsIEkgd2FzIG5vdCBhYmxlIHRvIHNl
ZSBtdWNoIGltcHJvdmVtZW50cyB3aXRoIHRoaXMNCj4gY2hhbmdlLCBzbyBrZWVwaW5nIGl0IGZv
ciBsYXRlci4gQXN5bmNocm9ub3VzIHByb2JpbmcgY2hhbmdlIGlzIG5vdA0KPiBkZXBlbmRlbnQg
b24gdGhpcy4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2
LmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gaW5kZXggODk4MTZhMmJkN2NkMy4uMDU2ZDM3
OWIzY2VlNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2
LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gQEAgLTQx
NTUsNiArNDE1NSw5IEBAIHN0YXRpYyBzdHJ1Y3QgaHZfZHJpdmVyIGh2X3BjaV9kcnYgPSB7DQo+
ICAJLnJlbW92ZQkJPSBodl9wY2lfcmVtb3ZlLA0KPiAgCS5zdXNwZW5kCT0gaHZfcGNpX3N1c3Bl
bmQsDQo+ICAJLnJlc3VtZQkJPSBodl9wY2lfcmVzdW1lLA0KPiArCS5kcml2ZXIgPSB7DQo+ICsJ
CS5wcm9iZV90eXBlID0gUFJPQkVfUFJFRkVSX0FTWU5DSFJPTk9VUywNCj4gKwl9LA0KPiAgfTsN
Cj4gDQo+ICBzdGF0aWMgdm9pZCBfX2V4aXQgZXhpdF9odl9wY2lfZHJ2KHZvaWQpDQo+IC0tDQo+
IDIuNDMuMA0KPiANCg0K
