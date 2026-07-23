Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010003.outbound.protection.outlook.com [52.103.13.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1EB391E57;
	Thu, 23 Jul 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829183; cv=fail; b=bbK7uXh5UFrd3S3T5vZ1JZKF/A/MMK6eP/LvE59TJLZVlnIOC3dhhArfbyv9J39+1wRO0ioYbX8tGZhSWUomEoOxEIDGHGeRlbudaVTXZNzy7rhZWq5/anFSuvwP11/V8K8fDIBGCI+9SdRfvW/yAZYGA2wiI6UNfPyFwB0tFW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829183; c=relaxed/simple;
	bh=FKhSQGnrcvyyBkihs6yJa6o73DRad7G4shZ/f5VM8oM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mzaXrAGvFHwuTs1eqUV0xd0+hv+8LSw3Mc9AKqpU9/Lcr14SgoEF9OfZJlWo0rS89sZlN/56ioUPOP2wCkNvxeuIitnb10lCC6iagShp4aQHNhDsEPesNmKViQ9P4qUC9T4Z5g12nVfUtdUOVUagYQF4/WV1QDxaZSD1ldfatQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Pp3vIRjc; arc=fail smtp.client-ip=52.103.13.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Pp3vIRjc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pj0DgAcNYjLvcrUNhIzhOr/ePUWwwSecprPDhMcLH41kdeCNmZlGxKpSi+fHDaITWy9pcwOgDvENaZgVeowuqka7pQ3bCth4jKYJUMa7yvELXglPcixq35BysoxOy0LJD2u+z1hk+1aRPYtegSu9DARrkskbVRXv0k7ubPNEKHzrNytVwS47OHclFQMoIzuAe5765H9fELDx1FHrgrKJrqnbPRP8/nO8/bpioe3msNU6gQ26ABkGBlIy/vJ/ZMgcqqTbYyL42mwqZSqEfAW3pwa6OypqVjabwbHUFkhwbbeHB1w+54Erkr2tgb/hEZSMwkDizPqPK5/uGCpcZPLehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5wboTqn5uzCzGETihreA1Oy2TZ4dYcSiunvn4J+M2U=;
 b=XtXIg1YHi1oGJ1UzEbNuaredjw1Ri/lT0CZ7uxgN3Pls48ZDo5+2mM6Rsa69VFxI/OmleR66UCbdFMlvq4/TbfH74DNHU5s97DUbtgE3F01YuDbKkSsXSItBp0PajXIOQyk6sL+ViX/bhbQ+CrX14/+/Fu80VfcbDiT8XcNGQhnK4LZpMUsBrsdRNTNIb68ZzF4OLivz43f0MFAn+Ny16ZTrg476WtScnGr+j6w5qHI7LBgbOcitFOBxUMIzQGwEkUvDgOuBDhY9o3JWwwmi2AVFnq5AJBg5jEPUjhOAhChifBC8tv6M1rHHp4biyGJMX5EGC3dfBdQpSR1txM3MlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5wboTqn5uzCzGETihreA1Oy2TZ4dYcSiunvn4J+M2U=;
 b=Pp3vIRjcJMV6Xak4PtY9xCwSUxVYp+SSfA2Y7A2cyH1C+LAZ6FseQ+mMLUCLpRIZDW/VDrxZGpd6Iw48CfQ6ImYLDTtdd0NwA8ukY+1iRU9xMmP71x/pUE0Vxchi8lJzokdiI2QvUqDhqp5mXAYL6En9KJI0qc/DstvxbaV24h0eAtVWn9k72rROqCo7TZlWQTRuoVvr1byuo4SSfr0n6Rz3lDZthAAkIc+mBUv8jK5ye+bTr9rUt9wHXWh0BeVyhztJzlQ3crtH3me6TiZl3kJHJu/4TVFdy5xa9TvTQJX2a5t4SVR5TdWXDVQkwuZAAlELUrip3Z/tlKjvMZrbHg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by PH0PR02MB7271.namprd02.prod.outlook.com (2603:10b6:510:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 17:52:57 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 17:52:56 +0000
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
Subject: RE: [RFC PATCH 1/2] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Thread-Topic: [RFC PATCH 1/2] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Thread-Index: AQHdGUsrGjPPA2jvQk6PwaHM3aptkbZ7ZZXw
Date: Thu, 23 Jul 2026 17:52:56 +0000
Message-ID:
 <BN7PR02MB414815ABD36AD06CA3319306D4C02@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
 <20260721195633.1438361-2-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260721195633.1438361-2-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|PH0PR02MB7271:EE_
x-ms-office365-filtering-correlation-id: c66370d6-2533-447e-c430-08dee8e33a3c
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|24021099003|15080799012|4140399003|25010399006|41001999006|37011999003|51005399006|31061999003|13091999003|19110799012|8060799015|8062599012|12091999003|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D+DoAcmWtPMHU5QaFdV3yE9Ad0nPJjArH1Wr8oP68ydXkIOffNQ+GOnP6I+Y?=
 =?us-ascii?Q?Wpou/0snrO4k3a7jfnvyH56bmE6O4dAp5K5//o3grRI26gW2XbzQccQk5iL4?=
 =?us-ascii?Q?pRdGmkuBF0IwGv9UBjfMkegAZBR3PiwuPGwoBkZkugLva5bOFxu0VG2VvpAh?=
 =?us-ascii?Q?iINj4h/wj5rPLf+YV47DBgNOOKn7VxPQxGUbTliev8cbYk33CRajPcpbIe4K?=
 =?us-ascii?Q?hLXYacFyjOczsITAMh52PzMNcbL+FDkZkZmD4f+AKssZWm18pwbqvn+zIcDh?=
 =?us-ascii?Q?Jvr/oxccAJhRF02q3Zerpl3/QscSn8GdAdEP+PLZyDreA9g1cS6I7N6NjzyJ?=
 =?us-ascii?Q?O/Slq9T0y4EUPS3+mr4RK/iT9UsoPHDoMVu6605Ji3o5Efiiim69xATrNDaJ?=
 =?us-ascii?Q?oR/P5pcJPZ5fyuRNVGP4mSOV7MnmSy3ECXIWboE4lDxw8spYzs9Qp0ELWnDa?=
 =?us-ascii?Q?MXiMbGBwXY7XegPD3+KvMaiz8tViQcK/+jM5ZEe+zOcB2q/rdhy5ZY64JH3C?=
 =?us-ascii?Q?2GTC7G0104iMSPE9290vLmy1hcyHM8G4vFBT+cqDBh1pM0CkKFPCwRM84yAq?=
 =?us-ascii?Q?Q3ct+X53T3QTJ2NaPaFdRq4X97HRPcrpBIP3LDhHFNvLMa8HVSYukzZm2Gk0?=
 =?us-ascii?Q?SljlbA7yWZpu+FPLHnZ6oVEiOwJlObZLlBZgJqj+7yorx/Cmc1pJk3YjXeaA?=
 =?us-ascii?Q?AStdMTGLfElI3X60kaDLZpAYI+/XeJzqB6tbg0TCg/3okFt3JAwzfevBsenX?=
 =?us-ascii?Q?1pCRZ2eU5qZtRpWC+35nZYNVFD1oAOqACAzUXulxJ+b4pHG5kP/shmPDgQ/H?=
 =?us-ascii?Q?HySCnyViko6w0AxnKU0Iyx0zn1IlDLAx30VTYA+KvlXxHz0giqezY43gH+s2?=
 =?us-ascii?Q?kcYNM4R0a7U/RnG+BPP19/Rrp1VRyuVO7NkVkiLrxgEWglLvSxRT0aJrLVmY?=
 =?us-ascii?Q?WxpHJoNqHCXmaBUi3n2bTKrWQc/Mg8ksJS574fPNJwoJn7tdiKbghpansGBu?=
 =?us-ascii?Q?YXrhSnOwmgA81//KH7wA2YV6yXwXwQHy1DRY0K6ugg++8u8psy8mfr6tfQLR?=
 =?us-ascii?Q?HLlGqUfPJsfZ43SwAyWEGGu+IPGx2zumn4WLvJPNkOOrVc9UH2zvGcfXe0Lw?=
 =?us-ascii?Q?M1PXSE7f5k5u?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8S90xtubKWVDRbmaYLngNtlzFX9qm0C3UA1FjBgz6MHT0VNGCW0UfmjgWbQW?=
 =?us-ascii?Q?RyGF6XiLf9LskKBsaqrUP0mtXTae89cZbt8aSWCEzwhonOUzgBFp5U6JgZTG?=
 =?us-ascii?Q?b2yotr15pcL+SFa8mcKdFEDRd0bYALc5/RevWQBmBZB6wPwTpAQKOGPLyAAv?=
 =?us-ascii?Q?QxlDQ0A7Tifluooe5CSlWMuxICrNJJERSG+H/5QMoMX7lCPMmjrs/EZiS51B?=
 =?us-ascii?Q?IZkAPIF5BZI0HePSJt3NtEDiNZROYhUF6zkOLwoCcA0SduUGWjkKvgJR5enJ?=
 =?us-ascii?Q?RB1hQipk7+eCeliKljQx9egH9WVpSxqA7bGcTwLiXpUk2inMxeC2pJ/V/18s?=
 =?us-ascii?Q?PJFHTp5g3woskUPVIR2J0uZZ5F5c2cS2OaAkL05heG18KTw7c7BLpLpo+nks?=
 =?us-ascii?Q?LYvXcv2Qv5snXxWSN1FUNrNwKPzcSbLk4qzDhEj3Uyw2cZkVkkWqa2t0Sn3m?=
 =?us-ascii?Q?d4+1sA2vNnXN4C3tItj26iY0jqU20tHYeRlP88UBskF2RRj0TexeX/aEFvaV?=
 =?us-ascii?Q?6v2toBPjGMfBsuLvDfR9MK+02JgLt1+nISlm7u/3sJEXamnjdnthD6BiLXLm?=
 =?us-ascii?Q?K4aXlw65nrFzHWh0QEaamlplS1NM/BbhbKGQuAyniZUAbJvjuYqAr0IBsQMy?=
 =?us-ascii?Q?3CZJSQiAeNJslVNNziYRI2wmlDcH42xoYvlzVJH3xlo5hTcyfzEk+6LpYqma?=
 =?us-ascii?Q?4gO8kbz/Ex5SHQuIkUmNbMwuwOMR3N2x93yhE9VS74TExFSbsiOglDwicedH?=
 =?us-ascii?Q?96S/rvFC/XBbMh2azYlK7B2ecefVPw0HZNomRkhxEEpMaAqtYefKNn1GTq24?=
 =?us-ascii?Q?8KtAotR2UpLuNL89R1MrPzRFNMMjB0uRYEtUN3fNWqwU/jK3SDRo9MIaUXMV?=
 =?us-ascii?Q?hpdfOqezLMTIVwfQKoo1te+elHDg5cx6FqMqwwPDJC9QixpnVKS3r+sqWN0d?=
 =?us-ascii?Q?FZFh1+Twv7hha3qHXPxHREfq7fYzhuG6AToVU64ZP3WRu3o45Kt2OG9nBytB?=
 =?us-ascii?Q?KL9ZIViwGDzA/4sqlEEK80Mfr5kK8z04GdDMeMgODMO8pkQmiiIh2APZRclP?=
 =?us-ascii?Q?8/h/8vkykfHaV7hJ/6uKPD/XUISNt45zODtqvw5CmvXvmKEA3SmpKK9+wayN?=
 =?us-ascii?Q?0ybLxK+62hwR6SBlpsAearCFA/NX+CIjpxIo5Gqfz4q3Z0kzz+tXBR3Pp+72?=
 =?us-ascii?Q?GfbB3HkNmL/gqimHatGU0Wt9KgJVWpVcBKveGSBrdkUbDo1lx5ygY4JFvTiR?=
 =?us-ascii?Q?1EugbFXD19jP8hGoH6F85jZDrHwlD4+nUW3KeVQyOhqKKaN8dO0AQBx7Tou2?=
 =?us-ascii?Q?hQtAC3ZlSVXbP5BFRpXOFa3+V6lPyd2soxeEecpoRyVAUr6kg7Iadaao3bvH?=
 =?us-ascii?Q?T7b3D9E=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c66370d6-2533-447e-c430-08dee8e33a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 17:52:56.4855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7271

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, July 21=
, 2026 12:57 PM
>=20
> Refactor vmbus_establish_gpadl() to separate the encryption lifecycle
> from the rest of the GPADL establishment logic.
>=20
> Add a new vmbus_establish_gpadl_caller_decrypted() for callers that want
> to decrypt their own buffers.
>=20
> No functional change for existing callers.

I have a suggestion for a different way to accomplish this. I haven't coded
it, but I think it will result in less code churn and be simpler overall.

1) In enum hv_gpadl_type, add value HV_GPADL_BUFFER_DECRYPTED

2) Update hv_gpadl_size() and hv_gpadl_hvpfn() to treat the new enum
value just like HV_GPADL_BUFFER

