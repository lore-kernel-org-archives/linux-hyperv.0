Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011066.outbound.protection.outlook.com [52.103.23.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288ED5218BB;
	Tue, 13 Oct 2026 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913943; cv=fail; b=PZfa99YnobuQE0P04/dcUq0qqrQAjbY9b22/+8v9eaXedExSkKuANSjprSJo5qglvAJX9lTdHKsAoczs/PcczBG73NPYeZ9OvSObMSzXAQjQQtLWusEZ+J58ZdPcwUquubQfXoMG3mFVghXbwiG6zEPfumjrU4c8rPJO5FO8noU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913943; c=relaxed/simple;
	bh=D8rV9iI1SCxhT+ZpsxeRJ6if660b6ajr6onM2Ju50+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXd28iT97oog2D2o4DZPnGeXn2Usgd0+G60pLjDEAWrMazJgoL1S1xN8v19bqLW5EH1zJOSKDqVXBbXpo+HNlejRfkcWhOXIcz3jfwwyh5HWnYrk+6hOxiSTAhJBP7mBIwNO7u42vTiTwvmSAKgA+MUORXYh9NPXc4ySzCMlv+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rVh4k6FK; arc=fail smtp.client-ip=52.103.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rVh4k6FK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QILKTRvExGxLyHIvrG6mS8ce8YjJFLxlO3PvYsKi8W2bca/yBrcJLbWp/YWlWIltee1qzsAhRFFTRe6sqGFGQlagWNaMk4vFzVg1LJ5taT8oxqaJVVFT3gejxClX4BFdOVU5eFbj+Tv+v+Nk+NpmDPqYLaoZDjiMvi+NItG7NQ5rMBuQ5ZuQTAUeG38aPqvktct4XQQKTFFW4ZKxYhN1PBHSE6evVaJwZSJh7+UYOE3x95GYNBp+qVopvla4rQyHQYvDig3TcJHfdiZjvzTbyGyho5gtW/WHB4OKvEXRHw+kPh8NiFR8G/RjqCZZEyAqTKSKlfNwmmh/ONq8bSI+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DMRFw1JYZeMYFjIqyYiRb4WdL4g69Cry+RjDE+GOqI=;
 b=QsHnsqpJAx2fe33SERcWCNr4ybDf2bwR/fPP5/Dw8qrstGaD2w0ISs65X+zyITpVJ0Oq+uZUs9ChYx9QYqIb745KP8tUswjxXKV19Jj72C0i8evUz24tcKx30nTsjKmuRBBvkwswEQ1JorwIyTsJ5sQPsvs3Nyx2xtog8gfdh1DVpXkWGIHNIZYsMaSVX1a3h5mqq3nZj6KUDoOnbIel36uHz6aAEniQswKPb90FJP/L+rD9JSBOw2UgtSk98QMff2Pk0QDvaeJVTsyvl00ww2KS5oQbtvAivxMhHYIJQeOFAcUb0OxiVOqtP/6eHGBBGZJryYRoScDJxkMKCWfQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DMRFw1JYZeMYFjIqyYiRb4WdL4g69Cry+RjDE+GOqI=;
 b=rVh4k6FKdEx4I9M4CKMPiZWY9iYm41g8SyHnsEGCsbKeAyYuUZU/m9OfA3leoRpAxgPKgauIs2bAac/o6V/VaOr2A6EGRyHWkNvbWbsj0azPmUfwyi7iHUUpfTxHXb+6+D0a7pfj/CIoaIe2fxk5Na3pFq77tcFX1+z++BIC0v/pMKtUobYLK80NllrEC8qvQw74INrKl95EqmMUL9s8i3Iv0rmICTjnuST+2AQx59uZTam1mV93SqId3aS4aXTNhiLMfvsIAxBSJMXBpquVWvp0KzuhXmCfNa9CaIEeZ5aJ23Crgbi2Wu+YXcggTaTXqDikxljkxamvBngoRir3oA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CY8PR02MB9504.namprd02.prod.outlook.com (2603:10b6:930:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 13 Oct
 2026 17:52:18 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0522.012; Tue, 13 Oct 2026
 17:52:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Emerson Busson <emersonbusson@gmail.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 0/14] hv: vmbus: make rings and host-visible buffers
 survive buddy fragmentation
Thread-Topic: [PATCH v2 0/14] hv: vmbus: make rings and host-visible buffers
 survive buddy fragmentation
Thread-Index: AQHdVo8tr0L/zHk2U0G7iReSi7jjmrb7ygzQ
Date: Tue, 13 Oct 2026 17:52:17 +0000
Message-ID:
 <MN2PR02MB6863F3AF7D339B117A71F4A3D49E2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CY8PR02MB9504:EE_
x-ms-office365-filtering-correlation-id: 2567ae96-08e5-45f3-a6f6-08df2952b92b
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|25010399006|12121999013|37011999003|15080799012|55001999006|8060799015|8062599012|13091999003|19110799012|24021099003|31061999003|51005399006|40105399003|12091999003|1602099012|10035399007|30101999006|2607281247196008|102099032|56899033|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Wm5LKyDN+n4DChUlS23TOWPJpAXH8CxJk2bdDFYCKYn0zTc3U9Kt7FjqZL8I?=
 =?us-ascii?Q?gQrfbMbzj5o5kDZyv9EJKArkC7By8RJieIi3Osizxx9gRj71XB67Gn+usc32?=
 =?us-ascii?Q?uF1T3/Yt7ZsK36FmqMoxcjJ+qmp9mqKbtA6QA/25GapAKKUD3pfu+0cd6q7B?=
 =?us-ascii?Q?0Tyg6VByg5VI6nnmb8wbdDM34XGid2LFVH+CSjSVSAQSZEuaU2ZS2whFBLQl?=
 =?us-ascii?Q?DMCV+PUyqyZ4vKhVvyitO9THuB72wpe0mD6iCiRYXZYnl+Qgjbz+yYji9Rns?=
 =?us-ascii?Q?jTnsOilDvsuDrDmMfjwwipGkQJcXzeqTa6nWuhgMemCER588k0DIEj6gpcbI?=
 =?us-ascii?Q?uKjnnoWd3Aqozcgu0dZXc3NV9x1XZ7bSo+0PAs8OSHpqBepzXCbs/C7N+rs9?=
 =?us-ascii?Q?qzuE4UfpQKwtyq8ineI5opAZcdjN0djc/ZfsWejilJ3Dp2jh9VP0VeN9S1BY?=
 =?us-ascii?Q?1IC6SLlMkXwQUx8TaYfHe5OC2WDf3aAfvgquiwIOwVW3re4glbivJj9BpMN4?=
 =?us-ascii?Q?B9sNmDbxN4y/QQiT+BS5h9Jov08KtAW0HYfQC1UYMzkbWcMYIMoIXJ7Lv1CQ?=
 =?us-ascii?Q?XB6uLby1Jl1mbLcLHi1ls+TT7AEjqQ3rULUvUCzeJHgkpZ/5QRsSQuQnD2HK?=
 =?us-ascii?Q?YSG+uyYB2bquP4gUmVXGwgpXynRWhCNf2p2ZNge6vAGTPDSRwuEGwAtULNYz?=
 =?us-ascii?Q?OzvrTObeKl1UmfIPSPAIBEEPYs13/G5NaIALRWBBA2EDtgYa/jGtFF10dWX/?=
 =?us-ascii?Q?9c0MQWxKG+duEdYo/HO9qs9Tt0nu6+ClT+BUaKUMdytbAl7zEPFY2X7J7skZ?=
 =?us-ascii?Q?nR6U7Q5yFxuyKR/fZvbefJts7Jg2SMXV9zTmOdSa9ePGXp4j8sp1brRE4NB1?=
 =?us-ascii?Q?yVUQaTpY28nOLRhXRacGagyQfvxSl+vbIq07eiCez2aGJNbTuo97SxYCuZaO?=
 =?us-ascii?Q?BX/q/B3zCJIbQFOO617TXk8XSb9YF2bgvSxzkbUhRbk20MXd6hWRvj6fKhIy?=
 =?us-ascii?Q?AzDYtSl+fJU24xoCcRcHBOUKSv4pRI1pFiEKjwBvbOSbEVGhH7UkskLO2HJK?=
 =?us-ascii?Q?CK/JN8yZj1uAhoLwoUxbv8IRDq3isFcAM9dxz71sEgSrnyzOBpmbwoJkeWng?=
 =?us-ascii?Q?dom9d3lozNqyByhrlLfavE8/OxE8p9CcuuHesIYGEq3cvuY1y6YIPx/+dFul?=
 =?us-ascii?Q?V6PjlOnipjEobNhNbFellMNm2HS+wmE9gBnGMg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U4cArK+6U90w7h6jJbz1Gmgejsf4noBEdWLCI2CrqB3q4bmYIfm4t7njhhwJ?=
 =?us-ascii?Q?hezP1bu8SgeSDCr3vCXATljXQeILLQdewNsFnz0CAZFNfkKDDO5B0XKTmCmm?=
 =?us-ascii?Q?UfqLlRu2hTJyAE+awmdSIc58LpiSMNw3ixA1dLQFNkATDNo52N1ZN3H29e4m?=
 =?us-ascii?Q?GVVdD7BXpwiJCellJJ3zNcYZIaXPNsFrfGD1yjEeWUkzjOT1GeNczLtDJawp?=
 =?us-ascii?Q?TylqI+lfxVMQSHStZ3q7wS/3AXknpLGqZymrXgNLU5PAVj1eHmXe9ivgtgWE?=
 =?us-ascii?Q?5AdcaR/aDX/LFBe3f2W6AcdwFxSaVw/CZ0ZVGcVSd4oGNv2ukvL8XvSQVmMH?=
 =?us-ascii?Q?OZQxvGHnc1WUqxbYavD5/VfUkUJ4NfwwR2s9yj9L7uxpqdZ3gd/jR/sSXjuk?=
 =?us-ascii?Q?dASMIa/f2jGrx7563RvHn7a/iIUXjk6tFiEf66azQlLCJvM+kKMvJvPyZFgr?=
 =?us-ascii?Q?hBDC4WbiuAE8QmBNKmtqE5qkklX1hi0v03pn5XsqOovv/L0BC4vbEGnTUJgz?=
 =?us-ascii?Q?gxXXbPfktAbr7dcEBUGoWG/MqYCgnx/fjZ0gDmnH9cm++//3R0XKYFibVRiC?=
 =?us-ascii?Q?sM2B+Lw2oK179caLO7Onn9PDANUwFhBP2B6lM2Pgl0+w3Tq4ZmEkfCFLqsGE?=
 =?us-ascii?Q?FwsE7awdfnnQ902zwuS7nhxDtZqzMNAE9YFaUbTfjInpUOHpeoORgwnZKa7l?=
 =?us-ascii?Q?0inMWRHn2omtOFdh1253MTkilRxNNyks97Gm3Ntb9UXr6a884ox5TEMF2sGS?=
 =?us-ascii?Q?y9gVA+lIVhm9TudrcY6DoN7C7Hth4XKe5KPQnYiS2FK9KAOzl0zYizLaPST2?=
 =?us-ascii?Q?RShM8A68FaQW9x5jVv0JDsYV2fe2pCHEN+ockLGMKiZayzRKL6li7N/4GGWe?=
 =?us-ascii?Q?dnCny2XcOVIWvtP6m93pALBDiDCSslfCPoJs3X3MgxoUfbxzlA2f+es+KM2K?=
 =?us-ascii?Q?qNAnG1OXeBnL3E7A8ON09LOfXOBKCy3fFvE5jpMGFQ33KG9M7Jnoj/B0cGzC?=
 =?us-ascii?Q?qLNQm7EoKl1rF/8OAasbx/g2lqjVWIavzJv771rHZiMBUnL8XcKJofly3fNP?=
 =?us-ascii?Q?30fzMtoWbtrSKzFKOMvpz/qKyUc2vFS77SnDAuiAhdb26EGgzFeFVDllRsiP?=
 =?us-ascii?Q?OgBT+bThbb88qy6uDu2QsiVVlYfYXYw85WszS98nAEXrA9o4mCNKXnG38/li?=
 =?us-ascii?Q?DjpnHOZYglPpets8LvNvVRWkXzNROjDLYPbWGLXqtsl+GRHQ/f7gi5oOLaHb?=
 =?us-ascii?Q?/qUtSaSlAxP6XGQLjhXvaFAdZNcGxDKby0GZPsqJiQh3up5xoK+dKHN22QvW?=
 =?us-ascii?Q?S+akUPEVflUb/ctcaap8GlSBG3Dd4Dqkbb9OVv222n5r/rxzW8MAEjBsyoBU?=
 =?us-ascii?Q?8Q3ul+c=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2567ae96-08e5-45f3-a6f6-08df2952b92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 17:52:18.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9504

From: Emerson Busson <emersonbusson@gmail.com> Sent: Wednesday, October 7, =
2026 12:08 PM
>=20
> This series moves VMBus ring backing to the chunk allocator and keeps the
> allocation, GPADL ownership, and mapping references together. It preserve=
s
> the exported four-argument interfaces while allowing the private allocati=
on
> paths to carry ownership and sharing policy.
>=20
> A review of the original vzalloc fallback noted that CCA and TDX guests
> without a paravisor need direct-map page transitions. This revision uses
> contiguous chunks for buffers that must be host-shared, transitions each
> page through page_address(), and combines the chunks with vmap(). Ordinar=
y
> guest-private buffers retain vzalloc-style allocation.
>=20
> Allocation and compatibility
> ----------------------------
>=20
> Every ring allocation uses the chunk allocator. Ordinary guests and buffe=
rs
> kept private by channel policy use vzalloc(). For host-shared buffers in =
an
> encrypted or isolated guest, the allocator uses contiguous chunks and
> transitions them page by page. Guest-memory encryption is selected
> independently of Hyper-V isolation.
>=20
> Ring consumers select co_ring_buffer. External buffers and the legacy
> allocator select co_external_memory. The exported allocator and caller-
> decrypted GPADL prototypes retain four arguments throughout all fourteen
> patches. UIO migration follows its release support.
>=20
> The address, page and chunk arrays, and embedded GPADL belong to one buff=
er.
> The allocation extent, host-described GPADL extent, and retained allocati=
on
> extent remain distinct. Interior GPADL duplication preserves the existing
> exported interfaces. Prepared owned buffers avoid repeat decryption, and
> HV_GPADL_BUFFER_DECRYPTED is removed.
>=20
> Lifetime and host acknowledgement
> ---------------------------------
>=20
> A host rescind alone does not prove GPADL revocation. For a known-live GP=
ADL
> whose channel identifier is still held, teardown posts a request and wait=
s
> for a matching GPADL_TORNDOWN message before clearing ownership. Syntheti=
c
> rescind notification cannot replace this acknowledgement. Unknown creates=
,
> local removal, invalid identifiers, failed posting, and timeouts retain
> ownership.
>=20
> Waiter removal shares the response-list lock with matching replies so a l=
ate
> acknowledgement cannot use a freed waiter. Released owners retain pages
> across mapping references and failed page-state restoration. Reclaimer
> shutdown cancels pending timers under the owner lock and requeues only wo=
rk
> that was actually canceled; running callbacks drain through workqueue
> destruction without re-executing freed embedded work.
>=20
> Sysfs mappings install no vm_ops and release the bridge pin on every setu=
p
> outcome. UIO mappings hold their pin through VMA close. Page, count, and
> protection snapshots share the owner-lock boundary. New tests call the re=
al
> sysfs wrapper, insert actual PTEs, and check readable bytes and page
> references through success and partial -EBUSY. They do not execute a full
> kernfs syscall or full device destruction.
>=20
> The final four fixes use vzalloc() for guest-private requestor arrays and
> bitmaps, kvzalloc_obj() for guest-private RNDIS descriptors, handle NULL
> control requests on empty NetVSC completions, and use kvzalloc_obj()/kvfr=
ee()
> for the large guest-private NetVSC device object.
>=20
> Qualification on the exact fourteen-patch series
> ------------------------------------------------
>=20
> The code mails are pinned by series/SHA256SUMS. Applying all fourteen to
> 93f51579e7df248780214094418f205253383cc5 produces source tree
> e6fe523ca92ce30ea7edb265b8a26bf20a867c47.
>=20
> The VMBus workflow builds x86_64 and arm64 with W=3D1 and C=3D2, passes s=
parse,
> and passes all 69 linked x86_64 QEMU KUnit cases. The distinct WSL backpo=
rt
> passes all 26 of its KUnit cases. CoCo source invariants pass on both
> architectures; these are necessary static checks, not confidential-hardwa=
re
> qualification.
>=20
> Exact-source Hyper-V runtime, including controlled host rescind:
> https://github.com/emersonbusson/WSL2-Linux-Kernel/actions/runs/376504680=
77
>=20
> On both windows-2025 and windows-latest, the candidate passes 100 bind/un=
bind
> cycles, bounded buddy fragmentation, channel rebind, UIO mapping teardown=
,
> and the controlled host-origin NIC removal. Each report records
> HYPERV_DRILL_HOST_RESCIND status=3DPASS, target_absent=3Dyes,
> matching_events=3D1. Both report zero splats and faults, restore the meas=
ured
> kernel settings, and return lifecycle map accounting to the settled opera=
tional
> baseline. Captured owner accounting reports 722 created, zero unobserved
> creates, 715 reclaimed, and seven still active; active owners are not
> classified as leaks. Trace capture has no overruns or dropped events, and
> the disposable VM, VHD, and switch cleanup passes.
>=20
> The baseline is an intentional negative control. It reproduces the expect=
ed
> fragmented-allocation failure without guest faults; the workflow accepts
> that exact signature as a passing control. It is not a candidate result.
>=20
> WSL backport runtime matrix:
> https://github.com/emersonbusson/WSL2-Linux-Kernel/actions/runs/376457081=
53
>=20
> That separate backport passes the actual Windows candidate matrix. Each
> runner completes 64 commands with matching teardown acknowledgements,
> zero unacknowledged requests, no backing or tail growth, and all six
> shutdown checks. The shutdown retry path is covered by 40 local parser an=
d
> refusal regressions; the live candidate runs required zero retries. These
> results qualify the WSL backport's measured ordinary behavior, not the
> mainline mail series.
>=20
> Qualification limits
> --------------------
>=20
> The Hyper-V runtime uses the ordinary x86_64 vzalloc path. It does not
> execute confidential chunk transitions. Full memory saturation, the
> chunked CoCo fallback on hardware, SEV-SNP, TDX without a paravisor, Arm
> CCA, and complete VMBus module unload and retained-owner destruction rema=
in
> unqualified. The exact mainline series has not been installed or booted o=
n
> the daily WSL host; the installed kernel and Windows WSL matrix are a sep=
arate
> backport. The baseline is one intentional fragmentation negative control,
> not a matched same-configuration diagnostic-count comparison for every pa=
tch.
> No confidential-platform result is inferred from ordinary Hyper-V or stat=
ic
> checks.
>=20
> ---
> Emerson Busson (14):
>   hv: vmbus: convert ring backing through the chunk allocator
>   hv: vmbus: validate chunk buffer allocation and cleanup
>   uio: hv_generic: describe buffers for owned allocation
>   hv: vmbus: add KUnit tests for GPADL post failure injection
>   hv: vmbus: add KUnit test for order-zero allocation fallback
>   hv: vmbus: cover all shared-page policy combinations
>   hv: vmbus: distinguish host rescind from local channel unload
>   hv: vmbus: retain backing until ownership and references clear
>   hv: use owned VMBus buffers in NetVSC and UIO
>   hv: vmbus: pin buffer pages across UIO mmap to close the reclaim race
>   hv: vmbus: vmalloc requestor metadata
>   hv: netvsc: allocate RNDIS request descriptors with kvzalloc_obj()
>   hv: netvsc: handle a NULL request address on empty completions
>   hv: netvsc: use kvzalloc for device state

This patch set has become huge in going from your original v1 to this v2.
The v1 diffstat was 101 insertions and 12 deletions. This v2 has 4515
insertions and 427 deletions, which is too big to be effectively reviewed.
(For some reason this v2 cover letter doesn't have the diffstat, while your
v1 series did.) The elapsed time from my comments on v1 to this v2 is a lit=
tle
over 2 weeks, so it's clear that most of this code must be AI generated, wh=
ich
is itself a red flag. I'll also comment further down on the commit messages
and this cover page summary, which I find difficult to comprehend and
assume must have been mostly AI-generated as well.

At a top level, I think this needs to be broken into multiple patch sets,
each with a clear focus. I can see these areas:

1) Ensure ring buffer allocations don't fail when memory is fragmented

