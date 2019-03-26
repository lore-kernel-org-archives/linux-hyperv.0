Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4DBC43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3952082F
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 18:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e3fLkrQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfCZSBv (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:01:51 -0400
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:44400
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731828AbfCZSBt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 14:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8Dvk6j9xwj6LUQ7n/6dDaq4VPGXUwhHAstyScBV03o=;
 b=e3fLkrQls2VF4WmXen7EDeN9zOABzgOuvST57Buc/rmN0EQWtJFXVqyjxw5CdCqNkSWS/huU88BoYhWUrzChm3yMje8AGQ03H0OZqCOlUpZfPK1hx32F5Gh6Q09lsa14SNrAjPV11kdbfSRoa16Ks7fs37GWEPtjWyvzxYUbEVk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0121.APCP153.PROD.OUTLOOK.COM (10.170.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.3; Tue, 26 Mar 2019 18:01:33 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0%6]) with mapi id 15.20.1771.003; Tue, 26 Mar 2019
 18:01:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
Thread-Index: AQHU32UqILToz6O5hEmdqVYxs1ZuS6YVIKsQgAAvHICACPe1AIAACgWA///qgnA=
Date:   Tue, 26 Mar 2019 18:01:32 +0000
Message-ID: <PU1P153MB0169CA2F484C02A196F9B78DBF5F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169E9AA13EB51DF5CFC1CE4BF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190326170842.GA10666@e107981-ln.cambridge.arm.com>
 <DM5PR2101MB0918F2C06BBFF7684BF179FFD75F0@DM5PR2101MB0918.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB0918F2C06BBFF7684BF179FFD75F0@DM5PR2101MB0918.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-26T17:47:18.9455886Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3dafe725-df3a-4757-a2e6-da58e28706c9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:f:48ac:9c3a:afc1:92ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 687dc3d6-a6b6-41cb-da9e-08d6b215152a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0121;
x-ms-traffictypediagnostic: PU1P153MB0121:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0121E4C5196ED98BE5183397BF5F0@PU1P153MB0121.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(5660300002)(7736002)(316002)(102836004)(71190400001)(186003)(76176011)(8990500004)(10090500001)(22452003)(2906002)(52536014)(256004)(446003)(33656002)(46003)(81166006)(7696005)(106356001)(6436002)(1511001)(14444005)(81156014)(305945005)(486006)(8676002)(476003)(110136005)(99286004)(8936002)(54906003)(6506007)(11346002)(53546011)(229853002)(97736004)(7416002)(86362001)(4326008)(53936002)(55016002)(10290500003)(9686003)(86612001)(478600001)(6246003)(105586002)(68736007)(6116002)(14454004)(966005)(74316002)(25786009)(71200400001)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0121;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iHtSHlDj0v1NdgDp3exOgYKbXHYZyBsMerW9BJrLb8SpA2LyAMaSJBj2NnKjTyMnq7X5/LGsiH1+wC54wcN9mD5ebjgwlat30x7PbIkO8LSJpvtwLoaBguE9JT4qCghr22uQMBIfRMdPGZYVZMRsSkWOTjg7dLbY0qFY9Tn5e4w+3b0DDAUP0wXbgD8a26DYE1BDIAM8G5B5VBXFV68f+VQqRltbulijguAScSkBoRI67LyXImuEg3ss3LJu3167f6gyXop9yDDB9Lezi3P1s4CG1n+lLejjxjMhAp0z+Tl3YQ2ty+BUdQ3yzsVdU+60ewfqFlXA/sC6eTu8e1fboJdRfJaRRrEp+oCDJUT1HDgOjzHIw9JT3KOLJzMJR1Owfucoge4Y7+KNUq1kxKTXxwm5up7/I4KSUuUgV12xo3g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687dc3d6-a6b6-41cb-da9e-08d6b215152a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 18:01:32.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0121
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Tuesday, March 26, 2019 10:47 AM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Dexuan Cui
> <decui@microsoft.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> Sasha Levin <Alexander.Levin@microsoft.com>; linux-hyperv@vger.kernel.org=
;
> linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Hai=
yang
> Zhang <haiyangz@microsoft.com>; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; vkuznets <vkuznets@redhat.com>;
> marcelo.cerri@canonical.com; jackm@mellanox.com; stable@vger.kernel.org
> Subject: RE: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_wo=
rk()
>=20
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>  Sent: Tuesday, March=
 26,
> 2019 10:09 AM
> > On Thu, Mar 21, 2019 at 12:12:03AM +0000, Dexuan Cui wrote:
> > > > From: Michael Kelley <mikelley@microsoft.com>
> > > > Sent: Wednesday, March 20, 2019 2:38 PM
> > > >
> > > > From: Dexuan Cui <decui@microsoft.com>
> > > > >
> > > > > After a device is just created in new_pcichild_device(), hpdev->r=
efs is
> set
> > > > > to 2 (i.e. the initial value of 1 plus the get_pcichild()).
> > > > >
> > > > > When we hot remove the device from the host, in Linux VM we first=
 call
