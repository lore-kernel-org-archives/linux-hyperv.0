Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011027.outbound.protection.outlook.com [52.103.12.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E130DEDC;
	Thu,  8 Oct 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480242; cv=fail; b=otthmAe6tQ9A0vUWiqtwjD4BzfT1Q4dTkL9C4B8yH+VyDzdlP3/x7FLz1VCZXDz4rsk2Rxje75miQ9O/kt/D10RvJcOt2sUogwiJGqYhy19JMdpd4Mfe/lf77mCviDj7a9/BquhFDckrZZ/UdVpESFPrlgFZzQpeEOg/rhXwUP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480242; c=relaxed/simple;
	bh=Ob9v4gsKVsoD1AF0EYw+qDrYi6OPMszHmeuRiuY+YKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PbN8gDzrn9lvH3NF+d3JhmYiZDrqBfC26wb8Fh1Z4uIfm5k/VDBau/XwOP5HS8z/GkDATA4NqqrOtl4IZMTHjY2h/XyGI6KdX/fLOXZh9yej9g7WCjzRHFXrDInM5cuA7/lkqiLKImTz76KB4Y7ignLyaQb1s7AK0CNSX70YyJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FBCJH9wj; arc=fail smtp.client-ip=52.103.12.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FBCJH9wj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFjCQQRfAXSxJOq7AjG7bc5Zxhk+rbeCMpC6znMqeILbtASY14Cf91bUInYfSUE9SASR2gp5dFtiXcb8poSf/jAEeznZ0E6jeUb2xKA7PQay84EbBhiu0aRoqRRNqayAhoNQZrXSujwTAzAdM7aZLw1zDNWVtXcnG4QjE7XJBabn9GGxmMMk9aL3Fx2ltXpYUfjnyiw4rDYYQp8n8IA15TaUjJTmM6CIE0Ge/iJN7pPtBjHgoBoOPWJd5HoQQ/LyHklhwkpOzfpbKmEfreH+pwXbWyO31K0DyYrnpUXDqKmQ23fM9MHOYPkp+oc7BWtGUGrkeG+En2bnk+CbbbZSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ+MdgYzAtpKhQbTtvcZ0OMf51Yuzt+wJ399QyJiJG8=;
 b=PMDpOzEUujnQ2LxIwPiDogkBnUCYxK3vmtutFC9N5K0gEcmn4irE5RoTUm1RcjhUyq+KGoMx/SCRfWEZpK7YSUlJ6SRYG3LrUumYkknhZ6CPu8k/muasKyXwUE+99ZWPYDr5g2lqAYWDkYLpUK4o9KsCA8W6LPUvpRmPn8r7XKMdgN9c0T1rLGnIcZcWWzFf7I/DYXnumRrO3vjO6yopyn0JQomVJ+w1sUGaFgVGZDj11JroA518uS84bhHhEaVFsAfE14pvtJY9BNnekXzDYzjn3wjh7YvNzUuL5WVu5cZG2+r1LtzAI9cv7ZZIbOtB3trmGS3cbBp25szcASiO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ+MdgYzAtpKhQbTtvcZ0OMf51Yuzt+wJ399QyJiJG8=;
 b=FBCJH9wjuUxliCf3V1ZClG0GvFjmiE1gIl/8WoNJVLzxJZEDSA6kWkvxHmnOBv67fgtihiv78jJDf+g4FnUi8of/B6JIxJGW7Wr9PFpENgSHIyGIxPu1guSWtr+5om1b3nak8KO0WUwusIFpdtrGAQWQNYme2LSA/kzH9NXaQaoNDXlKVkOkc39HapysS3hE5FuvN+AdicHcE52gdyJs5SvCSzsP8eyT7708D46uQyi67v1Pdpl2SADhGYDPir8LjI9lBpw1BqrJ/6iH0AY0YRm0MB/lKW5XqCD+X9bjS/jXHSsbN9vqfcK0v5HGgqAaV2QWdewxP+QbZ/kyeGv9qQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB7165.namprd02.prod.outlook.com (2603:10b6:a03:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:23:57 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:23:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] Drivers: hv: vmbus: Compute ring byte counts from a
 caller-held snapshot
Thread-Topic: [PATCH 3/4] Drivers: hv: vmbus: Compute ring byte counts from a
 caller-held snapshot
Thread-Index: AQFOJEjNF6VkbcuqUxfhl9QR1YCS0QHSF1j7uAOumGA=
Date: Thu, 8 Oct 2026 17:23:57 +0000
Message-ID:
 <MN2PR02MB6863DB8026B1A1C07A8909C1D4932@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
 <20261001221040.1794904-4-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261001221040.1794904-4-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB7165:EE_
x-ms-office365-filtering-correlation-id: 98d0616a-ba47-4a71-de8d-08df2560ef47
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|12121999013|25010399006|13091999003|31061999003|24021099003|41001999006|8060799015|19110799012|8062599012|51005399006|15080799012|37011999003|40105399003|12091999003|2607281247196008|102099032|19061999003|56899033|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u25dVjdSK1uHGqCC+zdsbse9S2EEderuaWPOVnlgMBMnAWHbB176lko3ttmS?=
 =?us-ascii?Q?ZFAy4PJxGnwcSJ7hP2TmlQoQg1Fzs6tOa+MtzitZTWNprRsxwOUQXoA6K2Tl?=
 =?us-ascii?Q?HkyzIas2rGHa/BW8RzMVvQ9mgaGkfznqdrIOICjTHIrg/29BgJU1MuTX2QSi?=
 =?us-ascii?Q?uf6EUocIXwLrHD9KXP4aDqAeWQLq6xT/aGxZV9U/USKeq01vYjff2FQzQRqp?=
 =?us-ascii?Q?2Rvbv/JnpLfpN5uhhP1XMyyXHrQ92ittxduNW+a6MJVmwSTWHSQlIWxmIo9O?=
 =?us-ascii?Q?hibxHTGPlWnf9KCG+L/xWDuNMadhWttWLwZQmHFIbWVLzVn7zX3mYQwKVp7X?=
 =?us-ascii?Q?6fAD1WC9Rf20vSlgE7XtCcP+CKRwFUMZH3gSZvwMqm8RIwpvpLEEL6ldWJoO?=
 =?us-ascii?Q?fVYIyAMdXmgqV1ETOjTJPuKHnWrS09w1KCQioyrXsKM7uDQQwI/XJ3fUnbcs?=
 =?us-ascii?Q?GNhVoubh5G+QMHRN0YIM3PKPlpvhYPysPA9sFIBQPEXPpFR+AuexzL7f8bzK?=
 =?us-ascii?Q?UyKvxj5J2r5PXHmM19NQQjoyx6OpzS6qGE9ensmR+tU+x4Vg3qq4WFIZ8vrX?=
 =?us-ascii?Q?HuE3WJtVSgyXa1FOHUw+3PO1xbqz2bv+ZRResgT20VFE3eacDsisOUGmtADd?=
 =?us-ascii?Q?lg4i5LJkxfJ9utN13SUusIpoZqi+wGvHqiXeB84ghnMxFS2DwGVtkAYnUEG2?=
 =?us-ascii?Q?PsrSqiJNnFNj+mlzJKcRYvBGxfF7dDwDvAyXJ3pgDC5Jp1xVu8HP9CnOvXEb?=
 =?us-ascii?Q?CJHKL6K8SYwd/roik5igBwt0Q1Rj0ZwQERTN3M1fYTKxal7AjVL7g8jrD6QU?=
 =?us-ascii?Q?uXCzkHiCXpQkpSffd/dclJzN4Iocq1dGDqe09QLYn5QGuoKPiFuGNx9Cl2ZE?=
 =?us-ascii?Q?a+ZpdZ3pO4FbIMVhgC/PDhSRI4pIJfmUy57LXjdOMl2/11pHXWCAn9ZONk2e?=
 =?us-ascii?Q?W5W19YgFyyesgvSavkTpUoehNp5FRphMQYjzIHypsYuk2LJs6uOge6wDE+ME?=
 =?us-ascii?Q?AHmpLBKDYE9pbu4/0ZnsoDnttCBphvQ9DjdHMez2zD8f2ol5MCgGk8ZJJyqs?=
 =?us-ascii?Q?Gyk+YPkounVjwkMrYMPzrCGiYhX5v15a5CLVcWw3IupwXUBR5MLPm9gsil0J?=
 =?us-ascii?Q?5g3oZlvXKQXN7vfqg2i0QVyQIHuSy0tBxB6YS0VuqzqYPyiAiSkGXP4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cfGG9ZZ0YFpmrbV5UbJiRSTxRxEEe3NH2fxYNUOiJa9zSLgeuQ7IXmLNCKwK?=
 =?us-ascii?Q?dm+Pff+R0RmWDOPPFTKJUBkmx1axWtk6AX5bgsnhtvwQpcOfNCttoZ4sDpQ4?=
 =?us-ascii?Q?pKjUMxUD2ed5FHOrKh6xQIL4QDfrWYP6l0uAWQVrOIs3Vj6ALHQ/EXXRq8Cf?=
 =?us-ascii?Q?7eDkiwKdOJEZ5Xe2cnCI4C8HM6eb4REkLXD2qp1BbqMZQg32BJvV1uuo9xAs?=
 =?us-ascii?Q?H5+3KHUhbsUYNH1V//18+uOYfugKjCsmZhEDbzZpVLuxmHXXD8rl5mtI75y0?=
 =?us-ascii?Q?1oOwFaEbz5q6ODpHLSxqKuTEh0F924gzF+YHT/bx54wFAjKAyeM7z3zoGZjM?=
 =?us-ascii?Q?GH6i0++NkHPJT27gpjjUp2wMSfSIy2VWRHc4QcRSIxcpDh31L6lRHp+1R8U/?=
 =?us-ascii?Q?9KTtzJiPz+rqwuu2BiK2zAyqE+5fmt4JD8pbprMl1jDfJOYjwOfuh4LUdizT?=
 =?us-ascii?Q?YDZcUgWHUoZK5A3vTxp3vZpTvyYAHMczRwrTAlNvN85RmGyWY73cJW4UYoQ1?=
 =?us-ascii?Q?EywPW8UlHCgcYqEPzT9RQI/i1yrNKVIFycPLB4Z20mAvZFnoIX1YjFazfoMR?=
 =?us-ascii?Q?5SjkoPPuGm1c4is5TKgoNPbEDCk8BDUpUZXnThYZQQmKhZHmFLm0+wZNiVDT?=
 =?us-ascii?Q?rC73WEX8MwQT364yxTn8SIYh5Ohm9Km/3iRgEUjZ55z6Bh3zJMezGNqViY4O?=
 =?us-ascii?Q?f0gLPJ8QD/hbGK1gK6xPoGxJHDmGTvTDm5gD2QgSEImf4oqRVyRpdpRkJfWp?=
 =?us-ascii?Q?UkFXmQ7OQ1uvYWuzAoaVooCr0z7+CQoOB3yotl3q7MxRqgnH5yKUGA8zKjnk?=
 =?us-ascii?Q?wXvbweZuBcD8rpr9TRLjSu3FLiVaUGFgw6b1K2IsErSY2ObBXJcDy+1YNcTc?=
 =?us-ascii?Q?G1NzlOd9bHc1za60fzNfdJtL1qvGeaTcKXnMAItBNtLn7lkDTWgRxxI7Teg9?=
 =?us-ascii?Q?BobRjycPsk6FS4u0bnpOl4bC/4+hIlSbOrw/dAd7r9B39aHPySf3HiT+wpBI?=
 =?us-ascii?Q?ILRWP55IKKSQU/xU+8JCI6ziVZep1kl5w8uqN+SGnBBJwRZpVBzZ7WvKuLvj?=
 =?us-ascii?Q?KrlpO0tBwQ6hypkNLFWHj+nMh5hd+ow5Zukpuaz6j/csszwte9gojgAD7Lqx?=
 =?us-ascii?Q?4bQus7Wpt7DznBm1yk7rAUL2VBHN4UCmOQLpcFtdPWzuB/ECL6kq1Ow5/k59?=
 =?us-ascii?Q?76Pcl1VVpWP2VMKK+7ds5i2drCSVxL+XAm3E7N8UkP/C52mlHKkWponTFktG?=
 =?us-ascii?Q?LMlkz5VkJZ0r5toMGBBYIEMVzcxplQbkkIT7LtOItAGIptnrn8RbNxF4ApFV?=
 =?us-ascii?Q?GXcWr8EZErhQr8YrhAok/W6WJHI1YUwOgeeTl8/4sP1kO4kTojZhdBCi1AvX?=
 =?us-ascii?Q?jPIqLio=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d0616a-ba47-4a71-de8d-08df2560ef47
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:23:57.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7165

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, Octobe=
r 1, 2026 3:11 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;=
 Dexuan Cui
> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/4] Drivers: hv: vmbus: Compute ring byte counts from a =
caller-held
> snapshot
>=20
> hv_get_ringbuffer_availbytes() reads the indices directly, so a caller
> that also wants the index values has to read them a second time. The
> host can change them in between, resulting in the byte counts and the
> indices reflecting two different states of the ring.
>=20
> Replace it with hv_ringbuffer_avail_write() and
> hv_ringbuffer_avail_read(), which take the indices as arguments and
> return a single count. They are separate because most callers want only
> one of the two values. Use them in hv_ringbuffer_write() in place of the
> open-coded equivalent. hv_get_bytes_to_read() and
> hv_get_bytes_to_write() duplicated the same arithmetic, so put the
> helpers in include/linux/hyperv.h and use them there too.
>=20
> Add a hv_ringbuffer_index_valid() helper for bounds checking and use it
> for the checks in hv_ringbuffer_write().=20

