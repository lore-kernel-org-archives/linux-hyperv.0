Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012012.outbound.protection.outlook.com [52.103.23.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC5369224;
	Fri,  7 Aug 2026 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115513; cv=fail; b=FE4fE/ixF/9tZbEFfxT8luT35gbIKrTC5zu8hx+IgLVPYUupc1rvawjqLtvUNr7lQ5la50NcGUvE1YTC8m3QPSJisIjs71421KJMiqoex2bFtPZt1NZ/jsmGu6fxAV2gOCRn4R2tEwWKMpwnkdV4WnyeEsBrZjjuj+P2p9xmq9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115513; c=relaxed/simple;
	bh=hyOD1C81ECTkntOMTPpqJ7EKyzi1HCIb2+9Xi1QlZXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dssjpc6fCe3i6mCDLo5L8JkyhH0rmVj5/vqGb1uW6qIkrasR94tzA9SKvKOtLJ+XqzRm8ozRQgQeEAXcN0dAcnrmmitk1kVmPiqm1dWzaZMzezx/y8LyUcUuytDVtsOmFQjZr5mJ/mcJYwvOEhvjIzcXDcCUvZuNx+pxLmb4fGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sS/qx4xN; arc=fail smtp.client-ip=52.103.23.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sS/qx4xN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXGpjlc3DFTKFpaZQBrZpF5dshDHeokodmDduezOPKhI2cbdDrtG6gbtiemhpJJQayoV/BJidC55ne5/OXI8l7KFBrid9atU8FPaUtnvdeWl53a+vN8CrFgUANA7u+xp2FuqwZ9x9ZiLU9X02U4Y2BRHEI31UXbE3A+KPgmqY5spS64yYShzWT6wRIlsXGXXuecb9FwlV8bWGi8xEV5g3Nfjs/yv53qj0N5F9EQENfOGy/WUdw0i0IJQuGvyr8xuqcy6r9WErRIww7fMkGqkB/YjzqnR0N78N0EIIuliZ0IXJjMpbbXSqwNqH1V+NPfupYmmZlyUesxkowEKurcPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jk0hNf/XleuUOqo9lRSu4B9HHz/hFtpiCT/AAVsLHw=;
 b=kedzpi3eap7Ali3KCbUYUTZuHBmq9oMMeMpmzSTr8vR/RD7QTkQzVCwC11gJQK2Q2v9myovguHUfBw/uEqmZ10W0cDMMRrTkLCIkGh2l1iPBeckmePLQ387OhT0Ku4zaxv9j19X6AlMnkxuZwIi9hlppTLnqhCDkw6qo5v79H0I3TLduNFhR2UHkfTiFYzgG5lDw/sWbTEi04W/RIB6ivKv1q3Z20BjVkw9DtbnqO0xhuufoLuuWggRvwVtCshF+dZ/5iJfJPEGwsq/XonMZp0orC/JScm13TnuPbW0HYRTxUMWnhho2zA1r/3wbweRaAqC87Fckz4nnRn/chFoCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jk0hNf/XleuUOqo9lRSu4B9HHz/hFtpiCT/AAVsLHw=;
 b=sS/qx4xNVuHYaKPICJMf855ubw8NmELjIMS+BMQ7G1a827qW/if02p+x8Ur0HHwTVpaklC3wXv8XHgoDS3QZO7NMJfQcv7pSTEVYN+OfK7rtuka5OkLYar/GIHuQVYU9TL3pqt2La8nL0nr0qL1CXr8ocLTXWjACd7DyqZu0mI0Ua70WSvD+fRqdqZCZob4duqdc0rW8maBrOV/rPcGYpAAeJw0PEQJ3X4bT3tE+CGpRy7pLeKPI/Hkt1OJ4pvJIC4d0pj+iedZ02X/1ouAC6gfIFxVwf58s9tcJ4cAj9xKhIWTmsGRT1eDuNgKx5ucyk28Y5HWecCM0aZPDb+tdWg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8167.namprd02.prod.outlook.com (2603:10b6:610:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 15:11:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 15:11:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Michael
 Kelley <mhklinux@outlook.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] hv: vmbus: Add
 vmbus_alloc_buffer()/vmbus_free_buffer() for CoCo VMs
Thread-Topic: [PATCH v3 2/3] hv: vmbus: Add
 vmbus_alloc_buffer()/vmbus_free_buffer() for CoCo VMs
Thread-Index: AQHdJetW2gqVBS/MYkOqSKo46C6jSLaSskKw
Date: Fri, 7 Aug 2026 15:11:42 +0000
Message-ID:
 <SN6PR02MB4157F44468C6C9AB96266589D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260806213326.1425848-1-kameroncarr@linux.microsoft.com>
 <20260806213326.1425848-3-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260806213326.1425848-3-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8167:EE_
x-ms-office365-filtering-correlation-id: ae103f79-1e3e-4e57-207f-08def4963020
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|31061999003|51005399006|13091999003|25010399006|24021099003|55001999006|41001999006|8062599012|8060799015|19110799012|12091999003|11031999003|260806224601699003|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?td3/gP5wosjUrk2WOy82/LrJyKuFzMkgvUVagKmGQMYW7u/K1BxVzNcNlOt+?=
 =?us-ascii?Q?nPN8W8rczZffn3dL941G2NrpSp6SYmZCg1B2JMyOcLLtuc7QUeFdhx+ORybN?=
 =?us-ascii?Q?j4NVfZJyQcoAbdf50UJR6KV1obeOpVZQ+onk597VcKltX4z1/bsJuhF+pzVD?=
 =?us-ascii?Q?si3f2ajS72E8vmxzF4Gq+xSeNIPwMBxPtjuXQBZPUViLsgSWQXO1wB00GMQu?=
 =?us-ascii?Q?SWbvjdBnX4uP81GClMpygK52ev5/ymJpYMDWadM4s6Q5HH/gHr5MsvQ+8Lb8?=
 =?us-ascii?Q?vSsYW2KXgm0tB9e4yLK6MkpuV9Ueq28lnZurfJupqQFZ6UTkPZEE1a1q+ubi?=
 =?us-ascii?Q?na6a7iEkQ4LKaD7Qq4dZXpfSlXODROq73L9BjyxKzOPAcd2UqjSod+Ms8Rs/?=
 =?us-ascii?Q?32sf2qrcbp74+/CA5SzMrvg+xfRutA3as43VdwQFhzSaR8kwFH8BzKOsw7tz?=
 =?us-ascii?Q?P3t1LIbK8qTr+JuRK1xTEO1P/tNkG27Gwe0pAG8KWQo3nSp/EmVU6ssb1E/9?=
 =?us-ascii?Q?DQcYiDZ4j10v6zdbA+iT2bO+5Orej/Cj6kcRG2VOnavuKSU5d9UfyFkIZrIw?=
 =?us-ascii?Q?9TPcldrLCRejuX8lNP9KIsBWKI6DgO8yNFIZ+HYO0bzOT4+rt/O3WgMoXFEF?=
 =?us-ascii?Q?tRDal4BUkxv6+01m9X9BD20OS5Ov7pKffOYsZnl3d5Gtv3gDNIwuQlnOaTeE?=
 =?us-ascii?Q?kXQdToczdx70Bzi9ZDCDOX2PTnDGopE89VT6orBD8u1BVH8SgVPkKrv3A22N?=
 =?us-ascii?Q?+pqBnXnaOv/ueV9UI0/R31jpuIdBRnKvTp4uPFSRTNy6uyToef+rANkEqEVq?=
 =?us-ascii?Q?LKocVLtrinDRWgBQCTN5vfiHYiSyR4JGft0V+3jngPQ/2JxQAF0MCi6jx5LU?=
 =?us-ascii?Q?6hSccJg6PJRQiBJuM654WhvSgZLHB4HzBJKK+rK5aPEqOtajBPH01T6TTyat?=
 =?us-ascii?Q?WMcTS+/A4wOdOIy6liivAJaiuEerKm0+gbhmpKPxKt1EhN5CHwrN0/bPbskj?=
 =?us-ascii?Q?Flkqz7PlgjKICPKcjpMbhHdty+TKJApiR0njjLobowlT/MmefXyLyJFBc1Rm?=
 =?us-ascii?Q?BA2/J7b1D8g9L/246JRSLILdIQ7Vkg3kDPlrkOskYIYMLWHL42nGUcLZfAWQ?=
 =?us-ascii?Q?YEpNxYpMPPveIRuoEoM0cIpSg/5xzyjjpBljsvYI7uCoBHvw038M/SdaIXZP?=
 =?us-ascii?Q?Ppjlq8LN99fOBT5qYdEVWCwWcuXOeeDNWXuCaQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8aQVy/bhUTrgpY/bmrJMB5p7dUTj6f8GyhJRcs49TyA7iurXYOSbnlx9dDGZ?=
 =?us-ascii?Q?CaVuwXP+B21pPgMqIiv0EB1DPygopy4ZcombtykVicLTHsWFa1YAjUsB+g7l?=
 =?us-ascii?Q?ztO4kzYWZk41mpuIxV3w6nDC9SpSSA4F/mApdm+VWUrp4tjOzBVdrYHcqF73?=
 =?us-ascii?Q?JHSl2GrIwN9olT0fwJeGRECElGFyle/z/j+0DMUiC3u+NQSXgt8jC/yIPsvu?=
 =?us-ascii?Q?JkC30nB71UbRNLKK+PH9k6Z49+DVlXV5JL0b8Flm+4K/YCeqjuqYxhs4p89d?=
 =?us-ascii?Q?ts0TAHjeANBlEuljT+xUQdAHFzs1V/FrSFF3Reo3MT1q8F8jtQa89tMpWBed?=
 =?us-ascii?Q?wL/8GC9mYbELtGUUq45L+RB73qAiYxfozzp+qD72kVd75byGEqzG6UYI31H4?=
 =?us-ascii?Q?JzAhLnyus3kLvqcfjQspSJQeSF8w+zsZzHpi89W/J4g0G3a8xLqZWZAAf9A5?=
 =?us-ascii?Q?ch1S503ryXLvFbTNsahd7euPurjPStaJPiSAtUwJNJcpwduxevuubruag914?=
 =?us-ascii?Q?MK/RwfRPstIYQHY9JtXiOP3fzm8JiKxK0wtO0XZzPi+uap4zFp3RTSIBoWGV?=
 =?us-ascii?Q?D/dA4lQoTgbmE+Bj+uVhrOhdr17gpIX7EoxzRfpOISRJJwUkVX2ePC4jF6Ju?=
 =?us-ascii?Q?tgWyeCmicfRDDnOy99Wux3MrkvTJNcZjJ1WrWcKCNf7eZeKS7sZpDQbAtPcA?=
 =?us-ascii?Q?s847XHzmn79p8C3ou2S0OsjoijmNfDLZycjM0jG58Pj+soV9v/5odeSWMlPF?=
 =?us-ascii?Q?TZ+96LxHvDh5lJgaOTqpqG4eeJ1Fh5CpxC0lYh5oCCp0SA7xY9E5gjgBGA3+?=
 =?us-ascii?Q?XIPxTypWNXe87J78UWRmNHPR3ZFhWzLdzLWl3MCMD+TkEy9T94m+B0l+CUNu?=
 =?us-ascii?Q?YIeZ1uasG8rMZjHvfizp0glMarpl59OqH3q59r9lpI0w7FOBETAO2fl8irBD?=
 =?us-ascii?Q?HDS28hHc9jRUJnBCqraURhieO/i9VcSa0P3Uw0avprGFc8KjVdayOXo1wH7S?=
 =?us-ascii?Q?QW4lc1hQ+ZhsqaVxAnIRhHSP7grmO/kTu2l/KVDt84TUY4OAgK86jpS93hpJ?=
 =?us-ascii?Q?/lqM8/dBWCJ3qmSFD7l+PCNBq0K6OzVQ+PUOgJzMxBh2dPKmzdcgZPcn2+hW?=
 =?us-ascii?Q?LuXy+mGuEVfP0XvrhDxODaO8bBs9Zltu799x4HrAsGZ/nE+3KRdCrj8mdeE/?=
 =?us-ascii?Q?K+X2DvGvRCcG75auP2RnV4s4vv7y3myer3R/vlpf3FxN5f3eEsF8v2mBO6/5?=
 =?us-ascii?Q?mpDsiNmtN4pwrM++G6xgtg6K9vCny36WRGI5K2n9X8YvvxjlOFj4BCDA9PaF?=
 =?us-ascii?Q?XE6ThtVB4sQdLviShAlrX3Bdl4lNQXma+7OrNjFazbncGbz247aRj4atEx2D?=
 =?us-ascii?Q?Y7mF/jc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae103f79-1e3e-4e57-207f-08def4963020
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 15:11:42.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8167

From: Kameron Carr <kameroncarr@linux.microsoft.com>

Nit:  Subject: prefix should be "Drivers: hv: vmbus:" for historical consis=
tency.

If there are no other changes, Wei Liu can probably fix this when taking th=
e
patch.

>=20
> On CoCo VMs without confidential VMBus, the netvsc send and receive buffe=
rs
> must be made host-visible by decrypting them. These buffers are vmalloc'e=
d,
> but set_memory_decrypted()/encrypted() do not work on vmalloc'ed memory.
> This use case is (so far) unique to netvsc, so solve it locally rather th=
an
> changing the set_memory() or allocation APIs.
>=20
> Add vmbus_alloc_buffer()/vmbus_free_buffer() to the VMBus core. When the
> guest's isolation model requires it, allocate the buffer as a list of
> physically-contiguous chunks via alloc_pages_node(), starting at
> MAX_PAGE_ORDER and falling back to smaller orders so the allocation still
> succeeds under memory fragmentation. Each chunk is decrypted in place via
> set_memory_decrypted() on its direct-map address, and the chunks are then
> stitched into a single virtually-contiguous range with vmap(). Buffers th=
at
> do not need decryption keep using vzalloc().
>=20
> To free the buffer, vmbus_free_buffer() calls vunmap() on the range then
> re-encrypts and frees each chunk individually; any chunk that fails
> re-encryption is leaked to prevent accidentally freeing decrypted memory.
>=20
> This approach minimizes scattering of decrypted 4 KiB pages through the
> kernel direct map and the resulting shattering of large page mappings.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Modulo the nit, looks good to me.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel.c   | 155 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h |   7 ++
>  2 files changed, 162 insertions(+)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 4782f5070bba9..f4370617deacb 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -13,11 +13,13 @@
>  #include <linux/wait.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/hyperv.h>
>  #include <linux/uio.h>
>  #include <linux/interrupt.h>
>  #include <linux/set_memory.h>
> +#include <linux/vmalloc.h>
>  #include <linux/export.h>
>  #include <asm/page.h>
>  #include <asm/mshyperv.h>
> @@ -608,6 +610,159 @@ int vmbus_establish_gpadl_caller_decrypted(struct v=
mbus_channel *channel,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
>=20
> +/**
> + * vmbus_free_buffer - release a buffer allocated by vmbus_alloc_buffer(=
).
> + *
> + * @addr: buffer address, or NULL if none was allocated (e.g. cleanup fr=
om a
> + *        failed allocation)
> + * @chunks: chunks array from vmbus_alloc_buffer(), or NULL
> + * @chunk_cnt: number of entries in @chunks
> + *
> + * When @chunks is NULL the buffer is a plain vzalloc() allocation.
> + *
> + * Otherwise tear down the vmap, and for each chunk re-encrypt and free
> + * the underlying pages. Any chunk that cannot be re-encrypted is leaked=
.
> + */
> +void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt)
> +{
> +	u32 i;
> +
> +	if (!chunks) {
> +		vfree(addr);
> +		return;
> +	}
> +
> +	vunmap(addr);
> +
> +	for (i =3D 0; i < chunk_cnt; i++) {
> +		unsigned long vaddr =3D
> +			(unsigned long)page_address(chunks[i]);
> +		unsigned int order =3D folio_order(page_folio(chunks[i]));
> +
> +		if (set_memory_encrypted(vaddr, 1U << order))
> +			continue;
> +		__free_pages(chunks[i], order);
> +	}
> +
> +	kvfree(chunks);
> +}
> +EXPORT_SYMBOL_GPL(vmbus_free_buffer);
> +
> +/**
> + * vmbus_alloc_buffer - allocate a host-visible, virtually-contiguous bu=
ffer.
> + *
> + * @channel: the channel the buffer will be attached to
> + * @size: requested buffer size in bytes (will be rounded up to PAGE_SIZ=
E)
> + * @chunks_out: on success, set to the array of underlying chunks, or NU=
LL when
> + *              the buffer was allocated with vzalloc()
> + * @chunk_cnt_out: on success, set to the number of chunks
> + *
> + * Buffers not requiring decryption are allocated with vzalloc().
> + *
> + * Buffers requiring decryption are allocated as a series of
> + * physically-contiguous chunks, starting at MAX_PAGE_ORDER and falling =
back to
> + * smaller orders on allocation failure. Each chunk is transitioned to
> + * host-visible via set_memory_decrypted() on its direct-map address, th=
en all
> + * chunks are combined into a virtually-contiguous range via vmap().
> + *
> + * Return: the buffer's virtual address, or NULL on failure.
> + */
> +void *vmbus_alloc_buffer(struct vmbus_channel *channel,
> +			 u32 size,
> +			 struct page ***chunks_out,
> +			 u32 *chunk_cnt_out)
> +{
> +	unsigned long nr_pages =3D PFN_UP(size);
> +	unsigned long remaining =3D nr_pages;
> +	unsigned long page_idx =3D 0;
> +	struct page **chunks =3D NULL;
> +	struct page **pages =3D NULL;
> +	int order =3D MAX_PAGE_ORDER;
> +	u32 chunk_cnt =3D 0;
> +	void *addr;
> +	u32 i;
> +	int ret;
> +
> +	*chunks_out =3D NULL;
> +	*chunk_cnt_out =3D 0;
> +
> +	if (!nr_pages)
> +		return NULL;
> +
> +	/* If the buffer does not need to be decrypted, just use vzalloc() */
> +	if (!hv_is_isolation_supported() || channel->co_external_memory)
> +		return vzalloc(nr_pages << PAGE_SHIFT);
> +
> +	/* Worst case: every chunk is a single page. */
> +	chunks =3D kvmalloc_array(nr_pages, sizeof(*chunks),
> +				GFP_KERNEL | __GFP_ZERO);
> +	if (!chunks)
> +		goto err;
> +
> +	pages =3D kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		goto err;
> +
> +	while (remaining) {
> +		struct page *page;
> +		gfp_t gfp;
> +
> +		order =3D min(order, ilog2(remaining));
> +
> +		/*
> +		 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing,
> +		 * but try harder at order 0 since that is the final
> +		 * fallback.
> +		 * __GFP_COMP stores order information in the page folio.
> +		 */
> +		gfp =3D GFP_KERNEL | __GFP_ZERO;
> +		if (order)
> +			gfp |=3D __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
> +
> +		page =3D alloc_pages_node(cpu_to_node(channel->target_cpu),
> +					gfp, order);
> +		if (!page) {
> +			if (!order--)
> +				goto err;
> +			continue;
> +		}
> +
> +		ret =3D set_memory_decrypted((unsigned long)page_address(page),
> +					   1U << order);
> +		if (ret) {
> +			/*
> +			 * set_memory_decrypted() failed; the page state is
> +			 * unknown so it must be leaked rather than freed.
> +			 */
> +			goto err;
> +		}
> +
> +		chunks[chunk_cnt++] =3D page;
> +
> +		for (i =3D 0; i < (1U << order); i++)
> +			pages[page_idx++] =3D page + i;
> +
> +		remaining -=3D 1U << order;
> +	}
> +
> +	addr =3D vmap(pages, nr_pages, VM_MAP, pgprot_decrypted(PAGE_KERNEL));
> +	if (!addr)
> +		goto err;
> +
> +	memset(addr, 0, nr_pages << PAGE_SHIFT);
> +
> +	kvfree(pages);
> +	*chunks_out =3D chunks;
> +	*chunk_cnt_out =3D chunk_cnt;
> +	return addr;
> +
> +err:
> +	kvfree(pages);
> +	vmbus_free_buffer(NULL, chunks, chunk_cnt);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_alloc_buffer);
> +
>  /**
>   * request_arr_init - Allocates memory for the requestor array. Each slo=
t
>   * keeps track of the next available slot in the array. Initially, each
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 1146addbb42c4..f843ee0efa22f 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1214,6 +1214,13 @@ extern int vmbus_establish_gpadl_caller_decrypted(=
struct
> vmbus_channel *channel,
>  extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
>  				     struct vmbus_gpadl *gpadl);
>=20
> +extern void *vmbus_alloc_buffer(struct vmbus_channel *channel,
> +				u32 size,
> +				struct page ***chunks_out,
> +				u32 *chunk_cnt_out);
> +
> +extern void vmbus_free_buffer(void *addr, struct page **chunks, u32 chun=
k_cnt);
> +
>  void vmbus_reset_channel_cb(struct vmbus_channel *channel);
>=20
>  extern int vmbus_recvpacket(struct vmbus_channel *channel,
> --
> 2.45.4
>=20

