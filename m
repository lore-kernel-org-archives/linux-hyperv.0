Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3857C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 00:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6809720835
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 00:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E9J5s9Sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCUAgO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:36:14 -0400
Received: from mail-eopbgr1300129.outbound.protection.outlook.com ([40.107.130.129]:43648
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfCUAgO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 20:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjMjWn4NUnOin5K4hwNUlYXgkZiJzSxlr31WJJflS5Q=;
 b=E9J5s9SlwhI4Lsl4ap3uGU76D1a4agSN1XeqcUxHhabBsEyCTvAb8P/tUMlUS8JR/Uqdl9S/hm0Dp0sUuXBjlKqv+f1+eTfCgr46JDcYtjaOGVgI6+Xb4qsQiLgICNKAeLlqGZ60hIzAgNy+zsjgXWjtLCixW7dX/m4SmM2DnHM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0171.APCP153.PROD.OUTLOOK.COM (10.170.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.4; Thu, 21 Mar 2019 00:35:58 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0%7]) with mapi id 15.20.1750.002; Thu, 21 Mar 2019
 00:35:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
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
Thread-Index: AQHU32YKEJIP46QDrEis0DD/jJcNx6YVOGoA
Date:   Thu, 21 Mar 2019 00:35:58 +0000
Message-ID: <PU1P153MB01691FE3199135CE5C3BFFEDBF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-4-decui@microsoft.com>
 <DM5PR2101MB091892992BB0431538A09A30D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB091892992BB0431538A09A30D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
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
x-originating-ip: [2601:600:a280:1760:b139:a24a:e67f:7afd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f05b33fb-29a0-4001-d3e8-08d6ad95301b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0171;
x-ms-traffictypediagnostic: PU1P153MB0171:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01714BF80DDDB851D91CD4B2BF420@PU1P153MB0171.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(81156014)(46003)(86612001)(2906002)(6246003)(486006)(11346002)(476003)(53546011)(14454004)(81166006)(10290500003)(186003)(71190400001)(76176011)(6116002)(55016002)(446003)(7416002)(25786009)(1511001)(6506007)(8990500004)(9686003)(33656002)(8676002)(106356001)(53936002)(71200400001)(102836004)(478600001)(7736002)(105586002)(305945005)(8936002)(99286004)(2501003)(6346003)(4326008)(74316002)(316002)(54906003)(229853002)(10090500001)(2201001)(86362001)(7696005)(97736004)(110136005)(6436002)(256004)(22452003)(52536014)(6636002)(5660300002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0171;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IQe9sGHavsqLXebQv1b/TKO7WBg/dsR/rmMTph5bJ9jfpuwknyKEM+xnfFEkVvh+O6P5Kx1vAlhwgAv5aur5OEBtBdgBJEVgwtRk2GjGTOlKooe+QHkl8jJvvYXNN2C13baOKrCqH7z5qaw841tiXqMD15N7JDru1KIaq0ZKg9iNSUKZR/lAPtfjzRsnfcIJ+e/9HdZlBYab0RnLOL3ELkO6qo5ACwAGRgpN47grzKkS7QNI2WDywDh4NXLitZqul3Z19h+tW3NsPY3EEh3FEGMGOedtDFLP5ZfT9vrVtYkU8NWe9nqsKFCJrMIbMeZls9FXC276mIDDFCS4/11C3j6VQboEpJW+9sRAWDHAJOAq2q57sBEqhUar2SZ2eFZ3CU7EXkHL1ccJ31/yAW589WG3mN8+MSzxtVRFAjOKIlI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05b33fb-29a0-4001-d3e8-08d6ad95301b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 00:35:58.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0171
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, March 20, 2019 2:44 PM
> To: Dexuan Cui <decui@microsoft.com>; lorenzo.pieralisi@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> > ...
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > @@ -1776,6 +1776,10 @@ static void pci_devices_present_work(struct
> work_struct *work)
> >  		hpdev =3D list_first_entry(&removed, struct hv_pci_dev,
> >  					 list_entry);
> >  		list_del(&hpdev->list_entry);
> > +
> > +		if (hpdev->pci_slot)
> > +			pci_destroy_slot(hpdev->pci_slot);
>=20
> The code is inconsistent in whether hpdev->pci_slot is set to NULL after =
calling
> pci_destory_slot().=20
Here, in pci_devices_present_work(), it's unnecessary to set it to NULL,
Because:
1) the "hpdev" is removed from hbus->children and it can not be seen
elsewhere;
2) the "hpdev" struct is freed in the below put_pcichild():

     while (!list_empty(&removed)) {
                hpdev =3D list_first_entry(&removed, struct hv_pci_dev,
                                         list_entry);
                list_del(&hpdev->list_entry);

                if (hpdev->pci_slot)
                        pci_destroy_slot(hpdev->pci_slot);

                put_pcichild(hpdev);
        }

> Patch 2 in this series does set it to NULL, but this code does not.
In Patch2, i.e. in the code path hv_pci_remove() -> hv_pci_remove_slots(),
we must set hpdev->pci_slot to NULL, otherwise, later, due to
hv_pci_remove() -> hv_pci_bus_exit() ->
hv_pci_devices_present() with the zero "relations", we'll double-free the
"hpdev" struct in pci_devices_present_work() -- see the above.

> And the code in hv_eject_device_work() does not set it to NULL.
It's unnecessary to set hpdev->pci_slot to NULL in hv_eject_device_work(),
Because in hv_eject_device_work():=20
1) the "hpdev" is removed from hbus->children and it can not be seen
elsewhere;
2) the "hpdev" struct is freed at the end of hv_eject_device_work() with my
first patch: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work=
().
=20
> It looks like all the places that test the value of hpdev->pci_slot or ca=
ll
> pci_destroy_slot() are serialized, so it looks like it really doesn't mat=
ter.  But
> when
> the code is inconsistent about setting to NULL, it always makes me wonder=
 if
> there
> is a reason.
>=20
> Michael

Thanks,
-- Dexuan
