Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020130.outbound.protection.outlook.com [52.101.193.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD52D73A1;
	Fri, 28 Aug 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955819; cv=fail; b=k33HX/jKKwiDTa3BrOPHEQ10DtmYyDStm5GuMTMssYAsmNCXcuWGxquQ7RHvDNmvxW3mlZbp044W8w7Otf8/tEy/hZXH5NrRMZ0XbOwIwL+OLvVV44hcRCAm6eCg0uDp1xpxw6MCgtrz04HAbnVsXrA+DSO5YShTW+gnrRsA0Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955819; c=relaxed/simple;
	bh=RR8tCpcRwK8pEMDo2QG1BhlQL8QJHF4rQS6JXps8Dfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IlL0RLXUF5D12uo9D4FJtY7exmElIp5ZfA867lnnt0A3e19SV57xRw8AUCd6e5HFRuOqhABCiiufxbMf3SdEbV+qpIfN0fipdLVoAIGEwk1jk49ZMKq1Py3nsBN4+5BK/bkS+yYEjbSU0csC5yimNwEedMueQjhuGzhvCfF/EGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SKU8yXNd; arc=fail smtp.client-ip=52.101.193.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SKU8yXNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X18YDulLv+Ox8c7WaX+sq0fnQcX2OH0igvMOd/zZwQll545xpvtWjfEI4XV7/J3x+mnECWel+/KP4bfvTAK6BnEi4QRdyEarKSwMOje9Dqq693C3q7I6nukyLnFRwjGVDLMhFCB2WwvjUUce0GWNbBK+8nrIO3EP1RCFdVpRBZOVtlZtD9x4xBvlBzTCRfT/DPty5Gi6XHhK4j1mnYHuW9xpuRFv/IYLzD38M98UiGN9vZbUUOo74QsrvCvmKqp1jQXkcHe72D8Te7A6N0vqMtMXZIMstbHbF3xI03XTeg+WIxPG2j8vvXUw7yDfG3xCqZeTpgOWes54jS3cQ+bFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR8tCpcRwK8pEMDo2QG1BhlQL8QJHF4rQS6JXps8Dfk=;
 b=y4rK+aNmW9/d/QNgOy2SLji3YLwJM6BBzfQCc6NfpABVikeywIE4yhkkdReZT6McAqNpD6h16bP8GOY1jTw+ski9g3lNT6TLzOLqjO9XfOtSJgDC28Hmk9pkVGxGbsEcGIGrlI9I6uBrknVd2wjpoYCv676J+0weWffR73wEc0jfjvkxbuussDumfURGR+8gqq1li+6oOBd8tyovXYT1/8rlrB5yUnHH3usl1tqka89qcFXzYYDnwWjATOXShS2YyP+O0CxYbHTTMFrNsA3dDEws+618Ro1T2sQr8Iga3C9KbJFWEssVdu3QuxbskWg4YqFmBSZt3NeliLCry3msGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR8tCpcRwK8pEMDo2QG1BhlQL8QJHF4rQS6JXps8Dfk=;
 b=SKU8yXNd5lNO0SwbtKs9r5GEkQN0syxr1k4BPD/yKuMHERA+UT859pqTZsvUOrXIJsIvHDOMaFvazRPof3vtdOD+1X91oQqOJL3fThkQGq6hc6zRpMnjcJIqa8vqrnX7XynUO46UhYi4jSFwVcCRrssNw5I71dYcYTQKTdfUsnM=
Received: from CH8PR21MB4716.namprd21.prod.outlook.com (2603:10b6:610:264::15)
 by CH4PR21MB4652.namprd21.prod.outlook.com (2603:10b6:610:1f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.4; Fri, 28 Aug
 2026 22:23:35 +0000
Received: from CH8PR21MB4716.namprd21.prod.outlook.com
 ([fe80::5703:2b5a:48f7:3291]) by CH8PR21MB4716.namprd21.prod.outlook.com
 ([fe80::5703:2b5a:48f7:3291%6]) with mapi id 15.21.0382.007; Fri, 28 Aug 2026
 22:23:35 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Long Li <longli@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] hv_netvsc: Advertise the SR-IOV capability for
 CoCo VMs
Thread-Topic: [PATCH net-next] hv_netvsc: Advertise the SR-IOV capability for
 CoCo VMs
Thread-Index: AQHdNzOWypeuAZthoESKbCXZD7Ik8ba0CFFg
Date: Fri, 28 Aug 2026 22:23:34 +0000
Message-ID:
 <CH8PR21MB4716879DA48636623D5270FACAAC2@CH8PR21MB4716.namprd21.prod.outlook.com>
References: <20260828212325.2309515-1-decui@microsoft.com>
In-Reply-To: <20260828212325.2309515-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6927e5b3-60fa-4aa0-816c-1083cb67bf49;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-28T22:19:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR21MB4716:EE_|CH4PR21MB4652:EE_
x-ms-office365-filtering-correlation-id: ca993c26-8f23-45dd-7b94-08df0552ffee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|7146999003|6133799003|7053199004|22082099003|18002099003|11063799006|56012099006|38070700021|921020;
x-microsoft-antispam-message-info:
 RqugV6+jWWZd9ElzNPGRdHQXvKykuT+1hldj5nttD3zJ6eWWyDFnRurckZ6GPtmfKMDV1gdHE+zheVPh3nrgAwK3MvdQtcUpLBKLY8ZUiij3w41/X9Ax6czJfsVCd/riGHcipzAjsMzTmR8AfPVQhjF/a9kAuEQ1F2Ox0/RwG9n/hlW3YrxW+W2p+2eGQzVf8y/v9/2bJmoMZH3V6Y5c48EdwNMwodqE7yaT/PKezAArirWQO58lhs3DQ+hJXVPnDdGdQkLTqrHt4TfUzlsFO7PJxvIxJWGGcme6bAK3HaufxSQTjru/o+IIrQ6WIZuBcT9RlXapU9ksJECFkXghvgUdzRYWRuUWwZeMo7gflFcNFJQiGwf4J4HnKrkAYCB+152KYVueIJAnXGFoiSTL/sZTfvJH657l4tOVsCbQf1GR59BHuSaOGm+H+UT8QXHlQBlm0asVaakYEik+zTQuz4R68BkAbvc1NYyHeBXDdXyVmmj8vBM4pOUTzk+gMvqBpId6xzRkOFW4/ETePtB/9KEnbTh5emKZmuaRwSvET040gdppF1D9x1YYfn7xcwWZbYtK7/OivZZnWPGFZ3WUoRrJPZ6qxHEvGbp3263jJk1iAWCW2EB1TqXXHM6Rx0+xQe6X0yv5dZ1XVTXjpDxKfwzOfo5QRs1plTJHAux43NhNqCfNBylWomSdD6CQNzD/5s7BLv2kTcLYVtJ1ak7yl4qZXkZqEkWdEdDC+3shGak=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR21MB4716.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(7146999003)(6133799003)(7053199004)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?frPT7U40IXwbAc4W9q43+v3SVuqQhZiEkKdVqGSSDI3YsgasTmKPyCyNXNJZ?=
 =?us-ascii?Q?hqY3gFDyvb3HqTZirQwlafxq8pA0C784CzFDXrp9jq2YuAnCcO6ARH3il5kw?=
 =?us-ascii?Q?3qLYsGeAzGiTVbxkB19cbMTFOoNUVH+ROuXI/iC7jMm3SQZrxr4t/CqPDLsX?=
 =?us-ascii?Q?uXr/Q3hDcGB8wZAZ6Qqge+Z9wY/bEBx6uuMWVBNXnVeyDNa7x10Ms9GVlof7?=
 =?us-ascii?Q?zPAwz099m8DYbdjHAb3qZ1hwsPLZL5W0HWKlo6HuzTT8dkhj3abx+hWj2ZcL?=
 =?us-ascii?Q?/Mm3He4K8sv+m3lqj4E0nr+lQuOUEUxLCAAmy7SMbaPiTgaTRJWtkWemzFUw?=
 =?us-ascii?Q?8rfGDPWkOCYzA2YFP5cnPhLurUnDUTc4o/Nbg3F8KyQojI/qNLmG/6XXfcqj?=
 =?us-ascii?Q?KEUfgcQV32uRAyXYo+gh8mmXgyewqjpEYKjEU4u9BUNV1URtd+BPUjtI41jV?=
 =?us-ascii?Q?q5THQrsEIOAe33STIegNW5YER5u5/gCvofrIBZpgBKj4Sdfa2NejSAU0XydL?=
 =?us-ascii?Q?V2Wpg4RzdRMcybcHPuLF/9cQoE922NupyXnpAyZgwVuYU7veUYJ5Id2Q+tso?=
 =?us-ascii?Q?R3cRvRYcwUgm0WBWM+JaubCH3dMOBN+4nSEam3tJVVSHpxcsILZ50lxAP5dI?=
 =?us-ascii?Q?UP7BgOtkCi/t8H8OAa7krzHtiGvYHc5Guq0TNpc7ir2BblVMSHNP1Hz/OkY4?=
 =?us-ascii?Q?y9T/t0AjTkov7h0bxIsvFw9OYnU14zOH9hmczZJ0aGQXrFBi5+c2dJWVxltx?=
 =?us-ascii?Q?eA9kmB53jkC0xy1jVFXTYuU70pY+gkPwJjmVICLpFscYG6Isc0S1McpX9rZj?=
 =?us-ascii?Q?ry7/tljYkQbgf6N2Z1dBvPPxYKHG5E3K6Wt5nV2378NRLF0mM85mQ/sbfRLN?=
 =?us-ascii?Q?Qr9pD9+sFuPrUHLV19IRP+YxsK8AuxRM/zIB45/3whlHfjF1i0lTxxmBc+mU?=
 =?us-ascii?Q?V4D55/S1w7OYsQJGrmUz4brCTmM+UWOe8ed0w9oTvPlliRwR5xji0lq20BTa?=
 =?us-ascii?Q?d/dvkmuufRFC7EsLLNJ025h7NoGGzE7FKqUrurn05R1erzirMUWDy8n+j+X0?=
 =?us-ascii?Q?6TLcFuGEzg3h2plyXQ1FkkcPBSWOpttloAGoJOEhJpt6W9q2GD2E5TGRYP24?=
 =?us-ascii?Q?YsPjeS6j+CJoksD1qUiBk7pzvuhoNTWCVPGLOHVhmjCBVKHrn6lJQVSuF7rq?=
 =?us-ascii?Q?K8Zisjb6BsuoKd4PHolaIvLW4xpjq5fheI3mWUl9I5QVtDrg37iShClDERS0?=
 =?us-ascii?Q?tOETahrPBZ2WWJylB1LE8tm0r+BR+ONP/KRIO4sD2/Xj9BRJrld5OSQm7+/n?=
 =?us-ascii?Q?SPfMN1sMr7YovU+i/YsB6WP9Uh+XINQsXML+Z1PkxGjLK6qKTPwmRJ+YDHJ8?=
 =?us-ascii?Q?SKk8T3EB24aUqjyNb3i+EiJgT228NNuYBB75jqk1nYHBoZiRDE/jJEixhgCZ?=
 =?us-ascii?Q?ieZ+DNIN0e7iwMkeiyLprSvnDwZ+JKjUkfm2REdZ9q9iYg+h+YvpIM1nO5d5?=
 =?us-ascii?Q?2xrm/6B7ynKQ+ErKRtI1OCoJVe8AiZY5DcIjzSySkIHUSurZEHr1tKbS5uD1?=
 =?us-ascii?Q?otWTkiv73nGZ3SUFEkojP/DTFL0IYQ55YHb2T6/PoN+5FH5b67EE4XBYDZtJ?=
 =?us-ascii?Q?YbqOw6OVWpp6tkv6fgI5HrJIfZqPRhsiAx0gzfJIZcl3S+JBkLATusOVimIx?=
 =?us-ascii?Q?Jp8P0GYlri1un+VuBEaK7lJRsJnwQdx1YiPInbSQ6gMpqH6tAQHzmHykDW3S?=
 =?us-ascii?Q?JRwcKDxgrw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH8PR21MB4716.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca993c26-8f23-45dd-7b94-08df0552ffee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 22:23:34.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3HQyfHQY/Sb7Bh+uYTOJsDbxqba3SzvHcWD0t34hRVcr5+Ilveu3ILKFrX8U7HBS4jiK7XffukTA2XtVeqgvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR21MB4652



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Friday, August 28, 2026 5:23 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH net-next] hv_netvsc: Advertise the SR-IOV capability for
> CoCo VMs
>=20
> This basically reverts the Feb 2021 change:
> commit 96854bbda24f ("hv_netvsc: Restrict configurations on isolated
> guests")
>=20
> In Feb 2021, PCI device assignment for CoCo VMs on Hyper-V was not
> supported: if the host offered a PCI VF NIC device to the VM, the VM
> couldn't handle it properly, so the 2021 commit was made to tell the host
> "I'm unable to handle SR-IOV NICs, so please don't offer a VF to me".
> If the host offers a VF NIC to the VM anyway, the change to
> netvsc_receive_inband() ignores the VF NIC.
>=20
> Since Mar 2023, the VM is able to support PCI device assignment due to
> commit 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in
> Confidential VMs")
> and related commits, so hv_netvsc can functionally work with a VF NIC, bu=
t
> we haven't advertised the SR-IOV capability because the MANA NIC driver
> (drivers/net/ethernet/microsoft/mana/) hadn't been hardened, so a
> malicious MANA NIC might be able to attack the VM.
>=20
> Recently, we have finished hardening the MANA driver, so we can safely
> use the MANA NIC in a CoCo VM now. Note: currently the MANA driver in a
> CoCo VM still uses bounce buffering (i.e. shared decrypted memory)
> for DMA. In the future, it will be able to use private encrypted
> memory for DMA with the help of TDISP.
>=20
> Now, advertises the SR-IOV capability for CoCo VMs.
>=20
> Note: for MANA to work properly for CoCo VMs, the following earlier
> commits are also required:
> commit 2e2a83b4998a ("net: mana: Validate the packet length reported by
> the NIC")
> commit c72a0f09c57f ("net: mana: Sync page pool RX frags for CPU")
>=20
> Note: the host might offer a VF NIC device that's not MANA -- in that
> case, if the corresponding VF NIC driver isn't hardened for CoCo VMs,
> the driver should be blacklisted in CoCo VMs.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

