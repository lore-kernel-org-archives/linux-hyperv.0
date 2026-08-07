Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012052.outbound.protection.outlook.com [52.103.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B637E5ED;
	Fri,  7 Aug 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115481; cv=fail; b=uhk6EhuXru4S1QI/aYqXheoa152pDUE1M1b3tEsiQhtS5UzTvuQ8qqzDNYhzIGsLAmIvLAe/90RWfGS7p1WjSKiaJnyaejB7fWgGkfBfypz3Q308Gw03N0J1YjnCw73mS72u9M6QXeS1RReqiOC+Wc5YE5dJHotqx7cJbGT1DNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115481; c=relaxed/simple;
	bh=wQyO6N4SAEE5yI0j/3/Pkhq0iFfRGEdbQ2+8Jbg7Ft0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDWVgWl893Kwc9aEyAWcq56cowIHu04G/OR46ltBrsm8/qo0dFKZXxldpejBm6D4tpr1Cgvj8sQt0JuAe9c8l/VoKpv2K2OWpWrpwCYo1RC77UfhCbbbeozCxSdlddIEm6ottMrMIUPSGQ5EcgGyywQ50A+lBnhXLMxp4BISqsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H9IPxQer; arc=fail smtp.client-ip=52.103.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H9IPxQer"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUL1cfbTPDDnOrLp+ly2TA1LXftEsDDzaR7s42A7/liusMLp/7ird/Dl8hcMGGdiN0n4/x7e9MT8HboclEYXtKjdbNF9i86n8iOM1diCh6aJfwBFq5EKo+97t4ACJW21h/IYvBNvLhBHcO95vHDYiMWAKectlb3FwAE7qGdPRXxgvxcHwPo8yjVXBLsHhWnJItEbkOpCbXw1WDJfgYVyfoeHnCTjCmpBmcYunDJvcNVf6j8QRQK0LCkSwPqmj6MZkAv8BI05wZIh7HUKJvTO/jlJM+T/7HCUcrGaD7ssEMAjI8JX6FdDOLPPqvH1UdEC3zHzdgTrPl2QBop2Ukjs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YENHYfVRgT140P0cSUZxg1aP3jTOEROOm5RAJTQLqkI=;
 b=U2+NwaCZen33hMpL34FBFqu7oQxazFm3zdX2OX2dSnt0/wVPUIJKE2AMAOoP0vfQ9L3j7kxoM0zGmluO+SCMOS2iXF+i9bAyvrUueCdip2PJMi/kb7RBYyS30fM+tzz9XST7Coxy0zd+951UxXIcrNFhgWVdH6IpLucXtmWPjPM4EPvRDpvr0Eeld4bUvqsYNqXHWtgd2R+mG4+khrRjoNG6ngTNMxldfstAnLX4CEbRj7MebpfyVJrKQoopCopsTgTPL5SM4yG8uLyU1nI41Q18qgn7PFjKl2no9mxn/+wRvhvFSreiWB4RoLu3GKI7dv5cx1jEcJg1D8o2+1pJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YENHYfVRgT140P0cSUZxg1aP3jTOEROOm5RAJTQLqkI=;
 b=H9IPxQerWyu8FK6Rb8JnHCsOwutCH/7MiuO3WWQfZM1nfbywNMM3pCbXbnEdBBflkdqk/pYeh6MWcBX0aMJ/ttG9J2xDhylJbl/rSu+g2L2C/IXQ5OVBpRnJyLMnykAbsl4EmzNZiK8B1+NaOlR+Jfcr1HMG3V6zZyOimJXZM/yaN/HkbFy2w2sGb09AEq/OIFtT2RY6rmKQvqk5jT+5pab3nh5h025Ca0Ee7EaPPJCzqgqGpHCBh4RyS+QAtsiS8e0Tbmjwwl6C86QKbIyzw0UBUIJqn7azKxuhtWJTIKKpmWUsxQGGceA4svk4s7CjGOm9xGOvFyV3Xe3pjL0Vug==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8167.namprd02.prod.outlook.com (2603:10b6:610:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 15:11:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 15:11:16 +0000
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
Subject: RE: [PATCH v3 1/3] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Thread-Topic: [PATCH v3 1/3] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Thread-Index: AQHdJetWd3eaH0qI6U+aCLv0S0V/cLaSsiPA
Date: Fri, 7 Aug 2026 15:11:16 +0000
Message-ID:
 <SN6PR02MB41570BDA7BBDDC7EDB8C0504D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260806213326.1425848-1-kameroncarr@linux.microsoft.com>
 <20260806213326.1425848-2-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260806213326.1425848-2-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8167:EE_
x-ms-office365-filtering-correlation-id: 74213f79-91fe-451d-b79d-08def49620d5
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|31061999003|51005399006|13091999003|25010399006|24021099003|55001999006|41001999006|8062599012|8060799015|19110799012|260806224601699003|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FjtrSHQtDF5R4eELmQ1kzfapF5cugjiBSQ8uKVjXqGt7bjl0X7d1XH3FEWok?=
 =?us-ascii?Q?h2gcl4umRtO/CVHNiJ0q3cH2vJOo+Fh0CbqCfiagiuIJm0j23XNMDqrBGXnr?=
 =?us-ascii?Q?P+kFfkOCpF98uju2nviN4bt4kaojlG0Gcb/tE+9rSwKlqN4iCQf3BWMNo1qj?=
 =?us-ascii?Q?R9UHqC6qm0mAz6RGBvFaK7WfiOHJSF4fBpiuZzgv8U7Bojtb6Wx4yzdjwHFp?=
 =?us-ascii?Q?KNSXeYGG14Vq3k80bwETUfNBv/NkK/Rq6k7hcZwu6D0CQGK2MMG0ZHyb5Row?=
 =?us-ascii?Q?kXoEnjBI2RxMFuMfR/DUjMXOuoQ0ypTQ4NW/RqFruXxHibmFNE3G6sL56JwT?=
 =?us-ascii?Q?EyXbFX1TXY6LlHwL9TEREkLISjDIQQDNDKZnWLMTaEzYTBZbk7opRoyMBnVp?=
 =?us-ascii?Q?RGSXWh1uGqv/RIjadKZtAo+vYQksYoYCOfIIfOVIYMw2jVe0uoABVkKRojGa?=
 =?us-ascii?Q?grKpQPOQdVP1Cvv0OF6hBXthI3zHadEYxEvXZuJOOcAVjYDX/721Dn7P+Tvz?=
 =?us-ascii?Q?IjryG00cX1xSmJ0CQt06pdIWR5I0c7CPoaxL1fFsKanqnivGb711bVbzdjP7?=
 =?us-ascii?Q?PjKO3G1ITEub+VGUTFzZJzl5gCG1hkAu0nHtAJaCZThhcB2he/xEkzmLz6hW?=
 =?us-ascii?Q?lJi72ahiSAQ7J2Tmx7aRkWjyWtgwcqMsMPxjqmtlkSNkVotCfvmVDn+F4ToH?=
 =?us-ascii?Q?L3GTOomWLhTVI2Hdo/qCmwrfZ6cLxAK2XW6j45hNyE/bEXm1KLfzM1wpf2AP?=
 =?us-ascii?Q?hiprtVcfZcQDQXe50mgaG9l2Tul+qabBrdoe0l5uWcKDNuHH8uvQBW6vTGqs?=
 =?us-ascii?Q?CUNEc9f7hrGBwX2q6egJBWOJw1pcjk8JCCzIC9kigUzZK0KuVe8QIm1FM8MP?=
 =?us-ascii?Q?HbRQ2gq6CVO2e/vf6oNp62lpIFh/j6WvdTb33LO7zymxD0X1wHOUgiw3lQ5s?=
 =?us-ascii?Q?LV5ru1MaKUUHmVN8gkqciaoAN4lja0h+abffZpT/y+FQ9xXUkArUh2FnvfJ3?=
 =?us-ascii?Q?nuwZsWL8y5sMPqyM74pl88KXTZuQ8SyNL/q4Z62jBHli5hmmVf8SHNqRJK8Z?=
 =?us-ascii?Q?/6RtdQdXdTq3NKmGnHr7qmfDeIcfimRRUzw123BOukTZ84A/hfOMJSv67FkE?=
 =?us-ascii?Q?CPDCEmdGhEOa6TOgjvBCq2oJte/2000FRg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?abFHdU9L5mvqho3DFNTl01nooagQpBnJZdSzKCEDxF7njGTSKhN8cp1quWBt?=
 =?us-ascii?Q?lqjA/NZqhA00txDiIRnaA3+EhTjbmfUmW1Ia/2uT58F6iGt8zij6QlKHo7R9?=
 =?us-ascii?Q?zgcdD4w498SeXc6DGMy5CJRiCyxoMpT4gLTSUf21VX6Lmw+UmQiUyK13AE7v?=
 =?us-ascii?Q?eY6xyy9naxbQYTL+H3JllUEs454mTNCAn5cJ9kJDnRFcMJgQdEmkCthYwXyF?=
 =?us-ascii?Q?ZjgiWkSYzCWUlCXgeYZWB7ebunPvuHw3yTu8KhLgVl+S12oWkpOJb9YjTnY/?=
 =?us-ascii?Q?jcic53UisyKqA+pBi9RJkBXJPY5R2mR067lB4dHA3ex3ioGzqtGRekekvewf?=
 =?us-ascii?Q?VOvk3prHdob4fVS4qA1FaR94tkphFf2FYM/4uNf29xedsEGz1WVIvETK9h9h?=
 =?us-ascii?Q?rxlmLrIVnaugsn7cEdjqiaEiDNf3e7n+mPZlFUNBaXEW5S8kG1ahoekSfVnp?=
 =?us-ascii?Q?iU4iyeN7Nd5VLWXAvXSdv/SfyKg9Rs+HTKbVb5saOlz0vdAWPqlLPA/w6lDM?=
 =?us-ascii?Q?lC8yDyQURpu5oCXCZY8UfIYkr1oxXd4RIA4w6nPL4a7m57CGrutKkdGA1xuH?=
 =?us-ascii?Q?zO+ZNaw+ZpJot4IDD/EewM2Cl0dXIUkf+GoTHFGVAno25tNk9vZKdQD0R/S9?=
 =?us-ascii?Q?fLAU4tnTJ57IUQ5U5S2liOmmCdI2Eea4zHBfohwfbmJ1UhqNmRSK3TkmKmNn?=
 =?us-ascii?Q?dpTVXp9aqWq5qyfp1z29F186VxtVEG1soqx5kgEOn2ROinBG0wRbEUYn2gG/?=
 =?us-ascii?Q?6+nWzDSa45/o0f0PttLa2Yj7IuXICZWp3GfsmLnNzQygC01PMj6opsldNgh8?=
 =?us-ascii?Q?ugTcl8PI/Jjz1uwQiLkpbehvig88lTbJldG9tGpgjmeUVlus7IQuHPkLHKFQ?=
 =?us-ascii?Q?JYhyGUkWfsxHlRG80Visq6hgoiYQYYaVs7LMXyFtEHV49P2pxf7tUiwh2/ke?=
 =?us-ascii?Q?0WFI0HAtf3cG4LAN7JOXGcu5veLW4922e/NvGzdGioY7l+x9snbTfpTtaOyI?=
 =?us-ascii?Q?xmk5k8MRkwOMCSxjwownltKDDXCxyahf6cznryPEYwmyhWIx0s4rh2qMr2Qg?=
 =?us-ascii?Q?ts6DWlLbPro2DM5rgdvlo8ePNqntFSXkwKDa5gXNvuVip5rUecC+zf0kCZVy?=
 =?us-ascii?Q?I5QSa1khbTIAjnDiVrwfPryYCtM4WAP+CInhvv7Y0jbqLl1tpsrbQ06PjPi4?=
 =?us-ascii?Q?F3Sy02oXTZTASbwyfRf1qGLtNpBlgVJNqGdq5txIK7FkfRlYRC/1px540Rey?=
 =?us-ascii?Q?oLYeRwQ0xGfPfpvu6fnHkyWaFtkxN5UKE160X68a7Gn5IHx33a1bB/J3J9p/?=
 =?us-ascii?Q?hb66l027rxZK7/i7ew3y0MC2wHpOca4Bmm+JrS6qMtvMAlLF2NqJ6V4FH1Fl?=
 =?us-ascii?Q?9ANXgk8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74213f79-91fe-451d-b79d-08def49620d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 15:11:16.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8167

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, August=
 6, 2026 2:33 PM
>=20
> Add a new vmbus_establish_gpadl_caller_decrypted() for callers that want =
to
> decrypt their own buffers. Add a new hv_gpadl_type,
> HV_GPADL_BUFFER_DECRYPTED, to communicate the decryption status of the
> buffer.
>=20
> No functional change for existing callers.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel.c   | 27 +++++++++++++++++++++++++--
>  include/linux/hyperv.h |  8 +++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6821f225248b1..4782f5070bba9 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -40,6 +40,7 @@ static inline u32 hv_gpadl_size(enum hv_gpadl_type type=
, u32
> size)
>  {
>  	switch (type) {
>  	case HV_GPADL_BUFFER:
> +	case HV_GPADL_BUFFER_DECRYPTED:
>  		return size;
>  	case HV_GPADL_RING:
>  		/* The size of a ringbuffer must be page-aligned */
> @@ -100,6 +101,7 @@ static inline u64 hv_gpadl_hvpfn(enum hv_gpadl_type t=
ype,
> void *kbuffer,
>=20
>  	switch (type) {
>  	case HV_GPADL_BUFFER:
> +	case HV_GPADL_BUFFER_DECRYPTED:
>  		break;
>  	case HV_GPADL_RING:
>  		if (i =3D=3D 0)
> @@ -460,7 +462,8 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el
> *channel,
>  	}
>=20
>  	gpadl->decrypted =3D !((channel->co_external_memory && type =3D=3D
> HV_GPADL_BUFFER) ||
> -		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));
> +		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING) ||
> +		(type =3D=3D HV_GPADL_BUFFER_DECRYPTED));
>  	if (gpadl->decrypted) {
>  		/*
>  		 * The "decrypted" flag being true assumes that
> set_memory_decrypted() succeeds.
> @@ -575,7 +578,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el
> *channel,
>   * @channel: a channel
>   * @kbuffer: from kmalloc or vmalloc
>   * @size: page-size multiple
> - * @gpadl_handle: some funky thing
> + * @gpadl: output gpadl
>   */
>  int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
>  			  u32 size, struct vmbus_gpadl *gpadl)
> @@ -585,6 +588,26 @@ int vmbus_establish_gpadl(struct vmbus_channel *chan=
nel,
> void *kbuffer,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
>=20
> +/*
> + * vmbus_establish_gpadl_caller_decrypted - Establish a GPADL for a buff=
er
> + * that has already been decrypted by the caller.
> + *
> + * @channel: a channel
> + * @kbuffer: from kmalloc or vmalloc; must already be decrypted by the c=
aller
> + * @size: page-size multiple
> + * @gpadl: output gpadl
> + *
> + * The caller is responsible for re-encrypting the buffer before freeing=
 it.
> + */
> +int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel=
,
> +					   void *kbuffer, u32 size,
> +					   struct vmbus_gpadl *gpadl)
> +{
> +	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER_DECRYPTED,
> +				       kbuffer, size, 0U, gpadl);
> +}
> +EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
> +
>  /**
>   * request_arr_init - Allocates memory for the requestor array. Each slo=
t
>   * keeps track of the next available slot in the array. Initially, each
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 964f1be8150c5..1146addbb42c4 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -70,7 +70,8 @@
>   */
>  enum hv_gpadl_type {
>  	HV_GPADL_BUFFER,
> -	HV_GPADL_RING
> +	HV_GPADL_RING,
> +	HV_GPADL_BUFFER_DECRYPTED
>  };
>=20
>  /* Single-page buffer */
> @@ -1205,6 +1206,11 @@ extern int vmbus_establish_gpadl(struct vmbus_chan=
nel
> *channel,
>  				      u32 size,
>  				      struct vmbus_gpadl *gpadl);
>=20
> +extern int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *=
channel,
> +						  void *kbuffer,
> +						  u32 size,
> +						  struct vmbus_gpadl *gpadl);
> +
>  extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
>  				     struct vmbus_gpadl *gpadl);
>=20
> --
> 2.45.4
>=20

