Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795408976;
	b=de69WiAy7NuZXTf6EQv/8wBXSsy/cHBg14PNnxkkow9a1iL3s2oBvFDhErTnEkgQWVaW
	 Bv4eXFp6MJjIs7s47CRiB/5X9R/s60APQev58UoCNGRR558f1DJsFUKO796CongDqIVa9
	 WHIx0WwLTpwHdg2MhGf/hBkHk7dx3JPEwD2LJYHF7SqZsoiNCMA2RQXKm2g617mu56Qrs
	 WtxQ4mVq7WDCAL51gzMlYbl6mzPJeBgGHW4cnGQ5M6DU7oLyUnNa5ZRdOeprWip0utfpd
	 tTvz8eD1aBDToEvJrh+gr2YA0tJwEiD4oR56qzs2gZtVqbqyP4KkCw/iiBi82NZpz5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408976;
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
	bh=oK/d3zBsmUie4LA4+yP1lmk8Rh6PEIF0D9YLsiO4vVg=;
	b=ZlyWRhRI/D3jVoiL3oNQnZyXmbWOttgLDj3yKcwGHMUsdkHhPT3oC8ErcxaEZRXTXJRE
	 pgMcJJMz+nB1VjvKZrAjvP29kcEBHIROVUhoWtT8Y+v64lpL+LCK4ndOMFhzHJr9raqSX
	 SwHUigRReFKCmLvkQCzhpCi0olee12MWYALVO3yLyOPaM6hvwZ51wYC4Mp++mUm5Gx6tq
	 7rGSDXpGOdZggKb0jJfdXYCRIHTMw6uIGX8mvKnSo/cO4mj/nlYmK6Oacz5xXP/e2+3vL
	 DQHYlwkAw4NV+GPXQzv5fJOoFi6VId7NQOBpt1zkHd1g1yZesRTEg6JxuaGXENbpKOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=OnXr0vBf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.57
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011057.outbound.protection.outlook.com [52.103.14.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E298606A31A;
	Mon, 23 Nov 2026 04:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E298606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=OnXr0vBf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPgbocZ4qlg3u2VSggNO0VBrmuoVmAYtrRUDcRFg5vFbpBijrLhYjcaPHY0N5uNcn3ct0k6czyXTlEA3rbEXGgbFU0dy2x8o/fDFIZLiX553rWL0E1Zi7YsUwlGp9GK6ENrhyBiDzIG5FjqifVHFF8j7ocfJgzAzARAxXhw/g8cyzYqZXawS2hjkQnz3PwZASYp9hK1mtIdaxVxiOi2ALKSv5hx3xBj5WW+j2Utv+OAMNizgk9R+BHHUiBhceQhoezcU25CPPlsQNzYVsdmvpKD8IVCckfZnt+un7iT4Vk0T/34HLrxAU8tt1lO9Zgtp9gD00WSs81T1iHJs0VpP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK/d3zBsmUie4LA4+yP1lmk8Rh6PEIF0D9YLsiO4vVg=;
 b=kTwMwXvic2E2R4DHDD+L7EfJf0OJ6P8Hoaq3QQ90CZY8XxZj5HLhvSXb96E6gRxHl9mlzyUNjzcQK/y2YQXiS8+xXUsafWZsmH68t3flZ68R090i/diwj8YGfV/zyJbLDznbfV1OfVB/Q8AU2s8sToPR8deNMkcYPSNcgsEhz1jW+qv9qv9TFJfyODG3PIONm/KM+4W9p681Zboyqm2Iakelgfy1ReiBmWfFvN09Vulzly1wamLi1ge5dQopZW5BQW5vLA3Uxe4s12pODCYvIp362rtZojq5wBgmkqU+tHhbZKMqP1rbDiD7DE32CxnYifm+dKg8NABSjY4Xc3UO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK/d3zBsmUie4LA4+yP1lmk8Rh6PEIF0D9YLsiO4vVg=;
 b=OnXr0vBfqREZXAzHY9YQJa6dc3ezYJhJAq50oHwvdKEPCT4kdgNCwx4AY4bZZZgumwJfmq379tLT8h1kk2w82Kl+wSKsruXSfutYDZ7aVLx2NFdnBk9mA09E40sioRe5luyVGowtbNihUlPW/XpXhTDISSL1c3Q2OdMLP7JB5QdSURB5gPip/cpbkDSfgYuCyY3vFVnyc4VqKmHt3fFI8plX+qgbwvPn7+TAjJQ2YfjOMd/jsuFW45XK+H+Vjp6vhTI1p21C0zhMzqSYfIy+CLsFqCEgC83IUYoiadbmTG9RO+4P2QHYUhgekByr8wssIRxsDGWr6KnbK/4cWbEgxA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH4PR02MB247929.namprd02.prod.outlook.com (2603:10b6:610:521::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 04:42:54 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 04:42:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] mshv: Do not map mmio in map user memory ioctl
Thread-Topic: [PATCH] mshv: Do not map mmio in map user memory ioctl
Thread-Index: AQHdc1jYKri8GZ4IqU6twvMrOri3fbc7I4Dg
Date: Mon, 23 Nov 2026 04:42:54 +0000
Message-ID:
 <MN2PR02MB6863AD86B89C4055793E6724D4452@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261113031343.896489-1-mrathor@linux.microsoft.com>
In-Reply-To: <20261113031343.896489-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH4PR02MB247929:EE_
x-ms-office365-filtering-correlation-id: 879331f2-0307-4b23-2fbf-08df491c3d1a
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|37011999003|13091999003|25010399006|51005399006|31061999003|19110799012|8060799015|8062599012|24021099003|55001999006|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kLcESAPbqjJLXmzpHB1XkmX3Lk1Ow7/jENSopZlQxpnPNKCorkWfz28G1CcF?=
 =?us-ascii?Q?fgJCA62qeGIzQF03uHxbVr2kijmmMcRAmy0wSBxQ0TL3FR9LbGO3rNGLbweC?=
 =?us-ascii?Q?1wmPWSrlCRy5mZmDlw8rAdLtKPMq19DFImfvsHkactUJq/5fVlKihPwvL/CE?=
 =?us-ascii?Q?9j8q7Dt/gx3VZvNnXxSlKvT3tkT9iHmxh7ecqg5UOCF2EFNLSFlQy1o2m6ei?=
 =?us-ascii?Q?WpaZ1+NI0drLod8IrSkbaFctiLYyDgAAYqa5B5xw6ZheguZsrv0u+P9vk6FJ?=
 =?us-ascii?Q?qUSOR4g/5KZyN3mM7XLzW2UxOVK20JbMWVh6RDtIQOzQuLHYm5q3727kI+KN?=
 =?us-ascii?Q?fzKXK2ZxmorIrSI2fraDPbgWckL4BVMZZUziP0cq9aTYndZyi/r4VZ4rkFZM?=
 =?us-ascii?Q?ewom5JInrL1GRgJLs5eG4GSrgeUrniKxptq0EBKe7Va4GGmkdiI+82RLlwM/?=
 =?us-ascii?Q?ds74ph16aL7xhsN+Urr5PRsOuhBgGXz/zfcPX8JYHHjZ4WRX5supoBaZe4qN?=
 =?us-ascii?Q?ZCy2fdCRIGxGIRe4PSoinxO9RUfO5QY8G5tlmO0AGh+ILxTxbk52rilqiIOR?=
 =?us-ascii?Q?JSyTBWf0G2ei3LpbxTHpYtf8yOOBd31xd0zXaVPajcQ7FypUw4yxs9OKFgPK?=
 =?us-ascii?Q?bnA9nBZPqEzr9fY3H7vV9LJk7By4BBSifHbI7Fh+wLPUmwUTS8QoMJc7wb6o?=
 =?us-ascii?Q?Fhn3JsvUwka5vvHj+xRlBPd6o9siX/Pge9Ktih7NL0re+7Vh9i1bP0P1AcVd?=
 =?us-ascii?Q?yPM1DIHM1G9BcEAVU7s8vp4f5k4rdS9K77jNiB8V8D7xlPbIb/+6nLVo7bvW?=
 =?us-ascii?Q?vhZ7IZgP5T9YmJErp0FmQep7qdGZ4sENtaSr1dssHzjbav8HoZup+N2i671u?=
 =?us-ascii?Q?Ci4JEYaWmxdZ5DQSfDPcRo3n/BXVonMIAiq81dkFMnwFn5NHF59NTzYsgiY6?=
 =?us-ascii?Q?xySZZS1hgmS0xvJWUfoMpZnm/XOEftlLyS/4nZ45U5gWzt+jM/03Oa1cM1V+?=
 =?us-ascii?Q?ur6NfSF+bZKJk1m8LMAg2PN9hhMzn1CTYYP/fk+q2nNZVBQA3d9mfZcbUaA3?=
 =?us-ascii?Q?6EOBe+/w?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KDpaD1tPaEaTPqWDrN3p7me8zifge01vN8Phhu6irprXjx5g+SrC+6/gMORL?=
 =?us-ascii?Q?0UBPUafD/5eO9ePQbv7pNrzBI/WnmIIm2ItroTDQuaN2jpbuZwXBUoVOXLWq?=
 =?us-ascii?Q?X/KsE9Bu9hlNieDp7qi/M1fGRmoNPiBoiBZDAvy+Yuwy6unDLvrBiCjeB3uK?=
 =?us-ascii?Q?fHkuBzhy3NgRNczN/J7p+UkFIxIPR1zArg5ksPeBSqXeCKfHNQFqdbobin0M?=
 =?us-ascii?Q?om/XA6Tc+7zS6kJS+SKMkaDRTJhzqdtG5q7HlnG0FHd+PM9ZhcXLTR7Zbwu+?=
 =?us-ascii?Q?qSS422DJtatP+oevjE+w30Q49+sRQ/AYsXKUFs1GaQTGF7/MwZh5AfW2WNz/?=
 =?us-ascii?Q?/DHw6fZlanKugTKMggV0rCxyFg6cpakpB33FFXqOAoyJDtxpP42ikxd1eS+X?=
 =?us-ascii?Q?KFhAbAr+As5DTf57a5Gq2x9WppKRoLxneIs1XqP6wuQizeqDBs9vCDZjhi8C?=
 =?us-ascii?Q?fjiQOL/Jj9hm+n+P8XzndjlLHkkRA7lRMXkhPmo4CNyeh6MhwWE2Gc1u+nOL?=
 =?us-ascii?Q?yQPvRD1gEhtZpgQLAhfuv5/Wazch0vne37HM6aqbN1XQl39j6/lJtj7A3C9O?=
 =?us-ascii?Q?PyRf7Mvah2NLZuDinNZ+5Q+DPakistP5Em1rsupXVjaqFcdy2jBC/V0WGRzU?=
 =?us-ascii?Q?YraaJLtm6m0xLjlYS3KKru3p8Y+9PD+/gntwz+R4WSXjuzEuawfXjSphSkdm?=
 =?us-ascii?Q?hlcdoZ84YsTZhhoFAyUPfcO/hG+JmpyiQllfqOG2iwsWh2Mqh1T9KmTnhKBv?=
 =?us-ascii?Q?t0goD2LmR2IDElZSp5dX4bBcqB3P9Mecx1scONwEx+EI384cfpkQS0UeLnny?=
 =?us-ascii?Q?/SXr5Yrtc535VLpmmYe3JOYydTP15d+b69gfa0r8zMCFD7/XD/CYO7SQBVe0?=
 =?us-ascii?Q?+x9G04czbsYJ7TPZ9ZaJDAxGq780eCMqyqxez8nOQUFTSb3Dan87jTn1Hc0w?=
 =?us-ascii?Q?/5aaFLsDLEu6hNcPJLm0xTLe1scDtTyHqKwvaBqopo69kC3hAXuYwIIt5vYX?=
 =?us-ascii?Q?oW1DsnOBpIF4gQJFcj7kFhEgPVC64piQwn5TGAMqCcYuKpYdBPZcPa26yt9D?=
 =?us-ascii?Q?qCHW1LKpwIbHHQI9QTpz6lkawPby1/Tb4zl4n3XmCGt+HDHSxuWAC0gN1FnH?=
 =?us-ascii?Q?Xk2KgaNUjc1GvCf6QoCeK/PKIhKLA018oqKaeindgDC217T++Ynk3eq6fl0J?=
 =?us-ascii?Q?klXD02unR9XANzyJ1ZMtadg8OZuairFwXJEPeyB0EjVCR108pFS4vAXW+Rqe?=
 =?us-ascii?Q?i3lsqHWNShlCaEa9vhabocdLUV3o9/wuMzSv6ptCC7LdwuRyoUZwVvVMpPv5?=
 =?us-ascii?Q?G1eIFLy72JMq3Wa+uGX9iQ7u8wp5YA25LCbDzSriZiG/p4nGbcZ+Dgt7G/uc?=
 =?us-ascii?Q?i6z3vCo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 879331f2-0307-4b23-2fbf-08df491c3d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 04:42:54.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB247929

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Thursday, November 12, 2=
026 7:14 PM
>=20
> Currently, mshv_map_user_memory() snoops into vma to get the mmio
> pfn via vm_pgoff. The mmio pfn is no longer stored there and will

Did you identify a specific commit that changed how the mmio pfn
is stored? Given that the issue fixed by this patch causes a system
crash, it seems like this patch should have a Fixes: tag so it can
be backported.

Is the mmio pfn now stored someplace else that is accessible?
I'm wondering if this patch is a temporary band-aid to prevent the
crash, with upfront mapping of MMIO space coming back again
later via a more complex/more complete fix.=20

> cause the system to crash. Moreover, it is not legit to obtain
> mmio pfn via that method. So, remove upfront mmio mappings, just
> create region and do basic checks. The mmio entries will be populated
> on demand during intercepts in future.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |  1 -
>  drivers/hv/mshv_root_hv_call.c | 15 ---------------
>  drivers/hv/mshv_root_main.c    | 28 +++++++++++-----------------
>  3 files changed, 11 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index c61b52db7f00..c0844b28b6a8 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -281,7 +281,6 @@ int hv_call_create_partition(u64 flags,
>  int hv_call_initialize_partition(u64 partition_id);
>  int hv_call_finalize_partition(u64 partition_id);
>  int hv_call_delete_partition(u64 partition_id);
> -int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 =
numpgs);
>  int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_cou=
nt,
>  			  u32 flags, struct page **pages);
>  int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_c=
ount,
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index e8485d949951..1287c0a8d118 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -327,21 +327,6 @@ int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_=
target, u64 page_count,
>  				   flags, pages, 0);
>  }
>=20
> -/* Ask the hypervisor to map guest mmio space */
> -int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 =
numpgs)
> -{
> -	int i;
> -	u32 flags =3D HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
> -		    HV_MAP_GPA_NOT_CACHED;
> -
> -	for (i =3D 0; i < numpgs; i++)
> -		if (page_is_ram(mmio_spa + i))
> -			return -EINVAL;
> -
> -	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
> -				   mmio_spa);
> -}
> -

