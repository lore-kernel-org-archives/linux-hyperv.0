Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021075.outbound.protection.outlook.com [52.101.57.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CF495051
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731877; cv=fail; b=sjVYAlmQ1f99XrLbv7ZsiNUUQtcLnk7GGxoBRMy6p8XlTLxjfEpJwRUjoF/pVmPAOyH9No+Qb6fXlgQCTobqSkwa2Of0f3HDJL9kbyjwuJnyXx1U8VlpTknXvPWKMWPFMFqf9QmQIW4p1kO3TG1AVSZ9yxmMIqVWRnfCiJD8cxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731877; c=relaxed/simple;
	bh=XckIMCa30flgLL/KUWNYfHsCi+UEB1Gn9xcWImRORzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cB/ucOZSBQNddpUfgwK8MZ3TkK4kubOU29Kc6q3OOT4djKVxoILlV+MsfTFkdFlRm8K/fZ65gTFUZY9KfqTrgEfR1uLDloreu9NdH94rPpZdBf2P87As6NyY4jQ2O7xbVvxenvvEN/OcM2u6tFz1OPlxxyatsh0yN9coCXCnr3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SIR3fdew; arc=fail smtp.client-ip=52.101.57.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SIR3fdew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1Q/HwSQwGlYDGDAdF7YaYZKWpEpkS1LfjOGLibRqq1Zciy+4EieboSQc/1GfAxyxFyHsDPomtvOm+vtSe/c07zQHjw9LwzxJGPMAueG9dcGcfCq2778oHuhd9qNBx+j/m1kg2vjQlJ8Q7DxKl5b+PiUyigShSz+/xJIbE2/mqPonX1S4wwTLYcZM98Xw//h3uE6eUJObf0oE/RgxpnshgCXnpkvWF1OvsAv/UKgUTJlpsmqzwMBS8bLhw1+sHcjDdGvI7dt6Kq0xwOKexJhKGvNnjv+K6iNh6lulRISx5GpzFWw75nGnP1OVNA0Dqwq8O9ww97hUQxfG+J5rjrmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htHtR2FMgxxm34lwO09LUqyFRHlddxYwHG4QMgmrpX8=;
 b=pplAZTNoE3R9sRdMTKtMs6neZJErbs2MR4alGwzfNukZvOStzR8ZGaUPhfYrsjw62Q5vYsTqxOchUvJAuz6XE9OyMR/4iQrudnC+bzI9gyp9XjZ6TI1ZEBU/AJmzF45sM3Mln4ow6sxOEPQCqOpT8g+I4/feS0YJbDzSAvmi0TqlVo5Qj+65griSm9y+zmm1FKqYI9mz1PXpgr4yTkQoNUFJzroug4IPo6xjkjZ3DTMZ9romaxx2ef6SiXJ24TK6gpQc/WcTJujh9REPqZgPNzHlmNH/FcOFxVI3vS4KCWSkep+KL1lx6RKUJnwJn9s/EO+zab7nu7cFoI4C38tMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htHtR2FMgxxm34lwO09LUqyFRHlddxYwHG4QMgmrpX8=;
 b=SIR3fdewL1GdEkz9yea4tYkDyrQfLVFn4cNOs+Uf48zbZqCRgg1JD/mNQLc+Xs0OzfRyBEx07t0AQ881c/w/Adbrc8VrU4VjbPf2ddTeHNQOaCm+g/ucXKt+uGrKeQeuucIUW9MMJhNw43MnHl0ovPv8oDnmyLC9WYqq7CKniYQ=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA0PR21MB2012.namprd21.prod.outlook.com (2603:10b6:806:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.6; Fri, 14 Aug
 2026 18:24:32 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 18:24:32 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 02/13] net: mana: swap queue
 sets in mana_set_channels
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 02/13] net: mana: swap queue
 sets in mana_set_channels
Thread-Index: AQHdKuFKyJd1I8JpR0CVzktccOfif7ac/zmAgADe9OA=
Date: Fri, 14 Aug 2026 18:24:32 +0000
Message-ID:
 <SA1PR21MB6683D4D55357CEE9FEEC746CCEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-3-longli@microsoft.com>
 <20260814050515.D0C531F00A3A@smtp.kernel.org>
