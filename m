Return-Path: <SRS0=2GwH=RH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A25C43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C052D20663
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UA0aR2p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCDVex (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:34:53 -0500
Received: from mail-eopbgr770121.outbound.protection.outlook.com ([40.107.77.121]:59715
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfCDVew (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Mar 2019 16:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV2iDe/3zcuJlZP73YTp/epx2GJ8zJucxhOV+U8fQl8=;
 b=UA0aR2p4mjHNnldl4ggKCvuJT/F6BWuj7kV8hQ+FNGaiLd4EEbDIQTJ4WBWDQf5x2mcFC5tGvMh6CcR1bOzbaEOmLtz3oTjlTS/hxFsfOHtShnIw9Og3ruu2UAYl1ykdDV7Fbw1Ot8sLkebY44HHTT0E6gJZxzGke2JpzJTzmLE=
Received: from MN2PR21MB1296.namprd21.prod.outlook.com (20.179.21.154) by
 MN2PR21MB1183.namprd21.prod.outlook.com (20.179.20.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.4; Mon, 4 Mar 2019 21:34:48 +0000
Received: from MN2PR21MB1296.namprd21.prod.outlook.com
 ([fe80::8d7a:2ffa:8916:69c3]) by MN2PR21MB1296.namprd21.prod.outlook.com
 ([fe80::8d7a:2ffa:8916:69c3%3]) with mapi id 15.20.1709.002; Mon, 4 Mar 2019
 21:34:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
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
        Dexuan Cui <decui@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work()
Thread-Topic: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work()
Thread-Index: AQHU0tIXarlyp3h9mUiQyALKGUsSIA==
Date:   Mon, 4 Mar 2019 21:34:48 +0000
Message-ID: <20190304213357.16652-2-decui@microsoft.com>
References: <20190304213357.16652-1-decui@microsoft.com>
In-Reply-To: <20190304213357.16652-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:405:2::20) To MN2PR21MB1296.namprd21.prod.outlook.com
 (2603:10b6:208:3e::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-originating-ip: [107.180.71.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc123403-2d2b-4d6e-9962-08d6a0e939df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1183;
x-ms-traffictypediagnostic: MN2PR21MB1183:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MN2PR21MB118386CC7C942682900CCB5CBF710@MN2PR21MB1183.namprd21.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(26005)(25786009)(6346003)(2501003)(476003)(22452003)(10090500001)(446003)(2616005)(486006)(11346002)(99286004)(6116002)(3846002)(14454004)(478600001)(81156014)(81166006)(316002)(8676002)(7736002)(76176011)(6506007)(386003)(1511001)(106356001)(105586002)(53936002)(6512007)(186003)(7416002)(66066001)(54906003)(110136005)(52116002)(305945005)(6486002)(36756003)(6436002)(102836004)(8936002)(4326008)(68736007)(71200400001)(6636002)(97736004)(86362001)(256004)(2906002)(2201001)(71190400001)(5660300002)(50226002)(10290500003)(1076003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1183;H:MN2PR21MB1296.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4VJ0Bts1nPTgpFD843v0SlDzsa27c/am9p4hpRmjL1Ztpr1Rup/1GfjWVEUdRYMtfVql7u0PUjPVpbXuLZ24XEzHdGVen/iDkG0xp+SADlYAILPpY42UbfpdOCWVww8BNy/JXBbNDZz0zco2YJpQ7zX0rxg4l/UHbtMt9XDKH3qlX7+V5/A4pYhnTfwoyuqdS8C8FwJEJVkSVjtgk8tGbWYlbhXi2gFs4Wh3Lv4/Hnjhx6Osz1/geDrfeKmkuv2pdh6LzurHQgqaSQSNCn2WKPs5ktOYji26rOxvvSAn+OmyB62WZIPFYBTtoqB0f8elckyDHyq+bHfOglc60TJx5sc3H/+kYVxlk0EuMMkwLwRJLlHQTiBnowInVpBDjxaUv52oDRaghIMbbcxHjzSR6qlZ5pCVroqDeJKzMEcNjQw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc123403-2d2b-4d6e-9962-08d6a0e939df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 21:34:48.2876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1183
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

After a device is just created in new_pcichild_device(), hpdev->refs is set
to 2 (i.e. the initial value of 1 plus the get_pcichild()).

When we hot remove the device from the host, in Linux VM we first call
hv_pci_eject_device(), which increases hpdev->refs by get_pcichild() and
then schedules a work of hv_eject_device_work(), so hpdev->refs becomes 3
(let's ignore the paired get/put_pcichild() in other places). But in
hv_eject_device_work(), currently we only call put_pcichild() twice,
meaning the 'hpdev' struct can't be freed in put_pcichild(). This patch
adds one put_pcichild() to fix the memory leak.

BTW, the device can also be removed when we run "rmmod pci-hyperv". On this
path (hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_devices_present()),
hpdev->refs is 2, and we do correctly call put_pcichild() twice in
pci_devices_present_work().

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft =
Hyper-V VMs")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 95441a35eceb..30f16b882746 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1900,6 +1900,9 @@ static void hv_eject_device_work(struct work_struct *=
work)
 			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
 			 VM_PKT_DATA_INBAND, 0);
=20
+	/* For the get_pcichild() in hv_pci_eject_device() */
+	put_pcichild(hpdev);
+	/* For the two refs got in new_pcichild_device() */
 	put_pcichild(hpdev);
 	put_pcichild(hpdev);
 	put_hvpcibus(hpdev->hbus);
--=20
2.19.1

