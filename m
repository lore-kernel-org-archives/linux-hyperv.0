Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.143
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793422285;
	b=sD/UyaTddZzeBf8oPyNfP3aVEe7zUaR1xJKhemAma5K05P1MLraAT0shhi8zHtmc722V
	 FSF1UiqsiqFLRbbbGjXw06iJpvWoO2vYmVjmF3ZnTfr/3FAv4dWHhEXjXNvwolUEV0WeN
	 OCq7Khhh/HeayZV94IM+Qiu/nxalBxu610XNMPL8rXyW8t2HnF1WkkWs5KFTp6am4N1E9
	 /hcQF93x2RqIQ06v0LwCWnqcfCE1jc/PTbJjcaA7DnOW6HofTCva79+JDnM+SBL1CsODd
	 6pLl0c/MjH6Vzt9Mg2ykb8wr/URINIeHP72s1Yq7YUbphjkb6dV/BXtNFcYBS17tCcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793422285;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-traffictypediagnostic:x-ms-publictraffictype:
	 client-request-id:request-id:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9DeGQICiLtTg9nSkIhPkMLPYOj2zayOu81E4wnX2DvE=;
	b=RCqLEA4DqU51fEF/VZYCiyPqFJvm53lKOw7JoIpl5b6YE5NNXLAlv9aTBYKcRDjyJMWT
	 oGKrXe1gwbD2e9ulVlrSu3cFQYOdPy6HQUFzVfZzAkLwwGJvkDRAB8u6PAPcb3PpqTssg
	 zCQjx4qw663hU/4HzhqY93exjXvsPUOB3RAmbBYD+qzbuKKtNc3FqmgzJQzxuHFfGeswf
	 Ww8qoHT8bmJQ4AG+3u33h+TEaExmw07+6TfrK/v5Wa1zAQhqxS8S4l0fZ6K7zSuf5KpV0
	 4FgAwZSrRpmYRgs/Fg7ZIHtw599q4KNBnZHNBBd4tL7mxtLcXi8GJtr2SfRtqNtEkIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microsoft.com;
	spf=pass smtp.mailfrom=microsoft.com;
	dkim=pass header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=OPmZVDBh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.143
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020143.outbound.protection.outlook.com [52.101.46.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04611606A31A;
	Sat, 31 Oct 2026 04:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04611606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=OPmZVDBh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiGsG/X751tK/WZltOK7/hwvCqgVYz08rssg5NDK9teYrLQRvI/ceVK8N1oiTAoGdpXShKB61WnBcxUhBYIfWuiXklpiMZG1DM+wDqnj/wHJCc4XUsBUDh1OEIos7hu+6ScOmo40iEYNsFyvtWxcJbmAL+VWOf4vZ43e/LyzVopZIM0KPNvhI/h3EnHPSobRabO8+Q9VOiR+D3JPPAzlyHPeVCt24SGyDtffGnERKVfICObZVoadeZAhTqlzPbpq5JlUD1BkV2Gk/rk2pnhOpRcIiiG+DRt4ALoge0TveqMM4aHuYMMLDcpApfpC3qrH7s4+WLmW8AIJRWuV8fVnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DeGQICiLtTg9nSkIhPkMLPYOj2zayOu81E4wnX2DvE=;
 b=awRKSURDECKlPuj+tMFgr6D8wQS5QJ07rFSQRVxvcwF1mFR+/7HuIj3K33OsFaWoPDfOASAXibOFq/8pmPfJeQ6ZpD9HkQ7cr/tLQtbEn/Cxl6CFuRYsXsJ1xXmHIbru/PfbOx7JdVF/tAydyj7NdNzU3jXzR344fhJ2LHszf7VCI+Qq+Iq+26y3Oq6v2Wp9kSJBQNDtLgXzv5EEDg44ji5Ir75AdCgCDnks5QxOLCv1d4NiGJJw88s1jMG7jIAShtaI/UCDIbrDqLGD1WHUPZxqrrrYmmPYM1lfuWbdJhWLNZvYKLJcuq2fvq2x+CAYVhEk2grkdjZTO1tvEkeFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DeGQICiLtTg9nSkIhPkMLPYOj2zayOu81E4wnX2DvE=;
 b=OPmZVDBh3OOkEFevYuQWLOAR1PUrs6LrdPwptYr/5m4G1YD9Z52qv7gypz0llWE2qRT4qFgm5GlbxLqZ9H/kk1QHd/OkxtAeFiNHSnBRRQOA+lL0MSRAr/ko+lZHyixtOlIFizL89r/4XIZQdeEZwMjrK20089ElfnKVmGTvVxY=
Received: from CH4PPF0966F22FC.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::c44) by CH8PR21MB4693.namprd21.prod.outlook.com with
 HTTP via P2P; Sat, 31 Oct 2026 04:51:21 +0000
