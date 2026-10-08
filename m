Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010044.outbound.protection.outlook.com [52.103.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE633B388D;
	Thu,  8 Oct 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480252; cv=fail; b=ixlvvgmBlKbe/qQr5V076cBRjiTX3CvLQm3Sumo26aZfO6izGur4MMcWwH/7aLGTDd0YmsgAZ+V5v6kZIHFWk4Vv/UnUsdVrMdFNK1Dj84PKZMci0aEpIRmbJsT8gG+R6qphwX/m5RoJQqJeIxzS6RasZgpzcTMIfNgr4SFBOaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480252; c=relaxed/simple;
	bh=+riNTnSi98eXZr1v+AONCwo4u3l+EmAVgJNiIwlbf1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JoyEyiYircIhcyJVwnB2i73odSJIv4SHtMc5kk57OP4EJwDo2zieNp+mYWreQwqkKb137SVkx3EedSEEyaHJQXAN5ES6Iyt77NfC05clWdYPkcmlnyBBCZhX2mLH8b60XeBXpX/ATK1C04lQFfGYfa2LNdRF4gWbO6g1olJo5X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CtvTWajx; arc=fail smtp.client-ip=52.103.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CtvTWajx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBsRucdo+YtAZF5QcseHqyfqLA5iWu+sN3uQYNubFkZmYioBNZhIhikh+7iQLEQIO2yLayFngmNdZL9Sq6JO4+xYi9yfL8ckaHK2PYW4mve7Aag3i9fm1u9EjdM/S6ZLHkTVFJGgIEUFgPIKNTWPp81rMZXJeIdcMREkNP5+exrEBWN4vTg+VMg+gO2Mo/dyh5zdV+T2bXxcbktuFVDBMpHMaN1UOuRlxqIQuJV13OCIeKPXx8E8E/nSoqhHkqSY4/wO0yemHt0eDn+dR2uij99ONDVbCEKS1k3VPAIhi86FyUcGR36YTEU2b355pJFo+TtTwAZyNL4x0txXSueMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqyJqhaw2FTTJMw6OjZKfE53joWJWeN3kTUEql+nTaE=;
 b=DqW0rRxnVQcUHJnKgHW3sIcg1lZ7AkCRa/z8k/fCaLuoS8pNiDVT7FjFktS0DUh//re5IYTs0q4JFiglO+KiKkezOv0RZnB0gDkjZ1F+6l+0TvpMyF9rUV2RozlGJPWlD/NXYDQqijxF36E/4F0+0/LRKzHAeM/9GEHr0/ndHDsl8viPyXpcDRSwdoV3QosRO4Db1tL9rXhFjKyCp4XhdUKu3dEeXkNzUnNJydviKC8DCcP/0wh3jjo0798+GS9LA8HG1pLTJQs2bYP/kH9VSww/OiSxx24YidJbPhrtcT6vLXUnxgZFEIFSpO91QNDzj++l0rqFKb9IaUV3PLrLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqyJqhaw2FTTJMw6OjZKfE53joWJWeN3kTUEql+nTaE=;
 b=CtvTWajxxrWpzMaGgZUaCnf+uXdg4QUJhofFZacetWlRfFaLkykUctyTQK/zIj2omkVfFfA4v0pQ6/6tFaELJjgAh9iu6614p0GNLcXf8AgikOv0ZlrPobZNtla/1Ua31Oz2v3wcZLDOQQG4AKfxP+FTrvmA4k0yr4C9S2xHpEBsiZCsQo2pb1G3eNVMYux+1gb53tQAJ1/oDEdiw5eT8+yn80GQ/F88aKr8AcRdzgAzyjB3ROR6sv8q5XHkoeO33krf7BJv5CHNegiKrqZ0bLkTOVyzolV5G1WaUSOnGeUPb6tQO6EuU9i/U1yuM76rhkYluJQ3DxNzbH75+xuaGQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB7165.namprd02.prod.outlook.com (2603:10b6:a03:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:24:09 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:24:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] Drivers: hv: vmbus: Keep the ring byte counts sane
 for a bad index
Thread-Topic: [PATCH 4/4] Drivers: hv: vmbus: Keep the ring byte counts sane
 for a bad index
Thread-Index: AQFOJEjNF6VkbcuqUxfhl9QR1YCS0QIIEFayuAICh7A=
Date: Thu, 8 Oct 2026 17:24:08 +0000
Message-ID:
 <MN2PR02MB6863063534FFF3DBE9BB22A1D4932@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
 <20261001221040.1794904-5-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261001221040.1794904-5-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB7165:EE_
x-ms-office365-filtering-correlation-id: b16737b1-e295-4340-3e0d-08df2560f652
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|25010399006|13091999003|31061999003|24021099003|41001999006|8060799015|19110799012|8062599012|51005399006|15080799012|37011999003|40105399003|12091999003|2607281247196008|102099032|56899033|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2idGlIx4oCIRL79hFF9OstgiOn4j5AyJ5S8N05zCiliwIA9zwHmqch1GGJIy?=
 =?us-ascii?Q?vfkH4ln9CvEQrNVkWySyw92Q5lrxCR8kDIGMntOxla7BkVKKkbnb8Q/3pmqv?=
 =?us-ascii?Q?GFM8ozPMoCw1SsUxjC1GVIhdKGiL/SlXFELoH27SQDgg/XU9L+XOXsqyt5pJ?=
 =?us-ascii?Q?vSv0u44K58u98DvGoeDt+n5keAAnLCBq5Q71Peu9Ckg2fmru18MUgpjljrWb?=
 =?us-ascii?Q?ynWeOm5ABiQcA2jLL4NcJS+Pt2NyxLQLN/Vv+FN4Hd/v37OJLWDByr0oKnf5?=
 =?us-ascii?Q?8r3Y2JBe+6Ds5lrCqUKpg7RV99kJ4MCSIB9rZRNu0RRIUx8o5i6frmct2OHK?=
 =?us-ascii?Q?Azxz5QYz08SVuHvQSdAJHmYCdoAqky8o3oVcPCvAB7bAT0Ab8ajjpkCYLi6e?=
 =?us-ascii?Q?zLqw8Vo+79JBaK91xBm6MxYWOWY+x+/Kha4cfdMutMOfhj7izxOtUCzfUzsB?=
 =?us-ascii?Q?1bn9bvNEfo4FXgPT7Z7qBNAIn/TFphvpsv5B7APN7p112jvTZzsnyWJGRG5+?=
 =?us-ascii?Q?U3u9m7QiPXDz/so2d4/nnRWRuTB0UIi+Vof1nKGx4iXwcnzAz2C4/VBiThNN?=
 =?us-ascii?Q?T+H35DutYPiN/jmG8EHf6kXiCu0vBX4fxP8L1++2mewdmCS7Py+guBVt99PK?=
 =?us-ascii?Q?Hqce2Eax4mp8qzT9NaTgqP357ls/SfEFxjdcMG6qhRP9fTtvDXo89fxyQCNa?=
 =?us-ascii?Q?RzwpsiTHFdXBKH7c6kkboT6pXzGHeKuojGHOYVKwx6t/A3K7fyqRn7F8EnVB?=
 =?us-ascii?Q?N7pLj7FJmC8lR07mOSHzXGMqoVvX+efwtMoOSTdMfjiL9E5inRH670J6aJWj?=
 =?us-ascii?Q?GEGN88pomS62v82yOVFSd4TotWJ6SgH10zqeDPe/RDX90p7rM77Bj1/iz7Gd?=
 =?us-ascii?Q?f3g6jjO2l9owiKRZp7qm92nU9vCpwuQ9hgRF8mxBY7CmCF+PgJjj1BEvjRjM?=
 =?us-ascii?Q?E6EGjiL2peXO/Q5nid5iW5fSj6Rrb9veL/2zzPmLwHQYzZVns1GUzE+xCr6r?=
 =?us-ascii?Q?Tmp1qryAfCVuCyd2ZDtKf6cmrVjb8Ef6yWRSPPLFy67KyspZzvJMcuIM3H43?=
 =?us-ascii?Q?6QErqs1zDLrs+qnSdBFu12WdsbyCrUbCu0+906QVXUrn9OkzYk4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1pEkmsLYkB84FT08GiJ3WHF3+Hmb8P0xHAlcB0jYf2A+natdV9pmxEz2PVz6?=
 =?us-ascii?Q?Fqh/bID+5zyCnHptZdExHkli0WAbeiK/UTGa8KTGpqX0IjMsK/xWKyinZv7T?=
 =?us-ascii?Q?YEF+LkLQIvHik05t5q6MUjgmi3V5w7DPKdbqkbV6rNci97zv/mHdi0bSWRCM?=
 =?us-ascii?Q?K+GYcA1EYSFHqAgmnc3tIVxqW2VPHy3Ilylp2mGUUs3OAcsc3x7X18IriQ9r?=
 =?us-ascii?Q?xDUsTl2lj0g6bGi/GUnnz5TEovVNQ8oLrEmQh75fi+EsdDAAbwavi04vdjdO?=
 =?us-ascii?Q?V5DsQFR7Jg0aPGv3mM7+0GcKeK3rJgbJMzhmj5/pQ04m2r933y3GwLkhce2g?=
 =?us-ascii?Q?gV6Js4dNxpeOI1o8mKFr9iHxyZpAQFdV3pChs/fxKJVD4aAHkJe13ac+D5YL?=
 =?us-ascii?Q?ezt6Dw9KG/EFInzrlGTNKQqcmW3ZZ5n8JdYhmANO9GvzncNL+hg28BqQEnGE?=
 =?us-ascii?Q?n3mY6+vW109D33Nm4hgbLSlqoXiOvDeeLZ5am8qh+sIqBZDVy6GMx0mV0I5i?=
 =?us-ascii?Q?5Saa/KtD4zPrDUvySmcDYBd8fGjNpPazJxxyOKYfNAamabYl7u2x5fLEqiUe?=
 =?us-ascii?Q?seLBMXqb280PDLLqhvLbvPPPQlEDHGcdb1sdfVxirJbZE1eJm+dMc4KpRl0q?=
 =?us-ascii?Q?Aj66bRpp0+h0mJ34uiiS36XLVvCBTFPiilookCj5JroLCwuxOSXXM+v96nIS?=
 =?us-ascii?Q?KlmGutv7l1UvWNIT8T85PDIXJsgiIj0nCrYBJxi1Tk8MoZ5/W0Sy6DK4ff5j?=
 =?us-ascii?Q?F2NW2wNfIN6MakpR3qnNsqcAXkr0e+1TFrOaMeEZlFIAtzNX6HCfTh443SYV?=
 =?us-ascii?Q?x4yWIokyQHz5AEppDYn9QikFKte6HyffJJOVXQxMLmn0obtdFId7rFv+XqMW?=
 =?us-ascii?Q?GMtdzUJzxkRu2xK1wWx5K6O7hgyV26d4OVlfPDtd6aWf74lO3qXT9NRVfOh/?=
 =?us-ascii?Q?QykSNaM/NLzFuUhWgBILgwZSDdJ2N/7b4fpJEYOT/U2Ny3fS2BwG1dKST9Ip?=
 =?us-ascii?Q?gR7BrrWAoasrxBLy7Xl4kqRIbmAa1QfvDU/eFc0yPPi41Wy7GDgTYdtSbqds?=
 =?us-ascii?Q?VNORL08zuva0iZZHI0O9pr0ENB0CO1+8JmRyjo3EZt2bj9EU56rpoMNwmstr?=
 =?us-ascii?Q?Pmcid7C066/6w4nWKga4+614OhnqofIYivWxEwR8u0CIVqVhcowyzTbpK66r?=
 =?us-ascii?Q?7eFz+TUcTWI7hUDUgqOZK2/5ER0w6Wly0mx8I+D/tQE0YCoXS0+3s2X+n9Ve?=
 =?us-ascii?Q?OTXTVGVT/3NLinlyHNiBycFeN0m1845pO/KrDlUzVs5srOh1oRWAyRyBoJx6?=
 =?us-ascii?Q?MzBO5IoecA9Li5Fc/xBO98iaLkJL5aIVlVlxeuI1hkOp5A3725+bRDOLWxyy?=
 =?us-ascii?Q?0cRlYtk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b16737b1-e295-4340-3e0d-08df2560f652
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:24:08.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7165

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, Octobe=
r 1, 2026 3:11 PM
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
>  drivers/hv/ring_buffer.c | 15 +++++++++++++--
>  include/linux/hyperv.h   |  6 ++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 29edab9..b54a7d3 100644
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
> @@ -421,6 +422,12 @@ static u32 hv_pkt_iter_avail(const struct hv_ring_bu=
ffer_info *rbi)
>  	 * stale data.
>  	 */
>  	write_loc =3D virt_load_acquire(&rbi->ring_buffer->write_index);
> +	if (unlikely(!hv_ringbuffer_index_valid(rbi, write_loc))) {
> +		pr_err_ratelimited("inbound write index out of range: relid %u write %=
u size %u\n",
> +				   channel->offermsg.child_relid, write_loc,
> +				   rbi->ring_datasize);
> +		return 0;
> +	}
>=20
>  	if (write_loc >=3D priv_read_loc)
>  		return write_loc - priv_read_loc;
> @@ -441,7 +448,7 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct =
vmbus_channel *channel)
>=20
>  	hv_debug_delay_test(channel, MESSAGE_DELAY);
>=20
> -	bytes_avail =3D hv_pkt_iter_avail(rbi);
> +	bytes_avail =3D hv_pkt_iter_avail(channel);
>  	if (bytes_avail < sizeof(struct vmpacket_descriptor))
>  		return NULL;
>  	bytes_avail =3D min(rbi->pkt_buffer_size, bytes_avail);
> @@ -590,6 +597,10 @@ void hv_pkt_iter_close(struct vmbus_channel *channel=
)
>  	 */
>  	virt_rmb();
>  	write_index =3D READ_ONCE(rbi->ring_buffer->write_index);
> +	if (unlikely(!hv_ringbuffer_index_valid(rbi, write_index) ||
> +		     !hv_ringbuffer_index_valid(rbi, start_read_index)))
> +		return;
> +
>  	curr_write_sz =3D hv_ringbuffer_avail_write(rbi, rbi->priv_read_index,
>  						  write_index);
>  	bytes_read =3D hv_pkt_iter_bytes_read(rbi, start_read_index);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 9d7d09c..fd61382 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -248,6 +248,9 @@ static inline u32 hv_get_bytes_to_read(const struct h=
v_ring_buffer_info *rbi)
>=20
>  	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
>  	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
> +	if (unlikely(!hv_ringbuffer_index_valid(rbi, read_loc) ||
> +		     !hv_ringbuffer_index_valid(rbi, write_loc)))
> +		return 0;
>=20
>  	return hv_ringbuffer_avail_read(rbi, read_loc, write_loc);
>  }
> @@ -258,6 +261,9 @@ static inline u32 hv_get_bytes_to_write(const struct =
hv_ring_buffer_info *rbi)
>=20
>  	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
>  	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
> +	if (unlikely(!hv_ringbuffer_index_valid(rbi, read_loc) ||
> +		     !hv_ringbuffer_index_valid(rbi, write_loc)))
> +		return 0;
>=20
>  	return hv_ringbuffer_avail_write(rbi, read_loc, write_loc);
>  }
>=20
> --
> 2.45.4

