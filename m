Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020094.outbound.protection.outlook.com [52.101.193.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A74963B8
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732154; cv=fail; b=jDJCi80gEyPPLrRGQqfnjsQPISbsq59z1RqOjLg1BC0gmw7kt3W5XiQgAU3f/5q7OU5qy8xI+05RaTrR752CrK/i7pEktEJramKK/FKn3AsUUEhoYJKGOqY4ovuMC+bhFaRaJMsdNccd8w/Qrz8lHmbtdC1p67qYiARxCz8Apr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732154; c=relaxed/simple;
	bh=yuXbdAzxb9stsPtYX0VWZAXmDKdhPOP/uI5nafn6c5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pE2VYbrO5vzAHCMtNOJHRl6R4QApO3s4mjNPP0COxg25g7oeCuWjuVDsHfhN/iofYM1po9o0XETyEj0zV0fhYCGeGqkwjnvVRGVPbkWOjTJUZHKQ1knYdF5sRkTIjkISJDqIaNksFJGb+pQw+ON0I67MnlZiWUBqeJXG6g1JmNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AQPYK7Ae; arc=fail smtp.client-ip=52.101.193.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AQPYK7Ae"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW6kqcdRVN5Ya8Un69TzgZYk3mAP8Pc4vVseFqCrALXLvNGfj9dhYzvE+OmVUOs09R0bgHeTpTx6K0yUhdouRvQIRu43QJ1IvEWmsHqsFn8k0iidgThvqXVz3xcDHkE/s3RgVBWoU2mwxo3fEnst8FrvneEJqlttvZj1Cb20045HBBC1T9bTidJ3Vd/jM9niIP64+mAiZi6Trv7Gfq+9VifLSsY3hWfzdg0V/MWU4L3+9uVppdC4nF8eM9l1qbRTk9C3uAc5cuzUD4GMNqqjXobGf341+58WudteY/c8/BQNTGuWj67nIBPFbj81oxBsGWp+i1BayVnFOP96HAg6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKwaOvOvofXaHQd7PyV+WWBXre3m3pucX7lx2Y1PYVU=;
 b=SkMnLvDwZxzTtz28vDXbhNIEbceua3eWLMO0vcdncHXlYDnC45emWzny89c76mC/q+8ZOogalP4gf7ihhoonEl/C8fVMqjGlgBztitPN5aTxSJzC2i1CKTfiluhFBGWnmBVlSXtOm3H65cjNw50d+NoCOUJp3StmvSw0/obOOQaxciXv/swy4xxg+Do4H5UWUzH0v1DHXcLhEddj2D9Ka3dbeOsz1iCFiDpQwKci7hSpkIifeuX46Iqf0cqs3DnJBstRl4Npj/nkLUAnmOobr8PlqYW3KF6qPVIg7fpBg/HIi7kxYDEOhQyaxW/X/rK+djnm9PVzI6oz0qZIXz6GLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKwaOvOvofXaHQd7PyV+WWBXre3m3pucX7lx2Y1PYVU=;
 b=AQPYK7AeZJ479G7Bg6MI5fBbD2iel/JzAySx8jCaELPodkdV1QNU0IsJQF3VuUw56wnbN3OGbiK6qKyU9hgkBYZcF0SCTT7C7KUcaFX1lypBAtauxGeApbcnl1zu4+WX98a2wRcS4Hc1fBfkKhu7n0v8PhWXJRuqS+3b2NLE9T0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA0PR21MB2012.namprd21.prod.outlook.com (2603:10b6:806:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.6; Fri, 14 Aug
 2026 18:29:10 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 18:29:10 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 03/13] net: mana: swap queue
 sets in mana_set_ringparam
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 03/13] net: mana: swap queue
 sets in mana_set_ringparam
Thread-Index: AQHdKuFJ10DUy2OofUCJ6hc0sTQpkrac/zuAgADfwPA=
Date: Fri, 14 Aug 2026 18:29:09 +0000
Message-ID:
 <SA1PR21MB6683FA97809435E669770BE9CEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-4-longli@microsoft.com>
 <20260814050517.CAF901F00A3A@smtp.kernel.org>