2) Ensure other allocations by VMBus infrastructure and drivers (netvsc)
don't fail when memory is fragmented

3) Deal with failures in GPADL teardown, ensuring that the memory
is leaked (I think this is what you are calling "ownership"). This can
be a tricky area, especially if the host doesn't respond within the
guest's timeout period. There's an existing VMBus mechanism to
help with this case but it has not been applied widely. The VMBus
code mostly just assumes that if there's no response in the timeout
period, there will never be a response. Handling a "late" response
is a separate issue that already exists, and could be dealt with in a
separate patch set if it's judged to be worth the trouble.

4) It looks like there are other bugs you are also fixing (UIO mmap and
reclaim race?). If such bugs already existed, it's usually better to fix
them as a separate patch or patch set, rather than folding the fixes
into a patch set that is focused on a different issue. That's particularly
true if the complexity of the fix is moderate to high.

5) Kunit tests. There are 2651 lines added in the new *test.c files,
plus there are hooks and supporting infrastructure in the main source
code files. So over half the code in this patch set is for tests. I'm rathe=
r
ambivalent about this. Having unit tests is good. But as you can tell,
not much effort has been invested to date in doing VMBus unit tests,
with one reason being that it requires a relatively high level of
invasiveness. As a result, it's a lot of test code that adds to the
maintenance burden over time. Probably should get a read from the
Hyper-V maintainers on whether they want to take on that burden.

