Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022078.outbound.protection.outlook.com [40.107.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BB327BF8
	for <linux-hyperv@vger.kernel.org>; Sat, 29 Aug 2026 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787967301; cv=fail; b=S+hm9oSIdQX5PkBriTKeOBlm/smlANoGzWQtxJj7oYKuLI0nl+6vV98z7v2+2JQaN38SBUUPFDlEUxWh68S/iS+FlYkFwAMn+UBv84wswkL1XAmwYc+eGmXh4SZgxtbOr6UfjV7gsFnoOvqJovmkXLQPFxNyRKIpOKnLNeIJHfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787967301; c=relaxed/simple;
	bh=ABG6YjE7wNIcOLPVk6oUo45jw8UDtV379DFCeI4cXJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R/bi2bF4sjafU6OdIrI45Hd6uyhx1ePrIrpsIj7dwcGa9ec7k0NsS6Jkh/Qke93VU2ZQl2Yz5lURfsTrBs9QGPPw+oe0iCi09yq/UqNb7Ek54rjUcn3IMibsblzhn+/diFWv29mRMua4qrTlNTeEFO52dPFNOlqRacgTIV8m1KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jGZw2F45; arc=fail smtp.client-ip=40.107.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jGZw2F45"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRAIYHC//YP3JnqlcRNq1aYjZB+uZ1LEIFkhoch/GgVThwFh5JtB6lI93S8HJXECxZmP6EGbv7KWsnwEmCffiLx+TCbyVhSmZESy+k1nTODKF416re4FyJQL0w0Gj2fxyjyYafRDbZmN94YKzV2UCfrbak3Z4kjYrHL30ko06yWPKMISkPlVgEGsT57POL3hJSGOLaDVas/9d3BjZiYIQizxlXlZhccL2sn0ZYjfHOooc85uScfJu4WQCsYFXWolTianNXkEXseMKA8TU2qEDj3sr0ZszFuRgnQEqX55KjuDlju62ZiOGvrhffLYagERMQ60lT9xBLGl7jw47kPP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18aCGySYmMphuKiLIZFTMSIfaJ8pRzQcDnb75z620X0=;
 b=rrH5j9kPQ6Oi4g903U3lGpLen9DLslaStHvjswcchPzf+I3I0iaVAJH5nPbFomHhmq49GDhy8a7EV+T1GNhbaPBxzIBWlyE3w2FljZR17D/rm5vZV/2LGknsLf56/kpS/l9Ew1aZgfivMRUq8fsax8h5nEj1PB8qgLwqYMJecNljKxdGLm1CGFhNcsDpkIzUc6lY6+zQnydBnlalWkftParubTcmp1naNEO59ycIC2SF8uZ3xmpLXzX0B0EbpfPaqJgVZO1filFmKzBMlD57D/81CtWpxEAA/aUlh2SkH10iLnkCh3vbb47xy9wnVHvv3LDL4hwCRFdWcmBQQ0DVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18aCGySYmMphuKiLIZFTMSIfaJ8pRzQcDnb75z620X0=;
 b=jGZw2F45Vf6hEVgKwsJMTfrzU/7Oyco3KXc8QKIRhJmTeaTRzVJnx360e+TN1xLqEfHC4n3t5IxpaW/9Ectm84luoPWp5p9xOpfTFG71mC+C7UzJnIz3vHpSt7+OCWb/1XGQ98wyc6cSVUKFw7I854dkwC/PTx0KhgbxJCFRK0c=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6922.namprd21.prod.outlook.com (2603:10b6:806:4ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.4; Sat, 29 Aug
 2026 01:34:57 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Sat, 29 Aug 2026
 01:34:57 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net v2] net: mana: Clear RDMA teardown and
 suspend state in mana_rdma_probe()
Thread-Topic: [EXTERNAL] Re: [PATCH net v2] net: mana: Clear RDMA teardown and
 suspend state in mana_rdma_probe()
Thread-Index: AQHdNoHyJHxYt4xOt0q521Qs+wjjDLa0KTmAgAAWePA=
Date: Sat, 29 Aug 2026 01:34:56 +0000
Message-ID:
 <SA1PR21MB668308F94FC2E0B22128A3C2CEAB2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260828001202.2110938-1-longli@microsoft.com>
 <20260829001247.A56A71F000E9@smtp.kernel.org>
In-Reply-To: <20260829001247.A56A71F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=45e25057-cca2-4133-a3c1-800e6693ec1a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-29T01:33:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6922:EE_
x-ms-office365-filtering-correlation-id: f73e8564-6689-46c4-9fa6-08df056dbbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|3023799007|4143699003|11063799006|4133799003|56012099006|7146999003|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 i63uKkJaZR3neKPIdxaMlHedWRiZG4tgkqrAKC58xn1dCCpguSzB6JUVOdtkkMOyw2xxPtpShTbw75kz7//U5LEjXiSETN126GNsBAk3ZJMiSCM8gyIiPl2SDRfJdY5ei67Jtbyc3JXDSlBEUCNXRa0FpPwjqfcpdgZNV471W5DNcrlMnAboAOtaGdL5q/KbKkQ04E/v/uLqFImFYUBWOEXa8D9MfHWb6mVmqGcN9wK6wqMbDFHVmPRpGjcQwwAdRMl4kkH2urAuvRAVMAPg53N/memC2bK5YV7is0TylIoQZl37uuXxrJxR3h5yjO4VWfvR8NQrYcNMf3Or2BJsSO7kDH5MIBegcEtucu2BzdEdcJwOPsINbD+15mT+PFNfT9u31O/CGMSh1dXJMgY7wjG88mMlBpC+NkNaOIkpPDJnGYnSrqmIyeS1yQIHOR94dxSSr/7UdUYh8+5TAx56I7pU2+7mE/PhuB/SCrLoejn1ldLsT0hol1PC7rH0ejwgpyKj80eksWnTocicgJsvvRGHP3GtiWx4EjKwkFeQMt+rOpAf7NpmYCixsrK+FP1YL3vDo79e832TvAcvJMcITNyhRnqZiQyDEfBnufijpnZBE1/fupD1qXw5o68ILc8uZgFCK1J4E5EivSpj79oBaVSl5GUXnktPyVeJBra+dV4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(3023799007)(4143699003)(11063799006)(4133799003)(56012099006)(7146999003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wTj5OwBFqP2hZmqW5tJiX8+lpfVgvkopyI3Kwl4GWoY5ookWBDp5i3jc5p8m?=
 =?us-ascii?Q?dSiY1CqQIbWtllGRG/LcxzttdoQYvh2Hy6DjxEPSyeyKyLVcJBbRLZOFI2il?=
 =?us-ascii?Q?Pfik/QZFyKHbs6uOkvv3t1l+RGD/uXva3IcKaVeSgNhlDx9Omo1i7ZjjZXVC?=
 =?us-ascii?Q?j1TEogn8+y0bR80tDf7JnuCp1T0029dh24njyekXjPO7zO+v1/qsZqNU/+n9?=
 =?us-ascii?Q?LGwRM9GnUrDBuGkGIlPaHO4TikDDpHOMHCmDTsLb5N5UvWTH/YM23cMk/tF2?=
 =?us-ascii?Q?9fv3L+QQmp7SsrdJbBqzQjWditkWGzFemB3OphlWNU0jI3dhCKZbek+owHYm?=
 =?us-ascii?Q?qt58tOMqZx7aIEhwrBD/Qv7298G0HuqIPAeRlvamEPTjaen3M1swXdkH41j+?=
 =?us-ascii?Q?TZs41V8Na6UWItYI0uMWiUuKVKmFS64ve/GG2qwNNfpjwT8zmpPQj5uKpcIV?=
 =?us-ascii?Q?tPIguI80rPgph/t3FnoKmWNp0tLj2sR68lR6eZMiSVlUtD8XhqCetT/QI8ZO?=
 =?us-ascii?Q?x55/TRqoi1lE95hiKDk1VCntgXX+OM5dUrK8ym/BYtWPS1ha9z2Y/iERIzBi?=
 =?us-ascii?Q?oE6kjRPTJyUvMQQfgltxkZVtPrgB5zWBXjO0VoCVuzrQ4kDkNoznO6soqI9q?=
 =?us-ascii?Q?XK0bbGKZpqgVYOvkTzalodCDEXyj5OODN+RGW2wfWW5Hdc3srbrIIFHibN22?=
 =?us-ascii?Q?PoEcGUO9CGcpy0F6d4BoHfOkABIqJTIIYmsudwuq/kxfDq9dVkOaajQ/ZcWk?=
 =?us-ascii?Q?iRRmSlJL1lj8DF86jCOgYON3b8cjlTHHH2ND7CeyB5hJnxTZDxtA2L5bPobc?=
 =?us-ascii?Q?gvPbhRM+13hL2Cj5kZ88upuWp84QnkHVaEat3nIzjTQ4IBD0l/8On3t6ECh4?=
 =?us-ascii?Q?Hn6o0Z+sIt0dZwGl6bED6dlWdw835CJyGc3TCQd+uJfUyLXGKtaNwNMh03CJ?=
 =?us-ascii?Q?MNv5Qa6POvYJEWsFz+lgPSyLKuhWMGx0Ftr6o/yKEAJA0fKqEvGUlL9K+zQf?=
 =?us-ascii?Q?svjYkxfgKYYIthbqVJrbgog9ynuYJDT/CLC7QiW6Teju/h75O/Rs7rQ2FBW0?=
 =?us-ascii?Q?tvc3V1dMCYLbuw0RXXey5+E6jUjL2oEwhaNhldfXizNc+6tA0UD0+oWyyS6p?=
 =?us-ascii?Q?oSTfWc2yeWiEMhsfoH/xl3d5KfDFK5u0Sn3TGIi6Tjj4la7Nyq02WxgtXb6L?=
 =?us-ascii?Q?8IyXvcEe8xAaSojKY5iqzak6B568uweGXIli20sf2DwhtFFQyTJ63V//NBUK?=
 =?us-ascii?Q?KRYcHhrP767hy+2YKhQ9NC0Wa/FMooihGvkTiZj5Znp46aDA8Y//CL3HsA7r?=
 =?us-ascii?Q?CqQG+/5t+wLr6yf7D+EGfOZwWFuSiNkgTk1CwP7DPH+bX13wiNwQ7JAvDCGB?=
 =?us-ascii?Q?2iykiKtHSWCCsDqUl7V9Y2WQBM85OCeQjyl0FI0C/CSCk70MnLXXOUQeAXco?=
 =?us-ascii?Q?0rR0TDMuLOOlMwD3VOqrIHwnM653ebOAVkfGFsyPeXdIjdhP/ezkU78MeezW?=
 =?us-ascii?Q?58BBTC2fYeHNn4TCCd9O6lqM7lMow3wYKF9d65vWguz6iLN8grrMMiaPes+7?=
 =?us-ascii?Q?YVsxbwBPfvK6D1wo95eEFo8LPC5GAMldqHO2eX7jrqSY+aTW9fGtOYoCVVWr?=
 =?us-ascii?Q?TMUciUh2IQkEsFQAnlgGWIKYpvMGoyYKWhpphQr7+YZRZsmEHOTd/Tq3o/2u?=
 =?us-ascii?Q?61r0Xb7Kwy41HeYZgtdP4gwGrT8wA25pUwn31T8tfHi5YvA+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e8564-6689-46c4-9fa6-08df056dbbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2026 01:34:56.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D15VpwW/C8CMpFn0P1sjSRQuBoUcBEYYLyCrbcbEo86SjhEQxLBVjlXiIDI8/CP2zqtovGsWK+sSH5T+2yqGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6922

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [High] Lockless gate reopening in `mana_rdma_probe()` exposes a race
> window that can silently drop hardware service events.
> --
>
> commit 92507b04de784a341e9ea7d0275d9b3dbe00e839
> Author: Long Li <longli@microsoft.com>
>
> net: mana: Clear RDMA teardown and suspend state in mana_rdma_probe()
>
> This commit clears the rdma_teardown and is_suspended flags during probe
> to ensure hardware service events are handled correctly after a reset cyc=
le.
>
> Link:
> https://lore.ke/
> rnel.org%2Fall%2F20260826235940.1869565-1-
> longli%40microsoft.com%2F&data=3D05%7C02%7Clongli%40microsoft.com%7Ce
> 4ad1794c21a42eae10608df0562428a%7C72f988bf86f141af91ab2d7cd011db4
> 7%7C1%7C0%7C639235591719595495%7CUnknown%7CTWFpbGZsb3d8eyJFb
> XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
> pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DDgiM6eURZJPqg1Kw%2F107
> aSEqL3jkvp3JzFytQ6oXEJ4%3D&reserved=3D0
>
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 7a1ac853e3abc..56f426da72864 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>
> [ ... ]
>
> > @@ -4279,6 +4280,17 @@ int mana_rdma_probe(struct gdma_dev *gd)
> >     if (err)
> >             return err;
> >
> > +   /* Clear the state left by a previous mana_rdma_remove() so
> servicing
> > +    * events are handled again after a reset cycle.
> > +    */
> > +   gd->is_suspended =3D false;
> > +
> > +   /* Publish is_suspended before re-opening the gate, so the handler
> > +    * cannot act on a stale value.  Pairs with the smp_load_acquire()
> > +    * in mana_rdma_service_handle().
> > +    */
> > +   smp_store_release(&gd->rdma_teardown, false);
> > +
> >     err =3D add_adev(gd, "rdma");
>
> [Severity: High]
> Does opening the rdma_teardown gate here create a race window where
> hardware service events can be silently dropped?
>
> Because mana_gd_register_device(gd) was called earlier in this function, =
the
> hardware can now generate events. If an event like
> GDMA_SERVICE_TYPE_RDMA_SUSPEND fires immediately after
> smp_store_release() clears rdma_teardown, the ordered workqueue will run
> mana_rdma_service_handle().
>
> The handler will pass the rdma_teardown check but evaluate !gd->adev as
> true because add_adev() hasn't completed yet:
>
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_rdma_service_handl
> e() {
>       ...
>       case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
>               if (!gd->adev || gd->is_suspended)
>                       break;
>       ...
> }
>
> This causes the event to be dropped, which could create a permanent state
> inconsistency between the OS and the hardware. Should the gate be opened
> after add_adev() successfully assigns gd->adev?
>
> >     if (err)
> >             mana_gd_deregister_device(gd);
>
> --
> Sashiko AI
> review * https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%25
> 2Fsashiko.dev%2F%23%2Fpatchset%2F20260828001202.2110938-1-
> longli%40microsoft.com%3Fpart%3D1&data=3D05%7C02%7Clongli%40microsoft.
> com%7Ce4ad1794c21a42eae10608df0562428a%7C72f988bf86f141af91ab2d7c
> d011db47%7C1%7C0%7C639235591719616083%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D3TUhCla0LzwnJhxJ
> NJ5xptY5YUbnLeiax%2FT4HpHRpFA%3D&reserved=3D0

This is not an issue introduced by this patch.

Some background on what the patch fixes first, because it is the same code =
path.

There are two bugs, both in state that outlives a reset cycle.

gd is &gc->mana_ib, embedded in the gdma_context. A hardware service
reset runs mana_serv_reset(), which calls mana_gd_suspend() and then
mana_gd_resume() on the same pci_get_drvdata() pointer -- gc is not
freed and reallocated, so everything in gd survives the cycle.

1) rdma_teardown is set by mana_rdma_remove() and never cleared.

   mana_gd_suspend() -> mana_rdma_remove()  sets rdma_teardown =3D true
   mana_gd_resume()  -> mana_rdma_probe()   left it set

   From the first reset onward, mana_rdma_service_handle() returns at

        if (READ_ONCE(gd->rdma_teardown))
                goto out;

   so every GDMA_EQE_HWC_SOC_SERVICE event is discarded for the
   remaining life of the device. RDMA suspend/resume servicing stops
   working entirely, and the host and hardware disagree permanently.