In-Reply-To: <20260814050515.D0C531F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e58b131-e530-4c1d-9aed-0b01e0776e41;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T18:23:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA0PR21MB2012:EE_
x-ms-office365-filtering-correlation-id: 65a7b6d2-735c-40b2-5a85-08defa31492f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|7146999003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 YUBEzw4oHU2wVhoRXQPcAD1+0qdZhHilT8V1X9yfhrccEG/K981H9Gx0ofWheBxcih+Vk5LaeRQ0jar/eCwlUut8Q/CPjOBo8tYyMOGnVpNvKTeW7VVbi0BZ8Cv+1heuZ1aqfYkQqKNhYV5AtFrA8xjLTlU6iD9KAr9Yqyh8PFISajwQwZuc2cacKwofWKY+BM2FpTVTqgVAVixsRNLx3FkJypbEl5aeYBH4ZMkdmiRYVUUGbHY/KC0t+kLjtHTz3eddTX16wOibvQaTxeKRO63j7eBzcxDm2glJLKou3Erej8uRIAuANuGPKfdeqc/cXGupboIv2i9MESGMVs9C8mV56ISNjdIGoMXHx1tHlE4YgWQjAXZdEsCGjJBtI1UJY10uJnggHnGBFibZcJZ5lP0oUvMy8LitBtiw2Ws49SK6cjmgVmo3h6mY1auTgV/RHLJhWiuva5apDqtv/tJ2DJc7xQ9jRJoA2AN/7+AjWlp0OgJS98YmMi7nO4N0iCH3PMg1XwL2ZucpjTg5X6J8hd59ouRAZSiT45B9JFPRLgBMbSW002T+qHr5Q7D+JEBATjfzs7TBZ8BPLVEd1JQEtfF05Iq6FAnIQyBkBoE/qxjrZGfZzIvchyiEYN4PD+3Y4n/ceRve8XVlWafgu6nlZrunZbA+luiBpRxyifYSgZqV75+irCHLz5dEyTzB+rEQmEH66kIt3rYMynshUSNWtwXWXXcZbWo3A5o7S6W7CeQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(7146999003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CXR186HOJnXSC0hspZwaZz6HutC4Cwo4LfsrxLGJ3sDC6MhgHzsPpgSvbD?=
 =?iso-8859-1?Q?AZXhorsG3LDyoDde6ptDWl0y/2Voxd2NpaZ/3jpFvZtkQFubDiRnMAUdKG?=
 =?iso-8859-1?Q?0SuMPRj4prP0saDYnheIyCQ4SQD6NaNIsl0GuFjmQU78fstdtZXNSR/0Wn?=
 =?iso-8859-1?Q?FOrK5Z4lsSgf166CxwM4NANdYIBwF/xzSnxfzJG/09U+Zmr4JXjcFeRxiv?=
 =?iso-8859-1?Q?08BbENBQt/WSmQkx/jbMQXg1StNGYwOUGmRuOuUlE2BnWdEglXix5wInOf?=
 =?iso-8859-1?Q?n5nzn2TI+YlpV4m6iSJVqNEXHlMTPMw/wtSBFh3fZtS0+wKZ94E73VbSUC?=
 =?iso-8859-1?Q?0ylzaz27kvLgB9Anf8wJDQOloMpStcnUoksTYiBc1C54ma6ZPXqLawhQ+G?=
 =?iso-8859-1?Q?0bEQB7vPOBDxJ7hx0k0joqxiFckRXOkHzElhGwlYIS+/EWt6vYS+YjJd6Z?=
 =?iso-8859-1?Q?HtmoDOuWc+/oQoj5oRM28smcFZftWE8Dfjw4UDpV8zq86QhE/oubbl7k68?=
 =?iso-8859-1?Q?ibOxo9Mk3A3j6U668BJsbOWJhFutO0lQmGw4CMrtH/vViRbn28so4g/iMQ?=
 =?iso-8859-1?Q?Wbr5C1gR4+Q3UcBtSPSDdRj6ldoZSf+Mk/vR+eyVrIRBuGZpaAqXMhOVnf?=
 =?iso-8859-1?Q?cD3CpkhNmwRENrtAHeIl8hjiLSFxlyN1RqIo6fDr4Fq5dJXBBTv4VosW0x?=
 =?iso-8859-1?Q?TVU14xrZZp3vxeOwWDOIYB2iDcZE8hGduyuI2IXkooKmT0+4fqcNq1kArR?=
 =?iso-8859-1?Q?Zrd67vXhMEzU69zY529qZAUORk+a8flhRVrX+3hTp/L3feXDqpsX5QIf4z?=
 =?iso-8859-1?Q?kKdkXMxPlUw7B+rnzQrQsE/6WDSqdyY7F0M785TA6qK/GVTKIz85R+SLGb?=
 =?iso-8859-1?Q?9ulyntyyRL/p/mPQsdgaLL2iPppz3CO819lLMA4p1wcJs9jsmEdXTN6RrM?=
 =?iso-8859-1?Q?61bmwSTxb8TAOFjAcLK2IVE4nrekjZp1DvYJRFv7c4Tv/uiqVKRA3v2Y//?=
 =?iso-8859-1?Q?kukBsxWI1akBsXDFajMAK2K5Mg7w54m46y/SpvHrtMkyU3koQEfUdmnJBy?=
 =?iso-8859-1?Q?HQtmq3BVI57IBPIOCR5NAKOA9u8AQyvTZ3LKenc0zNoPV2uKCo6Tjzbkjz?=
 =?iso-8859-1?Q?QDLNjRy9/YHgArv7J1YbFmum1mAho2EOAYNa08UvTre8uuPDaSqHOP5+t+?=
 =?iso-8859-1?Q?PU68IAbjvCwDe/Ww/buxIDwN9LPSjk5P4hq5T9LCnJyjgIKieVbi6FMB9U?=
 =?iso-8859-1?Q?X0TFQVSaULTHyui5rYiqQcKmwcGHmbYCUuF0N+c2KgNUOEorsYjkmLf8Ay?=
 =?iso-8859-1?Q?5KcAw2eYZQJp7abnbe6a6B1LU5fsmSgxRsyGRD+JS6mJ3ki1s475pXvaW6?=
 =?iso-8859-1?Q?WP0/KObBwr2zp2BRhQxfB67T/dSNIj9STWcnZ5V6x1goskrSxJFQidqvCN?=
 =?iso-8859-1?Q?E0RJlT+0t9zK7wO68Ah2Xdvo3Em94jeE0ll1dDWSXmcUHeT43VGGrHlYPc?=
 =?iso-8859-1?Q?Un6yZkpLT5WGJid66hyxApknBCaCbGavFdlEJNTaR+rMBN/o5mwVz9qhTC?=
 =?iso-8859-1?Q?fWVyunIY+CWBklCDqaO6hShwYBezlyNMgMaNjt1AfKWfkl5x6Ujafk+Sw9?=
 =?iso-8859-1?Q?mlyKkDUNgHXtpbW4xDQ4FuABmxbrubbCEiRyqwNimNJ+otIKgWUI1HQU50?=
 =?iso-8859-1?Q?XUgzeFPQSkif/PBlDbXybOboaPELeMiz1d9FgKJfMeahmg+LzMBnKTR4LM?=
 =?iso-8859-1?Q?TbSx71QASE1f001MpHYZLIqR5cHrZu7wt3TM9YT15AfW/Q?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7b6d2-735c-40b2-5a85-08defa31492f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 18:24:32.1337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJZCLVJ3yoho/hlizNrGWABqVqw1j0+OdzpIBnUS1fr6a2XP7zGljP0Qt/lqEYIkAxQ8X31WHnjVsMhwzFCbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2012

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [Medium] mana_set_channels silently drops user-configured RSS indirecti=
on
> tables
> --
>=20
> --- Patch [2]: [PATCH net-next v2 02/13] net: mana: swap queue sets in
> mana_set_channels --- commit
> 20d58255702f027247917ff013e18e0c18e9845c
> Author: Long Li <longli@microsoft.com>
> Subject: net: mana: swap queue sets in mana_set_channels
>=20
> This converts the channel count path away from detach/attach. It builds t=
he
> new queue set while the current one keeps serving traffic, then swaps it =
in
> and retires the old one.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index 04b7a5c0fdabc..b12291555eaeb 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> [ ... ]
> > @@ -659,42 +659,88 @@ static int mana_set_channels(struct net_device
> *ndev,
> >  	apc->channel_changing =3D true;
> >  	mutex_unlock(&apc->vport_mutex);
> >
> > -	err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, new_count);
> > -	if (err) {
> > -		netdev_err(ndev, "Insufficient memory for new allocations");
> > +	scratch =3D mana_qset_scratch_alloc(apc);
> > +	if (!scratch) {
> > +		err =3D -ENOMEM;
> >  		goto clear_flag;
> >  	}
> >
> > -	err =3D mana_detach(ndev, false);
> > -	if (err) {
> > -		netdev_err(ndev, "mana_detach failed: %d\n", err);
> > -		goto out;
> > -	}
> > +	err =3D mana_alloc_qset(scratch, new_count, apc->rx_queue_size,
> > +			      apc->tx_queue_size, apc->priv_flags, &newq);
>=20
> [Severity: Medium]
> Does this silently drop a user-configured RSS indirection table?
>=20
> By using mana_alloc_qset() here in mana_set_channels(), a custom RSS
> indirection table configured via ethtool will be lost. When mana_alloc_qs=
et()
> is called, it unconditionally initializes the table with default values i=
n
> drivers/net/ethernet/microsoft/mana/mana_en.c:
>=20
> mana_alloc_qset() {
>     ...
>     mana_rss_table_init(scratch);
>     ...
>     mana_qset_snapshot(scratch, out);
> }
>=20
> Because out->rxfh_indir_lost is explicitly set to false, the old indirect=
ion
> table is freed without preserving the entries, and no
> ethtool_rxfh_indir_lost() notification is sent.
>=20
> Will this cause the interface to silently revert to a default hashing
> distribution after a channel count change instead of preserving it?

This is a pre-existing upstream behavior. Patch 11/13 adds =A0mana_rss_tabl=
e_keep()=A0and fixes it.

Long


