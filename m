Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519494;
	b=2ddqmHHrgabK9gidjszwUJt0Gxw8pU44BwuPJrkpVuXULBWm005nMPWjSWva5HjZnkGr
	 kk3vrCHzrc7+hkscpwsdRMNC/pY98ZiP50hLLldaYCMuo/sFKN0pvkai/7cK0+ypkdMf+
	 3zSOke4g1eykJzJIXcyU1W2M7+7E6nZJBeABMby7YEQo7UT3lc0HBeO3yGYPAzLHIBlg9
	 zAbwmlTB26G0+bP1aCOUiXKt4WmckG8EubD1if8w0BWFnhd9AAysnoR0TWrsvR8YK0AD0
	 qzLmrfo9FzbiUrLcZCrfjy/+nyDjTVelumRJWAiBjn5+NvR4Qo1l/5a95YKAOAD4zEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519494;
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
	bh=zjPIhdAqbtIQro/3Ddy1Wdx85aCBQ8owC35Rk0sdxtM=;
	b=1MdYLMJXfn2uozxPJCenEnWQbu5tzUVOOUUrVg6j5XkMzxCBC2hKBiGkDO0NIRySRMad
	 j3amVI9ttTAWREciGlpOuqloZEKVvFtyBT+1ugPO/UPZhasAzS8FMQT1QnvvdCVegX+lD
	 C6ip/KLaYuy4WwACDVsgGv1taTw4R/sbBJcmnjh3fsPoEd7hNUj7cnFuSKt5FJn7fY2Xr
	 u8o7N98qkrmWTnu48qv/2Zh/sQM5edzhjzvo/0IAw9SRQ2okMIZzG26Ulx40+oOShTWWM
	 g7guXxgg678QvSiX1IH1ByizIh7w7zJeOA7LU5NDyUVvIdIv/BmlPD/Q320v122qWVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ssUPEOaG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.78
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013078.outbound.protection.outlook.com [52.103.7.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59E606A31E;
	Tue, 20 Oct 2026 18:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A59E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ssUPEOaG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7m/gU7SDXHTI19d+2nX+7J88JyhOPWJIwIocjYe9fLoAL7XKym++ByeJ4HPtVrzZmm8U2U4dB3nH3qJGo8zzFGbJEtwhLXlrZO5/cRGyN/yunjsmEzwf8iMCT6HvoLEQiJDKKwFf6oVyuEC549lJqCK1jKYqVwKjTtFx9bKjyc6DwA5l161kMdRgdb0m9z9ZNiv1P+ZrtEupfTsD5yHVTQchZUb3WVoT6AOdQ9fDWsSGSH7lfVfpSxk7TVj5pee4OLu37gVc88DB4Cx21Z02DCTFSmMopeg5YD/3dDf+RtG9TGitoAWCGAsXrYAvn5FuTgXOfHwzz27U9+Y7uLHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjPIhdAqbtIQro/3Ddy1Wdx85aCBQ8owC35Rk0sdxtM=;
 b=C863syWieTFHME5dDABc51R1i9dtZrs1qg9wKyv6K3Oe8slJ5o9k5E2tPVv8d98Lpdkp3/sMSDtQxGgh6Im252JXPXCkcCfcoGrmuI0FAezSMnmiHlevvlRXYoOWAKGNfPQIHhf4I2z6IRsTC2Sz4Fq9k/2OOFtYajwCsxWhZ1vSuvILXctmTn/XuLPm1IQ5j0KPEPplMUaqE5ao+sG9qGiiHIP/ve1UNNwpVi//X/DMDGFJ6ci7JSgh+dXyqp8N10qgfW++SENvE/CRdUjeGz8v2SF898r3JNNXECMo9zyzPfWlDCAV911wSItU6DpEDOfmkNENFUi1y4ZhgJeieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjPIhdAqbtIQro/3Ddy1Wdx85aCBQ8owC35Rk0sdxtM=;
 b=ssUPEOaGGJl6Gj9x7DuLcNcpzmp8o/NisEHmjVCMYHl+DCD4R24Acw6Eo+RvlxmWP89+spMGMj7JNPZMxLSNd3LG0oCWDyK9nSyDmunmcNLNaPQwltIbd6SS/359O1YjcN198F3pLnUqW8jtsUNyhifE1sMkZCmyuJaN+YXMW1R4tMElWL2k2Z+tT/abrsYmkgCKfNbUYPPObp8mJl1pv3SPBwecb+ByBtc8lBsah4PTkVd2x7Q7ZoWCNgIy2vbIVG0clXtFgxVV1vj/IPM1ucUIauOmvpNNepirmrntBgNQzU0SWpb2pbcZSUGxKKELhgD2alICMnz0xy6Xz/TDIQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by MN2PR02MB6928.namprd02.prod.outlook.com (2603:10b6:208:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 18:04:20 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:04:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] Drivers: hv: vmbus: Keep the ring byte counts sane
 for a bad index
Thread-Topic: [PATCH v2 4/5] Drivers: hv: vmbus: Keep the ring byte counts
 sane for a bad index
Thread-Index: AQHdYB77wX636uOSAUucEquqbpZb3bcGupxw
Date: Tue, 20 Oct 2026 18:04:20 +0000
Message-ID:
 <MN2PR02MB68635749E43264418EC2DB6CD4672@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
 <20261019230950.1573677-5-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261019230950.1573677-5-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|MN2PR02MB6928:EE_
x-ms-office365-filtering-correlation-id: 18d21e00-2374-460f-4192-08df2ed49094
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|37011999003|15080799012|13091999003|8062599012|8060799015|19110799012|55001999006|24021099003|31061999003|25010399006|41001999006|56899033|440099028|3412199025|102099032|40105399003|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1jAklFS4UQLGdSCX/FyRtsf0zb7ZR0RKIJhoHwLlpQ4HM9uN1XffKrC85ec4?=
 =?us-ascii?Q?4ELqwhbz6E0sm3JU2YShpTeekr5vElirhQYjBGQGdADAL0b8/Ljegp85IlsC?=
 =?us-ascii?Q?sbmzqUGtSoNfnkT4V28UgNh9cYkbL9a06F/xfU2Q6kHzspsGkHISDodNgG3e?=
 =?us-ascii?Q?vinNCuJx4+0MwYMTslc7kwkoZoby6qcGVxvPdvqUKxgp3AzM5IeKCqS2RFHi?=
 =?us-ascii?Q?6oJUwPzIoMB74kDyEpqhNvNfX/ZrJjgxYUKIejinUGQzagZW1HJJgmxNizvo?=
 =?us-ascii?Q?5bVvKH5Tv/57kDzNIa/ezk0i65UolvECe9TqUoz1BYC4lyNfPil2OQcbyFGi?=
 =?us-ascii?Q?RqxLUhENM71x/f3sbKeeRXN8e8YeyNJEti2Pk3GRN6bKbuIWO2Vng53t6PEg?=
 =?us-ascii?Q?wWLaYIDWjEeivD6IMpJt9DTm+aYFmqct0y9XWTTEua6rvXxPI0diwhI8pJoY?=
 =?us-ascii?Q?EWh/IDQn/hmzg+1o5PfnHUcaTP2VDkX2RHSxsrv0na0CE3hcId+I1Xr2nqru?=
 =?us-ascii?Q?2jPwtu8rihayA1gEuKcpV9L/wbZbzJ/rFMy1smrJS6jYhfm576F8TmsikR9Z?=
 =?us-ascii?Q?Mk4RpK2wQ6KB60rv6XzLGl4nmjk/Ky+eUk+rJOOXLj25G1/MnJ6ynj/fl+Ll?=
 =?us-ascii?Q?a4WHTtOmbAohHqiZ0ZHTzbow2GflCpAS94kNBsr8pZHPInPFVdqBn2F3FGa8?=
 =?us-ascii?Q?t8QYPagd6Im+P8aEmiprMC9F0ViZrNU3papOuT2mN/9iKsfbINGeO1Pc4ElH?=
 =?us-ascii?Q?1hVmLm/JKFeqzoEDFdN+8/8+KysxytwaYgqTPKhBa+eV5mYmXDeg5X55tWUb?=
 =?us-ascii?Q?1gkXjAaOONHF6urp8M5YxsfuQek2OwLqR0Pv6RvUtCkXW3p8EMDPyAWStoKN?=
 =?us-ascii?Q?79s1U8Jwadttzp1u726gcfJlSFYuU7N5aizM2KQMFT8He3E3DRKqBLGgoDoo?=
 =?us-ascii?Q?abFnsginh9YQh5RPyKU4luglk3Ne7BMLAlgXCsdwLusbmIk1hdZPzS4gawyT?=
 =?us-ascii?Q?XkpyFJqyvOpoKQd5n60wpsxTHXV7fk/iv8FLSnfJp4vTbWWoLLx2bxtg9E5i?=
 =?us-ascii?Q?zCV96+NiS8bx0dVMnL/P/Tdxer6DqGU6BmHWp9UnHLNiowz271YSnz5hcOMv?=
 =?us-ascii?Q?Dky0RXMeFFE9?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SX1KHc6aMxcVWblTr4caEyVR+1YJ5PXldrKk3fZH8SHPVrCuD9R9qyXBkOJR?=
 =?us-ascii?Q?aj2rjGqZXGcejgqUivP5BAk5JLtwCYOV+PWSyjm26z6Y0s2U+4tPlIQhxEVO?=
 =?us-ascii?Q?sAWH7Hh2jlc4JWJ01wdqL1c4ISiLzZsiMgsFoQSPT5uJdvu7JhpoOg5x5ZaG?=
 =?us-ascii?Q?5jIqvihL9gPQKwDZeGyh/sncG0U95RX3zzBNi2WyYqjE72+yVzecpxLENvBT?=
 =?us-ascii?Q?CkcVyh/4/j/o+FICl7371MGCa+wvWPjidIMHC8RbCtSvK6Q8WnFRycNZ3AGC?=
 =?us-ascii?Q?GzdcbgjaEHnEfiXkZGPJ/KBEgFzHwteOvKsBnNV2hzaUHsxuCDODzn+YyKas?=
 =?us-ascii?Q?I0jFolR92kgrHAPsllL3CZzT87xGfA53cupBgexLW+OrC771eXaGYK84nMm2?=
 =?us-ascii?Q?m8TeG+E147XJFXa3CXF53VID08tC4MxhbcE4DilbJAVjtIrx7YTHRBeOPdLD?=
 =?us-ascii?Q?F8sSTx8sO2ZXXBwi1UQ/1Rbf4iLU+zCuyT5pmkYt2b0KM68/lTNd4yusKXTZ?=
 =?us-ascii?Q?x6nJHqMo2fHx1Zfd2mjFnlRtD0PG0Dm3vBjMz7zrmBX9F8avJmp/oeIeRE1X?=
 =?us-ascii?Q?OQjab780T7XGiNHbay8FAjtrLjrbWjzGFzVGtCyJ6GMEFYIUw5JlWxyMf4b9?=
 =?us-ascii?Q?IRu393NUaiJBT092rT8RzXjkT/9zM2HyCZfQ37B4Vub42Fg6uWFFQgD5fYhM?=
 =?us-ascii?Q?JLcCfXWeYK4Y48vPU4dQPOZfPCvg/evsvisRUnAfgDSjTuXBtH6Yk/q/0r7A?=
 =?us-ascii?Q?yfuHmJ4yqH1raZ8CnpCGDGyjxMkKP8N6bH5bK6HoEmDNduj4U5/j1RbeIU5E?=
 =?us-ascii?Q?YVYkf2+zVgJvfUZZr4Htd5k1snPWc5HZqK62fJEQJ7Jw3Xn4y3OztPK0HBNg?=
 =?us-ascii?Q?Du3oUQ+1ZborJkCAKjeTPs42jSs/aCS7u/+1TeQvuq1cRiQ2POXIoolk7wzJ?=
 =?us-ascii?Q?HqP0y2/hTah+OeJKHi+WsqWb2+gBtSD1vFpPhaurpbkhpXJqbqoUJBog5vTb?=
 =?us-ascii?Q?5/09TommsuA8K5x/AVyzyKoqZqOkt2slnvyMKoCq0sug6qj+MTQUEpkos4Xv?=
 =?us-ascii?Q?a4b0m8Sfr38EB1oUkvSlu0+j1crcTceknzkOKW9SVprdiUoEcad6gDD8U4jh?=
 =?us-ascii?Q?UuLnypFJ7SxIfUqOJ6GejDF9ti+4+B9y+8+IKciVJ+colDn6dh/Ah5uRcpk/?=
 =?us-ascii?Q?ArHLem0spvUh4+i3j28LQ41q7TBAvPN4Tsyc7PcsuYAZ3Af6yNi7WvVa2M5C?=
 =?us-ascii?Q?coX6BcOdgETnkTXYglZjMPV6qV/Q3FGdiWdUNzUROs4lJjhp4R3eQtAwB54p?=
 =?us-ascii?Q?tgMmoSwGURXIGrQezc0DtIebB0Gvf4YG1ITd5wt6ZdH2/D1SN+3GBvEh4/B+?=
 =?us-ascii?Q?g9WrcuY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d21e00-2374-460f-4192-08df2ed49094
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 18:04:20.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6928

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Monday, October =
19, 2026 4:10 PM
>=20
> The remaining users of the shared indices can't cause a bad memory
> access with the channels a CoCo VM accepts today, but an out-of-range
> index gives them a nonsense byte count. Give them defined behavior
> instead.
>=20
> hv_pkt_iter_first() bounds its memcpy() by hv_pkt_iter_avail(), which
> is derived from write_index, and by pkt_buffer_size, which comes from
> max_pkt_size and can exceed ring_datasize. A bad write index can then
> make it read past the end of the ring. Only KVP has such a max_pkt_size
> (16K on a 12K ring with 4K pages), and vmbus_is_valid_offer() rejects
> it in isolated VMs, so this is latent. hv_pkt_iter_avail() now reports
> an empty ring for a bad write index and logs it, rate-limited like
> hv_ringbuffer_write(). It takes the channel instead of the ring so the
> message can include the relid.
>=20
> hv_get_bytes_to_read() and hv_get_bytes_to_write() now return 0 for a
> bad index, so callers see nothing to read and no room to write. This
> also stops hv_end_read() from reporting data that hv_pkt_iter_first()
> won't return, which would keep a channel rescheduling its callback.
>=20
> hv_pkt_iter_close() only uses the indices to decide whether to signal
> the host, so skip the signal if either is out of range.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/ring_buffer.c | 16 ++++++++++++++--
>  include/linux/hyperv.h   |  4 ++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index cda957d..72f30ab 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -408,8 +408,9 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
>   * This is similar to hv_get_bytes_to_read but with private
>   * read index instead.
>   */
> -static u32 hv_pkt_iter_avail(const struct hv_ring_buffer_info *rbi)
> +static u32 hv_pkt_iter_avail(const struct vmbus_channel *channel)
>  {
> +	const struct hv_ring_buffer_info *rbi =3D &channel->inbound;
>  	u32 priv_read_loc =3D rbi->priv_read_index;
>  	u32 write_loc;
>=20
> @@ -421,6 +422,13 @@ static u32 hv_pkt_iter_avail(const struct hv_ring_bu=
ffer_info *rbi)
>  	 * stale data.
>  	 */
>  	write_loc =3D virt_load_acquire(&rbi->ring_buffer->write_index);
> +	if (unlikely(hv_ringbuffer_indices_invalid(rbi, priv_read_loc,
> +						   write_loc))) {
> +		pr_err_ratelimited("inbound write index out of range: relid %u write %=
u size %u\n",
> +				   channel->offermsg.child_relid, write_loc,
> +				   rbi->ring_datasize);
> +		return 0;
> +	}
>=20
>  	return hv_ringbuffer_avail_read(rbi, priv_read_loc, write_loc);
>  }
> @@ -438,7 +446,7 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct =
vmbus_channel *channel)
>=20
>  	hv_debug_delay_test(channel, MESSAGE_DELAY);
>=20
> -	bytes_avail =3D hv_pkt_iter_avail(rbi);
> +	bytes_avail =3D hv_pkt_iter_avail(channel);
>  	if (bytes_avail < sizeof(struct vmpacket_descriptor))
>  		return NULL;
>  	bytes_avail =3D min(rbi->pkt_buffer_size, bytes_avail);
> @@ -587,6 +595,10 @@ void hv_pkt_iter_close(struct vmbus_channel *channel=
)
>  	 */
>  	virt_rmb();
>  	write_index =3D READ_ONCE(rbi->ring_buffer->write_index);
> +	if (unlikely(hv_ringbuffer_indices_invalid(rbi, start_read_index,
> +						   write_index)))
> +		return;
> +
>  	curr_write_sz =3D hv_ringbuffer_avail_write(rbi, rbi->priv_read_index,
>  						  write_index);
>  	bytes_read =3D hv_pkt_iter_bytes_read(rbi, start_read_index);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 09f25ad..216c0b9 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -250,6 +250,8 @@ static inline u32 hv_get_bytes_to_read(const struct h=
v_ring_buffer_info *rbi)
>=20
>  	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
>  	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
> +	if (unlikely(hv_ringbuffer_indices_invalid(rbi, read_loc, write_loc)))
> +		return 0;
>=20
>  	return hv_ringbuffer_avail_read(rbi, read_loc, write_loc);
>  }
> @@ -260,6 +262,8 @@ static inline u32 hv_get_bytes_to_write(const struct =
hv_ring_buffer_info *rbi)
>=20
>  	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
>  	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
> +	if (unlikely(hv_ringbuffer_indices_invalid(rbi, read_loc, write_loc)))
> +		return 0;
>=20
>  	return hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
>  }
>=20
> --
> 2.45.4

