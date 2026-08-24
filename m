Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012068.outbound.protection.outlook.com [52.103.14.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA187126BE1;
	Mon, 24 Aug 2026 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787543515; cv=fail; b=jznX7q1xUSJ5t2mxwb902YwaR0WNvnMXQc/FHDK6Ulk45Wg9qFW6ROW3fpVv595nZtpafQeKkw1tWQws9bY7JStoGGREgKVhKKnxHhLtt5iOv/XzhsVInbeRHUaV0bKvncdwxO4BX7w/NwzO6K4UT4JQ7IMby4W3LKu4IArhkHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787543515; c=relaxed/simple;
	bh=3LcRI6Px5lJoiEphUxcDGKm6142S8ofkqGtdwSTs+bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCsLKNYRgJki63hLFgmR4FbUrEyjBcqoeVEW0GxqVq3+Iii+NDcDBa7lHcLOCrjWP+Gmc6o5KcW9ODpe1OWiPMvsK0BEoJGwU88hHW0QM0aB+DCu1nVfWz/Htj6i8/Nn+BPaEeek1J8nvpDNBg90AdOEzNeqxL00VkqvfrfwsdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TJcnW9r1; arc=fail smtp.client-ip=52.103.14.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TJcnW9r1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjsU/d2Aio2hf5oFvA6jSra1TsfF+k6aXhD1bEsTRh44+zOxOTo52MdHpeuqokmyXMWvglXqYxJfGAAKTNqsdrryCtodgoBKXcQ6F2IXEuy+bRDNSM1/puNuXcIGRSF5+KHGWEKm1WCAQMg7mqlVZx5dAVBXcFoDeZXkXuaLPAxb0UeHYQDzbhp7/lnK79BzyRkmo4uFQaPHMn3AdsiYCgQH8zsTLsJQNEwO11lP2q8ij16Wnx33vcZQRLqaobKzo43sSkzxNkVihssyUZ/x+8j0pgvihZl8w4uQ5cB+caL2zSfRN6aaF6egenfqUZgQxZBXs3sr6GZ7K7JubyRAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVtGL9Fn4+E59Xd4+dPBHxOn5v36kMi4ubq8ySb/6tg=;
 b=iicYiQl8XHabPCO6PVPIJMzBkIQyYrJGQa96/Q5zg9EU59C381LfYo2klt04j8jkc3Y/uXH8D9rR6sDQieYvO4L3cdG4A9av5BWFMlDEk8FRF+0e2HfP5kh4+BcA178khkQlwh2JnFI0oRj3twkpciu0ezqNGNPtF54i0ju0t64xVWGZuwmQSD+4QQ2tQEBMdShKF2yBSTLVlVuwx9Q/1XGNys82sspgBCLCqBazjD7JJ/dTapPktS8jezCJSoiRyfAYhSAqcWBgsumlSQyrgulvg16jV14tyOUyu+7+RIsGlwxgJGccEm4EnEbYeMOS2xf8tqPbelrwP72lGIuXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVtGL9Fn4+E59Xd4+dPBHxOn5v36kMi4ubq8ySb/6tg=;
 b=TJcnW9r1kiH0CWWI7OgWncuQJ3lYWtnuopcywIPoHNy0lERs2uVeTSPaxlCFbHnaXapt+sm4bbYLJusrheFmM0Y1lCNxyfTazzDdc4ILOcAKpNcqCg+yhfxVszlfBq5WVvfJ0XBeWRiJhYCleVOTuBebRYXxwCp7r2fwV6ZsRmv8Kj7Z1jMSr7NKLv2TTlzQ2zdsyHmMkcknRXYfhyZoI5UQMO3C3qygnSeUSgRNMPhQv2dgrs280demXG3XR8WTNCtbfopXSBlF9RPhzaHQaqujB3OqULkcHTteAfFZ545vpO1hlQMBiBf0HfhodpOYTUxjqcKiBMTEtX0K8O700A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB11101.namprd02.prod.outlook.com (2603:10b6:208:59f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:51:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 03:51:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] Remove support for Windows Server 2012/2012R2 &
 Win8/Win8.1 versions of Hyper-V
Thread-Topic: [PATCH v2 0/6] Remove support for Windows Server 2012/2012R2 &
 Win8/Win8.1 versions of Hyper-V
Thread-Index: AQGxtEcDjCHSVJ3Ltjt2mT0Vbj0ZWrcDWRaAgAA2I7A=
Date: Mon, 24 Aug 2026 03:51:51 +0000
Message-ID:
 <SN6PR02MB415747152F7DD4469F9F945CD4A02@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260805203751.2678-1-mhklinux@outlook.com>
 <20260824003803.GI3566091@liuwe-devbox-debian-v2.local>
In-Reply-To: <20260824003803.GI3566091@liuwe-devbox-debian-v2.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB11101:EE_
x-ms-office365-filtering-correlation-id: cd80cfe0-4944-43e9-8dc5-08df019307fd
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|8060799015|31061999003|37011999003|13091999003|51005399006|15080799012|12121999013|55001999006|24021099003|25010399006|40105399003|1602099012|10035399007|2607281247196008|102099032|3412199025|440099028|4302099013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xq+QjGd3F47iwbI/2m4XJ8WaZ7NScHQmMJnNc0gfN8B96XScJkRHqgoLbLLT?=
 =?us-ascii?Q?ePSOTRp50z5B7HBp1Gaglj5vomwsjxLqNKrYmsVcmj+Xg8MLL1L5dNkWpQo+?=
 =?us-ascii?Q?niGZusavzo2T4OQE2SEqAMCtUbIytuKXM2isr6P6gh3BJWw1YZYzOuoXREzk?=
 =?us-ascii?Q?6yHMXl4Oc8frk34cGqem0NK/7jh9ewy4lwRialxNptf89rU0d8iMf4cjhDuQ?=
 =?us-ascii?Q?9ma2E6zjxjndP5bGRS89JBq6pHn15+G65Cnf/j/hT5OCXKXGSSYgzkADCcHj?=
 =?us-ascii?Q?e5BvqoYv0E1pl4reFfthXE4z6t29NuCsj8/10zBTR2ysRPpEmwEET3z4Z9oY?=
 =?us-ascii?Q?QxhYLxTcX+mZxMhNBDl/cOF3ejm2yrKu6lQPFy66hgHjDujOSMbLi8aKB9mz?=
 =?us-ascii?Q?8LxkIwRz+52e9W1Qo4IwShcOnV85hthVrkf7I6csBO3Szn6rnXx96T280XLs?=
 =?us-ascii?Q?3/bD+ge1kY9JmRpIVQ19JGm6udX9p4DHMpfnTVLytazXckAUAd/yjn6VrQY+?=
 =?us-ascii?Q?060rLDKLG86MFdCLswJuvqxeC1G1aLwtRMTSKIFrdAfj+GnGj8w5uE/Frjv4?=
 =?us-ascii?Q?YZv9HmAUleVunfyB9Ydlhl8oUtLM7WtJzlWJMZMvonLXlvOQsCe6NwP1QcaP?=
 =?us-ascii?Q?i53WW+Bw2AbdVqqFiyxLGUqKo+kGmZcRrOMArfS1jalG31vvy+htabAhQUue?=
 =?us-ascii?Q?sBcKYMRH1Gq7ahEJxjWtjycdw3jxnaiCY8vSfnfSKUd0oynKYsg78sb7/KMA?=
 =?us-ascii?Q?BmJ53+7OuuhItjNogF+0dTFY1CU3C3mdQGcRpyECcXzJ5WN2YZfmBbo20iTs?=
 =?us-ascii?Q?9qyYpSGkur2DnRLvmYk2OHC7NXke2FndnhX0/o40Poyb7SJQe7xjZP+jscb7?=
 =?us-ascii?Q?WjBIFievVcYGH01Op0wcRFcfNovtocXiCoRV287ZtQyrLkCm6Tk51TNj2lyc?=
 =?us-ascii?Q?Y9cg5TI3q8dO+eJHVrvIJkAruShY3PE0qqyBUF5yUyH0xOfUPXCiTDhRxCJL?=
 =?us-ascii?Q?wbABxGBrICncRugAYAxyQU2d4pqLxwK9n/j4upXix7AUlCrlU6zStNVhkN6M?=
 =?us-ascii?Q?8xC0iYyCVgxWC8Fkk4ZIKnqExOFaPymf9MyqNgTxzDjSSpvw15AMCn29Tv1E?=
 =?us-ascii?Q?XGRNUwm3to6mMjT9ibm/Y9wMz3+wpicgFpLu/OL0qQPT8X/ds70tgJk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jPuPx1GSlu0GjG4N3LDllq8Xqxfa1aodkhTm5FfRi1ac4ejMsS0TPaKWo7fJ?=
 =?us-ascii?Q?D/4I54ZzOQUkL4Zr+IKgIEouBwJKNLXQaGQ246Hgo2DaI47j+zSph0SO3TKw?=
 =?us-ascii?Q?+KeKeCGCFJMSFCuXNnD8jub2KQ1GowPfqOC248DiRksq93RbkpNA9Nfnt3Fo?=
 =?us-ascii?Q?GcjBBUHm0H7KlvjiuSm2H+HqRLe4+cuxWP2oTjNPaUGaywrsqME70VttIRYH?=
 =?us-ascii?Q?6St519TW91Dp6k9NNAYosFaTQ62bl34McWGuSPumAEuikWcosF+Jn5yCX/Mz?=
 =?us-ascii?Q?vRsZQn5+wvhz27eoivYZdNsdni8y7Vh47sv1FO9OjL8ZjDFiiHPtTQwFVyiU?=
 =?us-ascii?Q?Q8m02zq657WknaE57Ip23TQyrFTbc1pgZ7Sxq8P4+H1YNhE0SrgHSqLLZmPD?=
 =?us-ascii?Q?P2W4gsdo5gfe2k7edHDj2J0R0gAweivh266CPArEz6IkHL6+X88CbP8cIbiD?=
 =?us-ascii?Q?QBrlGSAq/8cMKGRvI6zfMlGn2L1kj2fIJUePYt8Lg0aFMNX9gHq78qEsfw7+?=
 =?us-ascii?Q?aWmoOyPXX6nzoKyjBMevyAtW3s0L3MuTU8yVaJo326RuhVxMzLDKFhjN7ZdY?=
 =?us-ascii?Q?PFEdfX4cJR5v7AE+Zd8dwYbfi9H/XoOoBToTyzsP7V0TarkCMLev+hD/aI51?=
 =?us-ascii?Q?dV7mIsLBmQ8MGDeYyy9lKmTSn0de7hg/No/nx8gWEOPVuxCt9tRwxlfWwZBb?=
 =?us-ascii?Q?6hiGJTia4nlI4AKwebl65tq6svHvJNiar7BQupsCMliMEYmJ+4U591Z1cyay?=
 =?us-ascii?Q?FIUP6+supWiCEiW+CoVGYbQblzmGuiGj7dZMJLEsxUEi/4DGWM/PscEkoTG3?=
 =?us-ascii?Q?QC7ktOtrVfAoCEm50mBmySRt06PkAlmnq4CvKYO05mDFXgagqi/cAOUBqOf2?=
 =?us-ascii?Q?rEJothc6pzrVV70TttevFHitlYeiWHTiq73AnRunmdHW/SG17D6CoHfWen5F?=
 =?us-ascii?Q?F36hO+8Hm8qbp6l4bvcMpjDIBwnkiYmmNUpbyW2Z4Q5Ktkzfub7Fjn0Ou6tC?=
 =?us-ascii?Q?YMMln81csRDNd72kfDwaglnbEV9gjPH69u5YAksDTbUthj2ZO6/57JZ1aFgQ?=
 =?us-ascii?Q?YhzIinjklYPD2SkYai/tI8KeJdCEAAlvGulGsJInT7ZCmed0ABUPX/n2dT+G?=
 =?us-ascii?Q?ORcApq+9gPluflmDQeD14eyZMHSitDOy8SWtI3b+g3/kR4v/dyMjevmcG5ou?=
 =?us-ascii?Q?fdxhyNfSwhc2YhG2dcF6pkr4ySf+aHVjG+1QiszSUj15/yOdRBhaSgZxfKms?=
 =?us-ascii?Q?jpgAu2Dln7pxlFE07hbIoekJE2M26xKMYv6phZV3lq4LHZiPPd8stRtYDUwb?=
 =?us-ascii?Q?PqaOdUQi1s9IIGg3HgBNB4WACUzAz5W5cvweJV9ynZ79RNwwhj1ormIBe1FA?=
 =?us-ascii?Q?JlfJsUo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd80cfe0-4944-43e9-8dc5-08df019307fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 03:51:51.5320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB11101

From: Wei Liu <wei.liu@kernel.org> Sent: Sunday, August 23, 2026 5:38 PM
>=20
> On Wed, Aug 05, 2026 at 01:37:45PM -0700, Michael Kelley wrote:
> > Michael Kelley (6):
> >   Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of
> >     Hyper-V
> >   hv_sock: Remove check for old Hyper-V hosts
> >   hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
> >   drm_hyperv: Remove support for synth video protocol of old Hyper-V
> >     hosts
>=20
> This drm_hyperv doesn't apply cleanly. I have applied the rest.
>

Thanks!

The hyperv-next tree doesn't have commit 1502b42819c2 [1] that
is already in Linus' tree for the upcoming 7.3-rc1. That commit came
thru the drm tree, which is probably why the hyperv tree doesn't
have it.

What's the best way to proceed? Rebase the hyperv tree on
7.3-rc1 when it comes out a week from now, and then try
applying my patch again? Or is there another approach? Redoing
my patch without commit 1502b42819c2 is just going to create
merge conflicts later on.

Michael

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/hyperv/hyperv_drm_proto.c?id=3D1502b42819c2eee9658009ff0=
b7c9249078d7366

>=20
> >   scsi: storvsc: Remove support for storvsc protocol of old Hyper-V
> >     hosts
> >   clocksource: hyper-v: Remove support for stimer interrupts in message
> >     mode
> >
> >  arch/x86/hyperv/hv_init.c                 |  17 +--
> >  arch/x86/kernel/cpu/mshyperv.c            |   4 +-
> >  drivers/clocksource/hyperv_timer.c        | 150 +++-------------------
> >  drivers/gpu/drm/hyperv/hyperv_drm.h       |   1 -
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c |  44 ++-----
> >  drivers/hv/channel_mgmt.c                 |   8 +-
> >  drivers/hv/connection.c                   |  11 +-
> >  drivers/hv/hv.c                           |   4 -
> >  drivers/hv/hv_balloon.c                   |  36 +++---
> >  drivers/hv/hv_snapshot.c                  |   5 -
> >  drivers/hv/vmbus_drv.c                    |  10 +-
> >  drivers/net/hyperv/netvsc.c               |  20 +--
> >  drivers/scsi/storvsc_drv.c                |  53 ++------
> >  include/clocksource/hyperv_timer.h        |   6 -
> >  include/linux/hyperv.h                    |   5 +-
> >  net/vmw_vsock/hyperv_transport.c          |   3 -
> >  16 files changed, 82 insertions(+), 295 deletions(-)
> >
> > --
> > 2.25.1
> >

