Return-Path: <SRS0=S9PY=Q6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A9C4360F
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 17:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BD6206A3
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 17:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P0HAoGCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBWR3P (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:29:15 -0500
Received: from mail-eopbgr680107.outbound.protection.outlook.com ([40.107.68.107]:33055
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfBWR3P (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 Feb 2019 12:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l88/V3oIqHqT7BJnk2yMKqp4SSQ29GlXX2ft+eerh0=;
 b=P0HAoGCrdvk9TEl6cRL8+9PHBoiaNg8qH3t+N3vCLNfPl0gRKOZH/wYTvVc2sv+0MrwRkVSBUKd+zBZCjvZMt5SmvaIXJ3sSuzMiDLNeWR6ppyt7MdFpDrVmDZcPX3wKSm/JrraqXpY5hV6RUH6/SjHA/00hQuuML0sirfw35MQ=
Received: from BN6PR21MB0114.namprd21.prod.outlook.com (10.173.199.140) by
 BN6PR21MB0788.namprd21.prod.outlook.com (10.175.132.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.2; Sat, 23 Feb 2019 17:29:10 +0000
Received: from BN6PR21MB0114.namprd21.prod.outlook.com
 ([fe80::943d:65ab:dc08:a633]) by BN6PR21MB0114.namprd21.prod.outlook.com
 ([fe80::943d:65ab:dc08:a633%14]) with mapi id 15.20.1665.008; Sat, 23 Feb
 2019 17:29:10 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Haiyang Zhang <haiyangz@linuxonhyperv.com>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes] hv_netvsc: Fix IP header checksum for
 coalesced packets
Thread-Topic: [PATCH hyperv-fixes] hv_netvsc: Fix IP header checksum for
 coalesced packets
Thread-Index: AQHUytwrKQKuQINSEEGv6EaofC/+e6XtmOcAgAAIlvA=
Date:   Sat, 23 Feb 2019 17:29:10 +0000
Message-ID: <BN6PR21MB0114A6A07A74EB5F8300DDA7CA780@BN6PR21MB0114.namprd21.prod.outlook.com>
References: <20190222182503.12160-1-haiyangz@linuxonhyperv.com>
 <20190223084624.0d0c60a0@shemminger-XPS-13-9360>
In-Reply-To: <20190223084624.0d0c60a0@shemminger-XPS-13-9360>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-23T17:29:07.4734457Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9cb1f404-45ff-40e1-ad48-7bf7e76f77e9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3edf2ede-25d3-4702-31e1-08d699b46be8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR21MB0788;
x-ms-traffictypediagnostic: BN6PR21MB0788:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BN6PR21MB0788;23:NYAYWKvPMmuJ5+lcWS09vdOjWmXNtaJrjFJMD/tlH?=
 =?us-ascii?Q?vVWZLjgDta2/D0Oo3xX9WR5BMD5O9/UpnaSfox8n131WpgITuaBDQ3ATEEpT?=
 =?us-ascii?Q?KcUutoiZVHIbFozWZBm7xPG3zwA5NtWJDwo0vKOXdxtRhCw1QEIEbisDZWiU?=
 =?us-ascii?Q?QZVICj8aFDICKTXf4cHowdjO8eIj8+LSO+USuHRjlUPKloAVnCfffly88jnj?=
 =?us-ascii?Q?iikAhFtaNFEUL+9xtA2RF7GE7QPNuhKkLU9TuRUuRMNHqewYJN+J2goMWC01?=
 =?us-ascii?Q?jpqa1wxQP6EsFbM9aOJN6rQQ/Qpj7p3/JH6ehdSGmOPefSY4ilWG+F4W/4L5?=
 =?us-ascii?Q?apHAUHY1meWgT3skBlnVbTlvK1pxXK5j7b9Th2xI6/x6+z+lI5WxpFk+WBWs?=
 =?us-ascii?Q?aHaAre0UfjqBw6NuyHxUQ5SLkOdECrBVki+zgWBvZSH+uujY/ccylRnsKMlj?=
 =?us-ascii?Q?KEilUDdFL2XVu8ELn8hornX9AqxHhmi3QEoqxpzLOW+M2+Gexq0rKQ6tjR6e?=
 =?us-ascii?Q?SWF+Zgk/P1VxCbsQZjz/vK5GHLE51tTXDrlpQQtHu4wTLuWUia0hhdg5c/MP?=
 =?us-ascii?Q?v9f4GNzfNOg4Lxainq3AQEOzsSwT89pmNZKJWc875KtTCllE8ZZq41ycJmTe?=
 =?us-ascii?Q?qh/K8XWkJG0ljqdQn0hsjehH3Hp2sM08gtCn6uwt/DT2EcIn3YkEb1DSOZAQ?=
 =?us-ascii?Q?hMgTZqCEcilPJdxwckRTGMmRXzSScb7vqjV7JSkRWRRyYC7SJo3wJn37Bu9b?=
 =?us-ascii?Q?8AhF8FrDfxq//hudR8iqmPOV0AgB3fHfqJO3GYWd8z/LvdHdKz+mwXCHZ42b?=
 =?us-ascii?Q?PdxGupqck0cvO3zQIgNF3FI7IPpG20V4Vuj2cq9iUy/ulJj1Unwvq3BTRTXH?=
 =?us-ascii?Q?FQa89Whl70+ETQNK4sjDX1WDBy/ZNhtsG5qbBoAkqmo2xPXe99loxyPP5kjv?=
 =?us-ascii?Q?6m1YoN6LffPg8f6LCXNmaXsy/s5nXWeRwkf5ec+g3/IXcz398ZC0rfyi/Bg2?=
 =?us-ascii?Q?dOaS1NLZl1OOD/t59T7L+IQpMa+gpuKcb0sshwV8ZzPuzHp59/rU46wmT8/g?=
 =?us-ascii?Q?S+/PtyvWjVUfKrveouunr0Oox4ydVmNPxG8e0xewvklcQVe38w8tccieqQeB?=
 =?us-ascii?Q?Dsfga6JEM1y+TyV5XkW3gBhu5CHqOR7rRqXhFnGUqo5tYOQDEYLhWys7q0lW?=
 =?us-ascii?Q?PvoDLmuFh9o8DUCa6C8M0tIYGq6wwyKo9XqjV1Lgjx+swa/OMMHoeV17SYzh?=
 =?us-ascii?Q?4aQQAGJ1UroUF7meEFp/GQgoVNGz1/p5Ziv9UGGlqyhHwnuzo9saY3Nj/OfE?=
 =?us-ascii?Q?zZCbqrzdYCl1mzM+dBIs32wN12Fie2jKFVIYEHhyN+eRYEyGCZQ4Ox3vgyke?=
 =?us-ascii?Q?CksHEGimQtHbBbAXbvxUOjRBrUuWo2aoFkiGV1UWoxFpuz+q2ebwCfzpDvIR?=
 =?us-ascii?Q?Ze3Qf4Mh2tK7cjs7PjaM+mkU3QtbuQ=3D?=
x-microsoft-antispam-prvs: <BN6PR21MB07887A5718FFFC180ED977FACA780@BN6PR21MB0788.namprd21.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(13464003)(199004)(189003)(186003)(86362001)(6346003)(14454004)(6116002)(3846002)(74316002)(966005)(86612001)(22452003)(81166006)(81156014)(316002)(8990500004)(33656002)(8676002)(99286004)(478600001)(7736002)(305945005)(4326008)(486006)(6246003)(11346002)(53546011)(6506007)(102836004)(26005)(476003)(446003)(97736004)(53936002)(229853002)(10290500003)(66066001)(68736007)(25786009)(6436002)(105586002)(106356001)(5660300002)(2906002)(52536013)(9686003)(256004)(55016002)(6306002)(54906003)(110136005)(71200400001)(71190400001)(7696005)(76176011)(8936002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0788;H:BN6PR21MB0114.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1rLSMAvYKIB1JwQe/wl4ZsFk7s6QStQghgbkPUQbeUbVzHQc/WxpJ1k3jimyev3wy1SIPlLeFoJSiFo82ciBWgalYnGu0l1tfB4zDzOvP2EOMQzG26UnLOHam4PIHh1KGfZiXoLNHQRaFBDCQcCgZ49NW+2NidWSOq6/xDZmMJ2pbHEU5JzI+abE4BhXPi1VITVmrnY16hXMKB/pSXUTkfzdg3AV6qBlFi2xY2/RQMt7cMl1DYPyS0pcOOL4XSFzzcjpZ6fvjKfrH+YVXi0+dS4+0p9uAkb1qFvxLR+vRQEpmCWojTvUV96qARknO8diwmX42CKwZBF7YiMcsK+y1jUP1ZxW/cVD1GVA/whBzAVqX5c6AfrFDYrkgHIYHMIpsnUBdO6e9z7QqVNyF7M1ilPXE5Tkv2liypjKccdF2s8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edf2ede-25d3-4702-31e1-08d699b46be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 17:29:10.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0788
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Saturday, February 23, 2019 11:46 AM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; sashal@kernel.org; linux-
> hyperv@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix IP header checksum for
> coalesced packets
>=20
> On Fri, 22 Feb 2019 18:25:03 +0000
> Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
>=20
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Incoming packets may have IP header checksum verified by the host.
> > They may not have IP header checksum computed after coalescing.
> > This patch re-compute the checksum when necessary, otherwise the
> > packets may be dropped, because Linux network stack always checks it.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/netvsc_drv.c
> > b/drivers/net/hyperv/netvsc_drv.c index 256adbd044f5..cf4897043e83
> > 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -744,6 +744,14 @@ void netvsc_linkstatus_callback(struct net_device
> *net,
> >  	schedule_delayed_work(&ndev_ctx->dwork, 0);  }
> >
> > +static void netvsc_comp_ipcsum(struct sk_buff *skb) {
> > +	struct iphdr *iph =3D (struct iphdr *)skb->data;
>=20
> Can you use iphdr(skb) here?
This skb is just allocated by netvsc, the skb->network_header is not set ye=
t.

>=20
> > +
> > +	iph->check =3D 0;
> > +	iph->check =3D ip_fast_csum(iph, iph->ihl); }
> > +
> >  static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
> >  					     struct netvsc_channel *nvchan)
> { @@ -770,9 +778,17 @@
> > static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
> >  	/* skb is already created with CHECKSUM_NONE */
> >  	skb_checksum_none_assert(skb);
> >
> > -	/*
> > -	 * In Linux, the IP checksum is always checked.
> > -	 * Do L4 checksum offload if enabled and present.
> > +	/* Incoming packets may have IP header checksum verified by the
> host.
> > +	 * They may not have IP header checksum computed after coalescing.
> > +	 * We compute it here if the flags are set, because on Linux, the IP
> > +	 * checksum is always checked.
> > +	 */
> > +	if (csum_info && csum_info->receive.ip_checksum_value_invalid &&
> > +	    csum_info->receive.ip_checksum_succeeded &&
> > +	    skb->protocol =3D=3D htons(ETH_P_IP))
> > +		netvsc_comp_ipcsum(skb);
>=20
> Does this still handle for coalesced and non-coalesced packets which are
> received with bad IP checksum?  My concern is that you are potentially
> correcting the checksum for a packet whose received checksum was bad.

Windows networking team told me that the flags above indicate host side=20
already verified the checksum. Online doc is here:
https://docs.microsoft.com/en-us/windows-hardware/drivers/network/indicatin=
g-coalesced-segments
If the NIC or miniport driver validates the TCP and IPv4 checksums but does=
 not recompute them for the coalesced segment, it must set the TcpChecksumV=
alueInvalid and IpChecksumValueInvalid flags in the NDIS_TCP_IP_CHECKSUM_NE=
T_BUFFER_LIST_INFO structure. Additionally, in this case the NIC or minipor=
t driver may optionally zero out the TCP and IPv4 header checksum values in=
 the segment.

The NIC and miniport driver must always set the IpChecksumSucceeded and Tcp=
ChecksumSucceeded flags in the NDIS_TCP_IP_CHECKSUM_NET_BUFFER_LIST_INFO st=
ructure before indicating the coalesced segment.

Thanks,
- Haiyang

