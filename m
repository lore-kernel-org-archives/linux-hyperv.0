Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011030.outbound.protection.outlook.com [52.103.12.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B53E44E7;
	Tue, 22 Sep 2026 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051145; cv=fail; b=Qa/Re1NZ/S3wjO0Eqz0Dp6ZI3ExDg+Ge4yZeZEL7FVvVGgyF5jeKctE2CjXUuZmo8ti7HPUaXeDygNETFAwHHl9T7x3kd2EjRi/xwcOLXntqKWWqRYP9P3LcrMtkbYZCNbp9+6slEPWRZZsAqTkfJrk+W/EIwi37jt9HKME0wIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051145; c=relaxed/simple;
	bh=uayFxoBbr91kR6jiC4fTInPnkRnsewZuSC1FR4/H+Oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j9ItHRzzyk822Md2rCPKQvywmn4ToFyGoa21xhXT3UBhXEC5Gc1FVEzxzbfBDgMt1AfB4iBFNaFXp+lV5tkZBSpNNiuHn/Jz0BwzvMsOFCf2VMNJqzirMMrapZqPyodj+gvYHE/QujwWCQYS7n2C9f76yk8GF369aWI3qHUtkc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a0dZY+CG; arc=fail smtp.client-ip=52.103.12.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a0dZY+CG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEujwSCggF0ROFc3zeeHkvd7dBUuNQw6slSNlsoo1omJ9mLLBaKMo/6H7hEJb2Hm+frYY08E8VUkPIJyy2GYgLN70HbG1MEmOok2fiS2d9I85rg/GmFD2LrgO3eQVlRAYBwG5GvEAoNNITS+ywjL5gBuc3hdKqpXIcgxSj4c5pytDHFjZHV4BptWz3P6FM9MLlNh0+xm/sn/cqkTmwMPdHWiVaNc4pYk5XInDmFE2jrss5CzbRFLzD/O3q3oNiAjJLlLItC5FOHC0mYnp0P/7fGxs4SDuMKEsFL6BWcN+FWA35x3lx6U4QJc0g4DywDQM+MThR2ZbOMvtR7afh67fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s8iPRo3B6mEynycQIh+hsdlMPKPmmrua1WaqBQUO5g=;
 b=PoscjLr5k5ocuY9uPpNHaFt/UObdItbmC5ifUSW+d8TjTX/XMeG5E/+EYESMW500MsQv3/8zajPSzdZjyC6fPcq2kZpaAeG1z4ziYn0QCwGTT4gqtKPRgIqLNXNUVbIAuQvCfV5VmuH1yrSGLfNMJleO/DFC4GgDuKD43KqsSR0Z+3qt2d56q7VdZaWVXsPyx0qZnVb2SvJdxMVL7h/kL78WHmBI/nxRYALkQPEocFXBkFhFBTHYX8dZKdVIQNE28ac3fAkqHgmwic+DEKl6AGlO/Iyh4l+hpxNCaPtuhLJZ42KbwS4al2KSBUfv1k4yxWX9rSuq58y7f98mT+VqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s8iPRo3B6mEynycQIh+hsdlMPKPmmrua1WaqBQUO5g=;
 b=a0dZY+CG81MZ1FK9sEcYNhB374suY60roYwsuaNKCzXR5PJw6h/iB5D+4B4OcVFd1NEd/Ic99a0dsg3ptGXRSfq8+F+v7+Y0/+fsTXNctiZWtU0pdXhvh682sPulZygigf50h0bMWRL2aNKLfiTSl047UzLxGbpbRo9u0yx1ELBnzKbFjaX/bvH/8sS07r8r3vnPE3IMC7kcE1bHmMc9NG/6g7wazO8we1l+3pCI7vvUdx2TXQ+ygPs/pBL175DgsmxXIEIvMu3ZCd5FUKqwaJnaMErSRseWqxGOPQ2xCcIxDYs87nqqKsrNpt4v42ftyhzrntIGmjrqgd+GTEi4mw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA5PR02MB11218.namprd02.prod.outlook.com (2603:10b6:806:47b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 04:25:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 04:25:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Emerson Busson <emersonbusson@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Kameron Carr
	<kameroncarr@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] hv: vmbus: add virtual memory fallback for ring
 buffer allocations under memory pressure
Thread-Topic: [PATCH 2/2] hv: vmbus: add virtual memory fallback for ring
 buffer allocations under memory pressure
Thread-Index: AQFB5yClcmoOg6hES9/6E54+5FX/RAGayEPfuAPkpbA=
Date: Tue, 22 Sep 2026 04:25:39 +0000
Message-ID:
 <SN6PR02MB4157B71CAC1433B04B92B700D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260918014017.2536753-1-emersonbusson@gmail.com>
 <20260918014017.2536753-3-emersonbusson@gmail.com>
In-Reply-To: <20260918014017.2536753-3-emersonbusson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA5PR02MB11218:EE_
x-ms-office365-filtering-correlation-id: 437f7428-d3e4-4c7a-6b61-08df18618efd
x-ms-exchange-slblob-mailprops:
 a+H6FLLcF3oArmUeIqZHaFYD1WEyA+la8rz7PivYz6+3uzI2QMXeknNROiuNtkLCMvX1iEvEBTwBj0HM8IZSg72KpOVQHiNXIcsQpw2BHGQj+Zn+X2YLfuOV2O19ulXY1cG7f++KWaaR5D9P4i7RcWXN8mcCcNvIVlpoVUL/R3pvrbgHHLRi8lFNixiD7u0fY1bbCkRC1eAT4gyKw1bDHSUjxS0BxxSrKkv6x1hb163K4+LFnQw29ssG9VXtnLgCgbjJhV9VDuMiGBjY8rod/mtlMzdHjAYGZ0WF8vnXSiGYFhnup6syCLMVcdUgDTc62vDYYqlVMCl59Ft/xUGzAVxFIZIfLXY4ly3smrV/rWjn7NYVFY+QfyEX95YdJv3ebwR8La+UvbVQ97sY41BJiFZ5Q/nHLkGK0W+dj6ArpIajqHYGsX70Z6dvdzer3VzbCqL/F+wzAfPolqq/e67RM/itsfK6PUVhuhXHyxh6/pTMeEf0Z2pjIVVp+yocAIrRNKIhs7KV2FJPWxSvGfL8h/lrJc/poSvSgsI6M8E7Xud2N7qtE3F90mGlithIHt9wk1k7CcbrgoRDuOA20hw8yJyiE254zdEZKrz/mfnSPMlxJzkwyw4VN45WLJvFY/fVz8zp9gUMrbnm2wBbChHi1ADJo4VLpxPWzXKK//5pyso9RDVmDiYgdFsoQIil8MEpCbXNvFgCIM21wcOlRbv9Is65TZBtCw3EpA36lY48oOgaoP1xRrOrKxdVohvOOLsP2J3girbFuEyWb3n59XVhcIfKG9qEmi3g/Blucr7FFRGPTgG+47j06crdF963rO9O
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|24021099003|41001999006|2604032031799003|13091999003|37011999003|31061999003|19110799012|8060799015|8062599012|15080799012|51005399006|25010399006|4140399003|40105399003|12091999003|10035399007|1602099012|2607281247196008|102099032|440099028|3412199025|4302099013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PoNRmDLtnfqRGzLptxLNC1dwpEpnMS99Dp3PXMFRDslNjDmV/FZ3lq+LTg8j?=
 =?us-ascii?Q?iP42QI54Ss3lfUQ8QBsB5Veal5lf+o5YZH7JhcVNWAZ5waePLOzTnDIEDICX?=
 =?us-ascii?Q?lWBGMwpqHQ1on+hSmgcDLNilF70UhqAv1R1gcZO3ZEGqQ/2ArhpeM7LkxSWO?=
 =?us-ascii?Q?8Ws0i4qxQiJNTPdmfxQSZ74LOzBq387/K6ZCMJpD+ImJRKQT37e1YLNcDcIV?=
 =?us-ascii?Q?LKkS61dPH1Cy77RFMFLxM45U1hf0RdplnZFGtLa+dri1dd+U5lMnVABrFA16?=
 =?us-ascii?Q?YpRCvlQ9a3R9UTrdF6UvlQfH5tRZipVIouCPs8h/pcVh1UQ4lBCceSJ9E1Re?=
 =?us-ascii?Q?kv/6G6+nlZSabcv0p3xZusffB0YSQZUyLGxolm0z5OswYeV3Ts/zy/VniJWg?=
 =?us-ascii?Q?3wWe/Nssh1ts7CaWPllGcRSZLIPA6fGiSEGF0ew0z+d7zCyw7QDKFPUZ4EUu?=
 =?us-ascii?Q?zvj2YDoAyauOWR9WDa018vdFI0aNoeOEaEhAgQZWK0ctqAelFEnQy0bxF4F/?=
 =?us-ascii?Q?n/rn6qJK/NrLwbhexTpZhadSk+lVjiAs1WvtYoiHQMzF1+Rcl5ACqNFRLrM4?=
 =?us-ascii?Q?lAk6t9gzG9XJXe7iGHKyKzwAwVRoTVXamT3UmhFoM2AtjNPIOv4ULb/fdHzZ?=
 =?us-ascii?Q?DUiMew7yRDJk5T8I8yy41Hswz2aj5QtDPOQxbiAFN2+8THNvkw307OXacik1?=
 =?us-ascii?Q?evY+aNV2otp+/8jfxkcLqZRp/oVRtUKs7Cm1+2JRITD1OfXnyPYLmfGNY6am?=
 =?us-ascii?Q?16RgtrbMgR7KbmHiNl9YB44uLC2EP2xWvXFz5LDS/mUVfMZul6dWHEPK81tT?=
 =?us-ascii?Q?fWKFz1UpvLBCghbOF3yliIMXO81AhG71pAladXZGK95cIDDds3OYmP43JSdI?=
 =?us-ascii?Q?gXO+8SjdjeeJ1DNPYN31HYhkfNJQB3Ss25FKHhikSYWGpuDYNRxAZzQfSb95?=
 =?us-ascii?Q?wMs2eyU4htvWpw5AtpgFIfJE9qriVP7KY2hOaqdbqkA2Qu/C6NQTcJbUrxSe?=
 =?us-ascii?Q?1hSlIoZ4S0LZ2rZufK1xsYRd71am9/Z72a5/+lS8ESgcepSaP5dDtOLvWfFU?=
 =?us-ascii?Q?TRMZhX1xMXux+10gNJZx4LNySiZjAo2l5KGSzqivAPULyJIcjQ5yxjgZOES9?=
 =?us-ascii?Q?MsXUsKWcvwGReLGqq5+SeyGnJrCqhJaTq2sSyezP0Hv1vgf0si4HOmmpubKv?=
 =?us-ascii?Q?rDglrEPXQRc6IROJ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hSbGxIn//KLe5h/3taekFf7eEWqBcfE61a42AakPf2iQwrPcrF/zqadNm8yX?=
 =?us-ascii?Q?ViHXl22RgXfN2bDowp3czTwBUpx/1yKfCiBXaUHnryYGJIDMrv4CpEZxpOEi?=
 =?us-ascii?Q?M69QPrQGD6YPGrqBnavl9WL+A00kBKraRH3W2q8o+hisVLbyrR/fKBfkdyeZ?=
 =?us-ascii?Q?Oj2H67J05UPpFoODeDzlq9vR14R0QKLZRbF5kA75ZGs8J/3hJNg3gHrDAjo3?=
 =?us-ascii?Q?8BTsODSwZ1qyOVioZOVuCzgNOOP+XGyou/B0PO1edPRpDKWA8BoV1OfoZVm5?=
 =?us-ascii?Q?5TGRGg3+mfoqta3EEOEd5cPk6bFq2/QwKGD7P77aObApBc1OL6hBp2FzsTPe?=
 =?us-ascii?Q?xcGQDBZMiY0XgoUb4dTF9L3NxH68ZyO90P+eUeif3NewZ0z9xehR80t+m/AA?=
 =?us-ascii?Q?e5Ah25De2rEOXdFsOILswUi5SOpWY4Lq7aqfoC90kR0mIf/DYDPbPiHzutLr?=
 =?us-ascii?Q?68jvCBY01BbpmZjqIC/Od+FDZJyB7HIAgRvN5B6uxkk3aScLjWfFGOLZDiPz?=
 =?us-ascii?Q?GgBRIYZ15jm0CURkEY6vvIG5Dw08NSSZEwaj8oiBbuc/NJbzbwKcjs1fN/tY?=
 =?us-ascii?Q?FezznsZZYFKdEjaGNm5ol4SEAUpHy5OBGfgTJjJA2X6tUCeqmPeH+v/boXtN?=
 =?us-ascii?Q?bvuC7pnQCSv+uYa9bQ5fV04ntEyOnCute/9AsOS0dSKmsSSyw5e9r87USBzs?=
 =?us-ascii?Q?wB6ZDPJPe07ysw3PZkTvepiuOED+oZlcele/Vvr8dSXRkQcLZlJ4MQllJz+P?=
 =?us-ascii?Q?u+xY0ATaOX1KZSnNvNGfWaoSfjJnj0zV4nbfevd/1NpUJOehGgkDnYykFUXg?=
 =?us-ascii?Q?KgE4b1HWsyarmi5zsYrt9KoukS6ggRIzj4YSKQh2fJLrpz44wegAG31H9QDM?=
 =?us-ascii?Q?lcSCCqYcXBDOSAC3t2t2F9Dnxnt+Fln+ffBrvXL94WgdjNIXYqEBHnFYiH8K?=
 =?us-ascii?Q?zomd2nkoA/xK9HITF3e/brJHMwXpfNT5tE8gf1hBzp3BfWFp+epMHbCOn/wa?=
 =?us-ascii?Q?bqK9bEZSbPsrIXZCw03V1EroOIPFOpN1jWtRjouV54sSJTeVb6bpubuv0Klt?=
 =?us-ascii?Q?KpCL25k+Fk2lrbbmwaWeiXZIi/alHy8Ss6IMoqYCm2p42feGKjEuSm2Vtvgg?=
 =?us-ascii?Q?MSHrDwapaloqoUm4fVjRDMPPDgpZvK8QLjQC9OjF+0o490vNFRzRo4UC4qzk?=
 =?us-ascii?Q?oBJcqbxf3UJRUXkiBtE5Mx4jtBSaD9rRyQGB0Qoa4LwEVlu5Tc8gwUciDwDZ?=
 =?us-ascii?Q?Av4s5qepQtxUnKz0qibxgpSX6tDPJISOs9Z3A7Izd7qGYg4JKpDxZvURUKMt?=
 =?us-ascii?Q?h10PhGaDn6UI0HQCZkKCXP5N2jFEYbNjtCOBirtCCbg5M98bta7jjJAMmcTZ?=
 =?us-ascii?Q?P7yR8bA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 437f7428-d3e4-4c7a-6b61-08df18618efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 04:25:39.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR02MB11218

From: Emerson Busson <emersonbusson@gmail.com> Sent: Thursday, September 17=
, 2026 6:40 PM
>=20
> When VMBus sub-channels (such as synthetic SCSI, network, or vsock
> channels) are dynamically opened during periods of sustained memory
> load or memory tier eviction, `vmbus_alloc_ring()` attempts to
> allocate physically contiguous memory using
> `alloc_pages(GFP_KERNEL | __GFP_ZERO, order)`.
>=20
> For standard rings (order-7, 512 KiB contiguous memory), high buddy
> allocator fragmentation under memory pressure frequently causes
> `alloc_pages()` to fail with -ENOMEM even when ample total virtual
> memory is available. This manifests in userspace as connection
> timeouts (e.g. `accept4 failed 110: Connection timed out` on WSL2 vsock
> control planes).
>=20
> This patch introduces a resilient fallback mechanism:
> 1. When `alloc_pages()` fails due to external fragmentation,
>    `vmbus_alloc_ring()` falls back to `vzalloc_node()` (or `vzalloc()`)
>    to satisfy the buffer allocation from virtually contiguous pages.
> 2. In `hv_ringbuffer_init()`, detects `is_vmalloc_addr(virt_addr)` and
>    populates the `pages_wraparound` mapping array using
>    `vmalloc_to_page()`.
> 3. In `vmbus_free_ring()`, tracks `ringbuffer_is_vmalloc` and calls
>    `vfree()` safely, preserving Confidential VM (CoCo) memory
>    re-encryption isolation checks prior to release.

The problem you describe is real, and there have been code changes
in the past to remove places where high-order kernel memory
allocations were needed to load and initialize a VMBus device or
a PCI pass-thru devices (such as the Mellanox NIC VF). But as you
noticed, the ring buffer allocations were never fixed.

Unfortunately, your solution doesn't work in all CoCo VMs. In
arm64 CCA VMs and in TDX VMs running without a paravisor,
the set_memory_decrypted() call in __vmbus_establish_gpadl()
doesn't work for vmalloc'ed memory. It only works for physically
contiguous memory, and various proposals to make it work
for vmalloc'ed memory have been stymied. As a result, Kameron
Carr recently had a patch set [1] accepted to solve the problem.
See the new function vmbus_alloc_buffer() and related.

Solving this high-order ring buffer allocation problem is a prime
opportunity to do a bit of refactoring:

1) Ring buffer allocation should *always* use Kameron's new
mechanism, not just as a fallback if normal alloc_pages() fails.
This would make things simpler, and even though Kameron's
mechanism has a little more overhead, I think that's OK as
ring buffer allocation/free is not a fast path.

