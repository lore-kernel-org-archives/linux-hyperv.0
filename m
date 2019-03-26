Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ADDC43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 07:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8220811
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 07:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iSnjQ/r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfCZHDF (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:03:05 -0400
Received: from mail-eopbgr1320125.outbound.protection.outlook.com ([40.107.132.125]:18688
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfCZHDF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 03:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+PboXISNxKppnVNTcPQ2P46VY2xfzBvB4VBJVNNdns=;
 b=iSnjQ/r/3riYhr6U0WBcTCFhgoLuo/qALPCeYKgd6ZFloqSkQJVr2ghxGXQmZpOsTOHmb91q+48WCNVpQtSJcohxOBzwkhtpcOayiHTNHSbRLe3ETCdWNHEQTnMH4QGHS0keWn9B69QWiMykc+K+0IuP9b/R87zwpOvi7IenXwU=
Received: from TY2P153MB0222.APCP153.PROD.OUTLOOK.COM (20.178.148.142) by
 TY2P153MB0223.APCP153.PROD.OUTLOOK.COM (20.178.148.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.3; Tue, 26 Mar 2019 07:02:18 +0000
Received: from TY2P153MB0222.APCP153.PROD.OUTLOOK.COM
 ([fe80::5da:26bc:4252:c6fc]) by TY2P153MB0222.APCP153.PROD.OUTLOOK.COM
 ([fe80::5da:26bc:4252:c6fc%9]) with mapi id 15.20.1771.003; Tue, 26 Mar 2019
 07:02:18 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: RE: Bad file pattern in MAINTAINERS section 'Hyper-V CORE AND
 DRIVERS'
Thread-Topic: Bad file pattern in MAINTAINERS section 'Hyper-V CORE AND
 DRIVERS'
Thread-Index: AQHU41FDdlZWKBv1RkayqT6aknj7k6YdcjJA
Date:   Tue, 26 Mar 2019 07:02:18 +0000
Message-ID: <TY2P153MB0222EA291D8F7F5094DCB3F4925F0@TY2P153MB0222.APCP153.PROD.OUTLOOK.COM>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212516.26489-1-joe@perches.com>
In-Reply-To: <20190325212516.26489-1-joe@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-26T07:02:16.0928911Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2382046b-d180-4d53-8599-80174d23bab6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [167.220.255.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2b1ad6b-81c3-46cb-969a-08d6b1b8fc53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:TY2P153MB0223;
x-ms-traffictypediagnostic: TY2P153MB0223:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <TY2P153MB0223CE95087808EC6FC63D1E925F0@TY2P153MB0223.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(13464003)(102836004)(14454004)(33656002)(229853002)(7696005)(53546011)(4326008)(6506007)(446003)(66066001)(76176011)(71190400001)(7736002)(11346002)(68736007)(2501003)(3846002)(8676002)(106356001)(6116002)(81156014)(81166006)(55016002)(105586002)(486006)(476003)(5660300002)(6436002)(256004)(186003)(26005)(71200400001)(97736004)(305945005)(316002)(74316002)(6246003)(53936002)(22452003)(478600001)(9686003)(54906003)(10090500001)(10290500003)(8990500004)(8936002)(99286004)(110136005)(72206003)(86362001)(86612001)(52536014)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2P153MB0223;H:TY2P153MB0222.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xlbo659U4YIzbZSSjhLJOnVnZIxF4S0ftYVITLJ6tDnODp96EuYurW9nwTc/XeIk4hZ1P2bB6UYcnPpnK7w/nfzUJHf0S8YjULwDy44gwHxWVRf+4JqgN+G0FjKCd0HyCcrLUqBHCXghhjPUPgzBqSrKIa2v/AiEv2L3eCYuE/y7kLn8o9UuuIuQoMuZBLgMy8Vl7Kc6eZwoLVIVoZAg3C5TXsmLDIZf6UR2SHCHYUisqpz+zNM5uiplUi1mg74FSP8KmEEVv7jF6rpl6WAVMQk2zR0m+if/dc7zVSZk2KcRP0U2mcPxvvkkRBUUFqbZSBznzMUTs7CKX4OTUSjq8+pOR8Ej5zYBZvFGnBLwEunoetIJe7KSkvHmuH9ZmD24Fj6JNEuJAbhh/AwV0LTPNe70ocM7wGtSJIlBX99Xdz0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b1ad6b-81c3-46cb-969a-08d6b1b8fc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 07:02:18.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2P153MB0223
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Joe:
	Thanks for report. I just sent out a fix patch.

-----Original Message-----
From: Joe Perches <joe@perches.com>=20
Sent: Tuesday, March 26, 2019 5:25 AM
To: linux-kernel@vger.kernel.org
Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.co=
m>; Stephen Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.=
org>; linux-hyperv@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>=
; Tianyu Lan <Tianyu.Lan@microsoft.com>; Joerg Roedel <jroedel@suse.de>
Subject: Bad file pattern in MAINTAINERS section 'Hyper-V CORE AND DRIVERS'

A file pattern line in this section of the MAINTAINERS file in linux-next d=
oes not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted o=
r renamed in some other commit.

The commits that added and if found renamed or removed the file pattern are=
 shown below.

Please fix this defect appropriately.

1: ------------------------------------------------------------------------=
---

linux-next MAINTAINERS section:

	7164	Hyper-V CORE AND DRIVERS
	7165	M:	"K. Y. Srinivasan" <kys@microsoft.com>
	7166	M:	Haiyang Zhang <haiyangz@microsoft.com>
	7167	M:	Stephen Hemminger <sthemmin@microsoft.com>
	7168	M:	Sasha Levin <sashal@kernel.org>
	7169	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
	7170	L:	linux-hyperv@vger.kernel.org
	7171	S:	Supported
	7172	F:	Documentation/networking/device_drivers/microsoft/netvsc.txt
	7173	F:	arch/x86/include/asm/mshyperv.h
	7174	F:	arch/x86/include/asm/trace/hyperv.h
	7175	F:	arch/x86/include/asm/hyperv-tlfs.h
	7176	F:	arch/x86/kernel/cpu/mshyperv.c
	7177	F:	arch/x86/hyperv
	7178	F:	drivers/hid/hid-hyperv.c
	7179	F:	drivers/hv/
	7180	F:	drivers/input/serio/hyperv-keyboard.c
	7181	F:	drivers/pci/controller/pci-hyperv.c
	7182	F:	drivers/net/hyperv/
	7183	F:	drivers/scsi/storvsc_drv.c
	7184	F:	drivers/uio/uio_hv_generic.c
	7185	F:	drivers/video/fbdev/hyperv_fb.c
-->	7186	F:	drivers/iommu/hyperv_iommu.c
	7187	F:	net/vmw_vsock/hyperv_transport.c
	7188	F:	include/linux/hyperv.h
	7189	F:	include/uapi/linux/hyperv.h
	7190	F:	tools/hv/
	7191	F:	Documentation/ABI/stable/sysfs-bus-vmbus

2: ------------------------------------------------------------------------=
---

The most recent commit that added or modified file pattern 'drivers/iommu/h=
yperv_iommu.c':

commit 32d5860a9e3c98b5043716fff05a7b20b15918f9
Author: Lan Tianyu <Tianyu.Lan@microsoft.com>
Date:   Wed Feb 27 22:54:05 2019 +0800

    MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS sco=
pe
   =20
    This patch is to add Hyper-V IOMMU driver file into Hyper-V CORE and
    DRIVERS scope.
   =20
    Reviewed-by: Michael Kelley <mikelley@microsoft.com>
    Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
    Signed-off-by: Joerg Roedel <jroedel@suse.de>

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

3: ------------------------------------------------------------------------=
---

No commit with file pattern 'drivers/iommu/hyperv_iommu.c' was found
