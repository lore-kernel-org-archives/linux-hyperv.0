Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021126.outbound.protection.outlook.com [52.101.62.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE892F3C10
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731472; cv=fail; b=fG9wwcNZI5OZJuDZQEaBlthGHaefMs3jpZ2ziiighN4XMk5nCywia9J1gcwOv3o45n/eAMsJ2fu1VZdPzvhyewfRXd/S4uvTQl0md3K4MWwdkftpnx70dpla1uLIuEUEKSa9Bg2ey+5bV3ofuGoLhIkLxdgn4BoW5u1rwRel2dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731472; c=relaxed/simple;
	bh=snvBMrxz/EMz0l2mXOwJDrcEEiveqkl0EmadTnKkbAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nb3uRga+6dYCN4n4Leno5pvqIvdUEqPAp3tyjZBXMbi8XufEMbjcBZWcwNuJbD4Sjg39th4b99TpdQhnMeAx/OvAzdf0PTMM8GfvnyAUKeNO/HQQcNmfzpF+xShAszZhS16Vo09wV3QPlxFV6lp1UieqwywIaPNVEvY7EYd3HA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jtmClD5v; arc=fail smtp.client-ip=52.101.62.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jtmClD5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDnyMWa5DIyJ3hV6c+qu4yPJHeDScPSPyTW/jfD5v5DUW8hPc5OImFiQ/GrALsXriJQ+4/jLzNDZjBw4fKtcETib31CfkMW6hy52tm/Az8RU9ztN4iwP5fmMb9FoHvc3oRX3ZHDmq7CqECAJ1d3QRKE3FGVk4gLfV55BbFOkWocRqfCCraJdI/pgjvz0WVjdbL7WPWi91jdwR8Y4c89LXyScBv2JTZg3Fny06oR4iVxmHH1S6eI1NRg/xL36Y92Pz8dI+tpf7uV62aJN/kDJj+MDTS7LufziYYmoTOofvJbAwr83kEz3Z8rFR+XhDg1CCslpzdRMUd+lIYvb+0AAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqLAnwgRJ1JuYmn1SBf2X5p2HjI7jFeJtfD2Dwpzll8=;
 b=ievG89xmeUNvSFFcBqFAf91Waq1NYH5Vw/7ZN9ya9sGrG66Oby86AuRRZsmhW3E+xGqObG2XNUd4nh6hgms/NM27cMQP1eGIjPp3CD8CuL3ZlWfUkFE4OxmTFtWo7qfuFzxW9t1B0LZmZd8bDWV4CwrCgcwIvFUEqthbAVTwd9T8+JXOiHk8ke0r/FxwiPB2ghiKpSjOQkPJa1ScIRE0Bpwyqnjt2yeKwndVSe0U/yMA429jjASJTUfk2KlrdDg+yFbtr4r4QCvC03Wj6zm7RDnX2dUWFCT3vhtfqjzg9wDwwTnXDooj2UbkO1/Cz4BtquyEopPDS42VaozMLcFsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqLAnwgRJ1JuYmn1SBf2X5p2HjI7jFeJtfD2Dwpzll8=;
 b=jtmClD5vul9cOSDSUSRYv3ygz7UdJvGLV2XhxDzqUuTJUbMelDONDR8nkE+LgschgK+J5MakyZAuLIyvWOQqA/DDcbRaOKRCvzEvQdVSRlj/Zquk5gUP/iChNKwqEQo02RH8tYhnE0mUEZ8XV32imEoOq/1WkgEW8+MjneoH0N0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB2049.namprd21.prod.outlook.com (2603:10b6:806:1b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.2; Fri, 14 Aug
 2026 18:17:47 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 18:17:46 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 01/13] net: mana: add queue-set
 allocation and teardown helpers
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 01/13] net: mana: add
 queue-set allocation and teardown helpers
Thread-Index: AQHdKuFKuk5ZIKVHHUKWUIwuPzLfzLac/z0AgADdK+A=
Date: Fri, 14 Aug 2026 18:17:46 +0000
Message-ID:
 <SA1PR21MB66837CDCF8E35CADA976DAF3CEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-2-longli@microsoft.com>
 <20260814050519.2B8851F000E9@smtp.kernel.org>
