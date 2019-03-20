Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE7C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 21:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696F218AE
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 21:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hxrl7QjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCTVhy (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:37:54 -0400
Received: from mail-eopbgr770131.outbound.protection.outlook.com ([40.107.77.131]:20558
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbfCTVhy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 17:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72O19RTsI1ctsnsQ5beIAK5lCvWm+ee/hJdcjd5NDQc=;
 b=hxrl7QjYZnTubCAqaRp/8p++nSkpCbcO8JEPNOEu1p+0l75FugGnEYztcOZv7KCijYbr8ifYVk1hnI6CyJE2P6rIm6KfSD3qp94mKDPrW1EcMlSHq2V806HwmoapjuL6YShGryIgSZKC4OS+Ags4YoaaQTOiflD7Ma+GKgjiffI=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0967.namprd21.prod.outlook.com (52.132.133.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.5; Wed, 20 Mar 2019 21:37:50 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1730.008; Wed, 20 Mar 2019
 21:37:50 +0000
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
Subject: RE: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work()
Thread-Topic: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work()
Thread-Index: AQHU0tIYcblOk9ffn0yRsYTt0Z4pWaYVIKsQ
Date:   Wed, 20 Mar 2019 21:37:49 +0000
Message-ID: <DM5PR2101MB0918F6A089C461EEA4457998D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-2-decui@microsoft.com>
In-Reply-To: <20190304213357.16652-2-decui@microsoft.com>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b897d5c-575a-4146-da8d-08d6ad7c4d1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB096737ED8E6B152B3A1F2DFFD7410@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(486006)(99286004)(446003)(2906002)(33656002)(8936002)(6116002)(10090500001)(3846002)(476003)(22452003)(6636002)(105586002)(478600001)(316002)(2501003)(66066001)(256004)(11346002)(106356001)(1511001)(110136005)(54906003)(305945005)(7736002)(6246003)(74316002)(186003)(4326008)(26005)(14454004)(2201001)(71190400001)(71200400001)(7416002)(25786009)(6436002)(55016002)(81156014)(81166006)(52536014)(8676002)(9686003)(53936002)(5660300002)(86612001)(97736004)(76176011)(86362001)(8990500004)(6506007)(102836004)(6346003)(68736007)(10290500003)(229853002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B0iAlPyXXcXlWe6h6Y6uOf/jcE4EeWaMof0wXHRcDcnpSmeznxI0CMI//0bJCNS53S/xzz7VLBaXBqe794Q254bNVxyG9BdO+keAT+YB2LG6VMbIyDL4j5WyF6OMS83BqPhZWWzuUsr4fGrxSolUffmN3TALTOeBvMEeS8aztiRSpDlwqKLbDYqZJivIF9uQ6oGzz7Vq13E1/b3fbbMSz6QLF0I/BNCmDigpBVDOPpbP8XN1xf+gLlfb6B0tNSP4tGVRVq5iS5RGFcFOJUToHnAtgTLA+qbDJXX4d0EmOKUG/Pvet3K79bcITh0OA19o/8MhvIxcCVzGYTScqWNHAEjPYaxdVGkjyXVyzSVIOJ2WaFKyTvYQsf13Npj8DR7QyppD6wkOSenIvSCwHkIDUBloQd4LJ3OHPn9tPjoE1VI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b897d5c-575a-4146-da8d-08d6ad7c4d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 21:37:49.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
>
> After a device is just created in new_pcichild_device(), hpdev->refs is s=
et
> to 2 (i.e. the initial value of 1 plus the get_pcichild()).
>=20
> When we hot remove the device from the host, in Linux VM we first call
> hv_pci_eject_device(), which increases hpdev->refs by get_pcichild() and
> then schedules a work of hv_eject_device_work(), so hpdev->refs becomes 3
> (let's ignore the paired get/put_pcichild() in other places). But in
> hv_eject_device_work(), currently we only call put_pcichild() twice,
> meaning the 'hpdev' struct can't be freed in put_pcichild(). This patch
> adds one put_pcichild() to fix the memory leak.
>=20
> BTW, the device can also be removed when we run "rmmod pci-hyperv". On th=
is
> path (hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_devices_present()),
> hpdev->refs is 2, and we do correctly call put_pcichild() twice in
> pci_devices_present_work().
>=20
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t Hyper-V VMs")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: <stable@vger.kernel.org>

Exiting new_pcichild_device() with hpdev->refs set to 2 seems OK to me.
There is the reference in the hbus->children list, and there is the referen=
ce that
is returned to the caller.  But what is strange is that pci_devices_present=
_work()
overwrites the reference returned in local variable hpdev without doing a
put_pcichild().  It seems like the "normal" reference count should be 1 whe=
n the
child device is not being manipulated, not 2.  The fix would be to add a ca=
ll to
put_pcichild() when the return value from new_pcichild_device() is overwrit=
ten.
Then remove the call to put_pcichild() in pci_device_present_work() when mi=
ssing
children are moved to the local list. The children have been moved from one=
 list
to another, so there's no need to decrement the reference count.  Then when
everything in the local list is deleted, the reference is correctly decreme=
nted,
presumably freeing the memory.

With this approach, the code in hv_eject_device_work() is correct.  There's
one call to put_pcichild() to reflect removing the child device from the hb=
us->
children list, and one call to put_pcichild() to pair with the get_pcichild=
() in
hv_pci_eject_device().

Your patch works, but to me it leaves the ref count in an unnatural state
most of the time.

Michael
