Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609EBC10F14
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29467206BA
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o5mbHSKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfDWDqx (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:46:53 -0400
Received: from mail-eopbgr770119.outbound.protection.outlook.com ([40.107.77.119]:40553
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfDWDqx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 23:46:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Bk/+vnsfKzXM4KDu1WknDE/NP7qbkWcngMbHxH8JlnnSGuif4A4R7weHpLruDiDgt1JphBWUhwnEny/Iw6QHGnurB3ywuGnGVHk6mLUObFzCLtmm26EK1+Y9+tznEiCwZ0jvLgJGZjFzS1zZiY+7/eY2BY1TTbIAPVDGEXDp1liCyTomagxZfuJkdrN4VFFbhsuIanlGYcLbu6zQUP4ITgFGL4UzgVfVAyxJMZcU31nK9B9FUgQ0ymbA+zxsDY37IRI0vd22/ZbzmQkXltnbBGRDqPgSClh5SrjbAPXid40/Xs8ydjeimp72HYcXHuhfDdejb+HKsG/Ry38Mi1KMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCdoVAjRkLM6Lj1v9m7TrnuduVAm4eitGeS/ZMG3pcg=;
 b=BohsoVhxb2CgwYYKt9ehvf3dAe/sBNbVl77YnYRbG9IgpaK1OONwhRPzs645CvY2v9dSti+QZj/zNGUDqa/QKpvNjBzH+yx8Ey0kIYyC3wZFIVI9mdxj+rAkmlk7xuLIJfFfFKA8YH955UiWViaKxobo8f1uwXzQLQnfy/7c37hal4rv9xlq57oPblbQowD8Ajg9LF16/VUpi8CpB0qQQDaXZmKWq5ThpTcCc9JZQlzE7KQzaTGzcSqpoFPGr6+btdtYyWi+eFfs9R0N8rqJew+I409kTPoyhYEjnbJ/TFGYfIaFbACRP/q2pVhtzYNMHrAo61LWvJKWbZdmY7iy2A==
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCdoVAjRkLM6Lj1v9m7TrnuduVAm4eitGeS/ZMG3pcg=;
 b=o5mbHSKNg1lS5rzhKVw/+ap/nD0NFEKnBZ56QUtWArY0rRLb6S641dghZUyVzlfh1T65ONyjskr2zNQYOD7quo4QDw0yIVKPCato6TyOzzri/4fWxxRCXCfQuWgO8DccGKfrY46u0vnzbAQcyynnIu5C1o1Luh4yHtEf4regjHo=
Received: from MN2PR21MB1184.namprd21.prod.outlook.com (20.179.20.15) by
 MN2PR21MB1293.namprd21.prod.outlook.com (20.179.21.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.2; Tue, 23 Apr 2019 03:46:50 +0000
Received: from MN2PR21MB1184.namprd21.prod.outlook.com
 ([fe80::31a4:c0ef:11a8:e6b]) by MN2PR21MB1184.namprd21.prod.outlook.com
 ([fe80::31a4:c0ef:11a8:e6b%8]) with mapi id 15.20.1856.000; Tue, 23 Apr 2019
 03:46:50 +0000
From:   Joseph Salisbury <Joseph.Salisbury@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH][v2] drivers: hid: Add a module description line to the
 hid_hyperv driver
Thread-Topic: [PATCH][v2] drivers: hid: Add a module description line to the
 hid_hyperv driver
Thread-Index: AQHU+Ycu1K+F3eDtz0yE/mbGsR2Axg==
Date:   Tue, 23 Apr 2019 03:46:50 +0000
Message-ID:
 <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
Reply-To: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0120.namprd02.prod.outlook.com
 (2603:10b6:208:35::25) To MN2PR21MB1184.namprd21.prod.outlook.com
 (2603:10b6:208:38::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmljts@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 2.17.1
x-originating-ip: [137.117.110.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 383c7f64-2b59-4b46-51ba-08d6c79e50ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1293;
x-ms-traffictypediagnostic: MN2PR21MB1293:
x-microsoft-antispam-prvs: <MN2PR21MB129377A45DD5210E001D2D6FAA230@MN2PR21MB1293.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(110136005)(3846002)(305945005)(71190400001)(6392003)(26005)(66946007)(186003)(8936002)(54906003)(97736004)(81166006)(6506007)(7736002)(7846003)(256004)(6116002)(4326008)(386003)(1511001)(66066001)(6512007)(8676002)(25786009)(316002)(81156014)(10290500003)(2906002)(52116002)(66556008)(68736007)(118296001)(478600001)(66476007)(22452003)(53936002)(50226002)(102836004)(6486002)(2616005)(99286004)(66446008)(73956011)(43066004)(2201001)(5660300002)(14454004)(486006)(476003)(6436002)(71200400001)(2501003)(4744005)(3450700001)(10090500001)(36756003)(64756008)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1293;H:MN2PR21MB1184.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4clDwWDVLmAUiVQAZpHEE5qXlW+FthcMu3ZIIIMvW1T3Xb2gWyEV89rCPu3S9L9SlKwntEB27AsWWjUkrzuWt2AMCRP0BI+OEfNXgd54iSSR8zYcT+lB6eauFGTqzO3bixxlk6KywwJ3eadqv13wIpJOV2v+ABoijpENUVi3PHhoaRR82vzzSV0pqrcMa6pBZTpeTSz5BkdcQ1mxON21ZM+Bb4waIBUnyo1tO6wo5mw8ktOiY4lM+acE1b8qrv0Vw2hIyJoMhGzrTj9yKNlyzMOkXxk2C/n8nTaxS3yGltFyS0EZOGo7xNf8hmL1hGdL9l/GE4iop4E/E0czYZdIjck/bcZZeJYj4OxkE1TA+BlZvT5PG1Sq/HmdALgAGTS/V8zMoMBzxYsOrRPRqndW6s+LkhjfNbeXHQKVBV3xjCc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383c7f64-2b59-4b46-51ba-08d6c79e50ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 03:46:50.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1293
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
Message-ID: <20190423034650.HO0mRk1dtQSzN06KCWs1fmX1Dsh0fI0Sazir2Qe73Xk@z>

VGhpcyBwYXRjaCBvbmx5IGFkZHMgYSBNT0RVTEVfREVTQ1JJUFRJT04gc3RhdGVtZW50IHRvIHRo
ZSBkcml2ZXIuICANClRoaXMgY2hhbmdlIGlzIG9ubHkgY29zbWV0aWMsIHNvIHRoZXJlIHNob3Vs
ZCBiZSBubyBydW50aW1lIGltcGFjdC4NCg0KDQpTaWduZWQtb2ZmLWJ5OiBKb3NlcGggU2FsaXNi
dXJ5IDxqb3NlcGguc2FsaXNidXJ5QG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2hpZC9o
aWQtaHlwZXJ2LmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jIGIvZHJpdmVycy9oaWQvaGlkLWh5
cGVydi5jDQppbmRleCA3MDQwNDllNjJkNTguLmQzMzExZDcxNGQzNSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvaGlkL2hpZC1oeXBlcnYuYw0KKysrIGIvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jDQpA
QCAtNjE0LDUgKzYxNCw3IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBtb3VzZXZzY19leGl0KHZvaWQp
DQogfQ0KIA0KIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCitNT0RVTEVfREVTQ1JJUFRJT04oIk1p
Y3Jvc29mdCBIeXBlci1WIFN5bnRoZXRpYyBISUQgRHJpdmVyIik7DQorDQogbW9kdWxlX2luaXQo
bW91c2V2c2NfaW5pdCk7DQogbW9kdWxlX2V4aXQobW91c2V2c2NfZXhpdCk7DQotLSANCjIuMTcu
MQ0KDQo=
