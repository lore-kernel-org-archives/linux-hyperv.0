Return-Path: <SRS0=dxrV=SY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266FBC10F11
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 21:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E733D2075A
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 21:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SVQ8JJ6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfDVViL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:38:11 -0400
Received: from mail-eopbgr740138.outbound.protection.outlook.com ([40.107.74.138]:16235
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728998AbfDVViL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 17:38:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=FPoI1rIZ5AAPjXD1nfsucGE1FwnOGUcoYnrqib8xKitRe0JNPq8Yy0C850gQKtW2jNGD8+LOO9vXZ864S6hs9s+m3AkbLx+xeV1+Mo5l/te2URJYowYbFzmwsNNjELTTbBam8fX695sVfIj4YfB8H4oiKWKG+1c301x9Xudq7Ss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgJ03KWfPezD6ULmNPgwjJs9/T5yNPJOMNe573Llp3M=;
 b=lMhYId9smmmLKEcSN8M5xhEv6ssr+BV6QceVDwF0VAlPu3gHRew89GeKWY7z5kwcLDoSII3syab2P10E5vAI7B/kEludFc2gBAtf/0cLz9hIZ3uXsK2+FZC/jF67TDSiDURivX+0fO4sTDvBaMuvilZ6X0yrQ4rSqA4Qk3fnbTo=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgJ03KWfPezD6ULmNPgwjJs9/T5yNPJOMNe573Llp3M=;
 b=SVQ8JJ6FM6cmF//KI6d2fXyueI7qQxNuBx4dfVkhX3grWAZT8JLhKCAU9TIbj3cYdGUG76X6ypkKycMDPO89TCOX77OK21iCebzIYdjpAD16u0z2dAUs1e7GEdRR+0hxfmaHTZo7q+gZFL+FFwez6Q0vxKzPdxvfn8aUIqVH93A=
Received: from BN8PR21MB1169.namprd21.prod.outlook.com (20.179.73.13) by
 BN8PR21MB1217.namprd21.prod.outlook.com (20.179.73.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.1; Mon, 22 Apr 2019 21:38:08 +0000
Received: from BN8PR21MB1169.namprd21.prod.outlook.com
 ([fe80::689c:69ae:165b:1acc]) by BN8PR21MB1169.namprd21.prod.outlook.com
 ([fe80::689c:69ae:165b:1acc%8]) with mapi id 15.20.1856.000; Mon, 22 Apr 2019
 21:38:08 +0000
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
Subject: [PATCH] drivers: input: serio: Add a module desription
Thread-Topic: [PATCH] drivers: input: serio: Add a module desription
Thread-Index: AQHU+VOtlxvMtDED/0uO7Q7nWiFRdQ==
Date:   Mon, 22 Apr 2019 21:38:08 +0000
Message-ID: <6a2c2e15e90138fcef67bed294d2e82d8d6f679b.1555967323.git.joseph.salisbury@microsoft.com>
Reply-To: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) To BN8PR21MB1169.namprd21.prod.outlook.com
 (2603:10b6:408:74::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmljts@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 2.17.1
x-originating-ip: [137.117.110.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ae27043-a43e-4c7e-2e1c-08d6c76acf94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1217;
x-ms-traffictypediagnostic: BN8PR21MB1217:
x-microsoft-antispam-prvs: <BN8PR21MB12179976AD62DE03F79D56BBAA220@BN8PR21MB1217.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(52116002)(2906002)(66476007)(10290500003)(66446008)(25786009)(256004)(110136005)(71190400001)(54906003)(66556008)(64756008)(50226002)(7846003)(6392003)(66946007)(71200400001)(305945005)(6436002)(3450700001)(53936002)(6512007)(2201001)(6116002)(86612001)(4326008)(1511001)(73956011)(26005)(3846002)(486006)(186003)(118296001)(99286004)(97736004)(8936002)(22452003)(102836004)(7736002)(2501003)(386003)(36756003)(10090500001)(6506007)(6486002)(5660300002)(66066001)(478600001)(316002)(81166006)(81156014)(43066004)(8676002)(2616005)(68736007)(476003)(4744005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1217;H:BN8PR21MB1169.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +AoO4FdN1oTj7zCt7OusjYAZSzSFMe8sIXQBr6lHfYr+jOeThDehlkKycsDUkgmtpJDAhwTr+pcZZ9LCEosPA80pnyDsSODj0BV5uDCQBzgCfKZsxLF2axiMb2DOYEcaNmhXfEIeerYJGzsI/rq+pQ1JVKMcDloBDkrENpnudjD816IVIIkFG2NrpMQkUfgjuH6XJiYf9rlwf1QlAwq7Ztrc8eSEBgC8cab1rR7iY9zz6dyjAVRUOmGZpHwA1QKBIJ+cXXifkipFXnm0icwDxCnf1WHDMHOz0hKRQYn41/IxujM36I5biBSJMzR7Kl+IVdlcL9AECdYcbC6peLdymHfMppdoD4BPYK+byZ+UEPodY3xQPHDzDcHX4J/X8d0ZDJSji8VvDKbe524bW56RtAreZZUjFb0Wt8p/bBVXo3o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae27043-a43e-4c7e-2e1c-08d6c76acf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 21:38:08.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1217
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSm9zZXBoIFNhbGlzYnVyeSA8am9zZXBoLnNhbGlzYnVyeUBtaWNyb3Nv
ZnQuY29tPg0KLS0tDQogZHJpdmVycy9pbnB1dC9zZXJpby9oeXBlcnYta2V5Ym9hcmQuYyB8IDIg
KysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lucHV0L3NlcmlvL2h5cGVydi1rZXlib2FyZC5jIGIvZHJpdmVycy9pbnB1dC9zZXJpby9o
eXBlcnYta2V5Ym9hcmQuYw0KaW5kZXggYThiOWJlM2UyOGRiLi43OTM1ZTUyYjU0MzUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2lucHV0L3NlcmlvL2h5cGVydi1rZXlib2FyZC5jDQorKysgYi9kcml2
ZXJzL2lucHV0L3NlcmlvL2h5cGVydi1rZXlib2FyZC5jDQpAQCAtNDQwLDUgKzQ0MCw3IEBAIHN0
YXRpYyB2b2lkIF9fZXhpdCBodl9rYmRfZXhpdCh2b2lkKQ0KIH0NCiANCiBNT0RVTEVfTElDRU5T
RSgiR1BMIik7DQorTU9EVUxFX0RFU0NSSVBUSU9OKCJNaWNyb3NvZnQgSHlwZXItViBTeW50aGV0
aWMgS2V5Ym9hcmQgRHJpdmVyIik7DQorDQogbW9kdWxlX2luaXQoaHZfa2JkX2luaXQpOw0KIG1v
ZHVsZV9leGl0KGh2X2tiZF9leGl0KTsNCi0tIA0KMi4xNy4xDQoNCg==
