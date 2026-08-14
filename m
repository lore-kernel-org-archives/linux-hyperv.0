Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023077.outbound.protection.outlook.com [40.107.201.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081A3542F6
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732684; cv=fail; b=W5xUwmhOwK2MAViOfIxN54pPmShI12Nz2M9RNMvKpDHxhzjykTrWnQSnnjGfBCiXxJ2fEp5DP5tg9jYzauP08K6L936XmEgCU3y2XiuR7T7LVcSxUxXh5r2VjkiuEqWeNg3N+twJmNO13GYf0T3OuW90ZhezEiBbLIGAnWtxkXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732684; c=relaxed/simple;
	bh=7Rgjq7j3Zi09J0PKRN0EeytNlKKRYSKR18FBJhFnvy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZekqV9mHxi0sE2stOA+5QL5cS0YBkP59b+oQw8P37IJTV1nIu4nC89faKYerBl8/OiThjkczaToh3YYaH5UmSBjJQFiXcdR92evtPWp8CMrvE8yWcELcUvL9z6tqODgku+kxPn9K0zCgwFJqtk068Rjhau8BS1ngxTiTHkhWDmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fP7oVlOB; arc=fail smtp.client-ip=40.107.201.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fP7oVlOB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHubyiw0MGxuZCgDakHVc9egb3OqB7V9whvRrYLaPGVMbgjTeXCN9myR1Fax8lH3iaEoaaCeP80hubDO96xWzxPwjroZvVVbEfhKValWATK7/AXSQ7mrFMhJnoVmiqjVxc1uc/rKbdGI8ErAiGkUI5kqBQzcZvH8kGlLfsmlftWaKfOjnpTmqXR5QXkoDAJjxxyLHcQVMwivReKB8GTEDzZ+KZroFB49yEiV+9QIehvRo8lqZnyjyptw/jZbNASOygC2eL8Vp06SgUVMARHd7jJpirxxuiPDumtZXZt4GAwF+QqgcwhqGx11yH5BG5QHTA+x1Pso6pQ/Vb/t8aL2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FhxfSvdxYvPqH+6d9iGS3xObxS/X5rbFjWc+0cYmRA=;
 b=MmPstInyD3Jr6fB/bQQIGXcMxnTemBJAwlK/V/+DLCX3Uqj4Q84rty8ObYxJhIkYo2UnCeO8POza/qqIv6T54pqjt8BawfDmkpXi8brEJGJRN8znXb6tHfRMMNtAyinLIdDC68MsKmDJSkY1NPVZ+H1YAV3n5hehRrtSDU9uxmuxRx87UBKOjU75hx8Oc6T2b0KfCSWIyXMp6hwyqkBAvtCoQfb3J/mpztb6gDmFPz+fEnNGsdUxcDrltw4jQtpnrRAgVtDWQatz8Z+t9JimRVdLcO+vU341m1RgR9wFSdV96lCl1eND/LzXrIgyDJ4XoYOTNjn6aFpdZvLcxf9oYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FhxfSvdxYvPqH+6d9iGS3xObxS/X5rbFjWc+0cYmRA=;
 b=fP7oVlOBcjID9jib0oOjamRD6awPkVzA7F4TSi1bPAVtl2wO2cuOqS4b6ZyshL0+G1gJ/N73/zUoF0Nj0fKgtaH39y5rwOX7p4IOl2kWCi7aQFb3T+HCX8F9J6ZG7rBmCpDUbKdQy41freSUstV01TXw7alPWsiEOr9rCljP90U=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB4033.namprd21.prod.outlook.com (2603:10b6:806:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.1; Fri, 14 Aug
 2026 18:38:00 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 18:38:00 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 07/13] net: mana: do not bail
 out of mana_detach on dealloc failure
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 07/13] net: mana: do not bail
 out of mana_detach on dealloc failure
Thread-Index: AQHdKuFLBDbeMlxtUEGKcI1IQzcD1bac/zoAgADiJAA=
Date: Fri, 14 Aug 2026 18:38:00 +0000
Message-ID:
 <SA1PR21MB6683E8B3384DB015CB34D6BACEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-8-longli@microsoft.com>
 <20260814050516.7629A1F00A3D@smtp.kernel.org>
