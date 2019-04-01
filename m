Return-Path: <SRS0=/wEv=SD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28153C43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1874208E4
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O1SKSWhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfDAQK4 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:10:56 -0400
Received: from mail-eopbgr740127.outbound.protection.outlook.com ([40.107.74.127]:40704
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbfDAQK4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Apr 2019 12:10:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=rHygVZ/VZeG75smzU6sCj3xysthcotefzEXoEk3Gj2Kh9YPIWm3+Qjg9BUKiakBYCk6/RTn9jicO3Or1fvKcMf03w7RbxWgfXxt/9rc+JDHjgvrkBlvbUcULtkRhluqY36fbVpGkAoqKzdEoC1kzK4N3uqd64SYRlf1CTLDqp7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4F1lwCpacHq/ZrOXLD7u4JskYkfYFZZrewB0SzPDHs=;
 b=fBzBqXOoho0xRJeDoUs7xlT+HKHEf9uGVMMVH/TDS8AbgiWaiMrVOYMONaSPXhHxVmCShV+UupBDG8RI2PZTdh863EIQ9I+Oj/5WoDLTkmri6cSHkwUWY7DeFiJnf45gAeu5/Cl22XfSM8R/P8L//yqYmQvIUg6navEcO224o0A=
ARC-Authentication-Results: i=1; test.office365.com 1;dmarc=none action=none
 header.from=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4F1lwCpacHq/ZrOXLD7u4JskYkfYFZZrewB0SzPDHs=;
 b=O1SKSWhkXjFW+KiUnUOAnbNY7ss+lMmdc3fVAQRs+KyGa1KDJtbBLRY2zhViFf53rXIkSgDBiCdg4utuKBgBciPR5y8zqPWY1eRR5NTdC1vfDNhUCSbea2wOL3K26FnSACIKokPsybYrbpjuhMRBt9S2rwpcHyBUD547UtGJDak=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0849.namprd21.prod.outlook.com (10.173.205.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.2; Mon, 1 Apr 2019 16:10:52 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c%14]) with mapi id 15.20.1771.002; Mon, 1 Apr 2019
 16:10:52 +0000
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
Subject: [PATCH v2 1/1] scsi: storvsc: Fix calculation of sub-channel count
Thread-Topic: [PATCH v2 1/1] scsi: storvsc: Fix calculation of sub-channel
 count
