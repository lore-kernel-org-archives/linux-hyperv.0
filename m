Return-Path: <SRS0=lZBM=Q5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B5DC43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 15:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11C12070D
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 15:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O51xw8ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBVP6s (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:58:48 -0500
Received: from mail-eopbgr770103.outbound.protection.outlook.com ([40.107.77.103]:31744
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfBVP6s (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Feb 2019 10:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey8auQpMXsv3z6XFfnN2WUhjQUQu9Jst6o0HrvR+FI4=;
 b=O51xw8obwvjnPBi9sL/WzLaGEJsUNmBHn38xmFpqZh5EAHuPKmc1RPJbiDMnwRWXVd/XrG3ppKpI1SpUrPekAf/q+Dq0fpWLeJouJLGSkUYwvXGhccvzKiYOr3KfDxcDsY2v3B2ZQk9jzufYDwBlmjgBEpxNzbXEcG0yiLCfyHc=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0805.namprd21.prod.outlook.com (10.167.105.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.1; Fri, 22 Feb 2019 15:58:44 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%9]) with mapi id 15.20.1665.006; Fri, 22 Feb 2019
 15:58:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH V5 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Topic: [PATCH V5 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Index: AQHUyqfjAemiCOG7hUuk4DOeCKQgBKXr+QVA
Date:   Fri, 22 Feb 2019 15:58:44 +0000
Message-ID: <DM5PR2101MB0918926EDE4D256EC16637A7D77F0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1550837545-10760-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1550837545-10760-3-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1550837545-10760-3-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-22T15:58:42.5622310Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c9db74bb-f88d-4e1c-b099-94266bcb06e4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22d2366c-a55f-466f-0eeb-08d698de9f88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB0805;23:I8Au/F7XF2lZCgtIQcGyl4MyEHoUMoYIBfHgNKy?=
 =?us-ascii?Q?JqBZ2O2PcbG0TeD/CimBBjRCeMcWCv3BWajUXUyvtCoA92+cVrh9DUjfYeDr?=
 =?us-ascii?Q?LAvPJNVjXVfmeTgEC9XjcPkk2k5RcF0fZVUs+V5lNAgPV+pEChD/4YY2lRsv?=
 =?us-ascii?Q?DvY1m6PCkS51Xxqd4/EAhSbQSrQBCfNGxlVp1T29bvADJ9FbBDgw+Ksczxv1?=
 =?us-ascii?Q?1dpWibFaeLom9Mker5e7hUnaNuOu4cjlpSlnRS83pYU/74RR3kPsw0wp27uf?=
 =?us-ascii?Q?byERH5xxlfanhyVs5tpqRlECRzvWsfUU75h4TRfvhkS86whDXMMuucKvVRB3?=
 =?us-ascii?Q?mx2DSxEb/MhZQUB5wmSWJLi4dep5zh6mEfKsWfKTjXGrF+BoVteZCoFYyqVV?=
 =?us-ascii?Q?+LJMliSWRQQII3DRcNC4Vb0ibg7pdeCof+MHKI2SqiG20BUmOGtyxiXSZDZH?=
 =?us-ascii?Q?QpRTWVnNr8oF5917jbclaiqxF2t40JiZCv3TXX1K7vNrX9REbJeDeqaDqJW0?=
 =?us-ascii?Q?pOLxRxK8kYeqEpfZmXeiI7JX43xrHtq+qHY4ETgqvnvQPAq5tumtZv4/rCFS?=
 =?us-ascii?Q?pwp8Xu8tfwUo7Fq8VHpv2kssr0fiUhrhczAyq6KZOM/9CqAMGE0vVfzDCjnS?=
 =?us-ascii?Q?o3eZIocDfEj0veXC3tniWAUOW2LQdlncaH40aZZppoyIskTpdyQNsz1NOaSl?=
 =?us-ascii?Q?gFzhkaxtyjzAPVjHb5HqukClKKDQkOrm2Bhw+MhCyHAsA4zXt309q4IkjAcV?=
 =?us-ascii?Q?HpwXLDo6C6k0w91Rh9qxVk1vl/5dOfgfxEOHi/I+pSjSVqGXM+58saeCpR5u?=
 =?us-ascii?Q?iefXI4EnU3BBVfVLyC7PreQ68mWU1aalI0G47dXkrLlPHwKmz0n2ySTLAr//?=
 =?us-ascii?Q?euOcsLTRRnJ79JCvdwHZT8ufy4r5Uja78bKS+xbNRjCcpwCD0oqZZQqyKXWW?=
 =?us-ascii?Q?lXaWs6Z5nRH9zK9AlVbcVBSBvqZZm8JdkSPQwxIlMsn+vZxse6wfgA/sED4r?=
 =?us-ascii?Q?AXYuYtJyR9WytkyV6JEuZP1E7TFlg9LUbFRaCNkxejns4BpGzVrNqy83ElzU?=
 =?us-ascii?Q?qdGWcAyu0QnXgSTBAkF8XG9rQRj2swNKaKiBE4VnjvMtE4FODnl0AMUh+Mh3?=
 =?us-ascii?Q?FN1YEDxN5OXiN/HqrKT+EYK1A+RA5H53vootTulGVMl9Gm+wM7Yj20NKSqqR?=
 =?us-ascii?Q?XJB32L0r7ah51TqEmPa7tKlQdJvyABRgxqbnLfwCq4ccfpIqU59h3dG129+W?=
 =?us-ascii?Q?vE5Xk9gRXXXZ6qDMQL9+4fqcCL/+uDFshCx223NfWsAged1Jc+njZr3QVEAN?=
 =?us-ascii?Q?3qogslq4kG6+pfTX8L9K9dsqG7rsfat1+pHeidNPMwn/cijDg9BYddWXjJYm?=
 =?us-ascii?Q?l5YSw06DsvDiR8/+JSIHRsBqPlQ099b0I9j5GCZ/Ewg5ZjN4LEtcslKvTwuc?=
 =?us-ascii?Q?GFBpywlHGWB3DCjVEk8T3DfBU/3F1vqk=3D?=
x-microsoft-antispam-prvs: <DM5PR2101MB0805B81E7990574324A3F694D77F0@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(305945005)(74316002)(66066001)(478600001)(55016002)(106356001)(86612001)(97736004)(25786009)(7736002)(10290500003)(6306002)(33656002)(14454004)(6246003)(1511001)(6862004)(53936002)(4326008)(8676002)(81166006)(81156014)(8936002)(7696005)(86362001)(3846002)(76176011)(6116002)(99286004)(71190400001)(71200400001)(966005)(54906003)(9686003)(6436002)(105586002)(68736007)(7416002)(14444005)(22452003)(6346003)(102836004)(316002)(26005)(6506007)(256004)(186003)(229853002)(6636002)(476003)(8990500004)(5660300002)(446003)(2906002)(10090500001)(11346002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DNvlmDWopB+rbapNknLk8Up9ItuwpBie7pbym7NpNOnOnMBGLx+WCU2J5loUy0ewFCPjq16n7eYNVdiGLtQaj6dExqD8PZMykmd34GDql97gKIyIlgfypOfhgPSzebJmNuyuI1KKg1i1n666pqREA6rnDNn+d99KaGxL8tOGuXEa90F8wAHZewdHLlfn/SlGPsnopX6/A4ytrK+dqvZLk/Ck8FXD0mKJTuWeuXB8WpIkbXTxyEybjbreq6m6iqXur7Q1e2i3LinqE6lJpOWciHxXEMtHT3PJDo6ave+Iuhdc/iLfyMIYdgU1D4AQMeBq6UXoHRoXA2eEhBsBKGE8tHMjfdnpzno6BJDFEfBgYHoUOKAnrjMzW5CNE3BqQkt0hVfwzkriBogwEw+9wrtgsonj4z6GWwsWxFiZeR/Be2E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d2366c-a55f-466f-0eeb-08d698de9f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 15:58:44.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu.Lan@microsoft.com <Tianyu.Lan@microsoft.com> Sent: Friday, Feb=
ruary 22, 2019 4:12 AM
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
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v4:
>        - Fix the loop of scan cpu's APIC id
>=20
> Change since v3:
>        - Make Hyper-V IOMMU as Hyper-V default driver
>        - Fix hypervisor_is_type() input parameter
>        - Check possible cpu numbers during scan 0~255 cpu's apic id.
>=20
> Change since v2:
>        - Improve comment about why save IO-APIC entry in the irq chip dat=
a.
>        - Some code improvement.
>        - Improve statement in the IOMMU Kconfig.
>=20
> Change since v1:
>       - Remove unused pr_fmt
>       - Make ioapic_ir_domain as static variable
>       - Remove unused variables cfg and entry in the hyperv_irq_remapping=
_alloc()
>       - Fix comments

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
