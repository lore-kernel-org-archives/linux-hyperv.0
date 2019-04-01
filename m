Return-Path: <SRS0=/wEv=SD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C54C43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6DB2070B
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 21:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pgc4BlOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfDAVmK (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:42:10 -0400
Received: from mail-eopbgr680116.outbound.protection.outlook.com ([40.107.68.116]:30320
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfDAVmJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Apr 2019 17:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=diFycp73/ZGoMwjdzH4cfUBAZnFR2eu7IdeQx2+X/wim9GoMC7zyF4qBv7kxAu1fUgkZa52UUk9ci3sTVqYlGxQhFzqRJBPIi7uFFV66s3wNC3WtgdMC15LIq/URVl65IQwwhyn+5HTXUc0GMj3uxApCat5q4VPqSs03j1d0N3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrYS48m0KXxj+LmB4P+7nY/g7cOUF/peQxHLZcrQdv4=;
 b=DuxvjUGZR/SoK/nKSWitOlKqR1FlCk9jesOpFAD0UYwn2YGbiqg/EaDwBG6I8aVfAqUbNQZE/7v/GjdwkCxObrqUFIq/TnQuaUKQUE1yZMLSFq5a35DLEsrIEicVGjZleF1fBfrfDuiMtE9CklFyaUDnB0Ei3fJx4lyut9pyU0o=
ARC-Authentication-Results: i=1; test.office365.com 1;dmarc=none action=none
 header.from=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrYS48m0KXxj+LmB4P+7nY/g7cOUF/peQxHLZcrQdv4=;
 b=Pgc4BlOEgpBI9NzFI4w1N2ggukqQ7V2ofwoTmooasWqW7oqDDig12EJU/DbFqyrDbJ/GXDGVeitLrrWELEUHGJSPJf/dWo+noHk2tCSeD5fR8ffinRWj/vlm/R819yu7zKc3vAMmZI0SDWtiZfyfe6udI3+Cg1cOWsxnr8amlyA=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0851.namprd21.prod.outlook.com (10.173.205.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.2; Mon, 1 Apr 2019 21:42:07 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c%14]) with mapi id 15.20.1771.002; Mon, 1 Apr 2019
 21:42:07 +0000
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
Subject: [PATCH 1/1] scsi: storvsc: Reduce default ring buffer size to 128
 Kbytes
Thread-Topic: [PATCH 1/1] scsi: storvsc: Reduce default ring buffer size to
 128 Kbytes
Thread-Index: AQHU6NPAwqy3b0fRgku3jt+SxDRaiw==
Date:   Mon, 1 Apr 2019 21:42:06 +0000
Message-ID: <1554154871-10305-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:300:ed::11) To BN6PR21MB0466.namprd21.prod.outlook.com
 (2603:10b6:404:b2::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.159.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86fa72c8-3515-40b5-6b53-08d6b6eae290
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR21MB0851;
x-ms-traffictypediagnostic: BN6PR21MB0851:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-prvs: <BN6PR21MB0851B212F13C7FDAC6F2243CD7550@BN6PR21MB0851.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(81166006)(81156014)(8676002)(6116002)(3846002)(10090500001)(14454004)(2906002)(1511001)(478600001)(486006)(2616005)(66066001)(52116002)(36756003)(26005)(386003)(6506007)(68736007)(102836004)(476003)(6486002)(106356001)(86612001)(71200400001)(71190400001)(186003)(6512007)(107886003)(256004)(4326008)(97736004)(25786009)(14444005)(2201001)(4744005)(5660300002)(6436002)(10290500003)(8936002)(2501003)(50226002)(110136005)(22452003)(105586002)(53936002)(7736002)(305945005)(99286004)(86362001)(4720700003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0851;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8jbeh5j00DFaZg8s4QcRv57Lz9WbdZzeHfbl68mtWi+wTRDoecv+EuF2gokqA3vwJnOqP03JjpH4C3mKoVBGP0U+7AnTxm4tWH/gOueCb8qyCgXE0cYeaFd6vDETfcazFzp6pwzCHpEd4kOpRdtqUwCmvpAuYUSyI1bw11fppA11d1Oi6+EOgWzB5X5Z6Np0z+nyISpblb0gwUZBCW5ZpEKBdb5G0vVqP7lJNyKOXWX+u8OVthU8mS2XtsNAiU/5QyyS5JwJxNRBX/5NeXlUGNGSpF0MX2wcb+JGS0jneFujFFQ16kqdgsgGqAsM0OV7yiDl9KxUbUBYUARB6m0r01Re4WdK2SVTIN21WvWCrJcBUT1T5991lnVaTga5hwU8EhGUtzy0YeRiNWNJHlU8Eob6SfZGB0gCwkMi9DsHvzs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa72c8-3515-40b5-6b53-08d6b6eae290
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 21:42:07.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0851
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

UmVkdWNlIHRoZSBkZWZhdWx0IFZNYnVzIGNoYW5uZWwgcmluZyBidWZmZXIgc2l6ZSBmb3Igc3Rv
cnZzYw0KU0NTSSBkZXZpY2VzIGZyb20gMSBNYnl0ZSB0byAxMjggS2J5dGVzLiBNZWFzdXJlbWVu
dHMgc2hvdw0KdGhhdCByaW5nIGJ1ZmZlciBzaXplcyBhYm92ZSAxMjggS2J5dGVzIGRvIG5vdCBp
bmNyZWFzZQ0KcGVyZm9ybWFuY2UgZXZlbiBhdCB2ZXJ5IGhpZ2ggSU9QUyByYXRlcywgc28gZG9u
J3Qgd2FzdGUNCnRoZSBtZW1vcnkuIEFsc28gcmVtb3ZlIHRoZSBkZXBlbmRlbmNlIG9uIFBBR0Vf
U0laRSwgc2luY2UNCnRoZSByaW5nIGJ1ZmZlciBzaXplIHNob3VsZCBub3QgY2hhbmdlIG9uIGFy
Y2hpdGVjdHVyZXMNCndoZXJlIFBBR0VfU0laRSBpcyBub3QgNCBLYnl0ZXMuDQoNClNpZ25lZC1v
ZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJp
dmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc3RvcnZz
Y19kcnYuYyBiL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jDQppbmRleCBmYmFhMTFhLi5mODU1
MTdkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCisrKyBiL2RyaXZl
cnMvc2NzaS9zdG9ydnNjX2Rydi5jDQpAQCAtMzg1LDcgKzM4NSw3IEBAIGVudW0gc3RvcnZzY19y
ZXF1ZXN0X3R5cGUgew0KICAqIFRoaXMgaXMgdGhlIGVuZCBvZiBQcm90b2NvbCBzcGVjaWZpYyBk
ZWZpbmVzLg0KICAqLw0KIA0KLXN0YXRpYyBpbnQgc3RvcnZzY19yaW5nYnVmZmVyX3NpemUgPSAo
MjU2ICogUEFHRV9TSVpFKTsNCitzdGF0aWMgaW50IHN0b3J2c2NfcmluZ2J1ZmZlcl9zaXplID0g
KDEyOCAqIDEwMjQpOw0KIHN0YXRpYyB1MzIgbWF4X291dHN0YW5kaW5nX3JlcV9wZXJfY2hhbm5l
bDsNCiANCiBzdGF0aWMgaW50IHN0b3J2c2NfdmNwdXNfcGVyX3N1Yl9jaGFubmVsID0gNDsNCi0t
IA0KMS44LjMuMQ0KDQo=
