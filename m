Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010021.outbound.protection.outlook.com [52.103.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB23191C8;
	Thu, 16 Jul 2026 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224673; cv=fail; b=rbZwEhLIWlkslJRWJd7zhz4nWdnuzHay34FMRl0dBZQFsPB3PdDxyog9V5Zs2vZpm9ov8++qbEEEbv2Fe+Dga7Yn/8YdBSeh2Li5dswTtshHvsAf/jXaTaFK4bw8ljM+w11OqNMh2sOOaBlHZP+rd2SS7CL9moDEAhxX4jCIsLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224673; c=relaxed/simple;
	bh=aDdU5ruM+Z90LtF+mru+f42fBERBQaHvxu6Ugy36ML4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGEhnnDi+aPwlmbA8b4/FC5IU2qEzyxyCm7s1fuVNN1KT9vS3GAea0asl0hWCMuLnuZFieZL93ELPvsZbxbOk3TDo1fJJKZbPwby5OGJzwKICgYZkJHtI/DkW1g60BIHpSX3Lf48Cpd00FazISz384yY2x2H2L6R/9omnClHoPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sQK9vE/Y; arc=fail smtp.client-ip=52.103.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sQK9vE/Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7YIMLNHpRGpqrDpC5mBXWOfdZtscoqmILgF+sMNnrNr7LgPnhFqHvGzL5vbhRQUAjmiMm9ZfE5U2C9B4OYlF+/Qon0UB6d6kiS1a7xMlpMRmEK0aFq0jyToSLOWOuCWSzSZDMVJ5febhQZvY9tPIh2AyiE/5/puHUPiRWCx6GnE4B7ZSop64CFPyzoIPupjEFTHdISHM5p81l5kgnqfGKNnD3YrAxFdPrtuLfZrorD0sybrbzeygT2o43n3C8JVCShvhKbz1FIAQXo++9TAi8IGDB7aixig3xzXbaniTNNcEAVX6qc8z5ilsAi/yXMiZl8gONz1CSW6kQvfwLaDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olkCSdYynFoa/OeYlrYMQFCeiC+Vk+Hh6qHEBaoer/I=;
 b=SM1BoQ8hFlIfOvC5oDvSdJCCEPP5IxSq90IvcmS9r1Gd4+/prx/ZLbUlLqj0WkrUiD12hsK82LzZtgCTNga6Bn1N+WZUZQhT22Ijb8ZroiS5M4Mc8/8cN97Ot7SxV1kYf+hY99uQIjzBkPirjNEn/G3Qy6kmEXRnPWbt7cRTiI7sp0YUoD61WrG2g2mH1aD9/mk+/s85EXybXWqvktSHtuFpuaZEdUa7dzyB8vS10rS2jm4Sbsx6D6b54szicyZPH1wg0/QrjVM4PaYFOtTTzWf1mlp39+MJujWwZpoTma2mviL75BkLzysiXtMR4+EYzyXqWwvdwT4TAlPrcIrRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olkCSdYynFoa/OeYlrYMQFCeiC+Vk+Hh6qHEBaoer/I=;
 b=sQK9vE/Y17Zf+zD8fsJdZcFLeUK47kxjJvU/jp1LX2dbHNKKOmCmkXES+AV9zxfhb/MLKR0JvRzkf1aWGHeCZ/uljXxZprxJXY+Y7tGvhKJvG2tRF9X4p7kgYlEFxdi1wcmhm5kr6qsUm2YNZS68/z7IVvAeew+rdKAOPMeSLAynsbPnMLhn1Dq7EI9GbbB0Oc5zKGWi5ITHSDNvlmJo2R2neqMKq87076ARkPnqaF7qkBnSrAFUxj7EiDY00Cv5Uif1Blb6vu3TfG6kcO6frCYedEXVAdSUnbw/0jKEzQJRm2BwlYYHjEbZeC48V3cIL3lNLoK/VQ841biPQopGNw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6820.namprd02.prod.outlook.com (2603:10b6:a03:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 17:57:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 17:57:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Set DMA coherent mask for VMBus
 devices
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Set DMA coherent mask for VMBus
 devices
Thread-Index: AQDXjBRrCKtGZX/zjU8VCx4m/kJzG7h7gBlw
Date: Thu, 16 Jul 2026 17:57:49 +0000
Message-ID:
 <SN6PR02MB415756E14DDAFCD7ECED3971D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260608020616.52852-1-mhklkml@zohomail.com>
In-Reply-To: <20260608020616.52852-1-mhklkml@zohomail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6820:EE_
x-ms-office365-filtering-correlation-id: b77f3b0a-c3c1-492e-c564-08dee363c02b
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|51005399006|25010399006|31061999003|8060799015|24021099003|13091999003|19110799012|8062599012|12121999013|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kCZ7uv3yGuev07xlbxRqlcpMTZ6fX/zs2elgb6ia6s1X1Nr0Oc/3AlYeyi12?=
 =?us-ascii?Q?ue/ZhrkXPmQC2uWejkxejCE7ZaynQHtBeZDo0u/RyxcAFpqbBFowq295CEWg?=
 =?us-ascii?Q?lUV1ltOnQtnGh9Q5O0vJ3+8dcI/nteCH11mtdW6ZWRMmP5OoItlJqG9oyEbL?=
 =?us-ascii?Q?b+BG+hp/SCiEFCfRxtRDCIAqg7NPA+UoAXtfb9N8GqIhNejEYQoUvTs19ZZT?=
 =?us-ascii?Q?wwSy7XNBAEq0+hx5AT4zq9PuR1BGvDeE8hRhOxpF2B6WT0VbVTl0F1qrPmH8?=
 =?us-ascii?Q?rN4e8egld+euKny3tVKlApbcf5WUK2BfXMcMzmDB3Q4Ke07ZjBSD1/JMYdly?=
 =?us-ascii?Q?vOmpyuWX/qlL1pdt9PKOfZ8dthyrZe1TyhGEiM8bnRLaisThPMqoJxveXmni?=
 =?us-ascii?Q?SYD1ESLmph+qjmUdEVJ/DVnrKss/ZLhOcMsSfR4eYsmr9D6FxwDRnvdrB6N/?=
 =?us-ascii?Q?lltEWp31AoTqtbohD0R1/HYbIu5QkgGfkOdWFfmfis2hV5fk2Yn7IBQp5UL+?=
 =?us-ascii?Q?glTpQfvsfIlnfaiuFoDIX7CNT4RaFnGsHxItdYLmElDDqffq89ublOlLVHbM?=
 =?us-ascii?Q?GUhIyH7pKUpWZSjkI3CQIg/JPSbQ0OO9FOzzIXV9qHn9qocq9NH4mOSmtvd6?=
 =?us-ascii?Q?PRFXYiifaVm8aM/bZCi4IPRbu75jdmOsdoBT5KOH6BzClSOf4AnysTNXXhAL?=
 =?us-ascii?Q?scpUw3BScYII5DggNkrSQhiVsa9Pw2oT3aFO/MPBykxWCr4k7xoOLcTH2xIL?=
 =?us-ascii?Q?7SE9tjOZ+91besziVQw1+dkSLdsL2r5PqmDuA2VVyTUeYdZUdTryTeSrsudy?=
 =?us-ascii?Q?QLJaERfDzF4E1AmpJOq3qJhrry9Ty5vKX5SE1uCNLt6GL3JNOOB+LK3T/j61?=
 =?us-ascii?Q?lu+yxycEI+/sj0utCoUbqP/fYHW2Us6AinFq23mRWDu0FGdg9NkPJD1zrpY4?=
 =?us-ascii?Q?BqvQaZ6teoa6Jr9uu50hi1DpMjeG4XrErfsgYmUmUfvhmdjvm8v1fkGv+StX?=
 =?us-ascii?Q?7Wmg6x4BBZNPRqhaLXiUfki/ZUjsTQUHvPgKe9AGRo3NBkg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GHGM9Gt1WJ+6MTzbEDXx1gy3wJLEk1/uajFEZU12iZCzn1GJiaMf1WUnf+P8?=
 =?us-ascii?Q?9oFXggdaNrL3AZ6BCQoQ/oAeOmBOyeDfr2rdi4CCjN0c9ArjICIF+jCISQo1?=
 =?us-ascii?Q?I/8oRahKnUI6Nz3WArV37CgzrRZt3hOdHLcQC3XALDvWxKhTKmdYTaEmEhcH?=
 =?us-ascii?Q?tokgAuFIiVvURfyRlQT31fW/tCY2CB2Vh1VnZUZKebiYlI/F2hbAaP4/9k5J?=
 =?us-ascii?Q?6bq2CiEpLHB69zOa8On2KNoznSVw3XdcZ3foDPfw3FLFncVBBgRElK/4WQmV?=
 =?us-ascii?Q?G6Fp5EuXqjEkplw4N2hItCAUSOgdad9JNBjGxBwPTG+LnVZ+TIuO7SU+uH4m?=
 =?us-ascii?Q?p9cuq7OhxXWDZeYwgofcA5f6hx0aFWVIWD7WhZ46U3bCiW0fJ9GzRNmqd9KW?=
 =?us-ascii?Q?NBKT6ChqKqKM/nzZOQ0Gphu9xRvK6wUieqLyrGdK5PpqBAxamWO/gh9rPO0j?=
 =?us-ascii?Q?YfYRljzMQOeR/oPblc9iLpQURT+PtruY/bCBgbTzcOyMg9OWxvBpO88RotI7?=
 =?us-ascii?Q?if8fV2wz0ADyarDcdpO71N36a9SENTeXw/e5cccWzhslwnssZLx1/rZGgAgg?=
 =?us-ascii?Q?m1QTlge9nHHIQlrO/CBGNd0BkEpBEkjokm4xs6XoGjB4gsdVMpzrIRjZgFwp?=
 =?us-ascii?Q?acTw50Y78ZoTSu8JX0pYaAh5EdmCNXZ3pNV6aN4HsF3xtMQbqkudp0vg9fEn?=
 =?us-ascii?Q?ZcCgXPXNMIDt6Toao0icGJKDCirvP4NuZVS5hKuP4nOxJeqi3avdOeHJQlXo?=
 =?us-ascii?Q?qzoDVtsOZj6tpYOGwYykG4w6zaueA+Q1gY2Ydrj6I440X3GDkv2b/3tgr57o?=
 =?us-ascii?Q?evzrHGoTfL29VvKbiILSh035luYczOUCPwCHUCC/HCn7zBChYt+z505Zd28D?=
 =?us-ascii?Q?Ju4hXZL/DFy/kBHl4xCvvuuAp1EeMha6X+Cw6Y0PsZjMH6VbBg2D/P7dridy?=
 =?us-ascii?Q?wVg9PUO2PTpawOWM0DKoTjTpM2HJ7HAiNkyFmAWwdAFMEQpRGLWxvAQLi2wJ?=
 =?us-ascii?Q?JZMyWZuMOk9ft7p0IrBadK+sRnxVd2zqGQj6bpm17OgLUUhhB9uXXBw/rCa3?=
 =?us-ascii?Q?/Qnz5bD//MjsDUtYZi7ue6ljmevt3zLeweF62V/rdilwsbntJm51oh6BJ3Gn?=
 =?us-ascii?Q?Mkcj7aDep1gOjM7WnsI3sHGuEhEI7cE9NUCDkOoHMtmajqSbWSFykL2DJlLV?=
 =?us-ascii?Q?0VA5F29XOdHN/ToxkGjbBsGkcKryfIY2QUeCUWaIRaTYMa7MWuE5RvBgAoUa?=
 =?us-ascii?Q?2YvZALTKl3ZFao0NLmYPbmkej4Tzv4qQXJynuSiLHCuDHa8OAYD+Z/GgjkWL?=
 =?us-ascii?Q?btknzZdlzA+AiGW+YfCCm7FtIf6eO1QyC7HGmmZcvnbnMtCa/RxGLiM+uV8X?=
 =?us-ascii?Q?g/DktfA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f3b0a-c3c1-492e-c564-08dee363c02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 17:57:49.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6820

From: Michael Kelley <mhklkml@zohomail.com> Sent: Sunday, June 7, 2026 7:06=
 PM
>=20
> In current code, the coherent_dma_mask for VMBus devices is not set, so
> it has the default value of 0, which essentially means "invalid". Because
> drivers for VMBus devices do not use dma_alloc_*() functions, the usual
> use of the coherent mask does not occur, and no errors result.
>=20
> However, a valid coherent_dma_mask may be needed even though the drivers
> don't use dma_alloc_*() functions. In a CoCo VM, the VMBus storvsc and
> netvsc drivers must bounce buffer DMA operations through the swiotlb
> because the Hyper-V host can't DMA into encrypted guest memory. If the
> kernel is built with CONFIG_SWIOTLB_DYNAMIC and the initial swiotlb size
> is small, swiotlb code may need to grow the swiotlb in response to a DMA
> mapping request. That growth first allocates a transient pool while the
> swiotlb is expanded in the background. The transient pool memory is
> allocated from the DMA atomic pools, and the allocation code checks for
> a valid coherent_dma_mask. With current code, this check fails, then the
> DMA mapping request from the storvsc or netvsc driver fails, and finally
> an I/O error occurs.
>=20
> Fix this problem by setting coherent_dma_mask for VMBus devices at the
> same time that dma_mask is set. Being a synthetic bus, VMBus does not
> have any restrictions on coherent DMA, so the coherent mask is set to
> the full 64 bits for all VMBus devices, just like with dma_mask.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Gentle ping:  Anyone able to review this patch? There's a
Sashiko comment, but it's for an issue in an unrelated error path,
so I'm not planning to respin this patch for that comment.

Michael

> ---
> I have not provided a Fixes: tag because the scenario under which
> the error occurs is an artificial test case that I came across
> while stressing a unrelated patch set. The fix is valid for general
> goodness, but the likelihood of the problem occurring in the real
> world is extremely small. So I see little value in adding this
> patch to the stable kernel maintainers' workload. If someone wants
> to argue otherwise, I have no fundamental objection to adding the
> Fixes: tag.
>=20
>  drivers/hv/vmbus_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c9eeb2ec365d..26e8273bbddd 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2192,6 +2192,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
>  	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
>  	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +	dma_set_coherent_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>=20
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
> --
> 2.25.1
>=20

