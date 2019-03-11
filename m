Return-Path: <SRS0=nv2F=RO=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C51FC43381
	for <linux-hyperv@archiver.kernel.org>; Mon, 11 Mar 2019 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8620643
	for <linux-hyperv@archiver.kernel.org>; Mon, 11 Mar 2019 19:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oMIfweH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfCKTt5 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:49:57 -0400
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:52032
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfCKTt5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Mar 2019 15:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7wb889HenTXKtjFY8P2GNRbCN2S5cuqwm+VFfWP+64=;
 b=oMIfweH/l+hwKZEppTCZuw9968zf2KwuJlUtg2srrdh8zkTwNyM/p/8CfaJlBiRjfkWZux7SOq7EB7GkmUuUk98/wjaZUxs+Gpz9GMNipo6ZtNBL25COWaTcyDFKDxfCtygKYnQkFUU0iYpLtMex+MA22XNyY6LSyD9rPe+7JW8=
Received: from DM5PR2101MB0725.namprd21.prod.outlook.com (10.167.107.167) by
 DM5PR2101MB1111.namprd21.prod.outlook.com (52.132.132.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Mon, 11 Mar 2019 19:49:54 +0000
Received: from DM5PR2101MB0725.namprd21.prod.outlook.com
 ([fe80::a884:b1f0:d91:f29a]) by DM5PR2101MB0725.namprd21.prod.outlook.com
 ([fe80::a884:b1f0:d91:f29a%8]) with mapi id 15.20.1730.000; Mon, 11 Mar 2019
 19:49:54 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>, Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: hyperv: fix a NULL pointer dereference
Thread-Topic: [PATCH] net: hyperv: fix a NULL pointer dereference
Thread-Index: AQHU19p5yQFnSUaxQECHIYx36L0CYKYG1fFQgAAAz2A=
Date:   Mon, 11 Mar 2019 19:49:53 +0000
Message-ID: <DM5PR2101MB0725E206EC1B6AA6CE2DB8E6CA480@DM5PR2101MB0725.namprd21.prod.outlook.com>
References: <20190311071714.28631-1-kjlu@umn.edu>
 <DM5PR2101MB0725705F1CDDD3D1631CD509CA480@DM5PR2101MB0725.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB0725705F1CDDD3D1631CD509CA480@DM5PR2101MB0725.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-11T19:46:40.8860394Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=79f2344b-338a-4c8b-a294-bd4cb40f3c8a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aed8ddb-6ecb-4505-8447-08d6a65abb6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
x-microsoft-antispam-prvs: <DM5PR2101MB1111E62CFB9448F8942D6C01CA480@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(13464003)(199004)(14454004)(110136005)(26005)(9686003)(22452003)(66066001)(99286004)(52536013)(68736007)(2171002)(86362001)(93156006)(6246003)(10290500003)(229853002)(446003)(8936002)(54906003)(6116002)(106356001)(478600001)(3846002)(186003)(305945005)(11346002)(256004)(7736002)(53936002)(81156014)(8990500004)(1511001)(476003)(102836004)(74316002)(5660300002)(8676002)(86612001)(2906002)(53546011)(105586002)(4326008)(6506007)(2940100002)(55016002)(316002)(71190400001)(6436002)(71200400001)(81166006)(6346003)(25786009)(7696005)(33656002)(97736004)(76176011)(486006)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB0725.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 37IU8uS6wQ+7r4DYFsy0bMVBgfnFdau47/+qlZGtPg3zgAde0BdlWDSnVx695q/mGCzerzMS4K7ES2GFeu0zKUBzIhSwQvcyQqLLR1QYPcE3+H3Z4NI/bjoVzpERX6ZscobAAc8dbBLOq/0Y3q5RBHnWw44olB03kghQxS8N4DntXTwxCsu2is6AfUkBA2NZw3Fhj8pc6GpbWDk+bHFJTm5bm+d3HI3BYb1Yb58flqZWMlWss86wB/L+atFQrr3QOHQ5pjPwWLfgjT30hLHQtIkzr2T/vaCdC7t1T/YbvNgZY8qUEirq93dNWpTWcmcbwGuUMBeblVYSINq3DTwx8+rcr69AYLToPuaoyMRaPSSMIPhZx7g2mLdhdmAFdi30ctIDP9mmd6JzRdNr9F/ILVddAQr5Dm4u6nVbK7pTFyw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aed8ddb-6ecb-4505-8447-08d6a65abb6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 19:49:53.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: linux-hyperv-owner@vger.kernel.org <linux-hyperv-
> owner@vger.kernel.org> On Behalf Of Haiyang Zhang
> Sent: Monday, March 11, 2019 3:47 PM
> To: Kangjie Lu <kjlu@umn.edu>
> Cc: pakki001@umn.edu; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>;
> David S. Miller <davem@davemloft.net>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] net: hyperv: fix a NULL pointer dereference
>=20
>=20
>=20
> > -----Original Message-----
> > From: Kangjie Lu <kjlu@umn.edu>
> > Sent: Monday, March 11, 2019 3:17 AM
> > To: kjlu@umn.edu
> > Cc: pakki001@umn.edu; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>;
> > Sasha Levin <sashal@kernel.org>; David S. Miller
> > <davem@davemloft.net>; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; linux- kernel@vger.kernel.org
> > Subject: [PATCH] net: hyperv: fix a NULL pointer dereference
> >
> > In case kvmalloc_array fails, we should stop using it to avoid NULL
> > pointer dereference.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
>=20
Also, please change the subject to be more specific:
	hv_netvsc: fix a possible NULL pointer dereference in netvsc_get_ethtool_s=
tats()

Thanks.
