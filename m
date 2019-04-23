Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82BC10F14
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418CA206BA
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zy4ERemQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfDWDrN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:47:13 -0400
Received: from mail-eopbgr720119.outbound.protection.outlook.com ([40.107.72.119]:26651
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfDWDrN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 23:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=WdHKwSysxWHlf5/6pqIH8zrDasx6lxCjq3S+PWNY6H1LFIUIvDd9hEesml85LLHxmQm4OWqeGLep674QB/HBUtr47ms8xKLIknUbvzPrI+ls5UNaiRJcVlwU7USzGHovRFX9eg4eVpECRoyAaHjOEmVeMEk+GHB7fGtsRM74l5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sql6bPaypYiO/PgURAxp+dZHPlGMozIC8+SaAO2oL+A=;
 b=lFzedMatnpQP2JZPFz7IisaRnn4NjSb5TqW9y788ffctqKj4Y4OG0pHKNT7QRqaAwHqown7Ng3iA64XPR3s/fb4s4fSG7ltJEyRLZcz72awSVt8m5p6BWUxbSaPcd7hEjMfaGYJoANeR/XwjUWHx/KsP6O7rK8Dj+mLuhQZ1Jr4=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sql6bPaypYiO/PgURAxp+dZHPlGMozIC8+SaAO2oL+A=;
 b=Zy4ERemQ4fmHFFWWSUDsT0MY2Ht46qUp+nbniDV4OUtgFmH31wNtFsCf+Kxf7s2e54IkEUdEmeD635joE74zm2I2UyJZ32wp8fAfRDmu1iJu39IBwOiDE/LaCCrnRsHSK34BZUNf4XqXl7U7IBbu8PEBRDykhPsn+QC4y2NnrOE=
Received: from MN2PR21MB1184.namprd21.prod.outlook.com (20.179.20.15) by
 MN2PR21MB1215.namprd21.prod.outlook.com (20.179.20.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.2; Tue, 23 Apr 2019 03:47:10 +0000
Received: from MN2PR21MB1184.namprd21.prod.outlook.com
 ([fe80::31a4:c0ef:11a8:e6b]) by MN2PR21MB1184.namprd21.prod.outlook.com
 ([fe80::31a4:c0ef:11a8:e6b%8]) with mapi id 15.20.1856.000; Tue, 23 Apr 2019
 03:47:10 +0000
From:   Joseph Salisbury <Joseph.Salisbury@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH][v2] drivers: input: serio: Add a module desription to the
 hyperv_keyboard driver
Thread-Topic: [PATCH][v2] drivers: input: serio: Add a module desription to
 the hyperv_keyboard driver
Thread-Index: AQHU+Yc6+05xDCnhUkiKm3Wzddccvg==
Date:   Tue, 23 Apr 2019 03:47:09 +0000
Message-ID:
 <6a2c2e15e90138fcef67bed294d2e82d8d6f679b.1555967323.git.joseph.salisbury@microsoft.com>
Reply-To: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0028.prod.exchangelabs.com (2603:10b6:208:71::41)
 To MN2PR21MB1184.namprd21.prod.outlook.com (2603:10b6:208:38::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmljts@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 2.17.1
x-originating-ip: [137.117.110.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3fa45c6-ecf0-4c44-e8d9-08d6c79e5ce3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1215;
x-ms-traffictypediagnostic: MN2PR21MB1215:
x-microsoft-antispam-prvs: <MN2PR21MB12150C5327DD1BDC8E492D35AA230@MN2PR21MB1215.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(97736004)(71200400001)(81166006)(476003)(486006)(68736007)(102836004)(71190400001)(2616005)(3450700001)(256004)(53936002)(110136005)(54906003)(5660300002)(6506007)(386003)(81156014)(118296001)(8676002)(6512007)(478600001)(8936002)(7846003)(6392003)(6436002)(305945005)(36756003)(10290500003)(4744005)(2906002)(26005)(6486002)(99286004)(186003)(50226002)(14454004)(1511001)(73956011)(7736002)(43066004)(66446008)(86612001)(2501003)(4326008)(25786009)(316002)(66946007)(2201001)(6116002)(66556008)(66066001)(52116002)(66476007)(10090500001)(64756008)(22452003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1215;H:MN2PR21MB1184.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eQA6eL75KI67QT4juJ2Fcd7NCSaBdQQZntl7bbgCg9gq/U6l03Y1TGmlNEPkiPnwhTloKftsoo1V7gLva2Y4sgwNPnjFpWcf6gHlhjC2DKIAt4WrCLkFhmmq1yWa+NhnrcyBp543jU172zfGcR2TJjjGdwZS4TNRc0kz5OyTAEz3ZlzFShcuKwaJNjZzEG8LmBclHeMTuu5ZeQW+FZAuiyscAJq5YzT62awhGa9kqkBKp/mooQN/wcrh4HMOR/m03zVqz4pnyvCVDqmb/Sfxg4nxykYEzQsc0pvz315R2AYmn/nEb06z0JjjH45YVe3jymlXyjPbd6NjkNLylpTDsuQ1efhoazH/8XuzF04g9XhHXhKi5/912x9BHLT264u0UAw5P2D8zT+Wamptd65Sek7cwNTY+FRg2ph5veVcQoE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa45c6-ecf0-4c44-e8d9-08d6c79e5ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 03:47:09.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
Message-ID: <20190423034709.gwTU57-YgI2xmDFVAa4BRIfGDt8NNdepz803W59RcMw@z>

VGhpcyBwYXRjaCBvbmx5IGFkZHMgYSBNT0RVTEVfREVTQ1JJUFRJT04gc3RhdGVtZW50IHRvIHRo
ZSBkcml2ZXIuDQpUaGlzIGNoYW5nZSBpcyBvbmx5IGNvc21ldGljLCBzbyB0aGVyZSBzaG91bGQg
YmUgbm8gcnVudGltZSBpbXBhY3QuDQoNClNpZ25lZC1vZmYtYnk6IEpvc2VwaCBTYWxpc2J1cnkg
PGpvc2VwaC5zYWxpc2J1cnlAbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW5wdXQvc2Vy
aW8vaHlwZXJ2LWtleWJvYXJkLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9zZXJpby9oeXBlcnYta2V5Ym9hcmQu
YyBiL2RyaXZlcnMvaW5wdXQvc2VyaW8vaHlwZXJ2LWtleWJvYXJkLmMNCmluZGV4IGE4YjliZTNl
MjhkYi4uNzkzNWU1MmI1NDM1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbnB1dC9zZXJpby9oeXBl
cnYta2V5Ym9hcmQuYw0KKysrIGIvZHJpdmVycy9pbnB1dC9zZXJpby9oeXBlcnYta2V5Ym9hcmQu
Yw0KQEAgLTQ0MCw1ICs0NDAsNyBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgaHZfa2JkX2V4aXQodm9p
ZCkNCiB9DQogDQogTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KK01PRFVMRV9ERVNDUklQVElPTigi
TWljcm9zb2Z0IEh5cGVyLVYgU3ludGhldGljIEtleWJvYXJkIERyaXZlciIpOw0KKw0KIG1vZHVs
ZV9pbml0KGh2X2tiZF9pbml0KTsNCiBtb2R1bGVfZXhpdChodl9rYmRfZXhpdCk7DQotLSANCjIu
MTcuMQ0KDQo=
