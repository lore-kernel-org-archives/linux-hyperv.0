Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021082.outbound.protection.outlook.com [52.101.57.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994D39478B
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377162; cv=fail; b=NSS2rUXvNAWV+zi8W1QxPGcQJXanZLu+80p0S6XJSSkYSdm8VPTl+dd2Vy7urIrLzkbBS7f8RqF5t5nfhYnSH2LEliAjuxP38Ao0ETDSLRqTmTjMweZQ222Mf7Mi8OFiWySIuWLjTE4F+P/SLGurWT60a1AwPX7ShM+NjsKFcKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377162; c=relaxed/simple;
	bh=LkXiGjfwDEKe4uzccvgnTHJCkby+9HOUdUwilhpxeUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvdmDn7S3H1YFOWIzMOfarr+NlXeylwC8MeeTdaULEpf67WMgO9V8ynqxCVHPjFsi/N0czBpNeCqh7VSHoxAEiIEkPmDcRSqWvRVP+6iHx5NLnjvn6enaxwATYPWFsXMZTu+/2IrGhI95QM7sKKcTBo55qAJOzynx8Sgs39u4Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=J0N6/q4o; arc=fail smtp.client-ip=52.101.57.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J0N6/q4o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkrxlOHU9rxSy4MNhr0yCnPnYUJMwp596RQJRt3ywEG4ymsUsPERmtPnGE3BjR0rnMKhBdn3eWlmM324WIdTcOyycZZEaYtzNn+KImatw5gySLxZka/SH5M/VyOug8IiCD07cHkpKnLNWKzR+fjGc+hUq2pgx+WQMgt11WDFguwWsgZ4ESx3a6ehH6C7fZXAJnVaoUsQ+KM8Sg0v+OTHTvBJwKGLHjm3Trlc+t2enwKvQ0gMlkfuH8yN6R90FWmxFWfSIT97DNlE5CzGgc1D+LsFD+CIkKoDENcgwwFt9EybSxqshSqMzPLKpQqrC9LBAxs0FZ3ZyXIlasX5pMYXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2wO2OMCQV1aQLhBUbB6cdn1v3e1A5wDGsTCqWb+G1Y=;
 b=NX5SlvNiNd9oX6wjpCVk8brlzHjxb/yEVuARUNdjDFqZ+oYBIhkLv7O14iXEbo73HWU2bV1IrhSgoW9X22pfCv0RhL2e8rLadnkM3Rtw5LK2TcOfBpwlscQNfhv2SplC6qUyr/OlzAY902q19ys84bhpSk94BrmtXjRfzuStY/Y6F3ai/BWWM7WT3UEX9qTXDnopdqRp9RBr5OFsyfz52PMmMq5ZXJsjjvTkvFmx0d+Q0ZccLdXZX1JDxO1bP5dUNva2PyOteBlwxfPFvjRDlbg0a5P4Pb75UXaOzAwXc8E5nIkYD5yp2/Mkp07Gn0iz0zPFHFUBW2R0Dny/uVWk7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2wO2OMCQV1aQLhBUbB6cdn1v3e1A5wDGsTCqWb+G1Y=;
 b=J0N6/q4oAwYXNbJbNL6oZKyzJ9lPl1IBcYJSHrFgkSnQvPnKgTy0rSMu6IsasS56DWAN2HxhdRGmr2veyrYnKXBk90um0Ml6z+Pja0V30VqdeqseRTu8FmjWixrFKmglrA7mVpZ5DwfXjNZvWgZb5tFNM9L1NWElwVMOXslRrlA=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6562.namprd21.prod.outlook.com (2603:10b6:806:4a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.1; Wed, 2 Sep 2026
 19:25:52 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Wed, 2 Sep 2026
 19:25:51 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 04/13] net: mana: swap queue
 sets in mana_set_ringparam
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 04/13] net: mana: swap queue
 sets in mana_set_ringparam
