Return-Path: <SRS0=lZBM=Q5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE3C43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADE52075A
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Feb 2019 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hEqvh4pG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfBVMOz (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:14:55 -0500
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:57312
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbfBVMOy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Feb 2019 07:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOEHeiitidRh6DEMmcbodYuE0mYazYgp5jAEtGt7+CQ=;
 b=hEqvh4pGv6p/UnwYk1BLKNjKhgLzLbY8xcalOIMQZVvwHif6zYMZPRem+eSaz/CaufyGgYEmgKv5BnOvIf/cY0Vf5gUTjYTcEDPj1x8InQ/e5/4JvzRxhkPMJ2XVzLPJ/7EbLO2mGmbOjDeUmXE1q1y9ddlImkmBhYER2xHUuhw=
Received: from TY2P153MB0222.APCP153.PROD.OUTLOOK.COM (20.178.148.142) by
 TY2P153MB0223.APCP153.PROD.OUTLOOK.COM (20.178.148.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.1; Fri, 22 Feb 2019 12:14:35 +0000
Received: from TY2P153MB0222.APCP153.PROD.OUTLOOK.COM
 ([fe80::54d7:8208:977f:821f]) by TY2P153MB0222.APCP153.PROD.OUTLOOK.COM
 ([fe80::54d7:8208:977f:821f%10]) with mapi id 15.20.1665.007; Fri, 22 Feb
 2019 12:14:35 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Topic: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Index: AQHUwhUE84k2Ey/KM0eLU3rWu6n1HqXqkU+AgAE6mZA=
Date:   Fri, 22 Feb 2019 12:14:34 +0000
Message-ID: <TY2P153MB0222F0ED0743B87BB103705C927F0@TY2P153MB0222.APCP153.PROD.OUTLOOK.COM>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549894824-26623-3-git-send-email-Tianyu.Lan@microsoft.com>
 <DM5PR2101MB091885D1CD3761322191CAAFD77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB091885D1CD3761322191CAAFD77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-21T17:27:35.7497325Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2314f9d2-8068-4997-b1ee-d7df58594c90;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [167.220.255.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fe61798-e9dc-4825-849f-08d698bf4f0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:TY2P153MB0223;
x-ms-traffictypediagnostic: TY2P153MB0223:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;TY2P153MB0223;23:aGbDaec5q+OGwhoTE30l+PfvG+/U76xd3U8+rITf0?=
 =?us-ascii?Q?xVeTXygCkcjbEq234YNPEoFifEdbt+4EtfuwCHcS5Q0wAaBI8YZ5XnigCaI5?=
 =?us-ascii?Q?JTrmZMWJEEx25V6uJLDgPaQWXUDneHApj7ssJBsshaeKtu85ZmLkitzABKUg?=
 =?us-ascii?Q?EVSJ9WZ1hAUpTgAade9ls8DQ7krJ3AJSjX/ABZ4Kaj4KPR97OtAg39huJ+LP?=
 =?us-ascii?Q?lbBR6JQxTNsJIgPDbQO2FhviZIRbp0rEtAVzyZteM8OTZHjSTVC565Ax4XVZ?=
 =?us-ascii?Q?i1Tu+q7wA333w5cIv1jFijkS5BGHQWKVjDg95vq+A31sE2em8SUZxDWePBIX?=
 =?us-ascii?Q?R7Rnb3yiY+Rf84zfA90fj2alanztm7pLTkhRWWfWw/ywGACUUUXOHOzajrWr?=
 =?us-ascii?Q?L5nWp72UCnMzzT2R4kztGW+0jPS9s8JheuZSwlmohEr4VhBSreUSyp4sUQsl?=
 =?us-ascii?Q?yA1H+Yhl80Jeoc3rEbG2oD8FHnLx0eP0XrjGoYvZ8WfvXoR0L5DpwwQmWoVI?=
 =?us-ascii?Q?EcVo1l1sFJydO1xVJVF1PReFzIQsCgpDJfQPBbEHSxMVDaLsFk8Mvvt129xx?=
 =?us-ascii?Q?1nSY9Dw5dy58B2pTVARi12+GoIrpzIdHepkWmn/3bIktvPOxJIaIZ//1iF+h?=
 =?us-ascii?Q?BpOn/lVZB7yPOmyzfV/d9x3P/NH8Rv7/ziF9Qv+lQ8F0s4RNwJW5KpB0BCDF?=
 =?us-ascii?Q?RXV6UwDkV+mDiOYynz1VtIEVbUoTK03haxLkgBUvM2gkKws2LCtEFEZ8WENb?=
 =?us-ascii?Q?2RTeTqE3z6w3N4Jvv3/RbEsLiMtTMZeitVRgW8PXAdYhdZ/pil6sFZmqtv8T?=
 =?us-ascii?Q?Qx/F5kxBxoMWCG7B7J6MgDR9wL8dvzMKUnMlyBbrchbtrOuC6VgmA9NxFWcM?=
 =?us-ascii?Q?g4cmi76EfQFr6RlVsXhj1k13YfWEScsrDnsLrr6QN77nJ0Ny+mnlPAamRXSw?=
 =?us-ascii?Q?Kh/A8gcijFWHjT94ILkQFBRuA5ort9G4KQmrivi08Y1RpUDuX8KHlQWPLSMG?=
 =?us-ascii?Q?Uk8QocFNpSor3w0fNJJboS7VwGD8ndQq+XWYph+hVFMTRk09OSRJzAQLIWdw?=
 =?us-ascii?Q?jWow1J9qtFvznMbLomPxl85SsCAj8Ss9oQhoQwrJMYcg0XDcphDcJZjmaaoS?=
 =?us-ascii?Q?KFbBm4Vs6VeccXJUT8O3yE9wA5FxZ9gQ3BVcZP7hyXdHTbZ9wrMdPfwngO5y?=
 =?us-ascii?Q?1HCz2ZbA3hiYyg07E7WprzSH4B7tsKP0Y+ThTDLAm/MXLsXRRYEIbfMTqDFW?=
 =?us-ascii?Q?2RBVZN3X/ptYb1MgT690+DGx3h5zNTeLsJVnEiZV9FXA4qhp5cAIgPXPpipI?=
 =?us-ascii?Q?2C2Z4Ow6jJSQ64t54BhSiRLfby77I6cw1iDNQDqOyaqFXoMe7qyVS5Z8vDrR?=
 =?us-ascii?Q?VuPKPRuMqSOWHq7MhnA4PkLg7KTdW/3zutPeoBg6+BRFBJythHh84P032cyT?=
 =?us-ascii?Q?/TstqsO4VbUpguV+X4hnnIzB8JnGAu17f1GX0zNL8f2APUO3RrY?=
x-microsoft-antispam-prvs: <TY2P153MB0223DC82BD778C3766635D92927F0@TY2P153MB0223.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(13464003)(199004)(66066001)(55016002)(76176011)(9686003)(25786009)(6436002)(7696005)(316002)(72206003)(22452003)(54906003)(86362001)(68736007)(305945005)(71200400001)(5660300002)(2906002)(71190400001)(86612001)(4326008)(6246003)(110136005)(10290500003)(8990500004)(478600001)(99286004)(10090500001)(14454004)(7736002)(81166006)(7416002)(229853002)(1511001)(106356001)(81156014)(26005)(6116002)(186003)(6346003)(8936002)(3846002)(102836004)(33656002)(53546011)(11346002)(476003)(8676002)(105586002)(97736004)(74316002)(53936002)(446003)(2501003)(486006)(256004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2P153MB0223;H:TY2P153MB0222.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qtuUqYQUC8DP60bNMdx6suoF2TIj4ZNLCfApO/QKksSOy1GuTG1OsQbqHWBuMIs+cS4LAuYvhajIKEljKxaGSikrCrs09ViG6VkJCMctRr9627zrRFfKkvimjXXviCWIjszRfEoE4hJj1t02LZowlM3BFlvTYt+SXs/ic7nAVXj4/iRa7MEPjaqSoJK2SA5gnRhQylPM61+t6sQUMORsgiTWGuueXhvencX50DMGqh9BiQbtb0VEQul9qXTuptG6OleiUkMO1dY/QADtnoS4RmUY4iJH4hqwl4XF91ODiCBR0PMQNx1RZr1GFmNwq5cOeWLs88rO1wKnm2iHlQS7mEj1SEFMrB04BGVE5Syc73IDosWesp2pHEhv1BNVq85kjxnC+iRpgK5FzmwOMMHKiz9pmaiVL3HpdKfOn7jcI6k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe61798-e9dc-4825-849f-08d698bf4f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 12:14:34.7256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2P153MB0223
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Michael:
               Thanks for your review.

-----Original Message-----
From: Michael Kelley <mikelley@microsoft.com>=20
Sent: Friday, February 22, 2019 1:28 AM
To: lantianyu1986@gmail.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; joro@8bytes.org; mchehab+samsung=
@kernel.org; davem@davemloft.net; gregkh@linuxfoundation.org; nicolas.ferre=
@microchip.com; arnd@arndb.de; linux-kernel@vger.kernel.org; iommu@lists.li=
nux-foundation.org; KY Srinivasan <kys@microsoft.com>; vkuznets <vkuznets@r=
edhat.com>; alex.williamson@redhat.com; sashal@kernel.org; dan.carpenter@or=
acle.com; linux-hyperv@vger.kernel.org
Subject: RE: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, Febru=
ary 11, 2019 6:20 AM
> +	/*
> +	 * Hyper-V doesn't provide irq remapping function for
> +	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> +	 * Cpu's APIC ID is read from ACPI MADT table and APIC IDs
> +	 * in the MADT table on Hyper-v are sorted monotonic increasingly.
> +	 * APIC ID reflects cpu topology. There maybe some APIC ID
> +	 * gaps when cpu number in a socket is not power of two. Prepare
> +	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
> +	 * into ioapic_max_cpumask if its APIC ID is less than 256.
> +	 */
> +	for (i =3D min_t(unsigned int, num_possible_cpus(), 255); i >=3D 0; i--=
)

The above isn't quite right.  For example, if num_possible_cpus() is 8, the=
n the loop will be executed 9 times, for values 8 down through 0.
It should be executed for values 7 down through 0.

Yes, fix this in the V5. Thanks.

> +		if (cpu_physical_id(i) < 256)
> +			cpumask_set_cpu(i, &ioapic_max_cpumask);
> +
> +	return 0;
> +}

Michael
