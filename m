Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58A2E739D
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732346; cv=fail; b=qMnKGej2LLOXK9zm5eo3QBfuaC38M+HS+oCrBjW6YJ5gXXcl8NWMATpYvDZNFsjYKmoLng9BilFYHmwnqSkp5qqWwhOIhBrQeLV0E6x3zfdkTxTwmSH7IWyKRhiErauQalSPGyJy7jJk68Hpcv90CJp0uu7g6r7BRGsh330c2YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732346; c=relaxed/simple;
	bh=2NqA60Enbo+lHhfIDFTW/hyyFVVjVnMlnOy258TArBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FjiLzXxbG6NZFoI/aIXsdg9brM0WDjZ+y5thpN2GZAzylN0TfG8IDST4gQh0JFnTiI3Mq3C1XnT3YaLoAKecxnPesrsJRkCeHraOsxQLnlJdNf9cL73Ksx9GNAjN8GqRIGPCUNFOVB8KLSDb1sR7372aseBDE8H3JYLbqwktAM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XAOd5elA; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XAOd5elA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adT+x4LEBtQfvDVNaa8gvVA/oXewaK2IPmF86zIbvtHSlmryFICBIyQOVpMwM+0opoGOTn5lUPbJptCKv3noA3zxZn98HFcWw13TMZpAE9rEUDPM2z76CQc1saP7LUYic0xulHcDDqB1rpjEXUe2CWq6i23eMT+L/rQHVwTfnRijmcOFzfv3E6wnCA9DI5rgaJjSe47yRxTz458Cn9o3vSjisL0Y9pzGlPN48cMp+Ur741ebEprmrBxJsTcKDlT48sEAVjQVx1VdDe0WqiU35WIBdN62mfXB2RK9KXuMa9Wg4Ixuh+09H/MDUqPnqjp92Fhtrlm8tCMdpC6gtElAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT0wdZ+gvJSlHP+wGetTT9INdHgUiANgIahWdByvMI8=;
 b=fSpAoGG/6qvuW6Vu61tJiVQrqwZM36rg9kfJ9Kyo4I8dwL4zU/Hdszs6FCTIWTqj7jNB2VIMVxtHbFzyd4S8vk0h8sZw0LRwiLjr44VNiAKRRodjulsXMK4M0Ecg+r/YE2fK5a0AedYxIW5Ydek+hqLhv5b9V7Qatn6wKGg+ZSLXHVMwbLSIF1DC/gAQFMPQCHPGOOzzLf3qZbW5Fo6OnzS48x78QDrSp1ojoALKHElQyAt1agwJDuKAwKuYLcVIVyCpT5vtLVzGMbkgpgHfUx2o5ADF1XS031MXJGYPROozpfzkStZVXU2pnNipr2jn0JSIPTyAFNcsIAJQlOJ4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT0wdZ+gvJSlHP+wGetTT9INdHgUiANgIahWdByvMI8=;
 b=XAOd5elARJuWY6zhZ+IE1kO51ZrSGU1Yf3dzpC1mL/u5lv0H0llCN8dZq0o2KS9Z/4ATyPeL8mPG6A3DTiRRkV+3DZRJXo2KGnMRn/PHUHT/06KtBOAjyyAsFZP2zd/8xj+CESALkeTRhUUoxZngbz1/n9V80WN51akVkE944/o=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA0PR21MB2012.namprd21.prod.outlook.com (2603:10b6:806:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.6; Fri, 14 Aug
 2026 18:32:22 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 18:32:21 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 05/13] net: mana: swap queue
 sets in mana_change_mtu
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 05/13] net: mana: swap queue
 sets in mana_change_mtu
Thread-Index: AQHdKuFKrtzUiaVhUEena3fToVLUCrac/z0AgADhTMA=
Date: Fri, 14 Aug 2026 18:32:21 +0000
Message-ID:
 <SA1PR21MB66836DF0CD0C486DB9F77641CEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-6-longli@microsoft.com>
 <20260814050518.805D11F00A3D@smtp.kernel.org>
