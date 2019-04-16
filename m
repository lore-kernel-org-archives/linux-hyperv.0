Return-Path: <SRS0=WJYP=SS=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B6DC10F0E
	for <linux-hyperv@archiver.kernel.org>; Tue, 16 Apr 2019 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D600C20830
	for <linux-hyperv@archiver.kernel.org>; Tue, 16 Apr 2019 00:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gllxtp3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfDPAVN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:21:13 -0400
Received: from mail-eopbgr760135.outbound.protection.outlook.com ([40.107.76.135]:17231
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfDPAVN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Apr 2019 20:21:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=kjBhEvUt/s/57FwCXkAMhSegJB5/LdEPFXSWJ8FzNkCSt5v4Gk1dL8CVLvw4PKuehmWmysOWGXdxuCjJF3EM2f9TgRY3dHPGNraEUu4R+GOedXZ90gxttekSOUMOW/GPnto+WqdR0/bNjt5syokaNq/f8ZZLxlYYvdH0ZeBR0IOtre/Q/bc6CBJcorNGRc8ogugQ0NH8fudXExrTZBT7VcafPnQDj1vlVS6YpDiOb4neiseXlsBgNsuMawEN62+Li9pF9XuoA1vaa+NBn1MGvZxTBlT8KLHWieXHxnw5guaUBGH3X0F4F224w4fNiz1VAUsfQ65jNGrqtW231k/oDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxct50eLRS23kU3L9Iyi1oINhc7pvQwAIOace5moelg=;
 b=IoQnDEeY1/9wy5uVmfvjGfw00iFlu4zkmT05U7/eMDVVe50TRe42/eYwAkOHGiMx7LgpBbUu+og3i66vZl90UJbhXqb/+m+fQxoH3VBJvAgNOgZsjR9xRzaU6c/Zsp3uZluGq0i6Nz2ErNWJ4kkkzRcilVxmji6YrXiX8dQDra9wWnEmdo6rFd3Hc8zFlqbVNv7Jh7PH10CUgCxrLPRRX51n/iKWml5c0OWcWWf8BbIxLO5spP3BfkiLMkBtljr3TUeKgoJhajb3aVckFPicA8Y0CyLp6FZZE2Z8uuwN2smZHcFwEimhXKkzvzEYTQpLvoyHfNzFKzF0P5I9H3XI3Q==
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxct50eLRS23kU3L9Iyi1oINhc7pvQwAIOace5moelg=;
 b=gllxtp3ST932KjBigPjjJAlGuNvUFZ/w62LiEt2PS9b24IvqpoCNOATNlZxz1fxj7LXBo4k2ECQv+YG7DdbXb8b3O0hJPO4XSHvT7dCUY5bZwcvKH7PbHcgIg7xlypV+g7EmE9SPkSuS/OvpL4j0jgJ3jsZvIr9c1449u3yz6Xg=
Received: from DM5PR21MB0635.namprd21.prod.outlook.com (10.175.111.142) by
 DM5PR21MB0779.namprd21.prod.outlook.com (10.173.172.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.2; Tue, 16 Apr 2019 00:21:10 +0000
Received: from DM5PR21MB0635.namprd21.prod.outlook.com
 ([fe80::b556:a858:3397:38a]) by DM5PR21MB0635.namprd21.prod.outlook.com
 ([fe80::b556:a858:3397:38a%5]) with mapi id 15.20.1835.000; Tue, 16 Apr 2019
 00:21:10 +0000
From:   Long Li <longli@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Simon Xiao <sixiao@microsoft.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] x86/hyper-v: implement EOI assist
Thread-Topic: [PATCH] x86/hyper-v: implement EOI assist
Thread-Index: AQHU6j8iVyBUPz6L9EOK1qqV/Nj/s6Y9OLgAgADGgJA=
Date:   Tue, 16 Apr 2019 00:21:10 +0000
Message-ID: <DM5PR21MB06351F098A8536E7E2BB68A4CE240@DM5PR21MB0635.namprd21.prod.outlook.com>
References: <20190403170309.4107-1-vkuznets@redhat.com>
 <87v9zfh2rr.fsf@vitty.brq.redhat.com>
In-Reply-To: <87v9zfh2rr.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b1ad6db-d1e6-452e-98ce-08d6c2016d4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0779;
x-ms-traffictypediagnostic: DM5PR21MB0779:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB077964405CDA41A9B4333180CE240@DM5PR21MB0779.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(54906003)(1511001)(6436002)(22452003)(52536014)(8990500004)(7696005)(316002)(4744005)(6116002)(25786009)(9686003)(8936002)(256004)(55016002)(76176011)(2906002)(33656002)(68736007)(106356001)(110136005)(5660300002)(97736004)(6506007)(71190400001)(53936002)(14454004)(486006)(71200400001)(86612001)(105586002)(478600001)(476003)(99286004)(7736002)(186003)(229853002)(8676002)(446003)(81156014)(10290500003)(81166006)(86362001)(74316002)(10090500001)(6246003)(11346002)(6636002)(305945005)(46003)(4326008)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0779;H:DM5PR21MB0635.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 04hBRLa6MIz2TwWcYU4tuA/fhjw6hb/eFilg3jwNmAT7AfORkRMK1OalQW9hK5cU6YEwHuBtfU3tdVlPcminvujZRPgVEOHq2IlwYU3wC45TfZLO5j81N/4FFB5wkG1QgQ18cycpxqfBxB5YG2ULY4Ldgm5DJUZrNeC7ehJy6fr5o4Bk+vaItWnCIWVeQnHmfP/rNsa9iFupzR+0o5ahmVPAhuhZ3z5/g9LbgnuEwx0a7j/j1jlBWhmZpjCP2hsJd/cqLpU14kcsQmhXu6ZqdzjwnkjNhbMwTjxxxBmkcoZ6scDY5x3KI2FtXDdBMn+iTAPEeOGJjv7nkHGa18HsbYz/SA1MX3otRCEcDuJCHnf26PuhfmuNEhRAy5fc36U3g/+3FVvm84thcjd40PYZsk1mxaJbax5USp7pOb9Q2Es=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1ad6db-d1e6-452e-98ce-08d6c2016d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 00:21:10.1623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0779
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>>>Subject: Re: [PATCH] x86/hyper-v: implement EOI assist
>>>
>>>Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>>>
>>>> Hyper-V TLFS suggests an optimization to avoid imminent VMExit on EOI:
>>>> "The OS performs an EOI by atomically writing zero to the EOI Assist
>>>> field of the virtual VP assist page and checking whether the "No EOI
>>>required"
>>>> field was previously zero. If it was, the OS must write to the
>>>> HV_X64_APIC_EOI MSR thereby triggering an intercept into the
>>>hypervisor."
>>>>
>>>> Implement the optimization in Linux.
>>>>
>>>
>>>Simon, Long,
>>>
>>>did you get a chance to run some tests with this?

I have ran some tests on Azure L80s_v2.

With 10 NVMe disks on raid0 and formatted to EXT4, I'm getting 2.6m max IOP=
S with the patch, compared to 2.55m IOPS before.

The VM has been running stable. Thank you!

Tested-by: Long Li <longli@microsoft.com>

>>>
>>>--
>>>Vitaly
