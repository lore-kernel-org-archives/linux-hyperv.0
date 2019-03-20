Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E440DC43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 21:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DA620685
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 21:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ikA+m36e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCTVi7 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:38:59 -0400
Received: from mail-eopbgr680099.outbound.protection.outlook.com ([40.107.68.99]:19940
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfCTVi7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 17:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz+bskILZYG8s+CRWYl6lA2nwnqAOC4rfvucVcsL71o=;
 b=ikA+m36eK6uPWpkPi7zwIG0Oe4Dqs5ugjHoVJKzOLZdq9sJekLgiWF69cxQo08NCkO4x84CW3b6rAqMK/vMDlZeDvK8VJXHNrBbtZJEyBCMAHEnlbhIkfY2vBpERJqQL69bvsmam7mJMhbPwCEWTpR5HvuqW+pcaj15T35Z5HM0=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0967.namprd21.prod.outlook.com (52.132.133.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.5; Wed, 20 Mar 2019 21:38:55 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1730.008; Wed, 20 Mar 2019
 21:38:55 +0000
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
Subject: RE: [PATCH 2/3] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Thread-Topic: [PATCH 2/3] PCI: hv: Add hv_pci_remove_slots() when we unload
 the driver
Thread-Index: AQHU0tIYAcuU2l8u70+aqPdXB3Weg6YVJMXA
Date:   Wed, 20 Mar 2019 21:38:55 +0000
Message-ID: <DM5PR2101MB09184F9359B300EEF04C5728D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-3-decui@microsoft.com>
In-Reply-To: <20190304213357.16652-3-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-20T21:38:52.9541339Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c16b61d8-76e9-4f9d-8a85-adb50c06fbb6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 810cf9fa-ad79-40ff-e6c5-08d6ad7c7418
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB09678FDADBAA2DB2AD59B368D7410@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(40224003)(486006)(99286004)(446003)(2906002)(33656002)(8936002)(6116002)(4744005)(10090500001)(3846002)(476003)(22452003)(6636002)(105586002)(478600001)(316002)(2501003)(66066001)(256004)(11346002)(14444005)(106356001)(1511001)(110136005)(54906003)(305945005)(7736002)(6246003)(74316002)(186003)(4326008)(26005)(14454004)(2201001)(71190400001)(71200400001)(7416002)(25786009)(6436002)(55016002)(81156014)(81166006)(52536014)(8676002)(9686003)(53936002)(5660300002)(86612001)(97736004)(76176011)(86362001)(8990500004)(6506007)(102836004)(6346003)(68736007)(10290500003)(229853002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K63pkkTiSkx/u+fEY7DRFwMpOL/Pl36/Kw8RCh5nwdLGjs3OvOJpWVxgd1i7MLxory37lAIScLcwxOzuUh1YCMcnCxvP7mPylijDmz7IVVGqD6uUTK51K6auBYAAhYUeD+B8rHxLe04Tj8cTTcmu2WJfr8zYb4HS/9tldjTQzoPdLRx0vwzjNtz2ZsEEutdDr0eN6Y1MeUEkqgQqcpdofIRr0PXU4LtEWzgheuxd7JG8DtTtPSrAuJ7pcHzNu+4932LvFwKoZw/OPSJ5LXwi11PAZTgpIx/v9dEUpVWnydlAK5+bdGu2lduwpCeCuDt1xkrLWlPQnwHhrM1wzQbTXkjbHfJ7SqLyzrEoFwvKsB3elZBINccU4n1YfjI/9bUlEEJ+swp/V4tTTlaWoDh4tH75IXucS+22xbTpKzsKUBk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810cf9fa-ad79-40ff-e6c5-08d6ad7c7418
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 21:38:55.3513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, March 4, 2019 1:35 PM
>=20
> When we unload pci-hyperv, the host doesn't send us a PCI_EJECT message.
> In this case we also need to make sure the sysfs pci slot directory
> is removed, otherwise "cat /sys/bus/pci/slots/2/address" will trigger
> "BUG: unable to handle kernel paging request" (I noticed the issue when
> systemd-dev crashed for me when I unloaded the driver). And, if we
> unload/reload the driver several times, we'll have multiple pci slot
> directories in /sys/bus/pci/slots/ like this:
>=20
> root@localhost:~# ls -rtl  /sys/bus/pci/slots/
> total 0
> drwxr-xr-x 2 root root 0 Feb  7 10:49 2
> drwxr-xr-x 2 root root 0 Feb  7 10:49 2-1
> drwxr-xr-x 2 root root 0 Feb  7 10:51 2-2
>=20
> The patch adds the missing code.
>=20
> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot in=
formation")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Acked-by: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
