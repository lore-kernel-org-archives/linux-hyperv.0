Return-Path: <SRS0=gI2d=RA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89226C43381
	for <linux-hyperv@archiver.kernel.org>; Mon, 25 Feb 2019 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3341F2087C
	for <linux-hyperv@archiver.kernel.org>; Mon, 25 Feb 2019 20:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m8bnHjdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBYUv1 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:51:27 -0500
Received: from mail-eopbgr820095.outbound.protection.outlook.com ([40.107.82.95]:12064
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbfBYUv1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Feb 2019 15:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sx3JNltH6HEJz9rnZLOz5RM6rY43l0+MvXS8FyGqlw=;
 b=m8bnHjdg3urualh3CS7gKmeGVIsd5BbQy4SqcKJVafGSXBDXLZwwcuoC9i51EPEacpPoZL9wWCd0Ofc6exhlOYzRBXDLZWASMr+Lzs2w1OnJXNMVSFKoY9cjZnQt0rLbTDAAMhhK35IfUNNBPZY3Dn8lHILy7EkWP0MW5Y5S0qs=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (52.132.133.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.3; Mon, 25 Feb 2019 20:51:22 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%8]) with mapi id 15.20.1686.003; Mon, 25 Feb 2019
 20:51:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to
 support x2apic mode
