Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED01C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB7F2173C
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OhazrTr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfC1T1m (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:27:42 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:1536
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfC1T1m (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 15:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKVrfuj/lsgGYJFfCEMasXeSp1EpubDufZ49vINOpUM=;
 b=OhazrTr8e7omEr9GRhrJMNADnIliIjqif/0ZXtl27uuaSqExZ0mPzIpcou5rxdHZtL/jSqzTKdfGh2HbzVqNBOGDiNJxZ318uwHjMqKdTNchigMP2ldHGcqng9TT4T1C3lb9IOlYO3lciv2KAWzH9cC9hdWPYBJsx54Bbf7tMRs=
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=QZsddG1iue475dgsUGdDiJSe185C4FzOR38dt55O4AbUTo/PExXxxUHqXHk9a+DKasFqnUb/terJ4C9D6M7EcvcCp2dquTf8QisHIRX5MIZyNdj8mf/kXVi6+NW48E5VMOfQ3byb6lOa2uB7cJWxeK47CWAZnroze0fobZAkwiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKVrfuj/lsgGYJFfCEMasXeSp1EpubDufZ49vINOpUM=;
 b=Nz5ob94jiz3XcDMurk3Q0Yn6ucOvzQwVcNOQDzRULY3weLCA+mACvSm/V7LoxVs8NRYstrlWW6vFkjTtYrctnnPtx46UTtk+Xp3+P6eZnA4kSk4uyb2eHfM3Kum3RpzycZvF7iWgpgpGlvw3Zjjz8YElbD/medzV9luqa+vDSKU=
ARC-Authentication-Results: =?us-ascii?Q?i=3D1;_test.office365.com_1;=0D=0A=09=09dmarc=3Dnone_action?=
 =?us-ascii?Q?=3Dnone_header.from=3Dmicrosoft.com;=0D=0A=09=09arc=3Dnone?=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1146.namprd21.prod.outlook.com (20.179.50.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.2; Thu, 28 Mar 2019 19:27:39 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049%8]) with mapi id 15.20.1771.007; Thu, 28 Mar 2019
 19:27:39 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     David Miller <davem@davemloft.net>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes,v2] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Thread-Topic: [PATCH hyperv-fixes,v2] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Thread-Index: AQHU5ZrtrFq7C3HnrUW1n+cygRgMW6Yha+MAgAAAo2A=
Date:   Thu, 28 Mar 2019 19:27:39 +0000
Message-ID: <DM6PR21MB1337D7CB7707022BEE58C86BCA590@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190328191637.6698-1-haiyangz@linuxonhyperv.com>
 <20190328.122214.1269115693598269959.davem@davemloft.net>
In-Reply-To: <20190328.122214.1269115693598269959.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-28T19:27:37.6191497Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e3eb8f8-f9a5-433a-b17f-130d89a4fe06;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 076ef0b7-8bae-4cba-b25b-08d6b3b3710d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1146;
x-ms-traffictypediagnostic: DM6PR21MB1146:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1146001271FECC780BC25504CA590@DM6PR21MB1146.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(13464003)(102836004)(54906003)(316002)(10090500001)(5660300002)(81166006)(66066001)(22452003)(305945005)(11346002)(486006)(476003)(446003)(229853002)(25786009)(81156014)(86612001)(52536014)(33656002)(6246003)(71200400001)(71190400001)(105586002)(74316002)(106356001)(7696005)(2906002)(256004)(86362001)(53936002)(97736004)(478600001)(6916009)(99286004)(6116002)(68736007)(6506007)(55016002)(8676002)(26005)(14454004)(8990500004)(10290500003)(7736002)(76176011)(8936002)(3846002)(186003)(53546011)(9686003)(4326008)(6436002)(26123001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1146;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IVTmY7OiBUD0VBv7VcZhxqTFuLHzyIq6zh9Ic6nHkT0h+ge31P0Ou32YuR9hR+ZZJe58AybwBXIGCwJZeaDNuKCZIXzDpHuMceVcaNBmJfUtdTfJOUOyITh7MHPKYWAfs7oqfXYBw58qaEV4cwETix61d9cxYiELfH54czYcnOoo3//lXbHimnrMKqBIlEl6u40d1Etjke8u9TZRoStrFjQutyM7jXW3l7+HNktGX+3id84UNRjIdKdl8julOIsc39ZXXIJtX7HQcbUcnnzEecBMWYtYQubAC+tZqUqhprimGRmkjN29M7hL05PCBiQZNtyqGrEox4kgxPLs4ACsmnOpCANhUV05H5+wdGI/2V9M7CRF4KvgQJyigv2ArPvJ/o/s098IebL8dSecz/L7p7TGFNoRZx1JIok4A0b3g80=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076ef0b7-8bae-4cba-b25b-08d6b3b3710d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 19:27:39.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1146
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: linux-hyperv-owner@vger.kernel.org <linux-hyperv-
> owner@vger.kernel.org> On Behalf Of David Miller
> Sent: Thursday, March 28, 2019 3:22 PM
> To: haiyangz@linuxonhyperv.com
> Cc: sashal@kernel.org; linux-hyperv@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH hyperv-fixes,v2] hv_netvsc: Fix unwanted wakeup after
> tx_disable
>=20
> From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Date: Thu, 28 Mar 2019 19:16:37 +0000
>=20
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > After queue stopped, the wakeup mechanism may wake it up again when
> > ring buffer usage is lower than a threshold. This may cause send path
> > panic on NULL pointer when we stopped all tx queues in netvsc_detach
> > and start removing the netvsc device.
> >
> > This patch fix it by adding a tx_disable flag to prevent unwanted
> > queue wakeup.
> >
> > Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
> > Reported-by: Mohammed Gamal <mgamal@redhat.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Still need to fix the inline issues I mentioned in v1.

I will fix the inline issues.=20

The haiyangz@linuxonhyperv.com cannot receive emails.=20
My regular email is in the reply-to: field.=20
Also, linuxonhyperv.com is being replaced by a new system soon.

Thanks.
- Haiyang
