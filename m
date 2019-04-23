Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD45C282DD
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAED720645
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cFs3n6Mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfDWQkB (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:40:01 -0400
Received: from mail-eopbgr760122.outbound.protection.outlook.com ([40.107.76.122]:61786
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728891AbfDWQj7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Apr 2019 12:39:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=PYsyPJhDsJ46KO7wFZ9HFJ0/jEnmMfYZfP7Ejof/bQRJH2aa5FtpsyrtBwxY5dtz5PtZlT5U5msFY+Ewdknyl9cWwO0K/aBcp/lTrOEzcJuVCmGDTJDSVE6JfkJVPY60iNYY3Js/jmVFfChD2D73H3aiG+2Vvl127rScrfjU+4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWIaadTnFx4Q8hKpvS7XO7metKCkL8rTFKkSnPUEJAM=;
 b=oPOvoQnoA519b7MCaXqro9P3WwflJGgtvRmQLAZhUD/BQ9vMvabjxZAIJAnz84dSFlOFO6ejcTYJLC2tR+DGaeTAbPlcnFOOz8TAcIzRB+CNGMgpMH4rjcmN1OnonMQB5CVGwGTia+oCzl2OgPJ2YW85oIxvs7A4c+RGYcJNw4k=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWIaadTnFx4Q8hKpvS7XO7metKCkL8rTFKkSnPUEJAM=;
 b=cFs3n6MbU9IAnILPaHopKTUHk4F5HYsGVZ0Dbpxcp/1r0AG0Dysqmple0ffMIGZpRal+YsOojE5Pl1760RByH4EhO5Zwc4HMoKUJIcRIrMPVfmFj831nUPG3IQY7WsJ0E2gIK10P6eYCoZlL1IQ3bk/aN3/oYvWaFHCSazyp7h4=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0981.namprd21.prod.outlook.com (52.132.133.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.4; Tue, 23 Apr 2019 16:39:57 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::2ca9:7d06:f5b1:7a6f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::2ca9:7d06:f5b1:7a6f%5]) with mapi id 15.20.1856.004; Tue, 23 Apr 2019
 16:39:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][v2] drivers: hv: Add a module description line to the
 hv_vmbus driver
Thread-Topic: [PATCH][v2] drivers: hv: Add a module description line to the
 hv_vmbus driver
Thread-Index: AQHU+fMveWYfDXebm0uDr4TX7kkenQ==
Date:   Tue, 23 Apr 2019 16:39:57 +0000
Message-ID: <DM5PR2101MB0918DA7EF7FAFC78C24D8350D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <04eaef0e2b365317935ff756c7365ee13a6f18f8.1555967337.git.joseph.salisbury@microsoft.com>
In-Reply-To: <04eaef0e2b365317935ff756c7365ee13a6f18f8.1555967337.git.joseph.salisbury@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-23T16:39:56.3757712Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2474c3ee-bfbc-4a11-aeb4-7d806508a961;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:fc77:f44:39ef:1b45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ee059ee-7b92-42c0-9b37-08d6c80a5289
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
x-microsoft-antispam-prvs: <DM5PR2101MB09816617D75F5456B91551E5D7230@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(186003)(4326008)(1511001)(305945005)(14454004)(7736002)(46003)(25786009)(6246003)(2501003)(2906002)(86612001)(486006)(76176011)(53936002)(102836004)(9686003)(6116002)(71190400001)(5660300002)(71200400001)(86362001)(256004)(74316002)(476003)(446003)(11346002)(110136005)(66556008)(8676002)(81156014)(52536014)(81166006)(66446008)(558084003)(55016002)(8936002)(73956011)(64756008)(6436002)(33656002)(229853002)(8990500004)(68736007)(66946007)(6506007)(66476007)(22452003)(99286004)(316002)(54906003)(10090500001)(97736004)(478600001)(76116006)(7696005)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N++pMT93DPU1HtFE4w4toUVvsu3QQ1WThgEnHCqcXdjtHcPdKt+qe8ZdgWW8hn7FYdtuBLmczeRDTkLXN1LZaWvTXLeqVOoWemD/nZP6Ec9t2qe1bhMae3cGChjg/ZNjVXOKKgDQtRnH8F5X7gsJ4WoD6iNw9r4KFGqFbCo7D9MacZxlliaiextOd0JN2ZdWMOghWXQ2rQHT5uzMhDqcs7foYiKjsR5d7D22DmtDVGSr0UD9sUMh5PY2UNB4UVLUuQXrWScN4/0rWaQwuIN3znzBrMcEuLIVnxxTLTbsfjjoYnWBpohfwrSdEsK8S3mnQu/Qx9vdWvAOuPlkBkG4eK/h8tBkTn9yOlNHcsnLITbttrFaKlcgzxaWGt59eStdZ/UUPSlRPMzgULd00+jcX4P9PvRZdPa+GuedM2FWCAs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee059ee-7b92-42c0-9b37-08d6c80a5289
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 16:39:57.8172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSm9zZXBoIFNhbGlzYnVyeSA8am9zZXBoLnNhbGlzYnVyeUBtaWNyb3NvZnQuY29tPiBT
ZW50OiBNb25kYXksIEFwcmlsIDIyLCAyMDE5IDg6NDcgUE0NCj4gDQo+IFRoaXMgcGF0Y2ggb25s
eSBhZGRzIGEgTU9EVUxFX0RFU0NSSVBUSU9OIHN0YXRlbWVudCB0byB0aGUgZHJpdmVyLg0KPiBU
aGlzIGNoYW5nZSBpcyBvbmx5IGNvc21ldGljLCBzbyB0aGVyZSBzaG91bGQgYmUgbm8gcnVudGlt
ZSBpbXBhY3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggU2FsaXNidXJ5IDxqb3NlcGgu
c2FsaXNidXJ5QG1pY3Jvc29mdC5jb20+DQo+DQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxl
eSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCg==
