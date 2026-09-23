Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A33B3BE9;
	Wed, 23 Sep 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173818; cv=fail; b=Gs1CQMnhykS1qVU6B09hpCp7kdVu8nZ04+LmsXuvQ1h04lTywAAZKiwnR75mauaBbGbAikM3BJG0HSkpuJiSfIlc5+45eWZTbqEc1xF4rTM736jh8CEBIZM8HQCcieZNC9yX1Owzu7TQo5bq7AYZB+f7+j1+yevMNN2ZvUcz2q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173818; c=relaxed/simple;
	bh=jC4fK9iQSmzH4zVEemVBM3q/HcVFXlCqNn0n4j+C+8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VScwFx2mQNV6t1htBru4zGV0jLEQ5J/VGQCisKLvenLRresz35PwGwBj+whbgPbLvZxw8ok8Iu5CoguriIrmkVMfRGXGeoK2PEj5hfQDVlNXg3+pA3tcqLJZUlnkTF+gXhZxKS76VsVJ6ZOE/OiMGKs1ErcOydxQBta2LFmjkdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p5lZCIf+; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p5lZCIf+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXtqvo5HFOouvBMao0FAW6QUhKIff2RTUSSjh0gQOHCEEzgH2pR9rC+RPNQcGWSp1tWe152MPYIr3hg86CGLeF8PKJFN5FjWRJI2JhZ24qs71kbS3M126CtfbTxx3qbcsD/4zgbcmlg1Kv9IZGAYHA5XHe0lNePH+/XF7/HJB1XNXjLgbPdD7nu4t7A23d1XDDi4Fv3OUQNR0cfcqwjrFWXeh3ld/xuQakLsT24BLh1+baiNh0GgQOS+k38krH3dG6T8Ghh6+x2AdIcytyyvIa+REp7VXduVrl0zxh7G13sgnU9Q3DP6JNG7ybq7DUj/Zw9NZnBmxn6xOcX4m+je8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC4fK9iQSmzH4zVEemVBM3q/HcVFXlCqNn0n4j+C+8k=;
 b=pdwxH2z3swthdckWOnE2u6miBPLv4PndFcx+m3RRebUoX+cZ26ZVu+pQdwt4OU3fY0UqHg8nPq3gRbTgWwnux3YlW5Q73t01IT0jSzmnx3aiH72Alh1KMJkrqVgL+MeV3YRQ7zQG+sG/h8QQu6QZvGuSX3k/2pwydkPs03wsu35MXJl0AJp4zX07QpxGnaL+5HJiBa9mgJfIfTYLRS/bcxyhZ29bx9bXWc8tWb2mvLtv9ujCKN7EELvdiS61bMBEwVPtycDkBstJtzmvdTTTKPEqvzPqdoLzCv1C0vY0l4hh3Bm6xFC+Cf3wDUnNasoUdcsdcCKeVxH4sxA15SA2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC4fK9iQSmzH4zVEemVBM3q/HcVFXlCqNn0n4j+C+8k=;
 b=p5lZCIf+/7Qsys7Ck7fCaQynBCriGzdvXx2UKrjDKh1i5U8uFPL3UMX24Yg+ImDWjMrHMk26SNjtr9kC1pUXqf+AX69KOGw5XVwYy5oI7yboLi+WFXOh9vUxinqMeNeaBe1P1zETk494q+V1n9m0Euk8MPWtkuBIzQZXThKjc29/TGh3MYI0yc6LigKrkOdhB3BorDUo35wC9b9O0++YjyPB3oKG8JD5bfUbjKLso5cns/aReUoRPN/MS94fPkjqKdVpfVWREtTGjS1kXjCL38X5BYvfL+Vdj//xvSp5IXqGHB5R0xnyk1k0IwhzqGgXfhq5g5etNkVYBlLoH7f5uA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS2PR02MB159176.namprd02.prod.outlook.com (2603:10b6:8:70a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 14:30:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:30:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Wei Liu
	<wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: Long Li <longli@microsoft.com>, Nam Cao <namcao@linutronix.de>, Joerg
 Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Kees Cook
	<kees@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Radu Rendec
	<radu@rendec.net>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Dmitry Ilvokhin <d@ilvokhin.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Thierry Reding <treding@nvidia.com>, Jiri
 Wiesner <jwiesner@suse.de>, Daniel J Blueman <daniel@quora.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v6 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 msi_set_affinity()
