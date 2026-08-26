Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011027.outbound.protection.outlook.com [52.103.14.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52417D6;
	Wed, 26 Aug 2026 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709721; cv=fail; b=kGJnQ9r0JMd+NeUIx+fR96F+yqsuHL9PBAnIVQe/4WHf7H6YYUozOo00MJ3Vor6jMnUvkcpIu56+jt7wz1I4oLJrIIr5SSD3DzlPJAfZ9UXBDqfBvsSvsBjjIPf1CNpDuaEbL8ThkV7EoVSNsuRdAImWp+3FMYv3LiRysxBhA2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709721; c=relaxed/simple;
	bh=QemnlEQDR4xi17zJ90IgAH6wvgJpjRWT6cqIqDU5YKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtFdL1vY6okQQ1EoLouVsWlPRHoOrnukB9T3rWsmA3ujGI4O/bsirdjAUqBLA4fZH/rYAv2kmYcmdoax64v/dIexP3UZ3rmbFJVO7WZRB438OD/8iXlFyWj1Xc6wYb5Sy3cQoXJZSDNfHX8tiy03odw9e9xQXDn44bVHw41L/Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DkAxnZU2; arc=fail smtp.client-ip=52.103.14.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DkAxnZU2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5chUeCZa9zgbOQWG+Z54v5Cp2DL5xe9WT+dCJdJS4Fwoe69jVR05sDDCt78ZJaG/td/VyEsGdjg47gZ9/k9adTR0VzzxvmkG1M/44HLgdMKRO3jr30kjrsKWWUggO59l+HNvw7OliOC46DmkkEoT4BTSQWJx6vWCfnyuqotmXaqIor67Vg/CM+W8BD/w1Xokhi1+/l7Tc4OnlEsQOIaeGz6ebzqSeMEIQWUYcOfHYgFut84iKT1rBptbr+NuZgXRiqc/ULjtyt1nF5DJWrMlHL24ALiLPNrFuv6lct2NZ5vemVLdVHHI4P5QZgCcWFIO/Oygp1W6JpALLtJcEYzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPbXYJHkH1iq5UW1zsqZ7eh4UPptW90xgFvIosqrkFk=;
 b=uDCJGf0q5ANUoroaj4KJDVr3iWOi4Zs/YqY8k1TjIupiOpEv0hLfokRJmuO3efhnAeZ53DbY1z59nCDx99gry7pvu004idnSolX0iQNPpUCciguUHC3u5RuIv5zkjFpDz9VOFhjvkmhjntEGCc6Ci/OxNm6pvrfLVZo0/WNb5evqVKKBbqC59PROcyto53LKJv242YQJSx5A26CCP+cnzlrUUHtr4td8cYyYHUtF0RvOVmSaOyYqlRLqtwgo9wY0BV5GsIoyZqNCdNDHGfucFP/5OfCSyShI3Vd9zgNA+MixxwbEd1xDg/3l2GeYiOU7TAIV2CRLiTWuHuP5tf5GAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPbXYJHkH1iq5UW1zsqZ7eh4UPptW90xgFvIosqrkFk=;
 b=DkAxnZU2LTYjvjaM+WWiBaHlOIu2STgaSRNGwRJhCb//cCX7kdlvMPK4iXsIdPKiFLDjZPvfHYlAoAHd+eLyp/c2/4V/A383Z0FjLNkp7fHFgTmex5CrZsNRD1bnsS6o1HjR4biw3QYiQqB9wXcYynsXjoU8a4xcIz5y3pGiNUCqeFVs/dZFs0qkxOJMfZrJ4eTQywcbKn/YFZ8n9pYtEke/3LmJI23yRTYAjx/r2II1ZxkdGVfKbuIZnbHTbR/uPKvXp1NKvUTKiu/MMSwbos+gO93sAMVX91LyakhXX+WUgNLkZ+DrX8RRgmCSeziF0fseBw4j9dS3StCvz7xpgQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8357.namprd02.prod.outlook.com (2603:10b6:510:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 02:01:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 02:01:56 +0000
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
Thread-Index: AQHdKJCMH5PeXdnWRUiBUqx3W0OgELavrJjg
Date: Wed, 26 Aug 2026 02:01:56 +0000
Message-ID:
 <SN6PR02MB415735EB56D0EBEAC606282DD4AE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
In-Reply-To: <20260810062144.2108758-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8357:EE_
x-ms-office365-filtering-correlation-id: becc0351-2bb1-4fe0-1428-08df031601e5
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|13091999003|37011999003|8060799015|55001999006|8062599012|19110799012|24021099003|31061999003|51005399006|15080799012|3412199025|440099028|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C3/7bMsVrznV93sLaPivm2Gidf4ohdmOrFd2Omwj7u0ouor6TbT1V2BhGsoj?=
 =?us-ascii?Q?7Tkk2NSfw4biwgnLh4hS8HgEDsqbCyfH6KnEO5kGa54QbLLRCMOxW67lFXxV?=
 =?us-ascii?Q?tI+JGNTCtP1L3o3VPvrE4sArl5NFFuTNCQxKBiK8HJdSQB8LVBCV6qKFUtts?=
 =?us-ascii?Q?CtUeKO7vbpdYCU6738reEvn9Es7zIXFDj9s/+VzLMaOb19jfBmcv8io6fGsM?=
 =?us-ascii?Q?LCeC2qcEE2THoBD4VvKQnZvusv08NCVBvn8MhDI15hpuJtp4tuFpJ/ic1kuG?=
 =?us-ascii?Q?7b9iHyH6XMdtgBX8d5ugONxZeggO+k3JOmrQKX+1AFzeqkNOwZvuM7EwB0GR?=
 =?us-ascii?Q?8FV9lDN2YEJAzHccl42JGTRiqOmrYnHTmZfVu/s9yJL+VmSMM74aPi3Hf3bw?=
 =?us-ascii?Q?iLjP+Urlc3fENbzeHQmqYsQbtMLHWzV8M9yJhOo8X0FpPBVSmv4O6oqhe0zX?=
 =?us-ascii?Q?GYZjOMY7Sq04TXSLmdaZEhZsTMRTvmPuoWFcdZXatwAcEYE6XI/RzV820Pjt?=
 =?us-ascii?Q?IQSEsVTgf7US2KoRX/StIweU+RdGvpjgfrsvTrMcaLAw/HaA7ZjYqSC/XiNO?=
 =?us-ascii?Q?URhwb9FjfL4qWi0QwmxJjvXEwox6nyt0eVd54bS6Fuc7aN2fKGwagWPL1var?=
 =?us-ascii?Q?rqNO7ZhC1GM1yedAxeGoN8rcjITcDTMbULIBqU3eKsvh640Cs9tHp2LBBHSw?=
 =?us-ascii?Q?ZiHm7iB96dNcn8C0YhOqJb4v7WsX/vQCoRqXeQGiS8ulYufuPnmVbDJu+a0v?=
 =?us-ascii?Q?XygrLXXrZFp1zGYkRXfAXnp7czS1HBtoBhMGlKdzrBrMtx7XWS1a2G4ry5h7?=
 =?us-ascii?Q?k7c/ek2yhEy9rfteScVpS4ni1zirX39aVDWfytpxzoZsA1/I/jUpTZiaSoZq?=
 =?us-ascii?Q?eVxQivbHaGOgMJMequ4PfssELEYYftJD9Xe8Xl2FJ9yPw2abfxnDkumM90lE?=
 =?us-ascii?Q?GrrR1XspkNpYAwAFLtajuzQhrU5phd3ZhrEJz3R+R0Hb+xysS7OFzvdNbLIB?=
 =?us-ascii?Q?NwIHCpjOdB+YBE9zpMfNfy5RuM8Q26T+8TFxYOALZJaKwgVMjzYNF71o0Udx?=
 =?us-ascii?Q?9fGre4wO?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cBydKTSmFDfi3S5RW6oDnO3s9mqPonwPf8wKpynj8shuQpRk+exABvVpZxil?=
 =?us-ascii?Q?SHSgAZMeKeZFvKwb2ncJkeR1gecW8HgKunBZcGudeOf6dT3Hpl12G/kq4pSL?=
 =?us-ascii?Q?0/9uCuqByqM87kD2WFOTVPDzb3mRoSpobIbI4bp7AMmow78Ne4f78k2fY4pq?=
 =?us-ascii?Q?6V0kRhZ9RSMhdiVYYxN5mAx06aP4k23Y/aVrmxioOSRXIO9PS6/mHaUn7+QG?=
 =?us-ascii?Q?ZH3u7BK88JjUBzfZ8H+ERQI7JBX4kpocKp8ytpYUrxcWAXIbgbisy7KW8LO1?=
 =?us-ascii?Q?/OBYg/fElGNoBWu1RGbKM6sxFwmLNjsmT6ol+SMrBWtQJqpEloUa/j/TmYU1?=
 =?us-ascii?Q?liferXZrG2mKuWAa8jnG7aXo0NKVkm5NReucpjw9xxBJkmgx3VXoKBALTcAm?=
 =?us-ascii?Q?LibWABkusRtRpTSbXEjsyGDxyIK7/waNgeogk0vD2NNLQggM8Zo6Q79cMGEi?=
 =?us-ascii?Q?wsgvdnfW0WKg+QxOnig/7QeQGZw5VrMig09MNYkFHUOfB/Xgr7IP9tLxIZjX?=
 =?us-ascii?Q?+J97pRypmNWTqQaoBF41KCPt1hB3LyVwoi4C3koDCYCSM1h7gWcqXvyQu2TI?=
 =?us-ascii?Q?xXU7NL0cIdnbLR53oJS+dl7Ypb1yAKIZuUG7L/xAVv4j9idkpLaW6N9iQ1X6?=
 =?us-ascii?Q?KQ2v2GbLTsvRgO1Zdr9NQE+O/x9s11AGvhKRfQWixGG4hTEeZ17kzm08bWKW?=
 =?us-ascii?Q?Q6Hm3t/tvFGFlstxi9CXZJ36yqzipkGWqAsiZ2RxlxAOmnTYKTF5HgxgUmuF?=
 =?us-ascii?Q?wn6c0ndaBFegXmBTHdXCGa/bSLet+vraTa/t4pEQoSm1c8l93ppIyUHPxfkY?=
 =?us-ascii?Q?mS9OnXjAeF6uoHZf5GKgokCeXMvLrq4Jq9/8N/0VlBX1gb5o2Ys3VhqLS0/G?=
 =?us-ascii?Q?yKdbv4JxF4vMzXOqejl0je4XNlM8Bhf0/o3y4wQ+qLSWu7LfYM7O7AIov+gr?=
 =?us-ascii?Q?mHAa1K0e8dtQPnHEb5BqQ0X232huyLCX6T5uRivu2BzXT6aPIz1QZ8TSMkRg?=
 =?us-ascii?Q?g3b6YLAdbhZLsZGodKSGnbDPXRjbohQUhU2SRqxuuutICFj9VjgTJGNBJh1X?=
 =?us-ascii?Q?vQAg6Su0SrSiAad6NZKJ4WLs+xw3f3Repbw5EMY4CEkj909vN1ScCaqMavAO?=
 =?us-ascii?Q?7qH6xLB7oik5lothbHNvpjRGxYBmlGWt0Kp1rrlHfKhc9Izp6k2I2rOSf8/Q?=
 =?us-ascii?Q?tPyfZdLeOeEXU9IjN0ss60d43HWfBQmBynjlM/l0Je21AaetusmX+NWY7Dzh?=
 =?us-ascii?Q?Fl/denXRuayRGXU0G5f5KNj5dHX3rn+taNz4vN+iyD+zItPTGLc+rApA9sb5?=
 =?us-ascii?Q?UjKm35vq2VnbugKpMWKqG8SURrK+G+GWzErSO7VTotR4kj2f0hSIbfiBrpq2?=
 =?us-ascii?Q?UvMUE3I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: becc0351-2bb1-4fe0-1428-08df031601e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 02:01:56.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8357

From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 9, 2026=
 11:22 PM

[snip]

> @@ -510,6 +633,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s, unsigned int *nummasks)
>  	if (!masks)
>  		goto fail_node_to_cpumask;
>=20
> +	spread_offset =3D (unsigned int)atomic_fetch_inc(&group_spread_cnt);
> +
>  	build_node_to_cpumask(node_to_cpumask);
>=20

