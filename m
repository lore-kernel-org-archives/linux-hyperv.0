Return-Path: <SRS0=ldGZ=SG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6748C4360F
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 02:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850D320820
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 02:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fGVtL1K5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDDCnI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:43:08 -0400
Received: from mail-eopbgr1300092.outbound.protection.outlook.com ([40.107.130.92]:4534
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfDDCnH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Apr 2019 22:43:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=CvWY8ruQT+if1OKMcHLwAKlJaTDo9k0SDZEfPrXfQ91Wr8/KAZiNZzffunk3g15cGtrgI9mFCEe5VH0cVgAH1qv08sOfw7kR1JgyEi6Ko5lFJoJgN9BzICn+6Zfpl/WvQWrMlbfMLgASbYEEMDHzG6UQoyHdXYXR0tSbNJ7P2tU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd1e/wRYWL9g2Lnzv00Qo1HiapD1gNjkZwE46YgNyUQ=;
 b=bxNHWELDfMXTRQHvl8PwN9ZZ3QRdP+96Ho86xD2bzDJSSN6slBRrCqtoaiL2wPnIfj9J4CTi0bsUZ+fme1aeook7DlMVyBfelfqBF+oR9mqtrboIVNvCWOfwl+Kia6LFZl+du3EjZQV52DOWRUWCA2nGj40j9hiYJNRhWV96xh0=
ARC-Authentication-Results: =?utf-8?B?aT0xOyB0ZXN0Lm9mZmljZTM2NS5jb20gMTsNCgkJZG1hcmM9bm9uZSBhY3Rp?=
 =?utf-8?B?b249bm9uZSBoZWFkZXIuZnJvbT1taWNyb3NvZnQuY29tOw0KCQlhcmM9bm9u?=
 =?utf-8?Q?e?=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd1e/wRYWL9g2Lnzv00Qo1HiapD1gNjkZwE46YgNyUQ=;
 b=fGVtL1K5OYQsOeCy4V1NVB9uRAxOz+2fUfAkLSiG9q0LbuedtThKAWao65dqTml2s1qQ8MsJTTamrrhE8I5kRGQYKGHhs91tVyX0sPfuL3Thu2F0v5Px/bTnupj4nzqZgyrIEjzK7PCun9hGYyMJUxRCeVhwoHKGaPGzlnh3RLA=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0123.APCP153.PROD.OUTLOOK.COM (10.170.188.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.3; Thu, 4 Apr 2019 02:42:57 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::811a:86f7:2a6d:71d5]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::811a:86f7:2a6d:71d5%9]) with mapi id 15.20.1771.006; Thu, 4 Apr 2019
 02:42:57 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Solio Sarabia <solio.sarabia@intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Shiny Sebastian <shiny.sebastian@intel.com>
