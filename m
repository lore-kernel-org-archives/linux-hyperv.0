Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023094.outbound.protection.outlook.com [40.93.196.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D97F503BCB
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809627; cv=fail; b=p7WSDYjv9kg/EmuAD6ae3B0won/B3TGNomUzPM2OaW+i05guwrexXS4baKESb/377T8rSqrLZSF1xZhyaqQzp+WKQOpJuIpWy5tbea/NXTSSdi93AQfzgYuS0B5GWwhBquHa8/gV0QFSyn0zAoJv+WHAw8/NRj3BLbGI7YEDZKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809627; c=relaxed/simple;
	bh=91cHSu6zakWq/GgJunzzWhWbv9zYIOtUStQUDOSDk28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLk32yRHFYRxFU7O1tDn1CTB2YauC8tTRnVHwMMtvI7p3JN7Fi766CeIIj1XR4Yi755D2jM+LD2LhRUFj1wPwCSw7opZQTvGMWJrnJSV485ZUnoKoT9NvmgW7/19xN3G9+xCVUV5W4/GIrmDJt5SbvCCXzmxDOcQbopnXLnzRNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hBr6+KVt; arc=fail smtp.client-ip=40.93.196.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hBr6+KVt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6WQLIxSM4KWy1F0McgAWP9RChxYlUQ7i2NKhVA5PUYKPzsrT4Wt8GNigo3sYfWr9aqEBLaOp/USXEbKTWVURy54MoChmpLsgLSStF4nYkJysWJa4QfDlFqIwRKjAF/tmF0I9Mp6S8pPw0DVGUEnPxiMLxiGdAbkJS8PiwfGtI5A4lShTtry++T7Yvw9yza/ubK+ms3wB3EbUcVsKPJqke2kldhFXa154BHgdmaANngkTxud7Ft4R5hIr57DRKxcB5FguyG+JMij0EnkNry6WMq7Y2xwiyszYVeZO7NF65pGrflyj0AK0jIpatUB9PRiu2dPduwecaMiottXhmf7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht+4gm2dvAFK/vqHWVRmy7HxqsFt3fYYIW0O9jmU+MU=;
 b=OzGKlPpz91Bbhl3W1kFGF2jvB5wUzHl0nlRZ1jMA4m4DgCvYXR29q0k5S1jjU6smt9wrx7cnuQrZhPgx/4bmlLaSh036eFtWEm9CaGzJPKWp1RDXFo44PD2gafgl5SXofTXnhSGj0okoDAyqgENWy0fQVjh3fwSaNrKZJfmbNcoPuTk79/NOPouScfDKZfuU0JC2sFotaLX35pWh4t3kBYiZl+lzfZ11sk8QNVek60/czgRTvItTVAEg/OZUTS3ivKZWAOS3dhQM6DrIvDHcxPVeKhIeIJ8RR1fKa5733S5VaPGZzm3yUgbSXNRv4sevxZxB1mduZuVFEBuvYDEi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht+4gm2dvAFK/vqHWVRmy7HxqsFt3fYYIW0O9jmU+MU=;
 b=hBr6+KVtrcS5fE8m+N3MwZ8zC3/RWQEunl4h8iqmanqkFt35rub1Difw1OpzqtO68pO3TRd+3p8uhyNqx2SMaG8PudAgJwxU46++xdT9sQMFJxH4c8rmuSlf612bh4j6tZJ+SJK/lro3AHSBRq7ct2n0HiGCPhRvb8TrM+0ixho=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6754.namprd21.prod.outlook.com (2603:10b6:806:4af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Mon, 7 Sep 2026
 19:33:42 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Mon, 7 Sep 2026
 19:33:42 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] net: mana: do not discard an
 ethtool-configured RSS table on a queue rebuild
Thread-Topic: [EXTERNAL] Re: [PATCH net] net: mana: do not discard an
 ethtool-configured RSS table on a queue rebuild
Thread-Index: AQHdPM/AFo/mFPjv3kSEyv8Y/PH4f7bAuDQAgALKFkA=
Date: Mon, 7 Sep 2026 19:33:41 +0000
Message-ID:
 <SA1PR21MB66836B14742F73D2DB9A4E5ACEB22@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260905004401.3937066-1-longli@microsoft.com>
 <20260906004447.3B1DB1F00A3A@smtp.kernel.org>
In-Reply-To: <20260906004447.3B1DB1F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4b6e854-4831-4a71-8c94-db410cf106d4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-07T19:20:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6754:EE_
x-ms-office365-filtering-correlation-id: 6f0ff430-3af5-41f4-534b-08df0d16ec85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|3023799007|4133799003|38070700021|10067099003|56012099006|7146999003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 SCRXDNqRsBRaJ39wdWD3C09il8hbUyTqNPieJbtkxu19elTAWc8siNHXcx7dHL4j20EX15v23LvG1UgffQSGzJSyEWbASRedMYPOIpceSXt7sbLbaXRWoZ9zObfOWkpDgybLaDjQj+ksEKnMFaGAIM0gVY6g9cqopzp7txC9/uLmjduKtd0GixUW3J12hC0CrAIjdumUx3bma1J2u2JUyZMnr+E4maBNjYWfrj2U9oEKtKP9am/ko8LmoU0Bo9AWZcEXAkt3zh4x7nhJkCzrtcE7StCndMj7tI2C/R5vrTudtF4Q6H70IY7Med2luuTPBj0elv5CgEPKChN0fL23b2dHXD2NIacX9vl7hGnjeuR6FuRQGHtsUFOMUb6RfjhQ28ABgGkj32FUbCFBZeeDZvW9Fmxu/XNapYDNK6GfsGxWHC9Fxql41aSHm+gi1tuR1Kv4qnXHYBod5m+DAZWa8jEojzMb541PToag8Nu5xAtdPruD5i6E+SCRrxm4E4bu4MLZckPO82AI+s+2OgzFNa97OCRD52Szj9CERau5+J7FgPGQhm6Vi/pIWKoPXfCyqr61ILBD4jrvHe0bjJQ7FGNh66wrdeOC3k4uLvV/PmG9eRfP+rL5VlqQpWP1pZCNSnICT2MYb4mQILmMrsdGiWajudAPS9+lHkWSz9gVa6g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(3023799007)(4133799003)(38070700021)(10067099003)(56012099006)(7146999003)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/1IJ3OEoGMhWS7OyBFxdiaUcbArPjPO3OE0SXs4EpvzngUYqanRGudCUjZU2?=
 =?us-ascii?Q?vccr1e0GQpK8vvsW9V9D00//5A58ek6s6A3SXyqja6Jjh/jaM1d3583H5ADi?=
 =?us-ascii?Q?7MIja/9XS5SmDdlakQxnTvsbuvjqSjt7lprjTGkhEK+eN7dWPZIpP4rorv6M?=
 =?us-ascii?Q?LVGLy7sEObx3C1n14uKkqzZjFFEsTtM5r00djZh042dZDu4br2pd7NCpzNGc?=
 =?us-ascii?Q?NMX7LXn692Y0vbZHzXeJW3Fqg02tqPqqQvF8BxJSibpa/NRP4efINzkFTsaE?=
 =?us-ascii?Q?RAPmZWW4EmgqOf2VppwwEQVRFa9qJWIJydsUiyHZBhJaQObJcUB5GWUAIec6?=
 =?us-ascii?Q?wfdmiL6DZmtuVjp56/wikmM7eINEGWGuW2P+vTfIRkrx95C+wm+Z1p1MQuE0?=
 =?us-ascii?Q?LM78CxPYn08Nv7z+/t9IcAEsRDXnQ3pwyVV2qocl2l8qhRPS/9iBrM7Jzkta?=
 =?us-ascii?Q?ZY1i7pxUvknDMlD4/12dHS5O0zs2jgthFIkdCp8qPr7ye/VsIQuPmgKHJHuC?=
 =?us-ascii?Q?dgeFeoUplz3LTvzFx2CJ4WxYoxH9L4Y+rZ0HYe8mRsTM7pczt6RxO/L2ICJq?=
 =?us-ascii?Q?k3gS/a/mboaUwcJgXqh/trxyrXM9JqUfpKdxfiR3HYwfBWwMmrG8+fXXug7n?=
 =?us-ascii?Q?JxM3XJkyMcZDhihjEwvWSfZwDZLOnO90QrEReyM7VXciixnLLX2uNXFD28rI?=
 =?us-ascii?Q?Qajc6kDWI4gfqCe+QZUfYDRhn627Haim85+Hio+j+MEjug+g4otItZpgd70r?=
 =?us-ascii?Q?fYx/0W+4dNCXTjEpU1t9BudkzG70zwa8zWdj5Jt3jRRc7e1r3HymFJ6d2Z+w?=
 =?us-ascii?Q?xXiXLiEiyaCLeLY7Su+7IAubu/OPrfXDIw07gUAoz+L96owHyL3AYKjJ/7sx?=
 =?us-ascii?Q?JufpzXBfi3v0NEQ5m327PVoRx5x7tBaUtrLWavIfwwQsLUBa3Nz5XgFzrEhT?=
 =?us-ascii?Q?l8LprTaG1GyP2nDjZOY+t6sI1K0pFH8Kh5ShMPn9IgJ4p7TCRaCQm9kCZpVf?=
 =?us-ascii?Q?dga6aVJbNS/YCyGqe/iYk0KiJ6U3V2UPmRW9z+XMd3rbjwv3PMsVtZ2iCxnB?=
 =?us-ascii?Q?cj/uREI4IoSTzSDc+Tp4IkSttXDz/miFXzcvIzK7ULuwlHDgRsVisTdAxwAM?=
 =?us-ascii?Q?dLflZFd1xa3tIynt/B3wjTimW1uOfpSQOQuItanh5NYTHRE+9A7CmSU7s7X0?=
 =?us-ascii?Q?L1UlZlFEog7Dlt5LC2OpdFYMxnFRq2zezUeTxCgEXSGn7I3ZKkFoI96/qXod?=
 =?us-ascii?Q?JtqdzjZaX0G6JM/ZdVCNSa4flcNPoCLMq4dW0aWSRgPsOBuvlhsHCspStJ1d?=
 =?us-ascii?Q?QLlWskJ2SH8rZB/AhP12cWr1vVaFPuq2jiqhMOY3SrrqnbNtIlmDeiuV3OZ1?=
 =?us-ascii?Q?1mTI4m8sJGmdaL9GPeiFoYts1g4wQbZAJeUKvAf4uc7yMdyZiRJVPqbVfZSb?=
 =?us-ascii?Q?FdBm3VKYIwXGAeNBE9kgFXVpmWSeFfg/0CqJ4/Uv5z4xIPHFaLyeaf6j1cTE?=
 =?us-ascii?Q?QjGt72/+BdBF8Ngp8o2EKiBSKtorkzLT6Cfrrp1UR/kUb3/WR7aUdfFMUOUb?=
 =?us-ascii?Q?ppa+Wtcv7IgXNvScSAYYyhBghWaAEY62srLXtc4ovctv2GmOQMs0iOxvTdUK?=
 =?us-ascii?Q?zeIqHrUiAZcOTR3yOxntXDMGrP1I7EWqxbVVE6IIA7ZE8+94M/L+LzNGaksg?=
 =?us-ascii?Q?SyC96YoaxKEg0oMVjGqt8Mtff4DJ1Sb/4j308Ly5iGSXrGg+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0ff430-3af5-41f4-534b-08df0d16ec85
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 19:33:41.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zgl1P0BbdkQaeJQuo3iTKOeT56PiOWw/9CQh7cuPVMyY3grzq4iF24Oesfu7eM7bjZU2YOi2YXMW4nIxGoLtrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6754



> -----Original Message-----
> From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
> Sent: Saturday, September 5, 2026 5:45 PM
> To: Long Li <longli@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net] net: mana: do not discard an ethtool-
> configured RSS table on a queue rebuild
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s)
> to consider:
>=20
> New issues:
> - [High] State desynchronization causes newly added queues to be left
> unutilized after a sequence of channel count changes.
>=20
> Pre-existing issues:
> - [Critical] Pre-existing Use-After-Free in stats collection due to ad-ho=
c
> synchronization flag.
> --
>=20
> commit dc8331f7b2434de9035275921f9768699946cdcb
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: do not discard an ethtool-configured RSS table on a queue
> rebuild
>=20
> mana_alloc_queues() regenerates the RSS indirection table from the driver
> default every time the queues are built, so a table installed with "ethto=
ol -X"
> is silently replaced by any operation that rebuilds them.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 7a1ac853e3abc..97386e17b9421 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -3306,6 +3306,28 @@ static void mana_rss_table_init(struct
> mana_port_context *apc)
> >  			ethtool_rxfh_indir_default(i, apc->num_queues);  }
> >
> > +/* Whether the current indirection table can be kept for
> > +apc->num_queues,
> > + * rather than rebuilt from the driver default.
> > + *
> > + * Only a user table ("ethtool -X") is worth keeping; a
> > +driver-generated one
> > + * is rebuilt so that it spreads over every queue. An entry pointing
> > +past the
> > + * last queue cannot be kept: mana_config_rss() uses these entries to
> > +index
> > + * apc->rxqs[], which holds apc->num_queues pointers.
> > + */
> > +static bool mana_rss_table_keep(struct mana_port_context *apc) {
> > +	u32 i;
> > +
> > +	if (!netif_is_rxfh_configured(apc->ndev))
> > +		return false;
> > +
> > +	for (i =3D 0; i < apc->indir_table_sz; i++)
> > +		if (apc->indir_table[i] >=3D apc->num_queues)
> > +			return false;
> > +
> > +	return true;
> > +}
>=20
> [Severity: High]
> Does this check wrongly trust netif_is_rxfh_configured() without validati=
ng if
> the table was previously replaced by a driver fallback?
>=20
> If a user sets a custom RSS table via ethtool -X and then reduces the cha=
nnel
> count, mana_alloc_queues() detects the user table indices are out of boun=
ds
> and generates a narrow driver-default table, but intentionally avoids not=
ifying
> the core via ethtool_rxfh_indir_lost(). The core's
> netif_is_rxfh_configured() remains true.
>=20
> When the user subsequently increases the channel count, could this functi=
on
> incorrectly believe the narrow driver-generated fallback table is still a=
 user-