In-Reply-To: <20260814050519.2B8851F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6e284c98-53ce-4514-9616-d78eceb93747;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T18:16:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB2049:EE_
x-ms-office365-filtering-correlation-id: e5b0de14-c1a0-4194-32e1-08defa3057a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|6133799003|7146999003|4143699003|10067099003;
x-microsoft-antispam-message-info:
 J/e2EDlPBuC3Nkis5hmqWeSxbzHBy98ucCL8Af9kA2ibZgv369mKN1O4in6GApox0+FehUwnvd1wVI1Y+Pw1rTNQ//E8lnceuJ9TVQucub0p7D8O3iX297ZSiZyIE3dBDwNBtX6bA7424p5ppuD1GQlpDgL9WXj/0ijlkS2UwkQlSdpsZnvQpg/WIhNAfehG8Ft59wUDTMVrLuCS2HDhtEPniaWDuWanyF9QFSzez/L7Fxuc4yz0HbtPFeDC8mgvvwVIeafVey16uyU52Xs01nEtIoANV0mL/Mcy2THWSdM9Iqra+vUZ4Dd+Awht31MD2ZHBiFmB1o3GEE/sH3XapFQx3oBUu0y8KJNs0CdLFmHNOd4gXdMtOvpUL0LMOdCJXiWpmPSkol7FiqeSX4tZY3Az8PKYVfl1IIgVYt3RKt3gjk+TnTrf8WCFkLbIZNxosU6ndzCy8oesGsQeY2puMzYLiMm41WARRcyKysEk6kaKAA0RcEcSiIUbBxFF4Po/WayuhA4YNakAic5/yHvjg5/AQwua97WFa/szkYj9klSnQWwpQ/bnmKAM7bB2i180encWau5bQ4S4hQQb5q2DojOT76+UAkChREXRh1CMpvNkxE7alISMDh4v3QC1Y2KQdbM42r+7QQVbOWiY6zNRM/WyxpdKXaSmktrd37GBk4Y3rERk+AJz79LqbA7oxuMr9eMfYH3NmoqQEUEDstt6r8HverZGeUuQ68w8QXxbaPU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(6133799003)(7146999003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ufYn4YnZVqgrZP/llsjdwcfxYlM9E4HctdtYlCFJ+iHRR1CKhhK/iUgwcW1Z?=
 =?us-ascii?Q?NJXsq24JN2XgWQFjfhN1qR99IYyHJ0t7nbg69K41jf6HuzLtmY8875NFKJq4?=
 =?us-ascii?Q?f3ZnpQxvoXfChQ3ExdeARhDXT0ifi7vHvco9e7wDQsyT5Y0PGKxaWM6UW8+i?=
 =?us-ascii?Q?MOXQ5Ty5HXPPVww7GuAk5kbkaEAJEB4zDEvofBmLfhqKVikHlLDfNfBbhPzq?=
 =?us-ascii?Q?FETsg++adeBHteAnViUu4Qj9z9ofTTeJsEAzvqs7KUJ4scrPAxjk+qvW26p7?=
 =?us-ascii?Q?+sgjV1A/2wnR7KpMej2+f1KGVmapUqbuiUPHbL/NEuPcPMADGLbr7jQdt2ja?=
 =?us-ascii?Q?jaExR4BZAPnPzj2LM2+HVqDiAPqk+3hsYKi+6/eWjED0G4WR3z29RXF6gv4m?=
 =?us-ascii?Q?lb3vFF0SsMGgScH+8oRQebDDRqXWdVAo5msJkkysSHsD5l5xBaQc+gpcce2E?=
 =?us-ascii?Q?8ZHvXlG8VqLOGHKzzSaPJIM9powNIVXCrmF8DPzCahr8b+dgwqQ7ot/RFGmE?=
 =?us-ascii?Q?2v7amJhAoGHF4gOnzv6a/ydtAsUW2rJkZggpigy0hBfsT8WoETN2tVKU8LvM?=
 =?us-ascii?Q?qhOxs8dtcD4Ro3LUUvRkKaVcGSYWoct7cUQieT11P1gIv94Z7NihZNYVszIx?=
 =?us-ascii?Q?bw0teuoiLCLY3UDgjiE0HvQHMUYX39vmT6w+eZZ1b8VClQyzHOY8HrwtPXQ/?=
 =?us-ascii?Q?Nr1DFVwPgSPDHCWIh5Y0+iTo6EQhITQGZoyhav8I+6BHVQut3CwR0v4/zf5T?=
 =?us-ascii?Q?gnyvo9ZdDyei/oTtEMj4zJ6JyqnnJeoCR4HdMMP/ZRxUQ8GhwSNG87YkSEQI?=
 =?us-ascii?Q?yEbhjiwk2IBgB1I3Je3GydjPL70Asq9/YeHAAoZ3xZgXet/O8LFs4l70tFrn?=
 =?us-ascii?Q?YhP2Y5SXlo5CTbn2S/68bBh8iDRzZixTWkIKXQ54+jjNO0hyQssb0eHuB9Q2?=
 =?us-ascii?Q?HuKeC3j9iszNXoe05Og8wRznXrdCyhSepS9YpHJs4gkHRXnCxMclHVRzQnkg?=
 =?us-ascii?Q?1x3axpYi5sUqn06bz+k/BNZpCjO3mnFWUi3QLX9AQUwqPZywmvuwzj2jDzw7?=
 =?us-ascii?Q?d360gEU7Eqdqmx/D3W58ZKCnn3xgMMc8QLVL8P+j4Fi8p2ZYo8xl4bpL7bk4?=
 =?us-ascii?Q?m0T/LkbT4gWU48DrYT86zpM4U7twZkZ/NbQ3/j4ZOUtvangxjEoRMlk3AGn9?=
 =?us-ascii?Q?eEoWQgWwvxI7aDfr+Y13Zi0Y/+ufJb4QO9B3sZTW+y7WCCLKV0QRlsDFSY4F?=
 =?us-ascii?Q?NQedzmKR+zqsunoPpkVifA+n//vnklYAb0cadw5fQw/Th6soZef45a+rf1lr?=
 =?us-ascii?Q?7cI9Nmzq6gvObqmOZWNhqKdCED05mWS+YFtPTCtGWwVMIO7L2awHML+VESGI?=
 =?us-ascii?Q?HaL422wcWSr7NFSrvA5KqwqVls8Ez19x2Rc1iQooiaDFQDu26NAaNbI/reDY?=
 =?us-ascii?Q?0QL4hhJgQI+w91OrJ4Hzlurj1x8DQ/6RUMGcqkRvZkyeWMl+XZXb/SOdbnre?=
 =?us-ascii?Q?TddDRnJeeigAfO06ySyKswxOKCemUtLCnSZzxeSOszp+P8EpMtTSfRHZPtYF?=
 =?us-ascii?Q?r6kVbrVWJGGQOTko0cuvp69rDFR4+b1K4jiwokjuyHWRKlIQuZFaP22+5eP0?=
 =?us-ascii?Q?Ip+w7Dpi0ngYv8brIc3Qal6GSleGJ+ZOCyCsh958aLm1CdUK5eFniDD/Vxyg?=
 =?us-ascii?Q?pSG86Hsaivu359tvfUWnYh5Q4VeIKvv7FIQLD+cFDrb/oRZW?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b0de14-c1a0-4194-32e1-08defa3057a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 18:17:46.8273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9s5dFPv5w5mAvmerHZZZYan8cAt2YnXLxW1M30RWVC8m8ngAftqVwM9OGPUeYhNZvBqFX4NuzFGswguC/81DDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2049

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [Medium] User-configured RSS indirection table is silently discarded an=
d
> reset to defaults during per-queue reconfigurations.
> --
>=20
> --- Patch [1]: [PATCH net-next v2 01/13] net: mana: add queue-set allocat=
ion
> and teardown helpers --- commit
> fcc6a74602d4e66dc287809434c5e9b44c3be829
> Author: Long Li <longli@microsoft.com>
> Subject: net: mana: add queue-set allocation and teardown helpers
>=20
> The ethtool reconfiguration paths (channel count, ring size, private flag=
s),
> mana_change_mtu() and mana_xdp_set() rebuild the queues with
> mana_detach() then mana_attach(). This adds the data model and helpers
> for pre-allocate and swap to independently build and tear down a queue se=
t.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> [ ... ]
> > +int mana_alloc_qset(struct mana_port_context *scratch, unsigned int
> num_queues,
> > +		    unsigned int rx_queue_size, unsigned int tx_queue_size,
> > +		    u32 priv_flags, struct mana_qset *out) {
> > +	struct net_device *ndev =3D scratch->ndev;
> > +	int err;
> [ ... ]
> > +	err =3D mana_rss_table_alloc(scratch);
> > +	if (err)
> > +		goto cleanup_rxq_array;
> > +
> > +	err =3D mana_create_eq(scratch);
> > +	if (err)
> > +		goto cleanup_rss;
> > +
> > +	err =3D mana_create_txq(scratch, ndev);
> > +	if (err)
> > +		goto cleanup_eq;
> > +
> > +	err =3D mana_add_rx_queues(scratch, ndev);
> > +	if (err)
> > +		goto cleanup_rxq;
> > +
> > +	mana_rss_table_init(scratch);
>=20
> [Severity: Medium]
> Will this unconditionally reset the RSS indirection table to defaults dur=
ing
> reconfigurations?
>=20
> Since mana_rss_table_alloc() creates a new table and mana_rss_table_init(=
)
> initializes it to default round-robin values, it seems like a user's exis=
ting
> custom RSS steering configuration might be silently overwritten when the =
new
> queue set is published.
>=20
> Could this cause a regression where the custom configuration is lost? Sho=
uld
> it be preserved by copying the existing table from the active port contex=
t
> instead?

patch 11/13 fixed this.

Long