Thread-Index: AQHU6KV6UQald53dlUasls9Rw8AeYw==
Date:   Mon, 1 Apr 2019 16:10:52 +0000
Message-ID: <1554134985-8671-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:300:ef::29) To BN6PR21MB0466.namprd21.prod.outlook.com
 (2603:10b6:404:b2::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.147.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bdbca7d-087a-4c72-bd7e-08d6b6bc9cc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR21MB0849;
x-ms-traffictypediagnostic: BN6PR21MB0849:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-prvs: <BN6PR21MB0849DF5888A47C19E14C620BD7550@BN6PR21MB0849.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(14444005)(81166006)(106356001)(476003)(478600001)(305945005)(6506007)(486006)(6486002)(2616005)(256004)(68736007)(99286004)(50226002)(52116002)(66066001)(26005)(1511001)(102836004)(386003)(7736002)(3846002)(6116002)(2906002)(86362001)(10290500003)(6512007)(2201001)(4720700003)(186003)(71190400001)(71200400001)(36756003)(6436002)(2501003)(10090500001)(8676002)(4326008)(8936002)(110136005)(316002)(5660300002)(53936002)(81156014)(97736004)(105586002)(107886003)(86612001)(25786009)(22452003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0849;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fh83anACCCre7mn45mPUC3a2jyy2l7gfUU+0S0bsCEkZt3zlhRnyLj3JnpFYKK1LzWzQnkbN5AnTn+qOgxy5ffJvR1EH5aOFdfgFuxH02P/Bmn47lV9LXsShARJB0nWy2KHmsU2f1yy63uRgeXSBoC9Nin6XuRLeGAcZwe7PKzt9m16cxW6KW1iSnYhody59IbTcCuqf9p6Geh/9kEg2Is/cKmOjJWBHQrRfg8Vx0WYz9P+K6VjqLeIuEFDGlzEywmP4yf2mYq6ycfyubSLZxQjuqWhBhPP2lC5lfDubyqc7PpzcvmhhpT+mkMW8aBQIR3JwkYdzAL0Wjiv0HUGbGhUqGFv8tNeP06sdjBf1DGQcbXJ0YpQK5Vy9vCmev708tpEX4pmH3o+937jEiCK5zSiZnhTHIPpSYZois4cHWKc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdbca7d-087a-4c72-bd7e-08d6b6bc9cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 16:10:52.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0849
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
aWtlbGxleUBtaWNyb3NvZnQuY29tPg0KUmV2aWV3ZWQtYnk6IFZpdGFseSBLdXpuZXRzb3YgPHZr
dXpuZXRzQHJlZGhhdC5jb20+DQotLS0NCkNoYW5nZXMgaW4gdjI6DQoqIFB1dCBudW1fb25saW5l
X2NwdXMoKSBpbmxpbmUgYW5kIGVsaW1pbmF0ZSBudW1fY3B1cyBsb2NhbA0KICB2YXJpYWJsZSBb
Vml0YWx5IEt1em5ldHNvdl0NCg0KLS0tDQogZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgfCAx
MyArKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYyBiL2Ry
aXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jDQppbmRleCA4NDM4MGJhLi5lMTg2NzQzIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCisrKyBiL2RyaXZlcnMvc2NzaS9zdG9y
dnNjX2Rydi5jDQpAQCAtNjY4LDEzICs2NjgsMjIgQEAgc3RhdGljIHZvaWQgIGhhbmRsZV9tdWx0
aWNoYW5uZWxfc3RvcmFnZShzdHJ1Y3QgaHZfZGV2aWNlICpkZXZpY2UsIGludCBtYXhfY2hucykN
CiB7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZkZXZpY2UtPmRldmljZTsNCiAJc3RydWN0IHN0
b3J2c2NfZGV2aWNlICpzdG9yX2RldmljZTsNCi0JaW50IG51bV9jcHVzID0gbnVtX29ubGluZV9j
cHVzKCk7DQogCWludCBudW1fc2M7DQogCXN0cnVjdCBzdG9ydnNjX2NtZF9yZXF1ZXN0ICpyZXF1
ZXN0Ow0KIAlzdHJ1Y3QgdnN0b3JfcGFja2V0ICp2c3Rvcl9wYWNrZXQ7DQogCWludCByZXQsIHQ7
DQogDQotCW51bV9zYyA9ICgobWF4X2NobnMgPiBudW1fY3B1cykgPyBudW1fY3B1cyA6IG1heF9j
aG5zKTsNCisJLyoNCisJICogSWYgdGhlIG51bWJlciBvZiBDUFVzIGlzIGFydGlmaWNpYWxseSBy
ZXN0cmljdGVkLCBzdWNoIGFzDQorCSAqIHdpdGggbWF4Y3B1cz0xIG9uIHRoZSBrZXJuZWwgYm9v
dCBsaW5lLCBIeXBlci1WIGNvdWxkIG9mZmVyDQorCSAqIHN1Yi1jaGFubmVscyA+PSB0aGUgbnVt
YmVyIG9mIENQVXMuIFRoZXNlIHN1Yi1jaGFubmVscw0KKwkgKiBzaG91bGQgbm90IGJlIGNyZWF0
ZWQuIFRoZSBwcmltYXJ5IGNoYW5uZWwgaXMgYWxyZWFkeSBjcmVhdGVkDQorCSAqIGFuZCBhc3Np
Z25lZCB0byBvbmUgQ1BVLCBzbyBjaGVjayBhZ2FpbnN0ICMgQ1BVcyAtIDEuDQorCSAqLw0KKwlu
dW1fc2MgPSBtaW4oKGludCkobnVtX29ubGluZV9jcHVzKCkgLSAxKSwgbWF4X2NobnMpOw0KKwlp
ZiAoIW51bV9zYykNCisJCXJldHVybjsNCisNCiAJc3Rvcl9kZXZpY2UgPSBnZXRfb3V0X3N0b3Jf
ZGV2aWNlKGRldmljZSk7DQogCWlmICghc3Rvcl9kZXZpY2UpDQogCQlyZXR1cm47DQotLSANCjEu
OC4zLjENCg0K
