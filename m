Return-Path: <SRS0=dxrV=SY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C1BC282CE
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B6B2075A
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 21:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="crxKWE19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfDVVbG (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:31:06 -0400
Received: from mail-eopbgr700126.outbound.protection.outlook.com ([40.107.70.126]:13281
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbfDVVbG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 17:31:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=qphl9eYk8BtYcFQ073F7rIwRW2RRcfKKzc3vOqWqiNtySDrWlBRQvu5MlIJHcE9AJsNEm+hbn1b5QLn46XadYUjoQEIHZr2eBbp++UHSlNvKiB4LdzmAJ86hN22w74whJC8g78h5eOsvqosi7WAxoT2p4t7VLVMGeOR0kTC/CHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E85tjeVLrU6mmQzLXaqo8ZsCX5NEXfRBR/zQT8hoHRw=;
 b=OkyKXkJqI6d67hAbUR///xbM5KoG1EUoM6GttU+6RzfcYs02xl4rYcqpgllsCcCBIunqLK9ZUjlS4l8xqs0gDUYo+GFhooES3xHFqN0TOxlpxQMG4EH/1NT+c0eAaiFXlaAqnI4Kx831dPxt6dRXg49kHca3UVJvcWHbQTfVSdw=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E85tjeVLrU6mmQzLXaqo8ZsCX5NEXfRBR/zQT8hoHRw=;
 b=crxKWE195vX+/OeeAD8s7q6/eQwUE0doTO8QqEAEYJJPjIW2KwLa7xjODi2/SApouud8ex+40xqS2F/42dLo7/UUExUcIX1x7CQTIFHn8NAfUY9WD+zbGUhFH2ryC5kQbETpbVMGvkbuJuFYl+deUmSeLaI+LnwsRBItVSgWkUU=
Received: from BN8PR21MB1169.namprd21.prod.outlook.com (20.179.73.13) by
 BN8PR21MB1267.namprd21.prod.outlook.com (20.179.74.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.3; Mon, 22 Apr 2019 21:31:03 +0000
Received: from BN8PR21MB1169.namprd21.prod.outlook.com
 ([fe80::689c:69ae:165b:1acc]) by BN8PR21MB1169.namprd21.prod.outlook.com
 ([fe80::689c:69ae:165b:1acc%8]) with mapi id 15.20.1856.000; Mon, 22 Apr 2019
 21:31:03 +0000
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
Subject: [PATCH] drivers: hid: Add a module description line
Thread-Topic: [PATCH] drivers: hid: Add a module description line
Thread-Index: AQHU+VKvIn+x34PH9kGUsz0PSRGBrw==
Date:   Mon, 22 Apr 2019 21:31:03 +0000
Message-ID: <324016691a62a13ce46c9ccd35c7e492bf609fd6.1555967348.git.joseph.salisbury@microsoft.com>
Reply-To: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0014.prod.exchangelabs.com
 (2603:10b6:207:18::27) To BN8PR21MB1169.namprd21.prod.outlook.com
 (2603:10b6:408:74::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmljts@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 2.17.1
x-originating-ip: [137.117.110.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76a3050b-46d6-4568-93b6-08d6c769d228
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1267;
x-ms-traffictypediagnostic: BN8PR21MB1267:
x-microsoft-antispam-prvs: <BN8PR21MB126786EE8DDFFC78E7E59A9BAA220@BN8PR21MB1267.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(7736002)(305945005)(6392003)(3846002)(386003)(6436002)(6506007)(52116002)(7846003)(54906003)(478600001)(316002)(22452003)(36756003)(1511001)(110136005)(10290500003)(26005)(50226002)(10090500001)(6486002)(6116002)(186003)(118296001)(102836004)(2501003)(68736007)(99286004)(2906002)(4744005)(8936002)(43066004)(8676002)(81166006)(81156014)(256004)(66946007)(2201001)(66066001)(4326008)(73956011)(71190400001)(71200400001)(86612001)(66556008)(66446008)(486006)(97736004)(53936002)(25786009)(6512007)(14454004)(5660300002)(2616005)(64756008)(476003)(66476007)(3450700001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1267;H:BN8PR21MB1169.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t8rzVm2SZMxRChTQxV10oT3GiG6/LMzBaJ3g0pIfqbdo6EJDGuCqlYLjHWQdQPZoT64Jvd+ZynSPoSKE1hjzLG19hy+6JL8/z9fnAKiYIzrZf7DfeV+GDjKXTsVOtQ0NrKUsqF65v7mcSAlk/7PTiE01xgJPvLYENmXDPDfGkBMDs+8fbJcClu4IFhOM0pTrVTolIjLAqGrSjJOeMp3jFh72ztcPu606HRKpuaNEXVt+WuUfrR1mDqvj0kR1aEHJVuhlgkQX3vkTBlvVxFqNTkbzODO2iOlOz7/PFKRtF+H8pxSgbvI4HNf9v6armxFCoaRS18Udy4TuRWIAjORnglglBMg1xYgnKSrY1vqS3hgs8fBjSe9VZGdumlpDmuNlwmc0xHIUqpXlB3d17rGp1vhx6rdpFiWD9+4NCBQiyJI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a3050b-46d6-4568-93b6-08d6c769d228
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 21:31:03.4180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1267
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSm9zZXBoIFNhbGlzYnVyeSA8am9zZXBoLnNhbGlzYnVyeUBtaWNyb3Nv
ZnQuY29tPg0KLS0tDQogZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jIHwgMiArKw0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1o
eXBlcnYuYyBiL2RyaXZlcnMvaGlkL2hpZC1oeXBlcnYuYw0KaW5kZXggNzA0MDQ5ZTYyZDU4Li5k
MzMxMWQ3MTRkMzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2hpZC9oaWQtaHlwZXJ2LmMNCisrKyBi
L2RyaXZlcnMvaGlkL2hpZC1oeXBlcnYuYw0KQEAgLTYxNCw1ICs2MTQsNyBAQCBzdGF0aWMgdm9p
ZCBfX2V4aXQgbW91c2V2c2NfZXhpdCh2b2lkKQ0KIH0NCiANCiBNT0RVTEVfTElDRU5TRSgiR1BM
Iik7DQorTU9EVUxFX0RFU0NSSVBUSU9OKCJNaWNyb3NvZnQgSHlwZXItViBTeW50aGV0aWMgSElE
IERyaXZlciIpOw0KKw0KIG1vZHVsZV9pbml0KG1vdXNldnNjX2luaXQpOw0KIG1vZHVsZV9leGl0
KG1vdXNldnNjX2V4aXQpOw0KLS0gDQoyLjE3LjENCg0K
