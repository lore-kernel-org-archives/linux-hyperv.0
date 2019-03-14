Return-Path: <SRS0=/bEP=RR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBCC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D10D2087C
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 14:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m+I+tD77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCNO5D (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:57:03 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:19055
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbfCNO5D (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Mar 2019 10:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1BW8XP2CvYd+BJDozFMywZUxRjst+0+JZdqMmeoXkM=;
 b=m+I+tD77Z0khOSuT9squa7X83pWG9U99hAC/msTZgZ/RbUS+nD6Mu1bWUO0GCTLl4NiSY783lbu/e79q8w2YYjTqJT2e+j83IerUYRRrCOEm4sMjOmNn3Em8jLvTz2+4MTYCcStaAxatYckfSSd0NDew5Vax4jldNV39d172cWA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Thu, 14 Mar 2019 14:57:00 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9595:af36:ad4:ab7d]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9595:af36:ad4:ab7d%9]) with mapi id 15.20.1730.003; Thu, 14 Mar 2019
 14:57:00 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyperv: a potential NULL pointer dereference
Thread-Topic: [PATCH] hyperv: a potential NULL pointer dereference
Thread-Index: AQHU2ilZRp8CWZZ0pke1kYNV+eQu/KYLMX6w
Date:   Thu, 14 Mar 2019 14:56:59 +0000
Message-ID: <CY4PR21MB0773FB535B3F4177CA9662C0A04B0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20190314054651.1315-1-kjlu@umn.edu>
In-Reply-To: <20190314054651.1315-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:9:6d92:a6c2:4a8e:3bad]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a20201fa-3e9d-4644-c7c8-08d6a88d4fad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790067CD84A91383C0EC340A04B0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(13464003)(199004)(189003)(8990500004)(9686003)(7416002)(8676002)(10290500003)(81156014)(55016002)(6436002)(6916009)(486006)(6246003)(476003)(52536014)(53936002)(81166006)(2171002)(25786009)(7696005)(71190400001)(71200400001)(86612001)(99286004)(2906002)(86362001)(186003)(68736007)(256004)(97736004)(316002)(102836004)(7736002)(33656002)(6346003)(54906003)(4326008)(14444005)(76176011)(74316002)(8936002)(6116002)(6506007)(5660300002)(53546011)(46003)(446003)(105586002)(10090500001)(229853002)(11346002)(106356001)(478600001)(305945005)(22452003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IX30NSLq+c8q0mgTX74bl+lGNxT5XWS21nNYIxwgYgL+WgP7dO3Nmn9UeA14yiNV6SZKFkJegIfddLcJSrOJ9r0rKaCuv0Ci/8/+YX7tyKNzbXhADrGqiD5EdlfX7V2rhcu7EhYTTFycqFkjk3ImYOkxoDgk66g2N95emKYUvHlxaeBhekyuXXLhuMU+Lywbs8lhcam9GSAcKGfq7pxrFNq3v6K/CbzuJ2iQUNj7mZEn8ot30Dob/LBv2GaXCTSuzJHYtT33DN7lVGjjlBKBHj9xKRyow0zSc2m65dsBAbEupH98/795tWQV56XK3ePaccmJ/+RAA+BeM4mteNo4CUD7+fo0XKWAMwo0V0DOIDFLGMPU4c8s48/YKTroQvM4yYASZw5YYzT7qG9P6tON1CXEPVKetUHcc/rnjwGLck8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20201fa-3e9d-4644-c7c8-08d6a88d4fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 14:56:59.9337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Kangjie Lu <kjlu@umn.edu>
> Sent: Wednesday, March 13, 2019 10:47 PM
> To: kjlu@umn.edu
> Cc: pakki001@umn.edu; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Thomas
> Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav
> Petkov <bp@alien8.de>; H. Peter Anvin <hpa@zytor.com>; x86@kernel.org;
> linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] hyperv: a potential NULL pointer dereference
>=20
> In case alloc_page, the fix returns -ENOMEM to avoid the potential
> NULL pointer dereference.
>=20
Thanks.

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

> ---
>  arch/x86/hyperv/hv_init.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7abb09e2eeb8..dfdb4ce1ae9c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -102,9 +102,13 @@ static int hv_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	struct hv_vp_assist_page **hvp =3D
> &hv_vp_assist_page[smp_processor_id()];
>  	void **input_arg;
> +	struct page *pg;
>=20
>  	input_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	*input_arg =3D page_address(alloc_page(GFP_KERNEL));
> +	pg =3D alloc_page(GFP_KERNEL);
> +	if (unlikely(!pg))
> +		return -ENOMEM;
> +	*input_arg =3D page_address(pg);
>=20
>  	hv_get_vp_index(msr_vp_index);
>=20
> --
> 2.17.1

