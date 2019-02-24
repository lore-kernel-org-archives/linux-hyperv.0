Return-Path: <SRS0=i+7F=Q7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EA8C43381
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 16:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F20205C9
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 16:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JTlGThxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfBXQyI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:54:08 -0500
Received: from mail-eopbgr750108.outbound.protection.outlook.com ([40.107.75.108]:29286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728179AbfBXQyI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Feb 2019 11:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRCN4KiKd9aYMdvScn8MzFxPdh54+vtN/BbIW17yB2c=;
 b=JTlGThxrS1WUd49ITDwrDx2nngas54Zo5nvqHzgNRMgu9hEYRaNX0VKnwf5OD/4Zlg/i5beD9R5Y0OyZaJDYPDbYo7wVM+/BtTv65KKSILW517gZ5/LvG6cjCIuiiXiP+VuSYzjjna7xt/pBvPRAEY8yxex7MdxgsihwybutapA=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1030.namprd21.prod.outlook.com (52.132.128.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.4; Sun, 24 Feb 2019 16:54:04 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%8]) with mapi id 15.20.1686.003; Sun, 24 Feb 2019
 16:54:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: Refactor chan->state if
 statement
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: Refactor chan->state if
 statement
Thread-Index: AQHUymFJafr//wA1P0WAFfBXe7I1j6XvLhRA
Date:   Sun, 24 Feb 2019 16:54:03 +0000
Message-ID: <DM5PR2101MB0918C0F4B89F715C2C643ECBD7790@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <cover.1550806305.git.kimbrownkd@gmail.com>
 <1bb109543adc60c1f349e0c6f290591804b4289a.1550806305.git.kimbrownkd@gmail.com>