> > > > > hv_pci_eject_device(), which increases hpdev->refs by get_pcichil=
d()
> and
> > > > > then schedules a work of hv_eject_device_work(), so hpdev->refs
> becomes 3
> > > > > (let's ignore the paired get/put_pcichild() in other places). But=
 in
> > > > > hv_eject_device_work(), currently we only call put_pcichild() twi=
ce,
> > > > > meaning the 'hpdev' struct can't be freed in put_pcichild(). This=
 patch
> > > > > adds one put_pcichild() to fix the memory leak.
> > > > >
> > > > > BTW, the device can also be removed when we run "rmmod pci-hyperv=
".
> On
> > > > this
> > > > > path (hv_pci_remove() -> hv_pci_bus_exit() ->
> hv_pci_devices_present()),
> > > > > hpdev->refs is 2, and we do correctly call put_pcichild() twice i=
n
> > > > > pci_devices_present_work().
> > > >
> > > > Exiting new_pcichild_device() with hpdev->refs set to 2 seems OK to=
 me.
> > > > There is the reference in the hbus->children list, and there is the
> reference that
> > > > is returned to the caller.
> > > So IMO the "normal" reference count should be 2. :-) IMO only when a
> hv_pci_dev
> > > device is about to be destroyed, its reference count can drop to less=
 than 2,
> > > i.e. first temporarily drop to 1 (meaning the hv_pci_dev device is re=
moved
> from
> > > hbus->children), and then drop to zero (meaning kfree(hpdev) is calle=
d).
> > >
> > > > But what is strange is that pci_devices_present_work()
> > > > overwrites the reference returned in local variable hpdev without d=
oing a
> > > > put_pcichild().
> > > I suppose you mean:
> > >
> > >         /* First, mark all existing children as reported missing. */
> > >         spin_lock_irqsave(&hbus->device_list_lock, flags);
> > >         list_for_each_entry(hpdev, &hbus->children, list_entry) {
> > >                 hpdev->reported_missing =3D true;
> > >         }
> > >         spin_unlock_irqrestore(&hbus->device_list_lock, flags)
> > >
> > > This is not strange to me, because, in pci_devices_present_work(), at=
 first
> we
> > > don't know which devices are about to disappear, so we pre-mark all
> devices to
> > > be potentially missing like that; if a device is still on the bus, we=
'll mark its
> > > hpdev->reported_missing to false later; only after we know exactly wh=
ich
> > > devices are missing, we should call put_pcichild() against them. All =
these
> > > seem natural to me.
> > >
> > > > It seems like the "normal" reference count should be 1 when the
> > > > child device is not being manipulated, not 2.
> > > What does "not being manipulated" mean?
> > >
> > > > The fix would be to add a call to
> > > > put_pcichild() when the return value from new_pcichild_device() is
> > > > overwritten.
> > > In pci_devices_present_work(), we NEVER "overwrite" the "hpdev"
> returned
> > > from new_pcichild_device(): the "reported_missing" field of the new h=
pdev
> > > is implicitly initialized to false in new_pcichild_device().
> > >
> > > > Then remove the call to put_pcichild() in pci_device_present_work()
> when
> > > > missing
> > > > children are moved to the local list. The children have been moved =
from
> one
> > > > list
> > > > to another, so there's no need to decrement the reference count.  T=
hen
> when
> > > > everything in the local list is deleted, the reference is correctly
> decremented,
> > > > presumably freeing the memory.
> > > >
> > > > With this approach, the code in hv_eject_device_work() is correct.
> There's
> > > > one call to put_pcichild() to reflect removing the child device fro=
m the
> hbus->
> > > > children list, and one call to put_pcichild() to pair with the get_=
pcichild() in
> > > > hv_pci_eject_device().
> > > Please refer to my replies above. IMO we should fix
> > > hv_eject_device_work() rather than pci_devices_present_work().
> >
> > Have we reached a conclusion on this ? I would like to merge this serie=
s
> > given that it is fixing bugs and it has hung in the balance for quite
> > a while but it looks like Michael is not too happy about these patches
> > and I need a maintainer ACK to merge them.
> >
> > Thanks,
> > Lorenzo
>=20
> Dexuan and I have discussed the topic extensively offline.  The patch wor=
ks
> in its current form, and I'll agree to it.
>=20
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

Thanks, Michael!

Hi Lorenzo,
All the 3 patches have got Michael's Reviewed-by.

Previously, Stephen Hemminger, one of the Hyper-V driver maintainers,=20
provided his Reviewed-by in the " [PATCH 0/3]" mail:
https://lkml.org/lkml/2019/3/5/521

Thanks,
--Dexuan
