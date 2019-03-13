Return-Path: <SRS0=yslr=RQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F287C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEFD214AE
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BeWe1eD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCMNip (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:38:45 -0400
Received: from mail-eopbgr710121.outbound.protection.outlook.com ([40.107.71.121]:63061
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfCMNip (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Mar 2019 09:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQCuTV970LwVL+1CgSBi9/HdZb/goljVsXvScT+92sY=;
 b=BeWe1eD7PMMFLfM49yQlrPQZuxjzHeJzFNpHkdR9jcf7ltHwoZAbvMUMUUWAOmfxRmxp7Hkzqmj8FWPN0aZ/5DCogTci0960qK51UpgzDobJ4TJMOX8sz/LwAZPnzwm0lnFGjVbfTQ5idDk7fUYXEYcxVv/YLoi/elc8Sj5eBHk=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1062.namprd21.prod.outlook.com (52.132.128.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.1; Wed, 13 Mar 2019 13:38:41 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1730.000; Wed, 13 Mar 2019
 13:38:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: Move Hyper-V clockevents code to new
 clocksource driver
Thread-Topic: [PATCH 1/2] Drivers: hv: Move Hyper-V clockevents code to new
 clocksource driver
Thread-Index: AQHU2Rx2S98qkJLCu0aTdca3djLhy6YJOzGAgABQGlA=
Date:   Wed, 13 Mar 2019 13:38:40 +0000
Message-ID: <DM5PR2101MB091897108980449F12FDDB3DD74A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
 <1552426813-9568-2-git-send-email-mikelley@microsoft.com>
 <874l87tbz2.fsf@vitty.brq.redhat.com>
In-Reply-To: <874l87tbz2.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-13T13:38:38.7572502Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b36b2f8c-7d03-4b05-be7c-f306ba152f88;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb3a67f5-72a9-4000-ec9c-08d6a7b9347d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB10629F49625D7826D697FAC2D74A0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(376002)(366004)(346002)(189003)(199004)(14444005)(74316002)(52536013)(71190400001)(2906002)(106356001)(86612001)(54906003)(256004)(53936002)(9686003)(4326008)(86362001)(6916009)(7416002)(105586002)(55016002)(22452003)(305945005)(316002)(7736002)(186003)(8936002)(97736004)(5660300002)(486006)(6436002)(71200400001)(478600001)(81156014)(10290500003)(14454004)(3846002)(8676002)(7696005)(229853002)(66066001)(10090500001)(11346002)(6246003)(33656002)(26005)(68736007)(107886003)(6506007)(8990500004)(446003)(102836004)(476003)(6116002)(99286004)(81166006)(6346003)(25786009)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nkNN6oNF4GYhD8IRRqvKW61dI7E2jxp6QvBR1d8b5lwFzGuEJAZuKCT1zUah6sLhfDogA4FLfImWJwzh5uUGToXa1w2QVcz55xiMbjCwZZNlzlGIzeEeOoD0Y1idwjyMoiy+d6EfiVTKGA36cb2wxpurcs7yttXCYKNE62UAa/SsfibJsWRhZloRMv1FpZZrPZOo/VUb5EsVI4gSK4lurOiWvpacGcld9PQlQXJyvr62cuCPWm2kwmsPef0/3qM09lzL/uympXpNFswPoCTqIVnT7T3pc/wpLdz1LtpwmLQSsp3dWCOiD3Dbl629PD3ZwJ0yNgITlvL1yr2uJXFfw6N7xo+bRHZupDnm5QADDspKr7ZrAGNhW5BGHhQRnBEM5nHfMaX2J6ESIWtuGvUZdhZKaRAM5kXBtnoM6Wi1p08=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3a67f5-72a9-4000-ec9c-08d6a7b9347d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 13:38:40.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, March 13, 20=
19 1:28 AM
>=20
> > Clockevents code for Hyper-V synthetic timers is currently mixed
> > in with other Hyper-V code. Move the code to a Hyper-V specific
> > driver in the "clocksource" directory. Update the VMbus driver
> > to call initialization and cleanup routines since the Hyper-V
> > synthetic timers are not independently enumerated in ACPI.
> >
>=20
> I like the idea! Would it also make sense to consider moving Hyper-V
> clocksource from arch/x86/hyperv/hv_init.c? The thing is that we use it
> from arch-independent code (e.g. seee 'hyperv_cs' usage in
> drivers/hv/hv_util.c).

That's what the second patch in the series does. :-)  But let me
know if there's something you think I've missed.

>=20
> Nitpicking:
>=20
> This has nothing to do with your patch but we have a mix of 'stimer',
> 'timer', 'syntimer' names when we refer to Hyper-V Synthetic timers, it
> may make sense to try to converge on something (stimer would probably be
> my personal preference but I don't really care as long as we use the
> same abbreviation). Examples:
>=20
> hv_init_timer_config(...)
> HV_MSR_SYNTIMER_AVAILABLE
> HYPERV_STIMER0_VECTOR
> hv_syntimer_init(...)
> ...

Yes, you are right about the mish-mash of names.  I also like converging
on "stimer".  I'll certainly change things like hv_syntimer_init() to
hv_stimer_init() as part of the patch and avoid making the problem
worse.

What about the name of the new .c and .h files?  They include code
both the stimer-based clockevents, as well as the Hyper-V
reference time source based clocksource.  Stay with "syntimer" or
shorten to "stimer", even though the code is slightly broader than
just the stimers?  (which highlights the generic Linux naming issue that
"clocksource drivers" include code for both clockevents and clocksources)

>=20
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefil=
e
> > index be6e0fb..a887955 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -83,3 +83,4 @@ obj-$(CONFIG_ATCPIT100_TIMER)		+=3D timer-atcpit100.o
> >  obj-$(CONFIG_RISCV_TIMER)		+=3D timer-riscv.o
> >  obj-$(CONFIG_CSKY_MP_TIMER)		+=3D timer-mp-csky.o
> >  obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-gx6605s.o
> > +obj-$(CONFIG_HYPERV)			+=3D hyperv_syntimer.o
>=20
> (just a couple of spare thoughs)
>=20
> CONFIG_HYPERV can also be a module, are we OK with that? (we'll have to
> support module loading/unloading then and honestly I see no reason for
> that. I would prefer everything but VMBus devices to be in
> kernel.) If we don't want it to be a module we can create a hidden
> CONFIG_HYPERV_STIMER or something like that - just like we already do
> for CONFIG_HYPERV_TSCPAGE.
>=20
> There is, however, one additional dependency here: when running in
> non-direct mode, Hyper-V clockevent devices require functional Hyper-V
> messaging - which currently lives in VMBus code so that may explain why
> you may want to keep stimer code in the same entity. Or, alternatively,
> we can move Hyper-V messaging out of VMBus code (is it actually
> architecture-agnostic?)
>=20

I thought about introducing CONFIG_HYPERV_STIMER, but in my
judgment it was just unnecessary complexity.  The Hyper-V clocksource
driver can't exist independent of Hyper-V, and vice versa.  When both the
clocksource and clockevents code is considered, the VMbus driver and
Hyper-V initialization code has to call directly into the driver since the
Hyper-V synthetic timers and reference time counter aren't independently
enumerated.  Even if we could get the Hyper-V messaging out of VMbus
code, we would still need the clocksource initialization call directly from
hyperv_init(), which is not in a module (see the 2nd patch of the series).

Michael
