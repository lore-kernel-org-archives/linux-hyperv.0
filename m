Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013066.outbound.protection.outlook.com [52.103.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC0311977;
	Sun, 23 Aug 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787500055; cv=fail; b=N2+Ar/XRghNOqvzOcmSVFDFd9xBlOqj4urjCwa7HLw3j2+Jy5JJV5uc+d2P/pHonARy3hCNBsBS7YnDvAGZd0YVMADZA0507POIhhWpionUZujH1t+9XTSPMLWf/O+frZLiai1OxXBw2LOIbUGeDoNgiVnARAXh/HjRoR7zBz2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787500055; c=relaxed/simple;
	bh=sOszRfaUO99BIEPpy+B1uHClsSURHBgVl65RBpmtlDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jCLpkB9IRnnHqEEW+e1RLgP845FRN18Nb3LVO8xTEq7w82AYlofsWIYvjlMfHrm/T6ZysScGT96h2xlmlvxXOuiTGxV8kOXSYeY9dZtMW30ehUs67QiL7BNU/ojdkDOS51V4tylQHfhFylWOelxgrbZTTENhW/osau+eVm/bGLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pdI39LMq; arc=fail smtp.client-ip=52.103.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pdI39LMq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOa6zj3flxSMwMfUlUyK7fruoLvlVi8+Jhh7sQW8k/rM7d9S2O1isGBa9+C/lfnNSUJTDOWxr3bk0l1hNQavqB5AXWDVP/Qmaa2Xn+Tu32jZxrJb7CIs+KYkZG14JqV/RT49ztGbuQgLO5jQ66a3F87BgPhMe1/RpN0fYxljDCfcaDx3Ft0oyz9tFncaequqY1jOSW5na9z6MPl9FabFj14B/sz4ycBKpZiAEsJdLq8N/0PLkFZt8NhpM12fVsiRxc6Rlu2mjoo0sCkrC0xf2Vc+7d02h5zJSE3n93VQNohLz8Jr9vtgQ7gA21pzL2cJrBpIiWK2TxzDXx+hORuLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkRKVX6KyNzWku6FJr6iX58v8bJtEJ9QqCdidP67h0U=;
 b=Qb/mMMXNyPZJWH7YqvM32CJ/XPW6Hw2/2PpbwvrOACVn2QD+a0W5JXFFOUVNJMpdiqk/KQLylCE6Xs2PDLSj55QrGeWQ71PZyAXz0MtnmOHQwKOdm6uP7bw1UA3N4xH1TcR6hyCWGVqAaOyK61i+/h5jIgo70cP5rl8sCJN4xTDo1aPF22kEqX68qgVvap5LqwK9GonS7MKpRHBG8FdUct0GnwiNzkeWxmyHdwSwWKR8V+tmT6+bwRKwLO3TM9zqSDFS2uO4viVGq3090S/Hk37qAigPzI7VrtlAmCzCBeuAN74neE0HKchkBcuzjHrNZBWOqzRc1DLk1bFJZU0r3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkRKVX6KyNzWku6FJr6iX58v8bJtEJ9QqCdidP67h0U=;
 b=pdI39LMqpNXzoVQGPoOYi2+mH2yNYDrH/zSvu1nSUFzlt8+IlNhOb+Q9UVeo7UIEx4dvy6nPIYETG1L3sKYKoRGiRjtymDjiWvsiL9vWbCSM6CUEjWZyqJtCJCa1rWEWxYQwl52Up15fUcTUU5Rvr88Mcoy7hcqfw+dqSAw5DQmVfNxOBRKrZ1X7qXqNYQIhk/UaBtNUKdU+D2YgB3FY67xVum/b7CBhHTvcz8iblO0Mco/fUHClEHLAclbfFYNuv2u0uLEXxgBS0xzMSgzFnyG94xR32IuteOVIyoDtSOKWjiz2/OAcDNcXGjGi6ZXfMzwQOlVcl8ia9YLxJ80VFQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9073.namprd02.prod.outlook.com (2603:10b6:208:443::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 15:47:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 15:47:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Andrew Morton
	<akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, Ming Lei
	<tom.leiming@gmail.com>, Ming Lei <ming.lei@redhat.com>
CC: Wangyang Guo <wangyang.guo@intel.com>, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Long Li <longli@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>
Subject: RE: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
Thread-Topic: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
Thread-Index: AQHdKJCMH5PeXdnWRUiBUqx3W0OgELar3EQw
Date: Sun, 23 Aug 2026 15:47:30 +0000
Message-ID:
 <SN6PR02MB415723B4BC62C164551B90CDD4A12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
In-Reply-To: <20260810062144.2108758-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9073:EE_
x-ms-office365-filtering-correlation-id: d1fa7e92-d893-4388-a220-08df012dd6f6
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|37011999003|13091999003|31061999003|15080799012|55001999006|24021099003|4140399003|25010399006|52005399003|40105399003|1602099012|10035399007|2607281247196008|18061999006|102099032|3412199025|440099028|4302099013|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1rHDubsj3NKIRFSCbyKT0B7b2hq9+DueqpzIcED8kG5kPnVX+XpebBKtr7BB?=
 =?us-ascii?Q?LDNsQDGw/1i5j1mKICOqf/7XI/tXj7muIOOYSaCwJbxbpzcoU0UiAtVhASSs?=
 =?us-ascii?Q?uNCmmE8DOWUJIv/rxI7lh7luGp31Qc5ZMJ646lJ3E17f37x3GiLLm8IVoF7K?=
 =?us-ascii?Q?v3VlLiXCvavVa4ss1L+zcQKk9IzIoxSPDeJKvwnmAU/7yWR/djSqFi0Q0SZE?=
 =?us-ascii?Q?YWQIHbCtS8Uj1xCwbW4XGTIGbuxoiocQY1TKIdzH/9aVZt1tzczi6Ewh0VsJ?=
 =?us-ascii?Q?CZG/CXjEoyzkYxaeHmKqMnrpfze9otwMpjGUFucuGhP9irxY/+gTe4CQxwE6?=
 =?us-ascii?Q?2hvxjo7mcAYQjVuFdk1yExO++IDAr63So52/PTRZu76KOQnsd01f8N2NuoqH?=
 =?us-ascii?Q?Q3HNqAbtmDRMJz7irq7ozn2q5r9iv/UF8l2c1QrTbte3vF9c9UXgXaEBwb6Z?=
 =?us-ascii?Q?zyrhMhXN/0J8X6RZeshpIx8oqE6HKD8XgMu1zKLm67zRHbFqeTFL7EtysxFY?=
 =?us-ascii?Q?TK+qoYKKpbFLUyUipSooDATCFrhKVp9bXZeltNN8KXxWblFelSou7vdsw3xQ?=
 =?us-ascii?Q?wblz0oQfuSBR+lESzQHVNjRWsZBpZ14kaL7Rrb2ZvaaEKPwWlZUcj9LsZks+?=
 =?us-ascii?Q?fvpxhg0HFdDe47mNRn0KwePC6pJ7En5hQKE/WMhNmTrJ19CYfpKW6n4wbqXI?=
 =?us-ascii?Q?DUFmjkPMl+A6kSfBpgSx/8jwaS2f62VXnrfQJgR7SpkCbjPmD/KUDD+NDyMl?=
 =?us-ascii?Q?FNiMizrr5qKxQmcBwbolRC0Bz+F9szveC4Je2zL2DUk31aHN3uxf0qzobphc?=
 =?us-ascii?Q?2cUXRL0+9HvMbzSMMoYhYR/m6rTsU9R53ruYPL9EKITpypQhoCKvzYhuF1Lj?=
 =?us-ascii?Q?86DaXKA+RvdEjYHwS6/8VGfwoi7uzFUbmDGokzyPI7hPVysKJsozLLXtAsJe?=
 =?us-ascii?Q?lWkH5NOwwpWsbyziJYbyLh9Q3UlJv5TYzrzlv6q706YDQMBr0K4hjQ38uRZx?=
 =?us-ascii?Q?hPWoq4C1qN5Bes1OEAnyhDFDw0vyK/cIae1NQqrPPDiPyEVY35nzr/kXOTIG?=
 =?us-ascii?Q?6R/1pC/49N7RmAwITpq3nS18VnG1/JpL7BV0AJAlcCwCOK5usqanc5l/UBUh?=
 =?us-ascii?Q?V70HGjNugy8VqXrjkk6qwWiZ9S64+QHRYAD2id41XQxfUzsbmi8YH9GB9jOm?=
 =?us-ascii?Q?eGp6i1/yUh4jIT9g?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QBfPXUND+ohXhPztlFOI29H8olWBIqBdXyDJXyDQxW4WglVZeQBpQYHw0Fkq?=
 =?us-ascii?Q?vQ9/4NYPyuyj/wI+mobqyECxfE3fsxtkcMEk4dfcvcpteOgFasx2rpBikhz1?=
 =?us-ascii?Q?eGOed8goj3zFYxdJkum/cRKL5x9MkTuP1wt10GUSzUmYOgBCkvKu9dRcUZWN?=
 =?us-ascii?Q?3eThZorq9S/NxI5WfSgsER0kUpRzaf73WmxQ8GuBgc6XqYlP34+UPgoxa1Zh?=
 =?us-ascii?Q?tOGR7SV9Te83YivKIgUayTND1qwzp2O3z9r9Eogn8Ht0VQYJi6rpkrvC5+04?=
 =?us-ascii?Q?CFT+cp/LxO52uHuwxN6rMDW8oFUV+KaEzeY2XQxvcmDRbMo/BrF8GtFPDh/U?=
 =?us-ascii?Q?UBeuNURp45qpIFzDMR7k6AplTtydfzGKH/zKXilJwOxSTqFfEAdqSQEjEQcp?=
 =?us-ascii?Q?a+9aoe0uybTxUUHhEkUZ7Iy2xtP87AZSd3CrZyTX84V/QKRN4SPaNRKmnAgM?=
 =?us-ascii?Q?D0g+MsNNj7YYq11afm5nyeoEnatM/UN0E4IbtWPWVQGfG8nD5okJ0ejnm9ki?=
 =?us-ascii?Q?iE+P1vNwpx/xvCaZB7NSZj5u4I/4c/guzDJQiV+nRSsOgeATP90IJHsHpW28?=
 =?us-ascii?Q?y9QFdSJ4BtT/XuWVwRfIDdvrEbG8kHaS9jKgX2brAb3WCaQKzG/5rY31QxRr?=
 =?us-ascii?Q?0KgwueHxEyZU81rBtPAAbRf5iSADIYk3sZfJeymDoguEtkXa36gMijObn7YP?=
 =?us-ascii?Q?O8rg2iJOucGBYgm/GPInX32E5hO1uehDZUunE+0sexPNw0nrqt54Zk62fmgW?=
 =?us-ascii?Q?LokPVjsE79LXCMR2K/m/pQG+kaOVhdLs/EYW3DAYq+enPizD1InaPCFNpVz+?=
 =?us-ascii?Q?wM287GgddImJg8NE6Ld+du4BOQ9xgHmaHzBCKkKzl34t0PyCLtR8+1+ivw13?=
 =?us-ascii?Q?VqjmmDGvvvZr4rul5IuFewmuUtaZNE4LEb1DCujbq2NSv9FB9zA4BuU+xuA8?=
 =?us-ascii?Q?Nenhv8uBNAr2LQyEGm4sf9X1U/Sx7k/06xMZvf8aheV1O5jcHPQheBVYpKe/?=
 =?us-ascii?Q?66NwmyEQtZqE31SlBpHs7Vgaz2m/7/w/0aXUNnjeeU2ZbXWOYLw7cV5vFZIq?=
 =?us-ascii?Q?h6OAmsfo5Bb9L105PKkRM4OvtaZwd8na4cSRVjf1Yd/dji3RQW+N/yR8SvL6?=
 =?us-ascii?Q?VG8sFn+ixjPqWVAYSQhpWhHTOJhBdjR2tM/15C3zC2mppK3oUujNHUXpd+La?=
 =?us-ascii?Q?lFRGptxO7LwemUgGE8MnkTwfMCe7hBTqytEOA8JcjOtTx7b9QvXCfHNAK8qT?=
 =?us-ascii?Q?ODHYqjWzZzCxhGT39lb1lSsAITfbUdGaiEZrkVY5qFFN+myNa06SHwGGwkA8?=
 =?us-ascii?Q?ikflDcDh62zNOAKK0Iag/x1lFqX/ggjwwa7TGXcVJCajT1QeILB5pE1ZqbJ2?=
 =?us-ascii?Q?IixX/qY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fa7e92-d893-4388-a220-08df012dd6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2026 15:47:30.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9073

From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 9, 2026=
 11:22 PM
>=20
> group_cpus_evenly() computes how a device's queue interrupts are spread
> across CPUs. It backs managed-interrupt affinity (kernel/irq/affinity.c)
> and block-multiqueue mappings (block/blk-mq-cpumap.c), and is invoked
> independently by every device that uses them - NVMe, NICs, storage HBAs,
> and virtio devices. Its output is deterministic, i.e. for a given
> topology, two similar devices produce an identical group-to-CPU mapping.
>=20
> When ngroups < ncpus, some groups end up with only a single CPU. An
> interrupt whose mask has one CPU can only run there, making that CPU a
> "hot" handler. Because the mapping is deterministic, identical devices
> compute the same layout and stack all their single-CPU IRQs onto the
> very same CPUs, leaving the rest of the system idle.
>=20
> This is easy to hit in practice. On an Azure L96as_v4 VM (96 vCPUs, 2
> NUMA nodes of 48 CPUs, 6 NVMe disks with 62 I/O queues each),
> group_cpus_evenly() splits each disk's 62 queues into 31 per node over
> 48 CPUs. 48 does not divide evenly by 31:
>=20
>     per NUMA node: 48 CPUs / 31 queues
>       17 groups get 2 CPUs   (cover 34 CPUs)
>       14 groups get 1 CPU    (cover 14 CPUs)  <- single-CPU "hot" queues
>=20
> That is 14 hot queues per node, 28 per disk. All 6 disks land them on
> the same 28 CPUs, so 168 hot interrupts pile onto 28 of 96 CPUs while
> two-thirds of the system handles none:
>=20
>     Before (per-CPU, disks whose IRQs it services):
>       CPU  0: 3 disks    ...   CPU 34: 6 disks (all six)
>       CPU  1: 3 disks    ...   CPU 47: 6 disks (all six)
>     Summary: 28 CPUs (34-47, 82-95) served all 6 disks and the other 68
>     served only 3. Those 28 CPUs cap throughput and inflate tail
>     latency while most of the system is idle.
>=20
> Fix this by introducing a per-caller rotation via a static atomic
> counter (group_spread_cnt). Each call to group_cpus_evenly() takes a
> unique spread_offset, applied to the two decisions that were previously
> deterministic:
>=20
> 1) Cluster-level rotation in __try_group_cluster_cpus(): after
>    alloc_groups_to_nodes() distributes groups proportionally across
>    clusters, integer rounding leaves some clusters with one extra
>    group. The extras are redistributed starting from a rotated
>    position, with a stride of ncluster/total_extra to minimize overlap
>    between consecutive callers. A multi-pass fallback ensures all
>    extras are placed even when some clusters are at capacity.
>=20
> 2) Intra-cluster rotation in assign_cpus_to_groups(): the sequential
>    extra assignment is replaced with a modular expression,
>      (v + spread_offset) % nv->ngroups < extra_grps
>    rotating which groups within a cluster receive the extra CPU.
>=20

