Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A424C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 21:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A610218B0
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 21:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GzE0LSzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCTVoL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:44:11 -0400
Received: from mail-eopbgr730134.outbound.protection.outlook.com ([40.107.73.134]:55392
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbfCTVoK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 17:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na9jL+MQG5qJjcnUCOq/0w4aWPNEuoRkez1gnDDjEhY=;
 b=GzE0LSzpbE9jt1OdIQlFmFyYNxKsnLd/fpUHPKrq6MyrbUQmNwJGLVawj754Ojcy5Pxy0pxsr1wNiOG0Mi5N2PZ/nV4UcymrKeXMmGniau8EglZJcHifpsXQgCAGDC6zgleu+MergOXFGMlXV2aQBuH3dKeov9Nzplup8SAhXOM=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1079.namprd21.prod.outlook.com (52.132.130.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.5; Wed, 20 Mar 2019 21:44:06 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1730.008; Wed, 20 Mar 2019
 21:44:06 +0000
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
Subject: RE: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Topic: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Thread-Index: AQHU0tIZgD9GMFct2EmlQHf+0/9EJaYVJQAQ
Date:   Wed, 20 Mar 2019 21:44:06 +0000
Message-ID: <DM5PR2101MB091892992BB0431538A09A30D7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-4-decui@microsoft.com>
In-Reply-To: <20190304213357.16652-4-decui@microsoft.com>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb41eda0-37a5-4bf9-2ef1-08d6ad7d2dad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB107980E1ABE50AACA4F8D8E2D7410@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(33656002)(9686003)(476003)(66066001)(256004)(11346002)(105586002)(54906003)(316002)(55016002)(25786009)(6636002)(110136005)(446003)(81166006)(4326008)(22452003)(8936002)(3846002)(6116002)(229853002)(8990500004)(81156014)(74316002)(10290500003)(6436002)(486006)(478600001)(10090500001)(2906002)(102836004)(8676002)(305945005)(7696005)(86612001)(6346003)(7736002)(7416002)(14454004)(5660300002)(99286004)(68736007)(2201001)(71190400001)(71200400001)(6246003)(76176011)(2501003)(6506007)(186003)(53936002)(52536014)(106356001)(86362001)(26005)(1511001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H7lO7+mMl9d/5zu94ifGAgmtJ8zfJoO+zM6X9X8vcG/HHzMusRCAN9LjVOGFBZTZoptkanKVxKwi975mfotgenKt2KRDFOw1ELS+AEG1pgtGQP6M0DHOiIVkHAI50SzBl4tjED8y6reakWrLGB9rA1j7OfIZpGSn3dNhvxwDBsum0/eBSZaC0mI5OUDA/SfrZqcx2zMTMmETdcZGk3lUjuv5ViPQmVhA6JctfgMSos4hA+cjYQA1B40wJTKGBgfWfx3N/iI9DEn/5qo3w547inimlDi8fK41FVU7L+C/5Vn18RtZaRwHTuCFWI5CfSV37OLKsVy9eVsCR6glP0DuTQOQY4bKTKEiM2ZA66DVndWUuSSzmNYWvWeE3q21ool2m2UrMnCPSZwDt7KaO0JfgTxz2h9NqfuFISe7Mj9bU4g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb41eda0-37a5-4bf9-2ef1-08d6ad7d2dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 21:44:06.7596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Monday, March 4, 2019 1:35 PM
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index b489412e3502..82acd6155adf 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1776,6 +1776,10 @@ static void pci_devices_present_work(struct work_s=
truct *work)
>  		hpdev =3D list_first_entry(&removed, struct hv_pci_dev,
>  					 list_entry);
>  		list_del(&hpdev->list_entry);
> +
> +		if (hpdev->pci_slot)
> +			pci_destroy_slot(hpdev->pci_slot);

The code is inconsistent in whether hpdev->pci_slot is set to NULL after ca=
lling
pci_destory_slot().  Patch 2 in this series does set it to NULL, but this c=
ode does not.
And the code in hv_eject_device_work() does not set it to NULL.

It looks like all the places that test the value of hpdev->pci_slot or call
pci_destroy_slot() are serialized, so it looks like it really doesn't matte=
r.  But when
the code is inconsistent about setting to NULL, it always makes me wonder i=
f there
is a reason.

Michael


> +
>  		put_pcichild(hpdev);
>  	}
>=20
> --
> 2.19.1

