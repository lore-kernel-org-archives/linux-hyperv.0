Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012083.outbound.protection.outlook.com [52.103.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA0279DB6;
	Mon, 31 Aug 2026 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788139527; cv=fail; b=a+3razPLqj87NQ0tLYzbdFMqlXbiHyOFpId271NaBT/j7s45Xx2tUULcbKE+eyQ2JLEzZrPEKsm8ZcgyTo+eLWh+gRDc5gRmBfc78LXsT84i+WtIEdDrEHB/NdLmfIQwvUHKbpEgRmGR/vsgTs4CyY03fCb4bUFQ9cHoY5aeyy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788139527; c=relaxed/simple;
	bh=gH6vhB1FPmRooJMy7uRwyktJWJ+zeUL1R3096w1L9Cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ybt1C8N3KQCzzxdaW5UGuqR+AnIC9OdgGSukBvoVV4FiMVNHaxveouQoLevCEHWukEblOI4N39Gj2VhXkGfMS6em9oT4hAppIfgqYLQr7So6FazxazVHj+m+e9EL7+JCBF52coE2FAmJYzuLR9UqJbZ7GbGnzIpXZ6dpSumT3zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YvByL4WC; arc=fail smtp.client-ip=52.103.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YvByL4WC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPCWLHx7whhffp+aACIATWDcsw83eOAXWFEW2Xvt/st7HwPWiLJXqvkUmHAkgtf8SxU85HOd1MydonRJXAfA/bYTyGn+/aXdKXLfJ4gvFYY4HcRS3wTtGcaRLYsYIEdRbrFgEe/XneXeqtZqGzuiMAKGZ5+PQmISnXCTapBwfXaf6JPIhzNblun3uOU+xZpO14/JntQdoLweV1Z/ffu4u3jhyHsS7g8erZCI9kMWS9pzIER/OZ5Hu3wlFhO/YT6l+CkMhh8nqqNci+u/fJkrb3v21RlmR8DRdo+vWEakb5MD6Mx/XRxlcjG3ed5Axx62wf4VhR+ThB8YqezNHydDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIGlBD7e9xGDu+eymNTggiR626yX+F8FcVuL0Zch6NY=;
 b=FSdfGMdXjIxTY6POO5v5KTcRbGjkfB0FzVWMxVSvdni4A1aaOr2mDsO2xkLNufzjGPoBMnblpc03njxTy/2UifFN489tOhP7FrKHQzZ6p08Q4vAx7uSKTYg4+6fjo/hqTiDCoTD+leTsJ1zC95okQNZ4gP+ByUZYKQQPwQ/JVgktpEQ6WrVbDMt1iUViC9Q2CbhnE0K+VsuhMuHa68/sVJ6hWny9+6GZMk+6DqSKzQSkm9OeJG94g1TZSfqCX+AfFAj8mpOEERJD9Kd+yYLEvxWvB5so0iO/33h79sooKxvlMcIAMgZN3ON4swvZArRt9oBjOJMZ6cnEKV1whtJwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIGlBD7e9xGDu+eymNTggiR626yX+F8FcVuL0Zch6NY=;
 b=YvByL4WCMtrvaUQA+6Bjs7sHP3f4F43A0uKIDjSmJ77Tkawhf0VQUQGKfq8ya9uePss8xFSBRfvcjRo4eXbxsnZzWzoZK06uMLgAW3hPpvP6+equL6HaPCvtRnzuMLvpdDb1MBijoESZhxB8NmjWN7runaYhc1s9f+fP8x0eSJixHvQER9KjiP6Lndn0G37cUQWx/e/HJbQSQKVzzXA/QimGqC1t7KE2/s8HM5kC/fzIM95ZoNPm3LkZVerMHJpYUXLI948r0rsfylZyo7bONHM7X/GFY+HVnvQ0p4sMDco1UYR9QFn8A74qsrw2vZNi5XTBiEMaZBiSQVcfdBKT5g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7627.namprd02.prod.outlook.com (2603:10b6:806:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:25:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:25:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Waiman Long <longman@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Topic: [PATCH v5] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Index: AQEBdJGAMFCAxQxKYcDCUO0qr7N2RLhu5W8g
Date: Mon, 31 Aug 2026 01:25:23 +0000
Message-ID:
 <SN6PR02MB41574F4E654477ADF0242F4AD4A92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260830234124.878502-1-longman@redhat.com>
In-Reply-To: <20260830234124.878502-1-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7627:EE_
x-ms-office365-filtering-correlation-id: 60aa1b58-6dd2-46cf-850d-08df06febab7
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|24021099003|55001999006|8060799015|25010399006|8062599012|37011999003|19110799012|15080799012|31061999003|13091999003|51005399006|440099028|4302099013|3412199025|102099032|1602099012|40105399003|2607281247196008|1141799003|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PDj7nS3m4ZF2HiufM0bb7IK51KdrX+sY4PdcUfZ8mOcLocMu4pYKnAiSKMo/?=
 =?us-ascii?Q?r8UPkAJPoBB0co3Q/65UuEfJF637/2W4wlleRdXLR/zo546XqpXkY1/rOWnM?=
 =?us-ascii?Q?Y9DB5S7hckq/nefqtkAVD8WgB5h2FfEYJgBZvkSzKbjEbFYFWhb0YJ/zV6XO?=
 =?us-ascii?Q?MzCR/Gl3UjNXvm917GdcDOowFffSrBYbDb6AabJmabNueqLDyDIQjHXQAQWa?=
 =?us-ascii?Q?d1+LXy56oRtZIJ3fIHr3Ae1qe7gNcaovr/2NCy9xZQ3Moa6+UgC81S8H7+Yu?=
 =?us-ascii?Q?qaS+PMYTAq0xvqRuON6mCXmIrG2foawyRDKz9RkLZREHX47KXeG8NuVP0X9X?=
 =?us-ascii?Q?Ty2/LsbDDRoXqTrGX7nbU6kGYME2becvykOv6ywRLEb/ca0nbXBURipJ2v0B?=
 =?us-ascii?Q?+Ruj9IIN60y8qVPgGuLqDdO9kda8bTKFYp8TwR4ze2cBtCdMwc/vCSKSZ5r7?=
 =?us-ascii?Q?Y/ZJ9lSPvjkLJH9iRBTwCRvgfTg/QZQZw4Y3siYyzxL+kn5FjjLiSw4HKVSU?=
 =?us-ascii?Q?WgEXb4OL10072Ct/RmMI+W+McoleQ3c9OdRjleEo5J+hSbjG5NbQGv56gqPv?=
 =?us-ascii?Q?snK6rX/63ySIVj2P1ArYRthQ9fc4UoBJeiJqq13pnaNXlXHDCgSQmTytkJ6H?=
 =?us-ascii?Q?dq9FGTub0/7V/u9mBeDMlZC3VaA4Ng6Kfxb4JBUK4SAQhFZfMpB+FO7YebXa?=
 =?us-ascii?Q?Yf8vF2YYbr8LJZJCb9X4owxoHGuLldUpIRJT6DNwiTzf9CBZF80Rw0jiCLYt?=
 =?us-ascii?Q?5G7sGPs38vC45uYEmm1P5UJZjEHtT/qgbhINC/8MolmdFzruZ83m12Fu28g7?=
 =?us-ascii?Q?/JMd6Fp0tGNYJuu27HFDPu1AQbCnBa4KJfTneeUo2hbVDXfr6fgE4zRYT3DL?=
 =?us-ascii?Q?dkd0olT89PfMQ1ojOTA9ltoCNO84yskgHpIDnpKBL2uVpjlG93i920ECmKzI?=
 =?us-ascii?Q?mVafmp+McckVA6dxYFrXjId5WgcFGuNmtTienhMeWg/Fk9zvMFfRdB6n+28+?=
 =?us-ascii?Q?5d7wI9t5d6rVsu5WnUAzecFz66OHpYBK0xPZEfWT7QzIZhGQKe7mLEEk/gkr?=
 =?us-ascii?Q?HRKuUB2aVFzRtDpEJ4cyBIeiyu96AlbyVpJ2OjhrlsvEj7wqeNhRVJW8WZEm?=
 =?us-ascii?Q?3uz4irK9/rV+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xuCih8MTrWjziNRd0RdZZgFLF1v0zsjAE778uzs5RhOXwdh+nktHPOhZVnrG?=
 =?us-ascii?Q?nBPlEtnEG2508HZtEWIylQv60axTGZa2zNF1ZIEujcjIyjoqMV0pVll32m8K?=
 =?us-ascii?Q?hTQ+EUc99sRXrXzjWQnsGpee7YWCq6Uf7OUQKrGSrZwYSQxq8GLQMV3EZdgP?=
 =?us-ascii?Q?8+pM8xamJ0OJ+YhBusWnh+5Cdvb/KfDWuQy9QPQjcbnYp+FhYXd0EcIJ2I9J?=
 =?us-ascii?Q?/Qlv/OJvmnScRxARnOy7ZXrBd3caEYox3KF5vQbU9f36bb0yMkqCZStp7KDQ?=
 =?us-ascii?Q?H8/90YYZaQqMTOeYiGGwZzNLfPridcFK1w/AtQxolfBiXjQ4WTy63KrrjPzS?=
 =?us-ascii?Q?PSHBxMyXjrK8VIPLW1E4p8JtO4GoS2XwEv8LcQgmVPaN7YDOzW1hRwjL/znx?=
 =?us-ascii?Q?BV50PKzrPseAuvkfo8EnjMayqbuItB5u6tMo3LXX35Hm419U9SU035NhPCHH?=
 =?us-ascii?Q?UO23z9LUKyGMdNhs9sffuFwcVvqLviAAAKcjMQxXVa/zgKgPd9g75ZBAD5uN?=
 =?us-ascii?Q?KE9Skavap717EBZjGvzpTloRwcNgfDHx+N+eDOQGm3yIyQLv25kOcx6RAnui?=
 =?us-ascii?Q?L58R2IzaeWumnlBYF4Z/Uoa5c+o4xQZZqFDcp66FT1jjuMySnZUdwn/fEqJM?=
 =?us-ascii?Q?4aji26PEgNThKCY73+875aNLhD/2BOctQTRKJd0kYO0ePzUtVh+2+N+GLgIx?=
 =?us-ascii?Q?ZXZ579cSWTFQr44cDjGFyUhTPKZWs7aah2eUDp89Ivc/DEkftLLMGFpdJP4X?=
 =?us-ascii?Q?425T+8qcPsBPfClysWbZkLMUVu40uznprD+BVVjsFJJzv9mTJTM97U8XuNRE?=
 =?us-ascii?Q?bpC6XZcjFW/OhBirFnMkQxIKjEP1PhKzSC9nHp0ON03wTxt0dUdmPPigmD4/?=
 =?us-ascii?Q?IDaBEI0h9PCCr5Xq3ElnC+y0NVsAL+58ljLXpDVuxwbutRIPq+22XF2IlzZs?=
 =?us-ascii?Q?z4SOlc5aTa4P7bqgMvrwhpeCB1ki3iLKfkrEfAH90HGVPlzxRkjn7W/tcWhV?=
 =?us-ascii?Q?YaZZBPZ+qpD6Uxflpc5E8M14A5tFoLU/PbLUPJTjce1I/mrujG9912YrNBf9?=
 =?us-ascii?Q?oC7XkopKRHXsaPNgxmJvYZR26kWfvmpZ961igCFyffK9C5uypfIEq/nJmQQH?=
 =?us-ascii?Q?3Ehfh9ZY1un6lyzkA9urGgtVbyQWBqbNU7LVJQSBdo+daPYDaiS0F0kxaaKH?=
 =?us-ascii?Q?IxrUTeFT/MtTs5wJOXyEi6qRIFt25NLpZbrOQhqzDOwBdG6b1yK8QYQtPGaM?=
 =?us-ascii?Q?NMjiwmTJkkV1TuncoI9MkO0XhuTMi3OtIQt0OhjUjMsgFw+eru8bgFTRCFsD?=
 =?us-ascii?Q?Ljx2x3V99nHjws525vE41m31sVOFewio9zq6wX7vGvoJd5HHmtNtQ85Zfxej?=
 =?us-ascii?Q?QTY+K34=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aa1b58-6dd2-46cf-850d-08df06febab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:25:23.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7627

From: Waiman Long <longman@redhat.com> Sent: Sunday, August 30, 2026 4:41 P=
M
>=20
> There is a retry loop in init_vp_index() where the CPUs from a certain
> node are stripped out if they have already been in the allocated cpumask
> or not in HK_TYPE_MANAGED_IRQ housekeeping cpumask. If there is no
> CPU left, the allocated cpumask is ignored and the process is retried
> again. However, if the HK_TYPE_MANAGED_IRQ housekeeping cpumask turns
> out not to contain any CPU in that particular node, that will become an
> infinite retry loop.  This particular problem was reported by sashiko
> [1]. This should rarely happen, but we still need to guard against this.
>=20
> Fix this infinite loop problem by also skipping NUMA node that has no
> housekeeping CPU in the inner while loop of init_vp_index(). Also update
> the early abort check to check for the absence of online housekeeping
> CPUs instead of just the emptiness of the cpumask. As the outer for
> loop will only be reached if the housekeeping cpumask has at least one
> online CPU, a NUMA node with housekeeping CPUs will eventually be found.
>=20
> Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.ker=
nel.org [1]
> Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel inte=
rrupts to isolated CPUs")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/hv/channel_mgmt.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 89d214dda360..28b8ff9aea6e 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -752,13 +752,14 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  	u32 i, ncpu =3D num_online_cpus();
>  	cpumask_var_t available_mask;
>  	struct cpumask *allocated_mask;
> +	const struct cpumask *node_mask;
>  	const struct cpumask *hk_mask =3D housekeeping_cpumask(HK_TYPE_MANAGED_=
IRQ);
>  	u32 target_cpu;
>  	int numa_node;
>=20
>  	if (!perf_chn ||
>  	    !alloc_cpumask_var(&available_mask, GFP_KERNEL) ||
> -	    cpumask_empty(hk_mask)) {
> +	    !cpumask_intersects(hk_mask, cpu_online_mask)) {
>  		/*
>  		 * If the channel is not a performance critical
>  		 * channel, bind it to VMBUS_CONNECT_CPU.
> @@ -780,14 +781,19 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  				next_numa_node_id =3D 0;
>  				continue;
>  			}
> -			if (cpumask_empty(cpumask_of_node(numa_node)))
> +			/*
> +			 * Try next NUMA node if current NUMA node has no CPU
> +			 * or doesn't contain any housekeeping CPU.
> +			 */
> +			node_mask =3D cpumask_of_node(numa_node);
> +			if (!cpumask_intersects(node_mask, hk_mask))
>  				continue;
>  			break;
>  		}
>  		allocated_mask =3D &hv_context.hv_numa_map[numa_node];
>=20
>  retry:
> -		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node)=
);
> +		cpumask_xor(available_mask, allocated_mask, node_mask);
>  		cpumask_and(available_mask, available_mask, hk_mask);
>=20
>  		if (cpumask_empty(available_mask)) {
> --
> 2.55.0
>=20

Looks good.

Reviewed-by: Michael Kelley <mhkelley@outlook.com>

