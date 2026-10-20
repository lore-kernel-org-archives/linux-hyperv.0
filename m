Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519580;
	b=4II/dHsYnYj1mQ0X9uRcVtIEZ/h6hsYLM9qQCANu5BB28wtQ56cavNmoEIdJamGiFgOd
	 2uNneW8cvGAVzsk7nuAqAJAT5L+yneQixbNJ28WiZ+Ey04dbZQWleINDHPuUf/C/TJYtF
	 SyDSVI8VySDGGw6XENZnkDnk4xsPS4EAtsIUhXQGnCsYPM+vbZPl3ac8aNXIyRK4tLflZ
	 mGGXoy075wVwmDT5QZqTR2JmlhehaFo/Gcy0BuSyHys9mOf3XBfllN3578U3jFPSi4EwI
	 pRv+NXnotVjf+91n/9/CjuvDyeOFTF4cWt5ga2Y5Ur5fofGS56lLUlVWCaKd7Wnrbkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519580;
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
	bh=DiJMhRCrfDaacw3dIifFDZrjGWdBDDeK3LfuR3NRnks=;
	b=qgSoZ/POuBd3HSaqSWmJEsE1KLI8afHnruI9lupiFmHRQc820Q4HT86boylRJcBpof1d
	 rvbRcvTLWrWFDT+0q15M3UWccjDzVODjqzqlqoOWLbVneXzpI8bp3v+tlSS1rOLNSfD9K
	 RmU8gGQofOXQFvy+Bhb02UZxAikgdJLKX+lzKcyV3J8DNKe5YTHGOL9+4x9Pd8snAP+v9
	 xe5jJaioEXTHLgbgaz4jvfJ911IiRSfIccMLNm1+/p+WJBzqJXfiURS/leUjcmzSSV3wU
	 k46xEihQ5e1T5HITzvgL3tFfo93YVWmE6OdmsaLB594P0qDdlmssEhwlPtcjghLrX2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fkPPrCCi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.83
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013083.outbound.protection.outlook.com [52.103.7.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A2606A319;
	Tue, 20 Oct 2026 18:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662A2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fkPPrCCi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C759RP5e+SBbVs8LLxsVjBWk7MKTbd+/VgCl+hHMDeEMAhUml4vdyoyZx9bJYcompMQX71rc2eOBIME2dhFpMqzpWtzE+LfbqdwbPKpgLfGHqRK4aAGLdZRFkoGtXFkRpmq6SMndqJPOEGlUNYiHNrG7u9KUdgz4oyXt71McAAkQGKn+SK4i4UPq1mxfj8Nx1u/7uU/nnHOMRFUP6FtwJ3am3pfCNsycnFRKz+jVS7YQIA8poJxw+v1pg/JYCg8PMldsDnuqegOwfYWqXGfGaGQ8vEQKFEc+bfxCkQwFMys3gKsh2wXFqcqDzn9T1DM7QK6maiYHNSgmuay9r5wPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiJMhRCrfDaacw3dIifFDZrjGWdBDDeK3LfuR3NRnks=;
 b=olG5x/EDu5l/RQ+2VvprF7uuSytfNSr50Pp5EsIQpu/W5T+emIgeaqsSDMm9jMOFv9Ifd8IJAFcnuCUd6zC0VKOzsS1+FjFDnrmfNnUMR47uDyqg4nxkkWL/GPoTQUSp9/CNUHrku2Ep6AjZ/eYjs3TeGNMuNaufuNxyZfZLO/sc3xwG2lWSeKYaPsw6yZNbiyQpBdjHkuZ3lCE2fwtImrpbqC0IJtTm2ru0t2I3OKUULHR4cpZJn5SGb2w/cQ4gzgRoRFT4BRKK0TdOIokwr3kK/6wyhhG8UdRgxFdsFC9+IY2QkDaNwvWqLzMRlXizUeRP/124xW76TbBcaXKkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiJMhRCrfDaacw3dIifFDZrjGWdBDDeK3LfuR3NRnks=;
 b=fkPPrCCiwo2EHduzar85ohCAXCsZuERcUfm4cOmAiPOsaCBgGXWH/oRzcXZOiPWahCrkCR3dUqLoEoAfZK1d4tfjcfB2hHNmWueMx2lJ5nSG+3H73TKU995Ibw0D7JdtgDeYBCtvxH1xzP0mnUoVj50N5rJ0U1uPBf084+hk0UHnIpmAZ4b7zYyo1zS7CFkLQf3wPVPrHtSfi2y7jGtJzzSj9TFAsFl7h+kk1r4rBhvXAVoOJTyuiVxJiOWdUKPK3B+cYCPHeJE8XlOeONkhdTnZfx1PxmJtup6+HQs8pHslyZUS/P9FFOU5m4yWnluJP9k+DJZaxXliUc206fbVYg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by MN2PR02MB6928.namprd02.prod.outlook.com (2603:10b6:208:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 18:04:11 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:04:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] Drivers: hv: vmbus: Compute ring byte counts from
 a caller-held snapshot
Thread-Topic: [PATCH v2 3/5] Drivers: hv: vmbus: Compute ring byte counts from
 a caller-held snapshot
Thread-Index: AQHdYB762f4L4uaOX0uJste68Gd8rbcGupBg
Date: Tue, 20 Oct 2026 18:04:10 +0000
Message-ID:
 <MN2PR02MB6863B5BB274EC29FB15862A5D4672@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
 <20261019230950.1573677-4-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261019230950.1573677-4-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|MN2PR02MB6928:EE_
x-ms-office365-filtering-correlation-id: 63660497-e22e-44d6-cdaf-08df2ed48ada
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|51005399006|37011999003|15080799012|13091999003|8062599012|8060799015|19110799012|55001999006|24021099003|31061999003|25010399006|41001999006|56899033|19061999003|440099028|3412199025|102099032|40105399003|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dC94RUJ8I8to+oMhMZJ7WSEvUqLFrwIJaaPbYQai1ZvXwSoL67RFdjtvHKIl?=
 =?us-ascii?Q?ahHa+f36omHrGFk/0i0kWk/pcPmjsOBdi3th1kQW4n1BiC4xEDsrCWVzsaRE?=
 =?us-ascii?Q?P4Y6dW5dwaI/AC180cHdekGt1FpvKhme6IvRcq/Be+7Wx1JxXySXf+uUtRig?=
 =?us-ascii?Q?e9GEceZprX12rzK6JEBXdYajIDIO5QIq7go3xwdKj5bxlEODL1gfMU87qyyu?=
 =?us-ascii?Q?2v98o1r1iGVmsMvQs1BjHFtAbWY8+1FgSf5gXITo0LjJg+h3Hq2v2OXIyKaC?=
 =?us-ascii?Q?tYycfhXuKs+6Kis4NKoEHhjDBvCISwmEv9r4Zs3hvNY0aYlMoiOgdlpDhZx9?=
 =?us-ascii?Q?IwJ3NzHh+gR3NDxDyP6hvlWPhkjdSR/E1oaGRVBRAIHrtMIGn9ca0age3AeS?=
 =?us-ascii?Q?zSC+5wgk5ijt1/Kb74WzBb7LZwzeP5As6dGObHdccwIPIX/fhkZEnKzNnlDE?=
 =?us-ascii?Q?mCc2fQhp2oMe8Wr11WbZFL5sy0xkBwT6Y/6wWkROoKq/Yw/sjwZeoeLVaO1j?=
 =?us-ascii?Q?+WT6y+LU279KcJM31O3LHaCgbPcbxVEEriETDmr1ryVrDYfysAZnNRFXdGjf?=
 =?us-ascii?Q?4YbWXcscRkqVKUXf6krCEl866BoV8g46PGdYVbhkdrgu6CBeUbJtnEZmxQ3S?=
 =?us-ascii?Q?y7Kpa5Up9mx+Gm+eS7Zdfp4yDz8VliVNqtibeKIUMdMf+Od+KNbUzkhegkWO?=
 =?us-ascii?Q?4pNFFED40a8n2eQjGc/Z3Bij8GgLno1oSFyOzmE2WLX60OCbW2dge7mos85Y?=
 =?us-ascii?Q?Z+JXXo1u44hjQhq3S8h9AQGtyxudKZR3vsxR63etmvHDHjsMFLKnI8+K9/Iy?=
 =?us-ascii?Q?0cLpH+U7fJsyfUfbzhvVpDBKRW3SZQeWGpc53QvdgTqEiv41JmuZ+rvPaeR5?=
 =?us-ascii?Q?PEtJ26/uNUWkLyjxLLA9hhSjK7TDSqEqG3KTDjKOGa6QYPeB1DODCwksKOVX?=
 =?us-ascii?Q?nW6dvmNxsV4JaBu3U/IyWX+XqPWRI/r85XL6x5s7r0aaoz2dTtUH2ykMNow5?=
 =?us-ascii?Q?1ifdZ+HVIYwtTddswpZYIwAV6dvQArbE3tcz/ZudjDfLbBFLjYtrTWHg3Xuy?=
 =?us-ascii?Q?2jS8dREyjCiPKGFa+0WoSNbBAkQM1z4ijLfuaHzXf8F3YS0rQpn26rZLQNrL?=
 =?us-ascii?Q?fZtRj1s778HciNrEJMmYbq1YHQBVVgORJhtuiwVRlPSoHG2XWfMW8+9w2wR1?=
 =?us-ascii?Q?LfSOrfm95hJ9w8cC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u1WHoogcLnlddPXG0F7oyxbBcRFE2wp3HctnDKRvHLeQEhptwhReJXNXhxRW?=
 =?us-ascii?Q?Jt96qgUNCdhmCc53IY7JXP1LlK6cGTWP1otF3hbg7FLlumY3+PU+DZIBGt+w?=
 =?us-ascii?Q?k5EhjEibuRBIFZzqQ7FmsalLzOY96jkORHmpYz2QM3dJxuXSa+z9PwtyxXrU?=
 =?us-ascii?Q?+csJf6MbuLYBMcWqDKbWTnVRO+JZTNB0ws4c9S+979osa4K1UfTqSAnDvti1?=
 =?us-ascii?Q?dB1pf2yqZGpf4ITEOEQaRQMWYV2jIfTmnj9aSsCJS3Iap2jVEzwgLNrx8W9A?=
 =?us-ascii?Q?f28IFuPnMsCSzcTrHe9AdZhCgSt2tsPHFvqikbj0mMZsM24H93w++iVekWi3?=
 =?us-ascii?Q?TmGhVDephirVwFCFFcmlGMPyB9ZD5XlmWde9gvTd6J5cvqmem830gpfLnVww?=
 =?us-ascii?Q?6um7iKJU8laBEOxdrEbRjKl5dySrydY0UbjkiNGb+L1XkSCZ07BZr54zWtwV?=
 =?us-ascii?Q?sEYqpgN+ptD6AkPknSoH72YLbCKShIxiX36LFM/eVV3DP3dSsNuA2i9JBDeQ?=
 =?us-ascii?Q?kkUrneXIlYo064OMIw3PUl4Qz7Eu/Ceo+4HL4j1Hb7xm0PlGSby4yPtjiZ7H?=
 =?us-ascii?Q?tPP1Htp2pCs20Dgax+Qy2gpTz6b94bsfH6Q65EHn/gBqPTvwr3bU0ba+ZEEY?=
 =?us-ascii?Q?Hx6AK/rkv9pCy5wC3ucSq0AOnGY2mWFBVfoyEwOFfFt0DY2GIMl44JVxI4ht?=
 =?us-ascii?Q?fI/yWpXjSRcD8HpT6xGEZD7cO76180WU1toTDgmDodrjWOoVjQoXCx3Hu/lW?=
 =?us-ascii?Q?nIvDoQg3kIFF1HNd5MuYSvojvN0ivWbKCv0a4cjq1IT9LUULW8YSY8AjLUGm?=
 =?us-ascii?Q?ggdbSYx7p1v+A39FLmM7Szvg1Opc3NGimcY0Pgos4102xUnHJvsDlsUbviJB?=
 =?us-ascii?Q?Tndab+4xfEEcSBXs3jTVh/al1RpLTAbdXSOhZXs6n/uIoBgyKvs0Gk9Wk31e?=
 =?us-ascii?Q?SbjnbaT/+UwUFpkgrhJoRowui21ywEXkCNnanyotnUpOw5Qz4TDIUYgZMurL?=
 =?us-ascii?Q?WgHEzIfEyKw7ADY20zOqmWrCXMsXN/N/e6e63B1aBV1l7agkN3HHq2tJiLpH?=
 =?us-ascii?Q?MREiLImltXS6vtJ3IPS0iZv3GlMI0hnB80CSnfX5q0fUASJBtYa8JvINKu2K?=
 =?us-ascii?Q?o0W68p8CZygN4p4zTqn0EAlSadvjR7y3bfGF7XUH1IUFFlqXK24PVHzHKAwl?=
 =?us-ascii?Q?EV1Q26f/7+GPibDIPFoly2QB67gjm/KkN2IvgpacjAJqoyhaPfI+J3WPnU5M?=
 =?us-ascii?Q?Yke8RhYRKbNbC9pUcSnWIEWpPUM5JYAqNDGdgKQY7jv7XWZukS81KTM7Q68i?=
 =?us-ascii?Q?J86ighdTqeY1gF2U9zRhqe8bI6LFnsjXxUmRlbCW66//x5yBkrECiiAB61CS?=
 =?us-ascii?Q?kMnPm48=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63660497-e22e-44d6-cdaf-08df2ed48ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 18:04:10.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6928

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Monday, October =
19, 2026 4:10 PM
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
> open-coded equivalent. hv_get_bytes_to_read(), hv_get_bytes_to_write()
> and hv_pkt_iter_avail() duplicated the same arithmetic, so put the
> helpers in include/linux/hyperv.h and use them there too.
>=20
> Add a hv_ringbuffer_indices_invalid() helper that bounds checks a pair
> of read and write indices, and use it for the check in
> hv_ringbuffer_write(). Convert the remaining callers to use a single
> snapshot:
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/ring_buffer.c | 68 ++++++++++++++++--------------------------=
------
>  include/linux/hyperv.h   | 50 +++++++++++++++++++++++++++--------
>  2 files changed, 61 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 7f466c5..cda957d 100644
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
er_info *ring_info,
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
> +	if (unlikely(hv_ringbuffer_indices_invalid(outring_info, read_index,
> +						   old_write))) {
>  		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
>  		pr_err_ratelimited("outbound ring indices out of range: relid %u read =
%u write %u size %u\n",
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
> @@ -445,10 +422,7 @@ static u32 hv_pkt_iter_avail(const struct hv_ring_bu=
ffer_info *rbi)
>  	 */
>  	write_loc =3D virt_load_acquire(&rbi->ring_buffer->write_index);
>=20
> -	if (write_loc >=3D priv_read_loc)
> -		return write_loc - priv_read_loc;
> -	else
> -		return (rbi->ring_datasize - priv_read_loc) + write_loc;
> +	return hv_ringbuffer_avail_read(rbi, priv_read_loc, write_loc);
>  }
>=20
>  /*
> @@ -568,6 +542,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
>  {
>  	struct hv_ring_buffer_info *rbi =3D &channel->inbound;
>  	u32 curr_write_sz, pending_sz, bytes_read, start_read_index;
> +	u32 write_index;
>=20
>  	/*
>  	 * Make sure all reads are done before we update the read index since
> @@ -607,11 +582,13 @@ void hv_pkt_iter_close(struct vmbus_channel *channe=
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
> @@ -627,8 +604,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
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
> index 5c65820..09f25ad 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -209,31 +209,59 @@ struct hv_ring_buffer_info {
>  };
>=20
>=20
> +/*
> + * The indices live in memory shared with the untrusted host, so check a
> + * snapshot of them before using it as an offset or to compute a byte co=
unt.
> + */
> +static inline bool
> +hv_ringbuffer_indices_invalid(const struct hv_ring_buffer_info *rbi,
> +			      u32 read_loc, u32 write_loc)
> +{
> +	return read_loc >=3D rbi->ring_datasize ||
> +	       write_loc >=3D rbi->ring_datasize;
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

