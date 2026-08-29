Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013072.outbound.protection.outlook.com [52.103.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDC2C11EE;
	Sat, 29 Aug 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787973002; cv=fail; b=XJBOM7XVYQj9HrJswuwE02tz4lMfNyv8D4auwmg5idlb0jOoXvEL1yBgohfTS2txfyt0yGijpX0BDVIME1/bGyKhuhq20EmhY4WgUTAvugHLffxwuTH6GiLzuc2YvMHw+EYE7TQ3CU20ilXhcDw5CVRVVmgP4+kJNgC8KyJDnZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787973002; c=relaxed/simple;
	bh=ByQWbmTWsShIYKU3ZqFStYd135YbcPcnGvs1ZIMSn1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H2SVI8RmVNiKoYti91AFcrn65WfdGZ/o1KGbJaqZPnZMJ5ChYuRwj5arzCUde4e6Bl7gqPDQyEQviepHQSLhEmxiUUFnvIM9JaKomrpUfW1DSKtb0+MQ2h0UrxtuT2ZqBSX2+1URlnQjvi3NnF3V+FFtr07/eQDoahnVc2YtI9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LJFeSr8u; arc=fail smtp.client-ip=52.103.7.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LJFeSr8u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAfCbEsgeO7b3NXEWtxsqDKoFkK8l8p1cZK0t5V7odS118OElz/fmngZGfPz+VoJajNXSjRJ6iGLpMSvjZngHC+PfgJ7dB9MjAYwgjYLeYbQMmSPD26xbeuVN/wDpmYpzg+NBDsRAHDqjhR/0Y8DT1vhYSTa0IbxPs7B5mrUc8T35bflVy+t6906BqqY1ydAXmzTAj4jN+BglA48CTt6j87yfOXlW+IpOen7wD8Jsdj5I7gAcEbi+osBpysSrRzmTxeqkO984Nkpdn0wYHvRsvqwa3n3snAjpHCzqUWdvMbIOcDMI/q5NEXimZRjshEm01d0arV3R+ZIpfZo6pTwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsdJe4OfSQOEmVQxsOWSY+M9FeqJcOpsNjwuAmUHvX8=;
 b=yoSIzGJFOGGxkxbGYlqTka2Yf+LB0FNVmfpdvjNpEy0O0FafQI8nU9/X+erzfvRB/b//zrzpp7Z+R18i/dAyz0kygXM1d6MWAuWRaADlljEos33fi+2utkm0hS5GFwAVjKvTZ5wvuxGh63lSUIfXH4u41EW1BpmjHhAZEKV4BJK9pa0kPDgtH4GlNPD61LpfUgJHJogTedNY1agh25wqDpgvZ+7ZLEsEDr4uWtasZN9Agp9K61qx/Hb4ipbUq9B00Ri3ZI5wFVm9hT19D7P2ogSoxfUEkAiU4qhY7LBEPdq+/oU9kuRdSYjzLrhMMb1NcgxEVp2NWq0sW+l0DKFhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsdJe4OfSQOEmVQxsOWSY+M9FeqJcOpsNjwuAmUHvX8=;
 b=LJFeSr8uA/zinFpGRHsM87mPynSyuDxEihXQqMAuKiBfgRYTbk3cHq+nDKKgE2dddbxRIB8kd5vpN4QzIOoTrURrOQSnm0YJI8pi5HNcrg4DmX0p4K/TK/pmyYgt+yY7XRoh3xSm+EuncHlaSv3bdix3Xy33Ko4C3lfZZhWoalCrfZgM8p1R6a8ovbctqcSj9Am/l78WVdjOByxhoTtWFedFhWOUddMP8jjUPegueHaZAdnqqLiUE3n9W9Fy/gTMkxgqRuEyhgM12+vNT5DV5cIFIS8xQbNmct5VzhOnIUjQ4BKisoU/zV8Q7MQ3lwpm9wiLICeMHY413DDtoP4ktA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB9384.namprd02.prod.outlook.com (2603:10b6:510:280::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Sat, 29 Aug
 2026 03:09:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:09:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "longli@microsoft.com" <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] hv_netvsc: Advertise the SR-IOV capability for
 CoCo VMs
Thread-Topic: [PATCH net-next] hv_netvsc: Advertise the SR-IOV capability for
 CoCo VMs
Thread-Index: AQGk4a8ZqhNfwmq7l8/WAss7xuEzJ7clA9Jw
Date: Sat, 29 Aug 2026 03:09:58 +0000
Message-ID:
 <SN6PR02MB4157708636A225F5FE223A2DD4AB2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260828212325.2309515-1-decui@microsoft.com>
In-Reply-To: <20260828212325.2309515-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB9384:EE_
x-ms-office365-filtering-correlation-id: 287c90e8-0b16-4f29-be44-08df057b0211
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|15080799012|51005399006|31061999003|37011999003|19110799012|8060799015|8062599012|2604032031799003|25010399006|24021099003|55001999006|40105399003|2607281247196008|12091999003|56899033|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FTbDwg6ktQyky//t+eLqyNL4QLi3HzPemqjKkm5rvuq25oay2zXrJOUctz0T?=
 =?us-ascii?Q?/W6QEuCiPMEA3fjXtSxq4V14M0wKdDhrg5Z40jzf7pDlVegYY+sl68RYY23p?=
 =?us-ascii?Q?KtYTU0P8zYvfVXqnrmyX/9nYfupv3QXPpxgQN97kTBtzXiJDji0vNemQx9xI?=
 =?us-ascii?Q?lSi/HFObEOYZYoqQeokpRbWmnSKE2r/6dQhxRG9IRg0/zfGVLo4smdMtOcFa?=
 =?us-ascii?Q?ghM5QSPIi1xkGztmyLvAhoAIkMbphHSHARLtKxpzsEjt150lZ0iFvYM6r7Nn?=
 =?us-ascii?Q?gFDGMSGtI3WDqgjS2fGX3yVySt5dExSn1Hmn8hZJkHNdBRzoEm8fDeKszzzB?=
 =?us-ascii?Q?aoY0ZQXzv3TohCMMxLmeq4wfkRV3ipKOBDpsA/qufElAtDEui3Pf3/ZSDo9M?=
 =?us-ascii?Q?N7D79Uk5h+Bh33Vt3TPyVpaBd510SF9FjaC7gm+nJDm1gmf3WBUy7BBl75E/?=
 =?us-ascii?Q?+Mnq8YIGey0CZ/QwcM5vIUjMMlwFhhFUZjI4v9FPBHBmDhBRL9C0Qhyx0CkN?=
 =?us-ascii?Q?v+KOBCbpRsykTlOaywhDgqwQNj5uXAMzY1P5+x5fsn9EmBNP6V4KwXWmDc7n?=
 =?us-ascii?Q?jhdX8OuuFJk0sF0bGux6dOagyyJ1R8EKXBTJin8Q9Ga95+PRch+a/WrYRd4k?=
 =?us-ascii?Q?evaLToXKWmY5Luzjw8eRFXgizARdaUujH137PCVKU6IhlypehvOGhce5mD/9?=
 =?us-ascii?Q?Y0/ZCtduopHAioFetmZ2Kad9pamHUEYKVjDNmH6wCtaffDhKU6nHviV+0osc?=
 =?us-ascii?Q?s+y8naHREhzXReqDUJTo8nfYy1nruXHKgLwq9NpfRNv1YNIQXndRgbiiKwtl?=
 =?us-ascii?Q?fdN8lAvKuSoCRvIDG36rZzEqSACl3nE3/DcBe1H14fv8FfYLVs3NaYiichsV?=
 =?us-ascii?Q?RuefyoZOsG8D8EyMUvx+ss0j7HaMLNXnyFCVgpqBuvqEjP2LAdzhbYW92jiG?=
 =?us-ascii?Q?q9u5JcI79sClCfjc1Y7evb76dm/6f6YLhWedwO5nL8KwpXxGId8/ZIHaxZon?=
 =?us-ascii?Q?SkK6wsaml5cMvQ3SUD4b7NFNwS8ZHe7OlrYs+LgjrDqYSGeATYpEBoT/Ql6C?=
 =?us-ascii?Q?rlprCnzuWE0UZZIrQVxfGqgJODV2+i2ynvLhgt+p8E5ZQrsQTys=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qlhe6KWlpyAOJGu0mFXVUiybPwSwrnK+0Zs3Z0tyQZaa1jvTQLJs1Tit6hW8?=
 =?us-ascii?Q?BmUHcf6IB0wapJYzjQjpIo4coaAEfZcc/X16UnXTOQPC8Vngn3bavtBXQ6XU?=
 =?us-ascii?Q?BOqUMO3eRs9+sxyydsb1EhXkvuGDK+DH+Vud+I4RBKEp0Gv5ILMVRmOlc8PK?=
 =?us-ascii?Q?XGRDVj6Hg4L9Q0Eg5FhRoHaNtVdgXTpJp4WeOLXBnzSVa/LN2A5O8uQ3UcrJ?=
 =?us-ascii?Q?L/EDogibmm8SX74GBtEEox+Dc2EWy13OMpA0eqca5LxBZhVSGNXowh1HYtk2?=
 =?us-ascii?Q?5veCg99hZNtRJxXT4B858eIuPGHPCPl4BsvZ4rJRELH9qKZms5tYc2Q30oNg?=
 =?us-ascii?Q?6xSl5DSSmEgvBpR3F7d+/cPBru9/kdwu3efQpP7bUMQMCZcZDyYOPdoLSIQc?=
 =?us-ascii?Q?NPjbzyOH6302LXm/xcgbH19ekzQnGRdvqDnJtKEzxOgKa2Ju8lMA+1IfiriY?=
 =?us-ascii?Q?erPz28sl+G8B+eQP3Sz0JJSIf7V6bYbdFYihEBus88k1zsXemkIlJ9Hkc4M6?=
 =?us-ascii?Q?KjsQruS612YVBYJLd/fauvCpJkWAb7VJPASQgwlbMlMx5yw8RHlH1q+Fj5Wx?=
 =?us-ascii?Q?+KzQdE1t4/9fp+jnULUsK8XN+JHpJhFTFVWz6sk0t51O3sNso5iBB8Hm0kFf?=
 =?us-ascii?Q?R2zP+zVOq5/jBfrr4BGhmICpx7252WqlshWKXokr1+h2heYWTBp2gvt6AlDs?=
 =?us-ascii?Q?7YANUi9g5YgSBDBLxqlpfE/GgzWB4YYQ8jw+5B47lf29DP4fExYtSfqYJ64f?=
 =?us-ascii?Q?b1ADR6k8LtANHUdJszkyMMybRXvXUlRdyndn7OaQU8NZXK7ZSFZctTXtxOoQ?=
 =?us-ascii?Q?1wDoQdIyuMtxf1XwwYbxcJOGAAE2DjlLe5VtT0dSFsddCq55uv6y3sfxZGnF?=
 =?us-ascii?Q?S1S9+3jZ97IB58HLqh/LGAmK+EO+Fudcp63UKyvJH8X4AquvT+NJ1fOpKIeo?=
 =?us-ascii?Q?Q+YItGszVsWDd5t1zQY1d5YZofshqNu4FfjqOszZP162LztAhsFcfefLCyUW?=
 =?us-ascii?Q?JJNY7U+gL5yzXD0DE6moLl9PZby/2JszN37ZND8XZixZ+JlmRF53uFQtl2OY?=
 =?us-ascii?Q?zJilj5MXU4aYQzs1t0oPFJDqRKKY2TUMbjAf1EF9xEJcT+gfD17UgpB30xmK?=
 =?us-ascii?Q?GrCsXvT8vnDn+6Id88yGJCzFKO1CG3IzuTohUqAn/FxJhhDTvwrc/ZrSSkWz?=
 =?us-ascii?Q?G5AcbfYrpRUoOCAdTBgrQUIP0ldG9XDKLV8HYo8VFoQKfi8cmfdFNPgk9Jv2?=
 =?us-ascii?Q?BaIus0ymXqH/qj4GQtShwZqNJ9JdPQ6nQEwJzIw8F2bPZO2RH9Q4+IJSf4DP?=
 =?us-ascii?Q?a7HIta9TUaNS6668dz18ohZwCz6WDRHV3rKoNUGDB6DPmOhGrj/j8jEEgij0?=
 =?us-ascii?Q?+ETxny8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 287c90e8-0b16-4f29-be44-08df057b0211
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2026 03:09:58.3248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9384

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, August 28, 2026 2:23 P=
M
>=20
> This basically reverts the Feb 2021 change:
> commit 96854bbda24f ("hv_netvsc: Restrict configurations on isolated gues=
ts")
>=20
> In Feb 2021, PCI device assignment for CoCo VMs on Hyper-V was not
> supported: if the host offered a PCI VF NIC device to the VM, the VM
> couldn't handle it properly, so the 2021 commit was made to tell the host
> "I'm unable to handle SR-IOV NICs, so please don't offer a VF to me".
> If the host offers a VF NIC to the VM anyway, the change to
> netvsc_receive_inband() ignores the VF NIC.
>=20
> Since Mar 2023, the VM is able to support PCI device assignment due to
> commit 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidenti=
al VMs")
> and related commits, so hv_netvsc can functionally work with a VF NIC, bu=
t
> we haven't advertised the SR-IOV capability because the MANA NIC driver
> (drivers/net/ethernet/microsoft/mana/) hadn't been hardened, so a
> malicious MANA NIC might be able to attack the VM.
>=20
> Recently, we have finished hardening the MANA driver, so we can safely
> use the MANA NIC in a CoCo VM now. Note: currently the MANA driver in a
> CoCo VM still uses bounce buffering (i.e. shared decrypted memory)
> for DMA. In the future, it will be able to use private encrypted
> memory for DMA with the help of TDISP.
>=20
> Now, advertises the SR-IOV capability for CoCo VMs.
>=20
> Note: for MANA to work properly for CoCo VMs, the following earlier
> commits are also required:
> commit 2e2a83b4998a ("net: mana: Validate the packet length reported by t=
he NIC")
> commit c72a0f09c57f ("net: mana: Sync page pool RX frags for CPU")
>=20
> Note: the host might offer a VF NIC device that's not MANA -- in that
> case, if the corresponding VF NIC driver isn't hardened for CoCo VMs,
> the driver should be blacklisted in CoCo VMs.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 5cd084e5696c..fc6548b16c91 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -625,10 +625,7 @@ static int negotiate_nvsp_ver(struct hv_device *devi=
ce,
>  	init_packet->msg.v2_msg.send_ndis_config.capability.ieee8021q =3D 1;
>=20
>  	if (nvsp_ver >=3D NVSP_PROTOCOL_VERSION_5) {
> -		if (hv_is_isolation_supported())
> -			netdev_info(ndev, "SR-IOV not advertised by guests on the host suppor=
ting isolation\n");
> -		else
> -			init_packet->msg.v2_msg.send_ndis_config.capability.sriov =3D 1;
> +		init_packet->msg.v2_msg.send_ndis_config.capability.sriov =3D 1;
>=20
>  		/* Teaming bit is needed to receive link speed updates */
>  		init_packet->msg.v2_msg.send_ndis_config.capability.teaming =3D 1;
> @@ -1665,10 +1662,7 @@ static void netvsc_receive_inband(struct net_devic=
e *ndev,
>  		break;
>=20
>  	case NVSP_MSG4_TYPE_SEND_VF_ASSOCIATION:
> -		if (hv_is_isolation_supported())
> -			netdev_err(ndev, "Ignore VF_ASSOCIATION msg from the host supporting =
isolation\n");
> -		else
> -			netvsc_send_vf(ndev, nvmsg, msglen);
> +		netvsc_send_vf(ndev, nvmsg, msglen);
>  		break;
>  	}
>  }

Nice to see this getting enabled!

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
