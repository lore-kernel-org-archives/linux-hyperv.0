Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1851DC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE6021773
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X1wk0xlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfC1TAW (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:00:22 -0400
Received: from mail-eopbgr680101.outbound.protection.outlook.com ([40.107.68.101]:64128
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfC1TAW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 15:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY6JkmY8WMNsq9fC7/XPER6FNpVtAVUyQ1CR5k+vwiQ=;
 b=X1wk0xlp5CMB4GlJVgn5gYGuPdKa1d8btS9K9JezV84ji1dh43RiCB+4O904yw63v/gLK7doEK8z5C7PGUCvJ/4Zt1pzIYNT6A51XzKsJSphDISqpS72VBzdetVpECbiotxrd3RhMSQek77vBO7IDMcdEW/gORzNNJQ7dcHlrUw=
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ZIk3+KCnVvuJFZBhlqCgoOrellwFHcufiVDKSt0J5EDJR/NrvrgUaCLs1xNE4/YNqvBb6G1j1HfmBpBsBemR4Wj251QexPChOaNR59wEL/7WEewlirLcXQafruljP3xCSpupTF6ZsibxLuGes3XxSnzOF6xnpqQWutxQgg2sBCo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY6JkmY8WMNsq9fC7/XPER6FNpVtAVUyQ1CR5k+vwiQ=;
 b=PdtYomEibLc1ggnSH53cwxCUQcTVp+2Q+zZlXVAoehqokYQareWc4xsmQoKIOqr3ZWfElts09AhSN60zAwbWLUapAXiyS0ggXNo2BaSRTGdleBKvbXmga4QMMbLIJmaqciiEReBN63k3UwCrDginXQkAjgZ0PIK1kQoInbkIjYo=
ARC-Authentication-Results: =?us-ascii?Q?i=3D1;_test.office365.com_1;=0D=0A=09=09dmarc=3Dnone_action?=
 =?us-ascii?Q?=3Dnone_header.from=3Dmicrosoft.com;=0D=0A=09=09arc=3Dnone?=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1273.namprd21.prod.outlook.com (20.179.51.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.4; Thu, 28 Mar 2019 19:00:18 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a8f3:221a:ccfe:f049%8]) with mapi id 15.20.1771.007; Thu, 28 Mar 2019
 19:00:18 +0000
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
Subject: RE: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Thread-Topic: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Thread-Index: AQHU5Y6yCEd0RmutM0qGiubebdJ5HaYhX7uAgAAB3SA=
Date:   Thu, 28 Mar 2019 19:00:18 +0000
Message-ID: <DM6PR21MB1337250A47CEE73D1EFE0AB7CA590@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
 <20190328113823.3c9b3599@shemminger-XPS-13-9360>
In-Reply-To: <20190328113823.3c9b3599@shemminger-XPS-13-9360>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-28T19:00:16.3869492Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=956a15e3-99e3-44b7-973e-d709cb7cf7b4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff398a7b-2acd-43ee-4e04-08d6b3af9ed9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1273;
x-ms-traffictypediagnostic: DM6PR21MB1273:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1273481E573173A2905FBFA6CA590@DM6PR21MB1273.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(13464003)(189003)(2906002)(110136005)(14454004)(478600001)(86612001)(446003)(4326008)(316002)(486006)(8936002)(10090500001)(54906003)(86362001)(25786009)(476003)(229853002)(8990500004)(81156014)(81166006)(11346002)(8676002)(256004)(106356001)(74316002)(10290500003)(22452003)(305945005)(71190400001)(105586002)(71200400001)(14444005)(97736004)(55016002)(3846002)(33656002)(7736002)(9686003)(5660300002)(6436002)(6116002)(99286004)(102836004)(68736007)(52536014)(26005)(53546011)(53936002)(76176011)(6246003)(7696005)(66066001)(186003)(6506007)(26123001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1273;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BeBY4eNF1rev42tvytKsrFvryxxkjgwItGQY5SRvefSIYQWGdHv9/a08ZNdCRV9Gdl9D2DaunwtxDMPrn2vGYD3h3xAOKUBqwAjZzQPMCNejrdBEEUbqpDvpl3YLkXS6TRnqkKaH09G7RKGKQhgwuXbU7Up40wU2YVwzZl8TRzOCWZJ1goue6UPF0pGw0+xmrRrDVuuxuIues0ibVaWHQoootCcy3iQi7RameYGzSGs+HskrnXTDtn9AjQPGOjYHmNS1fI2ygA9GNinBf+2uicwY4zEoihqnPXIlFxpUokAhVxfDUF3H9zRc2b1j4s+h6XXde8Uy+vTjVOojDPpxsmgAVvsOYylyB/jzuVOrms7Aj57fRc46WV1j39/kuInoZU2/ttmby+Lw9M+DXvYI5aYLKpPK0KZeI/DCH2Ke+MI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff398a7b-2acd-43ee-4e04-08d6b3af9ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 19:00:18.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1273
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, March 28, 2019 2:38 PM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: sashal@kernel.org; linux-hyperv@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
> tx_disable
>=20
> On Thu, 28 Mar 2019 17:48:45 +0000
> Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
>=20
> > +static inline void netvsc_tx_enable(struct netvsc_device *nvscdev,
> > +				    struct net_device *ndev)
> > +{
> > +	nvscdev->tx_disable =3D false;
> > +	mb(); /* ensure queue wake up mechanism is on */
> > +
> > +	netif_tx_wake_all_queues(ndev);
> > +}
>=20
> You don't need a full mb(). virt_wmb() should be sufficient.

I will make this change.=20

> Could I suggest an alternative approach.
> You don't need to introduce a local tx_disable flag, the only place where=
 a
> wakeup could cause problems is after a send_completion was processed
> during detach state.
>=20
> Instead, just avoid wakeup in that place.

In netvsc_detach(), after netif_tx_disable(), we call  netvsc_wait_until_em=
pty(nvdev);
TX patch should not be waken up again while waiting for in/out ring to beco=
mes empty.

In my tests before this patch, there are wakeup happens before netif_device=
_detach(),=20
so netif_device_present(ndev) is still true at that time.

In other places, like netvsc_close(), link_change(), we also don't want wak=
eup after tx_disable.

Thanks.
- Haiyang

>=20
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -720,6 +720,7 @@ static void netvsc_send_tx_complete(struct
> net_device *ndev,
>                 struct netdev_queue *txq =3D netdev_get_tx_queue(ndev, q_=
idx);
>=20
>                 if (netif_tx_queue_stopped(txq) &&
> +                   netif_device_present(ndev) &&
>                     (hv_get_avail_to_write_percent(&channel->outbound) >
>                      RING_AVAIL_PERCENT_HIWATER || queue_sends < 1)) {
>                         netif_tx_wake_queue(txq);
