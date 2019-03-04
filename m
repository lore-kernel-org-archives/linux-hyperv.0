Return-Path: <SRS0=2GwH=RH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7097DC10F09
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D86120823
	for <linux-hyperv@archiver.kernel.org>; Mon,  4 Mar 2019 21:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ftXULeXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCDVfC (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:35:02 -0500
Received: from mail-eopbgr770121.outbound.protection.outlook.com ([40.107.77.121]:59715
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfCDVez (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Mar 2019 16:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6mXG5pEBSPy1IbuUllcnKkUI0oSm7o3lCk621LqegM=;
 b=ftXULeXUyrrlqJrzoW+H75l+YylVJXhfl61oSbOy5GOhycdSVkoSMTnscI2moDaYTBOYd7xU3zv7FKQ57J4ab6LS0F8d0yBpEw9VmGZkYR+q99xzW0IrOCqv81kboI/gZ94eOEfKeJRwVYx7FoXLe0t12g8tZcKjpR9bySRfmd4=
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
Subject: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Topic: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Index: AQHU0tIY8DrNYkUs0k++5L52C5B9ng==
Date:   Mon, 4 Mar 2019 21:34:49 +0000
Message-ID: <20190304213357.16652-4-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: e134f3e4-dcea-4722-b04d-08d6a0e93abe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1183;
x-ms-traffictypediagnostic: MN2PR21MB1183:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MN2PR21MB11838783B5200EB2D16C6D86BF710@MN2PR21MB1183.namprd21.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(366004)(396003)(40224003)(199004)(189003)(26005)(25786009)(6346003)(2501003)(476003)(22452003)(10090500001)(446003)(2616005)(486006)(11346002)(99286004)(6116002)(3846002)(14454004)(478600001)(81156014)(81166006)(316002)(8676002)(7736002)(76176011)(6506007)(386003)(1511001)(106356001)(105586002)(53936002)(6512007)(186003)(7416002)(66066001)(54906003)(110136005)(52116002)(305945005)(6486002)(36756003)(6436002)(102836004)(8936002)(4326008)(68736007)(71200400001)(6636002)(97736004)(86362001)(256004)(2906002)(2201001)(71190400001)(5660300002)(50226002)(10290500003)(1076003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1183;H:MN2PR21MB1296.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nDY0Sde0G5/4D3jMxa+z8FKC1Rm+TUIkqTrK4LC/OoNtQ9MF07AjuU1d34eV29vW3Wk7M5jzGUF1KOWwPWDinE9wdTQorADNybywnR9lxIPx0nN/g0zftnlmvjiS7r4/4zdA23iCYyoO6Y24tK8XMNLUTQPGQMf7fsdeXXIRKI+tJcr92zQOgJ8Di+sNoaGQIAOOXcRuIv470CMGfpMPaUXlnx/3a3HoveoLZVV8QsEjX4iH4PHroeJkOAH9ueKL7pj7Etkm+XqsEmLTknQR/oKeHCEdMdRsXVdOuV25Xo57rw/xHU+bDM9bA7TKsSRzlleddiTtItmAVhnziVanVlIHFLbDxdlpFOvWVnlXOzNolD2e0FCEqoqUoUuozDaJbw78EvpE/wlTr9JXyHTnESntJoE82SFKaRYM386mzdI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e134f3e4-dcea-4722-b04d-08d6a0e93abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 21:34:49.5785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1183
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When we hot-remove a device, usually the host sends us a PCI_EJECT message,
and a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=3D 0. But wh=
en
we do the quick hot-add/hot-remove test, the host may not send us the
PCI_EJECT message, if the guest has not fully finished the initialization
by sending the PCI_RESOURCES_ASSIGNED* message to the host, so it's
potentially unsafe to only depend on the pci_destroy_slot() in
hv_eject_device_work(), though create_root_hv_pci_bus() ->
hv_pci_assign_slots() is not called in this case. Note: in this case, the
host still sends the guest a PCI_BUS_RELATIONS message with
bus_rel->device_count =3D=3D 0.

And, in the quick hot-add/hot-remove test, we can have such a race: before
pci_devices_present_work() -> new_pcichild_device() adds the new device
into hbus->children, we may have already received the PCI_EJECT message,
and hence the taklet handler hv_pci_onchannelcallback() may fail to find
the "hpdev" by get_pcichild_wslot(hbus, dev_message->wslot.slot), so
hv_pci_eject_device() is NOT called; later create_root_hv_pci_bus() ->
hv_pci_assign_slots() creates the slot, and the PCI_BUS_RELATIONS message
with bus_rel->device_count =3D=3D 0 removes the device from hbus->children,=
 and
we end up being unable to remove the slot in hv_pci_remove() ->
hv_pci_remove_slots().

The patch removes the slot in pci_devices_present_work() when the device
is removed. This can address the above race. Note 1:
pci_devices_present_work() and hv_eject_device_work() run in the
singled-threaded hbus->wq, so there is not a double-remove issue for the
slot. Note 2: we can't offload hv_pci_eject_device() from
hv_pci_onchannelcallback() to the workqueue, because we need
hv_pci_onchannelcallback() synchronously call hv_pci_eject_device() to
poll the channel's ringbuffer to work around the
"hangs in hv_compose_msi_msg()" issue: see
commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")

Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot info=
rmation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index b489412e3502..82acd6155adf 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1776,6 +1776,10 @@ static void pci_devices_present_work(struct work_str=
uct *work)
 		hpdev =3D list_first_entry(&removed, struct hv_pci_dev,
 					 list_entry);
 		list_del(&hpdev->list_entry);
+
+		if (hpdev->pci_slot)
+			pci_destroy_slot(hpdev->pci_slot);
+
 		put_pcichild(hpdev);
 	}
=20
--=20
2.19.1

