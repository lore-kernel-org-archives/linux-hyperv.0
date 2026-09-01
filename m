Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010095.outbound.protection.outlook.com [52.103.10.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD35A79B;
	Tue,  1 Sep 2026 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788220941; cv=fail; b=WC1dBMTLRP9J0eeAH0lpz23jMVjdBlvOAABi2+OetQ0t3uGdy82EVP26qAY7eA+a9wPJHTFpzmqRnW21d+xhb8E4ECXrbpfL4e8LvYAPrs5ufGzkvQ7ywHNepgYs2P+NC3PkQHsByzDvtlKB9oGo8YSaM2v10GcqvPB90hgD9tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788220941; c=relaxed/simple;
	bh=laXvH5yGiMAFGr98/32Iw4xgj2on9rnvpAW0Kfy5Sec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IzwW7KVkhnRtrJIi90paZgj3tuB1u/MPVQmxCsIKz6h2adzEh3fzCHRfSIoK0ASRP4iuhydT3NsOO0RQAMzrdmKgwsH93m/ikEXv7vRPkTeUZm26+xT97KmdAhTmkKOLCsmUs8K+wrrfIrENzNvT5p9TUg3M7dCDVjawK2+yi2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NJ5e3ZCZ; arc=fail smtp.client-ip=52.103.10.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NJ5e3ZCZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE65b7er6Oo3m6m7cb2778vaFhm0jyFa+tcnG+s/uRuKbdtMQHw+E/4RxbS5P/yiLFNeq3Y5dHdKM0xQnnwAqnCygV61cgs3V92h6/GtYMHRPlBt17ucuZ2E18B/6QL/jtV4ZcwrOI51Toy2B/2tv54bPZzaocLPQzlN4x3xg+lM/zbM5Cb0Zes7QstxLJ0rTXWutw6CgsgoeqBosV+lnc3hNn4+2lmHwyMs2FxnCMLcql4DFgIiSYVLdyoEYdJxDUIej9DIOFd59Dgsr7pbY3HpOQa8qqeM37eTpshP3iBFeqyBJv1lUYgXAdfURywYOM2Y+LcVsMWtBNiTPLruqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsgdh8nuCpSnMhZWpOXztufrwhjjmX7qhd4pU9ND+cQ=;
 b=w8rNUNrdxjj0J1/HQSI+OtT+XF9szYAtjbSz2cc0NCcxPEh5+0uFYbxVo8ZNJqdtBq10ThA4QqI3IMoZCYp1xd8Tgciqem2+xr+kNZpIO0YOVAz83w+dbLAFcVkWph+hJmms0U6vwqkoVKDavAxs6dLqXENES5GZw+yawMq89Wq3N8ggIjltPhLD32ReRbxu7SJJEBK9ikQH29tLH54Ea1+TCjoLHNWCDKQpcpanCTW/af2vk/7CToEzutpdkTfTfLg0Cya1DLQrsHJ8A6FGItNsYawLbh5REWSzYTDXfHS1EGIeJ1uDjYy+fRyDbcZBWBGnBEotPvZ3NRCEHtC9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsgdh8nuCpSnMhZWpOXztufrwhjjmX7qhd4pU9ND+cQ=;
 b=NJ5e3ZCZiW+mlncC0VTswyxunvJs9bhTCdvOMyRANwt9ak0bHWXsxEOVX9Ojrz/hA52ffXGQi3mcOHY9WgfZ8GOjM27dtyhNQ4aoSUROwSD3AY8aGwOVClN5UUfAmHCvRCD3rHMGU2IF5gvs02VK9PodFb/HQ/TjlZN1P3M1FGfEsEWxMNyXTQ7aoba6FSXk2RK9Y0Fo6Tyk4e4vCXC/RxUy8JvcsHDfPEWN8BR+HMLon/UNhAkD0pMKQEm5rL6xKBMFVCheLcdQPy0FmH/6nsuGQQ4nFgrWQlZICoVtFip4Y5cjqGYIC688DVN/yFQho/30mFeHym0SkyXNBMiXkQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8749.namprd02.prod.outlook.com (2603:10b6:a03:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:02:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 00:02:16 +0000
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
Thread-Index: AQHdKJCMH5PeXdnWRUiBUqx3W0OgELa4+Kew
Date: Tue, 1 Sep 2026 00:02:16 +0000
Message-ID:
 <SN6PR02MB4157B73B333F08702875110ED4A82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
In-Reply-To: <20260810062144.2108758-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8749:EE_
x-ms-office365-filtering-correlation-id: 7893031d-e468-49e0-fd55-08df07bc48df
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZn9IFDOZRHBr3PkJ6iE+FIkK51e0NHkjyLkYRJu5m7QfGDX0SJ/wP5ncOvPynOxMqrfvv67Y/vegi1DVA8vRwuLm+bPEQEkUDtyj+jqqjCGH8oK665ToBEIXF/K6xsxVh5hi1I1DBPmC0kKMWvhYxmXdhpJ7lh1QzOOxFsxQ2hQEmTbI/xGqHcMatuXQLc0Tix+NGnIdQc5gOAw1tfeBZtKsu37Lnflmtv3JkZx8q0la36mIHHR+2CMWIP2VZehLXwiD94ya36IuqUFvHg2dqHNw5kshvbPmmUMhJm6HKGBaRb0t+i27ZDHtj4fmA2nykU0h/5bn8tsO9TK9BzWLcrjsRpbaQKkGF6XO67UNYnmPQs/QZAicDY9pz0rf6cYeKsZTmJXxr5jiOAK5yYzbs+4faF1aOBot2bV1GC1fFR7MWLHXyq2RYZTzaAg+qjtfc5NFcS9DXdY/hLuDVmMTlYnkgGiRKlFRJ+7pjPDlFklUXXw6YrbX2yz0USJVfW21iOGsMdrXwqbHW5T28hdlYrsNd/jn9xxe+DvGVGS9/6Tv6R3BLIlPk+dueyxScggeKaUg9pAzAC4DJEYVTauzLdNGkrAP15sFtGaakfVAL7JwQ3T5C6tPRsPwIdB+ZaU45pOdfETA9m6/LXnWpqV/KeCiR1yZfi0xmqlP1v3U6dZABw+Alpqbcopcnp2pWhuxTFnMMgjHyPirILOnfIL3wfl2NMQqeJO796hwFaR+DGxtcASzK7U7LaZRx4rwi8zN+q7SQYfI7Xtga1ausaF+vS7kB1ESLc9gHQUZkvoX+FoNGxPqcPS0PtD
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|25010399006|37011999003|8060799015|19110799012|8062599012|24021099003|55001999006|15080799012|51005399006|13091999003|31061999003|18061999006|4302099013|3412199025|440099028|102099032|1602099012|40105399003|2607281247196008|10035399007|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nZ14YZtbsHd9sS5U9+u5ICv/Q0S+zwSL7y5tqeCmn2xOdCkyeFW+bhqSAkZI?=
 =?us-ascii?Q?zOFdMeQcd0pHcz1IbL2EBpiGi3i9RZWOGt1sJPB002ZwfULOmu9CxEB8D+Bv?=
 =?us-ascii?Q?5AQgtpzj6hq5AqJJgdWr8UGqD+m/iwo0+HQyTDUpuM0qGq8JkY8aFdcekiaw?=
 =?us-ascii?Q?v7NfE6WaAx9CBz6R0wipR5oxAIVTIhIMGwU4M6t8LFTPaNU4+ZzcJFsjWGXw?=
 =?us-ascii?Q?tKE4zmti7XNV0P2lPylfimK9sw7pmAJ6tLgx7M7mnB8Rhp9RGSNFecG/z5n8?=
 =?us-ascii?Q?mWzQ6FydnmwktabU4ia7kUGMUputkW1m/RGKn5yyCAoYlqPOtxU0bNezC5aI?=
 =?us-ascii?Q?VUgZnmAQzE22fTljEfT343gjdtun88HLq+SM6gpoSoOeZU84mSwa6MlK5eoP?=
 =?us-ascii?Q?qwq/qRsHe9W1BBsi1jvPmmrUUUORGHFTircu7ZwGASWYX5PoQqrKCm+0HhaZ?=
 =?us-ascii?Q?T4RMv8cX6npW2VdBDKSnJNg4fmhynpd+tCppzk5XwVfJXpeW/VFL7+lZuQc1?=
 =?us-ascii?Q?sf/I+sYHR+P7Srl7WJosGmpzpcBbC9bKTepnCvDfkgHqICpkSB1qfora0EJ6?=
 =?us-ascii?Q?Q/RDZgeTzPxYP56Cz4zo7EsUPVC9eLeOkTsffufgFxW3KfHOY+CC7Rvjt4hn?=
 =?us-ascii?Q?L4BwZb+gS7xjoRiVoW5TbQ6Vje9kTM4gyFsn1QkwK+mzLYyAl/60BQmHSZTU?=
 =?us-ascii?Q?nml/OneOzDltKyksc0yrDXyNniMPXoysqeSAOJBpilMxDsKsAY/dSC3Yuefx?=
 =?us-ascii?Q?rLHGK57CNkhBwgydW+NTNioLT8uJm2S2WLwhXpK18haEGOJfif2TslfesdF/?=
 =?us-ascii?Q?ETVl9VDuv3lxms0cNXLwmB6d5Qn2n3lAFBNFkPUUdNwFaw/Qnmk8YgB4vl4V?=
 =?us-ascii?Q?J/9aF1yWWGW4K4BONMR/rnxMPsu7feGBIhGpOliB5JRe16LO6wt3EcewMi1l?=
 =?us-ascii?Q?l7Dafwr2KR0fgbgSf+3LzDov6Zhoyu4swwSVWmxc95VIovdop0mmr8bBW08O?=
 =?us-ascii?Q?Ca5xMsC9H8hvcWAU8MaUYYRcb1qYD5OIwKlMDwcIb2S6jjbrH14su/SZFhhE?=
 =?us-ascii?Q?576EbpmYqAQiFU0Z+yPjdc7Lafy0+GG8kw3G8r+TH8Kz9BJYTuSippEFBPJq?=
 =?us-ascii?Q?nlub8O+72TZ2/9ZC9GINDMYMozR/upxh3F4WsjX7qM9ESBRDY4Uo36l+w1fb?=
 =?us-ascii?Q?3mAJiGVjQM9GNFikmZ/SoMRzyosZmzG/l9kV2w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YgvX0fuRiUf27mhx5soeK9kPzcCcsR9rmI+Lo4X4yzXSO/0xr9hMt8LGeCwh?=
 =?us-ascii?Q?/bHKvpVfqd0zGbbYxbzcaZV8+XIkZlQkB81PcFKt0aIj9SbY4SbPqyWuBZKy?=
 =?us-ascii?Q?ftUpReXQjg05DOiiD5sCQAZqvyL28vbMVSmU/MPH8b97HVZ+P9hVaWPkh7kU?=
 =?us-ascii?Q?jDtOwFNCC4OGfNG6Boz1mAxh/fbnn/fXYNSw69Ison9GXknG4wahNMZ/FG4P?=
 =?us-ascii?Q?32fUKPnBOW0OvaR8MInE4ChsV6q3TZ/6sUcRPkZ+8gEJtBAbJiAZZoMHH77r?=
 =?us-ascii?Q?Q5QW7iMOLYM/c+FlFdbZxf6qPsKAsCd+GtsDzGZlXKfHePXEGCcgVaF3bHFy?=
 =?us-ascii?Q?Z4OyWZJ3VhVgBNpvBfTM9Be5ofMTOM+ApSnE/uUtVDB8oTIGJ9uylMxfDLbZ?=
 =?us-ascii?Q?DWx24g2TA4+mjW3oEAF8vKn49EEXCtwPlMbNYiYNZ3FYL/uFN+P1EOBmBg+I?=
 =?us-ascii?Q?pie36DyhfhgFj6hSZ1ezGet51cO7BHE/PwSd/PMkRBYHLubLv/kDc4ErJzrs?=
 =?us-ascii?Q?FA74a2mzHFPTX3N6ScRuZqR76kcKyb5BS6YJ1AZ+cF24CbqC8YTaoEU8mfml?=
 =?us-ascii?Q?3oqZ+0bTqGJn2M11AtRpxCDcBncSchnrt1BprsguasDkgG/JObqegPKu/DT/?=
 =?us-ascii?Q?zIqFB7fKJRhCesasXPOyWeR5qQCIuH6jtkZzJd8ZVDjsxplnnnnsmAMaB57C?=
 =?us-ascii?Q?70lcYZKQG3UKOeCCLd7bN+1RE/klYRnR+ThoTQ8Ahqb6YCG2XTVn3tZSWK/G?=
 =?us-ascii?Q?w9NKgZxTOJmsJzPmmJ1Ki46WYnec+3Hq2f+KKX5FUOsWPBzYykG2PIJsxwfe?=
 =?us-ascii?Q?0huB/5Lr5CMverYGQd/9v0g+lif64ORNO9K9oACKurnYgPbTNNQ7Aw6LLuM4?=
 =?us-ascii?Q?a6N1FvoOwoScB33NT3YiAyBimPUvVj4GG/PbTrHL6Bc3/AvhtFV6a/KzLDgt?=
 =?us-ascii?Q?ltuJ6rCDqecsb61BZbcjLEPt857KiC/meylgk7UCjqKFxizNwyzFgYQvpXgG?=
 =?us-ascii?Q?Pwtl7Nj79ds6Iq4DERrGxH5Dq1A9SC0WlFF1Fe7Hb6154SXLNQY1vSd2RiaU?=
 =?us-ascii?Q?vOYHEbjtSVlNbVYglMtqCylXvAaFB7W0hKp7FFMaKAw7ThLr1DXalJg1SpI5?=
 =?us-ascii?Q?VJHucputknUJ58VjZkeek3kWZZtSOPlopv1QXiJrhy61Y3ZCxo93akFpT0X3?=
 =?us-ascii?Q?0Fl7DfXANPaJWfJXUc0uP4QXMzTaDrNWRt6tqxedp2haZf84ul+snE3bhRXu?=
 =?us-ascii?Q?/cAlndO9pzy3E2i9YhmrshN+YKIDEkclpjf3YMqlLlIMWuOg5immcwGIdFDP?=
 =?us-ascii?Q?r76DVHpeIpYeSxH3kgQGWjw7yL0eB6u4yBFUvmcD/Z4ZEjdak72ah9rJPqO8?=
 =?us-ascii?Q?jiueyns=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7893031d-e468-49e0-fd55-08df07bc48df
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 00:02:16.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8749

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

This is not quite accurate. The condition is ncpus/2 < ngroups < ncpus.
If ngroups is <=3D ncpus/2, then all groups have at least 2 CPUs. If ngroup=
s
is <=3D ncpus/3, then all groups have at least 3 CPUs, and so on. Rotating =
which
groups get the "extra" CPUs can be somewhat helpful even when all groups
have at least 2 CPUs. But as the minimum number of CPUs per group
increases, avoiding excessive stacking depends on how well the irqchip driv=
er
does spreading when picking the effective affinity CPU from the multiple CP=
Us
assigned to the group (per our discussion elsewhere in this thread).

> interrupt whose mask has one CPU can only run there, making that CPU a
> "hot" handler. Because the mapping is deterministic, identical devices
> compute the same layout and stack all their single-CPU IRQs onto the
> very same CPUs, leaving the rest of the system idle.
>=20
> This is easy to hit in practice. On an Azure L96as_v4 VM (96 vCPUs, 2
> NUMA nodes of 48 CPUs, 6 NVMe disks with 62 I/O queues each),
> group_cpus_evenly() splits each disk's 62 queues into 31 per node over
> 48 CPUs. 48 does not divide evenly by 31:

And FWIW, this example meets the stricter condition that I describe above .=
...

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
>  lib/group_cpus.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 137 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index e6e18d7a49bba..8bed0f9d2110b 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
>  #include <linux/sort.h>
> +#include <linux/atomic.h>
>  #include <linux/group_cpus.h>
>=20
>  #ifdef CONFIG_SMP
> @@ -255,12 +256,20 @@ static void alloc_nodes_groups(unsigned int numgrps=
,
>  	alloc_groups_to_nodes(numgrps, numcpus, node_groups, nr_node_ids);
>  }
>=20
> +/*
> + * Per-caller rotation counter for group_cpus_evenly().
> + * Wrapping is harmless: the offset is only used modulo small values
> + * (ncluster or nv->ngroups), so any unsigned value works.
> + */
> +static atomic_t group_spread_cnt =3D ATOMIC_INIT(0);
> +
>  static void assign_cpus_to_groups(unsigned int ncpus,
>  				  struct cpumask *nmsk,
>  				  struct node_groups *nv,
>  				  struct cpumask *masks,
>  				  unsigned int *curgrp,
> -				  unsigned int last_grp)
> +				  unsigned int last_grp,
> +				  unsigned int spread_offset)
>  {
>  	unsigned int v, cpus_per_grp, extra_grps;
>  	/* Account for rounding errors */
> @@ -270,11 +279,15 @@ static void assign_cpus_to_groups(unsigned int ncpu=
s,
>  	for (v =3D 0; v < nv->ngroups; v++, *curgrp +=3D 1) {
>  		cpus_per_grp =3D ncpus / nv->ngroups;
>=20
> -		/* Account for extra groups to compensate rounding errors */
> -		if (extra_grps) {
> +		/*
> +		 * Rotate which groups get the extra CPU so that
> +		 * successive callers produce different mappings,
> +		 * avoiding IRQ stacking when multiple devices
> +		 * share the same CPU topology.
> +		 */
> +		if (extra_grps &&

Explicitly testing extra_grps for zero isn't necessary. If it is
zero, the "less than" test below will always be false anyway.

> +		    (v + spread_offset) % nv->ngroups < extra_grps)
>  			cpus_per_grp++;
> -			--extra_grps;
> -		}
>=20
>  		/*
>  		 * wrapping has to be considered given 'startgrp'
> @@ -361,7 +374,8 @@ static bool __try_group_cluster_cpus(unsigned int ncp=
us,
>  				     struct cpumask *node_cpumask,
>  				     struct cpumask *masks,
>  				     unsigned int *curgrp,
> -				     unsigned int last_grp)
> +				     unsigned int last_grp,
> +				     unsigned int spread_offset)
>  {
>  	struct node_groups *cluster_groups;
>  	const struct cpumask **clusters;
> @@ -379,6 +393,111 @@ static bool __try_group_cluster_cpus(unsigned int n=
cpus,
>  	if (ncluster =3D=3D 0)
>  		goto fail_no_clusters;
>=20
> +	/*
> +	 * Rotate which clusters receive extra groups so that different
> +	 * callers of group_cpus_evenly() produce different group-to-CPU
> +	 * mappings. Without this, all devices get identical affinity
> +	 * masks, causing IRQ stacking on CPUs assigned single-CPU groups.

s/assigned/assigned to/

> +	 *
> +	 * alloc_groups_to_nodes() distributes ngroups proportionally, but
> +	 * integer rounding causes some clusters to get one more group
> +	 * than others. The assignment is deterministic, so every device
> +	 * gets the same mapping. Fix: compute a proportional floor for
> +	 * each cluster (ngroups * cap / ncpus), collect only the
> +	 * rounding-induced extras, then redistribute them starting from
> +	 * a rotated position. This preserves the proportional weighting
> +	 * across differently-sized clusters while rotating the rounding
> +	 * extras, keeping the rotation effective on both symmetric and
> +	 * asymmetric cluster topologies.
> +	 *
> +	 * Note: after alloc_groups_to_nodes(), cluster_groups[].ngroups
> +	 * holds the group count (the union no longer holds per-cluster CPU
> +	 * counts), so each cluster's CPU capacity (cap) is taken from its

Having to recompute "cap" three times in the code below is fairly clumsy.
Is there any reason that cluster_groups[].ncpus and .ngroups need to be a
union? If they were separate fields, then "cap" would be immediately
available when you need it. I looked back through the commit history
and LKML discussion for when the union was originally added, and I
didn't find any explanation for why it is a union. A union saves a bit
of memory, but the overall amount of memory here is small, so the
implementation doesn't need to be particularly stingy.

> +	 * mask. The ncpus divisor is the function parameter, which equals
> +	 * the sum of the per-cluster caps.
> +	 */
> +	if (ncluster > 1) {
> +		unsigned int total_extra =3D 0;
> +		unsigned int start, stride;
> +
> +		/*
> +		 * Compute a per-cluster proportional floor and collect
> +		 * only the rounding-induced extras for redistribution.
> +		 *
> +		 * Each cluster's floor is ngroups * cap / ncpus, which
> +		 * preserves its proportional share.  Only the rounding
> +		 * remainders (typically one per cluster) are collected
> +		 * for rotated redistribution, keeping the rotation
> +		 * effective even on asymmetric topologies (e.g.
> +		 * big.LITTLE) where differently-sized clusters would
> +		 * otherwise absorb all extras deterministically.
> +		 */
> +		for (i =3D 0; i < ncluster; i++) {
> +			unsigned int cap, prop_floor, base;
> +
> +			cap =3D cpumask_weight_and(clusters[cluster_groups[i].id],
> +						 node_cpumask);
> +			prop_floor =3D ngroups * cap / ncpus;
> +
> +			/*
> +			 * Use proportional floor as base.  Ensure at
> +			 * least 1 group per cluster, and never exceed
> +			 * alloc_groups_to_nodes()'s original allocation
> +			 * (which may be less than prop_floor when small
> +			 * clusters consumed groups via max(1,...)).
> +			 */
> +			base =3D prop_floor > 0 ? prop_floor : 1;
> +			if (base > cluster_groups[i].ngroups)
> +				base =3D cluster_groups[i].ngroups;
> +
> +			total_extra +=3D cluster_groups[i].ngroups - base;
> +			cluster_groups[i].ngroups =3D base;
> +		}

We had a separate discussion about how your new code here should
go with alloc_groups_to_nodes() so that it is also applied at the NUMA
node level. You said you had it working. Question: Did you combine the
above "for" loop with the "for" loop in alloc_groups_to_nodes()? It
seems unnecessarily complex to do group allocations, including extras,
using the "for" loop in alloc_groups_to_nodes(), and then follow that
with another "for" loop here to figure out which nodes got extras and
strip them out. A single loop should be able to set all the nodes to
their base value and count the extras.

> +
> +		/*
> +		 * Redistribute rounding extras using a stride to scatter
> +		 * them across clusters.  With stride =3D ncluster / extras,
> +		 * consecutive callers' extra sets overlap minimally
> +		 * (e.g. max 2 overlap for 6 callers with 24 clusters
> +		 * and 7 extras, vs 6 overlap with stride 1).
> +		 */
> +		start =3D spread_offset % ncluster;
> +		stride =3D (total_extra > 0 && total_extra < ncluster) ?
> +			 ncluster / total_extra : 1;
> +
> +		for (i =3D 0; i < ncluster && total_extra > 0; i++) {
> +			unsigned int idx =3D
> +				(start + i * stride) % ncluster;
> +			unsigned int cap;
> +
> +			cap =3D cpumask_weight_and(clusters[cluster_groups[idx].id],
> +						 node_cpumask);
> +			if (cluster_groups[idx].ngroups < cap) {
> +				cluster_groups[idx].ngroups++;
> +				total_extra--;
> +			}
> +		}
> +
> +		/* Fallback: place remaining extras wherever they fit */

Just so I'm clear, you could have "remaining extras" because a stride > 1
in the previous loop could miss some clusters/nodes that have available
space, depending on how the arithmetic works out. The code below
does essentially the same thing, but with a stride of 1 so that every
node is checked.  And you might have to make multiple passes in
case some nodes have space for two or more extras. But you know
there's enough space available somewhere.

Is my understanding correct?

> +		while (total_extra > 0) {
> +			unsigned int placed =3D 0;
> +
> +			for (i =3D 0; i < ncluster && total_extra > 0; i++) {
> +				unsigned int cap;
> +
> +				cap =3D cpumask_weight_and(clusters[cluster_groups[i].id],
> +							 node_cpumask);
> +				if (cluster_groups[i].ngroups < cap) {
> +					cluster_groups[i].ngroups++;
> +					total_extra--;
> +					placed++;
> +				}
> +			}
> +			if (!placed)
> +				break;

Is the control variable "placed" necessary? If all the extra groups are
guaranteed to fit somewhere, then total_extra should go to zero and
the checks on total_extra > 0 will break out of the loops. Thinking about
it from the other direction, if the "for" loop ever completed without
incrementing "placed", wouldn't that mean total_extra is still
non-zero, and you have an extra group that isn't assigned to a
cluster/node?

Michael

> +		}
> +	}
> +
>  	for (i =3D 0; i < ncluster; i++) {
>  		struct node_groups *nv =3D &cluster_groups[i];
>=20
> @@ -389,7 +508,8 @@ static bool __try_group_cluster_cpus(unsigned int ncp=
us,
>  			continue;
>  		WARN_ON_ONCE(nv->ngroups > nc);
>=20
> -		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
> +		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp,
> +				      spread_offset);
>  	}
>=20
>  	ret =3D true;
> @@ -404,7 +524,8 @@ static bool __try_group_cluster_cpus(unsigned int ncp=
us,
>  static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgr=
ps,
>  			       cpumask_var_t *node_to_cpumask,
>  			       const struct cpumask *cpu_mask,
> -			       struct cpumask *nmsk, struct cpumask *masks)
> +			       struct cpumask *nmsk, struct cpumask *masks,
> +			       unsigned int spread_offset)
>  {
>  	unsigned int i, n, nodes, done =3D 0;
>  	unsigned int last_grp =3D numgrps;
> @@ -455,13 +576,14 @@ static int __group_cpus_evenly(unsigned int startgr=
p, unsigned int numgrps,
>  		WARN_ON_ONCE(nv->ngroups > ncpus);
>=20
>  		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
> -					     masks, &curgrp, last_grp)) {
> +					     masks, &curgrp, last_grp,
> +					     spread_offset)) {
>  			done +=3D nv->ngroups;
>  			continue;
>  		}
>=20
>  		assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
> -				      last_grp);
> +				      last_grp, spread_offset);
>  		done +=3D nv->ngroups;
>  	}
>  	kfree(node_groups);
> @@ -488,6 +610,7 @@ static int __group_cpus_evenly(unsigned int startgrp,=
 unsigned int numgrps,
>  struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nu=
mmasks)
>  {
>  	unsigned int curgrp =3D 0, nr_present =3D 0, nr_others =3D 0;
> +	unsigned int spread_offset;
>  	cpumask_var_t *node_to_cpumask;
>  	cpumask_var_t nmsk, npresmsk;
>  	int ret =3D -ENOMEM;
> @@ -510,6 +633,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s, unsigned int *nummasks)
>  	if (!masks)
>  		goto fail_node_to_cpumask;
>=20
> +	spread_offset =3D (unsigned int)atomic_fetch_inc(&group_spread_cnt);
> +
>  	build_node_to_cpumask(node_to_cpumask);
>=20
>  	/*
> @@ -528,7 +653,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s, unsigned int *nummasks)
>=20
>  	/* grouping present CPUs first */
>  	ret =3D __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -				  npresmsk, nmsk, masks);
> +				  npresmsk, nmsk, masks, spread_offset);
>  	if (ret < 0)
>  		goto fail_node_to_cpumask;
>  	nr_present =3D ret;
> @@ -545,7 +670,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s, unsigned int *nummasks)
>  		curgrp =3D nr_present;
>  	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
>  	ret =3D __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -				  npresmsk, nmsk, masks);
> +				  npresmsk, nmsk, masks, spread_offset);
>  	if (ret >=3D 0)
>  		nr_others =3D ret;
>=20
> --
> 2.43.0
>=20