Thread-Index: AQHdObOUM7JdfrfpUEmwwX6GHA597La6hheAgAEn1eA=
Date: Wed, 2 Sep 2026 19:25:51 +0000
Message-ID:
 <SA1PR21MB668357F0C586389EFE989747CEB72@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260901014442.2945689-1-longli@microsoft.com>
 <20260901014442.2945689-5-longli@microsoft.com>
 <20260902014536.1CCE71F000E9@smtp.kernel.org>
In-Reply-To: <20260902014536.1CCE71F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=127baba3-b9d5-4846-8bcc-7a71d64a8f7b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-02T19:24:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6562:EE_
x-ms-office365-filtering-correlation-id: fd7497ef-1339-4683-1fa0-08df09280011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|4143699003|5023799004|6133799003|11063799006|10067099003|56012099006|22082099003|7146999003|18002099003;
x-microsoft-antispam-message-info:
 WXvvm+yhNBEv+hYGlKxIv/g0jWQwTvm4NtbiqvXloQobNQ2QYD6nVXmOzUzpdq7RatxnRQDltgfRpond5Q92k5PO/mJ0Yc1P4tNj73yxzUhjCk55zCkWIhONaQUNuve1NYWtcCO+1hlJzy8GxviqRD0O/3U34kYwG6grPcaWhEPm/ygqqvSS2SxDVkLEZgfvhPXZ0lkcBLpr51Da/8Rrdg5Q/7SPlHL8HoXQG2MMqxbyFfiKLBMwWDj0a+1edNBNpsKlAKLtQKDComxmsR9esxacWtd+RGuqJGWDG1yvfgstEz5M4ATqAhUhHq1ZZEHAVKoar23/0VlBSg/4IQ9BkvJC+8D7Ff6PSZhVmBnayG6uyI34A5hTdhBkofibkp/D8FH45M56Qtwtc2f6zpgWQoQzBeLEttlgUt0dSSoC2kF8zC3LRQ8gofO2DGBsHfiPpxKoIxsRALms096YV4VYVOVph4YMsF8a/+LkHWEZamS8jtq4lNEuydUsWiL/FxFiCU9gAwsOt/cq6e8i3tStO6mr2fmB/TPzyfHRqoJyCWnFi3M4TqR8JQFqgtMhWcafHNNrMOjyvxCcrLrGvl+O13G0kccLiw0lLOni4z27TQPqZSvlSApYF5fb3lKOqi8P1bJeULiaTQN3B2ImwRd0VwXd5NwRZ6ATIVFX8ElD30xZJvYFqMyd7bMr+H2Ejc8dBZMN4zW5yQc0xHnWBtMpvFyy655L83NWiWlxTr7ex6k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(5023799004)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(7146999003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8CLj1jPGYQP547NoaW9XnH3Bf4LL+/hDk/GQxdNtWNwaNMkAi2E6f2C3KguR?=
 =?us-ascii?Q?H7GwcAsOc/Z9526lgBhOO0FCiOwYOcSu8Hh1LXNfmWtRULqm9rvC5ssdtFyo?=
 =?us-ascii?Q?hEZrA5FijAFW6acyoNadurNy10aGXQEhPzSSpkhgsqGjSVIFTnmjWivT+Gcl?=
 =?us-ascii?Q?1y/TEYjQMFhffYrN+ZMVpm4duSiIqRI6Y+fWxaUrMaul3X3Ry3oeulBk1EaK?=
 =?us-ascii?Q?XjvRhmz1COifbzX7V/DL8DPFZkDBBSusXFTT5iEcldj84YVPUlk7rZ5AcNa9?=
 =?us-ascii?Q?lsTU1FxdhZyB/hQzu9dBn6r3EKUPLtXQ6OYcaLY0PTLb3muWKOCYHtuYzLhY?=
 =?us-ascii?Q?MyQvTYH9sTBsleDz3KF0kAv2CPREWofdbOAQWhqLzSmnDFM1Hyl5cBds4Ljl?=
 =?us-ascii?Q?tDsspps8W7WsywV2HCj1rqDiTSeyjAMUGrSAtYidoS9Z47jWViwliRthWl7i?=
 =?us-ascii?Q?TN+R96cqY1EHGnGZoK6J9GY+5KRqSiIERxPlEWH8Jl7zbaBUqU8CgCk7x255?=
 =?us-ascii?Q?MXeGSyNBSDBLzMIeFjN+KZ043H7m4FLxZpM6lIQLoNHevJu8lhRSAtCdPhoU?=
 =?us-ascii?Q?eK1Ixd9V5+DY58IWlPYpmlYdER2PBcW/E31wrPn0cDyHz6xh4svGFbf8QW3l?=
 =?us-ascii?Q?a+WkLWB7c9wOvRhOaxSPMYVUWMQqShoqJOT5f/jPHBNFxKLqaplOh1QEvd3x?=
 =?us-ascii?Q?wgacfNKvRr4RdoIkWv2EYiC6ONsv0o3f6dDaedeJQjgsWUEDPU0CRsillBjo?=
 =?us-ascii?Q?6gM2y27IiFmyRFGRByHOZJGKEQ8XnV7N7bI0T3Sxt+Kp+KzM7PxS+vnEU/DB?=
 =?us-ascii?Q?u8hnavAH0cGthYrE9h5GA4m2yU1hD13Akr2Uv0eqm146XkXnAiOy8ugr8T24?=
 =?us-ascii?Q?S9WkCOlxSsds/lIxd4VKYzw3X5RvGRpPqr1TgfOu5LgcWNV+1/AxfPX+TSmS?=
 =?us-ascii?Q?xiKP6NBe5mV3ctJhE2vl1Dkeg3c6ctGg0tqm4inl2UxsTAynm73Osr2v7qhZ?=
 =?us-ascii?Q?rPqEudebfhf6BtSKlL64D6OpFLlDClU9yOVjl8+EINllWncX1Spw3QqGCKAQ?=
 =?us-ascii?Q?T4JP9iUW1c5CZWlCqWNE45IrnHBTyQRxDGQ4cf9dfg95N5lqkscAg2bhpHwx?=
 =?us-ascii?Q?v72Kwd22G5AWqUhHwUIqKfHL1HBXL8OKLjtCImQyRVhfxeAzZzDibT+foFf4?=
 =?us-ascii?Q?CYKuHuGYDKf/vab7bUJ8qPMeMsMNWWAJGJNI9mk4SOYNvGecJdOTNeUT8rGd?=
 =?us-ascii?Q?hgSLSxOv/7ho7dJmQ0ocjmuMJVWBlZRlDAA8acW7/aoGjRYKxsbNWedoQoVt?=
 =?us-ascii?Q?yoCwvxJ4gpB1HIvlOfa9Zwe5+06RbtMZzyJV5g72NKG0LO94EoLoIRfxLTY8?=
 =?us-ascii?Q?/qVeJpzYzkXWw5iwtPWMZ+k2PvC+/ibE60OIi25YN8qR6ek+W+iVvOnMlBul?=
 =?us-ascii?Q?GZV5QkiAQQKFYyeK0v2woKdkPG6T2wC1RHv9gPshdT6S6iRv4A+t35fk6cLp?=
 =?us-ascii?Q?cs9XW+WL29LQeV0jTcxSAWO6KKubzgL1iwG+pnRAI0OdGllitxyWY1GbFiNH?=
 =?us-ascii?Q?PrzXoGZYM4CUfpqsb/LLjB0OtewExIaEb0BQfqef64Zu+jHHWqeML43oU0ir?=
 =?us-ascii?Q?fwgPqgFyF+uOlp5n/KjVOLCJmwacB1ZBNPKDRI1xtevTJFWcRvnUVGWg7R8q?=
 =?us-ascii?Q?4VY1lEDDjh6W4a14+/U6+SZIhP+x0jBlpku/qoD3TDLR2EaP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7497ef-1339-4683-1fa0-08df09280011
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 19:25:51.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j38x2FqgCbH6gtdWXnIJgnW3Atf8D8fHZ4zIcV4RqmeDFcRm+b4W+o7fvvda3y7Hc0cHKYBszhNtfnqqHbjeeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6562

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [Low] The patch introduces a boolean flag (`channel_changing`) into
> `mana_set_ringparam` to act as an ad-hoc lock against concurrent RDMA
> operations. The subsystem guidelines explicitly prohibit using a boolean =
flag
> set on entry and cleared on exit of a code region to prevent concurrent
> access, requiring a proper lock instead. Furthermore, this ad-hoc lock is
> entirely redundant and constitutes unnecessary code complexity: the RDMA
> path (`mana_cfg_vport`) already returns `-EBUSY` when `apc-
> >vport_use_count > 0`. Because `mana_set_ringparam` returns early if the
> port is down, `vport_use_count` is guaranteed to be `> 0` when the flag i=
s set
> (as the author notes in the code comment). This means the RDMA path will
> always short-circuit and fail before it even evaluates `apc-
> >channel_changing`, making the flag updates dead code.
> --
>=20
> commit ea4e4054a6be8a40258c13cd5a0aa9f21fa11e29
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: swap queue sets in mana_set_ringparam
>=20
> Convert the ring size path to pre-allocate and swap so that allocation fa=
ilures
> return an error without touching the running configuration. This drops th=
e
> fallback on failure and returns early when the requested sizes round to t=
he
> values already in use.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> [ ... ]
> > +	/* Block RDMA from acquiring the vport for the duration. The vport
> > +	 * itself is never released, so vport_use_count stays > 0.
> > +	 */
> > +	mutex_lock(&apc->vport_mutex);
> > +	if (apc->channel_changing) {
> > +		mutex_unlock(&apc->vport_mutex);
> > +		return -EBUSY;
> > +	}
> > +	apc->channel_changing =3D true;
> > +	mutex_unlock(&apc->vport_mutex);
>=20
> [Severity: Low]
> Does this introduce a boolean flag as an ad-hoc lock? Subsystem guideline=
s
> prohibit using a boolean flag set on entry and cleared on exit of a code
> region to prevent concurrent access, requiring a proper lock instead.
>=20
> Additionally, could this flag be entirely redundant? Since the RDMA path
> returns -EBUSY when apc->vport_use_count > 0, and the port is up here
> (meaning vport_use_count > 0, as noted in the comment), the RDMA path
> will likely short-circuit and fail before it even evaluates apc-
> >channel_changing.
> Does this make the flag updates dead code?
>=20
> [ ... ]
> > +clear_flag:
> > +	mutex_lock(&apc->vport_mutex);
> > +	apc->channel_changing =3D false;
> > +	mutex_unlock(&apc->vport_mutex);
> >  	return err;
> >  }
>=20
> [Severity: Low]
> This clears the ad-hoc lock mentioned above. Can we remove this flag-base=
d
> synchronization entirely if the RDMA path is already blocked by
> vport_use_count?

