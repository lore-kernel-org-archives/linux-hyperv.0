Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02354C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 20:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAE921873
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 20:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FYm6Ljdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfCTUSp (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:18:45 -0400
Received: from mail-eopbgr690101.outbound.protection.outlook.com ([40.107.69.101]:15746
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfCTUSp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 16:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNzdCBRI9SINYOxsdlHWR5H1QNSsHqLu1BfZAHq59f4=;
 b=FYm6Ljdkj8FxR40sA8JSs0ul0gouyV8jhH7ojkH1/MgQeHmPz7+2ecAIPjnW0HLt1Is9T4X1XUEnaxpDUByWG7tv57PWy397zUPkn9xgWIKp9gjqQxk+5jxCqAH0lrVqJlzlSZq+Ck9WFEKz4/wOVFLs94yYAyvulkFdbTEEMW8=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1093.namprd21.prod.outlook.com (52.132.130.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.5; Wed, 20 Mar 2019 20:18:41 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1730.008; Wed, 20 Mar 2019
 20:18:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Thread-Topic: [PATCH v6] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Thread-Index: AQHU3gjNNES1C2iNXEige4oL1t6+MaYU99WA
Date:   Wed, 20 Mar 2019 20:18:41 +0000
Message-ID: <DM5PR2101MB0918806B98B074BCEA1889DED7410@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190308224611.GA3047@ubu-Virtual-Machine>
 <20190319040401.GA3050@ubu-Virtual-Machine>
In-Reply-To: <20190319040401.GA3050@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-20T20:18:38.7027304Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff6591b4-d5d6-44a7-b37a-74063e763a43;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcfb2474-13b9-43d0-6e81-08d6ad713ed1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB10930DD59BF24B10765E2588D7410@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(33656002)(81166006)(76176011)(14454004)(5660300002)(66066001)(14444005)(6506007)(256004)(81156014)(7696005)(99286004)(8936002)(26005)(186003)(2906002)(10290500003)(52536014)(6116002)(6346003)(478600001)(7736002)(102836004)(305945005)(3846002)(68736007)(74316002)(86362001)(6436002)(11346002)(10090500001)(86612001)(4326008)(476003)(486006)(229853002)(53936002)(105586002)(6246003)(316002)(54906003)(55016002)(71200400001)(106356001)(8676002)(25786009)(9686003)(71190400001)(446003)(97736004)(22452003)(8990500004)(1511001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: piz7qVrfrCZzrhvEN8K5sJUx96yKCGqOtJVHjWtpQEh09cyegNAmsFlmJ5JV/G2qUuL0blarY4DyxPzUhwJ2hP3c5GwWhBLITaDeFjJTxbkLiLgDbCIpzKd7/lEBSB1cGRbkA14JvaFAqIS4ejsHR3302ANzQWWZmX4guZ6wXjaRPeKWyug+SLhm+06/JFlHL8LkqKK7jaIcy9cqrqFAm5E03EFwDI00NiurQDFbY2/KJVbfx2/ZlcsFHR76xlFoMchSUycywZouYsa28K/q2UJ/f9GZCs53DbHOfTSC4CYVhSftH1+AE7WfYdUOxVnIS3xNCpqlZ+UeFUPchaIH6fkXgsdoeesg5ek2y8B4G61y77tWRX0o/GDam79ieSU6mYdtPVqkgExKKjdBM8+VfYgilvULG01KbpJi+Ftmvsc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfb2474-13b9-43d0-6e81-08d6ad713ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 20:18:41.4537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogS2ltYmVybHkgQnJvd24gPGtpbWJyb3dua2RAZ21haWwuY29tPiBTZW50OiBNb25kYXks
IE1hcmNoIDE4LCAyMDE5IDk6MDQgUE0NCj4gDQo+IFRoZXJlIGFyZSB0d28gbWV0aG9kcyBmb3Ig
c2lnbmFsaW5nIHRoZSBob3N0OiB0aGUgbW9uaXRvciBwYWdlIG1lY2hhbmlzbQ0KPiBhbmQgaHlw
ZXJjYWxscy4gVGhlIG1vbml0b3IgcGFnZSBtZWNoYW5pc20gaXMgdXNlZCBieSBwZXJmb3JtYW5j
ZQ0KPiBjcml0aWNhbCBjaGFubmVscyAoc3RvcmFnZSwgbmV0d29ya2luZywgZXRjLikgYmVjYXVz
ZSBpdCBwcm92aWRlcw0KPiBpbXByb3ZlZCB0aHJvdWdocHV0LiBIb3dldmVyLCBsYXRlbmN5IGlz
IGluY3JlYXNlZC4gTW9uaXRvciBwYWdlcyBhcmUNCj4gYWxsb2NhdGVkIHRvIHRoZXNlIGNoYW5u
ZWxzLg0KPiANCj4gTW9uaXRvciBwYWdlcyBhcmUgbm90IGFsbG9jYXRlZCB0byBjaGFubmVscyB0
aGF0IGRvIG5vdCB1c2UgdGhlIG1vbml0b3INCj4gcGFnZSBtZWNoYW5pc20uIFRoZXJlZm9yZSwg
dGhlc2UgY2hhbm5lbHMgZG8gbm90IGhhdmUgYSB2YWxpZCBtb25pdG9yIGlkDQo+IG9yIHZhbGlk
IG1vbml0b3IgcGFnZSBkYXRhLiBJbiB0aGVzZSBjYXNlcywgc29tZSBvZiB0aGUgIl9zaG93Ig0K
PiBmdW5jdGlvbnMgcmV0dXJuIGluY29ycmVjdCBkYXRhLiBUaGV5IHJldHVybiBhbiBpbnZhbGlk
IG1vbml0b3IgaWQgYW5kDQo+IGRhdGEgdGhhdCBpcyBiZXlvbmQgdGhlIGJvdW5kcyBvZiB0aGUg
aHZfbW9uaXRvcl9wYWdlIGFycmF5IGZpZWxkcy4NCj4gDQo+IFRoZSAiY2hhbm5lbC0+b2ZmZXJt
c2cubW9uaXRvcl9hbGxvY2F0ZWQiIHZhbHVlIGNhbiBiZSB1c2VkIHRvIGRldGVybWluZQ0KPiB3
aGV0aGVyIG1vbml0b3IgcGFnZXMgaGF2ZSBiZWVuIGFsbG9jYXRlZCB0byBhIGNoYW5uZWwuDQo+
IA0KPiBBZGQgImlzX3Zpc2libGUoKSIgY2FsbGJhY2sgZnVuY3Rpb25zIGZvciB0aGUgZGV2aWNl
LWxldmVsIGFuZA0KPiBjaGFubmVsLWxldmVsIGF0dHJpYnV0ZSBncm91cHMuIFRoZXNlIGZ1bmN0
aW9ucyB3aWxsIGhpZGUgdGhlIG1vbml0b3INCj4gc3lzZnMgZmlsZXMgd2hlbiB0aGUgbW9uaXRv
ciBtZWNoYW5pc20gaXMgbm90IHVzZWQuDQo+IA0KPiBSZW1vdmUgIi5kZWZhdWx0X2F0dHJpYnV0
ZXMiIGZyb20gInZtYnVzX2NoYW5fYXR0cnMiIGFuZCBjcmVhdGUgYQ0KPiBjaGFubmVsLWxldmVs
IGF0dHJpYnV0ZSBncm91cC4gVGhlc2UgY2hhbmdlcyBhbGxvdyB0aGUgbmV3DQo+ICJpc192aXNp
YmxlKCkiIGNhbGxiYWNrIGZ1bmN0aW9uIHRvIGJlIGFwcGxpZWQgdG8gdGhlIGNoYW5uZWwtbGV2
ZWwNCj4gYXR0cmlidXRlcy4NCj4gDQo+IENhbGwgInN5c2ZzX2NyZWF0ZV9ncm91cCgpIiBpbiAi
dm1idXNfYWRkX2NoYW5uZWxfa29iaigpIiB0byBjcmVhdGUgdGhlDQo+IGNoYW5uZWwncyBzeXNm
cyBmaWxlcy4gQWRkIGEgbmV3IGZ1bmN0aW9uLA0KPiDigJx2bWJ1c19yZW1vdmVfY2hhbm5lbF9h
dHRyX2dyb3VwKCnigJ0sIGFuZCBjYWxsIGl0IGluICJmcmVlX2NoYW5uZWwoKSIgdG8NCj4gcmVt
b3ZlIHRoZSBjaGFubmVsJ3Mgc3lzZnMgZmlsZXMgd2hlbiB0aGUgY2hhbm5lbCBpcyBjbG9zZWQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaW1iZXJseSBCcm93biA8a2ltYnJvd25rZEBnbWFpbC5j
b20+DQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNv
bT4NCg==
