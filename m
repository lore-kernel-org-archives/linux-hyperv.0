Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020072.outbound.protection.outlook.com [52.101.46.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076C3254A8
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379485; cv=fail; b=MMiGW5ZWfft6MOobAoAGkTkZm8x8UHg/QMcQzAnJpkQgODNgWMysqMCF5BWUyYz6uNU//sxYD1+vz4J/yG8vUJW/B+KCNKNGiv+u0/Y/EW+XEEI19e9rGrSHJ9hw4qKP66rTpQAi++ldXYaSMkqQIK8un6m0DVmlolOLRz1U3XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379485; c=relaxed/simple;
	bh=Vz+QS4nQd/ZBak0djDpKBgpBjhJy/qkoZbI53HJah/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFOaMuzjt0rj4zalJjgCYh2cZMzHkd3LtPEeufnivvP2t7cwLKge1YRKns4Y+Z7U5dJeGcnYRiK/ksLQOGGeMjiss4QKAjiY61+UR0sH+1BcIxZOPgVi1xyxzpqTsoYE3wzaVMjU2qkOb6EUgLnS5GOb6SakfWr1GDJYByRY0aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DhtQYRE+; arc=fail smtp.client-ip=52.101.46.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DhtQYRE+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9HjjIzrhs/WbSEjiWRcfCUJcLpLsVn/SR3znKc0wP+Lpzzk4g8jrR4Thhnp3FsaqYq+E49xpgy5trGQpnXoISY2B+xTgrBTvMkPX7znQwsB0vjrnc5RkjUzjL6gLVVlWKdV7wy5k++1IpiSVD3RBAl8694GpoUtdmYxR4QX+/lOwGbv1GiPKScLSlLjOaY/IPWZqUKW3KZjwVIzqjPQ6m0Dr1XX2PMyBSiZ+Pugblb+k2Mwmp6MuB2DRW7txL0QO1VBpnKCpgBgrqK+hl7VDxv+32NoqjFvQiuSrqFFDuOBsvMw1K2HXmnkM/pfkjibkOZml6mg1dBAQItAuUdLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztl0h64uLhecwaWnw9rNLOpYSIMinzw5Lasfikc0QeI=;
 b=HmJXG/pLyOeF9IO8WIDwbB+Qmy2/JoGPYqhuhGuracSk6D9L5ICbMDyierdEKwNeZIeu7vpABneKKRd/2tQAFIPBQSeGaArPp6+SAZdkhpuGH/NzlQjQSyi9fXZ3jCVd+F2QICkrIzFPcBaGU5jJrvwJx3PGlf0A8zHLBEHD/gOM31tXWlsN/isqfGfa5s5M0y+IeF/NiSiIaB9hACO8wUyUTG06XM89tKuxltOWVlerSx32fZmV+aLFgrX1pGspyVYEttQeqBReUipse72wSXS9k9SD1hC0HtQmybjTxEyJzd46rF0mkqt8yHmrqFhpnBQoWqk2ntxhkUHBp5k0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztl0h64uLhecwaWnw9rNLOpYSIMinzw5Lasfikc0QeI=;
 b=DhtQYRE+jOM+ZGRdquGgwmOMkg+3iEHVbmnnWoChLoumkUw1q+EKVvMAMOoX02fQsg0AYAOXamLroqUqi5+meWD+yWrzbFoidOBII05ngLkACe07YgkFCagbLQUSvQpa+1ZlnOon2kC4KNpefhpyDtbdnZZQw2zx9XDEzU9TGFc=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA8PPF2C584C8BB.namprd21.prod.outlook.com (2603:10b6:80f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.1; Wed, 2 Sep 2026
 20:04:42 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Wed, 2 Sep 2026
 20:04:42 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4 4/4] net: mana: add dynamic HWC
 queue depth with reinit path
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 4/4] net: mana: add dynamic
 HWC queue depth with reinit path
Thread-Index: AQHdOkyoLoqALwCy5kOCFjCZG31uALa7twgAgAAA01A=
Date: Wed, 2 Sep 2026 20:04:42 +0000
Message-ID:
 <SA1PR21MB6683A552F3B64B4649D1C10ACEB72@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260901200018.3194525-1-longli@microsoft.com>
 <20260901200018.3194525-5-longli@microsoft.com>
 <20260902200118.793F51F00A3A@smtp.kernel.org>
