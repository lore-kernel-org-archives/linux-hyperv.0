Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010017.outbound.protection.outlook.com [52.103.13.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31957EDAA;
	Tue,  8 Sep 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890595; cv=fail; b=tHrF4pmAEIfnproiDc/31JK0TxFpwd92lkACzZyiuiJFBJgOGCflqiFJHer2ToJg5ib5P6zQWGh9kezOBadw6g8+2kNUxStGIt3sRqVVClZ03LP6betfqbgxoR26xiuwMZzTe2anlLoSUzwuER1uXJtGw8HCX/MBWVqAkiCKaWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890595; c=relaxed/simple;
	bh=cfV4eVMqeiZ6AhPE6fuqxwtpEA2x4tZ8PdbchUU+buE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0VJTF73nVBynXiDlLNYEhKQ04d2O4zbnXYYJ4toyUFwwX/qF3XQTttuoGUQbohdusvZqHbQnPsgLaMDR+ICOkTj50iroGuMC/ExaelR01jo0wtphaL2OCrdCM+bCqHFrwnB6P4lgqFot+CWxWYYOaigUrMV7/2WkH4ulQVJiOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hLBlwgpS; arc=fail smtp.client-ip=52.103.13.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hLBlwgpS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bosFUF1UMVfCZBx3uRf8C18trJT2iYeeapW+bg8wHI0vCA7cFmHqI1sYqYGAO9hg0wpeYVJt1VsrwVBh+rpCe4SlPebwK1apr7p22FDmSc1xL5kgyfiCZ2ErNMoKHHthdYjB1cv+oywswe80JrbQQ8gx+s82Lychy5RMmiXXoSLCTbvSkCIQsNRvAde9tTkipyyXmE8jcSt1PgOhWph6lzLQcZ+lZW56CB06U5pT06Jg9xqd1tDXix71QystiYjsBfHczsi7J/o7ClhYMrRU/27vCrbQoZhhwiwRzWHa2lYWauoqXutUVthdH3JN8oBNMkcUNI/pculJ8LjSs0KezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUgfhpjJTnQE8BZPOn7k25CA1tjiKkuE/d0gZALirPA=;
 b=C9uMJch6bg8QK8yFUdIblj5YHabmDJUU2B68Jw/uT749pWQk7hXh0kKEvxmm/UQepDM1bEodqkk5BkFOi/BQtlAZkBMy78yTq+WbFSlfgSZOO0HlxZMdmLHFgOVAqhTU7dkGIZAYpNIc0R6UTz7ixJNzI6qNxEo6AFRNFN/jnLDXjnp3o7+HjgeZxALs/LZfDG0ryEwehfOHOR43JVt7Nfu290pbowYIxq+sORw76+TcpfdN0zWK0C3jrW1fRbDByIdxutBWm87huhrryPHIfIO2gbgGHIyo57s50b3OGcaLVabztsfWJMvdxhiU5tmcU2Y0jHsPkSBp1+dmMXxb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUgfhpjJTnQE8BZPOn7k25CA1tjiKkuE/d0gZALirPA=;
 b=hLBlwgpSUOrf/nBfEo/VtV++jbRHfBJaYO5ZYefEtx6TGwF4qUUrb+uq46Bd4kebpk/tpj/uV6fD0q5nW1wSmT28JyA43yV0JihmO+2ckXBpYIUdYZGxC/r2oBbGsfKkHzZdNh5HMThvt7EB1Tmxf9j5MYKHoIRvBGWiByglvpiv4N38cw4eaYYS0n50icwAmGjUb7UkL8qxOIPxexIW5DGfGlRS0+eMKcd1ki777lb6vNirw9kHySc2q0eVndM0qgGn3XBscUlawTekAkip2CO8FAu4P0DPTVKlHlba2tqi3XtMNcaxTDHkunvv7lF+5pN0W/7XtU0EPbeJuVp6zA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV2PR02MB11153.namprd02.prod.outlook.com (2603:10b6:408:34c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:03:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:03:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "mhkelley58@gmail.com" <mhkelley58@gmail.com>
Subject: RE: [PATCH V1 3/3] mshv: Remove unused *_old memory deposit functions
Thread-Topic: [PATCH V1 3/3] mshv: Remove unused *_old memory deposit
 functions
Thread-Index: AQHdPze42mZv9sCE/k6zwwhJuves2bbE+ixw
Date: Tue, 8 Sep 2026 18:03:10 +0000
Message-ID:
 <SN6PR02MB41579AD38FA1E6C9EABE65EAD4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
 <20260908021340.2548924-4-mrathor@linux.microsoft.com>
In-Reply-To: <20260908021340.2548924-4-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV2PR02MB11153:EE_
x-ms-office365-filtering-correlation-id: 89417006-c2c3-4321-b320-08df0dd37175
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7UHD2zUNzuec/oOgDaAUcj23jJ41OFf64/QY5MaTtiC9Cm+zINYcacHezrAR6XXiUJQIKMDx3HUMjfXO0BoTaEGJ8I416TbOw8SqPtDxj9Yi1GJpu9utkUJxFy9IDFQpB1hR317IL1wK0wkmvY1Yh1P42Jy+wsrZ6Mic0A40ANUuQLUpeZGI+iGE58iCeSQxVc0edeNH3wqyTBO1pmt8IRpBbDvwvn5b+752FVvxa5Yj83IZeZ4bnNaSlx9vloYPkbSdLRa6RSc/Vx2rSDF94k3mJjzs942rxJQVl40Hva7sh7nO5wSLtD1+4XxruWfYn4GhKQLKRWxh3GxDLDXMmIeNYhk610iSsUlQwSoz7vniaGFVRaqHqr+HbpdxZh2agH8yDySMF8cR2JhJjgvDHhN2w3CltgfjUw1fUbPzPPLDSMIPX0Qf+OmIaCLPKpVeEtyITSJkauSW0A0EMfyi4F+H0accpNy5aFGxqFcq6GqBf98MFzQts2ewt5bVj8eEzeMm639EHFwzfI0rBCXlY2w9RQekzFiQBNvamDHQDI0gT1RqP2V6qkfvyACmYAMUodC1JVSEq5KBShX9b21hzBgLAlSUuJkMxdAXiGTk0wBPfue8X3/FF6/8ZsRjGNVu86Mi59IxMD6z5i4fD0pPLVBEcF4LjzSTUcrzXbTqpJHUlIvgvGt/Q5Lj8mhbZuom1v0kpltkGunKrq0Ri7vC6c2fFE0ar7cOXDExdcjmJ1Vk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|37011999003|11091999009|25010399006|4140399003|19110799012|8062599012|8060799015|12121999013|15080799012|24021099003|55001999006|2604032031799003|51005399006|31061999003|13091999003|440099028|3412199025|102099032|40105399003|12091999003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P3ZYcOWiPXWUJuA9YxzzsOsKAtqXw5X2rA91nWg18T5DZZL9KbOKt8N5DhO6?=
 =?us-ascii?Q?JSlspRe3Zn6ClQJlxNtZzE/WwqH8XConyutKIm2wruJl96i5LMqtVd8+v7xg?=
 =?us-ascii?Q?f+Nbum74H51/w1Rm/Rifbt+vWysy54Dz2Fb89uybUh0ktbkrqqeO5c3LhZAG?=
 =?us-ascii?Q?ytHTDVFmzLWyNy4hGnpLsswcrFX8VRMdMHAKMiO1NclqKZb1XgyTjdl43RgG?=
 =?us-ascii?Q?KBnmWBEyuBuSIDFBdg5wmAJ33UCFhz8+P/SVlfampX4wYgtxZ4FxOfxawJ1z?=
 =?us-ascii?Q?3uFj53nfTFYSYnw+4zEhQToQB3+2bRImwA7uXBuiFNF8wV3Xxh9kGN8+QjE5?=
 =?us-ascii?Q?0JZww+mnTjVdi8KQFGyVal+Q4VrbblmzmT6Nk/hMxpcvDxkfLsd9RTQrjrFb?=
 =?us-ascii?Q?6qC+wVD76oLA/8DMBtf/B7sV0MyUNaWD5uzi7qZdCRpVOtHyaUpQHri5gul1?=
 =?us-ascii?Q?0ZhrnU3cmP64El0HgSGO6LLPm0cXfaZzN0VcTDH4kG4s9/UPKmPqKOOcQk07?=
 =?us-ascii?Q?FZP/zAwSJU5A6j7MgpHoRYEazNZT5miw64GiRo9b/aGMaDosZN7uUxiyuoaW?=
 =?us-ascii?Q?lqxGxmS70+AAYjo5OEldIymgKtNXNgIkjMlnpzyIV+3cyWsPD/983/MCl1e9?=
 =?us-ascii?Q?jkb+ahR0wjaw8i2Iva/UUMnysN1DvitxB0QCwm0mub7AquO9nhxkphsa1/yt?=
 =?us-ascii?Q?0DZo3ult9/q56g1td5ZfDyP/NVrR3m/Wey+NegkcZC6c5TwWVOGDdAktGZV0?=
 =?us-ascii?Q?ptCnP1XYRuUY75M1K+kGbGFRhu+L1wrri1kQe4VoVf250K/4mbT57BxfiQSC?=
 =?us-ascii?Q?R/N4cxck03m2omfmxSM8MsvReeL4BKXQkdD4R4+uSgnis6gtBqhVrSah5tLP?=
 =?us-ascii?Q?sMQSsCGcdAB7k1UCjKgEO5D/08pQU4jB9MXku9+NVaoZTDYgPQQTRR2vwlpu?=
 =?us-ascii?Q?J70ilMZs/Vw8zXRfKhFKHa+ynJTCJduwBpGXySetPAjQ509sefNaZfL/hiAj?=
 =?us-ascii?Q?y2KxiFlTv2RmmlaK5CKpxQu5ZKeGtE620EUhaqAhxooXN2Ttiln3zy9ec1fC?=
 =?us-ascii?Q?9o4MlnLNx7onhGQUKCUHk6UVQW1NRPAjVnMoz/FGuNBeZY5zTxgRRn0y/yla?=
 =?us-ascii?Q?4AFWKZe5qLhJCqQiTJ0SvKc+TxivbapVMPygFLkI+/4D6vZCQ0v2fKLVMsx6?=
 =?us-ascii?Q?Atg9nEemKQRdhQQJ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZwMAi0d4nmI5oQoUd+CTKMCczrdle5ME426+3ii9blB8EwprdvKDzHYGCoNe?=
 =?us-ascii?Q?0qpZ3GbMOcaHucbhN5ecHso6tCA5yU9JlAPf+ZVUniDUgNJCq5qNDwheoC3y?=
 =?us-ascii?Q?09TcW0AZPxzMlpXhvK/GbSTYdX+Xk7TFkQjdakwnPAX2KTVA8ENgrBZoCJHp?=
 =?us-ascii?Q?V7MXzVkQUp2O5Z324x2QTexsOOUtaT4ClySGhGvtOP6nsjCfSZf93UJ1nyrv?=
 =?us-ascii?Q?8RO+JCKA3hpwnZO84uiLX8lfyHHh675trbhJ/xwm+efcgrqFC9/fDbWqiuBs?=
 =?us-ascii?Q?S/kim0EhlBvyrOh2h+IVSdLIiSfDk7e+XbFrd7vvoA95ucP7gNzQblloCGKe?=
 =?us-ascii?Q?ump70tHO5AETseg6OguAYM39gbnlI5vZJlnpVyano9huHI4vqzTF5jehEPOf?=
 =?us-ascii?Q?grUpuWjIbaguuRdbY65gPAkC1cUweW0nTV3ZOnpAJBVwF9EIpRae683LMa0G?=
 =?us-ascii?Q?8taaBU0UrETG3A8Z0nBde6ox08QZlOIQl0AmTshDIbzTrYOeBTEpf85LeydN?=
 =?us-ascii?Q?MACWoJWLQlOoVGgMCq0+mCyH8BOWOJ1cMM3alrx3Bx0H8p7VDHx9NqkD7dKv?=
 =?us-ascii?Q?vYkrs78zpcEKK+HO8DSWrpGACpt41eD/BlLjKlqw9dMNQYXH7EL0o19pcc09?=
 =?us-ascii?Q?hSWORPeZqYzNtmc+ulS2YvnhjlQceXwbYxyBFaqM3glgj4+88eXM8Tp55NAx?=
 =?us-ascii?Q?hnraCGXolqdoEHKrZkkEb/+P07sT4TiVsWviFrDmHIDJJpcgzZeTYqQVecBM?=
 =?us-ascii?Q?xhiNK6Efaikq7sNcotLz7tVBUdK9tZrEP6dpnGzasEuppyB5C7DdoSx1V8uO?=
 =?us-ascii?Q?kqvAwbPJBQi0rZLMiEMSnxYPSUhegfb9mG25nVs60aIpIyn9VN0L0fmqJxDw?=
 =?us-ascii?Q?LKOyrv3gjnkFx36EBjA8a2atBGuzP8+VrxkXYiBX9WDKc+8kIsTVC+ezstxt?=
 =?us-ascii?Q?qpbWLNpotySDnJiK8vm5yv8DUHwlXswXe5CeQuCm0WzWvECllcp8IIqbYT9M?=
 =?us-ascii?Q?wxhlIjd49LnlfIZLqQgyS8SH0AgoWXwy/bKPg3p4/GzRi/yTqBoozbQrcTJJ?=
 =?us-ascii?Q?/elUIJ8kfrQZd/JyMszaynwPnOGuhux9LX1vgKUyjEJd/8hIwS8N5+O1LFdx?=
 =?us-ascii?Q?qWG6MB15Clzmkq4NKQ80FdNUqOLFve49FhxTfxpWhqVvAhSJn39dEl/RXQWk?=
 =?us-ascii?Q?PwwnsfoBy64TpDeYkIoIV9OBF5EaUaTZK7BVyDWckxkukwH9TOPM/YId4fCg?=
 =?us-ascii?Q?ejowATxg3aTvmj9QSJQv+Wxek4RO22oCL274sYAHw43gRKGMHRBIif4Oe06+?=
 =?us-ascii?Q?MSKGwHHgtfTNfi0Rzr+z+ArjLyLi7ZHzy6dB16gmWQZMOdrtV3P1n/oJd5xo?=
 =?us-ascii?Q?34gszhc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89417006-c2c3-4321-b320-08df0dd37175
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:03:10.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11153

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, September 7, 202=
6 7:14 PM
>=20
> Remove the renamed *_old functions.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/hv_proc.c | 129 -------------------------------------------
>  1 file changed, 129 deletions(-)
>=20
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 0ebede0bc8b4..dfae4b933fa9 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -187,135 +187,6 @@ int hv_deposit_memory_node(int node, u64 pt_id, u64=
 hv_status)
>  }
>  EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
>=20
> -/*
> - * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> - * are GPAs.
> - */
> -#define HV_DEPOSIT_MAX_OLD (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
> -
> -/* Deposits exact number of pages. Must be called with interrupts enable=
d.  */
> -static int hv_call_deposit_pages_old(int node, u64 partition_id, u32 num=
_pages)
> -{
> -	struct page **pages, *page;
> -	int *counts;
> -	int num_allocations;
> -	int i, j, page_count;
> -	int order;
> -	u64 status;
> -	int ret;
> -	u64 base_pfn;
> -	struct hv_deposit_memory *input_page;
> -	unsigned long flags;
> -
> -	if (num_pages > HV_DEPOSIT_MAX_OLD)
> -		return -E2BIG;
> -	if (!num_pages)
> -		return 0;
> -
> -	/* One buffer for page pointers and counts */
> -	page =3D alloc_page(GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> -	pages =3D page_address(page);
> -
> -	counts =3D kzalloc_objs(int, HV_DEPOSIT_MAX_OLD);
> -	if (!counts) {
> -		free_page((unsigned long)pages);
> -		return -ENOMEM;
> -	}
> -
> -	/* Allocate all the pages before disabling interrupts */
> -	i =3D 0;
> -
> -	while (num_pages) {
> -		/* Find highest order we can actually allocate */
> -		order =3D 31 - __builtin_clz(num_pages);
> -
> -		while (1) {
> -			pages[i] =3D alloc_pages_node(node, GFP_KERNEL, order);
> -			if (pages[i])
> -				break;
> -			if (!order) {
> -				ret =3D -ENOMEM;
> -				num_allocations =3D i;
> -				goto err_free_allocations;
> -			}
> -			--order;
> -		}
> -
> -		split_page(pages[i], order);
> -		counts[i] =3D 1 << order;
> -		num_pages -=3D counts[i];
> -		i++;
> -	}
> -	num_allocations =3D i;
> -
> -	local_irq_save(flags);
> -
> -	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> -
> -	input_page->partition_id =3D partition_id;
> -
> -	/* Populate gpa_page_list - these will fit on the input page */
> -	for (i =3D 0, page_count =3D 0; i < num_allocations; ++i) {
> -		base_pfn =3D page_to_pfn(pages[i]);
> -		for (j =3D 0; j < counts[i]; ++j, ++page_count)
> -			input_page->gpa_page_list[page_count] =3D base_pfn + j;
> -	}
> -	status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
> -				     page_count, 0, input_page, NULL);
> -	local_irq_restore(flags);
> -	if (!hv_result_success(status)) {
> -		hv_status_err(status, "\n");
> -		ret =3D hv_result_to_errno(status);
> -		goto err_free_allocations;
> -	}
> -
> -	ret =3D 0;
> -	goto free_buf;
> -
> -err_free_allocations:
> -	for (i =3D 0; i < num_allocations; ++i) {
> -		base_pfn =3D page_to_pfn(pages[i]);
> -		for (j =3D 0; j < counts[i]; ++j)
> -			__free_page(pfn_to_page(base_pfn + j));
> -	}
> -
> -free_buf:
> -	free_page((unsigned long)pages);
> -	kfree(counts);
> -	return ret;
> -}
> -
> -static int __maybe_unused hv_deposit_memory_node_old(int node, u64 parti=
tion_id, u64 hv_status)
> -{
> -	u32 num_pages =3D 1;
> -
> -	switch (hv_result(hv_status)) {
> -	case HV_STATUS_INSUFFICIENT_MEMORY:
> -		break;
> -	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> -		num_pages =3D HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> -		break;
> -
> -	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> -		num_pages =3D HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> -		fallthrough;
> -	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> -		if (!hv_root_partition()) {
> -			hv_status_err(hv_status, "Unexpected root memory deposit\n");
> -			return -ENOMEM;
> -		}
> -		partition_id =3D HV_PARTITION_ID_SELF;
> -		break;
> -
> -	default:
> -		hv_status_err(hv_status, "Unexpected!\n");
> -		return -ENOMEM;
> -	}
> -	return hv_call_deposit_pages_old(node, partition_id, num_pages);
> -}
> -
>  bool hv_result_needs_memory(u64 status)
>  {
>  	switch (hv_result(status)) {
> --
> 2.51.2.vfs.0.1
>=20

