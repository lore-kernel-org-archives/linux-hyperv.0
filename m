Return-Path: <SRS0=Cz6W=SE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1F2C4360F
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Apr 2019 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99B020693
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Apr 2019 15:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TURtBL1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfDBP7B (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:59:01 -0400
Received: from mail-eopbgr780111.outbound.protection.outlook.com ([40.107.78.111]:64121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfDBP7B (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Apr 2019 11:59:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ov3RaWlt+VSfIAh+KTna84hvQLTB4UZuNt40c9wnQAv6b27Uyd7sa92IswrhkZCXlsRLCYKDR06QIFDA2P/f0RoJjMCJd0fZk64Q2MK7LSowrTw5aqi3wDmXNdqXzaJcp++0cVG8jdzaAtshYEO9wvp503OBp16CfYBRmaRCsOw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOVH1ZJfJFLSNf/eaahU50B/ZOQJjeEf0Z4AIjXT7zs=;
 b=O41N3IeVk0BWNK4wLs4bnIugCB6i5EQhdunqSsoOKDHylYmNOfarmdE5DVsAAnZq4D+PZHxIo+jR7614kq+DQX3tDSUevVuJ/4lFFBz6/xj/k3RSqfD54XXy9dli+hSRiJPbmQGibEWrmkBbKE3jPdqkVtBc0TVbI1zdJmBvJnc=
ARC-Authentication-Results: i=1; test.office365.com 1;dmarc=none action=none
 header.from=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOVH1ZJfJFLSNf/eaahU50B/ZOQJjeEf0Z4AIjXT7zs=;
 b=TURtBL1APgcMNBVCbjzARhaVVffoT1UFvsX98a7T3xR0kQX/McKVh7dx2jtNIHZ8wd5o49Hk9Nu4RlfjnD5GvnfAhc5msrGWKPo7EUkWfEHcfVxdHE4Iz/fSrQ3dZXcVzZYsR9OeUgnxLHudNExWXDq2BKxpYofPF1AfNpKcMZU=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1195.namprd21.prod.outlook.com (20.179.49.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.7; Tue, 2 Apr 2019 15:58:57 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049%8]) with mapi id 15.20.1792.000; Tue, 2 Apr 2019
 15:58:57 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "emilne@redhat.com" <emilne@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/1] scsi: storvsc: Reduce default ring buffer size to 128
 Kbytes
Thread-Topic: [PATCH 1/1] scsi: storvsc: Reduce default ring buffer size to
 128 Kbytes
Thread-Index: AQHU6NPAwqy3b0fRgku3jt+SxDRai6YpCAbA
Date:   Tue, 2 Apr 2019 15:58:57 +0000
Message-ID: <DM6PR21MB1337435B5EBFF250E412C506CA560@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1554154871-10305-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1554154871-10305-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-02T15:58:55.9823007Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b055f675-b910-4eb5-80f8-ed8f2dbf4aa1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a924f993-74d0-45ac-b2e1-08d6b7841d58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1195;
x-ms-traffictypediagnostic: DM6PR21MB1195:
x-microsoft-antispam-prvs: <DM6PR21MB1195AB30756D8867FE55EFA9CA560@DM6PR21MB1195.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(13464003)(81166006)(33656002)(6506007)(7696005)(55016002)(71190400001)(66066001)(6246003)(476003)(486006)(8990500004)(86612001)(316002)(10090500001)(2906002)(26005)(6436002)(106356001)(53546011)(105586002)(2201001)(11346002)(102836004)(14454004)(10290500003)(86362001)(71200400001)(1511001)(68736007)(9686003)(8936002)(305945005)(4326008)(76176011)(25786009)(186003)(6116002)(229853002)(446003)(81156014)(8676002)(22452003)(256004)(97736004)(4744005)(52536014)(3846002)(53936002)(99286004)(74316002)(2501003)(5660300002)(7736002)(107886003)(478600001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1195;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qfaKsSGkG+QNqiwQRcxNcObJp9CAWNolX3B/lG6h1mdXQrN8MKvL4sJ9qTVHeH9P0etAJ4+o8h0CFKn5yAjsjOBs1wIUFz3uyzqXPlgKSZQRPL65UizevYUdhxSRU/o90a7kgMn7WRMz9dWFUk4kLrrUEKROyDTfg91xNlmvcEwQpk2ys6unIntPMgTNtBF/tmvB2E1Fz1mdy6LfHO0yuyTTUJ/sW2QmDNNXBFX7BTRoJM1H3GRJteHe1FjuX5p5fpIWSvMAs907hvRKWz4aha9NbUpXp4ywr52JauP0tC+fywkyInI/e7xNCnYYhKhQs59E61ioGo8imKexgT40KPdwTrwnEer2qBS9Tm7angHd8YERf6GOFWTKl7iwTdfpG0cqv6Ua0JQir5LwqhLCRt5bYJbQlMFwaKqjHM3XeCs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a924f993-74d0-45ac-b2e1-08d6b7841d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:58:57.3720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1195
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtaHlwZXJ2LW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtaHlwZXJ2LQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBNaWNoYWVsIEtlbGxleQ0KPiBTZW50OiBNb25kYXksIEFwcmlsIDEs
IDIwMTkgNTo0MiBQTQ0KPiBUbzogS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+OyBt
YXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsgTG9uZyBMaQ0KPiA8bG9uZ2xpQG1pY3Jvc29mdC5j
b20+OyBKYW1lcy5Cb3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tOw0KPiBlbWlsbmVAcmVk
aGF0LmNvbTsgbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNaWNoYWVs
IEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvMV0g
c2NzaTogc3RvcnZzYzogUmVkdWNlIGRlZmF1bHQgcmluZyBidWZmZXIgc2l6ZSB0byAxMjggS2J5
dGVzDQo+IA0KPiBSZWR1Y2UgdGhlIGRlZmF1bHQgVk1idXMgY2hhbm5lbCByaW5nIGJ1ZmZlciBz
aXplIGZvciBzdG9ydnNjIFNDU0kgZGV2aWNlcw0KPiBmcm9tIDEgTWJ5dGUgdG8gMTI4IEtieXRl
cy4gTWVhc3VyZW1lbnRzIHNob3cgdGhhdCByaW5nIGJ1ZmZlciBzaXplcyBhYm92ZQ0KPiAxMjgg
S2J5dGVzIGRvIG5vdCBpbmNyZWFzZSBwZXJmb3JtYW5jZSBldmVuIGF0IHZlcnkgaGlnaCBJT1BT
IHJhdGVzLCBzbyBkb24ndA0KPiB3YXN0ZSB0aGUgbWVtb3J5LiBBbHNvIHJlbW92ZSB0aGUgZGVw
ZW5kZW5jZSBvbiBQQUdFX1NJWkUsIHNpbmNlIHRoZSByaW5nDQo+IGJ1ZmZlciBzaXplIHNob3Vs
ZCBub3QgY2hhbmdlIG9uIGFyY2hpdGVjdHVyZXMgd2hlcmUgUEFHRV9TSVpFIGlzIG5vdCA0IEti
eXRlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNy
b3NvZnQuY29tPg0KDQpSZXZpZXdlZC1ieTogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9z
b2Z0LmNvbT4NClRoYW5rIHlvdS4NCg==
