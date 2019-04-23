Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CACC282DD
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864C920843
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WiUDG8FU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfDWDZb (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:25:31 -0400
Received: from mail-eopbgr770125.outbound.protection.outlook.com ([40.107.77.125]:24325
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfDWDZa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 23:25:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=wDeAoU9jaKq2cbDphUqkpl9nqitvGnM9kvaJIsqb34bwmP8aTaGSr71GeTV7Gnq050/h6rfw46DSLygo9YRCh4NgXhCQJ7O9CmV8S2HXIG8C8omNAahC0zBuGNzZIhTAY8l/8/N8XEFfE5J7QdeTKiYcwb0fEfHCI0YGCbh/QIg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwmAEsM+LukQ/8vnL4Dxt4le4zeoQi5mYJ3m3zz9ph8=;
 b=Lrkw+5Zt7Rrdgm6bPkCfriDRL3bBXYUdGKVpyca3F6Hj5njiiq3020kOTwmMs8vcjZwoybZr6ZoscsPcAgoXqRBWJc1bF8zhw7Bk9iot1up8eJBdKl/WUZ1jyjexSX38/RPgMVSPq7Kiev+lZBm1aNN4VboF/3YT2vZS/R1htks=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwmAEsM+LukQ/8vnL4Dxt4le4zeoQi5mYJ3m3zz9ph8=;
 b=WiUDG8FURcR5l7YVL05ysfdlOSmndgNppAAV1uyV7WT6BAZ9QW3v8PRqLRM5p6dXAcrE95q9LRXbhQ5HKe4eWJHugyCCYrIUyomPvvJ9au8XaQAkn5svH6WnOKy7DzaNwO3CBWUPZx5FaX0x8PLSq1ENCvuGtQJRnP8CARRBhy4=
Received: from BN8PR21MB1185.namprd21.prod.outlook.com (20.179.73.77) by
 BN8PR21MB1297.namprd21.prod.outlook.com (20.179.74.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.4; Tue, 23 Apr 2019 03:25:15 +0000
Received: from BN8PR21MB1185.namprd21.prod.outlook.com
 ([fe80::3103:5356:bfee:87ad]) by BN8PR21MB1185.namprd21.prod.outlook.com
 ([fe80::3103:5356:bfee:87ad%8]) with mapi id 15.20.1856.004; Tue, 23 Apr 2019
 03:25:15 +0000
From:   Joseph Salisbury <Joseph.Salisbury@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: hid: Add a module description line
Thread-Topic: [PATCH] drivers: hid: Add a module description line
Thread-Index: AQHU+VKvIn+x34PH9kGUsz0PSRGBr6ZJDCfQgAAJGQA=
Date:   Tue, 23 Apr 2019 03:25:15 +0000
Message-ID: <BN8PR21MB11857F653EA51C97A48D12889C230@BN8PR21MB1185.namprd21.prod.outlook.com>
References: <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
 <SN6PR2101MB092558880B017881591E41E2D7230@SN6PR2101MB0925.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB092558880B017881591E41E2D7230@SN6PR2101MB0925.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-23T03:15:45.3845354Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9cc321c5-47f8-4018-98fc-c3567e11eb59;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Salisbury@microsoft.com; 
x-originating-ip: [47.14.67.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b887f5a-c39c-4c8a-42a9-08d6c79b4d80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1297;
x-ms-traffictypediagnostic: BN8PR21MB1297:
x-microsoft-antispam-prvs: <BN8PR21MB1297D6358F441F7BA93CB7F89C230@BN8PR21MB1297.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(51914003)(13464003)(199004)(189003)(10290500003)(10090500001)(68736007)(25786009)(22452003)(86612001)(52536014)(478600001)(110136005)(72206003)(86362001)(4326008)(54906003)(316002)(2501003)(2201001)(66556008)(66476007)(66946007)(73956011)(64756008)(74316002)(66446008)(7736002)(305945005)(6246003)(9686003)(76116006)(8990500004)(53936002)(3846002)(6116002)(97736004)(229853002)(5660300002)(256004)(71190400001)(14444005)(71200400001)(186003)(76176011)(8676002)(26005)(66066001)(99286004)(2906002)(486006)(14454004)(53546011)(33656002)(81156014)(8936002)(476003)(81166006)(446003)(11346002)(7696005)(55016002)(6506007)(1511001)(102836004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1297;H:BN8PR21MB1185.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kgx4B5tK3QZdqo9cg+SNtXWufrJH6/qR39U3BbxBl1NZDbW7rEUiD48+1UgpK2GoSpvNWH//qqmHd2z9LX05bhenA1Y/E0bVbnFZdjRFqqXmK18fIe/Qt2GrU68PkB+7E5GwtxxUkLI8R77UxP29g5ccWkE0b/TFPduV5F6/yBMAQ6ljigxnsGMCbX5EBiwrnTXCHYQbQ7CLuXg+MpjWadfpliyUvercep44vrcwdBHb9ifc2Md/HOWGVm3PgebsU+23hhjmq95gmgm/YKCYZ+kyxf2ZaYvvZ1LQ1imzOfLSc1B0o9gl/rmkix2HRbeLZNTMp94GW5lWVJMeVp27bKhns/9ZiV1RGAaPZAH8zqiB0qKfVK9/lN4UdxRbt3/mZnP5NNiGHBLxrGnpqnY95QuVjNyj6FdjVjwRxmKsugY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b887f5a-c39c-4c8a-42a9-08d6c79b4d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 03:25:15.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1297
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VGhhbmtzIGZvciB0aGUgZmVlZGJhY2suICBJJ2xsIHByb2JhYmx5IHVwZGF0ZSBlYWNoIHBhdGNo
IHN1YmplY3Qgd2l0aCB0aGUgbW9kdWxlIG5hbWVzIGFzIHdlbGwuICBJJ2xsIHNlbmQgYSB2MiBm
b3IgYWxsIHRocmVlLg0KDQpUaGFua3MsDQoNCkpvZQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4gDQpT
ZW50OiBNb25kYXksIEFwcmlsIDIyLCAyMDE5IDExOjE2IFBNDQpUbzogSm9zZXBoIFNhbGlzYnVy
eSA8Sm9zZXBoLlNhbGlzYnVyeUBtaWNyb3NvZnQuY29tPjsgS1kgU3Jpbml2YXNhbiA8a3lzQG1p
Y3Jvc29mdC5jb20+OyBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgU3Rl
cGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+OyBzYXNoYWxAa2VybmVsLm9y
Zzsgamlrb3NAa2VybmVsLm9yZzsgYmVuamFtaW4udGlzc29pcmVzQHJlZGhhdC5jb20NCkNjOiBs
aW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRyaXZl
cnM6IGhpZDogQWRkIGEgbW9kdWxlIGRlc2NyaXB0aW9uIGxpbmUNCg0KRnJvbTogSm9zZXBoIFNh
bGlzYnVyeSA8Sm9zZXBoLlNhbGlzYnVyeUBtaWNyb3NvZnQuY29tPiBTZW50OiBNb25kYXksIEFw
cmlsIDIyLCAyMDE5IDI6MzEgUE0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBTYWxpc2J1
cnkgPGpvc2VwaC5zYWxpc2J1cnlAbWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2hp
ZC9oaWQtaHlwZXJ2LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jIGIvZHJpdmVycy9o
aWQvaGlkLWh5cGVydi5jIGluZGV4IA0KPiA3MDQwNDllNjJkNTguLmQzMzExZDcxNGQzNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jDQo+ICsrKyBiL2RyaXZlcnMvaGlk
L2hpZC1oeXBlcnYuYw0KPiBAQCAtNjE0LDUgKzYxNCw3IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBt
b3VzZXZzY19leGl0KHZvaWQpICB9DQo+IA0KPiAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiAr
TU9EVUxFX0RFU0NSSVBUSU9OKCJNaWNyb3NvZnQgSHlwZXItViBTeW50aGV0aWMgSElEIERyaXZl
ciIpOw0KPiArDQo+ICBtb2R1bGVfaW5pdChtb3VzZXZzY19pbml0KTsNCj4gIG1vZHVsZV9leGl0
KG1vdXNldnNjX2V4aXQpOw0KPiAtLQ0KPiAyLjE3LjENCg0KRXZlbiB0aG91Z2ggaXQgd2lsbCBs
aWtlbHkgYmUgcmVkdW5kYW50IHdpdGggdGhlIGNvbW1pdCB0aXRsZSwgdGhlcmUNCnByb2JhYmx5
IG5lZWRzIHRvIGJlIGEgc2hvcnQgY29tbWl0IG1lc3NhZ2UuICAgKEFuZCBhbHNvIHdpdGggdGhl
DQpvdGhlciB0d28gc2ltaWxhciBwYXRjaGVzLikNCg0KTWljaGFlbA0KDQo=
