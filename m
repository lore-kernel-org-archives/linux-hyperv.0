Return-Path: <SRS0=GrSc=RK=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D34C43381
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70172063F
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H4XMONOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCGRdX (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:33:23 -0500
Received: from mail-eopbgr750122.outbound.protection.outlook.com ([40.107.75.122]:33805
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfCGRdX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Mar 2019 12:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh2rnylgbtIcSh7q49RSknKLLRRwgDznqSjVUuKZ8sw=;
 b=H4XMONOfGICTQRbNvFNZn8tMBbZZxn+hZ/2rleu2heR6J1raR9PIVM4LxxN4W7S47RCnCDevyjIomCNL6chDVWWO2Mbtv5iAwLndVm8Uj1hZzOeHzNA2yOwzRhauJR8jJupoDa8n5diTz7kY8DPBVvofmaQGbTSzYt4pdIZ9HHU=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1111.namprd21.prod.outlook.com (52.132.132.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.1; Thu, 7 Mar 2019 17:33:19 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::c92a:a5e0:ee92:5f6%5]) with mapi id 15.20.1709.009; Thu, 7 Mar 2019
 17:33:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kimbrownkd <kimbrownkd@gmail.com>
CC:     Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
Thread-Topic: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
Thread-Index: AQHU1QPtZRSIXE09xkqbBoh9CuDLqaYAbAww
Date:   Thu, 7 Mar 2019 17:33:19 +0000
Message-ID: <DM5PR2101MB09182EAC78F8EEA57E27C26AD74C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190307163606.25212-1-mgamal@redhat.com>
In-Reply-To: <20190307163606.25212-1-mgamal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-07T17:33:16.9877002Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f755f17e-5f83-4919-be4b-0a92d1d0fbcb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28fc3db3-c0db-4480-cd85-08d6a322fd49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
x-ms-exchange-purlcount: 2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB11115803193405D2638378FFD74C0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(10090500001)(966005)(55016002)(66066001)(6246003)(478600001)(8990500004)(256004)(14444005)(2501003)(6306002)(9686003)(10290500003)(53936002)(2906002)(305945005)(74316002)(68736007)(7736002)(4326008)(25786009)(97736004)(186003)(3846002)(54906003)(8676002)(6436002)(81156014)(106356001)(22452003)(105586002)(229853002)(81166006)(316002)(110136005)(11346002)(7696005)(8936002)(14454004)(26005)(86362001)(446003)(76176011)(99286004)(86612001)(476003)(33656002)(5660300002)(102836004)(486006)(71190400001)(71200400001)(52536013)(6346003)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XGqrRrV6EflhuNJY+ypOEBWyVaTP/xauJoHDmggMPiu+7mdCKRDSSK5xEabO5NEHfM4/Dt8GjpUHh45SR8iV4oR5VOoowWeqJJOJNZv2fECJdQPfPnhESsycDFaYgNbNGx+qHEDAsw8vXT5tVPy1jc1aDl0KNoosVcLdVhmGmqOkFz+2RDLiMrjtL7AJFBLgVTm+tZvwMkBZjo7uKvXHUbV/z8+BiZJiEuDFxSmB0iUBF5yu9SdrtNrlvtD7G/m/nUaDNijaCFxtOv/3DJINTr94Fw/rDlF8SWFZEIQZitNbGEk1VSqsBbqYPAnynjl9k8mN3vtESPdDzHosi+jsG2l+JTfjmJ0VY4j74Ji4aoJbFxbyvJqwIML0qIWCV0yuiOxtpzfHMTesNn09dlrt0QEOfrEaqc9f7HZASa/aSVA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fc3db3-c0db-4480-cd85-08d6a322fd49
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 17:33:19.1772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Mohammed Gamal <mgamal@redhat.com> Sent: Thursday, March 7, 2019 8:36=
 AM
>=20
> This patch adds a check for the presence of the ring buffer in
> hv_get_bytes_to_read/write() to avoid possible NULL pointer dereferences.
> If the ring buffer is not yet allocated, return 0 bytes to be read/writte=
n.
>=20
> The root cause is that code that accesses the ring buffer including
> hv_get_bytes_to_read/write() could be vulnerable to the race condition
> discussed in https://lkml.org/lkml/2018/10/18/779>
>=20
> This race is being addressed by the patch series by Kimberly Brown in
> https://lkml.org/lkml/2019/2/21/1236 which is not final yet
>=20
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

Could you elaborate on the code paths where
hv_get_bytes_to_read/write() could be called when the ring buffer
isn't yet allocated?  My sense is that Kim Brown's patch will address
all of the code paths that involved sysfs access from outside the
driver.  And within a driver, the ring buffer should never be accessed
unless it is already allocated.  Is there another code path we're not
aware of?  I'm wondering if these changes are really needed once
Kim Brown's patch is finished.

Michael
