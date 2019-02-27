Return-Path: <SRS0=Gp0b=RC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CE3C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457FA20C01
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 17:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jph/Hmcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfB0Rbn (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:31:43 -0500
Received: from mail-eopbgr800114.outbound.protection.outlook.com ([40.107.80.114]:5792
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfB0Rbm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 12:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCSrEiymHijc1bkhC2143nufuiirOxg5e1n23Atrg2s=;
 b=jph/HmcdPPovobDh/QOY8ysbZpJ/IEhcIYuEt/wfyKZ+d53lokjD1gN0OVByGR0sYlUshwB7hp1HzvCQlZPLFdXEvUMbROLp+Qv905pqnmdvQz4H+gUfz+8RnHdAZ0TX6lzpV/PIOiU+bNQeI78p0zA7wk3vCigOEmcpoOYG+no=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1045.namprd21.prod.outlook.com (52.132.128.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.4; Wed, 27 Feb 2019 17:31:38 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%8]) with mapi id 15.20.1686.003; Wed, 27 Feb 2019
 17:31:38 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH V6 2/3] IOMMU/Hyper-V: Add Hyper-V stub IOMMU driver
Thread-Topic: [PATCH V6 2/3] IOMMU/Hyper-V: Add Hyper-V stub IOMMU driver
Thread-Index: AQHUzqxi0wy192rIek243nOyl0T9cqXz5urQ
Date:   Wed, 27 Feb 2019 17:31:38 +0000
Message-ID: <DM5PR2101MB0918BCF506C61269BE66B5BDD7740@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1551279245-25888-3-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1551279245-25888-3-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-27T17:31:36.5717310Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c42ff034-6321-4f28-906e-b11cc91f8508;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3f8bd5a-002d-4721-be57-08d69cd96e15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1045;23:U2Y4zh4jndLy6NqXKmbOU5S2rK4cseb/xTh9P3p?=
 =?us-ascii?Q?p8M+GXWCE6ll1sF8OmNGoCbzI05axig/xmLZM3KD1B7Jk/kf4uIkrCk5HOZC?=
 =?us-ascii?Q?TobTY7tJHSHdUBchMuXd/LqCZli4MkVnU7kH8j+wo7OTkv9RYWwIHKZB2YQ5?=
 =?us-ascii?Q?TMKReB061kXdktDRftag3BoCHwJfeklEhUJrO0PXMWfQ/xrCxvy22dp4TEpc?=
 =?us-ascii?Q?tVNuZQ9l6cAM/aNVmQcbq+b02y0XaWBUEemCm86oOwYD8VT2YkjuEykSw4rh?=
 =?us-ascii?Q?BE6Jtu85j7Q8td1akjjqQoyEamwVRGvzk8aNcc/oJojb+nMcOMtx8HdmTUKz?=
 =?us-ascii?Q?DxtNRb78CITH+ihwFT9OICsSuepTqWhm+3s4hWY/kO7a0HoZsTOcIjCvv9jW?=
 =?us-ascii?Q?ur3lPu6BgOy+UZXI5x8b53uH7KBie9eqe/PJGwiv8Zs7Wukg+C3K94glOHzx?=
 =?us-ascii?Q?MFyEriAPIsuzr6vGFZ3iZhO5Yz/6iqYjIavLRHtkI+KoNS9yerSJCQNDpODN?=
 =?us-ascii?Q?JKGNcewr+UaMKF8NuIrGBe8ltkyn1BIfGM5N3ljC+YJDrGcLULFpjVCOl8wb?=
 =?us-ascii?Q?0Ro98Imkn6ajxyYXcTLEK/IzLp1Ip01gQbe5NwHcECufW0pEvt6jIx6UQbmR?=
 =?us-ascii?Q?OUl7y/2zPJ1iMuX8IZuohnlcl8fCBb26dIVvievwTS+8lMZah6H3bjUbvjNl?=
 =?us-ascii?Q?CyL7UEUARWVHoWw0s1j7cnFPgpR5me93Jr9CqBX96LOFkNPIZ+COusfup+Cs?=
 =?us-ascii?Q?lxR/65tvN6Ny+sRXvTil4UKM7qt46nEGtemqMKSvlIQh0PX8BGQHQ4n9kjPk?=
 =?us-ascii?Q?G6HywpbLuA7X/FK8MhyNH6jmUYfBnEorROA5G3CBWwPFZtER5Nni5mD4CiC8?=
 =?us-ascii?Q?A8g+BrknAgmRS/Ypaa5jwf7pFRZRqMQeZAZS3HL+R1t/nSeMDRzc9rrPnEC8?=
 =?us-ascii?Q?A2MXQYcT7yRumE72l0neYNe4OP9zvZ8puoV3wWEzT3t1kWcw4b/lzQqggicD?=
 =?us-ascii?Q?yoxg/bbqHkkIoLky2rx9F3IBbFEE5fXTqW6JsvunWgC5tJr9mzeSOkpCTYlV?=
 =?us-ascii?Q?lIGDrGNpI6dNxedLByNwn/ypYfjea+U4LesMb8A4hyF4Racn2bDcIusmlURy?=
 =?us-ascii?Q?a1H7i2s039eK51ZpaV//pYG+Ym8SbaZwgioFzGnxoA46NMi2cCb7X2UFBFAy?=
 =?us-ascii?Q?9QV9GA0rsn7evzCluhXNOvfiUq+6CQu9f3tHw9pp1s8LYEY4VeciOhssPtkQ?=
 =?us-ascii?Q?W+/osOeEnfjs3yRH+k6/XOFAw/Lc66xDeGit4l96fpd/bkg7UP0TJxbf8O26?=
 =?us-ascii?Q?xKIvkf+nAFQ4Rjn1/lsyCwrd+V4GxuuPP593+t+FIkVQe7gylCDhjqg330Pn?=
 =?us-ascii?Q?kmbaHfT7Yjq13GOKrXW+sGfA42rq1zPTAaWWBGMeeVtGEtpb5A0+zEjAjyvn?=
 =?us-ascii?Q?5n+WjaZ2pJR8NSNfQIQqvPkW4t2rvHNzlhV5omXe2dzrxOOP22JyZZCvi5qH?=
 =?us-ascii?Q?vQhcwG9yqqSYLzMJpk1995rZcIa1yw9ALYiIQpa/wvCfcp4DNGsITH83b?=