In-Reply-To: <20260814050517.CAF901F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dd2021ae-ad2c-4b82-ba92-19870c5b7cfa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T18:26:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA0PR21MB2012:EE_
x-ms-office365-filtering-correlation-id: 401393a7-7b04-4fb8-343b-08defa31eece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|7146999003|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 NSSKr0zE7HvrBhak4Nuk7aJ2/kgF1IxhMPE4ndACGOk+8W7XL6oel6gyImBMWMLHNJpiMYiUbzljaCd5L426kKD/puiPeFdlEiWae+Z97HlSJwSjwXaQeBtYK+3AVgqK5KKB7xOOv+3+DVtG0idGuFZZamftgAhwQ0FNzbfz70i9DPDDmE02IQOnlOsNMef/4WbM/8BOWNQw6oSjBQTiKEwQTLQrg+6BswxUMm4kUxdBd+bxE4Q9U4++7xPZgjAFReVw+MggVFMXhsjdQfjG3Hn9AneO5gHWA846EXKj23lM/t/dkDjZ6AvZiU8xd9aELPcTyHPkPTbXNfombwHqugDkjFDd/4nx5l3YOYYVZAEjufiOq5xS/9jS4+KmRVigWJ523MlyY+F+Xm+iO5p4j4SnDSD2V413GAf1J8uoPcXvFWRYwKMcwHZ3S48x8fTACZrC2A6nY5DnNQ5ioKc+ZCgfa7PqIRhGqOpmm/Ylq6oro083LZ/C407kVpbmJ+i0zxt4bf8eux1BP1yQCVzVCbGvbvbR5h2x5iWlz2Qjlt96Xr2qMhb5XKOgrrgrsVbsmHQo31sSrC6+LSweVCgTPw9t/0131Ger+dLhhebJWTOnfrCOkvrKOJBGqskz4dD/gRFg/rbgIkocgm0/ozweIXzJyS9EPDQ3o/jfWXmiYe2KI7q+n6lji5yYSHbGYLIi4U1zWNaN9vqy8tZt9yGkXPt73p5/dh3W1AN7sSpKU6k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(7146999003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YwBBkPoVoT5GYQdBS8/bQMqk41zHZHgEtMuGHzQ22Zkv7XJfIpsSRWLc7C?=
 =?iso-8859-1?Q?KIp6O3yvqOor8SxJwMI3ff7QtxGQU+daPGD/DB1mEyVpbd5Fy4BOICcWbB?=
 =?iso-8859-1?Q?XblQFl9pu9G0RA8kNQvLPww8cftlwaF8xDSYz6LOttO+gBznmorfX+9qbi?=
 =?iso-8859-1?Q?qmoaciBQ5AYTQDW9U22+jsmLPLA2xLWYk4YsxWLCs91jDBmch7REaActLW?=
 =?iso-8859-1?Q?gn25fIHZ4VPzK5Y2pWj72hmvWzDmfWIae8DwX8kUOt21rX+kK29ozkHVJ+?=
 =?iso-8859-1?Q?5reUIw83pg1e8lkr9XNpY6HqispLTlGdpoKbvV7BAab+Jv7/bBLoElH/HE?=
 =?iso-8859-1?Q?FgvnH61GHbN8ocE/7wB0iFXbCP4dvenNBNPfjD0BkTyNXDJx5mBcUCB8u8?=
 =?iso-8859-1?Q?j7yPG4CogkAgFhJNy/+lns1o8SEqJPb/JfrcHX4jpoxEz7uBS8tBWPGzqQ?=
 =?iso-8859-1?Q?T1YDaXBMkgyJgIGZu5Mg7KJUsFViYkAnMEl68CoqOO4TY3ko7afvBr6ok2?=
 =?iso-8859-1?Q?LRBZLUI4uQt9CFcvmJ/V0EQzokWQbPInB3gMnBuUZIBoaNlzb0vkV/rW85?=
 =?iso-8859-1?Q?BR61UVUNEwH9D81bz9uxqOC+L/TYKpcore1/lLzCBpt6+1ZqDItYMxriVK?=
 =?iso-8859-1?Q?JoJgUvoHq2e7gh8noJ/sX6oX6TowmGNh+LTm9dCt7IL0l32O8cRo6CFf2Y?=
 =?iso-8859-1?Q?nTECyIOd4VbYAjmn9/dBKVxkeIT6rgKYj8A6UZnTHAuQPOC1c3IUc9bE7E?=
 =?iso-8859-1?Q?5ha3sFXWJHCyEKqoozbtGdAPkLCNhV3K0lRqcDldvb+WOIjBZF9iE4sIok?=
 =?iso-8859-1?Q?4e1nEB8EJAopTcMaPfNZeX0Uxj79CB7zJF0H4o2fA38mNt7N3uRxHlMbbi?=
 =?iso-8859-1?Q?fyPGI4mWQhTU642JuouP5KSV3dyZsuoDb3Rk/qFbP5tYqOu48OhyJQexRq?=
 =?iso-8859-1?Q?tkBi2oND9jCy8mByQ7CTpZIG5WTizAwyZcTbTFUXo4aoQgTrwyJUkg3ib9?=
 =?iso-8859-1?Q?xGhoN5tcHPEaBl2/mVqzevMv5s57f+fjRFM1BWMdt5KzhJhpNqYvPDWdH9?=
 =?iso-8859-1?Q?C6UfYztCmcvi4Y5EAWcBxGB0EKZWHD3nRmn/mKGMPtYqaXr27EJ8qIomR3?=
 =?iso-8859-1?Q?z3F6tQW7P8WErOL7CVtPBYLQwvjuGKqIWCVMwI7TlbXL9RzfmLwxSsN0Fp?=
 =?iso-8859-1?Q?H+j/bwkpvc1zU4oPx/qjtT62jqRU6nha3NY1wPlVow5vlxC+zGBOWqSD02?=
 =?iso-8859-1?Q?mC6b2BkLz1SVa2aa0n6O79mrRCclb1zbHHM3xv0YqhRwXDCFrYyMRP/MtE?=
 =?iso-8859-1?Q?pMsiwV5zMf8zBUmlShO1atDF//7H1GchQB94Jz2uDm2FWMfJyhl1ljMXmw?=
 =?iso-8859-1?Q?NINczlYfSw+FCIIaguw+g5UlEbbYocLjD51Of1mQoV+1qacfFsiiFzaHaf?=
 =?iso-8859-1?Q?f944/PIfV6pJnm3UDEt/K2J/i972z9Pk9cNlTlnxZo+sswLd6noZJEgXUZ?=
 =?iso-8859-1?Q?aIDjMOxrerA4l8IVN+EfVuz/R4KBXZK5SjmIIpcOHqCtKfZCi+2f6Eu2Wi?=
 =?iso-8859-1?Q?6XXOGhc97DHbM6mDw0b+ghIX1JL74j4JjxdXMNZrWRU3Cg+kgAFCLG0ump?=
 =?iso-8859-1?Q?S9pXyX26vXwKjERt9+Ey9/iHQgl4M0/wgcsSOqoWoBD4xEQyasNrlA9TT1?=
 =?iso-8859-1?Q?BMLPbaRgURPi4QH+Jr9uZGemade3tueAA4yG194cPPSZ35eB5+0GTN8pp2?=
 =?iso-8859-1?Q?tE9hjFtona/42V+FqgquB8dwsqAR1GnYoQoQ4m/17ERqCc?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 401393a7-7b04-4fb8-343b-08defa31eece
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 18:29:09.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ryt642+gVNcLA0ELzgdaSXIQiTr8DshAo0dQ4navfx81rXbECjk5xK7F9uu8rY9pJBeWs388hBqmEYOxVGEZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2012

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s)
> to consider:
>=20
> New issues:
> - [High] Hardware Resource Exhaustion (MSI-X vectors) / Functional
> Regression
> - [High] Ad-hoc Synchronization with Flags
>=20
> Pre-existing issues:
> - [High] State Loss (RSS Indirection Table)
> --
>=20
> --- Patch [3]: [PATCH net-next v2 03/13] net: mana: swap queue sets in
> mana_set_ringparam --- commit
> e63909b90b30b5041af0319613913c9654a4cc80
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: swap queue sets in mana_set_ringparam
>=20
> Convert the ring size path to pre-allocate and swap, for the same reasons=
 as