In-Reply-To: <20260814050518.805D11F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c0833a48-2d84-4d56-95d0-cf7c142b559c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T18:31:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA0PR21MB2012:EE_
x-ms-office365-filtering-correlation-id: 361c0cc7-1e3a-453d-e9a4-08defa32612b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|7146999003|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 6KMinRXG6tsXVJ+k4SZQFUFxuDwCAVG8WWZu0ezQ325iv2u/RdilBkoRJKuaS+muhoK4GONAAo0Ay8qbAlRSosAw6dEHpBKFDGeW9NLPtxIPosi38ih6xVRa+tUasXygKvn5jZmv8e/DyIrQg91IE9qakNwFVYKkjO8FbyqRuAyctbWGkesyDEMmauaWnHXOsWnlMmiWVYZfRbtz4ya9CxWAryapWmjdfFLM5qLPRXhQXFlP0RZr634B3u/5ol5RAJt229ikfdR3G0Zcx7toIPg2nfrqACs98y7SpAi44nxbuqoEPUFkYYXeJ5ga2WFPa5U7moI7dVmvytNGSzFnYoFWrXgozvH3UDx0js7lV4PwfSfz1PqsRmLrYpa45T4FJNqEaOZfZ++kbBZshzgSwE2ousQTcVjVXFDD3BoUzt4eCHziQycsxcjQzqsdrRJ4fFLlggrnl3+4MG21yR7BS6Umj+OQfIeOTzJG0RX8XF2ffaMDcgN4wW0XfNsKqAnXryqTeY0rQWm1+mtVY/waMaMyjz+nwhQQmt8GCEhjuURWrGnqPvQkl2JVgbo0HZ1TSWTVI+KssESPhTrhexF4UwcAN8MzL1hU8/SzA6mRLC4zk5BYHYmmq+OP8ufn4gnfF8Ee/LCXjHy1PlD6Ir661+Y4G0bVTOJQUm7IRAI2/QYwBPHTcxDL3PGSgHZUyVm6KOFsMjfTYS+qtSd7hHj11uZrZZlXQjsFDlZ1wpm8OUY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(7146999003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kck2Eu7NqTGUEl/0D7q2IXdb7M0cPWhJj9H+5UVZjPw2FYd5VdAJBjZAZj3a?=
 =?us-ascii?Q?jUJOSY080H+3+PFexyOXSKmlAavPLLdVfAUZ0pnSZ0GrwNkLuBxeRYHS68kj?=
 =?us-ascii?Q?NKffulEWY64lBYKlUTIMNX8QZecz+pnPjb3iF1AcfhpkvwWFarToQ4aSCW6x?=
 =?us-ascii?Q?1HfgCKhwaXe+YwJIveq7EaKg9GQ4l3oEcAL3vqhwjN7kLgATQRovWD2b3FWY?=
 =?us-ascii?Q?lwNPIZbaRVMwtLadwDP1hv/hzkBH1t0mi13JZCF9yizI/0m4N3dHMqNM8Xsn?=
 =?us-ascii?Q?bpryUti34rNElWMSaLkDvTZZHG76oo5n2WbOcZlp+yPqNw1avvCUd5KpBYX0?=
 =?us-ascii?Q?UMLJVGejaApG0MaRfLrvX7DGnPxYUzJtAPgI6xChM7mwgzgUfByCm+KuBAmD?=
 =?us-ascii?Q?qa10IcLX0QNiKFLBNC57JYfrUXQ6WfgfUJeyE2Z0mN9mjReaqD/W6QZjMHX6?=
 =?us-ascii?Q?sktSk7y75WoPP64MmRpMR08VZM0JdJ9JrNLQo29jW6vcGgQeP5Q6bKoT9c4E?=
 =?us-ascii?Q?wzcx4sdG8e6vh12Tl+vobp58UbZdRfoxnOl3b+CqeyyzJt65DZbiJrqRtiFL?=
 =?us-ascii?Q?B2Z5z7nb+k/rUnio9Rl3c++5VbttpeQxtAPlZ8l8BWAgPbvtZOfMSFp8pf86?=
 =?us-ascii?Q?0xwWoSkbp2TiWRdcDUvaChKuMvt+R5QLQpzG6w9+z1w8Meiv8m9SYP2JVVOt?=
 =?us-ascii?Q?nOxtRY8d7eEHDtBciV8q3/34jVWCRNG4mbTYw2b640ELCpSKZTulAzlL7pV5?=
 =?us-ascii?Q?/uDptWUpRybrdG+29PW74BZtDyvdVYMjeoDhSKU37vPsCzZ94TypaFfEPUhO?=
 =?us-ascii?Q?2gEEanM3ea5X0/oL+7+vK9JA9uVmTvdM/bfWhswkBAK6mKbjOVSFTY/YyFeo?=
 =?us-ascii?Q?azrnTOSVDtHFJ7fRC6vXpSjSRBJf6n5U6zm0MwxpT52aQjDwwuYXE1wtpV15?=
 =?us-ascii?Q?vzUirrXi2j0nUuxgxweqXix7yg8tgN3ELkWPuw3vUuYOneZ3xFYqRLkd4jD+?=
 =?us-ascii?Q?VUPKXYxTmmGOL4Atr9QiNE4lK2xx1rW4CDOOWb6F1uijI09Y0aEHY9vuBXDv?=
 =?us-ascii?Q?hhtoczoewukG1le67P9BiL8pSVYDK1J3REUdbsm1Cy61H4SwDObTXheIM//R?=
 =?us-ascii?Q?g3+NQv7ix4yq+pqTKlnIaopTNNiONVwTkkp4VZRztx2Bfzi+b3BaqAJ9H8rA?=
 =?us-ascii?Q?npbxsgnNSzmAsTLuS56REkHxd6AE5NNVXuDL3CEw7ZfPXsEMIi/g1ZS3pth1?=
 =?us-ascii?Q?5Q7yNLUz5yVelBGVyMMCl/H/YNOtcrQbstHkkBWWQPbS+mqcxHlMBVI5VkBN?=
 =?us-ascii?Q?ihPS+XYG7c25+vOua3f7BY/TTx5W9HNz8UtQGlunV3QHBn5Kf8cXAICtNDNS?=
 =?us-ascii?Q?nsrbbRmDGACcFCMmwDdVEtS5V1qST34c5s8hOaCqnSIJFuuM/kTnkrKz2eYB?=
 =?us-ascii?Q?v+D7NBX34J1fkckSn/25UDAfWY1imATM1VgCjE+Hmb6ykRJw5QI5N2TxjHxZ?=
 =?us-ascii?Q?K+4Vr7tyBzEIBC5QsYzLMGBon55J8JO31qs6F35GaKb6kiwwLbVik/h3RzwD?=
 =?us-ascii?Q?HUa81yZjxAXFIVWlyKDWSgkSIHnhZG1XqgFXWgVDXfpkJxXJyvgzpptq+NwO?=
 =?us-ascii?Q?DVQxyjVHdatYv5KJbFyCfx/CF3kIAWJf2kBH+S4MS5mHgUIps9CM/iX9R9EJ?=
 =?us-ascii?Q?WU2RYe8eqL+aVodtUlhs1dB2V/VLppZv0nuYpgEwcXUmWA7J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361c0cc7-1e3a-453d-e9a4-08defa32612b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 18:32:21.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8GlFDXS8fQUJyyTyYXBppm5kJ/P+bvRtsIU8HgcP/jUY9KAkmnfKgYwKQ6qguRHJCxyRJK7BrKZhXzcjq4uZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2012

>=20
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
>=20
> Pre-existing issues:
> - [High] mana_xdp_set() is vulnerable to a race condition with RDMA vport
> creation because it continues to use the legacy mana_detach()/mana_attach=
()
> sequence without blocking RDMA, leaving the interface permanently down if
> a race occurs.
> --
>=20
> --- Patch [5]: [PATCH net-next v2 05/13] net: mana: swap queue sets in
> mana_change_mtu --- commit
> 07ab252b810cb193b26b16516fc0a40653d2b458
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: swap queue sets in mana_change_mtu
>=20
> The RX buffer layout depends on the MTU, so changing it rebuilds the
> queues. Convert mana_change_mtu() to pre-allocate and swap.
>=20
> The MTU becomes part of the queue-set configuration, so a new set can be
> built for the new MTU while the running one still serves traffic at the o=
ld
> one, and ndev->mtu is updated only once the new set is live.
> Previously it was written before mana_attach() and rolled back on failure=
, so
> a failed change was briefly visible to the stack.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index c0f31b386536a..c858a58577dfb 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -884,35 +884,49 @@ int mana_pre_alloc_rxbufs(struct
> mana_port_context *mpc, int new_mtu, int num_qu
> >  	return -ENOMEM;
> >  }
> >
> > +/* ndev->mtu is updated only once the new set is live
> > +(mana_publish_qset), so
> > + * a failed allocation leaves the queues and the advertised MTU
> untouched.
> > + */
> >  static int mana_change_mtu(struct net_device *ndev, int new_mtu)  {
> >  	struct mana_port_context *mpc =3D netdev_priv(ndev);
> > -	unsigned int old_mtu =3D ndev->mtu;
> > +	struct mana_port_context *scratch;
> > +	struct mana_qset newq, oldq;
> >  	int err;
> >
> > -	/* Pre-allocate buffers to prevent failure in mana_attach later */
> > -	err =3D mana_pre_alloc_rxbufs(mpc, new_mtu, mpc->num_queues);
> > -	if (err) {
> > -		netdev_err(ndev, "Insufficient memory for new MTU\n");
> > -		return err;
> > +	/* Port is down: no queues to rebuild, just record the new MTU.
> > +	 * mana_open() will size the RX buffers accordingly.
> > +	 */
> > +	if (!mpc->port_is_up) {
> > +		mpc->configured_mtu =3D new_mtu;
> > +		WRITE_ONCE(ndev->mtu, new_mtu);
> > +		return 0;
> >  	}
> >
> > -	err =3D mana_detach(ndev, false);
> > -	if (err) {
> > -		netdev_err(ndev, "mana_detach failed: %d\n", err);
> > -		goto out;
> > -	}
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but since it converts
> mana_change_mtu() to avoid the mana_detach()/mana_attach() sequence, is
> mana_xdp_set() still vulnerable to a race condition with RDMA vport
> creation?
>=20
> Looking at mana_xdp_set() in
> drivers/net/ethernet/microsoft/mana/mana_bpf.c,
> it still uses the legacy detach/attach pattern without blocking RDMA:
>=20
> 	err =3D mana_detach(ndev, false);
> 	if (err) {
> 		netdev_err(ndev,
> 			   "mana_detach failed at xdp set: %d\n", err);
> 		NL_SET_ERR_MSG_MOD(extack,
> 				   "XDP: Re-config failed at detach");
> 		goto err_dealloc_rxbuffs;
> 	}
>=20
> 	err =3D mana_attach(ndev);
>=20
> Because mana_xdp_set() drops vport_use_count to 0 without holding
> vport_mutex or setting channel_changing =3D true, couldn't an RDMA
> application successfully acquire the vport in the middle of XDP
> reconfiguration?
>=20
> If a race occurs, mana_attach() would fail with -EBUSY because RDMA owns
> the vport, leaving the Ethernet port permanently down and requiring manua=
l
> intervention to recover.

It's fixed by 06/13 patch.

Long
