Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022120.outbound.protection.outlook.com [52.101.48.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADD39C63D
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377445; cv=fail; b=a8WqTZ2PZXaoQpSX2iK/zVreq4CfXB71Kncq8aQCJ5Js5vREjHhHKl/NwETHDFEAJ0Fj3eu7a/RYUKm7ROGp4TvFQy5/pC0unZnzW9FhmhvLbBvz7Hc0wOoP+h8Rf6xTE2174Qi2um0K6hAopm55zlrjJIok4iPytkknovZQr9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377445; c=relaxed/simple;
	bh=md3wUj2RV+yALxlPKLedHEdlo71wa69KnrvwdJieoNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7E9GCTKVXjc+AhsgKLuNvVCuTsRfFCwxwCuzsxPMMpl6ftmxb2vYr+Vp+pLmcMP2URhSrE8CAgUHQSV60Fz/XR30zSJ88PQqG/S8yoos+xfJbI/Q6adAAy0cYPyquWUyMZx8783ekKpJn6V5IWPauFgC9DyL09vdIJnAQ2Y5YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YOcuR+YD; arc=fail smtp.client-ip=52.101.48.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YOcuR+YD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSZ1Asq5nPXFowQBbatSO0oRvLh26GGdT81dEFgZ7XnVbqCBxYEs0fJyGYlhPNvFZ712ZpcH3XYsF+FcdgYknLoRx6Vh+LbR6hurOjviwFzP1uugq+yK+sJcR4nLiJoZP0Gqxc6FMnQrXbC1Hb1OL0B5fqX/BaHqEx6mubFkiP9PNqUCW5JnJFPOD+9XPBRCoctx5w2mB6YOHgy2XRFNNGkgLjBT1+9Bpj4P+NXy3/w4/mHOdOLNNAxPWehKLe/TpVDLqA8RX8m+Q3Atq3YeqfWKuwbKhQTGv2/Tf9RyDF2MrQJ7qLwtcFXZKtxaNbYSgcHP7OZ68UcD+kdaQ/j7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWdpGIimZLQ+OlcX1hY4a9JUN7DYTVWBBLpZauUr9Pc=;
 b=KAfjC8G8vnXwyvd6LnKyhkWhizzYaKOX9tLgGFuhry6ZfLtNHzDxu0hzTm02PEzkLr7FJng5zRhQMtEvAXizwjG/PXIY/v8yqu2AF5clfTtTanuH40YSbJI7AQFwMS8MLc3WPI6qdFAxLXgR35/OGktX7AoxAsn5I/9L5BC9jBdyt+Zu+3bYIl+qdVaWysWRrCO4pxxEMiX56QU+x1t8F6fkanZErM6rr3BTch/GQeNfwnIyzX2qfdWWBfl334GpORsWr9zffxCKbZueohnC4ePReZWPH7cd3dJSeDalOQRgd+XSKHJvG3mMPafzeBXoQcI9CtMsHppdnrzQmDHvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWdpGIimZLQ+OlcX1hY4a9JUN7DYTVWBBLpZauUr9Pc=;
 b=YOcuR+YDNjXTUJgHcZP8txz3be9O59MYzfFraPLXrjMGImOIXkhkWHYbOnkVfNZ1i2/6+9aEvFVYhg3qKNIl+VFms3ib59q2gFiQflPMYujgikXs7KiYtf2KBLLrQjqpISCYsK3nLKQGHsd2mKxyLrfLRu1vM0e53+FKeift0ao=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS0PR21MB6792.namprd21.prod.outlook.com (2603:10b6:8:2f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Wed, 2 Sep 2026
 19:30:27 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Wed, 2 Sep 2026
 19:30:27 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 10/13] net: mana: release EQs
 left idle by a channel-count reduction
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 10/13] net: mana: release EQs
 left idle by a channel-count reduction
