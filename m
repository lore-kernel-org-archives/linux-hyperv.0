Return-Path: <SRS0=+9KR=SA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B3C43381
	for <linux-hyperv@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529402183F
	for <linux-hyperv@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G2n/W/hL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfC2QEZ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:04:25 -0400
Received: from mail-eopbgr730131.outbound.protection.outlook.com ([40.107.73.131]:58168
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729046AbfC2QEZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Mar 2019 12:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Ie4iqKTwNloq8vJty9+/j2e/hl38XZQbtCrFu2GvXn7bfLWi2jP85nedbDcMIWUJBCwb9EtV3tqY+CopA+dYd27Ly5wZVYrlODaDHEFR5OZj4P21ydvzMsazfCktRuIJLRpDzRk6ZITwYuw9ACISKVy6YE0X+1BuabXjvActXtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TROdEMm59NiaVgfmBfAFoM8NgjTgktjnuorhPCoaYY=;
 b=ic1EWSOy2IdpyqFlOoMMfjqKU2r3kX9vTwo08ncewikU8f5TdgeIXlLeVhdBsXIcRn+q4VG7etVQwuJciNG23oBs0HCjO92T+8qtLuTHrLzue0Dt/J9jjsNFs/ozmi7/lRpL3wX3SDCRXSQdd+TVZJ6ed1B/zEyRwDtJ7wewIpU=
ARC-Authentication-Results: =?us-ascii?Q?i=3D1;_test.office365.com_1;=0D=0A=09=09dmarc=3Dnone_action?=
 =?us-ascii?Q?=3Dnone_header.from=3Dmicrosoft.com;=0D=0A=09=09arc=3Dnone?=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TROdEMm59NiaVgfmBfAFoM8NgjTgktjnuorhPCoaYY=;
 b=G2n/W/hLbmKt7c/XbaK2It+tZThWjE1iN+i30iAbb0Z/GUAvY84yqEE3dh+AOS1qmlfi+BFq3cOYa+THGlGweHWVMNNH7Z4aQZuU2vwu6xyTYlRaWpn7MpnRohssqwyLOTT4OWYGPsRC2DIFtcqth2rXVshRDhkgesG70w+gTT0=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1061.namprd21.prod.outlook.com (52.132.128.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.6; Fri, 29 Mar 2019 16:04:23 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::41f8:5e99:8d3:1370]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::41f8:5e99:8d3:1370%5]) with mapi id 15.20.1771.007; Fri, 29 Mar 2019
 16:04:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Thread-Topic: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Thread-Index: AQHU2qFBQTqhNU8HdkG1Jcl3Z4D/rqYi3CiQ
Date:   Fri, 29 Mar 2019 16:04:22 +0000
Message-ID: <DM5PR2101MB0918E0523763524373A4562AD75A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
 <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
In-Reply-To: <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-29T16:04:21.1809000Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fb49d8f-3b9e-4229-8d44-dd7f4ae4bdef;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77e217cc-56ff-4e96-6d3b-08d6b46035b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600138)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1061;
x-ms-traffictypediagnostic: DM5PR2101MB1061:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB1061F422B919090C7D659F8BD75A0@DM5PR2101MB1061.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(99286004)(14454004)(7736002)(305945005)(10290500003)(4326008)(5660300002)(25786009)(74316002)(86612001)(476003)(10090500001)(486006)(8936002)(478600001)(316002)(86362001)(105586002)(110136005)(71190400001)(71200400001)(52536014)(106356001)(54906003)(11346002)(6246003)(6306002)(81166006)(55016002)(6506007)(9686003)(97736004)(256004)(7696005)(6636002)(22452003)(6436002)(76176011)(8990500004)(33656002)(446003)(14444005)(1511001)(102836004)(966005)(8676002)(68736007)(6116002)(3846002)(229853002)(81156014)(53936002)(26005)(186003)(66066001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1061;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KezaUDVepzg5E9xOiriW+1E/HIu0hSJTdzLXyrHJ+Kkyd3EAyqg3pLfODXPp2hBCK8bnoMpDp74XlG+u4HDSs5Uqzjj15+IPLH7M+040mmep3xsAU4eLE/gxxGENkKqhQZwO8GdQw01ip3Rw2zCk2rggmnv4suVAC3rdotnOjfqnbDaS7dpPR/IB/S/TtvEUGPdxKA4+gBjsq6uEDeYSpS8WhXiFavsRSQdClL9HSNOs7iTl7Y2gx8wHXS7Boq8ygV18U+U3o0WyZJV4R/6LAl505Ir0VrWdkmSTKTREENdMGLVbBdy8BGfy6syHFWiBsvQrd75GXLI2Wee0BVx1Yoiy4KhwJDMy83Se5FbIz+mZGoY+e/zvR7L382f/YNQoiD19PS5gBtviYb5sZ9T0Y5/X3RrfooiBWN/hgQyBTXw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e217cc-56ff-4e96-6d3b-08d6b46035b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 16:04:22.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com> Sent: Thursday, March 14, 2019 =
1:05 PM
>=20
> Fix a race condition that can result in a ring buffer pointer being set
> to null while a "_show" function is reading the ring buffer's data. This
> problem was discussed here: https://lkml.org/lkml/2018/10/18/779
>=20
> To fix the race condition, add a new mutex lock to the
> "hv_ring_buffer_info" struct. Add a new function,
> "hv_ringbuffer_pre_init()", where a channel's inbound and outbound
> ring_buffer_info mutex locks are initialized.
>=20
> Acquire/release the locks in the "hv_ringbuffer_cleanup()" function,
> which is where the ring buffer pointers are set to null.
>=20
> Acquire/release the locks in the four channel-level "_show" functions
> that access ring buffer data. Remove the "const" qualifier from the
> "vmbus_channel" parameter and the "rbi" variable of the channel-level
> "_show" functions so that the locks can be acquired/released in these
> functions.
>=20
> Acquire/release the locks in hv_ringbuffer_get_debuginfo(). Remove the
> "const" qualifier from the "hv_ring_buffer_info" parameter so that the
> locks can be acquired/released in this function.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
