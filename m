Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012060.outbound.protection.outlook.com [52.103.2.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB553B894B;
	Sun, 27 Sep 2026 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540808; cv=fail; b=cseA1IWsEzku6NoPGbcSNX1YcPhcM+1dlp8YmL9i2cQ16gSzZ/nHfBJXqMbK9d9Qlwq4J1+ACxk1Lyj+JsMx02KTP5QIOOIeMjL2yi++3XhTfx9+OY8nJCXiBbspJwUzwJYLxjDM9OUr6tcr2HSa2CecSFgmMBejX06ILbbNfiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540808; c=relaxed/simple;
	bh=mfp06+k0ADVXQfNaCmjAfwH+EfPoCzhy7p62Eq6c5Cg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=my8SEWlq1S/OaTDRUbvoPEfNf1TBJEVvWTeObbnlNof3P6/ChiwmH4W0aVl8OChDwLRSl7W++1EiigiA6Jp4opktCjkOUHVdj8o/Z8AwYun1LGMpi8erhzSXluE5AqEvPjv1r96k+1pwigCDrdAZYR4EdNI/k0HQSYgW0flG8DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fy/T4Ugf; arc=fail smtp.client-ip=52.103.2.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fy/T4Ugf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqeShZi7Wsph3ZYeVu80J10hby8oKKmXqaF8DTljw3nQzZLCqcG/eQGOL9ciyekKkiPxZyLb9CKt3dppvBfTezjAHP8a/KpRRAA82Onwtnw0N6w3wN2A1kXTkXuCNp1w5/KGjbYiHYwBXJMNGn6HxnVCeXLlbJ/euRP7rmDxoyDYHxwd4dLwd2+7R3xY4pAxg6Dyq1X+F3GhPKMce8NeowikhW+IlabXj9WJiNuqcQ5I/vbRj1ByAgHEhIIMfrMZjLexmeh1mOC4UyzEeG2pdEfTlQ+x/SE3JLAQONQOT/7CJ7IbHhk792puhdPHT43MIIgfjq5JqgRDrBtIC7QDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHfnhUijjb69x1qKrKciFQEf89iFrmu+UuS9U8hg044=;
 b=fUEoirZDnB5DHLPg+RQ796JFp9oNBGE5+MzoiTragk4XMC3fzDwgi5eBPDxy3gXstdpHR9uySAidHUUY4ZbiJ09PMIGJJCv1WLwqQTW0zhc7paoiIJi7v37SU4kmfBZ7HFfqpA4dxTesXOJXLAUJC+7yPcDqSdRFKrQe9u8zFM+X6NqKhGxiZr26SYSWFGcsb5J+58Tu5/fYckURW5R4Vlo4I4E0mqHH65uIi5InwIt8/mFAMkk3n4i3P5bJ2dM51lp9+tgGXlA+emzvbih6BL1aWFBnLM3HNB3FVpHhlKtlh43Xwluu/7+TpfrXB5rRLZeheK4EaVZKWEsV2H6U9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHfnhUijjb69x1qKrKciFQEf89iFrmu+UuS9U8hg044=;
 b=fy/T4UgfaJfsorjeNz1JU0MiSOQkVq13NnM9Kz7TMhROYrRzHSQkZ+HQicNSReY20O4VGxzHRF/s8FrbMH5EY2PFIKeCeGMPqd2xnECom/eifD5qMOO3VNqIsU30gLE87m3Vwy44Ied6trKBJG4AHxkYqLKzd6MDPy5uP53+dHNzaJb7qAm0yQ8kNEBKBpoITF0EDW2jyCBUSPB9yLRf33xoafJfLBfH8uoUMt6dSVxwOD3UPP7/GkMD2OVk36vucMBHr6gfM5fWDimjCF9eUwILtKq7NS3aQgeWtCHAksu6C6OQXPb2A2sgAnMK/gb+QrND001bPuMBK/rQdDfyWQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9579.namprd02.prod.outlook.com (2603:10b6:8:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 20:26:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 20:26:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "namjain@linux.microsoft.com"
	<namjain@linux.microsoft.com>
Subject: RE: [PATCH v2] arm64: hyperv: run VMBus kexec handler via syscore
 shutdown
Thread-Topic: [PATCH v2] arm64: hyperv: run VMBus kexec handler via syscore
 shutdown
Thread-Index: AQMYjp04r0wmno9dzHTu+g7YT+y+xLRsVYMA
Date: Sun, 27 Sep 2026 20:26:45 +0000
Message-ID:
 <SN6PR02MB4157A59FB4154C18BFBCB87BD48E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260907092544.230338-1-shradhagupta@linux.microsoft.com>
In-Reply-To: <20260907092544.230338-1-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9579:EE_
x-ms-office365-filtering-correlation-id: bc02e317-4e08-43a3-4400-08df1cd5a63e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|24021099003|55001999006|8062599012|8022599003|15080799012|31061999003|37011999003|25010399006|13091999003|440099028|3412199025|4302099013|102099032|1602099012|3071699003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dU+iT4a8pvbHj1zT4PHdPVB79kphF3zmhAgMwMS1auW6eiqN/G7b1pERQzsW?=
 =?us-ascii?Q?tCPsOOIrUBKB0kkSR2X5GLOOpFpPSXXbvVf6u8RI0V9XuCX8S9cqU2G+c/mI?=
 =?us-ascii?Q?+KHNljDdsId8rfxmY8JbQLO7kBytMzohT/PDtIIY0Orn4vKTPmO3Fr6GmDp6?=
 =?us-ascii?Q?EB4Tgxa7u6/YLjrrStbISv7o74InTdJgdfeTvTcMifDz53aHV/t3T10BxO4H?=
 =?us-ascii?Q?HKwpbyAJwnkFCTMQNh0TmqgMNxs7Jlkwv4rl8l8oR1HSGAWJdmmWr5UKWstr?=
 =?us-ascii?Q?sQTFRI6CbvZm6QQCdCOFnLF7DBS9DQdqzt+y3TZwhhlxltN2c1qgY0hiaxuY?=
 =?us-ascii?Q?XrpkHIRx2/+pARSiC29j4U1UGs6HhqdlbmOG9uj2YI/x23O+PIkHXZAA8nlc?=
 =?us-ascii?Q?NFvJy15H+d5Z01aaJusKsznMD1bPysgILX4wA276e2eUAz10VN3vBivwc4Yx?=
 =?us-ascii?Q?pCo4qF+vYDc7g8mBVP+7A7Mg5o8o8qmjTJHSErERq3JOB/FTJ8jSLHdDuAsi?=
 =?us-ascii?Q?4zuo8jtcCeGMkHU7+oy2n6uMkHkQet0asxPVNfSqIt7ds7On+Bm2R9pq6AXQ?=
 =?us-ascii?Q?hMxjAtynEIMQrTRPlF/4Gh2/WFEifdxkXQYOt+AgfEylZtkn2twOvf3oIHAM?=
 =?us-ascii?Q?AZG0CD25/UahjaO7RujkZk8Zmlr8ByuoOxomUTxLOzLRfChldRb6qrzcFAY3?=
 =?us-ascii?Q?g81I1V/DNcvKPFDyZz1hY/EtO82QEz0AHP79s1lpX9NOLHgemG/QRLAFmdL4?=
 =?us-ascii?Q?/R744P1qvhlAQGWPPyaKw/3F7DJ24ghPiHJ/5Bz6DuuvqxI0jigfv/FGXoq1?=
 =?us-ascii?Q?B4p363v8SyJN1ngL5IRiF1uE0lAdvk5VPrKttp3JmzoelvvMmGKmOcxafg+d?=
 =?us-ascii?Q?TV5YqagifGPedOOC4HSb0tIOXn+wD5ZoAq+0zhm8ZGAFHoBPUdtiq7N7WN43?=
 =?us-ascii?Q?91KOHTAMuh/LFOpRLY4t/nhM3IFVZbUstKFlIZqxOibUslskhoGBGjCKDDdq?=
 =?us-ascii?Q?wQoYoxtR16egxoYZvC64Fp3iv7+xnnW/fufqWNY97bObWdvOG4o0vTdiOz1i?=
 =?us-ascii?Q?2RxBjIIOWW9atoAzR93BkWV+Ete3CJX0PM5l7vcpCawiCPC4V5Y4LEhmkaSf?=
 =?us-ascii?Q?1fxfwPl4F5Uz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HszzMdOQUdE7bVDa0FkpHXF8n4zt4tURuJKMCC6G5pjHWX04u1wmTL6tPq/p?=
 =?us-ascii?Q?OfdVvbTnq6JeqlGp/bR1frkyAHIML3M9LSstph+572USNtc/shEUK28+bsDE?=
 =?us-ascii?Q?DR4PEOysbHqLVSlUZiKlbZNPLG9+InFsQb36k56u8AEd14J7lSPwdv+0LOQq?=
 =?us-ascii?Q?EjH3IzmvyrT8X556fks7/Uj06D+SN8KtVQU1MpRZXqMQqS2tC+EPrcFZFU79?=
 =?us-ascii?Q?9VPnAH/1PMubC/UjOp092KSuYvY5FWN973z8UDZWDZAOEZcry0MaNS4LOMI2?=
 =?us-ascii?Q?uoAgWzegZ++iV09c8gm99z7iVYxoUDz3rnECZ1ivsN98QsU12xQc1uuSl5jI?=
 =?us-ascii?Q?vUPSOnF2+bF90Gjb8gLpo6l2mLEBpvIyBGg7bXujWuCqbhhnpZ+8r0NQ5DZX?=
 =?us-ascii?Q?oGYJfJ5hTWm/eDZJvJ+jGVqBfux9nB6BG6T4+Rnt9C98nQ595kcoXFhw1Q14?=
 =?us-ascii?Q?ue1Z0iLFl7Cd1b4afWUknchD84/LcbDgzy1AMzG00ogAdZve8M+YeIe8w7gL?=
 =?us-ascii?Q?KIQj8NeMRc5XaPt8suEB7yYfESrk7B21mVlsU7qP6u6c3Z/qApzRKbGzcmYD?=
 =?us-ascii?Q?OLkdub3IW7QJi6UtrmaCrL17EHuQU2NgCx1n9GPHCrw1Z4VdQZgxAgmbWp6L?=
 =?us-ascii?Q?Y/5EF2E9TEstPA33jytUfo0Yy7HGUrdXKGQHeHExfGX/crFyMfmNslc5Il8z?=
 =?us-ascii?Q?hTRM2ytXbYawOuauquTgBBSG831S4dSydF1DzHAxmZ/Es2DKrYwxQbJMaQEm?=
 =?us-ascii?Q?xLLHOGViuHhkdF26UgVFpPuRxzRWU+Iu9VA4Wda5AEJm9zeGWmKGIADkywq1?=
 =?us-ascii?Q?6PIOg5BzbGPN31NAgcPgyRkcB1mRLNAla8F9VoqfUb6DjdDzs5WelIl4z/54?=
 =?us-ascii?Q?fq+Z6ajGqelr5JP5GjNj4yN2Zci+laxfzSHla9YhGNdxY4zd+hCJ+74YSA/y?=
 =?us-ascii?Q?g1KwFrwaugEh93JlDKPPPs6VJWfdJakgSQ8zLkPiGa773I0u/dbX2mEwhV2W?=
 =?us-ascii?Q?3mTpq7aygfBzPUHgQGjpbV90iAlx2y3Fx8j5aLOywdruDAQ6cG+igeeDs1YA?=
 =?us-ascii?Q?8BX008Z2R4lFEhwwmgEUbJ/twParsqrvK8kpdtpRqMj5ZzayMGaqbkjbafvb?=
 =?us-ascii?Q?Zq7X3TbaLetPOB++WU7c7TkvdqdeLYL18aNtho1Vmf4LmFVvt+LXvEij7y8O?=
 =?us-ascii?Q?UXjxPiJeXj7B2Jdvs49HiF6BC+UEUCm9Al7+6Z3E6T4Q4uRW9kBDMKeh0wZl?=
 =?us-ascii?Q?XkKtp1XuhhXe8cVL55rVUNpk2cNhiEzuXTlzNCPetVPuxS3P6Gq2oT2IeWA2?=
 =?us-ascii?Q?jOED9/pcnznDnbar4mcdb5zVKKm+XrVGzvKhSzBGs+JVKnHoI3dA95UIPBsm?=
 =?us-ascii?Q?F1oG8z0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc02e317-4e08-43a3-4400-08df1cd5a63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2026 20:26:45.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9579

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Monday, Septem=
ber 7, 2026 2:26 AM
>=20
> On ARM64, machine_shutdown() does not provide a platform hook between
> device_shutdown() and smp_shutdown_nonboot_cpus(), unlike x86's
> machine_ops.shutdown. This prevents the Hyper-V VMBus kexec handler
> from running at the correct point during kexec shutdown, causing
> kexec reboot to fail on ARM64 Hyper-V guests.
>=20
> Use syscore_ops.shutdown instead: syscore_shutdown() runs in the same
> window (after device_shutdown(), before CPUs are taken offline) where
> VMBus UNLOAD and cpuhp_remove_state() must execute.
>=20
> Provide ARM64-specific overrides of hv_setup_kexec_handler() and
> hv_remove_kexec_handler() that register/unregister a syscore_ops
> shutdown callback, replacing the __weak no-op stubs in hv_common.c.
> On x86, the existing machine_ops.shutdown mechanism is unchanged.

Reviewing the code, I think this patch works as intended to provide the
missing functionality on arm64. But it adds to code sprawl by having
separate implementations on x86 and arm64, and there's an
opportunity to combine into a single arch independent implementation
based on syscore_ops.shutdown. Here's an outline of that approach:

1) Move the current kexec_handler setup functions from
arch/x86/kernel/cpu/mshyperv.c to vmbus_drv.c. (Or maybe
they all just go away per my #4 below.)

2) There's already hv_synic_syscore_ops defined and registered
in vmbus_drv.c. Add the .shutdown function to that syscore_ops.
(And perhaps rename it to hv_vmbus_syscore_ops as it is no
longer specific to synic.)

3) Remove the hv_kexec_handler code from hv_machine_shutdown().
The new syscore_ops.shutdown path will run before
hv_machine_shutdown(), which mean it happens before the call
to hv_stimer_global_cleanup() instead of after. Until just recently,
that would have been an ordering problem. But with support for
Windows Server 2012 Hyper-V having been removed along with
the legacy message-based path for stimer interrupts,  it's now
OK for hv_stimer_global_cleanup() to run after the kexec handler
has done the VMBus unload.

