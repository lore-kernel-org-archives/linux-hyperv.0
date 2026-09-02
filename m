Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022138.outbound.protection.outlook.com [52.101.53.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CD392823
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377319; cv=fail; b=Az2bCm7Aaken1Yck6guw1vqn4y3HRU79wvrUoEs0L5VSSN52dzbkWgnsRs8kBui9RJ0lElCaMAqlYulya2Q1SFWSVoLm4k6KqOKK3h/DyQl9C+Ywj1A+/5uzHr5ArOOc85xKxtJ7iBvVdARF1TW+w2b0W7++vFWzRL1tGfvvazY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377319; c=relaxed/simple;
	bh=aDhJSMIoniOc6/KX1g7CB/B5oj2uwRTLzT1DSgh7y1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9vdeMZclZKwuocU60z5azaOkcWuneOXexC08TSFWwnq13PDGgzD6GXpBHB0j9k6NVe3CsYY/uG7Ye2vohywwBMNEJ1rWuTjewuf0J8W25IU1yM4p1oRdNrTAirSapS8a5SUUEf3d/fGShrAKqtbTS0M7VjyFPUHP6DVd89dgzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=L17ZMpFI; arc=fail smtp.client-ip=52.101.53.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L17ZMpFI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YruHWSzZVUtouLQbhVqA0osZ1JPHZHT7feCyru90v9lcy/846O2YZWyGJV6mhyCJTC79/f+j4sBaj9Tv6yU5lSXvLPV1TwXs1WDwQXBsbUKA1EQTNwn/WUaOSUIpDxszzCTvI3ggNfYlIeKcD60FNI2Y+2Ybph18akA5vaFWl57nykIETEuahtuOsNYD12qwp8GlsSpB6YQLIREp/hq7lWEPbPZ+OdTAuPIwycXuzxhLF1FJycdur9ENOVL1RUy6TwliHUvssSF1ztrRiaTFwCnI2ee/d1ovqaptqPlhRyzM5gZgM3DR1dXV9Y5sLR//e2xos+PPmZoGrLSkfH4W7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNkymyw19w93z/E7PvYHWGlMQiCrTZGVgtHpDjfE6FE=;
 b=yjrRx7YZ/yYLNAFezUZr0dYcLhzkxwTo55RaKxwdDd9zBlkxZgNfporn9HHwTsVryZFEdTaX0ouf+oWHy6CHkJJQnElTcEWzPrT1PDqMJlOeg6SLRQ0uPMIIFQGxGZzj5KbCBRXpU1Sko+UwWWxzscN1h7/GBSi++JuPvCwK5+15+/9EPrDSkfrpZwrgBxAIGCVmtvY+qiWd34KKwsqakZQUAOnhFUjU6U0mKHEJGKjN+qJv3202vGsHdHCcf8SyCBDYtl5hKo7FKNtUMJBv9rETgNNCY6W3WW3CJ10E2mQxQ8Obw5QcoFWVbwyzQn2fMvS7jTaRuFBwqa4QfUJe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNkymyw19w93z/E7PvYHWGlMQiCrTZGVgtHpDjfE6FE=;
 b=L17ZMpFIxJcLKxPqjQB7IKxTMtoIoRzLCjKHdn+NAU4cfFUJ+u/Eam8EtF7wUSsaVeOCyVrVzCPB2eDTEdIgUDSsdHjhshCGQkG3KU9p9mEpShZ5yktMkBCyJ4oxblsOA4G3Wj7FY8084lAlCnhoLyu15rs4nzqeQLzZnfiPV1s=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6347.namprd21.prod.outlook.com (2603:10b6:806:4a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.1; Wed, 2 Sep 2026
 19:28:22 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Wed, 2 Sep 2026
 19:28:22 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 09/13] net: mana: keep
 per-queue statistics in the port context
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 09/13] net: mana: keep
 per-queue statistics in the port context
Thread-Index: AQHdObOVmdRzSxBw8ECVeTE48pAu0ra6hhgAgAEoSiA=
Date: Wed, 2 Sep 2026 19:28:22 +0000
Message-ID:
 <SA1PR21MB66832017D03F7D3B393B5AE0CEB72@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260901014442.2945689-1-longli@microsoft.com>
 <20260901014442.2945689-10-longli@microsoft.com>
 <20260902014536.CD3C81F00A3A@smtp.kernel.org>