> configured table? Since its bounds fit the new queue count, it seems this
> might permanently freeze the table at the smaller size.

The two steps are mutually exclusive, so the sequence cannot occur.

The premise is that a channel reduction can strand a user table. It cannot:
both ethtool entry points call ethtool_check_max_channel() (channels.c and
ioctl.c), which refuses the request. On this hardware:

  # ethtool -X ens1 equal 16
  # ethtool -L ens1 combined 4
  netlink error: requested channel counts are too low for existing
  indirection table (15)

Note ethtool_get_max_rxfh_channel() derives that bound by calling
ops->get_rxfh(), i.e. the table the driver currently reports, so the guard
follows whatever mana last installed rather than a remembered user table.
mana_set_rxfh() also rejects any entry >=3D apc->num_queues, so a user tabl=
e
is never out of range when it is installed.

That leaves exactly one way for mana_rss_table_keep() to return false: the
clamp in mana_init_port(), where the device reports fewer queues after a
reset or resume. But that clamp is

        if (apc->num_queues > apc->max_queues)
                apc->num_queues =3D apc->max_queues;

so num_queues ends up equal to max_queues, and max_queues only ever shrinks=
 -
both assignments in mana_init_port() are guarded by "if (apc->max_queues >
...)", and the only initialisation is in mana_probe_port(), which does not =
run
on resume. A subsequent increase would need new_count > max_combined =3D=3D
apc->max_queues, which the core rejects with "requested channel count excee=
ds
maximum".

