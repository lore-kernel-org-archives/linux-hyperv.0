Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010093.outbound.protection.outlook.com [52.103.10.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B523AE184;
	Thu,  8 Oct 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480225; cv=fail; b=MkXJ3H8j0BaeqM+YdhydJ3PS0anF/kNRN54Vo+IuOdXmRAljhYrUYFnNSfvBhqDNuKQFe8/v4JozYk1cLnGU6v1Firw0NDFAULokBxoJ0BS4gkvhe8e1dNQChD3CVy8uOie/5RrCRLbTdnHaSs+Nf+geYxX32f2ILurlUITk+NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480225; c=relaxed/simple;
	bh=3SPRKcDiyskEhNgXs5Qdu5qSMeINCVFQ33LMBAXEKPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hEa9R0tj+p61SZ62NCpwlk9toMtdokb0nupDu+dKgpRy+Hh2YrH0SgtkI7rSYw+U3ExfOXf0YThFegwXAHGv2nl8tZnF8UJprUmPKIgqFUFmdyfeiC0nVOR4boZixqwPICW+61bKr3NLgklLVHnztFt30i21Sy7NMzrYvHIKjLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d7TuCEfs; arc=fail smtp.client-ip=52.103.10.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d7TuCEfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8gysp0ss6D/jmKJAuhx8h4hjCAjHeroIXuLaQGqNniUZ5fwF5DqoO4lUT8oQciUUN7twflcZZNTA+uWiSZLsAxmetvOHgDUBx1tS9+pdN0cPtarVYeLFNTk/7ir6FEn0CVKjgO1qmDbhMfk4oxDhKMYGg8po2eIWmBsXYDYP+7GyXkG6vCeHKg6v/hVxNV0cT1VkN92QFgdjyp2lk3jqo2OMOOsNF/Og/5XK9WeVOfKZ2VhlG3Ba8nscaMbWDR+iuoiXNPB/Hu1Ui/qyBsjZPVswQLOluQMl8hpO7Yv+oqB4pS8NpW7mHRn2nOPYhjfzhFBrXxYWGWT0gOavGSrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5HWKcpnW+XP2Djk4FFt09PGCwlxwZCRfiXkFKkTJHA=;
 b=KV0W4MLESWzbmn9z2iKwZZFvL0CFb9udIgnv7QzuvRBeNMSdJ1n4R9IF9hFDHPJSNxgpPCVSx1A1mLSmV5RUDpNJ/q5mk4dhmRp2kb/6TQ6cs5+53FH+080rVbEcY2uAAVvp/mxwX3bUwVexzUy2yhdjgL5G2vzDwuw5bazumvBN3sWYLMk9wxOb19OOyqXtox4rcuhczipN9JpzByCbRDT1fzQC0NvK2JZ6wPfYSfliiQQacavCSn8lQoD1v9HYzqwmDLzK9XnM12M6Aay2qAt0LBxXMQqR08fBubGol1pS+hgjPbBeOfjC9kU09y1SdpH9PCpN0ipOgmM9aQE7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5HWKcpnW+XP2Djk4FFt09PGCwlxwZCRfiXkFKkTJHA=;
 b=d7TuCEfsNWVGJW4XlakkAfAgEyy4PI4sT3oVkmqFIg1iQ0szad+Y3GkW9yEJpoGEBRvE/yGseF1X5Ps4KKCdg5utRrGclpL6RjsjEsHghtVNEPzwHA0s+EC+4Oj2lc71552GOX1RhcOnMF+YsRCxqF3yOPN9stvG9P2pk5dU96n1e0nbX1O40YBrIzg+VUS7C5xpCkU8NBfe0OqNEFx6Wzzc7w0RebWvepMnjV2mLwRrslbM879iamJFfDCH0MbKvruyvquyI87cknne7MRc+aJHzmR+0ruvAbWztB3wFOtiRocvFaLKP+TU3oUzvpm9un++Ypxa4Vn5ZmahPpT8tg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB7165.namprd02.prod.outlook.com (2603:10b6:a03:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:23:40 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:23:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] Drivers: hv: vmbus: Annotate accesses to the shared
 ring buffer indices
Thread-Topic: [PATCH 2/4] Drivers: hv: vmbus: Annotate accesses to the shared
 ring buffer indices
Thread-Index: AQFOJEjNF6VkbcuqUxfhl9QR1YCS0QH/pbPHuAJAB8A=
Date: Thu, 8 Oct 2026 17:23:40 +0000
Message-ID:
 <MN2PR02MB68631142D97C93B9772D30EAD4932@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
 <20261001221040.1794904-3-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261001221040.1794904-3-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB7165:EE_
x-ms-office365-filtering-correlation-id: 46620a84-ce5b-4b50-1433-08df2560e567
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|25010399006|13091999003|31061999003|24021099003|41001999006|8060799015|19110799012|8062599012|51005399006|15080799012|37011999003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1yGdUT41SWFLb7DfwL7CiOywRWXNOvmNizpPuAVcjtDcCe45rZkVLwuSBNMQ?=
 =?us-ascii?Q?v4UG7oUZpWrbTso8cAKP10NWldBGfs4YZqhQS27tLkGf79OtBjMqxx3LcUH9?=
 =?us-ascii?Q?e/6kkd8zG1aUGfA3bLJsn0hZ8E8obHzAVAR94kyYHvdXNMJ+4/uch7PoZFez?=
 =?us-ascii?Q?mNYnS6/9qdmOxLp6TqrIKcqulRno6Ja6nwkW8DnqtRuhq2IZnQAPOVDaaY5h?=
 =?us-ascii?Q?KMQp4frB+yE3aCp0TV0kRlb4/Dg5ZjKxttduGOqVIcLlBw34/dSDFONBeOjV?=
 =?us-ascii?Q?puQNGZirlZDNoz+RuZlCSyuTZDTcFFD68apd3bfugohPXxxdn6czeFKkFOAo?=
 =?us-ascii?Q?EIN1sEj6GKmwPG0hZjLpi7+I1IvaypaF+0CetzW6g7hLnGxD9e08o8Fd8eIn?=
 =?us-ascii?Q?6y8X+idmdgrubkOCZWjKK+MvwSqMRjPxKAKcrMviureLkoRHlG1g71ekdG2W?=
 =?us-ascii?Q?4F2LPq/93Iah7y77g8zC1/mUH0ymmZrsqiuk0lqwASbYS6QHSdRymVW0hnbX?=
 =?us-ascii?Q?87sEYHVi4uF+eL+MMgp59RNvwvFNeiiuz/wWWQQbd57ZlVyhimdCUlAWdhjD?=
 =?us-ascii?Q?O8bQo4LDs/kn6vE2SdmPUv1UHaoQBOrlomf57hUtD160q3dB1+CCbPIvYDQ0?=
 =?us-ascii?Q?Kp/Y/aT+dvZJ2HqBlOEcNSIu2rR10o3PtOoiF/rTTY6qNV+btmPVyLKoGmg4?=
 =?us-ascii?Q?Z6joZuhsi5+f2GUDbh0A726fDFHKqYSNBh3nW3Sph/T1gvHDinZm7GGGl+FF?=
 =?us-ascii?Q?BVljGoVUZ4aw3mxDcprJ7toCOkDUecNTy7BBoWBg13mIyC167t3M9Id7jr8r?=
 =?us-ascii?Q?UH0pRJg68uu6EQWa3NZmskS1a86nHTmovHxnKfzamT8oHJeG1T6rpjrLuFPg?=
 =?us-ascii?Q?4CKGqM3y59F5DTwtMtLo9BC68oLprC6qJy8VuLGaVWp4+R7Oo1g5hnhbI75z?=
 =?us-ascii?Q?HjkCKRLtb8/1JaMxLG2VIILKuy6U9rLmZksuwLAxoDr9m/vAdr0uWINShqFm?=
 =?us-ascii?Q?gJBbNsnojuW97YMa7/h6yBrVlL6mcM9po20HYy82Z5JUfZnVqu7Q15Ey/7t4?=
 =?us-ascii?Q?Jg1eMf76?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?diLfHsvb0YTO1X+oqYbXBPZqrEMShsffVL2ZeK8z9PSTubMHctJ1Kd4lH47d?=
 =?us-ascii?Q?TZFbgAOC0GqEYzGVYm6AGNqOFBiDwyrASqUtSdrqIZxMVf/zJK60nMPjiIrh?=
 =?us-ascii?Q?TGR+ZBC1L9Gqpn7ltJ5qH3MddkjhTv+eZSULqg5oev/PxzQt0sYg4jFxGLz1?=
 =?us-ascii?Q?80wgJs+mEZp6zDZ5lTS52rzS5oB8L6/p4w1CyavmqzVZI1tJzjujpPn4FZ9T?=
 =?us-ascii?Q?OjukcjXd55ZI3VLyjxVVsO8QeXOcxWN51Vt59d9HauDVK/lJpzQ/Qw3GPbxW?=
 =?us-ascii?Q?TgIuvnCmuau0lM/dR5+mj9Y4dN9e/jpRsaf2cms9Ej56nsqLfVeAofTkgZvP?=
 =?us-ascii?Q?ijrcJvsB2gogA89B6Ri5akzGlPPJ+g0asiK5pQiqfji+fb3XbOpF1gty0Kct?=
 =?us-ascii?Q?CpfCjLt58uEvbiC5HZ3cEReiroR2p8we4mpALdDiuKKSvU4eGxnbbCdILVzZ?=
 =?us-ascii?Q?/qmb3JLFV6nGT4wlRBHD/CvyqtsjDHQOyioWO+7B03nUV1XnoUtMNzncEDTZ?=
 =?us-ascii?Q?2XjLuctli7+mwiVAV5L3MhNw7HpOgg1eJwYySSDDPC4uo4kKkTq/UxXIQSw+?=
 =?us-ascii?Q?pK/YtbXkt68mYoRe45EToucOVeCG7woacj/eVZ77znQqn5Oa2RNSSDYXz3L0?=
 =?us-ascii?Q?XpaM++v9B3n7ZXSbnp0QNgUl0bQ0vRF48A+pNQ6C+mmdHxRj53XSN4kjAebs?=
 =?us-ascii?Q?kMxU94bEiYxaDavg/I+BZ2t9GxAw/omOV9FY8PPMTKWGkcDnb9g+FMUXyytd?=
 =?us-ascii?Q?huQe7bsUiEJ13EU5brCteH9AlVYqzLGDr4sI0ZgCHNJfwAu5OR63U4s8e+nH?=
 =?us-ascii?Q?UtyBELFJHrRRJDnD3mNwgi7GCq8/2EsEE0u+alZWH61BiGBosoYusRzrzOmx?=
 =?us-ascii?Q?eeJydWW9nkRgozUUERg+KcQdl3xXqgL1SCXms1IE4/VewhIMb3e29P7ZuYeG?=
 =?us-ascii?Q?6GTq5OFc1L/S2cXI62hgF+F7To4hmeGxt3X4STpSIz2ZBb9vw/I29Wh2JTEu?=
 =?us-ascii?Q?9SE0IdkFHOjMR3W6Nm3ap440+EYXaIq92OP1O1nmOr8a+xAUC5U4HvND8i/K?=
 =?us-ascii?Q?4SB5SrUVv4njdloCSMAql3pVywz2cqUW7aYVcbihFiatcN1hLhjGSEDSde6I?=
 =?us-ascii?Q?9QxTx3K9uykS1XBJY5aFEnnGskOhA1bdmf7nUFf1iDDnNXnjUsXrW3EwWj80?=
 =?us-ascii?Q?o3dwqgXXgOayeIUIBT5G3+xDQPOboiuBwO1l/XlzLtuWel7zZA1NG9gTuWDH?=
 =?us-ascii?Q?zuQsHHu3Z1EuhwyLh45pNzXHciiR5Usl8xPbx/WbH12cI+A9utqjR4PivWHh?=
 =?us-ascii?Q?1l+EGsqxSa3JDoVKSB83gWfevHWXKXeVFQMcUYuHNZK+HLysEeMsMIn6Wn7Q?=
 =?us-ascii?Q?lNHvR2o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46620a84-ce5b-4b50-1433-08df2560e567
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:23:40.5714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7165

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, Octobe=
r 1, 2026 3:11 PM
>=20

I have minor quibble with the patch "Subject". To me, "Annotate"
refers to adding metadata to the code, usually for use by some analysis
tool. READ/WRITE_ONCE() aren't annotations in that sense in that they
may affect the generated code and may be needed for correctness of
the code. As an alternative Subject, how about:

    Drivers: hv: vmbus: Use *_ONCE() to access shared ring buffer indices

But maybe my interpretation of "Annotate" is skewed ....

> The ring buffer read/write indices live in a page shared with the host,
> so the compiler must not split, merge or refetch accesses to them. Add
> READ_ONCE()/WRITE_ONCE() in hv_set_next_write_location(),
> hv_pkt_iter_close(), hv_get_bytes_to_read() and hv_get_bytes_to_write().
> The accesses in hv_ringbuffer_get_debuginfo() are left to the next
> patch.
>=20
> Drop hv_get_ring_bufferindices(). It has one caller and is a one-line
> expression on the write index. Inlining it moves the access to the call
> site, so hv_ringbuffer_write() can reuse its validated snapshot of that
> index, old_write, rather than reading the shared memory a second time.
>=20
> No functional change intended for a well-behaved host.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

My quibble with the Subject notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/ring_buffer.c | 15 ++++-----------
>  include/linux/hyperv.h   |  4 ++--
>  2 files changed, 6 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index a18b309..7f466c5 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -75,7 +75,7 @@ static inline void
>  hv_set_next_write_location(struct hv_ring_buffer_info *ring_info,
>  		     u32 next_write_location)
>  {
> -	ring_info->ring_buffer->write_index =3D next_write_location;
> +	WRITE_ONCE(ring_info->ring_buffer->write_index, next_write_location);
>  }
>=20
>  /* Get the size of the ring buffer. */
> @@ -85,13 +85,6 @@ hv_get_ring_buffersize(const struct hv_ring_buffer_inf=
o *ring_info)
>  	return ring_info->ring_datasize;
>  }
>=20
> -/* Get the read and write indices as u64 of the specified ring buffer. *=
/
> -static inline u64
> -hv_get_ring_bufferindices(struct hv_ring_buffer_info *ring_info)
> -{
> -	return (u64)ring_info->ring_buffer->write_index << 32;
> -}
> -
>  /*
>   * Helper routine to copy from source to ring buffer.
>   * Assume there is enough room. Handles wrap-around in dest case only!!
> @@ -358,7 +351,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>  		*trans_id =3D __trans_id;
>=20
>  	/* Set previous packet start */
> -	prev_indices =3D hv_get_ring_bufferindices(outring_info);
> +	prev_indices =3D (u64)old_write << 32;
>=20
>  	next_write_location =3D hv_copyto_ringbuffer(outring_info,
>  					     next_write_location,
> @@ -582,8 +575,8 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
>  	 * is updated.
>  	 */
>  	virt_rmb();
> -	start_read_index =3D rbi->ring_buffer->read_index;
> -	rbi->ring_buffer->read_index =3D rbi->priv_read_index;
> +	start_read_index =3D READ_ONCE(rbi->ring_buffer->read_index);
> +	WRITE_ONCE(rbi->ring_buffer->read_index, rbi->priv_read_index);
>=20
>  	/*
>  	 * Older versions of Hyper-V (before WS2102 and Win8) do not
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 9e109d9..5c65820 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -214,7 +214,7 @@ static inline u32 hv_get_bytes_to_read(const struct
> hv_ring_buffer_info *rbi)
>  	u32 read_loc, write_loc, dsize, read;
>=20
>  	dsize =3D rbi->ring_datasize;
> -	read_loc =3D rbi->ring_buffer->read_index;
> +	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
>  	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
>=20
>  	read =3D write_loc >=3D read_loc ? (write_loc - read_loc) :
> @@ -229,7 +229,7 @@ static inline u32 hv_get_bytes_to_write(const struct
> hv_ring_buffer_info *rbi)
>=20
>  	dsize =3D rbi->ring_datasize;
>  	read_loc =3D READ_ONCE(rbi->ring_buffer->read_index);
> -	write_loc =3D rbi->ring_buffer->write_index;
> +	write_loc =3D READ_ONCE(rbi->ring_buffer->write_index);
>=20
>  	write =3D write_loc >=3D read_loc ? dsize - (write_loc - read_loc) :
>  		read_loc - write_loc;
>=20
> --
> 2.45.4

