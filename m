Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013085.outbound.protection.outlook.com [52.103.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92883AE184;
	Thu,  8 Oct 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480201; cv=fail; b=jMmIgR8BGZFhCmAqd4Ly17Xx45TE8SHQvG/GLGYPsBPAN2WETmLOtUQcLy+olT7wnYmjqvk1fqJ0pTHfb/j1fSSYbzUHvshezJDFB/TvGKe7KzyV8Y2pc2vwrueuRQS3R2PjElDq3bgVFQwvjwpaHIAd2DeMGXbCdUuZo/N7Z48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480201; c=relaxed/simple;
	bh=jvu/yoa6XeBdDGbrL0c/wbHXnVo+2bo1CgByqdlp6I0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b1LDNnTQxIYHpgCZIjO+Ul+oqVkRJ7YlUl32Wv1OSifRUq0xSkyjrjwqzgmrv45ZaKWAf+s467FZOLKWsnasXJc/5fZolzM9WCcCLgOCpFKX+7zUkS3nzfDubQMA2/JTCbkecF5m435WzZK/pbhGY+ZSP9JxBCTsum2U1qOKPSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ebcyb+Zg; arc=fail smtp.client-ip=52.103.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ebcyb+Zg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPy4SBR1KYr59fCYrhjCVkyc6BTK2rHpfp5Hw6ungpbU0dXs8tsbcKottM07oNsytQQEe//a550wcQen/HVV/VluyE27MzVZ2oBQ714qXyBxQDpME36cEOptudUWBRgS85mIYWTs2T1Srw2YsjyRKHZBds4fBUAhvE3zIvU94KitxY1q1q10y8BHroK/1iPm0Il9oW6RozonZHIEt5Et6TQ8Pe9xwEeUT9Ywu7MD1h3e2GEM86uVF/ITmARClyaQY361AIjkzQfnBuydJ1llwPx8BBoMMbzlewohlgRDLbm35/814BpjiyGNmEyNFOu1b+sSuZTI37Ona9UF/pfCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i3nHPRf3XNmAu3nJjTA+8Sdpd19Ea9ng+D/LKa0p74=;
 b=k0ta/r3Ap6HasqVTnEVa7Bcadx3W99eV7ms6rNLoxGDuUt6OwCtCt5W5oqIuJmCRRSR9evOp1JZQAXVCfOXa/RMJ57xJP6FfSbrApeBi6qUVqRHthFs3S+fLppqx/zOKvP9hwK5sAOXcJ+7CmYRds5TlK4IZCh49C9/UsYSxNpN9aaTxn0bfByIjoGtKBvSTRBQYlqfLE7FvRazDd/TVshPprgeQrAEzjXwpqIWGFm9D0rje/oDqcUkMVB/x1vHfDIg7Jm8cbt7heoyn7XAkGShnSeW5ZD5P+CBZuvRytXL6mVE/YW2xx5B1Lex7bGZ5wy41JTia1ytPh0CnXW6lVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i3nHPRf3XNmAu3nJjTA+8Sdpd19Ea9ng+D/LKa0p74=;
 b=ebcyb+ZgcsUor7MZbodlVAs/2S8DBAo7SXfEN3vzdpYoUK12A1C4nAxl/MArwomflJVCK9eDn+FIBSfpg966Bn9OKf8KGieWXtGKCKec2YIaztzn/y9ndxe+I6hy00ToJmXder3jaE94lHJdLo3lMv+1DYtrd1KBR1v1Sf5kHcXy8egURRagvYMrfxttK3Nx3O/WUdNR+0BEe3yYGMxP9IXPT5iOaZotfkt+/5/xRvfAaxDpEuZeVhnYYhMpRejI2E1Mw+A55xFI/XXRbKi5WRs7vyNJJFVf1xCN5yOLRhgk9olXtcogsOoAfd05075DuKB+a7WehFSBcHFPCGWuYQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB7165.namprd02.prod.outlook.com (2603:10b6:a03:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:23:16 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:23:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] Drivers: hv: vmbus: Bounds check the shared ring
 buffer indices
Thread-Topic: [PATCH 1/4] Drivers: hv: vmbus: Bounds check the shared ring
 buffer indices
Thread-Index: AQFOJEjNF6VkbcuqUxfhl9QR1YCS0QISl8pyuAB+vBA=
Date: Thu, 8 Oct 2026 17:23:16 +0000
Message-ID:
 <MN2PR02MB68634AB3464D951691B060C4D4932@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
 <20261001221040.1794904-2-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261001221040.1794904-2-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB7165:EE_
x-ms-office365-filtering-correlation-id: 9277bfe4-d5d2-49a4-1934-08df2560d6fc
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|25010399006|13091999003|31061999003|24021099003|41001999006|8060799015|19110799012|8062599012|51005399006|15080799012|37011999003|40105399003|12091999003|2607281247196008|102099032|56899033|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rhsLIl3esFoCmO3V75kLfjbdwdn7cJUaF1va1RbodlagB+dbNHMM4p2Dz4MJ?=
 =?us-ascii?Q?Rd6eyhSkNVGAZuGNtlx6yssCODkI19emeJ8qL5Nd3m5aOObieCc8N8W6c5a0?=
 =?us-ascii?Q?7Tl//I2yZCmwbrOwnJqwlu2jq02U+ELmup1ZzqtNR+I7C7SoT9oq/nTqz+UK?=
 =?us-ascii?Q?02Gp/FQ+1cMQ4QLN4Q/EHlDLWo2bt8E4P7hMfFGRTscYiJZU03/RzS8YRKy/?=
 =?us-ascii?Q?kx0+Gjs2MJo+iarC0odJk5pibwZVUK07+jTKb7BuH+kqE9Zk4FsozseU4adZ?=
 =?us-ascii?Q?AeTiC/vFhmXXwJH3NKymbIs+zC3vvzSulf55GI1qv4a5zEwflKF1CL7tzL9M?=
 =?us-ascii?Q?WiaE3HSSlYOcRthmI5nRwSPUQbMCLsDVIO/fGXLY55rpVYluKM2AmJk1cMa0?=
 =?us-ascii?Q?UaemMmtZks1kKXVyb70uv0C1qgCgnERN4gBze/y7z6FmqqMF2bv0ZPr+Ktg3?=
 =?us-ascii?Q?S3+I8qFKv+5ayCrea4/hWWV6k2bvFl93QouvHsJCFUj6MNUv/HzSZAGQI2Pg?=
 =?us-ascii?Q?lz/VmE5eIw+Ia8o6OdDnW+58irSKuGDmNROrmi/9/WhjzunIYA2LQMRkXLDP?=
 =?us-ascii?Q?WRyzs3JMg6SnjaaDqFWvB5GlTOEn95LnbCeAQWa79hybnp6k7Bd228xcfDhQ?=
 =?us-ascii?Q?z52W1dbo/BWrlxFk2BMNV3+jPKB1YJPNnI8pQHqZESYH4HMKTYlu/eiB5rRj?=
 =?us-ascii?Q?k5a6Kpe4OF3J1HV2fK9tLwvrj8yNxczDSrxPzIEMxO+zwLrm5eBFaSRnZR9j?=
 =?us-ascii?Q?6G5l3CfwtSYjke56ymBtf962ZkUWhFawGNz3J6Uqc3pfuCKElV/f4xQoLlLt?=
 =?us-ascii?Q?OUinShXV0EAc5ZskF4vrY5muswF15ZOSE+JPSd9pKR+NOuUtDADMTrNP58f0?=
 =?us-ascii?Q?1lW/tW70URka/NyvZLOmL8SeB7OGuW7Pg2oet0AkYXdECywc2FA+N6orKy0e?=
 =?us-ascii?Q?Upbia87FUChW2Ju2YbAXsA7Sqt6lOVcIxcMiJWXUeadvWndDtelWt0Qh+Izc?=
 =?us-ascii?Q?8MOYQs2echwbKPvctnIjMi+GioVMvJTAFWhF6sXsqgNTMgYyQ4JBoMcAxmtd?=
 =?us-ascii?Q?j+uVao0k7matZDKHLsFEtpTqWxBfDNRJUTLCDdTkPDR/YO96XoI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?57Eqlu4AVJMMDBgsLKO1bDSW9k7PMVapH/1d+oG40BFcpbu4mV4oaA+j+5jh?=
 =?us-ascii?Q?9b8JfUSuOzLw3GroKhxihr/xkibkA/gpCm8MhNi/r1tdlw/4XXWgCpj5mv8+?=
 =?us-ascii?Q?7LkuISdO3OTWGxmJ/cnpXOpVrBDABHblr+zh9XF9mNTiFOnPs3IgzVD4bt/B?=
 =?us-ascii?Q?E8gq3MfzN55cUuVaveVrKDWwQ0JGBYS1y2+GcBTm8a56M6VltUyOZM1Yh/am?=
 =?us-ascii?Q?SLM/ncRbAqAyPCfq0a3LpEHVYhrZdlw8JBgxewzn12OqfMYBXvsJHKdzb82S?=
 =?us-ascii?Q?t+8kYMnxCrl+oLVIKPyKFIRVrtlqce+9LLs74Eta+2IB5Kj42jbNvNInryfj?=
 =?us-ascii?Q?JWVE4LV3DcgJwP2SAMBTdDIEE/vLJfvWYhr1R3uZDK/iE+KHduE57ELyTvyn?=
 =?us-ascii?Q?nwrNgbg8UoUiVj8KVw0mKlhU7upPsc1KVRqYVL+qY4IvS9231x6SFqiJNZtY?=
 =?us-ascii?Q?Afmd+GNtb0d3UmO0ebTi6SdLU0vErgQ/CZwILHh82t8rnhVy04p2iK2+sHSG?=
 =?us-ascii?Q?grWAS9T09KsBh2/O+KEX9ibxxUeur4fjU9gn38HGPmT11nzx8TUEC5bOFoWk?=
 =?us-ascii?Q?u1DMZ1Wi5fFPCXmKoB4YTBP2+F0/Xz/Iv7RsndvNtFKr2eny7/g8RvT6nuD2?=
 =?us-ascii?Q?L+rdzo+psqP0xNTh+rsmiu9WV4+Qsd9rbYRurzL8AK6wp2H95Hyk65xzvpDb?=
 =?us-ascii?Q?s+Vx8+Wjmn0tN85Shl1G/LS1JIJOlGjYbMTdNM+zSJ2afS1078YCaKmLRFjf?=
 =?us-ascii?Q?WYFiwhgtSka1aHOYWclZj2DcehdpMgbEaxTrWSL0GWkH1zStl8v0YTUsshvl?=
 =?us-ascii?Q?RoqWKM6JhUJXQ6EovyPnEZzsOF3wkBx4CbqPIwQdP+UBuqseUGQURiWziN6J?=
 =?us-ascii?Q?mkN9yoJ/La0giPeW/vjELF61gaDqoKgO6HjJBBIvyhjicE/2Pt09kFjNTyPr?=
 =?us-ascii?Q?cBFllXsQ7ZalJUxX7ZOeFpbtYysa4BoO2z9dCiS241w8aZ0knaqGQNi37dk+?=
 =?us-ascii?Q?MbXRZccR+M7iuS6Ku3QEYT1LKeWgVgODD1qRLrO1dlGuKgotvU9tNMManIzi?=
 =?us-ascii?Q?DXBclzl/72YptN245O/+AV2CN1cyQOedLjjgGsCUHteWmOS1VF6EifTIyEG/?=
 =?us-ascii?Q?NRVYbifJuVpc0XjIUOQXiWOcdqfy5rocohyyGaQTHiSGaVxzHE5GCwcYDra/?=
 =?us-ascii?Q?TNB5TdkrX9AkXpxDLIs9XBvwtsQcWDLHtGx3/ck8i+wMO1JKqAY/xHtCF4bR?=
 =?us-ascii?Q?o7flZA5tRaEy4P6WGP5kdIkGuJ7fCKB+6cQC3Gfx+jrN4Rm3CslMY8K7Zi5J?=
 =?us-ascii?Q?TukhCgzPEgagWHs+VZOxzV51BcwcAVqrZF0k6JTug2MX+B6uXIvuHBCR9Jy8?=
 =?us-ascii?Q?RGy2aDk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9277bfe4-d5d2-49a4-1934-08df2560d6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:23:16.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7165

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, Octobe=
r 1, 2026 3:11 PM
>=20
> In a CoCo VM the host is untrusted. Since the VMBus ring buffer read and
> write indices live in shared memory, the guest has to treat both as
> potentially malicious.
>=20
> hv_ringbuffer_write() copies into the ring at write_index with no bounds
> checking, so the host can make the guest write packet data at any offset
> up to 4 GiB past the start of the ring buffer. read_index matters too:
> the available space derived from both indices is the only bound on how
> much is copied, and an out-of-range index can make it far larger than
> the ring.
>=20
> The fix is to validate both indices before use and to use the validated
> snapshot instead of re-accessing. For invalid indices,
> hv_ringbuffer_write() logs and returns -EIO.

There's one place in hv_ringbuffer_write() where you aren't using the
validated snapshot. Using the validated snapshot is deferred to Patch
2 of this series. I presume that's because the guest does not use that
value to index into the ring buffer. The value is only written to the ring
buffer as a kind of post-header for the packet. The Hyper-V host must
already be protecting itself by validating the packet that it reads from
the ring buffer, so presumably it would catch the bogus value. Net, it's
OK to read write_index again and use it unvalidated for this purpose.
But perhaps this situation should be noted in the commit message or
a code comment so someone later doesn't think it has been overlooked.

>=20
> Open-coding the bytes available arithmetic keeps the fix free of
> prerequisites; a later patch refactors it into a helper function.
>=20
> The unchecked write goes back to the commit in the Fixes tag, but the
> host is only untrusted in CoCo VMs, which Linux has supported since
> v5.12, so the stable tag starts at 5.15.x. This applies as-is to v5.15
> and later.

Arguably, this paragraph goes below the "---" since it is commentary
on the backport process rather than part of the description of the
commit.

>=20
> Fixes: 3e7ee4902fe6 ("Staging: hv: add the Hyper-V virtual bus")
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

My discussion of the commit text notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/ring_buffer.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 592a960..a18b309 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -70,15 +70,6 @@ static void hv_signal_on_write(u32 old_write, struct
> vmbus_channel *channel)
>  	}
>  }
>=20
> -/* Get the next write location for the specified ring buffer. */
> -static inline u32
> -hv_get_next_write_location(struct hv_ring_buffer_info *ring_info)
> -{
> -	u32 next =3D ring_info->ring_buffer->write_index;
> -
> -	return next;
> -}
> -
>  /* Set the next write location for the specified ring buffer. */
>  static inline void
>  hv_set_next_write_location(struct hv_ring_buffer_info *ring_info,
> @@ -281,6 +272,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>  	u32 totalbytes_towrite =3D sizeof(u64);
>  	u32 next_write_location;
>  	u32 old_write;
> +	u32 read_index;
>  	u64 prev_indices;
>  	unsigned long flags;
>  	struct hv_ring_buffer_info *outring_info =3D &channel->outbound;
> @@ -295,7 +287,20 @@ int hv_ringbuffer_write(struct vmbus_channel *channe=
l,
>=20
>  	spin_lock_irqsave(&outring_info->ring_lock, flags);
>=20
> -	bytes_avail_towrite =3D hv_get_bytes_to_write(outring_info);
> +	read_index =3D READ_ONCE(outring_info->ring_buffer->read_index);
> +	old_write =3D READ_ONCE(outring_info->ring_buffer->write_index);
> +	if (unlikely(read_index >=3D outring_info->ring_datasize ||
> +		     old_write >=3D outring_info->ring_datasize)) {
> +		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
> +		pr_err_ratelimited("outbound ring indices out of range: relid %u read
> %u write %u size %u\n",
> +				   channel->offermsg.child_relid, read_index,
> +				   old_write, outring_info->ring_datasize);
> +		return -EIO;
> +	}
> +
> +	bytes_avail_towrite =3D old_write >=3D read_index ?
> +		outring_info->ring_datasize - (old_write - read_index) :
> +		read_index - old_write;
>=20
>  	/*
>  	 * If there is only room for the packet, assume it is full.
> @@ -317,9 +322,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>  	channel->out_full_flag =3D false;
>=20
>  	/* Write to the ring buffer */
> -	next_write_location =3D hv_get_next_write_location(outring_info);
> -
> -	old_write =3D next_write_location;
> +	next_write_location =3D old_write;
>=20
>  	for (i =3D 0; i < kv_count; i++) {
>  		next_write_location =3D hv_copyto_ringbuffer(outring_info,
>=20
> --
> 2.45.4