I've finally been able to review this. It took me a while to get up
to speed on the overall approach of the existing code, and then your
changes. I'm sure there are subtleties that I don't yet grok, so my
comments might be off base.

My first question is about the placement of your (1) change above.
It comes after alloc_groups_to_nodes() is called by
alloc_cluster_groups(), and it modifies what alloc_groups_to_nodes()
set up. I had expected that your (1) change would be included in
alloc_groups_to_nodes() so that it would also be applied at the
NUMA node level. There are cases where the NUMA node count
might be relatively large, but the cluster count is 0 or 1. In that
case, your (1) change is never invoked. Maybe there's a reason
for not applying your updates at the NUMA node level, but that
reason isn't evident to me.

> Nothing else about the layout changes - same queue count, same NUMA
> weighting, same full CPU coverage and locality. Each caller simply
> starts its mapping from a different point, and each individual call
> still produces a valid, fair distribution. Across callers, different
> CPUs absorb the single-CPU group IRQ load:
>=20
>     After (same setup, with the rotation):
>       CPU  0: 4 disks    CPU  2: 4 disks    CPU 47: 4 disks
>       CPU  1: 4 disks    CPU  3: 4 disks    ...
>     Summary: no CPU serves more than 4 disks, and all 96 CPUs are used.
>=20
> The total interrupt work is unchanged - every CPU still handles one
> queue per disk; only the placement of the single-CPU hot queues moves.
> This benefits every managed-IRQ, blk-mq, and virtio-vdpa / virtio-fs
> device with no driver changes.
>=20
> Because the offset comes from a global counter advanced once per call,
> the mapping now depends on call (device probe) order. A given device's
> exact layout can differ from one boot to the next, and a later recompute
> (e.g. a blk-mq remap) may pick a different layout. Every such layout is
> still valid, fair, and proportional - only the choice among equally good
> mappings varies.
>=20
> On a 96-vCPU Hyper-V VM running 4K random-read fio across 6 NVMe disks,
> worst-disk degradation versus average dropped from 11% to 5%, and the
> previously penalized disks gained 12% IOPS at 10% lower latency.