There may be some interdependencies between the above areas.
The trick is to figure out a sequencing that makes conceptual sense
while allowing the code to be added incrementally. It's OK to design
an earlier step in the sequence with a later step in mind but hopefully
not add the code until the later step. Caveat: My list of 5 areas above
is based on my high-level read of your v2 patch set. As the author,
you have to deal with the details, and there may be reasons that
combining two of the areas actually does make sense. Feel free to
make that such a case -- don't take my statement as absolute truth.

Commit messages (and this cover letter) must focus on the "Why?"
question. What is the problem scenario? Has the problem been seen
in the real world, or it is the result of code inspection or an AI report?
And then, what is the proposed fix? I know that memory allocation
failure due to fragmentation has happened in the real world, so
I'm on-board with the general approach to fixing it. Alternatively, if
the patch set is adding a new feature/function, why is it needed? What
problem is solved or new capability is provided, and why is that
valuable?

For large patch sets, cover letters also often explain the sequencing
and purpose of the patches in the patch set. E.g., Patches 1 thru 3 do
some preliminary code reorganization; patches 4 thru 8 are the core of
the patch set and fix the core XXXXX issue; patches 9 and 10 remove
XXXXX existing functionality that was made obsolete by the new code.
The goal is to give the reviewer a roadmap.

Read through postings to the linux-hyperv and linux-kernel mailing
lists to get a feel for how commit messages read. You want yours to
fit in with existing style and terminology (e.g., use "testing", not
"qualification"). I could provide more detailed feedback on the
commit messages, but would prefer to spend my time on a closer
review once they are more in alignment with typical practices.

Bottom-line: My recommendation is to go back to the original
problem from v1 of your patch set, and provide a good solution to
that problem, with modest refactoring so it fits naturally in the
existing code base and hopefully simplifies some of the complexity
that has built-up over time. Skip the Kunit tests for now. Separately
(and perhaps in parallel), deal with my #2, which is other high-order
allocations that could fail when memory is fragmented. Feel free to
use AI as an assistant, but don't just pass-thru AI-generated code
and commit messages. Put effort into making sure the code is
good and tight -- don't push that effort onto reviewers from the
mailing list. You've got to "own" the result before submitting it.

Michael