Thread-Topic: [PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to
 support x2apic mode
Thread-Index: AQHUyqfkQpHcfVLkgUq6wJWKYfDUTKXxAE0Q
Date:   Mon, 25 Feb 2019 20:51:22 +0000
Message-ID: <DM5PR2101MB0918EF12A3B75142EC54D754D77A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1550837545-10760-1-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1550837545-10760-1-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-25T20:51:20.7243693Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=667d574c-40ab-487e-af4a-a918ecfde09c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:8:6c98:1433:b92a:1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b0288c-c4f1-4216-03dc-08d69b63004f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1015;23:Hdb3RQVs6jJXncVClqNAuusZl7kMBFGLVyqv8ra?=
 =?us-ascii?Q?DKXzYqs+HSEQRcWGQcC0Eg0nTA4sR9DCf68FU7k1lvBZwKpvf1ugXsG4l191?=
 =?us-ascii?Q?GR5Ub8uWqShSaLl/6L+Ww/L1yMdOSUz433Zb+tSrNmTBAIrIOQBcVT9um6qg?=
 =?us-ascii?Q?AmhulOIzEE4eH41/87UpvgW/+AVe7ukvUKC+CLaWZDrlbHZsrzUWY1d3pgfw?=
 =?us-ascii?Q?ahXFlyRec/GdYfNWcsda/VxoUHmyNiYcFuEl2D2nPywxZmk+PbMUPp1IQe09?=
 =?us-ascii?Q?v8sEtLr8j/6sQdelJhliqTjqV23AZBK3jkbl2ro9hjFRv4wP8BXopyQSAqat?=
 =?us-ascii?Q?BBwUtkgCDE+nws6c25iXwch2jCwFW+PJbOkeW8T8eQTH7zWyBZYXwakxd6Ye?=
 =?us-ascii?Q?Izqmj2pTa63aXzNwOPjYnF6e47vGmuLnXDOiAd+In+e5Pz6YS5RLexiSNrhC?=
 =?us-ascii?Q?CGI3/8iq6dCUXz+0aJ86jPHLECSwLKSzALRREPgivyZnQ8Kl/9uGj84JPxrn?=
 =?us-ascii?Q?iuG1KMaRTausu7dUS7IPFcVXZjqc9FNlEz/bK4izR8tLCSJ3/hRzS23gfbBF?=
 =?us-ascii?Q?7tUPQEPN4DCjQql+qhMnlncfGrOB/YDZT9/RLYEiBFQTDbi01a/QKEcs64s4?=
 =?us-ascii?Q?KxFSNEF0Ap0EEC3XfIRFwKa8vKquDabLTbbsUczgT1ZUwLAABpqKwEBe7iVb?=
 =?us-ascii?Q?S17TNcBDV6tEWTlS1QiFudLPqX/OKO9oiC6MX0JClQTAHm1tLp4xbZMcVex1?=
 =?us-ascii?Q?lbRqAGiMjiAQmPhQs9R3I0b3VxfsMIRqiZ1zk75pWfS8tG/kgZ8u7LMJV9I0?=
 =?us-ascii?Q?iv0WS5TqgfnpRFn0Ph8lCqFnTBZKOLYPpOMPjTyFaC7WJpmZSTDMZ5FD0U/i?=
 =?us-ascii?Q?1mWqXRdxiNfbH5XdNG5UWOej/gDUufUfdRO/22OFA1ez3zw375c9qLC0BZVc?=
 =?us-ascii?Q?uEPc5Yt59bN2A4jn0K6utTXIdORcX3zauMTitwB2igUUUpGUfD1ZnXY7HgvY?=
 =?us-ascii?Q?mHCgSc3D/9kicKk2+cSda5WYPcIwAaDwnJ7rhphFsoaQFxxJ6KGW2ZDYKhOS?=
 =?us-ascii?Q?VG6xUFLV5ygiWQ0+JOd6dffqEdNNSCCBsmo7koE3q5M1zuEdO8s9xtQzAOfH?=
 =?us-ascii?Q?RoPV0HSNol+ugzUMYjK+0pz9kD5g1yTe3A2B2TozeR/V6Zi5HjPz3HrLZ2ar?=
 =?us-ascii?Q?xyISEIRmEYPyrsoiiJuUOk0nUgFbbLvHCyv3hfeAPBMEy418T8GDeAf5IXjI?=
 =?us-ascii?Q?itY3imotmjgUPO4ulxTtCwuh1nltzIkPvHNL7JN2JN3YF5qJ1hXyPwNLb546?=
 =?us-ascii?Q?R8gbDm3NrUQCJ5m/UwHWiIb2ozH8hkaDwiUQ4J/zproXoPN0fqKSiwRnqdVz?=
 =?us-ascii?Q?OLZOcuZHQH+AAChbr0yk4+ibPojZLMF6fOuSYEarUFmPiVYKd5FDVdLOuOIx?=
 =?us-ascii?Q?qPElR/3KnxgNHkeNb2Mz/U8grPvOwGGY=3D?=
x-microsoft-antispam-prvs: <DM5PR2101MB1015CCD49F5EA3FFFD86103DD77A0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(8676002)(8936002)(9686003)(81166006)(6436002)(5640700003)(229853002)(1730700003)(81156014)(6246003)(99286004)(2501003)(76176011)(102836004)(6506007)(7696005)(6116002)(4326008)(55016002)(53936002)(2906002)(7416002)(68736007)(7736002)(74316002)(97736004)(25786009)(14444005)(256004)(305945005)(2351001)(186003)(33656002)(6916009)(71190400001)(71200400001)(106356001)(52536013)(22452003)(316002)(486006)(54906003)(476003)(86362001)(6346003)(10090500001)(5660300002)(478600001)(11346002)(14454004)(46003)(10290500003)(86612001)(446003)(105586002)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PukB1FDLN9tHiwKdAEV9WKs6FcPp4blANlbAkm6mfyDQVTREs+ldubsmuQrBMWqscwD0e5OGhaWPCspHojQW0JZ/fbPzFjOMkRlEqCmW7/Fjr5xDcROika/6//XKkDP/PyUnHw3PFHfWP651LeWbYkyaPx6hcPekfWrYZRKSPF5xWpHyG/g0gMQv3NeLTst+wWsiwXT5BcWxTOpvr7vLCAz3lKIuHBoXg+URRif0ullWUWZmKroL7TTxvG42GgsBOyKKW4qXJ9HoPUTpjGyTL4oZpigOUuBb0ycxpR/LSDmmMYjay32/0phqI995Ojr2hY4H67oejW6EtluaVG6iezYaNZkIGBPPbvA267HhODcSdiHMKKa6z0pHLt5WY47iNL6mW9YJRTW7EctmXJkQcNPEIZRMlBIpg2Jfh0FbXTg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b0288c-c4f1-4216-03dc-08d69b63004f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 20:51:22.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Friday, February 22, 2019=
 4:12 AM
>=20
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
>=20
> This patchset is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2API=
C
> interrupt remapping capability when X2APIC mode is available. X2APIC
> destination mode is set to physical by PATCH 1 when X2APIC is available.
> Hyper-V IOMMU driver will scan cpu 0~255 and set cpu into IO-APIC MAX cpu
> affinity cpumask if its APIC ID is 8-bit. Driver creates a Hyper-V irq do=
main
> to limit IO-APIC interrupts' affinity and make sure cpus assigned with IO=
-APIC
> interrupt are in the scope of IO-APIC MAX cpu affinity.
>=20
> Lan Tianyu (3):
>   x86/Hyper-V: Set x2apic destination mode to physical when x2apic is
>      available
>   HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
>   MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
>     scope
>=20

Joerg -- What's your take on this patch set now that it has settled down?  =
If
you are good with it, from the Microsoft standpoint we're hoping that it
can get into linux-next this week (given the extra week due to 5.0-rc8).

Thanks,

Michael Kelley





