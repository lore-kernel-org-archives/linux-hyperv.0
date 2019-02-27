Return-Path: <SRS0=Gp0b=RC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1882C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629162184A
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 18:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mH4nCL3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfB0Svk (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:51:40 -0500
Received: from mail-eopbgr790121.outbound.protection.outlook.com ([40.107.79.121]:21526
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbfB0Svj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 13:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zryiOFKIJTYTcIQOqLlHyUjq3pZdlJ1Rs47u4Hu1CYY=;
 b=mH4nCL3r/mOsUZRBUYfdBDqEM8ejfGoDqdVQ130XrxcvHFsJ/4aCaNcPUglix6WU6hcI80sKoIcK3WUrdsSurhjOTx/eIzOKNhiOJkMnLwSqKZncnI1WY3nd4lTkpNms/0bjsX0Sr2DqJ7KPz21V3KmRIBEzg5XqqA40uJXIA4w=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0725.namprd21.prod.outlook.com (10.167.107.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.4; Wed, 27 Feb 2019 18:51:35 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%8]) with mapi id 15.20.1686.003; Wed, 27 Feb 2019
 18:51:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: linux-next: Tree for Feb 27 (mshyperv)
Thread-Topic: linux-next: Tree for Feb 27 (mshyperv)
Thread-Index: AQHUzsF4gZUpmHqus0On6lHAoyxD1qXz/Dnw
Date:   Wed, 27 Feb 2019 18:51:35 +0000
Message-ID: <DM5PR2101MB09184DFB7037015F99C5EB93D7740@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190227174427.4e8f7f24@canb.auug.org.au>
 <a6cfb923-c21e-b0e3-44e1-33197aac2625@infradead.org>
In-Reply-To: <a6cfb923-c21e-b0e3-44e1-33197aac2625@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-27T18:51:34.0629772Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d5e4ef7-677e-46ff-86c7-2af0f2826932;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d45d526d-e9e9-4524-8690-08d69ce49932
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB0725;23:j118zkcHeTxaZKkBa8HZkY4K92gvp1XaWadrDZo?=
 =?us-ascii?Q?oj3K66Y+zMAB9x2OVORjm6qyLau6IQLGEYN0EiBb5BKG8rovb62cMnwkaSUz?=
 =?us-ascii?Q?bMbx0JHMMR28GxK+joyRs3/RNiQbmGCSSB+s/p/HZboEy7ReHt/i/PpNxS8h?=
 =?us-ascii?Q?tkYMHZ9S8RZIP0fIcM+MgiUVlU17T5/vDaQdUCgbnB1hBFGg8PvXk+GOfTfS?=
 =?us-ascii?Q?2PFixR29x+QKp04sWnJUu7ayxYCAFu7AZoys3MVDPuUUGob73QxQZ+num4Cy?=
 =?us-ascii?Q?qk8V1JKHjb1Urvy3wKjU6VF67v7MgxAXb1VZMFH+XaSuhetWk9cU3HZAMz/W?=
 =?us-ascii?Q?eblwpL4VED+tcSXa6Nc2sg7kJfdo9itd1/Sdt8iuAi4WEJIyWYsSZ23aRcIx?=
 =?us-ascii?Q?CgkWN7zvCDmrM5uG89X6lg4OaPHKuGEV/65tVXrQHGKFm+Ht4q31O39OBhv1?=
 =?us-ascii?Q?2alBoFYeIgwZO/mp8uAzYELMFx4b4pzTIGf9whS8Ks5VsRBP05PeHV9OJLRk?=
 =?us-ascii?Q?01UpPGxvOuFgMkp2F0akDVVL41tMd1f6byQbHX195n6TwQuQZ3XsN8FfN5Cf?=
 =?us-ascii?Q?yGUSqesIkph8JdddneNjEPGKYznUETBNe8dqPomUNVjnSRXatO9aLr3aJpYs?=
 =?us-ascii?Q?Ij62zOA0CvvmMLSg5LckjSUqtF+DvNPg3pQY1MQQoxBwa3v6/4/c3C3Y1fRF?=
 =?us-ascii?Q?D0P6lO1uddldwFsirPI2lWf49Gxk78k26CcBPbH2X/l2ASmvvjP8qpMeQvuW?=
 =?us-ascii?Q?il9KcF08cZWxbqVPMFe4TejUNmaoOHijCRwqmg+e54f5ko+xaTWqlgYD/T1F?=
 =?us-ascii?Q?Hz4KdLvzjxAwLup6Kh4BtQZ/edVag7trxEkldNSt29HmwqBMrTNSjjcYJwVf?=
 =?us-ascii?Q?M29/yAhuQOjAa6WFhRGgH4HER62vXZam8QUBrcUYgn7RzQXo06IoHDrFfI4c?=
 =?us-ascii?Q?G9ryS37EPuyHW9PCtB0kjieO690dRgp6Asp9pb5mhy6wNj7fcKo6CXszXhZV?=
 =?us-ascii?Q?2dLDe3sZsXZH9bL0W5ywQpXhwD/hfeVJXKg0MntxHASR7Rfxzn/i5SUoed2H?=
 =?us-ascii?Q?L15Hdzmkj5TcS319YEgHyGc0ZfD0h27//EKmVd5W06Yam7p0Bcj3hRwDev76?=
 =?us-ascii?Q?U2AgRKi2pqLiZN+FJKYz2mkbdAyxozefPjTsLY8iVY4oyS78sEUzn+sHTi1F?=
 =?us-ascii?Q?n6OXbfp6fGv5u6xuB8whvh1CkAqpqTg5VM8D4xmwvRA3T3yumWKwJplGzTO/?=
 =?us-ascii?Q?D3oi3Jjv+Bhq075XoOlusZy6dIrVAKxvho83eKQ3BwF04XKNAW0qmUO8aKTJ?=
 =?us-ascii?Q?UWME4J93izME2wGxeiUkiQSZSpLuQsytkHp35oD59kxmZww+815uCGxRHaN4?=
 =?us-ascii?Q?goUhwofW7idfVxdpoCIrXh1qYRS3C4BUK/qHvnJCioA//AZKg/Iw1sKDzl3Q?=
 =?us-ascii?Q?5I3kfwmiVf9zDGyFrUgbgnQZ8v8uBjQI=3D?=
x-microsoft-antispam-prvs: <DM5PR2101MB07254CF574C5E4499FE5AABFD7740@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(110136005)(11346002)(446003)(66066001)(33656002)(476003)(8676002)(316002)(53936002)(74316002)(3846002)(486006)(6116002)(54906003)(10090500001)(26005)(5660300002)(6506007)(4744005)(76176011)(1511001)(81166006)(81156014)(8936002)(186003)(102836004)(68736007)(22452003)(6346003)(99286004)(7736002)(52536013)(8990500004)(105586002)(106356001)(256004)(71200400001)(71190400001)(305945005)(55016002)(9686003)(7696005)(4326008)(6636002)(25786009)(229853002)(86362001)(6436002)(2906002)(86612001)(14454004)(6246003)(478600001)(2501003)(97736004)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XTFHLKI/RS+EWUVqbmOM29Ez2shbw5QVL2MF1JXBrJqqTMU/+1XNBGAujTL+qTPnm4JM+V64orISfGmEZd6lBuRrZOxOx8c5tNKEvSmgd4SKrip5EQ3Kzqq91Ez/+gjN/MHQti5s/hmNR5ypHaHLXiOqEfVp2hbEkxJW+1O6K3iXfZeUDFyzCunhhF/cozRIXwHGKIdYiVJ1v0aepJw4dqbDIUQHYxEVwjMzeR8f8vq/QCK+4XHT9AEnr1aWs3szMIIaCq4PF0i7EQ8zMiBrE13po6v64UovJ7C6Nb2mfvo7kHaOakznFFUTDCqoRUM1Lo2GHt2xvfSLOBZVu1Gj4arJNzoAZGPd8V2YlZUyN5U+/nY8fBekvQ3gXHMy8PVtDSN06KOtnTnp0gRQJTmA7tMgbtdqx7iLchA3vYMrMDY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45d526d-e9e9-4524-8690-08d69ce49932
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 18:51:35.4976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org> Sent: Wednesday, February 27, 20=
19 9:25 AM
>
> on i386:
>=20
> ../arch/x86/kernel/cpu/mshyperv.c: In function 'ms_hyperv_init_platform':
> ../arch/x86/kernel/cpu/mshyperv.c:339:3: error: 'x2apic_phys' undeclared =
(first use in this
> function)
>    x2apic_phys =3D 1;
>    ^

FYI, the kbuild test robot flagged this issue overnight, and Tianyu Lan sub=
mitted a
fix earlier this morning.

Michael