With this code removed, hv_call_map_gpa_pages() is now the only caller
of hv_do_map_gpa_hcall(), and it is only a wrapper. Is there a reason to no=
t
collapse these into one function?  And the last parameter of
hv_do_map_gpa_hcall() is "mmio_spa", which becomes never used and could
be removed.

>  int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k=
,
>  			    u32 flags)
>  {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index f0bfbbbd7bdd..a11756e5c48d 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1345,16 +1345,8 @@ static int mshv_prepare_pinned_region(struct mshv_=
mem_region *region)
>  }
>=20
>  /*
> - * This maps two things: guest RAM and for pci passthru mmio space.
> - *
> - * mmio:
> - *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
> - *  - Two things need to happen for mapping mmio range:
> - *	1. mapped in the uaddr so VMM can access it.
> - *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it=
.
> - *
> - *   This function takes care of the second. The first one is managed by=
 vfio,
> - *   and hence is taken care of via vfio_pci_mmap_fault().
> + * This is called for both user ram and mmio space. The mmio space is no=
t
> + * mapped here, that should happen later during intercept on demand.
>   */
>  static long
>  mshv_map_user_memory(struct mshv_partition *partition,
> @@ -1363,7 +1355,7 @@ mshv_map_user_memory(struct mshv_partition *partiti=
on,
>  	struct mshv_mem_region *region;
>  	struct vm_area_struct *vma;
>  	bool is_mmio;
> -	ulong mmio_pfn;
> +	size_t vma_sz;
>  	long ret;
>=20
>  	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> @@ -1373,12 +1365,18 @@ mshv_map_user_memory(struct mshv_partition *parti=
tion,
>  	mmap_read_lock(current->mm);
>  	vma =3D vma_lookup(current->mm, mem->userspace_addr);
>  	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
> -	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;
> +	if (vma && is_mmio)

Just testing is_mmio is sufficient here.  is_mmio can be true only
when vma is non-NULL.  Indeed, the existing code uses exactly
that dependency when accessing vma->vm_pgoff.

> +		vma_sz =3D vma->vm_end - mem->userspace_addr;
>  	mmap_read_unlock(current->mm);
>=20
>  	if (!vma)
>  		return -EINVAL;
>=20
> +	if (is_mmio)
> +		/* Upon mmio intercept, entire region is mapped */
> +		if (mem->size > vma_sz)

Combine these two tests instead of nesting?  I.e.,

	if (is_mmio && mem->size > vma_sz)

> +			return -EPERM;
> +
>  	ret =3D mshv_partition_create_region(partition, mem, &region,
>  					   is_mmio);
>  	if (ret)
> @@ -1399,11 +1397,7 @@ mshv_map_user_memory(struct mshv_partition *partit=
ion,
>  					    region->nr_pages,
>  					    HV_MAP_GPA_NO_ACCESS, NULL);
>  		break;
> -	case MSHV_REGION_TYPE_MMIO:
> -		ret =3D hv_call_map_mmio_pages(partition->pt_id,
> -					     region->start_gfn,
> -					     mmio_pfn,
> -					     region->nr_pages);
> +	default:
>  		break;

A default case with just "break" seems useless. Omitting it
entirely produces the same result. The existing code doesn't have
a default. If you want to be explicit that no mapping is done for
MMIO, perhaps leave the case MSHV_REGION_TYPE_MMIO
with just "break".

Michael

>  	}
>=20
> --
> 2.51.2.vfs.0.1
>=20
