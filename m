Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013093.outbound.protection.outlook.com [52.103.20.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434643F4D5
	for <linux-hyperv@vger.kernel.org>; Thu, 16 Jul 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223465; cv=fail; b=Z5+mcdJehsBsaUxTQziDBcjcleQN3ZFbb0lQhVXlwkXt/WkPmmXVQzr8XkoDQUvGqU80HnpgEqJbrhCbtwHUmvE9Cq2MSdYxwZOpCqCSKz3wDJzUO8BBVHUMPZlTMmGRXHV+8GTYsVKpiCxAVfoBl9AEx3aH8UtmN2ApSq5sGbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223465; c=relaxed/simple;
	bh=w43gh9/q1Od2N+WLjlqOCn7ZAtOtD5qIZ8ScvQFTOzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFDoVxb/aHsWsxeEzGRAK2nzUtjJGESVOYlYYUpsHz4U/2zMgdOF8o9rGfaZ3gzH55IR78kQMLadISK2Od+wofv5yW8I83b7lCsex9xTrUbb6doNI5i0iHekkJQPwcOG1TxBOz9Sp5zWz8BUy4kDJrX/qnRGi58oKVsSjISJxfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c8XOfDsF; arc=fail smtp.client-ip=52.103.20.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c8XOfDsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdP/bQVD8Aw0Aewq0ZAP0DJVsAJg2Zp/53XGtpm+MTK48d1EIQs1lEgFd4UVjdoFOP4kC6mZq1R2HGKAW1pQqtI9TQwgSLVRJ2eNNMPAUlxU/ZL3kjR2vAQkg2OhnMiQoBoG8MwlThjpQcRSFg95KiTGxHLmJu81+CCujz8TR1AaJXqQ13/A6IWFXBEzbnG+WwiCNaemdWznFh3pH26OP0EDxgynMVNtWJAAUu8qZhShj8IQ03d0Ux4iubTRhYa9CsoYPqZgw4fOkSdhyT/bQU9XqlbaoiS3vHH+Q6HIXeC1Crld/ACyK3pB9Hdhay61FF/enOtDC5nX2LQo29RsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCuyDMXBj6TIjAh90NAswz5noPsnEaNgj6GJwexmhM8=;
 b=KbRi09137HoIWKQFDqb3jqfhLgNQDIoNmBlR5QT+L2hnLhc1BKfvp5XhDZTRBosLTyi3qdboQLZJ74i+mfvd2R0gFi1JhEsOBZQ52RhG2dCLON3j6LaOihyD/rv8DayxKcfVxgq3n5lW2GiP3kjfMVc2GUKCcFvLzIUQdeYd/aPhdbnpaADbU4jWQLPpAEnQSkzbSisis1YWjEH10qd+T9L0UtnLCzMluzWq3zUri1n5+o2X9kFlpzSCMkj8XyM/T8eXwBxDZ7Il6A0dQeHFTj26Pcm+xgYGDO7QH7+NaMz5NHydbaO8Y99gaAfDnjwzsb0S/neClZNI5drLshqLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCuyDMXBj6TIjAh90NAswz5noPsnEaNgj6GJwexmhM8=;
 b=c8XOfDsFyPtQiikzeHkcW0/Lve1ooSiYs/V0JKiTdyyy/za6ojLLv7j2uz8+pAM26q/euvvo2XO1F4EhuIS1VESaH3zbfInAXlU4+QZx0mTiLxqFMqps0YzdvFGy5IdUJfMovTMTHU26NUcraJtbaErNVhiJzKE9hBpRbKrploUJMVPI0GDk9qtKiK5+u+GmC0Ai+0jTcmq9r7vnncMnLCxLaK03EzgKAxSK/ZmxsYE1ufjVBnAwxv5iqoJhfBiiyy9hbubE6Y42K5BHfu9MgMLk0SnEJhAempRkHig0FGyapGMlKSm/8YVGtMPyCmhMUg0vP9QXlUHdyzz251htVg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10055.namprd02.prod.outlook.com (2603:10b6:408:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 17:37:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 17:37:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Jan Kiszka <jan.kiszka@siemens.com>, Long Li
	<longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: RE: [PATCH 1/2] hv: vmbus: Replace lockdep_hardirq_threaded()
 with lockdep annotation
Thread-Topic: RE: [PATCH 1/2] hv: vmbus: Replace lockdep_hardirq_threaded()
 with lockdep annotation
Thread-Index: AQHcwepdrKBOXzId6USmM56dY1Icq7XN/EkggKFNhACAAcAfkA==
Date: Thu, 16 Jul 2026 17:37:34 +0000
Message-ID:
 <SN6PR02MB415782B5C4F6E954EFF4E58FD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260401151517.1743555-1-bigeasy@linutronix.de>
 <20260401151517.1743555-2-bigeasy@linutronix.de>
 <SN6PR02MB4157524E39FC4ABD058A4A52D45FA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260715143252.gWEZfb5B@linutronix.de>
In-Reply-To: <20260715143252.gWEZfb5B@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10055:EE_
x-ms-office365-filtering-correlation-id: b43dc7a5-4132-4764-f83e-08dee360eb9d
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|15080799012|37011999003|51005399006|13091999003|8062599012|31061999003|24021099003|19110799012|8060799015|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DX2L7Y3cr4007qNYWqGSuQsL1G+EiHk+kGV40H3vVvgJdHMra9EwEtC5Ticf?=
 =?us-ascii?Q?YsrWaGvJB3rIWqCDRhiXh1qMDtxQNOXrO5u3ViUai0mXhmpjhvGhdGFjmZk3?=
 =?us-ascii?Q?KgKLZHByWH3fpaEsEgSMvWGIYoeMCn7R8SLNhbp3vbZinvPZp7wtXaHFM5Z3?=
 =?us-ascii?Q?PB7xGV1YmkHo/cHS+R+NTJGbbbFyktVfhvXhH3TEA829x6vBCf48FptYkZk+?=
 =?us-ascii?Q?liRm1g7fvHqbB+pe2GVd5BNSsLhOeRXcN20k3QMmfZgjnDsJrqXXB9iEO0Lh?=
 =?us-ascii?Q?DF17XHm6DkDpOsK3mqTqo9v+BhqM+u/aN9MzNbjXVglvtyzIUpTfliGzv7fh?=
 =?us-ascii?Q?lJo0v9tFxPOrDep+HqD5tXU75P1Oxw4bh38zK04NRX+jdS1ALYZ9PujLQRnn?=
 =?us-ascii?Q?1SFZcmylfZ9E/QoK1bf0TmunXmUHeiTSuASadNr9oTa+oQaypDRWs2aHPxFH?=
 =?us-ascii?Q?wj16Bzbf9CTfgD2U2tvi8+x7prvwaEvAdG08vuFCoe9DZyDuERRU+zDxXkTl?=
 =?us-ascii?Q?1laCbWw2i06h2LWpEBEJnuog3+d4BqB9Pau8UuiBPJ0Z683zp6XXGMLOmqqb?=
 =?us-ascii?Q?QVQJueWot4NdDXp+NqyqskCAwgj3tC3Erm1ah754U7jJmI9fUfyLWaFqP8eg?=
 =?us-ascii?Q?xAOKrnGOxm+N5FcGCdLURT7AfobsRu+v83RAC3QvqY18SWrue98wAh8roaLq?=
 =?us-ascii?Q?T9Ds4rwtQVhYQxvk8dgW+6hlCjmeuYCo73W/YNJ4brNvBIo9WoBN7RustA86?=
 =?us-ascii?Q?u8c6uSdYyf3Qb30CHA/vt1jtBczqbi2TOPSVkZHCBJA5TkVJaKH6DLOWQwQA?=
 =?us-ascii?Q?4eBBYUDpzqJDgc310rVk8+3hGiWq9c4uuWB+wLf5tF4SikwGWlTDRRapJ4n1?=
 =?us-ascii?Q?0SbTc82ULGdHs4KLFpMHBwiKsOqwWL+X6GCTxHoww04JXnPgeWbK21XhlHK7?=
 =?us-ascii?Q?j/oAF7SgYsrz33QSptJE4mKG4NiVQrM7cWXMPjmqrM6GfSze+Oqq11Rk7Gxy?=
 =?us-ascii?Q?/8GQ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?StGg20maVwOywlgdulWKPMXuXrYhjP5VnK/GXZ9swjpXJ74sFUV3XbAQHN0B?=
 =?us-ascii?Q?jVcn/DhFrNEzY7m1/gbLLNw8J+b6/3L8b6Gn+H3mqJb3/oVQG7a/hm8xvkV8?=
 =?us-ascii?Q?BK2dIVlbVIHrI9Ms8tCVROfUdIoj84cnqfQM6RWcz6Th9gMb0U9RGTthAbX7?=
 =?us-ascii?Q?BRtuXh27hC81bUUJqzsoO5u8pSPXtkWbIpoEVm1iKwJ5JQRf+gQ0rwLsdPco?=
 =?us-ascii?Q?GmIoErKpB2Rw8/l4HV5JnuMdMHFOy4jlPoSPmY/MEnI4/8+z1N73f/eAEMMO?=
 =?us-ascii?Q?M1c3wREcBIA7FMnHtOele8kbM7yhZ9KMfyNGVDTDLPSS8psl8yxHT0NMW+JR?=
 =?us-ascii?Q?6JgxSaWvQu7Zo91TEUC1oLqBlGReAUTbqhzqdhOl04jfUH3OisNRncJ739Wr?=
 =?us-ascii?Q?z97W7LhqZtRpaQ5G83z9+v744+/N868PeeBiQE3a6vvxDwU/C9GNwOTd9P1P?=
 =?us-ascii?Q?P/R6qy8z1OhDZgGRugwo0rXKR+9so26M4fXmh5qV/3wD8KuGnfr+cO59zcxE?=
 =?us-ascii?Q?uhnKdP/Gry7o2X8lDWG+Jk0unLuRFahy1VdiA82x2acXMGlTOXQbniuDhgSs?=
 =?us-ascii?Q?MKpjYK8Im8x84DRsfQwy8/xw4c9Q4YcAXgWCxufF12HyGPavmepJvUUWZ9pD?=
 =?us-ascii?Q?HO8N/Ls667pCieoEVtX1fqwD5o1QW1K8G8KcD2vAbZdnLuHfuxVxZxND7rmX?=
 =?us-ascii?Q?CChQDxAiFkv3y8Ve2xPglVITDKPTdv3jguDCnUB4/m7EONbJz5wxIxSEwqyg?=
 =?us-ascii?Q?JqvLR0vDMFwdwG5VmODOYnxqXIM4Hv1gXkcXrmr+yM7mMu+eRumK2ACQx6YZ?=
 =?us-ascii?Q?4zVlYgNvdzx3Ft7OUjdeiMIeHgqaXVatU+aMNbOhkp59abJ3fKLzD+c44TIi?=
 =?us-ascii?Q?5NnTzkDJw1v7uJahFNUWG1RR2ksTxXjz5eJrhdkZtum+yOg54eTXQX4eSrkc?=
 =?us-ascii?Q?xSOIBYh8mcJ4U5GhxLde2MYRCYHI6R7p5uCah/tHKfSO7RgK7GhgAXw3braY?=
 =?us-ascii?Q?r0YXrAlcMTvFgEsR5iliH/6dSRMSBLIZRw5Vbrn9Z+x0jb4i08O4EZ5Rz8HL?=
 =?us-ascii?Q?FVC5n0Z/e9f/ZNqAUc8BFd/VerZlF4jpvvCQwvuilmqgOy3XMlXfQk5DIvyV?=
 =?us-ascii?Q?8UjYJVOjTT2pXK1ytAmOKb51di5j1nH/Ei8OlbIFJgjuKMQpwlYxQKV8AfUH?=
 =?us-ascii?Q?Kq7r7Z5SAuiD8lU4V16Hv1MaBm+7vEOKbiCqbXYwiw/piC4DHYNPhTVBlysY?=
 =?us-ascii?Q?G4wWnL/yEKkrzofY/KYkG5++EsiDB4sbViJrOaiclcFj16iZGrDAxeSIPA9a?=
 =?us-ascii?Q?WXtDLHnby5QSOn4OwIFf5b7VKFhNtcF1k6awOv/PYsn7Tm6rU+lw3b6QCFju?=
 =?us-ascii?Q?96Rxl3A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b43dc7a5-4132-4764-f83e-08dee360eb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 17:37:34.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10055

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> Sent: Wednesday, Ju=
ly 15, 2026 7:33 AM
>=20
> On 2026-04-04 01:22:08 [+0000], Michael Kelley wrote:
> > Nit: For historical consistency, use "Drivers: hv: vmbus:" as the prefi=
x for the
> > patch "Subject:" line.  Same in Patch 2 of this series.
>=20
> okay.
>=20
> > Also, any reason not to have copied linux-kernel@vger.kernel.org? I kno=
w this
> > is pretty much just a Hyper-V thing, but I would have liked to see what=
 the
> > Sashiko AI did with these two patches. :-)
>=20
> Can do.
>=20
> > > lockdep_hardirq_threaded() is supposed to be used within IRQ core cod=
e
> > > and not within drivers. It is not obvious from within the driver, tha=
t
> > > this is the only interrupt service routing and that it is not shared
> > > handler.
> >
> > I presume you meant "routine". And what do you mean by "the only interr=
upt
> > service routine"? And why is the lack of obviousness relevant here? I d=
on't have
> > deep expertise in lockdep, but evidently there's some conclusion to rea=
ch and it
> > would have helped me to have it spelled out.
>=20
> You use lockdep_hardirq_threaded() which marks the hardirq as a thread
> for lockdep purposes. The reason is that the IRQ core will force-thread
> the handler and the whole routine will be threaded. It does invoke the
> function and the very begin and nothing else will be done.
>=20
> vmbus_isr() is using it before __vmbus_isr() is invoked and there can be
> other functions/ ISRs that are invoked afterwards which would be wrongly
> recognized.
> To make it more concrete: sysvec_hyperv_callback() invokes mshv_handler
> and vmbus_handler. Would vmbus_handler() be invoked first then it will
> "spill" this lockdep attribute into mshv_handler(). Nested locks in
> mshv_handler() would not be visible then.
> This override limits it only to __vmbus_isr() while the RT case above is
> using vmbus_irqd_wake().
>=20
> > >
> > > Replace lockdep_hardirq_threaded() with a lockdep annotation limiting
> > > threaded context on PREEMPT_RT to __vmbus_isr().
> >
> > Again, I'm not clear what "limiting threaded context" means. But see my
> > additional comment further down.
>=20
> Does the explanation above make it clear?

Yes, this makes sense. Thanks for the help.

>=20
> > >
> > > Fixes: f8e6343b7a89c ("Drivers: hv: vmbus: Use kthread for vmbus inte=
rrupts on PREEMPT_RT")
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > >  drivers/hv/vmbus_drv.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index bc4fc1951ae1c..e44275370ac2a 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -1407,8 +1407,11 @@ void vmbus_isr(void)
> > >  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > >  		vmbus_irqd_wake();
> > >  	} else {
> > > -		lockdep_hardirq_threaded();
> >
> > I see two similar occurrences of LD_WAIT_CONFIG in the kernel:
> > __kfree_rcu_sheaf() and adjacent to printk_legacy_allow_spinlock_enter(=
).
> > Both occurrences have a multi-line comment explaining the "why". I'd li=
ke
> > to see a similar comment here so that drive-by readers of the code have
> > some idea of what's going on. My suggestion is something like this:
> >
> >    vmbus_isr() always runs at hard IRQ level -- the interrupt is not th=
readed. It
> >    calls __vmbus_isr() here, which may obtain the spinlock_t sched_lock=
 for
> >    a VMBus channel in vmbus_chan_sched(). If CONFIG_PROVE_LOCKING=3Dy,
> >    lockdep complains because obtaining spinlock_t's is not permitted at=
 hard
> >    IRQ level in PREEMPT_RT configurations. However, the PREEMPT_RT path
> >    is handled separately above, so there's actually not a problem. Tell
> >    lockdep that acquiring the spinlock_t is valid by temporarily raisin=
g
> >    the wait-type to LD_WAIT_CONFIG using the "fake" lock vmbus_map.
> >    If lockdep is not enabled, the acquire & release of the fake lock ar=
e no-ops,
> >    so performance is not impacted.
> >
> > Please review my suggested text and revise as appropriate, as I'm far
> > from an expert on any of this. The above is based on what I've learned
> > just now from a bit of research.
>=20
> What about?
>   vmbus_isr is never force-threaded and always invoked at hard IRQ level.
>   __vmbus_isr() below can acquire a spinlock_t which becomes a sleeping
>   lock and must not be acquired in this context. Therefore on PREEMPT_RT
>   this will be threaded via vmbus_irqd_wake(). On non-PREEMPT the
>   annotation lets lockdep know that acquiring a spinlock_t is not an
>   issue.

Yes, I'm good with this.

>=20
> > And thanks for jumping in and making all this better ....
>=20
> so I've been looking at __vmbus_isr() and vmbus_chan_sched() seems fine.
> vmbus_message_sched() on the handler invokes hv_stimer0_isr() which
> should not be done in the thread but in the hardirq. Is this the only
> timer in the system or some legacy thingy that is no longer used?

The stimer0 is not legacy, but having the stimer0 interrupt delivered as
a VMBus message *is* legacy. The legacy mechanism is used when running
on really old versions of Hyper-V. Modern versions of Hyper-V deliver stime=
r0
interrupts via a separate stimer0-specific hardirq. This linkage between st=
imer0
and VMBus creates separation problems in that it should conceptually be
possible to run on Hyper-V with stimer0 without using VMBus or vmbus_isr().

I will do some research on the history and supported versions of Hyper-V.
It might be possible to drop Linux support for running on these old version=
s
of Hyper-V, and remove this legacy mechanism for delivering stimer0
interrupts. That would be a nice cleanup of some historical baggage.

>=20
> And there is a lot of tasklet involved which mandates a
> local_bh_disable()/enable() in run_vmbus_irqd() around the function or
> everything gets pushed into ksoftirqd.

OK.

Michael