So the fallback and the later increase cannot both happen to one port.

On the wider point of not calling ethtool_rxfh_indir_lost(): 16 drivers tes=
t
netif_is_rxfh_configured(), and two call ethtool_rxfh_indir_lost() - bnxt
(__bnxt_reserve_rings(), when firmware grants fewer rings than asked) and
mlx5e (mlx5e_attach_netdev(), when max_nch drops). The other fourteen, amon=
g
them ice, idpf, hns3, fbnic, gve and nfp, keep a user table when one is set=
,
regenerate the default otherwise, and do not notify the core. This patch
follows that majority.

mana cannot follow bnxt or mlx5e here even if it wanted to. All three drive=
rs
require the netdev instance lock for the notification, since it sends
ETHTOOL_MSG_RSS_NTF; mlx5e says so at the rtnl_lock()/netdev_lock() pair in
mlx5e_attach_netdev(). The difference is the call sites, not the capability=
.
bnxt reaches its call only with dev->lock held, and mlx5e keys off
reg_state =3D=3D NETREG_REGISTERED. mana_alloc_queues() is reached from ndo=
_open
with dev->lock held and from mana_attach() on the reset and resume paths
without it, and the netdev is registered in both cases, so neither taking t=
he
lock nor testing reg_state works. Making mana notify would mean holding
netdev_lock across mana_attach() in the TX-timeout handler and the resume
loop, which is not something I would put in a fix for net.


