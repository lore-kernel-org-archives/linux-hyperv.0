Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795551167;
	b=AfYe9L1W/ZXc7Rj6Fvn7aZ4xP1K46Tnx2hOqWsShjaGY+Zfn1w2l/tFu2QgMF7PC6u5T
	 TmbEEkW5fprNzCJdW0HF2J4Uy0HhfVZC1j/skOS74SHpryIepgqGS9grpcIUKHb97ZRsA
	 OSmXRWlVtTvjhQ+CEb9i7rzg+lin41a0hYrAsTflzf4lT8Qv8VDvEs6XYiAE2II06kF4m
	 2j0nurqQgfELIAyEhPFImbBPD7ai0Uqhl+alLYsuu3WvAv3SQwZ6x4VpdIaQKHh8BpsUi
	 KL/oSd+I4mfrRsHSyehRyXXK+UQ9S6YFGLusBXWklYkmfFQaBds2h0Wjy3EHT+ihgEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551167;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=xefF2fQP84DmjJtBiHF85a5sPbWsYUigbta7JZBsQcc=;
	b=n8fSaWyP2XjRaCveMPerbBI1dT4xEJsmFzqyuQH+WqzKLnHn15pH1otmft/OGQP2f8WC
	 oq/qJG7vgoNZPbGU+q95gUovSGKcYXDZNDIHq9H7/HLLmbNnn2//VG7EMpUqKp78PM1CL
	 dW7caylrcoktjrNtQHL35dQhn0d+J3aIwnqzL8qFdKk82czt05X1fR6odtW9vwSeTGQ1S
	 ONm/tq2s/LmP6UhWbhp52Qnv5C/YPuXWtBliu1ftSwdrFNMtI6si1oIEY1f5P8mZWfo5C
	 uQ+1kWbLaX59NjK2PZpoRD8KIdBu4DO2ccCSUJcafg0NW2fl/yu89C95eypJkQaqeXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tZdS3QO6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.0
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010000.outbound.protection.outlook.com [52.103.2.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AA606A31E;
	Tue, 24 Nov 2026 20:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B0AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tZdS3QO6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF5B+vW2LVnDirK4B9wzY1vzlUGdJhIuES3cjHvdkHocInMh9ks2J2qWNkORoRuCHpX2eaBYf2xPs7NYXGbPNKCKLZ43nDIQsFmt/IXF6wOUbfXyDT2EQM/Bq09pbxR6qOo1v4i1blcUBjO8SqTkmugteMuw7bjdTq4LUeTiaSpgXa3ZW5uaNohmMe/UDAdJ2ZFIu7IPeatRYXGFV6DP+B3aOEloo4LKDh5nJFnBzkWxy4eeSdy57pl4sM8qxMzl+L3hwpsTqRewiC0vkqZiQM60spLRsiS/Xcykqopykv9anyWsrXa6XuFfG9CPrnH1xew0tmjdecUQLurDyG+DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xefF2fQP84DmjJtBiHF85a5sPbWsYUigbta7JZBsQcc=;
 b=doj9bz0Akj3uLU5mGR4r60/5CP/LhjWskz2B9yvGu7Z+PTLN/s73x5iFN5c3hqDjL0hHPiQAl5gR8rS7WXZfVo2pMxYCgxktL4TyX0waLUPe2YcDhaH6RMy5zHcq70oeS436cqQ9ZwfcvzazRAJgUyRgq6nVKw3aIlc7EIbSfD9t04QDverO/5AqCXazR7tALRRfO6CY7BToj4LGLWjlPNESO/NxFP4jR5PAJSDrMBa+Lh2leXxhMQ1Ed17gOETxYOO03ssGLWZULgzFvhoGPRnna+zKu+iQjfsVwZVsIlqc1OXdWTDVBP0Y3hCNO53kt6iVUX+6amJndAitIMY3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xefF2fQP84DmjJtBiHF85a5sPbWsYUigbta7JZBsQcc=;
 b=tZdS3QO6xU2Kh+R3QEfDzCQ+uT4N4JbMG6XPBQQ09b8PdruzXpVRzcMvCAHHRihNANMaNTQTgUEnicJZyqEoU3pHNu7DkYww5BeNDMri1awY6MxpZy7tg1AqI6wbRnYdCI5pa+uEZNe1F1hpbcKKF3p7SdEKzJy/YGN0RFk10XWwTi0fXUYu76bSex80UZlv2GVwngcfgMx8LZijg2kVfAoTcJswP2dmjcHTjaIz78x+HaWc3Yfpk1L8qscrOspduRYX4CCz2LyzM4zBkcooH+TzAg63+A9dUDIh5sGwZNyYx2PK/nxWfERaawamEofoxhReUyC99Bo2YBIoAcl9VA==
Received: from DM6PR02MB6860.namprd02.prod.outlook.com (2603:10b6:5:21a::13)
 by IA3PR02MB11197.namprd02.prod.outlook.com (2603:10b6:208:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 24 Nov
 2026 20:12:44 +0000
Received: from DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0]) by DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:12:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "zhouchuyi@bytedance.com"
	<zhouchuyi@bytedance.com>, "houwenlong.hwl@antgroup.com"
	<houwenlong.hwl@antgroup.com>, "qq570070308@gmail.com"
	<qq570070308@gmail.com>, "bastien.curutchet@bootlin.com"
	<bastien.curutchet@bootlin.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "jgross@suse.com" <jgross@suse.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] x86/hyperv: Use native callbacks for trimming and
 ASID transitions