Subject: RE: linux-5.1-rc3: nvme hv_pci: request for interrupt failed
Thread-Topic: linux-5.1-rc3: nvme hv_pci: request for interrupt failed
Thread-Index: AdTqewKw9ZFXkHiTTdS6NKeOfxDFoAAE39fA
Date:   Thu, 4 Apr 2019 02:42:56 +0000
Message-ID: <PU1P153MB01691F731370D45D13C3615CBF500@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <FCE231C24CDC4243982F7030CC75E92F644C034C@FMSMSX102.amr.corp.intel.com>
In-Reply-To: <FCE231C24CDC4243982F7030CC75E92F644C034C@FMSMSX102.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-04T02:42:52.8040871Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d45a7ce-8f50-4419-bd3c-060b9549914d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:a4d4:7648:4163:6e00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c538484d-547b-4e97-16d9-08d6b8a73ebf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0123;
x-ms-traffictypediagnostic: PU1P153MB0123:
x-ms-exchange-purlcount: 2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0123FF094D3FBA89EAF34F24BF500@PU1P153MB0123.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(2906002)(446003)(46003)(81156014)(2201001)(6506007)(11346002)(86362001)(6116002)(105586002)(186003)(6436002)(22452003)(316002)(68736007)(476003)(4326008)(71200400001)(6306002)(53936002)(5660300002)(55016002)(7696005)(9686003)(106356001)(52536014)(8936002)(7736002)(256004)(74316002)(6246003)(14444005)(486006)(71190400001)(86612001)(8990500004)(99286004)(102836004)(966005)(10290500003)(8676002)(2501003)(305945005)(25786009)(76176011)(10090500001)(110136005)(33656002)(54906003)(53546011)(229853002)(478600001)(97736004)(81166006)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0123;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M4rEU/erKc/yZetNS6lRxmHGKUuS3waf9SYQMD73xf2zQTQdTvx8LjPszaVSMXdObM9/mjxwVaNHUgHxAwwaGbQUr9xBxOhwZsDiH4QLJ8T07sXbZrXc7S5pzj7/2avCbGuJ9jfFq1DyttR0RWas57GF5Q5YCq3W5/+yWXtJw2P34bqx//NaMQ5NStbmTdAIb3t09NY1QjnnyUU0eXys/NBT0eF5jUDVaqsSYwT+UDY6emd1hLgnW6wtUTeb3RNwBnjsrRdll1tM2RiWaTBGgvp7f4iaLw+T7NEuZG1a+I7BJ1nmwFQclUG2JrHcExngGDZgxDJrYih7mHGIioeOi8GTfxBKfo/sV/lQ4YQiuQvrDEjnYIZ+Pi0CZZnbPaKAExS9i19C+t87j8SG6yMsgNpSkoySSQIbaSBLy79x84Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c538484d-547b-4e97-16d9-08d6b8a73ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 02:42:56.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0123
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBTb2xpbyBTYXJhYmlhIDxzb2xpby5zYXJhYmlhQGludGVsLmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBBcHJpbCAzLCAyMDE5IDU6MzggUE0NCj4gVG86IGxpbnV4LWh5cGVydkB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiANCj4gV2hlbiB0
d28gbnZtZSBkZXZpY2VzIGFyZSBkaXNjcmV0ZS1hc3NpZ25lZCBbMV0gdG8gYSBsaW51eHZtIG9u
DQo+IGh5cGVyLXYgcnM1IGhvc3QsIGl0IGZhaWxzIHRvIGluaXRpYWxpemUgYm90aC4gIEl0IHdv
cmtlZCBhIGNvdXBsZSBvZg0KPiB0aW1lcyBhbmQgYWZ0ZXIgc29tZSByZWJvb3RzIGl0IGZhaWxl
ZC4gYGRtZXNnYCBzaG93czoNCj4gDQo+IFsgICAxNC4wOTkzMTBdIGh2X3BjaSA5NmEwNzI4My04
ZGFjLTQxN2EtODJjNi0xMTFlYjhiOWE0YzA6IFJlcXVlc3QgZm9yDQo+IGludGVycnVwdCBmYWls
ZWQ6IDB4YzAwMDAwOWENCj4gDQo+IFRoYW5rcywNCj4gLVNvbGlvDQoNCjB4YzAwMDAwOWEgaXMg
U1RBVFVTX0lOU1VGRklDSUVOVF9SRVNPVVJDRVMuDQoNClRoaXMgaXMgYSBrbm93biBob3N0IHJl
c291cmNlIGxlYWthZ2UgYnVnIG9mIHRoZSBSUzUgaG9zdC4gQWZ0ZXIgdGhlIGlzc3VlDQpoYXBw
ZW5zLCByZWJvb3RpbmcgdGhlIFZNIGNhbiBub3QgaGVscCwgYW5kIHJlYm9vdGluZyB0aGUgaG9z
dCBtYXkgaGFuZw0KYW5kIHdlIG1heSBoYXZlIHRvIHBvd2VyIGN5Y2xlIHRoZSBob3N0IGJ5IGZv
cmNlLg0KDQpUaGUgYnVnIGhhcyBiZWVuIGZpeGVkIGluIDE5SDEsIHdoaWNoIGlzIGluIHRoZSBJ
bnNpZGVyIFByZXZpZXcgcGhhc2UsIHRob3VnaDoNCmh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29t
L2VuLXVzL3dpbmRvd3MtaW5zaWRlci9hdC1ob21lL3doYXRzLW5ldy13aXAtYXQtaG9tZS0xOWgx
DQpodHRwczovL3d3dy5taWNyb3NvZnQuY29tL2VuLXVzL3NvZnR3YXJlLWRvd25sb2FkL3dpbmRv
d3NpbnNpZGVycHJldmlld2FkdmFuY2VkDQoNClRoZSBmaXggaXMgYmVpbmcgYmFja3BvcnRlZCB0
byBSUzUsIGJ1dCBJIGRvbid0IGhhdmUgYW4gRVRBIHlldC4gDQpJJ2xsIHRyeSB0byBnZXQgbW9y
ZSBpbmZvIHRvZGF5IGFuZCBrZWVwIHlvdSB1cGRhdGVkLg0KDQpUaGFua3MsDQotLSBEZXh1YW4N
Cg==
