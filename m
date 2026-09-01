Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012057.outbound.protection.outlook.com [52.103.2.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18D2D1913;
	Tue,  1 Sep 2026 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299347; cv=fail; b=tqgXM4mzlZaZKFd6ObksTzExmfuLnmdxm0Jf3x7XhigjL10hJ4GpcRc6GoSL1HkK4abHmV6a+dkHM3CigO+1k4suUFz82urcuuBsSTFXnqXVyFxWAsbijyEFXR5GYL60SpRyIxHk7yyIxwk3xI5GvvAh0NQLFfxPUBzC+XowrJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299347; c=relaxed/simple;
	bh=ye1Rf3ymkEIuqBC+7ib6mcKoA4K3+Z0onWAjFZY9AU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4PajLHT72CWESqNGvVWfF3SH6jshhCotKuiclXwmoF450z83Rerq20ZXFJDyRCVGCpn9P/3OIDigtDwsHpWK+GeE5UZK7vmxrpjzWy5yIa1AZrHZOXJqlNNnAhG+QoNveUhioAFILFrrcRePBHGbI3ij7bl3FCD8aCGPksp9t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gFLkjLmm; arc=fail smtp.client-ip=52.103.2.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gFLkjLmm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+MOydS5y6FX0W0rV3IsNDc0dVvH50JeL9+qZzjt1gU2odeVvVf5M9cxSf5tajkw+9KJlJNx62aGtTFhFAvXQVCdfHqOgkjQRp3sLgMwGnmjGoKzKHCqPOkEKfHgbI2FtMbY4yx/vMVM9+XDxsa3X1S0+9gDb4OJgJFwTMlzsbganWM0Spt0Kg4fLlxeW0vk5B9QN7PUmiuxCosC13HW41IPD7fFt1cm+DNxJr9DbPf+uodRsL7Dde2TzuFfqmNHwXlJ41CGjbhwidC8gcOh9IDUCtWrSQWFOrbj+4rGZevkJKKDaCmEC1RdUinRHs3nN6Gw91+sFmQpQUvrcGUUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2rwUGGX/YmpKU7iwXQ4hO647MIeecLmjoYdMrjHunQ=;
 b=Tv4LLY1Qwv5WxJWI9UzvAuMtEHR/gpdqDRj52IRSU0oaHuioEXIIU8/gc5dHQ4npE6EOHaQJHP++aLg0hbe6sMNdDv+uBNyNHcn77zhQNDr69Ps4r7+zeWi3n1uhUxP0da0q6NbE9Wp3tP1j8agXrweOrrCj8a5Q+ixSFhvNXs5yxE9tkMPXgTCpnmh2erqFqIIfvho7YX0cZdVqtqBBjZq6EOxxVqm4EPSNIkGhRX19n40/IrfgjwoS5csSsnhAUefRbsyoWjEMV0VIouDbt60fS9CUQGY/ChzcuUhkG3Uam+zp7ohjOYWVx/qPqekdp4KOS6p72bg9FVjQqTuoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2rwUGGX/YmpKU7iwXQ4hO647MIeecLmjoYdMrjHunQ=;
 b=gFLkjLmmfqLZ8M2JoXeJorQGbIgE3/hiTzsanUfr/3AvWHvKRktvk/zW/sgkU+JvvYxXzleGofGs7YcJk81ss8jLWPh9CZiFg8aKi3OFGQCy1wV+ZUycFvUAtkDKConHhwBbRTX03HlKxuTO4wlrwn+5ni4LqWuE7qeymX377KMS0in/LvLeiFkwadahEAtLy8w4c3TNCq5vigKuENxkU/+MzXm0kgTknXpC7dBxIM1NfoznfcZtlAj6UlOYzbtBXU1xTkMcV5t7g991H3xgr6n7+x9DkUxOX1unrYqNMbE121Z1Y+LOFZTh6B+m5aFyoQVnIMskaoDZwmIUs6Qiew==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8405.namprd02.prod.outlook.com (2603:10b6:510:107::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:49:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:49:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "13667453960@163.com" <13667453960@163.com>
Subject: RE: [PATCH] x86/hyperv: Fix stale comments after stimer message mode
 removal
Thread-Topic: [PATCH] x86/hyperv: Fix stale comments after stimer message mode
 removal
Thread-Index: AQG9kfKljQUV8g90vRudy5ZCogHbMLb5kSng
Date: Tue, 1 Sep 2026 21:49:03 +0000
Message-ID:
 <SN6PR02MB415786ED07FC3162B07BA23CD4A82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260901033201.167219-1-yijiangshan@kylinos.cn>
In-Reply-To: <20260901033201.167219-1-yijiangshan@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8405:EE_
x-ms-office365-filtering-correlation-id: 248ed40d-7a72-4d46-28c7-08df0872d6d7
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CI608IrAXhbtN5mY9QiVFe1Ey+Wrkm1x6WJjAAFf05iqaYozq4H1Xl1GuBcLf45t6tgog6DmHfQ6btw0EnpnUzs2Dsrj2cfvhT0oaCx/ZDAhF+ji8Cit/eNKqRkfFlFYWSc+XPYwZR4wIIUKYCuGrEP4gxO0sS1GXrtWIaANFNFrG8s8J4OC8oA3TSr2yzbQqA8b2VUvbcy7/XHzUz/WDUCjyhezRG7xHCrAKvhKhBwkNTbGivQrnYt6OCmrBqgzisQhIcYwCAR86licYww/P4yZAq9VfP8kJ2QL0T/GyaVttjDXL6PE2yY0UsQbsXgsY+fq2FRZ68Q5w48UwP4waE91Bqp4B9MhQtLRJEv7GzfQQXXcFaIGVmK8nrV5WkN8ceLlHZ+sQDtdEn1Y5Li3ZedVhZxfYgrcplGgsQ+y9lcKRvbFVbjgtaixYSe/IB/FTJWr/tDRkRxdsvEaMpaLlQDMcsweUqyqx+298aSUczClrLAatCvO18k6xwYuZzd5r9iZ+67m35T0+F/HUTGph2OhT90xXQeClwJ8tkaRCgiaA6B0QbDvrdGOTTmJ0QqzC0YejkCVUmFNabm3NZzl2A44+P4j/Q8Uc5DKKD/Dn/DJXv2EWfUMZ6rpytQQdmRpkmqTYMdsq2nny5hYPrUX3xadIJz0J8xbPcTSV3ae/JMgSuai8zHURHAtXLvADdXXePXG4In001NpvnwnhtDAUj3UZCMNWbjV/wPe0ppCgr8Pw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|25010399006|4140399003|8062599012|8060799015|19110799012|37011999003|15080799012|51005399006|31061999003|13091999003|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Mn39TYrYrRiATYle9c8WUZ4GyCQ2fZ17KHliTvF8VEZvOdFd0TQmuj1EB6HE?=
 =?us-ascii?Q?H0orsBm0ife8xtffgbFjxFQrwgKYlwoLsT3TZmo3hUUJLKUVf+Cp1xFg6Dw/?=
 =?us-ascii?Q?BOaLhJt/pvHu2+YxwGgLR38Qbc0uvameu5v/IxIX4XqF5TwZ1i2Hpn0v99nB?=
 =?us-ascii?Q?xEncME89qLfzF0mI5qqiZdZXUAd962I5gmTGRrwnLTWFaKgmI8+LOTxFiiI8?=
 =?us-ascii?Q?dCKXG+lyMwlCPe7lVGfMy20PvWNzXFSuV74xZTfca14iYybZdX1CDmWok72n?=
 =?us-ascii?Q?ShoT5nM88uogzvnz3HGJXTWT+0jhUy/COwKhS0rh9CbUkNJ2d4h+iZLKkDEf?=
 =?us-ascii?Q?TJpi3IWapf3OzOWVMtOVw2UKDqfYkYTVecTn+nXWJFWdiLkVbMIN9In7jnwK?=
 =?us-ascii?Q?qgEuBjTO6CQzs1Q+llZykHnYkIZtN8UY2Uuynm/Zde0IVnKu6TYyGL7g8Pr9?=
 =?us-ascii?Q?FiX7iRINYkhPbKfyUifrRccQGlc1nqHY9WYVca7muy496XB+wfZwnhmhTYO4?=
 =?us-ascii?Q?siS0jQ4afxlFi61mdHwJE4OId58U4xwgCpiG1qIj6nvxkHCDfZIpl+wC07co?=
 =?us-ascii?Q?ygyKCThzBDLDwSzOlL3nunUN6cnlVsYDrorL+/hxnGhUHxM9uKPsMKBh8mWZ?=
 =?us-ascii?Q?wE3txFReddjoVqj93DEya5IIx+ev8baE5FCWh8/m7L6waodx6MCGuxvrCUMH?=
 =?us-ascii?Q?2XxM49xiS6T0kIMG9XQKEwj1MFcp6ejBGAAVlYC66KLXBWytEQK+qNiIsXcC?=
 =?us-ascii?Q?Xu2+G4fPLcuSdhPvAilG4Kb2Trq5KGLX+oIg8TpPxmnav0L8aWYwi4TXpvxh?=
 =?us-ascii?Q?lq4A2vpSmfk+ehQumlco0U5lTd5HU79Xit2ngpzhBA/GCNZu+YjqVlLvFQYR?=
 =?us-ascii?Q?Kr7DehOoWaZzcBz0QTM7dgrzyHPB2AMGF71HacJrsFLbrrHQHO3cZ1RrH3Ny?=
 =?us-ascii?Q?iH2C1XwoVf1V7Yruyidko4gtPpwpa9N6ZbTzi2ksYse0bIgNbqL4yaD/9tQQ?=
 =?us-ascii?Q?TLJgxEy8IEFwC7MRgy/WHqkAl31FDtmN/DeW6WRD/Pqjyv8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?shgDLE+50qZkmfTnGUuKA/QhvsvxrlCsqmCt1ktvT6VKbYFxKs2+4tdF10Jd?=
 =?us-ascii?Q?MAxfZo29EMobEMFxJpIQ7smBQb/9V4sT7XMaUN0pO3+q5nBL6P6epkJhi1VW?=
 =?us-ascii?Q?+ZN/FG60KqPyc9a6ta95mshNKm0b2KCrtE/cHGupGOK058z/Sgu6G2WeeXn4?=
 =?us-ascii?Q?zE4CfxwMs3Z3jidorSWam0F3P2By4fihaS/5gWRYbJ2iHy+iR8q013aqTrE3?=
 =?us-ascii?Q?i6f+fiqenqbD2IXBS4dqmPk6ORDBQajJ45nPUZgkwyuT9iOOo9Hzy5I6txI8?=
 =?us-ascii?Q?RixVkWFU1Qh+gnXnq1yZQSclqrKB4rHP4v+B6XzQcR6jrmB5aSjw+RVAwakO?=
 =?us-ascii?Q?xVkiN9IC9UQx6VsRwU/rxNLidawwJz6qdLovfWSdyQemml9WhwF46DytReMG?=
 =?us-ascii?Q?vBkgkKBLupBu8hb9iAvDg5A/Lo7GhWyZxG9HqxVdzm8ydcySl7e+atw/iz2s?=
 =?us-ascii?Q?lOgUC5oa87mhgyCjDzRTt9QJuh8/+4togJJHp3n514/oZ7dsaIlMfLLF6fvM?=
 =?us-ascii?Q?clObotT8AmnEOCIf82SBmCBvB8VC6QtS/AItHtfdeSCKUZynYwx6F1UZrngk?=
 =?us-ascii?Q?cwkR4pwxK8Ot/GmQv2kDsBHEhIWmKFNJ2YUN5jKH8XwvYiQ5qy4Xm+L2doeC?=
 =?us-ascii?Q?YNnG9ZjpdriO5J35fO3hOJSPXnrjMq+0EZLcuGO0pNJ4MWQvTyU54JuofIDI?=
 =?us-ascii?Q?cUuJ+dnu0lnWmMFakPqrX3bfcNrtSaTuqx+samZayp9TswWwSjJSPnZGHBBc?=
 =?us-ascii?Q?vlg0wj+xtmQBLFV7tiwOeaTx215qT2zq1yjq7VhJaLRT2spkRLeqp7DhmBr1?=
 =?us-ascii?Q?mCsBQKjM9gn8OjGKbfu5BCz2oVM78Jz6iL6QIN7rmeEeJZg47AjHu3LmjDj7?=
 =?us-ascii?Q?PRTFLKwI3ptRnQvqRtiDdJ28TsTUpukGnabDmOlJt4C61yyb2+7DauO/imPA?=
 =?us-ascii?Q?02ej5Bbt8/CocW26k2GguAg0uew+Lr6tL+Xz1VMxrw5g9H6g+53HIkq3NzMY?=
 =?us-ascii?Q?lKenqSehWS8mmqwmW5rxH5IhjBWZCKvvQLGJz/mtzW7+xdnMwwmb3CASonZb?=
 =?us-ascii?Q?tqIchYvpgdx9achzoxg6iPdf1u9hx3v1KEyBJ1PI/h48kcsp6jsBg+4oUqJW?=
 =?us-ascii?Q?Z107SWtYR36+0l5ix/iPhS+zelmo7DbC78fOtk5eK81+hK0raobrKJcuZSvb?=
 =?us-ascii?Q?H838PCYEDFsiIXnFVECsrAgMGL16HuA3IE3Ci2+fSoqqRh4x54TzzEiPZw4q?=
 =?us-ascii?Q?sENMAIgPCahRy3BED2WEzYkzn0iDgDZngmcIPGzzIplF0s9PO18WBzb3hoss?=
 =?us-ascii?Q?KQyBxbnVvlQ1TqxNnn5DAF3kMbKaKO+XVmVmbKvTYWazvIHZ5lLQY6jLMHFe?=
 =?us-ascii?Q?SclNViQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ed40d-7a72-4d46-28c7-08df0872d6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 21:49:03.3055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8405

From: Jiangshan Yi <yijiangshan@kylinos.cn> Sent: Monday, August 31, 2026 8=
:32 PM
>=20
> The removal of stimer message mode in commit be0cfab740e5 ("clocksource:
> hyper-v: Remove support for stimer interrupts in message mode") left a
> few comments out of date. hv_stimer_setup_percpu_clockev() picked up two
> typos ("afters", "to allows"), and the hv_synic_suspend() comment still
> references the deleted hv_stimer_legacy_cleanup(), the legacy non-Direct
> Mode configuration, and clockevents_unbind_device(), which is no longer
> on the cleanup path.
>=20
> Update the typos and rewrite the hv_synic_suspend() comment to describe
> the current Direct Mode path: non-boot CPU stimers are cleaned up via
> the cpuhp teardown callback hv_stimer_cleanup(), and CPU0's stimer is
> left alone because it is harmless (interrupts stay disabled across the
> suspend/resume window) and is shut down later by the timekeeping code.
>=20
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  arch/x86/hyperv/hv_init.c |  4 ++--
>  drivers/hv/vmbus_drv.c    | 18 +++++++-----------
>  2 files changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0b4a1c0b0b16..690f95295ee4 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -426,7 +426,7 @@ static void __init hv_stimer_setup_percpu_clockev(voi=
d)
>  	int ret;
>=20
>  	/*
> -	 * Continue afters errors in setting up stimer clockevents
> +	 * Continue after errors in setting up stimer clockevents
>  	 * as we can run with the LAPIC timer as a fallback.
>  	 */
>  	ret =3D hv_stimer_alloc(false);
> @@ -434,7 +434,7 @@ static void __init hv_stimer_setup_percpu_clockev(voi=
d)
>  		pr_warn("stimer setup failed with error %d\n", ret);
>=20
>  	/*
> -	 * Still register the LAPIC timer to allows users
> +	 * Still register the LAPIC timer to allow users
>  	 * to switch to LAPIC timer via /sys, if they want to.
>  	 */
>  	if (old_setup_percpu_clockev)
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 5ebdbe24b5a1..c1edc3a5b673 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2923,23 +2923,19 @@ static void hv_crash_handler(struct pt_regs *regs=
)
>  static int hv_synic_suspend(void *data)
>  {
>  	/*
> -	 * When we reach here, all the non-boot CPUs have been offlined.
> -	 * If we're in a legacy configuration where stimer Direct Mode is
> -	 * not enabled, the stimers on the non-boot CPUs have been unbound
> -	 * in hv_synic_cleanup() -> hv_stimer_legacy_cleanup() ->
> -	 * hv_stimer_cleanup() -> clockevents_unbind_device().
> +	 * When we reach here, all the non-boot CPUs have been offlined,
> +	 * and their stimers have been cleaned up by the cpuhp teardown
> +	 * callback hv_stimer_cleanup().
>  	 *
>  	 * hv_synic_suspend() only runs on CPU0 with interrupts disabled.
> -	 * Here we do not call hv_stimer_legacy_cleanup() on CPU0 because:
> -	 * 1) it's unnecessary as interrupts remain disabled between
> -	 * syscore_suspend() and syscore_resume(): see create_image() and
> +	 * The stimer on CPU0 is not explicitly cleaned up here because:
> +	 * 1) it's harmless as interrupts remain disabled between
> +	 * syscore_suspend() and syscore_resume(), so the stimer cannot
> +	 * fire during this window: see create_image() and
>  	 * resume_target_kernel()
>  	 * 2) the stimer on CPU0 is automatically disabled later by
>  	 * syscore_suspend() -> timekeeping_suspend() -> tick_suspend() -> ...
>  	 * -> clockevents_shutdown() -> ... -> hv_ce_shutdown()
> -	 * 3) a warning would be triggered if we call
> -	 * clockevents_unbind_device(), which may sleep, in an
> -	 * interrupts-disabled context.
>  	 */
>=20
>  	hv_hyp_synic_disable_regs(0);
> --
> 2.25.1
>=20

Thanks for cleaning up after my changes!

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