Thread-Topic: [PATCH v2 3/5] x86/hyperv: Use native callbacks for trimming and
 ASID transitions
Thread-Index: AQHddnQ3HT/Qa1jABkW3CW1Fxm9bUbc8ZTUQgABsZ4CAAOHNYA==
Date: Tue, 24 Nov 2026 20:12:44 +0000
Message-ID:
 <DM6PR02MB6860396375E1FD95F183F073D4442@DM6PR02MB6860.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-4-namjain@linux.microsoft.com>
 <MN2PR02MB6863881EE9A8C2A04604652DD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
 <6ac7bb4f-7a80-41a2-b1ed-0235d35aebdc@linux.microsoft.com>
In-Reply-To: <6ac7bb4f-7a80-41a2-b1ed-0235d35aebdc@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6860:EE_|IA3PR02MB11197:EE_
x-ms-office365-filtering-correlation-id: c3b0a268-787e-4ee3-a2b7-08df4a674d28
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOQFLR1xBnRIu77AMTUbzZg1sSw+IHFB6Kb+sw8KzvrvGdEw5ZguCCWNYPFf8sab7IHETrG7BCwgzGYi8KrJMonu8mSsHpMOc2vcbBpbOQoX/A1l8ZYNfoWF8drXq9S/GoGbgUdgz7cjKOR3hXl3N7vhK2Qo9oJITiJjCSL3WZkLj4FIKol2+rRpRfmlrKsV7ls/IIUfQBXObuBOmGCo/a/sb3DwVy9IuCGQ4fYrz0d7n4TKlaA5pKZoAKUd/vOpbVRT8CydB/c8Zx8h/gODdMsGoVO7uinwalbY+xlxWtRZS43yaqYJSS8aGJyHMbJ1vrImIWHdHc+p8l2tqorbd2tFFn8sLfUr4mr9YncfaMG/MlObPhi+1L63F4MV6Sd4RpvkIxN09mre5zqKRL/CUFsW9BI8mzy/L6OqCwSlGF6RPgbze01vbTOo9S3bh+G0qr9M1fALzB0f9lFeDPGm68+zgipVbMo0fl5KO4iVdUw/v77CsfHNsFVLFOLSkLFJcKcu7ZVq/BvC0kk1Wc5Jt3aygt5sCdPS8WsH/7tEB8E0EABL6iVM+0kzyhTHZ2MgkTb26O5qmFcvdySplJBfkozS1JPIzTi73dlceB79qrZCxuXz8PP+4U9CX28igD8FhrMX6GybUPNHUcQkUR22nG7NqTnWhIUC70HmomcAZzUGbPyvMBtcqNsxU6pumCwdzYe9F+waZauZStrW/fOMC9Rlc3jOiTu4ipeHHjsp1g3Dw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|12121999013|15080799012|2604032031799003|19110799012|24021099003|8060799015|55001999006|37011999003|31061999003|25010399006|51005399006|8062599012|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVl3ZHhNSGRzUXB0U0c4MmJyRVJHWUxqTFBhV2JxOWMvRncrL1FmWEIyV1ph?=
 =?utf-8?B?MGpiSGllbWtJQjRUeG96cis3b2ltNTd2RHMvanFsTHhWdHhiT1luaXE4NXFP?=
 =?utf-8?B?MFhvN1VSWWdkWHZ4NUNyczhuYkFvOXRoNFkzeEh5ZDdwS3FYR3dERHI0dEEz?=
 =?utf-8?B?L3lEWGl0eXJ0TWpNeGtqZ2JaVkh1Ykk4Q0ZuR0pxTnBDY1BWTHg2NXJSNjlI?=
 =?utf-8?B?MGppN2ltbkZobGhJaWJWc2JRNVRIbmpWVE9Uc0t6Mk0rbUwyVjE3M0Y1S0Qr?=
 =?utf-8?B?L3pGdHJuTE9RNTJCRDZZcUhFWHI1dkJrOXVYdmhYUWovSDdIOWNHRWlmZENR?=
 =?utf-8?B?QThMenBIWlZ0QjhlRnE2NE5vdXdKUkpZVGZIank4Wk4yWGlkTlJiZ2V1K2J4?=
 =?utf-8?B?RFp3TnlLcnA0NDR4blYrU0Vnd1BwRlpGd2dYMG1NblhJNURtMWpwMmQ4Nnl2?=
 =?utf-8?B?UmhmMkFsajNsSmthMUhBWUkvd3N2eVMzRlBqSU5qeThKMWs4Qk5INFkxRW80?=
 =?utf-8?B?TS91bVNsSE1kNUdLbFRJM1ZpWmsvZnVEaGwxVlorOElKRVY0U0RyWlpxSmpa?=
 =?utf-8?B?am5aUDBVWmcxZXQyWmlnV0daOWpwSEJ4WEJBYWZkRmIzOEFPOENiVVdzUzZs?=
 =?utf-8?B?dGtDTFZqejRUK1g1RTZDR1VHeUtBKzArdUtxZVlWSFQ5QjV0aUxaR1NJVnA5?=
 =?utf-8?B?V0E2djdyRkxtMDhuQ0FPV0RlNnlzSE1FVktmOTdXVDlReVd3RjYvOUVPRGFn?=
 =?utf-8?B?bFJUODdVVW1wZXM0OVc5WHIvaGl1Z3NQYVhUTS9kbnBIQ1ZEbERxTnhybFZD?=
 =?utf-8?B?c0o0RzVGSEVGZ1NJNmNMNjU1YjljbDJTaVZGZitKRFA3emVIV1RraDR6WjRy?=
 =?utf-8?B?Q3BYYUFlRnlQQThzZk1zS1F2cU9kb3NieERxNnhNaXZNUlJFbDFMV09WNG12?=
 =?utf-8?B?M1ExV3V0SVJ4d0F4RzhDTEk1MUtOWCtybEplalQ5V2g0VVhmbUQ3KzdKM1Q2?=
 =?utf-8?B?cE5SSmJJbUlhZXlHQlkwM3RKNzlBaGY5ZzcxQzRvZXNTNTlUYm8yTWRWZGo3?=
 =?utf-8?B?Q1dqSTk3QThGUnJxWXE4Tm9jbmtDZG90SFhPTmx2WEhBUXdFYmF0RDhrVStB?=
 =?utf-8?B?QlRZcGM1dC9PUjVVS1pBdVhHY1BIMCtPUGhGdmFoOHc3d3pudStpRlhIS3ZV?=
 =?utf-8?B?ZXNFT3dnSzQ1U0Nqa2htYXA4OU96bHZzQmVTZFpUdUU5T0h3U1lUcTlXY09W?=
 =?utf-8?B?NHo1S250N0JVY0V3S05SRUFBVjlMWmpYRThHdlhJTzZpa055b0Exb2JiYVhu?=
 =?utf-8?B?V0Z6bFBTNFpWekxTTjJDenpCNThLdG9lbjJLVXBBQXdPdjl3bkJGSVBEOWI0?=
 =?utf-8?B?dmhrYzhlZjhzSTB1cFluSFNqcmw0Q0FHZElBcGN5dG5DdjM1ZEtPM0RTenJi?=
 =?utf-8?B?dTF4blZKS1YxcVRlRS9iTHZ2RzQyYjc5Z1dhNFVaZUxLYTd6SmF1cUxNRExR?=
 =?utf-8?Q?NokmPw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzUva25YdWRXM2NwU3d2NW9CejZlN3hNRlJyYjNjalNydEhKRktScmhUNFRR?=
 =?utf-8?B?c2o4c0VGemVwTk9NMWpRMUN5Y01PU29INWp2czk2SkRiK3hwbEZlcGk0ZjA3?=
 =?utf-8?B?WWVpaXVkTUdTTkt3SUFJQlBOQjFoYmtjem5HbnNYM1lhbEdUa1FrVVpmd0p0?=
 =?utf-8?B?c1FKYWdmZ2RyekxsZjZsWW11RXpxeCtVYWF0S281R3VFU0FSWTZBSEFRMDF3?=
 =?utf-8?B?N1psdlNMYk5uem5QcmthZ3htWFBpdGZicHdGYlRMalRlQU10ZnlpYmdpZmJU?=
 =?utf-8?B?bzkxamE0WjdOQ2dPalRvMEY0cXB0OERCdUxQZGxOcm5zYWZUY01wUEhqamVv?=
 =?utf-8?B?cUVFUGQ4QmdsM3FtUVRMRnA4UFZ5amhNWUhDTDFQcjdZSjZvUVRtTFMvYXRw?=
 =?utf-8?B?Vk03R0g3cTJhbnlrcFVxRG82L2ROU0drSU1EYld4ZHEvbVg5OTVBYllvcFR3?=
 =?utf-8?B?eDlYTzNqVmVzQ3dEMW9QdExYeEFNUTZnclBaSjF5aEl2Umh6cURYTEdERVFq?=
 =?utf-8?B?QlNqY1luM0hSb25JcE1mMDJ1elJYckxBYXAxUDhIK2Y4eWh5Q05qelJNN21r?=
 =?utf-8?B?YW1IakxjcXlnNEZDOUlhVVYyVTN0YkZSbEwxUlF3SUpoL09jdzJkMUl1Kytj?=
 =?utf-8?B?V3lQZVRUVlZ3cllMcEd3NmVuNG9pUzI0MkdEalRqdGpLdSsyK2F6VFdtMERh?=
 =?utf-8?B?dmYwMGJwQkxMVFpRRDFpMTBpWE1VUk1URlRpcERFUWFQRU9oSUMxTzk0dFUv?=
 =?utf-8?B?RXI2ZllXcGwrcmpMVmhTbWFucHdBWlZJUkxWY1h1YWNoZ2RNNnlyVmNRTEVN?=
 =?utf-8?B?YzZ3MVA4UmRCMjFkZURnR3pWQWxuc0k3Rzg3UWsyNFJBK2d4ZlEzZ1p2YnFj?=
 =?utf-8?B?SG1oS3BjSEMyUG8yVDRPOWR5Nis0QWpKWjV2MHE4WFJxVHc3RlFtK08zTHZl?=
 =?utf-8?B?eVh5SnRXOGpLbHRxUVpWZUhGR0Z3VjFrZHV6NE9mQ3h3Q0JyaWE5WTAyRklU?=
 =?utf-8?B?NW56WSt3RVhHN09GWEEyWU5mSTBUUkNUd0JDNjl1T3JpZnFhNlRCUUdLTERr?=
 =?utf-8?B?R09sbjlMcTIwdlk1OE40bEJGN0JHamI3TjdOUmJCSDBYNFNIVnZELzVSRC9E?=
 =?utf-8?B?WHpOTVZrbzZSNE9lanVuNUFhWnVLdStBMStsR2UrVG51cU9QZ1pYaitpbXl1?=
 =?utf-8?B?Nkt6TjdLZlZ5ckkyeGt4QmZNWUwvTG1KOXJ1aUx1UTdHNFlZOG4wUEFranNi?=
 =?utf-8?B?MGs1K3lCdVc2Z3Y3MFZoN216d1JCcmNvZVhTejNORE5pTmxwLzU4c1JaV2Ru?=
 =?utf-8?B?WFd6U0tnK1RpTEQ5SzR6NUZYZGt3YlBnS0dCdW5YdzBuUm5Fd3MzT0YzaC94?=
 =?utf-8?B?L2Fsa3Iwc3NoY2hTNUF0eFEwYWx5Z01wYzFUZkdKOUV3TFlIcHdCWXZmVkJV?=
 =?utf-8?B?YzVDRS95Ri9IbjVSdUU2U0xmdDlBUVdYdDNGUFloamN6T0pLZS96ZW5NWVNF?=
 =?utf-8?B?MXAwTU5pQXRLY3ZNZzZSdHZnQ3hLVzl3MGg2OW4weEJVNkVTNXdLdVdqZFBy?=
 =?utf-8?B?U3JzODh2WDFpMkJSZFZWdldVdllySlVFeHRQNW1DQXBHZVBqTkdhTHNhZDV3?=
 =?utf-8?B?M3RkRjlNNWJQbmE0ZXRuazZ1b2ZKdUR5eHU0VWo4VkdJNTBEb3BEQ05SUGpD?=
 =?utf-8?B?K0xsdExLQjd4NWlIL0dqKzkxc0RPQjRDeWl3U1pVeVE0b0V2WUhwY0JEcHFC?=
 =?utf-8?B?MCs4dU9WRHdWbWloMWh0UFRRczlISURXTGFuVkh0UW1pdThLRVhIc0V4NEVo?=
 =?utf-8?Q?qi8pCgiKEsqObYECEk+vqkWJPOFzhqC5rOzA0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6860.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b0a268-787e-4ee3-a2b7-08df4a674d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 20:12:44.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11197

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDIzLCAyMDI2IDEwOjQ1IFBNDQo+IA0KPiBPbiAxMS8yNC8yMDI2IDU6NDYg
QU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE5hbWFuIEphaW4gPG5hbWphaW5A
bGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTcsIDIwMjYgMTox
NSBBTQ0KPiA+Pg0KPiA+PiBTdWNjZXNzZnVsIEh5cGVyLVYgZmx1c2ggaHlwZXJjYWxscyBkbyBu
b3QgcnVuIHRoZSBndWVzdCBjYWxsYmFja3MgdGhhdA0KPiA+DQo+ID4gSG93IHNob3VsZCBJIGlu
dGVycHJldCB0aGUgIlN1Y2Nlc3NmdWwiIHF1YWxpZmllciBvbiB0aGlzIHN0YXRlbWVudD8gSXQg
c2VlbXMNCj4gPiBhIGJpdCBzcHVyaW91cyBzaW5jZSB1bnN1Y2Nlc3NmdWwgZmx1c2ggaHlwZXJj
YWxscyBkb24ndCBydW4gdGhlIGNhbGxiYWNrcw0KPiA+IGVpdGhlci4gQnV0IG1heWJlIHRoZXJl
J3Mgc29tZXRoaW5nIEknbSBub3QgdW5kZXJzdGFuZGluZyAuLi4uDQo+ID4NCj4gPiBNaWNoYWVs
DQo+ID4NCj4gDQo+IEkgbWVhbnQgdGhhdCBhIGZhaWxlZCBoeXBlcmNhbGwgbGVhZHMgdG8gbmF0
aXZlIGZhbGxiYWNrLCB3aGljaCBjYW4gcnVuDQo+IHRoZSBjYWxsYmFja3MsIHdoZXJlYXMgYSBz
dWNjZXNzZnVsIGNhbGwgcmV0dXJucyB3aXRob3V0DQo+IGRvaW5nIHNvLiBCdXQgdGhlIGh5cGVy
Y2FsbCBpdHNlbGYgbmV2ZXIgcnVucyB0aG9zZSBjYWxsYmFja3MuDQo+IA0KPiBJIGNhbiB1c2Ug
dGhpcyBjb21taXQgbXNnIHRoZSBuZXh0IHRpbWUuDQo+IA0KPiANCj4geDg2L2h5cGVydjogVXNl
IG5hdGl2ZSBmbHVzaGVzIGZvciBtYXNrIHRyaW1taW5nIGFuZCBBU0lEIHRyYW5zaXRpb25zDQo+
IA0KPiBXaGVuIHRyaW1taW5nIG1tX2NwdW1hc2soKSwgTGludXggbmVlZHMgdG8gcnVuIGZsdXNo
X3RsYl9mdW5jKCkgb24NCj4gcmVtb3RlIENQVXMgc28gdGhleSBjYW4gY2xlYXIgdGhlaXIgc3Rh
bGUgYml0cy4gQSBIeXBlci1WIFRMQiBmbHVzaA0KPiBoeXBlcmNhbGwgaW52YWxpZGF0ZXMgdHJh
bnNsYXRpb25zIGJ1dCBkb2VzIG5vdCBydW4gdGhpcyBmdW5jdGlvbi4NCj4gDQo+IFRoZSBzYW1l
IGFwcGxpZXMgZHVyaW5nIGEgZ2xvYmFsIEFTSUQgdHJhbnNpdGlvbi4gQ1BVcyBzdGlsbCB1c2lu
Zw0KPiBsb2NhbCBBU0lEcyBuZWVkIHRvIHJ1biBmbHVzaF90bGJfZnVuYygpIHRvIHN3aXRjaCB0
byB0aGUgZ2xvYmFsIEFTSUQuDQo+IA0KPiBDYWxsIG5hdGl2ZV9mbHVzaF90bGJfbXVsdGkoKSBp
biBib3RoIGNhc2VzIHNvIHRoZSByZXF1aXJlZCB3b3JrIHJ1bnMNCj4gb24gdGhlIHRhcmdldCBD
UFVzLg0KPiANCg0KWWVzLCB0aGlzIHRleHQgbG9va3MgZ29vZCB0byBtZS4NCg0KQSBjb21tZW50
IHVucmVsYXRlZCB0byB0aGUgY29tbWl0IHRleHQ6IG1tX2luX2FzaWRfdHJhbnNpdGlvbigpDQpp
cyBhbHdheXMgZmFsc2UgdW5sZXNzIHRoZSBJTlZMUEdCIGluc3RydWN0aW9uIGlzIHByZXNlbnQs
IHdoaWNoIGlzIG9ubHkNCm9uIEFNRCBwcm9jZXNzb3JzLiBGdXJ0aGVybW9yZSwgd2hlbiBJIGxh
c3QgY2hlY2tlZCBhYm91dCBhIHllYXINCmFnbywgSHlwZXItViBkb2VzIG5vdCBtYWtlIElOVkxQ
R0IgYXZhaWxhYmxlIGluIGd1ZXN0IFZNcywgZXhjZXB0DQpmb3IgU0VWLVNOUCBndWVzdHMuIFNv
IGlmIHlvdSB3YW50IHRvIHRlc3QgdGhlIGxvY2FsIEFTSUQgdG8gZ2xvYmFsDQpBU0lEIHBhdGgs
IGl0IG11c3QgYmUgb24gYW4gU0VWLVNOUCBWTS4NCg0KTWljaGFlbA0KDQoNCg0KDQoNCg==
