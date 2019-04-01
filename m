Return-Path: <SRS0=/wEv=SD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88595C43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 21:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438B7206B6
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 21:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HyohiPBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfDAVj0 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:39:26 -0400
Received: from mail-eopbgr770105.outbound.protection.outlook.com ([40.107.77.105]:47360
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfDAVjZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Apr 2019 17:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=gG0XmTVmOJUtCMW9oaft8jbP0aOxPlqqpRN1HyYGQ1LC/Qbi5xFN8y9/Ot9eaqSfgOZUqQxTf7LJNoF74QfpOFbxGyJEClzknMnujucIzc6dsc8s3l5zTOLDyASB9FKBtxke21954BpNjLIrXYO/jtD1GpuJAecWugEEa3WbFXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZZ6IMXOXy8hffhbipOxOHn5l7IVRiZOcV10ROTDsME=;
 b=BWKgpr8oDUH4J82WdDnqYd+NKBeIL4ZEaaHamQrUn+3yg8tAeGAzSujFb3jNqSKWXAaNAXyG5tMK3fSdmjGuKYbhhiszN93q10KZrGTqoarIGYchps4/qHKTfXvr2Dm2pFnPER7xDYRUn3G7kAkRh+e22gUFCQZJ90+dSR1lTb0=
ARC-Authentication-Results: =?utf-8?B?aT0xOyB0ZXN0Lm9mZmljZTM2NS5jb20gMTsNCgkJZG1hcmM9bm9uZSBhY3Rp?=
 =?utf-8?B?b249bm9uZSBoZWFkZXIuZnJvbT1taWNyb3NvZnQuY29tOw0KCQlhcmM9bm9u?=
 =?utf-8?Q?e?=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZZ6IMXOXy8hffhbipOxOHn5l7IVRiZOcV10ROTDsME=;
 b=HyohiPBstnLshhvp1feXKVEcnoxvZS+noOooCc4SWPUM5ZWWzIKTUpK7zugprDGh3cb7lO8ASt+nPu3lvQLk8txA6uL3nFJ30UeoNppJ4Cfim1TcZOGAu22nDyerLjW+8ciqPG9qSmsCnjeASOmMPVOOM9BDtf1tIZpkD79TRik=
Received: from DM5PR21MB0635.namprd21.prod.outlook.com (10.175.111.142) by
 DM5PR21MB0748.namprd21.prod.outlook.com (10.173.172.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.7; Mon, 1 Apr 2019 21:38:43 +0000
Received: from DM5PR21MB0635.namprd21.prod.outlook.com
 ([fe80::505c:e067:e883:882]) by DM5PR21MB0635.namprd21.prod.outlook.com
 ([fe80::505c:e067:e883:882%12]) with mapi id 15.20.1771.007; Mon, 1 Apr 2019
 21:38:43 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "emilne@redhat.com" <emilne@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] scsi: storvsc: Fix calculation of sub-channel
 count
Thread-Topic: [PATCH v2 1/1] scsi: storvsc: Fix calculation of sub-channel
 count
Thread-Index: AQHU6KV6UQald53dlUasls9Rw8AeY6Yn1IZg
Date:   Mon, 1 Apr 2019 21:38:43 +0000
Message-ID: <DM5PR21MB06352133A72ED856E43ED396CE550@DM5PR21MB0635.namprd21.prod.outlook.com>
References: <1554134985-8671-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1554134985-8671-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:f:edde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcc62e97-0e5f-46e7-5cc0-08d6b6ea69c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0748;
x-ms-traffictypediagnostic: DM5PR21MB0748:
x-microsoft-antispam-prvs: <DM5PR21MB07489C0442765435F581DE8CCE550@DM5PR21MB0748.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(136003)(376002)(13464003)(189003)(199004)(10290500003)(10090500001)(97736004)(99286004)(316002)(86362001)(2906002)(55016002)(6506007)(2201001)(2501003)(102836004)(8936002)(8990500004)(6346003)(305945005)(7696005)(74316002)(86612001)(52536014)(76176011)(81166006)(81156014)(8676002)(186003)(6246003)(486006)(11346002)(33656002)(9686003)(14444005)(1511001)(7736002)(46003)(22452003)(53936002)(476003)(478600001)(110136005)(256004)(446003)(5660300002)(68736007)(105586002)(229853002)(71200400001)(14454004)(6436002)(25786009)(71190400001)(106356001)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0748;H:DM5PR21MB0635.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c7uukdJgG7PbZAWdi4cDISjIm/LCFR091sUb/vRN/mJ+8+YT0nBvS29UUTAo3MT3hFWuygWK86adRT+XYjMXoXID4tPEArPmfPlFlAKh//fDSG+Y90odq6ejl6hRhJRDwFKLd8u/nHabmIexxkQdt7kPhugFcZc0WkRRrUMAai9B1KCgG0oJjDGtiulU/L1WEVIuGbY2dMObrYTEQjECw457s0h3K5qo6MwtCO02YZKdMO2NUIrNMEedFUstavutgkplvTnqjFBG/V0aB/OC73Yp4gbBKT+DeNJdf8zTOnRuQ8O/FUOKmEXKykhZd6uSCsiMuLM4xMoKbukc/VnDwJ3LNhwmRIqtKk5XCXny/2G8WCCblNda9PlJxnqCuaOnTmPgbkInDOsg1KiQw8r6Bpf/aPHSK3U3dAURWwkHipA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc62e97-0e5f-46e7-5cc0-08d6b6ea69c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 21:38:43.1203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0748
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Pj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PkZyb206IE1pY2hhZWwgS2VsbGV5IDxt
aWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPj4+U2VudDogTW9uZGF5LCBBcHJpbCAxLCAyMDE5IDk6
MTEgQU0NCj4+PlRvOiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IG1hcnRpbi5w
ZXRlcnNlbkBvcmFjbGUuY29tOyBMb25nDQo+Pj5MaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+OyBK
YW1lcy5Cb3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tOw0KPj4+ZW1pbG5lQHJlZGhhdC5j
b207IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPj4+a2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmcNCj4+PkNjOiBNaWNoYWVsIEtl
bGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4+PlN1YmplY3Q6IFtQQVRDSCB2MiAxLzFd
IHNjc2k6IHN0b3J2c2M6IEZpeCBjYWxjdWxhdGlvbiBvZiBzdWItY2hhbm5lbCBjb3VudA0KPj4+
DQo+Pj5XaGVuIHRoZSBudW1iZXIgb2Ygc3ViLWNoYW5uZWxzIG9mZmVyZWQgYnkgSHlwZXItViBp
cyA+PSB0aGUgbnVtYmVyIG9mDQo+Pj5DUFVzIGluIHRoZSBWTSwgY2FsY3VsYXRlIHRoZSBjb3Jy
ZWN0IG51bWJlciBvZiBzdWItY2hhbm5lbHMuDQo+Pj5UaGUgY3VycmVudCBjb2RlIHByb2R1Y2Vz
IG9uZSB0b28gbWFueS4NCj4+Pg0KPj4+VGhpcyBzY2VuYXJpbyBhcmlzZXMgb25seSB3aGVuIHRo
ZSBudW1iZXIgb2YgQ1BVcyBpcyBhcnRpZmljaWFsbHkgcmVzdHJpY3RlZA0KPj4+KGZvciBleGFt
cGxlLCB3aXRoIG1heGNwdXM9PG4+IG9uIHRoZSBrZXJuZWwgYm9vdCBsaW5lKSwgYmVjYXVzZSBI
eXBlci1WDQo+Pj5ub3JtYWxseSBvZmZlcnMgYSBzdWItY2hhbm5lbCBjb3VudCA8IG51bWJlciBv
ZiBDUFVzLg0KPj4+V2hpbGUgdGhlIGN1cnJlbnQgY29kZSBkb2Vzbid0IGJyZWFrLCB0aGUgZXh0
cmEgc3ViLWNoYW5uZWwgaXMgdW5iYWxhbmNlZA0KPj4+YWNyb3NzIHRoZSBDUFVzIChmb3IgZXhh
bXBsZSwgYSB0b3RhbCBvZiA1IGNoYW5uZWxzIG9uIGEgVk0gd2l0aCA0IENQVXMpLg0KPj4+DQo+
Pj5TaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4N
Cj4+PlJldmlld2VkLWJ5OiBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0c0ByZWRoYXQuY29tPg0K
Pj4+LS0tDQo+Pj5DaGFuZ2VzIGluIHYyOg0KPj4+KiBQdXQgbnVtX29ubGluZV9jcHVzKCkgaW5s
aW5lIGFuZCBlbGltaW5hdGUgbnVtX2NwdXMgbG9jYWwNCj4+PiAgdmFyaWFibGUgW1ZpdGFseSBL
dXpuZXRzb3ZdDQo+Pj4NCg0KUmV2aWV3ZWQtYnk6IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQu
Y29tPg0KDQo+Pj4tLS0NCj4+PiBkcml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYyB8IDEzICsrKysr
KysrKysrLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4+Pg0KPj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jIGIv
ZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgaW5kZXgNCj4+Pjg0MzgwYmEuLmUxODY3NDMgMTAw
NjQ0DQo+Pj4tLS0gYS9kcml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYw0KPj4+KysrIGIvZHJpdmVy
cy9zY3NpL3N0b3J2c2NfZHJ2LmMNCj4+PkBAIC02NjgsMTMgKzY2OCwyMiBAQCBzdGF0aWMgdm9p
ZCAgaGFuZGxlX211bHRpY2hhbm5lbF9zdG9yYWdlKHN0cnVjdA0KPj4+aHZfZGV2aWNlICpkZXZp
Y2UsIGludCBtYXhfY2hucykgIHsNCj4+PiAJc3RydWN0IGRldmljZSAqZGV2ID0gJmRldmljZS0+
ZGV2aWNlOw0KPj4+IAlzdHJ1Y3Qgc3RvcnZzY19kZXZpY2UgKnN0b3JfZGV2aWNlOw0KPj4+LQlp
bnQgbnVtX2NwdXMgPSBudW1fb25saW5lX2NwdXMoKTsNCj4+PiAJaW50IG51bV9zYzsNCj4+PiAJ
c3RydWN0IHN0b3J2c2NfY21kX3JlcXVlc3QgKnJlcXVlc3Q7DQo+Pj4gCXN0cnVjdCB2c3Rvcl9w
YWNrZXQgKnZzdG9yX3BhY2tldDsNCj4+PiAJaW50IHJldCwgdDsNCj4+Pg0KPj4+LQludW1fc2Mg
PSAoKG1heF9jaG5zID4gbnVtX2NwdXMpID8gbnVtX2NwdXMgOiBtYXhfY2hucyk7DQo+Pj4rCS8q
DQo+Pj4rCSAqIElmIHRoZSBudW1iZXIgb2YgQ1BVcyBpcyBhcnRpZmljaWFsbHkgcmVzdHJpY3Rl
ZCwgc3VjaCBhcw0KPj4+KwkgKiB3aXRoIG1heGNwdXM9MSBvbiB0aGUga2VybmVsIGJvb3QgbGlu
ZSwgSHlwZXItViBjb3VsZCBvZmZlcg0KPj4+KwkgKiBzdWItY2hhbm5lbHMgPj0gdGhlIG51bWJl
ciBvZiBDUFVzLiBUaGVzZSBzdWItY2hhbm5lbHMNCj4+PisJICogc2hvdWxkIG5vdCBiZSBjcmVh
dGVkLiBUaGUgcHJpbWFyeSBjaGFubmVsIGlzIGFscmVhZHkgY3JlYXRlZA0KPj4+KwkgKiBhbmQg
YXNzaWduZWQgdG8gb25lIENQVSwgc28gY2hlY2sgYWdhaW5zdCAjIENQVXMgLSAxLg0KPj4+Kwkg
Ki8NCj4+PisJbnVtX3NjID0gbWluKChpbnQpKG51bV9vbmxpbmVfY3B1cygpIC0gMSksIG1heF9j
aG5zKTsNCj4+PisJaWYgKCFudW1fc2MpDQo+Pj4rCQlyZXR1cm47DQo+Pj4rDQo+Pj4gCXN0b3Jf
ZGV2aWNlID0gZ2V0X291dF9zdG9yX2RldmljZShkZXZpY2UpOw0KPj4+IAlpZiAoIXN0b3JfZGV2
aWNlKQ0KPj4+IAkJcmV0dXJuOw0KPj4+LS0NCj4+PjEuOC4zLjENCg0K
