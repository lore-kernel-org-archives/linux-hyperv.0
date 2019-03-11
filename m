Return-Path: <SRS0=nv2F=RO=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593DAC43381
	for <linux-hyperv@archiver.kernel.org>; Mon, 11 Mar 2019 19:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B16620643
	for <linux-hyperv@archiver.kernel.org>; Mon, 11 Mar 2019 19:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jNX79UYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCKTqp (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:46:45 -0400
Received: from mail-eopbgr810123.outbound.protection.outlook.com ([40.107.81.123]:23892
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfCKTqp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Mar 2019 15:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyNDXixeDrZh7qjApVC4NjxcRbjbzfDxgVjmTjlq56I=;
 b=jNX79UYf9ISh870Or+DVI513VmvCoGiolJtAp8xfkbKWzAI9IXOkhIHQVoEl962kzfZwno9nYT+oU+jpdkw0sKaunf9DBozQn8Q41BquGAUmg3ncncifp32pG6MIvoWRuuqYWc696lYmDjeuXe3p/ZI2fzLhwmdD/s3r4G5P+os=
Received: from DM5PR2101MB0725.namprd21.prod.outlook.com (10.167.107.167) by
 DM5PR2101MB1128.namprd21.prod.outlook.com (52.132.133.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Mon, 11 Mar 2019 19:46:42 +0000
Received: from DM5PR2101MB0725.namprd21.prod.outlook.com
 ([fe80::a884:b1f0:d91:f29a]) by DM5PR2101MB0725.namprd21.prod.outlook.com
 ([fe80::a884:b1f0:d91:f29a%8]) with mapi id 15.20.1730.000; Mon, 11 Mar 2019
 19:46:42 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Kangjie Lu <kjlu@umn.edu>
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
Thread-Index: AQHU19p5yQFnSUaxQECHIYx36L0CYKYG1fFQ
Date:   Mon, 11 Mar 2019 19:46:42 +0000
Message-ID: <DM5PR2101MB0725705F1CDDD3D1631CD509CA480@DM5PR2101MB0725.namprd21.prod.outlook.com>
References: <20190311071714.28631-1-kjlu@umn.edu>
In-Reply-To: <20190311071714.28631-1-kjlu@umn.edu>
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
x-ms-office365-filtering-correlation-id: 8a4961a4-8da1-4ac1-9566-08d6a65a4908
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
x-microsoft-antispam-prvs: <DM5PR2101MB1128BE6FA6881FBAC05C99FCCA480@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(136003)(396003)(13464003)(189003)(199004)(446003)(11346002)(486006)(8676002)(81156014)(81166006)(105586002)(8936002)(7736002)(22452003)(54906003)(316002)(86612001)(106356001)(476003)(99286004)(76176011)(7696005)(6916009)(86362001)(6346003)(26005)(4744005)(68736007)(102836004)(5660300002)(186003)(6116002)(229853002)(6246003)(2171002)(3846002)(9686003)(53936002)(6506007)(53546011)(2906002)(8990500004)(6436002)(55016002)(10090500001)(52536013)(305945005)(256004)(25786009)(71190400001)(33656002)(14454004)(71200400001)(74316002)(97736004)(478600001)(4326008)(66066001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB0725.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bNLmwplYgiFTnXaxGQgYq/5/x0ZAJlQ30vnkoibjiDc4dyaJ8lxHJISg4ZcJh/iRzyMV32UZE0A8hTIMtzobp14SUFsnnc8l73LVslnMqTNygMH+COZAGTl7MaT4PT/tkAkCjoYtGnGLp248SS3/n26oDEiSr0en4JSog/Iupzr2iJ7v32azWyNWdDW0vjqRFjdafJa9tjpqGa9fji7OXal1grS+pBPzAuwuLtG+oTqHPbHB8OKLGG3CB2C/9HGOoSNTYjECwzKknGCnJnmOcDPPML/hCwQztjaxMLnes2LyLFV1Ktbjd1s10K+BjIUHVolLfjhX8Vpo8cS57YqJwzdN+ldDpvSunSwgGo7/OJX06qzuS+J/AQuI4SlkRc6MxleFYK33h5bdwOv1WI0+YQboPJK359j3MUMWg8Yvhv0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4961a4-8da1-4ac1-9566-08d6a65a4908
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 19:46:42.0791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Kangjie Lu <kjlu@umn.edu>
> Sent: Monday, March 11, 2019 3:17 AM
> To: kjlu@umn.edu
> Cc: pakki001@umn.edu; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> Sasha Levin <sashal@kernel.org>; David S. Miller <davem@davemloft.net>;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] net: hyperv: fix a NULL pointer dereference
>=20
> In case kvmalloc_array fails, we should stop using it to avoid NULL point=
er
> dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks!
