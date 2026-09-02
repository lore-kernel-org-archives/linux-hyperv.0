Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020088.outbound.protection.outlook.com [52.101.46.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4A397350
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379456; cv=fail; b=VAYK9zwZKZSptZss9rn5ZN0tbOQ/tN6x38qTt7F2cb1hTX5bOjHAUigRZrOh0SpNjvZ8YsvBcbfnPtjxkQ+f1xUmj8sT/kmqM7K60ZGsVtTgYXzH7zACeVKmTOWBgpIEfPnWkdW+fCwyFNAiQ5pC1zNKCjyCxOAtLtPUncpWyiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379456; c=relaxed/simple;
	bh=oaxKBUGpEI4NJBkWEn2pwlYSbQ3mX6GR01lKpyI9jSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iF2f92yowAT9zJCZinSpOcoGLTt4Ynp4S7Q2yUWE2rQhz15pQL4S5V1XtN2sTb0KSB1IHjgyr1iqFXSPRkX83JdYI87J+k3m9AoZEuRYWwJ3VdO/ms3JFkXSx2vQw9FfieFyFRHkzI9qsiEtc9il05NqQNrukGitwB/TFQ+5v3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=blHhxQIe; arc=fail smtp.client-ip=52.101.46.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="blHhxQIe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j02zUhCgujRo+LZ6GAjh+Dn63RgWI3VGS72x23Kc9NRnaUC/OZNdP0eGSpn1OTM67sq0jFwjaUW7Ij91xV5cUWTqsX9LRECmM23JIthsSkFnDfrJ30luF439WY/STU/hdg3N6VKFzmx8TtJGXscB9rlIs7TPX//FIYCp27LtTJdHn4lIldngnm13UUurB7Lez/d7jIh8l8p2e8rOcnnMvrMq84wLkh9EwP4Pc9Ja4/qHSFOUDu85+oclQer4oWh6OQQRFOpyZtesEej3OOVqIR5tUA9w+Klx3GWjQdFm6do1r0uDFIdbyxyjYr8wrSXBeiSBx6FFlBr5Uba7WCwl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JKFjI5ZbKHIP1IqiQr7MZH7ca7Lo3RzxRE2+d+/paM=;
 b=U7TngIujvT/kALY2h5940PhY2O1y4XOqB5oW/xdsTpefY8li19STrRjD5qirFDoJg1JEw+GldJND/SVobFmJytWkCTZuchvIItL+6tG4UWUlI5M+LbVXxfFtdNZ1rbQy3c4s+SuHXGp7TTUobx4zMKmX2Anj2aYoxu+Buj55HN99UCdvVS+u0WDtJDqvX5GsrfOIpX2UTXsQ4ws38N2IcC+Kqt059O17VvjUGQDzo98X5dkGdDo+Lbs8nxLFwLkzaYp07fN7KNevBYk2ZhMRcWQfCnSEWf4Z6VXdhPQfxWIpiKdBV4nw32f5CNDLbBATJflZjNfCspTtZuxHBL8DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JKFjI5ZbKHIP1IqiQr7MZH7ca7Lo3RzxRE2+d+/paM=;
 b=blHhxQIeYwAACFogmq49DlaciI5xwpce9q27U+wsp3Rgc8T0KyQy3mJ5FfyF7U/4ZUjHel620pfdcAHSXf5mwW1z0qby5IbBvjawJyvKfrM5c9mBvok7e7EHD1Afh+3iEXL6/YKEiQvZtw/5y32Aj8jGWysET1eVYm9Y+Ix890c=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA8PPF2C584C8BB.namprd21.prod.outlook.com (2603:10b6:80f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.1; Wed, 2 Sep 2026
 20:04:12 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Wed, 2 Sep 2026
 20:04:12 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4 1/4] net: mana: track when the
 HWC has been handed to the PF
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 1/4] net: mana: track when the
 HWC has been handed to the PF
Thread-Index: AQHdOkymmtneHiXgakq90Z7rUxNYB7a7tweAgAAAXeA=
Date: Wed, 2 Sep 2026 20:04:12 +0000
Message-ID:
 <SA1PR21MB66838E841AEAAC186521189CCEB72@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260901200018.3194525-1-longli@microsoft.com>
 <20260901200018.3194525-2-longli@microsoft.com>
 <20260902200117.C71181F000E9@smtp.kernel.org>
