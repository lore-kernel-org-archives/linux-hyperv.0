Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011031.outbound.protection.outlook.com [52.103.14.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941D5237A3;
	Tue,  8 Sep 2026 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890506; cv=fail; b=rIpIZ8X0Qebs+Yeq6/q/8za5xavycGyAmMn/t1hVeb5r02hhGmp/s2aLmspmXTPcnZE0ACpI832Ze2xAgorJSxSaoMYKwNtjNT6Ix/H81HufWocSYfAK/zkLBj9jdfK2KFXNxnV8B+CLMIC3l5tjKU476k8mAZyMbATJ6n6WZI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890506; c=relaxed/simple;
	bh=LrcHlTuV5EywqaskhZ7/rVhf1ILYtnhoo+JrWi5fIC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+o2Q0m/YvBekGzhYe2D5xUTk+wqd+l1RILyy3mmwT8hEDNmn/ChAJmIgG89TV1EnJsjfMYe025MXNZYfh8vAvjEP/6uxMQ+HsZcr5Q7UDOglL3jTjDpN6fXKPdCGYzqSjEm2n9tkNYRcQ+7UlVyQozAXJs5rDSc+d4oTcnHadI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pKAFyBth; arc=fail smtp.client-ip=52.103.14.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pKAFyBth"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqTViGt7l1O2wneqXP5pInaOQDc+4x0FqIEQtDvfzuP1VcDraZrVWkRPJwfpu2sWSPaTeN0Jol8zYS1YcylCsdqCEG2I6C7baajbcEuuUdx7WI18Bz5Fp70wBndOl1xnd8SlsszCnrdo+Nac0xmyiOwhcsNTrXpQgA2AiKYdgF+g/CDFyIUopAvv8P4d/WVO4LznSFNeyTOtp0IjX4HryNV7cTWMDyX71wlenHneRMTgmWIMo5hxzoxc4PRvb4XWvs7MlxBTodOXZ32Pa/r6+nModF/TZErNof4iQPLlax2kg8+dOf1Y6B63JcWd4F2zmotjZx8IRmixJ16+Bgh7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDKuLTNUPHiVZi4RfGW2u7TUuTHoUzFU2YiSdEO3Rpc=;
 b=ow+D8UNZpuiffDhz8b2RgO30m1ubBZ2uCTOJ9Pal/Sf6emitsT0ZS1QLdB93IG5paTrgxGCpOIcWaC/lfPlw2lpJy1TQSyTPBlyxZjZuvbTvmuk6GTNcQshOZ4OBQxaG5/IiNeiyaQcTp6oOYMRzGr/Gqww5Xtb7dGebghBQO1Fw/VlQEULvMrQI5GaISgcrDWj69iNbRDb8pQbDrvsBO/UE8f1+pLCuUtxqwYSir/vh+pOc1oQx7hdoyWYwKTAm/eZr++B2dJsLGh1LVjzyS5XJrHYUXc8xL6xyfhPyriexpYFw345yMC3vqebsV49UbiiRioqN8o94MZ9jJ29zZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDKuLTNUPHiVZi4RfGW2u7TUuTHoUzFU2YiSdEO3Rpc=;
 b=pKAFyBthxeXbX02TF2zoJ+UkfngG/Wz5/TjXkzlLaPaVpb5W/DY2pM9l/N3rVtkZDNyz0HDQ7UAaxJ3rN3SWpm3gPS5wPRxMuActXlrwYleXE30dZPa2DXFYKEuggn1SjucP1XmFX9HjhBRTiEPAZLq5yZIcYte168MN8Va+zF/U0saKGa0FKwvFlrj6Fu4FGdkVvhp3YxIFO9Ugw7nD7pWcIoO5L3duIgZ5h0TLhfAtHwiblL/4ECCi+CD4Sb0vOXfmgY/Y3UWMGdo0Cs8jiDG2WcHVjfICfN9BjU5qVggPoGiBCWBYb3EaCzl9l0rKpHOMHg0gO5jpJt8r+LASqw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV2PR02MB11153.namprd02.prod.outlook.com (2603:10b6:408:34c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:01:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:01:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH V1 1/3] mshv: Rename memory deposit memory functions to
 _old
Thread-Topic: [PATCH V1 1/3] mshv: Rename memory deposit memory functions to
 _old
Thread-Index: AQHdPze4t0iLeIQ6+kakBQ4jjn7iQLbE+cGw
Date: Tue, 8 Sep 2026 18:01:42 +0000
Message-ID:
 <SN6PR02MB4157D9294688C8E5F21BDD19D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
 <20260908021340.2548924-2-mrathor@linux.microsoft.com>
In-Reply-To: <20260908021340.2548924-2-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV2PR02MB11153:EE_
x-ms-office365-filtering-correlation-id: 715858b9-0a86-4d9e-90cf-08df0dd33d3b
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/Moxhqk4VeBQXPI5azRUag83neldJ3t01zA19L78WVkTZZ1qMSz4720BILgQrMpPzlOeCC2F1UT2IlGHCp+w8WBh2P1qawb4A8ce/pxA15pEz0OB5WnodGlL8WEmHUw44SY63hzDzi+DS48iwDUHIl9StOPtEek53Vu7qcRShP84cMFqD/MkgqpAhYKXn233vGjDs/v+PEgWLAsNpeRukpTFkk1i76CLCO426FCZnsnYEKxdlcyFo5iJi+JVde50+EQb9HZeRPjjax+bj6kVhnLpmxxDqHr4R6Tof766FaF4JnWdS9ci4r/TW30oDZ4IDJTJMLLmI+HmYZOYPnlNGH38VhNsVhjQXGBXmitlYUOZWyyVq+Et7VrOjz4OKtN5KslFtOl8JcpUl3YpKV6uuebs+xqjB6ei+mastfyW3fYJUWBuybKScrR33j5x+eP9CIKsQRwlAJNfUb3N2ao+yTNO1JJsw3ae28fF0HrhVcg+IU4Kvm10qcuTTFqptDo6+FOolRJtxScJ20raEEze2hPt+KqKb284wS/ZxUDZX3H2s1dI/6pl/28fDo8vvFFCXy1SHRKhlIqk2EXO1gLWSYPYrmwWaUcSKRd2zodbuRgsDb3ubvfVt9R0IKTtEMUsLQnmkX01y0iBLAZYpWDr7TbkhfYJF5veYor0wcFJdXui2CbFmU6U4q7q5PMAk5GmizC8n+tzAr6NkVuke+ZlganBxR3b6jl2F
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|37011999003|11091999009|25010399006|19110799012|8062599012|8060799015|12121999013|15080799012|24021099003|55001999006|2604032031799003|51005399006|31061999003|13091999003|440099028|3412199025|102099032|40105399003|12091999003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V7BNNnRw+n8kr3+YX6CSLKC3NpNmhZrv1uSd13W5Ux3UM6QMmKNecw0Xe+MT?=
 =?us-ascii?Q?Fb6RFFwF6T3UzFsHDjB7nJzuNsovN0OAILCboOSHhIkIfWXBMNJZgf+u0UA8?=
 =?us-ascii?Q?lSw/qHdkksNQ6TJI2Kp22+UinJUZirmEoyXjSZClKP7p4ps6QSHExfEZ+GPN?=
 =?us-ascii?Q?ggX/lh4oJSGq0WsvGWJc7sMlQGlLhGmclRWXhtZ7L3+c7oomapwPDgWas3RP?=
 =?us-ascii?Q?nObYXyT5CZsN4NK93gGD5vSGz1U3vQM8S2NdM7LfMvIJRwIDa2Xs4/sN7i9U?=
 =?us-ascii?Q?XcaRarlb8HZtYb3xg+vaq/CIuOqzeVky7d/G+IF881z06Wyrz7dHMTYPlJbr?=
 =?us-ascii?Q?RFokRG9PIhwhsDo7gtfzxEY4Ph6Hc6M8zwvPFoBPVAAC0RDMU8PQAkd6BE8K?=
 =?us-ascii?Q?60GNj8tdlqODMSn9MMDK1gFrs50Gs14TuwCxbwRP+ZeqA+6cj15hxHheup+T?=
 =?us-ascii?Q?CudFPyA0c9myo9WHArwMh7NL3j4AKRfsOgT8ViEOAV8tpv6s1NuJSVkdUIha?=
 =?us-ascii?Q?MkeA81O8iqJ9X5pejQ6uR5dd0SuEOBHPn+PcEaFYY3NyoL2297WzlFaJ8/5g?=
 =?us-ascii?Q?b0k6YAUo1ZI99iwVe25KrQqaBaeXQXMSdaPMmwaUsZZAeHWg69DhZ8fCYhu+?=
 =?us-ascii?Q?m/MkIx1DJoyaS5zYM6vcpMuUbQIKREIewTJKnEPp7ZB5WU+KV8jk+r1CcJ50?=
 =?us-ascii?Q?mB5z1xI7rjbv4slP78M71imKf5RkC5FdHJahAYybhrBWUJfsrE5zNzpKUI7U?=
 =?us-ascii?Q?A6bBORRyffjGf2KDHmoHfth62R/gHy4JH3hzz9eHrteghhxQkR9N4npvZyZ0?=
 =?us-ascii?Q?KO/eSDnRfcri1d9yC+4u+l7aN3aqAAWPairyzfLKXE51YU22zaqKjL1ujIE7?=
 =?us-ascii?Q?TqrHA55r7DF6arYhB/TiH2Y0lLGsMrGuW4qz8HDa7LZh0vw3Kq3uPyFCocCY?=
 =?us-ascii?Q?crLgf5UTz2ZMorxJKhaHIQQyZpCoAdo2+wdX9DdEZCrGnLHX7PIGLghZKlxH?=
 =?us-ascii?Q?+fbF5u9P20U/w7lrf4nw3haXXnoUvgWInXPzJiO65ilAYvwyx1vUTDwSdu4d?=
 =?us-ascii?Q?1pF2LYt7Yoj7KNfHm20bYT92xrxGHWtiwsGLPZa7U1NsXwgc3zbrfwJ6ML+U?=
 =?us-ascii?Q?a2aiKTNLz3Lsuc+I8wp/tbkFX5tqtpg1jMEaSurSaZb84wNI32/7wO5RZNw7?=
 =?us-ascii?Q?g9QpXbHOkiDJrnmRVfgucnGofeY/5CfA/+g/yg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mXHU3+Z8TySyJLofyd2nyIA/Agx7lS4h3GZ5zzZ9yJnXT9wkOZHdXxsjN4wN?=
 =?us-ascii?Q?5RF+Y+zDtUJbQDhFTJgEg4gtK9oLs00lZoMfZzn5NEk0VjZGT2F135Juytyz?=
 =?us-ascii?Q?vYi4ecNTqWpFCXZR8+SJJZIKJq7v3oHZuhbSR6w3UIIR3mO4ojUjIxwlTF1E?=
 =?us-ascii?Q?uNexymfLMgkfvu5YoidVVVPCTtrQ2lZL43nQKQkMD2eu7CwWQdkhWcGD082U?=
 =?us-ascii?Q?tmpFUA4g/An8rlDdbcyb/yXZ8yFpT0ilX+WWNMDRClN0t0JYYn23+Pji23bi?=
 =?us-ascii?Q?PVezGbmqGrAHwNXH8aQLpFcutd2qRz98ilh4oWyitSSJiSZdjzydGKfe5yDM?=
 =?us-ascii?Q?45wJUgF3muZ4Vy6QxqBapsKpzxQW1735gzuxr8XxrVVq5R/AL0zbbBxhJvDC?=
 =?us-ascii?Q?AKKLGECQbPjZkoHl+sSd5d0rSSOUgaW0px2ammBKewbYep+8XXslQk/95VCM?=
 =?us-ascii?Q?SS8Ula9dY03l23qkuYNsZYD5Lp/6nDGhusRK+MGxpRCGrIP/ayzxl2+qwf06?=
 =?us-ascii?Q?Yf5TxjoWBR3gyJxPzRHUvs0nhRCeSzhS/srviiVbYhKLeMpwY/YNJ/vMLyyb?=
 =?us-ascii?Q?n8pOgoCoOVpWYckZSr9URag5N7OYBM3Ua8EN3RHq0Mzow+Xwm2i8Ox6/Y1td?=
 =?us-ascii?Q?Nyi/GWnuvp1evqXlanb6bZk1EbUpeLq5RFY+Pjxc81oeZKxObstsbNc5ey32?=
 =?us-ascii?Q?avYNaXgHCMkUdBcmmnfoQ0I5r1yK5AWW1W3fD9sDIr7cOJ3dhG8X0oqeQ7Vn?=
 =?us-ascii?Q?Gs7JUUVsgUJ7EHHCTwqVrmbNPwqp0g+B+puJpceviOw9F6+CRL8Uzd1vMn4d?=
 =?us-ascii?Q?lL5RxN4tzfBYSfHnDkOp9IW/yC3IVfAinO6qUYnP+V79FdcESHgp/GTPIu6d?=
 =?us-ascii?Q?q6xsqdaZ3Ti8lbX/mXUg3fwY3E9pMjM+X9p9XW3S223RvmY57JiZoW+3Zg3d?=
 =?us-ascii?Q?dk6cZg72cuGbiEa5GXnnLbeLmRB+pYy4Cx7Dbkb5gNkaGLVTY6NJ4AI61/NI?=
 =?us-ascii?Q?74Ghv2fEjsAVGG+49OYv+vBRLC/snoLRgQTq8OhVAmY2RNrE61YfTlsIuE6T?=
 =?us-ascii?Q?BRW2p8Uuqot5YV1sA7iKOffEO4L125NtFnR3Kt93fF7r2OrzUt1XmxIeEKwr?=
 =?us-ascii?Q?bJDorHMfX82iQ9xINt18C7DQepAtDAcRhF+eAX6ipMwfON4yWjETBCu/maX8?=
 =?us-ascii?Q?i19UzDwYgMEZwuHDJh9hqtlklGxddbg4WhKY08M3LWCgqkOrbIHYdyvRUN8P?=
 =?us-ascii?Q?OMnhabmLnWr2worwW7JUu82tuy5wdHWJF9jYh2YL96+XxY3nSWOPuLQSRwS/?=
 =?us-ascii?Q?nzxaRgyTw94XvLg2OF78MtrJx36pMKr/aGgLmxaKCqmuoT//S9YTzOKY2B5M?=
 =?us-ascii?Q?WFXYegk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 715858b9-0a86-4d9e-90cf-08df0dd33d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:01:42.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11153

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, September 7, 202=
6 7:14 PM
>=20
> Rename hv_call_deposit_pages() and hv_deposit_memory_node() to _old
> to make reviewing the new functions much easier.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb..57864bb5bcd8 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -13,10 +13,10 @@
>   * See struct hv_deposit_memory. The first u64 is partition ID, the rest
>   * are GPAs.
>   */
> -#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
> +#define HV_DEPOSIT_MAX_OLD (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>=20
>  /* Deposits exact number of pages. Must be called with interrupts enable=
d.  */
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +static int hv_call_deposit_pages_old(int node, u64 partition_id, u32 num=
_pages)
>  {
>  	struct page **pages, *page;
>  	int *counts;
> @@ -29,7 +29,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u=
32 num_pages)
>  	struct hv_deposit_memory *input_page;
>  	unsigned long flags;
>=20
> -	if (num_pages > HV_DEPOSIT_MAX)
> +	if (num_pages > HV_DEPOSIT_MAX_OLD)
>  		return -E2BIG;
>  	if (!num_pages)
>  		return 0;
> @@ -40,7 +40,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u=
32 num_pages)
>  		return -ENOMEM;
>  	pages =3D page_address(page);
>=20
> -	counts =3D kzalloc_objs(int, HV_DEPOSIT_MAX);
> +	counts =3D kzalloc_objs(int, HV_DEPOSIT_MAX_OLD);
>  	if (!counts) {
>  		free_page((unsigned long)pages);
>  		return -ENOMEM;
> @@ -108,10 +108,14 @@ int hv_call_deposit_pages(int node, u64 partition_i=
d, u32 num_pages)
>  	kfree(counts);
>  	return ret;
>  }
> +
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +{
> +	return hv_call_deposit_pages_old(node, partition_id, num_pages);
> +}
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>=20
> -int hv_deposit_memory_node(int node, u64 partition_id,
> -			   u64 hv_status)
> +static int __maybe_unused hv_deposit_memory_node_old(int node, u64 parti=
tion_id, u64 hv_status)

I'm not clear on why there is "__maybe_unused" here. If CONFIG_MSHV_ROOT
isn't defined, this whole file isn't built.

But it doesn't really matter since Patch 3 of the series deletes the code a=
nyway.

>  {
>  	u32 num_pages =3D 1;
>=20
> @@ -137,7 +141,12 @@ int hv_deposit_memory_node(int node, u64 partition_i=
d,
>  		hv_status_err(hv_status, "Unexpected!\n");
>  		return -ENOMEM;
>  	}
> -	return hv_call_deposit_pages(node, partition_id, num_pages);
> +	return hv_call_deposit_pages_old(node, partition_id, num_pages);
> +}
> +
> +int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
> +{
> +	return hv_deposit_memory_node_old(node, partition_id, hv_status);
>  }
>  EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
>=20
> --
> 2.51.2.vfs.0.1
>=20

The "__maybe_unused" notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

