Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020076.outbound.protection.outlook.com [52.101.61.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363F49504B
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734829; cv=fail; b=sleF3OZO1c5kwoKTDVt00wUvIpb/T4wnuW/rVxJcLSzF+S6lPJaXItsgAza/HRL9NPP6xRmEgT6XiiBrHD/ix16S0bp57xcWANCydRWh4pE3utHINT3VpBU4d1uCiF9EJeLIjaXyvT6MnxQMevu01n/W8BSP8VpBww26NQhIgJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734829; c=relaxed/simple;
	bh=RFpuoYFkNn2GPqUohta8CGIIPYunhf5pnBJLW5t3mZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AkZSF+CQR2S8/Lui0b+Gl+DPyrhJNNCU4/WGfU3HnFLEu1QykvM7hKUlNHwpJqn2LnD/cWRzJzA166sW48eNsK2sVx0mFHrPWuzXOJdH3RXY+Mfe3/sYofXPO7SfYExn+G0A0zqRkR60Fghpf6m2mwmI5WdLOcq9FgGa2ox96Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Zv1jc9xC; arc=fail smtp.client-ip=52.101.61.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zv1jc9xC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwzueIKRU+mNeRB6Dvb2ZmN8tp1jrg8gDZ7lTAvdqIkoGi/zFhDPFauYYynOm8CORVAQYiYqtQS2Ue5AWZcLwu+YLHia+OmOsMF9BT5VDoXP/zEzAAhP5ranzh7JoFcQrE5hrEJ5U6eRjmPETI8t/Ij0K60N9uO5N+ksep0RVVXmz37jggkr+TjjGyXqsNrBw/0nzSEVcAVamAL6ZccRxYOpqRwmJIyqN+mrXA0VAnmXPbTd7Z8+LjstMZtemGTf1NCoJhhP+dbLoBns5jUUZd5piVs34xYeme6mlNCR2yS2iIkn3fSnJ22y5M0+2tYn5lwOkFsl+czPwHPXDCIRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s12Uc4uR81Qk+JKNDutW0nqXhtdd9rcBF+PT4/JIXFE=;
 b=JCNWRKCDkZMoTchaM28mdj2i5Axw2t5kJsrjRvW5mNt17m8+sjGvs0P8D4gfMtIlGHzZ9SyBqca0jkqKCfYOZku/r/zSSTSdKLkC0YDwbL9rguMnoiyvYBqCN0eLFK2eP2HNrbKjwLxPtst2BybcdA5S7q1Kax3iqmMwm2B1NZDnC2EACbJoGon1XV0bys83OTv2axNuiAFUZCVmFAmXszcOJ1K0OHx+hD+wTF6z5O0i73QOa2QPQlL5/RGaiVW/5g8X7crfAzl6Tw0U5PlrM2JyYgqq/1nKLwoymxHuc80JFoBINrgOJvdmPzPLI1YYUbPIFnTPw6aJwYL3J5Qt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s12Uc4uR81Qk+JKNDutW0nqXhtdd9rcBF+PT4/JIXFE=;
 b=Zv1jc9xCVOH6YHbK3Gg66T9oCA1t/yYtBfMeo92LISPjZMWfI/lM3N0B9wKmcHBrEJlhfMesZ4f3luOxWBo0vtoM0ez4LbwhVBXQXcRREw1MKxchBrEOEYqT3sqFeT+pDHM/waF1lzuzOu4f25JjRW+6n28budvF1JNs6rm66BY=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by PH0PR21MB6229.namprd21.prod.outlook.com (2603:10b6:510:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 19:13:43 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 19:13:43 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 08/13] net: mana: keep
 per-queue statistics in the port context
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 08/13] net: mana: keep
 per-queue statistics in the port context
Thread-Index: AQHdKuFM+fH6nG+YXk6WFzV4mWf7Qrac/zSAgADtBOA=
Date: Fri, 14 Aug 2026 19:13:43 +0000
Message-ID:
 <SA1PR21MB6683551A6A43C4ED99645662CEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-9-longli@microsoft.com>
 <20260814050515.3B65B1F000E9@smtp.kernel.org>
