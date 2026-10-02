Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020126.outbound.protection.outlook.com [52.101.46.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E13C5DC5;
	Fri,  2 Oct 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969941; cv=fail; b=acRC1kAAP1nawnMN5bnRKD9O6K5YYyx+fqqqT6FYPRttWiovieuQGJUh2ObVrbzFL25CvEvW9SIm+gnlBxuc5JVpN8Tp9QefkjUFz7cH8+JCBRr9y/1ESzmRhVMphRptDTEAwU3Qh6iO2Y3E5CW4nBSqWiTI2SzEDslGJuY8A1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969941; c=relaxed/simple;
	bh=tAyaJsiuhdI6h9U0jv9/8ebE1mg6Budt2dGHMAUFg1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JZUU4osCvzkhh1UNxyWlT9qA7v9VTteUUOKsog28sSCNcr5wM0OnbMfKQy4yTzEwMauIvap6irq3CdwR1eMSRPJEGVbtSoF2fvz+ev0A73A0L67ODk6wTrJUSXyikG0Ys/UHD49u+HsfDYnPGVBwWhqUWAY75HTbtaNAcIKIWxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V2i4RrEp; arc=fail smtp.client-ip=52.101.46.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V2i4RrEp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWFzNVYip2pSbGpuwSD+wqXXJlh3EMEcpEnme8Cz2tAzpJ3lNkUl1XuxyxW4pXgGt+nTL+118dfFxlQQBrcWTY14M61MVyMiTP8XDX9wFUsWpBeCDCFql0ZfXdAgNiF/tR2922doyt8V16oayr+T24OBRc/wzymNUk8Who8RT+VuYbLlaL5H/6mIIX9MM7DI5sbh2ij3YOD6pQZ0h0ADtTlFp4RXt9NOz5HUpPIoGoJaoJtP/rO2BEOh/yTNLfC9HNF7Xt06E1l1+k9W2KC2Wd4HrA1vMTdEHYEBTaXHAQ/CCYT10Z7SFoN1b+EobGF/Knm7A6kNGMUQyAjS8VqMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDI6r/POlYLggRdXMekjh9CHeK4InECjfuaJhPpA8dI=;
 b=nXIR5Xpj89plz1xdMfageOh+0P+e7JV/JGhyp3LijOWQ+BZEUi8gx8PIoWeQW9KstH9RZCvkekRICsECmSop8PLscfRj1oNXo8zerUHaYZuxPISexfwoaOayqrkiTYLGyH8dSUPyU7RCwBgaB0byqyaxsfmiKA6dwHuTWXzx65UXP9r4qtu4MaK3nvFxRBGJ3yrdO/BB1/CYBW04C9r++NeV+Tuw1j3pOyCq6g5qH29nYSWEEnRzExXhVWnRVa5kW5LJuPDfCCBNGm7mILbSOKx2Fs4N/rlWqwWSuk/SupZKOfuAPwjxBN4DBx1t1TZ3KvS2eJxz1nbzF9MW0aI3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDI6r/POlYLggRdXMekjh9CHeK4InECjfuaJhPpA8dI=;
 b=V2i4RrEpzoU/0rn/PIq02xN78hLS//R+vUqktUENcZkOs2ONGeTUXV1LneofqV28toe6ubm8BBpkWM8wgms/cmFPXJJOFzUPKe+U3gVuqoJzUnCIKX+bMRWOoGPxF8O4VDwQLYc5alW63wrhRwU3Q0gOyzqYZ9QLIMrU9ZfnOpE=
Received: from LV5PR21MB4704.namprd21.prod.outlook.com (2603:10b6:408:307::7)
 by LV4PR21MB6292.namprd21.prod.outlook.com (2603:10b6:408:356::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 19:38:51 +0000
Received: from LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb]) by LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb%4]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 19:38:51 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"hawk@kernel.org" <hawk@kernel.org>, "andriin@fb.com" <andriin@fb.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH net-next 0/5] hv_netvsc: make XDP propagation
 act more like bonding
Thread-Topic: [EXTERNAL] [PATCH net-next 0/5] hv_netvsc: make XDP propagation
 act more like bonding
Thread-Index: AQHdUUYBYEQd+JFADUy8Bu9DLbbaErbqp74Q
Date: Fri, 2 Oct 2026 19:38:51 +0000
Message-ID:
 <LV5PR21MB4704E9960B2B82028F2FB51DCA892@LV5PR21MB4704.namprd21.prod.outlook.com>
