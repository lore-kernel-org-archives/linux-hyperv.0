Return-Path: <SRS0=dxrV=SY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB474C10F11
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 21:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7983B205F4
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 21:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FHUO8TZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfDVVkA (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:40:00 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:41433
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728998AbfDVVj7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 17:39:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=QTsnRQreg0HrC8C0v6qLJ0SqTsWQWl6vNgHiVzXXj4u4VTIXbYFmuzhf+mpwcKSwXEZSpQp8KafEfkUYbdPGc524LvaP7h0vVoZ6wW4MjMwfFLRDMQ+MS28pDugscDg31Lnk/Nki3/M1isrmm/cSFEOBqoE7hVNrIwcQSQtBvc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfUrz73Hx0S71f40M4mRGRU149kRJ/NmcY9ICmfWa1g=;
 b=s4rSxm5SMRzpn9zazBHRtVhckB1fyDXyGHdGMhN21K2E4DSMV1OIG9oYymbObiPIPfBTcugX6ZwDJwEj+WIzmwqkY8YFXDbwfnvMET0k0O/tLv+Z6vViGgfpD4cI7Xkf2qEKEXCVUXCH0d/ICrJSMTMeNByPLRo79YDmj1cToiM=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfUrz73Hx0S71f40M4mRGRU149kRJ/NmcY9ICmfWa1g=;
 b=FHUO8TZexWN5yL1iojarffk6hYPPhdsRkC66O/V7f6QVFNE7pJps+Vt1N9o9DgZGuMvDLZ2oOonbjdpw7KRAETPAxtWhsLJetJNCrd1a7Bmn28p1ii8VWLuO5c4d+I0cGA9ESt5igqWE90oNfkKBqnmk8cNFoWHCUkJeJdIsvAw=
Received: from BN8PR21MB1169.namprd21.prod.outlook.com (20.179.73.13) by
 BN8PR21MB1153.namprd21.prod.outlook.com (20.179.72.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.2; Mon, 22 Apr 2019 21:39:56 +0000
Received: from BN8PR21MB1169.namprd21.prod.outlook.com
 ([fe80::689c:69ae:165b:1acc]) by BN8PR21MB1169.namprd21.prod.outlook.com
 ([fe80::689c:69ae:165b:1acc%8]) with mapi id 15.20.1856.000; Mon, 22 Apr 2019
 21:39:56 +0000
From:   Joseph Salisbury <Joseph.Salisbury@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers: hv: Add a module description line
Thread-Topic: [PATCH] drivers: hv: Add a module description line
Thread-Index: AQHU+VPtaJJJxRLfR0ipkHjKz/0RbQ==
Date:   Mon, 22 Apr 2019 21:39:56 +0000
Message-ID: <04eaef0e2b365317935ff756c7365ee13a6f18f8.1555967337.git.joseph.salisbury@microsoft.com>
Reply-To: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:208:160::29) To BN8PR21MB1169.namprd21.prod.outlook.com
 (2603:10b6:408:74::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmljts@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 2.17.1
x-originating-ip: [137.117.110.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9ceba65-84dc-4a16-f177-08d6c76b0ffb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1153;
x-ms-traffictypediagnostic: BN8PR21MB1153:
x-microsoft-antispam-prvs: <BN8PR21MB1153239493AA72BB695166BBAA220@BN8PR21MB1153.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(81166006)(53936002)(64756008)(52116002)(81156014)(256004)(8936002)(97736004)(26005)(6512007)(99286004)(186003)(66476007)(66556008)(478600001)(486006)(14454004)(7736002)(66446008)(102836004)(386003)(50226002)(22452003)(6506007)(3450700001)(316002)(3846002)(25786009)(6116002)(10090500001)(2616005)(10290500003)(66946007)(476003)(305945005)(73956011)(5660300002)(4744005)(54906003)(6486002)(110136005)(43066004)(6436002)(8676002)(86612001)(68736007)(36756003)(2906002)(71200400001)(118296001)(71190400001)(4326008)(2501003)(7846003)(66066001)(6392003)(1511001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1153;H:BN8PR21MB1169.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o5SHwWrqiqDxY4RngZjjh/bW0fMByEU36BdOYMbrhSAwMHzCyjXDumULHZQfBkBW7XImSAr51VuanO1l+bv8XNEvuN2Gk4LhWcmNO/23e+uGGIpMlv6IixY8kPnadyF4IykOlFWOTFfdawvljSitfhOZJc3LZyDtktSkSVoRvUmVFWVXZC7pWBdvbCnkAFK5IXvEmaNE3FcyobZD75CaI8eLwZRCwfQ4u3caOiaIeHBHa1lWy7O6fH4UTxteE12GrY88Wo3hAo4KK+8hX1FYwRBYGNz3183/1aO+DdVyPcWzvGkQT2bFP5QjegzXxe9F/X3fH0KcMV51X4h7wkUz24+/yN9QD3nLneIVByrZ1htF76w6F4iv623Y6D8ZrH+pBJugyk/yeLgLUxrgMBjOnEv0fZ7d+DtrrhvN72XVum0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ceba65-84dc-4a16-f177-08d6c76b0ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 21:39:56.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSm9zZXBoIFNhbGlzYnVyeSA8am9zZXBoLnNhbGlzYnVyeUBtaWNyb3Nv
ZnQuY29tPg0KLS0tDQogZHJpdmVycy9odi92bWJ1c19kcnYuYyB8IDEgKw0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi92bWJ1c19kcnYu
YyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCmluZGV4IGFhMjVmM2JjYmRlYS4uMWNiOTQwOGIw
ZDQwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KKysrIGIvZHJpdmVycy9o
di92bWJ1c19kcnYuYw0KQEAgLTIxNzQsNiArMjE3NCw3IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCB2
bWJ1c19leGl0KHZvaWQpDQogDQogDQogTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KK01PRFVMRV9E
RVNDUklQVElPTigiTWljcm9zb2Z0IEh5cGVyLVYgVk1CdXMgRHJpdmVyIik7DQogDQogc3Vic3lz
X2luaXRjYWxsKGh2X2FjcGlfaW5pdCk7DQogbW9kdWxlX2V4aXQodm1idXNfZXhpdCk7DQotLSAN
CjIuMTcuMQ0KDQo=
