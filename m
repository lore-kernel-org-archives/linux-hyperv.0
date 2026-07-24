Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010004.outbound.protection.outlook.com [52.103.20.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEC447806;
	Fri, 24 Jul 2026 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921813; cv=fail; b=mjGeBhsBF7ZBBYe0YLhsLWzG2Cc7X58qsB/5U83IxwVkWLiQWex5i6ah4yXwqLytnuV8zGoV6HUzL9wJyBN/y8MVIta9hD7JP1+CxWcyiwH2y7bup7n28ttFax6mNRMYxd4zjn00XlslCVagsL47HfGcHw6UmLAQpNVAQoKJBVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921813; c=relaxed/simple;
	bh=mWHA9SrTwY2XXWvLoylb5HihL9rxOmaitHVtuKjQZaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ImBro4zLZaGVUtLXe3aiWL1mtHi05nye0xu/rytkEJpsxN/5ziv4LYRYpj7Lyev1pxVtmIY58no8/ML1J+VCV9140OtrG6w1kPJlW39Zvnjka0v9AXajHSr9bbCmIXAyPhRzAGuB2fCryQiQwD8a4bqfH+QSRYFSezCafnH/SVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FYF/91Rh; arc=fail smtp.client-ip=52.103.20.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FYF/91Rh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiIt/mBe2NRRSskgk0VHzgR+TrgDbcpeLPyI1fxhZLlh/q0T6XzuKCP/KdyreBw8Cc+CbFSrYvuxCeDH0jWqS5WSgeJH3tIN5Bx32MddaG99VBCQMcMM86TjS4lVgFMFWt0xKgyewy/8xirvk4ShChBD1QQL2x8vkfvRqBqytq33jtpUVxVjFU9kU9Lx9Nio6v83sgAOKMwWQMWiVjKlfNzhB+ZGKIkkSa5bwTJ7xAjLzf3Qo8vs9b72I7bRlLtJigWwe2bI84hWIomzYWH4FMfJGJP2LqVCXLyXMK1mj8ELgcNW8AMZ/ddbraGc51YEDfRhheMHsyLmJcq9b539BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYRwNd7YiDy2gbUP+UgjoyH6nX6v5A0rZBEJ7uuB0EQ=;
 b=iei53kWFQQEv/6MhnYGr+OihvRnIV5aAxzsscqbrs8w091cl4bnQqDrLCQKXi9IFG0oXDZfDL5go1dIUy1kKI1BtvBruTb9PHbbCNyN1ogw8gRhjMTsDRdpkvKUWRZPeRMQay22Jj9SMvdZwfMPnrGoqDgNNKFLHeDLTYrf+ueZXR+imE6VBy1e++eU2Nijb7E/xCXEcF9CSD1LAUEu9DIQAxTP9vLUaVBYsTXtv5oKFWRxTL8fhVuSeXy/unNEGyuzfz80pEdraHyJ+1Gv7JBb0I5kqYxbMClA/qDvxyLls0pg94f1QKX4YMbCAGaNutYsgyvMHwevik4PVqMP8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYRwNd7YiDy2gbUP+UgjoyH6nX6v5A0rZBEJ7uuB0EQ=;
 b=FYF/91RhjA5HnX/8e2OjRcyy8Okj9DO/eP7XzaEh49ev1Dz5Is6QDnG715/ABeSIucCC2FMSXOqlsg89ejMN48ABNMdaZqXH3ntp2FXEOtdbdV4kfUzohMuP43MQxKxa2UlZbjYKagEJIEFr+NeWy79Rgl1vFad8BLRWKDwk95vRBL3W7Wx/E9YaOdoE4okq3E9TL4Yx8jPLA9zLv5unBkw5m1TP90J/KZrXsv03VBqOZJEBOT7ZixSl23HxFRqdmTgyXwr6oFjksunUGdMvKebfHK9Z22PqH/ZGUcSpvZQqLkh70rpC+fhQoplJ/+aFcudeScsXYB+wwIDg6THolQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7191.namprd02.prod.outlook.com (2603:10b6:510:13::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 19:36:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 19:36:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Michael
 Kelley <mhklinux@outlook.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc +
 decrypt + vmap
Thread-Topic: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc +
 decrypt + vmap
Thread-Index: AQHdGUstWmkWeQ5MbUqxHXCQQLfsQ7Z9FO5w
Date: Fri, 24 Jul 2026 19:36:48 +0000
Message-ID:
 <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
 <20260721195633.1438361-3-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260721195633.1438361-3-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7191:EE_
x-ms-office365-filtering-correlation-id: d760c602-be67-4603-8131-08dee9bae712
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|41001999006|19110799012|8062599012|8060799015|31061999003|37011999003|24021099003|55001999006|15080799012|51005399006|25010399006|40105399003|12091999003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HvFqvdGMt++vXlwPVaJtp0Fm8zCN1oXA78IHIJb3n7F6GH23KotGg4h1E5Cw?=
 =?us-ascii?Q?3T/S5Ep9lM7AHIIN5/TZNA4nHSKp6JQxW3qYBTHY7F9b+KiHGN7mjFLtTVYK?=
 =?us-ascii?Q?DyNvegUt/kuDsepx7NudJ0jPPB9ieJiNShzfiD8ZNVUEKtxCQKujTL6RKwm8?=
 =?us-ascii?Q?W4NQerRkdhRtVulwwLkzeb47l1DLdCnrAKeZLgfA0Y0nS8c6mnuwowvCahZK?=
 =?us-ascii?Q?hrEvtpQmpAav2ToGGY/Sfc1dPIXgUtmon5vTPaC9Yh3SFsRrQv38tR3bovag?=
 =?us-ascii?Q?sg+8XMB4ZqDAnT3qmdFZXEsEryhacoVR2MqBzxhMvpV0wehS02OBrUuii6Hf?=
 =?us-ascii?Q?mVoEK0nx4e/si28nxfRzoWhOMzMceq2sOCKalBVzQXXmwf5/y0W25s0iUBr4?=
 =?us-ascii?Q?0P71tPioUfDJoLUQKAICLfjG4LgwtvregTYh7e1aSD+5+fkDFYkm4DOsyxDb?=
 =?us-ascii?Q?1wnnn7a5fzaN6Y+LND/gqK3Go4SozWBnguxOttfZDdRyY9Rd/zl/8pg+aOqs?=
 =?us-ascii?Q?qBEOwGjoteu5Jfi840ypjcPlsFXQwTixO0YeesTiSaWdHDQAHcPfetK/vzYZ?=
 =?us-ascii?Q?oiBIGeMhcTdlvalX38U4q0BcP26GPy8Dz5hBNsKMcJzwEmi0ZrLaN/RPZICq?=
 =?us-ascii?Q?Zr8xlA5aYvXmA2mwNIn4qtinT9xFNM25fWs7OQdUmqqlG00VIXQB7+mphxu7?=
 =?us-ascii?Q?64B6ezUQ+GooCMckjauscB21couLRMRlnnE+HfKZVFBpi5Qcqj1YPRTsmJx5?=
 =?us-ascii?Q?7uUVsr92FcNySbsISSMowbPUny6yk0ROtcXKP3K3NqaBo45XrIInFYEbgh+5?=
 =?us-ascii?Q?r1KldIPN6PPMDwEInJMIAkUHunQS/xciY9L5XW04h5/FCGnKh9phGnswe5zo?=
 =?us-ascii?Q?l9zPh3cQmjTfcwUN3BD1txaZWXQGJtQNx9eYKQ7uUKXc0EFEfMpWPLoXliF6?=
 =?us-ascii?Q?nmgh+A6fWaw0Q5LxG7QThve6NI0wblvYLugx1QOQAUV0rNnx9u8Efl8eh7ks?=
 =?us-ascii?Q?7hcwz4oMob5HVUwnbFoH67BT5isT2hvkLcj+Krv+BA84WQ8KxQuX20o/nWCg?=
 =?us-ascii?Q?LORjJQGn738QBhti4y6j6DvJMt/dRgFyZOIEEQxaNA+0iWDUQswNssoRYu2A?=
 =?us-ascii?Q?lphaIV0U8BQI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1Y9FVkr7vJmj2DVDvkqbar7PuHBT3bAXLFrRTqAQbeZWtwJWW9ac0HEkJ2h3?=
 =?us-ascii?Q?ORW1TIFH0oCR9ST4m+8UaUe2+kzn4WwXbTG13FEH0rDDPyNmAupAOwXTYmzj?=
 =?us-ascii?Q?NHhhhDCIQMiR/Q+Ag5oLCHKMnCYIXDIN06Lj0+9PxmDTx/IQdGzikXCXf/ks?=
 =?us-ascii?Q?HQaizao31zm/QEK2XxfWJho22wGsi20nhL3VWfP9EvEb0YTihPxNumSH71b+?=
 =?us-ascii?Q?v7dnVfM5eaSaFydZOigOp1k5A+uYbbxOEmtp15FdCMsgse+9k0HbXN5A+o/r?=
 =?us-ascii?Q?o8uvnLT5Y0Ey9DWKZVvkVkigcsY+TYT1YLhqdIHPomGkM3CYSxuqlCCLG/js?=
 =?us-ascii?Q?Ajv2VrhkyQrccD03DL+TmjSHqHEa2Tls0IFmoP0RM2eCBGZr0/eDsjVowPGW?=
 =?us-ascii?Q?jq2lmaZIj+PyKgYwThDuX/rtdwsW0l6EX56cTz1dYogVrB0CG+S+oxnKjDV4?=
 =?us-ascii?Q?HGf673aW/mXKnl4V5miSPYVPB5W/dQfCuIwB771eVyYKT6ARCUMioLdEuReQ?=
 =?us-ascii?Q?RQAi73l7vFhysu38GRfkrhYIAnyQ7BE3zSD7z5l2jU1CtiH+QQthc04Lon+r?=
 =?us-ascii?Q?cq00KstIMfJ49phGpKPQXH49DskUpagS/5gziZlFiaskGmSgklHA/oIbi4Pw?=
 =?us-ascii?Q?6jI4sotwsJHc1SGI6sa2hvMPn23JQleUkehhVlN0gUvgqBbVbHo/5p3z/0H7?=
 =?us-ascii?Q?8ypl+g0B9GjTvDA3fQEmWQWLSiFK1IZtOgrK/4fMzpPmRy2owOgN7WzkThoD?=
 =?us-ascii?Q?rMVy51mwzSq9rx8ZCGvgSD8qw9D1UZ/xt6T3abOESh3ji0gG4DUTPomLT040?=
 =?us-ascii?Q?5UXq+LDZNgbIlgXM6d7+aR0/ZYNB/ZOMRJ7+AM7kAyB1aPg3b5QkQmrDPhnW?=
 =?us-ascii?Q?1hXwukQASq+hdaJN3JOKLK6KhFP+KyMsgwrEn6O4RoiFLdnWUzwHeef68Yz6?=
 =?us-ascii?Q?VmcMYFS7Xv5vE5xoo6gmH6dTKMplQQYVaXwUCWfmycGnfnHKgoe8H8dIJ9I1?=
 =?us-ascii?Q?tU6XsSjbx4dk/n3zL3sPwh3Zb+T3/xePPqu8/EPHwIWy8bE5nvVT9IVgc27T?=
 =?us-ascii?Q?B/GYbsT1Juv8DPJH6cQGCptKORuoF/X1+UFEI0/Rba4BW1RRfmZoD2zZsi+g?=
 =?us-ascii?Q?Xd1RfK1TcYbyBFbyuqhCW5qD1PhzoCMxDUhat6vKERBaP8H4UdAdLd/TchKT?=
 =?us-ascii?Q?ChUynHDiqM7NbsOA0INuAJCv5Eh5EdzLnZzcno3KK/M0fEqzPqK4Vx1K13b5?=
 =?us-ascii?Q?gStHj7s2txXJCCh5yv/QgHB3J8yM2dmECLXz8iWsZDeBygmj10H6S0pd6KhH?=
 =?us-ascii?Q?XGF24vlHERqcL2nXJjq2CmLg5mTmE5Yhtv93261/BwRjpz7z2FF7BGOpAeah?=
 =?us-ascii?Q?GIDUikU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d760c602-be67-4603-8131-08dee9bae712
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 19:36:48.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7191

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, July 21=
, 2026 12:57 PM
>=20
> Allocate the buffer as a list of physically-contiguous chunks using
> alloc_pages_node() starting at MAX_PAGE_ORDER and falling back to smaller
> orders. Each chunk is transitioned to host-visible via
> set_memory_decrypted() on its direct-map address, then all chunks are
> stitched together via vmap() into a single virtually-contiguous address.

The commit message should describe the "why" and not just the "what".
So mention the high-level motivations for this approach:

1) Avoids the need for set_memory_decrypted()/encrypted() to work
on vmalloc'ed memory, since (so far) that requirement is specific to
the Hyper-V netvsc driver.

2) Minimizes scattering of decrypted 4 KiB pages through the kernel
direct map, with the resulting impact of shattering large page mappings.

