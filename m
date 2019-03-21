Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC7C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 00:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4975C218AE
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 00:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ambHfo6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCUAmT (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:42:19 -0400
Received: from mail-eopbgr1320114.outbound.protection.outlook.com ([40.107.132.114]:64320
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbfCUAmS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 20:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ca6vH2AqIImnQHoLXJOwExKBGBjABLNFlqQCFoNYe8=;
 b=ambHfo6Je3qn25Ci41onkV5JhMpH8NiRK5vi19cvLgSPOvgkKvAEBSjOliplIL7ZyPsBc3C0si2QnZxkR8dH1HmTWOm/jiZDC0FjnMHuyWShCCNaj04ieCYghVHTb9MhGoyYr2llNiQSCcs0MvE+uE0smD3u4UzNea9YSspGtk4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0203.APCP153.PROD.OUTLOOK.COM (52.133.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.3; Thu, 21 Mar 2019 00:42:11 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::8073:4441:ad0d:75c0%7]) with mapi id 15.20.1750.002; Thu, 21 Mar 2019
 00:42:11 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
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
Thread-Index: AQHU32YKEJIP46QDrEis0DD/jJcNx6YVOGoAgAAF9cA=
Date:   Thu, 21 Mar 2019 00:42:10 +0000
Message-ID: <PU1P153MB016935A5D6D203B9E44CEDB2BF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-4-decui@microsoft.com>
 <DM5PR2101MB091892992BB0431538A09A30D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <PU1P153MB01691FE3199135CE5C3BFFEDBF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01691FE3199135CE5C3BFFEDBF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
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
x-ms-office365-filtering-correlation-id: 6744cbd5-cb59-4992-3a9b-08d6ad960e05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0203;
x-ms-traffictypediagnostic: PU1P153MB0203:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB020336548C5613F727CC72E9BF420@PU1P153MB0203.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(99286004)(10290500003)(1511001)(2201001)(54906003)(2501003)(102836004)(256004)(6346003)(11346002)(2940100002)(186003)(486006)(81166006)(5660300002)(8990500004)(86612001)(14454004)(446003)(86362001)(8676002)(93886005)(22452003)(478600001)(110136005)(476003)(10090500001)(316002)(81156014)(4744005)(6436002)(105586002)(6116002)(6246003)(33656002)(7416002)(8936002)(25786009)(7736002)(55016002)(71200400001)(7696005)(106356001)(46003)(53936002)(2906002)(74316002)(9686003)(52536014)(6506007)(4326008)(71190400001)(6636002)(68736007)(97736004)(229853002)(76176011)(93156006)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0203;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Y0o/Wve5scTXJj1TgHAleBMqSv1Ov1JIljSOeI+QGrse9XprNEniSJLTWSHa92aO5m8rp4ckXAsM5sJ9V4OqdVyzAlJRiFeBp3/NVV2GEqgwDvsSW20ZOQlNkNEc7Wh9N7XKcbgWrq4ugduKxIu/tpiobocDioNS8Lh/WF2KoSlEVTy7dyyb6I2IjSO9az2mt8jWKlsG9whh42BOd6DvSGgjExLI3BAIf239Q1K0gEe6sR5y7oAk5lr7QcARqB2xOjvxk1BTpFyVa4so0tb+L3DL7/HM6U5ip7YDHf3YlQZbE4+gsgc2K08aiy+dSGVrvQcKCzMqHfnvZs0C/ZFzkVUi+W0lqmy0Bge8Rhlztxj/5AudkbzKhHz3OqMNxMmtLEm/8M9hOLdLU46FmPWYixgA4KpS5UrNy9i8iBowds=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6744cbd5-cb59-4992-3a9b-08d6ad960e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 00:42:10.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
> > ...
> > Patch 2 in this series does set it to NULL, but this code does not.
> In Patch2, i.e. in the code path hv_pci_remove() -> hv_pci_remove_slots()=
,
> we must set hpdev->pci_slot to NULL, otherwise, later, due to
> hv_pci_remove() -> hv_pci_bus_exit() ->
> hv_pci_devices_present() with the zero "relations", we'll double-free the
> "hpdev" struct in pci_devices_present_work() -- see the above.
A minor correction: I meant we'll call pci_destroy_slot(hpdev->pci_slot)
twice, not "double-free hpdev".

Thanks,
-- Dexuan
