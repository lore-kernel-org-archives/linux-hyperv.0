Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68973C10F05
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCD320866
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 17:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ykl4nPZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfCZRuE (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:50:04 -0400
Received: from mail-eopbgr710138.outbound.protection.outlook.com ([40.107.71.138]:12055
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729800AbfCZRuE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 13:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw00kzpSjQ0fVLUBWFkMONgHUldNuM+AI5sAs0u4m7w=;
 b=Ykl4nPZbNypOuwByKvXdF2feOSgdko3I+SUNf4wUzTg8ZN7A+y8/EybDBLNdKFJnGnKvAu2T6H7kPpK9Z7YGuDPPlhMV40ILg6rJwgPWm7pDkzmj7a/vnlStpWqROmL7mcIpUWcq2DTLKlOzE7++oSBoL6otYU/Zvwi3pUl1bho=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (52.132.133.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.2; Tue, 26 Mar 2019 17:50:01 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::bc27:5e7:f223:2191]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::bc27:5e7:f223:2191%3]) with mapi id 15.20.1771.003; Tue, 26 Mar 2019
 17:50:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Topic: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Index: AQHU0tIZgD9GMFct2EmlQHf+0/9EJaYVJQAQgAAxdgCACPxPgA==
Date:   Tue, 26 Mar 2019 17:50:00 +0000
Message-ID: <DM5PR2101MB09184CD1568C414674CB2C4DD75F0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-4-decui@microsoft.com>
 <DM5PR2101MB091892992BB0431538A09A30D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <PU1P153MB01691FE3199135CE5C3BFFEDBF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01691FE3199135CE5C3BFFEDBF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-20T21:44:04.4186852Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85e9252e-0119-484c-a7d0-9f061de1f9c6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f5553ef-755d-4abd-e05e-08d6b2137846
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0983CBDE1AE32C4C7EFB14A6D75F0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(476003)(256004)(22452003)(5660300002)(6246003)(97736004)(74316002)(486006)(7696005)(478600001)(105586002)(4326008)(1511001)(8676002)(10090500001)(86362001)(2501003)(66066001)(93886005)(106356001)(2906002)(7416002)(99286004)(2201001)(86612001)(6636002)(110136005)(3846002)(8936002)(68736007)(54906003)(6346003)(81166006)(6506007)(102836004)(81156014)(25786009)(14454004)(305945005)(71200400001)(7736002)(55016002)(33656002)(10290500003)(8990500004)(6436002)(6116002)(71190400001)(446003)(11346002)(52536014)(9686003)(186003)(26005)(316002)(76176011)(53936002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wE4dJOc6DznWs/Oj/BIogLyUVxInCb6UH5jm8/Zt3eJG7LU+14sJeG878Emyoy1iPycHWCvzRGecGunS6T4VSxLkaNFHXwP6QMAF37LkUiQVa4o4alrrEKPqindq1FIG+A7t1xGuscsmm/eKvnqKT6gMJq+MCsOsbGBmbHFuMwqDa+Ml0kvBBPhX9/dev56Ab8K4NXzCbJaPPJkGZiQtX/17GCSLMg0P+Yc1UgDO4VAFdccgOhhiSGv1dwiR4DknxWb9oQXgDc28qKfcyjoCkRJ7knuVrIaq7sB9AIlzvhdUJEHVuaeiO7LFtgq1dRvZ3/OVSJU/21hxkSHgTsE8idq1YcNHByj5gRaIox9LYZg3oamIyMOI21XOYG11ZJTx8y8wfhv6cyZCGCrUK09bwgGykiogrb+5Sl4vMCHeXR0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5553ef-755d-4abd-e05e-08d6b2137846
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 17:50:00.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Wednesday, March 20, 2019 5:3=
6 PM
>=20
> > From: Michael Kelley <mikelley@microsoft.com>
> > > ...
> > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > @@ -1776,6 +1776,10 @@ static void pci_devices_present_work(struct
> > work_struct *work)
> > >  		hpdev =3D list_first_entry(&removed, struct hv_pci_dev,
> > >  					 list_entry);
> > >  		list_del(&hpdev->list_entry);
> > > +
> > > +		if (hpdev->pci_slot)
> > > +			pci_destroy_slot(hpdev->pci_slot);
> >
> > The code is inconsistent in whether hpdev->pci_slot is set to NULL afte=
r calling
> > pci_destory_slot().
> Here, in pci_devices_present_work(), it's unnecessary to set it to NULL,
> Because:
> 1) the "hpdev" is removed from hbus->children and it can not be seen
> elsewhere;
> 2) the "hpdev" struct is freed in the below put_pcichild():
>=20
>      while (!list_empty(&removed)) {
>                 hpdev =3D list_first_entry(&removed, struct hv_pci_dev,
>                                          list_entry);
>                 list_del(&hpdev->list_entry);
>=20
>                 if (hpdev->pci_slot)
>                         pci_destroy_slot(hpdev->pci_slot);
>=20
>                 put_pcichild(hpdev);
>         }
>=20
> > Patch 2 in this series does set it to NULL, but this code does not.
> In Patch2, i.e. in the code path hv_pci_remove() -> hv_pci_remove_slots()=
,
> we must set hpdev->pci_slot to NULL, otherwise, later, due to
> hv_pci_remove() -> hv_pci_bus_exit() ->
> hv_pci_devices_present() with the zero "relations", we'll double-free the
> "hpdev" struct in pci_devices_present_work() -- see the above.
>=20
> > And the code in hv_eject_device_work() does not set it to NULL.
> It's unnecessary to set hpdev->pci_slot to NULL in hv_eject_device_work()=
,
> Because in hv_eject_device_work():
> 1) the "hpdev" is removed from hbus->children and it can not be seen
> elsewhere;
> 2) the "hpdev" struct is freed at the end of hv_eject_device_work() with =
my
> first patch: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_wo=
rk().
>=20
> > It looks like all the places that test the value of hpdev->pci_slot or =
call
> > pci_destroy_slot() are serialized, so it looks like it really doesn't m=
atter.  But
> > when
> > the code is inconsistent about setting to NULL, it always makes me wond=
er if
> > there
> > is a reason.
> >
> > Michael
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