Received: from CH4PPF0966F22FC.namprd21.prod.outlook.com
 ([fe80::d976:2d64:b851:4f61]) by CH4PPF0966F22FC.namprd21.prod.outlook.com
 ([fe80::d976:2d64:b851:4f61%8]) with mapi id 15.21.0592.001; Sat, 31 Oct 2026
 04:51:21 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "mhklinux@outlook.com" <mhklinux@outlook.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "Mark.Rutland" <Mark.Rutland@arm.com>,
	"sudeep.holla@kernel.org" <sudeep.holla@kernel.org>, "thuth@redhat.com"
	<thuth@redhat.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 1/6] arm64: rsi: Add RSI host call structure and helper
 function
Thread-Topic: [PATCH v6 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Thread-Index: AQHdaMzUUokNwK8a/EiHtGsVfz1nK7cXFNdQ
Date: Sat, 31 Oct 2026 04:51:21 +0000
Message-ID:
 <CH4PPF0966F22FCBBF24F0929E97AC69951BF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-2-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261031001412.4150488-2-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3b05dc1b-35e2-4bec-ad0e-0d9fe2821a86;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-10-31T04:49:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: CH4PPF0966F22FC:EE_|CH8PR21MB4693:EE_
x-ms-publictraffictype: Email
client-request-id: 9e674162-bd76-4ec1-a8f6-e7ad9f5c3291
request-id: a02e4ac3-508b-4bfd-0d6f-08df370a9bf9
x-ms-office365-filtering-correlation-id: a02e4ac3-508b-4bfd-0d6f-08df370a9bf9
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|38070700021|7146999003|5023799004|11063799006|56012099006|261009223027099003|4143699003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|10067099003|7053199004|18002099003|22082099003|6133799003|261028144727099003;
x-microsoft-antispam-message-info:
 HTJTt1CgTsmFpSWLdA6KooI2PV8CGryippcBo62f82bzFTh3OMXR3NQ5b9jQkjlRMhdRWitFIwghjY657FgWByR+JxgbEtFXod4t4WyOAQF/iXtJIWCCxmAK8tG4dO0BSoy2NgPPeaC6iOXwZx+HiVaADXUA0iXpLgtYEhMcoZph6i1SCdiZcg8BRYujK/DCwTfqGhZiqgi8tkNTXAvdr+QtGq9HN/QdbszUpzM7KjwvatQMbOhoFKrIZY0d2IadJB3W543/pI7MOHYGafNLSjWV342SQ6Je+XSzy3aOpf93kRsLghymtbCMETVOwc0oabS2Dofp4Ua5AjhZEfn+up+hrfqVFwAWfgmu8ckqyYZ18GDqAftBhCBW1bIRjLU1a2Dyd51nuLrCi9xm41X+EZsELv142IwCzjKAG7Ys67u7Jzec5DMiyUMnG3hPGbLI7Pfuaa0YxxPqsXXwzdNx3NSNc4fBBqrkHNBlJ4DN7/lJLZ5yDMwN3P9BVrCDntVSrz9HupXziGXbRsnzwQNojtLluEvpxC2GRjZSPiG2T3IiblVH4cRGToAzZGuiLK5UpyMlf3dn5K2K4RXzqQf83q6mH/x10eadcso8h2mynjq1lo6W5mBOwhP1ClMX6z2o4HhHB2+1pDKcDpbnJqzGwZjLsMXOD8IuLMMWrFSxp4cvn30WZqe6wFWy7cCwETx6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(38070700021)(7146999003)(5023799004)(11063799006)(56012099006)(261009223027099003)(4143699003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(7053199004)(18002099003)(22082099003)(6133799003)(261028144727099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xZxkbWjLehfuRL5rfTlkw3hp39I07Jo3ZfvgbYi6X7mV/zw6rARTGQ5MR47N?=
 =?us-ascii?Q?GFZRsMPPloFm4i3wFRNFefbTJk/1vynD8M0AZfRJ7szaCQthnp/zMvHXERNo?=
 =?us-ascii?Q?WogLXqGQ6Zn5zcw8yPm9b+ARefC+EehJyjkUL7n+QmNL6uNHHYIUcjIJiUTv?=
 =?us-ascii?Q?NoBZz7vBzsnu3bq2vF0Mrzq/WxmEdVzd92geLzN6Bp5omeoqeSyutUpmEuBA?=
 =?us-ascii?Q?aerSw5sE4aApNb+cTc0oPINBPzvJWzb4jqr7BxrKzzowLc4lbvm/KdbGz8iR?=
 =?us-ascii?Q?wmtOJVr7HXO7RImJGxlRgWs5wdfBtXc8NLqlyCXk/jafrCUqsRGhDH/uIVEv?=
 =?us-ascii?Q?0FoSp0aRLWyjcl787lp9epZAz2i+AtBnvs66sKoZrYxkOQR5yin8WKANMfKl?=
 =?us-ascii?Q?bPCNqtv2geiLLeU4wHDsVrRCkl/H/pHwk+HSYx+9cgtR+goN+y3uDittfDD7?=
 =?us-ascii?Q?7DAza9Pw8O33fdacbfFrLnhdk6MiToFshV5xYWt5lu/l6C5nn0bZ05bLr5q1?=
 =?us-ascii?Q?y5t/pSb9eisVUl3iXADK5/8qzpGRMKjMZ6V91DDNE8Pj8ntd6RRJ9MlRsbFe?=
 =?us-ascii?Q?r4pKKovk9qbBBlO1FX0D3vy3mWSE92X1QUF09fDpopCcqNpt8S2llmWldlkV?=
 =?us-ascii?Q?i3T6Vwz1h9PlWERTASZqON2LouIsUBuDqeyJJnzhkS9MTq3nzBLiek0hqY2H?=
 =?us-ascii?Q?tbp720rQR5RfLmYqr+RMenw8/KS/YHFA64GyoCO/Tbr53eABuiBgyLIC3OLA?=
 =?us-ascii?Q?wi+vl5R/Lfs2cz9hWe5Efrtd/HiCSo9rTkX8Cwvn22jAsRjl67crwbSSb73p?=
 =?us-ascii?Q?ZrGmWef319MzMznOlqxqnC0bemI72DWhowfjQkhkJvQEcCWA5s8x9FotUm6A?=
 =?us-ascii?Q?Sc/FxYak05E/TnetS/QetsBrCZ1lPnAt94Xw3K6609GnFteM7VuhRwzpYEP3?=
 =?us-ascii?Q?Lfm6I3YnmWF4cYwy/oM8Z8tFy5r97VR+lumsoTWZQtfFVSk1ETOlmSNt9iqa?=
 =?us-ascii?Q?0JPq0rpKfEnIj/BwkpZWDPyVBCT26Vx7ncBnrPxPnc2eqRgjE2hNe0IsOcs2?=
 =?us-ascii?Q?5TlXsLVMIc0PX+t1fo0B5vGztSUPjX13vPDSlewQlD3hkPedVOmfrIx4UngZ?=
 =?us-ascii?Q?mkDgA4baqw0U/ux2sCmaeF9scAP/vj1IqbMmvhAuOO3S5uicrPpVycLqMWgs?=
 =?us-ascii?Q?TeFe0jnemsXQq9wpQEs7piJx2vVo+2ODTFXDB6+9jBV0x1M/7fzopPhr5v1q?=
 =?us-ascii?Q?fido7Q+oOfSOaHkWjDxeTOXGfeMSJjTKP8H/76wTfPQ4iJBZHiOkJTa+S9ze?=
 =?us-ascii?Q?oq09TV5ei35KNaa6KRHeEyE8IrjR3wYs2RgKef6L34EuozNbY9Z20bgDQJIn?=
 =?us-ascii?Q?Yo4zTW+8M3LptWfJwONaouF4WwxWkJtyIpgnRonoRlIyTRd4thgvYAYvDQ7B?=
 =?us-ascii?Q?hxFAHYzprFf+R2N0E/YxZfFf/l7vekfCL92XqY9hZiNfrfjCHmC7sLA0rj3G?=
 =?us-ascii?Q?/ELH15hmeVCbfNrkjG3Mb2U7G2nPlJYfuDPS3NFOWuJWdpDp0sHBOrN+tNWK?=
 =?us-ascii?Q?3wkYq/07meL7tFXxXCj8nPLkQoG33O8NjL2oq7bun+Yiv0PdLSbz/SPjLZXU?=
 =?us-ascii?Q?XnpYl/BSaD0VilaXwVamoYhB8bbDMow0yFsIhQ29fWDmhIKQFbthhyX4Yk6w?=
 =?us-ascii?Q?2DRTOD3+Z1oUHXCxy1ksWu98qKiol4m8itSbrWAhuFwyZnQH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PPF0966F22FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02e4ac3-508b-4bfd-0d6f-08df370a9bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2026 04:51:21.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhcEXvbwswsu/cpy4OboIMVO5P68Tnunx2eLmCuRuSRNQExUGk6E14R1Td3AKmZKsc1kJud2ohBSwtsx45EsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR21MB4693

> From: Kameron Carr <kameroncarr@linux.microsoft.com>
> Sent: Friday, October 30, 2026 5:14 PM
> To: Dexuan Cui <DECUI@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; mhklinux@outlook.com; wei.liu@kernel.org
> Cc: arnd@arndb.de; catalin.marinas@arm.com; linux-arch@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-hyperv@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; lpieralisi@kernel.org; Mark.Rutland
> <Mark.Rutland@arm.com>; sudeep.holla@kernel.org; thuth@redhat.com;
> will@kernel.org
> Subject: [PATCH v6 1/6] arm64: rsi: Add RSI host call structure and helpe=
r
> function
>=20
> Add struct rsi_host_call to arm-smccc-rsi.h, which represents the host
> call data structure used by the Realm Management Monitor (RMM) for the
> RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
> and 31 general-purpose register values, aligned to 256 bytes as required
> by the CCA RMM specification.
>=20
> Add rsi_host_call() static inline wrapper in arm-rsi-cmds.h that invokes
> SMC_RSI_HOST_CALL with the physical address of the host call structure.
> This will be used by Hyper-V guest code to route hypercalls through the
> RSI interface when running inside an Arm CCA Realm.
>=20
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---

Catalin provided Reviewed-by to v5's patch #1, which is the same
as v6's patch #1:
https://lore.kernel.org/all/auPOxoaRbdOEHnv_@arm.com/


