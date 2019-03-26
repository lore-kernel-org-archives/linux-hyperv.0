Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E4C4360F
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4698F2070D
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VXhvnZoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfCZRr0 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:47:26 -0400
Received: from mail-eopbgr710115.outbound.protection.outlook.com ([40.107.71.115]:19572
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727492AbfCZRrZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 13:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gQ1m88sCKYDt919YYmXLZ6w7nqiy6eQKfPezj7bff0=;
 b=VXhvnZojWMIvQ3cI8A78JRdTPf8kVLPBEKh+voaZoAVbTDnbswdlUrcL1RA79AnsHA9xT1z6KGoTBjzNCJvGknYJ3cmBHsW0ZtCVJkKtR/aFJDf9tPgsSgxG80Jxt/c0ZOqlgg6AyS8Xg2AJrfa3+2HLhrA5uHlBCQBfwffRVZY=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (52.132.133.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.2; Tue, 26 Mar 2019 17:47:21 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::bc27:5e7:f223:2191]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::bc27:5e7:f223:2191%3]) with mapi id 15.20.1771.003; Tue, 26 Mar 2019
 17:47:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dexuan Cui <decui@microsoft.com>
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
Thread-Index: AQHU0tIYcblOk9ffn0yRsYTt0Z4pWaYVIKsQgAAvHICACPe1AIAACgWA
Date:   Tue, 26 Mar 2019 17:47:21 +0000
Message-ID: <DM5PR2101MB0918F2C06BBFF7684BF179FFD75F0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <PU1P153MB0169E9AA13EB51DF5CFC1CE4BF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190326170842.GA10666@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190326170842.GA10666@e107981-ln.cambridge.arm.com>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a12cdb4e-881f-46fe-7cc8-08d6b213190f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0983B2C453CC689496A4CB2FD75F0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(476003)(256004)(22452003)(5660300002)(14444005)(6246003)(97736004)(74316002)(486006)(7696005)(478600001)(105586002)(4326008)(1511001)(8676002)(10090500001)(86362001)(66066001)(106356001)(2906002)(7416002)(99286004)(86612001)(6636002)(110136005)(3846002)(8936002)(68736007)(54906003)(6346003)(81166006)(6506007)(102836004)(81156014)(25786009)(14454004)(305945005)(71200400001)(7736002)(55016002)(33656002)(10290500003)(8990500004)(6436002)(6116002)(71190400001)(446003)(11346002)(52536014)(9686003)(186003)(26005)(316002)(76176011)(53936002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TQwnPhxNEff33YqAfN+w9fliTFqM15pRwdH1izA2jgcm2vsC31eIQ2jq5nxNzAfMjILCVfwkx6BN0X1u1geD9i/RXz3fGAEqv8fFvjnm1S4zjfFFoZomH3pcmqgEzVJYL3TbRhaPLaq6GiQR2+jnifwL3V0tEuXNfBKjVGLqRGFFqmb79ij2rjKWIhNTeOzARwVPuc8d4DZurZSLBCtXVtkAgYb4UJCb/hvdUrl2RirYtEaeO/+Fo9Xd9BUIy27aGR8UgP+jyopwBskzxty/jVAO+fxPKPcE+Dg6OVSVEE5eUQ3Krazn9yoSFzaHMdcTAdIasY+kDvN/DHfdrGSnrRsIHsTVc/iFthykS1zIMctjodWgjHH1Pf+OXpCoCzPUJ0uiPy+pB0G7KPz3L3SumEB+LY4UgPoH4hRJ9qYxze0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12cdb4e-881f-46fe-7cc8-08d6b213190f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 17:47:21.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>  Sent: Tuesday, March 2=
6, 2019 10:09 AM
> On Thu, Mar 21, 2019 at 12:12:03AM +0000, Dexuan Cui wrote:
> > > From: Michael Kelley <mikelley@microsoft.com>
> > > Sent: Wednesday, March 20, 2019 2:38 PM
> > >
> > > From: Dexuan Cui <decui@microsoft.com>
> > > >
> > > > After a device is just created in new_pcichild_device(), hpdev->ref=
s is set
> > > > to 2 (i.e. the initial value of 1 plus the get_pcichild()).
> > > >
> > > > When we hot remove the device from the host, in Linux VM we first c=
all
> > > > hv_pci_eject_device(), which increases hpdev->refs by get_pcichild(=
) and
> > > > then schedules a work of hv_eject_device_work(), so hpdev->refs bec=
omes 3
> > > > (let's ignore the paired get/put_pcichild() in other places). But i=
n
> > > > hv_eject_device_work(), currently we only call put_pcichild() twice=
,
> > > > meaning the 'hpdev' struct can't be freed in put_pcichild(). This p=
atch
> > > > adds one put_pcichild() to fix the memory leak.
> > > >
> > > > BTW, the device can also be removed when we run "rmmod pci-hyperv".=
 On
> > > this
> > > > path (hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_devices_presen=
t()),
> > > > hpdev->refs is 2, and we do correctly call put_pcichild() twice in
> > > > pci_devices_present_work().
> > >
> > > Exiting new_pcichild_device() with hpdev->refs set to 2 seems OK to m=
e.
> > > There is the reference in the hbus->children list, and there is the r=
eference that
> > > is returned to the caller.
> > So IMO the "normal" reference count should be 2. :-) IMO only when a hv=
_pci_dev
> > device is about to be destroyed, its reference count can drop to less t=
han 2,
> > i.e. first temporarily drop to 1 (meaning the hv_pci_dev device is remo=
ved from
> > hbus->children), and then drop to zero (meaning kfree(hpdev) is called)=
.
> >
> > > But what is strange is that pci_devices_present_work()
> > > overwrites the reference returned in local variable hpdev without doi=
ng a
> > > put_pcichild().
> > I suppose you mean:
> >
> >         /* First, mark all existing children as reported missing. */
> >         spin_lock_irqsave(&hbus->device_list_lock, flags);
> >         list_for_each_entry(hpdev, &hbus->children, list_entry) {
> >                 hpdev->reported_missing =3D true;
> >         }
> >         spin_unlock_irqrestore(&hbus->device_list_lock, flags)
> >
> > This is not strange to me, because, in pci_devices_present_work(), at f=
irst we
> > don't know which devices are about to disappear, so we pre-mark all dev=
ices to
> > be potentially missing like that; if a device is still on the bus, we'l=
l mark its
> > hpdev->reported_missing to false later; only after we know exactly whic=
h
> > devices are missing, we should call put_pcichild() against them. All th=
ese
> > seem natural to me.
> >
> > > It seems like the "normal" reference count should be 1 when the
> > > child device is not being manipulated, not 2.
> > What does "not being manipulated" mean?
> >
> > > The fix would be to add a call to
> > > put_pcichild() when the return value from new_pcichild_device() is
> > > overwritten.
> > In pci_devices_present_work(), we NEVER "overwrite" the "hpdev" returne=
d
> > from new_pcichild_device(): the "reported_missing" field of the new hpd=
ev
> > is implicitly initialized to false in new_pcichild_device().
> >
> > > Then remove the call to put_pcichild() in pci_device_present_work() w=
hen
> > > missing
> > > children are moved to the local list. The children have been moved fr=
om one
> > > list
> > > to another, so there's no need to decrement the reference count.  The=
n when
> > > everything in the local list is deleted, the reference is correctly d=
ecremented,
> > > presumably freeing the memory.
> > >
> > > With this approach, the code in hv_eject_device_work() is correct.  T=
here's
> > > one call to put_pcichild() to reflect removing the child device from =
the hbus->
> > > children list, and one call to put_pcichild() to pair with the get_pc=
ichild() in
> > > hv_pci_eject_device().
> > Please refer to my replies above. IMO we should fix
> > hv_eject_device_work() rather than pci_devices_present_work().
>=20
> Have we reached a conclusion on this ? I would like to merge this series
> given that it is fixing bugs and it has hung in the balance for quite
> a while but it looks like Michael is not too happy about these patches
> and I need a maintainer ACK to merge them.
>=20
> Thanks,
> Lorenzo

Dexuan and I have discussed the topic extensively offline.  The patch works
in its current form, and I'll agree to it.

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
