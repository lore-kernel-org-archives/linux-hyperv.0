Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E238BC10F11
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBF720843
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EZKXQIH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfDWDPt (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:15:49 -0400
Received: from mail-eopbgr760117.outbound.protection.outlook.com ([40.107.76.117]:54983
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728527AbfDWDPt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 23:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=cEi1N447JGNr/PmGgyWvU31ftY0aNUrpqQB3674U3nOxWGkd3i1SZRz9EjO/WYMZ6oL1bolyKPYwLVdQ7IuIHYlt2+hLkWWZOdOSpako/TpJ70zli0Gs6C3HcCloYXprNMVEd0tZd6rEz6i+xYWn2vkaIZr5Wac+43cmWzT8ao4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NoUk6tx5deML4M0PyqyMgE1n/wRIhDoSjl0bPcD/jY=;
 b=CJd3v4cyR0B/+Bv+8FTuBgIQtgpfI0DIykFv53cfxCM3j/2OK6IN1DvrSw7Ea4Id7nNdShwgX9BHwPCy+AY0KnyMWo+Ttiz0A/AeIS5ZQ4O11p0ImoTjF4H+ZvhIh8OHaH7cM5/L94QY0JVYb1WrxUGTMNZ4QgLd3cm0jzWRnjQ=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NoUk6tx5deML4M0PyqyMgE1n/wRIhDoSjl0bPcD/jY=;
 b=EZKXQIH3JbIq7oASBxQ0MjrhDa0OM2zr4m8XSWoPVPcm5aIylhJFlJyhRahlmjWuIEPwfD6DKEc/4pByH7Bsd5FlCSTf8B0WaRJv15lBGTptArMkFMgHo3KjKaE7WBNHUjlOpqqvWxNDuTKBgyHZxFmkQb88gM2/ouWP1/A9r4c=
Received: from SN6PR2101MB0925.namprd21.prod.outlook.com (52.132.117.14) by
 SN6PR2101MB0989.namprd21.prod.outlook.com (52.132.114.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.2; Tue, 23 Apr 2019 03:15:47 +0000
Received: from SN6PR2101MB0925.namprd21.prod.outlook.com
 ([fe80::f1ad:f334:bd40:92e1]) by SN6PR2101MB0925.namprd21.prod.outlook.com
 ([fe80::f1ad:f334:bd40:92e1%9]) with mapi id 15.20.1835.000; Tue, 23 Apr 2019
 03:15:47 +0000
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
Subject: RE: [PATCH] drivers: hid: Add a module description line
Thread-Topic: [PATCH] drivers: hid: Add a module description line
Thread-Index: AQHU+VKvIn+x34PH9kGUsz0PSRGBr6ZJDCfQ
Date:   Tue, 23 Apr 2019 03:15:46 +0000
Message-ID: <SN6PR2101MB092558880B017881591E41E2D7230@SN6PR2101MB0925.namprd21.prod.outlook.com>
References: <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
In-Reply-To: <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
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
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12dc9c68-f3a8-4964-7330-08d6c799fac0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0989;
x-ms-traffictypediagnostic: SN6PR2101MB0989:
x-microsoft-antispam-prvs: <SN6PR2101MB09892A4A44FCD1DB466C90EAD7230@SN6PR2101MB0989.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:193;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(2501003)(81156014)(8676002)(229853002)(4744005)(5660300002)(33656002)(10090500001)(8936002)(22452003)(55016002)(76116006)(6436002)(2906002)(81166006)(4326008)(25786009)(64756008)(97736004)(66946007)(73956011)(66476007)(66556008)(66446008)(8990500004)(305945005)(86362001)(66066001)(6506007)(26005)(9686003)(186003)(14454004)(71200400001)(74316002)(316002)(476003)(68736007)(6246003)(53936002)(446003)(52536014)(11346002)(256004)(86612001)(99286004)(54906003)(110136005)(76176011)(3846002)(6116002)(7696005)(102836004)(1511001)(2201001)(486006)(10290500003)(478600001)(71190400001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0989;H:SN6PR2101MB0925.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ITBGukWKKlunVEHRc37yOFgwYd27McOg1PgwcWqSB+2bP43RicfBaeq/LwjUPM5fOcI0V+JwK9I/0FcdzXDiQIb2fV21dyIp7K0gkremPUT72j7Na9hGBT3546675u1pDGhYI68z4W9w04xBmaivnaIxSAX0LdoXVM7b6AGuZJ+3NC4uyzcDEd9dleT3FNyOls/lRVMVYRk4r0XXMD5X7DC6MaFDA7nEV9R84sz/1YgdNNbAXB+QHYKs4JGimdlBECiC0NAt3MJXHJVDCY+9/XaAXABB6nXguFqaSrNQy8xgYzJpgNs9Ws96WqNtryJmdORk/sz1sjRDUiWAMIcFMVTUdfV/skbLtTdPrNqMXdMgPoq2Wi00ZFwtGvINAgA+CURhMHGg6OjsyWhXZcLOOjCm9+GQkiHJjm5uZ2kFFUQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dc9c68-f3a8-4964-7330-08d6c799fac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 03:15:46.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0989
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSm9zZXBoIFNhbGlzYnVyeSA8Sm9zZXBoLlNhbGlzYnVyeUBtaWNyb3NvZnQuY29tPiBT
ZW50OiBNb25kYXksIEFwcmlsIDIyLCAyMDE5IDI6MzEgUE0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEpvc2VwaCBTYWxpc2J1cnkgPGpvc2VwaC5zYWxpc2J1cnlAbWljcm9zb2Z0LmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2hpZC9oaWQtaHlwZXJ2LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWh5cGVy
di5jIGIvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jDQo+IGluZGV4IDcwNDA0OWU2MmQ1OC4uZDMz
MTFkNzE0ZDM1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2hpZC9oaWQtaHlwZXJ2LmMNCj4gKysr
IGIvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jDQo+IEBAIC02MTQsNSArNjE0LDcgQEAgc3RhdGlj
IHZvaWQgX19leGl0IG1vdXNldnNjX2V4aXQodm9pZCkNCj4gIH0NCj4gDQo+ICBNT0RVTEVfTElD
RU5TRSgiR1BMIik7DQo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIk1pY3Jvc29mdCBIeXBlci1WIFN5
bnRoZXRpYyBISUQgRHJpdmVyIik7DQo+ICsNCj4gIG1vZHVsZV9pbml0KG1vdXNldnNjX2luaXQp
Ow0KPiAgbW9kdWxlX2V4aXQobW91c2V2c2NfZXhpdCk7DQo+IC0tDQo+IDIuMTcuMQ0KDQpFdmVu
IHRob3VnaCBpdCB3aWxsIGxpa2VseSBiZSByZWR1bmRhbnQgd2l0aCB0aGUgY29tbWl0IHRpdGxl
LCB0aGVyZQ0KcHJvYmFibHkgbmVlZHMgdG8gYmUgYSBzaG9ydCBjb21taXQgbWVzc2FnZS4gICAo
QW5kIGFsc28gd2l0aCB0aGUNCm90aGVyIHR3byBzaW1pbGFyIHBhdGNoZXMuKQ0KDQpNaWNoYWVs
DQoNCg==
