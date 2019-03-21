Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04559C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C775A2175B
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 16:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CEYq/BiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCUQEX (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:04:23 -0400
Received: from mail-eopbgr720105.outbound.protection.outlook.com ([40.107.72.105]:29792
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726787AbfCUQEX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Mar 2019 12:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVtOvZrLhc/44Lqm+acrKGn6qO2C4bSCpKf+DWrjdHY=;
 b=CEYq/BiMqVHSu6/+4aooSlD/m/T4VGGALoRir48R5uiz16jffZiuhDnVQuQ34LilvgVEJWvXYOinoW9LfhxkUWB7C4vxsz+2nyoFFZAlzvju26AY1+UufZs+HSXoXN79ECneF2qHNKwN9bBkPmletJnlTLGDDyZXS0f+d6rTmXk=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0981.namprd21.prod.outlook.com (52.132.133.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.5; Thu, 21 Mar 2019 16:04:20 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::7c40:f836:e5fc:efd0]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::7c40:f836:e5fc:efd0%6]) with mapi id 15.20.1750.010; Thu, 21 Mar 2019
 16:04:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>
CC:     Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Thread-Topic: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Thread-Index: AQHU2qFBQTqhNU8HdkG1Jcl3Z4D/rqYLugGAgANYDACABelzgIAAgPUAgADLjxA=
Date:   Thu, 21 Mar 2019 16:04:20 +0000
Message-ID: <DM5PR2101MB091851BC7C55093D388514D9D7420@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
 <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
 <20190314154533.17c8a362@shemminger-XPS-13-9360>
 <20190317014927.GA60356@ubu-Virtual-Machine>
 <20190320130619.07e49c97@shemminger-XPS-13-9360>
 <20190321034752.GA6828@ubu-Virtual-Machine>
In-Reply-To: <20190321034752.GA6828@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-21T16:04:16.0559398Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=36ddc760-fa83-457e-8fe0-76462c6b758b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:a:9848:bfa6:ccac:fec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcc7f27b-3001-4469-22a0-08d6ae16e0d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB09812D7887FC676AA96E5CE1D7420@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39860400002)(136003)(376002)(189003)(199004)(53936002)(8676002)(52536014)(11346002)(25786009)(446003)(97736004)(5660300002)(476003)(46003)(486006)(8936002)(22452003)(6436002)(9686003)(229853002)(8990500004)(33656002)(54906003)(81156014)(93886005)(305945005)(55016002)(106356001)(316002)(105586002)(110136005)(10090500001)(99286004)(71190400001)(6506007)(7736002)(14454004)(478600001)(81166006)(71200400001)(68736007)(10290500003)(4326008)(86612001)(256004)(14444005)(76176011)(6246003)(102836004)(186003)(86362001)(6116002)(74316002)(7696005)(6346003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2/sYLAHblvOGoSuGFy04fm0yceM/80tZcpWt1Agz11A8VeFYDIrSYEgCs/Sj1NlbHAr5qwE6JIoH/E+iasgj1ORfu8ZzMG/a9BgfTZRBkj3fii/uJT41CETalKRqGj3p9u8AReqKyAVWiLnYUPzwvjtZwylDKu0PM2xmOND1tuIAQHYm28TKd6wEaVFbQ/8SFo0hsPhKVOG9CNgYCoofowJDlWUZH0rplKSEZcVWzzSOzlxBPHwWw2dUbJkUuQdFIAAGI7CGE69jSMiX83kFfYJpI/sOmZ6EEQDlGHHaQzAB9GzcLjMbSuQdZqPbYT5u8l1Ge/xRBDkRQyTfBC27frsTKbFg27I/dk9ryLkye6j0BStA1IPc41rZHQrb5FiOikcNrVDETyHF7tvgsM5XDE3fIRTcufQvio6ZnzmoI4o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc7f27b-3001-4469-22a0-08d6ae16e0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 16:04:20.2346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Wednesday, March 20, 201=
9 8:48 PM
> > > > Adding more locks will solve the problem but it seems like overkill=
.
> > > > Why not either use a reference count or an RCU style access for the
> > > > ring buffer?
> > >
> > > I agree that a reference count or RCU could also solve this problem.
> > > Using mutex locks seemed like the most straightforward solution, but
> > > I'll certainly switch to a different approach if it's better!
> > >
> > > Are you concerned about the extra memory required for the mutex locks=
,
> > > read performance, or something else?
> >
> > Locks in control path are ok, but my concern is performance of the
> > data path which puts packets in/out of rings. To keep reasonable perfor=
mance,
> > no additional locking should be added in those paths.
> >
> > So if data path is using RCU, can/should the control operations also
> > use it?
>=20
> The data path doesn't use RCU to protect the ring buffers.

My $.02:  The mutex is obtained only in the sysfs path and the "delete
ringbuffers" path, neither of which is performance or concurrency sensitive=
.=20
There's no change to any path that reads or writes data from/to the ring
buffers.  It seems like the mutex is the most straightforward solution to
preventing sysfs from accessing the ring buffer info while the memory is
being freed as part of "delete ringbuffers".

Michael