Thread-Index: AQHdObOVqUyyhokUYU6fzOZYyNA7N7a6hhmAgAEo9CA=
Date: Wed, 2 Sep 2026 19:30:27 +0000
Message-ID:
 <SA1PR21MB6683B86C6A5BD910F19CB53FCEB72@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260901014442.2945689-1-longli@microsoft.com>
 <20260901014442.2945689-11-longli@microsoft.com>
 <20260902014537.7CBB51F00A3D@smtp.kernel.org>
In-Reply-To: <20260902014537.7CBB51F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2a8f992-2710-40cc-9bf5-589ee989e6a4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-02T19:28:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS0PR21MB6792:EE_
x-ms-office365-filtering-correlation-id: fe4390c6-c7e5-4d9e-4fa4-08df0928a47c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|4143699003|11063799006|56012099006|10067099003|7146999003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qHG2Cc4MxMn4tiCnAtN8pUynGGxQt8MjxZLOBfdB6HSAY0/AWnhMhpOkjwDdv7onGEYaqqPI5N28L/+x6Ee9Ktr8O2mtGvTIaYobBfcV4BQbm3edo6ihlIEn4tnLKxI22+IZQWfeFJ0FHKrNS/6SpWeZ9QkrC3JdIUGZmbcrfx+BUWwX9xTlz4mJwcX3FrKATXlrXzrZI7WuRzolldtdLyRkv8yabLwJlZfHL7RsZEUkHEzs4Z2LJfYyaU2jbGnOecO1fuDAAYEuUwZlxBfrj9taORV8ev3nKxTHRbZXIXYIPVgnqMu98p4Lv0DvuiHbXoiar8Lsyf5Kk5+ocHFrxYqsQ8W/cWoQ4Y4grcSygUqeXdRKXhC3Df4698XruFVGdvvrqUahA2DcaWZgO+wKFbnkH0HMbO0RUnMAjQFe+92JB4lAfOaUfkqLiBMVfmv7coCziIrY9rQC6PYJYS9/HiC+r+tF+jjrIenoB6xOr6vPMgCJq1eFBCHUuSjMljf9tJlRk321B3Qj7RO1sfEPMbTkWAA1Q9JBfmws0fW+yATpburrJsPkv8iK64mzrvGbHBk4/NXbkcdROFnr50uXn8QWpPVFDI7nyaKS2HgrtDsYK6br6flmGGBzg5bZ5Roui21hXUtNd8PmlTRdrw3GprYOCcUh+Z1J4ZoFxU4gN9dJ6kUfXXaIumZChu7JyoVEo9FHVjHqsG294IbZwybYnuy8hmuaiO70a6KFSrW6A9c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(7146999003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zLkgj2Qj9DbGDfRp9D5ZSdQSW+1HHNEj/9T4vfudLsllLu/0WqUXu5sZUp3i?=
 =?us-ascii?Q?R9Nl4iTZbiwNeFiGgDewQD5mI/cYZf7Il58uG4NBWWj+vmDSgSIV1udWrlqE?=
 =?us-ascii?Q?3+/hqh/OcebxVDnZEV9yfF4MDieFtYixvnaHm/6bP+LyFh5Krq4T/Dec2RiA?=
 =?us-ascii?Q?69iNATKKBLVAbQOG7W5e8KoJYCkiKBzomZhtKHwYiM+arrFXYxwMfRutLuCj?=
 =?us-ascii?Q?KMIzUe4FhcQ+uIHUomAm9OFcaVFKtP8w5niOZ4hi/T/cXVB7cZtGg+uCuAuN?=
 =?us-ascii?Q?0BOXkYyOt2TaMeo2/jkTeZ6cxjiMgtrfjA1AO+pVbJppyr0/NGcMKB9WXNnu?=
 =?us-ascii?Q?SXwD9h60l772K2PTalDxGBYmBuLJ7UdLZv6B51zl45D3FqAASJhjq6P9dJUQ?=
 =?us-ascii?Q?Lcz1behMslA9NNjQWqNMXD1cFPYRV/+jKsYaBtn1Yuhwa0+spy3pbnYmPPS1?=
 =?us-ascii?Q?wr8KCeRLpuSGduCQyVL4rBodyjXY+HaWT6osEWE2evk1egytXnmmkbIOq2xO?=
 =?us-ascii?Q?s14kc2x7U0y249I74v3AHXC3MpWNfmzNqNm2Kjn3ouos07tvwFfsTvOwbJpv?=
 =?us-ascii?Q?OWNgc7ADIyYtlugMusS2FTclyYS6hK89dj8a75Ps3FhfrEmdzMRImAUEKxQ5?=
 =?us-ascii?Q?ZaCMiBL4nQuwjkuDwIwtgcgPwPAHs9iZVeLtfcD2J6DtWtfmAXKxb7zb4WWi?=
 =?us-ascii?Q?MlNFUXuUB2y0/9t3LUQNFgKpmyIUF+nJF1kdBZmPxaV3q2WBBzzG+Ea7KjCm?=
 =?us-ascii?Q?zHLD0bbc4ye/W+Y+mrIMa1gYA1HOZ1sqcxAXEhCwkSdjWaORTpQulxDYQNBc?=
 =?us-ascii?Q?ya9wNQ+D1VdTJVQnaTB9oK7QCAFZFtxxj/sT+Pb7SM7YPRCHbvjCc6iFP+2t?=
 =?us-ascii?Q?AUD/xfbl4yQ19RI0iuG+dPxub4KjIzyHqtRKvyg1r28mrpqoassFYDkSnnnV?=
 =?us-ascii?Q?KpSj53PqsdCW8ulAuyz+u41i7sy98kzg9UmNYy6gHRxYGgWIJepSrWx208hL?=
 =?us-ascii?Q?tcv9Qw0ZEYy4fxdNE544mIJaetLBMNJYBxgEe+ryovSb5kJhXFs7l8JEBOJQ?=
 =?us-ascii?Q?vRUurtQvdDduqaiJWzQmPHfWPM2aQgNsj4aoQEAxSWKidEeqWVrfgROuYySX?=
 =?us-ascii?Q?+3zGRvKnoq2GNnyIxYQVVbDmr+D1iA2/7oYX/KgbXZXZ7pARyo47elwPSvzt?=
 =?us-ascii?Q?bVy5R0QJxcd5ufsFgavk9jdUdV82MYOp0DapBh+3ZfwmtERdBRcZM0buuM9a?=
 =?us-ascii?Q?HLGGqree4X6hChfuryGMCknt2H4m2e4uI45ZmhXKFvbJqctljjGjXc/FqY+H?=
 =?us-ascii?Q?jO3pqSY/hC+18NiyICIWkorSHgj/ISjqg5UEN2n9vq0GrPtTCdxaRWAZmR6d?=
 =?us-ascii?Q?Ne/Gtosyn0TFCsNWk0EnFcnkmWOVp1DKZz/7Um+Vu0nBnZeA2xcLTgSgkdm3?=
 =?us-ascii?Q?Y54wiyrWPtEgYl/0CYuZmYBF7LtDTGwDjmPYG0kqwlVxNI8Cm+B+4n/eFKGR?=
 =?us-ascii?Q?nZ6Z1B9twN+Llky/dfw16IjKCNYeKG7tdjdILyV27UUNvjVXqljAs+5u5vjQ?=
 =?us-ascii?Q?W10Ig9Lm03hi6SXVmi95Ah/XiFoGyzC0kmcu09KWQTnYMBQTnlPFi9OPSJso?=
 =?us-ascii?Q?IBAw5Ow98/9Dl0gd1qYAQzMYCyIpnVNWJIIT6TBOmTUy5vEdeGIfcYF2F+J3?=
 =?us-ascii?Q?7h9WimAUzS+L4zN6KBC0NEgnEP+naQi36ADMa21t7kDGj7Mw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4390c6-c7e5-4d9e-4fa4-08df0928a47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 19:30:27.2748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFqkNJITH7TimZIZ/V9APPHe1zrO0yHLVO8ninpx5PvJNsEvqZeWQ2XEc4IX2X4plPqeiWI27uZ5g5RAOxDxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6792

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
>=20
> Pre-existing issues:
> - [High] Use-After-Free of CQ in EQ event processing due to lack of
> synchronization during CQ destruction
> --
>=20
> commit 3d0d6fcf405f01d902d109c4441be576c316986f
> Author: Long Li <longli@microsoft.com>
> net: mana: release EQs left idle by a channel-count reduction
>=20
> The shared EQ pool only grows, so it sits at the high-water mark of every
> channel count the port has ever used. This commit releases the EQs above
> the live queue count once a retiring set has been torn down. It also ensu=
res
> the dentry is properly recorded for debugfs.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 69e34fab8fe8e..2295769da0306 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> [ ... ]
> > @@ -4745,12 +4785,19 @@ void mana_free_qset(struct
> mana_port_context
> > *scratch, struct mana_qset *qset)
> >
> >  	memset(qset, 0, sizeof(*qset));
> >
> > +	/* This set is gone, so any EQ above the live queue count is now
> > +	 * unreferenced. Release those vectors instead of holding them at
> the
> > +	 * high-water mark. Safe here and only here: the retiring set's CQs
> > +	 * have just been destroyed.
> > +	 */
>=20
> [Severity: High]
> This is a pre-existing issue, but since this teardown path is being modif=
ied,
> can the destruction of the retiring set's CQs race with the EQ interrupt
> handler?
>=20
> An admin reconfiguring the network interface (e.g., changing MTU, ring si=
zes,
> or channels) will tear down the old queue set. The hardware queues are
> fenced, generating a final CQE in the CQ.
>=20
> If the EQ interrupt fires, CPU A could process the EQE in
> mana_gd_process_eqe(). It reads the CQ pointer but might be delayed (e.g.=
,
> by an NMI) before invoking the callback:
>=20
> drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_process_eqe()
> {
>     ...
>     cq =3D gc->cq_table[cq_id];
>     if (WARN_ON_ONCE(!cq || cq->type !=3D GDMA_CQ || cq->id !=3D cq_id))
>         break;
>=20
>     if (cq->cq.callback)
>         cq->cq.callback(cq->cq.context, cq);
>     ...
> }
>=20
> Concurrently, NAPI on CPU C could process the fence CQE and signal the
> completion event. CPU B, waiting in mana_fence_rqs(), wakes up and tears
> down the old CQ via mana_destroy_rxq() -> mana_gd_destroy_queue().
>=20
> It clears gc->cq_table[cq_id] =3D NULL in mana_gd_destroy_cq() and frees =
the
> CQ memory immediately in mana_gd_destroy_queue():
>=20
> drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_destroy_queu
> e() {
>     ...
>     mana_gd_destroy_cq(gc, queue);
>     ...
>     kfree(queue);
> }
>=20
> When CPU A resumes and executes cq->cq.callback(cq->cq.context, cq), this
> dereferences the freed cq and mana_rxq structures to call napi_schedule()=
,
> causing a UAF write to napi.state.
>=20
> Is there any synchronization, such as RCU or IRQ synchronization, to prev=
ent
> this use-after-free during CQ destruction?
>=20
> > +	mana_shrink_eqs(apc, apc->num_queues);
> > +
> >  	/* Queues built through a scratch context carry no debugfs nodes,
> >  	 * because both sets are alive during the swap and would collide on
> >  	 * the same names. The retiring set's nodes are gone now, so the
> >  	 * published queues can finally take those names.
> >  	 */
> > -	mana_qset_debugfs_publish(netdev_priv(scratch->ndev));
> > +	mana_qset_debugfs_publish(apc);
> >  }
> >
> >  /* --- end of pre-allocate + swap reconfiguration path
> > ---------------------- */
>=20
> --

This is an existing issue with the original code; this patch set doesn't to=
uch it and will leave it as is.

If needed, I will submit another net patch for fixing the existing issue.

Long
