Return-Path: <SRS0=8B77=Q4=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42AEC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F082080D
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 17:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="at2pIQ1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfBUR2r (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:28:47 -0500
Received: from mail-eopbgr820117.outbound.protection.outlook.com ([40.107.82.117]:58416
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfBUR2r (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Feb 2019 12:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKaRylScQQBwhROxX4U0T7hS0cLJgwGBbS4QK9UTij8=;
 b=at2pIQ1OKteBSAEOZ2ZDXnIcwQhq3mOTOny9GqCAzkfVA7T58+fPSXIsQFc5SGrpmcfjjKfFb2Hto35yc8WZxpbpQghXrF04lTzhvjvNmuVf377TW2OVmFlyZXzctz8pXxHz4QaSOXitRyDyg28TnuuBk/4uefAlwbNYDGTosqk=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1094.namprd21.prod.outlook.com (52.132.130.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.2; Thu, 21 Feb 2019 17:28:44 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%9]) with mapi id 15.20.1665.006; Thu, 21 Feb 2019
 17:28:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH V4 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V
 CORE AND DRIVERS scope
Thread-Topic: [PATCH V4 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into
 Hyper-V CORE AND DRIVERS scope
Thread-Index: AQHUwhUGZWDykT7zJEKi89sJgY9i2KXqkVMg
Date:   Thu, 21 Feb 2019 17:28:44 +0000
Message-ID: <DM5PR2101MB0918A3F6228F1522F58C4FA6D77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549894824-26623-4-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1549894824-26623-4-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-21T17:28:42.3159341Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5e644305-ac02-4817-84eb-2d45be76a874;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ba08051-7227-4b01-f4bd-08d6982207a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1094;23:kYj3DJCmsrk1T2bZ+syEk57AoJIDmmGek68hKc+?=
 =?us-ascii?Q?Zn/T6DSuXquQzYULBydfL96VVNe0rB0WCXsDzLdrnJgYTok+bCbjmnWRrFmv?=
 =?us-ascii?Q?KT01+o8XnBQk4oczG0ey8qzVoL5MnJ+bxbBRlTdn6P+ymnb+6oPuOlmLLQ8J?=
 =?us-ascii?Q?m5s0p1zjhChrE7UouKPglrE8sMNmvA3RDJeDdfugqWAztoe6pXT9oLo9OFGn?=
 =?us-ascii?Q?yAhwAs5QujHOaSash6tXxgGmTfnO9sS+Ha6f/968n69qHqg5V2iYk0/0BOlk?=
 =?us-ascii?Q?5HwVh2dBT8GHiq5JJxXqxDGjKH8UK23kZoe9dZqwKzZr/wBwT54MAgPCKAQW?=
 =?us-ascii?Q?s59KvXuHeKclBcHQGM6ADlqeyLTmtFgaKirCtzCYMJXw3rY76+DOwbFwc9X3?=
 =?us-ascii?Q?CFGVUroYTPKg+w/T9LO5iAqcIT79YXqzU+fdStnE7lwhYKrLANW/104P9QTk?=
 =?us-ascii?Q?y6Bcx8jdfWnFKc9u2gZO3vqrMlTwpRch4m2QpHAU2VF41DPBs3JoQhYxHleX?=
 =?us-ascii?Q?NLG28yk0GTMP9cgpR4DVoLFZUTO4qTFvJyKbMIy2CZUHivj8mGJ7QTbtOMWc?=
 =?us-ascii?Q?0MfIa43QX3hRVBQ/2zJhFqvIQuybPoEbYy4Hmb0qLQLkpITIMOnfbfXkRNiT?=
 =?us-ascii?Q?jwk9OxZScyb9/dyRyECRxEOtft9RnbdAHI2jztm+9dH3VqsS3HnkFG6FFN/Q?=
 =?us-ascii?Q?AJm7VCKOKWjvJiAuX34Ocm2C6sSLqRqIKaGVdfo+Nx3h5VG3ZiSmVHmmuCef?=
 =?us-ascii?Q?6d+T3Y0doc1MrlE3uePPBuvyCmG7n4J2L5nqig/bmJtvCmXUWUG9/8qn3f5G?=
 =?us-ascii?Q?pR+ttPeeaI/RwnPPK2kxUfY12UfLIkEkrt8jNa4TEALtWdR7eaMHIuX4Whhb?=
 =?us-ascii?Q?haQvfS30gM6VI3zulYFKygduwGZAo9EBT0ycuqddYrGYsZH8k7C1ZbD0t1Tv?=
 =?us-ascii?Q?NTE0O9asAu+pQKJccS/0+O3X6lyD1IZAIpBixYQyDDEKrRzvUO2QhyAe9Zm6?=
 =?us-ascii?Q?5OJ+xFJkusJL8zRLo9bbPNK5ozX/fwEiDiJe1+s84DpgmJylVgevo6byzdzs?=
 =?us-ascii?Q?/eqv9HBB6FtG0gRo4p5zYiQXuB2whpepntQTgj9FqEQOaWO8Zbo2P5RcUoZb?=
 =?us-ascii?Q?FIBRRhnQOVCRvuspFk8GitLn7wXDFixgPdPFqvBm7c2Mo+pWG7FSuKBB+1QZ?=
 =?us-ascii?Q?JAGl9L2VB7TCDLeXo5BsMPHuLS89tr91TQ4cSqTn1SXiEEwhZImS6KrtEGfK?=
 =?us-ascii?Q?T4ZDuuMJM2lGhPxLp5aJPTVnzhmD9YqxTbZ1GyKA68SIJHIg9kmLNtvFnhSE?=
 =?us-ascii?Q?0JgqMjoV2SDmLe9CGdwyApl45HaBelJHeR1CT9KuaBSIBENyGuxr1SzuLvrO?=
 =?us-ascii?Q?u8fxJzStEeVdfVZvfvCJq43n8cYuintrv9h2bpcniLAA+qF7okUE5VUWWbFR?=
 =?us-ascii?Q?aiCRVSLfajZQKM/whWDI+jNE8Eh9xn5GOuoABhCstqZfn2nAAZPeVSLB96sR?=
 =?us-ascii?Q?mmCohwpahJtyxAw=3D=3D?=
x-microsoft-antispam-prvs: <DM5PR2101MB10943FF220AEF5B005469DF1D77E0@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(76176011)(53936002)(6246003)(74316002)(2351001)(54906003)(6436002)(55016002)(22452003)(9686003)(1361003)(99286004)(33656002)(7696005)(5640700003)(316002)(6506007)(97736004)(8990500004)(3846002)(6116002)(1411001)(81166006)(8936002)(229853002)(81156014)(6346003)(2906002)(2501003)(186003)(256004)(4326008)(26005)(10290500003)(558084003)(7416002)(71190400001)(5660300002)(71200400001)(25786009)(8676002)(478600001)(476003)(486006)(11346002)(446003)(66066001)(7736002)(6916009)(86612001)(86362001)(305945005)(68736007)(14454004)(105586002)(10090500001)(106356001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GkywrY7ynjrDJmeGC7Gti4bUoA0/y2t8vw8sWl5TBZ8/R6bAnqed3ud0ufRT530h+OaBdjSuZazHCUoor8/hFSMC7DgzbyZhKnsmzNE3e0PrWrNp3UbYUO136oyeZrbRFxEGoVQsoOvXzoFlpRGg7HzswSDf0g2Y+jbcAcqWnq3XBY4SooHP/afj/y4pLJ13P2zhb1m3XWtn4yCX3NU5FYJPYUJkbek3qezZrOcvUsOZsHvVEFLCoWaY6Z8H3c9TmC58PQE7rS6kBnwe/r6TCOst+OKHrvOrWPiQe4Od3cxNASREq/9zsIp3I/v1qt7os/n7zZjSYpf0Mx3oUgTXmpb4kyDwPg0VItuiOSpSz0It3nlwKDWpJNOkKrbumH9s5IRCHAjGLIMFo5qLUmMDxk0U4ok+6ZGvZXrdZyLF8ok=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba08051-7227-4b01-f4bd-08d6982207a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 17:28:44.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, Febru=
ary 11, 2019 6:20 AM
>=20
> This patch is to add Hyper-V IOMMU driver file into Hyper-V CORE and
> DRIVERS scope.
>=20
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
