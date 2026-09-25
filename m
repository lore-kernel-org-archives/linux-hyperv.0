Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012084.outbound.protection.outlook.com [52.103.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF01363C59;
	Fri, 25 Sep 2026 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302723; cv=fail; b=C8NTFasN8PzF36bSxCcFbNl15bPgelrRSP16l5hXGvJLpOLVWhWCd+g0bxkATq5oy6ALURzSZO7nEi9rSZTscYf6s44hik06E22gg3QJMRwrKXzimxK63JtNGZLd62UlDIy3euzCnzZkaen+3XI4WrNRgNUuJlMH2FtkTv1+DQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302723; c=relaxed/simple;
	bh=eWGlgmf9u64lYL/pVxyPeBVk/E8UKArwH39ghtFt+GI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmYPAJvUmDXstncK+3Yy+Nfikh3LADMNGtsZQjL9LOXb3kDdJLzywHk+n55oaISUq68FCP7y0frlPs1MUBnRMY/PafhQ4ES5HPUfMZaPf7dslDmnuRtZ4ix0dVU22Gaez4prE9EUiQSV8plxTpFTelCybHhAPmWVX5q9qcqgduE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZjS8jE2F; arc=fail smtp.client-ip=52.103.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZjS8jE2F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AP7O+SE6AqMRV8eeZczV7fERr4R5932emfpWVL9zcqZgqbfdsFrZYtJFRHjc+jaawZ6oNVDeaQoJMkWrJMTi4KcPBtqH9g/5qdd+hstd/rDyIWTP/V9eHM8kruEHDA9aqW11dosVVg5hFnS1u2yOrRbZFjow9/wzQ0FxqMeYXd9aoXNEI3XppSq3Vp65w37ymGJgBa8Gi5vbZxeR0F3xM8MAFThXwv0YcS3+OuoqWnPCTd1LWwQrqFX+YQCUJ6EmsZYiq7/kcSWczetGKbS48kyIPTY+tvPOwUxpk8+qAsn47aO8ruRAv/3E66Cxz9vqse4kbJ1r55Llja7QCnj16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWGlgmf9u64lYL/pVxyPeBVk/E8UKArwH39ghtFt+GI=;
 b=mMbqCcB+yOqXNp8TTqzgy9/E3Ofsf28Dp0gEorqiKkelcG3qt0HJHZvFnlhK4xWhIfFCKmmpLpXCqibQpwd8/Zl9Qh5yf0jfWVvUYMHuAshSCqAts0r9adb0MmEaS/s0YvBn/WQCe5U/pl/4KNI+fHZ2mIoOTNx7jnx/whZWt23W3/b6f4p/hrBLjabqXWeMIEhLfqj4zSigx4QoCH1xw6ANERjIAbO8hGEv7h2F44qZ7ZpstJw6dsZ4R0R9D/Z9du3OOXATaV9REJpbwTHN2WhugTm2ZgNQdO95E2FTRWE6x46Ge84ZuWLHbkbJAArO+9KGEUMN3fKUwmbc1yIarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWGlgmf9u64lYL/pVxyPeBVk/E8UKArwH39ghtFt+GI=;
 b=ZjS8jE2FJiL2Ixa9SxVGB8uEnimWZ6cRhz9cCoNAYZZan6THRTMwVKjIhnkpvtu93qjPpcQrwobk8+UbS1xUQAAE2ZNhN/mrSgeSuJpKKawva6RcCs7U5T2Y5Iqj2891P8ePpUK4AxD1J3kAUBH0uyZipgQa/u2gAJFWz9Wy8Qa98E4bqgQOKbV6mFvEILqvQyzfvWulOS8kKRuVwUK18i/oOnW9yepnNI7QhcfQ8sM6jomUcMIjj/HM9mlY7VR6PimXomi/KXyO/LPPVrh2AHYhPA5B9/zvOPQC1t7Ydh1RbNXw+IgW38VseIhnGHBvS8GZ0btQ9cghdz1RM0OYgA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8274.namprd02.prod.outlook.com (2603:10b6:610:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 02:18:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 02:18:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "mukeshrathor@linux.microsoft.com" <mukeshrathor@linux.microsoft.com>,
	"anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>, Mukesh
 R <mrathor@linux.microsoft.com>, Asher Kariv <askariv@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "open
 list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
	<linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Thread-Topic: [PATCH v2] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Thread-Index: AQLQ5+BUZyN5gfzLrIKvTOztWR1Vz7T3U1qw
Date: Fri, 25 Sep 2026 02:18:35 +0000
Message-ID:
 <SN6PR02MB4157B715ACD99BB579C1BCECD4802@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260913232255.2801797-1-wei.liu@kernel.org>
In-Reply-To: <20260913232255.2801797-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8274:EE_
x-ms-office365-filtering-correlation-id: 8420b464-856c-4686-830e-08df1aab4de4
x-ms-exchange-slblob-mailprops:
 V85gaVfRD4/uZtbPKQiHMaRLDxOOyjp2oa3viOffULAchnn/eUdUP0i9JB0utYzCh9owM9vvNgiv7HJBgD5dWytsaTFCuANei5KD8HrQELwzVhL9y6XaL1rh5VwU4umtZlXpyzLb/25/VcBkCN5n4BgNUirIg653FznKYiVn+rPJqpz+sF5lg0kz5tpSA+AehhZzLsKBBqw/8XNLWQH1BH2zXSeQKgVgj7X7C0gFIzIN8xazSLAtYryrPMg1k5HRf8fjaBYqAydnNwe+2ugE24j5+JXhV+3Izj/azzQn+NVC1gRMk9XSL+9dtm5PLl4BQyBywgYH5mjvkCmjf4qpNHowCPmYYglBTUXqQRK4kCgOCqv1Hrwojlbl/9Js1YATYBaDx0I6HxLtMMMotOf2tm3XDbgXDx8S8S7S6yFqmTPBoBx9rntfG0DVmLLA7DIDASsSXjRfQrAInwZBGfRavUdvvUNzDufwENymPBhdBpqUDd3r1j+o96Uzg7/COs3Fwhhs88nk5FdVjN4vNPZM3+a5/Qfw8dFBVaUbuOusThOqT6KnscOAkQ06ZQDUdSLP0Bd8fHqK9jHTEUxVU7rGjS/OSnlBPCF010xEeLl4ZRi3W9IwwZX7AH5/xTCZfFY+mXNMfo7H/dsv4WGVOebDDg6i1lbNJWjPeW/vTe0fyHihk2C7DCwvzfsIvFdxImVtCkR/IZS7w21a5ekNnlAd9Vp3QljyzdR/p8hlFow0usd0Iwsv916qvmyJsmEaXxyQ/XbiIRoKUTu0wexkdJkwoXmgG44jNukEtAxq72HzZal4poWO43cDbtG2EOyCZIYsue4QJL2Ny4rZkKPpEiRJ1Q==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|24021099003|25010399006|55001999006|4140399003|8062599012|31061999003|51005399006|8060799015|19110799012|13091999003|40105399003|2607281247196008|1602099012|10035399007|102099032|3412199025|4302099013|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnZDdFg5RDZzbitFcXJCd0lud0hnczFuQWZ6eW5RMUszUmRCVERmNWhXZkow?=
 =?utf-8?B?Q1RHaVlDdGovaUpFekRVbjFrWTR4QVF3alBteGt6ZXo3TS9sTjVBazYxZGEv?=
 =?utf-8?B?OFhpZnVyQ0tPZm1IVGV6SkRHUUt0WFZTV3VOQ2xSTDh2R3EyV21mbTUxQ2dO?=
 =?utf-8?B?cHZYamtXQS84RFpUNHhkcE5KS1N2ZlRtK3FGajBZOHlhY2dnT2s2ZkRiSDdD?=
 =?utf-8?B?VC9kOWNSbEJtaWlGU3RnY2dkdXFUQ0FaSE9MMGRZQUtQaGdTc2QzSzBSU3M4?=
 =?utf-8?B?S0NsR0tEdExrUW1GbkJOSnRZSFQrMW1qa2ZlRk8rK0dYekp2UHFhS2RZZVpS?=
 =?utf-8?B?RFVZVk1hcmVzSGM3ZDdaUG5ESVU4M2E5WGZvdktOeCtmNzBCQXl3ZG9oTmp1?=
 =?utf-8?B?NjJkQjBkbXg3d3VMdkhTd2VSOTJ1TWx1SzFnT3JQL2ZzV1B0MWRMNlp5NHM5?=
 =?utf-8?B?cmxBNWEwQjIzRi9HMXB1am1iN29Nc3lxOTVZU1ArN04wU3NVc3crRkttWEZt?=
 =?utf-8?B?R0lxRkR3YkhvQStRUlk2SWFmenVVdnQxR3RGNTVEckJIM2FqUjl4c1JtRjRH?=
 =?utf-8?B?NHUyRFNwa2JUUEJSd09GOUU1MUU0c1VtZG5rSVBsMGFmdE4yd2ZHZUtwWGVN?=
 =?utf-8?B?L2taK1hidXp5dGpJSWFOQ2hDS3l4ZGJFYUw2Q3oyRVp5RzV2dlluZXc4WUlw?=
 =?utf-8?B?Z0hlU2NmeEYydnliREQxUG5zK1BOZ0xveHQxb3dha0J5RWRWeGllZ0thOWxv?=
 =?utf-8?B?bXFKNkI1citwR0tpUUs3RngvSCs4TEtoWmpKdSt6TlRoTVVQdVA1ZyswamF2?=
 =?utf-8?B?R2dWcXdIZm1iclRxWGZOdzNtT2N4TE0vdXl1NGZjenJqY2loZzFRWkxNaFJH?=
 =?utf-8?B?dUJqTU1Kd2tERko2Q0ZSMkJzVXdxRWl0MXV1WllKVHpFZXZNeStmVDlxdGhj?=
 =?utf-8?B?ZTdPV3dNeTIwOVN6dkR0dzN0WXFaKzNnRHFWWlFOVEdGYWJWY2l6bDdDQnNR?=
 =?utf-8?B?dloxMnBINDFCaTA3WkMvNkViZzFwejJSUjRNc3RTWmpCOFduRVM2Q3ZNRjZC?=
 =?utf-8?B?WnZZRXlYczlKZVBlL3crb084NVdobC9vcGF3V3MySnM5REJFUS96dFl6RkhS?=
 =?utf-8?B?R2N6SGFMKzRwZC90NlhSL3VGeFc4ZkJLOWMzS013bTNIaks3Wk01VE5wTHJs?=
 =?utf-8?B?b25aRFlZUDJDdjVZNUVrTjBCbUcyRnVGVW5KcyswWVN0SnMzOXpGVmVCQ2d4?=
 =?utf-8?B?ZitETDA1WHYxL09Wc3NtWTNkSlIzWHRid08rM0RsWjhVK01BMGJVdDU1SzVq?=
 =?utf-8?B?RmN1NzZkdE44RUxkRTRNeW14bUg2ZTRZZzVtOTR5S3FVdFJMWXdmbjBQS1Fa?=
 =?utf-8?B?QVdNTDArdW1SdTNkbVlFMmlJenZ3UG9GelRMazM4U0cxZm02QURpU2pQejZm?=
 =?utf-8?B?cXlKc3h2alJLNGlvUzEwNThlYU4zb0ZhcWYySGxRPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTI4UFlwNHMrM3NLNm9nVThFbGpBd2NGWktZUUIrd1hGdHl6MkpQc3hJNC9Z?=
 =?utf-8?B?bUdDRWdRZ1FEVG1lNE9CYVZkdDcyblhKeDg0UlRJcWJoM1AweEt5N0swR21G?=
 =?utf-8?B?c1ZyM3NrSDFpWGYwKzR3b0tHQzNUbXZOcSsvdlVyMW4wNC85bWxXVEx5UmtD?=
 =?utf-8?B?bUU3Z0ViZWdraGRPUUczTDJEeUZqeDVhTHRaVGduRTJiZDlpU1Z4QUxjNFNt?=
 =?utf-8?B?QjM5VEw4T3ZDREFrejQ4U0p5NmhLSjcySnRQNzFLYlJ1WHZvdW1BZitqUis0?=
 =?utf-8?B?WC8xZlFueDF1aFBZUFlyUVhXeW5BcjhZVWo4VDlJZEtvekJqd1ptVHFERC9R?=
 =?utf-8?B?YTl5QTgxVVBodS9odkszMW55dkE5a2NVbzRZeUdmYXY3T2ljMWczVWhCQWN6?=
 =?utf-8?B?Qy9tUjFPZllEVjhYUTk2bzBPSFFYSjd4VVFTbHZhOEVIZkNrNkN2K2I3bThr?=
 =?utf-8?B?ckNsdkpWVTB5V1lwM3dZcFQwUGRZVEU2aXJwWUI2TFdqSll2QlJuZE9jVXpI?=
 =?utf-8?B?cmZycWNUOXNMWXJoem1zUWJnSnhnUUVCSy9rdUF4Q1dpVW8xZHNmQUo3V1dk?=
 =?utf-8?B?SWhwZVF2T1BiQUVqNEF3dVE2UUN5VnlJSFo1Mm5RYkIwbEhCQ0wxcWwwYVF6?=
 =?utf-8?B?MUpoVzlqbkpSSXNzaDZIUnZ1eXhHc2ZvMmk3VWVybmpvYkpnUGpaMWphTkc4?=
 =?utf-8?B?b0QrdkMxZXkxTlRFblNnUFBFR1hhTmwranhmaEF2aytyaUNFaXB4NFFpU1dL?=
 =?utf-8?B?b3lmVHoyZFNYOG1rb1NwbnI1U0xxUnRpd1I1ckJOSGZyaHlhZmFjRTdBZlA5?=
 =?utf-8?B?TUc2VkVDTk01ZFlyaU1EYmZaTitmZmh6MzVGVDA1d0FIaEx0clo3VVNkbVFO?=
 =?utf-8?B?Q0ozMHM0cFpuWlNIaGNoanU4d1dhUUNTTmdLNGtUWGRvWjErZWtZKzVXOUd1?=
 =?utf-8?B?bHFxS0Y4elJnYzI3QWNZVDY1MWw2UFN1a2VTMGloMEY3MmxlTGpDRzgyM2N5?=
 =?utf-8?B?VDJoOXFkU3dVNnRkRGgvd0tXazZmRVo2NzFpVWQ2cUp5Z0RpLzNuWDdyU2pY?=
 =?utf-8?B?N0Q1QWdtMFNZSnk3VjROYjM3VUI0blNTWjNVeC9NeEx4dXNLejl4VGw5czAr?=
 =?utf-8?B?bDF1RkRENVhIbmVyaTMwV3F4eWZRQWswZ1dVVFpyN0NsNWtmYzVJU1BaSFht?=
 =?utf-8?B?TTZDcGlLcWpKdlF3QXBmSU9ZTG9Sd0NabEtNV25oY05wMlc5QjI3VVpzSnRL?=
 =?utf-8?B?NHVkZlNKenJ2QWdxY2R0M3JGV2Q5K3VVR1lHTThGNncwVUMycnpCZmZBOVor?=
 =?utf-8?B?ZEY1QUg5Q1FvMkZsSldsVW5YeWZvcE4rS04vZGQxYi9vckFZcFVtbG5JNUhY?=
 =?utf-8?B?ZVAzUUJmd1FLZWcrUXZVQVpINUxremlndGNINlN6UDdrYm16dUt4M1czK25o?=
 =?utf-8?B?cXNrS1NuVWF4cC81Q2hVbEFyZmJYQnUwRWx0V3ljNlhiVVBpc3pHbXl0ZmhL?=
 =?utf-8?B?ZW4ralA0M0FRSHd4RmJoV1gySDJYM2VzaFg1ZEp1eWZFdUJ3YXFHajRzaUNE?=
 =?utf-8?B?aWhvWkZ4SU9LUDBJN0ZHVWViVEtuVFZiQ1BlckFXSXgzYklkQjBJSnNZUVVZ?=
 =?utf-8?B?TjVkY1QvS0VjS0F1ZkVHb29mVktsMXNlN21FSEUxWk83T1RYTVdLWFZ2M2VC?=
 =?utf-8?B?M0k1NE1nNEpCbkhaY0N0TmI3eTNac3pKbDIzRHZIZ1VIaEc4aXZxQ28welkv?=
 =?utf-8?B?N01HbVFISFNxMm5NdmZYcmxGMUxyZU9hU1VGNnR6cE9hRDZjQkYvOVVJMTdj?=
 =?utf-8?Q?N/GGOMp88/XZrzzEuB/ASYdcVDkLQTVQwJLyI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8420b464-856c-4686-830e-08df1aab4de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 02:18:35.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8274

RnJvbTogd2VpLmxpdUBrZXJuZWwub3JnIDx3ZWkubGl1QGtlcm5lbC5vcmc+IFNlbnQ6IFN1bmRh
eSwgU2VwdGVtYmVyIDEzLCAyMDI2IDQ6MjMgUE0NCj4gDQoNCkluIHRoZSBwYXRjaCBTdWJqZWN0
LCBjYXBpdGFsaXplICJIYXJkd2lyZSIgZm9yIGhpc3RvcmljYWwgY29uc2lzdGVuY3kuIFNlZSBb
MV0uDQoNCj4gSHlwZXItViBEaXNjcmV0ZSBEZXZpY2UgQXNzaWdubWVudCAoRERBKSBkb2VzIG5v
dCBzdXBwb3J0IGxlZ2FjeSAoSU5UWCkNCj4gaW50ZXJydXB0cy4gV2hlbiBQQ0lfSU5URVJSVVBU
X1BJTiBpcyByZWFkLCB0aGUgcGNpLWh5cGVydiBjb250cm9sbGVyLA0KPiB3aGljaCBjYXB0dXJl
cyBjb25maWd1cmF0aW9uIHNwYWNlIGFjY2Vzc2VzLCByZXR1cm5zIDAgdG8gdGhlIGNhbGxlci4N
Cj4gDQo+IEhvd2V2ZXIsIHRoZSBjdXJyZW50IGNvZGUgb25seSBjYXB0dXJlcyA4Yml0IHJlYWQg
YWNjZXNzLCB0aHVzIDE2Yml0LzMyYml0DQo+IGFyZSBtaXNzZWQsIGZvcndhcmRlZCB0byB0aGUg
aG9zdC9IVywgYW5kIG1heSB5aWVsZCBhIG5vbiB6ZXJvIHZhbHVlLg0KPiANCj4gVGhpcyBmaXgg
YWRkcmVzc2VzIHRoaXMgaXNzdWUsIGFuZCBtYWtlcyBzdXJlIHRoYXQgUENJX0lOVEVSUlVQVF9Q
SU4gaXMNCj4gaGFyZHdpcmVkIHRvIDAsIHdoaWxlIHRoZSBvdGhlciBieXRlcywgYXJlIHRob3Nl
IHJldHVybmVkIGJ5IHRoZSBob3N0L0hXLg0KDQpJdCB0b29rIG1lIGEgYml0IHRvIGZpZ3VyZSBv
dXQgd2hhdCB0aGUgYWJvdmUgdHdvIHBhcmFncmFwaHMgbWVhbi4gRm9yDQptb3JlIHByZWNpc2lv
biwgaG93IGFib3V0Og0KDQpUaGUgY3VycmVudCBjb2RlIHJlY29nbml6ZXMgUENJX0lOVEVSUlVQ
VF9QSU4gcmVhZHMgYW5kIGZvcmNlcyBhIHplcm8NCnZhbHVlLCBidXQgb25seSBmb3IgOCBiaXQg
cmVhZHMuIElmIGEgMTYgb3IgMzIgYml0IHJlYWQgb3ZlcmxhcHMgdGhlIGZpZWxkLCBpdA0KbWF5
IGJlIHJldHVybmVkIGFzIGEgbm9uLXplcm8gdmFsdWUuIEZpeCB0aGlzIGJ5IHJlY29nbml6aW5n
IHN1Y2ggb3ZlcmxhcCwNCmFuZCBmb3JjaW5nIHRoZSBQQ0lfSU5URVJSVVBUX1BJTiBieXRlIHRv
IHplcm8gd2hpbGUgcmV0YWluaW5nIHRoZQ0KYWRqYWNlbnQgYnl0ZXMgcmV0dXJuZWQgYnkgdGhl
IGhvc3QvSFcuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFzaGVyIEthcml2IDxhc2thcml2QG1p
Y3Jvc29mdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE11a2VzaCBSIDxtcmF0aG9yQGxpbnV4Lm1p
Y3Jvc29mdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9y
Zz4NCj4gLS0tDQo+IEkgZm91bmQgdGhpcyBpbiBvdXIgaW50ZXJuYWwgdHJlZSwgbWFzc2FnZWQg
dGhlIGNvZGUgYW5kIGNvbW1pdCBtZXNzYWdlLA0KPiBhbmQgcG9zdGVkIGl0Lg0KPiANCj4gdjI6
IGZpeCBhIGNvbXBpbGF0aW9uIGVycm9yDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2ktaHlwZXJ2LmMgfCAxMCArKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWh5cGVydi5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gaW5kZXgg
ODk4MTZhMmJkN2NkLi5iYjRlNmNhNGFjMWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWh5cGVydi5jDQo+IEBAIC0xMjQwLDYgKzEyNDAsMTYgQEAgc3RhdGljIHZvaWQgX2h2X3BjaWZy
b250X3JlYWRfY29uZmlnKHN0cnVjdCBodl9wY2lfZGV2ICpocGRldiwgaW50IHdoZXJlLA0KPiAg
CQkJbWIoKTsNCj4gIAkJfQ0KPiAgCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoYnVzLT5jb25m
aWdfbG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIE1ha2Ugc3VyZSBQQ0lfSU5U
RVJSVVBUX1BJTiBpcyBoYXJkLXdpcmVkIHRvIDAsIHNpbmNlIGl0DQo+ICsJCSAqIG1heSBiZSBy
ZWFkIHVzaW5nIGEgMzJiaXQgcmVhZCwgd2hpY2ggaXMgc2tpcHBlZCBieSB0aGUNCg0KIm1heSBi
ZSBpbmNsdWRlZCBpbiBhIDE2IGJpdCBvciAzMiBiaXQgcmVhZCwgd2hpY2ggaXMgc2tpcHBlZCBi
eSB0aGUiDQoNCj4gKwkJICogYWJvdmUgZW11bGF0aW9uLg0KPiArCQkgKi8NCj4gKwkJaWYgKHdo
ZXJlIDw9IFBDSV9JTlRFUlJVUFRfUElOICYmDQo+ICsJCSAgICBQQ0lfSU5URVJSVVBUX1BJTiA8
ICh3aGVyZSArIHNpemUpKQ0KPiArCQkJKigoY2hhciAqKXZhbCArIFBDSV9JTlRFUlJVUFRfUElO
IC0gd2hlcmUpID0gMDsNCj4gKw0KDQpEb2VzIHRoaXMgc2FtZSBoYW5kbGluZyBuZWVkIHRvIGJl
IGFwcGxpZWQgdG8gUENJX0lOVEVSUlVQVF9MSU5FPw0KDQo+ICAJfSBlbHNlIHsNCj4gIAkJZGV2
X2VycihkZXYsICJBdHRlbXB0IHRvIHJlYWQgYmV5b25kIGEgZnVuY3Rpb24ncyBjb25maWcgc3Bh
Y2UuXG4iKTsNCj4gIAl9DQoNCk1pY2hhZWwNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWh5cGVydi8yMDI0MDcwMTE3MjA1My5HQTEwMTAwQGJoZWxnYWFzLw0KDQo=
