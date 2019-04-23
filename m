Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E8C10F14
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A962206BA
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 03:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kQlukL66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfDWDr3 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:47:29 -0400
Received: from mail-eopbgr720107.outbound.protection.outlook.com ([40.107.72.107]:53312
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfDWDr3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 23:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ZHrmh5jGt1bchGuR/rZvTSxYapXzVw1J5PIKB8M4QNHd6qHC7NX5Kw6RiT8PEtELffFjYXFf7JAUwKqycmf2Hsmj2NTPiT/LINsZ3qFzkOizXLvmEGd5WEDbQK5V8ku+72TmdAobhHXel8Nn2UMMYEvoJ1nlb8UY1AVWMnUhEyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9KCBqhn3Ew+/XHQjS2f4JblwgHBQM43dgYm4BQTv3c=;
 b=cYzf7TElezkxIfApRgymCS7+DP9ZmMbymKwfwIgES+JHl1hG1zIE7f1O1AS79WZFCgl831zSRdrxFdZ+G+hxTVuf5Q3ZeZxG1BN1eyT1Fz2e4em7SstiwY48eN7AUVlN6j+rtXJMFjF47JORwW7podFPCXMuOUq7sBeY47LLQew=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9KCBqhn3Ew+/XHQjS2f4JblwgHBQM43dgYm4BQTv3c=;
 b=kQlukL66yP4qO+RzUOuqTAswSa1cSYL1kLDz+DzpwCCbnyasTSIoZKNnlQWCl8xIcXTMb1qPDCqt01NVMAWXsx8bW3a97lqP5FiTlSJX02l3q6U4KFOVdWaWaYByLK1qwQsT9lvoY2pAOlve5OTXA3nWRK4rlJkHqpNZgWs7bS0=
Received: from MN2PR21MB1184.namprd21.prod.outlook.com (20.179.20.15) by
 MN2PR21MB1215.namprd21.prod.outlook.com (20.179.20.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.2; Tue, 23 Apr 2019 03:47:27 +0000
Received: from MN2PR21MB1184.namprd21.prod.outlook.com
 ([fe80::31a4:c0ef:11a8:e6b]) by MN2PR21MB1184.namprd21.prod.outlook.com
 ([fe80::31a4:c0ef:11a8:e6b%8]) with mapi id 15.20.1856.000; Tue, 23 Apr 2019
 03:47:27 +0000
From:   Joseph Salisbury <Joseph.Salisbury@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH][v2] drivers: hv: Add a module description line to the
 hv_vmbus driver
Thread-Topic: [PATCH][v2] drivers: hv: Add a module description line to the
 hv_vmbus driver
Thread-Index: AQHU+YdEVkGXJ1d6KkytK7w1wdNOdg==
Date:   Tue, 23 Apr 2019 03:47:27 +0000
Message-ID:
 <04eaef0e2b365317935ff756c7365ee13a6f18f8.1555967337.git.joseph.salisbury@microsoft.com>
Reply-To: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:208:a8::26) To MN2PR21MB1184.namprd21.prod.outlook.com
 (2603:10b6:208:38::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmljts@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 2.17.1
x-originating-ip: [137.117.110.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 483cc4d5-c8b4-44ad-75b7-08d6c79e673a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1215;
x-ms-traffictypediagnostic: MN2PR21MB1215:
x-microsoft-antispam-prvs: <MN2PR21MB121549AD6851CD18E817DB51AA230@MN2PR21MB1215.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(97736004)(71200400001)(81166006)(476003)(486006)(68736007)(102836004)(71190400001)(2616005)(3450700001)(256004)(53936002)(110136005)(54906003)(5660300002)(6506007)(386003)(81156014)(118296001)(8676002)(6512007)(478600001)(8936002)(7846003)(6392003)(6436002)(305945005)(36756003)(10290500003)(4744005)(2906002)(26005)(6486002)(99286004)(186003)(50226002)(14454004)(1511001)(73956011)(7736002)(43066004)(66446008)(86612001)(2501003)(4326008)(25786009)(316002)(66946007)(6116002)(66556008)(66066001)(52116002)(66476007)(10090500001)(64756008)(22452003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1215;H:MN2PR21MB1184.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WMZrfK/hjFTSH6XXAiaVC+yS4dmInNTxYzf/d5vFp8W3SEqmhOKrPTDPEK+2y59VhrkJ2us2cLydKQBTs6FF89ty47Pb6So8iA0edQOF3nmWhzNZ6c+AUAdGYCZtADW8AJVGwDZCrFYKr7xXH4Zqcj3Y5cs66QCGaYcMVBLAtH3H9CvU2e4VBfNBIURyjulimu3Y2bDrzGBF5w1Vi2BZqSMpMmkH+aQkybDo3V3tHFKLjLxEO79QnFVMKZiWK8I+Z3I9010mHUgQYGMMNqK2JMh/neKzXEB+3sEJDr6GPUMtzIFQdBbZU6/259xxAYb5taWOCPdWFAGYsrFMhm9/w26y0Z4T3AEhxVYT13gdCDByNp1UXPaCfI1nPI7FRprU2qUgKFtLPPbLqrPgscxaE4BZHlqtT28qztocQ0UC5NA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483cc4d5-c8b4-44ad-75b7-08d6c79e673a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 03:47:27.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
Message-ID: <20190423034727.LFwUNjHKG2s3IPIbAP8mo3lhNcAtNJ9nVvlRygzAEJ0@z>

VGhpcyBwYXRjaCBvbmx5IGFkZHMgYSBNT0RVTEVfREVTQ1JJUFRJT04gc3RhdGVtZW50IHRvIHRo
ZSBkcml2ZXIuDQpUaGlzIGNoYW5nZSBpcyBvbmx5IGNvc21ldGljLCBzbyB0aGVyZSBzaG91bGQg
YmUgbm8gcnVudGltZSBpbXBhY3QuDQoNClNpZ25lZC1vZmYtYnk6IEpvc2VwaCBTYWxpc2J1cnkg
PGpvc2VwaC5zYWxpc2J1cnlAbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvaHYvdm1idXNf
ZHJ2LmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQppbmRl
eCBhYTI1ZjNiY2JkZWEuLjFjYjk0MDhiMGQ0MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaHYvdm1i
dXNfZHJ2LmMNCisrKyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCkBAIC0yMTc0LDYgKzIxNzQs
NyBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgdm1idXNfZXhpdCh2b2lkKQ0KIA0KIA0KIE1PRFVMRV9M
SUNFTlNFKCJHUEwiKTsNCitNT0RVTEVfREVTQ1JJUFRJT04oIk1pY3Jvc29mdCBIeXBlci1WIFZN
QnVzIERyaXZlciIpOw0KIA0KIHN1YnN5c19pbml0Y2FsbChodl9hY3BpX2luaXQpOw0KIG1vZHVs
ZV9leGl0KHZtYnVzX2V4aXQpOw0KLS0gDQoyLjE3LjENCg0K
