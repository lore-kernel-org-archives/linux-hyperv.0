Return-Path: <SRS0=wL2l=RU=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03623C43381
	for <linux-hyperv@archiver.kernel.org>; Sun, 17 Mar 2019 19:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9628F20872
	for <linux-hyperv@archiver.kernel.org>; Sun, 17 Mar 2019 19:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z2DBA8up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCQTGL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:06:11 -0400
Received: from mail-eopbgr760135.outbound.protection.outlook.com ([40.107.76.135]:37270
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfCQTGK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 17 Mar 2019 15:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmvI/2Y1lH+OoJgMJZbaKbRlPwWuVvm2R+OLOwj15j0=;
 b=Z2DBA8up2Vmwvfqr6vfkHRhN5pTpAQ/mc3NabRUkodXkKw2mGbNizsKeJKQiFsRcQYPOKTIoY8RKEkOCtlBnSTYkV4tIR5kU1sLjAbzK6OXgcrQLmY98oOFt4bySO5uz+auoHKERYmf4Hxv1YjETRxde29kLBJr3gwUOKioDKjg=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0788.namprd21.prod.outlook.com (10.175.132.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Sun, 17 Mar 2019 19:06:03 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c%13]) with mapi id 15.20.1730.008; Sun, 17 Mar 2019
 19:06:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: [PATCH v2 0/2] Drivers: hv: Move Hyper-V clock/timer code to separate
 clocksource driver