In-Reply-To: <20260902200118.793F51F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42d74204-3150-4239-858d-2311876ad2cf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-02T20:04:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA8PPF2C584C8BB:EE_
x-ms-office365-filtering-correlation-id: cd5f6e77-7740-4078-453a-08df092d6d7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|3023799007|7146999003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 63JaTbKkvTwcncC54ys3NoWJ7YC7gDn0+eMnyyHzYznHTnGovxwOy+cj146HCBTEPra9mpEqrdzwnMuG0ITtgnBFtWzteN+ZR0eQgEuzWdi76vu4zqOASk6Ll0ntyw/POECt3vT2wWXCCpMc0dCWPQ4hGd/rxwbOdnMVwOmIO/vKz32ZpbLl5xB750FPMW2Cy8WZbPR5JKNuux5W7nC4DRdGRwmIzC9IOodZi9YTbvVQLhc4em0+965tVa3plK1xZV+46OntiUjx6UCZ4p9ApnaOEixWQGam5g2qAJKXiVGUUNq4p22q2FMw3koIdojN4ZI0lDIVA1UE0IMfTZr9qOyA/KEL6WGTkBPF0+8nztLbx/AmM8dTUD4k1QoATqCST8MST+erqmDAa+sDr//qKF1DZ1lAdzrvZImxLUVleRjrdY4IGF9V5iM65iyXEbKAcTJctiMvUNqSZNb8d0auNjzjEdEAtgDDBh3K/PAmlOMEDi3Fyun2l0H4uu60CseA/V3jpUt0YwgzbyxwOP2RzWQ3mpfNzdAeIzNMDygj7Bwj3sKOHfIDPoECW0bnAwRIj9fd/88pXRa/wE6Q0cK80NpxIpbCqBEqo8hFgp1/GIhzy/O5OcLXA+C+0VB+cgHzMvLsLY8OCveWpCsFaEGRGqZ7nu2+GIAgs0h83nNq/TmoA9EElUwdv11g7SdTdXavwacnsGFryDii5F6FqEx5pKrrNZVdVtrNmpgaT1KCD44=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(3023799007)(7146999003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pmq49GITOrKtI3ZFG72T+Vx50HX6bnfQsfOxukKgugt+ePqpsHGu9kwh8oR5?=
 =?us-ascii?Q?OyLT3h6BrglbPutKqB4UxFAxHzCw7cib6gNsskKucbUr63gsXe5pnQT5Mlj7?=
 =?us-ascii?Q?st0avIEWZ9r8AJ9s8YzxDiub1ybkAenCYrZ81KfXx4P1Rz9Iq8UCVw0+p9fb?=
 =?us-ascii?Q?RAxSEKM5c1dvdYJKRyADL6MlrTS+imgvJt8BjYkbYoHdPCoTOtk7WfGE5Zq4?=
 =?us-ascii?Q?3AdUdSj2Z3g3d7lcUc3+B3dWan5//YcHlq/SnL9C3jTolphqcKtg6T3vSSIu?=
 =?us-ascii?Q?EPu6RjJVPbDQT2v5RBjZixXW1qlFekDdLcI5m8lI11U6bVT5U1uSkc7HrW3Q?=
 =?us-ascii?Q?3A0e7TV/bh3jTJbBc8g7DLCb50rhMBeswLWM6E1cFIaRfCpFLJKu4VxcLjoi?=
 =?us-ascii?Q?mIDCkaM417T+wi9P8tjvQ/ToCAmFFsCUcU3pjP2+ebEjAuyKhPZZEKf/xu4Q?=
 =?us-ascii?Q?/YzxPigGAfefj3Sk2htvbpqbswK016piIE18mMgoTY+OWbzrrHc9XQeBEGWs?=
 =?us-ascii?Q?XR66pTYarifIKOYQdkmT4sAzUMvasl5FLgpHnvDkWb8/H2pCUBMwawVRAqJv?=
 =?us-ascii?Q?+uDuBlWdNXJfyvYEoZuaOLEc8l2r5P9/7ii7dPID/9n8HvY10hnmv8m5MVnf?=
 =?us-ascii?Q?RRIkVln5O89AfUkTfrbsyx9pI8GWrbcCprP8BBIR8C+6np9sC22oUS2HToqq?=
 =?us-ascii?Q?Od+rh410mDA/SXx0rqXx3FCLzFPjpwrFdQcW9brTb54yVInMA0j8gsrDvVZR?=
 =?us-ascii?Q?ulaIlNhaFhDkA8JMFav20P3SwPdy6r+uKdYEsenwMIUEM6peFAmw8pmS/ILo?=
 =?us-ascii?Q?CKZXcFJxK+w4YDZvNM1hna3Rt2WXIfjYLE8mxcOY5ytMbcYNQbg7B/QOFOfP?=
 =?us-ascii?Q?Pe5O4QKt93/VaGJoJSBDy7zklhG1JQvw15l9o/XJNB+o1H2Y7DagmYjULhhg?=
 =?us-ascii?Q?OCVqex3FzeUfMKeoq2tTtKL5o5OyD1louTRDJ+3Z2QYepAhkBjlxlgtEAuPQ?=
 =?us-ascii?Q?XlqmvCB67VAs+fV+eQOp0MxGAXTTQksN48b8NE/UjgYGfI0zNxAFxT2Y9240?=
 =?us-ascii?Q?7qpugH2sHpeVwEq1bMkaABIIrxGLocCU7ggY6eRgo/TfWXm6W4eSEr7hlUZx?=
 =?us-ascii?Q?c7D8quw2Is7fB7kroom7SW5fJ79CL2vJSqMqQCg8NyiV/7kri5c/zVWv9jwB?=
 =?us-ascii?Q?q0wnfq2cKS0ny2BBNJItkf4eHTnEFFkfJtJNcmLVqL7oIp+g9jANcvzr/CA4?=
 =?us-ascii?Q?a34mDztLNFIcErnfFGpHlsT8ktua0xAhC1OmfaQbQLTWbV1ix5TsN0KX06rr?=
 =?us-ascii?Q?Dsr/n46zTYoGgElZzm78ciLzbSS+Y5hngcPQ0z3MiSsw+LqkExOnnu4deNVW?=
 =?us-ascii?Q?cnv+cSRSCzf+GurzrKYVZCadrHHMoTEvTUUIObckTYtRNoWoVKLnXhBmYE/x?=
 =?us-ascii?Q?CfagDVZN04EP+DpZTt+eKxmEeprL6T797zy2eU6nrCW3UC5q7spA1Bvc7gqp?=
 =?us-ascii?Q?LDT7yEyvNrQPe4nUNNDL1MDKozM/m2NaehlyoNXQ3LpS5TzjdjGX6UEhfbHj?=
 =?us-ascii?Q?MZiLDZ14HLmmUD2vWLL2Rv9YK2bKlq0/3oCNmwu3AqfjnZJPcGwCI+tHSUXK?=
 =?us-ascii?Q?OTs9mXnKWoiyNkvqY3l93RgJcoAx/RdGHYU/RlX9aPHO0IGO6B0tngXh4aZt?=
 =?us-ascii?Q?qzYz2IoVX7Thpo2Swg/tAiNzkkOZ5PzJPSsv95lZkbAns39E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5f6e77-7740-4078-453a-08df092d6d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 20:04:42.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEH1P7A/NcMngdrdmZnYQPsEqrqAA+zaBWMHPTUBS7DrYi6oU5me7UQdSllfFQMEaMV9iZbR9timz+XxwIi1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA8PPF2C584C8BB