2) is_suspended has the same lifetime problem, and it is the only
   guard on the resume path -- note that the RDMA_RESUME case does not
   also test gd->adev:

        case GDMA_SERVICE_TYPE_RDMA_RESUME:
                if (!gd->is_suspended)
                        break;
                ret =3D add_adev(gd, "rdma");

   If a reset happens while RDMA is suspended, mana_rdma_remove() finds
   gd->adev already NULL and does not touch is_suspended, then
   mana_rdma_probe() re-adds the adev. is_suspended is still true, so a
   later resume event calls add_adev() on top of a live gd->adev.
   add_adev() assigns gd->adev last, so the pointer is overwritten and
   the previous auxiliary device stays registered but untracked.
   mana_rdma_remove() then only removes the tracked one.

   Today this is masked by bug 1: the handler never gets that far.
   Clearing rdma_teardown alone would unmask it, which is why both
   flags are cleared together.

On the window you point at:

The !gd->adev check is not modified by this patch, and the race is not
introduced by it. It already exists on the initial probe path in
mainline: gc is vzalloc()ed, so rdma_teardown starts clear, and
mana_gd_setup() creates the service workqueue and enables the HWC
interrupts (gdma_main.c) before mana_gd_probe() calls
mana_rdma_probe() -> add_adev(). A SUSPEND arriving there passes the
gate, sees gd->adev =3D=3D NULL and is dropped, with no patch applied.

Before this patch the reset path did not reach that check, but only
because the gate was shut forever and the event was already being
dropped unconditionally -- along with every event after it. So there is
no input for which this patch loses an event that mainline would have
delivered; the set of dropped events strictly shrinks.

Closing the remaining add_adev() window needs probe to be serialized
against the service workqueue, or the pending request to be latched and
replayed once gd->adev is published. That is a behaviour change to the
servicing protocol rather than part of this fix, so I would prefer to
do it as a follow-up patch.

Thanks,
Long