Thread-Topic: [PATCH v2 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Thread-Index: AQHU3PR3nvkI5BPvckuJQbTeF03j1Q==
Date:   Sun, 17 Mar 2019 19:06:02 +0000
Message-ID: <1552849512-10063-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:104:2::18) To BN6PR21MB0466.namprd21.prod.outlook.com
 (2603:10b6:404:b2::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [167.220.2.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecd03ed9-84dd-4456-730b-08d6ab0b9958
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0788;
x-ms-traffictypediagnostic: BN6PR21MB0788:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB07887D90BB9DA43DF7071310D7460@BN6PR21MB0788.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 09796A1B83
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(99286004)(486006)(8676002)(5660300002)(81166006)(81156014)(102836004)(26005)(52116002)(6506007)(8936002)(97736004)(386003)(6486002)(50226002)(6346003)(305945005)(86612001)(14454004)(7736002)(6636002)(7416002)(106356001)(186003)(36756003)(71190400001)(22452003)(10290500003)(54906003)(105586002)(6436002)(2906002)(478600001)(66066001)(71200400001)(110136005)(316002)(2501003)(4326008)(68736007)(6512007)(86362001)(1511001)(10090500001)(6116002)(2616005)(4720700003)(25786009)(256004)(476003)(53936002)(3846002)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0788;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1y/T8vValLeECL+plUaMOaIn8fGtY89DMqSRFaRZZMbryzuOh6xwMLPl9JE4ooIdKqJTgFpb/ejMAsP6Kd0fKP7wnkJgP5Mr700zHebVtBdv4u3e5LdKSwi8BPtthp/BjfdW+gnMeCv8hkjF7TFMqzkFLZIE981Eop00aKllYYN5/Mv49hYNCCcp7q1kVnnsb21dS7WF0kc0S8n1LAM3+7EfK18YQ856JmdDDPKg2FWxBFV8KOy0BHjC1DlBvftayNhlYe7VjOCus4nI2yzpL9kbtkPQne4VOsweL3Sqpa7DyIqoHdQgWQ2FZzYVMfiS3jL3gm2zUSloup1f0Fq2mQTJ4erEp9INY2Azf3P3wyAVtKCzM6o7w6275p9k4jamDrNUcTQqkRVqLRsyBTevFs/ZZGRCf3/lMrN4fHrGimc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd03ed9-84dd-4456-730b-08d6ab0b9958
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2019 19:06:02.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0788
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgbW92ZXMgSHlwZXItViBjbG9jay90aW1lciBjb2RlIHRvIGEgc2Vw
YXJhdGUgSHlwZXItVg0KY2xvY2tzb3VyY2UgZHJpdmVyLiBQcmV2aW91c2x5LCBIeXBlci1WIGNs
b2NrL3RpbWVyIGNvZGUgYW5kIGRhdGENCnN0cnVjdHVyZXMgd2VyZSBtaXhlZCBpbiB3aXRoIG90
aGVyIEh5cGVyLVYgY29kZSBpbiB0aGUgSVNBIGluZGVwZW5kZW50DQpkcml2ZXJzL2h2IGNvZGUg
YXMgd2VsbCBhcyBpbiBhcmNoIGRlcGVuZGVudCBjb2RlLiBUaGUgbmV3IEh5cGVyLVYNCmNsb2Nr
c291cmNlIGRyaXZlciBpcyBJU0EgaW5kZXBlbmRlbnQsIHdpdGggYSBqdXN0IGZldyBkZXBlbmRl
bmNpZXMgb24NCmFyY2ggc3BlY2lmaWMgZnVuY3Rpb25zLiBUaGUgcGF0Y2ggc2VyaWVzIGRvZXMg
bm90IGNoYW5nZSBhbnkgYmVoYXZpb3INCm9yIGZ1bmN0aW9uYWxpdHkgLS0gaXQgb25seSByZW9y
Z2FuaXplcyB0aGUgZXhpc3RpbmcgY29kZSBhbmQgZml4ZXMgdXANCnRoZSBsaW5rYWdlcy4gQSBm
ZXcgcGxhY2VzIG91dHNpZGUgb2YgSHlwZXItViBjb2RlIGFyZSBmaXhlZCB1cCB0byB1c2UNCnRo
ZSBuZXcgI2luY2x1ZGUgZmlsZSBzdHJ1Y3R1cmUuDQoNClRoaXMgcmVzdHJ1Y3R1cmluZyBpcyBp
biByZXNwb25zZSB0byBNYXJjIFp5bmdpZXIncyByZXZpZXcgY29tbWVudHMNCm9uIHN1cHBvcnRp
bmcgSHlwZXItViBydW5uaW5nIG9uIEFSTTY0LCBhbmQgaXMgYSBnb29kIGlkZWEgaW4gZ2VuZXJh
bC4NCkl0IGluY3JlYXNlcyB0aGUgYW1vdW50IG9mIGNvZGUgc2hhcmVkIGJldHdlZW4gdGhlIHg4
NiBhbmQgQVJNNjQNCmFyY2hpdGVjdHVyZXMsIGFuZCByZWR1Y2VzIHRoZSBzaXplIG9mIHRoZSBu
ZXcgY29kZSBmb3Igc3VwcG9ydGluZw0KSHlwZXItViBvbiBBUk02NC4gQSBuZXcgdmVyc2lvbiBv
ZiB0aGUgSHlwZXItViBvbiBBUk02NCBwYXRjaGVzIHdpbGwNCmZvbGxvdyBvbmNlIHRoaXMgY2xv
Y2tzb3VyY2UgcmVzdHJ1Y3R1cmluZyBpcyBhY2NlcHRlZC4NCg0KVGhlIGNvZGUgaXMgY3VycmVu
dGx5IGRpZmYnZWQgYWdhaW5zdCBMaW51eCA1LjAuICBJJ2xsIHJlYmFzZQ0KdG8gbGludXgtbmV4
dCBvbmNlIDUuMS1yYzEgaXMgYXZhaWxhYmxlLg0KDQpDaGFuZ2VzIGluIHYyOg0KKiBSZXZpc2Vk
IGNvbW1pdCBzaG9ydCBkZXNjcmlwdGlvbnMgc28gdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4NCnRo
ZSB0d28gcGF0Y2hlcyBpcyBjbGVhcmVyIFtHcmVnS0hdDQoqIFJlbmFtZWQgbmV3IGNsb2Nrc291
cmNlIGRyaXZlciBmaWxlcyBhbmQgZnVuY3Rpb25zIHRvIHVzZQ0KZXhpc3RpbmcgInRpbWVyIiBh
bmQgInN0aW1lciIgbmFtZXMgaW5zdGVhZCBvZiBpbnRyb2R1Y2luZw0KInN5bnRpbWVyIi4gW1Zp
dGFseSBLdXpuZXRzb3ZdDQoqIEludHJvZHVjZWQgQ09ORklHX0hZUEVSX1RJTUVSIHRvIGZpeCBi
dWlsZCBwcm9ibGVtIHdoZW4NCkNPTkZJR19IWVBFUlY9bSBbVml0YWx5IEt1em5ldHNvdl0NCiog
QWRkZWQgIlN1Z2dlc3RlZC1ieTogTWFyYyBaeW5naWVyIg0KDQpNaWNoYWVsIEtlbGxleSAoMik6
DQogIERyaXZlcnM6IGh2OiBDcmVhdGUgSHlwZXItViBjbG9ja3NvdXJjZSBkcml2ZXIgZnJvbSBl
eGlzdGluZw0KICAgIGNsb2NrZXZlbnRzIGNvZGUNCiAgRHJpdmVyczogaHY6IE1vdmUgSHlwZXIt
ViBjbG9ja3NvdXJjZSBjb2RlIHRvIG5ldyBjbG9ja3NvdXJjZSBkcml2ZXINCg0KIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQogYXJjaC94ODYvZW50cnkvdmRz
by92Y2xvY2tfZ2V0dGltZS5jIHwgICAxICsNCiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZtYS5jICAg
ICAgICAgICAgfCAgIDIgKy0NCiBhcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jICAgICAgICAgICAg
fCAgOTEgKy0tLS0tLS0tLQ0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmggICB8
ICAgNiArDQogYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCAgICAgIHwgIDgwICsrLS0t
LS0tLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYyAgICAgICB8ICAgMiArDQogYXJj
aC94ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL2Nsb2Nr
c291cmNlL01ha2VmaWxlICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvaHlw
ZXJ2X3RpbWVyLmMgICB8IDMyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
IGRyaXZlcnMvaHYvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgMyArDQogZHJpdmVycy9o
di9odi5jICAgICAgICAgICAgICAgICAgICAgIHwgMTU0IC0tLS0tLS0tLS0tLS0tLS0NCiBkcml2
ZXJzL2h2L2h5cGVydl92bWJ1cy5oICAgICAgICAgICAgfCAgIDMgLQ0KIGRyaXZlcnMvaHYvdm1i
dXNfZHJ2LmMgICAgICAgICAgICAgICB8ICAzOSArKystLQ0KIGluY2x1ZGUvY2xvY2tzb3VyY2Uv
aHlwZXJ2X3RpbWVyLmggICB8IDEwNCArKysrKysrKysrKw0KIDE1IGZpbGVzIGNoYW5nZWQsIDQ4
NSBpbnNlcnRpb25zKCspLCAzMzIgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaA0KDQotLSANCjEuOC4zLjENCg0K