My second question is about the range of NUMA and cluster
configurations to which you expect your changes to be applicable. You've
cited an example above where the changes are very effective. But I
did some experiments on other configurations, and found them to be
less effective than I had expected. Maybe my expectations are wrong,
or the changes have a bug or incompleteness. In at least one case,
algorithm change (1) not being applied at the NUMA node level may
be the cause of reduced effectiveness, though I didn't fully investigate
the details.

Here are the three configuration I tried:

1)  Azure L48s v2 VM. This VM has 6 NUMA nodes, each with 8
vCPUs. It has 24 clusters, each with two vCPUs that are a hyper-
threaded pair. It has 6 NVMe controllers, each with 32 queues, so
there are 192 IRQs to be assigned. With existing code, all 48 vCPUs
are assigned IRQs:  32 vCPUs get 3 IRQs and 16 vCPUs get 6 IRQs,
which is somewhat unbalanced but not terrible. With your patch,
all vCPUs get between 3 and 5 IRQs, which is an improvement, but
not as good as the theoretical best of 4 IRQs/vCPU. In both cases,
the NUMA nodes are slightly unbalanced -- 2 NUMA nodes
get 36 IRQs each, and 4 NUMA nodes get 30 IRQs each.

2) Azure D16plds v6 VM. This is an arm64 VM with a single
NUMA node. It has 1 cluster with all 16 vCPUs because arm64
uses CONFIG_GENERIC_ARCH_TOPOLOGY, which makes
clusters degenerate. It has 2 NVMe controllers, each with 6 queues.
As expected, existing code assigns 2 IRQs each to 6 vCPUs.
With your patch, 4 vCPUs still have 2 IRQs, while 4 vCPUs have
1 IRQ. I had expected that 12 vCPUs would each be assigned
1 IRQ, but didn't investigate why that didn't happen.