2) The three data fields needed by Kameron's mechanism should
be grouped into a structure that can be passed around. Currently
the fields are separately added in the netvsc driver because that's
the only place that needed a GPADL for a buffer larger than
alloc_pages() could provide. But with broader usage for all
ring buffers, some encapsulation into a struct such as
struct vmbus_buffer would make sense.

3) We also have struct vmbus_gpadl. There's some logical
duplication between the fields Kameron needed and what's
in struct vmbus_gpadl. The stuff in struct vmbus_gpadl could
be folded into struct vmbus_buffer and the duplication
eliminated.

4) I have separately been working on a fix to making sure
that memory is leaked if the GPADL can't be removed, or
if the buffer memory can't be re-encrypted in a CoCo VM.
I've run into messy issues that can't be cleanly solved with
the current data structures. But having a struct vmbus_buffer
with a "leak" flag field would be a clean solution.
=20
5) Kameron's new code required introducing a new GPADL
type HV_GPADL_BUFFER_DECRYPTED because "normal"
buffers are decrypted in __vmbus_establish_gpadl(). But
if vmbus_alloc_buffer() is always used, and it does the
decryption in a CoCo VM instead of __vmbus_establish_gpadl(),
then some of the HV_GPADL_* types can probably be
eliminated.

That's a quick summary of what I'm thinking. I haven't
coded any of this, so maybe there are some flaws that
I haven't immediately spotted, but I'm pretty sure this
could all be worked out in a way that's better and
simpler than what we have now, and that would
avoid ring buffer allocation failures due to memory
fragmentation.

