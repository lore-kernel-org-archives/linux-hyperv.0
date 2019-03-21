Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F6FC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 00:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E0B218C3
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 00:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kiWvuxQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfCUAMV (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:12:21 -0400
Received: from mail-eopbgr1310125.outbound.protection.outlook.com ([40.107.131.125]:3069
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726914AbfCUAMU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 20:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6EG0lUmr1oiMHIBfGPkHRzEQjuDAMo82R2BXfOtZWk=;
 b=kiWvuxQ8OxP0TIj4OceIy16NfCD+UD/S3vrJtlHTS//WPyyVOVCkjznKw0b9FN4S6MwcNIe7kHOMugUnKE7mSEspobyhpSQjeNJWQKhTGAnhzI0jAcEb0I4p8c1b4VzbbaPKcLWLtWdDKWqCQJG58b89cxRr1AxQxYt2jjPS8Ms=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.4; Thu, 21 Mar 2019 00:12:03 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0%7]) with mapi id 15.20.1750.002; Thu, 21 Mar 2019
 00:12:03 +0000
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
Subject: RE: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work()
Thread-Topic: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work()
Thread-Index: AQHU32UqILToz6O5hEmdqVYxs1ZuS6YVHckA
Date:   Thu, 21 Mar 2019 00:12:03 +0000
Message-ID: <PU1P153MB0169E9AA13EB51DF5CFC1CE4BF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-2-decui@microsoft.com>
 <DM5PR2101MB0918F6A089C461EEA4457998D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB0918F6A089C461EEA4457998D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-20T21:37:46.2345424Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e434203d-b77d-43fb-8540-83db36fb089c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:a280:1760:b139:a24a:e67f:7afd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef3379ef-fc23-48ba-95a4-08d6ad91d8cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0172;
x-ms-traffictypediagnostic: PU1P153MB0172:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB017229384E903324E792736ABF420@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(6346003)(7736002)(10290500003)(33656002)(7696005)(25786009)(68736007)(55016002)(9686003)(8936002)(4326008)(6246003)(8676002)(6436002)(46003)(22452003)(54906003)(105586002)(305945005)(110136005)(316002)(476003)(1511001)(2906002)(99286004)(486006)(6636002)(229853002)(8990500004)(81156014)(106356001)(256004)(10090500001)(11346002)(6506007)(5660300002)(478600001)(446003)(86362001)(186003)(2201001)(86612001)(71200400001)(71190400001)(53936002)(6116002)(7416002)(52536014)(14454004)(102836004)(81166006)(97736004)(2501003)(14444005)(74316002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7bQWt+2AKlnwQ5t4tpadfa5knPbVRa6BFqd94bFRvKyc2gk4UB47ZxybcK2lNYV6DJ1Sp5JlD+lJi0ELPXnF3Cs5CJ/fLEacoHkn76Uj8IdS5EmX+mXo/2CvgKjxvT4bjCuW+8pK7nkg8sKKm3uK7YzGs37TTdMyvJxKkzEXh/8SrsU+TazCvq2nL3t7BQMgEcmaQz8OZj4tpktOrdboaLTj6E9mbtfaYXp1fAfkajq8v1wDf1GPMBHBbe5tPGsvlqHhaqq+lb/tOqaIvyQhPLOpXwc/BzqFWI85kpXJcglQWjAwgkB3Yup3DEve/xDlDImmhAnE8KwpI6ijo/7/WgmKSksVbysvUzOItsiLeCSDeg52oucJl+pHwqriHYW8axi/ASmjk8C4MB9+PGZDQRMoRheCfGY4VB5m9qs7qVA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3379ef-fc23-48ba-95a4-08d6ad91d8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 00:12:03.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, March 20, 2019 2:38 PM
>=20
> From: Dexuan Cui <decui@microsoft.com>
> >
> > After a device is just created in new_pcichild_device(), hpdev->refs is=
 set
> > to 2 (i.e. the initial value of 1 plus the get_pcichild()).
> >
> > When we hot remove the device from the host, in Linux VM we first call
> > hv_pci_eject_device(), which increases hpdev->refs by get_pcichild() an=
d
> > then schedules a work of hv_eject_device_work(), so hpdev->refs becomes=
 3
> > (let's ignore the paired get/put_pcichild() in other places). But in
> > hv_eject_device_work(), currently we only call put_pcichild() twice,
> > meaning the 'hpdev' struct can't be freed in put_pcichild(). This patch
> > adds one put_pcichild() to fix the memory leak.
> >
> > BTW, the device can also be removed when we run "rmmod pci-hyperv". On
> this
> > path (hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_devices_present())=
,
> > hpdev->refs is 2, and we do correctly call put_pcichild() twice in
> > pci_devices_present_work().
>=20
> Exiting new_pcichild_device() with hpdev->refs set to 2 seems OK to me.
> There is the reference in the hbus->children list, and there is the refer=
ence that
> is returned to the caller. =20
So IMO the "normal" reference count should be 2. :-) IMO only when a hv_pci=
_dev
device is about to be destroyed, its reference count can drop to less than =
2,=20
i.e. first temporarily drop to 1 (meaning the hv_pci_dev device is removed =
from
hbus->children), and then drop to zero (meaning kfree(hpdev) is called).

> But what is strange is that pci_devices_present_work()
> overwrites the reference returned in local variable hpdev without doing a
> put_pcichild().
I suppose you mean:

        /* First, mark all existing children as reported missing. */
        spin_lock_irqsave(&hbus->device_list_lock, flags);
        list_for_each_entry(hpdev, &hbus->children, list_entry) {
                hpdev->reported_missing =3D true;
        }
        spin_unlock_irqrestore(&hbus->device_list_lock, flags)

This is not strange to me, because, in pci_devices_present_work(), at first=
 we
don't know which devices are about to disappear, so we pre-mark all devices=
 to
be potentially missing like that; if a device is still on the bus, we'll ma=
rk its
hpdev->reported_missing to false later; only after we know exactly which
devices are missing, we should call put_pcichild() against them. All these
seem natural to me.

> It seems like the "normal" reference count should be 1 when the
> child device is not being manipulated, not 2.
What does "not being manipulated" mean?

> The fix would be to add a call to
> put_pcichild() when the return value from new_pcichild_device() is
> overwritten.
In pci_devices_present_work(), we NEVER "overwrite" the "hpdev" returned
from new_pcichild_device(): the "reported_missing" field of the new hpdev
is implicitly initialized to false in new_pcichild_device().

> Then remove the call to put_pcichild() in pci_device_present_work() when
> missing
> children are moved to the local list. The children have been moved from o=
ne
> list
> to another, so there's no need to decrement the reference count.  Then wh=
en
> everything in the local list is deleted, the reference is correctly decre=
mented,
> presumably freeing the memory.
>=20
> With this approach, the code in hv_eject_device_work() is correct.  There=
's
> one call to put_pcichild() to reflect removing the child device from the =
hbus->
> children list, and one call to put_pcichild() to pair with the get_pcichi=
ld() in
> hv_pci_eject_device().
Please refer to my replies above. IMO we should fix
hv_eject_device_work() rather than pci_devices_present_work().

Thanks
-- Dexuan
=20
> Your patch works, but to me it leaves the ref count in an unnatural state
> most of the time.
>=20
> Michael

