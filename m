Return-Path: <SRS0=KSih=RF=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ACDC43381
	for <linux-hyperv@archiver.kernel.org>; Sat,  2 Mar 2019 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEF620838
	for <linux-hyperv@archiver.kernel.org>; Sat,  2 Mar 2019 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U5Y+38qM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCBSjg (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:39:36 -0500
Received: from mail-eopbgr790135.outbound.protection.outlook.com ([40.107.79.135]:12064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfCBSjf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 2 Mar 2019 13:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qKUFg37P3gs3MZiiUuMuFZNoLgTVDHlDxV+SDCy5s4=;
 b=U5Y+38qM8ifyxUCRN08f8qGPyNcHnLpO1ENui8U2WK9RpiOvxvfDEz5u/UbEw654bWe/v1UHJlSrSBr+H4EtXK+utz16Z/6vVTfPOs02J55Gy/vEWAkn5YlWlHDf82Qy7RmKI05HplGe9JqMkj3b8fW5S7R9W8O1HYqzwALDeQ0=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0887.namprd21.prod.outlook.com (52.132.132.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.3; Sat, 2 Mar 2019 18:39:31 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%8]) with mapi id 15.20.1686.003; Sat, 2 Mar 2019
 18:39:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Thread-Topic: [PATCH v4] Drivers: hv: vmbus: Expose monitor data only when
 monitor pages are used
Thread-Index: AQHU0GOP4Hnv7QzAq0Gy2Vo3bvT5e6X4q0rw
Date:   Sat, 2 Mar 2019 18:39:30 +0000
Message-ID: <DM5PR2101MB091825C55612FBCEA3322119D7770@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190226053530.GA2897@ubu-Virtual-Machine>
 <20190301191824.GA4108@ubu-Virtual-Machine>
In-Reply-To: <20190301191824.GA4108@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-02T18:39:27.7610633Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2d9ed75d-13e4-4fbd-bbbf-79ba7f57ada0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [107.0.123.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbc22955-2881-4e30-0b7f-08d69f3e6889
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB0887;
x-ms-traffictypediagnostic: DM5PR2101MB0887:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjIxMDFNQjA4ODc7MjM6VVVkWk9zS2s1aVY2cC9OZEdPTldmN2I0?=
 =?utf-8?B?aHNycFVEQkZkK2JXVnBHU01LSHR0Nlg3QnZpSDRLa1dYT3VFQW9UcFJQM0lk?=
 =?utf-8?B?ZFJSNWJQUTZpQzFna1BLVm44eFNXRktHK3J6MnhlenZBMm9PWEZVc2lTVEQ5?=
 =?utf-8?B?S1EyTjFEZFVmNHhZV3drQXBlU05zd3BmekNRU1JYSVpqVktZeEhlaS9PMzlI?=
 =?utf-8?B?bTFrUjJjaWV2ZXBBR0hQdEc1QjhJSzBpTHFjdHJYOUpHOUFuanZ5OXVBZmVL?=
 =?utf-8?B?T2p1WlRCYm5iNG04TFlZSnowcWJFY2xKYmRUdFh1T2N3bkhJbks4cFR4RUpW?=
 =?utf-8?B?OHFRaDdrNS81REdEOWZIZWtmWnozZ3psQWFvZERmVGI2WnhMOXk1b2gwU3dq?=
 =?utf-8?B?MzZ0MlVyQ2pYd0Z2bmdGZWZMNEQvUEdYaWJmdGhYZXloUHE4U2dhS0NDdE1q?=
 =?utf-8?B?M1NvNEpLbEV2ei91OExQWEtBSFk2R1F0QnJBWlB4LzNaOEpjK25TTkFualpC?=
 =?utf-8?B?S1hZSmY1RDNkSWNTZWxBUnhGckx4RWswRXZtdHVjaUdzS3MxTXJoS2hCdzFy?=
 =?utf-8?B?a2JFZmF1ZnRORGQ0SUtIYkpkRHh5U0Nnc05EOVhuenJMMUdLTWUrY3JGa3U1?=
 =?utf-8?B?bHJTVUFMRTFyNmFJanRaNXdZN3NScDgxVytuYUFKK3BYRFNDazA1cm5pbFFh?=
 =?utf-8?B?MFVjN1lCUzhOWVR1VFpLZmNhM0dTdmx4U0lIWFpUekZvTUlzOFVlby9TMFZ1?=
 =?utf-8?B?d1VNMTI5N2NpYXlGaHdITHk4SU5HNnA0UFVuQjRsemI3MkNQM3BaYWR3S3pK?=
 =?utf-8?B?Qld4UVJrYXJPUVUyWXdoRnlsUmhDRjNYWml6b3A0NUFlSS95RUwwbkV2T0hK?=
 =?utf-8?B?OEEyNUYxelcwc2h6N3RMdy9hcTdQeGFJN0JMa2dHWUxkZVQwVzAzNzNWNXFo?=
 =?utf-8?B?bEZCS1FRL2FTc2ZBTHIvaWpJSmkzSGxnbGU5eDVNYWtJbnZsYUgwWUlsNXpI?=
 =?utf-8?B?S1cwRWYzdFE2T3RjSG9EOGQxQ3RSSS9uazFhZkl5MGFxaXkwek5kSDJjK3JK?=
 =?utf-8?B?cDB2RE40KzJwamVnVFpIS2k3YmV5b1g0NWVSMjAxQmVZTGJkelBramIwWEpB?=
 =?utf-8?B?c0c5bUJXYzZUbEp5RTNPT3ZZdnF3ekpmVWM0QUducndWN1k2MUZ0dkl3cWdp?=
 =?utf-8?B?V1ZSeVFGd2Y4RHdvblNJSFVnTXdMZHB2cHNjalZGOFNwNC9lRi91VDdEQ0hG?=
 =?utf-8?B?VldtWDFVTWt5N09YV3ZpZVdLUDZmUmh3OEtaUHdCaHlPczhHa1BGbW84UGtX?=
 =?utf-8?B?NHhsQlM0QmJUbzQySUpZaVZ2TEpLbFdHYkJvWU4rbnpyS3NpZVNQYmxQeVAz?=
 =?utf-8?B?OFBrNGdCQzhkYWpWVzhCUHlBNDdIRnVkSHpDaHRzclJ5RW8xTFdnTjFRQXpP?=
 =?utf-8?B?ZmxMNVNYdGRsYk0wazQvWjBFSU8yaHlBNHdtYjBNZ1YrTGVvZFRvcjh6bzA2?=
 =?utf-8?B?TkhkNUMrZ2pxeVJmK2ZKQkFzRG45TWVES0dLR09nSmtnZ3NmMU9OaEsyb2VU?=
 =?utf-8?B?emhWRG5BaXRlOGpyNHZBTGIza1E3bVh2ZGFwN0h1TXEzNmdIcE9mczVNMnc2?=
 =?utf-8?B?RmNtWFdiWStBbW85b0tUQTMxTXJMNEhaU1VBeCtidG0wak1YcE5aNCtyZ1JQ?=
 =?utf-8?B?UUxmbld1QitrVWVSM3RLTUI3ZEZKQVJUYnE4T01adCtkOEVMUVAraWVEMHJq?=
 =?utf-8?B?N2xmTmx5ZFNQeTJHUzlXQm1CbmVnakFxL3FTK3dlb2dvbmdvNUoyZ2doc2VO?=
 =?utf-8?B?WldEc2dGMXcxV243VjM3ZjVaSlN4Y1JDbjJqcWlTVUx4WENhbHFLd1JFVXFs?=
 =?utf-8?B?ckQwZFBCRE5pWWYwZ3VBWCtqaU1NT2pDNStBYW9GK2NYWGdIeFZDcVVUTktY?=
 =?utf-8?B?dGpBTVV3Wjd1MHc9PQ==?=
x-microsoft-antispam-prvs: <DM5PR2101MB08875F992CB1D02EC42B9998D7770@DM5PR2101MB0887.namprd21.prod.outlook.com>
x-forefront-prvs: 09645BAC66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(186003)(256004)(14444005)(6506007)(76176011)(9686003)(55016002)(26005)(6346003)(6436002)(102836004)(7696005)(22452003)(97736004)(10290500003)(316002)(54906003)(110136005)(71200400001)(71190400001)(25786009)(229853002)(2501003)(68736007)(8936002)(478600001)(33656002)(14454004)(4326008)(486006)(476003)(11346002)(446003)(2906002)(6116002)(3846002)(106356001)(105586002)(305945005)(7736002)(86362001)(86612001)(53936002)(99286004)(6246003)(8676002)(81166006)(81156014)(8990500004)(1511001)(66066001)(10090500001)(52536013)(5660300002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0887;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eSf5w7Jcc5wYSQaacVp0KPoGv5ycQZ5un+EugdCpDDuK3xUFkzAXKUl29TIr2ivO46iuz1MjQWsDxPUglY4cBHlGsLG7okoHp1qj15IqMmCl8jJSmSOWLTQTquyf67XMapA+qV4FmkZxyh3RZ3MyhQlhki65736aCy/Z7ac/HgfEPqItQm+qAJSqnl8FzlTzI5pKnGzHRbTK2XjJylfUjtfmSDtDdkiebM8DKtuPqndDcPYyZ9VQrXnvVxRvbt8RvCrteKQCr00v61e5wqsSKS3D68CVZSlWhq1iFLC1ZyoimCNGkyvdAlISFL2swIkOoNSYG+jixX20qmT1D9Aw4DeHExRy8C63AOuisk05dkvtLRVhJvDNpc476yvjTBMFXnDYAWuLBjMMFkOqTgKGsh7Lpxi5k4cdPrZj5bymzV4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc22955-2881-4e30-0b7f-08d69f3e6889
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 18:39:30.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0887
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogS2ltYmVybHkgQnJvd24gPGtpbWJyb3dua2RAZ21haWwuY29tPiAgU2VudDogRnJpZGF5
LCBNYXJjaCAxLCAyMDE5IDExOjE4IEFNDQo+IA0KPiArLyoNCj4gKyAqIENoYW5uZWwtbGV2ZWwg
YXR0cmlidXRlX2dyb3VwIGNhbGxiYWNrIGZ1bmN0aW9uLiBSZXR1cm5zIHRoZSBwZXJtaXNzaW9u
IGZvcg0KPiArICogZWFjaCBhdHRyaWJ1dGUsIGFuZCByZXR1cm5zIDAgaWYgYW4gYXR0cmlidXRl
IGlzIG5vdCB2aXNpYmxlLg0KPiArICovDQo+ICtzdGF0aWMgdW1vZGVfdCB2bWJ1c19jaGFuX2F0
dHJfaXNfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gKwkJCQkJICBzdHJ1Y3QgYXR0
cmlidXRlICphdHRyLCBpbnQgaWR4KQ0KPiArew0KPiArCWNvbnN0IHN0cnVjdCB2bWJ1c19jaGFu
bmVsICpjaGFubmVsID0NCj4gKwkJY29udGFpbmVyX29mKGtvYmosIHN0cnVjdCB2bWJ1c19jaGFu
bmVsLCBrb2JqKTsNCj4gKw0KPiArCS8qIEhpZGUgdGhlIG1vbml0b3IgYXR0cmlidXRlcyBpZiB0
aGUgbW9uaXRvciBtZWNoYW5pc20gaXMgbm90IHVzZWQuICovDQo+ICsJaWYgKCFjaGFubmVsLT5v
ZmZlcm1zZy5tb25pdG9yX2FsbG9jYXRlZCAmJg0KPiArCSAgICAoYXR0ciA9PSAmY2hhbl9hdHRy
X3BlbmRpbmcuYXR0ciB8fA0KPiArCSAgICAgYXR0ciA9PSAmY2hhbl9hdHRyX2xhdGVuY3kuYXR0
ciB8fA0KPiArCSAgICAgYXR0ciA9PSAmY2hhbl9hdHRyX21vbml0b3JfaWQuYXR0cikpDQo+ICsJ
CXJldHVybiAwOw0KPiArDQo+ICsJcmV0dXJuIGF0dHItPm1vZGU7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHZtYnVzX2NoYW5fZ3JvdXAgPSB7DQo+ICsJLmF0
dHJzID0gdm1idXNfY2hhbl9hdHRycywNCj4gKwkuaXNfdmlzaWJsZSA9IHZtYnVzX2NoYW5fYXR0
cl9pc192aXNpYmxlDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgc3RydWN0IGtvYmpfdHlwZSB2bWJ1
c19jaGFuX2t0eXBlID0gew0KPiAgCS5zeXNmc19vcHMgPSAmdm1idXNfY2hhbl9zeXNmc19vcHMs
DQo+ICAJLnJlbGVhc2UgPSB2bWJ1c19jaGFuX3JlbGVhc2UsDQo+IC0JLmRlZmF1bHRfYXR0cnMg
PSB2bWJ1c19jaGFuX2F0dHJzLA0KDQpKdXN0IHRvIGRvdWJsZS1jaGVjayBteSB1bmRlcnN0YW5k
aW5nLCByZW1vdmluZyB0aGUgZGVmYXVsdF9hdHRycw0KaGVyZSBtZWFucyB0aGF0IGluIHZtYnVz
X2FkZF9jaGFubmVsX2tvYmooKSwgdGhlIGNhbGwgdG8NCmtvYmplY3RfaW5pdF9hbmRfYWRkKCkg
d2lsbCBvbmx5IGNyZWF0ZSB0aGUgc3ViLWRpcmVjdG9yeSB0aGF0IGlzIHRoZQ0KY2hhbm5lbCBu
dW1iZXIuICBUaGUgc3ViLWRpcmVjdG9yeSB3aWxsIGJlIGVtcHR5LiAgVGhlbiB0aGUgbmV3DQpj
YWxsIHRvIHN5c2ZzX2NyZWF0ZV9ncm91cCgpIHRoYXQgeW91IGFkZGVkIGJlbG93IHdpbGwgcG9w
dWxhdGUNCnRoZSBzdWJkaXJlY3RvcnksIGFzIGZpbHRlcmVkIGJ5IHZtYnVzX2NoYW5fYXR0cl9p
c192aXNpYmxlKCkuDQoNCj4gIH07DQo+IA0KPiAgLyoNCj4gQEAgLTE1NzEsNiArMTYyNCwxMiBA
QCBpbnQgdm1idXNfYWRkX2NoYW5uZWxfa29iaihzdHJ1Y3QgaHZfZGV2aWNlICpkZXYsIHN0cnVj
dA0KPiB2bWJ1c19jaGFubmVsICpjaGFubmVsKQ0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiBy
ZXQ7DQo+IA0KPiArCXJldCA9IHN5c2ZzX2NyZWF0ZV9ncm91cChrb2JqLCAmdm1idXNfY2hhbl9n
cm91cCk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlwcl9lcnIoIlVuYWJsZSB0byBzZXQgdXAgY2hh
bm5lbCBzeXNmcyBmaWxlc1xuIik7DQo+ICsJCXJldHVybiByZXQ7DQoNCkluIHRoaXMgZXJyb3Ig
Y2FzZSwgdGhlIHByZXZpb3VzbHkgY3JlYXRlZCBzdWItZGlyZWN0b3J5IHRoYXQgaXMgdGhlDQpj
aGFubmVsIG51bWJlciBuZWVkcyB0byBiZSBkZWxldGVkL2NsZWFuZWQgdXAuDQoNCj4gKwl9DQo+
ICsNCg0KTWljaGFlbA0K
