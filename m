Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023100.outbound.protection.outlook.com [40.107.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508A2AE76
	for <linux-hyperv@vger.kernel.org>; Fri, 28 Aug 2026 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875724; cv=fail; b=mQVn5UG1pLmMoWN/6yT9bHL9jaFmo58Fu9idanB9SsfYXjg27/ec7IfxDDheLs3r89XuFZBR9o0OrpJUZMbBHVPZWZfGVqCWJnvJ8LE/7k8LkmjY5jbkJx3FQmrkdzsOkko9kcPO/WZ8T4Tu8G7zI20/ozyoRS/4Y9SF+f11jmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875724; c=relaxed/simple;
	bh=lAlHD4XHTDSHYeXslkKKZQsr/A345jJL8YzMBKRdMOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/YRmvWHgVUWb++X0xjBr5rgeRk1TO4L28nw5jmq6wXefUJyV7Oj26Y2+u67zxcoeIIePKLj9R3QdyBeX+S4SJPIydoNyOrAcqUJ0VLTzwxYGzj56SXm52t/44eGr271axcf4pyJ7RudnozJ/RkJf91kyAPu2reUQau0MA4ezZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fO9Ji1wo; arc=fail smtp.client-ip=40.107.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fO9Ji1wo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWG5bTJ7C2xW2UFyFi8iyZQD53h3o1pA3Z+7jO0/YOLEzQmw5llXpY91RvKPotc6Y5t5dWHYeVFeX2vWlYotLRCnjqNhghCI9RkCH5A7WNos7X6Om6d6jfqfklsHH4fgTsRFnjJl2/kbUWpy82P/SIdjY85mHDe8A2Bo2M8nPeOKB/IRU0JFT5ujnJSQKy/zbBfHLVwOEzWY12kPOOAarK19bcJvS/4fqmXVxoPdbGBu5/T/dUqVv4VG399c6daF+2rJVpTErrzAtelHmyBANh47XjDZcH70ZjyGd5g1bo5euNluTNhWm/STrub70bt8Qm2c5735JkJFK5h88EcwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/vqytL9aasyl6vAdx2FisFUTiFukEmWVWjl/S0CdSk=;
 b=fkR5WCw5XaZ8uPCg1X0QpTyo6oY4mLxTa0VfTv3EKIXXWEE6iPCgVpqg45hq6L0SL401K7yIu17GJsJ08cOi+Z9WH11m8BkHlMuWJVQNqFPIZPQQ3WIdy8Qag3x4zCe44cGpgMHKT18eQb2W2uHyhvg40Hw5rVM2SXGsHkrD1rrLOiSeatE+d2Zf7OzUZ4DZg5AOFSQKzuEC42IVDEOhdW/q9/WEy6b/rRdaDuFQBmxpRNbOEM2un9uEFkw9r+ZSaLoBN8xlE96ZIUv1SJrtd97F7tvF6JdruXkQ3rTD291+Be67TVHghohHGxIErWfVohAoMOfzjj+i9VMYisJP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/vqytL9aasyl6vAdx2FisFUTiFukEmWVWjl/S0CdSk=;
 b=fO9Ji1woTNjlgn2xu5un7m6LHnWCIHTNJ+tnPwzzpkCMzHa2YvRZblMDFngfCyR1nSKZmAnKLtLvDDdolSZ0ufYPR49DfRFdZTIA1jsjZsL1Vr0QrvQko5l7VM27pZGnr54Chr0SrU13BcZNoqhD6b4wULeibQk6SEyIL0bLD30=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by PH0PR21MB3027.namprd21.prod.outlook.com (2603:10b6:510:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Fri, 28 Aug
 2026 00:08:38 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 28 Aug 2026
 00:08:37 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] net: mana: Clear RDMA teardown and suspend
 state in mana_rdma_probe()
Thread-Topic: [EXTERNAL] Re: [PATCH] net: mana: Clear RDMA teardown and
 suspend state in mana_rdma_probe()
Thread-Index: AQHdNbcQFxvvDAadlE26bSWYlZBKD7aylQ4AgAABDiA=
Date: Fri, 28 Aug 2026 00:08:37 +0000
Message-ID:
 <SA1PR21MB668363CAED36F06D8EF8C5F5CEAC2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260826235940.1869565-1-longli@microsoft.com>
 <20260828000033.2BC731F000E9@smtp.kernel.org>
In-Reply-To: <20260828000033.2BC731F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=211e0f96-125e-4a18-9c63-bb20cb367603;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-28T00:04:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|PH0PR21MB3027:EE_
x-ms-office365-filtering-correlation-id: 05ac63ab-6ee1-42a7-2c83-08df04988246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|3023799007|10067099003|7146999003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Af3lGlcIMdMW/hUMAJ7xwpYMrpy1Uj8HM+ww5p2oFlk/0Nf4YN1V1bboQ2SCqGl8HIqPDa9hJb+TsV/BpPmu0a40sTPL91Bc4CkMwnprhzKqyEQOWBLNImBgZ4JbkydnclnxvwkMiNFYZ/H441w4UMYdfgDzlMYbahSZ6XbjfYE021KdvcDpTSlVd3aUsYZHSgv0Y9j0rn6ANizGUJeEw17EqLCV5uetFyFpUxsPFLgvCeJFXtqysgXzTgOOzlVaahrSgfIYaNXfljYsilthstGR1BOLgqEbzVktdQB0CaztH8nPaGvM75/VPqipLoURONJpgHSmyzSafXagkr1I2uI/c7ld3HXMcyPnYS+8VPPvi6NAsxINKqAHp3Lg3aYs3KuUbR22SC0kM8HCoZT84De3W1fpkg8W2sntnX+jzlPm5S1cV9mg2ZgnNqqSKNR54ydef5caTxwekxwpzqFZgevJqy1+2QiEQYHtIir8LQl3C7FZujSFIQWV8x0zj/mZ4jiSM4jNY7+OwPzkKpwcn1cHLaBZrrrmEj41Cc4VJnlQm6Sd8i1wNe7odzHZAMQAOaZ5jVqN4cWeBtCo1oWrVRXNdlJ27xfRNIlNYM5omJbXa22TnZD7ia1Acj/bPy6CIKG/rFOsDNf+DC5EuNYdvgFJ7DnReyjopSLrxlQyp6czO12y94mvR7SE6Vrp2taEQvFI7Dvn+vUYUv8YL7jbCNjB0AU6/eCtdSwkLxW+zgU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(3023799007)(10067099003)(7146999003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cSPKPs2mP425WVDAvK83Zufg+VuOrhWM25YH4Telqc7LTri0EizrvG5sHFx9?=
 =?us-ascii?Q?EusGQhg5h5MIuuy1f9Njv1D7fWm/PkNHpW9A0HixqCFzqizebf3Uu6XQFR/t?=
 =?us-ascii?Q?dlzyMguNpWGmkEs4UdCaLrX+msly0EFO8L1e1m7URrRY6FmX3oxTScV8XRIc?=
 =?us-ascii?Q?ZtsnkywRLjf3oH6Z0JHxKZ1PZeXNGDXIeIt7bZqHNyr29BOqkk5y7r8oYh8Z?=
 =?us-ascii?Q?TrYfBXGSn6HJMbGK+yykATQpodvmNRLuxRNRh7gMhmMWTohPMMvXkKPHdPzX?=
 =?us-ascii?Q?kRLgxyL1CXPCfSMbsj/c4XKOxWh7cGduwGSGqIQJNf5XhYoLwApIr9wcQtzi?=
 =?us-ascii?Q?UEr7oMwp5HidhniMaGBc5+UyNhqI7HOlG2cVByuSPpyE6cxHBidIB1pX6D0b?=
 =?us-ascii?Q?wUqhq9Ulv574CH1CGOAJTojKEIuaomc/fRdLUINrIygzj7L+PHCEL8uNIBDQ?=
 =?us-ascii?Q?u5RC/sOJS7O9sSYStnxWVHYxMUtWlRA/jCT21WoVrWZlZeOyHY0o51GWnntt?=
 =?us-ascii?Q?9QxpwCXGZbS46Ct0gWuF7ppKJho7JIBQlmaBHouB811eB/IynybNQhQTNUrq?=
 =?us-ascii?Q?mukhHg1QkN7KjAV4VRY5n0pLlgjr2U9MscYebWlvTcA9aOYlWU4+b/nLVrSr?=
 =?us-ascii?Q?kWlKhBbTBWvkm8Ei12STdux/Er1FVxx7Y9zyduzQzuK+MDnFcoU7VFce+6ck?=
 =?us-ascii?Q?4hibhVTysiedXMewOZPdjHnBs+O14zebjjZ5QnvFPQQ1hntDBCmOBOU2FHO1?=
 =?us-ascii?Q?l02eBfCQQyvF6iVTL/GMEZX8/E/Hg0WD9KMZikium9YTSg4qrKxU/S5A8QQn?=
 =?us-ascii?Q?dB0Te8soHukLDgvxpRTowzkjUfFCfR11DrFrnG0+OQHS6RYwlQNCViJVP2be?=
 =?us-ascii?Q?86AcaZcTsaNh+3R3bIbgBZ/+AntVfJ85B9ltvyr1kVbofOM09DiNIT1/sW4B?=
 =?us-ascii?Q?mXd0jy8s7TC7/n8IfFo2kJpICtcCaBMFE+RJv70eNL5DitiEqGi0d0L9qwP6?=
 =?us-ascii?Q?3Axt7BdECSFYW6WVHqKzGcp9+PP3smnlOjvSM6rZ+2EG1chZWyXOMN1uvMZI?=
 =?us-ascii?Q?jBSiTFOqNdnw4zBMjime/0aAjLDze89DvYmohT+fUjdnVL6GeV3eXGAqxkFV?=
 =?us-ascii?Q?DzZ3sG9IJR/BK8cmugmjZ3s+5J7p8RKbYMEoWrhCAl/GReP96Zcob526tOL4?=
 =?us-ascii?Q?vo0xxjQh/9emyMTq4+T95DIdA3RzPpl12pKCOWQGoPeeM6lI18s4EfCHVLCv?=
 =?us-ascii?Q?/nR9v+RV0RwqB+GhjJzOMvkui1//7Q6g2YzYSggKxzjN0biOrWoNzJpRTjuP?=
 =?us-ascii?Q?mUYI2+mTUoGiCLlfmASu+MAY/E36CJU944OBy1Xl2km+w0JIE7YGJOyvOdp5?=
 =?us-ascii?Q?mY+ESzqKykZA1Z1SZZjeAFZKBcuxZ3KxtQJrVSyVPrlySKKqSoK2VnUQ4qgk?=
 =?us-ascii?Q?xZcC1kTs+AEzdKUOYW5RNhyVOHsG77jbe3oz410ZmrdiJp/wkWjFsEdvksha?=
 =?us-ascii?Q?UDZEjCMIYxFUK4+9v/zBE6Yp0oI5lZI5INveF2Fy99531/UwFp7e9t5qVR+j?=
 =?us-ascii?Q?5LEH5XQ1yP5uacpSnxPtA4aKaj7iUmor7Txx77jFxIopXPyIBjc1d9dbdImj?=
 =?us-ascii?Q?2yJoD3PcPw4h34gs4QfTNEWjHIdtmC78MBSt2y26yAjINmUP5BlPLLSGXT7h?=
 =?us-ascii?Q?bfY+zu6Ev4BaWVNg5gtFx80rud6hbiFg875Zb00G8SioFsNv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ac63ab-6ee1-42a7-2c83-08df04988246
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 00:08:37.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaaiwTDxp9vSVv7VJbECA52GT886OQ8OUqy/Ub4Vw3DiVgC2vcsPoptbt7RrWmRUtyt3KXjclg5LypErWcBn6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB3027

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [High] Lockless access to `gd->adev` during probe causes hardware SUSPE=
ND
> events to be silently dropped, leading to a state mismatch between the ho=
st
> and hardware.
> --
>=20
> commit a413863cad4d3b91f96dce2e01b3fa3e47e6054e
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: Clear RDMA teardown and suspend state in mana_rdma_probe()
>=20
> This commit clears gd->rdma_teardown and gd->is_suspended during
> mana_rdma_probe() to allow servicing events to be handled again after a
> reset cycle. It uses smp_store_release() to publish the state before addi=
ng
> the auxiliary device.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 7a1ac853e3abc..56f426da72864 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>=20
> [ ... ]
>=20
> > @@ -4279,6 +4280,17 @@ int mana_rdma_probe(struct gdma_dev *gd)
> >  	if (err)
> >  		return err;
> >
> > +	/* Clear the state left by a previous mana_rdma_remove() so
> servicing
> > +	 * events are handled again after a reset cycle.
> > +	 */
> > +	gd->is_suspended =3D false;
> > +
> > +	/* Publish is_suspended before re-opening the gate, so the handler
> > +	 * cannot act on a stale value.  Pairs with the smp_load_acquire()
> > +	 * in mana_rdma_service_handle().
> > +	 */
> > +	smp_store_release(&gd->rdma_teardown, false);
> > +
> >  	err =3D add_adev(gd, "rdma");
>=20
> [Severity: High]
> Could clearing the teardown flag before the auxiliary device is fully ini=
tialized
> cause hardware suspend events to be silently dropped?
>=20
> If a GDMA_SERVICE_TYPE_RDMA_SUSPEND event arrives from hardware
> immediately after smp_store_release() clears gd->rdma_teardown, the
> handler in
> mana_rdma_service_handle() will be able to process it.
>=20
> However, because add_adev() has not yet completed and published gd-
> >adev, the lockless check in mana_rdma_service_handle() will see a NULL
> pointer:
>=20
> mana_rdma_service_handle() {
>         ...
>         switch (serv_work->event) {
>         case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
>                 if (!gd->adev || gd->is_suspended)
>                         break;
>         ...
> }
>=20
> Will this result in the handler breaking out early and dropping the suspe=
nd
> event locklessly, leading to a state mismatch between the host and
> hardware?

Thanks for looking at this. Some background on what the patch fixes
first, because it is the same code path.

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