In-Reply-To: <1bb109543adc60c1f349e0c6f290591804b4289a.1550806305.git.kimbrownkd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-24T16:54:02.1428765Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6ee00396-5cdc-4133-9c7a-10b5444b7874;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dfd4c30-9589-4948-a18a-08d69a78aed4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjIxMDFNQjEwMzA7MjM6Zy9vK2dsMWRkNGpwK3hsWnhMeHVTRmI0?=
 =?utf-8?B?ZEJYRS8wV1hVZFNSV3JvTFJQcjZ3WE9jQjRXeWJIZ1RXV1ptMW9IMTJ6b1hq?=
 =?utf-8?B?TDdMeVBlQ2hzMVFyamJ1UWtsNW5mM1dpMGRBcXlSaUdFbXEyb2s1LzRNQ0Rm?=
 =?utf-8?B?M2V4b1FNTCtQZEJvNGdpQ082Nk1MSGtrRHM5RTJ2MG1lVE1xd2tyWWVoZDdH?=
 =?utf-8?B?ZDhOdCtyN2JKZTdMZk1udGdzOXU3clExTThxR2xIeGpTU0FEUngwZ1VJRTlh?=
 =?utf-8?B?MGZGdzYyc1VYMWZGZmRRUXNWYnp1eTlCalFVcmx6YnBmMUxvOFB4OCtUdjVw?=
 =?utf-8?B?VjU3RGZBYjBDY0pyS2R4Mk42YlZZUmY2ZmFtOVovYVVONDlSS2hDUlozYWph?=
 =?utf-8?B?MVNCVmkvSU96elo0TTlDTXphWHpTSllZVWJyc2pyVW90R1VLbnh2OWFjWUpP?=
 =?utf-8?B?S2daektQMFQvUjIvMEw5V0ZpRnRxbGltOGk5NlE5YkZXNWpFTEdLd3NNb1hQ?=
 =?utf-8?B?WkE3V0dCcU5qQkJkdHA2aDR3Z090bkEyeFViMkg0QlhhK1pQbXFtVnpXSVZN?=
 =?utf-8?B?ZUYyd04rVkVoQTRCZWM3ZnBkVXQ2ZlU5cGFvZ1gweDJUSG5CQ1k5VUxScGlY?=
 =?utf-8?B?RlpyMUZuUVYyQ3pENzB6L1FvNVpoM2t5YjRkV2dPZXd4WDVLUXFuRG9TNzIr?=
 =?utf-8?B?bjEydzF6RTN2NmNxWTJnNUZ6MHFhVDd5aXMwUjMzSjlmRllwc2krbzVtbjM3?=
 =?utf-8?B?eFNHV2dKb3NVSkhaUmlpNkh0U08vVENYSUJzRmJOcFpqbkFsdEUxNGhsOEs1?=
 =?utf-8?B?cnZpZWdVWFN0UFhOTUhPa1ZLdmVSbXFUdDA2dkViTzEyS05oVC9yU0NsVFBI?=
 =?utf-8?B?NkJ2bUc5UEE1WG1SNHhmN0h2c3ZDTVlSVjhZQzhZSHBLQVRrUnd5dlNTakZv?=
 =?utf-8?B?S2wwYkhwWTRUN3dUZmMwcWVneGs2bjJ6cm5CQkUwSUhKNVRya2RkS3JmakUr?=
 =?utf-8?B?aGlLdnpRS0NoQVYxcDhWL2xKS29ZTUJta3ZIZUd1dk00Ulo4cTBEV25FT3JX?=
 =?utf-8?B?eGdGNEFCZTRQWGxCdmk3M3FRT2pka1Q4eGprMmk4T1hUekVhWFlkdGtmSnNT?=
 =?utf-8?B?blNnQkhIbnlQellwdjhsZ1NtQm5zNTk5a1B4WjA3alRjRGtvdkI1ZU80cGEy?=
 =?utf-8?B?b1pnWUcySG9VUjgzVjkvWFEzVVRTRTQ3YmFuWjJPRXNnSVdFSTRpOWFuaS90?=
 =?utf-8?B?NXlRQlByMGRXUStKNHNGdzlCdTZuM2czWmZEeTBuQ2FSWDFnRmdsRkM4cWdp?=
 =?utf-8?B?OFVJRHJvcW9tU3JIRHc2NVJVMzlvdEhYazBwUzhUS3VkOW9pd3cyN1VROExn?=
 =?utf-8?B?MkFjaXBaSzZGbkNsclFIOVIxZHhFRDhWUTNVSmxDKzNNb3V2OXBpdFFxcDJW?=
 =?utf-8?B?VUx4K3VnZ2NFcVpORDJNSm50bXZ0TStXUnZvU3dCZXBNWlJxTlk5My9Ud1pW?=
 =?utf-8?B?cWlYOUdBdlNjVmtHN2ZTSVd4bFdVY3Bua3Y2cTZacHU0M3JUUEY1bFdzaUJS?=
 =?utf-8?B?ckNTR0x2bGtldlN2V1BTaWpsanpIVTV3RDd3ZWFuMURKK2U2QlJKclVodnlG?=
 =?utf-8?B?RmFYc28vdFQvKy93bVVYSlZRWjFMUlpaVzNoWmlRR1NIVzVhdVkxU2NpaWl6?=
 =?utf-8?B?WWgxRngvcGYrNWpZV2FVK1J4ZHJvcm1CNnVGeVRZMjdhc09PSnQ4WHowbzZD?=
 =?utf-8?B?WXFDUVJHWUR4Z3I1T2FFVlpZTmNKdWUxTmFON3N2cTFYUkhteXk4YTFISnNC?=
 =?utf-8?B?RnphdDQ1NGRmOFVYU3JnTkQ2bjJVNDlmbzJ3Skc1eVhJdjhuRXVNNlRLUitU?=
 =?utf-8?B?ODhpS0NpeXZRcXltWmd0cjNuRFpYQm9neXk0ZzRqbmhkaHZJR3dhTHRxdjFW?=
 =?utf-8?B?NmF4di9xZTV3Snc9PQ==?=