In-Reply-To: <20260902014536.CD3C81F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8dcb5c2-deb6-4444-a03e-aecc399d0e0e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-02T19:26:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6347:EE_
x-ms-office365-filtering-correlation-id: 7aa24985-e1ba-4aa4-4308-08df09285a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|6133799003|10067099003|7146999003|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 8zgDo1pBIF+mC5yMrYoZm8oYUOqjUUBtvzdRK3efeeIASmRNBJl90PsCJcjjjGupdCNq0g22LrKqjbc0RmCon7BLoxN72A/F1VWmLNZr2Qs6HjaXcuBGJJZYu59+yxIU4EXKihNR5H6Gwtng5ztJxev6VzpG6Vle8JspL8lpHUP4yAwZPDdvqDy7/HJIHTZrDLXdrFRPvsTnJzYAo+5pOX8PQQ3y7ZxCKhPvavALas7HvMpye4bHJQdBxWnPO/e57YNbTmTnYc87B74Kv4XkUUUT/OxLZiwrYcjwkBEI2/jD0hkE/WSdf3eTtqde5ofITaEyeD5SUnC6heBcHhwBOujCAEp456odcJ9HCeVnZzyco4Ac3CzK2xZxHbUSw0R7xpe3+cly06cNVscnIHc3hr4UWBq35gT2khJjWuKVPIh+y/cK4+QfmTg7QOALMfIs4bv0iy1H0PJuzadR4awLnkIUEi9swMDwvQHUQsegH1fpTJJ03aZ8pXIkZHDtoJjXSl10hRjr5ZsW6g+6L2Q6wn41x+OrEn9/NT2tTLqLgIRRbgVW/vNWKiHBaA9IFwidLDjpTx5wTkwkY7T+VZRIeqAWVQlr1perQGggGAFRLbJ+eWq4qzcaA789yDQmApy7ai22p/LRPCqI00yIU/agiE1Zy2SmlluBfwzbAN/K2ZNtWMJmB2jihMMhxWQuMbbmBH5RQc4AjSrk0Esm7uZOGPWEqfOYrx7//+ro2B24SU0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(6133799003)(10067099003)(7146999003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F9dGoSmUtTkW5reoYPufqlVUPDPLWbdaMepsJE2urTApsSfWHm5hjhYM0hrd?=
 =?us-ascii?Q?SCB719+7CYKi5lo3o07jw08XwaOEM3sE4Xtjol7vE7rfHAMPIwsrF2FNCLlr?=
 =?us-ascii?Q?Q+L1Pcjp76z2Jcu/jYHg3scgnGdu8ydvKr264fthAMgQ1Vb8bmCvBd9By2O7?=
 =?us-ascii?Q?tjbpZPhQLMSwC/yG4Tj2y/kqzy/EAu1w9hW/Fv9RLAMaBZ7EUoIf0aV5sdsW?=
 =?us-ascii?Q?Pg8ZcAGwKib7N9oXcdhf/Qo6ziN7sn9EkURvZnEIrtrq3Xc9udp5xWq4UW55?=
 =?us-ascii?Q?gxdUCXBSaPBeXtOlbqGv8jVipQQg0F7sRvzSzOiNj/bJYUEh2bNpEBbfOO8O?=
 =?us-ascii?Q?vr7kpQvfwl/61s5YXAA5TV1Y61+VgNo9SoHj8oIG3hoj1vzu0xryfkawoCua?=
 =?us-ascii?Q?Sex9Mbsod7jnfZXeTEu/bIWN2lQGSPCO9KxrefhegvpOAphhzTMWjO9Nqvfo?=
 =?us-ascii?Q?SGcnfH8NLp5GTz1bPNwLS5nde4H+P2pPOI+iUMPs4ZmnSaa6XumM3vgyEom+?=
 =?us-ascii?Q?/EqLeoIGANpj6uZe0SROk7niQNdBiwvhnrYsOSOW5S8dj1GboAyr0MR0lUYE?=
 =?us-ascii?Q?HXiCquT80/86J6oetT2iRAkDCG2wUKL7HhNCXD1aD/hhrvo8Rg9fwzH9brQN?=
 =?us-ascii?Q?0NK+jdvq4ohxQguHv+Lz7zDIdgvpL9y0M49niHTsG6sAVmRvorcSPlXsfY21?=
 =?us-ascii?Q?3H0KTbgZ5HzCQO6+Nw4wq0+/f0+i+Rj1xolwhLX049fs96SCqtzF6C95XR/f?=
 =?us-ascii?Q?KH6q00pidW0chFmHZc3RiyjPV910vQsn6n/WOPnwk8HXBvtGge2/r63Rs6Au?=
 =?us-ascii?Q?MJtOYpeiaZSkZ3vuXloiGNGD4aZtyovtFb/oc+RnF825jC+HfdMRXKKFgaXI?=
 =?us-ascii?Q?vrUOvxrPoIUS+o/gPuXzSfX35eYhVoisrH2MGE6RG5hhdT9J6jmTsgHr6Zbe?=
 =?us-ascii?Q?UaZ92tKCriSGdOyHK39GzViNE9V0EwkrYt2vxycp1YeWlsWcOyjlS4cQmviS?=
 =?us-ascii?Q?8fvQIQamElvf2dIyRAmVFudcLtPjfefgOsT1o3MqtkuTvVBefWeSpadN+MIT?=
 =?us-ascii?Q?AjZ7fFUiCoEy+oq+gGpAJIDj2s51Cp41JM+E7u7a90a1oEhqSZ2JZjhJvpap?=
 =?us-ascii?Q?8y98NzIRluPLofwL0WHQ2e2a2WD8Ak4shg4eMgOR5Yugz50JpdesV1tgTeir?=
 =?us-ascii?Q?KAEJebLJy7ViXz9eLsWwKEF+3tX4daD+cXJy/liOMfxbEyGJxcX1c+/CSxkN?=
 =?us-ascii?Q?L1zbYtvLOxZ7TUD0EPga7I+cmHnMqujYj8UnlX+wioYfVU3vlpc8HE0GBGPd?=
 =?us-ascii?Q?ieaj0yuiVhXYEfyZCIzLdvfWMacG3x5dXGG8SIYmJG8hT3xA5UeUWwpM6EVi?=
 =?us-ascii?Q?P7jdBbyG5nU9lHlKMDvrrPTdSIs5/z5gKS/DbUxyuLMWVPzl6Dp3dUILjpzi?=
 =?us-ascii?Q?EMhPQ/F0F4EUPF0mTetWN1U5HiMqjtmpdkoq8SPQN8xwFa5K4SIRF9deI536?=
 =?us-ascii?Q?Rho8hh8bV7ZSj0daf10ZVzIFAVo4xKEbKdmOoMJzIr1bISjMxoTVsjcb9Lgw?=
 =?us-ascii?Q?Je62hE0uQZBwGHjncLXGa9Mnwt827ZZJwCMMHtTjB2uF+ohd4yhz8ycJV+Uf?=
 =?us-ascii?Q?p/6sq6zkQV/54RwnKzX0wAmkItYH1v1Z/2kYozflmh9PSp/0kMx52Pd1jfIf?=
 =?us-ascii?Q?NlNZePZWKCy5QIAFHkishUpf3HfrKTz0hbH5illXeq1jek0i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa24985-e1ba-4aa4-4308-08df09285a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 19:28:22.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxOZTAqZpjLeYKxuZtVZVqHogZBq6tp9vJH5fh9wWfXg+RESs05emuYamGUW1FK8xu2kg+lQbq64aumNvRc9GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6347

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [Medium] False-positive ASSERT_RTNL() warning during probe failure.
> --
>=20
> commit b6c8581e036e2f21afeed4eb0d2e9961d1a0d2f5
> Author: Long Li <longli@microsoft.com>
> Subject: net: mana: keep per-queue statistics in the port context
>=20
> This patch moves rx and tx statistics from the individual queue structure=
s into
> port-context arrays. This ensures that the interface counters are not los=
t
> across reconfigurations such as ethtool channel count or MTU changes.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> [ ... ]
> > +static void mana_fold_rxq_stats(struct mana_port_context *apc,
> > +				struct mana_rxq *rxq)
> > +{
> > +	struct mana_stats_rx *src =3D &rxq->drain_stats;
> > +	struct mana_stats_rx *dst;
> > +	unsigned int i;
> > +
> > +	ASSERT_RTNL();
> [ ... ]
> > @@ -3017,6 +3163,11 @@ static void mana_destroy_rxq(struct
> mana_port_context *apc,
> >  		netif_napi_del_locked(napi);
> >  	}
> >
> > +	/* No poller left, so this is the last chance to keep what the queue
> > +	 * counted after it stopped being the live one.
> > +	 */
> > +	mana_fold_rxq_stats(apc, rxq);
> > +
>=20
> [Severity: Medium]
> Will this trigger a false-positive ASSERT_RTNL() warning if the driver fa=
ils to
> probe?
>=20
> If mana_init_port() fails during device probe (e.g., due to a memory
> allocation failure or hardware timeout), the error recovery path calls
> mana_destroy_rxqs() and then mana_destroy_rxq(), which now
> unconditionally calls mana_fold_rxq_stats().
>=20
> Since the probe path in mana_probe_port() invokes mana_init_port() before
> calling register_netdev(), the RTNL lock is not held yet. This seems like=
 it
> would trigger the new ASSERT_RTNL() inside
> mana_fold_rxq_stats() during a valid error recovery path.
>=20

The false-positive warning will not cause any functional degradation and on=
ly show up when probe failed.

IMHO this is benign, I can move it to a cleanup patch if this is needed.