Thread-Topic: [PATCH v6 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 msi_set_affinity()
Thread-Index: AQHdSxRcEZEqfsGmBEGyDEsW4DX+FbbcOeOg
Date: Wed, 23 Sep 2026 14:30:15 +0000
Message-ID:
 <SN6PR02MB4157E117ED84FE873769DCCCD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
 <20260923043023.3150498-4-namjain@linux.microsoft.com>
In-Reply-To: <20260923043023.3150498-4-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS2PR02MB159176:EE_
x-ms-office365-filtering-correlation-id: 4b9c46d2-dcbd-409b-ac4d-08df197f2f17
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQkGaLwEdeYxLY7yqos8lGqVczr5qfg1JLx/qafcqibbTe6CZ8ajKe+pllnnJehE6VXhzxyaFaN1ex8EndzSSG/Xz8uTxneErvASYG933vdB8uHUigibfbE6LBbFELDdKSgM1VRafbEoUAMuZYnAcaR6uRttvTh3epqhs6LbOUYX0g8RuI4IcCc0NT8ICimT3eAXJc99G63aT2hYQHsXZpGSxexro9JYfPbm2q4gDeHn7qQo1OE4nGD7LJv3m8EiB5nizncHcRBuBYbxL7hTj2d28+WxDt+7MasKppWp/5OpgwTUQjb8x1uU3pPz5SGm5nbTZrlBYMh+UvTcY2FJC5CFXLwtrNN5gqo1r6f9jDdGpfCnbhR04XcNSHqHu/Fvc0Y+u4sJ4IM4Uclv8wDAB5JBvqK/ys24XOFIvnxULMNlxcxQjQmQU1fnwDNJ2gRGQChY3RiR86uLgLVo+4bV1J8tFY2Gfu6ZNorqG2UeobAFHI8EVA2iMIVJ1S1hh3S7jobzpn9IvEB4CNL2iB3Lj5OhLKhPgx8VMjH9LrCSGmAeCW/7AEp9LIwuJXCEMNQ6NRi7ZwAeXBUGHM8jHuWST45IQp+KSrKybDexYR3OIex+A1Q0ReUwOZxJqG98I0STNDhHtsGDIGh/ka1yuQ5JOEC8zcvhISyGmBc5Zrjps/HhfXbsI7/GnyToeM4g0Ui6m+911LzkGWsxy38tlArFbE9SFdzBPQoZB2k=
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|31061999003|55001999006|51005399006|37011999003|41001999006|15080799012|19110799012|13091999003|8060799015|25010399006|8062599012|40105399003|2607281247196008|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1REZzJxdmFTMUVKWUowY1ZLa2kvTzl2ZU4rdnB3eHcvQTlpcEQyUWRkcmQ5?=
 =?utf-8?B?NHBpMFR6VFFSdUtVSytUNlJuM25MQklCOHFTNVhDSjRkVUprK2V5bGdJMXpR?=
 =?utf-8?B?VzV4Y1NpZVM1dWVmTzJwZytxN3NYSWZYUThLOEl6U2FueFNNU3ZjbzQ4WVNj?=
 =?utf-8?B?K0ZacnkzMmhvMTRGajdnTWQyU056bjNqZTRScEE3dVg0N3lHSm1ZYWdNNzh5?=
 =?utf-8?B?QkhHczZ3ZWYzOWVlaEVJTWd3VDZPUDFSQm4xUUE5M3BZQ2RiRHJmSmRWMnBs?=
 =?utf-8?B?N3BnUGJDM01DUDB6UDBZVDR6K2VwYlFxUFVQYjdsTEkyMDEyK3VkMGVrVTlm?=
 =?utf-8?B?RTlvMTVNMWZ6dXFnSUxHRFNac3pGVmFnbmlvWWZ0TDdCbWs2Wk1QbUxTZ1NR?=
 =?utf-8?B?aW9xaXVvRVJZc0VlUmUwQkU1SmlqdkhyU0tHQ1pPWXQ5cTNRbHBDME9zTjN3?=
 =?utf-8?B?V1BCYlkrdVo3dTQvQ1hUd0ZKbU5weVVnQVhWUjA0QWRLdzMrWXkyMnZ3SnNo?=
 =?utf-8?B?NHZkbThsR3loRmN4SXpZRTUrMHk4cEFMM1E5ZkMvU0pKeS9NVzlqZG9OSXN5?=
 =?utf-8?B?SnB6YVYwenZPcFlUTHVGVlpPWEc4L09PeTF6VTFMbDNQcllZeloxejVldUsr?=
 =?utf-8?B?SzNpZzVNNHRZRWdDSDhyRjhKZlZjVTZHQ244UmZmdHlkYlhTYlhSY3JZd1RM?=
 =?utf-8?B?WnlPbURaUldLS1FON1RCYVIzMDhVRndjTTNyQ0tGUWkrVkJYY1VmRFl6Z1ZP?=
 =?utf-8?B?emliRkpEVlpnV3BFMmFQOXBzaTc2bC9vUVphYmx4ZHV2NmVYcXJLNTlvZWxI?=
 =?utf-8?B?V1oyUk1WT1YzOXdSeEZRMFRHeE9Ddyt6cXBBSzliNm4zS1JiUzhwY1dVdENV?=
 =?utf-8?B?QVQrZFl0cXJSa2E3K0thWGx6SkRHcWZIN0t6RFFZekUreXJ4WWFRYjd0c1Qv?=
 =?utf-8?B?YURucWg4UjNSNktLQUdxR3hVU3g1WGdWMW1sYUtQWTI4blRIWjU3allhZTRn?=
 =?utf-8?B?QXZxNTltUnJyNGgzNW13NkRPTTdJQm81bk5WZU1WdVlnVUZnMnFVL3VKN0R4?=
 =?utf-8?B?cXZzeTlGQVpYRFVkelNYbnh4eTAvclFxWkpleXVHVkwxckF4cnE5Z2Rhdkxh?=
 =?utf-8?B?VjArRVhBSUhVdEpISk9kTHV3cTUvNTZlRkVPVFlkU2IyZlhjdTlGZm9xV1FE?=
 =?utf-8?B?UDd2SmZhQVk1d1ZkTjAyZTJEN1FNdERIbzFIY1RUWDdadTF2cmtJN2c2ZUc0?=
 =?utf-8?B?R3I3Mk04Z3JhY05uYmxjOE1VUDlzZjh3Q3M3ZlFlYWFPQ1ljcUFJaWlnV25i?=
 =?utf-8?B?emRkWkNZR090Y1lENUhEYThzM3hjQzNkSUhoV0hyVld5OEc4d2w1MHlNNmZK?=
 =?utf-8?B?cDRNK2F1ZmVoSDdLTW9rTHcrdWVFSEdlblRZdnFzWUdpS2x2SEdBUlV6V3U4?=
 =?utf-8?B?TXVFM1RVaWpKV1ltY05YSHZkZUhwK1BNc2hPOUlRPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXNvbENwRDNqWHZyc0F2YWtTYS83akY2QlBNa09lUHFwbGdJbTBFelVyQjVt?=
 =?utf-8?B?aHoycmZIWjlqd25kVDlxTGhLL0JnRmJBSnZlUFdydFI5aVAwTmZnSkpiNFVu?=
 =?utf-8?B?akN5ZGlWbndrN3c0MSsvaHkzcVRickpnekE4T2JVN2lSUlVCMjZhZ1BVYnpB?=
 =?utf-8?B?Rnd5RHA3aFpmNGVEdVE4aXA5bllQUEV6SElreGRjOUVGTGtSdzdqMnc1NlFq?=
 =?utf-8?B?WXZ2bkE0eVhldlVFVmJMbUpSYklKT29mSGRjMjBveW9TL3NibURmWkh3SWJL?=
 =?utf-8?B?M29FTkhNYW5ta015U29DTHhiME1WVzNlOHozMEJSM0UrWUtsWUM5NjRkalN3?=
 =?utf-8?B?cks4ZzlRMEZJVGhOVCtHV04vNXF3MUZmcHErbWRPY1pIU29kOUNXU0dIaElG?=
 =?utf-8?B?YUZSNjZaaXRtTVB1NEg2VXhxclVQb2dnUlk4d2lvd3pLaVFGVG5zUmNubW9s?=
 =?utf-8?B?bEtmYWZMZXZReXdEV01pTXZqZnp5RzdZaWJhTWIrTFdQNHMrTmdGOTBMTEhn?=
 =?utf-8?B?VjljSEJxcGtqOGNkUSt0dXlnZCtCWU9hUzZhQ3JHbE1aUGNjVVJhNzFZWW14?=
 =?utf-8?B?NFFOa2JOUlNscldPWmk3R21mY3BEeWFDWE9DZmNETk11bTNjcDlBTTlWN0pk?=
 =?utf-8?B?VlkyWmVuNEtldzA4dzlWOEt4ekhVdjJUdSsxREJYeUExeURSZWlSb1FTSVFa?=
 =?utf-8?B?bzRVZnRRZVZ2cEdqK1hVL0NtcFhMUWU3N2MxbDdYeWxBVWEvYzZXYnJxL244?=
 =?utf-8?B?ekx6MFlSNG43MFJveEt2MjROakZaU1NFTmVxNkpYY2xiWitxeXYxeHVtSzBw?=
 =?utf-8?B?djNmYWFlRGxIUTJ6V2JjMlFxTW81ZTlMcmhKcWVNbXFrV0lSRHd1d3hTK1J4?=
 =?utf-8?B?M2ZubkgvZDlTcWRkaXYxNmVFT1ZKYmYzdHlPeGFPMEhXNnRNcjMzaG5VZXYw?=
 =?utf-8?B?TmtmeUIyWmQwdytpSEp1dVZTMDlPSEhrOVI4QU04NnRxMWFVaElLSGZVRGgy?=
 =?utf-8?B?U3ljWGhRQ1Jld1FjcTZJL0FwUy81K2NaMTdXNEY5aWdkeVVnZHA2c3h4eU53?=
 =?utf-8?B?VndPd3ljU1VtTWt6YzRiNk9EQlorQTg0R2hsYnhaY3FpV0lxMG9CMENqMjhP?=
 =?utf-8?B?MGI2SzJoTWJpQ1B4NkZ6UWJISkpjVHk2ZHJKdEFYaVA4V2UxbUd3dzZnZC9o?=
 =?utf-8?B?Wlh0VG5TaDlKMDRDMTRCTDJsanNvUG0xQWNWYStSaElucUZ2OHBhOENyaHJ1?=
 =?utf-8?B?T2NVTi94anpSU243TFhKOVZZYWcyTjFRclNNNUJNakp3YkJsRUN3WmJUZGZG?=
 =?utf-8?B?V0p3Z2JJS2Zqak8zQW10Y3NjSHdMWi8xSnoraU95M0Q0Y2dPdEZXQk1CSFVB?=
 =?utf-8?B?NVJZR00vOHBwVkxodDAzSXlzWk1mODI4TDlmTVRXZFpJMW1HQnREdkVuOTZt?=
 =?utf-8?B?ekY0L1pOdmtZUHZNejhxTVlkaHVqcVFTTU13RkF4bjlKM1hZbmdPZGVSektn?=
 =?utf-8?B?aytxRjRYYTRxMzZUNm1PTmJrdkFqNjRsWUowVkloNksxZTRSOTVCa0dKZHRl?=
 =?utf-8?B?Nm9JV2M5Nkc2MzdRNGtod0g3Y2IyUXdNYlVmQWxDblo1SFp1QVZaemFKUW1X?=
 =?utf-8?B?aWlPaWs0UUlnZjYrVE1GWHkvQ0x0NEZPVHdMcU5RQVJkQkxmR1Z0SElsK1Rn?=
 =?utf-8?B?czVwek9PbzdxeWZOemFwV2cyQ0t2U0RVakhOdWQ3SS9ua2l6ZEQwUmJ3TVB5?=
 =?utf-8?B?WHNYQm5xT2JQZHYrY3ZJczNhYU5XbHNNSUp1YXNkeWhHVEUrSkhiYnpvdHJz?=
 =?utf-8?Q?FIw0zLIyAuc6yPL9/f3P0FtCkrtIM6tiicRzM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9c46d2-dcbd-409b-ac4d-08df197f2f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 14:30:15.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB159176

DQpGcm9tOiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IFR1
ZXNkYXksIFNlcHRlbWJlciAyMiwgMjAyNiA5OjMwIFBNDQo+IA0KPiBUaGUgaXJxY2hpcHMgdXNl
ZCBieSBtc2lfc2V0X2FmZmluaXR5KCkgYXJlIGluaXRpYWxpemVkIGJ5DQo+IHg4Nl9pbml0X2Rl
dl9tc2lfaW5mbygpLCB3aGljaCBzZXRzIHRoZWlyIGlycV9yZXRyaWdnZXIoKSBjYWxsYmFjayB0
bw0KPiBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFyY2h5KCkuIENhbGwgdGhlIGhpZXJhcmNoeSBo
ZWxwZXIgZGlyZWN0bHkgaW5zdGVhZA0KPiBvZiBpbnZva2luZyBpdCBpbmRpcmVjdGx5IHRocm91
Z2ggdGhlIGlycWNoaXAgY2FsbGJhY2suDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVp
eG5lciA8dGdseEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2hyYWRoYSBHdXB0YSA8c2hy
YWRoYWd1cHRhQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IFJldmlld2VkLWJ5OiBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTmFtYW4gSmFpbiA8bmFt
amFpbkBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9hcGlj
L21zaS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KPiBpbmRleCA2NmJjNWQzZTc5ZGIzLi45MTYwMjI3
YjliMzJhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KPiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KPiBAQCAtMTM3LDcgKzEzNyw3IEBAIG1zaV9z
ZXRfYWZmaW5pdHkoc3RydWN0IGlycV9kYXRhICppcnFkLCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAq
bWFzaywgYm9vbCBmb3JjZSkNCj4gIAkgKiBJUlIuDQo+ICAJICovDQo+ICAJaWYgKGxhcGljX3Zl
Y3Rvcl9zZXRfaW5faXJyKGNmZy0+dmVjdG9yKSkNCj4gLQkJaXJxX2RhdGFfZ2V0X2lycV9jaGlw
KGlycWQpLT5pcnFfcmV0cmlnZ2VyKGlycWQpOw0KPiArCQlpcnFfY2hpcF9yZXRyaWdnZXJfaGll
cmFyY2h5KGlycWQpOw0KPiANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KDQpSZXZpZXdlZC1ieTog
TWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0K
