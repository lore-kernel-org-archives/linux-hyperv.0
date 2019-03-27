Return-Path: <SRS0=AyMY=R6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2280BC43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Mar 2019 00:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71E520811
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Mar 2019 00:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jrW97EI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfC0AWp (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:22:45 -0400
Received: from mail-eopbgr1310112.outbound.protection.outlook.com ([40.107.131.112]:55319
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731752AbfC0AWp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 20:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvvkwMLFuYAmYbWIcRyXLlMDJPZOx0HHHklWXCr6Hx0=;
 b=jrW97EI9by3Y/jqS1+Dvkzss5tvA6jqMpC5+MDWDo/HYs+mFGKO2Tsc2NENfKwWuRvXlWl/ySGkolcQ9Q9JSAX3sc5uUBZCIM+N09hgFalVsFJBXWTxnIHaELAUVcoBsRdV9MSIqnsQIJVahZsVGqRVxWbJcvZ5Wp4ZRYgwS24Q=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0108.APCP153.PROD.OUTLOOK.COM (10.170.188.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.4; Wed, 27 Mar 2019 00:22:34 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0%6]) with mapi id 15.20.1771.003; Wed, 27 Mar 2019
 00:22:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
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
Subject: RE: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Topic: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Index: AQHU5A25EJIP46QDrEis0DD/jJcNx6YebUig
Date:   Wed, 27 Mar 2019 00:22:33 +0000
Message-ID: <PU1P153MB0169256A5240C1EE6C0042C9BF580@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-4-decui@microsoft.com>
 <20190326195429.GA15410@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190326195429.GA15410@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-27T00:22:31.0117800Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b2fcd4b-49f7-440b-b212-8ad60a19d754;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:f:48ac:9c3a:afc1:92ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 338421a1-e113-47ef-99c1-08d6b24a4f1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0108;
x-ms-traffictypediagnostic: PU1P153MB0108:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0108D8ED52203C2705EE4407BF580@PU1P153MB0108.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(54534003)(256004)(478600001)(14454004)(55016002)(6116002)(10290500003)(74316002)(7736002)(99286004)(14444005)(97736004)(7416002)(22452003)(54906003)(305945005)(68736007)(5660300002)(25786009)(33656002)(2906002)(52536014)(6916009)(8936002)(81166006)(316002)(10090500001)(106356001)(105586002)(7696005)(81156014)(446003)(102836004)(6506007)(86362001)(6436002)(76176011)(186003)(8676002)(8990500004)(486006)(476003)(86612001)(9686003)(6246003)(53936002)(229853002)(46003)(71200400001)(71190400001)(4326008)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0108;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dKebL9JKRoE4Y+LhkzSDDuCjWjPp+MAUGpfiazffbCCih45PVTkyMGai4h4TnV+cOZUu1mZnDcMwp7PZu64D1NxzVlPaNWihRXiQuMZLEFpp3/AIiAGhDaPJubRwwU6m/NkLyooE5qydGbqgo1w4HRqrccII7ozgH5ZURQ2jXTFxfEuiIfRRLNxIw7jNtIYUmC7CVu8GFugAAC0+Z0oWOnbRO6MZPQlQ6CmEAiil28BFvdoRiI44r/h7V/QZKqOppymHG1ffqFRHCpCxkm/pXIpnuoxRvhHf9EplwRLnsCTLFLL2HLs7jSjbMwQ71A7HI3zsgQ/ZMOOT8H+OEvMjY8jH2E85LJpqabrLj4w1++xcKFXtdXDZoT+0BU01T5F9q85h4dNcC++GBoTuCQJ2aFP4ZKO0AGbXXO7iNGmJBpE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338421a1-e113-47ef-99c1-08d6b24a4f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 00:22:33.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0108
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Tuesday, March 26, 2019 12:55 PM
> On Mon, Mar 04, 2019 at 09:34:49PM +0000, Dexuan Cui wrote:
> > When we hot-remove a device, usually the host sends us a PCI_EJECT
> message,
> > and a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=3D 0. Bu=
t
> when
> > we do the quick hot-add/hot-remove test, the host may not send us the
> > PCI_EJECT message, if the guest has not fully finished the initializati=
on
> > by sending the PCI_RESOURCES_ASSIGNED* message to the host, so it's
> > potentially unsafe to only depend on the pci_destroy_slot() in
> > hv_eject_device_work(), though create_root_hv_pci_bus() ->
> > hv_pci_assign_slots() is not called in this case. Note: in this case, t=
he
> > host still sends the guest a PCI_BUS_RELATIONS message with
> > bus_rel->device_count =3D=3D 0.
> >
> > And, in the quick hot-add/hot-remove test, we can have such a race: bef=
ore
> > pci_devices_present_work() -> new_pcichild_device() adds the new device
> > into hbus->children, we may have already received the PCI_EJECT message=
,
> > and hence the taklet handler hv_pci_onchannelcallback() may fail to fin=
d
> > the "hpdev" by get_pcichild_wslot(hbus, dev_message->wslot.slot), so
> > hv_pci_eject_device() is NOT called; later create_root_hv_pci_bus() ->
> > hv_pci_assign_slots() creates the slot, and the PCI_BUS_RELATIONS messa=
ge
> > with bus_rel->device_count =3D=3D 0 removes the device from hbus->child=
ren,
> and
> > we end up being unable to remove the slot in hv_pci_remove() ->
> > hv_pci_remove_slots().
> >
> > The patch removes the slot in pci_devices_present_work() when the devic=
e
> > is removed. This can address the above race. Note 1:
> > pci_devices_present_work() and hv_eject_device_work() run in the
> > singled-threaded hbus->wq, so there is not a double-remove issue for th=
e
> > slot. Note 2: we can't offload hv_pci_eject_device() from
> > hv_pci_onchannelcallback() to the workqueue, because we need
> > hv_pci_onchannelcallback() synchronously call hv_pci_eject_device() to
> > poll the channel's ringbuffer to work around the
> > "hangs in hv_compose_msi_msg()" issue: see
> > commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> hv_compose_msi_msg()")
>=20
> This commit log is unreadable, sorry. Indentation, punctuation and
> formatting are just a mess, try to read it, you will notice by
> yourself.
>=20
> I basically reformatted it completely and pushed the series to
> pci/controller-fixes but that's the last time I do it since I am not an
> editor, next time I won't merge it.

Hi Lorenzo,
Thank you for helping improve my changelogs! I did learn a lot after
carefully comparing the improved version with my original version. :-)

I'll try my best to write a good changelog for my future patches.

> More importantly, these patches are marked for stable, given the series
> of fixes that triggered this series please ensure it was tested
> thoroughly because it is honestly complicate to understand and I do not
> want to backport further fixes to stable kernels on top of this.

I did the hot-add/hot-remove test in a loop for several thousand times,
and the patchset worked as expected and didn't show any issue.

> Please have a look and report back.
>=20
> Thanks,
> Lorenzo

Thanks again!

Thanks,
-- Dexuan