In-Reply-To: <20260902200117.C71181F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d4d0b949-74ca-4975-b04b-c8ba295e90ef;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-02T20:02:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA8PPF2C584C8BB:EE_
x-ms-office365-filtering-correlation-id: 40503548-9eb5-4aeb-b61f-08df092d5bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|7146999003|10067099003|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info:
 yIDwg7Xbhz4UBCUQ63UZO9Q0GjP4S2vapFlSVYENvff2uXOCdm5hAqRYaMa6Id6nhTLbEuGZ4OJoJ/xJWTo+MoQkkDyvk1Gr8eYTOVInFkBwcJTkWbb3AMR3xHN36YWf8E5JnFSN+FrpQ5m31C5o7qapCMeNIye8koaTF/hPJvvqjkTCrkaizIfFxe4I7Y6ilEY1FVRVVA1WBl+9l6KtY13gaLLGPfRTKrmjglLtYtfOOmmgXZxBcqb63ZJTQd/Q9d865PQHG8obM5ES0yyxKxyLRejzzFORDMLWjEupbj62u0Qrk1YehPSa1XtTCQfqj0bHGXVgwOLWo4h5yTHjkvjYSqlLmPlVz5bpVxVXHabxqGz4YMFOCTyea6JVUgkeIHmOPsn89zpO1wTu85mjHpoI+ReTe+xF1oB3rz5eXqNhNj7bhQaQtBQVaXa+Im5SyvH+VkNOoLByqCN3V9xpK3bxxd/uBWf1dgNmSLWwfKvOsUZhHCd1iaHw47w7vN6O7SUWkyBVSME5lltBWcD46Xm9BZ0TFuhRpywQFEgz1g4wado5fHa+nCgnrOyfW/VyrwDbJI3CBJ6fxihm+MwVFw5BuAKPiB8gjUwe41k2cknCZzlBPhGOTB69wjdWK8XwQOJOQ2b3NHnRYUe16BtODthV0cQj+ba4ZHIebDNkvEcD2TyhNhdG2Ldk3DWGqZmq5wghQlthfz9jl7Xs9tOzYQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(7146999003)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Yc6eT7/WWi6VHjdS841c8IC+UukIvy3TQJ/uLdEZH6eJ+SIkcfq+DXLLLnKQ?=
 =?us-ascii?Q?z+5FBPncgNMCmI7FmnNOJe4PdU6JnScfVf59bs3eJOaMbaLmNeiv3RyXR96j?=
 =?us-ascii?Q?LtWT83SxGUf8woNNIjLkZYVWBeEQf6GB6BjNTrxYGjrzBq8DyOKN8Cbse9N9?=
 =?us-ascii?Q?kY5xWal02oWm4zf11kddNLhalMJDAG706eD55GH1aBg+mF0uqnGPNIc17dCe?=
 =?us-ascii?Q?KJpqS+DmblnepUw8ua/mXuJRQ3jb0ynmO1ln1xSpdl2LiGxMHFhax6m9xurL?=
 =?us-ascii?Q?9QLShGxLag8XgT2bwRvCU98BvrVHoM2T2JW7Uy+cN7nY4eou6c1SkqWL1XG/?=
 =?us-ascii?Q?NTCecpoxXumj6P3lpT7CRtR56QpTqgv0jTsZHjWUdohqwZnZSWPMJHTkfzu5?=
 =?us-ascii?Q?2uN3tUYYSgsZNAOrYA3Z8VqE01KHphE+8h1fXAXvu08YlWxHBmhwvtmb6Vg7?=
 =?us-ascii?Q?A82LsCWfOFFL4DfJZ23L7Kza4RXmf9qrCJwU5kstgADjvPNgDmPAb/lufj9L?=
 =?us-ascii?Q?HBRovdfVe46w1TMcqvb22tWOZkrMKEvJS5CW1SAtwtq7LotbcHO/V/1Zy7Rh?=
 =?us-ascii?Q?TIWyROx/REcSqxgWpnERv7CXu8b6wJIZXOvnlnJoFuLx0cTnAjQoEvda2G3z?=
 =?us-ascii?Q?bKEoYzfnjBxjOXWVJMVuaqiX9NdIqqtb2EpkLY9rCmiR1/AaSpU9EzNFcCTs?=
 =?us-ascii?Q?p40/pEjyCeXSKPWRJI8jNEMPbdxaGiHuDp82CWrwEGuvdrgKkz0/Zzi8keQ9?=
 =?us-ascii?Q?N9vMHXP9cLQSl1KxSIydmdr9vmkjCrCCUn0grVLKH/SigW8P971oN6A4WSO/?=
 =?us-ascii?Q?ua6aIZRd5DKQyU15Uql/EhhbOORLHnQ0UxWm6uo5XGrmt6myaqJWz0FvttwH?=
 =?us-ascii?Q?jRd4Q0U5rTgm68TXDfM0uyQTnsPTNomJ/OSLGqJw5FbkuNE4gnkTc9+J+Xg2?=
 =?us-ascii?Q?MOycdZ4zaNbZ2ES6HaGnAZGG5anEIxJgqx5pBKllxi9grKLUBbXxHf/WnpK1?=
 =?us-ascii?Q?0dBkVEl/jGJShm8VjzqyRv1t51aFzTgYD07vfj9NGr9olaIiXRNrlkOn+1Ec?=
 =?us-ascii?Q?cvX7soKlr8aXcKJMR4P504RjMjKfFT0HklLuEnjCisPxnBzeodobRu8Jd5ne?=
 =?us-ascii?Q?wMiMWGZHEkIQSutpmFO7LopGgPfFT31Bj3nqd+IB5ERG3tx75niBZYU8gK98?=
 =?us-ascii?Q?d8bTYyHDECUUpcS0cEK4H1JWyE4MJjTvB+IJVX3VWxEoJ4uHW9VTdtELL6WY?=
 =?us-ascii?Q?K8WLlp11hhgI+TsuuDCyYp9lCad2Qt4qHkIgCLiQrEthB9ZCfzW2X/4Cd7Pn?=
 =?us-ascii?Q?cu7Gos9wVOboRUpvlXVNZrOtIipqbBsb3t85Qb6yQa7VNTgIKb4YbI9f7/k5?=
 =?us-ascii?Q?l68Xd8pJlcG8PWBOANz+1ywYeKDnllkcmoyoWv8PfgzUAa3cxGZHcAA//cfi?=
 =?us-ascii?Q?Qr1bdXgc9DT37pvlwvJborGoO6X+9w7/ayRGxuA/CECgwYKGcEz9ljEGV84c?=
 =?us-ascii?Q?FBuqsCizLlgvThI2f+HNW+/3c7rxybaAAsEABDJDUgT3LajhWRmJSv5roBLp?=
 =?us-ascii?Q?/vA+MK0YDEJ1Vl7kd3SODse4WBZ2/yAbCONjTIVLI+zknX7gTpmp2SseRl5V?=
 =?us-ascii?Q?CFeMkdF8YQQ6JZoGYfPHBIzRc2L5mI2Uz6A4+dvNuI+mVb54zDZtYfA66Qr+?=
 =?us-ascii?Q?vEixpqfN1pYo0hthiLzLJBtaHuhOzW4c1mEttaKSJ/y8ql8V?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40503548-9eb5-4aeb-b61f-08df092d5bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 20:04:12.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUT+HOwdEZsaSF5AsZaXXxnmHUtlpuOxCGSd85VUXuWwgm0gG506UdqNSeyzcubmeqL/F0r0hl81zkhyTnkLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA8PPF2C584C8BB

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
>=20
> Pre-existing issues:
> - [High] If `mana_smc_teardown_hwc()` fails, the driver proceeds to
> unconditionally destroy the hardware queues and free their backing DMA
> memory, which can lead to a DMA use-after-free by the device.
> --
>=20
> commit 0af150088ed8994a134d0a328a359e4cea4bbce5
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: track when the HWC has been handed to the PF
>=20
> This commit introduces a new setup_active flag to reliably track whether =
the
> hardware queues have been handed to the physical function, addressing a
> gap where the previous queue depth check was insufficient. This ensures
> accurate state tracking during teardown to prepare for a future reinitial=
ization
> path.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > index 263e7c4e29341..75fdccdc8c482 100644
> > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> [ ... ]
> > @@ -815,13 +815,20 @@ void mana_hwc_destroy_channel(struct
> gdma_context *gc)
> >  	if (!hwc)
> >  		return;
> >
> > -	/* gc->max_num_cqs is set in mana_hwc_init_event_handler(). If it's
> > -	 * non-zero, the HWC worked and we should tear down the HWC
> here.
> > +	/* Tear down only if setup_hwc() handed the queues to the PF.  Until
> > +	 * then the device never saw them, so there is nothing to undo.
> >  	 */
> > -	if (gc->max_num_cqs > 0) {
> > -		mana_smc_teardown_hwc(&gc->shm_channel, false);
> > -		gc->max_num_cqs =3D 0;
> > +	if (hwc->setup_active) {
> > +		/* Only a successful teardown invalidates the MST entries.  If
> > +		 * it fails the device may still be using the queues, so leave
> > +		 * the flag set rather than record a clean teardown.
> > +		 */
> > +		if (!mana_smc_teardown_hwc(&gc->shm_channel, false))
> > +			hwc->setup_active =3D false;
> > +		else
> > +			dev_err(hwc->dev, "Failed to tear down HWC\n");
> >  	}
> > +	gc->max_num_cqs =3D 0;
> >
> >  	if (hwc->txq)
> >  		mana_hwc_destroy_wq(hwc, hwc->txq);
>=20
> [Severity: High]
> This is a pre-existing issue, but if mana_smc_teardown_hwc() fails, does =
the
> driver proceed to unconditionally destroy the hardware queues and free
> their backing DMA memory?
>=20
> As the newly added comment acknowledges that "the device may still be
> using the queues", calling mana_hwc_destroy_wq() unconditionally unmaps
> and frees the DMA memory. If the physical function hardware is still acti=
ve,
> could this result in a DMA use-after-free leading to memory corruption or
> IOMMU faults?
>=20

This is a pre-existing issue. The patch set implements multi queue depth su=
pport and doesn't attempt to fix the existing issue.

If needed, I will submit a separate patch to fix the existing issue. The pa=
tch is not related to this patch series.

Long