One additional observation:  In my testing, group_cpus_evenly() is
often called with numgrps set to 1. This happens in the block "loop"
devices (drivers/block/loop.c) and for the NVMe admin queue. In
these cases, the spread_offset is never used, but group_spread_cnt
gets incremented anyway. Incrementing for NVMe admin queues
tends to dirty the spreading for multiple NVMe devices with the
same configuration because it is usually interleaved with the
spreading of the main NVMe I/O queues.

To improve this, I changed the above code to this:

+       if (numgrps =3D=3D 1)
+               spread_offset =3D 0;
+       else
+               spread_offset =3D (unsigned int)atomic_fetch_inc(&group_spr=
ead_cnt);

With this change, my configuration #1 (Azure L48s v2 VM) is noticeably
better.  All CPUs in NUMA node 1 have either 3 or 4 IRQs assigned. NUMA
node 0 ranges from 3 to 5 IRQs, but that's partly because the NUMA
nodes themselves aren't balanced, as previously discussed. With your
change to apply group_spread_cnt to the NUMA nodes, and my change
above, my config #1 is likely to work out very near optimal. Of course,
there's no guarantee that some other device won't increment
group_spread_cnt and dirty things, but for the typical case it probably
works very well.

This change to skip incrementing group_spread_cnt when numgrps =3D=3D 1
doesn't help my arm64 configs. I'm still thinking about ways to do better
when there aren't any clusters. I have an idea that I'm experimenting
with, but it may be a few more days before I reach any conclusions.

Michael
