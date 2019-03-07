Return-Path: <SRS0=GrSc=RK=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B2C43381
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7884820840
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 19:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RE+SZUb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCGTe5 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:34:57 -0500
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:53915
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfCGTe4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Mar 2019 14:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHXg9RwaIApDL1FEaYayEFUjzrOUdf/wJPTmgOogAdI=;
 b=RE+SZUb0bw+HNRgLATOv6RJpSDhsg1RC4P9EnY5BrOFBPUoMRebA02yfASeLEw1IhWE3+Lk0pz2TAUpJelO2CfWvAiHTR0xx9sqskB5tkTQXgSd/77w5YhGowIrBIRNnkXgVGSR3MZGOF1DWA72N5WFZfl0XBmMZvFvO1A6nzc8=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0967.namprd21.prod.outlook.com (52.132.133.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.2; Thu, 7 Mar 2019 19:34:53 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1709.009; Thu, 7 Mar 2019
 19:34:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "mgamal@redhat.com" <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kimbrownkd <kimbrownkd@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
Thread-Topic: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
Thread-Index: AQHU1QPtZRSIXE09xkqbBoh9CuDLqaYAbAwwgAASFoCAAA++YA==
Date:   Thu, 7 Mar 2019 19:34:53 +0000
Message-ID: <DM5PR2101MB091890642848E7F17B20DAD9D74C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190307163606.25212-1-mgamal@redhat.com>
         <DM5PR2101MB09182EAC78F8EEA57E27C26AD74C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <1551983533.5436.8.camel@redhat.com>
In-Reply-To: <1551983533.5436.8.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-07T19:34:50.7018882Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8a71e18c-29e7-4d1b-8ab3-b9f477cefbf1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0e93868-d98e-4974-a812-08d6a333f8e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB096797BAF3175B6838B02101D74C0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(97736004)(66066001)(10090500001)(8936002)(81166006)(81156014)(6636002)(8676002)(2906002)(478600001)(305945005)(2501003)(7736002)(74316002)(10290500003)(68736007)(1511001)(316002)(54906003)(9686003)(110136005)(99286004)(7696005)(476003)(8990500004)(486006)(22452003)(14444005)(71200400001)(71190400001)(76176011)(4326008)(52536013)(105586002)(11346002)(6436002)(229853002)(6246003)(256004)(5660300002)(26005)(53936002)(3846002)(6506007)(55016002)(102836004)(6346003)(33656002)(86362001)(25786009)(186003)(6116002)(446003)(14454004)(106356001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 829SQezNF/+6IGCkdIpbB8BEYRsJ0Pk0RbNgB00WPpaF8XkaxYy9wpmZDEjzpdVG6wPkMKdnA8NwzKqAKPK1l9GkN4yNyxh/1FwzOC8mkGymdC+0K2LzEv3Ay1rMLjuNQZg6PKob6AzEX4qG3gSrrl4ubQjmOmhdBbrT5ni8rBbvKvpWw+Elzq5vUkIM4Nbudu9uqOtYxI2ITmahq2QY59QuIIgDET3693UbI+D81/4iClo8NomKA2JYWlLlzVLvy6SBueukx+re6xzNPNwTG1ofCzKIfb9Ib57XRxKoHif6BQ0Cls1Iol0kg5d6VXRiT2B/1avyeojOivvcgTsJ1cqT7r35o6HmRVmAj4zH11kYUV1K2ofl12bt+Kc45HwnhnkOXHEKujY2yePvk7hMQz9rI6kstalet6DDEmGYI8k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e93868-d98e-4974-a812-08d6a333f8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 19:34:53.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTW9oYW1tZWQgR2FtYWwgPG1nYW1hbEByZWRoYXQuY29tPiAgU2VudDogVGh1cnNkYXks
IE1hcmNoIDcsIDIwMTkgMTA6MzIgQU0NCj4gPg0KPiA+IENvdWxkIHlvdSBlbGFib3JhdGUgb24g
dGhlIGNvZGUgcGF0aHMgd2hlcmUNCj4gPiBodl9nZXRfYnl0ZXNfdG9fcmVhZC93cml0ZSgpIGNv
dWxkIGJlIGNhbGxlZCB3aGVuIHRoZSByaW5nIGJ1ZmZlcg0KPiA+IGlzbid0IHlldCBhbGxvY2F0
ZWQ/wqDCoE15IHNlbnNlIGlzIHRoYXQgS2ltIEJyb3duJ3MgcGF0Y2ggd2lsbCBhZGRyZXNzDQo+
ID4gYWxsIG9mIHRoZSBjb2RlIHBhdGhzIHRoYXQgaW52b2x2ZWQgc3lzZnMgYWNjZXNzIGZyb20g
b3V0c2lkZSB0aGUNCj4gPiBkcml2ZXIuwqDCoEFuZCB3aXRoaW4gYSBkcml2ZXIsIHRoZSByaW5n
IGJ1ZmZlciBzaG91bGQgbmV2ZXIgYmUNCj4gPiBhY2Nlc3NlZA0KPiA+IHVubGVzcyBpdCBpcyBh
bHJlYWR5IGFsbG9jYXRlZC7CoMKgSXMgdGhlcmUgYW5vdGhlciBjb2RlIHBhdGggd2UncmUgbm90
DQo+ID4gYXdhcmUgb2Y/wqDCoEknbSB3b25kZXJpbmcgaWYgdGhlc2UgY2hhbmdlcyBhcmUgcmVh
bGx5IG5lZWRlZCBvbmNlDQo+ID4gS2ltIEJyb3duJ3MgcGF0Y2ggaXMgZmluaXNoZWQuDQo+ID4N
Cj4gPiBNaWNoYWVsDQo+IA0KPiBJJ3ZlIHNlZW4gb25lIGluc3RhbmNlIG9mIHRoZSByYWNlIGlu
IHRoZSBuZXR2c2MgZHJpdmVyIHdoZW4gcnVubmluZw0KPiB0cmFmZmljIHRocm91Z2ggaXQgd2l0
aCBpcGVyZjMgd2hpbGUgY29udGludW91c2x5IGNoYW5naW5nIHRoZSBjaGFubmVsDQo+IHNldHRp
bmdzLg0KPiANCj4gVGhlIGZvbGxvd2luZyBjb2RlIHBhdGggZGVhbGxvY2F0ZXMgdGhlIHJpbmcg
YnVmZmVyOg0KPiBuZXR2c2Nfc2V0X2NoYW5uZWxzKCkgLT4gbmV0dnNjX2RldGFjaCgpIC0+DQo+
IHJuZGlzX2ZpbHRlcl9kZXZpY2VfcmVtb3ZlKCkgLT4gbmV0dnNjX2RldmljZV9yZW1vdmUoKSAt
PiB2bWJ1c19jbG9zZSgpDQo+IC0+IHZtYnVzX2ZyZWVfcmluZygpIC0+IGh2X3JpbmdidWZmZXJf
Y2xlYW51cCgpLg0KPiANCj4gbmV0dnNjX3NlbmRfcGt0KCkgLT4gaHZfZ2V0X2J5dGVzX3RvX3dy
aXRlKCkgbWlnaHQgZ2V0IGNhbGxlZA0KPiBjb25jdXJyZW50bHkgYWZ0ZXIgdm1idXNfY2xvc2Uo
KSBhbmQgYmVmb3JlIHZtYnVzX29wZW4oKSByZXR1cm5zIGFuZA0KPiBzZXRzIHVwIHRoZSBuZXcg
cmluZyBidWZmZXIuDQo+IA0KPiBUaGUgcmFjZSBpcyBmYWlybHkgaGFyZCB0byByZXByb2R1Y2Ug
b24gcmVjZW50IHVwc3RyZWFtIGtlcm5lbHMsIGJ1dCBJDQo+IHN0aWxsIG1hbmFnZWQgdG8gcmVw
cm9kdWNlIGl0Lg0KDQpNeSB0aG91Z2h0IGlzIHRoYXQgYSByYWNlIGxpa2UgdGhlIGFib3ZlIG5l
ZWRzIHRvIGJlIGFkZHJlc3NlZCBpbiB0aGUNCm5ldHZzYyBkcml2ZXIuICBUaGUgcmFjZSBtYXkg
aGF2ZSBvdGhlciBwcm9ibGVtcyBiZXlvbmQganVzdA0KYWNjZXNzaW5nIHRoZSByaW5nIGJ1ZmZl
ciBiZWZvcmUgaXQgaXMgKHJlKWFsbG9jYXRlZC4gIFdoaWxlIGFkZGluZyB0aGUgdGVzdHMNCmlu
IGh2X2dldF9ieXRlc190b19yZWFkL3dyaXRlKCkgaXNuJ3QgaGFybWZ1bCwgZG9pbmcgc28gaGFz
IHRoZSBwb3RlbnRpYWwNCnRvIG1hc2sgdGhlIHJlYWwgcHJvYmxlbS4gIFRoZXNlIHJvdXRpbmVz
IGFyZSBhbHNvIHNvbWV3aGF0IHBlcmZvcm1hbmNlDQpzZW5zaXRpdmUgc28gd2UgZG9uJ3Qgd2Fu
dCBhbnkgdW5uZWNlc3Nhcnkgb3ZlcmhlYWQuDQoNCk1pY2hhZWwNCg==