> the channel count path. An allocation failure returns the error with the
> running configuration untouched, and the vport is never released.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index b12291555eaeb..40e9886c87a81 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> [ ... ]
> > @@ -791,32 +790,61 @@ static int mana_set_ringparam(struct net_device
> > *ndev,
> [ ... ]
> > +	/* Block RDMA from acquiring the vport for the duration. The vport
> > +	 * itself is never released, so vport_use_count stays > 0.
> > +	 */
> > +	mutex_lock(&apc->vport_mutex);
> > +	if (apc->channel_changing) {
> > +		mutex_unlock(&apc->vport_mutex);
> > +		return -EBUSY;
> >  	}
> > +	apc->channel_changing =3D true;
> > +	mutex_unlock(&apc->vport_mutex);
>=20
> [Severity: High]
> Does this code use apc->channel_changing as an ad-hoc lock?
>=20
> Since this flag is set on entry and cleared on exit to prevent concurrent
> RDMA vport access, could we use a proper synchronization primitive here
> instead of a boolean flag?

This is pre-existing upstream mechanism, already used by =A0mana_set_channe=
ls()=A0; this patch reuses it for the ring path rather than inventing a sec=
ond scheme.

>=20
> >
> > -	apc->tx_queue_size =3D new_tx;
> > -	apc->rx_queue_size =3D new_rx;
> > +	scratch =3D mana_qset_scratch_alloc(apc);
> > +	if (!scratch) {
> > +		err =3D -ENOMEM;
> > +		goto clear_flag;
> > +	}
> >
> > -	err =3D mana_attach(ndev);
> > +	err =3D mana_alloc_qset(scratch, apc->num_queues, new_rx, new_tx,
> > +			      apc->priv_flags, &newq);
>=20
> [Severity: High]
> By pre-allocating a complete new queue set alongside the existing one, do=
es
> this require twice as many MSI-X vectors simultaneously?
>=20
> If the system is already fully utilizing its vectors, could mana_create_e=
q() fail
> to acquire vectors from the MSI-X pool, causing the ring parameter change=
s
> to reliably fail with -ENOSPC?

patch 9/13 ("share the EQ pool across a queue-set swap") fixes this.

>=20
> [Severity: High]
> This is a pre-existing issue, but does this code cause a loss of the cust=
om RSS
> indirection table?
>=20
> During mana_alloc_qset(), mana_rss_table_init() is called, which
> unconditionally overwrites the indirection table with default round-robin
> values. If a user has configured a custom RSS indirection table, will tho=
se
> settings be irrevocably destroyed here?

Patch 11/13 fixes it.

Long