With all patches in this series applied, there are 5 places that
hv_ringbuffer_index_valid() is used. Four of those places check two indices=
 --
a read index and a write index. One place checks just a single index. I'd
suggest having hv_ringbuffer_index_valid() check two indices instead of
just one. For the one place that checks a single index, just pass zero for =
the
other index. And flip the polarity -- make it hv_ringbuffer_indices_invalid=
()
so that it doesn't need a "!" in front of every usage. (For me anyway,
that's slightly less cognitive load when reading the code.)

This is just a suggestion. If you prefer to keep the code like it is,
I won't object.

> Convert the remaining callers
> to use a single snapshot:
>=20
>   - hv_ringbuffer_get_debuginfo() now reports the indices and the
>     computed byte counts from the same snapshot.
>=20
>   - hv_pkt_iter_close() computes the free space from priv_read_index
>     instead of re-reading the shared read index. The two agree unless a
>     misbehaving host has rewritten the value.
>=20
> No functional change intended for a well-behaved host.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Regardless of whether you want to take my suggestion,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/ring_buffer.c | 63 ++++++++++++++++--------------------------=
------
>  include/linux/hyperv.h   | 48 +++++++++++++++++++++++++++---------
>  2 files changed, 58 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 7f466c5..29edab9 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -107,35 +107,12 @@ static u32 hv_copyto_ringbuffer(
>  	return start_write_offset;
>  }
>=20
> -/*
> - *
> - * hv_get_ringbuffer_availbytes()
> - *
> - * Get number of bytes available to read and to write to
> - * for the specified ring buffer
> - */
> -static void
> -hv_get_ringbuffer_availbytes(const struct hv_ring_buffer_info *rbi,
> -			     u32 *read, u32 *write)
> -{
> -	u32 read_loc, write_loc, dsize;
> -
> -	/* Capture the read/write indices before they changed */
> -	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
> -	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
> -	dsize =3D rbi->ring_datasize;
> -
> -	*write =3D write_loc >=3D read_loc ? dsize - (write_loc - read_loc) :
> -		read_loc - write_loc;
> -	*read =3D dsize - *write;
> -}
> -
>  /* Get various debug metrics for the specified ring buffer. */
>  int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
>  				struct hv_ring_buffer_debug_info *debug_info)
>  {
> -	u32 bytes_avail_towrite;
> -	u32 bytes_avail_toread;
> +	u32 read_index;
> +	u32 write_index;
>=20
>  	mutex_lock(&ring_info->ring_buffer_mutex);
>=20
> @@ -144,13 +121,14 @@ int hv_ringbuffer_get_debuginfo(struct hv_ring_buff=
er_info
> *ring_info,
>  		return -EINVAL;
>  	}
>=20
> -	hv_get_ringbuffer_availbytes(ring_info,
> -				     &bytes_avail_toread,
> -				     &bytes_avail_towrite);
> -	debug_info->bytes_avail_toread =3D bytes_avail_toread;
> -	debug_info->bytes_avail_towrite =3D bytes_avail_towrite;
> -	debug_info->current_read_index =3D ring_info->ring_buffer->read_index;
> -	debug_info->current_write_index =3D ring_info->ring_buffer->write_index=
;
> +	read_index =3D READ_ONCE(ring_info->ring_buffer->read_index);
> +	write_index =3D READ_ONCE(ring_info->ring_buffer->write_index);
> +	debug_info->bytes_avail_toread =3D
> +		hv_ringbuffer_avail_read(ring_info, read_index, write_index);
> +	debug_info->bytes_avail_towrite =3D
> +		hv_ringbuffer_avail_write(ring_info, read_index, write_index);
> +	debug_info->current_read_index =3D read_index;
> +	debug_info->current_write_index =3D write_index;
>  	debug_info->current_interrupt_mask
>  		=3D ring_info->ring_buffer->interrupt_mask;
>  	mutex_unlock(&ring_info->ring_buffer_mutex);
> @@ -282,8 +260,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>=20
>  	read_index =3D READ_ONCE(outring_info->ring_buffer->read_index);
>  	old_write =3D READ_ONCE(outring_info->ring_buffer->write_index);
> -	if (unlikely(read_index >=3D outring_info->ring_datasize ||
> -		     old_write >=3D outring_info->ring_datasize)) {
> +	if (unlikely(!hv_ringbuffer_index_valid(outring_info, read_index) ||
> +		     !hv_ringbuffer_index_valid(outring_info, old_write))) {
>  		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
>  		pr_err_ratelimited("outbound ring indices out of range: relid %u read =
%u
> write %u size %u\n",
>  				   channel->offermsg.child_relid, read_index,
> @@ -291,9 +269,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>  		return -EIO;
>  	}
>=20
> -	bytes_avail_towrite =3D old_write >=3D read_index ?
> -		outring_info->ring_datasize - (old_write - read_index) :
> -		read_index - old_write;
> +	bytes_avail_towrite =3D hv_ringbuffer_avail_write(outring_info, read_in=
dex,
> +							old_write);
>=20
>  	/*
>  	 * If there is only room for the packet, assume it is full.
> @@ -568,6 +545,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
>  {
>  	struct hv_ring_buffer_info *rbi =3D &channel->inbound;
>  	u32 curr_write_sz, pending_sz, bytes_read, start_read_index;
> +	u32 write_index;
>=20
>  	/*
>  	 * Make sure all reads are done before we update the read index since
> @@ -607,11 +585,13 @@ void hv_pkt_iter_close(struct vmbus_channel *channe=
l)
>  		return;
>=20
>  	/*
> -	 * Ensure the read of write_index in hv_get_bytes_to_write()
> -	 * happens after the read of pending_send_sz.
> +	 * Ensure the read of write_index happens after the read of
> +	 * pending_send_sz.
>  	 */
>  	virt_rmb();
> -	curr_write_sz =3D hv_get_bytes_to_write(rbi);
> +	write_index =3D READ_ONCE(rbi->ring_buffer->write_index);
> +	curr_write_sz =3D hv_ringbuffer_avail_write(rbi, rbi->priv_read_index,
> +						  write_index);
>  	bytes_read =3D hv_pkt_iter_bytes_read(rbi, start_read_index);
>=20
>  	/*
> @@ -627,8 +607,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
>  	 * Exactly filling the ring buffer is treated as "not enough
>  	 * space". The ring buffer always must have at least one byte
>  	 * empty so the empty and full conditions are distinguishable.
> -	 * hv_get_bytes_to_write() doesn't fully tell the truth in
> -	 * this regard.
> +	 * curr_write_sz doesn't fully tell the truth in this regard.
>  	 *
>  	 * So first check if we were in the "enough free space" state
>  	 * before we began the iteration. If so, the host was not
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 5c65820..9d7d09c 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -209,31 +209,57 @@ struct hv_ring_buffer_info {
>  };
>=20
>=20
> +/*
> + * The indices live in memory shared with the untrusted host, so check o=
ne
> + * before using it as an offset or to compute a byte count.
> + */
> +static inline bool
> +hv_ringbuffer_index_valid(const struct hv_ring_buffer_info *rbi, u32 ind=
ex)
> +{
> +	return index < rbi->ring_datasize;
> +}
> +
> +/*
> + * Byte counts for a caller-supplied snapshot of the indices, so that th=
e
> + * counts and the indices the caller goes on to use describe one state o=
f the
> + * ring.
> + */
> +static inline u32
> +hv_ringbuffer_avail_write(const struct hv_ring_buffer_info *rbi,
> +			  u32 read_loc, u32 write_loc)
> +{
> +	u32 dsize =3D rbi->ring_datasize;
> +
> +	return write_loc >=3D read_loc ? dsize - (write_loc - read_loc) :
> +		read_loc - write_loc;
> +}
> +
> +static inline u32
> +hv_ringbuffer_avail_read(const struct hv_ring_buffer_info *rbi,
> +			 u32 read_loc, u32 write_loc)
> +{
> +	return rbi->ring_datasize -
> +		hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
> +}
> +
>  static inline u32 hv_get_bytes_to_read(const struct hv_ring_buffer_info =
*rbi)
>  {
> -	u32 read_loc, write_loc, dsize, read;
> +	u32 read_loc, write_loc;
>=20
> -	dsize =3D rbi->ring_datasize;
>  	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
>  	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
>=20
> -	read =3D write_loc >=3D read_loc ? (write_loc - read_loc) :
> -		(dsize - read_loc) + write_loc;
> -
> -	return read;
> +	return hv_ringbuffer_avail_read(rbi, read_loc, write_loc);
>  }
>=20
>  static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info=
 *rbi)
>  {
> -	u32 read_loc, write_loc, dsize, write;
> +	u32 read_loc, write_loc;
>=20
> -	dsize =3D rbi->ring_datasize;
>  	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
>  	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
>=20
> -	write =3D write_loc >=3D read_loc ? dsize - (write_loc - read_loc) :
> -		read_loc - write_loc;
> -	return write;
> +	return hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
>  }
>=20
>  static inline u32 hv_get_avail_to_write_percent(
>=20
> --
> 2.45.4