The flag is not introduced by this patch. channel_changing is already in
mainline: declared in struct mana_port_context, checked inside
mana_cfg_vport() via its check_channel_changing argument, and
set/cleared by mana_set_channels(), mana_set_priv_flags() and the
per-port reset work handler. This patch converts mana_set_ringparam() to
the swap model and follows the convention the neighbouring ethtool
setters already use.

It is also not dead code. The reasoning holds for the success path:
while the swap succeeds the vport is never released, vport_use_count
stays at 1, and mana_cfg_vport() short-circuits on the first disjunct
exactly as you describe. The failure path releases it:

  free_scratch:
        mana_publish_close_if_needed(apc);  /* -> mana_dealloc_queues()
                                               -> mana_destroy_vport()
                                               -> mana_uncfg_vport(): 1 -> =
0 */
        mana_qset_scratch_free(scratch);
  clear_flag:
        apc->channel_changing =3D false;

When mana_publish_qset() hits a dead end the port is closed, which drops
vport_use_count to 0, and the flag is only cleared after that. In that
window channel_changing is the only thing still blocking RDMA, which
calls mana_cfg_vport(..., true) from drivers/infiniband/hw/mana/main.c
without RTNL and can therefore land in it. The same applies to the reset
work handler, which this series does not convert and which still does a
full detach/attach.

Thanks,
Long