In-Reply-To: <20260814050516.7629A1F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2f89b830-d0c2-4bad-b7be-29d97516b009;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T18:34:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB4033:EE_
x-ms-office365-filtering-correlation-id: 15834c3c-c7ec-46ef-748c-08defa332ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|10067099003|7146999003|4143699003|22082099003|18002099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info:
 ekxiiJtrjwx2NcBhOQTNgOL7/Gj6EYgqjFwFmibwM9zPC6F+adrHQB1Sh7en5ejERC/1pfKLnKE2gD28AoqTxonxmX+7VJC9JxPRvXLLP6QdYOT1FENGcVtHq88Y7tJ3tnn3EoeUIJzaDr7CAzPiyc+58VFsCtg/tkD/1cSNOa/tk5RwgUSDhWJ+DlQYQt5GGYLBb/dBA96KyvP+DiL/2Ks0aTkwK8S3U8JTdJs5ns/3+SlnG1MNktb80LOR5nLGYTCo2pNYZYbt5W6Q2+JkzZ/zu7PH/ARH7c1xCozRPeK2MsY1lBlfDByq54Al/mZucN9mklv9b71Hv4+U0zE5lyUjhJPX0YDDs5ho2nnieTcDg6H6FPKMFAQeDbeLDx1j3/F0aLnQqD0JCFQgCnq8Rl/CH4wKbcjncCD+RgzGeo1U1/augApNPoQElMZQUwSQ/aXicpgn7fsb0wIBuBQ/BtyYaZUNK2INfiNMI69rW+BoOnmZ7+SToAQsCdNTUlxRbr+hrPasTOITQM9kviyFv0BU7tu1uBSNGMm3V4nW169Wzp6neYsqGAR5gXoGoeWtydRVAaM89ZZnVuJwxBswOwDEfPLUKAWi+LhUvvgYEmQ6ZqVsgz0PdkjSoP93YwydycKygGZ1KUCCEhHOvonTAfNWUMCZFshn6h+WMfzXSLGf7LKfeagQe99dJY+oUmnFW7k+4cHddgFHWwdXmH8y9WGPQQyxelxpkXUkoZou03s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(7146999003)(4143699003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kAMPUOBuTJLGE25OdIavEMeXZhWfa+NtCcB2mO57XhdPIhMWDwODN7m5M0?=
 =?iso-8859-1?Q?q7YIAO/89DpHFgR//hXCLLmWY9Xt8N6xHXgJ542PHAjDIbJF+5jS+0e2m9?=
 =?iso-8859-1?Q?vR1lDs+QfsDZcVgjyL3AbI66SG0Tj9VgXMKWMaWnkddQGiCo4coxGLxA2a?=
 =?iso-8859-1?Q?ne75AN5AAUFPqcgzgxDd6eMFAMIGJnp+YaZV0VFifKE8KwwblD3HRbPbCA?=
 =?iso-8859-1?Q?RJ4AOCAOFSlP8GkLCktm0Xg8kkGErxwwU1SxBZNikspN1+NIht5KIZgIim?=
 =?iso-8859-1?Q?17eDsUcwmfqsFLs982EAhe8l/D+9hW/zyzsNcnetINvNLiQqSJBv0Z7tvG?=
 =?iso-8859-1?Q?SYFTrDHOZRH0PTz7IbGq83V8h2feSCkf6ec240yFzHp682ZunNUYSdQq2j?=
 =?iso-8859-1?Q?f0MzBkPFPv4jMjxMTOMQqaE6bRGvnXHjdLSa+ZxNm4ZE/qHO46pjLsa6wG?=
 =?iso-8859-1?Q?Clc9vBNLtl5VbrMKJC8Klk/kfBu9v43iAyMRwe3yADJRz7nRAwjj/0KFJd?=
 =?iso-8859-1?Q?jZyZzTMmo5VGRW6kxoq0E30H5wBNrJOnZ+Df7Hj9aIPavemjvpE7uaS8fq?=
 =?iso-8859-1?Q?gDzLMxrdDzaI2TkAV9rcilh6YXC8sebUNh+ltacF9SLSvX86g7ho+4NE5O?=
 =?iso-8859-1?Q?pKgpcBOLF28K5tSZcvsu1Bbc1K/lzeDpCWJrnFe5zFCeJC0ODLKw/LXujn?=
 =?iso-8859-1?Q?33xrLBUV+0oa8ahYeC+h/8WEIMWHcPFIrwez4rpFSrztCYkPK0gHI1blo2?=
 =?iso-8859-1?Q?f2oNMDKiaYxkfpGX9fRf3eBg9t/4VRiQbo+Fn9hjNL1HVqfMmpxYMjrLyp?=
 =?iso-8859-1?Q?/B5/wR2py47H5OD5wRzO9gQgr4jrMSfCmb8Tk8qYYrKso64UwnjWP24FTp?=
 =?iso-8859-1?Q?e+ZfiNjnzEhWGbzBY395RpKFUY3ryIO9cUlS80IPCR5rRvcuzs+td3/B47?=
 =?iso-8859-1?Q?rcqsr0LlmqJO48tBq3QPEuyIuHv068h8ACBtNaWkw6xEkivLw2yzt5CgyA?=
 =?iso-8859-1?Q?KtyESFIfUWmytIm6ub+x7xIxqr7JMHpsbM83L0e/Yi2GuzFXopcLS+9Khu?=
 =?iso-8859-1?Q?7BNlGK1xTjbVM3Txf2fj//E1Q2VEzukKEKIWVQZeGPkych6edxqTJThops?=
 =?iso-8859-1?Q?11iLwCUByqtu4JTSG9P+uASVMTr+Bl4+Hv8eSQybAzYF0SqOoJiIwEQeZy?=
 =?iso-8859-1?Q?3E/F205s4dqCYdEApfau7gODZh6pJFtzQ6vHgRMudcnsvnJmlz/6Gv7nn8?=
 =?iso-8859-1?Q?a2v84jhNqSMX2vSrBDLAkC+eVA0EOF+bybO0YaoeXJSQ06hdk05OMb9epm?=
 =?iso-8859-1?Q?CKfRVNbhebO9JY5OI83d2h/86SJOdPNnhOX7Tg+f9FkAxNOkv/n4+qOljw?=
 =?iso-8859-1?Q?zW6n/HVoqPyCEapHQlh53bTvOyGGI9YSlwMzIB1OqY6uHpSj+5QPR4uZnu?=
 =?iso-8859-1?Q?G4lVNANMzrWrND6rbDrDkfV1PPGJ/zOEIwIiS5S4V55x5mMYtZPA8WFyA8?=
 =?iso-8859-1?Q?MSFxr/n9iw+W/+iSncfWCLw3y1erit59z4A5U1NX0bjTVIgrtjGWor2dqL?=
 =?iso-8859-1?Q?lbQXiYEX9tYw1/JrQTvxRfjFoJcZ4dCxmRIomWEaMXzlIi2/BKJHdCbnj2?=
 =?iso-8859-1?Q?iU2BG4zh2VDdy0VDtO74A9BuP9xVcr7SuPyBKJ8zc4NGfQLtqssytrDI+G?=
 =?iso-8859-1?Q?ntfKVYb44w11QMY/hnLbli/lUK7RIc/NAiaa+AIDxPMtUpmRLLo/lQ6KEQ?=
 =?iso-8859-1?Q?VzZg8ienfqUV4PjYgW5Xv5VZY1m5n0zKU3W7oGSEzvJJ7e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15834c3c-c7ec-46ef-748c-08defa332ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 18:38:00.2463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlNN5KJn2DyxbwiVFxoowTAoZgApGMS6ITwgQnTYZKbFv9Jcza4WUGG+KhdZK5J4vr7q6n0W8Vku4wa6hY8N7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4033

>=20
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s)
> to consider:
>=20
> New issues:
> - [High] The 'channel_changing' boolean flag is used as an ad-hoc lock to
> guard code sections and prevent concurrent access, violating kernel
> synchronization guidelines.
>=20
> Pre-existing issues:
> - [Critical] Hardware queue memory and RX page pools are freed while the
> device may still be DMAing to them if it fails to quiesce during teardown
> (DMA Use-After-Free).
> --
>=20
> --- Patch [7]: [PATCH net-next v2 07/13] net: mana: do not bail out of
> mana_detach on dealloc failure --- commit
> 04170ba1361c402d70e39fad639e6d6455da30a2
> Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>=20
> net: mana: do not bail out of mana_detach on dealloc failure
>=20
> This commit modifies mana_detach() to remove the early return if
> mana_dealloc_queues() fails. This ensures that the function completes its=
 full
