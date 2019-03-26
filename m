Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95012C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6BD2075E
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 14:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OPL5XmK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfCZOmH (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:42:07 -0400
Received: from mail-eopbgr760138.outbound.protection.outlook.com ([40.107.76.138]:8785
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZOmH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 10:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzlniicGOYuRnY9IiVfTUX6jOoorTlO8q8XghXfZ4po=;
 b=OPL5XmK6+apoGwY7Z9qQXmhQyt46Tud8f/FIcUyB8HYpwa9TT2G7oL0L1FTUNcZhqDJyDaNgRTkV/RFo+FtGg4g+zvvjSkWMPDHSzahwMwk+5gqzznuqAD6AEZ67kgH/FwxhO5Ta/fzWRwhluN4Yo5MXaNbkw/GtrFDNR2j5Aoc=
Received: from DM5PR2101MB0725.namprd21.prod.outlook.com (10.167.107.167) by
 DM5PR2101MB1014.namprd21.prod.outlook.com (52.132.133.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.4; Tue, 26 Mar 2019 14:42:03 +0000
Received: from DM5PR2101MB0725.namprd21.prod.outlook.com
 ([fe80::a884:b1f0:d91:f29a]) by DM5PR2101MB0725.namprd21.prod.outlook.com
 ([fe80::a884:b1f0:d91:f29a%8]) with mapi id 15.20.1750.002; Tue, 26 Mar 2019
 14:42:03 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "mgamal@redhat.com" <mgamal@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kimbrownkd <kimbrownkd@gmail.com>
CC:     Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
Thread-Topic: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
Thread-Index: AQHU1QPubzvk7J5JVUa0qOsXMxOVkqYAba2AgAAQdYCAB8q1AIABGy2AgAC1AgCAAQPEAIAASlYAgBF53kCAAS8MAIAACfSw
Date:   Tue, 26 Mar 2019 14:42:03 +0000
Message-ID: <DM5PR2101MB0725E2DDE9608628B4778779CA5F0@DM5PR2101MB0725.namprd21.prod.outlook.com>
References: <20190307163606.25212-1-mgamal@redhat.com>
         <DM5PR2101MB09182EAC78F8EEA57E27C26AD74C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
         <1551983533.5436.8.camel@redhat.com>
         <DM5PR2101MB0725B71EE9A41E1ABE2B266ACA490@DM5PR2101MB0725.namprd21.prod.outlook.com>
         <1552472705.4717.7.camel@redhat.com>
         <SN6PR2101MB0912DF97AC683F8DAD5B59FDCC4A0@SN6PR2101MB0912.namprd21.prod.outlook.com>
        ,<1552567360.4717.11.camel@redhat.com>
         <SN6PR2101MB0912C247FA2B38E10F1824B0CC4B0@SN6PR2101MB0912.namprd21.prod.outlook.com>
         <DM5PR2101MB0725E0BD19C4D4EBA1F2B9FCCA5E0@DM5PR2101MB0725.namprd21.prod.outlook.com>
 <1553609158.5021.15.camel@redhat.com>
In-Reply-To: <1553609158.5021.15.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-26T14:42:01.6409856Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2d02ac49-72e1-455c-84ba-3b906cc5eb17;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e67f5ca-f29f-4893-f7f9-08d6b1f9365c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB101485AF0BE180C14304C6EBCA5F0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(13464003)(446003)(9686003)(4326008)(54906003)(14454004)(8990500004)(305945005)(71200400001)(55016002)(256004)(7736002)(68736007)(66066001)(1511001)(8936002)(53936002)(74316002)(5024004)(2906002)(106356001)(11346002)(81156014)(105586002)(71190400001)(316002)(81166006)(6116002)(25786009)(22452003)(86362001)(486006)(8676002)(99286004)(3846002)(52536014)(476003)(76176011)(6246003)(10090500001)(2501003)(6506007)(53546011)(97736004)(10290500003)(93886005)(86612001)(26005)(7696005)(229853002)(186003)(478600001)(5660300002)(110136005)(6436002)(102836004)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB0725.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QxznIaeYHXFkeHZUP2DFBuMAMDmJBLvhFl+pzJQKAON189IP+jUINUb+LjE8CghqkbMdCErxzKvmpq+gGMybq+6vMe1cRvPW4y7lXOUnhECjpOxYkh4mf1amVb7pXS8jSi+BjEo8F4tdF2QB/mYdZa8pFkQ8nuLk0+KgW2FpoJGkVS+ThXomiGV6TDF/Q6x6yrpS6RWEWWy08JitxTZvivwPrzbs7xsOEPZKWA+/wQ1AwykXLHFCXggZ6zD3y7xq9xs1b6n+dQZNnSQkHUS0U8pnBGV4VuE0tXTro3EmNEbYIM6JOXssMaHuFn52BPwF74pwN+NgTxhoyMIFDE+H2Do0dyTsd6YC45/9lo5mxB+3fU9wTiX41mR/WTW7rVYLjCfJnOlK9z8/rJso+A76Ud2U7UFb76eEjO6WBL3XFOo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e67f5ca-f29f-4893-f7f9-08d6b1f9365c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 14:42:03.4150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtaHlwZXJ2LW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtaHlwZXJ2LQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBNb2hhbW1lZCBHYW1hbA0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAy
NiwgMjAxOSAxMDowNiBBTQ0KPiBUbzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0
LmNvbT47IFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsgTWlj
aGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+Ow0KPiBsaW51eC1oeXBlcnZAdmdl
ci5rZXJuZWwub3JnOyBraW1icm93bmtkIDxraW1icm93bmtkQGdtYWlsLmNvbT4NCj4gQ2M6IFNh
c2hhIExldmluIDxBbGV4YW5kZXIuTGV2aW5AbWljcm9zb2Z0LmNvbT47IERleHVhbiBDdWkNCj4g
PGRlY3VpQG1pY3Jvc29mdC5jb20+OyBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47IEtZ
IFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPjsgdmt1em5ldHMgPHZrdXpuZXRzQHJl
ZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh5cGVyLXY6IENoZWNrIGZvciByaW5n
IGJ1ZmZlciBpbg0KPiBodl9nZXRfYnl0ZXNfdG9fcmVhZC93cml0ZQ0KPiANCj4gT24gTW9uLCAy
MDE5LTAzLTI1IGF0IDIwOjEzICswMDAwLCBIYWl5YW5nIFpoYW5nIHdyb3RlOg0KPiA+IEhpIE1v
aGFtbWVkLA0KPiA+DQo+ID4gSSBmb3VuZCBieSByZWFkaW5nIHRoZSBjb2RlIGFuZCB0ZXN0aW5n
IOKAkyBpbiBuZXR2c2NfZGV0YWNoKCksIGFmdGVyDQo+ID4gbmV0aWZfdHhfZGlzYWJsZSgpLCB0
aGUgcXVldWVzIG1heSBiZSB3YWtlbiB1cCBhZ2FpbiB3aGVuIHJpbmcgYnVmZmVyDQo+ID4gdXNh
Z2UgZHJvcHMgYmVsb3cgdGhlIOKAnGxvdyB3YXJ0ZXJtYXJr4oCdLiBUaGlzIGlzIGV4cGVjdGVk
IGluIG5vcm1hbA0KPiA+IGNvbmRpdGlvbnMgYXMgcGFydCBvZiBvdXIgZmxvdyBjb250cm9sIG1l
Y2hhbmlzbS4NCj4gPg0KPiA+IEJ1dCB3aGVuIHdlIHN0b3BwZWQgYWxsIHR4IHF1ZXVlcyBpbiBu
ZXR2c2NfZGV0YWNoKCksIGFuZCBzdGFydA0KPiA+IHJlbW92aW5nIHRoZSBuZXR2c2MgZGV2aWNl
LCB0aGlzIG1heSBjYXVzZSBzZW5kIHBhdGggcGFuaWMgb24gTlVMTA0KPiA+IHBvaW50ZXIgb24g
YSBjbG9zZWQgY2hhbm5lbC4NCj4gPg0KPiA+IEkgaGF2ZSBhdHRhY2hlZCBhIHBhdGNoIGZvciB0
aGlzIGlzc3VlLCBjb3VsZCB5b3UgdGVzdCBpdCBvbiB5b3VyDQo+ID4gc2lkZT8NCj4gPg0KPiA+
IFRoYW5rcywNCj4gPiBIYWl5YW5nDQo+IA0KPiBIaSBIYWl5YW5nLA0KPiANCj4gSSd2ZSB0ZXN0
ZWQgdGhlIHBhdGNoIGFuZCBpdCBzZWVtcyB0byBmaXggdGhlIHByb2JsZW0uDQo+IA0KPiBUaGFu
a3MsDQo+IE1vaGFtbWVkDQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoZSB0ZXN0aW5nIQ0KIC0gSGFp
eWFuZw0K
