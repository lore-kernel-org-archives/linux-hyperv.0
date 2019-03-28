Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18159C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEED2173C
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GZofP13G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfC1T7J (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:59:09 -0400
Received: from mail-eopbgr700091.outbound.protection.outlook.com ([40.107.70.91]:26988
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbfC1T7J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 15:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQshc3/5uYAYoIMKyIc6lsHJfIZlDsaCsfQlo+M+SUk=;
 b=GZofP13G1xXjphZe2dyalSLtFSAAvbV8I7k/A0r27RNxnQH3hOyt797ifj0ZJAkAgvimfYFL9wtrOvty1cbHwoTUS4jpkhV1XxoFh5oPvvWtx46E+gvBtTQZa/ZvbA6uaZ3fOQIv+GpVXkPrSQLKGgB0e1ZNSVpEph0yqRIAZxE=
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ZBpnawZ2xJIZicbbbXOowTrSCQjN4DK3u1Waiu/p0xi2MmqNci4rq8QsLbFfPTe6gf6qLW8bDmKvh9ZNhc1B28Gn8gQhno79N7QO4EE35UOmxhQe9Y+83Wbd/QgulIQNfONYiIp9v4OwHgjfLopLFrWnaY1ennUKFqTJK6t7EL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQshc3/5uYAYoIMKyIc6lsHJfIZlDsaCsfQlo+M+SUk=;
 b=uw8cvcpAdS58m51IYUAKkjG+vliXTw3YQskWmi9JQsGnBfgjvFasH3Or7hEmRGPcQacD3DrH+qmDHgGQn3qpjtyEC7s2AmPdzAjbYhdLTIgkJDiqMS7P8ze51talt+pORSAAYzUntKhe8FjeKluu+4ESTZjG12C1rr8w7XolEyM=
ARC-Authentication-Results: =?us-ascii?Q?i=3D1;_test.office365.com_1;=0D=0A=09=09dmarc=3Dnone_action?=
 =?us-ascii?Q?=3Dnone_header.from=3Dmicrosoft.com;=0D=0A=09=09arc=3Dnone?=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1241.namprd21.prod.outlook.com (20.179.50.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.2; Thu, 28 Mar 2019 19:59:05 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049%8]) with mapi id 15.20.1771.007; Thu, 28 Mar 2019
 19:59:05 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Thread-Topic: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Thread-Index: AQHU5Y6yCEd0RmutM0qGiubebdJ5HaYhX7uAgAAB3SCAAA/vgIAAAuNg
Date:   Thu, 28 Mar 2019 19:59:05 +0000
Message-ID: <DM6PR21MB13373F19D06D1FB27B65A9F6CA590@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
        <20190328113823.3c9b3599@shemminger-XPS-13-9360>
        <DM6PR21MB1337250A47CEE73D1EFE0AB7CA590@DM6PR21MB1337.namprd21.prod.outlook.com>
 <20190328124205.42f5f337@shemminger-XPS-13-9360>
In-Reply-To: <20190328124205.42f5f337@shemminger-XPS-13-9360>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-28T19:59:02.1667228Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d2617ba-bcbb-4296-b2e6-29b7d9ef9028;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb24fa0a-4973-4654-3b97-08d6b3b7d50b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1241;
x-ms-traffictypediagnostic: DM6PR21MB1241:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB124117C4D678D7FCAAB944CFCA590@DM6PR21MB1241.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(13464003)(71200400001)(229853002)(74316002)(68736007)(8990500004)(305945005)(6916009)(7736002)(6436002)(81156014)(446003)(8676002)(71190400001)(81166006)(11346002)(26005)(97736004)(14444005)(256004)(52536014)(478600001)(86612001)(6246003)(66066001)(55016002)(9686003)(53936002)(4326008)(86362001)(22452003)(5660300002)(6116002)(476003)(33656002)(54906003)(10090500001)(186003)(25786009)(10290500003)(14454004)(7696005)(106356001)(6506007)(53546011)(316002)(8936002)(6346003)(76176011)(105586002)(102836004)(2906002)(3846002)(486006)(93886005)(99286004)(26123001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1241;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tsIL0N7kwi+82B1xBil0RzIRPadrwCvD4j852LQkmpaTRRVsWB8AY6l0CwCRMpVSgdSLf3BRyfGMllmPJNtLwaGTy/ridL3MisqDv2L5d5JDjxC01f7nHRabHH024MwsKLneEhIBe9L2xxgnoNuqjhSFDCpcnegX3b3Tev4dkvIkTOUlvag1iS0U4TUoDYKDWci1vb+0UQRIVz51XMLIGNQGSQQLOohnh6wYjcJz84+UfTpzQq52x9gpvKNs28ejDGsRWYrdbT26iXj0uCWo2siTxJN0r2IKJNJfGHRyUbH3j6+g/Hco6GuneDWMnpScpSb21fti7NY90il2Gt7NAmUQO21/SHkoukLlhilUROF2Hsz+yzNnkWpGogBarWSAICwXNx9sC5qSQVfQl6luEmi/xsAplyNGCbcaq39Ju7M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb24fa0a-4973-4654-3b97-08d6b3b7d50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 19:59:05.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1241
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, March 28, 2019 3:42 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@linuxonhyperv.com>; sashal@kernel.org;
> linux-hyperv@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
> tx_disable
>=20
> On Thu, 28 Mar 2019 19:00:18 +0000
> Haiyang Zhang <haiyangz@microsoft.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > Sent: Thursday, March 28, 2019 2:38 PM
> > > To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> > > Cc: sashal@kernel.org; linux-hyperv@vger.kernel.org; Haiyang Zhang
> > > <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Stephen
> > > Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets
> > > <vkuznets@redhat.com>; davem@davemloft.net;
> netdev@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup
> > > after tx_disable
> > >
> > > On Thu, 28 Mar 2019 17:48:45 +0000
> > > Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
> > >
> > > > +static inline void netvsc_tx_enable(struct netvsc_device *nvscdev,
> > > > +				    struct net_device *ndev)
> > > > +{
> > > > +	nvscdev->tx_disable =3D false;
> > > > +	mb(); /* ensure queue wake up mechanism is on */
> > > > +
> > > > +	netif_tx_wake_all_queues(ndev);
> > > > +}
> > >
> > > You don't need a full mb(). virt_wmb() should be sufficient.
> >
> > I will make this change.
> >
> > > Could I suggest an alternative approach.
> > > You don't need to introduce a local tx_disable flag, the only place
> > > where a wakeup could cause problems is after a send_completion was
> > > processed during detach state.
> > >
> > > Instead, just avoid wakeup in that place.
> >
> > In netvsc_detach(), after netif_tx_disable(), we call
> > netvsc_wait_until_empty(nvdev); TX patch should not be waken up again
> while waiting for in/out ring to becomes empty.
> >
> > In my tests before this patch, there are wakeup happens before
> > netif_device_detach(), so netif_device_present(ndev) is still true at t=
hat
> time.
> >
> > In other places, like netvsc_close(), link_change(), we also don't want
> wakeup after tx_disable.
> >
> > Thanks.
> > - Haiyang
> >
> > >
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -720,6 +720,7 @@ static void netvsc_send_tx_complete(struct
> > > net_device *ndev,
> > >                 struct netdev_queue *txq =3D netdev_get_tx_queue(ndev=
,
> > > q_idx);
> > >
> > >                 if (netif_tx_queue_stopped(txq) &&
> > > +                   netif_device_present(ndev) &&
> > >                     (hv_get_avail_to_write_percent(&channel->outbound=
) >
> > >                      RING_AVAIL_PERCENT_HIWATER || queue_sends < 1)) =
{
> > >                         netif_tx_wake_queue(txq);
>=20
>=20
> Then what about doing netif_detach earlier in netvsc_detach.
>=20
> The state management is already (too) complex in netvsc and adding anothe=
r
> boolean flag just makes it harder to understand.

If we move netif_device_detach() before the netvsc_wait_until_empty(), the =
remaining
Packets in the receive buffer will be passed to a detached device.

Also, in case of netvsc_close() and link_change(), we don't call netif_devi=
ce_detach().

Thanks,
- Haiyang
