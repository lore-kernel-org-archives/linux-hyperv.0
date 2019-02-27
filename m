Return-Path: <SRS0=Gp0b=RC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D83C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 17:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D141A20C01
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 17:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mKP9FyMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfB0RbK (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:31:10 -0500
Received: from mail-eopbgr820100.outbound.protection.outlook.com ([40.107.82.100]:6509
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfB0RbK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 12:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6I3Y3MjkTvtPUHK9VBDqMvb64MShJBxgkg6u3MX0x8=;
 b=mKP9FyMHLEr01eUGgyj9IoqyHGqRkVcUgU5DTIkEjzYWJ4HfMFAdSv3XDjoiZVIlCajLW82uu5PtnS5Lyaxnsf61npKWztIGhAclUIrfHCcTkFvSie8yWQgNNWURoSHmhP3vF5Ue5vKndP5zGF1PQcVSeYkm/0lCklVJkfs/B8Q=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1046.namprd21.prod.outlook.com (52.132.128.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.3; Wed, 27 Feb 2019 17:30:27 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%8]) with mapi id 15.20.1686.003; Wed, 27 Feb 2019
 17:30:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH V6 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Thread-Topic: [PATCH V6 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Thread-Index: AQHUzqxg/hZtMFOrpkGZzHcIOklRl6Xz5knQ
Date:   Wed, 27 Feb 2019 17:30:27 +0000
Message-ID: <DM5PR2101MB091823BD2059EF420F4EFF4CD7740@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1551279245-25888-2-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1551279245-25888-2-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-27T17:30:24.9550519Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec32e336-3244-40cf-9fd6-86494a9d1cde;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e231bc02-bb9c-435d-b105-08d69cd94364
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1046;23:IQ+nFtARHjA1YDHjKXLre8Nf2DIjp7aIwhyRMxv?=
 =?us-ascii?Q?twNi71ntn2vQME6w+9ktX0UAexpZF7dtX53GOXX6Ef9XOwMbGXdeSuoTaS9G?=
 =?us-ascii?Q?0WaIR5KMvsBEN/yeb90+tbFc43f3ssb5u4TdCVj9GgzbwifUrHS1Qlbxu6+E?=
 =?us-ascii?Q?tBeMm8atcpv2qgE9C2WqEZ8eLHcsfCj+YWTUiyhsNl/8QgqLLWRSXZ+BMZu1?=
 =?us-ascii?Q?b8MNZ77PlUTVioWIwHlCa+k3XswoT7X9PC+mFxefuOwEGqYvdGVdVsWpzgNX?=
 =?us-ascii?Q?5+tKlq20JMFdbw++NLmOuaZOIgV7LveyZAFxLUQsTx9VLKw0DqBiSrAUHqiq?=
 =?us-ascii?Q?mT/iiL3nAx8Gj3C5pxVrq8UoNetVKY5jnP8ZJi72VShUNg84ANR0NAu7Nfcq?=
 =?us-ascii?Q?IEougKh35EG5cmmK4f909vY1ONNU2bso3+AfEoUQJ+/KlYJpxwLcCxZktcQQ?=
 =?us-ascii?Q?3TtHPtfooOCry8GNWvO0HigCxWHgiAOHOpju/ALL82iLdOIxpm75DXC6e2E5?=
 =?us-ascii?Q?dY2mKnaG1sVXBYhmt1moxVohB+SwiN6qqGUXy5SFkyB/qW7WbOZDsZzUXnaL?=
 =?us-ascii?Q?ejcDyfAOLcxA63DFX+hoxhXjZLuwYwZ0YQS4aHhf/NNZaD4H6NNaKhx7B7Ob?=
 =?us-ascii?Q?oLfUgVbYwF8AADPIT4Eyqbe7jK0TUW3a5DOblezHyTwJTd1VMVu781StW3Fy?=
 =?us-ascii?Q?oQ3GivHM8Y0KK6tInsm3wbQ8CmAEGx09Kru0mXT6YV1vEEOQP7JfHaBkm4Hf?=
 =?us-ascii?Q?Xqe8cBMHFgivwHXq0/NjHZcvFwzR3/BCqj+NeI6+9NUCxVqlZ6Sd5cOysGRz?=
 =?us-ascii?Q?W3paZphnl6rmh16H248ME4nJYfnZMv0TOto+abSjxPjnhipXUorUjsm0eVI4?=
 =?us-ascii?Q?Bw5wID8XuN7ofQRF+KfmGcNm6scnG6fsm9UkEqfArOS/KKRGKOwEYseZdNR+?=
 =?us-ascii?Q?QabFwQbvdk9E7WK54FjRFSPxEz2jCkIPk6UnDv9KFp0TL9Ne+UpeAWhZTxWw?=
 =?us-ascii?Q?M2UYpDgKMLJE3/6tpn67QYCOTng5cH7guzgy0aTCDILGZzwhEuy10sIjcUcz?=
 =?us-ascii?Q?mjJG/smHG1+hBBlN7j0POil7lEVqFKhEOrnzXWGmYv+4JRQH5wwBaTT1vUvS?=
 =?us-ascii?Q?SJ44JOHHmX4rxnUebf7k7KPPPQ0ASrnMtVjbwT8stxLAH0vDX9KXf94fBH3l?=
 =?us-ascii?Q?NHu0T6jlbHlcZ//GQdkaYi6HcYcOdCeenF5pOowsLTB4nOO+VEVfmOpIOF+g?=
 =?us-ascii?Q?/u/kA/GMFLbArLzrbRoR2s6xzGmEgiL3UEp2v8SWziYy3dfOXcAm3F+rhtm/?=
 =?us-ascii?Q?ANEjdEVkaQoBElqgDva2mEakmoQLuW8cPVlB/M16g6xz7LUQoqWBOucYO24D?=
 =?us-ascii?Q?lKu5385BziSykmWi0rYv9ejm+G6IQs+rDEQuzT0hEm5ntfQtm4oy6PENsXCx?=
 =?us-ascii?Q?+vPxH46EC+Xa23v+XZt/f9E5Bk71yNdIfl816DZ9TEl+AeK2AMfBrDxI6bdX?=
 =?us-ascii?Q?ijQVR64RTZy9JIA=3D=3D?=
x-microsoft-antispam-prvs: <DM5PR2101MB1046FB1455261F23BE4C7C2DD7740@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(99286004)(86362001)(9686003)(81166006)(81156014)(486006)(476003)(2201001)(11346002)(5660300002)(4326008)(55016002)(8676002)(305945005)(446003)(52536013)(26005)(186003)(2501003)(74316002)(6506007)(7736002)(102836004)(6346003)(106356001)(14454004)(7416002)(10290500003)(25786009)(22452003)(2906002)(33656002)(110136005)(53936002)(256004)(10090500001)(68736007)(8990500004)(66066001)(8936002)(478600001)(316002)(6116002)(3846002)(4744005)(71190400001)(71200400001)(86612001)(229853002)(105586002)(7696005)(6436002)(6246003)(76176011)(97736004)(1511001)(54906003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DsJJ4LIhlhEN1zjK20VkbGoj8/KohKNbOwAcggXIQR2oNDzSVRsFIBkD1XLhsOvmEoyCgIJ4koZ/5MQ9jU0a2sHBZA2mWQHZcTyGq5N0/47cGHeWVmF0PBKrsYKoB9EJjD6paRWcJLJinbFzPSUeONhBWDMD5pjErXq5FiOiWSQ0hVAd9fQHWOOgou5Wv5Js3V7Nu59k6EkIC986yS3yMySq7o8uFtwRvSuI4ZuGOPQLdBxxic6dzZcVepVA3yDgg4tWMBrIODiXdjm/n/cfg1AkG0kIDS9hMdG3NVFzmP0kfa5c8zGZEHrJQsopQ8mBBJgW7DA1bzQOnONqR+zVwbg7dzTDaYE7+LArccofU3DjqEkOGe8gTQvRipx9DfPKSoAIVTzMY7+c2UMWLmqDTfm6P+uwnmy8s118Q5hdRB0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e231bc02-bb9c-435d-b105-08d69cd94364
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 17:30:27.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <lantianyu1986@gmail.com> Sent: Wednesday, February 27, 20=
19 6:54 AM
>=20
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
>=20
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v5:
>        - Fix comile error due to x2apic_phys
>=20
> Change since v2:
>        - Fix compile error due to x2apic_phys
>        - Fix comment indent
> Change since v1:
>        - Remove redundant extern for x2apic_phys
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reconfirming my reviewed-by after the change to fix the
compile error detected by the kbuild test robot.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