3) In __vmbus_establish_gpadl(), change this code

        gpadl->decrypted =3D !((channel->co_external_memory && type =3D=3D =
HV_GPADL_BUFFER) ||
                (channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));

to

        gpadl->decrypted =3D !((channel->co_external_memory && type =3D=3D =
HV_GPADL_BUFFER) ||
                (channel->co_ring_buffer && type =3D=3D HV_GPADL_RING) ||
	  (type =3D=3D HV_GPADL_BUFFER_DECRYPTED));

4) Add the function vmbus_establish_gpadl_caller_decrypted() like you
have in this patch. It just calls __vmbus_establish_gpadl(), passing
HV_GPADL_BUFFER_DECRYPTED.

I think that's all that is needed, though I haven't gone through
everything rigorously and might be missing something.

FWIW, the meaning of the "decrypted" field in struct vmbus_gpadl is
a bit abused, but it was already that way. In current code, it initially
means "decryption needed". Then after the gpadl is created, it
means "was decrypted" so that gpadl teardown will re-encrypt.
But my suggested approach doesn't really make the abuse any worse. =20

>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  drivers/hv/channel.c   | 123 +++++++++++++++++++++++++++--------------
>  include/linux/hyperv.h |  11 ++++
>  2 files changed, 93 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6821f225248b1..0166367a4df37 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -426,7 +426,13 @@ static void vmbus_free_channel_msginfo(struct vmbus_=
channel_msginfo *msginfo)
>  }
>=20
>  /*
> - * __vmbus_establish_gpadl - Establish a GPADL for a buffer or ringbuffe=
r
> + * __vmbus_establish_gpadl - Establish a GPADL for a buffer or ringbuffe=
r.
> + *
> + * This function only handles the GPADL handshake with the host.  The ca=
ller
> + * is responsible for ensuring that @kbuffer is in the encryption state =
the
> + * host expects (host-visible / "decrypted" for confidential VMs); this
> + * function never calls set_memory_decrypted() or set_memory_encrypted()=
.
> + * It also leaves gpadl->decrypted untouched, so the caller must set it.
>   *
>   * @channel: a channel
>   * @type: the type of the corresponding GPADL, only meaningful for the g=
uest.
> @@ -434,7 +440,7 @@ static void vmbus_free_channel_msginfo(struct vmbus_c=
hannel_msginfo *msginfo)
>   * @size: page-size multiple
>   * @send_offset: the offset (in bytes) where the send ring buffer starts=
,
>   *              should be 0 for BUFFER type gpadl
> - * @gpadl_handle: some funky thing
> + * @gpadl: out parameter receiving the established GPADL handle/buffer/s=
ize
>   */
>  static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  				   enum hv_gpadl_type type, void *kbuffer,
> @@ -454,30 +460,8 @@ static int __vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>  		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
>=20
>  	ret =3D create_gpadl_header(type, kbuffer, size, send_offset, &msginfo)=
;
> -	if (ret) {
> -		gpadl->decrypted =3D false;
> +	if (ret)
>  		return ret;
> -	}
> -
> -	gpadl->decrypted =3D !((channel->co_external_memory && type =3D=3D HV_G=
PADL_BUFFER) ||
> -		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));
> -	if (gpadl->decrypted) {
> -		/*
> -		 * The "decrypted" flag being true assumes that set_memory_decrypted()=
 succeeds.
> -		 * But if it fails, the encryption state of the memory is unknown. In =
that case,
> -		 * leave "decrypted" as true to ensure the memory is leaked instead of=
 going back
> -		 * on the free list.
> -		 */
> -		ret =3D set_memory_decrypted((unsigned long)kbuffer,
> -					PFN_UP(size));
> -		if (ret) {
> -			dev_warn(&channel->device_obj->device,
> -				"Failed to set host visibility for new GPADL %d.\n",
> -				ret);
> -			vmbus_free_channel_msginfo(msginfo);
> -			return ret;
> -		}
> -	}
>=20
>  	init_completion(&msginfo->waitevent);
>  	msginfo->waiting_channel =3D channel;
> @@ -553,19 +537,47 @@ static int __vmbus_establish_gpadl(struct vmbus_cha=
nnel *channel,
>  	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
>=20
>  	vmbus_free_channel_msginfo(msginfo);
> +	return ret;
> +}
>=20
> -	if (ret) {
> -		/*
> -		 * If set_memory_encrypted() fails, the decrypted flag is
> -		 * left as true so the memory is leaked instead of being
> -		 * put back on the free list.
> -		 */
> -		if (gpadl->decrypted) {
> -			if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
> -				gpadl->decrypted =3D false;
> +/*
> + * vmbus_establish_gpadl_and_decrypt - Manage the encryption lifecycle o=
f
> + * @kbuffer around a __vmbus_establish_gpadl() call.
> + *
> + * Decrypts @kbuffer (making it host-visible) unless the channel was cre=
ated
> + * with confidential memory for @type, then establishes the GPADL.  On
> + * establish failure the buffer is re-encrypted so the caller can free i=
t.
> + *
> + * Sets gpadl->decrypted; see the comment on struct vmbus_gpadl::decrypt=
ed.
> + */
> +static int vmbus_establish_gpadl_and_decrypt(struct vmbus_channel *chann=
el,
> +					     enum hv_gpadl_type type,
> +					     void *kbuffer, u32 size,
> +					     u32 send_offset,
> +					     struct vmbus_gpadl *gpadl)
> +{
> +	bool decrypt =3D !((channel->co_external_memory && type =3D=3D HV_GPADL=
_BUFFER) ||
> +			 (channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));
> +	int ret;
> +
> +	if (decrypt) {
> +		ret =3D set_memory_decrypted((unsigned long)kbuffer, PFN_UP(size));
> +		if (ret) {
> +			dev_warn(&channel->device_obj->device,
> +				 "Failed to set host visibility for new GPADL %d.\n",
> +				 ret);
> +			/* Encryption state unknown; signal caller to leak. */
> +			gpadl->decrypted =3D true;
> +			return ret;
>  		}
>  	}
>=20
> +	gpadl->decrypted =3D decrypt;
> +	ret =3D __vmbus_establish_gpadl(channel, type, kbuffer, size, send_offs=
et,
> +				      gpadl);
> +	if (ret && decrypt &&
> +	    !set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
> +		gpadl->decrypted =3D false;
>  	return ret;
>  }
>=20
> @@ -580,11 +592,40 @@ static int __vmbus_establish_gpadl(struct vmbus_cha=
nnel *channel,
>  int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
>  			  u32 size, struct vmbus_gpadl *gpadl)
>  {
> -	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer, size,
> -				       0U, gpadl);
> +	return vmbus_establish_gpadl_and_decrypt(channel, HV_GPADL_BUFFER,
> +						 kbuffer, size, 0U, gpadl);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
>=20
> +/*
> + * vmbus_establish_gpadl_caller_decrypted - Establish a GPADL for a buff=
er
> + * whose encryption state is managed by the caller.
> + *
> + * @channel: a channel
> + * @kbuffer: a buffer that the caller has already transitioned to host-v=
isible
> + *           (decrypted) via set_memory_decrypted() or an equivalent mec=
hanism.
> + * @size: page-size multiple
> + * @gpadl: out parameter receiving the established GPADL
> + *
> + * Unlike vmbus_establish_gpadl(), this function does not call
> + * set_memory_decrypted() on @kbuffer, and the matching vmbus_teardown_g=
padl()
> + * call will not call set_memory_encrypted() on it.  The caller is respo=
nsible
> + * for the full encryption lifecycle of @kbuffer; on return gpadl->decry=
pted
> + * is set to false to record that vmbus does not own the encryption stat=
e.
> + */
> +int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel=
,
> +					   void *kbuffer, u32 size,
> +					   struct vmbus_gpadl *gpadl)
> +{
> +	int ret =3D __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer,
> +					  size, 0U, gpadl);
> +
> +	/* Caller owns @kbuffer's encryption; teardown must not touch it. */
> +	gpadl->decrypted =3D false;
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);
> +
>  /**
>   * request_arr_init - Allocates memory for the requestor array. Each slo=
t
>   * keeps track of the next available slot in the array. Initially, each
> @@ -685,11 +726,11 @@ static int __vmbus_open(struct vmbus_channel *newch=
annel,
>  	/* Establish the gpadl for the ring buffer */
>  	newchannel->ringbuffer_gpadlhandle.gpadl_handle =3D 0;
>=20
> -	err =3D __vmbus_establish_gpadl(newchannel, HV_GPADL_RING,
> -				      page_address(newchannel->ringbuffer_page),
> -				      (send_pages + recv_pages) << PAGE_SHIFT,
> -				      newchannel->ringbuffer_send_offset << PAGE_SHIFT,
> -				      &newchannel->ringbuffer_gpadlhandle);
> +	err =3D vmbus_establish_gpadl_and_decrypt(newchannel, HV_GPADL_RING,
> +						page_address(newchannel->ringbuffer_page),
> +						(send_pages + recv_pages) << PAGE_SHIFT,
> +						newchannel->ringbuffer_send_offset << PAGE_SHIFT,
> +						&newchannel->ringbuffer_gpadlhandle);
>  	if (err)
>  		goto error_clean_ring;
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 964f1be8150c5..9c6b1b7794b48 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -781,6 +781,12 @@ struct vmbus_gpadl {
>  	u32 gpadl_handle;
>  	u32 size;
>  	void *buffer;
> +	/*
> +	 * Only used if the vmbus layer owns the encryption lifecycle of

s/VMBus/vmbus/

> +	 * @buffer.
> +	 * Indicates @buffer must be re-encrypted at teardown or that it
> +	 * must be leaked because re-encryption failed.

Overall, this comment would be a bit different with my suggested approach.

> +	 */
>  	bool decrypted;
>  };
>=20
> @@ -1205,6 +1211,11 @@ extern int vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
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

