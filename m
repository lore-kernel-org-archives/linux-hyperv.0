Return-Path: <SRS0=2GwH=RH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0CEC43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A249E20663
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NCuq2q3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfCDVev (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:34:51 -0500
Received: from mail-eopbgr770121.outbound.protection.outlook.com ([40.107.77.121]:59715
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfCDVev (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Mar 2019 16:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P7Bc+bOKvdeNhDLyzSUaD60OzD7G4kA9Id04or4820=;
 b=NCuq2q3buzi7OOtyKslOP4fYP3amKTwEeU/iiaMxPskltUbf9Ohby25c2UdCLp0gLP80O62+YzMxXWOMbIxQPIM3lEDhJLtglireuh3ZFv5cRXrkVFHcEAhUi0XKEb4fdtJHzj+FK893MWDMK9qIR25GRiGkDXgkTNYkiPhleS4=
Received: from MN2PR21MB1296.namprd21.prod.outlook.com (20.179.21.154) by
 MN2PR21MB1183.namprd21.prod.outlook.com (20.179.20.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.4; Mon, 4 Mar 2019 21:34:47 +0000
Received: from MN2PR21MB1296.namprd21.prod.outlook.com
 ([fe80::8d7a:2ffa:8916:69c3]) by MN2PR21MB1296.namprd21.prod.outlook.com
 ([fe80::8d7a:2ffa:8916:69c3%3]) with mapi id 15.20.1709.002; Mon, 4 Mar 2019
 21:34:47 +0000
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
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/3] pci-hyperv: fix memory leak and add pci_destroy_slot()
Thread-Topic: [PATCH 0/3] pci-hyperv: fix memory leak and add
 pci_destroy_slot()
Thread-Index: AQHU0tIXpoMWrIasuUiIcSagCuoTRA==
Date:   Mon, 4 Mar 2019 21:34:47 +0000
Message-ID: <20190304213357.16652-1-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 7db59db7-f9c6-4805-3ac9-08d6a0e9396d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1183;
x-ms-traffictypediagnostic: MN2PR21MB1183:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MN2PR21MB1183AC2ED0DC4C5991BB2305BF710@MN2PR21MB1183.namprd21.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(26005)(25786009)(6346003)(2501003)(476003)(22452003)(10090500001)(2616005)(486006)(99286004)(6116002)(3846002)(14454004)(478600001)(81156014)(81166006)(316002)(8676002)(7736002)(6506007)(386003)(1511001)(106356001)(105586002)(53936002)(6512007)(186003)(7416002)(66066001)(54906003)(110136005)(107886003)(52116002)(305945005)(6486002)(36756003)(6436002)(102836004)(8936002)(4326008)(68736007)(71200400001)(6636002)(97736004)(86362001)(14444005)(256004)(2906002)(2201001)(71190400001)(5660300002)(50226002)(10290500003)(1076003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1183;H:MN2PR21MB1296.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M9KspP+3NvEQufhHNMxeFCnsiBKSg6BVWlgIFvkOJXIUYr3oE/ulnMMevKm2Sh8rumn9xg6eKG2QcyoLsji/cYtK7GtXrQ6QdNVBPn5LYlREaKEg9Z6O/9fVy55fztaxO+ko1WTJ486URi+C5m79ujQ+9KHkI3qtzjP+NFIom9Jx5GZmCvBAvaixFwY6CJTS3ga3nxgqNxn08V+6Gu2l/aFs1oIO2pKfJ0l71PorktmVeQJ7fB0VIYgseEGBKhBukoLXQlxCZe0Hp5HaqDg+1cHdDgJopeZ0EPtEhy2+BlRN5ahRJx+7tseI8rwOX7K4jJzV8GkOcu4jwn2akfwAqELs2IT553t0oZzwLb0zGwpL/eCFY0/EwQykyUbmJLXVvQCz1K7rkDIEql3+J/xmD0gGWdZxyq8BxyEYFure0AU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db59db7-f9c6-4805-3ac9-08d6a0e9396d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 21:34:47.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1183
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Patch #1 fixes a memory leak caused by incorrectly-maintained hpdev->refs.

Patch #2 and #3 make sure the "slot" is removed in all the scenarios.
Without them, in the quick hot-add/hot-remove test, systemd-dev may easily
crash when trying to access a dangling sys file in /sys/bus/pci/slots/:
"BUG: unable to handle kernel paging request".

BTW, Patch #2 was posted on Feb 7, 2019, and this is the v2: the change
to hv_eject_device_work() in v1 is removed, as the change is only needed
when we hot-remove the device and remove the pci-hyperv driver at the=20
same time. It looks more work is required to make this scenaro work
correctly, and since removing the driver is not really a "usual" usage,
we can address this scenario in the future.

Please review the patchset.

Dexuan Cui (3):
  PCI: hv: Fix a memory leak in hv_eject_device_work()
  PCI: hv: Add hv_pci_remove_slots() when we unload the driver
  PCI: hv: Add pci_destroy_slot() in pci_devices_present_work(), if
    necessary

 drivers/pci/controller/pci-hyperv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--=20
2.19.1

