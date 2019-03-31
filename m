Return-Path: <SRS0=+i6l=SC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA4C43381
	for <linux-hyperv@archiver.kernel.org>; Sun, 31 Mar 2019 23:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5194720866
	for <linux-hyperv@archiver.kernel.org>; Sun, 31 Mar 2019 23:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ek9ECAfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfCaX5c (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:57:32 -0400
Received: from mail-eopbgr710099.outbound.protection.outlook.com ([40.107.71.99]:47840
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731335AbfCaX5b (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 31 Mar 2019 19:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=mvom5AFeaqclhQ7r2pe+kAz89TjPqZAHvPV4YmnVUs1bj8+zuXf3GOwXIB8t93RelLAQ1fSavwO64KZMMFOU9vH6geLuVCNgEXCFORdHLc8Tdp+RaFPG/WJrnWXIXhxU5HcR4wW33TVOewOhjYmqG9hicpC+SJU8JsFh9y4rZ7s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ8HB+j+P3z2raSVOy1thiADYKs9qTQ3klK6hIxoEz8=;
 b=qUDnV/k8NGJiq2YtLnV0r37EdupdXz0gv7ti6VQUgT4gMpq5Je+74RxX/IQQmRs6+MmE8EppDpgOwXdwSDSkmwTdnsAmoQtJh2xMre9IyOacJF2Vw65EI8OGBxF/MFiQ2S14n0j9f8lb6VW00gXZn9rRNbO8reZhQP8t4Gh6dpY=
ARC-Authentication-Results: i=1; test.office365.com 1;dmarc=none action=none
 header.from=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ8HB+j+P3z2raSVOy1thiADYKs9qTQ3klK6hIxoEz8=;
 b=ek9ECAfxgYCWB5ZrBM1Mf3igpkHyirNuj5K+9OamMNdd0Pb3l4YQ5XZ4ngfkaFDB+a2E+9B3k9/5G4tckjzAX8mq/TQlqC62TP5NMRkjpb4ltN+txcqsBr2qHjulmjH10K+zsbkRdQUicC4AaGYhbAxzEeKHuSXy+vOUC6UzyAs=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0276.namprd21.prod.outlook.com (10.173.203.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.2; Sun, 31 Mar 2019 23:57:28 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c%14]) with mapi id 15.20.1771.002; Sun, 31 Mar 2019
 23:57:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "emilne@redhat.com" <emilne@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/1] scsi: storvsc: Fix calculation of sub-channel count
Thread-Topic: [PATCH 1/1] scsi: storvsc: Fix calculation of sub-channel count
Thread-Index: AQHU6B1/IlcHzsnAWkK0ZsVGotIa4g==
Date:   Sun, 31 Mar 2019 23:57:28 +0000
Message-ID: <1554076559-14873-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0011.namprd13.prod.outlook.com
 (2603:10b6:301:29::24) To BN6PR21MB0466.namprd21.prod.outlook.com
 (2603:10b6:404:b2::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.159.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36ebd018-5ef5-4600-7fbf-08d6b634a153
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR21MB0276;
x-ms-traffictypediagnostic: BN6PR21MB0276:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-prvs: <BN6PR21MB0276473932C1425E4FEA12C3D7540@BN6PR21MB0276.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0993689CD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(5660300002)(4326008)(3846002)(66066001)(6512007)(186003)(476003)(36756003)(6116002)(68736007)(8936002)(305945005)(6486002)(4720700003)(81166006)(81156014)(8676002)(486006)(7736002)(1511001)(6436002)(2616005)(2501003)(50226002)(25786009)(386003)(26005)(10290500003)(10090500001)(14454004)(6506007)(99286004)(53936002)(105586002)(106356001)(478600001)(71190400001)(71200400001)(52116002)(14444005)(256004)(2201001)(86362001)(86612001)(316002)(22452003)(110136005)(102836004)(107886003)(2906002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0276;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: avrEKth1A+Ij3VY7cSDjIzQKvYZ67009u8+7UuhdnxDCEVrDevcP7uEbu/PrkOOk98B8pbWlurG0UIydDwyBP5INTGQXsw4oAp6arW7GtMlCvmf18p1pDlLI25+o8XDqlAsg1onDP6oeolNGSuuYf1oj0+Jqoxp5IlkV46HOl81+sXDU83nvf3MFyvJAfH0wygT0WPkrWpD65uzevG08HLICGgww9H9gvvXGRD3oemX0huza8sTFF5F0yyGCu/a9RsSq8XWwzYlI6Qd/2BzfH53rDDood/nvaJZr4zl1nnf0e9wwfCr2RRNsthh3tiQDw5LTSHIV41QpL3urNmySkiGy9ZTsfRMuVcfDME2W1LZlxv4EpyIWQY0SL7dSxDArkKR/nNoTf2sdmWYC5NUBqySiZ+JFUIO90Z5BAH8WP9k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ebd018-5ef5-4600-7fbf-08d6b634a153
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2019 23:57:28.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0276
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

V2hlbiB0aGUgbnVtYmVyIG9mIHN1Yi1jaGFubmVscyBvZmZlcmVkIGJ5IEh5cGVyLVYgaXMgPj0g
dGhlIG51bWJlcg0Kb2YgQ1BVcyBpbiB0aGUgVk0sIGNhbGN1bGF0ZSB0aGUgY29ycmVjdCBudW1i
ZXIgb2Ygc3ViLWNoYW5uZWxzLg0KVGhlIGN1cnJlbnQgY29kZSBwcm9kdWNlcyBvbmUgdG9vIG1h
bnkuDQoNClRoaXMgc2NlbmFyaW8gYXJpc2VzIG9ubHkgd2hlbiB0aGUgbnVtYmVyIG9mIENQVXMg
aXMgYXJ0aWZpY2lhbGx5DQpyZXN0cmljdGVkIChmb3IgZXhhbXBsZSwgd2l0aCBtYXhjcHVzPTxu
PiBvbiB0aGUga2VybmVsIGJvb3QgbGluZSksDQpiZWNhdXNlIEh5cGVyLVYgbm9ybWFsbHkgb2Zm
ZXJzIGEgc3ViLWNoYW5uZWwgY291bnQgPCBudW1iZXIgb2YgQ1BVcy4NCldoaWxlIHRoZSBjdXJy
ZW50IGNvZGUgZG9lc24ndCBicmVhaywgdGhlIGV4dHJhIHN1Yi1jaGFubmVsIGlzDQp1bmJhbGFu
Y2VkIGFjcm9zcyB0aGUgQ1BVcyAoZm9yIGV4YW1wbGUsIGEgdG90YWwgb2YgNSBjaGFubmVscyBv
bg0KYSBWTSB3aXRoIDQgQ1BVcykuDQoNClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxt
aWtlbGxleUBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMg
fCAxMiArKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgYi9k
cml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYw0KaW5kZXggODQzODBiYS4uZmJhYTExYSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jDQorKysgYi9kcml2ZXJzL3Njc2kvc3Rv
cnZzY19kcnYuYw0KQEAgLTY3NCw3ICs2NzQsMTcgQEAgc3RhdGljIHZvaWQgIGhhbmRsZV9tdWx0
aWNoYW5uZWxfc3RvcmFnZShzdHJ1Y3QgaHZfZGV2aWNlICpkZXZpY2UsIGludCBtYXhfY2hucykN
CiAJc3RydWN0IHZzdG9yX3BhY2tldCAqdnN0b3JfcGFja2V0Ow0KIAlpbnQgcmV0LCB0Ow0KIA0K
LQludW1fc2MgPSAoKG1heF9jaG5zID4gbnVtX2NwdXMpID8gbnVtX2NwdXMgOiBtYXhfY2hucyk7
DQorCS8qDQorCSAqIElmIHRoZSBudW1iZXIgb2YgQ1BVcyBpcyBhcnRpZmljaWFsbHkgcmVzdHJp
Y3RlZCwgc3VjaCBhcw0KKwkgKiB3aXRoIG1heGNwdXM9MSBvbiB0aGUga2VybmVsIGJvb3QgbGlu
ZSwgSHlwZXItViBjb3VsZCBvZmZlcg0KKwkgKiBzdWItY2hhbm5lbHMgPj0gdGhlIG51bWJlciBv
ZiBDUFVzLiBUaGVzZSBzdWItY2hhbm5lbHMNCisJICogc2hvdWxkIG5vdCBiZSBjcmVhdGVkLiBU
aGUgcHJpbWFyeSBjaGFubmVsIGlzIGFscmVhZHkgY3JlYXRlZA0KKwkgKiBhbmQgYXNzaWduZWQg
dG8gb25lIENQVSwgc28gY2hlY2sgYWdhaW5zdCAjIENQVXMgLSAxLg0KKwkgKi8NCisJbnVtX3Nj
ID0gbWluKChudW1fY3B1cyAtIDEpLCBtYXhfY2hucyk7DQorCWlmICghbnVtX3NjKQ0KKwkJcmV0
dXJuOw0KKw0KIAlzdG9yX2RldmljZSA9IGdldF9vdXRfc3Rvcl9kZXZpY2UoZGV2aWNlKTsNCiAJ
aWYgKCFzdG9yX2RldmljZSkNCiAJCXJldHVybjsNCi0tIA0KMS44LjMuMQ0KDQo=