In-Reply-To: <20260814050515.3B65B1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4b85cad-0d34-4273-a296-975d301ece26;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T19:13:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|PH0PR21MB6229:EE_
x-ms-office365-filtering-correlation-id: fb3dbc6b-6094-4299-f80a-08defa38284c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|7146999003|11063799006|4143699003|56012099006|22082099003|18002099003|4133799003;
x-microsoft-antispam-message-info:
 68hl8dQ2rhOdjHIs/pEzA7pd1Ro8VxdvZsXQtvKHu3qMxQk6mEDcvZu26JTt1m2v/cA3gBoQ2VWo9aXE0xNLmz3E4nn6c+aGCOTr7UrE+xGLfD9SiTwjTm9lmHsLbTZgH4tQTKDVBZgo62FEc3kXTTxjC1txks9rMefHZtYXwNvkUi4o/IhFjFJkfENpP8mdcbLaeOoGJdiZKffznIFLU4QxSUntah4fIp/RZEKdm7cVYbRXlZTOCWhoSc6IbcFw+FB9SRMzEODJZzTGRH240u8knRkNq91/n1QR7DxItVlQsUx7C883w7VFDgCwMvmjVV/gjeUj1Ruguy6tBGJ78TtIHlmdoIDB9vzFOAXf06hiMwDdd+3mt8ql2KqPWn7/WRjPSVqUokQ1dCnwEKN3aKk1Po8vOrbaSIaX3qfuU2Cx5yyEURrttm34BCdqh6LfthDL99yLRpjPFAVsL4gd+azT1wjr2izD5mF6W82HSBAkY75VqWXlBn2CGMKID6FbUOn0EemnCyd+iXeTkMeIgcmIj3a9EIAOeeZX883qxYL47G8G6D2rX7iT9KmTuF1Pl+bflrKG4QpCAkXSf+iK0LzhJ40tdO0BAi+vnNPq5ocunDPlDZRI8aZhtJ1mq9WefLcWwA5r/qJEj/ZRDqKRUIzZt44n7Er4So/T6rnUwFo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(7146999003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(4133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JlM+9fkvlxcXthOAKAlDhBH20OsOt+LjrX7wMR5qOedYJJzQvpJf4otK9Cfc?=
 =?us-ascii?Q?N8y6GUhNy8qs64rxHHBsyxi3eT09hzxFi7feLfvuL5BCesL6HIPsO4eWlA0G?=
 =?us-ascii?Q?jo7WQsX9ud/XRfKLQdGsR9RXrSoj4Ysjbg/vz1IMGXcco5lN42reYtHkOaeC?=
 =?us-ascii?Q?TpbpnEwe4vFAzE+5UzFqagWHigFuoz3EYbVIA6R28b779JomxGVfCVAP+G+g?=
 =?us-ascii?Q?LPUsq/HGfkRFljoLp9+xe0E2/Z/MIpQM9ol9KC38Iso44QqtxcefIrgsltTM?=
 =?us-ascii?Q?EUnb8zNG1RLwujfRwwWeme1rZ7YHkF67tLdOc6cKCHufZBq2ghOg8I8z9NyI?=
 =?us-ascii?Q?p4hPph7eE/wJ/9VdbvfV/hUmWI1K86MCt0lQZA4fXlwpmFKcgiCy3XR2VhsQ?=
 =?us-ascii?Q?jWbocNtvEeP0DFDB5Jvy+NerM+/o8cEE3FWel4NS8FsTI323wr3afvLuKnAp?=
 =?us-ascii?Q?PX2MpPcti/RthFuL/+e90yFD+aKXuOtskFNeku3nwZSdg3CAjb1Ci62x9cDq?=
 =?us-ascii?Q?foEKXd25LiqaLa3yg4GUqZBg1OOsPW9SENgu4/txhQBVkgDAwbATQZUoLjT5?=
 =?us-ascii?Q?KiBGGROVn/pWSKh41vwO14ULLziA1NLXW013vFqD4RXNlNXpWaM8Ap6fjfOp?=
 =?us-ascii?Q?rAV80wX924W7kIa/lWsxR813TDNTaSL+RcMmWbYaIGFFJTXJhwSZksZCBqPb?=
 =?us-ascii?Q?8v9K30Wvb7lbx/0rL22WQCY8/S7mLukOR2Uzq8S4N9dNKSxjY3KUPLOqzZL+?=
 =?us-ascii?Q?cLJHza2NxO1aVjV1OhkAydIgAOXU8nd0qtxab/7bPwBo7P1xegS1CxmNpcJ0?=
 =?us-ascii?Q?xuZkx1T3IO7Xw2DgGEewr9pRtq5igVMgk+y5v6d69eKwaVHyaZs+P+oKbtJt?=
 =?us-ascii?Q?DS3cP3m/3S1WVsItegJ/M4eZHgZANu7yMVdOX1oDOlzv733nlc4D1GEoP4Jt?=
 =?us-ascii?Q?fbaOe5Ucje8TwMMhzKXQVtYK0AyULdzs2QaYyYpEtBJNa1XreBAs0A4Ilyi3?=
 =?us-ascii?Q?pypskh8W/ymCeAUnK3QqL0lgi9VREB5jeZsjW7bQfud7C15DqyvoWfUYGkx/?=
 =?us-ascii?Q?NwXMB3VAEkLr8H/MzxHeAFZvFZpqvTfXTtE6QL0gGngNh85kipA0ekFxeIda?=
 =?us-ascii?Q?KJfsZdnW1jhoBbW1dIiIQue05yy93QeQxBwo7pBKbuCYo8Xa4zWOHDT5O4ra?=
 =?us-ascii?Q?IuSC5Ty5jrR4BPxmkL4lDWqKzfaeIak6TTfdqXSPdSD6CZlVHDYbQo8wBsdN?=
 =?us-ascii?Q?UR9QJfcPT9Gy7GtKVgBSoXYFKe/vLzwuUkxChf4hx1gLoYFfocSQ78YGnMEJ?=
 =?us-ascii?Q?3xisqipk+DtEZqC2d9qX2BPGQgi9yWddZadiTSz2T6Ur5ETpL0ixjXyE1xJh?=
 =?us-ascii?Q?OCfvPDJ1uIpc6puFJTbzkXC/o+wUUXkPJ+ANQ4mShaBm4hMvpM3W5DHDX70C?=
 =?us-ascii?Q?43m/WCRI9mlOo14YIpE/tW4E0xA3nfdnbl0hMP2MnTR2Ph8QANIQdO3Lfaqz?=
 =?us-ascii?Q?7ztKwBlSr+6mjxBvGYJy4H68+YzAGHZNAtJtRQGiKyawdgdpDAbfaR5DvpYg?=
 =?us-ascii?Q?6o8Mw2Wl+dmNYLBbd7XUeRtD4ruIowc9lGelsLGO/tYLQVDyzJ+7bH3O2MqG?=
 =?us-ascii?Q?HWXSrwN7YqIuD6DP2SkzXqPB/9xObT2HNW6tiWoD4S+nnRKM/FRorhvOxFZn?=
 =?us-ascii?Q?jkqfQ07wzpzJ6VX6NqdDCTl72gU781zHPyeCH2lleWE3/ny2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3dbc6b-6094-4299-f80a-08defa38284c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 19:13:43.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0di7qZjbKZGdbeEt9j/fnLkcWz58FaaDPtj2oC+rdxSMsvYwmKw2/BvPEGknqUBsb+pGhoJSf2Xfo50zPX+Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB6229

>=20
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [Medium] Concurrent writers to the same `u64_stats_sync` structure duri=
ng
> RX queue swap.
> --
>=20
> --- Patch [8]: [PATCH net-next v2 08/13] net: mana: keep per-queue statis=
tics in
> the port context --- commit 48e144b542daf3b7f2ff07b74db60098e784159d
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: keep per-queue statistics in the port context
>=20
> This commit moves per-queue statistics out of the queue structures and in=
to
> a port-context array to prevent statistics from resetting when the queue =
is
> reconfigured. The stats are indexed by the queue index, and the arrays
> outlive the queues so totals stay monotonic.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> [ ... ]
> > @@ -1059,6 +1065,48 @@ static void mana_cleanup_port_context(struct
> mana_port_context *apc)
> >  	apc->rxqs =3D NULL;
> >  }
> >
> > +/* Counters belong to the port, not the queues, so a queue-set
> > +replacement
> > + * does not reset them. Sized to max_queues, allocated once.
> > + *
> > + * A swap adds no writer to a TX slot. RX slots do overlap briefly,
> > +since a
> > + * retiring rxq keeps its NAPI until mana_free_qset() destroys it.
> > +MANA is
> > + * 64-bit only, so u64_stats_sync has no seqcount and at worst a few
> > + * increments are lost; the alternatives are a lock in the receive
> > +path or
> > + * per-set slots that make ndo_get_stats64() dip during a swap.
> > + */
>=20
> [Severity: Medium]
> Is it safe to allow concurrent writers to the same u64_stats_sync structu=
re?
>=20
> The u64_stats_sync API requires that writers must be mutually exclusive f=
or a
> given syncp. While MANA is 64-bit only and lacks a seqcount in the syncp,
> allowing both the retiring RX queue's NAPI and the new RX queue's NAPI to
> concurrently update the same apc->rxq_stats[rxq_idx] introduces a data ra=
ce.
>=20
> For example, both could be running mana_rx_skb() at the same time:
>=20
> 	u64_stats_update_begin(&rx_stats->syncp);
> 	rx_stats->packets++;
> 	rx_stats->bytes +=3D pkt_len;
>=20
> Could this lead to undefined behavior or KCSAN warnings when the queues
> overlap during a swap?

Wil fix this.

Long

>=20
> > +static int mana_alloc_queue_stats(struct mana_port_context *apc) {
> > +	unsigned int i;
>=20
> --
> Sashiko AI
> review * https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%
> 2Fsashiko.dev%2F%23%2Fpatchset%2F20260813050418.2906468-1-
> longli%40microsoft.com%3Fpart%3D8&data=3D05%7C02%7Clongli%40microsoft.
> com%7C310903ff6b08415ea5b508def9c1a301%7C72f988bf86f141af91ab2d7c
> d011db47%7C1%7C0%7C639222807222824332%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D%2BNqZwTPmXgY
> tTuwJUM%2Fj%2FSq%2F8ZbA9FR0XOQrz81lpDQ%3D&reserved=3D0