x-microsoft-antispam-prvs: <DM5PR2101MB1045699D38CA47B9E60B1BEFD7740@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(71190400001)(33656002)(11346002)(5660300002)(71200400001)(97736004)(8936002)(2906002)(2201001)(10090500001)(966005)(478600001)(486006)(10290500003)(81156014)(81166006)(25786009)(3846002)(86362001)(6116002)(229853002)(4326008)(86612001)(68736007)(6246003)(6436002)(8676002)(186003)(2501003)(66066001)(305945005)(7736002)(7416002)(52536013)(105586002)(8990500004)(74316002)(26005)(22452003)(102836004)(110136005)(476003)(7696005)(53936002)(6506007)(6346003)(54906003)(316002)(1511001)(446003)(9686003)(106356001)(99286004)(76176011)(14444005)(55016002)(14454004)(256004)(6306002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tSTCQXUP3bBYyhXqNuzqN2NGcyQQL9s10gszTtW9jVXBWmfw2EYyZfYWUO/S3jOl1xURhzItkN0MeVpJKSglKbaP8y1SDhqbYKGUIXCj69i79dNM5UVVU0s+KnhfkAGl2C6ACIhtKCrqLO3XBQrYLa1cWyYLVJ7fN5vPbeD/Ljal0u4HKmmtNSvgc67H8APTnVi8xb2n6JOg+nSXoWR1C2ZBUk+crl9vj2YzanUPsQt8pE8bW+ezI391HfW1onw75Ohgm946PbLNWgXpfCI1Q/71+ZYsyEa0INNycOSECaumyMQ1e7vQ0Kwd+s4hpKtcL48wmHnTvd+3ENJU/BAzaiq8x7gfUnKDUH4E3HhZ063aLueg8Y9k2eD76EcMhr8H+1u7AhyJJSc034y205XZojL3DvgqGbAg9pZyM4t5b/A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f8bd5a-002d-4721-be57-08d69cd96e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 17:31:38.6979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Wednesday, Fe=
bruary 27, 2019 6:54 AM
>=20
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
>=20
> This patch is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2API=
C
> interrupt remapping capability when X2APIC mode is available. Otherwise,
> it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
>=20
> Define 24 IO-APIC remapping entries because Hyper-V only expose one
> single IO-APIC and one IO-APIC has 24 pins according IO-APIC spec(
> https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf).
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>

Reconfirming my reviewed-by after the change to fix the
compile error detected by the kbuild test robot.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
