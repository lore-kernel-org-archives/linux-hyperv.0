Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012064.outbound.protection.outlook.com [52.103.14.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32D3AEF36;
	Thu, 27 Aug 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865054; cv=fail; b=XY0URmozmtxsfXwDtKmtjuMNerpox/4cBbV/GDzyvIWuv7WT8wjdEgpZY9bxIL0ZHBfqVAfcydWjSMiC3PZ6RjOh3NsG6skdgtWT31CYHKVfmtnSP/Oy8ooZ/L7mMEk7PUbLjowO2U5CTjSasP1tlTPizfwUTAJgvUT92Z0IJIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865054; c=relaxed/simple;
	bh=ZOD/iQ1BwSsULrkqQrXDaE2gXwtR9eJRK00Qcd8yQHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=clBE9SSy6tW2ciNZjs6Oznpx4DqQ6kA8Lk89Fk3PvtSeG95SYNqODkTrvLkmvKfcqjMeSHtneQsSFKMt6b+81kj4bD+dsJ/Ck1WICtof5NNpGGqJoNMA6ap6WYSBinqRtYIEhquSIY9Rk3A2LddFbCGIVbvTCBfelUmEg3pxC6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KgrUY4Eg; arc=fail smtp.client-ip=52.103.14.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KgrUY4Eg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdbUNPZSt+b7gUN//9iOT1hAHNqCYJ3AfH733B9knQ6KqbIhzxA27mcrjXRAO2cf6EKrd+8pwJgAF86WxuXaP5r6vdd2yhlI0yUuNx9kOWstnoT9UDIzSmK4IrND5P8gwOHGCQGUO+jEs3XXSiJ4VelPmhNHA4hlG4DeuVPVHTx7Y57Vn5bs9i/2bfk3vEQL5+gvI2W5XxpFADt0HlgG5VttQvxun7maCUOLuBirHQuIOXWRrk/i+m/Z0xtnn1O9wOqrq+2jNExXqKst2xxBLIHGpwaJAQHwPm9MX3opKxYpDqlGqMjMdPPA+pUw+Xxn01g2QOCneIrRgPjxbaNGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6/SyPbpxNxWpYMRBliq+uWjCede2eT/XdiUTzrxs9M=;
 b=tTfgmr9G2YaVAvVilD3c7moDr+f225JvKlEKZo/KcD/83XqMaFat6sVgriowjQmFH7HnNStn1FGKj/+hOaHDZrGMQxDwAvRXYX/sUk3HJCyS3A6TAGZuo8TtLxUrMoJWdHbtmfd5TRkwh640ICS0QMc2rwTA7Bpn6k+U8ATb0jzS1kyvXCLvOvHbcI30DcQ5Re5hOXDtsdQP1Ichg+mRMm/KPb5vBm+PH0El8Uhusco+xIFI9398GgBaaAw5Z0ZYYokGATWLWIMsaNbhnQNj3ezz9Pia/36uLCIi1oDbY2sGcAdOLXgXQLEyKfbfSMAGJxR8WCpJcKN8OHcK3HQJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6/SyPbpxNxWpYMRBliq+uWjCede2eT/XdiUTzrxs9M=;
 b=KgrUY4EgrqP9aRPhvJmpLxNgGMiYyCtDP0oo5zWEkMgx3MXEOZBF6DzOfWXd6kDOErrnGOOT75bL9mzy/pyR6+ybgqsqHHlBwXo+icM657gNAvH4dJzUnr6asNAQlEkD9BkELcSLSozkrmMT7C6ebqokIlk8kuj9drHAP+dPAaVMyx2yeNYa7126wsmVgvzQgCY9ay/ux38ZtkR537/mxaAv/HP+Ky9U6S4t549wekq3DmTKGkfiX3vIEnW+jaQ3JfXjUzi3GNDYb53ilha4jNFhvjvpjxA+HVUtc7KOgAPATQMJZ3+KqwYT8AmVUWLSVJ6B4updBtS1kRI2luJaQQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6503.namprd02.prod.outlook.com (2603:10b6:a03:1dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 21:10:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 21:10:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Waiman Long <longman@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Michael Kelley <mikelley@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Topic: [PATCH v3] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Index: AQJq8gdS5UNdHvCBWIBChMZYcTVn1LWW38zQ
Date: Thu, 27 Aug 2026 21:10:50 +0000
Message-ID:
 <SN6PR02MB415755118796082D643126ACD4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260827193750.662623-1-longman@redhat.com>
In-Reply-To: <20260827193750.662623-1-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6503:EE_
x-ms-office365-filtering-correlation-id: f0d5f939-1e03-4157-5602-08df047fac01
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZn9IFDOZRHBr3PkJ6iE+FIkCjTOOXEJ22bN1qVBSCU09VMCvn4m8wZNax1lgwsM8CO8DqBt6oBqsNbvicov5UL/lnxj25rBQODPQ/YhrnKu2B2O2RSeev/G0VJQl6/yDBVf7nGbc5IVAgFbqUzhOJE50Wx0uh9o3AyoWjenAMEyoCjEh68a4J/GASRq0VNxIIfsJiXBoMsIj6P0/IfOUkAOsdFPf5hQgWT8mDCksS9dtad3ZkFYWD11e5p9c79LQd0utshcCWOoqYRvXZkJaaepcZRRG5mJtlZWaxLDaJN9TDiXbGaoR0YAEF4lxTt3iM8lflaHNBO+Wuh3ltrPckgQylTN6BAhA+I5HRykjUyNPNAI+MOj9pCJDh9SuenKsJXlmsolJrUOVnSxIdsK8fTHB/Z7jf7ojGzJOOM29bF+BKpTYuo1cGg6RXWJACM+RNSV3iWIsXGSFoAjfsK4AS5VXhrk4/I2OE4hQz5l93jRhIWzuV9jahO6sgX5U9dBzdOX6bWooDmlbRaQ8Jaw4Y0KEQvf+zQ4op+NacipwpRX9L7uu+Hvet8Ki+PUm6fUFTMFxw1NRjXJcqd937OduunYDlB7KA1yZbB/8J1vLgXbJjPvIqGY8h0qFV4AiIRRNgEOb00Tk3qjyAPWa95JMMqBxkRXwYlM0quPF043/Uhl60zlJa+h6DNpdV/9lRT1qAMNQdXXLLhMtw8Tp7VPmnD1opOoNgb3ekrgHaLAmo0Giu1Y/1760G9RCE3SG47Rkwac37PAvo06o+rcL48nP+daNNFzU4dPDAUrWSLv/FpGE+wVcL44IG6Z
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|8062599012|13091999003|19110799012|8060799015|37011999003|51005399006|31061999003|24021099003|55001999006|15080799012|3412199025|4302099013|440099028|102099032|1602099012|40105399003|2607281247196008|1141799003|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZOc1iyJEf9xqR7I9ZpcG3TYfrxj/7qVbqfRzasS8WemJFSUmmQgq64AF36gr?=
 =?us-ascii?Q?t35v67bzKlgPzhFyWHgejF1MqRA4asqdWynhGcn6ySw/LzneAQjpO8dBEEyQ?=
 =?us-ascii?Q?dfyvLZ1h/oPVYWDyeI6RZiyZR3gprRB0QIw+O5el496fXdRbQmW4cAQ5bQq4?=
 =?us-ascii?Q?XnSUiB1tJ7MwQBz9aVG+0kRT7VIR/4i53aJESlko6OyFUfPELQh3hugHi7o9?=
 =?us-ascii?Q?aY1aWSXSy6EaF/Q17UhIZrZYq8DlvNUUOPLy8/5ADvtZL/KyVxS5lstAF9eC?=
 =?us-ascii?Q?9t26vR+Mtwag2wudDbsswUajU9aturtt/SN2KLu+LC0T5wcx9rM9IdEs3vud?=
 =?us-ascii?Q?ZSM2eQ5l99QHwp7nu4SszpPmQKCIdpHeYie1uB9sYKh7Twf5ykNGRtRFSmwB?=
 =?us-ascii?Q?XL1/r6E0Y2xoj4+tX01tXdksVaCRY1YfDEeKTXV+B1sW6yejbSWOF6sFRa/i?=
 =?us-ascii?Q?NlOT1Z+R9JYtBr5/uu7G7KeRATB9LFEqdR1m4k3ql68UoK2SBJfY653yE00P?=
 =?us-ascii?Q?vDRcI61VK+1dziZ6hY3mjNID+OYHGyBh0dqpPMUHAsGag0obPFaDAQPJuW4T?=
 =?us-ascii?Q?57q+xPAUqrYF89HIGNBqFeThh8uJn4ucRRjuNRyEK7896HwdTCHsvY0gHZft?=
 =?us-ascii?Q?QEsOB/7VlfxAZ1XMdMMfpawl6ZFTRM/CwyiqXxZwyw5LOOrMY1FQRFjNwEbe?=
 =?us-ascii?Q?bHU4FJVB2n0c+0z1rtuK5PvPG/Dw8WW1NvdlZaRWCQKoUQ1y8AnzHxN+fWJV?=
 =?us-ascii?Q?g3pvgxfCMzabEvo7CePkjGjCUOaEuj2mu9qeDu+zAl8xYt60FF87HLAzA347?=
 =?us-ascii?Q?F5h9fVmK2DUyd1sob9ju3SoZ+UlzY7sY1AzX8tkPtHhIal7DqjJ4HHrGMv3l?=
 =?us-ascii?Q?LP3j534pWMugZWkEo9uftFU6uoJw9vpEULi61WXdDrx7Mz+mR1qezPmPLkiH?=
 =?us-ascii?Q?/a2iWqpAjDhycCK1N9SchX4t1lkTQ2FF8SajbbgofsVzYKzBn12arGKYy9Ai?=
 =?us-ascii?Q?UVM6eTxRevFOjYEEv2t5pfgbLeNh8F+71o8o1yy92vBO77F286yzDMaPNR0r?=
 =?us-ascii?Q?W1NKAzLAaiCRuMjZE9m3CC/aVw9bQuniQx30XlCThHeJ9UqkX6o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yQO2a8Ra1+y54HQ538lKFyLCTpXhpMjpbUnqegfloCr4X5iNNMjjNu9PHjuL?=
 =?us-ascii?Q?F03c8P8OVI8BUroIIMd0nt/ZD5KOD6dIoi5uCqVoRKCledsP3Ojoy3r92Ii8?=
 =?us-ascii?Q?koxcZ6R3uW1zkhUdXKZj8w1lBQCwD8GkbesYoMcGi7uiMewz1T8xFT7YZFHD?=
 =?us-ascii?Q?58UTOKa9wOPFJ9lMtrh79pwn2unwzop1+DMwVQcBy1a2ixQ4f0lhzuhpYDZw?=
 =?us-ascii?Q?CXqr1EYx1KV4XP2VFuRxOIx+KblSl9kvTLZY6Af7bVd1RoVP1yHuoldL6pvW?=
 =?us-ascii?Q?+rB69qkN5/e+y9YbElfgpM/6TjcHVf2iOUTtnnOGx60S2mH0wAEwNQYjMQ+t?=
 =?us-ascii?Q?nQLkGOO072DD4rD3Bt3TJG7yeLe0gkAU07KtoB6G3139x8stn9DR0l2DnC72?=
 =?us-ascii?Q?45LBqdd3uaPUfcVrZVD9Y6TddkMRaQbiwArc5rfgkLxVQwrsAn5el/ZfTYws?=
 =?us-ascii?Q?WLo2Vu3R+LxCaYv0kg9b1AjP6KrbbiND1pOISi4j9hrgt4VCrNOzNIGZ/k5X?=
 =?us-ascii?Q?W9nlnRHgJ81Jsyt4r+WtJZLzY/8kqOPoLTOITjvK6fDXvExi7OlkI9Gk33mb?=
 =?us-ascii?Q?eSyDcEIVJwQFxwOac9Wdm7o4HkhUUc/dxyruVYfs0goG+TPZd/pt51HZd9RD?=
 =?us-ascii?Q?i9j0pV9Hi2N2KbFoD31r4SNF1N5GNLeGPKrDK7GMAUrYW9tvcMkh3zNLLkiG?=
 =?us-ascii?Q?iJzPx/vcHP70q2O0FpuBtl9PiLtsAfBCkUc/GpMBpIEglqHGJ4zJnPh4MoXN?=
 =?us-ascii?Q?ogARGmS0wxH7bO4nkYVdVIYxzXEQpwNW3qbmN3kjDfASyaA5VVjw35oXkhcY?=
 =?us-ascii?Q?2XATJ8yHPw06PmMSbg+A2P0eXz9a7PGCQ8HIjQupc+hIP0me8P/GI+Rwj9Pp?=
 =?us-ascii?Q?RHEW+eABZxPIPeqe5eOTjfGgczV+v3lHsDtHk/TQOQ9V7kyhZkv/v1RaNluh?=
 =?us-ascii?Q?MycmCPJyekRwZw0Q9LKJGw9sTpVVxGC+v+50EpblxJjBOzFUt2PKP34fnq+m?=
 =?us-ascii?Q?riQF7hNlCM53pZ5Ql5Gjp56B2vf7FEd9YnJrhBB5HttcOXWycvOWv27fQsxP?=
 =?us-ascii?Q?c6+/kLQx23dlfCrqTnMhp8+BEJrIim3i4zGbDQur2iV8fYuK1ar0l68cgKiu?=
 =?us-ascii?Q?8GOOhCuUBm2R3iDIWaa+z6RLvooD21+nKuGIOprT79TCdRMaWElprHvVfzxx?=
 =?us-ascii?Q?NLStFp1DUP1PVaoU/La8WpalDd1jrabcmM1pPAh4FJ0YGZeU+fV4jhua1+61?=
 =?us-ascii?Q?BsHNuaTBkLKJeof5pgH9wNEqVwgoS7iwnTosqYBtT+diTfhSzlb/IyP1MY74?=
 =?us-ascii?Q?PBX50dK8sBufYVtMe2EzQ3H/HMr/Y0AiVfb09NgzYTjMXqvYiMR/kltrfqUV?=
 =?us-ascii?Q?v/0tzdk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d5f939-1e03-4157-5602-08df047fac01
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 21:10:50.2520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6503

From: Waiman Long <longman@redhat.com> Sent: Thursday, August 27, 2026 12:3=
8 PM
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
> housekeeping CPU in the inner while loop of init_vp_index(). As the outer
> for loop will only be reached if the housekeeping cpumask isn't empty,
> a NUMA node with housekeeping CPUs will eventually be found.
>=20
> Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.ker=
nel.org [1]
> Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel inte=
rrupts to isolated CPUs")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/hv/channel_mgmt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 89d214dda360..ed121d74d73f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -752,6 +752,7 @@ static void init_vp_index(struct vmbus_channel *chann=
el)
>  	u32 i, ncpu =3D num_online_cpus();
>  	cpumask_var_t available_mask;
>  	struct cpumask *allocated_mask;
> +	const struct cpumask *node_mask;
>  	const struct cpumask *hk_mask =3D housekeeping_cpumask(HK_TYPE_MANAGED_=
IRQ);
>  	u32 target_cpu;
>  	int numa_node;
> @@ -780,14 +781,16 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  				next_numa_node_id =3D 0;
>  				continue;
>  			}
> -			if (cpumask_empty(cpumask_of_node(numa_node)))
> +			node_mask =3D cpumask_of_node(numa_node);
> +			if (cpumask_empty(node_mask) ||
> +			    !cpumask_intersects(node_mask, hk_mask))

The cpumask_empty() test looks to be redundant. The
cpumask_intersects() test will catch the case where
node_mask is empty.

Otherwise, I think this looks good as a solution to the core
problem.

Michael

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