>=20
> > +
> >  int mana_disable_vport_rx(struct mana_port_context *apc)  {
> >  	return mana_cfg_vport_steering(apc, TRI_STATE_FALSE, false, false,
> > @@ -3621,7 +3643,20 @@ int mana_alloc_queues(struct net_device
> *ndev)
> >  		goto destroy_rxq;
> >  	}
> >
> > -	mana_rss_table_init(apc);
> > +	/* Keep a user-configured table across the rebuild: its entries are
> > +	 * queue indices and stay meaningful while they are all still in rang=
e.
> > +	 * Only a driver-generated table is regenerated here.
> > +	 *
> > +	 * A table that cannot be kept is replaced by the default without
> > +	 * telling the core, which keeps reporting the table as user
> > +	 * configured. That is what this function did for every table before,
> > +	 * and reporting it here is not an option: ethtool_rxfh_indir_lost()
> > +	 * sends ETHTOOL_MSG_RSS_NTF, which requires the netdev instance
> lock,
> > +	 * and this runs both with that lock held (ndo_open) and without it
> > +	 * (mana_attach() from the reset and resume paths).
> > +	 */
> > +	if (!mana_rss_table_keep(apc))
> > +		mana_rss_table_init(apc);
>=20
> [Severity: High]
> If mana_rss_table_keep() incorrectly returns true due to the
> desynchronization described above, does it skip the table regeneration an=
d
> leave newly added queues unutilized?

Yes, that consequence would follow - it is the same branch. But the
antecedent cannot hold, for the reasons in my reply to the first half: the
fallback and a later increase cannot both happen to one port.

Worth separating the two cases, though, because the symptom you describe is
also the intended behaviour here. When a real user table is carried across =
an
increase, the added queues do stay unsteered:

  # ethtool -X ens1 equal 2
  # ethtool -L ens1 combined 16      /* queues 2..15 get no traffic */

That is deliberate. The alternative is to silently discard a table the user
asked for, which is what this patch exists to stop, and it is what ice
(ice_set_channels()), idpf, hns3, fbnic and the rest do as well. The user
recovers with another ethtool -X, and "ethtool -x" always shows the table
actually in use.

So unsteered queues after a grow are not a bug signature by themselves. The
bug would be reaching that state with a table the user never asked for, and
that needs the desync, which cannot occur.

In summary, this patch behavior is consistent with other drivers on this sc=
enario.


>=20
> [ ... ]
>=20
> [Severity: Critical]
> This is a pre-existing issue, but is there a Use-After-Free in the stats =
collection
> due to the ad-hoc port_is_up synchronization flag?
>=20
> Looking at mana_get_stats64(), the reader path relies on the ad-hoc
> port_is_up flag and dereferences the queue structure, but can be preempte=
d
> before accessing it:
>=20
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_get_stats64() {
> 	if (!apc->port_is_up)
> 		return;
> ...
> 	for (q =3D 0; q < num_queues; q++) {
> 		rx_stats =3D &apc->rxqs[q]->stats;
> ...
> }
>=20
> Concurrently, a teardown path clears the flag and proceeds to free the
> underlying memory structures without waiting for concurrent readers:
>=20
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_detach() {
> 	apc->port_st_save =3D apc->port_is_up;
> 	apc->port_is_up =3D false;
>=20
> 	/* Ensure port state updated before txq state */
> 	smp_wmb();
>=20
> 	netif_tx_disable(ndev);
>=20
> 	if (apc->port_st_save) {
> 		err =3D mana_dealloc_queues(ndev);
> ...
> }
>=20
> The memory is then synchronously freed, guaranteeing a Use-After-Free if =
a
> reader is mid-execution:
>=20
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_destroy_txq() { ...
> 		mana_deinit_txq(apc, &apc->tx_qp[i]->txq);
>=20
> 		kvfree(apc->tx_qp[i]);
> ...
> }
>=20
> Could a preempted reader accessing the freed memory lead to memory
> corruption?

This is a pre-existing issue and out of scope from this patch.

I needed, I suggest submitting another patch to fix this.



>=20
> --
> Sashiko AI
> review * https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%
> 2Fsashiko.dev%2F%23%2Fpatchset%2F20260905004401.3937066-1-
> longli%40microsoft.com%3Fpart%3D1&data=3D05%7C02%7Clongli%40microsoft.
> com%7C18ce764cb5f6435395b608df0bb00dee%7C72f988bf86f141af91ab2d7c
> d011db47%7C1%7C0%7C639242522911822221%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DIML49OomMP48q
> RaUNNmX7zbI%2BIQ31FQZH5OhErqzovQ%3D&reserved=3D0