References: <20261001014131.310771-1-kuba@kernel.org>
In-Reply-To: <20261001014131.310771-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b9b005d-30d1-4ead-944e-0a863ed84eaf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-10-02T19:35:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4704:EE_|LV4PR21MB6292:EE_
x-ms-office365-filtering-correlation-id: 8d6883d0-88d6-4958-555a-08df20bcc99e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|260925021911599003|260925022911599003|260925021311599003|10067099003|56012099006|11063799006|7146999003|6133799003|4133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 9Jk8eS6QEmACyINiRCb8TQSg/jD5DW4SezMZztZtkljR7lS6x+TnNQgKc9XG6yu9jZoHOrBi9YElB5HHdef2Dh9Xws68emKhMrBgcLTX9lczlVJK56HhHh5qlt38eOfhRj9HCyt0KDHBEahcBjBQmdKOf/mw46X4UNTnFJ1twY4B7VjrePl0DviH/fii+JeUPOpgmWst17NRlRpQerqALA+fYZpK7waoEdAkygXazc3aHmbao5fpcloBE9Fuc4OY1hGK4T4HL5GPRLPlQIHmyucTXL6N8OwdPKV9MQ6dskOBSEdcjeZONq7AjXlTxxxoMB8m+8kBYX1YETeyGdGkhjCea0hbWb5BQUhLrMCkI4DwspvDgDrujxsP1GriO6DPEDnqb/Fpofjs4GxhgOLQ363813mYRHxp198Mx+TeIGtTLNsowY2pm3kFtSUnLdLpHCfh3bW3ceIle9F9HQMv9WWNYUOZU/pG4fq1ffNJZ34QFkAP8e+P+JwLsLKg+Q6+1lFr6nZmmmWcygT4hi6Uz4cD6DEkzPrcftrI8Mq+4XXGDI8/QNZzGgI6fmpI++sqH8OU5WKaMHvVhKTAnVMYLTmRD/cztMvYPku8Y/HR/aYRFcw+WLxuzV8BucuIfperGBVINyuWqXYZZP8E1vXE1DuAPqtvIku0ickRjvyr1dc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR21MB4704.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(56012099006)(11063799006)(7146999003)(6133799003)(4133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7Dpc/bWDrQ26/XbDTiAYQkpzengKvShXMeHRyZpLizMESU5J8x2YN3BFzHN9?=
 =?us-ascii?Q?Axqc4BUbYig8OIYsLsg6OR7aLclvsokndoHrlGnya60MH3hUwOYabKJsJe4Y?=
 =?us-ascii?Q?w+qKlin/3HeQn7sbp7spU/Bf/lFGRrp+Kmi/u7RH9YA1w5Dw+sKW7r7ZfaS1?=
 =?us-ascii?Q?hZKZ32xvPz1lfs3Dq2HYpamCrP8OM9t0s2BcSh2fv7aVcFgRCotjSWvKb6jW?=
 =?us-ascii?Q?C0amYfw0WeV7zDXshpHfUOrU/3TnHSltSTdyfSNQ2jKEpwu2mJ1KQgXAzM0J?=
 =?us-ascii?Q?vXVF3oiMeLqFpZby/daJD89HdshqtOJDfGwyctktdma9WtY6MS98ghsQJ2PT?=
 =?us-ascii?Q?nYuNCZ8QMv3xDLA6n1FdElA8a3dpOFCfaFx6PYVki/2CfWitrfI6EAcJTenY?=
 =?us-ascii?Q?VdYN7ac6LNQZCfTGV50dF+ziTyTqiE7G4csR+TEm79jlv9rbH5Mzlu40QSCk?=
 =?us-ascii?Q?uSgQRtLTgH/fbuUyDG6Tt1Qr8KJdMCEPSvHEj2LjXObO5RPuMdtKfy8RvxBO?=
 =?us-ascii?Q?Qz8/1s5rFPAI/LcvXS9PGAuVu8t+lAfbeNrhwXWHknIaGs32TnNy+BWjg8KK?=
 =?us-ascii?Q?mIgXq7cWJjeCdkYPtYfcwuI+Rr58iFUJkKC7EfsMTTIL506+VjSLdf3cZNcl?=
 =?us-ascii?Q?eH2m2nmrUyQ+GOu9KJhS+FwO7sxTD7ar9FiFMfCbJLoJ52tvkfrqW7CUAmnj?=
 =?us-ascii?Q?kOCHNDzBgVboW1DxdkWHpllUJdCjyadKQxQZy1Ogwkp00oyIuo1kQbsh3Ziy?=
 =?us-ascii?Q?6jXoOK3D7bvUVbHxd/IZ4fvmpTgiNlUrExQ59nOeSbLvn5Lyb0JgTb8hHA1m?=
 =?us-ascii?Q?y7D+oiCu2jJMglGbExOphtfq/KutcgdFL0NJZl+RB+nSP77kwZVssGrlINlt?=
 =?us-ascii?Q?JSPO3AZioRlSefv+hqkLHmKkwS4obBr7C+gI5y98wTTIikG3oL9y6fiF7fnT?=
 =?us-ascii?Q?1oVkQLYM6ccPfX9w77jVBBR5sjx9uPXqM1wc8e1rkSjs8nrVYOHg4cOFI9/C?=
 =?us-ascii?Q?wYiJt2bgdK4RJlCFPfSTcI9RtjPhP01ZTQFf2L2pCx/a4NmEZQkUrKEj4fNY?=
 =?us-ascii?Q?QKY0vgc6N24LOG4LN/4DIdyrZYgMdhy3DgkFtUZhUHeVIvkXL+vQLc6DzKUd?=
 =?us-ascii?Q?B1DwRyj8nagHxEU0QLRPsupzcgWYaB/awPgHlTD8gW7Q0APKuIb4UcwTwxyp?=
 =?us-ascii?Q?fwkJu9u5bnmqaY0L0eXszdqUPouOx2v5oMhxd7v5YeGXTIHBvXN9IrPg9tdi?=
 =?us-ascii?Q?O4jEfVLdANHuElxNRk1wsDqS14RESofGwnC1ZI8O9GW90t4Q7NJ+YlRzFNLg?=
 =?us-ascii?Q?q1aDYDbzxy2/R1fAj/32uPF2/KWYVSAoyOFJMkMNLFTdXPxVm6HaDtLGGzeU?=
 =?us-ascii?Q?joxUqWxqvprLwVyHZ1ihE63ZZwKUCzO12YWHomu3AoxFLgnPYOO/KtD4RaLR?=
 =?us-ascii?Q?TmdFJUDOObtjkHj5NmTxtIQUnrEluQsdfoiWAr4g1JdeiCNxO7XLrf6HG5b4?=
 =?us-ascii?Q?iGthm59Hh16vh6Wr5mq4kf1Yf5i2hdSO/xqusaq/qh6wTZLeWEWvvNdZCaEx?=
 =?us-ascii?Q?NmWKxcA8Vn4aSyAIMXQqLR+21snI2gXXuS8hFl1Yh7kO7F36Zdn609sh3FAA?=
 =?us-ascii?Q?h4YJQm2ASjpBduRrOaHq4FDdmNyXSO9SRdWWCjJAXW/IgGPuH6UyFFDjev/F?=
 =?us-ascii?Q?yAYpPQQuluMF1zFWNfnco0Em0kXzpr77BOpYpboL1w9Uq9bkingCc6ueYaf8?=
 =?us-ascii?Q?/8xsB247fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4704.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6883d0-88d6-4958-555a-08df20bcc99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 19:38:51.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjK4ZyX8LlAMy8sqrieX8Zhe/IdPFhCaTrhDmrxZjo2YcK/Mhkx/mit9vcNp6QzbQAkCXQzgurOx9jYgjV1TNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR21MB6292



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, September 30, 2026 9:41 PM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; horms@kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; longli@microsoft.com; linux-hyperv@vger.kernel.org=
;
> hawk@kernel.org; andriin@fb.com; Jakub Kicinski <kuba@kernel.org>
> Subject: [EXTERNAL] [PATCH net-next 0/5] hv_netvsc: make XDP propagation
> act more like bonding
>
> Currently XDP programs propagated from uppers are invisible
> to safety checks. I'm trying to fix that, but AI reviewer
> threw up a bunch of complaints about hv_netvsc. See previous
> series here:
>
> https://lore.ker/
> nel.org%2F20260928223648.2739371-1-
> kuba%40kernel.org&data=3D05%7C02%7Chaiyangz%40microsoft.com%7C004597675fc=
941
> cc7a8808df1f5d2050%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C639264157=
0
> 12414027%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw=
M
> CIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D=
Sd7
> 6Tk%2Bqcp1GeOUDM2YWyo3l4WzWW7U2vRHsXjx9SGk%3D&reserved=3D0
>
> That series is now on hold, let's try to sanitize the hv_netvsc
> behavior. AFAIU the main use case is to catch the VF as it appears,
> and attach it to the netvsc SW interface. If we catch the VF
> as soon as it appears we shouldn't have to worry about the VF
> already having XDP attached. Let's do what bonding does and
> refuse to attach if VF already has XDP, also refuse to attach
> if nv_netvsc has XDP but the VF refuses the propagation.
>
> All patches are from LLM reviews and LLM generated. I do not
> have access to Hyper-V. I did 6 cycles of reviews and back
> and forth with the LLM over these, so I think they should
> be okay-ish. Let's be clear tho, that I do not care one bit
> about this driver and it's brokenness is blocking core work.
>
> Jakub Kicinski (5):
>   hv_netvsc: fix the program refcount when the VF refuses XDP
>   hv_netvsc: hold the VF's instance lock when installing XDP on it
>   hv_netvsc: treat the VF's XDP program the way bonding treats a slave's
>   hv_netvsc: move a new VF to netvsc's netns from a work item
>   hv_netvsc: let the core take XDP off a netvsc device that is going
>     away
>
>  drivers/net/hyperv/hyperv_net.h |  3 +
>  drivers/net/hyperv/netvsc_bpf.c | 27 ++++++++-
>  drivers/net/hyperv/netvsc_drv.c | 98 +++++++++++++++++++++++++--------
>  3 files changed, 103 insertions(+), 25 deletions(-)

Thank you for making this patch set, looks good to me.
I will find a teammate to test it.

- Haiyang