Michael

[1] https://lore.kernel.org/linux-hyperv/20260811160447.2529876-1-kameronca=
rr@linux.microsoft.com/

>=20
> Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
> ---
>  drivers/hv/channel.c      | 46 ++++++++++++++++++++++++++++++++++-----
>  drivers/hv/hyperv_vmbus.h |  2 +-
>  drivers/hv/ring_buffer.c  | 19 +++++++++++-----
>  include/linux/hyperv.h    |  2 ++
>  4 files changed, 57 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 162d6aeec..f0fb3dd8f 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -12,6 +12,7 @@
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  #include <linux/mm.h>
> +#include <linux/vmalloc.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/hyperv.h>
> @@ -153,13 +154,20 @@ void vmbus_free_ring(struct vmbus_channel *channel)
>  	hv_ringbuffer_cleanup(&channel->outbound);
>  	hv_ringbuffer_cleanup(&channel->inbound);
>=20
> -	if (channel->ringbuffer_page) {
> +	if (channel->ringbuffer_is_vmalloc && channel->ringbuffer_page_virt) {
> +		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
> +		if (!channel->ringbuffer_gpadlhandle.decrypted)
> +			vfree(channel->ringbuffer_page_virt);
> +		channel->ringbuffer_page_virt =3D NULL;
> +		channel->ringbuffer_is_vmalloc =3D false;
> +	} else if (channel->ringbuffer_page) {
>  		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
>  		if (!channel->ringbuffer_gpadlhandle.decrypted)
>  			__free_pages(channel->ringbuffer_page,
>  			     get_order(channel->ringbuffer_pagecount
>  				       << PAGE_SHIFT));
>  		channel->ringbuffer_page =3D NULL;
> +		channel->ringbuffer_page_virt =3D NULL;
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_ring);
> @@ -182,10 +190,26 @@ int vmbus_alloc_ring(struct vmbus_channel *newchann=
el,
>  	if (!page)
>  		page =3D alloc_pages(GFP_KERNEL|__GFP_ZERO, order);
>=20
> -	if (!page)
> -		return -ENOMEM;
> +	if (!page) {
> +		/* Fallback to virtual memory allocation under buddy fragmentation */
> +		void *virt_addr =3D vzalloc_node(send_size + recv_size,
> +					       cpu_to_node(newchannel->target_cpu));
> +
> +		if (!virt_addr)
> +			virt_addr =3D vzalloc(send_size + recv_size);
> +
> +		if (!virt_addr)
> +			return -ENOMEM;
> +
> +		newchannel->ringbuffer_page =3D NULL;
> +		newchannel->ringbuffer_page_virt =3D virt_addr;
> +		newchannel->ringbuffer_is_vmalloc =3D true;
> +	} else {
> +		newchannel->ringbuffer_page =3D page;
> +		newchannel->ringbuffer_page_virt =3D page_address(page);
> +		newchannel->ringbuffer_is_vmalloc =3D false;
> +	}
>=20
> -	newchannel->ringbuffer_page =3D page;
>  	newchannel->ringbuffer_pagecount =3D (send_size + recv_size) >> PAGE_SH=
IFT;
>  	newchannel->ringbuffer_send_offset =3D send_size >> PAGE_SHIFT;
>=20
> @@ -639,6 +663,7 @@ static int __vmbus_open(struct vmbus_channel *newchan=
nel,
>  	struct vmbus_channel_open_channel *open_msg;
>  	struct vmbus_channel_msginfo *open_info =3D NULL;
>  	struct page *page =3D newchannel->ringbuffer_page;
> +	void *inbound_virt =3D NULL;
>  	u32 send_pages, recv_pages;
>  	unsigned long flags;
>  	int err;
> @@ -669,6 +694,8 @@ static int __vmbus_open(struct vmbus_channel *newchan=
nel,
>  	newchannel->ringbuffer_gpadlhandle.gpadl_handle =3D 0;
>=20
>  	err =3D __vmbus_establish_gpadl(newchannel, HV_GPADL_RING,
> +				      newchannel->ringbuffer_page_virt ?
> +				      newchannel->ringbuffer_page_virt :
>  				      page_address(newchannel->ringbuffer_page),
>  				      (send_pages + recv_pages) << PAGE_SHIFT,
>  				      newchannel->ringbuffer_send_offset <<
> PAGE_SHIFT,
> @@ -677,11 +704,18 @@ static int __vmbus_open(struct vmbus_channel
> *newchannel,
>  		goto error_clean_ring;
>=20
>  	err =3D hv_ringbuffer_init(&newchannel->outbound,
> -				 page, send_pages, 0);
> +				 page, newchannel->ringbuffer_page_virt,
> +				 send_pages, 0);
>  	if (err)
>  		goto error_free_gpadl;
>=20
> -	err =3D hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
> +	if (newchannel->ringbuffer_page_virt)
> +		inbound_virt =3D newchannel->ringbuffer_page_virt +
> +			       (send_pages << PAGE_SHIFT);
> +
> +	err =3D hv_ringbuffer_init(&newchannel->inbound,
> +				 page ? &page[send_pages] : NULL,
> +				 inbound_virt,
>  				 recv_pages, newchannel->max_pkt_size);
>  	if (err)
>  		goto error_free_gpadl;
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 34943de7d..ec06c30d2 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -182,7 +182,7 @@ extern int hv_synic_cleanup(unsigned int cpu);
>  void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
>=20
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
> +		       struct page *pages, void *virt_addr, u32 pagecnt, u32
> max_pkt_size);
>=20
>  void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 23ce1fb70..e6d4cf185 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -184,7 +184,7 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *cha=
nnel)
>=20
>  /* Initialize the ring buffer. */
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
> +		       struct page *pages, void *virt_addr, u32 page_cnt, u32
> max_pkt_size)
>  {
>  	struct page **pages_wraparound;
>  	int i;
> @@ -201,10 +201,19 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *=
ring_info,
>  	if (!pages_wraparound)
>  		return -ENOMEM;
>=20
> -	pages_wraparound[0] =3D pages;
> -	for (i =3D 0; i < 2 * (page_cnt - 1); i++)
> -		pages_wraparound[i + 1] =3D
> -			&pages[i % (page_cnt - 1) + 1];
> +	if (virt_addr && is_vmalloc_addr(virt_addr)) {
> +		pages_wraparound[0] =3D vmalloc_to_page(virt_addr);
> +		for (i =3D 0; i < 2 * (page_cnt - 1); i++) {
> +			void *curr_virt =3D virt_addr + ((i % (page_cnt - 1) + 1) <<
> PAGE_SHIFT);
> +
> +			pages_wraparound[i + 1] =3D vmalloc_to_page(curr_virt);
> +		}
> +	} else {
> +		pages_wraparound[0] =3D pages;
> +		for (i =3D 0; i < 2 * (page_cnt - 1); i++)
> +			pages_wraparound[i + 1] =3D
> +				&pages[i % (page_cnt - 1) + 1];
> +	}
>=20
>  	ring_info->ring_buffer =3D (struct hv_ring_buffer *)
>  		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index a76f556f5..63203df4d 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -807,6 +807,8 @@ struct vmbus_channel {
>=20
>  	/* Allocated memory for ring buffer */
>  	struct page *ringbuffer_page;
> +	void *ringbuffer_page_virt;
> +	bool ringbuffer_is_vmalloc;
>  	u32 ringbuffer_pagecount;
>  	u32 ringbuffer_send_offset;
>  	struct hv_ring_buffer_info outbound;	/* send to parent */
> --
> 2.43.0
>=20

