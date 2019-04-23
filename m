Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D11EC282E1
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCC2217D9
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MqJn7QdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfDWQiK (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:10 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com ([40.107.69.122]:7761
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728728AbfDWQiJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Apr 2019 12:38:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Wvic7e8yYgB7yadfeMYNGaMJ/uChh/7WBZa04BVNBt9xalblXBWJOX7v9LOiusczis6f7vtpEWlYLouaBylVbaj2zdfeAFp62aXJxGknqZpb1XuBAc1DdxMk115P1eGPsrs//UvECb9MUMkgJ3kreybb47DMoGMqSXDoRNW6uHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCdHEaCXEDA2BRH5zNlaLADG0296Lh9oCXjEJXh8DrQ=;
 b=DBshGHtUlqLqfueno6SK5Fi3yIBcts1nmDUyjLEP5/YurVuuYJUklNSUl/dst25FytWgQU23UA03dWcoSSKV+zIRJTLiLz3vfHUlOvLXv16MVixlr1RA7DUHT2pH8PhuFagbMn0atmMCvYqrbPIaeYnNr/Lp/8H8cM/5IdLycXs=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCdHEaCXEDA2BRH5zNlaLADG0296Lh9oCXjEJXh8DrQ=;
 b=MqJn7QdSCN7F990H1tKngVG0mm9TH6oIedawl+mvJP4dUSvHqSjda1lp7rtS5Y+QlPpBfIiGfLyRw5uBIYAIiR+j1CuHFH59g2fKX3lE5p3GcbROvQ0s2LDVz0ezKHBptxIbchS4sjFKRAd7DP73QjmTwYANbSdU8PikIsoTvhw=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1031.namprd21.prod.outlook.com (52.132.128.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.4; Tue, 23 Apr 2019 16:38:06 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::2ca9:7d06:f5b1:7a6f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::2ca9:7d06:f5b1:7a6f%5]) with mapi id 15.20.1856.004; Tue, 23 Apr 2019
 16:38:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][v2] drivers: hid: Add a module description line to the
 hid_hyperv driver
Thread-Topic: [PATCH][v2] drivers: hid: Add a module description line to the
 hid_hyperv driver
Thread-Index: AQHU+fLt7DAJsU1n9kWwUlZfOZ1uYQ==
Date:   Tue, 23 Apr 2019 16:38:05 +0000
Message-ID: <DM5PR2101MB09183A22984131883E033DA7D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
In-Reply-To: <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-23T16:38:04.5423360Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9514dc48-02c0-4ae0-b9f1-b6ac2568b8a7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:fc77:f44:39ef:1b45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a3c1659-ffe2-42c3-47e6-08d6c80a0fe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
x-microsoft-antispam-prvs: <DM5PR2101MB10311A9D3B21BC974524F605D7230@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(66946007)(476003)(99286004)(9686003)(305945005)(229853002)(46003)(10090500001)(68736007)(64756008)(66476007)(7736002)(486006)(66556008)(66446008)(2906002)(73956011)(2501003)(558084003)(14454004)(53936002)(256004)(55016002)(102836004)(76116006)(186003)(76176011)(7696005)(97736004)(6436002)(86612001)(4326008)(6116002)(71200400001)(71190400001)(81156014)(8676002)(81166006)(52536014)(110136005)(86362001)(8936002)(8990500004)(316002)(478600001)(54906003)(6506007)(22452003)(11346002)(446003)(6246003)(33656002)(10290500003)(2201001)(25786009)(1511001)(74316002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZZsu79NmJrmQW7Bvx4sbkUc2WTtvOe6nsjDwDGK/9vr2TtBMqtKHtsYv/bx0OlvewI/qt1xVO6uW6thBfdTptaMb91iGtNpoYTElfl8KGOw24wG1VpU81fh2SAL8c5yndo2CY7q5DGK4mqWLhy2CS7sj2VfyASkPMRnPn34rArwU+mHdlrXj8Wq1+yCJ8MIkH135cGlvZ6QrwiUyMD1Kkx4hbzp2qZL86cbQtt0br74WsNx/qMg+xbSM1q2/5rd4OGbshbvECUdJqe6nyHzbAjsNEoENubGUJ3v/OkVyz9YvvOSN22Fq9pfkXA9UVJnCdvYxFpLgGFxnuD2meOtNXVnKKSTzXpIEowlObOwScdUuS5g7lzuAVq+QmcUzKUJnlcN8kDV9CAgYjrTKvlcQyL0Dwwsqd3rb6+yL1gWV/c0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3c1659-ffe2-42c3-47e6-08d6c80a0fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 16:38:06.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSm9zZXBoIFNhbGlzYnVyeSA8am9zZXBoLnNhbGlzYnVyeUBtaWNyb3NvZnQuY29tPiBT
ZW50OiBNb25kYXksIEFwcmlsIDIyLCAyMDE5IDg6NDcgUE0NCj4gDQo+IFRoaXMgcGF0Y2ggb25s
eSBhZGRzIGEgTU9EVUxFX0RFU0NSSVBUSU9OIHN0YXRlbWVudCB0byB0aGUgZHJpdmVyLg0KPiBU
aGlzIGNoYW5nZSBpcyBvbmx5IGNvc21ldGljLCBzbyB0aGVyZSBzaG91bGQgYmUgbm8gcnVudGlt
ZSBpbXBhY3QuDQo+IA0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9zZXBoIFNhbGlzYnVyeSA8am9z
ZXBoLnNhbGlzYnVyeUBtaWNyb3NvZnQuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IE1pY2hh
ZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0K
