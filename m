Return-Path: <SRS0=mRNI=RP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C49C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFB42077B
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oIEtiz5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCLVxc (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:53:32 -0400
Received: from mail-eopbgr780115.outbound.protection.outlook.com ([40.107.78.115]:32079
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbfCLVxc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Mar 2019 17:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk2C/dk4RMNOLDmTobKrb5nSxsJ0Pqs91MLX1EqlT34=;
 b=oIEtiz5eZe/ghJSd6yRgTyAdWIehjZKPc6xShv8ajtwiaNew51vKJyfLwNPzlKhzbHL659AKw25pdh4MsTM0rlOZzMjKrtNlh2MBCeVz3mWMZJOamGf+xMgkgUEJ5kLLV1Kt2iZZPeob/Gr4ick2RUQugqB9N37dLCCDKziS8EA=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0808.namprd21.prod.outlook.com (10.167.110.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Tue, 12 Mar 2019 21:53:29 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1730.000; Tue, 12 Mar 2019
 21:53:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Thread-Topic: [PATCH 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Thread-Index: AQHU2RxyOTq1l4uiQEScYNos9n0ruqYIh/sAgAAAheA=
Date:   Tue, 12 Mar 2019 21:53:28 +0000
Message-ID: <DM5PR2101MB091877CF62AD20D07D82F452D7490@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
 <20190312214652.GA15914@kroah.com>
In-Reply-To: <20190312214652.GA15914@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-12T21:53:25.8626166Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c9b6464c-fef1-4f07-b6eb-66cb15698b2d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c863c566-d9e5-4e96-09c5-08d6a7352975
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB08081E683D3997F32A40720DD7490@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(229853002)(97736004)(7696005)(6116002)(10290500003)(81166006)(8936002)(54906003)(8676002)(2351001)(105586002)(53936002)(81156014)(1730700003)(106356001)(86612001)(6916009)(86362001)(6436002)(99286004)(5640700003)(2501003)(5660300002)(52536013)(76176011)(6506007)(478600001)(7736002)(316002)(74316002)(305945005)(9686003)(55016002)(22452003)(4744005)(33656002)(14454004)(10090500001)(256004)(71190400001)(6246003)(71200400001)(476003)(11346002)(486006)(6346003)(102836004)(66066001)(25786009)(4326008)(446003)(26005)(8990500004)(68736007)(186003)(7416002)(2906002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kIUFaGHhp3eHzgL+O19V2WnO04Oq5LEok7f0WRPvtbJVJxkuarjgsMsJe52cdUx4fFR+YjWkfNUEUOnrJW3rIddQ+QFcqLdGnffhldJfyipj7udGYLZ5D/HFH3o0SMYV3JJnx7CKNZUH0TOd4CAkJu0lEKeuGH0qreo2RJrIamMEiN76bFSyiXg0L6NaTagXVd9L43KcJOz+09VathQIwIlzEXTmvqU5L6slacvQmJbMcabPtjy7fBOHCyKEURT/ekp1HQuYikA4hlmzh/HOGEWVwV1r0n5tDOrI3Aqo3+LaRGslmkTRFqE0teOZgyb7CyGBM4OtaBvYWUiKVn1UmhPBVDUxAjjjZHPeJhs+RmZPzK9D6GY/k1au2Q45D53enxkh+LaB1JHZN39hszJnng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c863c566-d9e5-4e96-09c5-08d6a7352975
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 21:53:28.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>  Sent: Tuesda=
y, March 12, 2019 2:47 PM
> >
> > Michael Kelley (2):
> >   Drivers: hv: Move Hyper-V clockevents code to new clocksource driver
> >   Drivers: hv: Move Hyper-V clocksource code to new clocksource driver
>=20
> You have two different patches that do different things, yet have the
> same identical shortlog text :(
>=20
> That's not ok, and something that I reject for trivial patches, it
> should never happen for a "real" patch as you don't do the same thing in
> both of these patches.

Hmmm.  Not identical.  The first patch is "clockevents" code, and the secon=
d
patch is "clocksource" code.

Michael