3) Meets the requirement to allocate the large netvsc buffers if a
synthetic NIC is added after the kernel has been running a while and
memory is fragmented to the point that high order allocations fail.

>=20
> Use vmbus_establish_gpadl_caller_decrypted() so the vmbus layer doesn't
> try to decrypt the virtual address. At teardown, vunmap() the range and
> re-encrypt and free each chunk individually; any chunk that fails
> re-encryption is leaked to prevent accidentally freeing decrypted memory.
>=20
> Because vunmap() and set_memory_encrypted() must run in process context,
> replace the rcu_head/call_rcu() pair used to defer free_netvsc_device()
> with rcu_work/queue_rcu_work().

This special RCU handling points out a problem with the current
upstream code. I don't know the exact motivation, but presumably
the freeing of the large buffers is done after the RCU grace period
because the buffers might still be accessed by code in the networking
stack. In current code, tearing down the GPADL is done before doing
the RCU free. But tearing down the GPADL re-encrypts the large
buffer. Re-encryption is a multi-step process, and if the networking
stack should access the buffer at certain points in that process,
unhanded faults will occur. It's a small timing window on a
relatively infrequent operation, but it's a risk nonetheless.
This patch fixes the race condition.

>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  drivers/net/hyperv/hyperv_net.h |  18 ++-
>  drivers/net/hyperv/netvsc.c     | 271 ++++++++++++++++++++++++++++----
>  drivers/net/hyperv/netvsc_drv.c |   6 +
>  3 files changed, 261 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_=
net.h
> index 7397c693f984a..b0c4cb0f7a4ce 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -220,6 +220,8 @@ struct net_device_context;
>=20
>  extern u32 netvsc_ring_bytes;
>=20
> +int netvsc_workqueue_init(void);
> +void netvsc_workqueue_destroy(void);
>  struct netvsc_device *netvsc_device_add(struct hv_device *device,
>  					const struct netvsc_device_info *info);
>  int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_=
idx);
> @@ -1147,6 +1149,16 @@ struct netvsc_channel {
>  	struct netvsc_stats_rx rx_stats;
>  };
>=20
> +/* A physically-contiguous chunk of netvsc buffer.
> + *
> + * The chunk list is preserved so each chunk can be individually freed a=
t
> + * teardown.
> + */
> +struct netvsc_buf_chunk {
> +	struct page *page;
> +	unsigned int order;
> +};
> +
>  /* Per netvsc device */
>  struct netvsc_device {
>  	u32 nvsp_version;
> @@ -1158,6 +1170,8 @@ struct netvsc_device {
>  	/* Receive buffer allocated by us but manages by NetVSP */
>  	void *recv_buf;
>  	u32 recv_buf_size; /* allocated bytes */
> +	struct netvsc_buf_chunk *recv_buf_chunks;
> +	u32 recv_buf_chunk_cnt;
>  	struct vmbus_gpadl recv_buf_gpadl_handle;
>  	u32 recv_section_cnt;
>  	u32 recv_section_size;
> @@ -1166,6 +1180,8 @@ struct netvsc_device {
>  	/* Send buffer allocated by us */
>  	void *send_buf;
>  	u32 send_buf_size;
> +	struct netvsc_buf_chunk *send_buf_chunks;
> +	u32 send_buf_chunk_cnt;
>  	struct vmbus_gpadl send_buf_gpadl_handle;
>  	u32 send_section_cnt;
>  	u32 send_section_size;
> @@ -1193,7 +1209,7 @@ struct netvsc_device {
>=20
>  	struct netvsc_channel chan_table[VRSS_CHANNEL_MAX];
>=20
> -	struct rcu_head rcu;
> +	struct rcu_work rwork;
>  };
>=20
>  /* NdisInitialize message */
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 59e95341f9b1e..2505d10e22010 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -14,6 +14,8 @@
>  #include <linux/mm.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/set_memory.h>
>  #include <linux/slab.h>
>  #include <linux/netdevice.h>
>  #include <linux/if_ether.h>
> @@ -28,6 +30,8 @@
>  #include "hyperv_net.h"
>  #include "netvsc_trace.h"
>=20
> +static struct workqueue_struct *netvsc_wq;
> +
>  /*
>   * Switch the data path from the synthetic interface to the VF
>   * interface.
> @@ -125,6 +129,194 @@ static void netvsc_subchan_work(struct work_struct =
*w)
>  	rtnl_unlock();
>  }
>=20
> +/*
> + * netvsc_free_buf_pages - release a netvsc send/receive buffer.
> + *
> + * @addr: buffer address, or NULL if none was allocated (e.g. cleanup fr=
om a
> + *        failed allocation)
> + * @chunks: chunks array from netvsc_alloc_buf_pages(), or NULL
> + * @chunk_cnt: number of entries in @chunks
> + *
> + * When @chunks is NULL the buffer is a plain vzalloc() allocation.
> + *
> + * Otherwise tear down the vmap, and for each chunk re-encrypt and free
> + * the underlying pages. Any chunk that cannot be re-encrypted is leaked=
.
> + */
> +static void netvsc_free_buf_pages(void *addr,
> +				  struct netvsc_buf_chunk *chunks,
> +				  u32 chunk_cnt)
> +{
> +	u32 i;
> +
> +	if (!chunks) {
> +		vfree(addr);
> +		return;
> +	}
> +
> +	vunmap(addr);
> +
> +	for (i =3D 0; i < chunk_cnt; i++) {
> +		unsigned long vaddr =3D
> +			(unsigned long)page_address(chunks[i].page);
> +		unsigned int order =3D chunks[i].order;
> +
> +		if (set_memory_encrypted(vaddr, 1U << order))
> +			continue;
> +		__free_pages(chunks[i].page, order);
> +	}
> +
> +	kvfree(chunks);
> +}
> +
> +/*
> + * netvsc_alloc_buf_pages - allocate a virtually-contiguous, host-visibl=
e
> + * buffer for the netvsc send/receive area.
> + *
> + * @node: NUMA node hint (NUMA_NO_NODE for any node)
> + * @size: requested buffer size in bytes (rounded up to PAGE_SIZE)

A slight ambiguity about rounding up. Is the text here saying that the
requested size must already be a multiple of PAGE_SIZE, or that this
function will round up the requested size? I think it's the latter, so
maybe "(will be rounded up to PAGE_SIZE)" is more explicit and clear.

> + * @chunks_out: on success, set to the array of underlying chunks
> + * @chunk_cnt_out: on success, set to the number of chunks
> + *
> + * Allocates the buffer as a series of physically-contiguous chunks,
> + * starting at MAX_PAGE_ORDER and falling back to smaller orders on
> + * allocation failure. Each chunk is transitioned to host-visible via
> + * set_memory_decrypted() on its direct-map address, then all chunks are
> + * combined into a virtually-contiguous range via vmap().
> + *
> + * Return: the vmap()ed virtual address, or NULL on failure.
> + */
> +static void *netvsc_alloc_buf_pages(int node, u32 size,
> +				    struct netvsc_buf_chunk **chunks_out,
> +				    u32 *chunk_cnt_out)
> +{
> +	u32 nr_pages =3D PFN_UP(size);
> +	struct netvsc_buf_chunk *chunks =3D NULL;
> +	struct page **pages =3D NULL;
> +	unsigned int order;
> +	u32 chunk_cnt =3D 0;
> +	u32 page_idx =3D 0;
> +	u32 remaining =3D nr_pages;
> +	void *addr;
> +	u32 i;
> +	int ret;
> +
> +	*chunks_out =3D NULL;
> +	*chunk_cnt_out =3D 0;
> +
> +	if (!nr_pages)
> +		return NULL;
> +
> +	/* Worst case: every chunk is a single page. */
> +	chunks =3D kvmalloc_array(nr_pages, sizeof(*chunks),
> +				GFP_KERNEL | __GFP_ZERO);
> +	if (!chunks)
> +		goto err;
> +
> +	pages =3D kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		goto err;
> +
> +	/*
> +	 * @order monotonically decreases across iterations
> +	 *
> +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing, but try
> +	 * harder at order 0 since that is the final fallback.
> +	 */
> +	order =3D min_t(unsigned int, MAX_PAGE_ORDER, ilog2(nr_pages));

Prefer using min() instead of min_t(). For normal integer values,
min() should work correctly.

> +	while (remaining) {
> +		struct page *page;
> +		gfp_t gfp;
> +
> +		order =3D min_t(unsigned int, order, ilog2(remaining));

Same here.

> +
> +		for (;;) {
> +			gfp =3D GFP_KERNEL | __GFP_ZERO;
> +			if (order)
> +				gfp |=3D __GFP_NORETRY | __GFP_NOWARN;
> +			page =3D alloc_pages_node(node, gfp, order);
> +			if (page)
> +				break;
> +			if (!order)
> +				goto err;
> +			order--;
> +		}
> +
> +		ret =3D set_memory_decrypted((unsigned long)page_address(page),
> +					   1U << order);
> +		if (ret) {
> +			/*
> +			 * set_memory_decrypted() failed; the page state is
> +			 * unknown so it must be leaked rather than freed.
> +			 */
> +			goto err;
> +		}
> +
> +		chunks[chunk_cnt].page =3D page;
> +		chunks[chunk_cnt].order =3D order;

Is it necessary to explicitly save "order" in the chunks array? For
contiguously allocated memory like this, where "page" is a
struct page *, I think netvsc_free_buf_pages() can do

    folio_order(page_folio(page))

to get the order. =20

> +		chunk_cnt++;
> +
> +		for (i =3D 0; i < (1U << order); i++)
> +			pages[page_idx++] =3D page + i;
> +
> +		remaining -=3D 1U << order;
> +	}

The memory was zero'ed before decryption. But after decryption, it
may no longer be zero, depending on the underlying hardware. TDX
zero's the memory after decryption. But SEV-SNP does not. I'm unsure
about CCA.

It's not clear to me that these buffers really *need* to be zero'ed
for netvsc's purposes, but historically they have been, so you would
need to zero the full buffer again. It's probably best to do it a few lines
below as a single operation using the vmap() address.

> +
> +	addr =3D vmap(pages, nr_pages, VM_MAP, pgprot_decrypted(PAGE_KERNEL));
> +	if (!addr)
> +		goto err;
> +
> +	kvfree(pages);
> +	*chunks_out =3D chunks;
> +	*chunk_cnt_out =3D chunk_cnt;
> +	return addr;
> +
> +err:
> +	kvfree(pages);
> +	netvsc_free_buf_pages(NULL, chunks, chunk_cnt);
> +	return NULL;
> +}
> +
> +static void __free_netvsc_device(struct netvsc_device *nvdev)
> +{
> +	int i;
> +
> +	kfree(nvdev->extension);
> +
> +	netvsc_free_buf_pages(nvdev->recv_buf, nvdev->recv_buf_chunks,
> +			      nvdev->recv_buf_chunk_cnt);
> +	netvsc_free_buf_pages(nvdev->send_buf, nvdev->send_buf_chunks,
> +			      nvdev->send_buf_chunk_cnt);
> +	bitmap_free(nvdev->send_section_map);
> +
> +	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
> +		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
> +		kfree(nvdev->chan_table[i].recv_buf);
> +		vfree(nvdev->chan_table[i].mrc.slots);
> +	}
> +
> +	kfree(nvdev);
> +}
> +
> +static void free_netvsc_device(struct work_struct *w)
> +{
> +	struct rcu_work *rwork =3D to_rcu_work(w);
> +
> +	__free_netvsc_device(container_of(rwork, struct netvsc_device, rwork));
> +}
> +
> +int netvsc_workqueue_init(void)
> +{
> +	netvsc_wq =3D alloc_workqueue("hv_netvsc", WQ_UNBOUND, 0);
> +
> +	return netvsc_wq ? 0 : -ENOMEM;
> +}
> +
> +void netvsc_workqueue_destroy(void)
> +{
> +	rcu_barrier();
> +	destroy_workqueue(netvsc_wq);
> +}
> +
>  static struct netvsc_device *alloc_net_device(void)
>  {
>  	struct netvsc_device *net_device;
> @@ -143,36 +335,18 @@ static struct netvsc_device *alloc_net_device(void)
>  	init_completion(&net_device->channel_init_wait);
>  	init_waitqueue_head(&net_device->subchan_open);
>  	INIT_WORK(&net_device->subchan_work, netvsc_subchan_work);
> +	INIT_RCU_WORK(&net_device->rwork, free_netvsc_device);
>=20
>  	return net_device;
>  }
>=20
> -static void free_netvsc_device(struct rcu_head *head)
> -{
> -	struct netvsc_device *nvdev
> -		=3D container_of(head, struct netvsc_device, rcu);
> -	int i;
> -
> -	kfree(nvdev->extension);
> -
> -	if (!nvdev->recv_buf_gpadl_handle.decrypted)
> -		vfree(nvdev->recv_buf);
> -	if (!nvdev->send_buf_gpadl_handle.decrypted)
> -		vfree(nvdev->send_buf);
> -	bitmap_free(nvdev->send_section_map);
> -
> -	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
> -		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
> -		kfree(nvdev->chan_table[i].recv_buf);
> -		vfree(nvdev->chan_table[i].mrc.slots);
> -	}
> -
> -	kfree(nvdev);
> -}
> -
>  static void free_netvsc_device_rcu(struct netvsc_device *nvdev)
>  {
> -	call_rcu(&nvdev->rcu, free_netvsc_device);
> +	/*
> +	 * Defer the actual free to process context: vunmap() and
> +	 * set_memory_encrypted() cannot run from RCU softirq context.
> +	 */
> +	queue_rcu_work(netvsc_wq, &nvdev->rwork);
>  }
>=20
>  static void netvsc_revoke_recv_buf(struct hv_device *device,
> @@ -351,7 +525,20 @@ static int netvsc_init_buf(struct hv_device *device,
>  		buf_size =3D min_t(unsigned int, buf_size,
>  				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
>=20
> -	net_device->recv_buf =3D vzalloc(buf_size);
> +	if (device->channel->co_external_memory) {
> +		/* Confidential VM Bus leaves buffer encrypted */
> +		net_device->recv_buf_chunks =3D NULL;
> +		net_device->recv_buf_chunk_cnt =3D 0;
> +		net_device->recv_buf =3D vzalloc(buf_size);
> +	} else {
> +		/* Otherwise, allocate decrypted buffer */
> +		net_device->recv_buf =3D
> +			netvsc_alloc_buf_pages(cpu_to_node(device->channel->target_cpu),
> +					       buf_size,
> +					       &net_device->recv_buf_chunks,
> +					       &net_device->recv_buf_chunk_cnt);
> +	}
> +

I have several thoughts about this code, and the similar code below
for the send buffer.

Deciding whether to allocate decrypted or not in the netvsc driver
seems out-of-place. That decision should be in the VMBus code. I'd
recommend renaming and moving netvsc_free_buf_pages() and
netvsc_alloc_buf_pages() to drivers/hv/channel.c where the GPADL
code is. Then make the decision about decrypting in the new
vmbus_alloc_buf_pages() function and fallback to vzalloc() when
not decrypting. That way vmbus_alloc_buf_pages() will more
closely parallel vmbus_free_buf_pages(), which already has
code for the vfree() case. The recv_buf_chunks and
recv_buf_chunk_cnt fields stay in struct netvsc_device, and are
passed into vmbus_alloc/free_buf_pages().

In the new vmbus_alloc_buf_pages(), the decision to decrypt or not
is more complicated than you have here. A "normal" VM (i.e., not
Confidential) has co_external_memory set to false, so as coded here,
a normal VM takes the decrypted path instead of doing just vzalloc().
That actually works because set_memory_decrypted() and
pgprot_decrypted() are no-op's in a normal VM. Still, I think it's
probably better to do just vzalloc() in a normal VM and let vzalloc()
handle populating the pages, since there's no scattering problem
to ameliorate.

That's my comments for now. Next week, I may look at some
areas more closely, but don't necessarily wait for those
additional comments before spinning a new version.

Michael


>  	if (!net_device->recv_buf) {
>  		netdev_err(ndev,
>  			   "unable to allocate receive buffer of size %u\n",
> @@ -367,9 +554,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	 * channel.  Note: This call uses the vmbus connection rather
>  	 * than the channel to establish the gpadl handle.=09
>  	 */
> -	ret =3D vmbus_establish_gpadl(device->channel, net_device->recv_buf,
> -				    buf_size,
> -				    &net_device->recv_buf_gpadl_handle);
> +	ret =3D vmbus_establish_gpadl_caller_decrypted(device->channel,
> +						     net_device->recv_buf,
> +						     buf_size,
> +						     &net_device->recv_buf_gpadl_handle);
>  	if (ret !=3D 0) {
>  		netdev_err(ndev,
>  			"unable to establish receive buffer's gpadl\n");
> @@ -457,7 +645,19 @@ static int netvsc_init_buf(struct hv_device *device,
>  	buf_size =3D device_info->send_sections * device_info->send_section_siz=
e;
>  	buf_size =3D round_up(buf_size, PAGE_SIZE);
>=20
> -	net_device->send_buf =3D vzalloc(buf_size);
> +	if (device->channel->co_external_memory) {
> +		/* Confidential VM Bus leaves buffer encrypted */
> +		net_device->send_buf_chunks =3D NULL;
> +		net_device->send_buf_chunk_cnt =3D 0;
> +		net_device->send_buf =3D vzalloc(buf_size);
> +	} else {
> +		/* Otherwise, allocate decrypted buffer */
> +		net_device->send_buf =3D
> +			netvsc_alloc_buf_pages(cpu_to_node(device->channel->target_cpu),
> +					       buf_size,
> +					       &net_device->send_buf_chunks,
> +					       &net_device->send_buf_chunk_cnt);
> +	}
>  	if (!net_device->send_buf) {
>  		netdev_err(ndev, "unable to allocate send buffer of size %u\n",
>  			   buf_size);
> @@ -470,9 +670,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	 * channel.  Note: This call uses the vmbus connection rather
>  	 * than the channel to establish the gpadl handle.
>  	 */
> -	ret =3D vmbus_establish_gpadl(device->channel, net_device->send_buf,
> -				    buf_size,
> -				    &net_device->send_buf_gpadl_handle);
> +	ret =3D vmbus_establish_gpadl_caller_decrypted(device->channel,
> +						     net_device->send_buf,
> +						     buf_size,
> +						     &net_device-
> >send_buf_gpadl_handle);
>  	if (ret !=3D 0) {
>  		netdev_err(ndev,
>  			   "unable to establish send buffer's gpadl\n");
> @@ -1863,7 +2064,11 @@ struct netvsc_device *netvsc_device_add(struct hv_=
device *device,
>  	netif_napi_del(&net_device->chan_table[0].napi);
>=20
>  cleanup2:
> -	free_netvsc_device(&net_device->rcu);
> +	/*
> +	 * net_device was never published, so we don't need to wait for an
> +	 * RCU grace period -- call the free routine synchronously.
> +	 */
> +	__free_netvsc_device(net_device);
>=20
>  	return ERR_PTR(ret);
>  }
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index ee5ab5ceb2be2..1d43c73fd73f1 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2867,12 +2867,17 @@ static void __exit netvsc_drv_exit(void)
>  {
>  	unregister_netdevice_notifier(&netvsc_netdev_notifier);
>  	vmbus_driver_unregister(&netvsc_drv);
> +	netvsc_workqueue_destroy();
>  }
>=20
>  static int __init netvsc_drv_init(void)
>  {
>  	int ret;
>=20
> +	ret =3D netvsc_workqueue_init();
> +	if (ret)
> +		return ret;
> +
>  	if (ring_size < RING_SIZE_MIN) {
>  		ring_size =3D RING_SIZE_MIN;
>  		pr_info("Increased ring_size to %u (min allowed)\n",
> @@ -2890,6 +2895,7 @@ static int __init netvsc_drv_init(void)
>=20
>  err_vmbus_reg:
>  	unregister_netdevice_notifier(&netvsc_netdev_notifier);
> +	netvsc_workqueue_destroy();
>  	return ret;
>  }
>=20
> --
> 2.45.4
>=20