> teardown, including netif_device_detach() and
> mana_cleanup_port_context(), avoiding an inconsistent port state.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index e54ad4db918ce..2b3250483b439 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -4502,10 +4502,8 @@ int mana_detach(struct net_device *ndev, bool
> > from_close)
> >
> >  	if (apc->port_st_save) {
> >  		err =3D mana_dealloc_queues(ndev);
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does mana_dealloc_queues() safely handl=
e a
> failure to quiesce the device?
>=20
> If mana_drain_txqs() times out and pci_try_reset_function() fails, it ski=
ps
> freeing the TX SKB buffers and returns false:
>=20
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_drain_txqs() {
>     ...
> 		err =3D pci_try_reset_function(to_pci_dev(gd->gdma_context-
> >dev));
> 		if (err) {
> 			netdev_err(apc->ndev,
> 				   "function reset failed: %d, %d pkts pending
> in txq %u\n",
> 				   err, atomic_read(&txq->pending_sends),
> 				   txq->gdma_txq_id);
> 			quiesced =3D false;
>     ...
> 	if (!quiesced) {
> 		netdev_err(apc->ndev,
> 			   "device not quiesced, leaking pending TX buffers
> instead of unmapping memory it can still DMA from\n");
> 		return reset;
> 	}
>     ...
> }
>=20
> However, mana_dealloc_queues() ignores this false return value and
> proceeds with the teardown:
>=20
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_dealloc_queues() {
>     ...
> 	if (mana_drain_txqs(apc)) {
> 		struct mana_context *ac =3D apc->ac;
> 		unsigned int i;
>     ...
> 	/* Even in err case, still need to cleanup the vPort */
> 	mana_destroy_rxqs(apc);
> 	mana_destroy_txq(apc);
>     ...
> }
>=20
> Because the device was never successfully quiesced, it remains active. Wi=
ll
> unconditionally freeing the GDMA SQ and RQ hardware ring buffers and RX
> page pool buffers here lead to a DMA use-after-free when the hardware
> continues to DMA read/write to the now-freed memory?

Pre-existing behavior exactly the same in upstream, and the ordering alread=
y accounts for it: =A0mana_destroy_txq()=A0/=A0mana_destroy_rxq()=A0 call =
=A0mana_destroy_wq_obj()=A0 first, which tells the device to stop using the=
 queue, and only then free the rings and page pool. This patch set doesn't =
attempt to address this.

>=20
> > -		if (err) {
> > +		if (err)
> >  			netdev_err(ndev, "%s failed to deallocate
> queues: %d\n", __func__, err);
> > -			return err;
> > -		}
> >  	}
>=20
> [Severity: High]
> Is the channel_changing boolean flag being used as an ad-hoc lock to guar=
d
> code sections and prevent concurrent access?
>=20
> drivers/net/ethernet/microsoft/mana/mana_ethtool.c:mana_set_ringparam(
> ) {
>     ...
> 	mutex_lock(&apc->vport_mutex);
> 	if (apc->channel_changing) {
> 		mutex_unlock(&apc->vport_mutex);
> 		return -EBUSY;
> 	}
> 	apc->channel_changing =3D true;
> 	mutex_unlock(&apc->vport_mutex);
>     ...
> }
>=20
> Using a boolean flag to protect entire blocks of code bypasses standard
> kernel locking mechanisms. This prevents lockdep from analyzing lock
> dependencies and forces concurrent callers to fail with -EBUSY instead of
> gracefully waiting.
>=20
> Could a proper mutex or rwsem be used here instead?

This is the pre-existing upstream locking mechanism. The patch set doesn't =
attempt to change it.

Long


