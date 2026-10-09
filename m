Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012075.outbound.protection.outlook.com [52.103.11.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0343A1A29;
	Fri,  9 Oct 2026 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525277; cv=fail; b=dCQrbzbYKAtQtQ8nVHvGh0vc2V78p5z78uTMaOM0QVSve5A2KBPl2Vf+pjGR7QJGtNVYK7k/DqmhUZMgZ1ss1GnWlj/4JD3yNe7v0YR/BfprP4/qDSRnUFhjUvc6VRYoI0ifPRQbvIkHsYS8Mm1KH3xSuZSmRbgoGwapW/X5rW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525277; c=relaxed/simple;
	bh=OV26oKARCkp7+G8IV2fbgSWRKiJmCeFxh9KYcvyixdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jT8a8MaBtCmvRQ6q2nByCrQXhxvd+DSElZgHMr6o4GOMf6ikdPE6I5bOjM8GAjtavBD5ksmLJ4lCeVdmWfFg16vk4b/XbJdmj4TCi61ztxZEmfxM5AFq70PMcYE+CRfCrgtnyP770B2lX2LGeq4VZmcuFJ8AkLJOLzIWF1ZLFqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gcr+Rs/F; arc=fail smtp.client-ip=52.103.11.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gcr+Rs/F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRAF2aToHlMPeQnob/oCa8S6BK2k6OIfeSEG47H59wctswrUaqVnIxr+ZbB0aA4WtzAPovrL4ffBKeY3E7ZlA6R6Lj9RemOBNUFjMPnnWi4XYk8JVgq88eE4zSRxWJiIWSewU6FDj91xmfwYpYfeAvj+UkvJSQnQHUZ3Mx2H6+piaEs5tEN4PAghdkTvbgXfcLwEFhRSDlbPsATN8uF1SOkzaLbjTx5Ba38v1vdYpg+BlCmXQhzpFOF4aPPtQCADUlX6cyPBptu5nJMapvF6a69gdHwXbhMo5L1N4JYEmbz8cJjBrQmM+nemd+J6uU8X/AJ+StR7o444JvBPfWBZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7RkjNMOHclL6v8DVbFJYlK/NZTQ4neWIxb9nHibeuo=;
 b=iEwXmBQ8ZMw/hZ3XdVFU0F06ML4y0PacmDQpFDpGo1qGvaAoDI6SPXm3g9t5aSc2YISVRhANencXezB242s1Kx8ym99NX+F2tlBljFbKyXrdZEdFjc/G7uMoYDSM4mku/9mY2BXhgLFOKmB4Ho/kIQvf+9lwdAp8q9ve7pVMJUeKvp3mosUTGJ5t37y7PHqgjF6TkxlUdBPH+I3xbqd3G5+Tdmy2nM/FWcB3h4J3jEMCkXCZyxw0k4hnr8Fyl0MOLMlivRR73O8ExkVALvnyL3Ztatp6zps7vMQ4UpZgBHPll7VKzJiPsWUTMNHuLVLVJKY2xBf3LLytImq5ZF0ZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7RkjNMOHclL6v8DVbFJYlK/NZTQ4neWIxb9nHibeuo=;
 b=gcr+Rs/F+LFgiaHu/HRIsCMJ29/c0F0HKDqI0zURX3B+OkCP8P0YQQ2aobP4Lu5EcWkuq6OgLnUWjpvLJHIl3M7297weX+hrOi1iWW4UeMxpuK50XjJVLiKfBqruOsYKMlMkXvhihiCLUzkj7+FwxDnQfc8m2AX5mqbkdP99yz/GacE1mLUQMTTu7I+6JBGiH5GZuQ5EIeHHuE5GehAxbWQOfOchB8GgsSb9tyAgj4Yjy/C8McY9G8g1V8i8639z11W209w8CMDkZK9JLLXoOMKLsohwuQTjxCw9brbg2fUfEAex5tZNrIlJYxcnT9+7OFlxveNSC26cN/cd2uGJkA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by MN2PR02MB7040.namprd02.prod.outlook.com (2603:10b6:208:1f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 05:54:31 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:54:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
Thread-Topic: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
Thread-Index: AQHdV6vpnDgVRbGlK0OQcDVR5VR04rb0syPQ
Date: Fri, 9 Oct 2026 05:54:31 +0000
Message-ID:
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
In-Reply-To: <20261009050556.2817978-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|MN2PR02MB7040:EE_
x-ms-office365-filtering-correlation-id: bb707d46-50d6-4254-1f23-08df25c9c9b8
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|24021099003|41001999006|13031999006|12121999013|55001999006|8062599012|19110799012|13091999003|31061999003|25010399006|8060799015|4140399003|52005399003|1602099012|12091999003|10035399007|2607281247196008|102099032|40105399003|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kzYKQakpe33aR2d4km61WkONDbXxYyJbIXSCLCq8hZM+cRBsUzMeSKTEqdne?=
 =?us-ascii?Q?LyYJXiepUu+DhB2rzB9glBGuxoJAaoplHov87WdaI9B6FfY5rWyzmkQAuS4n?=
 =?us-ascii?Q?0lPV2PDFs3MOblukfKQ0Z7/Cr8QDozh+fCfDcXcngzF8kcs6x7mZzyY4CQFc?=
 =?us-ascii?Q?eWwb/F9dbwUnC3+li0cc7JiIsvgbqvD/TTV/t9urps5jE3n0PfM3aC6lHQxZ?=
 =?us-ascii?Q?kHMiUHBF4+cXJqxDex1B2Nd4xJ/GbDqlOuhzk7pt0sJNhY+CO0mH0KZLzY9B?=
 =?us-ascii?Q?0E40wBi/lZLyUyT39VLhJK0iulPvD9kknf8Lqr7G1HEvO9VRNVZ0y8+cUH+1?=
 =?us-ascii?Q?v3Hx0blU7I+eV+AvfBkZW+NS1hOz05Yceurm/Cjg7b52iknKxG1p/2znTtNX?=
 =?us-ascii?Q?o1QP7s71byQEO4W3zSZOmFuyUt3iMhDHT1xRLPv3UBCrYuoCACroMUEzTkRu?=
 =?us-ascii?Q?0XHhvqGmPZz+k+aMPh+2DBWrJ1kVuQgC1qvXzEZjhrlQ2gmVtyb2Edo8ZdCq?=
 =?us-ascii?Q?PpaaNHdmElj1YSDZFEUgZqKxIwuHvKZbNV/ZgnZuMokRqtiByuR69js0WkCO?=
 =?us-ascii?Q?hF82HOA7LtoF2ZemnUIck1csRsA/QPOGDUsFTh4Waretip0RC7QC6k1pPhvs?=
 =?us-ascii?Q?V84hkfDczAw5KPsC8pIe0OTZBUa0oCZfrcRzW2G5My86j4e8peRDxARJ5EUo?=
 =?us-ascii?Q?GzfQiCy2TeYRI/UnFLQ5nH6/87KIBjm5JqXPqo8lxpVEljOSdei/Lz6GjpA7?=
 =?us-ascii?Q?50pCh1z5rlv7vU0ihpvjicAp1OuHLrA0DGPiftbB5xdlb9nkDQH/uLESro97?=
 =?us-ascii?Q?DdsFddrB86wBuWwluESQXAGB14fS0dKZoR00a4HkUwPqNtOVxN035Mx6GduK?=
 =?us-ascii?Q?MwQO7TLPDFoDmvyslBF3ueyBLiYP+JrkdJxOlUYW26cQFc4NkhkrxxFhbYeG?=
 =?us-ascii?Q?ionuftA6Wr7rfdkBQDuCAalbYGU3JktBiQdWWoVav54s6+Biziaemu223w9y?=
 =?us-ascii?Q?iO22qGPWVpFj0APFIaO8BSoQSJji4RWCkTtI4AeKJzzyGXy9UAxzumFnXeSP?=
 =?us-ascii?Q?0rpUSzzC3FHaODh7t8YySc0fc1v28MCb0WCxHrB+ngYw+5yMZUL44jdzkhKQ?=
 =?us-ascii?Q?0PnHOxgKqHz+hv+IZgpgb3nghFMuVsV7ZGxV2X2s5W8ui4XTLY2bWUUqbV7G?=
 =?us-ascii?Q?avx3snjZTD4O0h9C?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w4NelLR38a33MIGBJ1KamR2FyiZTyf4BnNCpFlwFIvTphrBn00n/nYoYfJMo?=
 =?us-ascii?Q?cdeWkRFK6HUi1sJGko+gUirbmz39W7c6o5vIszETKDJ3IcRia7FCBYKZ05Gf?=
 =?us-ascii?Q?3irHWzuIaIZ7XaMrK1vi0bMxjIx0R/SFyLXOVXPco6EXLoNCLQkZJ8CJba/7?=
 =?us-ascii?Q?NFmZ7kPiM7ldEdOx13CVRSLRkmv37DgIVXPIK8aEbnrQACIHGu5LxgfnTPD0?=
 =?us-ascii?Q?xc4Fw527VyI/KIlaL762LO/m0lR4ARkxOqoW4dx2lSSeCd7zrg5/LUhjbs0J?=
 =?us-ascii?Q?wNCbGbQgzirdaLImJElrbeEB1DiPCed4iMigYplh8/u6ffCCZGunCsqHEdO7?=
 =?us-ascii?Q?048qR65UrzD0x8lHUPE9EsFjrPrLbt7U0K4EYDg13DIrNojD8r1aN1+Oaf3U?=
 =?us-ascii?Q?JIKFDp4DKijdNQcmTjOsqiernxisPaoCf2GZFkHeV6ns31jolnTEQFvqcUC9?=
 =?us-ascii?Q?Rr8SWfqyMP87Cg3CGy9+jVXJkiS/u1i46whRFFNY8AxgutUv6bep/Vty3sy8?=
 =?us-ascii?Q?pAPViDJA+AJjvqFfi126ueFExzuAsJvzisDFiW2qCOgeafuTM3SOIGks5FrL?=
 =?us-ascii?Q?pXZHWBuoqJsjcxUYXIfiv1n3AMHgf1nZ/mJx9g5ENUrcqygQMP3CMy0jPZQy?=
 =?us-ascii?Q?h4IVl+v9phaTKp/JyS1datEeT/EixZFvIBmQuq434BT+2ePtLKUuvx3STax9?=
 =?us-ascii?Q?ZEz8aPrbtxtC1O0BL+P2utbCxoJqQNf6/XEz3HQ44EKmUiQ2v8GjY2U1FgGO?=
 =?us-ascii?Q?jJ4CA6R9NMMD6cRcogcE4OW7qhXYEGpSFtw5aJR3R2SLB7gDjBsgzMc+M9Ls?=
 =?us-ascii?Q?AYdxH53bmOfQ+kfZhwud58cNPJjFJvj0VZYidV6qGg6UabBsmjMhriitZjgx?=
 =?us-ascii?Q?1ZI6TCtOG51HyMBZSMrMPi2C1t0gR+8ewrzG5JhNlV4buRkdbJQ84ThFeyei?=
 =?us-ascii?Q?LzsGyFPEigdZBxCmOnItDZ4qqMSmeaavWJzV/VlacmV55+k6ueqCDaqowRBZ?=
 =?us-ascii?Q?C7DPOXtgJKry1czmowxAyK8At0cYBJ1hQ2ienvVcA5GyCPdRBq5cgwh+/nqw?=
 =?us-ascii?Q?htonvfF9nM+yyP0GemQo1YIBma32RxfQSAbkjvZ1De2azsJ1hDi7TaSNSc9k?=
 =?us-ascii?Q?imiltel7gi9ISG5ALIRoKwe9zFEb/+nNCTUuxAgqvB1OLo3ovYb9oYIonmJN?=
 =?us-ascii?Q?vAVsYRau6I/RB3KWO/vQei+KXk1+YQMfqmzcFN25EbrKqdBbg7gZs0RgcBWv?=
 =?us-ascii?Q?IhLm/2O+aDgarYo9L9Gpob1UPS7P7LHyYDqJ1dwQCs4kxZvkPgUmeyMt6SE7?=
 =?us-ascii?Q?bkTzo7V0bnwT03N83l3Gdup1//kO7uiKoofW5AJiCGm6cfTm6KcVnnGrC9CL?=
 =?us-ascii?Q?wWUMDqM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb707d46-50d6-4254-1f23-08df25c9c9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 05:54:31.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7040

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October 8, 2=
026 10:06 PM
>
> On systems with several fast NVMe controllers, completion interrupts can
> keep returning to the same CPUs faster than scheduled work can run. Each
> handler may drain only a small number of completions, but the combined
> interrupt stream can still prevent scheduler and watchdog progress.

See this recent proposal [1] that sounds like it is addressing the same or =
a
similar issue. And there is this [2] more global approach. It's worthwhile =
to read
through the discussion on both threads. I haven't done a detailed compariso=
n
of either vs. your proposal.

Michael

[1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@=
bytedance.com/
[2] https://lore.kernel.org/lkml/20260819124341.4185621-1-lrizzo@google.com=
/

>
> This series keeps the existing hardirq completion path for normal I/O.
> For an I/O queue with a dedicated MSI-X vector, if an interrupt arrives
> with a completion pending while need_resched() is set, mask that vector
> and hand the queue to irq_poll. The poller drains bounded batches and
> returns the queue to interrupt mode as soon as it catches up.
>
> The completion-path transitions are:
>
>                          +-----------------+
>                          | normal IRQ mode |
>                          +-----------------+
>                                   |
>                    CQE pending and need_resched()
>                                   |
>                                   v
>                      mask vector, schedule irq_poll
>                                   |
>                                   v
>                 +--------------------------------+
>           +---->| drain up to one poll budget    |
>           |     +--------------------------------+
>           |              |                 |
>           |         full budget        short batch
>           |              |                 |
>           |              v                 v
>           |     remain on poll list   irq_poll_complete()
>           |              |           mark handoff allowance
>           |     generic irq_poll      clear poll ownership
>           |     invokes next pass     enable vector
>           |              |                 |
>           +--------------+                 v
>                                   +-----------------+
>                                   | normal IRQ mode |
>                                   +-----------------+
>
> A full-budget return deliberately stays on the irq_poll list. The generic
> irq_poll core invokes another bounded pass. Eventually a pass consumes
> less than its budget, takes the short-batch path, and restores interrupt
> mode.
>
> An MSI-X message may have been latched while the vector was masked, but
> not every MSI-X hierarchy can report pending state. The handoff allowance
> therefore does not claim that an interrupt is known to be stale. It lets
> exactly one empty interrupt after unmasking return IRQ_HANDLED. If a new
> completion is present, the normal completion path handles it.
>
> The core idea is simple: when a hardirq sees need_resched(), it masks the
> interrupt and offloads completion processing to irq_poll. The interrupt i=
s
> unmasked once the CQ catches up. Everything else handles queue and
> controller state changes while irq_poll is active, because its asynchrono=
us
> callback can outlive the hardirq that scheduled it.
>
> The lifecycle transitions are:
>
>   normal IRQ mode / irq_poll
>               |
>               | set PAUSED, join IRQ and irq_poll, mask vector
>               v
>           +--------+
>           | paused |---- temporary ----> resume after controller is ready
>           +--------+                      clear PAUSED, restore IRQ mode
>               |
>               | permanent stop
>               | clear INIT, balance owned mask, synchronize replay
>               v
>         free registered IRQ
>
> INIT means the queue has an initialized irq_poll instance and a dedicated
> MSI-X vector. IRQ_POLL owns completion processing, while MASKED records t=
he
> matching disable_irq_nosync(). PAUSED blocks IRQ handling and new admissi=
on.
> HANDOFF allows one empty interrupt after unmasking. A temporary pause kee=
ps
> MASKED set for resume; permanent stop keeps PAUSED set through IRQ remova=
l.
>
> Admin, shared, legacy, and threaded interrupt paths are unchanged. Explic=
it
> polling never enters irq_poll; it only disables bottom halves while holdi=
ng
> the shared CQ polling lock. The series adds no timer, rate sampler,
> workqueue, sysfs knob, module parameter, or IRQ thread.
>
> Why not use nvme.use_threaded_interrupts=3D1 instead?
>
> Threaded mode installs nvme_irq_check() as the primary handler and
> nvme_irq() as the IRQ thread. When the primary handler finds a pending
> completion, it returns IRQ_WAKE_THREAD, so completion queue draining runs
> through a schedulable task rather than the normal hardirq fast path.
>
> That remains a useful opt-in mode and this series does not change it. On
> the affected VM it prevented the lockup, but it also reduced peak
> throughput. This series has a narrower goal: retain direct hardirq
> completion while the CPU is keeping up, and use bounded irq_poll work
> only after the scheduler has already asserted need_resched().
>
> The distinction is not that irq_poll is always faster than an IRQ thread.
> It is that the normal path is left alone, while the fallback creates a
> scheduling boundary only after a reschedule request is observed.
>
> need_resched() is used here as a best-effort pressure signal, not as an
> interrupt-flood detector or an elapsed-time guarantee. It is transient,
> and irq_poll may execute one bounded callback before the scheduler runs.
> The narrower claim is that, once an NVMe hardirq observes an already
> pending reschedule request, it stops unbounded CQ draining in hardirq.
>
> Previous NVMe attempts made the fallback the normal high-load path. An
> all-irq_poll RFC in 2016 reported an 8-10% single-core IOPS loss and a
> measurable low-queue-depth latency cost. A hardirq-first, threaded
> overflow series in 2019 fixed the Azure lockup, but Azure testing
> reported a substantial throughput loss.
>
> Relevant discussions from the past around this problem:
>
>
> https://lore.kernel.org/
> %2Flinux-nvme%2F1475660534-16681-1-git-send-email-
> sagi%40grimberg.me%2F&data=3D05%7C02%7C%7Cbbdfaf4318614114c57808df25c30
> 4c3%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C639271191764118549
> %7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM
> CIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D=
1
> mVDHNgaLqX48N6F4S5ny1KC76E4Yv6CM4k%2BOI7V3ks%3D&reserved=3D0
>
> https://lore.kernel.org/
> %2Flkml%2F1566281669-48212-1-git-send-email-
> longli%40linuxonhyperv.com%2F&data=3D05%7C02%7C%7Cbbdfaf4318614114c57808
> df25c304c3%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C639271191764
> 147973%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAu
> MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C
> &sdata=3D8LgU81UBs5FTTkkc7zbQo7Gx828IjfJO6Un9aebcdkM%3D&reserved=3D0
>
> https://lore.kernel.org/
> %2Flinux-nvme%2F20191209175622.1964-1-
> kbusch%40kernel.org%2F&data=3D05%7C02%7C%7Cbbdfaf4318614114c57808df25c3
> 04c3%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C639271191764169164
> %7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM
> CIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D=
N
> IMpebg%2B3xIyJvnIk7FbUJANUxhUSFmljodgIAqswTY%3D&reserved=3D0
>
> The first patch selects IRQ_POLL. The second makes existing task-context
> CQ polling safe against the new softirq user. The third adds the NVMe
> queue handoff and lifecycle handling.
>
> The RFC starts with a per-queue weight of 256, matching the existing
> global irq_poll budget. This is a starting point, not a claim that 256 is
> the optimal NVMe value.
>
> Testing included:
>
>   - full x86_64 kernel build and strict checkpatch
>   - four-controller QEMU fio, full-disable S3, controller reset, and
>     post-reset I/O
>   - QEMU lockdep, prove-locking, and atomic-context validation
>   - ARM64 Hyper-V VM with four 14-queue NVMe data controllers
>   - natural irq_poll activation with threaded interrupts disabled
>   - matching default-hardirq, IRQ-poll fallback, and threaded-IRQ compari=
son
>   - four controller resets followed by successful reads
>
> Read-only 4 KiB random-read results follow. "Default hardirq" uses the
> unpatched base. The other modes use the same kernel built from this serie=
s:
> "IRQ-poll fallback" uses the default nvme.use_threaded_interrupts=3D0, wh=
ile
> "threaded IRQs" uses nvme.use_threaded_interrupts=3D1. Low-load values ar=
e
> medians of two 30-second runs. High-load fallback and threaded values are
> medians of two and three 90-second runs respectively; the default-hardirq
> run locked up before it could complete.
>
>                               default       IRQ-poll      threaded
>                               hardirq       fallback      IRQs
>   1 disk, QD1
>     IOPS                      24.42K        24.96K        21.24K
>     mean completion latency  38.94 us      38.17 us      44.60 us
>     p99 completion latency   90.6 us       90.1 us       94.2 us
>     p99.9 completion latency 94.7 us       94.7 us      103.9 us
>
>   4 disks, 128 jobs, QD256
>     status                    lockup (26s)  pass           pass
>     IOPS                      N/A           4.986M         3.165M
>     bandwidth                 N/A          19.0 GiB/s     12.1 GiB/s
>     mean completion latency   N/A           6.544 ms      10.332 ms
>     p99 completion latency    N/A          14.483 ms      22.151 ms
>     p99.9 completion latency  N/A          22.544 ms      24.773 ms
>
> IRQ-poll fallback prevents hardirq starvation while avoiding the 15-37%
> IOPS loss and higher latency observed with threaded interrupts, by
> activating only under scheduler pressure.
>
> Naman Jain (3):
>   nvme-pci: select IRQ_POLL
>   nvme-pci: make completion queue polling softirq-safe
>   nvme-pci: defer completions when rescheduling is needed
>
>  drivers/nvme/host/Kconfig |   1 +
>  drivers/nvme/host/pci.c   | 295
> ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 283 insertions(+), 13 deletions(-)
>
> base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
> --
> 2.43.0