x-microsoft-antispam-prvs: <DM5PR2101MB103043ED16F0CD6AD4F4FA40D7790@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(8990500004)(4326008)(186003)(1511001)(74316002)(81156014)(54906003)(97736004)(110136005)(7736002)(305945005)(8676002)(81166006)(6436002)(33656002)(256004)(229853002)(102836004)(14444005)(6506007)(10090500001)(26005)(316002)(6116002)(3846002)(2906002)(68736007)(71190400001)(6346003)(9686003)(22452003)(71200400001)(86612001)(25786009)(7696005)(478600001)(10290500003)(476003)(66066001)(486006)(6246003)(6636002)(99286004)(86362001)(8936002)(76176011)(446003)(55016002)(11346002)(53936002)(106356001)(14454004)(105586002)(5660300002)(52536013);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UyQx5LOFRUllSy2TkGpl13/BYGrSBHSdr4kG0OrF3aJ8NtPpBIGK8p8CFM1qIVWlKpHZQjkQ/XLlwWXZLAKP4c40sAKLImfQxQueqJp10VWH+fH2cG+ZIBnpugqnYclg6x9+A8jO3ZU7OZ+46oWiCUcaYSOaYv+VrdNxL+/O32S56c39swmi9IUSPmhftP4uX/h1gnCyxjSRyshX+yo4RSIcHTybAZNE8fmr6i+RoCMi/xo8c//D992Da9cHzDALD/8+VglnoP+h4MPzBgoAgGC4t5SiJA9KUxHZzx84smfa6pxs1XI3+pIJZjCuHkBxksgNzzCFbidMj6DADYlBpyeKm6FrM2lzb7HTOOjskuXh6/EL+6cXk8z1YlX3AYCaaaGXPGQyJNXZjx8ktsCkMMIGp6AZZBejw2a3rl0eIZU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfd4c30-9589-4948-a18a-08d69a78aed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 16:54:03.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogS2ltYmVybHkgQnJvd24gPGtpbWJyb3dua2RAZ21haWwuY29tPiAgU2VudDogVGh1cnNk
YXksIEZlYnJ1YXJ5IDIxLCAyMDE5IDc6NDcgUE0NCj4gDQo+IFRoZSBjaGFuLT5zdGF0ZSAiaWYg
c3RhdGVtZW50IiB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQgNjcxMmNjOWMyMjExDQo+ICgidm1i
dXM6IGRvbid0IHJldHVybiB2YWx1ZXMgZm9yIHVuaW5pdGFsaXplZCBjaGFubmVscyIpLiBUaGF0
IGNvbW1pdA0KPiBzdGF0ZXMgdGhhdCB0aGUgcHVycG9zZSBvZiB0aGUgY2hhbi0+c3RhdGUgImlm
IHN0YXRlbWVudCIgaXMgdG8gcHJldmVudA0KPiByZXR1cm5pbmcgZ2FyYmFnZSBvciBjYXVzaW5n
IGEga2VybmVsIE9PUFMgd2hlbiB0aGUgY2hhbm5lbCByaW5nIGJ1ZmZlcg0KPiBpcyBub3QgaW5p
dGlhbGl6ZWQuIFRoZSBjaGFuZ2VzIGluIHRoaXMgcGF0Y2ggcHJvdmlkZSB0aGUgc2FtZQ0KPiBw
cm90ZWN0aW9uLg0KPiANCj4gUmVmYWN0b3IgdGhlIGNoYW4tPnN0YXRlIOKAnGlmIHN0YXRlbWVu
dOKAnSBpbiB2bWJ1c19jaGFuX2F0dHJfc2hvdygpOg0KPiAgLSBJbnN0ZWFkIG9mIGNoZWNraW5n
IHRoZSBjaGFubmVsIHN0YXRlIGluIHRoZSAiaWYgc3RhdGVtZW50IiwgY2hlY2sNCj4gICAgd2hl
dGhlciB0aGUgY2hhbm5lbCByaW5nIGJ1ZmZlciBwb2ludGVyIGlzIE5VTEwuIENoZWNraW5nIHRo
ZQ0KPiAgICByaW5nIGJ1ZmZlciBwb2ludGVyIG1ha2VzIHRoaXMgY29kZSBjb25zaXN0ZW50IHdp
dGgNCj4gICAgaHZfcmluZ2J1ZmZlcl9nZXRfZGVidWdpbmZvKCkuDQo+IA0KPiAgLSBNb3ZlIHRo
ZSAiaWYgc3RhdGVtZW50IiB0byB0aGUgZm91ciAiX3Nob3ciIGZ1bmN0aW9ucyB0aGF0IGFjY2Vz
cyBhDQo+ICAgIGNoYW5uZWwgcmluZyBidWZmZXIuIE9ubHkgZm91ciBvZiB0aGUgY2hhbm5lbC1s
ZXZlbCAiX3Nob3ciIGZ1bmN0aW9ucw0KPiAgICBhY2Nlc3MgYSByaW5nIGJ1ZmZlci4gVGhlIHJp
bmcgYnVmZmVyIHBvaW50ZXIgZG9lcyBub3QgbmVlZCB0byBiZQ0KPiAgICBjaGVja2VkIGJlZm9y
ZSBjYWxsaW5nIHRoZSBvdGhlciAiX3Nob3ciIGZ1bmN0aW9ucywgYW5kIG1vdmluZyB0aGUNCj4g
ICAgcmluZyBidWZmZXIgcG9pbnRlciAiaWYgc3RhdGVtZW50IiB0byB0aGUgIl9zaG93IiBmdW5j
dGlvbnMgdGhhdA0KPiAgICBhY2Nlc3MgYSByaW5nIGJ1ZmZlciBtYWtlcyB0aGUgcHVycG9zZSBv
ZiB0aGUgImlmIHN0YXRlbWVudCIgY2xlYXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaW1iZXJs
eSBCcm93biA8a2ltYnJvd25rZEBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtl
bGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCg==