> -----Original Message-----
> From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
> Sent: Wednesday, September 2, 2026 1:01 PM
> To: Long Li <longli@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next v4 4/4] net: mana: add dynamic
> HWC queue depth with reinit path
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s)
> to consider:
>=20
> Pre-existing issues:
> - [Critical] Use-after-free of `hwc_cq->comp_buf` during queue teardown
> because memory is freed before the EQ IRQ is deregistered.
> - [High] NULL pointer dereference on `gc->cq_table` during HWC reinit
> fallback on error paths because `gc->max_num_cqs` is updated
> asynchronously before table allocation.
> --
>=20
> commit b3057022f465825e22d893f907cd5cd5dd291b2f
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: add dynamic HWC queue depth with reinit path
>=20
> This patch dynamically adjusts the hardware channel (HWC) queue depth by
> tearing down the bootstrap channel and rebuilding it at a device-supporte=
d
> maximum depth. This allows more management commands to be in flight.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
>=20
> [ ... ]
>=20
> > @@ -872,13 +916,64 @@ static int mana_hwc_init_queues(struct
> > hw_channel_context *hwc, u16 q_depth,
> [ ... ]
> > +static void mana_hwc_destroy_queues(struct hw_channel_context *hwc) {
> > +	struct gdma_context *gc =3D hwc->gdma_dev->gdma_context;
> > +
> > +	/* Destroy CQ first to deregister the EQ from the interrupt
> > +	 * handler list before freeing caller_ctx, TXQ, or RXQ memory.
> > +	 * A pending interrupt handler could still reach handle_resp()
> > +	 * which dereferences caller_ctx.
> > +	 */
> > +	if (hwc->cq) {
> > +		mana_hwc_destroy_cq(gc, hwc->cq);
>=20
> [Severity: Critical]
> This is a pre-existing issue, but since this patch dynamically tears down=
 and
> reconstructs the active HWC queues on the main probe path, does it turn a
> teardown race into a reachable use-after-free regression?
>=20
> Inside mana_hwc_destroy_cq(), the memory for hwc_cq->comp_buf is freed
> before the EQ interrupt is deregistered:
>=20
> mana_hwc_destroy_cq() {
>     kfree(hwc_cq->comp_buf);
>=20
>     if (hwc_cq->gdma_cq)
>         mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
>     if (hwc_cq->gdma_eq)
>         mana_gd_destroy_queue(gc, hwc_cq->gdma_eq); ...
>=20
> If an EQ interrupt fires concurrently (or a stray interrupt occurs), the =
interrupt
> handler mana_gd_intr() calls the completion callback
> mana_hwc_comp_event(). That callback will read the freed comp_buf pointer
> and pass it to mana_gd_poll_cq(), causing out-of-bounds DMA completions
> to be written into the freed memory.
>=20
> > +		hwc->cq =3D NULL;
> > +	}
>=20
> [ ... ]
>=20
> > @@ -926,8 +1021,200 @@ int mana_hwc_create_channel(struct
> gdma_context
> > *gc)
> [ ... ]
> > +reinit_fallback:
> > +	/* Restore bootstrap-depth channel so the device remains
> functional.
> > +	 * Free cq_table if it was allocated by a partially successful
> > +	 * establish attempt.
> > +	 */
> > +	dev_warn(hwc->dev, "HWC reinit failed, falling back to bootstrap
> > +depth\n");
> > +
> > +	mana_hwc_destroy_queues(hwc);
>=20
> [Severity: High]
> This is a pre-existing issue, but does this fallback path expose a null p=
ointer
> dereference on gc->cq_table?
>=20
> If mana_hwc_establish_channel() fails after the firmware updates
> gc->max_num_cqs (via an EQ event) but before gc->cq_table is allocated
> (for example, if vcalloc fails or the doorbell is missing), we jump to
> reinit_fallback.
>=20
> In this path, mana_hwc_destroy_queues() is called before gc->max_num_cqs
> is cleared. This calls down into mana_gd_destroy_cq(), which assumes
> gc->cq_table is safely allocated if id < max_num_cqs:
>=20
> mana_gd_destroy_cq() {
>     if (id >=3D gc->max_num_cqs)
>         return;
>     if (!gc->cq_table[id])
>         return;
> ...
>=20
> This will dereference the null gc->cq_table pointer.
>=20
> > +
> > +	old_cq_table =3D gc->cq_table;
> > +	gc->cq_table =3D NULL;
> > +	/* Clear the bound with the table, as above. */
> > +	gc->max_num_cqs =3D 0;
> > +	synchronize_rcu();
> > +	vfree(old_cq_table);
>=20
> --

Those are both pre-existing issues. The patch set implements multi queue de=
pth support and doesn't attempt to fix the existing issues.

If needed, I will submit a separate patch to fix the existing issue. The pa=
tch is not related to this patch series.

Long
