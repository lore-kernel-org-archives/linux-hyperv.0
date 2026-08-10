Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010004.outbound.protection.outlook.com [52.103.2.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A47357D19;
	Mon, 10 Aug 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376122; cv=fail; b=AKeEI1jEVEXRSjO6pARW+M4Teo0ncFZIhMZpZgBUYbpW8iDRMxmeKI3HJkmB7w7pZpPxJBDBs8RJ/VyPecRW+j5fHjbzraYmd1B2BT17rPX3bzDqZDXIdWn9YFXYSZ+A8r9wxaQWNwXyjcbUkP7/i8bFDAnUXCDuGLYbHsjM/kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376122; c=relaxed/simple;
	bh=31P8EZEqUgFkITxI/BrIawOh3ngr4oy1N3vAeWXZlHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kb+DdeQaQwRZhUlygzfPm07gFE/Hd0EJvqtHUgxfIYR2CCccQifzbxmD/V7CFXxLWJOn3yUCTLwMM+GBg3xVAzMD9tBQ0PhFsZKXhQ4WBGCmZINFXA+VZ/5PwZJluC/s/mIcjUyZxkauauJGXD38qaF77ncP2vQ9MoftinSUibA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M6LqC65C; arc=fail smtp.client-ip=52.103.2.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M6LqC65C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrgQhMHvxLej41AVxObY/3CSihDwYeBhKHOtaYZAKIza3/+7jRCQfGlufTeHDlQVlxN7+31ZtWgV222q4MllZqLEJ2jyXijkSXjdZp5mW9d2HK8z25XT+Dzy4b1tc6KHTtvqFiMPrzAjcFEARw/WmPJrl12wbBo7tfgGXLEWoDmW1vwMQz7HAMbfdm9ci6otNfdIKBOcF80yJRrCbJujlek/vNuSV988kHh2s7S+XaTpsIofz+PDG5Ss6U1bqf9HVE/tP+Cea+3W0O9PlNx8rwILRAtyRVCsd++LI2b2Xzb/FIHbf3nZQGVqZngvTfsH1WsnVo4W49hKfHNWYLLyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKcF61FjJINzNQ9J3IvqLXP5bBLOlqXw5V7UkFXKEDA=;
 b=wK4IlSjsqu2QL+KxXLjLFQ/mkrHfvSXiZT7R9t5KZOqwTYVLKwV+LMTHnkn93a+dDfCpQHnA3rIVrGRuHTsIrUNNSnRYzbYLMztV4c+H8BvbzydC2kEYVjUNW0r8XH0LUF5eoplmE14bpU7AaNIlMJccQcLiH+HqKKtrg5v1eDI5+AksyGO/38712JfyfTccm809ncbf4yFXiY31qKTT7UIcXjsee5Ol/PoQzCaTdxQSf+hG9T4JeEQm0bNxxxuYI0A7H1ESl68lJ9Or0MiYM0aH4cjmB/AxGMKq9XzqH6fPzr+lzMdOVErHC3A5hoD+5LEEgd4bj7nk53dPXv3bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKcF61FjJINzNQ9J3IvqLXP5bBLOlqXw5V7UkFXKEDA=;
 b=M6LqC65CdkYO2XZ9LJaK8Qrl0xlSHHhGFFA5myvfODVhfiv3rkMAvxvDjm5BVPxYCJ60mc430XUjKyDb51g0Ems960auq+tEGjjPd9YruMZxWZ/eOgH5bKle12eQtuX3nUbnz0KLGpkY6h8PWKiJ0UXcigiVpywXmSq8XZYUp9pFpzc1yqPM13pn8eTk5U5FKt5wYY3YCJn4NP48jriLrVQOFMqxixg2XF7eN0qcKK0j3vUDGD/nmzkOoG+uLpufTtgSqObDhxebEnA1O3WDMWNVbxy0pDFM+nh07tLP/q8o06EBDqYb2IDIX6aTfilwXAinHETeS9T4U1tCAYv0Fw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB12062.namprd02.prod.outlook.com (2603:10b6:208:629::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:35:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:35:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "mukeshrathor@linux.microsoft.com" <mukeshrathor@linux.microsoft.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: reserve more vectors
Thread-Topic: [PATCH] x86/hyperv: reserve more vectors
Thread-Index: AQHguxbdqmk2qzOEIHp0SlYmOmKB77aQQsYw
Date: Mon, 10 Aug 2026 15:35:16 +0000
Message-ID:
 <SN6PR02MB41579785497E4D4FC62A95E0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260730005020.2181875-1-wei.liu@kernel.org>
In-Reply-To: <20260730005020.2181875-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB12062:EE_
x-ms-office365-filtering-correlation-id: 72f24d91-f619-4cf4-713c-08def6f4fa96
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|25010399006|31061999003|4140399003|13091999003|41001999006|51005399006|12121999013|24021099003|55001999006|8062599012|19110799012|15080799012|8060799015|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QXcpa1O64gl0wAk6TySc8ir5FhJPGREj7Gc8uj/7bqeu5fYb2AqBNFPlG0Vd?=
 =?us-ascii?Q?N7ehaT+CZNKIRDWHxCrMvYAoTZG9EuHMsr5sbszDfL9JoD+w1egt88CFPghx?=
 =?us-ascii?Q?zb6zmsLVkdwypfXzFyG+EcfRocyiSCgvp85zlEjdqzLGiqZ4mF4e4W8s5XGm?=
 =?us-ascii?Q?Im+1qRgWIpNPHGGq101F4tUaEyUXgH2wZ9OQ2QVpNxoKAgm89kTXLakvpdwq?=
 =?us-ascii?Q?jjHn42jS4mBAZq207H+7f51DMXqO/6DvXoiEMmR7myFluC9CR0ofDoDMELc5?=
 =?us-ascii?Q?cGQhxhfGiG1Sd1DTIcFVisIj8m0Cep2LqxHwxeaziq/aKxdyyAqLrm/Tc7Tn?=
 =?us-ascii?Q?OfE6nxiG3AAq7bvrKhkTu3uxkDjWE1Scm1QSCiz7AlQKD7BEhoTt1Lh2a+pK?=
 =?us-ascii?Q?lNCEMKjsJHAxODpggzK5xzGu07HH45jFFNmeTwkiQ5RPAT0uyA/XYnoCsxd9?=
 =?us-ascii?Q?tFjZAY4fYxDaXeHVYfvXxATvxsQkvsQw7ql4gFmgGoTcEwMa/t/av7oYd9R4?=
 =?us-ascii?Q?vn1shnUWIRmfWkpDcenDmMi8TTtWRayTmTSkZvzp5TZLm+G0ldym54r54mR4?=
 =?us-ascii?Q?8wCeGdjtMw7LeIS4OPZiXAuTRdvKHxT6pbdFsVh1Nq1KdEP/+PzLzN72TVhI?=
 =?us-ascii?Q?iATz36FfIZLCjg4d3M6/rlafRpoY71VDyODGtCr0uAcLrOjv16GGtpdoVstN?=
 =?us-ascii?Q?W0cfGga5lTR6EkxEr8DI5uZVFzUEM86xCS8my/H5BVpDzJRBbn5OWab64/yK?=
 =?us-ascii?Q?DG/zGuhCe/cd1TSs0v9bci5xi8c0hk3iBmpgZ+XXTYX6ugFYFGppCaugX+UV?=
 =?us-ascii?Q?ipZ4CoBcKISuKBIye3N3BQt6kfhKgeejeEQnZelEdV4RS8bZWWLnvwUPuth7?=
 =?us-ascii?Q?/JZsv9DCe1TR0pUiv7X2kpb82p+2vCphAugcQn9gqLcXs6k/eM6giOr5KFcF?=
 =?us-ascii?Q?shPqBeKbDzPFsblfIPQHIp5l7f6fgipxL3ZwpZBS5HjjEW5t2CWSEJyYfqXM?=
 =?us-ascii?Q?BmqV82cu3LI86fvlnmU888gnytyyL1MxU3/Imq2toFQheiZJca9D0izc53Rh?=
 =?us-ascii?Q?t4c/KzXkQoRxrXik9aTuHvy4ZlFfF3W+AmJ9naRkX2k8xcSyczM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A84wmR6CrHzWMEaE7ETV/HzKhSTnjTNvYLiX7GcWA6PCxtcmN2zI1b+Bq2ls?=
 =?us-ascii?Q?/qn8AolOV2pv/eix3pSxTohTLfFURoxsXpSnCNJPlbVcGHctrp3ja9kP46J7?=
 =?us-ascii?Q?M2xQZyZQXjQ9FP2B5khdeM1pYEeaUHosIyBJaNKfUeuPmNIGKzw8wrocy+Xc?=
 =?us-ascii?Q?afzl5bMt4mseEEArPrcA3jwBoFrTu0YR8RnsZiVz5QzDRuyuZpWpyFkZRJjI?=
 =?us-ascii?Q?Vkbjyx20bpTebNqy+7qOyWd+6PjxdToGz6BnzBzkTeYoii19/O3gWNFQKSRX?=
 =?us-ascii?Q?XXQJmWckzBRMIz0mQPxabJpz6h23xnDfKB0099zu55N+2VJEFPSd5k0U1b0W?=
 =?us-ascii?Q?UJF618YUUSHH/xmGfKzoF73smO2C7kCpMFrYKE1X7PC18aiTccazZ+f6Eb3j?=
 =?us-ascii?Q?v8Qw6hTuGfuTvcmDmQ2baYtYwWNvJH3YMkcih+/9R9sd560SY1HjySBNIcxt?=
 =?us-ascii?Q?Ckqo4Vl02ioFG9HHsXyPKodDU2prePNDr8PXSO3nD8rziW2t5snKn/3wBFjB?=
 =?us-ascii?Q?x+0Ot3QmcV7JuIZZFkqaYSbJTkikWslEX9Kw4FOb31HUkGpPv4npZWLOWM1U?=
 =?us-ascii?Q?8zOCN5TYsKiejP+A6T7zk7guhDvBjOJgxmJr3/hjZx24X04peDjINh1Q6rpb?=
 =?us-ascii?Q?DO2VG/k0KNEYkCT7EdNG7bu9dlgWg7Gj/iMB2iWGxhKTIg9HZICRZ4FLdsQj?=
 =?us-ascii?Q?7nXbBdl6AXWSbm0vHMxc0uq9/VP3ctak41dT5p07uY4obZqrZIIhkt1Fyii4?=
 =?us-ascii?Q?5W4THj9DIUVDAAjypHM4FsdsasY7CMEuaFcE3aq06kwtLRBKcKT+hgOdmVc8?=
 =?us-ascii?Q?xEo+ZiQRS6RlFLHegqYUKm/SJ/Q1dTJhvTGFAjB2bAGYSe9WX0hBvyqD0kP1?=
 =?us-ascii?Q?cNawhJRkhmjM268wRBJOSgnbl3iSpuT0jt3wjhA9e5Pog4R+US/+1lKhrYPj?=
 =?us-ascii?Q?Lx6TgvRHK1XgE68+Bc6yUGp3vE+SZO6+/s5hNayQSle+PEe5dK5RQrmzWC3R?=
 =?us-ascii?Q?zob8pZz8H7Am9gJbBpFrwZ2zeRI7ON54PnGYbmbvKvgccRPvNXlHmRO/D77e?=
 =?us-ascii?Q?o6JQO3FDutn56JuYImRviTkcHlxl4GPz4Kme9lA+Ev+JcbhHkOAt9Yu1e3O/?=
 =?us-ascii?Q?/u7zpkx8IlJRBvhdmXnsjUkYISmOkoBWkfPdGzy1ptGuVIfH1j3qyNWWHWtm?=
 =?us-ascii?Q?sP4s+7TLuV889KMy0T9C2GW8qE1vu8z/455roNs95fJthJ/4A/qWMHV9q/tL?=
 =?us-ascii?Q?9pN6D/6ZmRLXX/Zg+Ujm1UnqIABFQjAZZkNq/XPZ1X2tibqpTGKRuNdBJyF5?=
 =?us-ascii?Q?nLtnX++eqxI5JPAhHXKSfA3uWfk9XpusqGNzirHDvAAfOaQFhQeVYyJnsbT8?=
 =?us-ascii?Q?xwdOc8o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f24d91-f619-4cf4-713c-08def6f4fa96
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 15:35:16.9150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB12062

From: wei.liu@kernel.org <wei.liu@kernel.org> Sent: Wednesday, July 29, 202=
6 5:50 PM
>=20
> Microsoft Hypervisor delivers three vectors to the NT HAL running in the
> root partition and refuses to map a device interrupt to any of them when
> interrupt remapping is not available in the system. As of writing, the

s/of writing/of this writing/

> nested MSHV setup has no interrupt remapping capability.
>=20
> The three vectors are:
>=20
>   HAL_NT_APC_VECTOR		0x1F
>   HAL_NT_DPC_VECTOR		0x2F
>   HAL_NT_CLOCK_IPI_VECTOR	0xD2
>=20
> 0x1F is below FIRST_EXTERNAL_VECTOR so the vector allocator never hands
> it out, but 0x2F and 0xD2 are both inside the allocatable range and are
> handed out once enough vectors are in use. Mapping such an interrupt
> then fails with HV_STATUS_INVALID_PARAMETER, and the interrupt is never
> delivered.
>=20
> Reserve all three next to the hypervisor debug vectors that are already
> kept out of the allocator's hands.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 185d4f677ec0..229c7377a980 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -502,17 +502,32 @@ static void hv_reserve_irq_vectors(void)
>  	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
>  	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
>=20
> +	/*
> +	 * The hypervisor delivers these three to the NT HAL and refuses to
> +	 * map a device interrupt to any of them.
> +	 *
> +	 * The hypervisor will provide a hint in the future when these
> +	 * vectors become available to use.
> +	 */
> +	#define HAL_NT_APC_VECTOR		0x1F
> +	#define HAL_NT_DPC_VECTOR		0x2F
> +	#define HAL_NT_CLOCK_IPI_VECTOR		0xD2
> +
>  	if (cpu_feature_enabled(X86_FEATURE_FRED))
>  		return;
>=20
>  	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
>  	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> -	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HAL_NT_APC_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HAL_NT_DPC_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HAL_NT_CLOCK_IPI_VECTOR, system_vectors))

Calling test_and_set_bit() explicitly for each of the 6 vectors seems right
on the border of where it would be better to declare a static array with
the vectors and loop through the array. The loop could also populate the
string to be output in the pr_info() statement below. But leaving it explic=
it
as you have done is probably simpler unless the vector list grows again.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>  		BUG();
>=20
> -	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x\n",
> +	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
>  		HYPERV_DBG_ASSERT_VECTOR, HYPERV_DBG_SERVICE_VECTOR,
> -		HYPERV_DBG_FASTFAIL_VECTOR);
> +		HYPERV_DBG_FASTFAIL_VECTOR, HAL_NT_APC_VECTOR,
> +		HAL_NT_DPC_VECTOR, HAL_NT_CLOCK_IPI_VECTOR);
>  }
>=20
>  static void __init ms_hyperv_init_platform(void)
> --
> 2.53.0
>=20

