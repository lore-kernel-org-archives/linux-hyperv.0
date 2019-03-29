Return-Path: <SRS0=+9KR=SA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A8C43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 29 Mar 2019 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDB32070B
	for <linux-hyperv@archiver.kernel.org>; Fri, 29 Mar 2019 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aIyUIqj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfC2QBo (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:01:44 -0400
Received: from mail-eopbgr770132.outbound.protection.outlook.com ([40.107.77.132]:50863
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbfC2QBn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Mar 2019 12:01:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ECIDmgR3bjlMJ09b8H5ln4C/78WWmDR7Q6lmstnf0y3DWuu0K//2eIEMT2CbTo4wzz2q1L3xiqS3Rdou+KodjaHp61oLA/BVsV9uKKsWH1WcTtwrNOi0jz4kwYkaTPuYE5yUrAoqP7IpzHvrMmWgqHwl5MAlzGvRaO9SYdrCk4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5e1pifl3TplLKcZa20iG0t6NI7GIl6krltsNBkW5RM=;
 b=XQ7W4j5tqsw2fRN9gpQOGZxZ/QiRWzieSTly2nDOOva8zDQg7RtOARxLBGavSAma7XbOIK+jbb+yXUwARTZoP+XgihHGf9qkcTNd4ZHrG7IAEGNo/Y8Gj606E7ft/R3dkrPar++BHbaiqXj+Q8ky58xwljSSBV3qHoUl70f99js=
ARC-Authentication-Results: =?us-ascii?Q?i=3D1;_test.office365.com_1;=0D=0A=09=09dmarc=3Dnone_action?=
 =?us-ascii?Q?=3Dnone_header.from=3Dmicrosoft.com;=0D=0A=09=09arc=3Dnone?=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5e1pifl3TplLKcZa20iG0t6NI7GIl6krltsNBkW5RM=;
 b=aIyUIqj6wifOyn5llcx/Xuvu1QqhZz1/hFcAEcZPfcUexjQf198eQLBOvjbEdcesfcBIHGvDZA4xnWqHIrtCMMaJq6hepA0Rv3xMpmGdRj0ojx7JDbmTRHgXuqSTnYwGc6lmZzAUYL/i9Of/kNWbpbDa6YUGNEXfQAlW3CafP54=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0872.namprd21.prod.outlook.com (10.167.111.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.8; Fri, 29 Mar 2019 16:01:41 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::41f8:5e99:8d3:1370]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::41f8:5e99:8d3:1370%5]) with mapi id 15.20.1771.007; Fri, 29 Mar 2019
 16:01:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] Drivers: hv: vmbus: Set ring_info field to 0 and
 remove memset
Thread-Topic: [PATCH v3 2/3] Drivers: hv: vmbus: Set ring_info field to 0 and
 remove memset
Thread-Index: AQHU2qE7Abdico24WESRHskWgspSF6Yi2++Q
Date:   Fri, 29 Mar 2019 16:01:40 +0000
Message-ID: <DM5PR2101MB09187D0E1373E3E9830903A0D75A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
 <b9b604327b885d82ddad2991f55d1b54be6eb1c8.1552592620.git.kimbrownkd@gmail.com>
In-Reply-To: <b9b604327b885d82ddad2991f55d1b54be6eb1c8.1552592620.git.kimbrownkd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-29T16:01:39.2622860Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0bf8cfbd-bc3a-400b-b13e-146a5b42d4d7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fad0ed48-1e73-4ead-0f44-08d6b45fd53f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600138)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB08725DAE4CD6E37A479429C7D75A0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(199004)(189003)(305945005)(6246003)(8936002)(478600001)(10290500003)(66066001)(7696005)(97736004)(486006)(71190400001)(71200400001)(22452003)(316002)(25786009)(105586002)(86362001)(1511001)(8676002)(86612001)(54906003)(110136005)(81166006)(229853002)(6636002)(2906002)(106356001)(33656002)(476003)(9686003)(6436002)(68736007)(3846002)(55016002)(558084003)(26005)(81156014)(14454004)(99286004)(4326008)(74316002)(256004)(76176011)(446003)(6116002)(8990500004)(11346002)(10090500001)(7736002)(5660300002)(53936002)(186003)(52536014)(6506007)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Lgaa5WRHK/5OPMJfQf67iIJ2dWipelPlvu7ccItddK508QzrvT6eSmFXYnWsl8qJ8yilREhlkUFy5sR0lTnlgWRYA9MVwSfjspvQEy0H3oCRub0BVs5iLYwh+o2ik1hqIiFN+2EQ9xV7vRPTr89tQTGjXNz8CZfx4u1ToHYftENzStQSh6/xNi3/GVTxDEZ/HO+mt5aMUEzfcmuLtGqQ83U3MRX8YxqdVq+VF4L+jzW0FFUfEaCDCxG/GtWH9c6vYSohM7Rt/j7YHkwu3nsWZiDzNhS5TVD/rcTo6BzZvLi6dOckNwKsLUp9XAuSl3BlEpGjBbslKzWp9z/wRL3P1OjPgDxkuxswaZR42wh4jqBkO5LxMcQ7KBMyyCpIUsULezWoVoXXQ13uHeB0i3ru6bBRAWxan7Y3knUL7rIMVU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad0ed48-1e73-4ead-0f44-08d6b45fd53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 16:01:41.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com> Sent: Thursday, March 14, 2019 =
1:05 PM
>=20
> Set "ring_info->priv_read_index" to 0. Now, all of ring_info's fields
> are explicitly set in this function. The memset() call is no longer
> necessary, so remove it.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
