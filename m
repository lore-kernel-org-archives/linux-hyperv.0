Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB89C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 15:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61133218A5
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 15:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="msFGvD6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCUPzc (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:55:32 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:37121
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbfCUPzb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Mar 2019 11:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DUnq2e806z0mGlv5Ogn6ek5xThZj0rLlfyqjczCN7o=;
 b=msFGvD6mbdL+c5gn3WZG2CIIudeT7uchWXeOE+wCwUaQGlwsQyoWE84dgS3PdWuJQ+AvCZEJGthC2UJgdC3SXkC3ETWApmWVufRyFSashxKOdn4+rlN1750KZA54iEi8b6htNcDwwFPL54a8LPv3dPI00gMTnYGrzTNIHdrwBKw=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0981.namprd21.prod.outlook.com (52.132.133.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.5; Thu, 21 Mar 2019 15:55:23 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::7c40:f836:e5fc:efd0]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::7c40:f836:e5fc:efd0%6]) with mapi id 15.20.1750.010; Thu, 21 Mar 2019
 15:55:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>, kimbrownkd <kimbrownkd@gmail.com>
CC:     Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Thread-Topic: [PATCH v6] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Thread-Index: AQHU3gjNNES1C2iNXEige4oL1t6+MaYVeDmAgADG7FA=
Date:   Thu, 21 Mar 2019 15:55:22 +0000
Message-ID: <DM5PR2101MB091836C94C52C1B3469C5380D7420@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190308224611.GA3047@ubu-Virtual-Machine>
 <20190319040401.GA3050@ubu-Virtual-Machine> <20190321035705.GE25262@sasha-vm>
In-Reply-To: <20190321035705.GE25262@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-21T15:55:20.6464318Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=425ce458-27ca-4f11-bc1e-631a9aeb445e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:a:9848:bfa6:ccac:fec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ed7fead-727f-4875-4874-08d6ae15a095
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0981C534DE63A65B2F784422D7420@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39860400002)(136003)(376002)(189003)(199004)(53936002)(8676002)(52536014)(11346002)(25786009)(446003)(97736004)(5660300002)(476003)(46003)(486006)(8936002)(22452003)(6436002)(9686003)(229853002)(8990500004)(33656002)(54906003)(81156014)(305945005)(55016002)(106356001)(316002)(105586002)(110136005)(10090500001)(99286004)(71190400001)(6506007)(7736002)(14454004)(478600001)(81166006)(71200400001)(68736007)(4744005)(10290500003)(4326008)(86612001)(256004)(76176011)(6246003)(102836004)(186003)(86362001)(6116002)(74316002)(7696005)(6346003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fwMiiXSa+GfQTteNttEhm70tYguT5QdLbheNMLL7f3pULYGIZFxx+Czx3iUF3yo8o209vJMrn8iHuGkkniYn52huiPbCH7m7T3fZgIDQBiIo5xJwjrm2A46h38cSnocb0N213QQeB4LJDHPfAqYjHHnI5OGHk3DE9AMGxi0HxipCMZdj7MswJyyR0K6CMjuE+E9Xc+GqQh3+qPneWc3G3gRGE6S3jbMRtVVKD5Ygn6/sJzvcpYnfLZ874i/xToVGplZCHADFs40DYdzjLQ9uU+Go0gObysngES48KsHp208mpTFdQ6X2hMk8WvqwXe4zgPgt43nsTSNNST30fo+ORIyyu44Lhruh+FCQ8tXPlPvv+mM75sgkUQTYIZAg74/a3wq88p/nkHz3nwBpyxCiG5QF7jERiutRnhRVFMMTU2U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed7fead-727f-4875-4874-08d6ae15a095
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 15:55:22.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPiBTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDIwLCAyMDE5IDg6NTcgUE0NCj4gDQo+IEkndmUgcXVldWVkIGl0IHVwIGZvciBoeXBlcnYt
Zml4ZXMsIHRoYW5rcyBLaW1iZXJseS4NCj4gDQo+IFNob3VsZCB0aGlzIGdvIGluIHN0YWJsZSBh
cyB3ZWxsPw0KPiANCg0KTXkgdGFrZTogIHRoZXNlIGNoYW5nZXMgbGVhbiBtb3JlIHRvd2FyZCBi
ZWluZyBhICJjbGVhbiB1cCIgcmF0aGVyDQp0aGFuIGZpeGluZyBhIHByb2JsZW0gdGhhdCBoYXMg
c2lnbmlmaWNhbnQgaW1wYWN0LiAgVGhlIGRhdGEgaW4gdGhlIHN5c2ZzDQplbnRyaWVzIGlzIGJv
Z3VzLCBidXQgaXNuJ3QgYWN0dWFsbHkgaHVydGluZyBhbnl0aGluZy4gVGhlIGN1cnJlbnQgY29k
ZSBkb2VzDQppbmRleCBvZmYgdGhlIGVuZCBvZiBhbiBhcnJheSBpbiBzb21lIGNhc2VzLCBidXQg
dGhlIGFjY2Vzc2VzIGFyZSByZWFkcw0KYW5kIHRoZXJlJ3MgcGxlbnR5IG9mIHBhZGRpbmcgc28g
dGhhdCBhY3R1YWxseSBtYWtpbmcgYW4gaW52YWxpZCBtZW1vcnkNCnJlZmVyZW5jZSB3b24ndCBo
YXBwZW4uICAgSW4gdGhlIGludGVyZXN0IG9mIHJlZHVjaW5nIGNodXJuIGluIHRoZQ0Kc3RhYmxl
IGJyYW5jaGVzLCBJIHdvdWxkIGxlYW4gdG93YXJkICpub3QqIGJhY2twb3J0aW5nIHRoaXMgdG8g
c3RhYmxlLg0KDQpNaWNoYWVsDQo=
