Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795383019;
	b=rqJMPB4+6Sj0lAEUroA2rQPaKLxuVmYdzVLiklR9DcbppScbZzAsaPcQyAuyfgCDzBdn
	 M+HHOemN0qSGUD1wl9qprZNZ6jFEI8izeQZ0aafwbA703e1IMSa0Vd+vAhSGhkcUYHMqj
	 YO0zZfTloxlPM/s93+gJBTEr7710k7v9GYVG4r9z1uw0jdA19LDxqvn+v4lAshPZpzAw3
	 LpKePJRjc5HiUeSUrhdBrB3RQun7kJHo5op3LH/q7fNtYyL0L96v3sb0JJTOCa2la46ab
	 0v+yMqDY4pLGJL2mhOYCwT0oOjCyd6oO5kZ0LOiHKIkGg1mVS64ONr+ZGgXYCCDR7LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383019;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=aa2iVhqn0OHezWmfk7g613/N7MjtEWM0wDkg5g8d7G4=;
	b=DE1M4tUYYBzgcN6kYOSGLHoDsx9jGec0x7B5pJHtP5VKi40yj3VpTW0HRkHmgkpcQXOe
	 4H5VQ8ZdM6Q4w+mZoDqG7UOMB/MAiaG7HqkgzL9134lpfxU4ic4mKDFmGWXgn8LMZD9RB
	 0yIB6WenCN48PnfMRcbzJsRxhDjwhLifiMuZhvZ17POTczw3YOQo7briuNyUOn9C0meuS
	 u8HFoY2ymgsJzPcvjOuo1ZbQ7l6U68457QRB9KbxKvC9OPLL4cSt+blgEqNYaOA2EoP1r
	 p5IhR/F/SgzAvJCnxM7d6ANiYiko/etLU3p2YRXKSbi4sGsr8xnqkBG3hNFqNS2XqSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Ayb8QvPX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.85
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012085.outbound.protection.outlook.com [52.103.20.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57257606A31D;
	Sun, 22 Nov 2026 21:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57257606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Ayb8QvPX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URPZbTgZqWmv32Y7TDCVRtNMeZ7Mxo1YJtGdsMYnU2CksWjW7Ngs0a+1sTUZgr1Suq8WDKq+s9oPVk0YUC9tjlihtcFQAXx4ie8057zaz/CLeUdFCGtt/bsD0s3a9M3xbLhaVRChQEY61dWQsO64OQ0CeaBK2dQ2U1wT6F8r5TREyp19bopKz6n52L3AIsl8R0ZlGB+uQy8ZjD1rNGwtvA+6T5e8DAWlpLeBFzne0AzN6kY8poLx4X064NTvVFoKMHeSrCmRwpWFBk2qcWB4T5NAinjGwonOObcfYYnJoSk7e/zJ2zNW7PAczcPHWl6hHkyGsQRuNM2MDC94ji3KbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa2iVhqn0OHezWmfk7g613/N7MjtEWM0wDkg5g8d7G4=;
 b=eZstxbm5TQTceXyq61hg1sSEGkLsJWOZLL04ciZECbAMxb+hT4uM8R9ORog+b1ipM3vDvO+u91Q1Z6gOUq6eqhskqSzDRS6aQaP48i+xetNPZCyjkcUzrJgVrJ5aic5XjCefm2F07PvdOBs/KbnCs9hy6YNDtS8pdHSvsG+VuVEpL8Dc5DaG69T61RMDYlv5ggBUgGpVggT6gu0OKgx8p/q3uOFx6z5wqzys4VIrHwt3slz28y9idcm0a9D7FDG9BKYIIUUbuPRAHq0XdqLfb/c5C6DdzsvFr7bB5zrW7xzL2wTK3+RpeunU0J/PrPqfV9nRhjkAAsYvj14bZuAyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa2iVhqn0OHezWmfk7g613/N7MjtEWM0wDkg5g8d7G4=;
 b=Ayb8QvPXk6cm5EsuW0ZCxy1CnfWduKIj71oOXwA9Wrbu9rARNE+2gcdj9j95gyJ8Bura3nf6R8XdxKmiqQysffujSNQowMIgUWmk++jZTg6gLxZT0R4Azn6YnFZx5ppeEAOetGXzqwOHE7R6hQio4RB2HVw/ASx020HPOOLTR/DPInQ9xWnF0Z68VUCSeCw70J0BXoUVp3CbDGD23IM9UOV5/FOpiBdUT4RRLCtDJM1VfFxzYCS+ahhOJqKdDm+THNyEBRlnKggz790z5wSpK7AfaZNbD3ATSXTHodnD32tTeeoEnz86si12LTae+AgK5//ZtiiBoyIOpgpByih/hg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB8813.namprd02.prod.outlook.com (2603:10b6:a03:3d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 21:26:46 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 21:26:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
CC: Daniel Lezcano <daniel.lezcano@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Marco
 Crivellari <marco.crivellari@suse.com>, Peter Zijlstra
	<peterz@infradead.org>, Phil Auld <pauld@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Waiman Long <longman@redhat.com>, Wei Liu
	<wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: RE: [PATCH 39/47] clocksource: hyper-v: Move
 CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
Thread-Topic: [PATCH 39/47] clocksource: hyper-v: Move
 CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
Thread-Index: AQIdf9UHAmip996qXxPi71vThFyn6AHjQZaGtqtebcA=
Date: Sun, 22 Nov 2026 21:26:45 +0000
Message-ID:
 <MN2PR02MB6863BD8055B08CA905B85980D4462@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-40-frederic@kernel.org>
In-Reply-To: <20261105163045.38862-40-frederic@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB8813:EE_
x-ms-office365-filtering-correlation-id: 14f8c0bd-446b-4f92-071d-08df48df4f8f
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|13091999003|25010399006|51005399006|15080799012|8062599012|8060799015|19110799012|37011999003|31061999003|40105399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5CW8X5gM949i4I2K9hT2BHYAnHgMNpjtDXuRi8snVWO3w8B8Z9k4ILY4DDnD?=
 =?us-ascii?Q?fwXq4by32TZLOxE85ftclB+9O/OHeMg92XfvmMY7SnrrXf74IjfSL0G1h0BT?=
 =?us-ascii?Q?pbmyD9n8y0sEyOQzmhNwQa65rpjETXdHENQWm9Z1NGooAFvGGBW3f0dcUJ7t?=
 =?us-ascii?Q?lCCOgPRkN2BWFR2eAxrv7Q16vxXin1jE2PnO1AzLBrc1/XMO4Lirhx1dQWDc?=
 =?us-ascii?Q?P0L6SanS2ZekGz3j6SBRhyMs67N28KY2icG0QouPLS24coyJnwaw+Bk5d4+i?=
 =?us-ascii?Q?dtdKQ5eivx9syaQGlH/UHZDN5Qqf/RgoV4CMkRa+HsB26LKGq8gpNX2WW0Ek?=
 =?us-ascii?Q?GGNsIlwYphAmQ9VTvV0A3ef/pXYurPn8L1CguFKcn1GrDjZWhQjNh48dXxy7?=
 =?us-ascii?Q?z1c7gvj6r8gGrwPDbL1JEdod/86j5OovGS3+ASKFB8oYmgyxPeVYttTV711P?=
 =?us-ascii?Q?kyCXH9LgbYXkav1Wp+UC5O2tmnm3C5cyFfY32OApofE5FOjuFaOaA5C0dNQM?=
 =?us-ascii?Q?paEMCYgJJ+ew5UHux5ZVCpNJxLrPIojbYY/7m6u5A/GcDc+gK7J2U+2DIYq7?=
 =?us-ascii?Q?FirQkJ0yUFX05dtUO42V5Dok6wbAx5STf3KSRpDn7LwFRByti1dIq/iekdvM?=
 =?us-ascii?Q?1PO7dpGD2Yt9uvUZquYk0mMW6BRqDhTgZwuK0bZ4JNArd0xat5lWwtf1oifH?=
 =?us-ascii?Q?AaFzxn74h4ucjK2bOxAHRXTftk5TNWwxsbTzyP3Sd17H/02pWgLPJyrmZ1rQ?=
 =?us-ascii?Q?BNAov7wEggRlw3lISFfhFRMcn6rLZyN7TeKGNgIUz7eVv8tY9OHD+Og5QwPy?=
 =?us-ascii?Q?kMaWrmKXDFL/MPdlX8tY73/6+B6tuDVwwEaFqgspkLU3134V0/CIyjSR6Vlw?=
 =?us-ascii?Q?OvXD/AwbvDpbGxmJ80fDAtPhDctyZ2QeRUpYEsyh3qMs5ygT0haEtsK0OYem?=
 =?us-ascii?Q?nZ1Gul9PYU/i3aN1xgbbbk4lDMkD6RilcyvAbKraJqfpbcBibwAJf0izJYbu?=
 =?us-ascii?Q?9FP+sQn4XfFfozLw8pGD8GDuc8ocd3icfJ43hL8eOCG8AUo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?65TRTaCWk21nwUnturHNHv1x1tdZ0PAiFRFZDCkDSmMwamt0KFOLD9uYd8nm?=
 =?us-ascii?Q?BzvBxBLt+rmQaW+8b76TWk7326iAI1F+ywQQeItjTCJ53ibnCb82w0UzMIL+?=
 =?us-ascii?Q?ie/4L0xnshY5s+MbvV70aap23TmwwVyICXcQ+72DGng1TN0dUc/npK87px8J?=
 =?us-ascii?Q?iYVzVrMKryojhM9WgtDhewSomi3vr82oef8aLBl6Y1qLxxJ1w/BbdEfJK55g?=
 =?us-ascii?Q?igjq7kUWKryYR+gG5Dv4sB3+YiBV0uPHWJ6b0N0DGNvx93kjjDt+afcxFT0n?=
 =?us-ascii?Q?S4qG95dHuS3PNHDwdUWcMTiGW1Up6LHR8zXNaRbVa5CbnhRbfFDYSJ9jplcp?=
 =?us-ascii?Q?0od52Kh5NlnSo0SKSdugKbkqAKQodCottzkjPxGGdkfe3BnwCWCN99I3LU9u?=
 =?us-ascii?Q?FBl0othEfuwrh7i7JQGLwacBNJ7hVKqkIMHqis0clsU1OpziKued99RVLFIp?=
 =?us-ascii?Q?D4QxMQATRWL9g3Oemk0vab2vZg/fxqJP2MFXCOdVgAm4EvViZWyeInknIlcw?=
 =?us-ascii?Q?+B8FAxXiEbXmvFuwSS/IDv3s7TCcWqrTCRiMmrPcOg9iHR2od5OAWLfnDfXI?=
 =?us-ascii?Q?DMWIw6WJ1Is/qBM04oYpMe7nydaEqc/fGOPcJK5Rqqd583NulRm+54LeQq14?=
 =?us-ascii?Q?NkbcjvGkuAM+0JbrUf5ruz2UbxRaHkY+I0D2jYhl+C+qrw+hHGmyuBTeZWlN?=
 =?us-ascii?Q?aKvEAtbNKquXLvuvlS3vtA+00XPBSnvMftPBQbo5ApNXRfCI/LJWwkuJUMlx?=
 =?us-ascii?Q?FEwZV65sqaWUOhN9TKOjZ0pQxXtHQ8X/buA6uvktIWuuUASodQ3pbfdG2nwE?=
 =?us-ascii?Q?X8HXT7G5IyEeF31UXWv+JptUMjbSj4yItLsF/OXX6ZiPnMY6Lwejm6vIDyfN?=
 =?us-ascii?Q?L72fpCXe8pTUDcMl0f8q8H5g/2qIYl0SAkkBZbVBj26X+YpIAyTNufQ9fW7s?=
 =?us-ascii?Q?kjJiRnpN1ms2ObqnfbxCHtdlPzEaitFtiEt22mixDOKC9r/Layub9pAlwJZD?=
 =?us-ascii?Q?899qwMFbDwc/LxgzssSwiJWHOjMd1EV1iuYwyY64dt4PAZrv3ZMeN2i24t1b?=
 =?us-ascii?Q?d5u8k92Xf/lB/qRzcGph7WUxSDPPTQq4QbZP9G2mutClHk3aIiw8r+bTK9KZ?=
 =?us-ascii?Q?1Qn1211xAGMSQu7mXIaACBLoyBDFj7BgEH0qMeNq1SMM1U+NYADz1Q93BS8L?=
 =?us-ascii?Q?HjKDxLA+RZkGMCfhsCF+O1EyVU6LctbnhyA0ai/ZcHwWtqr25TrRFvJJ8u/S?=
 =?us-ascii?Q?HCjRZD5w6V39I/ldkenysEJ9GjeEQ9kV8mSyU5edhMPzLbWn2S0TpLZF97h0?=
 =?us-ascii?Q?Q0CTydyuepfRZUtErHGsNBUWqR882SI/8D7WsWzL2W57PLlSDSIW2Drm9RfN?=
 =?us-ascii?Q?yYx9wDI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f8c0bd-446b-4f92-071d-08df48df4f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2026 21:26:45.9097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8813

From: Frederic Weisbecker <frederic@kernel.org> Sent: Thursday, November 5,=
 2026 8:31 AM
>=20
> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.

s/mix-up/mix/

"mix-up" usually denotes some kind of confusion or miscommunication,
and I don't think that's what you mean here.

The first sentence here talks about "stopping" all CPUs in the system.
It took me some investigation to realize that you meant "stopping"
in the sense that stop_machine() temporarily pauses all the CPUs,
and not permanently "stopping" the CPUs during a shutdown, as
x86 native_machine_shutdown() does when it calls stop_other_cpus().=20
Unfortunately, the word "stop" is overloaded and is used for both
cases. Maybe something like this would help clarify:

"... while temporarily stopping/pausing all CPUs in the system."

Michael

>=20
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
>=20
> The teardown callback here simply performs timer and IRQ disablement,
> both of which can run concurrently with other CPUs.
>=20
> Move it to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 93b8498e26c4..b49b67ef5ecb 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
>  static int take_cpu_down(void *_param)
>  {
>  	struct cpuhp_cpu_state *st =3D this_cpu_ptr(&cpuhp_state);
> -	enum cpuhp_state target =3D max((int)st->target, CPUHP_AP_TI_GP_TIMER_S=
TARTING);
> +	enum cpuhp_state target =3D max((int)st->target, CPUHP_AP_HYPERV_TIMER_=
STARTING);
>  	int err, cpu =3D smp_processor_id();
>=20
>  	/* Ensure this CPU doesn't handle any more interrupts. */
> @@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
>  	enum cpuhp_state target =3D max((int)st->target, CPUHP_AP_OFFLINE);
>  	int cpu =3D smp_processor_id();
>=20
> -	WARN_ON(st->state !=3D CPUHP_AP_TI_GP_TIMER_STARTING);
> +	WARN_ON(st->state !=3D CPUHP_AP_HYPERV_TIMER_STARTING);
>  	/*
>  	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
>  	 */
> --
> 2.53.0
>=20