4) With all the above code now in vmbus_drv.c, the kexec handler
functions and data can be static. The __weak stubs for the kexec
handler can be removed from hv_common.c. And having a
global variable to store the pointer to hv_kexec_handler()
is probably unnecessary -- it can just be called directly.

Net, overall there might be a few less lines of code, instead
of adding 40 lines. I haven't coded this up, so maybe there's
an issue I'm missing, but hopefully it could be worked out.
When possible, having a single arch independent
implementation is almost always better than separate
implementations for each architecture.

One issue: The arch independent approach I've proposed
wouldn't backport very well. If a backport is important, it
might have to be the arm64 specific implementation that
you have in this version of the patch. Then supersede it
with the arch independent version for simplicity going
forward.

>=20
> Fixes: 9d7cf2c96758 ("Drivers: hv: Add arch independent default functions=
 for some Hyper-V handlers")

I'm not clear on how this commit is related to fixing/adding
the kexec support on arm64.

Michael

> Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@l=
inux.microsoft.com/
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  Changes in V2
>  * Use syscore_ops.shutdown instead of a bare function pointer hook in
>    machine_shutdown(), per Catalin's suggestion.
> ---
>  arch/arm64/hyperv/mshyperv.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d7..e608e546a395 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -15,10 +15,50 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/kexec.h>
> +#include <linux/syscore_ops.h>
>  #include <asm/mshyperv.h>
>=20
>  static bool hyperv_initialized;
>=20
> +/*
> + * Kexec handler registered by VMBus.
> + *
> + * On ARM64, machine_shutdown() does not provide a platform hook between
> + * device_shutdown() and smp_shutdown_nonboot_cpus(), unlike the
> + * machine_ops.shutdown mechanism used on x86.  Use a syscore_ops shutdo=
wn
> + * callback instead: syscore_shutdown() runs after device_shutdown() and
> + * before CPUs are taken offline, which is the same window VMBus needs t=
o
> + * run its UNLOAD message and cpuhp_remove_state() during kexec.
> + */
> +static void (*hv_kexec_handler_fn)(void);
> +
> +static void hv_kexec_syscore_shutdown(void *data)
> +{
> +	if (kexec_in_progress && hv_kexec_handler_fn)
> +		hv_kexec_handler_fn();
> +}
> +
> +static const struct syscore_ops hv_kexec_syscore_ops =3D {
> +	.shutdown	=3D hv_kexec_syscore_shutdown,
> +};
> +
> +static struct syscore hv_kexec_syscore =3D {
> +	.ops		=3D &hv_kexec_syscore_ops,
> +};
> +
> +void hv_setup_kexec_handler(void (*handler)(void))
> +{
> +	hv_kexec_handler_fn =3D handler;
> +	register_syscore(&hv_kexec_syscore);
> +}
> +
> +void hv_remove_kexec_handler(void)
> +{
> +	unregister_syscore(&hv_kexec_syscore);
> +	hv_kexec_handler_fn =3D NULL;
> +}
> +
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  {
>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> --
> 2.43.0
>=20

