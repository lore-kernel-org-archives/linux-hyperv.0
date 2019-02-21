Return-Path: <SRS0=8B77=Q4=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A9DC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 17:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27B22077B
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 17:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TWl2wtMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBURBg (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:01:36 -0500
Received: from mail-eopbgr780115.outbound.protection.outlook.com ([40.107.78.115]:52859
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBURBg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Feb 2019 12:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLFoTHrYGxGbuNpL+en+YKLWHj1rB5JZJd9/QzEjaEA=;
 b=TWl2wtMuLBnT2HTglIv4DYTF9tF1rf1TJX/HEhZM6APwujfwGkNAlXvuutryDWe3WaQ4/P/GweL9lv+RT84jOb3lpM420R1LK3e441ixbj81ca633ShHMclshoDjDBxOoMZ6YeuJNLSyx7DBbb3aLiycJLfXyrL3dsEdRgFZtqc=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1048.namprd21.prod.outlook.com (52.132.128.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.2; Thu, 21 Feb 2019 17:00:53 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%9]) with mapi id 15.20.1665.006; Thu, 21 Feb 2019
 17:00:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH V4 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Thread-Topic: [PATCH V4 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Thread-Index: AQHUwhUA3ogagdsxGU2FCnaMcKl+TqXqiVcg
Date:   Thu, 21 Feb 2019 17:00:53 +0000
Message-ID: <DM5PR2101MB0918F78D1E8682FF545519F8D77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549894824-26623-2-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1549894824-26623-2-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-21T17:00:50.9090246Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=efb255d0-3962-48a8-a1be-321710d7a1c4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 051dba6d-2e7d-49c9-b911-08d6981e23eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1048;23:72OR0y1gOTqxL57Znw6UrjxWQq2qnw46ysPOzFM?=
 =?us-ascii?Q?f5IFCnnHYv2rqUx0ESO+X5kxeI9QkxkY2j7L3DJ7KGLdEck3eczXxuQKsVhm?=
 =?us-ascii?Q?bjNt2WXtdByN2xrz2tbvdjNzt0YIUurNnFt0EbdXX6wj9SDmoSPJm5oV9TgH?=
 =?us-ascii?Q?6Dzi+tzxt26SDS942N047hl9hp5bd18nyfaN/YkiGyvsM3bus4HjSJlNWDwr?=
 =?us-ascii?Q?sukKzXbVtQ4mRn28O/rfjiWjMXr01GoV3LuJsKcWrUQLGKKqODIgnANfMYcr?=
 =?us-ascii?Q?YNyvw74+XizlmtbzNn/Z/rxdvDEKzh/Ku51rkjkFIAVthyc2LtdizgoB5drP?=
 =?us-ascii?Q?wut1di9I2DKXFcLTSSrT7Fy6OnfuUQuL57fFlZ1z0UiXvUEwg7KfGIQ+2j7l?=
 =?us-ascii?Q?4J3/gYjWqcNt1pfBvYrj1eDI3VdzCOt+ZIj5hCs+sjvMP+BnCOvu7gGHn1Dv?=
 =?us-ascii?Q?cD2FnIMQuudOnfYGdkAx2jHpUn9F0Vn8WuKL9XEIcN7cJBZgyHaC7Td0Wu9w?=
 =?us-ascii?Q?7BFRng/zbzJ7dswWANBXZRkgjosQlauSrDX+PnfAN1boR8pS38mLo2rET4/E?=
 =?us-ascii?Q?Dz3caMdMMt8F0kPC3LFpnUT5Rx9UHAI5rXrcAq8jtmG8Mxxt1gaI2PvgRcQz?=
 =?us-ascii?Q?FE31GBOxhIMQS/9BM38CXoHZAzG5fiN3K8H1XFXifFdOk/4S4W28zvADexme?=
 =?us-ascii?Q?MURdHo26heIFxpAX7tKaKaDSp8WDiwU1huYveHAlSrko7FSfeOB0r4HtihNz?=
 =?us-ascii?Q?SIAyWQT2DFHi8GyQ7YaaIWP1SXmjTrtaL4AN9jPQUDmz72pzEiAcX3/bAd1R?=
 =?us-ascii?Q?Y3KjrJP65O6dBBJJmSswHifXzuhHWNDP4GCMYpQtPUvWbsQ5CofRaapWUNPn?=
 =?us-ascii?Q?+RRDwlRmhkzswO2ToVXACAwo4hSVlxfiHA7ftuIurfOcR1cILwzyvpvGCXam?=
 =?us-ascii?Q?nGlHWcwqqevR4ck3lyag5LIa1+OsgW2OUlF/nx0oVKlZHSn3rJInL7jYGx4d?=
 =?us-ascii?Q?pwkdgftUtxzHbeGLpLcolOG4vc8d2/i4Z1KeIUM+A5Jv5DLDns5B508HflKf?=
 =?us-ascii?Q?btqlWAb/UWvrWiFVv46kwsrWl15SZgoqlZi62HfRhb0+z7wOiA7oRh1aA2gS?=
 =?us-ascii?Q?3gr7T7IYDp7qQkjH2pEa2C2DdqZwGpxKcWCoXDndp9xOkFM3aKkCJ/oOB7hb?=
 =?us-ascii?Q?rrJTqttnAwwmrisEmAF8pibuZEneTdlq+5GvddHWlHfB0pMySbaadxtcSgxB?=
 =?us-ascii?Q?F2wTmhIhyTuU6a82nzSnHlxUrHj34q6DOej4Zso/J7lc0ZK7/MHlNUL6Kaqu?=
 =?us-ascii?Q?e1l9Rl9JUAanFcVfLUkazWj5rCIaAgvKsaqyJsuoSXbS1bGn+sH55tXK79AQ?=
 =?us-ascii?Q?Vkysyc0N56FVLZM193a0Md72nePw/DtgMKXrAHnHOVwHvs1LsBtp0gDPHMco?=
 =?us-ascii?Q?43/7HrTdjL5slb1Zr7x8/vI9nNBluPdJx72o+PVBvfATXmChBesdv?=
x-microsoft-antispam-prvs: <DM5PR2101MB1048CB895EC689D534AB9D10D77E0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(11346002)(7736002)(1411001)(53936002)(33656002)(25786009)(486006)(8936002)(99286004)(71200400001)(54906003)(71190400001)(2501003)(305945005)(5660300002)(81156014)(74316002)(68736007)(2906002)(6916009)(186003)(4326008)(476003)(446003)(4744005)(7416002)(81166006)(2351001)(8676002)(6246003)(3846002)(97736004)(478600001)(102836004)(256004)(229853002)(6116002)(66066001)(26005)(106356001)(6346003)(76176011)(7696005)(10290500003)(14454004)(10090500001)(316002)(22452003)(86612001)(6436002)(9686003)(105586002)(8990500004)(1361003)(55016002)(86362001)(5640700003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kGvDpJ9cVAg8AimnBzBdP/RZfF9CyLrA8cxYf2PH1mPcXpGSYj3z3xS6786Tthlue3s4bLaJdbfUxDclujM7FDdkFMi6MDdYy/qqCX9zcPHqYP2T4BxvUVC6LDl8N+LoEJoX4fwfKmdAIwAGkhr5XtsKkM5+SRq/F3fTiK0Fgj6QBZusbGl6tYlrwRblW4eUy9bFIjrreFq0X7X6H/wfhTTLrwStxLVYdRNT5c3cqhyDxRMdUAbawL03KZNSK25+b1LtR+KPPXjzPaJJmvLt6SiBNekZ2V1J0KnIbET0FSoEANn4J96mMXZyCsfTwduJSr2zG5FtMe/n9qK0uXh6U3w1AG8QtH2Eudf1dBWR1rLha1WGmtagHUwffxHPF4uXF4s9ECZurXUrwFPo4OK0Sy75NQopd6/eMWsXFJN4zSg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051dba6d-2e7d-49c9-b911-08d6981e23eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 17:00:53.7296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, Febru=
ary 11, 2019 6:20 AM
>=20
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
>=20
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v2:
>        - Fix compile error due to x2apic_phys
>        - Fix comment indent
> Change since v1:
>        - Remove redundant extern for x2apic_phys
>=20
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