3) Azure D96plds v6 VM. Also an arm64 VM, but with 2 NUMA
nodes. Again, it has 1 cluster with all 96 vCPUs. It has 6 NVMe
controllers, each with 14 queues. As expected, existing code
assigns 6 IRQs to each of 14 vCPUs. With your patch, the IRQs
are spread across 26 vCPUs (13 in each NUMA node) with
counts ranging from 1 to 6. I can't discern a pattern in the
IRQ counts, except that the pattern for each NUMA node
is the same.

At this point, I'm just calling out my top-level observations.
I may look more closely at the details of "why" some of
these cases don't get much improvement.

Michael


>=20
> Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
> Co-developed-by: Long Li <longli@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> Changes since v1
> (https://lore.kernel.org/all/20260324075352.2326972-1-namjain@linux.micro=
soft.com/):
> - Cluster base is now a per-cluster proportional floor
>   (ngroups * cap / ncpus) instead of the global per-cluster minimum,
>   so proportional weighting is preserved on asymmetric (e.g.
>   big.LITTLE) cluster topologies. (Sashiko review)
> - Document that the rotation offset is call/probe-order dependent: a
>   device's exact layout may vary across boots and recomputes (each
>   layout is still valid, fair, and proportional).
> - Rewrite the commit message with a worked example and fio numbers.
>=20
