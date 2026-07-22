Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013045.outbound.protection.outlook.com [52.103.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2D4266B8;
	Wed, 22 Jul 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751514; cv=fail; b=AXhT6zTCvnEn9ZjOi86P3oXGA1qu4FWJIQIKEhfzK8NoVUafm6YpupZigd5fTm+Ruw53BMHRBxRllhZjvbWdHnx5RerHzJKZZd8+OtiHdqBxgZSmQLI4/joOSPZO4XdmZ7+bUatt9SxR+frzdv98hZaRiZH4d1VNGTwOQgd/ZWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751514; c=relaxed/simple;
	bh=0KoHHwVuDTUZdPNBDM/6EDTmMTxi/GRkAF1h+izs82A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r/3Me40LE2GoksSuvALXyN+QcDwX2QPotfTLHUVZ0RHkqTuCXquqjGjw29ivEGQOjh5ia0TiWZsbN8HwVwtG1YQeD+9sz9UCV2OEZmobik7spizCPUr4hsgqryZ6g8pEnWNn2T1OvCukw211Mk8+YoDu2ZgoR5UXovSH2oCwsUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eLH6eqR7; arc=fail smtp.client-ip=52.103.14.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eLH6eqR7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEnxJ+in0C6aODIs2pWF+Acal8Mju0wcJlRSE9w4JOJuYZTrUTRelGMifS1SD98Y2zFYNbtY6/S7gYIw560hISPDGPePSzXziA//+oroKrYraB01gGweyypn8QCuaPocrRVWyAL6K3a31coj0SiZbrY7og7F6FB3RdxiWfUXU0/9crBndGHYPN7SAMNzdVTkwquGxmRJ/y0spYb9CyrWcjKys/Eyl8Ko4OAW5IVJXn0RmJ22Mof0TwSDwr5Ayh+AGni5ionVYypa59o5gBwX5mSE+5uomACSkh43UAaeUsXLNs48253qJ63DH8gFY3UJlUJ4JSHX9/fJhWMMCATXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W+qRlY2QNm6TMe4Hj4c59A2C5gp0ALaU48uvCkqPbI=;
 b=I0b4ypO02zJ4ot+WYmtU8ZEZw6d8g7dsg8wqfORGzs5S+dAHEnRu0ah7P+C7Ce0UwsyZDzNHSUJqH0kgviUV5Bxi6lGyr3WVdmVYj3v9F581VdmwDg4ELFaRmYsdVYxhOUolZ0pWhzcOC3cKAf7arDCAg2ejor933HlU1c1bFDZe2hdnuQzdHO8bcP28B20YaewxV7/SopT/byLy5D5PKfthe8zLaPKGVSFA+uUNK320pYIrzRw4/np4I/G84lr4XjW5kj6sc2N7jW1ZdD2pB1L6wlqiLDUsYS0AsRZ46KYG+mLiWoMhVoVBy3mAKQBt2MQuPqUAZNchvv2vqjk4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W+qRlY2QNm6TMe4Hj4c59A2C5gp0ALaU48uvCkqPbI=;
 b=eLH6eqR7ouz8c4vrnaQRK0E2lPI4mgJPuSZ3GTUZbiIDxu4X08slk5tFquTYjARK3cUHY9lN3RnKJ/GSwDGBWWOcXPpEuaa52C+pEmUxfHjYUEBXxrIDnqHCzVHZLBLh3EgwXrVb28vdYaiUloVrhuqDl1GpVnv8y4VFt2sMGZCYnCeGURQF9HiCu1h+EKDuSgSsnSbzKKzMjuEybmaPJhxAptN8QA2iDr2y+GlrTECGECPfHiV4Qbhg+AKe+rWIBKnu54CH3V7WBKLzv94WVw3sR9noHa7OPFsZqBlezJ4fjNPVgrqs3ABxa+5sqNlvitn2iFM+jlWnDWsKGn5wpw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB8959.namprd02.prod.outlook.com (2603:10b6:8:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 20:18:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 20:18:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, Wei
 Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: Replace
 lockdep_hardirq_threaded() with lockdep annotation
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: Replace
 lockdep_hardirq_threaded() with lockdep annotation
Thread-Index: AQHdGSYlR0ysEZkL90ukdEGF6PTNirZ5/DJw
Date: Wed, 22 Jul 2026 20:18:27 +0000
Message-ID:
 <SN6PR02MB4157B7DEC27E78D31C6F218FD4C12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260721153216.382536-1-bigeasy@linutronix.de>
 <20260721153216.382536-2-bigeasy@linutronix.de>
In-Reply-To: <20260721153216.382536-2-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB8959:EE_
x-ms-office365-filtering-correlation-id: 24f1e342-c82d-4e9c-01e0-08dee82e63fc
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|15080799012|55001999006|31061999003|25010399006|37011999003|51005399006|13091999003|8062599012|8060799015|19110799012|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S1/kdmonFCFgP33zVRpPfE9+A0kotGpgbUiRhnGl+Z60YFsCKekwd+BdBTAq?=
 =?us-ascii?Q?RTMimy/F1fuJZRO2WHuRfGTWxvweY55VFfZZtM3D1tOIFmiw479FRqA4xwuj?=
 =?us-ascii?Q?Krulk9ZVOcR/xgTup65oMrVBLIEroYvNlldPdYFjkrAvHohpCx+NNTUPK9uP?=
 =?us-ascii?Q?kInk74iyom5Os/M0Iic2WAVLx0kG6V0fn+3n2yFfQWSpiojq6c5VpBDA2eSz?=
 =?us-ascii?Q?2ObM4WWZ+8xJwU488ibcgM6Roy/C/sDf2kG8oSh33B4LJRXp6YvJ2s3BnZ8a?=
 =?us-ascii?Q?NXhrsvuQklhBQF1uk8hdUEM8lj/b9C4dFqwi8pxY+hR0EOsApkOlsOocGlQ1?=
 =?us-ascii?Q?VjQ+UcpLxhNMwE14JGGkBfJemMKuy1bJmv5n19ZTPxfItFm/WLACgmEFVmpM?=
 =?us-ascii?Q?8Q5NRW5Xg2RNrgIQCUdryzwm+/6XC8jVnpTcjOZNkXqVPY/zChzuThjis7pO?=
 =?us-ascii?Q?7n4I2M6376Gf7kvumde6QDimwas3ZFbUIq8DNdXLOi2CwIYHVFquShzpxZ8u?=
 =?us-ascii?Q?GShyrO10rwuUsrRLDtIQRKsC9mJr9r1qBIznzQKjVMfM5hYBytbnm+yj0gkQ?=
 =?us-ascii?Q?8hS8L50J0vi/syCBTL68HBSTTAvJdKzT4lxtksthgl59KvJ5gxcrfetSDddz?=
 =?us-ascii?Q?nhDszlgpM+fJJkpE9Cx9MXVnY6gAxs2zY9aRd2eihGnZc4Hy3Jkig4GcT4qs?=
 =?us-ascii?Q?b1Yfscc3Qv9f+M+5KTp0Gjos5tf5IrnJA4WM6x8X478veMLcUQcB73NFjRZO?=
 =?us-ascii?Q?udAKoqS1TIqguKR9fyM1fWBeABM0ixIq7KoyGUF2dK9mKJfZJyvvnVedzyTW?=
 =?us-ascii?Q?B+q4PIZ31tSbYF/SYO/XNe+JNX41QztbBNo9F4ig9JHiTLImJEMpe3ppWInJ?=
 =?us-ascii?Q?SzGS+QIYX+4bYrUwWRHAMD+cPdcNsE5ub7eFJtj/7WY2ofQyBk4yEZhQ24ar?=
 =?us-ascii?Q?TaaNPo/CM8zFrL0rvPNjvsgJ+a7wfbvF3jmR5L+EN6+3+76hxb+QwPKMr2da?=
 =?us-ascii?Q?JQgOPB9Wx3NbTFs0WIOATwodKBerFG4WSL1Cg6IGGJ77RywRjYIhwDGUI97R?=
 =?us-ascii?Q?sYfGt+qa?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e60qrRwHOv+pi7oUzLWx8ZOCyKMS23cjrdeAmsounlxu0gjvvzrWgGuka0GJ?=
 =?us-ascii?Q?NNL2LRAFP4NXvqcE2+7JDXCOZTYRgzc74e0YB7WEx/qOXT6HHBXTJcJddUae?=
 =?us-ascii?Q?PAtsT8XaUtTNaEbdczeKakJ3RyoymK7l4KSGPUCobe2ZF8G5KAtVEt50H5V4?=
 =?us-ascii?Q?89fT4OLIEPu9yNXTZkvwc0yrBxBn9BX1NJ+rOxiHENbBKviM7eXCLcxHE3Tw?=
 =?us-ascii?Q?Pnp2v54ONlrZjwofVckYcEpTtetfdu4tIWzwc6e4iJ5Qgdunzw5Mz+/outz5?=
 =?us-ascii?Q?SIFmsDZm9fnGulRyk7JUQ4BG+UJz+Rkc97FpQyyi/vSgQgx0ySQ5ai3B38Yd?=
 =?us-ascii?Q?fn+PjAG505FIyf+wGrZN7jl9ssAol0/D2QSVlUJIoR1KOx20qtwojrjkBZZG?=
 =?us-ascii?Q?bh2LOXfO3SO2i/ZTkONDKV2T7D1x3XjoHsn2ZpPnN/RK6O2eo79gLgYGA6/0?=
 =?us-ascii?Q?09S0d2Vjf5CQgs/x5jSYLIT9A8JD+hfKRcpLZ5iIrQK3Qwf1eJbnjqmUD2BO?=
 =?us-ascii?Q?bCH8vm55qWY0ie4sWA8IgvZ06iKXg8+y0HA85vLw6/T2AKN1OYh1iEiEqTsl?=
 =?us-ascii?Q?wa+fl3Ezf5BVMVwAsbm4c8MIRWWY6Od5UGv4EfvyzzvcvTSzC88uFYOgXN8C?=
 =?us-ascii?Q?5y/lgVYe7RojCu8heLcVSNftZlXZ+zbBHArB6UDUlY7I21ok2dvxE6u0E9nH?=
 =?us-ascii?Q?1DYwWYNqlYEesUWxeUzkFE1DIKgpi6SRGHt2UR5JDJPYEa6o9nWRz4EebSf3?=
 =?us-ascii?Q?RweIYU9UH4aqsI+Wd83zfgK5JF+VRxWEyG+zox4KLD1AGvqJKAaXdlXMyMKO?=
 =?us-ascii?Q?t0zVjakNPPKtn+wFIbaIwShQcBhBoPr9I3PAkwX4uAGOjpudq27iiK4XlWd2?=
 =?us-ascii?Q?E0Np7HOMJo0eFwEP+USPBMsq4IIwO9dnu5bMcjUlJg/dUN3GqZ+tNEDk8Q8V?=
 =?us-ascii?Q?ROhrnNmNyCwgtBMRbLC6tQ+zATYigVlk5ma0Q6Hf971rauohCthzpoY8/cLN?=
 =?us-ascii?Q?4ZtgIjLXiXpyv7j8yAYZhvAKvweE6TkwTQA66bpd6d2yQ+SY47+kbdbieai2?=
 =?us-ascii?Q?lgQudmdC34rh5imv9iO1Z/vX8hSAcvsKs4i6EHc8Qc/rYZIuYd6wL+3uQ9DB?=
 =?us-ascii?Q?2z6qXSJH25CSBRx2A1p4fCCsFsWOmJE0iEEDmvMx9UlfEE5KJHwPtIwe8gLu?=
 =?us-ascii?Q?a0wfR/mPvzi11xd56xESQMziRyZCEbVg3tOZhUxVIZXFP0kNs4jvQaqKQPqg?=
 =?us-ascii?Q?6mQtBHjR4EaZClwHsCLRceUa9Mr1xKWNn4fh9by92mTrq56sNnM5T1lrUOhb?=
 =?us-ascii?Q?BtQGUGHn34/hQDVsgHRDlx0dSP9UYWUvNzBZ9ogrbtu7MqV5lwQ9CQFjj/CD?=
 =?us-ascii?Q?rYy1xNw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f1e342-c82d-4e9c-01e0-08dee82e63fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 20:18:27.6620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8959

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> Sent: Tuesday, July=
 21, 2026 8:32 AM
>=20
> lockdep_hardirq_threaded() is supposed to be used within IRQ core code
> and not within drivers. It is not obvious from within the driver, that
> this is the only interrupt service routing and that it is not shared

s/routing/routine/

> handler.
>=20
> Replace lockdep_hardirq_threaded() with a lockdep annotation limiting
> threaded context on PREEMPT_RT to __vmbus_isr().
>=20
> Fixes: f8e6343b7a89c ("Drivers: hv: vmbus: Use kthread for vmbus interrup=
ts on PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/hv/vmbus_drv.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 23206640c6139..44877664d9d08 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1384,8 +1384,19 @@ void vmbus_isr(void)
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		vmbus_irqd_wake();
>  	} else {
> -		lockdep_hardirq_threaded();
> +		static DEFINE_WAIT_OVERRIDE_MAP(vmbus_map, LD_WAIT_CONFIG);
> +
> +		/*
> +		 * vmbus_isr is never force-threaded and always invoked at hard
> +		 * IRQ level. __vmbus_isr() below can acquire a spinlock_t
> +		 * which becomes a sleeping lock and must not be acquired in
> +		 * this context. Therefore on PREEMPT_RT this will be threaded
> +		 * via vmbus_irqd_wake(). On non-PREEMPT the annotation lets
> +		 * lockdep know that acquiring a spinlock_t is not an issue.
> +		 */
> +		lock_map_acquire_try(&vmbus_map);
>  		__vmbus_isr();
> +		lock_map_release(&vmbus_map);
>  	}
>  }
>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
> --
> 2.53.0
>=20

In my view, it's OK to ignore the Sashiko-reported issue about
hv_stimer0_isr() running in a thread context when
CONFIG_PREEMPT_RT is set. That scenario can only happen if the
guest is running on Windows Server/Hyper-V 2012R2 or earlier,
and that version went out of official Microsoft support in October
2023. I have an inquiry into the Microsoft team about removing
support for that Hyper-V version from the Linux kernel code, which
would resolve the issue.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
