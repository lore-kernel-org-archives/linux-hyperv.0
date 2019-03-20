Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2125C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8424B2184E
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YP8H2/SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfCTOkc (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:40:32 -0400
Received: from mail-eopbgr770098.outbound.protection.outlook.com ([40.107.77.98]:29443
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfCTOkb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 10:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+nai1KSas3j9kQtUrBcrMVl0Q6GQg1eulqp1WNTZrQ=;
 b=YP8H2/SP4R7vEoFS4zQCStZycVFOp+5BZdJQKrhOb/YwoxgeiHelXm1LwQBl9I0zmYnTr0KvahaANhlNO03d3kn39ccYi4wVucffdoGSAOBWUm/4KY8nhoQbtZVX6l3ceznkUn8OKT5wKiyWQCXg3wnfFZrEJegqnkwblcBPoac=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.7; Wed, 20 Mar 2019 14:40:28 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9595:af36:ad4:ab7d]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9595:af36:ad4:ab7d%9]) with mapi id 15.20.1750.002; Wed, 20 Mar 2019
 14:40:28 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Kangjie Lu <kjlu@umn.edu>, "pakki001@umn.edu" <pakki001@umn.edu>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyperv: a potential NULL pointer dereference
Thread-Topic: [PATCH] hyperv: a potential NULL pointer dereference
Thread-Index: AQHU2ilZRp8CWZZ0pke1kYNV+eQu/KYLMX6wgAknVgCAAEhA4A==
Date:   Wed, 20 Mar 2019 14:40:28 +0000
Message-ID: <CY4PR21MB077378A6C09FEDE31990D86DA0410@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20190314054651.1315-1-kjlu@umn.edu>
 <CY4PR21MB0773FB535B3F4177CA9662C0A04B0@CY4PR21MB0773.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1903201119240.1906@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903201119240.1906@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:9:8d7e:908d:9a9b:f0dc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4086ac7-839b-4fbd-b848-08d6ad41ff44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134E5171AC5704526D9034FA0410@CY4PR21MB0134.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39860400002)(199004)(189003)(13464003)(22452003)(446003)(71190400001)(55016002)(86362001)(4326008)(86612001)(71200400001)(25786009)(76176011)(229853002)(99286004)(9686003)(256004)(7416002)(68736007)(10290500003)(6916009)(5660300002)(53936002)(11346002)(7696005)(6246003)(46003)(52536014)(8936002)(6116002)(316002)(476003)(486006)(97736004)(6436002)(7736002)(74316002)(186003)(305945005)(8990500004)(8676002)(33656002)(106356001)(54906003)(81156014)(53546011)(81166006)(2906002)(6506007)(478600001)(105586002)(6346003)(10090500001)(102836004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rs/PG8kipgae9d8cIloWQsf7UESpXH31GD7EsIYflY7gxYa6L8NfjXKlip3f8PNitZQBJYV77+qhqSEsJAmJy7+b54o31DTgPaFtkuvKWAeBCcvIef9Xjj7BSJ0vM+gvqaVCyxJlwVTOuVw1UP/l/cIJQKq3syfxmL8dEVFjgbl5MJRSdwj7iB/ea3RLEgz5IKamC3H+GN7hHVvMR3KVERbtTZ1q4ImRrh9IdBmr3aDfObB7h2+PxzOJnwWuwwOzGzqH8LoK5CpYwSHWRlx0kpdluAc6IfYNF3CCKRD3R5Trr7EBPeFPAtyTWV842RM6tsqOYXhCzja5ndaJrHtAz4nppUDDG4g6Vg4GFo2qFz6Ui/OmmXATZJyfHw5Oky/T3E0/a0dCHE2QDm7KyKi5SJv0Gu3UfItBaFsaoMFVMaQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4086ac7-839b-4fbd-b848-08d6ad41ff44
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 14:40:28.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, March 20, 2019 3:21 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: Kangjie Lu <kjlu@umn.edu>; pakki001@umn.edu; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Ingo Molnar
> <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H. Peter Anvin
> <hpa@zytor.com>; x86@kernel.org; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH] hyperv: a potential NULL pointer dereference
>=20
> On Thu, 14 Mar 2019, KY Srinivasan wrote:
> > > -----Original Message-----
> > > From: Kangjie Lu <kjlu@umn.edu>
> > > Sent: Wednesday, March 13, 2019 10:47 PM
> > > To: kjlu@umn.edu
> > > Cc: pakki001@umn.edu; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang
> > > <haiyangz@microsoft.com>; Stephen Hemminger
> > > <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Thomas
> > > Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Borislav
> > > Petkov <bp@alien8.de>; H. Peter Anvin <hpa@zytor.com>;
> x86@kernel.org;
> > > linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [PATCH] hyperv: a potential NULL pointer dereference
> > >
> > > In case alloc_page, the fix returns -ENOMEM to avoid the potential
> > > NULL pointer dereference.
> > >
> > Thanks.
> >
> > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
>=20
> Did you mean: Reviewed-by or Acked-by?
Sorry, I meant Acked-by.

K. Y
>=20
> You cannot sign off on a patch from
> someone else which you are not picking up and transporting it further.
>=20
> Thanks,
>=20
> 	tglx
