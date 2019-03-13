Return-Path: <SRS0=yslr=RQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FF8C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 16:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4992075C
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 16:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dU6WfXXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfCMQUD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:20:03 -0400
Received: from mail-eopbgr810130.outbound.protection.outlook.com ([40.107.81.130]:48032
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfCMQUD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Mar 2019 12:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u4Fvf9zrzoO3VClkrpM8uWo1TE4WMX3bCMCbCILY54=;
 b=dU6WfXXdH2ZvEnPxlr8x/67VPX1/nAVXzrBurli7U/6Uw8+DRils6u9oBq7lCFhyZcE9oSYV11whSd9nQiq6+RXUVm7pqGOTDp4Xhbdj2Wg1aSOvMsa6AQOT4S1CLMxDW51gQt+93bSWzg2bppz2ZKS7lXb+NfB+tJWhFEqSH2g=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1127.namprd21.prod.outlook.com (52.132.132.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Wed, 13 Mar 2019 16:19:16 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1730.000; Wed, 13 Mar 2019
 16:19:16 +0000
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
Thread-Index: AQHU2Rx2S98qkJLCu0aTdca3djLhy6YJOzGAgABQGlCAABMHgIAAHdCA
Date:   Wed, 13 Mar 2019 16:19:16 +0000
Message-ID: <DM5PR2101MB09180753D788F8587B19B993D74A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
 <1552426813-9568-2-git-send-email-mikelley@microsoft.com>
 <874l87tbz2.fsf@vitty.brq.redhat.com>
 <DM5PR2101MB091897108980449F12FDDB3DD74A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <87pnqusvjq.fsf@vitty.brq.redhat.com>
In-Reply-To: <87pnqusvjq.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-13T16:19:14.3821466Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=185ee705-5fea-425d-b477-d36d7db9b8e6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a63e0a1e-72b9-4a84-12c3-08d6a7cfa3bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB112715377386D4834AD7CB70D74A0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(51914003)(3846002)(2906002)(6506007)(52536013)(53936002)(229853002)(6436002)(55016002)(186003)(9686003)(8990500004)(5660300002)(6246003)(6116002)(107886003)(10290500003)(93886005)(74316002)(97736004)(478600001)(10090500001)(4326008)(66066001)(256004)(25786009)(14454004)(71200400001)(7416002)(71190400001)(33656002)(305945005)(86612001)(316002)(54906003)(7736002)(22452003)(106356001)(8936002)(476003)(486006)(11346002)(446003)(8676002)(81166006)(81156014)(105586002)(26005)(68736007)(6346003)(99286004)(86362001)(7696005)(76176011)(102836004)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M0ZqQLPmj4ZPkz/uRD8WceS5ywssGp5uVn/9+4PhfDZ1EC9U5x2xi6KgaiekiN4mBBOycp6exGa2pIHVvYHj2Ojf+wMX+fse2T6zICNuw11yfdzmxD0EanYiM5/s7sL+Nc8p1tssyhYMeWuVXAGWLhrpXndDAuS+muBdkm8Cap3ZKcixZLs538zWdELVOaC7SVUs/cmrKx31cUjpNwnGEQvDmWJbIx8m4XUw0A0CV5Pqk/Ca38/clL9wdz1oI18RrjgbcDxZY7HqxXFn74Mdueqj5ORSlpRjBKh/qjnqv/H+PiEG8RBUanTMi3S3IYnB/YvYYznjb/9aazIB2Qc9yJ47ZwiQUSeuXyHGRcJ2r71o27aaPWf3VIFROcxhdej/VcL77mkPMLt44RE71PhSzTfNXjj2Cu1YoMOMM5CnH8o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63e0a1e-72b9-4a84-12c3-08d6a7cfa3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 16:19:16.5461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, March 13, 201=
9 7:23 AM

> >> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Make=
file
> >> > index be6e0fb..a887955 100644
> >> > --- a/drivers/clocksource/Makefile
> >> > +++ b/drivers/clocksource/Makefile
> >> > @@ -83,3 +83,4 @@ obj-$(CONFIG_ATCPIT100_TIMER)		+=3D timer-atcpit10=
0.o
> >> >  obj-$(CONFIG_RISCV_TIMER)		+=3D timer-riscv.o
> >> >  obj-$(CONFIG_CSKY_MP_TIMER)		+=3D timer-mp-csky.o
> >> >  obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-gx6605s.o
> >> > +obj-$(CONFIG_HYPERV)			+=3D hyperv_syntimer.o
> >>
> >> (just a couple of spare thoughs)
> >>
> >> CONFIG_HYPERV can also be a module, are we OK with that? (we'll have t=
o
> >> support module loading/unloading then and honestly I see no reason for
> >> that. I would prefer everything but VMBus devices to be in
> >> kernel.) If we don't want it to be a module we can create a hidden
> >> CONFIG_HYPERV_STIMER or something like that - just like we already do
> >> for CONFIG_HYPERV_TSCPAGE.
> >>
> >> There is, however, one additional dependency here: when running in
> >> non-direct mode, Hyper-V clockevent devices require functional Hyper-V
> >> messaging - which currently lives in VMBus code so that may explain wh=
y
> >> you may want to keep stimer code in the same entity. Or, alternatively=
,
> >> we can move Hyper-V messaging out of VMBus code (is it actually
> >> architecture-agnostic?)
> >>
> >
> > I thought about introducing CONFIG_HYPERV_STIMER, but in my
> > judgment it was just unnecessary complexity.  The Hyper-V clocksource
> > driver can't exist independent of Hyper-V, and vice versa.  When both t=
he
> > clocksource and clockevents code is considered, the VMbus driver and
> > Hyper-V initialization code has to call directly into the driver since =
the
> > Hyper-V synthetic timers and reference time counter aren't independentl=
y
> > enumerated.  Even if we could get the Hyper-V messaging out of VMbus
> > code, we would still need the clocksource initialization call directly =
from
> > hyperv_init(), which is not in a module (see the 2nd patch of the serie=
s).
> >
>=20
> Right, so hv_init_clocksource() cannot live in hv_vmbus module and we
> need to somehow prevent hyperv_syntimer.o from going in there. And
>=20
> +obj-$(CONFIG_HYPERV)                      +=3D hyperv_syntimer.o
>=20
> will do exactly the opposite - put it in hv_vmbus module. Or am I
> missing something? (I haven't tried to build your code yet, sorry).
>=20

That line just controls whether hyperv_syntimer.o is built.  It doesn't put
it in the hv_vmbus module.  All of the clocksource .o files that are built =
go
into the kernel, not in a module.  But thinking about it more, the above wo=
rks
correctly when CONFIG_HYPERV=3Dy, but not when CONFIG_HYPERV=3Dm.  I'll
have to introduce CONFIG_HYPERV_TIMER after all.  Will fix this in v2.  Tha=
nks
for the discussion!
=20
Michael
