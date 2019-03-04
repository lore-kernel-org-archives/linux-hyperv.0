Return-Path: <SRS0=2GwH=RH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A7AC43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FE320663
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QfjL84f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCDVez (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:34:55 -0500
Received: from mail-eopbgr770121.outbound.protection.outlook.com ([40.107.77.121]:59715
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfCDVey (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Mar 2019 16:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOKmRkSCHwSKpBV4HFslL4NSXTh0ODmXdhgq+pzjjqM=;
 b=QfjL84f8YP1v7iyb7drmZBa8HniNCjdy4H0HS4MHUCBP2rm9JBak5oV6UK0WUzntYzSg5usSNJ9+xOYkVKwTD0ct5XB+2g3QQkmZ6g94Tup0O3wPtLsFmWN6zjuGizOeWrIT4rIeg7RdPmKR0E7iE4Rok5M7qTduH8ygsJbfG20=
Received: from MN2PR21MB1296.namprd21.prod.outlook.com (20.179.21.154) by
 MN2PR21MB1183.namprd21.prod.outlook.com (20.179.20.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.4; Mon, 4 Mar 2019 21:34:49 +0000
Received: from MN2PR21MB1296.namprd21.prod.outlook.com
 ([fe80::8d7a:2ffa:8916:69c3]) by MN2PR21MB1296.namprd21.prod.outlook.com
 ([fe80::8d7a:2ffa:8916:69c3%3]) with mapi id 15.20.1709.002; Mon, 4 Mar 2019
 21:34:49 +0000
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
Subject: [PATCH 2/3] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Thread-Topic: [PATCH 2/3] PCI: hv: Add hv_pci_remove_slots() when we unload
 the driver
Thread-Index: AQHU0tIYYM00GlnBAUeAnbzMfj5zdw==
Date:   Mon, 4 Mar 2019 21:34:48 +0000
Message-ID: <20190304213357.16652-3-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 9ab0dda4-ce2a-40ec-6f9d-08d6a0e93a5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1183;
x-ms-traffictypediagnostic: MN2PR21MB1183:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MN2PR21MB1183C1A115987CDC82A19D7EBF710@MN2PR21MB1183.namprd21.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(366004)(396003)(40224003)(199004)(189003)(26005)(25786009)(6346003)(2501003)(476003)(22452003)(10090500001)(446003)(2616005)(486006)(11346002)(99286004)(6116002)(3846002)(14454004)(478600001)(81156014)(81166006)(316002)(8676002)(7736002)(76176011)(6506007)(386003)(1511001)(106356001)(105586002)(53936002)(6512007)(186003)(7416002)(66066001)(54906003)(110136005)(52116002)(305945005)(6486002)(36756003)(6436002)(102836004)(8936002)(4326008)(68736007)(71200400001)(6636002)(97736004)(86362001)(14444005)(256004)(2906002)(2201001)(71190400001)(5660300002)(50226002)(10290500003)(1076003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1183;H:MN2PR21MB1296.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ywYzU7CyfTFriQQs9sNaGiPOzyPI3usV8PhR7nNQRNWcRv6iCsTXja4FSkwrtv8aRG7tQyUrf0vsgm5MKqXmUsqam4mMbnqUaBQcZYYVmLCHW59Z1lnNCVbqVTnCcU/XDWUnVyoMZ/CwicG1TI9W0OB0jgAMirxXioEIyUtiz3C+Yoe5QhNt1EVxeZbERyvf4/O9FwGUSQBjiw/TBe1VlBZxXSUL5IcaWrulkfjy4Ubo4lFfuStYsVNkQWdsN1eTF+7e6fV2AS2ViveP+wRwf65jK0H5IC8lNxzm4b+mBTRbLCyX7l/PZZmPu07QTTNJZe+aHoOqzdfdk1pdW7+gOZys/ym8DKqFPr4sjfZqBV7CuN6yQrA6/PlNzbLNtQfupwCD7EIJDysuzGXfUpOzo/GaQbOkgQ4u0f+ehKvVJ+M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab0dda4-ce2a-40ec-6f9d-08d6a0e93a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 21:34:48.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1183
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When we unload pci-hyperv, the host doesn't send us a PCI_EJECT message.
In this case we also need to make sure the sysfs pci slot directory
is removed, otherwise "cat /sys/bus/pci/slots/2/address" will trigger
"BUG: unable to handle kernel paging request" (I noticed the issue when
systemd-dev crashed for me when I unloaded the driver). And, if we
unload/reload the driver several times, we'll have multiple pci slot
directories in /sys/bus/pci/slots/ like this:

root@localhost:~# ls -rtl  /sys/bus/pci/slots/
total 0
drwxr-xr-x 2 root root 0 Feb  7 10:49 2
drwxr-xr-x 2 root root 0 Feb  7 10:49 2-1
drwxr-xr-x 2 root root 0 Feb  7 10:51 2-2

The patch adds the missing code.

Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot info=
rmation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Stephen Hemminger <sthemmin@microsoft.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-hyperv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 30f16b882746..b489412e3502 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1486,6 +1486,21 @@ static void hv_pci_assign_slots(struct hv_pcibus_dev=
ice *hbus)
 	}
 }
=20
+/*
+ * Remove entries in sysfs pci slot directory.
+ */
+static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
+{
+	struct hv_pci_dev *hpdev;
+
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		if (!hpdev->pci_slot)
+			continue;
+		pci_destroy_slot(hpdev->pci_slot);
+		hpdev->pci_slot =3D NULL;
+	}
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -2680,6 +2695,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		pci_lock_rescan_remove();
 		pci_stop_root_bus(hbus->pci_bus);
 		pci_remove_root_bus(hbus->pci_bus);
+		hv_pci_remove_slots(hbus);
 		pci_unlock_rescan_remove();
 		hbus->state =3D hv_pcibus_removed;
 	}
--=20
2.19.1

